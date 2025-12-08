Return-Path: <bpf+bounces-76259-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BF8CAC4C2
	for <lists+bpf@lfdr.de>; Mon, 08 Dec 2025 08:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16C973022F2B
	for <lists+bpf@lfdr.de>; Mon,  8 Dec 2025 07:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EB63126C9;
	Mon,  8 Dec 2025 06:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nj31hE65"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2BE3126B9
	for <bpf@vger.kernel.org>; Mon,  8 Dec 2025 06:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765175048; cv=none; b=O2GW0S6QDg+pUQtdBKGD3YPqz5SN9VU9KfKzp3z6xbtR0FmOS9p/GgbgtuaETxDZBEzLcn7zu+dXzctM0STvkOV1UJRY9fpPf7N09RB3151XHyVvNL0op92zt18Ay+qzhk6aR1gcJhkJr1vvn+eA27m+LUEy37ledvXduKdFKQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765175048; c=relaxed/simple;
	bh=7ngEULL678quRrsmJ39omINLf8wh8oMlVDKhnztkP/E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nejVd1LKy5+M75wvMafuaky1hyx9D/7BVJCulNHye5VHC1dAnYPgii6hhBMz8uFMPR9dGKWSWo9XdpIB8s4HeHvGdLz+6wGaFNEcYwjqdHVJ1hKeFPkqow4yKLYHCEsv+yVBCZSm6pYfpo0BYrK8Uf9a+9H2XEbKhiD/azaaXek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nj31hE65; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-29e1b8be48fso9997715ad.1
        for <bpf@vger.kernel.org>; Sun, 07 Dec 2025 22:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765175046; x=1765779846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qbxRcU+iIJswxukru9rEL0qIQsiT5P658wY0LXDT54=;
        b=nj31hE651SuQWFv6TNcZkwiCRP8BO6KFIg4XxO5uqBQEPsv3aqkHf3UG0AAtFPWbPb
         oyblZjQ5wrTR1h7sZBqZOoQqndqSQcX/0UZBNnV+jUPMUqWqI/Fwg5b2OlssiyL36tMV
         2pzEtXGf5m+owB2FtlyU3zA9hzgxABzKFIKxM6WG0tLgu0bpZRQmJ2hrzIY4dmXMiGl2
         uSiWr26oszLmsYQ6zL+rsNSeXmTndMqqvdovTKOv5A1l4M2hv3FiLp8XjgA38ay5tQZ2
         4XADNuYeMcAfn9g9o0XZqcELP+iwt3RpcOFaTEWOF/0gatFzfj5fyozMOFh7QbT4MF9c
         /psg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765175046; x=1765779846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9qbxRcU+iIJswxukru9rEL0qIQsiT5P658wY0LXDT54=;
        b=pnLCyZDq5jtLqIJbqeB/2oAlVjyt06mdfsilGVAGbLvftyeX2pgmj4d5iWCDDywc4t
         JNlv4TtOTWM5KGBOMhqwTUWaTkdCc146KC57RLZxzGnxReJGqmh3V+PIZvxyvcJ4YBVf
         yARE4jjnhwHYAdGS3VP5y+A8yBzDGv1vmsXZsVPU13PczY0ARQad9KZu2noiZ9tnEDTP
         D5ZZsC0hSYMOIOkm/1qzUNmlm6CGpdheV460FvaYoK9Q8OqqwhEuniFGew/WoRYzHKuC
         6kBh0MGHmiizLyD0eTvf3vNSDw2SZ1Bi4Ytvn00wpbyJdHTdByW3H18vcXateyF72vcU
         uEeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWe0mpXweH32p8pSjafSrfgrwDVRdsnzxaUTiKKHZzPo/izrBlhWE6M/zXF8r6HyXq8dg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6kLXiIGaIAMTokCVFyAyHY/tqS+vZdTTPvSnD/qByk2Ge/fSu
	KoEJDYjLePHT/mvx86Er05CAnT0+qqCQTHTNTn4Fz4RBfKCXaeoF9ZRk
X-Gm-Gg: ASbGncstewRd/FH6jVzbCCHDGr5vYjlf5gIhofKyH4EGSjG/lRoXi8po3Oyv8VVfEEl
	bND/lQF/g6+BLRIA7R+323myYMSoRixJqWxi6nhmCzsX+9rgOkdc/hHmNYXhWtTiacqETYnHpES
	x91qiUfd1Xzt0VYAQ+bEQM0x/KlJf6vVimagA2bptmd+bRL1bulmhpxPCi9K3C1HnphldpGmmgI
	SJHxjyt5w1g7K5jeAFL2DvCNhB9Cs6oNVrQlpMKk8IWJoCO9RIsjLxjrGIfWEbUdUGx0HkyMZbv
	vk9dfhVe5vVDD50Wnrga7gBt4/AiNjzPoJRt3UeHrSPcnll3rPN5qQrLP8fMd7+zigz1tVOpzKo
	SrC3hz0YGrOacwjZjf6EKUwwp7VJRrVDMfgQXunPajP0AKA5ZiSt8ENxZZXb2q3NNY/TGC7Um81
	h3/UKp81eTIKMBR6eOWB8MPuegTdM=
X-Google-Smtp-Source: AGHT+IERiY+8ZnMLvZa+B1nEe/0Kkuwb7fx53ZHc+psgLhl1HZsx4sl76ERZ0/x9WuEX8c0sMUxeIQ==
X-Received: by 2002:a17:903:2c0d:b0:295:c2e7:7199 with SMTP id d9443c01a7336-29df610eabcmr60906455ad.29.1765175045916;
        Sun, 07 Dec 2025 22:24:05 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae49ca1esm112555855ad.2.2025.12.07.22.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 22:24:04 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org,
	andrii.nakryiko@gmail.com
Cc: eddyz87@gmail.com,
	zhangxiaoqin@xiaomi.com,
	ihor.solodrai@linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	pengdonglin <pengdonglin@xiaomi.com>,
	Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next v9 02/10] selftests/bpf: Add test cases for btf__permute functionality
Date: Mon,  8 Dec 2025 14:23:45 +0800
Message-Id: <20251208062353.1702672-3-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251208062353.1702672-1-dolinux.peng@gmail.com>
References: <20251208062353.1702672-1-dolinux.peng@gmail.com>
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


