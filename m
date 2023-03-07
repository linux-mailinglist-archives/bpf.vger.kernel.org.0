Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFE56AF80D
	for <lists+bpf@lfdr.de>; Tue,  7 Mar 2023 22:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjCGVyD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 7 Mar 2023 16:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbjCGVxt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 16:53:49 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06DB99647
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 13:53:47 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 327KgP2v009396
        for <bpf@vger.kernel.org>; Tue, 7 Mar 2023 13:53:47 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3p5vdppy21-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 07 Mar 2023 13:53:46 -0800
Received: from twshared58712.02.prn6.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 7 Mar 2023 13:53:44 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 28C1929835389; Tue,  7 Mar 2023 13:53:35 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH v2 bpf-next 2/8] bpf: add iterator kfuncs registration and validation logic
Date:   Tue, 7 Mar 2023 13:53:23 -0800
Message-ID: <20230307215329.3895377-3-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230307215329.3895377-1-andrii@kernel.org>
References: <20230307215329.3895377-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: aacylkySZRSQuAg7-1_iWwlPRLbyN93I
X-Proofpoint-ORIG-GUID: aacylkySZRSQuAg7-1_iWwlPRLbyN93I
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

Add ability to register kfuncs that implement BPF open-coded iterator
contract and enforce naming and function proto convention. Enforcement
is happing at the time of kfunc registration and is significantly
simplifies the rest of iterators logic in verifier.

More details follow in subsequent patches, but we recognize and enforce
the following conditions.

