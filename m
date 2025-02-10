Return-Path: <bpf+bounces-50952-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83407A2E93F
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 11:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E01A216294B
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 10:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660881E0DD8;
	Mon, 10 Feb 2025 10:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R9a2Zk49"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CEB1E2007;
	Mon, 10 Feb 2025 10:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739182907; cv=none; b=otPUMhr0gPfc05ufuSf3Way2DSuvfZj1ek+t9S20Gus4itn9eLHH5u5WJ6AtHHkfdAiIb6Pz6M/PyX+SE1Al/KJ/aHUPjV+JX5bthWsnQnsAvFNIs6K4/v1AJc3LZgTUJxARrFGtYAews7QE6I4my0M8hbKWoPRQr9o5EgbDPh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739182907; c=relaxed/simple;
	bh=3BWQMgQHm4rlwamztaxiQSXl3k+wHsmUmwyrgkwM5bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YuelaDQvHPezAJwgKWqID7Dsy8K70Fb6NpBkuh3bYxQKNILHOwRdAcTh7+j2kU82QRDpm8sTn2Twmts8p2HoKINhr9TmQ4dd/bEMsDJ1i9YZujDZObAnostJR81iRxF4EfPtwXTGNzkSqHGgxh5DUUlpY+h9O3LLF7zSSZDUUXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=R9a2Zk49; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3ZCJTrlnqZRstCYuWmdLHJ1sJ7rg+hreFOoAqi6oKWw=; b=R9a2Zk49wDwCrF7oXbqmjwi84Y
	74PVnMGbyIq00P2+lrS7iHzwvqcpF4kkSmy1DiPoC76wmesBdUNsSfHztSEHsUn9ipP8b/settCAS
	R+NmSZK7265WMXyO9sp6lBVbegpkGDvnQP/zuh8n90aPl4FWOzptxp80+OGiD6N+0vK3sSeO2Adq7
	YqGJwnTjC2sDmW+7d7oSZQjjucmFiMtxZLVgUb8F0827FVYypBAeNi3Jot5fZexItcCePkSaIRSOm
	vrWE2NF+N+oyoPpdgcMC7gtkm21Fr78+E8alpL5NZC+RDs4peCsTu+mgchzTrrWhyKbQ851RgN/Rr
	cVaLAl1g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1thQv6-0000000Fbw1-2xNm;
	Mon, 10 Feb 2025 10:21:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A3E4C300318; Mon, 10 Feb 2025 11:21:39 +0100 (CET)
Date: Mon, 10 Feb 2025 11:21:39 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Will Deacon <will@kernel.org>, Waiman Long <llong@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
	Barret Rhoden <brho@google.com>, Josh Don <joshdon@google.com>,
	Dohyun Kim <dohyunkim@google.com>,
	linux-arm-kernel@lists.infradead.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next v2 11/26] rqspinlock: Add deadlock detection and
 recovery
Message-ID: <20250210102139.GJ10324@noisy.programming.kicks-ass.net>
References: <20250206105435.2159977-1-memxor@gmail.com>
 <20250206105435.2159977-12-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206105435.2159977-12-memxor@gmail.com>

On Thu, Feb 06, 2025 at 02:54:19AM -0800, Kumar Kartikeya Dwivedi wrote:
> +#define RES_NR_HELD 32
> +
> +struct rqspinlock_held {
> +	int cnt;
> +	void *locks[RES_NR_HELD];
> +};

That cnt field makes the whole thing overflow a cacheline boundary.
Making it 31 makes it fit again.

