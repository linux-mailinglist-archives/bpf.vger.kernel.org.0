Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE9A3251F0F
	for <lists+bpf@lfdr.de>; Tue, 25 Aug 2020 20:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgHYSaC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Aug 2020 14:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbgHYS31 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Aug 2020 14:29:27 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009A0C061755
        for <bpf@vger.kernel.org>; Tue, 25 Aug 2020 11:29:26 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id dp2so12570011ejc.4
        for <bpf@vger.kernel.org>; Tue, 25 Aug 2020 11:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7EGajeDiJIxrlPr3Y0NRvAuPtl3AEsFbIm2NTrH6ZEc=;
        b=jDfTkfnuojbMaFUK6N1gavlgXoz0UOitqddOW0kO7XGsBtyCIdWvVGP4Ali167FpVl
         +8fZXzYunItxxegZYSeFNDr+lSOHwnPn/FI8sdZL/Jmm+9TIQS005cX+6+E9SOoujGw1
         aSz2+ffiizsI2Lg0F9RC26uoeZVLjUSIq012E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7EGajeDiJIxrlPr3Y0NRvAuPtl3AEsFbIm2NTrH6ZEc=;
        b=r7ZaFq/pOfXIFcmpjFfA9BD5F+wwlaChsqKvv1aPppE0lXejv2ra/z75RsdK2wNZUp
         kX+ba6NbLNvLx9p+xS2DrVg4xnJg2HV9o9LfZJFnnyEQIYMkMhKuoTsb6LV+noK4rkRq
         z9YFhOuKWzIFZjV5EGlC1JI6YW35gyYWRMjFyEmIy2qGLZ8AalbVqgusbCsI3nXpRq3N
         bj4X+qVcTEPwBbUfmg289xVSdcEfC90wcodGxMPluXZJWPgeyGKTwT+5tACVzKUpCkdU
         v1SHfbS6UIz0b4FW6oHMNe6PCo9wyA2yin2hn6n1enVcIyYrgXBGbppW/h8QlhtMHrFs
         jyNw==
X-Gm-Message-State: AOAM532kfC7CW5awQTCewZrXbxXTubyXU0bEtkN5SidXBYy0dsz7TZuP
        Bo3LcL5N8jgmkYKKkawQKJFB+A==
X-Google-Smtp-Source: ABdhPJxwWmTdSKRTZoliBYv1yxoma3Uae22mPp0EOYaM+udhulIxdQLSMBipzg5LcWTHCcC3UvKnbg==
X-Received: by 2002:a17:906:4f11:: with SMTP id t17mr8838115eju.371.1598380165443;
        Tue, 25 Aug 2020 11:29:25 -0700 (PDT)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id dr21sm15323286ejc.112.2020.08.25.11.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 11:29:24 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v10 2/7] bpf: Generalize caching for sk_storage.
Date:   Tue, 25 Aug 2020 20:29:14 +0200
Message-Id: <20200825182919.1118197-3-kpsingh@chromium.org>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
In-Reply-To: <20200825182919.1118197-1-kpsingh@chromium.org>
References: <20200825182919.1118197-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

Provide the a ability to define local storage caches on a per-object
type basis. The caches and caching indices for different objects should
not be inter-mixed as suggested in:

  https://lore.kernel.org/bpf/20200630193441.kdwnkestulg5erii@kafai-mbp.dhcp.thefacebook.com/

  "Caching a sk-storage at idx=0 of a sk should not stop an
  inode-storage to be cached at the same idx of a inode."

Acked-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: KP Singh <kpsingh@google.com>
---
 include/net/bpf_sk_storage.h | 19 +++++++++++++++++++
 net/core/bpf_sk_storage.c    | 31 +++++++++++++++----------------
 2 files changed, 34 insertions(+), 16 deletions(-)

diff --git a/include/net/bpf_sk_storage.h b/include/net/bpf_sk_storage.h
index 5036c94c0503..950c5aaba15e 100644
--- a/include/net/bpf_sk_storage.h
+++ b/include/net/bpf_sk_storage.h
@@ -3,6 +3,9 @@
 #ifndef _BPF_SK_STORAGE_H
 #define _BPF_SK_STORAGE_H
 
+#include <linux/types.h>
+#include <linux/spinlock.h>
+
 struct sock;
 
 void bpf_sk_storage_free(struct sock *sk);
@@ -15,6 +18,22 @@ struct sk_buff;
 struct nlattr;
 struct sock;
 
