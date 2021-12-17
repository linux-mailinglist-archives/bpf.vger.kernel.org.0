Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C07DF4783CC
	for <lists+bpf@lfdr.de>; Fri, 17 Dec 2021 04:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbhLQDwp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Dec 2021 22:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbhLQDwp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Dec 2021 22:52:45 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50786C061574
        for <bpf@vger.kernel.org>; Thu, 16 Dec 2021 19:52:45 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id z6so738590plk.6
        for <bpf@vger.kernel.org>; Thu, 16 Dec 2021 19:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CJIpnOzefUFt+nL87mthtmqoVcfxJhjZyLYypQL34rg=;
        b=YwTQuagosUPjtMLOOdXfH8njOwxk5FhLv/1qcUDetJkryKNDDFy3vzTFIyuEyVRPxa
         d65UlA/3C8anETFQmdm8KQKINgaO/VXtfJipm8bIZwEaPEqkbxpiapelBHjCEh0WjtcN
         LuXQYX0wI8fLGnl9cbtzYEuOFDCHJII4w6jVIqHu0J9uDKtmiULUa4EmcfwyFuZ/qfg8
         Wfb+3WqSGhRKKYP1Ve2NvoNv4KKk/HiNdeouNHSzEMxkX2klXYPv6ZmUAVh+dA3+uj/D
         D/l8wtJGOGoLY59Aj5N4lXaEyB4A0rZRS+PU+mDyqUvXgF9vYCv2bxBV9QMdk0EK+/BP
         dF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CJIpnOzefUFt+nL87mthtmqoVcfxJhjZyLYypQL34rg=;
        b=KoiNLMQkQ9m0D2qhuTBbMYS5ap71DZsbR/qqfWPsoBBIpKQejaBdTSJEYi5jrkJ9f/
         FVXoFqiMCL0oLHDMpOnczKgmHfF6P7jZ36iXMp4ADkQJC/p53ZdqZEbM+RsVwBpRsW6v
         RV3qotP8CSTb+S6SVUvlPUGKQ7vKJGvPbkGCGCGY90s2WEvxZXznlhDtc8V9Vx0hceKE
         wff22njwvDOEKvPQelm9DiO0DJdk2gRT+A+AR9Ll5jXY9G5s42ulpU1IBSUXQIP6yxTa
         sP6u/M/c5PuY6MG2DuJTOoBY2UOIeYfN2q1dIvBLZAA1NefGzbyW+RnPk4v9q8cLG4d8
         r+JA==
X-Gm-Message-State: AOAM533L6f5p/OCcbGQcD6Lko8CFCHO5WKVYHYEAx/l69+ZnYrNupd6u
        HaAiPp+9vAUd7dIyC7g4APv2hgYZmu45t2dL4RY=
X-Google-Smtp-Source: ABdhPJwd2J/s9w5JlJ5ypP0zAOMh6UA/gimkHrOBxO78Bc8dPgBZMAEFMmQLXwFyiRpKgmEwwgws9g5VFfAsdkVMMl0=
X-Received: by 2002:a17:90b:4c03:: with SMTP id na3mr1565884pjb.62.1639713164745;
 Thu, 16 Dec 2021 19:52:44 -0800 (PST)
