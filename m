Return-Path: <bpf+bounces-40962-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D419908B4
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 18:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80B5BB24BAE
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 16:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD4A1AA7AD;
	Fri,  4 Oct 2024 16:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="F3qc8Qd3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284F61E3766
	for <bpf@vger.kernel.org>; Fri,  4 Oct 2024 16:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728057952; cv=none; b=O8NY/3iEK5yPiGep0dkwnmTO5W4ecbUPkya9YlBjaxUDrl93AF+CX2nVpn1WFEn2n36p2vTn1QkpXxxqCTVLlwXNnm6mRSSFHVMRE9qZ6jDK0uw2+CSyoPhVx5e1Ett75artvbTDtBgHdUPB+WcADSP2Cr5LgSS7+ENl5AvQvVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728057952; c=relaxed/simple;
	bh=C8+E70IFc21tJxm8gLF2f1jcbOmUmoHB0iUH41CAWSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bwQWZQJduu7HtGEAoCjaWa4Ak5pcWCVGsUAnDvrxSZjDyQPt+GXAmvWADa3ccIRwzWXJk3cV9II1qhLr9cL9ikYgiw0rYQa5x6tk5vZgkNhOmmUumvqb1TEjImqyMMEM3orbgopyUMyxxxRZei8ueibuF0k9H12O7gC7wCL2EmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=F3qc8Qd3; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71def715ebdso268395b3a.2
        for <bpf@vger.kernel.org>; Fri, 04 Oct 2024 09:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728057949; x=1728662749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8DgA6gQLk526uv5nFhNrX9l/ATz98WfN6ETaxfWgW3g=;
        b=F3qc8Qd3RjfKHYvn1G8MhMrSkkKzqTD75KL1qmbtaRLu0HCDGDRuPf4+O60MYQrHnp
         63ptz+/JYMzh8zsMUgNpcgfBEYVuRmxJq9g2hX61IYmaltQpTn2DH9LJsOIo6m6Fo8e6
         6H6iymPv424qWY1ll0cbUEMEaOrKeXTv4w9Kg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728057949; x=1728662749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8DgA6gQLk526uv5nFhNrX9l/ATz98WfN6ETaxfWgW3g=;
        b=QYQhE6krXRn2Lxp2r1ei9CvmDWpLlYF24TibhUafGFIDdBJg/OJ+Bh1HghcRGKtE0e
         zfEKD3iE6IEqumYPKpeEDhDRb9LoDsNpZajwOwNf4Wg3pC3DTYjGIUurzJ+EUWdk+AR8
         LOQmnbTDvWcYOnnaSXHQ15j50dR+tbNPW075rEDUkZfnHH+9s9P5f+jU8mXMYQ+CyZW9
         8NroVH7pzZjU0Sn7lxW5xss/5rlSxwR0LpWafwpMiKWyk9JBBzZC/aJaAG86q95lIczb
         3oGfi/FbaxkIk4T2Le0KcfD1gV3EkuKHRm7HvT9d/UDwu4jUE0IKc7zoPdGIAXG+m6j5
         69YA==
X-Forwarded-Encrypted: i=1; AJvYcCW46vDFNw5KPBlYV+uAbXoNjJnRGEMR4ckuQZUjjIYFEObYTt2sbJFltFt+kUntbnbm8j0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSodTNV4lvbGrT5Y8rJ5nXd1BPAEVuYWMoiJzQySZR/9u9FQno
	ao2eat8EhSXMTAvdwNJi7LTdhL+zRE+bfxxrKIvnyfAOJy+a0nsWE+fvTcOOhP2I1fSDF+hMhuK
	S7uDjssyoMZloLtd4GV+ZWFhEkInFGhcIEXC4
X-Google-Smtp-Source: AGHT+IHrvnHw3FVjvTTNKr1bqXznfvQlmxItSYcov9d1t4vebXm+9FqwtiPXmIQyXN0EnDWTP6aS6+x4KFr52zqJG+s=
X-Received: by 2002:a05:6a00:a09:b0:710:5848:8ae1 with SMTP id
 d2e1a72fcca58-71de239d27bmr5411024b3a.4.1728057949123; Fri, 04 Oct 2024
 09:05:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904054815.1341712-1-jitendra.vegiraju@broadcom.com>
 <20240904054815.1341712-3-jitendra.vegiraju@broadcom.com> <mhfssgiv7unjlpve45rznyzr72llvchcwzk4f7obnvp5edijqc@ilmxqr5gaktb>
 <CAMdnO-+CcCAezDXLwTe7fEZPQH6_B1zLD2g1J6uWiKi12vOxzg@mail.gmail.com>
