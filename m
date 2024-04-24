Return-Path: <bpf+bounces-27725-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 921E78B14C3
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 22:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C20F3B2829B
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 20:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61ADC156C53;
	Wed, 24 Apr 2024 20:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="araiJMUD"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA68156674
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 20:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713991068; cv=none; b=nRtkRy0mssB9uzDfY8NTExl5W10rUHeYSyb05naq0ROd2PeVoZVujCfthgeJ4sgSS20Z1bsQtNH6HGFUeimyZcQEWCEeox0VpH6dsHmaeUYBsZa65ueVaqzz6YeYjgzMgKT1GmYlwfVuFpzXP+XEgaPkgVB8j+sZMJvgqROuGDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713991068; c=relaxed/simple;
	bh=QK9UMzy7FXM4EZC+6fiHDSSyZd8qS90Y/4wgyQOoQVA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SSnRTRMHm7LbMDUmFG2XG1AVyhkLj5Ss8HBwEU6SloTR3FLgxKfse91tO9OwT8RY/prJJUlh1hkTwwIdSFUVu+sb+f0OoFTrBy3rnsKpy0mgfRHokI759vXSy0M+9FXe/U7InaaW8TVwS1Tx0fCEpYDCRtN8xlupYEQWsXtcNcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=araiJMUD; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43OJpRSZ000600
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 13:37:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=scIAbCP5Mt2EUNw5+qRbppIK8+St5c+UsSHjwQlHwzs=;
 b=araiJMUDyT2Ixo1mXflA01eKWVebmla5JZglYa78Usfj3wKoQ4ykXsG/KhqWO3e2Mr7V
 MQRoaoI5jVb8o89opAGmQaTiTZ2T+E2G/bR6JtO98iOQsfyqkUQVtr06lfqQYOulLFZI
 fmT+GUdmfzPtRS0Ye9csfY1LqRrsEj5Z5eit9XWr9ahXAvgoB8zl2XgH31QX4GTdq2lt
 fJhdA8wn3SMdvMVFtNiego6aHv35xt6a+QZcTXa1g8+p8Ha48sA9jJu5h3CNwqhMKVbp
 fxRodHAN3Eh3AhrpQ4snGGT5sgcXB5pCbeLbcyBoA6EvajrixKmPgTm4DFMSfGT8yiHD FQ== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3xpsq653tv-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 13:37:46 -0700
Received: from twshared19781.38.frc1.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 20:37:30 +0000
Received: by devvm15954.vll0.facebook.com (Postfix, from userid 420730)
	id 98C4AC26A602; Wed, 24 Apr 2024 13:37:27 -0700 (PDT)
From: Miao Xu <miaxu@meta.com>
To: Eric Dumazet <edumazet@google.com>,
        "David S . Miller"
	<davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>, Martin Lau
	<kafai@meta.com>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, Miao Xu <miaxu@meta.com>
Subject: [PATCH 2/2] [PATCH net-next,2/2] Add test for the use of new args in cong_control
Date: Wed, 24 Apr 2024 13:37:13 -0700
Message-ID: <20240424203713.4003974-2-miaxu@meta.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240424203713.4003974-1-miaxu@meta.com>
References: <20240424203713.4003974-1-miaxu@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: F2WKmA9g966OHhFHbYJLxbUNxoygJ9Qa
X-Proofpoint-GUID: F2WKmA9g966OHhFHbYJLxbUNxoygJ9Qa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_17,2024-04-24_01,2023-05-22_02

This patch adds a selftest to show the usage of the new arguments in
cong_control. For simplicity's sake, the testing example reuses cubic's
kernel functions.

Signed-off-by: Miao Xu <miaxu@meta.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  23 +++
 .../bpf/progs/bpf_cubic_cong_control.c        | 176 ++++++++++++++++++
 2 files changed, 199 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_cubic_cong_cont=
rol.c

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testin=
g/selftests/bpf/bpf_tcp_helpers.h
index 82a7c9de95f9..3115bc80280e 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -21,6 +21,15 @@ BPF_PROG(name, args)
 #endif
