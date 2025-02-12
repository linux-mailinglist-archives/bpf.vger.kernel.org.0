Return-Path: <bpf+bounces-51296-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AC3A32F8F
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 20:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74B1416746E
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 19:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7C82627FD;
	Wed, 12 Feb 2025 19:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="TuOGU+hS"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CB61DEFDD;
	Wed, 12 Feb 2025 19:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739388330; cv=none; b=oqizEWcVfM5pGLXHV4Hiz7A8LlkyT19TDuYKI3t5CycZHG53S1zTO2fQzPym24RXRVnaqi6kxPsvxV0D6BwDYt6Czugtlw5SGmNYKsAXSP1dEh+0aHyM1b3Ucn10Pyf5QafYgGpwaUSnvz05B5acw1nfQB6HbTyeSx9NuBNn+Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739388330; c=relaxed/simple;
	bh=HBBqqi+x0G8qDpmtHU+9cA14OLmLrDmPMXDs7u256ZM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZO+4J8kS6CModUcTwK9V4wf04Dsa32kTSIynA4SUPcOuoDdfg3tdIqoOD43i4H7FSiaTq8JF9l9rZWIXwwHKsenFcHUgbYbleamUawD2KkXN/tA092sQPoQQOUUqGMLRbB/8x9CbWRRW8bTfLnP8Rst3nHPsVndp6u+4b08anJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=TuOGU+hS; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51C9hFbv026890;
	Wed, 12 Feb 2025 11:25:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=Wufsjz4xcZASzpC++jwn8Zg
	FIphgLQj/6xicRGnRsws=; b=TuOGU+hSoXt2d1JkBG0/3Rd3yPNae2D1+/neiMo
	rBCmkv9BfCNNmYfR1fzJCae4/ApzPeD7gvURubpgekABS1L8sT5P7cinOaSgNHx4
	n3z0Rbdsh9jlHhQZDSAUx538yRaMRXaIe2PA/owbNyxTmN50EkdnDgn6r53ifegQ
	3g+Wb5RrOj7Pu+c+voqtM7Y+enmPEXA0QXLrpihIEi1tDvmXO0hRFC7Mja2PDTFq
	t24PBLwfL05eMjBjy5cigINp5dXZoPQEeKeRFRObwJRnXSqyoigNqgqVnYLEGOn1
	grcc0k9Ps+Pny9eVu2+AfQV9GcnYMHW/ZXDpW5TFTdp2Q+A==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44rs80s6pw-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 11:25:06 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 12 Feb 2025 11:25:04 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 12 Feb 2025 11:25:04 -0800
Received: from localhost.localdomain (unknown [10.28.36.166])
	by maili.marvell.com (Postfix) with ESMTP id 978603F7043;
	Wed, 12 Feb 2025 11:24:58 -0800 (PST)
From: Suman Ghosh <sumang@marvell.com>
To: <horms@kernel.org>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lcherian@marvell.com>, <jerinj@marvell.com>,
        <john.fastabend@gmail.com>, <bbhushan2@marvell.com>, <hawk@kernel.org>,
        <andrew+netdev@lunn.ch>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <bpf@vger.kernel.org>, <larysa.zaremba@intel.com>
CC: Suman Ghosh <sumang@marvell.com>
Subject: [net-next PATCH v6 0/6] Add af_xdp support for cn10k
Date: Thu, 13 Feb 2025 00:54:50 +0530
Message-ID: <20250212192456.2771997-1-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Rinfm1qGTwGETJh9yn1X50WAG7h-QOC4
X-Proofpoint-ORIG-GUID: Rinfm1qGTwGETJh9yn1X50WAG7h-QOC4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_06,2025-02-11_01,2024-11-22_01

This patchset includes changes to support AF_XDP for cn10k chipsets. Both
non-zero copy and zero copy will be supported after these changes. Also,
the RSS will be reconfigured once a particular receive queue is
added/removed to/from AF_XDP support.

Patch #1: octeontx2-pf: use xdp_return_frame() to free xdp buffers

Patch #2: octeontx2-pf: Add AF_XDP non-zero copy support

Patch #3: octeontx2-pf: AF_XDP zero copy receive support

Patch #4: octeontx2-pf: Reconfigure RSS table after enabling AF_XDP
zerocopy on rx queue

Patch #5: octeontx2-pf: Prepare for AF_XDP transmit

Patch #6: octeontx2-pf: AF_XDP zero copy transmit support

Geetha sowjanya (1):
  octeontx2-pf: use xdp_return_frame() to free xdp buffers

Hariprasad Kelam (2):
  octeontx2-pf: Prepare for AF_XDP
  octeontx2-pf: AF_XDP zero copy transmit support

Suman Ghosh (3):
  octeontx2-pf: Add AF_XDP non-zero copy support
  octeontx2-pf: AF_XDP zero copy receive support
  octeontx2-pf: Reconfigure RSS table after enabling AF_XDP zerocopy on
    rx queue

v6 changes:
- Updated patch #1,#3,#5 and #6 to address review comments
  from Simon for some code re-arrangement

v5 changes:
- Updated patch #1 to use xdp_return_frame 
- Updated patch #6 to use xdp_return_frame

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
 .../ethernet/marvell/octeontx2/nic/cn10k.c    |   7 +-
 .../marvell/octeontx2/nic/otx2_common.c       | 122 +++++++---
 .../marvell/octeontx2/nic/otx2_common.h       |  17 +-
 .../marvell/octeontx2/nic/otx2_ethtool.c      |   6 +-
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |  32 +--
 .../marvell/octeontx2/nic/otx2_txrx.c         | 188 +++++++++++----
 .../marvell/octeontx2/nic/otx2_txrx.h         |   9 +
 .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |  12 +-
 .../ethernet/marvell/octeontx2/nic/otx2_xsk.c | 225 ++++++++++++++++++
 .../ethernet/marvell/octeontx2/nic/otx2_xsk.h |  24 ++
 .../ethernet/marvell/octeontx2/nic/qos_sq.c   |   2 +-
 12 files changed, 554 insertions(+), 92 deletions(-)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.h

-- 
2.25.1


