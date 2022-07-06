Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D143569458
	for <lists+bpf@lfdr.de>; Wed,  6 Jul 2022 23:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234383AbiGFV3R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Jul 2022 17:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234379AbiGFV3Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Jul 2022 17:29:16 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2BF240A5
        for <bpf@vger.kernel.org>; Wed,  6 Jul 2022 14:29:15 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 4A65C240029
        for <bpf@vger.kernel.org>; Wed,  6 Jul 2022 23:29:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1657142954; bh=fOROytmrENan2OZ0M69OH7iB9oM378I5kMVtZq68EPw=;
        h=From:To:Subject:Date:From;
        b=N8pmSuk7l24t0FD8sbxCWt2GoDHkobZyC1lVVnJRKlOJVUszjy7ElPW9NtNcThv1I
         Y86PAnefXoK2+KRyldJdGRv6O1HU0YOgfeuflnnjljkXx/4qqrlBjUmzOcjOBa3FNh
         oEE2CJDzHQt3xUc8bvH2X8K4x1yz7x3Wz2HME7MEpC0mXQh9Hhe+/t4Jq8NoH+oOYb
         fIhDjjjFiSzEG5N4TqayS0lGdA1/zzM5HlIkTE8TNc20hCbZrPH/YNUx+nwavQ/wlQ
         x/QSBx0NulE5kG4zY/UccibJkyQn8lyOpxLHX1XCs9JfMlPKEnPdHgHPmgymUCeZu1
         7feCCLPW7B9lg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4LdXjj3fk1z9rxM;
        Wed,  6 Jul 2022 23:29:13 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, quentin@isovalent.com, kernel-team@fb.com
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add test involving restrict type qualifier
Date:   Wed,  6 Jul 2022 21:28:55 +0000
Message-Id: <20220706212855.1700615-3-deso@posteo.net>
In-Reply-To: <20220706212855.1700615-1-deso@posteo.net>
References: <20220706212855.1700615-1-deso@posteo.net>
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

This change adds a type based test involving the restrict type qualifier
to the BPF selftests. On the btfgen path, this will verify that bpftool
correctly handles the corresponding RESTRICT BTF kind.

