Return-Path: <bpf+bounces-68113-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E36B52F78
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 13:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90E85177337
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 11:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892D131C570;
	Thu, 11 Sep 2025 11:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ZL+OgqGs"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BA13168EA;
	Thu, 11 Sep 2025 11:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757588835; cv=none; b=hht1EsrWroNPPorEki5+MQSENTpyPV/aF2IYKkx5kh1XywkOQka5MSFp6EGytc8L1UiLMHpr21NG/8bZOj6ztduxkw6Anw28Fw5DCqssMsSjo3pk4/buHHdg9AHxDMzvcT6FcR7dlVx8PPj2uf2byfMwmDseNRCFRPAbYimGKQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757588835; c=relaxed/simple;
	bh=Y3S40h4t4YOYFXpWL6Zb0/KLqZvU/SjdruT37V7g0Tg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=r5R9vSU+KB8XyhMo/IBuilJy5fBHGQ3rm0y1zAMZvo31WFQGrvqsi2PcTZNYe9JF9rhtHinL+TbfKu3hd5CZJynXN+XcX1A8o5pvq/3Qs30mO4V5PZZg3hiE53md3TlVlo9bZ5iqebE5NCWBAtW6r0DS4mmu2p/8uBskejeYx4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ZL+OgqGs; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8qB3/M4iROaSgOmiFUSzNNAEGfamTBErIeBwN20mtPg=; b=ZL+OgqGsNYNibAv1PnDfVADpz8
	7a0mUOE4b1h3RD9rRCeP0XaDn+DO/qqf2TSiTszg9nLZTxw8qgFYrteLG+ceH5ELboIMDf/J38T9Z
	x25A7t/th3w4JgBSJecFu43nYq5Ksk7wCmai8F8FT5OaUiE6D9O3J77pPa6RKB1kw5n9ZySbcJv5r
	UM6aa/eeoAlTc2uWWqnznpXobIrByO6U8JvLBVpctberK0RKent3Bj4cimHV+34g8Lk49slxcD8J4
	7u7SIh8FpGg/NPaUawSrhjY87fIeGLnzZ3Pmh2nKvrdSdNXL1yb+8gSCSBsK7MZMdLMuvGKFoOuQo
	xQrX9o8w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40946)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uwf8t-000000002rL-2Lgr;
	Thu, 11 Sep 2025 12:07:07 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uwf8p-000000002IN-3cf6;
	Thu, 11 Sep 2025 12:07:03 +0100
Date: Thu, 11 Sep 2025 12:07:03 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: [PATCH net-next v2 00/11] net: stmmac: timestamping/ptp cleanups
Message-ID: <aMKtV6O0WqlmJFN4@shell.armlinux.org.uk>
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

This series cleans up the hardware timestamping / PTP initialisation
and cleanup code in the stmmac driver. Several key points in no
particular order:

1. Golden rule: unregister first, then release resources.
   stmmac_release_ptp didn't do this.

2. Avoid leaking resources - __stmmac_open() failure leaves the
   timestamping support initialised, but stops its clock. Also
   violates (1).

3. Avoid double-release of resources - stmmac_open() followed by
   stmmac_xdp_open() failing results in the PTP clock prepare and
   enable counts being released, and if the interface is then
   brought down, they are incorrectly released again. As XDP
   doesn't gain any additional prepare/enables on the PTP clock,
   remove this incorrect cleanup.

4. Changing the MTU of the interface is disruptive to PTP, and
   remains so as long as. This is not fixed by this series (too
   invasive at the moment.)

5. Avoid exporting functions that aren't used...

6. Avoid unnecessary runtime PM state manipulations (no point
   manipulating this when MTU changes).

7. Make the PTP/timestamping initialisation more readable - no
   point calling functions in the same file from one callsite
   that return error codes from one location in the called function,
   to only have the sole callee print messages depending on that
   return code. Also simplifying the mess in stmmac_hw_setup().
   Also placing support checks in a better location. Also getting
   rid of the "ptp_register" boolean through this restructuring.

Not tested beyond compile testing. (I don't have my Jetson Xavier NX
platform.) So anyone testing this and providing feedback would be
most welcome.

v1 was tested by Gatien CHEVALLIER - thanks.

v2: update patch descriptions on a couple of patches identified in v1.

 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |   1 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 113 ++++++++++++----------
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c  |  10 +-
 3 files changed, 67 insertions(+), 57 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

