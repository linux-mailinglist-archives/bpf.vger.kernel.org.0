Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961BA5A349F
	for <lists+bpf@lfdr.de>; Sat, 27 Aug 2022 06:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiH0EvI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 27 Aug 2022 00:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234210AbiH0EvG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 27 Aug 2022 00:51:06 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B810CD1277
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 21:51:04 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id fy31so6041062ejc.6
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 21:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ia5B9+CeAkcpqwpgh88xVAGfCtPwDTXAKD+zdnV5ufg=;
        b=eCX+/oaXQjyJs5jE2WtqN9Dad6IfOo0Q2lFAJJJIwNjjg88WKpEZDGpuAq7yhmnEQK
         q4BPxXIZO37PmyIq5Wu1bzKs5/2ymmxVswE3/ngANqv2dcLYFwL/MGe8g/78mpG9uiqx
         A2Vzsy3ixLej3Igy+jAgpcjIWyHM17ahaIEzIbvy7IqnvBj1k+Q3o2yL34BhJ60dhWZ5
         AJ+YpeNiNRbjXjZhprZ+JrvbSlzTiPxrWifZGz/aRIHFGe4QnnygythwzmPyh4TZhewW
         LSHoVH5jnugy8MiiJDkmpNxtM5EftxD7R/vao/qszNZyzBSdHoUpJToVQQQabD9VtvJb
         +HIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ia5B9+CeAkcpqwpgh88xVAGfCtPwDTXAKD+zdnV5ufg=;
        b=G3BaWzIiV72UrOPIvlqR2AQceYRUJSY0JwnC1EyRNR3v26IuKsgyq32A6gO5Wyyd6v
         NNtC2d8ksQo9V4SyP9gmOpWnHvZYh1lzmikhPnyOfdj4nKk3fo4F+vgYPhUHG5rUaWyC
         o3osR2VlaVXMFS386s98Fsf1wDhJ5d0BAG8wyZdNpNJ8a6f0ERZpKtxAWKj7Ps05sS+S
         GTeBi/Lx211QgG+8gKqyuy9aMylS9f56tQchPHjnPaDgRCsmMH5OF6wgw1qaHu+N161/
         7ciXz/7S80WebtFGfgVS/Jxp01d+HfpaOoMJjlhH9p99ohW04AtrHl6AWLRixty1CnIE
         dfTQ==
X-Gm-Message-State: ACgBeo1qu6fAPci3DtfUiIVACJ4sae5SPbb8UUbI+dV+YkT039vnD3tR
        KkoIUEuAgjA/0NVoBBsVsfq7KHAs4q2NnvD31fI=
X-Google-Smtp-Source: AA6agR79NNoHGWuzJrHbIbLz84BukwYrQCMIZYrtn+VeHrc+aVpKeueKwUJTM0WzTf558YtLKrMGJk9xQydfjQbmEjo=
X-Received: by 2002:a17:907:2d12:b0:731:6a4e:ceb0 with SMTP id
 gs18-20020a1709072d1200b007316a4eceb0mr7280573ejc.115.1661575863191; Fri, 26
 Aug 2022 21:51:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220819220927.3409575-1-kuifeng@fb.com> <20220819220927.3409575-2-kuifeng@fb.com>
 <CAEf4Bzai7s1E6Y5=+URKXvSO7h8NJ6aNLxZCQrTq2ucTUp=S_Q@mail.gmail.com>
 <52171bf63f54b311116988cefd275c0847396d45.camel@fb.com> <CAEf4BzZEVzh5eTjHt_PmDKMJMgtSKkTcGpidNGamyH3__38R9g@mail.gmail.com>
 <50a3d352b6098841eb691b435fde4dec05e22aaa.camel@fb.com>
