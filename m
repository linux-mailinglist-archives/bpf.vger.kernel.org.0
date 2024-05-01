Return-Path: <bpf+bounces-28322-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC478B8639
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 09:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F0831C21310
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 07:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269944D9F2;
	Wed,  1 May 2024 07:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="nyGLb6cT"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33D14CDE0
	for <bpf@vger.kernel.org>; Wed,  1 May 2024 07:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714549456; cv=none; b=LuXMs2Nv7JwaIAKNtthxTcP/pZMa1WdrEGhtuzu7Ntpr3BJ9V+ckeBO81AZinLXjNRht5ilM8L1ZWEgeMlNgKSV9Oqn9DRsKSXlHsI99tIEljEJUuUIRqe5hathR/81KRW2s4pT0C5od0sMldY0N3NwhuOJ9AzX0vgjmdo0RmOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714549456; c=relaxed/simple;
	bh=md6jVbAS5qS0rwyKif0UFiJ92p+UOungs2JrhrKKl4E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DiFrJ5kqAvn0JgoVENc850Y/nMepJTudVD1psJof4Et3tnEeFvK7lqv6wbxscjp3J/ZTaWFHLQYUvePx2Xm/dTHMoxqGJDwipyJlJO/FzboDSa98aOiKKUlDBKimrtmv2Anrek9ODAwlsmkoE1CC02Zgc2DsK5OK9IXauKKYX0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=nyGLb6cT; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44101Kbw002498
	for <bpf@vger.kernel.org>; Wed, 1 May 2024 00:44:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=4lF8F4Lq71XKAlTdvWul2zbc0f5YYEDVLLeJgnkIzrg=;
 b=nyGLb6cT24nIXN0FCGkKfhn1Jdy11hdM1MdhYbsPCKMZkhN/aCgUYVttZdc29eJvgsLd
 VUSLDaUC+BVUqhZLrcoDfJclzrBFsQztc4mfWAoFFNAnU9E5UkIJcqQiR+RVA5+NHMn+
 o172uECYF8eI+yK9zZaIniHaxJwGaFdyZwKbApU6u/j6uvkHx4KmpWE9I1/UsdnZ8Bls
 TO1i6313sTfpcg7pNBRAmvH/a2hlxWsDK2ArGWLnEtLfDDtGizfj1uVUW0GVMg/zYHTz
 UDTVjEUxHGNEPWkY0PvQ58DOR2QNrPnHzpT5qv19kVa+mLoZEHVGLb6qTdPWjKvw0kme Og== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3xtxh3dube-15
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 01 May 2024 00:44:13 -0700
Received: from twshared12096.14.prn3.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 1 May 2024 07:44:11 +0000
Received: by devvm15954.vll0.facebook.com (Postfix, from userid 420730)
	id 49C06CA32C04; Wed,  1 May 2024 00:44:06 -0700 (PDT)
From: Miao Xu <miaxu@meta.com>
To: Eric Dumazet <edumazet@google.com>,
        "David S . Miller"
	<davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>, Martin Lau
	<kafai@meta.com>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, Miao Xu <miaxu@meta.com>
Subject: [PATCH net-next v2 3/3] Add test for the use of new args in cong_control
Date: Wed, 1 May 2024 00:43:38 -0700
Message-ID: <20240501074338.362361-3-miaxu@meta.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240501074338.362361-1-miaxu@meta.com>
References: <20240501074338.362361-1-miaxu@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 8KuE1zeeV5SiLX43I4EflFNVd0xDNP82
X-Proofpoint-ORIG-GUID: 8KuE1zeeV5SiLX43I4EflFNVd0xDNP82
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_06,2024-04-30_01,2023-05-22_02

This patch adds a selftest to show the usage of the new arguments in
cong_control. For simplicity's sake, the testing example reuses cubic's
kernel functions.
--
Changes in v2:
* Added highlights to explain major differences between the bpf program
and tcp_cubic.c.
* bpf_tcp_helpers.h should not be further extended, so remove the
  dependency on this file. Use vmlinux.h instead.
* Minor changes such as indentation.

Signed-off-by: Miao Xu <miaxu@meta.com>
---
 .../bpf/progs/bpf_cubic_cong_control.c        | 207 ++++++++++++++++++
 .../selftests/bpf/progs/bpf_tracing_net.h     |  10 +
 2 files changed, 217 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_cubic_cong_cont=
rol.c

diff --git a/tools/testing/selftests/bpf/progs/bpf_cubic_cong_control.c b=
/tools/testing/selftests/bpf/progs/bpf_cubic_cong_control.c
new file mode 100644
index 000000000000..7ec9da0356c3
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_cubic_cong_control.c
@@ -0,0 +1,207 @@
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
+			// __cwnd_event(sk, CA_EVENT_COMPLETE_CWR);
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
+	.name		=3D "bpf_cubic",
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


