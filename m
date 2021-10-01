Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3209C41E63E
	for <lists+bpf@lfdr.de>; Fri,  1 Oct 2021 05:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbhJADhz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Sep 2021 23:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbhJADhy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Sep 2021 23:37:54 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B72BC06176A;
        Thu, 30 Sep 2021 20:36:11 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id dj4so30622552edb.5;
        Thu, 30 Sep 2021 20:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jkp98q2ixpv2/VB9hqcJl2RHzO1J0JRn3M5buNc2nMU=;
        b=DovXkrN/rEmoX6kPkslXaKGObhyDRIbHo65GlK4pUJ4BXkN3mLqguDkwH9C3rMzdkc
         HBoIpZDQx2u3lBK+K3hEMbphH7pgx9n9JotlDOKI0PKC+zkjgG7oPebZLkdzwMKsgOO7
         iqa9+RMO0xlVxz3i3i7cj9wgq5Eaj9vSdnWDO0RmbVLAIYPpCZjZf/LIuYecv0mNP7YU
         Y7fqcbS48QR1TSJnOku9ygQKx6oE7BeQmrI9ut9VUZw6rjmGb1petKtHB2HKhp8m7n3B
         TDFKPggJDQ76BE3cHYUTv4aVCz/MaeGDomXKwXKCwxKgfUbENTBMXYKcMONXg/ovu3MG
         yNBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jkp98q2ixpv2/VB9hqcJl2RHzO1J0JRn3M5buNc2nMU=;
        b=N69ZpmPtiDVGm4Vb7varO68oWKQ+3MGvRjVZE8uU8H3LyqpP5x+ATztl4PG0AcMDAN
         PcRDUKOYp9UfZ0EwSxxDZroAkEqKET6O/H8lSX5T4iOxRwWP1gMV/Kuye2ZfJ+jh+6lL
         6WSjkoq2ysyd0ws5OZqlUovM5UVy/1Iq/rnBfKIk2ES7O/HZCD008ukAvEKDDP3lXhTB
         ZPG6VK2fWlqDM7DLUuh1vslO9G3KNY6oeQ/BrI3bNyCIf0FRHCf1H2ZRPE9g2kKQxT0K
         AGxqMYUIbqbIaEEjwVYDC3SHqL42v8Q1HOvoxPiFAhfpsXsm2K6aihGaRvfDX0wgaMhS
         88wQ==
X-Gm-Message-State: AOAM532YWON2HtjprF+EQ2UFsj6wLHGTGrEu7nIoI01GgZFn3KyOIz8Q
        lf5Ti8nIdnhsHoNnF8cPw1+iEUpdc/WqhiRIdHY=
X-Google-Smtp-Source: ABdhPJwsDYJ8byhhcHm8xfuPYA6x0kXOPmO17k4AVIKoWo6GLOjlH+ncR3nrdUmtJSLP2IN4CjxTj2yLH28aYG0nDqo=
X-Received: by 2002:a17:906:3383:: with SMTP id v3mr3653540eja.213.1633059369746;
 Thu, 30 Sep 2021 20:36:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210915213550.3696532-1-guro@fb.com> <20210916162451.709260-1-guro@fb.com>
 <20210916162451.709260-5-guro@fb.com>
In-Reply-To: <20210916162451.709260-5-guro@fb.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Fri, 1 Oct 2021 16:35:58 +1300
Message-ID: <CAGsJ_4xr0Xg3B1seT5_kcb26ZQgWaakR8QGOB-N62wehfXkt_Q@mail.gmail.com>
Subject: Re: [PATCH rfc 4/6] sched: cfs: add bpf hooks to control wakeup and
 tick preemption
To:     Roman Gushchin <guro@fb.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>, bpf@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 17, 2021 at 4:36 AM Roman Gushchin <guro@fb.com> wrote:
>
> This patch adds 3 hooks to control wakeup and tick preemption:
>   cfs_check_preempt_tick
>   cfs_check_preempt_wakeup
>   cfs_wakeup_preempt_entity
>
> The first one allows to force or suppress a preemption from a tick
> context. An obvious usage example is to minimize the number of
> non-voluntary context switches and decrease an associated latency
> penalty by (conditionally) providing tasks or task groups an extended
> execution slice. It can be used instead of tweaking
> sysctl_sched_min_granularity.
>
> The second one is called from the wakeup preemption code and allows
> to redefine whether a newly woken task should preempt the execution
> of the current task. This is useful to minimize a number of
> preemptions of latency sensitive tasks. To some extent it's a more
> flexible analog of a sysctl_sched_wakeup_granularity.

This reminds me of Mel's recent work which might be relevant:
sched/fair: Scale wakeup granularity relative to nr_running
https://lore.kernel.org/lkml/20210920142614.4891-3-mgorman@techsingularity.net/

