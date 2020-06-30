Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6EF20FFC6
	for <lists+bpf@lfdr.de>; Wed,  1 Jul 2020 00:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbgF3WAX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Jun 2020 18:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgF3WAW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Jun 2020 18:00:22 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D4AC03E979
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2020 15:00:22 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f18so21054555wml.3
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2020 15:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZT4eHqjgLgFbZKFz6Fnx3WNj/UXI1/Z0pVKwqarFcV0=;
        b=fRCgUmkrKGY4NUiCGeHxlRFYvoP4oHLkuEi7UxCJZKH0m8LNPSbuqYnA03qm1bSiZn
         SL2VayIjaHDu3FaHilsdLJywPiHnBiDltqzcjwrKJAZLZ0T4W+OHidGzQE06e6lY11mh
         aCt6OhAdjklhbaPCn/6iM3OBvnXRSEvUzP7k0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZT4eHqjgLgFbZKFz6Fnx3WNj/UXI1/Z0pVKwqarFcV0=;
        b=dD7hFXrzTY4TwqKoDkuCJTiZNKJ1HK5mE4VjqqHXzgFFkL+qDSO5mGsB5TBcP7XqCt
         HqMK8ZbYhP60ackrYEWIjBH+Xha6QigB5WBBpoFbzuRy/fyCN407Y+0IGhszKtxtAe5v
         UjuyQfMCTjcsDhQoCBNc9aKXgxS/FTkYqVyCVHWT0hM9pSumzmJo3jqwXx1/TRURezwN
         fwVXekko1VTJ3HFIzNSUraYn7mHaizK76nhci6feY7+wF8v2rP0zFljTxxXAuvkBVjbu
         4+Pi7pW+VOeCL8ELxUyx74pZrCqiTrXmeTgdKBWuO/87LFmSK06F7a5qixUi5X1FK14j
         DZyg==
X-Gm-Message-State: AOAM5323yh835Za1/YD+PFyL9hUGnJaKBRLN+ctrb8ML4xnyH7p3cpQ3
        mVEd9QtlhBSMEDbb9ciqB0Yi7Q==
X-Google-Smtp-Source: ABdhPJwTu6HslTgQfYGxFAVfgvr2yi/bUFHZj8+mi7ueGqmJrYDHJJIbygTqEK6BqVzFXH4VFc3RXA==
X-Received: by 2002:a1c:44d7:: with SMTP id r206mr16032764wma.7.1593554420819;
        Tue, 30 Jun 2020 15:00:20 -0700 (PDT)
Received: from google.com (49.222.77.34.bc.googleusercontent.com. [34.77.222.49])
        by smtp.gmail.com with ESMTPSA id 65sm5285566wma.48.2020.06.30.15.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 15:00:20 -0700 (PDT)
Date:   Tue, 30 Jun 2020 22:00:18 +0000
From:   KP Singh <kpsingh@chromium.org>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf <bpf@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH bpf-next v2 1/4] bpf: Generalize bpf_sk_storage
Message-ID: <CACYkzJ6Vr3TtKQnTrJyB0L47goAMTC0uHoLpsNF8Vo2QySWECw@mail.gmail.com>
References: <20200617202941.3034-1-kpsingh@chromium.org>
 <20200617202941.3034-2-kpsingh@chromium.org>
 <20200619064332.fycpxuegmmkbfe54@kafai-mbp.dhcp.thefacebook.com>
 <20200629160100.GA171259@google.com>
 <20200630193441.kdwnkestulg5erii@kafai-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630193441.kdwnkestulg5erii@kafai-mbp.dhcp.thefacebook.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On Tue, Jun 30, 2020 at 9:35 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Mon, Jun 29, 2020 at 06:01:00PM +0200, KP Singh wrote:
> > > >

[...]

> > > >  static atomic_t cache_idx;
> > > inode local storage and sk local storage probably need a separate
> > > cache_idx.  An improvement on picking cache_idx has just been
> > > landed also.
> >
> > I see, thanks! I rebased and I now see that cache_idx is now a:
> >
> >   static u64 cache_idx_usage_counts[BPF_STORAGE_CACHE_SIZE];
> >
> > which tracks the free cache slots rather than using a single atomic
> > cache_idx. I guess all types of local storage can share this now
> > right?
> I believe they have to be separated.  A sk-storage will not be cached/stored
> in inode.  Caching a sk-storage at idx=0 of a sk should not stop
> an inode-storage to be cached at the same idx of a inode.

Ah yes, I see.

