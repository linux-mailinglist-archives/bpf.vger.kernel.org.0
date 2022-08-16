Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3DA595424
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 09:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbiHPHx1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 03:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbiHPHxG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 03:53:06 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CFB1B212D
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 22:02:23 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id t5so12010369edc.11
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 22:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=AIUm2EOlpEaMYfSAO95tqmOxhwDksoJ14pZiy85GAGo=;
        b=WJ79V/sGOmIkCQJuKyyVbLeVr5bgAlPiZHHg/jjcUSyKNT8D065mopyzRYCXWtdv0T
         XsY2K92Rl0/3/Ti3lksX1vdFvniZQ50SeQ+OA9bDgs6oyrFr1+ixw/D/fvXXN27BG4ZS
         RS4pUC3rJTmZo8hyLYxiHRbvqVkv3A1EZFN2oDFw3NDlTX4imTzKxhLPgrk8PFiLQa70
         98A3cmTot3eToEaSOxeGiIt2lfDwwGOwpQ+YX1hBFPd9Aksqiw4XQFxCdLhwQdENqgha
         56G1fQsn+IA7nO2TSvFlLx7NOb5/XguwgvouNfMvfivqBskD1H3BFNQNicGETUVarNgH
         Yspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=AIUm2EOlpEaMYfSAO95tqmOxhwDksoJ14pZiy85GAGo=;
        b=H0GzDJwvB8TlG0xunXw9Y5ITEtW4N4Fd+DzJAWzmQzknCQlkNqf/GqCCYxplL14BPF
         mJcQKSd4MkJFNYG8yY/I/vZeyQMkUtRBvz5QqGLpS+F8qs55bGa+YYnJBbqaLveugrfG
         0e/T3CCMNuB5gHEWdsX9Una3W4NwFUS0Gj8SCi3uYmTwvJg+HykApV031G9pPcxBdLDh
         cEMhx9XiUgWyh39mV2Z8Z/5/G+B+G83MuwnEhobcdE503JR8xWM6VHyGYUf5L+0d0LU+
         qNl5yNHQIm4lVqB0WKEiE/8JdzHo3CONH2J9V2yE1iY8bU3WxMpcTWWw6mhE4nt/DyGl
         yuTQ==
X-Gm-Message-State: ACgBeo2aWqhdi6RBwLIKTey+1N+IDdGx297D0G/j86xmxaq8vCtGeSUL
        KpWptkCwYSgy+7d2pIaZa42ind/3gSwmoPGDArzwQv9z
X-Google-Smtp-Source: AA6agR4maDZ21Hd5gSvCmR55mP6vt2zo0UN3BkxGrL5h6uOldjrGpqHqhmhzFU8DC4p/awKD8EU88ACosTncsEcCtZ0=
X-Received: by 2002:a05:6402:24a4:b0:440:8c0c:8d2b with SMTP id
 q36-20020a05640224a400b004408c0c8d2bmr16728708eda.311.1660626141850; Mon, 15
 Aug 2022 22:02:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220811001654.1316689-1-kuifeng@fb.com> <20220811001654.1316689-2-kuifeng@fb.com>
In-Reply-To: <20220811001654.1316689-2-kuifeng@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 15 Aug 2022 22:02:10 -0700
Message-ID: <CAEf4Bzab06-dfmd3CpRekdQJ1gw5yFJJGJ5G-vN05Dx3+AOkGQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/3] bpf: Parameterize task iterators.
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kernel-team@fb.com, yhs@fb.com
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

On Wed, Aug 10, 2022 at 5:17 PM Kui-Feng Lee <kuifeng@fb.com> wrote:
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
>  include/linux/bpf.h            |  29 ++++++++
>  include/uapi/linux/bpf.h       |   8 +++
>  kernel/bpf/task_iter.c         | 126 ++++++++++++++++++++++++++-------
>  tools/include/uapi/linux/bpf.h |   8 +++
>  4 files changed, 147 insertions(+), 24 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 11950029284f..6bbe53d06faa 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1716,8 +1716,37 @@ int bpf_obj_get_user(const char __user *pathname, int flags);
>         extern int bpf_iter_ ## target(args);                   \
>         int __init bpf_iter_ ## target(args) { return 0; }
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
> + */
> +enum bpf_iter_task_type {
> +       BPF_TASK_ITER_ALL = 0,
> +       BPF_TASK_ITER_TID,
> +       BPF_TASK_ITER_TGID,
> +};
> +
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

You don't seem to use pid_fd in bpf_iter_aux_info at all, is that
right? Drop it? And for tid/tgid, I'd use kernel-side terminology for
this internal data structure and just have single u32 pid here. Then
type determines whether you are iterating tasks or task leaders
(processes), no ambiguity.

>  };
>
>  typedef int (*bpf_iter_attach_target_t)(struct bpf_prog *prog,
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index ffcbf79a556b..6328aca0cf5c 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -91,6 +91,14 @@ union bpf_iter_link_info {
>         struct {
>                 __u32   map_fd;
>         } map;
> +       /*
> +        * Parameters of task iterators.
> +        */
> +       struct {
> +               __u32   tid;
> +               __u32   tgid;
> +               __u32   pid_fd;
> +       } task;
>  };
>

[...]
