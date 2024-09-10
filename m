Return-Path: <bpf+bounces-39518-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC9D974253
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 20:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF0FB1F26655
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 18:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDF21A4F34;
	Tue, 10 Sep 2024 18:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWMi8jAM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A7F1A4AB5;
	Tue, 10 Sep 2024 18:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725993481; cv=none; b=Jx7J8UByQCKAFzM56hMRamdo2zxS/fO6Ywt3osUPM+tDb1eF8H/A7YxISCmUPxRNVLL8LZu4SVNyYsDNkRRwe2iq4pw6PyUIflmx0DkmUS8BglvrPYBkaL6IV+ArBNsBaXyUJk3Ar0jgP20/FhJaQpRcYfgFxuULN1ACb6GkRo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725993481; c=relaxed/simple;
	bh=+6erVIx9nJaj7/srcqN07+6DKoKkqA8z4fpFhR72wnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2WDWLu124oynxyHikPR57WPxd5jIChTC7PzX3/JDsuaJiIg2BXul05VrD3xzVo3YC+aMbpfl0LPoI9VDOltJ7WdK7u+6ZZp+rcILTHgnOWPFp4D+EVfdpgbJxSldqvELLJbZ1zKD3lird1ETetLduWQHeMSK9hyJqfwCtJCfvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VWMi8jAM; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f74e468baeso72379071fa.2;
        Tue, 10 Sep 2024 11:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725993478; x=1726598278; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MGJTDyPZrPgud+em+SoTe59IhXK+nc1Nr17gxYaoJ8M=;
        b=VWMi8jAMnfU2vSpbFEx+KOkqiH9COb+TJAxGjjjBcEYMQ4M4pvxrTFgGw5f02y0Rdc
         e42Si9SiUM2z2KAgoASnvLvzN7F3bHX7ToCnLHYFtXkWJeHiJ4gbkahm0CW/aUXtUVwX
         Za/GTJCAQJRUNSoICZ4oPtcraokejsATWTVeZQAB/T5sqancHZ1ZaAhINGh67On+gppJ
         j1e1v0F50db+gtW/b1Hans/AxeJssio8cXl0HI6TKZdiu42ZnXNJq8nZF728dkt2yNnz
         zfa0m/ZcUW3kGaY9aGuXhB0ntLPZh2OeyKwPJJmUfC3oXR9LkgZIUHdU9t+bBO6oRCyB
         NRxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725993478; x=1726598278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGJTDyPZrPgud+em+SoTe59IhXK+nc1Nr17gxYaoJ8M=;
        b=Mmqt8lO9lhRV8gJEKo8lpoighyyQXpFB0kGwTgIUl6MP13mIFlsaXoPv5HDpyKBV87
         EAPP8JW5NrXnDUGHitp308G6d1U6yVeLu9djGkJ1t0SLKfsTYq5Yrf2nyq+KAsjCm+Cj
         fvXvt6yLetK4PXyEbR6xwgP0Oom+/ITErwS9zhGtdt5Vr9WxtmTC+Bw8iX4+ZRKNz+t0
         2jQ6/89CdhLwwRSC71OtONb1ZTaU79UZ6zcXyqakY74v2rovuVoYIX9lshb0SbeUknfF
         RNTSjdcs042g+qwRxYC7H3m2dtqymgWo2N03XJNaHtlCTadYoA3kwzS2iHFwt9dFQmic
         q/jQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqdqyEP4x+nM4chDDM5ckCh2xqlZJr1ZCkJ/2483OTdxlh0QzPq+MtTG+2hlk579GzIn0=@vger.kernel.org, AJvYcCXFX73YX82HaQQJj+hxkij1xSk8CSkW6xvk2dt2oERndUKs00yTziZuuS3i/pl67gGzWxkhEA7h207KThzi@vger.kernel.org
X-Gm-Message-State: AOJu0YzYNnKvNaebSQQKxyrHCWMXdu6wzVUc3fVbZGNCl+55VkQ5xg8y
	Spv1WDgwuSvevN4jLaBTcg+u7g3BtdrXQRWfzQXihfLxi4c9pgpO
X-Google-Smtp-Source: AGHT+IGJ5N5cpAoAAMGa06fcAXoZykutRUQ7ciz6dqZCopzWKg9EwW64N+1kd17OukpLdCRli+ei0A==
X-Received: by 2002:a2e:80d2:0:b0:2f7:5759:db45 with SMTP id 38308e7fff4ca-2f75b93079dmr59037311fa.31.1725993476881;
        Tue, 10 Sep 2024 11:37:56 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f75c098e9esm13200291fa.116.2024.09.10.11.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 11:37:56 -0700 (PDT)
Date: Tue, 10 Sep 2024 21:37:52 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: jitendra.vegiraju@broadcom.com
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com, 
	joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, mcoquelin.stm32@gmail.com, bcm-kernel-feedback-list@broadcom.com, 
	richardcochran@gmail.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, rmk+kernel@armlinux.org.uk, ahalaney@redhat.com, 
	xiaolei.wang@windriver.com, rohan.g.thomas@intel.com, Jianheng.Zhang@synopsys.com, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, andrew@lunn.ch, linux@armlinux.org.uk, 
	horms@kernel.org, florian.fainelli@broadcom.com
Subject: Re: [PATCH net-next v5 1/5] net: stmmac: Add HDMA mapping for
 dw25gmac support
