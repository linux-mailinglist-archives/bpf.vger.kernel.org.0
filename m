Return-Path: <bpf+bounces-71972-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 00978C03F0F
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 02:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 933B14EF92A
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 00:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0D2156CA;
	Fri, 24 Oct 2025 00:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cp5DQ+ku"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABE217BA6;
	Fri, 24 Oct 2025 00:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761264888; cv=none; b=rcLSI7lNjQzLXKaAy8kzfGsc4hcW9ueF/lNcN2Psly3AgD6Huh/ofQ4ge7qv71CMYTYQctZd7D17IWkhLyZqzla9Y9MAGK/NJNTySTW8+6wtLtYl4kAGPpMiGzzD7GjFd8w1Vk8MYFIkwSGi3b+DYn9obbVEaAQdowD8aun8Dj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761264888; c=relaxed/simple;
	bh=wNfF88XJrtwddINtbyLx/v5hRHXYNoY5vwhDh2Fs2AQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tsmjGFOguAt44/bQ5WCvPm3QwNLlIZmIIiG+wUF4O6LwJxHY3ACUtfJeAFE1mQ9e1KKWAKclf6qzgWvbNAUmCMgIGsaNPurzW6vEFhnymDLR2x8HbwnKQzHFTXbt3fl7joaKBsLOQ3P5p8pKjmuVfxV3/v6weCIF+6TbH6bHfRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cp5DQ+ku; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C52C4CEE7;
	Fri, 24 Oct 2025 00:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761264887;
	bh=wNfF88XJrtwddINtbyLx/v5hRHXYNoY5vwhDh2Fs2AQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Cp5DQ+kuTyijbyUco0SGy8lR3E+FMJtXFKIDRQFtoXWwvf2O1GSb2TLNtuwGCxFxO
	 5+vRAKPeiov7cLOiuM5mAhb7LgmG80/Lf39HXgQrQlZOVfdSOA8s4t4uDrE+jbRLZs
	 CoXldV+tOh5rhTiUrKbqV6bBGFrxav/zAwEWOW3YrQh3SAH5P7a8oyYgfcuAEsn9Oe
	 1/mE8GiMsABG1hIc6J7Jz/B9r8rH65UbwyiA1EwJZQM1ARy61/yoFHpyMuf25QIYt7
	 a77YJtwe2P5VyT1ESyx6fHPqJzHqiDIip0BuaRmZ49rz38Q4OE/TSM1hmFgXaGwhGv
	 WXUfy9ocp3aAA==
Date: Thu, 23 Oct 2025 17:14:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joshua Washington <joshwash@google.com>
Cc: netdev@vger.kernel.org, Ankit Garg <nktgrg@google.com>, Harshitha
 Ramamurthy <hramamurthy@google.com>, Jordan Rhee <jordanrhee@google.com>,
 Willem de Bruijn <willemb@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Praveen Kaligineedi
 <pkaligineedi@google.com>, Ziwei Xiao <ziweixiao@google.com>, open list
 <linux-kernel@vger.kernel.org>, "open list:XDP (eXpress Data
 Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next 2/3] gve: Allow ethtool to configure rx_buf_len
Message-ID: <20251023171445.2d470bb3@kernel.org>
In-Reply-To: <20251022182301.1005777-3-joshwash@google.com>
References: <20251022182301.1005777-1-joshwash@google.com>
	<20251022182301.1005777-3-joshwash@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Oct 2025 11:22:24 -0700 Joshua Washington wrote:
> +	if (priv->rx_cfg.packet_buffer_size != SZ_2K) {
> +		netdev_warn(dev,
> +			    "XDP is not supported for Rx buf len %d. Set Rx buf len to %d before using XDP.\n",
> +			    priv->rx_cfg.packet_buffer_size, SZ_2K);
> +		return -EOPNOTSUPP;
> +	}

Please plumb extack thru to here. It's inside struct netdev_bpf

>  	max_xdp_mtu = priv->rx_cfg.packet_buffer_size - sizeof(struct ethhdr);
>  	if (priv->queue_format == GVE_GQI_QPL_FORMAT)
>  		max_xdp_mtu -= GVE_RX_PAD;
> @@ -2050,6 +2057,44 @@ bool gve_header_split_supported(const struct gve_priv *priv)
>  		priv->queue_format == GVE_DQO_RDA_FORMAT && !priv->xdp_prog;
>  }
>  
> +int gve_set_rx_buf_len_config(struct gve_priv *priv, u32 rx_buf_len,
> +			      struct netlink_ext_ack *extack,
> +			      struct gve_rx_alloc_rings_cfg *rx_alloc_cfg)
> +{
> +	u32 old_rx_buf_len = rx_alloc_cfg->packet_buffer_size;
> +
> +	if (rx_buf_len == old_rx_buf_len)
> +		return 0;
> +
> +	if (!gve_is_dqo(priv)) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Modifying Rx buf len is only supported with DQO format");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (priv->xdp_prog && rx_buf_len != SZ_2K) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Rx buf len can only be 2048 when XDP is on");
> +		return -EINVAL;
> +	}
> +
> +	if (rx_buf_len > priv->max_rx_buffer_size) {

This check looks kinda pointless given the check right below against
the exact sizes?

> +		NL_SET_ERR_MSG_FMT_MOD(extack,
> +				       "Rx buf len exceeds the max supported value of %u",
> +				       priv->max_rx_buffer_size);
> +		return -EINVAL;
> +	}
> +
> +	if (rx_buf_len != SZ_2K && rx_buf_len != SZ_4K) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Rx buf len can only be 2048 or 4096");
> +		return -EINVAL;
> +	}
> +	rx_alloc_cfg->packet_buffer_size = rx_buf_len;
> +
> +	return 0;
> +}

