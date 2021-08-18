Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2A43F0ED9
	for <lists+bpf@lfdr.de>; Thu, 19 Aug 2021 01:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235429AbhHRXxA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Aug 2021 19:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235279AbhHRXw5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Aug 2021 19:52:57 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A829AC061764
        for <bpf@vger.kernel.org>; Wed, 18 Aug 2021 16:52:21 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id f3-20020a25cf030000b029055a2303fc2dso4676513ybg.11
        for <bpf@vger.kernel.org>; Wed, 18 Aug 2021 16:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dNzVzG00YuL9BPubaFReOEmMNwvCEpVxzU7LeS/yc5w=;
        b=K4KV3UcU5YxbQ1Qg4BbCZXyoiODQYzv/uqz/faq2JQf1e/KVZI3U0R9m9Fxdx0cff5
         CasFwoKrR4WBAQ0c1TZOVIxk2/4CfUyMDZnvs1nX55Sw8SSdweXNid0r5FBSSM25VhGo
         oOobBVGTZZUqlxkX17PTJ2yB+NafV4zRdCTDf7auL4Whh+/QXXyw3rrvTnLA1EMxeWvK
         ttSHlFLBsRNeL9vQ3JTMSk/UJX2XS6z+FZPdLl2XJXQj8pDuopwXpSzTWXPG0/ZJFLfK
         2RVIHCw3Bs3wbYUuQaMeqy7XnK4ZWpMDSrnl/MJJcG3c/Z2TTh6xh1cTMdUm8EW0jTsC
         aPQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dNzVzG00YuL9BPubaFReOEmMNwvCEpVxzU7LeS/yc5w=;
        b=Ev+DnYD52I8HcpTK9+307kUKQvW4x87dv7cY0040uNTy7fl+aGHNj9+E5jrUDiYn7j
         +EeNms672/O6WYZ9fwPQ4mYg0btk+L2RAtoHwLe3TDGO2qsHHGzaVRI7mRwyFtE9l0zH
         J0CZpo47L51T5h2cFK3/wJIUXb05RsnYcrIZotP+MV88YsB9K2gNYpF6q6fXn2Gi6De8
         nlLHxtXvZ35o8TC7wla6wqpPBYxpAC38a8y2WSeXl4RPRHIulWPjAKCn4jvqbb5O/dps
         +vFdcE/PH229BB1WKMjGYmxhLoM7Zg1KKy0YuXriMfYuQrRoYvPz4pBVVto2XKKBopbW
         Kt0Q==
X-Gm-Message-State: AOAM531By5qR1XkzzXCj2sNjC/PS3b7tAp+DHtu4HcbMJ80o60fk5f8a
        BvfZsvO0M0mzGB7bxqkblHkfgRY=
X-Google-Smtp-Source: ABdhPJwq/fLcYMJf7f4rPMWxBqhc4/YvPJqHBBwjUW1EphvmK0ERzdTWW/WB1aCVUWqjUYZoZtij67Q=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:201:7401:ef23:e119:5cbc])
 (user=sdf job=sendgmr) by 2002:a25:420b:: with SMTP id p11mr15255535yba.377.1629330740916;
 Wed, 18 Aug 2021 16:52:20 -0700 (PDT)
Date:   Wed, 18 Aug 2021 16:52:16 -0700
In-Reply-To: <20210818235216.1159202-1-sdf@google.com>
Message-Id: <20210818235216.1159202-2-sdf@google.com>
Mime-Version: 1.0
References: <20210818235216.1159202-1-sdf@google.com>
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [PATCH bpf-next v3 2/2] bpf: use kvmalloc for map keys in syscalls
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        Stanislav Fomichev <sdf@google.com>,
        Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Same as previous patch but for the keys. memdup_bpfptr is renamed
to kvmemdup_bpfptr (and converted to kvmalloc).

v3:
* kvmemdup_bpfptr and copy_from_bpfptr (Daniel Borkmann)

Signed-off-by: Stanislav Fomichev <sdf@google.com>
Acked-by: Song Liu <songliubraving@fb.com>
---
 include/linux/bpfptr.h | 12 ++++++++++--
 kernel/bpf/syscall.c   | 34 +++++++++++++++++-----------------
 2 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/include/linux/bpfptr.h b/include/linux/bpfptr.h
index 5cdeab497cb3..546e27fc6d46 100644
--- a/include/linux/bpfptr.h
+++ b/include/linux/bpfptr.h
@@ -62,9 +62,17 @@ static inline int copy_to_bpfptr_offset(bpfptr_t dst, size_t offset,
 	return copy_to_sockptr_offset((sockptr_t) dst, offset, src, size);
 }
 
