Return-Path: <bpf+bounces-63472-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE992B07CDF
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 20:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2376A172832
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 18:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E28429B239;
	Wed, 16 Jul 2025 18:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="De6aRbuk"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306CD19DFAB;
	Wed, 16 Jul 2025 18:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752690262; cv=none; b=h/OQS0x3I8rR5ZSv9k02xvYgbx4Kd54EXIBEmaXWKAEGlOWITyAmrI4QsXMBBqILEuu1liX2dBfYTG6qtsWjkuz2z3Blu7A8ZUlytcyt1P4cwW0WXu0L6YNKpVl9JbplgsoTEp2jxA3RZsqj6VW7AW6tgTlkU84gE/QR8KmzYho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752690262; c=relaxed/simple;
	bh=rq2sNcvGNSXQGHJOcJcmFZzvpuSjQI0+RgGNGsfTdds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MNZUsoQiwt7prun+BbJU9B8W58wdqRcqS9irCV9CVtoQsJtKZQpdiLT6SC/wS8ZwyKVzduEsWbs0D924jMzzS5ObrONGwZDUghz3krZhQhB5BFZbRxPO+DdyK86b7ZduWxTihiVUjl3qgDTUmSTkX1LKnkSkPSWsj3XbUU/DT00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=De6aRbuk; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=c186ZNgQmAaLS8afZJIRv4pOWgMcJfYqLO2lB+Do3FQ=; b=De6aRbukFLaahYguOiPeZ/16x4
	CRNwGMxNGkbljygJ9Ogege8ytbzXLVS17ASPMstF2omMKYMcUNJi6wQVwvaxhRFOKHq9IQojG3HpQ
	hEJkXl2XoC4IBh7p5HfVQdi9zasAB7FXaZKfUtLL8mFyYRGtR5Dckc/llRjSwNeQseKADmksy8MX5
	ucUqRkCp4wjS7j6iWfwAvAMjNgAXYUpIVFHlS8s1RDy4/Rj8B02iF3EcKp9b8VasQ/9JxgtGHg2N0
	pNnRv11KacQ6ZsvhoSUVFOJhiD8YkpjyCLl3/gN5j7mN/Nz1Nbq8h1NdNXsLE5hcZrtHaSDEKMkZU
	IINqJGgA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uc6nf-0000000A9X8-29NZ;
	Wed, 16 Jul 2025 18:24:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 63CAB300230; Wed, 16 Jul 2025 20:24:14 +0200 (CEST)
Date: Wed, 16 Jul 2025 20:24:14 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Menglong Dong <menglong.dong@linux.dev>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@kernel.org>,
	bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>
Subject: Re: Inlining migrate_disable/enable. Was: [PATCH bpf-next v2 02/18]
 x86,bpf: add bpf_global_caller for global trampoline
Message-ID: <20250716182414.GI4105545@noisy.programming.kicks-ass.net>
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
 <20250703121521.1874196-3-dongml2@chinatelecom.cn>
 <CAADnVQKP1-gdmq1xkogFeRM6o3j2zf0Q8Atz=aCEkB0PkVx++A@mail.gmail.com>
 <45f4d349-7b08-45d3-9bec-3ab75217f9b6@linux.dev>
 <3bccb986-bea1-4df0-a4fe-1e668498d5d5@linux.dev>
 <CAADnVQ+Afov4E=9t=3M=zZmO9z4ZqT6imWD5xijDHshTf3J=RA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQ+Afov4E=9t=3M=zZmO9z4ZqT6imWD5xijDHshTf3J=RA@mail.gmail.com>

On Wed, Jul 16, 2025 at 09:56:11AM -0700, Alexei Starovoitov wrote:

> Maybe Peter has better ideas ?

Is it possible to express runqueues::nr_pinned as an alias?

extern unsigned int __attribute__((alias("runqueues.nr_pinned"))) this_nr_pinned;

And use:

	__this_cpu_inc(&this_nr_pinned);


This syntax doesn't actually seem to work; but can we construct
something like that?

Google finds me this:

 https://gcc.gnu.org/pipermail/gcc-help/2012-February/109877.html


