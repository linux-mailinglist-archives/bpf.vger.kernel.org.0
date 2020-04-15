Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3F5A1A9223
	for <lists+bpf@lfdr.de>; Wed, 15 Apr 2020 06:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393182AbgDOE7V (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Apr 2020 00:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393136AbgDOE7R (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Apr 2020 00:59:17 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF54C061A0C
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2020 21:59:17 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id j4so15916753qkc.11
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2020 21:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CNuXmYYBWHM0qJxc1Tgf3dRJKLy06lMQYZT/VsCanWw=;
        b=NJmm4k6ZJYgbqvTVxypoRtij9rIV7pNKdxR2oGHU0gM7Uo1EQCppxcO4x90C/dQfy4
         EW0M2WgeRh8pS1UtfuXxQZ6dWhMasII/3WywCpzE16IItE4qPtjlddrfoMlAEt28lilt
         6pXpABMYGWkid+OK9Yh55eXnD5arVfOYxRgAKMm2GaT8+qhagNkehw8erJrlS1+yck28
         Gec3E8C4HwijJJWQD5DTEY6J+LNB0s6bbWCGxpdcxVrZTbbCOq+tqWrKqfJbrf3vu1GA
         HZgRVSEp3Q+HrPax60SOYdEbUm+sVYNW2czRFJrt0vT+nUeGdyI1egFB64EUJKRYc0FN
         dU6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CNuXmYYBWHM0qJxc1Tgf3dRJKLy06lMQYZT/VsCanWw=;
        b=Hf6/4cNLBHIu3p04q2ntcBeYqjyadO2ruTrlaDMYQM//ss3B+Ty3Hw9KB1a2nOe5Uz
         W3sGd6ykDg0te5eOBAYZhnwQhANOnlp1NRMDM6xSG1xflAjBsy/XbZmgO9pkTBbXOPVE
         G4fcX354zq9h4ripb/6/eFbZNx+SccBkMXWQx17tmtxiUa0m7ojiKR0wl6dLxBh1WeAY
         cOEU9emEIHiEQPgOVRGbX9lOlHuhifR5HvPN5yzi+L4Wmk5NWlRZqOcIvbQ2Qong1yW6
         IlXDBAAL5fKuJW8LDskPwVOzLi2MzoAo32AT38Ny2qbJeky7sEPi2zAUHZvB3sAktS2+
         i5OA==
X-Gm-Message-State: AGi0PuYbZzJ/MZLqeu8U/cLZsyw8BhM75eK2bIOkWYE5g9Sd3yhFRoqh
        8x/xPP7ylmSEMLJxgQr0ty9SXWJS/8zel/XOtMQ=
X-Google-Smtp-Source: APiQypJRCuahceBiruUkQw/2i4ZIkT82SAyxOYDGxMbT7M3tyJaTAhA6L7A3afweUQtQRcic5tF3ATOcfAZkJz9+5PM=
X-Received: by 2002:ae9:e854:: with SMTP id a81mr24550025qkg.36.1586926756320;
 Tue, 14 Apr 2020 21:59:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez2R5nZA91j7cf2Z5o3dOEz0QNZK7cxecjmw0B-ZQ7AjmA@mail.gmail.com>
 <CAEf4Bzb2zcfJt6ujAN8zY_=x7-dFO92mPzkbCE+UMHVDGL7J+Q@mail.gmail.com>
 <CAG48ez20KjiYjcYzWnnVCyNTMjNFf+YgnwbbF9BUovZxDzsuEw@mail.gmail.com>
 <CAEf4BzbEcbgAmXSzKx70rEhzmWcZ_8ECuX98_wsfvRkprKQgbQ@mail.gmail.com>
 <CAG48ez15gsNtjiwFtLR_eBGAZnfXAt4O+ykuaopVf+jW5KTeRQ@mail.gmail.com>
 <CAEf4Bzak3FnhD3kUZ4Dn9ZRz=yWSfZ+nkYa1Gz1WeZO7PC7Wkw@mail.gmail.com> <CAG48ez0mmVtBVTjy-KmpUnvJ52O=EYKwJWoCxcXH8O6zCG1QHA@mail.gmail.com>
In-Reply-To: <CAG48ez0mmVtBVTjy-KmpUnvJ52O=EYKwJWoCxcXH8O6zCG1QHA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 14 Apr 2020 21:59:05 -0700
Message-ID: <CAEf4BzZ2vmdmn111KXXrp3qp1qLb4iMjUJ11Cj06SOGeOB6_Qg@mail.gmail.com>
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

On Tue, Apr 14, 2020 at 3:50 PM Jann Horn <jannh@google.com> wrote:
>
> On Tue, Apr 14, 2020 at 9:46 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > On Tue, Apr 14, 2020 at 9:07 AM Jann Horn <jannh@google.com> wrote:
> > > On Fri, Apr 10, 2020 at 10:48 PM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > > On Fri, Apr 10, 2020 at 1:47 AM Jann Horn <jannh@google.com> wrote:
> > > > > On Fri, Apr 10, 2020 at 1:33 AM Andrii Nakryiko
> > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > > On Wed, Apr 8, 2020 at 12:42 PM Jann Horn <jannh@google.com> wrote:
> > > > > > >
> > > > > > > Hi!
> > > > > > >
> > > > > > > I saw that BPF allows root to create frozen maps, for which the
> > > > > > > verifier then assumes that they contain constant values. However, map
> > > > > > > freezing is pretty wobbly:
> [...]
> > > > > > > 3. It is assumed that a memory mapping can't be used to write to a
> > > > > > > page anymore after the mapping has been removed; but actually,
> > > > > > > userspace can grab references to pages in a VMA and use those
> > > > > > > references to write to the VMA's pages after the VMA has already been
> > > > > > > closed. (crasher attached as bpf-constant-data-uffd.c, compile with
> > > > > > > "gcc -pthread ...")
> > > > > >
> > > > > > Please help me understand how that works (assuming we drop
> > > > > > VM_MAYWRITE, of course). You mmap() as R/W, then munmap(), then
> > > > > > freeze(). After munmap() refcount of writable pages should drop to
> > > > > > zero. And mmap'ed address should be invalid and unmapped. I'm missing
> > > > > > how after munmap() parallel thread still can write to that memory
> > > > > > page?
> > > > >
> > > > > The mmap()/munmap() syscalls place references to the pages the kernel
> > > > > is using in the page tables of the process. Some other syscalls (such
> > > > > as process_vm_writev()) can read these page table entries, take their
> > > > > own references on those backing pages, and then continue to access
> > > > > those pages even after they've been removed from the task's page
> > > > > tables by munmap(). This works as long as the page table entries don't
> > > > > have magic marker bits on them that prohibit this, which you get if
> > > > > you use something like remap_pfn_range() in a loop instead of
> > > > > remap_vmalloc_range() - but the memory mappings created by that
> > > > > syscall are weird, and e.g. some syscalls like read() and write()
> > > > > might sometimes fail if the buffer argument points into such a memory
> > > > > region.
> > > >
> > > > So mmap() subsystem won't event know about those extra references and
> > > > thus we can't really account that in our code, right? That's sad, but
> > > > hopefully those APIs are root-only?
> > >
> > > Nope, those APIs are reachable by normal users. These extra references
> > > are counted on the page refcount - since they have to be tracked
> > > somehow - but as far as I know, that refcount can also be elevated
> > > spuriously, so triggering hard errors based on it is probably not a
> > > good idea.
> > >
> >
> > Just trying to educate myself and you seem to know a lot about this.
> > If we think about regular file memory-mapping with mmap(). According
> > to this, it seems like it would be possible to mmap() file as writable
> > first, do some changes and then munmap. At this point some application
> > would assume that file can't be modified anymore and can be treated as
> > read-only, yet, it's possible that some other process/thread can just
> > go and still modify file contents. Do I understand correctly?
>
> Yep, exactly.
>
> There are some longstanding issues around this stuff - e.g. in some
> contrived scenarios, this can mean that when you call read() and
> fork() at the same time in a multithreaded process, the data you read
> becomes visible in the child instead of in the parent
> (https://lore.kernel.org/lkml/CAG48ez17Of=dnymzm8GAN_CNG1okMg1KTeMtBQhXGP2dyB5uJw@mail.gmail.com/).
> At least a while ago, it could also cause crashes in filesystem code
> (see e.g. https://lwn.net/Articles/774411/), and cause issues for code
> that wants to compute stable checksums of pages
> (https://lwn.net/Articles/787636/); I'm not sure what the state of
> that stuff is.

Oh, ok, thanks for details. This is... illuminating for sure...

>
> > > > > > > Is there a reason why the verifier doesn't replace loads from frozen
> > > > > > > maps with the values stored in those maps? That seems like it would be
> > > > > > > not only easier to secure, but additionally more performant.
> > > > > >
> > > > > > Verifier doesn't always know exact offset at which program is going to
> > > > > > read read-only map contents. So something like this works:
> > > > > >
> > > > > > const volatile long arr[256];
> > > > > >
> > > > > > int x = rand() % 256;
> > > > > > int y = arr[x];
> > > > > >
> > > > > > In this case verifier doesn't really know the value of y, so it can't
> > > > > > be inlined. Then you can have code in which in one branch register is
> > > > > > loaded with known value, but in another branch same register gets some
> > > > > > value at random offset. Constant tracking is code path-sensitive,
> > > > > > while instructions are shared between different code paths. Unless I'm
> > > > > > missing what you are proposing :)
> > > > >
> > > > > Ah, I missed that possibility. But is that actually something that
> > > > > people do in practice? Or would it be okay for the verifier to just
> > > > > assume an unknown value in these cases?
> > > >
> > > > Verifier will assume unknown value for the branch that has variable
> > > > offset. It can't do the same for another branch (with constant offset)
> > > > because it might not yet have encountered branch with variable offset.
> > > > But either way, you were proposing to rewrite instruction and inline
> > > > read constant, and I don't think it's possible because of this.
> > >
> > > Ah, I see what you mean. That sucks. I guess that means that to fix
> > > this up properly in such edgecases, we'd have to, for each memory
> > > read, keep track of all the values that we want to hardcode for it,
> > > and then generate branches in the unlikely case that the instruction
> > > was reached on paths that expect different values?
> >
> > I guess, though that sounds extreme and extremely unlikely.
>
> It just seems kinda silly to me to have extra memory loads if we know
> that those loads will in most cases load the same fixed value on every
> execution... but oh well.
>
> > I'd say
> > the better way would be to implement immutable BPF maps from the time
> > they are created. E.g., at the time of creating map, you specify extra
> > flag BPF_F_IMMUTABLE and specify pointer to a blob of memory with
> > key/value pairs in it.
>
> It seems a bit hacky to me to add a new special interface for
> populating an immutable map. Wouldn't it make more sense to add a flag
> for "you can't use mmap on this map", or "I plan to freeze this map",
> or something like that, and keep the freezing API?

"you can't use mmap on this map" is default behavior, unless you
specify BPF_F_MMAPABLE. "I plan to freeze this map" could be added,
but how that would help existing users that freeze and mmap()?
Disallowing those now would be a breaking change.

Currently, libbpf is using freezing for .rodata variables, but it
doesn't mmap() before freezing. What we are talking about is malicious
user trying to cause a crash, which given everything is under root is
a bit of a moot point. So I don't know if we actually want to fix
anything here, given that lots of filesystems are already broken for a
while for similar reasons... But it's certainly good to know about
issues like this.
