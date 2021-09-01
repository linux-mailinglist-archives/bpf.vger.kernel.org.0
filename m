Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5FB3FD206
	for <lists+bpf@lfdr.de>; Wed,  1 Sep 2021 06:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbhIAEDs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Sep 2021 00:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhIAEDr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Sep 2021 00:03:47 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859EDC061575;
        Tue, 31 Aug 2021 21:02:51 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id v26so417438ybd.9;
        Tue, 31 Aug 2021 21:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3jvvFuay3kvFuziBi2+wIgp51YYcFQaw4C+vPV7RxBY=;
        b=jCB7H0vbJHZXWbx/rKoyVmPSlZnv1sBq8vdikvihB+5ts0bB3NMBxl5+lihGK9CWUY
         5m4lq3wv0UFHnMKkNBE5ZA6GvnveWS/MUHX5R4gwBENxsxnwDMlVC0ge5lV6g8v+0+8d
         uCkkfKPPlJCsV8Y6R9sg2usmFwn+FcI/pmMcbrj/D71ok1jOSoNwNXpSJLKTcXoevmag
         6oB8+8HLOODAMGk2SkfQUKBSQv7tvJtBzpfj7tCRYtd9oqOlwZPgIBtKtSWAbe8cdbZY
         HBGlGPl2z27MxRQF1cljdwDtC2J2kr8owHWhRpqAwsxX+Rfc3MrhDAx7qveaTSRTeFt0
         nZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3jvvFuay3kvFuziBi2+wIgp51YYcFQaw4C+vPV7RxBY=;
        b=A3pIr68iVpALodO9G1Qs1ZNKE4+Zpm3ESxtyKj0txQZLZfefiN6ZllLQsa2WVeeu8f
         Qzn+DfB45rcWqCjG+LwwY3+FS3rUW6yO3ohVrv+VEXyWlOVurV0jJNDHsb4ollkuqN5L
         zj4MyzmWcPt7fktdnLpJb6HdzGax9tKPBuE5jyynh44IPvdBSxs4B+4bZ321ULjmz6mu
         24SbDaPo/v6I66U6zTX6qoakJdc75u9gBMbKI5gDKqbkDGQsUTpsG+vgnAZK8OXBCIJa
         FWIbzPX+80tkYIPJNtMeKwHLmLPPo5eJVHLSZwJ4AX+F+zrcpQfd4o9BvW2IQhAdtFrF
         TKDw==
X-Gm-Message-State: AOAM531TnsdZCSOoc5QDc/61iSaHXVdKwAujoTP9Yafkq2dMm/YXzii1
        7Xb9Moxt84DFqcp5lgEh0RLf4xFU5DUFzX/EDl4=
X-Google-Smtp-Source: ABdhPJzir6T0JZ97Rw2E61zEdODF/tNWIuSgxr2AIWkP5w+rekEmH48hqvYBMSKTzAgqt6eQSyH85WPPVn7SguelBmw=
X-Received: by 2002:a25:bdc5:: with SMTP id g5mr34790828ybk.403.1630468970557;
 Tue, 31 Aug 2021 21:02:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210901003517.3953145-1-songliubraving@fb.com> <20210901003517.3953145-3-songliubraving@fb.com>
In-Reply-To: <20210901003517.3953145-3-songliubraving@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 31 Aug 2021 21:02:39 -0700
Message-ID: <CAEf4BzaPuPJKnVJ+Bi4aNs57A2x0jRnM3V-ud37U6V=wThHAYQ@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/3] bpf: introduce helper bpf_get_branch_snapshot
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

