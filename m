Return-Path: <bpf+bounces-69634-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05005B9C65B
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 00:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43B141BC2CF7
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 22:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F313228935A;
	Wed, 24 Sep 2025 22:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+j8Igtw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727981552FD;
	Wed, 24 Sep 2025 22:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758754721; cv=none; b=Zhx2dlJZ3Wo8ri8AS1ASnmTk/AqD4BWOY6hX1HxiiLwE4YqOQglRMTB09wBGGBo3Dm3SiIkuzdanJjxeewGaL4byBdqIoUR53VZNDsUXOb+35SvueTDat+DFyac2vjSpyXa9zf3qcc/RVipGkAmVY2m2GB4nwtuBbl21oOLMZ3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758754721; c=relaxed/simple;
	bh=1PFTGUbdKZPcpSN8dMqwgrwhqjrq0ISJsbgNf6fGWNA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=jjdK7p+mjIWUJ6JdR6HsECF2BIO8iKa28vklJh/QVSBak5WI5JZyd93+OB/ciuz0ykhPOkQrLuC1QHHD19E4UxcFMBp4rMBQH/XpIUk2hRgQL1PI3blZn2S+HrAiliHRIqkMAU2fsuAcRWLuc1yrgdmQ/OE+/WVZzJnoWfWSJ0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+j8Igtw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6838C4CEE7;
	Wed, 24 Sep 2025 22:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758754721;
	bh=1PFTGUbdKZPcpSN8dMqwgrwhqjrq0ISJsbgNf6fGWNA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D+j8IgtwA5RLL3SXYsn4xGqEarw1ISAJv+wAkgEETdm4C7Jr2orx10NMPP/TReBYD
	 7luBkZqSt+aAjvCLjfZz/vJHlmZmVEEKABBJJg3S6C671Z8IQ3taOXgGtTvZB2BZzX
	 VM/CGCeQLJ6x2p/RPPtGfVmCpSbP2NvJ3vR8NnBJ0RnMnSDFZ3C9erHhn5uuSpQl2M
	 uakzOosPHP/LHgTym921LmYYak8jFus691mflKw0dQRSZwPKtPg5ITLPeOTItaTgRp
	 5RkZnR2Q256+52bmnSNz1Ffg0S2ewM5IJY0bwaZf/6aWyq12xCFWLSKZm+UYRajz/h
	 yYFMKLlycMJ3Q==
Date: Thu, 25 Sep 2025 07:58:34 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Steven Rostedt
 <rostedt@kernel.org>, Menglong Dong <menglong8.dong@gmail.com>,
 jolsa@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 kees@kernel.org, samitolvanen@google.com, rppt@kernel.org, luto@kernel.org,
 ast@kernel.org, andrii@kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH] tracing: fgraph: Protect return handler from recursion
 loop
Message-Id: <20250925075834.6f8f8b318e8f1e9d89b1f772@kernel.org>
In-Reply-To: <20250921185203.561676ad@batman.local.home>
References: <20250918120939.1706585-1-dongml2@chinatelecom.cn>
	<175828305637.117978.4183947592750468265.stgit@devnote2>
	<20250919112746.09fa02c7@gandalf.local.home>
	<20250921130519.d1bf9ba2713bd9cb8a175983@kernel.org>
	<20250921185203.561676ad@batman.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 21 Sep 2025 18:52:03 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sun, 21 Sep 2025 13:05:19 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> >  
> > > The reason I would say not to have the warn on, is because we don't have a
> > > warn on for recursion happening at the entry handler. Because this now is
> > > exposed by fprobe allowing different routines to be called at exit than
> > > what is used in entry, it can easily be triggered.  
> > 
> > At the entry, if it detect recursion, it exits soon. But here we have to
> > process stack unwind to get the return address. This recursion_trylock()
> > is to mark this is in the critical section, not detect it.
> 
> Ah, because the first instance of the exit callback sets the recursion
> bit. This will cause recursed entry calls to detect the recursion bit
> and return without setting the exit handler to be called.
> 
> That is, by setting the recursion bit in the exit handler, it will cause
> a recursion in entry to fail before the exit is called again.
> 
> I'd like to update the comment:
> 
> +	bit = ftrace_test_recursion_trylock(trace.func, ret);
> +	/*
> +	 * This must be succeeded because the entry handler returns before
> +	 * modifying the return address if it is nested. Anyway, we need to
> +	 * avoid calling user callbacks if it is nested.
> +	 */
> +	if (WARN_ON_ONCE(bit < 0))
> +		goto out;
> +
> 
> to:
> 
> 	/*
> 	 * Setting the recursion bit here will cause the graph entry to
> 	 * detect recursion before the exit handle will. If the ext
> 	 * handler detects recursion, something went wrong.
> 	 */
> 	if (WARN_ON_ONCE(bit < 0))

OK, let me update it.

Thank you,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

