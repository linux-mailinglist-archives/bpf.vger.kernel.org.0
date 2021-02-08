Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6E831409D
	for <lists+bpf@lfdr.de>; Mon,  8 Feb 2021 21:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbhBHUhO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Feb 2021 15:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbhBHUge (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Feb 2021 15:36:34 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2454C061786
        for <bpf@vger.kernel.org>; Mon,  8 Feb 2021 12:35:50 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id m76so15946760ybf.0
        for <bpf@vger.kernel.org>; Mon, 08 Feb 2021 12:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nW2qLv4P+ELaCEQDSEa8aD195GqQR8KeBcLIkVFipd8=;
        b=YsBkxEoeORqQKHXGWCfNHd4tmqM1ZnNLVo8724axQQN3ExIQiNN6gBnGvofHo0xOHe
         gNMHjLf/jJzrsqlZIMzXA6QTkCLmh/4aGz8Ye6N4WTMlYj2nquvdkf3Uig/OZaTkhvv1
         JEzcNpSwzhNR12vd/URMkBbtVT9WIrLAQGpEx3DyXhqTWunUkI2HIn/fvRs4bX4G/m4Z
         d2Q45Xl8q1s8kvo7m/+vQxTAwG0qb7oxc1rYeNzsfF69Mu9G2daoZAX4y5AqvDjns30Z
         d2ZOCRe6gRGAnJm2ZrvlJwBMSmCEchapKSy1sglKo7ssibTrmTrK3LGa80ooSJgnMyDU
         mMKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nW2qLv4P+ELaCEQDSEa8aD195GqQR8KeBcLIkVFipd8=;
        b=WX5hwBOndEqnulV4gWDEQ85WI/XrZ/W+1qsTkXX6pycDPsCQV0parf10r08bthP5Ti
         xo3dUJ6lSnH1/XMKI+dUpIl0OoEb12rk3KVHzp5uBSfbSRGJQoQtTjEQx1JKR6j3mj8r
         WuHpWufJ8J024HPEu0Wz696+JHLdthK5yNvreUQKMR+qGXNLh3fiJUsThHTQhrM0vYKe
         hP9KGIp0UsfxCU5BlJSdB9lst7MmEAl+pZpIt6nzCJLUhKlZl+V2ik1itwb6b3ZzTFjK
         QYn33aCguzni/CeEu29pifvnfP4z9OD5AnvMlsuv0T6uXsJSKeanbDkDGo87qjZPJgV+
         x5qA==
X-Gm-Message-State: AOAM531rmMitw/RQB2VGhozUKrF58S6lkNu1PzTRhIpBijlHrPj79AaQ
        i9x9VOAZttXjIth9Q1dxywKL70jiDV9QtWAGlX5pnJpD7hcs4w==
X-Google-Smtp-Source: ABdhPJwQRClbCXZ0NtL85TZOQQUmKacC+To72plVA6RhMyuoVs19c3TsiS79EZKrMKKrZpF1Tfy6q5cptcXbzHTAEzM=
X-Received: by 2002:a25:4b86:: with SMTP id y128mr27780915yba.403.1612816550149;
 Mon, 08 Feb 2021 12:35:50 -0800 (PST)
MIME-Version: 1.0
References: <20210206170344.78399-1-alexei.starovoitov@gmail.com> <20210206170344.78399-3-alexei.starovoitov@gmail.com>
In-Reply-To: <20210206170344.78399-3-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 8 Feb 2021 12:35:39 -0800
Message-ID: <CAEf4Bzaoqt7ByRRrfdRUXvP+WKmK2bwncCrTVCL+A9bZLEYCWw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/7] bpf: Compute program stats for sleepable programs
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Feb 6, 2021 at 9:05 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> In older non-RT kernels migrate_disable() was the same as preempt_disable().
> Since commit 74d862b682f5 ("sched: Make migrate_disable/enable() independent of RT")
> migrate_disable() is real and doesn't prevent sleeping.
> Use it to efficiently compute execution stats for sleepable bpf programs.
> migrate_disable() will also be used to enable per-cpu maps in sleepable programs
> in the future patches.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

