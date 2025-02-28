Return-Path: <bpf+bounces-52934-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9CCA4A693
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 00:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 192F23B9B74
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 23:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78181DE8AB;
	Fri, 28 Feb 2025 23:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOc5N44u"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97D51DE4F3
	for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 23:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740784736; cv=none; b=F/Wwv8MUOgkY6W4xX9Lkc/Bs6CyVuIMXh0foXSsyOlqVNLIBVS1jP0inN+OL+Nxxl2JHAxI88+2NP36CkQzrLK6OLS3odStR1ZcykrCmjos4u66My2LWp9ixtG0ZT9MTXxUcvlWXjpJPiLGfjAF/2rFfrJtDWORs83ZNnvWr7BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740784736; c=relaxed/simple;
	bh=+0j/VDq5yMKOUZ3L5pmZTm1/1JwFAR5DFIc32kGtIeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cpJaPJzoqIMy1LEShKFmPqzKjyli6PLAM0KBNXPFn634WoW6qJZiop6pe4oZxwDFhXCn78L2yZqyWDhQnobbUA9VquGs32b1lJSM91VZ5wN/eW+j6Xj6Ue6r9kv6UXSYw8vhLT6e4Aq5EM+bC2pD2KfSXWKTDQoyLrFzfUaKiKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JOc5N44u; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2f83a8afcbbso4818097a91.1
        for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 15:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740784734; x=1741389534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zam8dK8wkfrnIDGfEnkxEuzwT3S14Xe18txrKm97jSg=;
        b=JOc5N44uAC/4zz53oOG+ptuRnhtvMVVikYJJk+xZyJsiZR89IzC2V9DmwwaDxoPs6o
         p9EUBgVCZ9SUQVbTo8E4V7XR68jE5a/yfBZ/sbWEVBLDKKdY0zf0uEoAQqNZ0+BoYjvc
         ktDiTev/4UgIAJSVn63rdcSs1Ddhg5118grd/9XUB2DlnzHFUiThE5apCQxQtKVmRQ4g
         awg/baQ/Do5Mh9rcTeB9LVe+39zU3xoTBfpQJ3HmyWfkphX8rCAAH4GiiShKCtNi6D1H
         +Xcx6H7XCpf+oJxeHHhLIyGbqfBnlEnUY567Ez+e78pD1z3XI6z4L8W+nyaiu0i7UB/C
         Pi7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740784734; x=1741389534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zam8dK8wkfrnIDGfEnkxEuzwT3S14Xe18txrKm97jSg=;
        b=erwaj+PAcDZSOWekZKqRUm7Xp9bTGm9vE4TuHuceqqichrDjEee6RlMmmO7LQOzbt6
         4myG7VvEcGcclV/J6Xu1b4F0vuehCbWKYsU+BG+0jXeJ0MdCdMPe1YsmT277PN8O1UVv
         mvCiXcyRuaEC9lMDEp9+EGgqVDeUaOVLr1BCbMkLb3X4NunfBqozn/d2aHFw+myYToY3
         kQ+dKHNDljz8SEFfTb5N1ZOdZHjok2bMR2rI1UiuN+wDyJ8qoFBW3YqhYRSKfx/lT7kY
         AD5UGXqn/aNnKFyl8zrTwVHZgA3m4hRL8rzEh/PgZsd+fRot85LmZc6fDHNGlceOX7KN
         We8Q==
X-Gm-Message-State: AOJu0Ywu4Ldo7MsonwNav1nmVui0+eItZdFnJZCpiyLX8aIusWmO/jxU
	AhU9OCVqWXpibm77wusZBv00G8q8dmCGHI3eU0F5xbeiSO/RRRsCQK1+P7m5W1ShUY5uNtKRXHQ
	+m8Los7zPph3X6XsYG1Dtj6V2ArI=
X-Gm-Gg: ASbGncuyKJ3rKKIxPGZBBh4CRH9X8IUfrD8WPZvaZJILkF8e6hzU9ADoY5+jSCfsChC
	/w/ZjJlVO4Re/bldYTZXjJkqE1N23zD9PcLayZv6einxuEllbjmqtRyeKQQfHPNoi7/YjSP3bMO
	pDS+4QGkRIyO/wopeyDIyhuQnNI9QepvbXWUYdvSl1Dg==
