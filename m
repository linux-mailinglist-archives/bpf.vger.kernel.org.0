Return-Path: <bpf+bounces-28422-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD618B93D9
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 06:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32ECF1F21F31
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 04:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543691BF54;
	Thu,  2 May 2024 04:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="aJ9HJE6n"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305B61B815
	for <bpf@vger.kernel.org>; Thu,  2 May 2024 04:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714623835; cv=none; b=qOUMSqGQI9YRFFffiHDSq/THGMEn1a9jZYbn9jMpnN6QrJPebyijw4tiydZCdKXH/vXHP++6QE9hW/cGuJG+CY0rkGf+PWkxE4EX7vrh6eDNqck+Iw8EKy8Y3SmWTBXPNXSv/3qt284KeuODQZpRuvCcxHoON+EKYlsKbactfUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714623835; c=relaxed/simple;
	bh=nq4J+JF/nlZncQ9KRhE7y7GG5Mp/mKSDdzAHJp7VVqA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=djNm26SPiUUHmpcNt8gbJrYX0OlMuY+PcF/bjATjC8/vxvS//2fV2d2Zb6Mz+wPMMo3wL5vwC3B2DUL/oRsQd5eosLMbH3N3A7FkSLADEnmsFa/JB9zsIWlujIabt04TMsZ4bqxNuZbIK0yXVmvTGChOwSPz3MsDF87q4r/vFFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=aJ9HJE6n; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 441L060L025995
	for <bpf@vger.kernel.org>; Wed, 1 May 2024 21:23:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=CmM0TG0WgPsvqMWWyrMseQcITzyN2UNylHaeM4P42lA=;
 b=aJ9HJE6nnCG9qn8xvGkrLhf59O8bKaThZ5aq7ArPgXUePLpq7P28CKgzqqZPQxkcB8Ou
 wJTFCkxZc2A4e5JJ+cpkOxQ8zXm2mA8kuteES0T6PrqSKqB6y+xkJoVVlaHtLgrM2a54
 a16hA5WEexQnDeUokWKJbNI3Wsh73eyLl0zfT/XrCI4T/c39IM6nhzP4N6E2+UKjh5ul
 zB+dxQbFykbVzAx2KcjWxI/rUZ3UCsK6joiHu4RzRL1wC6T4MDzOlxYfVovC3ygfDj7/
 ncbKxxYF3sJPYwgu/73jZ5bnK6rI0Lkkz1CNG6WikZYOdmZIGF05BEk/EDl3ehua+jtq /A== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0089730.ppops.net (PPS) with ESMTPS id 3xu2ymk05c-12
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 01 May 2024 21:23:52 -0700
Received: from twshared18280.38.frc1.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 1 May 2024 21:23:46 -0700
Received: by devvm15954.vll0.facebook.com (Postfix, from userid 420730)
	id 72CB7CB262BB; Wed,  1 May 2024 21:23:45 -0700 (PDT)
From: Miao Xu <miaxu@meta.com>
To: Eric Dumazet <edumazet@google.com>,
        "David S . Miller"
	<davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>, Martin Lau
	<kafai@meta.com>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, Miao Xu <miaxu@meta.com>
Subject: [PATCH net-next v3 3/3] selftests/bpf: Add test for the use of new args in cong_control
Date: Wed, 1 May 2024 21:23:18 -0700
Message-ID: <20240502042318.801932-4-miaxu@meta.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240502042318.801932-1-miaxu@meta.com>
References: <20240502042318.801932-1-miaxu@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: BDSjakxhxFbNNVc1MwBVbJCELwof-0En
X-Proofpoint-GUID: BDSjakxhxFbNNVc1MwBVbJCELwof-0En
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_16,2024-04-30_01,2023-05-22_02

This patch adds a selftest to show the usage of the new arguments in
cong_control. For simplicity's sake, the testing example reuses cubic's
kernel functions.
---
Changes in v3:
* Renamed the selftest file and the bpf struct_ops' name.
* Minor changes such as removing unused comments.

