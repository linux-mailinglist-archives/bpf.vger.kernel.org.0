Return-Path: <bpf+bounces-72327-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2127EC0E2FF
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 14:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13E9C188B77C
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 13:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CC1308F35;
	Mon, 27 Oct 2025 13:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ls/pWkuR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362B43081D4
	for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 13:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761573281; cv=none; b=Q9HOqupGaJrHF5te5YZUyTPhp+g3g7qyIMA7TyKRZhbNfCh6MMzODMR2Vewnz4ekh6s2X5tkqkPg3z4kRd41ajasprIbKrVzx20m92SjuY5osyJ8bfw12nbGdra6nFgAenRHTqlfEyL5qKO4Iagu85HPxqLXfh+HvwzQuPSdcg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761573281; c=relaxed/simple;
	bh=a2vWknJBLfGI/zn/aoQrvNPJmduxdpV0+V2L95agYGo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JQMIT3N778TRNT+qKUytU99A15k1f3KWqyjxs298R/aIDk6E9jckHXjQpzopdSSZON9qOS23WcnRZH99xDty+cBVQoIkDpUsvUYWL9jI+hkczDLLUWVuaWjvTQCWNjtpNe8Lh0RgLS103U51IdmZOCu/1RlzLn+AY+eVjdhNWV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ls/pWkuR; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-78125ed4052so5594906b3a.0
        for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 06:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761573279; x=1762178079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PULKnB7zB8mjvxqnQKYFYWmpI5jL7Y4AmR36CypPlxc=;
        b=ls/pWkuRZfztTsMi4aUO50AvMIAijbkkP/kRisxGBVOsHTaPaJHH9LBkTp631SuEmU
         pHCpY3gPUjve8lYVxW4intZyqtm7mkWoEWO8FxA9aNkHC6wqdI2FMuJkyKer29au5QDN
         4SHlTPUaZbbIPfnV4iwa7+KrARyzFUKxDOy+ewPM1laabpdbUELYr0DH8YBRGJ0cQAjp
         8mVBH/+wz0nv2PY25+3TsEOwJr5lXoP/p+9iCr3C3d57TSwxhd7lP+08pDd2yB5/d9BZ
         AdJWgMEPCve6xsZiSYZiGcdem43CffR+DlBGdT/a4mrESScxyL9wjleQAyNX0oWucQor
         N9Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761573279; x=1762178079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PULKnB7zB8mjvxqnQKYFYWmpI5jL7Y4AmR36CypPlxc=;
        b=PuX+5PiZmMok+KI5K+NW0kCORN1ZNx89EBkUfJxBEYpNhM1w183gZDXqClVpchuFHk
         v2+tZCKS0fugwT/8Dd25HEQA53iVvrLlyY20trDf5MaF82squKBtCg1Rx2FJhO9Rdy8I
         f8X7DutGkCFOqSW/xJKDMaD9qrWia0xwpKi/f7RQrIJkBj0PVBwPxv8agDB9BG82VZi9
         padM1M9Ftsg08aaQ31nGmyQ1NJGkv1Yw4gyT5JiU38WS9lxYy28JdWXbHvXBUMFQXGTG
         pnzdS+c1IVqtusWTYsrEC62dv2IztCwRShOUvT+EB5EP6GILoL0q9dASKf6suQ2MY99d
         awEA==
X-Forwarded-Encrypted: i=1; AJvYcCUpoMTiEGajqsYAPYRkKzKm+5hltqk+pCo/UErkRGLW41RWb5FFMaxQOY3ETNl3mbVQg4o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg+SfgrK8Uxt40jANugYxC7KfKcUdTTvtPG5PH23QTFhwRSU0i
	557VAoJlrwyobJ7OMqQtuh3nl23cZeKpqfDL5n0Xag+IZGNF2So7TpDa
X-Gm-Gg: ASbGncuY4eO8AIVix5u1ZfpDL5iWX74vy+H/XJbXD/oL+kTs1TG1HK1+fV4m+OyEszy
	3QgagieQMdsMzbsa0giqSOi7Cv3oBJXjpVAEo3viwjK+R2OPRmxyUgondoOC39J/fdBYa0/ANpf
	ZeSZ9u6qJLmhZ8tEoYG9JfujiUDj3kvu0dPQEyTGs2KtMCE5wJdrYNoEaji1s0WeGsyNdZuJHb7
	Aku2Xm02q/ZYlds58RWN8vK3L7iHKdpeDxRHdJmlzks9F146yW0Zt0bh4sdXIFM5fdYRcixgsj/
	CZ2LVj+ZmwkebVQuRv8v4nNkSRe2dz+rR5Nos8Bab2Hmuhl6f/s7eu+xD/3HmLRs/Pdovwx59p3
	/fA76H8Ec7JPBY6t6RApIEOpXo1CwR8XnyXcWX/6doK243KUWvQ0hlQR4nyKs2+V0vBYBiFvYeJ
	n4LmaDp6yqxCTn0Qx/Y2Hkafpygf0=
