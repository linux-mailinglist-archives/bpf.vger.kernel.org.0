Return-Path: <bpf+bounces-73860-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C85DC3B366
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 14:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9851F3BD2C4
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 13:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912A6332EA8;
	Thu,  6 Nov 2025 13:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GyQscZaf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7731D3328FC
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 13:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762435237; cv=none; b=eY39NJr/9qaUbLVHlPtypFBM63tn4cTYBtuByj/eg8Z4+hfc17c4EyReEhdPsByUr9a3XUyfvaDABqDNi1ecRbTtrE6QhDMbYeNX+y/ZqFrqIcNv4xdrTCNLQ/d4Stpnc3dSZzDyjzry1PPxicFdssLt6MJaxpSFGbOGgQna6YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762435237; c=relaxed/simple;
	bh=F5X5Y5A4ts8MLXZLKzfKP+tr0DZu+o/90/KYpaX5Qb0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OAJNOQ0JDbaYqMtTKZkJ6+JwpBr10Lwkg+3YYrajOrphCJwcKej4Bl7mqqVXKkfyE4awyQ0lcGCM7P7WMpgFE/sYZeb/7UvK1yXKAQGyg/FT5yHDAAEeqPL2VMxEqbYe1vOeYadMuPoxw/xIb63FdflUf4hkIj6GOkI3FzDUkG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GyQscZaf; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-340c39ee02dso996834a91.1
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 05:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762435235; x=1763040035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3oe9IB7XRuftK/ORLSLXvtfYwT74Xn4ffToyKR5CyQA=;
        b=GyQscZaf8nREVM6RKPr779zcbhPzppTWxVAttqaAS1kdmiugEXA3yHDHadnl6n/SuU
         XLGLOjHGAMcUKSzHMVkScwc7CmAo+vPZDK4/DJYNekd4MMbH+pWGl/GKs9YxXzPSPpnS
         V1k16MxcePyUe5clRTArIJUiIbg0mow7Yo/6AI+PQl7tVYuWZLyka44KMLdQD02zyyNm
         p/+5Vx8B/spM98NSwALTreTLaUAdZCTfrvoxkUCWj7Hj8tsFcsUozHtVR5PRe635I6xy
         7iX8oyalFwbb0+Wrv5k8O+yKtQHf9UVua3kem3IQ2Rf1VqajAyuSqTBrt2TRB+gfFpdC
         eg3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762435235; x=1763040035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3oe9IB7XRuftK/ORLSLXvtfYwT74Xn4ffToyKR5CyQA=;
        b=BRVRRvqn2R2bouLedrJro5P8OyFRG1/iWJfOWA4QVbb2EEs3G3MTsxZ5hWBEC/jETh
         y/F7tQr4lETYjO0XqQ+iy9cv3cvRbCNdhAO+8mz8E9eAzDvrLV9axvPnzs9XGr2TgATX
         Nl8tP7YFe3ww+5PJPkCSfFnCrKSRWT2MMGbQ98HhEGX8DG91nTha57t1f3JtMAGmBhJP
         JJl5ZxeVyQqlFzmnOFNXLhuotL81yfyawE/kfanm7RTxH4JMh0eRbM7gpsfwQnIP9NKA
         6Wrl+2QQmfu30Jb4Q3qNhq7kXqUXpbxxFa5dU9NSoHvmaxQcbjob8ZcF/WPbTXJMahnQ
         EwOA==
X-Forwarded-Encrypted: i=1; AJvYcCVHbA1OC1jhSVpGgB8dwTARnW8C9hN2qQoLOHxjcfTzyTalF28gu3x73qsZDi2yEV1hnMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuFNE5VNZ6kR2kAPPqPPgYIjioH7lyoVDeBkcevchYBpVvcag6
	veLWnuWXDivJ9jei9Vt69Sqp0BGdMrRIG3/t40Hg7fUX9QQ1ZwOuKm0j
X-Gm-Gg: ASbGncvSfYZWdRwJ43lk/nnW9PTv1tPeSy9+zH0iHj0iZXXfoM49D3QLP69XbW2izOi
	iOhHHN7hirk22JnJYRwPYc9LffuXz53wd/HQsxjiACCmnLn+l5qjwx1yC0VNe6ZgFcABFV8UBub
	UVasMsI2ljq5biFtNoKs0PnnxBPI1zYRS1FWTTfHswjey8tyrqGJgT/Ks5kl1Nlgl9xFsw4S/UW
	9dyk8wjfJMnKS2AXWU4MI39I25Es815HOCa9xTzxklqRtfx6hFPbrdlWYWEXkGEPyEcK5Tc8t2M
	8KbLoLX/v9Sv8pkocB4kRINYcO5A5RPKzlcn6JeRYKZBzBEp8lnCCUrX0pEgYAH5za26EPr3VTW
	GpLyCCW57jiiWKDCCA7jr3NUGwY1Anc5DdhDnCxePDmh8uCuqJm1RSpjwIjaSH7eZ5vaCGf+8vW
	t74+HB4DMASKrljbPN
X-Google-Smtp-Source: AGHT+IHdCvg4WM6MDWt7CjISOISNrqfsnmPepoxmBDS9wWIOhAC432xRASHA8HBRdlSBjrUGDiQajg==
X-Received: by 2002:a17:90a:1508:b0:340:d578:f299 with SMTP id 98e67ed59e1d1-341a6c00d45mr5789547a91.3.1762435234764;
        Thu, 06 Nov 2025 05:20:34 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341d3e0b0b2sm1914869a91.21.2025.11.06.05.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 05:20:33 -0800 (PST)
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
Subject: [PATCH v5 5/7] btf: Optimize type lookup with binary search
Date: Thu,  6 Nov 2025 21:19:54 +0800
Message-Id: <20251106131956.1222864-6-dolinux.peng@gmail.com>
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

