Return-Path: <bpf+bounces-10462-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 020617A8923
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 18:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E68C71C20A18
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 16:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2783D386;
	Wed, 20 Sep 2023 16:00:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DAB3C69D
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 16:00:19 +0000 (UTC)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7BEC6
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 09:00:17 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-59c0a7d54bdso57184577b3.1
        for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 09:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695225616; x=1695830416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1pawmbwonJqOvb4jbyhQiD/rIQ8Emeedok2tH8YDWlA=;
        b=GfwpTGVvNwsrl1FRBI0zPY+rUapMHlnecN5aitjr8xKXJXx8bOj1Ig2Wq+4Mbgze4k
         uq1hkfaU1D2dDf7XePoKAzoDs7hC+37U6RtJC6Lb9KZGFJ1pDoWLN6UXqEnucL5YM0FE
         /p9JBCVR4plvuOzjUDvdtHasC7Kh0xQxOWC9ie+CVfbJtA8s6Wl1gd8px5ycsA35QVS7
         NZE2O92Hadk/3F6Zwums7LKyFFdRXCZ64htQEO+3aIDdPwE6dQdiuVzYWTaehAgvWERK
         2rLVjESwJLojp+nvoe7tFkBmbHAy6ESQbfc+nTzvmOS33G5TzCWN6/En88LzgftOuvDn
         T+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695225616; x=1695830416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1pawmbwonJqOvb4jbyhQiD/rIQ8Emeedok2tH8YDWlA=;
        b=pAOXtHQkxrnmYIStIPmNkApw59wQqLPn+eJ0GesejzPBp1Y892gR5y/KaaEF/Bi29s
         71a2dQqfic8vmao42e/QYnOT57G8v25roVnPjfB1iFRcFs1hQW2qq923lGYQaTfUWdS4
         kUZsSl2rwgBBQcnpxiXE9S3p2GQGBVutm+IiM2O3ppoqvikbDt9ee9tSHxx0tIUk9TLk
         K2uVs26oWZWNkJBQwPHsh1YvzZD2zkH1idokJUo6J4cyYWahuCtKRirndk4z8sArXOPd
         5dgexkGLD/FRxwDPY088vIhrDzlJwj/9sNsTxbiQdoRInlcBMnaG5NbkcxDIjLv4zXe4
         XSXg==
X-Gm-Message-State: AOJu0Ywk/2c4F/WpMYHJtxmf2xih7MUJ0HwXTnbMYIYeErf5CHCA8qy0
	Ijd68T8LTD+qtP8BOKtaX/dSqqoPh0o=
X-Google-Smtp-Source: AGHT+IHElgqqpvAv4KTvWTHAFX3amZqQgwjmiCc+oEmkzpM6a/kf7q9P0f25SMUZZ6R/jGCpMu3y6g==
X-Received: by 2002:a0d:dec3:0:b0:59b:52bd:4d2a with SMTP id h186-20020a0ddec3000000b0059b52bd4d2amr2595420ywe.23.1695225615820;
        Wed, 20 Sep 2023 09:00:15 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:dcd2:9730:2c7c:239f])
        by smtp.gmail.com with ESMTPSA id m131-20020a817189000000b00589dbcf16cbsm3860490ywc.35.2023.09.20.09.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 09:00:14 -0700 (PDT)
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
Subject: [RFC bpf-next v3 03/11] bpf: add register and unregister functions for struct_ops.
Date: Wed, 20 Sep 2023 08:59:15 -0700
Message-Id: <20230920155923.151136-4-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230920155923.151136-1-thinker.li@gmail.com>
References: <20230920155923.151136-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Kui-Feng Lee <thinker.li@gmail.com>

Provide registration functions to add/remove struct_ops types.

