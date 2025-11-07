Return-Path: <bpf+bounces-73914-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AD8C3DFF6
	for <lists+bpf@lfdr.de>; Fri, 07 Nov 2025 01:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2154A3A7307
	for <lists+bpf@lfdr.de>; Fri,  7 Nov 2025 00:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476192E090B;
	Fri,  7 Nov 2025 00:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFkThyRZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD7A1A9F96;
	Fri,  7 Nov 2025 00:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762476068; cv=none; b=KmhQBOnLvj7+opuuPbNJSQzEHgaXCQqmuxSzZz8fYXMTrcw5eKo3g34CjD0zHBD5dWMHamA0MCVnz57OlGBaoIN37naOSRQgsY6w0AmZt86od0BD95DR9WZXDoiFZdn5z+nVzJlSkQ3Hwlx1bsxhnHEa+oNn25s1uTnAeIdE7LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762476068; c=relaxed/simple;
	bh=jFa55KqNnHvpz9rnQU89qCerdm7mULqQMBPjFJ5SP08=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qdcji95ciaKqiZc5TmIGUybw1aR6XdypR7vDTNy5+OQr+Sb0ZYeNivJ1lNanpR1wwVBV6gu0XHOoY3V5XnoIWk9dGI6NhGVwonNlhYGDJAqH2AmDlifAfZYAv3v1OdcCypUUpsDnprdv7PJvFHqd0gSYvIDXb6kedblBkm/vZiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YFkThyRZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D8F7C116D0;
	Fri,  7 Nov 2025 00:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762476068;
	bh=jFa55KqNnHvpz9rnQU89qCerdm7mULqQMBPjFJ5SP08=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YFkThyRZ8OICs85nHiZhdLcLoGxAoJQdjQi88aHns9MBS01mV6IpLohKUM55VrkJa
	 m0GCe1+tTnVTWydYqzAke+MZdjzizwKycsUgcdhlIq3CV2D+fdDhpYl5N3eZ1Y5tMR
	 hLnf5vC+l3d6Zt21bYE5nq4vdG+tHtgx5AtmzZMkGqBedtvCTMW5QrXt8WA+zPMn96
	 QpFe9Kx/g8Nb7jo09NtdYa8jaxxiKEraHz1ODV52iks39npKF2safqhDoG1DalH9hx
	 G4Vs5qa/FcI0JI1AEaIcRKLbt/KPEl1YpoiSffH2ZS4UaaBHMbDfppYFqAUKf+h9we
	 sBd+yxNT15wpw==
Date: Thu, 6 Nov 2025 16:41:06 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com,
 sdf@fomichev.me, john.fastabend@gmail.com, martin.lau@kernel.org,
 jordan@jrife.io, maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
 dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
 wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v4 11/14] netkit: Implement
 rtnl_link_ops->alloc and ndo_queue_create
Message-ID: <20251106164106.7b858706@kernel.org>
In-Reply-To: <20251031212103.310683-12-daniel@iogearbox.net>
References: <20251031212103.310683-1-daniel@iogearbox.net>
	<20251031212103.310683-12-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Oct 2025 22:21:00 +0100 Daniel Borkmann wrote:
> +static void netkit_get_channels(struct net_device *dev,
> +				struct ethtool_channels *channels)
> +{
> +	channels->max_rx = dev->num_rx_queues;
> +	channels->max_tx = dev->num_tx_queues;
> +	channels->max_other = 0;
> +	channels->max_combined = 1;
> +	channels->rx_count = dev->real_num_rx_queues;
> +	channels->tx_count = dev->real_num_tx_queues;
> +	channels->other_count = 0;
> +	channels->combined_count = 0;
>  }

Why do we need to implement get_channels?

