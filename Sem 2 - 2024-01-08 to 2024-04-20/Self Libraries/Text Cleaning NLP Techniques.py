# Natural Language Toolkit.
import nltk

# Tokenizer.
from nltk.tokenize import word_tokenize

# Stop-Words.
from nltk.corpus import stopwords

# Stem.
from nltk.stem import PorterStemmer

# Regular Expression
import re

def tokenize_words(text: str) -> list:
    return nltk.word_tokenize(''.join(t for t in text if t.isalnum() or t == ' '))

def remove_stopwords_addon(words: list, stopword_addon: list = []) -> list:
    return ' '.join([word.lower() for word in words if word.lower() not in set(stopwords.words('English') + stopword_addon)])

def stemmatize(text: str) -> str:
    return PorterStemmer().stem(text)

def merge_tokens(text: str) -> list:
    separator = '-' * 20
    tokens = re.sub(pattern = r'\b([A-Z]\w+)\s([A-Z]\w+)\b', repl = r'\1{}\2'.format(separator), string = text).split()
    return [word.replace(separator, ' ') for word in tokens]

def literal_strings(string: str) -> list:
    return [word for word, grammar in nltk.pos_tag(tokenize_words(stemmatize(remove_stopwords_addon(tokenize_words(string))))) if grammar == 'NN']
