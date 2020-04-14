Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACD811A8431
	for <lists+bpf@lfdr.de>; Tue, 14 Apr 2020 18:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbgDNQIB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Apr 2020 12:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388269AbgDNQH6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 14 Apr 2020 12:07:58 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE48C061A0C
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2020 09:07:57 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id 131so150441lfh.11
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2020 09:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5YQPLSU7Z2DuhlE5I6MHLBPZaJGA7qq5mKOqOaM5NLs=;
        b=Ojm7DGDCXlAYFIK/9DfVZ86gfbzvZQ5gAtUTlZxxyV0yKA02nkezct+XXv/90kgy9T
         sDUzImWQoEkCej3OC+4OGnQK7f49Iy0KAvIwtqNVMmJkNyv+UyIIoiQNtEgCmVB9vUAn
         WcuznFtXtxkHS7DS14/5ACVsZS5UPc2eZjLoA9Ut4WijslJuctx/32QAV47wyR1Oi9SM
         ugMXzRzh4JybEWy6XdykH8CgbiIbVHR2uqq6l4AQbx5ON5HoAx8gs2Twmhg7KdU2+gKF
         npcxdhbJGkUMxa9A7qcwa0sfVedc0WHtYj7N1XF7Y7dQq259+3bs11tYEF04Bh11fKzt
         Ai+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5YQPLSU7Z2DuhlE5I6MHLBPZaJGA7qq5mKOqOaM5NLs=;
        b=qGBOiS7P0N4stpDBr45KqHL/Qdn+MM156kkMJgZSwcT1qv2xxCbx02GA1JaL/f8GrP
         ts5Rh+pWtOQFx9G7a2U6hunqFQl/YBMxvpbdQHkKqj5+57aizGoWdrfs32fbV0uufZ8I
         bb1QSTHN9EMSzdCKcmY+AJVtVJi4zvB8boLNigN7vOAUSanlLwv9g/iFP/RCbTqvg3wv
         9a4ikRMz6OdeVo9ZZsAbNtD9A6vGvLOb9Eke9DNfW8nar0QO7so3egWKiObO2P/+ZEyR
         FOThHgAKhSKJT/hvhxhfpGFoxRmJDsNGU0JXLPJ85d0Bnu6J37ydGOnTm+ZzSD2BvuSB
         ODIA==
X-Gm-Message-State: AGi0PubjeQR8fGrKHXQ6D2mGykz+53Ypr3UT1vTiGg2Hkd2wBf0pEx2r
        8WxnqI/JciQHWa00bJwi41mypyQTxt5dsDd4Yek7RA==
X-Google-Smtp-Source: APiQypJKnIsMzOvrBH+wDbSqrQonRYtBwCWIGK3RTMTYt1McXC10y42HGX5EAuH0cVldpA4dMOr1Fh+Y5fbfmfsK6mg=
X-Received: by 2002:ac2:4a76:: with SMTP id q22mr313130lfp.157.1586880475611;
 Tue, 14 Apr 2020 09:07:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez2R5nZA91j7cf2Z5o3dOEz0QNZK7cxecjmw0B-ZQ7AjmA@mail.gmail.com>
 <CAEf4Bzb2zcfJt6ujAN8zY_=x7-dFO92mPzkbCE+UMHVDGL7J+Q@mail.gmail.com>
 <CAG48ez20KjiYjcYzWnnVCyNTMjNFf+YgnwbbF9BUovZxDzsuEw@mail.gmail.com> <CAEf4BzbEcbgAmXSzKx70rEhzmWcZ_8ECuX98_wsfvRkprKQgbQ@mail.gmail.com>
