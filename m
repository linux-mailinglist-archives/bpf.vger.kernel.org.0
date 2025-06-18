Return-Path: <bpf+bounces-60929-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF73ADEE56
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 15:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D7F01BC14D8
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 13:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629982EA46E;
	Wed, 18 Jun 2025 13:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IqNC1wCl"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B83DB672;
	Wed, 18 Jun 2025 13:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750254577; cv=none; b=j1aPO4HAzfJsfJHL/s2l/jtbTXtFlrIXW1Q71WXl6kXzyNvhZnd1hES9xJqTai7ogBtwWokTUZGKe6FF6265H4i+45n3w0rIQ3VzuVCU0Qwx1IuH/MBVOmfWDN8uCjEhfY1liGO+qHQPd4PEtPgMHOChXnHBrsSZLyoWidHUJEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750254577; c=relaxed/simple;
	bh=OwFE1pD1KZbh0gaqp1EA23bjStIvc59+I767Mn156eM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g8R+4kiz6l/Qusp7B1gfGinT3dC46fU4W00Q/W7JFDp6V/ebqCPBml9s1+ZvVCLuBv89gxzRaXi1/xigu5iKWrSz5xvyGtlPUm8FhLlLFZK6ddOyn4fOEdIpGUrMZfd0uSK2Hr+eIQ3GnLSIb8l0r2lhHDetM7czUkIW7ZyCL7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IqNC1wCl; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=C6Bom0krT6ocOdMCSUC5RnAJ/ezmG5rabjTXzGvpnBQ=; b=IqNC1wCliXmTDts9xATzO0fset
	BgSlRE3yZ+44bEg70/ZcgV8P3N0OFYCg22bUDb5EigjckCxmXbHVSdVvmlHv5RarkHsbVTlwna32p
	Z3ukuK/U5P/vLv5R5vBUiY1/flyLS2NZGoKuoLrvBeIE5VEBNyftr0Og3GH1zhdfEZcoA4UpjEanF
	YqXLVU8AiqtMWSScg9EChuL3W+NqyxLufBPce2D2npDM+rwljTKXlaLADnb/hbZjTzhrpMEsAOyTV
	mzci7yYn2zw3EcIIgiNTjlH53mvBXyQ7rC2lHaEUhjv73wrHN63GR7R+FWBivhwWQW8HasXPcwwMq
	+URlofxA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRtAP-00000003ieC-1HWf;
	Wed, 18 Jun 2025 13:49:29 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E5C37307FB7; Wed, 18 Jun 2025 15:49:28 +0200 (CEST)
Date: Wed, 18 Jun 2025 15:49:28 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org, x86@kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrii Nakryiko <andrii@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v10 01/14] unwind_user: Add user space unwinding API
Message-ID: <20250618134928.GL1613376@noisy.programming.kicks-ass.net>
References: <20250611005421.144238328@goodmis.org>
 <20250611010427.923519889@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611010427.923519889@goodmis.org>

On Tue, Jun 10, 2025 at 08:54:22PM -0400, Steven Rostedt wrote:

> +	state->ip = instruction_pointer(regs);
> +	state->sp = user_stack_pointer(regs);
> +	state->fp = frame_pointer(regs);

That user_ thing sticks out like a sore thumb. I realize this is
pre-existing naming, but urgh..

