Return-Path: <bpf+bounces-36251-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B959456A2
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 05:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63AF71F245C0
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 03:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3211EB4BC;
	Fri,  2 Aug 2024 03:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="p5XI9A4t"
X-Original-To: bpf@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (saphodev.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5D51862;
	Fri,  2 Aug 2024 03:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722569054; cv=none; b=TCfH59nNR3DRwJCOnsGtduqo5x/BPsB3BOr1iV/1KMx3AL6K+qSgrJx8hn9Y55NIFdA7MNTykNtOLk84Bh0BRWLSicaIRj/tbfqetG2dVmMyt7/mKMmbam6ip9S1MHVnx3V0AKfurmyDhQ24jJcDniTobu1mK9r1+pPhSXNvucg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722569054; c=relaxed/simple;
	bh=RHWM2CtWUWVpihcZvDeOFBZpR66cVXr5m/EFPtj1ocI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BcBXFw3snGwl4lDVbrMddSGreN65YzaqWzkVjqUUBwZSTpkMDhcN9UzH1C6LUatVm/W/OEq/RppgzdIYxmighdKNwUV7/TqXhJL+k3jYWDzVUfOW5Cg7iJ357A1VDYXg2ySxjdCYYfltjvjN/M1TnsRVXf3DdkraT/BKx87d1ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=p5XI9A4t; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 7D02FC0000EA;
	Thu,  1 Aug 2024 20:18:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 7D02FC0000EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1722568706;
	bh=RHWM2CtWUWVpihcZvDeOFBZpR66cVXr5m/EFPtj1ocI=;
	h=From:To:Cc:Subject:Date:From;
	b=p5XI9A4tDoBDbHQDvwqF34I/x9A+ZZBWs+kpJh7RsS/14I9UtKeEkAngT+/RNnOyX
	 zB77CnkwlJb7en35uxL7jbP1X1c35mvebKaDuN3W8KkYXiP4V5ESvn7XER7GVFbRXg
	 kC8VH9skX73xMPz7J1Rjvux+b/3FMSVtHUUXGdr0=
Received: from pcie-dev03.dhcp.broadcom.net (pcie-dev03.dhcp.broadcom.net [10.59.171.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id AF53118041CAC4;
	Thu,  1 Aug 2024 20:18:23 -0700 (PDT)
From: jitendra.vegiraju@broadcom.com
To: netdev@vger.kernel.org
Cc: alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	jitendra.vegiraju@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	richardcochran@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	bpf@vger.kernel.org,
	andrew@lunn.ch,
	linux@armlinux.org.uk,
	horms@kernel.org,
	florian.fainelli@broadcom.com
Subject: [PATCH net-next v3 0/3] net: stmmac: Add PCI driver support for BCM8958x
Date: Thu,  1 Aug 2024 20:18:19 -0700
Message-Id: <20240802031822.1862030-1-jitendra.vegiraju@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>

This patchset adds basic PCI ethernet device driver support for Broadcom
BCM8958x Automotive Ethernet switch SoC devices.

This SoC device has PCIe ethernet MAC attached to an integrated ethernet
switch using XGMII interface. The PCIe ethernet controller is presented to
the Linux host as PCI network device.

The following block diagram gives an overview of the application.
             +=================================+
             |       Host CPU/Linux            |
             +=================================+
                        || PCIe
                        ||
        +==========================================+
        |           +--------------+               |
        |           | PCIE Endpoint|               |
        |           | Ethernet     |               |
        |           | Controller   |               |
        |           |   DMA        |               |
        |           +--------------+               |
        |           |   MAC        |   BCM8958X    |
        |           +--------------+   SoC         |
        |               || XGMII                   |
        |               ||                         |
        |           +--------------+               |
        |           | Ethernet     |               |
        |           | switch       |               |
        |           +--------------+               |
        |             || || || ||                  |
        +==========================================+
                      || || || || More external interfaces

The MAC block on BCM8958x is based on Synopsis XGMAC 4.00a core. This
driver uses common dwxgmac2 code where applicable.
Driver functionality specific to this MAC is implemented in dwxgmac4.c.
Management of integrated ethernet switch on this SoC is not handled by
the PCIe interface.
This SoC device has PCIe ethernet MAC directly attached to an integrated
ethernet switch using XGMII interface.

v2->v3:
   Addressed v2 comments from Andrew, Jakub, Russel and Simon.
   Based on suggestion by Russel and Andrew, added software node to create
   phylink in fixed-link mode.
   Moved dwxgmac4 specific functions to new files dwxgmac4.c and dwxgmac4.h
   in stmmac core module.
   Reorganized the code to use the existing glue logic support for xgmac in
   hwif.c and override ops functions for dwxgmac4 specific functions.
   The patch is split into three parts.
     Patch#1 Adds dma_ops for dwxgmac4 in stmmac core
     Patch#2 Hooks in the hardware interface handling for dwxgmac4
     Patch#3 Adds PCI driver for BCM8958x device

v1->v2:
   Minor fixes to address coding style issues.
   Sent v2 too soon by mistake, without waiting for review comments.
   Received feedback on this version.
   https://lore.kernel.org/netdev/20240511015924.41457-1-jitendra.vegiraju@broadcom.com/

v1:  
   https://lore.kernel.org/netdev/20240510000331.154486-1-jitendra.vegiraju@broadcom.com/

Jitendra Vegiraju (3):
  Add basic dwxgmac4 support to stmmac core
  Integrate dwxgmac4 into stmmac hwif handling
  Add PCI driver support for BCM8958x

 MAINTAINERS                                   |   8 +
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 +
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   3 +-
 drivers/net/ethernet/stmicro/stmmac/common.h  |   4 +
 .../net/ethernet/stmicro/stmmac/dwmac-brcm.c  | 517 ++++++++++++++++++
 .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    |  31 ++
 .../net/ethernet/stmicro/stmmac/dwxgmac4.c    | 142 +++++
 .../net/ethernet/stmicro/stmmac/dwxgmac4.h    |  84 +++
 drivers/net/ethernet/stmicro/stmmac/hwif.c    |  26 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |   1 +
 10 files changed, 825 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-brcm.c
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwxgmac4.c
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwxgmac4.h

-- 
2.34.1


