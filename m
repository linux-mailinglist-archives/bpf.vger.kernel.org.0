Return-Path: <bpf+bounces-47044-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DB89F354B
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 17:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 693FD18888D0
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 16:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17EB9205507;
	Mon, 16 Dec 2024 16:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVEhgTF6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAA5192B70;
	Mon, 16 Dec 2024 16:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734365120; cv=none; b=fSgHxnzJZj86tZpIhAdUg+ZdS3Ma+vLu9yPnDgJARwCDjIhAmS8e7rclsgwaA6nBCpQ3fVWzSsJp+irlgpQdBfEntp2DMEcRS0zXAzCdi2CjEWvnVkXf51ZStOG9Q4A8SAgnCHRFwwOPw+jdJGKYHWFWMpim4pMHvAHIXyusZGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734365120; c=relaxed/simple;
	bh=hwAuvErfSFn0MWdhGQXJs8ZXEJYf1uVrAWPyWrNJ5a4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oo7VnAH5OhAfaNPxUfu+DHvzXlkw9si2bQvu1W27kGiAn2epYkipeaacb0VRghOL9yQZm/3nAzV4J+Y2ofnhV2Xk9pMagtIu69Gqq+6+7Ltg8KuEmFUFURUflxtx0v9gUPsH7Gno5ZtLin/a2ziYk3j0txIyV/WqRfH4Uf7OFYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DVEhgTF6; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43616c12d72so5809025e9.2;
        Mon, 16 Dec 2024 08:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734365117; x=1734969917; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dG99stxxx20DSdS/lbls1Jk7NIYbcNyenoZoJZYfN7g=;
        b=DVEhgTF6IBmMD8PWaNNmJa0EdxuVbOs/QqpqkW0+XrIMBE6zOW3zTHM5amSqSfoS+N
         yBuU315uauIUXJGwv7/kchHtBpz3OKUGsDESFMMWGVsE34bZ0M+dRel54wtNEc9EDM+y
         751h7Z7nrmEEF1JJ7PHwVGlqZ2rhRjmIlBus8lO3NuqZDNCnjAJxKJupJS2NAPZlLWgi
         06Mf0ax4gJnSBL8FPAPJswDYjxHbF8XGn6Nf23BAzDiLvUuGcouLFsyrsOXWXXk3b9tq
         Kxk1/UWIJwytffNvr+z+01PHqrErKg4ASEj2JqaSs0xfxjWvPiUzJP1zp4tZRCZqMCpk
         8zqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734365117; x=1734969917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dG99stxxx20DSdS/lbls1Jk7NIYbcNyenoZoJZYfN7g=;
        b=jhhm6PZys1yIclkFhxdZMGcINA0Sy3iYWW2e2TQO5I+y6gxWafm0WgGjKTPLlF0xY1
         jg3DBAYWnW+t0ni2fwZEdhdaI8U8A/a6rX52myNag8c9tXm3LBO3tBrfyXu7plKGFesu
         B6dvK9zRx2kS4H6j45qlRoaRPb7gfhYkzfbHksNldHt3A4FPQJT2yVOn8fCsu3kRuHKq
         yA+vlckP0c9mLLzxvkUN9gTCs0ChsmxiOX5tiOQYCeyUz4UpmR6P8OlTAsxo6mRpBV8/
         au5WcH5/Ehyq8Wt8QX8SKx2c+hz5aOmDokFMVNDvvhCYG3LLD32M/rKlDjyslFw3CnGg
         Z5Dw==
X-Forwarded-Encrypted: i=1; AJvYcCV4freUIH3RHhwB0uhjPufIWyPmhHjyOo7rX2Rd+SV25YQ3O8GAKvecSU336Oh9anhOAp8D8dyM04MHUbFO@vger.kernel.org, AJvYcCVflaCyORttZZX6aV+bQjG25NCyOBIqJkvSLTtpsixKvaCzAg1Uo085k+fhfMHGLiWXQ8s=@vger.kernel.org, AJvYcCWr2mzO8/Hn6nDuJcm66H7kbdNhejYPVmiLpK38lX+ygi3N26mEMqWaHgX6FmtIZQzTNj/n2qFU@vger.kernel.org
X-Gm-Message-State: AOJu0YyDhAxi/rNFnUzhUcuZf0PW166D1JQU+hNwtKwgE61aDiXRZY42
	d9kYEGlKeK9QeCENFK5nA0u2oDMjY2+qfhMN9tfHVedDN4Zud8my3z7fecVe
X-Gm-Gg: ASbGncvJp8rnZ1jo7YLrvpat3CtMbZ4PzhUJd5b/lkU4oiW59lx2HyPminbFQWWnqIo
	JpQLV4wje/SagrgYF3TdG40s7r/BOTFnEsPkccEfQBbcGiL6X5sPS+4s2Cc5caPIxEhGvVekr40
	z+SX92olBoYso2RZfvUhflepZ4DYNoeLWyNUkuhpyaDYSj9B2rRhScwP+5ci4v10GOaGKFOkcbJ
	eS1SYmVwV3BN89y7V5QZZwX1SCXZZiwK5gYBfxfOuJ8
