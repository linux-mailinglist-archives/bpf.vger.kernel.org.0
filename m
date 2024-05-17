Return-Path: <bpf+bounces-29900-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 297DC8C7FC3
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 04:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90EDE1F2227E
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 02:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34C64C6B;
	Fri, 17 May 2024 02:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQrxM5WY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47239449;
	Fri, 17 May 2024 02:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715911629; cv=none; b=faiQgePdaoJzOEee8KsGCmb/iVqMS9zP27FdPYhflGxZjpS2LFU11nQhQZYZH2MeZ8RIJv2qLniOOcoE3JIe+QqbUvf/vSwv/4brj4QQoJbHEV/6J8BHy2MT/0SUW4jyfp1cERauuHxh/9AobkZi7bwDye7BnoxstweoQFkVG/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715911629; c=relaxed/simple;
	bh=uPdrJJ/OOEpp8mPsh5143oB/e/pJOxHcdBAWzpc0yS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=loa2tT86aH3Q11e4v/Zh0PYWa8astAW4obrkkdU53kYLi6d5+Z9rZZnUFBWJwt1xnzVVW83WcKGD1YEo8FWHMf/ctuTCGL4oYR3Lc83pSd8bb3JLdjZwLOfkGB+YtHiEcZxCc3aziLEPBKi6ZjhHEMICbUb28HCp+mtJDOyVOBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQrxM5WY; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-de45dba15feso8833345276.3;
        Thu, 16 May 2024 19:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715911626; x=1716516426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DVOKrxiIP+KxjEHkskNezN1+cXMkosqN5I8s0vi9mj0=;
        b=MQrxM5WY7gmjXy5TJRHWUWZlwZvc7LQ35e5S7HP2n3lQuoKeU84jtSE/EKYlpQl2xQ
         ls7LqA5ymEz78kX0M8R+QAbMlmUeQu+EKOKMgT1i+FePM1H20XC1KYh+G0LCo4i+dfsY
         GIq2bl6rUmhQyiD11S5AYbnoq0lp+WS6SoeA2Lv5CyoJbKHAGzOGjjcHpRAn9WShuh6n
         5wyFavrX4k9bpoQQK4NjKXrKFegqODB6jHK26Ug/TjAG0SmBTZhJpvcb+DxnRMvdy+pK
         J4v44ZQdYm6JKSnkpwncgY9l5hqwGXZFrJONsXhM1RjTAp9PIrmGF8zTR7xh7PWfc7As
         vkoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715911626; x=1716516426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DVOKrxiIP+KxjEHkskNezN1+cXMkosqN5I8s0vi9mj0=;
        b=GtXC2GcTam/AxI17yI+tDfphzhq5KXhBdcYbqXLCFN+MIS/bccG9Qmk1Lqbr+hCzX+
         KWMF+3zGgki8YptRVrLvxTHGrKqWpSH+NANtulGCkusHYRY9xwPv6F+PiAjWWrfKN4hg
         ZW4HGq7QtqnGL0a/5K6W8ciYJ5zgrgbtxl1imFQAvm9iBaQwF1be1QRmwPZNX9H3Nl9/
         35RyKNgN1lF8GmbC8jg4Y+t8sAziCZtBsc5H3obvZQZtjobk7ZyfjSsaS+XqA8hek4Uv
         GeCD4Sbz+M1eTlmZU3fATeOPMuvsD2/W2Q1WxCkGvIBw+P6aNEkzAJN9JTYp8dheoINT
         DZKw==
X-Gm-Message-State: AOJu0Yw3iXcJcvOf5pxAWuzgg6ta4ogc16xunjVm+k+eonlDvPeO1+E+
	KDGIbCLnC6d254tRMxPls4Un358wFfBHeoyq1eIBMPvib3TW8isR+PAuAdFu+iHO4Ve41nd2ECK
	54RrA4+Ina+Gnhvx2grtcuHFmXqmMcSHL
