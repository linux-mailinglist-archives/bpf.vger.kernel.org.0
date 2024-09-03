Return-Path: <bpf+bounces-38835-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7618A96A9C7
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 23:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B5BE286219
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 21:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B220D126BE4;
	Tue,  3 Sep 2024 21:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qIs57Wl9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB9E1EC011;
	Tue,  3 Sep 2024 21:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725397762; cv=none; b=Acro83MF5fRt/IIefJ0NQXFT44PpVAjV9SFTanpRLUmhyXD7QvZOIXpc0IVU7rraMtPRUKuUJ4+Nfv6dkYfqHIauGRSLtnGJ9/aHqBcvxE9AdDBi0HXGgkuUxfqIHTl2AqQkEBu4aRmDmAVuloqJoqYIpV9z0/yGL64pryPyg+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725397762; c=relaxed/simple;
	bh=zMYA+LcGsMb9VFlyyQ4rB4esNt0Wsi3Z7wJ735oK+TQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=RUU/rXfiqoLn5vuFQXuaIxlnKK6jIrbbSN6Ld5kH8tSR+M8hsQiSd0uBQHNDZcBWwGLdNr5IxJAYYKfhEHlYlWn7WYsjMimj/N29WBjGv0OopnCB2YWXiAeWNoqKwptRZJBTzyLnf+r3RQlu8Pj2JQP05uJkqMHAYQZqT0qHJLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qIs57Wl9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 592A7C4CEC4;
	Tue,  3 Sep 2024 21:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725397761;
	bh=zMYA+LcGsMb9VFlyyQ4rB4esNt0Wsi3Z7wJ735oK+TQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=qIs57Wl9jXFEqhkEJPkefxf7DNEpJ/KpO+Vz3giW1hy7mMsLHGeVdOQkkjx/+NmmV
	 negBj0xkg1WEhOt0XYT1iCrGGzGIJjYOxxCttFb3gTJdQXofcN90AjhNG7CpX04DtM
	 KZRTymWXV6TvKAfXJsYwF/8MLR3SFgpQ3A2G9pGoe7h5HvQZUN1YNvmHVLrMQz1Z4l
	 2ikCqhcsHbDY86LeQwgeqBYLxKygEr8a9LXBVjf8UWZukvXPDMYqHdu01RuCB2vuiW
	 BGoMAVReWhiBiAHDqtZ3Qws9SVbgQPKBWbRxUKIcOCWb8KeuNEhpfNWrdR44PJ3vnL
	 nsP/xhzYHVYBw==
Date: Tue, 3 Sep 2024 16:09:19 -0500
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
	devicetree@vger.kernel.org
Subject: Re: [PATCH v8 11/11] PCI: imx6: Add i.MX8Q PCIe root complex (RC)
 support
Message-ID: <20240903210919.GA277611@bhelgaas>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtdzIxr3YnDAW5VY@lizhi-Precision-Tower-5810>

On Tue, Sep 03, 2024 at 04:35:47PM -0400, Frank Li wrote:
> On Mon, Sep 02, 2024 at 08:49:27PM -0500, Bjorn Helgaas wrote:
> > On Mon, Jul 29, 2024 at 04:18:18PM -0400, Frank Li wrote:
> > > From: Richard Zhu <hongxing.zhu@nxp.com>
> > >
> > > Implement i.MX8Q (i.MX8QM, i.MX8QXP, and i.MX8DXL) PCIe RC support. While
> > > the controller resembles that of iMX8MP, the PHY differs significantly.
> > > Notably, there's a distinction between PCI bus addresses and CPU addresses.
> >
> > This bus/CPU address distinction is unrelated to the PHY despite the
> > fact that this phrasing suggests they might be related.
> 
> This just list two indepentent differences.

Yes.  But using "Notably" here connects them by suggesting that the
address space translation is a major part of what came before.  Weird
subtlety of English usage, I guess.

Krzysztof, if you have a chance, just s/Notably/Also/ here.

