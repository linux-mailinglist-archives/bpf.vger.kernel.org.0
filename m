Return-Path: <bpf+bounces-30793-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E5D8D280A
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 00:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2F6C1F26448
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 22:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C9613E043;
	Tue, 28 May 2024 22:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVCvnonH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671B98F49;
	Tue, 28 May 2024 22:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716935508; cv=none; b=DNXhhLpt5AJ4utqp8xjUfeGAFgpEjLF6VpVVOdHA6ng7QpRMsbCQDwK+eccgnkTOct770i9otctkb1iqeBq4yaE7JIWCbGjS83C32DtVoAyYuPOaxXi1C4RGJ3esZPvUA0fEIMrYL3UbK1C7786KtbxFG2sjeDIsa6Wdr0pt3f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716935508; c=relaxed/simple;
	bh=2tvp4ALV98F8ntrfFbB0RTWjKg+x73NToh4KDsv8yLI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QFank3dqxALTi8EHP7wW+swOiEQNZ+bEP41KPyaimQAZombbWyO1BPUVlzqZkNck06VDF68abAUx/tVefgLtjCrEZBmIM4mWLnvcDOz5//YPm3pH3Tk86HXqlhaAdeKoaRFcRYw4giAg6TBJbMUGuEMchysovdG8RG+DmMzQQHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RVCvnonH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CDAFC3277B;
	Tue, 28 May 2024 22:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716935507;
	bh=2tvp4ALV98F8ntrfFbB0RTWjKg+x73NToh4KDsv8yLI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=RVCvnonHvbTAKaQ3IOfXjIFrz98p6w31jApG/4vdbHP6eixh96BKMqSdMMttdqKMn
	 TvmixPInKMfHEnGgzJhMZjHWImkjt+W91oeXHB+MujcM60zzkF2GNeK+PLxCLNb7oW
	 r3g2uG3sdG+FZ8IbuseE4s3wewY8/RriRfqN1R7ue/SbYh+kIXSS73aTJhUj1IgACS
	 pWC+IK3+jLefQlmU6DSTBFPdenHK7dpG0cX9DGAVpjmiMRt2of1SRsDoehMgNs2ylT
	 F501bB/f6f20CVd4ZakfMDoDBuvM9Yu/9VNvbdTp1szh3pCDXfBZLXpIKAGI3lWrkl
	 q7UHGCzkdIbrg==
Date: Tue, 28 May 2024 17:31:36 -0500
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
	devicetree@vger.kernel.org, Jason Liu <jason.hui.liu@nxp.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v5 00/12] PCI: imx6: Fix\rename\clean up and add lut
 information for imx95
Message-ID: <20240528223136.GA473846@bhelgaas>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528-pci2_upstream-v5-0-750aa7edb8e2@nxp.com>

On Tue, May 28, 2024 at 03:39:13PM -0400, Frank Li wrote:
> Fixed 8mp EP mode problem.
> 
> imx6 actaully for all imx chips (imx6*, imx7*, imx8*, imx9*). To avoid     
> confuse, rename all imx6_* to imx_*, IMX6_* to IMX_*. pci-imx6.c to        
> pci-imx.c to avoid confuse.                                                
> 
> Using callback to reduce switch case for core reset and refclk.            
> 
> Add imx95 iommux and its stream id information.                            
> 
> Base on linux-pci/controller/imx

This applies cleanly to the pci/controller/gpio branch, which has some
minor rework in pci-imx6.c.

When we apply this, I think we should do it on a a pci/controller/imx6
branch that is based on "main" (v6.10-rc1).

I can resolve the conflicts with pci/controller/gpio when building
pci/next.

Bjorn

