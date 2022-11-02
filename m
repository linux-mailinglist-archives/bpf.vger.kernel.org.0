Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61E061618B
	for <lists+bpf@lfdr.de>; Wed,  2 Nov 2022 12:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbiKBLNM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Nov 2022 07:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiKBLNH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Nov 2022 07:13:07 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A7E2937E
        for <bpf@vger.kernel.org>; Wed,  2 Nov 2022 04:12:53 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id c25so11078183ljr.8
        for <bpf@vger.kernel.org>; Wed, 02 Nov 2022 04:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hNbQUzjBtjO3QWinhEl3sibDYUNji+fk6J83E9vQcI=;
        b=R76yTO56LDeiAxi+CYa1RTUQ4rLF1ZujHFJnzYpxORSMGw/YWWcEgh63HVlhv75gy6
         X9LteWrolxY3vbofann9caOgkUZmv2HfJmPllzOCeN/uqJXQ77CdjUdAys8dWYq5PbCH
         nULwFy2Ec3lVKME35m+yhHMNRegzKsimUMFOFm5uZ2KV5xKaZ2KnBuT9VypXHbgAhGRw
         GvXXEt3pCQ3KdfFLQR5mODWtYoAef/KeUQxKO5IMBQvMuU4jDf/IXSJB5bEgZfd3jlS0
         oHpK9K11gcBtXPjj1OWOqbKtlfKWUKRSt69Efpk0aZpB27ZQjaNeJOy3R4rP6H7QP9pa
         muuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/hNbQUzjBtjO3QWinhEl3sibDYUNji+fk6J83E9vQcI=;
        b=u1afoORTUAV3ic+98NGgRgQqQKxdcZ9nQ/ctCf81gJwnf2yMBAGNF5rQOLp/MJV8yj
         vl26XQfwF7NK3WinafBNsjWzZnIbKJ02B2CYZOiTwldNGNI0Xpg1ZU5VyE6PKCg2TkU3
         v0n5MCdIyf0sapQaR5pcbb3gFdKO3/nlCg6gT87cTK9ZzkxoXdt5tjn9hCk4po/Ddj92
         jp5rYxmAQC84BUGWuZr2r26ylr2p+jhkQLvYIGQMhEUjpZthxOU/TFw9d6JAUbqgRN8i
         90vkgJh5HxRx9VsYqEYNOfb4I1tTlBxkTBCbJJGGewDTAKl5G2f0KvbG/P+IHwHlguY9
         YiwA==
X-Gm-Message-State: ACrzQf1SbhSuoghrkFhjeZd6PnlWmV9dQppjdQ+06XLHsDmgovB46hEc
        Bh9ZdteYILJ+NfjGdb0fZIsrhW2155jxwgvS
X-Google-Smtp-Source: AMsMyM5Pt+ppi7RDLCKAnQvzwEqmVf4+8YFAoJWBIiSAicVrhGgQcrXtwp78oKbe5tO1M6XBoC9RUw==
X-Received: by 2002:a2e:894c:0:b0:277:1e3e:fbc8 with SMTP id b12-20020a2e894c000000b002771e3efbc8mr8595945ljk.301.1667387395196;
        Wed, 02 Nov 2022 04:09:55 -0700 (PDT)
Received: from pluto.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id a6-20020a05651c010600b0026dcac60624sm2039781ljb.108.2022.11.02.04.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 04:09:54 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, alan.maguire@oracle.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 4/4] selftests/bpf: Tests for btf_dedup_resolve_fwds
Date:   Wed,  2 Nov 2022 13:09:05 +0200
Message-Id: <20221102110905.2433622-5-eddyz87@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221102110905.2433622-1-eddyz87@gmail.com>
References: <20221102110905.2433622-1-eddyz87@gmail.com>
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
---
 tools/testing/selftests/bpf/prog_tests/btf.c  | 152 ++++++++++++++++++
 .../bpf/prog_tests/btf_dedup_split.c          |  45 ++++--
 2 files changed, 182 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index 127b8caa3dc1..f14020d51ab9 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -7598,6 +7598,158 @@ static struct btf_dedup_test dedup_tests[] = {
 		BTF_STR_SEC("\0e1\0e1_val"),
 	},
 },
