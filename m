Return-Path: <bpf+bounces-74736-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F18C645A0
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 14:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ADE864E9E75
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 13:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FAE332EC9;
	Mon, 17 Nov 2025 13:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTwk0+Zo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA701332EA7
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 13:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763385999; cv=none; b=MFNjmNkZbWzS+SQfG0h/AK1M2he/85CAmaGGI3cyJSgcMsm+gQWDE4EvBhtQONnjT6+6A1Er3sx5hjQYEwrDoI/ZCzR+XXDtHesgl6ieJCYySVSuqeSTo6eA88IbotZpiYc8+2ZKk8/hPsg8SF0jTx97zSHFIwEhC2ziIgUHIVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763385999; c=relaxed/simple;
	bh=fKl3CjkwUAvLf00MO5NwlJbM77gTj4jLjJopoNuYY3k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WPRSL+MBHd0uGClfCnGQnUJM4kQ3syhZOtOcv55ZMxJ6oe1gaA84JVVkSyNDhUP0/yMtljZ7Bc6ugD3qD3MejDudmXEd99D/T+70TkNJx/kBWcSptoQtK3RAWZxQUfyk7D0m3h6NsPurEV1RM5jllB19lRpM8X4CpqYB/AkX71s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RTwk0+Zo; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7baf61be569so2615605b3a.3
        for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 05:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763385997; x=1763990797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KIFYlXOHz5whi3PfXinpEu8mupdZxU5ceyDILBZSC4o=;
        b=RTwk0+ZoTLLyy1LznHpukZKWcKj5E5vrIt9ohyGzNFE/NcRYrP4P8n5NpNBvMkIMYi
         ZqVsT9nygAzy/XKlYOS0dBbLEEXk5QK0eHIudd/vuQR1rz3mk2ksMFauyWu5MFPnDj6F
         bm+z5pwVMdUvXN+5F6kmvvMsG5Rj6Kgx9dXufrxIhU2U3/0tbmzrgTZe7TwlXy8jciRr
         XpEz+k6a8pLiEj+qXVXqV2rbjHSln9dEI+Bwlugtouo4gfZN2WH1+UnAO6HJ68ED7N69
         d//FFPkO5U7J9qoz71joLfUXkx1jDKZ39ca8bQdUKKtKWEvdgQ9ccfEuv0nV78YBnhKV
         SrOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763385997; x=1763990797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KIFYlXOHz5whi3PfXinpEu8mupdZxU5ceyDILBZSC4o=;
        b=YfB622iA4/s8ONB+RkAOdusYaSrjAqur4SC9GQApCHYSEOnE2KTTLhwusNkfc9TlTO
         151PuGaP+WaxpseaVDfrvSWAPoZN8gzk3j92exPKKGtgctt/P6SPkm3I44ZniOP9yQC9
         /2cl7Slyf5I1n4DzQxjAt8GRduSjuM5WM1e47ORrNtvUSlYh9JP62crmxTapc/zN92WP
         u8oFYEarudY4RjV3se6PFCJQqVzY10w2LsM2OKmv+DE0/1ISuu3I79wgNY6h7Uak61yE
         ZjCw7XJ+PwCNieib1YQzDShfowYceqGFW/7VDo1zSb1bw43YXoSZ4dRKn3wPz0lwolQD
         VcPA==
X-Forwarded-Encrypted: i=1; AJvYcCWGJgrAcdWM4vsUUbn5NK4M0q6XTwq9KGfEAGtsSZLtNm3BukrSvMGwMJqhnGsG8LcVTPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOj+aUCExldA8LAKF5oqJk30CUi4SG4JVO4Hi1eV28qh8Uxw60
	Bk6SCG9CITwY7TX13kHyEzhY6dQCKObIA+lE+iad1uc5bhQAe+TO4817
