Return-Path: <bpf+bounces-68930-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BAAB8975D
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 14:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDA525A11A8
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 12:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4211E2853;
	Fri, 19 Sep 2025 12:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q8mKJFGj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A9A1B4236;
	Fri, 19 Sep 2025 12:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758285182; cv=none; b=VEvwPDDyyL/XRK6TwUxhnwD5uRuiS4Ggy1Viw3qc+pCYUGDkmyYsIR8ewQS44tx+3cGsUJOdyinGltxA1fhintTgVpg8CAz+3iMiUBNXwoff+kdCD3Cs9TxEBUFAfFgZP9/KW0nHACxBdvj/uR/u+LB0IyF/RvryqM4Ysbx96j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758285182; c=relaxed/simple;
	bh=OeUYaF3sIx2rzEitBeJ0U/Ak9lOUSf7wNKaGWHsQd8E=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=aLa8PaNl7k8RJcy0az07JUjpxomcPyDJVLWzyQYLz5T+u/td0LVmEbphbZPp2wCe/ziyEwdnP6vl4I6nA42gtpsXM2HGDvRQfd+U686NNBhgmzfjxno1hhkVB0pDvTcBSQn2gbDEAFpjWjC+y0AwxW08BilxMaYcHsNTcs2rqcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q8mKJFGj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC48C4CEF0;
	Fri, 19 Sep 2025 12:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758285181;
	bh=OeUYaF3sIx2rzEitBeJ0U/Ak9lOUSf7wNKaGWHsQd8E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q8mKJFGjRL0+kr0AS6/Rk/ttNABBy5QXrhTw8GPBZfcDEJcyza78ldv3rLMsJ9CU4
	 1N6MNbLMDHzIpx9gAhy523M7a1tHT6fjr1d4o8rPqXWX5dpm/veUwXnQeI60iNmixQ
	 mLsTHaP/q+JBZkD5/kQhJldj/hkCNlnljI7W2eXPOyPaG5ixZ7J4TyUKXg8CVDu8XQ
	 58qeFzFAh9xnEf1l8mRt/UdT1IlUU5pujdaKz5mMLQ2xuBTAtzR76HTKcDGskrWG0Y
	 Q1lM0uMZsTlS0FkJVBFitz49tLnBdG+HLKKv8vlbF1086m81GuxEnPCBXOPrtVd14F
	 7eO+nI0sDztBg==
Date: Fri, 19 Sep 2025 21:32:55 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: peterz@infradead.org, jolsa@kernel.org, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, kees@kernel.org, samitolvanen@google.com,
 rppt@kernel.org, luto@kernel.org, ast@kernel.org, andrii@kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] x86/ibt: make is_endbr() notrace
Message-Id: <20250919213255.db643846f6dddfe409f03e55@kernel.org>
In-Reply-To: <5925436.DvuYhMxLoT@7940hx>
References: <20250918120939.1706585-1-dongml2@chinatelecom.cn>
	<20250919175255.f7c2c77fa03665a42b148046@kernel.org>
	<5925436.DvuYhMxLoT@7940hx>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Sep 2025 16:58:57 +0800
Menglong Dong <menglong8.dong@gmail.com> wrote:

> On 2025/9/19 16:52 Masami Hiramatsu <mhiramat@kernel.org> write:
> > On Thu, 18 Sep 2025 20:09:39 +0800
> > Menglong Dong <menglong8.dong@gmail.com> wrote:
> > 
> > > is_endbr() is called in __ftrace_return_to_handler -> fprobe_return ->
> > > kprobe_multi_link_exit_handler -> is_endbr.
> > > 
> > > It is not protected by the "bpf_prog_active", so it can't be traced by
> > > kprobe-multi, which can cause recurring and panic the kernel. Fix it by
> > > make it notrace.
> > 
> > Ah, OK. This is fprobe's issue. fprobe depends on fgraph to check
> > recursion, but fgraph only detects the recursion in the entry handler.
> > Thus it happens in the exit handler, fprobe does not check the recursion.
> > 
> > But since the fprobe provides users to register callback at exit, it
> > should check the recursion in return path too.
> 
> That's a good idea to provide recursion checking for the exit handler,
> which is able to solve this problem too.
> 
> If so, we don't need to check the recursion on the kprobe-multi anymore.
> Do we?

Yes, but *if possible*, please avoid calling such functions from fprobe
callbacks. This just prevents kernel crash from such recursion, but that
means it is not possible to trace such functions.

Thank you,


> 
> Thanks!
> Menglong Dong
> 
> > 
> > Thanks,
> > 
> > -- 
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> 
> 
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