Message-ID: <7foqi3vdgc3kvyw5rrnqsqsakgfgcrhw5sihnqwza4okdnh5dd@pdsdjn32ya6u>
References: <20240904054815.1341712-1-jitendra.vegiraju@broadcom.com>
 <20240904054815.1341712-2-jitendra.vegiraju@broadcom.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904054815.1341712-2-jitendra.vegiraju@broadcom.com>

Hi Jitendra

On Tue, Sep 03, 2024 at 10:48:11PM -0700, jitendra.vegiraju@broadcom.com wrote:
> From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
> 
> Add hdma configuration support in include/linux/stmmac.h file.
> The hdma configuration includes mapping of virtual DMAs to physical DMAs.
> Define a new data structure stmmac_hdma_cfg to provide the mapping.
> 
> Introduce new plat_stmmacenet_data::snps_id,snps_dev_id to allow glue
> drivers to specify synopsys ID and device id respectively.
> These values take precedence over reading from HW register. This facility
> provides a mechanism to use setup function from stmmac core module and yet
> override MAC.VERSION CSR if the glue driver chooses to do so.
> 
> Signed-off-by: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
> ---
>  include/linux/stmmac.h | 48 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> index 338991c08f00..eb8136680a7b 100644
> --- a/include/linux/stmmac.h
> +++ b/include/linux/stmmac.h
> @@ -89,6 +89,51 @@ struct stmmac_mdio_bus_data {
>  	bool needs_reset;
>  };
>  
> +/* DW25GMAC Hyper-DMA Overview
> + * Hyper-DMA allows support for large number of Virtual DMA(VDMA)
> + * channels using a smaller set of physical DMA channels(PDMA).
> + * This is supported by the mapping of VDMAs to Traffic Class(TC)
> + * and PDMA to TC in each traffic direction as shown below.
> + *
> + *        VDMAs            Traffic Class      PDMA
> + *       +--------+          +------+         +-----------+
> + *       |VDMA0   |--------->| TC0  |-------->|PDMA0/TXQ0 |
> + *TX     +--------+   |----->+------+         +-----------+
> + *Host=> +--------+   |      +------+         +-----------+ => MAC
> + *SW     |VDMA1   |---+      | TC1  |    +--->|PDMA1/TXQ1 |
> + *       +--------+          +------+    |    +-----------+
> + *       +--------+          +------+----+    +-----------+
> + *       |VDMA2   |--------->| TC2  |-------->|PDMA2/TXQ1 |
> + *       +--------+          +------+         +-----------+
> + *            .                 .                 .
> + *       +--------+          +------+         +-----------+
> + *       |VDMAn-1 |--------->| TCx-1|-------->|PDMAm/TXQm |
> + *       +--------+          +------+         +-----------+
> + *
> + *       +------+          +------+         +------+
> + *       |PDMA0 |--------->| TC0  |-------->|VDMA0 |
> + *       +------+   |----->+------+         +------+
> + *MAC => +------+   |      +------+         +------+
> + *RXQs   |PDMA1 |---+      | TC1  |    +--->|VDMA1 |  => Host
> + *       +------+          +------+    |    +------+
> + *            .                 .                 .
> + */
> +

> +/* Hyper-DMA mapping configuration
> + * Traffic Class associated with each VDMA/PDMA mapping
> + * is stored in corresponding array entry.
> + */
> +struct stmmac_hdma_cfg {
> +	u32 tx_vdmas;	/* TX VDMA count */
> +	u32 rx_vdmas;	/* RX VDMA count */
> +	u32 tx_pdmas;	/* TX PDMA count */
> +	u32 rx_pdmas;	/* RX PDMA count */
> +	u8 *tvdma_tc;	/* Tx VDMA to TC mapping array */
> +	u8 *rvdma_tc;	/* Rx VDMA to TC mapping array */
> +	u8 *tpdma_tc;	/* Tx PDMA to TC mapping array */
> +	u8 *rpdma_tc;	/* Rx PDMA to TC mapping array */
> +};
> +
>  struct stmmac_dma_cfg {
>  	int pbl;
>  	int txpbl;
> @@ -101,6 +146,7 @@ struct stmmac_dma_cfg {
>  	bool multi_msi_en;
>  	bool dche;
>  	bool atds;
> +	struct stmmac_hdma_cfg *hdma_cfg;

Based on what you are implementing the _static_ VDMA-TC-PDMA channels
mapping I really don't see a value of adding all of these data here.
The whole implementation gets to be needlessly overcomplicated.
Moreover AFAICS there are some channels left misconfigured in the
Patch 2 code.  Please see my comments there for more details.

>  };
>  
>  #define AXI_BLEN	7
> @@ -303,5 +349,7 @@ struct plat_stmmacenet_data {
>  	int msi_tx_base_vec;
>  	const struct dwmac4_addrs *dwmac4_addrs;
>  	unsigned int flags;

> +	u32 snps_id;
> +	u32 snps_dev_id;

Please move these fields to the head of the structure as the kind of
crucial ones, and convert snps_dev_id to just dev_id.

snps_id field name was selected based on the VERSION.SNPSVER field
name (see SNPS prefix). Following that logic the VERSION.DEVID field
should be converted to the dev_id name.

-Serge(y)

>  };
>  #endif
> -- 
> 2.34.1
> 

