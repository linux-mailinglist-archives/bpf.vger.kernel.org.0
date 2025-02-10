Return-Path: <bpf+bounces-50957-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0268EA2E99B
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 11:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E4511884C2B
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 10:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B956F1DC04A;
	Mon, 10 Feb 2025 10:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dWbXPj0r"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72161C5D58;
	Mon, 10 Feb 2025 10:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739183794; cv=none; b=mpuAlwMWdZ6821y9tfkf8or9SQfOfPAIweitDrmPAn1vECYc65umVkD10myEgGu2dHB6+4rzWVloToYk2A2Xt3pCEWcdRXGtyYjc3ZBOSySUDFlR8lEg3XbaxRJWjzZL9Ozgxkj+0PnISJYSYYm1VyZL4zg9f3EDy61qLvy4FtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739183794; c=relaxed/simple;
	bh=ZqX1PcVIxs8vVNyVm/2C4mPZ1eUvAz/wYsk1sK7l6MU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nDL13HnEOxN3mHA+WTcC6eDWJIdctf2x0ib0mnLNrpkZPDU1v0zv4o2Q3fMTSpqwoBPR2G8+qK+TCJLp8P9WzeNyO8yWn/U/QWYB9LuogAB1h2r70HKkZJmlZ+GS8b4NmJwLAUn9aDbAoiqreaHV07orXiyd6Oc8hbI96GVW8UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dWbXPj0r; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Fbev8gX6zQhqBnk6ZosZ+K90Ne5Pg66SYqcXnm0oea4=; b=dWbXPj0rff9aRR6VmRTPN1tRik
	L79Fdxnnj4Ka8iHhRIx2cVdVUJ0cD6WRlEfeb5/PWFh8q9TewxHDD83iYAuF8VRrex9klbkymLnJS
	9gSUtjC86kFTQfEtBPaNCbI5lCe+UO6e9rAJ3tvFx+5uBYzTq3ugytzzmQvia+qTufeYkxmhrMsiv
	91O+7xYd0PzfBoJx40Igse7KVgucBMrMx4R4QwyyGdijb7ssLaNva4SaIEYUe9FyqthMMJjndY/gN
	ZhsJqpOOLXFBXsf/L3EQqSxDNc0OSUPT3cJ9KzPMzUQi46wzPRlOILE6ZGA9BCmH06Z3Zopx+oh3p
	vQbAySMw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1thR9O-0000000Fcuf-1MQ4;
	Mon, 10 Feb 2025 10:36:26 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BC89B300318; Mon, 10 Feb 2025 11:36:25 +0100 (CET)
Date: Mon, 10 Feb 2025 11:36:25 +0100
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
Message-ID: <20250210103625.GK10324@noisy.programming.kicks-ass.net>
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
> +	/*
> +	 * Find the CPU holding the lock that we want to acquire. If there is a
> +	 * deadlock scenario, we will read a stable set on the remote CPU and
> +	 * find the target. This would be a constant time operation instead of
> +	 * O(NR_CPUS) if we could determine the owning CPU from a lock value, but
> +	 * that requires increasing the size of the lock word.
> +	 */

Is increasing the size of rqspinlock_t really a problem? For the kernel
as a whole there's very little code that really relies on spinlock_t
being u32 (lockref is an example that does care).

And it seems to me this thing might benefit somewhat significantly from
adding this little extra bit.


