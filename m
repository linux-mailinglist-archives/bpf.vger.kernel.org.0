Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34EA14576B3
	for <lists+bpf@lfdr.de>; Fri, 19 Nov 2021 19:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbhKSSx4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Nov 2021 13:53:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:59676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235134AbhKSSxu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Nov 2021 13:53:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 57B1B61AD2;
        Fri, 19 Nov 2021 18:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637347848;
        bh=N89DVtM/C7GU55j1dJHLSOU+nswExmc+jtpbDvNOVZg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ml2N3fwZx99ea2S7w6WVGtmxbzaEjZXr/t17XhG6lZGuQ9wx5k9MoEvvR21FUQaua
         TgEt5irp914mQCIeSyptzFB4c5VvvlbCTc9eV2LsohomS24HIIHvLZemXY+MjfheVY
         0CimETYkATWT2VL7S+yITuZoia+9xl560N8liCPvZ9H8BukZBstBH/HD9DvJ5i+NoR
         dSqAt2C6m8ScSxa6A7T+8omrGcFJIjar6hlynNtosGhghbfdKeU4Ggp/SkkvH1ahjL
         oypFGnDvcI93L0JXeaZ7vgeuWONok6a3aUubyZGtCRmEnzz2CVltJvNcfqD3WydJLv
         c9x1BFOsLctdg==
From:   Jakub Kicinski <kuba@kernel.org>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     bpf@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: [RFC bpf-next 3/6] bpf: create a header for cgroup_storage_type()
Date:   Fri, 19 Nov 2021 10:50:40 -0800
Message-Id: <20211119185043.3937836-4-kuba@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211119185043.3937836-1-kuba@kernel.org>
References: <20211119185043.3937836-1-kuba@kernel.org>
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
index 1ffd469c217f..352acea8e53a 100644
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

