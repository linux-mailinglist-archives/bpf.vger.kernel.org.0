Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 664F51A8C6C
	for <lists+bpf@lfdr.de>; Tue, 14 Apr 2020 22:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633078AbgDNUYr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Apr 2020 16:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2633074AbgDNUYp (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 14 Apr 2020 16:24:45 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A62C061A0E
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2020 12:46:32 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id j4so14659852qkc.11
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2020 12:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CgGq5FiEKZmQAaQgAQGhZKkpfBAzulsYGoB6mb/dhBA=;
        b=mo8XlNjbEx5FVSkOI9c/RwKo5QCgb2N77IM2hLMbg5Ca9uau0R56rG89qlMM3+GD1r
         tkD/xw5I8h1fsi6jyNgwxXYJscu9Zj/ZLJBgQgfIK8Of3tt384wKCYe58D1CpcG6ZvO3
         Dlv1q/gC/5zt320a/4Q5OMRuUBtrrJafXGJYrV7tIT64iGBxEPBZ0Pk1mtDHsJ4j2kEs
         N6KyuJgMqMFHpxCs4ZiEbjvd/z37q+Uu58cTF86aZOkbmqdgiETf4U9+XXik2jXAmXz1
         z/uPT1OnYHtM3VcvsERmKRuzeHOZMvSlfzzPt2S+liNBrGy5jxTnS3rhE+/NPhxY9zoy
         sEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CgGq5FiEKZmQAaQgAQGhZKkpfBAzulsYGoB6mb/dhBA=;
        b=TwHwCn/QMUao7yzEeqWGuQeDuzrxi18iBP35KLTdtK/KwgjeM15cozuF1clCZ1/u0P
         MeCNlz5NraFlvYNsxwLVtSSGJziqvSE7dfeYBxQxC6Q0ud7oWXzKkmt7gRgcXFMmz28E
         eo5aoBnGNd3N5B5JXbprjKw7f2VIsHpN/sldDrjn6c4wDwcbjSyfWhd9kFXrjDSz5eun
         Hw2/xMCDby0Tlsn0jqV5hEvho+TN7BQRJ6KUKnxKm3tw6T2g9f9Nt0vGzsnkHoHMohlb
         KxOMyUp9kD4FSoF6bicV+x/h+TX5+Ihyx3gkvPmdO5RmXTJICdNwh/XprcjrSWB2cYSv
         vm1w==
X-Gm-Message-State: AGi0PuZd8siOdJGpx7/q7WERSUgGd9DUvrD7j5P/b+YVf74pZSS69Z0g
        phLQsC7Z7GdQXPQ1FpmaIalREuLzCyLnXt11fdw=
X-Google-Smtp-Source: APiQypJvOajLjGB8zaQ5mBNRActEXeTOeRb7Mks8o79bulsFZt710GnNHRn2xiVAlEXt93y/VzchF351j0EsiYjthVE=
X-Received: by 2002:a05:620a:88e:: with SMTP id b14mr24111039qka.449.1586893591584;
 Tue, 14 Apr 2020 12:46:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez2R5nZA91j7cf2Z5o3dOEz0QNZK7cxecjmw0B-ZQ7AjmA@mail.gmail.com>
 <CAEf4Bzb2zcfJt6ujAN8zY_=x7-dFO92mPzkbCE+UMHVDGL7J+Q@mail.gmail.com>
 <CAG48ez20KjiYjcYzWnnVCyNTMjNFf+YgnwbbF9BUovZxDzsuEw@mail.gmail.com>
 <CAEf4BzbEcbgAmXSzKx70rEhzmWcZ_8ECuX98_wsfvRkprKQgbQ@mail.gmail.com> <CAG48ez15gsNtjiwFtLR_eBGAZnfXAt4O+ykuaopVf+jW5KTeRQ@mail.gmail.com>
In-Reply-To: <CAG48ez15gsNtjiwFtLR_eBGAZnfXAt4O+ykuaopVf+jW5KTeRQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 14 Apr 2020 12:46:20 -0700
Message-ID: <CAEf4Bzak3FnhD3kUZ4Dn9ZRz=yWSfZ+nkYa1Gz1WeZO7PC7Wkw@mail.gmail.com>
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

On Tue, Apr 14, 2020 at 9:07 AM Jann Horn <jannh@google.com> wrote:
>
> On Fri, Apr 10, 2020 at 10:48 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > On Fri, Apr 10, 2020 at 1:47 AM Jann Horn <jannh@google.com> wrote:
> > > On Fri, Apr 10, 2020 at 1:33 AM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > > On Wed, Apr 8, 2020 at 12:42 PM Jann Horn <jannh@google.com> wrote:
> > > > >
> > > > > Hi!
> > > > >
> > > > > I saw that BPF allows root to create frozen maps, for which the
> > > > > verifier then assumes that they contain constant values. However, map
> > > > > freezing is pretty wobbly:
> > > > >
> > > > > 1. The syscalls for updating maps from userspace don't seem to lock
> > > > > the map at all.
> > > >
> > > > True, there is a tiny race between freezing and map updates, but I
> > > > don't think it's possible to solve it without taking locks all around
> > > > the place in map update operations.
> > >
> > > Yeah. So I think BPF should do exactly that. Or change the userspace
> > > API so that userspace has to say at map creation time "I'll freeze
> > > this map later", and then you only have to do the locking if that flag
> > > is set.
> >
> > I'd love to be able to create frozen maps from the get go (and specify
> > initial values for the map), but freezing is done the way it's done
> > already, unfortunately :(
> > Regarding locking, maps could be updated from BPF program side as
> > well. I'd be curious to hear what others think about this issue.
>
> Map freezing only has an effect on the verifier if the map was created
> with BPF_F_RDONLY_PROG, which prevents the BPF program from updating
> the map, right?

Yes, good point.

>
> > > > > 3. It is assumed that a memory mapping can't be used to write to a
> > > > > page anymore after the mapping has been removed; but actually,
> > > > > userspace can grab references to pages in a VMA and use those
> > > > > references to write to the VMA's pages after the VMA has already been
> > > > > closed. (crasher attached as bpf-constant-data-uffd.c, compile with
> > > > > "gcc -pthread ...")
> > > >
> > > > Please help me understand how that works (assuming we drop
> > > > VM_MAYWRITE, of course). You mmap() as R/W, then munmap(), then
> > > > freeze(). After munmap() refcount of writable pages should drop to
> > > > zero. And mmap'ed address should be invalid and unmapped. I'm missing
> > > > how after munmap() parallel thread still can write to that memory
> > > > page?
> > >
> > > The mmap()/munmap() syscalls place references to the pages the kernel
> > > is using in the page tables of the process. Some other syscalls (such
> > > as process_vm_writev()) can read these page table entries, take their
> > > own references on those backing pages, and then continue to access
> > > those pages even after they've been removed from the task's page
> > > tables by munmap(). This works as long as the page table entries don't
> > > have magic marker bits on them that prohibit this, which you get if
> > > you use something like remap_pfn_range() in a loop instead of
> > > remap_vmalloc_range() - but the memory mappings created by that
> > > syscall are weird, and e.g. some syscalls like read() and write()
> > > might sometimes fail if the buffer argument points into such a memory
> > > region.
> >
> > So mmap() subsystem won't event know about those extra references and
> > thus we can't really account that in our code, right? That's sad, but
> > hopefully those APIs are root-only?
>
> Nope, those APIs are reachable by normal users. These extra references
> are counted on the page refcount - since they have to be tracked
> somehow - but as far as I know, that refcount can also be elevated
> spuriously, so triggering hard errors based on it is probably not a
> good idea.
>

Just trying to educate myself and you seem to know a lot about this.
If we think about regular file memory-mapping with mmap(). According
to this, it seems like it would be possible to mmap() file as writable
first, do some changes and then munmap. At this point some application
would assume that file can't be modified anymore and can be treated as
read-only, yet, it's possible that some other process/thread can just
go and still modify file contents. Do I understand correctly?

>
> > > > > Is there a reason why the verifier doesn't replace loads from frozen
> > > > > maps with the values stored in those maps? That seems like it would be
> > > > > not only easier to secure, but additionally more performant.
> > > >
> > > > Verifier doesn't always know exact offset at which program is going to
> > > > read read-only map contents. So something like this works:
> > > >
> > > > const volatile long arr[256];
> > > >
> > > > int x = rand() % 256;
> > > > int y = arr[x];
> > > >
> > > > In this case verifier doesn't really know the value of y, so it can't
> > > > be inlined. Then you can have code in which in one branch register is
> > > > loaded with known value, but in another branch same register gets some
> > > > value at random offset. Constant tracking is code path-sensitive,
> > > > while instructions are shared between different code paths. Unless I'm
> > > > missing what you are proposing :)
> > >
> > > Ah, I missed that possibility. But is that actually something that
> > > people do in practice? Or would it be okay for the verifier to just
> > > assume an unknown value in these cases?
> >
> > Verifier will assume unknown value for the branch that has variable
> > offset. It can't do the same for another branch (with constant offset)
> > because it might not yet have encountered branch with variable offset.
> > But either way, you were proposing to rewrite instruction and inline
> > read constant, and I don't think it's possible because of this.
>
> Ah, I see what you mean. That sucks. I guess that means that to fix
> this up properly in such edgecases, we'd have to, for each memory
> read, keep track of all the values that we want to hardcode for it,
> and then generate branches in the unlikely case that the instruction
> was reached on paths that expect different values?

I guess, though that sounds extreme and extremely unlikely. I'd say
the better way would be to implement immutable BPF maps from the time
they are created. E.g., at the time of creating map, you specify extra
flag BPF_F_IMMUTABLE and specify pointer to a blob of memory with
key/value pairs in it.
