Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094126AAF9A
	for <lists+bpf@lfdr.de>; Sun,  5 Mar 2023 13:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjCEMqi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 5 Mar 2023 07:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjCEMqg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 5 Mar 2023 07:46:36 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD59EF99
        for <bpf@vger.kernel.org>; Sun,  5 Mar 2023 04:46:34 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id b12so1202974ilf.9
        for <bpf@vger.kernel.org>; Sun, 05 Mar 2023 04:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678020394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WmDHP81h9Zc5yHGdhmIdZKJM07O38CQheGMoXufBbrk=;
        b=nYbNcXqLx0Xnu+OZfznwuKJ9mvUo/P7jOqrHJQHSbOfxMePf82QxBb9RGYX26mZyEC
         ogIB7N8LQ1OhxK/GPC5Jr5DdnfR+JDppNnFNZ0QDQ/TQrfvdGXMKQouBzciULwaetgRZ
         QwKxcjOJr9uxR2w25QPqN8hQr5qOF41lQyQILqvhBgLxvj5tcAy4eddVUJinymGSJpeG
         5MSfU4QTp5QtuR7fhHD84xhKaNzfGqyOezXXvqcZughG1zypQW7aFz1M4nDcr1mclDqK
         eyWIAQP8+koC1790J1iZTfiwYZkDGmYOnNNQe9Rd6o7wZ0UCOH+Sy+lkQdhlhGaH5V/e
         GX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678020394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WmDHP81h9Zc5yHGdhmIdZKJM07O38CQheGMoXufBbrk=;
        b=NptSa/egR10N6VGjcggICEqmc1mJEWGZTtbguovf9PfSqRUe1x0zA6SreZh2NE6zhw
         sJeB4W4PeuH9u/5xSoVZ8L8THSS07W9fJTGnbzAoeGuKxF5xxfqkZlyLc8TGmh8FC8g4
         xQR6fanl3ZXtz5aMFRF+MXAZDQcjRBPl0TweNVWwvWOZtBX5OsNIpiPP6OqmHl1USXTx
         NZ0DhyW/Vink6P2iZB5ISnR26cURIUzOh5FyAp6XqtWwiChnMkdSEwtiukllahH1Gp/2
         bNRLsw/5WUX3ZPRsY3ysso+CC00d/Wri2tVQIel0fN2nkFGYoq5ZhAfQ0S61B5FnHFRb
         tQLQ==
X-Gm-Message-State: AO0yUKXsO/bivt7CxRZa/fJbCJUCXcFGFf10CM6p5RD6oiuz83okJWsF
        8ye2lc5Hag+JfVbRFbC4bUY=
X-Google-Smtp-Source: AK7set8i9U5rpHHcpoQbN7VRT7WGelKch3Ws10RR8TRmneqhYegnX3HE2qxppMxd+gzfflgC3XsZmQ==
X-Received: by 2002:a92:1a43:0:b0:315:51c3:2ad9 with SMTP id z3-20020a921a43000000b0031551c32ad9mr5571033ill.21.1678020394060;
        Sun, 05 Mar 2023 04:46:34 -0800 (PST)
Received: from vultr.guest ([107.191.51.243])
        by smtp.gmail.com with ESMTPSA id v6-20020a02b906000000b003c4f6400c78sm2269629jan.33.2023.03.05.04.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 04:46:33 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, horenc@vt.edu,
        xiyou.wangcong@gmail.com, houtao1@huawei.com
Cc:     bpf@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v4 10/18] bpf: devmap memory usage
Date:   Sun,  5 Mar 2023 12:46:07 +0000
Message-Id: <20230305124615.12358-11-laoar.shao@gmail.com>
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

A new helper is introduced to calculate the memory usage of devmap and
devmap_hash. The number of dynamically allocated elements are recored
for devmap_hash already, but not for devmap. To track the memory size of
dynamically allocated elements, this patch also count the numbers for
devmap.

The result as follows,
- before
40: devmap  name count_map  flags 0x80
        key 4B  value 4B  max_entries 65536  memlock 524288B
