Return-Path: <bpf+bounces-12189-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 964E37C900C
	for <lists+bpf@lfdr.de>; Sat, 14 Oct 2023 00:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A15CB20A73
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 22:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0ECC2B5EE;
	Fri, 13 Oct 2023 22:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Kb62kSuk"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A5828E1F;
	Fri, 13 Oct 2023 22:07:22 +0000 (UTC)
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8727CBF;
	Fri, 13 Oct 2023 15:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1697234839; x=1728770839;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qymGeRSwEhZagwLZFtU6v8TbgmGpKxp8wmPV4NOiUhg=;
  b=Kb62kSukReWnshULZU7V4LB26tB2UstqEA/NHlYCm6dFwtPvfL9MQLi7
   i3IZw1sQXxbQhxAV9l+li/ig4porbtb8qwExF4A7DS/aLHVmGB7CEq/tC
   vnmWJA3gIVTFPPHBD5AP4FGCtZ5LLTlzNpNLxiln1dIwbQjzhM/fIB7LY
   Q=;
X-IronPort-AV: E=Sophos;i="6.03,223,1694736000"; 
   d="scan'208";a="361839175"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-83883bdb.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 22:07:15 +0000
Received: from EX19MTAUWC001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
	by email-inbound-relay-pdx-2a-m6i4x-83883bdb.us-west-2.amazon.com (Postfix) with ESMTPS id 2EFE960D9C;
	Fri, 13 Oct 2023 22:07:14 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Fri, 13 Oct 2023 22:07:13 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.170.60) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Fri, 13 Oct 2023 22:07:09 +0000
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
Subject: [PATCH v1 bpf-next 05/11] bpf: tcp: Add SYN Cookie generation SOCK_OPS hook.
Date: Fri, 13 Oct 2023 15:04:27 -0700
Message-ID: <20231013220433.70792-6-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D040UWB001.ant.amazon.com (10.13.138.82) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch adds a new SOCK_OPS hook to generate arbitrary SYN Cookie.

When the kernel sends SYN Cookie to a client, the hook is invoked with
bpf_sock_ops.op == BPF_SOCK_OPS_GEN_SYNCOOKIE_CB if the listener has
BPF_SOCK_OPS_SYNCOOKIE_CB_FLAG set by bpf_sock_ops_cb_flags_set().

The BPF program can access the following information to encode into
ISN:

  bpf_sock_ops.sk      : 4-tuple
  bpf_sock_ops.skb     : TCP header
  bpf_sock_ops.args[0] : MSS

The program must encode MSS and set it to bpf_sock_ops.replylong[0],
which will be looped back to the paired hook added in the following
patch.

Note that we do not call tcp_synq_overflow() so that the BPF program
can set its own expiration period.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/uapi/linux/bpf.h       | 18 +++++++++++++++-
 net/ipv4/tcp_input.c           | 38 +++++++++++++++++++++++++++++++++-
 tools/include/uapi/linux/bpf.h | 18 +++++++++++++++-
 3 files changed, 71 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 7ba61b75bc0e..d3cc530613c0 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6738,8 +6738,17 @@ enum {
 	 * options first before the BPF program does.
 	 */
 	BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG = (1<<6),
+	/* Call bpf when the kernel generates SYN Cookie (ISN) for SYN+ACK.
+	 *
+	 * The bpf prog will be called to encode MSS into SYN Cookie with
+	 * sock_ops->op == BPF_SOCK_OPS_GEN_SYNCOOKIE_CB.
+	 *
+	 * Please refer to the comment in BPF_SOCK_OPS_GEN_SYNCOOKIE_CB for
+	 * input and output.
+	 */
+	BPF_SOCK_OPS_SYNCOOKIE_CB_FLAG = (1<<7),
 /* Mask of all currently supported cb flags */
-	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0x7F,
+	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0xFF,
 };
 
 /* List of known BPF sock_ops operators.
@@ -6852,6 +6861,13 @@ enum {
 					 * by the kernel or the
 					 * earlier bpf-progs.
 					 */
