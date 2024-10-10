Return-Path: <bpf+bounces-41669-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF009995D7
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 01:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03A2F284705
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 23:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B235B1E7C1A;
	Thu, 10 Oct 2024 23:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCYKxdwK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C451A704B;
	Thu, 10 Oct 2024 23:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728604552; cv=none; b=rQOxI8hB0byrZi2++pdK7DPnjbmhiFWG7Ut6+EeKl5Sh7gcnk3LhQim3SmKMMqoNb6zIK+n8gxxYWqWc76Gh50iexNhga5o3a98hzc2KvC5k/qFKunRVzVcebO/Kg1Q2BLinL3mF30/rC6R+jF9GJ3PboHb4MFlXPvwAvMFZyV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728604552; c=relaxed/simple;
	bh=gpzBBnA3MJxHQS6+6hokfHkqY2+Oc+NFGwglGBafSf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jHutWB+kFBYMdoO1x2WceoFetxP8PS/ljE8zn795emYLNA1ZtfXuQ9dhnEQCEKqysMdic8VQhpKX7490bk4FEQlXdeEYO252qbG4zF4WvYvXnFiNHh3/qPCNb3Z30uw9PFTeed6PmVJfYuE2n5kYzM7bWEJ880FcZXeebsV+q0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BCYKxdwK; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5399041167cso2376234e87.0;
        Thu, 10 Oct 2024 16:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728604548; x=1729209348; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YhBXFtGH6i0vOK/LESRrJj88Uulh/r+OrkraFHl54nQ=;
        b=BCYKxdwKCEFrdbNQjvn4iPR2cm0hg6oZRtbm+jL/QbXDSArK8eFeFbXXb98juZvGn6
         aQgVQEvbbd6ond1Tt+2CCSaW0vOGhv6FF3ctFnXJeptVA8sk+fcStbn/8BS803m3f9oA
         HBW7fPhjHG8lU5MZtfA880dznoaKdqBgNzBPOT521+Gsax3DkL6KMUKkdkRW5tzJ8HB4
         lxcOJiRuslWHw5Smqul/vknJS8Yp8Ou4GpMICv9JvP4VdJ0nvU9vSNJN1j1u+Nen5uMm
         GmuNVPw1Y6uOPduBrChvVXzDSS+WzuNXkzKxUgc/1UF0Y+yGPy4DB2ErdM+imMcdcEWN
         yLRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728604548; x=1729209348;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YhBXFtGH6i0vOK/LESRrJj88Uulh/r+OrkraFHl54nQ=;
        b=hFSSAHXkPTGvWrb0MiTmUmTqf2USxjfzjqtMj7QK19UVZT4RjX1d+yV6tjQlceGP1U
         ggArnEq+7pAjy9FzGqVZTIi+JZ8tPXtwKlJqmai6om44JgxOcHOKn8bK23uh/q/7eL08
         HlaRQXGz/+x128tufXyoK/h7noCwT2AtfsP/C0GwJiYJL8bklkvcNGSgpuoI9qTyAHXk
         BVnu3nhgQqhZZjPH2D8TkbnSA79lTRp5CbVwaJyOfWto0CCqVrHltE/mxU0oNW3jCAgo
         0cO+E1xZkjIOIRcS+YyHkr20fwAqYTRiUuPteJP1SPz0hiCBPgG68cKBuN2qOwVSJ80t
         nDWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVk7zFBO0M5BN5XH+R5ShGJNbEymeu0u0uDwxQfE7t2fKe9+/LxKxJV5pPdzj7Opu/GFiiKzmURUqgAye+R@vger.kernel.org, AJvYcCVoLUYKgy+63+C2E57n7eVqKnhdfGte0K9kuVzeNLpFKfEhasroSLBfbXDc4dLfFgebTmw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9pxD5LKNxezUrZl0EIjdIcXCq5Pu1xUOGzScasqfw7YktwiYn
	cmOFBlCeG6N7Crmv87iHQq6pqgorhlKie9ZE9LLGkQAaavxeHSx76DsiFH7G
