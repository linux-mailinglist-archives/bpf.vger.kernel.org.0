Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058BF6A45E7
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 16:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjB0PVA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 10:21:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjB0PVA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 10:21:00 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F04222A16
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 07:20:55 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id c1so7077191plg.4
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 07:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YxpNF8yA/J5C+4abp2EOSZEhHe3V+KL1xLxCSAvbtOY=;
        b=pNaTN9Ilg4/QvSkjfBXARAhukWDcthc6LI8K7vHfHt6hYO9c3UDpjM25hG3BdG23ZP
         tJbM0Ars4uuYwjrAElMkuLVAW9X2snSM9bMnvEd/nuxjPY14z32auFu8SB2palNlewr6
         Cdab7akGdyDF5H+dmTxw/6BJUeo+RnibgH6PHrmXTLiQMFjZQdAxS9U38b57ivMHAyPD
         D6sK6ikjqBSe5NazCb+lrdE+KhpyIAmTlUcsZysGkMZAJdBAMQ4HdQ+s/Ln0nTVuuO31
         ECiO7/762ZsUAVRX8bbpxC+2IXcL7EeF4kz/pOZnBZ1X7JUaxROMrz6jNnpeBD7zB6Jk
         31kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YxpNF8yA/J5C+4abp2EOSZEhHe3V+KL1xLxCSAvbtOY=;
        b=bZSDIODUSgi41338gKv5MERtEsfhlrOu+JPyLrCPhqImEUl2fj8SAlEAhcwSYAIFoz
         eHJn4m386Ywl0tmR4n/WfZiyMjBOJrzwhNyaVtNOPrOhihY3C03GzDmkK/LrL/vnPiiw
         Ociid1q2dOl1z/07EAyl0FIXm7EbqiXJF8dPcVfnI4pP7eJFp89PqLCXVvxoG+xUCD4D
         F/rLE0xrkjYzOTg6RvdJ4D7MOFjq5vrJ9iQLO86ApPZs5KEtMIMnVEaYhbswWbLx0CE/
         scxuBIyNxxZYBryaaLqn2Hh5nEdd/HtlwW4KY1rf6wbSb0AZYAgzUiMl8cP8cE4o4t9R
         F+Gg==
X-Gm-Message-State: AO0yUKUtG+E+APut44gjYcBo4Kk2DLx8ITSQAGHzr3ajTGaREJJ7/pun
        uGvZj1z5yGF+1E7aX1FmDn4=
X-Google-Smtp-Source: AK7set8dm/Te9f5D41VKK8TT2RpjS1INmSuaN9TWkRsvbeoeJoynIBbERvX029Z+DtP3WSJIswpyxw==
X-Received: by 2002:a05:6a20:6d8a:b0:cd:18d7:f131 with SMTP id gl10-20020a056a206d8a00b000cd18d7f131mr4764233pzb.7.1677511255104;
        Mon, 27 Feb 2023 07:20:55 -0800 (PST)
Received: from vultr.guest ([2401:c080:1000:4a6a:5400:4ff:fe53:1982])
        by smtp.gmail.com with ESMTPSA id n2-20020a62e502000000b00589a7824703sm4326825pff.194.2023.02.27.07.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 07:20:54 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, horenc@vt.edu,
        xiyou.wangcong@gmail.com
Cc:     bpf@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v3 03/18] bpf: hashtab memory usage
Date:   Mon, 27 Feb 2023 15:20:17 +0000
Message-Id: <20230227152032.12359-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230227152032.12359-1-laoar.shao@gmail.com>
References: <20230227152032.12359-1-laoar.shao@gmail.com>
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

