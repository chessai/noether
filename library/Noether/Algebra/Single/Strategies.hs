module Noether.Algebra.Single.Strategies where

import           Noether.Lemmata.Prelude
import           Noether.Lemmata.TypeFu

import           Noether.Algebra.Tags

import           Noether.Algebra.Single.Cancellative
import           Noether.Algebra.Single.Commutative
import           Noether.Algebra.Single.Neutral

import           Noether.Algebra.Single.Magma
import           Noether.Algebra.Single.Monoid
import           Noether.Algebra.Single.Semigroup

import           Noether.Algebra.Single.AbelianGroup
import           Noether.Algebra.Single.Group

type Semigroup op a = (SemigroupC op a, Magma op a)

type Monoid op a = (MonoidC op a, Semigroup op a)

type Group op a = (GroupC op a, Monoid op a, Cancellative op a)

type AbelianGroup op a = (AbelianGroupC op a, Group op a, Commutative op a)

-- Lifting strategies

type DeriveSemigroup_Magma t a = Semigroup_Magma (MagmaS t a)

type DeriveMonoid_Semigroup_Neutral t a =
  Monoid_Semigroup_Neutral (SemigroupS t a) (NeutralS t a)

type DeriveGroup_Monoid_Cancellative t a =
  Group_Monoid_Cancellative (MonoidS t a) (CancellativeS t a)

type DeriveAbelianGroup_Commutative_Group t a =
  AbelianGroup_Commutative_Group (CommutativeS t a) (GroupS t a)

type DeriveAbelianGroup_Commutative_Monoid_Cancellative t a =
  AbelianGroup_Commutative_Group
    (CommutativeS t a)
    (DeriveGroup_Monoid_Cancellative t a)

-- Instances

type instance MagmaS (_ :: BinaryBoolean) Bool = MagmaPrim
type instance NeutralS (_ :: BinaryBoolean) Bool = NeutralPrim
type instance CommutativeS (_ :: BinaryBoolean) Bool = CommutativeNum
type instance SemigroupS (op :: BinaryBoolean) Bool =
     DeriveSemigroup_Magma op Bool

-- Double

type instance MagmaS (_ :: BinaryNumeric) Double = MagmaNum
type instance NeutralS (_ :: BinaryNumeric) Double = NeutralNum
type instance SemigroupS (op :: BinaryNumeric) Double =
     DeriveSemigroup_Magma op Double

type instance MonoidS (op :: BinaryNumeric) Double =
     DeriveMonoid_Semigroup_Neutral op Double

type instance CancellativeS Add Double = CancellativeNum
type instance CancellativeS Mul Double = CancellativeFractional

type instance GroupS (op :: BinaryNumeric) Double =
     DeriveGroup_Monoid_Cancellative op Double

type instance CommutativeS (_ :: BinaryNumeric) Double = CommutativeNum

type instance AbelianGroupS (op :: BinaryNumeric) Double =
     DeriveAbelianGroup_Commutative_Group op Double
