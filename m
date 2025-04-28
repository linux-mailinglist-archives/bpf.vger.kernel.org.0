Return-Path: <bpf+bounces-56837-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB626A9F039
	for <lists+bpf@lfdr.de>; Mon, 28 Apr 2025 14:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDA3A1A8181B
	for <lists+bpf@lfdr.de>; Mon, 28 Apr 2025 12:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D048267B0E;
	Mon, 28 Apr 2025 12:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yumF25c5"
X-Original-To: bpf@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582A626738A;
	Mon, 28 Apr 2025 12:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745841936; cv=none; b=Uo6zCHYGdAVOD94/JaeKOFbql1Pw9OuTcbXNwoLO7y18cVyknPRB/n/AjtOW0Q1/5tvaZYLCJ0kTqxXh3FC06PAWe/5UIMA7OSKSbuIh1/8OEcm0Jv5no7KidC7a0nAGwALfjZ/FJIBaOONqW3KOJO2aCeDDKk1Ns7cAdcHzCRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745841936; c=relaxed/simple;
	bh=l6COzp162sPy3iLEeB0x8B+SOeX9Lkg6j1DjkyyiyW4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JkxgLct608U3jWcNQpHXtKKo/FFMMOWZAHsbM0pNnpUgZn6cvcLc+ogPwCXkRISMgiiFBca5/oYfgifC3HP4OC9JELNMBFWJdwdI6/HKLbHILzBrFeFbW/tRaJpLLKgrH0Hz6oSV6F455cq+oxesORKm71f9dCy4cIxD8g5TzEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=yumF25c5; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53SC54pA3531175
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 07:05:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1745841904;
	bh=6DRyDcyPSgFT59lfHen3lkJueNSOvm0dbM7e8Gn/vj0=;
	h=From:To:CC:Subject:Date;
	b=yumF25c5X2+yq5LAxgos6DOvdGR4oAomJEyMeMOaLdLEdrB2s+EE1etwCakwi0gEX
	 hR6uHys9JOLhsKj3M//6mu1dBgLw3Sfh7s4VIuogw+PsrOUo01MNuytjijfs17eWGl
	 1h9N9nG+Zr1WOgbjM3zI4Vr5+IjnGlBeZy8bholE=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53SC54dB061149
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 28 Apr 2025 07:05:04 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 28
 Apr 2025 07:05:04 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 28 Apr 2025 07:05:04 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53SC54iK023623;
	Mon, 28 Apr 2025 07:05:04 -0500
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 53SC52ih026319;
	Mon, 28 Apr 2025 07:05:03 -0500
From: Meghana Malladi <m-malladi@ti.com>
To: <dan.carpenter@linaro.org>, <m-malladi@ti.com>, <john.fastabend@gmail.com>,
        <hawk@kernel.org>, <daniel@iogearbox.net>, <ast@kernel.org>,
        <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net 0/4] Bug fixes from XDP patch series
Date: Mon, 28 Apr 2025 17:34:55 +0530
Message-ID: <20250428120459.244525-1-m-malladi@ti.com>
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

This patch series fixes the bugs introduced while adding
xdp support in the icssg driver, and were reproduced while
running xdp-trafficgen to generate xdp traffic on icssg interfaces. 

Meghana Malladi (4):
  net: ti: icssg-prueth: Set XDP feature flags for ndev
  net: ti: icssg-prueth: Report BQL before sending XDP packets
  net: ti: icssg-prueth: Fix race condition for traffic from different
    network sockets
  net: ti: icssg-prueth: Fix kernel panic during concurrent Tx queue
    access

 drivers/net/ethernet/ti/icssg/icssg_common.c | 22 ++++++++++++++++++--
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 16 ++++++++------
 drivers/net/ethernet/ti/icssg/icssg_prueth.h |  1 +
 3 files changed, 31 insertions(+), 8 deletions(-)


base-commit: cc17b4b9c332cc654b248619c1d8ca40d80d1155
-- 
2.43.0


