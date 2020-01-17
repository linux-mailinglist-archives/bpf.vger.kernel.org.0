Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B71A141484
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2020 23:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729849AbgAQW4P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Jan 2020 17:56:15 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:44753 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728927AbgAQW4P (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Jan 2020 17:56:15 -0500
Received: by mail-pg1-f201.google.com with SMTP id o21so15251027pgm.11
        for <bpf@vger.kernel.org>; Fri, 17 Jan 2020 14:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=YjsrWHQk2Ef6EHqeIvIXkz/PqYhiYpHlX5C3YmPgP0Q=;
        b=mSNZ/egwZMUmNm1xCRqbVDVxIgJ6PFHFMD97bYM6PSRiI0fnVpa/c12S1s1e8l9lw3
         4kJDr5myZh+2kfmLJaaAEkMEyaQ7kZLp+1occpsd9NPK1bruNXoY8zJc7ak14IL03QZe
         tQYueFop0SCDJZTSzY7KkD4Cg5Snz5DeVEVNli2apaOIfDqXOylKHzuofDWMjNrZJU8N
         hUtED5YDA2ThS+KjvTVPVSZ9hp2yCUvcNaBB5hVRNC1Y8D5MByJpTWoP+2uK4ggVt1x8
         DIfsFSUPEoYc7WqM2Q1f9BmZlW5m8ZrGf39dOPe9VBVxkRcYilUThhxblU6pZgYALu5p
         SGUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=YjsrWHQk2Ef6EHqeIvIXkz/PqYhiYpHlX5C3YmPgP0Q=;
        b=h/AhUXohTcOdbFGoF4MccG387OA8DSFKqRnZRJiRX7q86gg7VVRQNh0axXLP40a+3K
         dz77rhzqEFOQlSZvz0i/EGjdgtKFgehMhj1wds5HetaZ1EIc5qPRkaX5zBFcOVM2U3Ch
         Y9dd8mTho+E03XJevIsA6/UNUSlmkAxbZrsRsMjfd5LKLcaycdTqZ9bdDVhsTyX3sFt5
         P8EsCCSMNz+FQ6Mk8rR3vsS1CDnKYh9qXglczvnvcCIZJojisUpDMgCgjxWDDaa2OCwJ
         XjYDWBqvSBM8mX/nITU3/e60TCnNfPHBIOlWqDUQdTnpFjlmr/gZNld7ke5eYP+d35si
         TfMQ==
X-Gm-Message-State: APjAAAWjsvePmQhrvwKYzP5lA724Sz/ub14Y22ruXYqNnjzXNdqmya+D
        kh+mqlsssrjXhNTNeiPsJP4IwLZrU3O7
X-Google-Smtp-Source: APXvYqyz6Htr5YrcybMBordUJnmC5nMxj+CYUOrxzx3s7H3o4YTtrCUUGDPO0qBaXmphcnbRdVW3Yra5sMzi
X-Received: by 2002:a63:3f82:: with SMTP id m124mr48101369pga.431.1579301774378;
 Fri, 17 Jan 2020 14:56:14 -0800 (PST)
Date:   Fri, 17 Jan 2020 14:56:08 -0800
Message-Id: <20200117225608.220838-1-brianvv@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH bpf-next] bpf: Fix memory leaks in generic update/delete batch ops
From:   Brian Vazquez <brianvv@google.com>
To:     Brian Vazquez <brianvv.kernel@gmail.com>,
        Brian Vazquez <brianvv@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

generic update/delete batch ops functions were using __bpf_copy_key
without properly freeing the memory. Handle the memory allocation and
copy_from_user separately.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: aa2e93b8e58e ("bpf: Add generic support for update and delete
batch ops")
Signed-off-by: Brian Vazquez <brianvv@google.com>
---
 kernel/bpf/syscall.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index c26a71460f02f..9a840c57f6df7 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1239,12 +1239,15 @@ int generic_map_delete_batch(struct bpf_map *map,
 	if (!max_count)
 		return 0;
 
+	key = kmalloc(map->key_size, GFP_USER | __GFP_NOWARN);
+	if (!key)
+		return -ENOMEM;
+
 	for (cp = 0; cp < max_count; cp++) {
-		key = __bpf_copy_key(keys + cp * map->key_size, map->key_size);
-		if (IS_ERR(key)) {
-			err = PTR_ERR(key);
+		err = -EFAULT;
+		if (copy_from_user(key, keys + cp * map->key_size,
+				   map->key_size))
 			break;
-		}
 
 		if (bpf_map_is_dev_bound(map)) {
 			err = bpf_map_offload_delete_elem(map, key);
@@ -1264,6 +1267,8 @@ int generic_map_delete_batch(struct bpf_map *map,
 	}
 	if (copy_to_user(&uattr->batch.count, &cp, sizeof(cp)))
 		err = -EFAULT;
+
+	kfree(key);
 	return err;
 }
 
@@ -1294,18 +1299,21 @@ int generic_map_update_batch(struct bpf_map *map,
 	if (!max_count)
 		return 0;
 
+	key = kmalloc(map->key_size, GFP_USER | __GFP_NOWARN);
+	if (!key)
+		return -ENOMEM;
+
 	value = kmalloc(value_size, GFP_USER | __GFP_NOWARN);
-	if (!value)
+	if (!value) {
+		kfree(key);
 		return -ENOMEM;
+	}
 
 	for (cp = 0; cp < max_count; cp++) {
-		key = __bpf_copy_key(keys + cp * map->key_size, map->key_size);
-		if (IS_ERR(key)) {
-			err = PTR_ERR(key);
-			break;
-		}
 		err = -EFAULT;
-		if (copy_from_user(value, values + cp * value_size, value_size))
+		if (copy_from_user(key, keys + cp * map->key_size,
+		    map->key_size) ||
+		    copy_from_user(value, values + cp * value_size, value_size))
 			break;
 
 		err = bpf_map_update_value(map, f, key, value,
-- 
2.25.0.341.g760bfbb309-goog