+#define BPF_LOCAL_STORAGE_CACHE_SIZE	16
+
+struct bpf_local_storage_cache {
+	spinlock_t idx_lock;
+	u64 idx_usage_counts[BPF_LOCAL_STORAGE_CACHE_SIZE];
+};
+
+#define DEFINE_BPF_STORAGE_CACHE(name)				\
+static struct bpf_local_storage_cache name = {			\
+	.idx_lock = __SPIN_LOCK_UNLOCKED(name.idx_lock),	\
+}
+
+u16 bpf_local_storage_cache_idx_get(struct bpf_local_storage_cache *cache);
+void bpf_local_storage_cache_idx_free(struct bpf_local_storage_cache *cache,
+				      u16 idx);
+
 #ifdef CONFIG_BPF_SYSCALL
 int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk);
 struct bpf_sk_storage_diag *
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index f975e2d01207..ec61ee7c7ee4 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -14,6 +14,8 @@
 
 #define BPF_LOCAL_STORAGE_CREATE_FLAG_MASK (BPF_F_NO_PREALLOC | BPF_F_CLONE)
 
+DEFINE_BPF_STORAGE_CACHE(sk_cache);
+
 struct bpf_local_storage_map_bucket {
 	struct hlist_head list;
 	raw_spinlock_t lock;
@@ -78,10 +80,6 @@ struct bpf_local_storage_elem {
 #define SELEM(_SDATA)							\
 	container_of((_SDATA), struct bpf_local_storage_elem, sdata)
 #define SDATA(_SELEM) (&(_SELEM)->sdata)
-#define BPF_LOCAL_STORAGE_CACHE_SIZE	16
-
-static DEFINE_SPINLOCK(cache_idx_lock);
-static u64 cache_idx_usage_counts[BPF_LOCAL_STORAGE_CACHE_SIZE];
 
 struct bpf_local_storage {
 	struct bpf_local_storage_data __rcu *cache[BPF_LOCAL_STORAGE_CACHE_SIZE];
@@ -521,16 +519,16 @@ static int sk_storage_delete(struct sock *sk, struct bpf_map *map)
 	return 0;
 }
 
-static u16 cache_idx_get(void)
+u16 bpf_local_storage_cache_idx_get(struct bpf_local_storage_cache *cache)
 {
 	u64 min_usage = U64_MAX;
 	u16 i, res = 0;
 
-	spin_lock(&cache_idx_lock);
+	spin_lock(&cache->idx_lock);
 
 	for (i = 0; i < BPF_LOCAL_STORAGE_CACHE_SIZE; i++) {
-		if (cache_idx_usage_counts[i] < min_usage) {
-			min_usage = cache_idx_usage_counts[i];
+		if (cache->idx_usage_counts[i] < min_usage) {
+			min_usage = cache->idx_usage_counts[i];
 			res = i;
 
 			/* Found a free cache_idx */
@@ -538,18 +536,19 @@ static u16 cache_idx_get(void)
 				break;
 		}
 	}
-	cache_idx_usage_counts[res]++;
+	cache->idx_usage_counts[res]++;
 
-	spin_unlock(&cache_idx_lock);
+	spin_unlock(&cache->idx_lock);
 
 	return res;
 }
 
-static void cache_idx_free(u16 idx)
+void bpf_local_storage_cache_idx_free(struct bpf_local_storage_cache *cache,
+				      u16 idx)
 {
-	spin_lock(&cache_idx_lock);
-	cache_idx_usage_counts[idx]--;
-	spin_unlock(&cache_idx_lock);
+	spin_lock(&cache->idx_lock);
+	cache->idx_usage_counts[idx]--;
+	spin_unlock(&cache->idx_lock);
 }
 
 /* Called by __sk_destruct() & bpf_sk_storage_clone() */
@@ -601,7 +600,7 @@ static void bpf_local_storage_map_free(struct bpf_map *map)
 
 	smap = (struct bpf_local_storage_map *)map;
 
-	cache_idx_free(smap->cache_idx);
+	bpf_local_storage_cache_idx_free(&sk_cache, smap->cache_idx);
 
 	/* Note that this map might be concurrently cloned from
 	 * bpf_sk_storage_clone. Wait for any existing bpf_sk_storage_clone
@@ -718,7 +717,7 @@ static struct bpf_map *bpf_local_storage_map_alloc(union bpf_attr *attr)
 
 	smap->elem_size =
 		sizeof(struct bpf_local_storage_elem) + attr->value_size;
-	smap->cache_idx = cache_idx_get();
+	smap->cache_idx = bpf_local_storage_cache_idx_get(&sk_cache);
 
 	return &smap->map;
 }
-- 
2.28.0.297.g1956fa8f8d-goog

