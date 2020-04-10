Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 500DC1A4B65
	for <lists+bpf@lfdr.de>; Fri, 10 Apr 2020 22:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgDJUsl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Apr 2020 16:48:41 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:39725 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgDJUsl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Apr 2020 16:48:41 -0400
Received: by mail-qv1-f66.google.com with SMTP id v38so1542002qvf.6
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2020 13:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7W0i1Cg1I5ndUZxWKSLW2NSYUtpwue6+Fzg3/yTyiSo=;
        b=AmG/2ipiY/yKzMndeEJgkiW099tNPSMjnV63fUjS/zPfLTCu/7pA7is45zI3NSmUqC
         TADGAlkjvhFK56HbsrZ+tFK314uQWcrWkX3Xvnx0VmWFrp8oblx7nJdGuFeUoQqw+sH+
         YV5BWf+RLGxX5lDBXEUX6PFNHZKlWq5nFZuSPsQr/u5QUw3ekB6ruf5w7jr9FX/1eJNO
         nbgAXtpP57wQGeQOOpUdBvhXryUAomwalh+KMcNYcGpx39osm72Qj+XpOn78sgjay3Nq
         yu48Jx7Qu+5oVFItkMDFEySURPTbkhXyMOd1MGcMCWur7AyVoeutcIzKS0EEAZ2m6i4S
         TL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7W0i1Cg1I5ndUZxWKSLW2NSYUtpwue6+Fzg3/yTyiSo=;
        b=if/UaqXsge77/RT2BygLzA0I8wKLtX7Ib1rhDlNSc3DpYBpbfXboR9gJXC3Jx+LX57
         OWDa9+mAYqI6lAy6Tbk/y94pEdfvWXE8b+CHDEDZx+x+tN9JbVmLRyGUXCt7xXbqNBtc
         PKCSbs0cmNoifGd8E8I4STP0+mZaiwxZZA3IFkkbN0ntu/kVMAepf2jQ3iKtl/gpLvtV
         Qya2EFnK15nAYdUaa7dp/ZagalWTur/mBLCf4ME1Ptowhya07xmL/qWfBcAwz/e8pTGa
         BMlcSOC+NmKqVZMgCVV9Qbrj0P3DIgqC4G3oCRAA5XudaZK2wwi7YER4VB1rHZGr8bbQ
         aPow==
X-Gm-Message-State: AGi0PuZw+TdyRm/lqL4eNbTlp+MpjKdtycCDaQCQ6S3wSEAbkdV2dCS4
        e4PQGtgSzg9kQTZ84pRc6/iV3U9cy9dtZkQzPkM=
X-Google-Smtp-Source: APiQypJt9LUyYqQ28+3vSuIIAPfrlgQXZgJf4ccAg9F3Bgc1U6YxGxIQ8hM4EL4H4p++WYw8/qT3QgkZi8mXjC9BKoQ=
X-Received: by 2002:a05:6214:1801:: with SMTP id o1mr6794237qvw.224.1586551719523;
 Fri, 10 Apr 2020 13:48:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez2R5nZA91j7cf2Z5o3dOEz0QNZK7cxecjmw0B-ZQ7AjmA@mail.gmail.com>
 <CAEf4Bzb2zcfJt6ujAN8zY_=x7-dFO92mPzkbCE+UMHVDGL7J+Q@mail.gmail.com> <CAG48ez20KjiYjcYzWnnVCyNTMjNFf+YgnwbbF9BUovZxDzsuEw@mail.gmail.com>
