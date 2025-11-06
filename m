Return-Path: <bpf+bounces-73862-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEAEC3B39C
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 14:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCE88563072
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 13:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD3A329E6C;
	Thu,  6 Nov 2025 13:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7tChW0o"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C13E333737
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 13:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762435245; cv=none; b=eU8c3mseGO1XkZF/KK3DYh/QGOfFvhZK2CKlV8d1V4bDUpjYyEWZ//ttyns7cAArvnIWwKLItDEQ0HC/FeF+G2B9HJcftBU47KB0fgUhDdwmqeAGXlk/z+CejF9V2HzPLIBLYZnDh68SXQon7OHbHQ8e6zcVg0XYA5h0LwzG6ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762435245; c=relaxed/simple;
	bh=kXTsduKxLo9uHmoNu6IW7eKc1GQZJpGYrGZWrIBc2AU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VsMFdsn1vMHhKgMEXwSLSqZjIlCudZ/Oo0fMPEDdf12dMnQqES4EvoBBoaSevnQU49a2I6EIvYzA9dV+ndf6nacqy4jzwRr7f6xFgjtiuWM6Db8Ih6SoX8JsD1P6TQMJ32Mudo6pV1n/VCY8eswSfnrFqpnR35PHDeOAZ+AdbRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7tChW0o; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b994baabfcfso581297a12.3
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 05:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762435242; x=1763040042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mbhqg+u2xhmrkRGLtmWVa4WGYDJR8aV9FcUmNybsdgM=;
        b=V7tChW0or7DHazekqe4Q4C541ArAOidzl94ATtmmzChhZHDMP9R1SwYjFXFE2Bq0cs
         qpSTRLwaVPObFR/cv5/UFjkfhVGgVhDYP2vk6F+Nqr/TO0KRUYOrr3HjX8XLXSd1k6sf
         jtQbzvW/SkefMCTXGGkg95cC5TGdGFR8BMeHMl83hu8/TtdQuusziYYrE5D3kYsxi6Qs
         M41tp+HZ1+higKmg51+71x352fDbBhhipTRhUGLbis+9AP06dL587xFlJkZHaXG+ZSH9
         wDl1hms/wdUuwksYN8FzZ1S8thKzPjBlwmkBLV3RWE1InDExTST1LLrBcDrxXAQcaxsg
         nmHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762435242; x=1763040042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mbhqg+u2xhmrkRGLtmWVa4WGYDJR8aV9FcUmNybsdgM=;
        b=nhfynXpo5jJY/XRqULJibU1iIA0Ano32125VVzXc0BXmH/pIwamuW5f1a7BDrHeJTE
         +S39Q2cq7wIFrK8AF6PL2lAAGi1PVwN6D7PsDBaPh27MBx1MRuenirlmY42N0cAMKFyC
         RXHtKfAtUqH4eLWeIBQnz93WeFYPN5VTNVy7zOyVhsnOZ7G1wBhKC+lybNaEG+FpDoL8
         0OJSvTQ6GwH62wDvevYwTc8MYM6646NGM/CvKSmeUw39TQZnqj6+dxA95w+8kcm7ncnJ
         Qx0uM0U1LGpNz3ksff/X5wqGgqkr4ZppkcEv/zGiTus+ken0aZXa/QkKYBApKMkZ8lOj
         TV1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWXnhWdeqdepYs3nwTNRIc9+D4G2kkGA9FKKOpqxLfYIsZC7q+ym4zfRMiI5V3N0CCMEag=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1is2oceloXuYj345WxfvOt1X0rcBVr5L2MIL2voLbziKqV23E
	EKIcD+io5QW4g3ql7kpKZ0JaEb8x0Qe+mARpSdyAkibp21V7qzW+ARRc0pil6gKYiBY=
