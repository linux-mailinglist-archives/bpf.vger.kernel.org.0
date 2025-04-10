Return-Path: <bpf+bounces-55632-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A53DA83982
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 08:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 265E71B66957
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 06:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88295204C1D;
	Thu, 10 Apr 2025 06:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAz6w8JZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79515204C02;
	Thu, 10 Apr 2025 06:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744267116; cv=none; b=SjQauBUci2w/bsNOaIIgs9PzvBUohYzCO+84iNdqG9CA85DspbuHcb29fqJ68z37CEP2heGU/fHH3QDr1RlxoIdUs/1OrM/2/k9RBPxqlEh0KDtykZrWYa143AAWY0YnkvT8TVX+9bZqkjD6E8TpRfr7gDQ+m6h6X/oHJcEa52Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744267116; c=relaxed/simple;
	bh=bDD5fHC5yG/fqnt/5gyzP8f48vNMjEUjChpk5HqxRAA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p0RX2zciWip5O44stOes04VYVDCZRjg8j8Odilg78zQrvZMP1zDs3vIVwLDtACpu2ROJGdwYcOF4mm5T+WvdYynS0veJjM5wGrAj/JDSYzK1RMIBtbSV9ZBhIirBW3ApkZqcWu+Yw4a5Ui1AIZ985ntNoF+ztCDXlSATuS7odIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PAz6w8JZ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-227a8cdd241so4916415ad.3;
        Wed, 09 Apr 2025 23:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744267114; x=1744871914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KuVL+jTm8BlM5ZpgP0Uojq+Y9nMX/V5q2TiLQtlvtmM=;
        b=PAz6w8JZpg4hsxhEQBMnEuKKVJAPNhKoUN+oSvjSGGVIzOJOimNcRaFMMnqBS6kBf0
         KiGhTaY6lQnna/ti5ftLYF/WQfysPk/ctXYp66lkONH9OUSARQ3QnO/u81cv9456RnL0
         giCpG/pp2ycbgpWq2MDcDXgkOXQhql67SuIm90Oa29D2A6KYD7GTVlRrZ1/n2TZbtFxR
         aHvn4O2Pwuba9JhTDqJSega88ErvNZMopG4qkYr+KCEBHM1+dhOnNAXrnr/ar7Yhz5gC
         DHdmQ57Etsgam2mQ4M6LeHoSXYbvn084Hzd56oRfIw8xENPfllzqOOueIn05LYlVAAfP
         Z5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744267114; x=1744871914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KuVL+jTm8BlM5ZpgP0Uojq+Y9nMX/V5q2TiLQtlvtmM=;
        b=NNyqfBLZ7KhDw0Oj5xRuzKf1eQG6Xjzg6uo8UNByH1nwWbng9UpdlRWbUptsV8lmm/
         9UuNjaaEXmu3UxQTAjhSnuRSrLkJCLN3ZrUs1FR04CXWi6B2fogiZLGg5b3HpjlT5NeZ
         QEcvnKoYdL2qL6M0FZVZie46/vLT+cGq/CcVq0CZYEJ2NcFjEs+GxI1Gec4qsMdEFWRR
         onCGHnGzuCsAp+52lJ2Hcg/oZYNhP+pd7Vo7YfxGk7hYgQosfYbvMwlFG34fkuvS4JQW
         B+bcAg6mTomLIGhU6Ho5YKW928167AQnS8rlG4pp2I4qTozleII6A8tBAyi/BA3naeR2
         /PGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzMXTp8KSXsTXjLDxyAZrjwWMNzDR769ZV9M8UD1eTlYBiga1FVcZhU94N5WKWykPgASwUAbqJJk1Pt7kx@vger.kernel.org, AJvYcCXx+xaz5IjfxFDjH+8wWhcs5oIlOlGHmC6lVmYGTLevoPd7uZ1Sv6lpSQAPF55lvlQl6xE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAC6d23hRZ+ugS3LtBMITnfOeeeqPwBCcR5NcYpGy2S8TwVGWT
	GHdzWY+KUe5kd31vwMDOpKxCtypEAemTxRc11zIBuH1K1Mz9oqu2
