Return-Path: <bpf+bounces-45347-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFE69D4A0C
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 10:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8624FB21748
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 09:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A531CB9ED;
	Thu, 21 Nov 2024 09:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLaupWNt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C4615C120;
	Thu, 21 Nov 2024 09:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732181623; cv=none; b=fj5cbki7OKyn/Nj4Nr33zwcu3Mk8TqbzubKbjmot2/TdO6C7U3DPpZNSj5yGB7bZAaBiidKIdEsoyiZRmQiVbdIgoDgmvxIvd21jNPhQCgiruKEqfha4U25kK/CESrv3NZgdDnWqaHFPp3xwYMqLrBFf3hMwnNm44/BHRbBP0zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732181623; c=relaxed/simple;
	bh=aSnTwvt7CneRsdTVfomrIM+e7aF5A3zhVBIPd3PyVWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rVW6e+/IPWujpuNVXZOPQhmjjRJKre/QxjcnGJOm3GheUzMNlk+45mt6ik4Bl/AvQpT2jjq44wGq4dILKOkaerBrEPqzPQALORhdexapyeyDF3MpJ4ZqwTftnIuF64Fbm9oybcwg3/Qc5+XoaA4ztz5IPdibppBjdvwroWkYg+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLaupWNt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5A79C4CECC;
	Thu, 21 Nov 2024 09:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732181623;
	bh=aSnTwvt7CneRsdTVfomrIM+e7aF5A3zhVBIPd3PyVWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eLaupWNtlZ6TOc8jKpOtlZ+FxJ4u9TAuH71L94wc+LnOi1vmarIjTIwlu94RGiKpn
	 M1EY4wEFgEDQqn5Yzj54bpCxUSQTX6T8U/AM7QQUxz/H2tgaRoh8eVNQe66yBdRs/F
	 gfWsX0KHCxvbQoRNpE845Z7cQv5PM31O+BM4MREZo6vvewaqLd1ezRgBfTUQXwoiaW
	 X0hA88Lgg+Zre+6W2W9ZGObDdGKGtxUpVLkqXw0vMGxqHbTRKGebXF+S0BtiqmT/cw
	 ayh5Z2SMFS+QbwMocLDrnt34LusBPOVDMzIc4/hymcKJLvFN5eXOxDsJV146daoEl2
	 eIVTyMqG8E+Bg==
Date: Thu, 21 Nov 2024 10:33:33 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
	akpm@linux-foundation.org, oleg@redhat.com, rostedt@goodmis.org,
	mhiramat@kernel.org, bpf@vger.kernel.org,
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
Message-ID: <Zz7-bXrFsC8zJwu3@gmail.com>
References: <20241028010818.2487581-1-andrii@kernel.org>
 <CAEf4BzYPajbgyvcvm7z1EiPgkee1D1r=a8gaqxzd7k13gh9Uzw@mail.gmail.com>
 <CAEf4Bza=pwrZvd+3dz-a7eiAQMk9rwBDO1Kk_iwXSCM70CAARw@mail.gmail.com>
 <CAEf4BzbiZT5mZrQp3EDY688PzAnLV5DrqGQdx6Pzo6oGZ2KCXQ@mail.gmail.com>
 <20241120154323.GA24774@noisy.programming.kicks-ass.net>
 <Zz4IQaF9CCfjS28S@gmail.com>
 <CAEf4BzYR44BgfAjKAvppmyG_hjojBL7XZe75C0qBTPoE7WXzHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYR44BgfAjKAvppmyG_hjojBL7XZe75C0qBTPoE7WXzHg@mail.gmail.com>


* Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> Is this about Liao's siglock patch set? We are at v4 (!) already (see 
> [0]) with Oleg's Acked-by added.

AFAICS you didn't Cc: me to -v3 and -v4 - and while I'll generally see 
those patches too, eventually, there's a delay.

> > Andrii did get some other uprobes scalability work merged in v6.13:
> >
> >     - Switch to RCU Tasks Trace flavor for better performance 
> >     (Andrii Nakryiko)
> >
> >     - Massively increase uretprobe SMP scalability by 
> >       SRCU-protecting the uretprobe lifetime (Andrii Nakryiko)
> >
> > So we've certainly not been ignoring his patches, to the contrary 
> > ...
> 
> Yes, and as I mentioned, this one is a) ready, reviewed, tested and 
> b) complements the other work you mention.

Sorry, but patchsets that didn't even build a few weeks before the 
development window closed are generally pushed further down the 
backlog. Think of this as rate-limiting the risk of potentially broken 
code entering the kernel. You can avoid this problem by doing more 
testing, or by accepting that sometimes one more cycle is needed to get 
your patchsets merged.

> [...] It removes mmap_lock which limits scalability of the rest of 
> the work. Is there some rule that I get to land only two patch sets 
> in a single release?

Your facetous question and the hostile tone of your emails is not 
appreciated.

Me pointing out that two other patchsets of yours got integrated simply 
demonstrates how your original complaint of an 'ignore list' is not 
just unprofessional on its face, but also demonstrably unfair:

> > > > I'm not sure what's going on here, this patch set seems to be 
> > > > in some sort of "ignore list" on Peter's side with no 
> > > > indication on its destiny.

Trying to pressure maintainers over a patchset that recently had build 
failures isn't going to get your patches applied faster.

Thanks,

	Ingo

