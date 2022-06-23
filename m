Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED873558AA8
	for <lists+bpf@lfdr.de>; Thu, 23 Jun 2022 23:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiFWVWr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jun 2022 17:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiFWVWq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jun 2022 17:22:46 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC87C4E390
        for <bpf@vger.kernel.org>; Thu, 23 Jun 2022 14:22:44 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 9FBAE240109
        for <bpf@vger.kernel.org>; Thu, 23 Jun 2022 23:22:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1656019363; bh=BMp9XtfX2kj2mjbA+tVPu764UU6HiuGix3rEwLmc2XE=;
        h=From:To:Cc:Subject:Date:From;
        b=d3nRPBliQyp/on5GQp+UMkAgRZsE8TTP75QQhi2D5ioIMU5cT6yNIkwBjpoUW7LGU
         guuYS4jBNMnF2ofua33iXSkJLA0SZs6kxgP1YABOjUEqdEjYLHwXQOktrBQMvYV9kv
         9LJS+La6pWcvE4Ssu58R2JZbQVqIe6zWJDmNpCojFumJVAYR2T2nffkF+yDunqQeBN
         3Ipl38sC4vfES5haBSv0HyVrMqJ332gWcxsRYaodDoWVpEIDjVaWlQoj7Sj+OmhmL+
         pc78Ts0zepS3x/W59otPRLMRDOtpsngONc7vll73wxuq5KqnDAmSJEzpOFKO+zIkLL
         tB1M6JDQ/XqSg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4LTYBB0ksRz6tmq;
        Thu, 23 Jun 2022 23:22:42 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Cc:     joannelkoong@gmail.com
Subject: [PATCH bpf-next v2 7/9] selftests/bpf: Add type-match checks to type-based tests
Date:   Thu, 23 Jun 2022 21:22:03 +0000
Message-Id: <20220623212205.2805002-8-deso@posteo.net>
In-Reply-To: <20220623212205.2805002-1-deso@posteo.net>
References: <20220623212205.2805002-1-deso@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Now that we have type-match logic in both libbpf and the kernel, this
change adjusts the existing BPF self tests to check this functionality.
Specifically, we extend the existing type-based tests to check the
previously introduced bpf_core_type_matches macro.

Signed-off-by: Daniel Müller <deso@posteo.net>
---
 .../selftests/bpf/prog_tests/core_reloc.c     | 31 ++++++++++++++++--
 .../selftests/bpf/progs/core_reloc_types.h    | 14 +++++++-
 .../bpf/progs/test_core_reloc_type_based.c    | 32 ++++++++++++++++++-
 3 files changed, 73 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc.c b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
index 2f92fe..328dd7 100644
--- a/tools/testing/selftests/bpf/prog_tests/core_reloc.c
+++ b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
@@ -543,7 +543,6 @@ static int __trigger_module_test_read(const struct core_reloc_test_case *test)
 	return 0;
 }
 
