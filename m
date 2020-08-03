Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6142C23AAC7
	for <lists+bpf@lfdr.de>; Mon,  3 Aug 2020 18:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgHCQrE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Aug 2020 12:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbgHCQrD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Aug 2020 12:47:03 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2038DC061756
        for <bpf@vger.kernel.org>; Mon,  3 Aug 2020 09:47:03 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id c16so18954026ejx.12
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2020 09:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jWq9xcPzW6zE3flBBT8XSejw7BvbFb4qcCI1YOHOcdw=;
        b=fUmAv+zLS1DA3w/OwtMY93vb/ZKmDkFHEvUEl2PqV1CTegCFfqEvHgGaU2UGLIoBmC
         l/foLmE8WU+DoaU+6MdB5meXgquG3eW+OpeycdMjWJwAeeIlQjFLwaBQ2ZFEg3aiJrPQ
         CmdW0HOFfAfEDA/P48OTzlt/GCUTrOKcMUODA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jWq9xcPzW6zE3flBBT8XSejw7BvbFb4qcCI1YOHOcdw=;
        b=NtcuSTI9QZ9a3oadA41Qxb7ExnsUYN+UTo43PVYmx0jEXsAMuZa8QFjohL8WjRMPwQ
         D6PrMoa8Tyay6oQXJSyPuRv5OcqTmnfgesOtHqyslYNyQE1PCpDcB1fX78NESUjwBUsi
         lGAFhVHPCHVCQD4C0DDVC+T6bqRREFfYFXnb3jqPNfiAr1emeC8xLIr/asy/8f+Wt2cb
         z78kutdXDez7AFKmjIfD/1SzoAhimJVsgcFySESHPNXbsCF9/iVEZ2eYkJcVbUyPtS1p
         /8zVz6QJSrLtbfhPwjbAhb4+CcJsTU2ap6j1tK4TQQ5fLsOekbGVDmfeyvSdlEgKMB5x
         bDAg==
X-Gm-Message-State: AOAM530yB0cJZPKCxA99qtDQqeTJC3gFGTRLpBRP/2fviNi+FdUSdniF
        C/0FifJSYolMTvVpan6wrWg3AenJxvCFaQ==
X-Google-Smtp-Source: ABdhPJz/uXQnos/O0vtYFwc9AMsUhFFntpklC4ORHSvtTXVGzLxfZijgfm/ny+6STyjJhad1wqPMGg==
X-Received: by 2002:a17:906:fc26:: with SMTP id ov38mr16574597ejb.99.1596473221690;
        Mon, 03 Aug 2020 09:47:01 -0700 (PDT)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id j7sm16385654ejb.64.2020.08.03.09.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 09:47:00 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v8 2/7] bpf: Generalize caching for sk_storage.
Date:   Mon,  3 Aug 2020 18:46:50 +0200
Message-Id: <20200803164655.1924498-3-kpsingh@chromium.org>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
In-Reply-To: <20200803164655.1924498-1-kpsingh@chromium.org>
References: <20200803164655.1924498-1-kpsingh@chromium.org>
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
2.28.0.163.g6104cc2f0b6-goog

