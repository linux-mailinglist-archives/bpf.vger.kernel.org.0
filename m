Return-Path: <bpf+bounces-75005-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A2583C6B80C
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 20:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 54DD92A316
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 19:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430812ECE8F;
	Tue, 18 Nov 2025 19:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lbaXHhds"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9A32E1747;
	Tue, 18 Nov 2025 19:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763495856; cv=none; b=G6uR/hAYt7veKGy58NrEfBgYIU/B5oIAxXw4uG5Gw37gJ8/btAF1zP+I26DLvEMUPSbTw6b5pr3tBHWuLA2Wiv4PEWDv34oVQuTHfdwMk3zUlPJLe4tZ3lfGS0EyyAry/CGCO4AT+BAnTfGTEhvzlkQEtTpaFaP3ZYANlNW4oDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763495856; c=relaxed/simple;
	bh=1FSG1V3qR27LXMlsNMFduFdy2LjWczTQ+/qtiHeFEfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0N2A+DapyQYWSk18DEMZpksRJpo/qkj4b4q9gXVNG6j4pdo0yCwlKMAEA9p1uCytSJAVmtocFk4k3HX+Sm5+Lq37hPFdwFM98swiwVJOIRAb4cU6z39UVj3x/h3OwQ7Z7udUQ+G5rlIP+TPrmUueulgmGAYmCuIlu08a3XJ904=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lbaXHhds; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=W1Y1wX4hmQMJFdqAY8ThVoyxh2X0uPU7pKbMV844lBw=; b=lbaXHhdsH2npNGMQXpllRKoSUy
	0MCDp1l9wu37uJ7l0yMpcAoaRkm3t9gz/LH/7JtA0nAAu7WkplrxFe0X3nPyaJO3rOzqshSYjtUoQ
	W1PM/N3t0EcXeLb82mhVGZ4l9B/YbdbTrBun+X+ooGzcOVIzArNua9tTCVv2yDIn0t9kgTXguLmnS
	1lZoFgeYaLodhgLjGbttW+S4OABTA6xXB2HRXO9gLb/dd/s3/VPwKKIW7E8e/Qrmn5CwKRY2BkXvs
	/g729uocHjpGQWKMvqwNmErPVAIFSQKXP6y52R9/w6Uux06eX+QIFlFAOCOH1gwxcA2YKSNg889sS
	osHx2fAw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLRpS-0000000Fz8x-0Vhn;
	Tue, 18 Nov 2025 19:57:30 +0000
Date: Tue, 18 Nov 2025 19:57:29 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"hch@infradead.org" <hch@infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"urezki@gmail.com" <urezki@gmail.com>
Subject: Re: [PATCH v3 0/4] make vmalloc gfp flags usage more apparent
Message-ID: <aRzPqYfXc6mtR1U9@casper.infradead.org>
References: <TY3PR01MB11346E8536B69E11A9A9DAB0886D6A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <aRyn7Ibaqa5rlHHx@fedora>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRyn7Ibaqa5rlHHx@fedora>

On Tue, Nov 18, 2025 at 09:07:56AM -0800, Vishal Moola (Oracle) wrote:
> On Tue, Nov 18, 2025 at 04:14:01PM +0000, Biju Das wrote:
> > Hi All,
> > 
> > I get below warning with today's next. Can you please suggest how to fix this warning?
> 
> Thanks Biju. This has been fixed and will be in whenever Andrews tree
> gets merged again.

I see:

Unexpected gfp: 0x1000000 (__GFP_NOLOCKDEP). Fixing up to gfp: 0x2dc0 (GFP_KERNEL|__GFP_ZERO|__GFP_NOWARN). Fix your code!

I suspect __GFP_NOLOCKDEP should also be permitted by vmalloc.

