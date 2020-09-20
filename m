Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAC027150A
	for <lists+bpf@lfdr.de>; Sun, 20 Sep 2020 16:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbgITOqD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Sep 2020 10:46:03 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:50311 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726290AbgITOqD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 20 Sep 2020 10:46:03 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R761e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0U9V.p7K_1600613153;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0U9V.p7K_1600613153)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 20 Sep 2020 22:45:54 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     ast@kernel.org
Cc:     daniel@iogearbox.net, kafai@fb.com, andriin@fb.com,
        xhao@linux.alibaba.com, bpf@vger.kernel.org
Subject: [bpf-next 1/3] sample/bpf: Avoid repetitive definition of log2 func
Date:   Sun, 20 Sep 2020 22:45:45 +0800
Message-Id: <20200920144547.56771-2-xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200920144547.56771-1-xhao@linux.alibaba.com>
References: <20200920144547.56771-1-xhao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

log2 func is defined and used in following three files:
    samples/bpf/lathist_kern.c
    samples/bpf/lwt_len_hist_kern.c
    samples/bpf/tracex2_kern.c

There's no need to repeat define them many times, so i added
a "common.h" file which maintains common codes, you just need
to include it in your file and future we can put more common codes
into this file.

Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
---
 samples/bpf/common_kern.h       | 30 ++++++++++++++++++++++++++++++
 samples/bpf/lathist_kern.c      | 25 +------------------------
 samples/bpf/lwt_len_hist_kern.c | 23 +----------------------
 samples/bpf/tracex2_kern.c      | 23 +----------------------
 4 files changed, 33 insertions(+), 68 deletions(-)
 create mode 100644 samples/bpf/common_kern.h

diff --git a/samples/bpf/common_kern.h b/samples/bpf/common_kern.h
new file mode 100644
index 000000000000..c23b44238d02
--- /dev/null
+++ b/samples/bpf/common_kern.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ */
+
+static unsigned int log2(unsigned int v)
+{
+	unsigned int r;
+	unsigned int shift;
+
+	r = (v > 0xFFFF) << 4; v >>= r;
+	shift = (v > 0xFF) << 3; v >>= shift; r |= shift;
+	shift = (v > 0xF) << 2; v >>= shift; r |= shift;
+	shift = (v > 0x3) << 1; v >>= shift; r |= shift;
+	r |= (v >> 1);
+
+	return r;
+}
+
+static unsigned int log2l(unsigned long v)
+{
+	unsigned int hi = v >> 32;
+
+	if (hi)
+		return log2(hi) + 32;
+	else
+		return log2(v);
+}
diff --git a/samples/bpf/lathist_kern.c b/samples/bpf/lathist_kern.c
index ca9c2e4e69aa..0978e24dd01c 100644
--- a/samples/bpf/lathist_kern.c
+++ b/samples/bpf/lathist_kern.c
@@ -9,6 +9,7 @@
 #include <linux/ptrace.h>
 #include <uapi/linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include "common_kern.h"
 
 #define MAX_ENTRIES	20
 #define MAX_CPU		4
@@ -37,30 +38,6 @@ int bpf_prog1(struct pt_regs *ctx)
 	return 0;
 }
 
-static unsigned int log2(unsigned int v)
-{
-	unsigned int r;
-	unsigned int shift;
-
-	r = (v > 0xFFFF) << 4; v >>= r;
-	shift = (v > 0xFF) << 3; v >>= shift; r |= shift;
-	shift = (v > 0xF) << 2; v >>= shift; r |= shift;
-	shift = (v > 0x3) << 1; v >>= shift; r |= shift;
-	r |= (v >> 1);
-
-	return r;
-}
-
-static unsigned int log2l(unsigned long v)
-{
-	unsigned int hi = v >> 32;
-
-	if (hi)
-		return log2(hi) + 32;
-	else
-		return log2(v);
-}
-
 struct bpf_map_def SEC("maps") my_lat = {
 	.type = BPF_MAP_TYPE_ARRAY,
 	.key_size = sizeof(int),
diff --git a/samples/bpf/lwt_len_hist_kern.c b/samples/bpf/lwt_len_hist_kern.c
index 9ed63e10e170..6e61072d602b 100644
--- a/samples/bpf/lwt_len_hist_kern.c
+++ b/samples/bpf/lwt_len_hist_kern.c
@@ -15,6 +15,7 @@
 #include <uapi/linux/ip.h>
 #include <uapi/linux/in.h>
 #include <bpf/bpf_helpers.h>
+#include "common_kern.h"
 
 # define printk(fmt, ...)						\
 		({							\
@@ -41,28 +42,6 @@ struct bpf_elf_map SEC("maps") lwt_len_hist_map = {
 	.max_elem = 1024,
 };
 
-static unsigned int log2(unsigned int v)
-{
-	unsigned int r;
-	unsigned int shift;
-
-	r = (v > 0xFFFF) << 4; v >>= r;
-	shift = (v > 0xFF) << 3; v >>= shift; r |= shift;
-	shift = (v > 0xF) << 2; v >>= shift; r |= shift;
-	shift = (v > 0x3) << 1; v >>= shift; r |= shift;
-	r |= (v >> 1);
-	return r;
-}
-
-static unsigned int log2l(unsigned long v)
-{
-	unsigned int hi = v >> 32;
-	if (hi)
-		return log2(hi) + 32;
-	else
-		return log2(v);
-}
-
 SEC("len_hist")
 int do_len_hist(struct __sk_buff *skb)
 {
diff --git a/samples/bpf/tracex2_kern.c b/samples/bpf/tracex2_kern.c
index 5bc696bac27d..7a8cda216d54 100644
--- a/samples/bpf/tracex2_kern.c
+++ b/samples/bpf/tracex2_kern.c
@@ -11,6 +11,7 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include "trace_common.h"
+#include "common_kern.h"
 
 struct {
 	__uint(type, BPF_MAP_TYPE_HASH);
@@ -42,28 +43,6 @@ int bpf_prog2(struct pt_regs *ctx)
 	return 0;
 }
 
-static unsigned int log2(unsigned int v)
-{
-	unsigned int r;
-	unsigned int shift;
-
-	r = (v > 0xFFFF) << 4; v >>= r;
-	shift = (v > 0xFF) << 3; v >>= shift; r |= shift;
-	shift = (v > 0xF) << 2; v >>= shift; r |= shift;
-	shift = (v > 0x3) << 1; v >>= shift; r |= shift;
-	r |= (v >> 1);
-	return r;
-}
-
-static unsigned int log2l(unsigned long v)
-{
-	unsigned int hi = v >> 32;
-	if (hi)
-		return log2(hi) + 32;
-	else
-		return log2(v);
-}
-
 struct hist_key {
 	char comm[16];
 	u64 pid_tgid;
-- 
2.28.0

