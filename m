Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E694AE37B
	for <lists+bpf@lfdr.de>; Tue,  8 Feb 2022 23:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236989AbiBHWWv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 17:22:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386918AbiBHVU4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 16:20:56 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118A8C0612B8;
        Tue,  8 Feb 2022 13:20:56 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id e28so672764pfj.5;
        Tue, 08 Feb 2022 13:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZM1nSLJ2yy0XCOnwkMPhCfHL7dFUtelFO2BPDuqjW0Y=;
        b=GGu0TYe+F6jFKwY3Qz7/AocnUpRrUOF913L1zofAIQt1UG6+oeIoLnQhezQdyrf5FW
         twYJEH+murJL4QGvZhN9YOrUs8cf5dTvrKSdk66ZzFDoSmXXqCXOSHErIsApOXJxLgns
         sH5nFwMY56z1kyzyMMCQpSLCKozzdDBJ+VH3JX7a284jJKbJBxUrWqXSNnXnfZw893Ev
         J+mJiR32sX9jYB5tocb0ij60fqujUeR2oFQlxebhCKvJ+tEJi9tV8Axtj5xQD5/67uoQ
         mYT1/siSGgv2yACF0F1vMDB2pDB+VYNgx8gl1dva0NwzLjv5Vg73lwoTgJkjCvoQ2fp2
         2GxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZM1nSLJ2yy0XCOnwkMPhCfHL7dFUtelFO2BPDuqjW0Y=;
        b=JRe7Op2GL6zGANzYfNI8h+v0DisF1pxFRvxxYEMun88jShZ2yhcPaq9Nk4RLQdqCVe
         E1cSwgFKybobQZH/shOaPHVM4V4L63ff3T0x6AcJNloTzyC/gnYfBUHEx/7+NNkcaKcu
         5g+Pq2WCEUtn4g9HFmVeW5xXIKvH0zAyfCOWDXEKEhAv86ZBjKJ6TkD0VYZJSfljriRf
         n1CxULMG+ksFnwoIC6EIY+IaiGpPfH/8Aqt7rCoZQzz2H7s0g1tt8i+NtyBgD52+MCYy
         eXu2ANX6LuOSG9jH4uJG7H9Xp+0AotM8LOlZs/t2BJzKI6alXj2dJMFkvqZE7eGC5KsG
         MGyw==
X-Gm-Message-State: AOAM532OK7OdjnMS+yaIJ9u5CDRUwmGrHUdlx+5tqVyhdkJgTrxYLXgo
        FsgNfdMHJ3w0/DfScD8m5UFTwRT60JdwGiFPWrU=
X-Google-Smtp-Source: ABdhPJzLQ5OiBxETJ/n/pCVvGcsULw94LLCVu0lToYc6JXrDk7g5/B162zMjS/B4zCByuRgoxv3Qm0ohGX36u9EmKz0=
X-Received: by 2002:a05:6a00:2301:: with SMTP id h1mr6195909pfh.77.1644355255463;
 Tue, 08 Feb 2022 13:20:55 -0800 (PST)
MIME-Version: 1.0
References: <20220201205534.1962784-1-haoluo@google.com> <20220201205534.1962784-6-haoluo@google.com>
 <20220203180414.blk6ou3ccmod2qck@ast-mbp.dhcp.thefacebook.com>
 <CA+khW7jkJbvQrTx4oPJAoBZ0EOCtr3C2PKbrzhxj-7euBK8ojg@mail.gmail.com>
 <CAADnVQLZZ3SM2CDxnzgOnDgRtGU7+6wT9u5v4oFas5MnZF6DsQ@mail.gmail.com>
 <CA+khW7i+TScwPZ6-rcFKiXtxMm8hiZYJGH-wYb=7jBvDWg8pJQ@mail.gmail.com>
 <CAADnVQ+-29CS7nSXghKMgZjKte84L0nRDegUE0ObFm3d7E=eWw@mail.gmail.com> <CA+khW7iWd5MzZW_mCfgqHESi8okjNRiRMr0TM=CQzLkMsa_a5g@mail.gmail.com>
In-Reply-To: <CA+khW7iWd5MzZW_mCfgqHESi8okjNRiRMr0TM=CQzLkMsa_a5g@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 8 Feb 2022 13:20:44 -0800
Message-ID: <CAADnVQJcTAgcbwrOWO8EnbTdAcQ91HQmtpn7aKJGwHc=mEpJ1g@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v2 5/5] selftests/bpf: test for pinning for
 cgroup_view link
