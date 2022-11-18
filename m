Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7BE62EB68
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 02:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240511AbiKRB4p (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 20:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234813AbiKRB4k (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 20:56:40 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FF1898C5
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 17:56:38 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id z26so3555539pff.1
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 17:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j9L6zs2xpO1suLgtnhOh7GRPwwjzCMBBbuIttorBrF4=;
        b=cJ9L1tMCjx0jfTjszReZf7sVMnNte5rnmfnPU3YLWGLkQrsmFihyUZlcNYlmFzFuA9
         C62RccCjCpxXgqR/w9pPu6r1pjGR6ZWxL9hbPOUb/7ph4ekWcF03tRUWAaj0HSqVnzA9
         OGO11NovCwfutkvIIyYyPWNyDxI1MICmmKO3J1QU77AgpHm19T4TwOHnRbbSh0LssHoN
         KLFs2ScYTzk6nFmhd7+4QOXZxD14wep1twu8HJlQ9cPoF0JbuUA786oaL7LXRgttg4cT
         bTC0yq/s5TYzXdvCEnkaupYfQL4E8dVGl0Uj1koMxsE3ZHvi/IGbqhuc8oYPA2KHxfJt
         FDig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j9L6zs2xpO1suLgtnhOh7GRPwwjzCMBBbuIttorBrF4=;
        b=PB/AFPINep6ep2yYvET0NLEEj//JvWHjxh731dS7Pc+dtKLfeLENEP12Fn6U5k3zYr
         YVOcjTKKtQ3X8TjpgdDEH7Eq3J4AFgejIQe+zZ4iAFxR6EKdheTiSVp/OAXWN5RAktQ+
         Pa8/+O49J0X3H5L17VVQR5QN9RM9U9w4DCuJkh7vQtF5NpctvLgtShVFOTHTuENqAKiB
         IvHwJ0bQDwMXXSHYVNzIG7ZEFa39zRZSL3+OngcXRNR6gbkRlc+YcSya7Nsx/0UyUV+Z
         gEydA1YGTz6mFqTujjx3scuelndI2t47lWjVT16ddN1JaQSKX1YP1yKNOGrwm1N8TCs1
         fUNQ==
X-Gm-Message-State: ANoB5plQ07ml52yui6Yj/YafPdRd6h7MmzcePuf1eKuglzC9O4gDvndK
        XJLP1QR8EcW5KzGJv/CIn1VqyUGn42o=
X-Google-Smtp-Source: AA0mqf5c8SoPBSJzuNY26pMbnAJ4OXcYxhKEhLOVqTL7lgde3HuT7N45eaifhdPF0L7x2efHw+McMw==
X-Received: by 2002:a62:1b4a:0:b0:573:20a7:d with SMTP id b71-20020a621b4a000000b0057320a7000dmr1683730pfb.65.1668736597428;
        Thu, 17 Nov 2022 17:56:37 -0800 (PST)
Received: from localhost ([2409:40f4:8:955c:5484:8048:c08:7b3])
        by smtp.gmail.com with ESMTPSA id p11-20020a631e4b000000b0046f469a2661sm1724743pgm.27.2022.11.17.17.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 17:56:37 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v10 06/24] bpf: Recognize lock and list fields in allocated objects
Date:   Fri, 18 Nov 2022 07:25:56 +0530
Message-Id: <20221118015614.2013203-7-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118015614.2013203-1-memxor@gmail.com>
References: <20221118015614.2013203-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14956; i=memxor@gmail.com; h=from:subject; bh=3j2kADy8heWKgTV7xRad/hiMYH5DbNhm6oQjBwn/jpI=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjduXOI63biJWxTmyvbx6QN1RUAq2GuvFQUs3aOG+B bcI7IfGJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3blzgAKCRBM4MiGSL8RylwcEA CAB+v091upD2cJB7Y4Qd7QA5B/TU4f3HafJ7q66XroUE5yerzh4/UH0r9g9rdVVojyOkE+SLa2nOy+ Zt/5T5+hCuOtwp7ghm2iLcrlTXwleLBTv8C1gR50X4y3pDLuDdTj39vac6oVKyBaHa/YGlhYKb1Q0o SmSQo7GRGtAfiSKMPczMaMecUm3kGl31SsgaG5rrfqXHnEJ1/lINcbw487PKUcCEVPROQt1Xoht9Si vN9UlGtkvLiHlS2URJS5d55bbGs26nNuOfMs41bYCn800XSmZf60HqTlfbT79yCSL2HeW2LVgiXulg lyqzqKX0GT/+ZMkLzUijeTvTVl1AYKsnZWhlWHO/GhIpA6EC9N2flHIqF0Ebwi9tIgzNbosIpw+2hp r/XP2SP8+TZNWqgr1iLqdeXqsxdEutDweKSJGGpPBBf4uj8/74PJcy+Z4rhTRfy9NuzCgjVdNMB2lK 5rqUgkQvq6vV58UWJ/KYSpBHnF/YdCRGQ473zGm6B44upN5pvs+PIL/mfI2/qLJjtbFQ3uBzXkllu9 /dRjuL9Ppyn9rhf6Lk2Fw+Yb5RxpK71fiSh7y1dSKgD4o6cQ9pAgLfXxcDB7HYKvMR1yKTG9j5ZpDX PfK33xWDPLoJe5t9lU9aZ8MdIbqLhAKd+3ZicuGf52L5kBeeaFvV6SYMyUyg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Allow specifying bpf_spin_lock, bpf_list_head, bpf_list_node fields in a
allocated object.

Also update btf_struct_access to reject direct access to these special
fields.

A bpf_list_head allows implementing map-in-map style use cases, where an
allocated object with bpf_list_head is linked into a list in a map
value. This would require embedding a bpf_list_node, support for which
is also included. The bpf_spin_lock is used to protect the bpf_list_head
and other data.

While we strictly don't require to hold a bpf_spin_lock while touching
the bpf_list_head in such objects, as when have access to it, we have
complete ownership of the object, the locking constraint is still kept
and may be conditionally lifted in the future.

Note that the specification of such types can be done just like map
values, e.g.:

struct bar {
	struct bpf_list_node node;
};

struct foo {
	struct bpf_spin_lock lock;
	struct bpf_list_head head __contains(bar, node);
	struct bpf_list_node node;
};

struct map_value {
	struct bpf_spin_lock lock;
	struct bpf_list_head head __contains(foo, node);
};

To recognize such types in user BTF, we build a btf_struct_metas array
of metadata items corresponding to each BTF ID. This is done once during
the btf_parse stage to avoid having to do it each time during the
verification process's requirement to inspect the metadata.

Moreover, the computed metadata needs to be passed to some helpers in
future patches which requires allocating them and storing them in the
BTF that is pinned by the program itself, so that valid access can be
assumed to such data during program runtime.

A key thing to note is that once a btf_struct_meta is available for a
type, both the btf_record and btf_field_offs should be available. It is
critical that btf_field_offs is available in case special fields are
present, as we extensively rely on special fields being zeroed out in
map values and allocated objects in later patches. The code ensures that
by bailing out in case of errors and ensuring both are available
together. If the record is not available, the special fields won't be
recognized, so not having both is also fine (in terms of being a
verification error and not a runtime bug).

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h  |   7 ++
 include/linux/btf.h  |  35 ++++++++
 kernel/bpf/btf.c     | 197 +++++++++++++++++++++++++++++++++++++++----
 kernel/bpf/syscall.c |   4 +
 4 files changed, 225 insertions(+), 18 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 7440c20c4192..eb6ea53fa5a2 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -177,6 +177,7 @@ enum btf_field_type {
 	BPF_KPTR_REF   = (1 << 3),
 	BPF_KPTR       = BPF_KPTR_UNREF | BPF_KPTR_REF,
 	BPF_LIST_HEAD  = (1 << 4),
+	BPF_LIST_NODE  = (1 << 5),
 };
 
 struct btf_field_kptr {
@@ -277,6 +278,8 @@ static inline const char *btf_field_type_name(enum btf_field_type type)
 		return "kptr";
 	case BPF_LIST_HEAD:
 		return "bpf_list_head";
+	case BPF_LIST_NODE:
+		return "bpf_list_node";
 	default:
 		WARN_ON_ONCE(1);
 		return "unknown";
@@ -295,6 +298,8 @@ static inline u32 btf_field_type_size(enum btf_field_type type)
 		return sizeof(u64);
 	case BPF_LIST_HEAD:
 		return sizeof(struct bpf_list_head);
+	case BPF_LIST_NODE:
+		return sizeof(struct bpf_list_node);
 	default:
 		WARN_ON_ONCE(1);
 		return 0;
@@ -313,6 +318,8 @@ static inline u32 btf_field_type_align(enum btf_field_type type)
 		return __alignof__(u64);
 	case BPF_LIST_HEAD:
 		return __alignof__(struct bpf_list_head);
+	case BPF_LIST_NODE:
+		return __alignof__(struct bpf_list_node);
 	default:
 		WARN_ON_ONCE(1);
 		return 0;
diff --git a/include/linux/btf.h b/include/linux/btf.h
index d80345fa566b..a01a8da20021 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -6,6 +6,8 @@
 
 #include <linux/types.h>
 #include <linux/bpfptr.h>
+#include <linux/bsearch.h>
+#include <linux/btf_ids.h>
 #include <uapi/linux/btf.h>
 #include <uapi/linux/bpf.h>
 
@@ -78,6 +80,17 @@ struct btf_id_dtor_kfunc {
 	u32 kfunc_btf_id;
 };
 
+struct btf_struct_meta {
+	u32 btf_id;
+	struct btf_record *record;
+	struct btf_field_offs *field_offs;
+};
+
+struct btf_struct_metas {
+	u32 cnt;
+	struct btf_struct_meta types[];
+};
+
 typedef void (*btf_dtor_kfunc_t)(void *);
 
 extern const struct file_operations btf_fops;
@@ -408,6 +421,23 @@ static inline struct btf_param *btf_params(const struct btf_type *t)
 	return (struct btf_param *)(t + 1);
 }
 
+static inline int btf_id_cmp_func(const void *a, const void *b)
+{
+	const int *pa = a, *pb = b;
+
+	return *pa - *pb;
+}
+
+static inline bool btf_id_set_contains(const struct btf_id_set *set, u32 id)
+{
+	return bsearch(&id, set->ids, set->cnt, sizeof(u32), btf_id_cmp_func) != NULL;
+}
+
+static inline void *btf_id_set8_contains(const struct btf_id_set8 *set, u32 id)
+{
+	return bsearch(&id, set->pairs, set->cnt, sizeof(set->pairs[0]), btf_id_cmp_func);
+}
+
 #ifdef CONFIG_BPF_SYSCALL
 struct bpf_prog;
 
@@ -423,6 +453,7 @@ int register_btf_kfunc_id_set(enum bpf_prog_type prog_type,
 s32 btf_find_dtor_kfunc(struct btf *btf, u32 btf_id);
 int register_btf_id_dtor_kfuncs(const struct btf_id_dtor_kfunc *dtors, u32 add_cnt,
 				struct module *owner);
+struct btf_struct_meta *btf_find_struct_meta(const struct btf *btf, u32 btf_id);
 #else
 static inline const struct btf_type *btf_type_by_id(const struct btf *btf,
 						    u32 type_id)
@@ -454,6 +485,10 @@ static inline int register_btf_id_dtor_kfuncs(const struct btf_id_dtor_kfunc *dt
 {
 	return 0;
 }
+static inline struct btf_struct_meta *btf_find_struct_meta(const struct btf *btf, u32 btf_id)
+{
+	return NULL;
+}
 #endif
 
 static inline bool btf_type_is_struct_ptr(struct btf *btf, const struct btf_type *t)
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 9a596f430558..a04e10477567 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -237,6 +237,7 @@ struct btf {
 	struct rcu_head rcu;
 	struct btf_kfunc_set_tab *kfunc_set_tab;
 	struct btf_id_dtor_kfunc_tab *dtor_kfunc_tab;
+	struct btf_struct_metas *struct_meta_tab;
 
 	/* split BTF support */
 	struct btf *base_btf;
@@ -1642,8 +1643,30 @@ static void btf_free_dtor_kfunc_tab(struct btf *btf)
 	btf->dtor_kfunc_tab = NULL;
 }
 
+static void btf_struct_metas_free(struct btf_struct_metas *tab)
+{
+	int i;
+
+	if (!tab)
+		return;
+	for (i = 0; i < tab->cnt; i++) {
+		btf_record_free(tab->types[i].record);
+		kfree(tab->types[i].field_offs);
+	}
+	kfree(tab);
+}
+
+static void btf_free_struct_meta_tab(struct btf *btf)
+{
+	struct btf_struct_metas *tab = btf->struct_meta_tab;
+
+	btf_struct_metas_free(tab);
+	btf->struct_meta_tab = NULL;
+}
+
 static void btf_free(struct btf *btf)
 {
+	btf_free_struct_meta_tab(btf);
 	btf_free_dtor_kfunc_tab(btf);
 	btf_free_kfunc_set_tab(btf);
 	kvfree(btf->types);
@@ -3353,6 +3376,12 @@ static int btf_get_field_type(const char *name, u32 field_mask, u32 *seen_mask,
 			goto end;
 		}
 	}
+	if (field_mask & BPF_LIST_NODE) {
+		if (!strcmp(name, "bpf_list_node")) {
+			type = BPF_LIST_NODE;
+			goto end;
+		}
+	}
 	/* Only return BPF_KPTR when all other types with matchable names fail */
 	if (field_mask & BPF_KPTR) {
 		type = BPF_KPTR_REF;
@@ -3396,6 +3425,7 @@ static int btf_find_struct_field(const struct btf *btf,
 		switch (field_type) {
 		case BPF_SPIN_LOCK:
 		case BPF_TIMER:
+		case BPF_LIST_NODE:
 			ret = btf_find_struct(btf, member_type, off, sz, field_type,
 					      idx < info_cnt ? &info[idx] : &tmp);
 			if (ret < 0)
@@ -3456,6 +3486,7 @@ static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
 		switch (field_type) {
 		case BPF_SPIN_LOCK:
 		case BPF_TIMER:
+		case BPF_LIST_NODE:
 			ret = btf_find_struct(btf, var_type, off, sz, field_type,
 					      idx < info_cnt ? &info[idx] : &tmp);
 			if (ret < 0)
@@ -3671,6 +3702,8 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
 			if (ret < 0)
 				goto end;
 			break;
+		case BPF_LIST_NODE:
+			break;
 		default:
 			ret = -EFAULT;
 			goto end;
@@ -5141,6 +5174,119 @@ static int btf_parse_hdr(struct btf_verifier_env *env)
 	return btf_check_sec_info(env, btf_data_size);
 }
 
+static const char *alloc_obj_fields[] = {
+	"bpf_spin_lock",
+	"bpf_list_head",
+	"bpf_list_node",
+};
+
+static struct btf_struct_metas *
+btf_parse_struct_metas(struct bpf_verifier_log *log, struct btf *btf)
+{
+	union {
+		struct btf_id_set set;
+		struct {
+			u32 _cnt;
+			u32 _ids[ARRAY_SIZE(alloc_obj_fields)];
+		} _arr;
+	} aof;
+	struct btf_struct_metas *tab = NULL;
+	int i, n, id, ret;
+
+	BUILD_BUG_ON(offsetof(struct btf_id_set, cnt) != 0);
+	BUILD_BUG_ON(sizeof(struct btf_id_set) != sizeof(u32));
+
+	memset(&aof, 0, sizeof(aof));
+	for (i = 0; i < ARRAY_SIZE(alloc_obj_fields); i++) {
+		/* Try to find whether this special type exists in user BTF, and
+		 * if so remember its ID so we can easily find it among members
+		 * of structs that we iterate in the next loop.
+		 */
+		id = btf_find_by_name_kind(btf, alloc_obj_fields[i], BTF_KIND_STRUCT);
+		if (id < 0)
+			continue;
+		aof.set.ids[aof.set.cnt++] = id;
+	}
+
+	if (!aof.set.cnt)
+		return NULL;
+	sort(&aof.set.ids, aof.set.cnt, sizeof(aof.set.ids[0]), btf_id_cmp_func, NULL);
+
+	n = btf_nr_types(btf);
+	for (i = 1; i < n; i++) {
+		struct btf_struct_metas *new_tab;
+		const struct btf_member *member;
+		struct btf_field_offs *foffs;
+		struct btf_struct_meta *type;
+		struct btf_record *record;
+		const struct btf_type *t;
+		int j, tab_cnt;
+
+		t = btf_type_by_id(btf, i);
+		if (!t) {
+			ret = -EINVAL;
+			goto free;
+		}
+		if (!__btf_type_is_struct(t))
+			continue;
+
+		cond_resched();
+
+		for_each_member(j, t, member) {
+			if (btf_id_set_contains(&aof.set, member->type))
+				goto parse;
+		}
+		continue;
+	parse:
+		tab_cnt = tab ? tab->cnt : 0;
+		new_tab = krealloc(tab, offsetof(struct btf_struct_metas, types[tab_cnt + 1]),
+				   GFP_KERNEL | __GFP_NOWARN);
+		if (!new_tab) {
+			ret = -ENOMEM;
+			goto free;
+		}
+		if (!tab)
+			new_tab->cnt = 0;
+		tab = new_tab;
+
+		type = &tab->types[tab->cnt];
+		type->btf_id = i;
+		record = btf_parse_fields(btf, t, BPF_SPIN_LOCK | BPF_LIST_HEAD | BPF_LIST_NODE, t->size);
+		/* The record cannot be unset, treat it as an error if so */
+		if (IS_ERR_OR_NULL(record)) {
+			ret = PTR_ERR_OR_ZERO(record) ?: -EFAULT;
+			goto free;
+		}
+		foffs = btf_parse_field_offs(record);
+		/* We need the field_offs to be valid for a valid record,
+		 * either both should be set or both should be unset.
+		 */
+		if (IS_ERR_OR_NULL(foffs)) {
+			btf_record_free(record);
+			ret = -EFAULT;
+			goto free;
+		}
+		type->record = record;
+		type->field_offs = foffs;
+		tab->cnt++;
+	}
+	return tab;
+free:
+	btf_struct_metas_free(tab);
+	return ERR_PTR(ret);
+}
+
+struct btf_struct_meta *btf_find_struct_meta(const struct btf *btf, u32 btf_id)
+{
+	struct btf_struct_metas *tab;
+
+	BUILD_BUG_ON(offsetof(struct btf_struct_meta, btf_id) != 0);
+	tab = btf->struct_meta_tab;
+	if (!tab)
+		return NULL;
+	return bsearch(&btf_id, tab->types, tab->cnt, sizeof(tab->types[0]), btf_id_cmp_func);
+}
+
 static int btf_check_type_tags(struct btf_verifier_env *env,
 			       struct btf *btf, int start_id)
 {
@@ -5191,6 +5337,7 @@ static int btf_check_type_tags(struct btf_verifier_env *env,
 static struct btf *btf_parse(bpfptr_t btf_data, u32 btf_data_size,
 			     u32 log_level, char __user *log_ubuf, u32 log_size)
 {
+	struct btf_struct_metas *struct_meta_tab;
 	struct btf_verifier_env *env = NULL;
 	struct bpf_verifier_log *log;
 	struct btf *btf = NULL;
@@ -5259,15 +5406,24 @@ static struct btf *btf_parse(bpfptr_t btf_data, u32 btf_data_size,
 	if (err)
 		goto errout;
 
+	struct_meta_tab = btf_parse_struct_metas(log, btf);
+	if (IS_ERR(struct_meta_tab)) {
+		err = PTR_ERR(struct_meta_tab);
+		goto errout;
+	}
+	btf->struct_meta_tab = struct_meta_tab;
+
 	if (log->level && bpf_verifier_log_full(log)) {
 		err = -ENOSPC;
-		goto errout;
+		goto errout_meta;
 	}
 
 	btf_verifier_env_free(env);
 	refcount_set(&btf->refcnt, 1);
 	return btf;
 
+errout_meta:
+	btf_free_struct_meta_tab(btf);
 errout:
 	btf_verifier_env_free(env);
 	if (btf)
@@ -6028,6 +6184,28 @@ int btf_struct_access(struct bpf_verifier_log *log,
 	u32 id = reg->btf_id;
 	int err;
 
+	while (type_is_alloc(reg->type)) {
+		struct btf_struct_meta *meta;
+		struct btf_record *rec;
+		int i;
+
+		meta = btf_find_struct_meta(btf, id);
+		if (!meta)
+			break;
+		rec = meta->record;
+		for (i = 0; i < rec->cnt; i++) {
+			struct btf_field *field = &rec->fields[i];
+			u32 offset = field->offset;
+			if (off < offset + btf_field_type_size(field->type) && offset < off + size) {
+				bpf_log(log,
+					"direct access to %s is disallowed\n",
+					btf_field_type_name(field->type));
+				return -EACCES;
+			}
+		}
+		break;
+	}
+
 	t = btf_type_by_id(btf, id);
 	do {
 		err = btf_struct_walk(log, btf, t, off, size, &id, &tmp_flag);
@@ -7269,23 +7447,6 @@ bool btf_is_module(const struct btf *btf)
 	return btf->kernel_btf && strcmp(btf->name, "vmlinux") != 0;
 }
 
-static int btf_id_cmp_func(const void *a, const void *b)
-{
-	const int *pa = a, *pb = b;
-
-	return *pa - *pb;
-}
-
-bool btf_id_set_contains(const struct btf_id_set *set, u32 id)
-{
-	return bsearch(&id, set->ids, set->cnt, sizeof(u32), btf_id_cmp_func) != NULL;
-}
-
-static void *btf_id_set8_contains(const struct btf_id_set8 *set, u32 id)
-{
-	return bsearch(&id, set->pairs, set->cnt, sizeof(set->pairs[0]), btf_id_cmp_func);
-}
-
 enum {
 	BTF_MODULE_F_LIVE = (1 << 0),
 };
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 4c20dcbc6526..56ae97d490f4 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -537,6 +537,7 @@ void btf_record_free(struct btf_record *rec)
 			btf_put(rec->fields[i].kptr.btf);
 			break;
 		case BPF_LIST_HEAD:
+		case BPF_LIST_NODE:
 			/* Nothing to release for bpf_list_head */
 			break;
 		default:
@@ -582,6 +583,7 @@ struct btf_record *btf_record_dup(const struct btf_record *rec)
 			}
 			break;
 		case BPF_LIST_HEAD:
+		case BPF_LIST_NODE:
 			/* Nothing to acquire for bpf_list_head */
 			break;
 		default:
@@ -648,6 +650,8 @@ void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
 				continue;
 			bpf_list_head_free(field, field_ptr, obj + rec->spin_lock_off);
 			break;
+		case BPF_LIST_NODE:
+			break;
 		default:
 			WARN_ON_ONCE(1);
 			continue;
-- 
2.38.1