X-Google-Smtp-Source: AGHT+IGrUtcLfRPV/X2BgAOVs8KJ3Cn9gKPa53TuaklXWoBoVtKgGbjWxjWntvDHXXCf+hazNI+N/Q==
X-Received: by 2002:a05:6512:39c6:b0:539:8d2c:c01a with SMTP id 2adb3069b0e04-539da4e088bmr374945e87.29.1728604547766;
        Thu, 10 Oct 2024 16:55:47 -0700 (PDT)
Received: from mobilestation ([85.249.18.22])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539cb6c1628sm424807e87.28.2024.10.10.16.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 16:55:47 -0700 (PDT)
Date: Fri, 11 Oct 2024 02:55:41 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com, 
	joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, mcoquelin.stm32@gmail.com, bcm-kernel-feedback-list@broadcom.com, 
	richardcochran@gmail.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, rmk+kernel@armlinux.org.uk, ahalaney@redhat.com, 
	xiaolei.wang@windriver.com, rohan.g.thomas@intel.com, Jianheng.Zhang@synopsys.com, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, andrew@lunn.ch, linux@armlinux.org.uk, 
	horms@kernel.org, florian.fainelli@broadcom.com
Subject: Re: [PATCH net-next v5 2/5] net: stmmac: Add basic dw25gmac support
 in stmmac core
Message-ID: <sn5epdl4jdwj4t6mo55w4poz6vkdcuzceezsmpb7447hmaj2ot@gmlxst7gdcix>
References: <20240904054815.1341712-1-jitendra.vegiraju@broadcom.com>
 <20240904054815.1341712-3-jitendra.vegiraju@broadcom.com>
 <mhfssgiv7unjlpve45rznyzr72llvchcwzk4f7obnvp5edijqc@ilmxqr5gaktb>
 <CAMdnO-+CcCAezDXLwTe7fEZPQH6_B1zLD2g1J6uWiKi12vOxzg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMdnO-+CcCAezDXLwTe7fEZPQH6_B1zLD2g1J6uWiKi12vOxzg@mail.gmail.com>

