Return-Path: <bpf+bounces-58788-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0637DAC17A0
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 01:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A98D4507709
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 23:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771DF2D1926;
	Thu, 22 May 2025 23:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ri7ME5py"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30D32D0278;
	Thu, 22 May 2025 23:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747955970; cv=none; b=cFUgoVn4itg/lowCM1/AXywu7CYk+8uw4KoLQF7ZkemvetoTbblnkIngiSYNPk7zEYjemcfmFn8E+MBKMUJeX1TBm0vSm2NjtYMMyk+qYOVP6FJC6v2KfipRoFhME9wOg3kz/3qEej9JjjVzdigHi34qXPQhyo92X8jKUKe8gqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747955970; c=relaxed/simple;
	bh=cjW9PVL0/Eq1a/hOUaEzc/Ua2x1NBZ3c6LCU6XFANY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VGG9jmzJtre8e2ULbeEjLXgXshaLoY+pWi52DkAoecfLA1iVVWHhxLKZY38RnoCGFzsanbX9QO302g69UfOIKJuSCWvZM59Ow+xlTVkW7CNa1jS/xXuq7IXjjfpQicODUdytPVSNJk9YH72itolK+x/TiLY9zn+4JmfvIRLuh4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ri7ME5py; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA0DEC4CEEB;
	Thu, 22 May 2025 23:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747955969;
	bh=cjW9PVL0/Eq1a/hOUaEzc/Ua2x1NBZ3c6LCU6XFANY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ri7ME5py8Wd8vPgE55M2cznFBRaWDAnh9A+NLgy6HDiyAWwxN7JyPN2BkDRZnJ4Sb
	 0Cdoi2YVrDug1iwiDI/iSj9MlY3v2fSroUA/MkXxTExu4I16HxlyMtuQNw0haI9mlT
	 cUljrxCmG6C303b3vY8V4J/UwFsxg/wKLzgljxoHLt0fg7Ue8y/7rBPn/4kNvDz1Lw
	 5s70ZB+ykmQV3O/uLQwp8/Ndzc+GvA9ljB0JVfVhvznWzJAdl5Iq1bPZdojLIobFEF
	 vVyzt9A8O6LVkTzMd4AQSoebTWCnNzNNHdPHsds0w3tFSsAGUI9FVorQWVGrlRPgPt
	 gyRPrX2ZRU7TA==
Date: Thu, 22 May 2025 16:19:28 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, Moshe Shemesh <moshe@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next V2 11/11] net/mlx5e: Support ethtool
 tcp-data-split settings
Message-ID: <aC-xAK0Unw2XE-2T@x130>
References: <1747950086-1246773-1-git-send-email-tariqt@nvidia.com>
 <1747950086-1246773-12-git-send-email-tariqt@nvidia.com>
 <20250522155518.47ab81d3@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250522155518.47ab81d3@kernel.org>

On 22 May 15:55, Jakub Kicinski wrote:
>On Fri, 23 May 2025 00:41:26 +0300 Tariq Toukan wrote:
>> +	/* if HW GRO is not enabled due to external limitations but is wanted,
>> +	 * report HDS state as unknown so it won't get turned off explicitly.
>> +	 */
>> +	if (kernel_param->tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_DISABLED &&
>> +	    priv->netdev->wanted_features & NETIF_F_GRO_HW)
>> +		kernel_param->tcp_data_split = ETHTOOL_TCP_DATA_SPLIT_UNKNOWN;
>
>The kernel_param->tcp_data_split here is the user config, right?
>It would be cleaner to not support setting SPLIT_DISABLED.
>Nothing requires that, you can support just setting AUTO and ENABLED.
>

I think I agree, AUTO might require some extra work on the driver side to
figure out current internal mode, but it actually makes more sense than
just doing "UNKNOWN", UKNOWN here means that HW GRO needs to be enabled
when disabling TCP HDR split, and we still don't know if that will work..

Cosmin will you look into this ? 

>> +
>
>nit: extra empty line, please run checkpatch
>
>>  }
>>
>>  static void mlx5e_get_ringparam(struct net_device *dev,
>> @@ -383,6 +391,43 @@ static void mlx5e_get_ringparam(struct net_device *dev,
>>  	mlx5e_ethtool_get_ringparam(priv, param, kernel_param);
>>  }
>>
>> +static bool mlx5e_ethtool_set_tcp_data_split(struct mlx5e_priv *priv,
>> +					     u8 tcp_data_split)
>> +{
>> +	bool enable = (tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_ENABLED);
>> +	struct net_device *dev = priv->netdev;
>> +
>> +	if (tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_UNKNOWN)
>> +		return true;
>> +
>> +	if (enable && !(dev->hw_features & NETIF_F_GRO_HW)) {
>> +		netdev_warn(dev, "TCP-data-split is not supported when GRO HW is not supported\n");
>> +		return false; /* GRO HW is not supported */
>> +	}
>> +
>> +	if (enable && (dev->features & NETIF_F_GRO_HW)) {
>> +		/* Already enabled */
>> +		dev->wanted_features |= NETIF_F_GRO_HW;
>> +		return true;
>> +	}
>> +
>> +	if (!enable && !(dev->features & NETIF_F_GRO_HW)) {
>> +		/* Already disabled */
>> +		dev->wanted_features &= ~NETIF_F_GRO_HW;
>> +		return true;
>> +	}
>> +
>> +	/* Try enable or disable GRO HW */
>> +	if (enable)
>> +		dev->wanted_features |= NETIF_F_GRO_HW;
>> +	else
>> +		dev->wanted_features &= ~NETIF_F_GRO_HW;
>
>Why are you modifying wanted_features? wanted_features is what
>*user space* wanted! You should probably operate on hw_features ?
>Tho, may be cleaner to return an error and an extack if the user
>tries to set HDS and GRO to conflicting values.
>

hw_features is hw capabilities, it doesn't mean on/off.. so no we can't
rely on that.

To enable TCP_DATA_SPLIT we tie it to GRO_HW, so we enable GRO_HW when
TCP_DATA_SPLIT is set to on and vise-versa. I agree not the cleanest.. 
But it is good for user-visibility as you would see both ON if you query
from user, which is the actual state. This is the only way to set HW_GRO
to on by driver and not lose previous state when we turn the other bit
on/off.

Yes, I guess such logic should be in the stack, although I don't see
anything wrong here in terms of correctness.


