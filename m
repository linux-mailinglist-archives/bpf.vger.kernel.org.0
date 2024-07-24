Return-Path: <bpf+bounces-35543-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E70A893B5AD
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 19:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 155681C2048D
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 17:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F45115F41F;
	Wed, 24 Jul 2024 17:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ba98B9Mf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B02161FCA
	for <bpf@vger.kernel.org>; Wed, 24 Jul 2024 17:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721841375; cv=none; b=fdnUWYDtBB7xkxVVMSnTHYH6YAVvVwEmGSTP8v/VnAM3dd3FM5Y9tl8zzMl22Va4RMCsqNowx4Mtr01WZ0jZhrLNIPRDfNjXgseNY8gAiqgVwkQ3jIFN13E0l+wB4/Irt4ayIIC5ORp84qoaSCD2NkPrf5cB6TuRRuds5Zy5dwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721841375; c=relaxed/simple;
	bh=/dU1cNTdY041Xy/3w5RX1KY4WSmaNnazUS/PFk5FsOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l19novZoGc1Jj4Q6WuEPn3oRGkUbRkN4Ex3ATYsHuRpHJY8RdMhds0v/wao+qllpP1CrIabf7xN8/ACIizpzkE0+Ejotvifzr+Wb8ebO9Ov5MfNCZIETEXEHyNqmGKAI2uH0m7beRti0wAV4hotDu9Llj4LZIss/MGxqsysRJp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ba98B9Mf; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70d24d0a8d4so32476b3a.0
        for <bpf@vger.kernel.org>; Wed, 24 Jul 2024 10:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721841373; x=1722446173; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KyaQp44nnXsTM0SAEoKII/fnYGZT7U9n/kUXWtnFy+k=;
        b=ba98B9MfVz33RY81CWmwNZltow55SPcUoearRvNnFl0lDVofhcEtbmT5pdf7pdWoe4
         44u1kKTV5+pL0A8noQtvv+cDWGzwgsUfsNx7wrSzeWsGoDkQmpdFjDlu+gphLr2YmE9B
         cOilBOWqHG7P8CsBeieYZI8JB/fKVkw+hCC9mhq/qDa+LNtggUoKoRZMNYVq8ZoKkKzg
         hrqtifx6r0bnWrodrjBdnxl3eHtqiTK7yYB/uSHdDw/2OBZlw7pbj9Nj81iEYIrJ2EJD
         V+KV2OFBcvxRJ8W4i2LkCSEE7jlPtxGOjNCDJAwL/Nv1ooilVtrC1ED9Qc9PXmMsCkV/
         sNWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721841373; x=1722446173;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KyaQp44nnXsTM0SAEoKII/fnYGZT7U9n/kUXWtnFy+k=;
        b=ZznInueix6ZdH7+9OL9w0T2d3qTeAWw5Pz/lltZ9IUgMEa+G96Hc9450cs8KzMty6E
         UIkBi6bpvRy3DXXyDjLpOuMm2+88q7cdynM1IgPwl1N41+x5Kr+YX5EaPn73g6+MSKZp
         630FYMI3CzpKqqPVkhwrd5Kn83sdXo+URbGKYNRRheoRdEz37BUxZJpoxpaBCdeUCshw
         uszTD58COgT4fYGI2NZ1isCNp2xhvoeR2NP0kbktFeKCb/S0sUcrIFfKo7Xz9ruYkDfh
         3wTmTGrYufhK4sh4KaR3OowPrpeUWi3i2eYXPlCAW82egzxxrlE+9PxM6fdabXoD8lvA
         KBLA==
X-Forwarded-Encrypted: i=1; AJvYcCVpusYiXA8PCxVGiZ3hAV455M/VOCZW34+Yd00m6b2zKLYRNuQwQ1E4PI44BCnvJBxp06abWcddrrHfA4sMv7cETqms
X-Gm-Message-State: AOJu0Yx7anx4ibB9GnQWrYDXg5xDVLKJeH41EM8CI/5BQwl00YTuXB64
	XIP4h+KpN6I9wyYuGL2vy/1aXHAM1SWtq6Bxu+eOqxcTTxNFa1mQ8zgsF2/XNg==
