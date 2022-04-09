Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171454FA67C
	for <lists+bpf@lfdr.de>; Sat,  9 Apr 2022 11:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiDIJfn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 9 Apr 2022 05:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239437AbiDIJfj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 9 Apr 2022 05:35:39 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A7B62CC
        for <bpf@vger.kernel.org>; Sat,  9 Apr 2022 02:33:32 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id u14so10786826pjj.0
        for <bpf@vger.kernel.org>; Sat, 09 Apr 2022 02:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lvIedNFHqeEgnWVKpptdosSqKfVDEskkhdyKy05rVAg=;
        b=iO6ry2ATNl2MoUDVvFCxzY+lMuQRA+Ywi6PSkREiPygNg4BccCzG44q88pFen/wL9i
         mPEvB8rtXK4oob7KafgsKGg3RiKYHM+8dpgFLm0Ly8QobkCYXyiGlXMT0pr5u2WmhwTY
         jiwttP/slPI4/R57A4iUvZ6HZvao7boDshQfV4O06esk8RJiewkANQvjaqAXgzDdZizq
         oNEccEmIn30dAlmVPFaHvN+sqv45eJyLSPBaTdf50LxYvh5WMbkyI9e5Nnrp2WDZhPhz
         alskdFlvPHayiqZrA1Ke6nJDNiHiWHviYcjupUdBbKrLGCcNm7vIyNGPuip4YvsJt2wI
         KBtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lvIedNFHqeEgnWVKpptdosSqKfVDEskkhdyKy05rVAg=;
        b=HOv62uL51gXSu3ILki3exDLAJfdiCKtp3E9YiafRF3Kse6jiZDdVzkdhLM3ZuLEEGs
         09ruqPBAEhm2zRegp98pqNjf5hBXYQgh3JAdsQyzn/E45+ZsdAqz0w5A/0P7dX0u61yM
         bBTptmq6nuw7s+X7xqEYOcjMdJSftQDFgPWACjsgo7jX0GowZzJdUNlBwdGMRIlP1fOp
         ZNKRyJZPav9X4KLhgJdwvkpi2Q5tmt6xYTY9URrc+/OmvzkpY8z9kJJJiBa+1EJuoE7E
         5XP+q2+2EfXbTUkAMMG4oT0NyrT6RVHL4rgZHmbRCmP+M8HsSViAB89AIuUZSMI/rGH9
         ct5Q==
X-Gm-Message-State: AOAM5300fVwMGdSHQqJYUkwMx8piycsE6D9lZNTIlMG27NC+qWsg14dC
        ORuBf959XLaOfDx/Wt5yoFMUrZU8FMk=
X-Google-Smtp-Source: ABdhPJwirCMqy3W1obUYdckLSzVpsEospmbL70F9hFZ3f9XxAt1ISV9TeZBVT+WG6UrY3ZauX1UBDw==
X-Received: by 2002:a17:902:d5c3:b0:154:c472:de80 with SMTP id g3-20020a170902d5c300b00154c472de80mr23492280plh.87.1649496811700;
        Sat, 09 Apr 2022 02:33:31 -0700 (PDT)
Received: from localhost ([112.79.142.148])
        by smtp.gmail.com with ESMTPSA id y5-20020a056a00180500b004faac109225sm30726218pfa.179.2022.04.09.02.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 02:33:31 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH bpf-next v4 09/13] bpf: Wire up freeing of referenced kptr
