Return-Path: <bpf+bounces-75036-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 813AAC6C982
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 04:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9ABB63513F0
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 03:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD10B2F39CE;
	Wed, 19 Nov 2025 03:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYPeDfSa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECFF2F2605
	for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 03:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763522510; cv=none; b=BRila/7wmDvSI0ZJvVhSbj9Dr1bZwjZGjZ925TbnXPirtOJAOTeR5nKsVAQ/xwe/xjslXTn6IQnrbHlLKk2CnXL2IFMul7G6fJQ20S1X3WWqX7/tWRKz8a7gyPmw6gL2mHHxRqxeTGAXStgaXb+WwjusRbumMj9h2qSUQ+sb7s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763522510; c=relaxed/simple;
	bh=GBVX+ySw7NWLKgKlhE+nzNCRnzQLuGUfC1XtdwTzftw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gW/92MYSzsTj4+dLWwwtA6rRh1y4WJxB/GFZ/Va8X6rnM56EjaURsA2ZweLaQK84WHD9kv6seLs12TFweNXBvVFMB5fSfKd4JRjj1sh5uQZIP9VQL8LqSVD+Edt/5n2QB7Hebpfre45sQNe+M3BkprbTaiP3lLIdVcR+9XGyg6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYPeDfSa; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-298456bb53aso70336795ad.0
        for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 19:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763522507; x=1764127307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W5lRC+ms5uVQta4Fss1sLWV8MDgW3AK2UQU+qT8gzRo=;
        b=bYPeDfSa2ocdlm6kCmmk0N6I/SFEVNnhx6vb0ot0G6NYOJc4wLuBoXjiWjoRLqe6oW
         +Fzogri80+kyDUxOMYA9aKfot8920MBQECj+SPjiesoABbWjVHw5WTqBLULAbuxeBs8N
         qoqo1qv3yk26SFF1eR76Lk0XN8j5VYFXhKtwarJnF2YEzolLvb7hKtJ5Re1h2aLI7/U2
         PcC4D2Tc4VZwwqsotfTAeUFO5OFaZaDsNDmxdnybDslonUtZcf+7ZSpssyMIh6/WzTKM
         UDy+KlgrCEcOLQfbYr3qzz/+3JtvBy6zRRaWk6Hv6PLPBlWyRkTJRZW6VBh1HbMiIQTL
         72VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763522507; x=1764127307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W5lRC+ms5uVQta4Fss1sLWV8MDgW3AK2UQU+qT8gzRo=;
        b=dtD7fMn2Apf7wX7U2Ony7qyaj1YP1vc3Vpjjqn9k/4VfM5hIpXOwvcuDHHzOV5osux
         A88RcIfQ5E5TtUGASQvWq5WA2EhRty0xBt490vvrN1JpULiej3RZqxhknHsgWbT4RCaM
         nFK9tTv/jJxeEhnU8PzaenlKpBqxfDKXnUB3fAQ9PoTzNMcFFXbFM4PmBYUNiOjXgFON
         eXtWeeXJOWGsnfDAKwnCkYqd0XIpuLmUWvfFOuE16NQWuWh/fBJOFUCZyHlhatXybZs3
         XRoS0NryYDSQD8qHnqrH6Ig36+ActVAiWCgILqUlJBHOA0HMOyDU3+cKS5G5iXKyW+lU
         JnCw==
X-Forwarded-Encrypted: i=1; AJvYcCUO/s1goUTlXlwO+Ny5EpeOnsM/h2mc5lxXiD7l4BBxc/PBmPPjc3Icj2C/NFMuqYySC4s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6KZb5hrCjeFNA94mrXZv2948yzBJIe+GQfS359RlpR7zxvJ2H
	H8whNcO/H4JLhSVAgqPWTlhF09QWGaCIBnr8fjcnZP3GkprINXpraEBn
X-Gm-Gg: ASbGncskUpDDyT8acrb3t+Q7IYnR+5r9w3ejNiZJk8gomTll9hpeSzSZ/vESGVKEh5E
	Cv6VQSX+qVBfjBvaJmKGmsiXPtfc6CkYQbkImnBf84NzxDzxUpf0tZKT7dNg4BbekqMLMEQmR9p
	MsWp/QggqYYZC9tFDXtPne/uat/UFi6BnoJHnt6ShGdIdVTecpRSnImD4gt9OKJOiNqOzYpZ5Nm
	11OHVf1yJSo/0bo8HUJ5+g01nxoolmV73s5nLDxb0B+dweog4WYB5/0Iy2Wsh6lH/0/ZlIaImu5
	/fpEoeLN5h3TIXYTte9Az7wQTmdJ2hla89pqPuHe2BbMMa0U2mrJHjEo/rBb4mcN03azy/qGmgM
	nPlzXspu98BmSglnD+H46mcx58WDJid6ENJW6eyEyjiwTtfP8CzhjLMrrkqFSbAD8VGoa1Nelid
	O7nYxFUQ/BkglJH7E4337ku0KfVRk=
