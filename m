Return-Path: <bpf+bounces-49077-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C61EA14204
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 20:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D4F416AA5D
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 19:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9BE22FDF4;
	Thu, 16 Jan 2025 19:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="PZOYBG+w"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03CB1547E2;
	Thu, 16 Jan 2025 19:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737054720; cv=none; b=M8zmAg79NKmOWJ7wisfIGZMqSHDi4njz1ISyKri8aMwe1+M95CgGreXPDiRnr9Yoofc1xwgbHkddnyX4fJfGcfhWOhwi6ArqLLH7piNIbDuiWRK6BK7sZIWcm0ciP7VM+5O5t639I55fQCFBXTNPcTtL9h4I7FXj6QlSN3g3QDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737054720; c=relaxed/simple;
	bh=Eu5cnF1JduLc3kQde9BZUGpflVrfUoGrIcrRDwbbDtg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ScekfQeOtjiNWMI2p4kUVTj+mlv3gLCqZdN8MaETZuyPceXNL8U1zrF7TBF/dSdCTx+paA7xCzpkxBqXKxNoNGcpbXetWxZ93yoltCpbJR5i5nlBaC/0qS6my9GknETYOEV9KITdXUoTzkM8LjMo5lDPByrsbzTp9JYNI/dnQBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=PZOYBG+w; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50GFdhAU030715;
	Thu, 16 Jan 2025 11:11:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=P+UDXuftbBdTKRrlDUzQllR
	vTWLrrqnSr5XDjT3EWiM=; b=PZOYBG+wV6qWOpiWUkLyV0IVOwq7AyrWWXiKoHc
	y2jrvkkgh3o2rt3TMUNNk/4/IDg90XuwPDZxgWTAFFsqFX+d82/b+NRM2RcS0363
	G/Ex99kz/WZIs2QfCTQfK/OO7LP64XqN96AXLYukVVrYGomUz3kuEmTfgOxGG8kz
	WeQH6dwpoTcAwadOReQptd6/nTdE8CZpFv2cLFApC6stf1bI470UQjHJpgJEPXUf
	AioAr9R8Gx1N7VbS/uDN1Uys3kkaPSdNkSB1Y8EEuGcUTJXZs4KNLjzsOgGC0bp6
	Jbf0JMaW3dWKxv7wIJ2NerP207oYAKfUeYeJo0Rl2l1NZPg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4474xvrg7c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 11:11:25 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 16 Jan 2025 11:11:24 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 16 Jan 2025 11:11:24 -0800
Received: from localhost.localdomain (unknown [10.28.36.166])
	by maili.marvell.com (Postfix) with ESMTP id 1B1DD3F7088;
	Thu, 16 Jan 2025 11:11:18 -0800 (PST)
From: Suman Ghosh <sumang@marvell.com>
To: <horms@kernel.org>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lcherian@marvell.com>, <jerinj@marvell.com>,
        <john.fastabend@gmail.com>, <bbhushan2@marvell.com>, <hawk@kernel.org>,
        <andrew+netdev@lunn.ch>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <bpf@vger.kernel.org>
CC: Suman Ghosh <sumang@marvell.com>
Subject: [net-next PATCH v4 0/6] Add af_xdp support for cn10k
Date: Fri, 17 Jan 2025 00:41:10 +0530
Message-ID: <20250116191116.3357181-1-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 7WkqeT7bV7L33b6yRfRqDRWrbb98-AJf
X-Proofpoint-GUID: 7WkqeT7bV7L33b6yRfRqDRWrbb98-AJf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_08,2025-01-16_01,2024-11-22_01

This patchset includes changes to support AF_XDP for cn10k chipsets. Both
non-zero copy and zero copy will be supported after these changes. Also,
the RSS will be reconfigured once a particular receive queue is
added/removed to/from AF_XDP support.

Patch #1: octeontx2-pf: Don't unmap page pool buffer used by XDP

Patch #2: octeontx2-pf: Add AF_XDP non-zero copy support

Patch #3: octeontx2-pf: AF_XDP zero copy receive support

Patch #4: octeontx2-pf: Reconfigure RSS table after enabling AF_XDP
zerocopy on rx queue

Patch #5: octeontx2-pf: Prepare for AF_XDP transmit

Patch #6: octeontx2-pf: AF_XDP zero copy transmit support

Geetha sowjanya (1):
  octeontx2-pf: Don't unmap page pool buffer used by XDP

Hariprasad Kelam (2):
  octeontx2-pf: Prepare for AF_XDP
  octeontx2-pf: AF_XDP zero copy transmit support

Suman Ghosh (6):
  octeontx2-pf: Add AF_XDP non-zero copy support
  octeontx2-pf: AF_XDP zero copy receive support
  octeontx2-pf: Reconfigure RSS table after enabling AF_XDP zerocopy on
    rx queue

v4 changes:
- Addressed minor comments from Paolo regarding adding fixes tag in patch#2
  and removed one unnecessary NULL check from patch#3

v3 changes:
- Rearrenged patch ordering to fix individual patch compilation issue
- Fixed un-initialized variable declaration and reverse x-mas tree issue
  pointed by Simon

v2 changes:
- Addressed minor review comments from Simon regrading smatch warnings

 .../ethernet/marvell/octeontx2/nic/Makefile   |   2 +-
 .../ethernet/marvell/octeontx2/nic/cn10k.c    |   6 +-
 .../marvell/octeontx2/nic/otx2_common.c       | 120 ++++++++--
 .../marvell/octeontx2/nic/otx2_common.h       |  17 +-
 .../marvell/octeontx2/nic/otx2_ethtool.c      |   6 +-
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |  33 ++-
 .../marvell/octeontx2/nic/otx2_txrx.c         | 183 +++++++++++---
 .../marvell/octeontx2/nic/otx2_txrx.h         |   9 +
 .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |  12 +-
 .../ethernet/marvell/octeontx2/nic/otx2_xsk.c | 225 ++++++++++++++++++
 .../ethernet/marvell/octeontx2/nic/otx2_xsk.h |  24 ++
 .../ethernet/marvell/octeontx2/nic/qos_sq.c   |   2 +-
 12 files changed, 558 insertions(+), 81 deletions(-)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.h

-- 
2.25.1


