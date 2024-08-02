Return-Path: <bpf+bounces-36266-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7ED945AF6
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 11:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E9D628457C
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 09:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE591DB44A;
	Fri,  2 Aug 2024 09:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WZqFkjXn"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B578A1DAC7B;
	Fri,  2 Aug 2024 09:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722590739; cv=none; b=uDLI6eAo3pUFnBaaPg1sZXKfvMYSXOX6VaCwhSLTb0dY7gb9xXW/RcKzTboSea5dNsD7zkvQkcV6tviiK1RyPbYh1QtTgOZ08E3rrsYPGmK/2gZd3aY0r9bZP1USBmRD3YnWs/1rXWqhc+LzE8avBjVFD34gOvd9MGSIsjoWD7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722590739; c=relaxed/simple;
	bh=nxi/UpW7TNUIM3qXBJgqkiuIHmBFCuD2w6oSAp6ZKOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDY47xyx/nWhFgxd928J1YfhTRUXzrZAdbW6mG3KUs0+2ynLqeuYRAZY2wo+3VJ9GRz8Qiw9fWvN53mdUUPGyPMGcAQ+mu+HRcJtzduFr0VWpFgE7hOkKPlpz6plhofjv1cw1+FYRmM0UlxaE+ykpv0cAF4bTVpeo6OwafEVxW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WZqFkjXn; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=W+owQCIJsP9RdZSo6sQquy+xzS2ExjPjb12SnDlp3xg=; b=WZqFkjXnMZdvoFRBrWzzTR/Oby
	o+QOXzxKli5Ov/PMsQ3DnH43gnJrp1/KKYQh4jzHRzxKPKomV93Ws16J2brnJZDbASeeeT+sM97gf
	KYFcHP4sVAmcqMWa7N2N2plKgfj8FABwEsGdoz/FORir6QnGIX3iIA54vvGV/sFn2zH5BiqOu/u3Q
	JczxLH2DSeMVBI78vu5scRn4yO6uk8WqZ9aXTwR40PbpEuCYhoQLzR9NIoG8XZ8Tn8r+mNc0slhyw
	ltqWHschHYBwxh9b4zcYNnUj5lz0amUhRh5X+eKXLH+16N5/XGZ80o2fn71Q4cfY7RqGSrW666ZcI
	iKZHOHhQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZoXR-00000005fVu-0GAr;
	Fri, 02 Aug 2024 09:25:31 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4961B30049D; Fri,  2 Aug 2024 11:25:28 +0200 (CEST)
Date: Fri, 2 Aug 2024 11:25:28 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Oleg Nesterov <oleg@redhat.com>, andrii@kernel.org,
	mhiramat@kernel.org, jolsa@kernel.org, rostedt@goodmis.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH v4 0/9] uprobes: misc cleanups/simplifications
Message-ID: <20240802092528.GF39708@noisy.programming.kicks-ass.net>
References: <20240801132638.GA8759@redhat.com>
 <20240801133617.GA39708@noisy.programming.kicks-ass.net>
 <CAEf4BzY-gNWHhjnSh3myb0sStjm0Qjsu6nhFtXEULLvo_E=i5w@mail.gmail.com>
 <CAEf4BzY9diEi2_tHsLxB4Yk-ZAWHT=XJNmagjQtOXc7qShqgrA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzY9diEi2_tHsLxB4Yk-ZAWHT=XJNmagjQtOXc7qShqgrA@mail.gmail.com>

On Thu, Aug 01, 2024 at 02:13:41PM -0700, Andrii Nakryiko wrote:

> Ok, this bisected to:
> 
> 675ad74989c2 ("perf/core: Add aux_pause, aux_resume, aux_start_paused")

Adrian, there are at least two obvious bugs there:

 - aux_action was key's off of PERF_PMU_CAP_AUX_OUTPUT, which is not
   right, that's the capability where events can output to AUX -- aka.
   PEBS-to-PT. It should be PERF_PMU_CAP_ITRACE, which is the
   PT/CoreSight thing.

 - it sets aux_paused unconditionally, which is scribbling in the giant
   union which is overwriting state set by perf_init_event().

But I think there's more problems, we need to do the aux_action
validation after perf_get_aux_event(), we can't know if having those
bits set makes sense before that. This means the perf_event_alloc() site
is wrong in the first place.

I'm going to drop these patches for now. Please rework.

