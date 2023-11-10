Return-Path: <bpf+bounces-14759-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBFD7E7BA2
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 12:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2FF3B20ECE
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 11:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCD11428A;
	Fri, 10 Nov 2023 11:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="woS+y7OV"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738D412B8B
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 11:04:29 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4AE82B78E
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 03:04:28 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A9MaPCD027485;
	Fri, 10 Nov 2023 11:04:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=FJ+y8EJTGoUDCQeOIu7lqIhWqMFUASuERWwk11K6+PM=;
 b=woS+y7OVG8ZS93cP77nQ7Honi1w+Cd+MKVb55sKv1HLqf5eH32OVseW1Kff1GNNzf/bn
 s7IUH0sk3fC2rejq7eedDa/4A7vA3wV8pKXqFhECXGhy+Y98PMO6L8hSh8zRmBbw4r8V
 +Pd3EMB0/W7fWlghxMcqvT5/+bqOpStRM+m7eMp9wrd22QfeWcbTiiW/uJFGQxWCXA1y
 PGO2PFLkhgN/OIDTnHLVhSKucGtosEe/ag/IENihQnYnlxVpQxAb4KPnFJPly1OcfThM
 DTFeV7QSOO884OoSCqY3fjJe96ulRoypXSzlwdxJPWaXrKLu3kprHxCMzl7qPAsUd7Dq YA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w23p1ya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Nov 2023 11:04:11 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAA48K5018297;
	Fri, 10 Nov 2023 11:04:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u8c01qgnd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Nov 2023 11:04:09 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AAB3Wfw018454;
	Fri, 10 Nov 2023 11:04:09 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-213-193.vpn.oracle.com [10.175.213.193])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3u8c01qfd7-10;
	Fri, 10 Nov 2023 11:04:09 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: jolsa@kernel.org, quentin@isovalent.com, eddyz87@gmail.com,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 bpf-next 09/17] bpf: switch to --btf_features, add crc,kind_layout features
Date: Fri, 10 Nov 2023 11:02:56 +0000
Message-Id: <20231110110304.63910-10-alan.maguire@oracle.com>
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
X-Proofpoint-ORIG-GUID: NSxNp0JIHpgDN9NlhTl2Zdf4p4yPnumE
X-Proofpoint-GUID: NSxNp0JIHpgDN9NlhTl2Zdf4p4yPnumE

For pahole v1.26 and later, --btf_features is used to specify BTF
features for encoding.  Since it tolerates unknown features, no
further version checking will be needed when adding new features.
Add crc, kind_layout features.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 scripts/pahole-flags.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/pahole-flags.sh b/scripts/pahole-flags.sh
index 728d55190d97..30a3e270308b 100755
--- a/scripts/pahole-flags.sh
+++ b/scripts/pahole-flags.sh
@@ -26,5 +26,8 @@ fi
 if [ "${pahole_ver}" -ge "125" ]; then
 	extra_paholeopt="${extra_paholeopt} --skip_encoding_btf_inconsistent_proto --btf_gen_optimized"
 fi
+if [ "${pahole_ver}" -ge "126" ]; then
+	extra_paholeopt="-j --lang_exclude=rust --btf_features=encode_force,var,float,decl_tag,type_tag,enum64,optimized_func,consistent_func,crc,kind_layout"
+fi
 
 echo ${extra_paholeopt}
-- 
2.31.1


