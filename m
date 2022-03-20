Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453F74E1C68
	for <lists+bpf@lfdr.de>; Sun, 20 Mar 2022 16:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245410AbiCTP5I (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Mar 2022 11:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245415AbiCTP5I (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Mar 2022 11:57:08 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9687454196
        for <bpf@vger.kernel.org>; Sun, 20 Mar 2022 08:55:44 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id kx5-20020a17090b228500b001c6ed9db871so2161214pjb.1
        for <bpf@vger.kernel.org>; Sun, 20 Mar 2022 08:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T4H7pdnq3bwIteVvOoef2KNTqot/e0QuKMYjkx98YRQ=;
        b=f0hCRfMFQb7KSLcoxODvZTGTS7VE/lgAP9C/qokvpRVn/0voMzSa80wObrOuLhe+xS
         w5TpwOSSRmA1DFYvWxtXAlhQlOyHUcR9ZZe0NSDS9ZbX4dAc+kjm5DCqtsvhn/WqMymS
         bA6blBLLoOJqH7Ys1//L9Z+Fugza2cqm2dxmDGodyxDbH50b0wsfrLWqPL5EaxA9nqKr
         EGDfmHRoVHbtyWJhwDieZrrW+4gm22V5VpgDyALVEvhcNwt1rdgl+MfpXsjGjNiSuM20
         qg2NKMnq3RKkTJHwcbE35DdgXa9reFnPYEzUoIxBVz0It0U83OzReZHro6nps14IsgYI
         cc/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T4H7pdnq3bwIteVvOoef2KNTqot/e0QuKMYjkx98YRQ=;
        b=MMd+cTlxmAfDxI6wPjGmHx89FsY4P68PbHxH+tosgAWxi7wNWK0kixYrl3DQnOWpZM
         qNyf0TYp38prWN76U5N5M9BG4UbfleweyL1pj1yCEcIJVSWMa4PwuRllFlVdkPyI3Zp0
         9vYBDTl/sZfHZ6ReqCdgf2mrc7i5P9AaLvNrMOgVZPV8YanLff1hdgXiLwBjtsLeFdGY
         i9rdZzR+XlUEiUm5UD2Ae0r5cdDKuzPQzAKGaK5o9hVOi2MfKObAJf1DPW6axBRCoePh
         BSdoygV3/uIXqPz/Z51hJ6VlZKdPQ7aLu/SEy+aVV6Jjufpy1hQNfmgt7pmah+MGXReo
         EZSg==
X-Gm-Message-State: AOAM533lLjzlM4MpIDJWyoExgvH2tMOHcMcxIMEgSUSjaT3NawYF/s9E
        wbuoO+tOAp1ezLgtIQ8p+Ti/PPn0rYo=
X-Google-Smtp-Source: ABdhPJyMqc8xr60dW3bA8rY5mclUBAK4eSVgElu1mJHrYkLq7N4kPeApezhVkH90MLXRiEwVsFLYlw==
X-Received: by 2002:a17:90b:3508:b0:1c6:e4f9:538b with SMTP id ls8-20020a17090b350800b001c6e4f9538bmr6889826pjb.158.1647791743962;
        Sun, 20 Mar 2022 08:55:43 -0700 (PDT)
Received: from localhost ([14.139.187.71])
        by smtp.gmail.com with ESMTPSA id j16-20020a63e750000000b00373598b8cbfsm12270941pgk.74.2022.03.20.08.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 08:55:43 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH bpf-next v3 07/13] bpf: Adapt copy_map_value for multiple offset case
Date:   Sun, 20 Mar 2022 21:25:04 +0530
Message-Id: <20220320155510.671497-8-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220320155510.671497-1-memxor@gmail.com>
References: <20220320155510.671497-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5763; h=from:subject; bh=RxLjSvyKuEdkZl4+p5jTlytjnaAo9SXxwcUKkicAGLU=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiN00yX8y4Sla0T5nPy9taGtCoNFvohxuugwzlLQyv bSSs7UaJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYjdNMgAKCRBM4MiGSL8Ryv69EA CIzGDRc0WZLX1ejlFp3uxvXeDG5rPn/r4FEdOAWILqGZy95qPk//mqYlSdLTMHUJ4cDBCTArxl+zc6 ieNy58mXIj7Gfm7awZFGbCawE/xjZc5qRVdQ+RlgXSgo4bHn9kQJML5sO61EavzeYQ03Vmp628V+IF s0+llBGY3265ApZ7nChNVIzcUtmB9laSyI39XLkzgLk4uEKe299u3Ywk0U1NLvrsvQWrdNn2PELdsZ ph3ivFeVLK1ArOEzElThQ4kRtEiVQQT/FW6pukBYP1SlgEaP8h0yk/ZfwXc/kH/DNcjgTQGdpbmVae FBlJcFl0Car0Q6Zd/84ARGCP6yQrmvUma7LOc5NLFnHmKd+0j1gcbfygmjaKuDcFduviVBVil3BwSg Rq+q2U+CJijiPhEauBQ9X5pAK10UDncAjw5YyQ5YYepZxqh7Jfos88kZnfxYM0fqjQhQPUewy5hYr+ RaiQhLVsWtjvwbuJFKH9X/amttRhLnIDKEOkRfOAen2RK6VlyVMagg6/8hHVJv7BFAKsVymgxNP3dC vyl0PmFX1LhnmFHPeEzod7lqnJk8z5czeu1HTRBRvTVVevGohHkUF3gO1JMpfMOQudl80UlXBp2uuE yKi3L0wTAjJvv3Z7mjUvcZURnHUfqykD2cVfsydgOIGHOkAr0bPgybJOsAMA==
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
 include/linux/bpf.h  | 55 +++++++++++++++++++++++---------------------
 kernel/bpf/syscall.c | 52 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+), 26 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 9d424d567dd3..6474d2d44b78 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -158,6 +158,10 @@ struct bpf_map_ops {
 enum {
 	/* Support at most 8 pointers in a BPF map value */
 	BPF_MAP_VALUE_OFF_MAX = 8,
+	BPF_MAP_OFF_ARR_MAX   = BPF_MAP_VALUE_OFF_MAX +
+				1 + /* for bpf_spin_lock */
+				1 + /* for bpf_timer */
+				1,  /* for map->value_size sentinel */
 };
 
 enum {
@@ -206,9 +210,17 @@ struct bpf_map {
 	char name[BPF_OBJ_NAME_LEN];
 	bool bypass_spec_v1;
 	bool frozen; /* write-once; write-protected by freeze_mutex */
-	/* 6 bytes hole */
-
-	/* The 3rd and 4th cacheline with misc members to avoid false sharing
+	/* 2 bytes hole */
+	struct {
+		struct {
+			u32 off;
+			u8 sz;
+		} field[BPF_MAP_OFF_ARR_MAX];
+		u32 cnt;
+	} off_arr;
+	/* 40 bytes hole */
+
+	/* The 4th and 5th cacheline with misc members to avoid false sharing
 	 * particularly with refcounting.
 	 */
 	atomic64_t refcnt ____cacheline_aligned;
@@ -250,36 +262,27 @@ static inline void check_and_init_map_value(struct bpf_map *map, void *dst)
 		memset(dst + map->spin_lock_off, 0, sizeof(struct bpf_spin_lock));
 	if (unlikely(map_value_has_timer(map)))
 		memset(dst + map->timer_off, 0, sizeof(struct bpf_timer));
+	if (unlikely(map_value_has_kptr(map))) {
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
+	int i;
 
-	if (unlikely(map_value_has_spin_lock(map))) {
-		s_off = map->spin_lock_off;
-		s_sz = sizeof(struct bpf_spin_lock);
-	}
-	if (unlikely(map_value_has_timer(map))) {
-		t_off = map->timer_off;
-		t_sz = sizeof(struct bpf_timer);
-	}
+	memcpy(dst, src, map->off_arr.field[0].off);
+	for (i = 1; i < map->off_arr.cnt; i++) {
+		u32 curr_off = map->off_arr.field[i - 1].off;
+		u32 next_off = map->off_arr.field[i].off;
 
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
+		curr_off += map->off_arr.field[i - 1].sz;
+		memcpy(dst + curr_off, src + curr_off, next_off - curr_off);
 	}
 }
 void copy_map_value_locked(struct bpf_map *map, void *dst, void *src,
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 5990d6fa97ab..7b32537bd81f 100644
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
@@ -851,6 +852,55 @@ int map_check_no_btf(const struct bpf_map *map,
 	return -ENOTSUPP;
 }
 
+static int map_off_arr_cmp(const void *_a, const void *_b)
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
+static void map_populate_off_arr(struct bpf_map *map)
+{
+	u32 i;
+
+	map->off_arr.cnt = 0;
+	if (map_value_has_spin_lock(map)) {
+		i = map->off_arr.cnt;
+
+		map->off_arr.field[i].off = map->spin_lock_off;
+		map->off_arr.field[i].sz = sizeof(struct bpf_spin_lock);
+		map->off_arr.cnt++;
+	}
+	if (map_value_has_timer(map)) {
+		i = map->off_arr.cnt;
+
+		map->off_arr.field[i].off = map->timer_off;
+		map->off_arr.field[i].sz = sizeof(struct bpf_timer);
+		map->off_arr.cnt++;
+	}
+	if (map_value_has_kptr(map)) {
+		struct bpf_map_value_off *tab = map->kptr_off_tab;
+		u32 j = map->off_arr.cnt;
+
+		for (i = 0; i < tab->nr_off; i++) {
+			map->off_arr.field[j + i].off = tab->off[i].offset;
+			map->off_arr.field[j + i].sz = sizeof(u64);
+		}
+		map->off_arr.cnt += tab->nr_off;
+	}
+
+	map->off_arr.field[map->off_arr.cnt++].off = map->value_size;
+	if (map->off_arr.cnt == 1)
+		return;
+	sort(map->off_arr.field, map->off_arr.cnt, sizeof(map->off_arr.field[0]),
+	     map_off_arr_cmp, NULL);
+}
+
 static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 			 u32 btf_key_id, u32 btf_value_id)
 {
@@ -1018,6 +1068,8 @@ static int map_create(union bpf_attr *attr)
 			attr->btf_vmlinux_value_type_id;
 	}
 
+	map_populate_off_arr(map);
+
 	err = security_bpf_map_alloc(map);
 	if (err)
 		goto free_map;
-- 
2.35.1

