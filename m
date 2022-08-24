Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E568E5A03DD
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 00:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiHXWVA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 18:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiHXWU7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 18:20:59 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB827B1EE
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 15:20:58 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id h22so25897431ejk.4
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 15:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=h7vwJtsKRfXsATiIc2XKJhOiZx/wNHKi6X80s7oJyms=;
        b=nIga/k01j0LU201es6kHjIhxSZW1wOTUED3Do8GGbQcjqbqY1i+d7ISWJKQ4ed6EDd
         QG0Zrj44FhlDCHOUnd8BLe2XEcraqiJlFevOvGN3yHk0CToZmSjh93j5x4sg5LVvj5xr
         DoG6uVJqAIQp05eP4dEAQ8RSf6dhetvKLchPVCFxMgGz7IvyuCofJD7jgluTgrEJoIBY
         NeyBb0M5xvahp/Raj2j0K5Oyk1Uhhe7fZpJ9AeGfXY99783nzAHS9VAghyXLen2NBp/Y
         b8imw8/sy0BoVYxIKoaj6Ed21o8NZ8JmXTUpkQXftrV0EPzitzO7F6jV+Voooq7lCoiV
         89AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=h7vwJtsKRfXsATiIc2XKJhOiZx/wNHKi6X80s7oJyms=;
        b=mR8LG88i2DxEX/MbJtaNkwWRfbKOjN/LB6DpBkK6EnWaMuEZQxhfbQeTQwbh8XXuGW
         iqjrfAC9N8gdw+Snxa4zN5KoZAyhhrRuNJc1opgB2DejJHiGrdEtCs8Xmrxbrods1FsK
         7BZ0jfUGER8EZiPVcNiBBSU/g8T5o3PcJ0jMNTSQ88X+nLWYS40icJEANPZ0n3l8oi61
         NrpCBE7IKbU9PbDLcq4/FY0328PotgfxtqoP/CZozD1rB8BXPobngCWcmRXyXjryshcv
         ZqsG2BcE+25ispd3REFxtrCt1kgbr1w0WkJDh+e49Dok4Lvq+QosiD4Q+JUPu8WgvYlV
         ksNA==
X-Gm-Message-State: ACgBeo2bEnXlNu7+ofWtOBQQeawoSDdIgRtkEuVf4HGkLKhzPriC4lnH
        4saDDgEUEqSoUh9IWXVjVL/0rFZbMCiqugS3FXc=
X-Google-Smtp-Source: AA6agR5baNb1wqwXsvDl5wus/jSrW475PWcIYhyMPayBapSDU6gumwNniXzOUA7ab1JgEH07zyuYIOBptUHPQgnm9LU=
X-Received: by 2002:a17:906:844f:b0:73d:56b6:7e3d with SMTP id
 e15-20020a170906844f00b0073d56b67e3dmr633092ejy.545.1661379656611; Wed, 24
 Aug 2022 15:20:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220819220927.3409575-1-kuifeng@fb.com> <20220819220927.3409575-2-kuifeng@fb.com>
In-Reply-To: <20220819220927.3409575-2-kuifeng@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 24 Aug 2022 15:20:45 -0700
Message-ID: <CAEf4Bzai7s1E6Y5=+URKXvSO7h8NJ6aNLxZCQrTq2ucTUp=S_Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 1/4] bpf: Parameterize task iterators.
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kernel-team@fb.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Aug 19, 2022 at 3:09 PM Kui-Feng Lee <kuifeng@fb.com> wrote:
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
>  include/linux/bpf.h            |  25 +++++++
>  include/uapi/linux/bpf.h       |   6 ++
>  kernel/bpf/task_iter.c         | 116 ++++++++++++++++++++++++++-------
>  tools/include/uapi/linux/bpf.h |   6 ++
>  4 files changed, 129 insertions(+), 24 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 39bd36359c1e..59712dd917d8 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1729,8 +1729,33 @@ int bpf_obj_get_user(const char __user *pathname, int flags);
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

