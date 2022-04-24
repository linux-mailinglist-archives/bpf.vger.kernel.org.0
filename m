Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE02550D560
	for <lists+bpf@lfdr.de>; Sun, 24 Apr 2022 23:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239678AbiDXVwN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 24 Apr 2022 17:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235710AbiDXVwN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 24 Apr 2022 17:52:13 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF37644DF
        for <bpf@vger.kernel.org>; Sun, 24 Apr 2022 14:49:10 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id c23so22965862plo.0
        for <bpf@vger.kernel.org>; Sun, 24 Apr 2022 14:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T0amIKjI58dxUW4m7C20Er9a2WKh1LNljilqcsfhQQ0=;
        b=awt9hBHC+x4R8ydfrFYLrg/LGfri5wu5uye+6lkom/FOn03nurx6fANCyv+POFVS5r
         LuTMUn+o6jUTAyfn4Q+zgzy/MISxsPovpB9A9jsSFes7dB5++UlC8k9FiasnQF43p9xx
         VzBf9txZJ4eZZJPaHEP7uOps3Wl6VH5IA5tLfs3oEJb8trJLr4/q/m17EMkchQubotna
         UxwxXJecQAGPfNRCl8LYMZfI50HYXHz8UhSxsM7MgKvEyEKrkAR6v+gvXi6ctQ6GA3LV
         ipX4USAGMZNrsPBvcHEbCdhDg9BaxXQwG8GgM5oEd9V61MkFGGQVh4uhCAkxkceV2ZGt
         HwYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T0amIKjI58dxUW4m7C20Er9a2WKh1LNljilqcsfhQQ0=;
        b=YdeB4eT3GRKWgwaJ3krlgGhToGLGyebz0ouLhI/YK2jDYBE55xSoOFN0ELn/dTBBIK
         X2x/eZDsQcLCPohR22D7MyS0nOAy2MLpLpvlNd0GEF7H5gM8J73NjT0SKJqAuR6ZAKKf
         sRex1vzP0QnnIPm+w/8opaFwVK57JSbg9Lywmz2b0YxV/wqGAaLl1C0jx0l9GrtPiXgy
         FAYGLtNHofxZtXrtRN9AkjmQmQOIBN58GVum0hwQrsNxBHX0F0wY+uscDKAjlyH9gvUD
         FZId/3lGMR98pFR/ZXwKJNTIc0YBED5STmwlJLg/rDXFVvJtu08w2M/eAPIOdXqx2PhQ
         8wVQ==
X-Gm-Message-State: AOAM532vLK9xE25SL3gLJ7S0ax/NKVSP8EwkDTJN4Wy5pA4g8E2VqVKH
        6OsX0xO9l+FlEOuDAf6GDFIxR3Yp1cg=
X-Google-Smtp-Source: ABdhPJwlMshcW2dxX+3ZM71Ddxd7EOiFGRADO2Dsys0Bgdg2okNCUBg58O3AiK0ueLmzEzvewo5dTw==
X-Received: by 2002:a17:90a:9109:b0:1cb:a814:8947 with SMTP id k9-20020a17090a910900b001cba8148947mr27688810pjo.52.1650836949892;
        Sun, 24 Apr 2022 14:49:09 -0700 (PDT)
Received: from localhost ([157.49.66.127])
        by smtp.gmail.com with ESMTPSA id m16-20020a17090ade1000b001d25dfb9d39sm1900312pjv.14.2022.04.24.14.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 14:49:09 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH bpf-next v6 07/13] bpf: Wire up freeing of referenced kptr
