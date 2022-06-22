Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9587C555303
	for <lists+bpf@lfdr.de>; Wed, 22 Jun 2022 20:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377046AbiFVSKq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Jun 2022 14:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377166AbiFVSKp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Jun 2022 14:10:45 -0400
Received: from mailrelay.tu-berlin.de (mailrelay.tu-berlin.de [130.149.7.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E4E3B031
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 11:10:40 -0700 (PDT)
Received: from SPMA-03.tubit.win.tu-berlin.de (localhost.localdomain [127.0.0.1])
        by localhost (Email Security Appliance) with SMTP id 49A206E5BA_2B35B1EB;
        Wed, 22 Jun 2022 18:10:38 +0000 (GMT)
Received: from mail.tu-berlin.de (bulkmail.tu-berlin.de [141.23.12.143])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "exchange.tu-berlin.de", Issuer "DFN-Verein Global Issuing CA" (verified OK))
        by SPMA-03.tubit.win.tu-berlin.de (Sophos Email Appliance) with ESMTPS id 91FCA72BAF_2B35B1CF;
        Wed, 22 Jun 2022 18:10:36 +0000 (GMT)
Received: from jt.fritz.box (77.191.241.175) by ex-03.svc.tu-berlin.de
 (10.150.18.7) with Microsoft SMTP Server id 15.2.986.22; Wed, 22 Jun 2022
 20:10:36 +0200
From:   =?UTF-8?q?J=C3=B6rn-Thorben=20Hinz?= <jthinz@mailbox.tu-berlin.de>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, Martin KaFai Lau <kafai@fb.com>,
        =?UTF-8?q?J=C3=B6rn-Thorben=20Hinz?= <jthinz@mailbox.tu-berlin.de>
Subject: [PATCH bpf-next] selftests/bpf: Use bpf_tcp_helpers.h together with vmlinux.h
Date:   Wed, 22 Jun 2022 20:10:15 +0200
Message-ID: <20220622181015.892445-1-jthinz@mailbox.tu-berlin.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-SASI-RCODE: 200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=campus.tu-berlin.de; h=from:to:cc:subject:date:message-id:mime-version:content-type:content-transfer-encoding; s=dkim-tub; bh=kl16W4xTHZOFXTto6N3xn3BRxArMXN7VHska0ODq+2g=; b=RIJ6HrlM1pp9BTNFTFclA1o0Otxgi2rrvyBUCLkcUpilfXXhgXbKU+AKeTudUS0P05tpmaLGqne2BfJtu6/kv/IXJ1m/bQwQZtGbkycOaD8ezxv4fK8e3G6B4Q1VjMEkFzO0If84Q/DAbNdMMDI2aTZGA4HSV1QwzigXs1ibee8=
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello there,

I’m looking for and happy about feedback with this. This patch enables
the usage of bpf_tcp_helpers.h together with vmlinux.h, as briefly
discussed here[1].


There is currently one failing prog test with this patch: sock_fields.
After including vmlinux.h there (for struct tcp_sock), it fails on
skeleton-load in egress_read_sock_fields(), when calling is_loopback6(),
with:

	; return !a6[0] && !a6[1] && !a6[2] && a6[3] == bpf_htonl(1);
	22: (56) if w2 != 0x0 goto pc-6       ; R2_w=P0
	23: (b7) r3 = 28                      ; R3_w=P28
	24: (bf) r2 = r1                      ; R1_w=sock_common(off=0,imm=0) R2_w=sock_common(off=0,imm=0)
	25: (0f) r2 += r3
	R2 pointer arithmetic on sock_common prohibited

Seems to happen with Clang 13, 14 and trunk (ff5301dde981) and
kernel/bpf-next at d4609a5d8c70 so far. The instructions generated for
is_loopback6() are actually different here after switching to vmlinux.h.
I’m unsure why this is happening—maybe even a Clang bug?


[1] https://lore.kernel.org/bpf/20220614104452.3370148-4-jthinz@mailbox.tu-berlin.de/


Commit description:

Remove type declarations from bpf_tcp_helpers.h. Modify files using this
header accordingly and provide defines that where previously available
from the UAPI headers.

Also, include bpf_tracing.h or bpf_tracing_net.h instead of
bpf_tcp_helpers.h where those are more appropriate.

bpf_tcp_helpers.h moves to progs/, the same place as other headers to be
included by BPF programs but not by userspace programs.

Signed-off-by: Jörn-Thorben Hinz <jthinz@mailbox.tu-berlin.de>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h | 241 ------------------
 tools/testing/selftests/bpf/progs/bpf_cubic.c |   8 +-
 tools/testing/selftests/bpf/progs/bpf_dctcp.c |   7 +-
 .../selftests/bpf/progs/bpf_dctcp_release.c   |   8 +-
 .../selftests/bpf/progs/bpf_tc_helpers.h      |   7 +
 .../selftests/bpf/progs/bpf_tcp_helpers.h     |  85 ++++++
 .../selftests/bpf/progs/bpf_tcp_nogpl.c       |   4 +-
 .../selftests/bpf/progs/bpf_tracing_net.h     |   8 +
 .../bpf/progs/kfunc_call_test_subprog.c       |   4 +-
 .../testing/selftests/bpf/progs/mptcp_sock.c  |   6 +-
 .../selftests/bpf/progs/sockopt_qos_to_cc.c   |   6 +-
 .../bpf/progs/test_btf_skc_cls_ingress.c      |  14 +-
 .../selftests/bpf/progs/test_sock_fields.c    |   6 +-
 .../selftests/bpf/progs/test_tcpbpf_kern.c    |  23 +-
 tools/testing/selftests/bpf/progs/timer.c     |   2 +-
 tools/testing/selftests/bpf/progs/timer_mim.c |   2 +-
 .../selftests/bpf/progs/timer_mim_reject.c    |   2 +-
 17 files changed, 130 insertions(+), 303 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/bpf_tcp_helpers.h
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_tc_helpers.h
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_tcp_helpers.h

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
deleted file mode 100644
index 82a7c9de95f9..000000000000
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ /dev/null
@@ -1,241 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __BPF_TCP_HELPERS_H
-#define __BPF_TCP_HELPERS_H
-
-#include <stdbool.h>
-#include <linux/types.h>
-#include <bpf/bpf_helpers.h>
-#include <bpf/bpf_core_read.h>
-#include <bpf/bpf_tracing.h>
-
-#define BPF_STRUCT_OPS(name, args...) \
-SEC("struct_ops/"#name) \
-BPF_PROG(name, args)
-
-#ifndef SOL_TCP
-#define SOL_TCP 6
-#endif
-
-#ifndef TCP_CA_NAME_MAX
-#define TCP_CA_NAME_MAX	16
-#endif
-
-#define tcp_jiffies32 ((__u32)bpf_jiffies64())
-
-struct sock_common {
-	unsigned char	skc_state;
-	__u16		skc_num;
-} __attribute__((preserve_access_index));
-
-enum sk_pacing {
-	SK_PACING_NONE		= 0,
-	SK_PACING_NEEDED	= 1,
-	SK_PACING_FQ		= 2,
-};
-
-struct sock {
-	struct sock_common	__sk_common;
-#define sk_state		__sk_common.skc_state
-	unsigned long		sk_pacing_rate;
-	__u32			sk_pacing_status; /* see enum sk_pacing */
-} __attribute__((preserve_access_index));
-
-struct inet_sock {
-	struct sock		sk;
-} __attribute__((preserve_access_index));
-
-struct inet_connection_sock {
-	struct inet_sock	  icsk_inet;
-	__u8			  icsk_ca_state:6,
-				  icsk_ca_setsockopt:1,
-				  icsk_ca_dst_locked:1;
-	struct {
-		__u8		  pending;
-	} icsk_ack;
-	__u64			  icsk_ca_priv[104 / sizeof(__u64)];
-} __attribute__((preserve_access_index));
-
-struct request_sock {
-	struct sock_common		__req_common;
-} __attribute__((preserve_access_index));
-
-struct tcp_sock {
-	struct inet_connection_sock	inet_conn;
-
-	__u32	rcv_nxt;
-	__u32	snd_nxt;
-	__u32	snd_una;
-	__u32	window_clamp;
-	__u8	ecn_flags;
-	__u32	delivered;
-	__u32	delivered_ce;
-	__u32	snd_cwnd;
-	__u32	snd_cwnd_cnt;
-	__u32	snd_cwnd_clamp;
-	__u32	snd_ssthresh;
-	__u8	syn_data:1,	/* SYN includes data */
-		syn_fastopen:1,	/* SYN includes Fast Open option */
-		syn_fastopen_exp:1,/* SYN includes Fast Open exp. option */
-		syn_fastopen_ch:1, /* Active TFO re-enabling probe */
-		syn_data_acked:1,/* data in SYN is acked by SYN-ACK */
-		save_syn:1,	/* Save headers of SYN packet */
-		is_cwnd_limited:1,/* forward progress limited by snd_cwnd? */
-		syn_smc:1;	/* SYN includes SMC */
-	__u32	max_packets_out;
-	__u32	lsndtime;
-	__u32	prior_cwnd;
-	__u64	tcp_mstamp;	/* most recent packet received/sent */
-	bool	is_mptcp;
-} __attribute__((preserve_access_index));
-
-static __always_inline struct inet_connection_sock *inet_csk(const struct sock *sk)
-{
-	return (struct inet_connection_sock *)sk;
-}
-
-static __always_inline void *inet_csk_ca(const struct sock *sk)
-{
-	return (void *)inet_csk(sk)->icsk_ca_priv;
-}
-
-static __always_inline struct tcp_sock *tcp_sk(const struct sock *sk)
-{
-	return (struct tcp_sock *)sk;
-}
-
-static __always_inline bool before(__u32 seq1, __u32 seq2)
-{
-	return (__s32)(seq1-seq2) < 0;
-}
-#define after(seq2, seq1) 	before(seq1, seq2)
-
-#define	TCP_ECN_OK		1
-#define	TCP_ECN_QUEUE_CWR	2
-#define	TCP_ECN_DEMAND_CWR	4
-#define	TCP_ECN_SEEN		8
-
-enum inet_csk_ack_state_t {
-	ICSK_ACK_SCHED	= 1,
-	ICSK_ACK_TIMER  = 2,
-	ICSK_ACK_PUSHED = 4,
-	ICSK_ACK_PUSHED2 = 8,
-	ICSK_ACK_NOW = 16	/* Send the next ACK immediately (once) */
-};
-
-enum tcp_ca_event {
-	CA_EVENT_TX_START = 0,
-	CA_EVENT_CWND_RESTART = 1,
-	CA_EVENT_COMPLETE_CWR = 2,
-	CA_EVENT_LOSS = 3,
-	CA_EVENT_ECN_NO_CE = 4,
-	CA_EVENT_ECN_IS_CE = 5,
-};
-
-struct ack_sample {
-	__u32 pkts_acked;
-	__s32 rtt_us;
-	__u32 in_flight;
-} __attribute__((preserve_access_index));
-
-struct rate_sample {
-	__u64  prior_mstamp; /* starting timestamp for interval */
-	__u32  prior_delivered;	/* tp->delivered at "prior_mstamp" */
-	__s32  delivered;		/* number of packets delivered over interval */
-	long interval_us;	/* time for tp->delivered to incr "delivered" */
-	__u32 snd_interval_us;	/* snd interval for delivered packets */
-	__u32 rcv_interval_us;	/* rcv interval for delivered packets */
-	long rtt_us;		/* RTT of last (S)ACKed packet (or -1) */
-	int  losses;		/* number of packets marked lost upon ACK */
-	__u32  acked_sacked;	/* number of packets newly (S)ACKed upon ACK */
-	__u32  prior_in_flight;	/* in flight before this ACK */
-	bool is_app_limited;	/* is sample from packet with bubble in pipe? */
-	bool is_retrans;	/* is sample from retransmission? */
-	bool is_ack_delayed;	/* is this (likely) a delayed ACK? */
-} __attribute__((preserve_access_index));
-
-#define TCP_CA_NAME_MAX		16
-#define TCP_CONG_NEEDS_ECN	0x2
-
-struct tcp_congestion_ops {
-	char name[TCP_CA_NAME_MAX];
-	__u32 flags;
-
-	/* initialize private data (optional) */
-	void (*init)(struct sock *sk);
-	/* cleanup private data  (optional) */
-	void (*release)(struct sock *sk);
-
-	/* return slow start threshold (required) */
-	__u32 (*ssthresh)(struct sock *sk);
-	/* do new cwnd calculation (required) */
-	void (*cong_avoid)(struct sock *sk, __u32 ack, __u32 acked);
-	/* call before changing ca_state (optional) */
-	void (*set_state)(struct sock *sk, __u8 new_state);
-	/* call when cwnd event occurs (optional) */
-	void (*cwnd_event)(struct sock *sk, enum tcp_ca_event ev);
-	/* call when ack arrives (optional) */
-	void (*in_ack_event)(struct sock *sk, __u32 flags);
-	/* new value of cwnd after loss (required) */
-	__u32  (*undo_cwnd)(struct sock *sk);
-	/* hook for packet ack accounting (optional) */
-	void (*pkts_acked)(struct sock *sk, const struct ack_sample *sample);
-	/* override sysctl_tcp_min_tso_segs */
-	__u32 (*min_tso_segs)(struct sock *sk);
-	/* returns the multiplier used in tcp_sndbuf_expand (optional) */
-	__u32 (*sndbuf_expand)(struct sock *sk);
-	/* call when packets are delivered to update cwnd and pacing rate,
-	 * after all the ca_state processing. (optional)
-	 */
-	void (*cong_control)(struct sock *sk, const struct rate_sample *rs);
-	void *owner;
-};
-
-#define min(a, b) ((a) < (b) ? (a) : (b))
-#define max(a, b) ((a) > (b) ? (a) : (b))
-#define min_not_zero(x, y) ({			\
-	typeof(x) __x = (x);			\
-	typeof(y) __y = (y);			\
-	__x == 0 ? __y : ((__y == 0) ? __x : min(__x, __y)); })
-
-static __always_inline bool tcp_in_slow_start(const struct tcp_sock *tp)
-{
-	return tp->snd_cwnd < tp->snd_ssthresh;
-}
-
-static __always_inline bool tcp_is_cwnd_limited(const struct sock *sk)
-{
-	const struct tcp_sock *tp = tcp_sk(sk);
-
-	/* If in slow start, ensure cwnd grows to twice what was ACKed. */
-	if (tcp_in_slow_start(tp))
-		return tp->snd_cwnd < 2 * tp->max_packets_out;
-
-	return !!BPF_CORE_READ_BITFIELD(tp, is_cwnd_limited);
-}
-
-static __always_inline bool tcp_cc_eq(const char *a, const char *b)
-{
-	int i;
-
-	for (i = 0; i < TCP_CA_NAME_MAX; i++) {
-		if (a[i] != b[i])
-			return false;
-		if (!a[i])
-			break;
-	}
-
-	return true;
-}
-
-extern __u32 tcp_slow_start(struct tcp_sock *tp, __u32 acked) __ksym;
-extern void tcp_cong_avoid_ai(struct tcp_sock *tp, __u32 w, __u32 acked) __ksym;
-
-struct mptcp_sock {
-	struct inet_connection_sock	sk;
-
-	__u32		token;
-	struct sock	*first;
-	char		ca_name[TCP_CA_NAME_MAX];
-} __attribute__((preserve_access_index));
-
-#endif
diff --git a/tools/testing/selftests/bpf/progs/bpf_cubic.c b/tools/testing/selftests/bpf/progs/bpf_cubic.c
index d9660e7200e2..b6cb0a651a0a 100644
--- a/tools/testing/selftests/bpf/progs/bpf_cubic.c
+++ b/tools/testing/selftests/bpf/progs/bpf_cubic.c
@@ -14,9 +14,11 @@
  *    "ca->ack_cnt / delta" operation.
  */
 