In-Reply-To: <CAEf4BzbEcbgAmXSzKx70rEhzmWcZ_8ECuX98_wsfvRkprKQgbQ@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 14 Apr 2020 18:07:29 +0200
Message-ID: <CAG48ez15gsNtjiwFtLR_eBGAZnfXAt4O+ykuaopVf+jW5KTeRQ@mail.gmail.com>
Subject: Re: BPF map freezing is unreliable; can we instead just inline constants?
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 10, 2020 at 10:48 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> On Fri, Apr 10, 2020 at 1:47 AM Jann Horn <jannh@google.com> wrote:
> > On Fri, Apr 10, 2020 at 1:33 AM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > > On Wed, Apr 8, 2020 at 12:42 PM Jann Horn <jannh@google.com> wrote:
> > > >
> > > > Hi!
> > > >
> > > > I saw that BPF allows root to create frozen maps, for which the
> > > > verifier then assumes that they contain constant values. However, map
> > > > freezing is pretty wobbly:
> > > >
> > > > 1. The syscalls for updating maps from userspace don't seem to lock
> > > > the map at all.
> > >
> > > True, there is a tiny race between freezing and map updates, but I
> > > don't think it's possible to solve it without taking locks all around
> > > the place in map update operations.
> >
> > Yeah. So I think BPF should do exactly that. Or change the userspace
> > API so that userspace has to say at map creation time "I'll freeze
> > this map later", and then you only have to do the locking if that flag
> > is set.
>
> I'd love to be able to create frozen maps from the get go (and specify
> initial values for the map), but freezing is done the way it's done
> already, unfortunately :(
> Regarding locking, maps could be updated from BPF program side as
> well. I'd be curious to hear what others think about this issue.

Map freezing only has an effect on the verifier if the map was created
with BPF_F_RDONLY_PROG, which prevents the BPF program from updating
the map, right?

> > > > 3. It is assumed that a memory mapping can't be used to write to a
> > > > page anymore after the mapping has been removed; but actually,
> > > > userspace can grab references to pages in a VMA and use those
> > > > references to write to the VMA's pages after the VMA has already been
> > > > closed. (crasher attached as bpf-constant-data-uffd.c, compile with
> > > > "gcc -pthread ...")
> > >
> > > Please help me understand how that works (assuming we drop
> > > VM_MAYWRITE, of course). You mmap() as R/W, then munmap(), then
> > > freeze(). After munmap() refcount of writable pages should drop to
> > > zero. And mmap'ed address should be invalid and unmapped. I'm missing
> > > how after munmap() parallel thread still can write to that memory
> > > page?
> >
> > The mmap()/munmap() syscalls place references to the pages the kernel
> > is using in the page tables of the process. Some other syscalls (such
> > as process_vm_writev()) can read these page table entries, take their
> > own references on those backing pages, and then continue to access
> > those pages even after they've been removed from the task's page
> > tables by munmap(). This works as long as the page table entries don't
> > have magic marker bits on them that prohibit this, which you get if
> > you use something like remap_pfn_range() in a loop instead of
> > remap_vmalloc_range() - but the memory mappings created by that
> > syscall are weird, and e.g. some syscalls like read() and write()
> > might sometimes fail if the buffer argument points into such a memory
> > region.
>
> So mmap() subsystem won't event know about those extra references and
> thus we can't really account that in our code, right? That's sad, but
> hopefully those APIs are root-only?

Nope, those APIs are reachable by normal users. These extra references
are counted on the page refcount - since they have to be tracked
somehow - but as far as I know, that refcount can also be elevated
spuriously, so triggering hard errors based on it is probably not a
good idea.


> > > > Is there a reason why the verifier doesn't replace loads from frozen
> > > > maps with the values stored in those maps? That seems like it would be
> > > > not only easier to secure, but additionally more performant.
> > >
> > > Verifier doesn't always know exact offset at which program is going to
> > > read read-only map contents. So something like this works:
> > >
> > > const volatile long arr[256];
> > >
> > > int x = rand() % 256;
> > > int y = arr[x];
> > >
> > > In this case verifier doesn't really know the value of y, so it can't
> > > be inlined. Then you can have code in which in one branch register is
> > > loaded with known value, but in another branch same register gets some
> > > value at random offset. Constant tracking is code path-sensitive,
> > > while instructions are shared between different code paths. Unless I'm
> > > missing what you are proposing :)
> >
> > Ah, I missed that possibility. But is that actually something that
> > people do in practice? Or would it be okay for the verifier to just
> > assume an unknown value in these cases?
>
> Verifier will assume unknown value for the branch that has variable
> offset. It can't do the same for another branch (with constant offset)
> because it might not yet have encountered branch with variable offset.
> But either way, you were proposing to rewrite instruction and inline
> read constant, and I don't think it's possible because of this.

Ah, I see what you mean. That sucks. I guess that means that to fix
this up properly in such edgecases, we'd have to, for each memory
read, keep track of all the values that we want to hardcode for it,
and then generate branches in the unlikely case that the instruction
was reached on paths that expect different values?
