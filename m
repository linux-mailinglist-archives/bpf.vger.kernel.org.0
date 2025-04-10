Return-Path: <bpf+bounces-55640-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9341FA83CC1
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 10:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBFA48A3074
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 08:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BF820C009;
	Thu, 10 Apr 2025 08:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLlOoNiE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E5320AF88;
	Thu, 10 Apr 2025 08:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744273166; cv=none; b=PNxpRtbSJR9kVls/Smj6TMClW70brGbw+K1pm6ef9yvplhMDnfM5wwp3OzXojzYY1qWZqxpKabGvhhfy+Igqea7SA1kO8AGSBm6MCiCyWohoBLJ++Y+FUJ9vskfyjgYHYOgrP3vV/K13SHuDml9FS+CkZ809Q5X9YVDcYafyfF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744273166; c=relaxed/simple;
	bh=vj7HOfbc0VUjF+W4DznIGCuy9zZnueeCps54a42o/9M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aKctJYHNBZpi8TNxIR8/HBU7Y1Vue6VJ0jzizB3jNm2xTs+o8hhJXnoxCCUeiMBzdJixeH0bmCOtua66vRWB1HHS5x+h1MhjWNMx4xNZV67EzevGdf43vJP+d6sOvdrtstxY2yPxgUkZIYN1beuoLq1E2LEJqFeBOgMM3q7WiOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RLlOoNiE; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22548a28d0cso7416535ad.3;
        Thu, 10 Apr 2025 01:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744273164; x=1744877964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHyb6lhohF2wzP2TRq2BN9NjbPL3ptwOR5h1WfQqLIY=;
        b=RLlOoNiEwwoXR5dQCEOEJkOGNZgrVuK0RaK5ZH7+A5kNn2ZuHZoV8UaZzpTkqoF2+b
         9Bcoj+84/6d+cCtrV23A03jYEhjBM6xRDwW6RTVAqkiRlY2ovTe1bVVjlfpokxVQYwlD
         IjZRboHxneMuZ53+MUEyt8SaQ1piNul7bqCpqAx96HYAuNUyRupGsVHudnBgpmyykjdZ
         mdFSJm+Ae2ujAWoZApZpF+OFVZo+5KVtwtquBbWPTihBtvO7NIpJhmBUMaaa9Bn1jnYh
         Um54Xlx+6eV/jfKH0Y8bQJOgoUOLHdpZ2AyywZPtMsfQblhjcfmecHtoCsBboJOlgDVb
         qXoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744273164; x=1744877964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hHyb6lhohF2wzP2TRq2BN9NjbPL3ptwOR5h1WfQqLIY=;
        b=ZRjVhIvwo/08QCgUH3RvDSuPxKmQGQxy6FHQTvK5zJURxK7csYC6rWY2AyzpqlJhQU
         g4JOsfeDhROGunA6IOYckSDOrUl7gfo1oPFhZMfLCyhDWrezlPtORMmILJ3F9DXEADLT
         tVuYOdqTw0SsVk7thLh9L8WJkYMIh4+bqNoGEtdZE5Vu6gOyFobURlrp4e1tjlbziZjY
         YdDmSD4vs154gkdt0KxYi/X1LBJRzaiwBiA35g2EoCPuNP8IhOqF1XFbjSUcTiutGZIP
         GzHYyJSC7OM+oSbEnp2Oz00utw+3c3upanrtd92D9Sx9hn9gpxRu74ApUhlvETrhXE4i
         QbXA==
X-Forwarded-Encrypted: i=1; AJvYcCUPM3Ws3TSWdwzUoMEPPD5mYve/VmkJ0W4oYPnFwrsGtmp1T3eMbAXuawmCDOxmNPCqQIWjzpbALtnc47Ir@vger.kernel.org, AJvYcCVMxWOYF08N0BfhKPu7oSR8cZI7wc8zeloD/GxFqgVzXc7SHWsFlYKlYBvik0uJZOrpv5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzau/8GC6wcSXVlO+Oy2RQLW4hPA5+OCkDfjKYW14LPmGcTg0Yq
	67h4M/mMgasfGW4BGcAXPRAp7zMT5+N4+ZDPnha5V6Pxr4pczJz1
X-Gm-Gg: ASbGnctvYBfbvKHazObSDBt7sgqkS/sB2/dP50TDeySRV+myr+piFROXGN9ASCAVtMR
	oVtOSGpkyI02dI6NHSNVFwdWXmyC4TN5P4fDO7EBHC6QNSPUiAlsYtcxAQ+oh0z/5QzeShMVNsT
	+mBgA4dFnF7xZBTvYinYbZxB3FhxMw3FN+06m1ryhFo4BZiDkL5UEnQO0BmB/mO3991jq7evFBo
	y1+95rTDZ/D5+Wf4GjkiVBS4Ja4UaUE1+9bQxcG+nz9hDLVr/p57LHVggaN11eDn148sKbbelJ/
	sXHeMzRjE/BYM2uL3WnO9+4BiZa9by2OSQ==
X-Google-Smtp-Source: AGHT+IH17ATIoN+yDWaOFwQRSqTSShuXuEFiLJbcGJtyBxMLgeMII6OtBGNiFxLsRBJFPmmRKIiE9A==
X-Received: by 2002:a17:903:22c5:b0:224:24d5:f20a with SMTP id d9443c01a7336-22be03f19cbmr22298095ad.48.1744273164355;
        Thu, 10 Apr 2025 01:19:24 -0700 (PDT)
