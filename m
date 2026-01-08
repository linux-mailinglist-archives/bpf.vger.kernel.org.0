Return-Path: <bpf+bounces-78195-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB43FD00D80
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 04:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 625DE30A83B2
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 03:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED2B28851F;
	Thu,  8 Jan 2026 03:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lw/12P0x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AEB286D70
	for <bpf@vger.kernel.org>; Thu,  8 Jan 2026 03:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767842226; cv=none; b=WetVvAumh4KEjDnRe8Rr3Eivgg9/KrvUdkWocHcwjx2tiLT+kKMrrNkkZjeG8BckU7G8nes6ARv3VUvy5ZQ5n4nged+hWgdXfnELADNSyZOEhzb7agV0dRDHkq3TI2Uq5EIpM8p/+9XrFqYWSlxnsOiLmKtY6GT/pM8SvAKpWks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767842226; c=relaxed/simple;
	bh=ZOq8fJcGVS/fCpvZMwV/P+/0vrcfuhuBwBc7kMUvfWk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c94+l7+Vw08UhbRIotluQPWU4R+YvGS3gGnAnprvteLbgLDu/7ATBSaE8Ijl43rLwTpkM42KB0w7YteOBeeXyv6XX2pmsRjiDwguCMCQ49VweA3uDiBuWMk/ouVCCyA+aak3Xt+f1uQsdeVPiJLGuujN7o0rSsoC8v8PZb5lf68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lw/12P0x; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-803474aaa8bso826657b3a.0
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 19:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767842224; x=1768447024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s8++2dvjEi+Fcakj7nAgD/5PeeKaHx/ulT/qgv8H064=;
        b=Lw/12P0xtRGABs9Y4UcApVxlTn+szjObplaqbaP7nv4jZGXX54i+VEGI55nSn2u71/
         vsnLhdlb9E2OcpEMg3rBGV19iUSyllXdHwc5WH8EFxRVKYyJpqi6dl9Aj1Tze5jfqB0+
         SuqTsOkUNFFWG2OrCCHFgE+sc+Px0Ts8fJPkvWDX6PUg+zmnggaKM4eqwPDsk8useEIo
         uAlgF8VRKlk5GgTjXS/UIJfe0LI5PFDbMNvLzyBzIONNJRI1DLEFrc3raYKiE7yeFLWY
         CXq1R8YvBnaZFDYJz4YuZJEJRdHtPw/KphpX1w7Fje25MefWNij0dOSknRWvtAslw4Dy
         oNeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767842224; x=1768447024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s8++2dvjEi+Fcakj7nAgD/5PeeKaHx/ulT/qgv8H064=;
        b=LA1IoTIxtK2Cmv/avP+CIKfWxyJPF/x54K7MXUa1oAWmmks8Yttwk+B+Ly/pN3g+oB
         a45H+b0Gx1aAMrre66CIAMqvvgmeLqhxFM9sN51kK/Ft6s8HmPifOjC8PdAFTiPt1ELA
         cGc0X/GucBtGoNM2Tj98Bn1iqe0ILUhXuJ+cyiL6Fe5SIaYi/e802vdi2BI8KtM30mIO
         4ckCI1HgamDjXnENvT1gV9pU91TZUWzah+/j4c1IbkxKnNVlgk26gwbUpXKnIgvsr/9F
         9JA8nZ5SYf08kcReVhmSM3Nqop4TFaId05DH+PEAtfr8Up9Rhdb4z28cgtraeOOr8UJD
         CdJw==
X-Forwarded-Encrypted: i=1; AJvYcCXyqXiCPMflq8OO62Bkwe3UBAoS0CE7/Y7a1OyiCnKgFPFtlyg/BXrdNAq7UVEEZIyWeUs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6AIk2BH2aF7GzN7X7OADUy0E1CrbDGel3muDxR9A+YSzQkHT4
	qEOWohuNNAkXLD1nKM7kx7kj0ydsvM6NaWfpAWrqO6X1iQ01hajdFCCL
