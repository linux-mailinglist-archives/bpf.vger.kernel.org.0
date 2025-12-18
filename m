Return-Path: <bpf+bounces-76972-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC970CCBA07
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 12:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0612D30CBE5A
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 11:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B8231A06C;
	Thu, 18 Dec 2025 11:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDlTrljC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91ECA31A067
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 11:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766057481; cv=none; b=Lqei/Kjg794Ltk4s4k51seTcOJ6hJHdLL9IMPvdnjaQy7TDk2vWTS4E/nDgoZ3jXW23FdBZsjIO8YvunuUDQOB1QaFeNO7VUWBHOzwnGTzQmGOLOnWrmxTaqCVOpsPBvIrQc0iGt3eupbly51OA3DW7JfLSLQRzT+1UJ0GYFSEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766057481; c=relaxed/simple;
	bh=TSISUcMass7QYhAsa8W20cahOnTUG1WjN3lWzxGmgQo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qY1qvNpC0JpizoAMIxYFDJAZMWYbO3pZgIy4ZpyHuPNnIPMu5fiZ3nuEJtLrb9sdGj6Wmr/rpcttdhBiKICSypntiaooOVgEV3y2skGBidB7dohsnWFX6Nho/HuJB2ubC+VMq9YCrSTWqdVH7QlfkCGpDvtmGCkTrK/lFja02Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XDlTrljC; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a0eaf55d58so10173755ad.1
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 03:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766057478; x=1766662278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7zGA7dmrO478eN5aCt6oXnO7sLpKz6iRVJEdrsHBhiU=;
        b=XDlTrljC2KRybpS8iyjHRCv6wGSQfYUQHRpJGrMrgLV9IU2e9qz+L878wfJmQFPo4a
         XWjBMuTzyStj0bsiozaug9zhp3ra0AkQgQt7WnuTeXYn2rODcdmGCcmKJWcb1LWuBsXl
         eI1HTCbRaPjyUtYIOlx2ByXNgFhG/KCB7Mbfx8hn1pj3wdwIaJBQPeSp+VaVImXRCPQV
         ZyIQwC5lqRujYbexhuJWoo6MTuF8ULF6Bn8JI8X6ZmcP3m2OQNABu/N4RTrUpqR4O+0u
         SFteRgrU33URCCYNtR81lLDgqyXBkhh3mSOYGytPQeWCXZohKx47F06IlNRJqgOUbpSd
         GhGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766057478; x=1766662278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7zGA7dmrO478eN5aCt6oXnO7sLpKz6iRVJEdrsHBhiU=;
        b=AIpTIME4og6tAP2Qtm2TqdL+lpSayda9QzpTvFhnKI01AuwBVhMophNMxCFkKkULVX
         l4y72sTxG/NTug0mzLozxCsaPQYOULv0iQ1heV9uHbocXeCc02e0fyuZVspQvK3L3Was
         3W23xl3nEOBY+WS9NyOFsVMm+tzl1+dwe+7I6RpSyHTXYmXyD0WQOPym9Y6jFAGo8P53
         1igEOY7+ArVwe7QnDts3cRfnXVfYLysDOLKzI0zyTVoe2OJ+s1ndp2Y/v86tCKKkHdoM
         e7u2AqaG5kXeRiEgYm+SZB9CgLP3qGww6l6FT5ZYvwBnt+S/vmUrECXwmBF9Dfe9w4O0
         FMNg==
X-Forwarded-Encrypted: i=1; AJvYcCWTYvAYBCs0AZFg7wKfNgCD+1p/CZqL0hX0ETJ6+2tb62udJEkvrlMeoiWs0K4Lt883h/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNeRxdn+4fSOjRvJ1lby/uBBr2CRSSlb0BzmTiegmdGuCgqpN3
	QiNvEmEVSOQ9NYdZpWjW2xBe+NUMxnmhORoAcGWhYx8kIn7NZgaIbJLU
