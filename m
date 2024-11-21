Return-Path: <bpf+bounces-45379-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4696E9D4FC5
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 16:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B7D5284159
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 15:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455271531CB;
	Thu, 21 Nov 2024 15:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i3W6cHcz"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A5328687
	for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 15:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732203229; cv=none; b=kgQtrbK3ExaoIAkMzhWHg0Qdz2vo+W6YoCjtIiTJ6xrZU9gFAlhXdFYZxdhQ8gNgSVajroPEReyyFPYNpNCMaZuqdsI/kCeXY7dox4W5nkUiYGzpZ001imjJUTOEwaAngiqQ35FVa8ljNjkDaz0CuceIinjxizFjzvh5CYmRoIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732203229; c=relaxed/simple;
	bh=ERdNmGcyd6AZrmPF2szVswpz9H59VeJ7vDPFvPHzXDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZhRzDJy0GsB6GbIGtRJlxYSoPW9xBVd2oJUKiMeSPPtzzlKiJfaIO3MUuaT7dgsokGfEbeeQVbK0oKHBLLpNFGUoQVkvbB3LK99gVvfty4bOlRifhZifjXCtNbAow47yjHdX7BbZe9pz871VVb2rcC9e7aZHgdEiGVagOIyn4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=i3W6cHcz; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+zR524Tfj2aoQsJieN/ro7G3f5lXPpJtIlcJbnqYJw4=; b=i3W6cHczj/KRIdQ559Y8SBa6TZ
	owMOidxvKjmKpJH7y6lE0ZVlxHgBoXR/JlKrVoNjqNhIG58udqT3zXzyoG2IS1HDHa8XhNQTtXjRx
	gMj+iEc+LsHO+IH+RSwCCRkfcnRsfxKz1JB2FrW/BWiVCSadpuhGfguZtaNbPJDS3POB5gMTimOMd
	hX4JiWKfx693zPagawRrE/c0mch6Z2f/LKmRH4y9kVQX0EsHO0DO3gPU40hwCUT7ly7pPAqcrHzHG
	Qx6WqcwnhFxdJ7vJ5Jfvno91E37oLBM0w+8gByycZwVDoh42gJz/Slz1DpJ9t89O0g4qCy4SnSboz
	ZWl9sYAA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tE9BW-00000000aw1-3Jvs;
	Thu, 21 Nov 2024 15:33:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 339A330068B; Thu, 21 Nov 2024 16:33:34 +0100 (CET)
Date: Thu, 21 Nov 2024 16:33:34 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Vadim Fedorenko <vadfed@meta.com>, Borislav Petkov <bp@alien8.de>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yonghong Song <yonghong.song@linux.dev>,
	Mykola Lysenko <mykolal@fb.com>, x86@kernel.org,
	bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>
Subject: Re: [PATCH bpf-next v8 1/4] bpf: add bpf_get_cpu_time_counter kfunc
Message-ID: <20241121153334.GN39245@noisy.programming.kicks-ass.net>
References: <20241121000814.3821326-1-vadfed@meta.com>
 <20241121000814.3821326-2-vadfed@meta.com>
 <20241121113202.GG24774@noisy.programming.kicks-ass.net>
 <482d32d5-2caa-4759-b3b1-765678ac42a2@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <482d32d5-2caa-4759-b3b1-765678ac42a2@linux.dev>

On Thu, Nov 21, 2024 at 06:35:39AM -0800, Vadim Fedorenko wrote:
> On 21/11/2024 03:32, Peter Zijlstra wrote:
> > On Wed, Nov 20, 2024 at 04:08:11PM -0800, Vadim Fedorenko wrote:
> > > New kfunc to return ARCH-specific timecounter. For x86 BPF JIT converts
> > > it into rdtsc ordered call. Other architectures will get JIT
> > > implementation too if supported. The fallback is to
> > > __arch_get_hw_counter().
> > 
> > Still not a single word as to *WHY* and what you're going to do with
> > those values.
> > 
> > NAK
> 
> Did you have a chance to read cover letter?

Cover letter is disposable and not retained when applying patches, as
such I rarely read it.

