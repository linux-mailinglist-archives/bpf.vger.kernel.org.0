Return-Path: <bpf+bounces-48778-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3A0A108EF
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 15:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23CEC1884A9F
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 14:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D821213A879;
	Tue, 14 Jan 2025 14:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qu6dI3iI"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1746F06B;
	Tue, 14 Jan 2025 14:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736864249; cv=none; b=qGNAih5V4drZTiP5GpnT7KKA6axC7hG3qo6FylZwEkiQ3V30Zp7sAzKufmRFWuCgy77LITEZ9rubK2nQ8lzOsMUZle/pFOo/P0/+/wLpvJvkoqsr2KUdZCofTJ4aHnUdh54y6QbAW8YeXEY1yJ4jNQfQSkLkagE49Vo2jLL5pBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736864249; c=relaxed/simple;
	bh=m+z2P0iqMgo30jCMZH1rPbo39nINlhLh3q/Vd2vM2BY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZu2KhoXVddqoBY2m3zemLEskaXUJ7nbNAhc3CRIeUyzojrneE5M4RQZUuZXT8dN30nJcstCunLNyDKP8FwbWd/NZXLYP7AXFIS01AbBwaL7mxBCU+KrnT0TFSOJFPEcOVnsHVtb72cID9Q224CFKe4aXvz0XfmrG6Oz+kXWqBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qu6dI3iI; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sZSQ+aNYXb1wrd7HMBp8nX09OrL4/Lj8Lt0BpEG6ikI=; b=qu6dI3iIUSsO9XBNdr4DMCRl2v
	PRWP5V5TDNCElptz95VqqFIX5wgFdWijlDxm8tDRsvRCE7Btp0lpORO4MAhgCkE10tNn/8dicXckZ
	mjg3tSYt70+YpXKVYcVuQO/wmn/8RwUSXbDt/G196xDcAihPD2U2Zulnbuz4aNXoqMGt4qxO1CJMW
	f5Y4atGMndeQgZytO4JLdaQiWwSsKsnnj+mk464ggp7mbo/eXHIPMQQmungKLDD2VFLhYRnOal+ck
	UghRJj9q1/ck3sP8kX7icHSskJkDLpsDtK3sDnDOn4QEs0LWbh+Y0DMKnAh6x+eUHIPhDUc6aGQEp
	vWPJvQdg==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tXhjQ-0000000GrZv-1cYu;
	Tue, 14 Jan 2025 14:17:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7DF833003AF; Tue, 14 Jan 2025 15:17:23 +0100 (CET)
Date: Tue, 14 Jan 2025 15:17:23 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	David Laight <David.Laight@aculab.com>,
	lkml <linux-kernel@vger.kernel.org>,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	x86@kernel.org
Subject: Re: [RFC] x86/alternatives: Merge first and second step in
 text_poke_bp_batch
Message-ID: <20250114141723.GS5388@noisy.programming.kicks-ass.net>
References: <20250114140237.3506624-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114140237.3506624-1-jolsa@kernel.org>

On Tue, Jan 14, 2025 at 03:02:37PM +0100, Jiri Olsa wrote:
> hi,
> while checking on similar code for uprobes I was wondering if we
> can merge first 2 steps of instruction update in text_poke_bp_batch
> function.
> 
> Basically the first step now would be to write int3 byte together
> with the rest of the bytes of the new instruction instead of doing
> that separately. And the second step would be to overwrite int3
> byte with first byte of the new instruction.
> 
> Would that work or do I miss some x86 detail that could lead to crash?

I *think* it will work on most modern systems, but I'm very sure I don't
have all the details.

IIRC this is the magic recipe blessed by both Intel and AMD, and
if we're going to be changing this I would want both vendors to sign off
on that.

> I tried to hack it together in attached patch and it speeds up a bit
> text_poke_bp_batch as shown below.

Why do we care about performance here?

