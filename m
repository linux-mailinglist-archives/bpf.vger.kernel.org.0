Return-Path: <bpf+bounces-55267-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D89BCA7B1AF
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 23:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D10133B2F10
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 21:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E8818CBFB;
	Thu,  3 Apr 2025 21:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UiQuLG3C"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CCE161320
	for <bpf@vger.kernel.org>; Thu,  3 Apr 2025 21:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743717209; cv=none; b=WWJRMLIpLdH/W7SDjdkf1CfB6EaALIJ5dVX0yNYTG9eYC8I6ILJceaX+cfjyi1biiSfrIN9GaNXCNW/pRaNLnRNh9j4c0VhK5Pyu4P7yrryrCJMfXyPsy3COydPYm6+9q1ltcnnu2M+sf4MIH3AHK3SyV4alO96tfxAKR+6zJmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743717209; c=relaxed/simple;
	bh=xDbe7xG6uC7/xLzkVbi/KMH3m7W/R15mhmk7Hr0LUqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CT2KhlFYHPh9IgrZ1K2dkL2PvN0BKjO46yDjTST+twTt2k20VagrrReTwDQKRrSl4ziCMcL65kKBOyKpq4k+16vZb1/uZt2UjHizueNCKbQ47mqmVONnd7b/2psoqjs1zNHmYnYrw1DMbvaxjgDXBh6AllXN0177CFD65Jqg6oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UiQuLG3C; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 3 Apr 2025 14:53:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743717203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O4guBMfIbd3F2XZ6kM9yTMeZgA4X0tKNbbP6azMXJGU=;
	b=UiQuLG3CvFakiz8eI670didk7PB/xq02yBvMyCdtIHMsqzDdhKqqSgXcWwWzNjWoNOhovN
	43MeRlA9a0dkG6GXz7rRWPBLo/g6bSXSd+8IjUNBXW5cR0dGXRXrsGHTZBxn5XrI5D6icu
	7XSIN5Ms+HdtmzzYSSlwxIzE63mmPVE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Sebastian Sewior <bigeasy@linutronix.de>, 
	Steven Rostedt <rostedt@goodmis.org>, Michal Hocko <mhocko@suse.com>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] locking/local_lock, mm: Replace localtry_ helpers
 with local_trylock_t type
Message-ID: <dfcba7bacqwpwpdttj7y44ltyvdcclx7pibr4l3pwrfbmk6itl@pheighdusebk>
References: <20250401205245.70838-1-alexei.starovoitov@gmail.com>
 <umfukiohyxcxxw5g6ca5g7stq7oonnr3sbvjyjshnbqalzffeq@2nrwqsmwcrug>
 <CAADnVQLHakKsVEbKiENF8eV0fEAtbVbL0b_QbJO2b0dH9r7PSw@mail.gmail.com>
 <78c2d3be-aa8e-4bb7-8883-7f144a06f866@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <78c2d3be-aa8e-4bb7-8883-7f144a06f866@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Thu, Apr 03, 2025 at 11:26:35AM +0200, Vlastimil Babka wrote:
> On 4/2/25 23:40, Alexei Starovoitov wrote:
> > On Wed, Apr 2, 2025 at 1:56 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >>
> >> On Tue, Apr 01, 2025 at 01:52:45PM -0700, Alexei Starovoitov wrote:
> >> > From: Alexei Starovoitov <ast@kernel.org>
> >> >
> >> > Partially revert commit 0aaddfb06882 ("locking/local_lock: Introduce localtry_lock_t").
> >> > Remove localtry_*() helpers, since localtry_lock() name might
> >> > be misinterpreted as "try lock".
> >> >
> >> > Introduce local_trylock[_irqsave]() helpers that only work
> >> > with newly introduced local_trylock_t type.
> >> > Note that attempt to use local_trylock[_irqsave]() with local_lock_t
> >> > will cause compilation failure.
> >> >
> >> > Usage and behavior in !PREEMPT_RT:
> >> >
> >> > local_lock_t lock;                     // sizeof(lock) == 0
> >> > local_lock(&lock);                     // preempt disable
> >> > local_lock_irqsave(&lock, ...);        // irq save
> >> > if (local_trylock_irqsave(&lock, ...)) // compilation error
> >> >
> >> > local_trylock_t lock;                  // sizeof(lock) == 4
> >>
> >> Is there a reason for this 'acquired' to be int? Can it be uint8_t? No
> >> need to change anything here but I plan to change it later to compact as
> >> much as possible within one (or two) cachline for memcg stocks.
> > 
> > I don't see any issue. I can make it u8 right away.
> 
> Are you planning to put the lock near other <64bit sized values in memcg
> stock? Otherwise it will be padded anyway?
> 

Something like following:

struct memcg_stock_pcp {
	local_trylock_t stock_lock;
	uint8_t size;
	uint8_t nr_pages[NR_CACHED];
	struct mem_cgroup *cached[NR_CACHED];
...
}

and then experiment with different values of NR_CACHED which puts all
these fields in 1 or 2 cachelines.