X-Google-Smtp-Source: AGHT+IET+3PrzjkCJC0X6yQ8Z+hpWLYS7lVlEf69KG5hRlXm3bRMfzaAU7Yy57uPgRvipPcNBD5QFg==
X-Received: by 2002:a05:6a00:8592:b0:70e:a4ef:e5c2 with SMTP id d2e1a72fcca58-70eaa885078mr212774b3a.13.1721841372739;
        Wed, 24 Jul 2024 10:16:12 -0700 (PDT)
Received: from thinkpad ([103.244.168.26])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70cff4b8166sm8760869b3a.85.2024.07.24.10.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 10:16:12 -0700 (PDT)
Date: Wed, 24 Jul 2024 22:46:05 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v7 04/10] PCI: imx6: Introduce SoC specific callbacks for
 controlling REFCLK
Message-ID: <20240724171605.GJ3349@thinkpad>
References: <20240708-pci2_upstream-v7-0-ac00b8174f89@nxp.com>
 <20240708-pci2_upstream-v7-4-ac00b8174f89@nxp.com>
 <20240721075634.GC1908@thinkpad>
 <Zp53yUlVmmEk2rAU@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zp53yUlVmmEk2rAU@lizhi-Precision-Tower-5810>

On Mon, Jul 22, 2024 at 11:16:25AM -0400, Frank Li wrote:
> On Sun, Jul 21, 2024 at 01:26:34PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Jul 08, 2024 at 01:08:08PM -0400, Frank Li wrote:
> > > Instead of using the switch case statement to enable/disable the reference
> > > clock handled by this driver itself, let's introduce a new callback
> > > enable_ref_clk() and define it for platforms that require it. This
> > > simplifies the code.
> > > 
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >  drivers/pci/controller/dwc/pci-imx6.c | 111 ++++++++++++++++------------------
> > >  1 file changed, 51 insertions(+), 60 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > > index 47134e2dfecf2..dbcb70186036e 100644
> > > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > > @@ -103,6 +103,7 @@ struct imx_pcie_drvdata {
> > >  	const u32 mode_mask[IMX_PCIE_MAX_INSTANCES];
> > >  	const struct pci_epc_features *epc_features;
> > >  	int (*init_phy)(struct imx_pcie *pcie);
> > > +	int (*enable_ref_clk)(struct imx_pcie *pcie, bool enable);
> > >  };
> > >  
> > >  struct imx_pcie {
> > > @@ -585,21 +586,20 @@ static int imx_pcie_attach_pd(struct device *dev)
> > >  	return 0;
> > >  }
> > >  
> > > -static int imx_pcie_enable_ref_clk(struct imx_pcie *imx_pcie)
> > > +static int imx6sx_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
> > >  {
> > > -	unsigned int offset;
> > > -	int ret = 0;
> > > +	if (enable)
> > > +		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
> > > +				  IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
> > 
> > Since all SoCs except IMX6Q/6QP doesn't have both enable/disable controls (which
> > is very weird btw), you can have separate enable/disable callbacks and just
> > populate the ones that require.
> 
> I think old code is wrong, which depended on hardware reset value. It
> should paired between enable/disable. I just want to keep the same logic
> here as old code. I have another patches to improve these. This patch
> series were already big, I want to do it after these patch merged.
> 
> Is it okay?
> 

Fine with me.

- Mani

