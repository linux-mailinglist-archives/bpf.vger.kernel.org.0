Return-Path: <bpf+bounces-75556-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84242C88C3D
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 09:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F0F53A7668
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 08:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1C132142B;
	Wed, 26 Nov 2025 08:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyW+p2ev"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E054231AF24
	for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 08:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764147054; cv=none; b=fQRfUdxfwPdvdMSDXCzvj75VUG2ybwaUDycJQPe7jEFy3Y1bWCLwmV+M7407dp4pBWU6ZzosU+2Z8CB72lAH1boVJyFuF1pOZB4MsX4QfaCdTgWNK//tysala96tpHy9DMBQFdgMKLeEuH6Apo6fqPnDKasaM1923GXsdpn23C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764147054; c=relaxed/simple;
	bh=0kgEQtgvPa55pKXFrtj7srWoStjEyAoMQzDyIdaQ2pI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JbVs2Kmpvlb0td6a5iuxAuCzl4z/0f/9z31Rha52G1vYtHEYtR+3sJJyyRdjg6Sz7An0SM7u/yGV9nMaa0JjVwGYDQHqXJ4UlOUJhJjdv5PIpAXziRQe1rpgqknyx5iD4DrM4IvHLvx8pvxgtSqwTQDWbeQG8BPrOKC2h23OAQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DyW+p2ev; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7b8eff36e3bso10064998b3a.2
        for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 00:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764147052; x=1764751852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mgDV1ROzgzpe5gCmmSbOnsLIyQpLC/h36ENHoKlfvVE=;
        b=DyW+p2evw6yBS3tsjQXxaAzDW1Y1+Lnmth8Lk2r6jrfyEkemBv33aCKMDu/xkR1vQ+
         Xd6aAlZZDD3f+wHiykwxpjzSpfdAQ0IrSctL/B0ehyvK8qYXsLV1l7kt2KboW8pihr1i
         5VMAfdBjxBteYHqnFLbd0WTapseNl2+0/D94EXTq08hKJx0wlnzS/a6SmXDoa4JEsCh0
         fdoXYYflgWW8kdm6yJsOl4+NwKP2Ih50qLpkejl+gnjnLAC4sVtvR5URyluu20cEGM0w
         Dl6El4aeJ0PLcmOMKAUTAwOo/ZORychQLV4isyLP32wfTQprmY63/l24neoNNXsqcSVb
         lNgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764147052; x=1764751852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mgDV1ROzgzpe5gCmmSbOnsLIyQpLC/h36ENHoKlfvVE=;
        b=EYANViAoN1VGJcalaIMRHwOydav8jjPguJaEnXTshl9ZdyWrwDD6yZR42UFpT93nNY
         WsH3g2Lcgv9qK5/N/4IYpqwuro33bm/NdwpVMQPgJowQX+uLS3+WOjVSuuC8iYzYCUtX
         UG3pbs0wg6V53fN95vL1EWvCainJAZgjLl25mVsUCT7n1p+nOB4+lxlXYnQWeDIQI5Vr
         PYK+P2GndZN+0TAqHlmWcnZ1W4J607B50FaKOCqnhAOtoq3Cb8bd1nC+6kaTv3+wHx+T
         LgK5cWslUnU8Ldie0P4vc3l8uE2kuzUF133wHf7rXfgv91e77jK+J7Rp5LoqV4SuD1c9
         qRIg==
X-Forwarded-Encrypted: i=1; AJvYcCXuQvFJaNAkclS53oCYAlFHGK5iHvEZkFFaJ50CX+ZrmMaYQzsbIr0FrP0/5vFjnUrnzms=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHeu8GyLzbds/Jbj+dBJlD1NIL+VjXBvmqvg+RRXoylh7ZTR7W
	kFwqG2F2uXZi2db0L5/RnCA1C5VbjWWSL3GAl8uhV1vvihpcv6WmXTdE
X-Gm-Gg: ASbGncs3aPsLrvLq+p/MQhok/uT4TjA6Rhr3I0FGuJb9iqk9eNelt0KrDK9OAVYxec5
	sUKGHlXzaGMUI9jO9wALws7JcLu83+XxLeb1UOl0mbhqxdHkrlK9zpx2IW3rs03lQFCmULlt3pc
	pr+rbRpDq5owXqEiGEPvqmq5RpuBC/21DmyKTYAgXMt2rwF2JAe291sjGnCrXTCUfIhhHifnBRQ
	JdR0IyPjZCQIA6dWN3WtCL7z9bcArtsVkanXad27COzHDB9FIF0NG471N6z18zpqg8xOpLS37VI
	qe18cyjdxzLpbOpmogoLmtzQJy3c0plU6e+wbnFD+UrVMcYwAG+e6jrhCmdb1XwMM9i1VJ1ezKq
	wMcCOpEukzKIT7JbFUfnR6WldD21drF2SLNok6xPYOkcBNCfKaZq7a7mGQWHQNiJQ4qcWIJN39a
	8yeN4Kd3KM9euJ0QYoV65PITk5Ov0=