X-Gm-Gg: ASbGncuGt54higWnjiKku4Nt013i+7Kqi6JYDd6ZJMUfMYXLJ8mBRZwDTrN8svtI/H+
	r/GZTCiphnaUxBAJV+yG5m0MEeoYWD4RhMxgZRnX5kMmZBpPkqfoQUWjp3FIxV4Nas2bSKBiPSp
	wM0mNdKjne6a7mksH2LmPJ0dU2b4+55gf7w0Esn9UzuAzDWyMli/ozBCGiGscA24sixw+fBVJnG
	AukPnbHL69f+rdy1a9swzIg6KwrOIrzmYPFOcCH8/m3LTTcpI8v85qKvT9mhi6gKYP423ZvBi3G
	jVqDl4dKXppt0JDhB6+ND7tYWjFNapN0nB6rxvB2W8rZ
X-Google-Smtp-Source: AGHT+IFoLHwW+yB8ugnhtjq/Zm+3UsyrrhpRcH51GcUutNiq2TfCMkej9FiKynCN6f6ckD3TqsaTYA==
X-Received: by 2002:a17:90b:2dca:b0:2fa:17dd:6afa with SMTP id 98e67ed59e1d1-30718b82e6bmr3115309a91.17.1744267113628;
        Wed, 09 Apr 2025 23:38:33 -0700 (PDT)
