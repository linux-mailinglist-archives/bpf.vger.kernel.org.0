Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43FD6528DA
	for <lists+bpf@lfdr.de>; Tue, 20 Dec 2022 23:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234220AbiLTWVF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Dec 2022 17:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234150AbiLTWU4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Dec 2022 17:20:56 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C65B62CF
        for <bpf@vger.kernel.org>; Tue, 20 Dec 2022 14:20:53 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id h2-20020a17090a130200b00223faca3786so452082pja.0
        for <bpf@vger.kernel.org>; Tue, 20 Dec 2022 14:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nzrwtqxoT18C90ko5qH29Hib1sKDyAaEMw0UcTVessw=;
        b=s+seZOxU62F4YkOPvp86G1+PdqozkHLP/iIyazYlsx5R8MU6Lqx7tQjU8sEMbCmJtl
         asfSxCtdDkq+vosd9ol6+vapvN+UkpaKm0l0KBQ/h1/6AEEzQNvCDi+/z38ec7TPxLUv
         9OOLtvOSaxM1NhkHinipBNDUI3w3OjfaEdyIpYCLXblEidFZKo5M5Vm5RDHOy1h6j+WM
         iAbwKEWdo30r67QkQZO6xAjmdbDWDfv8w2DSkhZS3hyEicpjxig/da2p0khDoN/iUMeG
         NNDiyM1F/NfrsM31xMtfE75viCVLzxyi+U3stDN4bbj15QSQygeT8IF5sTJrg07GB1VX
         6+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nzrwtqxoT18C90ko5qH29Hib1sKDyAaEMw0UcTVessw=;
        b=g5dwp/4gh5MTlXo2MA9p8CUsovSODmqtRnqRpwxLNDnPae2BXu4EBcmAHfke86WxQ3
         /sDfC/1BHcy7rilGVpAG3X7MwBWoSQtJxlhLEflTPEX+PDdmbNGIcHvG9KAT5jJTPk3M
         3TmXRYmDs/GGFZo22+C3nnrOHqttchqcEu48RZDFF7csAL+poHzkevKC68U8dtYz0D9P
         IGZP+YwcJPTItSR0drxC4vyBnwz7J5F6PoB9GTyG+mRzHsoPZYcwWHtvwybX7Sm515w1
         CcAcVNtbXpQ0BP3/ZsOGKMymkUbhcpaP1P+uP5mLRuHhjMfYlL5OHO55w0U6gfczApda
         AbYw==
X-Gm-Message-State: ANoB5pkc2kWiM5BzZb1EP6zlslM9wu6izAPTZjTlNsaIfRPZEGTaPLQx
        o1VIAEbj6MLC3BaevIcsupiunqlVR1YxcEiL00k5u2371+On89oAcC7MqBKXh+MIus5wtI47Rc/
        wnz1mPj50r//XeJ68UL9v+JO5BUAOBEt1RpGDbXQ9Uq4RSBz9HA==
X-Google-Smtp-Source: AA0mqf7DebJ/vbQzCts5DPyuhD6PbeEFlr4yPNOGQtT8UN1eyUzh6pwLUuSKWfmcZPbgAaIrzGDjz1s=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:3201:b0:576:670e:5de2 with SMTP id
 bm1-20020a056a00320100b00576670e5de2mr31295013pfb.70.1671574852632; Tue, 20
 Dec 2022 14:20:52 -0800 (PST)
Date:   Tue, 20 Dec 2022 14:20:30 -0800
In-Reply-To: <20221220222043.3348718-1-sdf@google.com>
Mime-Version: 1.0
References: <20221220222043.3348718-1-sdf@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221220222043.3348718-5-sdf@google.com>
Subject: [PATCH bpf-next v5 04/17] bpf: Reshuffle some parts of bpf/offload.c
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        David Ahern <dsahern@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Anatoly Burakov <anatoly.burakov@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

To avoid adding forward declarations in the main patch, shuffle
some code around. No functional changes.

Cc: John Fastabend <john.fastabend@gmail.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Jesper Dangaard Brouer <brouer@redhat.com>
Cc: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: Alexander Lobakin <alexandr.lobakin@intel.com>
Cc: Magnus Karlsson <magnus.karlsson@gmail.com>
Cc: Maryam Tahhan <mtahhan@redhat.com>
Cc: xdp-hints@xdp-project.net
Cc: netdev@vger.kernel.org
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 kernel/bpf/offload.c | 222 +++++++++++++++++++++++--------------------
 1 file changed, 117 insertions(+), 105 deletions(-)

diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index 621e8738f304..deb06498da0b 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -74,6 +74,121 @@ bpf_offload_find_netdev(struct net_device *netdev)
 	return rhashtable_lookup_fast(&offdevs, &netdev, offdevs_params);
 }
 
