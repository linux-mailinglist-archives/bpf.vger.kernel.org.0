Return-Path: <bpf+bounces-46850-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D41D9F0E1B
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 14:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F8CD188EC26
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 13:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B551E1A28;
	Fri, 13 Dec 2024 13:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O8+bhyVM"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3231E049F;
	Fri, 13 Dec 2024 13:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734098090; cv=none; b=i+OkDymydN4fMiMvGr9guFLEJG+gts6ZDPLoNJb5n+ZK1ZVlYWPOC/+kBTy3ygkoE9bHnxVdr4TlgUsdjQ2fAYP6SkvI7uJKKVBqdCJBUHy2U0Ab66FyaSS7AZ0qGa5Ixq0sUjVNlu4u65JwxcuYbv1KCyia176WifFjeOitvys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734098090; c=relaxed/simple;
	bh=fvyMI/H8q6jI/7TMK/Z7fKWCjdWV7cicS5M53FBJDkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/we75hTtUIeQ4kEXRkHtnPGJUEstcqfYfo1j4ow1FaZzS/ZkNtliIbLxYB9btXJL32cRFIOfVkL0F5XeDklJ8SvvCnN6YFDg1Crv0ORe6vb4RhXrYiHBz0go5c4DtS8Rx6zwsFNIpp3hOOIkig3NRUubR+chvXej+uMUtcJbXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=O8+bhyVM; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oQZ+CAyfd5mt5S0jyE8HQGYNw+zsdshFiHqeHheuxKA=; b=O8+bhyVMuQKtzCw+7KeDjOMYrW
	9aaoa70aquz2Gny1z7Z64/EzIEf67dobeyU0ORihwCLwdOp0/ZQW6Fv2FTQTFSAoH4czn4spw3hSR
	d2buMF7xlUv1X7IrtFa4+zWI3Bm8E+j5y4tV6iFLlJyyPx3+TznU7ZzQMVuEBUiLxPxQ6KyxaBYXu
	Pa3PUS5kGHp6jmauHIG7qTgYKGPvFRbBnIS3jSHEB1UAthBWf1W+7/TQhfsVOEZP04ViWPHP/G6EK
	CgoODAE9bc272FoVDUVhcJ/X9PwlH3OettcQMp7o8rBDMptewQc9a9wbTVhPQxgiDv7tiVX4Gz754
	Q3GKYDyg==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tM67m-0000000DL0g-2vbD;
	Fri, 13 Dec 2024 13:54:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D02E03004AF; Fri, 13 Dec 2024 14:54:33 +0100 (CET)
Date: Fri, 13 Dec 2024 14:54:33 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 00/13] uprobes: Add support to optimize usdt
 probes on x86_64
Message-ID: <20241213135433.GD35539@noisy.programming.kicks-ass.net>
References: <20241211133403.208920-1-jolsa@kernel.org>
 <20241213105105.GB35539@noisy.programming.kicks-ass.net>
 <Z1wxqhwHbDbA2UHc@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1wxqhwHbDbA2UHc@krava>

On Fri, Dec 13, 2024 at 02:07:54PM +0100, Jiri Olsa wrote:
> On Fri, Dec 13, 2024 at 11:51:05AM +0100, Peter Zijlstra wrote:
> > On Wed, Dec 11, 2024 at 02:33:49PM +0100, Jiri Olsa wrote:
> > > hi,
> > > this patchset adds support to optimize usdt probes on top of 5-byte
> > > nop instruction.
> > > 
> > > The generic approach (optimize all uprobes) is hard due to emulating
> > > possible multiple original instructions and its related issues. The
> > > usdt case, which stores 5-byte nop seems much easier, so starting
> > > with that.
> > > 
> > > The basic idea is to replace breakpoint exception with syscall which
> > > is faster on x86_64. For more details please see changelog of patch 8.
> > 
> > So ideally we'd put a check in the syscall, which verifies it comes from
> > one of our trampolines and reject any and all other usage.
> > 
> > The reason to do this is that we can then delete all this code the
> > moment it becomes irrelevant without having to worry userspace might be
> > 'creative' somewhere.
> 
> yes, we do that already in SYSCALL_DEFINE0(uprobe):
> 
>         /* Allow execution only from uprobe trampolines. */
>         vma = vma_lookup(current->mm, regs->ip);
>         if (!vma || vma->vm_private_data != (void *) &tramp_mapping) {
>                 force_sig(SIGILL);
>                 return -1;
>         }

Ah, right I missed that. Doesn't that need more locking through? The
moment vma_lookup() returns that vma can go bad.

