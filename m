Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2106235A7
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 22:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiKIVUC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 16:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbiKIVUC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 16:20:02 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F9C317DF
        for <bpf@vger.kernel.org>; Wed,  9 Nov 2022 13:20:01 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9KWRQg005507
        for <bpf@vger.kernel.org>; Wed, 9 Nov 2022 13:20:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=Oa+FvLKeePjCM0Bs5FnU6oFps/r/BqeeRojKd+8rWBU=;
 b=aHQNl2sGaCWH4hWl7aHdfNijcJB5zQLtUjM9QLBR3zeOT3YuQhH6XTd+4Vrtd/X41lls
 8XbdvN0/FNoEyi6nFkTaf+/dSvLoUnK3lfU1bSU4S9nw3Pa3fBkJUbLZBIkHVAxv33iB
 LMcpHHjL7CVFqN6sSjgss0cHJEiKK3wpsQ0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3krh8r9err-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 09 Nov 2022 13:20:00 -0800
Received: from twshared14438.02.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 13:19:58 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id CE58B11E72E7E; Wed,  9 Nov 2022 13:19:54 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 2/7] bpf: Abstract out functions to check sleepable helpers
Date:   Wed, 9 Nov 2022 13:19:54 -0800
Message-ID: <20221109211954.3214540-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221109211944.3213817-1-yhs@fb.com>
References: <20221109211944.3213817-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: BE8cDvmu55NDh7nXZTLI9JKbvGvTyu3Y
X-Proofpoint-GUID: BE8cDvmu55NDh7nXZTLI9JKbvGvTyu3Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Abstract out two functions to check whether a particular helper
is sleepable or not for bpf_lsm and bpf_trace. These two
functions will be used later to check whether a helper is
sleepable or not in verifier. There is no functionality
change.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 include/linux/bpf_lsm.h      |  6 ++++++
 include/linux/trace_events.h |  8 ++++++++
 kernel/bpf/bpf_lsm.c         | 20 ++++++++++++++++----
 kernel/trace/bpf_trace.c     | 22 ++++++++++++++++++----
 4 files changed, 48 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
index 4bcf76a9bb06..d99b1caf118e 100644
--- a/include/linux/bpf_lsm.h
+++ b/include/linux/bpf_lsm.h
@@ -28,6 +28,7 @@ int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
 			const struct bpf_prog *prog);
=20
 bool bpf_lsm_is_sleepable_hook(u32 btf_id);
+const struct bpf_func_proto *bpf_lsm_sleepable_func_proto(enum bpf_func_=
id func_id);
=20
 static inline struct bpf_storage_blob *bpf_inode(
 	const struct inode *inode)
@@ -50,6 +51,11 @@ static inline bool bpf_lsm_is_sleepable_hook(u32 btf_i=
d)
 {
 	return false;
 }
+static inline const struct bpf_func_proto *
+bpf_lsm_sleepable_func_proto(enum bpf_func_id func_id)
+{
+	return NULL;
+}
=20
 static inline int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
 				      const struct bpf_prog *prog)
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 20749bd9db71..c3eb4fb78ea5 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -9,6 +9,7 @@
 #include <linux/hardirq.h>
 #include <linux/perf_event.h>
 #include <linux/tracepoint.h>
+#include <uapi/linux/bpf.h>
=20
 struct trace_array;
 struct array_buffer;
@@ -16,6 +17,7 @@ struct tracer;
 struct dentry;
 struct bpf_prog;
 union bpf_attr;