-
 static const struct core_reloc_test_case test_cases[] = {
 	/* validate we can find kernel image and use its BTF for relocs */
 	{
@@ -752,7 +751,7 @@ static const struct core_reloc_test_case test_cases[] = {
 	SIZE_CASE(size___diff_offs),
 	SIZE_ERR_CASE(size___err_ambiguous),
 
-	/* validate type existence and size relocations */
+	/* validate type existence, match, and size relocations */
 	TYPE_BASED_CASE(type_based, {
 		.struct_exists = 1,
 		.union_exists = 1,
@@ -765,6 +764,19 @@ static const struct core_reloc_test_case test_cases[] = {
 		.typedef_void_ptr_exists = 1,
 		.typedef_func_proto_exists = 1,
 		.typedef_arr_exists = 1,
+
+		.struct_matches = 1,
+		.union_matches = 1,
+		.enum_matches = 1,
+		.typedef_named_struct_matches = 1,
+		.typedef_anon_struct_matches = 1,
+		.typedef_struct_ptr_matches = 1,
+		.typedef_int_matches = 1,
+		.typedef_enum_matches = 1,
+		.typedef_void_ptr_matches = 1,
+		.typedef_func_proto_matches = 1,
+		.typedef_arr_matches = 1,
+
 		.struct_sz = sizeof(struct a_struct),
 		.union_sz = sizeof(union a_union),
 		.enum_sz = sizeof(enum an_enum),
@@ -792,6 +804,19 @@ static const struct core_reloc_test_case test_cases[] = {
 		.typedef_void_ptr_exists = 1,
 		.typedef_func_proto_exists = 1,
 		.typedef_arr_exists = 1,
+
+		.struct_matches = 0,
+		.union_matches = 0,
+		.enum_matches = 0,
+		.typedef_named_struct_matches = 0,
+		.typedef_anon_struct_matches = 0,
+		.typedef_struct_ptr_matches = 1,
+		.typedef_int_matches = 0,
+		.typedef_enum_matches = 0,
+		.typedef_void_ptr_matches = 1,
+		.typedef_func_proto_matches = 0,
+		.typedef_arr_matches = 0,
+
 		.struct_sz = sizeof(struct a_struct___diff_sz),
 		.union_sz = sizeof(union a_union___diff_sz),
 		.enum_sz = sizeof(enum an_enum___diff_sz),
@@ -806,10 +831,12 @@ static const struct core_reloc_test_case test_cases[] = {
 	}),
 	TYPE_BASED_CASE(type_based___incompat, {
 		.enum_exists = 1,
+		.enum_matches = 1,
 		.enum_sz = sizeof(enum an_enum),
 	}),
 	TYPE_BASED_CASE(type_based___fn_wrong_args, {
 		.struct_exists = 1,
+		.struct_matches = 1,
 		.struct_sz = sizeof(struct a_struct),
 	}),
 
diff --git a/tools/testing/selftests/bpf/progs/core_reloc_types.h b/tools/testing/selftests/bpf/progs/core_reloc_types.h
index 26e1033..6a44f3e 100644
--- a/tools/testing/selftests/bpf/progs/core_reloc_types.h
+++ b/tools/testing/selftests/bpf/progs/core_reloc_types.h
@@ -860,7 +860,7 @@ struct core_reloc_size___err_ambiguous2 {
 };
 
 /*
- * TYPE EXISTENCE & SIZE
+ * TYPE EXISTENCE, MATCH & SIZE
  */
 struct core_reloc_type_based_output {
 	bool struct_exists;
@@ -875,6 +875,18 @@ struct core_reloc_type_based_output {
 	bool typedef_func_proto_exists;
 	bool typedef_arr_exists;
 
+	bool struct_matches;
+	bool union_matches;
+	bool enum_matches;
+	bool typedef_named_struct_matches;
+	bool typedef_anon_struct_matches;
+	bool typedef_struct_ptr_matches;
+	bool typedef_int_matches;
+	bool typedef_enum_matches;
+	bool typedef_void_ptr_matches;
+	bool typedef_func_proto_matches;
+	bool typedef_arr_matches;
+
 	int struct_sz;
 	int union_sz;
 	int enum_sz;
diff --git a/tools/testing/selftests/bpf/progs/test_core_reloc_type_based.c b/tools/testing/selftests/bpf/progs/test_core_reloc_type_based.c
index fb60f8..325ead 100644
--- a/tools/testing/selftests/bpf/progs/test_core_reloc_type_based.c
+++ b/tools/testing/selftests/bpf/progs/test_core_reloc_type_based.c
@@ -61,6 +61,18 @@ struct core_reloc_type_based_output {
 	bool typedef_func_proto_exists;
 	bool typedef_arr_exists;
 
+	bool struct_matches;
+	bool union_matches;
+	bool enum_matches;
+	bool typedef_named_struct_matches;
+	bool typedef_anon_struct_matches;
+	bool typedef_struct_ptr_matches;
+	bool typedef_int_matches;
+	bool typedef_enum_matches;
+	bool typedef_void_ptr_matches;
+	bool typedef_func_proto_matches;
+	bool typedef_arr_matches;
+
 	int struct_sz;
 	int union_sz;
 	int enum_sz;
@@ -77,7 +89,13 @@ struct core_reloc_type_based_output {
 SEC("raw_tracepoint/sys_enter")
 int test_core_type_based(void *ctx)
 {
-#if __has_builtin(__builtin_preserve_type_info)
+	/* Support for the BPF_TYPE_MATCHES argument to the
+	 * __builtin_preserve_type_info builtin was added at some point during
+	 * development of clang 15 and it's what we require for this test. Part of it
+	 * could run with merely __builtin_preserve_type_info (which could be checked
+	 * separately), but we have to find an upper bound.
+	 */
+#if __has_builtin(__builtin_preserve_type_info) && __clang_major__ >= 15
 	struct core_reloc_type_based_output *out = (void *)&data.out;
 
 	out->struct_exists = bpf_core_type_exists(struct a_struct);
@@ -92,6 +110,18 @@ int test_core_type_based(void *ctx)
 	out->typedef_func_proto_exists = bpf_core_type_exists(func_proto_typedef);
 	out->typedef_arr_exists = bpf_core_type_exists(arr_typedef);
 
+	out->struct_matches = bpf_core_type_matches(struct a_struct);
+	out->union_matches = bpf_core_type_matches(union a_union);
+	out->enum_matches = bpf_core_type_matches(enum an_enum);
+	out->typedef_named_struct_matches = bpf_core_type_matches(named_struct_typedef);
+	out->typedef_anon_struct_matches = bpf_core_type_matches(anon_struct_typedef);
+	out->typedef_struct_ptr_matches = bpf_core_type_matches(struct_ptr_typedef);
+	out->typedef_int_matches = bpf_core_type_matches(int_typedef);
+	out->typedef_enum_matches = bpf_core_type_matches(enum_typedef);
+	out->typedef_void_ptr_matches = bpf_core_type_matches(void_ptr_typedef);
+	out->typedef_func_proto_matches = bpf_core_type_matches(func_proto_typedef);
+	out->typedef_arr_matches = bpf_core_type_matches(arr_typedef);
+
 	out->struct_sz = bpf_core_type_size(struct a_struct);
 	out->union_sz = bpf_core_type_size(union a_union);
 	out->enum_sz = bpf_core_type_size(enum an_enum);
-- 
2.30.2

