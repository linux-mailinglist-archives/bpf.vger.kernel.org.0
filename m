Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF2C2333CE
	for <lists+bpf@lfdr.de>; Thu, 30 Jul 2020 16:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbgG3OH1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Jul 2020 10:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729280AbgG3OH0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Jul 2020 10:07:26 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F064C061757
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2020 07:07:25 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k20so6313427wmi.5
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2020 07:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wg0kUSEGrXJMBnS7RgbBCsvy47iqb2tGJq2KYVpzp4k=;
        b=jvJv6yv6xw2Jt9XFRvVkb3uVw/3MnlSFZoSU57KuYryVkW5Qt16DX5ASNRWVB1imJd
         LCuiiB4KD795O/OGiWAohtAJgpioTiLJpJv2SBRIz0XpaOEPNrorUeMMAGTUQD1zDT8E
         ftT4KTIUlr287/LdTtbJh78IKSbyJb4hm4laI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wg0kUSEGrXJMBnS7RgbBCsvy47iqb2tGJq2KYVpzp4k=;
        b=ZqwZLjruogW92q8rnsd13mZK96PGl+VmuwncINf5xJTHvXKIUHHTkJVMHlOSxHdxAB
         hIq68U9xH+FTSwGeQW1hv/FimydUengmnDRTCQ9nvxwaO6gCp5BHNr52KGe6T2XCYCzy
         LMPBwLNSh2MitNqLjg0Nj0O68G876x5US8Cj/c34gOyqMz473iYPs+KEhIOYjKMKp0S7
         Dw910OomCJWIWUKDVMlb0PKHIqj5WiH3/Cf7pEOaK9qnjJ1vNzPaFlTcYkM01/+yAZxK
         YNn7unvrUDwlLPvbb1BoV/CXLAKKLKkzHjE842hdJcgwIThdyhSqYXVvhTjGQsjboEeU
         yIig==
X-Gm-Message-State: AOAM531fpVuX622fbzo4WMhgYsDmrfae3tyfmXxa1u+wq/JwhCypIpGs
        CqcYtQUL8ZOMo5tmoEkAerFi8w==
X-Google-Smtp-Source: ABdhPJwKmxyL+HXR/Ui+uT+uL2doJSlN+dfZt76rDaYOmw4WSo1ziMuCfc4EcPFbtA1OTmIOu6zoWQ==
X-Received: by 2002:a1c:5f41:: with SMTP id t62mr14230359wmb.134.1596118044164;
        Thu, 30 Jul 2020 07:07:24 -0700 (PDT)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id a10sm19088599wmd.3.2020.07.30.07.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 07:07:23 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v7 2/7] bpf: Generalize caching for sk_storage.
Date:   Thu, 30 Jul 2020 16:07:11 +0200
Message-Id: <20200730140716.404558-3-kpsingh@chromium.org>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
In-Reply-To: <20200730140716.404558-1-kpsingh@chromium.org>
References: <20200730140716.404558-1-kpsingh@chromium.org>
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
index a5cc218834ee..99dde7b74767 100644
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
@@ -517,16 +515,16 @@ static int sk_storage_delete(struct sock *sk, struct bpf_map *map)
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
@@ -534,18 +532,19 @@ static u16 cache_idx_get(void)
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
@@ -597,7 +596,7 @@ static void bpf_local_storage_map_free(struct bpf_map *map)
 
 	smap = (struct bpf_local_storage_map *)map;
 
-	cache_idx_free(smap->cache_idx);
+	bpf_local_storage_cache_idx_free(&sk_cache, smap->cache_idx);
 
 	/* Note that this map might be concurrently cloned from
 	 * bpf_sk_storage_clone. Wait for any existing bpf_sk_storage_clone
@@ -713,7 +712,7 @@ static struct bpf_map *bpf_local_storage_map_alloc(union bpf_attr *attr)
 	}
 
 	smap->elem_size = sizeof(struct bpf_local_storage_elem) + attr->value_size;
-	smap->cache_idx = cache_idx_get();
+	smap->cache_idx = bpf_local_storage_cache_idx_get(&sk_cache);
 
 	return &smap->map;
 }
-- 
2.28.0.rc0.142.g3c755180ce-goog

