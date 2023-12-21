Return-Path: <bpf+bounces-18550-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 775B281BD99
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 18:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F3D8288DDF
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 17:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663E4634E4;
	Thu, 21 Dec 2023 17:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOoDUE5P"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F202362811
	for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 17:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50e67f70f34so94366e87.0
        for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 09:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703181087; x=1703785887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWurB7w0TSY5mVS5ATkWE793jcbo8OU00Iep2/kZrvk=;
        b=YOoDUE5PLWFp71nstN+oq2M094aAx84ajgtbK260M3wcyqXUXdzuy5dRcIva9oN4lZ
         V3okm3gXNK7Tkt4/h3PfR0F1IHkEUxILlwkEldKWWHZRJc0ROaEVoDBgrv3F+QbA7vKP
         iZYpabMlFx+RKYLVDImCGji3jguh0T03sW0Y6XPV4lnjL/x61FQ3z1+cXOwabFMK4J3U
         ZnipfUcQdhWjLF3GjC33t6N+GAgyryW+sDqppfq24xGJwHqwlKy1EvaYEcAxrLPK33O7
         RYufCvfccVjD35tZLJ2s1vJeQbRr+0lTgYfslkHvM98xlN5m78QqOxt9GuljsHCukgZS
         2o6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703181087; x=1703785887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bWurB7w0TSY5mVS5ATkWE793jcbo8OU00Iep2/kZrvk=;
        b=Diu+P+ELTElnTcTQz7r9+UyHjWzQqsdJF7nqujQQPdyKB81m7gJcIzL+j7yXOFFYKj
         RFE/Imf4Nors9W8r57XhtzGXqeAb7uM8rrF4pUjaXKSENU70hZZFSY5Zo3nMdAGUSCp3
         +JFu5n2d+x1dfDjLSEvRk+Nw0Rbn4Bl4AhOUMgE3D2GShnLxZ3rhPU3c65Tq6pwP3yQJ
         5Z3oR9CFfSU9vzIlpAC+jI07JjkfyOh50C1822s/YvR9yLpzxHHScpps+pgQYvQyRTc2
         rQo819xzWXn3Z3jjSe+nsFV++ltzSeNmgQvyim/jHafD+yNZYuLO/zoOW9GnPFTMwnrN
         7xxg==
X-Gm-Message-State: AOJu0YyHeB9ohtsmzHTlEC57OWKtnWIRLdsUPgs1qE7IFrTuYLPsqU+q
	8bBvkNkwvNp0QEdMkJ1IDFLO+9pVHR1LTJiYvS8=
X-Google-Smtp-Source: AGHT+IElNhOJ+WbAxzcaU4qMnPCkFrInRBbdL565PY8Vm6SJL73H7LJaSpBWuDqXOSvxf2Ia4BNTiMJq8NIWvnYK1o4=
X-Received: by 2002:a05:6512:108a:b0:50e:410d:8abc with SMTP id
 j10-20020a056512108a00b0050e410d8abcmr3575928lfg.137.1703181086305; Thu, 21
 Dec 2023 09:51:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220170604.183380-1-andreimatei1@gmail.com>
 <20231220170604.183380-2-andreimatei1@gmail.com> <CAEf4BzajeEa970Jm6MQCOiT-7++o_dA+KcoE_pQL-yGBZhtKUw@mail.gmail.com>
