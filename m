Return-Path: <bpf+bounces-73858-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F93C3B3C0
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 14:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD413467AD6
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 13:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B633321A0;
	Thu,  6 Nov 2025 13:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLYqaOfd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF488330B2E
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 13:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762435231; cv=none; b=pw8ky4BimoH5pVzO9MDcsGJwWMgTLtPm1kNsrt38quBvmCPAtrH9QlpanD66Ndc04qRV7+Ij5GRk/12pyeTeQDKcUuN06EZ28drby24+jpIPNMbwrK++5xkmfo+xeznRdR9H+ZX4bmBWApZjdDRPVhjpyYd1k2hxo9nSfv2O4g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762435231; c=relaxed/simple;
	bh=h0EAfcD+G3X7Szy66vuob8E02hE5zbvK7+ntjyNEADw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=czJAA6YO6l6xQnLKItSxHeke2vdZP+RHHTVpAJ/BKqL16q9pt2Nv9MxdxwZQJaj4zcfzHg776KqJeNlIcv+I9zdr2pMoHHsMiGq7n66f5+gM65mmTNj4XGCEEKwa2S48lo4H/lxU2jFALFywaQCYAXTEzdhadNof4qN+QjMK4HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLYqaOfd; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-33ff5149ae8so634592a91.3
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 05:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762435228; x=1763040028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2uTTJAlVf03fWlQTjN51jZc/1vK3RKFQ55CcWNpRfq0=;
        b=DLYqaOfdZGIj6yp4A2m7PNvAtkV0tB0MN03vF74YnVRTM8jNXYhnkgCUlC+p2NCsF8
         AnM4jdjf2gJazEQQzm77Twz2rkQTV3OfiML5tUU0MJ6LFmJOZU8pXu/Z+RyKP9RaRaTn
         lkcUVAuA59xoxcBhuq3miBxP8WK3nkl79wAJIjr82UoYjusTy0K+BmJf+xRNUDmsUp95
         bgzr4KfXRQ4/N4axnWkbtB+LgO4ZIdn8VkGzZSKVKtwv1pDieigZavszudf5ZmUcD/g8
         20FIoymd8lCAakOdK8pV0opXWklbhihNr+fpPZxSE/mJru44GQ4Nj3SvjAWWer8lb3d7
         X9Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762435228; x=1763040028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2uTTJAlVf03fWlQTjN51jZc/1vK3RKFQ55CcWNpRfq0=;
        b=gsUhwtDczecVOfqpXXWd3aYXKVYzg0JVRvfa+A33MdYgnpTy5TxZTrJUGQhVyeIV31
         mHPnymGd8N1qndPTgvy7AFfrHUDLPwLJwgdu43wGiL78eIjhnDIv5Tnn0SNvVRvar5kT
         dv5Zw+d5DMnWH7lL3nSp1GP8F2GIZZUYqeiytE7Jj28UMgoVB/uzTO+e/XSjjjm8Y/Lp
         huiFYd8X5s/rBkGOrHVCOfPNPXS6eR0PPRs4zu1bjSmFJ9burTF101h683aSMBSjZuCW
         Kr6vV8FATLVw2G8J1b8/Tt347aB64xvP5KU7hgZ8XvMa8RPZ3Enf2TNUgsh5OpT0xaxn
         coZg==
X-Forwarded-Encrypted: i=1; AJvYcCVYCj4pScNr2mZb0oPaZngb+53W2LsDKz/uLR3V9cNgI2//5XaUAEHcUF8D+P+CX9als00=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDT8qq7+qmQV0c3ajg/aDFC8rj0wz1/NaoTzQTkaMjMWDZmO+G
	3C4iDAhX4FjQFnhMGGD2AeUA6SCPCIMHsufi4yF9mpqbTaaD1PHBknoJ
X-Gm-Gg: ASbGnctuRYzhXCikAWz9mPA/49nnT8X4Yyh+ZddUyWTDSwkYmX0TB3W3U3y5anZqF6a
	T/e89hRTWx05touSqJ5HJcrUIfMhD7dQsE/gq0Q8bDLVUOh7iTcWJE2htmbCQnbt9yZEjJX/j+L
	hy3ZtKS3a3e16fHZL/bAtJGp6MaukKGCn8yX9CDgms3UTRxF2F+4sP8LA0/2tPQBFVEEyvT8vdk
	LnPEQQMKNhoP2CoZgYA9jcnZOnTSQDQSNpMr1bYkGGyYtLo8lFCSTMjZMQ5gXP1wPzG80uMR79J
	mZ7QNhdWcmiuyw9x1dqTnGcYJZ3iq8s5yBJnI9tna/15VSYTLJdSxoCcNSg4sEtyYyjETc3/1Ul
	5x5fMZpQeoqYytuDfhQVsRYSSdBK1uglPj1e5eucrDyY1wwYmtYhzgCOP2cno+YhELaC61ZO/hM
	Wc7IYextneG8G11Tug