=20
 #define tcp_jiffies32 ((__u32)bpf_jiffies64())
+#define TCP_INFINITE_SSTHRESH 0x7fffffff
+
+#define FLAG_DATA_ACKED 0x04 /* This ACK acknowledged new data.		*/
+#define FLAG_SYN_ACKED 0x10 /* This ACK acknowledged SYN.		*/
+#define FLAG_DATA_SACKED 0x20 /* New SACK.				*/
+#define FLAG_SND_UNA_ADVANCED \
+	0x400 /* Snd_una was changed (!=3D FLAG_DATA_ACKED) */
+#define FLAG_ACKED (FLAG_DATA_ACKED | FLAG_SYN_ACKED)
+#define FLAG_FORWARD_PROGRESS (FLAG_ACKED | FLAG_DATA_SACKED)
=20
 struct sock_common {
 	unsigned char	skc_state;
@@ -37,6 +46,7 @@ struct sock {
 	struct sock_common	__sk_common;
 #define sk_state		__sk_common.skc_state
 	unsigned long		sk_pacing_rate;
+	unsigned long		sk_max_pacing_rate;
 	__u32			sk_pacing_status; /* see enum sk_pacing */
 } __attribute__((preserve_access_index));
=20
@@ -86,6 +96,19 @@ struct tcp_sock {
 	__u32	prior_cwnd;
 	__u64	tcp_mstamp;	/* most recent packet received/sent */
 	bool	is_mptcp;
+	__u32	snd_cwnd_stamp;
+	__u32	mss_cache;	/* Cached effective mss, not including SACKS */
+	__u32	high_seq;	/* snd_nxt at onset of congestion	*/
+	__u32	packets_out;	/* Packets which are "in flight"	*/
+	__u32	srtt_us;	/* smoothed round trip time << 3 in usecs */
+	__u32	retrans_out;	/* Retransmitted packets out */
+	__u32	lost_out;	/* Lost packets */
+	__u32	sacked_out;	/* SACK'd packets */
+	__u32	prr_delivered;	/* Number of newly delivered packets to
+				 * receiver in Recovery.
+				 */
+	__u32	prr_out;	/* Total number of pkts sent during Recovery. */
+	__u32	reordering;	/* Packet reordering metric. */
 } __attribute__((preserve_access_index));
=20
 static __always_inline struct inet_connection_sock *inet_csk(const struc=
t sock *sk)
diff --git a/tools/testing/selftests/bpf/progs/bpf_cubic_cong_control.c b=
/tools/testing/selftests/bpf/progs/bpf_cubic_cong_control.c
new file mode 100644
index 000000000000..698964df1f33
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_cubic_cong_control.c
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/* WARNING: This implementation is NOT the same as the tcp_cubic.c.
+ * The purpose is mainly to show use cases of the new arguments in
+ * cong_control.
+ */
+
+#include <linux/bpf.h>
+#include <linux/stddef.h>
+#include <linux/tcp.h>
+#include "bpf_tcp_helpers.h"
+
+char _license[] SEC("license") =3D "GPL";
+
+extern void cubictcp_init(struct sock *sk) __ksym;
+extern void cubictcp_cwnd_event(struct sock *sk, enum tcp_ca_event event=
)
+	__ksym;
+	extern __u32 cubictcp_recalc_ssthresh(struct sock *sk) __ksym;
+	extern void cubictcp_state(struct sock *sk, __u8 new_state) __ksym;
+	extern __u32 tcp_reno_undo_cwnd(struct sock *sk) __ksym;
+extern void cubictcp_acked(struct sock *sk, const struct ack_sample *sam=
ple)
+	__ksym;
+	extern void cubictcp_cong_avoid(struct sock *sk, __u32 ack, __u32 acked=
) __ksym;
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
+static void tcp_update_pacing_rate(struct sock *sk)
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
+	sk->sk_pacing_rate =3D min(rate, (__u64)sk->sk_max_pacing_rate);
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
--=20
2.43.0


