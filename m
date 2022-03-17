Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9B24DC55C
	for <lists+bpf@lfdr.de>; Thu, 17 Mar 2022 13:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233304AbiCQMBz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Mar 2022 08:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbiCQMBy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Mar 2022 08:01:54 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7576A180205
        for <bpf@vger.kernel.org>; Thu, 17 Mar 2022 05:00:38 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id e13so4260743plh.3
        for <bpf@vger.kernel.org>; Thu, 17 Mar 2022 05:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LRfwtizGo5opgZZb7U54UsHzhcwLuWkNo1YXQ3d8L2A=;
        b=otW3hxb8zZXHfnUbXyRwB8j7XC/dlQRI2DKlGRV1sQhgKhsaxUeYb1CXslTV8aR9mp
         y9xWM/nRZ7haU4fWgLPVIXhXnmFhLZlukSAupbhY4881SGOgYtxuu+D1dyMYU4Wo9RgK
         qauQ9sTL1NhvcjfplQB4gMeNgkk+S86neTCDo63XYhGOwVGWwAwv8D+QSEHWoI4wkXOF
         F5y8XRuo2j8kyyUZMZTpcLRp5blvVyluuz3YjPIJGEHoQmp25RW+n3DHc6yjpJA1Qa6D
         sGBVq68HXz9FWXejuH+nmWOYVxqgNAuXnXr/JHjFlwxp9Hwnv8pVicfmCpEMtHqbOyTS
         nk3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LRfwtizGo5opgZZb7U54UsHzhcwLuWkNo1YXQ3d8L2A=;
        b=jABVUq9SIk0jiGMHnJFi6eIHHiXdnO42XmxOpnxeQJ/2mzF7l4kWVZbMBSWIYWjq1A
         mshBc5CZuw+oo/FgJiNGUn/JQt7cEszFfSsIvPi/obidGqmL/ErDNZFj9IriXZOEwCLa
         i9NcNqKEwTtPjbyCJkEe2yZJR3ZlqvGFXeCFIycd9G6sVHIbLdGq6Rjy0N/W6Fhk7OHK
         UH34VYkpchSHA71obXjRA7FCWDGGDTDntBW63X5GZ7uteYdibDWf8k5dyb0I4I5Nkobl
         Hq8enYPqafbIqy1z7NbRcKihOZcyBqlMhp6M+qrBGufVmPwRgaVBHOEaB9EZX+gR7p/t
         QB9g==
X-Gm-Message-State: AOAM530rJ1cZk73bkRq7xsutfWn1drLfLJp+xa8vVQUhSctA59WF55qx
        mzMqgOJdvevmuIBFNEzhmGX+5xK1LfM=
X-Google-Smtp-Source: ABdhPJxe3HCc98tHQL3cn1gDRzF4T3IpcaRE0n3K6sbtpp8NTUWmDRUbVhFV5HAjee0nqIxvflHbEg==
X-Received: by 2002:a17:903:1c9:b0:152:af89:5c97 with SMTP id e9-20020a17090301c900b00152af895c97mr4808491plh.52.1647518437546;
        Thu, 17 Mar 2022 05:00:37 -0700 (PDT)
Received: from localhost ([157.51.20.101])
        by smtp.gmail.com with ESMTPSA id d2-20020a056a0024c200b004f6b6817549sm7032044pfv.173.2022.03.17.05.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 05:00:37 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH bpf-next v2 08/15] bpf: Adapt copy_map_value for multiple offset case
Date:   Thu, 17 Mar 2022 17:29:50 +0530
Message-Id: <20220317115957.3193097-9-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220317115957.3193097-1-memxor@gmail.com>
References: <20220317115957.3193097-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5892; h=from:subject; bh=XzKckFcAoEpntyLgPdR9OSWkdPjjfJU0k/Mz7S/iZaM=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiMyKjlONjdAOmw76hF5ueeTVHMj9a0pTZANVTfF1H Z9V+WA+JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYjMiowAKCRBM4MiGSL8RyhojD/ 9DxAZDeH1zw1qSiwNHRMNMuav1uX3bx+BK5+8V+9tcXiRy39IUvpbRWoRb3B9Y7B9jbpP3bjseWHaA M/yBP1tj2O/KmNHI7rEAbtXeX+y8ZNCJKljnpXWtzPuEF2pl8bseGR+850c1HwKmN4RuDmX2enHwID 8EH0C0liPoTsvFQwBOFSgzq51OU/knAp6/Wat8HEAQfNvTOPGBGolLNV/DJQk9SqBOY8U1ePi9fLfJ zCAQ7eFiNtOVHb7c7HdqlyYwttJ1bKioSQpX2edgyzPWAtukBiUV1i5W6MAl0psB3Cxl1Zyy2k/T1l o5GVKxq33eCJ/OopDYt/ptZO2qr3KSUv4Ut464APagol7/4YJZIq/dVXx/PvdEmSO6q07o8vcbyzBZ vV9PXzWRMHb/rXEiv58dOVkkazihJ3+sKuTyuym67oit6XQLWoRlf1UcomB489oxEdO0YDal+OEczO 3d/bq8gFMQWOgUlHNVAqhsnzPSmHrIB5CfP4N1dP2D6ZiNR2vJNjK+rlZUWh88Q4AhLRIVO7E0BULG 2x0RxdkQPe4W8Swv2EhxkK+zPYinT1W9eMpxy/Y9RH+KwpdvB7q7vQHmei9iqQZq0ViHpxXsq1kaOm FUrg/rsWTRb9X4YTqiKGIZS6Vsnujhn07dpkLH7yW+JKHjHfSxB0V05XYhzQ==
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
offset to subtract previous offset from. Since there can only be three
sizes, we can avoid recording the size in the struct map, and only store
sorted offsets. Later we can determine the size for each offset by
comparing it to timer_off and spin_lock_off, otherwise it must be
sizeof(u64) for kptr.