Signed-off-by: Daniel Müller <deso@posteo.net>
---
 tools/testing/selftests/bpf/prog_tests/core_reloc.c       | 2 ++
 tools/testing/selftests/bpf/progs/core_reloc_types.h      | 8 ++++++--
 .../selftests/bpf/progs/test_core_reloc_type_based.c      | 5 +++++
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc.c b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
index a6f65e2..c8655ba 100644
--- a/tools/testing/selftests/bpf/prog_tests/core_reloc.c
+++ b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
@@ -764,6 +764,7 @@ static const struct core_reloc_test_case test_cases[] = {
 		.typedef_int_exists = 1,
 		.typedef_enum_exists = 1,
 		.typedef_void_ptr_exists = 1,
+		.typedef_restrict_ptr_exists = 1,
 		.typedef_func_proto_exists = 1,
 		.typedef_arr_exists = 1,
 
@@ -777,6 +778,7 @@ static const struct core_reloc_test_case test_cases[] = {
 		.typedef_int_matches = 1,
 		.typedef_enum_matches = 1,
 		.typedef_void_ptr_matches = 1,
+		.typedef_restrict_ptr_matches = 1,
 		.typedef_func_proto_matches = 1,
 		.typedef_arr_matches = 1,
 
diff --git a/tools/testing/selftests/bpf/progs/core_reloc_types.h b/tools/testing/selftests/bpf/progs/core_reloc_types.h
index 7ef91d..fd8e1b 100644
--- a/tools/testing/selftests/bpf/progs/core_reloc_types.h
+++ b/tools/testing/selftests/bpf/progs/core_reloc_types.h
@@ -874,6 +874,7 @@ struct core_reloc_type_based_output {
 	bool typedef_int_exists;
 	bool typedef_enum_exists;
 	bool typedef_void_ptr_exists;
+	bool typedef_restrict_ptr_exists;
 	bool typedef_func_proto_exists;
 	bool typedef_arr_exists;
 
@@ -887,6 +888,7 @@ struct core_reloc_type_based_output {
 	bool typedef_int_matches;
 	bool typedef_enum_matches;
 	bool typedef_void_ptr_matches;
+	bool typedef_restrict_ptr_matches;
 	bool typedef_func_proto_matches;
 	bool typedef_arr_matches;
 
@@ -939,6 +941,7 @@ typedef int int_typedef;
 typedef enum { TYPEDEF_ENUM_VAL1, TYPEDEF_ENUM_VAL2 } enum_typedef;
 
 typedef void *void_ptr_typedef;
+typedef int *restrict restrict_ptr_typedef;
 
 typedef int (*func_proto_typedef)(long);
 
@@ -955,8 +958,9 @@ struct core_reloc_type_based {
 	int_typedef f8;
 	enum_typedef f9;
 	void_ptr_typedef f10;
-	func_proto_typedef f11;
-	arr_typedef f12;
+	restrict_ptr_typedef f11;
+	func_proto_typedef f12;
+	arr_typedef f13;
 };
 
 /* no types in target */
diff --git a/tools/testing/selftests/bpf/progs/test_core_reloc_type_based.c b/tools/testing/selftests/bpf/progs/test_core_reloc_type_based.c
index d95bc08..2edb4d 100644
--- a/tools/testing/selftests/bpf/progs/test_core_reloc_type_based.c
+++ b/tools/testing/selftests/bpf/progs/test_core_reloc_type_based.c
@@ -51,6 +51,7 @@ typedef int int_typedef;
 typedef enum { TYPEDEF_ENUM_VAL1, TYPEDEF_ENUM_VAL2 } enum_typedef;
 
 typedef void *void_ptr_typedef;
+typedef int *restrict restrict_ptr_typedef;
 
 typedef int (*func_proto_typedef)(long);
 
@@ -67,6 +68,7 @@ struct core_reloc_type_based_output {
 	bool typedef_int_exists;
 	bool typedef_enum_exists;
 	bool typedef_void_ptr_exists;
+	bool typedef_restrict_ptr_exists;
 	bool typedef_func_proto_exists;
 	bool typedef_arr_exists;
 
@@ -80,6 +82,7 @@ struct core_reloc_type_based_output {
 	bool typedef_int_matches;
 	bool typedef_enum_matches;
 	bool typedef_void_ptr_matches;
+	bool typedef_restrict_ptr_matches;
 	bool typedef_func_proto_matches;
 	bool typedef_arr_matches;
 
@@ -118,6 +121,7 @@ int test_core_type_based(void *ctx)
 	out->typedef_int_exists = bpf_core_type_exists(int_typedef);
 	out->typedef_enum_exists = bpf_core_type_exists(enum_typedef);
 	out->typedef_void_ptr_exists = bpf_core_type_exists(void_ptr_typedef);
+	out->typedef_restrict_ptr_exists = bpf_core_type_exists(restrict_ptr_typedef);
 	out->typedef_func_proto_exists = bpf_core_type_exists(func_proto_typedef);
 	out->typedef_arr_exists = bpf_core_type_exists(arr_typedef);
 
@@ -131,6 +135,7 @@ int test_core_type_based(void *ctx)
 	out->typedef_int_matches = bpf_core_type_matches(int_typedef);
 	out->typedef_enum_matches = bpf_core_type_matches(enum_typedef);
 	out->typedef_void_ptr_matches = bpf_core_type_matches(void_ptr_typedef);
+	out->typedef_restrict_ptr_matches = bpf_core_type_matches(restrict_ptr_typedef);
 	out->typedef_func_proto_matches = bpf_core_type_matches(func_proto_typedef);
 	out->typedef_arr_matches = bpf_core_type_matches(arr_typedef);
 
-- 
2.30.2

