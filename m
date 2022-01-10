Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36683489FAC
	for <lists+bpf@lfdr.de>; Mon, 10 Jan 2022 19:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242631AbiAJS4I (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Jan 2022 13:56:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242539AbiAJS4H (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Jan 2022 13:56:07 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B295C06173F
        for <bpf@vger.kernel.org>; Mon, 10 Jan 2022 10:56:06 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id y17so15428025qtx.9
        for <bpf@vger.kernel.org>; Mon, 10 Jan 2022 10:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wr72sF1VRyUbrJU6dELMjk6kUFdtRJXcpGymlQx5fqw=;
        b=Kg5yU+8szdFX3qEUA9lcmH1FKuy+2nYouPyRZWdLcGMIyrsdy6gQRPGYxsySp4I7Py
         X2pOgJOFtnSmcAFxHBakhHhL1mZvhAj8WBU/Z4oDQPxCS3sH02AECkSAN2fLhRoU2ov5
         vZb/jRn1mwH080RYmzrVLxyU+lmMZq+9Ben+kHeyKGhv8avYQcUmpJS2QBWxFdwh5Bln
         cnHkTi4LLUTSj1qrpkfploJ0XjzwSenlBtHYybVqE/SQF+e1CnRJEYS48dJAuNUlodpb
         FqILwtotCv8NHbqFgx62pRg2sOvVjCrnQqawvYP0bpwSPYkFfHRU18sChzRghK5gT6tH
         oykA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wr72sF1VRyUbrJU6dELMjk6kUFdtRJXcpGymlQx5fqw=;
        b=6+yK724t0+msTALvSgCvyCHB1nQYFeH+P7nKjTufprT6kRta092SmHn4ZvQVMiA7hG
         IL9bCNvOustKyUxjxzAf+rfDZO8u3cE1mXTvUgnA29cAwekW7OU/fdNvjGglunogcpPK
         VZKELI6iSF+sP2L755iAXAr/VxJu1rhMoj65dFK0920homdeaiy6wyvF8KVkA8lGt11I
         jzv6Dp2cfOTnkgIAzxRLh0WWQUKL5s1vW1u8zxrkkKaOYdYLVOdUnTvWIHwb+pt2fQIM
         QSR8vS1/IHPUqQprxbmoZt9Mj0vwo8GTDIciVdcIk7A5/tRvan+/qTfZ3CjL43H3pYH6
         GAXg==
X-Gm-Message-State: AOAM530/sW5vdJUN2QWQJjBgW9Nt4y8BLMITliweMjEcQkUUgev2P+t+
        +b4jaO0lY0FFFTvCEJDjfE0gkRHwsMKgieqZi84rJQ==
X-Google-Smtp-Source: ABdhPJwuq3bDT3cElyx4qKfhLgboqStYqLAhaHryawR26J5sZ2Ke7ldnusphvNuVRmjJEpnmJyMUReziaKSEREUYuYs=
X-Received: by 2002:ac8:5986:: with SMTP id e6mr916587qte.519.1641840965331;
 Mon, 10 Jan 2022 10:56:05 -0800 (PST)
MIME-Version: 1.0
References: <20220106215059.2308931-1-haoluo@google.com> <Ydd1IIUG7/3kQRcR@google.com>
 <CA+khW7h4OG0=w5RXnentwnsi614wZdpYW4EUwN6k7Vce3unBKw@mail.gmail.com> <YdiTrq4Y7JwmQumc@google.com>
In-Reply-To: <YdiTrq4Y7JwmQumc@google.com>
From:   Hao Luo <haoluo@google.com>
Date:   Mon, 10 Jan 2022 10:55:54 -0800
Message-ID: <CA+khW7ihrLZwvzPTGAy0GyFmKzB7tH-FU6D+-fthqbj4wuiwFg@mail.gmail.com>
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

On Fri, Jan 7, 2022 at 11:25 AM <sdf@google.com> wrote:
>
> On 01/07, Hao Luo wrote:
> > On Thu, Jan 6, 2022 at 3:03 PM <sdf@google.com> wrote:
> > >
> > > On 01/06, Hao Luo wrote:
> > > > Bpffs is a pseudo file system that persists bpf objects. Previously
> > > > bpf objects can only be pinned in bpffs, this patchset extends pinning
> > > > to allow bpf objects to be pinned (or exposed) to other file systems.
> > >
> > > > In particular, this patchset allows pinning bpf objects in kernfs.
> > This
> > > > creates a new file entry in the kernfs file system and the created
> > file
> > > > is able to reference the bpf object. By doing so, bpf can be used to
> > > > customize the file's operations, such as seq_show.
> > >
> > > > As a concrete usecase of this feature, this patchset introduces a
> > > > simple new program type called 'bpf_view', which can be used to format
> > > > a seq file by a kernel object's state. By pinning a bpf_view program
> > > > into a cgroup directory, userspace is able to read the cgroup's state
> > > > from file in a format defined by the bpf program.
> > >
> > > > Different from bpffs, kernfs doesn't have a callback when a kernfs
> > node
> > > > is freed, which is problem if we allow the kernfs node to hold an
> > extra
> > > > reference of the bpf object, because there is no chance to dec the
> > > > object's refcnt. Therefore the kernfs node created by pinning doesn't
> > > > hold reference of the bpf object. The lifetime of the kernfs node
> > > > depends on the lifetime of the bpf object. Rather than "pinning in
> > > > kernfs", it is "exposing to kernfs". We require the bpf object to be
> > > > pinned in bpffs first before it can be pinned in kernfs. When the
> > > > object is unpinned from bpffs, their kernfs nodes will be removed
> > > > automatically. This somehow treats a pinned bpf object as a persistent
> > > > "device".
> > >
> > > > We rely on fsnotify to monitor the inode events in bpffs. A new
> > function
> > > > bpf_watch_inode() is introduced. It allows registering a callback
> > > > function at inode destruction. For the kernfs case, a callback that
> > > > removes kernfs node is registered at the destruction of bpffs inodes.
> > > > For other file systems such as sockfs, bpf_watch_inode() can monitor
> > the
> > > > destruction of sockfs inodes and the created file entry can hold the
> > bpf
> > > > object's reference. In this case, it is truly "pinning".
> > >
> > > > File operations other than seq_show can also be implemented using bpf.
> > > > For example, bpf may be of help for .poll and .mmap in kernfs.
> > >
> > > This looks awesome!
> > >
> > > One thing I don't understand is: why did go through the pinning
> > > interface VS regular attach/detach? IOW, why not allow regular
> > > sys_bpf(BPF_PROG_ATTACH, prog_id, cgroup_id) and attach to the cgroup
> > > (which, in turn, creates the kernfs nodes). Seems like this way you can
> > drop
> > > the requirement on the object being pinned in the bpffs first?
>
> > Thanks Stan.
>
> > Yeah, the attach/detach approach is definitely another option. IIUC,
> > in comparison to pinning, does attach/detach only work for cgroups?
>
> attach has target_fd argument that, in theory, can be whatever. We can
> add support for different fd types.
>

I see. With attach API, are we also able to specify some attributes
for the attachment? For example, a property that we may want is: let
descendent cgroups inherit their parent cgroup's programs.

> > Pinning may be used on other file systems, sockfs, sysfs or resctrl.
> > But I don't know whether this generality is welcome and implementing
> > seq_show is the only concrete use case I can think of right now. If
> > people think the ability of creating files in other subsystems is not
> > good, I'd be happy to take a look at the attach/detach approach and
> > that may be the right way.
>
> The reason I started thinking about attach/detach is because of clunky
> unlink that you have to do (aka echo "rm" > file). IMO, having standard
> attach/detach is a much more clear. But I might be missing some
> complexity associated with non-cgroup filesystems.

Oh, I see. Looks good. Let me play with it before sending the next version.
