Return-Path: <bpf+bounces-68550-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD0EB5A339
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 22:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D74D7AA297
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 20:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F97F2F9D94;
	Tue, 16 Sep 2025 20:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dz88jW/W"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EA62F90D4
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 20:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758054888; cv=none; b=cgBLyTc+UVPR9oFOo/avly/MDskmWk9Oqd3UcIFhzODx1bGoKOsFBmSIWBVQbbtc5HU3+LKCZWLiKsQtK0yMDKjGpMUYUvpjl7TA5dGhUvA5nRg8sL4HSeIbMJoczGDC4o4axjGTeYNckbe3G2Gvi2va5cLF9oxdIsSx5lWqwPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758054888; c=relaxed/simple;
	bh=k4+mv6WIihwWYrk2dT0LY4k5k/mV+ft0oyCHj2qvSBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bo/45+F2MIHhh7oT3P/btnsPN++qDzmGo5WLH6Y9F++JD882jjVXKhNJH03WEGHxFBxG63ZmdeyI+PqAyvNU4MfhAJ9M4+Ef0A+GK+WIKEvz01J5g+cUzDvqIEifBoV8aBDklEwb2oLOjTJEW+/lUW6N2hEMKgkKMA/JwGNnvng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dz88jW/W; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3e7636aa65fso5428593f8f.1
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 13:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758054884; x=1758659684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xkjwOL4mMmOp+s8Z3wckPSBWjiZYX5jwd7dlZ43ibXY=;
        b=dz88jW/Wf90ubyiVwaa6wcVxOc/wct7kGiJ2KxS91a3+vicnZqtKIHTcgAhSsAHuYo
         t7xph+q78TetTfC6dY0aXkz8bioCWgBo1xN373PGFUzkLBHI8f9yQzY6Qboae7DKuG8E
         svq4pBbisQDt/L1OqMohrSyO4fcPnKHbjq+Fu/K/xnumzkke5czbOMctJ8FPFNTMHUBt
         ukgij48T4Vn6edALl3/1FmNzikYrPqN/aat91XkP8IQUmkKFMjKS6anqaDvtP/RsGLQH
         MqEWyUsXgL+0+sMYsQQaKPF0+sxdikqwJZIm7t4lcmP1Cu1tnossEKKp63ybKCmXJx+o
         sriA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758054884; x=1758659684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xkjwOL4mMmOp+s8Z3wckPSBWjiZYX5jwd7dlZ43ibXY=;
        b=lz/6svomZrSX92tluEDP6WOQlU7KKM9fpO9EAeYTVbvRrLFVKpCysYlSy9wR8EFEkg
         82Drv11TiSM/Q3kRnBIF+wiIjKO0FOjvr24tgfG0P8XwUHK9IF+XkQSEAK0SQSoECszY
         fk4MfQb/61IUa+/c8e92HPZGTXcJloS1pG9sHnJxshFCsiQlSfmic/svUvqZmGWjErT3
         tCIFpg5aVxhOdSgV8VBZHn1uNiYwaJwLRKOntpkHJ9x7DfLiwULQuY4OyuyLDfp6JIgy
         42Ub3ifdL0cSj2v/2LfxaGQO8bhLZDp5jF7xFMuYyrkj7hTueWW8+T42GeWPsuwjT5gU
         QizA==
X-Gm-Message-State: AOJu0YyJtt9IAVgeeKavK0RHoWFvPNEhwwrqxh7JO3Pp5Yh+S0gopApu
	d6t22piCcP5MKRTNk10pq55qeieRHc6/dLkMzEa+pf6/nbd2L7M/GbuIRvMaZs5v25weHtYK3S8
	y8b1AM7gttS0ssfWtsZjUXGhmMoHKqww=
