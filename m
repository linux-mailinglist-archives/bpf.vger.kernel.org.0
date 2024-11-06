Return-Path: <bpf+bounces-44178-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 594999BF953
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 23:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE858B21ED5
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 22:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E991DDC33;
	Wed,  6 Nov 2024 22:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWIbJ8P4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14B31A00FE
	for <bpf@vger.kernel.org>; Wed,  6 Nov 2024 22:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730932344; cv=none; b=adI7Hk0wdzD1IKi3vLRLmKxQTPhC9s1pJrJbY2f1zkdoDkbpg+HiUjvHDGina5XOUlu+xCuG2HugbMmAryK/+G0Qnv+8qeQzj71k2QjknPMHS7UXTnezSCRihf57+jsLR5CcjzxOA3Ncbge1O1YBkl/7lad0FCgti1y6aL1p/sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730932344; c=relaxed/simple;
	bh=mjWyhtDVW2ZEBxQlLKCPKL2eDRXS6u2U3jVgDq863u0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YsDxwI1aKjDf5cs2C7JvjP0q+a/EDZQblR4F7eb7oF7sl4Ihr6OME/VDaUco4UqomaH8grLYTeDSBTUhBHtSDRkRmUh0/H5CrB3YvcXxrUo9lsOcWlfgwa76vypqEJ2KGKc7CLPeUwy7GON3Bc2467JNxQOHbOsl+CBcAbrO7GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWIbJ8P4; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e2a97c2681so248163a91.2
        for <bpf@vger.kernel.org>; Wed, 06 Nov 2024 14:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730932341; x=1731537141; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DCYIsZH6SPS6czBakdesnlSRtXWHcQMldLVzWuN19oA=;
        b=YWIbJ8P4r3nJ8RHbRzmRHx4gxy4kJ2lu5uPkkrQ+JVjke/hRkOilEVVxz3D/88fXIZ
         nOw8wjZl4uGuW65VUCvU6c2dqzEMWI5C6Wrezh9gUQCTt0M460uSpWdTPYdbM3M8PMiV
         +Jxhqn33FcfhpMBtaHtMRczZf8Qk7DVag0BRzgrIo6sOXf8feNkkTOvWhMLuXsttmqpV
         uv60Ft6iGukYP8+DcEl2S3bLI7AwMZWAaHYameiy/oqyGANUxr42OUkVrblLtYAqZWrl
         ILSHnxDamYftlFmpX+w5tChpxTxqgEMv/IFX4i+nVfzAG8wzAjZ5GOlP+5xMQBaIsl6d
         5fwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730932341; x=1731537141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DCYIsZH6SPS6czBakdesnlSRtXWHcQMldLVzWuN19oA=;
        b=gNvxtTg2Nqx8BnmX4Wmb5O7Ge5OHulYQ8RbWb5Me9fNwhN6JlGB85jttvAwPNb7ktE
         y3rxNRHKtp1uavD2rQi1SvUawWXLS0A8skERx7M3Np0MVVFWwcfb2WcSdmdXWFvQxHpP
         Vf2FkWlpQx4LNeS3Z+KbH8KBARao5OtFyFbXb9iokHHisiqRWjFdkI0zf5fPsX8MnElI
         MvLYI0FdfYFiePbTiif0tdYRs2rgnLQvl1MvxbwR7xKw5mK4NVaSaSD+XFKJakgAYX72
         UK6PgPVv8zo+w/UDy/wkxhlB+NMObAOBKoNOivJXKzEoL430XdRCWKjaZAi1ub++C3p0
         wTtA==
X-Gm-Message-State: AOJu0Yw4HaiHrZVJ36oJ4qMkVO1y6Ut/g+9gQaNA7Lv6ObO+c4e4wLeA
	LhnXvKkfipmx1KMjYV4+n6gsr12TnJhslTG0qOMSIZe/DirOG5Mr0OR16I6jMwTDiLIXb5qnkit
	uEzii9Ns6bKzb2QKAXMaexFIro0m2dOe5
