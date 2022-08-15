Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417C9594ECF
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 04:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240052AbiHPCoM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Aug 2022 22:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240489AbiHPCnz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Aug 2022 22:43:55 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5502A4F6E
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 16:08:27 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id d1so6761010qvs.0
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 16:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ARxz0Uc0r3OdrWMHnOVuj29xQ12QvKI0j4eZDWtjHRw=;
        b=ApqIM2XuXMM6wJjuLPvfWIwOL0KMTK11YejbnYml8l6b/g/uzAcgO3Q03haBshXwG+
         1dqxw5N9097U3tJb6U8MHv7rO4sIcU5D9mE4aRS+H0E2CTSzBrZq2/9CyfD5H0OKd+9u
         SG0amx6ywr6HRaOH/tPPuci80jA/oHLBHifgvjxck6iSaWc2QorYluzZw5C9YlX9uSTB
         jPSvc5r1ONgHiltVFrNI/mK/2JV2Yr9Gp36toBcpF1xdWqtko9k1b5sHPsHVDjBf6M3u
         e/1j1fH5UHUNJjT0Ng5y687fDgK2Rve92THNu7HtlmpqgnD67o6ow0QDU7ixv8hWqQJG
         Y/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ARxz0Uc0r3OdrWMHnOVuj29xQ12QvKI0j4eZDWtjHRw=;
        b=ek/2eVYGKjScmHLOC+OSLJpUR28rCBwpf7vXx4XeP10cNMRYoSffQwHRM7DA8pdy0s
         C4S9TynS7MvLGoES3xm3/3gl7lsnGRZEKaj412CZ/AvRTF6h9hkenzT7AaG6Tmd8DcgU
         GMR/CNct3Jhck6hM87fXnIaYj4FaMoDZvcowZBvpxUfKCkqUVVBfWO11a5HTytB+qxPi
         hJ7WMtA29PKA6LyfIOuXzaVn7jpDrdCEn9U4ikGFeIfBcRs2ExN8C2q/kJp4ni4GROBs
         yJ2RD3MyGwWc80ZR7gG85Qup1YjC7b+P2PhfqdwUuiu+/8GrroxZWwqdbLUDf0fpmZ0Q
         3dOw==
X-Gm-Message-State: ACgBeo2MpLe/qNEZv0uulLmv2hyKokL9Kp82O29TYperoF7+mQ45Uio9
        U/cC9F3ak4IeQWqLSHTgte8xgC6yG/bHFzDnTNK13g==
X-Google-Smtp-Source: AA6agR4kU1SWbzUzvHW0TQGyPddjlRnxprQueT/unBIHX31Pn7mZZwnmt+Yp1Wsbs5AlzJG6PifrSv6mjPXzGMUw5Qc=
X-Received: by 2002:a0c:9101:0:b0:473:9b:d92a with SMTP id q1-20020a0c9101000000b00473009bd92amr15475086qvq.17.1660604902997;
 Mon, 15 Aug 2022 16:08:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220811001654.1316689-1-kuifeng@fb.com> <20220811001654.1316689-2-kuifeng@fb.com>
In-Reply-To: <20220811001654.1316689-2-kuifeng@fb.com>
From:   Hao Luo <haoluo@google.com>
Date:   Mon, 15 Aug 2022 16:08:12 -0700
Message-ID: <CA+khW7jRFFLsF=th2WKi7ryXYJzG4LcgJSLoLxjhnAsObLkC_Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/3] bpf: Parameterize task iterators.
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kernel-team@fb.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Kui-Feng,

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

typos: resources and every.

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

We could remove this particular comment. It is kind of obvious.

