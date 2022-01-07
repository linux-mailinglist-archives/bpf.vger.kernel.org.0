Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07B31487DCF
	for <lists+bpf@lfdr.de>; Fri,  7 Jan 2022 21:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbiAGUoE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Jan 2022 15:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiAGUoD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Jan 2022 15:44:03 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66EAC061574
        for <bpf@vger.kernel.org>; Fri,  7 Jan 2022 12:44:03 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id q3so6600838qvc.7
        for <bpf@vger.kernel.org>; Fri, 07 Jan 2022 12:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F/duy4ok7LCjAYvVEiaWHn9szJ5yPHasYdjK3KcLrTQ=;
        b=BMu6kCV5XsR8WGYvzzLNYNEoUPoi3osmivmn2ZS0ZENDXqUm7upe2inALfYYQZytJ6
         FppZ0HrfymDrS3dOQ8ujndw/01C93RM9Iun6gtDJ+ycAPkHgfYuVdJRdixA+6txDbOF6
         bLLD5BAIxVNDd86eLfcQhGDVUkElLKeNL77VV5usaxaJTHgJ3KC3QrRuqJh6zlC81KQB
         p+ZpOmJ4Hi67MZ1SMtUj506fK+HgfdMzi2d4I5uVTqoOESAWbo+Hs2Y9hypZTZAJAtPR
         XFo6sjYfOyVFbPgxba+CLQgWqLh3W6rrc6bFHXmR34VZnEK9LRG4ho5P84G6mLk1UeWy
         iDhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F/duy4ok7LCjAYvVEiaWHn9szJ5yPHasYdjK3KcLrTQ=;
        b=a5OAVjF2FVNUStHezroY9szpKFydRitcb/8IMVmkD1WDZbhwaj2E3Wic8FS3BNbgp1
         t7XTt3PkDUH3zVREZbV2KOXC4+leqVkpbp+4yqfou1R4TXgEydnkCldaB2x3n4qE0M8N
         n2MaIexak63QsejmZpKp5oMdCajmBOyq9ZGtdfDrwkdZaeg8y+WfehOvA8YY+e289r5t
         J4wEdCEntKWcPR/+V7Uha//jF3SCOh9vV0siXXuS/7QlIAoleCUPfybywVy6MDJGH3KV
         PxhmIGasa64kQLT6aKW/7ZYsCA4S/w1LD8FIwDPV0snsP5s7uFyR41TLk5lNs1Ww7DLk
         bFYQ==
X-Gm-Message-State: AOAM531p5X/cPITRcbsp/Ji+Ozbx67+pBaCVoMnEsk+JewDiOtgKx06i
        KF9mgPS53TegHDPsfF8N7P1OxHTrUrkjDXi8EWXK6A==
X-Google-Smtp-Source: ABdhPJy65GT2V23oE/Gp3y6/xg+XBl0ovpdWHX6EpD3NLwAOI5Ht3TN6RgqDLXX8CVu/g2yOz1CrVcLkBlnqhunhtfg=
X-Received: by 2002:a05:6214:500a:: with SMTP id jo10mr59522372qvb.17.1641588242422;
 Fri, 07 Jan 2022 12:44:02 -0800 (PST)
MIME-Version: 1.0
References: <20220106215059.2308931-1-haoluo@google.com> <86203252-0c97-8085-f56f-ea8fe7f0b9dd@fb.com>
In-Reply-To: <86203252-0c97-8085-f56f-ea8fe7f0b9dd@fb.com>
From:   Hao Luo <haoluo@google.com>
Date:   Fri, 7 Jan 2022 12:43:51 -0800
Message-ID: <CA+khW7jiDgdFz3Wty0=ajkaiLpAyYu8-9jnZXqT2sF45Y4rb9Q@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v1 0/8] Pinning bpf objects outside bpffs
To:     Yonghong Song <yhs@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 6, 2022 at 4:30 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 1/6/22 1:50 PM, Hao Luo wrote:
> > Bpffs is a pseudo file system that persists bpf objects. Previously
> > bpf objects can only be pinned in bpffs, this patchset extends pinning
> > to allow bpf objects to be pinned (or exposed) to other file systems.
> >
> > In particular, this patchset allows pinning bpf objects in kernfs. This
> > creates a new file entry in the kernfs file system and the created file
> > is able to reference the bpf object. By doing so, bpf can be used to
> > customize the file's operations, such as seq_show.
> >
> > As a concrete usecase of this feature, this patchset introduces a
> > simple new program type called 'bpf_view', which can be used to format
> > a seq file by a kernel object's state. By pinning a bpf_view program
> > into a cgroup directory, userspace is able to read the cgroup's state
> > from file in a format defined by the bpf program.
> >
> > Different from bpffs, kernfs doesn't have a callback when a kernfs node
> > is freed, which is problem if we allow the kernfs node to hold an extra
> > reference of the bpf object, because there is no chance to dec the
> > object's refcnt. Therefore the kernfs node created by pinning doesn't
> > hold reference of the bpf object. The lifetime of the kernfs node
> > depends on the lifetime of the bpf object. Rather than "pinning in
> > kernfs", it is "exposing to kernfs". We require the bpf object to be
> > pinned in bpffs first before it can be pinned in kernfs. When the
> > object is unpinned from bpffs, their kernfs nodes will be removed
> > automatically. This somehow treats a pinned bpf object as a persistent
> > "device".

