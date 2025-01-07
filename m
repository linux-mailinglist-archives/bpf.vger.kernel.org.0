Return-Path: <bpf+bounces-48125-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C932A04338
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 15:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BF4D1882390
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 14:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EA41F2360;
	Tue,  7 Jan 2025 14:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z6F5kW77"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D5518EAD;
	Tue,  7 Jan 2025 14:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736261528; cv=none; b=uanFeEcSpAW63C2XIdp4UTlO/n6BkBg9vMDsH2BwV79I4j3KqIm3N6OsD7wnj3dLw4L/znzJbQk1b5PGPhgnoJC05mqjl+cejTwsns51MF3t3CUBjqVY+2yFYrGEwNkMhjyMKPCIxySRYtCCnB6k9yzdmiD25kTFZv7TLDEukak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736261528; c=relaxed/simple;
	bh=P9AHTjelzob1NFQ+NFuYwOWiOFYaPHhJiJwKx62rOnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cSDuQg7NMbszDa7IOIoRtCj7Cnjgb85jKJ5RhILnaxKFGxZEWgv8MxIUn7a6WrGAiLi5UiNZQzKdROSHzyKlPI439GiuSH8WxBNlhxhhgfPogDFs0qvq/DGQVYzaIvfGd0DKXbbALVyqhyURdAu7IxqOTeSE/h/ejTovjCfQISk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Z6F5kW77; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mzENbMHxpfdj8AXTykucRYkre5rKLz4IxILX1Fd+7oQ=; b=Z6F5kW77mTXSd6dihEhQYOx8ia
	KcoJWbPwAjh9RYRagusQedto1I6/4A/8gIF/4Lri6IAtVwEemYu1aq8RiDTCNGECoGyHygJB74/KR
	5piSXq0mJGiwnKoWOQ092ZP0T63daJdqCSS01DibQhWyQr8fIFqdyFrXM4epYrwMR3RMtXhVrYohS
	40CeRHL+fYEKm8/0uFqMcQjCMU1q+Y6LT+brHtjiHNsOerMXq3uWw5KCtwwoTvqO0vo9rM1Jh2/bX
	C1Tb5xfNgIKqDrwBA6XT153Z8EBUPEuL0am2OLWnXeBggINqjpBrTzIQTE3lMeAqwmdZ8DrsnsU5v
	YvRePS6Q==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tVAw4-000000099xY-0WQp;
	Tue, 07 Jan 2025 14:52:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BC8AD30057A; Tue,  7 Jan 2025 15:51:59 +0100 (CET)
Date: Tue, 7 Jan 2025 15:51:59 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	Barret Rhoden <brho@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Waiman Long <llong@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
	Josh Don <joshdon@google.com>, Dohyun Kim <dohyunkim@google.com>,
	kernel-team@meta.com
Subject: Re: [PATCH bpf-next v1 08/22] rqspinlock: Protect pending bit owners
 from stalls
Message-ID: <20250107145159.GB23315@noisy.programming.kicks-ass.net>
References: <20250107140004.2732830-1-memxor@gmail.com>
 <20250107140004.2732830-9-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107140004.2732830-9-memxor@gmail.com>

On Tue, Jan 07, 2025 at 05:59:50AM -0800, Kumar Kartikeya Dwivedi wrote:
> +	if (val & _Q_LOCKED_MASK) {
> +		RES_RESET_TIMEOUT(ts);
> +		smp_cond_load_acquire(&lock->locked, !VAL || RES_CHECK_TIMEOUT(ts, ret));
> +	}

Please check how smp_cond_load_acquire() works on ARM64 and then add
some words on how RES_CHECK_TIMEOUT() is still okay.

