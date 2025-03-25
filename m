Return-Path: <bpf+bounces-54680-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 621F7A701C4
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 14:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 632C18412CD
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 13:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E92C265CD8;
	Tue, 25 Mar 2025 12:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wRc3RSU7"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DB625BAC4
	for <bpf@vger.kernel.org>; Tue, 25 Mar 2025 12:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742907339; cv=none; b=ERjgxFnUuWDoNYRlQgHQpRxGq6KBEgPew2TiiseRwy2P4jewqnVLzzZzcBd1kUCdl7Gn+IWOv5E3WZonPP17YrvrSzN4UJc6VGziVv69dVxYuIyQQ8x3BMUcyOufmFgft5GlNQGR5PcYDx4LV6I3SrEXmA96hcOR6Trq3YkHNJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742907339; c=relaxed/simple;
	bh=oJNkCde7HTKoGxxpdmV5pQbOB+HxCCMFH8BtG1adrrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dciqM1PSPDsQpJiMGj7k98QUgy9xJpGg6dyM4RfrWiTYpygcnMyqHS34JEBSdh1WLdserLatmSVodEsIBTkBu5zhikaG7U3LxgBVxNLxvKAMFrs0cBsZcLBZcIIosbluiFB3Olf3KbvRpFXplVhhE328Hre56YbDF1eqKJ06u0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wRc3RSU7; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZN5BBGesynuQfxBuKQRCBaycZbe+FrZapkonjpabc6s=; b=wRc3RSU7r+slchPE6y/d28p7BE
	EkGat4wXxvEQeIjrxF100t5ogdqGj8HW1XaHKVzGz2qlMbfV22zEWrEi6f6kox6KWOXIi3n7XK1lx
	/h7jllPX9zL4C9Oez3w17BPTDwJNsGXVGtLl/ep0/7+VmHwKaJXrfwvS/obyuNyBaWi/Xq5rTU7I1
	Yve/znpZ7Lw7RlBRHMF/eTVLqxfmTD285mpv0N+qpfQUigzupEojS/Fy6ynHXg2HanchtnZzL26Hh
	0b112GM72mYfbULSsrSv1GmtbbgLd8x/tsNhYyTZtp6QZlkmeaxwssib3DdTlyU44CGIqRHLAQncH
	fIYvLvnw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tx3R9-000000042i4-3KCp;
	Tue, 25 Mar 2025 12:31:19 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 15E913004AF; Tue, 25 Mar 2025 13:31:19 +0100 (CET)
Date: Tue, 25 Mar 2025 13:31:19 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
	bpf@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
	Greg Thelen <gthelen@google.com>,
	Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] x86/alternatives: remove false sharing in
 poke_int3_handler()
Message-ID: <20250325123119.GL36322@noisy.programming.kicks-ass.net>
References: <20250323072511.2353342-1-edumazet@google.com>
 <Z-B_R737uM31m6_K@gmail.com>
 <CANn89i+fmyJ8p=vBpwBy38yhVMCJv8XjrTkrXSUnSGedboCM_Q@mail.gmail.com>
 <Z-EGvjhkg6llyX24@gmail.com>
 <CANn89iL8o0UZTpomaT1oaMxRTBv1YdaXZGwXQn3H0dDO81UyGA@mail.gmail.com>
 <CANn89iKwPpV7v=EnK2ac5KjHSef64eyVwUST=q=+oFaqTB95sQ@mail.gmail.com>
 <20250324113304.GB14944@noisy.programming.kicks-ass.net>
 <Z-JsJruueRgLQ8st@gmail.com>
 <20250325103047.GH36322@noisy.programming.kicks-ass.net>
 <Z-KS7H6666PZ3eKv@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-KS7H6666PZ3eKv@gmail.com>

On Tue, Mar 25, 2025 at 12:26:36PM +0100, Ingo Molnar wrote:

> Yeah, so I do know what #BP is, but what the heck disambiguates the two 
> meanings of _bp and why do we have the above jungle of an inconsistent 
> namespace? :-)
> 
> Picking _int3 would neatly solve all of that.

Sure; the most obvious case where BP would make sense, the trap entry
point, we already use int3 so yeah, make it int3 throughout.

