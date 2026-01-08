Return-Path: <bpf+bounces-78193-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F3CD00D77
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 04:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD0C63080AAD
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 03:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AFA27F727;
	Thu,  8 Jan 2026 03:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dl/dIZc5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2F5280317
	for <bpf@vger.kernel.org>; Thu,  8 Jan 2026 03:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767842222; cv=none; b=JUA/B0bc4E1jD7u/LpfvgRMKM6sWZd0FbTqcv+flQCGOmG1wqe6da6xyvhMf7obxDj4yAAxoLvH/5XEHbKpOx0oANCi7o5os00VM1wNX4Sts9/SsgRiZB/TpXPlZB7LKkd8FIcrTu6Kh2sdIC7mXpdyPzucLxohNgAk1TTbpBAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767842222; c=relaxed/simple;
	bh=uMiIaTuHoGp8t2XP9PDz6WtnuLCS6v4VMQ6JPWkBmY4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tl19Qv2f/qaz1cAS/4rvX1p/ln8Bt57DFXPZlbCqiIyHNq33UcB19HV1Pi3m8j+XVB4IWgp3s9UADqj/iyWCttaCCN2QmaWi4hRqvMaeV0dXsdLWQEQ5n/bRaIYMaqM1e8Wc72BxTGS4plFRc1RBP6b57ktsuXBKRWuEstdI/+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dl/dIZc5; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7fc0c1d45a4so1682423b3a.0
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 19:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767842219; x=1768447019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CLf4MD/8vWtFsjd7VfVNcjK4gNe3ynQJ9Qc+27+cU9U=;
        b=dl/dIZc5Tl0wIybKUA2TAvfnOauIbMNQtotjfjX8EsqII9ATf7+r718d/4BgSKNL7u
         O1zBRH9R9yC2TXY9X5eMXnrlkgrWHPpk8h6z/5TP0KCJx87qcOK8h6DzLjOUH/X7onYn
         e0C/s6ayxF9BcZOHvMS4ZQLDGFoZc5bpQMFdLVw67Nxi/QhziplUVQFO05Zxa+NSiv82
         IT8lFN+bdF+YKRo7KQ7RlbvAT/k1y2Y/KAZqX+tpGaRPqzPb/F7FJ37kcdXmh41JrALZ
         9CCn9q44PSDioY+zoSsMEah0BGGQfotoAGyqmbuI/+M4r1+epIYBxGu6XUjiXz4GNE1L
         dSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767842219; x=1768447019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CLf4MD/8vWtFsjd7VfVNcjK4gNe3ynQJ9Qc+27+cU9U=;
        b=g7gJgx6LqhvRAJO1TDXrDmzv1kPL8pKumFsiTZOgN4j/kfWBcPihTYId3jxijaSgtA
         CBJeMWoaoyNjYPmZg6B2sEe0vndaQ0N79414p+8cJPsx2Et9sSC2khkaAeXKpo6NbACO
         x1whYhifTnzz4Nu9qoaQ01djuKWNl+9zqeijvam/eb6UeBonF0t1sP0CA6Vos0LlVq0t
         qTUqXVyskLz+htUrHAIy0qVFtGK907BriV6ufrUqjbmODSChnuxtBDowgNMecvlcMqg+
         FwiC+iNQYw7TGluDQ2Dqegis9ZeNuvBGmXLs2SqrrJHAdqT6BtGNktP0xchnDcfHR5le
         clOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGXyvOIO53/VMdoCScaXZNohsRFLPndHGMaMbW09dcjtWBoI8QFD879kdT39gKqyXM9RM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn2nR9g688ep2PoMBC/qsmhOncuIHdw1KiXcgPlTbwa4E7K3+f
	1Xf4A/DY7FFI3/ShFzVqb2qMG58MiE1xqvOxGV0XaDu/3dOeCLP7ObQ9
X-Gm-Gg: AY/fxX51tF6SnEWCZZxZ6PuuRP1DM226whCQav4NwjKqaQ+URHPcNDX0Ld6ftYdZUt7
	CWQbfQ26niY+mUFGy1NBQo1bft2VwCCIhgWVT/d1kYtBo6K2xq0IJtz+0QhdYLvuKt0av5z2Wsu
	Nr+7ZvAT28GB/LtZjMrp39zIVEHIKZL5sPkdei0LmaTkmljBZerd4kIfc2CWXP4ocxYWAMkMIMC
	i2Z6Y7pKjWVl37TFUWPhz3XFRAhN1QQlCKlIhZocYlX+JZtBN/4PXHG00wDe1C05OjKJQj9UZRX
	zeKR7096TdkNoRdh7Nn/pXxA+YTS9fJQ51SAZwD1z33P4WZYlVXjYvJ4KHKyNu8NesU47SnDGYE
	X9YS1XnaWKwdTOOt2Euqfepef1pJ3EmHkEyuXiRyHQ1PAN1a/qiMwTUHUjNtykdw8zKXBTQGKzY
	oHuNvThnWX9pTc8dx/W2c4/iB2Ryg=
