Return-Path: <bpf+bounces-14756-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8814E7E7B9F
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 12:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 994C91C20D3A
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 11:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9AEC12B75;
	Fri, 10 Nov 2023 11:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OVavqhVM"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08375134DA
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 11:04:21 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A052B78E
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 03:04:20 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A9MYBOD020650;
	Fri, 10 Nov 2023 11:04:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=+Y1hdcI5CntZO/WUgo2owHVyNhoSnQ3SeGkaszAGb1s=;
 b=OVavqhVMJrWJMoNJa98HShgxJT4IAUIDAoXa454wydf1vkOTnx0P0jbgxWgGV5yKhOFb
 1lBIpU/QJtX/S4ualf0TyfY16QzlRHFUgyETJN7WaIyGME3qDwoCFg+DSgcpWHa+Wj+z
 rhH4GGd2yeO2onMRcxh3/fodI8O2YgFce4cXv+n59kGBkaKdCy4pZCqd8XJIG70eTzMK
 7UZmcXuqtdULRS5MvZ5VoGpsQczKVR5RpJKNDty5d08bify6uRxtSgcy32gwo6lffciM
 vlj0AGiMEJJW97nFz3n9AQwjylr0/oUnrGRJ2pEkHvVty8RpH3XogE9316mFvaZH/EOF yA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w2264kw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Nov 2023 11:04:03 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AA9hSpY017608;
	Fri, 10 Nov 2023 11:04:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u8c01qgh2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Nov 2023 11:04:02 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AAB3Wfs018454;
	Fri, 10 Nov 2023 11:04:02 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-213-193.vpn.oracle.com [10.175.213.193])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3u8c01qfd7-8;
	Fri, 10 Nov 2023 11:04:02 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: jolsa@kernel.org, quentin@isovalent.com, eddyz87@gmail.com,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v3 bpf-next 07/17] bpf: add BTF CRC verification where present
Date: Fri, 10 Nov 2023 11:02:54 +0000
Message-Id: <20231110110304.63910-8-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231110110304.63910-1-alan.maguire@oracle.com>
References: <20231110110304.63910-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_07,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311100090
X-Proofpoint-GUID: jMIMQiTFw8crD76lU5MBaSnJJt9js5hf
X-Proofpoint-ORIG-GUID: jMIMQiTFw8crD76lU5MBaSnJJt9js5hf

If a CRC is set in provided BTF, verify it.

Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 kernel/bpf/btf.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 7cc372462124..4eb13634580b 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -25,6 +25,7 @@
 #include <linux/bsearch.h>
 #include <linux/kobject.h>
 #include <linux/sysfs.h>
+#include <linux/crc32.h>
 
 #include <net/netfilter/nf_bpf_link.h>
 
@@ -5357,6 +5358,20 @@ static int btf_parse_hdr(struct btf_verifier_env *env)
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


