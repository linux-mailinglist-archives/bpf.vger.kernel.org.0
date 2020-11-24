Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C73922C2405
	for <lists+bpf@lfdr.de>; Tue, 24 Nov 2020 12:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732662AbgKXLVi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Nov 2020 06:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732624AbgKXLVh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Nov 2020 06:21:37 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CF8C0613D6
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2020 03:21:36 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id c198so2097497wmd.0
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2020 03:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AbI6MQXGu5GDrmiZjtzAD97PknkGNEDqUtPe5kdRZa4=;
        b=nkOqYH+DN7Psgvd1yJxlhSSuGarSUBCN8w5/arELzNTi3hUp6Dm0EBNTj4fg+y711l
         zZsOkvNvX7eqthTSk5ttm3XNn6sRF/r5/ieCq+YK9QjQg79F/rt/5ri/ahfHqQtVES8y
         GMK600EOgR+2qKmNWRAT5O3JEHj/mZGcHVrC7d08+X+6AGh4yIv4PtA/XPJU9Xyp6Pk3
         gSedsDDGUwZFF/554kmBV0uvv+xk9hkltn5Bs0npdCved58TR8PCnO9B/Dng2veWCLV2
         dwczwZmx6Pmazl/7k3B4Uc8YwAm2v3VmY3mfz97kr1IPM6Iqrd9d0myc+5dkPnUdKDOq
         8LKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AbI6MQXGu5GDrmiZjtzAD97PknkGNEDqUtPe5kdRZa4=;
        b=WyexNb3qT2uzRIy652zm5InuKelmiWaDgWOYl+5nDTkQLEWaIVphjWLjHJG/vPGViw
         2+N8xOYLxzs3vXl4ZNrNX1CrGaYGwnYfLxLrnwwzxbWxYjQYV22sHZXXMNqGQoji+0L7
         VOZQJB7E6hNrOv7XVgNa7Ge2CmVqC9pZBwhlj/N++7LrE0CL2YEfzsSAQOegelfN0wek
         2hJe83YlpobgjLlA9diLIF2Fn8zn5jSymEe4mrQERKChKaBQEO6DBuZsFSCuhY7g9KF+
         viYXwIDoq+xviTm0x6GhZnVJUU1yn2HWZ1PCxYOFgkXNR0XrYO5Mtd3OmWeOHokoNphy
         qGmg==
X-Gm-Message-State: AOAM531KOd2DkqU9IN4+dGA4XEjH5l5wZymz8y+dBM3H7SgPPyV4IDL+
        7BRW7TlSkckhkyOGtE7crxpUYg==
X-Google-Smtp-Source: ABdhPJw0PQ5UO3ySvs21ETc2XvWRgps6kPnb9egLtjbjGadoQixIQ6BGTDjYfHSdp9RzzX8aOSp0iQ==
X-Received: by 2002:a1c:1b12:: with SMTP id b18mr3969847wmb.119.1606216895325;
        Tue, 24 Nov 2020 03:21:35 -0800 (PST)
Received: from google.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id z11sm3957754wmc.39.2020.11.24.03.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 03:21:34 -0800 (PST)
Date:   Tue, 24 Nov 2020 11:21:30 +0000
From:   Brendan Jackman <jackmanb@google.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>
Subject: Re: [PATCH 3/7] bpf: Rename BPF_XADD and prepare to encode other
 atomics in .imm
Message-ID: <20201124112130.GD1883487@google.com>
References: <20201123173202.1335708-1-jackmanb@google.com>
 <20201123173202.1335708-4-jackmanb@google.com>
 <20201124065004.pdgjfkqvzywb5l2c@ast-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124065004.pdgjfkqvzywb5l2c@ast-mbp>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 23, 2020 at 10:50:04PM -0800, Alexei Starovoitov wrote:
> On Mon, Nov 23, 2020 at 05:31:58PM +0000, Brendan Jackman wrote:
> > A subsequent patch will add additional atomic operations. These new
> > operations will use the same opcode field as the existing XADD, with
> > the immediate discriminating different operations.
> > 
> > In preparation, rename the instruction mode BPF_ATOMIC and start
> > calling the zero immediate BPF_ADD.
> > 
> > This is possible (doesn't break existing valid BPF progs) because the
> > immediate field is currently reserved MBZ and BPF_ADD is zero.
> > 
> > All uses are removed from the tree but the BPF_XADD definition is
> > kept around to avoid breaking builds for people including kernel
> > headers.
> > 
> > Signed-off-by: Brendan Jackman <jackmanb@google.com>
> > ---
> >  Documentation/networking/filter.rst           | 27 +++++++++-------
> >  arch/arm/net/bpf_jit_32.c                     |  7 ++---
> >  arch/arm64/net/bpf_jit_comp.c                 | 16 +++++++---
> >  arch/mips/net/ebpf_jit.c                      | 11 +++++--
> >  arch/powerpc/net/bpf_jit_comp64.c             | 25 ++++++++++++---
> >  arch/riscv/net/bpf_jit_comp32.c               | 20 +++++++++---
> >  arch/riscv/net/bpf_jit_comp64.c               | 16 +++++++---
> >  arch/s390/net/bpf_jit_comp.c                  | 26 +++++++++-------
> >  arch/sparc/net/bpf_jit_comp_64.c              | 14 +++++++--
> >  arch/x86/net/bpf_jit_comp.c                   | 30 +++++++++++-------
> >  arch/x86/net/bpf_jit_comp32.c                 |  6 ++--
> 
> I think this massive rename is not needed.
> BPF_XADD is uapi and won't be removed.
> Updating documentation, samples and tests is probably enough.

Ack, will tone down my agression against BPF_XADD! However the majority
of these changes are to various JITs, which do need to be updated, since
they need to check for nonzero immediate fields. Do you think I should
keep the renames where we're touching the code anyway?
