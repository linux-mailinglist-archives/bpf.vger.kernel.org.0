Return-Path: <bpf+bounces-45359-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3BF9D4BFD
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 12:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 736402826DF
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 11:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAA83C47B;
	Thu, 21 Nov 2024 11:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="erTKTJ3X"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A741CD202
	for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 11:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732188676; cv=none; b=dEdCiOcqkd01P3UhBsNc5g4yLicG9lx/o9RliObV8pDwGqA11ZpwMAthmDIK2TbQ/8HjdoMWpzRxqL9sfyEyubBSZpC9uj812DYB+YpHWykf8kCmreJwMx1tZ7cnohaKN5PsCXGn6rbgCaJ5Z73tsv/QGpsTUHU8fZ+ge7xQB9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732188676; c=relaxed/simple;
	bh=zs8SKII8mMGsvDX3KPlUXSYfC/V4zfVu2hLTYizAESU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WAAEG6vPylplmGg3tXZ+DKgjZWm2xt46yDGddGgjqpXd4mmJS15RRHyleFz/cyXV0kC4efLrcjvgI2CPHU4y7osab5R5aaR5jaQ6jFqJu7inRB10JtfOFkUSOEDiR/tKUyHz9I16nhiQhs9mdaqec22S+DLQxBYSQzxDLP2c7Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=erTKTJ3X; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zs8SKII8mMGsvDX3KPlUXSYfC/V4zfVu2hLTYizAESU=; b=erTKTJ3X8pOVhoVnm7oEg1NYZP
	iFs6UeE4HTZwmvLXmHYMlpt4+OdF3YcweoO1OTiiv4jiy2h9WPsmK+LYVTRxVboHASzhuzI9wLgwt
	3vyoEP9upiSmvO90hdC3Yt8lZJ04ONgq+yuVNjUAJgvAQ5iVau1r5vxSPePnuBPDbzQvVckHKNEh6
	XowukGWxVvzQkVihGk2zzgPDT5MKSKSyNGQqjn/BWbHAqxikY6W8KD4IzXZL2n4QsWvVuLfbpZbm7
	6CAl1DtD/j5DguafdmuNlFdS9hvvIoK9ho/ZUNYXBHnXAF+WXi8+hHYY7fTJirm9aRTWdlBKfkW7s
	ggER41eA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tE5Or-00000000Zk1-19nH;
	Thu, 21 Nov 2024 11:31:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E10C430068B; Thu, 21 Nov 2024 12:31:04 +0100 (CET)
Date: Thu, 21 Nov 2024 12:31:04 +0100
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
Subject: Re: [PATCH bpf-next v8 2/4] bpf: add bpf_cpu_time_counter_to_ns
 helper
Message-ID: <20241121113104.GF24774@noisy.programming.kicks-ass.net>
References: <20241121000814.3821326-1-vadfed@meta.com>
 <20241121000814.3821326-3-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121000814.3821326-3-vadfed@meta.com>

On Wed, Nov 20, 2024 at 04:08:12PM -0800, Vadim Fedorenko wrote:
> The new helper should be used to convert cycles received by
> bpf_get_cpu_cycle() into nanoseconds.

This is pertinently false, as written here you're looking for a single
reading into a clock value, while that is exactly not what you want.

Please, go write real changelogs

