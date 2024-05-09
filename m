Return-Path: <bpf+bounces-29212-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 230758C1456
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 19:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEA1B282487
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 17:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D174770E2;
	Thu,  9 May 2024 17:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PxFbUU3w"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C083474BE8
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 17:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715277046; cv=none; b=lLI+fkAovsYPnwLl5v1z3/dbodb++/4NvNCy8dNsb3p1OBPiyzsGygiHtCxhgfHxV4y+Sa6K2FqHJ/GyxQ2/JnlsC0lfqCRCgCY9DVho3UryW7KUtHb2KP2Gyzw8xyEra+/KkNBV7uB+ZqZq4vjAtSp9jxWvtWywLZwOUEO5JE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715277046; c=relaxed/simple;
	bh=J9nB7wwUmCDDGMABhaImUWjHwjO0B3uYFYcoCyKYmDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SDByDenXzYRQXm5/7QQS7ejJMhhJuBYsj3SKmGMNMuP5OOfPqHWdBYE9U7uKnyVjS83fXc2420DUYCAJFDeav/zZrJYLX89rbSoj02SMA07vzB1KILcFsg8oMXRciXJpTgrBxNkXP4bV1ZGbMU6zSX9mb7Lg0rxcleSEkn8Gyjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PxFbUU3w; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715277042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yuy4y0aRXpgIeYRbM0aiip+SfiECeOj+FGWJj+UCvV4=;
	b=PxFbUU3wTqCsrGz1bn6WZJbvypQP0iXL9Xbhr/42pSCrF9oi8trrf22RM/WZnZr0VTEN6J
	crft5bfoO7WJuPTlJxGxo4g/G6mwgzTpvKv3jZ2k3dM3/4trRByvwLZjBHPG1cbS4vcekZ
	nNTZ3aoagpHEnH8sVWEYqefArsJLu/U=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@meta.com
Subject: [PATCH bpf-next 04/10] selftests/bpf: Sanitize the SEC and inline usages in the bpf-tcp-cc tests
Date: Thu,  9 May 2024 10:50:20 -0700
Message-ID: <20240509175026.3423614-5-martin.lau@linux.dev>
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

It is needed to remove the BPF_STRUCT_OPS usages from the tcp-cc tests
because it is defined in bpf_tcp_helpers.h which is going to be retired.
While at it, this patch consolidates all tcp-cc struct_ops programs to
use the SEC("struct_ops") + BPF_PROG().

It also removes the unnecessary __always_inline usages from the
tcp-cc tests.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 .../selftests/bpf/progs/bpf_cc_cubic.c        | 28 +++++++------
 tools/testing/selftests/bpf/progs/bpf_cubic.c | 42 +++++++++----------
 tools/testing/selftests/bpf/progs/bpf_dctcp.c | 26 ++++++------
 .../selftests/bpf/progs/bpf_dctcp_release.c   |  3 +-
 .../selftests/bpf/progs/bpf_tcp_nogpl.c       |  3 +-
 .../bpf/progs/tcp_ca_incompl_cong_ops.c       |  4 +-
 .../selftests/bpf/progs/tcp_ca_kfunc.c        | 22 +++++-----
 .../bpf/progs/tcp_ca_unsupp_cong_op.c         |  2 +-
 .../selftests/bpf/progs/tcp_ca_update.c       | 10 ++---
 .../bpf/progs/tcp_ca_write_sk_pacing.c        | 12 +++---
 10 files changed, 77 insertions(+), 75 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_cc_cubic.c b/tools/testing/selftests/bpf/progs/bpf_cc_cubic.c
