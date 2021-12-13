Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4DBB4738AE
	for <lists+bpf@lfdr.de>; Tue, 14 Dec 2021 00:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244242AbhLMXml (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Dec 2021 18:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244221AbhLMXmk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Dec 2021 18:42:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE98C061574
        for <bpf@vger.kernel.org>; Mon, 13 Dec 2021 15:42:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30B7CB8172A
        for <bpf@vger.kernel.org>; Mon, 13 Dec 2021 23:42:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B11C34607;
        Mon, 13 Dec 2021 23:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639438958;
        bh=AZeAw8ZpijrLJ/heFqc1Js2PpzpOVDrm4r7bXzirfLo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YQaImhnfxs4xN0GitYzLmLxJOb7PcIWO2bfOs6JzMg3oZovrhsCnG5wZwYISyNwMJ
         q/Je9+sTd2+uIrYuWGMX4ua+TzThXNv8MBZB0kzyskhXN+HEszFoyQ6snrI4UVwl3W
         /fROhh/8N0pauzrxgPZRy0cNPV6ZxkOAYFUOsQn7MEZmRokM223nxo5tJNlL9/PTEz
         3G0HsnwZL6Ln3r1SWVhZ3ZwJb56mMQdUxhTNJbo34r84L1fuGHgDm9HBK+wZOTZqJE
         IkDa5PQaWQq9geWjBpMUFY+YRfX/EOnvUCoaqt6Ayvxho4mao59qqN0PfhPflQ1nqL
         8zphrZR+fjwvA==
From:   Jakub Kicinski <kuba@kernel.org>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     bpf@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH bpf-next 2/5] bpf: create a header for cgroup_storage_type()
Date:   Mon, 13 Dec 2021 15:42:20 -0800
Message-Id: <20211213234223.356977-3-kuba@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211213234223.356977-1-kuba@kernel.org>
References: <20211213234223.356977-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

cgroup_storage_type() is a static inline which needs to deference
bpf_map. Move it to its own header so that we don't need to pull
in bpf.h. It only has a couple of callers.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/bpf-cgroup-storage.h | 17 +++++++++++++++++
 include/linux/bpf-cgroup.h         |  9 ---------
 kernel/bpf/helpers.c               |  1 +
 kernel/bpf/local_storage.c         |  1 +
 4 files changed, 19 insertions(+), 9 deletions(-)
 create mode 100644 include/linux/bpf-cgroup-storage.h

diff --git a/include/linux/bpf-cgroup-storage.h b/include/linux/bpf-cgroup-storage.h
new file mode 100644
index 000000000000..0e0f3409c586
--- /dev/null
+++ b/include/linux/bpf-cgroup-storage.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _BPF_CGROUP_STORAGE_H
+#define _BPF_CGROUP_STORAGE_H
+
+#include <linux/bpf.h>
+#include <linux/bpf-cgroup.h>
+
+static inline enum bpf_cgroup_storage_type cgroup_storage_type(
+	struct bpf_map *map)
+{
+	if (map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE)
+		return BPF_CGROUP_STORAGE_PERCPU;
+
+	return BPF_CGROUP_STORAGE_SHARED;
+}
+
+#endif
diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 11820a430d6c..12474516e0be 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -194,15 +194,6 @@ int __cgroup_bpf_run_filter_getsockopt_kern(struct sock *sk, int level,
 					    int optname, void *optval,
 					    int *optlen, int retval);
 
-static inline enum bpf_cgroup_storage_type cgroup_storage_type(
-	struct bpf_map *map)
-{
-	if (map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE)
-		return BPF_CGROUP_STORAGE_PERCPU;
-
-	return BPF_CGROUP_STORAGE_SHARED;
-}
-
 struct bpf_cgroup_storage *
 cgroup_storage_lookup(struct bpf_cgroup_storage_map *map,
 		      void *key, bool locked);
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 8babae03d30a..415c38222069 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2011-2014 PLUMgrid, http://plumgrid.com
  */
 #include <linux/bpf.h>
+#include <linux/bpf-cgroup-storage.h>
 #include <linux/rcupdate.h>
 #include <linux/random.h>
 #include <linux/smp.h>
diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index 035e9e3a7132..195f9c13ef5b 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -1,5 +1,6 @@
 //SPDX-License-Identifier: GPL-2.0
 #include <linux/bpf-cgroup.h>
+#include <linux/bpf-cgroup-storage.h>
 #include <linux/bpf.h>
 #include <linux/bpf_local_storage.h>
 #include <linux/btf.h>
-- 
2.31.1

