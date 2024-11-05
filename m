Return-Path: <bpf+bounces-44025-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F17A79BC98E
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 10:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1D432831F8
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 09:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555901D0F5F;
	Tue,  5 Nov 2024 09:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jf01UEFI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15A0163;
	Tue,  5 Nov 2024 09:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730800141; cv=none; b=QcSyDUlQrJVEtcNqTzTY+lk0CQXXMJIt5uKfGtE+1Q240ct87I16KzdUSqFBD9ST6UqorWUm5BjuP0Pa91YgeEWTfGR7cZonCJfTMaR6I4fCAUSheB+wPKo8Okc5c0ZQednFpY/TaBgNOAynTMV/AZ8WWtMnLwgv3G874yvHurQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730800141; c=relaxed/simple;
	bh=zxM5hAERtAB7gMIJ084EOz6L37mhY4koGGPbkVTQwTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XCTFLdf45qZGxgCd3AZdJ7hCGklxfXaGYHEXXIGWgGgjcRcug/x3dT9Z/LNyimtXHsH7icRaUKdiE4nrPd0z4GFXgUyhUTwZC2x4cR3SEFng9Icqh0xDsXM79WtNBqt1ttHDm8kVSsgIJmYcjajHsuqcJc6yR/LiqaUauRpT+JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jf01UEFI; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-431688d5127so41474635e9.0;
        Tue, 05 Nov 2024 01:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730800138; x=1731404938; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/w0WpjPEcium9zbrSap5bfYNsTXqLhqroWKQsTECXKM=;
        b=Jf01UEFILvaSvF3q7Zbq7gqZ7Pm3Ckdx/bU7fy2oM7/zF9h4evT2uliMO7PbLPqq0z
         FOjORE2KidYWBMFSyTCI4lY53g0zn1dQxjIeoEWka1C9Yv/WDmMB1kluHSjJb1viquHu
         qesS5pEPYLcYaHX+zsEPaYMoOvQhz5RBUBANPTc7US72dWSqMJopxWujZLBXGWfEy4u4
         ScmS/405KVS0u03UiSaIc8r7tjhrn6Lf8yZnJzoSsHtpaxoHQWNv+FrT+Mg/O3Tger50
         oGGMOQ8Wn8EjIBC9L2mlmLB+FnllutSituYF6FCU9BU85Wu4PbUfG4kpBrFn72+H2kVw
         pgjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730800138; x=1731404938;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/w0WpjPEcium9zbrSap5bfYNsTXqLhqroWKQsTECXKM=;
        b=fvE1IkWCjOO+Qhds6W8j6uu2Hp1sMycB6yho5R4i7uLQRmg028jv86w74n8J2XxlID
         D6Po4YuQXGwZ6YGgQ892nxbNMAEtlx5ZdG/Xa72+CIg5DFJsyGuOMANhK4e1pbOPPZ5E
         o4gDOCoYLTpnG45OH6p+J1OEmVejYcOD4dz0VkGYfsxqJ4vG/3GcY/SJgPn8cfpL9ynj
         CqVLsn3XNCL+7WiDrhFkh0Ek9GlAFwSQGZPPWQkv/cX7leLDLY2wkXKKZRbucvSHG3EB
         0nWU4GlvjGKIseML1LXfkFKFeeZBom6tO5FXPtfNn1idR0nRmUerCrfxuUGKNxYzy2mM
         vKAw==
X-Forwarded-Encrypted: i=1; AJvYcCWDbwEgdqqgM9wySB0YLJUD4CyBQlF1kL5045MGk8BuaeryMID7LPPM3EAZn4hEloNoaFjN/b65YX6HDaAs@vger.kernel.org, AJvYcCWM+fF1NQ6Dr9ljRkpPFl/eL6H3dItDzon35h/16S0wuXjS/CWLjU2cs0LA/hQuQTD9k1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaxF6q3q82pYjyKpQoKKSjnrICW8xDKA6TuajU96tKGS98hgmk
	vVPeh9+feK1a90hAB6W/QZqcOqEV0E9vW/2KAAVybhSPE3Hd+TL+p3bQZMXL
X-Google-Smtp-Source: AGHT+IHNmm2Ntw2+Ap6scTGTnQ8hpTqJZM/Tmkm9xYM7ujAthDKd3FDJ7+/j/s7g3RD+WvheukC5Yg==
X-Received: by 2002:a05:600c:19c8:b0:430:54a4:5b03 with SMTP id 5b1f17b1804b1-4319ac6fad6mr279878385e9.6.1730800137880;
        Tue, 05 Nov 2024 01:48:57 -0800 (PST)
