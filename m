Return-Path: <bpf+bounces-28428-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 415F48B96C9
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 10:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 727C21C20C64
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 08:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EB2524B8;
	Thu,  2 May 2024 08:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bWiyhUzR"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B21246B9F;
	Thu,  2 May 2024 08:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714639697; cv=none; b=FAxvPM+lB7KJE1lAMduMbxWlNffY+ruO9hmVhjK3nDdWdIKj5Axkg5vq/uazCTSJL/OVpbkfud8E6/bt2cxeAw8s6SsQ+ZUOkRm8D3UH+PRF61fVTNg0pgAYeQqhN+uLcviSeQyjkVHckzkNnSB2tzUZoO/JgsaDvxP7dvZcBOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714639697; c=relaxed/simple;
	bh=JqJzSWAyxv660cl8Xg3dl36539iExCzhOiU0kDqZifM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DD7rcU/8KKu95xvE4Ux/4/TJW7w2z/dvNOHBHIxDosVhfsOsrJVK9RQJKeN4JYeJ7iGHV7V1/ZayjxrPY1blHG9OvIMr9RJXvNjWokgWe+4vHR4+xQwtnNmO1Z3qXmoTUdDNQsu+C01GTEtSQqiqqUebIDu/pFnpQiXFPdkF0RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bWiyhUzR; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JqJzSWAyxv660cl8Xg3dl36539iExCzhOiU0kDqZifM=; b=bWiyhUzRQbpbgjOo+W4broAbo2
	G91JxNSItgZbGmnb1iRg5zA2iP8Xlymrp8U30sGC7228zTwwQgL8OCCWz7Pq35US3CErfleGP3HJL
	I9Dh8vGwsNMuSUTN/62nvAAks9gk6YUiGZjChfH7hwxP2dQLRfr/xJMbsVKIeRq2/YnQkkoXC22ee
	dTcaDjRo5cUF1b+i9RKZ1IJYIumBr4tEXDMqKGzNGQd/5OnJW3zi3uliezBHM5kaXdiSA2yAKDp0I
	Yhbq9gGf9bI+2gJ7bQ4r7cPnZCYG4ljbIYmUmdlLyN/RZ895KCB65CDyeSf8uvQ6AsY3s4nBH+ecl
	AKAlPd4w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2S6j-00000001HfQ-0PqL;
	Thu, 02 May 2024 08:48:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BF6D830057A; Thu,  2 May 2024 10:48:00 +0200 (CEST)
Date: Thu, 2 May 2024 10:48:00 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
	joshdon@google.com, brho@google.com, pjt@google.com,
	derkling@google.com, haoluo@google.com, dvernet@meta.com,
	dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com,
	changwoo@igalia.com, himadrics@inria.fr, memxor@gmail.com,
	andrea.righi@canonical.com, joel@joelfernandes.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCHSET v6] sched: Implement BPF extensible scheduler class
Message-ID: <20240502084800.GY30852@noisy.programming.kicks-ass.net>
References: <20240501151312.635565-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501151312.635565-1-tj@kernel.org>



Can you please put your efforts and the touted Google collaboration in
fixing the existing cgroup mess?

