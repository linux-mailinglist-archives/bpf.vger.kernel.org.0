Return-Path: <bpf+bounces-74262-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD828C50303
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 02:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4891718960C1
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 01:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F43B22A1D4;
	Wed, 12 Nov 2025 01:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLPc63+d"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9145146A66;
	Wed, 12 Nov 2025 01:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762910331; cv=none; b=u0NOcJ/5i1aJVpS5uPcSibiI62KUgrz3AU7UkbT1CEH5T2g+TvrNBMZzCzNRrPaSKW0q6hH8dm8NdMwZRcNFOMLbxXvquCXDk4DbqBTuSM61vn1Ofbn++CJ6/gDg/Ja3gQg1Gl24CgSJfPfMue3ImwkLmfemDj+AFyRRX1wBoIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762910331; c=relaxed/simple;
	bh=97xU45qdEBpW2fivb5PGMD/llcOzvONkpb6RqID0mCE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cgj73TtJgUrJJrKF6rCXlDnGhefWRfLLKJ6Dpr9+74GJe5Xo3tkI2SizkQ49gj7wMJRkgYihFDJeso/806uR+WnrNi59HMs4TnWmDTR+MrX8J9ZC3qqHu2U2MtXpC/zemO1nrlD3IO8p+oVL5zyemPyQslVEGQuEJ60O/MZRXpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLPc63+d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B678C4CEF5;
	Wed, 12 Nov 2025 01:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762910330;
	bh=97xU45qdEBpW2fivb5PGMD/llcOzvONkpb6RqID0mCE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TLPc63+dMvlBPnRfG3N925Xo9BAPQn4nhuvICt7vX/ogkcFEEN5FSjfLzWsafcs3B
	 GdGLo8ylkJMcxrzw6Z5FZjYEDnhTUV4BCC5ciI2Dg3rRy2pW1UTw+wzO58PyzHh5UD
	 Yiib+/YdGwGcgVHWYD3oDSt9AESHDpAGpZV5Odn0t7wEK7GmXVhwxO3IQEcKKIvpmQ
	 xFNI1jij7O84TF632Q+3tOuHvTo2QLvYzhtrsXvwRBzslAj3FMI/vvvORx8/g2xkIU
	 woBXRh6PHna01qzjnYUi+jWSguds+VpSYdCzIKALeSux0JOr2HiFoNcBpvdASddpVL
	 gt7o9OCHfd7KA==
Date: Tue, 11 Nov 2025 17:18:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Roger Quadros <rogerq@kernel.org>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>, Stanislav
 Fomichev <sdf@fomichev.me>, Simon Horman <horms@kernel.org>, srk@ti.com,
 Meghana Malladi <m-malladi@ti.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH net-next v2 0/7] net: ethernet: ti: am65-cpsw: add
 AF_XDP zero copy support
Message-ID: <20251111171848.1a4c8c03@kernel.org>
In-Reply-To: <20251109-am65-cpsw-xdp-zc-v2-0-858f60a09d12@kernel.org>
References: <20251109-am65-cpsw-xdp-zc-v2-0-858f60a09d12@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 09 Nov 2025 23:37:50 +0200 Roger Quadros wrote:
> This series adds AF_XDP zero coppy support to am65-cpsw driver.
> 
> Tests were performed on AM62x-sk with xdpsock application [1].
> 
> A clear improvement is seen in 64 byte packets on Transmit (txonly)
> and receive (rxdrop).
> 1500 byte test seems to be limited by line rate (1G link) so no
> improvement seen there in packet rate. A test on higher speed link
> (or PHY-less setup) might be worthwile.
> 
> There is some issue during l2fwd with 64 byte packets and benchmark
> results show 0. This issue needs to be debugged further.
> A 512 byte l2fwd test result has been added to compare instead.

It appears that the drivers/net/ethernet/ti/am65-* files do not fall
under any MAINTAINERS entry. Please add one or extend the existing CPSW
entry as the first patch of the series.

