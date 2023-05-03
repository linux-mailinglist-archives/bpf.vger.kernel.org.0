Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06646F619B
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 00:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjECWyO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 May 2023 18:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjECWyK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 May 2023 18:54:10 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14B146A6
        for <bpf@vger.kernel.org>; Wed,  3 May 2023 15:54:07 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1ab01bf474aso29856715ad.1
        for <bpf@vger.kernel.org>; Wed, 03 May 2023 15:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1683154447; x=1685746447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7sG94dNySAdFrxzxkKgsn/Qvw18MkZf4kTSp4kQD6+s=;
        b=CvnszwoyFxeY+GLEFeiaV7VOPgWpuLDTADtKGy/ZMGNPrC9GSnIrtEXqWntj31H7/K
         auwB0PX5g42isYwp4By/5bUuRrsjVgecv/7uPFbR11H2scobgL3/bgguij9kfoqr8XfG
         Z8uzw8rqkgqUh9sawnooV0+trJHfEgDCT9FgiVOJ2Z0pA+yj3KOTBUlSJ/ydL487lJQ8
         GnFTtiUsxrJqHSs1MAqpg0LqkNo188Ig2qQxoK2cQAYz9CNk0a/BCID9Q9wVPm4Sf7o0
         xwmScL3qMakak5UuDpxPXvI7jQGUR1faTRxAjTfkMOqUcAu5LwETVN5yHus1nWCvLbN+
         I0Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683154447; x=1685746447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7sG94dNySAdFrxzxkKgsn/Qvw18MkZf4kTSp4kQD6+s=;
        b=Ln/LGyKxg8vXxtwq0Sf04D1sJ6A3FS1cVcR+UDwK4uWDuz5pHYFTVy4N5nAUW0oZfn
         17Sk0zZhpY9L3845BAaMcl7Ih58xtcFYy7oTfjPKa6PGAwSs28lNdpjHJ+c+EDGKDHya
         J2eOF9bOEaHVRZGtxytvoIM8KNIM40LRCK3rmIroce3t//0XLTfyFC3PDkQh8CKdTpcC
         cjm5iIjemrAC7O36QGAFpeCjMMN0RWPC9/zs0Mr76+zikUq2gGmgFKHU3iyLWzy5XlGh
         Ax3w5wJY7d1NBeul/1QiPj9o4KUAjzZ/l9FXjIpk9c0HQ373L6l3xLLLHDnOtkNp+K10
         xgYg==
X-Gm-Message-State: AC+VfDxB4PTtPC1aHhAs1LH4ebSXcxhW+5lZgifP9TZH9d6CoctFFoDy
        hjS+n/GQsJBuf2ldcrJPgUde93P927Jd1/0y8TY=
X-Google-Smtp-Source: ACHHUZ5G4rXbW+XaTxat5gqK1Rv7+g8Z2YYF4Uldel6zmG+LOwOjtshiiRJBVDh6q6KyWpn1BNc3ew==
X-Received: by 2002:a17:902:aa02:b0:1a0:50bd:31a8 with SMTP id be2-20020a170902aa0200b001a050bd31a8mr1504206plb.26.1683154446788;
        Wed, 03 May 2023 15:54:06 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4611:8100::1])
        by smtp.gmail.com with ESMTPSA id p2-20020a1709028a8200b001a641e4738asm2200443plo.1.2023.05.03.15.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 15:54:06 -0700 (PDT)
From:   Aditi Ghag <aditi.ghag@isovalent.com>
To:     bpf@vger.kernel.org
Cc:     kafai@fb.com, sdf@google.com, aditi.ghag@isovalent.com,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH v7 bpf-next 09/10] bpf: Add a kfunc filter function to 'struct btf_kfunc_id_set'
Date:   Wed,  3 May 2023 22:53:50 +0000
Message-Id: <20230503225351.3700208-10-aditi.ghag@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230503225351.3700208-1-aditi.ghag@isovalent.com>
References: <20230503225351.3700208-1-aditi.ghag@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This commit adds the ability to filter kfuncs to certain BPF program
types, and thereby limits bpf_sock_destroy kfunc to progras with attach
type 'BPF_TRACE_ITER'.
Previous patches introduced 'bpf_sock_destroy kfunc' that can only be
called from BPF (sockets) iterator type programs.  The reason being, the
kfunc requires lock_sock to be done from the BPF context prior to
calling the kfunc.
To that end, the patch adds a callback filter to 'struct
btf_kfunc_id_set'.  The filter has access to the prog construct
including other properties of the prog.  For the bpf_sock_destroy case,
the `expected_attached_type` property of a prog construct is used to
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
index 97d70b7959a1..20c603321325 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -11762,9 +11762,18 @@ BTF_SET8_START(sock_destroy_kfunc_set)
 BTF_ID_FLAGS(func, bpf_sock_destroy)
 BTF_SET8_END(sock_destroy_kfunc_set)
 
+static int tracing_iter_filter(const struct bpf_prog *prog, u32 kfunc_id)
+{
+	if (btf_id_set8_contains(&sock_destroy_kfunc_set, kfunc_id) &&
+	    prog->expected_attach_type != BPF_TRACE_ITER)
+		return -EACCES;
+	return 0;
+}
+
 static const struct btf_kfunc_id_set bpf_sock_destroy_kfunc_set = {
 	.owner = THIS_MODULE,
 	.set   = &sock_destroy_kfunc_set,
+	.filter = tracing_iter_filter,
 };
 
 static int init_subsystem(void)
-- 
2.34.1

