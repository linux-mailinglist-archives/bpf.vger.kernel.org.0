Return-Path: <bpf+bounces-61062-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C74DAE01BE
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 11:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D434188C359
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 09:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C5621D3C0;
	Thu, 19 Jun 2025 09:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AS7uy+BC"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109581E3DE8;
	Thu, 19 Jun 2025 09:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750325686; cv=none; b=uGDYww9htPwSn4j2aEWnshn/kU2DBzi8wBS4us6u/eFCBiu/0+lAlPE9owxXfso5Wcv+pMeJsDjJo5Mf7VUtAc9ZcrFIodKcb7o4zaAFv6wvjuBsyJJZ53dw9qytGw92kDQPZwiZPuuBL3cQXpTa03u/7ur/gLqKEr4wd3gMoqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750325686; c=relaxed/simple;
	bh=QcAYBKT1cIvdsyseoqgitnm430Vwz/EU0Tl9epGz3tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/aLUOlPU4AAbCLR838b6qJqjTslY9Q4FY95sF9qE1SoGCDhjgwR0RnjPVR6EsviNrxMog6eJ03rgOdV/YQuf8lXKj5pxuxu8VobGKqOfxMFg2r+5l20g89Ry21q1Ky3/z4TPLM/kDpZ40M5F7IoSDbrnd+aoXGmEbMp4w17DtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AS7uy+BC; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2AUllZ+Dj4P64TXGTgLBYOcRg8kwoj8xfoPreeFt9p4=; b=AS7uy+BCM1J7UM94lymt0Uy9Fh
	gBOsBSpu50ONWsQL3mvwYWtZgB2yjwYNbiZQaaj9gk7avxxBDMpKJp06hhbIgwEpvCqN+ZzXCVxeo
	26S5vH/n5cKjwCuqBabHbOauwpdTOlXDGb7YpMpq4Ax6pgGe2JqywJdchVMuRCZDvBbxSnerQv1ZB
	Pgrne9l9lVo5bomblV8NN9CIiUs7TjB/KGuwA9PrJKCybmG9fdjNhWupmurDaQ9oeTC5XUAHeV4Hx
	sv5SE1/q9LFW6iMxY/e7DaIJcI/34VfRNlnvznJxcyyfwwE3lkExhEx/Gkxct59YZkHWetVzobS2Y
	55ydr8iA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSBfJ-000000084li-46D5;
	Thu, 19 Jun 2025 09:34:38 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 204BE3088F2; Thu, 19 Jun 2025 11:34:37 +0200 (CEST)
Date: Thu, 19 Jun 2025 11:34:37 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org, x86@kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrii Nakryiko <andrii@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v10 07/14] unwind_user/deferred: Make unwind deferral
 requests NMI-safe
Message-ID: <20250619093437.GI1613200@noisy.programming.kicks-ass.net>
References: <20250611005421.144238328@goodmis.org>
 <20250611010428.938845449@goodmis.org>
 <20250619085717.GB1613376@noisy.programming.kicks-ass.net>
 <FCBAD96C-AD1B-4144-91D2-2A48EDA9B6CC@goodmis.org>
 <20250619093226.GH1613200@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619093226.GH1613200@noisy.programming.kicks-ass.net>

On Thu, Jun 19, 2025 at 11:32:26AM +0200, Peter Zijlstra wrote:
> On Thu, Jun 19, 2025 at 05:07:10AM -0400, Steven Rostedt wrote:
> 
> > Does #DB make in_nmi() true? If that's the case then we do need to handle that.
> 
> Yes: #DF, #MC, #BP (int3), #DB and NMI all have in_nmi() true.

Note: these are all the from-kernel parts of those exceptions. The
from-user side is significantly different.

> Ignoring #DF because that's mostly game over, you can get them all
> nested for up to 4 (you're well aware of the normal NMI recursion
> crap).
> 
> Then there is the SEV #VC stuff, which is also NMI like. So if you're a
> CoCo-nut, you can perhaps get it up to 5.