-#include <linux/bpf.h>
-#include <linux/stddef.h>
-#include <linux/tcp.h>
+#define bictcp bictcp___not_used
+#include "vmlinux.h"
+#undef bictcp
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
 #include "bpf_tcp_helpers.h"
 
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/bpf_dctcp.c b/tools/testing/selftests/bpf/progs/bpf_dctcp.c
index 9573be6122be..71cbe779f578 100644
--- a/tools/testing/selftests/bpf/progs/bpf_dctcp.c
+++ b/tools/testing/selftests/bpf/progs/bpf_dctcp.c
@@ -6,14 +6,11 @@
  * the kernel BPF logic.
  */
 
-#include <stddef.h>
-#include <linux/bpf.h>
-#include <linux/types.h>
-#include <linux/stddef.h>
-#include <linux/tcp.h>
+#include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include "bpf_tcp_helpers.h"
+#include "bpf_tracing_net.h"
 
 char _license[] SEC("license") = "GPL";
 
diff --git a/tools/testing/selftests/bpf/progs/bpf_dctcp_release.c b/tools/testing/selftests/bpf/progs/bpf_dctcp_release.c
index d836f7c372f0..8785ec85c1fe 100644
--- a/tools/testing/selftests/bpf/progs/bpf_dctcp_release.c
+++ b/tools/testing/selftests/bpf/progs/bpf_dctcp_release.c
@@ -1,14 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2021 Facebook */
 
