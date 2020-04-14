Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 682F11A8EC5
	for <lists+bpf@lfdr.de>; Wed, 15 Apr 2020 00:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730876AbgDNWuy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Apr 2020 18:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729551AbgDNWuw (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 14 Apr 2020 18:50:52 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BB8C061A0C
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2020 15:50:51 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id t11so1108400lfe.4
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2020 15:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FKxwBNOyus8z2fM9jxXF1C+iqmXwqjuWKuRmfnBkzgg=;
        b=Y0vJeJ18rwLWovP/Hiisv43iv0pcSzCP2b5x11fhY/YmWNeXjmYvP66fx+22zfJeOS
         JMeGTVXT/BHZthqAZLTH+Pm8p002Gen5TYw7IMfiL/yPdnFfBXhLiRbztD3wiDEJv67i
         ZbPthEoLMhE39MPQ7XqvvQCG12vyOGyPAW9tP4qgmWseG/TD7GmhP1WGjUgSKqgnljmX
         g4apQWzMYg57dEdJrBcWx6lUP7ACmC+kc4XIDLXWtBqOHuSflhqGwDgyIZeSrMh30VKV
         MbxFaptenE5mDTbxbH/AcwJ2J9DInhL4sEX2u1bl1t6KjaKJWfAbDNGTZpG4i56SyLTA
         u6xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FKxwBNOyus8z2fM9jxXF1C+iqmXwqjuWKuRmfnBkzgg=;
        b=MIDQfa14dPVLsAy3++zmECL4uO9l9kq6pgRLjDQS3WyqHawqGrEaDMawPcsOaNY2w2
         K1/i+X8Vw0MSr+9DFZFrH79JFYi52X9k1M6/3e/SS9dUTkGZfGt5WPAM6/E0DRlUUvUV
         cAZFmnQK718+eiWHIBvJD11ZJwaHt1Ag3Jo0qQ3Uibzr6QdJ4duGexw6efOO7dX8bKl2
         65ElgyYGoy1yt9NS/1Ocofw39AjWTg+dDCZkAjn3MgWVxJwxh1iSJ2cwl0CKa/MIOQCd
         FUvH8IINOMJn6ALfcrWWkpdxR7TJBw8Slszuch+XieKBhmaWa2Cyux/VOdsLI8qv7w8J
         nSVQ==
X-Gm-Message-State: AGi0PuZXG6I39iKx3RkghUTZQVcYaXB46porStjS3ebzBSfyN6HF0yZs
        JGua2bWvDon3TX9xUR9ie1lqwzre9UlriiiCUFX/QA==
X-Google-Smtp-Source: APiQypI0MObRxdhEZCn1mAyg/ql68+VdA2gfvxM36B3D6UzjLmr0rRLCPtDo+PZ1QG6nl5numSTD2z/iE9MB2RkGHgw=
X-Received: by 2002:ac2:4257:: with SMTP id m23mr1167697lfl.141.1586904650031;
 Tue, 14 Apr 2020 15:50:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez2R5nZA91j7cf2Z5o3dOEz0QNZK7cxecjmw0B-ZQ7AjmA@mail.gmail.com>
 <CAEf4Bzb2zcfJt6ujAN8zY_=x7-dFO92mPzkbCE+UMHVDGL7J+Q@mail.gmail.com>
 <CAG48ez20KjiYjcYzWnnVCyNTMjNFf+YgnwbbF9BUovZxDzsuEw@mail.gmail.com>
 <CAEf4BzbEcbgAmXSzKx70rEhzmWcZ_8ECuX98_wsfvRkprKQgbQ@mail.gmail.com>
 <CAG48ez15gsNtjiwFtLR_eBGAZnfXAt4O+ykuaopVf+jW5KTeRQ@mail.gmail.com> <CAEf4Bzak3FnhD3kUZ4Dn9ZRz=yWSfZ+nkYa1Gz1WeZO7PC7Wkw@mail.gmail.com>
In-Reply-To: <CAEf4Bzak3FnhD3kUZ4Dn9ZRz=yWSfZ+nkYa1Gz1WeZO7PC7Wkw@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 15 Apr 2020 00:50:23 +0200
Message-ID: <CAG48ez0mmVtBVTjy-KmpUnvJ52O=EYKwJWoCxcXH8O6zCG1QHA@mail.gmail.com>
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

On Tue, Apr 14, 2020 at 9:46 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> On Tue, Apr 14, 2020 at 9:07 AM Jann Horn <jannh@google.com> wrote:
> > On Fri, Apr 10, 2020 at 10:48 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > > On Fri, Apr 10, 2020 at 1:47 AM Jann Horn <jannh@google.com> wrote:
> > > > On Fri, Apr 10, 2020 at 1:33 AM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > On Wed, Apr 8, 2020 at 12:42 PM Jann Horn <jannh@google.com> wrote:
> > > > > >
> > > > > > Hi!
> > > > > >
> > > > > > I saw that BPF allows root to create frozen maps, for which the
> > > > > > verifier then assumes that they contain constant values. However, map
> > > > > > freezing is pretty wobbly:
[...]
> > > > > > 3. It is assumed that a memory mapping can't be used to write to a
> > > > > > page anymore after the mapping has been removed; but actually,
> > > > > > userspace can grab references to pages in a VMA and use those
> > > > > > references to write to the VMA's pages after the VMA has already been
> > > > > > closed. (crasher attached as bpf-constant-data-uffd.c, compile with
> > > > > > "gcc -pthread ...")
> > > > >
> > > > > Please help me understand how that works (assuming we drop
> > > > > VM_MAYWRITE, of course). You mmap() as R/W, then munmap(), then
> > > > > freeze(). After munmap() refcount of writable pages should drop to
> > > > > zero. And mmap'ed address should be invalid and unmapped. I'm missing
> > > > > how after munmap() parallel thread still can write to that memory
> > > > > page?
> > > >
> > > > The mmap()/munmap() syscalls place references to the pages the kernel
> > > > is using in the page tables of the process. Some other syscalls (such
> > > > as process_vm_writev()) can read these page table entries, take their
> > > > own references on those backing pages, and then continue to access
> > > > those pages even after they've been removed from the task's page
> > > > tables by munmap(). This works as long as the page table entries don't
> > > > have magic marker bits on them that prohibit this, which you get if
> > > > you use something like remap_pfn_range() in a loop instead of
> > > > remap_vmalloc_range() - but the memory mappings created by that
> > > > syscall are weird, and e.g. some syscalls like read() and write()
> > > > might sometimes fail if the buffer argument points into such a memory
> > > > region.
> > >
> > > So mmap() subsystem won't event know about those extra references and
> > > thus we can't really account that in our code, right? That's sad, but
> > > hopefully those APIs are root-only?
> >
> > Nope, those APIs are reachable by normal users. These extra references
> > are counted on the page refcount - since they have to be tracked
> > somehow - but as far as I know, that refcount can also be elevated
> > spuriously, so triggering hard errors based on it is probably not a
> > good idea.
> >
>
> Just trying to educate myself and you seem to know a lot about this.
> If we think about regular file memory-mapping with mmap(). According
> to this, it seems like it would be possible to mmap() file as writable
> first, do some changes and then munmap. At this point some application
> would assume that file can't be modified anymore and can be treated as
> read-only, yet, it's possible that some other process/thread can just
> go and still modify file contents. Do I understand correctly?

Yep, exactly.

There are some longstanding issues around this stuff - e.g. in some
contrived scenarios, this can mean that when you call read() and
fork() at the same time in a multithreaded process, the data you read
becomes visible in the child instead of in the parent
(https://lore.kernel.org/lkml/CAG48ez17Of=dnymzm8GAN_CNG1okMg1KTeMtBQhXGP2dyB5uJw@mail.gmail.com/).
At least a while ago, it could also cause crashes in filesystem code
(see e.g. https://lwn.net/Articles/774411/), and cause issues for code
that wants to compute stable checksums of pages
(https://lwn.net/Articles/787636/); I'm not sure what the state of
that stuff is.

> > > > > > Is there a reason why the verifier doesn't replace loads from frozen
> > > > > > maps with the values stored in those maps? That seems like it would be
> > > > > > not only easier to secure, but additionally more performant.
> > > > >
> > > > > Verifier doesn't always know exact offset at which program is going to
> > > > > read read-only map contents. So something like this works:
> > > > >
> > > > > const volatile long arr[256];
> > > > >
> > > > > int x = rand() % 256;
> > > > > int y = arr[x];
> > > > >
> > > > > In this case verifier doesn't really know the value of y, so it can't
> > > > > be inlined. Then you can have code in which in one branch register is
> > > > > loaded with known value, but in another branch same register gets some
> > > > > value at random offset. Constant tracking is code path-sensitive,
> > > > > while instructions are shared between different code paths. Unless I'm
> > > > > missing what you are proposing :)
> > > >
> > > > Ah, I missed that possibility. But is that actually something that
> > > > people do in practice? Or would it be okay for the verifier to just
> > > > assume an unknown value in these cases?
> > >
> > > Verifier will assume unknown value for the branch that has variable
> > > offset. It can't do the same for another branch (with constant offset)
> > > because it might not yet have encountered branch with variable offset.
> > > But either way, you were proposing to rewrite instruction and inline
> > > read constant, and I don't think it's possible because of this.
> >
> > Ah, I see what you mean. That sucks. I guess that means that to fix
> > this up properly in such edgecases, we'd have to, for each memory
> > read, keep track of all the values that we want to hardcode for it,
> > and then generate branches in the unlikely case that the instruction
> > was reached on paths that expect different values?
>
> I guess, though that sounds extreme and extremely unlikely.

It just seems kinda silly to me to have extra memory loads if we know
that those loads will in most cases load the same fixed value on every
execution... but oh well.

> I'd say
> the better way would be to implement immutable BPF maps from the time
> they are created. E.g., at the time of creating map, you specify extra
> flag BPF_F_IMMUTABLE and specify pointer to a blob of memory with
> key/value pairs in it.

It seems a bit hacky to me to add a new special interface for
populating an immutable map. Wouldn't it make more sense to add a flag
for "you can't use mmap on this map", or "I plan to freeze this map",
or something like that, and keep the freezing API?
