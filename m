Return-Path: <bpf+bounces-45252-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAA89D35E7
	for <lists+bpf@lfdr.de>; Wed, 20 Nov 2024 09:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF9B7B263C4
	for <lists+bpf@lfdr.de>; Wed, 20 Nov 2024 08:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820D7176FB4;
	Wed, 20 Nov 2024 08:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DGUgemkk"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B721779BB
	for <bpf@vger.kernel.org>; Wed, 20 Nov 2024 08:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732092686; cv=none; b=hQ6kPBS3JiH9w6onrKvtRW53JVSiTO7IoCI8/PcVNKivpN+nsNUrrQj58kMucqVueo2oXYuGwHTz+nkYro3ho6stQspc3erzqL8cke8EWSYdpZuq+TbB0yr5WGD5h6ZDs7rmFdqyE561P3zf2qknz1NlZ5odmn+01JDJPUL0D2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732092686; c=relaxed/simple;
	bh=lxlSnZTzCoHQe0Mn5TbP1w2v1GCdj7splVSmLSjAAuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QfmWbIdOPd4WbFSQo2Uw4dvRLVTmwQIcxq9T+bqJ85ym/GLZwnR9HWObplqpm0Ue27ZCcsm0vMaMvKut5TDyuiKAuHemXkP6feCXMd+2JoW5rCZVeeYLw4uA82Ea0GMn/WX/XOMBhxWgxIKRt/2RFcfVW2DyI82hLspvwhrzb1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DGUgemkk; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SRLIWYKS0Zon9tEkIQqfVwayp4fhVFYn3PJ5zdjlhWc=; b=DGUgemkkQKW8oCC1/sAv3XLqJ7
	jwtyVPvbjGccLUcmmZvw6LYB7N4U4750HWdV4LjsXaSmzQ+DOuSFknJB0TdYBHY8n7Iqp9XAM+Xma
	j6jqNaWFViL/0/o1T7KentwGkFoWdRd6heThIZj2tK6Q+tksGUe9jyJT3EM3IbmlLIpBZ6oxuBDXn
	ZhqI/k7W3NHp+GolvZ0kCidk/BVJlHMSIvl1ruhEtn27bHo4CO76fmtUkDfq9XpdxhgkBkIska7rl
	+ZvAPOe55YXUeqQixW3hliCCWy04i92vsqMdtpKt88PtjDGfwGIGBYIlLR9SmBPKVFpWlZYOlChHE
	xh2RlYnQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDgQe-000000052ro-2PYv;
	Wed, 20 Nov 2024 08:51:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 79D543006AB; Wed, 20 Nov 2024 09:51:17 +0100 (CET)
Date: Wed, 20 Nov 2024 09:51:17 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Borislav Petkov <bp@alien8.de>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yonghong Song <yonghong.song@linux.dev>,
	Mykola Lysenko <mykolal@fb.com>, x86@kernel.org,
	bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>
Subject: Re: [PATCH bpf-next v7 4/4] selftests/bpf: add usage example for cpu
 cycles kfuncs
Message-ID: <20241120085117.GC19989@noisy.programming.kicks-ass.net>
References: <20241118185245.1065000-1-vadfed@meta.com>
 <20241118185245.1065000-5-vadfed@meta.com>
 <20241119114714.GD2328@noisy.programming.kicks-ass.net>
 <de9a2138-39ee-46ce-9838-f6d6a4dde747@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de9a2138-39ee-46ce-9838-f6d6a4dde747@linux.dev>

On Tue, Nov 19, 2024 at 06:45:57AM -0800, Vadim Fedorenko wrote:
> On 19/11/2024 03:47, Peter Zijlstra wrote:
> > On Mon, Nov 18, 2024 at 10:52:45AM -0800, Vadim Fedorenko wrote:
> > 
> > > +int bpf_cpu_cycles(void)
> > > +{
> > > +	struct bpf_pidns_info pidns;
> > > +	__u64 start;
> > > +
> > > +	start = bpf_get_cpu_cycles();
> > > +	bpf_get_ns_current_pid_tgid(0, 0, &pidns, sizeof(struct bpf_pidns_info));
> > > +	cycles = bpf_get_cpu_cycles() - start;
> > > +	ns = bpf_cpu_cycles_to_ns(cycles);
> > > +	return 0;
> > > +}
> > 
> > Oh, the intent is to use that cycles_to_ns() on deltas. That wasn't at
> > all clear.
> 
> Yep, that's the main use case, it was discussed in the previous
> versions of the patchset.

Should bloody well be in the changelogs then. As is I'm tempted to NAK
the entire series because there is not a single word on WHY for any of
this.

> > Anyway, the above has more problems than just bad naming. TSC is
> > constant and not affected by DVFS, so depending on the DVFS state of
> > things your function will return wildly different readings.
> 
> Why should I care about DVFS? The use case is to measure the time spent
> in some code. If we replace it with bpf_ktime_get_ns(), it will also be
> affected by DVFS, and it's fine. We will be able to see the difference
> for different DVFS states.

Again, this goes to usage, why do you want this, what are you going to
do with the results?

Run-ro-run numbers will be absolutely useless because of DVFS.

