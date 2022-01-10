Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3466C48A00D
	for <lists+bpf@lfdr.de>; Mon, 10 Jan 2022 20:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242411AbiAJTWk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Jan 2022 14:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbiAJTWk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Jan 2022 14:22:40 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A39C06173F
        for <bpf@vger.kernel.org>; Mon, 10 Jan 2022 11:22:39 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id 202so16026847qkg.13
        for <bpf@vger.kernel.org>; Mon, 10 Jan 2022 11:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AImdtbn9NrxNEFt6Vc+27k9iQBx+AU3zAjp9eZzzthc=;
        b=PEoPgh8WbYHEHVrOsuvxOcBHvDqUGGntjcFy7QQn5eINHaWy2NaDHZIlbZKQBhzdP8
         LxRzhXpxnHpl1jmkwXurI+17sIZGIGU8f17psofeQd/ihFvrIOyO7GwSfT4fnsEn18dM
         0oUTWneRvPNP13flbCZO8YsjJ0eAt+qo0Gj+9gpukQN30EDzs37vT6nsMyYyRE+81VX+
         HaI0ABXwEFLjBJgA5x85RdnC47iHSUB7tx87jLvluJLegBH0gwsYcnA+HEgrkgp/Zuxl
         2XvBChAc95KcLCGJ12eKAY6pac+QMM5aQy1jm09IrASKhaMSvTh8ScOZjkM9JYPU2R7A
         jxtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AImdtbn9NrxNEFt6Vc+27k9iQBx+AU3zAjp9eZzzthc=;
        b=umCX9s363CzvT2NPUn5tjfJtdOqvCVtglNLkRSUFD7406Ex7UVqQGkgy5jPBKTD7Aj
         qJvU9jyi5MLYsaJ3kZ8OOTQ7u0f9yLwn+s7cw8Cc1F7/MAJrb32cfyLxwrMaedxl3igU
         0I8s2RUzMjeU20f9alvW2pZQwxR8YwNfZvqdoNiAJLBSw/30TVpOzWOiG61qUcnEGdOa
         QID0dH1LAOQQt644/k9cLCaUsrCzIwvplugDNt939+NlSKPojS+dVXfdlQ+SHPAmn+PO
         23PNjcliyBSC4jwV05Dc9f/pVx5ujXK1/66aQRpHhwkuBqyjvMoJXo/nts3MNyGMfoe0
         aikQ==
X-Gm-Message-State: AOAM531bHa/xeXOkfucEYDblRMfBXxgsKeKB33w6Ha5pVRe2A5vjeINp
        Whe7LJ3zsDtXHcZGWo5+isQrpQJlox9whksbrLX8Rg==
X-Google-Smtp-Source: ABdhPJw8WcMSHaxByAXAp8jHCKKjY8EZHLKxCgyb6qwk39PzDAmORi2bMR3TOnO43TWtLU+nGyGGwWOtcznGmrW57Ns=
X-Received: by 2002:a05:620a:1370:: with SMTP id d16mr846632qkl.759.1641842557283;
 Mon, 10 Jan 2022 11:22:37 -0800 (PST)
MIME-Version: 1.0
References: <20220106215059.2308931-1-haoluo@google.com> <Ydd1IIUG7/3kQRcR@google.com>
 <CA+khW7h4OG0=w5RXnentwnsi614wZdpYW4EUwN6k7Vce3unBKw@mail.gmail.com>
 <YdiTrq4Y7JwmQumc@google.com> <CA+khW7ihrLZwvzPTGAy0GyFmKzB7tH-FU6D+-fthqbj4wuiwFg@mail.gmail.com>
In-Reply-To: <CA+khW7ihrLZwvzPTGAy0GyFmKzB7tH-FU6D+-fthqbj4wuiwFg@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Mon, 10 Jan 2022 11:22:26 -0800
Message-ID: <CAKH8qBs16NmZ5xWROFTk=cwSnbKK0Yj==XvsQhxPvPvN3RM9CA@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v1 0/8] Pinning bpf objects outside bpffs
To:     Hao Luo <haoluo@google.com>
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

