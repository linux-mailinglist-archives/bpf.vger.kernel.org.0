Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B988C6E55B3
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 02:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjDRAWJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 17 Apr 2023 20:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjDRAWI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Apr 2023 20:22:08 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9763AB3
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 17:22:04 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33HNwlkA019870
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 17:22:04 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3q1g8683hw-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 17:22:04 -0700
Received: from twshared52232.38.frc1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 17 Apr 2023 17:22:03 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 4D0102E4F359D; Mon, 17 Apr 2023 17:21:59 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 5/6] libbpf: move bpf_for(), bpf_for_each(), and bpf_repeat() into bpf_helpers.h
Date:   Mon, 17 Apr 2023 17:21:47 -0700
Message-ID: <20230418002148.3255690-6-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230418002148.3255690-1-andrii@kernel.org>
References: <20230418002148.3255690-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: JYHjx7DDO_wS0fweITBdSwifySXldGSO
X-Proofpoint-ORIG-GUID: JYHjx7DDO_wS0fweITBdSwifySXldGSO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_14,2023-04-17_01,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

To make it easier for bleeding-edge BPF applications, such as sched_ext,
to utilize open-coded iterators, move bpf_for(), bpf_for_each(), and
bpf_repeat() macros from selftests/bpf-internal bpf_misc.h helper, to
libbpf-provided bpf_helpers.h header.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf_helpers.h                  | 103 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/bpf_misc.h | 103 -------------------
 2 files changed, 103 insertions(+), 103 deletions(-)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index e7e1a8acc299..525dec66c129 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -291,4 +291,107 @@ enum libbpf_tristate {
 /* Helper macro to print out debug messages */
 #define bpf_printk(fmt, args...) ___bpf_pick_printk(args)(fmt, ##args)
 
+struct bpf_iter_num;
+
+extern int bpf_iter_num_new(struct bpf_iter_num *it, int start, int end) __ksym;
+extern int *bpf_iter_num_next(struct bpf_iter_num *it) __ksym;
+extern void bpf_iter_num_destroy(struct bpf_iter_num *it) __ksym;
+
+#ifndef bpf_for_each
+/* bpf_for_each(iter_type, cur_elem, args...) provides generic construct for
+ * using BPF open-coded iterators without having to write mundane explicit
+ * low-level loop logic. Instead, it provides for()-like generic construct
+ * that can be used pretty naturally. E.g., for some hypothetical cgroup
+ * iterator, you'd write:
+ *
+ * struct cgroup *cg, *parent_cg = <...>;
+ *
+ * bpf_for_each(cgroup, cg, parent_cg, CG_ITER_CHILDREN) {
+ *     bpf_printk("Child cgroup id = %d", cg->cgroup_id);
+ *     if (cg->cgroup_id == 123)
+ *         break;
+ * }
+ *
+ * I.e., it looks almost like high-level for each loop in other languages,
+ * supports continue/break, and is verifiable by BPF verifier.
+ *
+ * For iterating integers, the difference betwen bpf_for_each(num, i, N, M)
+ * and bpf_for(i, N, M) is in that bpf_for() provides additional proof to
+ * verifier that i is in [N, M) range, and in bpf_for_each() case i is `int
+ * *`, not just `int`. So for integers bpf_for() is more convenient.
+ *
+ * Note: this macro relies on C99 feature of allowing to declare variables
+ * inside for() loop, bound to for() loop lifetime. It also utilizes GCC
+ * extension: __attribute__((cleanup(<func>))), supported by both GCC and
+ * Clang.
+ */
+#define bpf_for_each(type, cur, args...) for (							\
+	/* initialize and define destructor */							\
+	struct bpf_iter_##type ___it __attribute__((aligned(8), /* enforce, just in case */,	\
+						    cleanup(bpf_iter_##type##_destroy))),	\
+	/* ___p pointer is just to call bpf_iter_##type##_new() *once* to init ___it */		\
+			       *___p __attribute__((unused)) = (				\
+					bpf_iter_##type##_new(&___it, ##args),			\
+	/* this is a workaround for Clang bug: it currently doesn't emit BTF */			\
+	/* for bpf_iter_##type##_destroy() when used from cleanup() attribute */		\
+					(void)bpf_iter_##type##_destroy, (void *)0);		\
+	/* iteration and termination check */							\
+	(((cur) = bpf_iter_##type##_next(&___it)));						\
+)
+#endif /* bpf_for_each */
+
+#ifndef bpf_for
+/* bpf_for(i, start, end) implements a for()-like looping construct that sets
+ * provided integer variable *i* to values starting from *start* through,
+ * but not including, *end*. It also proves to BPF verifier that *i* belongs
+ * to range [start, end), so this can be used for accessing arrays without
+ * extra checks.
+ *
+ * Note: *start* and *end* are assumed to be expressions with no side effects
+ * and whose values do not change throughout bpf_for() loop execution. They do
+ * not have to be statically known or constant, though.
+ *
+ * Note: similarly to bpf_for_each(), it relies on C99 feature of declaring for()
+ * loop bound variables and cleanup attribute, supported by GCC and Clang.
+ */
+#define bpf_for(i, start, end) for (								\
+	/* initialize and define destructor */							\
+	struct bpf_iter_num ___it __attribute__((aligned(8), /* enforce, just in case */	\
+						 cleanup(bpf_iter_num_destroy))),		\
+	/* ___p pointer is necessary to call bpf_iter_num_new() *once* to init ___it */		\
+			    *___p __attribute__((unused)) = (					\
+				bpf_iter_num_new(&___it, (start), (end)),			\
+	/* this is a workaround for Clang bug: it currently doesn't emit BTF */			\
+	/* for bpf_iter_num_destroy() when used from cleanup() attribute */			\
+				(void)bpf_iter_num_destroy, (void *)0);				\
+	({											\
+		/* iteration step */								\
+		int *___t = bpf_iter_num_next(&___it);						\
+		/* termination and bounds check */						\
+		(___t && ((i) = *___t, (i) >= (start) && (i) < (end)));				\
+	});											\
+)
+#endif /* bpf_for */
+
+#ifndef bpf_repeat
+/* bpf_repeat(N) performs N iterations without exposing iteration number
+ *
+ * Note: similarly to bpf_for_each(), it relies on C99 feature of declaring for()
+ * loop bound variables and cleanup attribute, supported by GCC and Clang.
+ */
+#define bpf_repeat(N) for (									\
+	/* initialize and define destructor */							\
+	struct bpf_iter_num ___it __attribute__((aligned(8), /* enforce, just in case */	\
+						 cleanup(bpf_iter_num_destroy))),		\
+	/* ___p pointer is necessary to call bpf_iter_num_new() *once* to init ___it */		\
+			    *___p __attribute__((unused)) = (					\
+				bpf_iter_num_new(&___it, 0, (N)),				\
+	/* this is a workaround for Clang bug: it currently doesn't emit BTF */			\
+	/* for bpf_iter_num_destroy() when used from cleanup() attribute */			\
+				(void)bpf_iter_num_destroy, (void *)0);				\
+	bpf_iter_num_next(&___it);								\
+	/* nothing here  */									\
+)
+#endif /* bpf_repeat */
+
 #endif
diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index 6e3b4903c541..3b307de8dab9 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -121,107 +121,4 @@
 /* make it look to compiler like value is read and written */
 #define __sink(expr) asm volatile("" : "+g"(expr))
 
-struct bpf_iter_num;
-
-extern int bpf_iter_num_new(struct bpf_iter_num *it, int start, int end) __ksym;
-extern int *bpf_iter_num_next(struct bpf_iter_num *it) __ksym;
-extern void bpf_iter_num_destroy(struct bpf_iter_num *it) __ksym;
-
-#ifndef bpf_for_each
-/* bpf_for_each(iter_type, cur_elem, args...) provides generic construct for
- * using BPF open-coded iterators without having to write mundane explicit
- * low-level loop logic. Instead, it provides for()-like generic construct
- * that can be used pretty naturally. E.g., for some hypothetical cgroup
- * iterator, you'd write:
- *
- * struct cgroup *cg, *parent_cg = <...>;
- *
- * bpf_for_each(cgroup, cg, parent_cg, CG_ITER_CHILDREN) {
- *     bpf_printk("Child cgroup id = %d", cg->cgroup_id);
- *     if (cg->cgroup_id == 123)
- *         break;
- * }
- *
- * I.e., it looks almost like high-level for each loop in other languages,
- * supports continue/break, and is verifiable by BPF verifier.
- *
- * For iterating integers, the difference betwen bpf_for_each(num, i, N, M)
- * and bpf_for(i, N, M) is in that bpf_for() provides additional proof to
- * verifier that i is in [N, M) range, and in bpf_for_each() case i is `int
- * *`, not just `int`. So for integers bpf_for() is more convenient.
- *
- * Note: this macro relies on C99 feature of allowing to declare variables
- * inside for() loop, bound to for() loop lifetime. It also utilizes GCC
- * extension: __attribute__((cleanup(<func>))), supported by both GCC and
- * Clang.
- */
-#define bpf_for_each(type, cur, args...) for (							\
-	/* initialize and define destructor */							\
-	struct bpf_iter_##type ___it __attribute__((aligned(8), /* enforce, just in case */,	\
-						    cleanup(bpf_iter_##type##_destroy))),	\
-	/* ___p pointer is just to call bpf_iter_##type##_new() *once* to init ___it */		\
-			       *___p __attribute__((unused)) = (				\
-					bpf_iter_##type##_new(&___it, ##args),			\
-	/* this is a workaround for Clang bug: it currently doesn't emit BTF */			\
-	/* for bpf_iter_##type##_destroy() when used from cleanup() attribute */		\
-					(void)bpf_iter_##type##_destroy, (void *)0);		\
-	/* iteration and termination check */							\
-	(((cur) = bpf_iter_##type##_next(&___it)));						\
-)
-#endif /* bpf_for_each */
-
-#ifndef bpf_for
-/* bpf_for(i, start, end) implements a for()-like looping construct that sets
- * provided integer variable *i* to values starting from *start* through,
- * but not including, *end*. It also proves to BPF verifier that *i* belongs
- * to range [start, end), so this can be used for accessing arrays without
- * extra checks.
- *
- * Note: *start* and *end* are assumed to be expressions with no side effects
- * and whose values do not change throughout bpf_for() loop execution. They do
- * not have to be statically known or constant, though.
- *
- * Note: similarly to bpf_for_each(), it relies on C99 feature of declaring for()
- * loop bound variables and cleanup attribute, supported by GCC and Clang.
- */
-#define bpf_for(i, start, end) for (								\
-	/* initialize and define destructor */							\
-	struct bpf_iter_num ___it __attribute__((aligned(8), /* enforce, just in case */	\
-						 cleanup(bpf_iter_num_destroy))),		\
-	/* ___p pointer is necessary to call bpf_iter_num_new() *once* to init ___it */		\
-			    *___p __attribute__((unused)) = (					\
-				bpf_iter_num_new(&___it, (start), (end)),			\
-	/* this is a workaround for Clang bug: it currently doesn't emit BTF */			\
-	/* for bpf_iter_num_destroy() when used from cleanup() attribute */			\
-				(void)bpf_iter_num_destroy, (void *)0);				\
-	({											\
-		/* iteration step */								\
-		int *___t = bpf_iter_num_next(&___it);						\
-		/* termination and bounds check */						\
-		(___t && ((i) = *___t, (i) >= (start) && (i) < (end)));				\
-	});											\
-)
-#endif /* bpf_for */
-
-#ifndef bpf_repeat
-/* bpf_repeat(N) performs N iterations without exposing iteration number
- *
- * Note: similarly to bpf_for_each(), it relies on C99 feature of declaring for()
- * loop bound variables and cleanup attribute, supported by GCC and Clang.
- */
-#define bpf_repeat(N) for (									\
-	/* initialize and define destructor */							\
-	struct bpf_iter_num ___it __attribute__((aligned(8), /* enforce, just in case */	\
-						 cleanup(bpf_iter_num_destroy))),		\
-	/* ___p pointer is necessary to call bpf_iter_num_new() *once* to init ___it */		\
-			    *___p __attribute__((unused)) = (					\
-				bpf_iter_num_new(&___it, 0, (N)),				\
-	/* this is a workaround for Clang bug: it currently doesn't emit BTF */			\
-	/* for bpf_iter_num_destroy() when used from cleanup() attribute */			\
-				(void)bpf_iter_num_destroy, (void *)0);				\
-	bpf_iter_num_next(&___it);								\
-	/* nothing here  */									\
-)
-#endif /* bpf_repeat */
-
 #endif
-- 
2.34.1

