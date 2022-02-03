Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E008D4A90CD
	for <lists+bpf@lfdr.de>; Thu,  3 Feb 2022 23:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355855AbiBCWqU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Feb 2022 17:46:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355852AbiBCWqT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Feb 2022 17:46:19 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EBCC061714
        for <bpf@vger.kernel.org>; Thu,  3 Feb 2022 14:46:19 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id k4so3905175qvt.6
        for <bpf@vger.kernel.org>; Thu, 03 Feb 2022 14:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3uTrKfJl0B2M1t5hjDoYw6LHu5uHngu7A4EsnOQxqAc=;
        b=Q0e+9JxcmxO28HdGxidRJ+v6cvAU+j0mQY2b5Fh+9itFQ7qAX9ZdfKCVGbwPTrE9Dd
         3f8XiZMcLs6mzcx3rGTO7ProinxnMnl5KYKxzag/mm2QWawCcdIlX8aLOZ3CIL35CahY
         rE5LdrLAoHrw7OPuc7vxlsIcKsXgb2zKH0iNVSFV99qznx6g2iYtz8BcyUFLEKLjOGxB
         irMGqwMxCcOf+LpOmb4NbA/R0uEPqi8ncvZiU+NcrI56uq0vEBMBTtMJqtArx87xMftc
         b3MF7wA+dD9sfXrHEozBMJedsgwV4c7tJjTGbNMt33eBTEj0YbGhAPSz5XywO0M0YJUd
         3XPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3uTrKfJl0B2M1t5hjDoYw6LHu5uHngu7A4EsnOQxqAc=;
        b=G029+LKeCDGTgzkAMhFHCrO+GqpGTCt786zq8DIYxfSxfwTbV13Ol2i+X4abha3Pwl
         0ura5YwtaNOW4TTr9pahw0gpLpdD5lLZS6nbEWhcmkJ106t46RMG8C26kqaNaona2gqS
         HKMJfcD+Jik4PRmzpzdnE2HAJ+LtqweaiVe9KoKe9T2c1mBKuOPBhZHwm/dXVEi1G/Wq
         zd1zhHcpWYtukPE0EoeHsFHInfx+7uZJpGsj7+mcmA8B6KgJsN/bqx+hJIYcO/LJelxv
         e1N/afvZ9/lwVMj0U3c3BXkSpNnHDsW71yDQEoGU3miigaBLWlTGxMGutxn0x59/HDCl
         +kCQ==
X-Gm-Message-State: AOAM531HKEZjZAjmaaXWanV/+9Y1HkBR3+mqSlpiHjIn+tehKJFOIKOv
        OuqK32KuZAv4Q10CUFqvyFyxWv5lh25J3vSqRK4tuQ==
X-Google-Smtp-Source: ABdhPJwR4E8NTdjNRS4RPZNKrDIyw+CJNaSmzcK5ZPj2UOO9VoGW18R0etaIXKXfc5AwiT3jTPMJDYd0mj+LX67slXw=
X-Received: by 2002:a05:6214:2b0c:: with SMTP id jx12mr28089qvb.17.1643928378464;
 Thu, 03 Feb 2022 14:46:18 -0800 (PST)
MIME-Version: 1.0
References: <20220201205534.1962784-1-haoluo@google.com> <20220201205534.1962784-6-haoluo@google.com>
 <20220203180414.blk6ou3ccmod2qck@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20220203180414.blk6ou3ccmod2qck@ast-mbp.dhcp.thefacebook.com>
From:   Hao Luo <haoluo@google.com>
Date:   Thu, 3 Feb 2022 14:46:07 -0800
Message-ID: <CA+khW7jkJbvQrTx4oPJAoBZ0EOCtr3C2PKbrzhxj-7euBK8ojg@mail.gmail.com>
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
        Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 3, 2022 at 10:04 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Feb 01, 2022 at 12:55:34PM -0800, Hao Luo wrote:
> > +
> > +SEC("iter/cgroup_view")
> > +int dump_cgroup_lat(struct bpf_iter__cgroup_view *ctx)
> > +{
> > +     struct seq_file *seq = ctx->meta->seq;
> > +     struct cgroup *cgroup = ctx->cgroup;
> > +     struct wait_lat *lat;
> > +     u64 id;
> > +
> > +     BPF_SEQ_PRINTF(seq, "cgroup_id: %8lu\n", cgroup->kn->id);
> > +     lat = bpf_map_lookup_elem(&cgroup_lat, &id);
>
> Looks like "id = cgroup->kn->id" assignment is missing here?
>

Ah, yes. I'll fix it.

> Thanks a lot for this test. It explains the motivation well.
>
> It seems that the patches 1-4 are there to automatically
> supply cgroup pointer into bpf_iter__cgroup_view.
>
> Since user space needs to track good part of cgroup dir opreations
> can we task it with the job of patches 1-4 as well?
> It can register notifier for cgroupfs operations and
> do mkdir in bpffs similarly _and_ parametrize 'view' bpf program
> with corresponding cgroup_id.
> Ideally there is no new 'view' program and it's a subset of 'iter'
> bpf program. They're already parametrizable.
> When 'iter' is pinned the user space can tell it which object it should
> iterate on. The 'view' will be an interator of one element and
> argument to it can be cgroup_id.
> When user space pins the same 'view' program in a newly created bpffs
> directory it will parametrize it with a different cgroup_id.
> At the end the same 'view' program will be pinned in multiple directories
> with different cgroup_id arguments.
> This patch 5 will look very much the same, but patches 1-4 will not be
> necessary.
> Of course there are races between cgroup create/destroy and bpffs
> mkdir, prog pin operatiosn, but they will be there regardless.
> The patch 1-4 approach is not race free either.

Right. I tried to minimize the races between cgroupfs and bpffs in
this patchset. The cgroup and kernfs APIs called in this patchset
guarantee that the cgroup and kernfs objects are alive once get. Some
states in the objects such as 'id' should be valid at least.

> Will that work?

Thanks Alexei for the idea.

The parameterization part sounds good. By 'parametrize', do you mean a
variable in iter prog (like the 'pid' variable in bpf_iter_task_vma.c
[1])? or some metadata of the program? I assume it's program's
metadata. Either parameterizing with cgroup_id or passing cgroup
object to the prog should work. The problem is at pinning.

In our use case, we can't ask the users who create cgroups to do the
pinning. Pinning requires root privilege. In our use case, we have
non-root users who can create cgroup directories and still want to
read bpf stats. They can't do pinning by themselves. This is why
inheritance is a requirement for us. With inheritance, they only need
to mkdir in cgroupfs and bpffs (unprivileged operations), no pinning
operation is required. Patch 1-4 are needed to implement inheritance.

It's also not a good idea in our use case to add a userspace
privileged process to monitor cgroupfs operations and perform the
pinning. It's more complex and has a higher maintenance cost and
runtime overhead, compared to the solution of asking whoever makes
cgroups to mkdir in bpffs. The other problem is: if there are nodes in
the data center that don't have the userspace process deployed, the
stats will be unavailable, which is a no-no for some of our users.

[1] tools/testing/selftests/bpf/progs/bpf_iter_task_vma.c
