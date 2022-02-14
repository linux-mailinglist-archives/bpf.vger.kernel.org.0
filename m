Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663FD4B59E1
	for <lists+bpf@lfdr.de>; Mon, 14 Feb 2022 19:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357439AbiBNS3i (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Feb 2022 13:29:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242239AbiBNS3i (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Feb 2022 13:29:38 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF79D55480
        for <bpf@vger.kernel.org>; Mon, 14 Feb 2022 10:29:29 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id o12so15136117qke.5
        for <bpf@vger.kernel.org>; Mon, 14 Feb 2022 10:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LujYmaOiAVKwbl24zDMRkVK0oOkNk6En6jjb4+6/vg0=;
        b=sC41pwYIZcsyHeM4riL2XhpIwlYfMGBje75Rj+HudxZHIhKM+E6rYHKZqe+/7fbMT+
         IiJxF8OqiOEi5sA9qhyg3pIM97O+MxOOsl4X+5viD6G/qNFQvYYIaskxoepLqJ1F65ko
         dxegh1kp4yymDcZpQn3XLrLdbzGyweXesCRZU6mjvoIZq5zEoaw8cpYWcRYH7NoRR4ir
         Emijcxz+RJXdwIVnPYbDgHts6B6YXi7vruntHvYZM6ik2t7/SdoKUHYza+K4LGR2+Stk
         PWxFR8Ibr0dNM1yr+BJO2lekEBlsvqeGP1PCxGKgLIyFAaDmgKaaRS7yWztnyfOyjUCX
         lUbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LujYmaOiAVKwbl24zDMRkVK0oOkNk6En6jjb4+6/vg0=;
        b=byP/4/iIVflIkeWO8SNUVQj4pG8kzDswSnLHLf49o0WXH1aRgkJYPnJ4pTwolY7nSH
         8aSybLoQzoeRqhTQVMrIyTjP+g/T5689MfDz/coV3safioyXkRKHmvUtTtRodO8av/vT
         efKPsjA0gLjeu6xZ4zHcXtBKJVTSG+nRVqJUwY2D2uxA6caYtSpbtMoLE4UJOt1YSyoP
         ZnL948jWjM7Js/CMhEv3plkVp0iYDd0P52zV87WeeMIkjZLa9yt4JaJI5ojciyeQc1pi
         FfG2oBgJbvZbqZKHmOfQN6y0jetqcUXBz2tC/loLm5aop8NXOHMJKX/ddxp4+0FiXl8x
         ewFw==
X-Gm-Message-State: AOAM5324ZXp9/hElR5rhvVJHEH1dsJSTkoyfLeNw6SfS8ZpU3K0b9MN9
        9cN5SXWjcBrHgn+gu7YuUUWElflbEyvZ8TjvJS73xg==
X-Google-Smtp-Source: ABdhPJy0e45Pw9dVPsMbq1vVzeaoeYU+q23A4Yig8yos82am8dbn6uM2XBQC9vV7XwtSdU+xYqb4NM0PlWiPwKQhB0Q=
X-Received: by 2002:a05:620a:470a:: with SMTP id bs10mr77702qkb.583.1644863368736;
 Mon, 14 Feb 2022 10:29:28 -0800 (PST)
MIME-Version: 1.0
References: <20220201205534.1962784-1-haoluo@google.com> <20220201205534.1962784-6-haoluo@google.com>
 <20220203180414.blk6ou3ccmod2qck@ast-mbp.dhcp.thefacebook.com>
 <CA+khW7jkJbvQrTx4oPJAoBZ0EOCtr3C2PKbrzhxj-7euBK8ojg@mail.gmail.com>
 <CAADnVQLZZ3SM2CDxnzgOnDgRtGU7+6wT9u5v4oFas5MnZF6DsQ@mail.gmail.com>
 <CA+khW7i+TScwPZ6-rcFKiXtxMm8hiZYJGH-wYb=7jBvDWg8pJQ@mail.gmail.com>
 <CAADnVQ+-29CS7nSXghKMgZjKte84L0nRDegUE0ObFm3d7E=eWw@mail.gmail.com>
 <CA+khW7iWd5MzZW_mCfgqHESi8okjNRiRMr0TM=CQzLkMsa_a5g@mail.gmail.com> <CAADnVQJcTAgcbwrOWO8EnbTdAcQ91HQmtpn7aKJGwHc=mEpJ1g@mail.gmail.com>
In-Reply-To: <CAADnVQJcTAgcbwrOWO8EnbTdAcQ91HQmtpn7aKJGwHc=mEpJ1g@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Mon, 14 Feb 2022 10:29:17 -0800
Message-ID: <CA+khW7i46Rg8q=8goXdmuJuZ+NOuZ5AP6fSbSVzyqcU3C5iX4A@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v2 5/5] selftests/bpf: test for pinning for
 cgroup_view link
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
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

On Tue, Feb 8, 2022 at 1:20 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Feb 8, 2022 at 12:07 PM Hao Luo <haoluo@google.com> wrote:
> >
> > On Sat, Feb 5, 2022 at 8:29 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Fri, Feb 4, 2022 at 10:27 AM Hao Luo <haoluo@google.com> wrote:
> > > > >
> > > > > > In our use case, we can't ask the users who create cgroups to do the
> > > > > > pinning. Pinning requires root privilege. In our use case, we have
> > > > > > non-root users who can create cgroup directories and still want to
> > > > > > read bpf stats. They can't do pinning by themselves. This is why
> > > > > > inheritance is a requirement for us. With inheritance, they only need
> > > > > > to mkdir in cgroupfs and bpffs (unprivileged operations), no pinning
> > > > > > operation is required. Patch 1-4 are needed to implement inheritance.
> > > > > >
> > > > > > It's also not a good idea in our use case to add a userspace
> > > > > > privileged process to monitor cgroupfs operations and perform the
> > > > > > pinning. It's more complex and has a higher maintenance cost and
> > > > > > runtime overhead, compared to the solution of asking whoever makes
> > > > > > cgroups to mkdir in bpffs. The other problem is: if there are nodes in
> > > > > > the data center that don't have the userspace process deployed, the
> > > > > > stats will be unavailable, which is a no-no for some of our users.
> > > > >
> > > > > The commit log says that there will be a daemon that does that
> > > > > monitoring of cgroupfs. And that daemon needs to mkdir
> > > > > directories in bpffs when a new cgroup is created, no?
> > > > > The kernel is only doing inheritance of bpf progs into
> > > > > new dirs. I think that daemon can pin as well.
> > > > >
> > > > > The cgroup creation is typically managed by an agent like systemd.
> > > > > Sounds like you have your own agent that creates cgroups?
> > > > > If so it has to be privileged and it can mkdir in bpffs and pin too ?
> > > >
> > > > Ah, yes, we have our own daemon to manage cgroups. That daemon creates
> > > > the top-level cgroup for each job to run inside. However, the job can
> > > > create its own cgroups inside the top-level cgroup, for fine grained
> > > > resource control. This doesn't go through the daemon. The job-created
> > > > cgroups don't have the pinned objects and this is a no-no for our
> > > > users.
> > >
> > > We can whitelist certain tracepoints to be sleepable and extend
> > > tp_btf prog type to include everything from prog_type_syscall.
> > > Such prog would attach to cgroup_mkdir and cgroup_release
> > > and would call bpf_sys_bpf() helper to pin progs in new bpffs dirs.
> > > We can allow prog_type_syscall to do mkdir in bpffs as well.
> > >
> > > This feature could be useful for similar monitoring/introspection tasks.
> > > We can write a program that would monitor bpf prog load/unload
> > > and would pin an iterator prog that would show debug info about a prog.
> > > Like cat /sys/fs/bpf/progs.debug shows a list of loaded progs.
> > > With this feature we can implement:
> > > ls /sys/fs/bpf/all_progs.debug/
> > > and each loaded prog would have a corresponding file.
> > > The file name would be a program name, for example.
> > > cat /sys/fs/bpf/all_progs.debug/my_prog
> > > would pretty print info about 'my_prog' bpf program.
> > >
> > > This way the kernfs/cgroupfs specific logic from patches 1-4
> > > will not be necessary.
> > >
> > > wdyt?

Hi Alexei,

Actually, I found this almost worked, except that the tracepoints
cgroup_mkdir and cgroup_rmdir are not sleepable. They are inside a
spinlock's critical section with irq off. I guess one solution is to
offload the sleepable part of the bpf prog into a thread context. We
may create a dedicated kernel thread or use workqueue for this. Do you
have any advice?

> >
> > Thanks Alexei. I gave it more thought in the last couple of days.
> > Actually I think it's a good idea, more flexible. It gets rid of the
> > need of a user space daemon for monitoring cgroup creation and
> > destruction. We could monitor task creations and exits as well, so
> > that we can export per-task information (e.g. task_vma_iter) more
> > efficiently.
>
> Yep. Monitoring task creation and exposing via bpf_iter sounds
> useful too.
>
> > A couple of thoughts when thinking about the details:
> >
> > - Regarding parameterized pinning, I don't think we can have one
> > single bpf_iter_link object, but with different parameters. Because
> > parameters are part of the bpf_iter_link (bpf_iter_aux_info). So every
> > time we pin, we have to attach iter in order to get a new link object
> > first. So we need to add attach and detach in bpf_sys_bpf().
>
> Makes sense.
> I'm adding bpf_link_create to bpf_sys_bpf as part of
> the "lskel for kernel" patch set.
> The detach is sys_close. It's already available.
>
> > - We also need to add those syscalls for cleanup: (1) unlink for
> > removing pinned obj and (2) rmdir for removing the directory in
> > prog_type_syscall.
>
> Yes. These two would be needed.
> And obj_pin too.
>
> > With these extensions, we can shift some of the bpf operations
> > currently performed in system daemons into the kernel. IMHO it's a
> > great thing, making system monitoring more flexible.
>
> Awesome. Sounds like we're converging :)