X-Google-Smtp-Source: AGHT+IHzeKtCtpLCEMVlFJtNJ+/oYWZrU8TrGk2tx36GDm8H5JwR6BIj6q+D6+YDWIIhY4cIdllkridRrJgVk0Tcva0=
X-Received: by 2002:a25:4e85:0:b0:de8:a770:4812 with SMTP id
 3f1490d57ef6-dee4f3149dfmr17678815276.40.1715911626291; Thu, 16 May 2024
 19:07:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510192412.3297104-1-amery.hung@bytedance.com> <20240510192412.3297104-4-amery.hung@bytedance.com>
In-Reply-To: <20240510192412.3297104-4-amery.hung@bytedance.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 16 May 2024 19:06:55 -0700
Message-ID: <CAMB2axMa6sGcn69QhzkoG5JijDF+QpBuyWO9aae7hrLrM_EZvA@mail.gmail.com>
Subject: Re: [RFC PATCH v8 03/20] bpf: Allow struct_ops prog to return
 referenced kptr
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, yangpeihao@sjtu.edu.cn, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@kernel.org, sinquersw@gmail.com, 
	toke@redhat.com, jhs@mojatatu.com, jiri@resnulli.us, sdf@google.com, 
	xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 12:24=E2=80=AFPM Amery Hung <ameryhung@gmail.com> w=
