Return-Path: <bpf+bounces-14925-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B6C7E8FC4
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 13:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF0BA1C2084B
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 12:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B378BE5;
	Sun, 12 Nov 2023 12:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jD18tR9c"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D1763D3
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 12:49:28 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3E42D64
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 04:49:27 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ACCiL2H012886;
	Sun, 12 Nov 2023 12:49:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=61TYyj5H8+eGFzSL11VBzh4G3fjDb1CAqf8B71EAdCY=;
 b=jD18tR9cVG7tvqRAHMOrTNgDXW+WtJ6sBwfKdb6xNy6H9FiQI7WR3oBsRyLD6NbevA3R
 ZaX7KkkEcE1dvTsNOQUEtq3j+nXoM5ZOpHyLFvtpJ5xCebnyXTfoaq465v+G13WyDDXT
 QRNaJUpjdCVXY1zdyBqx81IZFZXV/8WKy8bLdDHHQjcI0yHHplz0vkMjhc47MQdWDQT6
 kOfh1Aj7o0WFPFrfDCpmRkbh09ydPzgUxvZTRbRxZuV271sIw3RZcZBTApp62AVmBF+a
 /+ZDr6M1MOpM3Z/vUnJYY5zOKE+L0hAWoq7DuhOTCVVGCQIcyH+I3qB7fj8ofIG/jz05 bg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2r01eq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 12 Nov 2023 12:49:10 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3ACCEGNi008467;
	Sun, 12 Nov 2023 12:49:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uaxhngfmd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 12 Nov 2023 12:49:09 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ACCmceG029718;
	Sun, 12 Nov 2023 12:49:08 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-173-14.vpn.oracle.com [10.175.173.14])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3uaxhngfep-8;
	Sun, 12 Nov 2023 12:49:08 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, jolsa@kernel.org
Cc: quentin@isovalent.com, eddyz87@gmail.com, martin.lau@linux.dev,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        masahiroy@kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v4 bpf-next 07/17] bpf: add BTF CRC verification where present
Date: Sun, 12 Nov 2023 12:48:24 +0000
Message-Id: <20231112124834.388735-8-alan.maguire@oracle.com>
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
X-Proofpoint-ORIG-GUID: ws70et_2i-tqNoq0iRrVm0x3D4vnCIqz
X-Proofpoint-GUID: ws70et_2i-tqNoq0iRrVm0x3D4vnCIqz

If a CRC is set in provided BTF, verify it.

Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 kernel/bpf/btf.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 554b5b795d6f..96c553e40b43 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -25,6 +25,7 @@
 #include <linux/bsearch.h>
 #include <linux/kobject.h>
 #include <linux/sysfs.h>
+#include <linux/crc32.h>
 
 #include <net/netfilter/nf_bpf_link.h>
 
@@ -5354,6 +5355,20 @@ static int btf_parse_hdr(struct btf_verifier_env *env)
 		return -ENOTSUPP;
 	}
 
+	if (hdr->flags & BTF_FLAG_CRC_SET) {
+		__u32 check, crc = hdr->crc;
+		struct btf_header *h = btf->data;
+
+		h->crc = 0;
+		check = crc32(0xffffffff, btf->data, btf_data_size);
+		check ^= ~0;
+		h->crc = crc;
+		if (check != crc) {
+			btf_verifier_log(env, "Invalid CRC; expected 0x%x ; actual 0x%x",
+					 crc, check);
+			return -EINVAL;
+		}
+	}
 	if (!btf->base_btf && btf_data_size == hdr->hdr_len) {
 		btf_verifier_log(env, "No data");
 		return -EINVAL;
-- 
2.31.1