Improve btf_find_by_name_kind() performance by adding binary search
support for sorted types. Falls back to linear search for compatibility.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Song Liu <song@kernel.org>
Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
---
 kernel/bpf/btf.c | 117 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 107 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 0de8fc8a0e0b..66cb739a0598 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -192,6 +192,8 @@
  */
 #define BTF_MAX_SIZE (16 * 1024 * 1024)
 
+#define BTF_NEED_SORT_CHECK ((u32)-1)
+
 #define for_each_member_from(i, from, struct_type, member)		\
 	for (i = from, member = btf_type_member(struct_type) + from;	\
 	     i < btf_type_vlen(struct_type);				\
@@ -259,6 +261,7 @@ struct btf {
 	void *nohdr_data;
 	struct btf_header hdr;
 	u32 nr_types; /* includes VOID for base BTF */
+	u32 nr_sorted_types; /* exclude VOID for base BTF */
 	u32 types_size;
 	u32 data_size;
 	refcount_t refcnt;
@@ -494,6 +497,11 @@ static bool btf_type_is_modifier(const struct btf_type *t)
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
@@ -544,24 +552,110 @@ u32 btf_nr_types(const struct btf *btf)
 	return total;
 }
 
+/* Performs binary search within specified type ID range to find the leftmost
+ * BTF type matching the given name. The search assumes types are sorted by
+ * name in lexicographical order within the specified range.
+ *
+ * Return: Type ID of leftmost matching type, or -ENOENT if not found
+ */
+static s32 btf_find_by_name_kind_bsearch(const struct btf *btf, const char *name,
+						s32 start_id, s32 end_id)
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
+/* Searches for a BTF type with the specified name and kind. The function
+ * first recursively searches in the base BTF (if present), then searches
+ * in the current BTF using either binary search (if types are sorted)
+ * or linear search.
+ *
+ * Binary search is used when types are name-sorted (nr_sorted_types > 0).
+ * After finding a name match, it scans forward to find the first type
+ * that also matches the specified kind. Linear search is used for unsorted
+ * types, checking each type sequentially.
+ *
+ * Return: Type ID of matching type on success, -ENOENT if not found
+ */
 s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind)
 {
+	const struct btf *base_btf = btf_base_btf(btf);;
 	const struct btf_type *t;
 	const char *tname;
-	u32 i, total;
+	int err = -ENOENT;
 
-	total = btf_nr_types(btf);
-	for (i = 1; i < total; i++) {
-		t = btf_type_by_id(btf, i);
-		if (BTF_INFO_KIND(t->info) != kind)
-			continue;
+	if (base_btf) {
+		err = btf_find_by_name_kind(base_btf, name, kind);
+		if (err > 0)
+			goto out;
+	}
 
-		tname = btf_name_by_offset(btf, t->name_off);
-		if (!strcmp(tname, name))
-			return i;
+	if (btf->nr_sorted_types != BTF_NEED_SORT_CHECK) {
+		/* binary search */
+		bool skip_first;
+		s32 start_id, end_id;;
+		int ret;
+
+		start_id = btf_start_id(btf);
+		end_id = start_id + btf->nr_sorted_types - 1;
+		ret = btf_find_by_name_kind_bsearch(btf, name, start_id, end_id);
+		if (ret < 0)
+			goto out;
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
+			tname = btf_name_by_offset(btf, t->name_off);
+			if (!strcmp(tname, name))
+				return ret;
+			else
+				break;
+		} while (++ret <= end_id);
+	} else {
+		/* linear search */
+		u32 i, total;
+
+		total = btf_nr_types(btf);
+		for (i = btf_start_id(btf); i < total; i++) {
+			t = btf_type_by_id(btf, i);
+			if (BTF_INFO_KIND(t->info) != kind)
+				continue;
+
+			tname = btf_name_by_offset(btf, t->name_off);
+			if (!strcmp(tname, name))
+				return i;
+		}
 	}
 
-	return -ENOENT;
+out:
+	return err;
 }
 
 s32 bpf_find_btf_id(const char *name, u32 kind, struct btf **btf_p)
@@ -5791,6 +5885,7 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr, u32 uat
 		goto errout;
 	}
 	env->btf = btf;
+	btf->nr_sorted_types = BTF_NEED_SORT_CHECK;
 
 	data = kvmalloc(attr->btf_size, GFP_KERNEL | __GFP_NOWARN);
 	if (!data) {
@@ -6210,6 +6305,7 @@ static struct btf *btf_parse_base(struct btf_verifier_env *env, const char *name
 	btf->data = data;
 	btf->data_size = data_size;
 	btf->kernel_btf = true;
+	btf->nr_sorted_types = BTF_NEED_SORT_CHECK;
 	snprintf(btf->name, sizeof(btf->name), "%s", name);
 
 	err = btf_parse_hdr(env);
@@ -6327,6 +6423,7 @@ static struct btf *btf_parse_module(const char *module_name, const void *data,
 	btf->start_id = base_btf->nr_types;
 	btf->start_str_off = base_btf->hdr.str_len;
 	btf->kernel_btf = true;
+	btf->nr_sorted_types = BTF_NEED_SORT_CHECK;
 	snprintf(btf->name, sizeof(btf->name), "%s", module_name);
 
 	btf->data = kvmemdup(data, data_size, GFP_KERNEL | __GFP_NOWARN);
-- 
2.34.1


