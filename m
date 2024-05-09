Return-Path: <bpf+bounces-29213-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0598C1457
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 19:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41349B2116C
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 17:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D7877101;
	Thu,  9 May 2024 17:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Usytzlhv"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB61217BA9
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 17:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715277047; cv=none; b=ZZXpEyrfkSqdpiRMIeRiZvnE54JWhVVCzIbLKAW7a2xKRwNzIoR+cmNOtAb5LZYQGHzpcsqHz4rRLShT5xqxxbaIdm7+4r8iYFRWoDRcwO1CdG0e+A7SweMN12f817lujp/X4JFJAed0aHvn1UAHs4yfZDEkatzoiDFFGhNPHi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715277047; c=relaxed/simple;
	bh=7AinhW8PeRgCKwm5X6LpTK9icY3BWWPadsJhp9T+aqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c4zlFcMTjR+132/+5ovEib3HP3yMDeFYLhwOX8BGgEtYRpEaUV0BDHjGb3TgTrXabO3+d8YLUoktH/TXdw8Xr5empHC96gMXZmnyLQfa7IzEUi9RLQERn+VB4iB8gA7pftpgtP7M4Er+7NMoSvyFFrNGwakFQHNJmdlBBOTc7Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Usytzlhv; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715277044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9SBxpPV1IpkKBGPrd7WrLW34xBrfI+VLZ9cvhss1KQY=;
	b=UsytzlhvUg2kn69TPR6DmDRmqwP7POZjDuCvUfVfOuIe3ShsxZvcNQs/A6O3C9QepIEqY9
	AeGBavCsCNhAO6gCkSHqx2pOE/yWo1fKXZEJKskGaJQGcok/rEBD+DmpdT1MEySj6wgg9Y
	tb9RjE7Zoc449eWOGUKmDPkCAs785RY=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@meta.com
Subject: [PATCH bpf-next 05/10] selftests/bpf: Rename tcp-cc private struct in bpf_cubic and bpf_dctcp
Date: Thu,  9 May 2024 10:50:21 -0700
Message-ID: <20240509175026.3423614-6-martin.lau@linux.dev>
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

The "struct bictcp" and "struct dctcp" are private to the bpf prog
and they are stored in the private buffer in inet_csk(sk)->icsk_ca_priv.
Hence, there is no bpf CO-RE required.

The same struct name exists in the vmlinux.h. To reuse vmlinux.h,
they need to be renamed such that the bpf prog logic will be
immuned from the kernel tcp-cc changes.

This patch adds a "bpf_" prefix to them.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 tools/testing/selftests/bpf/progs/bpf_cubic.c | 20 +++++++++----------
 tools/testing/selftests/bpf/progs/bpf_dctcp.c | 16 +++++++--------
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_cubic.c b/tools/testing/selftests/bpf/progs/bpf_cubic.c
index 53a98b609e5f..53872e2d2c52 100644
--- a/tools/testing/selftests/bpf/progs/bpf_cubic.c
+++ b/tools/testing/selftests/bpf/progs/bpf_cubic.c
@@ -70,7 +70,7 @@ static const __u64 cube_factor = (__u64)(1ull << (10+3*BICTCP_HZ))
 				/ (bic_scale * 10);
 
 /* BIC TCP Parameters */
