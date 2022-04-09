Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3734FA67A
	for <lists+bpf@lfdr.de>; Sat,  9 Apr 2022 11:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236598AbiDIJf3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 9 Apr 2022 05:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiDIJf2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 9 Apr 2022 05:35:28 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D011127
        for <bpf@vger.kernel.org>; Sat,  9 Apr 2022 02:33:21 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id a42so3913761pfx.7
        for <bpf@vger.kernel.org>; Sat, 09 Apr 2022 02:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7CM23jzrrfQFydfrjhjub2XHsWDZpEMs5jJIBM5UDNE=;
        b=FCurSajzCMPNJpMIvf/KRVF3WivNnAoe1Fy5EiOTSl8ImwwrqUGQ2ysbeR73jLs/mO
         yTIJrhVGK8CKmTxyIbLFTZX85xkpdOLgse+Q42O2j548BJxKxGG7EfMJF5DYdl6vs6fS
         Kk5sQqFRxucXWQ2RrGkysT+onCxBIuEjzcVweeXxu87zMC9JhFrJJepH6OdhdqEepbwq
         GnTa4TG/Bx0hnufcfO5M+qjVVnICGzkTDm57ln0L9//zHjtcrSc3vDEtbjVWyhMp5jPK
         OLR7osB3/egnws1yIb3sATkrcTZ3wEHSdN0kTjGuzZPNDGAtWv4IfWQ/CbaRCFqOaU9+
         Pa1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7CM23jzrrfQFydfrjhjub2XHsWDZpEMs5jJIBM5UDNE=;
        b=EKtRieme0UWNTHeeaHfBdjaemx4DWliqyHJybnn55L1ZBxH+6B7DiT0RRGam3qShDv
         I+Uxo5QC1+8/+84qdvydFErFegmeLijvnRUSOVrl1OnBO3AdbhpDsGbjirhk5LXtTTP0
         nvIrpxVtrpDg/uslZNTVYleI4eS1JdIePtt6KyXqkOEOKmxwne1QZPpnBx7cPjK3LkFF
         dtm3vdzILJ52/9j3TUZ77dWtpFE5roBliio6GfXjjdBPcU4gzRUHzexi0/3r0q+cnIPs
         Vy+uIIDAuESeYaSbybcBuOqdSNAVIBVLUBOhka+PGUYjjOx2HB2l+ljlCI0Xq9UadK07
         RknA==
X-Gm-Message-State: AOAM533wv1X0GF5zMadfH8n9i26GOfPS0WIXXDvn84CD9yMdxwaklG/J
        Ma2/W5NhDCfLDH61FHBeFQeIZKylg1Y=
X-Google-Smtp-Source: ABdhPJwyQxGoKUZ2CZKCIyJWcmZ1IzW9VhEfGkvKDoPxXoPidMC2bpmrjubyh8N5Wkb5qd5vFIMoJg==
X-Received: by 2002:a05:6a02:28a:b0:385:f767:34f4 with SMTP id bk10-20020a056a02028a00b00385f76734f4mr19094856pgb.299.1649496801101;
        Sat, 09 Apr 2022 02:33:21 -0700 (PDT)
Received: from localhost ([112.79.142.148])
        by smtp.gmail.com with ESMTPSA id s10-20020a63a30a000000b003987eaef296sm24125715pge.44.2022.04.09.02.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 02:33:20 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH bpf-next v4 07/13] bpf: Adapt copy_map_value for multiple offset case
Date:   Sat,  9 Apr 2022 15:02:57 +0530
Message-Id: <20220409093303.499196-8-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220409093303.499196-1-memxor@gmail.com>
References: <20220409093303.499196-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7645; h=from:subject; bh=U4CrtjyWi2X6CiGW/Dw6U/6bcylUEZ4rBW0fwJG+DuQ=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiUVF0ewHDT8nWwKlH5JkMbNMccmzgqIKHg1jOwuCQ FAqI3C2JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYlFRdAAKCRBM4MiGSL8Ryq9gEA CY3F/YBoNPWWEmhBpsHyNBhijXCfz7A0gluc2FxLJjbESOBgbAwNODp3dEZHVrobuOPUqeVQsVjZRF XEN9JRifR7jwWljH/EcfqBKhx8GTLQLyJBFuauZWk1+Zofz2RAp0DKD0tUHMSJVRJSVEHzBp9235n2 D2nZnDn4sS8JMojt0fTL4dtuxU5W/2RSdIg2fJi3vSlhyi31zm+/L+HuRxXXi9vknPwAGfvlIqw7Ye +FlAF5aKwgsjbSkkT4fJVjGGdKIlHw2TpV7js0L7ZV1Hkrab6yzxhnD6NpXpf8MyCU5xbhB+d6RQsV hd1BezDb79fb8wXRMp0T0LWp8xzJGMs6MsY7Z/yxrxxZvgEPiumaoZhSGHLaNOE0fGWfh6CBaCSCH/ fGvwgVJW8H+ZGO7ImtSByLJgk/Z6Ca0JUK9GBkTWBetTHMRmAbQKwc46SfjyKqFyt1cYY/nIJA6m1h 9r5M57whbfN9MLrvEBJ0rsYFmMQZ1yctzQdYHDhCdtR+b2gl+u08ZNFPSZ0MFxmbbfB/CJeX+a6Edj HGE5jwxPHT4lz73HkAOZJRq03zx72xHzY3kjAAwLUxjLGmaJKpVmd9GnfVWx84iQZTTLh9mH6HsNe8 JFWlixorCkuY204lGEYRuIg95nuRWjgr819Fq8YEgWZVrxzRHXRg6mbHXK7Q==
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
with one extra element for map->value_size, which is used as the final
offset to subtract previous offset from. Then, copy_map_value uses this
sorted offset array is used to memcpy while skipping timer, spin lock,
and kptr.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h  | 56 +++++++++++++++-------------
 kernel/bpf/syscall.c | 88 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 117 insertions(+), 27 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index e9791ecafa5d..bd79132c664d 100644
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
 
 enum {
@@ -176,6 +179,12 @@ struct bpf_map_value_off {
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
@@ -204,10 +213,7 @@ struct bpf_map {
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
@@ -227,6 +233,8 @@ struct bpf_map {
 		bool jited;
 		bool xdp_has_frags;
 	} owner;
+	bool bypass_spec_v1;
+	bool frozen; /* write-once; write-protected by freeze_mutex */
 };
 
 static inline bool map_value_has_spin_lock(const struct bpf_map *map)
@@ -250,37 +258,33 @@ static inline void check_and_init_map_value(struct bpf_map *map, void *dst)
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
index edfe691284b0..481d5bb06203 100644
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
@@ -562,6 +563,7 @@ static void bpf_map_free_deferred(struct work_struct *work)
 	struct bpf_map *map = container_of(work, struct bpf_map, work);
 
 	security_bpf_map_free(map);
+	kfree(map->off_arr);
 	bpf_map_free_kptr_off_tab(map);
 	bpf_map_release_memcg(map);
 	/* implementation dependent freeing */
@@ -851,6 +853,84 @@ int map_check_no_btf(const struct bpf_map *map,
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
@@ -1020,10 +1100,14 @@ static int map_create(union bpf_attr *attr)
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
@@ -1046,6 +1130,8 @@ static int map_create(union bpf_attr *attr)
 
 free_map_sec:
 	security_bpf_map_free(map);
+free_map_off_arr:
+	kfree(map->off_arr);
 free_map:
 	btf_put(map->btf);
 	map->ops->map_free(map);
-- 
2.35.1