Date:   Sat,  9 Apr 2022 15:02:59 +0530
Message-Id: <20220409093303.499196-10-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220409093303.499196-1-memxor@gmail.com>
References: <20220409093303.499196-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=16900; h=from:subject; bh=/qeskZc82mrgyArFPtrC+XMwdGxTTILkn7/5d+pplrE=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiUVF0E6KAs4YjtEwQlLYfVhOhjHJZbAkX8LOnHRiN 3BhG3PGJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYlFRdAAKCRBM4MiGSL8RynYhEA C6xbHtOaC2qK5moMI1I7N7R+bOUSuiNRXIMlANZJxBXMmViy8Z51z2n+HhQj8OK1eq6JCNXAD9VeJJ Y0NrIP0YXsr1pg7AoBvXTF4OMsScXR7sg7h/dYbMyBuyHisJ6BG2A9WLmwO9Mdn0rwSnB0mni9Cx4w tXbwFpQ3H6mBcpbQ7qP9t4QiUjQlVHZITlmM4AgUB/MQw4dRGrDjsfCRiB/gbzO+5ack21I+lsDXKc 2adyb0niSb0WZ4c43sPGmDNoZECRhjx3cGCUveHUhG4F5lL4KEde9zHsbVT1FM203YFKWDb6k6Syd2 8nbt+IowA7+C83XtQ49CNkaiEYom6m6T0xGRUB+lZ0eaoLSCgE7UKQ6y3mZJCYk+CONsvfKMcGScED SlArlI7GUxv4aeH6dWacO0/x7PnI2l8okfIqJNWQIXTlFGbCGXJ+sJqULb1mp5fE3IHIQOcvz8ZeEE lj8mQzOTUTXGikezHDTI3UZiocvn1agnVQXzOJ39lmDlXDKOTT3IA+iM+xysHf0B9zmEeoOdcD7c2y 4uBUVlRQAJLY5kv4khwD62LcHLjZFmJ463xHbplU4cEdKP2UNJI50G6+QDmv2UixJOsWBiKV82RiMy w+sZF94r4MUBp+wW2oqjHY9VIU8lSw4vWg//gz4KH3gCJr1nkAXmuNQQXliQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A destructor kfunc can be defined as void func(type *), where type may
be void or any other pointer type as per convenience.

In this patch, we ensure that the type is sane and capture the function
pointer into off_desc of ptr_off_tab for the specific pointer offset,
with the invariant that the dtor pointer is always set when 'kptr_ref'
tag is applied to the pointer's pointee type, which is indicated by the
flag BPF_MAP_VALUE_OFF_F_REF.

Note that only BTF IDs whose destructor kfunc is registered, thus become
the allowed BTF IDs for embedding as referenced kptr. Hence it serves
the purpose of finding dtor kfunc BTF ID, as well acting as a check
against the whitelist of allowed BTF IDs for this purpose.

Finally, wire up the actual freeing of the referenced pointer if any at
all available offsets, so that no references are leaked after the BPF
map goes away and the BPF program previously moved the ownership a
referenced pointer into it.

The behavior is similar to BPF timers, where bpf_map_{update,delete}_elem
will free any existing referenced kptr. The same case is with LRU map's
bpf_lru_push_free/htab_lru_push_free functions, which are extended to
reset unreferenced and free referenced kptr.

Note that unlike BPF timers, kptr is not reset or freed when map uref
drops to zero.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h   |   4 ++
 include/linux/btf.h   |   2 +
 kernel/bpf/arraymap.c |  14 +++++-
 kernel/bpf/btf.c      | 100 +++++++++++++++++++++++++++++++++++++++++-
 kernel/bpf/hashtab.c  |  58 ++++++++++++++++++------
 kernel/bpf/syscall.c  |  57 +++++++++++++++++++++---
 6 files changed, 212 insertions(+), 23 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index bd79132c664d..a0a848127007 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -23,6 +23,7 @@
 #include <linux/slab.h>
 #include <linux/percpu-refcount.h>
 #include <linux/bpfptr.h>
+#include <linux/btf.h>
 
 struct bpf_verifier_env;
 struct bpf_verifier_log;
@@ -171,6 +172,8 @@ struct bpf_map_value_off_desc {
 	u32 offset;
 	u32 btf_id;
 	struct btf *btf;
+	struct module *module;
+	btf_dtor_kfunc_t dtor;
 	int flags;
 };
 