+static int __bpf_offload_dev_netdev_register(struct bpf_offload_dev *offdev,
+					     struct net_device *netdev)
+{
+	struct bpf_offload_netdev *ondev;
+	int err;
+
+	ondev = kzalloc(sizeof(*ondev), GFP_KERNEL);
+	if (!ondev)
+		return -ENOMEM;
+
+	ondev->netdev = netdev;
+	ondev->offdev = offdev;
+	INIT_LIST_HEAD(&ondev->progs);
+	INIT_LIST_HEAD(&ondev->maps);
+
+	down_write(&bpf_devs_lock);
+	err = rhashtable_insert_fast(&offdevs, &ondev->l, offdevs_params);
+	if (err) {
+		netdev_warn(netdev, "failed to register for BPF offload\n");
+		goto err_unlock_free;
+	}
+
+	list_add(&ondev->offdev_netdevs, &offdev->netdevs);
+	up_write(&bpf_devs_lock);
+	return 0;
+
+err_unlock_free:
+	up_write(&bpf_devs_lock);
+	kfree(ondev);
+	return err;
+}
+
+static void __bpf_prog_offload_destroy(struct bpf_prog *prog)
+{
+	struct bpf_prog_offload *offload = prog->aux->offload;
+
+	if (offload->dev_state)
+		offload->offdev->ops->destroy(prog);
+
+	/* Make sure BPF_PROG_GET_NEXT_ID can't find this dead program */
+	bpf_prog_free_id(prog, true);
+
+	list_del_init(&offload->offloads);
+	kfree(offload);
+	prog->aux->offload = NULL;
+}
+
+static int bpf_map_offload_ndo(struct bpf_offloaded_map *offmap,
+			       enum bpf_netdev_command cmd)
+{
+	struct netdev_bpf data = {};
+	struct net_device *netdev;
+
+	ASSERT_RTNL();
+
+	data.command = cmd;
+	data.offmap = offmap;
+	/* Caller must make sure netdev is valid */
+	netdev = offmap->netdev;
+
+	return netdev->netdev_ops->ndo_bpf(netdev, &data);
+}
+
+static void __bpf_map_offload_destroy(struct bpf_offloaded_map *offmap)
+{
+	WARN_ON(bpf_map_offload_ndo(offmap, BPF_OFFLOAD_MAP_FREE));
+	/* Make sure BPF_MAP_GET_NEXT_ID can't find this dead map */
+	bpf_map_free_id(&offmap->map, true);
+	list_del_init(&offmap->offloads);
+	offmap->netdev = NULL;
+}
+
+static void __bpf_offload_dev_netdev_unregister(struct bpf_offload_dev *offdev,
+						struct net_device *netdev)
+{
+	struct bpf_offload_netdev *ondev, *altdev;
+	struct bpf_offloaded_map *offmap, *mtmp;
+	struct bpf_prog_offload *offload, *ptmp;
+
+	ASSERT_RTNL();
+
+	down_write(&bpf_devs_lock);
+	ondev = rhashtable_lookup_fast(&offdevs, &netdev, offdevs_params);
+	if (WARN_ON(!ondev))
+		goto unlock;
+
+	WARN_ON(rhashtable_remove_fast(&offdevs, &ondev->l, offdevs_params));
+	list_del(&ondev->offdev_netdevs);
+
+	/* Try to move the objects to another netdev of the device */
+	altdev = list_first_entry_or_null(&offdev->netdevs,
+					  struct bpf_offload_netdev,
+					  offdev_netdevs);
+	if (altdev) {
+		list_for_each_entry(offload, &ondev->progs, offloads)
+			offload->netdev = altdev->netdev;
+		list_splice_init(&ondev->progs, &altdev->progs);
+
+		list_for_each_entry(offmap, &ondev->maps, offloads)
+			offmap->netdev = altdev->netdev;
+		list_splice_init(&ondev->maps, &altdev->maps);
+	} else {
+		list_for_each_entry_safe(offload, ptmp, &ondev->progs, offloads)
+			__bpf_prog_offload_destroy(offload->prog);
+		list_for_each_entry_safe(offmap, mtmp, &ondev->maps, offloads)
+			__bpf_map_offload_destroy(offmap);
+	}
+
+	WARN_ON(!list_empty(&ondev->progs));
+	WARN_ON(!list_empty(&ondev->maps));
+	kfree(ondev);
+unlock:
+	up_write(&bpf_devs_lock);
+}
+
 int bpf_prog_offload_init(struct bpf_prog *prog, union bpf_attr *attr)
 {
 	struct bpf_offload_netdev *ondev;
@@ -206,21 +321,6 @@ bpf_prog_offload_remove_insns(struct bpf_verifier_env *env, u32 off, u32 cnt)
 	up_read(&bpf_devs_lock);
 }
 