MIME-Version: 1.0
References: <20211216213358.3374427-1-christylee@fb.com> <20211216213358.3374427-3-christylee@fb.com>
In-Reply-To: <20211216213358.3374427-3-christylee@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 16 Dec 2021 19:52:33 -0800
Message-ID: <CAADnVQLpxiFYcPYgZoSq2-Sb1M910MpwhrpFs-x0E7Dcg27TWg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 2/3] Right align verifier states in verifier logs
To:     Christy Lee <christylee@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, christyc.y.lee@gmail.com,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 16, 2021 at 1:34 PM Christy Lee <christylee@fb.com> wrote:
> +static void print_insn_state(struct bpf_verifier_env *env,
> +                            const struct bpf_func_state *state)
> +{
> +       if (env->prev_log_len && (env->prev_log_len == env->log.len_used)) {

redundant ()

> +               /* remove new line character*/

missing ' ' before */

> +               bpf_vlog_reset(&env->log, env->prev_log_len - 1);
> +               verbose(env, "%*c;", vlog_alignment(env->prev_insn_print_len), ' ');
> +       } else {
> +               verbose(env, "%d:", env->insn_idx);
> +       }
> +       print_verifier_state(env, state, false);
> +}
> +
>  /* copy array src of length n * size bytes to dst. dst is reallocated if it's too
>   * small to hold src. This is different from krealloc since we don't want to preserve
>   * the contents of dst.
> @@ -2724,10 +2743,10 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno,
>                         reg->precise = true;
>                 }
>                 if (env->log.level & BPF_LOG_LEVEL) {
> -                       print_verifier_state(env, func, false);
> -                       verbose(env, "parent %s regs=%x stack=%llx marks\n",
> +                       verbose(env, "parent %s regs=%x stack=%llx marks:",
>                                 new_marks ? "didn't have" : "already had",
>                                 reg_mask, stack_mask);
> +                       print_verifier_state(env, func, true);
>                 }
>
>                 if (!reg_mask && !stack_mask)
> @@ -3422,11 +3441,8 @@ static int check_mem_region_access(struct bpf_verifier_env *env, u32 regno,
>         /* We may have adjusted the register pointing to memory region, so we
>          * need to try adding each of min_value and max_value to off
>          * to make sure our theoretical access will be safe.
> -        */
> -       if (env->log.level & BPF_LOG_LEVEL)
> -               print_verifier_state(env, state, false);
> -
> -       /* The minimum value is only important with signed
> +        *
> +        * The minimum value is only important with signed
>          * comparisons where we can't assume the floor of a
>          * value is 0.  If we are using signed variables for our
>          * index'es we need to make sure that whatever we use
> @@ -4565,6 +4581,8 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
>
>  static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_insn *insn)
>  {
> +       struct bpf_verifier_state *vstate = env->cur_state;
> +       struct bpf_func_state *state = vstate->frame[vstate->curframe];
>         int load_reg;
>         int err;
>
> @@ -4651,6 +4669,9 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
>         if (err)
>                 return err;
>
> +       if (env->log.level & BPF_LOG_LEVEL)
> +               print_insn_state(env, state);
> +

I couldn't figure out why check_atomic() is special
when the main loop in do_check() is doing it anyway.
So I've removed this hunk and one above.

> -               if ((env->log.level & BPF_LOG_LEVEL2) ||
> -                   (env->log.level & BPF_LOG_LEVEL && do_print_state)) {
> -                       if (verifier_state_scratched(env) &&
> -                           (env->log.level & BPF_LOG_LEVEL2))
> -                               verbose(env, "%d:", env->insn_idx);
> -                       else
> -                               verbose(env, "\nfrom %d to %d%s:",
> -                                       env->prev_insn_idx, env->insn_idx,
> -                                       env->cur_state->speculative ?
> -                                       " (speculative execution)" : "");
> -                       print_verifier_state(env, state->frame[state->curframe],
> -                                            false);
> +               if ((env->log.level & BPF_LOG_LEVEL1) && do_print_state) {

redundant ()

> +                       verbose(env, "\nfrom %d to %d%s:\n", env->prev_insn_idx,
> +                               env->insn_idx, env->cur_state->speculative ?
> +                               " (speculative execution)" : "");

Due to vlog_reset at log_level=1 "from %d to %d"
is not seen anymore.
So it should be LEVEL2 instead of LEVEL1.
Then this 'from %d to %d' becomes meaningful in full verifier log.

> @@ -11328,9 +11340,16 @@ static int do_check(struct bpf_verifier_env *env)
>                                 .private_data   = env,
>                         };
>
> +                       if (verifier_state_scratched(env))
> +                               print_insn_state(env, state->frame[state->curframe]);
> +
>                         verbose_linfo(env, env->insn_idx, "; ");
> +                       env->prev_log_len = env->log.len_used;
>                         verbose(env, "%d: ", env->insn_idx);
>                         print_bpf_insn(&cbs, insn, env->allow_ptr_leaks);
> +                       env->prev_insn_print_len =
> +                               env->log.len_used - env->prev_log_len;

no need to wrap the line.

I fixed it all up while applying.