On Mon, Jan 10, 2022 at 10:56 AM Hao Luo <haoluo@google.com> wrote:
>
> On Fri, Jan 7, 2022 at 11:25 AM <sdf@google.com> wrote:
> >
> > On 01/07, Hao Luo wrote:
> > > On Thu, Jan 6, 2022 at 3:03 PM <sdf@google.com> wrote:
> > > >
> > > > On 01/06, Hao Luo wrote:
> > > > > Bpffs is a pseudo file system that persists bpf objects. Previously
> > > > > bpf objects can only be pinned in bpffs, this patchset extends pinning
> > > > > to allow bpf objects to be pinned (or exposed) to other file systems.
> > > >
> > > > > In particular, this patchset allows pinning bpf objects in kernfs.
> > > This
> > > > > creates a new file entry in the kernfs file system and the created
> > > file
> > > > > is able to reference the bpf object. By doing so, bpf can be used to
> > > > > customize the file's operations, such as seq_show.
> > > >
> > > > > As a concrete usecase of this feature, this patchset introduces a
> > > > > simple new program type called 'bpf_view', which can be used to format
> > > > > a seq file by a kernel object's state. By pinning a bpf_view program
> > > > > into a cgroup directory, userspace is able to read the cgroup's state
> > > > > from file in a format defined by the bpf program.
> > > >
> > > > > Different from bpffs, kernfs doesn't have a callback when a kernfs
> > > node
> > > > > is freed, which is problem if we allow the kernfs node to hold an
> > > extra
> > > > > reference of the bpf object, because there is no chance to dec the
> > > > > object's refcnt. Therefore the kernfs node created by pinning doesn't
> > > > > hold reference of the bpf object. The lifetime of the kernfs node
> > > > > depends on the lifetime of the bpf object. Rather than "pinning in
> > > > > kernfs", it is "exposing to kernfs". We require the bpf object to be
> > > > > pinned in bpffs first before it can be pinned in kernfs. When the
> > > > > object is unpinned from bpffs, their kernfs nodes will be removed
> > > > > automatically. This somehow treats a pinned bpf object as a persistent
> > > > > "device".
> > > >
> > > > > We rely on fsnotify to monitor the inode events in bpffs. A new
> > > function
> > > > > bpf_watch_inode() is introduced. It allows registering a callback
> > > > > function at inode destruction. For the kernfs case, a callback that
> > > > > removes kernfs node is registered at the destruction of bpffs inodes.
> > > > > For other file systems such as sockfs, bpf_watch_inode() can monitor
> > > the
> > > > > destruction of sockfs inodes and the created file entry can hold the
> > > bpf
> > > > > object's reference. In this case, it is truly "pinning".
> > > >
> > > > > File operations other than seq_show can also be implemented using bpf.
> > > > > For example, bpf may be of help for .poll and .mmap in kernfs.
> > > >
> > > > This looks awesome!
> > > >
> > > > One thing I don't understand is: why did go through the pinning
> > > > interface VS regular attach/detach? IOW, why not allow regular
> > > > sys_bpf(BPF_PROG_ATTACH, prog_id, cgroup_id) and attach to the cgroup
> > > > (which, in turn, creates the kernfs nodes). Seems like this way you can
> > > drop
> > > > the requirement on the object being pinned in the bpffs first?
> >
> > > Thanks Stan.
> >
> > > Yeah, the attach/detach approach is definitely another option. IIUC,
> > > in comparison to pinning, does attach/detach only work for cgroups?
> >
> > attach has target_fd argument that, in theory, can be whatever. We can
> > add support for different fd types.
> >
>
> I see. With attach API, are we also able to specify some attributes
> for the attachment? For example, a property that we may want is: let
> descendent cgroups inherit their parent cgroup's programs.

There are already flags like these: BPF_F_ALLOW_OVERRIDE, maybe you
can rely on them? But you can always add more bit flags if needed.

> > > Pinning may be used on other file systems, sockfs, sysfs or resctrl.
> > > But I don't know whether this generality is welcome and implementing
> > > seq_show is the only concrete use case I can think of right now. If
> > > people think the ability of creating files in other subsystems is not
> > > good, I'd be happy to take a look at the attach/detach approach and
> > > that may be the right way.
> >
> > The reason I started thinking about attach/detach is because of clunky
> > unlink that you have to do (aka echo "rm" > file). IMO, having standard
> > attach/detach is a much more clear. But I might be missing some
> > complexity associated with non-cgroup filesystems.
>
> Oh, I see. Looks good. Let me play with it before sending the next version.