@@ -1545,6 +1548,7 @@ struct bpf_map_value_off_desc *bpf_map_kptr_off_contains(struct bpf_map *map, u3
 void bpf_map_free_kptr_off_tab(struct bpf_map *map);
 struct bpf_map_value_off *bpf_map_copy_kptr_off_tab(const struct bpf_map *map);
 bool bpf_map_equal_kptr_off_tab(const struct bpf_map *map_a, const struct bpf_map *map_b);
+void bpf_map_free_kptrs(struct bpf_map *map, void *map_value);
 
 struct bpf_map *bpf_map_get(u32 ufd);
 struct bpf_map *bpf_map_get_with_uref(u32 ufd);
diff --git a/include/linux/btf.h b/include/linux/btf.h
index fea424681d66..f70625dd5bb4 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -45,6 +45,8 @@ struct btf_id_dtor_kfunc {
 	u32 kfunc_btf_id;
 };
 
+typedef void (*btf_dtor_kfunc_t)(void *);
+
 extern const struct file_operations btf_fops;
 
 void btf_get(struct btf *btf);
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 7f145aefbff8..a84bbca55336 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -287,10 +287,12 @@ static int array_map_get_next_key(struct bpf_map *map, void *key, void *next_key
 	return 0;
 }
 
-static void check_and_free_timer_in_array(struct bpf_array *arr, void *val)
+static void check_and_free_fields(struct bpf_array *arr, void *val)
 {
 	if (unlikely(map_value_has_timer(&arr->map)))
 		bpf_timer_cancel_and_free(val + arr->map.timer_off);
+	if (unlikely(map_value_has_kptrs(&arr->map)))
+		bpf_map_free_kptrs(&arr->map, val);
 }
 
 /* Called from syscall or from eBPF program */
@@ -327,7 +329,7 @@ static int array_map_update_elem(struct bpf_map *map, void *key, void *value,
 			copy_map_value_locked(map, val, value, false);
 		else
 			copy_map_value(map, val, value);
-		check_and_free_timer_in_array(array, val);
+		check_and_free_fields(array, val);
 	}
 	return 0;
 }
@@ -386,6 +388,7 @@ static void array_map_free_timers(struct bpf_map *map)
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
 	int i;
 
+	/* We don't reset or free kptr on uref dropping to zero. */
 	if (likely(!map_value_has_timer(map)))
 		return;
 
