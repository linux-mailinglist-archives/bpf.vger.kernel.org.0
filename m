Return-Path: <bpf+bounces-50625-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1CAA2A390
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 09:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E3EB3A522B
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 08:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D784A225790;
	Thu,  6 Feb 2025 08:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="gXq+X1H/"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F66214231;
	Thu,  6 Feb 2025 08:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738831882; cv=none; b=tGIVh5Cwm6+2mXL7bDy5sT9WDcd4TFTW06G/6urKMFKsN0aLWSmu1I+HeIoS43hQDWvQ3P/Kpyn/O19cuVSZqYsSMjy20amn/HVYct0MjSKLhlUJ/5WAvkECUzYdE3K3D8Nu2qMzrVbBXg+0wkZpbRWul1Q8l47HGpzqhQCMQ0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738831882; c=relaxed/simple;
	bh=JKCmw5pDaLAFqBhIlO6NyYAjW5GUiLAiShjZy0hyb+k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m+dS2OUN4AIcY9hT3uqavOD+++ThIu3RkocN47GqZY85RFdfdiachNjle1IA2ANZS6n90k2sxrt/WhS0Mqz8Fr4hYXo2fXG91AmDcPsw0GnjQzwa70QNFUzBLCJzmFnQRnTewc1oNYEDmBRvzs2Suc0O0v8sfL0+NQqxyRFZfU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=gXq+X1H/; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5167MNjC015382;
	Thu, 6 Feb 2025 00:50:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=CNVx3hFwqLKCf979AeskNWg
	5bSvnmcY54EumXWb1M/o=; b=gXq+X1H/JjJsL54LSNoSa2dobN9W35Txcia+h5R
	aCyX9t+lwNEGdEUswczd/+Vu7lENQf07kYU4zWm0K/o/02xzn8MuZ87G770kjY53
	k3Y67xpiqE6a09qEOLqvGW1OQYwjpUWL63dxzCN0zJ1tQJpxnYhdBS5R3tE/Jrp7
	+JmcWoOPHmFnMy3uthHzOO6e5ql0TnGZ+rAAeCI5KMhQg/2PMxn1ILBaR+S79RP3
	NI8BK1IJ3ct9BrJZiUiIfqWvUNh39homQ2ewrtd4jC9nO4l2fFmhzXZZyD+iyS4Y
	nlt5MD8dFtgEhRQRb8WoSc1x1b9m+ro9AMMmkXUyoFCLduw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44mrmsg52d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Feb 2025 00:50:44 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 6 Feb 2025 00:50:43 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 6 Feb 2025 00:50:42 -0800
Received: from localhost.localdomain (unknown [10.28.36.166])
	by maili.marvell.com (Postfix) with ESMTP id C9EBE3F705F;
	Thu,  6 Feb 2025 00:50:36 -0800 (PST)
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
Subject: [net-next PATCH v5 0/6] Add af_xdp support for cn10k
Date: Thu, 6 Feb 2025 14:20:28 +0530
Message-ID: <20250206085034.1978172-1-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 4ShNTj4w1nIx8zwGzM8JsMFX7eFQWgCv
X-Proofpoint-ORIG-GUID: 4ShNTj4w1nIx8zwGzM8JsMFX7eFQWgCv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_02,2025-02-05_03,2024-11-22_01

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
 .../ethernet/marvell/octeontx2/nic/cn10k.c    |   6 +-
 .../marvell/octeontx2/nic/otx2_common.c       | 120 ++++++++--
 .../marvell/octeontx2/nic/otx2_common.h       |  17 +-
 .../marvell/octeontx2/nic/otx2_ethtool.c      |   6 +-
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |  32 +--
 .../marvell/octeontx2/nic/otx2_txrx.c         | 191 +++++++++++----
 .../marvell/octeontx2/nic/otx2_txrx.h         |   9 +
 .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |  12 +-
 .../ethernet/marvell/octeontx2/nic/otx2_xsk.c | 226 ++++++++++++++++++
 .../ethernet/marvell/octeontx2/nic/otx2_xsk.h |  24 ++
 .../ethernet/marvell/octeontx2/nic/qos_sq.c   |   2 +-
 12 files changed, 557 insertions(+), 90 deletions(-)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.h

-- 
2.25.1