X-Gm-Gg: ASbGncu59lxHlTkyiqPk7UOuOzGPHuZYDDqxhYg76rDWUIFca9wefPusYetHUx4Q2Sv
	xLC+myBNqnWY1bu0FhFp0vcCvlhdYnlvT0FSmIM0zXK3kXPI38Zd11zMjHwleHzbzEmuB75VFiC
	d+I7890yMMuoERBmoJhhX2txLDLpTJWikZvGgbv8XWcgIUxRyP1GCHtAiAz/AvC3VYNOyN1po9T
	OUCxukFMRCTR9nDSTZTREYvkmXtzy835QjQGAOYhYX0bi93k8yq4zeWNxslKzeZd1nRd28DwF7B
	4KxPaziZw01okevPlx22iO+UFdYnsvrH+dA9Qk34hanPT0oEHI53oOJvgo2yj3noKFNl6qAnfQ0
	BIiPlGF014mF4iKX7sGpVJ5B9OlDM3vfToiUfQ/qnCg82HOOffHBUWEk7s549fiJ2HEI54BrlBf
	q/+TsECCluORj7QZES
X-Google-Smtp-Source: AGHT+IHdTnYzPJpDm8dxpyzjmpKTz4z28CIouriXEG9ikH1xw0E4XaaZizSOWoHVGZw2NDZ+1IEN2g==
X-Received: by 2002:a05:6a00:2194:b0:7a4:1880:e25e with SMTP id d2e1a72fcca58-7ba3ca60000mr13431081b3a.30.1763385996792;
        Mon, 17 Nov 2025 05:26:36 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b924cd89bcsm13220953b3a.15.2025.11.17.05.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 05:26:35 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org
Cc: eddyz87@gmail.com,
	andrii.nakryiko@gmail.com,
	zhangxiaoqin@xiaomi.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Donglin Peng <pengdonglin@xiaomi.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Song Liu <song@kernel.org>
