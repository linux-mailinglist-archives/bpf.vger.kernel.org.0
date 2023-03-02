Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03BC6A8D4F
	for <lists+bpf@lfdr.de>; Fri,  3 Mar 2023 00:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjCBXu6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 2 Mar 2023 18:50:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjCBXu4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 18:50:56 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD26938E9D
        for <bpf@vger.kernel.org>; Thu,  2 Mar 2023 15:50:54 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 322KTZwF030242
        for <bpf@vger.kernel.org>; Thu, 2 Mar 2023 15:50:54 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3p30k9j75w-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 02 Mar 2023 15:50:53 -0800
Received: from ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) by
 ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 2 Mar 2023 15:50:52 -0800
Received: from twshared33736.38.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 2 Mar 2023 15:50:52 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 3C73C291B7F48; Thu,  2 Mar 2023 15:50:47 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next 14/17] bpf: implement number iterator
Date:   Thu, 2 Mar 2023 15:50:12 -0800
Message-ID: <20230302235015.2044271-15-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230302235015.2044271-1-andrii@kernel.org>
References: <20230302235015.2044271-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: iS1M1otvdxka3Fey9aldacnzsFaGzD1m
X-Proofpoint-ORIG-GUID: iS1M1otvdxka3Fey9aldacnzsFaGzD1m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_15,2023-03-02_02,2023-02-09_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Implement first open-coded iterator type over a range of integers.

It's public API consists of:
  - bpf_iter_num_new() constructor, which accepts [start, end) range
    (that is, start is inclusive, while end is exclusive).
  - bpf_iter_num_next() which will keep returning 4-byte read-only
    pointer to int until the range is exhausted, at which point NULL will
    be returned. If bpf_iter_num_next() is kept calling after this, NULL
    will be persistently returned.
  - bpf_iter_num_destroy() destructor, that needs to be called at some
    point to clean up iterator state. BPF verifier enforces that iterator
    destructor is called at some point before BPF program exits.

Note that `start = end = X` is a valid combination to setup empty
iterator. bpf_iter_num_new() will return 0 (success) for any such
combination.

If bpf_iter_num_new() detects invalid combination of input arguments, it
returns error, resets iterator state to, effectively, empty iterator, so
any subsequent call to bpf_iter_num_next() will keep returning NULL.

BPF verifier has no knowledge that returned integers are in the [start,
end) value range, as both `start` and `end` are not statically
known/enforced, they are runtime values only.

While implementation is pretty trivial, some care needs to be taken to
avoid overflows and underflows. Subsequent selftests will validate
correctness of [start, end) semantics, especially around extremes
(INT_MIN and INT_MAX).

Similarly to bpf_loop(), we enforce that no more than BPF_MAX_LOOPS can
be specified.

bpf_iter_num_{new,next,destroy}() is a logical evolution from bounded
BPF loops and bpf_loop() helper and is the basis for implementing
ergonomic BPF loops with no statically known and verified bounds.
Subsequent patches implement bpf_for() macro, demonstrating how this can
be wrapped into something that works and feels like a normal for() loop
in C language.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf.h   | 14 +++++++--
 kernel/bpf/bpf_iter.c | 71 +++++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/helpers.c  |  3 ++
 kernel/bpf/verifier.c | 24 +++++++++++++--
 4 files changed, 107 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a968282ba324..2a730759a471 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -613,6 +613,9 @@ enum bpf_type_flag {
 	/* DYNPTR points to xdp_buff */
 	DYNPTR_TYPE_XDP		= BIT(16 + BPF_BASE_TYPE_BITS),
 
+	/* ITER of integers */
+	ITER_TYPE_NUM		= BIT(17 + BPF_BASE_TYPE_BITS),
+
 	__BPF_TYPE_FLAG_MAX,
 	__BPF_TYPE_LAST_FLAG	= __BPF_TYPE_FLAG_MAX - 1,
 };
@@ -620,7 +623,7 @@ enum bpf_type_flag {
 #define DYNPTR_TYPE_FLAG_MASK	(DYNPTR_TYPE_LOCAL | DYNPTR_TYPE_RINGBUF | DYNPTR_TYPE_SKB \
 				 | DYNPTR_TYPE_XDP)
 
