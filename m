Return-Path: <bpf+bounces-45174-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F38019D2524
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 12:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 987191F22D8C
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 11:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946BA1CB32B;
	Tue, 19 Nov 2024 11:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PyVsuh03"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CF6211C
	for <bpf@vger.kernel.org>; Tue, 19 Nov 2024 11:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732016843; cv=none; b=QQuUCBu+V3BA2r/4VRQTlgE1/JYDTV+WULsJSHweS3XivTBl/1K9SItBy2vhBf1Uqn7mX9d0Ux53TgwrVSGJNtvh0whP2gwmDqNDuJENO1nlWzrj+LU7G+qFUbu9/3jNGKT3HyN5BuHkfxeu39FXf7XVS07hmF5UYAcmmTQvlBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732016843; c=relaxed/simple;
	bh=ul+0cE/NFXaJ2WacMh2cOw45i5xxIgxayk8WiYq8xlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nA4XvTWg5+KtWuJzE5fZ8pgGta8H/guvqJcHSxA76Kz7YXlCE/R8CFdVb6ciF66pbv1tqRolaWj+UAVvv/YY3slHFGmAHF+Dt4hlVoLb60i41SuMNa21fqkq/NFuWUMmloFNqrrvjsxhznQJ/a5ufmccG8ufd4kUWpaVj6rWBrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PyVsuh03; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bS5ioAHFKaFZLl66tiMTlq2gg0Bmy7ETkEBC3fV5p9I=; b=PyVsuh03ZeqnVS/P6UKeGtxzyD
	FhTkqRVTB9bdK6rTsK5lqk7geIacy1qS88JoLQSSbwu+6cTpnNazQ9w+V1eOdXdhoVduJY2zi2Zzb
	B4SI+iPSLuWNBeW0iMxBuEm27QxDNEnMyOqQNvOorpt/uMT3gI+utyQUnFOR2UckdBN8LUuy2WUY1
	bspDtFqEs5gc3fOT75kRbDyQ37Uqm01bWrrfSKVIOFyXYW0lv/2SnfOvNcOXCm7WZSj9iOISPZUoi
	n4rc2Ea9HyLlkSeso8LIKq5LqNnWakuXnPWUKg9qsZVZpACk3ofn4npRxh/D3cCua/tHaFfXvwuFe
	RvDxiXSg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDMhP-00000000L7h-0tON;
	Tue, 19 Nov 2024 11:47:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D00873006AB; Tue, 19 Nov 2024 12:47:14 +0100 (CET)
Date: Tue, 19 Nov 2024 12:47:14 +0100
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
Subject: Re: [PATCH bpf-next v7 4/4] selftests/bpf: add usage example for cpu
 cycles kfuncs
Message-ID: <20241119114714.GD2328@noisy.programming.kicks-ass.net>
References: <20241118185245.1065000-1-vadfed@meta.com>
 <20241118185245.1065000-5-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118185245.1065000-5-vadfed@meta.com>

On Mon, Nov 18, 2024 at 10:52:45AM -0800, Vadim Fedorenko wrote:

> +int bpf_cpu_cycles(void)
> +{
> +	struct bpf_pidns_info pidns;
> +	__u64 start;
> +
> +	start = bpf_get_cpu_cycles();
> +	bpf_get_ns_current_pid_tgid(0, 0, &pidns, sizeof(struct bpf_pidns_info));
> +	cycles = bpf_get_cpu_cycles() - start;
> +	ns = bpf_cpu_cycles_to_ns(cycles);
> +	return 0;
> +}

Oh, the intent is to use that cycles_to_ns() on deltas. That wasn't at
all clear.

Anyway, the above has more problems than just bad naming. TSC is
constant and not affected by DVFS, so depending on the DVFS state of
things your function will return wildly different readings.

Why do you think you need this?