+	BPF_SOCK_OPS_GEN_SYNCOOKIE_CB,	/* Generate SYN Cookie (ISN of
+					 * SYN+ACK).
+					 *
+					 * args[0]: MSS
+					 *
+					 * replylong[0]: ISN
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 584825ddd0a0..c86a737e4fe6 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6966,6 +6966,37 @@ u16 tcp_get_syncookie_mss(struct request_sock_ops *rsk_ops,
 }
 EXPORT_SYMBOL_GPL(tcp_get_syncookie_mss);
 
+#if IS_ENABLED(CONFIG_CGROUP_BPF) && IS_ENABLED(CONFIG_SYN_COOKIES)
+static int bpf_skops_cookie_init_sequence(struct sock *sk, struct request_sock *req,
+					  struct sk_buff *skb, __u32 *isn)
+{
+	struct bpf_sock_ops_kern sock_ops;
+	int ret;
+
+	memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
+
+	sock_ops.op = BPF_SOCK_OPS_GEN_SYNCOOKIE_CB;
+	sock_ops.sk = req_to_sk(req);
+	sock_ops.args[0] = req->mss;
+
+	bpf_skops_init_skb(&sock_ops, skb, tcp_hdrlen(skb));
+
+	ret = BPF_CGROUP_RUN_PROG_SOCK_OPS_SK(&sock_ops, sk);
+	if (ret)
+		return ret;
+
+	*isn = sock_ops.replylong[0];
+
+	return 0;
+}
+#else
+static int bpf_skops_cookie_init_sequence(struct sock *sk, struct request_sock *req,
+					  struct sk_buff *skb, __u32 *isn)
+{
+	return 0;
+}
+#endif
+
 int tcp_conn_request(struct request_sock_ops *rsk_ops,
 		     const struct tcp_request_sock_ops *af_ops,
 		     struct sock *sk, struct sk_buff *skb)
@@ -7062,7 +7093,12 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 	tcp_ecn_create_request(req, skb, sk, dst);
 
 	if (want_cookie) {
-		isn = cookie_init_sequence(af_ops, sk, skb, &req->mss);
+		if (BPF_SOCK_OPS_TEST_FLAG(tp, BPF_SOCK_OPS_SYNCOOKIE_CB_FLAG)) {
+			if (bpf_skops_cookie_init_sequence(sk, req, skb, &isn))
+				goto drop_and_release;
+		} else {
+			isn = cookie_init_sequence(af_ops, sk, skb, &req->mss);
+		}
 		if (!tmp_opt.tstamp_ok)
 			inet_rsk(req)->ecn_ok = 0;
 	}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 7ba61b75bc0e..d3cc530613c0 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6738,8 +6738,17 @@ enum {
 	 * options first before the BPF program does.
 	 */
 	BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG = (1<<6),
+	/* Call bpf when the kernel generates SYN Cookie (ISN) for SYN+ACK.
+	 *
+	 * The bpf prog will be called to encode MSS into SYN Cookie with
+	 * sock_ops->op == BPF_SOCK_OPS_GEN_SYNCOOKIE_CB.
+	 *
+	 * Please refer to the comment in BPF_SOCK_OPS_GEN_SYNCOOKIE_CB for
+	 * input and output.
+	 */
+	BPF_SOCK_OPS_SYNCOOKIE_CB_FLAG = (1<<7),
 /* Mask of all currently supported cb flags */
-	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0x7F,
+	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0xFF,
 };
 
 /* List of known BPF sock_ops operators.
@@ -6852,6 +6861,13 @@ enum {
 					 * by the kernel or the
 					 * earlier bpf-progs.
 					 */
+	BPF_SOCK_OPS_GEN_SYNCOOKIE_CB,	/* Generate SYN Cookie (ISN of
+					 * SYN+ACK).
+					 *
+					 * args[0]: MSS
+					 *
+					 * replylong[0]: ISN
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
-- 
2.30.2


