Return-Path: <bpf+bounces-78123-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CC6CFEA8B
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 16:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C5F7D30034A8
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 15:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2493537F73D;
	Wed,  7 Jan 2026 15:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R8/Ls6FN"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BE437F72F;
	Wed,  7 Jan 2026 15:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767800649; cv=none; b=Gz3ZqS8pA7S6HDbnuLtwB7lEa7UJ439ecJQViGUWRXA0tsHlTTD5MogaBC2+1jI12hSoPP/pQVsz5oJ8g4SBPkL7e8glP15MdeVCgZDFuLQd2+7aVyTpSBafK2PUCoxFijhpVuwLfG6sBBy2OK/XP0gqJIQRogAs1duUvYeTS8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767800649; c=relaxed/simple;
	bh=BbLcyEIrDbOHeU05/snN426eettS5ViJfANxGihHTP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AKltmgroZGqiIrwGY3V+Mbtb/Le+DrRGZ42ReNcIu6C97mgOHwXeoZgQYZpi9ToFlWSospH7KDbenImue6UrE8+rnwHHT+G/QtVrzcyTI15iMKRYbjxCFAJkCDVlimAx1ATf9FEL2cky6bd9yn+HoNltBpymGRG9dyAHNRxlcNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=R8/Ls6FN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=z3wIbGTqvKpReucdUbctr3AoGZHR+7Wb1hGUtOYukf0=; b=R8/Ls6FN62kI5tFv2DM5x+yRbN
	aaEX8Q3gmTXtRX6AYaauk0BYG2nWamV39wcPNwRwqsMBJfMPH5p5L7y1FuRW1sBw7CkaoDH0m/6VI
	HqeOs0Vx/vH/X6Q+QQ5ozsH0GEY+dZSjVJ0XzVWjggeTrFBnBp9qh3uGZrd28gzmiGQE4EsCgS2lr
	5XCDEe57NMqskREqz0BDj48r4lsBBjmFN+CUHCS+f/XeMlDGQc4yU/3K6MeXIUW8Pm1sayAxOOJOj
	Dv0D+dYLWFV+EQhbKFYS3IybBp/gJOUppQr9Se/KvOcrQB5uEFXvxhuwz79Umttm+SSyZJG6Rg4NE
	JXzGauaQ==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdVhd-0000000Dbhw-24pv;
	Wed, 07 Jan 2026 15:44:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E0F2630057E; Wed, 07 Jan 2026 16:44:04 +0100 (CET)
Date: Wed, 7 Jan 2026 16:44:04 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Rustam Kovhaev <rkovhaev@gmail.com>
Cc: Sami Tolvanen <samitolvanen@google.com>,
	Alexei Starovoitov <ast@kernel.org>, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: kernel crashes in BPF JIT code with kCFI and clang on x86
Message-ID: <20260107154404.GJ3708021@noisy.programming.kicks-ass.net>
References: <20251223034332.GA2008178@nuc10>
 <20260107093639.GC3707891@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107093639.GC3707891@noisy.programming.kicks-ass.net>

On Wed, Jan 07, 2026 at 10:36:39AM +0100, Peter Zijlstra wrote:
> On Mon, Dec 22, 2025 at 07:43:32PM -0800, Rustam Kovhaev wrote:

> > After switching to clang kbuild always generates these huge paddings in my kernel config:
> > rusty@nuc10:~/code/kbuild_rust$ grep -e IBT -e PADDING .config
> > CONFIG_CC_HAS_IBT=y
> > CONFIG_X86_KERNEL_IBT=y
> > CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
> > CONFIG_CC_HAS_ENTRY_PADDING=y
> > CONFIG_FUNCTION_PADDING_CFI=59
> > CONFIG_FUNCTION_PADDING_BYTES=59
> > CONFIG_CALL_PADDING=y
> > CONFIG_FINEIBT=y
> 
> Oh gawd, you have FUNCTION_ALIGNMENT_64B. Yeah, I suppose that wasn't
> tested very well.
> 
> Let me go check all that code.

I replied here:

 https://lkml.kernel.org/r/20260107153603.GI3708021@noisy.programming.kicks-ass.net

but Gmail is fscking useless and figured that reply is spam. Please
consider using a 'real' mail host.

