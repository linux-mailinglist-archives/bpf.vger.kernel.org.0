Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576C069EC77
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 02:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjBVBqg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Feb 2023 20:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjBVBqf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Feb 2023 20:46:35 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2026932E5F
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 17:46:34 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id fd25so2831670pfb.1
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 17:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YxpNF8yA/J5C+4abp2EOSZEhHe3V+KL1xLxCSAvbtOY=;
        b=ZbCWFQLDCka+0d0C+9kwRTLpjlXmVkfWtfZvHwTdLxegFFMoogSI7ge+l9AQ4b3N3r
         3CCftPcr2X7mAPf06KAmACjuE9aVhhDq7GV48Fx+CHiOiohy9YERAWArPpXvzQUogbpZ
         S1l+MuM3D8gp+RK2XH4geKPSzsPk9mVKCTUIlaLDQ52PETHocLCQedAN9M8BhfmkobFn
         2viQ0q5pTVS9Gt4t6nliW6AmQa8dQ98IBq6BA7ESlBLTdMuDMsLUZ9H3pdU0LvOa0Uef
         KewELZvxP5z3RocFvxKlgTrhFQZc5MI014of50FXW0fHhP7N08BhxV+jOfc8yoElR9ZZ
         /lfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YxpNF8yA/J5C+4abp2EOSZEhHe3V+KL1xLxCSAvbtOY=;
        b=fogp7jA1d1dtNhPoFvusIDPjDlYV5mvAS3TTtDLkq4O+5ljvLoi1jPDmimgj2tAl35
         AC5LS7CXXaTAmxBlwMg8rx+z1UKKl7taETigu23YcooKt5vdaklsEz+SlOOjC1yYTp0b
         T0Vzfz0uCGtZ/Y/Stopn4plkoOWmxx2KN3bP75l81KhKMMV0CVgSdyZK1MmMzgjs9pW5
         i6zDmB2IwzXJSgFgIp9GRtQpSIRRWinOhXYLED9PnRT35FR9mauyppRooE40IM1Q3yQ7
         3rA2G+Be4v7YilJkZz6mpZzuJNm951WDP5xDfxk7riqQmETxI/50OzG3zBiFNRU0rFEn
         FdmQ==
X-Gm-Message-State: AO0yUKWq+yVeU/y8WrL7W3C6+U9UqjXTcH5R1IROFcN20m+fKIkO7ur5
        Jm5veyHclkVFzdxpGDL4CW8=
X-Google-Smtp-Source: AK7set/E6e0sQVMw2zNrZOlUEObKF7N9rks/+LB/Gi5Xckq7An6ZuB1rTBHHRwcoEzStTsIMunSt1Q==
X-Received: by 2002:a62:1912:0:b0:5a8:d97d:59d7 with SMTP id 18-20020a621912000000b005a8d97d59d7mr6099924pfz.28.1677030393588;
        Tue, 21 Feb 2023 17:46:33 -0800 (PST)
Received: from vultr.guest ([2001:19f0:7001:5cd8:5400:4ff:fe4e:5fe5])
        by smtp.gmail.com with ESMTPSA id f15-20020aa78b0f000000b005ac419804d3sm3811509pfd.186.2023.02.21.17.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 17:46:33 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, horenc@vt.edu,
        xiyou.wangcong@gmail.com
Cc:     bpf@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v2 03/18] bpf: hashtab memory usage
Date:   Wed, 22 Feb 2023 01:45:38 +0000
Message-Id: <20230222014553.47744-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230222014553.47744-1-laoar.shao@gmail.com>
References: <20230222014553.47744-1-laoar.shao@gmail.com>
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

htab_map_mem_usage() is introduced to calculate hashmap memory usage. In
this helper, some small memory allocations are ignore, as their size is
quite small compared with the total size. The inner_map_meta in
hash_of_map is also ignored.

The result for hashtab as follows,

- before this change
1: hash  name count_map  flags 0x1  <<<< no prealloc, fully set
        key 16B  value 24B  max_entries 1048576  memlock 41943040B
2: hash  name count_map  flags 0x1  <<<< no prealloc, none set
        key 16B  value 24B  max_entries 1048576  memlock 41943040B
3: hash  name count_map  flags 0x0  <<<< prealloc
        key 16B  value 24B  max_entries 1048576  memlock 41943040B

The memlock is always a fixed size whatever it is preallocated or
not, and whatever the count of allocated elements is.

- after this change
1: hash  name count_map  flags 0x1    <<<< non prealloc, fully set
        key 16B  value 24B  max_entries 1048576  memlock 117441536B
2: hash  name count_map  flags 0x1    <<<< non prealloc, non set
        key 16B  value 24B  max_entries 1048576  memlock 16778240B
3: hash  name count_map  flags 0x0    <<<< prealloc
        key 16B  value 24B  max_entries 1048576  memlock 109056000B

The memlock now is hashtab actually allocated.

The result for percpu hash map as follows,
- before this change
4: percpu_hash  name count_map  flags 0x0       <<<< prealloc
        key 16B  value 24B  max_entries 1048576  memlock 822083584B
5: percpu_hash  name count_map  flags 0x1       <<<< no prealloc
        key 16B  value 24B  max_entries 1048576  memlock 822083584B

