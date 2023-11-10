Return-Path: <bpf+bounces-14757-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5692F7E7BA0
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 12:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87DCD1C20BD2
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 11:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237751428D;
	Fri, 10 Nov 2023 11:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b2K+bgq3"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA771427E
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 11:04:24 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151982B78E
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 03:04:23 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A9MY59K020629;
	Fri, 10 Nov 2023 11:04:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=uUi5A1cYY335vpW2po9LFcqtECoTTqcgTnrD1OFJaeQ=;
 b=b2K+bgq33l3ZKVAmJZ/kWk94fLBwg6kRpIgWGgqdgfpXSXPvQAitR3qr9u2JUs7O7eXD
 KFr+5WH9Mec/Yplg9OAkoN3j9YngM+kYmKUySw/qCVjFQFFRx0X34C1AXFEziecv5rTK
 iIRt59v0L4FpEfhm99v96ErawQSGog3hasFjqD0lePTL8jJwyzE4O2CHMbLdUghbA35I
 MfU5iD5lDTY66O7UURaGnRsLyzEvluT0fkC9I2jxivLphHyRwrargIOwwwzbAKporDti
 ppVtwzT0fOU0b43uJyw+WR6nPm69s9h4I44L0lc0sLUh65vMNNlOwpkhHWCqVZvhY2cA Xw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w2264m1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Nov 2023 11:04:06 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AA9pqQn017618;
	Fri, 10 Nov 2023 11:04:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u8c01qgk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Nov 2023 11:04:06 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AAB3Wfu018454;
	Fri, 10 Nov 2023 11:04:05 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-213-193.vpn.oracle.com [10.175.213.193])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3u8c01qfd7-9;
	Fri, 10 Nov 2023 11:04:05 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: jolsa@kernel.org, quentin@isovalent.com, eddyz87@gmail.com,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 bpf-next 08/17] bpf: verify base BTF CRC to ensure it matches module BTF
Date: Fri, 10 Nov 2023 11:02:55 +0000
Message-Id: <20231110110304.63910-9-alan.maguire@oracle.com>
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
X-Proofpoint-GUID: ke31aeWTx6_BcaoxfWBCVs74yTl47NiI
X-Proofpoint-ORIG-GUID: ke31aeWTx6_BcaoxfWBCVs74yTl47NiI

Having a base CRC in module BTF allows us to reject base BTF
that does not match that CRC; this allows us to recognize
incompatible BTF up-front, not having to rely on invalidation
due to internal mismatches in module/kernel BTF ids.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 kernel/bpf/btf.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 4eb13634580b..65a85bad13f7 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5372,6 +5372,24 @@ static int btf_parse_hdr(struct btf_verifier_env *env)
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


