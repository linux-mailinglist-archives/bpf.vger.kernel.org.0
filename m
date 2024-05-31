Return-Path: <bpf+bounces-31019-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 269708D609E
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 13:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A3C91C23CCB
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 11:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85EAC157480;
	Fri, 31 May 2024 11:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="BTj0mDAp"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93886157469;
	Fri, 31 May 2024 11:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717154768; cv=none; b=XB4+bdoRk713j4e9RXBVG+ydN4Qh6aCVGrvmh4nYmtCuvWz1tmW6kiFj+rVyyN8VxK4eWUqUf2/sOzLg3IIr5jM7C1qyxZRIfAS1ClYuPg2r6mDsTdC/MCFKwydgipx2oVmKgvRTEXOe+BabsojCWb6gRPbHn2JCrmD0IRKq9YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717154768; c=relaxed/simple;
	bh=XFV9/tpoxAasMKJ6r6uC8h6xU1uC7yi21wCCQxN0vg8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=joR+hmoHUJTcrBqy02RjKS0UtgnDELE/WtvheVtzk6eLeb/3/5v1BbNTOFb+wEu5E+6xunG0XiBjhvJ8Osm4fdknlebyieeRUpnowXYA0wtuwdzvWW++wwLbB79EzEEafH5xaYfweq8WKWw5mDljM6C9VZ5VNWy63vpJKsAsWrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=BTj0mDAp; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vJEcpcI3DDmVpZ/th+vmT2vib7QpzkNwo7AkdINnSmk=; b=BTj0mDApK2ybh6JuEQfB5S1nnk
	6nEj8bw3WgJ/pKoyO6SBCNTkzeFx5L2gvrnvyailtNpBU5p83UcbVN+Kt6xIPkLThD/ihLMSMhd3Z
	RnSQOXV7uy8TstNZoXAxVNCc6Af4EV7yveDb7kCO0rQPosK26VnJQ0XSl7Ocht4XzF0gWcGMZG9h/
	kugzczY/vxJvTa8RYxiFMJobEKqGL4dLTWhsRfwVO1bJ3vo6ViJfL8vR1EiLPT2/FYVJZvQlwJZb+
	ZNfDOBqQ8o3H8jP36Op+aBEH8/5RjrOCgPlAgNIrVKftAB6iuZ9EZbg6aWk65SkqAQoARQK9poOWp
	G4nlU2uw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36288)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sD0OK-0008Qz-1u;
	Fri, 31 May 2024 12:25:48 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sD0OJ-00061r-Kl; Fri, 31 May 2024 12:25:47 +0100
Date: Fri, 31 May 2024 12:25:47 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Andrew Halaney <ahalaney@redhat.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH RFC v2 0/8] net: stmmac: convert stmmac "pcs" to phylink
Message-ID: <Zlmzu7/ANyZxOOQL@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi,

This is version 2 of the series switching stmmac to use phylink PCS
instead of going behind phylink's back.

Changes since version 1:
- Addition of patches from Serge Semin to allow RGMII to use the
  "PCS" code even if priv->dma_cap.pcs is not set (including tweaks
  by me.)
- Restructuring of the patch set to be a more logical split.
- Leave the pcs_ctrl_ane methods until we've worked out what to do
  with the qcom-ethqos driver (this series may still end up breaking
  it, but at least we will now successfully compile.)

A reminder that what I want to hear from this patch set are the results
of testing - and thanks to Serge, the RGMII paths were exercised, but
I have not had any results for the SGMII side of this.

There are still a bunch of outstanding questions:

- whether we should be using two separate PCS instances, one for
  RGMII and another for SGMII. If the PCS hardware is not present,
  but are using RGMII mode, then we probably don't want to be
  accessing the registers that would've been there for SGMII.
- what the three interrupts associated with the PCS code actually
  mean when they fire.
- which block's status we're reading in the pcs_get_state() method,
  and whether we should be reading that for both RGMII and SGMII.
- whether we need to activate phylink's inband mode in more cases
  (so that the PCS/MAC status gets read and used for the link.)

There's probably more questions to be asked... but really the critical
thing is to shake out any breakage from making this conversion. Bear
in mind that I have little knowledge of this hardware, so this
conversion has been done somewhat blind using only what I can observe
from the current driver.

Original blurb below.

As I noted recently in a thread (and was ignored) stmmac sucks. (I
won't hide my distain for drivers that make my life as phylink
maintainer more difficult!)

One of the contract conditions for using phylink is that the driver
will _not_ mess with the netif carrier. stmmac developers/maintainers
clearly didn't read that, because stmmac messes with the netif
carrier, which destroys phylink's guarantee that it'll make certain
calls in a particular order (e.g. it won't call mac_link_up() twice
in a row without an intervening mac_link_down().) This is clearly
stated in the phylink documentation.

Thus, this patch set attempts to fix this. Why does it mess with the
netif carrier? It has its own independent PCS implementation that
completely bypasses phylink _while_ phylink is still being used.
This is not acceptable. Either the driver uses phylink, or it doesn't
use phylink. There is no half-way house about this. Therefore, this
driver needs to either be fixed, or needs to stop using phylink.

Since I was ignored when I brought this up, I've hacked together the
following patch set - and it is hacky at the moment. It's also broken
because of recentl changes involving dwmac-qcom-ethqos.c - but there
isn't sufficient information in the driver for me to fix this. The
driver appears to use SGMII at 2500Mbps, which simply does not exist.
What interface mode (and neg_mode) does phylink pass to pcs_config()
in each of the speeds that dwmac-qcom-ethqos.c is interested in.
Without this information, I can't do that conversion. So for the
purposes of this, I've just ignored dwmac-qcom-ethqos.c (which means
it will fail to build.)

The patch splitup is not ideal, but that's not what I'm interested in
here. What I want to hear is the results of testing - does this switch
of the RGMII/SGMII "pcs" stuff to a phylink_pcs work for this driver?

Please don't review the patches, but you are welcome to send fixes to
them. Once we know that the overall implementation works, then I'll
look at how best to split the patches. In the mean time, the present
form is more convenient for making changes and fixing things.

There is still more improvement that's needed here.

Thanks.

 drivers/net/ethernet/stmicro/stmmac/Makefile       |   2 +-
 drivers/net/ethernet/stmicro/stmmac/common.h       |  12 +-
 .../net/ethernet/stmicro/stmmac/dwmac1000_core.c   | 146 ++++++++++++++-------
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  | 131 +++++++++++++-----
 drivers/net/ethernet/stmicro/stmmac/hwif.h         |  19 ++-
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   | 111 +---------------
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  33 ++---
 drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c   |  58 ++++++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h   |  34 +----
 9 files changed, 298 insertions(+), 248 deletions(-)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

