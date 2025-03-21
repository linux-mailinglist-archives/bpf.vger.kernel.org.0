Return-Path: <bpf+bounces-54531-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6FFA6B5E6
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 09:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF4DA465013
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 08:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FC61F0E54;
	Fri, 21 Mar 2025 08:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BRuJ55FL"
X-Original-To: bpf@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910D81F0E20;
	Fri, 21 Mar 2025 08:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742544842; cv=none; b=LVkQ3jnXuKyFydwx6TEyMoJ9HC5jDw3sUsDnt+kr8s3UsfglOQfhVnCNO10Emx5/oCquVV1XXd97hwk3yQdqRgVrppADFk+pLSifJvrlonuU0cQoaOHtFiSXJtCl3Dr5grJZUmwsBt/VituRq6eVKoUc5bG/lOookwuOeLD4Y2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742544842; c=relaxed/simple;
	bh=giItXvr0qEiG7naihd/IsnoR7WxuXOIxuT2IYEnS6VA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ctc4BXTnwJmbnYJx+xbL0iqy5C3v7CI0niVjnlaHsdFhE8I17r1UctjhByp8OMrp45dKCEY7c5XIzy6DiRRSsIAb6WQXxPEHXjt5nDERL/+hFsabgN4GW9nnmhq1Va9qt5nIzTAkCGpBSP/Hg3dT/xK0IzRBOC1I6uj1H1lDVps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BRuJ55FL; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52L8DJaE855070
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 21 Mar 2025 03:13:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1742544799;
	bh=J6Ul1FLsyftKxNQEjsWV5e3ecH3RvVGlfo884n4XtIs=;
	h=From:To:CC:Subject:Date;
	b=BRuJ55FLRFKjpLI5Y0N6l6c/qEFww5dm/6k8FIQgg6lQCjQ5qij8G4Y0zt1u2Rky9
	 E3AmZn4KmXWlwhqpgAWhWgZOn8m5yk59MjFNpXVxmJEEBIBLy87mTrtZfIzNZ8Vg2v
	 jyFlX+7KGLRHxViC/I0y7yhdwnxyxLdblVV1/F7c=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52L8DILb127538;
	Fri, 21 Mar 2025 03:13:18 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 21
 Mar 2025 03:13:18 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 21 Mar 2025 03:13:18 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52L8DIG6130148;
	Fri, 21 Mar 2025 03:13:18 -0500
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 52L8DHmX032421;
	Fri, 21 Mar 2025 03:13:17 -0500
From: Meghana Malladi <m-malladi@ti.com>
To: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <kory.maincent@bootlin.com>, <dan.carpenter@linaro.org>,
        <javier.carrasco.cruz@gmail.com>, <diogo.ivo@siemens.com>,
        <jacob.e.keller@intel.com>, <horms@kernel.org>, <m-malladi@ti.com>,
        <john.fastabend@gmail.com>, <hawk@kernel.org>, <daniel@iogearbox.net>,
        <ast@kernel.org>, <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Roger
 Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net-next v2 0/3] Bug fixes from XDP and perout series
Date: Fri, 21 Mar 2025 13:43:10 +0530
Message-ID: <20250321081313.37112-1-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

This patch series consists of bug fixes from the features which recently
got merged into net-next, and haven't been merged to net tree yet.

Patch 2/3 and 3/3 are bug fixes reported by Dan Carpenter
<dan.carpenter@linaro.org> using Smatch static checker.

Meghana Malladi (3):
  net: ti: prueth: Fix kernel warning while bringing down network
    interface
  net: ti: prueth: Fix possible NULL pointer dereference inside
    emac_xmit_xdp_frame()
  net: ti: icss-iep: Fix possible NULL pointer dereference for perout
    request

 drivers/net/ethernet/ti/icssg/icss_iep.c     | 4 ++++
 drivers/net/ethernet/ti/icssg/icssg_common.c | 9 ++++-----
 2 files changed, 8 insertions(+), 5 deletions(-)


base-commit: 6f13bec53a48c7120dc6dc358cacea13251a471f
-- 
2.43.0