@@ -398,6 +401,13 @@ static void array_map_free_timers(struct bpf_map *map)
 static void array_map_free(struct bpf_map *map)
 {
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
+	int i;
+
+	if (unlikely(map_value_has_kptrs(map))) {
+		for (i = 0; i < array->map.max_entries; i++)
+			bpf_map_free_kptrs(map, array->value + array->elem_size * i);
+		bpf_map_free_kptr_off_tab(map);
+	}
 
 	if (array->map.map_type == BPF_MAP_TYPE_PERCPU_ARRAY)
 		bpf_array_free_percpu(array);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 8d7cdb8a6391..8978724b0b61 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3412,6 +3412,8 @@ struct bpf_map_value_off *btf_parse_kptrs(const struct btf *btf,
 {
 	struct btf_field_info info_arr[BPF_MAP_VALUE_OFF_MAX];
 	struct bpf_map_value_off *tab;
+	struct btf *off_btf = NULL;
+	struct module *mod = NULL;
 	int ret, i, nr_off;
 
 	/* Revisit stack usage when bumping BPF_MAP_VALUE_OFF_MAX */
@@ -3431,7 +3433,6 @@ struct bpf_map_value_off *btf_parse_kptrs(const struct btf *btf,
 	tab->nr_off = 0;
 	for (i = 0; i < nr_off; i++) {
 		const struct btf_type *t;
-		struct btf *off_btf;
 		s32 id;
 
 		t = btf_type_by_id(btf, info_arr[i].type_id);
@@ -3442,16 +3443,69 @@ struct bpf_map_value_off *btf_parse_kptrs(const struct btf *btf,
 			goto end;
 		}
 
+		/* Find and stash the function pointer for the destruction function that
+		 * needs to be eventually invoked from the map free path.
+		 */
+		if (info_arr[i].flags & BPF_MAP_VALUE_OFF_F_REF) {
+			const struct btf_type *dtor_func;
+			const char *dtor_func_name;
+			unsigned long addr;
+			s32 dtor_btf_id;
+
+			/* This call also serves as a whitelist of allowed objects that
+			 * can be used as a referenced pointer and be stored in a map at
+			 * the same time.
+			 */
+			dtor_btf_id = btf_find_dtor_kfunc(off_btf, id);
+			if (dtor_btf_id < 0) {
+				ret = dtor_btf_id;
+				goto end_btf;
+			}
+
+			dtor_func = btf_type_by_id(off_btf, dtor_btf_id);
+			if (!dtor_func) {
+				ret = -ENOENT;
+				goto end_btf;
+			}
+
+			if (btf_is_module(btf)) {
+				mod = btf_try_get_module(off_btf);
+				if (!mod) {
+					ret = -ENXIO;
+					goto end_btf;
+				}
+			}
+
+			/* We already verified dtor_func to be btf_type_is_func
+			 * in register_btf_id_dtor_kfuncs.
+			 */
+			dtor_func_name = __btf_name_by_offset(off_btf, dtor_func->name_off);
+			addr = kallsyms_lookup_name(dtor_func_name);
+			if (!addr) {
+				ret = -EINVAL;
+				goto end_mod;
+			}
+			tab->off[i].dtor = (void *)addr;
+		}
+
 		tab->off[i].offset = info_arr[i].off;
 		tab->off[i].btf_id = id;
 		tab->off[i].btf = off_btf;
+		tab->off[i].module = mod;
 		tab->off[i].flags = info_arr[i].flags;
 		tab->nr_off = i + 1;
 	}
 	return tab;
+end_mod:
+	module_put(mod);
+end_btf:
+	btf_put(off_btf);
 end:
-	while (tab->nr_off--)
+	while (tab->nr_off--) {
 		btf_put(tab->off[tab->nr_off].btf);
+		if (tab->off[tab->nr_off].module)
+			module_put(tab->off[tab->nr_off].module);
+	}
 	kfree(tab);
 	return ERR_PTR(ret);
 }
@@ -7056,6 +7110,43 @@ s32 btf_find_dtor_kfunc(struct btf *btf, u32 btf_id)
 	return dtor->kfunc_btf_id;
 }
 
+static int btf_check_dtor_kfuncs(struct btf *btf, const struct btf_id_dtor_kfunc *dtors, u32 cnt)
+{
+	const struct btf_type *dtor_func, *dtor_func_proto, *t;
+	const struct btf_param *args;
+	s32 dtor_btf_id;
+	u32 nr_args, i;
+
+	for (i = 0; i < cnt; i++) {
+		dtor_btf_id = dtors[i].kfunc_btf_id;
+
+		dtor_func = btf_type_by_id(btf, dtor_btf_id);
+		if (!dtor_func || !btf_type_is_func(dtor_func))
+			return -EINVAL;
+
+		dtor_func_proto = btf_type_by_id(btf, dtor_func->type);
+		if (!dtor_func_proto || !btf_type_is_func_proto(dtor_func_proto))
+			return -EINVAL;
+
+		/* Make sure the prototype of the destructor kfunc is 'void func(type *)' */
+		t = btf_type_by_id(btf, dtor_func_proto->type);
+		if (!t || !btf_type_is_void(t))
+			return -EINVAL;
+
+		nr_args = btf_type_vlen(dtor_func_proto);
+		if (nr_args != 1)
+			return -EINVAL;
+		args = btf_params(dtor_func_proto);
+		t = btf_type_by_id(btf, args[0].type);
+		/* Allow any pointer type, as width on targets Linux supports
+		 * will be same for all pointer types (i.e. sizeof(void *))
+		 */
+		if (!t || !btf_type_is_ptr(t))
+			return -EINVAL;
+	}
+	return 0;
+}
+
 /* This function must be invoked only from initcalls/module init functions */
 int register_btf_id_dtor_kfuncs(const struct btf_id_dtor_kfunc *dtors, u32 add_cnt,
 				struct module *owner)
@@ -7086,6 +7177,11 @@ int register_btf_id_dtor_kfuncs(const struct btf_id_dtor_kfunc *dtors, u32 add_c
 		goto end;
 	}
 
+	/* Ensure that the prototype of dtor kfuncs being registered is sane */
+	ret = btf_check_dtor_kfuncs(btf, dtors, add_cnt);
+	if (ret < 0)
+		goto end;
+
 	tab = btf->dtor_kfunc_tab;
 	/* Only one call allowed for modules */
 	if (WARN_ON_ONCE(tab && btf_is_module(btf))) {
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 65877967f414..d5ef0ae56a61 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -254,6 +254,25 @@ static void htab_free_prealloced_timers(struct bpf_htab *htab)
 	}
 }
 
+static void htab_free_prealloced_kptrs(struct bpf_htab *htab)
+{
+	u32 num_entries = htab->map.max_entries;
+	int i;
+
+	if (likely(!map_value_has_kptrs(&htab->map)))
+		return;
+	if (htab_has_extra_elems(htab))
+		num_entries += num_possible_cpus();
+
+	for (i = 0; i < num_entries; i++) {
+		struct htab_elem *elem;
+
+		elem = get_htab_elem(htab, i);
+		bpf_map_free_kptrs(&htab->map, elem->key + round_up(htab->map.key_size, 8));
+		cond_resched();
+	}
+}
+
 static void htab_free_elems(struct bpf_htab *htab)
 {
 	int i;
@@ -725,12 +744,15 @@ static int htab_lru_map_gen_lookup(struct bpf_map *map,
 	return insn - insn_buf;
 }
 
-static void check_and_free_timer(struct bpf_htab *htab, struct htab_elem *elem)
+static void check_and_free_fields(struct bpf_htab *htab,
+				  struct htab_elem *elem)
 {
+	void *map_value = elem->key + round_up(htab->map.key_size, 8);
+
 	if (unlikely(map_value_has_timer(&htab->map)))
-		bpf_timer_cancel_and_free(elem->key +
-					  round_up(htab->map.key_size, 8) +
-					  htab->map.timer_off);
+		bpf_timer_cancel_and_free(map_value + htab->map.timer_off);
+	if (unlikely(map_value_has_kptrs(&htab->map)))
+		bpf_map_free_kptrs(&htab->map, map_value);
 }
 
 /* It is called from the bpf_lru_list when the LRU needs to delete
@@ -757,7 +779,7 @@ static bool htab_lru_map_delete_node(void *arg, struct bpf_lru_node *node)
 	hlist_nulls_for_each_entry_rcu(l, n, head, hash_node)
 		if (l == tgt_l) {
 			hlist_nulls_del_rcu(&l->hash_node);
-			check_and_free_timer(htab, l);
+			check_and_free_fields(htab, l);
 			break;
 		}
 
@@ -829,7 +851,7 @@ static void htab_elem_free(struct bpf_htab *htab, struct htab_elem *l)
 {
 	if (htab->map.map_type == BPF_MAP_TYPE_PERCPU_HASH)
 		free_percpu(htab_elem_get_ptr(l, htab->map.key_size));
-	check_and_free_timer(htab, l);
+	check_and_free_fields(htab, l);
 	kfree(l);
 }
 
@@ -857,7 +879,7 @@ static void free_htab_elem(struct bpf_htab *htab, struct htab_elem *l)
 	htab_put_fd_value(htab, l);
 
 	if (htab_is_prealloc(htab)) {
-		check_and_free_timer(htab, l);
+		check_and_free_fields(htab, l);
 		__pcpu_freelist_push(&htab->freelist, &l->fnode);
 	} else {
 		atomic_dec(&htab->count);
@@ -1104,7 +1126,7 @@ static int htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 		if (!htab_is_prealloc(htab))
 			free_htab_elem(htab, l_old);
 		else
-			check_and_free_timer(htab, l_old);
+			check_and_free_fields(htab, l_old);
 	}
 	ret = 0;
 err:
@@ -1114,7 +1136,7 @@ static int htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 
 static void htab_lru_push_free(struct bpf_htab *htab, struct htab_elem *elem)
 {
-	check_and_free_timer(htab, elem);
+	check_and_free_fields(htab, elem);
 	bpf_lru_push_free(&htab->lru, &elem->lru_node);
 }
 
@@ -1419,8 +1441,14 @@ static void htab_free_malloced_timers(struct bpf_htab *htab)
 		struct hlist_nulls_node *n;
 		struct htab_elem *l;
 
-		hlist_nulls_for_each_entry(l, n, head, hash_node)
-			check_and_free_timer(htab, l);
+		hlist_nulls_for_each_entry(l, n, head, hash_node) {
+			/* We don't reset or free kptr on uref dropping to zero,
+			 * hence just free timer.
+			 */
+			bpf_timer_cancel_and_free(l->key +
+						  round_up(htab->map.key_size, 8) +
+						  htab->map.timer_off);
+		}
 		cond_resched_rcu();
 	}
 	rcu_read_unlock();
