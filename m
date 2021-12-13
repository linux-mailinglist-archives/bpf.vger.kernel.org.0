Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF384738AD
	for <lists+bpf@lfdr.de>; Tue, 14 Dec 2021 00:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238160AbhLMXmk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Dec 2021 18:42:40 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:53864 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244221AbhLMXmj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Dec 2021 18:42:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D95AEB816E6
        for <bpf@vger.kernel.org>; Mon, 13 Dec 2021 23:42:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D59C34603;
        Mon, 13 Dec 2021 23:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639438957;
        bh=+8YZf4CrvNoHFQhLqu1whVy/qJgjDZkxMQ87oi+GMJg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rv3pVUUYsMCCRJuHihpLSwVJ1F29HWY4yV3RJuLlqdffa14hYfWi1FBrHpTiS/i0r
         m3+vQosoNKKTv9+oFe4yxVuHQCwcVdNpaqCVa0Gpaxf1iaE3ODhJxOpRyPmCg9gHe/
         4ZCLeLRi+FVGmNXBu+BqGc/ejtTyRUWszFU6Ie5mcjhtMBmoQdqSUYwtq0NX2oHF8l
         fGUCOD9g1kvGJqZvtSEasL6MMSZ182NfuXp6EwIJwfnr55E9WmMP2zg70CnRsp3SVU
         /lp4cFxqhtKVYzYjHFtld+QjqWyDcv2Q0XcIFaQgobpv26gejD6Bi9sCDfpBMaOL8C
         qm0HVjlwLNT/A==
From:   Jakub Kicinski <kuba@kernel.org>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     bpf@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH bpf-next 1/5] bpf: add header for enum bpf_cgroup_storage_type
Date:   Mon, 13 Dec 2021 15:42:19 -0800
Message-Id: <20211213234223.356977-2-kuba@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211213234223.356977-1-kuba@kernel.org>
References: <20211213234223.356977-1-kuba@kernel.org>
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
index 7a40022e3d00..b998347297ec 100644
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

