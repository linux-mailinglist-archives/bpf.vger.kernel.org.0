Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF7B5FAA08
	for <lists+bpf@lfdr.de>; Tue, 11 Oct 2022 03:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiJKBZp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Oct 2022 21:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiJKBZJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Oct 2022 21:25:09 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D1F17E1F
        for <bpf@vger.kernel.org>; Mon, 10 Oct 2022 18:24:56 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id l4so11833830plb.8
        for <bpf@vger.kernel.org>; Mon, 10 Oct 2022 18:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sAA67wPLL5acgmYCAH5LhLPymmUZbXzroH3jRlMqXyc=;
        b=CUFpbBUfH9t+RHnbS1HPvZZ1aWCyLXiM1ej6aOGkamz3faoPQ6dxF/D8E7F/86oKJC
         uYprB5wv9enB2E455S/6mTo4g3pgrZoDZSGimR6mnjfQpMAQ+MXm+2lrX70DECzDRucV
         1Lizn3rHviwMPA7T8IEiRWRq3iDEt99MV4tQB5lY1EQ87DV3JbTCNXYMuFW28j9tQhes
         x/DauDVj3HLYOR0g+sZV8YUyDEN/ucEWdc6PwQhcnrYOxH4ovaTJeevIEH7+SM742Vvg
         uj85DD6GDZpIEn6cUTg0D6k7wqp0fuTOnFsi7Na1NoqvZv+fHOZ0YR75ZxrizEp5+V2b
         KIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sAA67wPLL5acgmYCAH5LhLPymmUZbXzroH3jRlMqXyc=;
        b=FBbsCdlArdRoNNoApoexLBS1MUikDqQSzuSIPKl8X+PIxx7BgfqXDUN8FBCPNwL1UJ
         3X+zTGQ4vylndOeVAvU3bvmftu/uJhFcf7TIVjbO4tiUU1OJOAO4VMQkkz/Fpkd7B5ZJ
         GyFOyX30Vuh2Ui6aQWAD/xti/hcglHYJDheKIBxqvFKaASMycqvPfTt9yxxTL9Po6GeQ
         UlXl7st/4tygRJEuH9z7rzN+4GL3J3+D6SHD/moZNvq/KEgNp+SPFSCKZ9N/ZJWXFMj7
         aCfbOO0iTtE4EmjglGO4wlBvpWjGvRXkce6+mofJq5FNRL09ZoNczH/QUgsS0bThKf46
         6cdQ==
X-Gm-Message-State: ACrzQf1wHVEdCspdBfcfDm6ARdIb4nzaFKSEPzfbU0EvY5oAde4mEbe5
        F8yu1HppcioHrn7qgKmVTdR27OEFesHP6w==
X-Google-Smtp-Source: AMsMyM56jqOw1iTYAZeByyM1bgd4nzSH1aiVyQcVe2JASOVhM/B16woCignAk6plH8o0cqg5lp4p4Q==
X-Received: by 2002:a17:90b:3b8b:b0:20d:4fd9:9a0f with SMTP id pc11-20020a17090b3b8b00b0020d4fd99a0fmr5691091pjb.17.1665451495465;
        Mon, 10 Oct 2022 18:24:55 -0700 (PDT)
Received: from localhost ([103.4.221.252])
        by smtp.gmail.com with ESMTPSA id a10-20020a170902900a00b0017849a2b56asm7261843plp.46.2022.10.10.18.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 18:24:55 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Subject: [PATCH bpf-next v1 11/25] bpf: Recognize bpf_{spin_lock,list_head,list_node} in local kptrs