In-Reply-To: <CAEf4BzajeEa970Jm6MQCOiT-7++o_dA+KcoE_pQL-yGBZhtKUw@mail.gmail.com>
From: Andrei Matei <andreimatei1@gmail.com>
Date: Thu, 21 Dec 2023 12:51:14 -0500
Message-ID: <CABWLseugK9zg9nawVG=hQzEQv=fLKzPjZPJC3nCoOw2KKn_xaQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Simplify checking size of helper accesses
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, eddyz87@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 11:30=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Dec 20, 2023 at 9:06=E2=80=AFAM Andrei Matei <andreimatei1@gmail.=
com> wrote:
> >
> > This patch simplifies the verification of size arguments associated to
> > pointer arguments to helpers and kfuncs. Many helpers take a pointer
> > argument followed by the size of the memory access performed to be
> > performed through that pointer. Before this patch, the handling of the
> > size argument in check_mem_size_reg() was confusing and wasteful: if th=
e
> > size register's lower bound was 0, then the verification was done twice=
:
> > once considering the size of the access to be the lower-bound of the
> > respective argument, and once considering the upper bound (even if the
> > two are the same). The upper bound checking is a super-set of the
> > lower-bound checking(*), except: the only point of the lower-bound chec=
k
> > is to handle the case where zero-sized-accesses are explicitly not
> > allowed and the lower-bound is zero. This static condition is now
> > checked explicitly, replacing a much more complex, expensive and
> > confusing verification call to check_helper_mem_access().
> >
> > Now that check_mem_size_reg() deals directly with the zero_size_allowed
> > checking, the single remaining call to check_helper_mem_access() can
> > pass a static value for the zero_size_allowed arg, instead of
> > propagating a dynamic one. I think this is an improvement, as tracking
> > the wide propagation of zero_sized_allowed is already complicated.
> >
> > Error messages change in this patch. Before, messages about illegal
> > zero-size accesses depended on the type of the pointer and on other
> > conditions, and sometimes the message was plain wrong: in some tests
> > that changed you'll see that the old message was something like "R1 min
> > value is outside of the allowed memory range", where R1 is the pointer
> > register; the error was wrongly claiming that the pointer was bad
> > instead of the size being bad. Other times the information that the siz=
e
> > came for a register with a possible range of values was wrong, and the
> > error presented the size as a fixed zero. Now the errors refer to the
> > right register. However, the old error messages did contain useful
> > information about the pointer register which is now lost. The next patc=
h
> > will bring that information back.
> >
> > (*) Besides standing to reason that the checks for a bigger size access
> > are a super-set of the checks for a smaller size access, I have also
> > mechanically verified this by reading the code for all types of
> > pointers. I could convince myself that it's true for all but
> > PTR_TO_BTF_ID (check_ptr_to_btf_access). There, simply looking
> > line-by-line does not immediately prove what we want. If anyone has any
> > qualms, let me know.
> >
> > Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
> > ---
> >  kernel/bpf/verifier.c                         | 28 ++++++++----
> >  .../bpf/progs/verifier_helper_value_access.c  | 45 +++++++++++++++++--
> >  .../selftests/bpf/progs/verifier_raw_stack.c  |  2 +-
> >  3 files changed, 61 insertions(+), 14 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 1863826a4ac3..4409b8f2b0f3 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -7267,6 +7267,7 @@ static int check_mem_size_reg(struct bpf_verifier=
_env *env,
> >                               bool zero_size_allowed,
> >                               struct bpf_call_arg_meta *meta)
> >  {
> > +       const bool size_is_const =3D tnum_is_const(reg->var_off);
> >         int err;
> >
> >         /* This is used to refine r0 return value bounds for helpers
> > @@ -7282,7 +7283,7 @@ static int check_mem_size_reg(struct bpf_verifier=
_env *env,
> >         /* The register is SCALAR_VALUE; the access check
> >          * happens using its boundaries.
> >          */
> > -       if (!tnum_is_const(reg->var_off))
> > +       if (!size_is_const)
> >                 /* For unprivileged variable accesses, disable raw
> >                  * mode so that the program is required to
> >                  * initialize all the memory that the helper could
> > @@ -7296,12 +7297,9 @@ static int check_mem_size_reg(struct bpf_verifie=
r_env *env,
> >                 return -EACCES;
> >         }
> >
> > -       if (reg->umin_value =3D=3D 0) {
> > -               err =3D check_helper_mem_access(env, regno - 1, 0,
> > -                                             zero_size_allowed,
> > -                                             meta);
> > -               if (err)
> > -                       return err;
> > +       if (reg->umin_value =3D=3D 0 && !zero_size_allowed) {
> > +               verbose(env, "R%d invalid zero-sized read\n", regno);
> > +               return -EACCES;
> >         }
> >
>
> I feel like this simplification is the only one necessary. Code change
> below (for umax) seems unnecessary.
>
> >         if (reg->umax_value >=3D BPF_MAX_VAR_SIZ) {
> > @@ -7309,9 +7307,21 @@ static int check_mem_size_reg(struct bpf_verifie=
r_env *env,
> >                         regno);
> >                 return -EACCES;
> >         }
> > +       /* If !zero_size_allowed, we already checked that umin_value > =
0, so
> > +        * umax_value should also be > 0.
> > +        */
> > +       if (reg->umax_value =3D=3D 0 && !zero_size_allowed) {
> > +               verbose(env, "verifier bug: !zero_size_allowed should h=
ave been handled already\n");
> > +               return -EFAULT;
> > +       }
>
> This check seems unnecessary. If we have a bug and umax < umin, then
> a) we should detect it earlier in reg bounds sanity check and b)
> check_helper_mem_access would still reject umax=3D=3D0 case if
> !zero_size_allowed. On the other hand, this check does nothing if
> zero_size_allowed=3D=3Dtrue.
>
> So it's at best partially useful, I'd just drop it. If you do drop it,
> please add my ack to the next revision, thanks. (I might disappear due
> to holidays, so might be slow to review/reply going forward).
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>
> >         err =3D check_helper_mem_access(env, regno - 1,
> > -                                     reg->umax_value,
> > -                                     zero_size_allowed, meta);
> > +                               reg->umax_value,
> > +                               /* zero_size_allowed: we asserted above=
 that umax_value is not
> > +                                * zero if !zero_size_allowed, so we do=
n't need any further
> > +                                * checks.
> > +                                */
> > +                               true,
> > +                               meta);
>
> and here if we leave zero_size_allowed, what's the worst that can
> happen? I'd keep the original call as is.

