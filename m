Return-Path: <bpf+bounces-812-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D165707049
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 20:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D824B281595
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 17:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD7731EF9;
	Wed, 17 May 2023 17:59:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A0310966
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 17:59:50 +0000 (UTC)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F03213B
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 10:59:48 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1ae3a5dfa42so8991135ad.0
        for <bpf@vger.kernel.org>; Wed, 17 May 2023 10:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1684346388; x=1686938388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jg0WCZ9Iqn+RY0bfCJQZxl/NIAZaJJtjp8wqjrC3QVo=;
        b=YvTsUOtVRHiRSOePgj5r0JKiYHscV+VNCoKuAu4ubK0fk6id3spA+kXQshSutR7wcA
         /F3QFjs//mp7UqyBRrAsHUMtvfXImpIGrddIF0aY9WiHHLggkID6m7M5h9oGVmgbDvra
         noa5p+oDjGcWZWZjt4lXLyQ6giGpYEi3IRPfW/GQl0QxCSJY/M7J6ZHxaQgiOjiBbbKN
         uhYYQ6LArNKQaSJh+cy8/jhtXlGFKasX+C6hJobJxmM0uAL4mgbHynLoQxzkuleEbntz
         fQTA6pQp5NmUrEoWAXO9VS2uSqZjOgO6olMqmtqTuwlGvJJcs67ejipuqZ8lb193gE9R
         zdqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684346388; x=1686938388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jg0WCZ9Iqn+RY0bfCJQZxl/NIAZaJJtjp8wqjrC3QVo=;
        b=JpUMPrh/DYbgUZwnsHS8ZaKzqJljOf8tQH3H4392xitBPmP62bJFfBvCD4PaMAfvtv
         Iw3xfC9uPnzX9ahPbqv/jUbi5O4dHPMfs+ceV2a9Im3ZCFH3pcu7+hLDVU4o9RVxki27
         lRoUk1sokL0CI6rlHU+uhqOK42UVzg/7ObW5gdTwUuSk3s/Rh3o4Yig9fwpp3Q3iZgOS
         4YePR0cX0fIa+x0tqfDDsjzX4TD/BlI5cpwbFtJnxy2QWrBWqOUi+nQoxmhFVNIIzRLU
         aghQJ8CW+t/NMD3nsxdB6DRI5MsjzyDTg0NkB5cm4AUY0NxCdn39Gmkzsbpi+lbJltn8
         FH/g==
X-Gm-Message-State: AC+VfDzHfQlYA3H/Iy3zeDPkbRj/HfonMUy0dbM+jyubSbkBXrjebEwO
	i53W2qlzgBCgpHXroVtLWnOhY6PnNBZ3bVqTOww=
X-Google-Smtp-Source: ACHHUZ5ziiQtvleNrisQ6gY/2S33XpIQtSVDODt3j0loqBEQr5iQJbg7cNiAPWM+K8BIarCyq/zTAA==
X-Received: by 2002:a17:902:e5cf:b0:1ac:807b:deb1 with SMTP id u15-20020a170902e5cf00b001ac807bdeb1mr39670588plf.38.1684346387671;
        Wed, 17 May 2023 10:59:47 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4611:8100::1])
        by smtp.gmail.com with ESMTPSA id f11-20020a17090274cb00b001a6db2bef16sm17815989plt.303.2023.05.17.10.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 10:59:47 -0700 (PDT)
From: Aditi Ghag <aditi.ghag@isovalent.com>
To: bpf@vger.kernel.org
Cc: kafai@fb.com,
	sdf@google.com,
	void@manifault.com,
	aditi.ghag@isovalent.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH v8 bpf-next 09/10] bpf: Add kfunc filter function to 'struct btf_kfunc_id_set'