Thanks Yonghong for the feedback.

>
> During our initial discussion for bpf_iter, we even proposed to
> put cat-able files under /proc/ system. But there are some concerns
> that /proc/ system holds stable APIs so people can rely on its format
> etc. Not sure kernfs here has such requirement or not.
>
> I understand directly put files in respective target directories
> (e.g., cgroup) helps. But you can also create directory hierarchy
> in bpffs. This can make a bunch of cgroup-stat-dumping bpf programs
> better organized.
>

I thought about this. I think the problem is that you need to
simultaneously manage two hierarchies now. You may have
synchronization problems in bpffs to deal with. For example, what if
the target cgroup is being removed while there is an on-going 'cat' on
the bpf program. I haven't given much thought in this direction. This
patchset doesn't deal with this problem, because kernfs has already
handled these synchronizations.

> Also regarding new program type bpf_view, I think we can reuse
> bpf_iter infrastructure. E.g., we already can customize bpf_iter
> for a particular map. We can certainly customize bpf_iter targeting
> a particular cgroup.
>

Right, that's what I was thinking. During the bpf office hour when I
initially proposed the idea, Alexei suggested creating a new program
type instead of reusing bpf_iter. The reason I remember was that iter
is for iterating a set of objects. Even for dumping a particular map,
it is iterating the entries in a map. While what I wanted to achieve
here is printing for a particular cgroup, not iterating something.
Maybe, we should reuse the infrastructure of bpf_iter (attach, target
registration, etc) but having a different prog type? I do copy-pasted
many code from bpf_iter for bpf_view. I haven't put too much thought
there as I would like to get feedbacks on the idea in general in this
first version of RFC.

> >
> > We rely on fsnotify to monitor the inode events in bpffs. A new function
> > bpf_watch_inode() is introduced. It allows registering a callback
> > function at inode destruction. For the kernfs case, a callback that
> > removes kernfs node is registered at the destruction of bpffs inodes.
> > For other file systems such as sockfs, bpf_watch_inode() can monitor the
> > destruction of sockfs inodes and the created file entry can hold the bpf
> > object's reference. In this case, it is truly "pinning".
> >
> > File operations other than seq_show can also be implemented using bpf.
> > For example, bpf may be of help for .poll and .mmap in kernfs.
> >
> > Patch organization:
> >   - patch 1/8 and 2/8 are preparations. 1/8 implements bpf_watch_inode();
> >     2/8 records bpffs inode in bpf object.
> >   - patch 3/8 and 4/8 implement generic logic for creating bpf backed
> >     kernfs file.
> >   - patch 5/8 and 6/8 add a new program type for formatting output.
> >   - patch 7/8 implements cgroup seq_show operation using bpf.
> >   - patch 8/8 adds selftest.
> >
> > Hao Luo (8):
> >    bpf: Support pinning in non-bpf file system.
> >    bpf: Record back pointer to the inode in bpffs
> >    bpf: Expose bpf object in kernfs
> >    bpf: Support removing kernfs entries
> >    bpf: Introduce a new program type bpf_view.
> >    libbpf: Support of bpf_view prog type.
> >    bpf: Add seq_show operation for bpf in cgroupfs
> >    selftests/bpf: Test exposing bpf objects in kernfs
> >
> >   include/linux/bpf.h                           |   9 +-
> >   include/uapi/linux/bpf.h                      |   2 +
> >   kernel/bpf/Makefile                           |   2 +-
> >   kernel/bpf/bpf_view.c                         | 190 ++++++++++++++
> >   kernel/bpf/bpf_view.h                         |  25 ++
> >   kernel/bpf/inode.c                            | 219 ++++++++++++++--
> >   kernel/bpf/inode.h                            |  54 ++++
> >   kernel/bpf/kernfs_node.c                      | 165 ++++++++++++
> >   kernel/bpf/syscall.c                          |   3 +
> >   kernel/bpf/verifier.c                         |   6 +
> >   kernel/trace/bpf_trace.c                      |  12 +-
> >   tools/include/uapi/linux/bpf.h                |   2 +
> >   tools/lib/bpf/libbpf.c                        |  21 ++
> >   .../selftests/bpf/prog_tests/pinning_kernfs.c | 245 ++++++++++++++++++
> >   .../selftests/bpf/progs/pinning_kernfs.c      |  72 +++++
> >   15 files changed, 995 insertions(+), 32 deletions(-)
> >   create mode 100644 kernel/bpf/bpf_view.c
> >   create mode 100644 kernel/bpf/bpf_view.h
> >   create mode 100644 kernel/bpf/inode.h
> >   create mode 100644 kernel/bpf/kernfs_node.c
> >   create mode 100644 tools/testing/selftests/bpf/prog_tests/pinning_kernfs.c
> >   create mode 100644 tools/testing/selftests/bpf/progs/pinning_kernfs.c
> >
