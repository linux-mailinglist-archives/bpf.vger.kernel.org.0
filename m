Return-Path: <bpf+bounces-9863-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 083F679DFCB
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 08:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 836631C20B04
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 06:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8047215AF5;
	Wed, 13 Sep 2023 06:15:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC43A45
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 06:15:10 +0000 (UTC)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CF51730
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 23:15:09 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-58c92a2c52dso61501587b3.2
        for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 23:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694585708; x=1695190508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PCFimkrFCiT5ST7UdTzN4TI+iymkocXGAHReBSOeduc=;
        b=QOeF7rH67mjWkyJhnilqpyaivKLPtt5FpZtGUBnjRId3vM/T8ggLhq94EMVSDFb/XV
         XIxtaLXB9biMiGKDT/RmrcsIJX+gMjkZZmFghVv23sxMUaCcA6u9CjQYA5gfVxy2DdRJ
         Dn0gIhjfiI8SgvgCPXeOAKxshFLHaNwjP4jBdyPJYaNfjTp2KlYWk67HNj8XiePhGPWu
         /XsHph0SmrbN/FYnONbxT8h4t6DD1rpZ850QkXGkDIOIgRi8qT8rRmF42FpiyfZiQJKa
         COgP4PyIokTVYpK3n/8eHw39B4USWng7bGyV2O1woVrFX1p8JV6RhJX0xNP0LeLbhpWE
         iK5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694585708; x=1695190508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PCFimkrFCiT5ST7UdTzN4TI+iymkocXGAHReBSOeduc=;
        b=dr+pHKS3FP3HLtpi4vxVGw4W/OyZm7oqK9XdBGEAhLQXb1BuEJBcWyVAyudCJuD0+M
         33ZrZhp7RH/Q7l515uvaWUKzCeb3/RyKt7ZngahtF78hVBcmzqLoGps9emAlqKX4NLPi
         9ghfS1sKkbWiwHKl5ioPIe3CGIssUkWvZX66qYr5RZhJPLR9VbWkscQVQtfEXQqo+ltb
         PCbqOFPnDxnTmyoSo++95ojEHpCG3JARNWX1XtMIsXS4gOBN6HF0bNjoYZDYu7mGM2td
         N0XCBlXnT8Dq6HT+xU+bx9R1UyZ7OuAUuIgQPDg+ZS++DF0hGszwALKaZVIRi2apjjfG
         Zo6g==
X-Gm-Message-State: AOJu0Yw0MRGhH2oWhTZJXMMwxSptzJI1PfI23Xq4dOx0rNeThtIAmFiN
	JwJ+b6dLpfo2EoJxqThKS6cuZc9yatg=
X-Google-Smtp-Source: AGHT+IGVtfVmTa2I9zQmSyIAtxan2LC7Fjl5KFxM5sxS0EWPi88SRxzbtdejn/hdOLdmDUZrWZtf6w==
X-Received: by 2002:a81:490b:0:b0:576:93f1:d118 with SMTP id w11-20020a81490b000000b0057693f1d118mr1665043ywa.2.1694585708552;
        Tue, 12 Sep 2023 23:15:08 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:34c0:240e:9597:d8ed])
        by smtp.gmail.com with ESMTPSA id b132-20020a0dd98a000000b0057a5302e2fesm2961454ywe.5.2023.09.12.23.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 23:15:08 -0700 (PDT)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [RFC bpf-next v2 2/9] bpf: add register and unregister functions for struct_ops.
Date: Tue, 12 Sep 2023 23:14:42 -0700
Message-Id: <20230913061449.1918219-3-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230913061449.1918219-1-thinker.li@gmail.com>
References: <20230913061449.1918219-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

Provide registration functions to add/remove struct_ops types.

Currently, it does linear search to find a struct_ops type. It should be
fine for now since we don't have many struct_ops types.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/linux/bpf.h         |  13 ++++
 include/linux/btf.h         |   1 +
 kernel/bpf/bpf_struct_ops.c | 115 ++++++++++++++++++++++++++++++++++--
 kernel/bpf/btf.c            |   2 +-
 4 files changed, 126 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 024e8b28c34b..10f98f0ddc77 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1561,6 +1561,8 @@ struct btf_member;
  * @init: A callback that is invoked a single time, and before any other
  *	  callback, to initialize the structure. A nonzero return value means
  *	  the subsystem could not be initialized.
