Return-Path: <bpf+bounces-980-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B56F970A2F1
	for <lists+bpf@lfdr.de>; Sat, 20 May 2023 00:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D72C281C0B
	for <lists+bpf@lfdr.de>; Fri, 19 May 2023 22:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946EA6FA1;
	Fri, 19 May 2023 22:52:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7126AB3
	for <bpf@vger.kernel.org>; Fri, 19 May 2023 22:52:13 +0000 (UTC)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE5B1B3
	for <bpf@vger.kernel.org>; Fri, 19 May 2023 15:52:09 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-530638a60e1so3529826a12.2
        for <bpf@vger.kernel.org>; Fri, 19 May 2023 15:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1684536728; x=1687128728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1mMHL9BrN/4I2tgPLf1ovFUop4r/zTIH+bjmli+x/vM=;
        b=KndMyEw4gmUqI0gp6xILIFLVt0Fnmq84TIOCx6t4EtN1fTTPe6EVkpAbyruLFeR7u7
         DFXCNb9WajWrlvTxgYIb3KVuri3Qt3Mt+38QVcyTOrR8HzRokuwtBRppSm1t8T0zovpG
         mia919eM78Ep6lxXrPmRZXv7yfvMekj3Gg3359RAnGRvuelx5jy4QOQHQEArfrBbN9Dl
         bLgyHak9l8EYfqmmrgOizTa+mFfN2lgbsYXL0/B9xUx1aqqoBKBzQUuP8dt/9FnZpLjU
         AppAejR5XE3bKBFgER0jaQtMoXLDDaeaAIvj90gATbruICHGObjAKJ69alwV3LbjH0ID
         /EHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684536728; x=1687128728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1mMHL9BrN/4I2tgPLf1ovFUop4r/zTIH+bjmli+x/vM=;
        b=K03MR2ThkCO3z6h/fOYu/+Kum4GokxGiXFwIHYd4YNyZAF7nyESCejBZp8PjAY+IGB
         RVxU/hC/JBuN32sSWluncu6q1dbISbv6yIzXuvaK1u6tPU65laQECGOS+fpE+9uaW2hx
         7ZweRHg7SkmnlaMKhZ7GMy4zN741w7C+R4u7CyH6IYZ/pqju74+9Y50ma3rFG30XKzTD
         +EE+dxEClzkagDL+mV03kfLCBXyGJimL+biL+pX9dZhXWxzSx3AVCKrkNCF/e+7OFcqo
         vYHcyEZDufmLubYfkeDHq1piM1+n/54HXmDMrs0rzfkLJkAtcAfOoZ3Psh5WPcfsr1eM
         ghvg==
X-Gm-Message-State: AC+VfDxZgS0KU4/Sm9T9i1ddUsRDvVaGoGieC7eodk5prRKbQrofbwGZ
	gnvsxUt6mjo7hTHjuhG9c2REFElnzrZ7YJ8yghU=
X-Google-Smtp-Source: ACHHUZ6tkACOY8tUzhAddvHh1w27u6d1VF3rUbC+YH3mZ/CeHfuONGsHkSAPXag6OT64zV0UPhxDLA==
X-Received: by 2002:a17:903:32c8:b0:1ad:cba5:5505 with SMTP id i8-20020a17090332c800b001adcba55505mr4429628plr.14.1684536728291;
        Fri, 19 May 2023 15:52:08 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4611:8100::1])
        by smtp.gmail.com with ESMTPSA id j4-20020a170902c08400b001a6ed2d0ef8sm117880pld.273.2023.05.19.15.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 15:52:07 -0700 (PDT)
From: Aditi Ghag <aditi.ghag@isovalent.com>
To: bpf@vger.kernel.org
Cc: kafai@fb.com,
	sdf@google.com,
	aditi.ghag@isovalent.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH v9 bpf-next 6/9] bpf: Add kfunc filter function to 'struct btf_kfunc_id_set'
Date: Fri, 19 May 2023 22:51:54 +0000
Message-Id: <20230519225157.760788-7-aditi.ghag@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230519225157.760788-1-aditi.ghag@isovalent.com>
References: <20230519225157.760788-1-aditi.ghag@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This commit adds the ability to filter kfuncs to certain BPF program
types. This is required to limit bpf_sock_destroy kfunc implemented in
follow-up commits to programs with attach type 'BPF_TRACE_ITER'.

The commit adds a callback filter to 'struct btf_kfunc_id_set'.  The
filter has access to the `bpf_prog` construct including its properties
such as `expected_attached_type`.

Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 include/linux/btf.h   | 18 ++++++++-----
 kernel/bpf/btf.c      | 61 ++++++++++++++++++++++++++++++++++++-------
 kernel/bpf/verifier.c |  7 ++---
 3 files changed, 66 insertions(+), 20 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 495250162422..918a0b6379bd 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -99,10 +99,14 @@ struct btf_type;
 union bpf_attr;
 struct btf_show;
 struct btf_id_set;
