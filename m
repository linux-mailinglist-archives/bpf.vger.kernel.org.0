Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7249030827B
	for <lists+bpf@lfdr.de>; Fri, 29 Jan 2021 01:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbhA2AhL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jan 2021 19:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbhA2Agc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jan 2021 19:36:32 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080F3C061573
        for <bpf@vger.kernel.org>; Thu, 28 Jan 2021 16:35:46 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id f11so8567710ljm.8
        for <bpf@vger.kernel.org>; Thu, 28 Jan 2021 16:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YVcwPFCBvZCUVf9RXTm7VmIT6xyY6ib1jlEqSV2AeO0=;
        b=krg0O1c/dtsd9ZW4b+u8AoEJyZvUcT8GNXPWr68z3o4MP1Uv5MqrG0bwjQHrzxKEpx
         Zwu+tyxwrL1QlODveXkN8WxDJTdqk0jFGrfafH60ZL1bk40hctcO+rheU2sFeiMXJrCV
         MHch8hlYMrxy3xjgp/WRmyBFCcOFhgKm5JXkBtZHkESnmysE6wYDed8F3ZvD63MExEJ1
         +IZCj4XKbbrkzL2n4J3n8i0o6NdiB/PyKtbI9FA+mcbYREPtdFWLGsuOKI98lYZAwCoN
         7Co3LtEUf0F72s3ZK8SpQ/u3xQAa58FSbpoLcOI4OSRMloUmRT71tGf+79rl2pP3qQed
         VELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YVcwPFCBvZCUVf9RXTm7VmIT6xyY6ib1jlEqSV2AeO0=;
        b=k2OhmNvXdi658Z06YfD58ooBmrFnkIkSrSXnIhiugv2XfBG4RiIiA+c3ol3IsbU3qk
         PJ7/+501kdllEnfQgvHMSgh4XD07H+fztDGYBYYVSDR9WEr7GA/FJxo0zlQKs4PZhpKb
         DD8AZfL9jkTDNw8PuGkwddz920OeHa8HakF7GrkyjP3VpKD5/j7I6G+w4xRNyFssz1D4
         MLmqHEXH8LArT68lPSZdNg3TLNUcWliWq8SsrcDqu5aiouHaMTIQQ4BXbet73lzus4LG
         NgQQIcLC3FwYfdg5UP95UtypWFktXHhIlNSXvnnJ6sGFTysaUglyy+FqfXYgS0RQnFnz
         yq3A==
X-Gm-Message-State: AOAM531lWckex/z8qMxGRJpWTe72AghH3XEA/tr0jfX8WOQKO7/Ii5lT
        FV3qzjhMIrPgLYs7tiDZY61gJmdPx+8z3GMTtE2IEA==
X-Google-Smtp-Source: ABdhPJyDxKzDpSiPdgfUL87qi1DgR5m7Tcr1f1Urhgi5OlXf4h31+jiOd5L0VbveehUak1Z1l+OULrtVjcqRUofL1AY=
X-Received: by 2002:a2e:9b45:: with SMTP id o5mr1048445ljj.448.1611880544192;
 Thu, 28 Jan 2021 16:35:44 -0800 (PST)
MIME-Version: 1.0
References: <20210126001219.845816-1-yhs@fb.com> <CALCETrX157htkCF81zb+5BBo9C_V39YNdt7yXRcFGGw_SRs02Q@mail.gmail.com>
 <92a66173-6512-f1bc-0f9a-530c6c9a1ef0@fb.com> <CALCETrVZRiG+qQFrf_7NaCZ9o9f2-aUTgLNJgCzBfsswpG7kTA@mail.gmail.com>
 <20210129001130.3mayw2e44achrnbt@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20210129001130.3mayw2e44achrnbt@ast-mbp.dhcp.thefacebook.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 29 Jan 2021 01:35:16 +0100
Message-ID: <CAG48ez0s78q+ujyXb2M9W+EHz7XHZwHJzJzm=Sz8=4XYwgEYUQ@mail.gmail.com>
Subject: Re: [PATCH bpf] x86/bpf: handle bpf-program-triggered exceptions properly
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        kernel-team <kernel-team@fb.com>, X86 ML <x86@kernel.org>,
        KP Singh <kpsingh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 29, 2021 at 1:11 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Thu, Jan 28, 2021 at 03:51:13PM -0800, Andy Lutomirski wrote:
> > Okay, so I guess you're trying to inline probe_read_kernel().  But
> > that means you have to inline a valid implementation.  In particular,
> > you need to check that you're accessing *kernel* memory.  Just like
>
> That check is on the verifier side. It only does it for kernel
> pointers with known types.
> In a sequnce a->b->c the verifier guarantees that 'a' is valid
> kernel pointer and it's also !null. Then it guarantees that offsetof(b)
> points to valid kernel field which is also a pointer.
> What it doesn't check that b != null, so
> that users don't have to write silly code with 'if (p)' after every
> dereference.

How is that supposed to work? If I e.g. have a pointer to a
task_struct, and I do something like:

task->mm->mmap->vm_file->f_inode

and another thread concurrently mutates the VMA tree and frees the VMA
that we're traversing here, how can BPF guarantee that
task->mm->mmap->vm_file is a valid pointer and not whatever garbage we
read from freed memory?
