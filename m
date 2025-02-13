Return-Path: <bpf+bounces-51357-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB05A33743
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 06:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B06E73A6024
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 05:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7812066FE;
	Thu, 13 Feb 2025 05:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="YbckNyKi"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C491EA84;
	Thu, 13 Feb 2025 05:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739424748; cv=none; b=ZJd8ZbUsSexkKIJLWnVhmCK/dxahdQz6uTid9ZcteeaTBP47R6SzBtIzGgTYpPKrXsC+ZOe1V9euy8E2pJThg4YlpqR5ePH8jHX5HHhZ3o8uvoiv2ijP6nbxNE/qEFBI7kazDVO91WH6N9+s8N0C8luAitL5wQhD2rXSGYbA+9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739424748; c=relaxed/simple;
	bh=HBBqqi+x0G8qDpmtHU+9cA14OLmLrDmPMXDs7u256ZM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QYfIwHm7hvfve1PoaopgCUjEQRROKhilLJr/UlHzvkBY6V/v4TQOgyAUx16EMrCjgEtx3ihHb3qcsKaO/DIJlanWMHPc8l6zdT9uGfoftRXgXUbV1BEK3a5ZOy2mmOw7czf7r3IXw9SQy0FpBwV6Ei4Ye8n6MvL8KkPUsyh8wDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=YbckNyKi; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51D5OLNx023573;
	Wed, 12 Feb 2025 21:32:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=Wufsjz4xcZASzpC++jwn8Zg
	FIphgLQj/6xicRGnRsws=; b=YbckNyKi+EOH73IsSoOgPByYkqQmY5GpLioiAGF
	f6U5n2/rydqzZd0h0onfH3uzQDhE649O/r95qB//AIZnazWiA9sWLy5AaWEogWYY
	LyxAFl/x3q0+vKw+XNLMmscUywF70dUXSP/K/wv04+7bcJDlKkGSO6SsJoJh5Mfv
	zQhJISotPfp171TyJAcHcfboi12th7wYZ0JwWaaSzvd21AlLZ7xfqp+wJOPymb3C
	Ds/C5YbLjXWb2GfaSPH7hIuSaxOt+BzJEgbrFgGzekbyFMinOkHst6sLbYrFZD6M
	r3qsv2OeqzGfGTklqVukCMKzIU4zZffDry2mSk1cciVKuwA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44rw9g9pkh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 21:32:00 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 12 Feb 2025 21:31:50 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 12 Feb 2025 21:31:50 -0800
Received: from localhost.localdomain (unknown [10.28.36.166])
	by maili.marvell.com (Postfix) with ESMTP id 3573F3F7096;
	Wed, 12 Feb 2025 21:31:43 -0800 (PST)
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
Date: Thu, 13 Feb 2025 11:01:35 +0530
Message-ID: <20250213053141.2833254-1-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: liaVDsDQJT4A0gBD_FHPVwTi8wa88GTm
X-Proofpoint-ORIG-GUID: liaVDsDQJT4A0gBD_FHPVwTi8wa88GTm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_02,2025-02-11_01,2024-11-22_01

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