LGTM (see comment about outdated comment).

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  arch/x86/net/bpf_jit_comp.c | 31 ++++++++++++-------------------
>  include/linux/bpf.h         |  4 ++--
>  kernel/bpf/trampoline.c     | 27 +++++++++++++++++++++------
>  3 files changed, 35 insertions(+), 27 deletions(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index a3dc3bd154ac..d11b9bcebbea 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -1742,15 +1742,12 @@ static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
>         u8 *prog = *pprog;
>         int cnt = 0;
>
> -       if (p->aux->sleepable) {
> -               if (emit_call(&prog, __bpf_prog_enter_sleepable, prog))
> +       if (emit_call(&prog,
> +                     p->aux->sleepable ? __bpf_prog_enter_sleepable :
> +                     __bpf_prog_enter, prog))
>                         return -EINVAL;
> -       } else {
> -               if (emit_call(&prog, __bpf_prog_enter, prog))
> -                       return -EINVAL;
> -               /* remember prog start time returned by __bpf_prog_enter */
> -               emit_mov_reg(&prog, true, BPF_REG_6, BPF_REG_0);
> -       }
> +       /* remember prog start time returned by __bpf_prog_enter */
> +       emit_mov_reg(&prog, true, BPF_REG_6, BPF_REG_0);
>
>         /* arg1: lea rdi, [rbp - stack_size] */
>         EMIT4(0x48, 0x8D, 0x7D, -stack_size);
> @@ -1770,18 +1767,14 @@ static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
>         if (mod_ret)
>                 emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -8);
>
> -       if (p->aux->sleepable) {
> -               if (emit_call(&prog, __bpf_prog_exit_sleepable, prog))
> +       /* arg1: mov rdi, progs[i] */
> +       emit_mov_imm64(&prog, BPF_REG_1, (long) p >> 32, (u32) (long) p);
> +       /* arg2: mov rsi, rbx <- start time in nsec */
> +       emit_mov_reg(&prog, true, BPF_REG_2, BPF_REG_6);
> +       if (emit_call(&prog,
> +                     p->aux->sleepable ? __bpf_prog_exit_sleepable :
> +                     __bpf_prog_exit, prog))
>                         return -EINVAL;
> -       } else {
> -               /* arg1: mov rdi, progs[i] */
> -               emit_mov_imm64(&prog, BPF_REG_1, (long) p >> 32,
> -                              (u32) (long) p);
> -               /* arg2: mov rsi, rbx <- start time in nsec */
> -               emit_mov_reg(&prog, true, BPF_REG_2, BPF_REG_6);
> -               if (emit_call(&prog, __bpf_prog_exit, prog))
> -                       return -EINVAL;
> -       }
>
>         *pprog = prog;
>         return 0;
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 026fa8873c5d..2fa48439ef31 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -563,8 +563,8 @@ int arch_prepare_bpf_trampoline(void *image, void *image_end,
>  /* these two functions are called from generated trampoline */
>  u64 notrace __bpf_prog_enter(void);
>  void notrace __bpf_prog_exit(struct bpf_prog *prog, u64 start);
> -void notrace __bpf_prog_enter_sleepable(void);
> -void notrace __bpf_prog_exit_sleepable(void);
> +u64 notrace __bpf_prog_enter_sleepable(void);
> +void notrace __bpf_prog_exit_sleepable(struct bpf_prog *prog, u64 start);
>
>  struct bpf_ksym {
>         unsigned long            start;
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index 5be3beeedd74..b1f567514b7e 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -388,10 +388,11 @@ void bpf_trampoline_put(struct bpf_trampoline *tr)
>   * call prog->bpf_func
>   * call __bpf_prog_exit
>   */
> +#define NO_START_TIME 0
>  u64 notrace __bpf_prog_enter(void)
>         __acquires(RCU)
>  {
> -       u64 start = 0;
> +       u64 start = NO_START_TIME;
>
>         rcu_read_lock();
>         migrate_disable();
> @@ -400,8 +401,8 @@ u64 notrace __bpf_prog_enter(void)
>         return start;
>  }
>
> -void notrace __bpf_prog_exit(struct bpf_prog *prog, u64 start)
> -       __releases(RCU)
> +static void notrace update_prog_stats(struct bpf_prog *prog,
> +                                     u64 start)
>  {
>         struct bpf_prog_stats *stats;
>
> @@ -411,25 +412,39 @@ void notrace __bpf_prog_exit(struct bpf_prog *prog, u64 start)
>              * And vice versa.
>              * Hence check that 'start' is not zero.

This comment still references __bpf_prog_enter and __bpf_prog_exit
(only). See for yourself if it needs to be updated.

>              */
> -           start) {
> +           start > NO_START_TIME) {
>                 stats = this_cpu_ptr(prog->stats);
>                 u64_stats_update_begin(&stats->syncp);
>                 stats->cnt++;
>                 stats->nsecs += sched_clock() - start;
>                 u64_stats_update_end(&stats->syncp);
>         }
> +}
> +
> +void notrace __bpf_prog_exit(struct bpf_prog *prog, u64 start)
> +       __releases(RCU)
> +{
> +       update_prog_stats(prog, start);
>         migrate_enable();
>         rcu_read_unlock();
>  }
>
> -void notrace __bpf_prog_enter_sleepable(void)
> +u64 notrace __bpf_prog_enter_sleepable(void)
>  {
> +       u64 start = NO_START_TIME;
> +
>         rcu_read_lock_trace();
> +       migrate_disable();
>         might_fault();
> +       if (static_branch_unlikely(&bpf_stats_enabled_key))
> +               start = sched_clock();
> +       return start;
>  }
>
> -void notrace __bpf_prog_exit_sleepable(void)
> +void notrace __bpf_prog_exit_sleepable(struct bpf_prog *prog, u64 start)
>  {
> +       update_prog_stats(prog, start);
> +       migrate_enable();
>         rcu_read_unlock_trace();
>  }
>
> --
> 2.24.1
>