-static inline void *memdup_bpfptr(bpfptr_t src, size_t len)
+static inline void *kvmemdup_bpfptr(bpfptr_t src, size_t len)
 {
-	return memdup_sockptr((sockptr_t) src, len);
+	void *p = kvmalloc(len, GFP_USER | __GFP_NOWARN);
+
+	if (!p)
+		return ERR_PTR(-ENOMEM);
+	if (copy_from_bpfptr(p, src, len)) {
+		kvfree(p);
+		return ERR_PTR(-EFAULT);
+	}
+	return p;
 }
 
 static inline long strncpy_from_bpfptr(char *dst, bpfptr_t src, size_t count)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 075f650d297a..4e50c0bfdb7d 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1013,7 +1013,7 @@ int __weak bpf_stackmap_copy(struct bpf_map *map, void *key, void *value)
 static void *__bpf_copy_key(void __user *ukey, u64 key_size)
 {
 	if (key_size)
-		return memdup_user(ukey, key_size);
+		return vmemdup_user(ukey, key_size);
 
 	if (ukey)
 		return ERR_PTR(-EINVAL);
@@ -1024,7 +1024,7 @@ static void *__bpf_copy_key(void __user *ukey, u64 key_size)
 static void *___bpf_copy_key(bpfptr_t ukey, u64 key_size)
 {
 	if (key_size)
-		return memdup_bpfptr(ukey, key_size);
+		return kvmemdup_bpfptr(ukey, key_size);
 
 	if (!bpfptr_is_null(ukey))
 		return ERR_PTR(-EINVAL);
@@ -1093,7 +1093,7 @@ static int map_lookup_elem(union bpf_attr *attr)
 free_value:
 	kvfree(value);
 free_key:
-	kfree(key);
+	kvfree(key);
 err_put:
 	fdput(f);
 	return err;
@@ -1153,7 +1153,7 @@ static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
 free_value:
 	kvfree(value);
 free_key:
-	kfree(key);
+	kvfree(key);
 err_put:
 	fdput(f);
 	return err;
@@ -1205,7 +1205,7 @@ static int map_delete_elem(union bpf_attr *attr)
 	bpf_enable_instrumentation();
 	maybe_wait_bpf_programs(map);
 out:
-	kfree(key);
+	kvfree(key);
 err_put:
 	fdput(f);
 	return err;
@@ -1247,7 +1247,7 @@ static int map_get_next_key(union bpf_attr *attr)
 	}
 
 	err = -ENOMEM;
-	next_key = kmalloc(map->key_size, GFP_USER);
+	next_key = kvmalloc(map->key_size, GFP_USER);
 	if (!next_key)
 		goto free_key;
 
@@ -1270,9 +1270,9 @@ static int map_get_next_key(union bpf_attr *attr)
 	err = 0;
 
 free_next_key:
-	kfree(next_key);
+	kvfree(next_key);
 free_key:
-	kfree(key);
+	kvfree(key);
 err_put:
 	fdput(f);
 	return err;
@@ -1299,7 +1299,7 @@ int generic_map_delete_batch(struct bpf_map *map,
 	if (!max_count)
 		return 0;
 
-	key = kmalloc(map->key_size, GFP_USER | __GFP_NOWARN);
+	key = kvmalloc(map->key_size, GFP_USER | __GFP_NOWARN);
 	if (!key)
 		return -ENOMEM;
 
@@ -1326,7 +1326,7 @@ int generic_map_delete_batch(struct bpf_map *map,
 	if (copy_to_user(&uattr->batch.count, &cp, sizeof(cp)))
 		err = -EFAULT;
 
-	kfree(key);
+	kvfree(key);
 	return err;
 }
 
@@ -1357,13 +1357,13 @@ int generic_map_update_batch(struct bpf_map *map,
 	if (!max_count)
 		return 0;
 
-	key = kmalloc(map->key_size, GFP_USER | __GFP_NOWARN);
+	key = kvmalloc(map->key_size, GFP_USER | __GFP_NOWARN);
 	if (!key)
 		return -ENOMEM;
 
 	value = kvmalloc(value_size, GFP_USER | __GFP_NOWARN);
 	if (!value) {
-		kfree(key);
+		kvfree(key);
 		return -ENOMEM;
 	}
 
@@ -1385,7 +1385,7 @@ int generic_map_update_batch(struct bpf_map *map,
 		err = -EFAULT;
 
 	kvfree(value);
-	kfree(key);
+	kvfree(key);
 	return err;
 }
 
@@ -1419,13 +1419,13 @@ int generic_map_lookup_batch(struct bpf_map *map,
 	if (put_user(0, &uattr->batch.count))
 		return -EFAULT;
 
-	buf_prevkey = kmalloc(map->key_size, GFP_USER | __GFP_NOWARN);
+	buf_prevkey = kvmalloc(map->key_size, GFP_USER | __GFP_NOWARN);
 	if (!buf_prevkey)
 		return -ENOMEM;
 
 	buf = kvmalloc(map->key_size + value_size, GFP_USER | __GFP_NOWARN);
 	if (!buf) {
-		kfree(buf_prevkey);
+		kvfree(buf_prevkey);
 		return -ENOMEM;
 	}
 
@@ -1485,7 +1485,7 @@ int generic_map_lookup_batch(struct bpf_map *map,
 		err = -EFAULT;
 
 free_buf:
-	kfree(buf_prevkey);
+	kvfree(buf_prevkey);
 	kvfree(buf);
 	return err;
 }
@@ -1575,7 +1575,7 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
 free_value:
 	kvfree(value);
 free_key:
-	kfree(key);
+	kvfree(key);
 err_put:
 	fdput(f);
 	return err;
-- 
2.33.0.rc2.250.ged5fa647cd-goog