+{
+	.descr = "dedup: standalone fwd declaration struct",
+	/*
+	 * // CU 1:
+	 * struct foo { int x; };
+	 * struct foo *a;
+	 *
+	 * // CU 2:
+	 * struct foo;
+	 * struct foo *b;
+	 */
+	.input = {
+		.raw_types = {
+			BTF_STRUCT_ENC(NAME_NTH(1), 1, 4),             /* [1] */
+			BTF_MEMBER_ENC(NAME_NTH(2), 2, 0),
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), /* [2] */
+			BTF_PTR_ENC(1),                                /* [3] */
+			BTF_FWD_ENC(NAME_TBD, 0),                      /* [4] */
+			BTF_PTR_ENC(4),                                /* [5] */
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0foo\0x"),
+	},
+	.expect = {
+		.raw_types = {
+			BTF_STRUCT_ENC(NAME_NTH(1), 1, 4),             /* [1] */
+			BTF_MEMBER_ENC(NAME_NTH(2), 2, 0),
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), /* [2] */
+			BTF_PTR_ENC(1),                                /* [3] */
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0foo\0x"),
+	},
+},
+{
+	.descr = "dedup: standalone fwd declaration union",
+	/*
+	 * // CU 1:
+	 * union foo { int x; };
+	 * union foo *another_global;
+	 *
+	 * // CU 2:
+	 * union foo;
+	 * union foo *some_global;
+	 */
+	.input = {
+		.raw_types = {
+			BTF_UNION_ENC(NAME_NTH(1), 1, 4),              /* [1] */
+			BTF_MEMBER_ENC(NAME_NTH(2), 2, 0),
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), /* [2] */
+			BTF_PTR_ENC(1),                                /* [3] */
+			BTF_FWD_ENC(NAME_TBD, 1),                      /* [4] */
+			BTF_PTR_ENC(4),                                /* [5] */
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0foo\0x"),
+	},
+	.expect = {
+		.raw_types = {
+			BTF_UNION_ENC(NAME_NTH(1), 1, 4),              /* [1] */
+			BTF_MEMBER_ENC(NAME_NTH(2), 2, 0),
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), /* [2] */
+			BTF_PTR_ENC(1),                                /* [3] */
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0foo\0x"),
+	},
+},
+{
+	.descr = "dedup: standalone fwd declaration wrong kind",
+	/*
+	 * // CU 1:
+	 * struct foo { int x; };
+	 * struct foo *b;
+	 *
+	 * // CU 2:
+	 * union foo;
+	 * union foo *a;
+	 */
+	.input = {
+		.raw_types = {
+			BTF_STRUCT_ENC(NAME_NTH(1), 1, 4),             /* [1] */
+			BTF_MEMBER_ENC(NAME_NTH(2), 2, 0),
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), /* [2] */
+			BTF_PTR_ENC(1),                                /* [3] */
+			BTF_FWD_ENC(NAME_TBD, 1),                      /* [4] */
+			BTF_PTR_ENC(4),                                /* [5] */
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0foo\0x"),
+	},
+	.expect = {
+		.raw_types = {
+			BTF_STRUCT_ENC(NAME_NTH(1), 1, 4),             /* [1] */
+			BTF_MEMBER_ENC(NAME_NTH(2), 2, 0),
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), /* [2] */
+			BTF_PTR_ENC(1),                                /* [3] */
+			BTF_FWD_ENC(NAME_TBD, 1),                      /* [4] */
+			BTF_PTR_ENC(4),                                /* [5] */
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0foo\0x"),
+	},
+},
+{
+	.descr = "dedup: standalone fwd declaration name conflict",
+	/*
+	 * // CU 1:
+	 * struct foo { int x; };
+	 * struct foo *a;
+	 *
+	 * // CU 2:
+	 * struct foo;
+	 * struct foo *b;
+	 *
+	 * // CU 3:
+	 * struct foo { int x; int y; };
+	 * struct foo *c;
+	 */
+	.input = {
+		.raw_types = {
+			BTF_STRUCT_ENC(NAME_NTH(1), 1, 4),             /* [1] */
+			BTF_MEMBER_ENC(NAME_NTH(2), 2, 0),
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), /* [2] */
+			BTF_PTR_ENC(1),                                /* [3] */
+			BTF_FWD_ENC(NAME_TBD, 0),                      /* [4] */
+			BTF_PTR_ENC(4),                                /* [5] */
+			BTF_STRUCT_ENC(NAME_NTH(1), 2, 8),             /* [6] */
+			BTF_MEMBER_ENC(NAME_NTH(2), 2, 0),
+			BTF_MEMBER_ENC(NAME_NTH(3), 2, 0),
+			BTF_PTR_ENC(6),                                /* [7] */
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0foo\0x\0y"),
+	},
+	.expect = {
+		.raw_types = {
+			BTF_STRUCT_ENC(NAME_NTH(1), 1, 4),             /* [1] */
+			BTF_MEMBER_ENC(NAME_NTH(2), 2, 0),
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), /* [2] */
+			BTF_PTR_ENC(1),                                /* [3] */
+			BTF_FWD_ENC(NAME_TBD, 0),                      /* [4] */
+			BTF_PTR_ENC(4),                                /* [5] */
+			BTF_STRUCT_ENC(NAME_NTH(1), 2, 8),             /* [6] */
+			BTF_MEMBER_ENC(NAME_NTH(2), 2, 0),
+			BTF_MEMBER_ENC(NAME_NTH(3), 2, 0),
+			BTF_PTR_ENC(6),                                /* [7] */
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0foo\0x\0y"),
+	},
+},
 
 };
 
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

