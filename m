Return-Path: <bpf+bounces-38971-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0115E96D160
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 10:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33F631C22C56
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 08:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AD41946DA;
	Thu,  5 Sep 2024 08:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="bkSTZZz5"
X-Original-To: bpf@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F6F1946C1;
	Thu,  5 Sep 2024 08:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523654; cv=none; b=XbKPMUBpasOEc1z/GBMkO0p5SNpa79mZBGNrwNve8Qjet49nQrRLcjGpt+XXn2OBJNk6OFYVH3uVYzctluBXUL8UL0KVmCp+4d5UyG0nlO6X+iLjwrFWPoUpzn8ypYXj7dVupX8HUhIJDjOfPI3TCcAVkF9eNeAr+V5H/M2bI/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523654; c=relaxed/simple;
	bh=sQmwqtbyKWeKClURYxtHruG04ZVecYGGYN4qShRAmGY=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=qkczVHCFofcjCqSTYbbhXNsUHJyieSi/GXRDRq3loAMwYKKkVzqLXJQEKsYucN6R31VCqRjC5tsNiMsPhixN5ZuB1WscIKsTyXudU6eMDiJGeyAk5qnC6hNKOejsgXcggzBSeY2tT7sgDwQnkdrp2gqkgnknDnWFq5EAv770Bfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=bkSTZZz5; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725523653; x=1757059653;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=sQmwqtbyKWeKClURYxtHruG04ZVecYGGYN4qShRAmGY=;
  b=bkSTZZz5xbkPPHZuZb+YVh4NBEyhY2cGizZ60U7smE8qnH+NaRtzdKHW
   bYz3V5ioN2X0YeW8eEJLpMa/wLOqtr/Dc+a+kiNsoPwq0loJALYd6k8lu
   8/EO4ALJXAJ2oemlnfv9n8Rl1X7m5QaPxiPluQl64vwtxNUxJeBffZyeD
   JW1/RVu38/hzvUZukmL3sweyNv3Rtf1QB53I6fjaGuCdA37ahWLBdmXHt
   ggpUQXM0iZn/niJ5Fvrw/q3ByaDrPV3GrPELgGzTfkhsm3XdZJHGpLHNk
   BqpPiKUKDP1wy0aNFl1EAOa8l2R7P3rn6OYggdgmHZoHO3NBfZL2k87jG
   w==;
X-CSE-ConnectionGUID: rESGLHboTQ606MdHMphuVg==
X-CSE-MsgGUID: HUJvOwDWRSaErmv9CWM78g==
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="198790962"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Sep 2024 01:07:32 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 5 Sep 2024 01:06:52 -0700
Received: from [10.205.21.108] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 5 Sep 2024 01:06:50 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Subject: [PATCH net-next 00/12] net: lan966x: use the newly introduced FDMA
 library
Date: Thu, 5 Sep 2024 10:06:28 +0200
Message-ID: <20240905-fdma-lan966x-v1-0-e083f8620165@microchip.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIRm2WYC/x2MQQqDMBAAvyJ77kJMoxi/UnrYxFUX6lYSKQHx7
 017HIaZEzIn4Qxjc0Lij2R5a4X21kBcSRdGmSqDNdYZbxzO00b4IvV9X9A4O7Sxu/vOBqjJnni
 W8t89QPlA5XLAs5pAmTEk0rj+dhuJwnV9AUe1Jip/AAAA
To: Horatiu Vultur <horatiu.vultur@microchip.com>,
	<UNGLinuxDriver@microchip.com>, "David S. Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
	"John Fastabend" <john.fastabend@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
X-Mailer: b4 0.14-dev

This patch series is the second of a 2-part series [1], that adds a new
common FDMA library for Microchip switch chips Sparx5 and lan966x. These
chips share the same FDMA engine, and as such will benefit from a common
library with a common implementation.  This also has the benefit of
removing a lot of open-coded bookkeeping and duplicate code for the two
drivers.

In this second series, the FDMA library will be taken into use by the
lan966x switch driver.

 ###################
 # Example of use: #
 ###################

- Initialize the rx and tx fdma structs with values for: number of
  DCB's, number of DB's, channel ID, DB size (data buffer size), and
  total size of the requested memory. Also provide two callbacks:
  nextptr_cb() and dataptr_cb() for getting the nextptr and dataptr.

- Allocate memory using fdma_alloc_phys() or fdma_alloc_coherent().

- Initialize the DCB's with fdma_dcb_init().

- Add new DCB's with fdma_dcb_add().

- Free memory with fdma_free_phys() or fdma_free_coherent().

 #####################
 # Patch  breakdown: #
 #####################

Patch #1:  select FDMA library for lan966x.

Patch #2:  includes the fdma_api.h header and removes old symbols.

Patch #3:  replaces old rx and tx variables with equivalent ones from the
           fdma struct. Only the variables that can be changed without
           breaking traffic is changed in this patch.

Patch #4:  uses the library for allocation of rx buffers. This requires
           quite a bit of refactoring in this single patch.

Patch #5:  uses the library for adding DCB's in the rx path.

Patch #6:  uses the library for freeing rx buffers.

Patch #7:  uses the library for allocation of tx buffers. This requires
           quite a bit of refactoring in this single patch.

Patch #8:  uses the library for adding DCB's in the tx path.

Patch #9:  uses the library helpers in the tx path.

Patch #10: ditch last_in_use variable and use library instead.

Patch #11: uses library helpers throughout.

Patch #12: refactor lan966x_fdma_reload() function.

[1] https://lore.kernel.org/netdev/20240902-fdma-sparx5-v1-0-1e7d5e5a9f34@microchip.com/

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
Daniel Machon (12):
      net: lan966x: select FDMA library
      net: lan966x: use FDMA library symbols
      net: lan966x: replace a few variables with new equivalent ones
      net: lan966x: use the FDMA library for allocation of rx buffers
      net: lan966x: use FDMA library for adding DCB's in the rx path
      net: lan966x: use library helper for freeing rx buffers
      net: lan966x: use the FDMA library for allocation of tx buffers
      net: lan966x: use FDMA library for adding DCB's in the tx path
      net: lan966x: use library helper for freeing tx buffers
      net: lan966x: ditch tx->last_in_use variable
      net: lan966x: use a few FDMA helpers throughout
      net: lan966x: refactor buffer reload function

 drivers/net/ethernet/microchip/lan966x/Kconfig     |   1 +
 drivers/net/ethernet/microchip/lan966x/Makefile    |   1 +
 .../net/ethernet/microchip/lan966x/lan966x_fdma.c  | 409 ++++++++-------------
 .../net/ethernet/microchip/lan966x/lan966x_main.h  |  58 +--
 4 files changed, 164 insertions(+), 305 deletions(-)
---
base-commit: ff09bc366fc45861b35dfeac97baadee16f65aec
change-id: 20240904-fdma-lan966x-04281c53952b

Best regards,
-- 
Daniel Machon <daniel.machon@microchip.com>