index 2004be380683..1654a530aa3d 100644
--- a/tools/testing/selftests/bpf/progs/bpf_cc_cubic.c
+++ b/tools/testing/selftests/bpf/progs/bpf_cc_cubic.c
@@ -17,10 +17,6 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
-#define BPF_STRUCT_OPS(name, args...) \
-SEC("struct_ops/"#name) \
-BPF_PROG(name, args)
-
 #define USEC_PER_SEC 1000000UL
 #define TCP_PACING_SS_RATIO (200)
 #define TCP_PACING_CA_RATIO (120)
@@ -114,18 +110,21 @@ static bool tcp_may_raise_cwnd(const struct sock *sk, const int flag)
 	return flag & FLAG_DATA_ACKED;
 }
 
-void BPF_STRUCT_OPS(bpf_cubic_init, struct sock *sk)
+SEC("struct_ops")
+void BPF_PROG(bpf_cubic_init, struct sock *sk)
 {
 	cubictcp_init(sk);
 }
 
-void BPF_STRUCT_OPS(bpf_cubic_cwnd_event, struct sock *sk, enum tcp_ca_event event)
+SEC("struct_ops")
+void BPF_PROG(bpf_cubic_cwnd_event, struct sock *sk, enum tcp_ca_event event)
 {
 	cubictcp_cwnd_event(sk, event);
 }
 
-void BPF_STRUCT_OPS(bpf_cubic_cong_control, struct sock *sk, __u32 ack, int flag,
-		    const struct rate_sample *rs)
+SEC("struct_ops")
+void BPF_PROG(bpf_cubic_cong_control, struct sock *sk, __u32 ack, int flag,
+	      const struct rate_sample *rs)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 
@@ -151,23 +150,26 @@ void BPF_STRUCT_OPS(bpf_cubic_cong_control, struct sock *sk, __u32 ack, int flag
 	tcp_update_pacing_rate(sk);
 }
 
-__u32 BPF_STRUCT_OPS(bpf_cubic_recalc_ssthresh, struct sock *sk)
+SEC("struct_ops")
+__u32 BPF_PROG(bpf_cubic_recalc_ssthresh, struct sock *sk)
 {
 	return cubictcp_recalc_ssthresh(sk);
 }
 
-void BPF_STRUCT_OPS(bpf_cubic_state, struct sock *sk, __u8 new_state)
+SEC("struct_ops")
+void BPF_PROG(bpf_cubic_state, struct sock *sk, __u8 new_state)
 {
 	cubictcp_state(sk, new_state);
 }
 
-void BPF_STRUCT_OPS(bpf_cubic_acked, struct sock *sk,
-		const struct ack_sample *sample)
+SEC("struct_ops")
+void BPF_PROG(bpf_cubic_acked, struct sock *sk, const struct ack_sample *sample)
 {
 	cubictcp_acked(sk, sample);
 }
 
-__u32 BPF_STRUCT_OPS(bpf_cubic_undo_cwnd, struct sock *sk)
+SEC("struct_ops")
+__u32 BPF_PROG(bpf_cubic_undo_cwnd, struct sock *sk)
 {
 	return tcp_reno_undo_cwnd(sk);
 }
diff --git a/tools/testing/selftests/bpf/progs/bpf_cubic.c b/tools/testing/selftests/bpf/progs/bpf_cubic.c
index c997e3e3d3fb..53a98b609e5f 100644
--- a/tools/testing/selftests/bpf/progs/bpf_cubic.c
+++ b/tools/testing/selftests/bpf/progs/bpf_cubic.c
@@ -91,7 +91,7 @@ struct bictcp {
 	__u32	curr_rtt;	/* the minimum rtt of current round */
 };
 
