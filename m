Return-Path: <bpf+bounces-55866-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA8EA88829
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 18:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 730CE3B470D
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 16:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1572227FD6F;
	Mon, 14 Apr 2025 16:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bdX7Cr2k"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FBF27B51A
	for <bpf@vger.kernel.org>; Mon, 14 Apr 2025 16:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744647146; cv=none; b=ounKVfuOTM92nH69iyC0Nwj6J4orPhLYkTT1YoKRAlhrGC9BE1D1etlT9ovetmVWX+5HXH5dlz4TK7RQZJBH7l9yWVSayPLmqgFzIBu6VBwpQxeSy0pr0krNmrvVNG3k8sWQOD1CnUxa3pUnrfhYIO9JwkLtXIStojEhkKANK5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744647146; c=relaxed/simple;
	bh=1NIHbhj4JVbVzEQGtIVkTUlCLFpsolzH9EvWr+Vpdbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AGdaoi3YfxEqRilsaEE9Eyo9GFoCkYy/tIQkgkPjd7u48Ad6a2W/T9d314d7yITiDjEoc+y0XjIyZporDGp1XZOt28Kps/pJaWdHFGM0qY9C0gIopFbYm6Lm+EATcyKIKE/1VN7N/pq7oW4+k7tC5UY2qgMJlTa/VpjEDuWSkkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bdX7Cr2k; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744647142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FSEXeuFZmlfGP9mNVsD3X0qCwzG9fRcgpWs1Q82AhS8=;
	b=bdX7Cr2kmpeX+qcWgXAeUxvneO1FaitPsnLd/0/QIfVz45aScPjBgUDFDvHen5MTkF79S/
	w1u4TaKJDq9uVakdwd68E3HNJ7TCOaZ31nkfi7zEgau+p34ObwFb4tL/10NtRxbBurf82q
	AhzchHwIAIT2GpYdc1ZxGYPer5CTVm4=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: mrpre@163.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 2/2] bpf: relocates the BPF net tracepoint definitions
Date: Tue, 15 Apr 2025 00:11:46 +0800
Message-ID: <20250414161153.14990-2-jiayuan.chen@linux.dev>
In-Reply-To: <20250414161153.14990-1-jiayuan.chen@linux.dev>
References: <20250414161153.14990-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This commit relocates the BPF tracepoint definitions for XDP and sockmap
from the kernel directory to net/bpf.

This ensures that these tracepoints are controlled by the CONFIG_NET,
avoiding unnecessary function definitions when the CONFIG_NET is disabled.
Additionally, it prevents build failures caused by the use of net module
functions when CONFIG_NET is not enabled.

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 kernel/bpf/core.c       | 7 -------
 net/bpf/Makefile        | 1 +
 net/bpf/bpf_net_trace.c | 8 ++++++++
 3 files changed, 9 insertions(+), 7 deletions(-)
 create mode 100644 net/bpf/bpf_net_trace.c

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index ba6b6118cf50..54e570f62606 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3180,10 +3180,3 @@ late_initcall(bpf_global_ma_init);
 
 DEFINE_STATIC_KEY_FALSE(bpf_stats_enabled_key);
 EXPORT_SYMBOL(bpf_stats_enabled_key);
-
-/* All definitions of tracepoints related to BPF. */
-#define CREATE_TRACE_POINTS
-#include <linux/bpf_trace.h>
-
-EXPORT_TRACEPOINT_SYMBOL_GPL(xdp_exception);
-EXPORT_TRACEPOINT_SYMBOL_GPL(xdp_bulk_tx);
diff --git a/net/bpf/Makefile b/net/bpf/Makefile
index 1ebe270bde23..e95453053159 100644
--- a/net/bpf/Makefile
+++ b/net/bpf/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_BPF_SYSCALL)	:= test_run.o
+obj-$(CONFIG_BPF_SYSCALL)	+= bpf_net_trace.o
 ifeq ($(CONFIG_BPF_JIT),y)
 obj-$(CONFIG_BPF_SYSCALL)	+= bpf_dummy_struct_ops.o
 endif
diff --git a/net/bpf/bpf_net_trace.c b/net/bpf/bpf_net_trace.c
new file mode 100644
index 000000000000..e7c0537dbffd
--- /dev/null
+++ b/net/bpf/bpf_net_trace.c
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* All definitions of net tracepoints related to BPF. */
+#define CREATE_TRACE_POINTS
+#include <linux/bpf_trace.h>
+
+EXPORT_TRACEPOINT_SYMBOL_GPL(xdp_exception);
+EXPORT_TRACEPOINT_SYMBOL_GPL(xdp_bulk_tx);
-- 
2.47.1