X-Gm-Gg: ASbGncsW0jyqB2JqV3G9lVg/CVRxfCJcXINNkn9OEiR9cUHqDoXc+hA5cYUUgmBTumw
	mzPsJILu5VaiGjjbEizeOEImaSx8vC7woJQiDFl1tacu3ddsjo3OiySPvL3OUFE0yAHcx9qad+N
	rM4hAL/r03ptRgYBjlpINOD97xbiPdFzyA67T2vj2F6pe93SNn9u/NEYhOMefWbkkvBTZ2KxTO6
	5hWiGXXtm7UmtIq1Si9W/gcCr+nOBkZsVPQFvw/1WENHbeyd3eDIXPqhel5nxjR+WhjWxMjvqod
	vMMIC6qnX6DJduC+LuWLnSRsY4sIsbGGalNFvS0739i56CU50015ovfJXHm3tl0YKLtnmTkAtwF
	mJI8sHEnnNOdoJfJHYfH2v7M/B0Cp660P/H6wVLLq3nnMrCq18CfokECiX8EqXndrEk92rWFg8U
	UMbxOV1M7B9D2AnySr/xuU31r9VII=
X-Google-Smtp-Source: AGHT+IFHVedB9NmBgtn6+nlw/N4zptK11GvUsLCXCmsB8fjmD3DGYnva+eMZrhOmWymj8Dw6tJk+tg==
X-Received: by 2002:a17:90b:1c07:b0:340:bc27:97bd with SMTP id 98e67ed59e1d1-341a6c4516cmr8047408a91.9.1762435241884;
        Thu, 06 Nov 2025 05:20:41 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341d3e0b0b2sm1914869a91.21.2025.11.06.05.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 05:20:40 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org
Cc: eddyz87@gmail.com,
	andrii.nakryiko@gmail.com,
	zhangxiaoqin@xiaomi.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Donglin Peng <dolinux.peng@gmail.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Song Liu <song@kernel.org>,
	Donglin Peng <pengdonglin@xiaomi.com>
