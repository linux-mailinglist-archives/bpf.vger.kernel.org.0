Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 341E5226FBF
	for <lists+bpf@lfdr.de>; Mon, 20 Jul 2020 22:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgGTUda (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Jul 2020 16:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbgGTUd3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Jul 2020 16:33:29 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD59DC061794;
        Mon, 20 Jul 2020 13:33:29 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id q17so9221240pls.9;
        Mon, 20 Jul 2020 13:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=woYDQw/fOKCUiUPc84nf3NVJM7d7msUrWkm2YtnbzC0=;
        b=cOgRHO7VfHOlUabiz2nkKRKcD00vwhyfOmhSLKgPdGPNqVaJn+lFjdktYe0iaqvVVz
         i21XXZ3T8VhTyBPY5qEAJDvrMoJgepfvNRgpUNdY1pIlGTxaUAf8zcuh4zEl2Jx8rOHP
         1sQMfY5MHUwgndNf4ggMXT+eqx6TfeH0fR9zwq3ahW0uKgw6UZDxXCkhFPhyhQUF35lQ
         j60P1rkF3rOtgdXr9sRpL1pkQayobCqUn0kGBftPlOv0dHpDu9mR1o/WYxv3sA7yAWRP
         yn+KOiQX8o5zeHZGsjffZBJg3s9wm95hwQmJDSL+6yDYC5fz2XgD40+cF6+//6uKVQuw
         r8Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=woYDQw/fOKCUiUPc84nf3NVJM7d7msUrWkm2YtnbzC0=;
        b=ifkcBxIeOtKQL0ZPc3ZH7PjLMZhmdxcsjHHuzpX9weHkjfQ4qC6XDK1WbdPeyg2lJq
         tneXIXv2R60WGV6lramHAPwuiXEWGC8Qgv8weieIinVqNBqKIOokj28qLLjcdlaqu6mX
         K24tb7FftBOQIEwaTg6yACTu9HQXWwjv9THt+eVmOaumcKu/0Dtx/c8WgF+jC4lQnuBN
         Qpp9JzJrva4Q7nc0ecaT+hBOLj4FNMwzclvE/g3qHcUnEndGd3y3Qlxk04NtcDOnXwce
         kXiADbOloTC4QpXSNrSS204uzB1FaxiNAOyi4j7mAU5s8cSlBSlTi1RLbDZcbkXvXusp
         VTlg==
X-Gm-Message-State: AOAM532058yFIeiyBp6c0vQxbiEt+yWSJyv0kehDVfkOLkbnfvMs671v
        YJ9ZI04SaESCp60STAHYM+ot672Y
X-Google-Smtp-Source: ABdhPJy59lpBL7dnFK4McGN3Y1P0g2OXU3cuaSD/R0MmWCdN/bLw84UwXRZW0NpQFnz5++a77n9hiQ==
X-Received: by 2002:a17:90a:764c:: with SMTP id s12mr1105981pjl.201.1595277209209;
        Mon, 20 Jul 2020 13:33:29 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:e3b])
        by smtp.gmail.com with ESMTPSA id w12sm451664pjb.18.2020.07.20.13.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 13:33:28 -0700 (PDT)
Date:   Mon, 20 Jul 2020 13:33:26 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>
Subject: Re: [PATCH bpf-next] bpf: allow loading instructions from a fd
Message-ID: <20200720203326.z4jtrjv7gmtlzz57@ast-mbp.dhcp.thefacebook.com>
References: <20200713130511.6942-1-mcroce@linux.microsoft.com>
 <20200714173154.i2wxhm4n4ob7sfpd@ast-mbp.dhcp.thefacebook.com>
 <CAFnufp2_vwyCR95Z=Dkd9XXRO8CTQ5NZtNPdJL+1oPRurv-feQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFnufp2_vwyCR95Z=Dkd9XXRO8CTQ5NZtNPdJL+1oPRurv-feQ@mail.gmail.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 16, 2020 at 08:47:36PM +0200, Matteo Croce wrote:
> On Tue, Jul 14, 2020 at 7:31 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Jul 13, 2020 at 03:05:11PM +0200, Matteo Croce wrote:
> > > From: Matteo Croce <mcroce@microsoft.com>
> > >
> > > Allow to load the BPF instructons from a file descriptor,
> > > other than a pointer.
> > >
> > > This is required by the Integrity Subsystem to validate the source of
> > > the instructions.
> > >
> > > In bpf_attr replace 'insns', which is an u64, to a union containing also
> > > the file descriptor as int.
> > > A new BPF_F_LOAD_BY_FD flag tells bpf_prog_load() to load
> > > the instructions from file descriptor and ignore the pointer.
> > >
> > > As BPF files usually are regular ELF files, start reading from the
> > > current file position, so the userspace can skip the ELF header and jump
> > > to the right section.
> >
> > That is not the case at all.
> > Have you looked at amount of work libbpf is doing with elf file before
> > raw instructions become suitable to be loaded by the kernel?
> 
> I see now what bpf_object__relocate() and all the *reloc* functions
> do, so it can't be done this way, I see.
> 
> A malicious BPF file can be as bad as a malicious binary. Let's say I
> want to assert code integrity for BPF files, what could be a viable
> option?
> Perhaps a signature in the object file as we do with modules?

It's a hard problem to solve.
Signing bpf programs was proposed in the past. It may work, but challenging
to implement, since even simplest programs are being modified by the user
space loader before kernel sees them. The signature would have to skip
all such instructions which makes the signature verification 'best effort'.
Some instructions won't be covered by signature (like ld_imm64 that points
to a map).