X-Google-Smtp-Source: AGHT+IHROYAxieSOuEtVlkaSl07/w7yC13DXAzitgomMggiAZ5EpVDSb7GqKmf0E6LfLu5FYK8yJiZf9NIvh7TURXpI=
X-Received: by 2002:a17:90b:2247:b0:2ee:ee77:226d with SMTP id
 98e67ed59e1d1-2feba5cecd5mr8688868a91.4.1740784733811; Fri, 28 Feb 2025
 15:18:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228162858.1073529-1-memxor@gmail.com> <20250228162858.1073529-2-memxor@gmail.com>
In-Reply-To: <20250228162858.1073529-2-memxor@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 28 Feb 2025 15:18:42 -0800
X-Gm-Features: AQ5f1JrgmZS6FOiEwlEt-Ccf7WxE_lpCGLxcpAnO5ahMRZLB8pm5MPCKZn-Sxy4
Message-ID: <CAEf4BzZ_UQVtOhE3SRvHBE3NyCwfdFCxmiAPPNbLArZVQT6oZg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Summarize sleepable global subprogs
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 8:29=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> The verifier currently does not permit global subprog calls when a lock
> is held, preemption is disabled, or when IRQs are disabled. This is
> because we don't know whether the global subprog calls sleepable
> functions or not.
>
> In case of locks, there's an additional reason: functions called by the
> global subprog may hold additional locks etc. The verifier won't know
> while verifying the global subprog whether it was called in context
> where a spin lock is already held by the program.
>
> Perform summarization of the sleepable nature of a global subprog just
> like changes_pkt_data and then allow calls to global subprogs for
> non-sleepable ones from atomic context.
>
> While making this change, I noticed that RCU read sections had no
> protection against sleepable global subprog calls, include it in the
> checks and fix this while we're at it.
>
> Care needs to be taken to not allow global subprog calls when regular
> bpf_spin_lock is held. When resilient spin locks is held, we want to
> potentially have this check relaxed, but not for now.
>
> Tests are included in the next patch to handle all special conditions.
>
> Fixes: 9bb00b2895cb ("bpf: Add kfunc bpf_rcu_read_lock/unlock()")
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  include/linux/bpf_verifier.h |  1 +
>  kernel/bpf/verifier.c        | 50 ++++++++++++++++++++++++++----------
>  2 files changed, 37 insertions(+), 14 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index bbd013c38ff9..1b3cfa6cb720 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -667,6 +667,7 @@ struct bpf_subprog_info {
>         /* true if bpf_fastcall stack region is used by functions that ca=
n't be inlined */
>         bool keep_fastcall_stack: 1;
>         bool changes_pkt_data: 1;
> +       bool sleepable: 1;
>
>         enum priv_stack_mode priv_stack_mode;
>         u8 arg_cnt;
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index dcd0da4e62fc..e3560d19d513 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10317,23 +10317,18 @@ static int check_func_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
>         if (subprog_is_global(env, subprog)) {
>                 const char *sub_name =3D subprog_name(env, subprog);
>
> -               /* Only global subprogs cannot be called with a lock held=
. */
>                 if (env->cur_state->active_locks) {
>                         verbose(env, "global function calls are not allow=
ed while holding a lock,\n"
>                                      "use static function instead\n");
>                         return -EINVAL;
>                 }
>
> -               /* Only global subprogs cannot be called with preemption =
disabled. */
> -               if (env->cur_state->active_preempt_locks) {
> -                       verbose(env, "global function calls are not allow=
ed with preemption disabled,\n"
> -                                    "use static function instead\n");
> -                       return -EINVAL;
> -               }
> -
> -               if (env->cur_state->active_irq_id) {
> -                       verbose(env, "global function calls are not allow=
ed with IRQs disabled,\n"
> -                                    "use static function instead\n");
> +               if (env->subprog_info[subprog].sleepable &&
> +                   (env->cur_state->active_rcu_lock || env->cur_state->a=
ctive_preempt_locks ||
> +                    env->cur_state->active_irq_id || !in_sleepable(env))=
) {
> +                       verbose(env, "global functions that may sleep are=
 not allowed in non-sleepable context,\n"
> +                                    "i.e., in a RCU/IRQ/preempt-disabled=
 section, or in\n"
> +                                    "a non-sleepable BPF program context=
\n");
>                         return -EINVAL;
>                 }
>
> @@ -16703,6 +16698,14 @@ static void mark_subprog_changes_pkt_data(struct=
 bpf_verifier_env *env, int off)
>         subprog->changes_pkt_data =3D true;
>  }
>
> +static void mark_subprog_sleepable(struct bpf_verifier_env *env, int off=
)
> +{
> +       struct bpf_subprog_info *subprog;
> +
> +       subprog =3D find_containing_subprog(env, off);
> +       subprog->sleepable =3D true;
> +}
> +
>  /* 't' is an index of a call-site.
>   * 'w' is a callee entry point.
>   * Eventually this function would be called when env->cfg.insn_state[w] =
=3D=3D EXPLORED.
> @@ -16716,6 +16719,7 @@ static void merge_callee_effects(struct bpf_verif=
ier_env *env, int t, int w)
>         caller =3D find_containing_subprog(env, t);
>         callee =3D find_containing_subprog(env, w);
>         caller->changes_pkt_data |=3D callee->changes_pkt_data;
> +       caller->sleepable |=3D callee->sleepable;
>  }
>
>  /* non-recursive DFS pseudo code
> @@ -17183,9 +17187,20 @@ static int visit_insn(int t, struct bpf_verifier=
_env *env)
>                         mark_prune_point(env, t);
>                         mark_jmp_point(env, t);
>                 }
> -               if (bpf_helper_call(insn) && bpf_helper_changes_pkt_data(=
insn->imm))
> -                       mark_subprog_changes_pkt_data(env, t);
> -               if (insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL) {
> +               if (bpf_helper_call(insn)) {
> +                       const struct bpf_func_proto *fp;
> +
> +                       ret =3D get_helper_proto(env, insn->imm, &fp);
> +                       /* If called in a non-sleepable context program w=
ill be
> +                        * rejected anyway, so we should end up with prec=
ise
> +                        * sleepable marks on subprogs, except for dead c=
ode
> +                        * elimination.

TBH, I'm worried that we are regressing to doing all these side effect
analyses disregarding dead code elimination. It's not something
hypothetical to have an .rodata variable controlling whether, say, to
do bpf_probe_read_user() (non-sleepable) vs bpf_copy_from_user()
(sleepable) inside global subprog, depending on some outside
configuration (e.g., whether we'll be doing SEC("iter.s/task") or it's
actually profiler logic called inside SEC("perf_event"), all
controlled by user-space). We do have use cases like this in
production already, and this dead code elimination is important in
such cases. Probably can be worked around with more global functions
and stuff like that, but still, it's worrying we are giving up on such
an important part of the BPF CO-RE approach - disabling parts of code
"dynamically" before loading BPF programs.

> +                        */
> +                       if (ret =3D=3D 0 && fp->might_sleep)
> +                               mark_subprog_sleepable(env, t);
> +                       if (bpf_helper_changes_pkt_data(insn->imm))
> +                               mark_subprog_changes_pkt_data(env, t);
> +               } else if (insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL) {
>                         struct bpf_kfunc_call_arg_meta meta;
>
>                         ret =3D fetch_kfunc_meta(env, insn, &meta, NULL);
> @@ -17204,6 +17219,13 @@ static int visit_insn(int t, struct bpf_verifier=
_env *env)
>                                  */
>                                 mark_force_checkpoint(env, t);
>                         }
> +                       /* Same as helpers, if called in a non-sleepable =
context
> +                        * program will be rejected anyway, so we should =
end up
> +                        * with precise sleepable marks on subprogs, exce=
pt for
> +                        * dead code elimination.
> +                        */
> +                       if (ret =3D=3D 0 && is_kfunc_sleepable(&meta))
> +                               mark_subprog_sleepable(env, t);
>                 }
>                 return visit_func_call_insn(t, insns, env, insn->src_reg =
=3D=3D BPF_PSEUDO_CALL);
>
> --
> 2.43.5
>

