Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28644A9EF4
	for <lists+bpf@lfdr.de>; Fri,  4 Feb 2022 19:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377512AbiBDS1N (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Feb 2022 13:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237893AbiBDS1M (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Feb 2022 13:27:12 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD73BC061714
        for <bpf@vger.kernel.org>; Fri,  4 Feb 2022 10:27:11 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id bs32so5487016qkb.1
        for <bpf@vger.kernel.org>; Fri, 04 Feb 2022 10:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jeWAra30FXkZs/gRmR49z6lt/T+9ynnjq9B+AWcFc0M=;
        b=LOIf1tBuS1tAG6bCCiNP8m5VoC8AK9dgPZpaYYC8CMFPy2FtTuNt3HOG/39ywfFeXf
         2SvwmqypOW2WfYOvprujZf3zzwP7EZlK6Tw3mksOgbimD03VlJ4E2UTarrCm3HBAsDmp
         4DFmgTvJAJGS+bcOFGbM78sNuJ2xoCUsTqfsB4AD0F+L/YHeSKzm7Rr5uQMVIpEiqVr6
         UFVW2VMOW9OTwQEmkjRKzUTUGC4KESydLa4s3Te4ai8t98QE11qc9ljjjW8ZVTgFnvbW
         4u0WLxTWCwZezv2TYyo0d7dEK1Ejnt98unT3m6/txxJOAPuQ5QAugdqnsGnXMsrYuJjA
         7k6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jeWAra30FXkZs/gRmR49z6lt/T+9ynnjq9B+AWcFc0M=;
        b=0WlT8qfzgGb/L1x9h23/ZsO6CXUWPqkz1mGzTn54P4Rf+cs7Ybu/HycbkMzkcL7Pef
         U7DtX7lRZh1L2tvBVBvRj+P9NGuB86mYDScyhV04V69XlJk/4d9ST4fLPEfDQpX3BaZf
         f4M/Z2iGRR8scRl1xVSC66dAoJm+jYtWRSx3jhxBh9vaxaF7zuPYvfE6t6dfoezNCPOh
         heTmiO5zBOozn57rOHFU7/rYiGzF1PLcuWTLHbAfiGMSVACp6BJ7thLwVwDj+RgWAUS0
         3BD4y++6whsaHYB626szgIP1DW8vGrpnRJ/Fb9xo6lSnWtre00P7fcTWI0Od1/x+xeVi
         bsKA==
X-Gm-Message-State: AOAM533z7BLn9T7rTFwng0L2pUoN2+dtaeLm7JLTEf2HdpvJYryTdXMt
        rW7BcdSGRW+Ni7xGapHYNe9qEuNOUHeTbwvkEzZgUg==
X-Google-Smtp-Source: ABdhPJz8DFPAFaDlhPX2045fX9vYzX/NA6X+81wbKs9VCuJPZx20zm691CYXL4xR4mi3Q2U4HBn+P5UwHAgdFFvqsHs=
X-Received: by 2002:ae9:ed96:: with SMTP id c144mr241939qkg.221.1643999230713;
 Fri, 04 Feb 2022 10:27:10 -0800 (PST)
MIME-Version: 1.0
References: <20220201205534.1962784-1-haoluo@google.com> <20220201205534.1962784-6-haoluo@google.com>
 <20220203180414.blk6ou3ccmod2qck@ast-mbp.dhcp.thefacebook.com>
 <CA+khW7jkJbvQrTx4oPJAoBZ0EOCtr3C2PKbrzhxj-7euBK8ojg@mail.gmail.com> <CAADnVQLZZ3SM2CDxnzgOnDgRtGU7+6wT9u5v4oFas5MnZF6DsQ@mail.gmail.com>
In-Reply-To: <CAADnVQLZZ3SM2CDxnzgOnDgRtGU7+6wT9u5v4oFas5MnZF6DsQ@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Fri, 4 Feb 2022 10:26:59 -0800
Message-ID: <CA+khW7i+TScwPZ6-rcFKiXtxMm8hiZYJGH-wYb=7jBvDWg8pJQ@mail.gmail.com>
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
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 3, 2022 at 7:33 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Feb 3, 2022 at 2:46 PM Hao Luo <haoluo@google.com> wrote:
> >
> > On Thu, Feb 3, 2022 at 10:04 AM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Tue, Feb 01, 2022 at 12:55:34PM -0800, Hao Luo wrote:
> > > > +
> > > > +SEC("iter/cgroup_view")
> > > > +int dump_cgroup_lat(struct bpf_iter__cgroup_view *ctx)
> > > > +{
> > > > +     struct seq_file *seq = ctx->meta->seq;
> > > > +     struct cgroup *cgroup = ctx->cgroup;
> > > > +     struct wait_lat *lat;
> > > > +     u64 id;
> > > > +
> > > > +     BPF_SEQ_PRINTF(seq, "cgroup_id: %8lu\n", cgroup->kn->id);
> > > > +     lat = bpf_map_lookup_elem(&cgroup_lat, &id);
> > >
> > > Looks like "id = cgroup->kn->id" assignment is missing here?
> > >
> >
> > Ah, yes. I'll fix it.
> >
> > > Thanks a lot for this test. It explains the motivation well.
> > >
> > > It seems that the patches 1-4 are there to automatically
> > > supply cgroup pointer into bpf_iter__cgroup_view.
> > >
> > > Since user space needs to track good part of cgroup dir opreations
> > > can we task it with the job of patches 1-4 as well?
> > > It can register notifier for cgroupfs operations and
> > > do mkdir in bpffs similarly _and_ parametrize 'view' bpf program
> > > with corresponding cgroup_id.
> > > Ideally there is no new 'view' program and it's a subset of 'iter'
> > > bpf program. They're already parametrizable.
> > > When 'iter' is pinned the user space can tell it which object it should
> > > iterate on. The 'view' will be an interator of one element and
> > > argument to it can be cgroup_id.
> > > When user space pins the same 'view' program in a newly created bpffs
> > > directory it will parametrize it with a different cgroup_id.
> > > At the end the same 'view' program will be pinned in multiple directories
> > > with different cgroup_id arguments.
> > > This patch 5 will look very much the same, but patches 1-4 will not be
> > > necessary.
> > > Of course there are races between cgroup create/destroy and bpffs
> > > mkdir, prog pin operatiosn, but they will be there regardless.
> > > The patch 1-4 approach is not race free either.
> >
> > Right. I tried to minimize the races between cgroupfs and bpffs in
> > this patchset. The cgroup and kernfs APIs called in this patchset
> > guarantee that the cgroup and kernfs objects are alive once get. Some
> > states in the objects such as 'id' should be valid at least.
> >
> > > Will that work?
> >
> > Thanks Alexei for the idea.
> >
> > The parameterization part sounds good. By 'parametrize', do you mean a
> > variable in iter prog (like the 'pid' variable in bpf_iter_task_vma.c
> > [1])? or some metadata of the program? I assume it's program's
> > metadata. Either parameterizing with cgroup_id or passing cgroup
> > object to the prog should work. The problem is at pinning.
>
> The bpf_iter_link_info is used to parametrize the iterator.
> The map iterator will iterate the given map_fd.
> iirc pinning is not parameterizable yet,
> but that's not difficult to add.
>

I can take a look at that. This will be useful in our use case.

>
> > In our use case, we can't ask the users who create cgroups to do the
> > pinning. Pinning requires root privilege. In our use case, we have
> > non-root users who can create cgroup directories and still want to
> > read bpf stats. They can't do pinning by themselves. This is why
> > inheritance is a requirement for us. With inheritance, they only need
> > to mkdir in cgroupfs and bpffs (unprivileged operations), no pinning
> > operation is required. Patch 1-4 are needed to implement inheritance.
> >
> > It's also not a good idea in our use case to add a userspace
> > privileged process to monitor cgroupfs operations and perform the
> > pinning. It's more complex and has a higher maintenance cost and
> > runtime overhead, compared to the solution of asking whoever makes
> > cgroups to mkdir in bpffs. The other problem is: if there are nodes in
> > the data center that don't have the userspace process deployed, the
> > stats will be unavailable, which is a no-no for some of our users.
>
> The commit log says that there will be a daemon that does that
> monitoring of cgroupfs. And that daemon needs to mkdir
> directories in bpffs when a new cgroup is created, no?
> The kernel is only doing inheritance of bpf progs into
> new dirs. I think that daemon can pin as well.
>
> The cgroup creation is typically managed by an agent like systemd.
> Sounds like you have your own agent that creates cgroups?
> If so it has to be privileged and it can mkdir in bpffs and pin too ?

Ah, yes, we have our own daemon to manage cgroups. That daemon creates
the top-level cgroup for each job to run inside. However, the job can
create its own cgroups inside the top-level cgroup, for fine grained
resource control. This doesn't go through the daemon. The job-created
cgroups don't have the pinned objects and this is a no-no for our
users.