-#include <stddef.h>
-#include <linux/bpf.h>
-#include <linux/types.h>
-#include <linux/stddef.h>
-#include <linux/tcp.h>
+#include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
-#include <bpf/bpf_tracing.h>
 #include "bpf_tcp_helpers.h"
+#include "bpf_tracing_net.h"
 
 char _license[] SEC("license") = "GPL";
 const char cubic[] = "cubic";
diff --git a/tools/testing/selftests/bpf/progs/bpf_tc_helpers.h b/tools/testing/selftests/bpf/progs/bpf_tc_helpers.h
new file mode 100644
index 000000000000..fef72cba6298
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_tc_helpers.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __BPF_TC_HELPERS_H
+#define __BPF_TC_HELPERS_H
+
+#define TC_ACT_OK		0
+
+#endif
diff --git a/tools/testing/selftests/bpf/progs/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/progs/bpf_tcp_helpers.h
new file mode 100644
index 000000000000..a8659fed2c18
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_tcp_helpers.h
@@ -0,0 +1,85 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __BPF_TCP_HELPERS_H
+#define __BPF_TCP_HELPERS_H
+
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+#include <bpf/bpf_tracing.h>
+
+#include "bpf_tracing_net.h"
+
+#define BPF_STRUCT_OPS(name, args...) \
+SEC("struct_ops/"#name) \
+BPF_PROG(name, args)
+
+#define tcp_jiffies32 ((__u32)bpf_jiffies64())
+
+static __always_inline struct inet_connection_sock *inet_csk(const struct sock *sk)
+{
+	return (struct inet_connection_sock *)sk;
+}
+
+static __always_inline void *inet_csk_ca(const struct sock *sk)
+{
+	return (void *)inet_csk(sk)->icsk_ca_priv;
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
+#define after(seq2, seq1) 	before(seq1, seq2)
+
+#define	TCP_ECN_OK		1
+#define	TCP_ECN_QUEUE_CWR	2
+#define	TCP_ECN_DEMAND_CWR	4
+#define	TCP_ECN_SEEN		8
+
+#define TCP_CONG_NEEDS_ECN	0x2
+
+#define min(a, b) ((a) < (b) ? (a) : (b))
+#define max(a, b) ((a) > (b) ? (a) : (b))
+#define min_not_zero(x, y) ({			\
+	typeof(x) __x = (x);			\
+	typeof(y) __y = (y);			\
+	__x == 0 ? __y : ((__y == 0) ? __x : min(__x, __y)); })
+
+static __always_inline bool tcp_in_slow_start(const struct tcp_sock *tp)
+{
+	return tp->snd_cwnd < tp->snd_ssthresh;
+}
+
+static __always_inline bool tcp_is_cwnd_limited(const struct sock *sk)
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
+static __always_inline bool tcp_cc_eq(const char *a, const char *b)
+{
+	int i;
+
+	for (i = 0; i < TCP_CA_NAME_MAX; i++) {
+		if (a[i] != b[i])
+			return false;
+		if (!a[i])
+			break;
+	}
+
+	return true;
+}
+
+extern __u32 tcp_slow_start(struct tcp_sock *tp, __u32 acked) __ksym;
+extern void tcp_cong_avoid_ai(struct tcp_sock *tp, __u32 w, __u32 acked) __ksym;
+
+#endif
diff --git a/tools/testing/selftests/bpf/progs/bpf_tcp_nogpl.c b/tools/testing/selftests/bpf/progs/bpf_tcp_nogpl.c
index 2ecd833dcd41..2db3b6816e0f 100644
--- a/tools/testing/selftests/bpf/progs/bpf_tcp_nogpl.c
+++ b/tools/testing/selftests/bpf/progs/bpf_tcp_nogpl.c
@@ -1,9 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#include <linux/bpf.h>
-#include <linux/types.h>
+#include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
-#include <bpf/bpf_tracing.h>
 #include "bpf_tcp_helpers.h"
 
 char _license[] SEC("license") = "X";
