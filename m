Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489CE67BEC9
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 22:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236780AbjAYVkB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 16:40:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236639AbjAYVjy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 16:39:54 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD1A2ED42
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 13:39:51 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PKLd4R004565;
        Wed, 25 Jan 2023 21:39:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=6m44g1/Graei40VKmgHMtR7A1/5EySouX48qWDlOmUQ=;
 b=JDqMqxZQncyR88WwI4AfB8hvoC9nDruG9cVjQZdBo05L71DLvDMrDDkZMeG9xmNAItX/
 330uZvkCx9RZnG3h5Awv/wrCh4IeuBBa4DLzsJcWJv34SabhwXf0z4Sy+ORtWA4aH/T2
 k3FwYesKXjMznk0ys+/bHaZZLnJ4x5tYUpft2HSXfK2ipADPq/CaqYYGjQtOXXINxVM6
 mb10Q5XrZ29dVZyw2AOEinf82twFI/aQjQ2gZgzN4y1o0FjZPtnAVVJpzcGaq+RJZ42p
 Rf/HJwqtfPATbfpeCl2gKAHc4hYI3KxhZGwy6u8aScthqs35eql0GlYrS4C7hcMl09TQ pQ== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nb8yu5ts6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 21:39:37 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30PEafF9016206;
        Wed, 25 Jan 2023 21:39:36 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3n87p6c1e7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 21:39:35 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30PLdWrb43909520
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 21:39:32 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 621ED20043;
        Wed, 25 Jan 2023 21:39:32 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2EAAD20040;
        Wed, 25 Jan 2023 21:39:32 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.155.209.149])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 25 Jan 2023 21:39:32 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 21/24] bpf: btf: Add BTF_FMODEL_SIGNED_ARG flag
Date:   Wed, 25 Jan 2023 22:38:14 +0100
Message-Id: <20230125213817.1424447-22-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230125213817.1424447-1-iii@linux.ibm.com>
References: <20230125213817.1424447-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MI7ZpoWf9s5tiOndO_g4ozOSY0VB4mxI
X-Proofpoint-ORIG-GUID: MI7ZpoWf9s5tiOndO_g4ozOSY0VB4mxI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_13,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=987 impostorscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301250193
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
index 14a0264fac57..cf89504c8dda 100644
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

