Return-Path: <bpf+bounces-57506-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A41AAC208
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 13:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D5114C7529
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 11:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C37627A448;
	Tue,  6 May 2025 11:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OJkJakUP"
X-Original-To: bpf@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105CE2797AA;
	Tue,  6 May 2025 11:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746529592; cv=none; b=EFqknGxHNIvzsQF1sh3OgM8vuSOT61YXhmBQUaGAzOh9LOd4ds2FZufFGVzQixt2zCL/6orugJbFKsQyBCZ8Qd//DkIWZA1oUKyE4wYauLalI3dPrTknJcMsxa73Z/v9beqww++2kniB7HX2Zb5wK5XlGewzj92+TfmrqhVnhrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746529592; c=relaxed/simple;
	bh=zr6B6BHk0ijs+WAE8Za6/YddqsXcbPx2EntaO/pYqLI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L272JSbroX2ezYKzzT9RyA1uv4uTPQx8MCBQcLIxSTNPja8XbfmYGWCnRriXLQhBt7rAMlP3kn+hSpzD7xZ9ccThyRa6nX+PGAOtwCMmNtEM/3sdeSQHk7dmeJh75tpZOutdpsJI9xKWx85PlCyuDuEGFZXMyrAYGL/JWM2y4ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OJkJakUP; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 546B5pWU505365
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 May 2025 06:05:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1746529551;
	bh=kvvixGItnP8EXItNCvGOcFRVOXqkBwtBwhbiCKvfChM=;
	h=From:To:CC:Subject:Date;
	b=OJkJakUPKklp+XK+d4qOPDKY+LCananYXCsGJaA1/TdIVSIKFfSoswF9F7OpHsTI/
	 ORP9UfQF/aqrRQygaVlpP8RHpMyw70xLn2J1YivG3sCgG22bjnVTBPTf1QYjxnud0Y
	 mXPIljeRcBY9n7GYpEYMXw18zYVNi65xV9yWlONg=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 546B5pVS024284
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 May 2025 06:05:51 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 May 2025 06:05:51 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 May 2025 06:05:51 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 546B5prY127657;
	Tue, 6 May 2025 06:05:51 -0500
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 546B5no5010330;
	Tue, 6 May 2025 06:05:50 -0500
From: Meghana Malladi <m-malladi@ti.com>
To: <namcao@linutronix.de>, <horms@kernel.org>, <m-malladi@ti.com>,
        <john.fastabend@gmail.com>, <hawk@kernel.org>, <daniel@iogearbox.net>,
        <ast@kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
        <edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net v2 0/3] Bug fixes from XDP patch series
Date: Tue, 6 May 2025 16:35:43 +0530
Message-ID: <20250506110546.4065715-1-m-malladi@ti.com>
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

v1: https://lore.kernel.org/all/20250428120459.244525-1-m-malladi@ti.com/

Meghana Malladi (3):
  net: ti: icssg-prueth: Set XDP feature flags for ndev
  net: ti: icssg-prueth: Fix kernel panic during concurrent Tx queue
    access
  net: ti: icssg-prueth: Report BQL before sending XDP packets

 drivers/net/ethernet/ti/icssg/icssg_common.c | 15 +++++++++++++--
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 16 ++++++++++------
 2 files changed, 23 insertions(+), 8 deletions(-)


base-commit: 8c2e6b26ffe243be1e78f5a4bfb1a857d6e6f6d6
-- 
2.43.0


