Return-Path: <bpf+bounces-31341-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9478FB6E6
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 17:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E85562866A1
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 15:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E50A1442F2;
	Tue,  4 Jun 2024 15:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uBlERkTf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF4FC13B;
	Tue,  4 Jun 2024 15:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717514755; cv=none; b=lf/IEspISWALTKlIVd4nfSidzoDUPFCcgy6uwYBm2yPz2nF16uzm20Ld8fOAO2clRVeEYuj48eFk7hUMIAPO97zxf3+XZ4PR+3fGJtDqkNFK7g6EaGOKvWR9Cfg6uNFqVBpIqpMWjKATThDnsptVKIKrQ8KyIR8a02Uo7ebJrYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717514755; c=relaxed/simple;
	bh=W4guxw4l01Fm9wSUJoG6FBoB1xjKNyaC5jSs9toFe60=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pl3NJFjGe/XSgp3pW6fgX8U6T3N2Vmtck0UullHUe3NzV3cg9R9FFoUK3CcQYljXTARU+rRHuEGBSQorpGK3BHPXaJD/Qwrn9cpFIACoypQMLxt73s5qalujRVp/VsMiw/maPbD7w4OI2faZvj3IU2cCjSexaUNPBDgqWtCujaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uBlERkTf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A9BC2BBFC;
	Tue,  4 Jun 2024 15:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717514754;
	bh=W4guxw4l01Fm9wSUJoG6FBoB1xjKNyaC5jSs9toFe60=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uBlERkTfsl6Cc1Hb9rsoZKL3tUhcrxXlmutR3hjFozXXQD+clGNtj1kEfeLvvmwug
	 ZhWMMQut0D6GHkWtFX8YI98xpkpe0RVwG9dTrBOJAzEEHbM1jrIz+mgFlwhD1+Zkz9
	 yhcx5lXBjmqbQsJKqOcjTckeEboWdcI5vfGbCKMzwWVElQlzdOzDR+Fsq07m+nAE/3
	 mt5h/Neh6E82IwLgvYRsrlKqAZ2L/tTnDx4q6APk351MkrsjO1GIWAC0hzcsSj0fLW
	 DpfNjAfk7nTYj7P3ukQ3kQ4HLc1jPIulxTvauURLNPh0ROtGhBPWE3M0euplY+Qq+k
	 AIywwb5ieKwlQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1sEW2q-000d09-Cz;
	Tue, 04 Jun 2024 16:25:52 +0100
Date: Tue, 04 Jun 2024 16:25:51 +0100
Message-ID: <86cyowlog0.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Robin Murphy <robin.murphy@arm.com>,	Bjorn Helgaas <helgaas@kernel.org>,
	Richard Zhu <hongxing.zhu@nxp.com>,	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,	Krzysztof =?UTF-8?B?V2lsY3p5?=
 =?UTF-8?B?xYRza2k=?= <kw@linux.com>,	Rob Herring <robh@kernel.org>,	Bjorn
 Helgaas <bhelgaas@google.com>,	Shawn Guo <shawnguo@kernel.org>,	Sascha
 Hauer <s.hauer@pengutronix.de>,	Pengutronix Kernel Team
 <kernel@pengutronix.de>,	Fabio Estevam <festevam@gmail.com>,	NXP Linux Team
 <linux-imx@nxp.com>,	Philipp Zabel <p.zabel@pengutronix.de>,	Liam Girdwood
 <lgirdwood@gmail.com>,	Mark Brown <broonie@kernel.org>,	Manivannan
 Sadhasivam <manivannan.sadhasivam@linaro.org>,	Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,	Conor Dooley <conor+dt@kernel.org>,
	linux-pci@vger.kernel.org,	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,	devicetree@vger.kernel.org,	Will Deacon
 <will@kernel.org>,	Joerg Roedel <joro@8bytes.org>,	Jason Gunthorpe
 <jgg@ziepe.ca>,	Alyssa Rosenzweig <alyssa@rosenzweig.io>
Subject: Re: [PATCH v5 08/12] PCI: imx6: Config look up table(LUT) to support MSI ITS and IOMMU for i.MX95
In-Reply-To: <Zl4v10Od99et+tLX@lizhi-Precision-Tower-5810>
References: <20240603171921.GA685838@bhelgaas>
	<3d24fecf-1fdb-4804-9a51-d6c34a9d65c6@arm.com>
	<Zl4v10Od99et+tLX@lizhi-Precision-Tower-5810>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/29.2
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: Frank.li@nxp.com, robin.murphy@arm.com, helgaas@kernel.org, hongxing.zhu@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, p.zabel@pengutronix.de, lgirdwood@gmail.com, broonie@kernel.org, manivannan.sadhasivam@linaro.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, linux-pci@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, devicetree@vger.kernel.org, will@kernel.org, joro@8bytes.org, jgg@ziepe.ca, alyssa@rosenzweig.io
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Mon, 03 Jun 2024 22:04:23 +0100,
Frank Li <Frank.li@nxp.com> wrote:
> 
> iommu may share one stream id for multi-devices. but ITS MSI can't. each
> device's MSI index start from 0. It needs difference stream id for each
> device.

That's not quite true. We go through all sort of hoops to find about
device aliasing on PCI and allow devices that translate into the same
DID to get MSIs.

Of course, just like the IOMMU, you lose any form of isolation, but
you get what you pay for.

	M.

-- 
Without deviation from the norm, progress is not possible.

