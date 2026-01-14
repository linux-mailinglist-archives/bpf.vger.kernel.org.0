Return-Path: <bpf+bounces-78952-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C01B9D20DB8
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 19:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB849300528C
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 18:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE6A2BE02A;
	Wed, 14 Jan 2026 18:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nPiPpwVp"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C713331233
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 18:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768415937; cv=none; b=sHCDQMC7mKz+Gc3Ra4FVgYsN1wOnIuaPWx+9PQIlvLdqi/7Q/tFjX3KvXUIaKpcEy88Hm4QuM34oNzXgdmnwMCTXVpPQWIrOqsiHicUWdnDI0cqyEjAPeom60FmT27OU6NCkZd4dyv9k7Nk4cEMVAvYK0P7UodciMelnTVJ0RWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768415937; c=relaxed/simple;
	bh=ynBr0rbq0IRITvB5O7mDnc8A+PzSQVKdDCmzv/H6PSs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iKPZ6GhcL8W6C+Ty8vxuxoWEOeOAtKtiqeGXXFIo5BbEmWemYn/sEN3HtDd1y/IfB1YdG6hmbpSGUb2uJFPlWCeh18Mw7eVLTyj/dR5tsYYSQZ30Ue/P3xNERufevYDEGTTLDjR8IjA7vroJ3czzUmS3WM2OyZkFabdoorukTHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nPiPpwVp; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60EHjHr31940074;
	Wed, 14 Jan 2026 18:38:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=2NQJATLWzzGc9g1o/cxelyWZKnqAA
	b8iC14Du9zY+14=; b=nPiPpwVpfp2RFjBpkxqzhCP3L6ow/jjCf/EsTFyVgYWKA
	Dp/BVCgxmHi+wyceB08JS7HkUkXPCMSECNvhXxyoWs1p0F19sx4wcgSjjEUYkeZj
	a2p/2UgGoNpNWQPdTPkC7+1rDJZ9FGhIzZ5yVmXG3MOsArqxfBpjNkvNMkfzgvDj
	EYahTwk7ENR/yJH08Ps68oSVNdvs+uk+mu6FLPAPlmUGfBkKKa9TXUrpRz3q2Mkq
	OLJB4MgcpcU/q7WIlbcT/D3S+1k1que9OC9W6NsTGdNqSDgbeGFzinLE/7xgq3q2
	XMG488E4RtbrdIWBcjF0afCDg0IyDUQIpMFWZcP6Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bp5p391y8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Jan 2026 18:38:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60EGmxQP001933;
	Wed, 14 Jan 2026 18:38:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7acdg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Jan 2026 18:38:23 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60EIcNUD016071;
	Wed, 14 Jan 2026 18:38:23 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-50-147.vpn.oracle.com [10.154.50.147])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4bkd7acd9y-1;
	Wed, 14 Jan 2026 18:38:22 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, yonghong.song@linux.dev
Cc: nilay@linux.ibm.com, ast@kernel.org, jolsa@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, bvanassche@acm.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf v2 0/2] libbpf: handle modifiers in dedup equivalence
Date: Wed, 14 Jan 2026 18:38:06 +0000
Message-ID: <20260114183808.2946395-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_05,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601140155
X-Authority-Analysis: v=2.4 cv=OJUqHCaB c=1 sm=1 tr=0 ts=6967e2a0 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=yPCof4ZbAAAA:8 a=xROlNGpojHQRmVdD6oAA:9
X-Proofpoint-ORIG-GUID: bAVZImV6uKR3IFnuqUd7nQVgqwUVScws
X-Proofpoint-GUID: bAVZImV6uKR3IFnuqUd7nQVgqwUVScws
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDE1NCBTYWx0ZWRfX5hfzm+z7BWpk
 lRSpKEIzAn1ZAGaxM/XdEBHtOYSLJzF2I3KRFT/7hPJGJbIP28ycdlI2J6n18Abmh3FyjpSi0Iw
 ki3f/DZ70RbDC9Cvl9NV2sLkbl3xL5IPQvk28rK9PgEQjgYm3i/fUros2f2dZGMoGCei1YSaCy5
 Nha+HFFkEMqFsfI2hMIF0lpINKDnJmFdNroLZdantCRV/WLCmuaTsnfFLneK135WZRROmWtDQZl
 HBsBZRRHwv8CuFbLEh8LRiuyM2fRJVLlajpI1ptxmrz4T8cATGcL1CiK6Rec6ORh/fvVvVqGf0F
 Y4IxdmKCd3V/mJHmYrZv7DKFe7UawKKoU8ZxJbNdZLTYbeFjHKbFNh/lVJWTfG6c/tWRbpFFuty
 8sL3vVv1Ve+JhArk5Jwh9SRB5Em2omvSHiCJgNwywgsInTQVeZrU9zwn70nPR5YnoEdKEwSMmao
 XYmN7Q8XzQIvJqdaJzA==

Enabling KCSAN is causing a large number of duplicate type
declarations for core kernel structs like task_struct [1].
This is due to the definition in include/linux/compiler_types.h

`#ifdef __SANITIZE_THREAD__
...
`#define __data_racy volatile
..
`#else
...
`#define __data_racy
...
`#endif

Because some objects in the kernel are compiled without
KCSAN flags, we sometimes get the empty __data_racy
annotation and as a result we get multiple declarations
of the associated structs that have members with that
annotation, and these lead to multiple instances of core
kernel types.

To solve this, patch 1 skips modifiers CONST, VOLATILE
and RESTRICTED in type equivalence checks.  We avoid 
populating the hypot_map with the intermediate equivalences
as this can lead to unwanted matching failures.

Patch 2 provides tests for the equivalence matching, testing
within BTF and module-to-base BTF deduplication with a struct
that has a mix of modifier and non-modifer types.

Changes since RFC [2]:

- Avoid polluting the hypot_map with intermediate matches
  (Andrii, BPF AI bot)
- Added tests (patch 2)

[1] https://lore.kernel.org/bpf/42a1b4b0-83d0-4dda-b1df-15a1b7c7638d@linux.ibm.com/
[2] https://lore.kernel.org/bpf/20260109101325.47721-1-alan.maguire@oracle.com/

Alan Maguire (2):
  libbpf: BTF dedup should ignore modifiers in type equivalence checks
  selftests/bpf: Verify dedup for skipped modifiers

 tools/lib/bpf/btf.c                           | 35 ++++++---
 .../bpf/prog_tests/btf_dedup_split.c          | 75 +++++++++++++++++++
 2 files changed, 101 insertions(+), 9 deletions(-)

-- 
2.31.1


