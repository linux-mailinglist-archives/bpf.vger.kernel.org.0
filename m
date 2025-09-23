Return-Path: <bpf+bounces-69306-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59281B93D4B
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 03:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C82B3481AFC
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 01:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0FE1F8755;
	Tue, 23 Sep 2025 01:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ht6LKRRh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5EB1FDE01;
	Tue, 23 Sep 2025 01:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758590553; cv=none; b=MgPbhd0VZvti4KwNGM+WHy8cOygZ/locY/J+jcG9tHea1TUVft6V9THS0KMcbIN3w/SJh0FC5QVoeXvu5Ye1y+zkfRTyn+Idarxyw4XAjeHcpgK5BszyrP/da6VHC1mw3YYTcWjRkvQF/m6NDmp1VehpMzTybhDt1PbWA2bPrBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758590553; c=relaxed/simple;
	bh=EumMEY/UUWWTjUdtuoHUk7W5cMhDw4YKRiV76rZwtdo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YAsHbugKu8XBZDmGon+sFD7dE7aUBpIU6RyFzvybBlvtlbQ7XI4UxazReTJGf4yZP1JuByUGfZ2bK/wvapyQ82GU4e0sIaK/BVDXuUaXI/37YCd1Hvc4FiRCh07XN4W/SW7IzlkoXnKxq/VVmZCltOia0CVsezLHYH9fucIPpxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ht6LKRRh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D841FC4CEF0;
	Tue, 23 Sep 2025 01:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758590552;
	bh=EumMEY/UUWWTjUdtuoHUk7W5cMhDw4YKRiV76rZwtdo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ht6LKRRhRMfIMuPvcmQqLGsOtEJPSPXFrFCUYiX0FmwJ9C6JsE7DaD1hnzD6GIkjK
	 Ii1+QYGRC08SGe1k66TSuLoEwC1JioRDRCpjyf4SjvefQhANuwfXnboor2rWYIC03a
	 dY1tjxKyrDgM3UoURtXsKsc8Yp0aCA1CU/mbjHDP07Co/myxe27af2G3lYsXn+vpXh
	 4n66j8n6glpVsLDQ2oo8skum+B+gYU1sYdGf04ccS3QnGenhQ9cmGEx8jyG32Zw0cL
	 4+/N7hfbmQogU1166b1eIBOwFSgU3mAIPwH8cVt/RhqGzVrjFZl+2z+q9N5kD/MmZP
	 JeCWiWIiuDz/w==
Date: Mon, 22 Sep 2025 18:22:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com,
 sdf@fomichev.me, john.fastabend@gmail.com, martin.lau@kernel.org,
 jordan@jrife.io, maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
 David Wei <dw@davidwei.uk>
Subject: Re: [PATCH net-next 03/20] net: Add ndo_queue_create callback
Message-ID: <20250922182231.197635c1@kernel.org>
In-Reply-To: <20250919213153.103606-4-daniel@iogearbox.net>
References: <20250919213153.103606-1-daniel@iogearbox.net>
	<20250919213153.103606-4-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Sep 2025 23:31:36 +0200 Daniel Borkmann wrote:
> From: David Wei <dw@davidwei.uk>
> 
> Add ndo_queue_create() to netdev_queue_mgmt_ops that will create a new
> rxq specifically for mapping to a real rxq. The intent is for only
> virtual netdevs i.e. netkit and veth to implement this ndo. This will
> be called from ynl netdev fam bind-queue op to atomically create a
> mapped rxq and bind it to a real rxq.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  include/net/netdev_queues.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
> index cd00e0406cf4..6b0d2416728d 100644
> --- a/include/net/netdev_queues.h
> +++ b/include/net/netdev_queues.h
> @@ -149,6 +149,7 @@ struct netdev_queue_mgmt_ops {
>  						  int idx);
>  	struct device *		(*ndo_queue_get_dma_dev)(struct net_device *dev,
>  							 int idx);
> +	int			(*ndo_queue_create)(struct net_device *dev);
>  };
>  
>  bool netif_rxq_has_unreadable_mp(struct net_device *dev, int idx);

This patch is meaningless, please squash it into something that matters.