Nothing bad will happen. I can revert these changes if you want, no problem=
.
But:
The point of this code change was not to have any effects at run-time, but
rather to simplify the code conceptually. The way I see it, terminating the
dynamic aspect of zero_size_allowed here is a good thing: with this change,=
 all
callers now pass a static constant as zero_size_allowed to
check_helper_mem_access(), so tracking the possible values of the argument
becomes much easier. I generally dislike the fact that a lot of functions h=
ave
this zero_size_allowed argument; I've tried to figure out some alternative
where zero-sized reads are summarily rejected somewhere high-up so that
functions like check_packet_access, check_map_access, check_mem_region_acce=
ss,
check_buffer_access, check_stack_range_initialized do not need this argumen=
t
any more. But so far I came up empty handed and gave up for now, given that
these functions are called from multiple places. Still, I see
check_mem_size_reg() passing a static `true` as a step in the right directi=
on
for future refactorings.
Similarly, the point of the assertion I've added above was not that it's
"necessary"; the point was for it to act like commentary assuring the reade=
r
that the value of zero_size_allowed doesn't matter any more.



Since we're talking, let me ask you this: would you agree that, if the acce=
ss
size is zero, the pointer value does not need to be checked *at all*? Meani=
ng,
if zero_size_allowed is true and the size is zero, the verifier can allow e=
ven
invalid pointers (or registers that are not a pointer at all) to be used?
Because if the answer is yes, that might help getting a cleaner code struct=
ure
in place -- because it would mean that verifying zero-sized accesses can be
terminated early both for zero_size_allowed =3D true/false.

>
> >         if (!err)
> >                 err =3D mark_chain_precision(env, regno);
> >         return err;
> > diff --git a/tools/testing/selftests/bpf/progs/verifier_helper_value_ac=
cess.c b/tools/testing/selftests/bpf/progs/verifier_helper_value_access.c
> > index 692216c0ad3d..137cce939711 100644
> > --- a/tools/testing/selftests/bpf/progs/verifier_helper_value_access.c
> > +++ b/tools/testing/selftests/bpf/progs/verifier_helper_value_access.c
> > @@ -89,9 +89,14 @@ l0_%=3D:       exit;                                =
           \
