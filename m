Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D9D67F2BD
	for <lists+bpf@lfdr.de>; Sat, 28 Jan 2023 01:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbjA1AIB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 19:08:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbjA1AHu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 19:07:50 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DAEB8A577
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 16:07:41 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30RNBkOQ024118;
        Sat, 28 Jan 2023 00:07:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=+h37hH/r5oaPcK0aN9XuFmXK62+jpwTJOw5ieZMK8XY=;
 b=Kk06fD87+3BM/wqFz1eig5WVAF9SjEMUAcEbITTKOPi8m3/vlCrQe60oNff7Nth15epA
 47QtGC/j4Bo2bqgHFMyNmqd4as9sxd/JNJNVfo+LhWG7iX7aVNEqhOKGmZwby4opWo6B
 DTDeVJ3EF68rWm+7IqcboIpthxN4rTfrXsRz1gXU8pr/ySz0CC3STjU8L//P+xgHUd0K
 7OVCk7sdyLHTQhiUJroa4c6VtSFwQqyXvsZJbgxZRotS039hwvrEkRe3YP0o4u68X5Tb
 Pz4oeg8Bg/x8iMmDcjrx13rB1JhOczo4nOD0eKJx/X70zlj/CxNtUJxE5dsnlvirDFhR Ow== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ncr2nrxq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 28 Jan 2023 00:07:28 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30RMa8bb015740;
        Sat, 28 Jan 2023 00:07:26 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3n87afg595-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 28 Jan 2023 00:07:26 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30S07Mgi47841590
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 28 Jan 2023 00:07:23 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6BAD20043;
        Sat, 28 Jan 2023 00:07:22 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 538AA2004B;
        Sat, 28 Jan 2023 00:07:22 +0000 (GMT)
Received: from heavy.ibmuc.com (unknown [9.179.11.57])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Sat, 28 Jan 2023 00:07:22 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 25/31] bpf: btf: Add BTF_FMODEL_SIGNED_ARG flag
Date:   Sat, 28 Jan 2023 01:06:44 +0100
Message-Id: <20230128000650.1516334-26-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230128000650.1516334-1-iii@linux.ibm.com>
References: <20230128000650.1516334-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UB2a0qHeMuPsHwtS2fWlXk-ZPO32lMUE
X-Proofpoint-ORIG-GUID: UB2a0qHeMuPsHwtS2fWlXk-ZPO32lMUE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_15,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=974 mlxscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 bulkscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301270220
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

s390x eBPF JIT needs to know whether a function return value is signed
and which function arguments are signed, in order to generate code
compliant with the s390x ABI.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 include/linux/bpf.h |  4 ++++
 include/linux/btf.h | 15 ++++++++++-----
 kernel/bpf/btf.c    | 16 +++++++++++++++-
 3 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 6415b54fea4e..8aafbe6af21c 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -899,8 +899,12 @@ enum bpf_cgroup_storage_type {
 /* The argument is a structure. */
 #define BTF_FMODEL_STRUCT_ARG		BIT(0)
 
+/* The argument is signed. */
+#define BTF_FMODEL_SIGNED_ARG		BIT(1)
+
 struct btf_func_model {
 	u8 ret_size;
+	u8 ret_flags;
 	u8 nr_args;
 	u8 arg_size[MAX_BPF_FUNC_ARGS];
 	u8 arg_flags[MAX_BPF_FUNC_ARGS];
diff --git a/include/linux/btf.h b/include/linux/btf.h
index 5f628f323442..e9b90d9c3569 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -236,6 +236,16 @@ static inline bool btf_type_is_small_int(const struct btf_type *t)
 	return btf_type_is_int(t) && t->size <= sizeof(u64);
 }
 
+static inline u8 btf_int_encoding(const struct btf_type *t)
+{
+	return BTF_INT_ENCODING(*(u32 *)(t + 1));
+}
+
+static inline bool btf_type_is_signed_int(const struct btf_type *t)
+{
+	return btf_type_is_int(t) && (btf_int_encoding(t) & BTF_INT_SIGNED);
+}
+
 static inline bool btf_type_is_enum(const struct btf_type *t)
 {
 	return BTF_INFO_KIND(t->info) == BTF_KIND_ENUM;
@@ -306,11 +316,6 @@ static inline u8 btf_int_offset(const struct btf_type *t)
 	return BTF_INT_OFFSET(*(u32 *)(t + 1));
 }
 
-static inline u8 btf_int_encoding(const struct btf_type *t)
-{
-	return BTF_INT_ENCODING(*(u32 *)(t + 1));
-}
-
 static inline bool btf_type_is_scalar(const struct btf_type *t)
 {
 	return btf_type_is_int(t) || btf_type_is_enum(t);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 47b8cb96f2c2..1622a3b15d6f 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6453,6 +6453,18 @@ static int __get_type_size(struct btf *btf, u32 btf_id,
 	return -EINVAL;
 }
 
+static u8 __get_type_fmodel_flags(const struct btf_type *t)
+{
+	u8 flags = 0;
+
+	if (__btf_type_is_struct(t))
+		flags |= BTF_FMODEL_STRUCT_ARG;
+	if (btf_type_is_signed_int(t))
+		flags |= BTF_FMODEL_SIGNED_ARG;
+
+	return flags;
+}
+
 int btf_distill_func_proto(struct bpf_verifier_log *log,
 			   struct btf *btf,
 			   const struct btf_type *func,
@@ -6473,6 +6485,7 @@ int btf_distill_func_proto(struct bpf_verifier_log *log,
 			m->arg_flags[i] = 0;
 		}
 		m->ret_size = 8;
+		m->ret_flags = 0;
 		m->nr_args = MAX_BPF_FUNC_REG_ARGS;
 		return 0;
 	}
@@ -6492,6 +6505,7 @@ int btf_distill_func_proto(struct bpf_verifier_log *log,
 		return -EINVAL;
 	}
 	m->ret_size = ret;
+	m->ret_flags = __get_type_fmodel_flags(t);
 
 	for (i = 0; i < nargs; i++) {
 		if (i == nargs - 1 && args[i].type == 0) {
@@ -6516,7 +6530,7 @@ int btf_distill_func_proto(struct bpf_verifier_log *log,
 			return -EINVAL;
 		}
 		m->arg_size[i] = ret;
-		m->arg_flags[i] = __btf_type_is_struct(t) ? BTF_FMODEL_STRUCT_ARG : 0;
+		m->arg_flags[i] = __get_type_fmodel_flags(t);
 	}
 	m->nr_args = nargs;
 	return 0;
-- 
2.39.1

