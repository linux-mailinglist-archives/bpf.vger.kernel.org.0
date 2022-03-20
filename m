Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3CC84E1C6A
	for <lists+bpf@lfdr.de>; Sun, 20 Mar 2022 16:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245418AbiCTP5Q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Mar 2022 11:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245417AbiCTP5P (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Mar 2022 11:57:15 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF8954188
        for <bpf@vger.kernel.org>; Sun, 20 Mar 2022 08:55:52 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id mm17-20020a17090b359100b001c6da62a559so2742985pjb.3
        for <bpf@vger.kernel.org>; Sun, 20 Mar 2022 08:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JwA6tXeW4rujADpGQJYx5JHai0TWyLc8dgN6taF15IE=;
        b=oODt10Q4zjgfRuaAQ2rJq9U1cnxWv8ldbVFjDWqbO5rdjSEJVDRFIxs9j7KoUvckgP
         clH7n9d3KiY77DpPwpwCsqblQXjlO3zbLuDpy9TB+5q7+2dELNBHbYAyRif6AxSv+HkU
         hrVm6mZw64UxLJPw9qmnK0+OA5+MRSCkjsO+4gibk4OndSsz0HfHCgv+cYBaeSd6bUKW
         3I0JewJPl5WEiyYToExSTVwS2cKXmyQu9yi9/LYzmJrGvkgz14DPdQa2Pj11dOmaNdHQ
         nAf06fAcSgiJi2RprUbsVYl0oWZVyBwodclig+vGLymCOEwjW8c5XO8JxY1uNzGf2zMM
         Xo2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JwA6tXeW4rujADpGQJYx5JHai0TWyLc8dgN6taF15IE=;
        b=TgsTAOM/stExlAehCZRQVB22XzJzUO2nytPgJBD0gUllxK2hlE7NEyW0KDoGrRTfI7
         KFJAS5ZaIdzyT5BjhIalp90xkHty1RRkNkPi9GUG8+YzrtGDaw/7j/Ou3Mlaexv9QHFx
         St/kdmyAZWMZ2ZJXl4ZssRdMr65jpvYMWzLyYtSf+WTBB+V3gi84ezukQcMWh4UpLzem
         Dk1VtsiMQqdOzsoGYUrQ9qVp+ivUaVttN4MsfJP3/nadn2RceykV5zXfBhxvOZT1CaSl
         lQQZnCrhEUnx4Iyuul2ndLVdx/76P2whSh/D3Z+4DEaVDcKLPq+e04U/epo1ShfIEYXt
         tdGw==
X-Gm-Message-State: AOAM532oBdPegvU7hL7iWK5FN/AOzhcIQeBXzG12BCNI5C3eNY3GKjaO
        /YX99uHdgKMZ1bbM767qDNND9Vw+Rww=
X-Google-Smtp-Source: ABdhPJx9N7Q7DrxTWpjcAOw6zmGxIr/Y4skbYBYeA7/iemhTVZ2v7gstWXN1w0+X/0ePYR+J2opbXg==
X-Received: by 2002:a17:90b:3a86:b0:1c6:5971:5980 with SMTP id om6-20020a17090b3a8600b001c659715980mr25558926pjb.68.1647791751313;
        Sun, 20 Mar 2022 08:55:51 -0700 (PDT)
Received: from localhost ([14.139.187.71])
        by smtp.gmail.com with ESMTPSA id l10-20020a056a00140a00b004c55d0dcbd1sm16201688pfu.120.2022.03.20.08.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 08:55:51 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH bpf-next v3 09/13] bpf: Wire up freeing of referenced kptr