X-Google-Smtp-Source: AGHT+IHYj/tJTjJciBlbThZka3fht5do0jmD0uAVpuX39xUUzlLX6XnsjobX3DJLyFyd+Ta+kfQJDw==
X-Received: by 2002:a05:6000:1846:b0:37d:4aa2:5cfe with SMTP id ffacd0b85a97d-38880ac5c89mr4680766f8f.6.1734365116394;
        Mon, 16 Dec 2024 08:05:16 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436360159aasm88625815e9.6.2024.12.16.08.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 08:05:15 -0800 (PST)
Date: Mon, 16 Dec 2024 18:05:13 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH iwl-next 9/9] igc: Add support to get frame preemption
 statistics via ethtool
Message-ID: <20241216160513.24i4ehroff47iwzi@skbuf>
References: <20241216064720.931522-1-faizal.abdul.rahim@linux.intel.com>
 <20241216064720.931522-10-faizal.abdul.rahim@linux.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216064720.931522-10-faizal.abdul.rahim@linux.intel.com>

On Mon, Dec 16, 2024 at 01:47:20AM -0500, Faizal Rahim wrote:
> Implemented "ethtool --include-statistics --show-mm" callback for IGC.
> 
> Tested preemption scenario to check preemption statistics:
> 1) Trigger verification handshake on both boards:
>     $ sudo ethtool --set-mm enp1s0 pmac-enabled on
>     $ sudo ethtool --set-mm enp1s0 tx-enabled on
>     $ sudo ethtool --set-mm enp1s0 verify-enabled on
> 2) Set preemptible or express queue in taprio for tx board:
>     $ sudo tc qdisc replace dev enp1s0 parent root handle 100 taprio \
>       num_tc 4 map 0 1 2 3 0 0 0 0 0 0 0 0 0 0 0 0 \
>       queues 1@0 1@1 1@2 1@3 base-time 0 sched-entry S F 100000 \
>       fp E E P P

Hmm, the prio_tc_map pattern changed since the last time I looked at igc
examples? It was in decreasing order before? How do you handle backwards
compatibility with the Tx ring strict priority default configuration?
I haven't downloaded the entire set locally, will do so later.