Received: from localhost ([144.24.43.60])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1d2afa9sm2669045b3a.22.2025.04.10.01.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 01:19:24 -0700 (PDT)
Date: Thu, 10 Apr 2025 16:19:12 +0800
From: Furong Xu <0x1207@gmail.com>
To: Boon Khai Ng <boon.khai.ng@altera.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Russell King <linux@armlinux.org.uk>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Matthew Gerlach
 <matthew.gerlach@altera.com>, Tien Sung Ang <tien.sung.ang@altera.com>, Mun
 Yew Tham <mun.yew.tham@altera.com>, G Thomas Rohan
 <rohan.g.thomas@altera.com>
Subject: Re: [PATCH net-next v3 1/2] net: stmmac: Refactor VLAN
 implementation
Message-ID: <20250410161912.0000168a@gmail.com>
In-Reply-To: <20250408081354.25881-2-boon.khai.ng@altera.com>
References: <20250408081354.25881-1-boon.khai.ng@altera.com>
	<20250408081354.25881-2-boon.khai.ng@altera.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  8 Apr 2025 16:13:53 +0800, Boon Khai Ng <boon.khai.ng@altera.com> wrote:

> Refactor VLAN implementation by moving common code for DWMAC4 and
> DWXGMAC IPs into a separate VLAN module. VLAN implementation for
> DWMAC4 and DWXGMAC differs only for CSR base address, the descriptor
> for the VLAN ID and VLAN VALID bit field.
> 
> Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
> Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/Makefile  |   2 +-
>  drivers/net/ethernet/stmicro/stmmac/common.h  |   1 +
>  drivers/net/ethernet/stmicro/stmmac/dwmac4.h  |  40 ---
>  .../net/ethernet/stmicro/stmmac/dwmac4_core.c | 295 +-----------------
>  .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  13 -
>  .../ethernet/stmicro/stmmac/dwxgmac2_core.c   |  87 ------
>  drivers/net/ethernet/stmicro/stmmac/hwif.c    |   8 +
>  drivers/net/ethernet/stmicro/stmmac/hwif.h    |  61 ++--
>  .../net/ethernet/stmicro/stmmac/stmmac_vlan.c | 294 +++++++++++++++++
>  .../net/ethernet/stmicro/stmmac/stmmac_vlan.h |  63 ++++
>  10 files changed, 401 insertions(+), 463 deletions(-)
>  create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
>  create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.h
> 
[...]
> +static void vlan_update_hash(struct mac_device_info *hw, u32 hash,
> +			     __le16 perfect_match, bool is_double)
> +{
> +	void __iomem *ioaddr = hw->pcsr;
> +	u32 value;
> +
> +	writel(hash, ioaddr + VLAN_HASH_TABLE);
> +
> +	value = readl(ioaddr + VLAN_TAG);
> +
> +	if (hash) {
> +		value |= VLAN_VTHM | VLAN_ETV;
> +		if (is_double) {
> +			value |= VLAN_EDVLP;
> +			value |= VLAN_ESVL;
> +			value |= VLAN_DOVLTC;

I can confirm that 802.1ad (QinQ) has been broken on stmmac for years,
and it will be so nice if this refactoring includes some fixes for QinQ

> +		}
> +
> +		writel(value, ioaddr + VLAN_TAG);
> +	} else if (perfect_match) {
> +		u32 value = VLAN_ETV;
> +
> +		if (is_double) {
> +			value |= VLAN_EDVLP;
> +			value |= VLAN_ESVL;
> +			value |= VLAN_DOVLTC;
> +		}
> +
> +		writel(value | perfect_match, ioaddr + VLAN_TAG);
> +	} else {
> +		value &= ~(VLAN_VTHM | VLAN_ETV);
> +		value &= ~(VLAN_EDVLP | VLAN_ESVL);
> +		value &= ~VLAN_DOVLTC;
> +		value &= ~VLAN_VID;
> +
> +		writel(value, ioaddr + VLAN_TAG);
> +	}
> +}
> +
> +static void vlan_enable(struct mac_device_info *hw, u32 type)
> +{
> +	void __iomem *ioaddr = hw->pcsr;
> +	u32 value;
> +
> +	value = readl(ioaddr + VLAN_INCL);
> +	value |= VLAN_VLTI;
> +	value |= VLAN_CSVL; /* Only use SVLAN */
> +	value &= ~VLAN_VLC;
> +	value |= (type << VLAN_VLC_SHIFT) & VLAN_VLC;
> +	writel(value, ioaddr + VLAN_INCL);
> +}
> +
> +static void vlan_rx_hw(struct mac_device_info *hw,
> +		       struct dma_desc *rx_desc, struct sk_buff *skb)
> +{
> +	if (hw->desc->get_rx_vlan_valid(rx_desc)) {
> +		u16 vid = hw->desc->get_rx_vlan_tci(rx_desc);
> +
> +		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vid);

So, as the comment above, ETH_P_8021AD or ETH_P_8021Q shall be set selectively
depend on the frame type.

> +	}
> +}


