Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF14358E2BB
	for <lists+bpf@lfdr.de>; Wed, 10 Aug 2022 00:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiHIWN6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 18:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiHIWNi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 18:13:38 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EB6186D2
        for <bpf@vger.kernel.org>; Tue,  9 Aug 2022 15:12:38 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id z20so14916444edb.9
        for <bpf@vger.kernel.org>; Tue, 09 Aug 2022 15:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YVIDw6XnpvNCwkszE5+XQ2op+IiW359EhausHzoYr3s=;
        b=f6re58jASFmDHK5eemaDqCjI4+t6TkHya6iKNFQ55mDJ6/zQXhERFsVjZeAPtWBfBT
         41btIcnqzLjMn8oLEPfgdjhmw9jexh1uJXckK3lodyq8EPIwDdOGMx/bHHSNvoPvKiHc
         tyS/TB9xFNELXMHDAxIOB34vOnoQBz/rFoJ8eXYKzhrBzAa5T+WRx8Q/9xRR8FJHMmmJ
         YAjQDCaVGLGUyODf1RELrMwwM3pQ5XHcbL215ZNgKfdAKYX1Kf9p+m17k/huMdrVZ+PS
         sL1vmwCygTINAos8EqMVymwV0Pq9ZkcZrchwyP3BYIBAs6SNMEEsMUZNYCWfxcuSUiaY
         QV7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YVIDw6XnpvNCwkszE5+XQ2op+IiW359EhausHzoYr3s=;
        b=6ijk+3M5b6JvRco5Jff9Pb5Ixcrd+jYtyOF6rV/jOXweQgqJOoY7oJK5ZGuK2s7tSw
         v6oS1c2QdUoQtyGxlvVC8JKd+Tq3hWoJ4OEmU9Z+CwAdDjCKQfG8nI7KbuEqLHe0k5A9
         KalX3zjjJI4jrvbNXQR0hKwjz7/HbSjrdaonYKf0/z9KTbep5HZR4L5U7TAj1T0yTNoa
         cScYKKBM6DxwABUVUt6r687Y8XQhpG1X2RYz9GkMfdqGrbU2KxD6o98Ptjxi0d/ziBmK
         2uMAy4FnTN+5xRyDlUmKiIHeohqdAMoy0yVnGUuE9bo91s0o1paO/qgnBolA0VDue3GW
         8Img==
X-Gm-Message-State: ACgBeo3m+hNd9K8qXQ2Na5va3irMxI+tZDCQvQKINJuQW5uY18Lsc34+
        l6YldrRswOnoRj9ywK5VOWa4yub+eBP3y22XiZs=
X-Google-Smtp-Source: AA6agR5lVdXsWJagMSdMTwBptp5GWZEhoB9p+yDGXwj0lTG2hxh5e04XjfHWQPmcncotyxTMBMuOrHcGxQfF6MBFakI=
X-Received: by 2002:a05:6402:2079:b0:43d:a218:9b8a with SMTP id
 bd25-20020a056402207900b0043da2189b8amr23291940edb.357.1660083156719; Tue, 09
 Aug 2022 15:12:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220809195429.1043220-1-kuifeng@fb.com> <20220809195429.1043220-2-kuifeng@fb.com>
In-Reply-To: <20220809195429.1043220-2-kuifeng@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 9 Aug 2022 15:12:25 -0700
Message-ID: <CAADnVQLjHpfFQDn_1mXj7+o6E8Dsmatr0jeozPAk5rV8hcLWfg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/3] bpf: Parameterize task iterators.
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 9, 2022 at 12:54 PM Kui-Feng Lee <kuifeng@fb.com> wrote:
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
>  include/linux/bpf.h            |   8 ++
>  include/uapi/linux/bpf.h       |  36 +++++++++
>  kernel/bpf/task_iter.c         | 134 +++++++++++++++++++++++++++------
>  tools/include/uapi/linux/bpf.h |  36 +++++++++
>  4 files changed, 190 insertions(+), 24 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 11950029284f..bef81324e5f1 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1718,6 +1718,14 @@ int bpf_obj_get_user(const char __user *pathname, int flags);
>
>  struct bpf_iter_aux_info {
>         struct bpf_map *map;
> +       struct {
> +               enum bpf_iter_task_type type;
> +               union {
> +                       u32 tid;
> +                       u32 tgid;
> +                       u32 pid_fd;
> +               };
> +       } task;
>  };
>
>  typedef int (*bpf_iter_attach_target_t)(struct bpf_prog *prog,
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index ffcbf79a556b..3d0b9e34089f 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -87,10 +87,46 @@ struct bpf_cgroup_storage_key {
>         __u32   attach_type;            /* program attach type (enum bpf_attach_type) */
>  };
>
> +/*
> + * The task type of iterators.
> + *
> + * For BPF task iterators, they can be parameterized with various
> + * parameters to visit only some of tasks.
> + *
> + * BPF_TASK_ITER_ALL (default)
> + *     Iterate over resources of every task.
> + *
> + * BPF_TASK_ITER_TID
> + *     Iterate over resources of a task/tid.
> + *
> + * BPF_TASK_ITER_TGID
> + *     Iterate over reosurces of evevry task of a process / task group.
> + *
> + * BPF_TASK_ITER_PIDFD
> + *     Iterate over resources of every task of a process /task group specified by a pidfd.
> + */
> +enum bpf_iter_task_type {
> +       BPF_TASK_ITER_ALL = 0,
> +       BPF_TASK_ITER_TID,
> +       BPF_TASK_ITER_TGID,
> +       BPF_TASK_ITER_PIDFD,
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
> +               enum bpf_iter_task_type type;
> +               union {
> +                       __u32 tid;
> +                       __u32 tgid;
> +                       __u32 pid_fd;
> +               };

Sorry I'm late to this discussion, but
with enum and with union we kinda tell
the kernel the same information twice.
Here is how the selftest looks:
+       linfo.task.tid = getpid();
+       linfo.task.type = BPF_TASK_ITER_TID;

first line -> use tid.
second line -> yeah. I really meant the tid.

Instead of union and type can we do:
> +                       __u32 tid;
> +                       __u32 tgid;
> +                       __u32 pid_fd;

as 3 separate fields?
The kernel would have to check that only one
of them is set.

I could have missed an earlier discussion on this subj.