In-Reply-To: <50a3d352b6098841eb691b435fde4dec05e22aaa.camel@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 26 Aug 2022 21:50:51 -0700
Message-ID: <CAEf4BzYPwCir27j8Gqn7SJ480VZZpBce=akYJ0VGqa+AB_UB-g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 1/4] bpf: Parameterize task iterators.
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>, Yonghong Song <yhs@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
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

On Fri, Aug 26, 2022 at 7:49 AM Kui-Feng Lee <kuifeng@fb.com> wrote:
>
> On Thu, 2022-08-25 at 14:13 -0700, Andrii Nakryiko wrote:
> > On Wed, Aug 24, 2022 at 5:16 PM Kui-Feng Lee <kuifeng@fb.com> wrote:
> > >
> > > On Wed, 2022-08-24 at 15:20 -0700, Andrii Nakryiko wrote:
> > > > On Fri, Aug 19, 2022 at 3:09 PM Kui-Feng Lee <kuifeng@fb.com>
> > > > wrote:
> > > > >
> > > > > Allow creating an iterator that loops through resources of one
> > > > > task/thread.
> > > > >
> > > > > People could only create iterators to loop through all
> > > > > resources of
> > > > > files, vma, and tasks in the system, even though they were
> > > > > interested
> > > > > in only the resources of a specific task or process.  Passing
> > > > > the
> > > > > additional parameters, people can now create an iterator to go
> > > > > through all resources or only the resources of a task.
> > > > >
> > > > > Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> > > > > ---
> > > > >  include/linux/bpf.h            |  25 +++++++
> > > > >  include/uapi/linux/bpf.h       |   6 ++
> > > > >  kernel/bpf/task_iter.c         | 116
> > > > > ++++++++++++++++++++++++++---
> > > > > ----
> > > > >  tools/include/uapi/linux/bpf.h |   6 ++
> > > > >  4 files changed, 129 insertions(+), 24 deletions(-)
> > > > >
> > > > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > > > index 39bd36359c1e..59712dd917d8 100644
> > > > > --- a/include/linux/bpf.h
> > > > > +++ b/include/linux/bpf.h
> > > > > @@ -1729,8 +1729,33 @@ int bpf_obj_get_user(const char __user
> > > > > *pathname, int flags);
> > > > >         extern int bpf_iter_ ## target(args);
> > > > > \
> > > > >         int __init bpf_iter_ ## target(args) { return 0; }
> > > > >
> > > > > +/*
> > > > > + * The task type of iterators.
> > > > > + *
> > > > > + * For BPF task iterators, they can be parameterized with
> > > > > various
> > > > > + * parameters to visit only some of tasks.
> > > > > + *
> > > > > + * BPF_TASK_ITER_ALL (default)
> > > > > + *     Iterate over resources of every task.
> > > > > + *
> > > > > + * BPF_TASK_ITER_TID
> > > > > + *     Iterate over resources of a task/tid.
> > > > > + *
> > > > > + * BPF_TASK_ITER_TGID
> > > > > + *     Iterate over reosurces of evevry task of a process /
> > > > > task
> > > > > group.
> > > >
> > > > typos: resources, every
> > > >
> > > > > + */
> > > > > +enum bpf_iter_task_type {
> > > > > +       BPF_TASK_ITER_ALL = 0,
> > > > > +       BPF_TASK_ITER_TID,
> > > > > +       BPF_TASK_ITER_TGID,
> > > > > +};
> > > > > +
> > > >
> > > > [...]
> > > >
> > > > >         rcu_read_lock();
> > > > >  retry:
> > > > > -       pid = find_ge_pid(*tid, ns);
> > > > > +       pid = find_ge_pid(*tid, common->ns);
> > > > >         if (pid) {
> > > > > -               *tid = pid_nr_ns(pid, ns);
> > > > > +               *tid = pid_nr_ns(pid, common->ns);
> > > > >                 task = get_pid_task(pid, PIDTYPE_PID);
> > > > >                 if (!task) {
> > > > >                         ++*tid;
> > > > >                         goto retry;
> > > > > -               } else if (skip_if_dup_files &&
> > > > > !thread_group_leader(task) &&
> > > > > -                          task->files == task->group_leader-
> > > > > > files) {
> > > > > +               } else if ((skip_if_dup_files &&
> > > > > !thread_group_leader(task) &&
> > > > > +                           task->files == task->group_leader-
> > > > > > files) ||
> > > > > +                          (common->type == BPF_TASK_ITER_TGID
> > > > > &&
> > > > > +                           __task_pid_nr_ns(task,
> > > > > PIDTYPE_TGID,
> > > > > common->ns) != common->pid)) {
> > > >
> > > > it gets super hard to follow this logic, would a simple helper
> > > > function to calculate this condition (and maybe some comments to
> > > > explain the logic behind these checks?) make it a bit more
> > > > readable?
> > >
> > > !matched_task(task, common, skip_if_dup_file)?
> > >
> > > bool matched_task(struct task_struct *task,
> > >                   struct bpf_iter_seq_task_common *common,
> > >                   bool skip_if_dup_file) {
> > >         /* Should not have the same 'files' if skip_if_dup_file is
> > > true
> > > */
> > >         bool diff_files_if =
> > >                 !skip_if_dup_file ||
> > >                 (thread_group_leader(task) &&
> > >                 task->file != task->gorup_leader->fies);
> > >         /* Should have the given tgid if the type is
> > > BPF_TASK_ITER_TGI
> > > */
> > >         bool have_tgid_if =
> > >                 common->type != BPF_TASK_ITER_TGID ||
> > >                 __task_pid_nr_ns(task, PIDTYPE_TGID,
> > >                 common->ns) == common->pid;
> > >         return diff_files_if && have_tgid_if;
> > > }
> > >
> > > How about this?
> > >
> >
> > Hm... "matched_task" doesn't mean much, tbh, so not really. I wanted
> > to suggest having a separate helper just for your TGID check and call
> > it something more meaningful like "task_belongs_to_tgid". Can't come
> > up with a good name for existing dup_file check, so I'd probably keep
> > it as is. But also seems like there is same_thread_group() helper in
> > include/linux/sched/signal.h, so let's look if we can use it, it
> > seems
> > like it's just comparing signal pointers (probably quite faster than
> > what you are doing right now).
> >
> > But looking at this some more made me realize that even if we specify
> > pid (tgid in kernel terms) we are still going to iterate through all
> > the tasks, essentially. Is that right? So TGID mode isn't great for
> > speeding up, we should point out to users that if they want to
> > iterate
> > files of the process, they probably want to use TID mode and set tid
> > to pid to use the early termination condition in TID.
> >
> > It wasn't obvious to me until I re-read this patch like 3 times and
> > wrote three different replies here :)
> >
> > But then I also went looking at what procfs doing for
> > /proc/<pid/task/* dirs. It does seem like there are faster ways to
> > iterate all threads of a process. See next_tid() which uses
> > next_thread(), etc. Can you please check those and see if we can have
> > faster in-process iteration?
> >
>
> I haven't notice this message until now.
> It looks like very promise.  I will add it to next version.

No worries. Thanks! Hopefully there is a way to make efficient
per-process file and vma iteration.

>
> >
> > > >
> > > > >                         put_task_struct(task);
> > > > >                         task = NULL;
> > > > >                         ++*tid;
> > > > > @@ -56,7 +73,7 @@ static void *task_seq_start(struct seq_file
> > > > > *seq,
> > > > > loff_t *pos)
> > > > >         struct bpf_iter_seq_task_info *info = seq->private;
> > > > >         struct task_struct *task;
> > > > >
> > > > > -       task = task_seq_get_next(info->common.ns, &info->tid,
> > > > > false);
> > > > > +       task = task_seq_get_next(&info->common, &info->tid,
> > > > > false);
> > > > >         if (!task)
> > > > >                 return NULL;
> > > > >
> >
> > [...]
>
