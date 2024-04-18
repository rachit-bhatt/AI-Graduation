class ClassificationModel:
    
    def __init__(self, models : dict[str, object]) -> None:
        
        # List of Models.
        self.models = models

        # Training Models.
        self.trained_instances = dict()

        # Predicted Data.
        self.train_predictions = dict()
        self.test_predictions = dict()
        
        # Accuracy.
        self.train_accuracies = dict()
        self.test_accuracies = dict()
        
        # Classification Report.
        self.train_classification_reports = dict()
        self.test_classification_reports = dict()
        
    #region Data Splitter
        
    def set_split_data(self,
                       train_test_data : list[DataFrame | Series,
                                              DataFrame | Series,
                                              DataFrame | Series,
                                              DataFrame | Series]) -> None:

        self.X_train, self.X_test, self.y_train, self.y_test = train_test_data
        
    #endregion
        
    #region Model Training
        
    def model_training(self) -> dict[str, object]:
        
        for model_name, model_instance in self.models.items():
    
            model_instance.fit(X = self.X_train,
                               y = self.y_train)
            
            self.trained_instances[model_name] = model_instance
            
        return self.trained_instances
    
    #endregion
    
    #region Model Prediction
    
    def predict_train_data(self) -> dict[str, object]:
        
        for model_name, model_instance in self.trained_instances.items():
            self.train_predictions[model_name] = model_instance.predict(X = self.X_train)

        return self.train_predictions
    
    def predict_test_data(self) -> dict[str, object]:
        
        for model_name, model_instance in self.trained_instances.items():
            self.test_predictions[model_name] = model_instance.predict(X = self.X_test)

        return self.test_predictions
    
    #endregion
    
    #region Metrics
    
    #region Accuracy
    
    def get_accuracy(self, true_label : list[object], predictions : list[object]) -> str:
        
        return accuracy_score(y_true = true_label,
                              y_pred = predictions)
    
    def get_train_accuracies(self) -> str:
        
        for model_name, predicted_values in self.train_predictions.items():
            self.train_accuracies[model_name] = self.get_accuracy(true_label = self.y_train, predictions = predicted_values)
        
        return self.train_accuracies
    
    def get_test_accuracies(self) -> str:
        
        for model_name, predicted_values in self.test_predictions.items():
            self.test_accuracies[model_name] = self.get_accuracy(true_label = self.y_test, predictions = predicted_values)
        
        return self.test_accuracies
    
    #endregion
    
    #region Classification Report
    
    def get_classification_report(self, true_label : list[object], predictions : list[object]) -> str:
        
        return classification_report(y_true = true_label,
                                     y_pred = predictions,
                                     zero_division = 0,
                                     output_dict = True)
    
    def get_train_classification_reports(self) -> str:
        
        for model_name, predicted_values in self.train_predictions.items():
            self.train_classification_reports[model_name] = self.get_classification_report(true_label = self.y_train, predictions = predicted_values)
        
        return self.train_classification_reports
    
    def get_test_classification_reports(self) -> str:

        for model_name, predicted_values in self.test_predictions.items():
            self.test_classification_reports[model_name] = self.get_classification_report(true_label = self.y_test, predictions = predicted_values)
        
        return self.test_classification_reports
    
    #endregion
        
    #endregion
    
    #region Visualization
    
    #region Confusion Matrix
    
    def render_confusion_matrix(self, true_label : list[object], predictions : list[object], model_name : str) -> None:
        
        plot_confusion_matrix(y_true = true_label,
                              y_pred = predictions,
                              normalize = True,
                              cmap = 'plasma',
                              title = 'Confusion Matrix of {} Algorithm'.format(model_name),
                              figsize = (25.6, 16),
                              text_fontsize = 26,
                              title_fontsize = 35)
        
    def plot_train_confusion_matrices(self) -> None:
        
        for model_name, predicted_values in self.train_predictions.items():
            self.render_confusion_matrix(true_label = self.y_train, predictions = predicted_values, model_name = model_name)
        
    def plot_test_confusion_matrices(self) -> None:
        
        for model_name, predicted_values in self.test_predictions.items():
            self.render_confusion_matrix(true_label = self.y_test, predictions = predicted_values, model_name = model_name)
        
    #endregion
    
    def plot_model_comparison(self, accuracies : dict[str, any], title : str = str()) -> None:
        
        data = DataFrame({
            'Model' : accuracies.keys(),
            'Accuracy' : accuracies.values()
        })

        bar(data_frame = data,
            x = 'Model',
            y = 'Accuracy',
            text = 'Accuracy',
            range_y = ['50%', '100%'],
            title = 'Algorithm Comparison on {} data'.format(title)).show()
    
    #endregion
    
    #region Converters
    
    def to_accuracy(accuracy : float) -> str:
        
        return str(round(accuracy, ndigits = 2) * 100) + '%'
    
    def to_accuracies(collection : dict[str, float]) -> dict[str, str]:
        
        accuracies = dict()
        
        for item, accuracy in collection.items():
        
            accuracies[item] = ClassificationModel.to_accuracy(accuracy = accuracy)
            
        return accuracies

    #endregion
