Return-Path: <bpf+bounces-49481-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C986FA191C1
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 13:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41DEF18883CA
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 12:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82A4213242;
	Wed, 22 Jan 2025 12:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kJ90qTlI"
X-Original-To: bpf@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD53211A33;
	Wed, 22 Jan 2025 12:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737550284; cv=none; b=l7qTyJjyXdQtNUXo9AKVdIwHzsMPc2tirIcnNAl9B5X230+5I3xbm0/wpTyi3Ryo/YK1APr6FyX1ztSWtWIBrJeC5obwGHn+be3z8mWzYLRhGEl7nE85iT0lrOuo2Vzn2rRQqKTg8UGMD6MWg8XcYW5LZJ78ggTbBM8cXqsIHW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737550284; c=relaxed/simple;
	bh=hCelolFFOP07qkTFGLrGfcNVaZbpx4pmVPj0dfmfcIE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PmX0+eI7drakt8g6ahD/p3xkhRFvMBb6oyh06ej08ovjqE4/1hiKEjEEdCvYbQoHoJGqbXWCs042L8DEJoP14TiXVXRmjvGg853Uk4CBwwRVrYvpt/oMkkDukwCyzPALsdZp64c3PJcYDmd7eYtkbwUp+u4sjzTuMj+Efw5nTRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kJ90qTlI; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 50MCoPfk1012928
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 06:50:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1737550226;
	bh=rzsitFajKNQgm3+5WVXmKqy42uC96f1m1FRZWnKkx4M=;
	h=From:To:CC:Subject:Date;
	b=kJ90qTlI8xP7aJKzQEo8qHIpLJTheSsCstHj1GdsKIFXXg5/wVQhyTQYit24QXfCA
	 S2OoBjqu/lS+yvD9Um4D9M+82fBVa38zMGW9la6BIglcgeNdgmROEKZCo8rumAjimu
	 xvhZiBuXglzrrhoDmFCbua4yUy9m38RN+Rw4//JY=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 50MCoPQb024960
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 22 Jan 2025 06:50:25 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 22
 Jan 2025 06:50:25 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 22 Jan 2025 06:50:25 -0600
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50MCoP17014791;
	Wed, 22 Jan 2025 06:50:25 -0600
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 50MCoONL026475;
	Wed, 22 Jan 2025 06:50:25 -0600
From: Meghana Malladi <m-malladi@ti.com>
To: <rogerq@kernel.org>, <danishanwar@ti.com>, <pabeni@redhat.com>,
        <kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
        <andrew+netdev@lunn.ch>
CC: <bpf@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <robh@kernel.org>, <matthias.schiffer@ew.tq-group.com>,
        <m-malladi@ti.com>, <dan.carpenter@linaro.org>,
        <rdunlap@infradead.org>, <diogo.ivo@siemens.com>,
        <schnelle@linux.ibm.com>, <glaroque@baylibre.com>,
        <john.fastabend@gmail.com>, <hawk@kernel.org>, <daniel@iogearbox.net>,
        <ast@kernel.org>, <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH net 0/3] Add native mode XDP support
Date: Wed, 22 Jan 2025 18:19:48 +0530
Message-ID: <20250122124951.3072410-1-m-malladi@ti.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

This series adds native XDP support using page_pool.
XDP zero copy support is not included in this patch series.

Patch 1/3: Replaces skb with page pool for Rx buffer allocation
Patch 2/3: Adds prueth_swdata struct for SWDATA for all swdata cases
Patch 3/3: Introduces native mode XDP support

Roger Quadros (3):
  net: ti: icssg-prueth: Use page_pool API for RX buffer allocation
  net: ti: icssg-prueth: introduce and use prueth_swdata struct for
    SWDATA
  net: ti: icssg-prueth: Add AF_XDP support

 drivers/net/ethernet/ti/Kconfig               |   1 +
 drivers/net/ethernet/ti/icssg/icssg_common.c  | 435 ++++++++++++++----
 drivers/net/ethernet/ti/icssg/icssg_config.h  |   2 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  | 124 ++++-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |  51 +-
 .../net/ethernet/ti/icssg/icssg_prueth_sr1.c  |  23 +-
 6 files changed, 543 insertions(+), 93 deletions(-)


base-commit: 49afc040f4d707a4149a05180edc42bc590641a4
-- 
2.25.1