+ * @uninit: A callback that is invoked after any other
+ *	    callback to release resources used by the subsystem.
  * @check_member: When defined, a callback invoked by the verifier to allow
  *		  the subsystem to determine if an entry in the struct_ops map
  *		  is valid. A nonzero return value means that the map is
@@ -1601,6 +1603,7 @@ struct btf_member;
 struct bpf_struct_ops {
 	const struct bpf_verifier_ops *verifier_ops;
 	int (*init)(struct btf *btf);
+	int (*uninit)(void);
 	int (*check_member)(const struct btf_type *t,
 			    const struct btf_member *member,
 			    const struct bpf_prog *prog);
@@ -1619,6 +1622,11 @@ struct bpf_struct_ops {
 	u32 value_id;
 };
 
+struct bpf_struct_ops_mod {
+	struct module *owner;
+	struct bpf_struct_ops *st_ops;
+};
+
 #if defined(CONFIG_BPF_JIT) && defined(CONFIG_BPF_SYSCALL)
 #define BPF_MODULE_OWNER ((void *)((0xeB9FUL << 2) + POISON_POINTER_DELTA))
 const struct bpf_struct_ops *bpf_struct_ops_find(u32 type_id);
@@ -3183,4 +3191,9 @@ static inline gfp_t bpf_memcg_flags(gfp_t flags)
 	return flags;
 }
 
+#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
+int register_bpf_struct_ops(struct bpf_struct_ops_mod *mod);
+int unregister_bpf_struct_ops(struct bpf_struct_ops_mod *mod);
+#endif
+
 #endif /* _LINUX_BPF_H */
diff --git a/include/linux/btf.h b/include/linux/btf.h
index 928113a80a95..d6ed3d99ba41 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -200,6 +200,7 @@ u32 btf_obj_id(const struct btf *btf);
 bool btf_is_kernel(const struct btf *btf);
 bool btf_is_module(const struct btf *btf);
 struct module *btf_try_get_module(const struct btf *btf);