@@ -1430,6 +1458,7 @@ static void htab_map_free_timers(struct bpf_map *map)
 {
 	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
 
+	/* We don't reset or free kptr on uref dropping to zero. */
 	if (likely(!map_value_has_timer(&htab->map)))
 		return;
 	if (!htab_is_prealloc(htab))
@@ -1453,11 +1482,14 @@ static void htab_map_free(struct bpf_map *map)
 	 * not have executed. Wait for them.
 	 */
 	rcu_barrier();
-	if (!htab_is_prealloc(htab))
+	if (!htab_is_prealloc(htab)) {
 		delete_all_elements(htab);
-	else
+	} else {
+		htab_free_prealloced_kptrs(htab);
 		prealloc_destroy(htab);
+	}
 
+	bpf_map_free_kptr_off_tab(map);
 	free_percpu(htab->extra_elems);
 	bpf_map_area_free(htab->buckets);
 	for (i = 0; i < HASHTAB_MAP_LOCK_COUNT; i++)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 481d5bb06203..de237bfede85 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -508,8 +508,11 @@ void bpf_map_free_kptr_off_tab(struct bpf_map *map)
 	if (!map_value_has_kptrs(map))
 		return;
 	for (i = 0; i < tab->nr_off; i++) {
+		struct module *mod = tab->off[i].module;
 		struct btf *btf = tab->off[i].btf;
 
+		if (mod)
+			module_put(mod);
 		btf_put(btf);
 	}
 	kfree(tab);
@@ -524,8 +527,16 @@ struct bpf_map_value_off *bpf_map_copy_kptr_off_tab(const struct bpf_map *map)
 	if (!map_value_has_kptrs(map))
 		return ERR_PTR(-ENOENT);
 	/* Do a deep copy of the kptr_off_tab */
-	for (i = 0; i < tab->nr_off; i++)
-		btf_get(tab->off[i].btf);
+	for (i = 0; i < tab->nr_off; i++) {
+		struct module *mod = tab->off[i].module;
+		struct btf *btf = tab->off[i].btf;
+
+		if (mod && !try_module_get(mod)) {
+			ret = -ENXIO;
+			goto end;
+		}
+		btf_get(btf);
+	}
 
 	size = offsetof(struct bpf_map_value_off, off[tab->nr_off]);
 	new_tab = kzalloc(size, GFP_KERNEL | __GFP_NOWARN);
@@ -536,8 +547,14 @@ struct bpf_map_value_off *bpf_map_copy_kptr_off_tab(const struct bpf_map *map)
 	memcpy(new_tab, tab, size);
 	return new_tab;
 end:
-	while (i--)
-		btf_put(tab->off[i].btf);
+	while (i--) {
+		struct module *mod = tab->off[i].module;
+		struct btf *btf = tab->off[i].btf;
+
+		if (mod)
+			module_put(mod);
+		btf_put(btf);
+	}
 	return ERR_PTR(ret);
 }
 
