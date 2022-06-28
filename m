Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D2355E800
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 18:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347845AbiF1QDE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jun 2022 12:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347819AbiF1QCl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jun 2022 12:02:41 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B954E3819D
        for <bpf@vger.kernel.org>; Tue, 28 Jun 2022 09:02:04 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 5F9FE240113
        for <bpf@vger.kernel.org>; Tue, 28 Jun 2022 18:02:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1656432123; bh=8m58aPJqeip5Nyyiy5MvdK2kx7zSbD5M92tegFp7+P4=;
        h=From:To:Cc:Subject:Date:From;
        b=SOnsArByJlTtqIXfgEbLJy6/IOZLR5rsC5x7hoJ2Ckh4HjAFHa8E+7ReyaFK+rqlw
         cFE9PbgIIyConoD6OAduOw8ZNMHKcAHovxbHojVGf/XxzBuxF7VHxR3D36KX8rNWkE
         IizH3BkuJVjxZr1wxks9qLgtrEQnZoks4IVeDlR0xzyz+5xXJObkE/Bv4F4G7daovR
         gruDc/6qTxWEcZN6RvJ0yRnq/k4gxSwGx+WszBclKC4wOnJw5RCLiYHkNOQsDi3Kcg
         VTFn6/tGvicDB3WCHXLPfy5Begt3DeyALF2CeVG2Mq11BR90aoTS5SFuZH+tRcMN2k
         gsi4Y0B/iFoPw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4LXTqt3jZ7z6tmM;
        Tue, 28 Jun 2022 18:02:02 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Cc:     joannelkoong@gmail.com
Subject: [PATCH bpf-next v3 08/10] selftests/bpf: Add test checking more characteristics
Date:   Tue, 28 Jun 2022 16:01:25 +0000
Message-Id: <20220628160127.607834-9-deso@posteo.net>
In-Reply-To: <20220628160127.607834-1-deso@posteo.net>
References: <20220628160127.607834-1-deso@posteo.net>
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

This change adds another type-based self-test that specifically aims to
test some more characteristics of the TYPE_MATCH logic. Specifically, it
covers a few more potential differences between types, such as different
orders, enum variant values, and integer signedness.

Signed-off-by: Daniel Müller <deso@posteo.net>
---
 .../selftests/bpf/prog_tests/core_reloc.c     | 37 ++++++++++++++
 .../progs/btf__core_reloc_type_based___diff.c |  3 ++
 .../selftests/bpf/progs/core_reloc_types.h    | 51 +++++++++++++++++++
 3 files changed, 91 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_type_based___diff.c

diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc.c b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
index 328dd7..eb47bf 100644
--- a/tools/testing/selftests/bpf/prog_tests/core_reloc.c
+++ b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
@@ -792,6 +792,43 @@ static const struct core_reloc_test_case test_cases[] = {
 	TYPE_BASED_CASE(type_based___all_missing, {
 		/* all zeros */
 	}),
+	TYPE_BASED_CASE(type_based___diff, {
+		.struct_exists = 1,
+		.union_exists = 1,
+		.enum_exists = 1,
+		.typedef_named_struct_exists = 1,
+		.typedef_anon_struct_exists = 1,
+		.typedef_struct_ptr_exists = 1,
+		.typedef_int_exists = 1,
+		.typedef_enum_exists = 1,
+		.typedef_void_ptr_exists = 1,
+		.typedef_func_proto_exists = 1,
+		.typedef_arr_exists = 1,
+
+		.struct_matches = 1,
+		.union_matches = 1,
+		.enum_matches = 1,
+		.typedef_named_struct_matches = 1,
+		.typedef_anon_struct_matches = 1,
+		.typedef_struct_ptr_matches = 1,
+		.typedef_int_matches = 0,
+		.typedef_enum_matches = 1,
+		.typedef_void_ptr_matches = 1,
+		.typedef_func_proto_matches = 0,
+		.typedef_arr_matches = 0,
+
+		.struct_sz = sizeof(struct a_struct___diff),
+		.union_sz = sizeof(union a_union___diff),
+		.enum_sz = sizeof(enum an_enum___diff),
+		.typedef_named_struct_sz = sizeof(named_struct_typedef___diff),
+		.typedef_anon_struct_sz = sizeof(anon_struct_typedef___diff),
+		.typedef_struct_ptr_sz = sizeof(struct_ptr_typedef___diff),
+		.typedef_int_sz = sizeof(int_typedef___diff),
+		.typedef_enum_sz = sizeof(enum_typedef___diff),
+		.typedef_void_ptr_sz = sizeof(void_ptr_typedef___diff),
+		.typedef_func_proto_sz = sizeof(func_proto_typedef___diff),
+		.typedef_arr_sz = sizeof(arr_typedef___diff),
+	}),
 	TYPE_BASED_CASE(type_based___diff_sz, {
 		.struct_exists = 1,
 		.union_exists = 1,
diff --git a/tools/testing/selftests/bpf/progs/btf__core_reloc_type_based___diff.c b/tools/testing/selftests/bpf/progs/btf__core_reloc_type_based___diff.c
new file mode 100644
index 0000000..57ae2c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/btf__core_reloc_type_based___diff.c
@@ -0,0 +1,3 @@
+#include "core_reloc_types.h"
+
+void f(struct core_reloc_type_based___diff x) {}
diff --git a/tools/testing/selftests/bpf/progs/core_reloc_types.h b/tools/testing/selftests/bpf/progs/core_reloc_types.h
index 6a44f3e..e326b6 100644
--- a/tools/testing/selftests/bpf/progs/core_reloc_types.h
+++ b/tools/testing/selftests/bpf/progs/core_reloc_types.h
@@ -951,6 +951,57 @@ struct core_reloc_type_based {
 struct core_reloc_type_based___all_missing {
 };
 
+/* different member orders, enum variant values, signedness, etc */
+struct a_struct___diff {
+	int x;
+	int a;
+};
+
+union a_union___diff {
+	int z;
+	int y;
+};
+
+typedef struct a_struct___diff named_struct_typedef___diff;
+
+typedef struct { int z, x, y; } anon_struct_typedef___diff;
+
+typedef struct {
+	int c;
+	int b;
+	int a;
+} *struct_ptr_typedef___diff;
+
+enum an_enum___diff {
+	AN_ENUM_VAL2___diff = 0,
+	AN_ENUM_VAL1___diff = 42,
+	AN_ENUM_VAL3___diff = 1,
+};
+
+typedef unsigned int int_typedef___diff;
+
+typedef enum { TYPEDEF_ENUM_VAL2___diff, TYPEDEF_ENUM_VAL1___diff = 50 } enum_typedef___diff;
+
+typedef const void *void_ptr_typedef___diff;
+
+typedef int_typedef___diff (*func_proto_typedef___diff)(long);
+
+typedef char arr_typedef___diff[3];
+
+struct core_reloc_type_based___diff {
+	struct a_struct___diff f1;
+	union a_union___diff f2;
+	enum an_enum___diff f3;
+	named_struct_typedef___diff f4;
+	anon_struct_typedef___diff f5;
+	struct_ptr_typedef___diff f6;
+	int_typedef___diff f7;
+	enum_typedef___diff f8;
+	void_ptr_typedef___diff f9;
+	func_proto_typedef___diff f10;
+	arr_typedef___diff f11;
+};
+
 /* different type sizes, extra modifiers, anon vs named enums, etc */
 struct a_struct___diff_sz {
 	long x;
-- 
2.30.2

