Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9851B30843A
	for <lists+bpf@lfdr.de>; Fri, 29 Jan 2021 04:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbhA2D1X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jan 2021 22:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbhA2D1W (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jan 2021 22:27:22 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B012EC061574
        for <bpf@vger.kernel.org>; Thu, 28 Jan 2021 19:26:42 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id i63so5349296pfg.7
        for <bpf@vger.kernel.org>; Thu, 28 Jan 2021 19:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=91M9+kmdlxArp2KRxn234tmAQ4wOnbPB7GL1K5jIWSk=;
        b=G32ateoagToDZUpgAoACq3lWeOuBxr8AGGRt8R3sTTH5MrXREwissrdbB5iGPVoJXl
         kebDaJ3zITi1+hlGLStOSFgBAJgBwVT80GrkHDuJN5J1K26absfQpSt8Fb2AJmJFVCiE
         ml6ehCwJ869Fvq7K2rITS/7XxK3rHsFu5wC+ud2GdJPi6I8484Jxw8n66m67rN1xeNZP
         ZkFZak2fw0DJJwzNwMJjH1v9KWeUEK0acNVQUpcbFNgIe3TfWj2re9yNbPxS1QFT7b/3
         vuu4rc+xfZXCBsrqOAD3X3RqW3oDdhhIoGU/gqW5gv2iWbFkHD4DkxD+dI0GXM3jahLu
         bmTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=91M9+kmdlxArp2KRxn234tmAQ4wOnbPB7GL1K5jIWSk=;
        b=CnUEp2A5DfnhfI10GY8GSwYSK/WDC0IFkTYe18WbDB2pzxAfeqV39IewEEbZsYgNeI
         G9zsMRxLZGPjRWegUq/l/O8EM1S7gvYRYF7b9/kfK58+z2c1Ft2/2nF3yA8eRaAFa7yM
         dhb7GvKSkohDnspITNG3Tv30dWr/pqXB4e6gdfauvjXhsvvf0rMbfRKfl/HINJQxHVgK
         BJEIIRz0+PM5MbZRv6kSeiDhZePtnXIy9VgnSb+Gdh3L++z51QnhkSVAG1sgfT9Sv/Ab
         wgqiDJHESjOy0DXO5iJi1q5mdwVqCv4dpsmnJN0fNyiPN2GZN/7r1hONy9E33kmm4fFg
         XCzw==
X-Gm-Message-State: AOAM5306pG6csGesg8E67uVvVAaNsNJppl8a0la/swr28sB4PMbyoGoC
        oUR7f3LwbvYhgnycptY70K4=
X-Google-Smtp-Source: ABdhPJxkKzgfDQyPJ65ZQyCzJZbCLP2Xbi3vd8I0Sg4ujameNz1La5iWRDshVMqX8/RR5wbQr25LNQ==
X-Received: by 2002:aa7:818f:0:b029:1ae:6a6a:e131 with SMTP id g15-20020aa7818f0000b02901ae6a6ae131mr2377048pfi.38.1611890802246;
        Thu, 28 Jan 2021 19:26:42 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:8ed])
        by smtp.gmail.com with ESMTPSA id y5sm7319302pfq.96.2021.01.28.19.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 19:26:41 -0800 (PST)
Date:   Thu, 28 Jan 2021 19:26:38 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andy Lutomirski <luto@kernel.org>, Yonghong Song <yhs@fb.com>,
        Jann Horn <jannh@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        kernel-team <kernel-team@fb.com>, X86 ML <x86@kernel.org>,
        KP Singh <kpsingh@kernel.org>
Subject: Re: [PATCH bpf] x86/bpf: handle bpf-program-triggered exceptions
 properly
Message-ID: <20210129032638.3jpl3fmu5mlvdj3d@ast-mbp.dhcp.thefacebook.com>
References: <20210129023259.wffchzof4rlw5pvs@ast-mbp.dhcp.thefacebook.com>
 <D8D2B06A-295E-4E13-A176-0D5D7F226E84@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D8D2B06A-295E-4E13-A176-0D5D7F226E84@amacapital.net>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 28, 2021 at 07:09:29PM -0800, Andy Lutomirski wrote:
> 
> 
> > On Jan 28, 2021, at 6:33 PM, Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > 
> > ﻿On Thu, Jan 28, 2021 at 06:18:37PM -0800, Andy Lutomirski wrote:
> >>> On Thu, Jan 28, 2021 at 5:53 PM Alexei Starovoitov
> >>> <alexei.starovoitov@gmail.com> wrote:
> >>> 
> >>> On Thu, Jan 28, 2021 at 05:31:35PM -0800, Andy Lutomirski wrote:
> >>>> 
> >>>> What exactly could the fault code even do to fix this up?  Something like:
> >>>> 
> >>>> if (addr == 0 && SMAP off && error_code says it's kernel mode && we
> >>>> don't have permission to map NULL) {
> >>>>  special care for bpf;
> >>>> }
> >>> 
> >>> right. where 'special care' is checking extable and skipping single
> >>> load instruction.
> >>> 
> >>>> This seems arbitrary and fragile.  And it's not obviously
> >>>> implementable safely without taking locks,
> >>> 
> >>> search_bpf_extables() needs rcu_read_lock() only.
> >>> Not the locks you're talking about.
> >> 
> >> I mean the locks in the if statement.  How am I supposed to tell
> >> whether this fault is a special bpf fault or a normal page fault
> >> without taking a lock to look up the VMA or to do some other hack?
> > 
> > search_bpf_extables() only needs a faulting rip.
> > No need to lookup vma.
> > if (addr == 0 && search_bpf_extables(regs->ip)...
> > is trivial enough and won't penalize page faults in general.
> > These conditions are not going to happen in the normal kernel code.
> 
> The need to make this decision will happen in normal code.
> 
> The page fault code is a critical piece of the kernel. The absolute top priority is correctness.  Then performance for the actual common case, which is a regular page fault against a valid VMA. Everything else is lower priority.
> 
> This means I’m not about to add an if (special bpf insn) before the VMA lookup. And by the time we do the VMA lookup, we have already lost.

what's the difference between bpf prog and kprobe ? Not much from page fault pov.
They both do things that are not normal for the rest of the kernel.

if (kprobe_page_fault())
is handled first by the fault handler.
So there is a precedent to handle special things.

> You could try to play games with pagefault_disable(), but that will have its own problems.
> 
> 
> > The faulting address and faulting ip will precisely identify this situation.
> > There is no guess work.
> 
> If there is a fault on an instruction with an exception handler and the faulting address is a valid user pointer,
> it is absolutely ambiguous whether it’s BPF chasing a NULL pointer or something else following a valid user pointer.

It's not ambiguous. Please take a look at search_bpf_extables.
It's not like the whole bpf program is one special region.
Only certain specific instructions are in extable. That table was dynamically generated by JIT.
Just like kernel module's extables.
bpf helpers are not in the extable. Most of the bpf prog code is not in it either.
