Return-Path: <bpf+bounces-35561-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DFF93B832
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 22:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B672FB23D6A
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 20:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C141B1386DA;
	Wed, 24 Jul 2024 20:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUkUqZG+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58B11369A6;
	Wed, 24 Jul 2024 20:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721853877; cv=none; b=X0Lw6pU7iLZtVdgsChHvgUFHH47S4Q7Y1QE8jo90CgjtgLrlB2A3WSPWu1qYNjcaoHPYYkTEmbXTlH6h+0v2BlLL1+sxa4At8kyTTIfanNncYB7B1I7wUO68wPLu7UbmOWmLZLhKx+KKRaBdsVdTZEkm4ks4GQh/VSC78F9rjHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721853877; c=relaxed/simple;
	bh=aqLSDTeIVOn7A3DgnKv/dOOcnFOd9vlENye8M1qxMSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UDM4sSj4W4RIA7/ICRcbLl+mJJdpo7w0bDC9lVUEeJgzAdklmYsCE8WulLYtKqnBucjyTHzAy+ztmJO0O2lywAOw38ueOEo0LTJ10/WrGtSdk3R9hmgBlJvJ/RrASLPefxbMcVlmwLX2LXq2cSSkyaQkZKZAHV0SDowEPSVg0hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fUkUqZG+; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e03a17a50a9so156213276.1;
        Wed, 24 Jul 2024 13:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721853874; x=1722458674; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FuNNxC5HgFnQcvP+8pSB67hgEingAAzG7UF9sEosR8c=;
        b=fUkUqZG+3ODQqpxUNgiZcdrqxd3kY8sb8mY4m3rgeNYDNzSakQBGR8PPvGHfWmZJjK
         NAO/Hq7a0U/J8Qm+G4Z0Y1jTEn/j639xs7DHJ1/zBUZMsmlldmgsxCFDwVsc4MOkCcyS
         l2Z+KobHzoVwYepwcWIfuwiEUoHnYwNxvDTHLJ6d2om+Y8u9y/r6odSj2LVqDv/BxUOc
         6t7QdEnKCvWAAXiqQhWRDbbJmMkSGvFnE7BYn0K6F0zEHtKQRaJPYDfKe4DWSrcFe998
         psmdi4MPi6s432DByLQlTRdnQdBAzqXXifmMzD0ZOSSljFyE1gNSRfvaBhBnBv7YJ2Lt
         rwlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721853874; x=1722458674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FuNNxC5HgFnQcvP+8pSB67hgEingAAzG7UF9sEosR8c=;
        b=kewgOpgsSlt61VYy6YLsoxIFnZ6sp1B/f56SJzUXMvP6AjCcqnOBQsvbbwrKwFjM0b
         Myed+tOZYGlytVEin2IGSsiOO5G3P9VQa6C5l4zP47B67p0CWXwJEd4dCOiDnHn+QTnx
         g1U/GF5wUDvmw9g39w5mb881tQMkxox3AAfid9cYat+GudW5rg6uqEISNsyNvQL8ciAb
         0KGGmZgoHPnRheEDg4mF1ZT3ie+GCR+LNQQQR2zWEpbbJfU6lyGJ3nCekrRp842QKiLp
         dFlBb0cJVCXIq+jKbKfZ79wQP64gtCT5MhazHH7ixlKUNbGtvhR1rrPm0QADVpJ9LD7m
         niJQ==
X-Forwarded-Encrypted: i=1; AJvYcCV14wU0NOO8erH5oF/EnupYUgX/vBzSV5ho7cY2B0gkp9L49lvJfJulUnlsorzRbSTPApooFlvt9RDeYPAqwnfaroNx
X-Gm-Message-State: AOJu0YwyXn5NBiH2dw/ZyPhAR6bUSpT5yjPXH0+DLkepy9j+sGzw93tl
	GF9hsgK5vqvLocDtHi4+RPFaQ/Ivr99jP4pLm8t6KhIYf1FBHGPTF0uZ73oqJ4hKF76qfCrgpDl
	gpDHiK3dJyOhgILhO6BdPEYzCF4I=