-static void __bpf_prog_offload_destroy(struct bpf_prog *prog)
-{
-	struct bpf_prog_offload *offload = prog->aux->offload;
-
-	if (offload->dev_state)
-		offload->offdev->ops->destroy(prog);
-
-	/* Make sure BPF_PROG_GET_NEXT_ID can't find this dead program */
-	bpf_prog_free_id(prog, true);
-
-	list_del_init(&offload->offloads);
-	kfree(offload);
-	prog->aux->offload = NULL;
-}
-
 void bpf_prog_offload_destroy(struct bpf_prog *prog)
 {
 	down_write(&bpf_devs_lock);
@@ -340,22 +440,6 @@ int bpf_prog_offload_info_fill(struct bpf_prog_info *info,
 const struct bpf_prog_ops bpf_offload_prog_ops = {
 };
 
-static int bpf_map_offload_ndo(struct bpf_offloaded_map *offmap,
-			       enum bpf_netdev_command cmd)
-{
-	struct netdev_bpf data = {};
-	struct net_device *netdev;
-
-	ASSERT_RTNL();
-
-	data.command = cmd;
-	data.offmap = offmap;
-	/* Caller must make sure netdev is valid */
-	netdev = offmap->netdev;
-
-	return netdev->netdev_ops->ndo_bpf(netdev, &data);
-}
-
 struct bpf_map *bpf_map_offload_map_alloc(union bpf_attr *attr)
 {
 	struct net *net = current->nsproxy->net_ns;
@@ -405,15 +489,6 @@ struct bpf_map *bpf_map_offload_map_alloc(union bpf_attr *attr)
 	return ERR_PTR(err);
 }
 
-static void __bpf_map_offload_destroy(struct bpf_offloaded_map *offmap)
-{
-	WARN_ON(bpf_map_offload_ndo(offmap, BPF_OFFLOAD_MAP_FREE));
-	/* Make sure BPF_MAP_GET_NEXT_ID can't find this dead map */
-	bpf_map_free_id(&offmap->map, true);
-	list_del_init(&offmap->offloads);
-	offmap->netdev = NULL;
-}
-
 void bpf_map_offload_map_free(struct bpf_map *map)
 {
 	struct bpf_offloaded_map *offmap = map_to_offmap(map);
@@ -592,77 +667,14 @@ bool bpf_offload_prog_map_match(struct bpf_prog *prog, struct bpf_map *map)
 int bpf_offload_dev_netdev_register(struct bpf_offload_dev *offdev,
 				    struct net_device *netdev)
 {
-	struct bpf_offload_netdev *ondev;
-	int err;
-
-	ondev = kzalloc(sizeof(*ondev), GFP_KERNEL);
-	if (!ondev)
-		return -ENOMEM;
-
-	ondev->netdev = netdev;
-	ondev->offdev = offdev;
-	INIT_LIST_HEAD(&ondev->progs);
-	INIT_LIST_HEAD(&ondev->maps);
-
-	down_write(&bpf_devs_lock);
-	err = rhashtable_insert_fast(&offdevs, &ondev->l, offdevs_params);
-	if (err) {
-		netdev_warn(netdev, "failed to register for BPF offload\n");
-		goto err_unlock_free;
-	}
-
-	list_add(&ondev->offdev_netdevs, &offdev->netdevs);
-	up_write(&bpf_devs_lock);
-	return 0;
-
-err_unlock_free:
-	up_write(&bpf_devs_lock);
-	kfree(ondev);
-	return err;
+	return __bpf_offload_dev_netdev_register(offdev, netdev);
 }
 EXPORT_SYMBOL_GPL(bpf_offload_dev_netdev_register);
 
 void bpf_offload_dev_netdev_unregister(struct bpf_offload_dev *offdev,
 				       struct net_device *netdev)
 {
-	struct bpf_offload_netdev *ondev, *altdev;
-	struct bpf_offloaded_map *offmap, *mtmp;
-	struct bpf_prog_offload *offload, *ptmp;
-
-	ASSERT_RTNL();
-
-	down_write(&bpf_devs_lock);
-	ondev = rhashtable_lookup_fast(&offdevs, &netdev, offdevs_params);
-	if (WARN_ON(!ondev))
-		goto unlock;
-
-	WARN_ON(rhashtable_remove_fast(&offdevs, &ondev->l, offdevs_params));
-	list_del(&ondev->offdev_netdevs);
-
-	/* Try to move the objects to another netdev of the device */
-	altdev = list_first_entry_or_null(&offdev->netdevs,
-					  struct bpf_offload_netdev,
-					  offdev_netdevs);
-	if (altdev) {
-		list_for_each_entry(offload, &ondev->progs, offloads)
-			offload->netdev = altdev->netdev;
-		list_splice_init(&ondev->progs, &altdev->progs);
-
-		list_for_each_entry(offmap, &ondev->maps, offloads)
-			offmap->netdev = altdev->netdev;
-		list_splice_init(&ondev->maps, &altdev->maps);
-	} else {
-		list_for_each_entry_safe(offload, ptmp, &ondev->progs, offloads)
-			__bpf_prog_offload_destroy(offload->prog);
-		list_for_each_entry_safe(offmap, mtmp, &ondev->maps, offloads)
-			__bpf_map_offload_destroy(offmap);
-	}
-
-	WARN_ON(!list_empty(&ondev->progs));
-	WARN_ON(!list_empty(&ondev->maps));
-	kfree(ondev);
-unlock:
-	up_write(&bpf_devs_lock);
+	__bpf_offload_dev_netdev_unregister(offdev, netdev);
 }
 EXPORT_SYMBOL_GPL(bpf_offload_dev_netdev_unregister);
 
-- 
2.39.0.314.g84b9a713c41-goog

