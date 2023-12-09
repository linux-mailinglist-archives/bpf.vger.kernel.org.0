Return-Path: <bpf+bounces-17284-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8F380B0F8
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 01:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3208B1C20D39
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 00:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3041915C1;
	Sat,  9 Dec 2023 00:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVP9hbnY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1058E1723
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 16:27:21 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5d226f51f71so25651367b3.3
        for <bpf@vger.kernel.org>; Fri, 08 Dec 2023 16:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702081640; x=1702686440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdB5FWiEnCQxPfhzIAOeyjpBWMnnHt30kmPLXgz+oXU=;
        b=KVP9hbnY6yjHRx6VsbmwQGUuB0v9zDbcSKrsaRmM9D0h8U3loe5dioMkEghTuy4SbK
         Dh7oGiilavw0TDX+UpXURgw8aWmICaoWBOZjeIvZQYitUNLmyuKdGu8kv6iG7cFI3jxV
         rKaw4rR75EARz6ZwlQ3QKoryrtCYYXqo5/yoXaHLcYXbLh/W0FjeYdQEQzdK7FQNwsMp
         PNT6Ff/WfWKD6yg54lSeC9IOStSTixX6ZNMSpqm9vXxXucY5gB6N1H0JhcJHzz7zP7ba
         kfPzR5XpFf6fJXtfup67yyXwHd/gadmQ6y0KxnF6pRM+Fmfg1X1KVBXzwMFeaqfq7jCC
         z5Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702081640; x=1702686440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jdB5FWiEnCQxPfhzIAOeyjpBWMnnHt30kmPLXgz+oXU=;
        b=NwTH4CFf1FhDDVo+ngAU80ZcyU7t2CHxBv0wIRZNf9glSJYOuKENKQ1VEKm6BjMCJt
         fp5DndR32At12qwjrqqoNpfwaKPF62mEihS5jhNba3s/nimWo84SaJ7kDQfyzmp1QqIu
         qCT1I2bU5DmSzIF1yINmdXa6wMmYXdkiV+rtjWAwkznUTKqkxlrGI+MNKW1/RwO31HEt
         oYEjPlwJZcRj4U17Qy8RC7EP4rwfwTLFj/o5Llxj+aPZ8++2McseXNVKQXtMDgD0MFZ9
         k7J4X2MSgZtcvfR0srGzk20v9Yofk57D/GQ3jKJ9QUODEWhtR8nrvmnfzX+CZ7MtwUkm
         EO0w==
X-Gm-Message-State: AOJu0Yy5eYJJx5HXJHDe2d20hUdpueHBB1kn+ZxRvIvAHbQBcXFyS15h
	oelyei6NeIwIlCmbmJKKEeYH3XPtSJs5Yw==
X-Google-Smtp-Source: AGHT+IETfJVYs3sT56teuJlJIqD/Up+3BlAESPfLPZfWyheBLpDYah2abJvyH49bGxB0MUjr0xfEqQ==
X-Received: by 2002:a81:488d:0:b0:5de:8c10:d17c with SMTP id v135-20020a81488d000000b005de8c10d17cmr796138ywa.66.1702081639849;
        Fri, 08 Dec 2023 16:27:19 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:65fe:fe26:c15:a05c])
        by smtp.gmail.com with ESMTPSA id v4-20020a818504000000b005d9729068f5sm1057450ywf.42.2023.12.08.16.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 16:27:19 -0800 (PST)
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
Subject: [PATCH bpf-next v13 06/14] bpf: lookup struct_ops types from a given module BTF.
Date: Fri,  8 Dec 2023 16:27:01 -0800
Message-Id: <20231209002709.535966-7-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231209002709.535966-1-thinker.li@gmail.com>
References: <20231209002709.535966-1-thinker.li@gmail.com>
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
index fa43255f59bc..91bcd62d6fcf 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1696,7 +1696,7 @@ struct bpf_struct_ops_desc {
 
 #if defined(CONFIG_BPF_JIT) && defined(CONFIG_BPF_SYSCALL)
 #define BPF_MODULE_OWNER ((void *)((0xeB9FUL << 2) + POISON_POINTER_DELTA))
-const struct bpf_struct_ops_desc *bpf_struct_ops_find(u32 type_id);
+const struct bpf_struct_ops_desc *bpf_struct_ops_find(struct btf *btf, u32 type_id);
 void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log);
 bool bpf_struct_ops_get(const void *kdata);
 void bpf_struct_ops_put(const void *kdata);
@@ -1739,7 +1739,7 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
 			    union bpf_attr __user *uattr);
 #endif
 #else
-static inline const struct bpf_struct_ops_desc *bpf_struct_ops_find(u32 type_id)
+static inline const struct bpf_struct_ops_desc *bpf_struct_ops_find(struct btf *btf, u32 type_id)
 {
 	return NULL;
 }
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 2b0c402740cc..ed4d84a8437c 100644
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
index ce41bc17ac10..6b45f56f8d4c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20078,7 +20078,7 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 	}
 
 	btf_id = prog->aux->attach_btf_id;
-	st_ops_desc = bpf_struct_ops_find(btf_id);
+	st_ops_desc = bpf_struct_ops_find(btf_vmlinux, btf_id);
 	if (!st_ops_desc) {
 		verbose(env, "attach_btf_id %u is not a supported struct\n",
 			btf_id);
-- 
2.34.1


