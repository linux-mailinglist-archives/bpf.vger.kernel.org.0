Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32DA617789
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 08:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiKCHVW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 03:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiKCHVV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 03:21:21 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E84B24
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 00:21:19 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A2NVteq010911
        for <bpf@vger.kernel.org>; Thu, 3 Nov 2022 00:21:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=lk6nibECkjxKLVSyqN3jvt+1HPzxY0CdZOqsrDPBEEE=;
 b=VIIvzE++LhowlYJqkLx7iJZNAz+csSIzIeVbBDWpO7JHEZBCI22gpa2zFm4twxz2Zlh0
 4IowyVn9VHxZwlV6sKvCc4vkbdpvVhyQw9qTMbPV9LMNzpTFbhFAV7vTq6AsAU4E1tPy
 4MR3FofNsHKuo0xE8u+sHr2YeqMiNeHf0GY= 
Received: from maileast.thefacebook.com ([163.114.130.3])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kkhkvuau1-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 03 Nov 2022 00:21:18 -0700
Received: from twshared9088.05.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 00:21:17 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 54B371192D062; Thu,  3 Nov 2022 00:21:13 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 2/5] bpf: Add bpf_rcu_read_lock/unlock helper
Date:   Thu, 3 Nov 2022 00:21:13 -0700
Message-ID: <20221103072113.2322563-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221103072102.2320490-1-yhs@fb.com>
References: <20221103072102.2320490-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: T2-JNi_zqPZEsOjt0Bb2Xk3oi_cFP5SF
X-Proofpoint-ORIG-GUID: T2-JNi_zqPZEsOjt0Bb2Xk3oi_cFP5SF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_15,2022-11-02_01,2022-06-22_01
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add bpf_rcu_read_lock() and bpf_rcu_read_unlock() helpers.
Both helpers are available to all program types with
CAP_BPF capability.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 include/linux/bpf.h            |  2 ++
 include/uapi/linux/bpf.h       | 14 ++++++++++++++
 kernel/bpf/core.c              |  2 ++
 kernel/bpf/helpers.c           | 26 ++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h | 14 ++++++++++++++
 5 files changed, 58 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 8d948bfcb984..a9bda4c91fc7 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2554,6 +2554,8 @@ extern const struct bpf_func_proto bpf_get_retval_p=
roto;
 extern const struct bpf_func_proto bpf_user_ringbuf_drain_proto;
 extern const struct bpf_func_proto bpf_cgrp_storage_get_proto;
 extern const struct bpf_func_proto bpf_cgrp_storage_delete_proto;
+extern const struct bpf_func_proto bpf_rcu_read_lock_proto;
+extern const struct bpf_func_proto bpf_rcu_read_unlock_proto;
=20
 const struct bpf_func_proto *tracing_prog_func_proto(
   enum bpf_func_id func_id, const struct bpf_prog *prog);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 94659f6b3395..e86389cd6133 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5481,6 +5481,18 @@ union bpf_attr {
  *		0 on success.
  *
  *		**-ENOENT** if the bpf_local_storage cannot be found.
+ *
+ * void bpf_rcu_read_lock(void)
+ *	Description
+ *		Call kernel rcu_read_lock().
+ *	Return
+ *		None.
+ *
+ * void bpf_rcu_read_unlock(void)
+ *	Description
+ *		Call kernel rcu_read_unlock().
+ *	Return
+ *		None.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
@@ -5695,6 +5707,8 @@ union bpf_attr {
 	FN(user_ringbuf_drain, 209, ##ctx)		\
 	FN(cgrp_storage_get, 210, ##ctx)		\
 	FN(cgrp_storage_delete, 211, ##ctx)		\
+	FN(rcu_read_lock, 212, ##ctx)			\
+	FN(rcu_read_unlock, 213, ##ctx)			\
 	/* */
=20
 /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that do=
n't
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 9c16338bcbe8..26858b579dfc 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2627,6 +2627,8 @@ const struct bpf_func_proto bpf_map_lookup_percpu_e=
lem_proto __weak;
 const struct bpf_func_proto bpf_spin_lock_proto __weak;
 const struct bpf_func_proto bpf_spin_unlock_proto __weak;
 const struct bpf_func_proto bpf_jiffies64_proto __weak;
+const struct bpf_func_proto bpf_rcu_read_lock_proto __weak;
+const struct bpf_func_proto bpf_rcu_read_unlock_proto __weak;
=20
 const struct bpf_func_proto bpf_get_prandom_u32_proto __weak;
 const struct bpf_func_proto bpf_get_smp_processor_id_proto __weak;
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 124fd199ce5c..f19416dc8ad1 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1273,6 +1273,28 @@ static const struct bpf_func_proto bpf_timer_start=
_proto =3D {
 	.arg3_type	=3D ARG_ANYTHING,
 };
=20
+BPF_CALL_0(bpf_rcu_read_lock) {
+	rcu_read_lock();
+	return 0;
+}
+
+const struct bpf_func_proto bpf_rcu_read_lock_proto =3D {
+	.func		=3D bpf_rcu_read_lock,
+	.gpl_only	=3D false,
+	.ret_type	=3D RET_VOID,
+};
+
+BPF_CALL_0(bpf_rcu_read_unlock) {
+	rcu_read_unlock();
+	return 0;
+}
+
+const struct bpf_func_proto bpf_rcu_read_unlock_proto =3D {
+	.func		=3D bpf_rcu_read_unlock,
+	.gpl_only	=3D false,
+	.ret_type	=3D RET_VOID,
+};
+
 static void drop_prog_refcnt(struct bpf_hrtimer *t)
 {
 	struct bpf_prog *prog =3D t->prog;
@@ -1627,6 +1649,10 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		return &bpf_spin_lock_proto;
 	case BPF_FUNC_spin_unlock:
 		return &bpf_spin_unlock_proto;
+	case BPF_FUNC_rcu_read_lock:
+		return &bpf_rcu_read_lock_proto;
+	case BPF_FUNC_rcu_read_unlock:
+		return &bpf_rcu_read_unlock_proto;
 	case BPF_FUNC_jiffies64:
 		return &bpf_jiffies64_proto;
 	case BPF_FUNC_per_cpu_ptr:
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 94659f6b3395..e86389cd6133 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5481,6 +5481,18 @@ union bpf_attr {
  *		0 on success.
  *
  *		**-ENOENT** if the bpf_local_storage cannot be found.
+ *
+ * void bpf_rcu_read_lock(void)
+ *	Description
+ *		Call kernel rcu_read_lock().
+ *	Return
+ *		None.
+ *
+ * void bpf_rcu_read_unlock(void)
+ *	Description
+ *		Call kernel rcu_read_unlock().
+ *	Return
+ *		None.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
@@ -5695,6 +5707,8 @@ union bpf_attr {
 	FN(user_ringbuf_drain, 209, ##ctx)		\
 	FN(cgrp_storage_get, 210, ##ctx)		\
 	FN(cgrp_storage_delete, 211, ##ctx)		\
+	FN(rcu_read_lock, 212, ##ctx)			\
+	FN(rcu_read_unlock, 213, ##ctx)			\
 	/* */
=20
 /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that do=
n't
--=20
2.30.2

