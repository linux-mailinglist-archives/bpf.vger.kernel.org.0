Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88EC61E5E8
	for <lists+bpf@lfdr.de>; Sun,  6 Nov 2022 21:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiKFU3w (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 6 Nov 2022 15:29:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiKFU3v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 6 Nov 2022 15:29:51 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0904BC2D
        for <bpf@vger.kernel.org>; Sun,  6 Nov 2022 12:29:49 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id t25-20020a1c7719000000b003cfa34ea516so1261227wmi.1
        for <bpf@vger.kernel.org>; Sun, 06 Nov 2022 12:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zeYpBI/Zis9oRLlLkun7Q/n0Uulsc8veDV2HLGI+YVE=;
        b=n/2q0eMIyPl99UdtZobk9D8htM16sFNfNRJPTPBboFypl1HKjT0gK/5G2uzFkBbVWi
         2TN1MvDHQDmcYj3VDmQwP85Ih0XdsdWxw5xYoGmNHtI6hcYM2gRvpYymTDwODcX7AE6I
         aYw3xBZhzeNwlU6K7l2e3EYB3LN8F1ksOL1AXIDjF8FV7pL63gNAC+QdsI7x0fxMXzZ6
         2NO+KJxUBPscH+76YHmzUcT1A4QvnPDIIJJsqj/6f/rGSHcu+LOUjALQBin/8lgoDvoh
         08nB9O0VxE9aMo9n171JS4V2BVsUz0nr70OlUtLh6UQlQBfRITQUBqZAk/X3yKbQJyKq
         Wl4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zeYpBI/Zis9oRLlLkun7Q/n0Uulsc8veDV2HLGI+YVE=;
        b=Sg/RFJneY96Ddmc+cwlZV8r0hQ1A3LzHCGI2GpNb/BGxBeZADXTGe5uWteRnxhKc7N
         1au0LdNN0S8K30klYdmNsnoNF/1r/q/NJNRL6hc2RZI/RZtBFbwK51S4+/4p+5rol7jB
         7t4mbPy/YGL9xpaHzGx3niTWu90KfulcpYPEcglFxPB9ZSlYqTcyuIgtBrqpkMR2LesZ
         x1JG0/K3bq5sH/SWanuBgzCHwIMiX3TqoWJNOi51DCVew9a9BtTel0mARPuhTBaBVYbM
         Smy8lEtF9Y1dvxvyWLYtzr3bsXdmK1miHvuUmyakxCaZy6nXAlwiGyI1GqnXMIemO84s
         hT9g==
X-Gm-Message-State: ACrzQf3t2OWvTYSBjQ6VmZKijbu5WMDCDRuqP5i9A3Es05FrQ54rZXaT
        a+dm+MM4nr1iqSIxXpqng468MpKbF07f3U0W
X-Google-Smtp-Source: AMsMyM5+95pmFOff/yQr2GnYKVhwA1zDjKe1gOz+ao0Y/kBsL+wDsS+k4g0V/72x9E6S0o+YXi5Q2A==
X-Received: by 2002:a7b:ca52:0:b0:3cf:5c22:cbee with SMTP id m18-20020a7bca52000000b003cf5c22cbeemr30575412wml.97.1667766588212;
        Sun, 06 Nov 2022 12:29:48 -0800 (PST)
Received: from pluto.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id q188-20020a1c43c5000000b003cf894c05e4sm9358636wma.22.2022.11.06.12.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 12:29:47 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, alan.maguire@oracle.com, acme@kernel.org,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 3/3] selftests/bpf: Tests for btf_dedup_resolve_fwds
Date:   Sun,  6 Nov 2022 22:29:10 +0200
Message-Id: <20221106202910.4193104-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221106202910.4193104-1-eddyz87@gmail.com>
References: <20221106202910.4193104-1-eddyz87@gmail.com>
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