Subject: [PATCH v5 7/7] selftests/bpf: Add test cases for btf__permute functionality
Date: Thu,  6 Nov 2025 21:19:56 +0800
Message-Id: <20251106131956.1222864-8-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251106131956.1222864-1-dolinux.peng@gmail.com>
References: <20251106131956.1222864-1-dolinux.peng@gmail.com>
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

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Song Liu <song@kernel.org>
Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/btf_permute.c    | 279 ++++++++++++++++++
 1 file changed, 279 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_permute.c

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_permute.c b/tools/testing/selftests/bpf/prog_tests/btf_permute.c
new file mode 100644
index 000000000000..edab03742598
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/btf_permute.c
@@ -0,0 +1,279 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Xiaomi */
+
+#include <test_progs.h>
+#include <bpf/btf.h>
+#include "btf_helpers.h"
+
+/* Ensure btf__permute work as expected with base_btf */
+static void test_permute_base(void)
+{
+	struct btf *btf;
+	__u32 permute_ids[6];
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
+	permute_ids[0] = 4; /* struct s2 */
+	permute_ids[1] = 3; /* struct s1 */
+	permute_ids[2] = 5; /* int (*)(int *p) */
+	permute_ids[3] = 1; /* int */
+	permute_ids[4] = 6; /* int f(int *p) */
+	permute_ids[5] = 2; /* ptr to int */
+	err = btf__permute(btf, permute_ids, ARRAY_SIZE(permute_ids), NULL);
+	if (!ASSERT_OK(err, "btf__permute_base"))
+		goto done;
+
+	VALIDATE_RAW_BTF(
+		btf,
+		"[1] STRUCT 's2' size=4 vlen=1\n"
+		"\t'm' type_id=4 bits_offset=0",
+		"[2] STRUCT 's1' size=4 vlen=1\n"
+		"\t'm' type_id=4 bits_offset=0",
+		"[3] FUNC_PROTO '(anon)' ret_type_id=4 vlen=1\n"
+		"\t'p' type_id=6",
+		"[4] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[5] FUNC 'f' type_id=3 linkage=static",
+		"[6] PTR '(anon)' type_id=4");
+
+done:
+	btf__free(btf);
+}
+
+/* Ensure btf__permute work as expected with split_btf */
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
+	permute_ids[0] = 6; /* int f(int *p) */
+	permute_ids[1] = 3; /* struct s1 */
+	permute_ids[2] = 5; /* int (*)(int *p) */
+	permute_ids[3] = 4; /* struct s2 */
+	err = btf__permute(split_btf, permute_ids, ARRAY_SIZE(permute_ids), NULL);
+	if (!ASSERT_OK(err, "btf__permute_split"))
+		goto cleanup;
+
+	VALIDATE_RAW_BTF(
+		split_btf,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[2] PTR '(anon)' type_id=1",
+		"[3] FUNC 'f' type_id=5 linkage=static",
+		"[4] STRUCT 's1' size=4 vlen=1\n"
+		"\t'm' type_id=1 bits_offset=0",
+		"[5] FUNC_PROTO '(anon)' ret_type_id=1 vlen=1\n"
+		"\t'p' type_id=2",
+		"[6] STRUCT 's2' size=4 vlen=1\n"
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
+	permute_ids[0] = 4; /* struct s2 */
+	permute_ids[1] = 2; /* ptr to int */
+	permute_ids[2] = 5; /* int (*)(int *p) */
+	permute_ids[3] = 1; /* int */
+	err = btf__permute(btf, permute_ids, 4, NULL);
+	if (!ASSERT_OK(err, "btf__permute_drop_base"))
+		goto done;
+
+	VALIDATE_RAW_BTF(
+		btf,
+		"[1] STRUCT 's2' size=4 vlen=1\n"
+		"\t'm' type_id=4 bits_offset=0",
+		"[2] PTR '(anon)' type_id=4",
+		"[3] FUNC_PROTO '(anon)' ret_type_id=4 vlen=1\n"
+		"\t'p' type_id=2",
+		"[4] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED");
+
+	permute_ids[0] = 4; /* struct s2 */
+	permute_ids[1] = 5; /* int (*)(int *p) */
+	permute_ids[2] = 1; /* int */
+	err = btf__permute(btf, permute_ids, 3, NULL);
+	if (!ASSERT_ERR(err, "btf__permute_drop_base_fail"))
+		goto done;
+
+done:
+	btf__free(btf);
+}
+
+/* Verify btf__permute function drops types correctly with split_btf */
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
+	permute_ids[0] = 6; /* int f(int *p) */
+	permute_ids[1] = 3; /* struct s1 */
+	permute_ids[2] = 5; /* int (*)(int *p) */
+	err = btf__permute(split_btf, permute_ids, 3, NULL);
+	if (!ASSERT_OK(err, "btf__permute_drop_split"))
+		goto cleanup;
+
+	VALIDATE_RAW_BTF(
+		split_btf,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[2] PTR '(anon)' type_id=1",
+		"[3] FUNC 'f' type_id=5 linkage=static",
+		"[4] STRUCT 's1' size=4 vlen=1\n"
+		"\t'm' type_id=1 bits_offset=0",
+		"[5] FUNC_PROTO '(anon)' ret_type_id=1 vlen=1\n"
+		"\t'p' type_id=2");
+
+	permute_ids[0] = 6; /* int f(int *p) */
+	permute_ids[1] = 3; /* struct s1 */
+	err = btf__permute(split_btf, permute_ids, 2, NULL);
+	if (!ASSERT_ERR(err, "btf__permute_drop_split_fail"))
+		goto cleanup;
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
+	if (test__start_subtest("permute_drop_base"))
+		test_permute_drop_base();
+	if (test__start_subtest("permute_drop_split"))
+		test_permute_drop_split();
+}
-- 
2.34.1