> Frank
>  
> > 
> > This way it becomes clear which SoC is supporting what. If you have a common
> > helper and just toggle based on a bool, then it becomes hard to follow.
> > 
> > - Mani
> > 
> > >  
> > > -	switch (imx_pcie->drvdata->variant) {
> > > -	case IMX6SX:
> > > -		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
> > > -				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN, 0);
> > > -		break;
> > > -	case IMX6QP:
> > > -	case IMX6Q:
> > > +	return 0;
> > > +}
> > > +
> > > +static int imx6q_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
> > > +{
> > > +	if (enable) {
> > >  		/* power up core phy and enable ref clock */
> > > -		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> > > -				   IMX6Q_GPR1_PCIE_TEST_PD, 0 << 18);
> > > +		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_TEST_PD);
> > >  		/*
> > >  		 * the async reset input need ref clock to sync internally,
> > >  		 * when the ref clock comes after reset, internal synced
> > > @@ -607,55 +607,33 @@ static int imx_pcie_enable_ref_clk(struct imx_pcie *imx_pcie)
> > >  		 * add one ~10us delay here.
> > >  		 */
> > >  		usleep_range(10, 100);
> > > -		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> > > -				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
> > > -		break;
> > > -	case IMX7D:
> > > -	case IMX95:
> > > -	case IMX95_EP:
> > > -		break;
> > > -	case IMX8MM:
> > > -	case IMX8MM_EP:
> > > -	case IMX8MQ:
> > > -	case IMX8MQ_EP:
> > > -	case IMX8MP:
> > > -	case IMX8MP_EP:
> > > -		offset = imx_pcie_grp_offset(imx_pcie);
> > > -		/*
> > > -		 * Set the over ride low and enabled
> > > -		 * make sure that REF_CLK is turned on.
> > > -		 */
> > > -		regmap_update_bits(imx_pcie->iomuxc_gpr, offset,
> > > -				   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE,
> > > -				   0);
> > > -		regmap_update_bits(imx_pcie->iomuxc_gpr, offset,
> > > -				   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN,
> > > -				   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN);
> > > -		break;
> > > +		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_REF_CLK_EN);
> > > +	} else {
> > > +		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_REF_CLK_EN);
> > > +		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_TEST_PD);
> > >  	}
> > >  
> > > -	return ret;
> > > +	return 0;
> > >  }
> > >  
> > > -static void imx_pcie_disable_ref_clk(struct imx_pcie *imx_pcie)
> > > +static int imx8mm_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
> > >  {
> > > -	switch (imx_pcie->drvdata->variant) {
> > > -	case IMX6QP:
> > > -	case IMX6Q:
> > > -		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> > > -				IMX6Q_GPR1_PCIE_REF_CLK_EN, 0);
> > > -		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> > > -				IMX6Q_GPR1_PCIE_TEST_PD,
> > > -				IMX6Q_GPR1_PCIE_TEST_PD);
> > > -		break;
> > > -	case IMX7D:
> > > -		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
> > > -				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
> > > -				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
> > > -		break;
> > > -	default:
> > > -		break;
> > > +	int offset = imx_pcie_grp_offset(imx_pcie);
> > > +
> > > +	if (enable) {
> > > +		regmap_clear_bits(imx_pcie->iomuxc_gpr, offset, IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE);
> > > +		regmap_set_bits(imx_pcie->iomuxc_gpr, offset, IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN);
> > >  	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int imx7d_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
> > > +{
> > > +	if (!enable)
> > > +		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
> > > +				IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
> > > +	return 0;
> > >  }
> > >  
> > >  static int imx_pcie_clk_enable(struct imx_pcie *imx_pcie)
> > > @@ -668,10 +646,12 @@ static int imx_pcie_clk_enable(struct imx_pcie *imx_pcie)
> > >  	if (ret)
> > >  		return ret;
> > >  
> > > -	ret = imx_pcie_enable_ref_clk(imx_pcie);
> > > -	if (ret) {
> > > -		dev_err(dev, "unable to enable pcie ref clock\n");
> > > -		goto err_ref_clk;
> > > +	if (imx_pcie->drvdata->enable_ref_clk) {
> > > +		ret = imx_pcie->drvdata->enable_ref_clk(imx_pcie, true);
> > > +		if (ret) {
> > > +			dev_err(dev, "Failed to enable PCIe REFCLK\n");
> > > +			goto err_ref_clk;
> > > +		}
> > >  	}
> > >  
> > >  	/* allow the clocks to stabilize */
> > > @@ -686,7 +666,8 @@ static int imx_pcie_clk_enable(struct imx_pcie *imx_pcie)
> > >  
> > >  static void imx_pcie_clk_disable(struct imx_pcie *imx_pcie)
> > >  {
> > > -	imx_pcie_disable_ref_clk(imx_pcie);
> > > +	if (imx_pcie->drvdata->enable_ref_clk)
> > > +		imx_pcie->drvdata->enable_ref_clk(imx_pcie, false);
> > >  	clk_bulk_disable_unprepare(imx_pcie->drvdata->clks_cnt, imx_pcie->clks);
> > >  }
> > >  
> > > @@ -1475,6 +1456,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
> > >  		.mode_off[0] = IOMUXC_GPR12,
> > >  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
> > >  		.init_phy = imx_pcie_init_phy,
> > > +		.enable_ref_clk = imx6q_pcie_enable_ref_clk,
> > >  	},
> > >  	[IMX6SX] = {
> > >  		.variant = IMX6SX,
> > > @@ -1489,6 +1471,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
> > >  		.mode_off[0] = IOMUXC_GPR12,
> > >  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
> > >  		.init_phy = imx6sx_pcie_init_phy,
> > > +		.enable_ref_clk = imx6sx_pcie_enable_ref_clk,
> > >  	},
> > >  	[IMX6QP] = {
> > >  		.variant = IMX6QP,
> > > @@ -1504,6 +1487,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
> > >  		.mode_off[0] = IOMUXC_GPR12,
> > >  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
> > >  		.init_phy = imx_pcie_init_phy,
> > > +		.enable_ref_clk = imx6q_pcie_enable_ref_clk,
> > >  	},
> > >  	[IMX7D] = {
> > >  		.variant = IMX7D,
> > > @@ -1516,6 +1500,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
> > >  		.mode_off[0] = IOMUXC_GPR12,
> > >  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
> > >  		.init_phy = imx7d_pcie_init_phy,
> > > +		.enable_ref_clk = imx7d_pcie_enable_ref_clk,
> > >  	},
> > >  	[IMX8MQ] = {
> > >  		.variant = IMX8MQ,
> > > @@ -1529,6 +1514,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
> > >  		.mode_off[1] = IOMUXC_GPR12,
> > >  		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
> > >  		.init_phy = imx8mq_pcie_init_phy,
> > > +		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
> > >  	},
> > >  	[IMX8MM] = {
> > >  		.variant = IMX8MM,
> > > @@ -1540,6 +1526,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
> > >  		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
> > >  		.mode_off[0] = IOMUXC_GPR12,
> > >  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
> > > +		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
> > >  	},
> > >  	[IMX8MP] = {
> > >  		.variant = IMX8MP,
> > > @@ -1551,6 +1538,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
> > >  		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
> > >  		.mode_off[0] = IOMUXC_GPR12,
> > >  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
> > > +		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
> > >  	},
> > >  	[IMX95] = {
> > >  		.variant = IMX95,
> > > @@ -1577,6 +1565,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
> > >  		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
> > >  		.epc_features = &imx8m_pcie_epc_features,
> > >  		.init_phy = imx8mq_pcie_init_phy,
> > > +		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
> > >  	},
> > >  	[IMX8MM_EP] = {
> > >  		.variant = IMX8MM_EP,
> > > @@ -1589,6 +1578,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
> > >  		.mode_off[0] = IOMUXC_GPR12,
> > >  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
> > >  		.epc_features = &imx8m_pcie_epc_features,
> > > +		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
> > >  	},
> > >  	[IMX8MP_EP] = {
> > >  		.variant = IMX8MP_EP,
> > > @@ -1601,6 +1591,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
> > >  		.mode_off[0] = IOMUXC_GPR12,
> > >  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
> > >  		.epc_features = &imx8m_pcie_epc_features,
> > > +		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
> > >  	},
> > >  	[IMX95_EP] = {
> > >  		.variant = IMX95_EP,
> > > 
> > > -- 
> > > 2.34.1
> > > 
> > 
> > -- 
> > மணிவண்ணன் சதாசிவம்
> 

-- 
மணிவண்ணன் சதாசிவம்

