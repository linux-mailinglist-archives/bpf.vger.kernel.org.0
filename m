Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBBFE4750F6
	for <lists+bpf@lfdr.de>; Wed, 15 Dec 2021 03:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235326AbhLOCbv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Dec 2021 21:31:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235193AbhLOCbv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Dec 2021 21:31:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E531CC061574
        for <bpf@vger.kernel.org>; Tue, 14 Dec 2021 18:31:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80F696179F
        for <bpf@vger.kernel.org>; Wed, 15 Dec 2021 02:31:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABFE6C3460D;
        Wed, 15 Dec 2021 02:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639535509;
        bh=cCTLnOSDMiTu9pWEs/PeBoBxdZB4leyPkdVnN7/DQhU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q1aa+Drc9q1ziMIGGkq6sRxyG8fZMnQfNAbggELXAGDJsdar8/OHElXxB6XWmOa3D
         Y9kv0d1KeNdznDvBjfLq/Xaym1APkQXscuv2R+dO2/CuPfUCNzqjx0AcNM/rx8JFqc
         azFqXGpOQR7INcMcJs1iplkLYMyjMFXptU81leQCT8Ny2zZLZzfDG+QMZxmPcsY5uu
         TTT2PiQL/TdF4keCHBNL+Eb+joVFlfVfSV5LM9j3gUqfGIfwHT/EIUnHZ6NcHO0gmH
         POFueR7DengLRxKFk60Y3jwEJs8gEo+moBXl678Td8fU5zeXMdhp0fSe+JTvd1xVMz
         39HMDHpT6sM1Q==
From:   Jakub Kicinski <kuba@kernel.org>
To:     daniel@iogearbox.net, ast@kernel.org, andrii@kernel.org
Cc:     bpf@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH bpf-next v2 2/4] bpf: create a header for inline helpers
Date:   Tue, 14 Dec 2021 18:31:24 -0800
Message-Id: <20211215023126.659200-3-kuba@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211215023126.659200-1-kuba@kernel.org>
References: <20211215023126.659200-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

static inlines are notorious for creating inter-header dependencies.
Create a dedicated header where we can place include-heavy inlines
for bpf.

Put cgroup_storage_type() there. It needs to deference bpf_map and
access cgroup types thus creating a dependency between cgroup and
bpf.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/bpf-cgroup.h  |  9 ---------
 include/linux/bpf-inlines.h | 17 +++++++++++++++++
 kernel/bpf/helpers.c        |  1 +
 kernel/bpf/local_storage.c  |  1 +
 4 files changed, 19 insertions(+), 9 deletions(-)
 create mode 100644 include/linux/bpf-inlines.h

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
diff --git a/include/linux/bpf-inlines.h b/include/linux/bpf-inlines.h
new file mode 100644
index 000000000000..73d8429d22f1
--- /dev/null
+++ b/include/linux/bpf-inlines.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _BPF_INLINES_H
+#define _BPF_INLINES_H
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
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 8babae03d30a..d33216287b4d 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2011-2014 PLUMgrid, http://plumgrid.com
  */
 #include <linux/bpf.h>
+#include <linux/bpf-inlines.h>
 #include <linux/rcupdate.h>
 #include <linux/random.h>
 #include <linux/smp.h>
diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index 035e9e3a7132..bc8cfe03a37e 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -1,5 +1,6 @@
 //SPDX-License-Identifier: GPL-2.0
 #include <linux/bpf-cgroup.h>
+#include <linux/bpf-inlines.h>
 #include <linux/bpf.h>
 #include <linux/bpf_local_storage.h>
 #include <linux/btf.h>
-- 
2.31.1

