Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0865E20F9B5
	for <lists+bpf@lfdr.de>; Tue, 30 Jun 2020 18:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732786AbgF3Qpp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Jun 2020 12:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730177AbgF3Qpp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Jun 2020 12:45:45 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B07DC03E979
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2020 09:45:45 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id o18so16899125eje.7
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2020 09:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+yEeZlarbU91uv0Ql8B8++SYTfNGG1/xTWpTrvqqrIs=;
        b=jqC/OX7Y8MzrYNjy3ylDnmQrQEj41yQrMHdqbjONWSdJzGGzowJg7j5RkFACBM+IIB
         EtNkze+ogacTgiD7ULUOoLnXgngUgdfxb8LKLgmrn9uON8+5NZG/iB19+War2iUYR5BI
         XE0lAH5A0TiGHtu2rGMDiBuFuUO2eqCDSRLk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+yEeZlarbU91uv0Ql8B8++SYTfNGG1/xTWpTrvqqrIs=;
        b=TIxDzQZOElSflE3min44UnmaA9+iaHbjADpI2NibSoUgT+YRwLw+dc7HeiapAPdR0C
         aTYexPQYC9PwC5EZlGmd45znXyFBFCyQOzfW+XkWlhTkgNlR4nnJveIi5T74ggn8+S71
         ZXPzqi9sGoCc6NnvkTHtMIoo5KMOG1nPJK7ZG1Ws/oGKpar6eD0IYuVw+T+r0J0uwEkd
         zXtn2dX+a9WnRvY56aiuQpBtNWUNxmbKUuYFR9OR5mgSF7S7sD70B6jkzImcdP5l2E4V
         Cm+ERMoamxuF4clH6jsScdfhD/HVJVlZZjY4hzBnYhCVQDhPyZORcGbb3Bd2xhTfvlHa
         +jmQ==
X-Gm-Message-State: AOAM530V5YtCyJkkXDdm483KHmUCS0v6DmP6n9kXsHgbH1f4JKZjseJd
        zNGXpzqlQgazmc7JodAAG4xyMaiJDJThRQ==
X-Google-Smtp-Source: ABdhPJzRVgS9U13GNiAqIdjjxWiez3ls3peNZFKlFuH4dSOywiqz3PY7PuJj0Gh6g6HM8nRRxeYwZg==
X-Received: by 2002:a17:906:444e:: with SMTP id i14mr6947851ejp.418.1593535543110;
        Tue, 30 Jun 2020 09:45:43 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id y21sm2420738ejp.32.2020.06.30.09.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 09:45:42 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com
Subject: [PATCH bpf-next] bpf, netns: Fix use-after-free in pernet pre_exit callback
Date:   Tue, 30 Jun 2020 18:45:41 +0200
Message-Id: <20200630164541.1329993-1-jakub@cloudflare.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Iterating over BPF links attached to network namespace in pre_exit hook is
not safe, even if there is just one. Once link gets auto-detached, that is
its back-pointer to net object is set to NULL, the link can be released and
freed without waiting on netns_bpf_mutex, effectively causing the list
element we are operating on to be freed.

This leads to use-after-free when trying to access the next element on the
list, as reported by KASAN. Bug can be triggered by destroying a network
namespace, while also releasing a link attached to this network namespace.

