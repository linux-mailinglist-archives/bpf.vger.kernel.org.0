Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDA858B94
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2019 22:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfF0UYf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Jun 2019 16:24:35 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:34380 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfF0UYe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Jun 2019 16:24:34 -0400
Received: by mail-pf1-f201.google.com with SMTP id i2so2283234pfe.1
        for <bpf@vger.kernel.org>; Thu, 27 Jun 2019 13:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=t/AyvcKYelZOkRBej05NHVNdPUqzSYdpnSoVrXwFeq8=;
        b=LIW93hNP6NVq8yXgn8E05Ej1/SJ7vmBTNKx8snF9AkQiLA5O6goQISrbGKdqM5GDdg
         k7qSx2jY38J8QyD+G/790+OFELCmMSfY1Uib081YHXRR9lqHAvkWg+2kBUR4peNAN8ay
         IQkAtWSz9biOy0dEmIbs56ULp+myJ3z5Vibs8YNJBE7Lqt1IpbtFoVSOycJNu9RO0Ciy
         uY/lueImZPyKGnrl0xJdKBzaM1zDAhFNcuVT0qDw+8HYR59Zxyyr5x3Ox835FQ1xrf7u
         Mk6meYMbl7C928p5T6+msNfup+p0E4oPk270xoGIhsZntaE53djxvuBT5M/uZSERHNUU
         W1+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=t/AyvcKYelZOkRBej05NHVNdPUqzSYdpnSoVrXwFeq8=;
        b=VlY7MuvlwZJVTlvdWZPgbW+iHCrORsBIHrZvlgwjjjW9oluiMskEn8eANFlA6jZlfN
         LJtSexunr2P7k7Rg23elN6IMkEV0a7g0mQMq2gz8FzbKz1GtgoINzs/Hdpr+m0BgtEOD
         Promd67hesRq762XLiVplYz+dA0JTZC/dKw8ZEMKv8BwZFifEHToN11Z3SxMwNBnOQT0
         ex6BN2ZUfezEnH4SrHYMQFSzI6oR43bHP6dofjhsUNs8TXd2DZzVvV26+0QzGI3Pvw0j
         XNVHlw6yFqDDRfRrWS9L+O4mbN7O2HrDw7zxjLKjmNdV5BeVzC/LZyXcgQdXT3q3yOsK
         RvxQ==
X-Gm-Message-State: APjAAAV4fEOcpISrWt7LKBPdDsE1pploPi7ccMvQiTEUPTO4vdw02UQB
        p/SsuJT9wPfPVLH/CHUVb0u2E8rbW0o0
X-Google-Smtp-Source: APXvYqybBO9mVUy6hU9MY80fEbV6SlfmU8XopUR58BZqjyfwdOoWUPIqlvQtX6OMnldSsQCZD+LWQl7YNoi5
X-Received: by 2002:a63:1864:: with SMTP id 36mr4089744pgy.272.1561667073214;
 Thu, 27 Jun 2019 13:24:33 -0700 (PDT)
Date:   Thu, 27 Jun 2019 13:24:12 -0700
In-Reply-To: <20190627202417.33370-1-brianvv@google.com>
Message-Id: <20190627202417.33370-2-brianvv@google.com>
Mime-Version: 1.0
References: <20190627202417.33370-1-brianvv@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [RFC PATCH bpf-next v2 1/6] bpf: add bpf_map_value_size and
 bp_map_copy_value helper functions
From:   Brian Vazquez <brianvv@google.com>
To:     Brian Vazquez <brianvv.kernel@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Stanislav Fomichev <sdf@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Petar Penkov <ppenkov@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Brian Vazquez <brianvv@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Move reusable code from map_lookup_elem to helper functions to avoid code
duplication in kernel/bpf/syscall.c

Suggested-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Brian Vazquez <brianvv@google.com>
---
 kernel/bpf/syscall.c | 134 +++++++++++++++++++++++--------------------
 1 file changed, 73 insertions(+), 61 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 7713cf39795a4..a1823a50f9be0 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -126,6 +126,76 @@ static struct bpf_map *find_and_alloc_map(union bpf_attr *attr)
 	return map;
 }
 