Date:   Mon, 25 Apr 2022 03:18:55 +0530
Message-Id: <20220424214901.2743946-8-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220424214901.2743946-1-memxor@gmail.com>
References: <20220424214901.2743946-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=16817; h=from:subject; bh=dxezxrDSmLURno5XzgVe2+U9NmU2RBlJ/WPrZDdO1oM=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiZcTLiOhwwNCQKfoXTj2wZQkQZbAhLi7tHReSZkJw ss3CRjmJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYmXEywAKCRBM4MiGSL8RykasD/ 9tX4bK8oDsSCejs0kf8Qv+L0CZ5gTszMm8ijk4Hh2q3kLwp0HBV6wsDQ8QfRFbjswKIrulbUzRrSyE E4EMbKPHXPvJrNiepesAzJhM4WbEWkObopmz6TRi9VKS4o7MNh6ZpP1o4wShtkfRyQd54hGvqzIwam rC/Ayq5okKHFGtdpkqou9Ohg+JS2zbk2Q1Xi7AmQ/7pck4nEyJLn2KUuclP3R9s48Co3lABFZOMcad B55H5GTzwk6rijfENgGlTI6C+ov/iYq4yG1XmaNc8h0uYFrxgz4VrBDx+5wdkSzVMlDB9gPJ8d0cFs e7+KFyZ6M6DSqVshRz5ain61A2zW2lqYnZj+UU2JnqEO4pC1JJSezIquHKw6B4XXPv3Z9QOxYPVj0h R6cyCZFwK7E7g1Qu4JTRnj7NmUMBCR90HjdFZoCD0Xwcuow3gfjcVO0WAznb65lo1Lp3YvUWHjj9Vb mYoJW1dCqJoSz08QBzJv3hSuThDHlEaf+aSyZrOQcM512h6k5risEQkZNZmkfMn59XtVT7qZNia1h0 1evWasFDVuemhW3ulCauFMJ/Sm2F0QhxnDDAf6mCzBS8twEjdDQIpLAs+IaOVPM5PecVr6saPIpW0R bntxoGTBJ0VqLDO6sK0S9q6MkQe2IXJhOmZT+dVOIJOrvOeF8k8Y3b96leYg==
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
 kernel/bpf/arraymap.c | 18 ++++++--
 kernel/bpf/btf.c      | 98 ++++++++++++++++++++++++++++++++++++++++++-
 kernel/bpf/hashtab.c  | 64 +++++++++++++++++++++-------
 kernel/bpf/syscall.c  | 49 ++++++++++++++++++++--
 6 files changed, 210 insertions(+), 25 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4e12b27a5de6..6141564c76c8 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -23,6 +23,7 @@
 #include <linux/slab.h>
 #include <linux/percpu-refcount.h>
 #include <linux/bpfptr.h>
+#include <linux/btf.h>
 
 struct bpf_verifier_env;
 struct bpf_verifier_log;
@@ -173,6 +174,8 @@ struct bpf_map_value_off_desc {
 	enum bpf_kptr_type type;
 	struct {
 		struct btf *btf;
+		struct module *module;
+		btf_dtor_kfunc_t dtor;
 		u32 btf_id;
 	} kptr;
 };