X-Google-Smtp-Source: AGHT+IHaJ/rRelltsl8P9R5l7b+ZZN9RxpLEf4fqwxkGn3IqGzByKnwRBF7GE/dH3Irl62wfIBeTizjxDPjzY3t/ZW0=
X-Received: by 2002:a17:90a:7c06:b0:2e0:921a:3383 with SMTP id
 98e67ed59e1d1-2e92ce2e140mr34835498a91.1.1730932340675; Wed, 06 Nov 2024
 14:32:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104171959.2938862-1-memxor@gmail.com> <20241104171959.2938862-2-memxor@gmail.com>
In-Reply-To: <20241104171959.2938862-2-memxor@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 6 Nov 2024 14:32:08 -0800
Message-ID: <CAEf4BzYxjWY-YCaCMQ73joU_O96KhKBRXm6KgvENJk1TbeCD_w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] bpf: Mark raw_tp arguments with PTR_MAYBE_NULL
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, kkd@meta.com, Jiri Olsa <jolsa@kernel.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 9:20=E2=80=AFAM Kumar Kartikeya Dwivedi <memxor@gmai=
l.com> wrote:
>
> Arguments to a raw tracepoint are tagged as trusted, which carries the
> semantics that the pointer will be non-NULL.  However, in certain cases,
> a raw tracepoint argument may end up being NULL. More context about this
> issue is available in [0].
>
> Thus, there is a discrepancy between the reality, that raw_tp arguments
> can actually be NULL, and the verifier's knowledge, that they are never
> NULL, causing explicit NULL checks to be deleted, and accesses to such
> pointers potentially crashing the kernel.
>
> To fix this, mark raw_tp arguments as PTR_MAYBE_NULL, and then special
> case the dereference and pointer arithmetic to permit it, and allow
> passing them into helpers/kfuncs; these exceptions are made for raw_tp
> programs only. Ensure that we don't do this when ref_obj_id > 0, as in
> that case this is an acquired object and doesn't need such adjustment.
>
> The reason we do mask_raw_tp_trusted_reg logic is because other will
> recheck in places whether the register is a trusted_reg, and then
> consider our register as untrusted when detecting the presence of the
> PTR_MAYBE_NULL flag.
>
> To allow safe dereference, we enable PROBE_MEM marking when we see loads
> into trusted pointers with PTR_MAYBE_NULL.
>
> While trusted raw_tp arguments can also be passed into helpers or kfuncs
> where such broken assumption may cause issues, a future patch set will
> tackle their case separately, as PTR_TO_BTF_ID (without PTR_TRUSTED) can
> already be passed into helpers and causes similar problems. Thus, they
> are left alone for now.
>
> It is possible that these checks also permit passing non-raw_tp args
> that are trusted PTR_TO_BTF_ID with null marking. In such a case,
> allowing dereference when pointer is NULL expands allowed behavior, so
> won't regress existing programs, and the case of passing these into
> helpers is the same as above and will be dealt with later.
>
> Also update the failure case in tp_btf_nullable selftest to capture the
> new behavior, as the verifier will no longer cause an error when
> directly dereference a raw tracepoint argument marked as __nullable.
>
>   [0]: https://lore.kernel.org/bpf/ZrCZS6nisraEqehw@jlelli-thinkpadt14gen=
4.remote.csb
>
> Reviewed-by: Jiri Olsa <jolsa@kernel.org>
> Reported-by: Juri Lelli <juri.lelli@redhat.com>
> Tested-by: Juri Lelli <juri.lelli@redhat.com>
> Fixes: 3f00c5239344 ("bpf: Allow trusted pointers to be passed to KF_TRUS=
TED_ARGS kfuncs")
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  include/linux/bpf.h                           |  6 ++
>  kernel/bpf/btf.c                              |  5 +-
>  kernel/bpf/verifier.c                         | 79 +++++++++++++++++--
>  .../bpf/progs/test_tp_btf_nullable.c          |  6 +-
>  4 files changed, 87 insertions(+), 9 deletions(-)
>

[...]

> @@ -12065,12 +12109,15 @@ static int check_kfunc_args(struct bpf_verifier=
_env *env, struct bpf_kfunc_call_
>                         return -EINVAL;
>                 }
>
> +               mask =3D mask_raw_tp_reg(env, reg);
>                 if ((is_kfunc_trusted_args(meta) || is_kfunc_rcu(meta)) &=
&
>                     (register_is_null(reg) || type_may_be_null(reg->type)=
) &&
>                         !is_kfunc_arg_nullable(meta->btf, &args[i])) {
>                         verbose(env, "Possibly NULL pointer passed to tru=
sted arg%d\n", i);
> +                       unmask_raw_tp_reg(reg, mask);

Kumar,

Do we really need this unmask? We are already erroring out, restoring
reg->type is probably not very important at this point?

>                         return -EACCES;
>                 }
> +               unmask_raw_tp_reg(reg, mask);
>
>                 if (reg->ref_obj_id) {
>                         if (is_kfunc_release(meta) && meta->ref_obj_id) {
> @@ -12128,16 +12175,24 @@ static int check_kfunc_args(struct bpf_verifier=
_env *env, struct bpf_kfunc_call_
>                         if (!is_kfunc_trusted_args(meta) && !is_kfunc_rcu=
(meta))
>                                 break;
>
> +                       /* Allow passing maybe NULL raw_tp arguments to
> +                        * kfuncs for compatibility. Don't apply this to
> +                        * arguments with ref_obj_id > 0.
> +                        */
> +                       mask =3D mask_raw_tp_reg(env, reg);
>                         if (!is_trusted_reg(reg)) {
>                                 if (!is_kfunc_rcu(meta)) {
>                                         verbose(env, "R%d must be referen=
ced or trusted\n", regno);
> +                                       unmask_raw_tp_reg(reg, mask);

same as above, do we care about unmasking in this situation? and the
one immediately below?

>                                         return -EINVAL;
>                                 }
>                                 if (!is_rcu_reg(reg)) {
>                                         verbose(env, "R%d must be a rcu p=
ointer\n", regno);
> +                                       unmask_raw_tp_reg(reg, mask);
>                                         return -EINVAL;
>                                 }
>                         }
> +                       unmask_raw_tp_reg(reg, mask);
>                         fallthrough;
>                 case KF_ARG_PTR_TO_CTX:
>                 case KF_ARG_PTR_TO_DYNPTR:
> @@ -12160,7 +12215,9 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
>
>                 if (is_kfunc_release(meta) && reg->ref_obj_id)
>                         arg_type |=3D OBJ_RELEASE;
> +               mask =3D mask_raw_tp_reg(env, reg);
>                 ret =3D check_func_arg_reg_off(env, reg, regno, arg_type)=
;
> +               unmask_raw_tp_reg(reg, mask);
>                 if (ret < 0)
>                         return ret;
>
> @@ -12337,6 +12394,7 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
>                         ref_tname =3D btf_name_by_offset(btf, ref_t->name=
_off);
>                         fallthrough;
>                 case KF_ARG_PTR_TO_BTF_ID:
> +                       mask =3D mask_raw_tp_reg(env, reg);
>                         /* Only base_type is checked, further checks are =
done here */
>                         if ((base_type(reg->type) !=3D PTR_TO_BTF_ID ||
>                              (bpf_type_has_unsafe_modifiers(reg->type) &&=
 !is_rcu_reg(reg))) &&
> @@ -12345,9 +12403,11 @@ static int check_kfunc_args(struct bpf_verifier_=
env *env, struct bpf_kfunc_call_
>                                 verbose(env, "expected %s or socket\n",
>                                         reg_type_str(env, base_type(reg->=
type) |
>                                                           (type_flag(reg-=
>type) & BPF_REG_TRUSTED_MODIFIERS)));
> +                               unmask_raw_tp_reg(reg, mask);

ditto

>                                 return -EINVAL;
>                         }
>                         ret =3D process_kf_arg_ptr_to_btf_id(env, reg, re=
f_t, ref_tname, ref_id, meta, i);
> +                       unmask_raw_tp_reg(reg, mask);
>                         if (ret < 0)
>                                 return ret;
>                         break;
> @@ -13320,7 +13380,7 @@ static int sanitize_check_bounds(struct bpf_verif=
ier_env *env,
>   */
>  static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
>                                    struct bpf_insn *insn,
> -                                  const struct bpf_reg_state *ptr_reg,
> +                                  struct bpf_reg_state *ptr_reg,
>                                    const struct bpf_reg_state *off_reg)
>  {
>         struct bpf_verifier_state *vstate =3D env->cur_state;
> @@ -13334,6 +13394,7 @@ static int adjust_ptr_min_max_vals(struct bpf_ver=
ifier_env *env,
>         struct bpf_sanitize_info info =3D {};
>         u8 opcode =3D BPF_OP(insn->code);
>         u32 dst =3D insn->dst_reg;
> +       bool mask;
>         int ret;
>
>         dst_reg =3D &regs[dst];
> @@ -13360,11 +13421,14 @@ static int adjust_ptr_min_max_vals(struct bpf_v=
erifier_env *env,
>                 return -EACCES;
>         }
>
> +       mask =3D mask_raw_tp_reg(env, ptr_reg);
>         if (ptr_reg->type & PTR_MAYBE_NULL) {
>                 verbose(env, "R%d pointer arithmetic on %s prohibited, nu=
ll-check it first\n",
>                         dst, reg_type_str(env, ptr_reg->type));
> +               unmask_raw_tp_reg(ptr_reg, mask);

ditto

>                 return -EACCES;
>         }
> +       unmask_raw_tp_reg(ptr_reg, mask);
>
>         switch (base_type(ptr_reg->type)) {
>         case PTR_TO_CTX:
> @@ -19866,6 +19930,7 @@ static int convert_ctx_accesses(struct bpf_verifi=
er_env *env)
>                  * for this case.
>                  */
>                 case PTR_TO_BTF_ID | MEM_ALLOC | PTR_UNTRUSTED:
> +               case PTR_TO_BTF_ID | PTR_TRUSTED | PTR_MAYBE_NULL:
>                         if (type =3D=3D BPF_READ) {
>                                 if (BPF_MODE(insn->code) =3D=3D BPF_MEM)
>                                         insn->code =3D BPF_LDX | BPF_PROB=
E_MEM |
> diff --git a/tools/testing/selftests/bpf/progs/test_tp_btf_nullable.c b/t=
ools/testing/selftests/bpf/progs/test_tp_btf_nullable.c
> index bba3e37f749b..5aaf2b065f86 100644
> --- a/tools/testing/selftests/bpf/progs/test_tp_btf_nullable.c
> +++ b/tools/testing/selftests/bpf/progs/test_tp_btf_nullable.c
> @@ -7,7 +7,11 @@
>  #include "bpf_misc.h"
>
>  SEC("tp_btf/bpf_testmod_test_nullable_bare")
> -__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
> +/* This used to be a failure test, but raw_tp nullable arguments can now
> + * directly be dereferenced, whether they have nullable annotation or no=
t,
> + * and don't need to be explicitly checked.
> + */
> +__success
>  int BPF_PROG(handle_tp_btf_nullable_bare1, struct bpf_testmod_test_read_=
ctx *nullable_ctx)
>  {
>         return nullable_ctx->len;
> --
> 2.43.5
>

