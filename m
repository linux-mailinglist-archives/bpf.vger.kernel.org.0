Return-Path: <bpf+bounces-45457-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A85379D5E3A
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 12:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EA9728138A
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 11:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1281DE2D2;
	Fri, 22 Nov 2024 11:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KzdX/m4n"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B011DDC39
	for <bpf@vger.kernel.org>; Fri, 22 Nov 2024 11:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732275257; cv=none; b=le9JMFZCtz3KU3VwXx1Nt8Iy7XYnvORbvEtquhv+zUx+DBTUuoKCk29hd46CtarCj1AkcLe1IsGJs1EbHwAObDhOM/nzDzmg8KFJlOYBRo2zyQ/l5XLDAY510t/a+Uj4fYtfSdi/Rh9DhgyZkT7/dx6Kj+v39qtszIWf3lxEqMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732275257; c=relaxed/simple;
	bh=CGdFSTpCJdiMMviqvMyvU200vMCiOiab0iSLFJ6Non4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BICqNkG7MJQ55tZlTqijq6+npCADlNvfhVoafKagMzZGTzEuapx5yvYXZwlJC7nWAYsGq15fA7wl06An0aEUSw2suSUJSysypCgEmr2fN3OVguVe9qR2UO2lcThEggkvppFBFj4BV9MAqVNOHEXi2nCt2TcbWJIzhNH54T2JGJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KzdX/m4n; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CGdFSTpCJdiMMviqvMyvU200vMCiOiab0iSLFJ6Non4=; b=KzdX/m4ngNSYfY3kFTWHd+P1Xu
	wcg0aq25KEUzAgdmGfTKjVSr9XaXyLtO84lYjbWveUnVkCVoV6EQLbr4P33xF6hde0pZO8B+fO6NY
	zO5jRdooWSq+qI0t6ZfL2pnHtG5VPvmI1m9FVSAAzLIpWNFFZ2qMpDDGgLeQSr8KBaNc304W83YKv
	0BjXyJ6VuVmkkueag+5kZc2DM/vUCt3W9tPIGoNcgBc3VwKvKOJK+02acL7yqA4zhKLdtenCUHl64
	wJqUwOm/HagzYjKsxpkdbtuoKQ1WcnjflvXCZLwVUF0hQex5eCOKbv/SiadXtMLYxopHL+pEBxuYc
	3uMKi3Mw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tERvN-00000000hQK-2Um1;
	Fri, 22 Nov 2024 11:34:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2A6C830066A; Fri, 22 Nov 2024 12:34:09 +0100 (CET)
Date: Fri, 22 Nov 2024 12:34:09 +0100
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
Subject: Re: [PATCH bpf-next v8 0/4] bpf: add cpu cycles kfuncss
Message-ID: <20241122113409.GV24774@noisy.programming.kicks-ass.net>
References: <20241121000814.3821326-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121000814.3821326-1-vadfed@meta.com>

On Wed, Nov 20, 2024 at 04:08:10PM -0800, Vadim Fedorenko wrote:
> This patchset adds 2 kfuncs to provide a way to precisely measure the
> time spent running some code. The first patch provides a way to get cpu
> cycles counter which is used to feed CLOCK_MONOTONIC_RAW. On x86
> architecture it is effectively rdtsc_ordered() function while on other
> architectures it falls back to __arch_get_hw_counter(). The second patch
> adds a kfunc to convert cpu cycles to nanoseconds using shift/mult
> constants discovered by kernel. The main use-case for this kfunc is to
> convert deltas of timestamp counter values into nanoseconds. It is not
> supposed to get CLOCK_MONOTONIC_RAW values as offset part is skipped.
> JIT version is done for x86 for now, on other architectures it falls
> back to slightly simplified version of vdso_calc_ns.

So having now read this. I'm still left wondering why you would want to
do this.

Is this just debug stuff, for when you're doing a poor man's profile
run? If it is, why do we care about all the precision or the ns. And why
aren't you using perf?

Is it something else?

Again, what are you going to do with this information?

