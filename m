Return-Path: <bpf+bounces-12194-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 993BC7C9016
	for <lists+bpf@lfdr.de>; Sat, 14 Oct 2023 00:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC8A41C2129F
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 22:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2406B2B5F6;
	Fri, 13 Oct 2023 22:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ZIPYHLcG"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D733428E14;
	Fri, 13 Oct 2023 22:09:30 +0000 (UTC)
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558C8B7;
	Fri, 13 Oct 2023 15:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1697234970; x=1728770970;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tvNQKjIkt6orEEZPCXRfskH3QaTC6APkpBykP3iI3RI=;
  b=ZIPYHLcGo0ZQ8Qd63Y8Zr8FIjBXQfTemPAQHszKNgspS0d2tezLKE3QV
   VlLn0ptAIrad8CU9lY/KuwysxmCqM7a/mIS/t8mCdkDCIzzzW/Mzil1DH
   b205l10NrnDKQPh6iTbIMv0+5yQ12wKA6LkNkbL7t6kHWWkGbbD1BHamg
   I=;
X-IronPort-AV: E=Sophos;i="6.03,223,1694736000"; 
   d="scan'208";a="159967486"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-b538c141.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 22:09:28 +0000
Received: from EX19MTAUWB002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
	by email-inbound-relay-iad-1e-m6i4x-b538c141.us-east-1.amazon.com (Postfix) with ESMTPS id D57B0A0E1F;
	Fri, 13 Oct 2023 22:09:22 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Fri, 13 Oct 2023 22:09:22 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.170.60) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Fri, 13 Oct 2023 22:09:18 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
	<andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
	<song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
	<john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH v1 bpf-next 10/11] bpf: tcp: Make WS, SACK, ECN configurable from BPF SYN Cookie.
Date: Fri, 13 Oct 2023 15:04:32 -0700
Message-ID: <20231013220433.70792-11-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231013220433.70792-1-kuniyu@amazon.com>
References: <20231013220433.70792-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.170.60]
X-ClientProxiedBy: EX19D041UWB002.ant.amazon.com (10.13.139.179) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch allows BPF_SOCK_OPS_CHECK_SYNCOOKIE_CB hook to enable WScale,
SACK, and ECN by passing corresponding flags to bpf_sock_ops.replylong[1].