X-Google-Smtp-Source: AGHT+IFs6pLfGprWWWpfV4uPUwFHD5qyL94NbyLWxHqsqV9ucC0hIrcGzqA9thasWaM1KDvECSl8tQ==
X-Received: by 2002:a05:6a20:430b:b0:341:c4e5:f626 with SMTP id adf61e73a8af0-3637db254efmr6304165637.7.1764147052098;
        Wed, 26 Nov 2025 00:50:52 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f023fd82sm20885721b3a.42.2025.11.26.00.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 00:50:51 -0800 (PST)
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
Subject: [RFC bpf-next v8 6/9] btf: Optimize type lookup with binary search
Date: Wed, 26 Nov 2025 16:50:22 +0800
Message-Id: <20251126085025.784288-7-dolinux.peng@gmail.com>
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

Improve btf_find_by_name_kind() performance by adding binary search
support for sorted types. Falls back to linear search for compatibility.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
---
 kernel/bpf/btf.c | 85 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 76 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 0de8fc8a0e0b..842f9c0200e4 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -259,6 +259,7 @@ struct btf {
 	void *nohdr_data;
 	struct btf_header hdr;
 	u32 nr_types; /* includes VOID for base BTF */
+	u32 sorted_start_id;
 	u32 types_size;
 	u32 data_size;
 	refcount_t refcnt;
@@ -494,6 +495,11 @@ static bool btf_type_is_modifier(const struct btf_type *t)
 	return false;
 }
 
+static int btf_start_id(const struct btf *btf)
+{
+	return btf->start_id + (btf->base_btf ? 0 : 1);
+}
+
 bool btf_type_is_void(const struct btf_type *t)
 {
 	return t == &btf_void;
@@ -544,21 +550,79 @@ u32 btf_nr_types(const struct btf *btf)
 	return total;
 }
 
+static s32 btf_find_by_name_bsearch(const struct btf *btf, const char *name,
+				    s32 start_id, s32 end_id)
+{
+	const struct btf_type *t;
+	const char *tname;
+	s32 l, r, m, lmost = -ENOENT;
+	int ret;
+
+	l = start_id;
+	r = end_id;
+	while (l <= r) {
+		m = l + (r - l) / 2;
+		t = btf_type_by_id(btf, m);
+		tname = btf_name_by_offset(btf, t->name_off);
+		ret = strcmp(tname, name);
+		if (ret < 0) {
+			l = m + 1;
+		} else {
+			if (ret == 0)
+				lmost = m;
+			r = m - 1;
+		}
+	}
+
+	return lmost;
+}
+
 s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind)
 {
+	const struct btf *base_btf = btf_base_btf(btf);
 	const struct btf_type *t;
 	const char *tname;
-	u32 i, total;
+	s32 idx;
 
-	total = btf_nr_types(btf);
-	for (i = 1; i < total; i++) {
-		t = btf_type_by_id(btf, i);
-		if (BTF_INFO_KIND(t->info) != kind)
-			continue;
+	if (base_btf) {
+		idx = btf_find_by_name_kind(base_btf, name, kind);
+		if (idx > 0)
+			return idx;
+	}
 
-		tname = btf_name_by_offset(btf, t->name_off);
-		if (!strcmp(tname, name))
-			return i;
+	if (btf->sorted_start_id > 0) {
+		/* skip anonymous types */
+		s32 start_id = btf->sorted_start_id;
+		s32 end_id = btf_nr_types(btf) - 1;
+
+		idx = btf_find_by_name_bsearch(btf, name, start_id, end_id);
+		if (idx < 0)
+			return -ENOENT;
+
+		t = btf_type_by_id(btf, idx);
+		if (BTF_INFO_KIND(t->info) == kind)
+			return idx;
+
+		for (idx++; idx <= end_id; idx++) {
+			t = btf_type_by_id(btf, idx);
+			tname = btf_name_by_offset(btf, t->name_off);
+			if (strcmp(tname, name) != 0)
+				return -ENOENT;
+			if (BTF_INFO_KIND(t->info) == kind)
+				return idx;
+		}
+	} else {
+		u32 i, total;
+
+		total = btf_nr_types(btf);
+		for (i = btf_start_id(btf); i < total; i++) {
+			t = btf_type_by_id(btf, i);
+			if (BTF_INFO_KIND(t->info) != kind)
+				continue;
+			tname = btf_name_by_offset(btf, t->name_off);
+			if (strcmp(tname, name) == 0)
+				return i;
+		}
 	}
 
 	return -ENOENT;
@@ -5791,6 +5855,7 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr, u32 uat
 		goto errout;
 	}
 	env->btf = btf;
+	btf->sorted_start_id = 0;
 
 	data = kvmalloc(attr->btf_size, GFP_KERNEL | __GFP_NOWARN);
 	if (!data) {
@@ -6210,6 +6275,7 @@ static struct btf *btf_parse_base(struct btf_verifier_env *env, const char *name
 	btf->data = data;
 	btf->data_size = data_size;
 	btf->kernel_btf = true;
+	btf->sorted_start_id = 0;
 	snprintf(btf->name, sizeof(btf->name), "%s", name);
 
 	err = btf_parse_hdr(env);
@@ -6327,6 +6393,7 @@ static struct btf *btf_parse_module(const char *module_name, const void *data,
 	btf->start_id = base_btf->nr_types;
 	btf->start_str_off = base_btf->hdr.str_len;
 	btf->kernel_btf = true;
+	btf->sorted_start_id = 0;
 	snprintf(btf->name, sizeof(btf->name), "%s", module_name);
 
 	btf->data = kvmemdup(data, data_size, GFP_KERNEL | __GFP_NOWARN);
-- 
2.34.1


