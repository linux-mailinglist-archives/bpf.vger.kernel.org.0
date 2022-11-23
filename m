Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06257636773
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 18:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237496AbiKWRmg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 12:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236639AbiKWRmd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 12:42:33 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1C1F78
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 09:42:31 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ANHeffX006310;
        Wed, 23 Nov 2022 17:42:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=bg/zdPZMnoM6xrcIe1D3mIvFscb7+6Jxb0xZHy15ijg=;
 b=AEk9SDLQxZgf+SiTsQZHXh642nx5VK2e8uxFsyZDwgfrqbwSZ1MyQILbZGZAR2JAWLVv
 p3ILf/h3tF/REPOSwjXodqQYBef1sQfQ2q0EwHzy+VctoQor3mvv+Q0p1oabW1dF1Brl
 GPCoiL4BhCSySjM6zH8HglMDMQISEeGi7ouwqFaM+hwQVX+tK/V8Ueo8I3y/g05cSkRE
 YyKkF4Rh6Hjn+LTJ5fDwKl0bginq3L4GL38WIZ6plBAW1JH2EEq+ez6ATZFEfZDkID5p
 OSxoNERpablNgh+jc8HiFQyMIPX3sFM8dfTo54W9aG+HJk+dwrbKXWhD1/3xyXsL6IXM 9g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m1nd88h35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Nov 2022 17:42:03 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ANH74tV015641;
        Wed, 23 Nov 2022 17:42:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kxnk74a9t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Nov 2022 17:42:01 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2ANHfvqC028233;
        Wed, 23 Nov 2022 17:42:01 GMT
Received: from myrouter.uk.oracle.com (dhcp-10-175-201-76.vpn.oracle.com [10.175.201.76])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3kxnk74a4g-2;
        Wed, 23 Nov 2022 17:42:01 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc:     martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        haiyue.wang@intel.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC bpf-next 1/5] bpf: add kind/metadata prefixes to uapi/linux/btf.h
Date:   Wed, 23 Nov 2022 17:41:48 +0000
Message-Id: <1669225312-28949-2-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1669225312-28949-1-git-send-email-alan.maguire@oracle.com>
References: <1669225312-28949-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-23_10,2022-11-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211230130
X-Proofpoint-GUID: MhMso8frcz_nrSERh6X5EfskHZ63VBpO
X-Proofpoint-ORIG-GUID: MhMso8frcz_nrSERh6X5EfskHZ63VBpO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This allows us to share them with kernel and userspace so that
both libbpf and the kernel can parse BTF kind information.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 include/uapi/linux/btf.h       | 7 +++++++
 tools/include/uapi/linux/btf.h | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
index ec1798b..68628e9 100644
--- a/include/uapi/linux/btf.h
+++ b/include/uapi/linux/btf.h
@@ -197,4 +197,11 @@ struct btf_enum64 {
 	__u32	val_hi32;
 };
 
+/* Prefixes used for names encoding BTF kind information via structs;
+ * a "struct __BTF_KIND_ARRAY" represents how BTF_KIND_ARRAY is encoded,
+ * while a "struct __BTF_KIND_META_ARRAY" represents the metadata encoding.
+ */
+#define BTF_KIND_PFX		"__BTF_KIND_"
+#define BTF_KIND_META_PFX	"__BTF_KIND_META_"
+
 #endif /* _UAPI__LINUX_BTF_H__ */
diff --git a/tools/include/uapi/linux/btf.h b/tools/include/uapi/linux/btf.h
index ec1798b..68628e9 100644
--- a/tools/include/uapi/linux/btf.h
+++ b/tools/include/uapi/linux/btf.h
@@ -197,4 +197,11 @@ struct btf_enum64 {
 	__u32	val_hi32;
 };
 
+/* Prefixes used for names encoding BTF kind information via structs;
+ * a "struct __BTF_KIND_ARRAY" represents how BTF_KIND_ARRAY is encoded,
+ * while a "struct __BTF_KIND_META_ARRAY" represents the metadata encoding.
+ */
+#define BTF_KIND_PFX		"__BTF_KIND_"
+#define BTF_KIND_META_PFX	"__BTF_KIND_META_"
+
 #endif /* _UAPI__LINUX_BTF_H__ */
-- 
1.8.3.1