The same flags are passed to BPF_SOCK_OPS_GEN_SYNCOOKIE_CB hook as
bpf_sock_ops.args[1] so that the BPF prog need not parse the TCP header to
check if WScale, SACK, ECN, and TS are available in SYN.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/uapi/linux/bpf.h       | 18 ++++++++++++++++++
 net/ipv4/syncookies.c          | 20 ++++++++++++++++++++
 net/ipv4/tcp_input.c           | 11 +++++++++++
 tools/include/uapi/linux/bpf.h | 18 ++++++++++++++++++
 4 files changed, 67 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 24f673d88c0d..cdae4dd5d797 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6869,6 +6869,7 @@ enum {
 					 * option.
 					 *
 					 * args[0]: MSS
+					 * args[1]: BPF_SYNCOOKIE_XXX
 					 *
 					 * replylong[0]: ISN
 					 * replylong[1]: TS
@@ -6883,6 +6884,7 @@ enum {
 					 * args[1]: TS
 					 *
 					 * replylong[0]: MSS
+					 * replylong[1]: BPF_SYNCOOKIE_XXX
 					 */
 };
 
@@ -6970,6 +6972,22 @@ enum {
 						 */
 };
 
+/* arg[1] value for BPF_SOCK_OPS_GEN_SYNCOOKIE_CB and
+ * replylong[1] for BPF_SOCK_OPS_CHECK_SYNCOOKIE_CB.
+ *
+ * MSB                                LSB
+ * | 31 ... | 6  | 5   | 4    | 3 2 1 0 |
+ * |    ... | TS | ECN | SACK | WScale  |
+ */
+enum {
+	/* 0xf is invalid thus means that SYN did not have WScale. */
+	BPF_SYNCOOKIE_WSCALE_MASK	= (1 << 4) - 1,
+	BPF_SYNCOOKIE_SACK		= (1 << 4),
+	BPF_SYNCOOKIE_ECN		= (1 << 5),
+	/* Only available for BPF_SOCK_OPS_GEN_SYNCOOKIE_CB to check if SYN has TS */
+	BPF_SYNCOOKIE_TS		= (1 << 6),
+};
+
 struct bpf_perf_event_value {
 	__u64 counter;
 	__u64 enabled;
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index ff979cc314da..22353a9af52d 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -286,6 +286,7 @@ int bpf_skops_cookie_check(struct sock *sk, struct request_sock *req, struct sk_
 {
 	struct bpf_sock_ops_kern sock_ops;
 	struct net *net = sock_net(sk);
+	u32 options;
 
 	if (tcp_opt->saw_tstamp) {
 		if (!READ_ONCE(net->ipv4.sysctl_tcp_timestamps))
@@ -309,6 +310,25 @@ int bpf_skops_cookie_check(struct sock *sk, struct request_sock *req, struct sk_
 	if (!sock_ops.replylong[0])
 		goto err;
 
+	options = sock_ops.replylong[1];
+
+	if ((options & BPF_SYNCOOKIE_WSCALE_MASK) != BPF_SYNCOOKIE_WSCALE_MASK) {
+		if (!READ_ONCE(net->ipv4.sysctl_tcp_window_scaling))
+			goto err;
+
+		tcp_opt->wscale_ok = 1;
+		tcp_opt->snd_wscale = options & BPF_SYNCOOKIE_WSCALE_MASK;
+	}
+
+	if (options & BPF_SYNCOOKIE_SACK) {
+		if (!READ_ONCE(net->ipv4.sysctl_tcp_sack))
+			goto err;
+
+		tcp_opt->sack_ok = 1;
+	}
+
+	inet_rsk(req)->ecn_ok = options & BPF_SYNCOOKIE_ECN;
+
 	__NET_INC_STATS(sock_net(sk), LINUX_MIB_SYNCOOKIESRECV);
 
 	return sock_ops.replylong[0];
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index feb44bff29ef..483e2f36afe5 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6970,14 +6970,25 @@ EXPORT_SYMBOL_GPL(tcp_get_syncookie_mss);
 static int bpf_skops_cookie_init_sequence(struct sock *sk, struct request_sock *req,
 					  struct sk_buff *skb, __u32 *isn)
 {
+	struct inet_request_sock *ireq = inet_rsk(req);
 	struct bpf_sock_ops_kern sock_ops;
+	u32 options;
 	int ret;
 
+	options = ireq->wscale_ok ? ireq->snd_wscale : BPF_SYNCOOKIE_WSCALE_MASK;
+	if (ireq->sack_ok)
+		options |= BPF_SYNCOOKIE_SACK;
+	if (ireq->ecn_ok)
+		options |= BPF_SYNCOOKIE_ECN;
+	if (ireq->tstamp_ok)
+		options |= BPF_SYNCOOKIE_TS;
+
 	memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
 
 	sock_ops.op = BPF_SOCK_OPS_GEN_SYNCOOKIE_CB;
 	sock_ops.sk = req_to_sk(req);
 	sock_ops.args[0] = req->mss;
+	sock_ops.args[1] = options;
 
 	bpf_skops_init_skb(&sock_ops, skb, tcp_hdrlen(skb));
 
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 24f673d88c0d..cdae4dd5d797 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6869,6 +6869,7 @@ enum {
 					 * option.
 					 *
 					 * args[0]: MSS
+					 * args[1]: BPF_SYNCOOKIE_XXX
 					 *
 					 * replylong[0]: ISN
 					 * replylong[1]: TS
@@ -6883,6 +6884,7 @@ enum {
 					 * args[1]: TS
 					 *
 					 * replylong[0]: MSS
+					 * replylong[1]: BPF_SYNCOOKIE_XXX
 					 */
 };
 
@@ -6970,6 +6972,22 @@ enum {
 						 */
 };
 
+/* arg[1] value for BPF_SOCK_OPS_GEN_SYNCOOKIE_CB and
+ * replylong[1] for BPF_SOCK_OPS_CHECK_SYNCOOKIE_CB.
+ *
+ * MSB                                LSB
+ * | 31 ... | 6  | 5   | 4    | 3 2 1 0 |
+ * |    ... | TS | ECN | SACK | WScale  |
+ */
+enum {
+	/* 0xf is invalid thus means that SYN did not have WScale. */
+	BPF_SYNCOOKIE_WSCALE_MASK	= (1 << 4) - 1,
+	BPF_SYNCOOKIE_SACK		= (1 << 4),
+	BPF_SYNCOOKIE_ECN		= (1 << 5),
+	/* Only available for BPF_SOCK_OPS_GEN_SYNCOOKIE_CB to check if SYN has TS */
+	BPF_SYNCOOKIE_TS		= (1 << 6),
+};
+
 struct bpf_perf_event_value {
 	__u64 counter;
 	__u64 enabled;
-- 
2.30.2


