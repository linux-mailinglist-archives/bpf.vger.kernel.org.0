Return-Path: <bpf+bounces-19196-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 491FA827491
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 17:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9426B21C13
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 16:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7F151C5B;
	Mon,  8 Jan 2024 16:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SXOJttRi"
X-Original-To: bpf@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB8A51C51
	for <bpf@vger.kernel.org>; Mon,  8 Jan 2024 16:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HvKMB7Amwnf4YmHthQLzVzMzQpiNhalR9XuEKWvBCgQ=; b=SXOJttRiLM0meXkwzbpRElTIQd
	wsRFXGF5PItztCBFbZfp9RVdRqGGr0HApm8KKibXJh6eBe98hG/B3R0C58XV8beXWXF0bymVXgwZD
	uPLjS0MtSbBTOSXleBcBPtwVLdYeSu7uN1R7q0tYwCGfHiaO2mKmHqTJxZ5v9W1BCA9ePckKHLAG0
	Gtkn36BuiU0CRmrHjxlQEGFHBLCMU7jEVSJ1EzPhnpYBtYtm6MV9UyS+fxOI8UvZF9qPO0rrNKj3A
	U1WlMV7JbDo70jT9OKTwRYRz+mhJE8yiTXOC4g/2IZQeiNc0TUIZiWOtXbUQ/cRtqQRsuC1QeP8jk
	OnVY5g8A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rMs2t-005ZUp-39;
	Mon, 08 Jan 2024 16:00:11 +0000
Date: Mon, 8 Jan 2024 08:00:11 -0800
From: Christoph Hellwig <hch@infradead.org>
To: David Vernet <void@manifault.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Dave Thaler <dthaler1968@googlemail.com>, bpf@ietf.org,
	bpf <bpf@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [Bpf] BPF ISA conformance groups
Message-ID: <ZZwcC7nZiZ+OV1ST@infradead.org>
References: <CAADnVQJ-JwNTY5fW-oXdTur9aDrv2NQoreTH3yYZemVBVtq9fQ@mail.gmail.com>
 <20231213185603.GA1968@maniforge>
 <CAADnVQLOjByUKJNyLdvDzwuegtjZFwrttHft_1o8BoyDCXQvDQ@mail.gmail.com>
 <20231214174437.GA2853@maniforge>
 <ZXvkS4qmRMZqlWhA@infradead.org>
 <CAADnVQ+ExRC_RavN_sbuOmuwyP6+HKnV9bFjJOseORBaVw0Jcg@mail.gmail.com>
 <09dc01da32a6$99c97e50$cd5c7af0$@gmail.com>
 <CAADnVQ+Kb20aUZdcqSh5eF-_dzpHWcpjAtYpLgg5Fqog=g7hpA@mail.gmail.com>
 <ZYPiq6ijLaMl/QD8@infradead.org>
 <20240105220711.GA1001999@maniforge>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240105220711.GA1001999@maniforge>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jan 05, 2024 at 04:07:11PM -0600, David Vernet wrote:
> 
> So how do we want to move forward here? It sounds like we're leaning
> toward's Alexei's proposal of having:
> 
> - Base Integer Instruction Set, 32-bit
> - Base Integer Instruction Set, 64-bit
> - Integer Multiplication and Division
> - Atomic Instructions

As in the 64-bit integer set would be an add-on to the first one which
is the core set?  In that case that's fine with me, but the above
wording is a bit suboptimal.

> And then either having 3 separate groups for the calls, or putting all 3
> in the basic group? I'd lean towards the latter given that we're
> decoupling ISA compliance from the verifier, but don't feel strongly
> either way.

What would be the three different groups for the calls?  I think just
having the call instruction in the base group should be fine.  We'll
need to put in some wording that having support for any kind of call
depends on the program type.