diff --git a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
index 1c1289ba5fc5..f06410392efc 100644
--- a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
+++ b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
@@ -2,16 +2,24 @@
 #ifndef __BPF_TRACING_NET_H__
 #define __BPF_TRACING_NET_H__
 
+#define ETH_P_IPV6	0x86DD
+
 #define AF_INET			2
 #define AF_INET6		10
 
+#define SOL_IPV6	41
+#define IPV6_TCLASS		67
+
 #define SOL_SOCKET		1
 #define SO_SNDBUF		7
 #define __SO_ACCEPTCON		(1 << 16)
 
 #define SOL_TCP			6
+#define TCP_WINDOW_CLAMP	10
 #define TCP_CONGESTION		13
 #define TCP_CA_NAME_MAX		16
+#define TCP_SAVE_SYN		27
+#define TCP_SAVED_SYN		28
 
 #define ICSK_TIME_RETRANS	1
 #define ICSK_TIME_PROBE0	3
diff --git a/tools/testing/selftests/bpf/progs/kfunc_call_test_subprog.c b/tools/testing/selftests/bpf/progs/kfunc_call_test_subprog.c
index c1fdecabeabf..18a9ec639807 100644
--- a/tools/testing/selftests/bpf/progs/kfunc_call_test_subprog.c
+++ b/tools/testing/selftests/bpf/progs/kfunc_call_test_subprog.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2021 Facebook */
-#include <linux/bpf.h>
+#include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
-#include "bpf_tcp_helpers.h"
+#include "bpf_tracing_net.h"
 
 extern const int bpf_prog_active __ksym;
 extern __u64 bpf_kfunc_call_test1(struct sock *sk, __u32 a, __u64 b,
diff --git a/tools/testing/selftests/bpf/progs/mptcp_sock.c b/tools/testing/selftests/bpf/progs/mptcp_sock.c
index 91a0d7eff2ac..da91fb8a6620 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_sock.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_sock.c
@@ -2,9 +2,11 @@
 /* Copyright (c) 2020, Tessares SA. */
 /* Copyright (c) 2022, SUSE. */
 
-#include <linux/bpf.h>
+#include "vmlinux.h"
+#include <bpf/bpf_core_read.h>
 #include <bpf/bpf_helpers.h>
-#include "bpf_tcp_helpers.h"
+#include <bpf/bpf_tracing.h>
+#include "bpf_tracing_net.h"
 
 char _license[] SEC("license") = "GPL";
 __u32 token = 0;
diff --git a/tools/testing/selftests/bpf/progs/sockopt_qos_to_cc.c b/tools/testing/selftests/bpf/progs/sockopt_qos_to_cc.c
index 1bce83b6e3a7..bc50dc5da837 100644
--- a/tools/testing/selftests/bpf/progs/sockopt_qos_to_cc.c
+++ b/tools/testing/selftests/bpf/progs/sockopt_qos_to_cc.c
@@ -1,11 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2021 Facebook */
-#include <string.h>
-#include <linux/tcp.h>
-#include <netinet/in.h>
-#include <linux/bpf.h>
+#include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
 #include "bpf_tcp_helpers.h"
+#include "bpf_tracing_net.h"
 
 char _license[] SEC("license") = "GPL";
 
diff --git a/tools/testing/selftests/bpf/progs/test_btf_skc_cls_ingress.c b/tools/testing/selftests/bpf/progs/test_btf_skc_cls_ingress.c
index e2bea4da194b..72c20d40468b 100644
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
+#include "vmlinux.h"
 
+#include <errno.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
-#include "bpf_tcp_helpers.h"
+#include "bpf_tc_helpers.h"
+#include "bpf_tracing_net.h"
 
 struct sockaddr_in6 srv_sa6 = {};
 __u16 listen_tp_sport = 0;
diff --git a/tools/testing/selftests/bpf/progs/test_sock_fields.c b/tools/testing/selftests/bpf/progs/test_sock_fields.c
index 9f4b8f9f1181..d9ee861061aa 100644
--- a/tools/testing/selftests/bpf/progs/test_sock_fields.c
+++ b/tools/testing/selftests/bpf/progs/test_sock_fields.c
@@ -1,13 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2019 Facebook */
 
-#include <linux/bpf.h>
-#include <netinet/in.h>
-#include <stdbool.h>
+#include "vmlinux.h"
 
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
-#include "bpf_tcp_helpers.h"
+#include "bpf_tracing_net.h"
 
 enum bpf_linum_array_idx {
 	EGRESS_LINUM_IDX,
diff --git a/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c b/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c
index 3ded05280757..5315a1ec06a2 100644
--- a/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c
@@ -1,30 +1,13 @@
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
+#include "vmlinux.h"
+
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
-#include "bpf_tcp_helpers.h"
+#include "bpf_tracing_net.h"
 #include "test_tcpbpf.h"
 
 struct tcpbpf_globals global = {};
 
-/**
- * SOL_TCP is defined in <netinet/tcp.h> while
- * TCP_SAVED_SYN is defined in already included <linux/tcp.h>
- */
-#ifndef SOL_TCP
-#define SOL_TCP 6
-#endif
-
 static __always_inline int get_tp_window_clamp(struct bpf_sock_ops *skops)
 {
 	struct bpf_sock *sk;
diff --git a/tools/testing/selftests/bpf/progs/timer.c b/tools/testing/selftests/bpf/progs/timer.c
index 5f5309791649..c2aa74aef4e0 100644
--- a/tools/testing/selftests/bpf/progs/timer.c
+++ b/tools/testing/selftests/bpf/progs/timer.c
@@ -4,7 +4,7 @@
 #include <time.h>
 #include <errno.h>
 #include <bpf/bpf_helpers.h>
-#include "bpf_tcp_helpers.h"
+#include <bpf/bpf_tracing.h>
 
 char _license[] SEC("license") = "GPL";
 struct hmap_elem {
diff --git a/tools/testing/selftests/bpf/progs/timer_mim.c b/tools/testing/selftests/bpf/progs/timer_mim.c
index 2fee7ab105ef..50ebc3f68522 100644
--- a/tools/testing/selftests/bpf/progs/timer_mim.c
+++ b/tools/testing/selftests/bpf/progs/timer_mim.c
@@ -4,7 +4,7 @@
 #include <time.h>
 #include <errno.h>
 #include <bpf/bpf_helpers.h>
-#include "bpf_tcp_helpers.h"
+#include <bpf/bpf_tracing.h>
 
 char _license[] SEC("license") = "GPL";
 struct hmap_elem {
diff --git a/tools/testing/selftests/bpf/progs/timer_mim_reject.c b/tools/testing/selftests/bpf/progs/timer_mim_reject.c
index 5d648e3d8a41..dd3f1ed6d6e6 100644
--- a/tools/testing/selftests/bpf/progs/timer_mim_reject.c
+++ b/tools/testing/selftests/bpf/progs/timer_mim_reject.c
@@ -4,7 +4,7 @@
 #include <time.h>
 #include <errno.h>
 #include <bpf/bpf_helpers.h>
-#include "bpf_tcp_helpers.h"
+#include <bpf/bpf_tracing.h>
 
 char _license[] SEC("license") = "GPL";
 struct hmap_elem {
-- 
2.30.2