Received: from localhost ([144.24.43.60])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7cb554bsm22850725ad.199.2025.04.09.23.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 23:38:33 -0700 (PDT)
Date: Thu, 10 Apr 2025 14:38:21 +0800
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
Message-ID: <20250410143821.000002c0@gmail.com>
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
> diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
> index 31bdbab9a46c..0a57c5e7497d 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
> @@ -9,6 +9,7 @@
>  #include "stmmac_fpe.h"
>  #include "stmmac_ptp.h"
>  #include "stmmac_est.h"
> +#include "stmmac_vlan.h"
>  #include "dwmac4_descs.h"
>  #include "dwxgmac2.h"
>  
> @@ -120,6 +121,7 @@ static const struct stmmac_hwif_entry {
>  	const void *tc;
>  	const void *mmc;
>  	const void *est;
> +	const void *vlan;
>  	int (*setup)(struct stmmac_priv *priv);
>  	int (*quirks)(struct stmmac_priv *priv);
>  } stmmac_hw[] = {
> @@ -197,6 +199,7 @@ static const struct stmmac_hwif_entry {
>  		.desc = &dwmac4_desc_ops,
>  		.dma = &dwmac4_dma_ops,
>  		.mac = &dwmac410_ops,
> +		.vlan = &dwmac_vlan_ops,

Rename dwmac_vlan_ops to dwmac4_vlan_ops will be better,
just like dwmac4_desc_ops/dwmac4_dma_ops

[...]
> +const struct stmmac_vlan_ops dwmac_vlan_ops = {
> +	.update_vlan_hash = vlan_update_hash,
> +	.enable_vlan = vlan_enable,
> +	.add_hw_vlan_rx_fltr = vlan_add_hw_rx_fltr,
> +	.del_hw_vlan_rx_fltr = vlan_del_hw_rx_fltr,
> +	.restore_hw_vlan_rx_fltr = vlan_restore_hw_rx_fltr,
> +	.rx_hw_vlan = vlan_rx_hw,
> +	.set_hw_vlan_mode = vlan_set_hw_mode,
> +};
> +
> +const struct stmmac_vlan_ops dwxlgmac2_vlan_ops = {
> +	.update_vlan_hash = vlan_update_hash,
> +	.enable_vlan = vlan_enable,
> +};

dwxlgmac2_vlan_ops looks redundant here, another new struct contains
totally identical members.

stmmac_do_void_callback()/stmmac_do_callback() handles NULL function
pointers so good, we can leave the un-implemented functions as NULL.

Are you trying to avoid something undefined here?

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.h
> new file mode 100644
> index 000000000000..29e7be83161e
> --- /dev/null
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.h
> @@ -0,0 +1,63 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2025, Altera Corporation
> + * stmmac VLAN(802.1Q) handling
> + */
> +
> +#ifndef __STMMAC_VLAN_H__
> +#define __STMMAC_VLAN_H__
> +
> +#include <linux/bitfield.h>
> +
> +#define VLAN_TAG			0x00000050
> +#define VLAN_TAG_DATA			0x00000054
> +#define VLAN_HASH_TABLE			0x00000058
> +#define VLAN_INCL			0x00000060
> +
> +#define HW_FEATURE3			0x00000128
> +
> +/* MAC VLAN */
> +#define VLAN_EDVLP			BIT(26)
> +#define VLAN_VTHM			BIT(25)
> +#define VLAN_DOVLTC			BIT(20)
> +#define VLAN_ESVL			BIT(18)
> +#define VLAN_ETV			BIT(16)
> +#define VLAN_VID			GENMASK(15, 0)
> +#define VLAN_VLTI			BIT(20)
> +#define VLAN_CSVL			BIT(19)
> +#define VLAN_VLC			GENMASK(17, 16)
> +#define VLAN_VLC_SHIFT			16
> +#define VLAN_VLHT			GENMASK(15, 0)
> +
> +/* MAC VLAN Tag */
> +#define VLAN_TAG_VID			GENMASK(15, 0)
> +#define VLAN_TAG_ETV			BIT(16)
> +
> +/* MAC VLAN Tag Control */
> +#define VLAN_TAG_CTRL_OB		BIT(0)
> +#define VLAN_TAG_CTRL_CT		BIT(1)
> +#define VLAN_TAG_CTRL_OFS_MASK		GENMASK(6, 2)
> +#define VLAN_TAG_CTRL_OFS_SHIFT		2
> +#define VLAN_TAG_CTRL_EVLS_MASK		GENMASK(22, 21)
> +#define VLAN_TAG_CTRL_EVLS_SHIFT	21
> +#define VLAN_TAG_CTRL_EVLRXS		BIT(24)
> +
> +#define VLAN_TAG_STRIP_NONE		FIELD_PREP(VLAN_TAG_CTRL_EVLS_MASK, 0x0)
> +#define VLAN_TAG_STRIP_PASS		FIELD_PREP(VLAN_TAG_CTRL_EVLS_MASK, 0x1)
> +#define VLAN_TAG_STRIP_FAIL		FIELD_PREP(VLAN_TAG_CTRL_EVLS_MASK, 0x2)
> +#define VLAN_TAG_STRIP_ALL		FIELD_PREP(VLAN_TAG_CTRL_EVLS_MASK, 0x3)
> +
> +/* MAC VLAN Tag Data/Filter */
> +#define VLAN_TAG_DATA_VID		GENMASK(15, 0)
> +#define VLAN_TAG_DATA_VEN		BIT(16)
> +#define VLAN_TAG_DATA_ETV		BIT(17)
> +
> +/* MAC VLAN HW FEAT */
> +#define VLAN_HW_FEAT_NRVF		GENMASK(2, 0)
> +
> +extern const struct stmmac_vlan_ops dwmac_vlan_ops;
> +extern const struct stmmac_vlan_ops dwxlgmac2_vlan_ops;
> +
> +u32 stmmac_get_num_vlan(void __iomem *ioaddr);
> +
> +#endif /* __STMMAC_VLAN_H__ */

It is a good practice to only keep inside the header those definitions
which are truly exported by stmmac_vlan.c towards external callers.
That means those #defines which are only used within stmmac_vlan.c
shouldn't be here, but inside stmmac_vlan.c file.

