Return-Path: <bpf+bounces-55749-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B99B9A86371
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 18:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBD819C3310
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 16:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F31821D3E3;
	Fri, 11 Apr 2025 16:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDmjxAYm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6E21DE2DB;
	Fri, 11 Apr 2025 16:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744389369; cv=none; b=DCUQFhgxIdYH53/SF+KUgN4A1VABDMe2f9vlVTnD8Ukacpw1McnlLz9wYeMmwhKNTFArGA2198V38wCGXdKxBTED+OeXL077qg5NiesHrgEEnZghyQYPRALKWmaFYH8VmMp333tfMvoHZXplmMKHiugBJCr1vM+XkizgYbvkJm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744389369; c=relaxed/simple;
	bh=57EeinT2kFyZ3eosPEp0yhJlIy364+wh69p+Prj2EKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQ/PC2t7HfxH+y2VwXTOMMbd4zvCypZ37q1A3k6fm1TqLRxAKLgzCeT5CxxWm7LkUrLKTy++yyCAgjbuiWVUERQbjMzSxreOCV91UTw6+bEXJgsnSuO5dwdvnp8U3fOlUhrEWTL2C76A2Ey64xeGrdagXH4mF7OaMk3VnODnR8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDmjxAYm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ABFAC4CEE2;
	Fri, 11 Apr 2025 16:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744389368;
	bh=57EeinT2kFyZ3eosPEp0yhJlIy364+wh69p+Prj2EKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FDmjxAYm5b0bmRinJ1+KmL15n0Aam/EUskqODzz2KdMFYiIuv0uVDY5Mu2t9noqE9
	 Oz/0e5o4SdRpqsDjyGz0uZ9ncVaF5qQQ0PcZkVGvnVO/UFtVJTdfGTe6+pNof/ALH1
	 vFA1+tNU+0Okw+44X1B/4ZEkpQnhJ/w2s68uW0ilKH/wcuXO5Zzoq6zxhkDzVddFSm
	 MFLNuKGgYkIk3WzvYTVq+pfdW7GTW383TmwrMFG82Lty99Durco3wZsF2W42lT2K4+
	 y46BsEwtef8lwu3gCyXR9+MWwa4UNMZWYZpXazsDBp1z97rGGSWgKaTPji/uk3/ag9
	 x3+U+4W3giOhQ==
Date: Fri, 11 Apr 2025 17:36:02 +0100
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
	Matthew Gerlach <matthew.gerlach@altera.com>,
	Tien Sung Ang <tien.sung.ang@altera.com>,
	Mun Yew Tham <mun.yew.tham@altera.com>,
	G Thomas Rohan <rohan.g.thomas@altera.com>
Subject: Re: [PATCH net-next v3 1/2] net: stmmac: Refactor VLAN implementation
Message-ID: <20250411163602.GM395307@horms.kernel.org>
References: <20250408081354.25881-1-boon.khai.ng@altera.com>
 <20250408081354.25881-2-boon.khai.ng@altera.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408081354.25881-2-boon.khai.ng@altera.com>

On Tue, Apr 08, 2025 at 04:13:53PM +0800, Boon Khai Ng wrote:
> Refactor VLAN implementation by moving common code for DWMAC4 and
> DWXGMAC IPs into a separate VLAN module. VLAN implementation for
> DWMAC4 and DWXGMAC differs only for CSR base address, the descriptor
> for the VLAN ID and VLAN VALID bit field.
> 
> Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
> Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>

...

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c

...

> @@ -965,45 +807,6 @@ static void dwmac4_set_mac_loopback(void __iomem *ioaddr, bool enable)
>  	writel(value, ioaddr + GMAC_CONFIG);
>  }
>  
> -static void dwmac4_update_vlan_hash(struct mac_device_info *hw, u32 hash,
> -				    u16 perfect_match, bool is_double)

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

...

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c

...

> +static void vlan_update_hash(struct mac_device_info *hw, u32 hash,
> +			     __le16 perfect_match, bool is_double)

...

Hi,

The signature of this new function does not appear to match that of the
functions it replaces. And it appears to regress the endian annotation of
perfect_match which was corrected in commit e9dbebae2e3c ("net: stmmac:
Correct byte order of perfect_match")

Flagged by Sparse.

