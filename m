Return-Path: <bpf+bounces-43195-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F8E9B134B
	for <lists+bpf@lfdr.de>; Sat, 26 Oct 2024 01:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0633C2838A4
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 23:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78054200C91;
	Fri, 25 Oct 2024 23:33:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from trager.us (trager.us [52.5.81.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CF9157E99;
	Fri, 25 Oct 2024 23:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.5.81.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729899238; cv=none; b=WhWbDZmtXyNyGAf5m1kQZoBxSyIJvVEJjChWDGK5uJ+pHxPxck+4me/X7/SaY9GhIlTjm84BeU1EuMRm9Y4ledXBMZ4Nlc6iGpwEDdQqLgYGq6I7x68vzrIM+ddJcHCY5cwKLCvUKoCyQnpRYUack0wqiVsa1A25VkAq4Ho8A5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729899238; c=relaxed/simple;
	bh=x1Gam1cUgRZUSYLtAOC1R/8avqGuEZaMFalCzVzgqjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UIkEEZqESJuDrMIRNs1X8ML/8p7amQcOqGPKutj5jM7lezudJe2x9Kkt3xXWsZI51unXx8so5bwwHBAApd0qulBYrPXPSz4lt5+nOb5ZXSIuKoTseENVjaEnb+hH7eXWw/FGfrsqjAT/zef6UYm4meM8KMUlwCaD2K+cxsS+OcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trager.us; spf=pass smtp.mailfrom=trager.us; arc=none smtp.client-ip=52.5.81.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trager.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trager.us
Received: from c-76-104-255-50.hsd1.wa.comcast.net ([76.104.255.50] helo=[192.168.1.226])
	by trager.us with esmtpsa (TLSv1.3:TLS_AES_128_GCM_SHA256:128)
	(Exim 4.92.3)
	(envelope-from <lee@trager.us>)
	id 1t4ToW-0002GO-P3; Fri, 25 Oct 2024 23:33:52 +0000
Message-ID: <597a68d6-2314-47a0-af9f-138e46387978@trager.us>
Date: Fri, 25 Oct 2024 16:33:45 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 net-next] net: freescale: use ethtool string helpers
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 "moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)"
 <bpf@vger.kernel.org>
References: <20241025203757.288367-1-rosenp@gmail.com>
Content-Language: en-US
From: Lee Trager <lee@trager.us>
In-Reply-To: <20241025203757.288367-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Cleans things up nicely :)

Reviewed-by: Lee Trager <lee@trager.us>

