Return-Path: <bpf+bounces-26980-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFB88A6E89
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 16:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7BDC1F21984
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 14:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B817B12D741;
	Tue, 16 Apr 2024 14:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nrZYupA0"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F5F39FCE;
	Tue, 16 Apr 2024 14:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713278298; cv=none; b=VMmYhHtPe20UGwdU1GCa11tu1UacK80yfa9rpOOf0QLOlDUdK0v2XpwosX9SIMlOF1dEp61PS8o2rlZhREdEpPQHf3MhMjH6d2YFVpN8CmEb7dL5CpdGoWpM9Wl/fnyHevfztxcmtfgq21IxKYSjuj4wPs/SVrvsT7iMapqGk7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713278298; c=relaxed/simple;
	bh=qSn2RUnF3XP/q/N0ytMEYtwpqinLYB/3XGMpEAhpfuc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WNdvJ9g8ndk4vWZ7jxZyUqJ/aGWBrvx0YuTRNFhQlMZugP1cIsas0itfQbVy7DlwMXyDZVIksfKbJkgB7IHa3/xJe+og6LF0gHDvMxrmJWd5gIa9JOcMlE7ah4wSd9g+FFr7FbP2y+wgcblaow1ax0CZwOnGkpX/mjgGLH4W3eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nrZYupA0; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43GEOf5Y001623;
	Tue, 16 Apr 2024 14:37:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=q3B6UDm3ZSHnyu2nqXZHOOzntM11SSqUKG4D+A4uES8=;
 b=nrZYupA0nhE7U1ce+sytwvj+IMfhmQoOIM9p/L2RFwPeFbQrUPHP3urdLegRtruzLA/y
 Xhga+GOt9GYxjiiLf/+eY7yrIfFi/PNUjsz7CLWs7ms/nPTiC8/lJ6QwfAMBjA6KoYSv
 eSO6oqUD9aDvwijzsV+U5scaYTTFAdDiShmG+Rs2oQDHqrcFc8+gRXvUy8eKi00OYXBL
 pYLU38IMK7Lc/amt7tXcpAcB9RckcB/6jnTV59+9nKBXGsfQuzUjZxa7Kn/hUGr6EIsp
 vqrg6+jpSMb3W+mqtj4tbwpysd4fhsLLLGEHgNCp+5LqkcW5Jyl+1BfiDqPbFmRvYz6o zw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfjkv5cej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2024 14:37:32 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43GDoKCJ029278;
	Tue, 16 Apr 2024 14:37:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xfgg7ana4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2024 14:37:31 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43GEbMeu029885;
	Tue, 16 Apr 2024 14:37:30 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-210-77.vpn.oracle.com [10.175.210.77])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3xfgg7an1y-4;
	Tue, 16 Apr 2024 14:37:30 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org
Cc: dwarves@vger.kernel.org, jolsa@kernel.org, williams@redhat.com,
        kcarcia@redhat.com, bpf@vger.kernel.org, kuifeng@fb.com,
        linux@weissschuh.net, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves 3/3] tests/reproducible_build: use --btf_features=all,reproducible_build
Date: Tue, 16 Apr 2024 15:37:18 +0100
Message-Id: <20240416143718.2857981-4-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240416143718.2857981-1-alan.maguire@oracle.com>
References: <20240416143718.2857981-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_10,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404160089
X-Proofpoint-ORIG-GUID: bTmVqexumY1bycKUXeISwhfEDlfkL0tp
X-Proofpoint-GUID: bTmVqexumY1bycKUXeISwhfEDlfkL0tp

...as this will test enabling all standard features plus a non-standard
one.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tests/reproducible_build.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/reproducible_build.sh b/tests/reproducible_build.sh
index 8cc36fe..e2f8360 100755
--- a/tests/reproducible_build.sh
+++ b/tests/reproducible_build.sh
@@ -29,7 +29,7 @@ nr_proc=$(getconf _NPROCESSORS_ONLN)
 
 for threads in $(seq $nr_proc) ; do
 	test -n "$VERBOSE" && echo $threads threads encoding
-	pahole -j$threads --reproducible_build --btf_features=all --btf_encode_detached=$outdir/vmlinux.btf.parallel.reproducible $vmlinux &
+	pahole -j$threads --btf_features=all,reproducible_build --btf_encode_detached=$outdir/vmlinux.btf.parallel.reproducible $vmlinux &
 	pahole=$!
 	# HACK: Wait a bit for pahole to start its threads
 	sleep 0.3s
-- 
2.39.3


