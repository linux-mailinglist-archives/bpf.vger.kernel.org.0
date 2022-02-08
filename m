Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 667094AE377
	for <lists+bpf@lfdr.de>; Tue,  8 Feb 2022 23:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387299AbiBHWV6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 17:21:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386965AbiBHVfR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 16:35:17 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE503C0612BC
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 13:35:11 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id o3so235578qtm.12
        for <bpf@vger.kernel.org>; Tue, 08 Feb 2022 13:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1QB55jMTplcdYlabtTc/ZFlq8sXgFtNSlzk1Cu5qXMA=;
        b=iZduEqW1Fq+secAshROZBw3TS9gDpmD3ryna/5cqGsaGJ2+QnzS41ZgwQTjZUQ9aJR
         gX8vqmN5e/c3fNvEwjNsFvWwtwGJ0tN6K+2iBQQa9yPiLYoq+h0h2jytu8l8Xh9JR+yl
         FX7eiRLxeZHfZ1NtJnwq2v7AlL8+Peu4U8ZYlxe1iibUlnaJKvqp0hQrGbVkYWys0pOY
         drREZeKDwvBhuwBivdtTiFFuCdXozrp5Ti1v383N2E+6Y2wUGxQCbChlwXTf/siJuzV6
         v4nV5jyJhhWELNECeTjhYEayNGj/ks0Rt0irlfGha9y6oBckQxbD69Ub4SDCQVn3KpKm
         xzVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1QB55jMTplcdYlabtTc/ZFlq8sXgFtNSlzk1Cu5qXMA=;
        b=Gx3ilfMipIHJQO+lED2gFPYnQqoCjeN+g7bKjsq/chPFdTCqZUWvPe9gERH6A2OksN
         mh+q134yhDSLIYd+hFXaznMafZZF6/xcr4UamNYJ2i9EmMNI5rcisS2tJ3+ItJtIH5aN
         qbXsjInxXCgfs6lAdjG5hcSbPVCy1vc7N4sA9LOyOvnDarzUjBzgV94B9nQzYWKUfnqv
         IXGKyF+ifAJ51EnA6fOv7BmccluBA2IWVhMQLQKAiOyQ+K4Vw5d10RNAqhRaGv/ubpD1
         N+mgfm/l+P6yikDo9d17gP3YSCy1FYLZmTPaQQ8OkLVaKGsAMybXKAX3+OmLWfipe3u8
         gpHw==
X-Gm-Message-State: AOAM530o6OPIl3ufvU54Ra6RuxXS+sodl9t6Wo20TaV08SSjeqlENn23
        CbNfqCpIucWHumRsWrrFPmVyN+aCCiLApaFmskkpCA==
X-Google-Smtp-Source: ABdhPJyXNmgVa1X/Pv0CtstbtUswazDKyzLAkCK1vpTiTSNw68kUrI19g5f1phL6dQvakDtVGrP6eaEHW7qWfUirjOY=
X-Received: by 2002:ac8:5aca:: with SMTP id d10mr4450416qtd.565.1644356110551;
 Tue, 08 Feb 2022 13:35:10 -0800 (PST)
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
Date:   Tue, 8 Feb 2022 13:34:59 -0800
Message-ID: <CA+khW7h1n9Np3O3DvMYc272ivPwCHtWVy=1cvQZMLzekfhpeZg@mail.gmail.com>
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
        autolearn=unavailable autolearn_force=no version=3.4.6
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

Right. :)

Thank you for proposing this solution. This really helps! I'm going to
work on a prototype.
