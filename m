Return-Path: <bpf+bounces-18120-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3E7815E09
	for <lists+bpf@lfdr.de>; Sun, 17 Dec 2023 09:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC059283B97
	for <lists+bpf@lfdr.de>; Sun, 17 Dec 2023 08:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DD52571;
	Sun, 17 Dec 2023 08:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TR3T2Ncj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47F023D6
	for <bpf@vger.kernel.org>; Sun, 17 Dec 2023 08:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-db99bad7745so1648382276.0
        for <bpf@vger.kernel.org>; Sun, 17 Dec 2023 00:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702800710; x=1703405510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YwVABPiurYU0h6snjiaqzm9nh3rg+t29RoJEq18LE2g=;
        b=TR3T2NcjjOzHDzLzj79x7nHSg/C5cHmsZU7cbEA27jls3mtVzRyZiJzhqV3TTyIha+
         rDoznl+/OvlLHKY9hG3aFcGEV14N/9jIqNuc7Ain+zqOLu+iMu6qM/Iq2vrw4zWk+xfO
         TF7HvBl/NoiYZM5xLsftIP094Emg6D+mvq6kUhUa3VbD7WFXZhXGnc/NyLJJaQLk60kg
         0yxPal9H3V3BheRA7aMxdXOLSmdwCRZeVooj3bMDc6EM3wgIVhndAiyecwfMj8a0GAcH
         h4VlixsvkQIuMbAdR3EMG+Vaz7y7ExuA655xbGEqRIgeECg3kZdMX3utLj5XHtFqPx7+
         zlaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702800710; x=1703405510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YwVABPiurYU0h6snjiaqzm9nh3rg+t29RoJEq18LE2g=;
        b=lzKc6kZoI+QEnRPNjK17wzFPZQfcvmSj4azOgWKiS3Oxy2JyQLDuxKjY1iP/5iB1rl
         Y6AMLFLKhXNsAsj6ep49v1/il/MOrmhnkqwscC3sDNYnb8/Zt3xiasLgfbmOFUuaI/2K
         2h3oyvRhuD/zai1KsEeyYgU6MZ3ydoHJbkqyhVkMi9xfQc6QAk7uskTBFJ6dZcFMLpMX
         k0lFiprbHfl2lB3VKBZI5wc63W3hcz8zQdccGGAeVypIR3xa+tW2c7eMJtl0irSmBXiW
         fUXwaPVzHrdMn/bVXGyAPFZK5ntWyiNT9hKjyp1E+nE5IZHAEir0fBXtI9GNBkwFue69
         pnVA==
X-Gm-Message-State: AOJu0Yz3TAcEvlLwbQEoR9D3paLY9epuy9dgMSa3qRzZWs55l12zZPr2
	I4LJgWh/fgz8QEQ1bNuCrYa5leSnkpE=
X-Google-Smtp-Source: AGHT+IEN3QJYvG/D7kF4Q1qrnDzjU1kQk94FEBq75NV/aiN1F7Onm4fAyXxdxiOJchfz6T8UM5+txg==
X-Received: by 2002:a81:8585:0:b0:5d7:1940:53c7 with SMTP id v127-20020a818585000000b005d7194053c7mr12469446ywf.63.1702800710453;
        Sun, 17 Dec 2023 00:11:50 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:bb8c:c0f2:4408:50cf])
        by smtp.gmail.com with ESMTPSA id c85-20020a814e58000000b005e303826838sm3399415ywb.56.2023.12.17.00.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 00:11:50 -0800 (PST)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	drosen@google.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v14 07/14] bpf: lookup struct_ops types from a given module BTF.
Date: Sun, 17 Dec 2023 00:11:24 -0800
Message-Id: <20231217081132.1025020-8-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231217081132.1025020-1-thinker.li@gmail.com>
References: <20231217081132.1025020-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

This is a preparation for searching for struct_ops types from a specified
module. BTF is always btf_vmlinux now. This patch passes a pointer of BTF
to bpf_struct_ops_find_value() and bpf_struct_ops_find(). Once the new
registration API of struct_ops types is used, other BTFs besides
btf_vmlinux can also be passed to them.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/linux/bpf.h         |  4 ++--
 kernel/bpf/bpf_struct_ops.c | 11 ++++++-----
 kernel/bpf/verifier.c       |  2 +-
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 469d26d27e64..0163b46910b1 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1698,7 +1698,7 @@ struct bpf_struct_ops_desc {
 
 #if defined(CONFIG_BPF_JIT) && defined(CONFIG_BPF_SYSCALL)
 #define BPF_MODULE_OWNER ((void *)((0xeB9FUL << 2) + POISON_POINTER_DELTA))
-const struct bpf_struct_ops_desc *bpf_struct_ops_find(u32 type_id);
+const struct bpf_struct_ops_desc *bpf_struct_ops_find(struct btf *btf, u32 type_id);
 void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log);
 bool bpf_struct_ops_get(const void *kdata);
 void bpf_struct_ops_put(const void *kdata);
@@ -1742,7 +1742,7 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
 #endif
 void bpf_map_struct_ops_info_fill(struct bpf_map_info *info, struct bpf_map *map);
 #else
-static inline const struct bpf_struct_ops_desc *bpf_struct_ops_find(u32 type_id)
+static inline const struct bpf_struct_ops_desc *bpf_struct_ops_find(struct btf *btf, u32 type_id)
 {
 	return NULL;
 }
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 679bcdf763ef..bda31cc3bab0 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -221,11 +221,11 @@ void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log)
 extern struct btf *btf_vmlinux;
 
 static const struct bpf_struct_ops_desc *
-bpf_struct_ops_find_value(u32 value_id)
+bpf_struct_ops_find_value(struct btf *btf, u32 value_id)
 {
 	unsigned int i;
 
-	if (!value_id || !btf_vmlinux)
+	if (!value_id || !btf)
 		return NULL;
 
 	for (i = 0; i < ARRAY_SIZE(bpf_struct_ops); i++) {
@@ -236,11 +236,12 @@ bpf_struct_ops_find_value(u32 value_id)
 	return NULL;
 }
 
-const struct bpf_struct_ops_desc *bpf_struct_ops_find(u32 type_id)
+const struct bpf_struct_ops_desc *
+bpf_struct_ops_find(struct btf *btf, u32 type_id)
 {
 	unsigned int i;
 
-	if (!type_id || !btf_vmlinux)
+	if (!type_id || !btf)
 		return NULL;
 
 	for (i = 0; i < ARRAY_SIZE(bpf_struct_ops); i++) {
@@ -682,7 +683,7 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 	struct bpf_map *map;
 	int ret;
 
-	st_ops_desc = bpf_struct_ops_find_value(attr->btf_vmlinux_value_type_id);
+	st_ops_desc = bpf_struct_ops_find_value(btf_vmlinux, attr->btf_vmlinux_value_type_id);
 	if (!st_ops_desc)
 		return ERR_PTR(-ENOTSUPP);
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bd52d7b318a5..52c530b5733c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20094,7 +20094,7 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 	}
 
 	btf_id = prog->aux->attach_btf_id;
-	st_ops_desc = bpf_struct_ops_find(btf_id);
+	st_ops_desc = bpf_struct_ops_find(btf_vmlinux, btf_id);
 	if (!st_ops_desc) {
 		verbose(env, "attach_btf_id %u is not a supported struct\n",
 			btf_id);
-- 
2.34.1