X-Gm-Gg: AY/fxX4xh/Y5ErkT13252+giL1vkMOUeJEwp47LUYYLNGaFBcmgrzH6ZtgEZI6EMSvw
	eUO5FVZojAgpjrGGJQ9Ad5kh1WDua150xJpvTWGXGpL9oVp0KH0zCPSUul7JmX6xY9N2i4Izbf+
	iK9Jz5EV1rV7rLt0Od00JgdAGWTdiBuhwCGBKMKFTiGcRlY4lKHFiQIvWeVKVtPcOQeU2/ZRWA2
	gI7uUMwMd2J3UUSTcXShzKxbUuImBNHzMbJPBEkr3uNDKmveJ64bSg48Pmryl0ECr7VfTRfZlGt
	SmS7IBSILYDX3eePSYGEFDO/dD9pIDNvucC7cJxUpmunyOKa24K/q4J5pKzLHRfPpzranJ7l/+W
	TdrZL6IuJEvBsKMoaqNN1pNfc8h2Blvt6D4yYt2tEKTY6wmM6aGH7nNzD+jW9vWFMMPcdmiC4br
	Q8QHHXqk2p/Cbn4Vm8jtuq7SSJpnYGfSd1R2lACw==
X-Google-Smtp-Source: AGHT+IFGwdUyqDwaYlBr4lLMYhoJJzPw06Sbar1py7DjIxEkSI4qkacyGr98gxp0p7UuMGdseTWxoA==
X-Received: by 2002:a05:6a00:408c:b0:7a9:f465:f29 with SMTP id d2e1a72fcca58-81b7684e6a1mr4560405b3a.10.1767842224292;
        Wed, 07 Jan 2026 19:17:04 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c5de655bsm6134860b3a.60.2026.01.07.19.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 19:17:03 -0800 (PST)
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
Subject: [PATCH bpf-next v11 04/11] libbpf: Optimize type lookup with binary search for sorted BTF
Date: Thu,  8 Jan 2026 11:16:38 +0800
Message-Id: <20260108031645.1350069-5-dolinux.peng@gmail.com>
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

This patch introduces binary search optimization for BTF type lookups
when the BTF instance contains sorted types.

The optimization significantly improves performance when searching for
types in large BTF instances with sorted types. For unsorted BTF, the
implementation falls back to the original linear search.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
---
 tools/lib/bpf/btf.c | 90 +++++++++++++++++++++++++++++++++------------
 1 file changed, 66 insertions(+), 24 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index bf75f770d29a..60ff8eafea83 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -92,6 +92,8 @@ struct btf {
 	 *   - for split BTF counts number of types added on top of base BTF.
 	 */
 	__u32 nr_types;
+	/* the start IDs of named types in sorted BTF */
+	int named_start_id;
 	/* if not NULL, points to the base BTF on top of which the current
 	 * split BTF is based
 	 */
@@ -897,46 +899,83 @@ int btf__resolve_type(const struct btf *btf, __u32 type_id)
 	return type_id;
 }
 
