Return-Path: <bpf+bounces-50946-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E8FA2E85B
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 10:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7D8E188BC93
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 09:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1D91C5D56;
	Mon, 10 Feb 2025 09:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kFGMe+BG"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6B52E628;
	Mon, 10 Feb 2025 09:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739181376; cv=none; b=vCm1V2gCW9RDn+ufvjGi/XdN/ECP4wPnkV7fxGnw9Yg4tmYir5BPJNXUX+V9IcSINtMPTL03px9R9p+v4v0knc49fxrbNqPB4DNH0X7Wrv7E/NzpIF39F95uzlkFXC37657MfdZm7bf6NCgapPygzMxFR5fkyCabOZTAVKX5LKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739181376; c=relaxed/simple;
	bh=W+4OL3hfjrzmZ1Z9dPP9D+fRq55/N6iNlw7pEZVDRDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XOp6g6D4um+DwP5yF0GuJh0Wj7EmIMjgS2sf/OfpMF00KVQayT/ErXh5jOFMQQnncRFxAqqT2o/QIn8IijO5pqIxkX6sfQk/PI+1ESgnQywGVw3EHgbbA0dlAy8DTMU8PnpQECaYR2xM79FYXMpJCXKKBKqggXNabURAbWE7TdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kFGMe+BG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lda57PQrvabV7TRnU6VjJDmDMF10QGZVMZAT4AjoPmg=; b=kFGMe+BGbho/98khdsaOK+1haQ
	aDKn1Q73vWV+mCxc73fbgI4pIK2ksy++4trCtS6msTI3rq9EhmVJ90UUtUkic8c+GFkK3jpxVULkm
	/xelkbA4A4SPebWm3p4UKr0hfPtdES2uV8grGuugejHBkQtu0WyocjRCVPl6cOG4/vGmSfyw0DsU1
	zZsrVCmsYG4Y7L2PUhSVTS5MLUs64L8cal4QUR3zE2JkiK3RlXVSseIi27TibAUDeuXmjGQ++9pzq
	CchN03CoaftrmZdZqVjfY9yHlms+ejn7IJTDwIrOkVQ2FvmKD5SQ+iw344+KfNttNJXEgE3cyVC65
	gnTFSmEA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1thQWN-0000000FTvf-2hEk;
	Mon, 10 Feb 2025 09:56:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3D42F300318; Mon, 10 Feb 2025 10:56:07 +0100 (CET)
Date: Mon, 10 Feb 2025 10:56:07 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	Barret Rhoden <brho@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Will Deacon <will@kernel.org>, Waiman Long <llong@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
	Josh Don <joshdon@google.com>, Dohyun Kim <dohyunkim@google.com>,
	linux-arm-kernel@lists.infradead.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next v2 07/26] rqspinlock: Add support for timeouts
Message-ID: <20250210095607.GH10324@noisy.programming.kicks-ass.net>
References: <20250206105435.2159977-1-memxor@gmail.com>
 <20250206105435.2159977-8-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206105435.2159977-8-memxor@gmail.com>

On Thu, Feb 06, 2025 at 02:54:15AM -0800, Kumar Kartikeya Dwivedi wrote:
> @@ -68,6 +71,44 @@
>  
>  #include "mcs_spinlock.h"
>  
> +struct rqspinlock_timeout {
> +	u64 timeout_end;
> +	u64 duration;
> +	u16 spin;
> +};
> +
> +static noinline int check_timeout(struct rqspinlock_timeout *ts)
> +{
> +	u64 time = ktime_get_mono_fast_ns();

This is only sane if you have a TSC clocksource. If you ever manage to
hit the HPET fallback, you're *really* sad.

> +
> +	if (!ts->timeout_end) {
> +		ts->timeout_end = time + ts->duration;
> +		return 0;
> +	}
> +
> +	if (time > ts->timeout_end)
> +		return -ETIMEDOUT;
> +
> +	return 0;
> +}
> +
> +#define RES_CHECK_TIMEOUT(ts, ret)                    \
> +	({                                            \
> +		if (!(ts).spin++)                     \
> +			(ret) = check_timeout(&(ts)); \
> +		(ret);                                \
> +	})

