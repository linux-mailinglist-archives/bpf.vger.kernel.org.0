Return-Path: <bpf+bounces-47840-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A566BA008CD
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 12:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7A51162DD5
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 11:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2788F1F9A94;
	Fri,  3 Jan 2025 11:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fzMBsGdj"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BC0145B3F;
	Fri,  3 Jan 2025 11:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735904512; cv=none; b=GLNxk7PrGzqdOXCDHwok7Gm23/Jy6GKm9G65YX3WoMuHoxobqX+nQRI1FqiF1Ia2Knf6J7D1eAascjJ++qIwYuwsawexEF/qEew7bLs9d9n9chgngtalSR/gcuGYb5LVMfmMUWY8jPTMJ4PEYhCL9LMscezuMNkt02NN3zcKLjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735904512; c=relaxed/simple;
	bh=meU45f2zzKKiqML/Xv38bJ3s4W9oZ8/Usw2vMT4vmCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wosx3mJysaOiLn3X38uhQ78xmWkziAys5PJwLBgbxTNvKXi/edvc8WGTyMDvTYIJPlI38fzXDtTPFm6WzawH+Pe/10cDcnI7zDzY1GCy2EMtiXnRx2HP+qQbZuddFy9336aDonCGfarB/SUweM08W36cvf+muZs1qkC6iWJ/j2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fzMBsGdj; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=q+QUVp3X7x9DTNoGCWrtzET+o64puN6h3OneDX7RX6U=; b=fzMBsGdjfJQM16tH/dRjC1WocD
	DQB4scgSVzV4b5ACt4njwJCckyQV90AP0+Tb0ZuxWkbNkrRgwIuBKUIWOXqPyrOCaKjvVNNak9tZ3
	gGQCs2deYd/4bz0S71OZco+zYHLPeE8S2+8swWn215kpbNkGAQazWI+jGd3QyxQaMwqUWQu862YwZ
	1OsdwQ1RrnmNf2+S8eoGckH/5VmgM80Ma/77dB0TUip12g/1QAEwsHIVzylGyKRk+ikBZAQsQOg0w
	uxfOWw1OP0i/SXW/8x8OsI8I20Mh0e7Ea5P6eE0JVDDBlvOnD5CqoI6zi5gjb6tTEk44U4RhCjZul
	pbOwJUFQ==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tTg3h-00000008Nbl-22pD;
	Fri, 03 Jan 2025 11:41:41 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 100013003AF; Fri,  3 Jan 2025 12:41:41 +0100 (CET)
Date: Fri, 3 Jan 2025 12:41:40 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	bpf <bpf@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
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
Message-ID: <20250103114140.GF22934@noisy.programming.kicks-ass.net>
References: <20250102185845.928488650@goodmis.org>
 <20250102190105.506164167@goodmis.org>
 <Z3fFkHCPl_68hN4H@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3fFkHCPl_68hN4H@krava>

On Fri, Jan 03, 2025 at 12:10:08PM +0100, Jiri Olsa wrote:
> On Thu, Jan 02, 2025 at 01:58:59PM -0500, Steven Rostedt wrote:
> > From: Steven Rostedt <rostedt@goodmis.org>
> > 
> > When a function is annotated as "weak" and is overridden, the code is not
> > removed. If it is traced, the fentry/mcount location in the weak function
> > will be referenced by the "__mcount_loc" section. This will then be added
> > to the available_filter_functions list. Since only the address of the
> > functions are listed, to find the name to show, a search of kallsyms is
> > used.
> > 
> > Since kallsyms will return the function by simply finding the function
> > that the address is after but before the next function, an address of a
> > weak function will show up as the function before it. This is because
> > kallsyms does not save names of weak functions. This has caused issues in
> > the past, as now the traced weak function will be listed in
> > available_filter_functions with the name of the function before it.
> > 
> > At best, this will cause the previous function's name to be listed twice.
> > At worse, if the previous function was marked notrace, it will now show up
> > as a function that can be traced. Note that it only shows up that it can
> > be traced but will not be if enabled, which causes confusion.
> > 
> >  https://lore.kernel.org/all/20220412094923.0abe90955e5db486b7bca279@kernel.org/
> > 
> > The commit b39181f7c6907 ("ftrace: Add FTRACE_MCOUNT_MAX_OFFSET to avoid
> > adding weak function") was a workaround to this by checking the function
> > address before printing its name. If the address was too far from the
> > function given by the name then instead of printing the name it would
> > print: __ftrace_invalid_address___<invalid-offset>
> > 
> > The real issue is that these invalid addresses are listed in the ftrace
> > table look up which available_filter_functions is derived from. A place
> > holder must be listed in that file because set_ftrace_filter may take a
> > series of indexes into that file instead of names to be able to do O(1)
> > lookups to enable filtering (many tools use this method).
> > 
> > Even if kallsyms saved the size of the function, it does not remove the
> > need of having these place holders. The real solution is to not add a weak
> > function into the ftrace table in the first place.
> > 
> > To solve this, the sorttable.c code that sorts the mcount regions during
> > the build is modified to take a "nm -S vmlinux" input, sort it, and any
> > function listed in the mcount_loc section that is not within a boundary of
> > the function list given by nm is considered a weak function and is zeroed
> > out. Note, this does not mean they will remain zero when booting as KASLR
> > will still shift those addresses.
> 
> hi,
> fyi this seems to remove several functions from available_filter_functions,
> that bpf relay on.. like update_socket_protocol or bpf_rstat_flush:
> 
> 	__bpf_hook_start();
> 
> 	__weak noinline int update_socket_protocol(int family, int type, int protocol)
> 	{
> 		return protocol;
> 	}
> 
> 	__bpf_hook_end();
> 
> 
> 	[root@qemu-1 tracing]# cat available_filter_functions | grep update_socket_protocol
> 	[root@qemu-1 tracing]# cat /proc/kallsyms | grep update_socket_protocol
> 	ffffffff821d58b0 W __pfx_update_socket_protocol
> 	ffffffff821d58c0 W update_socket_protocol
> 
> not sure why that fits the condition above for removal

Check your build, if update_socket_protocol() is no longer in the symbol
table for your vmlinux.o then the linker deleted the symbol and things
work as advertised.

If its still there, these patches have a wobbly.

