Return-Path: <bpf+bounces-26853-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 000788A59A0
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 20:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0327281590
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 18:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A2E13A89E;
	Mon, 15 Apr 2024 18:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvO/FYUe"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF2113A244;
	Mon, 15 Apr 2024 18:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713204954; cv=none; b=Q9Mv568nKYWNK1vkutJOy0hznYYfrCcCKb8Fs20D2yutmb1Tdu6VJewiE8TB4GWpj1eix5RiZsve3WPAoxd0++p2rZfPsBNbG2yngWLRxb0S27d4U8TcVt4uHUPOpm7jOmDy4VxTuusG2p96LceuBFNhGCKONO9BM43/H5RpCZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713204954; c=relaxed/simple;
	bh=acsYRsvhylCApNh8T4aCv+3PFrS/GpwjBz2DieWvPSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6KcqXHxT8GXLdPPjeLhbt9kfHbjBEOqgUXTR2N9s9AcqReEWicZiW5gplZO3oxT108mnNxvX6PWCIxYrhy6hKmAen2vkL6j2+VZK/BUjGlgsENtWOjfpMxgr4dwj9M6QtDuc7y0OFsNlTaYVsX9RtX5awNIcCe3cksSs/VvEqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvO/FYUe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65CC7C32781;
	Mon, 15 Apr 2024 18:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713204954;
	bh=acsYRsvhylCApNh8T4aCv+3PFrS/GpwjBz2DieWvPSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GvO/FYUeqkr6SgNavJ0HYoBPF1G2Z0QV43eKPfYImsJYGWO1W7WylSBhxaDXw373x
	 yZinn16IC7TiLB0PiMXJBWyX3wFHOMhIt8fq9mi4EzpUAVdpULJTv+H/ewQkPr/B72
	 bMxZb/WhfM/hVWVCWjL2X+a0CNE+MTw/xRXFpTUzbkT30IsLThw1P9fh6w2YT1jVIc
	 t5lGZt0kHOw85fF57MEvrusyZBLdBmnflJmzApZoTShxrKyrrRWQFIS3OTayYJJ+Ei
	 FxLP1CXp1Y01E7aG3CFW6Nby7T9IsnBAuU2HKslFG/rTvC2qi0i84NIKeQDXeqDla4
	 hGiqxI6i5KeWQ==
Date: Mon, 15 Apr 2024 19:15:50 +0100
From: Simon Horman <horms@kernel.org>
To: Zheng Li <lizheng043@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, jmorris@namei.org, James.Z.Li@dell.com
Subject: Re: [PATCH] neighbour: guarantee the localhost connections be
 established successfully even the ARP table is full
Message-ID: <20240415181550.GF2320920@kernel.org>
References: <20240412122538.51-1-lizheng043@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412122538.51-1-lizheng043@gmail.com>

On Fri, Apr 12, 2024 at 08:25:38PM +0800, Zheng Li wrote:
> From: Zheng Li <James.Z.Li@Dell.com>
> 
> Inter-process communication on localhost should be established successfully even the ARP table is full,
> many processes on server machine use the localhost to communicate such as command-line interface (CLI),
> servers hope all CLI commands can be executed successfully even the arp table is full.
> Right now CLI commands got timeout when the arp table is full.
> Set the parameter of exempt_from_gc to be true for LOOPBACK net device to
> keep localhost neigh in arp table, not removed by gc.
> 
> the steps of reproduced:
> server with "gc_thresh3 = 1024" setting, ping server from more than 1024 IPv4 addresses,
> run "ssh localhost" on console interface, then the command will get timeout.
> 
> Signed-off-by: Zheng Li <James.Z.Li@Dell.com>
> ---
>  net/core/neighbour.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index 552719c3bbc3..d96dee3d4af6 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -734,7 +734,10 @@ ___neigh_create(struct neigh_table *tbl, const void *pkey,
>  struct neighbour *__neigh_create(struct neigh_table *tbl, const void *pkey,
>  				 struct net_device *dev, bool want_ref)
>  {
> -	return ___neigh_create(tbl, pkey, dev, 0, false, want_ref);
> +	if (dev->flags & IFF_LOOPBACK)
> +		return ___neigh_create(tbl, pkey, dev, 0, true, want_ref);
> +	else
> +		return ___neigh_create(tbl, pkey, dev, 0, false, want_ref);
>  }
>  EXPORT_SYMBOL(__neigh_create);

Hi James,

I'm not commenting on the merits of your patch - I'm sure
the maintainers will do so when you repost as Jakub has suggested.

But wile looking at this it seemed to me that the following might
be a cleaner way to express your change.

struct neighbour *__neigh_create(struct neigh_table *tbl, const void *pkey,
				 struct net_device *dev, bool want_ref)
{
	bool exempt_from_gc = !!(dev->flags & IFF_LOOPBACK);

	return ___neigh_create(tbl, pkey, dev, 0, exempt_from_gc,  want_ref);
}