On Tue, Aug 31, 2021 at 7:01 PM Song Liu <songliubraving@fb.com> wrote:
>
> Introduce bpf_get_branch_snapshot(), which allows tracing pogram to get
> branch trace from hardware (e.g. Intel LBR). To use the feature, the
> user need to create perf_event with proper branch_record filtering
> on each cpu, and then calls bpf_get_branch_snapshot in the bpf function.
> On Intel CPUs, VLBR event (raw event 0x1b00) can be use for this.
>
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  include/uapi/linux/bpf.h       | 22 +++++++++++++++++++
>  kernel/bpf/trampoline.c        |  3 ++-
>  kernel/trace/bpf_trace.c       | 40 ++++++++++++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h | 22 +++++++++++++++++++
>  4 files changed, 86 insertions(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 791f31dd0abee..c986e6fad5bc0 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -4877,6 +4877,27 @@ union bpf_attr {
>   *             Get the struct pt_regs associated with **task**.
>   *     Return
>   *             A pointer to struct pt_regs.
> + *
> + * long bpf_get_branch_snapshot(void *entries, u32 size, u64 flags)
> + *     Description
> + *             Get branch trace from hardware engines like Intel LBR. The
> + *             branch trace is taken soon after the trigger point of the
> + *             BPF program, so it may contain some entries after the
> + *             trigger point. The user need to filter these entries
> + *             accordingly.
> + *
> + *             The data is stored as struct perf_branch_entry into output
> + *             buffer *entries*. *size* is the size of *entries* in bytes.
> + *             *flags* is reserved for now and must be zero.
> + *
> + *     Return
> + *             On success, number of bytes written to *buf*. On error, a
> + *             negative value.
> + *
> + *             **-EINVAL** if arguments invalid or **size** not a multiple
> + *             of **sizeof**\ (**struct perf_branch_entry**\ ).
> + *
> + *             **-ENOENT** if architecture does not support branch records.
>   */
>  #define __BPF_FUNC_MAPPER(FN)          \
>         FN(unspec),                     \
> @@ -5055,6 +5076,7 @@ union bpf_attr {
>         FN(get_func_ip),                \
>         FN(get_attach_cookie),          \
>         FN(task_pt_regs),               \
> +       FN(get_branch_snapshot),        \
>         /* */
>
>  /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index fe1e857324e66..39eaaff81953d 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -10,6 +10,7 @@
>  #include <linux/rcupdate_trace.h>
>  #include <linux/rcupdate_wait.h>
>  #include <linux/module.h>
> +#include <linux/static_call.h>
>
>  /* dummy _ops. The verifier will operate on target program's ops. */
>  const struct bpf_verifier_ops bpf_extension_verifier_ops = {
> @@ -526,7 +527,7 @@ void bpf_trampoline_put(struct bpf_trampoline *tr)
>  }
>
>  #define NO_START_TIME 1
> -static u64 notrace bpf_prog_start_time(void)
> +static __always_inline u64 notrace bpf_prog_start_time(void)
>  {
>         u64 start = NO_START_TIME;
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 8e2eb950aa829..a8ec3634a3329 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1017,6 +1017,44 @@ static const struct bpf_func_proto bpf_get_attach_cookie_proto_pe = {
>         .arg1_type      = ARG_PTR_TO_CTX,
>  };
>
> +static DEFINE_PER_CPU(struct perf_branch_snapshot, bpf_perf_branch_snapshot);
> +
> +BPF_CALL_3(bpf_get_branch_snapshot, void *, buf, u32, size, u64, flags)
> +{
> +#ifndef CONFIG_X86
> +       return -ENOENT;

nit: -EOPNOTSUPP probably makes more sense for this?

> +#else
> +       static const u32 br_entry_size = sizeof(struct perf_branch_entry);
> +       u32 to_copy;
> +
> +       if (unlikely(flags))
> +               return -EINVAL;
> +
> +       if (!buf || (size % br_entry_size != 0))
> +               return -EINVAL;
> +
> +       static_call(perf_snapshot_branch_stack)(this_cpu_ptr(&bpf_perf_branch_snapshot));

First, you have four this_cpu_ptr(&bpf_perf_branch_snapshot)
invocations in this function, probably cleaner to store the pointer in
local variable?

But second, this still has the reentrancy problem, right? And further,
we copy the same LBR data twice (to per-cpu buffer and into
user-provided destination).

What if we change perf_snapshot_branch_stack signature to this:

int perf_snapshot_branch_stack(struct perf_branch_entry *entries, int
max_nr_entries);

with the semantics that it will copy only min(max_nr_entreis,
PERF_MAX_BRANCH_RECORDS) * sizeof(struct perf_branch_entry) bytes.
That way we can copy directly into a user-provided buffer with no
per-cpu storage. Of course, perf_snapshot_branch_stack will return
number of entries copied, either as return result, or if static calls
don't support that, as another int *nr_entries output argument.


> +
> +       if (this_cpu_ptr(&bpf_perf_branch_snapshot)->nr == 0)
> +               return -ENOENT;
> +
> +       to_copy = this_cpu_ptr(&bpf_perf_branch_snapshot)->nr *
> +               sizeof(struct perf_branch_entry);
> +       to_copy = min_t(u32, size, to_copy);
> +       memcpy(buf, this_cpu_ptr(&bpf_perf_branch_snapshot)->entries, to_copy);
> +
> +       return to_copy;
> +#endif
> +}
> +

[...]
