Return-Path: <bpf+bounces-28106-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 054538B5D3D
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 17:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7148C1F21051
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 15:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1003586AFE;
	Mon, 29 Apr 2024 15:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="us7LGmTF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D2881AB1;
	Mon, 29 Apr 2024 15:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714403327; cv=none; b=b27KXvaqXpoa6OkW0R78j4Bed6/bhGJinEKRSwS3WzHkhy8WY1Ll5/EO0Ce5c4Y33R+FHlTLu9LTar24Drl/J8I4FrtFo3U6mNbn9SK9oOMD6XLT4KTN1zp9LM4QqB3b2MCLgTjioFH5UziyqC6LoR/MKLigMA7YpVJfog420YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714403327; c=relaxed/simple;
	bh=Bjx5gl49VFSc1mqMjIvCV5QyXb/r8anmZ/JpE0QNtUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SBkfRHdgey3TyJy8MLKVR+c4RVxDuU6mQCt4mUt/I6UsiY1u5tShMKL2epPMtqRLRls8ApPtoVZH33bfAi710p/0w82LgEYpw38gTgHiyowUCTPSgzKG8ywxXa6N0EfZirNTWEAnIwkXHMwYY1VTDNJRswUtZoGXK9v1I3rgVMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=us7LGmTF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C04FDC113CD;
	Mon, 29 Apr 2024 15:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714403327;
	bh=Bjx5gl49VFSc1mqMjIvCV5QyXb/r8anmZ/JpE0QNtUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=us7LGmTFUvR9qlbeUavr2vBJcXJDL8YupNIJWRuGGcSIHSRK4yNIbx4/nUELan+bZ
	 QVsidnDrL639ZmuSN3im/wf0UNl6w2TSUCXIJFRvewc0mLD5fuR26XScAWn5avm3XV
	 A0ROdl0dX1LU0BNMhth7be8WguEn8VJnJEtUkP1P1liOaGQX6GmG3FKWWM9n6aKZsb
	 B/7mN+rhOnzjJFTgAikEbyPTvJxYtFLfNFqdj0UqDlC6CtZnbdBHngvSU07lni3+xX
	 fTJnQHpcZxlg10cVvTU1OB/CAjY1g0Oy1kxilp6iNBSZ8Wr4L+2OjYPySzjolPDRGE
	 CIqox8Qm+aG/A==
Date: Mon, 29 Apr 2024 10:08:42 -0500
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 08/11] PCI: imx: Config look up table(LUT) to support
 MSI ITS and IOMMU for i.MX95
Message-ID: <20240429150842.GC1709920-robh@kernel.org>
References: <20240402-pci2_upstream-v3-0-803414bdb430@nxp.com>
 <20240402-pci2_upstream-v3-8-803414bdb430@nxp.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402-pci2_upstream-v3-8-803414bdb430@nxp.com>