41: devmap_hash  name count_map  flags 0x80
        key 4B  value 4B  max_entries 65536  memlock 524288B

- after
40: devmap  name count_map  flags 0x80  <<<< no elements
        key 4B  value 4B  max_entries 65536  memlock 524608B
41: devmap_hash  name count_map  flags 0x80 <<<< no elements
        key 4B  value 4B  max_entries 65536  memlock 524608B

Note that the number of buckets is same with max_entries for devmap_hash
in this case.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/devmap.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 2675fef..19b036a 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -819,8 +819,10 @@ static int dev_map_delete_elem(struct bpf_map *map, void *key)
 		return -EINVAL;
 
 	old_dev = unrcu_pointer(xchg(&dtab->netdev_map[k], NULL));
-	if (old_dev)
+	if (old_dev) {
 		call_rcu(&old_dev->rcu, __dev_map_entry_free);
+		atomic_dec((atomic_t *)&dtab->items);
+	}
 	return 0;
 }
 
@@ -931,6 +933,8 @@ static int __dev_map_update_elem(struct net *net, struct bpf_map *map,
 	old_dev = unrcu_pointer(xchg(&dtab->netdev_map[i], RCU_INITIALIZER(dev)));
 	if (old_dev)
 		call_rcu(&old_dev->rcu, __dev_map_entry_free);
+	else
+		atomic_inc((atomic_t *)&dtab->items);
 
 	return 0;
 }
@@ -1016,6 +1020,20 @@ static int dev_hash_map_redirect(struct bpf_map *map, u64 ifindex, u64 flags)
 				      __dev_map_hash_lookup_elem);
 }
 
+static u64 dev_map_mem_usage(const struct bpf_map *map)
+{
+	struct bpf_dtab *dtab = container_of(map, struct bpf_dtab, map);
+	u64 usage = sizeof(struct bpf_dtab);
+
+	if (map->map_type == BPF_MAP_TYPE_DEVMAP_HASH)
+		usage += (u64)dtab->n_buckets * sizeof(struct hlist_head);
+	else
+		usage += (u64)map->max_entries * sizeof(struct bpf_dtab_netdev *);
+	usage += atomic_read((atomic_t *)&dtab->items) *
+			 (u64)sizeof(struct bpf_dtab_netdev);
+	return usage;
+}
+
 BTF_ID_LIST_SINGLE(dev_map_btf_ids, struct, bpf_dtab)
 const struct bpf_map_ops dev_map_ops = {
 	.map_meta_equal = bpf_map_meta_equal,
@@ -1026,6 +1044,7 @@ static int dev_hash_map_redirect(struct bpf_map *map, u64 ifindex, u64 flags)
 	.map_update_elem = dev_map_update_elem,
 	.map_delete_elem = dev_map_delete_elem,
 	.map_check_btf = map_check_no_btf,
+	.map_mem_usage = dev_map_mem_usage,
 	.map_btf_id = &dev_map_btf_ids[0],
 	.map_redirect = dev_map_redirect,
 };
@@ -1039,6 +1058,7 @@ static int dev_hash_map_redirect(struct bpf_map *map, u64 ifindex, u64 flags)
 	.map_update_elem = dev_map_hash_update_elem,
 	.map_delete_elem = dev_map_hash_delete_elem,
 	.map_check_btf = map_check_no_btf,
+	.map_mem_usage = dev_map_mem_usage,
 	.map_btf_id = &dev_map_btf_ids[0],
 	.map_redirect = dev_hash_map_redirect,
 };
@@ -1109,9 +1129,11 @@ static int dev_map_notification(struct notifier_block *notifier,
 				if (!dev || netdev != dev->dev)
 					continue;
 				odev = unrcu_pointer(cmpxchg(&dtab->netdev_map[i], RCU_INITIALIZER(dev), NULL));
-				if (dev == odev)
+				if (dev == odev) {
 					call_rcu(&dev->rcu,
 						 __dev_map_entry_free);
+					atomic_dec((atomic_t *)&dtab->items);
+				}
 			}
 		}
 		rcu_read_unlock();
-- 
1.8.3.1

