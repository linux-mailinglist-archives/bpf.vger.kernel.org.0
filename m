Return-Path: <bpf+bounces-22949-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D0986BBE6
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 00:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 790D81F29D03
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 23:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A7E13D2F8;
	Wed, 28 Feb 2024 23:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Frmk1kIk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDDE1EEE7;
	Wed, 28 Feb 2024 23:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709161522; cv=none; b=Ur/yVPGbrb4IjjlokUpUyLdFWElINk0CdkTj67vZzg636OA3SR1KdL91P9VZWjw/LYtOV3KkB5vejCucgwz5y7/qCnB/zM49UpJXv3DoqIUPMkJJSdz67UNdv6xmXM2mxfWxGmuTLiQMCd+wHXsPB5mhvQb5oTyo53YjTP4weTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709161522; c=relaxed/simple;
	bh=F1VOE+DnjdscjpxmdpPOZleVN5H0NxncCSGnUm/eOfM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Pt0C5I7Ckxxm2LIhEG8pmQxh0k9WsqdniTeLm1WrP042AvNU2RxDgEG63u4jvqCUjjlIbY8QZH05jxa3LXnQ/9M79jwBi+QJKB3l03Slm2qoB9sTYRIoETIybyh/ZGHZ0/oFLujVG/b1uIWzVyHtRJjGByJIzfdiPd/FJXnsnk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Frmk1kIk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E74C433F1;
	Wed, 28 Feb 2024 23:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709161521;
	bh=F1VOE+DnjdscjpxmdpPOZleVN5H0NxncCSGnUm/eOfM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Frmk1kIkCtxpQM1uEGaF3hVv/D95rdvphgFe94ADYS2R3mpXMAjS/R25w0LEwLNFy
	 hC2cj69c3cptVkpQFMZpR4bvruVKfqOaZJ38zAeO7J+6fTVHgfT+are01CP+pz7wyP
	 n38haW2bEAVvFD+a6zm+2HbahRmWN5Fy4n+o9NPPJR0Pc+M0Sej9QiaedNEY4jmtZ/
	 YcwTG+vuyYyhjKVC7mqP6+zCfzmsr+Ukawhx3154Wgczj33Q7KUrRZDCQrdsuqZViS
	 Ejvl8OYqjPMfbtt2nJLHQqQg8eJ5oGHkHMF8iqpoc53W5FchQXztgXSTrwhVLbsFVB
	 +JOP4EYyPL36Q==
Date: Wed, 28 Feb 2024 17:05:20 -0600
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
	Mark Brown <broonie@kernel.org>, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 2/6] PCI: imx6: Rename pci-imx6.c and PCI_IMX6 config
Message-ID: <20240228230520.GA314710@bhelgaas>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227-pci2_upstream-v1-2-b952f8333606@nxp.com>

On Tue, Feb 27, 2024 at 04:47:09PM -0500, Frank Li wrote:
> pci-imx6.c and PCI_IMX6 actuall for all i.MX chips (i.MX6x, i.MX7x, i.MX8x,
> i.MX9x). Remove '6' to avoid confuse.

s/actuall for all/cover all/
s/confuse/confusion/

>  drivers/pci/controller/dwc/{pci-imx6.c => pci-imx.c} |  0

If we're going to rename it, we should rename it to "pcie-imx.c".

It was my mistake long ago to use "pci-" instead of "pcie-".

> -config PCI_IMX6
> +config PCI_IMX

What does this look like to users who carry an old .config file
forward?

