Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E53C487CF5
	for <lists+bpf@lfdr.de>; Fri,  7 Jan 2022 20:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbiAGTZi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Jan 2022 14:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbiAGTZi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Jan 2022 14:25:38 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF91C061574
        for <bpf@vger.kernel.org>; Fri,  7 Jan 2022 11:25:37 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id s84-20020a254557000000b0060ac37f4bb1so13582694yba.5
        for <bpf@vger.kernel.org>; Fri, 07 Jan 2022 11:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7IxBx134xindHAVoKThil5bfggxZngQfRS8+QZVE890=;
        b=if17mj5tS8746QLe/lNfeBmhqyDN7itI2JjiirqftIBGoHCIkZ/As0AzVnSElarh6+
         9oPBBsfHvjQnmtO5b3FCYAUbLHJq/dcq2TVHNaKve3vPG351Gttm/9UGgYI3qwY/Mamq
         tzMOkQxRNOhyRwp+Fvdb4GQhQHvgqufFbyXRpejJwCxy9v6zYc2h0SNkLfneUOn25Rn3
         qf2eF2VfVzIYo24BQHBn35RtDJ2U6dcn/noeOdcoKflqKpAF7Y6wdhzX5LLUyOhSymbQ
         qkldwsTebXjXzDyvtBlbg47WGwgP40Wnr+htD2bRXIR/bLJDtrDLPmlQtZCDo5D6AM+V
         7ojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7IxBx134xindHAVoKThil5bfggxZngQfRS8+QZVE890=;
        b=bXG3x90h9/HcjdrWy3Dx0RavSv6HfZByDEQCpML6WPRPgh+2SihkUdndoXnCrUdKvl
         qrwfFAYLT2tviBmyRdp2Tp1OH3NpIteoOI3LCcR6vZaRjhtwCC9fOvjIprPUmk7XVIdP
         IcTKVIXhVosN/u4QVqFzusl8eRQgj8SfqALA5pSlTk8PjQFzn618wWZv2P26EHa7KYY1
         YVn2pZi8bHEgG7e9hA6RblpYUi4IZXzkfrAO+3GmiObFg0jdkQjq77ccEZlB99tjTvZU
         2ig9oAMLKFrATZKo8fUVYYLIJM0QqCqM5TvccKQsJySoN2Tv7GuW71WYqJJpnbHqiBKD
         ji4Q==
X-Gm-Message-State: AOAM530erp2oyKMWw1kS6qqUjJzWKOGB+TuWjvQouHjktZ6TDeGsfZHc
        peEhLQzbRu7o9e+T7DcE90SK3IE=
X-Google-Smtp-Source: ABdhPJz1imt0DchlBTn3l5nFgOR51O+wri7qEJQGqSCHipSViOvK/t0g+aflLVUM8nLagZ9z5+hnaWQ=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:201:ca92:b9c0:5dd8:724c])
 (user=sdf job=sendgmr) by 2002:a25:b30e:: with SMTP id l14mr69264150ybj.162.1641583536873;
 Fri, 07 Jan 2022 11:25:36 -0800 (PST)
Date:   Fri, 7 Jan 2022 11:25:34 -0800
In-Reply-To: <CA+khW7h4OG0=w5RXnentwnsi614wZdpYW4EUwN6k7Vce3unBKw@mail.gmail.com>
Message-Id: <YdiTrq4Y7JwmQumc@google.com>
Mime-Version: 1.0
References: <20220106215059.2308931-1-haoluo@google.com> <Ydd1IIUG7/3kQRcR@google.com>
 <CA+khW7h4OG0=w5RXnentwnsi614wZdpYW4EUwN6k7Vce3unBKw@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v1 0/8] Pinning bpf objects outside bpffs
From:   sdf@google.com
To:     Hao Luo <haoluo@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 01/07, Hao Luo wrote:
> On Thu, Jan 6, 2022 at 3:03 PM <sdf@google.com> wrote:
> >
> > On 01/06, Hao Luo wrote:
> > > Bpffs is a pseudo file system that persists bpf objects. Previously
> > > bpf objects can only be pinned in bpffs, this patchset extends pinning
> > > to allow bpf objects to be pinned (or exposed) to other file systems.
> >
> > > In particular, this patchset allows pinning bpf objects in kernfs.  
> This
> > > creates a new file entry in the kernfs file system and the created  
> file
> > > is able to reference the bpf object. By doing so, bpf can be used to
> > > customize the file's operations, such as seq_show.
> >
> > > As a concrete usecase of this feature, this patchset introduces a
> > > simple new program type called 'bpf_view', which can be used to format
> > > a seq file by a kernel object's state. By pinning a bpf_view program
> > > into a cgroup directory, userspace is able to read the cgroup's state
> > > from file in a format defined by the bpf program.
> >
> > > Different from bpffs, kernfs doesn't have a callback when a kernfs  
> node
> > > is freed, which is problem if we allow the kernfs node to hold an  
> extra
> > > reference of the bpf object, because there is no chance to dec the
> > > object's refcnt. Therefore the kernfs node created by pinning doesn't
> > > hold reference of the bpf object. The lifetime of the kernfs node
> > > depends on the lifetime of the bpf object. Rather than "pinning in
> > > kernfs", it is "exposing to kernfs". We require the bpf object to be
> > > pinned in bpffs first before it can be pinned in kernfs. When the
> > > object is unpinned from bpffs, their kernfs nodes will be removed
> > > automatically. This somehow treats a pinned bpf object as a persistent
> > > "device".
> >
> > > We rely on fsnotify to monitor the inode events in bpffs. A new  
> function
> > > bpf_watch_inode() is introduced. It allows registering a callback
> > > function at inode destruction. For the kernfs case, a callback that
> > > removes kernfs node is registered at the destruction of bpffs inodes.
> > > For other file systems such as sockfs, bpf_watch_inode() can monitor  
> the
> > > destruction of sockfs inodes and the created file entry can hold the  
> bpf
> > > object's reference. In this case, it is truly "pinning".
> >
> > > File operations other than seq_show can also be implemented using bpf.
> > > For example, bpf may be of help for .poll and .mmap in kernfs.
> >
> > This looks awesome!
> >
> > One thing I don't understand is: why did go through the pinning
> > interface VS regular attach/detach? IOW, why not allow regular
> > sys_bpf(BPF_PROG_ATTACH, prog_id, cgroup_id) and attach to the cgroup
> > (which, in turn, creates the kernfs nodes). Seems like this way you can  
> drop
> > the requirement on the object being pinned in the bpffs first?

> Thanks Stan.

> Yeah, the attach/detach approach is definitely another option. IIUC,
> in comparison to pinning, does attach/detach only work for cgroups?

attach has target_fd argument that, in theory, can be whatever. We can
add support for different fd types.

> Pinning may be used on other file systems, sockfs, sysfs or resctrl.
> But I don't know whether this generality is welcome and implementing
> seq_show is the only concrete use case I can think of right now. If
> people think the ability of creating files in other subsystems is not
> good, I'd be happy to take a look at the attach/detach approach and
> that may be the right way.

The reason I started thinking about attach/detach is because of clunky
unlink that you have to do (aka echo "rm" > file). IMO, having standard
attach/detach is a much more clear. But I might be missing some
complexity associated with non-cgroup filesystems.