In-Reply-To: <CAG48ez20KjiYjcYzWnnVCyNTMjNFf+YgnwbbF9BUovZxDzsuEw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 10 Apr 2020 13:48:27 -0700
Message-ID: <CAEf4BzbEcbgAmXSzKx70rEhzmWcZ_8ECuX98_wsfvRkprKQgbQ@mail.gmail.com>
Subject: Re: BPF map freezing is unreliable; can we instead just inline constants?
To:     Jann Horn <jannh@google.com>
Cc:     bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 10, 2020 at 1:47 AM Jann Horn <jannh@google.com> wrote:
>
> On Fri, Apr 10, 2020 at 1:33 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > On Wed, Apr 8, 2020 at 12:42 PM Jann Horn <jannh@google.com> wrote:
> > >
> > > Hi!
> > >
> > > I saw that BPF allows root to create frozen maps, for which the
> > > verifier then assumes that they contain constant values. However, map
> > > freezing is pretty wobbly:
> > >
> > > 1. The syscalls for updating maps from userspace don't seem to lock
> > > the map at all.
> >
> > True, there is a tiny race between freezing and map updates, but I
> > don't think it's possible to solve it without taking locks all around
> > the place in map update operations.
>
> Yeah. So I think BPF should do exactly that. Or change the userspace
> API so that userspace has to say at map creation time "I'll freeze
> this map later", and then you only have to do the locking if that flag
> is set.

I'd love to be able to create frozen maps from the get go (and specify
initial values for the map), but freezing is done the way it's done
already, unfortunately :(
Regarding locking, maps could be updated from BPF program side as
well. I'd be curious to hear what others think about this issue.

>
> [...]
> > > 3. It is assumed that a memory mapping can't be used to write to a
> > > page anymore after the mapping has been removed; but actually,
> > > userspace can grab references to pages in a VMA and use those
> > > references to write to the VMA's pages after the VMA has already been
> > > closed. (crasher attached as bpf-constant-data-uffd.c, compile with
> > > "gcc -pthread ...")
> >
> > Please help me understand how that works (assuming we drop
> > VM_MAYWRITE, of course). You mmap() as R/W, then munmap(), then
> > freeze(). After munmap() refcount of writable pages should drop to
> > zero. And mmap'ed address should be invalid and unmapped. I'm missing
> > how after munmap() parallel thread still can write to that memory
> > page?
>
> The mmap()/munmap() syscalls place references to the pages the kernel
> is using in the page tables of the process. Some other syscalls (such
> as process_vm_writev()) can read these page table entries, take their
> own references on those backing pages, and then continue to access
> those pages even after they've been removed from the task's page
> tables by munmap(). This works as long as the page table entries don't
> have magic marker bits on them that prohibit this, which you get if
> you use something like remap_pfn_range() in a loop instead of
> remap_vmalloc_range() - but the memory mappings created by that
> syscall are weird, and e.g. some syscalls like read() and write()
> might sometimes fail if the buffer argument points into such a memory
> region.

So mmap() subsystem won't event know about those extra references and
thus we can't really account that in our code, right? That's sad, but
hopefully those APIs are root-only?

>
> [...]
> > > Is there a reason why the verifier doesn't replace loads from frozen
> > > maps with the values stored in those maps? That seems like it would be
> > > not only easier to secure, but additionally more performant.
> >
> > Verifier doesn't always know exact offset at which program is going to
> > read read-only map contents. So something like this works:
> >
> > const volatile long arr[256];
> >
> > int x = rand() % 256;
> > int y = arr[x];
> >
> > In this case verifier doesn't really know the value of y, so it can't
> > be inlined. Then you can have code in which in one branch register is
> > loaded with known value, but in another branch same register gets some
> > value at random offset. Constant tracking is code path-sensitive,
> > while instructions are shared between different code paths. Unless I'm
> > missing what you are proposing :)
>
> Ah, I missed that possibility. But is that actually something that
> people do in practice? Or would it be okay for the verifier to just
> assume an unknown value in these cases?

Verifier will assume unknown value for the branch that has variable
offset. It can't do the same for another branch (with constant offset)
because it might not yet have encountered branch with variable offset.
But either way, you were proposing to rewrite instruction and inline
read constant, and I don't think it's possible because of this.
