Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19ED5558AAA
	for <lists+bpf@lfdr.de>; Thu, 23 Jun 2022 23:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiFWVWu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jun 2022 17:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiFWVWu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jun 2022 17:22:50 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1087656F8C
        for <bpf@vger.kernel.org>; Thu, 23 Jun 2022 14:22:49 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id B237B24002A
        for <bpf@vger.kernel.org>; Thu, 23 Jun 2022 23:22:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1656019367; bh=/hvehwMkNSOMape3WP4mwp4pPVa6Y6Eo1bGnnvvrfpw=;
        h=From:To:Cc:Subject:Date:From;
        b=pM8K5ibi/oaXRLv42utVh8vYAVr7PzEiICp0mvpAebCQlv1v2IqYBMpQqGcZn192T
         gKFj0m0dgD7YvmzDHlj4YMKScV47DRhI4twfzb0U5IwXmw+vcxM0oJd17HfyKZgtzf
         SbgNQvevLsq+TI/M3PYO5mpibvzgCwBrA9fS1TepjZrB4t0cMhlJCjdq1iZVFIXJE8
         BiDq98fRW794OZv5f2N3wi3oBRK5lF0QRgFUfdP2p2C0kTrN4Lxm6wUxb0fqXdJEd/
         T1N3cS/+r5qeU+Y8pWIekL1T0fnHEgbRAV035XQ4N8wlVk/m+WrPew9ZLhvVIlskHS
         8/nQmLbEwjHkg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4LTYBG6Xl6z6tmb;
        Thu, 23 Jun 2022 23:22:46 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Cc:     joannelkoong@gmail.com
Subject: [PATCH bpf-next v2 9/9] selftests/bpf: Add nested type to type based tests
Date:   Thu, 23 Jun 2022 21:22:05 +0000
Message-Id: <20220623212205.2805002-10-deso@posteo.net>
In-Reply-To: <20220623212205.2805002-1-deso@posteo.net>
References: <20220623212205.2805002-1-deso@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This change extends the type based tests with another struct type (in
addition to a_struct) to check relocations against: a_complex_struct.
This type is nested more deeply to provide additional coverage of
certain paths in the type match logic.

Signed-off-by: Daniel Müller <deso@posteo.net>
---
 .../selftests/bpf/prog_tests/core_reloc.c     |  4 ++
 .../selftests/bpf/progs/core_reloc_types.h    | 62 +++++++++++++------
 .../bpf/progs/test_core_reloc_type_based.c    | 12 ++++
 3 files changed, 58 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc.c b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
