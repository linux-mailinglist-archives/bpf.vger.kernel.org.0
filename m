Return-Path: <bpf+bounces-45367-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8B49D4C50
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 12:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00B20282698
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 11:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC4C1D2234;
	Thu, 21 Nov 2024 11:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i8kPc53J"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE281CD1EE;
	Thu, 21 Nov 2024 11:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732190043; cv=none; b=H2NP316dOD7wA7LXcuxknWAHt1pyg2soV415FlwodjZ8VJtV6C4BoNFpBhKYhAzptlbySg7ascDrNK3GTNdnCIVcco8ktR2cueCCQ4o4cjNgWzgW1Zuy5424Slzll7BT64FApJxS4ReZsXxMSpc8ewdlZET2kxHik4HUS4WtcxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732190043; c=relaxed/simple;
	bh=AmK0AI1qoNjZ0cH1lAwLtt6sWfdkbtQrIoeS241Raec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhMJxmPS5rCTPZ731euklN91BZWZLnBYogRBq8/ILXmogwEuvZEH+PBdrnE5Amncl5nFdN2Ef978yB/ggwwyXMUA9Gp0DCo3jW15oxnR2UzKAKUOrMJpSM15khfOIMjNQVBKmCGL4H8Ev0dbUVfm1+CaouSYaqi8kFwjsUvPSjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=i8kPc53J; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AmK0AI1qoNjZ0cH1lAwLtt6sWfdkbtQrIoeS241Raec=; b=i8kPc53JEweieYf82/XNWs+MyZ
	y4TdePE7L5rOgPuxlWUHzcVG6gzltYkmMsaE/ZzgBBynjqMwGiE+6yFLxQvITJvcH7YGqUYLkNaUo
	Qn0lvht+b2fv6Uq8UKqIZHgHfoTNAYjqbeJ1capS9O1WbedziHKV9DK7xsXuaA3Ta90tiAThMD8Ow
	IDMPeF/uK4/iX1VS8IQTC9idKd0O0yp9Co4xmqi+FU1LZtLHXRySZh8HVH6PkynqdkebIAQiuVifM
	ENg5RvdtXFb6WZIRurvGvEZHCyzs2oZ8tLHTrN29ItXiy8FUmXg9AVXM5eSe1PV5ZjVj9O4DrBFVX
	nIlPDXLw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tE5ku-00000006LDa-2iuE;
	Thu, 21 Nov 2024 11:53:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 83C1B30068B; Thu, 21 Nov 2024 12:53:53 +0100 (CET)
Date: Thu, 21 Nov 2024 12:53:53 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC perf/core 05/11] uprobes: Add mapping for optimized uprobe
 trampolines
Message-ID: <20241121115353.GJ24774@noisy.programming.kicks-ass.net>
References: <20241105133405.2703607-1-jolsa@kernel.org>
 <20241105133405.2703607-6-jolsa@kernel.org>
 <20241105142327.GF10375@noisy.programming.kicks-ass.net>
 <ZypI3n-2wbS3_w5p@krava>
 <CAEf4BzZ4XgSOHz0T5nXPyd+keo=rQvH5jc0Jghw1db0a7qR9GQ@mail.gmail.com>
 <ZzkSKQSrbffwOFvd@krava>
 <CAEf4BzbSrtJWUZUcq-RouwwRxK1GOAwO++aSgjbyQf26cQMfow@mail.gmail.com>
 <20241119091348.GE11903@noisy.programming.kicks-ass.net>
 <CAEf4BzbhDE2B41pULQuTfx0f_-1fn5ugJEdPpweKWZVJetCxrQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbhDE2B41pULQuTfx0f_-1fn5ugJEdPpweKWZVJetCxrQ@mail.gmail.com>

On Wed, Nov 20, 2024 at 04:07:38PM -0800, Andrii Nakryiko wrote:

> USDTs are meant to be "transparent" to the surrounding code and they
> don't mark any clobbered registers. Technically it could be added, but
> I'm not a fan of this.

Sure. Anyway, another thing to consider is FRED, will all of this still
matter once that lands? If FRED gets us INT3 performance close to what
SYSCALL has, then all this work will go unused.

