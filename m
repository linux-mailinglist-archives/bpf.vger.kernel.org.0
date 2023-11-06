Return-Path: <bpf+bounces-14319-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAAB57E2DF2
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 21:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64355280A8F
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 20:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED572E63C;
	Mon,  6 Nov 2023 20:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1nXaWZQ"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03162E634
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 20:13:11 +0000 (UTC)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCA51712
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 12:13:09 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5a81ab75f21so58911877b3.2
        for <bpf@vger.kernel.org>; Mon, 06 Nov 2023 12:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699301588; x=1699906388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7FUry4RwIoQPA7qvWaSeYITPCsoTnmXfnNAPiaz/xKA=;
        b=i1nXaWZQc9+554mTW38xXq4id3wi79WynLuEQLZEYeXGoVZs5lIEmcUEONs8SaYiSi
         rgUK9r2yXo8qqrYbD9R9tMJcfaI0diwO0SYy6z8G6bXDKp9LrT+YXUef6s81+XuyTsdK
         vMKunqyrWgDqOIisNXZp2na3tsxC1TXPlPYpYzU5gdTPhBT1nFxColl6GwxkMJ1J3VSN
         JU/uABN92mOaza8nj7PmEWc5oziej1N7Clequ4tQ0uXShjwid6/EF6oJE0J8hj2wQMuQ
         t0jxFW+2opogybCq4an+XXeK4BxxGa1D8x8LvUApOI50FaHjzJkMh7z4MwBxXFUwr4Q0
         cuNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699301588; x=1699906388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7FUry4RwIoQPA7qvWaSeYITPCsoTnmXfnNAPiaz/xKA=;
        b=DYsK18WH4tt4o6aXkV8Sp880PcJXW1Nso9M2SK1ffV9rCW8iU+U45SHlHphptwvB39
         51nfkLkpzm1nw6ze7yhP1DgCvJrxiI3GZ6z8bBjkdUtlR75y4xRApbYUlhSLCO73/0tl
         aCWV3UbbJSx8GRW8N1TMUaAyrXy1j6qm9CffPFfi2umhBTEnpmsYCE6nWhR6jVVtN4As
         +xAhlk9ftzfh+TGqgMwGt4vfPSzLw7g+/mG2VxIFm911vxVseSJMuF4BCeHQtBZxp14S
         l4xSMk2r5IUaW3k7Fkui3cHLSifdjYqhkNOJMY49D8YqNv8aL62zbYPASr73VKRKWWQi
         RAQg==
X-Gm-Message-State: AOJu0YyEqmMMJ9dI0afHVXCKHA9D8qED0F7RMPZZmX/lyJWOizQ2AVAu
	Y/GM6gBCT3UyetssvNE9VICWw3QKuZA=
X-Google-Smtp-Source: AGHT+IE//h0gMXB/p0RuJEffTx5iBI4p/opRoltISgm5jnxKzAzsl1yGYfO6VJG9l8nJDH+m+hxrAw==
X-Received: by 2002:a05:690c:388:b0:59b:cfe1:bcf1 with SMTP id bh8-20020a05690c038800b0059bcfe1bcf1mr11542006ywb.44.1699301587927;
        Mon, 06 Nov 2023 12:13:07 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:446d:cdea:6fa5:5630])
        by smtp.gmail.com with ESMTPSA id e65-20020a816944000000b0058427045833sm4760611ywc.133.2023.11.06.12.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 12:13:07 -0800 (PST)
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
Subject: [PATCH bpf-next v11 06/13] bpf: lookup struct_ops types from a given module BTF.
Date: Mon,  6 Nov 2023 12:12:45 -0800
Message-Id: <20231106201252.1568931-7-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106201252.1568931-1-thinker.li@gmail.com>
References: <20231106201252.1568931-1-thinker.li@gmail.com>
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
index b55e27162df0..f0ed874d5ac3 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1641,7 +1641,7 @@ struct bpf_struct_ops_desc {
 
 #if defined(CONFIG_BPF_JIT) && defined(CONFIG_BPF_SYSCALL)
 #define BPF_MODULE_OWNER ((void *)((0xeB9FUL << 2) + POISON_POINTER_DELTA))
-const struct bpf_struct_ops_desc *bpf_struct_ops_find(u32 type_id);
+const struct bpf_struct_ops_desc *bpf_struct_ops_find(struct btf *btf, u32 type_id);
 void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log);
 bool bpf_struct_ops_get(const void *kdata);
 void bpf_struct_ops_put(const void *kdata);
@@ -1684,7 +1684,7 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
 			    union bpf_attr __user *uattr);
 #endif
 #else
-static inline const struct bpf_struct_ops_desc *bpf_struct_ops_find(u32 type_id)
+static inline const struct bpf_struct_ops_desc *bpf_struct_ops_find(struct btf *btf, u32 type_id)
 {
 	return NULL;
 }
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index a0291877a792..4ba6181ed1c4 100644
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
@@ -676,7 +677,7 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 	struct bpf_map *map;
 	int ret;
 
-	st_ops_desc = bpf_struct_ops_find_value(attr->btf_vmlinux_value_type_id);
+	st_ops_desc = bpf_struct_ops_find_value(btf_vmlinux, attr->btf_vmlinux_value_type_id);
 	if (!st_ops_desc)
 		return ERR_PTR(-ENOTSUPP);
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 290e3a7ee72f..bdd166cab977 100644
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