On Mon, Sep 16, 2024 at 04:32:33PM GMT, Jitendra Vegiraju wrote:
> Hi Serge,
> 
> On Tue, Sep 10, 2024 at 12:25 PM Serge Semin <fancer.lancer@gmail.com> wrote:
> >
> > > +static u32 decode_vdma_count(u32 regval)
> > > +{
> > > +     /* compressed encoding for vdma count
> > > +      * regval: VDMA count
> > > +      * 0-15  : 1 - 16
> > > +      * 16-19 : 20, 24, 28, 32
> > > +      * 20-23 : 40, 48, 56, 64
> > > +      * 24-27 : 80, 96, 112, 128
> > > +      */
> > > +     if (regval < 16)
> > > +             return regval + 1;
> > > +     return (4 << ((regval - 16) / 4)) * ((regval % 4) + 5);
> >
> > The shortest code isn't always the best one. This one gives me a
> > headache in trying to decipher whether it really matches to what is
> > described in the comment. What about just:
> >
> >         if (regval < 16) /* Direct mapping */
> >                 return regval + 1;
> >         else if (regval < 20) /* 20, 24, 28, 32 */
> >                 return 20 + (regval - 16) * 4;
> >         else if (regval < 24) /* 40, 48, 56, 64 */
> >                 return 40 + (regval - 20) * 8;
> >         else if (regval < 28) /* 80, 96, 112, 128 */
> >                 return 80 + (regval - 24) * 16;
> >
> > ?
> Couldn't agree more :)
> Thanks, I will replace it with your code, which is definitely more readable.
> 
> >
> > > +}
> > > +
> > > +static void dw25gmac_read_hdma_limits(void __iomem *ioaddr,
> > > +                                   struct stmmac_hdma_cfg *hdma)
> > > +{
> > > +     u32 hw_cap;
> > > +
> > > +     /* Get VDMA/PDMA counts from HW */
> > > +     hw_cap = readl(ioaddr + XGMAC_HW_FEATURE2);
> >
> >
> > > +     hdma->tx_vdmas = decode_vdma_count(FIELD_GET(XXVGMAC_HWFEAT_VDMA_TXCNT,
> > > +                                                  hw_cap));
> > > +     hdma->rx_vdmas = decode_vdma_count(FIELD_GET(XXVGMAC_HWFEAT_VDMA_RXCNT,
> > > +                                                  hw_cap));
> > > +     hdma->tx_pdmas = FIELD_GET(XGMAC_HWFEAT_TXQCNT, hw_cap) + 1;
> > > +     hdma->rx_pdmas = FIELD_GET(XGMAC_HWFEAT_RXQCNT, hw_cap) + 1;
> >
> > Hmm, these are the Tx/Rx DMA-channels and Tx/Rx MTL-queues count
> > fields. Can't you just use the
> > dma_features::{number_tx_channel,number_tx_queues} and
> > dma_features::{number_rx_channel,number_rx_queues} fields to store the
> > retrieved data?
> >
> > Moreover why not to add the code above to the dwxgmac2_get_hw_feature() method?
> >
> Thanks, I missed the reuse of existing fields.

> However, since the VDMA count has a slightly bigger bitmask, we need to extract
> VDMA channel count as per DW25GMAC spec.
> Instead of duplicating dwxgmac2_get_hw_feature(), should we add wrapper for
> dw25gmac, something like the following?

Yeah, and there is the encoded fields value. Your suggestion sounds
reasonable.

> dw25gmac_get_hw_feature(ioaddr, dma_cap)
> {
>     u32 hw_cap;

>     int rc;

s/rc/ret

+ newline

>     rc = dwxgmac2_get_hw_feature(ioaddr, dma_cap);

newline

>     /* Get VDMA counts from HW */
>     hw_cap = readl(ioaddr + XGMAC_HW_FEATURE2);
>    dma_cap->num_tx_channels =
> decode_vdma_count(FIELD_GET(XXVGMAC_HWFEAT_VDMA_TXCNT,
>      hw_cap));
>    dma_cap->num_rx_channels =
> decode_vdma_count(FIELD_GET(XXVGMAC_HWFEAT_VDMA_RXCNT,
>      hw_cap));

newline

>    return rc;
> }
> 
> > > +}
> > > +
> > > +int dw25gmac_hdma_cfg_init(struct stmmac_priv *priv)
> > > +{
> > > +     struct plat_stmmacenet_data *plat = priv->plat;
> > > +     struct device *dev = priv->device;
> > > +     struct stmmac_hdma_cfg *hdma;
> > > +     int i;
> > > +
> > > +     hdma = devm_kzalloc(dev,
> > > +                         sizeof(*plat->dma_cfg->hdma_cfg),
> > > +                         GFP_KERNEL);
> > > +     if (!hdma)
> > > +             return -ENOMEM;
> > > +
> > > +     dw25gmac_read_hdma_limits(priv->ioaddr, hdma);
> > > +
> > > +     hdma->tvdma_tc = devm_kzalloc(dev,
> > > +                                   sizeof(*hdma->tvdma_tc) * hdma->tx_vdmas,
> > > +                                   GFP_KERNEL);
> > > +     if (!hdma->tvdma_tc)
> > > +             return -ENOMEM;
> > > +
> > > +     hdma->rvdma_tc = devm_kzalloc(dev,
> > > +                                   sizeof(*hdma->rvdma_tc) * hdma->rx_vdmas,
> > > +                                   GFP_KERNEL);
> > > +     if (!hdma->rvdma_tc)
> > > +             return -ENOMEM;
> > > +
> > > +     hdma->tpdma_tc = devm_kzalloc(dev,
> > > +                                   sizeof(*hdma->tpdma_tc) * hdma->tx_pdmas,
> > > +                                   GFP_KERNEL);
> > > +     if (!hdma->tpdma_tc)
> > > +             return -ENOMEM;
> > > +
> > > +     hdma->rpdma_tc = devm_kzalloc(dev,
> > > +                                   sizeof(*hdma->rpdma_tc) * hdma->rx_pdmas,
> > > +                                   GFP_KERNEL);
> > > +     if (!hdma->rpdma_tc)
> > > +             return -ENOMEM;
> > > +
> >
> > > +     /* Initialize one-to-one mapping for each of the used queues */
> > > +     for (i = 0; i < plat->tx_queues_to_use; i++) {
> > > +             hdma->tvdma_tc[i] = i;
> > > +             hdma->tpdma_tc[i] = i;
> > > +     }
> > > +     for (i = 0; i < plat->rx_queues_to_use; i++) {
> > > +             hdma->rvdma_tc[i] = i;
> > > +             hdma->rpdma_tc[i] = i;
> > > +     }
> >
> > So the Traffic Class ID is initialized for the
> > tx_queues_to_use/rx_queues_to_use number of channels only, right? What
> > about the Virtual and Physical DMA-channels with numbers greater than
> > these values?
> >

> You have brought up a question that applies to remaining comments in
> this file as well.
> How the VDMA/PDMA mapping is used depends on the device/glue driver.
> For example in
> our SoC the remaining VDMAs are meant to be used with SRIOV virtual
> functions and not
> all of them are available for physical function.
> Since additional VDMAs/PDMAs remain unused in hardware I let them stay at their
> default values. No traffic is expected to be mapped to unused V/PDMAs.
>  I couldn't think of a reason for it to be an issue from a driver perspective.
> Please let me know, if I am missing something or we need to address a
> use case with bigger scope.
> The responses for following comments also depend on what approach we take here.

If they are unused, then I suggest to follow the KISS principle. See
my last comment for details.

> 
> > > +     plat->dma_cfg->hdma_cfg = hdma;
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +
> > > +void dw25gmac_dma_init(void __iomem *ioaddr,
> > > +                    struct stmmac_dma_cfg *dma_cfg)
> > > +{
> > > +     u32 value;
> > > +     u32 i;
> > > +
> > > +     value = readl(ioaddr + XGMAC_DMA_SYSBUS_MODE);
> > > +     value &= ~(XGMAC_AAL | XGMAC_EAME);
> > > +     if (dma_cfg->aal)
> > > +             value |= XGMAC_AAL;
> > > +     if (dma_cfg->eame)
> > > +             value |= XGMAC_EAME;
> > > +     writel(value, ioaddr + XGMAC_DMA_SYSBUS_MODE);
> > > +
> > > +     for (i = 0; i < dma_cfg->hdma_cfg->tx_vdmas; i++) {
> > > +             value = rd_dma_ch_ind(ioaddr, MODE_TXDESCCTRL, i);
> > > +             value &= ~XXVGMAC_TXDCSZ;
> > > +             value |= FIELD_PREP(XXVGMAC_TXDCSZ,
> > > +                                 XXVGMAC_TXDCSZ_256BYTES);
> > > +             value &= ~XXVGMAC_TDPS;
> > > +             value |= FIELD_PREP(XXVGMAC_TDPS, XXVGMAC_TDPS_HALF);
> > > +             wr_dma_ch_ind(ioaddr, MODE_TXDESCCTRL, i, value);
> > > +     }
> > > +
> > > +     for (i = 0; i < dma_cfg->hdma_cfg->rx_vdmas; i++) {
> > > +             value = rd_dma_ch_ind(ioaddr, MODE_RXDESCCTRL, i);
> > > +             value &= ~XXVGMAC_RXDCSZ;
> > > +             value |= FIELD_PREP(XXVGMAC_RXDCSZ,
> > > +                                 XXVGMAC_RXDCSZ_256BYTES);
> > > +             value &= ~XXVGMAC_RDPS;
> > > +             value |= FIELD_PREP(XXVGMAC_TDPS, XXVGMAC_RDPS_HALF);
> > > +             wr_dma_ch_ind(ioaddr, MODE_RXDESCCTRL, i, value);
> > > +     }
> > > +
> >
> > > +     for (i = 0; i < dma_cfg->hdma_cfg->tx_pdmas; i++) {
> > > +             value = rd_dma_ch_ind(ioaddr, MODE_TXEXTCFG, i);
> > > +             value &= ~(XXVGMAC_TXPBL | XXVGMAC_TPBLX8_MODE);
> > > +             if (dma_cfg->pblx8)
> > > +                     value |= XXVGMAC_TPBLX8_MODE;
> > > +             value |= FIELD_PREP(XXVGMAC_TXPBL, dma_cfg->pbl);
> > > +             wr_dma_ch_ind(ioaddr, MODE_TXEXTCFG, i, value);
> > > +             xgmac4_tp2tc_map(ioaddr, i, dma_cfg->hdma_cfg->tpdma_tc[i]);
> > > +     }
> > > +
> > > +     for (i = 0; i < dma_cfg->hdma_cfg->rx_pdmas; i++) {
> > > +             value = rd_dma_ch_ind(ioaddr, MODE_RXEXTCFG, i);
> > > +             value &= ~(XXVGMAC_RXPBL | XXVGMAC_RPBLX8_MODE);
> > > +             if (dma_cfg->pblx8)
> > > +                     value |= XXVGMAC_RPBLX8_MODE;
> > > +             value |= FIELD_PREP(XXVGMAC_RXPBL, dma_cfg->pbl);
> > > +             wr_dma_ch_ind(ioaddr, MODE_RXEXTCFG, i, value);
> > > +             xgmac4_rp2tc_map(ioaddr, i, dma_cfg->hdma_cfg->rpdma_tc[i]);
> >
> > What if tx_pdmas doesn't match plat_stmmacenet_data::tx_queues_to_use
> > and rx_pdmas doesn't match to plat_stmmacenet_data::rx_queues_to_use?
> >
> > If they don't then you'll get out of the initialized tpdma_tc/rpdma_tc
> > fields and these channels will be pre-initialized with the zero TC. Is
> > that what expected? I doubt so.
> >
> As mentioned in the previous response the remaining resources are unused
> and no traffic is mapped to those resources.
> 
> > > +     }
> > > +}
> > > +
> >
> > > +void dw25gmac_dma_init_tx_chan(struct stmmac_priv *priv,
> > > +                            void __iomem *ioaddr,
> > > +                            struct stmmac_dma_cfg *dma_cfg,
> > > +                            dma_addr_t dma_addr, u32 chan)
> > > +{
> > > +     u32 value;
> > > +
> >
> > > +     value = readl(ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
> > > +     value &= ~XXVGMAC_TVDMA2TCMP;
> > > +     value |= FIELD_PREP(XXVGMAC_TVDMA2TCMP,
> > > +                         dma_cfg->hdma_cfg->tvdma_tc[chan]);
> > > +     writel(value, ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
> >
> > Please note this will have only first
> > plat_stmmacenet_data::{tx_queues_to_use,rx_queues_to_use} VDMA
> > channels initialized. Don't you have much more than just 4 channels?
> >
> Yes, there are 32 VDMA channels on this device. In our application the
> additional channels are partitioned for use with SRIOV virtual functions.
> Similar to PDMA comment above, the additional VDMAs are not enabled,
> and left in default state.
> My thinking is, when another 25gmac device comes along that requires a
> different mapping we may need to add the ability to set the mapping in
> glue driver.
> We can support this by adding a check in dw25gmac_setup()
> @@ -1708,8 +1708,10 @@ int dw25gmac_setup(struct stmmac_priv *priv)
>         mac->mii.clk_csr_shift = 19;
>         mac->mii.clk_csr_mask = GENMASK(21, 19);
> 
> -       /* Allocate and initialize hdma mapping */
> -       return dw25gmac_hdma_cfg_init(priv);
> +       /* Allocate and initialize hdma mapping, if not done by glue driver. */
> +       if (!priv->plat->dma_cfg->hdma_cfg)
> +               return dw25gmac_hdma_cfg_init(priv);
> +       return 0;
>  }

So the use-case is actually hypothetical. Then I don't see a point in
adding the stmmac_hdma_cfg structure. See my last comment for details.

> 
> > > +
> > > +     writel(upper_32_bits(dma_addr),
> > > +            ioaddr + XGMAC_DMA_CH_TxDESC_HADDR(chan));
> > > +     writel(lower_32_bits(dma_addr),
> > > +            ioaddr + XGMAC_DMA_CH_TxDESC_LADDR(chan));
> > > +}
> > > +
> > > +void dw25gmac_dma_init_rx_chan(struct stmmac_priv *priv,
> > > +                            void __iomem *ioaddr,
> > > +                            struct stmmac_dma_cfg *dma_cfg,
> > > +                            dma_addr_t dma_addr, u32 chan)
> > > +{
> > > +     u32 value;
> > > +
> >
> > > +     value = readl(ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan));
> > > +     value &= ~XXVGMAC_RVDMA2TCMP;
> > > +     value |= FIELD_PREP(XXVGMAC_RVDMA2TCMP,
> > > +                         dma_cfg->hdma_cfg->rvdma_tc[chan]);
> > > +     writel(value, ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan));
> >
> > The same question.
> >
> > > +
> > > +     writel(upper_32_bits(dma_addr),
> > > +            ioaddr + XGMAC_DMA_CH_RxDESC_HADDR(chan));
> > > +     writel(lower_32_bits(dma_addr),
> > > +            ioaddr + XGMAC_DMA_CH_RxDESC_LADDR(chan));
> > > +}
> >
> > These methods are called for each
> > plat_stmmacenet_data::{tx_queues_to_use,rx_queues_to_use}
> > DMA-channel/Queue. The static mapping means you'll have each
> > PDMA/Queue assigned a static traffic class ID corresponding to the
> > channel ID. Meanwhile the VDMA channels are supposed to be initialized
> > with the TC ID corresponding to the matching PDMA ID.
> >
> > The TC ID in this case is passed as the DMA/Queue channel ID. Then the
> > Tx/Rx DMA-channels init methods can be converted to:
> >
> > dw25gmac_dma_init_Xx_chan(chan)
> > {
> >         /* Map each chan-th VDMA to the single chan PDMA by assigning
> >          * the static TC ID.
> >          */
> >         for (i = chan; i < Xx_vdmas; i += (Xx_vdmas / Xx_queues_to_use)) {
> >                 /* Initialize VDMA channels */
> >                 XXVGMAC_TVDMA2TCMP = chan;
> >         }
> >
> >         /* Assign the static TC ID to the specified PDMA channel */
> >         xgmac4_rp2tc_map(chan, chan)
> > }
> >
> > , where X={t,r}.
> >
> > Thus you can redistribute the loops implemented in dw25gmac_dma_init()
> > to the respective Tx/Rx DMA-channel init methods.
> >
> > Am I missing something?
> I think your visualization of HDMA may be going beyond the application
> I understand.
> We are allocating a VDMA for each of the TX/RX channels. The use of
> additional VDMAs
> depends on how the device is partitioned for virtualization.
> In the non-SRIOV case the remaining VDMAs will remain unused.
> Please let me know if I missed your question.

