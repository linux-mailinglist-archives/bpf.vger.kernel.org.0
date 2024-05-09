Return-Path: <bpf+bounces-29217-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D82798C145C
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 19:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E9D7282464
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 17:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714AD7711D;
	Thu,  9 May 2024 17:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eK+BeCF7"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214877710E
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 17:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715277056; cv=none; b=R+J/RshtiPrY9BQ5mOw5CsUjxnKtyc2uEkV7i5I6Zvf/ZBQiALIkZzATNGzxMuEUzVNegjC4vt6y6IsxAjoMnDD0hy8GGCwZlx4Ml/dJoim6rb7eq5bsnKZQ1eX1YNlxLH9MIcFY6tZaXB0U2NCACuxAyKmQrm3dbCnkFpOpUOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715277056; c=relaxed/simple;
	bh=HcxNCPN+mHM7e3bHq7ysJ36pGHRtkq3jyWRQVu1u5qA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LEELszvYd8NLWHWAu7OUcnn/IKhv0Tu+bpDtkqs/V3QmgTXdOoMS8VYIeoIoCn5kMNGAFCqyXtjBxEpfDTpmndXVCoDSQPG5Q2l8GngYwJv7jLHnXbU8bFVZgkjpoWHtcv1yfwcNoWCkFA7uzU3fceBjt82AICCgTOv1OSdSL7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eK+BeCF7; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715277052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YLMsU+ojB2g/lcG0Olebbmj99CGtYZ+FqJRMSSKqW2o=;
	b=eK+BeCF7sT59R/BAkZn8dL+yIKRDvWm2mBdu7d1rx8Gr1s6/5LUNUBVRMialBYshK/pxyE
	vkO7sBkAVgfAJRDLttc5uXX7W2XVkLRZY/3y8uemNmBxgDSHAS5McG9met5OI2QrwbRcAS
	8xJZUOL6wUPIgCFPmDTf8hAtKX8+7wU=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@meta.com
Subject: [PATCH bpf-next 09/10] selftests/bpf: Remove the bpf_tcp_helpers.h usages from other non tcp-cc tests
Date: Thu,  9 May 2024 10:50:25 -0700
Message-ID: <20240509175026.3423614-10-martin.lau@linux.dev>
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

The patch removes the remaining bpf_tcp_helpers.h usages in the
non tcp-cc networking tests. It either replaces it with bpf_tracing_net.h
or just removed it because the test is not actually using any
kernel sockets. For the later, the missing macro (mainly SOL_TCP) is
defined locally.

An exception is the test_sock_fields which is testing
the "struct bpf_sock" type instead of the kernel sock type.
Whenever "vmlinux.h" is used instead, it hits a verifier
error on doing arithmetic on the sock_common pointer:

; return !a6[0] && !a6[1] && !a6[2] && a6[3] == bpf_htonl(1); @ test_sock_fields.c:54
21: (61) r2 = *(u32 *)(r1 +28)        ; R1_w=sock_common() R2_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
22: (56) if w2 != 0x0 goto pc-6       ; R2_w=0
23: (b7) r3 = 28                      ; R3_w=28
24: (bf) r2 = r1                      ; R1_w=sock_common() R2_w=sock_common()
25: (0f) r2 += r3
R2 pointer arithmetic on sock_common prohibited

Hence, instead of including bpf_tracing_net.h, the test_sock_fields test
defines a tcp_sock with one lsndtime field in it.

Another highlight is, in sockopt_qos_to_cc.c, the tcp_cc_eq()
is replaced by bpf_strncmp(). tcp_cc_eq() was a workaround
in bpf_tcp_helpers.h before bpf_strncmp had been added.

The SOL_IPV6 addition to bpf_tracing_net.h is needed by the
test_tcpbpf_kern test.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 .../selftests/bpf/progs/bpf_tracing_net.h        |  1 +
 .../testing/selftests/bpf/progs/connect4_prog.c  |  6 ++++--
 tools/testing/selftests/bpf/progs/mptcp_sock.c   |  4 ++--
 .../selftests/bpf/progs/sockopt_qos_to_cc.c      | 16 ++++++----------
 .../bpf/progs/test_btf_skc_cls_ingress.c         | 16 +++++-----------
 .../selftests/bpf/progs/test_sock_fields.c       |  5 ++++-
 .../selftests/bpf/progs/test_tcpbpf_kern.c       | 13 +------------
 7 files changed, 23 insertions(+), 38 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
index ba4ca0334586..59843b430f76 100644
--- a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
+++ b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
@@ -25,6 +25,7 @@
 
 #define IP_TOS			1
 
+#define SOL_IPV6		41
 #define IPV6_TCLASS		67
 #define IPV6_AUTOFLOWLABEL	70
 
diff --git a/tools/testing/selftests/bpf/progs/connect4_prog.c b/tools/testing/selftests/bpf/progs/connect4_prog.c
index 7ef49ec04838..bec529da7c9d 100644
--- a/tools/testing/selftests/bpf/progs/connect4_prog.c
+++ b/tools/testing/selftests/bpf/progs/connect4_prog.c
@@ -14,8 +14,6 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
 
-#include "bpf_tcp_helpers.h"
-
 #define SRC_REWRITE_IP4		0x7f000004U
 #define DST_REWRITE_IP4		0x7f000001U
 #define DST_REWRITE_PORT4	4444
@@ -32,6 +30,10 @@
 #define IFNAMSIZ 16
 #endif
 
