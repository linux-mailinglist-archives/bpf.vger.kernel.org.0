Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012B162035C
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 00:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbiKGXKY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 18:10:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232448AbiKGXKW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 18:10:22 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E835323164
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 15:10:20 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id y13so12196463pfp.7
        for <bpf@vger.kernel.org>; Mon, 07 Nov 2022 15:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XUm3eU1Buz+0ts0Dif5SZ61dZ8dUqnINfHNkZQXYpU8=;
        b=qu8lonhYtyC/zECoKYCfYf1uBhPW7zdUbHIi86jGYWEfLsHrclSpnZq42FL3A8iYw2
         mxjTFtUf0egqIWbCy2yY5tpguYoBXnZrfb7XhJg/X5dSo6NIv3qiV14egzQrzo/PvEiG
         b1ou+aJy31FBiAGbpOyat1MxfxEAZU5HOBifYEvFQRZbwq3WISp7PMwed5BMrizrmyAL
         jzuzwL/V0fEH8vdsiKZYRzvrjq4QGPvNpLc/RHoB6vsNbrt3oLM9fa3Ydi9xs+WA3nxK
         a1XmEJz3a1XMbOmxPIXoTk/nP/DCl/9EmEEAcHb8eL9+qxgcArhLMptI+hinXwRMGKIy
         UzWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XUm3eU1Buz+0ts0Dif5SZ61dZ8dUqnINfHNkZQXYpU8=;
        b=MwJMgXnqtUxWIKlCdoqLr4r75k5USEO+wqco5m5XeaJgMnTIwP6PfqSfVaS3+6KBeF
         aCzXazHdO8QUh9CZiHN0vPqnd4uVJZsxidhoXAcS4s+DkIj5VzJ47UaTiXA9JEm4fiZ/
         PwtD+TQvpLpvcLpv0n0YaXibp3wm4Wp1HuFQGnBGwYa4LuxiteQ+iGFpvmKS74M5fawK
         gFq6Gu3A/4O2zNJtpiqL0RmcVI9DfjZiSyObIo0ipy1HeaDVWYc5P8FQZ9AdL8hK9Hiu
         G64bENHekBVCJwBIWwIMqrYtKQth2o8zTMgeRDaz+TFWIIEsCm8BzCNZhDEYFGJ83Sy5
         U5Yg==
X-Gm-Message-State: ACrzQf2KPOpQNaCEll/cZ2tIuponk2qDBrgVSZ7FSo7GBmByvP9Fc4eH
        QCa704rqyBGIhZDO+EwQXFecCqVvXT9FaA==
X-Google-Smtp-Source: AMsMyM74jB+esTc3yDWKccOD/OzefKI7IAoXk2Bu1NoM2ASC/PzJ5Pa4wLF1p6MgM78+xu1eym6GEw==
X-Received: by 2002:a05:6a00:1c82:b0:562:7bed:9676 with SMTP id y2-20020a056a001c8200b005627bed9676mr914694pfw.13.1667862620064;
        Mon, 07 Nov 2022 15:10:20 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id b3-20020a62cf03000000b00562a526cd2esm5037265pfg.55.2022.11.07.15.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 15:10:19 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v5 07/25] bpf: Recognize bpf_{spin_lock,list_head,list_node} in local kptrs
Date:   Tue,  8 Nov 2022 04:39:32 +0530
Message-Id: <20221107230950.7117-8-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221107230950.7117-1-memxor@gmail.com>
References: <20221107230950.7117-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14726; i=memxor@gmail.com; h=from:subject; bh=IDI88PXg+i1c6BSagE19MIWh+rcW6bvnq7C0li9H3zg=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjaY+2DtgpCrh/1XYlRSdfHfzgfq9er1vp7DC7oZqz sw9QDQKJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY2mPtgAKCRBM4MiGSL8RyuXeD/ wK/ezWE4qjwrPYgytP5LUGz2LXJrT2G2yOUoUhB0qa0D3HmG98HCpEsPJMwpf+5ee9KkCXWZaDTtmy JKFU/IHIqc9oiZCCTEF7ZOdmV4sJO6X3y7nkSTDvzeA4DT+L7HtMOqkB3VOENY9STlKBno4RF4VxgD 4mrlFFqQOJdT2IPKGIcqA55mHjwTaH+T1DW1WNkqtYH7vYCuaa5eRPvRqd2oT9ZXi06lIAlhFXWt3o /w1HuAcHgWk8SnxAMBuCuZnpe1UpQMDX6jlryMaXHs7DCPsHIu07EjrJt3sKlvtbBe9X8NVpD9FvKc Hd2uiUWGy84GZ4BzUN35KGmHLqhI4LeEm2F5khsWm3pzpaJ8nnf+HQSMYIWabRZBY76f5w6qmBL92E IiIVbQnqe2jSk8vf3deJ5Ir7l598Si332HBylZtcWrvBwF0f+mIdxz5wSJBg43+l1h4xYXEH5s2X7L hQeYf0KBBZ9gRFyQ4Xerao4z3fxt/xo5Uk8aFY0trQ50HK8BV0NM2p2Hx8XDYNRZ4D3MvLkmH1kfL/ pxr526m0zorlAEvyGWvm2UbMfyvaIIbcAn3CWyNnD+3V7xS1MkMH+0WqwGtLqOILRnuGj6d986Lo9+ dlBNkazVYWvM47EUYZ8lcHatxi8Atm+gBND0eyMVScd6Js18vcGdTWQARUpQ==
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

