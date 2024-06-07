Return-Path: <bpf+bounces-31596-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D934090082E
	for <lists+bpf@lfdr.de>; Fri,  7 Jun 2024 17:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A1C228EAC0
	for <lists+bpf@lfdr.de>; Fri,  7 Jun 2024 15:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FCE19B3ED;
	Fri,  7 Jun 2024 15:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T2ioaF9D"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3EE198E86;
	Fri,  7 Jun 2024 15:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717772564; cv=none; b=riZn6eTB1VpnXQ3WBmrSq60jBHb4XUPiKAMAwRCdFr595zNHQjKzixE9Lkjsm0zZI5QIBXVZHKAK2D4estMfnssEn0h3Oug1O0/k0G2yBW0FympjFK7SLu8nUKVAJdcPu6csBItmZu8TDGdsV5VMBGh6Iq45TuolniOemhYq3yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717772564; c=relaxed/simple;
	bh=fa8ueD0GQwlyRQ5ETF58gyHuhw7GXljvBVj2+DD63Vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZbhKL8F4YN1s2ZWj6U7ysbhRJ7nO3JCPPQ7Sbhp8WcIxvJ5JmADz5Oyd0+0eJUp3dROK/H881+8UHM/hi+6SqF87oubMzWxwj0SYn8uhhhv8Kux1XTRoJxN+ZI43Z9GAwSJyapx+SWzYQlMsVJHwYAR5oOrhNlVAaAf7XTFyz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=T2ioaF9D; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bLVL8IMkIlvG10TPYUYNLSCq2gOhZEVJHk0jnDyW34M=; b=T2ioaF9DFQhSj/AcCjykCsH7Lr
	A9HBD7mnZB1sbbH597HzkgI9jdeuQOMvVU61AC346f8GlBVejRdUNR+CuxeHGSaZ8cUOJ0i+l1Y7R
	J2NR96ohzwygnVPkfmmymRtFVXhopZhfexkdL+UWlKkLtYF6hEG0qSdsEcNUCN8O7GF7Bvh5L3fNP
	CDrwJts1waRWeI3mX8ZkJ97lklbfh9621n6zgTeCauANfm/+kXRb5KpBA8dsgdxoMsyGLYbVblS7i
	wJLg2rBmw3SCMW8keHnMyQnFo/SjK5zBMK6nyXD47g2NXfrmki4wHPPAZXjZyWukqg3hFuSGS5ZeN
	J/tBlD9A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFb6v-00000006Kui-1FWX;
	Fri, 07 Jun 2024 15:02:33 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DBD4C3002A6; Fri,  7 Jun 2024 17:02:28 +0200 (CEST)
Date: Fri, 7 Jun 2024 17:02:28 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Zheng Yejian <zhengyejian1@huawei.com>
Cc: rostedt@goodmis.org, mcgrof@kernel.org, mhiramat@kernel.org,
	mark.rutland@arm.com, mathieu.desnoyers@efficios.com,
	jpoimboe@kernel.org, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [RFC PATCH] ftrace: Skip __fentry__ location of overridden weak
 functions
Message-ID: <20240607150228.GR8774@noisy.programming.kicks-ass.net>
References: <20240607115211.734845-1-zhengyejian1@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607115211.734845-1-zhengyejian1@huawei.com>

On Fri, Jun 07, 2024 at 07:52:11PM +0800, Zheng Yejian wrote:
> ftrace_location() was changed to not only return the __fentry__ location
> when called for the __fentry__ location, but also when called for the
> sym+0 location after commit aebfd12521d9 ("x86/ibt,ftrace: Search for
> __fentry__ location"). That is, if sym+0 location is not __fentry__,
> ftrace_location() would find one over the entire size of the sym.
> 
> However, there is case that more than one __fentry__ exist in the sym
> range (described below) and ftrace_location() would find wrong __fentry__
> location by binary searching, which would cause its users like livepatch/
> kprobe/bpf to not work properly on this sym!
> 
> The case is that, based on current compiler behavior, suppose:
>  - function A is followed by weak function B1 in same binary file;
>  - weak function B1 is overridden by function B2;
> Then in the final binary file:
>  - symbol B1 will be removed from symbol table while its instructions are
>    not removed;
>  - __fentry__ of B1 will be still in __mcount_loc table;
>  - function size of A is computed by substracting the symbol address of
>    A from its next symbol address (see kallsyms_lookup_size_offset()),
>    but because symbol info of B1 is removed, the next symbol of A is
>    originally the next symbol of B1. See following example, function
>    sizeof A will be (symbol_address_C - symbol_address_A):
> 
>      symbol_address_A
>      symbol_address_B1 (Not in symbol table)
>      symbol_address_C
> 
> The weak function issue has been discovered in commit b39181f7c690
> ("ftrace: Add FTRACE_MCOUNT_MAX_OFFSET to avoid adding weak function")
> but it didn't resolve the issue in ftrace_location().
> 
> There may be following resolutions:

Oh gawd, sodding weak functions again.

I would suggest changing scipts/kallsyms.c to emit readily identifiable
symbol names for all the weak junk, eg:

  __weak_junk_NNNNN

That instantly fixes the immediate problem and Steve's horrid hack can
go away.

Additionally, I would add a boot up pass that would INT3 fill all such
functions and remove/invalidate all
static_call/static_jump/fentry/alternative entry that is inside of them.


