Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFFC4576B4
	for <lists+bpf@lfdr.de>; Fri, 19 Nov 2021 19:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235134AbhKSSx5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Nov 2021 13:53:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:59668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235090AbhKSSxu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Nov 2021 13:53:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0086C61AA2;
        Fri, 19 Nov 2021 18:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637347848;
        bh=iM0JcDXWu/mnHNcHeTMqwT7obsxOn7J0SxUPu3Te5+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AZY+R9BaVXoXQgkK7ILNuc+lYh5OPd4Aq0k+TSm/KnkaE4I6xOZd9s057mN+YYLJV
         Tkjq/P4MpL93TOVOesc6s989roQa7ZijYi1uk94vQ73y1JmJOpECvHDI5JZgdtNKgX
         ndR3tQangql3aur5Bm5O5I28fe7k4nbqOgvrEHKao1OdN48l2PO5BNAQRIFEuCHjXa
         /oGrxkCPAlHbJzUdySu32zvsP98EBM+hI+lw36RTGkfY8G7o5KpbxU6Lkha/jiytkF
         rxLGNQATAUMupGTUB8n0g2SWeZTU+q0WHv+DSS4/PG70l83NzvA/Bbcw6PG+HBA0yP
         XJSWocT0iPUXA==
From:   Jakub Kicinski <kuba@kernel.org>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     bpf@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: [RFC bpf-next 2/6] bpf: add header for enum bpf_cgroup_storage_type
Date:   Fri, 19 Nov 2021 10:50:39 -0800
Message-Id: <20211119185043.3937836-3-kuba@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211119185043.3937836-1-kuba@kernel.org>
References: <20211119185043.3937836-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

enum bpf_cgroup_storage_type is needed both in bpf.h and bpf-cgroup.h.
Since we want to break the cgroup -> bpf dependency we need to place
it in its own header.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/bpf-cgroup-types.h | 13 +++++++++++++
 include/linux/bpf.h              |  9 +--------
 2 files changed, 14 insertions(+), 8 deletions(-)
 create mode 100644 include/linux/bpf-cgroup-types.h

diff --git a/include/linux/bpf-cgroup-types.h b/include/linux/bpf-cgroup-types.h
new file mode 100644
index 000000000000..343dd5c2128d
--- /dev/null
+++ b/include/linux/bpf-cgroup-types.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _BPF_CGROUP_TYPES_H
+#define _BPF_CGROUP_TYPES_H
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
index cc7a0c36e7df..47f0a3cfec24 100644
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
-- 
2.31.1

