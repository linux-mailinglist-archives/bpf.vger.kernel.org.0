Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 432F7308296
	for <lists+bpf@lfdr.de>; Fri, 29 Jan 2021 01:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbhA2Anw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jan 2021 19:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbhA2Ans (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jan 2021 19:43:48 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940ADC061573
        for <bpf@vger.kernel.org>; Thu, 28 Jan 2021 16:43:08 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id j11so1709584plt.11
        for <bpf@vger.kernel.org>; Thu, 28 Jan 2021 16:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8ktIxNdx2w90sqVbYPMAHajQwETGXiot4PMElVpsd9o=;
        b=qE2qQiK+ldtPXmJobD9hHP3TpaZH4tJQRH78RczUrERpnRtgl6hCH/mktInG8OoFSa
         rdACgdx0RJ217A5vaBpl8kdbsm4r22R2QZ7Aisi7s5gmDiu22ql5/CmGH5XryBh0KXNb
         KUWjy6qeSxBB24r2uT6/6t58h2xBb5Uyze/pgafdUrPurzRQf9/KUZOUa/CUC2s5VN+y
         0dLbbi9QnQmu8I1tGn+789pLoaj74Sslm62KDYuI0GIBTXFiBqh0+avQWHl00xaCmmTD
         0MZlpQwey1QZCcEdq/Qz+fUgUS39u+V4I0q9iklX9aghQ3k7azvW+4rJNxEXGhbPIwcF
         qUMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8ktIxNdx2w90sqVbYPMAHajQwETGXiot4PMElVpsd9o=;
        b=LwZGiRfuHyQtP63/Gc4j2TKfDu1JzGFIIsXCaUCaKLfA2AFjHBrkXYI7wv/AhqPpta
         QYcp5gC1j9QMf074ZQhQ4P9bE24vIOToUmmrkaHJNzN9q9VrkYswp2Nnovcz05u1CQ+E
         eOe0aF1tf3RUpyulncMZcbg+bIhUbzXUiO+SF8D3lDIVTQSrdz6vp3/2shjIQosLVfLa
         /WouJah+cBO0KBZ3d88yHodZaLiBJ4mzmWM1NduAN7AuRYL7KPKMYDu4GXSEKsBYI9UD
         vIhsvT3s+m3HAzuNvGyhdGvrFJGDa0aeTFnlsnWjJQbZBJUJmLGIt27gBN/QEZbFQUqf
         Fu1w==
X-Gm-Message-State: AOAM532F4l9bgE0CHibbK9oObmAXksooVC/yxWVM1WsN4rDF5IoTJReq
        uqsj60dqsmvOjTMp53Cyn9g=
X-Google-Smtp-Source: ABdhPJzjqnJ+cI8JI2ROmDA/o+6RNNI3tDE0pB9tCxkThz26/RdHw/Dud740p0k7Ce2FICRMo1qUSA==
X-Received: by 2002:a17:90b:b07:: with SMTP id bf7mr1922909pjb.195.1611880988164;
        Thu, 28 Jan 2021 16:43:08 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:8ed])
        by smtp.gmail.com with ESMTPSA id x186sm6761098pfd.57.2021.01.28.16.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 16:43:07 -0800 (PST)
Date:   Thu, 28 Jan 2021 16:43:05 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Jann Horn <jannh@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        kernel-team <kernel-team@fb.com>, X86 ML <x86@kernel.org>,
        KP Singh <kpsingh@kernel.org>
Subject: Re: [PATCH bpf] x86/bpf: handle bpf-program-triggered exceptions
 properly
Message-ID: <20210129004305.cwtt3f4c3kq5qyth@ast-mbp.dhcp.thefacebook.com>
References: <20210126001219.845816-1-yhs@fb.com>
 <CALCETrX157htkCF81zb+5BBo9C_V39YNdt7yXRcFGGw_SRs02Q@mail.gmail.com>
 <92a66173-6512-f1bc-0f9a-530c6c9a1ef0@fb.com>
 <CALCETrVZRiG+qQFrf_7NaCZ9o9f2-aUTgLNJgCzBfsswpG7kTA@mail.gmail.com>
 <20210129001130.3mayw2e44achrnbt@ast-mbp.dhcp.thefacebook.com>
 <CAG48ez0s78q+ujyXb2M9W+EHz7XHZwHJzJzm=Sz8=4XYwgEYUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez0s78q+ujyXb2M9W+EHz7XHZwHJzJzm=Sz8=4XYwgEYUQ@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 29, 2021 at 01:35:16AM +0100, Jann Horn wrote:
> On Fri, Jan 29, 2021 at 1:11 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> > On Thu, Jan 28, 2021 at 03:51:13PM -0800, Andy Lutomirski wrote:
> > > Okay, so I guess you're trying to inline probe_read_kernel().  But
> > > that means you have to inline a valid implementation.  In particular,
> > > you need to check that you're accessing *kernel* memory.  Just like
> >
> > That check is on the verifier side. It only does it for kernel
> > pointers with known types.
> > In a sequnce a->b->c the verifier guarantees that 'a' is valid
> > kernel pointer and it's also !null. Then it guarantees that offsetof(b)
> > points to valid kernel field which is also a pointer.
> > What it doesn't check that b != null, so
> > that users don't have to write silly code with 'if (p)' after every
> > dereference.
> 
> How is that supposed to work? If I e.g. have a pointer to a
> task_struct, and I do something like:
> 
> task->mm->mmap->vm_file->f_inode
> 
> and another thread concurrently mutates the VMA tree and frees the VMA
> that we're traversing here, how can BPF guarantee that
> task->mm->mmap->vm_file is a valid pointer and not whatever garbage we
> read from freed memory?

Please read upthread. Every -> is replaced with probe_kernel_read.
That's what was kprobes were doing for years. That's what bpf was
doing for years.