Then, copy_map_value uses this sorted offset array is used to memcpy
while skipping timer, spin lock, and kptr.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h  | 59 +++++++++++++++++++++++++-------------------
 kernel/bpf/syscall.c | 47 +++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+), 26 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 8ac3070aa5e6..f0f1e0d3bb2e 100644
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
@@ -208,7 +212,12 @@ struct bpf_map {
 	char name[BPF_OBJ_NAME_LEN];
 	bool bypass_spec_v1;
 	bool frozen; /* write-once; write-protected by freeze_mutex */
-	/* 6 bytes hole */
+	/* 2 bytes hole */
+	struct {
+		u32 off[BPF_MAP_OFF_ARR_MAX];
+		u32 cnt;
+	} off_arr;
+	/* 20 bytes hole */
 
 	/* The 3rd and 4th cacheline with misc members to avoid false sharing
 	 * particularly with refcounting.
@@ -252,36 +261,34 @@ static inline void check_and_init_map_value(struct bpf_map *map, void *dst)
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
-
-	if (unlikely(map_value_has_spin_lock(map))) {
-		s_off = map->spin_lock_off;
-		s_sz = sizeof(struct bpf_spin_lock);
-	}
-	if (unlikely(map_value_has_timer(map))) {
-		t_off = map->timer_off;
-		t_sz = sizeof(struct bpf_timer);
-	}
-
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
+	int i;
+
+	memcpy(dst, src, map->off_arr.off[0]);
+	for (i = 1; i < map->off_arr.cnt; i++) {
+		u32 curr_off = map->off_arr.off[i - 1];
+		u32 next_off = map->off_arr.off[i];
+		u32 curr_sz;
+
+		if (map_value_has_spin_lock(map) && map->spin_lock_off == curr_off)
+			curr_sz = sizeof(struct bpf_spin_lock);
+		else if (map_value_has_timer(map) && map->timer_off == curr_off)
+			curr_sz = sizeof(struct bpf_timer);
+		else
+			curr_sz = sizeof(u64);
+		curr_off += curr_sz;
+		memcpy(dst + curr_off, src + curr_off, next_off - curr_off);
 	}
 }
 void copy_map_value_locked(struct bpf_map *map, void *dst, void *src,
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 87263b07f40b..69e8ea1be432 100644
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
@@ -850,6 +851,50 @@ int map_check_no_btf(const struct bpf_map *map,
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
+		map->off_arr.off[i] = map->spin_lock_off;
+		map->off_arr.cnt++;
+	}
+	if (map_value_has_timer(map)) {
+		i = map->off_arr.cnt;
+
+		map->off_arr.off[i] = map->timer_off;
+		map->off_arr.cnt++;
+	}
+	if (map_value_has_kptr(map)) {
+		struct bpf_map_value_off *tab = map->kptr_off_tab;
+		u32 j = map->off_arr.cnt;
+
+		for (i = 0; i < tab->nr_off; i++)
+			map->off_arr.off[j + i] = tab->off[i].offset;
+		map->off_arr.cnt += tab->nr_off;
+	}
+
+	map->off_arr.off[map->off_arr.cnt++] = map->value_size;
+	if (map->off_arr.cnt == 1)
+		return;
+	sort(map->off_arr.off, map->off_arr.cnt, sizeof(map->off_arr.off[0]), map_off_arr_cmp, NULL);
+}
+
 static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 			 u32 btf_key_id, u32 btf_value_id)
 {
@@ -1015,6 +1060,8 @@ static int map_create(union bpf_attr *attr)
 			attr->btf_vmlinux_value_type_id;
 	}
 
+	map_populate_off_arr(map);
+
 	err = security_bpf_map_alloc(map);
 	if (err)
 		goto free_map;
-- 
2.35.1