X-Google-Smtp-Source: AGHT+IHo+v0TtA1LN3JuLTKCRweiuU1NOoFv6iTGjRKxpQ9ZmN93DDux9gXzM/pFEUH3U2AvrZ42mg==
X-Received: by 2002:a17:90b:4acf:b0:32e:3552:8c79 with SMTP id 98e67ed59e1d1-341a6defc72mr8457709a91.29.1762435227616;
        Thu, 06 Nov 2025 05:20:27 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341d3e0b0b2sm1914869a91.21.2025.11.06.05.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 05:20:26 -0800 (PST)
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
Subject: [PATCH v5 3/7] libbpf: Optimize type lookup with binary search for sorted BTF
Date: Thu,  6 Nov 2025 21:19:52 +0800
Message-Id: <20251106131956.1222864-4-dolinux.peng@gmail.com>
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

This patch introduces binary search optimization for BTF type lookups
when the BTF instance contains sorted types.

The optimization significantly improves performance when searching for
types in large BTF instances with sorted type names. For unsorted BTF
or when nr_sorted_types is zero, the implementation falls back to
the original linear search algorithm.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Song Liu <song@kernel.org>
Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
---
 tools/lib/bpf/btf.c | 145 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 122 insertions(+), 23 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index aad630822584..be092892c4ae 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -26,6 +26,10 @@
 
 #define BTF_MAX_NR_TYPES 0x7fffffffU
 #define BTF_MAX_STR_OFFSET 0x7fffffffU
+/*
+ * sort verification occurs lazily upon first btf_find_type_by_name_kind() call
+ */
+#define BTF_NEED_SORT_CHECK ((__u32)-1)
 
 static struct btf_type btf_void;
 
@@ -92,6 +96,16 @@ struct btf {
 	 *   - for split BTF counts number of types added on top of base BTF.
 	 */
 	__u32 nr_types;
+	/* number of sorted and named types in this BTF instance:
+	 *   - doesn't include special [0] void type;
+	 *   - for split BTF counts number of sorted and named types added on
+	 *     top of base BTF.
+	 *   - BTF_NEED_SORT_CHECK value indicates sort validation will be performed
+	 *     on first call to btf_find_type_by_name_kind.
+	 *   - zero value indicates applied sorting check with unsorted BTF or no
+	 *     named types.
+	 */
+	__u32 nr_sorted_types;
 	/* if not NULL, points to the base BTF on top of which the current
 	 * split BTF is based
 	 */
@@ -897,44 +911,126 @@ int btf__resolve_type(const struct btf *btf, __u32 type_id)
 	return type_id;
 }
 
-__s32 btf__find_by_name(const struct btf *btf, const char *type_name)
+/* Performs binary search within specified type ID range to find the leftmost
+ * BTF type matching the given name. The search assumes types are sorted by
+ * name in lexicographical order within the specified range.
+ *
+ * Return: Type ID of leftmost matching type, or -ENOENT if not found
+ */
+static __s32 btf_find_type_by_name_bsearch(const struct btf *btf, const char *name,
+						__s32 start_id, __s32 end_id)
 {
-	__u32 i, nr_types = btf__type_cnt(btf);
+	const struct btf_type *t;
+	const char *tname;
+	__s32 l, r, m, lmost = -ENOENT;
+	int ret;
+
+	l = start_id;
+	r = end_id;
+	while (l <= r) {
+		m = l + (r - l) / 2;
+		t = btf_type_by_id(btf, m);
+		tname = btf__str_by_offset(btf, t->name_off);
+		ret = strcmp(tname, name);
+		if (ret < 0) {
+			l = m + 1;
+		} else {
+			if (ret == 0)
+				lmost = m;
+			r = m - 1;
+		}
+	}
 
-	if (!strcmp(type_name, "void"))
-		return 0;
+	return lmost;
+}
 
