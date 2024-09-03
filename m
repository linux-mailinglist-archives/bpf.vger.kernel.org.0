Return-Path: <bpf+bounces-38747-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39020969111
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 03:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC91C1F22532
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 01:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59FB1CCEDD;
	Tue,  3 Sep 2024 01:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+QeXC2X"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F341CCED9;
	Tue,  3 Sep 2024 01:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725328170; cv=none; b=Mp27Ce4jJcdla1f4fpC+eHy2jIaoCCnWU1dEayWHer0WVjNORf6aDPBEGynkrfY2khEyvwGWMTQzYiK1RKlqPYKOV6F8kRq096vbA8AWRMG2C5eZoQkEm20Erzz7G5f3V3faauAVjWFSzBz6GJo+NhpZH4MKea30lqO6tllJdxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725328170; c=relaxed/simple;
	bh=MYd+BDZHjT4A49/uPMG3JKdeSg29HklOPqAeNtZYWOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OmLRmpl3g80+up3s6JN655JLehkFlbeO4yhab40wvF4Z7nGLnIC/Ity0k5z1QMFqcYf69cDJpTJD4cxMcsuTQx6P5DUb3IgJvmjz0TbXgP7BdHbtvxs+dMglbjtZkemh7CiYhrpds0db60tovpd6DQBfxlHlziU3gYtSTa0omaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+QeXC2X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF07C4CEC2;
	Tue,  3 Sep 2024 01:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725328169;
	bh=MYd+BDZHjT4A49/uPMG3JKdeSg29HklOPqAeNtZYWOQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=U+QeXC2X1xudw533PDy63Jd71UFCyOegTYWfMWdJdl3xMIYgieBBJ57QEvO6Nuiju
	 ziBP/E56LLdhirSIbhjy6x8sI34F8nBb45hV5jKNdTLAXJbkMwucnaexUitgrIYxxx
	 eTtBCzAXlxQ2SUJPDMXoKkV79upiyjETusnKFJJMF/oa5meQdZusy5ltBUMmusM8d1
	 ymNSYkz94NenKd1w/Ilg0MKS5kNr+lt5tLnXLPvVCc29bzwaY1pZtvgAxvsZytlsAT
	 m/Ng3cEBcXjRjxAROcOECAXlXd2LxDMc/Fmtw48XMcjld5OPjdSWg1GgKdwiiCnokn
	 o+iSZYY52Z6CQ==
Date: Mon, 2 Sep 2024 20:49:27 -0500
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
	devicetree@vger.kernel.org
Subject: Re: [PATCH v8 11/11] PCI: imx6: Add i.MX8Q PCIe root complex (RC)
 support
Message-ID: <20240903014927.GA230795@bhelgaas>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729-pci2_upstream-v8-11-b68ee5ef2b4d@nxp.com>

On Mon, Jul 29, 2024 at 04:18:18PM -0400, Frank Li wrote:
> From: Richard Zhu <hongxing.zhu@nxp.com>
> 
> Implement i.MX8Q (i.MX8QM, i.MX8QXP, and i.MX8DXL) PCIe RC support. While
> the controller resembles that of iMX8MP, the PHY differs significantly.
> Notably, there's a distinction between PCI bus addresses and CPU addresses.

This bus/CPU address distinction is unrelated to the PHY despite the
fact that this phrasing suggests they might be related.

> Introduce IMX_PCIE_FLAG_CPU_ADDR_FIXUP in drvdata::flags to indicate driver
> need the cpu_addr_fixup() callback to facilitate CPU address to PCI bus
> address conversion according to "ranges" property.

I actually don't understand why the .cpu_addr_fixup() callback exists
at all.  I guess this is my lack of understanding here, but on the
ACPI side, if CPU addresses and PCI bus addresses are different, ACPI
tells us how to convert them.  It seems like it should be analogous
for DT.

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

I would have assumed that if the DT is correct, "offset" will be zero
for platforms where PCI bus addresses are identical to CPU addresses,
so we could (and *should*) do this for all platforms, not just IMX8Q.
But I must be missing something?

> +	return (cpu_addr - offset);
> +}

