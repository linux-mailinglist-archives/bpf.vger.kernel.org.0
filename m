Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC19622DCA
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 15:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbiKIO1Q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 09:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbiKIO05 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 09:26:57 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48D213D7D
        for <bpf@vger.kernel.org>; Wed,  9 Nov 2022 06:26:39 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id f7so27470220edc.6
        for <bpf@vger.kernel.org>; Wed, 09 Nov 2022 06:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zeYpBI/Zis9oRLlLkun7Q/n0Uulsc8veDV2HLGI+YVE=;
        b=KQ3PY4C6U9kmOWRjG6M274C9UnuIXP3YVgAb9voPVuisX9la0BC1+oRI3WFqUhBOlN
         ZTGMWP/Ny74xWcmMXCOpgvkf0F7Y0uUXikkT1r98UBJVvI8h5QmkjUCYVGLWzoPdrI62
         q0oZqu5GREQK5c3pHuolHYZMpqhlAvvauDFoA/Ai88ob8ZRZ+GhFwg0MtbI2tteznE30
         zoY4EcZ4OAERJGNcDGTJGaAXO9yQCzOVuD2f/CxbN7Gfb8Hqc2DRS6+9g4e9L+HEwuQl
         ngRMuaj4sezVkPRqddV0ptSYm6U5sERtnc8QJAIrBJ6Re0icHpADFn7rlUKRxHxmCs+x
         Qq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zeYpBI/Zis9oRLlLkun7Q/n0Uulsc8veDV2HLGI+YVE=;
        b=3mv6rHzIMigYv2INZAAso0eQ/HSaDW9z/00rQzieqTjDmHht8OSSoj+ogDcBCWSix6
         QkFuWgY6X9YCTe+5wRhzhzQlrOzPkV7FUGcGb9YBmrg9TNVCNKzno8KGF71zTaNskYZT
         71P0IE1umeiq5r+1RCpzpNnPNivsQgtdIX5Wfaxk4p0XpBbAX25Fi9PHmp4uNaTmqujr
         PQ95lNZrlrW3dGDySfnbdiiw6uKzUE9Bo0G7BimRgCxdgtljMj8sWYsJ8Ut/5ed4ePRV
         aATrOjXUqPQeXTVVcPYY82+cVgNH3D4nRcT7G7fbmroAV+/A/Q2U1zALfe8JfPbbV+Ek
         wLCw==
X-Gm-Message-State: ANoB5pk0JjZ78AwaTx5kYKTFzidCype2qhUmvQvvcMGySzIh57eDxZbM
        Kxiv25z/dJNESFCYFdZCwWdRht46YfZlWXSN
X-Google-Smtp-Source: AA0mqf4r8fiw3Nbrk8qpxIWq1TqnRKW/829gPgP+5VGZtsjOjjYxwMmOBxE+5/BZnzS5ZXbJDqzuHA==
X-Received: by 2002:a50:bb67:0:b0:466:f299:bb32 with SMTP id y94-20020a50bb67000000b00466f299bb32mr1405061ede.307.1668003997994;
        Wed, 09 Nov 2022 06:26:37 -0800 (PST)
Received: from pluto.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id w21-20020a170906131500b007addcbd402esm5921013ejb.215.2022.11.09.06.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 06:26:37 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, alan.maguire@oracle.com, acme@kernel.org,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v4 3/3] selftests/bpf: Tests for btf_dedup_resolve_fwds
Date:   Wed,  9 Nov 2022 16:26:11 +0200
Message-Id: <20221109142611.879983-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221109142611.879983-1-eddyz87@gmail.com>
References: <20221109142611.879983-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Tests to verify the following behavior of `btf_dedup_resolve_fwds`:
- remapping for struct forward declarations;
- remapping for union forward declarations;
- no remapping if forward declaration kind does not match similarly
  named struct or union declaration;
- no remapping if forward declaration name is ambiguous;
- base ids are considered for fwd resolution in split btf scenario.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/testing/selftests/bpf/prog_tests/btf.c  | 176 ++++++++++++++++++
 .../bpf/prog_tests/btf_dedup_split.c          |  45 +++--
 2 files changed, 206 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index c3e1cea9abae..95a2b80f0d17 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -7690,6 +7690,182 @@ static struct btf_dedup_test dedup_tests[] = {
 		BTF_STR_SEC("\0e1\0e1_val\0td"),
 	},
 },
