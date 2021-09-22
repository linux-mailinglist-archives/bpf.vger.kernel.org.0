Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5B441516C
	for <lists+bpf@lfdr.de>; Wed, 22 Sep 2021 22:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237487AbhIVUeE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 22 Sep 2021 16:34:04 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:58480 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237309AbhIVUeD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 22 Sep 2021 16:34:03 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18MIlSj2000986
        for <bpf@vger.kernel.org>; Wed, 22 Sep 2021 13:32:33 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3b7q54fx69-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 22 Sep 2021 13:32:32 -0700
Received: from intmgw001.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 22 Sep 2021 13:32:31 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id AF72E4B04EBA; Wed, 22 Sep 2021 13:32:29 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <kafai@fb.com>, <joannekoong@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH RFC bpf-next 1/4] bpf: add bpf_jhash_mem BPF helper
Date:   Wed, 22 Sep 2021 13:32:21 -0700
Message-ID: <20210922203224.912809-2-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210922203224.912809-1-andrii@kernel.org>
References: <20210922203224.912809-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: lJNo1WsJZ0JEjsMC1cwgmHaj00D1dhNh
X-Proofpoint-GUID: lJNo1WsJZ0JEjsMC1cwgmHaj00D1dhNh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-22_08,2021-09-22_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 clxscore=1015 phishscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109220133
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add BPF helper that allows to calculate jhash of arbitrary (initialized)
memory slice.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/uapi/linux/bpf.h       |  8 ++++++++
 kernel/bpf/helpers.c           | 23 +++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  8 ++++++++
 3 files changed, 39 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 2e3048488feb..7b17e46b0be2 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -4913,6 +4913,13 @@ union bpf_attr {
  *	Return
  *		The number of bytes written to the buffer, or a negative error
  *		in case of failure.
+ *
+ * u64 bpf_jhash_mem(const void *data, u32 sz, u32 seed)
+ *	Description
+ *		Calculate jhash of a given memory slice.
+ *
+ *	Return
+ *		Calculated hash value.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5093,6 +5100,7 @@ union bpf_attr {
 	FN(task_pt_regs),		\
 	FN(get_branch_snapshot),	\
 	FN(trace_vprintk),		\
+	FN(jhash_mem),			\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 2c604ff8c7fb..00fb1b69595c 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -15,9 +15,30 @@
 #include <linux/pid_namespace.h>
 #include <linux/proc_ns.h>
 #include <linux/security.h>
+#include <linux/jhash.h>
 
 #include "../../lib/kstrtox.h"
 
+BPF_CALL_3(bpf_jhash_mem, const void *, data, u32, sz, u32, seed)
+{
+	if (unlikely((uintptr_t)data % 4 || sz % 4))
+		return jhash(data, sz, seed);
+
+	/* optimized 4-byte version */
+	return jhash2(data, sz / 4, seed);
+}
+
+
+static const struct bpf_func_proto bpf_jhash_mem_proto = {
+	.func		= bpf_jhash_mem,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_CONST_SIZE_OR_ZERO,
+	.arg3_type	= ARG_ANYTHING,
+};
+
+
 /* If kernel subsystem is allowing eBPF programs to call this function,
  * inside its own verifier_ops->get_func_proto() callback it should return
  * bpf_map_lookup_elem_proto, so that verifier can properly check the arguments
@@ -1341,6 +1362,8 @@ const struct bpf_func_proto *
 bpf_base_func_proto(enum bpf_func_id func_id)
 {
 	switch (func_id) {
+	case BPF_FUNC_jhash_mem:
+		return &bpf_jhash_mem_proto;
 	case BPF_FUNC_map_lookup_elem:
 		return &bpf_map_lookup_elem_proto;
 	case BPF_FUNC_map_update_elem:
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 2e3048488feb..7b17e46b0be2 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -4913,6 +4913,13 @@ union bpf_attr {
  *	Return
  *		The number of bytes written to the buffer, or a negative error
  *		in case of failure.
+ *
+ * u64 bpf_jhash_mem(const void *data, u32 sz, u32 seed)
+ *	Description
+ *		Calculate jhash of a given memory slice.
+ *
+ *	Return
+ *		Calculated hash value.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5093,6 +5100,7 @@ union bpf_attr {
 	FN(task_pt_regs),		\
 	FN(get_branch_snapshot),	\
 	FN(trace_vprintk),		\
+	FN(jhash_mem),			\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
-- 
2.30.2

