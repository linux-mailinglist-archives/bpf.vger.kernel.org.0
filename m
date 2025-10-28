Return-Path: <bpf+bounces-72643-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B71E7C173E4
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 23:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3E5FC356705
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 22:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BE836A5E1;
	Tue, 28 Oct 2025 22:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="o+gXM3DQ"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646F43557FE
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 22:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761692175; cv=none; b=QB+RwoQkTVWlQ6yvAU2jZo65aZCsE3H/NsgMd8atEsytJ6FlJERprKB0b+a5QjG3lxdq+pF+5PxLwah8QoC3MH4qwmXfilVHPD5NOf6oew+m8O0tZ0SODvkMYuW3QJ7BhgEBv00wvycCJ8+ZNVgqwMLn847MD/Qhbo8EHbVecUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761692175; c=relaxed/simple;
	bh=RLoNYxGc/OMWUoC2F6HqL5IAZ8tTYBOrKBUTKviKabc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m/5TbfkJKb42nHrBb2tvtaYfgIbLbnH+y9s6RZ9ib+PJd4BQ59XPEL7bHrEjR3h070pHAftjluhEqSYypoP/FNWpQlpYAUMAiNntwPt7VwNhamL1SqeJJRVfM7zdD1LQhwSywqDpPjXKAkyaN1oCYxB0vnnurXKiqe6U9RfCg3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=o+gXM3DQ; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59SMCh2S030726;
	Tue, 28 Oct 2025 22:55:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=LQPBqQs3EwuuA+aAGSJeBpPp1MKPQ
	BpcA+VXt/BJCY4=; b=o+gXM3DQoDfTNXXnANWDwxtKVjt3t36Jz6bkWm6poXusi
	G0kZtFraNjEuydYKY3kFuWXfm7f9ylRE9yuB6RhsNt3y9y3/Sk9LJ0FM/t4YBzNV
	W0/auc1PNW37UVUirXd+Iu+2TJYg83SBgk52qe48CKqLP6M2y79CF9VBqHFSTgOc
	UVpyIxf0RF42a7pU5z3TRK9lptOqSbiVspgVmaOKE8DSyotHc0UA3jwMTboCJ2Sn
	OZnZVk4aqePBawFiR/6mLbOaRfZeDrRNZ4dOflmT8LKmag6FiMO0AYFVI9Vi+IMR
	Wl6D6up/CxKZrv9mk/o24s/0O57/OP05wVn6rpnvQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a33vygbc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 22:55:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59SLWYdL011644;
	Tue, 28 Oct 2025 22:55:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a33vwek5g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 22:55:49 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59SMpl5s001957;
	Tue, 28 Oct 2025 22:55:48 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-54-249.vpn.oracle.com [10.154.54.249])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a33vwek50-1;
	Tue, 28 Oct 2025 22:55:48 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org
Cc: eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, acme@kernel.org, ttreyer@meta.com,
        yonghong.song@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, ihor.solodrai@linux.dev, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 bpf-next 0/2] Multi-split BTF fixes and test
Date: Tue, 28 Oct 2025 22:55:42 +0000
Message-ID: <20251028225544.1312356-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510280194
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2MiBTYWx0ZWRfX19tXLoUqVP4m
 z3vvxgWs7VgtE2uITbT5NfIx5rXNSNBHyhgtwNrBQQPW1N1siO5hAgLg2dAEWsQOeD/POVofLL/
 xm6X6wBUSSXDKmrDXQr+v5Pdty8hofKnpDCSiayMIj5ebxzUZsEDVTWCP1yr6kPL0yeM2XTkQM1
 tlKtVI3yjkbF3Ut7uaHCbDqmtOkKqygZAGRwy6RCSkj3dfoQmEfrTGq88qgTQHKmjxf2Nw++kpT
 6+YKuaX2vAdi5QJRJjbuEYmidlSN2VU1fduzGlufzksRSUQgEVdWciI1wul1Wx62tMZ3BEjW7zW
 rFq70SvY+P5FhBX6XBj6GKSHi5gU/oNcs3iR4mm0CaT7oX0HCjC0I6/Gr68fbmsTTzXf4HWt0Q8
 o+meqpRSTwqanJ61VS3cyJ+sFptC0w==
X-Proofpoint-ORIG-GUID: rDxyCXZrwfBt1sMTGcXu7dLnSePimrBM
X-Authority-Analysis: v=2.4 cv=M8xA6iws c=1 sm=1 tr=0 ts=690149f5 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=yiKXGxLub-E0OzASjs4A:9
X-Proofpoint-GUID: rDxyCXZrwfBt1sMTGcXu7dLnSePimrBM

This small series consists of a fix to multi-split BTF parsing
(patch 1) and a test which exercises (multi-)split BTF parsing
(patch 2).

Changes since v2 [1]

- fix Fixes: tag formatting (Andrii, patch 1)
- BPF code-review bot saw we were doing ASSERT_OK_PTR() on wrong
  BTF (not multisplit) in patch 2
- ensure cleanup is correctly handled for BTF, unlink in split
  tests (Andrii, patch 2)

Changes since v1 [2]

- BPF code-review bot spotted another place that the string offset
needed to be adjusted based upon base start string offset + header
string offset.
- added selftests to extend split BTF testing to parsing

[1] https://lore.kernel.org/bpf/20251028155709.1265445-1-alan.maguire@oracle.com/
[2] https://lore.kernel.org/bpf/20251023142812.258870-1-alan.maguire@oracle.com/

Alan Maguire (2):
  libbpf: Fix parsing of multi-split BTF
  selftests/bpf: Test parsing of (multi-)split BTF

 tools/lib/bpf/btf.c                           |  4 +-
 .../selftests/bpf/prog_tests/btf_split.c      | 80 ++++++++++++++++++-
 2 files changed, 80 insertions(+), 4 deletions(-)

-- 
2.39.3


