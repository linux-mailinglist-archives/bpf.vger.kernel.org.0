Return-Path: <bpf+bounces-36327-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00647946614
	for <lists+bpf@lfdr.de>; Sat,  3 Aug 2024 01:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A940F1F22CE0
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 23:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AB513A88A;
	Fri,  2 Aug 2024 23:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="e2NxG781"
X-Original-To: bpf@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABC25258;
	Fri,  2 Aug 2024 23:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722640100; cv=none; b=c8i1fpa5nI1oLb6/qFPQhVSXH4Y9DroD3nHjF2ZtZnXyjy4VbM1lNtbXV9eztdV3Y0Dbr4NCV6c1Qc90anGFfgvbtothFsukhorCW880mNGzuZLXbHk1yKbZN2SLAMvul0zRlUyQNTSsVRXt+im4zpoMhTEpjkT4uy+t3ONfwds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722640100; c=relaxed/simple;
	bh=WI6oypT/oiwwUtwYuwNP2UGscdgLAh/K8+fT/qS/g0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQt55izepRLc+2BmQnpvI5qLXgUVqhtxz2Xe00byJ0vuRcHhH1rHRKNvummM/FhOkSBCUKRhcc1d4OmGueSC2KYHGcmaraoD18Wo8GR2kJ3Ecp33jmU2R6stvr7p+uQlaHLN7wFSNWJ2w8fFuVszzX8PtH/U421QPKvEwONn/Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=e2NxG781; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kCvDw6cMtXkCqDiB477k4mCcHd/xIbtjON9PoTAGLh0=; b=e2NxG7814mITJZkIfu4rFDAQiq
	4IaKpIXaqfpBWOc/2N3uQisgAiCLLAhpdwFxkk1fEKfczfNYFDQxGTGUDptl5EScLDbW5fj5x1ZNB
	rrF9CYaTigZp8FbYQ884wruCeDwJHl+xblWWzq3+FiSnmWvmInXnEPObZMsTQBHZvx2s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sa1NQ-003tlO-OQ; Sat, 03 Aug 2024 01:08:00 +0200
Date: Sat, 3 Aug 2024 01:08:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: jitendra.vegiraju@broadcom.com
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	bcm-kernel-feedback-list@broadcom.com, richardcochran@gmail.com,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
	linux@armlinux.org.uk, horms@kernel.org,
	florian.fainelli@broadcom.com
Subject: Re: [PATCH net-next v3 3/3] net: stmmac: Add PCI driver support for
 BCM8958x
Message-ID: <c2e2f11a-89d8-42fa-a655-972a4ab372da@lunn.ch>
References: <20240802031822.1862030-1-jitendra.vegiraju@broadcom.com>
 <20240802031822.1862030-4-jitendra.vegiraju@broadcom.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802031822.1862030-4-jitendra.vegiraju@broadcom.com>

> Management of integrated ethernet switch on this SoC is not handled by
> the PCIe interface.

MDIO? SPI? I2C?

> +#define XGMAC_PCIE_MISC_MII_CTRL			0x4
> +#define XGMAC_PCIE_MISC_MII_CTRL_VALUE			0x7

Could you replace these magic values with actual definitions. What
does 7 mean?

> +#define XGMAC_PCIE_MISC_PCIESS_CTRL			0x8
> +#define XGMAC_PCIE_MISC_PCIESS_CTRL_VALUE		0x200

> +static int num_instances;

> +	/* This device is directly attached to the switch chip internal to the
> +	 * SoC using XGMII interface. Since no MDIO is present, register
> +	 * fixed-link software_node to create phylink.
> +	 */
> +	if (num_instances == 0) {
> +		ret = software_node_register_node_group(fixed_link_node_group);
> +		if (ret) {
> +			dev_err(&pdev->dev,
> +				"%s: failed to register software node\n",
> +				__func__);
> +			return ret;
> +		}
> +	}
> +	num_instances++;

So all the instances of the MAC share one fixed link? That is pretty
unusual. In DT, each would have its own. Have you reviewed the
implications of this?

	Andrew