In-Reply-To: <CAMdnO-+CcCAezDXLwTe7fEZPQH6_B1zLD2g1J6uWiKi12vOxzg@mail.gmail.com>
From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Date: Fri, 4 Oct 2024 09:05:36 -0700
Message-ID: <CAMdnO-JZ2crBaOEtvgMupQs7nTZ8r0_7TTQdX3B3n6F_owAMZA@mail.gmail.com>
Subject: Re: [PATCH net-next v5 2/5] net: stmmac: Add basic dw25gmac support
 in stmmac core
To: Serge Semin <fancer.lancer@gmail.com>
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mcoquelin.stm32@gmail.com, bcm-kernel-feedback-list@broadcom.com, 
	richardcochran@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, rmk+kernel@armlinux.org.uk, 
	ahalaney@redhat.com, xiaolei.wang@windriver.com, rohan.g.thomas@intel.com, 
	Jianheng.Zhang@synopsys.com, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, andrew@lunn.ch, 
	linux@armlinux.org.uk, horms@kernel.org, florian.fainelli@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Serge,

On Mon, Sep 16, 2024 at 4:32=E2=80=AFPM Jitendra Vegiraju
<jitendra.vegiraju@broadcom.com> wrote:
>
> Hi Serge,
>
> On Tue, Sep 10, 2024 at 12:25=E2=80=AFPM Serge Semin <fancer.lancer@gmail=
.com> wrote:
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
> Thanks, I will replace it with your code, which is definitely more readab=
le.
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
> > > +     hw_cap =3D readl(ioaddr + XGMAC_HW_FEATURE2);
> >
> >
> > > +     hdma->tx_vdmas =3D decode_vdma_count(FIELD_GET(XXVGMAC_HWFEAT_V=
DMA_TXCNT,
> > > +                                                  hw_cap));
> > > +     hdma->rx_vdmas =3D decode_vdma_count(FIELD_GET(XXVGMAC_HWFEAT_V=
DMA_RXCNT,
> > > +                                                  hw_cap));
> > > +     hdma->tx_pdmas =3D FIELD_GET(XGMAC_HWFEAT_TXQCNT, hw_cap) + 1;
> > > +     hdma->rx_pdmas =3D FIELD_GET(XGMAC_HWFEAT_RXQCNT, hw_cap) + 1;
> >
> > Hmm, these are the Tx/Rx DMA-channels and Tx/Rx MTL-queues count
> > fields. Can't you just use the
> > dma_features::{number_tx_channel,number_tx_queues} and
> > dma_features::{number_rx_channel,number_rx_queues} fields to store the
> > retrieved data?
> >
> > Moreover why not to add the code above to the dwxgmac2_get_hw_feature()=
 method?