On 10/25/24 1:37 PM, Rosen Penev wrote:
> The latter is the preferred way to copy ethtool strings.
>
> Avoids manually incrementing the pointer. Cleans up the code quite well.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>   v2: fix wrong variable in for loop
>   .../ethernet/freescale/dpaa/dpaa_ethtool.c    | 40 ++++++-------------
>   .../ethernet/freescale/dpaa2/dpaa2-ethtool.c  | 15 +++----
>   .../net/ethernet/freescale/dpaa2/dpaa2-mac.c  |  9 ++---
>   .../net/ethernet/freescale/dpaa2/dpaa2-mac.h  |  2 +-
>   .../freescale/dpaa2/dpaa2-switch-ethtool.c    |  9 ++---
>   .../ethernet/freescale/enetc/enetc_ethtool.c  | 35 +++++-----------
>   .../net/ethernet/freescale/gianfar_ethtool.c  |  8 ++--
>   .../net/ethernet/freescale/ucc_geth_ethtool.c | 21 +++++-----
>   8 files changed, 51 insertions(+), 88 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c b/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
> index b0060cf96090..9986f6e1f587 100644
> --- a/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
> +++ b/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
> @@ -243,38 +243,24 @@ static void dpaa_get_ethtool_stats(struct net_device *net_dev,
>   static void dpaa_get_strings(struct net_device *net_dev, u32 stringset,
>   			     u8 *data)
>   {
> -	unsigned int i, j, num_cpus, size;
> -	char string_cpu[ETH_GSTRING_LEN];
> -	u8 *strings;
> +	unsigned int i, j, num_cpus;
>   
> -	memset(string_cpu, 0, sizeof(string_cpu));
> -	strings   = data;
> -	num_cpus  = num_online_cpus();
> -	size      = DPAA_STATS_GLOBAL_LEN * ETH_GSTRING_LEN;
> +	num_cpus = num_online_cpus();
>   
>   	for (i = 0; i < DPAA_STATS_PERCPU_LEN; i++) {
> -		for (j = 0; j < num_cpus; j++) {
> -			snprintf(string_cpu, ETH_GSTRING_LEN, "%s [CPU %d]",
> -				 dpaa_stats_percpu[i], j);
> -			memcpy(strings, string_cpu, ETH_GSTRING_LEN);
> -			strings += ETH_GSTRING_LEN;
> -		}
> -		snprintf(string_cpu, ETH_GSTRING_LEN, "%s [TOTAL]",
> -			 dpaa_stats_percpu[i]);
> -		memcpy(strings, string_cpu, ETH_GSTRING_LEN);
> -		strings += ETH_GSTRING_LEN;
> -	}
> -	for (j = 0; j < num_cpus; j++) {
> -		snprintf(string_cpu, ETH_GSTRING_LEN,
> -			 "bpool [CPU %d]", j);
> -		memcpy(strings, string_cpu, ETH_GSTRING_LEN);
> -		strings += ETH_GSTRING_LEN;
> +		for (j = 0; j < num_cpus; j++)
> +			ethtool_sprintf(&data, "%s [CPU %d]",
> +					dpaa_stats_percpu[i], j);
> +
> +		ethtool_sprintf(&data, "%s [TOTAL]", dpaa_stats_percpu[i]);
>   	}
> -	snprintf(string_cpu, ETH_GSTRING_LEN, "bpool [TOTAL]");
> -	memcpy(strings, string_cpu, ETH_GSTRING_LEN);
> -	strings += ETH_GSTRING_LEN;
> +	for (i = 0; i < num_cpus; i++)
> +		ethtool_sprintf(&data, "bpool [CPU %d]", i);
> +
> +	ethtool_puts(&data, "bpool [TOTAL]");
>   
> -	memcpy(strings, dpaa_stats_global, size);
> +	for (i = 0; i < DPAA_STATS_GLOBAL_LEN; i++)
> +		ethtool_puts(&data, dpaa_stats_global[i]);
>   }
>   
>   static int dpaa_get_hash_opts(struct net_device *dev,
> diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-ethtool.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-ethtool.c
> index 7f476519b7ad..74ef77cb7078 100644
> --- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-ethtool.c
> +++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-ethtool.c
> @@ -217,20 +217,15 @@ static int dpaa2_eth_set_pauseparam(struct net_device *net_dev,
>   static void dpaa2_eth_get_strings(struct net_device *netdev, u32 stringset,
>   				  u8 *data)
>   {
> -	u8 *p = data;
>   	int i;
>   
>   	switch (stringset) {
>   	case ETH_SS_STATS:
> -		for (i = 0; i < DPAA2_ETH_NUM_STATS; i++) {
> -			strscpy(p, dpaa2_ethtool_stats[i], ETH_GSTRING_LEN);
> -			p += ETH_GSTRING_LEN;
> -		}
> -		for (i = 0; i < DPAA2_ETH_NUM_EXTRA_STATS; i++) {
> -			strscpy(p, dpaa2_ethtool_extras[i], ETH_GSTRING_LEN);
> -			p += ETH_GSTRING_LEN;
> -		}
> -		dpaa2_mac_get_strings(p);
> +		for (i = 0; i < DPAA2_ETH_NUM_STATS; i++)
> +			ethtool_puts(&data, dpaa2_ethtool_stats[i]);
> +		for (i = 0; i < DPAA2_ETH_NUM_EXTRA_STATS; i++)
> +			ethtool_puts(&data, dpaa2_ethtool_extras[i]);
> +		dpaa2_mac_get_strings(&data);
>   		break;
>   	}
>   }
> diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
> index a69bb22c37ea..422ce13a7c94 100644
> --- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
> +++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
> @@ -558,15 +558,12 @@ int dpaa2_mac_get_sset_count(void)
>   	return DPAA2_MAC_NUM_STATS;
>   }
>   
> -void dpaa2_mac_get_strings(u8 *data)
> +void dpaa2_mac_get_strings(u8 **data)
>   {
> -	u8 *p = data;
>   	int i;
>   
> -	for (i = 0; i < DPAA2_MAC_NUM_STATS; i++) {
> -		strscpy(p, dpaa2_mac_ethtool_stats[i], ETH_GSTRING_LEN);
> -		p += ETH_GSTRING_LEN;
> -	}
> +	for (i = 0; i < DPAA2_MAC_NUM_STATS; i++)
> +		ethtool_puts(data, dpaa2_mac_ethtool_stats[i]);
>   }
>   
>   void dpaa2_mac_get_ethtool_stats(struct dpaa2_mac *mac, u64 *data)
> diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.h b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.h
> index c1ec9efd413a..53f8d106d11e 100644
> --- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.h
> +++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.h
> @@ -49,7 +49,7 @@ void dpaa2_mac_disconnect(struct dpaa2_mac *mac);
>   
>   int dpaa2_mac_get_sset_count(void);
>   
> -void dpaa2_mac_get_strings(u8 *data);
> +void dpaa2_mac_get_strings(u8 **data);
>   
>   void dpaa2_mac_get_ethtool_stats(struct dpaa2_mac *mac, u64 *data);
>   
> diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-ethtool.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-ethtool.c
> index 6bc1988be311..a888f6e6e9b0 100644
> --- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-ethtool.c
> +++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-ethtool.c
> @@ -170,17 +170,16 @@ dpaa2_switch_ethtool_get_sset_count(struct net_device *netdev, int sset)
>   static void dpaa2_switch_ethtool_get_strings(struct net_device *netdev,
>   					     u32 stringset, u8 *data)
>   {
> -	u8 *p = data;
> +	const char *str;
>   	int i;
>   
>   	switch (stringset) {
>   	case ETH_SS_STATS:
>   		for (i = 0; i < DPAA2_SWITCH_NUM_COUNTERS; i++) {
> -			memcpy(p, dpaa2_switch_ethtool_counters[i].name,
> -			       ETH_GSTRING_LEN);
> -			p += ETH_GSTRING_LEN;
> +			str = dpaa2_switch_ethtool_counters[i].name;
> +			ethtool_puts(&data, str);
>   		}
> -		dpaa2_mac_get_strings(p);
> +		dpaa2_mac_get_strings(&data);
>   		break;
>   	}
>   }
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
> index 2563eb8ac7b6..e1745b89362d 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
> @@ -247,38 +247,25 @@ static int enetc_get_sset_count(struct net_device *ndev, int sset)
>   static void enetc_get_strings(struct net_device *ndev, u32 stringset, u8 *data)
>   {
>   	struct enetc_ndev_priv *priv = netdev_priv(ndev);
> -	u8 *p = data;
>   	int i, j;
>   
>   	switch (stringset) {
>   	case ETH_SS_STATS:
> -		for (i = 0; i < ARRAY_SIZE(enetc_si_counters); i++) {
> -			strscpy(p, enetc_si_counters[i].name, ETH_GSTRING_LEN);
> -			p += ETH_GSTRING_LEN;
> -		}
> -		for (i = 0; i < priv->num_tx_rings; i++) {
> -			for (j = 0; j < ARRAY_SIZE(tx_ring_stats); j++) {
> -				snprintf(p, ETH_GSTRING_LEN, tx_ring_stats[j],
> -					 i);
> -				p += ETH_GSTRING_LEN;
> -			}
> -		}
> -		for (i = 0; i < priv->num_rx_rings; i++) {
> -			for (j = 0; j < ARRAY_SIZE(rx_ring_stats); j++) {
> -				snprintf(p, ETH_GSTRING_LEN, rx_ring_stats[j],
> -					 i);
> -				p += ETH_GSTRING_LEN;
> -			}
> -		}
> +		for (i = 0; i < ARRAY_SIZE(enetc_si_counters); i++)
> +			ethtool_puts(&data, enetc_si_counters[i].name);
> +		for (i = 0; i < priv->num_tx_rings; i++)
> +			for (j = 0; j < ARRAY_SIZE(tx_ring_stats); j++)
> +				ethtool_sprintf(&data, tx_ring_stats[j], i);
> +		for (i = 0; i < priv->num_rx_rings; i++)
> +			for (j = 0; j < ARRAY_SIZE(rx_ring_stats); j++)
> +				ethtool_sprintf(&data, rx_ring_stats[j], i);
>   
>   		if (!enetc_si_is_pf(priv->si))
>   			break;
>   
> -		for (i = 0; i < ARRAY_SIZE(enetc_port_counters); i++) {
> -			strscpy(p, enetc_port_counters[i].name,
> -				ETH_GSTRING_LEN);
> -			p += ETH_GSTRING_LEN;
> -		}
> +		for (i = 0; i < ARRAY_SIZE(enetc_port_counters); i++)
> +			ethtool_puts(&data, enetc_port_counters[i].name);
> +
>   		break;
>   	}
>   }
> diff --git a/drivers/net/ethernet/freescale/gianfar_ethtool.c b/drivers/net/ethernet/freescale/gianfar_ethtool.c
> index a99b95c4bcfb..781d92e703cb 100644
> --- a/drivers/net/ethernet/freescale/gianfar_ethtool.c
> +++ b/drivers/net/ethernet/freescale/gianfar_ethtool.c
> @@ -115,12 +115,14 @@ static const char stat_gstrings[][ETH_GSTRING_LEN] = {
>   static void gfar_gstrings(struct net_device *dev, u32 stringset, u8 * buf)
>   {
>   	struct gfar_private *priv = netdev_priv(dev);
> +	int i;
>   
>   	if (priv->device_flags & FSL_GIANFAR_DEV_HAS_RMON)
> -		memcpy(buf, stat_gstrings, GFAR_STATS_LEN * ETH_GSTRING_LEN);
> +		for (i = 0; i < GFAR_STATS_LEN; i++)
> +			ethtool_puts(&buf, stat_gstrings[i]);
>   	else
> -		memcpy(buf, stat_gstrings,
> -		       GFAR_EXTRA_STATS_LEN * ETH_GSTRING_LEN);
> +		for (i = 0; i < GFAR_EXTRA_STATS_LEN; i++)
> +			ethtool_puts(&buf, stat_gstrings[i]);
>   }
>   
>   /* Fill in an array of 64-bit statistics from various sources.
> diff --git a/drivers/net/ethernet/freescale/ucc_geth_ethtool.c b/drivers/net/ethernet/freescale/ucc_geth_ethtool.c
> index 601beb93d3b3..699f346faf5c 100644
> --- a/drivers/net/ethernet/freescale/ucc_geth_ethtool.c
> +++ b/drivers/net/ethernet/freescale/ucc_geth_ethtool.c
> @@ -287,20 +287,17 @@ static void uec_get_strings(struct net_device *netdev, u32 stringset, u8 *buf)
>   {
>   	struct ucc_geth_private *ugeth = netdev_priv(netdev);
>   	u32 stats_mode = ugeth->ug_info->statisticsMode;
> +	int i;
>   
> -	if (stats_mode & UCC_GETH_STATISTICS_GATHERING_MODE_HARDWARE) {
> -		memcpy(buf, hw_stat_gstrings, UEC_HW_STATS_LEN *
> -			       	ETH_GSTRING_LEN);
> -		buf += UEC_HW_STATS_LEN * ETH_GSTRING_LEN;
> -	}
> -	if (stats_mode & UCC_GETH_STATISTICS_GATHERING_MODE_FIRMWARE_TX) {
> -		memcpy(buf, tx_fw_stat_gstrings, UEC_TX_FW_STATS_LEN *
> -			       	ETH_GSTRING_LEN);
> -		buf += UEC_TX_FW_STATS_LEN * ETH_GSTRING_LEN;
> -	}
> +	if (stats_mode & UCC_GETH_STATISTICS_GATHERING_MODE_HARDWARE)
> +		for (i = 0; i < UEC_HW_STATS_LEN; i++)
> +			ethtool_puts(&buf, hw_stat_gstrings[i]);
> +	if (stats_mode & UCC_GETH_STATISTICS_GATHERING_MODE_FIRMWARE_TX)
> +		for (i = 0; i < UEC_TX_FW_STATS_LEN; i++)
> +			ethtool_puts(&buf, tx_fw_stat_gstrings[i]);
>   	if (stats_mode & UCC_GETH_STATISTICS_GATHERING_MODE_FIRMWARE_RX)
> -		memcpy(buf, rx_fw_stat_gstrings, UEC_RX_FW_STATS_LEN *
> -			       	ETH_GSTRING_LEN);
> +		for (i = 0; i < UEC_RX_FW_STATS_LEN; i++)
> +			ethtool_puts(&buf, rx_fw_stat_gstrings[i]);
>   }
>   
>   static void uec_get_ethtool_stats(struct net_device *netdev,

