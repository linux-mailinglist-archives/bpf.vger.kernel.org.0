Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9557C4738B0
	for <lists+bpf@lfdr.de>; Tue, 14 Dec 2021 00:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244221AbhLMXml (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Dec 2021 18:42:41 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:53890 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244233AbhLMXml (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Dec 2021 18:42:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2218EB816E6
        for <bpf@vger.kernel.org>; Mon, 13 Dec 2021 23:42:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2370C34615;
        Mon, 13 Dec 2021 23:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639438958;
        bh=Yhif4MF/BZX9oRk0V9GdftA13TztKqwgFVmF4zd71HU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lajj/C3aUW2zHM3eWwG5QxhQjZLMHgDU7rk/qzTTnOMRdnYrW8nbBcJLe4dYeOJ+r
         MYaqBHtmwwj3Cc+PELVjoz36V/m1hTq3FJ+dvoLjsIUEcUdnO35Cpqe490FDAMgJtZ
         W1kRVgztHWo9jmqFveEE81ugX2ZNluTM2ty4seJc69l4N+vHX7BgdtPXgSz3PCQl7f
         zuU4fKAnO03jmfu0cSQL2is4fj/mh4Ig+/MVvZ5OTjSa7fVrn6/kacD/ndZlhkLuCP
         BoAtBum6sunvSpJs5I5KnM0nseknueji7B0tzde0iHTVXRsfg6zu8MBIXLIqDJc1xL
         pWKRjiDSna/jg==
From:   Jakub Kicinski <kuba@kernel.org>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     bpf@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH bpf-next 5/5] bpf: push down the bpf-link include
Date:   Mon, 13 Dec 2021 15:42:23 -0800
Message-Id: <20211213234223.356977-6-kuba@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211213234223.356977-1-kuba@kernel.org>
References: <20211213234223.356977-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Turns out bpf_link is not dereferenced or embedded much.
Since we have separated it out to its own header why not
drop the include from bpf.h completely...

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/bpf.h   | 2 +-
 kernel/bpf/bpf_iter.c | 1 +
 kernel/bpf/syscall.c  | 1 +
 net/core/dev.c        | 1 +
 4 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 64bdae62a594..0be6890f01ec 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -23,12 +23,12 @@
 #include <linux/slab.h>
 #include <linux/percpu-refcount.h>
 #include <linux/bpf-cgroup-types.h>
-#include <linux/bpf-link.h>
 #include <linux/bpfptr.h>
 
 struct bpf_verifier_env;
 struct bpf_verifier_log;
 struct perf_event;
+struct bpf_link;
 struct bpf_prog;
 struct bpf_prog_aux;
 struct bpf_map;
diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index b7aef5b3416d..9e4d00446227 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -5,6 +5,7 @@
 #include <linux/anon_inodes.h>
 #include <linux/filter.h>
 #include <linux/bpf.h>
+#include <linux/bpf-link.h>
 
 struct bpf_iter_target_info {
 	struct list_head list;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index ddd81d543203..9034bb833ec3 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5,6 +5,7 @@
 #include <linux/bpf_trace.h>
 #include <linux/bpf_lirc.h>
 #include <linux/bpf_verifier.h>
+#include <linux/bpf-link.h>
 #include <linux/btf.h>
 #include <linux/syscalls.h>
 #include <linux/slab.h>
diff --git a/net/core/dev.c b/net/core/dev.c
index 4420086f3aeb..d8e51e826852 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -93,6 +93,7 @@
 #include <linux/skbuff.h>
 #include <linux/kthread.h>
 #include <linux/bpf.h>
+#include <linux/bpf-link.h>
 #include <linux/bpf_trace.h>
 #include <net/net_namespace.h>
 #include <net/sock.h>
-- 
2.31.1

