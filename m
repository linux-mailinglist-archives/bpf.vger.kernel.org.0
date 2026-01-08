Return-Path: <bpf+bounces-78194-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 545A0D00D7A
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 04:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 335FB3090A5D
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 03:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70697EAC7;
	Thu,  8 Jan 2026 03:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBJ/HBOO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3565D285066
	for <bpf@vger.kernel.org>; Thu,  8 Jan 2026 03:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767842223; cv=none; b=s6qZHw6556Hd2n7R+HF3/k8vHDfiJwwX86GG+GQ4d6vhRQIy4qfJvSNlrBhzQ2lErb9Dq0ZM/jCAY3XgQWSzHALUuD7SE+ipl77rFukL7yzAzmBPNb6CD4QVRQH1LJeYrn9K048bl47G/nFEngwQJBzSePDHMTIsIO1/VLJ/2mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767842223; c=relaxed/simple;
	bh=V2vGk2Zy5fJHvJb6bZZNfPor1jIBJ/nlZMkVKHTwBMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nb1b0asgWv/Ig4RA0HgbETVeb4nGO8MbNDVqQNWpTOcWJOXOgGp8+XfFWsCJqChlbfvBmVEbZt32jg8+RsK7mtgy4tcTSk3gjkWGUfJ20LJxAbRUIrGqq3prpaXcp7oPNKSsHaJ46bpkr8fYPMXrnkNY+Pl+I46uNRfkeYuIvwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hBJ/HBOO; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7e2762ad850so2338539b3a.3
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 19:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767842221; x=1768447021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bty2Mx4T9JTfidtdE5tI1SEQacGBSMSmT3cGtlsXrrQ=;
        b=hBJ/HBOOqNmmDb60WJtTA3CBMUoSqXFl8m0u7RHYAUSyczcDRXN8mMmdu1PeymdAOT
         UQ09oYEwBwBXED8N6TIgDPyFSTSa72rDE7YV9aYFzibI4tFlhJJpkPfcpZkinzscZuyc
         LT+0zRmewT7mqdpnogKV9ejwAQ6nBOqyw+P0a3Qsb17BRfyGBsxgMLGqonz3zcWtWNVz
         kUNsZQTs6LtL5hScszsmkg1W3d505Q3lgJNvEMPXiRxlFKzp0gt6vOE8OmMk2j1sP/n2
         dGosZdFTHvslwOCy1Lf79yHUko39ioX/PGoig/bndqrdMY4jZ7eRgnInGDNWn2AJjuuV
         8y8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767842221; x=1768447021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bty2Mx4T9JTfidtdE5tI1SEQacGBSMSmT3cGtlsXrrQ=;
        b=Cn9NuShw8dxJsLmOL/WHnh0VPsII9M6YSxh4assDWrJZPNep2FD41gKSK5hkHv3pP0
         3gxE0/Z0jBldO13I+hMFhGchOQArgJmwY1npU9kTDM6663gM9oa5eOkkzeFQuf9kJJcH
         Y8vNUWs95p5FBr091QCHsGy6x66mrgeobj+S9Zi5aRetW0NmzWGScw9IqDQUYySwqL+c
         LLL+vRu+mxoUfza1cJYn0B+6qmtiyT9x/WvmvVIwBDNUHM6ereBm5Wk2FLze7K3U5fN+
         WOavfBzyANk22igljN9UQsI+imcQE1xHHEzIgwVl4QcgAl5kU5pkCVu13umIaxl2k5wE
         tv/A==
X-Forwarded-Encrypted: i=1; AJvYcCXGMuFCHsNsOItbzZJ/zw0YUZFH2w3W39cva7gPpff2K5Zt5njj0hdqN99whXa/rsKVXc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOcuXzaeozR7HgHKORIawl/PjQyFnaT/CAnKbRuinj1tg9+IER
	gpIWDSSk1e3Up3q2tibT+iI47arY3MwHDXD5jRczEDku0U7FvfKOBDts
