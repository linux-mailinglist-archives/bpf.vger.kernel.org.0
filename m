Return-Path: <bpf+bounces-47782-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1E9A00005
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 21:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3FD71883D3A
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 20:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFE21B85CA;
	Thu,  2 Jan 2025 20:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XyuKYCsp"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6029C187346;
	Thu,  2 Jan 2025 20:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735849939; cv=none; b=WceHksDaEee6BAwwoNaATghflmXV0Rp2uLQRos8odCVgN+gsWPkkj6bHDG2A4vPZ6b49XuHUnW0efzrOTDhyXQbdn23GBg70yRo+6jVmBA53KLSFsIyhpOI82tEzks0htk45SW5am6ov5Vn+UwBj4/NtIeph0c6pMMjOq25o3s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735849939; c=relaxed/simple;
	bh=Sm9iame8tVpt4wrVW/Q9ivf/8KyhylgNk3j3RxS7MXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gglHCSJ1ffRmw3TEXUAX6Osw90aRmzAbSyC4XCFkjffHPG5G1bixnXgRl6qyKHwb+Ck7Eqg/jyfsQZHtj7HwDozpQGckLzKka4ATpbcLfgbQbhxCdBtKNmySCiRFwEeLtTUUL4ttCaypVR46co8qG52pYCf1eIFkxtj4lXx8rpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XyuKYCsp; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pq7jl0w3hIYEiqplpJ1UfOfFWVRZ+ZFmcyVGbmOZPgw=; b=XyuKYCspmsUu8ngk/EaP0p+A2q
	EGRw+++K/4N563Rj3EF6TtzwZtiQk4GZhl4ODyp/Jn4+xmbiYVIsRI4HioYZsLhTmbPD5+pS+kQq/
	IlLMYJn3ao/6ycWR7NwTaA8zopRXm0fObHyn0t21nGCSsoS+4571uQDav/0Yrz3klvU1TLdKWKPjz
	nlnwHfrnOK0a8Tx6vRdDwZ6/jFvqqFGBvzXb6S2KtcX13JOpnaLyxCidYLSUhoxzs4zy834nWHxfr
	E+kVTOfKYSPbf7SjDH4qCm8bphJSUgwTIWbusyp7mJLXORCoFjl2JT9eRBUd35F2/Kuph0Lr74w4i
	e6xrs3+w==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tTRrN-00000008FCa-1AIS;
	Thu, 02 Jan 2025 20:32:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D159A3005D6; Thu,  2 Jan 2025 21:32:00 +0100 (CET)
Date: Thu, 2 Jan 2025 21:32:00 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org, bpf <bpf@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Zheng Yejian <zhengyejian1@huawei.com>,
	Martin Kelly <martin.kelly@crowdstrike.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 14/14] scripts/sorttable: ftrace: Do not add weak
 functions to available_filter_functions
Message-ID: <20250102203200.GE7274@noisy.programming.kicks-ass.net>
References: <20250102185845.928488650@goodmis.org>
 <20250102190105.506164167@goodmis.org>
 <20250102194814.GA7274@noisy.programming.kicks-ass.net>
 <20250102145501.3e821c56@gandalf.local.home>
 <20250102150356.1372a947@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250102150356.1372a947@gandalf.local.home>

On Thu, Jan 02, 2025 at 03:03:56PM -0500, Steven Rostedt wrote:

> Maybe I misunderstood you, if you are not talking about kallsyms, but for
> static calls or anything else that references weak functions.
> 
> The reference is not a problem I'm trying to address. The problem with
> mcount_loc, is that it is used to create the ftrace_table that is exposed
> to user space, and I can't remove entries once they are added.
> 
> To set filter functions you echo names into set_ftrace_filter. If you want
> to enabled 5000 filters, that can take over a minute complete. That's
> because echoing in names to set_ftrace_filter is an O(n^2) operation. It
> has to search every address, call kallsyms on the address then compare it
> to every function passed in. If you have 40,000 functions total, and pass
> in 5,000 functions, that's 40,000 * 5,000 compares!

I'm pretty sure kallsyms has an option to use tree lookups, which would
make it ~ 16*5000.

> Since tooling is what does add these large number of filters, a shortcut
> was added. If a number written into set_ftrace_filter, it doesn't do a
> kallsyms lookup, it will enable the nth function in
> available_filter_functions. This turns into a O(1) operation.
> 
> libtracefs() will read the available_filter_functions, figure out what to
> enable from that, and then write the indexes of all the functions it wants
> to enable. This is a much faster operation then echoing the names one at a
> time.
> 
> This is where the weak functions becomes an issue. If I just ignore them,
> and do not add a place holder in the mcount section. Then the index will be
> off, and will break.
> 
> When the issue first came about, I simply ignored the weak functions, but
> then my libtracefs self tests started to fail.
> 
> So yes, this is just fixing mcount_loc, but I believe it's the only one
> that has a user interface issue.

This is quite the insane interface -- but whatever. I still feel
strongly you should fix kallsyms so that we can all deal more sanely
with the weak crap.

