Return-Path: <bpf+bounces-58386-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F39CDAB96C9
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 09:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E66369E2A02
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 07:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3DD22B5AA;
	Fri, 16 May 2025 07:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6fDJ4Ra"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B1722A819;
	Fri, 16 May 2025 07:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747381681; cv=none; b=WRjjFYWb7rD/zaCw+vPBvOMu3NSQffqp9aBHZBFgBOL28OiL1BlwwIp+ZWHndipXDdVSVayDQdsxSlH1D+Tb8ORYIXcUZgy8TCaR/5UeWC3CoijtAfEcizPd6OMHg14fGcoq4vyITpAzrekucCmOlhVJw/kAQeIE7/gyRXh/lxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747381681; c=relaxed/simple;
	bh=z+ZUZ0mpF6mymO05ycQK6JTZ9bRKFcGp10LLh7ATWIY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sOJcLNeRNP1JVcia6xy5/c/tgpySI2XBxa7dAliawKkOO74GBqVtAZKvrLcdxH42oIjUdsPG3knF1sC7T/o0ZQgFg/5MOyVrHV9MWVNw68kI9EDjN+mT0xWwVjG1Qn3Po3B/4HpsWqtVsfKFS4nH3Hn+hmlpTONGn/ZAy9JsGd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6fDJ4Ra; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso16714665e9.2;
        Fri, 16 May 2025 00:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747381677; x=1747986477; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UGLdzEmCHgfFS2+pk36HdAyakdtVqbuEckYtNgZnWGo=;
        b=U6fDJ4RaiOVVidqH1h2E1M5WuJp5k5WuAYyIG4U1VFgjuya7kn56BS4L0s78GkPCbc
         McQ1jcZGyj3SyP5+MOPXHXI+FHnCutqqrCgNTjMEFWuglyjCpcO0pM7V8Lf0qbMpdpfA
         ZJ4wwAb3xuBqeNHn84sb/HqEWcsloJMZeCDtEuDHId7m5Ste3ElJ04BNYmz358U0KxFp
         g202n1Avk1WT2gZJWcj6VCFM61cmVvPG43UtbFzRMe1Q0JbsIPbHm6d7jNwIi+xM8Skj
         DnvAuBcvzcEfit9Nhpz5MjqXxXX816kf6/ejT0FVj9kghfJOnN0D5kB8n92AfOe/WpGq
         MJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747381677; x=1747986477;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UGLdzEmCHgfFS2+pk36HdAyakdtVqbuEckYtNgZnWGo=;
        b=Q9YaDK6166CB0DckQ144Ve4V+4wddfsh8zLrGd/qlvPPxc0D0bJBWBnHFczhrIlSMv
         hAeXulcskBNq562pDW3wimRGNtJz28MX8jxubXEBu7hUm0ucx6Bqd4ovDK60h/XNX+pk
         zb8NMi7sRRj+1du9aCvic67AKroJOz+1qk1vPt1s/BW7HUrqLefjBa17DQ2s57ZxECcd
         iZ/hHaRyIAPU36ReDVz7zoWWsXrLG7iAV2tEFU6Ubrvk+w3NxhSG0yvle3CZ71TtED5V
         pwSSp54YlWxPUwrh6ukuE6ugIJet4YcK5qzoLrmFfxgPGgxyW1iPQAE3ajSViADF7fUc
         iYfA==
X-Forwarded-Encrypted: i=1; AJvYcCUOc3fkSNodkoNEHavuGok7o4Y5MSon1SGJIcHEMwZuUN9LB+mRSMYVQaQ/X0pmyoQi4ACfqbgcDhm8OsgA@vger.kernel.org, AJvYcCVusUpx5HT5kvxgH1anoy9Pz+Tb3r1UepZqIROi7qJo24qO5WN87Qg+cPX4wXd95nE5/RQ=@vger.kernel.org, AJvYcCVvRmdLYxu8kcSTY2WX2cnv8mgoO9sRQqQR2FqB4elhuNWBUcVyYuk8XwYkeCxqra9XjLDFyucuiWwH8HeeiDjh2wC9@vger.kernel.org
X-Gm-Message-State: AOJu0YwP3/YM59Jqefx08pigtDelit44NeZkfs892TH7ZG36P6mus+wS
	91Cox73fB0rDueYDz7Jpex5i07IET3qTZxYODtgtZNyF3MxMr574AyLP