Changes in v2:
* Added highlights to explain major differences between the bpf program
and tcp_cubic.c.
* bpf_tcp_helpers.h should not be further extended, so remove the
  dependency on this file. Use vmlinux.h instead.
* Minor changes such as indentation.

Signed-off-by: Miao Xu <miaxu@meta.com>
---
 .../selftests/bpf/progs/bpf_cc_cubic.c        | 206 ++++++++++++++++++
 .../selftests/bpf/progs/bpf_tracing_net.h     |  10 +
 2 files changed, 216 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_cc_cubic.c

diff --git a/tools/testing/selftests/bpf/progs/bpf_cc_cubic.c b/tools/tes=
ting/selftests/bpf/progs/bpf_cc_cubic.c
new file mode 100644
index 000000000000..e37868c05794
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_cc_cubic.c
@@ -0,0 +1,206 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/* Highlights:
+ * 1. The major difference between this bpf program and tcp_cubic.c
+ *    is that this bpf program relies on `cong_control` rather than
+ *    `cong_avoid` in the struct tcp_congestion_ops.
+ * 2. Logic such as tcp_cwnd_reduction, tcp_cong_avoid, and
+ *    tcp_update_pacing_rate is bypassed when `cong_control` is
+ *    defined, so moving these logic to `cong_control`.
+ * 3. WARNING: This bpf program is NOT the same as tcp_cubic.c.
+ *    The main purpose is to show use cases of the arguments in
+ *    `cong_control`. For simplicity's sake, it reuses tcp cubic's
+ *    kernel functions.
+ */
+
+#include "vmlinux.h"
+
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_tracing_net.h"
+
+#define BPF_STRUCT_OPS(name, args...) \
+SEC("struct_ops/"#name) \
+BPF_PROG(name, args)
+
+
+#define min(a, b) ((a) < (b) ? (a) : (b))
+#define max(a, b) ((a) > (b) ? (a) : (b))
+
+static __always_inline struct inet_connection_sock *inet_csk(const struc=
t sock *sk)
+{
+	return (struct inet_connection_sock *)sk;
+}
+
+static __always_inline struct tcp_sock *tcp_sk(const struct sock *sk)
+{
+	return (struct tcp_sock *)sk;
+}
+
+static __always_inline bool before(__u32 seq1, __u32 seq2)
+{
+	return (__s32)(seq1-seq2) < 0;
+}
+#define after(seq2, seq1) before(seq1, seq2)
+
+char _license[] SEC("license") =3D "GPL";
+
+extern void cubictcp_init(struct sock *sk) __ksym;
+extern void cubictcp_cwnd_event(struct sock *sk, enum tcp_ca_event event=
) __ksym;
+extern __u32 cubictcp_recalc_ssthresh(struct sock *sk) __ksym;
+extern void cubictcp_state(struct sock *sk, __u8 new_state) __ksym;
+extern __u32 tcp_reno_undo_cwnd(struct sock *sk) __ksym;
+extern void cubictcp_acked(struct sock *sk, const struct ack_sample *sam=
ple) __ksym;
+extern void cubictcp_cong_avoid(struct sock *sk, __u32 ack, __u32 acked)=
 __ksym;
+
+
+void BPF_STRUCT_OPS(bpf_cubic_init, struct sock *sk)
+{
+	cubictcp_init(sk);
+}
+
+void BPF_STRUCT_OPS(bpf_cubic_cwnd_event, struct sock *sk, enum tcp_ca_e=
vent event)
+{
+	cubictcp_cwnd_event(sk, event);
+}
+
+#define USEC_PER_SEC 1000000UL
+#define TCP_PACING_SS_RATIO (200)
+#define TCP_PACING_CA_RATIO (120)
+#define TCP_REORDERING (12)
+#define likely(x) (__builtin_expect(!!(x), 1))
+
+static __always_inline __u64 div64_u64(__u64 dividend, __u64 divisor)
+{
+	return dividend / divisor;
+}
+
+static __always_inline void tcp_update_pacing_rate(struct sock *sk)
+{
+	const struct tcp_sock *tp =3D tcp_sk(sk);
+	__u64 rate;
+
+	/* set sk_pacing_rate to 200 % of current rate (mss * cwnd / srtt) */
+	rate =3D (__u64)tp->mss_cache * ((USEC_PER_SEC / 100) << 3);
+
+	/* current rate is (cwnd * mss) / srtt
+	 * In Slow Start [1], set sk_pacing_rate to 200 % the current rate.
+	 * In Congestion Avoidance phase, set it to 120 % the current rate.
+	 *
+	 * [1] : Normal Slow Start condition is (tp->snd_cwnd < tp->snd_ssthres=
h)
+	 *	 If snd_cwnd >=3D (tp->snd_ssthresh / 2), we are approaching
+	 *	 end of slow start and should slow down.
+	 */
+	if (tp->snd_cwnd < tp->snd_ssthresh / 2)
+		rate *=3D TCP_PACING_SS_RATIO;
+	else
+		rate *=3D TCP_PACING_CA_RATIO;
+
+	rate *=3D max(tp->snd_cwnd, tp->packets_out);
+
+	if (likely(tp->srtt_us))
+		rate =3D div64_u64(rate, (__u64)tp->srtt_us);
+
+	sk->sk_pacing_rate =3D min(rate, sk->sk_max_pacing_rate);
+}
+
+static __always_inline void tcp_cwnd_reduction(
+		struct sock *sk,
+		int newly_acked_sacked,
+		int newly_lost,
+		int flag) {
+	struct tcp_sock *tp =3D tcp_sk(sk);
+	int sndcnt =3D 0;
+	__u32 pkts_in_flight =3D tp->packets_out - (tp->sacked_out + tp->lost_o=
ut) + tp->retrans_out;
+	int delta =3D tp->snd_ssthresh - pkts_in_flight;
+
+	if (newly_acked_sacked <=3D 0 || !tp->prior_cwnd)
+		return;
+
+	__u32 prr_delivered =3D tp->prr_delivered + newly_acked_sacked;
+
+	if (delta < 0) {
+		__u64 dividend =3D
+			(__u64)tp->snd_ssthresh * prr_delivered + tp->prior_cwnd - 1;
+		sndcnt =3D (__u32)div64_u64(dividend, (__u64)tp->prior_cwnd) - tp->prr=
_out;
+	} else {
+		sndcnt =3D max(prr_delivered - tp->prr_out, newly_acked_sacked);
+		if (flag & FLAG_SND_UNA_ADVANCED && !newly_lost)
+			sndcnt++;
+		sndcnt =3D min(delta, sndcnt);
+	}
+	/* Force a fast retransmit upon entering fast recovery */
+	sndcnt =3D max(sndcnt, (tp->prr_out ? 0 : 1));
+	tp->snd_cwnd =3D pkts_in_flight + sndcnt;
+}
+
+/* Decide wheather to run the increase function of congestion control. *=
/
+static __always_inline bool tcp_may_raise_cwnd(
+		const struct sock *sk,
+		const int flag) {
+	if (tcp_sk(sk)->reordering > TCP_REORDERING)
+		return flag & FLAG_FORWARD_PROGRESS;
+
+	return flag & FLAG_DATA_ACKED;
+}
+
+void BPF_STRUCT_OPS(bpf_cubic_cong_control, struct sock *sk, __u32 ack, =
int flag,
+		const struct rate_sample *rs)
+{
+	struct tcp_sock *tp =3D tcp_sk(sk);
+
+	if (((1<<TCP_CA_CWR) | (1<<TCP_CA_Recovery)) &
+			(1 << inet_csk(sk)->icsk_ca_state)) {
+		/* Reduce cwnd if state mandates */
+		tcp_cwnd_reduction(sk, rs->acked_sacked, rs->losses, flag);
+
+		if (!before(tp->snd_una, tp->high_seq)) {
+			/* Reset cwnd to ssthresh in CWR or Recovery (unless it's undone) */
+			if (tp->snd_ssthresh < TCP_INFINITE_SSTHRESH &&
+					inet_csk(sk)->icsk_ca_state =3D=3D TCP_CA_CWR) {
+				tp->snd_cwnd =3D tp->snd_ssthresh;
+				tp->snd_cwnd_stamp =3D tcp_jiffies32;
+			}
+		}
+	} else if (tcp_may_raise_cwnd(sk, flag)) {
+		/* Advance cwnd if state allows */
+		cubictcp_cong_avoid(sk, ack, rs->acked_sacked);
+		tp->snd_cwnd_stamp =3D tcp_jiffies32;
+	}
+
+	tcp_update_pacing_rate(sk);
+}
+
+__u32 BPF_STRUCT_OPS(bpf_cubic_recalc_ssthresh, struct sock *sk)
+{
+	return cubictcp_recalc_ssthresh(sk);
+}
+
+void BPF_STRUCT_OPS(bpf_cubic_state, struct sock *sk, __u8 new_state)
+{
+	cubictcp_state(sk, new_state);
+}
+
+void BPF_STRUCT_OPS(bpf_cubic_acked, struct sock *sk,
+		const struct ack_sample *sample)
+{
+	cubictcp_acked(sk, sample);
+}
+
+__u32 BPF_STRUCT_OPS(bpf_cubic_undo_cwnd, struct sock *sk)
+{
+	return tcp_reno_undo_cwnd(sk);
+}
+
+
+SEC(".struct_ops")
+struct tcp_congestion_ops cubic =3D {
+	.init		=3D (void *)bpf_cubic_init,
+	.ssthresh	=3D (void *)bpf_cubic_recalc_ssthresh,
+	.cong_control	=3D (void *)bpf_cubic_cong_control,
+	.set_state	=3D (void *)bpf_cubic_state,
+	.undo_cwnd	=3D (void *)bpf_cubic_undo_cwnd,
+	.cwnd_event	=3D (void *)bpf_cubic_cwnd_event,
+	.pkts_acked     =3D (void *)bpf_cubic_acked,
+	.name		=3D "bpf_cc_cubic",
+};
diff --git a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h b/tools/=
testing/selftests/bpf/progs/bpf_tracing_net.h
index 7001965d1cc3..f9ec630dfcd5 100644
--- a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
+++ b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
@@ -80,6 +80,14 @@
 #define TCP_INFINITE_SSTHRESH	0x7fffffff
 #define TCP_PINGPONG_THRESH	3
=20
+#define FLAG_DATA_ACKED 0x04 /* This ACK acknowledged new data.		*/
+#define FLAG_SYN_ACKED 0x10 /* This ACK acknowledged SYN.		*/
+#define FLAG_DATA_SACKED 0x20 /* New SACK.				*/
+#define FLAG_SND_UNA_ADVANCED \
+	0x400 /* Snd_una was changed (!=3D FLAG_DATA_ACKED) */
+#define FLAG_ACKED (FLAG_DATA_ACKED | FLAG_SYN_ACKED)
+#define FLAG_FORWARD_PROGRESS (FLAG_ACKED | FLAG_DATA_SACKED)
+
 #define fib_nh_dev		nh_common.nhc_dev
 #define fib_nh_gw_family	nh_common.nhc_gw_family
 #define fib_nh_gw6		nh_common.nhc_gw.ipv6
@@ -119,4 +127,6 @@
 #define tw_v6_daddr		__tw_common.skc_v6_daddr
 #define tw_v6_rcv_saddr		__tw_common.skc_v6_rcv_saddr
=20
+#define tcp_jiffies32 ((__u32)bpf_jiffies64())
+
 #endif
--=20
2.43.0


