Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0DF41A43EC
	for <lists+bpf@lfdr.de>; Fri, 10 Apr 2020 10:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbgDJIrP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Apr 2020 04:47:15 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:38328 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgDJIrP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Apr 2020 04:47:15 -0400
Received: by mail-lj1-f170.google.com with SMTP id v16so1269742ljg.5
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2020 01:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ki8M5lfAB2wJsZmfTgN+keL4yKpqLBe4BMyCiTPBZ5g=;
        b=mZ0s9mw8DXWk/Bz651zbMlVeECyqJZa3Y6T5JUWG1wJB6eaiVMJyILK/RgR/PZsAJt
         P/8LM/T8wCBDSo/UmKtKRUO9SXUDj+EffGajbCTOtW9HC9J5DVCXy0YAk71smwxTC/+0
         +X8x3vtRb0c8jCZv81LnycxvXkS7lEQWYHwHlJ5G2TFoWo72p3YUHXwe2/QDECld9Qel
         /sbKtr6uSBcaMyPP+0y/e2H5El31ou/CHaLpOQaa12YLUX7xlXoUNV5/2G7iIompbijI
         CwRL/cHY7Ge+3/VIlXbwpoXvVxGFMQx1ZZFgIaFnhPkCCx7Ulk1nmA5HjEETcZduyzmd
         dxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ki8M5lfAB2wJsZmfTgN+keL4yKpqLBe4BMyCiTPBZ5g=;
        b=uR1CZmDIEV1NvuoM/WXNycMwkOx6/4UZXALLniObuReXDvJ3dnRhTM1SHf2TMKPEoE
         iiXemKuemE42KgIGmLhzGf07YCX+sQfadTS/iZVQP8Oyd3LD4M5oStyaOI0enLke4Abb
         graT/OspTf9srRmuUMQ6HUI7PC5x1ZcIWG9GAoLLPrZSdlFHcKkHVkcNEDAoadz2sZks
         T4sRpOwm1wcPIdO3iLagHM6rKWJQidiuVTbMAMP0vxwCD28xriaWM2mAV0GD55N9sQe2
         q7dgCvZ+mslLNoYkb7125theUXy/s4LcbX3LsAk4+8uFoWGMXnYAfnOm9GrEMYyLjkpr
         2BhQ==
X-Gm-Message-State: AGi0PuYwbtk3/5Sfy8tr8J8bCV8yE7FwmsjYwhE/j/dPYS2DifEq9vjd
        oD6evnR2IPDgj0fOnd/UQLjuT5TcWjdDKwfJqQqXPg==
X-Google-Smtp-Source: APiQypKhrGfA/R6ND1paE84FDBFeGq0Qjqp++XPD8XPdU6LGbNglcVgff1ljdO951NALbztw+AVY0FxBHz0aAiQ/+b0=
X-Received: by 2002:a2e:9247:: with SMTP id v7mr2248269ljg.215.1586508431741;
 Fri, 10 Apr 2020 01:47:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez2R5nZA91j7cf2Z5o3dOEz0QNZK7cxecjmw0B-ZQ7AjmA@mail.gmail.com>
 <CAEf4Bzb2zcfJt6ujAN8zY_=x7-dFO92mPzkbCE+UMHVDGL7J+Q@mail.gmail.com>
In-Reply-To: <CAEf4Bzb2zcfJt6ujAN8zY_=x7-dFO92mPzkbCE+UMHVDGL7J+Q@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 10 Apr 2020 10:46:45 +0200
Message-ID: <CAG48ez20KjiYjcYzWnnVCyNTMjNFf+YgnwbbF9BUovZxDzsuEw@mail.gmail.com>
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

On Fri, Apr 10, 2020 at 1:33 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> On Wed, Apr 8, 2020 at 12:42 PM Jann Horn <jannh@google.com> wrote:
> >
> > Hi!
> >
> > I saw that BPF allows root to create frozen maps, for which the
> > verifier then assumes that they contain constant values. However, map
> > freezing is pretty wobbly:
> >
> > 1. The syscalls for updating maps from userspace don't seem to lock
> > the map at all.
>
> True, there is a tiny race between freezing and map updates, but I
> don't think it's possible to solve it without taking locks all around
> the place in map update operations.

Yeah. So I think BPF should do exactly that. Or change the userspace
API so that userspace has to say at map creation time "I'll freeze
this map later", and then you only have to do the locking if that flag
is set.

[...]
> > 3. It is assumed that a memory mapping can't be used to write to a
> > page anymore after the mapping has been removed; but actually,
> > userspace can grab references to pages in a VMA and use those
> > references to write to the VMA's pages after the VMA has already been
> > closed. (crasher attached as bpf-constant-data-uffd.c, compile with
> > "gcc -pthread ...")
>
> Please help me understand how that works (assuming we drop
> VM_MAYWRITE, of course). You mmap() as R/W, then munmap(), then
> freeze(). After munmap() refcount of writable pages should drop to
> zero. And mmap'ed address should be invalid and unmapped. I'm missing
> how after munmap() parallel thread still can write to that memory
> page?

The mmap()/munmap() syscalls place references to the pages the kernel
is using in the page tables of the process. Some other syscalls (such
as process_vm_writev()) can read these page table entries, take their
own references on those backing pages, and then continue to access
those pages even after they've been removed from the task's page
tables by munmap(). This works as long as the page table entries don't
have magic marker bits on them that prohibit this, which you get if
you use something like remap_pfn_range() in a loop instead of
remap_vmalloc_range() - but the memory mappings created by that
syscall are weird, and e.g. some syscalls like read() and write()
might sometimes fail if the buffer argument points into such a memory
region.

[...]
> > Is there a reason why the verifier doesn't replace loads from frozen
> > maps with the values stored in those maps? That seems like it would be
> > not only easier to secure, but additionally more performant.
>
> Verifier doesn't always know exact offset at which program is going to
> read read-only map contents. So something like this works:
>
> const volatile long arr[256];
>
> int x = rand() % 256;
> int y = arr[x];
>
> In this case verifier doesn't really know the value of y, so it can't
> be inlined. Then you can have code in which in one branch register is
> loaded with known value, but in another branch same register gets some
> value at random offset. Constant tracking is code path-sensitive,
> while instructions are shared between different code paths. Unless I'm
> missing what you are proposing :)

Ah, I missed that possibility. But is that actually something that
people do in practice? Or would it be okay for the verifier to just
assume an unknown value in these cases?
