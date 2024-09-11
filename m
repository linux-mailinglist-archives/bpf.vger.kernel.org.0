Return-Path: <bpf+bounces-39632-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5624F97587C
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 18:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DBD91C239EC
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 16:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B8A1AE873;
	Wed, 11 Sep 2024 16:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cke0NNEi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7901A3AB8;
	Wed, 11 Sep 2024 16:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726072439; cv=none; b=QfszJNOkGr1b7pAiK1fg8BOGMhDqxs8V6NAH8W8JaM4PQB19KsEDbJEpo/1u+tHWAXYK834zqzDGaJFq2fiWDdc2dvPoa7iOO0kdGplmmIw/DKAvmKowcdWNqUJJB3oPT9mD4T5ypWCv9WnwRjDaCPIIDvcTj+9nUCBsbDgxU40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726072439; c=relaxed/simple;
	bh=me2IwCdr0YPbwk7LPVsZk6xYX4lHvRc5w/WlwEq5Ot0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LUHNmTXVZX+PjYJC00IFNHFVdNqsUj7ROHp2ldUqZLJVZWTD++JAkHCOqU2gXIJcmc4TD9ulJ9K2gm1ikDKlXi6yVzagVkHeH8QbR0j7sb1pQR18zYTCH+zlnCdNrahG/Adtriou0JdDe1iP2mWrY5P7E5Ap5UDYIrv4S0c3reI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cke0NNEi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C99A8C4CEC0;
	Wed, 11 Sep 2024 16:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726072439;
	bh=me2IwCdr0YPbwk7LPVsZk6xYX4lHvRc5w/WlwEq5Ot0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Cke0NNEiY/Ntdi9DzOQWVIx2io2HmhtOE9Tfn/DtPR7XxhJ2nNd/qGrWUEHNo0Hu7
	 jtXTkS39wkSgMp5MdfGtAdXasMqWFKucOTqwcKosQ2zT355Tkz1r45LHx34oa7hkMk
	 PFYXqcEQJnAV98EKJ1fw8P67GORnJ/TU3U6pBOKSv42z/bTShuyl5xPhDFjVxyN9fQ
	 3ZH2P8eMrByP8jTwXRBuAAT/mdCh4dEwC15fTixvA8LXqKJ/yDKBmitZw+BBY/475u
	 M9thXb3k+g7hf2aRQkbAExivGG3g//uIsLFPSQ3l2XLhQkkGqPbGlheoEpDTYSCfcE
	 xxQja9Fio1UyQ==
Date: Wed, 11 Sep 2024 11:33:56 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
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
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	devicetree@vger.kernel.org, Qianqiang Liu <qianqiang.liu@163.com>
Subject: Re: [PATCH v8 11/11] PCI: imx6: Add i.MX8Q PCIe root complex (RC)
 support
Message-ID: <20240911163356.GA643833@bhelgaas>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuG1BfhQpd9GajNH@lizhi-Precision-Tower-5810>

On Wed, Sep 11, 2024 at 11:19:33AM -0400, Frank Li wrote:
> On Wed, Sep 11, 2024 at 09:07:21AM -0500, Bjorn Helgaas wrote:
> > [+cc Qianqiang]
> >
> > On Mon, Jul 29, 2024 at 04:18:18PM -0400, Frank Li wrote:
> > > From: Richard Zhu <hongxing.zhu@nxp.com>
> > >
> > > Implement i.MX8Q (i.MX8QM, i.MX8QXP, and i.MX8DXL) PCIe RC support. While
> > > the controller resembles that of iMX8MP, the PHY differs significantly.
> > > Notably, there's a distinction between PCI bus addresses and CPU addresses.
> > >
> > > Introduce IMX_PCIE_FLAG_CPU_ADDR_FIXUP in drvdata::flags to indicate driver
> > > need the cpu_addr_fixup() callback to facilitate CPU address to PCI bus
> > > address conversion according to "ranges" property.
> >
> > > +static u64 imx_pcie_cpu_addr_fixup(struct dw_pcie *pcie, u64 cpu_addr)
> > > +{
> > > +	struct imx_pcie *imx_pcie = to_imx_pcie(pcie);
> > > +	struct dw_pcie_rp *pp = &pcie->pp;
> > > +	struct resource_entry *entry;
> > > +	unsigned int offset;
> > > +
> > > +	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_CPU_ADDR_FIXUP))
> > > +		return cpu_addr;
> > > +
> > > +	entry = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
> > > +	offset = entry->offset;
> > > +	return (cpu_addr - offset);
> > > +}
> >
> > I'm sure that with enough effort, we could prove "entry" cannot be
> > NULL here, but I'm not sure I want to spend the effort, and we're
> > going to end up with more patches like this:
> >
> >   https://lore.kernel.org/r/20240911125055.58555-1-qianqiang.liu@163.com
> >
> > I propose this minor change:
> >
> >   entry = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
> >   if (!entry)
> >     return cpu_addr;
> >
> >   return cpu_addr - entry->offset;
> >
> > I still think we should get rid of the .cpu_addr_fixup() callback if
> > possible.  But that's a discussion for another day.
> 
> Stop these fake alarm from some tools's scan. entry never be NULL here.
> I am working on EP side by involve a "ranges" support like RC side.
> 
> Or just omit this kinds of patches.

As I said initially, we probably *could* prove that "entry" can never
be NULL here, but why should I have to spend the effort to do that?
The "windows" list is not even built in this file, so it's not
trivial.  And even if "entry" can't be NULL now, what's to prevent
that assumption from breaking in the future?

I don't think there's anything wrong with checking for NULL here, and
it avoids copy/pasting this somewhere where it *does* matter.  So I'm
in favor of this kind of patch.

Bjorn

