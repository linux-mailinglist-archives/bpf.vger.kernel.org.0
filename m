Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09CD62EB79
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 02:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239916AbiKRB5n (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 20:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240681AbiKRB5l (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 20:57:41 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D288473BBF
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 17:57:40 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id g10so3296957plo.11
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 17:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uP5i2POafRboYFdqn4vr6SG6ZnSgjd/hNIcjL7JNlTw=;
        b=q5BisQnhJuYU5UqZHhggKjnF9kdhuGqoQaytHq3YZcTumJyV6lp31oQthTzAREet97
         3PwaOfSOH5asq6t6yfymQBaB6QAJabSprn5PDBlqoRetz8Fga5IcA1ly2TjEzlZV8N5P
         K9XECVdYnckgTia89EDI7ZDzJgTD4W4GNfb7P0+0f+FMifk+aNWoewg8WflxLWQcxlYm
         AVpYf1dRqQAe9MmR64Opj6sLLanGicRKZtwlARELPfS/9dqytJnoJMzsy3BpDwEBC5C2
         V94nA2BxQ4O9tFvlL81qK4ukr3Lo35M2t+V28NfSYjXjpQ56h+Ed29QEH5V0kpLLWIbS
         vUvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uP5i2POafRboYFdqn4vr6SG6ZnSgjd/hNIcjL7JNlTw=;
        b=yoYUaWwfJM0SO/swy0Zo44Y6I11VXOVq55DYwZCiF6amIKnYx7PD3P3ZPY6kAqGdqw
         aMoCdTagbhdlriiozSHGAkhVW6S/ZhYqtQWnGXqdVI30hmSPM41J5hWfd4ArzRJAa5DU
         i/pGG/5YaY9pfVpLwtDPAL1qo06tppTXkRw9S/Bf8aZkXqpISSRXJuKQWU1txfpiaUkb
         3LNqNqrPMj501OTPkfnKP72Vxijz9THF3n1PJ59z8nAavdT6pr2BlVgg7En0DTdJ8D0E
         LdCbXvQRJixLBT90GV8O2w+OI2PRgp9Nn5SD2+jNCMwbmudmbYZd7L2AYdW1h4acfm9e
         9UlQ==
X-Gm-Message-State: ANoB5pmy/n5DgmIfzbcyCVnKcjh51KJ1seAav7mQ9JW4tRAMEfzzENza
        Bde0z9WOxJCj+McAioHNla6rVl2ICoQ=
X-Google-Smtp-Source: AA0mqf6Et3NtAIOx1ai+e1bh13v1aTNWoqu1MyxnR7Wqr1aLiy7lzwkJTIzeA6bF1qNdqfFy6m2WxA==
X-Received: by 2002:a17:902:ec8d:b0:188:7dca:6f41 with SMTP id x13-20020a170902ec8d00b001887dca6f41mr5331889plg.72.1668736660087;
        Thu, 17 Nov 2022 17:57:40 -0800 (PST)
Received: from localhost ([2409:40f4:8:955c:5484:8048:c08:7b3])
        by smtp.gmail.com with ESMTPSA id b7-20020a170902d50700b0017c37a5a2fdsm2109365plg.216.2022.11.17.17.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 17:57:39 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v10 24/24] selftests/bpf: Temporarily disable linked list tests
Date:   Fri, 18 Nov 2022 07:26:14 +0530
Message-Id: <20221118015614.2013203-25-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118015614.2013203-1-memxor@gmail.com>
References: <20221118015614.2013203-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9757; i=memxor@gmail.com; h=from:subject; bh=uP/sZmvhuYUyQOoqH/MkTKMCK9nINIPi2Gzdnp4l23g=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjduXQ28mSgwi9IAHEcQ6Cpacpec5e5xW1/ay2kZBe M5O9czWJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3bl0AAKCRBM4MiGSL8Ryi0uD/ kBh9BJRjDQJBl3tD20klykAMdbKOSJxeetlJHkDsxXW8uTYLaWAkfeOX4D1mpIYhFZ4eM1v4WIuLbM ZnS8ySM7QdzR31WLnp9lOVB9v6ajX23b6op+DZylqinIFuxa7N4GSvpNtvwY7HfAh1eBLkQl4h50jW PbAiwGBG+w5EibU4aM2ToQG0lp9WwhJdNJt0JUl9kAbFBVJ4KkF52y4T/h3mDTaeEmR3KS2vvVM0l0 /UtDLy2DUWTGDF6g0vE0dMJ7C1F0v5D/3yrbxETL4MyrkpH6zbAQa6XoUJuGHuu109Y1ZlwzDwxXeB JKtGIzmEzt9KFAoasn98jscHdcF4ERF3Z7LoXH+1WT4RDU7DtPX2T+vGtiUXAGJEeSNuKqfJ5wpdae gtyL0FBx/Z1EO0+u/CGv36DYv+djvrgOYGBbbNX7/Q/yNDyUMaRbFg3Gi32akt2unMKu2pkAA2jG7H pFB5MD4gQuXysPr/ag8pjxVcEXPni+MaPHIBl49oJ3/wivAdiAzs/C0kq/U/QHfs0NpebQstwWfZXs 5unZyDZabEPjTIGhaxwe+XgxyoLySZQfvgZkzd1z3OEYaMAIpsABpCOVn0SBfc9r8oLJ717JpYZaZe NdhVJg+D+ZC9RiLDAT6aDVe0MBpQqzr2ZqXHv/Jx0Uoy5CE2row1V8xOtVgQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
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

The latest clang nightly as of writing crashes with the given test case
for BPF linked lists wherever global glock, ghead, glock2 are used,
hence comment out the parts that cause the crash, and prepare this commit
so that it can be reverted when the fix has been made. More context in [0].

 [0]: https://lore.kernel.org/bpf/d56223f9-483e-fbc1-4564-44c0858a1e3e@meta.com

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/linked_list.c    | 21 ++++++++++++-------
 .../testing/selftests/bpf/progs/linked_list.c | 11 +++++++++-
 .../testing/selftests/bpf/progs/linked_list.h |  2 ++
 .../selftests/bpf/progs/linked_list_fail.c    | 16 +++++++-------
 4 files changed, 34 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/linked_list.c b/tools/testing/selftests/bpf/prog_tests/linked_list.c
index dd73d0a62c6e..6170d36fe5fc 100644
--- a/tools/testing/selftests/bpf/prog_tests/linked_list.c
+++ b/tools/testing/selftests/bpf/prog_tests/linked_list.c
@@ -24,7 +24,9 @@ static struct {
 	{ #test "_missing_lock_pop_back", \
 	  "bpf_spin_lock at off=" #off " must be held for bpf_list_head" },
 	TEST(kptr, 32)
+/* FIXME
 	TEST(global, 16)
+*/
 	TEST(map, 0)
 	TEST(inner_map, 0)
 #undef TEST
@@ -32,9 +34,6 @@ static struct {
 	{ #test "_kptr_incorrect_lock_" #op, \
 	  "held lock and object are not in the same allocation\n" \
 	  "bpf_spin_lock at off=32 must be held for bpf_list_head" }, \
-	{ #test "_global_incorrect_lock_" #op, \
-	  "held lock and object are not in the same allocation\n" \
-	  "bpf_spin_lock at off=16 must be held for bpf_list_head" }, \
 	{ #test "_map_incorrect_lock_" #op, \
 	  "held lock and object are not in the same allocation\n" \
 	  "bpf_spin_lock at off=0 must be held for bpf_list_head" }, \
@@ -45,10 +44,6 @@ static struct {
 	TEST(kptr, push_back)
 	TEST(kptr, pop_front)
 	TEST(kptr, pop_back)
-	TEST(global, push_front)
-	TEST(global, push_back)
-	TEST(global, pop_front)
-	TEST(global, pop_back)
 	TEST(map, push_front)
 	TEST(map, push_back)
 	TEST(map, pop_front)
@@ -58,12 +53,14 @@ static struct {
 	TEST(inner_map, pop_front)
 	TEST(inner_map, pop_back)
 #undef TEST
+/* FIXME
 	{ "map_compat_kprobe", "tracing progs cannot use bpf_list_head yet" },
 	{ "map_compat_kretprobe", "tracing progs cannot use bpf_list_head yet" },
 	{ "map_compat_tp", "tracing progs cannot use bpf_list_head yet" },
 	{ "map_compat_perf", "tracing progs cannot use bpf_list_head yet" },
 	{ "map_compat_raw_tp", "tracing progs cannot use bpf_list_head yet" },
 	{ "map_compat_raw_tp_w", "tracing progs cannot use bpf_list_head yet" },
+*/
 	{ "obj_type_id_oor", "local type ID argument must be in range [0, U32_MAX]" },
 	{ "obj_new_no_composite", "bpf_obj_new type ID argument must be of a struct" },
 	{ "obj_new_no_struct", "bpf_obj_new type ID argument must be of a struct" },
@@ -78,6 +75,7 @@ static struct {
 	{ "direct_write_head", "direct access to bpf_list_head is disallowed" },
 	{ "direct_read_node", "direct access to bpf_list_node is disallowed" },
 	{ "direct_write_node", "direct access to bpf_list_node is disallowed" },
+/* FIXME
 	{ "write_after_push_front", "only read is supported" },
 	{ "write_after_push_back", "only read is supported" },
 	{ "use_after_unlock_push_front", "invalid mem access 'scalar'" },
@@ -94,8 +92,11 @@ static struct {
 	{ "no_head_type", "bpf_list_head not found at offset=0" },
 	{ "incorrect_head_var_off1", "R1 doesn't have constant offset" },
 	{ "incorrect_head_var_off2", "variable ptr_ access var_off=(0x0; 0xffffffff) disallowed" },
+*/
 	{ "incorrect_head_off1", "bpf_list_head not found at offset=17" },
+/* FIXME
 	{ "incorrect_head_off2", "bpf_list_head not found at offset=1" },
+*/
 	{ "pop_front_off",
 	  "15: (bf) r1 = r6                      ; R1_w=ptr_or_null_foo(id=4,ref_obj_id=4,off=40,imm=0) "
 	  "R6_w=ptr_or_null_foo(id=4,ref_obj_id=4,off=40,imm=0) refs=2,4\n"
@@ -188,8 +189,10 @@ static void test_linked_list_success(int mode, bool leave_in_map)
 	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.global_list_push_pop), &opts);
 	ASSERT_OK(ret, "global_list_push_pop");
 	ASSERT_OK(opts.retval, "global_list_push_pop retval");
+	/* FIXME:
 	if (!leave_in_map)
 		clear_fields(skel->maps.data_A);
+	*/
 
 	if (mode == PUSH_POP)
 		goto end;
@@ -210,8 +213,10 @@ static void test_linked_list_success(int mode, bool leave_in_map)
 	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.global_list_push_pop_multiple), &opts);
 	ASSERT_OK(ret, "global_list_push_pop_multiple");
 	ASSERT_OK(opts.retval, "global_list_push_pop_multiple retval");
+	/* FIXME:
 	if (!leave_in_map)
 		clear_fields(skel->maps.data_A);
+	*/
 
 	if (mode == PUSH_POP_MULT)
 		goto end;
@@ -232,8 +237,10 @@ static void test_linked_list_success(int mode, bool leave_in_map)
 	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.global_list_in_list), &opts);
 	ASSERT_OK(ret, "global_list_in_list");
 	ASSERT_OK(opts.retval, "global_list_in_list retval");
+	/* FIXME:
 	if (!leave_in_map)
 		clear_fields(skel->maps.data_A);
+	*/
 end:
 	linked_list__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/linked_list.c b/tools/testing/selftests/bpf/progs/linked_list.c
index 2c7b615c6d41..a99103c86e48 100644
--- a/tools/testing/selftests/bpf/progs/linked_list.c
+++ b/tools/testing/selftests/bpf/progs/linked_list.c
@@ -291,7 +291,10 @@ int inner_map_list_push_pop(void *ctx)
 SEC("tc")
 int global_list_push_pop(void *ctx)
 {
-	return test_list_push_pop(&glock, &ghead);
+	/* FIXME:
+	 * return test_list_push_pop(&glock, &ghead);
+	 */
+	return 0;
 }
 
 SEC("tc")
@@ -327,10 +330,13 @@ int global_list_push_pop_multiple(void *ctx)
 {
 	int ret;
 
+	/* FIXME:
 	ret = list_push_pop_multiple(&glock, &ghead, false);
 	if (ret)
 		return ret;
 	return list_push_pop_multiple(&glock, &ghead, true);
+	*/
+	return 0;
 }
 
 SEC("tc")
@@ -364,7 +370,10 @@ int inner_map_list_in_list(void *ctx)
 SEC("tc")
 int global_list_in_list(void *ctx)
 {
+	/* FIXME
 	return test_list_in_list(&glock, &ghead);
+	*/
+	return 0;
 }
 
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/linked_list.h b/tools/testing/selftests/bpf/progs/linked_list.h
index 8db80ed64db1..93157efc2d04 100644
--- a/tools/testing/selftests/bpf/progs/linked_list.h
+++ b/tools/testing/selftests/bpf/progs/linked_list.h
@@ -47,10 +47,12 @@ struct {
 	},
 };
 
+/* FIXME
 #define private(name) SEC(".data." #name) __hidden __attribute__((aligned(8)))
 
 private(A) struct bpf_spin_lock glock;
 private(A) struct bpf_list_head ghead __contains(foo, node);
 private(B) struct bpf_spin_lock glock2;
 
+*/
 #endif
diff --git a/tools/testing/selftests/bpf/progs/linked_list_fail.c b/tools/testing/selftests/bpf/progs/linked_list_fail.c
index 1d9017240e19..1b7ed1d3a9bb 100644
--- a/tools/testing/selftests/bpf/progs/linked_list_fail.c
+++ b/tools/testing/selftests/bpf/progs/linked_list_fail.c
@@ -59,10 +59,12 @@ CHECK(kptr, push_back, &f->head);
 CHECK(kptr, pop_front, &f->head);
 CHECK(kptr, pop_back, &f->head);
 
+/* FIXME
 CHECK(global, push_front, &ghead);
 CHECK(global, push_back, &ghead);
 CHECK(global, pop_front, &ghead);
 CHECK(global, pop_back, &ghead);
+*/
 
 CHECK(map, push_front, &v->head);
 CHECK(map, push_back, &v->head);
@@ -89,23 +91,15 @@ CHECK(inner_map, pop_back, &iv->head);
 
 #define CHECK_OP(op)                                           \
 	CHECK(kptr_kptr, op, &f1->lock, &f2->head);            \
-	CHECK(kptr_global, op, &f1->lock, &ghead);             \
 	CHECK(kptr_map, op, &f1->lock, &v->head);              \
 	CHECK(kptr_inner_map, op, &f1->lock, &iv->head);       \
                                                                \
-	CHECK(global_global, op, &glock2, &ghead);             \
-	CHECK(global_kptr, op, &glock, &f1->head);             \
-	CHECK(global_map, op, &glock, &v->head);               \
-	CHECK(global_inner_map, op, &glock, &iv->head);        \
-                                                               \
 	CHECK(map_map, op, &v->lock, &v2->head);               \
 	CHECK(map_kptr, op, &v->lock, &f2->head);              \
-	CHECK(map_global, op, &v->lock, &ghead);               \
 	CHECK(map_inner_map, op, &v->lock, &iv->head);         \
                                                                \
 	CHECK(inner_map_inner_map, op, &iv->lock, &iv2->head); \
 	CHECK(inner_map_kptr, op, &iv->lock, &f2->head);       \
-	CHECK(inner_map_global, op, &iv->lock, &ghead);        \
 	CHECK(inner_map_map, op, &iv->lock, &v->head);
 
 CHECK_OP(push_front);
@@ -117,6 +111,7 @@ CHECK_OP(pop_back);
 #undef CHECK_OP
 #undef INIT
 
+/* FIXME
 SEC("?kprobe/xyz")
 int map_compat_kprobe(void *ctx)
 {
@@ -158,6 +153,7 @@ int map_compat_raw_tp_w(void *ctx)
 	bpf_list_push_front(&ghead, NULL);
 	return 0;
 }
+*/
 
 SEC("?tc")
 int obj_type_id_oor(void *ctx)
@@ -303,6 +299,7 @@ int direct_write_node(void *ctx)
 	return 0;
 }
 
+/* FIXME
 static __always_inline
 int write_after_op(void (*push_op)(void *head, void *node))
 {
@@ -506,6 +503,7 @@ int incorrect_head_var_off2(struct __sk_buff *ctx)
 
 	return 0;
 }
+*/
 
 SEC("?tc")
 int incorrect_head_off1(void *ctx)
@@ -529,6 +527,7 @@ int incorrect_head_off1(void *ctx)
 	return 0;
 }
 
+/* FIXME
 SEC("?tc")
 int incorrect_head_off2(void *ctx)
 {
@@ -545,6 +544,7 @@ int incorrect_head_off2(void *ctx)
 
 	return 0;
 }
+*/
 
 static __always_inline
 int pop_ptr_off(void *(*op)(void *head))
-- 
2.38.1