> 3) Send large size packets on preemptible queue
> 4) Send small size packets on express queue to preempt packets in
>    preemptible queue
> 5) Show preemption statistics on the receiving board:
>    $ ethtool --include-statistics --show-mm enp1s0
>      MAC Merge layer state for enp1s0:
>      pMAC enabled: on
>      TX enabled: on
>      TX active: on
>      TX minimum fragment size: 252
>      RX minimum fragment size: 252
>      Verify enabled: on
>      Verify time: 128
>      Max verify time: 128
>      Verification status: SUCCEEDED
>      Statistics:
>      	MACMergeFrameAssErrorCount: 0
> 	MACMergeFrameSmdErrorCount: 0
> 	MACMergeFrameAssOkCount: 511
> 	MACMergeFragCountRx: 764
> 	MACMergeFragCountTx: 0
> 	MACMergeHoldCount: 0
> 
> Co-developed-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_ethtool.c | 40 ++++++++++++++++++++
>  drivers/net/ethernet/intel/igc/igc_regs.h    | 19 ++++++++++
>  2 files changed, 59 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> index 16aa6e4e1727..90a9dbb0d901 100644
> --- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
> +++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> @@ -1835,6 +1835,45 @@ static int igc_ethtool_set_mm(struct net_device *netdev,
>  	return igc_tsn_offload_apply(adapter);
>  }
>  
> +/**
> + * igc_ethtool_get_frame_ass_error - Get the frame assembly error count.
> + * @dev: Pointer to the net_device structure.
> + * @return: The count of frame assembly errors.

I may be wrong, but I think the syntax for kernel-doc is "Returns: "

> + */
> +static u64 igc_ethtool_get_frame_ass_error(struct net_device *dev)
> +{
> +	struct igc_adapter *adapter = netdev_priv(dev);
> +	u32 ooo_smdc, ooo_frame_cnt, ooo_frag_cnt; /* Out of order statistics */
> +	struct igc_hw *hw = &adapter->hw;
> +	u32 miss_frame_frag_cnt;
> +	u32 reg_value;
> +
> +	reg_value = rd32(IGC_PRMEXPRCNT);
> +	ooo_smdc = reg_value & IGC_PRMEXPRCNT_OOO_SMDC;
> +	ooo_frame_cnt = (reg_value & IGC_PRMEXPRCNT_OOO_FRAME_CNT)
> +			 >> IGC_PRMEXPRCNT_OOO_FRAME_CNT_SHIFT;
> +	ooo_frag_cnt = (reg_value & IGC_PRMEXPRCNT_OOO_FRAG_CNT)
> +			>> IGC_PRMEXPRCNT_OOO_FRAG_CNT_SHIFT;
> +	miss_frame_frag_cnt = (reg_value & IGC_PRMEXPRCNT_MISS_FRAME_FRAG_CNT)
> +			      >> IGC_PRMEXPRCNT_MISS_FRAME_FRAG_CNT_SHIFT;

Candidates for FIELD_GET()?

> +
> +	return ooo_smdc + ooo_frame_cnt + ooo_frag_cnt + miss_frame_frag_cnt;
> +}
> +
> +static void igc_ethtool_get_mm_stats(struct net_device *dev,
> +				     struct ethtool_mm_stats *stats)
> +{
> +	struct igc_adapter *adapter = netdev_priv(dev);
> +	struct igc_hw *hw = &adapter->hw;
> +
> +	stats->MACMergeFrameAssErrorCount = igc_ethtool_get_frame_ass_error(dev);
> +	stats->MACMergeFrameSmdErrorCount = 0; /* Not available in IGC */
> +	stats->MACMergeFrameAssOkCount = rd32(IGC_PRMPTDRCNT);
> +	stats->MACMergeFragCountRx =  rd32(IGC_PRMEVNTRCNT);
> +	stats->MACMergeFragCountTx = rd32(IGC_PRMEVNTTCNT);
> +	stats->MACMergeHoldCount = 0; /* Not available in IGC */

Don't report counters as zero when in reality you don't know.

Just don't assign values to these. mm_prepare_data() -> ethtool_stats_init()
presets them to 0xffffffffffffffff (ETHTOOL_STAT_NOT_SET), and
mm_put_stats() -> mm_put_stat() detects whether they are still equal to
this value, and if they are, does not report netlink attributes for them.

> +}
> +
>  static int igc_ethtool_get_link_ksettings(struct net_device *netdev,
>  					  struct ethtool_link_ksettings *cmd)
>  {
> @@ -2124,6 +2163,7 @@ static const struct ethtool_ops igc_ethtool_ops = {
>  	.get_channels		= igc_ethtool_get_channels,
>  	.get_mm			= igc_ethtool_get_mm,
>  	.set_mm			= igc_ethtool_set_mm,
> +	.get_mm_stats		= igc_ethtool_get_mm_stats,
>  	.set_channels		= igc_ethtool_set_channels,
>  	.get_priv_flags		= igc_ethtool_get_priv_flags,
>  	.set_priv_flags		= igc_ethtool_set_priv_flags,
> diff --git a/drivers/net/ethernet/intel/igc/igc_regs.h b/drivers/net/ethernet/intel/igc/igc_regs.h
> index 12ddc5793651..f40946cce35a 100644
> --- a/drivers/net/ethernet/intel/igc/igc_regs.h
> +++ b/drivers/net/ethernet/intel/igc/igc_regs.h
> @@ -222,6 +222,25 @@
>  
>  #define IGC_FTQF(_n)	(0x059E0 + (4 * (_n)))  /* 5-tuple Queue Fltr */
>  
> +/* Time sync registers - preemption statistics */
> +#define IGC_PRMEVNTTCNT		0x04298	/* TX Preemption event counter */
> +#define IGC_PRMEVNTRCNT		0x0429C	/* RX Preemption event counter */
> +#define IGC_PRMPTDRCNT		0x04284	/* Good RX Preempted Packets */
> +
> + /* Preemption Exception Counter */
> +#define IGC_PRMEXPRCNT					0x042A0
> +/* Received out of order packets with SMD-C and NOT ReumeRx */
> +#define IGC_PRMEXPRCNT_OOO_SMDC 0x000000FF
> +/* Received out of order packets with SMD-C and wrong Frame CNT */
> +#define IGC_PRMEXPRCNT_OOO_FRAME_CNT			0x0000FF00
> +#define IGC_PRMEXPRCNT_OOO_FRAME_CNT_SHIFT		8
> +/* Received out of order packets with SMD-C and wrong Frag CNT */
> +#define IGC_PRMEXPRCNT_OOO_FRAG_CNT			0x00FF0000
> +#define IGC_PRMEXPRCNT_OOO_FRAG_CNT_SHIFT		16
> +/* Received packets with SMD-S and ReumeRx */

What is ReumeRx?

> +#define IGC_PRMEXPRCNT_MISS_FRAME_FRAG_CNT		0xFF000000
> +#define IGC_PRMEXPRCNT_MISS_FRAME_FRAG_CNT_SHIFT	24
> +
>  /* Transmit Scheduling Registers */
>  #define IGC_TQAVCTRL		0x3570
>  #define IGC_TXQCTL(_n)		(0x3344 + 0x4 * (_n))
> -- 
> 2.25.1
> 
> 

