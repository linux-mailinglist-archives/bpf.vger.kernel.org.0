Return-Path: <bpf+bounces-78316-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4842DD0A615
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 14:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D15A2312B7D5
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 13:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35B535BDC9;
	Fri,  9 Jan 2026 13:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecM4lOQD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEFD35BDB3
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 13:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767963618; cv=none; b=m0jW4s69gpuGG8Xc849zz5SrxE1sSKbIEPUZhHe5Aufw4ktWaPoxhVQw2ATozK9/tcnfAMkytvUIX9A8Ts+7TE/lbp21e1gyy1Pe5o5C/sW+FocsCS9jiPDKoANY5zo3l+g1dMXVdpIcvmk5XgrGT7XooqjFwQw0y7cNsprAVHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767963618; c=relaxed/simple;
	bh=uMiIaTuHoGp8t2XP9PDz6WtnuLCS6v4VMQ6JPWkBmY4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cARWpw3Kvn2BPeMmHi4XYxj3zbsTUWg3BntZXAQBBilupb4SB8hhUZPdw+PKhSWqoK0n2WKzfp7VJf291UjVQFKlC5mRz76PU9ljtVG/Pr7leZB+Jrp2QhVlkveOx0eVzdJFC+DXb8MiGuGAUe6Jtp8iHo1nUDnpWcq4KWYeVVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecM4lOQD; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a081c163b0so30772905ad.0
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 05:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767963616; x=1768568416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CLf4MD/8vWtFsjd7VfVNcjK4gNe3ynQJ9Qc+27+cU9U=;
        b=ecM4lOQD1dlVHQAwW9Kjrizm73duzuA7G9IWNr4S24nmYrj4pDSrral0v1oYsjCea3
         Mft+xWCKu6ZxjRrlYZHF3PsTCLMBTmitdvJLJrX7AbvJLJcA7riWkkibxd1C0IAqYr8d
         7dwLyDcOu++iow1KadTChv/aSKRwha8sMf6ccnnkEGd8wB9jQyeEy/+3rsGdR0xnxTVc
         I5saWhbPRAuMaS9R9enc5brbqfcg6h5fQPh8iHAhcLTZBEmr1CwJksN6zsHDzKZM9+pv
         kIMcdV8OsEf+a/TjSQi/dy/Uk4qf56OG9oPcG4xmgdWhfrYXuIHUR+FC1c7kwmoUP05j
         Lfpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767963616; x=1768568416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CLf4MD/8vWtFsjd7VfVNcjK4gNe3ynQJ9Qc+27+cU9U=;
        b=bjTj/17AZJNIlMaLqzGjMyeYvybwqvvSHtj6MUtK6nvIXQCjdLHC7l9WqvaBxP/Rn/
         sJlPgXchBxDKwD9hpqGrEoQo8IdvCcQzF7Dy/c3gOeF8QjMv/RrGwtbCV42WmixrtPgh
         aGw4aZWOd0vgvwKBxbD9BmQnJAQrz6RwPlaDcS7mFtDrI/t4qZkvrU74A9mmxsULt1Z5
         A3d2MZds3q1Zi/DUTijYiErssbV9qUdnrYKFDLnbs/0t/k1NEOcYuO812Cr2ddsM43sh
         ZuuD0PqtHQP77AaR4/vJI9kWWKKE61DbdcAeCUAOibABePeo4qdoq6XmK/L7w6wfSQQ8
         vV7g==
X-Forwarded-Encrypted: i=1; AJvYcCUj4iZ799prKFclYbatLMQpVA5Cv22oI29VUY4RPH1tOagyFaWQzVqGDOUdf2VQK0RSCxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZXUvMwv19dwmYA8teigrpIj7CcXSuRswS8DFahZm9R+uuRjsb
	4yG8BrKbT41ohShE1zx4zTBWXFxCVFwPhK3vTbdQbt7S36eqApEO4gNu
X-Gm-Gg: AY/fxX54FIiG/TzKC6iohFoomlGQdd7ysEBIiLfONbqVSSj4TQbD9vn/3Ap1a1JGuh7
	DNM1n7QRzAbyoX5metREgzlrwCxn5sG1BkVsXTktStIT1O+JcoNYcyNgA26SOG2AMOmEuKBG4tU
	xRP2NL4dHCIFXQJftsUMde30oGxQmobnqs0cUjCV/gfk/NVExxtodyuWlKgNnpemEYlMr3rPEKT
	4CaxxS2SeJA8DAguiW0f+fv3LaA+MqUDcoMlADvnQYscFecsmpOwVhIjnIKuA0850QHLtm/PiSB
	M6qvOf3oieTLzq524d5ILT1GLsToWXUU4A4S14pLJxddmEIVeE4C/tH+2GjtlvBINbS2QmJ17cH
	scXxnxjjKinT/HP/p7k3Hz5rFG9Waklsr8KcW+xaQTKM2ssmgDKjf0VEBgQ1DaB00PHaVaWHsAP
	tXC9dxjlm01rghJV+Ax809k3abuoA=
X-Google-Smtp-Source: AGHT+IHUbv9WRCZStjAecPrTyLJ6XpZmmO3OJTH9Yv044JkqHu4Qb0zoqrFjdl0rbPYyVoyrUN7Tow==
X-Received: by 2002:a17:903:3d0f:b0:2a0:81c1:6194 with SMTP id d9443c01a7336-2a3ee49c2a5mr99381295ad.47.1767963615302;
        Fri, 09 Jan 2026 05:00:15 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c3a328sm104927325ad.4.2026.01.09.05.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 05:00:14 -0800 (PST)
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
Subject: [PATCH bpf-next v12 02/11] selftests/bpf: Add test cases for btf__permute functionality
Date: Fri,  9 Jan 2026 20:59:54 +0800
Message-Id: <20260109130003.3313716-3-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260109130003.3313716-1-dolinux.peng@gmail.com>
References: <20260109130003.3313716-1-dolinux.peng@gmail.com>
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


