Return-Path: <bpf+bounces-48536-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0353A08C53
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 10:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9492162780
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 09:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FAF209F4D;
	Fri, 10 Jan 2025 09:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="fsREf/6z"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4A31E3761;
	Fri, 10 Jan 2025 09:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736501919; cv=none; b=FZApvWmrQhnbmeoI8xoqq+6TSUWKTob4Vn8n0vEENfiUxUQaeAfV4jZMzubdl91uD4HeUO1UzLJoaoGr2VA27VCUhY6VKy813yYcNnXQMOu6+TRLJsSPw//GK3QS/xSmde1GK7/Y1F6Xa+Fe0ko51QpNdwT+kH1xfhRRtXgOezk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736501919; c=relaxed/simple;
	bh=ZTcCtMHsnVdGEzFJmuWQKCSxIQgUYyk61zPoioPTEDU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rEbUmdkFmN6L1UwY0oJCfJuSplWBPwG2ukFn+W29r+Hvhq9I0jtregBQVrneZesTbGTWOHlj1/StNRkQKGPZwsR4qhKZLQq//jAoFRN4bW/1Em6qVx9CXmhOfH+dUsiT/IGqPYJzoXo2yKIOY9uNXygHqNUt2utgf+3Nxw2+2rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=fsREf/6z; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50A9bRpx005808;
	Fri, 10 Jan 2025 01:38:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=BUUdAjW1kzBw/yHLlfywf7y
	2XtKtJGS6J9Eyy3aw2pA=; b=fsREf/6zNfDq/EZEivP/Fgf0XaWobRyBR1gbtqQ
	c69p6ac13GSahh55jEMfV/hHalwRhJCPEH9YU9tlP9vzNQ8yk0maWtB26gf4/iQ7
	0kAqtwFiFW1Fg49EXdEc81DD8yCcX90u4AZjcDw1XdtXuJtJ3GgYSIGndLHxrqpg
	6cUAPmX8VWBcNKx75yEXOvb9lVU2SZLVpMzjiZ720vp3xj8hMK14I6P426wi5HOP
	firq8w+7ogaUd0h9a6ZxIXyTtDqxQq3e32ZmwOrIsU/L0UFa63EAz5AVE/0GWqJx
	3OCIVapZiGxDfkSmZvDFHBOkVw2wTm8PEJbGeTD2XxpGVzQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44312qg02r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 01:38:17 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 10 Jan 2025 01:38:16 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 10 Jan 2025 01:38:16 -0800
Received: from localhost.localdomain (unknown [10.28.36.166])
	by maili.marvell.com (Postfix) with ESMTP id 202A53F7084;
	Fri, 10 Jan 2025 01:38:09 -0800 (PST)
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
Subject: [net-next PATCH v3 0/6] Add af_xdp support for cn10k
Date: Fri, 10 Jan 2025 15:08:01 +0530
Message-ID: <20250110093807.2451954-1-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 7JB0I4WVoxQ-Q8zhyZIeMVldL-fLhLnj
X-Proofpoint-GUID: 7JB0I4WVoxQ-Q8zhyZIeMVldL-fLhLnj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

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
  Octeontx2-pf: Prepare for AF_XDP
  octeontx2-pf: AF_XDP zero copy transmit support

Suman Ghosh (6):
  octeontx2-pf: Add AF_XDP non-zero copy support
  octeontx2-pf: AF_XDP zero copy receive support
  octeontx2-pf: Reconfigure RSS table after enabling AF_XDP zerocopy on
    rx queue

v3 changes:
- Rearrenged patch ordering to fix individual patch compilation issue
- Fixed un-initialized variable declaration and reverse x-mas tree issue
  pointer by Simon

v2 changes:
- Addressed minor review comments from Simon regrading smatch warnings

 .../ethernet/marvell/octeontx2/nic/Makefile   |   2 +-
 .../ethernet/marvell/octeontx2/nic/cn10k.c    |   6 +-
 .../marvell/octeontx2/nic/otx2_common.c       | 125 +++++++---
 .../marvell/octeontx2/nic/otx2_common.h       |  17 +-
 .../marvell/octeontx2/nic/otx2_ethtool.c      |   6 +-
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |  33 ++-
 .../marvell/octeontx2/nic/otx2_txrx.c         | 183 +++++++++++---
 .../marvell/octeontx2/nic/otx2_txrx.h         |   9 +
 .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |  12 +-
 .../ethernet/marvell/octeontx2/nic/otx2_xsk.c | 225 ++++++++++++++++++
 .../ethernet/marvell/octeontx2/nic/otx2_xsk.h |  24 ++
 .../ethernet/marvell/octeontx2/nic/qos_sq.c   |   2 +-
 12 files changed, 562 insertions(+), 82 deletions(-)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.h

-- 
2.25.1


