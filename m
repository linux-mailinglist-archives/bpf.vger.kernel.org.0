Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63ACA314103
	for <lists+bpf@lfdr.de>; Mon,  8 Feb 2021 21:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbhBHUyp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Feb 2021 15:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233747AbhBHUwI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Feb 2021 15:52:08 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695CCC06178C
        for <bpf@vger.kernel.org>; Mon,  8 Feb 2021 12:51:28 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id e132so15939796ybh.8
        for <bpf@vger.kernel.org>; Mon, 08 Feb 2021 12:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=klK20eL0+Zt94T//ZzFU76bgYoH399Ue8l1nzl5walo=;
        b=p4r2nciLeEOF20BvmHqPfTXJdPWqngfFYBYRar47aI++NAck5icgYcTMwtZltqBIsZ
         QY36rtqhcPA6N1AY/3KsbC4YLKAnRpKjyXOG5uTWwEIzfM42eo6UmrR+kiyWXEmY4aGm
         l/GIS9z/DTDMuB9yZqFgj2f0L+hJLqbKAZ2MFdjaoyetkKZwAwufu4TGCQJVwRIARqbQ
         yqelHL6DNcOqPFioxWsBg6GL4BVvqx0ivtfg8tR7PI0tBulWj1m6OKZ6icTGgU9lHMNw
         xHjLY0sQiUjKfal64SJtwhA0Dy6tlHoFI0wUABop4Bf9EHU6oan/VrQEqV1qghyetbU0
         eExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=klK20eL0+Zt94T//ZzFU76bgYoH399Ue8l1nzl5walo=;
        b=AVDsuwhMvL+dzHthZjQ5ozLdw5xER+kNjuVhJmY82lg0BpIdkewlvvs18U2A0TdCEn
         tpG9DDHDNdOY/l2EC5pTwWwu+fR0NsRpAkMOMtXosR4xftWfEWJjxcEsv1WJtVgzlfZ7
         oD2/hUHGXqJ1tDKDKFUVC0GzHTJwCK1O6QPDj1tzn+s1WxbjYzh2IxuvEriNTgw0dZbh
         93nxnMUnifvdRnKSUzySHUKgZp6gU6sMqeN24OW882aauG9KZfHEBtTP9Re4y5tmFHBT
         APkik7/2JMAwsUUmPL9G23yG4HwFOuNQcDkK9EPokgT93PNR0qXaW+f0xpo1ClSn9gDI
         j2Pg==
X-Gm-Message-State: AOAM5331lq696wcSuGuJvM8K2HpUiJwHn5O6woThcV5idZ6nyLgTg8Ir
        +VCoFcFZCx8EuQ6jabDJlNx/KqUXoe0UYUghhsY=
X-Google-Smtp-Source: ABdhPJyy/FrgAFFesjXa6H7J+/1knOKQcGi7b6hVaOz8fmk9LiiLS3DvZprfAXqJBm7g36qPC0Twz8R7hZ0Jp12TUTw=
X-Received: by 2002:a25:3805:: with SMTP id f5mr11183228yba.27.1612817485804;
 Mon, 08 Feb 2021 12:51:25 -0800 (PST)
MIME-Version: 1.0
References: <20210206170344.78399-1-alexei.starovoitov@gmail.com> <20210206170344.78399-4-alexei.starovoitov@gmail.com>
In-Reply-To: <20210206170344.78399-4-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 8 Feb 2021 12:51:14 -0800
Message-ID: <CAEf4Bzb1D9AzOU2Zn2DkZrP+VYOPuJ-7xFcEF1unTr6SutMSWg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 3/7] bpf: Add per-program recursion prevention mechanism
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
> Since both sleepable and non-sleepable programs execute under migrate_disable
> add recursion prevention mechanism to both types of programs when they're
> executed via bpf trampoline.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  arch/x86/net/bpf_jit_comp.c                   | 15 +++++++++++++
>  include/linux/bpf.h                           |  6 ++---
>  include/linux/filter.h                        |  1 +
>  kernel/bpf/core.c                             |  8 +++++++
>  kernel/bpf/trampoline.c                       | 22 ++++++++++++++-----
>  .../selftests/bpf/prog_tests/fexit_stress.c   |  2 +-
>  .../bpf/prog_tests/trampoline_count.c         |  4 ++--
>  7 files changed, 47 insertions(+), 11 deletions(-)
>

[...]

> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index b1f567514b7e..226f613ab289 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -388,16 +388,21 @@ void bpf_trampoline_put(struct bpf_trampoline *tr)
>   * call prog->bpf_func
>   * call __bpf_prog_exit
>   */
> -#define NO_START_TIME 0
> -u64 notrace __bpf_prog_enter(void)
> +#define NO_START_TIME 1
> +u64 notrace __bpf_prog_enter(struct bpf_prog *prog)
>         __acquires(RCU)
>  {
>         u64 start = NO_START_TIME;
>
>         rcu_read_lock();
>         migrate_disable();
> -       if (static_branch_unlikely(&bpf_stats_enabled_key))
> +       if (unlikely(__this_cpu_inc_return(*(prog->active)) != 1))
> +               return 0;
> +       if (static_branch_unlikely(&bpf_stats_enabled_key)) {
>                 start = sched_clock();
> +               if (unlikely(!start))
> +                       start = NO_START_TIME;
> +       }
>         return start;
>  }
>
> @@ -425,25 +430,32 @@ void notrace __bpf_prog_exit(struct bpf_prog *prog, u64 start)
>         __releases(RCU)
>  {
>         update_prog_stats(prog, start);
> +       __this_cpu_dec(*(prog->active));
>         migrate_enable();
>         rcu_read_unlock();
>  }
>
> -u64 notrace __bpf_prog_enter_sleepable(void)
> +u64 notrace __bpf_prog_enter_sleepable(struct bpf_prog *prog)
>  {
>         u64 start = NO_START_TIME;
>
>         rcu_read_lock_trace();
>         migrate_disable();
>         might_fault();
> -       if (static_branch_unlikely(&bpf_stats_enabled_key))
> +       if (unlikely(__this_cpu_inc_return(*(prog->active)) != 1))
> +               return 0;
> +       if (static_branch_unlikely(&bpf_stats_enabled_key)) {
>                 start = sched_clock();
> +               if (unlikely(!start))
> +                       start = NO_START_TIME;
> +       }
>         return start;


maybe extract this piece into a function, so that enter functions
would look like:

...
if (unlikely(__this_cpu_inc_return(*(prog->active)) != 1))
         return 0;
return bpf_prog_start_time();

no need for u64 start initialization, more linear code, and no
duplication of logic?

Oh, and actually, given you have `start > NO_START_TIME` condition in
exit function, you don't need this `if (unlikely(!start))` bit at all,
because you are going to ignore both 0 and 1. So maybe no need for a
new function, but no need for extra if as well.

>  }
>
>  void notrace __bpf_prog_exit_sleepable(struct bpf_prog *prog, u64 start)
>  {
>         update_prog_stats(prog, start);
> +       __this_cpu_dec(*(prog->active));
>         migrate_enable();
>         rcu_read_unlock_trace();
>  }
> diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_stress.c b/tools/testing/selftests/bpf/prog_tests/fexit_stress.c
> index 3b9dbf7433f0..4698b0d2de36 100644
> --- a/tools/testing/selftests/bpf/prog_tests/fexit_stress.c
> +++ b/tools/testing/selftests/bpf/prog_tests/fexit_stress.c
> @@ -3,7 +3,7 @@
>  #include <test_progs.h>
>
>  /* x86-64 fits 55 JITed and 43 interpreted progs into half page */

Probably the comment is a bit outdated now forcing you to decrease CNT?

> -#define CNT 40
> +#define CNT 38
>
>  void test_fexit_stress(void)
>  {
> diff --git a/tools/testing/selftests/bpf/prog_tests/trampoline_count.c b/tools/testing/selftests/bpf/prog_tests/trampoline_count.c
> index 781c8d11604b..f3022d934e2d 100644
> --- a/tools/testing/selftests/bpf/prog_tests/trampoline_count.c
> +++ b/tools/testing/selftests/bpf/prog_tests/trampoline_count.c
> @@ -4,7 +4,7 @@
>  #include <sys/prctl.h>
>  #include <test_progs.h>
>
> -#define MAX_TRAMP_PROGS 40
> +#define MAX_TRAMP_PROGS 38
>
>  struct inst {
>         struct bpf_object *obj;
> @@ -52,7 +52,7 @@ void test_trampoline_count(void)
>         struct bpf_link *link;
>         char comm[16] = {};
>
> -       /* attach 'allowed' 40 trampoline programs */
> +       /* attach 'allowed' trampoline programs */
>         for (i = 0; i < MAX_TRAMP_PROGS; i++) {
>                 obj = bpf_object__open_file(object, NULL);
>                 if (CHECK(IS_ERR(obj), "obj_open_file", "err %ld\n", PTR_ERR(obj))) {
> --
> 2.24.1
>