To:     Hao Luo <haoluo@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Tue, Feb 8, 2022 at 12:07 PM Hao Luo <haoluo@google.com> wrote:
>
> On Sat, Feb 5, 2022 at 8:29 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Feb 4, 2022 at 10:27 AM Hao Luo <haoluo@google.com> wrote:
> > > >
> > > > > In our use case, we can't ask the users who create cgroups to do the
> > > > > pinning. Pinning requires root privilege. In our use case, we have
> > > > > non-root users who can create cgroup directories and still want to
> > > > > read bpf stats. They can't do pinning by themselves. This is why
> > > > > inheritance is a requirement for us. With inheritance, they only need
> > > > > to mkdir in cgroupfs and bpffs (unprivileged operations), no pinning
> > > > > operation is required. Patch 1-4 are needed to implement inheritance.
> > > > >
> > > > > It's also not a good idea in our use case to add a userspace
> > > > > privileged process to monitor cgroupfs operations and perform the
> > > > > pinning. It's more complex and has a higher maintenance cost and
> > > > > runtime overhead, compared to the solution of asking whoever makes
> > > > > cgroups to mkdir in bpffs. The other problem is: if there are nodes in
> > > > > the data center that don't have the userspace process deployed, the
> > > > > stats will be unavailable, which is a no-no for some of our users.
> > > >
> > > > The commit log says that there will be a daemon that does that
> > > > monitoring of cgroupfs. And that daemon needs to mkdir
> > > > directories in bpffs when a new cgroup is created, no?
> > > > The kernel is only doing inheritance of bpf progs into
> > > > new dirs. I think that daemon can pin as well.
> > > >
> > > > The cgroup creation is typically managed by an agent like systemd.
> > > > Sounds like you have your own agent that creates cgroups?
> > > > If so it has to be privileged and it can mkdir in bpffs and pin too ?
> > >
> > > Ah, yes, we have our own daemon to manage cgroups. That daemon creates
> > > the top-level cgroup for each job to run inside. However, the job can
> > > create its own cgroups inside the top-level cgroup, for fine grained
> > > resource control. This doesn't go through the daemon. The job-created
> > > cgroups don't have the pinned objects and this is a no-no for our
> > > users.
> >
> > We can whitelist certain tracepoints to be sleepable and extend
> > tp_btf prog type to include everything from prog_type_syscall.
> > Such prog would attach to cgroup_mkdir and cgroup_release
> > and would call bpf_sys_bpf() helper to pin progs in new bpffs dirs.
> > We can allow prog_type_syscall to do mkdir in bpffs as well.
> >
> > This feature could be useful for similar monitoring/introspection tasks.
> > We can write a program that would monitor bpf prog load/unload
> > and would pin an iterator prog that would show debug info about a prog.
> > Like cat /sys/fs/bpf/progs.debug shows a list of loaded progs.
> > With this feature we can implement:
> > ls /sys/fs/bpf/all_progs.debug/
> > and each loaded prog would have a corresponding file.
> > The file name would be a program name, for example.
> > cat /sys/fs/bpf/all_progs.debug/my_prog
> > would pretty print info about 'my_prog' bpf program.
> >
> > This way the kernfs/cgroupfs specific logic from patches 1-4
> > will not be necessary.
> >
> > wdyt?
>
> Thanks Alexei. I gave it more thought in the last couple of days.
> Actually I think it's a good idea, more flexible. It gets rid of the
> need of a user space daemon for monitoring cgroup creation and
> destruction. We could monitor task creations and exits as well, so
> that we can export per-task information (e.g. task_vma_iter) more
> efficiently.

Yep. Monitoring task creation and exposing via bpf_iter sounds
useful too.

> A couple of thoughts when thinking about the details:
>
> - Regarding parameterized pinning, I don't think we can have one
> single bpf_iter_link object, but with different parameters. Because
> parameters are part of the bpf_iter_link (bpf_iter_aux_info). So every
> time we pin, we have to attach iter in order to get a new link object
> first. So we need to add attach and detach in bpf_sys_bpf().

Makes sense.
I'm adding bpf_link_create to bpf_sys_bpf as part of
the "lskel for kernel" patch set.
The detach is sys_close. It's already available.

> - We also need to add those syscalls for cleanup: (1) unlink for
> removing pinned obj and (2) rmdir for removing the directory in
> prog_type_syscall.

Yes. These two would be needed.
And obj_pin too.

> With these extensions, we can shift some of the bpf operations
> currently performed in system daemons into the kernel. IMHO it's a
> great thing, making system monitoring more flexible.

Awesome. Sounds like we're converging :)