I came up with some macros to solve this. Let me know what you think:
(this is on top of the refactoring I did, so some function names may seem new,
but it should, hopefully, convey the general idea).

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 3067774cc640..1dc2e6d72091 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -79,6 +79,26 @@ struct bpf_local_storage_elem {
 #define SDATA(_SELEM) (&(_SELEM)->sdata)
 #define BPF_STORAGE_CACHE_SIZE	16
 
+u16 bpf_ls_cache_idx_get(spinlock_t *cache_idx_lock,
+			   u64 *cache_idx_usage_count);
+
+void bpf_ls_cache_idx_free(spinlock_t *cache_idx_lock,
+			   u64 *cache_idx_usage_counts, u16 idx);
+
+#define DEFINE_BPF_STORAGE_CACHE(type)					\
+static DEFINE_SPINLOCK(cache_idx_lock_##type);				\
+static u64 cache_idx_usage_counts_##type[BPF_STORAGE_CACHE_SIZE];	\
+static u16 cache_idx_get_##type(void)					\
+{									\
+	return bpf_ls_cache_idx_get(&cache_idx_lock_##type,		\
+				    cache_idx_usage_counts_##type);	\
+}									\
+static void cache_idx_free_##type(u16 idx)				\
+{									\
+	return bpf_ls_cache_idx_free(&cache_idx_lock_##type,		\
+				     cache_idx_usage_counts_##type,	\
+				     idx);				\
+}
 
 /* U16_MAX is much more than enough for sk local storage
  * considering a tcp_sock is ~2k.
@@ -105,13 +125,14 @@ struct bpf_local_storage {
 
 /* Helper functions for bpf_local_storage */
 int bpf_local_storage_map_alloc_check(union bpf_attr *attr);
-struct bpf_map *bpf_local_storage_map_alloc(union bpf_attr *attr);
+struct bpf_local_storage_map *
+bpf_local_storage_map_alloc(union bpf_attr *attr);
 
 struct bpf_local_storage_data *
 bpf_local_storage_lookup(struct bpf_local_storage *local_storage,
 	struct bpf_local_storage_map *smap, bool cacheit_lockit);
 
-void bpf_local_storage_map_free(struct bpf_map *map);
+void bpf_local_storage_map_free(struct bpf_local_storage_map *smap);
 
 int bpf_local_storage_map_check_btf(const struct bpf_map *map,
 	const struct btf *btf, const struct btf_type *key_type,
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index fb589a5715f5..2bc04f8d1e35 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -17,9 +17,6 @@
 	container_of((_SDATA), struct bpf_local_storage_elem, sdata)
 #define SDATA(_SELEM) (&(_SELEM)->sdata)
 
-static DEFINE_SPINLOCK(cache_idx_lock);
-static u64 cache_idx_usage_counts[BPF_STORAGE_CACHE_SIZE];
-
 static struct bucket *select_bucket(struct bpf_local_storage_map *smap,
 				    struct bpf_local_storage_elem *selem)
 {
@@ -460,12 +457,13 @@ static struct bpf_local_storage_data *inode_storage_update(
 					map_flags);
 }
 
-static u16 cache_idx_get(void)
+u16 bpf_ls_cache_idx_get(spinlock_t *cache_idx_lock,
+			 u64 *cache_idx_usage_counts)
 {
 	u64 min_usage = U64_MAX;
 	u16 i, res = 0;
 
-	spin_lock(&cache_idx_lock);
+	spin_lock(cache_idx_lock);
 
 	for (i = 0; i < BPF_STORAGE_CACHE_SIZE; i++) {
 		if (cache_idx_usage_counts[i] < min_usage) {
@@ -479,16 +477,17 @@ static u16 cache_idx_get(void)
 	}
 	cache_idx_usage_counts[res]++;
 
-	spin_unlock(&cache_idx_lock);
+	spin_unlock(cache_idx_lock);
 
 	return res;
 }
 
-static void cache_idx_free(u16 idx)
+void bpf_ls_cache_idx_free(spinlock_t *cache_idx_lock,
+			   u64 *cache_idx_usage_counts, u16 idx)
 {
-	spin_lock(&cache_idx_lock);
+	spin_lock(cache_idx_lock);
 	cache_idx_usage_counts[idx]--;
-	spin_unlock(&cache_idx_lock);
+	spin_unlock(cache_idx_lock);
 }
 
 static int inode_storage_delete(struct inode *inode, struct bpf_map *map)
@@ -552,17 +551,12 @@ void bpf_inode_storage_free(struct inode *inode)
 		kfree_rcu(local_storage, rcu);
 }
 
-void bpf_local_storage_map_free(struct bpf_map *map)
+void bpf_local_storage_map_free(struct bpf_local_storage_map *smap)
 {
 	struct bpf_local_storage_elem *selem;
-	struct bpf_local_storage_map *smap;
 	struct bucket *b;
 	unsigned int i;
 
-	smap = (struct bpf_local_storage_map *)map;
-
-	cache_idx_free(smap->cache_idx);
-
 	/* Note that this map might be concurrently cloned from
 	 * bpf_sk_storage_clone. Wait for any existing bpf_sk_storage_clone
 	 * RCU read section to finish before proceeding. New RCU
@@ -607,7 +601,7 @@ void bpf_local_storage_map_free(struct bpf_map *map)
 	synchronize_rcu();
 
 	kvfree(smap->buckets);
-	kfree(map);
+	kfree(smap);
 }
 
 int bpf_local_storage_map_alloc_check(union bpf_attr *attr)
@@ -629,8 +623,7 @@ int bpf_local_storage_map_alloc_check(union bpf_attr *attr)
 	return 0;
 }
 
-
-struct bpf_map *bpf_local_storage_map_alloc(union bpf_attr *attr)
+struct bpf_local_storage_map *bpf_local_storage_map_alloc(union bpf_attr *attr)
 {
 	struct bpf_local_storage_map *smap;
 	unsigned int i;
@@ -670,9 +663,8 @@ struct bpf_map *bpf_local_storage_map_alloc(union bpf_attr *attr)
 
 	smap->elem_size =
 		sizeof(struct bpf_local_storage_elem) + attr->value_size;
-	smap->cache_idx = cache_idx_get();
 
-	return &smap->map;
+	return smap;
 }
 
 int bpf_local_storage_map_check_btf(const struct bpf_map *map,
@@ -768,11 +760,34 @@ static int notsupp_get_next_key(struct bpf_map *map, void *key,
 	return -ENOTSUPP;
 }
 
+DEFINE_BPF_STORAGE_CACHE(inode);
+
+struct bpf_map *inode_storage_map_alloc(union bpf_attr *attr)
+{
+	struct bpf_local_storage_map *smap;
+
+	smap = bpf_local_storage_map_alloc(attr);
+	if (IS_ERR(smap))
+		return ERR_CAST(smap);
+
+	smap->cache_idx = cache_idx_get_inode();
+	return &smap->map;
+}
+
+void inode_storage_map_free(struct bpf_map *map)
+{
+	struct bpf_local_storage_map *smap;
+
+	smap = (struct bpf_local_storage_map *)map;
+	cache_idx_free_inode(smap->cache_idx);
+	bpf_local_storage_map_free(smap);
+}
+
 static int inode_storage_map_btf_id;
 const struct bpf_map_ops inode_storage_map_ops = {
 	.map_alloc_check = bpf_local_storage_map_alloc_check,
-	.map_alloc = bpf_local_storage_map_alloc,
-	.map_free = bpf_local_storage_map_free,
+	.map_alloc = inode_storage_map_alloc,
+	.map_free = inode_storage_map_free,
 	.map_get_next_key = notsupp_get_next_key,
 	.map_lookup_elem = bpf_inode_storage_lookup_elem,
 	.map_update_elem = bpf_inode_storage_update_elem,
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 0ec44e819bfe..add0340e9ad3 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -396,11 +396,34 @@ static int notsupp_get_next_key(struct bpf_map *map, void *key,
 	return -ENOTSUPP;
 }
 
+DEFINE_BPF_STORAGE_CACHE(sk);
+
+struct bpf_map *sk_storage_map_alloc(union bpf_attr *attr)
+{
+	struct bpf_local_storage_map *smap;
+
+	smap = bpf_local_storage_map_alloc(attr);
+	if (IS_ERR(smap))
+		return ERR_CAST(smap);
+
+	smap->cache_idx = cache_idx_get_sk();
+	return &smap->map;
+}
+
+void sk_storage_map_free(struct bpf_map *map)
+{
+	struct bpf_local_storage_map *smap;
+
+	smap = (struct bpf_local_storage_map *)map;
+	cache_idx_free_sk(smap->cache_idx);
+	bpf_local_storage_map_free(smap);
+}
+
 static int sk_storage_map_btf_id;
 const struct bpf_map_ops sk_storage_map_ops = {
 	.map_alloc_check = bpf_local_storage_map_alloc_check,
-	.map_alloc = bpf_local_storage_map_alloc,
-	.map_free = bpf_local_storage_map_free,
+	.map_alloc = sk_storage_map_alloc,
+	.map_free = sk_storage_map_free,
 	.map_get_next_key = notsupp_get_next_key,
 	.map_lookup_elem = bpf_sk_storage_lookup_elem,
 	.map_update_elem = bpf_sk_storage_update_elem,

>

[...]

> >
> > Sure, I can also keep the sk_clone code their as well for now.
> Just came to my mind.  For easier review purpose, may be
> first do the refactoring/renaming within bpf_sk_storage.c first and
> then create another patch to move the common parts to a new
> file bpf_local_storage.c.
>
> Not sure if it will be indeed easier to read the diff in practice.
> I probably should be able to follow it either way.

Since I already refactored it. I will send the next version with the refactoring
and split done as a part of the Generalize bpf_sk_storage patch.
If it becomes too hard to review, please let me know and I can split it. :)


>
> >
> > >
> > > There is a test in map_tests/sk_storage_map.c, in case you may not notice.
> >
> > I will try to make it generic as a part of this series. If it takes
> > too much time, I will send a separate patch for testing
> > inode_storage_map and till then we have some assurance with
> > test_local_storage in test_progs.
> Sure. no problem.  It is mostly for you to test sk_storage to ensure things ;)
> Also give some ideas on what racing conditions have
> been considered in the sk_storage test and may be the inode storage
> test want to stress similar code path.

Thanks! I ran test_maps and it passes. I will send a separate patch
that generalizes the sk_storage_map.c.

- KP
