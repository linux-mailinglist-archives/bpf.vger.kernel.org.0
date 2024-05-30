Return-Path: <bpf+bounces-30952-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBD38D5100
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 19:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CED011F232EC
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 17:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A2D4654E;
	Thu, 30 May 2024 17:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLERB+W8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5204446421;
	Thu, 30 May 2024 17:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717090072; cv=none; b=KHKvmAqnLiTZ4K44NaT8MjG5gUEpH31zruUA4aNuSk1P0QmGry3x3NQR5IlZZWA5p5UnFK+7tfQV8ZyQJulpED4vLwComjKR+COLV3LrH5lefpI6pwhiE4YnZK5swm6xeK8QQuMsDpc93U5bcCY2FGeUOILPEfq+l9yXg/i5ZQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717090072; c=relaxed/simple;
	bh=EkqPzNjUDQoN8lPfXqwKVpp8+X0/wVz+5NkoJWj35ko=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Xb8isxAO6+HFq/qkT1WQeTJlTAvHwyN2xabtOEMpvIn/9HcBlat2ysBFOpuH55yu1W4b94EcfPLXeRWhJgVPm2FUUQ5OQNKMnFbFvpKZRusmJgvneTrz5cKNev30XlFTyPm+s+cmbPdLbUEvX/iae8FmE4nerf98t0HSTRtgfcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLERB+W8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AACBC2BBFC;
	Thu, 30 May 2024 17:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717090071;
	bh=EkqPzNjUDQoN8lPfXqwKVpp8+X0/wVz+5NkoJWj35ko=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=lLERB+W86acD27TYDzKVQXQn1QMtGGWa3wwzsNOnVvZNcpsS+eXwViREODp86cbJI
	 rSJe96C7mr2uk7xEx2WcAWaFri7i5u7e/PgmXIaWd19TSaJf9xcagmzCgg4hwS09kq
	 hxySEa23v54kQxPNYOiJ7LK5ZMkwq+6ZXJTI8QFOcKQu0C4DdWnK57+kTEbnmPxQf2
	 P1waAtfMiozVsWzyLACVBQ6mxVU6MSbvpz1d5y8ZWCELAxxSmkovDqU95WZ8fGpq2K
	 KWa0Ny/gIzNGzi6NoZo+xzMnoiKxHlfpNyBJ4yfnEAYP0fweLpMy2hOamY7a0KRwEB
	 MqR2BFyNUnTxQ==
Date: Thu, 30 May 2024 12:27:49 -0500
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
	devicetree@vger.kernel.org, Jason Liu <jason.hui.liu@nxp.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v5 00/12] PCI: imx6: Fix\rename\clean up and add lut
 information for imx95
Message-ID: <20240530172749.GA552716@bhelgaas>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZldDIabPAa7NEmDQ@lizhi-Precision-Tower-5810>

On Wed, May 29, 2024 at 11:00:49AM -0400, Frank Li wrote:
> On Tue, May 28, 2024 at 05:31:36PM -0500, Bjorn Helgaas wrote:
> > On Tue, May 28, 2024 at 03:39:13PM -0400, Frank Li wrote:
> ...

> > > Base on linux-pci/controller/imx
> > 
> > This applies cleanly to the pci/controller/gpio branch, which has some
> > minor rework in pci-imx6.c.
> > 
> > When we apply this, I think we should do it on a a pci/controller/imx6
> > branch that is based on "main" (v6.10-rc1).
> > 
> > I can resolve the conflicts with pci/controller/gpio when building
> > pci/next.
> 
> Sorry, I forget update this. It should be base on linux-pci/next
> (e3fca37312892122d73f8c5293c0d1cc8c34500b). 

I prefer patches that are based on -rc1, i.e., the pci/main branch,
not on the pci/next branch.

If a series *requires* functionality that is already on a topic
branch, you can base it on that branch instead of on pci/main.

This series happens to touch some of the same code as
pci/controller/gpio, but it doesn't require those gpio changes, so it
does not need to be based on pci/controller/gpio.

Having this series based on pci/main means that if we update or drop
the gpio branch for some reason, this series will still make sense.

Bjorn