> >         : __clobber_all);
> >  }
> >
> > +/* Call a function taking a pointer and a size which doesn't allow the=
 size to
> > + * be zero (i.e. bpf_trace_printk() declares the second argument to be
> > + * ARG_CONST_SIZE, not ARG_CONST_SIZE_OR_ZERO). We attempt to pass zer=
o for the
> > + * size and expect to fail.
> > + */
> >  SEC("tracepoint")
> >  __description("helper access to map: empty range")
> > -__failure __msg("invalid access to map value, value_size=3D48 off=3D0 =
size=3D0")
> > +__failure __msg("R2 invalid zero-sized read")
> >  __naked void access_to_map_empty_range(void)
> >  {
> >         asm volatile ("                                 \
> > @@ -113,6 +118,38 @@ l0_%=3D:     exit;                                =
           \
> >         : __clobber_all);
> >  }
> >
> > +/* Like the test above, but this time the size register is not known t=
o be zero;
> > + * its lower-bound is zero though, which is still unacceptible.
>
> typo: unacceptable
>
> we normally add new tests in a separate patch. Fixing existing tests
> to make them pass together with kernel change is the only case were we
> mix selftests changes and kernel changes.
>
> > + */
> > +SEC("tracepoint")
> > +__description("helper access to map: possibly-empty range")
> > +__failure __msg("R2 invalid zero-sized read")
> > +__naked void access_to_map_possibly_empty_range(void)
> > +{
> > +       asm volatile ("                                         \
> > +       r2 =3D r10;                                               \
> > +       r2 +=3D -8;                                               \
> > +       r1 =3D 0;                                                 \
> > +       *(u64*)(r2 + 0) =3D r1;                                   \
> > +       r1 =3D %[map_hash_48b] ll;                                \
> > +       call %[bpf_map_lookup_elem];                            \
> > +       if r0 =3D=3D 0 goto l0_%=3D;                                  \
> > +       r1 =3D r0;                                                \
> > +       /* Read an unknown value */                             \
> > +       r7 =3D *(u64*)(r0 + 0);                                   \
> > +       /* Make it small and positive, to avoid other errors */ \
> > +       r7 &=3D 4;                                                \
> > +       r2 =3D 0;                                                 \
> > +       r2 +=3D r7;                                               \
> > +       call %[bpf_trace_printk];                               \
> > +l0_%=3D: exit;                                               \
> > +"      :
> > +       : __imm(bpf_map_lookup_elem),
> > +         __imm(bpf_trace_printk),
> > +         __imm_addr(map_hash_48b)
> > +       : __clobber_all);
> > +}
> > +
> >  SEC("tracepoint")
> >  __description("helper access to map: out-of-bound range")
> >  __failure __msg("invalid access to map value, value_size=3D48 off=3D0 =
size=3D56")
> > @@ -221,7 +258,7 @@ l0_%=3D:      exit;                                =
           \
> >
> >  SEC("tracepoint")
> >  __description("helper access to adjusted map (via const imm): empty ra=
nge")
> > -__failure __msg("invalid access to map value, value_size=3D48 off=3D4 =
size=3D0")
> > +__failure __msg("R2 invalid zero-sized read")
> >  __naked void via_const_imm_empty_range(void)
> >  {
> >         asm volatile ("                                 \
> > @@ -386,7 +423,7 @@ l0_%=3D:      exit;                                =
           \
> >
> >  SEC("tracepoint")
> >  __description("helper access to adjusted map (via const reg): empty ra=
nge")
> > -__failure __msg("R1 min value is outside of the allowed memory range")
> > +__failure __msg("R2 invalid zero-sized read")
> >  __naked void via_const_reg_empty_range(void)
> >  {
> >         asm volatile ("                                 \
> > @@ -556,7 +593,7 @@ l0_%=3D:      exit;                                =
           \
> >
> >  SEC("tracepoint")
> >  __description("helper access to adjusted map (via variable): empty ran=
ge")
> > -__failure __msg("R1 min value is outside of the allowed memory range")
> > +__failure __msg("R2 invalid zero-sized read")
> >  __naked void map_via_variable_empty_range(void)
> >  {
> >         asm volatile ("                                 \
> > diff --git a/tools/testing/selftests/bpf/progs/verifier_raw_stack.c b/t=
ools/testing/selftests/bpf/progs/verifier_raw_stack.c
> > index f67390224a9c..3dbda85e2997 100644
> > --- a/tools/testing/selftests/bpf/progs/verifier_raw_stack.c
> > +++ b/tools/testing/selftests/bpf/progs/verifier_raw_stack.c
> > @@ -64,7 +64,7 @@ __naked void load_bytes_negative_len_2(void)
> >
> >  SEC("tc")
> >  __description("raw_stack: skb_load_bytes, zero len")
> > -__failure __msg("invalid zero-sized read")
> > +__failure __msg("R4 invalid zero-sized read")
> >  __naked void skb_load_bytes_zero_len(void)
> >  {
> >         asm volatile ("                                 \
> > --
> > 2.40.1
> >

