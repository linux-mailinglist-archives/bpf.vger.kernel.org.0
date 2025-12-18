Return-Path: <bpf+bounces-76973-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD166CCBA10
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 12:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECB5D30D9870
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 11:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C36231AA86;
	Thu, 18 Dec 2025 11:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxbVXIsU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB1231A044
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 11:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766057483; cv=none; b=U7U56TWdIz+Wl5Tmcz16tUM6Zt9uJ9wYSsToIwtx4nFYDZnpqyV/P13aBNTYo8bdjuGYS1BDHqNbptunyJsgpt0uLRicBog7nkwvMBzn298tVJMrFptrIHBTaZmovgU+1xlyqN9sX6U3yncxFeqrsBJOvUbTsyDJQVoHMYeqTpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766057483; c=relaxed/simple;
	bh=5djMaNHVV5H6BwOtjnSRGIWANgTzxyBijzGE08hQiWg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lb/93+JszO6DuyJfR1GLSvIWzViE2z9geQ9LWMAW7P5nMptEsH4iVk9QvxnpieuBg/KUTst04AOTEkk7w62dqLIHfZ9BaEcZ0MNwfI2JZL+BTnonuo22pOGDMzeRpgM9VzNCPQYZtR6ewOqmgOKSAdthmhmkOoTw18RjFHKni7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KxbVXIsU; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-34b75f7a134so430676a91.0
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 03:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766057481; x=1766662281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJcl/jCRaGXylPBo/Z8OTR3Isxk2SlLcxWMRbR2qK0s=;
        b=KxbVXIsUZr7ofE6D82+Mt7YdRY8DX08jdHXzzbFX5jwF+YXjPjs+qhfbBNnrNkN4rw
         znBBwUq6EKJVeKuL9BRPyc8OpVg6EX64nKXLD/AuA7dy+uq/OVBLumWnKFzT/JV2xL8h
         tY+op4UZEsv4lIPh85qTj0aDvRbIWII64QLNAZTx4+JuTY8fKaXvqClzLtb8AgDqLTaI
         wi/cpT+eAvVuoixAyR1YSHlO532RHcwXQfb457z8aYmc1KbWVKenDeUgISZX4XFRRXDm
         h366qBZYP+C9xY8BtZK5CAZ6ikcO9bhM5jqTGr+hrnc/oid8gdQHwzxiwUJDnsX736Ej
         a+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766057481; x=1766662281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RJcl/jCRaGXylPBo/Z8OTR3Isxk2SlLcxWMRbR2qK0s=;
        b=NNX67OeAulTmWm6OgD4OUt523m34z0c7cD5lt5UjZzErnR99H/iOohcJGL1V7gGeA/
         HXY0LqyyJ6TnVgUOzd/FEjy41zNOBbPwHdjQ9QOOT/DuydEMj0y4oZz9j2RXwUOrpXRN
         YV08b+Ee8c2iWXGYAO/lxlVG700qIITNE3d70WSglSk45Z8tAFhZ+W2LFzienf1qpL/P
         o7Dd370XZ295ohCN/fDDPgYhM4cbo0DxJhhrfxvQXkwECOEpkPu2Ji3gimtvTn0eBS/U
         fGptvf8RY+e393IzjWG3zUkSZi4f1tWZDBpddwYSNueOWAJYiGGB6YGDH18i3lIx/GUK
         mvNg==
X-Forwarded-Encrypted: i=1; AJvYcCUSkhBSlEnFAX0app6Qg/J86PRJu04BpSR41oR/2Y9p+iwwL7ckCIhcMwOUcyMF7ieDffo=@vger.kernel.org
X-Gm-Message-State: AOJu0YynfOB/eF3L4Z+9w7DjwhyZH7u92tRgWvg1sf1rvLR98LIpJ4J2
	3ewO+yKw5y/Lk7ELy9G66EWZ+0CJnyUy/TfRIhpBgNLnL6eudnjhKOef
X-Gm-Gg: AY/fxX6OZzbaHGTzsnV3aSeiEBJtK/0tN6rtCzVZFASavAistkZyiekK1UT2lUnizEY
	MXjCJVKuMJClDVmwt7htfFolXo3AB3vbPb6S2AG7JZiKtylrsOfmmYZlS6FQfE0870MsZBFWZAp
	VvQxxj3UtwZL9SkJHzNtn8i9m6LTR7pH6+wl25cokd0zU7CIwBEAhYIY0D6cM7ujRkp8fdWywo2
	HTSjNE/v56Hjg/HjdDjyem1UgQBFBDsBZMqocUbd68V/aGNvKq6LrCaDAahOsh37uCvd/m+uvDC
	0jCkZfGg1xjXqLBqxY0Bf1Ar6ft19zNtjMnkWb17vPb0oHUGAaf+TC8BdUxe5URCOkckI3k5JM0
	ZvhWMPnqL+zXcYPSAu2b782JAzEknp/9u6zWg9iKR7SoXCkZTnTn5w4eqsqchZF9vHsM1/ZERIR
	1sAEF8wOKAwfNGAxmnzdeMAPiknCc=
X-Google-Smtp-Source: AGHT+IEHum/i2me2oAGVYypygRW5Lr0FdJN1whl+oC0tykabf313G6Z1GvEaaE3TTKvu/tiyDmVWLQ==
X-Received: by 2002:a17:90b:2fc8:b0:340:be4d:a718 with SMTP id 98e67ed59e1d1-34abd7e76c9mr20430778a91.7.1766057481332;
        Thu, 18 Dec 2025 03:31:21 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70d4f887sm2328237a91.3.2025.12.18.03.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 03:31:20 -0800 (PST)
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
Subject: [PATCH bpf-next v10 03/13] tools/resolve_btfids: Support BTF sorting feature
Date: Thu, 18 Dec 2025 19:30:41 +0800
Message-Id: <20251218113051.455293-4-dolinux.peng@gmail.com>
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

This introduces a new BTF sorting phase that specifically sorts
BTF types by name in ascending order, so that the binary search
can be used to look up types.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/bpf/resolve_btfids/main.c | 68 +++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index 3e88dc862d87..659de35748ec 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -848,6 +848,71 @@ static int dump_raw_btf(struct btf *btf, const char *out_path)
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
+	__u32 start_id = 1, id;
+
+	if (btf__base_btf(btf))
+		start_id = btf__type_cnt(btf__base_btf(btf));
+	nr_types = btf__type_cnt(btf) - start_id;
+	if (nr_types < 2)
+		goto out;
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
+	qsort_r(permute_ids, nr_types, sizeof(*permute_ids), cmp_type_names, btf);
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
+static int btf2btf(struct object *obj)
+{
+	return sort_btf_by_name(obj->btf);
+}
+
 static inline int make_out_path(char *buf, u32 buf_sz, const char *in_path, const char *suffix)
 {
 	int len = snprintf(buf, buf_sz, "%s%s", in_path, suffix);
@@ -906,6 +971,9 @@ int main(int argc, const char **argv)
 	if (load_btf(&obj))
 		goto out;
 
+	if (btf2btf(&obj))
+		goto out;
+
 	if (elf_collect(&obj))
 		goto out;
 
-- 
2.34.1