-static inline void bictcp_reset(struct bictcp *ca)
+static void bictcp_reset(struct bictcp *ca)
 {
 	ca->cnt = 0;
 	ca->last_max_cwnd = 0;
@@ -112,7 +112,7 @@ extern unsigned long CONFIG_HZ __kconfig;
 #define USEC_PER_SEC	1000000UL
 #define USEC_PER_JIFFY	(USEC_PER_SEC / HZ)
 
-static __always_inline __u64 div64_u64(__u64 dividend, __u64 divisor)
+static __u64 div64_u64(__u64 dividend, __u64 divisor)
 {
 	return dividend / divisor;
 }
@@ -120,7 +120,7 @@ static __always_inline __u64 div64_u64(__u64 dividend, __u64 divisor)
 #define div64_ul div64_u64
 
 #define BITS_PER_U64 (sizeof(__u64) * 8)
-static __always_inline int fls64(__u64 x)
+static int fls64(__u64 x)
 {
 	int num = BITS_PER_U64 - 1;
 
@@ -153,12 +153,12 @@ static __always_inline int fls64(__u64 x)
 	return num + 1;
 }
 
-static __always_inline __u32 bictcp_clock_us(const struct sock *sk)
+static __u32 bictcp_clock_us(const struct sock *sk)
 {
 	return tcp_sk(sk)->tcp_mstamp;
 }
 
-static __always_inline void bictcp_hystart_reset(struct sock *sk)
+static void bictcp_hystart_reset(struct sock *sk)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct bictcp *ca = inet_csk_ca(sk);
@@ -169,8 +169,7 @@ static __always_inline void bictcp_hystart_reset(struct sock *sk)
 	ca->sample_cnt = 0;
 }
 
-/* "struct_ops/" prefix is a requirement */
-SEC("struct_ops/bpf_cubic_init")
+SEC("struct_ops")
 void BPF_PROG(bpf_cubic_init, struct sock *sk)
 {
 	struct bictcp *ca = inet_csk_ca(sk);
@@ -184,8 +183,7 @@ void BPF_PROG(bpf_cubic_init, struct sock *sk)
 		tcp_sk(sk)->snd_ssthresh = initial_ssthresh;
 }
 
