import graphene
from graphene_django.types import DjangoObjectType
from app.models import Category, User


class CategoryType(DjangoObjectType):
    class Meta:
        model = Category


class UserType(DjangoObjectType):
    class Meta:
        model = User


class Query(object):
    all_categories = graphene.List(CategoryType)
    all_users = graphene.List(UserType)

    def resolve_all_categories(self, info, **kwargs):
        return Category.objects.all()

    def resolve_all_users(self, info, **kwargs):
        # We can easily optimize query count in the resolve method
        return User.objects.select_related('category').all()