Date: Wed, 17 May 2023 17:59:42 +0000
Message-Id: <20230517175942.528375-1-aditi.ghag@isovalent.com>
X-Mailer: git-send-email 2.34.1
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
types, and thereby limits bpf_sock_destroy kfunc to programs with attach
type 'BPF_TRACE_ITER'.
Previous commits introduced 'bpf_sock_destroy kfunc' that can only be
called from BPF (sockets) iterator type programs.  The reason being, the
kfunc requires lock_sock to be done from the BPF context prior to
calling the kfunc.
To that end, the patch adds a callback filter to 'struct
btf_kfunc_id_set'.  The filter has access to the bpf_prog construct
including other properties of the bpf_prog. For the bpf_sock_destroy case,
the `expected_attached_type` property of a bpf_prog construct is used to
allow access to the kfunc in the provided callback filter.

Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 include/linux/btf.h   | 18 ++++++++-----
 kernel/bpf/btf.c      | 59 +++++++++++++++++++++++++++++++++++--------
 kernel/bpf/verifier.c |  7 ++---
 net/core/filter.c     |  9 +++++++
 4 files changed, 73 insertions(+), 20 deletions(-)

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
index 913b9d717a4a..c6dae44e236d 100644
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
@@ -7737,6 +7747,20 @@ static int btf_populate_kfunc_set(struct btf *btf, enum btf_kfunc_hook hook,
 		return 0;
 
 	tab = btf->kfunc_set_tab;
+
+	if (tab && add_filter) {
+		int i;
+
+		hook_filter = &tab->hook_filters[hook];
+		for (i = 0; i < hook_filter->nr_filters; i++) {
+			if (hook_filter->filters[i] == kset->filter)
+				add_filter = false;
+		}
+
+		if (add_filter && hook_filter->nr_filters == BTF_KFUNC_FILTER_MAX_CNT)
+			return -E2BIG;
+	}
+
 	if (!tab) {
 		tab = kzalloc(sizeof(*tab), GFP_KERNEL | __GFP_NOWARN);
 		if (!tab)
@@ -7759,7 +7783,7 @@ static int btf_populate_kfunc_set(struct btf *btf, enum btf_kfunc_hook hook,
 	 */
 	if (!vmlinux_set) {
 		tab->sets[hook] = add_set;
-		return 0;
+		goto do_add_filter;
 	}
 
 	/* In case of vmlinux sets, there may be more than one set being
@@ -7801,6 +7825,11 @@ static int btf_populate_kfunc_set(struct btf *btf, enum btf_kfunc_hook hook,
 
 	sort(set->pairs, set->cnt, sizeof(set->pairs[0]), btf_id_cmp_func, NULL);
 
+do_add_filter:
+	if (add_filter) {
+		hook_filter = &tab->hook_filters[hook];
+		hook_filter->filters[hook_filter->nr_filters++] = kset->filter;
+	}
 	return 0;
 end:
 	btf_free_kfunc_set_tab(btf);
@@ -7809,15 +7838,22 @@ static int btf_populate_kfunc_set(struct btf *btf, enum btf_kfunc_hook hook,
 
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
@@ -7870,23 +7906,25 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
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
@@ -7917,7 +7955,8 @@ static int __register_btf_kfunc_id_set(enum btf_kfunc_hook hook,
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
diff --git a/net/core/filter.c b/net/core/filter.c
index 0be10f6556df..efeac5d8f19c 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -11759,9 +11759,18 @@ BTF_SET8_START(bpf_sk_iter_check_kfunc_set)
 BTF_ID_FLAGS(func, bpf_sock_destroy, KF_TRUSTED_ARGS)
 BTF_SET8_END(bpf_sk_iter_check_kfunc_set)
 
+static int tracing_iter_filter(const struct bpf_prog *prog, u32 kfunc_id)
+{
+	if (btf_id_set8_contains(&bpf_sk_iter_check_kfunc_set, kfunc_id) &&
+	    prog->expected_attach_type != BPF_TRACE_ITER)
+		return -EACCES;
+	return 0;
+}
+
 static const struct btf_kfunc_id_set bpf_sk_iter_kfunc_set = {
 	.owner = THIS_MODULE,
 	.set   = &bpf_sk_iter_check_kfunc_set,
+	.filter = tracing_iter_filter,
 };
 
 static int init_subsystem(void)
-- 
2.34.1


