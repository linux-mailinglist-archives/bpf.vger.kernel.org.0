Return-Path: <bpf+bounces-48279-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BBEA06466
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 19:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B0783A4026
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 18:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8746C202C4E;
	Wed,  8 Jan 2025 18:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Qj4jTaUU"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F09E201256;
	Wed,  8 Jan 2025 18:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736361042; cv=none; b=sugYIBwZK1h5S2ZQS8Nc6yRmwCSRHduSliNDQ79IXjyjQJpbsfcvpO3Xvj6d3vMY0gcVJSlY4HkfbK0HfFcdIdlh+LnhY0OTZk2TF0UgYGI8yhXVKEE7uNZF5D8lVMiQ8dnl/OmaSsWqk81LCJftMuy5Ge5ishfdDaILGyugwKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736361042; c=relaxed/simple;
	bh=uOFpUTOI1C71zkkHFH2Hw3J9Z4OeD7nsT3ge0WLBhJM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qDi+t6ifUKswLDdzoMqBlT/X3tP05YJOw+WjJX/0h+THtM+uzp3NwDr/uei34O9nGqi1H5F8+RicF0o7qZ8K/hw/oYJZTlIK/8/s6i9o2WWXJDLYwzevUimlxJYvr1v81nT882zGPeguxOYmmbKL7rHqjd3i+FpTzxtTUfarI4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Qj4jTaUU; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508HduKn020996;
	Wed, 8 Jan 2025 10:30:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=lQk8noi7KT0SO/sCiOnpHXf
	NOlFwsQLIcBfY+VjQH2I=; b=Qj4jTaUUZoKfFVzZZgvHdCGmbjVpVYHXK6L5G9L
	DCfdekarOFc0cxGLMnAARn8flLNrsbQ0PPYtxJ14jGi933HqWWOiyMNI4lMrAcPO
	4xirZhv+YBuppl3ZluyYwfdCV2R52aDlxyJaapBurjy3ix1uvIjkgYxOU7wR3Av0
	UqZd8TLIX0gbYJhBg9/Td4wDB7oSjydPsvhUK8aMfksaybQ8PUM/DyljxfJr3Lc1
	0goV+k9kFWe2w0SVn+5GMUOCUSR0m1le4F6tkXM2Bd2uh2qKikC4nS9PaCULqpEa
	fpYBe1X7yqlkjY6kLwT8039pt75Cp9JkE1t0sF61OUoEhYQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 441wy9r3w0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 10:30:09 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 8 Jan 2025 10:30:08 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 8 Jan 2025 10:30:08 -0800
Received: from localhost.localdomain (unknown [10.28.36.166])
	by maili.marvell.com (Postfix) with ESMTP id D9C7B3F70A8;
	Wed,  8 Jan 2025 10:30:02 -0800 (PST)
From: Suman Ghosh <sumang@marvell.com>
To: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lcherian@marvell.com>,
        <jerinj@marvell.com>, <john.fastabend@gmail.com>,
        <bbhushan2@marvell.com>, <hawk@kernel.org>, <andrew+netdev@lunn.ch>,
        <ast@kernel.org>, <daniel@iogearbox.net>, <bpf@vger.kernel.org>
CC: Suman Ghosh <sumang@marvell.com>
Subject: [net-next PATCH v2 0/6] Add af_xdp support for cn10k
Date: Wed, 8 Jan 2025 23:59:53 +0530
Message-ID: <20250108182959.2207450-1-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: EFL-gwrB803eHterdmXFx2k0xS-ZotE6
X-Proofpoint-ORIG-GUID: EFL-gwrB803eHterdmXFx2k0xS-ZotE6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

This patchset includes changes to support AF_XDP for cn10k chipsets. Both
non-zero copy and zero copy will be supported after these changes. Also,
the RSS will be reconfigured once a particular receive queue is
added/removed to/from AF_XDP support.

Patch #1: octeontx2-pf: Add AF_XDP non-zero copy support

Patch #2: octeontx2-pf: Don't unmap page pool buffer used by XDP

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

Suman Ghosh (3):
  octeontx2-pf: Add AF_XDP non-zero copy support
  octeontx2-pf: Add AF_XDP zero copy receive support
  octeontx2-pf: Reconfigure RSS table after enabling AF_XDP zerocopy on
    rx queue

 .../ethernet/marvell/octeontx2/nic/Makefile   |   2 +-
 .../ethernet/marvell/octeontx2/nic/cn10k.c    |   6 +-
 .../marvell/octeontx2/nic/otx2_common.c       | 125 +++++++---
 .../marvell/octeontx2/nic/otx2_common.h       |  17 +-
 .../marvell/octeontx2/nic/otx2_ethtool.c      |   6 +-
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |  33 ++-
 .../marvell/octeontx2/nic/otx2_txrx.c         | 181 +++++++++++---
 .../marvell/octeontx2/nic/otx2_txrx.h         |   9 +
 .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |  12 +-
 .../ethernet/marvell/octeontx2/nic/otx2_xsk.c | 225 ++++++++++++++++++
 .../ethernet/marvell/octeontx2/nic/otx2_xsk.h |  24 ++
 .../ethernet/marvell/octeontx2/nic/qos_sq.c   |   2 +-
 12 files changed, 561 insertions(+), 81 deletions(-)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.h

-- 
2.25.1