X-Gm-Gg: ASbGncui1ITWGOqOsi8QyBbmBchAxBiZs2/7vAG/FxcTYdwgwBzgGS0tuB0GKnusRrl
	8cBgy6BmDlmJHUvXuQNGWlRlScKzqshMOrtBQfZyMd8RK50ecz0wDaX95VVZarRNpY9O2Vw+8WF
	3wIOoDtpOK3e5GuHucjfCcWaoQk500vAw317N91Sr3aLniApwlSL8PwN/nxPFKc51OoSFEgfGyT
	KmXGfdfF5dRJaB3etX4Rw==
X-Google-Smtp-Source: AGHT+IEs2+VY/quE3S7v/wvSsPuU9fJo0VFkIdWvS3Z0UHZ12MaGWBYzLD7Aecaxaq0L8IrslhJiAkQiSbfOG92Nb9s=
X-Received: by 2002:a05:6000:2508:b0:3e9:ad34:2b2e with SMTP id
 ffacd0b85a97d-3e9ad343387mr10163074f8f.46.1758054884183; Tue, 16 Sep 2025
 13:34:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916113622.19540-1-puranjay@kernel.org>
In-Reply-To: <20250916113622.19540-1-puranjay@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 16 Sep 2025 13:34:30 -0700
X-Gm-Features: AS18NWBMTeYFPA6drMS_F3k9gM_gDqGmmf7T6cChr6V1b7jLAr84kLgGF3JvrkA
Message-ID: <CAADnVQKqjQKrSYTm8DO-GLYTFyaGaN8_RiuuJ8kj4zaAShQF0w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: support nested rcu critical sections
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, kkd@meta.com, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Puranjay Mohan <puranjay12@gmail.com>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 4:36=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
> Currently, nested rcu critical sections are rejected by the verifier and
> rcu_lock state is managed by a boolean variable. Add support for nested
> rcu critical sections by make active_rcu_locks a counter similar to
> active_preempt_locks. bpf_rcu_read_lock() increments this counter and
> bpf_rcu_read_unlock() decrements it, MEM_RCU -> PTR_UNTRUSTED transition
> happens when active_rcu_locks drops to 0.
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  include/linux/bpf_verifier.h                  |  2 +-
>  kernel/bpf/verifier.c                         | 34 ++++++++--------
>  .../selftests/bpf/prog_tests/rcu_read_lock.c  |  4 +-
>  .../selftests/bpf/progs/rcu_read_lock.c       | 40 +++++++++++++++++++
>  4 files changed, 61 insertions(+), 19 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 020de62bd09c..3fb4632d5eed 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -441,7 +441,7 @@ struct bpf_verifier_state {
>         u32 active_irq_id;
>         u32 active_lock_id;
>         void *active_lock_ptr;
> -       bool active_rcu_lock;
> +       u32 active_rcu_locks;
>
>         bool speculative;
>         bool in_sleepable;
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1029380f84db..645af66e29ab 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1438,7 +1438,7 @@ static int copy_reference_state(struct bpf_verifier=
_state *dst, const struct bpf
>         dst->acquired_refs =3D src->acquired_refs;
>         dst->active_locks =3D src->active_locks;
>         dst->active_preempt_locks =3D src->active_preempt_locks;
> -       dst->active_rcu_lock =3D src->active_rcu_lock;
> +       dst->active_rcu_locks =3D src->active_rcu_locks;
>         dst->active_irq_id =3D src->active_irq_id;
>         dst->active_lock_id =3D src->active_lock_id;
>         dst->active_lock_ptr =3D src->active_lock_ptr;
> @@ -5924,7 +5924,7 @@ static bool in_sleepable(struct bpf_verifier_env *e=
nv)
>   */
>  static bool in_rcu_cs(struct bpf_verifier_env *env)
>  {
> -       return env->cur_state->active_rcu_lock ||
> +       return env->cur_state->active_rcu_locks ||
>                env->cur_state->active_locks ||
>                !in_sleepable(env);
>  }
> @@ -10684,7 +10684,7 @@ static int check_func_call(struct bpf_verifier_en=
v *env, struct bpf_insn *insn,
>                 }
>
>                 if (env->subprog_info[subprog].might_sleep &&
> -                   (env->cur_state->active_rcu_lock || env->cur_state->a=
ctive_preempt_locks ||
> +                   (env->cur_state->active_rcu_locks || env->cur_state->=
active_preempt_locks ||
>                      env->cur_state->active_irq_id || !in_sleepable(env))=
) {
>                         verbose(env, "global functions that may sleep are=
 not allowed in non-sleepable context,\n"
>                                      "i.e., in a RCU/IRQ/preempt-disabled=
 section, or in\n"
> @@ -11231,7 +11231,7 @@ static int check_resource_leak(struct bpf_verifie=
r_env *env, bool exception_exit
>                 return -EINVAL;
>         }
>
> -       if (check_lock && env->cur_state->active_rcu_lock) {
> +       if (check_lock && env->cur_state->active_rcu_locks) {
>                 verbose(env, "%s cannot be used inside bpf_rcu_read_lock-=
ed region\n", prefix);
>                 return -EINVAL;
>         }
> @@ -11426,7 +11426,7 @@ static int check_helper_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn
>                 return err;
>         }
>
> -       if (env->cur_state->active_rcu_lock) {
> +       if (env->cur_state->active_rcu_locks) {
>                 if (fn->might_sleep) {
>                         verbose(env, "sleepable helper %s#%d in rcu_read_=
lock region\n",
>                                 func_id_name(func_id), func_id);
> @@ -13863,7 +13863,7 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
>         preempt_disable =3D is_kfunc_bpf_preempt_disable(&meta);
>         preempt_enable =3D is_kfunc_bpf_preempt_enable(&meta);
>
> -       if (env->cur_state->active_rcu_lock) {
> +       if (env->cur_state->active_rcu_locks) {
>                 struct bpf_func_state *state;
>                 struct bpf_reg_state *reg;
>                 u32 clear_mask =3D (1 << STACK_SPILL) | (1 << STACK_ITER)=
;
> @@ -13874,22 +13874,22 @@ static int check_kfunc_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn,
>                 }
>
>                 if (rcu_lock) {
> -                       verbose(env, "nested rcu read lock (kernel functi=
on %s)\n", func_name);
> -                       return -EINVAL;
> +                       env->cur_state->active_rcu_locks++;
>                 } else if (rcu_unlock) {
> -                       bpf_for_each_reg_in_vstate_mask(env->cur_state, s=
tate, reg, clear_mask, ({
> -                               if (reg->type & MEM_RCU) {
> -                                       reg->type &=3D ~(MEM_RCU | PTR_MA=
YBE_NULL);
> -                                       reg->type |=3D PTR_UNTRUSTED;
> -                               }
> -                       }));
> -                       env->cur_state->active_rcu_lock =3D false;
> +                       if (--env->cur_state->active_rcu_locks =3D=3D 0) =
{

hmm. can it go negative ?

nested_rcu_region_unbalanced_1 test suppose to check it,
but what kind of error is returned?


> +                               bpf_for_each_reg_in_vstate_mask(env-

rewrite it to avoid adding extra ident?

>cur_state, state, reg, clear_mask, ({
> +                                       if (reg->type & MEM_RCU) {
> +                                               reg->type &=3D ~(MEM_RCU =
| PTR_MAYBE_NULL);
> +                                               reg->type |=3D PTR_UNTRUS=
TED;
> +                                       }
> +                               }));
> +                       }
>                 } else if (sleepable) {
>                         verbose(env, "kernel func %s is sleepable within =
rcu_read_lock region\n", func_name);
>                         return -EACCES;
>                 }
>         } else if (rcu_lock) {
> -               env->cur_state->active_rcu_lock =3D true;
> +               env->cur_state->active_rcu_locks++;
>         } else if (rcu_unlock) {
>                 verbose(env, "unmatched rcu read unlock (kernel function =
%s)\n", func_name);
>                 return -EINVAL;
> @@ -18887,7 +18887,7 @@ static bool refsafe(struct bpf_verifier_state *ol=
d, struct bpf_verifier_state *c
>         if (old->active_preempt_locks !=3D cur->active_preempt_locks)
>                 return false;
>
> -       if (old->active_rcu_lock !=3D cur->active_rcu_lock)
> +       if (old->active_rcu_locks !=3D cur->active_rcu_locks)
>                 return false;
>
>         if (!check_ids(old->active_irq_id, cur->active_irq_id, idmap))
> diff --git a/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c b/too=
ls/testing/selftests/bpf/prog_tests/rcu_read_lock.c
> index c9f855e5da24..246eb259c08a 100644
> --- a/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c
> +++ b/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c
> @@ -28,6 +28,7 @@ static void test_success(void)
>         bpf_program__set_autoload(skel->progs.two_regions, true);
>         bpf_program__set_autoload(skel->progs.non_sleepable_1, true);
>         bpf_program__set_autoload(skel->progs.non_sleepable_2, true);
> +       bpf_program__set_autoload(skel->progs.nested_rcu_region, true);
>         bpf_program__set_autoload(skel->progs.task_trusted_non_rcuptr, tr=
ue);
>         bpf_program__set_autoload(skel->progs.rcu_read_lock_subprog, true=
);
>         bpf_program__set_autoload(skel->progs.rcu_read_lock_global_subpro=
g, true);
> @@ -78,7 +79,8 @@ static const char * const inproper_region_tests[] =3D {
>         "non_sleepable_rcu_mismatch",
>         "inproper_sleepable_helper",
>         "inproper_sleepable_kfunc",
> -       "nested_rcu_region",

should be deleted from progs/rcu_read_lock.c too ?

This selftests hunk should in the main patch,
but below new tests need to go into another patch.

pw-bot: cr

> +       "nested_rcu_region_unbalanced_1",
> +       "nested_rcu_region_unbalanced_2",
>         "rcu_read_lock_global_subprog_lock",
>         "rcu_read_lock_global_subprog_unlock",
>         "rcu_read_lock_sleepable_helper_global_subprog",
> diff --git a/tools/testing/selftests/bpf/progs/rcu_read_lock.c b/tools/te=
sting/selftests/bpf/progs/rcu_read_lock.c
> index 3a868a199349..d70c28824bbe 100644
> --- a/tools/testing/selftests/bpf/progs/rcu_read_lock.c
> +++ b/tools/testing/selftests/bpf/progs/rcu_read_lock.c
> @@ -278,6 +278,46 @@ int nested_rcu_region(void *ctx)
>         return 0;
>  }
>
> +SEC("?fentry.s/" SYS_PREFIX "sys_nanosleep")
> +int nested_rcu_region_unbalanced_1(void *ctx)
> +{
> +       struct task_struct *task, *real_parent;
> +
> +       /* nested rcu read lock regions */
> +       task =3D bpf_get_current_task_btf();
> +       bpf_rcu_read_lock();
> +       bpf_rcu_read_lock();
> +       real_parent =3D task->real_parent;
> +       if (!real_parent)
> +               goto out;
> +       (void)bpf_task_storage_get(&map_a, real_parent, 0, 0);
> +out:
> +       bpf_rcu_read_unlock();
> +       bpf_rcu_read_unlock();
> +       bpf_rcu_read_unlock();
> +       return 0;
> +}
> +
> +SEC("?fentry.s/" SYS_PREFIX "sys_nanosleep")
> +int nested_rcu_region_unbalanced_2(void *ctx)
> +{
> +       struct task_struct *task, *real_parent;
> +
> +       /* nested rcu read lock regions */
> +       task =3D bpf_get_current_task_btf();
> +       bpf_rcu_read_lock();
> +       bpf_rcu_read_lock();
> +       bpf_rcu_read_lock();
> +       real_parent =3D task->real_parent;
> +       if (!real_parent)
> +               goto out;
> +       (void)bpf_task_storage_get(&map_a, real_parent, 0, 0);
> +out:
> +       bpf_rcu_read_unlock();
> +       bpf_rcu_read_unlock();
> +       return 0;
> +}
> +
>  SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
>  int task_trusted_non_rcuptr(void *ctx)
>  {
> --
> 2.47.3
>

