Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B375ECDB30
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2019 06:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfJGE6H (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Oct 2019 00:58:07 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43252 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbfJGE6H (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Oct 2019 00:58:07 -0400
Received: by mail-pf1-f195.google.com with SMTP id a2so7823879pfo.10
        for <bpf@vger.kernel.org>; Sun, 06 Oct 2019 21:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sage.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=8EdYmdtbrf6+F/MAWhTLypXhwqGJzWhD4XIFByfyPhE=;
        b=GhJd0tc8YUTvVBQVfmwWKCxH8iiV75+AGU7hgrahFxssWhtLOtL/ndnUZxhrRa7+DI
         ENwKGEZpw05lNfcmJxU1pGU8wpY+4YLDjrsVX4GkHZZAFTDGximUvN3iiNjJspnu6UtA
         2q6LA42psEPxudGHskC07h2RHb1QrmZJhh/gjUSaPzmjEoRIu6e58PORwtCtXNhxK04F
         eHh6LrzFEE5xNg5u6/+ohIZSXcATmNKetumDy5a9jmAaAQsu4ogHFhHCd42u8G35SEg0
         K1U8fLjWBvM8toXvNLc9KBhKAsf3qhxC3ZsyY0GDSOwbSwim4lkZyQe+1OJOOYPD/kge
         pHUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8EdYmdtbrf6+F/MAWhTLypXhwqGJzWhD4XIFByfyPhE=;
        b=CXdEzRLuv43gfUy+eyXj9GsGVfLVVfDacuPAwz65qLF0GtkICLj9wTW//kydkLqrnJ
         kYtT67eJmrVGpLgGnWylPafsiVjM74E9czS33Jol1A1mW53PnAdzq0lsqHgatPZn7DTw
         oA9FNx/rOsd01R7Y2vRnIGgR2bGEyTSFzZbgTSPKdSaGXUAAShblp/o8VGozfb32ZJz9
         Mf0E5Ce3QWWY5L5uoP1tNdzvMtb0quTtMZ5c3a1Ggcnv2W+aak0dUrQ6tBwAxLLxBUGY
         JaeTTeF8uvT3J5VdNmLRBCYQ3AwA5kpB6hukgds2ae12PnJ9bScPYPCeo8Bsp//1ZNIk
         MWBQ==
X-Gm-Message-State: APjAAAUhNT4TBe3YLMhA3zcb2/4bcT9nK2Nx+tm3CCbKXOCEMVUrIQhM
        0JRZMhaD2jV9p0oTUC24qcvbUQ==
X-Google-Smtp-Source: APXvYqwEW7sGlxlLCNdwYrt2isMJ2qxl5mQ1no94mpHb3sJhlDVb4U6beFGgbvpOkwBL726Z2h6Knw==
X-Received: by 2002:a65:6681:: with SMTP id b1mr1090952pgw.393.1570424284665;
        Sun, 06 Oct 2019 21:58:04 -0700 (PDT)
Received: from dev-instance.c.sage-org.internal (143.139.82.34.bc.googleusercontent.com. [34.82.139.143])
        by smtp.googlemail.com with ESMTPSA id x11sm21565092pja.3.2019.10.06.21.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2019 21:58:04 -0700 (PDT)
From:   Eric Sage <eric@sage.org>
To:     netdev@vger.kernel.org
Cc:     bpf@vger.kernel.org, daniel@iogearbox.net,
        xdp-newbies@vger.kernel.org, brouer@redhat.org, ast@kernel.org,
        Eric Sage <eric@sage.org>
Subject: [PATCH] samples/bpf: make xdp_monitor use raw_tracepoints
Date:   Mon,  7 Oct 2019 04:57:26 +0000
Message-Id: <20191007045726.21467-1-eric@sage.org>
X-Mailer: git-send-email 2.18.1
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

raw_tracepoints are an eBPF alternative to standard tracepoints which
attach to a tracepoint without the perf layer being executed, making
them faster.

Since xdp_monitor is supposed to have as little impact on the system as
possible it is switched to using them by append raw_ to the SEC names.

There was also a small issues with 'samples/bpf/bpf_load' - it was
loading the raw_tracepoints with the tracing subsystem name still
attached, which the bpf syscall rejects with a No such file or directory
error. This is now fixed.

Signed-off-by: Eric Sage <eric@sage.org>
---
 samples/bpf/bpf_load.c         |  5 +++--
 samples/bpf/xdp_monitor_kern.c | 26 +++++++++++++-------------
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/samples/bpf/bpf_load.c b/samples/bpf/bpf_load.c
index 4574b1939e49..6f57eee8e913 100644
--- a/samples/bpf/bpf_load.c
+++ b/samples/bpf/bpf_load.c
@@ -156,9 +156,10 @@ static int load_and_attach(const char *event, struct bpf_insn *prog, int size)
 	}
 
 	if (is_raw_tracepoint) {
-		efd = bpf_raw_tracepoint_open(event + 15, fd);
+		efd = bpf_raw_tracepoint_open(event + 19, fd);
 		if (efd < 0) {
-			printf("tracepoint %s %s\n", event + 15, strerror(errno));
+			printf("tracepoint %s %s\n", event + 19,
+						strerror(errno));
 			return -1;
 		}
 		event_fd[prog_cnt - 1] = efd;
diff --git a/samples/bpf/xdp_monitor_kern.c b/samples/bpf/xdp_monitor_kern.c
index ad10fe700d7d..6f67c38468b9 100644
--- a/samples/bpf/xdp_monitor_kern.c
+++ b/samples/bpf/xdp_monitor_kern.c
@@ -23,10 +23,10 @@ struct bpf_map_def SEC("maps") exception_cnt = {
 };
 
 /* Tracepoint format: /sys/kernel/debug/tracing/events/xdp/xdp_redirect/format
+ * Notice: For raw_tracepoints first 8 bytes are not part of 'format' struct
  * Code in:                kernel/include/trace/events/xdp.h
  */
 struct xdp_redirect_ctx {
-	u64 __pad;		// First 8 bytes are not accessible by bpf code
 	int prog_id;		//	offset:8;  size:4; signed:1;
 	u32 act;		//	offset:12  size:4; signed:0;
 	int ifindex;		//	offset:16  size:4; signed:1;
@@ -65,44 +65,44 @@ int xdp_redirect_collect_stat(struct xdp_redirect_ctx *ctx)
 	 */
 }
 
-SEC("tracepoint/xdp/xdp_redirect_err")
+SEC("raw_tracepoint/xdp/xdp_redirect_err")
 int trace_xdp_redirect_err(struct xdp_redirect_ctx *ctx)
 {
 	return xdp_redirect_collect_stat(ctx);
 }
 
 
-SEC("tracepoint/xdp/xdp_redirect_map_err")
+SEC("raw_tracepoint/xdp/xdp_redirect_map_err")
 int trace_xdp_redirect_map_err(struct xdp_redirect_ctx *ctx)
 {
 	return xdp_redirect_collect_stat(ctx);
 }
 
 /* Likely unloaded when prog starts */
-SEC("tracepoint/xdp/xdp_redirect")
+SEC("raw_tracepoint/xdp/xdp_redirect")
 int trace_xdp_redirect(struct xdp_redirect_ctx *ctx)
 {
 	return xdp_redirect_collect_stat(ctx);
 }
 
 /* Likely unloaded when prog starts */
-SEC("tracepoint/xdp/xdp_redirect_map")
+SEC("raw_tracepoint/xdp/xdp_redirect_map")
 int trace_xdp_redirect_map(struct xdp_redirect_ctx *ctx)
 {
 	return xdp_redirect_collect_stat(ctx);
 }
 
 /* Tracepoint format: /sys/kernel/debug/tracing/events/xdp/xdp_exception/format
+ * Notice: For raw_tracepoints first 8 bytes are not part of 'format' struct
  * Code in:                kernel/include/trace/events/xdp.h
  */
 struct xdp_exception_ctx {
-	u64 __pad;	// First 8 bytes are not accessible by bpf code
 	int prog_id;	//	offset:8;  size:4; signed:1;
 	u32 act;	//	offset:12; size:4; signed:0;
 	int ifindex;	//	offset:16; size:4; signed:1;
 };
 
-SEC("tracepoint/xdp/xdp_exception")
+SEC("raw_tracepoint/xdp/xdp_exception")
 int trace_xdp_exception(struct xdp_exception_ctx *ctx)
 {
 	u64 *cnt;
@@ -144,10 +144,10 @@ struct bpf_map_def SEC("maps") cpumap_kthread_cnt = {
 };
 
 /* Tracepoint: /sys/kernel/debug/tracing/events/xdp/xdp_cpumap_enqueue/format
+ * Notice: For raw_tracepoints first 8 bytes are not part of 'format' struct
  * Code in:         kernel/include/trace/events/xdp.h
  */
 struct cpumap_enqueue_ctx {
-	u64 __pad;		// First 8 bytes are not accessible by bpf code
 	int map_id;		//	offset:8;  size:4; signed:1;
 	u32 act;		//	offset:12; size:4; signed:0;
 	int cpu;		//	offset:16; size:4; signed:1;
@@ -156,7 +156,7 @@ struct cpumap_enqueue_ctx {
 	int to_cpu;		//	offset:28; size:4; signed:1;
 };
 
-SEC("tracepoint/xdp/xdp_cpumap_enqueue")
+SEC("raw_tracepoint/xdp/xdp_cpumap_enqueue")
 int trace_xdp_cpumap_enqueue(struct cpumap_enqueue_ctx *ctx)
 {
 	u32 to_cpu = ctx->to_cpu;
@@ -179,10 +179,10 @@ int trace_xdp_cpumap_enqueue(struct cpumap_enqueue_ctx *ctx)
 }
 
 /* Tracepoint: /sys/kernel/debug/tracing/events/xdp/xdp_cpumap_kthread/format
+ * Notice: For raw_tracepoints first 8 bytes are not part of 'format' struct
  * Code in:         kernel/include/trace/events/xdp.h
  */
 struct cpumap_kthread_ctx {
-	u64 __pad;		// First 8 bytes are not accessible by bpf code
 	int map_id;		//	offset:8;  size:4; signed:1;
 	u32 act;		//	offset:12; size:4; signed:0;
 	int cpu;		//	offset:16; size:4; signed:1;
@@ -191,7 +191,7 @@ struct cpumap_kthread_ctx {
 	int sched;		//	offset:28; size:4; signed:1;
 };
 
-SEC("tracepoint/xdp/xdp_cpumap_kthread")
+SEC("raw_tracepoint/xdp/xdp_cpumap_kthread")
 int trace_xdp_cpumap_kthread(struct cpumap_kthread_ctx *ctx)
 {
 	struct datarec *rec;
@@ -218,10 +218,10 @@ struct bpf_map_def SEC("maps") devmap_xmit_cnt = {
 };
 
 /* Tracepoint: /sys/kernel/debug/tracing/events/xdp/xdp_devmap_xmit/format
+ * Notice: For raw_tracepoints first 8 bytes are not part of 'format' struct
  * Code in:         kernel/include/trace/events/xdp.h
  */
 struct devmap_xmit_ctx {
-	u64 __pad;		// First 8 bytes are not accessible by bpf code
 	int map_id;		//	offset:8;  size:4; signed:1;
 	u32 act;		//	offset:12; size:4; signed:0;
 	u32 map_index;		//	offset:16; size:4; signed:0;
@@ -232,7 +232,7 @@ struct devmap_xmit_ctx {
 	int err;		//	offset:36; size:4; signed:1;
 };
 
-SEC("tracepoint/xdp/xdp_devmap_xmit")
+SEC("raw_tracepoint/xdp/xdp_devmap_xmit")
 int trace_xdp_devmap_xmit(struct devmap_xmit_ctx *ctx)
 {
 	struct datarec *rec;
-- 
2.18.1

