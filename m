Return-Path: <bpf+bounces-38826-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F6896A777
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 21:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FE4A2862F4
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 19:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C06619149E;
	Tue,  3 Sep 2024 19:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOlAiJpa"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E21B1422A2;
	Tue,  3 Sep 2024 19:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725392262; cv=none; b=RqcECA3KyT2M2vDBOnXH2RrvQSyxUyiX1vwS2xFibtzLiU++qSZl8teLFBeugF6ISGob2xbXsFj9iQAbIRduV6Hf7HIz3hQG5derrUtJt7+LDen/yh+W/J3YKKm5sorIw0x1lTdcdR2GTdqK89o7H99FMhdb4fBmyRtfns6LBUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725392262; c=relaxed/simple;
	bh=SIJNjyq5dxaon4/zdpaiOfQn11sjOiaAf/Z1TfCGKVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=MrcYdI2nhFFd0ByJjg6eVELzkR3jI7ES+BOiqOA0Q+THRRlkov1gPNkCNPjDCT4Kag6LMk1tlFtM9M8UA/WTeTRqWeew02kx0iCTKqi+u3MZqjX1A8Odtz+oqYUwatScTHIdxN7G/OfN7D7YyzQqeX0uov6DSNCZttcY0t/ldIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOlAiJpa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB56BC4CEC4;
	Tue,  3 Sep 2024 19:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725392262;
	bh=SIJNjyq5dxaon4/zdpaiOfQn11sjOiaAf/Z1TfCGKVQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=BOlAiJpaGGK7mXIy7BGmiCpR7kTGpTjWCBfEbhPm7x5fiFWyCEE3W6/99cBdQ3Ndy
	 r/bBfZ0U+zak0u1tlasJqbve5qyYsUSDPuk2MLDoMGY0Jb5xIgftAH3Yl3nrD7+sSQ
	 uDYm92IUQBMeVd4jtzNM4Gr5Ezx6lpE07ed2BYkCer8eVXminTil3eB6AFb4prspmg
	 SLY0QJNaLtGFZU7zxEx9jaxmlB1ymTPQJAE0hwB0ETjZqkIX+5ocSIaAleYwgKghIG
	 pyN/MMaobCtErRaJJNjSjqFkYasFZU2Izr1o9KFRd6bA5SZ/eS6tO0uTJUVa0aLu6R
	 74ymjaDa9J5BQ==
Date: Tue, 3 Sep 2024 14:37:39 -0500
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
Subject: Re: [PATCH v8 04/11] PCI: imx6: Rename imx6_* with imx_*
Message-ID: <20240903193739.GA230579@bhelgaas>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729-pci2_upstream-v8-4-b68ee5ef2b4d@nxp.com>

On Mon, Jul 29, 2024 at 04:18:11PM -0400, Frank Li wrote:
> Since this driver has evolved to support other i.MX SoCs such as i.MX7/8/9,
> let's rename the 'imx6' prefix to 'imx' to avoid confusion. But the driver
> name is left unchanged to avoid breaking userspace scripts

s/let's//

It's not a proposal, it's what the patch *does*.

s/But the driver name is left unchanged/Leave the driver name unchanged/

s/scripts/scripts./ (add period)

> -#define IMX6_PCIE_FLAG_IMX6_PHY			BIT(0)
> -#define IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE	BIT(1)
> -#define IMX6_PCIE_FLAG_SUPPORTS_SUSPEND		BIT(2)
> -#define IMX6_PCIE_FLAG_HAS_PHYDRV			BIT(3)
> -#define IMX6_PCIE_FLAG_HAS_APP_RESET		BIT(4)
> -#define IMX6_PCIE_FLAG_HAS_PHY_RESET		BIT(5)
> -#define IMX6_PCIE_FLAG_HAS_SERDES		BIT(6)
> -#define IMX6_PCIE_FLAG_SUPPORT_64BIT		BIT(7)
> +#define IMX_PCIE_FLAG_IMX_PHY			BIT(0)
> +#define IMX_PCIE_FLAG_IMX_SPEED_CHANGE	BIT(1)
> +#define IMX_PCIE_FLAG_SUPPORTS_SUSPEND		BIT(2)
> +#define IMX_PCIE_FLAG_HAS_PHYDRV			BIT(3)

Good opportunity to fix the whitespace errors while renaming these.
IMX_PCIE_FLAG_IMX_SPEED_CHANGE and IMX_PCIE_FLAG_HAS_PHYDRV end up
with the wrong indentation.

> -#define imx6_check_flag(pci, val)     (pci->drvdata->flags & val)
> +#define imx_check_flag(pci, val)     (pci->drvdata->flags & val)
>
> -#define IMX6_PCIE_MAX_CLKS       6
> +#define IMX_PCIE_MAX_CLKS       6

Could also make these look nicer.

We can touch these up, no need to repost.

