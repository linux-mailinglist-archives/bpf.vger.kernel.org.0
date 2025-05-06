Return-Path: <bpf+bounces-57483-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFC8AABA2D
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 09:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 735E15A1202
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 06:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE37283139;
	Tue,  6 May 2025 04:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q7Y59Sv2"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0201D2DA53C
	for <bpf@vger.kernel.org>; Tue,  6 May 2025 02:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746499966; cv=none; b=i01+b2quRlxzimXvlUWPeZpu2QyDBbODN1Yd2JFz28GWu1sDkpKOLOYxu7XSG605SLY1CRSYii4MGJbUK9hjbnn7zAkI7AqCdDVUJP+XZ0qFIqppsh8m5xhYuHJxqzMtxct5VRP5O20Gu3ePnQzKlMCCVflg5NMDUjE9eIowcHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746499966; c=relaxed/simple;
	bh=I+Rv26GjS4KSNALIEBhVZMlFXm4GvJXZMsl//I41Rso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sko5A1FK8wKTPhHWnQMHN//eK32qFvjWtj30GhBNe9dIGgypgpL/9A4KG/d0DpzWSA8xph5t7/wpUQri8W1X7bbTRdrwlGDbLA3+c2E4FDZYbqZ+5hxvVuIg2Sq7gfH/9LWThmT9pTuJzzsMQT5BHfSLG58OLgCAYgUZ56Vyuq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=q7Y59Sv2; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746499961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tw75EoSdg6zoL+Zi/I21b4aq2fuCyLyiBQ1sa4xiJrQ=;
	b=q7Y59Sv2hCJ9PtPt3L/bAtdm+28a1Vyg1tmYkaJFCAucVOC1acZfu7hfD1C9byfn4gF4oL
	8+/ontCfQLZ+07FB4aGARwF/oHKTVPASu+ACa55/77ki1HPiNEAUOkl/nVNIv7h12xscKE
	zo9rXmvMKsaHOgRf/7iDKdAc8pEo6bg=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: vger.kernel.org@web.codeaurora.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
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
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [RESEND PATCH bpf-next v4 2/2] bpf: Move the BPF net tracepoint definitions to net directory
Date: Tue,  6 May 2025 10:51:25 +0800
Message-ID: <20250506025131.136929-2-jiayuan.chen@linux.dev>
In-Reply-To: <20250506025131.136929-1-jiayuan.chen@linux.dev>
References: <20250506025131.136929-1-jiayuan.chen@linux.dev>
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
index a3e571688421..18b6e157362b 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3185,10 +3185,3 @@ late_initcall(bpf_global_ma_init);
 
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