rote:
>
> This patch allows a struct_ops program to return a referenced kptr
> if the struct_ops member has a pointer return type. To make sure the
> pointer returned to kernel is valid, it needs to be referenced and
> originally comes from the kernel. That is, it should be acquired
> through kfuncs or struct_ops "ref_acquried" arguments, but not allocated
> locally. Besides, null pointer is allowed. Therefore, kernel caller
> of the struct_ops function consuming the pointer needs to take care of
> the potential null pointer.
>
> The first use case will be Qdisc_ops::dequeue, where a qdisc returns a
> pointer to the skb to be dequeued.
>
> To achieve this, we first allow a reference object to leak through return
> if it is in the return register and the type matches the return type of t=
he
> function. Then, we check whether the pointer to-be-returned is valid in
> check_return_code().
>
> Signed-off-by: Amery Hung <amery.hung@bytedance.com>
> ---
>  kernel/bpf/verifier.c | 50 +++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 46 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 06a6edd306fd..2d4a55ead85b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10081,16 +10081,36 @@ record_func_key(struct bpf_verifier_env *env, s=
truct bpf_call_arg_meta *meta,
>
>  static int check_reference_leak(struct bpf_verifier_env *env, bool excep=
tion_exit)
>  {
> +       enum bpf_prog_type type =3D resolve_prog_type(env->prog);
> +       u32 regno =3D exception_exit? BPF_REG_1 : BPF_REG_0;
> +       struct bpf_reg_state *reg =3D reg_state(env, regno);
>         struct bpf_func_state *state =3D cur_func(env);
> +       const struct bpf_prog *prog =3D env->prog;
> +       const struct btf_type *ret_type =3D NULL;
>         bool refs_lingering =3D false;
> +       struct btf *btf;
>         int i;
>
>         if (!exception_exit && state->frameno && !state->in_callback_fn)
>                 return 0;
>
> +       if (type =3D=3D BPF_PROG_TYPE_STRUCT_OPS &&
> +           reg->type & PTR_TO_BTF_ID && reg->ref_obj_id) {
> +               btf =3D bpf_prog_get_target_btf(prog);
> +               ret_type =3D btf_type_by_id(btf, prog->aux->attach_func_p=
roto->type);
> +               if (reg->btf_id !=3D ret_type->type) {
> +                       verbose(env, "Return kptr type, struct %s, doesn'=
t match function prototype, struct %s\n",
> +                               btf_type_name(reg->btf, reg->btf_id),
> +                               btf_type_name(btf, ret_type->type));
> +                       return -EINVAL;
> +               }
> +       }
> +
>         for (i =3D 0; i < state->acquired_refs; i++) {
>                 if (!exception_exit && state->in_callback_fn && state->re=
fs[i].callback_ref !=3D state->frameno)
>                         continue;
> +               if (ret_type && reg->ref_obj_id =3D=3D state->refs[i].id)
> +                       continue;
>                 verbose(env, "Unreleased reference id=3D%d alloc_insn=3D%=
d\n",
>                         state->refs[i].id, state->refs[i].insn_idx);
>                 refs_lingering =3D true;
> @@ -15395,12 +15415,15 @@ static int check_return_code(struct bpf_verifie=
r_env *env, int regno, const char
>         const char *exit_ctx =3D "At program exit";
>         struct tnum enforce_attach_type_range =3D tnum_unknown;
>         const struct bpf_prog *prog =3D env->prog;
> -       struct bpf_reg_state *reg;
> +       struct bpf_reg_state *reg =3D reg_state(env, regno);
>         struct bpf_retval_range range =3D retval_range(0, 1);
>         enum bpf_prog_type prog_type =3D resolve_prog_type(env->prog);
>         int err;
>         struct bpf_func_state *frame =3D env->cur_state->frame[0];
>         const bool is_subprog =3D frame->subprogno;
> +       struct btf *btf =3D bpf_prog_get_target_btf(prog);
> +       bool st_ops_ret_is_kptr =3D false;
> +       const struct btf_type *t;
>
>         /* LSM and struct_ops func-ptr's return type could be "void" */
>         if (!is_subprog || frame->in_exception_callback_fn) {
> @@ -15409,10 +15432,26 @@ static int check_return_code(struct bpf_verifie=
r_env *env, int regno, const char
>                         if (prog->expected_attach_type =3D=3D BPF_LSM_CGR=
OUP)
>                                 /* See below, can be 0 or 0-1 depending o=
n hook. */
>                                 break;
> -                       fallthrough;
> +                       if (!prog->aux->attach_func_proto->type)
> +                               return 0;
> +                       break;
>                 case BPF_PROG_TYPE_STRUCT_OPS:
>                         if (!prog->aux->attach_func_proto->type)
>                                 return 0;
> +
> +                       t =3D btf_type_by_id(btf, prog->aux->attach_func_=
proto->type);
> +                       if (btf_type_is_ptr(t)) {
> +                               /* Allow struct_ops programs to return kp=
tr or null if
> +                                * the return type is a pointer type.
> +                                * check_reference_leak has ensured the r=
eturning kptr
> +                                * matches the type of the function proto=
type and is
> +                                * the only leaking reference. Thus, we c=
an safely return
> +                                * if the pointer is in its unmodified fo=
rm
> +                                */
> +                               if (reg->type & PTR_TO_BTF_ID)
> +                                       return __check_ptr_off_reg(env, r=
eg, regno, false);
> +                               st_ops_ret_is_kptr =3D true;
> +                       }
>                         break;
>                 default:
>                         break;
> @@ -15434,8 +15473,6 @@ static int check_return_code(struct bpf_verifier_=
env *env, int regno, const char
>                 return -EACCES;
>         }
>
> -       reg =3D cur_regs(env) + regno;
> -
>         if (frame->in_async_callback_fn) {
>                 /* enforce return zero from async callbacks like timer */
>                 exit_ctx =3D "At async callback return";
> @@ -15522,6 +15559,11 @@ static int check_return_code(struct bpf_verifier=
_env *env, int regno, const char
>         case BPF_PROG_TYPE_NETFILTER:
>                 range =3D retval_range(NF_DROP, NF_ACCEPT);
>                 break;
> +       case BPF_PROG_TYPE_STRUCT_OPS:
> +               if (!st_ops_ret_is_kptr)
> +                       return 0;
> +               range =3D retval_range(0, 0);
> +               break;

Arguments and the return for helpers and kfuncs, where we transition
between bpf program and kernel, can be tagged, so that we can do
proper checks. struct_ops shares the similar property in that sense,
but currently lacks the ability to tag the return.

A discussion was that, here we assume the returning referenced kptr
"may be null" because that's what Qdisc expects. I think it would make
sense to only allow it when the return is explicitly tagged with
MAY_BE_NULL. How about doing so in the stub function name?


>         case BPF_PROG_TYPE_EXT:
>                 /* freplace program can return anything as its return val=
ue
>                  * depends on the to-be-replaced kernel func or bpf progr=
am.
> --
> 2.20.1
>

