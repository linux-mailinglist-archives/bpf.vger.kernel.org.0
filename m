Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8473C1A3CE5
	for <lists+bpf@lfdr.de>; Fri, 10 Apr 2020 01:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgDIXdm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Apr 2020 19:33:42 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:38241 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgDIXdm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Apr 2020 19:33:42 -0400
Received: by mail-qv1-f68.google.com with SMTP id p60so237429qva.5
        for <bpf@vger.kernel.org>; Thu, 09 Apr 2020 16:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=npBZAQ8+nNwoz7pY5s9Hr75+OmCxMkNtfXBbfDSyFzE=;
        b=l2XT1720Fua8eq3e3S69qpHwoIOyRVYbIZ236MxSKZX5EG0ynkfOCor5JsNAxNDaA4
         lyIi0e6OEB9c6zfPYccPHDzns96vj0MgEABYa4itwLHvsFGRaYPOo5VqO8loJm4UVwrR
         bKHhZpFOdvYXCjArFRLVh4W9ub77ymnTx7PjQM982CWkDqWbEw1EMJ4Elrp7YP6Fm5p6
         1x7wmAG9ASdfZAdZoY2BFRH3juYyT6DG/qiGWULxRKweqYZoFN4btNG9moOklrlqZze0
         s8Id8KBTbv5nX/Y5g0eEM1RDf0+QmLH5SMULf6VHB517Ooe1JyiygGwORW83Y0K3XMYb
         FXxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=npBZAQ8+nNwoz7pY5s9Hr75+OmCxMkNtfXBbfDSyFzE=;
        b=WhjBV/hTG1P3iiVrVTa8I/6K8BSFoXEFWdWOwZxj67O3bsS1MIEtlUiKpvfO4u/2sO
         lC7NvWVSw1jqOhanalBIhjU06EBHwQ41JFZAQbbjZ7/OEXtq2kTSQamsgQXUFW5AFV3Z
         BgeDUD2IDVh7/PKlyenfi42OJw1F35ZPOlidluWHr71LdJbMX4BJaCo8a8c5KjPuqyFg
         fmiLYkhzi65fE0V+koAJ/fvghSGJRco5tIusZsqrfw15A1gWTjK/BvIDVkNVDAH0KEI5
         DGM+7c52BGbriWWUV82n954rqAF3djdX80nF4rscP5OChSIVD+6dATLxzKrEhoHKNLpB
         ibEg==
X-Gm-Message-State: AGi0PuZ1GEzEYzfGFWS2RqJI5p9hW7P2T1e+JHOgvVC9ZZDB5ODbcbvU
        XtGDDNEfpelJ97ZyQLTqLg9v4WSB6ZmdY6S2DrtOwUQR9KM=
X-Google-Smtp-Source: APiQypJJirlPIHYVlou1U0+Kc/6G4phKRR4YiFxlFzRFCeIBPUhh8m3uShSXWZpur6qdfn42FVTsJumA0hRB5psd/DU=
X-Received: by 2002:a05:6214:6a6:: with SMTP id s6mr2566120qvz.247.1586475221571;
 Thu, 09 Apr 2020 16:33:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez2R5nZA91j7cf2Z5o3dOEz0QNZK7cxecjmw0B-ZQ7AjmA@mail.gmail.com>
In-Reply-To: <CAG48ez2R5nZA91j7cf2Z5o3dOEz0QNZK7cxecjmw0B-ZQ7AjmA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 9 Apr 2020 16:33:30 -0700
Message-ID: <CAEf4Bzb2zcfJt6ujAN8zY_=x7-dFO92mPzkbCE+UMHVDGL7J+Q@mail.gmail.com>
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

On Wed, Apr 8, 2020 at 12:42 PM Jann Horn <jannh@google.com> wrote:
>
> Hi!
>
> I saw that BPF allows root to create frozen maps, for which the
> verifier then assumes that they contain constant values. However, map
> freezing is pretty wobbly:
>
> 1. The syscalls for updating maps from userspace don't seem to lock
> the map at all.

True, there is a tiny race between freezing and map updates, but I
don't think it's possible to solve it without taking locks all around
the place in map update operations.


> 2. BPF doesn't account for the fact that mprotect() can be used to
> arbitrarily flip VM_WRITE on and off as long as VM_MAYWRITE is set.
> (crasher attached as bpf-constant-data-mprotect.c)

Yeah, my bad. I wasn't aware of VM_MAYWRITE. I'll post a fix dropping
VM_MAYWRITE (and VM_MAYEXEC while at that...) for frozen maps. That
should fix bpf-constant-mprotect.c

> 3. It is assumed that a memory mapping can't be used to write to a
> page anymore after the mapping has been removed; but actually,
> userspace can grab references to pages in a VMA and use those
> references to write to the VMA's pages after the VMA has already been
> closed. (crasher attached as bpf-constant-data-uffd.c, compile with
> "gcc -pthread ...")

Please help me understand how that works (assuming we drop
VM_MAYWRITE, of course). You mmap() as R/W, then munmap(), then
freeze(). After munmap() refcount of writable pages should drop to
zero. And mmap'ed address should be invalid and unmapped. I'm missing
how after munmap() parallel thread still can write to that memory
page?

>
> These things are probably not _huge_ concerns for most usecases, since
> you need to be root to hit this stuff anyway - but I think it'd be
> desirable for BPF to actually be memory-safe (and the kernel lockdown
> folks would probably appreciate not having such a glaring hole that
> lets root read/write arbitrary memory).
>
> The third point is particularly hard to solve without adding more
> constraints on the userspace API; I think that tightening up map
> freezing would require ensuring that the map has *never* been mapped
> as writable.

I'm clearly missing how memory can remain mmaped() after single mmap()
+ munmap(), I'd really appreciate if you could elaborate, thanks!

>
> Is there a reason why the verifier doesn't replace loads from frozen
> maps with the values stored in those maps? That seems like it would be
> not only easier to secure, but additionally more performant.

Verifier doesn't always know exact offset at which program is going to
read read-only map contents. So something like this works:

const volatile long arr[256];

int x = rand() % 256;
int y = arr[x];

In this case verifier doesn't really know the value of y, so it can't
be inlined. Then you can have code in which in one branch register is
loaded with known value, but in another branch same register gets some
value at random offset. Constant tracking is code path-sensitive,
while instructions are shared between different code paths. Unless I'm
missing what you are proposing :)
