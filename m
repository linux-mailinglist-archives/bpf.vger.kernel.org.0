Return-Path: <bpf+bounces-58774-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 336E3AC1709
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 00:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFC6C5060A8
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 22:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C41A2BCF71;
	Thu, 22 May 2025 22:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GwoqHKt4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1CD29A9F9;
	Thu, 22 May 2025 22:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747954520; cv=none; b=j5Yb+B4G5VtKSreMHjte1CGzXJTNu8kCEM6j2fMCl6cNRKx+DhpRcJ+Z7OphhcLLHOSFeTXrMN3LnfA1BqTjWpLN+o4kBLSj4pwPb9hp/T96LnHaMb+K7IPOl81ZErUFlpd/atAs7w0HlRx/KUHuQ436U/BqeUsv5hOE9r5S9ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747954520; c=relaxed/simple;
	bh=20BxxCEe2TpJllJFUO+uu+ZTnDkvT1+Y6OoCQLuPVMo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EIbswz5AMhyZM7nkaM2oTEqOlkM4uPBQ24OjWys68Y5lNjQU4gq94kz8tWohjH9aNdrUduCVXpajMecqslFl5Kp5oGN/BxOyq/03/mi6HvJ5d/BFFmP5LCbjgIZVNOWAnxWQ3dNPItiQg92258Px2pJsYi8NZylYFXitGykHVtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GwoqHKt4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A67D3C4CEEB;
	Thu, 22 May 2025 22:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747954520;
	bh=20BxxCEe2TpJllJFUO+uu+ZTnDkvT1+Y6OoCQLuPVMo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GwoqHKt42hmw6eeGh/JitXySF3qirPMlq5ZuQjnFUDszGVPmHgEymvysZOjKqSdbm
	 bIR8hf1UwKSA+fXvWOy8THGqjELjqhKBlCfKTdhgj7l04iV85pctx9YrQC44daPcs/
	 4kAWjWZMP4L/4Pw3OLXkqRwDmXonWewlVsbr/7zbS64C6MWvD6rjI9oWVVYCkLlZuy
	 w/gMlKYqlGUSuluTvqu4UH3Of5M3HPCmgsb2+42usD4tiaAXh8nPv2HV39el576Nmp
	 +kejM0i5ISMAE78ga9L/0X2NwS7bi1Um4n+g/8aZIFIYBWuiA2R420nxpJiKQaR7+s
	 0hH3T16c+GImg==
Date: Thu, 22 May 2025 15:55:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, Saeed Mahameed <saeedm@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Richard Cochran <richardcochran@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, <netdev@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Mark Bloch
 <mbloch@nvidia.com>, Gal Pressman <gal@nvidia.com>, Cosmin Ratiu
 <cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next V2 11/11] net/mlx5e: Support ethtool
 tcp-data-split settings
Message-ID: <20250522155518.47ab81d3@kernel.org>
In-Reply-To: <1747950086-1246773-12-git-send-email-tariqt@nvidia.com>
References: <1747950086-1246773-1-git-send-email-tariqt@nvidia.com>
	<1747950086-1246773-12-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 May 2025 00:41:26 +0300 Tariq Toukan wrote:
> +	/* if HW GRO is not enabled due to external limitations but is wanted,
> +	 * report HDS state as unknown so it won't get turned off explicitly.
> +	 */
> +	if (kernel_param->tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_DISABLED &&
> +	    priv->netdev->wanted_features & NETIF_F_GRO_HW)
> +		kernel_param->tcp_data_split = ETHTOOL_TCP_DATA_SPLIT_UNKNOWN;

The kernel_param->tcp_data_split here is the user config, right?
It would be cleaner to not support setting SPLIT_DISABLED.
Nothing requires that, you can support just setting AUTO and ENABLED.

> +

nit: extra empty line, please run checkpatch

>  }
>  
>  static void mlx5e_get_ringparam(struct net_device *dev,
> @@ -383,6 +391,43 @@ static void mlx5e_get_ringparam(struct net_device *dev,
>  	mlx5e_ethtool_get_ringparam(priv, param, kernel_param);
>  }
>  
> +static bool mlx5e_ethtool_set_tcp_data_split(struct mlx5e_priv *priv,
> +					     u8 tcp_data_split)
> +{
> +	bool enable = (tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_ENABLED);
> +	struct net_device *dev = priv->netdev;
> +
> +	if (tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_UNKNOWN)
> +		return true;
> +
> +	if (enable && !(dev->hw_features & NETIF_F_GRO_HW)) {
> +		netdev_warn(dev, "TCP-data-split is not supported when GRO HW is not supported\n");
> +		return false; /* GRO HW is not supported */
> +	}
> +
> +	if (enable && (dev->features & NETIF_F_GRO_HW)) {
> +		/* Already enabled */
> +		dev->wanted_features |= NETIF_F_GRO_HW;
> +		return true;
> +	}
> +
> +	if (!enable && !(dev->features & NETIF_F_GRO_HW)) {
> +		/* Already disabled */
> +		dev->wanted_features &= ~NETIF_F_GRO_HW;
> +		return true;
> +	}
> +
> +	/* Try enable or disable GRO HW */
> +	if (enable)
> +		dev->wanted_features |= NETIF_F_GRO_HW;
> +	else
> +		dev->wanted_features &= ~NETIF_F_GRO_HW;

Why are you modifying wanted_features? wanted_features is what
*user space* wanted! You should probably operate on hw_features ?
Tho, may be cleaner to return an error and an extack if the user
tries to set HDS and GRO to conflicting values.

