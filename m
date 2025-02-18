Return-Path: <bpf+bounces-51848-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A602BA3A4E1
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 19:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0F8A168C7A
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 18:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A686270ECA;
	Tue, 18 Feb 2025 18:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AgWKjRZG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3A618CC15;
	Tue, 18 Feb 2025 18:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739901779; cv=none; b=o4HSzfyOzJcXh6ph0gNGD1sGrYOzNzUJ6v6xLiW7vHCP+7+Cw+FqSe4okQ5k+Yd2Qo/ZoVml4Cvggvu8CjhO3zLU9wk8qAW7CIH6ANq4HOPzzR7J5ACKy4vmVCeP+IX+xNpIW/boNs3X5RMJ0ySR2LhzPMSWUSdAbEqwlzcmEUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739901779; c=relaxed/simple;
	bh=Ji5H0HAIhBoajCoSQJjjccgX8c2XFWg15BCdipugYx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=emtuZ/rQ9D8QmCzT9SfFqtBFBtquiPiumK2BB4D074RwjqnMeu6tLZEiPuvwfnGkuw2BgNQ3wDUB4edkcGQT4fTsP/hO6Z7Of3NAeuK4MYRaOSaxn05HafVKlrQ1IA6F4AKLW2EiKfyj+XVxXb0mB1LcahCeef+YToV8E+yUHZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AgWKjRZG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8164FC4CEE2;
	Tue, 18 Feb 2025 18:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739901779;
	bh=Ji5H0HAIhBoajCoSQJjjccgX8c2XFWg15BCdipugYx0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AgWKjRZGxu333k5y6D2ngFcZZIpI9ttttE9iOZYDGqvQdg6557wtwP8DV4+jlX2bQ
	 nQHh2xU4dLYWtS0McBHT90JKf+b7qH5tAOy1A+but2cYZYgcTSoblIMh14kQiFr7iw
	 pcnxztiTx+7+zn4wVrRWbbkcqKdTmro53BmC5FNH4+RquYQEBDokh3q5ut81EQU7eO
	 cKnjlGmsxFqGIX6l+vtIj7fyQAx296W+KMeo7vnR2g74Thi41B9DBgyDS/Ku7ttsWb
	 XovfNIwrY+CdbJxGlYOr8Nmda3ZnJnYBzLxrn3awOYpB31Bl4i4BNV3m9sRDtjTlQ9
	 DglXqwSsI4Frg==
Date: Tue, 18 Feb 2025 18:02:54 +0000
From: Simon Horman <horms@kernel.org>
To: Roger Quadros <rogerq@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Md Danish Anwar <danishanwar@ti.com>, srk@ti.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next 3/5] net: ethernet: ti: am65-cpsw: use return
 instead of goto in am65_cpsw_run_xdp()
Message-ID: <20250218180254.GE1615191@kernel.org>
References: <20250217-am65-cpsw-zc-prep-v1-0-ce450a62d64f@kernel.org>
 <20250217-am65-cpsw-zc-prep-v1-3-ce450a62d64f@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217-am65-cpsw-zc-prep-v1-3-ce450a62d64f@kernel.org>

On Mon, Feb 17, 2025 at 09:31:48AM +0200, Roger Quadros wrote:
> In am65_cpsw_run_xdp() instead of goto followed by return, simply return.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


