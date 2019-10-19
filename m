Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD214DD86F
	for <lists+bpf@lfdr.de>; Sat, 19 Oct 2019 13:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbfJSLTo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Oct 2019 07:19:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32958 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbfJSLTo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Oct 2019 07:19:44 -0400
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com [209.85.208.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 442CDC057E9F
        for <bpf@vger.kernel.org>; Sat, 19 Oct 2019 11:19:43 +0000 (UTC)
Received: by mail-lj1-f200.google.com with SMTP id v19so1613115ljc.15
        for <bpf@vger.kernel.org>; Sat, 19 Oct 2019 04:19:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zsQ4PRZBT0X88Ct0c9NHjskC+viE4xcTsQ4A1NGvMMQ=;
        b=i+pmBRuIbYpgF3elrptfSYIZ60AOw3gOhtjTO7Sw8ncP0RjjSAJhFSA92qpD121L2o
         hZsiwNiptLuiTLFJ2RKa7PQJQv+73EQrGAYnNU1XI0c9J78zQtdwq38CoDI0NoVsECOr
         abTcVCzUESeMXsX8ZR6CC3Km4VmvAHN0+qw73zzsHzX1aZqX61UnIz/r5gKmHNrZbhxF
         myj0Kv4yQfP1Jj5H5qDAXaueAQGnFNwc8hFDuA6QnuuQVaFUWhjKTb7yqkLPDP0IBoyD
         lridq3xv8GBXC+JXAyyP8VUOQXyMMWSaEuO2sshf1XdV9nk9eI667ZqF/rGJNGGSDhEc
         arNQ==
X-Gm-Message-State: APjAAAWnokQc5PrD7iNsc/pcymeqL9trVrqs/Gs67V+mN1jbeWQBYvel
        8Ba/BLpH7fnGEsIweYSz5DVT+VoU8owR6T85zAvlhsbHEq+p5BbNqTRlgs6jscbETUmM7o4D7yW
        VFq0HhKoehTP1
X-Received: by 2002:a2e:8183:: with SMTP id e3mr8961654ljg.14.1571483981773;
        Sat, 19 Oct 2019 04:19:41 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxUvgxH2R8FMM1vsd+QTnKOBnPsc+ShRsupwCqVXOA57yOMU7Bwx9JOqUQNmGVtZ3sjnHNhXQ==
X-Received: by 2002:a2e:8183:: with SMTP id e3mr8961645ljg.14.1571483981596;
        Sat, 19 Oct 2019 04:19:41 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id d9sm375225lfj.81.2019.10.19.04.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2019 04:19:40 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id D52051804C8; Sat, 19 Oct 2019 13:19:39 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     daniel@iogearbox.net, ast@fb.com
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        bpf@vger.kernel.org, netdev@vger.kernel.org, kafai@fb.com,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH bpf v4] xdp: Handle device unregister for devmap_hash map type
Date:   Sat, 19 Oct 2019 13:19:31 +0200
Message-Id: <20191019111931.2981954-1-toke@redhat.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It seems I forgot to add handling of devmap_hash type maps to the device
unregister hook for devmaps. This omission causes devices to not be
properly released, which causes hangs.

Fix this by adding the missing handler.

Fixes: 6f9d451ab1a3 ("xdp: Add devmap_hash map type for looking up devices by hashed index")
Reported-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
v4:
  - Don't forget to decrement dtab->items when removing item from map
v3:
  - Use u32 for loop iterator variable
  - Since we're holding the lock we can just iterate with hlist_for_each_entry_safe()
v2:
  - Grab the update lock while walking the map and removing entries.

 kernel/bpf/devmap.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index c0a48f336997..3867864cdc2f 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -719,6 +719,32 @@ const struct bpf_map_ops dev_map_hash_ops = {
 	.map_check_btf = map_check_no_btf,
 };
 
+static void dev_map_hash_remove_netdev(struct bpf_dtab *dtab,
+				       struct net_device *netdev)
+{
+	unsigned long flags;
+	u32 i;
+
+	spin_lock_irqsave(&dtab->index_lock, flags);
+	for (i = 0; i < dtab->n_buckets; i++) {
+		struct bpf_dtab_netdev *dev;
+		struct hlist_head *head;
+		struct hlist_node *next;
+
+		head = dev_map_index_hash(dtab, i);
+
+		hlist_for_each_entry_safe(dev, next, head, index_hlist) {
+			if (netdev != dev->dev)
+				continue;
+
+			dtab->items--;
+			hlist_del_rcu(&dev->index_hlist);
+			call_rcu(&dev->rcu, __dev_map_entry_free);
+		}
+	}
+	spin_unlock_irqrestore(&dtab->index_lock, flags);
+}
+
 static int dev_map_notification(struct notifier_block *notifier,
 				ulong event, void *ptr)
 {
@@ -735,6 +761,11 @@ static int dev_map_notification(struct notifier_block *notifier,
 		 */
 		rcu_read_lock();
 		list_for_each_entry_rcu(dtab, &dev_map_list, list) {
+			if (dtab->map.map_type == BPF_MAP_TYPE_DEVMAP_HASH) {
+				dev_map_hash_remove_netdev(dtab, netdev);
+				continue;
+			}
+
 			for (i = 0; i < dtab->map.max_entries; i++) {
 				struct bpf_dtab_netdev *dev, *odev;
 
-- 
2.23.0