X-Gm-Gg: ASbGnctZs9/T3dm3+Yaiuekfc3pVrsermzYbJ2HqiXy33WShPdj8ZMSpJ5gTxpf+dCL
	TgIYgt31MRsVbRVGU7ljfTCkzgjWFgjNzXU34PtmZ4vCcSUnv7v5UNuOHZuHUCa02ekZkjDlwNc
	+f5d6o24l1LPLXlZRL38nkPRZ6FNCZ+xuzgu2yrQj95vpIFXJHYJsjMC555wTac3hgxrh9mOCQJ
	QkkokptCinZ3G+ftPZuVJiDhCVO8DE/hOYntotfanvGFQnEb9BSQEv8/NYLV7VErB/Us2P7/nDe
	V6UE2Z6NVS/7kubqtvSz82Lh6wcmHLbMaNIpchrZSECD
X-Google-Smtp-Source: AGHT+IFMl3rs6na9LxeXtWLe/VwxC91HleODaC7nRIIHHmzqKR3Pn4Y0wDfZ93eSaE8iuuILnDayAw==
X-Received: by 2002:a05:600c:8487:b0:43c:e7ae:4bc9 with SMTP id 5b1f17b1804b1-442fefd77c6mr13553045e9.1.1747381677190;
        Fri, 16 May 2025 00:47:57 -0700 (PDT)
Received: from krava ([2a00:102a:401a:bc81:9db7:192e:9f02:9c0c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-443003ab9e2sm7045135e9.7.2025.05.16.00.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 00:47:56 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 16 May 2025 09:47:53 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCHv2 perf/core 08/22] uprobes/x86: Add mapping for optimized
 uprobe trampolines
Message-ID: <aCbtqalKPGMMvxpk@krava>
References: <20250515121121.2332905-1-jolsa@kernel.org>
 <20250515121121.2332905-9-jolsa@kernel.org>
 <CAEf4BzYbZ3f9E8mSwY+oppSwU-Luh=5=GBjLKetVA2TOFT+dWQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYbZ3f9E8mSwY+oppSwU-Luh=5=GBjLKetVA2TOFT+dWQ@mail.gmail.com>

On Thu, May 15, 2025 at 10:22:51AM -0700, Andrii Nakryiko wrote:
> On Thu, May 15, 2025 at 5:13 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding support to add special mapping for user space trampoline with
> > following functions:
> >
> >   uprobe_trampoline_get - find or add uprobe_trampoline
> >   uprobe_trampoline_put - remove or destroy uprobe_trampoline
> >
> > The user space trampoline is exported as arch specific user space special
> > mapping through tramp_mapping, which is initialized in following changes
> > with new uprobe syscall.
> >
> > The uprobe trampoline needs to be callable/reachable from the probed address,
> > so while searching for available address we use is_reachable_by_call function
> > to decide if the uprobe trampoline is callable from the probe address.
> >
> > All uprobe_trampoline objects are stored in uprobes_state object and are
> > cleaned up when the process mm_struct goes down. Adding new arch hooks
> > for that, because this change is x86_64 specific.
> >
> > Locking is provided by callers in following changes.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  arch/x86/kernel/uprobes.c | 115 ++++++++++++++++++++++++++++++++++++++
> >  include/linux/uprobes.h   |   6 ++
> >  kernel/events/uprobes.c   |  10 ++++
> >  kernel/fork.c             |   1 +
> >  4 files changed, 132 insertions(+)
> >
> 
> [...]
> 
> > +static unsigned long find_nearest_page(unsigned long vaddr)
> > +{
> > +       struct vm_unmapped_area_info info = {
> > +               .length     = PAGE_SIZE,
> > +               .align_mask = ~PAGE_MASK,
> > +               .flags      = VM_UNMAPPED_AREA_TOPDOWN,
> > +               .low_limit  = 0,
> 
> would this, technically, allow to allocate memory at NULL (0x0000)
> address? should this start at PAGE_SIZE?

of course I overlooked that, but looks like it's ok because of the
mmap_min_addr, which is used as the actual low limit.. anyway I think
it's better to be explicit, so I'll put the PAGE_SIZE in here

thanks,
jirka

> 
> > +               .high_limit = ULONG_MAX,
> > +       };
> > +       unsigned long limit, call_end = vaddr + 5;
> > +
> > +       if (!check_add_overflow(call_end, INT_MIN, &limit))
> > +               info.low_limit = limit;
> > +       if (!check_add_overflow(call_end, INT_MAX, &limit))
> > +               info.high_limit = limit;
> > +       return vm_unmapped_area(&info);
> > +}
> 
> [...]

