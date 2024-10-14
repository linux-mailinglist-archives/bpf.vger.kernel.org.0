Return-Path: <bpf+bounces-41881-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F25C99D66A
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 20:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F181B21FCA
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 18:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5641C9B7A;
	Mon, 14 Oct 2024 18:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="e1FKL3W7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225DE1C831A
	for <bpf@vger.kernel.org>; Mon, 14 Oct 2024 18:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728930297; cv=none; b=tl22O1Yf5u6bCRSNRI0IGH/4d9ZCPVeiecu0H6yeoyA67QQocL83/KogH+1m8B1Rkfn/KL0VfSpY5dWpdY0PrvVci1M/9OVIlp4P86wBpSdCwqj1jtFUEgoWi2PxTs0734SljbJcdGjizikhbeCJf0jF38HmccbrLjyxTJseOFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728930297; c=relaxed/simple;
	bh=ZviL4SD0SPwnmZAqn9IceugqvwcopwFYok+DgZfQNQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=siDv/kjTzi1MUw73GE7/K8+5/pFQDn/iBezQOycxbJs90I82J7q8bVL89QUwOOo5zGZmU07V350ee23RnKal2L2Dp3b64HZFM9YPwekN/+GnodXC/TGGnrwr6XXzgKN8KcHVmYZWcAIWkf+CxdtFXYlvq+3fMI9HXRi4/d6m+YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=e1FKL3W7; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7db90a28cf6so3822366a12.0
        for <bpf@vger.kernel.org>; Mon, 14 Oct 2024 11:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728930294; x=1729535094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yEAtlm8aW4w81QuxKsQllg3gsuzIyEarbwweY5HANGo=;
        b=e1FKL3W7WW9VLRuUOLOfh6FEUQUiK0UDVptUDaKUL2GM/ZMzPCO+1UZy4p+8utKYXb
         YK7sWlXl5unQF8fd3fIRDN3+RLKTcOi+uCrAoxP1Ve+I8OTnmp5HONiGdUugxPMxKEUr
         X5Pc1WyEp0Iio7FRIPoHOck0etWPKFCek2ilQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728930294; x=1729535094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yEAtlm8aW4w81QuxKsQllg3gsuzIyEarbwweY5HANGo=;
        b=J3NlthgNHqay6cS0LqYGSGQBCVt/HcbfyzouqcHWRa6Zehj+ZTPRP+5jC9IK+F6Rv1
         Q10udETlPqrD9xO92FAjZJpN7zgpDirvnfDrYiH3NXnvxq0Zzo2mFeNS19j7SzipfVUo
         WGinuTm3l2XuYnZirSNwvRCyPfxftRkTI0Bul1Sr2MGJlGaonzzGD5yBns8S/GyVbkRy
         BJORzslsGvJUc/cP2qlVIyNE+uoOwElcCwM40TPr2MNJrFA7MKy8NUiBT6qpibKsVibb
         VfrI9vIUv1J+MwQbuJcoBIYlgCnSYqaXejiQdKD4BD5aDoF4P/zD3kR1rH/4zUDfiiK2
         pjxg==
X-Forwarded-Encrypted: i=1; AJvYcCXqYxb8KTdmvDFQvqz2DqzMae+w8SNiA+ongMZkX2zFTgp3+s3xxn3LKYbxchORvpbgO9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX2VnAOwsE4Elru+bgv6+P9e1MeC+97PCYesZgryh5m2Kv3bvx
	KcDJK132k02obGs/Vrs697zC0LlxZBbYdAzOC3Gr91Uo9WveQXlY0/o8sv5TXYInv9+Irlzr5Yi
	j4ZuC1fdCfXYx94LGIcZu2fzziJR30pC1Bbkc
X-Google-Smtp-Source: AGHT+IHr3YNUwZWay+7cynwxgML3zAFDQzJd/5AHx3h9tKWwjz/nfzsRu1/+bo/FLVV6AKwZyvhbN7TU1lEpxNrY278=
X-Received: by 2002:a17:90a:a00b:b0:2e2:a96b:2ccb with SMTP id
 98e67ed59e1d1-2e2c802a7b1mr23666648a91.7.1728930294194; Mon, 14 Oct 2024
 11:24:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904054815.1341712-1-jitendra.vegiraju@broadcom.com>
 <20240904054815.1341712-3-jitendra.vegiraju@broadcom.com> <mhfssgiv7unjlpve45rznyzr72llvchcwzk4f7obnvp5edijqc@ilmxqr5gaktb>
 <CAMdnO-+CcCAezDXLwTe7fEZPQH6_B1zLD2g1J6uWiKi12vOxzg@mail.gmail.com> <sn5epdl4jdwj4t6mo55w4poz6vkdcuzceezsmpb7447hmaj2ot@gmlxst7gdcix>
