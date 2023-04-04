Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561526D5874
	for <lists+bpf@lfdr.de>; Tue,  4 Apr 2023 08:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbjDDGKO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Apr 2023 02:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233258AbjDDGKO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Apr 2023 02:10:14 -0400
Received: from out-42.mta0.migadu.com (out-42.mta0.migadu.com [IPv6:2001:41d0:1004:224b::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC701BCD
        for <bpf@vger.kernel.org>; Mon,  3 Apr 2023 23:10:10 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1680588607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xns4MF9Tu1/FZqui7JeJktOQnLgAcvzRZR0uMKJaYPc=;
        b=OZgC3awUgTAlcSv/Q8xeRxd39TV68U9N6enqNzTGdf33tv7lQ/jb+CbNUdzNcePKn8Raxj
        C8ori/ElvZFSBMA9tuqTHwUCMSZt+D/7ZqYLMHffL4lIZrJkLweMAlSDPSx4lacQv/2dbD
        uM9LLuqA39zL4FuO2JC6IwlQIkhRt3U=
From:   Martin KaFai Lau <martin.lau@linux.dev>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Aditi Ghag <aditi.ghag@isovalent.com>,
        David Vernet <void@manifault.com>, kernel-team@meta.com
Subject: [RFC PATCH bpf-next] bpf: Add a kfunc filter function to 'struct btf_kfunc_id_set'.
Date:   Mon,  3 Apr 2023 23:09:59 -0700
Message-Id: <20230404060959.2259448-1-martin.lau@linux.dev>
In-Reply-To: <500d452b-f9d5-d01f-d365-2949c4fd37ab@linux.dev>
References: <500d452b-f9d5-d01f-d365-2949c4fd37ab@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Martin KaFai Lau <martin.lau@kernel.org>

This set (https://lore.kernel.org/bpf/https://lore.kernel.org/bpf/500d452b-f9d5-d01f-d365-2949c4fd37ab@linux.dev/)
needs to limit bpf_sock_destroy kfunc to BPF_TRACE_ITER.
In the earlier reply, I thought of adding a BTF_KFUNC_HOOK_TRACING_ITER.

Instead of adding BTF_KFUNC_HOOK_TRACING_ITER, I quickly hacked something
that added a callback filter to 'struct btf_kfunc_id_set'. The filter has
access to the prog such that it can filter by other properties of a prog.
The prog->expected_attached_type is used in the tracing_iter_filter().
It is mostly compiler tested only, so it is still very rough but should
be good enough to show the idea.

would like to hear how others think. It is pretty much the only
piece left for the above mentioned set.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 include/linux/btf.h                           | 18 +++---
 kernel/bpf/btf.c                              | 59 +++++++++++++++----
 kernel/bpf/verifier.c                         |  7 ++-
 net/core/filter.c                             |  9 +++
 .../selftests/bpf/progs/sock_destroy_prog.c   | 10 ++++
 5 files changed, 83 insertions(+), 20 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index d53b10cc55f2..84c31b4f5785 100644
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
index b7e5a5510b91..7685af3ca9c0 100644
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
@@ -7712,9 +7719,12 @@ static int btf_check_kfunc_protos(struct btf *btf, u32 func_id, u32 func_flags)
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
@@ -7729,6 +7739,20 @@ static int btf_populate_kfunc_set(struct btf *btf, enum btf_kfunc_hook hook,
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
@@ -7751,7 +7775,7 @@ static int btf_populate_kfunc_set(struct btf *btf, enum btf_kfunc_hook hook,
 	 */
 	if (!vmlinux_set) {
 		tab->sets[hook] = add_set;
-		return 0;
+		goto do_add_filter;
 	}
 
 	/* In case of vmlinux sets, there may be more than one set being
@@ -7793,6 +7817,11 @@ static int btf_populate_kfunc_set(struct btf *btf, enum btf_kfunc_hook hook,
 
 	sort(set->pairs, set->cnt, sizeof(set->pairs[0]), btf_id_cmp_func, NULL);
 
+do_add_filter:
+	if (add_filter) {
+		hook_filter = &tab->hook_filters[hook];
+		hook_filter->filters[hook_filter->nr_filters++] = kset->filter;
+	}
 	return 0;
 end:
 	btf_free_kfunc_set_tab(btf);
@@ -7801,15 +7830,22 @@ static int btf_populate_kfunc_set(struct btf *btf, enum btf_kfunc_hook hook,
 
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
@@ -7862,23 +7898,25 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
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
@@ -7909,7 +7947,8 @@ static int __register_btf_kfunc_id_set(enum btf_kfunc_hook hook,
 			goto err_out;
 	}
 
-	ret = btf_populate_kfunc_set(btf, hook, kset->set);
+	ret = btf_populate_kfunc_set(btf, hook, kset);
+
 err_out:
 	btf_put(btf);
 	return ret;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 20eb2015842f..1a854cdb2566 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10553,7 +10553,7 @@ static int fetch_kfunc_meta(struct bpf_verifier_env *env,
 		*kfunc_name = func_name;
 	func_proto = btf_type_by_id(desc_btf, func->type);
 
-	kfunc_flags = btf_kfunc_id_set_contains(desc_btf, resolve_prog_type(env->prog), func_id);
+	kfunc_flags = btf_kfunc_id_set_contains(desc_btf, func_id, env->prog);
 	if (!kfunc_flags) {
 		return -EACCES;
 	}
@@ -18521,7 +18521,8 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 				 * in the fmodret id set with the KF_SLEEPABLE flag.
 				 */
 				else {
-					u32 *flags = btf_kfunc_is_modify_return(btf, btf_id);
+					u32 *flags = btf_kfunc_is_modify_return(btf, btf_id,
+										prog);
 
 					if (flags && (*flags & KF_SLEEPABLE))
 						ret = 0;
@@ -18549,7 +18550,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 				return -EINVAL;
 			}
 			ret = -EINVAL;
-			if (btf_kfunc_is_modify_return(btf, btf_id) ||
+			if (btf_kfunc_is_modify_return(btf, btf_id, prog) ||
 			    !check_attach_modify_return(addr, tname))
 				ret = 0;
 			if (ret) {
diff --git a/net/core/filter.c b/net/core/filter.c
index a70c7b9876fa..5e5e6f9baccc 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -11768,9 +11768,18 @@ BTF_SET8_START(sock_destroy_kfunc_set)
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
diff --git a/tools/testing/selftests/bpf/progs/sock_destroy_prog.c b/tools/testing/selftests/bpf/progs/sock_destroy_prog.c
index 5c1e65d50598..5204e44f6ae4 100644
--- a/tools/testing/selftests/bpf/progs/sock_destroy_prog.c
+++ b/tools/testing/selftests/bpf/progs/sock_destroy_prog.c
@@ -3,6 +3,7 @@
 #include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
+#include <bpf/bpf_tracing.h>
 
 #include "bpf_tracing_net.h"
 
@@ -144,4 +145,13 @@ int iter_udp6_server(struct bpf_iter__udp *ctx)
 	return 0;
 }
 
+SEC("tp_btf/tcp_destroy_sock")
+int BPF_PROG(trace_tcp_destroy_sock, struct sock *sk)
+{
+	/* should not load */
+	bpf_sock_destroy((struct sock_common *)sk);
+
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.34.1

