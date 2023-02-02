Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A3D687324
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 02:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjBBBmu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 20:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjBBBmt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 20:42:49 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314D577DC5
        for <bpf@vger.kernel.org>; Wed,  1 Feb 2023 17:42:48 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id be8so379874plb.7
        for <bpf@vger.kernel.org>; Wed, 01 Feb 2023 17:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IlsPDQQrn+oExLAwKU+9a981T51GRXTZu9kwUUI2F68=;
        b=qw4zWHEG5rlxLuRA2Mk2zQxmQoWx+8vAJfsjWhcoXTLwNOskwzmVzveBoO/Ik8mj/K
         jYB40qB1HcmjfgW4nXG7OjV/04e3FIRK51MW/KIInIHJEk0gTzEruSbVfzBqCj0+BiUm
         A4jK+3jrJFm1TCQvZF4dDc0Hsr3bf+i2XLlq1IWjcxdzswxaf3xPKKRBt1mT5zyO29ep
         0rbTQVBit/K5XjnUmlEiG9J8i37h23wW7+oTDwbuVwt7QV8z4O43KsfzUKSHPq/6HiHS
         Ug6SgpdJ17MIdoCo8XPN3c51YsQgozW6lYKoWgLSp2jmPM9kcpakKcbGoAantIgGh4uQ
         iC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IlsPDQQrn+oExLAwKU+9a981T51GRXTZu9kwUUI2F68=;
        b=PKa6Zn9DT1aEFDg5cMQhE0P0kFomWx3NLvkJg6GVHhuoh09Jd/sDstHzxJNeR6lMTl
         SNd3kvKh/VVfFu3IrKyapT91sMC5zlJATOhYE3CISrXy/ILiq4gmwhIYO9HYX5s/wpxL
         4e8x+Hb/bIdfpAo5Ikr7JqnwU6vL6+8Zsskj9sHlpzaTRC1/nvDyPyBJY0n+CiefV052
         RG/1fjHc1dZUUOVJwMI1xZS1+hO50t6C9JMT7QtcqmQTQ9GvQBKTBTKIjuyS1UzsRQTs
         8zHS734N+kZlSSgNKjdGs/uTfm1sbPQ+ElVG+mlt7c1hvi0pZ06H5UhMTE8XDNa0CNx/
         vIEA==
X-Gm-Message-State: AO0yUKWgMih/oOXxNbDFjgA2cNNlDjK4UpxFNjlFhjJ+cXWC6Nf8P73R
        Y1UziJP6ixIakNRVOUx+z9k=
X-Google-Smtp-Source: AK7set/OuunuF82xfnkKr4JO7JphAerYxqJCUhDt5Rs18OlwYb7xCNJ/ZlBTM0ydmhVnZGVpcgln1Q==
X-Received: by 2002:a05:6a20:158e:b0:b8:54a2:b8d1 with SMTP id h14-20020a056a20158e00b000b854a2b8d1mr5750054pzj.57.1675302167711;
        Wed, 01 Feb 2023 17:42:47 -0800 (PST)
Received: from vultr.guest ([2001:19f0:7001:3f48:5400:4ff:fe4a:8c8b])
        by smtp.gmail.com with ESMTPSA id t191-20020a6381c8000000b004e8f7f23c4bsm6594205pgd.76.2023.02.01.17.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 17:42:47 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        dennis@kernel.org, cl@linux.com, akpm@linux-foundation.org,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, vbabka@suse.cz,
        urezki@gmail.com
Cc:     linux-mm@kvack.org, bpf@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next 7/7] bpf: hashtab memory usage
Date:   Thu,  2 Feb 2023 01:41:58 +0000
Message-Id: <20230202014158.19616-8-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230202014158.19616-1-laoar.shao@gmail.com>
References: <20230202014158.19616-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Get htab memory usage from the htab pointers we have allocated. Some
small pointers are ignored as their size are quite small compared with
the total size.

The result as follows,
- before this change
1: hash  name count_map  flags 0x0  <<<< prealloc
        key 16B  value 24B  max_entries 1048576  memlock 41943040B
