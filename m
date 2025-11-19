Return-Path: <bpf+bounces-75039-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEB3C6C994
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 04:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DD89234CA46
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 03:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13902FD1AA;
	Wed, 19 Nov 2025 03:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjgvL3Fw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84A72FC01C
	for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 03:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763522519; cv=none; b=HJniDRayv2ValkuqVe9M/yHSS3PG9mers4ysIrEKtNAxtZAmzuxLoyrw+fGd6fsYzauc+UgwGLp0rUJfZL0NV3ehozTkxBTgiIEM/Xv0kHTWiwIRXgSvcI2XaS/RjtObSB6COXLoRm0yRz4pPSuBIvYiKQHtb2OuqNwcQHnnn8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763522519; c=relaxed/simple;
	bh=0hqy/1YltC7K45hUu+cIK8psLGyQ0+7iQdqAXZ3z9pU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B0rgwvRXrCgAhXyAiZ8l1/LFYE9lQL//Dzb+D/Mv2e6AXDettlMB0/zogY1Oui888tB8WYzUKjniuqGxXPUxYIlDBgBXtwmkxijKGZC9IyPeD7Qc/r2z/0CzVqNo4yyAGOHwUI2g6bNuYj0Du3fdNejhJD9alvmVCQSYtO2Bzk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IjgvL3Fw; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2984dfae043so59998765ad.0
        for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 19:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763522517; x=1764127317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MrUjlXbQpuT/rGn9ebhDAet+g15u+mqlf//GGNvk5as=;
        b=IjgvL3FwsC3dy9Rj81fTOmvf5ibdXlJz3HGTR9RtXiDc47YeowyXizA+ml+dP6aCta
         fmjsLOQ241rcGThMk8esXSzWQfWfi0mCsr1AWzxbk1UGRAltYtc0CadROB1MAcno81p2
         NKSipfrPT9cyRsyClR6PD4/6iz1QKLZcO6Du0XrZ+O3lO21cvrMtDjsTspqd42T6s7y8
         iifHkbkQyzHs1Q5lKc+L78Ql4hRKSG3RPw6iepbtXr6NCo1wvAV+5MEESUCjj6l+056B
         HtwfLeIB8lTZH8uv74P6OkCIZ+d6pZAXbJta68swjONOCru6fviLmjwr6pEqswUojkG4
         k7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763522517; x=1764127317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MrUjlXbQpuT/rGn9ebhDAet+g15u+mqlf//GGNvk5as=;
        b=cV99SdgYYoSMjMLCWJ+juS5J1IxuoVN9oW6zBucZj/VQQbbvW9FlhZYe0ptlg9pSKD
         44vh/a1kZh6jyNuxkVYwX6gjsiWprrkIANKANncKNYAJadkz4TEaNk6OUPOQBWbdd6Tq
         jHaFMkAvz1JF+R2MVAQoBwJk7snLRl0WVTbFVxhkeiZ/X07Qmvaujalin92/83d6Mj7G
         QOjuD4RsHAD3eJMJK4fcja/w0XaCHlLAzPZg37YYv6eifgJjMtVRvuuP5u+6hE6p1kVG
         x4X4q+sXqFhp+hqFdCgdy6IboXZwDe0g/fnOYyK5lIHS/Fty8eMbZVbOv2qQnqLyfe0Y
         h5FQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRKX6eBhQ2X3Sik4CG5USTviJMdBkjrmxPnNPf0gGsypBtW9nu0fz6cfpbsRPLbyy7lIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVX9MqyWAHCJxit5U2zBDdApRLM3qQVkgzsqGbgKMef8n+K3eu
	0AuccVoUqBnpQ7QHwrxO3r6LBF4dQZFbWIedNjcMPGBr/q9n4lZwMt2d
X-Gm-Gg: ASbGncv3uy69oHThJfuWI6gScxkXG4jMjdUNBnhI5NiG1thkzE49sK1u2SA+2TJTID7
	F+Li0sBeJVEz+xWlr/KjwT4vADAddGWl6W+2AdyU6sBnSL3ZTC1CM5V7IMwy18CXn9cSoyDzbiL
	GXa8cpJgQlK+U2Fx4ePkIs5jew7x1LNLCsaek1dQ+F8nbFiC5+kmXGyxhTB0/P38SoB3VoJnXYc
	on+1UjunIK0mYM+t5wFPWUE6jBDwg+52cs7lr+NHQy8KM7FYEyGmlyJiNCn/xdFADgYTwu6OEeR
	wQDWu9Pn4NW0E4vTZ+Hmg9Pz4Y+KCVXl6IYipZNr4zQT6XKe4Dx/kRdqcrWOQl8VFbvRz1iR26l
	9u60++PIAp2vNcu190uNP4xezKBcvrVyRt4HEqZePxMGozz9p7iWIpU7dGQlgxIfOIUbOV65fqc
	LWsFM4TfhzboppFcBSPadVKs92JWQ=
