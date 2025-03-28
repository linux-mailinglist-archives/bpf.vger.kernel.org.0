Return-Path: <bpf+bounces-54849-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F762A7482A
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 11:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE1231B618C3
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 10:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0751421A445;
	Fri, 28 Mar 2025 10:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="s5CvMA8B"
X-Original-To: bpf@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9188216E1B;
	Fri, 28 Mar 2025 10:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743157498; cv=none; b=tGwxisIIU2EvvMR3rmGxDrLNu9JKJ2R7FdYNtAPZ4SsRXjFrZjLfqLsN+XQb4af27jvtOyhQ8DW616Tl5c8b72WWdNHnQTpGvBR3UlhsCkgfRp0cD+9Nq6O3K4NxG35sFovJCLI5zxX8sKBNh92BFWTHNmyNnjh0LQKo3ne5qLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743157498; c=relaxed/simple;
	bh=6VeiUkvgElYt6MHhS33HWI7Qu+kTxS1xsNic7r8ZugY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=quaG7yh+sPLVoxaQHCy9o8xA7sUgBuxuTk3BcmwLG4I/ESGFxbJFNb4r/8nEmDpIJBE9TXF78bgsiIKX4JzRAeJBmS5qo3p1stIbvXAYhLIHAJ5K4Apf3HzcDbgwXRKhGFXUJc7l3v/xUsoCW/7BbRvpDkcC/VdRkBZyH0KQ+UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=s5CvMA8B; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52SAO82b2688996
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Mar 2025 05:24:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1743157448;
	bh=t1CpYJHlklxVaczx+DLXp4fuzyVScYBG+2bxQ+q3SXQ=;
	h=From:To:CC:Subject:Date;
	b=s5CvMA8BE+6lnk+wW5QcURfa1sHg6GpDJbmqvWGZYD4DGkUdbu4cV1HA5OxicDcOi
	 xX6UGAU/ijzwUfeiA192YD0ckN5lNFLxet3njnc7aNY1FklpnkJdSOJrQ5PI04W9fg
	 E/+CjiXIAYZQEE91QRJM4q9/XTwNiFzbo0cOm9/c=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52SAO8av016101
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 28 Mar 2025 05:24:08 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 28
 Mar 2025 05:24:07 -0500
Received: from fllvsmtp8.itg.ti.com (10.64.41.158) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 28 Mar 2025 05:24:07 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by fllvsmtp8.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52SAO7vU080225;
	Fri, 28 Mar 2025 05:24:07 -0500
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 52SAO5OJ024918;
	Fri, 28 Mar 2025 05:24:06 -0500
From: Meghana Malladi <m-malladi@ti.com>
To: <dan.carpenter@linaro.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
        <edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <namcao@linutronix.de>, <javier.carrasco.cruz@gmail.com>,
        <diogo.ivo@siemens.com>, <horms@kernel.org>,
        <jacob.e.keller@intel.com>, <m-malladi@ti.com>,
        <john.fastabend@gmail.com>, <hawk@kernel.org>, <daniel@iogearbox.net>,
        <ast@kernel.org>, <srk@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net v3 0/3] Bug fixes from XDP and perout series
Date: Fri, 28 Mar 2025 15:54:00 +0530
Message-ID: <20250328102403.2626974-1-m-malladi@ti.com>
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

This patch series consists of bug fixes from the XDP/perout series:
1. Fixes a kernel warning that occurs when bringing down the
   network interface.
2. Resolves a potential NULL pointer dereference in the
   emac_xmit_xdp_frame() function.
3. Resolves a potential NULL pointer dereference in the
   icss_iep_perout_enable() function

v2: https://lore.kernel.org/all/20250321081313.37112-1-m-malladi@ti.com/

Changes from v2 (v3-v2):
- Posting to net tree as the features have been merged to net.

Meghana Malladi (3):
  net: ti: icssg-prueth: Fix kernel warning while bringing down network
    interface
  net: ti: icssg-prueth: Fix possible NULL pointer dereference inside
    emac_xmit_xdp_frame()
  net: ti: icss-iep: Fix possible NULL pointer dereference for perout
    request

 drivers/net/ethernet/ti/icssg/icss_iep.c     | 4 ++--
 drivers/net/ethernet/ti/icssg/icssg_common.c | 9 ++++-----
 2 files changed, 6 insertions(+), 7 deletions(-)


base-commit: 2eb6c6a34cb1c22b09b219390cdff0f02cd90258
-- 
2.43.0