@@ -1447,6 +1450,7 @@ struct bpf_map_value_off_desc *bpf_map_kptr_off_contains(struct bpf_map *map, u3
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
index 7f145aefbff8..c3de63ce574e 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -287,10 +287,12 @@ static int array_map_get_next_key(struct bpf_map *map, void *key, void *next_key
 	return 0;
 }
 
-static void check_and_free_timer_in_array(struct bpf_array *arr, void *val)
+static void check_and_free_fields(struct bpf_array *arr, void *val)
 {
-	if (unlikely(map_value_has_timer(&arr->map)))
+	if (map_value_has_timer(&arr->map))
 		bpf_timer_cancel_and_free(val + arr->map.timer_off);
+	if (map_value_has_kptrs(&arr->map))
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
@@ -386,7 +388,8 @@ static void array_map_free_timers(struct bpf_map *map)
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
 	int i;
 
-	if (likely(!map_value_has_timer(map)))
+	/* We don't reset or free kptr on uref dropping to zero. */
+	if (!map_value_has_timer(map))
 		return;
 
 	for (i = 0; i < array->map.max_entries; i++)
@@ -398,6 +401,13 @@ static void array_map_free_timers(struct bpf_map *map)
 static void array_map_free(struct bpf_map *map)
 {
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
+	int i;
+
+	if (map_value_has_kptrs(map)) {
+		for (i = 0; i < array->map.max_entries; i++)
+			bpf_map_free_kptrs(map, array->value + array->elem_size * i);
+		bpf_map_free_kptr_off_tab(map);
+	}
 
 	if (array->map.map_type == BPF_MAP_TYPE_PERCPU_ARRAY)
 		bpf_array_free_percpu(array);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index a0b1665a4a48..1f2012fd89fb 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3416,6 +3416,7 @@ struct bpf_map_value_off *btf_parse_kptrs(const struct btf *btf,
 	struct btf_field_info info_arr[BPF_MAP_VALUE_OFF_MAX];
 	struct bpf_map_value_off *tab;
 	struct btf *kernel_btf = NULL;
+	struct module *mod = NULL;
 	int ret, i, nr_off;
 
 	ret = btf_find_field(btf, t, BTF_FIELD_KPTR, info_arr, ARRAY_SIZE(info_arr));
@@ -3444,16 +3445,69 @@ struct bpf_map_value_off *btf_parse_kptrs(const struct btf *btf,
 			goto end;
 		}
 
+		/* Find and stash the function pointer for the destruction function that
+		 * needs to be eventually invoked from the map free path.
+		 */
+		if (info_arr[i].type == BPF_KPTR_REF) {
+			const struct btf_type *dtor_func;
+			const char *dtor_func_name;
+			unsigned long addr;
+			s32 dtor_btf_id;
+
+			/* This call also serves as a whitelist of allowed objects that
+			 * can be used as a referenced pointer and be stored in a map at
+			 * the same time.
+			 */
+			dtor_btf_id = btf_find_dtor_kfunc(kernel_btf, id);
+			if (dtor_btf_id < 0) {
+				ret = dtor_btf_id;
+				goto end_btf;
+			}
+
+			dtor_func = btf_type_by_id(kernel_btf, dtor_btf_id);
+			if (!dtor_func) {
+				ret = -ENOENT;
+				goto end_btf;
+			}
+
+			if (btf_is_module(kernel_btf)) {
+				mod = btf_try_get_module(kernel_btf);
+				if (!mod) {
+					ret = -ENXIO;
+					goto end_btf;
+				}
+			}
+
+			/* We already verified dtor_func to be btf_type_is_func
+			 * in register_btf_id_dtor_kfuncs.
+			 */
+			dtor_func_name = __btf_name_by_offset(kernel_btf, dtor_func->name_off);
+			addr = kallsyms_lookup_name(dtor_func_name);
+			if (!addr) {
+				ret = -EINVAL;
+				goto end_mod;
+			}
+			tab->off[i].kptr.dtor = (void *)addr;
+		}
+
 		tab->off[i].offset = info_arr[i].off;
 		tab->off[i].type = info_arr[i].type;
 		tab->off[i].kptr.btf_id = id;
 		tab->off[i].kptr.btf = kernel_btf;
+		tab->off[i].kptr.module = mod;
 	}
 	tab->nr_off = nr_off;
 	return tab;
+end_mod:
+	module_put(mod);
+end_btf:
+	btf_put(kernel_btf);
 end:
-	while (i--)
+	while (i--) {
 		btf_put(tab->off[i].kptr.btf);
+		if (tab->off[i].kptr.module)
+			module_put(tab->off[i].kptr.module);
+	}
 	kfree(tab);
 	return ERR_PTR(ret);
 }
@@ -7111,6 +7165,43 @@ s32 btf_find_dtor_kfunc(struct btf *btf, u32 btf_id)
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
@@ -7141,6 +7232,11 @@ int register_btf_id_dtor_kfuncs(const struct btf_id_dtor_kfunc *dtors, u32 add_c
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
index c68fbebc8c00..7351e61bd683 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -238,7 +238,7 @@ static void htab_free_prealloced_timers(struct bpf_htab *htab)
 	u32 num_entries = htab->map.max_entries;
 	int i;
 
-	if (likely(!map_value_has_timer(&htab->map)))
+	if (!map_value_has_timer(&htab->map))
 		return;
 	if (htab_has_extra_elems(htab))
 		num_entries += num_possible_cpus();
@@ -254,6 +254,25 @@ static void htab_free_prealloced_timers(struct bpf_htab *htab)
 	}
 }
 
+static void htab_free_prealloced_kptrs(struct bpf_htab *htab)
+{
+	u32 num_entries = htab->map.max_entries;
+	int i;
+
+	if (!map_value_has_kptrs(&htab->map))
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
-	if (unlikely(map_value_has_timer(&htab->map)))
-		bpf_timer_cancel_and_free(elem->key +
-					  round_up(htab->map.key_size, 8) +
-					  htab->map.timer_off);
+	void *map_value = elem->key + round_up(htab->map.key_size, 8);
+
+	if (map_value_has_timer(&htab->map))
+		bpf_timer_cancel_and_free(map_value + htab->map.timer_off);
+	if (map_value_has_kptrs(&htab->map))
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
@@ -1430,7 +1458,8 @@ static void htab_map_free_timers(struct bpf_map *map)
 {
 	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
 
-	if (likely(!map_value_has_timer(&htab->map)))
+	/* We don't reset or free kptr on uref dropping to zero. */
+	if (!map_value_has_timer(&htab->map))
 		return;
 	if (!htab_is_prealloc(htab))
 		htab_free_malloced_timers(htab);
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
index 4d419a3effc4..e0aead17dff4 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -507,8 +507,11 @@ void bpf_map_free_kptr_off_tab(struct bpf_map *map)
 
 	if (!map_value_has_kptrs(map))
 		return;
-	for (i = 0; i < tab->nr_off; i++)
+	for (i = 0; i < tab->nr_off; i++) {
+		if (tab->off[i].kptr.module)
+			module_put(tab->off[i].kptr.module);
 		btf_put(tab->off[i].kptr.btf);
+	}
 	kfree(tab);
 	map->kptr_off_tab = NULL;
 }
@@ -525,8 +528,18 @@ struct bpf_map_value_off *bpf_map_copy_kptr_off_tab(const struct bpf_map *map)
 	if (!new_tab)
 		return ERR_PTR(-ENOMEM);
 	/* Do a deep copy of the kptr_off_tab */
-	for (i = 0; i < tab->nr_off; i++)
+	for (i = 0; i < tab->nr_off; i++) {
 		btf_get(tab->off[i].kptr.btf);
+		if (tab->off[i].kptr.module && !try_module_get(tab->off[i].kptr.module)) {
+			while (i--) {
+				if (tab->off[i].kptr.module)
+					module_put(tab->off[i].kptr.module);
+				btf_put(tab->off[i].kptr.btf);
+			}
+			kfree(new_tab);
+			return ERR_PTR(-ENXIO);
+		}
+	}
 	return new_tab;
 }
 
@@ -546,6 +559,33 @@ bool bpf_map_equal_kptr_off_tab(const struct bpf_map *map_a, const struct bpf_ma
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
+		if (off_desc->type == BPF_KPTR_UNREF) {
+			u64 *p = (u64 *)btf_id_ptr;
+
+			WRITE_ONCE(p, 0);
+			continue;
+		}
+		old_ptr = xchg(btf_id_ptr, 0);
+		off_desc->kptr.dtor((void *)old_ptr);
+	}
+}
+
 /* called from workqueue */
 static void bpf_map_free_deferred(struct work_struct *work)
 {
@@ -553,9 +593,10 @@ static void bpf_map_free_deferred(struct work_struct *work)
 
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