All kfuncs (constructor, next, destructor) have to be named consistenly
as bpf_iter_<type>_{new,next,destroy(), respectively. <type> represents
iterator type, and iterator's state should be represented as matching
`struct bpf_iter_<type>` state type. Also, all iter kfuncs should have
a pointer to this `struct bpf_iter_<type>` as a very first argument.

Additionally:
  - Constructor, i.e., bpf_iter_<type>_new(), can have arbitrary extra
  number of arguments. Return type not enforced either.
  - Next method, i.e., bpf_iter_<type>_next(), has to return a pointer
  type and should have exactly one argument: `struct bpf_iter_<type> *`
  (const/volatile/restrict and typedefs are ignored).
  - Destructor, i.e., bpf_iter_<type>_destroy(), should return void and
  should have exactly one argument, similar to next method.
  - struct bpf_iter_<type> size is enforced to be positive and
  a multiple of 8 bytes (to fit stack slots correctly).

Such strictness and consistency allows to build generic helpers
abstracting important, but boilerplate, details to be able to use
open-coded iterators effectively and ergonomically. It also simplifies
verifier logic in some places.  At the same time, this doesn't hurt
generality of possible iterator implementations. Win-win.

Constructor kfunc is marked with a new KF_ITER_NEW flags, next method is marked
with KF_ITER_NEXT (and should also have KF_RET_NULL, of course), while
destructor kfunc is marked as KF_ITER_DESTROY.

Additionally, we add a trivial kfunc name validation, it should be
a valid non-NULL and non-empty string.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf_verifier.h |   2 +
 include/linux/btf.h          |   4 ++
 kernel/bpf/btf.c             | 112 ++++++++++++++++++++++++++++++++++-
 3 files changed, 117 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 18538bad2b8c..e2dc7f064449 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -59,6 +59,8 @@ struct bpf_active_lock {
 	u32 id;
 };
 
+#define ITER_PREFIX "bpf_iter_"
+
 struct bpf_reg_state {
 	/* Ordering of fields matters.  See states_equal() */
 	enum bpf_reg_type type;
diff --git a/include/linux/btf.h b/include/linux/btf.h
index 556b3e2e7471..1bba0827e8c4 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -71,6 +71,10 @@
 #define KF_SLEEPABLE    (1 << 5) /* kfunc may sleep */
 #define KF_DESTRUCTIVE  (1 << 6) /* kfunc performs destructive actions */
 #define KF_RCU          (1 << 7) /* kfunc takes either rcu or trusted pointer arguments */
+/* only one of KF_ITER_{NEW,NEXT,DESTROY} could be specified per kfunc */
+#define KF_ITER_NEW     (1 << 8) /* kfunc implements BPF iter constructor */
+#define KF_ITER_NEXT    (1 << 9) /* kfunc implements BPF iter next method */
+#define KF_ITER_DESTROY (1 << 10) /* kfunc implements BPF iter destructor */
 
 /*
  * Tag marking a kernel function as a kfunc. This is meant to minimize the
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index a8cb09e5973b..71758cd15b07 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7596,6 +7596,108 @@ BTF_ID_LIST_GLOBAL(btf_tracing_ids, MAX_BTF_TRACING_TYPE)
 BTF_TRACING_TYPE_xxx
 #undef BTF_TRACING_TYPE
 
+static int btf_check_iter_kfuncs(struct btf *btf, const char *func_name,
+				 const struct btf_type *func, u32 func_flags)
+{
+	u32 flags = func_flags & (KF_ITER_NEW | KF_ITER_NEXT | KF_ITER_DESTROY);
+	const char *name, *sfx, *iter_name;
+	const struct btf_param *arg;
+	const struct btf_type *t;
+	char exp_name[128];
+	u32 nr_args;
+
+	/* exactly one of KF_ITER_{NEW,NEXT,DESTROY} can be set */
+	if (!flags || (flags & (flags - 1)))
+		return -EINVAL;
+
+	/* any BPF iter kfunc should have `struct bpf_iter_<type> *` first arg */
+	nr_args = btf_type_vlen(func);
+	if (nr_args < 1)
+		return -EINVAL;
+
+	arg = &btf_params(func)[0];
+	t = btf_type_skip_modifiers(btf, arg->type, NULL);
+	if (!t || !btf_type_is_ptr(t))
+		return -EINVAL;
+	t = btf_type_skip_modifiers(btf, t->type, NULL);
+	if (!t || !__btf_type_is_struct(t))
+		return -EINVAL;
+
+	name = btf_name_by_offset(btf, t->name_off);
+	if (!name || strncmp(name, ITER_PREFIX, sizeof(ITER_PREFIX) - 1))
+		return -EINVAL;
+
+	/* sizeof(struct bpf_iter_<type>) should be a multiple of 8 to
+	 * fit nicely in stack slots
+	 */
+	if (t->size == 0 || (t->size % 8))
+		return -EINVAL;
+
+	/* validate bpf_iter_<type>_{new,next,destroy}(struct bpf_iter_<type> *)
+	 * naming pattern
+	 */
+	iter_name = name + sizeof(ITER_PREFIX) - 1;
+	if (flags & KF_ITER_NEW)
+		sfx = "new";
+	else if (flags & KF_ITER_NEXT)
+		sfx = "next";
+	else /* (flags & KF_ITER_DESTROY) */
+		sfx = "destroy";
+
+	snprintf(exp_name, sizeof(exp_name), "bpf_iter_%s_%s", iter_name, sfx);
+	if (strcmp(func_name, exp_name))
+		return -EINVAL;
+
+	/* only iter constructor should have extra arguments */
+	if (!(flags & KF_ITER_NEW) && nr_args != 1)
+		return -EINVAL;
+
+	if (flags & KF_ITER_NEXT) {
+		/* bpf_iter_<type>_next() should return pointer */
+		t = btf_type_skip_modifiers(btf, func->type, NULL);
+		if (!t || !btf_type_is_ptr(t))
+			return -EINVAL;
+	}
+
+	if (flags & KF_ITER_DESTROY) {
+		/* bpf_iter_<type>_destroy() should return void */
+		t = btf_type_by_id(btf, func->type);
+		if (!t || !btf_type_is_void(t))
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int btf_check_kfunc_protos(struct btf *btf, u32 func_id, u32 func_flags)
+{
+	const struct btf_type *func;
+	const char *func_name;
+	int err;
+
+	/* any kfunc should be FUNC -> FUNC_PROTO */
+	func = btf_type_by_id(btf, func_id);
+	if (!func || !btf_type_is_func(func))
+		return -EINVAL;
+
+	/* sanity check kfunc name */
+	func_name = btf_name_by_offset(btf, func->name_off);
+	if (!func_name || !func_name[0])
+		return -EINVAL;
+
+	func = btf_type_by_id(btf, func->type);
+	if (!func || !btf_type_is_func_proto(func))
+		return -EINVAL;
+
+	if (func_flags & (KF_ITER_NEW | KF_ITER_NEXT | KF_ITER_DESTROY)) {
+		err = btf_check_iter_kfuncs(btf, func_name, func, func_flags);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 /* Kernel Function (kfunc) BTF ID set registration API */
 
 static int btf_populate_kfunc_set(struct btf *btf, enum btf_kfunc_hook hook,
@@ -7772,7 +7874,7 @@ static int __register_btf_kfunc_id_set(enum btf_kfunc_hook hook,
 				       const struct btf_kfunc_id_set *kset)
 {
 	struct btf *btf;
-	int ret;
+	int ret, i;
 
 	btf = btf_get_module_btf(kset->owner);
 	if (!btf) {
@@ -7789,7 +7891,15 @@ static int __register_btf_kfunc_id_set(enum btf_kfunc_hook hook,
 	if (IS_ERR(btf))
 		return PTR_ERR(btf);
 
+	for (i = 0; i < kset->set->cnt; i++) {
+		ret = btf_check_kfunc_protos(btf, kset->set->pairs[i].id,
+					     kset->set->pairs[i].flags);
+		if (ret)
+			goto err_out;
+	}
+
 	ret = btf_populate_kfunc_set(btf, hook, kset->set);
+err_out:
 	btf_put(btf);
 	return ret;
 }
-- 
2.34.1

