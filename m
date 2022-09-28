Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3AE15EEA25
	for <lists+bpf@lfdr.de>; Thu, 29 Sep 2022 01:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbiI1XgT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Sep 2022 19:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbiI1XgS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Sep 2022 19:36:18 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AEC8EFF48
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 16:36:17 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id a41so19241617edf.4
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 16:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Al6xx6pGUoieBqlfuOOZMrsmXaCae2lTePEYq3eZepU=;
        b=TyFL8Ra0DM1iHft2/OXQgGrndKg4Qyw0hy/ot/GUu9UAOhyV1qnbwuyM3kPQLqQg5z
         FVKtyiXWpWD0VURgxnnmLlWW4+3yeBf2S2vz433hMXe1VBQg1284jw1rMPUjYWEq82CT
         V395cYunFYNjRhSKcIJk8Bp78d8LRNvHLndvwSHZp1ap9VdFLvKPNhlnHtMUET+zF+SP
         pbT0dtYA1k90zZY31cAxIaQMesu/gX6o3VqlDRFLZLJrUBm0Ab52np3/w5c0yJW3y/+E
         pwdQ0pgzjaybIIL/J81FmEOMVYzkV+kI57c/hv8Z4djWH77x2TFTH1neNb30vHiCk5uB
         UCdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Al6xx6pGUoieBqlfuOOZMrsmXaCae2lTePEYq3eZepU=;
        b=sgBXnbl6ScgN0QtdwEBeokD9p6gjEm5GEwRo9FLarUeb1WMlTg860+iScfal1DTz98
         Em7/NM7Ify2NSrTXdP2TCq/6Mu3pZnOuXOu43HCliySb5aOoYKenqErNbtULJ1iLdByj
         FU9i0axVahCT8h9nzdcm+Y7zNMBOdnqK1iutv5gxiPIoihAtVXgcs7did+ySK1yzJBpc
         yt2VLr+pLWGQefsUDGetVdnwLc7OjpIfG6GYBtTYrR9IBYFyHbbiddU0aPmL1uVLOwzP
         zw7O7QTH7FEDNMhMN1JOxueLuyclyBzVm181qbz95Hc7AqRshiQV/ZXJdTwKVMdap5w1
         Wf7Q==
X-Gm-Message-State: ACrzQf1lmkVhAxKVEvYVPqV0dgOBI6YKSfth6TjMVazWvcNKkbpeo+co
        g1slIH/49FpwgVq3b1q8g+ryoAJ1DnSsER7FcgE=
X-Google-Smtp-Source: AMsMyM5ygMPT5NT7ZtQEhuaQOJ0+DUwFY8JrBH3qFFqKG/K1CCTn090EtfKz+UZJVsMYkQELFBU7JFGWG19pB5/F0+A=
X-Received: by 2002:aa7:c549:0:b0:457:421d:449c with SMTP id
 s9-20020aa7c549000000b00457421d449cmr477920edr.260.1664408175384; Wed, 28 Sep
 2022 16:36:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220926184957.208194-1-kuifeng@fb.com> <20220926184957.208194-2-kuifeng@fb.com>
In-Reply-To: <20220926184957.208194-2-kuifeng@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 28 Sep 2022 16:36:02 -0700
Message-ID: <CAEf4BzZ=DvdRkVALjBKUC9OagJa-n2SFza9G6WTwmBtzxBPL=w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v11 1/5] bpf: Parameterize task iterators.
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

On Mon, Sep 26, 2022 at 11:50 AM Kui-Feng Lee <kuifeng@fb.com> wrote:
>
> Allow creating an iterator that loops through resources of one
> thread/process.
>
> People could only create iterators to loop through all resources of
> files, vma, and tasks in the system, even though they were interested
> in only the resources of a specific task or process.  Passing the
> additional parameters, people can now create an iterator to go
> through all resources or only the resources of a task.
>
> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> Acked-by: Yonghong Song <yhs@fb.com>
> ---
>  include/linux/bpf.h            |  25 +++++
>  include/uapi/linux/bpf.h       |   6 ++
>  kernel/bpf/task_iter.c         | 192 +++++++++++++++++++++++++++++----
>  tools/include/uapi/linux/bpf.h |   6 ++
>  4 files changed, 207 insertions(+), 22 deletions(-)
>

[...]

> +static int bpf_iter_attach_task(struct bpf_prog *prog,
> +                               union bpf_iter_link_info *linfo,
> +                               struct bpf_iter_aux_info *aux)
> +{
> +       unsigned int flags;
> +       struct pid_namespace *ns;
> +       struct pid *pid;
> +       pid_t tgid;
> +
> +       if ((!!linfo->task.tid + !!linfo->task.pid + !!linfo->task.pid_fd) > 1)
> +               return -EINVAL;
> +
> +       aux->task.type = BPF_TASK_ITER_ALL;
> +       if (linfo->task.tid != 0) {
> +               aux->task.type = BPF_TASK_ITER_TID;
> +               aux->task.pid = linfo->task.tid;
> +       }
> +       if (linfo->task.pid != 0) {
> +               aux->task.type = BPF_TASK_ITER_TGID;
> +               aux->task.pid = linfo->task.pid;
> +       }
> +       if (linfo->task.pid_fd != 0) {
> +               aux->task.type = BPF_TASK_ITER_TGID;
> +               ns = task_active_pid_ns(current);
> +               if (IS_ERR(ns))
> +                       return PTR_ERR(ns);

doesn't seem like task_active_pid_ns() can fail (other places in
kernel never handle NULL or IS_ERR for this), so I dropped this IS_ERR
check

> +
> +               pid = pidfd_get_pid(linfo->task.pid_fd, &flags);
> +               if (IS_ERR(pid))
> +                       return PTR_ERR(pid);
> +
> +               tgid = pid_nr_ns(pid, ns);
> +               aux->task.pid = tgid;
> +               put_pid(pid);
> +       }
> +
> +       return 0;
> +}
> +

[...]
