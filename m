Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14ACB6593F7
	for <lists+bpf@lfdr.de>; Fri, 30 Dec 2022 02:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbiL3BHs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Dec 2022 20:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiL3BHr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Dec 2022 20:07:47 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45671705B
        for <bpf@vger.kernel.org>; Thu, 29 Dec 2022 17:07:46 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id k19so5929036pfg.11
        for <bpf@vger.kernel.org>; Thu, 29 Dec 2022 17:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W20478hl5+mrzEXLvLMqsl7lQO/ew9iFmjTIvPpJMuU=;
        b=EqkAoClqCq2LZOoWh3Gp95TEV/l1Bk2Z9zPY78q2zHm/Ijhy4GcLAwMuAdpa7c6enV
         fcRufFtn4CFwqzgIWsilrQihLMUg8tcUjE2uc2fnLAXHZRlxCGrco4WqvNWMzmdA0J5l
         zgkC0NGx9dwtOYjIZhhuZPMWTAUgb4J+JSAwcLqU7OV1kxJMSfftRZSj3svjLsK+ROZm
         0p0/xNgIlpkSsjnvVPqvtj2GQ2qE1JmSKV/M77DJyMt+fe64LbkpArzruYPH29G1Ov1K
         RHZrmjmIvxB3aDKGshK2a5KZ+5eAuEzJPH83onj/JO0lIOicf+87IX2zvxKDVmtiaeMQ
         KSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W20478hl5+mrzEXLvLMqsl7lQO/ew9iFmjTIvPpJMuU=;
        b=3wqQxpcsZFOc/M8Qk30eJOfn9jrggL+BORt7DBUAEtRrCKwM+zm9yr35EFVFWCYBZ8
         GFp1XFRHljkZtoqrfC0AK8zqaMOwpPClP8lKBhoHxCE7L1Tp/FQFs3UokfQVcHj1z4Da
         F8wpfyRSlDZRPzVXAeldx7lU+eZC1PMi9ryoVbSNRO5E7xOCHtUgStmM/zlzggRwi0pS
         owTrrOr4kb7HSiKEvPzkP89jdWyRHbGe9v86cDg5NjDaFd80DZv+NjuaotJSN1zISSTx
         rLAK8mWwXbQtcCa0LBB1Tg5cJw9MS5M8Ibk1zbdiJyfVa717OsuJC5zfZxp5Vi7Ewq1G
         yq3Q==
X-Gm-Message-State: AFqh2kqCbBOGmJgzBBUXMyzDBPy/izZdTGZb0yCt4DsvnK4nSeDNFaN7
        H9oQGW20FqMEbmsZEvsSs98=
X-Google-Smtp-Source: AMrXdXvFkGgv5rVFEfrR0T2GVisRekQpNYg0I9yoJwaZCjWR9kSalgBl5IzNdsZPIH6x1FSb+wFo/g==
X-Received: by 2002:a62:198c:0:b0:57f:ef24:5829 with SMTP id 134-20020a62198c000000b0057fef245829mr29535238pfz.17.1672362466045;
        Thu, 29 Dec 2022 17:07:46 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:500::4:afb4])
        by smtp.gmail.com with ESMTPSA id b189-20020a621bc6000000b00580d877a50fsm9853998pfb.55.2022.12.29.17.07.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Dec 2022 17:07:45 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        void@manifault.com, memxor@gmail.com, davemarchevsky@fb.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH bpf-next 2/2] selftests/bpf: Update linked_list tests for non-owning ref semantics
Date:   Thu, 29 Dec 2022 17:07:38 -0800
Message-Id: <20221230010738.45277-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20221230010738.45277-1-alexei.starovoitov@gmail.com>
References: <20221230010738.45277-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Dave Marchevsky <davemarchevsky@fb.com>

Current linked_list semantics for release_on_unlock node refs are almost
exactly the same as newly-introduced "non-owning reference" concept. The
only difference: writes to a release_on_unlock node ref are not allowed,
while writes to non-owning reference pointees are.

As a result the linked_list "write after push" failure tests are no
longer scenarios that should fail.

The test##_missing_lock_##op and test##_incorrect_lock_##op
macro-generated failure tests need to have a valid node argument in
order to have the same error output as before. Otherwise verification
will fail early and the expected error output won't be seen.

Some other tests have minor changes in error output, but fail for the
same reason.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
Link: https://lore.kernel.org/r/20221217082506.1570898-4-davemarchevsky@fb.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/prog_tests/linked_list.c    |   6 +-
 .../selftests/bpf/prog_tests/spin_lock.c      |   2 +-
 .../testing/selftests/bpf/progs/linked_list.c |   2 +-
 .../selftests/bpf/progs/linked_list_fail.c    | 100 +++++++++++-------
 4 files changed, 66 insertions(+), 44 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/linked_list.c b/tools/testing/selftests/bpf/prog_tests/linked_list.c
