Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0CFA5875FD
	for <lists+bpf@lfdr.de>; Tue,  2 Aug 2022 05:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbiHBDbF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 23:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235462AbiHBDaz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 23:30:55 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21AA13F7E
        for <bpf@vger.kernel.org>; Mon,  1 Aug 2022 20:30:51 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id r4so8303772edi.8
        for <bpf@vger.kernel.org>; Mon, 01 Aug 2022 20:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=IDRZ8ASUWmRu4lgxVW5lUj3T+8vF7Lb2RxiXiDA3GlQ=;
        b=V4OxFMV0dzPyULc3lAq4BXPkT6uTYdpqRGbomAEepPTVzCKsTDjvFN7K0c5ZtVG/hk
         nFlYtvXuhA+511fVcCySbEyww++sqPgrTk2bebKmBYcMxxN/nN3xN4SSPq6ev1rJSQ0f
         Gwg4B4wpiS3zEZB1RQg38lU9nofhrFiukCCELAZ924h45eGOJi2O0wS2DrsyMb6AnIRG
         JORhB/V99VW1OXw2abJXext0zmOC1RF38fIwWmq0g3DTMV6+tv99SEBhJE1FvTSDORJX
         mlMLp4maPfkBQ0g/OIb/SpRBnHKG8kl/q0vYhPI/ClkSV+n1/loDhsMnz/UbtGnAyZBi
         1oFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=IDRZ8ASUWmRu4lgxVW5lUj3T+8vF7Lb2RxiXiDA3GlQ=;
        b=bXVjOYgT4M8P+8ngfFCUa4aihcpv2eKgNgGNi2uKQoJlUCi1edLE4nUrnnDA9f7L2k
         mZEm2KWPUdyRTKyc0XB2QY2TwJDKA8KBAbYTwR8FxlHcl5idls7bYfXrvRROYexyXsf7
         BbJBToGUqfAmxxuhF0U7uJQOLt5gClVauTebs5EVbAQxxIp6evEPT2Zj/ucYu6z7VUdQ
         l39bW+OX6L3g4Bnzoexxx0es1ePWS+/dI81NBy6DM1au3A5MKRMSg+wehmsO4BmqaBXj
         8+xWDpFMXiNDxR21J9v9iN8WIylKEX7sLwrW38UkdhkqTKszuOGrU1AH3Nmkij2YkHUw
         Rnsw==
X-Gm-Message-State: ACgBeo25sDsXqxjTQnSQkkeUlN20HVabQgxUKitD1IFwpilNTeQmftEv
        4RxjFj0l1C4of0pYkGH9AcXPfTg5QVPceFj/E0NQrSHd
X-Google-Smtp-Source: AA6agR6vdTdYD2/1idrRQEtX/VV+VpcQStppN4LAxAkdvdMfVzWtn6BVrRqWjebYWXkoTwnBPizNjPiWQWbrt3nWOFE=
X-Received: by 2002:aa7:ccc4:0:b0:43d:9e0e:b7ff with SMTP id
 y4-20020aa7ccc4000000b0043d9e0eb7ffmr8328171edt.14.1659411049887; Mon, 01 Aug
 2022 20:30:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220801232649.2306614-1-kuifeng@fb.com> <20220801232649.2306614-2-kuifeng@fb.com>