X-Google-Smtp-Source: AGHT+IFnV9PyudavkwUaPZ+kQ2ILlWTFIEiZjdh7kZ2svze02eKMLqOGH6tVrMcgIL5JQBCMaj65Ug==
X-Received: by 2002:a05:6a20:918c:b0:33d:5411:261b with SMTP id adf61e73a8af0-33d54112630mr16917813637.26.1761573279427;
        Mon, 27 Oct 2025 06:54:39 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed70a83csm8574361a91.4.2025.10.27.06.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 06:54:38 -0700 (PDT)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Donglin Peng <dolinux.peng@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Song Liu <song@kernel.org>,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [RFC PATCH v3 2/3] selftests/bpf: add tests for BTF type permutation
Date: Mon, 27 Oct 2025 21:54:22 +0800
Message-Id: <20251027135423.3098490-3-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251027135423.3098490-1-dolinux.peng@gmail.com>
References: <20251027135423.3098490-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Verify that BTF type permutation functionality works correctly.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Song Liu <song@kernel.org>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/btf.c | 109 ++++++++++++++++---
 1 file changed, 94 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index 8a9ba4292109..0688449613d4 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -6935,14 +6935,18 @@ struct btf_raw_data {
 	__u32 str_sec_size;
 };
 
-struct btf_dedup_test {
+struct btf_dedup_permute_test {
 	const char *descr;
 	struct btf_raw_data input;
 	struct btf_raw_data expect;
-	struct btf_dedup_opts opts;
+	bool permute;
+	struct btf_dedup_opts dedup_opts;
+	struct btf_permute_opts permute_opts;
 };
 
-static struct btf_dedup_test dedup_tests[] = {
+static __u32 permute_ids_sort_by_kind_name[] = {3, 4, 5, 8, 11, 14, 6, 9, 12, 15, 7, 10, 13, 16, 1, 2};
+
+static struct btf_dedup_permute_test dedup_permute_tests[] = {
 
 {
 	.descr = "dedup: unused strings filtering",
@@ -7105,7 +7109,7 @@ static struct btf_dedup_test dedup_tests[] = {
 		},
 		BTF_STR_SEC("\0s\0x"),
 	},
-	.opts = {
+	.dedup_opts = {
 		.force_collisions = true, /* force hash collisions */
 	},
 },
@@ -7151,7 +7155,7 @@ static struct btf_dedup_test dedup_tests[] = {
 		},
 		BTF_STR_SEC("\0s\0x"),
 	},
-	.opts = {
+	.dedup_opts = {
 		.force_collisions = true, /* force hash collisions */
 	},
 },
@@ -7354,7 +7358,7 @@ static struct btf_dedup_test dedup_tests[] = {
 		},
 		BTF_STR_SEC("\0.bss\0t"),
 	},
-	.opts = {
+	.dedup_opts = {
 		.force_collisions = true
 	},
 },
@@ -8022,6 +8026,72 @@ static struct btf_dedup_test dedup_tests[] = {
 		BTF_STR_SEC("\0foo\0x\0y\0foo_ptr"),
 	},
 },