index 9a7d4c47af63..a2ed99cf2417 100644
--- a/tools/testing/selftests/bpf/prog_tests/linked_list.c
+++ b/tools/testing/selftests/bpf/prog_tests/linked_list.c
@@ -78,12 +78,10 @@ static struct {
 	{ "direct_write_head", "direct access to bpf_list_head is disallowed" },
 	{ "direct_read_node", "direct access to bpf_list_node is disallowed" },
 	{ "direct_write_node", "direct access to bpf_list_node is disallowed" },
-	{ "write_after_push_front", "only read is supported" },
-	{ "write_after_push_back", "only read is supported" },
 	{ "use_after_unlock_push_front", "invalid mem access 'scalar'" },
 	{ "use_after_unlock_push_back", "invalid mem access 'scalar'" },
-	{ "double_push_front", "arg#1 expected pointer to allocated object" },
-	{ "double_push_back", "arg#1 expected pointer to allocated object" },
+	{ "double_push_front", "Allocated list_node must be referenced" },
+	{ "double_push_back", "Allocated list_node must be referenced" },
 	{ "no_node_value_type", "bpf_list_node not found at offset=0" },
 	{ "incorrect_value_type",
 	  "operation on bpf_list_head expects arg#1 bpf_list_node at offset=0 in struct foo, "
diff --git a/tools/testing/selftests/bpf/prog_tests/spin_lock.c b/tools/testing/selftests/bpf/prog_tests/spin_lock.c
index d9270bd3d920..31ae22bb70e0 100644
--- a/tools/testing/selftests/bpf/prog_tests/spin_lock.c
+++ b/tools/testing/selftests/bpf/prog_tests/spin_lock.c
@@ -16,7 +16,7 @@ static struct {
 	  "R1_w=ptr_foo(id=2,ref_obj_id=2,off=0,imm=0) refs=2\n6: (85) call bpf_this_cpu_ptr#154\n"
 	  "R1 type=ptr_ expected=percpu_ptr_" },
 	{ "lock_id_global_zero",
-	  "; R1_w=map_value(off=0,ks=4,vs=4,imm=0)\n2: (85) call bpf_this_cpu_ptr#154\n"
+	  "off=0,ks=4,vs=4,imm=0)\n2: (85) call bpf_this_cpu_ptr#154\n"
 	  "R1 type=map_value expected=percpu_ptr_" },
 	{ "lock_id_mapval_preserve",
 	  "8: (bf) r1 = r0                       ; R0_w=map_value(id=1,off=0,ks=4,vs=8,imm=0) "
diff --git a/tools/testing/selftests/bpf/progs/linked_list.c b/tools/testing/selftests/bpf/progs/linked_list.c
index 4ad88da5cda2..4fa4a9b01bde 100644
--- a/tools/testing/selftests/bpf/progs/linked_list.c
+++ b/tools/testing/selftests/bpf/progs/linked_list.c
@@ -260,7 +260,7 @@ int test_list_push_pop_multiple(struct bpf_spin_lock *lock, struct bpf_list_head
 {
 	int ret;
 
-	ret = list_push_pop_multiple(lock ,head, false);
+	ret = list_push_pop_multiple(lock, head, false);
 	if (ret)
 		return ret;
 	return list_push_pop_multiple(lock, head, true);
diff --git a/tools/testing/selftests/bpf/progs/linked_list_fail.c b/tools/testing/selftests/bpf/progs/linked_list_fail.c
index 1d9017240e19..69cdc07cba13 100644
--- a/tools/testing/selftests/bpf/progs/linked_list_fail.c
+++ b/tools/testing/selftests/bpf/progs/linked_list_fail.c
@@ -54,28 +54,44 @@
 		return 0;                                   \
 	}
 
-CHECK(kptr, push_front, &f->head);
-CHECK(kptr, push_back, &f->head);
 CHECK(kptr, pop_front, &f->head);
 CHECK(kptr, pop_back, &f->head);
 
-CHECK(global, push_front, &ghead);
-CHECK(global, push_back, &ghead);
 CHECK(global, pop_front, &ghead);
 CHECK(global, pop_back, &ghead);
 
-CHECK(map, push_front, &v->head);
-CHECK(map, push_back, &v->head);
 CHECK(map, pop_front, &v->head);
 CHECK(map, pop_back, &v->head);
 
-CHECK(inner_map, push_front, &iv->head);
-CHECK(inner_map, push_back, &iv->head);
 CHECK(inner_map, pop_front, &iv->head);
 CHECK(inner_map, pop_back, &iv->head);
 
 #undef CHECK
 
+#define CHECK(test, op, hexpr, nexpr)					\
+	SEC("?tc")							\
+	int test##_missing_lock_##op(void *ctx)				\
+	{								\
+		INIT;							\
+		void (*p)(void *, void *) = (void *)&bpf_list_##op;	\
+		p(hexpr, nexpr);					\
+		return 0;						\
+	}
+
+CHECK(kptr, push_front, &f->head, b);
+CHECK(kptr, push_back, &f->head, b);
+
+CHECK(global, push_front, &ghead, f);
+CHECK(global, push_back, &ghead, f);
+
+CHECK(map, push_front, &v->head, f);
+CHECK(map, push_back, &v->head, f);
+
+CHECK(inner_map, push_front, &iv->head, f);
+CHECK(inner_map, push_back, &iv->head, f);
+
+#undef CHECK
+
 #define CHECK(test, op, lexpr, hexpr)                       \
 	SEC("?tc")                                          \
 	int test##_incorrect_lock_##op(void *ctx)           \
@@ -108,11 +124,47 @@ CHECK(inner_map, pop_back, &iv->head);
 	CHECK(inner_map_global, op, &iv->lock, &ghead);        \
 	CHECK(inner_map_map, op, &iv->lock, &v->head);
 
-CHECK_OP(push_front);
-CHECK_OP(push_back);
 CHECK_OP(pop_front);
 CHECK_OP(pop_back);
 
+#undef CHECK
+#undef CHECK_OP
+
+#define CHECK(test, op, lexpr, hexpr, nexpr)				\
+	SEC("?tc")							\
+	int test##_incorrect_lock_##op(void *ctx)			\
+	{								\
+		INIT;							\
+		void (*p)(void *, void*) = (void *)&bpf_list_##op;	\
+		bpf_spin_lock(lexpr);					\
+		p(hexpr, nexpr);					\
+		return 0;						\
+	}
+
+#define CHECK_OP(op)							\
+	CHECK(kptr_kptr, op, &f1->lock, &f2->head, b);			\
+	CHECK(kptr_global, op, &f1->lock, &ghead, f);			\
+	CHECK(kptr_map, op, &f1->lock, &v->head, f);			\
+	CHECK(kptr_inner_map, op, &f1->lock, &iv->head, f);		\
+									\
+	CHECK(global_global, op, &glock2, &ghead, f);			\
+	CHECK(global_kptr, op, &glock, &f1->head, b);			\
+	CHECK(global_map, op, &glock, &v->head, f);			\
+	CHECK(global_inner_map, op, &glock, &iv->head, f);		\
+									\
+	CHECK(map_map, op, &v->lock, &v2->head, f);			\
+	CHECK(map_kptr, op, &v->lock, &f2->head, b);			\
+	CHECK(map_global, op, &v->lock, &ghead, f);			\
+	CHECK(map_inner_map, op, &v->lock, &iv->head, f);		\
+									\
+	CHECK(inner_map_inner_map, op, &iv->lock, &iv2->head, f);	\
+	CHECK(inner_map_kptr, op, &iv->lock, &f2->head, b);		\
+	CHECK(inner_map_global, op, &iv->lock, &ghead, f);		\
+	CHECK(inner_map_map, op, &iv->lock, &v->head, f);
+
+CHECK_OP(push_front);
+CHECK_OP(push_back);
+
 #undef CHECK
 #undef CHECK_OP
 #undef INIT
@@ -303,34 +355,6 @@ int direct_write_node(void *ctx)
 	return 0;
 }
 
-static __always_inline
-int write_after_op(void (*push_op)(void *head, void *node))
-{
-	struct foo *f;
-
-	f = bpf_obj_new(typeof(*f));
-	if (!f)
-		return 0;
-	bpf_spin_lock(&glock);
-	push_op(&ghead, &f->node);
-	f->data = 42;
-	bpf_spin_unlock(&glock);
-
-	return 0;
-}
-
-SEC("?tc")
-int write_after_push_front(void *ctx)
-{
-	return write_after_op((void *)bpf_list_push_front);
-}
-
-SEC("?tc")
-int write_after_push_back(void *ctx)
-{
-	return write_after_op((void *)bpf_list_push_back);
-}
-
 static __always_inline
 int use_after_unlock(void (*op)(void *head, void *node))
 {
-- 
2.30.2

