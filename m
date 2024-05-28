Return-Path: <bpf+bounces-30724-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1FF8D1B39
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 14:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B06A281D19
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 12:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DAC16DEBB;
	Tue, 28 May 2024 12:26:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7C616D4E0
	for <bpf@vger.kernel.org>; Tue, 28 May 2024 12:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716899169; cv=none; b=ZoJLJdAg6H1IPD6CI13jyOak60w8NEF7JQbw8fvpZxWi0TAZ5116aHy+74Z1owhwQkny07zbClgfu+kGBgU9E3KDxtfukKQIuy/LLGvdo2q5xFipZJNGyyq0uB5UYKn56Am4UdreDcraJZCgCvCmZ9qg2M7srsdhA4ejSrpqxDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716899169; c=relaxed/simple;
	bh=KRUpNxnGjfm+svBNuRavzq2AYrb1Gn6rYHJw5Mc1KfI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HFBbnoNaUyUf7hNUEosLPutSo/ZEXPJq7WmkLzDXGyG6GB7Jdg+LjmKjM2pxbRCTWHKmbWDu4Y4YWvnLqnllza+89J0rrojljl1LgB7tPeyLA3d4iLQtwgCY8qKajKOC49Lwadd8oBG5oA41t3pqIOF6ahbVarQMnw9qJ4RJZ9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44SBopZR001882;
	Tue, 28 May 2024 12:24:49 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:date:from:in-reply-to:message-i?=
 =?UTF-8?Q?d:mime-version:references:subject:to;_s=3Dcorp-2023-11-20;_bh?=
 =?UTF-8?Q?=3DQRypdBb66koL2LmsJw83xk/C9qsrWfGCaIp+kj9oKmU=3D;_b=3DGuTZQBiM?=
 =?UTF-8?Q?6jVrDCX44XIrQPMpXLcxJ051Bf8s0O7m0l5932wSkfE1rd/juBP4zCHvJxcn_CW?=
 =?UTF-8?Q?btyMlNVCvUUXPcBIoH4uA7F4n35lbouC7H6U8LWCczejafsElK6oW17qS+Q9LEM?=
 =?UTF-8?Q?pGb_IB2R9bZRhQBVFiWrHCHfwWwf5lH+FBVOHY5Tqmgff/23Kf6AtOp2MRwmTjw?=
 =?UTF-8?Q?PrULq2jyr_gUSP/0mjn85hOZKrCx9aDUR2RYA7ITyjT0laa/lyf6MhlfyEnzFTy?=
 =?UTF-8?Q?vfgT0ZUa8dKPG9l_bmwsvKFaN/XSMVHFczlBgEyLLYaTVhBn3A0qjVE5AcLYF7v?=
 =?UTF-8?Q?vOox6O4shSe1OArQvmX7/_rQ=3D=3D_?=
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8g446xs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 12:24:48 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44SBJV3I037285;
	Tue, 28 May 2024 12:24:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yc535a05r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 12:24:46 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44SCNlJX022297;
	Tue, 28 May 2024 12:24:45 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-164-70.vpn.oracle.com [10.175.164.70])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3yc5359yey-7;
	Tue, 28 May 2024 12:24:45 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com,
        quentin@isovalent.com
Cc: eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org,
        masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v5 bpf-next 6/9] resolve_btfids: handle presence of .BTF.base section
Date: Tue, 28 May 2024 13:24:05 +0100
Message-Id: <20240528122408.3154936-7-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240528122408.3154936-1-alan.maguire@oracle.com>
References: <20240528122408.3154936-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_08,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405280093
X-Proofpoint-GUID: W_UR51TygXIPzcsKggfq_oQ_kBnPihmM
X-Proofpoint-ORIG-GUID: W_UR51TygXIPzcsKggfq_oQ_kBnPihmM

Now that btf_parse_elf() handles .BTF.base section presence,
we need to ensure that resolve_btfids uses .BTF.base when present
rather than the vmlinux base BTF passed in via the -B option.
Detect .BTF.base section presence and unset the base BTF path
to ensure that BTF ELF parsing will do the right thing.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/bpf/resolve_btfids/main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index d9520cb826b3..de2012f25f71 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -409,6 +409,14 @@ static int elf_collect(struct object *obj)
 			obj->efile.idlist       = data;
 			obj->efile.idlist_shndx = idx;
 			obj->efile.idlist_addr  = sh.sh_addr;
+		} else if (!strcmp(name, BTF_BASE_ELF_SEC)) {
+			/* If a .BTF.base section is found, do not resolve
+			 * BTF ids relative to vmlinux; resolve relative
+			 * to the .BTF.base section instead.  btf__parse_split()
+			 * will take care of this once the base BTF it is
+			 * passed is NULL.
+			 */
+			obj->base_btf_path = NULL;
 		}
 
 		if (compressed_section_fix(elf, scn, &sh))
-- 
2.31.1