| ==================================================================
| BUG: KASAN: use-after-free in netns_bpf_pernet_pre_exit+0xd9/0x130
| Read of size 8 at addr ffff888119e0d778 by task kworker/u8:2/177
|
| CPU: 3 PID: 177 Comm: kworker/u8:2 Not tainted 5.8.0-rc1-00197-ga0c04c9d1008-dirty #776
| Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20190727_073836-buildvm-ppc64le-16.ppc.fedoraproject.org-3.fc31 04/01/2014
| Workqueue: netns cleanup_net
| Call Trace:
|  dump_stack+0x9e/0xe0
|  print_address_description.constprop.0+0x3a/0x60
|  ? netns_bpf_pernet_pre_exit+0xd9/0x130
|  kasan_report.cold+0x1f/0x40
|  ? netns_bpf_pernet_pre_exit+0xd9/0x130
|  netns_bpf_pernet_pre_exit+0xd9/0x130
|  cleanup_net+0x30b/0x5b0
|  ? unregister_pernet_device+0x50/0x50
|  ? rcu_read_lock_bh_held+0xb0/0xb0
|  ? _raw_spin_unlock_irq+0x24/0x50
|  process_one_work+0x4d1/0xa10
|  ? lock_release+0x3e0/0x3e0
|  ? pwq_dec_nr_in_flight+0x110/0x110
|  ? rwlock_bug.part.0+0x60/0x60
|  worker_thread+0x7a/0x5c0
|  ? process_one_work+0xa10/0xa10
|  kthread+0x1e3/0x240
|  ? kthread_create_on_node+0xd0/0xd0
|  ret_from_fork+0x1f/0x30
|
| Allocated by task 280:
|  save_stack+0x1b/0x40
|  __kasan_kmalloc.constprop.0+0xc2/0xd0
|  netns_bpf_link_create+0xfe/0x650
|  __do_sys_bpf+0x153a/0x2a50
|  do_syscall_64+0x59/0x300
|  entry_SYSCALL_64_after_hwframe+0x44/0xa9
|
| Freed by task 198:
|  save_stack+0x1b/0x40
|  __kasan_slab_free+0x12f/0x180
|  kfree+0xed/0x350
|  process_one_work+0x4d1/0xa10
|  worker_thread+0x7a/0x5c0
|  kthread+0x1e3/0x240
|  ret_from_fork+0x1f/0x30
|
| The buggy address belongs to the object at ffff888119e0d700
|  which belongs to the cache kmalloc-192 of size 192
| The buggy address is located 120 bytes inside of
|  192-byte region [ffff888119e0d700, ffff888119e0d7c0)
| The buggy address belongs to the page:
| page:ffffea0004678340 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0
| flags: 0x2fffe0000000200(slab)
| raw: 02fffe0000000200 ffffea00045ba8c0 0000000600000006 ffff88811a80ea80
| raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
| page dumped because: kasan: bad access detected
|
| Memory state around the buggy address:
|  ffff888119e0d600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
|  ffff888119e0d680: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
| >ffff888119e0d700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
|                                                                 ^
|  ffff888119e0d780: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
|  ffff888119e0d800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
| ==================================================================

Remove the "fast-path" for releasing a link that got auto-detached by a
dying network namespace to fix it. This way as long as link is on the list
and netns_bpf mutex is held, we have a guarantee that link memory can be
accessed.

An alternative way to fix this issue would be to safely iterate over the
list of links and ensure there is no access to link object after detaching
it. But, at the moment, optimizing synchronization overhead on link release
without a workload in mind seems like an overkill.

Fixes: 7233adc8b69b ("bpf, netns: Keep a list of attached bpf_link's")
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 kernel/bpf/net_namespace.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/net_namespace.c b/kernel/bpf/net_namespace.c
index 7a34a8caf954..247543380fa6 100644
--- a/kernel/bpf/net_namespace.c
+++ b/kernel/bpf/net_namespace.c
@@ -43,15 +43,11 @@ static void bpf_netns_link_release(struct bpf_link *link)
 	enum netns_bpf_attach_type type = net_link->netns_type;
 	struct net *net;
 
-	/* Link auto-detached by dying netns. */
-	if (!net_link->net)
-		return;
-
 	mutex_lock(&netns_bpf_mutex);
 
-	/* Recheck after potential sleep. We can race with cleanup_net
-	 * here, but if we see a non-NULL struct net pointer pre_exit
-	 * has not happened yet and will block on netns_bpf_mutex.
+	/* We can race with cleanup_net, but if we see a non-NULL
+	 * struct net pointer, pre_exit has not run yet and wait for
+	 * netns_bpf_mutex.
 	 */
 	net = net_link->net;
 	if (!net)
-- 
2.25.4