Update btf_struct_access callback to reject direct access to these
special fields in local kptrs.

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

A key thing to note is that once a btf_struct_meta is available for a
type, both the btf_record and btf_field_offs should be available. It is
critical that btf_field_offs is available in case special fields are
present, as we extensively rely on special fields being zeroed out in
map values and local kptrs in later patches. The code ensures that by
bailing out in case of errors and ensuring both are available together.
If the record is not available, the special fields won't be recognized,
so not having both is also fine (in terms of being a verification error
and not a runtime bug).

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h  |   7 ++
 include/linux/btf.h  |  35 ++++++++
 kernel/bpf/btf.c     | 196 +++++++++++++++++++++++++++++++++++++++----
 kernel/bpf/syscall.c |   4 +
 4 files changed, 224 insertions(+), 18 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 75dbd2ecf80a..dfcd34e36025 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -176,6 +176,7 @@ enum btf_field_type {
 	BPF_KPTR_REF   = (1 << 3),
 	BPF_KPTR       = BPF_KPTR_UNREF | BPF_KPTR_REF,
 	BPF_LIST_HEAD  = (1 << 4),
+	BPF_LIST_NODE  = (1 << 5),
 };
 
 struct btf_field_kptr {
@@ -276,6 +277,8 @@ static inline const char *btf_field_type_name(enum btf_field_type type)
 		return "kptr";
 	case BPF_LIST_HEAD:
 		return "bpf_list_head";
+	case BPF_LIST_NODE:
+		return "bpf_list_node";
 	default:
 		WARN_ON_ONCE(1);
 		return "unknown";
@@ -294,6 +297,8 @@ static inline u32 btf_field_type_size(enum btf_field_type type)
 		return sizeof(u64);
 	case BPF_LIST_HEAD:
 		return sizeof(struct bpf_list_head);
+	case BPF_LIST_NODE:
+		return sizeof(struct bpf_list_node);
 	default:
 		WARN_ON_ONCE(1);
 		return 0;
@@ -312,6 +317,8 @@ static inline u32 btf_field_type_align(enum btf_field_type type)
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
index 4d6c8577bf17..5e3cffe4bc37 100644
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
@@ -3398,6 +3427,7 @@ static int btf_find_struct_field(const struct btf *btf,
 		switch (field_type) {
 		case BPF_SPIN_LOCK:
 		case BPF_TIMER:
+		case BPF_LIST_NODE:
 			ret = btf_find_struct(btf, member_type, off, sz, field_type,
 					      idx < info_cnt ? &info[idx] : &tmp);
 			if (ret < 0)
@@ -3460,6 +3490,7 @@ static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
 		switch (field_type) {
 		case BPF_SPIN_LOCK:
 		case BPF_TIMER:
+		case BPF_LIST_NODE:
 			ret = btf_find_struct(btf, var_type, off, sz, field_type,
 					      idx < info_cnt ? &info[idx] : &tmp);
 			if (ret < 0)
@@ -3669,6 +3700,8 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
 			if (ret < 0)
 				goto end;
 			break;
+		case BPF_LIST_NODE:
+			break;
 		default:
 			ret = -EFAULT;
 			goto end;
@@ -5139,6 +5172,118 @@ static int btf_parse_hdr(struct btf_verifier_env *env)
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
+		const struct btf_member *member;
+		struct btf_field_offs *foffs;
+		struct btf_struct_meta *type;
+		struct btf_record *record;
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
+		record = btf_parse_fields(btf, t, BPF_SPIN_LOCK | BPF_LIST_HEAD | BPF_LIST_NODE, t->size);
+		if (IS_ERR_OR_NULL(record)) {
+			ret = PTR_ERR_OR_ZERO(record) ?: -EFAULT;
+			goto free;
+		}
+		foffs = btf_parse_field_offs(record);
+		if (WARN_ON_ONCE(IS_ERR_OR_NULL(foffs))) {
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
@@ -5189,6 +5334,7 @@ static int btf_check_type_tags(struct btf_verifier_env *env,
 static struct btf *btf_parse(bpfptr_t btf_data, u32 btf_data_size,
 			     u32 log_level, char __user *log_ubuf, u32 log_size)
 {
+	struct btf_struct_metas *struct_meta_tab;
 	struct btf_verifier_env *env = NULL;
 	struct bpf_verifier_log *log;
 	struct btf *btf = NULL;
@@ -5257,15 +5403,24 @@ static struct btf *btf_parse(bpfptr_t btf_data, u32 btf_data_size,
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
@@ -6026,6 +6181,28 @@ int btf_struct_access(struct bpf_verifier_log *log,
 	u32 id = reg->btf_id;
 	int err;
 
+	while (type_is_local_kptr(reg->type)) {
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
@@ -7267,23 +7444,6 @@ bool btf_is_module(const struct btf *btf)
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
index fdbae52f463f..c96039a4e57f 100644
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

