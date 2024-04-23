Return-Path: <bpf+bounces-27567-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1218C8AF368
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 18:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95E4D1F21E64
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 16:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B7613CAA0;
	Tue, 23 Apr 2024 16:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hIR0RA/I"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3085813CA9C;
	Tue, 23 Apr 2024 16:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713888147; cv=none; b=EAYgP+uZSlzkpsk48yx53DitT+2fvaXDgJfZejSJ7/Vtj9g/lU16sVeBki2KMu+bCC8hhHgMe99U5TYe7OPLxeddpKWJnjRmGeTilaR4Ci6YIvePx+G0Q3E3rRfZXMvtroyQ+LJLfPk5o+P0dFwivR9xAV1aadys35UVz1g0iKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713888147; c=relaxed/simple;
	bh=6Qt/yakGdHQHHA3EhMesGFzAtp7QD6hTYVlVNdwfJW4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cCy6LSNfEZySwx5D8+PlCuYcibIG+Yw1QnfhBtlpK8m8HIETjsbtJ84qjlwjEtbBmNG4LObmIy0fwCH1KrfqD62LEEkT7ZRHm1GppbKrzakDOh+7+w3DV12Ee03IHYmpVxmOyf3A0TmczZbcN05VIYHmFT0U5c/U1maAplZPoL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hIR0RA/I; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43NFT2DF023932;
	Tue, 23 Apr 2024 16:02:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=6V5R1i+rSoMbNqw14e3trjn+wLiaRgjXDaS5FAMuPWw=;
 b=hIR0RA/I89W7HeV+XY3vJzqg/PBKXT02BvDhmfXV1PPt6DETDWflEDVem20yV99rK5Wt
 KTvYRmkraDCoaIZJVLD7YSH51GFY/JlICECOiMycmRZMh+os3gtrxFBppR6bOUy18xsz
 6UhrmtoJCTFPehZ6JurS2oMgLsVIMYsGZa0agfgttCPgw365uqhVCLjrwG+BXLHhV7Z9
 Wc5zC3HuSRqMR/SrB3R3Dq4PlRKkXAG8W0yse0F5nBJcZvcQOuHSFHzXz087NEBHKlAh
 nqtVmt+skXXTKcdHpMhgICJT/1uk1wwcwUko24TFwyx2rV+/BoQwG6HotmGiuF4NsPAU DQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm5aunqaj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 16:02:11 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43NFNtZ1019227;
	Tue, 23 Apr 2024 16:02:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xpbf3e735-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 16:02:10 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43NG24nX038435;
	Tue, 23 Apr 2024 16:02:10 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-173-44.vpn.oracle.com [10.175.173.44])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3xpbf3e6pt-3;
	Tue, 23 Apr 2024 16:02:09 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org
Cc: dxu@dxuuu.xyz, dwarves@vger.kernel.org, andrii.nakryiko@gmail.com,
        jolsa@kernel.org, williams@redhat.com, kcarcia@redhat.com,
        bpf@vger.kernel.org, eddyz87@gmail.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves 2/2] tests: update reproducible_build test to use "default"
Date: Tue, 23 Apr 2024 17:02:00 +0100
Message-Id: <20240423160200.3139270-3-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240423160200.3139270-1-alan.maguire@oracle.com>
References: <20240423160200.3139270-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_12,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404230037
X-Proofpoint-ORIG-GUID: KD2gtLrcn_ErmDW-jJFAgp7k1dQYc7pY
X-Proofpoint-GUID: KD2gtLrcn_ErmDW-jJFAgp7k1dQYc7pY

The test should use --btf_features=default in place of the
removed "all".

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tests/reproducible_build.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/reproducible_build.sh b/tests/reproducible_build.sh
index e2f8360..00269c1 100755
--- a/tests/reproducible_build.sh
+++ b/tests/reproducible_build.sh
@@ -22,14 +22,14 @@ echo -n "Parallel reproducible DWARF Loading/Serial BTF encoding: "
 
 test -n "$VERBOSE" && printf "\nserial encoding...\n"
 
-pahole --btf_features=all --btf_encode_detached=$outdir/vmlinux.btf.serial $vmlinux
+pahole --btf_features=default --btf_encode_detached=$outdir/vmlinux.btf.serial $vmlinux
 bpftool btf dump file $outdir/vmlinux.btf.serial > $outdir/bpftool.output.vmlinux.btf.serial
 
 nr_proc=$(getconf _NPROCESSORS_ONLN)
 
 for threads in $(seq $nr_proc) ; do
 	test -n "$VERBOSE" && echo $threads threads encoding
-	pahole -j$threads --btf_features=all,reproducible_build --btf_encode_detached=$outdir/vmlinux.btf.parallel.reproducible $vmlinux &
+	pahole -j$threads --btf_features=default,reproducible_build --btf_encode_detached=$outdir/vmlinux.btf.parallel.reproducible $vmlinux &
 	pahole=$!
 	# HACK: Wait a bit for pahole to start its threads
 	sleep 0.3s
-- 
2.39.3