typos: resources, every

> + */
> +enum bpf_iter_task_type {
> +       BPF_TASK_ITER_ALL = 0,
> +       BPF_TASK_ITER_TID,
> +       BPF_TASK_ITER_TGID,
> +};
> +

[...]

>         rcu_read_lock();
>  retry:
> -       pid = find_ge_pid(*tid, ns);
> +       pid = find_ge_pid(*tid, common->ns);
>         if (pid) {
> -               *tid = pid_nr_ns(pid, ns);
> +               *tid = pid_nr_ns(pid, common->ns);
>                 task = get_pid_task(pid, PIDTYPE_PID);
>                 if (!task) {
>                         ++*tid;
>                         goto retry;
> -               } else if (skip_if_dup_files && !thread_group_leader(task) &&
> -                          task->files == task->group_leader->files) {
> +               } else if ((skip_if_dup_files && !thread_group_leader(task) &&
> +                           task->files == task->group_leader->files) ||
> +                          (common->type == BPF_TASK_ITER_TGID &&
> +                           __task_pid_nr_ns(task, PIDTYPE_TGID, common->ns) != common->pid)) {

it gets super hard to follow this logic, would a simple helper
function to calculate this condition (and maybe some comments to
explain the logic behind these checks?) make it a bit more readable?

>                         put_task_struct(task);
>                         task = NULL;
>                         ++*tid;
> @@ -56,7 +73,7 @@ static void *task_seq_start(struct seq_file *seq, loff_t *pos)
>         struct bpf_iter_seq_task_info *info = seq->private;
>         struct task_struct *task;
>
> -       task = task_seq_get_next(info->common.ns, &info->tid, false);
> +       task = task_seq_get_next(&info->common, &info->tid, false);
>         if (!task)
>                 return NULL;
>
> @@ -73,7 +90,7 @@ static void *task_seq_next(struct seq_file *seq, void *v, loff_t *pos)
>         ++*pos;
>         ++info->tid;
>         put_task_struct((struct task_struct *)v);
> -       task = task_seq_get_next(info->common.ns, &info->tid, false);
> +       task = task_seq_get_next(&info->common, &info->tid, false);
>         if (!task)
>                 return NULL;
>
> @@ -117,6 +134,48 @@ static void task_seq_stop(struct seq_file *seq, void *v)
>                 put_task_struct((struct task_struct *)v);
>  }
>
> +static int bpf_iter_attach_task(struct bpf_prog *prog,
> +                               union bpf_iter_link_info *linfo,
> +                               struct bpf_iter_aux_info *aux)
> +{
> +       unsigned int flags;
> +       struct pid_namespace *ns;
> +       struct pid *pid;
> +       pid_t tgid;

it seems it would be simpler to first check that at most one of
tid/pid/pid_fd is set instead of making sure that aux->task.type
wasn't already set.

How about

if (!!linfo->task.tid + !!linfo->task.pid + !!linfo->task.pid_fd > 1)
    return -EINVAL;

?

> +
> +       aux->task.type = BPF_TASK_ITER_ALL;
> +       if (linfo->task.tid != 0) {
> +               aux->task.type = BPF_TASK_ITER_TID;
> +               aux->task.pid = linfo->task.tid;
> +       }
> +       if (linfo->task.pid != 0) {
> +               if (aux->task.type != BPF_TASK_ITER_ALL)
> +                       return -EINVAL;
> +
> +               aux->task.type = BPF_TASK_ITER_TGID;
> +               aux->task.pid = linfo->task.pid;
> +       }
> +       if (linfo->task.pid_fd != 0) {
> +               if (aux->task.type != BPF_TASK_ITER_ALL)
> +                       return -EINVAL;
> +
> +               aux->task.type = BPF_TASK_ITER_TGID;
> +               ns = task_active_pid_ns(current);
> +               if (IS_ERR(ns))
> +                       return PTR_ERR(ns);
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
