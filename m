Return-Path: <bpf+bounces-45045-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 083659D0321
	for <lists+bpf@lfdr.de>; Sun, 17 Nov 2024 11:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AE3CB23D06
	for <lists+bpf@lfdr.de>; Sun, 17 Nov 2024 10:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB3B13BAD7;
	Sun, 17 Nov 2024 10:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="biJo/NU9"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AFC1392
	for <bpf@vger.kernel.org>; Sun, 17 Nov 2024 10:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731840879; cv=none; b=mzrdK71dnfaHObM42RkdKy7B+eCo4LXEBT1HBHSEXg3bxgmHu6KYQAUrbk2aqQjJn8W0I7jogQrKIXwGpSFvHHGrGAIykP+qVQjIZmsgdc+mUTffHJPgR+x/WqAS4sgvm27KYfF4CYNWhAQbiSAl6BgpmWnL+6TaFT1ljtDLIqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731840879; c=relaxed/simple;
	bh=Pe/iO81j/gY8AcnuTZXUH7AN5K1YH2xoiEStLjEZeVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BFuiXXSzzYOTiHOk4M/9sH6ad0ESWYf8v28qoWK2/WBmIMizHvbSobOiRVcaVuF2EpDk3QTypGouCcj4DcjOvGTH2FvaP0CmTOOhwEU+o7UCkH/HS6LOyZw920mbD89bF3UePHi2vc99saw+NXOgqXChQXTTTOmL2BUexAQ46jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=biJo/NU9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OCoqRWIGHsL5rtX+IV8/Gk+P9vZjZrxcGz8V37nCfYM=; b=biJo/NU9RX9dHQ6M+BMDgVdWs3
	BYNY1QX5RiZBUXPsA5LIjrh0JMOd8ujD+dtruLrbroRPMcJrmCTlTv04Fcu5ohmEW7CUq2UzdOHTu
	xO87IneWWv/Tsf5KKAfiYm7TdICauytRfIkQueZXfaMpupluGJL8Byls7V/CvgKZiM1KrAaFrE+T+
	KoPMCeOkC7Mzx3z1R9KOVdfIhyrN1LOqJ6cmmfcINDPEsgIUxqtw8ub7amFgYoERSsn1IPQzJMer6
	UqL6mGl5GonvrvW0noc3pLtlPBa2rT2zFgiDzppWaJFztfr6o6MnuVCHT7Gq+6TVekqg0YiWiMn3Z
	fR61FVeg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tCcv7-00000001vS7-0o9t;
	Sun, 17 Nov 2024 10:54:23 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B4A733006B7; Sun, 17 Nov 2024 11:54:21 +0100 (CET)
Date: Sun, 17 Nov 2024 11:54:21 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Hou Tao <houtao1@huawei.com>,
	Johannes Weiner <hannes@cmpxchg.org>, shakeel.butt@linux.dev,
	Michal Hocko <mhocko@suse.com>, Tejun Heo <tj@kernel.org>,
	linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 1/2] mm, bpf: Introduce __GFP_TRYLOCK for
 opportunistic page allocation
Message-ID: <20241117105421.GB27667@noisy.programming.kicks-ass.net>
References: <20241116014854.55141-1-alexei.starovoitov@gmail.com>
 <20241116194202.GR22801@noisy.programming.kicks-ass.net>
 <CAADnVQLOyY=Jvibq-hnv6dpXy+hAJFWojyHh7wuEiMn-itMvaw@mail.gmail.com>
 <CAADnVQLA9CkUtcEyjvrTCPZfMWdDXGRzr1O-GD58XM6xjfLTJg@mail.gmail.com>
 <CAADnVQJm64vyeXehTVRbyFqHuuPQWgD-iBYqCChjQE+tHTbKGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQJm64vyeXehTVRbyFqHuuPQWgD-iBYqCChjQE+tHTbKGA@mail.gmail.com>

On Sat, Nov 16, 2024 at 01:41:41PM -0800, Alexei Starovoitov wrote:

> > The maze of ifdef-s beat me :(
> > It doesn't increment in PREEMPT_RCU.
> > Need an additional check then. hmm.
> 
> Like:
> if (preemptible() && !rcu_preempt_depth())
>   return alloc_pages_node_noprof(nid, GFP_NOWAIT | __GFP_ZERO, 0);
> 
> Not pretty, but should do.

Yeah, I suppose that should work. Thanks!