> >
> Thanks, I missed the reuse of existing fields.
> However, since the VDMA count has a slightly bigger bitmask, we need to e=
xtract
> VDMA channel count as per DW25GMAC spec.
> Instead of duplicating dwxgmac2_get_hw_feature(), should we add wrapper f=
or
> dw25gmac, something like the following?
> dw25gmac_get_hw_feature(ioaddr, dma_cap)
> {
>     u32 hw_cap;
>     int rc;
>     rc =3D dwxgmac2_get_hw_feature(ioaddr, dma_cap);
>     /* Get VDMA counts from HW */
>     hw_cap =3D readl(ioaddr + XGMAC_HW_FEATURE2);
>    dma_cap->num_tx_channels =3D
> decode_vdma_count(FIELD_GET(XXVGMAC_HWFEAT_VDMA_TXCNT,
>      hw_cap));
>    dma_cap->num_rx_channels =3D
> decode_vdma_count(FIELD_GET(XXVGMAC_HWFEAT_VDMA_RXCNT,
>      hw_cap));
>    return rc;
> }
>
> > > +}
> > > +
> > > +int dw25gmac_hdma_cfg_init(struct stmmac_priv *priv)
> > > +{
> > > +     struct plat_stmmacenet_data *plat =3D priv->plat;
> > > +     struct device *dev =3D priv->device;
> > > +     struct stmmac_hdma_cfg *hdma;
> > > +     int i;
> > > +
> > > +     hdma =3D devm_kzalloc(dev,
> > > +                         sizeof(*plat->dma_cfg->hdma_cfg),
> > > +                         GFP_KERNEL);
> > > +     if (!hdma)
> > > +             return -ENOMEM;
> > > +
> > > +     dw25gmac_read_hdma_limits(priv->ioaddr, hdma);
> > > +
> > > +     hdma->tvdma_tc =3D devm_kzalloc(dev,
> > > +                                   sizeof(*hdma->tvdma_tc) * hdma->t=
x_vdmas,
> > > +                                   GFP_KERNEL);
> > > +     if (!hdma->tvdma_tc)
> > > +             return -ENOMEM;
> > > +
> > > +     hdma->rvdma_tc =3D devm_kzalloc(dev,
> > > +                                   sizeof(*hdma->rvdma_tc) * hdma->r=
x_vdmas,
> > > +                                   GFP_KERNEL);
> > > +     if (!hdma->rvdma_tc)
> > > +             return -ENOMEM;
> > > +
> > > +     hdma->tpdma_tc =3D devm_kzalloc(dev,
> > > +                                   sizeof(*hdma->tpdma_tc) * hdma->t=
x_pdmas,
> > > +                                   GFP_KERNEL);
> > > +     if (!hdma->tpdma_tc)
> > > +             return -ENOMEM;
> > > +
> > > +     hdma->rpdma_tc =3D devm_kzalloc(dev,
> > > +                                   sizeof(*hdma->rpdma_tc) * hdma->r=
x_pdmas,
> > > +                                   GFP_KERNEL);
> > > +     if (!hdma->rpdma_tc)
> > > +             return -ENOMEM;
> > > +
> >
> > > +     /* Initialize one-to-one mapping for each of the used queues */
> > > +     for (i =3D 0; i < plat->tx_queues_to_use; i++) {
> > > +             hdma->tvdma_tc[i] =3D i;
> > > +             hdma->tpdma_tc[i] =3D i;
> > > +     }
> > > +     for (i =3D 0; i < plat->rx_queues_to_use; i++) {
> > > +             hdma->rvdma_tc[i] =3D i;
> > > +             hdma->rpdma_tc[i] =3D i;
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
> Since additional VDMAs/PDMAs remain unused in hardware I let them stay at=
 their
> default values. No traffic is expected to be mapped to unused V/PDMAs.
>  I couldn't think of a reason for it to be an issue from a driver perspec=
tive.
> Please let me know, if I am missing something or we need to address a
> use case with bigger scope.
> The responses for following comments also depend on what approach we take=
 here.
>
> > > +     plat->dma_cfg->hdma_cfg =3D hdma;
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
> > > +     value =3D readl(ioaddr + XGMAC_DMA_SYSBUS_MODE);
> > > +     value &=3D ~(XGMAC_AAL | XGMAC_EAME);
> > > +     if (dma_cfg->aal)
> > > +             value |=3D XGMAC_AAL;
> > > +     if (dma_cfg->eame)
> > > +             value |=3D XGMAC_EAME;
> > > +     writel(value, ioaddr + XGMAC_DMA_SYSBUS_MODE);
> > > +
> > > +     for (i =3D 0; i < dma_cfg->hdma_cfg->tx_vdmas; i++) {
> > > +             value =3D rd_dma_ch_ind(ioaddr, MODE_TXDESCCTRL, i);
> > > +             value &=3D ~XXVGMAC_TXDCSZ;
> > > +             value |=3D FIELD_PREP(XXVGMAC_TXDCSZ,
> > > +                                 XXVGMAC_TXDCSZ_256BYTES);
> > > +             value &=3D ~XXVGMAC_TDPS;
> > > +             value |=3D FIELD_PREP(XXVGMAC_TDPS, XXVGMAC_TDPS_HALF);
> > > +             wr_dma_ch_ind(ioaddr, MODE_TXDESCCTRL, i, value);
> > > +     }
> > > +
> > > +     for (i =3D 0; i < dma_cfg->hdma_cfg->rx_vdmas; i++) {
> > > +             value =3D rd_dma_ch_ind(ioaddr, MODE_RXDESCCTRL, i);
> > > +             value &=3D ~XXVGMAC_RXDCSZ;
> > > +             value |=3D FIELD_PREP(XXVGMAC_RXDCSZ,
> > > +                                 XXVGMAC_RXDCSZ_256BYTES);
> > > +             value &=3D ~XXVGMAC_RDPS;
> > > +             value |=3D FIELD_PREP(XXVGMAC_TDPS, XXVGMAC_RDPS_HALF);
> > > +             wr_dma_ch_ind(ioaddr, MODE_RXDESCCTRL, i, value);
> > > +     }
> > > +
> >
> > > +     for (i =3D 0; i < dma_cfg->hdma_cfg->tx_pdmas; i++) {
> > > +             value =3D rd_dma_ch_ind(ioaddr, MODE_TXEXTCFG, i);
> > > +             value &=3D ~(XXVGMAC_TXPBL | XXVGMAC_TPBLX8_MODE);
> > > +             if (dma_cfg->pblx8)
> > > +                     value |=3D XXVGMAC_TPBLX8_MODE;
> > > +             value |=3D FIELD_PREP(XXVGMAC_TXPBL, dma_cfg->pbl);
> > > +             wr_dma_ch_ind(ioaddr, MODE_TXEXTCFG, i, value);
> > > +             xgmac4_tp2tc_map(ioaddr, i, dma_cfg->hdma_cfg->tpdma_tc=
[i]);
> > > +     }
> > > +
> > > +     for (i =3D 0; i < dma_cfg->hdma_cfg->rx_pdmas; i++) {
> > > +             value =3D rd_dma_ch_ind(ioaddr, MODE_RXEXTCFG, i);
> > > +             value &=3D ~(XXVGMAC_RXPBL | XXVGMAC_RPBLX8_MODE);
> > > +             if (dma_cfg->pblx8)
> > > +                     value |=3D XXVGMAC_RPBLX8_MODE;
> > > +             value |=3D FIELD_PREP(XXVGMAC_RXPBL, dma_cfg->pbl);
> > > +             wr_dma_ch_ind(ioaddr, MODE_RXEXTCFG, i, value);
> > > +             xgmac4_rp2tc_map(ioaddr, i, dma_cfg->hdma_cfg->rpdma_tc=
[i]);
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
> > > +     value =3D readl(ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
> > > +     value &=3D ~XXVGMAC_TVDMA2TCMP;
> > > +     value |=3D FIELD_PREP(XXVGMAC_TVDMA2TCMP,
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
>         mac->mii.clk_csr_shift =3D 19;
>         mac->mii.clk_csr_mask =3D GENMASK(21, 19);
>
> -       /* Allocate and initialize hdma mapping */
> -       return dw25gmac_hdma_cfg_init(priv);
> +       /* Allocate and initialize hdma mapping, if not done by glue driv=
er. */
> +       if (!priv->plat->dma_cfg->hdma_cfg)
> +               return dw25gmac_hdma_cfg_init(priv);
> +       return 0;
>  }
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
> > > +     value =3D readl(ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan));
> > > +     value &=3D ~XXVGMAC_RVDMA2TCMP;
> > > +     value |=3D FIELD_PREP(XXVGMAC_RVDMA2TCMP,
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
> >         for (i =3D chan; i < Xx_vdmas; i +=3D (Xx_vdmas / Xx_queues_to_=
use)) {
> >                 /* Initialize VDMA channels */
> >                 XXVGMAC_TVDMA2TCMP =3D chan;
> >         }
> >
> >         /* Assign the static TC ID to the specified PDMA channel */
> >         xgmac4_rp2tc_map(chan, chan)
> > }
> >
> > , where X=3D{t,r}.
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
> >
> > -Serge()
> >
> > > [...]

When you get a chance, I would like to get your input on the approach we ne=
ed
to take to incrementally add dw25gmac support.

In the last conversation there were some open questions around the case of
initializing unused VDMA channels and related combination scenarios.

The hdma mapping provides flexibility for virtualization. However, our
SoC device cannot use all VDMAs with one PCI function. The VDMAs are
partitioned for SRIOV use in the firmware. This SoC defaults to 8 functions
with 4 VDMA channels each. The initial effort is to support one PCI physica=
l
function with 4 VDMA channels.
Also, currently the stmmac driver has inferred one-to-one relation between
netif channels and physical DMAs. It would be a complex change to support
each VDMA as its own netif channel and mapping fewer physical DMAs.
Hence, for initial submission one-to-one mapping is assumed.

As you mentioned, a static one-to-one mapping of VDMA-TC-PDMA doesn't
require the additional complexity of managing these mappings as proposed
in the current patch series with *struct stmmac_hdma_cfg*.

To introduce dw25gmac incrementally, I am thinking of two approaches,
  1. Take the current patch series forward using *struct stmmac_hdma_cfg*,
     keeping the unused VDMAs in default state. We need to fix the
initialization
     loops to only initialize the VDMA and PDMAs being used.
  2. Simplify the initial patch by removing *struct hdma_cfg* from the patc=
h
     series and still use static VDMA-TC-PDMA mapping.
Please share your thoughts.
If it helps, I can send patch series with option 2 above after
addressing all other
review comments.

Appreciate your guidance!
-Jitendra

