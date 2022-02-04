Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5F34A92C4
	for <lists+bpf@lfdr.de>; Fri,  4 Feb 2022 04:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245190AbiBDDdZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Feb 2022 22:33:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236970AbiBDDdZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Feb 2022 22:33:25 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A51C061714;
        Thu,  3 Feb 2022 19:33:25 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id c3so4034202pls.5;
        Thu, 03 Feb 2022 19:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ma6PWHHr7hu/IjhSxyoQJ/J/Mu4XabGA7hf9x6U4ClM=;
        b=G8DJch7bNa6zxZ+ePelXu0GaWg9cul13UKDVOwM3co6fG6Q+LfhRFPj1+GHxpyUIj6
         W6x4yVDr0sk4xl+Vx5d2Jc84WeVkz2L3yEpOaHIHkv2o39mTeI8pNp7YX00C7vt/s4SL
         vUyUHmmR5EFxXBoW/kdPcoQD0+nM9EUE1UIM/XjmUFl3oueHdR5IgU5jfROPP4l5AlWl
         mGrcRCOq2oR7W7cBQBf/tWUwOUDqZVAg//xP2gdhtFAERyMg9JjF99tkZgFhHIurhJHl
         TZLvOLXkdSGfR7PXi9RhkB8unhqxAvWxrSt97fw03NL79Hk614D905S63/TftzfDKWYA
         0Owg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ma6PWHHr7hu/IjhSxyoQJ/J/Mu4XabGA7hf9x6U4ClM=;
        b=AAVBfqIhjbEHPxGucFAblByRzD8LIxyuXWJmXuT7+Q54l+Xlo75QMOtc4DOYa9i3st
         N0Db5rMeM0vTe9srAo0WTbDF2qlnSJQmBgSOtfkSMclD7eudLMMXrbTLSi/y6G6K58KL
         X8Hjk95kT8/21X2zzHM0ycIbT5hzONJZYobL7y0kXWj91R9KSJJgGMnxOeF2hP9UrKPv
         AiuAzYcra/NNZmANTTJJawVT8+SbvuklwQ3XiKuorqiFPe1meyBo1sV1b0PWJohZHOd6
         QGCwbNWWxAzO38gDgovFgwT4jRvWL/7bQ0Fx1p0SXwfTHcHPV0M8jb3QsS/HUd+cthks
         H6/g==
X-Gm-Message-State: AOAM531l36KvKTpU+oBe90ChpQncV0jh6fZDBKGihXGo/wA4W6oXyB+K
        GNvXdhIafcNH6Jkdqibwb7xxfO1SQtcNBPnyO0g=
X-Google-Smtp-Source: ABdhPJzlWg/yH0Yrf8I+HwdZURH0TrPBuQLTyJLS7k+kTjd+7AiFPXuuEKWgzGoXN+aBGXQW2s7hFM+DB6uYElnV9vw=
X-Received: by 2002:a17:902:e54c:: with SMTP id n12mr986748plf.78.1643945604282;
 Thu, 03 Feb 2022 19:33:24 -0800 (PST)
MIME-Version: 1.0
References: <20220201205534.1962784-1-haoluo@google.com> <20220201205534.1962784-6-haoluo@google.com>
 <20220203180414.blk6ou3ccmod2qck@ast-mbp.dhcp.thefacebook.com> <CA+khW7jkJbvQrTx4oPJAoBZ0EOCtr3C2PKbrzhxj-7euBK8ojg@mail.gmail.com>