+#ifndef SOL_TCP
+#define SOL_TCP 6
+#endif
+
 __attribute__ ((noinline)) __weak
 int do_bind(struct bpf_sock_addr *ctx)
 {
diff --git a/tools/testing/selftests/bpf/progs/mptcp_sock.c b/tools/testing/selftests/bpf/progs/mptcp_sock.c
index 91a0d7eff2ac..f3acb90588c7 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_sock.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_sock.c
@@ -2,9 +2,9 @@
 /* Copyright (c) 2020, Tessares SA. */
 /* Copyright (c) 2022, SUSE. */
 
-#include <linux/bpf.h>
+#include "bpf_tracing_net.h"
 #include <bpf/bpf_helpers.h>
-#include "bpf_tcp_helpers.h"
+#include <bpf/bpf_tracing.h>
 
 char _license[] SEC("license") = "GPL";
 __u32 token = 0;
diff --git a/tools/testing/selftests/bpf/progs/sockopt_qos_to_cc.c b/tools/testing/selftests/bpf/progs/sockopt_qos_to_cc.c
index 83753b00a556..5c3614333b01 100644
--- a/tools/testing/selftests/bpf/progs/sockopt_qos_to_cc.c
+++ b/tools/testing/selftests/bpf/progs/sockopt_qos_to_cc.c
@@ -1,24 +1,20 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2021 Facebook */
-#include <string.h>
-#include <linux/tcp.h>
-#include <netinet/in.h>
-#include <linux/bpf.h>
-#include <bpf/bpf_helpers.h>
-#include "bpf_tcp_helpers.h"
+#include "bpf_tracing_net.h"
 
 char _license[] SEC("license") = "GPL";
 
 __s32 page_size = 0;
 
+const char cc_reno[TCP_CA_NAME_MAX] = "reno";
+const char cc_cubic[TCP_CA_NAME_MAX] = "cubic";
+
 SEC("cgroup/setsockopt")
 int sockopt_qos_to_cc(struct bpf_sockopt *ctx)
 {
 	void *optval_end = ctx->optval_end;
 	int *optval = ctx->optval;
 	char buf[TCP_CA_NAME_MAX];
-	char cc_reno[TCP_CA_NAME_MAX] = "reno";
-	char cc_cubic[TCP_CA_NAME_MAX] = "cubic";
 
 	if (ctx->level != SOL_IPV6 || ctx->optname != IPV6_TCLASS)
 		goto out;
@@ -29,11 +25,11 @@ int sockopt_qos_to_cc(struct bpf_sockopt *ctx)
 	if (bpf_getsockopt(ctx->sk, SOL_TCP, TCP_CONGESTION, &buf, sizeof(buf)))
 		return 0;
 
-	if (!tcp_cc_eq(buf, cc_cubic))
+	if (bpf_strncmp(buf, sizeof(buf), cc_cubic))
 		return 0;
 
 	if (*optval == 0x2d) {
-		if (bpf_setsockopt(ctx->sk, SOL_TCP, TCP_CONGESTION, &cc_reno,
+		if (bpf_setsockopt(ctx->sk, SOL_TCP, TCP_CONGESTION, (void *)&cc_reno,
 				sizeof(cc_reno)))
 			return 0;
 	}
diff --git a/tools/testing/selftests/bpf/progs/test_btf_skc_cls_ingress.c b/tools/testing/selftests/bpf/progs/test_btf_skc_cls_ingress.c
index e2bea4da194b..f0759efff6ef 100644
--- a/tools/testing/selftests/bpf/progs/test_btf_skc_cls_ingress.c
+++ b/tools/testing/selftests/bpf/progs/test_btf_skc_cls_ingress.c
@@ -1,19 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2020 Facebook */
 
-#include <string.h>
-#include <errno.h>
-#include <netinet/in.h>
-#include <linux/stddef.h>
-#include <linux/bpf.h>
-#include <linux/ipv6.h>
-#include <linux/tcp.h>
-#include <linux/if_ether.h>
-#include <linux/pkt_cls.h>
-
+#include "bpf_tracing_net.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
-#include "bpf_tcp_helpers.h"
+
+#ifndef ENOENT
+#define ENOENT 2
+#endif
 
 struct sockaddr_in6 srv_sa6 = {};
 __u16 listen_tp_sport = 0;
diff --git a/tools/testing/selftests/bpf/progs/test_sock_fields.c b/tools/testing/selftests/bpf/progs/test_sock_fields.c
index f75e531bf36f..196844be349c 100644
--- a/tools/testing/selftests/bpf/progs/test_sock_fields.c
+++ b/tools/testing/selftests/bpf/progs/test_sock_fields.c
@@ -7,7 +7,6 @@
 
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
-#include "bpf_tcp_helpers.h"
 
 enum bpf_linum_array_idx {
 	EGRESS_LINUM_IDX,
@@ -42,6 +41,10 @@ struct {
 	__type(value, struct bpf_spinlock_cnt);
 } sk_pkt_out_cnt10 SEC(".maps");
 
+struct tcp_sock {
+	__u32	lsndtime;
+} __attribute__((preserve_access_index));
+
 struct bpf_tcp_sock listen_tp = {};
 struct sockaddr_in6 srv_sa6 = {};
 struct bpf_tcp_sock cli_tp = {};
diff --git a/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c b/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c
index a3f3f43fc195..6935f32eeb8f 100644
--- a/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c
@@ -1,18 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stddef.h>
-#include <string.h>
-#include <netinet/in.h>
-#include <linux/bpf.h>
-#include <linux/if_ether.h>
-#include <linux/if_packet.h>
-#include <linux/ip.h>
-#include <linux/ipv6.h>
-#include <linux/types.h>
-#include <linux/socket.h>
-#include <linux/tcp.h>
+#include "bpf_tracing_net.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
-#include "bpf_tcp_helpers.h"
 #include "test_tcpbpf.h"
 
 struct tcpbpf_globals global = {};
-- 
2.43.0


