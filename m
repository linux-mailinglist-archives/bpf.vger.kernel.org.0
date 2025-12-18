Return-Path: <bpf+bounces-76976-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89321CCBA25
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 12:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1F4330F9C19
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 11:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F9031AAB2;
	Thu, 18 Dec 2025 11:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgPeQGOV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAC031A067
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 11:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766057495; cv=none; b=A8JXENMWcqHXuZ57Zd8Y78rEyXlXdDLGrfObBK2BCPptIXjbKWTHaOhfhmIRRE6qjqMMxs+kq6zsB0JgmaYA+mVNW4Ga1wLt52Ghat+y+KUhoUPtfvgTS7jpijSXLfWjpeXSDdY+6lDNNy29X2Fzm7ZpPR0IbMHYN5S8mUd0q2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766057495; c=relaxed/simple;
	bh=+zqsDHnuHDnyqQtOgMwqka0OTnj+dnOtXNTtEUn01ew=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bn2NgiNmlZScAclOci04k2SteFY+ATS0RgcxhvN4dcIbtOC5KoBMspf1Qb/VYN4aTUz/u0tKSeuQzgMGTSq/rS3XeBd6qbHVn9K8ib+K0VtyhxKlt2yoJgaQtHxErG5qCwet6/AfAS3OLrWiEO96j7Vz9cmx/SqyhonwOo1iJUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HgPeQGOV; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-34abc7da414so492076a91.0
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 03:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766057492; x=1766662292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uewsaipU9OXUmad7hbnTZa38j0aK0kfvkQvJ5cwCJxk=;
        b=HgPeQGOVK9jteed7DN8wI2baXQb0GnzZ43CsSJLpjQPQYLHSOyspZOgFg4DfbmPoHF
         II1VixcOS+9GBK0d1F3lCaZ6vcMZ1EDijLYcLvE9g0ssor4xApOzzpKWkLWbATSe5BsW
         1aLh6paWQat6cZaD2ZbYa27Bf1EhL++J/YzQMNbGXJSMjMILfwDYqK3INdZktl/5KAJw
         iZbxxc3Muxv4mWp/3iEao5tOfGO7VPPJPflO+bBpbZvNnqHYaQGncWhFk+60Nhnn3Ncb
         YI1Xl712GcqmzA04e1DlvPc4v+dXz8LHgog1veXCuwIjl4oxpU9KZ6h2aVYAwbrq5KZf
         E3mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766057492; x=1766662292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uewsaipU9OXUmad7hbnTZa38j0aK0kfvkQvJ5cwCJxk=;
        b=nf7FecZWyuTT+AWCAlmR832TzjOvgAIqJkNxScGBGJTAgKDM/BtLz++1MrKpki31q8
         VCYpccZCsoYx0xav/n6vLGH0Mfu8jh1pKecKvZfh9gY4+008Hcnd80KB1l39k4d2PcLu
         yJRsDFMP9R7nlX/2lWmeyZ+RiTsqj3Z5+dNcyX2zp9F8+tassaMMyrMwuUeENPg2S28G
         r7oA2i88htuDMEY5sbCa8fCzhCP7zo2y5qSkBvNAHaYb3N7q9Vf9+u1i+9M7lZHfYv+g
         8ev2JeP+01UO/MHF8geVjdD3Je9w4CdHlKCndYjxgfi7JsUWiZqy62fi2rwwMOZ429ZM
         vVnw==
X-Forwarded-Encrypted: i=1; AJvYcCWN15F3WpM0RessijS3kGKtyOfc5Y8DD2/uGLmgyomygzytyiYi6+KN2ey83mMcnkSxVHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRS2M7g7KHb3SCvK3arunbL7mcev/3Q8PIeWuBTOBmNdMwaK7/
	nVPb2axecGim/bZWzoIpuBw7HacdWdT+KyBPOCZOelUq3CZS8DcxEl+t
X-Gm-Gg: AY/fxX4MwvgSHpe83GeyRPCxGCbrc4f2uTWW7esLn0U6pSgnQqLuSGSmC1csx6EdCYH
	VizhDELx5tNEr2XEFHzAPi+tmxhMSmhVWYWjrYIqTiOpMz6jJ0sJf21byF26zsVDLibTlPU4fYJ
	QKrLLqQ1WSi14DbTBCbNszpoHcX18i3Do6s4wQY1MMnuw+bwK4TwSs8DgFQS1rk3qBCA7sRMPUt
	Le+IwMlmLkF4H0t33JRIW+UCUAHcrwzQxdCYEJ0rhYf1RGZYWDH+Cc6PQxAZfkqITjNYOnDv1El
	jCwI4qJK9EwSS1M10SJe75Zi9FtFIjKh1dn+6gdLlcXJOfyvVJjK0VGWYcZhWZ0JYAEeaadicez
	/T591XmJarPRucptB2xy+G8lnlN35k/8u+UlyH+RAOQBCKreN+JmC2VFtp/Jufx3KK/ZAJ274Bu
	aYmKOBfWqShWuwTl09pUF3GVwjSJA=
X-Google-Smtp-Source: AGHT+IELClayAaqS0OadqjKtH4cOtXpKc/dZ0z9qgGpxsVMemuOw5iYbdyYOvOxgDADYhzL2w3p6cA==
X-Received: by 2002:a17:90b:5111:b0:34a:adf1:677d with SMTP id 98e67ed59e1d1-34abd6d88abmr17202318a91.9.1766057492127;
        Thu, 18 Dec 2025 03:31:32 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70d4f887sm2328237a91.3.2025.12.18.03.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 03:31:31 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org,
	andrii.nakryiko@gmail.com,
	eddyz87@gmail.com
Cc: zhangxiaoqin@xiaomi.com,
	ihor.solodrai@linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	pengdonglin <pengdonglin@xiaomi.com>,
	Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next v10 06/13] btf: Optimize type lookup with binary search
Date: Thu, 18 Dec 2025 19:30:44 +0800
Message-Id: <20251218113051.455293-7-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251218113051.455293-1-dolinux.peng@gmail.com>
References: <20251218113051.455293-1-dolinux.peng@gmail.com>
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
index 0de8fc8a0e0b..0394f0c8ef74 100644
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
+	if (btf->sorted_start_id > 0 && name[0]) {
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