Date:   Tue, 11 Oct 2022 06:52:26 +0530
Message-Id: <20221011012240.3149-12-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221011012240.3149-1-memxor@gmail.com>
References: <20221011012240.3149-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14060; i=memxor@gmail.com; h=from:subject; bh=FdT78iISCWEBCchTQH1QdDDRBjIEr9+ZUVJoQGhyYRA=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjRMUayLxO7GQR15nPPutLx3K0IoBAHQQqo3kpNubQ RAAj3yeJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY0TFGgAKCRBM4MiGSL8RykciEA CkAFV+PPOLtL6mx14J5NTGtW9AeScZbF1pIf0TUifqudrPceDPXHF81hdCAzFE45+JGIs7CWsoEza2 IYP8/zmlwfJ4HaUbrjsyl2o2iYwG9tXHXIbGbbF6sd6RBL7XYPo+WGFP+9F2t38JIVBowqlUg9XfXQ 2dfhcrGYlcHVPkXuWjG9B2VsiuFURxGkUFQS2Oq+B3391y8+Dn73Hi+BARLj4BnRHfxE4vZ48hqLjc CYGiLSRZJmAXufcHSye1kMmGB2aLq9z525WloVgGC5Gf0FtOS9kH1NdRFlSy9kHbxWAzlC44ecg/Gl r1byWYFgolHbTyqyQHUoVlmA6ccWCyAOPwPGtsm3UT3tHy1BQRbGwywrbxWKLXVm4gN5PtyD67ZZGb fViScoA0dwBg0rl06eqkwLS+oU8U8gTq8J0pg+QP/Ks3KvvC/mlawerAws9mvtie0WM9S3w6ZpViPP gRuK3Mb9G5kKPzI6aQmVkAwh1dEEq4ZEOSDs/nDvnHPoQikSbQr5Cciv+WX6uuywRK26IwPgR0gxAK vbuCFG4bD4bdDnyY2odqWleJa47NQIKQemaVltsZjlyFrl0JAPSG4l+0QKsiHmGyMQg3dEeIjSwM5Q HqweugaAJMXhAZBefZSYMwb0egMC11abPE/mj1KvHH47UR7C3XJEDASwdiHQ==
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
local kptr.

A bpf_list_head allows implementing map-in-map style use cases, where
local kptr with bpf_list_head is linked into a list in a map value. This
would require embedding a bpf_list_node, support for which is also
included.

Lastly, while we strictly don't require to hold a bpf_spin_lock while
manipulating the bpf_list_head of a local kptr, as when have access to
it, we have complete ownership of the object, the locking constraint is
still kept and may be conditionally lifted in the future.

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

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h  |   7 ++
 include/linux/btf.h  |  35 ++++++++
 kernel/bpf/btf.c     | 196 +++++++++++++++++++++++++++++++++++++++----
 kernel/bpf/syscall.c |   4 +
 4 files changed, 224 insertions(+), 18 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a2f4d3356cc8..76548a9d57db 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -178,6 +178,7 @@ enum btf_field_type {
 	BPF_KPTR_REF   = (1 << 3),
 	BPF_KPTR       = BPF_KPTR_UNREF | BPF_KPTR_REF,
 	BPF_LIST_HEAD  = (1 << 4),
+	BPF_LIST_NODE  = (1 << 5),
 };
 
 struct btf_field_kptr {
@@ -278,6 +279,8 @@ static inline const char *btf_field_type_name(enum btf_field_type type)
 		return "kptr";
 	case BPF_LIST_HEAD:
 		return "bpf_list_head";
+	case BPF_LIST_NODE:
+		return "bpf_list_node";
 	default:
 		WARN_ON_ONCE(1);
 		return "unknown";
@@ -296,6 +299,8 @@ static inline u32 btf_field_type_size(enum btf_field_type type)
 		return sizeof(u64);
 	case BPF_LIST_HEAD:
 		return sizeof(struct bpf_list_head);
+	case BPF_LIST_NODE:
+		return sizeof(struct bpf_list_node);
 	default:
 		WARN_ON_ONCE(1);
 		return 0;
@@ -314,6 +319,8 @@ static inline u32 btf_field_type_align(enum btf_field_type type)
 		return __alignof__(u64);
 	case BPF_LIST_HEAD:
 		return __alignof__(struct bpf_list_head);
+	case BPF_LIST_NODE:
+		return __alignof__(struct bpf_list_node);
 	default:
 		WARN_ON_ONCE(1);
 		return 0;
diff --git a/include/linux/btf.h b/include/linux/btf.h
index 609809017ea1..b63c88de3135 100644
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
+	struct btf_type_fields *fields_tab;
+	struct btf_type_fields_off *off_arr;
+};
+
+struct btf_struct_metas {
+	u32 cnt;
+	struct btf_struct_meta types[];
+};
+
 typedef void (*btf_dtor_kfunc_t)(void *);
 
 extern const struct file_operations btf_fops;