+struct bpf_prog;
+
+typedef int (*btf_kfunc_filter_t)(const struct bpf_prog *prog, u32 kfunc_id);
 
 struct btf_kfunc_id_set {
 	struct module *owner;
 	struct btf_id_set8 *set;
+	btf_kfunc_filter_t filter;
 };
 
 struct btf_id_dtor_kfunc {
@@ -482,7 +486,6 @@ static inline void *btf_id_set8_contains(const struct btf_id_set8 *set, u32 id)
 	return bsearch(&id, set->pairs, set->cnt, sizeof(set->pairs[0]), btf_id_cmp_func);
 }
 
-struct bpf_prog;
 struct bpf_verifier_log;
 
 #ifdef CONFIG_BPF_SYSCALL
@@ -490,10 +493,10 @@ const struct btf_type *btf_type_by_id(const struct btf *btf, u32 type_id);
 const char *btf_name_by_offset(const struct btf *btf, u32 offset);
 struct btf *btf_parse_vmlinux(void);
 struct btf *bpf_prog_get_target_btf(const struct bpf_prog *prog);
-u32 *btf_kfunc_id_set_contains(const struct btf *btf,
-			       enum bpf_prog_type prog_type,
-			       u32 kfunc_btf_id);
-u32 *btf_kfunc_is_modify_return(const struct btf *btf, u32 kfunc_btf_id);
+u32 *btf_kfunc_id_set_contains(const struct btf *btf, u32 kfunc_btf_id,
+			       const struct bpf_prog *prog);
+u32 *btf_kfunc_is_modify_return(const struct btf *btf, u32 kfunc_btf_id,
+				const struct bpf_prog *prog);
 int register_btf_kfunc_id_set(enum bpf_prog_type prog_type,
 			      const struct btf_kfunc_id_set *s);
 int register_btf_fmodret_id_set(const struct btf_kfunc_id_set *kset);
