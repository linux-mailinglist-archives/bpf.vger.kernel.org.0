Return-Path: <bpf+bounces-76727-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBBACC4A40
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 18:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DEF7D307DA51
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 17:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65063A1E8E;
	Tue, 16 Dec 2025 17:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OmaNnalk"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6405328608
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 17:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765905616; cv=none; b=PFXHf/CU8lPQfUo3K4B1SiEY7ZJGYhMdXunL/TbWrKxr6nh0rei3sU0AjYdCzMBlkVITzz2ZOXIcZZM+s6kp3U7I4Yns54M68Hrs3V4qj+xjBdRU9CJhtkA8Xa803PnfecVcoYmtylv8YTF9J9ZsJXvUobXaglguGFkwtQs6W9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765905616; c=relaxed/simple;
	bh=w7UWC60Kl2F4HFXLzJwUvsSAVfiFL30KxEdeYidBx60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s7U5p0y2E/XX4KcFafg9oVjxubd+2pR2P2INo6y7HYpGj6fIrxruve0NBihhRzCkSgPjx9U1kvU3Z6cfK/UU03QjoBYNDrkGkRexO3uo/GRcTnreYQmZ2H8Tot5MyUIcxB01/+5Dkzo/Pn4P2kNjs0F1cuXxwoTmQiDqhnL7D50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OmaNnalk; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BGDuNXl543904;
	Tue, 16 Dec 2025 17:19:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=895u1
	teOuieqgVITS/I99i8odp5vcx3mDJtrWPE9Fpc=; b=OmaNnalkEyS/YrKqthBlz
	7tmESHS3hDplavBG3DBObe0l/i+0rgeoxw3UdhjDl8guzpNpl2kqLItQYKv/AZOe
	UOgpgJowVbSG9jEVSPtmdwH3M0GjnuvXmYt3nkWqUT2kwoaRKnLeqYnI0Kdo8lSj
	wbxGhkOfrnbHwCezAJP2lLfVp8eJO/g0CzMKxY0UTbd3MDwilijj8FCe6Cl+oviS
	/gNTYX2yWSX8Wz9VJsrVbWFWdPYpKZuqDXsz/XmjL+ZMx0aggGOAuI4/77yT7OVe
	pduvfDfCV/TvkpR45RWAKV9OKw7NnMPSGFKvIta1/eD33IsgVOekSOmc7gnKmR6M
	g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b1015vc70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Dec 2025 17:19:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGHFnR4006079;
	Tue, 16 Dec 2025 17:19:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xkdgpws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Dec 2025 17:19:02 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BGHIvZT039632;
	Tue, 16 Dec 2025 17:19:01 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-50-156.vpn.oracle.com [10.154.50.156])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4b0xkdgprs-3;
	Tue, 16 Dec 2025 17:19:01 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: qmo@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next 2/2] bpftool: force-anonymize structs to avoid need for -fms-extension
Date: Tue, 16 Dec 2025 17:18:54 +0000
Message-ID: <20251216171854.2291424-3-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251216171854.2291424-1-alan.maguire@oracle.com>
References: <20251216171854.2291424-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512160149
X-Proofpoint-GUID: nnPeqjmEbmSd0PpN-rTVCMpKfSVdrbGU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDE0OCBTYWx0ZWRfXxQYXYXOCk3F0
 3WLOLEDA4SkbQAxZ2Aawneaj+mdbifELp1tIvQu68AaqLlQSiJdZYm/HLBTdOa9hXga9U9VW0Rm
 nCJhGtoUprJWb6jQQAaVs6oy+wU/2HVK/S1byXK2eyqh2b6Frwy4Un1pbMX3GvB81Task+Jqacn
 2WhWlXWnx2bHPZaoUbbUAGzbi+UfwbkI+PCeW1b5jBB27ryISEgaqsuORYd10p341dB9P1hk30p
 k1aIP9KLe43y1S+BS64ak/SDmjqbl19/rlr+z54HyjaEFcpAKUemadW5b+u7Bgxq9GZiwkv2HQM
 cE2d+16Ybjn+g6f34+0LIPpZwgeTk4yKTGrBs2PbzqeqEIXU89W+aEFbgBh67e0tkovcEaBmBgG
 c22jbF4DLEOGYRR9G+a/iANodR8e+Lgua4s4026o1jZ80Sm/0WU=
X-Authority-Analysis: v=2.4 cv=GbUaXAXL c=1 sm=1 tr=0 ts=69419487 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=5XCLiLK5bj5d-ma3yFgA:9 cc=ntf awl=host:12109
X-Proofpoint-ORIG-GUID: nnPeqjmEbmSd0PpN-rTVCMpKfSVdrbGU

Use libbpf dump option to ensure that a nested struct will be
declared as an equivalent anonymous struct to the named struct.
With this approach we do not need -fms-extension to support
such structs in vmlinux.h.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/bpf/bpftool/btf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 946612029dee..523c8bf0e53a 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -771,11 +771,13 @@ static struct sort_datum *sort_btf_c(const struct btf *btf)
 static int dump_btf_c(const struct btf *btf,
 		      __u32 *root_type_ids, int root_type_cnt, bool sort_dump)
 {
+	DECLARE_LIBBPF_OPTS(btf_dump_opts, opts,
+			    .force_anon_struct_members = true);
 	struct sort_datum *datums = NULL;
 	struct btf_dump *d;
 	int err = 0, i;
 
-	d = btf_dump__new(btf, btf_dump_printf, NULL, NULL);
+	d = btf_dump__new(btf, btf_dump_printf, NULL, &opts);
 	if (!d)
 		return -errno;
 
-- 
2.39.3