@@ -409,6 +422,23 @@ static inline struct btf_param *btf_params(const struct btf_type *t)
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
 
@@ -424,6 +454,7 @@ int register_btf_kfunc_id_set(enum bpf_prog_type prog_type,
 s32 btf_find_dtor_kfunc(struct btf *btf, u32 btf_id);
 int register_btf_id_dtor_kfuncs(const struct btf_id_dtor_kfunc *dtors, u32 add_cnt,
 				struct module *owner);
+struct btf_struct_meta *btf_find_struct_meta(const struct btf *btf, u32 btf_id);
 #else
 static inline const struct btf_type *btf_type_by_id(const struct btf *btf,
 						    u32 type_id)
@@ -455,6 +486,10 @@ static inline int register_btf_id_dtor_kfuncs(const struct btf_id_dtor_kfunc *dt
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
index 526702a264b8..d6aeb0a4d4b7 100644
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
+		btf_type_fields_free(tab->types[i].fields_tab);
+		kfree(tab->types[i].off_arr);
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
@@ -3359,6 +3382,12 @@ static int btf_get_field_type(const char *name, u32 field_mask, u32 *seen_mask,
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
@@ -3404,6 +3433,7 @@ static int btf_find_struct_field(const struct btf *btf,
 		switch (field_type) {
 		case BPF_SPIN_LOCK:
 		case BPF_TIMER:
+		case BPF_LIST_NODE:
 			ret = btf_find_struct(btf, member_type, off, sz, field_type,
 					      idx < info_cnt ? &info[idx] : &tmp);
 			if (ret < 0)
@@ -3466,6 +3496,7 @@ static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
 		switch (field_type) {
 		case BPF_SPIN_LOCK:
 		case BPF_TIMER:
+		case BPF_LIST_NODE:
 			ret = btf_find_struct(btf, var_type, off, sz, field_type,
 					      idx < info_cnt ? &info[idx] : &tmp);
 			if (ret < 0)
@@ -3676,6 +3707,8 @@ struct btf_type_fields *btf_parse_fields(const struct btf *btf,
 			if (ret < 0)
 				goto end;
 			break;
+		case BPF_LIST_NODE:
+			break;
 		default:
 			ret = -EFAULT;
 			goto end;
@@ -5143,6 +5176,118 @@ static int btf_parse_hdr(struct btf_verifier_env *env)
 	return btf_check_sec_info(env, btf_data_size);
 }
 
+static const char *local_kptr_fields[] = {
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
+			u32 _ids[ARRAY_SIZE(local_kptr_fields)];
+		} _arr;
+	} lkf;
+	struct btf_struct_metas *tab = NULL;
+	int i, n, id, ret;
+
+	memset(&lkf, 0, sizeof(lkf));
+
+	for (i = 0; i < ARRAY_SIZE(local_kptr_fields); i++) {
+		/* Try to find whether this special type exists in user BTF, and
+		 * if so remember its ID so we can easily find it among members
+		 * of structs that we iterate in the next loop.
+		 */
+		id = btf_find_by_name_kind(btf, local_kptr_fields[i], BTF_KIND_STRUCT);
+		if (id < 0)
+			continue;
+		lkf.set.ids[lkf.set.cnt++] = id;
+	}
+
+	if (!lkf.set.cnt)
+		return NULL;
+	sort(&lkf.set.ids, lkf.set.cnt, sizeof(lkf.set.ids[0]), btf_id_cmp_func, NULL);
+
+	n = btf_nr_types(btf);
+	for (i = 1; i < n; i++) {
+		struct btf_type_fields_off *off_arr;
+		struct btf_type_fields *fields_tab;
+		const struct btf_member *member;
+		struct btf_struct_meta *type;
+		const struct btf_type *t;
+		int j;
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
+			if (btf_id_set_contains(&lkf.set, member->type))
+				goto parse;
+		}
+		continue;
+	parse:
+		if (!tab) {
+			tab = kzalloc(offsetof(struct btf_struct_metas, types[1]),
+				      GFP_KERNEL | __GFP_NOWARN);
+			if (!tab)
+				return ERR_PTR(-ENOMEM);
+		} else {
+			struct btf_struct_metas *new_tab;
+
+			new_tab = krealloc(tab, offsetof(struct btf_struct_metas, types[tab->cnt + 1]),
+					   GFP_KERNEL | __GFP_NOWARN);
+			if (!new_tab) {
+				ret = -ENOMEM;
+				goto free;
+			}
+			tab = new_tab;
+		}
+		type = &tab->types[tab->cnt];
+
+		type->btf_id = i;
+		fields_tab = btf_parse_fields(btf, t, BPF_SPIN_LOCK | BPF_LIST_HEAD | BPF_LIST_NODE, t->size);
+		if (IS_ERR_OR_NULL(fields_tab)) {
+			ret = PTR_ERR_OR_ZERO(fields_tab) ?: -EFAULT;
+			goto free;
+		}
+		off_arr = btf_parse_fields_off(fields_tab);
+		if (WARN_ON_ONCE(IS_ERR_OR_NULL(off_arr))) {
+			btf_type_fields_free(fields_tab);
+			ret = -EFAULT;
+			goto free;
+		}
+		type->fields_tab = fields_tab;
+		type->off_arr = off_arr;
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
@@ -5193,6 +5338,7 @@ static int btf_check_type_tags(struct btf_verifier_env *env,
 static struct btf *btf_parse(bpfptr_t btf_data, u32 btf_data_size,
 			     u32 log_level, char __user *log_ubuf, u32 log_size)
 {
+	struct btf_struct_metas *struct_meta_tab;
 	struct btf_verifier_env *env = NULL;
 	struct bpf_verifier_log *log;
 	struct btf *btf = NULL;
@@ -5261,15 +5407,24 @@ static struct btf *btf_parse(bpfptr_t btf_data, u32 btf_data_size,
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
@@ -6030,6 +6185,28 @@ int btf_struct_access(struct bpf_verifier_log *log,
 	int err;
 	u32 id;
 
+	while (local_type) {
+		struct btf_struct_meta *meta;
+		struct btf_type_fields *tab;
+		int i;
+
+		meta = btf_find_struct_meta(btf, reg->btf_id);
+		if (!meta)
+			break;
+		tab = meta->fields_tab;
+		for (i = 0; i < tab->cnt; i++) {
+			struct btf_field *field = &tab->fields[i];
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
 	do {
 		err = btf_struct_walk(log, btf, t, off, size, &id, &tmp_flag);
 
@@ -7270,23 +7447,6 @@ bool btf_is_module(const struct btf *btf)
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
index 92486d777246..c60bf641301d 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -537,6 +537,7 @@ void btf_type_fields_free(struct btf_type_fields *tab)
 			btf_put(tab->fields[i].kptr.btf);
 			break;
 		case BPF_LIST_HEAD:
+		case BPF_LIST_NODE:
 			/* Nothing to release for bpf_list_head */
 			break;
 		default:
@@ -582,6 +583,7 @@ struct btf_type_fields *btf_type_fields_dup(const struct btf_type_fields *tab)
 			}
 			break;
 		case BPF_LIST_HEAD:
+		case BPF_LIST_NODE:
 			/* Nothing to acquire for bpf_list_head */
 			break;
 		default:
@@ -648,6 +650,8 @@ void bpf_obj_free_fields(const struct btf_type_fields *tab, void *obj)
 				continue;
 			bpf_list_head_free(field, field_ptr, obj + tab->spin_lock_off);
 			break;
+		case BPF_LIST_NODE:
+			break;
 		default:
 			WARN_ON_ONCE(1);
 			continue;
-- 
2.34.1

