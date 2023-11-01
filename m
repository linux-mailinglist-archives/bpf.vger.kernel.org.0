Return-Path: <bpf+bounces-13825-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D601C7DE6D8
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 21:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AD86B21171
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 20:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FDC18630;
	Wed,  1 Nov 2023 20:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BfnrBkV2"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC592101F9
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 20:45:34 +0000 (UTC)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E2610E
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 13:45:31 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d9c7bba32beso202592276.1
        for <bpf@vger.kernel.org>; Wed, 01 Nov 2023 13:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698871530; x=1699476330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7FUry4RwIoQPA7qvWaSeYITPCsoTnmXfnNAPiaz/xKA=;
        b=BfnrBkV2/WsqYemBn7+c02tsjjRDOcTMz8Q/r5G21+T9Ot7/R56gbEbTkEz7eeNBAu
         MhR2HC68N8Jy88XLJNDg1hVBCxbraQoSOHYwSZQEOPw3HiyDhDYNNXqA9bwPRGBdTZLz
         vhQS/Hr8hZ+8FocZoroEviHIRulEmeo8SeGz80CH5Uxfk7IaAPTZecdHljW8yKvddGbg
         /9WudjN1hguq9tGZmJKUW5rxyeS/nKtSLQtGJxLUlpxKcRts8HSDy9iAJEhYxLl4v3W4
         yp+4QU5FEe8Lj+n3w3x2XYsMbua+UlHjKnv8aP74BZ9Yt0QtbD4uejhiTczlOgY62vsY
         lmSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698871530; x=1699476330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7FUry4RwIoQPA7qvWaSeYITPCsoTnmXfnNAPiaz/xKA=;
        b=vMB6HJ62OouQnAWrWODMChqWwl80s1B9ndZwVbYp1C41nb/9C3uzH0t4a5+9hMwVxH
         H/y5kZ5qWaS1/Hz/RFT5Po+YOlayxaTon3sJphLtRDI8yQoaTMKLtJjPwW9SeH5QJ77R
         ioogb9oHTlLwknBUYvi5QLORBKpHdyLao2e/G02J9ymUeXG4nrNooFEJNPilPP8XTXF9
         Rv+y1YPA+092Y+7aHhaGBT8lobvA3jiFjCtsCtAOw2UwOMZ7HSDdVnxbEAb3IVoe+ssm
         eFpK8hrqs3+T3Btdc3uTNrMHuqY807YFs2bSidNzwD+E+P/pDNWnfONiSTpt8oFip8gw
         zf3g==
X-Gm-Message-State: AOJu0Yy8ECzy+1j2jCbRYbD7v7uta1PjWTXq2r/oOGAHt2hXB5+r72fY
	K7oVYnaklIHPYNoCAK7nhuj8duu//aA=
X-Google-Smtp-Source: AGHT+IE8a/6Ms4VU+xJcH7Xg1k4OsnoMzdLo7KBc1HK1Zcrr/JAn3lRQBYCw4ZtaDAgBx4LZcNFYGA==
X-Received: by 2002:a25:adc8:0:b0:d86:2cd4:c443 with SMTP id d8-20020a25adc8000000b00d862cd4c443mr17514580ybe.21.1698871530662;
        Wed, 01 Nov 2023 13:45:30 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:eea0:6f66:c57d:6b7c])
        by smtp.gmail.com with ESMTPSA id o83-20020a25d756000000b00da086d6921fsm342386ybg.50.2023.11.01.13.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 13:45:30 -0700 (PDT)
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
Subject: [PATCH bpf-next v9 05/12] bpf: lookup struct_ops types from a given module BTF.
Date: Wed,  1 Nov 2023 13:45:12 -0700
Message-Id: <20231101204519.677870-6-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101204519.677870-1-thinker.li@gmail.com>
References: <20231101204519.677870-1-thinker.li@gmail.com>
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