-__s32 btf__find_by_name(const struct btf *btf, const char *type_name)
+static __s32 btf_find_type_by_name_bsearch(const struct btf *btf, const char *name,
+					   __s32 start_id)
 {
-	__u32 i, nr_types = btf__type_cnt(btf);
-
-	if (!strcmp(type_name, "void"))
-		return 0;
-
-	for (i = 1; i < nr_types; i++) {
-		const struct btf_type *t = btf__type_by_id(btf, i);
-		const char *name = btf__name_by_offset(btf, t->name_off);
-
-		if (name && !strcmp(type_name, name))
-			return i;
+	const struct btf_type *t;
+	const char *tname;
+	__s32 l, r, m;
+
+	l = start_id;
+	r = btf__type_cnt(btf) - 1;
+	while (l <= r) {
+		m = l + (r - l) / 2;
+		t = btf_type_by_id(btf, m);
+		tname = btf__str_by_offset(btf, t->name_off);
+		if (strcmp(tname, name) >= 0) {
+			if (l == r)
+				return r;
+			r = m;
+		} else {
+			l = m + 1;
+		}
 	}
 
-	return libbpf_err(-ENOENT);
+	return btf__type_cnt(btf);
 }
 
 static __s32 btf_find_by_name_kind(const struct btf *btf, int start_id,
-				   const char *type_name, __u32 kind)
+				   const char *type_name, __s32 kind)
 {
-	__u32 i, nr_types = btf__type_cnt(btf);
+	const struct btf_type *t;
+	const char *tname;
+	__s32 idx;
+
+	if (start_id < btf->start_id) {
+		idx = btf_find_by_name_kind(btf->base_btf, start_id,
+					    type_name, kind);
+		if (idx >= 0)
+			return idx;
+		start_id = btf->start_id;
+	}
 
-	if (kind == BTF_KIND_UNKN || !strcmp(type_name, "void"))
+	if (kind == BTF_KIND_UNKN || strcmp(type_name, "void") == 0)
 		return 0;
 
-	for (i = start_id; i < nr_types; i++) {
-		const struct btf_type *t = btf__type_by_id(btf, i);
-		const char *name;
+	if (btf->named_start_id > 0 && type_name[0]) {
+		start_id = max(start_id, btf->named_start_id);
+		idx = btf_find_type_by_name_bsearch(btf, type_name, start_id);
+		for (; idx < btf__type_cnt(btf); idx++) {
+			t = btf__type_by_id(btf, idx);
+			tname = btf__str_by_offset(btf, t->name_off);
+			if (strcmp(tname, type_name) != 0)
+				return libbpf_err(-ENOENT);
+			if (kind < 0 || btf_kind(t) == kind)
+				return idx;
+		}
+	} else {
+		__u32 i, total;
 
-		if (btf_kind(t) != kind)
-			continue;
-		name = btf__name_by_offset(btf, t->name_off);
-		if (name && !strcmp(type_name, name))
-			return i;
+		total = btf__type_cnt(btf);
+		for (i = start_id; i < total; i++) {
+			t = btf_type_by_id(btf, i);
+			if (kind > 0 && btf_kind(t) != kind)
+				continue;
+			tname = btf__str_by_offset(btf, t->name_off);
+			if (strcmp(tname, type_name) == 0)
+				return i;
+		}
 	}
 
 	return libbpf_err(-ENOENT);
 }
 
+/* the kind value of -1 indicates that kind matching should be skipped */
+__s32 btf__find_by_name(const struct btf *btf, const char *type_name)
+{
+	return btf_find_by_name_kind(btf, btf->start_id, type_name, -1);
+}
+
 __s32 btf__find_by_name_kind_own(const struct btf *btf, const char *type_name,
 				 __u32 kind)
 {
@@ -1006,6 +1045,7 @@ static struct btf *btf_new_empty(struct btf *base_btf)
 	btf->fd = -1;
 	btf->ptr_sz = sizeof(void *);
 	btf->swapped_endian = false;
+	btf->named_start_id = 0;
 
 	if (base_btf) {
 		btf->base_btf = base_btf;
@@ -1057,6 +1097,7 @@ static struct btf *btf_new(const void *data, __u32 size, struct btf *base_btf, b
 	btf->start_id = 1;
 	btf->start_str_off = 0;
 	btf->fd = -1;
+	btf->named_start_id = 0;
 
 	if (base_btf) {
 		btf->base_btf = base_btf;
@@ -1715,6 +1756,7 @@ static void btf_invalidate_raw_data(struct btf *btf)
 		free(btf->raw_data_swapped);
 		btf->raw_data_swapped = NULL;
 	}
+	btf->named_start_id = 0;
 }
 
 /* Ensure BTF is ready to be modified (by splitting into a three memory
-- 
2.34.1