On Tue, Apr 02, 2024 at 10:33:44AM -0400, Frank Li wrote:
> i.MX95 need config LUT to convert bpf to stream id. IOMMU and ITS use the
> same stream id. Check msi-map and smmu-map and make sure the same PCI bpf
> map to the same stream id. Then config LUT related registers.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/controller/dwc/pcie-imx.c | 175 ++++++++++++++++++++++++++++++++++
>  1 file changed, 175 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-imx.c b/drivers/pci/controller/dwc/pcie-imx.c
> index af0f960f28757..653d8e8ee1abc 100644
> --- a/drivers/pci/controller/dwc/pcie-imx.c
> +++ b/drivers/pci/controller/dwc/pcie-imx.c
> @@ -55,6 +55,22 @@
>  #define IMX95_PE0_GEN_CTRL_3			0x1058
>  #define IMX95_PCIE_LTSSM_EN			BIT(0)
>  
> +#define IMX95_PE0_LUT_ACSCTRL			0x1008
> +#define IMX95_PEO_LUT_RWA			BIT(16)
> +#define IMX95_PE0_LUT_ENLOC			GENMASK(4, 0)
> +
> +#define IMX95_PE0_LUT_DATA1			0x100c
> +#define IMX95_PE0_LUT_VLD			BIT(31)
> +#define IMX95_PE0_LUT_DAC_ID			GENMASK(10, 8)
> +#define IMX95_PE0_LUT_STREAM_ID			GENMASK(5, 0)
> +
> +#define IMX95_PE0_LUT_DATA2			0x1010
> +#define IMX95_PE0_LUT_REQID			GENMASK(31, 16)
> +#define IMX95_PE0_LUT_MASK			GENMASK(15, 0)
> +
> +#define IMX95_SID_MASK				GENMASK(5, 0)
> +#define IMX95_MAX_LUT				32
> +
>  #define to_imx_pcie(x)	dev_get_drvdata((x)->dev)
>  
>  enum imx_pcie_variants {
> @@ -217,6 +233,159 @@ static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
>  	return 0;
>  }
>  
> +static int imx_pcie_update_lut(struct imx_pcie *imx_pcie, int index, u16 reqid, u16 mask, u8 sid)
> +{
> +	struct dw_pcie *pci = imx_pcie->pci;
> +	struct device *dev = pci->dev;
> +	u32 data1, data2;
> +
> +	if (sid >= 64) {
> +		dev_err(dev, "Too big stream id: %d\n", sid);
> +		return -EINVAL;
> +	}
> +
> +	data1 = FIELD_PREP(IMX95_PE0_LUT_DAC_ID, 0);
> +	data1 |= FIELD_PREP(IMX95_PE0_LUT_STREAM_ID, sid);
> +	data1 |= IMX95_PE0_LUT_VLD;
> +
> +	regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, data1);
> +
> +	data2 = mask;
> +	data2 |= FIELD_PREP(IMX95_PE0_LUT_REQID, reqid);
> +
> +	regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, data2);
> +
> +	regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, index);
> +
> +	return 0;
> +}
> +
> +struct imx_of_map {
> +	u32 bdf;
> +	u32 phandle;
> +	u32 sid;
> +	u32 sid_len;
> +};
> +
> +static int imx_check_msi_and_smmmu(struct imx_pcie *imx_pcie,
> +				   struct imx_of_map *msi_map, u32 msi_size, u32 msi_map_mask,
> +				   struct imx_of_map *smmu_map, u32 smmu_size, u32 smmu_map_mask)
> +{
> +	struct dw_pcie *pci = imx_pcie->pci;
> +	struct device *dev = pci->dev;
> +	int i;
> +
> +	if (msi_map && smmu_map) {
> +		if (msi_size != smmu_size)
> +			return -EINVAL;
> +		if (msi_map_mask != smmu_map_mask)
> +			return -EINVAL;
> +
> +		for (i = 0; i < msi_size / sizeof(*msi_map); i++) {
> +			if (msi_map->bdf != smmu_map->bdf) {
> +				dev_err(dev, "bdf setting is not match\n");
> +				return -EINVAL;
> +			}
> +			if ((msi_map->sid & IMX95_SID_MASK) != smmu_map->sid) {
> +				dev_err(dev, "sid setting is not match\n");
> +				return -EINVAL;
> +			}
> +			if ((msi_map->sid_len & IMX95_SID_MASK) != smmu_map->sid_len) {
> +				dev_err(dev, "sid_len setting is not match\n");
> +				return -EINVAL;
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Simple static config lut according to dts settings DAC index and stream ID used as a match result
> + * of LUT pre-allocated and used by PCIes.
> + *
> + * Currently stream ID from 32-64 for PCIe.
> + * 32-40: first PCI bus.
> + * 40-48: second PCI bus.
> + *
> + * DAC_ID is index of TRDC.DAC index, start from 2 at iMX95.
> + * ITS [pci(2bit): streamid(6bits)]
> + *	pci 0 is 0
> + *	pci 1 is 3
> + */
> +static int imx_pcie_config_sid(struct imx_pcie *imx_pcie)
> +{
> +	struct imx_of_map *msi_map = NULL, *smmu_map = NULL, *cur;
> +	int i, j, lut_index, nr_map, msi_size = 0, smmu_size = 0;
> +	u32 msi_map_mask = 0xffff, smmu_map_mask = 0xffff;
> +	struct dw_pcie *pci = imx_pcie->pci;
> +	struct device *dev = pci->dev;
> +	u32 mask;
> +	int size;
> +
> +	of_get_property(dev->of_node, "msi-map", &msi_size);
> +	if (msi_size) {
> +		msi_map = devm_kzalloc(dev, msi_size, GFP_KERNEL);
> +		if (!msi_map)
> +			return -ENOMEM;
> +
> +		if (of_property_read_u32_array(dev->of_node, "msi-map", (u32 *)msi_map,
> +					       msi_size / sizeof(u32)))
> +			return -EINVAL;
> +
> +		of_property_read_u32(dev->of_node, "msi-map-mask", &msi_map_mask);
> +	}
> +
> +	cur = msi_map;
> +	size = msi_size;
> +	mask = msi_map_mask;
> +
> +	of_get_property(dev->of_node, "iommu-map", &smmu_size);
> +	if (smmu_size) {
> +		smmu_map = devm_kzalloc(dev, smmu_size, GFP_KERNEL);
> +		if (!smmu_map)
> +			return -ENOMEM;
> +
> +		if (of_property_read_u32_array(dev->of_node, "iommu-map", (u32 *)smmu_map,
> +					       smmu_size / sizeof(u32)))
> +			return -EINVAL;
> +
> +		of_property_read_u32(dev->of_node, "iommu_map_mask", &smmu_map_mask);
> +	}

You should not be doing your own parsing of these properties.

Rob

