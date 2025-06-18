Return-Path: <bpf+bounces-60908-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52918ADEB1D
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 14:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 703CC3A6DBC
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 12:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD212BEC59;
	Wed, 18 Jun 2025 12:00:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from glittertind.blackshift.org (glittertind.blackshift.org [116.203.23.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FB129DB64
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 12:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.23.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750248036; cv=none; b=UpT6oQeNZamaMce/lj/JTw5JDq1kzqp2nOUOvWgwpIkHlWFnzifTsrkxKSzw1nyPgrND3wRUzelvfvBcy5nELjWOExRjOayc/qj2oe23pIu1vDmVhqAhHnwEw21jkBR5C4JiUO+LVEbvZ0p8sUPH6cFhVr0KpHv6JBmtqpa51yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750248036; c=relaxed/simple;
	bh=t/4f5nuUbxzFdcEBj7jVj6v6n3Ix7JfteeIh/hfyXao=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gmew4ogPPL15QuJtux3oBmQwz2EUS+Of3dVUqN6ey1rRYSi4J7CZz6Gj8vbbDl4R/i6YH/XVEcwfi+6AYuK0NpIuPNJMKdMaHlGSNhkJfJlWfyrVaEL6J9On7SJvTqxPtodGfdJV4qxJXSG1R6pJAYhYbM9UAbAZeyXrptL9PM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=none smtp.mailfrom=hardanger.blackshift.org; arc=none smtp.client-ip=116.203.23.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=hardanger.blackshift.org
Received: from bjornoya.blackshift.org (unknown [IPv6:2003:e3:7f3d:bb00:d189:60c:9a01:7dca])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1)
	 client-signature RSA-PSS (4096 bits))
	(Client CN "bjornoya.blackshift.org", Issuer "R10" (verified OK))
	by glittertind.blackshift.org (Postfix) with ESMTPS id 349A566FC45
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 12:00:33 +0000 (UTC)
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id EBE9A42B55E
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 12:00:32 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id C551742B509;
	Wed, 18 Jun 2025 12:00:28 +0000 (UTC)
Received: from hardanger.blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id f07a9404;
	Wed, 18 Jun 2025 12:00:28 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next v4 00/11] net: fec: general + VLAN cleanups
Date: Wed, 18 Jun 2025 14:00:00 +0200
Message-Id: <20250618-fec-cleanups-v4-0-c16f9a1af124@pengutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAECqUmgC/23NSwqDMBgE4KtI1k3J00dXvUfpwiR/NFCiJCoW8
 e6NQqG1XQ7DfLOgCMFBRJdsQQEmF13nUxCnDOm29g1gZ1JGjDBBKiaxBY31A2o/9hHrSkkphNK
 lFChN+gDWzTt3Qx4G7GEe0D01rYtDF577z0T3fiMpofk3OVFMsIGi5MpQCXl97cE34xA67+azg
 V2b2FuQJKfsILAk1FBonhtLSwl/Bf4pFAeBb4IslFW8rCpuf4R1XV+xCZTgOwEAAA==
X-Change-ID: 20240925-fec-cleanups-c9b5544bc854
To: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
 Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: imx@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel@pengutronix.de, bpf@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, Frank Li <Frank.Li@nxp.com>, 
 Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=2690; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=t/4f5nuUbxzFdcEBj7jVj6v6n3Ix7JfteeIh/hfyXao=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBoUqpC4OL816a18bKO1PoTPmhMzrorI+cvgXj02
 n8tos7H/reJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaFKqQgAKCRAMdGXf+ZCR
 nDOSB/46PQgI1UykdceP18zoZkOLiUO5aKcEyOZ26+M7Jhedc7WNDSXISBWJz18BqQOoB3tCsZR
 PBc/hwPDCWP1iH4la1W8+nfsEkQQnljxbvwwg2QabGDJgl8Phzq6Er9htRCJCzyaDNCDXuGgM6a
 5scNevfOJvy+LIZlAngQ5Lb3g6zt1mNnd+qKJXB6+lu+eoxI98L1GFE/Ge7C5Jh/Rmc0OzApL+L
 SOR0bAElYba6zggas0qK7o7OYsfLqEthEtE7qIUPEBIyP83xn5GXJ/CWTNsLzWJHbbQPQUAHMjQ
 GDgTJFLUUSq350XhBwNNTjGbeotFMDTsAFMyvzCUBz4QWqu+
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

This series first cleans up the fec driver a bit (typos, obsolete
comments, add missing header files, rename struct, replace magic
number by defines).

The last 5 patches clean up the fec_enet_rx_queue() function,
including VLAN handling.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Changes in v4:
- 3: new patch to switch from asm/cacheflush.h to linux/cacheflush.h
- 4: new patch to alphabetically sort includes (thanks Alexander Lobakin)
- Link to v3: https://patch.msgid.link/20250617-fec-cleanups-v3-0-a57bfb38993f@pengutronix.de

Changes in v3:
- update cover letter and subject
- 1: fix another typo (thanks Bence Csókás)
- 7: clarify patch description (thanks Andrew Lunn)
- collected Wei Fang's, Bence Csókás's and Andrew Lunn's Reviewed-by
- Link to v2: https://patch.msgid.link/20250612-fec-cleanups-v2-0-ae7c36df185e@pengutronix.de

Changes in v2:
- removed patches 7, 8 for now
- rebased to recent net-next/main:
  dropped patch 6
- 2, 3: wrap patch description at 75 chars:
  (thanks Frank Li)
- 4, 5, 6, 7, 9: updated wording of patch description
  (thanks Frank Li)
- 10: move VLAN_header into the if statement (thanks Wei Fang)
- 10: mark several variables const
- collected Wei Fang's and Frank Li's Reviewed-by
- Link to v1: https://patch.msgid.link/20241016-fec-cleanups-v1-0-de783bd15e6a@pengutronix.de

---
Marc Kleine-Budde (11):
      net: fec: fix typos found by codespell
      net: fec: struct fec_enet_private: remove obsolete comment
      net: fec: switch from asm/cacheflush.h to linux/cacheflush.h
      net: fec: sort the includes by alphabetic order
      net: fec: rename struct fec_devinfo fec_imx6x_info -> fec_imx6sx_info
      net: fec: fec_restart(): introduce a define for FEC_ECR_SPEED
      net: fec: fec_enet_rx_queue(): use same signature as fec_enet_tx_queue()
      net: fec: fec_enet_rx_queue(): replace manual VLAN header calculation with skb_vlan_eth_hdr()
      net: fec: fec_enet_rx_queue(): reduce scope of data
      net: fec: fec_enet_rx_queue(): move_call to _vlan_hwaccel_put_tag()
      net: fec: fec_enet_rx_queue(): factor out VLAN handling into separate function fec_enet_rx_vlan()

 drivers/net/ethernet/freescale/fec.h         |  15 ++-
 drivers/net/ethernet/freescale/fec_main.c    | 137 +++++++++++++--------------
 drivers/net/ethernet/freescale/fec_mpc52xx.c |   2 +-
 drivers/net/ethernet/freescale/fec_ptp.c     |  42 ++++----
 4 files changed, 96 insertions(+), 100 deletions(-)
---
base-commit: 170e4e3944aa39accf64d869b27c187f8c08abc7
change-id: 20240925-fec-cleanups-c9b5544bc854

Best regards,
-- 
Marc Kleine-Budde <mkl@pengutronix.de>