+struct btf *btf_get_module_btf(const struct module *module);
 u32 btf_nr_types(const struct btf *btf);
 bool btf_member_is_reg_int(const struct btf *btf, const struct btf_type *s,
 			   const struct btf_member *m,
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 1662875e0ebe..9be6e07ccba5 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -92,12 +92,15 @@ enum {
 	__NR_BPF_STRUCT_OPS_TYPE,
 };
 
-static struct bpf_struct_ops * const bpf_struct_ops[] = {
+static struct bpf_struct_ops *bpf_struct_ops_static[] = {
 #define BPF_STRUCT_OPS_TYPE(_name)				\
 	[BPF_STRUCT_OPS_TYPE_##_name] = &bpf_##_name,
 #include "bpf_struct_ops_types.h"
 #undef BPF_STRUCT_OPS_TYPE
 };
+static struct bpf_struct_ops **bpf_struct_ops;
+static int bpf_struct_ops_num;
+static int bpf_struct_ops_capacity;
 
 const struct bpf_verifier_ops bpf_struct_ops_verifier_ops = {
 };
@@ -212,12 +215,116 @@ void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log)
 	}
 	module_type = btf_type_by_id(btf, module_id);
 
-	for (i = 0; i < ARRAY_SIZE(bpf_struct_ops); i++) {
+	bpf_struct_ops_num = ARRAY_SIZE(bpf_struct_ops_static);
+	bpf_struct_ops_capacity = bpf_struct_ops_num;
+	bpf_struct_ops = bpf_struct_ops_static;
+
+	for (i = 0; i < bpf_struct_ops_num; i++) {
 		st_ops = bpf_struct_ops[i];
 		bpf_struct_ops_init_one(st_ops, btf, log);
 	}
 }
 
+static int add_struct_ops(struct bpf_struct_ops *st_ops)
+{
+	struct bpf_struct_ops **new_ops;
+	int i;
+
+	for (i = 0; i < bpf_struct_ops_num; i++) {
+		if (bpf_struct_ops[i] == st_ops)
+			return -EEXIST;
+		if (strcmp(bpf_struct_ops[i]->name, st_ops->name) == 0)
+			return -EEXIST;
+	}
+
+	if (bpf_struct_ops_num == bpf_struct_ops_capacity) {
+		if (bpf_struct_ops == bpf_struct_ops_static) {
+			new_ops = kmalloc_array(((bpf_struct_ops_capacity + 0x7) & ~0x7) * 2,
+						sizeof(*new_ops),
+						GFP_KERNEL);
+			if (!new_ops)
+				return -ENOMEM;
+			memcpy(new_ops, bpf_struct_ops,
+			       sizeof(*new_ops) * bpf_struct_ops_num);
+		} else {
+			new_ops = krealloc_array(bpf_struct_ops,
+						 bpf_struct_ops_capacity * 2,
+						 sizeof(*new_ops),
+						 GFP_KERNEL);
+			if (!new_ops)
+				return -ENOMEM;
+		}
+		bpf_struct_ops = new_ops;
+		bpf_struct_ops_capacity *= 2;
+	}
+
+	bpf_struct_ops[bpf_struct_ops_num++] = st_ops;
+	return 0;
+}
+
+static int remove_struct_ops(struct bpf_struct_ops *st_ops)
+{
+	int i;
+
+	for (i = 0; i < bpf_struct_ops_num; i++) {
+		if (bpf_struct_ops[i] == st_ops) {
+			bpf_struct_ops_num--;
+			bpf_struct_ops[i] = bpf_struct_ops[bpf_struct_ops_num];
+			return 0;
+		}
+	}
+
+	return -ENOENT;
+}
+
+int register_bpf_struct_ops(struct bpf_struct_ops_mod *mod)
+{
+	struct bpf_struct_ops *st_ops = mod->st_ops;
+	struct bpf_verifier_log *log;
+	struct btf *btf;
+	int err;
+
+	if (mod->st_ops == NULL ||
+	    mod->owner == NULL)
+		return -EINVAL;
+
+	log = kzalloc(sizeof(*log), GFP_KERNEL | __GFP_NOWARN);
+	if (!log) {
+		err = -ENOMEM;
+		goto errout;
+	}
+
+	log->level = BPF_LOG_KERNEL;
+
+	btf = btf_get_module_btf(mod->owner);
+	if (!btf) {
+		err = -EINVAL;
+		goto errout;
+	}
+
+	bpf_struct_ops_init_one(st_ops, btf, log);
+	err = add_struct_ops(st_ops);
+
+errout:
+	kfree(log);
+
+	return err;
+}
+EXPORT_SYMBOL(register_bpf_struct_ops);
+
+int unregister_bpf_struct_ops(struct bpf_struct_ops_mod *mod)
+{
+	struct bpf_struct_ops *st_ops = mod->st_ops;
+	int err;
+
+	err = remove_struct_ops(st_ops);
+	if (!err && st_ops->uninit)
+		err = st_ops->uninit();
+
+	return err;
+}
+EXPORT_SYMBOL(unregister_bpf_struct_ops);
+
 extern struct btf *btf_vmlinux;
 
 static const struct bpf_struct_ops *
@@ -228,7 +335,7 @@ bpf_struct_ops_find_value(u32 value_id)
 	if (!value_id || !btf_vmlinux)
 		return NULL;
 
-	for (i = 0; i < ARRAY_SIZE(bpf_struct_ops); i++) {
+	for (i = 0; i < bpf_struct_ops_num; i++) {
 		if (bpf_struct_ops[i]->value_id == value_id)
 			return bpf_struct_ops[i];
 	}
@@ -243,7 +350,7 @@ const struct bpf_struct_ops *bpf_struct_ops_find(u32 type_id)
 	if (!type_id || !btf_vmlinux)
 		return NULL;
 
-	for (i = 0; i < ARRAY_SIZE(bpf_struct_ops); i++) {
+	for (i = 0; i < bpf_struct_ops_num; i++) {
 		if (bpf_struct_ops[i]->type_id == type_id)
 			return bpf_struct_ops[i];
 	}
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 1095bbe29859..55d76d85c6ec 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7498,7 +7498,7 @@ struct module *btf_try_get_module(const struct btf *btf)
 /* Returns struct btf corresponding to the struct module.
  * This function can return NULL or ERR_PTR.
  */
-static struct btf *btf_get_module_btf(const struct module *module)
+struct btf *btf_get_module_btf(const struct module *module)
 {
 #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 	struct btf_module *btf_mod, *tmp;
-- 
2.34.1


