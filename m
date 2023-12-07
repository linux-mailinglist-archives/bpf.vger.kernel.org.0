Return-Path: <bpf+bounces-16964-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7153F807E01
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 02:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9563A1C21220
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 01:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B278F1C38;
	Thu,  7 Dec 2023 01:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSr3v8/N"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA7AD66
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 17:40:13 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5cece20f006so1424087b3.3
        for <bpf@vger.kernel.org>; Wed, 06 Dec 2023 17:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701913212; x=1702518012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3R5TXevNfxs1cSOanPsAaEQuaGWjZ7ZQg2eGu850H/U=;
        b=ZSr3v8/NQxc7JVq2JIBbsyqfPHCbXCwQKhIJne+0eo4KWUDQCyFHuTpYBrVODniubq
         wM2wqYdxA+bHXqjcm1WnP1u19KY4cxutVYWBsuTZBXkBsxzSTsa+yW7Rv+P7KkB25H56
         XBHeYZi6HeAyv3a/cntIlvc22svtA2ItjCU7BiCCJEG6rCfcECZkxwN3HFjFxqGO9TQs
         xc8fjv8Elu58zgyxHyzdsrLMtC5kQ8vHU6fYRQv8ZuwbyXQfWwW2LIH46HcGeddV1jZJ
         pi03Rvi10ucQPCTEMujBCl6qMof0r7b+RoNt+3a3o8q3ficCdGMUG1vu0O9fUyVFT1uJ
         wM6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701913212; x=1702518012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3R5TXevNfxs1cSOanPsAaEQuaGWjZ7ZQg2eGu850H/U=;
        b=UHmx/E+S/4V4ufvsMj6rbu+SxR4WC0BEwPMAqI/B1RuYVQcKxxMG/i9n878HB3xt8l
         Thy4JLewY5P+Tqm1swPUZutqWI7nagitWKOk/KhDPD8O924gp9tGtHSXEKICSHpwFbzn
         1UZyjw+STpoXzxwsBiRFUxJDs0bANRAbKE8V+OBWVz1UxAQUvhUTk0GBpsbQkGW7Bnn6
         C5tPpmsgvqsetokds6vBluwZOhDA+1/lPsjNpLqgUEAs2sQD8HMdeOZCAa1B9HVU76ca
         SCGzsYUViffka5nQppVfH8OKrzuyvJTIji6KfS1Kdk+QM6Pp4VkKMDeftFaeOh/enCvH
         UiRg==
X-Gm-Message-State: AOJu0YzLTAcuA4J+4smb5jLM+5NvXco2PgZHK7ZUZEe8jUknJgBBmTQe
	UgNHZMr/pX3uhoX5WtQ99LEMMJk11nI=
X-Google-Smtp-Source: AGHT+IH3gbLnHdj9D8LombJiXEu+9OCR4qh4xnsom/EW8mefbZAWFgOkVLPYkiHihSMj/wXic0HwvQ==
X-Received: by 2002:a81:784f:0:b0:5d7:1940:f3e2 with SMTP id t76-20020a81784f000000b005d71940f3e2mr1622056ywc.74.1701913212043;
        Wed, 06 Dec 2023 17:40:12 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:c8f2:3a3b:3003:f559])
        by smtp.gmail.com with ESMTPSA id v134-20020a81488c000000b005d997db3b2fsm60768ywa.23.2023.12.06.17.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 17:40:11 -0800 (PST)
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
Subject: [PATCH bpf-next v12 06/14] bpf: lookup struct_ops types from a given module BTF.
Date: Wed,  6 Dec 2023 17:39:42 -0800
Message-Id: <20231207013950.1689269-7-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231207013950.1689269-1-thinker.li@gmail.com>
References: <20231207013950.1689269-1-thinker.li@gmail.com>
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
index 73724e8caddf..59d26203f4d2 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1649,7 +1649,7 @@ struct bpf_struct_ops_desc {
 
 #if defined(CONFIG_BPF_JIT) && defined(CONFIG_BPF_SYSCALL)
 #define BPF_MODULE_OWNER ((void *)((0xeB9FUL << 2) + POISON_POINTER_DELTA))
-const struct bpf_struct_ops_desc *bpf_struct_ops_find(u32 type_id);
+const struct bpf_struct_ops_desc *bpf_struct_ops_find(struct btf *btf, u32 type_id);
 void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log);
 bool bpf_struct_ops_get(const void *kdata);
 void bpf_struct_ops_put(const void *kdata);
@@ -1692,7 +1692,7 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
 			    union bpf_attr __user *uattr);
 #endif
 #else
-static inline const struct bpf_struct_ops_desc *bpf_struct_ops_find(u32 type_id)
+static inline const struct bpf_struct_ops_desc *bpf_struct_ops_find(struct btf *btf, u32 type_id)
 {
 	return NULL;
 }
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 9e5d77ea738a..123ec76c48a9 100644
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
index 5b9652a0d062..405aeee608aa 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20020,7 +20020,7 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 	}
 
 	btf_id = prog->aux->attach_btf_id;
-	st_ops_desc = bpf_struct_ops_find(btf_id);
+	st_ops_desc = bpf_struct_ops_find(btf_vmlinux, btf_id);
 	if (!st_ops_desc) {
 		verbose(env, "attach_btf_id %u is not a supported struct\n",
 			btf_id);
-- 
2.34.1