Subject: [RFC PATCH v6 2/7] selftests/bpf: Add test cases for btf__permute functionality
Date: Mon, 17 Nov 2025 21:26:18 +0800
Message-Id: <20251117132623.3807094-3-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251117132623.3807094-1-dolinux.peng@gmail.com>
References: <20251117132623.3807094-1-dolinux.peng@gmail.com>
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
 .../selftests/bpf/prog_tests/btf_permute.c    | 632 ++++++++++++++++++
 1 file changed, 632 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_permute.c

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_permute.c b/tools/testing/selftests/bpf/prog_tests/btf_permute.c
new file mode 100644
index 000000000000..fccbf3744e5e
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/btf_permute.c
@@ -0,0 +1,632 @@
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
+	permute_ids[0] = 0;
+	permute_ids[1] = 4; /* [1] -> [4] */
+	permute_ids[2] = 3; /* [2] -> [3] */
+	permute_ids[3] = 5; /* [3] -> [5] */
+	permute_ids[4] = 1; /* [4] -> [1] */
+	permute_ids[5] = 6; /* [5] -> [6] */
+	permute_ids[6] = 2; /* [6] -> [2] */
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
+	/* For base BTF, id_map[0] must be 0 */
+	permute_ids[0] = 4;
+	permute_ids[1] = 0;
+	permute_ids[2] = 3;
+	permute_ids[3] = 5;
+	permute_ids[4] = 1;
+	permute_ids[5] = 6;
+	permute_ids[6] = 2;
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
+	/*
+	 * For base BTF, id_map_cnt must equal to the number of types
+	 * include VOID type
+	 */
+	permute_ids[0] = 4;
+	permute_ids[1] = 0;
+	permute_ids[2] = 3;
+	permute_ids[3] = 5;
+	permute_ids[4] = 1;
+	permute_ids[5] = 6;
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
+	permute_ids[0] = 6; /* [3] -> [6] */
+	permute_ids[1] = 3; /* [4] -> [3] */
+	permute_ids[2] = 5; /* [5] -> [5] */
+	permute_ids[3] = 4; /* [6] -> [4] */
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
+	permute_ids[0] = 4;
+	permute_ids[1] = 3;
+	permute_ids[2] = 5;
+	permute_ids[3] = 6;
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
+	permute_ids[0] = 4;
+	permute_ids[1] = 3;
+	permute_ids[2] = 3;
+	permute_ids[3] = 6;
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
+	permute_ids[0] = 4;
+	permute_ids[1] = 2;
+	permute_ids[2] = 5;
+	permute_ids[3] = 6;
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
+	/* Drop ID 4 */
+	permute_ids[0] = 0;
+	permute_ids[1] = 5; /* [1] -> [5] */
+	permute_ids[2] = 1; /* [2] -> [1] */
+	permute_ids[3] = 2; /* [3] -> [2] */
+	permute_ids[4] = 0; /* Drop [4] */
+	permute_ids[5] = 3; /* [5] -> [3] */
+	permute_ids[6] = 4; /* [6] -> [4] */
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
+	permute_ids[0] = 0;
+	permute_ids[1] = 1; /* [1] -> [1] */
+	permute_ids[2] = 2; /* [2] -> [2] */
+	permute_ids[3] = 3; /* [3] -> [3] */
+	permute_ids[4] = 0; /* Drop [4] */
+	permute_ids[5] = 4; /* [5] -> [4] */
+	err = btf__permute(btf, permute_ids, 6, NULL);
+	if (!ASSERT_OK(err, "btf__permute_drop_base_fail"))
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
+	/* Cannot drop the ID referenced by others */
+	permute_ids[0] = 0;
+	permute_ids[1] = 2;
+	permute_ids[2] = 3;
+	permute_ids[3] = 1;
+	permute_ids[4] = 0; /* [4] is referenced by others */
+	err = btf__permute(btf, permute_ids, 5, NULL);
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
+	permute_ids[0] = 0;
+	permute_ids[1] = 2; /* [1] -> [2] */
+	permute_ids[2] = 0; /* Drop [2] */
+	permute_ids[3] = 0; /* Drop [3] */
+	permute_ids[4] = 1; /* [4] -> [1] */
+	err = btf__permute(btf, permute_ids, 5, NULL);
+	if (!ASSERT_OK(err, "btf__permute_drop_base_fail"))
+		goto done;
+
+	VALIDATE_RAW_BTF(
+		btf,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[2] PTR '(anon)' type_id=1");
+
+	/* Drop all IDs */
+	permute_ids[0] = 0;
+	permute_ids[1] = 0; /* Drop [1] */
+	permute_ids[2] = 0; /* Drop [2] */
+	err = btf__permute(btf, permute_ids, 3, NULL);
+	if (!ASSERT_OK(err, "btf__permute_drop_base_fail"))
+		goto done;
+	if (!ASSERT_EQ(btf__type_cnt(btf), 0, "btf__permute_drop_split all"))
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
+	/* Drop ID 4 */
+	permute_ids[0] = 5; /* [3] -> [5] */
+	permute_ids[1] = 0; /* Drop [4] */
+	permute_ids[2] = 3; /* [5] -> [3] */
+	permute_ids[3] = 4; /* [6] -> [4] */
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
+	permute_ids[0] = 0; /* [3] is referenced by [4] */
+	permute_ids[1] = 4;
+	permute_ids[2] = 3;
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
+	permute_ids[0] = 0; /* Drop [3] */
+	permute_ids[1] = 0; /* Drop [4] */
+	permute_ids[2] = 3; /* [5] -> [3] */
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
+	permute_ids[0] = 0; /* Drop [3] */
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
+	__u32 permute_ids[6], btf_size;
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
+	permute_ids[0] = 0;
+	permute_ids[1] = 3; /* [1] -> [3] */
+	permute_ids[2] = 1; /* [2] -> [1] */
+	permute_ids[3] = 2; /* [3] -> [2] */
+	permute_ids[4] = 0; /* Drop result in unreferenced "tag2" */
+	permute_ids[5] = 0; /* Drop result in unreferenced "tag3" */
+	err = btf__permute(new_btf, permute_ids, ARRAY_SIZE(permute_ids), NULL);
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


