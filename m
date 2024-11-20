Return-Path: <bpf+bounces-45277-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A4C9D3F46
	for <lists+bpf@lfdr.de>; Wed, 20 Nov 2024 16:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC559283BB5
	for <lists+bpf@lfdr.de>; Wed, 20 Nov 2024 15:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0B513BAF1;
	Wed, 20 Nov 2024 15:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ftFqNAsy"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB4B24B28;
	Wed, 20 Nov 2024 15:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732117425; cv=none; b=sGVrpNSIaq37gfLlZPceUZWMSrBsTL8XLF7lFW6dr0rp04qPNM2vHzyT/JeOjqbv1hIsFxqAvPqGprJKSxYHavpWt9OYnj3X8IDz1QTyyv/iLUdNzPAno1gO0y6FfDA/STEFHMo/ryAvHE4Gu4g+oSlq9DkQadHpDCDHWCRtSTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732117425; c=relaxed/simple;
	bh=e7V7jnn9ITTjKxWWKQADOEeB6JxLUTkHLOQ79Zw0P+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sHsp+IGL3PX4jinTcSeNMr3zmvsy6XHQUPovvkLh6i5XL8lodeDLwX7/JGNeFAjaPuq5345LDzoNd9fMbuBXQ7RRl16FehZfUmsPDgnSuwMBcjW4j1CMpzqYvWQa9m6+qCtKDhXtc4zsFekHscEYyf3zBsvStI7vkUdFkBzk9Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ftFqNAsy; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Cd6TfnmOE6LRZo3IDk/gFLGhVF3QEUhrot1e84JPawk=; b=ftFqNAsyvqvs6A8M8OupuxyTTD
	ez/RcpJE1zFTSKALnTuX8h2Btu8ZvvctWShBLQd5OzZFMUOcXdRW7LGJ6hh2L8OA+trxk3+BIHt2x
	GBJtPEpoxwgaVuR4T8R1s/i6JFW4CsG3jc4MCq+yHW7/C+Krede1FpVyQ91f9gvIVqZERCVGw+ewB
	8telGia2Fz22piCOk+362lQxtANUrWEstBnlfOiQHyoV86zsqZaedeODrG/gQGVY77frlGrIXdACz
	oROxr+84Cl0lIOgDZJPYE8+r3eMp4mJgxlY3307wcTL7uyf1OR9nB1JGBMEeNYwMPua02OB9advtw
	qw2osoHg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDmrS-00000005PRf-2fU4;
	Wed, 20 Nov 2024 15:43:23 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7C3C4300446; Wed, 20 Nov 2024 16:43:23 +0100 (CET)
Date: Wed, 20 Nov 2024 16:43:23 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@kernel.org>, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org, akpm@linux-foundation.org, oleg@redhat.com,
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org,
	willy@infradead.org, surenb@google.com, mjguzik@gmail.com,
	brauner@kernel.org, jannh@google.com, mhocko@kernel.org,
	Andrii Nakryiko <andrii@kernel.org>, vbabka@suse.cz,
	shakeel.butt@linux.dev, hannes@cmpxchg.org, Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com, david@redhat.com, arnd@arndb.de,
	richard.weiyang@gmail.com, zhangpeng.00@bytedance.com,
	linmiaohe@huawei.com, viro@zeniv.linux.org.uk, hca@linux.ibm.com,
	Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Kernel Team <kernel-team@meta.com>
Subject: Re: [PATCH v4 tip/perf/core 0/4] uprobes,mm: speculative lockless
 VMA-to-uprobe lookup
Message-ID: <20241120154323.GA24774@noisy.programming.kicks-ass.net>
References: <20241028010818.2487581-1-andrii@kernel.org>
 <CAEf4BzYPajbgyvcvm7z1EiPgkee1D1r=a8gaqxzd7k13gh9Uzw@mail.gmail.com>
 <CAEf4Bza=pwrZvd+3dz-a7eiAQMk9rwBDO1Kk_iwXSCM70CAARw@mail.gmail.com>
 <CAEf4BzbiZT5mZrQp3EDY688PzAnLV5DrqGQdx6Pzo6oGZ2KCXQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbiZT5mZrQp3EDY688PzAnLV5DrqGQdx6Pzo6oGZ2KCXQ@mail.gmail.com>

On Wed, Nov 20, 2024 at 07:40:15AM -0800, Andrii Nakryiko wrote:
> Linus,
> 
> I'm not sure what's going on here, this patch set seems to be in some
> sort of "ignore list" on Peter's side with no indication on its
> destiny.

*sigh* it is not, but my inbox is like drinking from a firehose :/

