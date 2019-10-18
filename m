Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27E74DCF86
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2019 21:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440094AbfJRToa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Oct 2019 15:44:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55120 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440081AbfJRToa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Oct 2019 15:44:30 -0400
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com [209.85.208.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B1BE22D0FC7
        for <bpf@vger.kernel.org>; Fri, 18 Oct 2019 19:44:29 +0000 (UTC)
Received: by mail-lj1-f199.google.com with SMTP id l15so1331980lje.17
        for <bpf@vger.kernel.org>; Fri, 18 Oct 2019 12:44:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v3eNVDBnAH9AGnnWJdHHWAd28QMe+rGJCqeHl7RPnb8=;
        b=YSeVPdcf0gH/KEG5vlb8US9jWzlU3/RQ25+HWeBquotXx95tYm/FJjXbiwCXvwatGN
         GKQqUiIp0Cj/t7PUPohWkUtA05d/h6FvLKntPrOs8DsMe1mZQz8BpExI5pdvaQxJltyS
         WymWiCMgomTvKb9xds7+w0tst8SgQ1Rc9iOu+pdja9u/bC8zFqUt3H5ujl1RrhVntLg6
         7C0lfarECeXIX1V3aZiQtelQOREeB+v1bOWBxjgpUEJFFknFBZgGq1qomMURKLS7apCS
         FqwIy2K8wn4+2k3mlCO33TvYVIPsw3yl7tUBsaTl9RlrpCrxNPojVnTVHPf2fO/vM0eO
         O4NA==
X-Gm-Message-State: APjAAAXpC3ZADOEHWJatD2bkGaY9fIIsLSKNdnZPwVnyO5h8IoTnDgd+
        /yXSH2ZoX8wHLlCUk6rodZFG4oPtCWZ5BEZb7zrLsbAByl2+hr8Dh+m/CZxxVr3KIQLZeEMYR+F
        12I3lLveU4VJm
X-Received: by 2002:a2e:a211:: with SMTP id h17mr7184259ljm.251.1571427868224;
        Fri, 18 Oct 2019 12:44:28 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzAy4rTveML3hkNoYAHGQjhzvLK6CQZOhKdLfrvVC27x+M5xVdQcKIcHNtcD3HIyNWqd8Ne+w==
X-Received: by 2002:a2e:a211:: with SMTP id h17mr7184248ljm.251.1571427867983;
        Fri, 18 Oct 2019 12:44:27 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id o13sm2627404ljh.35.2019.10.18.12.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 12:44:27 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 6B9DA1804B6; Fri, 18 Oct 2019 21:44:26 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     daniel@iogearbox.net, ast@fb.com
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        bpf@vger.kernel.org, netdev@vger.kernel.org, kafai@fb.com,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH bpf v3] xdp: Handle device unregister for devmap_hash map type
Date:   Fri, 18 Oct 2019 21:44:18 +0200
Message-Id: <20191018194418.2951544-1-toke@redhat.com>
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
v3:
  - Use u32 for loop iterator variable
  - Since we're holding the lock we can just iterate with hlist_for_each_entry_safe()
v2:
  - Grab the update lock while walking the map and removing entries.

 kernel/bpf/devmap.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index c0a48f336997..012dbfb0f54b 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -719,6 +719,31 @@ const struct bpf_map_ops dev_map_hash_ops = {
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
@@ -735,6 +760,11 @@ static int dev_map_notification(struct notifier_block *notifier,
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