> +       struct {
> +               __u32   tid;
> +               __u32   tgid;
> +               __u32   pid_fd;
> +       } task;
>  };
>
>  /* BPF syscall commands, see bpf(2) man-page for more details. */
> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index 8c921799def4..f2e21efe075d 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -12,6 +12,12 @@
>
>  struct bpf_iter_seq_task_common {
>         struct pid_namespace *ns;
> +       enum bpf_iter_task_type type;
> +       union {
> +               u32 tid;
> +               u32 tgid;
> +               u32 pid_fd;
> +       };
>  };
>
>  struct bpf_iter_seq_task_info {
> @@ -22,24 +28,40 @@ struct bpf_iter_seq_task_info {
>         u32 tid;
>  };
>
> -static struct task_struct *task_seq_get_next(struct pid_namespace *ns,
> +static struct task_struct *task_seq_get_next(struct bpf_iter_seq_task_common *common,
>                                              u32 *tid,
>                                              bool skip_if_dup_files)
>  {
>         struct task_struct *task = NULL;
>         struct pid *pid;
>
> +       if (common->type == BPF_TASK_ITER_TID) {
> +               if (*tid && *tid != common->tid)
> +                       return NULL;
> +               rcu_read_lock();
> +               pid = find_pid_ns(common->tid, common->ns);
> +               if (pid) {
> +                       task = get_pid_task(pid, PIDTYPE_PID);
> +                       *tid = common->tid;
> +               }
> +               rcu_read_unlock();

nit: this is ok. But I think the commonly used pattern (e.g. proc_pid_lookup) is

        rcu_read_lock();
        task = find_task_by_pid_ns(tid, ns);
        if (task)
                get_task_struct(task);
        rcu_read_unlock();

> +               return task;
> +       }
> +
>         rcu_read_lock();
>  retry:
> -       pid = find_ge_pid(*tid, ns);
> +       pid = find_ge_pid(*tid, common->ns);
>         if (pid) {
> -               *tid = pid_nr_ns(pid, ns);
> +               *tid = pid_nr_ns(pid, common->ns);
>                 task = get_pid_task(pid, PIDTYPE_PID);
> +
>                 if (!task) {
>                         ++*tid;
>                         goto retry;
> -               } else if (skip_if_dup_files && !thread_group_leader(task) &&
> -                          task->files == task->group_leader->files) {
> +               } else if ((skip_if_dup_files && !thread_group_leader(task) &&
> +                           task->files == task->group_leader->files) ||
> +                          (common->type == BPF_TASK_ITER_TGID &&
> +                           __task_pid_nr_ns(task, PIDTYPE_TGID, common->ns) != common->tgid)) {

Use task_tgid_nr_ns instead of __task_pid_nr_ns?

>                         put_task_struct(task);
>                         task = NULL;
>                         ++*tid;
> @@ -56,7 +78,8 @@ static void *task_seq_start(struct seq_file *seq, loff_t *pos)
>         struct bpf_iter_seq_task_info *info = seq->private;
>         struct task_struct *task;
>
> -       task = task_seq_get_next(info->common.ns, &info->tid, false);
> +       task = task_seq_get_next(&info->common, &info->tid, false);
> +
>         if (!task)
>                 return NULL;
>
> @@ -73,7 +96,8 @@ static void *task_seq_next(struct seq_file *seq, void *v, loff_t *pos)
>         ++*pos;
>         ++info->tid;
>         put_task_struct((struct task_struct *)v);
> -       task = task_seq_get_next(info->common.ns, &info->tid, false);
> +
> +       task = task_seq_get_next(&info->common, &info->tid, false);
>         if (!task)
>                 return NULL;
>
> @@ -117,6 +141,43 @@ static void task_seq_stop(struct seq_file *seq, void *v)
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
> +
> +       if (linfo->task.tid != 0) {
> +               aux->task.type = BPF_TASK_ITER_TID;
> +               aux->task.tid = linfo->task.tid;
> +       } else if (linfo->task.tgid != 0) {
> +               aux->task.type = BPF_TASK_ITER_TGID;
> +               aux->task.tgid = linfo->task.tgid;
> +       } else if (linfo->task.pid_fd != 0) {
> +               aux->task.type = BPF_TASK_ITER_TGID;
> +               pid = pidfd_get_pid(linfo->task.pid_fd, &flags);
> +               if (IS_ERR(pid))
> +                       return PTR_ERR(pid);
> +
> +               ns = task_active_pid_ns(current);
> +               if (IS_ERR(ns))
> +                       return PTR_ERR(ns);
> +
> +               tgid = pid_nr_ns(pid, ns);
> +               if (tgid <= 0)
> +                       return -EINVAL;

Is this just pid_vnr?

> +
> +               aux->task.tgid = tgid;
> +       } else {
> +               aux->task.type = BPF_TASK_ITER_ALL;
> +       }

The same question as Yonghong has. Do we need to enforce that at most
one of {tid, tgid, pid_fd} is non-zero?

> +
> +       return 0;
> +}
> +
>  static const struct seq_operations task_seq_ops = {
>         .start  = task_seq_start,
>         .next   = task_seq_next,
> @@ -137,8 +198,7 @@ struct bpf_iter_seq_task_file_info {
>  static struct file *
>  task_file_seq_get_next(struct bpf_iter_seq_task_file_info *info)
>  {
> -       struct pid_namespace *ns = info->common.ns;
> -       u32 curr_tid = info->tid;
> +       u32 saved_tid = info->tid;
>         struct task_struct *curr_task;
>         unsigned int curr_fd = info->fd;
>
> @@ -151,21 +211,18 @@ task_file_seq_get_next(struct bpf_iter_seq_task_file_info *info)
>                 curr_task = info->task;
>                 curr_fd = info->fd;
>         } else {
> -                curr_task = task_seq_get_next(ns, &curr_tid, true);
> +               curr_task = task_seq_get_next(&info->common, &info->tid, true);
>                  if (!curr_task) {
>                          info->task = NULL;
> -                        info->tid = curr_tid;
>                          return NULL;
>                  }
>
> -                /* set info->task and info->tid */
> +               /* set info->task */
>                 info->task = curr_task;
> -               if (curr_tid == info->tid) {
> +               if (saved_tid == info->tid)
>                         curr_fd = info->fd;
> -               } else {
> -                       info->tid = curr_tid;
> +               else
>                         curr_fd = 0;
> -               }
>         }
>
>         rcu_read_lock();
> @@ -186,9 +243,15 @@ task_file_seq_get_next(struct bpf_iter_seq_task_file_info *info)
>         /* the current task is done, go to the next task */
>         rcu_read_unlock();
>         put_task_struct(curr_task);
> +
> +       if (info->common.type == BPF_TASK_ITER_TID) {
> +               info->task = NULL;
> +               return NULL;
> +       }
> +

Do we need to set info->fd to 0? I am not sure if the caller reads
info->fd anywhere. I think it would be good to do some refactoring on
task_file_seq_get_next().

>         info->task = NULL;
>         info->fd = 0;
> -       curr_tid = ++(info->tid);
> +       saved_tid = ++(info->tid);
>         goto again;
>  }
>
> @@ -269,6 +332,17 @@ static int init_seq_pidns(void *priv_data, struct bpf_iter_aux_info *aux)
>         struct bpf_iter_seq_task_common *common = priv_data;
>
>         common->ns = get_pid_ns(task_active_pid_ns(current));
> +       common->type = aux->task.type;
> +       switch (common->type) {
> +       case BPF_TASK_ITER_TID:
> +               common->tid = aux->task.tid;
> +               break;
> +       case BPF_TASK_ITER_TGID:
> +               common->tgid = aux->task.tgid;
> +               break;
> +       default:

very nit: IMHO we could place a warning here.

> +               break;
> +       }
>         return 0;
>  }
>
> @@ -307,11 +381,10 @@ enum bpf_task_vma_iter_find_op {
>  static struct vm_area_struct *
>  task_vma_seq_get_next(struct bpf_iter_seq_task_vma_info *info)
>  {
> -       struct pid_namespace *ns = info->common.ns;
>         enum bpf_task_vma_iter_find_op op;
>         struct vm_area_struct *curr_vma;
>         struct task_struct *curr_task;
> -       u32 curr_tid = info->tid;
> +       u32 saved_tid = info->tid;
>

Why do we need to directly operate on info->tid while other task iters
(e.g. vma_iter) uses curr_tid? IMHO, prefer staying using curr_tid if
possible, for two reasons:
 - consistent with other iters.
 - decouple refactoring changes from the changes that introduce new features

>         /* If this function returns a non-NULL vma, it holds a reference to
>          * the task_struct, and holds read lock on vma->mm->mmap_lock.
> @@ -371,14 +444,13 @@ task_vma_seq_get_next(struct bpf_iter_seq_task_vma_info *info)
>                 }
>         } else {
>  again:
> -               curr_task = task_seq_get_next(ns, &curr_tid, true);
> +               curr_task = task_seq_get_next(&info->common, &info->tid, true);
>                 if (!curr_task) {
> -                       info->tid = curr_tid + 1;
> +                       info->tid++;
>                         goto finish;
>                 }
>
> -               if (curr_tid != info->tid) {
> -                       info->tid = curr_tid;
> +               if (saved_tid != info->tid) {
>                         /* new task, process the first vma */
>                         op = task_vma_iter_first_vma;
>                 } else {
> @@ -430,9 +502,12 @@ task_vma_seq_get_next(struct bpf_iter_seq_task_vma_info *info)
>         return curr_vma;
>
>  next_task:
> +       if (info->common.type == BPF_TASK_ITER_TID)
> +               goto finish;
> +
>         put_task_struct(curr_task);
>         info->task = NULL;
> -       curr_tid++;
> +       info->tid++;
>         goto again;
>
>  finish:
> @@ -533,6 +608,7 @@ static const struct bpf_iter_seq_info task_seq_info = {
>
>  static struct bpf_iter_reg task_reg_info = {
>         .target                 = "task",
> +       .attach_target          = bpf_iter_attach_task,
>         .feature                = BPF_ITER_RESCHED,
>         .ctx_arg_info_size      = 1,
>         .ctx_arg_info           = {
> @@ -551,6 +627,7 @@ static const struct bpf_iter_seq_info task_file_seq_info = {
>
>  static struct bpf_iter_reg task_file_reg_info = {
>         .target                 = "task_file",
> +       .attach_target          = bpf_iter_attach_task,
>         .feature                = BPF_ITER_RESCHED,
>         .ctx_arg_info_size      = 2,
>         .ctx_arg_info           = {
> @@ -571,6 +648,7 @@ static const struct bpf_iter_seq_info task_vma_seq_info = {
>
>  static struct bpf_iter_reg task_vma_reg_info = {
>         .target                 = "task_vma",
> +       .attach_target          = bpf_iter_attach_task,
>         .feature                = BPF_ITER_RESCHED,
>         .ctx_arg_info_size      = 2,
>         .ctx_arg_info           = {
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index ffcbf79a556b..6328aca0cf5c 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
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
>  /* BPF syscall commands, see bpf(2) man-page for more details. */
> --
> 2.30.2
>