Currently, it does linear search to find a struct_ops type. It should be
fine for now since we don't have many struct_ops types.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/linux/bpf.h         |  9 +++++++++
 include/linux/btf.h         | 27 +++++++++++++++++++++++++++
 kernel/bpf/bpf_struct_ops.c | 11 -----------
 kernel/bpf/btf.c            |  2 +-
 4 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 30063a760b5a..67554f2f81b7 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1634,6 +1634,11 @@ struct bpf_struct_ops {
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
@@ -3205,4 +3210,8 @@ static inline bool bpf_is_subprog(const struct bpf_prog *prog)
 	return prog->aux->func_idx != 0;
 }
 
+#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
+int register_bpf_struct_ops(struct bpf_struct_ops_mod *mod);
+#endif
+
 #endif /* _LINUX_BPF_H */
diff --git a/include/linux/btf.h b/include/linux/btf.h
index 5fabe23aedd2..8d50e46b21bc 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -12,6 +12,8 @@
 #include <uapi/linux/bpf.h>
 
 #define BTF_TYPE_EMIT(type) ((void)(type *)0)
+#define BTF_STRUCT_OPS_TYPE_EMIT(type) {((void)(struct type *)0);	\
+		((void)(struct bpf_struct_ops_##type *)0); }
 #define BTF_TYPE_EMIT_ENUM(enum_val) ((void)enum_val)
 
 /* These need to be macros, as the expressions are used in assembler input */
@@ -200,6 +202,7 @@ u32 btf_obj_id(const struct btf *btf);
 bool btf_is_kernel(const struct btf *btf);
 bool btf_is_module(const struct btf *btf);
 struct module *btf_try_get_module(const struct btf *btf);
+struct btf *btf_get_module_btf(const struct module *module);
 u32 btf_nr_types(const struct btf *btf);
 bool btf_member_is_reg_int(const struct btf *btf, const struct btf_type *s,
 			   const struct btf_member *m,
@@ -580,4 +583,28 @@ int btf_add_struct_ops(struct bpf_struct_ops *st_ops,
 const struct bpf_struct_ops **
 btf_get_struct_ops(struct btf *btf, u32 *ret_cnt);
 
+enum bpf_struct_ops_state {
+	BPF_STRUCT_OPS_STATE_INIT,
+	BPF_STRUCT_OPS_STATE_INUSE,
+	BPF_STRUCT_OPS_STATE_TOBEFREE,
+	BPF_STRUCT_OPS_STATE_READY,
+};
+
+#define BPF_STRUCT_OPS_COMMON_VALUE			\
+	refcount_t refcnt;				\
+	enum bpf_struct_ops_state state
+
+/* bpf_struct_ops_##_name (e.g. bpf_struct_ops_tcp_congestion_ops) is
+ * the map's value exposed to the userspace and its btf-type-id is
+ * stored at the map->btf_vmlinux_value_type_id.
+ *
+ */
+#define DEFINE_STRUCT_OPS_VALUE_TYPE(_name)			\
+extern struct bpf_struct_ops bpf_##_name;			\
+								\
+struct bpf_struct_ops_##_name {					\
+	BPF_STRUCT_OPS_COMMON_VALUE;				\
+	struct _name data ____cacheline_aligned_in_smp;		\
+};
+
 #endif
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 627cf1ea840a..cd688e9033b5 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -13,17 +13,6 @@
 #include <linux/btf_ids.h>
 #include <linux/rcupdate_wait.h>
 
-enum bpf_struct_ops_state {
-	BPF_STRUCT_OPS_STATE_INIT,
-	BPF_STRUCT_OPS_STATE_INUSE,
-	BPF_STRUCT_OPS_STATE_TOBEFREE,
-	BPF_STRUCT_OPS_STATE_READY,
-};
-
-#define BPF_STRUCT_OPS_COMMON_VALUE			\
-	refcount_t refcnt;				\
-	enum bpf_struct_ops_state state
-
 struct bpf_struct_ops_value {
 	BPF_STRUCT_OPS_COMMON_VALUE;
 	char data[] ____cacheline_aligned_in_smp;
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 3fb9964f8672..73d19ef99306 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7532,7 +7532,7 @@ struct module *btf_try_get_module(const struct btf *btf)
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


