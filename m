Return-Path: <bpf+bounces-75552-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C835AC88C1C
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 09:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 312553B716F
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 08:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BB631D72B;
	Wed, 26 Nov 2025 08:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPvyhXsn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BD031BCB8
	for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 08:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764147041; cv=none; b=NvSp/KqyEgwxv5P0oWUyKR7DZDK4m3EZBR3iggu7xsd7K2s01C6CWIq/Ckz8Ie4Pln/LFkGQqH2TymGGWD47ayqLsuTRGldYZD9rK6rK9k2dnzOjn9SaXP2mAD242s85yS5vNg1p/GPIkmRntR3saXZgmmMktWGysTsnOx7hHLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764147041; c=relaxed/simple;
	bh=7ngEULL678quRrsmJ39omINLf8wh8oMlVDKhnztkP/E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=teknj2gcSYSp69ozWkHzqFjOa7iHTsMcnKD81Pd01rMUwTUzE5yZ+hyGVY0CkvP6ptVZ8CCEoasjiXlddSt2mIm4owRyriTcUrnYayegaCH78n/uIHOXGWa2VC6pSJwBUYdoUI9GIffe0/ChUaQn6I2Gg2ygM3KNYLyMzDcva3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cPvyhXsn; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7bc248dc16aso4816854b3a.0
        for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 00:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764147039; x=1764751839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qbxRcU+iIJswxukru9rEL0qIQsiT5P658wY0LXDT54=;
        b=cPvyhXsnzE7RioeKynOfRhL8tOXWtpCqlRdEkdyslycqWPZCNN4pubWDC9xnJBFWW4
         9bdKMU+5tmiWgRJJ5rAdfpWkR8kCVHnyx1EE3+P3zUpogqWFsnEcVU+Nc7uFmJQflq85
         aqVBBnhO21CWZhDWO+f+jvW4XES8kxJwCbuhzxQrqP+4IqhSwjxBtNj8Qsfr9w+RW/uU
         qjsZA78pP1kzzLKiCqlRX0bCB6DgpLd29F6mg2w79boTMqqaVpA0gl6zmChEOloK/7yJ
         m1g58KONwQ+NXAsPQgT6vTGqwDmyOQQ0d3W+Hoo6TN2lJ45drW9V31WukXexVTYyk2c+
         sf+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764147039; x=1764751839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9qbxRcU+iIJswxukru9rEL0qIQsiT5P658wY0LXDT54=;
        b=iJH5F7NVVW0ava0Eqk6gGkKH63vVAdP+Ngz84opG9Gl+F4EruletSVbPQ0/7sNCF8+
         mQrta/ACLR7HY1ftvdA2cwQAOvVNTJVhm9k2L4DHHZLXy8//d2Zgvwn+UlgpZVnddy/4
         ILB+smjE/yh+z8A4uoxrkm0o/Wi+HKcwtJWBeh4kBNsQxhHRNm20mBKVoYA2j3tnXIzQ
         J/SyuGHnesoPTa9i7Yi94hOcnSOg4ChsGKk3MjMZa2R8jMXgrKgQ9gSYUxhsYRGhHOV9
         DBF8xRmAyeHV8td6yla+MC13cvoqttUwuwPmyNf8ugkBGiDHPGWlY/jsD/g1jaQQ9aQy
         1iZg==
X-Forwarded-Encrypted: i=1; AJvYcCWYULIeLleMrEFIba7CCNAlRDcXKa4f4pkRn6VQvuXaZRYEchvqpU1pLvik6DYfhF5whK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YynBli9ZpcZjWOY9z13yXjAmRHBD0gEt7u+az4tzpGyZWFWxHYE
	UmBY9djyq0E3xPJKHaOqbNtjhOfnE+aNzgGguP+1/nzavI0ibb40Nm5b7V8798SIUbo=
X-Gm-Gg: ASbGnctepX137ztG2PQ+LAHZy8YGXZkWxnmpLO9wGVZ2rjHiPOp9nfp9DZlTHd9ucIc
	b7tVuriCIurd44nEU1sIeFFwmunBXEDAxvHdX1NqIiVGckMXz8JUY6JEEmo64lZ8N/sUudnJeIW
	ixP6446/JbJBINP6mMMiycIjjmuK6iFMYrqfiVTYHt9Yll90XwR58uA41zxJiK1B6vRiGHR9BDl
	CWbAQPpzex1L//W0CZaFPxcAZK/6fOb6juri8BMBG6bPrkHehmw59RPxtr91/LCUNBKR8bvFK0y
	OWCwQ8fIdkS13PV+GwK3JE+yE4k3VE742zpK1e51bBsJP6OvH4klh2Qg/1sgOsoDpEEWF2lmlxr
	FG2VCQrRqKXSlzw9PbMLwrbJcSVd8RPzzq7O7FFy+9ZvEIGhfzJTQQjXY11w8ofx2nvpqpTpNi6
	OKeWo90WTcloyTPGKRGHec+WMnMu8=
X-Google-Smtp-Source: AGHT+IHqvZLYppoBK2yVx1vDc9XKQk7gBLgQKYgen0ASnKXiIzwkQYbXBtvlVFuNZZBz+61W4qzx4w==
X-Received: by 2002:a05:6a00:c83:b0:7b9:7f18:c716 with SMTP id d2e1a72fcca58-7ca8740ef7emr6830252b3a.1.1764147038864;
        Wed, 26 Nov 2025 00:50:38 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f023fd82sm20885721b3a.42.2025.11.26.00.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 00:50:37 -0800 (PST)
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
Subject: [RFC bpf-next v8 2/9] selftests/bpf: Add test cases for btf__permute functionality
Date: Wed, 26 Nov 2025 16:50:18 +0800
Message-Id: <20251126085025.784288-3-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251126085025.784288-1-dolinux.peng@gmail.com>
References: <20251126085025.784288-1-dolinux.peng@gmail.com>
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


