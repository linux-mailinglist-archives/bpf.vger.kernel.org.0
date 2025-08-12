Return-Path: <bpf+bounces-65441-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D000FB22DEC
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 18:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8101169E55
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 16:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2AC2F90FA;
	Tue, 12 Aug 2025 16:35:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D849E2F90DF;
	Tue, 12 Aug 2025 16:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755016517; cv=none; b=YTv4Ty0ui4V736W7koc/kepVNARN8s5EG/MoxGhQxV5p4ij6EBM/YS95po+zOwsD6zkzAjqmjdDaaf2VPRFQJoyGZWZ0sei5RRkenbeN923EqW0EkD2iXmt6skYgMQQ8Tmn9mVnz0iwg4nH+dd97TlCcyECKkIOfatf5oMs3uqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755016517; c=relaxed/simple;
	bh=ZFn1gZ3CVw3oY+MqSfy6Kd4p12BsQLuqaFj6iP/PP6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=NFEjp+m8l2TUAv8SudXpHHDYVAuo/bKymaAspY6Shj6ZC+3iyM0Wb5dOaK11jIrG+NiujbxcMn562xNk17Qhv/ey6Y3JDeXI2XkLOdGwyF14ifV9vREpv95z2zxzrncXkD55KW97cOQpEp0CzTFk7MQVbIsLkSGUmdv7tmxZg2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 2CEA761E647BA;
	Tue, 12 Aug 2025 18:34:13 +0200 (CEST)
Message-ID: <af057e48-f428-4c34-8991-99959edbabd2@molgen.mpg.de>
Date: Tue, 12 Aug 2025 18:34:12 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH 1/5] ethtool: use vmalloc_array() to
 simplify code
To: Qianfeng Rong <rongqianfeng@vivo.com>
References: <20250812133226.258318-1-rongqianfeng@vivo.com>
 <20250812133226.258318-2-rongqianfeng@vivo.com>
Content-Language: en-US
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 bpf@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250812133226.258318-2-rongqianfeng@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Qianfeng,


Thank you for your patch.

Am 12.08.25 um 15:32 schrieb Qianfeng Rong:
> Remove array_size() calls and replace vmalloc() with vmalloc_array() to
> simplify the code and maintain consistency with existing kmalloc_array()
> usage.

You could build it without and with your patch and look if the assembler 
code changes.

> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---
>   drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c | 2 +-
>   drivers/net/ethernet/intel/igb/igb_ethtool.c     | 8 ++++----
>   drivers/net/ethernet/intel/igc/igc_ethtool.c     | 8 ++++----
>   drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 2 +-
>   drivers/net/ethernet/intel/ixgbevf/ethtool.c     | 6 +++---
>   5 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
> index 1954a04460d1..bf2029144c1d 100644
> --- a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
> +++ b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
> @@ -560,7 +560,7 @@ static int fm10k_set_ringparam(struct net_device *netdev,
>   
>   	/* allocate temporary buffer to store rings in */
>   	i = max_t(int, interface->num_tx_queues, interface->num_rx_queues);
> -	temp_ring = vmalloc(array_size(i, sizeof(struct fm10k_ring)));
> +	temp_ring = vmalloc_array(i, sizeof(struct fm10k_ring));
>   
>   	if (!temp_ring) {
>   		err = -ENOMEM;
> diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
> index 92ef33459aec..51d5cb6599ed 100644
> --- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
> +++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
> @@ -920,11 +920,11 @@ static int igb_set_ringparam(struct net_device *netdev,
>   	}
>   
>   	if (adapter->num_tx_queues > adapter->num_rx_queues)
> -		temp_ring = vmalloc(array_size(sizeof(struct igb_ring),
> -					       adapter->num_tx_queues));
> +		temp_ring = vmalloc_array(adapter->num_tx_queues,
> +					  sizeof(struct igb_ring));
>   	else
> -		temp_ring = vmalloc(array_size(sizeof(struct igb_ring),
> -					       adapter->num_rx_queues));
> +		temp_ring = vmalloc_array(adapter->num_rx_queues,
> +					  sizeof(struct igb_ring));
>   
>   	if (!temp_ring) {
>   		err = -ENOMEM;
> diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> index ecb35b693ce5..f3e7218ba6f3 100644
> --- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
> +++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> @@ -627,11 +627,11 @@ igc_ethtool_set_ringparam(struct net_device *netdev,
>   	}
>   
>   	if (adapter->num_tx_queues > adapter->num_rx_queues)
> -		temp_ring = vmalloc(array_size(sizeof(struct igc_ring),
> -					       adapter->num_tx_queues));
> +		temp_ring = vmalloc_array(adapter->num_tx_queues,
> +					  sizeof(struct igc_ring));
>   	else
> -		temp_ring = vmalloc(array_size(sizeof(struct igc_ring),
> -					       adapter->num_rx_queues));
> +		temp_ring = vmalloc_array(adapter->num_rx_queues,
> +					  sizeof(struct igc_ring));
>   
>   	if (!temp_ring) {
>   		err = -ENOMEM;
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> index 25c3a09ad7f1..2c5d774f1ec1 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> @@ -1278,7 +1278,7 @@ static int ixgbe_set_ringparam(struct net_device *netdev,
>   	/* allocate temporary buffer to store rings in */
>   	i = max_t(int, adapter->num_tx_queues + adapter->num_xdp_queues,
>   		  adapter->num_rx_queues);
> -	temp_ring = vmalloc(array_size(i, sizeof(struct ixgbe_ring)));
> +	temp_ring = vmalloc_array(i, sizeof(struct ixgbe_ring));
>   
>   	if (!temp_ring) {
>   		err = -ENOMEM;
> diff --git a/drivers/net/ethernet/intel/ixgbevf/ethtool.c b/drivers/net/ethernet/intel/ixgbevf/ethtool.c
> index 7ac53171b041..bebad564188e 100644
> --- a/drivers/net/ethernet/intel/ixgbevf/ethtool.c
> +++ b/drivers/net/ethernet/intel/ixgbevf/ethtool.c
> @@ -276,9 +276,9 @@ static int ixgbevf_set_ringparam(struct net_device *netdev,
>   	}
>   
>   	if (new_tx_count != adapter->tx_ring_count) {
> -		tx_ring = vmalloc(array_size(sizeof(*tx_ring),
> -					     adapter->num_tx_queues +
> -						adapter->num_xdp_queues));
> +		tx_ring = vmalloc_array(adapter->num_tx_queues +
> +					adapter->num_xdp_queues,
> +					sizeof(*tx_ring));
>   		if (!tx_ring) {
>   			err = -ENOMEM;
>   			goto clear_reset;

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

