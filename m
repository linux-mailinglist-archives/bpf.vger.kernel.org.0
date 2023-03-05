Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D52E6AAF93
	for <lists+bpf@lfdr.de>; Sun,  5 Mar 2023 13:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjCEMq2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 5 Mar 2023 07:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjCEMq2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 5 Mar 2023 07:46:28 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C167CE057
        for <bpf@vger.kernel.org>; Sun,  5 Mar 2023 04:46:26 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id w4so582084ilv.0
        for <bpf@vger.kernel.org>; Sun, 05 Mar 2023 04:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678020386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cu/vAfEmHhCsb3IwcGAX6XTmUnTtW1Rb4D+n9EPDM6I=;
        b=VlouMaOt5FtXxeFx/Pf/5zqJZJkim3g3Rx4CyNYrKvruDjc5EuZqaUw+7GQ9gfHXJc
         NFvZpS6E/7U6kdfmi3vtImRRtB6fFw7SPqo47Ye0W35NDO4h8+42hrTHzmca/Q1xC7+0
         /j7O2uElQmpWRVgoug7hEA0fMNYrgEsIs/SdRRTxNBLla4zPf14gXGJKUtCJDDuKDPMV
         yMDwo3R0Ma+AKfvwdJ3r3u9BHiy0iAh8Vbk2R/y0563vLX+C2l0Ee7k/sKTZq/4STMfT
         zylvEIwgHbztJ3zpGwD2rmKIvU6nn82S+wBExqE/at+MkfSuQPT9Qc2BajBCDQk0dRoH
         gWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678020386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cu/vAfEmHhCsb3IwcGAX6XTmUnTtW1Rb4D+n9EPDM6I=;
        b=ngQ5rrTZBs7MOIzWEII0PpMrIh9UxnVIQCXCLWCdsdsMDftlrZCpTKruQBx3ixDsI0
         eElNGpcOpz29nHmlRPIibcx1vbYMpLGAv8VkIyaFCiFwgGzuHEjIFH9xtEMSg6trR13/
         5KOUJVgNOiZD0rpy4YXC4CL/FPEF9ztt6Sec2nF3m0ZEG27ihgxjjFGQV0xiBfqJctsX
         qQd1en2RN7wdHFVT0CwXSq8i3Ac1VaVaDu7mLDwYLPFIuF80RRuNN3IIeX4TMyEVIrgV
         HzAjibhLElxtUSzVOc5L3eZw8GlaL8blvzPMQUnsPu6JT89wounbOw2MYKeSlMW7YaNL
         VbVg==
X-Gm-Message-State: AO0yUKX0vUwoo2bZTKJtyOmASwCFEAj9AO+NhWg6JE+s3tMY4GVMx4rM
        x0TDdIXSEKxfHPgJancXnK8=
X-Google-Smtp-Source: AK7set9jjzYHMglSlYKnEnQa4zB/ftputBAb4od70rbfJX1u/vTKcgr0Qq0wRKFWiWnPg4bxPJ1YQQ==
X-Received: by 2002:a05:6e02:669:b0:313:d82a:9fdd with SMTP id l9-20020a056e02066900b00313d82a9fddmr5765356ilt.29.1678020386497;
        Sun, 05 Mar 2023 04:46:26 -0800 (PST)
Received: from vultr.guest ([107.191.51.243])
        by smtp.gmail.com with ESMTPSA id v6-20020a02b906000000b003c4f6400c78sm2269629jan.33.2023.03.05.04.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 04:46:25 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, horenc@vt.edu,
        xiyou.wangcong@gmail.com, houtao1@huawei.com
Cc:     bpf@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v4 03/18] bpf: hashtab memory usage
Date:   Sun,  5 Mar 2023 12:46:00 +0000
Message-Id: <20230305124615.12358-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230305124615.12358-1-laoar.shao@gmail.com>
References: <20230305124615.12358-1-laoar.shao@gmail.com>
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
Acked-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/hashtab.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 653aeb4..0df4b0c 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -2190,6 +2190,44 @@ static int bpf_for_each_hash_elem(struct bpf_map *map, bpf_callback_t callback_f
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
@@ -2206,6 +2244,7 @@ static int bpf_for_each_hash_elem(struct bpf_map *map, bpf_callback_t callback_f
 	.map_seq_show_elem = htab_map_seq_show_elem,
 	.map_set_for_each_callback_args = map_set_for_each_callback_args,
 	.map_for_each_callback = bpf_for_each_hash_elem,
+	.map_mem_usage = htab_map_mem_usage,
 	BATCH_OPS(htab),
 	.map_btf_id = &htab_map_btf_ids[0],
 	.iter_seq_info = &iter_seq_info,
@@ -2227,6 +2266,7 @@ static int bpf_for_each_hash_elem(struct bpf_map *map, bpf_callback_t callback_f
 	.map_seq_show_elem = htab_map_seq_show_elem,
 	.map_set_for_each_callback_args = map_set_for_each_callback_args,
 	.map_for_each_callback = bpf_for_each_hash_elem,
+	.map_mem_usage = htab_map_mem_usage,
 	BATCH_OPS(htab_lru),
 	.map_btf_id = &htab_map_btf_ids[0],
 	.iter_seq_info = &iter_seq_info,
@@ -2378,6 +2418,7 @@ static void htab_percpu_map_seq_show_elem(struct bpf_map *map, void *key,
 	.map_seq_show_elem = htab_percpu_map_seq_show_elem,
 	.map_set_for_each_callback_args = map_set_for_each_callback_args,
 	.map_for_each_callback = bpf_for_each_hash_elem,
+	.map_mem_usage = htab_map_mem_usage,
 	BATCH_OPS(htab_percpu),
 	.map_btf_id = &htab_map_btf_ids[0],
 	.iter_seq_info = &iter_seq_info,
@@ -2397,6 +2438,7 @@ static void htab_percpu_map_seq_show_elem(struct bpf_map *map, void *key,
 	.map_seq_show_elem = htab_percpu_map_seq_show_elem,
 	.map_set_for_each_callback_args = map_set_for_each_callback_args,
 	.map_for_each_callback = bpf_for_each_hash_elem,
+	.map_mem_usage = htab_map_mem_usage,
 	BATCH_OPS(htab_lru_percpu),
 	.map_btf_id = &htab_map_btf_ids[0],
 	.iter_seq_info = &iter_seq_info,
@@ -2534,6 +2576,7 @@ static void htab_of_map_free(struct bpf_map *map)
 	.map_fd_sys_lookup_elem = bpf_map_fd_sys_lookup_elem,
 	.map_gen_lookup = htab_of_map_gen_lookup,
 	.map_check_btf = map_check_no_btf,
+	.map_mem_usage = htab_map_mem_usage,
 	BATCH_OPS(htab),
 	.map_btf_id = &htab_map_btf_ids[0],
 };
-- 
1.8.3.1

