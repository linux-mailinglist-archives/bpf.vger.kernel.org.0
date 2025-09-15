Return-Path: <bpf+bounces-68386-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE23DB578E9
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 13:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C6461A22082
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 11:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652CB3009EE;
	Mon, 15 Sep 2025 11:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q84tqTHL"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFC33009D8;
	Mon, 15 Sep 2025 11:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757936838; cv=none; b=huBZc+OmoJkhjPFgWGkbr+s7y12jVmOr596G/7wH36FiNXv4GR65ybj8D2p52YcCUYN69kSGN2wzNyBWXv35Wy6GctPBx8DG8Elco2K6vSckUo8W6d4ium6GRA/jcPk+9cIMuWgOzAaBH3zJohd8nHT6LnCKbjDkjsAdY/rsmKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757936838; c=relaxed/simple;
	bh=iYwdHd0yHyr9COcnUzQB7EY8HcVxM1IsSoPv8mO5MAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CSm5NTbo6EPrJr61qjIi8SwwuU7qNiHHs7WmZ35MKz8XBelztXHFuq9eGMiOOanrB2RkcsFleoA57X/iHp64TZrljtrID8P5TKVLdi9pzs7Zpw0TYPKp4pDc4yzuH50SGPjNGBH1mAfu1BvySztJRrAGPEX3mR+gQ02ahbg3OPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=q84tqTHL; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SFBbBvmmOnzTd5d+84TyP6wYT17N3spITLaBM1O9CQ0=; b=q84tqTHLOELd2tL88iYJBD6tN6
	htlwQzgKZLA740qa2qwSb3vW5+fF76toEwTU7xFWGXemJDRPryzgNrIS7F7dJ9rgl/NaK6wmUT1Mp
	fFRcEMxvAnzXdJxPa5Xud1xbrNAXR4Q14csQgGoWgvrRYniXqJfjmkw2Eb7ry+7vS7c8gtO+58iq5
	nhnMQH6T7T0KjFEWQC4UEev0jaGb7cGv3zp6vfRSn47ihAIyjw3ot7eSEizkW+t9cXPf4Xi2P3MEF
	63+mkgqXJj4SPu9Qbee6quXcagAtnZgtud+j3YfmrE1d8xWQpZN9yGZHRhC95kE8AajC30Qr2ury3
	4HgYhRNQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy7fm-0000000EUzB-3hNt;
	Mon, 15 Sep 2025 11:47:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6BAB9300212; Mon, 15 Sep 2025 13:47:06 +0200 (CEST)
Date: Mon, 15 Sep 2025 13:47:06 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>, Jann Horn <jannh@google.com>,
	Alejandro Colomar <alx@kernel.org>
Subject: Re: [PATCH perf/core 0/3] uprobes/x86: change error path for uprobe
 syscall
Message-ID: <20250915114706.GC3245006@noisy.programming.kicks-ass.net>
References: <20250905205731.1961288-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905205731.1961288-1-jolsa@kernel.org>

On Fri, Sep 05, 2025 at 10:57:28PM +0200, Jiri Olsa wrote:

> Jiri Olsa (2):
>       uprobes/x86: Return error from uprobe syscall when not called from trampoline
>       selftests/bpf: Fix uprobe_sigill test for uprobe syscall error value
> 
>  arch/x86/kernel/uprobes.c                               |  2 +-
>  tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c | 34 ++++++----------------------------
>  2 files changed, 7 insertions(+), 29 deletions(-)

Thanks!