>
> The third one is similar, but it tweaks the wakeup_preempt_entity()
> function, which is called not only from a wakeup context, but also
> from pick_next_task(), which allows to influence the decision on which
> task will be running next.
>
> It's a place for a discussion whether we need both these hooks or only
> one of them: the second is more powerful, but depends more on the
> current implementation. In any case, bpf hooks are not an ABI, so it's
> not a deal breaker.

I am also curious if similar hook can benefit
newidle_balance/sched_migration_cost
tuning things in this thread:
https://lore.kernel.org/lkml/ef3b3e55-8be9-595f-6d54-886d13a7e2fd@hisilicon.com/

It seems those static values are not universal. different topology might need
different settings.  but dynamically tuning them in the kernel seems to be
extremely difficult.

>
> The idea of the wakeup_preempt_entity hook belongs to Rik van Riel. He
> also contributed a lot to the whole patchset by proving his ideas,
> recommendations and a feedback for earlier (non-public) versions.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> ---
>  include/linux/bpf_sched.h       |  1 +
>  include/linux/sched_hook_defs.h |  4 +++-
>  kernel/sched/fair.c             | 27 +++++++++++++++++++++++++++
>  3 files changed, 31 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/bpf_sched.h b/include/linux/bpf_sched.h
> index 6e773aecdff7..5c238aeb853c 100644
> --- a/include/linux/bpf_sched.h
> +++ b/include/linux/bpf_sched.h
> @@ -40,6 +40,7 @@ static inline RET bpf_sched_##NAME(__VA_ARGS__)       \
>  {                                              \
>         return DEFAULT;                         \
>  }
> +#include <linux/sched_hook_defs.h>
>  #undef BPF_SCHED_HOOK
>
>  static inline bool bpf_sched_enabled(void)
> diff --git a/include/linux/sched_hook_defs.h b/include/linux/sched_hook_defs.h
> index 14344004e335..f075b32698cd 100644
> --- a/include/linux/sched_hook_defs.h
> +++ b/include/linux/sched_hook_defs.h
> @@ -1,2 +1,4 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -BPF_SCHED_HOOK(int, 0, dummy, void)
> +BPF_SCHED_HOOK(int, 0, cfs_check_preempt_tick, struct sched_entity *curr, unsigned long delta_exec)
> +BPF_SCHED_HOOK(int, 0, cfs_check_preempt_wakeup, struct task_struct *curr, struct task_struct *p)
> +BPF_SCHED_HOOK(int, 0, cfs_wakeup_preempt_entity, struct sched_entity *curr, struct sched_entity *se)
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ff69f245b939..35ea8911b25c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -21,6 +21,7 @@
>   *  Copyright (C) 2007 Red Hat, Inc., Peter Zijlstra
>   */
>  #include "sched.h"
> +#include <linux/bpf_sched.h>
>
>  /*
>   * Targeted preemption latency for CPU-bound tasks:
> @@ -4447,6 +4448,16 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
>
>         ideal_runtime = sched_slice(cfs_rq, curr);
>         delta_exec = curr->sum_exec_runtime - curr->prev_sum_exec_runtime;
> +
> +       if (bpf_sched_enabled()) {
> +               int ret = bpf_sched_cfs_check_preempt_tick(curr, delta_exec);
> +
> +               if (ret < 0)
> +                       return;
> +               else if (ret > 0)
> +                       resched_curr(rq_of(cfs_rq));
> +       }
> +
>         if (delta_exec > ideal_runtime) {
>                 resched_curr(rq_of(cfs_rq));
>                 /*
> @@ -7083,6 +7094,13 @@ wakeup_preempt_entity(struct sched_entity *curr, struct sched_entity *se)
>  {
>         s64 gran, vdiff = curr->vruntime - se->vruntime;
>
> +       if (bpf_sched_enabled()) {
> +               int ret = bpf_sched_cfs_wakeup_preempt_entity(curr, se);
> +
> +               if (ret)
> +                       return ret;
> +       }
> +
>         if (vdiff <= 0)
>                 return -1;
>
> @@ -7168,6 +7186,15 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
>             likely(!task_has_idle_policy(p)))
>                 goto preempt;
>
> +       if (bpf_sched_enabled()) {
> +               int ret = bpf_sched_cfs_check_preempt_wakeup(current, p);
> +
> +               if (ret < 0)
> +                       return;
> +               else if (ret > 0)
> +                       goto preempt;
> +       }
> +
>         /*
>          * Batch and idle tasks do not preempt non-idle tasks (their preemption
>          * is driven by the tick):
> --
> 2.31.1
>

Thanks
barry