-/* "struct_ops" prefix is a requirement */
-SEC("struct_ops/bpf_cubic_cwnd_event")
+SEC("struct_ops")
 void BPF_PROG(bpf_cubic_cwnd_event, struct sock *sk, enum tcp_ca_event event)
 {
 	if (event == CA_EVENT_TX_START) {
@@ -230,7 +228,7 @@ static const __u8 v[] = {
  * Newton-Raphson iteration.
  * Avg err ~= 0.195%
  */
-static __always_inline __u32 cubic_root(__u64 a)
+static __u32 cubic_root(__u64 a)
 {
 	__u32 x, b, shift;
 
@@ -263,8 +261,7 @@ static __always_inline __u32 cubic_root(__u64 a)
 /*
  * Compute congestion window to use.
  */
-static __always_inline void bictcp_update(struct bictcp *ca, __u32 cwnd,
-					  __u32 acked)
+static void bictcp_update(struct bictcp *ca, __u32 cwnd, __u32 acked)
 {
 	__u32 delta, bic_target, max_cnt;
 	__u64 offs, t;
@@ -377,8 +374,8 @@ static __always_inline void bictcp_update(struct bictcp *ca, __u32 cwnd,
 	ca->cnt = max(ca->cnt, 2U);
 }
 
-/* Or simply use the BPF_STRUCT_OPS to avoid the SEC boiler plate. */
-void BPF_STRUCT_OPS(bpf_cubic_cong_avoid, struct sock *sk, __u32 ack, __u32 acked)
+SEC("struct_ops")
+void BPF_PROG(bpf_cubic_cong_avoid, struct sock *sk, __u32 ack, __u32 acked)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct bictcp *ca = inet_csk_ca(sk);
@@ -397,7 +394,8 @@ void BPF_STRUCT_OPS(bpf_cubic_cong_avoid, struct sock *sk, __u32 ack, __u32 acke
 	tcp_cong_avoid_ai(tp, ca->cnt, acked);
 }
 
-__u32 BPF_STRUCT_OPS(bpf_cubic_recalc_ssthresh, struct sock *sk)
+SEC("struct_ops")
+__u32 BPF_PROG(bpf_cubic_recalc_ssthresh, struct sock *sk)
 {
 	const struct tcp_sock *tp = tcp_sk(sk);
 	struct bictcp *ca = inet_csk_ca(sk);
@@ -414,7 +412,8 @@ __u32 BPF_STRUCT_OPS(bpf_cubic_recalc_ssthresh, struct sock *sk)
 	return max((tp->snd_cwnd * beta) / BICTCP_BETA_SCALE, 2U);
 }
 
-void BPF_STRUCT_OPS(bpf_cubic_state, struct sock *sk, __u8 new_state)
+SEC("struct_ops")
+void BPF_PROG(bpf_cubic_state, struct sock *sk, __u8 new_state)
 {
 	if (new_state == TCP_CA_Loss) {
 		bictcp_reset(inet_csk_ca(sk));
@@ -433,7 +432,7 @@ void BPF_STRUCT_OPS(bpf_cubic_state, struct sock *sk, __u8 new_state)
  * We apply another 100% factor because @rate is doubled at this point.
  * We cap the cushion to 1ms.
  */
-static __always_inline __u32 hystart_ack_delay(struct sock *sk)
+static __u32 hystart_ack_delay(struct sock *sk)
 {
 	unsigned long rate;
 
@@ -444,7 +443,7 @@ static __always_inline __u32 hystart_ack_delay(struct sock *sk)
 		   div64_ul((__u64)GSO_MAX_SIZE * 4 * USEC_PER_SEC, rate));
 }
 
-static __always_inline void hystart_update(struct sock *sk, __u32 delay)
+static void hystart_update(struct sock *sk, __u32 delay)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct bictcp *ca = inet_csk_ca(sk);
@@ -492,8 +491,8 @@ static __always_inline void hystart_update(struct sock *sk, __u32 delay)
 
 int bpf_cubic_acked_called = 0;
 
-void BPF_STRUCT_OPS(bpf_cubic_acked, struct sock *sk,
-		    const struct ack_sample *sample)
+SEC("struct_ops")
+void BPF_PROG(bpf_cubic_acked, struct sock *sk, const struct ack_sample *sample)
 {
 	const struct tcp_sock *tp = tcp_sk(sk);
 	struct bictcp *ca = inet_csk_ca(sk);
@@ -524,7 +523,8 @@ void BPF_STRUCT_OPS(bpf_cubic_acked, struct sock *sk,
 
 extern __u32 tcp_reno_undo_cwnd(struct sock *sk) __ksym;
 
-__u32 BPF_STRUCT_OPS(bpf_cubic_undo_cwnd, struct sock *sk)
+SEC("struct_ops")
+__u32 BPF_PROG(bpf_cubic_undo_cwnd, struct sock *sk)
 {
 	return tcp_reno_undo_cwnd(sk);
 }
diff --git a/tools/testing/selftests/bpf/progs/bpf_dctcp.c b/tools/testing/selftests/bpf/progs/bpf_dctcp.c
index 460682759aed..b74dbb121384 100644
--- a/tools/testing/selftests/bpf/progs/bpf_dctcp.c
+++ b/tools/testing/selftests/bpf/progs/bpf_dctcp.c
@@ -48,8 +48,7 @@ struct dctcp {
 static unsigned int dctcp_shift_g = 4; /* g = 1/2^4 */
 static unsigned int dctcp_alpha_on_init = DCTCP_MAX_ALPHA;
 
-static __always_inline void dctcp_reset(const struct tcp_sock *tp,
-					struct dctcp *ca)
+static void dctcp_reset(const struct tcp_sock *tp, struct dctcp *ca)
 {
 	ca->next_seq = tp->snd_nxt;
 
@@ -57,7 +56,7 @@ static __always_inline void dctcp_reset(const struct tcp_sock *tp,
 	ca->old_delivered_ce = tp->delivered_ce;
 }
 
-SEC("struct_ops/dctcp_init")
+SEC("struct_ops")
 void BPF_PROG(dctcp_init, struct sock *sk)
 {
 	const struct tcp_sock *tp = tcp_sk(sk);
@@ -104,7 +103,7 @@ void BPF_PROG(dctcp_init, struct sock *sk)
 	dctcp_reset(tp, ca);
 }
 
-SEC("struct_ops/dctcp_ssthresh")
+SEC("struct_ops")
 __u32 BPF_PROG(dctcp_ssthresh, struct sock *sk)
 {
 	struct dctcp *ca = inet_csk_ca(sk);
@@ -114,7 +113,7 @@ __u32 BPF_PROG(dctcp_ssthresh, struct sock *sk)
 	return max(tp->snd_cwnd - ((tp->snd_cwnd * ca->dctcp_alpha) >> 11U), 2U);
 }
 
-SEC("struct_ops/dctcp_update_alpha")
+SEC("struct_ops")
 void BPF_PROG(dctcp_update_alpha, struct sock *sk, __u32 flags)
 {
 	const struct tcp_sock *tp = tcp_sk(sk);
@@ -144,7 +143,7 @@ void BPF_PROG(dctcp_update_alpha, struct sock *sk, __u32 flags)
 	}
 }
 
-static __always_inline void dctcp_react_to_loss(struct sock *sk)
+static void dctcp_react_to_loss(struct sock *sk)
 {
 	struct dctcp *ca = inet_csk_ca(sk);
 	struct tcp_sock *tp = tcp_sk(sk);
@@ -153,7 +152,7 @@ static __always_inline void dctcp_react_to_loss(struct sock *sk)
 	tp->snd_ssthresh = max(tp->snd_cwnd >> 1U, 2U);
 }
 
-SEC("struct_ops/dctcp_state")
+SEC("struct_ops")
 void BPF_PROG(dctcp_state, struct sock *sk, __u8 new_state)
 {
 	if (new_state == TCP_CA_Recovery &&
@@ -164,7 +163,7 @@ void BPF_PROG(dctcp_state, struct sock *sk, __u8 new_state)
 	 */
 }
 
-static __always_inline void dctcp_ece_ack_cwr(struct sock *sk, __u32 ce_state)
+static void dctcp_ece_ack_cwr(struct sock *sk, __u32 ce_state)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 
@@ -179,9 +178,8 @@ static __always_inline void dctcp_ece_ack_cwr(struct sock *sk, __u32 ce_state)
  * S:	0 <- last pkt was non-CE
  *	1 <- last pkt was CE
  */
-static __always_inline
-void dctcp_ece_ack_update(struct sock *sk, enum tcp_ca_event evt,
-			  __u32 *prior_rcv_nxt, __u32 *ce_state)
+static void dctcp_ece_ack_update(struct sock *sk, enum tcp_ca_event evt,
+				 __u32 *prior_rcv_nxt, __u32 *ce_state)
 {
 	__u32 new_ce_state = (evt == CA_EVENT_ECN_IS_CE) ? 1 : 0;
 
@@ -201,7 +199,7 @@ void dctcp_ece_ack_update(struct sock *sk, enum tcp_ca_event evt,
 	dctcp_ece_ack_cwr(sk, new_ce_state);
 }
 
-SEC("struct_ops/dctcp_cwnd_event")
+SEC("struct_ops")
 void BPF_PROG(dctcp_cwnd_event, struct sock *sk, enum tcp_ca_event ev)
 {
 	struct dctcp *ca = inet_csk_ca(sk);
@@ -220,7 +218,7 @@ void BPF_PROG(dctcp_cwnd_event, struct sock *sk, enum tcp_ca_event ev)
 	}
 }
 
-SEC("struct_ops/dctcp_cwnd_undo")
+SEC("struct_ops")
 __u32 BPF_PROG(dctcp_cwnd_undo, struct sock *sk)
 {
 	const struct dctcp *ca = inet_csk_ca(sk);
@@ -230,7 +228,7 @@ __u32 BPF_PROG(dctcp_cwnd_undo, struct sock *sk)
 
 extern void tcp_reno_cong_avoid(struct sock *sk, __u32 ack, __u32 acked) __ksym;
 
-SEC("struct_ops/dctcp_reno_cong_avoid")
+SEC("struct_ops")
 void BPF_PROG(dctcp_cong_avoid, struct sock *sk, __u32 ack, __u32 acked)
 {
 	tcp_reno_cong_avoid(sk, ack, acked);
diff --git a/tools/testing/selftests/bpf/progs/bpf_dctcp_release.c b/tools/testing/selftests/bpf/progs/bpf_dctcp_release.c
index d836f7c372f0..a946b070bb06 100644
--- a/tools/testing/selftests/bpf/progs/bpf_dctcp_release.c
+++ b/tools/testing/selftests/bpf/progs/bpf_dctcp_release.c
@@ -13,7 +13,8 @@
 char _license[] SEC("license") = "GPL";
 const char cubic[] = "cubic";
 
-void BPF_STRUCT_OPS(dctcp_nouse_release, struct sock *sk)
+SEC("struct_ops")
+void BPF_PROG(dctcp_nouse_release, struct sock *sk)
 {
 	bpf_setsockopt(sk, SOL_TCP, TCP_CONGESTION,
 		       (void *)cubic, sizeof(cubic));
diff --git a/tools/testing/selftests/bpf/progs/bpf_tcp_nogpl.c b/tools/testing/selftests/bpf/progs/bpf_tcp_nogpl.c
index 2ecd833dcd41..633164e704dd 100644
--- a/tools/testing/selftests/bpf/progs/bpf_tcp_nogpl.c
+++ b/tools/testing/selftests/bpf/progs/bpf_tcp_nogpl.c
@@ -8,7 +8,8 @@
 
 char _license[] SEC("license") = "X";
 
-void BPF_STRUCT_OPS(nogpltcp_init, struct sock *sk)
+SEC("struct_ops")
+void BPF_PROG(nogpltcp_init, struct sock *sk)
 {
 }
 
diff --git a/tools/testing/selftests/bpf/progs/tcp_ca_incompl_cong_ops.c b/tools/testing/selftests/bpf/progs/tcp_ca_incompl_cong_ops.c
index d6467fcb1deb..0016c90e9c13 100644
--- a/tools/testing/selftests/bpf/progs/tcp_ca_incompl_cong_ops.c
+++ b/tools/testing/selftests/bpf/progs/tcp_ca_incompl_cong_ops.c
@@ -6,13 +6,13 @@
 
 char _license[] SEC("license") = "GPL";
 
-SEC("struct_ops/incompl_cong_ops_ssthresh")
+SEC("struct_ops")
 __u32 BPF_PROG(incompl_cong_ops_ssthresh, struct sock *sk)
 {
 	return tcp_sk(sk)->snd_ssthresh;
 }
 
-SEC("struct_ops/incompl_cong_ops_undo_cwnd")
+SEC("struct_ops")
 __u32 BPF_PROG(incompl_cong_ops_undo_cwnd, struct sock *sk)
 {
 	return tcp_sk(sk)->snd_cwnd;
diff --git a/tools/testing/selftests/bpf/progs/tcp_ca_kfunc.c b/tools/testing/selftests/bpf/progs/tcp_ca_kfunc.c
index 52b610357309..f95862f570b7 100644
--- a/tools/testing/selftests/bpf/progs/tcp_ca_kfunc.c
+++ b/tools/testing/selftests/bpf/progs/tcp_ca_kfunc.c
@@ -27,7 +27,7 @@ extern void cubictcp_state(struct sock *sk, u8 new_state) __ksym;
 extern void cubictcp_cwnd_event(struct sock *sk, enum tcp_ca_event event) __ksym;
 extern void cubictcp_acked(struct sock *sk, const struct ack_sample *sample) __ksym;
 
-SEC("struct_ops/init")
+SEC("struct_ops")
 void BPF_PROG(init, struct sock *sk)
 {
 	bbr_init(sk);
@@ -35,38 +35,38 @@ void BPF_PROG(init, struct sock *sk)
 	cubictcp_init(sk);
 }
 
-SEC("struct_ops/in_ack_event")
+SEC("struct_ops")
 void BPF_PROG(in_ack_event, struct sock *sk, u32 flags)
 {
 	dctcp_update_alpha(sk, flags);
 }
 
-SEC("struct_ops/cong_control")
+SEC("struct_ops")
 void BPF_PROG(cong_control, struct sock *sk, u32 ack, int flag, const struct rate_sample *rs)
 {
 	bbr_main(sk, ack, flag, rs);
 }
 
-SEC("struct_ops/cong_avoid")
+SEC("struct_ops")
 void BPF_PROG(cong_avoid, struct sock *sk, u32 ack, u32 acked)
 {
 	cubictcp_cong_avoid(sk, ack, acked);
 }
 
-SEC("struct_ops/sndbuf_expand")
+SEC("struct_ops")
 u32 BPF_PROG(sndbuf_expand, struct sock *sk)
 {
 	return bbr_sndbuf_expand(sk);
 }
 
-SEC("struct_ops/undo_cwnd")
+SEC("struct_ops")
 u32 BPF_PROG(undo_cwnd, struct sock *sk)
 {
 	bbr_undo_cwnd(sk);
 	return dctcp_cwnd_undo(sk);
 }
 
-SEC("struct_ops/cwnd_event")
+SEC("struct_ops")
 void BPF_PROG(cwnd_event, struct sock *sk, enum tcp_ca_event event)
 {
 	bbr_cwnd_event(sk, event);
@@ -74,7 +74,7 @@ void BPF_PROG(cwnd_event, struct sock *sk, enum tcp_ca_event event)
 	cubictcp_cwnd_event(sk, event);
 }
 
-SEC("struct_ops/ssthresh")
+SEC("struct_ops")
 u32 BPF_PROG(ssthresh, struct sock *sk)
 {
 	bbr_ssthresh(sk);
@@ -82,13 +82,13 @@ u32 BPF_PROG(ssthresh, struct sock *sk)
 	return cubictcp_recalc_ssthresh(sk);
 }
 
-SEC("struct_ops/min_tso_segs")
+SEC("struct_ops")
 u32 BPF_PROG(min_tso_segs, struct sock *sk)
 {
 	return bbr_min_tso_segs(sk);
 }
 
-SEC("struct_ops/set_state")
+SEC("struct_ops")
 void BPF_PROG(set_state, struct sock *sk, u8 new_state)
 {
 	bbr_set_state(sk, new_state);
@@ -96,7 +96,7 @@ void BPF_PROG(set_state, struct sock *sk, u8 new_state)
 	cubictcp_state(sk, new_state);
 }
 
-SEC("struct_ops/pkts_acked")
+SEC("struct_ops")
 void BPF_PROG(pkts_acked, struct sock *sk, const struct ack_sample *sample)
 {
 	cubictcp_acked(sk, sample);
diff --git a/tools/testing/selftests/bpf/progs/tcp_ca_unsupp_cong_op.c b/tools/testing/selftests/bpf/progs/tcp_ca_unsupp_cong_op.c
index c06f4a41c21a..54f916a931c6 100644
--- a/tools/testing/selftests/bpf/progs/tcp_ca_unsupp_cong_op.c
+++ b/tools/testing/selftests/bpf/progs/tcp_ca_unsupp_cong_op.c
@@ -7,7 +7,7 @@
 
 char _license[] SEC("license") = "GPL";
 
-SEC("struct_ops/unsupp_cong_op_get_info")
+SEC("struct_ops")
 size_t BPF_PROG(unsupp_cong_op_get_info, struct sock *sk, u32 ext, int *attr,
 		union tcp_cc_info *info)
 {
diff --git a/tools/testing/selftests/bpf/progs/tcp_ca_update.c b/tools/testing/selftests/bpf/progs/tcp_ca_update.c
index 8581cad321b6..e4bd82bc0d01 100644
--- a/tools/testing/selftests/bpf/progs/tcp_ca_update.c
+++ b/tools/testing/selftests/bpf/progs/tcp_ca_update.c
@@ -9,31 +9,31 @@ char _license[] SEC("license") = "GPL";
 int ca1_cnt = 0;
 int ca2_cnt = 0;
 
-SEC("struct_ops/ca_update_1_init")
+SEC("struct_ops")
 void BPF_PROG(ca_update_1_init, struct sock *sk)
 {
 	ca1_cnt++;
 }
 
-SEC("struct_ops/ca_update_2_init")
+SEC("struct_ops")
 void BPF_PROG(ca_update_2_init, struct sock *sk)
 {
 	ca2_cnt++;
 }
 
-SEC("struct_ops/ca_update_cong_control")
+SEC("struct_ops")
 void BPF_PROG(ca_update_cong_control, struct sock *sk,
 	      const struct rate_sample *rs)
 {
 }
 
-SEC("struct_ops/ca_update_ssthresh")
+SEC("struct_ops")
 __u32 BPF_PROG(ca_update_ssthresh, struct sock *sk)
 {
 	return tcp_sk(sk)->snd_ssthresh;
 }
 
-SEC("struct_ops/ca_update_undo_cwnd")
+SEC("struct_ops")
 __u32 BPF_PROG(ca_update_undo_cwnd, struct sock *sk)
 {
 	return tcp_sk(sk)->snd_cwnd;
diff --git a/tools/testing/selftests/bpf/progs/tcp_ca_write_sk_pacing.c b/tools/testing/selftests/bpf/progs/tcp_ca_write_sk_pacing.c
index 4a369439335e..a58b5194fc89 100644
--- a/tools/testing/selftests/bpf/progs/tcp_ca_write_sk_pacing.c
+++ b/tools/testing/selftests/bpf/progs/tcp_ca_write_sk_pacing.c
@@ -10,17 +10,17 @@ char _license[] SEC("license") = "GPL";
 
 #define min(a, b) ((a) < (b) ? (a) : (b))
 
-static inline unsigned int tcp_left_out(const struct tcp_sock *tp)
+static unsigned int tcp_left_out(const struct tcp_sock *tp)
 {
 	return tp->sacked_out + tp->lost_out;
 }
 
-static inline unsigned int tcp_packets_in_flight(const struct tcp_sock *tp)
+static unsigned int tcp_packets_in_flight(const struct tcp_sock *tp)
 {
 	return tp->packets_out - tcp_left_out(tp) + tp->retrans_out;
 }
 
-SEC("struct_ops/write_sk_pacing_init")
+SEC("struct_ops")
 void BPF_PROG(write_sk_pacing_init, struct sock *sk)
 {
 #ifdef ENABLE_ATOMICS_TESTS
@@ -31,7 +31,7 @@ void BPF_PROG(write_sk_pacing_init, struct sock *sk)
 #endif
 }
 
-SEC("struct_ops/write_sk_pacing_cong_control")
+SEC("struct_ops")
 void BPF_PROG(write_sk_pacing_cong_control, struct sock *sk,
 	      const struct rate_sample *rs)
 {
@@ -43,13 +43,13 @@ void BPF_PROG(write_sk_pacing_cong_control, struct sock *sk,
 	tp->app_limited = (tp->delivered + tcp_packets_in_flight(tp)) ?: 1;
 }
 
-SEC("struct_ops/write_sk_pacing_ssthresh")
+SEC("struct_ops")
 __u32 BPF_PROG(write_sk_pacing_ssthresh, struct sock *sk)
 {
 	return tcp_sk(sk)->snd_ssthresh;
 }
 
-SEC("struct_ops/write_sk_pacing_undo_cwnd")
+SEC("struct_ops")
 __u32 BPF_PROG(write_sk_pacing_undo_cwnd, struct sock *sk)
 {
 	return tcp_sk(sk)->snd_cwnd;
-- 
2.43.0


