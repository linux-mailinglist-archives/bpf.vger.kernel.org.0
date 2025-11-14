Return-Path: <bpf+bounces-74484-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D18C8C5C29E
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 10:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 450D44F3312
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 09:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04568302CDF;
	Fri, 14 Nov 2025 09:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9z+R2WV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57920302176
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 09:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763111043; cv=none; b=aTcxINQyYplt8R182wVmVtDdLs9fnl5VM705C9y80+udOObPueP77C+p2MPD6Thiznm2radBOFFee4Yg4BLIFkXWAHJOzyeQh+TWuveI2BAvVvPa5UnA5RRSxaSxmWHnxJQDRlu9pfFMnvalupQQXkdsktiAtIsIAsEpbN0HySs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763111043; c=relaxed/simple;
	bh=kaCcv/gxLali8+OQISBxtBb21YuXVVu0kdZi2au/Qu4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H6Tm/ITZb6nhdYzwiAmoY8HI9/9fjjwJYmlgkKyTB2bqX83/D+0HNK4DUzXO6VZ1VaAByRmK0xEIBkLZ/eudUiCXaDVkpRD44us6AUeMMUcGct26yCtxWH3AdkPupcYY62MCFBZ8fTe3oZPb5f84OBmYLuY6NqD+c4yreUAf3jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9z+R2WV; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2984dfae043so15593275ad.0
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 01:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763111041; x=1763715841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dnz978baveRxYd8wc+wY2UrNBM5VV6QZrF0AyP76BvM=;
        b=i9z+R2WVs1y4BcVmzoKcVoiioWzKX6fFmrqInHBVnJbiAzDuTJOPd2xmTsWAKN+vbr
         7QXn/FAuQdX0sXzIUXsVIh263sdvllkXyW/1M14LTG9tMvf5vO+EUjbdxEihUxP1RKlT
         +OK6Zk/mJj5jKGhLrMdoItFUlwIp5DF5KAelmqTWnC8bt0EuGOPBQp6hd8pLcs+C8JSz
         qJjc05n0NJdrvGjx2WDg2YDdCdI5pd7TYTejQ7L3Q+8SYU89pyW+d0Ca6sECFNJHcQiN
         KOp8o01sUVDTa7fHQSuZBp1y+kRkapc2lbGCrbCDOrbU+6Pl7HaCUGDUTHzEbumam5Ed
         7zgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763111041; x=1763715841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Dnz978baveRxYd8wc+wY2UrNBM5VV6QZrF0AyP76BvM=;
        b=GdPCNz9J1ELdkdIrnqqOG2doi7Sm+1ohIiIALgLaamXVTrph0pA1tLgJOfWCOHpVW0
         TzQhZuDFkxQW9tF2F84QSYyem0LRCYXTokx+GoUjqSHT1GcT9UUMCr3uRNRwSIpqjGXR
         4M545gyKt5GWOPApoi+YSWHu34A9O84fVVVn4T1CRMSoWfBD1nmrU1aPH0E7SsSDxVGc
         ifkomm2qAuNJbkXZhcgtjXxAqdCC0wdhNdhi1eGbaCY1qOjZKSRN+iPS5dgvj1QWVVNc
         nNbuoHFqEl0volq45TwPmgBL6NvILtRFDRVLMv/DUwoMBq5WFGMqkWXWiKysydycoDgo
         QnVw==
X-Forwarded-Encrypted: i=1; AJvYcCW74CB/gVqhum4VEPznFXrL+oIxeiy4fhkZIrabycwFzfHtfk2GW/49ackzwhTbfGBJvSY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa+BJUCh9ITScAaHkBmjWHVnmWpx3l0taprJT3L0Z6+Ra5c0av
	h4aBUNSgWQm+vP2twz6O3Oy59FeZag/EY/nIIdcSFMZDcslX2ChwSr5c
X-Gm-Gg: ASbGncuhS4F99AYMcMueFvF4HoQWjxr8e7kQRp9S4yLrXZ4zM30nA/iib2xkQwQg9ms
	IbhLmVgmHNBQMbXQ/sWdp6KFXPn0qz7zN+viDpIQ7YcfDTQvCcWiIAnad8YoPywenYbOqvWq7sA
	3DVMOML9P+TIWXvgCOP/jJ0+mObMcczA26+AeWIPV3zCj6NNRs/o2CvKZcmnXnipM1u6qsYprtR
	ZQ3Ou/T57YVRGEubLB/J+WEpMCXPPGZ3OVCRssBy0Artpfw0O2tIpPz2R/4/GSGMUD9WM/RIf5u
	aP4KsqLy/Vn8pXbgJhvz8rx5ErBF2plWlgChL2Yb89Masv/DnDmU1V7JKz8f2+FkkRJ+atwMFdU
	vaR6TuNNQz8q1bKf+olKEXmeVi9zYXk+DZAgr8dw6+GOKJvD6T9xl8Di6QxkEXNlvWO6LF2Xd1F
	KWK9aRiHDKNJDPApDIFdwoqhNVcdE=
X-Google-Smtp-Source: AGHT+IFDHmOsxp10mTDwD3+or7sTDeUuVW883O4cpyuSK8PUcKKcJ85WjZ1xOZEJCEREIhHJup+SdA==
X-Received: by 2002:a17:902:ccc3:b0:24c:7b94:2f53 with SMTP id d9443c01a7336-2986a6b8528mr26627905ad.6.1763111040259;
        Fri, 14 Nov 2025 01:04:00 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2cca66sm48362605ad.99.2025.11.14.01.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 01:03:59 -0800 (PST)
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
Subject: [RFC PATCH 2/2] selftests/bpf: Add test cases for btf__permute functionality
Date: Fri, 14 Nov 2025 17:02:31 +0800
Message-Id: <20251114090231.2786984-3-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251114090231.2786984-1-dolinux.peng@gmail.com>
References: <20251114090231.2786984-1-dolinux.peng@gmail.com>
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
 .../selftests/bpf/prog_tests/btf_permute.c    | 626 ++++++++++++++++++
 1 file changed, 626 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_permute.c

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_permute.c b/tools/testing/selftests/bpf/prog_tests/btf_permute.c
new file mode 100644
index 000000000000..c1a47b8461ee
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/btf_permute.c
@@ -0,0 +1,626 @@
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
+	struct btf *btf, *new_btf;
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
+	hdr = btf_data;
+	if (!ASSERT_EQ(hdr->str_len, ARRAY_SIZE(expect_strs), "expect_strs"))
+		goto done;
+
+	err = btf__dedup(new_btf, NULL);
+	if (!ASSERT_OK(err, "btf__dedup"))
+		goto done;
+
+	btf_data = btf__raw_data(new_btf, &btf_size);
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


