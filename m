Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18445502D73
	for <lists+bpf@lfdr.de>; Fri, 15 Apr 2022 18:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243482AbiDOQG7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Apr 2022 12:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355698AbiDOQG6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Apr 2022 12:06:58 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B78C19C37
        for <bpf@vger.kernel.org>; Fri, 15 Apr 2022 09:04:29 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id c12so7432211plr.6
        for <bpf@vger.kernel.org>; Fri, 15 Apr 2022 09:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/zKiJlscsw4aQp8sxENm9IMM+gld4G5atLdGFDzUZfM=;
        b=ITgwdj+pu/gBri/OTmsOae4TkXvzUey3F6V79Ct4fLjgbPUxJRd6QsuPnjG9BFQV0D
         pQzEX+WDOGModxC9rraCVNa1EmpCRMlZEEr/TIbjvaGeyaaAQwyn+cmZOiFAsBqnia72
         FaWauMJpWAKhMtnYJGbWf/szqMT5Wd1vEXprrqlqX14/N66q3ebzT+k4nI40vH1OxGOa
         MLl9gjEz1nd4F91KJThFYu3CEEsJZkH54u0Prg8KJ9F9r1DyONdmgKr3D+lfG6HNhdcH
         C6NibvfOsBr8CAHRdRbUeBfJZmLyik21JUBObxWGv/TA4ovGQEbn4EVIrP/UVJKQMUHJ
         Kkng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/zKiJlscsw4aQp8sxENm9IMM+gld4G5atLdGFDzUZfM=;
        b=5qRdKbeYL/v7EEoA0LEDnDNAvUgL0lc1RJML2NhTSpUJUX+wiMTV1yZNMYrBcXSh59
         val5WWN5juULQ5ixAYv28FHqyFJv/iGWuGTlM6/OgG9qGmFeHNakJ/m6xaXlf8POxEqn
         mz3IMaPk84nSjm8gs2+Ort7tZ9EEXs+E1YtKVpPepMleZ//yh9ryuL0ypU0aBDTf3Qx6
         iMA4zHx6PCSHUMzYrFB6iNtLIaZVKW+sUc1n9E6BC9xCeNM/zzR71RRSZ3fpMgK7X+JS
         Aso5ICCxd4ACjg7mX58hXq1tx9Vn/sJ9eutVxWZC2cvO6d/hCdE0F6rPzT2VhQxSiUEK
         dsaw==
X-Gm-Message-State: AOAM530z2z9EGwN7NvcVg0zZnJ1bMWp/vhAAydEpTmz9WoTYpwp3zkxF
        3o84hoH9dV7DSh3qUGb0aWiWfB39fzs=
X-Google-Smtp-Source: ABdhPJx+XHgGD9Y0Tn/Q3xmQ42xwFkQqSPGT67ma1fSJDLsqUK6rzldtmu6T5kCONKL7chjYa1KNjg==
X-Received: by 2002:a17:902:9a8f:b0:158:acff:ff72 with SMTP id w15-20020a1709029a8f00b00158acffff72mr10991758plp.148.1650038668689;
        Fri, 15 Apr 2022 09:04:28 -0700 (PDT)
Received: from localhost ([112.79.166.196])
        by smtp.gmail.com with ESMTPSA id c7-20020a17090ab28700b001ca9514df81sm4922299pjr.45.2022.04.15.09.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 09:04:28 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH bpf-next v5 07/13] bpf: Adapt copy_map_value for multiple offset case
Date:   Fri, 15 Apr 2022 21:33:48 +0530
Message-Id: <20220415160354.1050687-8-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220415160354.1050687-1-memxor@gmail.com>
References: <20220415160354.1050687-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7761; h=from:subject; bh=4NjXsFAR3amuBnLHB2kfIZ4DtVgtFo4jrn3TKeR86eo=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiWZdCbOnArAwNrplWRuHYNsDjKNhHyo5TWx9mRxic t/tRAB+JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYlmXQgAKCRBM4MiGSL8RyjNbD/ 9+8OaASq1Y9qqqd+VpjFhTdOKNGzV+97H+CBtyWkUxslY1jjnq0jyJPMbsxNc3tXT5px81HnTtTmN7 Ax4fmVcDywcMduTkkA//yJrq6TYBiE48h6N4EtS35U97CLRbWqoDeVAy8ypEoEli2/aK/gTyXKO1eH ablEqfspg6CGhZH0jKMUQh0kBEbxiCcLpT6RWncLt8WX1o2S2uDfxOCqO55nHCwvBzIlirzUChoP7T YNJiQ3cJN7V9BDVmofQWNelQBBSrfvDDOog+jO4HcPvLSoB0XdkUnaw6uRiD6WkZXbPsthsJ06RTEg t0uAN+8p3QiJ/BmAXbmJEgCTD8C1i3eXZPe0SW5RLOsOsk3CL9IY+UTIySzKSn8s/NuysdHQiY6IaS AKwu2vUdJE2NbxL/jq3j/sle3VL04DpemfrZTkuWnKtO6NDlh0yzK68fMo7k+VqBSFyy27o1nm4FXg OnuJv9mEgxzVwfEuQXVH/YLmFLrbxouSL04Pg+vm+FFHQniVfaLGTN0+4dg4rbrh++oYQh3joowDaW Ft/k7oorgWpBUuhp5aKUIx+mxJ2vV9kCsYUoNIrqAwwFjCubEboMYLby2kC7IKFVs8jJzHtybrnsNt ucJ7jtPfXis2EDOHTGiRrpEpyr/MHHPHfZmRLVC+N1v3pD7YAyrrPeFnaUlg==
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