2: hash  name count_map  flags 0x1  <<<< non prealloc, fully set
        key 16B  value 24B  max_entries 1048576  memlock 41943040B
3: hash  name count_map  flags 0x1  <<<< non prealloc, non set
        key 16B  value 24B  max_entries 1048576  memlock 41943040B

The memlock is always a fixed number whatever it is preallocated or
not, and whatever the allocated elements number is.

- after this change
1: hash  name count_map  flags 0x0  <<<< prealloc
        key 16B  value 24B  max_entries 1048576  memlock 109064464B
2: hash  name count_map  flags 0x1  <<<< non prealloc, fully set
        key 16B  value 24B  max_entries 1048576  memlock 117464320B
3: hash  name count_map  flags 0x1  <<<< non prealloc, non set
        key 16B  value 24B  max_entries 1048576  memlock 16797952B

The memlock now is hashtab actually allocated.

At worst, the difference can be 10x, for example,
- before this change
4: hash  name count_map  flags 0x0
        key 4B  value 4B  max_entries 1048576  memlock 8388608B

- after this change
4: hash  name count_map  flags 0x0
        key 4B  value 4B  max_entries 1048576  memlock 83898640B

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/hashtab.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 79 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 66bded1..cba540b 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -273,6 +273,25 @@ static void htab_free_elems(struct bpf_htab *htab)
 	bpf_map_area_free(htab->elems);
 }
 