X-Google-Smtp-Source: AGHT+IHgHrD8Lvmo2Cb3OBfOs4eI3ypnKdfjJJNaWHpXUJTYK/FeVBtZRHJINlqTh4sRCgOXuzHXdw==
X-Received: by 2002:a17:903:3bc7:b0:290:9a74:a8ad with SMTP id d9443c01a7336-2986a76f2b7mr216940455ad.53.1763522506914;
        Tue, 18 Nov 2025 19:21:46 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2bed5asm188352485ad.88.2025.11.18.19.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 19:21:45 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org,
	andrii.nakryiko@gmail.com
Cc: eddyz87@gmail.com,
	zhangxiaoqin@xiaomi.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Donglin Peng <pengdonglin@xiaomi.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Song Liu <song@kernel.org>
Subject: [RFC PATCH v7 2/7] selftests/bpf: Add test cases for btf__permute functionality
Date: Wed, 19 Nov 2025 11:15:26 +0800
Message-Id: <20251119031531.1817099-3-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251119031531.1817099-1-dolinux.peng@gmail.com>
References: <20251119031531.1817099-1-dolinux.peng@gmail.com>
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
- test_permute_drop_base: Validates type dropping on base BTF
- test_permute_drop_split: Tests type dropping on split BTF
- test_permute_drop_dedup: Tests type dropping and deduping

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Song Liu <song@kernel.org>
Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
---
 .../selftests/bpf/prog_tests/btf_permute.c    | 608 ++++++++++++++++++
 1 file changed, 608 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_permute.c

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_permute.c b/tools/testing/selftests/bpf/prog_tests/btf_permute.c
new file mode 100644
index 000000000000..f67bf89519b3
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/btf_permute.c
@@ -0,0 +1,608 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Xiaomi */
+
+#include <test_progs.h>
+#include <bpf/btf.h>
+#include "btf_helpers.h"
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
+
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
+
+	/*
+	 * For base BTF, id_map_cnt must equal to the number of types
+	 * include VOID type
+	 */
+	permute_ids[1 - start_id] = 4; /* [1] -> [4] */
+	permute_ids[2 - start_id] = 3; /* [2] -> [3] */
+	permute_ids[3 - start_id] = 5; /* [3] -> [5] */
+	permute_ids[4 - start_id] = 1; /* [4] -> [1] */
+	permute_ids[5 - start_id] = 6; /* [5] -> [6] */
+	permute_ids[6 - start_id] = 2; /* [6] -> [2] */
+	err = btf__permute(btf, permute_ids, ARRAY_SIZE(permute_ids) - 1, NULL);
+	if (!ASSERT_ERR(err, "btf__permute_base"))
+		goto done;
+
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
+
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
+
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
+
+done:
+	btf__free(btf);
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
+
+	VALIDATE_RAW_BTF(
+		split_btf,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[2] PTR '(anon)' type_id=1",
+		"[3] STRUCT 's2' size=4 vlen=1\n"
+		"\t'm' type_id=1 bits_offset=0",
+		"[4] FUNC 'f' type_id=5 linkage=static",
+		"[5] FUNC_PROTO '(anon)' ret_type_id=1 vlen=1\n"
+		"\t'p' type_id=2",
+		"[6] STRUCT 's1' size=4 vlen=1\n"
+		"\t'm' type_id=1 bits_offset=0");
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
+
+	VALIDATE_RAW_BTF(
+		split_btf,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[2] PTR '(anon)' type_id=1",
+		"[3] STRUCT 's2' size=4 vlen=1\n"
+		"\t'm' type_id=1 bits_offset=0",
+		"[4] FUNC 'f' type_id=5 linkage=static",
+		"[5] FUNC_PROTO '(anon)' ret_type_id=1 vlen=1\n"
+		"\t'p' type_id=2",
+		"[6] STRUCT 's1' size=4 vlen=1\n"
+		"\t'm' type_id=1 bits_offset=0");
+
+	/* Multiple types can not be mapped to the same ID */
+	permute_ids[3 - start_id] = 4;
+	permute_ids[4 - start_id] = 3;
+	permute_ids[5 - start_id] = 3;
+	permute_ids[6 - start_id] = 6;
+	err = btf__permute(split_btf, permute_ids, 4, NULL);
+	if (!ASSERT_ERR(err, "btf__permute_split"))
+		goto cleanup;
+
+	VALIDATE_RAW_BTF(
+		split_btf,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[2] PTR '(anon)' type_id=1",
+		"[3] STRUCT 's2' size=4 vlen=1\n"
+		"\t'm' type_id=1 bits_offset=0",
+		"[4] FUNC 'f' type_id=5 linkage=static",
+		"[5] FUNC_PROTO '(anon)' ret_type_id=1 vlen=1\n"
+		"\t'p' type_id=2",
+		"[6] STRUCT 's1' size=4 vlen=1\n"
+		"\t'm' type_id=1 bits_offset=0");
+
+	/* Can not map to base ID */
+	permute_ids[3 - start_id] = 4;
+	permute_ids[4 - start_id] = 2;
+	permute_ids[5 - start_id] = 5;
+	permute_ids[6 - start_id] = 6;
+	err = btf__permute(split_btf, permute_ids, 4, NULL);
+	if (!ASSERT_ERR(err, "btf__permute_split"))
+		goto cleanup;
+
+	VALIDATE_RAW_BTF(
+		split_btf,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[2] PTR '(anon)' type_id=1",
+		"[3] STRUCT 's2' size=4 vlen=1\n"
+		"\t'm' type_id=1 bits_offset=0",
+		"[4] FUNC 'f' type_id=5 linkage=static",
+		"[5] FUNC_PROTO '(anon)' ret_type_id=1 vlen=1\n"
+		"\t'p' type_id=2",
+		"[6] STRUCT 's1' size=4 vlen=1\n"
+		"\t'm' type_id=1 bits_offset=0");
+
+cleanup:
+	btf__free(split_btf);
+	btf__free(base_btf);
+}
+
+/* Verify btf__permute function drops types correctly with base_btf */
+static void test_permute_drop_base(void)
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
+	/* Drop ID 4 */
+	permute_ids[1 - start_id] = 5; /* [1] -> [5] */
+	permute_ids[2 - start_id] = 1; /* [2] -> [1] */
+	permute_ids[3 - start_id] = 2; /* [3] -> [2] */
+	permute_ids[4 - start_id] = 0; /* Drop [4] */
+	permute_ids[5 - start_id] = 3; /* [5] -> [3] */
+	permute_ids[6 - start_id] = 4; /* [6] -> [4] */
+	err = btf__permute(btf, permute_ids, ARRAY_SIZE(permute_ids), NULL);
+	if (!ASSERT_OK(err, "btf__permute_drop_base"))
+		goto done;
+
+	VALIDATE_RAW_BTF(
+		btf,
+		"[1] PTR '(anon)' type_id=5",
+		"[2] STRUCT 's1' size=4 vlen=1\n"
+		"\t'm' type_id=5 bits_offset=0",
+		"[3] FUNC_PROTO '(anon)' ret_type_id=5 vlen=1\n"
+		"\t'p' type_id=1",
+		"[4] FUNC 'f' type_id=3 linkage=static",
+		"[5] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED");
+
+	/* Continue dropping */
+	permute_ids[1 - start_id] = 1; /* [1] -> [1] */
+	permute_ids[2 - start_id] = 2; /* [2] -> [2] */
+	permute_ids[3 - start_id] = 3; /* [3] -> [3] */
+	permute_ids[4 - start_id] = 0; /* Drop [4] */
+	permute_ids[5 - start_id] = 4; /* [5] -> [4] */
+	err = btf__permute(btf, permute_ids, 5, NULL);
+	if (!ASSERT_OK(err, "btf__permute_drop_base_fail"))
+		goto done;
+
+
+	VALIDATE_RAW_BTF(
+		btf,
+		"[1] PTR '(anon)' type_id=4",
+		"[2] STRUCT 's1' size=4 vlen=1\n"
+		"\t'm' type_id=4 bits_offset=0",
+		"[3] FUNC_PROTO '(anon)' ret_type_id=4 vlen=1\n"
+		"\t'p' type_id=1",
+		"[4] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED");
+
+	/* Cannot drop the ID referenced by others */
+	permute_ids[1 - start_id] = 2;
+	permute_ids[2 - start_id] = 3;
+	permute_ids[3 - start_id] = 1;
+	permute_ids[4 - start_id] = 0; /* [4] is referenced by others */
+	err = btf__permute(btf, permute_ids, 4, NULL);
+	if (!ASSERT_ERR(err, "btf__permute_drop_base_fail"))
+		goto done;
+
+	VALIDATE_RAW_BTF(
+		btf,
+		"[1] PTR '(anon)' type_id=4",
+		"[2] STRUCT 's1' size=4 vlen=1\n"
+		"\t'm' type_id=4 bits_offset=0",
+		"[3] FUNC_PROTO '(anon)' ret_type_id=4 vlen=1\n"
+		"\t'p' type_id=1",
+		"[4] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED");
+
+	/* Drop 2 IDs at once */
+	permute_ids[1 - start_id] = 2; /* [1] -> [2] */
+	permute_ids[2 - start_id] = 0; /* Drop [2] */
+	permute_ids[3 - start_id] = 0; /* Drop [3] */
+	permute_ids[4 - start_id] = 1; /* [4] -> [1] */
+	err = btf__permute(btf, permute_ids, 4, NULL);
+	if (!ASSERT_OK(err, "btf__permute_drop_base_fail"))
+		goto done;
+
+	VALIDATE_RAW_BTF(
+		btf,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[2] PTR '(anon)' type_id=1");
+
+	/* Drop all IDs */
+	permute_ids[1 - start_id] = 0; /* Drop [1] */
+	permute_ids[2 - start_id] = 0; /* Drop [2] */
+	err = btf__permute(btf, permute_ids, 2, NULL);
+	if (!ASSERT_OK(err, "btf__permute_drop_base_fail"))
+		goto done;
+	if (!ASSERT_EQ(btf__type_cnt(btf), 1, "btf__permute_drop_base all"))
+		goto done;
+
+done:
+	btf__free(btf);
+}
+
+/* Verify btf__permute function drops types correctly with split BTF */
+static void test_permute_drop_split(void)
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
+
+	/* Drop ID 4 */
+	permute_ids[3 - start_id] = 5; /* [3] -> [5] */
+	permute_ids[4 - start_id] = 0; /* Drop [4] */
+	permute_ids[5 - start_id] = 3; /* [5] -> [3] */
+	permute_ids[6 - start_id] = 4; /* [6] -> [4] */
+	err = btf__permute(split_btf, permute_ids, ARRAY_SIZE(permute_ids), NULL);
+	if (!ASSERT_OK(err, "btf__permute_drop_split"))
+		goto cleanup;
+
+	VALIDATE_RAW_BTF(
+		split_btf,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[2] PTR '(anon)' type_id=1",
+		"[3] FUNC_PROTO '(anon)' ret_type_id=1 vlen=1\n"
+		"\t'p' type_id=2",
+		"[4] FUNC 'f' type_id=3 linkage=static",
+		"[5] STRUCT 's1' size=4 vlen=1\n"
+		"\t'm' type_id=1 bits_offset=0");
+
+	/* Can not drop the type referenced by others */
+	permute_ids[3 - start_id] = 0; /* [3] is referenced by [4] */
+	permute_ids[4 - start_id] = 4;
+	permute_ids[5 - start_id] = 3;
+	err = btf__permute(split_btf, permute_ids, 3, NULL);
+	if (!ASSERT_ERR(err, "btf__permute_drop_split"))
+		goto cleanup;
+
+	VALIDATE_RAW_BTF(
+		split_btf,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[2] PTR '(anon)' type_id=1",
+		"[3] FUNC_PROTO '(anon)' ret_type_id=1 vlen=1\n"
+		"\t'p' type_id=2",
+		"[4] FUNC 'f' type_id=3 linkage=static",
+		"[5] STRUCT 's1' size=4 vlen=1\n"
+		"\t'm' type_id=1 bits_offset=0");
+
+	/* Continue dropping */
+	permute_ids[3 - start_id] = 0; /* Drop [3] */
+	permute_ids[4 - start_id] = 0; /* Drop [4] */
+	permute_ids[5 - start_id] = 3; /* [5] -> [3] */
+	err = btf__permute(split_btf, permute_ids, 3, NULL);
+	if (!ASSERT_OK(err, "btf__permute_drop_split"))
+		goto cleanup;
+
+	VALIDATE_RAW_BTF(
+		split_btf,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[2] PTR '(anon)' type_id=1",
+		"[3] STRUCT 's1' size=4 vlen=1\n"
+		"\t'm' type_id=1 bits_offset=0");
+
+	/* Continue dropping */
+	permute_ids[3 - start_id] = 0; /* Drop [3] */
+	err = btf__permute(split_btf, permute_ids, 1, NULL);
+	if (!ASSERT_OK(err, "btf__permute_drop_split"))
+		goto cleanup;
+
+	VALIDATE_RAW_BTF(
+		split_btf,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[2] PTR '(anon)' type_id=1");
+
+cleanup:
+	btf__free(split_btf);
+	btf__free(base_btf);
+}
+
+/* Verify btf__permute then btf__dedup work correctly */
+static void test_permute_drop_dedup(void)
+{
+	struct btf *btf, *new_btf = NULL;
+	const struct btf_header *hdr;
+	const void *btf_data;
+	char expect_strs[] = "\0int\0s1\0m\0tag1\0tag2\0tag3";
+	char expect_strs_dedupped[] = "\0int\0s1\0m\0tag1";
+	__u32 permute_ids[5], btf_size;
+	int start_id = 1;
+	int err;
+
+	btf = btf__new_empty();
+	if (!ASSERT_OK_PTR(btf, "empty_main_btf"))
+		return;
+
+	btf__add_int(btf, "int", 4, BTF_INT_SIGNED);	/* [1] int */
+	btf__add_struct(btf, "s1", 4);			/* [2] struct s1 { */
+	btf__add_field(btf, "m", 1, 0, 0);		/*       int m; */
+							/* } */
+	btf__add_decl_tag(btf, "tag1", 2, -1);		/* [3] tag -> s1: tag1 */
+	btf__add_decl_tag(btf, "tag2", 2, 1);		/* [4] tag -> s1/m: tag2 */
+	btf__add_decl_tag(btf, "tag3", 2, 1);		/* [5] tag -> s1/m: tag3 */
+
+	VALIDATE_RAW_BTF(
+		btf,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[2] STRUCT 's1' size=4 vlen=1\n"
+		"\t'm' type_id=1 bits_offset=0",
+		"[3] DECL_TAG 'tag1' type_id=2 component_idx=-1",
+		"[4] DECL_TAG 'tag2' type_id=2 component_idx=1",
+		"[5] DECL_TAG 'tag3' type_id=2 component_idx=1");
+
+	btf_data = btf__raw_data(btf, &btf_size);
+	if (!ASSERT_OK_PTR(btf_data, "btf__raw_data"))
+		goto done;
+	hdr = btf_data;
+	if (!ASSERT_EQ(hdr->str_len, ARRAY_SIZE(expect_strs), "expect_strs"))
+		goto done;
+
+	new_btf = btf__new(btf_data, btf_size);
+	if (!ASSERT_OK_PTR(new_btf, "btf__new"))
+		goto done;
+
+	/* Drop 2 IDs result in unreferenced strings */
+	permute_ids[1 - start_id] = 3; /* [1] -> [3] */
+	permute_ids[2 - start_id] = 1; /* [2] -> [1] */
+	permute_ids[3 - start_id] = 2; /* [3] -> [2] */
+	permute_ids[4 - start_id] = 0; /* Drop result in unreferenced "tag2" */
+	permute_ids[5 - start_id] = 0; /* Drop result in unreferenced "tag3" */
+	err = btf__permute(new_btf, permute_ids, 5, NULL);
+	if (!ASSERT_OK(err, "btf__permute"))
+		goto done;
+
+	VALIDATE_RAW_BTF(
+		new_btf,
+		"[1] STRUCT 's1' size=4 vlen=1\n"
+		"\t'm' type_id=3 bits_offset=0",
+		"[2] DECL_TAG 'tag1' type_id=1 component_idx=-1",
+		"[3] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED");
+
+	btf_data = btf__raw_data(new_btf, &btf_size);
+	if (!ASSERT_OK_PTR(btf_data, "btf__raw_data"))
+		goto done;
+	hdr = btf_data;
+	if (!ASSERT_EQ(hdr->str_len, ARRAY_SIZE(expect_strs), "expect_strs"))
+		goto done;
+
+	err = btf__dedup(new_btf, NULL);
+	if (!ASSERT_OK(err, "btf__dedup"))
+		goto done;
+
+	btf_data = btf__raw_data(new_btf, &btf_size);
+	if (!ASSERT_OK_PTR(btf_data, "btf__raw_data"))
+		goto done;
+	hdr = btf_data;
+	if (!ASSERT_EQ(hdr->str_len, ARRAY_SIZE(expect_strs_dedupped), "expect_strs_dedupped"))
+		goto done;
+
+done:
+	btf__free(btf);
+	btf__free(new_btf);
+}
+
+void test_btf_permute(void)
+{
+	if (test__start_subtest("permute_base"))
+		test_permute_base();
+	if (test__start_subtest("permute_split"))
+		test_permute_split();
+	if (test__start_subtest("permute_drop_base"))
+		test_permute_drop_base();
+	if (test__start_subtest("permute_drop_split"))
+		test_permute_drop_split();
+	if (test__start_subtest("permute_drop_dedup"))
+		test_permute_drop_dedup();
+}
-- 
2.34.1


