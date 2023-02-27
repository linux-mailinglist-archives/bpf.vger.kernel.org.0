Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD606A45EE
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 16:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjB0PVb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 10:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjB0PVV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 10:21:21 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20EC22A37
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 07:21:19 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id ce7so3730853pfb.9
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 07:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WmDHP81h9Zc5yHGdhmIdZKJM07O38CQheGMoXufBbrk=;
        b=cQ1CwSSmjsCxnR7BHnD8jTKQazh8b9zNxTimZocLyOXPWAybthTE9XcnIeDC2Zcu7x
         qmTKPvuFUUrZhx2XXpc2Q5E+TuBqV9RiG4t0ufMZ3t8MVOrMt/rLIvo0DtsOKTZWkVTT
         ipyXQiMrYfPFyu/HqJnyTqswHifUtY0Zv5jKbo+5TEwSEO/FjfvJrRr6oL8eRzjKczrE
         5xcoluTMLTO4uwOiniuvamjxKcvKM71sjw4CcvR4MXf5dIMtOuiytgpR5Yi0+R3TDwhK
         7GlU0hLpq0dORSmaoDG4wy2reIu1XAgLB811Sm7oM3cobkxOmW8nfDLO6i1hTEq5RGMI
         3yBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WmDHP81h9Zc5yHGdhmIdZKJM07O38CQheGMoXufBbrk=;
        b=guHUe/UbhptUrzFZKN0FEifdb/wy+N2UKsXZTpGeBfDvdAcYv42A+uNyb9MR6atw+i
         DB8pCHqZzJxjalGv7TQwMuDbOcGclS6MJcZmF8FTgdVvUz16MoAJx6LxYUEIRu80BBGA
         vKpylm0fjnoh3xFUZ/U3fRAszR39yMZU/ddwW2bwEFPvcR+u9VveuRYV/uTAGzp+fpwB
         u2A3z29vXoJJ9jkQzqvAXbpA6w/iZF7L+J2z3KCbOrJ+4R/2+Sp/cm1piqhsx1M/mgzz
         tclWgQRD6xsOQnTgH3PSQauOdp92guLxqyL1h+xmPsI8KTbM7oPuQZU6PZn16/mhuRxB
         Z1RQ==
X-Gm-Message-State: AO0yUKVN/A5n/B2wHKdo30t3mSS8PhjHpmjuoaFOo+Egs8OadkAQGnnz
        dtKPZvgBTOkbGNlDEtKml8Y=
X-Google-Smtp-Source: AK7set8AsZsiIhTqCbkpPbatVLv/rZv54prkKISTYQYfi4VcdF9dKKhJaxka1kRc1RDTYTV4JLiEzA==
X-Received: by 2002:a05:6a00:1c98:b0:594:1f1c:3d3a with SMTP id y24-20020a056a001c9800b005941f1c3d3amr6555231pfw.15.1677511279197;
        Mon, 27 Feb 2023 07:21:19 -0800 (PST)
Received: from vultr.guest ([2401:c080:1000:4a6a:5400:4ff:fe53:1982])
        by smtp.gmail.com with ESMTPSA id n2-20020a62e502000000b00589a7824703sm4326825pff.194.2023.02.27.07.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 07:21:18 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, horenc@vt.edu,
        xiyou.wangcong@gmail.com
Cc:     bpf@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v3 10/18] bpf: devmap memory usage
Date:   Mon, 27 Feb 2023 15:20:24 +0000
Message-Id: <20230227152032.12359-11-laoar.shao@gmail.com>
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