In-Reply-To: <CA+khW7jkJbvQrTx4oPJAoBZ0EOCtr3C2PKbrzhxj-7euBK8ojg@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 3 Feb 2022 19:33:12 -0800
Message-ID: <CAADnVQLZZ3SM2CDxnzgOnDgRtGU7+6wT9u5v4oFas5MnZF6DsQ@mail.gmail.com>
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
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 3, 2022 at 2:46 PM Hao Luo <haoluo@google.com> wrote:
>
> On Thu, Feb 3, 2022 at 10:04 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Feb 01, 2022 at 12:55:34PM -0800, Hao Luo wrote:
> > > +
> > > +SEC("iter/cgroup_view")
> > > +int dump_cgroup_lat(struct bpf_iter__cgroup_view *ctx)
> > > +{
> > > +     struct seq_file *seq = ctx->meta->seq;
> > > +     struct cgroup *cgroup = ctx->cgroup;
> > > +     struct wait_lat *lat;
> > > +     u64 id;
> > > +
> > > +     BPF_SEQ_PRINTF(seq, "cgroup_id: %8lu\n", cgroup->kn->id);
> > > +     lat = bpf_map_lookup_elem(&cgroup_lat, &id);
> >
> > Looks like "id = cgroup->kn->id" assignment is missing here?
> >
>
> Ah, yes. I'll fix it.
>
> > Thanks a lot for this test. It explains the motivation well.
> >
> > It seems that the patches 1-4 are there to automatically
> > supply cgroup pointer into bpf_iter__cgroup_view.
> >
> > Since user space needs to track good part of cgroup dir opreations
> > can we task it with the job of patches 1-4 as well?
> > It can register notifier for cgroupfs operations and
> > do mkdir in bpffs similarly _and_ parametrize 'view' bpf program
> > with corresponding cgroup_id.
> > Ideally there is no new 'view' program and it's a subset of 'iter'
> > bpf program. They're already parametrizable.
> > When 'iter' is pinned the user space can tell it which object it should
> > iterate on. The 'view' will be an interator of one element and
> > argument to it can be cgroup_id.
> > When user space pins the same 'view' program in a newly created bpffs
> > directory it will parametrize it with a different cgroup_id.
> > At the end the same 'view' program will be pinned in multiple directories
> > with different cgroup_id arguments.
> > This patch 5 will look very much the same, but patches 1-4 will not be
> > necessary.
> > Of course there are races between cgroup create/destroy and bpffs
> > mkdir, prog pin operatiosn, but they will be there regardless.
> > The patch 1-4 approach is not race free either.
>
> Right. I tried to minimize the races between cgroupfs and bpffs in
> this patchset. The cgroup and kernfs APIs called in this patchset
> guarantee that the cgroup and kernfs objects are alive once get. Some
> states in the objects such as 'id' should be valid at least.
>
> > Will that work?
>
> Thanks Alexei for the idea.
>
> The parameterization part sounds good. By 'parametrize', do you mean a
> variable in iter prog (like the 'pid' variable in bpf_iter_task_vma.c
> [1])? or some metadata of the program? I assume it's program's
> metadata. Either parameterizing with cgroup_id or passing cgroup
> object to the prog should work. The problem is at pinning.

The bpf_iter_link_info is used to parametrize the iterator.
The map iterator will iterate the given map_fd.
iirc pinning is not parameterizable yet,
but that's not difficult to add.


> In our use case, we can't ask the users who create cgroups to do the
> pinning. Pinning requires root privilege. In our use case, we have
> non-root users who can create cgroup directories and still want to
> read bpf stats. They can't do pinning by themselves. This is why
> inheritance is a requirement for us. With inheritance, they only need
> to mkdir in cgroupfs and bpffs (unprivileged operations), no pinning
> operation is required. Patch 1-4 are needed to implement inheritance.
>
> It's also not a good idea in our use case to add a userspace
> privileged process to monitor cgroupfs operations and perform the
> pinning. It's more complex and has a higher maintenance cost and
> runtime overhead, compared to the solution of asking whoever makes
> cgroups to mkdir in bpffs. The other problem is: if there are nodes in
> the data center that don't have the userspace process deployed, the
> stats will be unavailable, which is a no-no for some of our users.

The commit log says that there will be a daemon that does that
monitoring of cgroupfs. And that daemon needs to mkdir
directories in bpffs when a new cgroup is created, no?
The kernel is only doing inheritance of bpf progs into
new dirs. I think that daemon can pin as well.

The cgroup creation is typically managed by an agent like systemd.
Sounds like you have your own agent that creates cgroups?
If so it has to be privileged and it can mkdir in bpffs and pin too ?
