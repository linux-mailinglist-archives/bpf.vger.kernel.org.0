Return-Path: <bpf+bounces-51728-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD28A381B6
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 12:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C332D3B2801
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 11:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43550218E81;
	Mon, 17 Feb 2025 11:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FntKGJ2g"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43E119F104;
	Mon, 17 Feb 2025 11:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739791882; cv=none; b=kD40OoVHhzEELn6AAJzs3UUuZ1G+8LOtsf39UU1gLlaT/XrPj0ebGhWBzbXx8nnAoG3inoG1qhIVYTXUGb23BfT1md5ytNlEdiz11RmwGqtEZnINBdtrxsoXj3ifqJ/88EBSJSAuA6gOzKiJQ/ZYMh5+hlj+expX3wV4b5C5rD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739791882; c=relaxed/simple;
	bh=x59L7IqL94IFM2zao/QYrrn1Ck873l+zRRObe6nR3ZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VnDuRXJn2cz50KZQ0OJ1q7VDzRrrBX4YKZPe6vOmq+tW9tZF5SnHToVGKvqDs3jgE1LmQknDv9RBfV4/7mv0DxjnNXPKcnTUL5Zf+Hzmn/+w9ugQFkTCOtHcaQQBE2dp6jFVkPzwttugYsD6hmOFnGZsJxc1g+i5DXmUCqlSiYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FntKGJ2g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 322ECC4CED1;
	Mon, 17 Feb 2025 11:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739791882;
	bh=x59L7IqL94IFM2zao/QYrrn1Ck873l+zRRObe6nR3ZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FntKGJ2gEe8KQtXAM1A7/RQn+PfYq8H5dWKYZn5oss5qZBf9JJncJE+R18hFL8Lm9
	 PFPpYqcpS5EoPKMf2J66Tc0mJGlB837NAOJlOR8NTAl4z0mfHEvAkYdhwMS9wYhdKJ
	 HEiZuuptHx2U2UuENVvlZPPOD8mlcYbVLdg9xYKBvzRLVk1cxv7vKgZUb9VcRqL5Lp
	 nZcpJgysIZTcUAwuJCuFc5CgPBBFycmNx72h4mVdtw8TrXX0x7EKS9IV1CpLtU44w5
	 2lFAIvwLk9KmxV7+5Q6jltQEsCH16ycLhTcgGiskBxqc2hX/gfn1u19wzSWtFwHK40
	 qURVopF4ZbD4g==
Date: Mon, 17 Feb 2025 11:31:13 +0000
From: Simon Horman <horms@kernel.org>
To: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Furong Xu <0x1207@gmail.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Xiaolei Wang <xiaolei.wang@windriver.com>,
	Suraj Jaiswal <quic_jsuraj@quicinc.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Gal Pressman <gal@nvidia.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH iwl-next v4 5/9] igc: Add support for frame preemption
 verification
Message-ID: <20250217113113.GK1615191@kernel.org>
References: <20250210070207.2615418-1-faizal.abdul.rahim@linux.intel.com>
 <20250210070207.2615418-6-faizal.abdul.rahim@linux.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210070207.2615418-6-faizal.abdul.rahim@linux.intel.com>

On Mon, Feb 10, 2025 at 02:02:03AM -0500, Faizal Rahim wrote:

...

> diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c

...

> +bool igc_fpe_transmitted_smd_v(union igc_adv_tx_desc *tx_desc)
> +{
> +	u8 smd = FIELD_GET(IGC_TXD_POPTS_SMD_MASK, tx_desc->read.olinfo_status);

olininfo_status is little-endian, so I think it needs
to be converted to host byte order when used as an
argument to FIELD_GET().

Flagged by Sparse.

> +
> +	return smd == SMD_V;
> +}

...

> diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.h b/drivers/net/ethernet/intel/igc/igc_tsn.h

...

> +static inline void igc_fpe_lp_event_status(union igc_adv_rx_desc *rx_desc,
> +					   struct ethtool_mmsv *mmsv)
> +{
> +	__le32 status_error = le32_to_cpu(rx_desc->wb.upper.status_error);

It looks like the type of status_error should be a host byte order integer,
such as u32.

Also flagged by Sparse.

> +	int smd;
> +
> +	smd = FIELD_GET(IGC_RXDADV_STAT_SMD_TYPE_MASK, status_error);
> +
> +	if (smd == IGC_RXD_STAT_SMD_TYPE_V)
> +		ethtool_mmsv_event_handle(mmsv, ETHTOOL_MMSV_LP_SENT_VERIFY_MPACKET);
> +	else if (smd == IGC_RXD_STAT_SMD_TYPE_R)
> +		ethtool_mmsv_event_handle(mmsv, ETHTOOL_MMSV_LP_SENT_RESPONSE_MPACKET);
> +}
> +
> +static inline bool igc_fpe_is_verify_or_response(union igc_adv_rx_desc *rx_desc,
> +						 unsigned int size)
> +{
> +	__le32 status_error = le32_to_cpu(rx_desc->wb.upper.status_error);

Ditto.

> +	int smd;
> +
> +	smd = FIELD_GET(IGC_RXDADV_STAT_SMD_TYPE_MASK, status_error);
> +
> +	return ((smd == IGC_RXD_STAT_SMD_TYPE_V || smd == IGC_RXD_STAT_SMD_TYPE_R) &&
> +		size == SMD_FRAME_SIZE);
> +}
> +
>  #endif /* _IGC_BASE_H */
> -- 
> 2.34.1
> 

