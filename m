Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7B504752EB
	for <lists+bpf@lfdr.de>; Wed, 15 Dec 2021 07:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbhLOGTd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Dec 2021 01:19:33 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:50100 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbhLOGTb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Dec 2021 01:19:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07DCB61828
        for <bpf@vger.kernel.org>; Wed, 15 Dec 2021 06:19:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26FA6C3460B;
        Wed, 15 Dec 2021 06:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639549170;
        bh=l1u0kGbFQrEUX9Gn89KRkWqqryC0C4DEAu1820SpDTI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Twk8fPe8BRCemnqPFBPtgc8p2iqbbNlyEtBdoYswpOP8JOIcyWaHGK4X80SKeD+D7
         p0ltzN4HY3pe92Q6drFHAsE7yOq7EYtl31YmKTQm43f/2oiO8VE1TVVkxBsbqjYPvb
         FE3jr4oNclUgpzlvWOMMTeO+Exfsu6SunXlKKkf2J1HVcNP38pPbrJJCYsS5TVZwGG
         S5EOhoDHl6czXQreSb+fE6pBBHNbufJdmkL/r/u30k4bGENXDqcKELLWj1ztXSARBb
         PeWKX30+i2Go/3u1RJCFX++lnzri2h4i8gO82x402ZJ7yTn+0MqVCbMRwzErO+JvQu
         F+hY2WNMjCW+w==
From:   Jakub Kicinski <kuba@kernel.org>
To:     daniel@iogearbox.net, ast@kernel.org, andrii@kernel.org
Cc:     bpf@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH bpf-next v3 2/3] bpf: add header for enum bpf_cgroup_storage_type and bpf_link
Date:   Tue, 14 Dec 2021 22:19:15 -0800
Message-Id: <20211215061916.715513-3-kuba@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211215061916.715513-1-kuba@kernel.org>
References: <20211215061916.715513-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

enum bpf_cgroup_storage_type and struct bpf_link are needed both
in bpf.h and bpf-cgroup.h. Since we want to break the cgroup -> bpf
dependency we need to place it in its own header.

We can transform this header into some form of "kernel API"
header for BPF if more places want to include a lightweight
version of bpf.h. I'm calling it bpf-cgroup-types.h for now
mostly because naming is hard...

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/bpf-cgroup-types.h | 29 +++++++++++++++++++++++++++++
 include/linux/bpf.h              | 18 +-----------------
 2 files changed, 30 insertions(+), 17 deletions(-)
 create mode 100644 include/linux/bpf-cgroup-types.h

diff --git a/include/linux/bpf-cgroup-types.h b/include/linux/bpf-cgroup-types.h
new file mode 100644
index 000000000000..c916fd3f4a0f
--- /dev/null
+++ b/include/linux/bpf-cgroup-types.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _BPF_CGROUP_TYPES_H
+#define _BPF_CGROUP_TYPES_H
+
+#include <uapi/linux/bpf.h>
+
+#include <linux/workqueue.h>
+
+struct bpf_prog;
+struct bpf_link_ops;
+
+struct bpf_link {
+	atomic64_t refcnt;
+	u32 id;
+	enum bpf_link_type type;
+	const struct bpf_link_ops *ops;
+	struct bpf_prog *prog;
+	struct work_struct work;
+};
+
+enum bpf_cgroup_storage_type {
+	BPF_CGROUP_STORAGE_SHARED,
+	BPF_CGROUP_STORAGE_PERCPU,
+	__BPF_CGROUP_STORAGE_MAX
+};
+
+#define MAX_BPF_CGROUP_STORAGE_TYPE __BPF_CGROUP_STORAGE_MAX
+
+#endif
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 965fffaf0308..1e16243623fe 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -22,6 +22,7 @@
 #include <linux/sched/mm.h>
 #include <linux/slab.h>
 #include <linux/percpu-refcount.h>
+#include <linux/bpf-cgroup-types.h>
 #include <linux/bpfptr.h>
 
 struct bpf_verifier_env;
@@ -550,14 +551,6 @@ struct bpf_prog_offload {
 	u32			jited_len;
 };
 
-enum bpf_cgroup_storage_type {
-	BPF_CGROUP_STORAGE_SHARED,
-	BPF_CGROUP_STORAGE_PERCPU,
-	__BPF_CGROUP_STORAGE_MAX
-};
-
-#define MAX_BPF_CGROUP_STORAGE_TYPE __BPF_CGROUP_STORAGE_MAX
-
 /* The longest tracepoint has 12 args.
  * See include/trace/bpf_probe.h
  */
@@ -958,15 +951,6 @@ struct bpf_array_aux {
 	struct work_struct work;
 };
 
-struct bpf_link {
-	atomic64_t refcnt;
-	u32 id;
-	enum bpf_link_type type;
-	const struct bpf_link_ops *ops;
-	struct bpf_prog *prog;
-	struct work_struct work;
-};
-
 struct bpf_link_ops {
 	void (*release)(struct bpf_link *link);
 	void (*dealloc)(struct bpf_link *link);
-- 
2.31.1

