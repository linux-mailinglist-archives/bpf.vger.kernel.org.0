Return-Path: <bpf+bounces-14927-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 005137E8FC6
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 13:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A8621C2088D
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 12:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A838832;
	Sun, 12 Nov 2023 12:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="0IqfxAT0"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857D18495
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 12:49:32 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935FB2D5B
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 04:49:31 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ACCiaxj012933;
	Sun, 12 Nov 2023 12:49:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=aSLUpO+Oy9+9EXWKffUG2LeokwAiROZm+yzgXOAg7wM=;
 b=0IqfxAT0m/JzNgs/hPPRdQUx7ImltCVrKXsdyPvdVXaCgPm0jLNl4f2a/XHu7onJKqAA
 vAlUQXAI0xj9SlQax5Jb0ov++fPL4pvzitQ7Xq7DhIq2vckJU3bHRoYsx24lCGvbHF9Z
 0lxIIi5/AGlQUidEImpDgEgYhMQTL3ifOdT2zm8oFxFg6QKMCeaxCMYpNGoNmQceD3WZ
 AgqOK/P71A0CTDFX17U8VSWgP2T99eMWwjan4DdnP6rQ9CKsmCGW6g+NP/s1A3BXHpkX
 k/q1hxsQ7FbAUEi7f7rx+QZNOHaTX/l5jHzGyFGqJ3ZfSQoO6DqViwr3j3WMaqXD/ygh hQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2r01eqa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 12 Nov 2023 12:49:14 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3ACCF8wb009277;
	Sun, 12 Nov 2023 12:49:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uaxhngfn9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 12 Nov 2023 12:49:13 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ACCmceI029718;
	Sun, 12 Nov 2023 12:49:12 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-173-14.vpn.oracle.com [10.175.173.14])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3uaxhngfep-9;
	Sun, 12 Nov 2023 12:49:12 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, jolsa@kernel.org
Cc: quentin@isovalent.com, eddyz87@gmail.com, martin.lau@linux.dev,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        masahiroy@kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v4 bpf-next 08/17] bpf: verify base BTF CRC to ensure it matches module BTF
Date: Sun, 12 Nov 2023 12:48:25 +0000
Message-Id: <20231112124834.388735-9-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231112124834.388735-1-alan.maguire@oracle.com>
References: <20231112124834.388735-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-12_10,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311120113
X-Proofpoint-ORIG-GUID: QKB4y27Rd1SnReSKakYam1Tn7btLMWdk
X-Proofpoint-GUID: QKB4y27Rd1SnReSKakYam1Tn7btLMWdk

Having a base CRC in module BTF allows us to reject base BTF
that does not match that CRC; this allows us to recognize
incompatible BTF up-front, not having to rely on invalidation
due to internal mismatches in module/kernel BTF ids.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 kernel/bpf/btf.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 96c553e40b43..a51dc3ef6a56 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5369,6 +5369,24 @@ static int btf_parse_hdr(struct btf_verifier_env *env)
 			return -EINVAL;
 		}
 	}
+	if (hdr->flags & BTF_FLAG_BASE_CRC_SET) {
+		struct btf_header *base_hdr = &btf->base_btf->hdr;
+
+		if (!btf->base_btf) {
+			btf_verifier_log(env, "Specified base BTF CRC but no base BTF");
+			return -EINVAL;
+		}
+
+		if (!(base_hdr->flags & BTF_FLAG_CRC_SET)) {
+			btf_verifier_log(env, "Specified base BTF CRC but base BTF has no CRC");
+			return -EINVAL;
+		}
+		if (hdr->base_crc != base_hdr->crc) {
+			btf_verifier_log(env, "Specified base CRC 0x%x; differs from actual base CRC 0x%x\n",
+					 hdr->base_crc, base_hdr->crc);
+			return -EINVAL;
+		}
+	}
 	if (!btf->base_btf && btf_data_size == hdr->hdr_len) {
 		btf_verifier_log(env, "No data");
 		return -EINVAL;
-- 
2.31.1