+{
+	.descr = "permute: func/func_param/struct/struct_member tags",
+	.input = {
+		.raw_types = {
+			/* int */
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+			/* void f(int a1, int a2) */
+			BTF_FUNC_PROTO_ENC(0, 2),			/* [2] */
+				BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(1), 1),
+				BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(2), 1),
+			BTF_FUNC_ENC(NAME_NTH(3), 2),			/* [3] */
+			/* struct t {int m1; int m2;} */
+			BTF_STRUCT_ENC(NAME_NTH(4), 2, 8),		/* [4] */
+				BTF_MEMBER_ENC(NAME_NTH(5), 1, 0),
+				BTF_MEMBER_ENC(NAME_NTH(6), 1, 32),
+			/* tag -> f: tag1, tag2, tag3 */
+			BTF_DECL_TAG_ENC(NAME_NTH(7), 3, -1),		/* [5] */
+			BTF_DECL_TAG_ENC(NAME_NTH(8), 3, -1),		/* [6] */
+			BTF_DECL_TAG_ENC(NAME_NTH(9), 3, -1),		/* [7] */
+			/* tag -> f/a2: tag1, tag2, tag3 */
+			BTF_DECL_TAG_ENC(NAME_NTH(7), 3, 1),		/* [8] */
+			BTF_DECL_TAG_ENC(NAME_NTH(8), 3, 1),		/* [9] */
+			BTF_DECL_TAG_ENC(NAME_NTH(9), 3, 1),		/* [10] */
+			/* tag -> t: tag1, tag2, tag3 */
+			BTF_DECL_TAG_ENC(NAME_NTH(7), 4, -1),		/* [11] */
+			BTF_DECL_TAG_ENC(NAME_NTH(8), 4, -1),		/* [12] */
+			BTF_DECL_TAG_ENC(NAME_NTH(9), 4, -1),		/* [13] */
+			/* tag -> t/m2: tag1, tag3 */
+			BTF_DECL_TAG_ENC(NAME_NTH(7), 4, 1),		/* [14] */
+			BTF_DECL_TAG_ENC(NAME_NTH(8), 4, 1),		/* [15] */
+			BTF_DECL_TAG_ENC(NAME_NTH(9), 4, 1),		/* [16] */
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0a1\0a2\0f\0t\0m1\0m2\0tag1\0tag2\0tag3"),
+	},
+	.expect = {
+		.raw_types = {
+			BTF_FUNC_ENC(NAME_NTH(3), 16),			/* [1] */
+			BTF_STRUCT_ENC(NAME_NTH(4), 2, 8),		/* [2] */
+				BTF_MEMBER_ENC(NAME_NTH(5), 15, 0),
+				BTF_MEMBER_ENC(NAME_NTH(6), 15, 32),
+			BTF_DECL_TAG_ENC(NAME_NTH(7), 1, -1),		/* [3] */
+			BTF_DECL_TAG_ENC(NAME_NTH(7), 1,  1),		/* [4] */
+			BTF_DECL_TAG_ENC(NAME_NTH(7), 2, -1),		/* [5] */
+			BTF_DECL_TAG_ENC(NAME_NTH(7), 2,  1),		/* [6] */
+			BTF_DECL_TAG_ENC(NAME_NTH(8), 1, -1),		/* [7] */
+			BTF_DECL_TAG_ENC(NAME_NTH(8), 1,  1),		/* [8] */
+			BTF_DECL_TAG_ENC(NAME_NTH(8), 2, -1),		/* [9] */
+			BTF_DECL_TAG_ENC(NAME_NTH(8), 2,  1),		/* [10] */
+			BTF_DECL_TAG_ENC(NAME_NTH(9), 1, -1),		/* [11] */
+			BTF_DECL_TAG_ENC(NAME_NTH(9), 1,  1),		/* [12] */
+			BTF_DECL_TAG_ENC(NAME_NTH(9), 2, -1),		/* [13] */
+			BTF_DECL_TAG_ENC(NAME_NTH(9), 2,  1),		/* [14] */
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [15] */
+			BTF_FUNC_PROTO_ENC(0, 2),			/* [16] */
+				BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(1), 15),
+				BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(2), 15),
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0a1\0a2\0f\0t\0m1\0m2\0tag1\0tag2\0tag3"),
+	},
+	.permute = true,
+	.permute_opts = {
+		.ids = permute_ids_sort_by_kind_name,
+	},
+},
 };
 
 static int btf_type_size(const struct btf_type *t)
@@ -8078,9 +8148,9 @@ static void dump_btf_strings(const char *strs, __u32 len)
 	}
 }
 
-static void do_test_dedup(unsigned int test_num)
+static void do_test_dedup_permute(unsigned int test_num)
 {
-	struct btf_dedup_test *test = &dedup_tests[test_num - 1];
+	struct btf_dedup_permute_test *test = &dedup_permute_tests[test_num - 1];
 	__u32 test_nr_types, expect_nr_types, test_btf_size, expect_btf_size;
 	const struct btf_header *test_hdr, *expect_hdr;
 	struct btf *test_btf = NULL, *expect_btf = NULL;
@@ -8124,11 +8194,20 @@ static void do_test_dedup(unsigned int test_num)
 		goto done;
 	}
 
-	test->opts.sz = sizeof(test->opts);
-	err = btf__dedup(test_btf, &test->opts);
-	if (CHECK(err, "btf_dedup failed errno:%d", err)) {
-		err = -1;
-		goto done;
+	if (test->permute) {
+		test->permute_opts.sz = sizeof(test->permute_opts);
+		err = btf__permute(test_btf, &test->permute_opts);
+		if (CHECK(err, "btf_permute failed errno:%d", err)) {
+			err = -1;
+			goto done;
+		}
+	} else {
+		test->dedup_opts.sz = sizeof(test->dedup_opts);
+		err = btf__dedup(test_btf, &test->dedup_opts);
+		if (CHECK(err, "btf_dedup failed errno:%d", err)) {
+			err = -1;
+			goto done;
+		}
 	}
 
 	test_btf_data = btf__raw_data(test_btf, &test_btf_size);
@@ -8249,7 +8328,7 @@ void test_btf(void)
 		do_test_file(i);
 	for (i = 1; i <= ARRAY_SIZE(info_raw_tests); i++)
 		do_test_info_raw(i);
-	for (i = 1; i <= ARRAY_SIZE(dedup_tests); i++)
-		do_test_dedup(i);
+	for (i = 1; i <= ARRAY_SIZE(dedup_permute_tests); i++)
+		do_test_dedup_permute(i);
 	test_pprint();
 }
-- 
2.34.1


