Return-Path: <bpf+bounces-46036-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDD39E2F28
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 23:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB90A161CF2
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 22:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C75209674;
	Tue,  3 Dec 2024 22:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+Oamw/N"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE891D8E1E;
	Tue,  3 Dec 2024 22:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733265562; cv=none; b=UVgw32R+EEjWvXkV2G39Zr6C/BI9SxoHqcMWRM0DfruZOY1VCRUjuiZIaU96B3/9N0P6L2AWasukShaQ41FlnALiulxReC/mmX566UGyKqwySByWznYAVP0+NYz7k9m3xU43phkyuJadM2gaIPOEOUlCtA5vBWbf5kgw/f346wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733265562; c=relaxed/simple;
	bh=wKj6FXFllNBDaF5OSfRBHXGeyHVdbB1UAA4vOa8B/yU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Th2phDNrHphlY04iy+DCEcH5//oYFLh4FfLl4cmofjh8aFrLDU2WsaeweInAhuRs8m05lseHKu9q+XojNkHk0w9FehDk9VPJM0QTgoGQLp0pNe5AFexrqFPZzNhe6tEGcFumRHDTirv+EtJyy0eA73daZtZE7ERzayDSgemDqG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+Oamw/N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B9C8C4CEDC;
	Tue,  3 Dec 2024 22:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733265561;
	bh=wKj6FXFllNBDaF5OSfRBHXGeyHVdbB1UAA4vOa8B/yU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=M+Oamw/NYy+DFLqyJxR/dJ/vewk97b3hm56heP86XNoADsAj9LwNVSg5mfa7aVwFV
	 P8nNRDpOF1beu9AGtqQgfQVog68tmtYdkBjEk8oWFaGrT6dH7CZdPjdOHEyntkZXay
	 yuPq7xu3pR7qVcGxdVwF0eTyMc98bDqCuTXvaQogxXiOG8Gj0Bi1Qc92jHMXVJiFZa
	 mtL39MAgLaEu+tkKWt5WuUmu38wDfq8JCyQMtQaRTxgQwXFvGAMbbVkDiSJ33oUfrG
	 lIHCujR5DIVQNUeoNUqY0Hnlmbu+vOibhxsHndJy1VYRLeHBeiHkIQuUdJ2PoKUm9y
	 xVuhTRGHwfF/Q==
Date: Tue, 3 Dec 2024 16:39:20 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, alyssa@rosenzweig.io, bpf@vger.kernel.org,
	broonie@kernel.org, jgg@ziepe.ca, joro@8bytes.org,
	lgirdwood@gmail.com, maz@kernel.org, p.zabel@pengutronix.de,
	robin.murphy@arm.com, will@kernel.org
Subject: Re: [PATCH v5 1/2] PCI: Add enable_device() and disable_device()
 callbacks for bridges
Message-ID: <20241203223920.GA2969750@bhelgaas>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z09tOGxAK6nBB8wV@lizhi-Precision-Tower-5810>

On Tue, Dec 03, 2024 at 03:42:32PM -0500, Frank Li wrote:
> On Mon, Nov 04, 2024 at 02:22:59PM -0500, Frank Li wrote:
> > Some PCIe host bridges require special handling when enabling or disabling
> > PCIe Endpoints. For example, the i.MX95 platform has a lookup table to map
> > Requester IDs to StreamIDs, which are used by the SMMU and MSI controller
> > to identify the source of DMA accesses.
> >
> > Without this mapping, DMA accesses may target unintended memory, which
> > would corrupt memory or read the wrong data.
> >
> > Add a host bridge .enable_device() hook the imx6 driver can use to
> > configure the Requester ID to StreamID mapping. The hardware table isn't
> > big enough to map all possible Requester IDs, so this hook may fail if no
> > table space is available. In that case, return failure from
> > pci_enable_device().
> >
> > It might make more sense to make pci_set_master() decline to enable bus
> > mastering and return failure, but it currently doesn't have a way to return
> > failure.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> 
> Bjorn Helgaas:
> 
> 	Can I keep your acked tag? Compared V4, just use static helper
> functions.

Can you rebase this to pci/main (v6.13-rc1)?  This would go via the
PCI tree, so it will need to be rebased anyway, and then I can ack
that.

Bjorn