index eb47bf..8882c9c 100644
--- a/tools/testing/selftests/bpf/prog_tests/core_reloc.c
+++ b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
@@ -754,6 +754,7 @@ static const struct core_reloc_test_case test_cases[] = {
 	/* validate type existence, match, and size relocations */
 	TYPE_BASED_CASE(type_based, {
 		.struct_exists = 1,
+		.complex_struct_exists = 1,
 		.union_exists = 1,
 		.enum_exists = 1,
 		.typedef_named_struct_exists = 1,
@@ -766,6 +767,7 @@ static const struct core_reloc_test_case test_cases[] = {
 		.typedef_arr_exists = 1,
 
 		.struct_matches = 1,
+		.complex_struct_matches = 1,
 		.union_matches = 1,
 		.enum_matches = 1,
 		.typedef_named_struct_matches = 1,
@@ -794,6 +796,7 @@ static const struct core_reloc_test_case test_cases[] = {
 	}),
 	TYPE_BASED_CASE(type_based___diff, {
 		.struct_exists = 1,
+		.complex_struct_exists = 1,
 		.union_exists = 1,
 		.enum_exists = 1,
 		.typedef_named_struct_exists = 1,
@@ -806,6 +809,7 @@ static const struct core_reloc_test_case test_cases[] = {
 		.typedef_arr_exists = 1,
 
 		.struct_matches = 1,
+		.complex_struct_matches = 1,
 		.union_matches = 1,
 		.enum_matches = 1,
 		.typedef_named_struct_matches = 1,
diff --git a/tools/testing/selftests/bpf/progs/core_reloc_types.h b/tools/testing/selftests/bpf/progs/core_reloc_types.h
index e326b6..aa265c3 100644
--- a/tools/testing/selftests/bpf/progs/core_reloc_types.h
+++ b/tools/testing/selftests/bpf/progs/core_reloc_types.h
@@ -864,6 +864,7 @@ struct core_reloc_size___err_ambiguous2 {
  */
 struct core_reloc_type_based_output {
 	bool struct_exists;
+	bool complex_struct_exists;
 	bool union_exists;
 	bool enum_exists;
 	bool typedef_named_struct_exists;
@@ -876,6 +877,7 @@ struct core_reloc_type_based_output {
 	bool typedef_arr_exists;
 
 	bool struct_matches;
+	bool complex_struct_matches;
 	bool union_matches;
 	bool enum_matches;
 	bool typedef_named_struct_matches;
@@ -904,6 +906,14 @@ struct a_struct {
 	int x;
 };
 
+struct a_complex_struct {
+	union {
+		struct a_struct *a;
+		void *b;
+	} x;
+	volatile long y;
+};
+
 union a_union {
 	int y;
 	int z;
@@ -935,16 +945,17 @@ typedef char arr_typedef[20];
 
 struct core_reloc_type_based {
 	struct a_struct f1;
-	union a_union f2;
-	enum an_enum f3;
-	named_struct_typedef f4;
-	anon_struct_typedef f5;
-	struct_ptr_typedef f6;
-	int_typedef f7;
-	enum_typedef f8;
-	void_ptr_typedef f9;
-	func_proto_typedef f10;
-	arr_typedef f11;
+	struct a_complex_struct f2;
+	union a_union f3;
+	enum an_enum f4;
+	named_struct_typedef f5;
+	anon_struct_typedef f6;
+	struct_ptr_typedef f7;
+	int_typedef f8;
+	enum_typedef f9;
+	void_ptr_typedef f10;
+	func_proto_typedef f11;
+	arr_typedef f12;
 };
 
 /* no types in target */
@@ -957,6 +968,16 @@ struct a_struct___diff {
 	int a;
 };
 
+struct a_struct___forward;
+
+struct a_complex_struct___diff {
+	union {
+		struct a_struct___forward *a;
+		void *b;
+	} x;
+	volatile long y;
+};
+
 union a_union___diff {
 	int z;
 	int y;
@@ -990,16 +1011,17 @@ typedef char arr_typedef___diff[3];
 
 struct core_reloc_type_based___diff {
 	struct a_struct___diff f1;
-	union a_union___diff f2;
-	enum an_enum___diff f3;
-	named_struct_typedef___diff f4;
-	anon_struct_typedef___diff f5;
-	struct_ptr_typedef___diff f6;
-	int_typedef___diff f7;
-	enum_typedef___diff f8;
-	void_ptr_typedef___diff f9;
-	func_proto_typedef___diff f10;
-	arr_typedef___diff f11;
+	struct a_complex_struct___diff f2;
+	union a_union___diff f3;
+	enum an_enum___diff f4;
+	named_struct_typedef___diff f5;
+	anon_struct_typedef___diff f6;
+	struct_ptr_typedef___diff f7;
+	int_typedef___diff f8;
+	enum_typedef___diff f9;
+	void_ptr_typedef___diff f10;
+	func_proto_typedef___diff f11;
+	arr_typedef___diff f12;
 };
 
 /* different type sizes, extra modifiers, anon vs named enums, etc */
diff --git a/tools/testing/selftests/bpf/progs/test_core_reloc_type_based.c b/tools/testing/selftests/bpf/progs/test_core_reloc_type_based.c
index 325ead..d95bc08 100644
--- a/tools/testing/selftests/bpf/progs/test_core_reloc_type_based.c
+++ b/tools/testing/selftests/bpf/progs/test_core_reloc_type_based.c
@@ -19,6 +19,14 @@ struct a_struct {
 	int x;
 };
 
+struct a_complex_struct {
+	union {
+		struct a_struct *a;
+		void *b;
+	} x;
+	volatile long y;
+};
+
 union a_union {
 	int y;
 	int z;
@@ -50,6 +58,7 @@ typedef char arr_typedef[20];
 
 struct core_reloc_type_based_output {
 	bool struct_exists;
+	bool complex_struct_exists;
 	bool union_exists;
 	bool enum_exists;
 	bool typedef_named_struct_exists;
@@ -62,6 +71,7 @@ struct core_reloc_type_based_output {
 	bool typedef_arr_exists;
 
 	bool struct_matches;
+	bool complex_struct_matches;
 	bool union_matches;
 	bool enum_matches;
 	bool typedef_named_struct_matches;
@@ -99,6 +109,7 @@ int test_core_type_based(void *ctx)
 	struct core_reloc_type_based_output *out = (void *)&data.out;
 
 	out->struct_exists = bpf_core_type_exists(struct a_struct);
+	out->complex_struct_exists = bpf_core_type_exists(struct a_complex_struct);
 	out->union_exists = bpf_core_type_exists(union a_union);
 	out->enum_exists = bpf_core_type_exists(enum an_enum);
 	out->typedef_named_struct_exists = bpf_core_type_exists(named_struct_typedef);
@@ -111,6 +122,7 @@ int test_core_type_based(void *ctx)
 	out->typedef_arr_exists = bpf_core_type_exists(arr_typedef);
 
 	out->struct_matches = bpf_core_type_matches(struct a_struct);
+	out->complex_struct_matches = bpf_core_type_matches(struct a_complex_struct);
 	out->union_matches = bpf_core_type_matches(union a_union);
 	out->enum_matches = bpf_core_type_matches(enum an_enum);
 	out->typedef_named_struct_matches = bpf_core_type_matches(named_struct_typedef);
-- 
2.30.2