X-Google-Smtp-Source: AGHT+IFx2JTZ1GFd7mqZIsb/rLY3sskdSUuSBLUGr/Rla260PZosLUSTWpjrxGsQezbtN9zaHzKS8zpIrnYxnkF3Hac=
X-Received: by 2002:a05:6902:10c3:b0:e03:6023:ef75 with SMTP id
 3f1490d57ef6-e0b2317c11amr783503276.38.1721853874528; Wed, 24 Jul 2024
 13:44:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240714175130.4051012-1-amery.hung@bytedance.com>
 <20240714175130.4051012-4-amery.hung@bytedance.com> <5b527381-ef28-470e-954d-45ce27e8d9d9@gmail.com>
In-Reply-To: <5b527381-ef28-470e-954d-45ce27e8d9d9@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 24 Jul 2024 13:44:23 -0700
Message-ID: <CAMB2axOR-9_h2wCiibRD0bwoCntZi7h_g79E1naRLFOurWscTg@mail.gmail.com>
Subject: Re: [RFC PATCH v9 03/11] bpf: Allow struct_ops prog to return
 referenced kptr
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, yangpeihao@sjtu.edu.cn, 
	daniel@iogearbox.net, andrii@kernel.org, alexei.starovoitov@gmail.com, 
	martin.lau@kernel.org, toke@redhat.com, jhs@mojatatu.com, jiri@resnulli.us, 
	sdf@google.com, xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 10:36=E2=80=AFPM Kui-Feng Lee <sinquersw@gmail.com>=
 wrote:
>
>
>
> On 7/14/24 10:51, Amery Hung wrote:
> > Allow a struct_ops program to return a referenced kptr if the struct_op=
s
> > operator has pointer to struct as the return type. To make sure the
> > returned pointer continues to be valid in the kernel, several
> > constraints are required:
> >
> > 1) The type of the pointer must matches the return type
> > 2) The pointer originally comes from the kernel (not locally allocated)
> > 3) The pointer is in its unmodified form
> >
> > In addition, since the first user, Qdisc_ops::dequeue, allows a NULL
> > pointer to be returned when there is no skb to be dequeued, we will all=
ow
> > a scalar value with value equals to NULL to be returned.
> >
> > In the future when there is a struct_ops user that always expects a val=
id
> > pointer to be returned from an operator, we may extend tagging to the
> > return value. We can tell the verifier to only allow NULL pointer retur=
n
> > if the return value is tagged with MAY_BE_NULL.
> >
> > The check is split into two parts since check_reference_leak() happens
> > before check_return_code(). We first allow a reference object to leak
> > through return if it is in the return register and the type matches the
> > return type. Then, we check whether the pointer to-be-returned is valid=
 in