So you say that you need a 1:1 mapping between
First-VDMAs:PDMAs/Queues, and there are only
tx_queues_to_use/rx_queues_to_use pairs utilized. Right? If so I don't
really see a need in implementing the overcomplicated solution you
suggest, especially seeing the core driver already supports an
infrastructure for the DMA-Queue managing:
1. Rx path: dwxgmac2_map_mtl_to_dma() - set VDMA-Rx-Queue TC
            dwxgmac2_rx_queue_enable()
2. Tx path: dwxgmac2_dma_tx_mode() - set VDMA-Tx-Queue TC

In the first case the mapping can be changed via the MTL DT-nodes. In
the second case the mapping is one-on-one static. Thus you'll be able
to keep the dw25gmac_dma_init_tx_chan()/dw25gmac_dma_init_rx_chan()
method simple initializing the PBL/Descriptor/etc-related stuff only,
as it's done for the DW QoS Eth and XGMAC/XLGMAC IP-cores.  You won't
need to introduce a new structure stmmac_hdma_cfg, especially either
seeing it is anyway redundant for your use-case.

BTW could you clarify:

1. is the TCes specified for the VDMA/PDMA-queue mapping the same as
the TCs assigned to the Tx-Queues in the MTL_TxQ0_Operation_Mode
register? If they aren't, then what is the relation between them?

2. Similarly, if there is a TC-based Rx VDMA/Queue mapping, then
what's the function of the MTL_RxQ_DMA_MAP* registers?

-Serge(y)

> >
> > -Serge()
> >
> > > [...]