Received: from localhost ([81.168.73.77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd9ca6f8sm211157835e9.39.2024.11.05.01.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 01:48:56 -0800 (PST)
Date: Tue, 5 Nov 2024 09:48:55 +0000
From: Martin Habets <habetsm.xilinx@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Edward Cree <ecree.xilinx@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	"open list:SFC NETWORK DRIVER" <linux-net-drivers@amd.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next] net: sfc: use ethtool string helpers
Message-ID: <20241105094855.GE595392@gmail.com>
Mail-Followup-To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org,
	Edward Cree <ecree.xilinx@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	"open list:SFC NETWORK DRIVER" <linux-net-drivers@amd.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>
References: <20241104202705.120939-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104202705.120939-1-rosenp@gmail.com>

On Mon, Nov 04, 2024 at 12:27:05PM -0800, Rosen Penev wrote:
> 
> The latter is the preferred way to copy ethtool strings.
> 
> Avoids manually incrementing the pointer. Cleans up the code quite well.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/net/ethernet/sfc/ethtool_common.c     | 34 +++++++------------
>  drivers/net/ethernet/sfc/falcon/ethtool.c     | 24 +++++--------
>  drivers/net/ethernet/sfc/falcon/nic.c         |  7 ++--
>  drivers/net/ethernet/sfc/nic.c                |  7 ++--
>  .../net/ethernet/sfc/siena/ethtool_common.c   | 34 +++++++------------
>  drivers/net/ethernet/sfc/siena/nic.c          |  7 ++--
>  6 files changed, 40 insertions(+), 73 deletions(-)
> 
> diff --git a/drivers/net/ethernet/sfc/ethtool_common.c b/drivers/net/ethernet/sfc/ethtool_common.c
> index ae32e08540fa..d46972f45ec1 100644
> --- a/drivers/net/ethernet/sfc/ethtool_common.c
> +++ b/drivers/net/ethernet/sfc/ethtool_common.c
> @@ -403,24 +403,19 @@ static size_t efx_describe_per_queue_stats(struct efx_nic *efx, u8 *strings)
>  	efx_for_each_channel(channel, efx) {
>  		if (efx_channel_has_tx_queues(channel)) {
>  			n_stats++;
> -			if (strings != NULL) {
> -				snprintf(strings, ETH_GSTRING_LEN,
> -					 "tx-%u.tx_packets",
> -					 channel->tx_queue[0].queue /
> -					 EFX_MAX_TXQ_PER_CHANNEL);
> -
> -				strings += ETH_GSTRING_LEN;
> -			}
> +			if (strings)
> +				ethtool_sprintf(
> +					&strings, "tx-%u.tx_packets",

This still fits after the opening parentheses above within 80 characters.
I would prefer that style.

Martin

> +					channel->tx_queue[0].queue /
> +						EFX_MAX_TXQ_PER_CHANNEL);
>  		}
>  	}
>  	efx_for_each_channel(channel, efx) {
>  		if (efx_channel_has_rx_queue(channel)) {
>  			n_stats++;
> -			if (strings != NULL) {
> -				snprintf(strings, ETH_GSTRING_LEN,
> -					 "rx-%d.rx_packets", channel->channel);
> -				strings += ETH_GSTRING_LEN;
> -			}
> +			if (strings)
> +				ethtool_sprintf(&strings, "rx-%d.rx_packets",
> +						channel->channel);
>  		}
>  	}
>  	if (efx->xdp_tx_queue_count && efx->xdp_tx_queues) {
> @@ -428,11 +423,10 @@ static size_t efx_describe_per_queue_stats(struct efx_nic *efx, u8 *strings)
>  
>  		for (xdp = 0; xdp < efx->xdp_tx_queue_count; xdp++) {
>  			n_stats++;
> -			if (strings) {
> -				snprintf(strings, ETH_GSTRING_LEN,
> -					 "tx-xdp-cpu-%hu.tx_packets", xdp);
> -				strings += ETH_GSTRING_LEN;
> -			}
> +			if (strings)
> +				ethtool_sprintf(&strings,
> +						"tx-xdp-cpu-%hu.tx_packets",
> +						xdp);
>  		}
>  	}
>  
> @@ -467,9 +461,7 @@ void efx_ethtool_get_strings(struct net_device *net_dev,
>  		strings += (efx->type->describe_stats(efx, strings) *
>  			    ETH_GSTRING_LEN);
>  		for (i = 0; i < EFX_ETHTOOL_SW_STAT_COUNT; i++)
> -			strscpy(strings + i * ETH_GSTRING_LEN,
> -				efx_sw_stat_desc[i].name, ETH_GSTRING_LEN);
> -		strings += EFX_ETHTOOL_SW_STAT_COUNT * ETH_GSTRING_LEN;
> +			ethtool_puts(&strings, efx_sw_stat_desc[i].name);
>  		strings += (efx_describe_per_queue_stats(efx, strings) *
>  			    ETH_GSTRING_LEN);
>  		efx_ptp_describe_stats(efx, strings);
> diff --git a/drivers/net/ethernet/sfc/falcon/ethtool.c b/drivers/net/ethernet/sfc/falcon/ethtool.c
> index f4db683b80f7..41bd63d0c40c 100644
> --- a/drivers/net/ethernet/sfc/falcon/ethtool.c
> +++ b/drivers/net/ethernet/sfc/falcon/ethtool.c
> @@ -361,24 +361,18 @@ static size_t ef4_describe_per_queue_stats(struct ef4_nic *efx, u8 *strings)
>  	ef4_for_each_channel(channel, efx) {
>  		if (ef4_channel_has_tx_queues(channel)) {
>  			n_stats++;
> -			if (strings != NULL) {
> -				snprintf(strings, ETH_GSTRING_LEN,
> -					 "tx-%u.tx_packets",
> -					 channel->tx_queue[0].queue /
> -					 EF4_TXQ_TYPES);
> -
> -				strings += ETH_GSTRING_LEN;
> -			}
> +			if (strings)
> +				ethtool_sprintf(&strings, "tx-%u.tx_packets",
> +						channel->tx_queue[0].queue /
> +							EF4_TXQ_TYPES);
>  		}
>  	}
>  	ef4_for_each_channel(channel, efx) {
>  		if (ef4_channel_has_rx_queue(channel)) {
>  			n_stats++;
> -			if (strings != NULL) {
> -				snprintf(strings, ETH_GSTRING_LEN,
> -					 "rx-%d.rx_packets", channel->channel);
> -				strings += ETH_GSTRING_LEN;
> -			}
> +			if (strings)
> +				ethtool_sprintf(&strings, "rx-%d.rx_packets",
> +						channel->channel);
>  		}
>  	}
>  	return n_stats;
> @@ -412,9 +406,7 @@ static void ef4_ethtool_get_strings(struct net_device *net_dev,
>  		strings += (efx->type->describe_stats(efx, strings) *
>  			    ETH_GSTRING_LEN);
>  		for (i = 0; i < EF4_ETHTOOL_SW_STAT_COUNT; i++)
> -			strscpy(strings + i * ETH_GSTRING_LEN,
> -				ef4_sw_stat_desc[i].name, ETH_GSTRING_LEN);
> -		strings += EF4_ETHTOOL_SW_STAT_COUNT * ETH_GSTRING_LEN;
> +			ethtool_puts(&strings, ef4_sw_stat_desc[i].name);
>  		strings += (ef4_describe_per_queue_stats(efx, strings) *
>  			    ETH_GSTRING_LEN);
>  		break;
> diff --git a/drivers/net/ethernet/sfc/falcon/nic.c b/drivers/net/ethernet/sfc/falcon/nic.c
> index 78c851b5a56f..a7f0caa8710f 100644
> --- a/drivers/net/ethernet/sfc/falcon/nic.c
> +++ b/drivers/net/ethernet/sfc/falcon/nic.c
> @@ -451,11 +451,8 @@ size_t ef4_nic_describe_stats(const struct ef4_hw_stat_desc *desc, size_t count,
>  
>  	for_each_set_bit(index, mask, count) {
>  		if (desc[index].name) {
> -			if (names) {
> -				strscpy(names, desc[index].name,
> -					ETH_GSTRING_LEN);
> -				names += ETH_GSTRING_LEN;
> -			}
> +			if (names)
> +				ethtool_puts(&names, desc[index].name);
>  			++visible;
>  		}
>  	}
> diff --git a/drivers/net/ethernet/sfc/nic.c b/drivers/net/ethernet/sfc/nic.c
> index a33ed473cc8a..51c975cff4fe 100644
> --- a/drivers/net/ethernet/sfc/nic.c
> +++ b/drivers/net/ethernet/sfc/nic.c
> @@ -306,11 +306,8 @@ size_t efx_nic_describe_stats(const struct efx_hw_stat_desc *desc, size_t count,
>  
>  	for_each_set_bit(index, mask, count) {
>  		if (desc[index].name) {
> -			if (names) {
> -				strscpy(names, desc[index].name,
> -					ETH_GSTRING_LEN);
> -				names += ETH_GSTRING_LEN;
> -			}
> +			if (names)
> +				ethtool_puts(&names, desc[index].name);
>  			++visible;
>  		}
>  	}
> diff --git a/drivers/net/ethernet/sfc/siena/ethtool_common.c b/drivers/net/ethernet/sfc/siena/ethtool_common.c
> index 075fef64de68..53b1cdf872d8 100644
> --- a/drivers/net/ethernet/sfc/siena/ethtool_common.c
> +++ b/drivers/net/ethernet/sfc/siena/ethtool_common.c
> @@ -403,24 +403,19 @@ static size_t efx_describe_per_queue_stats(struct efx_nic *efx, u8 *strings)
>  	efx_for_each_channel(channel, efx) {
>  		if (efx_channel_has_tx_queues(channel)) {
>  			n_stats++;
> -			if (strings != NULL) {
> -				snprintf(strings, ETH_GSTRING_LEN,
> -					 "tx-%u.tx_packets",
> -					 channel->tx_queue[0].queue /
> -					 EFX_MAX_TXQ_PER_CHANNEL);
> -
> -				strings += ETH_GSTRING_LEN;
> -			}
> +			if (strings)
> +				ethtool_sprintf(
> +					&strings, "tx-%u.tx_packets",
> +					channel->tx_queue[0].queue /
> +						EFX_MAX_TXQ_PER_CHANNEL);
>  		}
>  	}
>  	efx_for_each_channel(channel, efx) {
>  		if (efx_channel_has_rx_queue(channel)) {
>  			n_stats++;
> -			if (strings != NULL) {
> -				snprintf(strings, ETH_GSTRING_LEN,
> -					 "rx-%d.rx_packets", channel->channel);
> -				strings += ETH_GSTRING_LEN;
> -			}
> +			if (strings)
> +				ethtool_sprintf(&strings, "rx-%d.rx_packets",
> +						channel->channel);
>  		}
>  	}
>  	if (efx->xdp_tx_queue_count && efx->xdp_tx_queues) {
> @@ -428,11 +423,10 @@ static size_t efx_describe_per_queue_stats(struct efx_nic *efx, u8 *strings)
>  
>  		for (xdp = 0; xdp < efx->xdp_tx_queue_count; xdp++) {
>  			n_stats++;
> -			if (strings) {
> -				snprintf(strings, ETH_GSTRING_LEN,
> -					 "tx-xdp-cpu-%hu.tx_packets", xdp);
> -				strings += ETH_GSTRING_LEN;
> -			}
> +			if (strings)
> +				ethtool_sprintf(&strings,
> +						"tx-xdp-cpu-%hu.tx_packets",
> +						xdp);
>  		}
>  	}
>  
> @@ -467,9 +461,7 @@ void efx_siena_ethtool_get_strings(struct net_device *net_dev,
>  		strings += (efx->type->describe_stats(efx, strings) *
>  			    ETH_GSTRING_LEN);
>  		for (i = 0; i < EFX_ETHTOOL_SW_STAT_COUNT; i++)
> -			strscpy(strings + i * ETH_GSTRING_LEN,
> -				efx_sw_stat_desc[i].name, ETH_GSTRING_LEN);
> -		strings += EFX_ETHTOOL_SW_STAT_COUNT * ETH_GSTRING_LEN;
> +			ethtool_puts(&strings, efx_sw_stat_desc[i].name);
>  		strings += (efx_describe_per_queue_stats(efx, strings) *
>  			    ETH_GSTRING_LEN);
>  		efx_siena_ptp_describe_stats(efx, strings);
> diff --git a/drivers/net/ethernet/sfc/siena/nic.c b/drivers/net/ethernet/sfc/siena/nic.c
> index 0ea0433a6230..06b97218b490 100644
> --- a/drivers/net/ethernet/sfc/siena/nic.c
> +++ b/drivers/net/ethernet/sfc/siena/nic.c
> @@ -457,11 +457,8 @@ size_t efx_siena_describe_stats(const struct efx_hw_stat_desc *desc, size_t coun
>  
>  	for_each_set_bit(index, mask, count) {
>  		if (desc[index].name) {
> -			if (names) {
> -				strscpy(names, desc[index].name,
> -					ETH_GSTRING_LEN);
> -				names += ETH_GSTRING_LEN;
> -			}
> +			if (names)
> +				ethtool_puts(&names, desc[index].name);
>  			++visible;
>  		}
>  	}
> -- 
> 2.47.0
> 

