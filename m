Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3AE69EC7E
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 02:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjBVBrC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Feb 2023 20:47:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjBVBrB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Feb 2023 20:47:01 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B4B32E5F
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 17:46:58 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d7so3716887pfu.4
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 17:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WmDHP81h9Zc5yHGdhmIdZKJM07O38CQheGMoXufBbrk=;
        b=O/7sO/nDPLAXxH5Pz9vc6X20BJF/0P2i/sjlPkz3izRVMNP7JBE4VrpOBUWe1l9pLY
         JHA/9JcgrB0uM5a2vfbpvV4HpdTW91qtUrsVCKspUg+58Q78vyGVpFYd7EOMBnbsU25/
         sM0qVRncVKddrym3cx7IfTul80KpL/8ssKVtFWFA3ttMyo2pdNdwZgxC3K/EuD2b/snL
         N/vGsFxgcMYAp85H46r1gZ5kyWW5Iv40VynckPeO3F9LWSZzLQ49RuBQP5FyK12ns9vr
         xb5rQV64VBLQ+8932wRv7HP4SU0CI4s7D7c1+Wk+r/g/rEiu89eUHjTP+Xf27dgdrXLw
         uXsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WmDHP81h9Zc5yHGdhmIdZKJM07O38CQheGMoXufBbrk=;
        b=OCxIDJZIuDq7kCJHCMafiKe7Di/n095XuZGp+Etd4J4xuFpPSTqU+aORJ8NYbE76+O
         wlQ/YEk1eYstJIkY5uDJSRjq1w4mHVSk9vVyITwmeGa2+j5NeZj4FWIrVnx/Ha7Rv67D
         4qWjoddAQNtsACwSreEDLB/4xsI5jc92G3SDB9UdmUHG6I/B9jYplwqhYE75Kq72vYXZ
         jSElAat1U554W/yoaQUzdeRPNEJufCKz5a9BYvNeX3EkYubIxgrZXQxZaRGgbHHU42SP
         IDGZPodToc+7Nc4e25e/shd/rH4hfBiLfz+/97GRQoq+IgkRq3ytQHegHw3nEWUJB0W7
         vj4w==
X-Gm-Message-State: AO0yUKUjjx7VZoyVpDrU2ZZyA+se60vngHAOOo3VFYHeO0fyFiLarCHZ
        uHcfaT/g0SZs6ZhE4ykOEE0=
X-Google-Smtp-Source: AK7set8+1xQ3+PHoO6YWo40DyF6/aA++q48AS4NY35nWoxSlu0SrXsjEiEqCV4bJIjPy4QGXmD1VLA==
X-Received: by 2002:a62:4eca:0:b0:5cd:229e:f1d8 with SMTP id c193-20020a624eca000000b005cd229ef1d8mr3905729pfb.4.1677030417712;
        Tue, 21 Feb 2023 17:46:57 -0800 (PST)
Received: from vultr.guest ([2001:19f0:7001:5cd8:5400:4ff:fe4e:5fe5])
        by smtp.gmail.com with ESMTPSA id f15-20020aa78b0f000000b005ac419804d3sm3811509pfd.186.2023.02.21.17.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 17:46:57 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, horenc@vt.edu,
        xiyou.wangcong@gmail.com
Cc:     bpf@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v2 10/18] bpf: devmap memory usage
Date:   Wed, 22 Feb 2023 01:45:45 +0000
Message-Id: <20230222014553.47744-11-laoar.shao@gmail.com>
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