-struct bictcp {
+struct bpf_bictcp {
 	__u32	cnt;		/* increase cwnd by 1 after ACKs */
 	__u32	last_max_cwnd;	/* last maximum snd_cwnd */
 	__u32	last_cwnd;	/* the last snd_cwnd */
@@ -91,7 +91,7 @@ struct bictcp {
 	__u32	curr_rtt;	/* the minimum rtt of current round */
 };
 
-static void bictcp_reset(struct bictcp *ca)
+static void bictcp_reset(struct bpf_bictcp *ca)
 {
 	ca->cnt = 0;
 	ca->last_max_cwnd = 0;
@@ -161,7 +161,7 @@ static __u32 bictcp_clock_us(const struct sock *sk)
 static void bictcp_hystart_reset(struct sock *sk)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
-	struct bictcp *ca = inet_csk_ca(sk);
+	struct bpf_bictcp *ca = inet_csk_ca(sk);
 
 	ca->round_start = ca->last_ack = bictcp_clock_us(sk);
 	ca->end_seq = tp->snd_nxt;
@@ -172,7 +172,7 @@ static void bictcp_hystart_reset(struct sock *sk)
 SEC("struct_ops")
 void BPF_PROG(bpf_cubic_init, struct sock *sk)
 {
-	struct bictcp *ca = inet_csk_ca(sk);
+	struct bpf_bictcp *ca = inet_csk_ca(sk);
 
 	bictcp_reset(ca);
 
@@ -187,7 +187,7 @@ SEC("struct_ops")
 void BPF_PROG(bpf_cubic_cwnd_event, struct sock *sk, enum tcp_ca_event event)
 {
 	if (event == CA_EVENT_TX_START) {
-		struct bictcp *ca = inet_csk_ca(sk);
+		struct bpf_bictcp *ca = inet_csk_ca(sk);
 		__u32 now = tcp_jiffies32;
 		__s32 delta;
 
@@ -261,7 +261,7 @@ static __u32 cubic_root(__u64 a)
 /*
  * Compute congestion window to use.
  */
-static void bictcp_update(struct bictcp *ca, __u32 cwnd, __u32 acked)
+static void bictcp_update(struct bpf_bictcp *ca, __u32 cwnd, __u32 acked)
 {
 	__u32 delta, bic_target, max_cnt;
 	__u64 offs, t;
@@ -378,7 +378,7 @@ SEC("struct_ops")
 void BPF_PROG(bpf_cubic_cong_avoid, struct sock *sk, __u32 ack, __u32 acked)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
-	struct bictcp *ca = inet_csk_ca(sk);
+	struct bpf_bictcp *ca = inet_csk_ca(sk);
 
 	if (!tcp_is_cwnd_limited(sk))
 		return;
@@ -398,7 +398,7 @@ SEC("struct_ops")
 __u32 BPF_PROG(bpf_cubic_recalc_ssthresh, struct sock *sk)
 {
 	const struct tcp_sock *tp = tcp_sk(sk);
-	struct bictcp *ca = inet_csk_ca(sk);
+	struct bpf_bictcp *ca = inet_csk_ca(sk);
 
 	ca->epoch_start = 0;	/* end of epoch */
 
@@ -446,7 +446,7 @@ static __u32 hystart_ack_delay(struct sock *sk)
 static void hystart_update(struct sock *sk, __u32 delay)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
-	struct bictcp *ca = inet_csk_ca(sk);
+	struct bpf_bictcp *ca = inet_csk_ca(sk);
 	__u32 threshold;
 
 	if (hystart_detect & HYSTART_ACK_TRAIN) {
@@ -495,7 +495,7 @@ SEC("struct_ops")
 void BPF_PROG(bpf_cubic_acked, struct sock *sk, const struct ack_sample *sample)
 {
 	const struct tcp_sock *tp = tcp_sk(sk);
-	struct bictcp *ca = inet_csk_ca(sk);
+	struct bpf_bictcp *ca = inet_csk_ca(sk);
 	__u32 delay;
 
 	bpf_cubic_acked_called = 1;
diff --git a/tools/testing/selftests/bpf/progs/bpf_dctcp.c b/tools/testing/selftests/bpf/progs/bpf_dctcp.c
index b74dbb121384..a8673b7ff35d 100644
--- a/tools/testing/selftests/bpf/progs/bpf_dctcp.c
+++ b/tools/testing/selftests/bpf/progs/bpf_dctcp.c
@@ -35,7 +35,7 @@ struct {
 
 #define DCTCP_MAX_ALPHA	1024U
 
-struct dctcp {
+struct bpf_dctcp {
 	__u32 old_delivered;
 	__u32 old_delivered_ce;
 	__u32 prior_rcv_nxt;
@@ -48,7 +48,7 @@ struct dctcp {
 static unsigned int dctcp_shift_g = 4; /* g = 1/2^4 */
 static unsigned int dctcp_alpha_on_init = DCTCP_MAX_ALPHA;
 
-static void dctcp_reset(const struct tcp_sock *tp, struct dctcp *ca)
+static void dctcp_reset(const struct tcp_sock *tp, struct bpf_dctcp *ca)
 {
 	ca->next_seq = tp->snd_nxt;
 
@@ -60,7 +60,7 @@ SEC("struct_ops")
 void BPF_PROG(dctcp_init, struct sock *sk)
 {
 	const struct tcp_sock *tp = tcp_sk(sk);
-	struct dctcp *ca = inet_csk_ca(sk);
+	struct bpf_dctcp *ca = inet_csk_ca(sk);
 	int *stg;
 
 	if (!(tp->ecn_flags & TCP_ECN_OK) && fallback[0]) {
@@ -106,7 +106,7 @@ void BPF_PROG(dctcp_init, struct sock *sk)
 SEC("struct_ops")
 __u32 BPF_PROG(dctcp_ssthresh, struct sock *sk)
 {
-	struct dctcp *ca = inet_csk_ca(sk);
+	struct bpf_dctcp *ca = inet_csk_ca(sk);
 	struct tcp_sock *tp = tcp_sk(sk);
 
 	ca->loss_cwnd = tp->snd_cwnd;
@@ -117,7 +117,7 @@ SEC("struct_ops")
 void BPF_PROG(dctcp_update_alpha, struct sock *sk, __u32 flags)
 {
 	const struct tcp_sock *tp = tcp_sk(sk);
-	struct dctcp *ca = inet_csk_ca(sk);
+	struct bpf_dctcp *ca = inet_csk_ca(sk);
 
 	/* Expired RTT */
 	if (!before(tp->snd_una, ca->next_seq)) {
@@ -145,7 +145,7 @@ void BPF_PROG(dctcp_update_alpha, struct sock *sk, __u32 flags)
 
 static void dctcp_react_to_loss(struct sock *sk)
 {
-	struct dctcp *ca = inet_csk_ca(sk);
+	struct bpf_dctcp *ca = inet_csk_ca(sk);
 	struct tcp_sock *tp = tcp_sk(sk);
 
 	ca->loss_cwnd = tp->snd_cwnd;
@@ -202,7 +202,7 @@ static void dctcp_ece_ack_update(struct sock *sk, enum tcp_ca_event evt,
 SEC("struct_ops")
 void BPF_PROG(dctcp_cwnd_event, struct sock *sk, enum tcp_ca_event ev)
 {
-	struct dctcp *ca = inet_csk_ca(sk);
+	struct bpf_dctcp *ca = inet_csk_ca(sk);
 
 	switch (ev) {
 	case CA_EVENT_ECN_IS_CE:
@@ -221,7 +221,7 @@ void BPF_PROG(dctcp_cwnd_event, struct sock *sk, enum tcp_ca_event ev)
 SEC("struct_ops")
 __u32 BPF_PROG(dctcp_cwnd_undo, struct sock *sk)
 {
-	const struct dctcp *ca = inet_csk_ca(sk);
+	const struct bpf_dctcp *ca = inet_csk_ca(sk);
 
 	return max(tcp_sk(sk)->snd_cwnd, ca->loss_cwnd);
 }
-- 
2.43.0