X-Gm-Gg: AY/fxX7W8Uih3f3RdTT8bMKKvWMFR9s9qBBeIME2FVOTqwurcqgeHubzQH0dZqaM6ia
	P9y1vsMbCity4i2ms9eHe17ahCXG0zgVa4j4e5xtA/SWOExLct+cnKOQWhOMRxoBophCeeu6qCI
	M2l/iiMnju1WcHmrWzUuiy2rPv0nBy0ms5REiB+B/2da+y1eputRSZVxoH288Jncinyjbo80s3s
	m0weNwkla4rJ+6LBx5uezOgSUREbPJuzbTRUjgJE/HsA9cJtNTTkdsgrDZOIa46ts85kw2HdGc7
	aeGG2QgcH4OQohf/p7ZTqIqrMGGnFGHSflXO8CJznhd7pu7qJXzh6ogGZpGknmmoMguEPRbOCKG
	UKtdYTztZw1p4pdmNK4B6IoTULnIp+RXRJwLqb6LyOe9Yh0MEXMktCMo22hndd4ws2/tcGRD7ri
	wO+oZvN3fHJSZvIkcV78tSfGfgjWE=
X-Google-Smtp-Source: AGHT+IH0xaZFB6RRfqVHaMnqhbLC+IadB2qSroslU8dsdq2c9JIfOOsh9RXbdF8CcYUxyZFIuxV9Ng==
X-Received: by 2002:a17:90b:3c10:b0:32e:4716:d551 with SMTP id 98e67ed59e1d1-34e71dbce04mr2351008a91.6.1766057477752;
        Thu, 18 Dec 2025 03:31:17 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70d4f887sm2328237a91.3.2025.12.18.03.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 03:31:16 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org,
	andrii.nakryiko@gmail.com,
	eddyz87@gmail.com
Cc: zhangxiaoqin@xiaomi.com,
	ihor.solodrai@linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	pengdonglin <pengdonglin@xiaomi.com>,
	Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next v10 02/13] selftests/bpf: Add test cases for btf__permute functionality
Date: Thu, 18 Dec 2025 19:30:40 +0800
Message-Id: <20251218113051.455293-3-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251218113051.455293-1-dolinux.peng@gmail.com>
References: <20251218113051.455293-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

This patch introduces test cases for the btf__permute function to ensure
it works correctly with both base BTF and split BTF scenarios.

