Return-Path: <bpf+bounces-45408-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E99BF9D5375
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 20:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DF5A1F23653
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 19:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C868B1C303A;
	Thu, 21 Nov 2024 19:39:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9691143ACB;
	Thu, 21 Nov 2024 19:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732217964; cv=none; b=Us4QAJTGEyzOSqc3Fv3kDOBuNEZ637qo/B+FNrIQ1PlEZg+lA5gf0BqIHDRXqN8P72sZb54LUqUqYWMBYZl14KFfOlVXQLvkkNOuq2wILwK2HzjRCnBr6JIANDQsxakSluGm9rNWXkYbf2jAu3EKTstZZiPGiZtfB8hqlFpkAOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732217964; c=relaxed/simple;
	bh=Nyzjvz4KYFaiD67hHwcz3LhDNHxN1WB5SGIxMXQszWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QdNTNW0X8A0XdVsYEv8as4IumAaztNE5XRART+Uf2wTCZSVIZ8KDPLseuhcIXe/3x1ZIIHvQqHw0sXSRTdmiu9Gf3W1QazpRVpPaeh4wv2T3HOcNJPG5iLRIAkh/lfLDznrRyy2aphH0UT1O1IORS6Z1KZqCt9Z/E6ywN0XZFnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AD0112FC;
	Thu, 21 Nov 2024 11:39:50 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A3AF13F5A1;
	Thu, 21 Nov 2024 11:39:17 -0800 (PST)
Date: Thu, 21 Nov 2024 19:38:58 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jiri Olsa <olsajiri@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC perf/core 05/11] uprobes: Add mapping for optimized uprobe
 trampolines
Message-ID: <Zz-MI1J1FpvqItdq@J2N7QTR9R3>
References: <ZypI3n-2wbS3_w5p@krava>
 <CAEf4BzZ4XgSOHz0T5nXPyd+keo=rQvH5jc0Jghw1db0a7qR9GQ@mail.gmail.com>
 <ZzkSKQSrbffwOFvd@krava>
 <CAEf4BzbSrtJWUZUcq-RouwwRxK1GOAwO++aSgjbyQf26cQMfow@mail.gmail.com>
 <20241119091348.GE11903@noisy.programming.kicks-ass.net>
 <CAEf4BzbhDE2B41pULQuTfx0f_-1fn5ugJEdPpweKWZVJetCxrQ@mail.gmail.com>
 <20241121115353.GJ24774@noisy.programming.kicks-ass.net>
 <CAADnVQJJ0WS=Y1EudjiFD8fn4zHCz6x1auaEEHaYHsP15Vks2Q@mail.gmail.com>
 <20241121163450.GN24774@noisy.programming.kicks-ass.net>
 <CAADnVQ+3VA-SW2FKVv7iSPps00gZRkOb9L7NiKFZ5Jc5NwDedQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+3VA-SW2FKVv7iSPps00gZRkOb9L7NiKFZ5Jc5NwDedQ@mail.gmail.com>

[resending as I somehow messed up the 'From' header and got a tonne of
bounces]

On Thu, Nov 21, 2024 at 08:47:56AM -0800, Alexei Starovoitov wrote:
> On Thu, Nov 21, 2024 at 8:34 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > Elsewhere in the thread Mark Rutland already noted that arm64 really
> > doesn't need or want this.
> 
> Doesn't look like you've read what you quoted above.
> On arm64 the _HW_ cost may be the same.
> The _SW_ difference in handling trap vs syscall is real.
> I bet once uprobe syscall is benchmarked on arm64 there will
> be a delta.

I already pointed out in [1] that on arm64 we can make the trap case
*faster* than the syscall. If that's not already the case, there's only
a small amount of rework needed, (pulling BRK handling into
entry-common.c), which we want to do for other reasons anyway.

On arm64 I do not want the syscall; the trap is faster and simpler to
maintain.

Mark

[1] https://lore.kernel.org/lkml/ZzsRfhGSYXVK0mst@J2N7QTR9R3/

