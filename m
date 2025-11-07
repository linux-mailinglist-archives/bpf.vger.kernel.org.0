Return-Path: <bpf+bounces-73915-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 523E2C3E000
	for <lists+bpf@lfdr.de>; Fri, 07 Nov 2025 01:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 654954E4C58
	for <lists+bpf@lfdr.de>; Fri,  7 Nov 2025 00:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860D52E6127;
	Fri,  7 Nov 2025 00:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tTWdaMI8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02842D3732;
	Fri,  7 Nov 2025 00:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762476230; cv=none; b=nqTlrMI2bkYKVS+T3V82/Q8QQT6lYyr083bnLuLkza2Ny/0F4qZi/1jxde3YiDu0XGw7Mpsk4XdKoQWu8dL4M+hM4hgeit7TYxNNFlwIZ0kp9i24I2HGW+wYG1Xhjx4EGW+c9896TQdE7u31DBk/YDvK55xPNekTu8sDkwuDgww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762476230; c=relaxed/simple;
	bh=vpzEZJ4Zn9ccO93YSGbqY0TGRI2esI3oL2206IKJwug=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EUdcLWdIt36wmR+RzHE9w4XOxhW873SLoc5FFH06peE2hhes22SDjy2lF5+KVvFnOQyfADXBcfAQixPUkGpiYTbV0rt5E6GzbSvFPYXFRujWoWEImraeGvxFrT7gywSYzCfb8vKuNYXBqR6M0CtQtd2JR21BzX7oHkID+vixSnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tTWdaMI8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF48C116C6;
	Fri,  7 Nov 2025 00:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762476229;
	bh=vpzEZJ4Zn9ccO93YSGbqY0TGRI2esI3oL2206IKJwug=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tTWdaMI8SNkb6TWWkx+7GsdvAqCjX00y/k+0J58Uyva7tUJzRwMCNYmlr2gYUofsk
	 6jb5shldZKKXqHBSoWWpM0YZtBdgtNrYFhlDrIrlOakNgBzNMbyubhlDxA9w1szg6/
	 gVTpO0sO8xMM8o9Dly0BB8pVvESAI3T+ffSmiVmOxXvJHYSUvcvCttAnDRzwrUklXu
	 YkCE0JPsnGftd/lucNQ+saDK6KV4azUUeYthgbE57tVzIXBUXLUdBQ20KdwC7awisQ
	 GksPg+jXvJwF9VeZK987+P8qziarJvu05JreVxxjYQGlE+d2GblAg85qu4Lb+CYUSO
	 k5AoYc0lUaPlA==
Date: Thu, 6 Nov 2025 16:43:47 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com,
 sdf@fomichev.me, john.fastabend@gmail.com, martin.lau@kernel.org,
 jordan@jrife.io, maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
 dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
 wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v4 13/14] netkit: Add io_uring zero-copy
 support for TCP
Message-ID: <20251106164347.2ffdf8d0@kernel.org>
In-Reply-To: <20251031212103.310683-14-daniel@iogearbox.net>
References: <20251031212103.310683-1-daniel@iogearbox.net>
	<20251031212103.310683-14-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Oct 2025 22:21:02 +0100 Daniel Borkmann wrote:
> +static struct device *netkit_queue_get_dma_dev(struct net_device *dev, int idx)
> +{
> +	struct netdev_rx_queue *rxq, *peer_rxq;
> +	unsigned int peer_idx;
> +
> +	rxq = __netif_get_rx_queue(dev, idx);
> +	if (!rxq->peer)
> +		return NULL;
> +
> +	peer_rxq = rxq->peer;
> +	peer_idx = get_netdev_rx_queue_index(peer_rxq);
> +
> +	return netdev_queue_get_dma_dev(peer_rxq->dev, peer_idx);
> +}

Doesn't look netkit specific at all, let's move it into the core
helper.