X-Google-Smtp-Source: AGHT+IEeqtmqV6MAaO/aC4GZwvfG+fRBuBRuioDCvJVWhMVtIzDtCsYz46QorBFw4vp/021FCzUk1g==
X-Received: by 2002:a17:902:da48:b0:295:9e4e:4090 with SMTP id d9443c01a7336-2986a766ba1mr199517065ad.52.1763522516753;
        Tue, 18 Nov 2025 19:21:56 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2bed5asm188352485ad.88.2025.11.18.19.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 19:21:55 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org,
	andrii.nakryiko@gmail.com
Cc: eddyz87@gmail.com,
	zhangxiaoqin@xiaomi.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Donglin Peng <pengdonglin@xiaomi.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Song Liu <song@kernel.org>
Subject: [RFC PATCH v7 5/7] libbpf: Implement BTF type sorting validation for binary search optimization
Date: Wed, 19 Nov 2025 11:15:29 +0800
Message-Id: <20251119031531.1817099-6-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251119031531.1817099-1-dolinux.peng@gmail.com>
References: <20251119031531.1817099-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Donglin Peng <pengdonglin@xiaomi.com>

This patch adds validation to verify BTF type name sorting, enabling
binary search optimization for lookups.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Song Liu <song@kernel.org>
Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
---
 tools/lib/bpf/btf.c | 59 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 1d19d95da1d0..d872abff42e1 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -903,6 +903,64 @@ int btf__resolve_type(const struct btf *btf, __u32 type_id)
 	return type_id;
 }
 
+/* Anonymous types (with empty names) are considered greater than named types
+ * and are sorted after them. Two anonymous types are considered equal. Named
+ * types are compared lexicographically.
+ */
+static int btf_compare_type_names(const void *a, const void *b, void *priv)
+{
+	struct btf *btf = (struct btf *)priv;
+	struct btf_type *ta = btf_type_by_id(btf, *(__u32 *)a);
+	struct btf_type *tb = btf_type_by_id(btf, *(__u32 *)b);
+	const char *na, *nb;
+	bool anon_a, anon_b;
+
+	na = btf__str_by_offset(btf, ta->name_off);
+	nb = btf__str_by_offset(btf, tb->name_off);
+	anon_a = str_is_empty(na);
+	anon_b = str_is_empty(nb);
+
+	if (anon_a && !anon_b)
+		return 1;
+	if (!anon_a && anon_b)
+		return -1;
+	if (anon_a && anon_b)
+		return 0;
+
+	return strcmp(na, nb);
+}
+
+/* Verifies that BTF types are sorted in ascending order according to their
+ * names, with named types appearing before anonymous types. If the ordering
+ * is correct, counts the number of named types and updates the BTF object's
+ * nr_sorted_types field.
+ */
+static void btf_check_sorted(struct btf *btf)
+{
+	const struct btf_type *t;
+	int i, k = 0, n, nr_sorted_types;
+
+	if (btf->nr_types < 2)
+		return;
+
+	nr_sorted_types = 0;
+	n = btf__type_cnt(btf) - 1;
+	for (i = btf->start_id; i < n; i++) {
+		k = i + 1;
+		if (btf_compare_type_names(&i, &k, btf) > 0)
+			return;
+		t = btf_type_by_id(btf, i);
+		if (!str_is_empty(btf__str_by_offset(btf, t->name_off)))
+			nr_sorted_types++;
+	}
+
+	t = btf_type_by_id(btf, k);
+	if (!str_is_empty(btf__str_by_offset(btf, t->name_off)))
+		nr_sorted_types++;
+	if (nr_sorted_types)
+		btf->nr_sorted_types = nr_sorted_types;
+}
+
 static __s32 btf_find_type_by_name_bsearch(const struct btf *btf, const char *name,
 						__s32 start_id, __s32 end_id)
 {
@@ -1148,6 +1206,7 @@ static struct btf *btf_new(const void *data, __u32 size, struct btf *base_btf, b
 	err = err ?: btf_sanity_check(btf);
 	if (err)
 		goto done;
+	btf_check_sorted(btf);
 
 done:
 	if (err) {
-- 
2.34.1