Date:   Sun, 20 Mar 2022 21:25:06 +0530
Message-Id: <20220320155510.671497-10-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220320155510.671497-1-memxor@gmail.com>
References: <20220320155510.671497-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14749; h=from:subject; bh=bsGWMu7O7IOIOHzd460LROXQUnokTF+Q5w3+3PEv6WE=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiN00yf5ueOdmNO55VEb72j7L13mzQ7326cCT7QVBE bZrgY/iJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYjdNMgAKCRBM4MiGSL8Ryu8oD/ 0Q0HRU2E5HagZFmjHnovF5rHIPaAzlVBvL01uPKgXu5bOFepQyQM/cXOOP9/GC/9NRRQBUJfOA+gTs PLwQ4Sa4KU7Ytnu4u06/5WK283LoN8GuEeISZmdPNfKFU+hO7JbgJLHBj5wKPiWJiJk+iEEEz3pkS5 2SPXu/YAel4GyJSsF1j2l+cOO7yc7dN/eH+qGV+mL2Zh4qFeMeni8pURSBro8wQWmR/n3mkQaeMzdQ RBfDs124cFB4SRzgEIG1CcNJMsNwtJO0J6JPwUcKG8j/XSrGrom/RVk2Whcrh5z5QSe/763uTkiGGA h2S4elmcNYLTheotRbWZPpS0FOPsYAayZACOS1exvi+4ncNDZaQkVXuyRuHGmUXLRlbCOupTldYfEY Hc6nlLcBHi7gdnRHXvLSi8xBVbkKTfrHclvboMPjnsFhhox3GQa+qZI5gButdbSxeDLJbK7UZ0EAAK o6fqW1MMrTjLo+ZdCLuTRcpEehuWeyh7DL7D/WL7EtyXH6ysap54yXbzPYpMldcvbW5qSMoYXaAk/Z npqCdmKQj3hFLsZhzTDYe6O3addLoFr4uyVf39UNn0e290oB8y2aE7RGFYsVBFZCkDL040urLmSwTB LxTGYuveCHP7GBoXSEt3IKr4fciJ8eOjwI1htLrAJ/qajJqrzUF1UWNqRVaw==
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
 include/linux/bpf.h   |  4 ++
 include/linux/btf.h   |  2 +
 kernel/bpf/arraymap.c | 14 ++++++-
 kernel/bpf/btf.c      | 86 ++++++++++++++++++++++++++++++++++++++++++-
 kernel/bpf/hashtab.c  | 29 ++++++++++-----
 kernel/bpf/syscall.c  | 57 +++++++++++++++++++++++++---
 6 files changed, 173 insertions(+), 19 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 6474d2d44b78..ae52602fdfbf 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -23,6 +23,7 @@
 #include <linux/slab.h>
 #include <linux/percpu-refcount.h>
 #include <linux/bpfptr.h>
+#include <linux/btf.h>
 
 struct bpf_verifier_env;
 struct bpf_verifier_log;
@@ -172,6 +173,8 @@ struct bpf_map_value_off_desc {
 	u32 offset;
 	u32 btf_id;
 	struct btf *btf;
+	struct module *module;
+	btf_dtor_kfunc_t dtor;
 	int flags;
 };
 