+{
+	.descr = "dedup: standalone fwd declaration struct",
+	/*
+	 * Verify that CU1:foo and CU2:foo would be unified and that
+	 * typedef/ptr would be updated to point to CU1:foo.
+	 *
+	 * // CU 1:
+	 * struct foo { int x; };
+	 *
+	 * // CU 2:
+	 * struct foo;
+	 * typedef struct foo *foo_ptr;
+	 */
+	.input = {
+		.raw_types = {
+			/* CU 1 */
+			BTF_STRUCT_ENC(NAME_NTH(1), 1, 4),             /* [1] */
+			BTF_MEMBER_ENC(NAME_NTH(2), 2, 0),
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), /* [2] */
+			/* CU 2 */
+			BTF_FWD_ENC(NAME_NTH(1), 0),                   /* [3] */
+			BTF_PTR_ENC(3),                                /* [4] */
+			BTF_TYPEDEF_ENC(NAME_NTH(3), 4),               /* [5] */
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0foo\0x\0foo_ptr"),
+	},
+	.expect = {
+		.raw_types = {
+			BTF_STRUCT_ENC(NAME_NTH(1), 1, 4),             /* [1] */
+			BTF_MEMBER_ENC(NAME_NTH(2), 2, 0),
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), /* [2] */
+			BTF_PTR_ENC(1),                                /* [3] */
+			BTF_TYPEDEF_ENC(NAME_NTH(3), 3),               /* [4] */
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0foo\0x\0foo_ptr"),
+	},
+},
+{
+	.descr = "dedup: standalone fwd declaration union",
+	/*
+	 * Verify that CU1:foo and CU2:foo would be unified and that
+	 * typedef/ptr would be updated to point to CU1:foo.
+	 * Same as "dedup: standalone fwd declaration struct" but for unions.
+	 *
+	 * // CU 1:
+	 * union foo { int x; };
+	 *
+	 * // CU 2:
+	 * union foo;
+	 * typedef union foo *foo_ptr;
+	 */
+	.input = {
+		.raw_types = {
+			/* CU 1 */
+			BTF_UNION_ENC(NAME_NTH(1), 1, 4),              /* [1] */
+			BTF_MEMBER_ENC(NAME_NTH(2), 2, 0),
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), /* [2] */
+			/* CU 2 */
+			BTF_FWD_ENC(NAME_TBD, 1),                      /* [3] */
+			BTF_PTR_ENC(3),                                /* [4] */
+			BTF_TYPEDEF_ENC(NAME_NTH(3), 4),               /* [5] */
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0foo\0x\0foo_ptr"),
+	},
+	.expect = {
+		.raw_types = {
+			BTF_UNION_ENC(NAME_NTH(1), 1, 4),              /* [1] */
+			BTF_MEMBER_ENC(NAME_NTH(2), 2, 0),
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), /* [2] */
+			BTF_PTR_ENC(1),                                /* [3] */
+			BTF_TYPEDEF_ENC(NAME_NTH(3), 3),               /* [4] */
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0foo\0x\0foo_ptr"),
+	},
+},
+{
+	.descr = "dedup: standalone fwd declaration wrong kind",
+	/*
+	 * Negative test for btf_dedup_resolve_fwds:
+	 * - CU1:foo is a struct, C2:foo is a union, thus CU2:foo is not deduped;
+	 * - typedef/ptr should remain unchanged as well.
+	 *
+	 * // CU 1:
+	 * struct foo { int x; };
+	 *
+	 * // CU 2:
+	 * union foo;
+	 * typedef union foo *foo_ptr;
+	 */
+	.input = {
+		.raw_types = {
+			/* CU 1 */
+			BTF_STRUCT_ENC(NAME_NTH(1), 1, 4),             /* [1] */
+			BTF_MEMBER_ENC(NAME_NTH(2), 2, 0),
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), /* [2] */
+			/* CU 2 */
+			BTF_FWD_ENC(NAME_NTH(3), 1),                   /* [3] */
+			BTF_PTR_ENC(3),                                /* [4] */
+			BTF_TYPEDEF_ENC(NAME_NTH(3), 4),               /* [5] */
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0foo\0x\0foo_ptr"),
+	},
+	.expect = {
+		.raw_types = {
+			/* CU 1 */
+			BTF_STRUCT_ENC(NAME_NTH(1), 1, 4),             /* [1] */
+			BTF_MEMBER_ENC(NAME_NTH(2), 2, 0),
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), /* [2] */
+			/* CU 2 */
+			BTF_FWD_ENC(NAME_NTH(3), 1),                   /* [3] */
+			BTF_PTR_ENC(3),                                /* [4] */
+			BTF_TYPEDEF_ENC(NAME_NTH(3), 4),               /* [5] */
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0foo\0x\0foo_ptr"),
+	},
+},
+{
+	.descr = "dedup: standalone fwd declaration name conflict",
+	/*
+	 * Negative test for btf_dedup_resolve_fwds:
+	 * - two candidates for CU2:foo dedup, thus it is unchanged;
+	 * - typedef/ptr should remain unchanged as well.
+	 *
+	 * // CU 1:
+	 * struct foo { int x; };
+	 *
+	 * // CU 2:
+	 * struct foo;
+	 * typedef struct foo *foo_ptr;
+	 *
+	 * // CU 3:
+	 * struct foo { int x; int y; };
+	 */
+	.input = {
+		.raw_types = {
+			/* CU 1 */
+			BTF_STRUCT_ENC(NAME_NTH(1), 1, 4),             /* [1] */
+			BTF_MEMBER_ENC(NAME_NTH(2), 2, 0),
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), /* [2] */
+			/* CU 2 */
+			BTF_FWD_ENC(NAME_NTH(1), 0),                   /* [3] */
+			BTF_PTR_ENC(3),                                /* [4] */
+			BTF_TYPEDEF_ENC(NAME_NTH(4), 4),               /* [5] */
+			/* CU 3 */
+			BTF_STRUCT_ENC(NAME_NTH(1), 2, 8),             /* [6] */
+			BTF_MEMBER_ENC(NAME_NTH(2), 2, 0),
+			BTF_MEMBER_ENC(NAME_NTH(3), 2, 0),
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0foo\0x\0y\0foo_ptr"),
+	},
+	.expect = {
+		.raw_types = {
+			/* CU 1 */
+			BTF_STRUCT_ENC(NAME_NTH(1), 1, 4),             /* [1] */
+			BTF_MEMBER_ENC(NAME_NTH(2), 2, 0),
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), /* [2] */
+			/* CU 2 */
+			BTF_FWD_ENC(NAME_NTH(1), 0),                   /* [3] */
+			BTF_PTR_ENC(3),                                /* [4] */
+			BTF_TYPEDEF_ENC(NAME_NTH(4), 4),               /* [5] */
+			/* CU 3 */
+			BTF_STRUCT_ENC(NAME_NTH(1), 2, 8),             /* [6] */
+			BTF_MEMBER_ENC(NAME_NTH(2), 2, 0),
+			BTF_MEMBER_ENC(NAME_NTH(3), 2, 0),
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0foo\0x\0y\0foo_ptr"),
+	},
+},
 };
 
 static int btf_type_size(const struct btf_type *t)
diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c b/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c
index 90aac437576d..d9024c7a892a 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c
@@ -141,6 +141,10 @@ static void test_split_fwd_resolve() {
 	btf__add_field(btf1, "f2", 3, 64, 0);		/*      struct s2 *f2; */
 							/* } */
 	btf__add_struct(btf1, "s2", 4);			/* [5] struct s2 { */
+	btf__add_field(btf1, "f1", 1, 0, 0);		/*      int f1; */
+							/* } */
+	/* keep this not a part of type the graph to test btf_dedup_resolve_fwds */
+	btf__add_struct(btf1, "s3", 4);                 /* [6] struct s3 { */
 	btf__add_field(btf1, "f1", 1, 0, 0);		/*      int f1; */
 							/* } */
 
@@ -153,20 +157,24 @@ static void test_split_fwd_resolve() {
 		"\t'f1' type_id=2 bits_offset=0\n"
 		"\t'f2' type_id=3 bits_offset=64",
 		"[5] STRUCT 's2' size=4 vlen=1\n"
+		"\t'f1' type_id=1 bits_offset=0",
+		"[6] STRUCT 's3' size=4 vlen=1\n"
 		"\t'f1' type_id=1 bits_offset=0");
 
 	btf2 = btf__new_empty_split(btf1);
 	if (!ASSERT_OK_PTR(btf2, "empty_split_btf"))
 		goto cleanup;
 
-	btf__add_int(btf2, "int", 4, BTF_INT_SIGNED);	/* [6] int */
-	btf__add_ptr(btf2, 10);				/* [7] ptr to struct s1 */
-	btf__add_fwd(btf2, "s2", BTF_FWD_STRUCT);	/* [8] fwd for struct s2 */
-	btf__add_ptr(btf2, 8);				/* [9] ptr to fwd struct s2 */
-	btf__add_struct(btf2, "s1", 16);		/* [10] struct s1 { */
-	btf__add_field(btf2, "f1", 7, 0, 0);		/*      struct s1 *f1; */
-	btf__add_field(btf2, "f2", 9, 64, 0);		/*      struct s2 *f2; */
+	btf__add_int(btf2, "int", 4, BTF_INT_SIGNED);	/* [7] int */
+	btf__add_ptr(btf2, 11);				/* [8] ptr to struct s1 */
+	btf__add_fwd(btf2, "s2", BTF_FWD_STRUCT);	/* [9] fwd for struct s2 */
+	btf__add_ptr(btf2, 9);				/* [10] ptr to fwd struct s2 */
+	btf__add_struct(btf2, "s1", 16);		/* [11] struct s1 { */
+	btf__add_field(btf2, "f1", 8, 0, 0);		/*      struct s1 *f1; */
+	btf__add_field(btf2, "f2", 10, 64, 0);		/*      struct s2 *f2; */
 							/* } */
+	btf__add_fwd(btf2, "s3", BTF_FWD_STRUCT);	/* [12] fwd for struct s3 */
+	btf__add_ptr(btf2, 12);				/* [13] ptr to struct s1 */
 
 	VALIDATE_RAW_BTF(
 		btf2,
@@ -178,13 +186,17 @@ static void test_split_fwd_resolve() {
 		"\t'f2' type_id=3 bits_offset=64",
 		"[5] STRUCT 's2' size=4 vlen=1\n"
 		"\t'f1' type_id=1 bits_offset=0",
-		"[6] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
-		"[7] PTR '(anon)' type_id=10",
-		"[8] FWD 's2' fwd_kind=struct",
-		"[9] PTR '(anon)' type_id=8",
-		"[10] STRUCT 's1' size=16 vlen=2\n"
-		"\t'f1' type_id=7 bits_offset=0\n"
-		"\t'f2' type_id=9 bits_offset=64");
+		"[6] STRUCT 's3' size=4 vlen=1\n"
+		"\t'f1' type_id=1 bits_offset=0",
+		"[7] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[8] PTR '(anon)' type_id=11",
+		"[9] FWD 's2' fwd_kind=struct",
+		"[10] PTR '(anon)' type_id=9",
+		"[11] STRUCT 's1' size=16 vlen=2\n"
+		"\t'f1' type_id=8 bits_offset=0\n"
+		"\t'f2' type_id=10 bits_offset=64",
+		"[12] FWD 's3' fwd_kind=struct",
+		"[13] PTR '(anon)' type_id=12");
 
 	err = btf__dedup(btf2, NULL);
 	if (!ASSERT_OK(err, "btf_dedup"))
@@ -199,7 +211,10 @@ static void test_split_fwd_resolve() {
 		"\t'f1' type_id=2 bits_offset=0\n"
 		"\t'f2' type_id=3 bits_offset=64",
 		"[5] STRUCT 's2' size=4 vlen=1\n"
-		"\t'f1' type_id=1 bits_offset=0");
+		"\t'f1' type_id=1 bits_offset=0",
+		"[6] STRUCT 's3' size=4 vlen=1\n"
+		"\t'f1' type_id=1 bits_offset=0",
+		"[7] PTR '(anon)' type_id=6");
 
 cleanup:
 	btf__free(btf2);
-- 
2.34.1