X-Gm-Gg: AY/fxX5EAnFBbWKUHiy7lIOiDdmpujnynB9Ecm/6BzfnCtcmTSezmhIzNkYqC2swV0M
	uup2oYO4sM8O6jbww+tJhPFXLutmjNhElhLAZuSV5hxxharK+hxfz8p5+/pT+PvOYlffjDWFGVu
	ODJBSBnQLsK7R2CDJecbockZQFkoAf0SiilmXqNDYwe8Y0pzDJlmI0pNYi4kzska3bpAiv/O3jI
	hqTJw0O+O7hAPGDalvhqVI4fhmiB21K2/SzTiW20QR/G7aOe9QQiluhJuQS7iz3Y1hiF2F3J7hT
	B6IItavycx8YCY7vbFBYTKVeGWYgwB6On/SxhfZWkW/MZgEEwYGGQj1Bi0zSGbGD8F5eHNkf5bI
	el44qmE4bwpf2YCKTElMGdSL7TD4DU4ta5KBZDmtWvOCj557x2M/bUtRnEfH0TpNH0JHQynM3oW
	52IUTH9g/KVhD/ij3xJE8EiBs62/I=
X-Google-Smtp-Source: AGHT+IHMEKVP3mhXgUpos/Q5KytBuzrqYEqaOFBA7IWN01A7RqP3IhiAjx4qP/6grxzJEKNhfrReQQ==
X-Received: by 2002:a05:6a00:3288:b0:7e8:4433:8fac with SMTP id d2e1a72fcca58-81b7fdc379bmr3840681b3a.52.1767842221498;
        Wed, 07 Jan 2026 19:17:01 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c5de655bsm6134860b3a.60.2026.01.07.19.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 19:17:01 -0800 (PST)
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
Subject: [PATCH bpf-next v11 03/11] tools/resolve_btfids: Support BTF sorting feature
Date: Thu,  8 Jan 2026 11:16:37 +0800
Message-Id: <20260108031645.1350069-4-dolinux.peng@gmail.com>
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

This introduces a new BTF sorting phase that specifically sorts
BTF types by name in ascending order, so that the binary search
can be used to look up types.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/bpf/resolve_btfids/main.c | 64 +++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index df39982f51df..343d08050116 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -850,6 +850,67 @@ static int dump_raw_btf(struct btf *btf, const char *out_path)
 	return 0;
 }
 
+/*
+ * Sort types by name in ascending order resulting in all
+ * anonymous types being placed before named types.
+ */
+static int cmp_type_names(const void *a, const void *b, void *priv)
+{
+	struct btf *btf = (struct btf *)priv;
+	const struct btf_type *ta = btf__type_by_id(btf, *(__u32 *)a);
+	const struct btf_type *tb = btf__type_by_id(btf, *(__u32 *)b);
+	const char *na, *nb;
+
+	na = btf__str_by_offset(btf, ta->name_off);
+	nb = btf__str_by_offset(btf, tb->name_off);
+	return strcmp(na, nb);
+}
+
+static int sort_btf_by_name(struct btf *btf)
+{
+	__u32 *permute_ids = NULL, *id_map = NULL;
+	int nr_types, i, err = 0;
+	__u32 start_id = 0, start_offs = 1, id;
+
+	if (btf__base_btf(btf)) {
+		start_id = btf__type_cnt(btf__base_btf(btf));
+		start_offs = 0;
+	}
+	nr_types = btf__type_cnt(btf) - start_id;
+
+	permute_ids = calloc(nr_types, sizeof(*permute_ids));
+	if (!permute_ids) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	id_map = calloc(nr_types, sizeof(*id_map));
+	if (!id_map) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	for (i = 0, id = start_id; i < nr_types; i++, id++)
+		permute_ids[i] = id;
+
+	qsort_r(permute_ids + start_offs, nr_types - start_offs,
+		sizeof(*permute_ids), cmp_type_names, btf);
+
+	for (i = 0; i < nr_types; i++) {
+		id = permute_ids[i] - start_id;
+		id_map[id] = i + start_id;
+	}
+
+	err = btf__permute(btf, id_map, nr_types, NULL);
+	if (err)
+		pr_err("FAILED: btf permute: %s\n", strerror(-err));
+
+out:
+	free(permute_ids);
+	free(id_map);
+	return err;
+}
+
 static inline int make_out_path(char *buf, u32 buf_sz, const char *in_path, const char *suffix)
 {
 	int len = snprintf(buf, buf_sz, "%s%s", in_path, suffix);
@@ -1025,6 +1086,9 @@ int main(int argc, const char **argv)
 	if (load_btf(&obj))
 		goto out;
 
+	if (sort_btf_by_name(obj.btf))
+		goto out;
+
 	if (elf_collect(&obj))
 		goto out;
 
-- 
2.34.1