The test suite includes:
- test_permute_base: Validates permutation on base BTF
- test_permute_split: Tests permutation on split BTF

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/btf_permute.c    | 228 ++++++++++++++++++
 1 file changed, 228 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_permute.c

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_permute.c b/tools/testing/selftests/bpf/prog_tests/btf_permute.c
new file mode 100644
index 000000000000..9aa71cdf984a
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/btf_permute.c
@@ -0,0 +1,228 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Xiaomi */
+
+#include <test_progs.h>
+#include <bpf/btf.h>
+#include "btf_helpers.h"
+
+static void permute_base_check(struct btf *btf)
+{
+	VALIDATE_RAW_BTF(
+		btf,
+		"[1] STRUCT 's2' size=4 vlen=1\n"
+		"\t'm' type_id=4 bits_offset=0",
+		"[2] FUNC 'f' type_id=6 linkage=static",
+		"[3] PTR '(anon)' type_id=4",
+		"[4] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[5] STRUCT 's1' size=4 vlen=1\n"
+		"\t'm' type_id=4 bits_offset=0",
+		"[6] FUNC_PROTO '(anon)' ret_type_id=4 vlen=1\n"
+		"\t'p' type_id=3");
+}
+
+/* Ensure btf__permute work as expected with base BTF */
+static void test_permute_base(void)
+{
+	struct btf *btf;
+	__u32 permute_ids[6];
+	int start_id = 1;
+	int err;
+
+	btf = btf__new_empty();
+	if (!ASSERT_OK_PTR(btf, "empty_main_btf"))
+		return;
+
+	btf__add_int(btf, "int", 4, BTF_INT_SIGNED);	/* [1] int */
+	btf__add_ptr(btf, 1);				/* [2] ptr to int */
+	btf__add_struct(btf, "s1", 4);			/* [3] struct s1 { */
+	btf__add_field(btf, "m", 1, 0, 0);		/*       int m; */
+							/* } */
+	btf__add_struct(btf, "s2", 4);			/* [4] struct s2 { */
+	btf__add_field(btf, "m", 1, 0, 0);		/*       int m; */
+							/* } */
+	btf__add_func_proto(btf, 1);			/* [5] int (*)(int *p); */
+	btf__add_func_param(btf, "p", 2);
+	btf__add_func(btf, "f", BTF_FUNC_STATIC, 5);	/* [6] int f(int *p); */
+
+	VALIDATE_RAW_BTF(
+		btf,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[2] PTR '(anon)' type_id=1",
+		"[3] STRUCT 's1' size=4 vlen=1\n"
+		"\t'm' type_id=1 bits_offset=0",
+		"[4] STRUCT 's2' size=4 vlen=1\n"
+		"\t'm' type_id=1 bits_offset=0",
+		"[5] FUNC_PROTO '(anon)' ret_type_id=1 vlen=1\n"
+		"\t'p' type_id=2",
+		"[6] FUNC 'f' type_id=5 linkage=static");
+
+	permute_ids[1 - start_id] = 4; /* [1] -> [4] */
+	permute_ids[2 - start_id] = 3; /* [2] -> [3] */
+	permute_ids[3 - start_id] = 5; /* [3] -> [5] */
+	permute_ids[4 - start_id] = 1; /* [4] -> [1] */
+	permute_ids[5 - start_id] = 6; /* [5] -> [6] */
+	permute_ids[6 - start_id] = 2; /* [6] -> [2] */
+	err = btf__permute(btf, permute_ids, ARRAY_SIZE(permute_ids), NULL);
+	if (!ASSERT_OK(err, "btf__permute_base"))
+		goto done;
+	permute_base_check(btf);
+
+	/* id_map_cnt is invalid  */
+	permute_ids[1 - start_id] = 4; /* [1] -> [4] */
+	permute_ids[2 - start_id] = 3; /* [2] -> [3] */
+	permute_ids[3 - start_id] = 5; /* [3] -> [5] */
+	permute_ids[4 - start_id] = 1; /* [4] -> [1] */
+	permute_ids[5 - start_id] = 6; /* [5] -> [6] */
+	permute_ids[6 - start_id] = 2; /* [6] -> [2] */
+	err = btf__permute(btf, permute_ids, ARRAY_SIZE(permute_ids) - 1, NULL);
+	if (!ASSERT_ERR(err, "btf__permute_base"))
+		goto done;
+	/* BTF is not modified */
+	permute_base_check(btf);
+
+	/* Multiple types can not be mapped to the same ID */
+	permute_ids[1 - start_id] = 4;
+	permute_ids[2 - start_id] = 4;
+	permute_ids[3 - start_id] = 5;
+	permute_ids[4 - start_id] = 1;
+	permute_ids[5 - start_id] = 6;
+	permute_ids[6 - start_id] = 2;
+	err = btf__permute(btf, permute_ids, ARRAY_SIZE(permute_ids), NULL);
+	if (!ASSERT_ERR(err, "btf__permute_base"))
+		goto done;
+	/* BTF is not modified */
+	permute_base_check(btf);
+
+	/* Type ID must be valid */
+	permute_ids[1 - start_id] = 4;
+	permute_ids[2 - start_id] = 3;
+	permute_ids[3 - start_id] = 5;
+	permute_ids[4 - start_id] = 1;
+	permute_ids[5 - start_id] = 7;
+	permute_ids[6 - start_id] = 2;
+	err = btf__permute(btf, permute_ids, ARRAY_SIZE(permute_ids), NULL);
+	if (!ASSERT_ERR(err, "btf__permute_base"))
+		goto done;
+	/* BTF is not modified */
+	permute_base_check(btf);
+
+done:
+	btf__free(btf);
+}
+
+static void permute_split_check(struct btf *btf)
+{
+	VALIDATE_RAW_BTF(
+		btf,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[2] PTR '(anon)' type_id=1",
+		"[3] STRUCT 's2' size=4 vlen=1\n"
+		"\t'm' type_id=1 bits_offset=0",
+		"[4] FUNC 'f' type_id=5 linkage=static",
+		"[5] FUNC_PROTO '(anon)' ret_type_id=1 vlen=1\n"
+		"\t'p' type_id=2",
+		"[6] STRUCT 's1' size=4 vlen=1\n"
+		"\t'm' type_id=1 bits_offset=0");
+}
+
+/* Ensure btf__permute work as expected with split BTF */
+static void test_permute_split(void)
+{
+	struct btf *split_btf = NULL, *base_btf = NULL;
+	__u32 permute_ids[4];
+	int err;
+	int start_id;
+
+	base_btf = btf__new_empty();
+	if (!ASSERT_OK_PTR(base_btf, "empty_main_btf"))
+		return;
+
+	btf__add_int(base_btf, "int", 4, BTF_INT_SIGNED);	/* [1] int */
+	btf__add_ptr(base_btf, 1);				/* [2] ptr to int */
+	VALIDATE_RAW_BTF(
+		base_btf,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[2] PTR '(anon)' type_id=1");
+	split_btf = btf__new_empty_split(base_btf);
+	if (!ASSERT_OK_PTR(split_btf, "empty_split_btf"))
+		goto cleanup;
+	btf__add_struct(split_btf, "s1", 4);			/* [3] struct s1 { */
+	btf__add_field(split_btf, "m", 1, 0, 0);		/*   int m; */
+								/* } */
+	btf__add_struct(split_btf, "s2", 4);			/* [4] struct s2 { */
+	btf__add_field(split_btf, "m", 1, 0, 0);		/*   int m; */
+								/* } */
+	btf__add_func_proto(split_btf, 1);			/* [5] int (*)(int p); */
+	btf__add_func_param(split_btf, "p", 2);
+	btf__add_func(split_btf, "f", BTF_FUNC_STATIC, 5);	/* [6] int f(int *p); */
+
+	VALIDATE_RAW_BTF(
+		split_btf,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[2] PTR '(anon)' type_id=1",
+		"[3] STRUCT 's1' size=4 vlen=1\n"
+		"\t'm' type_id=1 bits_offset=0",
+		"[4] STRUCT 's2' size=4 vlen=1\n"
+		"\t'm' type_id=1 bits_offset=0",
+		"[5] FUNC_PROTO '(anon)' ret_type_id=1 vlen=1\n"
+		"\t'p' type_id=2",
+		"[6] FUNC 'f' type_id=5 linkage=static");
+
+	start_id = btf__type_cnt(base_btf);
+	permute_ids[3 - start_id] = 6; /* [3] -> [6] */
+	permute_ids[4 - start_id] = 3; /* [4] -> [3] */
+	permute_ids[5 - start_id] = 5; /* [5] -> [5] */
+	permute_ids[6 - start_id] = 4; /* [6] -> [4] */
+	err = btf__permute(split_btf, permute_ids, ARRAY_SIZE(permute_ids), NULL);
+	if (!ASSERT_OK(err, "btf__permute_split"))
+		goto cleanup;
+	permute_split_check(split_btf);
+
+	/*
+	 * For split BTF, id_map_cnt must equal to the number of types
+	 * added on top of base BTF
+	 */
+	permute_ids[3 - start_id] = 4;
+	permute_ids[4 - start_id] = 3;
+	permute_ids[5 - start_id] = 5;
+	permute_ids[6 - start_id] = 6;
+	err = btf__permute(split_btf, permute_ids, 3, NULL);
+	if (!ASSERT_ERR(err, "btf__permute_split"))
+		goto cleanup;
+	/* BTF is not modified */
+	permute_split_check(split_btf);
+
+	/* Multiple types can not be mapped to the same ID */
+	permute_ids[3 - start_id] = 4;
+	permute_ids[4 - start_id] = 3;
+	permute_ids[5 - start_id] = 3;
+	permute_ids[6 - start_id] = 6;
+	err = btf__permute(split_btf, permute_ids, 4, NULL);
+	if (!ASSERT_ERR(err, "btf__permute_split"))
+		goto cleanup;
+	/* BTF is not modified */
+	permute_split_check(split_btf);
+
+	/* Can not map to base ID */
+	permute_ids[3 - start_id] = 4;
+	permute_ids[4 - start_id] = 2;
+	permute_ids[5 - start_id] = 5;
+	permute_ids[6 - start_id] = 6;
+	err = btf__permute(split_btf, permute_ids, 4, NULL);
+	if (!ASSERT_ERR(err, "btf__permute_split"))
+		goto cleanup;
+	/* BTF is not modified */
+	permute_split_check(split_btf);
+
+cleanup:
+	btf__free(split_btf);
+	btf__free(base_btf);
+}
+
+void test_btf_permute(void)
+{
+	if (test__start_subtest("permute_base"))
+		test_permute_base();
+	if (test__start_subtest("permute_split"))
+		test_permute_split();
+}
-- 
2.34.1


