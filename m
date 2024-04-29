Return-Path: <bpf+bounces-28105-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 714918B5CF4
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 17:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05127B2420D
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 15:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9059839F7;
	Mon, 29 Apr 2024 15:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="scBbbaYA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D59281724;
	Mon, 29 Apr 2024 15:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714403165; cv=none; b=VUv4YSXsTURjy0OWas2sEsRkklkIue7koVEka9EyScBFC8n/Yexe+P5pcFRjrUtwk+tbtqOCMVM532SelxQbsXYmgIPWXFSaG/JmLw9wDZWsJSYYpAWXjjvHSRgnOuseQHO6QlzxtBpe0J5GZf/M76k7PPIh/z3yF4DQ5/dvCYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714403165; c=relaxed/simple;
	bh=1OdOnmCWuTc9Eh7r0KmldnxLczyf/ys8U2hdOy5J3N8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMPJ7dbD3epwO9lTvtf4OIfjJ14IycEpmOB0FCbUPAN/i9JiradhjaZvmhrDUWjnrSMIIQfoeUiOcuRZJlvEcWGLA6+OQKTao+0oLdUxwA1rIlfLtxunFSgu2zjdLHxIEHsFNAi1RCh/X1WdDCC4g7UD2MEZjIDU3v4nX7EiWm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=scBbbaYA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D30C113CD;
	Mon, 29 Apr 2024 15:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714403164;
	bh=1OdOnmCWuTc9Eh7r0KmldnxLczyf/ys8U2hdOy5J3N8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=scBbbaYA4rJz5CH8YYOuBSqX07Sw2T/oCE5T93nMfzNOsa4xrjtowT4TWJIOdEgfD
	 AEU8HSykITPmrrDL1xwW4M8vtYYCp+W0D60YJDij0H7YWNtcp//+9OnHoSUu2N4fwK
	 WzjTxTCJk/XLcrBbySwA/EyJ+jEknAzWVGGHo9nmgBFGDnSPGkTmRCMzX8ZmKQjsb2
	 INKi3UZs5roerA/+i4QCjRO+oPrIEpO5ykRcUCnryGQC8F7SrLJP4+zZoETigtFKJD
	 9FVjDpofz1g1Z++OK6p0NJwE3rHD0YwM46sWLDI6QcIR5nQoz6tUa7yQR6qsLqwFNd
	 ONIzT38gzFPSA==
Date: Mon, 29 Apr 2024 10:06:00 -0500
From: Rob Herring <robh@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Frank Li <Frank.Li@nxp.com>, Richard Zhu <hongxing.zhu@nxp.com>,
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
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 08/11] PCI: imx: Config look up table(LUT) to support
 MSI ITS and IOMMU for i.MX95
Message-ID: <20240429150600.GB1709920-robh@kernel.org>
References: <20240402-pci2_upstream-v3-0-803414bdb430@nxp.com>
 <20240402-pci2_upstream-v3-8-803414bdb430@nxp.com>
 <20240427113643.GM1981@thinkpad>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240427113643.GM1981@thinkpad>

On Sat, Apr 27, 2024 at 05:06:43PM +0530, Manivannan Sadhasivam wrote:
> PCI: imx6: Add support for configuring BDF to SID mapping for i.MX95
> 
> On Tue, Apr 02, 2024 at 10:33:44AM -0400, Frank Li wrote:
> > i.MX95 need config LUT to convert bpf to stream id. IOMMU and ITS use the
> 
> Did you mean BDF? Here and everywhere.
> 
> > same stream id. Check msi-map and smmu-map and make sure the same PCI bpf
> > map to the same stream id. Then config LUT related registers.
> > 
> 
> These DT properties not documented in the binding.

They are in the common binding. 

Rob

