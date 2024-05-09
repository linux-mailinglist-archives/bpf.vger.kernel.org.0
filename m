Return-Path: <bpf+bounces-29215-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B28F8C1459
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 19:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C00391F2175D
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 17:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35D177109;
	Thu,  9 May 2024 17:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I9m6sAc5"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA97770ED
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 17:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715277051; cv=none; b=iZ7de4UEsGcRHoZMi4QDuPVeklV8iQ7PijGBDRbnjIbqotnurbRvBXWRDY1tpc3CNbg2L3bB07BoPd+S3SYsDFL2y1++nXvw4YzyCI55g5WxHRS72m6x/mcdc47wZWCSJ8FhMc9LzqM/93nyF0EadLQblV48JKOpmyO4GsAF1Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715277051; c=relaxed/simple;
	bh=MHlfph5QjMo4HLO8GZ1ds2GuMIY0tDdRIHL80kkS2uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FbkZ6s25HEmJIM6zgcv0qLr7X9c5LqyaNo8UMQIqXnpo+K+UG5l1hLc3VqWV2y1feL7UDDuEGqxcNfcGi4y3Vc5RWT17EQCGctzMvgD1ETIZybNrRr9PpoAeMid09CG6MlL5DXfyn+ssxQPQTAjlLA570PHeU9py6TwrB3vxRvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I9m6sAc5; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715277048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=15pH6WEK4wX1PxrUuslJoEthiSzOz55gcyvNg+dbl84=;
	b=I9m6sAc5iYftNVdnzjZ8YxFF+usTdTuu4n1ZJXN6bFWCoLVaYjyngYgEvAXvxjI5JX4rGs
	D6w/+aNqpjZiiuQGVf51Mr9N8uYYntF6+ichv3Vj+NDyZvcecPVlor79IFeFzqgneChVIB
	5bBrf0gfmBIujkjN/qotKkF2O8FHHjE=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@meta.com
Subject: [PATCH bpf-next 07/10] selftests/bpf: Use bpf_tracing_net.h in bpf_dctcp
Date: Thu,  9 May 2024 10:50:23 -0700
Message-ID: <20240509175026.3423614-8-martin.lau@linux.dev>
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

This patch uses bpf_tracing_net.h (i.e. vmlinux.h) in bpf_dctcp.
This will allow to retire the bpf_tcp_helpers.h and consolidate
tcp-cc tests to vmlinux.h.

It will have a dup on min/max macros with the bpf_cubic. It could
be further refactored in the future.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 tools/testing/selftests/bpf/progs/bpf_dctcp.c | 22 +++++++++++++------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_dctcp.c b/tools/testing/selftests/bpf/progs/bpf_dctcp.c
index a8673b7ff35d..3c9ffe340312 100644
--- a/tools/testing/selftests/bpf/progs/bpf_dctcp.c
+++ b/tools/testing/selftests/bpf/progs/bpf_dctcp.c
@@ -6,15 +6,23 @@
  * the kernel BPF logic.
  */
 
-#include <stddef.h>
-#include <linux/bpf.h>
-#include <linux/types.h>
-#include <linux/stddef.h>
-#include <linux/tcp.h>
-#include <errno.h>
+#include "bpf_tracing_net.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
-#include "bpf_tcp_helpers.h"
+
+#ifndef EBUSY
+#define EBUSY 16
+#endif
+#define min(a, b) ((a) < (b) ? (a) : (b))
+#define max(a, b) ((a) > (b) ? (a) : (b))
+#define min_not_zero(x, y) ({			\
+	typeof(x) __x = (x);			\
+	typeof(y) __y = (y);			\
+	__x == 0 ? __y : ((__y == 0) ? __x : min(__x, __y)); })
+static bool before(__u32 seq1, __u32 seq2)
+{
+	return (__s32)(seq1-seq2) < 0;
+}
 
 char _license[] SEC("license") = "GPL";
 
-- 
2.43.0