@@ -557,6 +574,33 @@ bool bpf_map_equal_kptr_off_tab(const struct bpf_map *map_a, const struct bpf_ma
 	return !memcmp(tab_a, tab_b, size);
 }
 
+/* Caller must ensure map_value_has_kptrs is true. Note that this function can
+ * be called on a map value while the map_value is visible to BPF programs, as
+ * it ensures the correct synchronization, and we already enforce the same using
+ * the bpf_kptr_xchg helper on the BPF program side for referenced kptrs.
+ */
+void bpf_map_free_kptrs(struct bpf_map *map, void *map_value)
+{
+	struct bpf_map_value_off *tab = map->kptr_off_tab;
+	unsigned long *btf_id_ptr;
+	int i;
+
+	for (i = 0; i < tab->nr_off; i++) {
+		struct bpf_map_value_off_desc *off_desc = &tab->off[i];
+		unsigned long old_ptr;
+
+		btf_id_ptr = map_value + off_desc->offset;
+		if (!(off_desc->flags & BPF_MAP_VALUE_OFF_F_REF)) {
+			u64 *p = (u64 *)btf_id_ptr;
+
+			WRITE_ONCE(p, 0);
+			continue;
+		}
+		old_ptr = xchg(btf_id_ptr, 0);
+		off_desc->dtor((void *)old_ptr);
+	}
+}
+
 /* called from workqueue */
 static void bpf_map_free_deferred(struct work_struct *work)
 {
@@ -564,9 +608,10 @@ static void bpf_map_free_deferred(struct work_struct *work)
 
 	security_bpf_map_free(map);
 	kfree(map->off_arr);
-	bpf_map_free_kptr_off_tab(map);
 	bpf_map_release_memcg(map);
-	/* implementation dependent freeing */
+	/* implementation dependent freeing, map_free callback also does
+	 * bpf_map_free_kptr_off_tab, if needed.
+	 */
 	map->ops->map_free(map);
 }
 
-- 
2.35.1

