Return-Path: <bpf+bounces-63209-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5816CB042BB
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 17:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 690827B40F3
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 15:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517FA25A2C0;
	Mon, 14 Jul 2025 15:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="asnmaG/H"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82A42E630;
	Mon, 14 Jul 2025 15:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752505592; cv=none; b=otUY4cm5CHcfz5dq39ZldrYWOsy8K0Kcq0dhMMxmkTk8PzYCvq3fYcvkRMnuZ5H01wpQ880OFUNHeQgmO3JO4XSPEfeNSvAB3h3SQXP6IqrIiJFkzNTyp56Puu4I74DyHOTS1XmmXTugZuPyQM1iH+cM9Z1sN7L2FxeSACGHZJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752505592; c=relaxed/simple;
	bh=rZEwBG5xcYTfwrowVFDeZfsNzGHUEzr6KDrtWIj8qU4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aLvgCKAZ0ofE5L2LdPtk9lG+VtOG6jecxt7WD6p6ln5UXQ1NZ9XeLSO0t0U4oFmdCSzuwsz66t94yx9gzGyy42STwIS3zwt8ili49LXkGry2e/cuSkDl/uawmLPZFuSzHJvsauLW286qrRZqIRLu/b54cFmXhSl6P5c8kyUmGi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=asnmaG/H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A92E4C4CEED;
	Mon, 14 Jul 2025 15:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752505592;
	bh=rZEwBG5xcYTfwrowVFDeZfsNzGHUEzr6KDrtWIj8qU4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=asnmaG/H6O1mKZurcswdFwsaHP/ZtxcpcKa1S/7hM4yz/H9VAF9G3XKmFUk5ExXXB
	 sB3nClYrxCawRcgzLPj+0UdHKzXXZnMULYu/24R14s52W4ApkV++qeZY374VzYAkA9
	 BlIFlWrn9ol+kogWbB2F3lWmJ+uRuF1fiLSfwgj/Gq13LtNvqnpBAumFfJnhFCntWR
	 T675lR9RoQxUuyq/rZlxUwl6JFCA0dNxL4WSXOMypmL2rvXowGJC25uBtlaz0F29Cq
	 7jnQZjBpgL1ohHEALsUymmQfK0mablSFKM/0eLLV1ozBk0RiJXFPiNIrF6pTeUa9AW
	 oyfBXFs+ISAQg==
Date: Mon, 14 Jul 2025 08:06:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Malladi, Meghana" <m-malladi@ti.com>
Cc: Roger Quadros <rogerq@kernel.org>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Sumit Semwal
 <sumit.semwal@linaro.org>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, <srk@ti.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
 <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linaro-mm-sig@lists.linaro.org>
Subject: Re: [PATCH RFC net-next 0/5] net: ethernet: ti: am65-cpsw: add
 AF_XDP zero copy support
Message-ID: <20250714080629.29aa7a2d@kernel.org>
In-Reply-To: <268f6849-efc6-4663-af20-f6726bd4b78d@ti.com>
References: <20250520-am65-cpsw-xdp-zc-v1-0-45558024f566@kernel.org>
	<268f6849-efc6-4663-af20-f6726bd4b78d@ti.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Jul 2025 14:50:05 +0530 Malladi, Meghana wrote:
> > AF_XDP performance using 64 byte packets in Kpps.
> > Benchmark:	XDP-SKB		XDP-Native	XDP-Native(ZeroCopy)
> > rxdrop		317		504		824
> > txonly		400		405		757
> > l2fwd 		207		264		0
> > 
> > AF_XDP performance using 1500 byte packets in Kpps.
> > Benchmark:	XDP-SKB		XDP-Native	XDP-Native(ZeroCopy)
> > rxdrop		82		82		82
> > txonly		82		82		82
> > l2fwd 		82		82		82
> > 
> > [1]: https://github.com/xdp-project/bpf-examples/tree/master/AF_XDP-example
> > 
> > To:
> > 
> > Signed-off-by: Roger Quadros <rogerq@kernel.org>  
> 
> This series crashes Linux on am64xx-hsevm, when I tried nfs boot using 
> AM65-CPSW-NUSS driver:
> logs: 
> https://gist.github.com/MeghanaMalladiTI/d655a1c8ca88113ee7f5f57d6ab0ec4c
> 
> Seems like you have reverted the fix for the same bug which was reported 
> by Siddharth and fixed by Julien: 
> https://lore.kernel.org/all/7f7fb71a-6d15-46f1-b63c-b569a2e230b7@baylibre.com/
> 
> reverted lines:
> 		if (!common->ports[port].ndev)
> 		/* FIXME should we BUG here? */
> 			continue;
> 
> Can you please take a look at it.

Just to be clear -- you're reporting this problem to Roger so that its
fixed before the series is reposted? I don't see this in the tree, I
wanted to make sure it's not something I need to track as a regression.

