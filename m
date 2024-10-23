Return-Path: <bpf+bounces-42950-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 561F59AD4DF
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 21:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11E2F284041
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 19:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8202F1D0E2B;
	Wed, 23 Oct 2024 19:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hPd4OOmc"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B5913BC11;
	Wed, 23 Oct 2024 19:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729711885; cv=none; b=gaEHxIcZt4YPGA6iSien83t8xEqwy8XLKg/PL+p4SL3O4ft0JKwXP3fHbd5/vJ6/dJXPgBb9R9K6+osVUQQ1DY44V4yQuo2oPbhaNUsKpkpBwWUppB3xjsLY4sH9HXvMGMO6SvKbB7+LPaGqtZghCqT/CPHFQFeSI0v7g/ZiGuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729711885; c=relaxed/simple;
	bh=wCuinHOJKoeDpl6zmF5NJc/J5sf8jxJNlVE3plACEhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOg544sgu95DPsDd75dKPCkk4H1MWXgiODeHqoJiqjWgfgF8fYnXZPMU6+aA8sU4khelhoFwCMVBnUvsqmg7iEwxKWRjb/nni1DIByk2fRGLWvy4ooz4/RGTMM+x9Yvc0hpCMbSJOzZ/vKducUWOYGCnu+Ah+pTYr5xzX0gd3Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hPd4OOmc; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6dEyxF6LeX0+K3I9i6BrJiYDooNw1Lk8zkNSyIPlzNQ=; b=hPd4OOmcYml5BUcrOL+c5eIN0s
	3JVhe2PTEV4W8jdYHJ/6pT31KumbMQyy2nl9AALxbEcO/QTHRAVnQj7Fso3YshpkYNiMZmFaoUfgn
	4lKMB/b4CXyXL2Q3c6ZM8SpQKTi9KQ22oTw+sU1RWBuMCXuvDp33NfQgS+uCJ62SNAaEEZYIwKXDS
	65oAAhEgwo1Bx4x2nifAm/dQn4iPus325z1Thzn0Ohh7azPJ22IJApmuDQfLt43FDfocxTtxyoDdI
	0FV/bYSINwdOebmOwFZ/7hl7HffP5fbEATZMhMFMUtxm4Elwq0VfeqDqfIjW3uXghW4poB02QxZYZ
	wRI27Ehg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t3h4Z-00000008XFB-3X7B;
	Wed, 23 Oct 2024 19:31:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 766BF30073F; Wed, 23 Oct 2024 21:31:11 +0200 (CEST)
Date: Wed, 23 Oct 2024 21:31:11 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, oleg@redhat.com,
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org,
	willy@infradead.org, surenb@google.com, akpm@linux-foundation.org,
	mjguzik@gmail.com, brauner@kernel.org, jannh@google.com,
	mhocko@kernel.org, vbabka@suse.cz, shakeel.butt@linux.dev,
	hannes@cmpxchg.org, Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com
Subject: Re: [PATCH v3 tip/perf/core 2/4] mm: switch to 64-bit
 mm_lock_seq/vm_lock_seq on 64-bit architectures
Message-ID: <20241023193111.GC11151@noisy.programming.kicks-ass.net>
References: <20241010205644.3831427-1-andrii@kernel.org>
 <20241010205644.3831427-3-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010205644.3831427-3-andrii@kernel.org>

On Thu, Oct 10, 2024 at 01:56:42PM -0700, Andrii Nakryiko wrote:
> To increase mm->mm_lock_seq robustness, switch it from int to long, so
> that it's a 64-bit counter on 64-bit systems and we can stop worrying
> about it wrapping around in just ~4 billion iterations. Same goes for
> VMA's matching vm_lock_seq, which is derived from mm_lock_seq.
> 
> I didn't use __u64 outright to keep 32-bit architectures unaffected, but
> if it seems important enough, I have nothing against using __u64.

(__uXX are the uapi types)

> 
> Suggested-by: Jann Horn <jannh@google.com>

Jann, do you see problems with the normal seqcount being unsigned (int)?
I suppose especially for preemptible seqcounts it might already be
entirely feasible to wrap them?

Doing u64 is tricky but not impossible, it would require something like
we do for GUP_GET_PXX_LOW_HIGH. OTOH, I don't think we really care about
32bit enough to bother.