-#define ITER_TYPE_FLAG_MASK	(0)
+#define ITER_TYPE_FLAG_MASK	(ITER_TYPE_NUM)
 
 /* Max number of base types. */
 #define BPF_BASE_TYPE_LIMIT	(1UL << BPF_BASE_TYPE_BITS)
@@ -1167,6 +1170,7 @@ u32 bpf_dynptr_get_size(const struct bpf_dynptr_kern *ptr);
 
 enum bpf_iter_type {
 	BPF_ITER_TYPE_INVALID,
+	BPF_ITER_TYPE_NUM,
 };
 
 #ifdef CONFIG_BPF_JIT
@@ -1622,8 +1626,12 @@ struct bpf_array {
 #define BPF_COMPLEXITY_LIMIT_INSNS      1000000 /* yes. 1M insns */
 #define MAX_TAIL_CALL_CNT 33
 
-/* Maximum number of loops for bpf_loop */
-#define BPF_MAX_LOOPS	BIT(23)
+/* Maximum number of loops for bpf_loop and bpf_iter_num.
+ * It's enum to expose it (and thus make it discoverable) through BTF.
+ */
+enum {
+	BPF_MAX_LOOPS = 8 * 1024 * 1024,
+};
 
 #define BPF_F_ACCESS_MASK	(BPF_F_RDONLY |		\
 				 BPF_F_RDONLY_PROG |	\
diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index 5dc307bdeaeb..504189a3b474 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (c) 2020 Facebook */
 
+#include "linux/build_bug.h"
 #include <linux/fs.h>
 #include <linux/anon_inodes.h>
 #include <linux/filter.h>
@@ -776,3 +777,73 @@ const struct bpf_func_proto bpf_loop_proto = {
 	.arg3_type	= ARG_PTR_TO_STACK_OR_NULL,
 	.arg4_type	= ARG_ANYTHING,
 };
+
+struct bpf_iter_num_kern {
+	int cur; /* current value, inclusive */
+	int end; /* final value, exclusive */
+	__u64 :64;
+	__u64 :64;
+} __aligned(8);
+
+__diag_push();
+__diag_ignore_all("-Wmissing-prototypes",
+		  "Global functions as their definitions will be in vmlinux BTF");
+
+__bpf_kfunc int bpf_iter_num_new(struct bpf_iter *it__uninit, int start, int end)
+{
+	struct bpf_iter_num_kern *s = (void *)it__uninit;
+
+	BUILD_BUG_ON(sizeof(struct bpf_iter_num_kern) != sizeof(struct bpf_iter));
+	BUILD_BUG_ON(__alignof__(struct bpf_iter_num_kern) != __alignof__(struct bpf_iter));
+
+	/* start == end is legit, it's an empty range and we'll just get NULL
+	 * on first (and any subsequent) bpf_iter_num_next() call
+	 */
+	if (start > end) {
+		s->cur = s->end = 0;
+		return -EINVAL;
+	}
+
+	/* avoid overflows, e.g., if start == INT_MIN and end == INT_MAX */
+	if ((s64)end - (s64)start > BPF_MAX_LOOPS) {
+		s->cur = s->end = 0;
+		return -E2BIG;
+	}
+
+	/* user will call bpf_iter_num_next() first,
+	 * which will set s->cur to exactly start value;
+	 * underflow shouldn't matter
+	 */
+	s->cur = start - 1;
+	s->end = end;
+
+	return 0;
+}
+
+__bpf_kfunc int *bpf_iter_num_next(struct bpf_iter* it)
+{
+	struct bpf_iter_num_kern *s = (void *)it;
+
+	/* check failed initialization or if we are done (same behavior);
+	 * need to be careful about overflow, so convert to s64 for checks,
+	 * e.g., if s->cur == s->end == INT_MAX, we can't just do
+	 * s->cur + 1 >= s->end
+	 */
+	if ((s64)(s->cur + 1) >= s->end) {
+		s->cur = s->end = 0;
+		return NULL;
+	}
+
+	s->cur++;
+
+	return &s->cur;
+}
+
+__bpf_kfunc void bpf_iter_num_destroy(struct bpf_iter *it)
+{
+	struct bpf_iter_num_kern *s = (void *)it;
+
+	s->cur = s->end = 0;
+}
+
+__diag_pop();
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index de9ef8476e29..23c8f2313d5a 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2398,6 +2398,9 @@ BTF_ID_FLAGS(func, bpf_rcu_read_lock)
 BTF_ID_FLAGS(func, bpf_rcu_read_unlock)
 BTF_ID_FLAGS(func, bpf_dynptr_slice, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_dynptr_slice_rdwr, KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_num_new)
+BTF_ID_FLAGS(func, bpf_iter_num_next, KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_num_destroy)
 BTF_SET8_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 58754929ee33..9671b4f354e9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -779,6 +779,8 @@ static const char *dynptr_type_str(enum bpf_dynptr_type type)
 static const char *iter_type_str(enum bpf_iter_type type)
 {
 	switch (type) {
+	case BPF_ITER_TYPE_NUM:
+		return "num";
 	case BPF_ITER_TYPE_INVALID:
 		return "<invalid>";
 	default:
@@ -1157,6 +1159,8 @@ static bool is_dynptr_type_expected(struct bpf_verifier_env *env, struct bpf_reg
 static enum bpf_dynptr_type arg_to_iter_type(enum bpf_arg_type arg_type)
 {
 	switch (arg_type & ITER_TYPE_FLAG_MASK) {
+	case ITER_TYPE_NUM:
+		return BPF_ITER_TYPE_NUM;
 	default:
 		return BPF_ITER_TYPE_INVALID;
 	}
@@ -9445,6 +9449,9 @@ enum special_kfunc_type {
 	KF_bpf_dynptr_from_xdp,
 	KF_bpf_dynptr_slice,
 	KF_bpf_dynptr_slice_rdwr,
+	KF_bpf_iter_num_new,
+	KF_bpf_iter_num_next,
+	KF_bpf_iter_num_destroy,
 };
 
 BTF_SET_START(special_kfunc_set)
@@ -9483,6 +9490,9 @@ BTF_ID(func, bpf_dynptr_from_skb)
 BTF_ID(func, bpf_dynptr_from_xdp)
 BTF_ID(func, bpf_dynptr_slice)
 BTF_ID(func, bpf_dynptr_slice_rdwr)
+BTF_ID(func, bpf_iter_num_new)
+BTF_ID(func, bpf_iter_num_next)
+BTF_ID(func, bpf_iter_num_destroy)
 
 static bool is_kfunc_bpf_rcu_read_lock(struct bpf_kfunc_call_arg_meta *meta)
 {
@@ -9496,7 +9506,7 @@ static bool is_kfunc_bpf_rcu_read_unlock(struct bpf_kfunc_call_arg_meta *meta)
 
 static bool is_iter_next_kfunc(int btf_id)
 {
-	return false;
+	return btf_id == special_kfunc_list[KF_bpf_iter_num_next];
 }
 
 static enum kfunc_ptr_arg_type
@@ -10278,7 +10288,17 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			if (is_kfunc_arg_uninit(btf, &args[i]))
 				iter_arg_type |= MEM_UNINIT;
 
-			ret = process_iter_arg(env, regno, insn_idx, iter_arg_type,  meta);
+			if (meta->func_id == special_kfunc_list[KF_bpf_iter_num_new] ||
+			    meta->func_id == special_kfunc_list[KF_bpf_iter_num_next]) {
+				iter_arg_type |= ITER_TYPE_NUM;
+			} else if (meta->func_id == special_kfunc_list[KF_bpf_iter_num_destroy]) {
+				iter_arg_type |= ITER_TYPE_NUM | OBJ_RELEASE;
+			} else {
+				verbose(env, "verifier internal error: unrecognized iterator kfunc\n");
+				return -EFAULT;
+			}
+
+			ret = process_iter_arg(env, regno, insn_idx, iter_arg_type, meta);
 			if (ret < 0)
 				return ret;
 			break;
-- 
2.30.2