In-Reply-To: <sn5epdl4jdwj4t6mo55w4poz6vkdcuzceezsmpb7447hmaj2ot@gmlxst7gdcix>
From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Date: Mon, 14 Oct 2024 11:24:42 -0700
Message-ID: <CAMdnO-JjbK2ajLwrs42ftThp56Bt9kBjVaFRG5wWLj545WjSzQ@mail.gmail.com>
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
Thanks for the feedback.
On Thu, Oct 10, 2024 at 4:55=E2=80=AFPM Serge Semin <fancer.lancer@gmail.co=
m> wrote:
>
> On Mon, Sep 16, 2024 at 04:32:33PM GMT, Jitendra Vegiraju wrote:
> > Hi Serge,
> >
> > On Tue, Sep 10, 2024 at 12:25=E2=80=AFPM Serge Semin <fancer.lancer@gma=
il.com> wrote:
> > >
> > > > +static u32 decode_vdma_count(u32 regval)
> > > > +{
> > > > +     /* compressed encoding for vdma count
> > > > +      * regval: VDMA count
> > > > +      * 0-15  : 1 - 16
> > > > +      * 16-19 : 20, 24, 28, 32
> > > > +      * 20-23 : 40, 48, 56, 64
> > > > +      * 24-27 : 80, 96, 112, 128
> > > > +      */
> > > > +     if (regval < 16)
> > > > +             return regval + 1;
> > > > +     return (4 << ((regval - 16) / 4)) * ((regval % 4) + 5);
> > >
> > > The shortest code isn't always the best one. This one gives me a
> > > headache in trying to decipher whether it really matches to what is
> > > described in the comment. What about just:
> > >
> > >         if (regval < 16) /* Direct mapping */
> > >                 return regval + 1;
> > >         else if (regval < 20) /* 20, 24, 28, 32 */
> > >                 return 20 + (regval - 16) * 4;
> > >         else if (regval < 24) /* 40, 48, 56, 64 */
> > >                 return 40 + (regval - 20) * 8;
> > >         else if (regval < 28) /* 80, 96, 112, 128 */
> > >                 return 80 + (regval - 24) * 16;
> > >
> > > ?
> > Couldn't agree more :)
> > Thanks, I will replace it with your code, which is definitely more read=
able.
> >
> > >
> > > > +}
> > > > +
> > > > +static void dw25gmac_read_hdma_limits(void __iomem *ioaddr,
> > > > +                                   struct stmmac_hdma_cfg *hdma)
> > > > +{
> > > > +     u32 hw_cap;
> > > > +
> > > > +     /* Get VDMA/PDMA counts from HW */
> > > > +     hw_cap =3D readl(ioaddr + XGMAC_HW_FEATURE2);
> > >
> > >
> > > > +     hdma->tx_vdmas =3D decode_vdma_count(FIELD_GET(XXVGMAC_HWFEAT=
_VDMA_TXCNT,
> > > > +                                                  hw_cap));
> > > > +     hdma->rx_vdmas =3D decode_vdma_count(FIELD_GET(XXVGMAC_HWFEAT=
_VDMA_RXCNT,
> > > > +                                                  hw_cap));
> > > > +     hdma->tx_pdmas =3D FIELD_GET(XGMAC_HWFEAT_TXQCNT, hw_cap) + 1=
;
> > > > +     hdma->rx_pdmas =3D FIELD_GET(XGMAC_HWFEAT_RXQCNT, hw_cap) + 1=
;
> > >
> > > Hmm, these are the Tx/Rx DMA-channels and Tx/Rx MTL-queues count
> > > fields. Can't you just use the
> > > dma_features::{number_tx_channel,number_tx_queues} and
> > > dma_features::{number_rx_channel,number_rx_queues} fields to store th=
e
> > > retrieved data?
> > >
> > > Moreover why not to add the code above to the dwxgmac2_get_hw_feature=
() method?
> > >
> > Thanks, I missed the reuse of existing fields.
>
> > However, since the VDMA count has a slightly bigger bitmask, we need to=
 extract
> > VDMA channel count as per DW25GMAC spec.
> > Instead of duplicating dwxgmac2_get_hw_feature(), should we add wrapper=
 for
> > dw25gmac, something like the following?
>
> Yeah, and there is the encoded fields value. Your suggestion sounds
> reasonable.
>
> > dw25gmac_get_hw_feature(ioaddr, dma_cap)
> > {
> >     u32 hw_cap;
>
> >     int rc;
>
> s/rc/ret
>
> + newline
>
> >     rc =3D dwxgmac2_get_hw_feature(ioaddr, dma_cap);
>
> newline
>
> >     /* Get VDMA counts from HW */
> >     hw_cap =3D readl(ioaddr + XGMAC_HW_FEATURE2);
> >    dma_cap->num_tx_channels =3D
> > decode_vdma_count(FIELD_GET(XXVGMAC_HWFEAT_VDMA_TXCNT,
> >      hw_cap));
> >    dma_cap->num_rx_channels =3D
> > decode_vdma_count(FIELD_GET(XXVGMAC_HWFEAT_VDMA_RXCNT,
> >      hw_cap));
>
> newline
>
Ack
> >    return rc;
> > }
> >
> > > > +}
> > > > +
> > > > +int dw25gmac_hdma_cfg_init(struct stmmac_priv *priv)
> > > > +{
> > > > +     struct plat_stmmacenet_data *plat =3D priv->plat;
> > > > +     struct device *dev =3D priv->device;
> > > > +     struct stmmac_hdma_cfg *hdma;
> > > > +     int i;
> > > > +
> > > > +     hdma =3D devm_kzalloc(dev,
> > > > +                         sizeof(*plat->dma_cfg->hdma_cfg),
> > > > +                         GFP_KERNEL);
> > > > +     if (!hdma)
> > > > +             return -ENOMEM;
> > > > +
> > > > +     dw25gmac_read_hdma_limits(priv->ioaddr, hdma);
> > > > +
> > > > +     hdma->tvdma_tc =3D devm_kzalloc(dev,
> > > > +                                   sizeof(*hdma->tvdma_tc) * hdma-=
>tx_vdmas,
> > > > +                                   GFP_KERNEL);
> > > > +     if (!hdma->tvdma_tc)
> > > > +             return -ENOMEM;
> > > > +
> > > > +     hdma->rvdma_tc =3D devm_kzalloc(dev,
> > > > +                                   sizeof(*hdma->rvdma_tc) * hdma-=
>rx_vdmas,
> > > > +                                   GFP_KERNEL);
> > > > +     if (!hdma->rvdma_tc)
> > > > +             return -ENOMEM;
> > > > +
> > > > +     hdma->tpdma_tc =3D devm_kzalloc(dev,
> > > > +                                   sizeof(*hdma->tpdma_tc) * hdma-=
>tx_pdmas,
> > > > +                                   GFP_KERNEL);
> > > > +     if (!hdma->tpdma_tc)
> > > > +             return -ENOMEM;
> > > > +
> > > > +     hdma->rpdma_tc =3D devm_kzalloc(dev,
> > > > +                                   sizeof(*hdma->rpdma_tc) * hdma-=
>rx_pdmas,
> > > > +                                   GFP_KERNEL);
> > > > +     if (!hdma->rpdma_tc)
> > > > +             return -ENOMEM;
> > > > +
> > >
> > > > +     /* Initialize one-to-one mapping for each of the used queues =
*/
> > > > +     for (i =3D 0; i < plat->tx_queues_to_use; i++) {
> > > > +             hdma->tvdma_tc[i] =3D i;
> > > > +             hdma->tpdma_tc[i] =3D i;
> > > > +     }
> > > > +     for (i =3D 0; i < plat->rx_queues_to_use; i++) {
> > > > +             hdma->rvdma_tc[i] =3D i;
> > > > +             hdma->rpdma_tc[i] =3D i;
> > > > +     }
> > >
> > > So the Traffic Class ID is initialized for the
> > > tx_queues_to_use/rx_queues_to_use number of channels only, right? Wha=
t
> > > about the Virtual and Physical DMA-channels with numbers greater than
> > > these values?
> > >
>
> > You have brought up a question that applies to remaining comments in
> > this file as well.
> > How the VDMA/PDMA mapping is used depends on the device/glue driver.
> > For example in
> > our SoC the remaining VDMAs are meant to be used with SRIOV virtual
> > functions and not
> > all of them are available for physical function.
> > Since additional VDMAs/PDMAs remain unused in hardware I let them stay =
at their
> > default values. No traffic is expected to be mapped to unused V/PDMAs.
> >  I couldn't think of a reason for it to be an issue from a driver persp=
ective.
> > Please let me know, if I am missing something or we need to address a
> > use case with bigger scope.
> > The responses for following comments also depend on what approach we ta=
ke here.
>
> If they are unused, then I suggest to follow the KISS principle. See
> my last comment for details.
>
> >
> > > > +     plat->dma_cfg->hdma_cfg =3D hdma;
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +
> > > > +void dw25gmac_dma_init(void __iomem *ioaddr,
> > > > +                    struct stmmac_dma_cfg *dma_cfg)
> > > > +{
> > > > +     u32 value;
> > > > +     u32 i;
> > > > +
> > > > +     value =3D readl(ioaddr + XGMAC_DMA_SYSBUS_MODE);
> > > > +     value &=3D ~(XGMAC_AAL | XGMAC_EAME);
> > > > +     if (dma_cfg->aal)
> > > > +             value |=3D XGMAC_AAL;
> > > > +     if (dma_cfg->eame)
> > > > +             value |=3D XGMAC_EAME;
> > > > +     writel(value, ioaddr + XGMAC_DMA_SYSBUS_MODE);
> > > > +
> > > > +     for (i =3D 0; i < dma_cfg->hdma_cfg->tx_vdmas; i++) {
> > > > +             value =3D rd_dma_ch_ind(ioaddr, MODE_TXDESCCTRL, i);
> > > > +             value &=3D ~XXVGMAC_TXDCSZ;
> > > > +             value |=3D FIELD_PREP(XXVGMAC_TXDCSZ,
> > > > +                                 XXVGMAC_TXDCSZ_256BYTES);
> > > > +             value &=3D ~XXVGMAC_TDPS;
> > > > +             value |=3D FIELD_PREP(XXVGMAC_TDPS, XXVGMAC_TDPS_HALF=
);
> > > > +             wr_dma_ch_ind(ioaddr, MODE_TXDESCCTRL, i, value);
> > > > +     }
> > > > +
> > > > +     for (i =3D 0; i < dma_cfg->hdma_cfg->rx_vdmas; i++) {
> > > > +             value =3D rd_dma_ch_ind(ioaddr, MODE_RXDESCCTRL, i);
> > > > +             value &=3D ~XXVGMAC_RXDCSZ;
> > > > +             value |=3D FIELD_PREP(XXVGMAC_RXDCSZ,
> > > > +                                 XXVGMAC_RXDCSZ_256BYTES);
> > > > +             value &=3D ~XXVGMAC_RDPS;
> > > > +             value |=3D FIELD_PREP(XXVGMAC_TDPS, XXVGMAC_RDPS_HALF=
);
> > > > +             wr_dma_ch_ind(ioaddr, MODE_RXDESCCTRL, i, value);
> > > > +     }
> > > > +
> > >
> > > > +     for (i =3D 0; i < dma_cfg->hdma_cfg->tx_pdmas; i++) {
> > > > +             value =3D rd_dma_ch_ind(ioaddr, MODE_TXEXTCFG, i);
> > > > +             value &=3D ~(XXVGMAC_TXPBL | XXVGMAC_TPBLX8_MODE);
> > > > +             if (dma_cfg->pblx8)
> > > > +                     value |=3D XXVGMAC_TPBLX8_MODE;
> > > > +             value |=3D FIELD_PREP(XXVGMAC_TXPBL, dma_cfg->pbl);
> > > > +             wr_dma_ch_ind(ioaddr, MODE_TXEXTCFG, i, value);
> > > > +             xgmac4_tp2tc_map(ioaddr, i, dma_cfg->hdma_cfg->tpdma_=
tc[i]);
> > > > +     }
> > > > +
> > > > +     for (i =3D 0; i < dma_cfg->hdma_cfg->rx_pdmas; i++) {
> > > > +             value =3D rd_dma_ch_ind(ioaddr, MODE_RXEXTCFG, i);
> > > > +             value &=3D ~(XXVGMAC_RXPBL | XXVGMAC_RPBLX8_MODE);
> > > > +             if (dma_cfg->pblx8)
> > > > +                     value |=3D XXVGMAC_RPBLX8_MODE;
> > > > +             value |=3D FIELD_PREP(XXVGMAC_RXPBL, dma_cfg->pbl);
> > > > +             wr_dma_ch_ind(ioaddr, MODE_RXEXTCFG, i, value);
> > > > +             xgmac4_rp2tc_map(ioaddr, i, dma_cfg->hdma_cfg->rpdma_=
tc[i]);
> > >
> > > What if tx_pdmas doesn't match plat_stmmacenet_data::tx_queues_to_use
> > > and rx_pdmas doesn't match to plat_stmmacenet_data::rx_queues_to_use?
> > >
> > > If they don't then you'll get out of the initialized tpdma_tc/rpdma_t=
c
> > > fields and these channels will be pre-initialized with the zero TC. I=
s
> > > that what expected? I doubt so.
> > >
> > As mentioned in the previous response the remaining resources are unuse=
d
> > and no traffic is mapped to those resources.
> >
> > > > +     }
> > > > +}
> > > > +
> > >
> > > > +void dw25gmac_dma_init_tx_chan(struct stmmac_priv *priv,
> > > > +                            void __iomem *ioaddr,
> > > > +                            struct stmmac_dma_cfg *dma_cfg,
> > > > +                            dma_addr_t dma_addr, u32 chan)
> > > > +{
> > > > +     u32 value;
> > > > +
> > >
> > > > +     value =3D readl(ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
> > > > +     value &=3D ~XXVGMAC_TVDMA2TCMP;
> > > > +     value |=3D FIELD_PREP(XXVGMAC_TVDMA2TCMP,
> > > > +                         dma_cfg->hdma_cfg->tvdma_tc[chan]);
> > > > +     writel(value, ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
> > >
> > > Please note this will have only first
> > > plat_stmmacenet_data::{tx_queues_to_use,rx_queues_to_use} VDMA
> > > channels initialized. Don't you have much more than just 4 channels?
> > >
> > Yes, there are 32 VDMA channels on this device. In our application the
> > additional channels are partitioned for use with SRIOV virtual function=
s.
> > Similar to PDMA comment above, the additional VDMAs are not enabled,
> > and left in default state.
> > My thinking is, when another 25gmac device comes along that requires a
> > different mapping we may need to add the ability to set the mapping in
> > glue driver.
> > We can support this by adding a check in dw25gmac_setup()
> > @@ -1708,8 +1708,10 @@ int dw25gmac_setup(struct stmmac_priv *priv)
> >         mac->mii.clk_csr_shift =3D 19;
> >         mac->mii.clk_csr_mask =3D GENMASK(21, 19);
> >
> > -       /* Allocate and initialize hdma mapping */
> > -       return dw25gmac_hdma_cfg_init(priv);
> > +       /* Allocate and initialize hdma mapping, if not done by glue dr=
iver. */
> > +       if (!priv->plat->dma_cfg->hdma_cfg)
> > +               return dw25gmac_hdma_cfg_init(priv);
> > +       return 0;
> >  }
>
> So the use-case is actually hypothetical. Then I don't see a point in
> adding the stmmac_hdma_cfg structure. See my last comment for details.
>
Yes, It's better to not over-complicate the  patch for the hypothetical cas=
e.
I will remove the new struct in next update.
> >
> > > > +
> > > > +     writel(upper_32_bits(dma_addr),
> > > > +            ioaddr + XGMAC_DMA_CH_TxDESC_HADDR(chan));
> > > > +     writel(lower_32_bits(dma_addr),
> > > > +            ioaddr + XGMAC_DMA_CH_TxDESC_LADDR(chan));
> > > > +}
> > > > +
> > > > +void dw25gmac_dma_init_rx_chan(struct stmmac_priv *priv,
> > > > +                            void __iomem *ioaddr,
> > > > +                            struct stmmac_dma_cfg *dma_cfg,
> > > > +                            dma_addr_t dma_addr, u32 chan)
> > > > +{
> > > > +     u32 value;
> > > > +
> > >
> > > > +     value =3D readl(ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan));
> > > > +     value &=3D ~XXVGMAC_RVDMA2TCMP;
> > > > +     value |=3D FIELD_PREP(XXVGMAC_RVDMA2TCMP,
> > > > +                         dma_cfg->hdma_cfg->rvdma_tc[chan]);
> > > > +     writel(value, ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan));
> > >
> > > The same question.
> > >
> > > > +
> > > > +     writel(upper_32_bits(dma_addr),
> > > > +            ioaddr + XGMAC_DMA_CH_RxDESC_HADDR(chan));
> > > > +     writel(lower_32_bits(dma_addr),
> > > > +            ioaddr + XGMAC_DMA_CH_RxDESC_LADDR(chan));
> > > > +}
> > >
> > > These methods are called for each
> > > plat_stmmacenet_data::{tx_queues_to_use,rx_queues_to_use}
> > > DMA-channel/Queue. The static mapping means you'll have each
> > > PDMA/Queue assigned a static traffic class ID corresponding to the
> > > channel ID. Meanwhile the VDMA channels are supposed to be initialize=
d
> > > with the TC ID corresponding to the matching PDMA ID.
> > >
> > > The TC ID in this case is passed as the DMA/Queue channel ID. Then th=
e
> > > Tx/Rx DMA-channels init methods can be converted to:
> > >
> > > dw25gmac_dma_init_Xx_chan(chan)
> > > {
> > >         /* Map each chan-th VDMA to the single chan PDMA by assigning
> > >          * the static TC ID.
> > >          */
> > >         for (i =3D chan; i < Xx_vdmas; i +=3D (Xx_vdmas / Xx_queues_t=
o_use)) {
> > >                 /* Initialize VDMA channels */
> > >                 XXVGMAC_TVDMA2TCMP =3D chan;
> > >         }
> > >
> > >         /* Assign the static TC ID to the specified PDMA channel */
> > >         xgmac4_rp2tc_map(chan, chan)
> > > }
> > >
> > > , where X=3D{t,r}.
> > >
> > > Thus you can redistribute the loops implemented in dw25gmac_dma_init(=
)
> > > to the respective Tx/Rx DMA-channel init methods.
> > >
> > > Am I missing something?
> > I think your visualization of HDMA may be going beyond the application
> > I understand.
> > We are allocating a VDMA for each of the TX/RX channels. The use of
> > additional VDMAs
> > depends on how the device is partitioned for virtualization.
> > In the non-SRIOV case the remaining VDMAs will remain unused.
> > Please let me know if I missed your question.
>
> So you say that you need a 1:1 mapping between
> First-VDMAs:PDMAs/Queues, and there are only
> tx_queues_to_use/rx_queues_to_use pairs utilized. Right? If so I don't
> really see a need in implementing the overcomplicated solution you
> suggest, especially seeing the core driver already supports an
> infrastructure for the DMA-Queue managing:
> 1. Rx path: dwxgmac2_map_mtl_to_dma() - set VDMA-Rx-Queue TC
>             dwxgmac2_rx_queue_enable()
> 2. Tx path: dwxgmac2_dma_tx_mode() - set VDMA-Tx-Queue TC
>
> In the first case the mapping can be changed via the MTL DT-nodes. In
> the second case the mapping is one-on-one static. Thus you'll be able
> to keep the dw25gmac_dma_init_tx_chan()/dw25gmac_dma_init_rx_chan()
> method simple initializing the PBL/Descriptor/etc-related stuff only,
> as it's done for the DW QoS Eth and XGMAC/XLGMAC IP-cores.  You won't
> need to introduce a new structure stmmac_hdma_cfg, especially either
> seeing it is anyway redundant for your use-case.
>
> BTW could you clarify:
>
> 1. is the TCes specified for the VDMA/PDMA-queue mapping the same as
> the TCs assigned to the Tx-Queues in the MTL_TxQ0_Operation_Mode
> register? If they aren't, then what is the relation between them?
>
In register documentation for HDMA XGMAC IP, the Q2TCMAP field in
MTL_TxQ0_Operation_Mode is marked as *reserved" and is ignored.
The VDMA->TC->PDMA mapping is used for DMA scheduling.

This static mapping can be done in dw25gmac_dma_init_tx_chan() and
dw25gmac_dma_init_rx_chan().

> 2. Similarly, if there is a TC-based Rx VDMA/Queue mapping, then
> what's the function of the MTL_RxQ_DMA_MAP* registers?

In the RX direction MTL_RxQ_DMA_MAP* decides the VDMA channel for a
given RXQ.
The TC for VDMA channel is decided by VDMA/TC mapping. Then TC to
PDMA mapping is used to pick PDMA for actual DMA operation.

>
> -Serge(y)
>
> > >
> > > -Serge()
> > >
> > > > [...]

