Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043B5588358
	for <lists+bpf@lfdr.de>; Tue,  2 Aug 2022 23:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbiHBVRm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Aug 2022 17:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiHBVRm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Aug 2022 17:17:42 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D5BCE3F
        for <bpf@vger.kernel.org>; Tue,  2 Aug 2022 14:17:40 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id r4so11450899edi.8
        for <bpf@vger.kernel.org>; Tue, 02 Aug 2022 14:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=m8aoBoxWmgm+a72uY+fCUuESbuFs11nCOffbfRkxisY=;
        b=gt76jp+1hgKJuVyWIasCgM+VduMJPTlF+RpYcdfWgdb42aX5qQnck+mjkgz4y5uxjO
         db4kUr1fOlGg3NPeK3UAYrCEHU8ItgqXXf/thTcuMIHozJ2kCZBbdiYNa4WXsklIoCR6
         A0vPXnemT2TytVjdKr8K07FikcWPQ7lKK4WyWU9hPM7L+W52XJKAk/1fgSAJ0lh0QZ1B
         j6KLnx2DgN69k+Bs31JrSLqRn0Ih6tRHYPckPP5WtEO4bC2ZJiNs0YDyTi696H4ebG2V
         W7rGtQI39s+TDlPzSeVFZZzud6ak7mOJFPhPPzBNS/RmhcEAskvBQiFaBiNPOqtt9S7P
         dayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=m8aoBoxWmgm+a72uY+fCUuESbuFs11nCOffbfRkxisY=;
        b=l/djSzPweM+XEXIYgGoAGhcdnC75SfaT1QQMK2Vflg72+IbhIUA0VTccEsNVTODKe8
         XirSBvEWulIsdZDipzvzm8aFWSQ/mMlM2+6p/KnPqFgnLkKbNsoZJFVl30CdtpO8gB98
         O12J1EEFGvGDgUF03r4vebyF9G7yGhYI8CS52B3RUuAwnbzMXYfuFtWeeE4pE2PUeh11
         81EPvbWma2iIhJkRKn2tfZwI+5q8xbdm4KJRc0ESLbQHD4bmFFDUj8cj3ihp05oeigEK
         hZ296ABO0A7yt2o+rqkoWS2cEUiVxjWpU03A9hiBlwVB2R05WgykVbJ0jC8Odwzdgmem
         CPMg==
X-Gm-Message-State: AJIora/fovjwU4oWrXIDBLle+K/lRy/MVAJVi4E0mGNkNPkPvvnDGsHG
        PgYygXfYKakw4W+IploG2cjchWv6xn1FMaI2dcw=
X-Google-Smtp-Source: AGRyM1uf57jqnmRdFXAHgBvBB+FM724mVkyzF0pNpEeqBJkBfiAlrv7kF3x/sy/N+ZCrhwaxudvldM41kb1q5ZC5GdM=
X-Received: by 2002:a05:6402:5108:b0:43b:e395:d2fb with SMTP id
 m8-20020a056402510800b0043be395d2fbmr22894339edd.260.1659475059271; Tue, 02
 Aug 2022 14:17:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220801232649.2306614-1-kuifeng@fb.com> <20220801232649.2306614-2-kuifeng@fb.com>
 <CAEf4BzZqwoCecuUTe=LGBBrTWMp_bCttik1fkmRF1rBXxBYPAw@mail.gmail.com> <9ab00aa58259d9dd7b45fdf860423e86612b591d.camel@fb.com>
In-Reply-To: <9ab00aa58259d9dd7b45fdf860423e86612b591d.camel@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 2 Aug 2022 14:17:27 -0700
Message-ID: <CAEf4BzZjpb514dpzxfeE_OzV6jTajObxc3UNpX1Wyr+0ZM7pLQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Parameterize task iterators.
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>, Yonghong Song <yhs@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
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