Since now there might be at most 10 offsets that need handling in
copy_map_value, the manual shuffling and special case is no longer going
to work. Hence, let's generalise the copy_map_value function by using
a sorted array of offsets to skip regions that must be avoided while
copying into and out of a map value.

When the map is created, we populate the offset array in struct map,
Then, copy_map_value uses this sorted offset array is used to memcpy
while skipping timer, spin lock, and kptr. The array is allocated as
in most cases none of these special fields would be present in map
value, hence we can save on space for the common case by not embedding
the entire object inside bpf_map struct.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h  | 56 +++++++++++++++-------------
 kernel/bpf/syscall.c | 88 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 117 insertions(+), 27 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 7e2ac2a26bdb..165d2a38eb97 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -158,6 +158,9 @@ struct bpf_map_ops {
 enum {
 	/* Support at most 8 pointers in a BPF map value */
 	BPF_MAP_VALUE_OFF_MAX = 8,
+	BPF_MAP_OFF_ARR_MAX   = BPF_MAP_VALUE_OFF_MAX +
+				1 + /* for bpf_spin_lock */
+				1,  /* for bpf_timer */
 };
 
 enum bpf_map_off_desc_type {
@@ -179,6 +182,12 @@ struct bpf_map_value_off {
 	struct bpf_map_value_off_desc off[];
 };
 
+struct bpf_map_off_arr {
+	u32 cnt;
+	u32 field_off[BPF_MAP_OFF_ARR_MAX];
+	u8 field_sz[BPF_MAP_OFF_ARR_MAX];
+};
+
 struct bpf_map {
 	/* The first two cachelines with read-mostly members of which some
 	 * are also accessed in fast-path (e.g. ops, max_entries).
@@ -207,10 +216,7 @@ struct bpf_map {
 	struct mem_cgroup *memcg;
 #endif
 	char name[BPF_OBJ_NAME_LEN];
-	bool bypass_spec_v1;
-	bool frozen; /* write-once; write-protected by freeze_mutex */
-	/* 6 bytes hole */
-
+	struct bpf_map_off_arr *off_arr;
 	/* The 3rd and 4th cacheline with misc members to avoid false sharing
 	 * particularly with refcounting.
 	 */
@@ -230,6 +236,8 @@ struct bpf_map {
 		bool jited;
 		bool xdp_has_frags;
 	} owner;
+	bool bypass_spec_v1;
+	bool frozen; /* write-once; write-protected by freeze_mutex */
 };
 
 static inline bool map_value_has_spin_lock(const struct bpf_map *map)
@@ -253,37 +261,33 @@ static inline void check_and_init_map_value(struct bpf_map *map, void *dst)
 		memset(dst + map->spin_lock_off, 0, sizeof(struct bpf_spin_lock));
 	if (unlikely(map_value_has_timer(map)))
 		memset(dst + map->timer_off, 0, sizeof(struct bpf_timer));
+	if (unlikely(map_value_has_kptrs(map))) {
+		struct bpf_map_value_off *tab = map->kptr_off_tab;
+		int i;
+
+		for (i = 0; i < tab->nr_off; i++)
+			*(u64 *)(dst + tab->off[i].offset) = 0;
+	}
 }
 
 /* copy everything but bpf_spin_lock and bpf_timer. There could be one of each. */
 static inline void copy_map_value(struct bpf_map *map, void *dst, void *src)
 {
-	u32 s_off = 0, s_sz = 0, t_off = 0, t_sz = 0;
+	u32 curr_off = 0;
+	int i;
 
-	if (unlikely(map_value_has_spin_lock(map))) {
-		s_off = map->spin_lock_off;
-		s_sz = sizeof(struct bpf_spin_lock);
-	}
-	if (unlikely(map_value_has_timer(map))) {
-		t_off = map->timer_off;
-		t_sz = sizeof(struct bpf_timer);
+	if (likely(!map->off_arr)) {
+		memcpy(dst, src, map->value_size);
+		return;
 	}
 
-	if (unlikely(s_sz || t_sz)) {
-		if (s_off < t_off || !s_sz) {
-			swap(s_off, t_off);
-			swap(s_sz, t_sz);
-		}
-		memcpy(dst, src, t_off);
-		memcpy(dst + t_off + t_sz,
-		       src + t_off + t_sz,
-		       s_off - t_off - t_sz);
-		memcpy(dst + s_off + s_sz,
-		       src + s_off + s_sz,
-		       map->value_size - s_off - s_sz);
-	} else {
-		memcpy(dst, src, map->value_size);
+	for (i = 0; i < map->off_arr->cnt; i++) {
+		u32 next_off = map->off_arr->field_off[i];
+
+		memcpy(dst + curr_off, src + curr_off, next_off - curr_off);
+		curr_off += map->off_arr->field_sz[i];
 	}
+	memcpy(dst + curr_off, src + curr_off, map->value_size - curr_off);
 }
 void copy_map_value_locked(struct bpf_map *map, void *dst, void *src,
 			   bool lock_src);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index fba49f390ed5..1b1497b94303 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -30,6 +30,7 @@
 #include <linux/pgtable.h>
 #include <linux/bpf_lsm.h>
 #include <linux/poll.h>
+#include <linux/sort.h>
 #include <linux/bpf-netns.h>
 #include <linux/rcupdate_trace.h>
 #include <linux/memcontrol.h>
@@ -561,6 +562,7 @@ static void bpf_map_free_deferred(struct work_struct *work)
 	struct bpf_map *map = container_of(work, struct bpf_map, work);
 
 	security_bpf_map_free(map);
+	kfree(map->off_arr);
 	bpf_map_free_kptr_off_tab(map);
 	bpf_map_release_memcg(map);
 	/* implementation dependent freeing */
@@ -850,6 +852,84 @@ int map_check_no_btf(const struct bpf_map *map,
 	return -ENOTSUPP;
 }
 
+static int map_off_arr_cmp(const void *_a, const void *_b, const void *priv)
+{
+	const u32 a = *(const u32 *)_a;
+	const u32 b = *(const u32 *)_b;
+
+	if (a < b)
+		return -1;
+	else if (a > b)
+		return 1;
+	return 0;
+}
+
+static void map_off_arr_swap(void *_a, void *_b, int size, const void *priv)
+{
+	struct bpf_map *map = (struct bpf_map *)priv;
+	u32 *off_base = map->off_arr->field_off;
+	u32 *a = _a, *b = _b;
+	u8 *sz_a, *sz_b;
+
+	sz_a = map->off_arr->field_sz + (a - off_base);
+	sz_b = map->off_arr->field_sz + (b - off_base);
+
+	swap(*a, *b);
+	swap(*sz_a, *sz_b);
+}
+
+static int bpf_map_alloc_off_arr(struct bpf_map *map)
+{
+	bool has_spin_lock = map_value_has_spin_lock(map);
+	bool has_timer = map_value_has_timer(map);
+	bool has_kptrs = map_value_has_kptrs(map);
+	struct bpf_map_off_arr *off_arr;
+	u32 i;
+
+	if (!has_spin_lock && !has_timer && !has_kptrs) {
+		map->off_arr = NULL;
+		return 0;
+	}
+
+	off_arr = kmalloc(sizeof(*map->off_arr), GFP_KERNEL | __GFP_NOWARN);
+	if (!off_arr)
+		return -ENOMEM;
+	map->off_arr = off_arr;
+
+	off_arr->cnt = 0;
+	if (has_spin_lock) {
+		i = off_arr->cnt;
+
+		off_arr->field_off[i] = map->spin_lock_off;
+		off_arr->field_sz[i] = sizeof(struct bpf_spin_lock);
+		off_arr->cnt++;
+	}
+	if (has_timer) {
+		i = off_arr->cnt;
+
+		off_arr->field_off[i] = map->timer_off;
+		off_arr->field_sz[i] = sizeof(struct bpf_timer);
+		off_arr->cnt++;
+	}
+	if (has_kptrs) {
+		struct bpf_map_value_off *tab = map->kptr_off_tab;
+		u32 *off = &off_arr->field_off[off_arr->cnt];
+		u8 *sz = &off_arr->field_sz[off_arr->cnt];
+
+		for (i = 0; i < tab->nr_off; i++) {
+			*off++ = tab->off[i].offset;
+			*sz++ = sizeof(u64);
+		}
+		off_arr->cnt += tab->nr_off;
+	}
+
+	if (off_arr->cnt == 1)
+		return 0;
+	sort_r(off_arr->field_off, off_arr->cnt, sizeof(off_arr->field_off[0]),
+	       map_off_arr_cmp, map_off_arr_swap, map);
+	return 0;
+}
+
 static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 			 u32 btf_key_id, u32 btf_value_id)
 {
@@ -1019,10 +1099,14 @@ static int map_create(union bpf_attr *attr)
 			attr->btf_vmlinux_value_type_id;
 	}
 
-	err = security_bpf_map_alloc(map);
+	err = bpf_map_alloc_off_arr(map);
 	if (err)
 		goto free_map;
 
+	err = security_bpf_map_alloc(map);
+	if (err)
+		goto free_map_off_arr;
+
 	err = bpf_map_alloc_id(map);
 	if (err)
 		goto free_map_sec;
@@ -1045,6 +1129,8 @@ static int map_create(union bpf_attr *attr)
 
 free_map_sec:
 	security_bpf_map_free(map);
+free_map_off_arr:
+	kfree(map->off_arr);
 free_map:
 	btf_put(map->btf);
 	map->ops->map_free(map);
-- 
2.35.1

