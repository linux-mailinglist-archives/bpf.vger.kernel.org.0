Return-Path: <bpf+bounces-43782-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE6F9B993F
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 21:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B40911C20F45
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 20:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACB91D279D;
	Fri,  1 Nov 2024 20:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8G+vR+W"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246421CB526
	for <bpf@vger.kernel.org>; Fri,  1 Nov 2024 20:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730492038; cv=none; b=N5T7iK6m6YBEFVNT0Q3Ee6tUqrr1fprD8sd/GxwwtSSyCT+0h0TIIs8CNgjdNB5xFi8OGuYeX+xhqy3Z+GdkqNXAuno5KbBtcOuT3gQFr4CU6ufYZLQkh2Uv/efH7cr9GOqm0eZ8tWeHwD2rSn7UNsxnNvYrqUiWKRm1g/oUl1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730492038; c=relaxed/simple;
	bh=8DoIsHJf2DEzI5AhcPIxxdVVqAY0ZNQjq8Kq7EvqJ20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bCg3g32WDILilNKXhvySAyDcA2gLV9+PYMHxrxwMuhHQZ5wutxRPEfbQemJpm6omp5EoB98VBNWVZNnNW4SmW//XW48BEPS7XYWyb9gsxEykB65LLEn8/54cPbatukX7c0kXm0SMQZsMRlYdlR7w1IMXa3p2ZNlzMaC+GGThVdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8G+vR+W; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43155abaf0bso19990965e9.0
        for <bpf@vger.kernel.org>; Fri, 01 Nov 2024 13:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730492034; x=1731096834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ON4i1mfZnlK8pG7P/PARjMgefSRARXOkwN3qO7t+HXc=;
        b=k8G+vR+WZyUNYonb1pc1RHk10Zt/JfR1KP5g2FyC3Mz+tYLJtS0F6mIYotRDGxjPQP
         PE+fi8Jp8wYBqT01OXkDjp8i+5VBdc/PDAeiJNwfiGuGwzLvKVXEEarGMF801Q2qXbPf
         sA2jLvQ8qaTy+KPnlEHlJ5R/j4AXbLpa6w3Y/KbGchlTXoeo0uKnNccLVqabdgzfz2F7
         O9tzwdanD5Xh16+NerSs9PpZBzFxkPo627h2UrHm2QS9f3e0QTleV04POzeQUt46Z4aU
         NTJJxnWF5wJjOT4p4o18Vfgdc7EfbPGip3c8zxAeMr1rl0cp7g7BCMqqbPAkskL5Y1Gn
         aM9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730492034; x=1731096834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ON4i1mfZnlK8pG7P/PARjMgefSRARXOkwN3qO7t+HXc=;
        b=jVwdZuGoH8qDZFTnf+DIR03LL40T3NBMXd2pds2EL6BC1wM35vdYyeSDVG6yXGD9Pr
         fXGAVMuHT7FXLVFH7uXaMt6MwL3T+vGcsC/FxZnfdP44Q7cqqhBy+mDDCBVDMbRQzc3E
         gO5THqqI1WeaY18V6o96YRlC6z2w6Lhcfb+3DTICslSzy3bUdcIyKSUYyXIm97Q47Koq
         i35Nby7pvB1HXLbSBZY0AZaAASSpvsgaHstpb1TEjkhvxNIGTKsx2Ek17mBa5koMJqzD
         XzwNi2BXP4jZoi40neEsiPNlOFR7Mxqg5bBCwegGGa53uxOTlw46D8bksySKVs8hkYd2
         BMtw==
X-Gm-Message-State: AOJu0YycHKokItu9+gcJZ0r6eKlJw+QNbS0s6gB0SQaZMmuu5bfcz1yB
	XS67DCx6WV4RWLilpMBP5Fjg/6p1dYk9DxRkAcbuevHe4OBgQTmHPFO+P0q95/0J6EBDrU1Fo1E
	eSe3Uh7/sx8SsDRbsxtkpFFqlO6Y=
