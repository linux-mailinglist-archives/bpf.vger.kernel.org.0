Return-Path: <bpf+bounces-14177-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B50D77E0C24
	for <lists+bpf@lfdr.de>; Sat,  4 Nov 2023 00:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D89E281A07
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 23:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72D826287;
	Fri,  3 Nov 2023 23:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAfCi0/y"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D8325116
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 23:22:21 +0000 (UTC)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5217DA2
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 16:22:20 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-58786e23d38so352070eaf.3
        for <bpf@vger.kernel.org>; Fri, 03 Nov 2023 16:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699053739; x=1699658539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7FUry4RwIoQPA7qvWaSeYITPCsoTnmXfnNAPiaz/xKA=;
        b=bAfCi0/y7stGlXjbt4NPzL79XCpJ2jYmuNgiSBRayw8TzXJ6N7BFtmQZrNAn1YnzHg
         2hqVyp/Zg7oYsLe5aFbeSMRweUbmW2K7WgtV1tKLOkLgkOO4lIUPZtVqvmSAiV+2UbUG
         UjpOpXvhBNXjSO9mQWqPzYNUzkTgv8odIlDEGCrkhFUWpkmBoH/jMKNTUzv02gwiCeVP
         +v2DwueWCB3T6VKIfoGtUdE7mSLzvtoY6GWhqzcR42GST5zSidPRYWoucQeZfzIxiMPw
         Uhs5XYGrdZHcAUAh2pT34rMYshY02Kb3KM+JhXGg68TdvZV+LqAM3UyNaHfitQGyuouF
         jnMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699053739; x=1699658539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7FUry4RwIoQPA7qvWaSeYITPCsoTnmXfnNAPiaz/xKA=;
        b=NNdtSekEEMVA+eFoejjxESQV+zBN2KAUkBWYXrYQNkPXvMHyQ3hfwx+l4ZcCfZdUUw
         LYC0yw2rwB/DixlChDaQ94ZzRWFmd7rJzhtKEvc8OfLL/wnb6IWkNIhwy3lIRjQxoI5f
         jXq2jx8a7ZuqzANjq5N40+yDQBT27wnLz27DfIOx8ldo5caHGr6GrdB7wOevkURgAxPa
         rD4M9YBfJ79lVzPJKlK0pzes7gC8awT+5pm6MQ4RK2FxnWc+l8B8GQ0TfDFcQna+1QyO
         O0azfqLVTxg06/A/zjx0OmPTIPMajEEON32VK1HUqUikRQWoABpLZtCVk6BEfXaxVm8w
         5UKA==
X-Gm-Message-State: AOJu0Yyt/jp27222m5USsAyOKWcc1nJBaLrcUOF7vJFdOA0Z+zcrok3t
	h+kBwIfLL/QCRwwxtO+H+VpzNvHZ/bk=
X-Google-Smtp-Source: AGHT+IHh/44gWaT7X9TAFpOu/Gnh2NAilRa9N3Ko32SkCAD0JQVNUSoSvjDOIEJL0sVAdguhXk6cSQ==
X-Received: by 2002:a4a:e8ce:0:b0:57b:6c85:972 with SMTP id h14-20020a4ae8ce000000b0057b6c850972mr18744910ooe.0.1699053739113;
        Fri, 03 Nov 2023 16:22:19 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:287:9d8c:4ad:9459])
        by smtp.gmail.com with ESMTPSA id 186-20020a4a14c3000000b0057b8baf00bbsm532288ood.22.2023.11.03.16.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 16:22:18 -0700 (PDT)
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
Subject: [PATCH bpf-next v10 06/13] bpf: lookup struct_ops types from a given module BTF.
Date: Fri,  3 Nov 2023 16:21:55 -0700
Message-Id: <20231103232202.3664407-7-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103232202.3664407-1-thinker.li@gmail.com>
References: <20231103232202.3664407-1-thinker.li@gmail.com>
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