- after this change
4: percpu_hash  name count_map  flags 0x0
        key 16B  value 24B  max_entries 1048576  memlock 897582080B
5: percpu_hash  name count_map  flags 0x1
        key 16B  value 24B  max_entries 1048576  memlock 922748736B

At worst, the difference can be 10x, for example,
- before this change
6: hash  name count_map  flags 0x0
        key 4B  value 4B  max_entries 1048576  memlock 8388608B

- after this change
6: hash  name count_map  flags 0x0
        key 4B  value 4B  max_entries 1048576  memlock 83889408B

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/hashtab.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 5dfcb5a..6913b92 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -2175,6 +2175,44 @@ static int bpf_for_each_hash_elem(struct bpf_map *map, bpf_callback_t callback_f
 	return num_elems;
 }
 
+static u64 htab_map_mem_usage(const struct bpf_map *map)
+{
+	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
+	u32 value_size = round_up(htab->map.value_size, 8);
+	bool prealloc = htab_is_prealloc(htab);
+	bool percpu = htab_is_percpu(htab);
+	bool lru = htab_is_lru(htab);
+	u64 num_entries;
+	u64 usage = sizeof(struct bpf_htab);
+
+	usage += sizeof(struct bucket) * htab->n_buckets;
+	usage += sizeof(int) * num_possible_cpus() * HASHTAB_MAP_LOCK_COUNT;
+	if (prealloc) {
+		num_entries = map->max_entries;
+		if (htab_has_extra_elems(htab))
+			num_entries += num_possible_cpus();
+
+		usage += htab->elem_size * num_entries;
+
+		if (percpu)
+			usage += value_size * num_possible_cpus() * num_entries;
+		else if (!lru)
+			usage += sizeof(struct htab_elem *) * num_possible_cpus();
+	} else {
+#define LLIST_NODE_SZ sizeof(struct llist_node)
+
+		num_entries = htab->use_percpu_counter ?
+					  percpu_counter_sum(&htab->pcount) :
+					  atomic_read(&htab->count);
+		usage += (htab->elem_size + LLIST_NODE_SZ) * num_entries;
+		if (percpu) {
+			usage += (LLIST_NODE_SZ + sizeof(void *)) * num_entries;
+			usage += value_size * num_possible_cpus() * num_entries;
+		}
+	}
+	return usage;
+}
+
 BTF_ID_LIST_SINGLE(htab_map_btf_ids, struct, bpf_htab)
 const struct bpf_map_ops htab_map_ops = {
 	.map_meta_equal = bpf_map_meta_equal,
@@ -2191,6 +2229,7 @@ static int bpf_for_each_hash_elem(struct bpf_map *map, bpf_callback_t callback_f
 	.map_seq_show_elem = htab_map_seq_show_elem,
 	.map_set_for_each_callback_args = map_set_for_each_callback_args,
 	.map_for_each_callback = bpf_for_each_hash_elem,
+	.map_mem_usage = htab_map_mem_usage,
 	BATCH_OPS(htab),
 	.map_btf_id = &htab_map_btf_ids[0],
 	.iter_seq_info = &iter_seq_info,
@@ -2212,6 +2251,7 @@ static int bpf_for_each_hash_elem(struct bpf_map *map, bpf_callback_t callback_f
 	.map_seq_show_elem = htab_map_seq_show_elem,
 	.map_set_for_each_callback_args = map_set_for_each_callback_args,
 	.map_for_each_callback = bpf_for_each_hash_elem,
+	.map_mem_usage = htab_map_mem_usage,
 	BATCH_OPS(htab_lru),
 	.map_btf_id = &htab_map_btf_ids[0],
 	.iter_seq_info = &iter_seq_info,
@@ -2363,6 +2403,7 @@ static void htab_percpu_map_seq_show_elem(struct bpf_map *map, void *key,
 	.map_seq_show_elem = htab_percpu_map_seq_show_elem,
 	.map_set_for_each_callback_args = map_set_for_each_callback_args,
 	.map_for_each_callback = bpf_for_each_hash_elem,
+	.map_mem_usage = htab_map_mem_usage,
 	BATCH_OPS(htab_percpu),
 	.map_btf_id = &htab_map_btf_ids[0],
 	.iter_seq_info = &iter_seq_info,
@@ -2382,6 +2423,7 @@ static void htab_percpu_map_seq_show_elem(struct bpf_map *map, void *key,
 	.map_seq_show_elem = htab_percpu_map_seq_show_elem,
 	.map_set_for_each_callback_args = map_set_for_each_callback_args,
 	.map_for_each_callback = bpf_for_each_hash_elem,
+	.map_mem_usage = htab_map_mem_usage,
 	BATCH_OPS(htab_lru_percpu),
 	.map_btf_id = &htab_map_btf_ids[0],
 	.iter_seq_info = &iter_seq_info,
@@ -2519,6 +2561,7 @@ static void htab_of_map_free(struct bpf_map *map)
 	.map_fd_sys_lookup_elem = bpf_map_fd_sys_lookup_elem,
 	.map_gen_lookup = htab_of_map_gen_lookup,
 	.map_check_btf = map_check_no_btf,
+	.map_mem_usage = htab_map_mem_usage,
 	BATCH_OPS(htab),
 	.map_btf_id = &htab_map_btf_ids[0],
 };
-- 
1.8.3.1

