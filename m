Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD3683EEF57
	for <lists+bpf@lfdr.de>; Tue, 17 Aug 2021 17:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236297AbhHQPqd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Aug 2021 11:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233372AbhHQPqc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Aug 2021 11:46:32 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5671AC061764
        for <bpf@vger.kernel.org>; Tue, 17 Aug 2021 08:45:59 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id n200-20020a25d6d10000b02905935ac4154aso20661974ybg.23
        for <bpf@vger.kernel.org>; Tue, 17 Aug 2021 08:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=BfhAh8rwBz608rvr8spcyMFyyewDU7pH/HrVKwG96Tk=;
        b=WXR3freRDToAp2xl4SDlN3yMdKCjUbEh05+DmAfMKENt527cAuH+l3btY/z5Bn73SS
         ldMfJ0Tycf9UoIbEbxLYSZyskgEVbhR1UUtrYuFStiBtfY0Y7zj63voOtao4rEQfl/EA
         7RwCzZf1S9lPQWFV6hZEdJ2FyqWf7CtA1v0yuWaqji8eyBKI+DlanGexREVxFOdujpVa
         uC+dDYemqb/3FDg9/wRAYzPPW2wLc/lvsyEa0bP1izBuFvFrsjCvwaLXASu4YKxSSkNY
         fyyDJgKkDIMrynCbwtrLMMMyMmQuos0jopxvFlz5eZYJc9hDdHVtndE5Okf4u8kxnB9l
         1KKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=BfhAh8rwBz608rvr8spcyMFyyewDU7pH/HrVKwG96Tk=;
        b=hbEfB5nJ2td85T2FbeywqRUHaPgfHPJYfwnFaqBVbkbndXi8iZJ9CK7HiEoJRrcO9q
         4bNJLam8QWwg7rDbxE7PFft/jdX2jforfcQQdvGQyqxk1Pokuzqm4SK9OxYSqK0U8qNO
         +8Mrp58x/mc1pdkVEOoQ3LqZxtAZpu7Sxl4yl2SglR9IJSH/OpJ9Gx/QmHB2eQbClmIc
         J98oGgExGosRXOMoArXNKEveCHvm82hxlBnsQT8gu9fJJC7CCoGIpI7YEtt6FDu77U+D
         3iA+Y44O52jVWY99eS8XV/uxqLWGGvXqi/xt8a2cr2DnVnWzqjVZkNR+MkI6ix+eYqGc
         Wq4A==
X-Gm-Message-State: AOAM533zDBafTAaXS1zpCLGYdrglS8hUv84orVZlSnv2HyD9IXS3e2md
        BT9k5k/LB5+DgXjhn86Ciw2w8To=
X-Google-Smtp-Source: ABdhPJx8Q8iWeacjC/ya0q+3BeFDPPi/z3ckCkUuM9BSZQOrzxR8k32JGqQZoTpIM6zGLeaZfniQums=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:201:e3f2:64ab:dda:c30f])
 (user=sdf job=sendgmr) by 2002:a25:b18e:: with SMTP id h14mr5290749ybj.441.1629215158605;
 Tue, 17 Aug 2021 08:45:58 -0700 (PDT)
Date:   Tue, 17 Aug 2021 08:45:55 -0700
Message-Id: <20210817154556.92901-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH bpf-next v2 1/2] bpf: use kvmalloc for map values in syscall
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use kvmalloc/kvfree for temporary value when manipulating a map via
syscall. kmalloc might not be sufficient for percpu maps where the value
is big (and further multiplied by hundreds of CPUs).

Can be reproduced with netcnt test on qemu with "-smp 255".

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 kernel/bpf/syscall.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 7420e1334ab2..075f650d297a 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1076,7 +1076,7 @@ static int map_lookup_elem(union bpf_attr *attr)
 	value_size = bpf_map_value_size(map);
 
 	err = -ENOMEM;
-	value = kmalloc(value_size, GFP_USER | __GFP_NOWARN);
+	value = kvmalloc(value_size, GFP_USER | __GFP_NOWARN);
 	if (!value)
 		goto free_key;
 
@@ -1091,7 +1091,7 @@ static int map_lookup_elem(union bpf_attr *attr)
 	err = 0;
 
 free_value:
-	kfree(value);
+	kvfree(value);
 free_key:
 	kfree(key);
 err_put:
@@ -1137,16 +1137,10 @@ static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
 		goto err_put;
 	}
 
-	if (map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
-	    map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH ||
-	    map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY ||
-	    map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE)
-		value_size = round_up(map->value_size, 8) * num_possible_cpus();
-	else
-		value_size = map->value_size;
+	value_size = bpf_map_value_size(map);
 
 	err = -ENOMEM;
-	value = kmalloc(value_size, GFP_USER | __GFP_NOWARN);
+	value = kvmalloc(value_size, GFP_USER | __GFP_NOWARN);
 	if (!value)
 		goto free_key;
 
@@ -1157,7 +1151,7 @@ static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
 	err = bpf_map_update_value(map, f, key, value, attr->flags);
 
 free_value:
-	kfree(value);
+	kvfree(value);
 free_key:
 	kfree(key);
 err_put:
@@ -1367,7 +1361,7 @@ int generic_map_update_batch(struct bpf_map *map,
 	if (!key)
 		return -ENOMEM;
 
-	value = kmalloc(value_size, GFP_USER | __GFP_NOWARN);
+	value = kvmalloc(value_size, GFP_USER | __GFP_NOWARN);
 	if (!value) {
 		kfree(key);
 		return -ENOMEM;
@@ -1390,7 +1384,7 @@ int generic_map_update_batch(struct bpf_map *map,
 	if (copy_to_user(&uattr->batch.count, &cp, sizeof(cp)))
 		err = -EFAULT;
 
-	kfree(value);
+	kvfree(value);
 	kfree(key);
 	return err;
 }
@@ -1429,7 +1423,7 @@ int generic_map_lookup_batch(struct bpf_map *map,
 	if (!buf_prevkey)
 		return -ENOMEM;
 
-	buf = kmalloc(map->key_size + value_size, GFP_USER | __GFP_NOWARN);
+	buf = kvmalloc(map->key_size + value_size, GFP_USER | __GFP_NOWARN);
 	if (!buf) {
 		kfree(buf_prevkey);
 		return -ENOMEM;
@@ -1492,7 +1486,7 @@ int generic_map_lookup_batch(struct bpf_map *map,
 
 free_buf:
 	kfree(buf_prevkey);
-	kfree(buf);
+	kvfree(buf);
 	return err;
 }
 
@@ -1547,7 +1541,7 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
 	value_size = bpf_map_value_size(map);
 
 	err = -ENOMEM;
-	value = kmalloc(value_size, GFP_USER | __GFP_NOWARN);
+	value = kvmalloc(value_size, GFP_USER | __GFP_NOWARN);
 	if (!value)
 		goto free_key;
 
@@ -1579,7 +1573,7 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
 	err = 0;
 
 free_value:
-	kfree(value);
+	kvfree(value);
 free_key:
 	kfree(key);
 err_put:
-- 
2.33.0.rc1.237.g0d66db33f3-goog

