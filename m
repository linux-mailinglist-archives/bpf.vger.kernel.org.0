Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74E3F489FB3
	for <lists+bpf@lfdr.de>; Mon, 10 Jan 2022 19:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242697AbiAJS4s (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Jan 2022 13:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242730AbiAJS4r (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Jan 2022 13:56:47 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323C8C06173F
        for <bpf@vger.kernel.org>; Mon, 10 Jan 2022 10:56:46 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id l17so15471175qtk.7
        for <bpf@vger.kernel.org>; Mon, 10 Jan 2022 10:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qbvMMFBEHrEBYRCvLick/K2WTAg49DZ4WEfKplRGlaQ=;
        b=nZ+QaTArza+xzXawyFKUOcoqQOfMlPAuXXMN8PKod56kVaLPtgT1InbvkqI6qpog6h
         rDlpHCQwVn0y3lUBv9VZqXELzTHo9/Ni8oS3T1VF8XmznxjVT/2B9CUp9/tKMWZwXezd
         o+wkP4T7BOrdv2ygr8uwPz17aPGklALlcsnOV9OHJaonEU6cgXNndQPKbM9DTLbS1XR/
         CTczk/XUQWwaoAsJWigBmU1ECaRvLTaKLCua5/5COgxwVu1X+BRr30u6YFLgvoGCYBN4
         4NlyP1ERsfD1zCQY+Ffz2lJQePLiqj70EKigXh5qT9sGdJtyrfs68RLhnDbEijWON0h/
         g/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qbvMMFBEHrEBYRCvLick/K2WTAg49DZ4WEfKplRGlaQ=;
        b=0V3J4HwlN8vKi3KLkJzDxeb3Bk2P/9ZMZ7se6wLSFLB2oTrLamehBgOENPHj5Aydmk
         FezseB6/3T3btMfiWNsZETGw9O8S7cn7BtSIF09cjGLgqL3NKG89E8hF17nr2X5mjllw
         Kc2N7kJgEafk6J1bkVrJUz8bzlB9j10QEUtiPRMfXNPbfunDrsSVe+2e+8HU5JhYYdXN
         KUk5T/ti+4e/LeF4UmC82Br3riS9UneQtcAwLVwVlwB8zJViVED4msGX4qEE993rNEGY
         OLWd8wN3DO6FZH43N8YuLgkcAtRQymTfAQryi+HDXgwnLoUrACOaGXm5Ekvez6S+mtDj
         CwcQ==
X-Gm-Message-State: AOAM533UtJczA6EcSejuwDmsv7VdIWs9jWjjPLLyai0fxIobc9bgTYNG
        /ypKONUMjKVXjSwxz4HTuMfk5NYJ3+hYFxKS9ck/WZZGkuw=
X-Google-Smtp-Source: ABdhPJzFoz7CeF7TVemMXUC7bjYjvh8f2rPkKM4jQaEOWb4fiX5GdBzvj/JSMMKo/WSEsiY50y1KQIT5yj6AZmn8Wsw=
X-Received: by 2002:ac8:5911:: with SMTP id 17mr930951qty.645.1641841005105;
 Mon, 10 Jan 2022 10:56:45 -0800 (PST)
MIME-Version: 1.0
References: <20220106215059.2308931-1-haoluo@google.com> <86203252-0c97-8085-f56f-ea8fe7f0b9dd@fb.com>
 <CA+khW7jiDgdFz3Wty0=ajkaiLpAyYu8-9jnZXqT2sF45Y4rb9Q@mail.gmail.com> <90f4f434-4be6-e2e0-ae91-b23fd58201fc@fb.com>
In-Reply-To: <90f4f434-4be6-e2e0-ae91-b23fd58201fc@fb.com>
From:   Hao Luo <haoluo@google.com>
Date:   Mon, 10 Jan 2022 10:56:33 -0800
Message-ID: <CA+khW7iCwo3euD0kroZi-ZHJy3U_oJN4cd+xyi4-U9+jQay_gQ@mail.gmail.com>
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

On Mon, Jan 10, 2022 at 9:30 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 1/7/22 12:43 PM, Hao Luo wrote:
> > On Thu, Jan 6, 2022 at 4:30 PM Yonghong Song <yhs@fb.com> wrote:
> >>
> >>
> >>
> >> On 1/6/22 1:50 PM, Hao Luo wrote:
> >>> Bpffs is a pseudo file system that persists bpf objects. Previously
> >>> bpf objects can only be pinned in bpffs, this patchset extends pinning
> >>> to allow bpf objects to be pinned (or exposed) to other file systems.
> >>>
> >>> In particular, this patchset allows pinning bpf objects in kernfs. This
> >>> creates a new file entry in the kernfs file system and the created file
> >>> is able to reference the bpf object. By doing so, bpf can be used to
> >>> customize the file's operations, such as seq_show.
> >>>
> >>> As a concrete usecase of this feature, this patchset introduces a
> >>> simple new program type called 'bpf_view', which can be used to format
> >>> a seq file by a kernel object's state. By pinning a bpf_view program
> >>> into a cgroup directory, userspace is able to read the cgroup's state
> >>> from file in a format defined by the bpf program.
> >>>
> >>> Different from bpffs, kernfs doesn't have a callback when a kernfs node
> >>> is freed, which is problem if we allow the kernfs node to hold an extra
> >>> reference of the bpf object, because there is no chance to dec the
> >>> object's refcnt. Therefore the kernfs node created by pinning doesn't
> >>> hold reference of the bpf object. The lifetime of the kernfs node
> >>> depends on the lifetime of the bpf object. Rather than "pinning in
> >>> kernfs", it is "exposing to kernfs". We require the bpf object to be
> >>> pinned in bpffs first before it can be pinned in kernfs. When the
> >>> object is unpinned from bpffs, their kernfs nodes will be removed
> >>> automatically. This somehow treats a pinned bpf object as a persistent
> >>> "device".
> >
> > Thanks Yonghong for the feedback.
> >
> >>
> >> During our initial discussion for bpf_iter, we even proposed to
> >> put cat-able files under /proc/ system. But there are some concerns
> >> that /proc/ system holds stable APIs so people can rely on its format
> >> etc. Not sure kernfs here has such requirement or not.
> >>
> >> I understand directly put files in respective target directories
> >> (e.g., cgroup) helps. But you can also create directory hierarchy
> >> in bpffs. This can make a bunch of cgroup-stat-dumping bpf programs
> >> better organized.
> >>
> >
> > I thought about this. I think the problem is that you need to
> > simultaneously manage two hierarchies now. You may have
> > synchronization problems in bpffs to deal with. For example, what if
> > the target cgroup is being removed while there is an on-going 'cat' on
> > the bpf program. I haven't given much thought in this direction. This
> > patchset doesn't deal with this problem, because kernfs has already
> > handled these synchronizations.
>
> If the file is going to pinned inside /sys/fs/cgroup, which arguably is
> indeed a better place, maybe ask cgroup maintainer's opinion?
>

Yes, will do.

I don't know if pinning in other file systems other than cgroup has
any use. If not, I can tailor this patchset for cgroup only. Would be
much simplified.

> >
> >> Also regarding new program type bpf_view, I think we can reuse
> >> bpf_iter infrastructure. E.g., we already can customize bpf_iter
> >> for a particular map. We can certainly customize bpf_iter targeting
> >> a particular cgroup.
> >>
> >
> > Right, that's what I was thinking. During the bpf office hour when I
> > initially proposed the idea, Alexei suggested creating a new program
> > type instead of reusing bpf_iter. The reason I remember was that iter
> > is for iterating a set of objects. Even for dumping a particular map,
> > it is iterating the entries in a map. While what I wanted to achieve
> > here is printing for a particular cgroup, not iterating something.
> > Maybe, we should reuse the infrastructure of bpf_iter (attach, target
> > registration, etc) but having a different prog type? I do copy-pasted
> > many code from bpf_iter for bpf_view. I haven't put too much thought
> > there as I would like to get feedbacks on the idea in general in this
> > first version of RFC.
>
> Sorry I am not aware of this bpf_view discussion. It is okay for me.
> But it would be great if we can avoid lots of code duplication.
>

No problem. I totally agree.


> >
> >>>
> >>> We rely on fsnotify to monitor the inode events in bpffs. A new function
> >>> bpf_watch_inode() is introduced. It allows registering a callback
> >>> function at inode destruction. For the kernfs case, a callback that
> >>> removes kernfs node is registered at the destruction of bpffs inodes.
> >>> For other file systems such as sockfs, bpf_watch_inode() can monitor the
> >>> destruction of sockfs inodes and the created file entry can hold the bpf
> >>> object's reference. In this case, it is truly "pinning".
> >>>
> >>> File operations other than seq_show can also be implemented using bpf.
> >>> For example, bpf may be of help for .poll and .mmap in kernfs.
> >>>
> [...]