X-Google-Smtp-Source: AGHT+IFTsBBICmI7w9NUcitepK09zPoWAnQzyjPhrantNXnM2/HoGRyjqD5yGPRnMXOZspGz9cpBMA==
X-Received: by 2002:a05:6a00:23d4:b0:81b:be1d:bd51 with SMTP id d2e1a72fcca58-81bbe1dbdf9mr3181660b3a.60.1767842218725;
        Wed, 07 Jan 2026 19:16:58 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c5de655bsm6134860b3a.60.2026.01.07.19.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 19:16:58 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org,
	andrii.nakryiko@gmail.com,
	eddyz87@gmail.com
Cc: zhangxiaoqin@xiaomi.com,
	ihor.solodrai@linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Donglin Peng <pengdonglin@xiaomi.com>,
	Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next v11 02/11] selftests/bpf: Add test cases for btf__permute functionality
Date: Thu,  8 Jan 2026 11:16:36 +0800
Message-Id: <20260108031645.1350069-3-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260108031645.1350069-1-dolinux.peng@gmail.com>
References: <20260108031645.1350069-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Donglin Peng <pengdonglin@xiaomi.com>

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
Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/btf_permute.c    | 244 ++++++++++++++++++
 1 file changed, 244 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_permute.c

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_permute.c b/tools/testing/selftests/bpf/prog_tests/btf_permute.c
new file mode 100644
index 000000000000..04ade5ad77ac
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/btf_permute.c
@@ -0,0 +1,244 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Xiaomi */
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
+/* Ensure btf__permute works as expected in the base-BTF scenario */
+static void test_permute_base(void)
+{
+	struct btf *btf;
+	__u32 permute_ids[7];
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
+	permute_ids[0] = 0; /* [0] -> [0] */
+	permute_ids[1] = 4; /* [1] -> [4] */
+	permute_ids[2] = 3; /* [2] -> [3] */
+	permute_ids[3] = 5; /* [3] -> [5] */
+	permute_ids[4] = 1; /* [4] -> [1] */
+	permute_ids[5] = 6; /* [5] -> [6] */
+	permute_ids[6] = 2; /* [6] -> [2] */
+	err = btf__permute(btf, permute_ids, ARRAY_SIZE(permute_ids), NULL);
+	if (!ASSERT_OK(err, "btf__permute_base"))
+		goto done;
+	permute_base_check(btf);
+
+	/* ids[0] must be 0 for base BTF */
+	permute_ids[0] = 4; /* [0] -> [0] */
+	permute_ids[1] = 0; /* [1] -> [4] */
+	permute_ids[2] = 3; /* [2] -> [3] */
+	permute_ids[3] = 5; /* [3] -> [5] */
+	permute_ids[4] = 1; /* [4] -> [1] */
+	permute_ids[5] = 6; /* [5] -> [6] */
+	permute_ids[6] = 2; /* [6] -> [2] */
+	err = btf__permute(btf, permute_ids, ARRAY_SIZE(permute_ids), NULL);
+	if (!ASSERT_ERR(err, "btf__permute_base"))
+		goto done;
+	/* BTF is not modified */
+	permute_base_check(btf);
+
+	/* id_map_cnt is invalid */
+	permute_ids[0] = 0; /* [0] -> [0] */
+	permute_ids[1] = 4; /* [1] -> [4] */
+	permute_ids[2] = 3; /* [2] -> [3] */
+	permute_ids[3] = 5; /* [3] -> [5] */
+	permute_ids[4] = 1; /* [4] -> [1] */
+	permute_ids[5] = 6; /* [5] -> [6] */
+	permute_ids[6] = 2; /* [6] -> [2] */
+	err = btf__permute(btf, permute_ids, ARRAY_SIZE(permute_ids) - 1, NULL);
+	if (!ASSERT_ERR(err, "btf__permute_base"))
+		goto done;
+	/* BTF is not modified */
+	permute_base_check(btf);
+
+	/* Multiple types can not be mapped to the same ID */
+	permute_ids[0] = 0;
+	permute_ids[1] = 4;
+	permute_ids[2] = 4;
+	permute_ids[3] = 5;
+	permute_ids[4] = 1;
+	permute_ids[5] = 6;
+	permute_ids[6] = 2;
+	err = btf__permute(btf, permute_ids, ARRAY_SIZE(permute_ids), NULL);
+	if (!ASSERT_ERR(err, "btf__permute_base"))
+		goto done;
+	/* BTF is not modified */
+	permute_base_check(btf);
+
+	/* Type ID must be valid */
+	permute_ids[0] = 0;
+	permute_ids[1] = 4;
+	permute_ids[2] = 3;
+	permute_ids[3] = 5;
+	permute_ids[4] = 1;
+	permute_ids[5] = 7;
+	permute_ids[6] = 2;
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
+/* Ensure btf__permute works as expected in the split-BTF scenario */
+static void test_permute_split(void)
+{
+	struct btf *split_btf = NULL, *base_btf = NULL;
+	__u32 permute_ids[4];
+	int err, start_id;
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
+	err = btf__permute(split_btf, permute_ids, ARRAY_SIZE(permute_ids) - 1, NULL);
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
+	err = btf__permute(split_btf, permute_ids, ARRAY_SIZE(permute_ids), NULL);
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
+	err = btf__permute(split_btf, permute_ids, ARRAY_SIZE(permute_ids), NULL);
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


