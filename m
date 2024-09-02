Return-Path: <bpf+bounces-38741-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3387968F1E
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 23:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C65B284725
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 21:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467F91A3A9D;
	Mon,  2 Sep 2024 21:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jg0uee8T"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA5E13D260;
	Mon,  2 Sep 2024 21:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725311562; cv=none; b=K50RCm7hYyvpNZoGIjh8ygblbzuHGfsj+0Jm4WuoRaum01EMRn/QywOu4GA1XijjA3dCYZ8cZjlqJB0a8P52pJb71NMlMC612dmkdMxXUzwWDwcY+fCyFNpm857Q7iYv58rjpBBLs0PdThlBtGBk8bSzbG033LkdK8sBmJYJkbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725311562; c=relaxed/simple;
	bh=lORzwTXT57dhMR/bpO4ifz86tt0oau7aGv/z53yqMO0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=oJHe9HsUZN0JIXHh42QNf1x2Lu68vz3UQFAlG1Tc3hiFxzoAloILXoRqsNGEGuApQ3UW1urVKogFsHGBTWS8rdPPKffckkRc0tIfbdqhxFRsK6hB3KC5U6b34EeBEd4eXQba0jfUIEE8bYMLTEJSlWn8BUk+YNAVGcM7y//yJ3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jg0uee8T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D4FC4CEC2;
	Mon,  2 Sep 2024 21:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725311562;
	bh=lORzwTXT57dhMR/bpO4ifz86tt0oau7aGv/z53yqMO0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=jg0uee8T0ltCRUGD1+vdZHV/vbB3c/HU4kHMjKDCxwFNnHXuDy/8MtuUhiAJlv7Um
	 h7L0kO+mzDv0sVQEq0Gw05RbsWfVldBEc30kzimFaE++oAAiXbQ0iMZOU8y7wmBP4L
	 JG8f+UPARiORk54IZXT2rtx3gpqjmXMHZcm5J6aMrOva4K/Yrc2f2KlhhfmfzcylzS
	 NAoRIfSrKNxKzRpMdqLq6pPT7ltEVj7o7hZYitqobbCvdVuJnxVHnbKeGS4dA3gCiH
	 huMgIdf07m5vERDMH5l6B1dyl6XtW9oqlNfpeGaPUXu9bZIhrbWjrbWlPCiCz9kXk4
	 tBy7SRjo+AgxQ==
Date: Mon, 2 Sep 2024 16:12:40 -0500
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
Subject: Re: [PATCH v8 01/11] PCI: imx6: Fix establish link failure in EP
 mode for iMX8MM and iMX8MP
Message-ID: <20240902211240.GA228125@bhelgaas>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729-pci2_upstream-v8-1-b68ee5ef2b4d@nxp.com>

On Mon, Jul 29, 2024 at 04:18:08PM -0400, Frank Li wrote:
> From: Richard Zhu <hongxing.zhu@nxp.com>

Maybe "iMX8MP" in this subject should be "i.MX8MP" as in the subject
of the next patch?

And if so, maybe it should be "i.MX8MM" here, too?

That seems to match usage in the rest of the series (although "PCI:
imx6: Add i.MX8Q PCIe Root Complex (RC) support" uses "iMX8MP" once in
the commit log).

