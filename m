Return-Path: <bpf+bounces-17955-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F702814143
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 06:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 260DD284443
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 05:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D2563B3;
	Fri, 15 Dec 2023 05:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="z+c7Su/y"
X-Original-To: bpf@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A7BD281
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 05:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CtQY7KcTCGUbqzxXM2TcGqfofhXPlN3NkzbGgokG5XI=; b=z+c7Su/y35aW7BVvydk4qKg0N6
	fpWjylJIiX85R7eB8p5OD1KSAX/v2LKoE1HdHs+TMwdbl13OdrxWcJ9Zh5QlHfhVVEE+CJZ8+/tFm
	wBj9PS92GbJnHXi/asdNcFVPzzoA57eh79tuDWRAhgCYAw+lVbWLp/qn8WY6EKDY+bd8Y8gdFpoaE
	vkS74aSqnIwb4dGyNVSYiK5Q17mSVJihefbAgBEQmGoW/N5b4Je90wK5WQenpzdvZ+ge9juXzEu85
	kGMjIWs2vwHakfJNXg2LcDcCa8CBHv45tiObQLJdECglUjYSgJ3NmgN5M1Z8GNjJserVTLOBbkpAE
	eSPXLQkA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rE0lf-0024GB-35;
	Fri, 15 Dec 2023 05:29:47 +0000
Date: Thu, 14 Dec 2023 21:29:47 -0800
From: Christoph Hellwig <hch@infradead.org>
To: David Vernet <void@manifault.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Dave Thaler <dthaler1968@googlemail.com>, bpf@ietf.org,
	bpf <bpf@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [Bpf] BPF ISA conformance groups
Message-ID: <ZXvkS4qmRMZqlWhA@infradead.org>
References: <20231207215152.GA168514@maniforge>
 <CAADnVQ+Mhe6ean6J3vH1ugTyrgWNxupLoFfwKu6-U=3R8i1TNQ@mail.gmail.com>
 <20231212214532.GB1222@maniforge>
 <157b01da2d46$b7453e20$25cfba60$@gmail.com>
 <CAADnVQKd7X1v6CwCa2MyJjQkN8hKsHJ_g9Kk5CwWSbp9+1_3zw@mail.gmail.com>
 <20231212233555.GA53579@maniforge>
 <CAADnVQJ-JwNTY5fW-oXdTur9aDrv2NQoreTH3yYZemVBVtq9fQ@mail.gmail.com>
 <20231213185603.GA1968@maniforge>
 <CAADnVQLOjByUKJNyLdvDzwuegtjZFwrttHft_1o8BoyDCXQvDQ@mail.gmail.com>
 <20231214174437.GA2853@maniforge>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214174437.GA2853@maniforge>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Dec 14, 2023 at 11:44:37AM -0600, David Vernet wrote:
> > > Why else would they be asking for a standard if not to
> > > have some guidelines of what to implement?
> > 
> > Excellent question. I don't know why nvme folks need a standard.
> > Lack of standard didn't stop netronome.
> 
> Christoph? Any chance you can shed some light here?

netronome is a single vendor implementation.  You write for their
device and the standard is what they accept.  NVMe is an open,
multi-vendor standard.  You need to be able to write your code against
the spec and run it on all devices (that implement the required
features).  NVMe also needs another open standard as the reference as
it just can't point to a void.

> I agree that there's value in instructions having specific meaning and
> encodings, but my worry is that (for device offload) the value would be
> minimized quite a bit if a developer writing a BPF offload program
> doesn't also have some knowledge or guarantee of what instructions
> vendors have actually implemented.

Absolutely.

> If we were to do away with conformance groups, then I as a BPF user
> would have the guarantee: "Any hw device which happens to implement the
> instructions in my program will behave in a predictable way". If that
> user doesn't know what instructions it can count on being actually
> available in devices, then they're going to end up just implementing the
> program for a single device anyways. At that point, how useful was it
> really to standardize on the semantics of the instructions? That user
> just as soon could have read the specifications for the device and
> implemented the prog according to the semantics that the vendor decided
> were most appropriate for them.

We need the concept in the spec just to allow future extensability.