@@ -520,8 +523,9 @@ static inline const char *btf_name_by_offset(const struct btf *btf,
 	return NULL;
 }
 static inline u32 *btf_kfunc_id_set_contains(const struct btf *btf,
-					     enum bpf_prog_type prog_type,
-					     u32 kfunc_btf_id)
+					     u32 kfunc_btf_id,
+					     struct bpf_prog *prog)
+
 {
 	return NULL;
 }
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 913b9d717a4a..c22325daf4a5 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -218,10 +218,17 @@ enum btf_kfunc_hook {
 enum {
 	BTF_KFUNC_SET_MAX_CNT = 256,
 	BTF_DTOR_KFUNC_MAX_CNT = 256,
+	BTF_KFUNC_FILTER_MAX_CNT = 16,
+};
+
+struct btf_kfunc_hook_filter {
+	btf_kfunc_filter_t filters[BTF_KFUNC_FILTER_MAX_CNT];
+	u32 nr_filters;
 };
 
 struct btf_kfunc_set_tab {
 	struct btf_id_set8 *sets[BTF_KFUNC_HOOK_MAX];
+	struct btf_kfunc_hook_filter hook_filters[BTF_KFUNC_HOOK_MAX];
 };
 
 struct btf_id_dtor_kfunc_tab {
@@ -7720,9 +7727,12 @@ static int btf_check_kfunc_protos(struct btf *btf, u32 func_id, u32 func_flags)
 /* Kernel Function (kfunc) BTF ID set registration API */
 
 static int btf_populate_kfunc_set(struct btf *btf, enum btf_kfunc_hook hook,
-				  struct btf_id_set8 *add_set)
+				  const struct btf_kfunc_id_set *kset)
 {
+	struct btf_kfunc_hook_filter *hook_filter;
+	struct btf_id_set8 *add_set = kset->set;
 	bool vmlinux_set = !btf_is_module(btf);
+	bool add_filter = !!kset->filter;
 	struct btf_kfunc_set_tab *tab;
 	struct btf_id_set8 *set;
 	u32 set_cnt;
@@ -7737,6 +7747,22 @@ static int btf_populate_kfunc_set(struct btf *btf, enum btf_kfunc_hook hook,
 		return 0;
 
 	tab = btf->kfunc_set_tab;
+
+	if (tab && add_filter) {
+		int i;
+
+		hook_filter = &tab->hook_filters[hook];
+		for (i = 0; i < hook_filter->nr_filters; i++) {
+			if (hook_filter->filters[i] == kset->filter) {
+				add_filter = false;
+				break;
+			}
+		}
+
+		if (add_filter && hook_filter->nr_filters == BTF_KFUNC_FILTER_MAX_CNT)
+			return -E2BIG;
+	}
+
 	if (!tab) {
 		tab = kzalloc(sizeof(*tab), GFP_KERNEL | __GFP_NOWARN);
 		if (!tab)
@@ -7759,7 +7785,7 @@ static int btf_populate_kfunc_set(struct btf *btf, enum btf_kfunc_hook hook,
 	 */
 	if (!vmlinux_set) {
 		tab->sets[hook] = add_set;
-		return 0;
+		goto do_add_filter;
 	}
 
 	/* In case of vmlinux sets, there may be more than one set being
@@ -7801,6 +7827,11 @@ static int btf_populate_kfunc_set(struct btf *btf, enum btf_kfunc_hook hook,
 
 	sort(set->pairs, set->cnt, sizeof(set->pairs[0]), btf_id_cmp_func, NULL);
 
+do_add_filter:
+	if (add_filter) {
+		hook_filter = &tab->hook_filters[hook];
+		hook_filter->filters[hook_filter->nr_filters++] = kset->filter;
+	}
 	return 0;
 end:
 	btf_free_kfunc_set_tab(btf);
@@ -7809,15 +7840,22 @@ static int btf_populate_kfunc_set(struct btf *btf, enum btf_kfunc_hook hook,
 
 static u32 *__btf_kfunc_id_set_contains(const struct btf *btf,
 					enum btf_kfunc_hook hook,
+					const struct bpf_prog *prog,
 					u32 kfunc_btf_id)
 {
+	struct btf_kfunc_hook_filter *hook_filter;
 	struct btf_id_set8 *set;
-	u32 *id;
+	u32 *id, i;
 
 	if (hook >= BTF_KFUNC_HOOK_MAX)
 		return NULL;
 	if (!btf->kfunc_set_tab)
 		return NULL;
+	hook_filter = &btf->kfunc_set_tab->hook_filters[hook];
+	for (i = 0; i < hook_filter->nr_filters; i++) {
+		if (hook_filter->filters[i](prog, kfunc_btf_id))
+			return NULL;
+	}
 	set = btf->kfunc_set_tab->sets[hook];
 	if (!set)
 		return NULL;
@@ -7870,23 +7908,25 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
  * protection for looking up a well-formed btf->kfunc_set_tab.
  */
 u32 *btf_kfunc_id_set_contains(const struct btf *btf,
-			       enum bpf_prog_type prog_type,
-			       u32 kfunc_btf_id)
+			       u32 kfunc_btf_id,
+			       const struct bpf_prog *prog)
 {
+	enum bpf_prog_type prog_type = resolve_prog_type(prog);
 	enum btf_kfunc_hook hook;
 	u32 *kfunc_flags;
 
-	kfunc_flags = __btf_kfunc_id_set_contains(btf, BTF_KFUNC_HOOK_COMMON, kfunc_btf_id);
+	kfunc_flags = __btf_kfunc_id_set_contains(btf, BTF_KFUNC_HOOK_COMMON, prog, kfunc_btf_id);
 	if (kfunc_flags)
 		return kfunc_flags;
 
 	hook = bpf_prog_type_to_kfunc_hook(prog_type);
-	return __btf_kfunc_id_set_contains(btf, hook, kfunc_btf_id);
+	return __btf_kfunc_id_set_contains(btf, hook, prog, kfunc_btf_id);
 }
 
-u32 *btf_kfunc_is_modify_return(const struct btf *btf, u32 kfunc_btf_id)
+u32 *btf_kfunc_is_modify_return(const struct btf *btf, u32 kfunc_btf_id,
+				const struct bpf_prog *prog)
 {
-	return __btf_kfunc_id_set_contains(btf, BTF_KFUNC_HOOK_FMODRET, kfunc_btf_id);
+	return __btf_kfunc_id_set_contains(btf, BTF_KFUNC_HOOK_FMODRET, prog, kfunc_btf_id);
 }
 
 static int __register_btf_kfunc_id_set(enum btf_kfunc_hook hook,
@@ -7917,7 +7957,8 @@ static int __register_btf_kfunc_id_set(enum btf_kfunc_hook hook,
 			goto err_out;
 	}
 
-	ret = btf_populate_kfunc_set(btf, hook, kset->set);
+	ret = btf_populate_kfunc_set(btf, hook, kset);
+
 err_out:
 	btf_put(btf);
 	return ret;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d6db6de3e9ea..8d9519210935 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10534,7 +10534,7 @@ static int fetch_kfunc_meta(struct bpf_verifier_env *env,
 		*kfunc_name = func_name;
 	func_proto = btf_type_by_id(desc_btf, func->type);
 
-	kfunc_flags = btf_kfunc_id_set_contains(desc_btf, resolve_prog_type(env->prog), func_id);
+	kfunc_flags = btf_kfunc_id_set_contains(desc_btf, func_id, env->prog);
 	if (!kfunc_flags) {
 		return -EACCES;
 	}
@@ -18526,7 +18526,8 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 				 * in the fmodret id set with the KF_SLEEPABLE flag.
 				 */
 				else {
-					u32 *flags = btf_kfunc_is_modify_return(btf, btf_id);
+					u32 *flags = btf_kfunc_is_modify_return(btf, btf_id,
+										prog);
 
 					if (flags && (*flags & KF_SLEEPABLE))
 						ret = 0;
@@ -18554,7 +18555,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 				return -EINVAL;
 			}
 			ret = -EINVAL;
-			if (btf_kfunc_is_modify_return(btf, btf_id) ||
+			if (btf_kfunc_is_modify_return(btf, btf_id, prog) ||
 			    !check_attach_modify_return(addr, tname))
 				ret = 0;
 			if (ret) {
-- 
2.34.1


