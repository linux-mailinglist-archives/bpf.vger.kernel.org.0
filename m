Return-Path: <bpf+bounces-56588-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6025A9AD05
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 14:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E93D81B66EC2
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 12:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243BD22D7B2;
	Thu, 24 Apr 2025 12:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oe51ROCq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D441FE45D;
	Thu, 24 Apr 2025 12:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745496971; cv=none; b=TfReNEkIGneKSjfDPg/eoD4TN1aRMqIz6CcmbbDUCAPnAXpxKC603YONgJjBxOQgDPZYYbPuxrl5Ymo50xvsPe8AEHroF/S0YufCWad8As9C8u/ZYsCmjIMiGkfOxUKOuWVx+jWQ239/X/zlKzlvIsvj21iN1/7W66XDTa++IQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745496971; c=relaxed/simple;
	bh=Sf0ybRK9DYsCxZ5Je/2MG9IakhbW6jd2lRTZlZQzniw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UH3+VHwl9wQajvllfPMiPg9hFUQG3F1oGV/XVJXOAUhThqEMVH+AxXD5wuCvGhlyvIHx9EwO/UyWzlPTA0jA6nmwHbzOBp2rG8dvkm880WIJqYk27tmPf1XXOhhcbbMg9WMGTPmXtHldvMcRlXYFr92OymK5ValdCfdy1pCBAGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oe51ROCq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC87C4CEE3;
	Thu, 24 Apr 2025 12:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745496971;
	bh=Sf0ybRK9DYsCxZ5Je/2MG9IakhbW6jd2lRTZlZQzniw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Oe51ROCqK35W//I58nfZjw9T19a9u3WVnBJB0SkIp3x39DQ7ql8iB0byUcTix9qCE
	 kZcy0a7XB+8uEXdqyJEA5ZXVFElPivKUlHovhEnK6Xrq4cXaAY0AQg5s4mQoaYJlDK
	 Pz8JmgYFrFGRSuf04xqzh3mZr2pcmqaNxzxK/Thnrcf3UQ4v8XT/0JUcy+C3UBTUzS
	 sfZTv9+jSh9WJTAKEVMPUsKU8AvLRMaAdxVo3n8DxEduUqvdHw6Z3G2zHhUK0UHqCh
	 OBrRynyn5GyXNZbV/uEfFTIvdekG9eVkwHEIW7xSRx0WchZ089/QSS/LQuqiDYN23P
	 zjAwyzQoD4VYA==
Date: Thu, 24 Apr 2025 13:16:04 +0100
From: Simon Horman <horms@kernel.org>
To: Boon Khai Ng <boon.khai.ng@altera.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
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
	Matthew Gerlach <matthew.gerlach@altera.com>,
	Tien Sung Ang <tien.sung.ang@altera.com>,
	Mun Yew Tham <mun.yew.tham@altera.com>,
	G Thomas Rohan <rohan.g.thomas@altera.com>
Subject: Re: [PATCH net-next v4 1/2] net: stmmac: Refactor VLAN implementation
Message-ID: <20250424121604.GE3042781@horms.kernel.org>
References: <20250421162930.10237-1-boon.khai.ng@altera.com>
 <20250421162930.10237-2-boon.khai.ng@altera.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421162930.10237-2-boon.khai.ng@altera.com>

On Tue, Apr 22, 2025 at 12:29:29AM +0800, Boon Khai Ng wrote:
> Refactor VLAN implementation by moving common code for DWMAC4 and
> DWXGMAC IPs into a separate VLAN module. VLAN implementation for
> DWMAC4 and DWXGMAC differs only for CSR base address, the descriptor
> for the VLAN ID and VLAN VALID bit field.
> 
> The descriptor format for VLAN is not moved to the common code due
> to hardware-specific differences between DWMAC4 and DWXGMAC.
> 
> For the DWMAC4 IP, the Receive Normal Descriptor 0 (RDES0) is
> formatted as follows:
>     31                                                0
>       ------------------------ -----------------------
> RDES0| Inner VLAN TAG [31:16] | Outer VLAN TAG [15:0] |
>       ------------------------ -----------------------
> 
> For the DWXGMAC IP, the RDES0 format varies based on the
> Tunneled Frame bit (TNP):
> 
> a) For Non-Tunneled Frame (TNP=0)
> 
>     31                                                0
>       ------------------------ -----------------------
> RDES0| Inner VLAN TAG [31:16] | Outer VLAN TAG [15:0] |
>       ------------------------ -----------------------
> 
> b) For Tunneled Frame (TNP=1)
> 
>      31                   8 7                3 2      0
>       --------------------- ------------------ -------
> RDES0| VNID/VSID           | Reserved         | OL2L3 |
>       --------------------- ------------------ ------
> 
> The logic for handling tunneled frames is not yet implemented
> in the dwxgmac2_wrback_get_rx_vlan_tci() function. Therefore,
> it is prudent to maintain separate functions within their
> respective descriptor driver files
> (dwxgmac2_descs.c and dwmac4_descs.c).
> 
> Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
> Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>

