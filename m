Return-Path: <bpf+bounces-29214-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 635AE8C1458
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 19:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 106001F2198E
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 17:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C253077104;
	Thu,  9 May 2024 17:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ls5VNLmm"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B649E770E6
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 17:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715277049; cv=none; b=W+JDN6fkjS9rVM0/QX4enBw1rj9IiLQCc3NZGVZ2NsDlt8wEb7VUTcTkrGtXk4bdjLor+pzHxLrUp491vjjFo6V1o3ez7/U8LeQIf6r1Kf1jiik/2Ej8Nv4i1HfqNGsCXRmU5Tk3HbWRRQGJUWl07Mjlj1UKVSRQ47Yt9y0LXV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715277049; c=relaxed/simple;
	bh=Q2m5ASpUiSC+3jCKVJNs3gdJvIRKtKh4wuzUBL08FoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EK6xyAIp7AvEJ8FvqSFzoSdiNQ6VW9QV7whKtGWGFi2PwXfeQprf+vtXMA3uprLTdOzRG7GQerrSsPg28/GP9q5vKz0X8RYTQv+ebvgurbFMZyzOWj7bbK6abxeDYvVdeJcRNu2eJC5DxcTx6TF4AOhpQ8UF72zyaa1t4ajVllY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ls5VNLmm; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715277045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DoLHDRM9g3GlVx2zV5cMoFu6waWI9nw3IalZp2hjFgc=;
	b=ls5VNLmmQCQYhdpt0PQqNuHKxiN8zl59Mipxm6ivxbEACTl3Y3DGBrIY7g/CvMDJQoE0TT
	8rCWjY1SvT9P8SIgkxQe15rr/GLDmF6mQtJaqxq+pCwKLCfhSUYIzyDrRWrWomaU8FeSjK
	ADn24jCBLki1icuqstNvYj29S+fnyeI=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@meta.com
Subject: [PATCH bpf-next 06/10] selftests/bpf: Use bpf_tracing_net.h in bpf_cubic
Date: Thu,  9 May 2024 10:50:22 -0700
Message-ID: <20240509175026.3423614-7-martin.lau@linux.dev>
In-Reply-To: <20240509175026.3423614-1-martin.lau@linux.dev>
References: <20240509175026.3423614-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

This patch uses bpf_tracing_net.h (i.e. vmlinux.h) in bpf_cubic.
This will allow to retire the bpf_tcp_helpers.h and consolidate
tcp-cc tests to vmlinux.h.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 tools/testing/selftests/bpf/progs/bpf_cubic.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_cubic.c b/tools/testing/selftests/bpf/progs/bpf_cubic.c
index 53872e2d2c52..d665b8a15cc4 100644
--- a/tools/testing/selftests/bpf/progs/bpf_cubic.c
+++ b/tools/testing/selftests/bpf/progs/bpf_cubic.c
@@ -14,14 +14,22 @@
  *    "ca->ack_cnt / delta" operation.
  */
 
-#include <linux/bpf.h>
-#include <linux/stddef.h>
-#include <linux/tcp.h>
-#include "bpf_tcp_helpers.h"
+#include "bpf_tracing_net.h"
+#include <bpf/bpf_tracing.h>
 
 char _license[] SEC("license") = "GPL";
 
 #define clamp(val, lo, hi) min((typeof(val))max(val, lo), hi)
+#define min(a, b) ((a) < (b) ? (a) : (b))
+#define max(a, b) ((a) > (b) ? (a) : (b))
+static bool before(__u32 seq1, __u32 seq2)
+{
+	return (__s32)(seq1-seq2) < 0;
+}
+#define after(seq2, seq1) 	before(seq1, seq2)
+
+extern __u32 tcp_slow_start(struct tcp_sock *tp, __u32 acked) __ksym;
+extern void tcp_cong_avoid_ai(struct tcp_sock *tp, __u32 w, __u32 acked) __ksym;
 
 #define BICTCP_BETA_SCALE    1024	/* Scale factor beta calculation
 					 * max_cwnd = snd_cwnd * beta
-- 
2.43.0


