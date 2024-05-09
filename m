Return-Path: <bpf+bounces-29210-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE178C1454
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 19:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03A061F224B3
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 17:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2570F770F1;
	Thu,  9 May 2024 17:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uBsCvOtZ"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC514C8B
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 17:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715277041; cv=none; b=DwQRoW+dWFEKxHlzf+hYGtCGmGy3GZuJIuhj5QVMoY3QKDP5ckzt06jGn+StOkFcMQeXMFpxUiD4XFpcXz6ASbeQUwsNKPogksa4KtH/hCTPA5l0xRwirsKP8r6t+BCjb6w5aVm8ola13NZ/k6db1Qo2RF0rbGIz0Wor+NtsIfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715277041; c=relaxed/simple;
	bh=oKS3HMCM4yNrdMmrb0DbVjoHt1w2N3uFokUaszdj+H8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TiQ0Cs+PL7i3n/LmRd4v6rHt13Ok/86bWcNFY90IhagTC6Sb7Lotc1ckxetDybncD3kIPwEVqZwgMiD0GW58lY3R2qGxPojdBjmMs3rzwbSAszfe3DDDueYpbEmdcNA46+pH+bUm1+u1aw2RTUcDZ3MlWHHN+V7uJjS07uGaqnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uBsCvOtZ; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715277038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ni4rVzesY6nAMDD7gOgirBwtdLvE0lLOxq2NaRnRSLY=;
	b=uBsCvOtZg7s8opkG+2BRwOaOkBnBHjk5N/hEO2VYiOxeWworv9GRPa2rStxIgIjLX5GAcq
	NkN9ocJZ/9brblv7MAKy/gowJGrcTdDzQ4rs2nq0F32sEKUDCrQjvTvpW9NDUu4fdiIy+F
	dkCEM8AilDduTf+QqxPy/IfYcfAmqIg=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@meta.com
Subject: [PATCH bpf-next 02/10] selftests/bpf: Add a few tcp helper functions and macros to bpf_tracing_net.h
Date: Thu,  9 May 2024 10:50:18 -0700
Message-ID: <20240509175026.3423614-3-martin.lau@linux.dev>
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

This patch adds a few tcp related helper functions to bpf_tracing_net.h.
They will be useful for both tcp-cc and network tracing related
bpf progs. They have already been in the bpf_tcp_helpers.h. This change
is needed to retire the bpf_tcp_helpers.h and consolidate all tests
to vmlinux.h (i.e. bpf_tracing_net.h).

Some of the helpers (tcp_sk and inet_csk) are also defined in
bpf_cc_cubic.c and they are removed. While at it, remove
the vmlinux.h from bpf_cc_cubic.c. bpf_tracing_net.h (which has
vmlinux.h after this patch) is enough and will be consistent
with the other tcp-cc tests in the later patches.

The other TCP_* macro additions will be needed for the bpf_dctcp
changes in the later patch.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 .../selftests/bpf/progs/bpf_cc_cubic.c        | 14 +------
 .../selftests/bpf/progs/bpf_tracing_net.h     | 41 +++++++++++++++++++
 2 files changed, 42 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_cc_cubic.c b/tools/testing/selftests/bpf/progs/bpf_cc_cubic.c
index 5c7697c70e2a..2004be380683 100644
--- a/tools/testing/selftests/bpf/progs/bpf_cc_cubic.c
+++ b/tools/testing/selftests/bpf/progs/bpf_cc_cubic.c
@@ -13,11 +13,9 @@
  *    kernel functions.
  */
 
-#include "vmlinux.h"
-
+#include "bpf_tracing_net.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
-#include "bpf_tracing_net.h"
 
 #define BPF_STRUCT_OPS(name, args...) \
 SEC("struct_ops/"#name) \
@@ -40,16 +38,6 @@ extern __u32 tcp_reno_undo_cwnd(struct sock *sk) __ksym;
 extern void cubictcp_acked(struct sock *sk, const struct ack_sample *sample) __ksym;
 extern void cubictcp_cong_avoid(struct sock *sk, __u32 ack, __u32 acked) __ksym;
 
-static struct inet_connection_sock *inet_csk(const struct sock *sk)
-{
-	return (struct inet_connection_sock *)sk;
-}
-
-static struct tcp_sock *tcp_sk(const struct sock *sk)
-{
-	return (struct tcp_sock *)sk;
-}
-
 static bool before(__u32 seq1, __u32 seq2)
 {
 	return (__s32)(seq1-seq2) < 0;
diff --git a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
index f9ec630dfcd5..ba4ca0334586 100644
--- a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
+++ b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
@@ -2,6 +2,9 @@
 #ifndef __BPF_TRACING_NET_H__
 #define __BPF_TRACING_NET_H__
 
+#include <vmlinux.h>
+#include <bpf/bpf_core_read.h>
+
 #define AF_INET			2
 #define AF_INET6		10
 
@@ -46,6 +49,13 @@
 #define TCP_CA_NAME_MAX		16
 #define TCP_NAGLE_OFF		1
 
+#define TCP_ECN_OK              1
+#define TCP_ECN_QUEUE_CWR       2
+#define TCP_ECN_DEMAND_CWR      4
+#define TCP_ECN_SEEN            8
+
+#define TCP_CONG_NEEDS_ECN     0x2
+
 #define ICSK_TIME_RETRANS	1
 #define ICSK_TIME_PROBE0	3
 #define ICSK_TIME_LOSS_PROBE	5
@@ -129,4 +139,35 @@
 
 #define tcp_jiffies32 ((__u32)bpf_jiffies64())
 
+static inline struct inet_connection_sock *inet_csk(const struct sock *sk)
+{
+	return (struct inet_connection_sock *)sk;
+}
+
+static inline void *inet_csk_ca(const struct sock *sk)
+{
+	return (void *)inet_csk(sk)->icsk_ca_priv;
+}
+
+static inline struct tcp_sock *tcp_sk(const struct sock *sk)
+{
+	return (struct tcp_sock *)sk;
+}
+
+static inline bool tcp_in_slow_start(const struct tcp_sock *tp)
+{
+	return tp->snd_cwnd < tp->snd_ssthresh;
+}
+
+static inline bool tcp_is_cwnd_limited(const struct sock *sk)
+{
+	const struct tcp_sock *tp = tcp_sk(sk);
+
+	/* If in slow start, ensure cwnd grows to twice what was ACKed. */
+	if (tcp_in_slow_start(tp))
+		return tp->snd_cwnd < 2 * tp->max_packets_out;
+
+	return !!BPF_CORE_READ_BITFIELD(tp, is_cwnd_limited);
+}
+
 #endif
-- 
2.43.0