@@ -1551,6 +1554,7 @@ struct bpf_map_value_off_desc *bpf_map_kptr_off_contains(struct bpf_map *map, u3
 void bpf_map_free_kptr_off_tab(struct bpf_map *map);
 struct bpf_map_value_off *bpf_map_copy_kptr_off_tab(const struct bpf_map *map);
 bool bpf_map_equal_kptr_off_tab(const struct bpf_map *map_a, const struct bpf_map *map_b);
+void bpf_map_free_kptr(struct bpf_map *map, void *map_value);
 
 struct bpf_map *bpf_map_get(u32 ufd);
 struct bpf_map *bpf_map_get_with_uref(u32 ufd);
diff --git a/include/linux/btf.h b/include/linux/btf.h
index ff4be49b7a26..8acf728c8616 100644
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
index 7f145aefbff8..3cc2884321e7 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -287,10 +287,12 @@ static int array_map_get_next_key(struct bpf_map *map, void *key, void *next_key
 	return 0;
 }
 
-static void check_and_free_timer_in_array(struct bpf_array *arr, void *val)
+static void check_and_free_timer_and_kptr(struct bpf_array *arr, void *val)
 {
 	if (unlikely(map_value_has_timer(&arr->map)))
 		bpf_timer_cancel_and_free(val + arr->map.timer_off);
+	if (unlikely(map_value_has_kptr(&arr->map)))
+		bpf_map_free_kptr(&arr->map, val);
 }
 
 /* Called from syscall or from eBPF program */
@@ -327,7 +329,7 @@ static int array_map_update_elem(struct bpf_map *map, void *key, void *value,
 			copy_map_value_locked(map, val, value, false);
 		else
 			copy_map_value(map, val, value);
-		check_and_free_timer_in_array(array, val);
+		check_and_free_timer_and_kptr(array, val);
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
+	if (unlikely(map_value_has_kptr(map))) {
+		for (i = 0; i < array->map.max_entries; i++)
+			bpf_map_free_kptr(map, array->value + array->elem_size * i);
+		bpf_map_free_kptr_off_tab(map);
+	}
 
 	if (array->map.map_type == BPF_MAP_TYPE_PERCPU_ARRAY)
 		bpf_array_free_percpu(array);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 9cb6f61a50a7..6227c1be6326 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3408,6 +3408,7 @@ struct bpf_map_value_off *btf_find_kptr(const struct btf *btf,
 	/* btf_find_field requires array of size max + 1 */
 	struct btf_field_info info_arr[BPF_MAP_VALUE_OFF_MAX + 1];
 	struct bpf_map_value_off *tab;
+	struct module *mod = NULL;
 	int ret, i, nr_off;
 
 	/* Revisit stack usage when bumping BPF_MAP_VALUE_OFF_MAX */
@@ -3438,16 +3439,99 @@ struct bpf_map_value_off *btf_find_kptr(const struct btf *btf,
 			goto end;
 		}
 
+		/* Find and stash the function pointer for the destruction function that
+		 * needs to be eventually invoked from the map free path.
+		 */
+		if (info_arr[i].flags & BPF_MAP_VALUE_OFF_F_REF) {
+			const struct btf_type *dtor_func, *dtor_func_proto;
+			const struct btf_param *args;
+			const char *dtor_func_name;
+			unsigned long addr;
+			s32 dtor_btf_id;
+			u32 nr_args;
+
+			/* This call also serves as a whitelist of allowed objects that
+			 * can be used as a referenced pointer and be stored in a map at
+			 * the same time.
+			 */
+			dtor_btf_id = btf_find_dtor_kfunc(off_btf, id);
+			if (dtor_btf_id < 0) {
+				ret = dtor_btf_id;
+				btf_put(off_btf);
+				goto end;
+			}
+
+			dtor_func = btf_type_by_id(off_btf, dtor_btf_id);
+			if (!dtor_func || !btf_type_is_func(dtor_func)) {
+				ret = -EINVAL;
+				btf_put(off_btf);
+				goto end;
+			}
+
+			dtor_func_proto = btf_type_by_id(off_btf, dtor_func->type);
+			if (!dtor_func_proto || !btf_type_is_func_proto(dtor_func_proto)) {
+				ret = -EINVAL;
+				btf_put(off_btf);
+				goto end;
+			}
+
+			/* Make sure the prototype of the destructor kfunc is 'void func(type *)' */
+			t = btf_type_by_id(off_btf, dtor_func_proto->type);
+			if (!t || !btf_type_is_void(t)) {
+				ret = -EINVAL;
+				btf_put(off_btf);
+				goto end;
+			}
+
+			nr_args = btf_type_vlen(dtor_func_proto);
+			args = btf_params(dtor_func_proto);
+
+			t = NULL;
+			if (nr_args)
+				t = btf_type_by_id(off_btf, args[0].type);
+			/* Allow any pointer type, as width on targets Linux supports
+			 * will be same for all pointer types (i.e. sizeof(void *))
+			 */
+			if (nr_args != 1 || !t || !btf_type_is_ptr(t)) {
+				ret = -EINVAL;
+				btf_put(off_btf);
+				goto end;
+			}
+
+			if (btf_is_module(btf)) {
+				mod = btf_try_get_module(off_btf);
+				if (!mod) {
+					ret = -ENXIO;
+					btf_put(off_btf);
+					goto end;
+				}
+			}
+
+			dtor_func_name = __btf_name_by_offset(off_btf, dtor_func->name_off);
+			addr = kallsyms_lookup_name(dtor_func_name);
+			if (!addr) {
+				ret = -EINVAL;
+				module_put(mod);
+				btf_put(off_btf);
+				goto end;
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
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 65877967f414..fa4a0a8754c5 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -725,12 +725,16 @@ static int htab_lru_map_gen_lookup(struct bpf_map *map,
 	return insn - insn_buf;
 }
 
-static void check_and_free_timer(struct bpf_htab *htab, struct htab_elem *elem)
+static void check_and_free_timer_and_kptr(struct bpf_htab *htab,
+					  struct htab_elem *elem,
+					  bool free_kptr)
 {
+	void *map_value = elem->key + round_up(htab->map.key_size, 8);
+
 	if (unlikely(map_value_has_timer(&htab->map)))
-		bpf_timer_cancel_and_free(elem->key +
-					  round_up(htab->map.key_size, 8) +
-					  htab->map.timer_off);
+		bpf_timer_cancel_and_free(map_value + htab->map.timer_off);
+	if (unlikely(map_value_has_kptr(&htab->map)) && free_kptr)
+		bpf_map_free_kptr(&htab->map, map_value);
 }
 
 /* It is called from the bpf_lru_list when the LRU needs to delete
@@ -757,7 +761,7 @@ static bool htab_lru_map_delete_node(void *arg, struct bpf_lru_node *node)
 	hlist_nulls_for_each_entry_rcu(l, n, head, hash_node)
 		if (l == tgt_l) {
 			hlist_nulls_del_rcu(&l->hash_node);
-			check_and_free_timer(htab, l);
+			check_and_free_timer_and_kptr(htab, l, true);
 			break;
 		}
 
@@ -829,7 +833,7 @@ static void htab_elem_free(struct bpf_htab *htab, struct htab_elem *l)
 {
 	if (htab->map.map_type == BPF_MAP_TYPE_PERCPU_HASH)
 		free_percpu(htab_elem_get_ptr(l, htab->map.key_size));
-	check_and_free_timer(htab, l);
+	check_and_free_timer_and_kptr(htab, l, true);
 	kfree(l);
 }
 
@@ -857,7 +861,7 @@ static void free_htab_elem(struct bpf_htab *htab, struct htab_elem *l)
 	htab_put_fd_value(htab, l);
 
 	if (htab_is_prealloc(htab)) {
-		check_and_free_timer(htab, l);
+		check_and_free_timer_and_kptr(htab, l, true);
 		__pcpu_freelist_push(&htab->freelist, &l->fnode);
 	} else {
 		atomic_dec(&htab->count);
@@ -1104,7 +1108,7 @@ static int htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 		if (!htab_is_prealloc(htab))
 			free_htab_elem(htab, l_old);
 		else
-			check_and_free_timer(htab, l_old);
+			check_and_free_timer_and_kptr(htab, l_old, true);
 	}
 	ret = 0;
 err:
@@ -1114,7 +1118,7 @@ static int htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 
 static void htab_lru_push_free(struct bpf_htab *htab, struct htab_elem *elem)
 {
-	check_and_free_timer(htab, elem);
+	check_and_free_timer_and_kptr(htab, elem, true);
 	bpf_lru_push_free(&htab->lru, &elem->lru_node);
 }
 
@@ -1420,7 +1424,10 @@ static void htab_free_malloced_timers(struct bpf_htab *htab)
 		struct htab_elem *l;
 
 		hlist_nulls_for_each_entry(l, n, head, hash_node)
-			check_and_free_timer(htab, l);
+			/* We don't reset or free kptr on uref dropping to zero,
+			 * hence set free_kptr to false.
+			 */
+			check_and_free_timer_and_kptr(htab, l, false);
 		cond_resched_rcu();
 	}
 	rcu_read_unlock();
@@ -1430,6 +1437,7 @@ static void htab_map_free_timers(struct bpf_map *map)
 {
 	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
 
+	/* We don't reset or free kptr on uref dropping to zero. */
 	if (likely(!map_value_has_timer(&htab->map)))
 		return;
 	if (!htab_is_prealloc(htab))
@@ -1458,6 +1466,7 @@ static void htab_map_free(struct bpf_map *map)
 	else
 		prealloc_destroy(htab);
 
+	bpf_map_free_kptr_off_tab(map);
 	free_percpu(htab->extra_elems);
 	bpf_map_area_free(htab->buckets);
 	for (i = 0; i < HASHTAB_MAP_LOCK_COUNT; i++)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 7b32537bd81f..3901a049fe2a 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -508,8 +508,11 @@ void bpf_map_free_kptr_off_tab(struct bpf_map *map)
 	if (!map_value_has_kptr(map))
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
 	if (!map_value_has_kptr(map))
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
 
@@ -557,15 +574,43 @@ bool bpf_map_equal_kptr_off_tab(const struct bpf_map *map_a, const struct bpf_ma
 	return !memcmp(tab_a, tab_b, size);
 }
 
+/* Caller must ensure map_value_has_kptr is true. Note that this function can be
+ * called on a map value while the map_value is visible to BPF programs, as it
+ * ensures the correct synchronization, and we already enforce the same using
+ * the verifier on the BPF program side, esp. for referenced pointers.
+ */
+void bpf_map_free_kptr(struct bpf_map *map, void *map_value)
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
 	struct bpf_map *map = container_of(work, struct bpf_map, work);
 
 	security_bpf_map_free(map);
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

