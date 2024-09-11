Return-Path: <bpf+bounces-39609-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFFB9754F7
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 16:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5CEC28636C
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 14:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D96D19AD6E;
	Wed, 11 Sep 2024 14:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ui2yWa6X"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81F83FB30;
	Wed, 11 Sep 2024 14:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726063645; cv=none; b=E/XDH7Fod9M3nH1svMa4mSxz6AXDsApXEcVh4ImeGw4v0jtSLhtWsCH9mdFxXlk752XCIi/7p6Gk1KFiF/rRm1zgEb6auRgBkhI3gBG6bUwCCsFIha47x245/ltACHSHy1YrTjsjwQmZeHIOSOpxlk5KmF3hnEWyJwsea3icQBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726063645; c=relaxed/simple;
	bh=r0VvpXAuRXJx3vp8kOdxd9EfYvbZyCGak9YTxgXyHb8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=TFlmKhu9N5v3SGTbHFQs/NY2ibxnbOJ5g3Ji1L2idV5S+FJ9lDh+8gLWXz7MRFsnp+X/KARJoDaavmj4WeEgurKZoeC6pYculpjQITgR9hpYrkzmLS+gTwIB/TcjTE0K5JwI0eMS2SmpvuMPichnqEPvZVRPHlVVT/GW7SOoO00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ui2yWa6X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF78C4CEC0;
	Wed, 11 Sep 2024 14:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726063644;
	bh=r0VvpXAuRXJx3vp8kOdxd9EfYvbZyCGak9YTxgXyHb8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Ui2yWa6X7iHBcYX32/ca4LD22AvNygh2Ug4YOmwLYA9yyXx6mvGowmxulmtdIU2HZ
	 W+eIT5oLdMpjIRTHHDNABHENAX4LrY3RvFufefCYRfDH8UKXZ0JmeI3PodOXZ4fu+r
	 QIWBke5DZvVffSmhdVEaUwJmdixtmqDoRNoeWAiPv4ZgtS8AG/GjkL/sgWWoXLWBep
	 foHnfwi4hoHXJOgofT1LDz+ndLl3HX4N/RRQW15jECNO8X/8vPLvxU+tFh+/Ac7MgK
	 2oJU9c8wORLWW0N7a/mm88UM2faha4DMEe2cuF3WTLsD4OSUlCsaM4rVX3pZijbx3R
	 c/iR8ZWcJNT/A==
Date: Wed, 11 Sep 2024 09:07:21 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
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
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	devicetree@vger.kernel.org, Qianqiang Liu <qianqiang.liu@163.com>
Subject: Re: [PATCH v8 11/11] PCI: imx6: Add i.MX8Q PCIe root complex (RC)
 support
Message-ID: <20240911140721.GA630378@bhelgaas>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729-pci2_upstream-v8-11-b68ee5ef2b4d@nxp.com>

[+cc Qianqiang]

On Mon, Jul 29, 2024 at 04:18:18PM -0400, Frank Li wrote:
> From: Richard Zhu <hongxing.zhu@nxp.com>
> 
> Implement i.MX8Q (i.MX8QM, i.MX8QXP, and i.MX8DXL) PCIe RC support. While
> the controller resembles that of iMX8MP, the PHY differs significantly.
> Notably, there's a distinction between PCI bus addresses and CPU addresses.
> 
> Introduce IMX_PCIE_FLAG_CPU_ADDR_FIXUP in drvdata::flags to indicate driver
> need the cpu_addr_fixup() callback to facilitate CPU address to PCI bus
> address conversion according to "ranges" property.

> +static u64 imx_pcie_cpu_addr_fixup(struct dw_pcie *pcie, u64 cpu_addr)
> +{
> +	struct imx_pcie *imx_pcie = to_imx_pcie(pcie);
> +	struct dw_pcie_rp *pp = &pcie->pp;
> +	struct resource_entry *entry;
> +	unsigned int offset;
> +
> +	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_CPU_ADDR_FIXUP))
> +		return cpu_addr;
> +
> +	entry = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
> +	offset = entry->offset;
> +	return (cpu_addr - offset);
> +}

I'm sure that with enough effort, we could prove "entry" cannot be
NULL here, but I'm not sure I want to spend the effort, and we're
going to end up with more patches like this:

  https://lore.kernel.org/r/20240911125055.58555-1-qianqiang.liu@163.com

I propose this minor change:

  entry = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
  if (!entry)
    return cpu_addr;

  return cpu_addr - entry->offset;

I still think we should get rid of the .cpu_addr_fixup() callback if
possible.  But that's a discussion for another day.

Bjorn