+static u32 bpf_map_value_size(struct bpf_map *map)
+{
+	if (map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
+	    map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH ||
+	    map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY ||
+	    map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE)
+		return round_up(map->value_size, 8) * num_possible_cpus();
+	else if (IS_FD_MAP(map))
+		return sizeof(u32);
+	else
+		return  map->value_size;
+}
+
+static int bpf_map_copy_value(struct bpf_map *map, void *key, void *value,
+			      __u64 flags)
+{
+	void *ptr;
+	int err;
+
+	if (bpf_map_is_dev_bound(map))
+		return  bpf_map_offload_lookup_elem(map, key, value);
+
+	preempt_disable();
+	this_cpu_inc(bpf_prog_active);
+	if (map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
+	    map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH) {
+		err = bpf_percpu_hash_copy(map, key, value);
+	} else if (map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY) {
+		err = bpf_percpu_array_copy(map, key, value);
+	} else if (map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE) {
+		err = bpf_percpu_cgroup_storage_copy(map, key, value);
+	} else if (map->map_type == BPF_MAP_TYPE_STACK_TRACE) {
+		err = bpf_stackmap_copy(map, key, value);
+	} else if (IS_FD_ARRAY(map)) {
+		err = bpf_fd_array_map_lookup_elem(map, key, value);
+	} else if (IS_FD_HASH(map)) {
+		err = bpf_fd_htab_map_lookup_elem(map, key, value);
+	} else if (map->map_type == BPF_MAP_TYPE_REUSEPORT_SOCKARRAY) {
+		err = bpf_fd_reuseport_array_lookup_elem(map, key, value);
+	} else if (map->map_type == BPF_MAP_TYPE_QUEUE ||
+		   map->map_type == BPF_MAP_TYPE_STACK) {
+		err = map->ops->map_peek_elem(map, value);
+	} else {
+		rcu_read_lock();
+		if (map->ops->map_lookup_elem_sys_only)
+			ptr = map->ops->map_lookup_elem_sys_only(map, key);
+		else
+			ptr = map->ops->map_lookup_elem(map, key);
+		if (IS_ERR(ptr)) {
+			err = PTR_ERR(ptr);
+		} else if (!ptr) {
+			err = -ENOENT;
+		} else {
+			err = 0;
+			if (flags & BPF_F_LOCK)
+				/* lock 'ptr' and copy everything but lock */
+				copy_map_value_locked(map, value, ptr, true);
+			else
+				copy_map_value(map, value, ptr);
+			/* mask lock, since value wasn't zero inited */
+			check_and_init_map_lock(map, value);
+		}
+		rcu_read_unlock();
+	}
+	this_cpu_dec(bpf_prog_active);
+	preempt_enable();
+
+	return err;
+}
+
 void *bpf_map_area_alloc(size_t size, int numa_node)
 {
 	/* We really just want to fail instead of triggering OOM killer
@@ -729,7 +799,7 @@ static int map_lookup_elem(union bpf_attr *attr)
 	void __user *uvalue = u64_to_user_ptr(attr->value);
 	int ufd = attr->map_fd;
 	struct bpf_map *map;
-	void *key, *value, *ptr;
+	void *key, *value;
 	u32 value_size;
 	struct fd f;
 	int err;
@@ -761,72 +831,14 @@ static int map_lookup_elem(union bpf_attr *attr)
 		goto err_put;
 	}
 
-	if (map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
-	    map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH ||
-	    map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY ||
-	    map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE)
-		value_size = round_up(map->value_size, 8) * num_possible_cpus();
-	else if (IS_FD_MAP(map))
-		value_size = sizeof(u32);
-	else
-		value_size = map->value_size;
+	value_size = bpf_map_value_size(map);
 
 	err = -ENOMEM;
 	value = kmalloc(value_size, GFP_USER | __GFP_NOWARN);
 	if (!value)
 		goto free_key;
 
-	if (bpf_map_is_dev_bound(map)) {
-		err = bpf_map_offload_lookup_elem(map, key, value);
-		goto done;
-	}
-
-	preempt_disable();
-	this_cpu_inc(bpf_prog_active);
-	if (map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
-	    map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH) {
-		err = bpf_percpu_hash_copy(map, key, value);
-	} else if (map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY) {
-		err = bpf_percpu_array_copy(map, key, value);
-	} else if (map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE) {
-		err = bpf_percpu_cgroup_storage_copy(map, key, value);
-	} else if (map->map_type == BPF_MAP_TYPE_STACK_TRACE) {
-		err = bpf_stackmap_copy(map, key, value);
-	} else if (IS_FD_ARRAY(map)) {
-		err = bpf_fd_array_map_lookup_elem(map, key, value);
-	} else if (IS_FD_HASH(map)) {
-		err = bpf_fd_htab_map_lookup_elem(map, key, value);
-	} else if (map->map_type == BPF_MAP_TYPE_REUSEPORT_SOCKARRAY) {
-		err = bpf_fd_reuseport_array_lookup_elem(map, key, value);
-	} else if (map->map_type == BPF_MAP_TYPE_QUEUE ||
-		   map->map_type == BPF_MAP_TYPE_STACK) {
-		err = map->ops->map_peek_elem(map, value);
-	} else {
-		rcu_read_lock();
-		if (map->ops->map_lookup_elem_sys_only)
-			ptr = map->ops->map_lookup_elem_sys_only(map, key);
-		else
-			ptr = map->ops->map_lookup_elem(map, key);
-		if (IS_ERR(ptr)) {
-			err = PTR_ERR(ptr);
-		} else if (!ptr) {
-			err = -ENOENT;
-		} else {
-			err = 0;
-			if (attr->flags & BPF_F_LOCK)
-				/* lock 'ptr' and copy everything but lock */
-				copy_map_value_locked(map, value, ptr, true);
-			else
-				copy_map_value(map, value, ptr);
-			/* mask lock, since value wasn't zero inited */
-			check_and_init_map_lock(map, value);
-		}
-		rcu_read_unlock();
-	}
-	this_cpu_dec(bpf_prog_active);
-	preempt_enable();
-
-done:
+	err = bpf_map_copy_value(map, key, value, attr->flags);
 	if (err)
 		goto free_value;
 
-- 
2.22.0.410.gd8fdbe21b5-goog

