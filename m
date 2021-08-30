Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B63FA3FBEAF
	for <lists+bpf@lfdr.de>; Tue, 31 Aug 2021 00:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbhH3WGb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Aug 2021 18:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbhH3WGb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Aug 2021 18:06:31 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D30DC061575;
        Mon, 30 Aug 2021 15:05:37 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id z18so31058882ybg.8;
        Mon, 30 Aug 2021 15:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3AI5mZl+BbVjezvyWOJjh9FI+0uPl+5gVobqJ+UruaM=;
        b=YmxO9Acp8m7p1yf7GZsf4g+mJLtokK7wrLGrs8UtWUDUD1WjknuD0P/x/hKGhseJoy
         qbl287mM2JhIDrCOAdN8CXUOwBJ4/YPzROOF4YbeuJJ21YIaU+r/aeGzpR+mwDibj9VZ
         vnIaRD1zlLWUThIXRpeWeAIF/rwCjLQ7eAXxdQQNZNsx+r3sJFnqpk4BEYFAPRf9amME
         stOGvWfR9ss/XXK7J/4gnLjhKE4nULVcu8PV8UVJOIcxJvtXb8fL+j+tD8NiY3e5Q0av
         Fz9ISGG9SxxT+EJqKwJkE1bd9Bd+k49S/tnaA03UAqhvKY2FhpgqJJAn7B0MQd0ppuEE
         3eSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3AI5mZl+BbVjezvyWOJjh9FI+0uPl+5gVobqJ+UruaM=;
        b=ZUtzwYq2FKvlC7yHyC98Iqb0UwX6jdgC5E+6qLUAUUT3S8gGygqE6Xm/ZkpoIBCSud
         gE7T7CDR9iUmvAD2qje3HPDRICjs8jOi0d4Xeu1RqB64KVuZmYCpuEh7xtxJTxG8OP68
         RT+re6Io+C9mjoFoK2M18yLriMqlwRA72TxvkoURpGmj5lzU1MXAuuUsL6K4H3AuzIGT
         hMadAhDwhoqO4M2aSoSKUDJHGMdQAXKn8uYU5TCWuuFy3Jec8zOThJG9Vok8pxjUpmDG
         UcGs6e5fMBNBmG89yG9ViRzDQe0oTn9P6ZBAeL3wDWT8AsZZbdpyaQk5gGk0ocUgk5IW
         BPew==
X-Gm-Message-State: AOAM5307YhTROHrE931tEYioqJwKECWPVDbQBg/l9kyWFU1By4NfIJgj
        uHsEOMivBYPPxCcAiKITTqamZfPCNjKV6GRhR5c=
X-Google-Smtp-Source: ABdhPJw84hvEHkHzKueTEuDlr1a8lDgNQTBp47BcH/A6g9xVGFdFIvui8Z1z9vSSf6TnCWzQvOobw/xRnajHkpQvIiQ=
X-Received: by 2002:a25:ac7:: with SMTP id 190mr25051248ybk.260.1630361136478;
 Mon, 30 Aug 2021 15:05:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210830214106.4142056-1-songliubraving@fb.com> <20210830214106.4142056-2-songliubraving@fb.com>