...

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> index a6d395c6bacd..d9f41c047e5e 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> @@ -614,76 +614,6 @@ static int dwxgmac2_rss_configure(struct mac_device_info *hw,
>  	return 0;
>  }
>  
> -static void dwxgmac2_update_vlan_hash(struct mac_device_info *hw, u32 hash,
> -				      u16 perfect_match, bool is_double)
> -{
> -	void __iomem *ioaddr = hw->pcsr;
> -
> -	writel(hash, ioaddr + XGMAC_VLAN_HASH_TABLE);
> -
> -	if (hash) {
> -		u32 value = readl(ioaddr + XGMAC_PACKET_FILTER);
> -
> -		value |= XGMAC_FILTER_VTFE;
> -
> -		writel(value, ioaddr + XGMAC_PACKET_FILTER);

Here the XGMAC_FILTER_VTFE bit of XGMAC_PACKET_FILTER is set.
However, this logic does not appear in vlan_update_hash()

> -
> -		value = readl(ioaddr + XGMAC_VLAN_TAG);
> -
> -		value |= XGMAC_VLAN_VTHM | XGMAC_VLAN_ETV;
> -		if (is_double) {
> -			value |= XGMAC_VLAN_EDVLP;
> -			value |= XGMAC_VLAN_ESVL;
> -			value |= XGMAC_VLAN_DOVLTC;
> -		} else {
> -			value &= ~XGMAC_VLAN_EDVLP;
> -			value &= ~XGMAC_VLAN_ESVL;
> -			value &= ~XGMAC_VLAN_DOVLTC;
> -		}

And likewise, here value is based on reading from XGMAC_VLAN_TAG.
Whereas in vlan_update_hash is constructed without reading from
XGMAC_VLAN_TAG.

Can I clarify that this is intentional and that vlan_update_hash(),
which is based on the DWMAC4 implementation, will also work for DWXGMAC IP?

> -
> -		value &= ~XGMAC_VLAN_VID;
> -		writel(value, ioaddr + XGMAC_VLAN_TAG);
> -	} else if (perfect_match) {
> -		u32 value = readl(ioaddr + XGMAC_PACKET_FILTER);
> -
> -		value |= XGMAC_FILTER_VTFE;
> -
> -		writel(value, ioaddr + XGMAC_PACKET_FILTER);
> -
> -		value = readl(ioaddr + XGMAC_VLAN_TAG);
> -
> -		value &= ~XGMAC_VLAN_VTHM;
> -		value |= XGMAC_VLAN_ETV;
> -		if (is_double) {
> -			value |= XGMAC_VLAN_EDVLP;
> -			value |= XGMAC_VLAN_ESVL;
> -			value |= XGMAC_VLAN_DOVLTC;
> -		} else {
> -			value &= ~XGMAC_VLAN_EDVLP;
> -			value &= ~XGMAC_VLAN_ESVL;
> -			value &= ~XGMAC_VLAN_DOVLTC;
> -		}
> -
> -		value &= ~XGMAC_VLAN_VID;
> -		writel(value | perfect_match, ioaddr + XGMAC_VLAN_TAG);
> -	} else {
> -		u32 value = readl(ioaddr + XGMAC_PACKET_FILTER);
> -
> -		value &= ~XGMAC_FILTER_VTFE;
> -
> -		writel(value, ioaddr + XGMAC_PACKET_FILTER);
> -
> -		value = readl(ioaddr + XGMAC_VLAN_TAG);
> -
> -		value &= ~(XGMAC_VLAN_VTHM | XGMAC_VLAN_ETV);
> -		value &= ~(XGMAC_VLAN_EDVLP | XGMAC_VLAN_ESVL);
> -		value &= ~XGMAC_VLAN_DOVLTC;
> -		value &= ~XGMAC_VLAN_VID;
> -
> -		writel(value, ioaddr + XGMAC_VLAN_TAG);
> -	}
> -}

...

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c

...

> +static int vlan_write_filter(struct net_device *dev,
> +			     struct mac_device_info *hw,
> +			     u8 index, u32 data)
> +{
> +	void __iomem *ioaddr = (void __iomem *)dev->base_addr;
> +	int i, timeout = 10;
> +	u32 val;
> +
> +	if (index >= hw->num_vlan)
> +		return -EINVAL;
> +
> +	writel(data, ioaddr + VLAN_TAG_DATA);
> +
> +	val = readl(ioaddr + VLAN_TAG);
> +	val &= ~(VLAN_TAG_CTRL_OFS_MASK |
> +		VLAN_TAG_CTRL_CT |
> +		VLAN_TAG_CTRL_OB);
> +	val |= (index << VLAN_TAG_CTRL_OFS_SHIFT) | VLAN_TAG_CTRL_OB;
> +
> +	writel(val, ioaddr + VLAN_TAG);
> +
> +	for (i = 0; i < timeout; i++) {
> +		val = readl(ioaddr + VLAN_TAG);
> +		if (!(val & VLAN_TAG_CTRL_OB))
> +			return 0;
> +		udelay(1);
> +	}

I am curious to know why readl_poll_timeout() isn't used here
as was the case in dwmac4_write_vlan_filter().

> +
> +	netdev_err(dev, "Timeout accessing MAC_VLAN_Tag_Filter\n");
> +
> +	return -EBUSY;
> +}

...

