Return-Path: <bpf+bounces-42944-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8222B9AD470
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 21:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B160D1C21DEA
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 19:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8471B1CEAAD;
	Wed, 23 Oct 2024 19:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SBMLHsEH"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104B614AD20;
	Wed, 23 Oct 2024 19:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729710181; cv=none; b=oKNk+4YlX2RItimmkLuWLY+sbKF4o7oKh0HLIKaMjV2gOcoodMeWgYTKftMBYH6hSKXXOwN52rOyrxFRXH8oDFPSXdGO46HfmzwXhqaJ8Q5lXfjaeLggWn0vlpbcub8rGvIE+F+2ueIJFw3MHg5y0SzB3cV2Md2ikeZq/DHMA0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729710181; c=relaxed/simple;
	bh=PDoEunpivtmDkHdtof8mc0xQNBak0TRvQREGtJWbwVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9l9n+k9Qjy5renxfUNtgNpxmq3JvsyDW8uX87XaTKWg6+HAc4ZfGZbhOSDHDvWuD8iDN/+VK1SUMt7kmD7VRXWSR+n/WrEERqxrOwxiKtOhlHcdqryenYYoLTl990CZ7NtD/WPdbtSlrdNmBTux71/V4fTd7bblbuuYY0lm2PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SBMLHsEH; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=cy23GZhRUgFLT1RLGlJ+GbqizeM20Ndew3cr/vC2tLs=; b=SBMLHsEHxhhf0ar8KzSMn6aotF
	r4QPIPmiHes7w7/hUrZYSrcVoZJ2odDy0RxYAsPGPEo05wX7gZo29VEDq9tkfl1gZOOYNrGHIgNvV
	TtoYU4ozWH3/KNf0Gyjk7mCdfP90veappHaDW5OjdMxE/Z5EIc7w4TYdxQGfQ4BbJUFxJNGpxkhaC
	auqucZVkU8Jl8WJ/06zfCZd77gylKTqm5oBszE5Pq8mSNbM2kOA97R9kBy8rUkoMd+qhh4uALVLRC
	IkbHNvKyWYeVc06x8CFJVlgNgHN6ldv1uzpd1EZGq3nUqmJjIxqGv60FSMf7cxU+DDpTdFf+O0tCn
	XHLEPpHQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t3gcz-00000008Wsk-0r4w;
	Wed, 23 Oct 2024 19:02:41 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8E96430073F; Wed, 23 Oct 2024 21:02:40 +0200 (CEST)
Date: Wed, 23 Oct 2024 21:02:40 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>,
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
	oleg@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org,
	paulmck@kernel.org, willy@infradead.org, akpm@linux-foundation.org,
	mjguzik@gmail.com, brauner@kernel.org, jannh@google.com,
	mhocko@kernel.org, vbabka@suse.cz, hannes@cmpxchg.org,
	Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com
Subject: Re: [PATCH v3 tip/perf/core 2/4] mm: switch to 64-bit
 mm_lock_seq/vm_lock_seq on 64-bit architectures
Message-ID: <20241023190240.GA11151@noisy.programming.kicks-ass.net>
References: <20241010205644.3831427-1-andrii@kernel.org>
 <20241010205644.3831427-3-andrii@kernel.org>
 <55hskn2iz5ixsl6wvupnhx7hkzcvx2u4muswvzi4wuqplmu2uo@rj72ypyeksjy>
 <CAJuCfpFpPvBLgZNxwHuT-kLsvBABWyK9H6tFCmsTCtVpOxET6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpFpPvBLgZNxwHuT-kLsvBABWyK9H6tFCmsTCtVpOxET6Q@mail.gmail.com>

On Wed, Oct 16, 2024 at 07:01:59PM -0700, Suren Baghdasaryan wrote:
> On Sun, Oct 13, 2024 at 12:56 AM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > On Thu, Oct 10, 2024 at 01:56:42PM GMT, Andrii Nakryiko wrote:
> > > To increase mm->mm_lock_seq robustness, switch it from int to long, so
> > > that it's a 64-bit counter on 64-bit systems and we can stop worrying
> > > about it wrapping around in just ~4 billion iterations. Same goes for
> > > VMA's matching vm_lock_seq, which is derived from mm_lock_seq.
> 
> vm_lock_seq does not need to be long but for consistency I guess that
> makes sense. While at it, can you please change these seq counters to
> be unsigned?

Yeah, that. Kees is waging war on signed types that 'overflow'. These
sequence counter thingies are designed to wrap and should very much be
unsigned.

