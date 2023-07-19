Return-Path: <bpf+bounces-5335-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 095D8759AB6
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 18:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69C0D28193E
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 16:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CD33D3BD;
	Wed, 19 Jul 2023 16:23:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4A011C93
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 16:23:58 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FD219B2
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 09:23:44 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36JFONCZ005169;
	Wed, 19 Jul 2023 16:23:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=yR+9Wv5PB3JJqtIcZemMr7tuYLmzFIP4yeZMgdou3Jg=;
 b=H6CxG2L3cIdP0U9tSEAlDjYjH3GSK6E25OSgCfoKxgGKVxCI+WJOc4ZjeRtsEb6bF5gO
 lyzp8+Duf2iCsYr1qtKQERLapGETSpnV13E1jzRDLgELLYEIVKJjOZI9Lov+EaAp3Iie
 9CoaWCvCl8GKlkd2+vO1TlTI499kB5F5HfvDP3mHqTlP9GgKhB8B2qIdT41xeIAMIS0C
 RHtsmJeQHDnGCLdDc2q+4/5SOEoSuVPOwZVgXanSq4llV0ArsKH0sIbvdGp96+M3LsnB
 ml7//pAuW1IQCn39ndFGNlND7uWclpHtV0ZjrrDHYF5I98hkuILGb5/lFChHMTJ2aNWy Pw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run8a7wjt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Jul 2023 16:23:29 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36JFBLcN019188;
	Wed, 19 Jul 2023 16:23:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw7k4wf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Jul 2023 16:23:27 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36JGI5xH009336;
	Wed, 19 Jul 2023 16:23:00 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-167-215.vpn.oracle.com [10.175.167.215])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3ruhw7k4v7-1;
	Wed, 19 Jul 2023 16:23:00 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: davemarchevsky@fb.com
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@kernel.org, memxor@gmail.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next] bpf: sync tools/ uapi header with
Date: Wed, 19 Jul 2023 17:22:57 +0100
Message-Id: <20230719162257.20818-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_11,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=950 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307190148
X-Proofpoint-ORIG-GUID: 38ssXu6Y96t5m2HNwA8-5wL5T0OLobun
X-Proofpoint-GUID: 38ssXu6Y96t5m2HNwA8-5wL5T0OLobun
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Seeing the following:

Warning: Kernel ABI header at 'tools/include/uapi/linux/bpf.h' differs from latest version at 'include/uapi/linux/bpf.h'

...so sync tools version missing some list_node/rb_tree fields.

Fixes: c3c510ce431c ("bpf: Add 'owner' field to bpf_{list,rb}_node")
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/include/uapi/linux/bpf.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 600d0caebbd8..9ed59896ebc5 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7052,6 +7052,7 @@ struct bpf_list_head {
 struct bpf_list_node {
 	__u64 :64;
 	__u64 :64;
+	__u64 :64;
 } __attribute__((aligned(8)));
 
 struct bpf_rb_root {
@@ -7063,6 +7064,7 @@ struct bpf_rb_node {
 	__u64 :64;
 	__u64 :64;
 	__u64 :64;
+	__u64 :64;
 } __attribute__((aligned(8)));
 
 struct bpf_refcount {
-- 
2.39.3