+struct bpf_func_proto;
=20
 const char *trace_print_flags_seq(struct trace_seq *p, const char *delim=
,
 				  unsigned long flags,
@@ -748,6 +750,7 @@ int bpf_get_perf_event_info(const struct perf_event *=
event, u32 *prog_id,
 			    u32 *fd_type, const char **buf,
 			    u64 *probe_offset, u64 *probe_addr);
 int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_=
prog *prog);
+const struct bpf_func_proto *bpf_tracing_sleepable_func_proto(enum bpf_f=
unc_id func_id);
 #else
 static inline unsigned int trace_call_bpf(struct trace_event_call *call,=
 void *ctx)
 {
@@ -794,6 +797,11 @@ bpf_kprobe_multi_link_attach(const union bpf_attr *a=
ttr, struct bpf_prog *prog)
 {
 	return -EOPNOTSUPP;
 }
+static inline const struct bpf_func_proto *
+bpf_tracing_sleepable_func_proto(enum bpf_func_id func_id)
+{
+	return NULL;
+}
 #endif
=20
 enum {
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index d6c9b3705f24..2f993a003389 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -192,6 +192,18 @@ static const struct bpf_func_proto bpf_get_attach_co=
okie_proto =3D {
 	.arg1_type	=3D ARG_PTR_TO_CTX,
 };
=20
+const struct bpf_func_proto *bpf_lsm_sleepable_func_proto(enum bpf_func_=
id func_id)
+{
+	switch (func_id) {
+	case BPF_FUNC_ima_inode_hash:
+		return &bpf_ima_inode_hash_proto;
+	case BPF_FUNC_ima_file_hash:
+		return &bpf_ima_file_hash_proto;
+	default:
+		return NULL;
+	}
+}
+
 static const struct bpf_func_proto *
 bpf_lsm_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog=
)
 {
@@ -203,6 +215,10 @@ bpf_lsm_func_proto(enum bpf_func_id func_id, const s=
truct bpf_prog *prog)
 			return func_proto;
 	}
=20
+	func_proto =3D bpf_lsm_sleepable_func_proto(func_id);
+	if (func_proto)
+		return prog->aux->sleepable ? func_proto : NULL;
+
 	switch (func_id) {
 	case BPF_FUNC_inode_storage_get:
 		return &bpf_inode_storage_get_proto;
@@ -220,10 +236,6 @@ bpf_lsm_func_proto(enum bpf_func_id func_id, const s=
truct bpf_prog *prog)
 		return &bpf_spin_unlock_proto;
 	case BPF_FUNC_bprm_opts_set:
 		return &bpf_bprm_opts_set_proto;
-	case BPF_FUNC_ima_inode_hash:
-		return prog->aux->sleepable ? &bpf_ima_inode_hash_proto : NULL;
-	case BPF_FUNC_ima_file_hash:
-		return prog->aux->sleepable ? &bpf_ima_file_hash_proto : NULL;
 	case BPF_FUNC_get_attach_cookie:
 		return bpf_prog_has_trampoline(prog) ? &bpf_get_attach_cookie_proto : =
NULL;
 #ifdef CONFIG_NET
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index f2d8d070d024..7804fa71d3f1 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1383,9 +1383,27 @@ static int __init bpf_key_sig_kfuncs_init(void)
 late_initcall(bpf_key_sig_kfuncs_init);
 #endif /* CONFIG_KEYS */
=20
+const struct bpf_func_proto *bpf_tracing_sleepable_func_proto(enum bpf_f=
unc_id func_id)
+{
+	switch (func_id) {
+	case BPF_FUNC_copy_from_user:
+		return &bpf_copy_from_user_proto;
+	case BPF_FUNC_copy_from_user_task:
+		return &bpf_copy_from_user_task_proto;
+	default:
+		return NULL;
+	}
+}
+
 static const struct bpf_func_proto *
 bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *=
prog)
 {
+	const struct bpf_func_proto *func_proto;
+
+	func_proto =3D bpf_tracing_sleepable_func_proto(func_id);
+	if (func_proto)
+		return prog->aux->sleepable ? func_proto : NULL;
+
 	switch (func_id) {
 	case BPF_FUNC_map_lookup_elem:
 		return &bpf_map_lookup_elem_proto;
@@ -1484,10 +1502,6 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, c=
onst struct bpf_prog *prog)
 		return &bpf_jiffies64_proto;
 	case BPF_FUNC_get_task_stack:
 		return &bpf_get_task_stack_proto;
-	case BPF_FUNC_copy_from_user:
-		return prog->aux->sleepable ? &bpf_copy_from_user_proto : NULL;
-	case BPF_FUNC_copy_from_user_task:
-		return prog->aux->sleepable ? &bpf_copy_from_user_task_proto : NULL;
 	case BPF_FUNC_snprintf_btf:
 		return &bpf_snprintf_btf_proto;
 	case BPF_FUNC_per_cpu_ptr:
--=20
2.30.2