On Tue, Aug 2, 2022 at 9:42 AM Kui-Feng Lee <kuifeng@fb.com> wrote:
>
> On Mon, 2022-08-01 at 20:30 -0700, Andrii Nakryiko wrote:
> > On Mon, Aug 1, 2022 at 4:27 PM Kui-Feng Lee <kuifeng@fb.com> wrote:
> > >
> > > Allow creating an iterator that loops through resources of one
> > > task/thread.
> > >
> > > People could only create iterators to loop through all resources of
> > > files, vma, and tasks in the system, even though they were
> > > interested
> > > in only the resources of a specific task or process.  Passing the
> > > additional parameters, people can now create an iterator to go
> > > through all resources or only the resources of a task.
> > >
> > > Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> > > ---
> > >  include/linux/bpf.h            |  4 ++
> > >  include/uapi/linux/bpf.h       | 23 +++++++++
> > >  kernel/bpf/task_iter.c         | 93 ++++++++++++++++++++++++++----
> > > ----
> > >  tools/include/uapi/linux/bpf.h | 23 +++++++++
> > >  4 files changed, 121 insertions(+), 22 deletions(-)
> > >
> > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > index 11950029284f..3c26dbfc9cef 100644
> > > --- a/include/linux/bpf.h
> > > +++ b/include/linux/bpf.h
> > > @@ -1718,6 +1718,10 @@ int bpf_obj_get_user(const char __user
> > > *pathname, int flags);
> > >
> > >  struct bpf_iter_aux_info {
> > >         struct bpf_map *map;
> > > +       struct {
> > > +               u32     tid;
> > > +               u8      type;
> > > +       } task;
> > >  };
> > >
> > >  typedef int (*bpf_iter_attach_target_t)(struct bpf_prog *prog,
> > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > index ffcbf79a556b..ed5ba501609f 100644
> > > --- a/include/uapi/linux/bpf.h
> > > +++ b/include/uapi/linux/bpf.h
> > > @@ -87,10 +87,33 @@ struct bpf_cgroup_storage_key {
> > >         __u32   attach_type;            /* program attach type
> > > (enum bpf_attach_type) */
> > >  };
> > >
> > > +enum bpf_task_iter_type {
> > > +       BPF_TASK_ITER_ALL = 0,
> > > +       BPF_TASK_ITER_TID,
> > > +};
> > > +
> > >  union bpf_iter_link_info {
> > >         struct {
> > >                 __u32   map_fd;
> > >         } map;
> > > +       /*
> > > +        * Parameters of task iterators.
> > > +        */
> > > +       struct {
> > > +               __u32   pid_fd;
> >
> > I was a bit late to the discussion about pidfd vs plain pid. I think
> > we should support both in this API. While pid_fd has some nice
> > guarantees like avoiding the risk of accidental PID reuse, in a lot
> > (if not all) cases where task/task_vma/task_file iterators are going
> > to be used this is never a risk, because pid will usually come from
> > some tracing BPF program (kprobe/tp/fentry/etc), like in case of
> > profiling, and then will be used by user-space almost immediately to
> > query some additional information (fetching relevant vma information
> > for profiling use case). So main benefit of pidfd is not that
> > relevant
> > for BPF tracing use cases, because PIDs are not going to be reused so
> > fast within such a short time frame.
> >
> > But pidfd does have downsides. It requires 2 syscalls (pidfd_open and
> > close) for each PID, it creates struct file for each such active
> > pidfd. So it will have non-trivial overhead for high-frequency BPF
> > iterator use cases (imagine querying some simple stats for a big set
> > of tasks, frequently: you'll spend more time in pidfd syscalls and
> > more resources just keeping corresponding struct file open than
> > actually doing useful BPF work). For simple BPF iter cases it will
> > unnecessarily complicate program flow while giving no benefit
> > instead.
>
> It is a good point to have more syscalls.
>
> >
> > So I propose we support both in UAPI. Internally either way we
> > resolve
> > to plain pid/tid, so this won't cause added maintenance burden. But
> > simple cases will keep simple, while more long-lived and/or
> > complicated ones will still be supported. We then can have
> > BPF_TASK_ITER_PIDFD vs BPF_TASK_ITER_TID to differentiate whether the
> > above __u32 pid_fd (which we should probably rename to something more
> > generic like "target") is pid FD or TID/PID. See also below about TID
> > vs PID.
> >
> > > +               /*
> > > +                * The type of the iterator.
> > > +                *
> > > +                * It can be one of enum bpf_task_iter_type.
> > > +                *
> > > +                * BPF_TASK_ITER_ALL (default)
> > > +                *      The iterator iterates over resources of
> > > everyprocess.
> > > +                *
> > > +                * BPF_TASK_ITER_TID
> > > +                *      You should also set *pid_fd* to iterate
> > > over one task.
> >
> > naming nit: we should decide whether we use TID (thread) and PID
> > (process) terminology (more usual for user-space) or PID (process ==
> > task == user-space thread) and TGID (thread group, i.e. user-space
> > process). I haven't investigated much what's we use most
> > consistently,
> > but curious to hear what others think.
> >
> > Also I can see use-cases where we want to iterate just specified task
> > (i.e., just specified thread) vs all the tasks that belong to the
> > same
> > process group (i.e., thread within process). Naming TBD, but we
> > should
> > have BPF_TASK_ITER_TID and BPF_TASK_ITER_TGID (or some other naming).
>
>
> I discussed with Yonghong about iterators over resources of all tasks
> of a process.  User code should create iterators for each thread of the
> process if necessary.  We may add the support of tgid if it is higly
> demanded.
>
> In a discussion of using pidfd, people mentioned to extend pidfd to
> threads if there is a good use-case.  It also applies to our case.
> Most of the time, if not always, vma & files are shared by all threads
> of a process.  So, an iteration over all resources of every threads of
> a process doesn't get obvious benefit.  It is also true for an iterator
> over the resources of a specific thread instead of a process.
>

Ok, so two different points here.

First, TID (thread) vs TGID (process) modes. I'd define TGID mode as:
a) user specifies some TID and we resolve that to thread group leader
TID (that is we resolve thread to process), and then iterate all
threads within that process. For TID (thread) mode, we accept
specified TID as exactly the thread we iterate (even if it's thread
group leader, we iterate only that specific thread, not all threads in
a process).

Second, about the point that all threads within a process share vma,
file table, etc. That's true. But you are forgetting about iter/task
that is iterating just tasks. TGID mode for such use case is very
useful. For task_vma/task_file we can probably do the same logic we
have today where if the thread has the same file table or mm_struct as
thread group leader, we skip such thread when iterating vmas and
files.

Thoughts?


> >
> > One might ask why do we need single-task mode if we can always stop
> > iteration from BPF program, but this is trivial only for iter/task,
> > while for iter/task_vma and iter/task_file it becomes inconvenient to
> > detect switch from one task to another. It costs us essentially
> > nothing to support this mode, so I advocate to do that.
> >
> > I have similar thoughts about cgroup iteration modes and actually
> > supporting cgroup_fd as target for task iterators (which will mean
> > iterating tasks belonging to provided cgroup(s)), but I'll reply on
> > cgroup iterator patch first, and we can just reuse the same cgroup
> > target specification between iter/cgroup and iter/task afterwards.
> >
> >
> > > +                */
> > > +               __u8    type;   /* BPF_TASK_ITER_* */
> > > +       } task;
> > >  };
> > >
> >
> > [...]
>