> > check_return_code().
> >
> > Signed-off-by: Amery Hung <amery.hung@bytedance.com>
> > ---
> >   kernel/bpf/verifier.c | 50 +++++++++++++++++++++++++++++++++++++++---=
-
> >   1 file changed, 46 insertions(+), 4 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index f614ab283c37..e7f356098902 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -10188,16 +10188,36 @@ record_func_key(struct bpf_verifier_env *env,=
 struct bpf_call_arg_meta *meta,
> >
> >   static int check_reference_leak(struct bpf_verifier_env *env, bool ex=
ception_exit)
> >   {
> > +     enum bpf_prog_type type =3D resolve_prog_type(env->prog);
> > +     u32 regno =3D exception_exit ? BPF_REG_1 : BPF_REG_0;
> > +     struct bpf_reg_state *reg =3D reg_state(env, regno);
> >       struct bpf_func_state *state =3D cur_func(env);
> > +     const struct bpf_prog *prog =3D env->prog;
> > +     const struct btf_type *ret_type =3D NULL;
> >       bool refs_lingering =3D false;
> > +     struct btf *btf;
> >       int i;
> >
> >       if (!exception_exit && state->frameno && !state->in_callback_fn)
> >               return 0;
> >
> > +     if (type =3D=3D BPF_PROG_TYPE_STRUCT_OPS &&
> > +         reg->type & PTR_TO_BTF_ID && reg->ref_obj_id) {
> > +             btf =3D bpf_prog_get_target_btf(prog);
> > +             ret_type =3D btf_type_by_id(btf, prog->aux->attach_func_p=
roto->type);
> > +             if (reg->btf_id !=3D ret_type->type) {
> > +                     verbose(env, "Return kptr type, struct %s, doesn'=
t match function prototype, struct %s\n",
> > +                             btf_type_name(reg->btf, reg->btf_id),
> > +                             btf_type_name(btf, ret_type->type));
> > +                     return -EINVAL;
> > +             }
> > +     }
> > +
> >       for (i =3D 0; i < state->acquired_refs; i++) {
> >               if (!exception_exit && state->in_callback_fn && state->re=
fs[i].callback_ref !=3D state->frameno)
> >                       continue;
> > +             if (ret_type && reg->ref_obj_id =3D=3D state->refs[i].id)
> > +                     continue;
>
> Is it possible having two kptrs that both are in the returned type
> passing into a function?
>

Just to make sure I understand the question correctly: Are you asking
what would happen here if a struct_ops operator has the following
signature?

struct *foo xxx_ops__dummy_op(struct foo *foo_a__ref, struct foo *foo_b__re=
f)

>
> >               verbose(env, "Unreleased reference id=3D%d alloc_insn=3D%=
d\n",
> >                       state->refs[i].id, state->refs[i].insn_idx);
> >               refs_lingering =3D true;
> > @@ -15677,12 +15697,15 @@ static int check_return_code(struct bpf_verif=
ier_env *env, int regno, const char
> >       const char *exit_ctx =3D "At program exit";
> >       struct tnum enforce_attach_type_range =3D tnum_unknown;
> >       const struct bpf_prog *prog =3D env->prog;
> > -     struct bpf_reg_state *reg;
> > +     struct bpf_reg_state *reg =3D reg_state(env, regno);
> >       struct bpf_retval_range range =3D retval_range(0, 1);
> >       enum bpf_prog_type prog_type =3D resolve_prog_type(env->prog);
> >       int err;
> >       struct bpf_func_state *frame =3D env->cur_state->frame[0];
> >       const bool is_subprog =3D frame->subprogno;
> > +     struct btf *btf =3D bpf_prog_get_target_btf(prog);
> > +     bool st_ops_ret_is_kptr =3D false;
> > +     const struct btf_type *t;
> >
> >       /* LSM and struct_ops func-ptr's return type could be "void" */
> >       if (!is_subprog || frame->in_exception_callback_fn) {
> > @@ -15691,10 +15714,26 @@ static int check_return_code(struct bpf_verif=
ier_env *env, int regno, const char
> >                       if (prog->expected_attach_type =3D=3D BPF_LSM_CGR=
OUP)
> >                               /* See below, can be 0 or 0-1 depending o=
n hook. */
> >                               break;
> > -                     fallthrough;
> > +                     if (!prog->aux->attach_func_proto->type)
> > +                             return 0;
> > +                     break;
> >               case BPF_PROG_TYPE_STRUCT_OPS:
> >                       if (!prog->aux->attach_func_proto->type)
> >                               return 0;
> > +
> > +                     t =3D btf_type_by_id(btf, prog->aux->attach_func_=
proto->type);
> > +                     if (btf_type_is_ptr(t)) {
> > +                             /* Allow struct_ops programs to return kp=
tr or null if
> > +                              * the return type is a pointer type.
> > +                              * check_reference_leak has ensured the r=
eturning kptr
> > +                              * matches the type of the function proto=
type and is
> > +                              * the only leaking reference. Thus, we c=
an safely return
> > +                              * if the pointer is in its unmodified fo=
rm
> > +                              */
> > +                             if (reg->type & PTR_TO_BTF_ID)
> > +                                     return __check_ptr_off_reg(env, r=
eg, regno, false);
> > +                             st_ops_ret_is_kptr =3D true;
> > +                     }
> >                       break;
> >               default:
> >                       break;
> > @@ -15716,8 +15755,6 @@ static int check_return_code(struct bpf_verifie=
r_env *env, int regno, const char
> >               return -EACCES;
> >       }
> >
> > -     reg =3D cur_regs(env) + regno;
> > -
> >       if (frame->in_async_callback_fn) {
> >               /* enforce return zero from async callbacks like timer */
> >               exit_ctx =3D "At async callback return";
> > @@ -15804,6 +15841,11 @@ static int check_return_code(struct bpf_verifi=
er_env *env, int regno, const char
> >       case BPF_PROG_TYPE_NETFILTER:
> >               range =3D retval_range(NF_DROP, NF_ACCEPT);
> >               break;
> > +     case BPF_PROG_TYPE_STRUCT_OPS:
> > +             if (!st_ops_ret_is_kptr)
> > +                     return 0;
> > +             range =3D retval_range(0, 0);
> > +             break;
> >       case BPF_PROG_TYPE_EXT:
> >               /* freplace program can return anything as its return val=
ue
> >                * depends on the to-be-replaced kernel func or bpf progr=
am.