+static unsigned long htab_prealloc_elems_size(struct bpf_htab *htab)
+{
+	unsigned long size = 0;
+	int i;
+
+	if (!htab_is_percpu(htab))
+		return kvsize(htab->elems);
+
+	for (i = 0; i < htab->map.max_entries; i++) {
+		void __percpu *pptr;
+
+		pptr = htab_elem_get_ptr(get_htab_elem(htab, i),
+					htab->map.key_size);
+		size += percpu_size(pptr);
+	}
+	size += kvsize(htab->elems);
+	return size;
+}
+
 /* The LRU list has a lock (lru_lock). Each htab bucket has a lock
  * (bucket_lock). If both locks need to be acquired together, the lock
  * order is always lru_lock -> bucket_lock and this only happens in
@@ -864,6 +883,16 @@ static void htab_elem_free(struct bpf_htab *htab, struct htab_elem *l)
 	bpf_mem_cache_free(&htab->ma, l);
 }
 
+static unsigned long htab_elem_size(struct bpf_htab *htab, struct htab_elem *l)
+{
+	unsigned long size = 0;
+
+	if (htab->map.map_type == BPF_MAP_TYPE_PERCPU_HASH)
+		size += bpf_mem_cache_elem_size(&htab->pcpu_ma, l->ptr_to_pptr);
+
+	return size + bpf_mem_cache_elem_size(&htab->ma, l);
+}
+
 static void htab_put_fd_value(struct bpf_htab *htab, struct htab_elem *l)
 {
 	struct bpf_map *map = &htab->map;
@@ -899,7 +928,6 @@ static void dec_elem_count(struct bpf_htab *htab)
 		atomic_dec(&htab->count);
 }
 
-
 static void free_htab_elem(struct bpf_htab *htab, struct htab_elem *l)
 {
 	htab_put_fd_value(htab, l);
@@ -1457,6 +1485,31 @@ static void delete_all_elements(struct bpf_htab *htab)
 	migrate_enable();
 }
 
+static unsigned long htab_non_prealloc_elems_size(struct bpf_htab *htab)
+{
+	unsigned long size = 0;
+	unsigned long count;
+	int i;
+
+	rcu_read_lock();
+	for (i = 0; i < htab->n_buckets; i++) {
+		struct hlist_nulls_head *head = select_bucket(htab, i);
+		struct hlist_nulls_node *n;
+		struct htab_elem *l;
+
+		hlist_nulls_for_each_entry(l, n, head, hash_node) {
+			size = htab_elem_size(htab, l);
+			goto out;
+		}
+	}
+out:
+	rcu_read_unlock();
+	count = htab->use_percpu_counter ? percpu_counter_sum(&htab->pcount) :
+			atomic_read(&htab->count);
+
+	return size * count;
+}
+
 static void htab_free_malloced_timers(struct bpf_htab *htab)
 {
 	int i;
@@ -1523,6 +1576,26 @@ static void htab_map_free(struct bpf_map *map)
 	bpf_map_area_free(htab);
 }
 
+/* Get the htab memory usage from pointers we have already allocated.
+ * Some minor pointers are igored as their size are quite small compared
+ * with the total size.
+ */
+static unsigned long htab_mem_usage(const struct bpf_map *map)
+{
+	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
+	unsigned long size = 0;
+
+	if (!htab_is_prealloc(htab))
+		size += htab_non_prealloc_elems_size(htab);
+	else
+		size += htab_prealloc_elems_size(htab);
+	size += percpu_size(htab->extra_elems);
+	size += kvsize(htab->buckets);
+	size += bpf_mem_alloc_size(&htab->pcpu_ma);
+	size += bpf_mem_alloc_size(&htab->ma);
+	return size;
+}
+
 static void htab_map_seq_show_elem(struct bpf_map *map, void *key,
 				   struct seq_file *m)
 {
@@ -2191,6 +2264,7 @@ static int bpf_for_each_hash_elem(struct bpf_map *map, bpf_callback_t callback_f
 	.map_seq_show_elem = htab_map_seq_show_elem,
 	.map_set_for_each_callback_args = map_set_for_each_callback_args,
 	.map_for_each_callback = bpf_for_each_hash_elem,
+	.map_mem_usage = htab_mem_usage,
 	BATCH_OPS(htab),
 	.map_btf_id = &htab_map_btf_ids[0],
 	.iter_seq_info = &iter_seq_info,
@@ -2212,6 +2286,7 @@ static int bpf_for_each_hash_elem(struct bpf_map *map, bpf_callback_t callback_f
 	.map_seq_show_elem = htab_map_seq_show_elem,
 	.map_set_for_each_callback_args = map_set_for_each_callback_args,
 	.map_for_each_callback = bpf_for_each_hash_elem,
+	.map_mem_usage = htab_mem_usage,
 	BATCH_OPS(htab_lru),
 	.map_btf_id = &htab_map_btf_ids[0],
 	.iter_seq_info = &iter_seq_info,
@@ -2363,6 +2438,7 @@ static void htab_percpu_map_seq_show_elem(struct bpf_map *map, void *key,
 	.map_seq_show_elem = htab_percpu_map_seq_show_elem,
 	.map_set_for_each_callback_args = map_set_for_each_callback_args,
 	.map_for_each_callback = bpf_for_each_hash_elem,
+	.map_mem_usage = htab_mem_usage,
 	BATCH_OPS(htab_percpu),
 	.map_btf_id = &htab_map_btf_ids[0],
 	.iter_seq_info = &iter_seq_info,
@@ -2382,6 +2458,7 @@ static void htab_percpu_map_seq_show_elem(struct bpf_map *map, void *key,
 	.map_seq_show_elem = htab_percpu_map_seq_show_elem,
 	.map_set_for_each_callback_args = map_set_for_each_callback_args,
 	.map_for_each_callback = bpf_for_each_hash_elem,
+	.map_mem_usage = htab_mem_usage,
 	BATCH_OPS(htab_lru_percpu),
 	.map_btf_id = &htab_map_btf_ids[0],
 	.iter_seq_info = &iter_seq_info,
@@ -2519,6 +2596,7 @@ static void htab_of_map_free(struct bpf_map *map)
 	.map_fd_sys_lookup_elem = bpf_map_fd_sys_lookup_elem,
 	.map_gen_lookup = htab_of_map_gen_lookup,
 	.map_check_btf = map_check_no_btf,
+	.map_mem_usage = htab_mem_usage,
 	BATCH_OPS(htab),
 	.map_btf_id = &htab_map_btf_ids[0],
 };
-- 
1.8.3.1

