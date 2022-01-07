Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5EC6487CAC
	for <lists+bpf@lfdr.de>; Fri,  7 Jan 2022 19:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiAGS7V (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Jan 2022 13:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbiAGS7U (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Jan 2022 13:59:20 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589D9C061574
        for <bpf@vger.kernel.org>; Fri,  7 Jan 2022 10:59:20 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id hu2so6308877qvb.8
        for <bpf@vger.kernel.org>; Fri, 07 Jan 2022 10:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NrHWfAPCJc/xHHo4xpth5SGnuz2ntMiXcDfL/apZMSs=;
        b=Jtnq0j6NObprBdoV62vo1qYZEQlutdjkpyqCjw+quyk3A68tAqf6NF104uLqdfetFp
         nuV8BAO1QHCtyISygiazAFVzY9Qiokg8rxyVHrrlknCxHI3N+/44gbyuzDu8HychWAhW
         2hjUknhFzbc55llIXaJD+bAoDNDDNk1hNIi5OWdXLTSU7LaHfNLm7yMIs1bXDjhd8XfN
         687kc8/lydXQ13F6o0z/lGKuXVPZJWG9kXfeTaj3uznXfoOiRdtQfc3oeYJHX+Mb3F8v
         bCuguJjHFGlzJj+gntZZkD/+ptusTqByESPbvPr3oHkXZTWIEROj9J61jRRwb3dj3mL1
         9g7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NrHWfAPCJc/xHHo4xpth5SGnuz2ntMiXcDfL/apZMSs=;
        b=Aw9Wream4TAR9XjEZAyQo9uaWW8RgPVoAM7HqRysQFbzgeUsKTsBLcllFOCtmSfxtp
         gMSc4M6x8/wQyuARX0qqC+lLnfxnfacZ7eaU0Kwi4h39vemi7biVkGO4JSYxjnQyK7Fx
         Dzz2U1peuMw3DE4xmYlDBI1dpvPOGo14Y0oj2kmZUWaWTSbXDi0rG0QiXJQJqwCEjoV0
         SIAbnvaMvymk0IK8b28+hPUumy6c1zoTU01kusjzk5vNfb3uiS0j3TPTEUfKFSoj7BP/
         +c+2OXuoO2U/sxo89y8QpKBhUcqLaif+8r6eOfZvUcEbLKkPDobnvhibiNxUojiqLbYV
         DtyQ==
X-Gm-Message-State: AOAM5327YHawxIIUE9nOySma1QVCaAOpQnKICA5wiE7Jpf/QJG32U54S
        r6hbSJp3mRyjhuz4sws0yGLFbgB/99Vn6VvztjYR9Jyxf8I=
X-Google-Smtp-Source: ABdhPJxLYjTdmLdfmUe1i9DpxVA9BqHc1k7Pv0RHDlNwlWlZZ5idifE71CEQaNbJPjc27ryuXgPg8OYrM2aOLxwno3Y=
X-Received: by 2002:ad4:5aa5:: with SMTP id u5mr59819408qvg.35.1641581959257;
 Fri, 07 Jan 2022 10:59:19 -0800 (PST)
MIME-Version: 1.0
References: <20220106215059.2308931-1-haoluo@google.com> <Ydd1IIUG7/3kQRcR@google.com>
In-Reply-To: <Ydd1IIUG7/3kQRcR@google.com>
From:   Hao Luo <haoluo@google.com>
Date:   Fri, 7 Jan 2022 10:59:07 -0800
Message-ID: <CA+khW7h4OG0=w5RXnentwnsi614wZdpYW4EUwN6k7Vce3unBKw@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v1 0/8] Pinning bpf objects outside bpffs
To:     sdf@google.com
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 6, 2022 at 3:03 PM <sdf@google.com> wrote:
>
> On 01/06, Hao Luo wrote:
> > Bpffs is a pseudo file system that persists bpf objects. Previously
> > bpf objects can only be pinned in bpffs, this patchset extends pinning
> > to allow bpf objects to be pinned (or exposed) to other file systems.
>
> > In particular, this patchset allows pinning bpf objects in kernfs. This
> > creates a new file entry in the kernfs file system and the created file
> > is able to reference the bpf object. By doing so, bpf can be used to
> > customize the file's operations, such as seq_show.
>
> > As a concrete usecase of this feature, this patchset introduces a
> > simple new program type called 'bpf_view', which can be used to format
> > a seq file by a kernel object's state. By pinning a bpf_view program
> > into a cgroup directory, userspace is able to read the cgroup's state
> > from file in a format defined by the bpf program.
>
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
>
> > We rely on fsnotify to monitor the inode events in bpffs. A new function
> > bpf_watch_inode() is introduced. It allows registering a callback
> > function at inode destruction. For the kernfs case, a callback that
> > removes kernfs node is registered at the destruction of bpffs inodes.
> > For other file systems such as sockfs, bpf_watch_inode() can monitor the
> > destruction of sockfs inodes and the created file entry can hold the bpf
> > object's reference. In this case, it is truly "pinning".
>
> > File operations other than seq_show can also be implemented using bpf.
> > For example, bpf may be of help for .poll and .mmap in kernfs.
>
> This looks awesome!
>
> One thing I don't understand is: why did go through the pinning
> interface VS regular attach/detach? IOW, why not allow regular
> sys_bpf(BPF_PROG_ATTACH, prog_id, cgroup_id) and attach to the cgroup
> (which, in turn, creates the kernfs nodes). Seems like this way you can drop
> the requirement on the object being pinned in the bpffs first?

Thanks Stan.

Yeah, the attach/detach approach is definitely another option. IIUC,
in comparison to pinning, does attach/detach only work for cgroups?
Pinning may be used on other file systems, sockfs, sysfs or resctrl.
But I don't know whether this generality is welcome and implementing
seq_show is the only concrete use case I can think of right now. If
people think the ability of creating files in other subsystems is not
good, I'd be happy to take a look at the attach/detach approach and
that may be the right way.