In-Reply-To: <20220801232649.2306614-2-kuifeng@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 1 Aug 2022 20:30:38 -0700
Message-ID: <CAEf4BzZqwoCecuUTe=LGBBrTWMp_bCttik1fkmRF1rBXxBYPAw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Parameterize task iterators.
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kernel-team@fb.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 1, 2022 at 4:27 PM Kui-Feng Lee <kuifeng@fb.com> wrote:
>
> Allow creating an iterator that loops through resources of one task/thread.
>
> People could only create iterators to loop through all resources of
> files, vma, and tasks in the system, even though they were interested
> in only the resources of a specific task or process.  Passing the
> additional parameters, people can now create an iterator to go
> through all resources or only the resources of a task.
>
> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> ---
>  include/linux/bpf.h            |  4 ++
>  include/uapi/linux/bpf.h       | 23 +++++++++
>  kernel/bpf/task_iter.c         | 93 ++++++++++++++++++++++++++--------
>  tools/include/uapi/linux/bpf.h | 23 +++++++++
>  4 files changed, 121 insertions(+), 22 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 11950029284f..3c26dbfc9cef 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1718,6 +1718,10 @@ int bpf_obj_get_user(const char __user *pathname, int flags);
>
>  struct bpf_iter_aux_info {
>         struct bpf_map *map;
> +       struct {
> +               u32     tid;
> +               u8      type;
> +       } task;
>  };
>
>  typedef int (*bpf_iter_attach_target_t)(struct bpf_prog *prog,
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index ffcbf79a556b..ed5ba501609f 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -87,10 +87,33 @@ struct bpf_cgroup_storage_key {
>         __u32   attach_type;            /* program attach type (enum bpf_attach_type) */
>  };
>
> +enum bpf_task_iter_type {
> +       BPF_TASK_ITER_ALL = 0,
> +       BPF_TASK_ITER_TID,
> +};
> +
>  union bpf_iter_link_info {
>         struct {
>                 __u32   map_fd;
>         } map;
> +       /*
> +        * Parameters of task iterators.
> +        */
> +       struct {
> +               __u32   pid_fd;

I was a bit late to the discussion about pidfd vs plain pid. I think
we should support both in this API. While pid_fd has some nice
guarantees like avoiding the risk of accidental PID reuse, in a lot
(if not all) cases where task/task_vma/task_file iterators are going
to be used this is never a risk, because pid will usually come from
some tracing BPF program (kprobe/tp/fentry/etc), like in case of
profiling, and then will be used by user-space almost immediately to
query some additional information (fetching relevant vma information
for profiling use case). So main benefit of pidfd is not that relevant
for BPF tracing use cases, because PIDs are not going to be reused so
fast within such a short time frame.

But pidfd does have downsides. It requires 2 syscalls (pidfd_open and
close) for each PID, it creates struct file for each such active
pidfd. So it will have non-trivial overhead for high-frequency BPF
iterator use cases (imagine querying some simple stats for a big set
of tasks, frequently: you'll spend more time in pidfd syscalls and
more resources just keeping corresponding struct file open than
actually doing useful BPF work). For simple BPF iter cases it will
unnecessarily complicate program flow while giving no benefit instead.

So I propose we support both in UAPI. Internally either way we resolve
to plain pid/tid, so this won't cause added maintenance burden. But
simple cases will keep simple, while more long-lived and/or
complicated ones will still be supported. We then can have
BPF_TASK_ITER_PIDFD vs BPF_TASK_ITER_TID to differentiate whether the
above __u32 pid_fd (which we should probably rename to something more
generic like "target") is pid FD or TID/PID. See also below about TID
vs PID.

> +               /*
> +                * The type of the iterator.
> +                *
> +                * It can be one of enum bpf_task_iter_type.
> +                *
> +                * BPF_TASK_ITER_ALL (default)
> +                *      The iterator iterates over resources of everyprocess.
> +                *
> +                * BPF_TASK_ITER_TID
> +                *      You should also set *pid_fd* to iterate over one task.

naming nit: we should decide whether we use TID (thread) and PID
(process) terminology (more usual for user-space) or PID (process ==
task == user-space thread) and TGID (thread group, i.e. user-space
process). I haven't investigated much what's we use most consistently,
but curious to hear what others think.

Also I can see use-cases where we want to iterate just specified task
(i.e., just specified thread) vs all the tasks that belong to the same
process group (i.e., thread within process). Naming TBD, but we should
have BPF_TASK_ITER_TID and BPF_TASK_ITER_TGID (or some other naming).

One might ask why do we need single-task mode if we can always stop
iteration from BPF program, but this is trivial only for iter/task,
while for iter/task_vma and iter/task_file it becomes inconvenient to
detect switch from one task to another. It costs us essentially
nothing to support this mode, so I advocate to do that.

I have similar thoughts about cgroup iteration modes and actually
supporting cgroup_fd as target for task iterators (which will mean
iterating tasks belonging to provided cgroup(s)), but I'll reply on
cgroup iterator patch first, and we can just reuse the same cgroup
target specification between iter/cgroup and iter/task afterwards.


> +                */
> +               __u8    type;   /* BPF_TASK_ITER_* */
> +       } task;
>  };
>

[...]