-	for (i = 1; i < nr_types; i++) {
-		const struct btf_type *t = btf__type_by_id(btf, i);
-		const char *name = btf__name_by_offset(btf, t->name_off);
+/* Searches for a BTF type by name and optionally by kind. The function first
+ * checks if the search should start from the base BTF (if @start_id is before
+ * current BTF's start_id). If types are sorted, it uses binary search to find
+ * the leftmost matching type and then verifies the kind. For unsorted types,
+ * it falls back to linear search through all types.
+ *
+ * The function handles split BTF scenarios by recursively searching in base
+ * BTFs when necessary. When @kind is -1, only the name matching is performed.
+ *
+ * Return: Type ID of matching type on success, -ENOENT if not found
+ */
+static __s32 btf_find_type_by_name_kind(const struct btf *btf, int start_id,
+				   const char *type_name, __u32 kind)
+{
+	const struct btf_type *t;
+	const char *tname;
+	int err = -ENOENT;
+
+	if (start_id < btf->start_id) {
+		err = btf_find_type_by_name_kind(btf->base_btf, start_id,
+			type_name, kind);
+		if (err > 0)
+			goto out;
+		start_id = btf->start_id;
+	}
+
+	if (btf->nr_sorted_types != BTF_NEED_SORT_CHECK) {
+		/* binary search */
+		__s32 end_id;
+		bool skip_first;
+		int ret;
+
+		end_id = btf->start_id + btf->nr_sorted_types - 1;
+		ret = btf_find_type_by_name_bsearch(btf, type_name, start_id, end_id);
+		if (ret < 0)
+			goto out;
+		if (kind == -1)
+			return ret;
+		skip_first = true;
+		do {
+			t = btf_type_by_id(btf, ret);
+			if (BTF_INFO_KIND(t->info) != kind) {
+				if (skip_first) {
+					skip_first = false;
+					continue;
+				}
+			} else if (skip_first) {
+				return ret;
+			}
+			tname = btf__str_by_offset(btf, t->name_off);
+			if (!strcmp(tname, type_name))
+				return ret;
+			else
+				break;
+		} while (++ret <= end_id);
+	} else {
+		/* linear search */
+		__u32 i, total;
 
-		if (name && !strcmp(type_name, name))
-			return i;
+		total = btf__type_cnt(btf);
+		for (i = start_id; i < total; i++) {
+			t = btf_type_by_id(btf, i);
+			if (kind != -1 && btf_kind(t) != kind)
+				continue;
+			tname = btf__str_by_offset(btf, t->name_off);
+			if (tname && !strcmp(tname, type_name))
+				return i;
+		}
 	}
 
-	return libbpf_err(-ENOENT);
+out:
+	return err;
 }
 
 static __s32 btf_find_by_name_kind(const struct btf *btf, int start_id,
 				   const char *type_name, __u32 kind)
 {
-	__u32 i, nr_types = btf__type_cnt(btf);
-
 	if (kind == BTF_KIND_UNKN || !strcmp(type_name, "void"))
 		return 0;
 
-	for (i = start_id; i < nr_types; i++) {
-		const struct btf_type *t = btf__type_by_id(btf, i);
-		const char *name;
-
-		if (btf_kind(t) != kind)
-			continue;
-		name = btf__name_by_offset(btf, t->name_off);
-		if (name && !strcmp(type_name, name))
-			return i;
-	}
+	return libbpf_err(btf_find_type_by_name_kind(btf, start_id, type_name, kind));
+}
 
-	return libbpf_err(-ENOENT);
+/* the kind value of -1 indicates that kind matching should be skipped */
+__s32 btf__find_by_name(const struct btf *btf, const char *type_name)
+{
+	return btf_find_by_name_kind(btf, btf->start_id, type_name, -1);
 }
 
 __s32 btf__find_by_name_kind_own(const struct btf *btf, const char *type_name,
@@ -1006,6 +1102,7 @@ static struct btf *btf_new_empty(struct btf *base_btf)
 	btf->fd = -1;
 	btf->ptr_sz = sizeof(void *);
 	btf->swapped_endian = false;
+	btf->nr_sorted_types = BTF_NEED_SORT_CHECK;
 
 	if (base_btf) {
 		btf->base_btf = base_btf;
@@ -1057,6 +1154,7 @@ static struct btf *btf_new(const void *data, __u32 size, struct btf *base_btf, b
 	btf->start_id = 1;
 	btf->start_str_off = 0;
 	btf->fd = -1;
+	btf->nr_sorted_types = BTF_NEED_SORT_CHECK;
 
 	if (base_btf) {
 		btf->base_btf = base_btf;
@@ -1715,6 +1813,7 @@ static void btf_invalidate_raw_data(struct btf *btf)
 		free(btf->raw_data_swapped);
 		btf->raw_data_swapped = NULL;
 	}
+	btf->nr_sorted_types = BTF_NEED_SORT_CHECK;
 }
 
 /* Ensure BTF is ready to be modified (by splitting into a three memory
-- 
2.34.1


