Return-Path: <bpf+bounces-45360-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E9D9D4BFE
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 12:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A03EB285CC
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 11:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2EB288CC;
	Thu, 21 Nov 2024 11:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IaMjaIe/"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B604716C6A1
	for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 11:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732188732; cv=none; b=l8h2uE/5x9lYlg8snY8tDQHjMgCJupPBb8aCVf8qEWUfcnKYy0LCpVvbL973zdFdq+B+7QfBNBGP7ruIU4ymnhLrJIjWLURq3pVIOJB9uwyIwufDK18X2kStBYF7FC+sh+ro7+N1owiBqmd4g4rFzN2M805F2hJEVtR0J7BwFeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732188732; c=relaxed/simple;
	bh=2lpc/Dad8+OfdZH86z/hXAXDPzJIU4EkCpBANq20P4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GhmBUNWnsIMnu5aeSbuv+sx/OK/z2NlZqmeLuavID2/Bsf4NwY4/l3YV6rqNEe7OWjkzEzhYxDi1nDHKaQAEtFeCF6GN6dWFmusSXcBSLQi/5YQxGkc5/lE58jNxc9HZ1tEKYv+EIL4Kx7v2hnHSj8W0hdokYEx6/ovgiBWu7FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IaMjaIe/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2lpc/Dad8+OfdZH86z/hXAXDPzJIU4EkCpBANq20P4w=; b=IaMjaIe/u0ZCYBfjybFH0HkyTh
	0N6s1jwGFLXzzgxJ147QeBgdLxAwQ4lKAvUndH+3jym5PqR2VeJhFhRPPrPcZnpJOU1TgoPZCpPzH
	9WGvMggrGO29qvo8jTRhoXa2bJoTca26G6EQPhkdfs4WJHWEBw6u6INn6YBtacDQlEzhqWtp/X4GU
	svBaOn42vIuzAkVDzEKES2y2i6F5G5dYNoFeBpuZvS7zyD+ef31DiQbJEUxoeWBFiEnH8ycpJOzzz
	pOZUuR2SKH8ZpB/z99gXEtIA15Gs8bVfIfpsYE+Ozmj6g3XiZUyC71OJZ4UPlz8AQMVZ4qfbwmnh5
	s7PB22Og==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tE5Pm-00000006KBi-1B9l;
	Thu, 21 Nov 2024 11:32:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BE6FD30068B; Thu, 21 Nov 2024 12:32:02 +0100 (CET)
Date: Thu, 21 Nov 2024 12:32:02 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Borislav Petkov <bp@alien8.de>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yonghong Song <yonghong.song@linux.dev>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Mykola Lysenko <mykolal@fb.com>, x86@kernel.org,
	bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>
Subject: Re: [PATCH bpf-next v8 1/4] bpf: add bpf_get_cpu_time_counter kfunc
Message-ID: <20241121113202.GG24774@noisy.programming.kicks-ass.net>
References: <20241121000814.3821326-1-vadfed@meta.com>
 <20241121000814.3821326-2-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121000814.3821326-2-vadfed@meta.com>

On Wed, Nov 20, 2024 at 04:08:11PM -0800, Vadim Fedorenko wrote:
> New kfunc to return ARCH-specific timecounter. For x86 BPF JIT converts
> it into rdtsc ordered call. Other architectures will get JIT
> implementation too if supported. The fallback is to
> __arch_get_hw_counter().

Still not a single word as to *WHY* and what you're going to do with
those values.

NAK