In-Reply-To: <20210830214106.4142056-2-songliubraving@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 30 Aug 2021 15:05:25 -0700
Message-ID: <CAEf4BzZg3Ea5hsmJmvGB=Xkr3Ak7Op0Oo_VTRBAFEJYavdk1LQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 1/3] perf: enable branch record for software events
To:     Song Liu <songliubraving@fb.com>
Cc:     bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Ziljstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 30, 2021 at 2:42 PM Song Liu <songliubraving@fb.com> wrote:
>
> The typical way to access branch record (e.g. Intel LBR) is via hardware
> perf_event. For CPUs with FREEZE_LBRS_ON_PMI support, PMI could capture
> reliable LBR. On the other hand, LBR could also be useful in non-PMI
> scenario. For example, in kretprobe or bpf fexit program, LBR could
> provide a lot of information on what happened with the function. Add API
> to use branch record for software use.
>
> Note that, when the software event triggers, it is necessary to stop the
> branch record hardware asap. Therefore, static_call is used to remove some
> branch instructions in this process.
>
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  arch/x86/events/intel/core.c | 24 ++++++++++++++++++++++--
>  include/linux/perf_event.h   | 24 ++++++++++++++++++++++++
>  kernel/events/core.c         |  3 +++
>  3 files changed, 49 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index ac6fd2dabf6a2..d28d0e12c112c 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -2155,9 +2155,9 @@ static void __intel_pmu_disable_all(void)
>
>  static void intel_pmu_disable_all(void)
>  {
> +       intel_pmu_lbr_disable_all();
>         __intel_pmu_disable_all();
>         intel_pmu_pebs_disable_all();
> -       intel_pmu_lbr_disable_all();
>  }
>
>  static void __intel_pmu_enable_all(int added, bool pmi)
> @@ -2186,6 +2186,20 @@ static void intel_pmu_enable_all(int added)
>         __intel_pmu_enable_all(added, false);
>  }
>
> +static int
> +intel_pmu_snapshot_branch_stack(struct perf_branch_snapshot *br_snapshot)
> +{
> +       struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> +
> +       intel_pmu_disable_all();
> +       intel_pmu_lbr_read();
> +       memcpy(br_snapshot->entries, cpuc->lbr_entries,
> +              sizeof(struct perf_branch_entry) * x86_pmu.lbr_nr);
> +       br_snapshot->nr = x86_pmu.lbr_nr;
> +       intel_pmu_enable_all(0);
> +       return 0;
> +}
> +
>  /*
>   * Workaround for:
>   *   Intel Errata AAK100 (model 26)
> @@ -6283,9 +6297,15 @@ __init int intel_pmu_init(void)
>                         x86_pmu.lbr_nr = 0;
>         }
>
> -       if (x86_pmu.lbr_nr)
> +       if (x86_pmu.lbr_nr) {
>                 pr_cont("%d-deep LBR, ", x86_pmu.lbr_nr);
>
> +               /* only support branch_stack snapshot for perfmon >= v2 */
> +               if (x86_pmu.disable_all == intel_pmu_disable_all)
> +                       static_call_update(perf_snapshot_branch_stack,
> +                                          intel_pmu_snapshot_branch_stack);
> +       }
> +
>         intel_pmu_check_extra_regs(x86_pmu.extra_regs);
>
>         /* Support full width counters using alternative MSR range */
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index fe156a8170aa3..1f42e91668024 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -57,6 +57,7 @@ struct perf_guest_info_callbacks {
>  #include <linux/cgroup.h>
>  #include <linux/refcount.h>
>  #include <linux/security.h>
> +#include <linux/static_call.h>
>  #include <asm/local.h>
>
>  struct perf_callchain_entry {
> @@ -1612,4 +1613,27 @@ extern void __weak arch_perf_update_userpage(struct perf_event *event,
>  extern __weak u64 arch_perf_get_page_size(struct mm_struct *mm, unsigned long addr);
>  #endif
>
> +/*
> + * Snapshot branch stack on software events.
> + *
> + * Branch stack can be very useful in understanding software events. For
> + * example, when a long function, e.g. sys_perf_event_open, returns an
> + * errno, it is not obvious why the function failed. Branch stack could
> + * provide very helpful information in this type of scenarios.
> + *
> + * On software event, it is necessary to stop the hardware branch recorder
> + * fast. Otherwise, the hardware register/buffer will be flushed with
> + * entries af the triggering event. Therefore, static call is used to
> + * stop the hardware recorder.
> + */
> +#define MAX_BRANCH_SNAPSHOT 32

Can you please make it an enum instead? It will make this available as
a constant in vmlinux.h nicely, without users having to #define it
every time.

> +
> +struct perf_branch_snapshot {
> +       unsigned int nr;
> +       struct perf_branch_entry entries[MAX_BRANCH_SNAPSHOT];
> +};
> +
> +typedef int (perf_snapshot_branch_stack_t)(struct perf_branch_snapshot *);
> +DECLARE_STATIC_CALL(perf_snapshot_branch_stack, perf_snapshot_branch_stack_t);
> +
>  #endif /* _LINUX_PERF_EVENT_H */
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 011cc5069b7ba..22807864e913b 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -13437,3 +13437,6 @@ struct cgroup_subsys perf_event_cgrp_subsys = {
>         .threaded       = true,
>  };
>  #endif /* CONFIG_CGROUP_PERF */
> +
> +DEFINE_STATIC_CALL_RET0(perf_snapshot_branch_stack,
> +                       perf_snapshot_branch_stack_t);
> --
> 2.30.2
>