X-Google-Smtp-Source: AGHT+IEKlDnn/PnQAWt74ISk+BRmVgVahQ+Gv9cMGMDYvBfs8a50dnYTI/vAYSqMG0b+C+SXVI/XR8yYmPEWZd4FVnc=
X-Received: by 2002:a05:600c:22d3:b0:432:7c08:d121 with SMTP id
 5b1f17b1804b1-432849fa03amr38481545e9.12.1730492034054; Fri, 01 Nov 2024
 13:13:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101030950.2677215-1-yonghong.song@linux.dev> <20241101031032.2680930-1-yonghong.song@linux.dev>
In-Reply-To: <20241101031032.2680930-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 1 Nov 2024 13:13:42 -0700
Message-ID: <CAADnVQKFG0x=3s=rK2uv19svnBdsegwsjcv7QESet-L8g3e7YA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 8/9] bpf: Support private stack for struct_ops progs
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 8:10=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> For struct_ops progs, whether a particular prog will use private stack
> or not (prog->aux->use_priv_stack) will be set before actual insn-level
> verification for that prog. One particular implementation is to
> piggyback on struct_ops->check_member(). The next patch will have an
> example for this. The struct_ops->check_member() will set
> prog->aux->use_priv_stack to be true which enables private stack
> usage with ignoring BPF_PRIV_STACK_MIN_SIZE limit.
>
> If use_priv_stack is true for a particular struct_ops prog, bpf
> trampoline will need to do recursion checks (one level at this point)
> to avoid stack overwrite. A field (recursion_skipped()) is added to
> bpf_prog_aux structure such that if bpf_prog->aux->recursion_skipped
> is set by the struct_ops subsystem, the function will be called
> to terminate the prog run, collect related info, etc.
>
> Acked-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  include/linux/bpf.h          |  1 +
>  include/linux/bpf_verifier.h |  1 +
>  kernel/bpf/trampoline.c      |  4 ++++
>  kernel/bpf/verifier.c        | 36 ++++++++++++++++++++++++++++++++----
>  4 files changed, 38 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 8a3ea7440a4a..7a34108c6974 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1528,6 +1528,7 @@ struct bpf_prog_aux {
>         u64 prog_array_member_cnt; /* counts how many times as member of =
prog_array */
>         struct mutex ext_mutex; /* mutex for is_extended and prog_array_m=
ember_cnt */
>         struct bpf_arena *arena;
> +       void (*recursion_skipped)(struct bpf_prog *prog); /* callback if =
recursion is skipped */

The name doesn't fit.
The recursion wasn't skipped.
It's the execution of the program that was skipped.
'recursion_detected' or 'recursion_disallowed' would be a better name.

>         /* BTF_KIND_FUNC_PROTO for valid attach_btf_id */
>         const struct btf_type *attach_func_proto;
>         /* function name for valid attach_btf_id */
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index bc28ce7996ac..ff0fba935f89 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -889,6 +889,7 @@ static inline bool bpf_prog_check_recur(const struct =
bpf_prog *prog)
>         case BPF_PROG_TYPE_TRACING:
>                 return prog->expected_attach_type !=3D BPF_TRACE_ITER;
>         case BPF_PROG_TYPE_STRUCT_OPS:
> +               return prog->aux->use_priv_stack;
>         case BPF_PROG_TYPE_LSM:
>                 return false;
>         default:
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index 9f36c049f4c2..a84e60efbf89 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -899,6 +899,8 @@ static u64 notrace __bpf_prog_enter_recur(struct bpf_=
prog *prog, struct bpf_tram
>
>         if (unlikely(this_cpu_inc_return(*(prog->active)) !=3D 1)) {
>                 bpf_prog_inc_misses_counter(prog);
> +               if (prog->aux->recursion_skipped)
> +                       prog->aux->recursion_skipped(prog);
>                 return 0;
>         }
>         return bpf_prog_start_time();
> @@ -975,6 +977,8 @@ u64 notrace __bpf_prog_enter_sleepable_recur(struct b=
pf_prog *prog,
>
>         if (unlikely(this_cpu_inc_return(*(prog->active)) !=3D 1)) {
>                 bpf_prog_inc_misses_counter(prog);
> +               if (prog->aux->recursion_skipped)
> +                       prog->aux->recursion_skipped(prog);
>                 return 0;
>         }
>         return bpf_prog_start_time();
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 30e74db6a85f..865191c5d21b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6023,17 +6023,31 @@ static int check_ptr_alignment(struct bpf_verifie=
r_env *env,
>
>  static int bpf_enable_priv_stack(struct bpf_verifier_env *env)
>  {
> +       bool force_priv_stack =3D env->prog->aux->use_priv_stack;
>         struct bpf_subprog_info *si;
> +       int ret;
> +
> +       if (!bpf_jit_supports_private_stack()) {
> +               if (force_priv_stack) {
> +                       verbose(env, "Private stack not supported by jit\=
n");
> +                       return -EACCES;
> +               }

This logic would fit better in the patch 2.
Less code churn and the whole approach is easier to understand.

I don't like this inband signaling.
Now I see why you had that weird <0 check in patch 2 :(
This is ugly.
May be it should be a separate bool request_priv_stack:1
that struct_ops callback will set and it will clean up
this logic.

>
> -       if (!bpf_jit_supports_private_stack())
>                 return NO_PRIV_STACK;
> +       }
>
> +       ret =3D PRIV_STACK_ADAPTIVE;
>         switch (env->prog->type) {
>         case BPF_PROG_TYPE_KPROBE:
>         case BPF_PROG_TYPE_TRACEPOINT:
>         case BPF_PROG_TYPE_PERF_EVENT:
>         case BPF_PROG_TYPE_RAW_TRACEPOINT:
>                 break;
> +       case BPF_PROG_TYPE_STRUCT_OPS:
> +               if (!force_priv_stack)
> +                       return NO_PRIV_STACK;
> +               ret =3D PRIV_STACK_ALWAYS;
> +               break;
>         case BPF_PROG_TYPE_TRACING:
>                 if (env->prog->expected_attach_type !=3D BPF_TRACE_ITER)
>                         break;
> @@ -6044,11 +6058,18 @@ static int bpf_enable_priv_stack(struct bpf_verif=
ier_env *env)
>
>         si =3D env->subprog_info;
>         for (int i =3D 0; i < env->subprog_cnt; i++) {
> -               if (si[i].has_tail_call)
> +               if (si[i].has_tail_call) {
> +                       if (ret =3D=3D PRIV_STACK_ALWAYS) {
> +                               verbose(env,
> +                                       "Private stack not supported due =
to tail call presence\n");
> +                               return -EACCES;

> +                       }
> +
>                         return NO_PRIV_STACK;
> +               }
>         }
>
> -       return PRIV_STACK_ADAPTIVE;
> +       return ret;
>  }
>
>  static int round_up_stack_depth(struct bpf_verifier_env *env, int stack_=
depth)
> @@ -6121,7 +6142,8 @@ static int check_max_stack_depth_subprog(struct bpf=
_verifier_env *env, int idx,
>                                         idx, subprog_depth);
>                                 return -EACCES;
>                         }
> -                       if (subprog_depth >=3D BPF_PRIV_STACK_MIN_SIZE) {
> +                       if (priv_stack_supported =3D=3D PRIV_STACK_ALWAYS=
 ||
> +                           subprog_depth >=3D BPF_PRIV_STACK_MIN_SIZE) {
>                                 subprog[idx].use_priv_stack =3D true;
>                                 subprog_visited[idx] =3D 1;
>                         }
> @@ -6271,6 +6293,12 @@ static int check_max_stack_depth(struct bpf_verifi=
er_env *env)
>                                 depth_frame, subtree_depth);
>                         return -EACCES;
>                 }
> +               if (orig_priv_stack_supported =3D=3D PRIV_STACK_ALWAYS) {
> +                       verbose(env,
> +                               "Private stack not supported due to possi=
ble nested subprog run\n");
> +                       ret =3D -EACCES;
> +                       goto out;
> +               }
>                 if (orig_priv_stack_supported =3D=3D PRIV_STACK_ADAPTIVE)=
 {
>                         for (int i =3D 0; i < env->subprog_cnt; i++)
>                                 si[i].use_priv_stack =3D false;
> --
> 2.43.5
>

