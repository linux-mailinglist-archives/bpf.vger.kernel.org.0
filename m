Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA4C6AFA58
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 00:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjCGX3k convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 7 Mar 2023 18:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjCGX3g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 18:29:36 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30580A8E8A
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 15:29:35 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 327M79Fd018195
        for <bpf@vger.kernel.org>; Tue, 7 Mar 2023 15:29:34 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3p6bu8sb8x-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 07 Mar 2023 15:29:34 -0800
Received: from twshared58712.02.prn6.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 7 Mar 2023 15:29:32 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 73E172985305C; Tue,  7 Mar 2023 15:29:22 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH v3 bpf-next 4/8] bpf: implement number iterator
Date:   Tue, 7 Mar 2023 15:29:09 -0800
Message-ID: <20230307232913.576893-5-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230307232913.576893-1-andrii@kernel.org>
References: <20230307232913.576893-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: QpTgBAh77NJB_lWqknE34W0j74rJOc-V
X-Proofpoint-ORIG-GUID: QpTgBAh77NJB_lWqknE34W0j74rJOc-V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_16,2023-03-07_01,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
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
    (that is, start is inclusive, end is exclusive).
  - bpf_iter_num_next() which will keep returning read-only pointer to int
    until the range is exhausted, at which point NULL will be returned.
    If bpf_iter_num_next() is kept calling after this, NULL will be
    persistently returned.
  - bpf_iter_num_destroy() destructor, which needs to be called at some
    point to clean up iterator state. BPF verifier enforces that iterator
    destructor is called at some point before BPF program exits.

Note that `start = end = X` is a valid combination to setup empty
iterator. bpf_iter_num_new() will return 0 (success) for any such
combination.

If bpf_iter_num_new() detects invalid combination of input arguments, it
returns error, resets iterator state to, effectively, empty iterator, so
any subsequent call to bpf_iter_num_next() will keep returning NULL.

BPF verifier has no knowledge that returned integers are in the
[start, end) value range, as both `start` and `end` are not statically
known/enforced, they are runtime values only.

While implementation is pretty trivial, some care needs to be taken to
avoid overflows and underflows. Subsequent selftests will validate
correctness of [start, end) semantics, especially around extremes
(INT_MIN and INT_MAX).

Similarly to bpf_loop(), we enforce that no more than BPF_MAX_LOOPS can
be specified.

bpf_iter_num_{new,next,destroy}() is a logical evolution from bounded
BPF loops and bpf_loop() helper and is the basis for implementing
ergonomic BPF loops with no statically known or verified bounds.
Subsequent patches implement bpf_for() macro, demonstrating how this can
be wrapped into something that works and feels like a normal for() loop
in C language.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf.h            |  8 +++-
 include/uapi/linux/bpf.h       |  8 ++++
 kernel/bpf/bpf_iter.c          | 70 ++++++++++++++++++++++++++++++++++
 kernel/bpf/helpers.c           |  3 ++
 tools/include/uapi/linux/bpf.h |  8 ++++
 5 files changed, 95 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 6792a7940e1e..e64ff1e89fb2 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1617,8 +1617,12 @@ struct bpf_array {
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
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 976b194eb775..bf8b77d9a17e 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7112,4 +7112,12 @@ enum {
 	BPF_F_TIMER_ABS = (1ULL << 0),
 };
 
+/* BPF numbers iterator state */
+struct bpf_iter_num {
+	/* opaque iterator state; having __u64 here allows to preserve correct
+	 * alignment requirements in vmlinux.h, generated from BTF
+	 */
+	__u64 __opaque[1];
+};
+
 #endif /* _UAPI__LINUX_BPF_H__ */
diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index 5dc307bdeaeb..96856f130cbf 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -776,3 +776,73 @@ const struct bpf_func_proto bpf_loop_proto = {
 	.arg3_type	= ARG_PTR_TO_STACK_OR_NULL,
 	.arg4_type	= ARG_ANYTHING,
 };
+
+struct bpf_iter_num_kern {
+	int cur; /* current value, inclusive */
+	int end; /* final value, exclusive */
+} __aligned(8);
+
+__diag_push();
+__diag_ignore_all("-Wmissing-prototypes",
+		  "Global functions as their definitions will be in vmlinux BTF");
+
+__bpf_kfunc int bpf_iter_num_new(struct bpf_iter_num *it, int start, int end)
+{
+	struct bpf_iter_num_kern *s = (void *)it;
+
+	BUILD_BUG_ON(sizeof(struct bpf_iter_num_kern) != sizeof(struct bpf_iter_num));
+	BUILD_BUG_ON(__alignof__(struct bpf_iter_num_kern) != __alignof__(struct bpf_iter_num));
+
+	BTF_TYPE_EMIT(struct btf_iter_num);
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
+__bpf_kfunc int *bpf_iter_num_next(struct bpf_iter_num* it)
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
+__bpf_kfunc void bpf_iter_num_destroy(struct bpf_iter_num *it)
+{
+	struct bpf_iter_num_kern *s = (void *)it;
+
+	s->cur = s->end = 0;
+}
+
+__diag_pop();
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 637ac4e92e75..f9b7eeedce08 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2411,6 +2411,9 @@ BTF_ID_FLAGS(func, bpf_rcu_read_lock)
 BTF_ID_FLAGS(func, bpf_rcu_read_unlock)
 BTF_ID_FLAGS(func, bpf_dynptr_slice, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_dynptr_slice_rdwr, KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_num_new, KF_ITER_NEW)
+BTF_ID_FLAGS(func, bpf_iter_num_next, KF_ITER_NEXT | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DESTROY)
 BTF_SET8_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 976b194eb775..bf8b77d9a17e 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7112,4 +7112,12 @@ enum {
 	BPF_F_TIMER_ABS = (1ULL << 0),
 };
 
+/* BPF numbers iterator state */
+struct bpf_iter_num {
+	/* opaque iterator state; having __u64 here allows to preserve correct
+	 * alignment requirements in vmlinux.h, generated from BTF
+	 */
+	__u64 __opaque[1];
+};
+
 #endif /* _UAPI__LINUX_BPF_H__ */
-- 
2.34.1

