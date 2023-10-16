Return-Path: <bpf+bounces-12310-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 836407CAEAC
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 18:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED1E1B20F1D
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 16:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1F130CFA;
	Mon, 16 Oct 2023 16:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="J0/P8eus"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3822E638;
	Mon, 16 Oct 2023 16:12:14 +0000 (UTC)
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD13E6;
	Mon, 16 Oct 2023 09:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1697472733; x=1729008733;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+36XmP8asMBo8L9iZ19ej+lJg8W+aW92hTS1Nj/oAYg=;
  b=J0/P8eus/07FMHaSHcmkIMHmJsfDmbiTx8xFntl6k6cX4/bQXGMGWEOb
   dqUGnKZTXxTrgi6C/sjewF2AF64GEjCLqxijjxhhF9RDLIGPuk+9UhhXA
   mVhXI3HpepERN5Nc0yVEnkT4X4aYhzkGu1crjkUwJRLbFjGUYzTKK3R7R
   c=;
X-IronPort-AV: E=Sophos;i="6.03,229,1694736000"; 
   d="scan'208";a="245384081"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-529f0975.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 16:12:09 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1e-m6i4x-529f0975.us-east-1.amazon.com (Postfix) with ESMTPS id 14D344880B;
	Mon, 16 Oct 2023 16:11:55 +0000 (UTC)
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:41908]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.209:2525] with esmtp (Farcaster)
 id 32d64908-6f5e-4cac-b6d7-291102808b66; Mon, 16 Oct 2023 16:11:54 +0000 (UTC)
X-Farcaster-Flow-ID: 32d64908-6f5e-4cac-b6d7-291102808b66
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Mon, 16 Oct 2023 16:11:46 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.29) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Mon, 16 Oct 2023 16:11:42 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <daniel@iogearbox.net>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<haoluo@google.com>, <john.fastabend@gmail.com>, <jolsa@kernel.org>,
	<kpsingh@kernel.org>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <martin.lau@linux.dev>, <mykolal@fb.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <sdf@google.com>,
	<song@kernel.org>, <yonghong.song@linux.dev>
Subject: Re: [PATCH v1 bpf-next 00/11] bpf: tcp: Add SYN Cookie generation/validation SOCK_OPS hooks.
Date: Mon, 16 Oct 2023 09:11:34 -0700
Message-ID: <20231016161134.25365-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <0611984e-aea2-7eb5-af3e-e0635ca3b7ba@iogearbox.net>
References: <0611984e-aea2-7eb5-af3e-e0635ca3b7ba@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.171.29]
X-ClientProxiedBy: EX19D039UWB003.ant.amazon.com (10.13.138.93) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Daniel Borkmann <daniel@iogearbox.net>
Date: Mon, 16 Oct 2023 15:05:25 +0200
> On 10/14/23 12:04 AM, Kuniyuki Iwashima wrote:
> > Under SYN Flood, the TCP stack generates SYN Cookie to remain stateless
> > for the connection request until a valid ACK is responded to the SYN+ACK.
> > 
> > The cookie contains two kinds of host-specific bits, a timestamp and
> > secrets, so only can it be validated by the generator.  It means SYN
> > Cookie consumes network resources between the client and the server;
> > intermediate nodes must remember which nodes to route ACK for the cookie.
> > 
> > SYN Proxy reduces such unwanted resource allocation by handling 3WHS at
> > the edge network.  After SYN Proxy completes 3WHS, it forwards SYN to the
> > backend server and completes another 3WHS.  However, since the server's
> > ISN differs from the cookie, the proxy must manage the ISN mappings and
> > fix up SEQ/ACK numbers in every packet for each connection.  If a proxy
> > node is down, all the connections through it are also down.  Keeping a
> > state at proxy is painful from that perspective.
> > 
> > At AWS, we use a dirty hack to build truly stateless SYN Proxy at scale.
> > Our SYN Proxy consists of the front proxy layer and the backend kernel
> > module.  (See slides of netconf [0], p6 - p15)
> > 
> > The cookie that SYN Proxy generates differs from the kernel's cookie in
> > that it contains a secret (called rolling salt) (i) shared by all the proxy
> > nodes so that any node can validate ACK and (ii) updated periodically so
> > that old cookies cannot be validated.  Also, ISN contains WScale, SACK, and
> > ECN, not in TS val.  This is not to sacrifice any connection quality, where
> > some customers turn off the timestamp option due to retro CVE.
> > 
> > After 3WHS, the proxy restores SYN and forwards it and ACK to the backend
> > server.  Our kernel module works at Netfilter input/output hooks and first
> > feeds SYN to the TCP stack to initiate 3WHS.  When the module is triggered
> > for SYN+ACK, it looks up the corresponding request socket and overwrites
> > tcp_rsk(req)->snt_isn with the proxy's cookie.  Then, the module can
> > complete 3WHS with the original ACK as is.
> > 
> > This way, our SYN Proxy does not manage the ISN mappings and can stay
> > stateless.  It's working very well for high-bandwidth services like
> > multiple Tbps, but we are looking for a way to drop the dirty hack and
> > further optimise the sequences.
> > 
> > If we could validate an arbitrary SYN Cookie on the backend server with
> > BPF, the proxy would need not restore SYN nor pass it.  After validating
> > ACK, the proxy node just needs to forward it, and then the server can do
> > the lightweight validation (e.g. check if ACK came from proxy nodes, etc)
> > and create a connection from the ACK.
> > 
> > This series adds two SOCK_OPS hooks to generate and validate arbitrary
> > SYN Cookie.  Each hook is invoked if BPF_SOCK_OPS_SYNCOOKIE_CB_FLAG is
> > set to the listening socket in advance by bpf_sock_ops_cb_flags_set().
> > 
> > The user interface looks like this:
> > 
> >    BPF_SOCK_OPS_GEN_SYNCOOKIE_CB
> > 
> >      input
> >      |- bpf_sock_ops.sk           : 4-tuple
> >      |- bpf_sock_ops.skb          : TCP header
> >      |- bpf_sock_ops.args[0]      : MSS
> >      `- bpf_sock_ops.args[1]      : BPF_SYNCOOKIE_XXX flags
> > 
> >      output
> >      |- bpf_sock_ops.replylong[0] : ISN (SYN Cookie) ------.
> >      `- bpf_sock_ops.replylong[1] : TS value -----------.  |
> >                                                         |  |
> >    BPF_SOCK_OPS_CHECK_SYNCOOKIE_CB                      |  |
> >                                                         |  |
> >      input                                              |  |
> >      |- bpf_sock_ops.sk           : 4-tuple             |  |
> >      |- bpf_sock_ops.skb          : TCP header          |  |
> >      |- bpf_sock_ops.args[0]      : ISN (SYN Cookie) <-----'
> >      `- bpf_sock_ops.args[1]      : TS value <----------'
> > 
> >      output
> >      |- bpf_sock_ops.replylong[0] : MSS
> >      `- bpf_sock_ops.replylong[1] : BPF_SYNCOOKIE_XXX flags
> > 
> > To establish a connection from SYN Cookie, BPF_SOCK_OPS_CHECK_SYNCOOKIE_CB
> > hook must set a valid MSS to bpf_sock_ops.replylong[0], meaning that
> > BPF_SOCK_OPS_GEN_SYNCOOKIE_CB hook must encode MSS to ISN or TS val to be
> > restored in the validation hook.
> > 
> > If WScale, SACK, and ECN are detected to be available in SYN packet, the
> > corresponding flags are passed to args[0] of BPF_SOCK_OPS_GEN_SYNCOOKIE_CB
> > so that bpf prog need not parse the TCP header.  The same flags can be set
> > to replylong[0] of BPF_SOCK_OPS_CHECK_SYNCOOKIE_CB to enable each feature
> > on the connection.
> > 
> > For details, please see each patch.  Here's an overview:
> > 
> >    patch 1 - 4 : Misc cleanup
> >    patch 5, 6  : Add SOCK_OPS hook (only ISN is available here)
> >    patch 7, 8  : Make TS val available as the second cookie storage
> >    patch 9, 10 : Make WScale, SACK, and ECN configurable from ACK
> >    patch 11    : selftest, need some help from BPF experts...
> > 
> > [0]: https://netdev.bots.linux.dev/netconf/2023/kuniyuki.pdf
> 
> Fyi, just as quick feedback, this fails BPF CI selftests :
> 
> https://github.com/kernel-patches/bpf/actions/runs/6513838231/job/17694669376
> 
> Notice: Success: 427/3396, Skipped: 24, Failed: 1
> Error: #274 tcpbpf_user
>    Error: #274 tcpbpf_user
>    test_tcpbpf_user:PASS:open and load skel 0 nsec
>    test_tcpbpf_user:PASS:test__join_cgroup(/tcpbpf-user-test) 0 nsec
>    test_tcpbpf_user:PASS:attach_cgroup(bpf_testcb) 0 nsec
>    run_test:PASS:start_server 0 nsec
>    run_test:PASS:connect_to_fd(listen_fd) 0 nsec
>    run_test:PASS:accept(listen_fd) 0 nsec
>    run_test:PASS:send(cli_fd) 0 nsec
>    run_test:PASS:recv(accept_fd) 0 nsec
>    run_test:PASS:send(accept_fd) 0 nsec
>    run_test:PASS:recv(cli_fd) 0 nsec
>    run_test:PASS:recv(cli_fd) for fin 0 nsec
>    run_test:PASS:recv(accept_fd) for fin 0 nsec
>    verify_result:PASS:event_map 0 nsec
>    verify_result:PASS:bytes_received 0 nsec
>    verify_result:PASS:bytes_acked 0 nsec
>    verify_result:PASS:data_segs_in 0 nsec
>    verify_result:PASS:data_segs_out 0 nsec
>    verify_result:FAIL:bad_cb_test_rv unexpected bad_cb_test_rv: actual 0 != expected 128

128 (0x80) should be BPF_SOCK_OPS_ALL_CB_FLAGS + 1 instead so
that we need not update the test for each SOCK_OPS addition.

I'll include this diff in the next revision.

Thank you!

---8<---
diff --git a/tools/testing/selftests/bpf/prog_tests/tcpbpf_user.c b/tools/testing/selftests/bpf/prog_tests/tcpbpf_user.c
index 7e8fe1bad03f..e4849d2a2956 100644
--- a/tools/testing/selftests/bpf/prog_tests/tcpbpf_user.c
+++ b/tools/testing/selftests/bpf/prog_tests/tcpbpf_user.c
@@ -26,7 +26,8 @@ static void verify_result(struct tcpbpf_globals *result)
 	ASSERT_EQ(result->bytes_acked, 1002, "bytes_acked");
 	ASSERT_EQ(result->data_segs_in, 1, "data_segs_in");
 	ASSERT_EQ(result->data_segs_out, 1, "data_segs_out");
-	ASSERT_EQ(result->bad_cb_test_rv, 0x80, "bad_cb_test_rv");
+	ASSERT_EQ(result->bad_cb_test_rv, BPF_SOCK_OPS_ALL_CB_FLAGS + 1,
+		  "bad_cb_test_rv");
 	ASSERT_EQ(result->good_cb_test_rv, 0, "good_cb_test_rv");
 	ASSERT_EQ(result->num_listen, 1, "num_listen");
 
diff --git a/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c b/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c
index cf7ed8cbb1fe..52da66d77fd6 100644
--- a/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c
@@ -103,7 +103,8 @@ int bpf_testcb(struct bpf_sock_ops *skops)
 		break;
 	case BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB:
 		/* Test failure to set largest cb flag (assumes not defined) */
-		global.bad_cb_test_rv = bpf_sock_ops_cb_flags_set(skops, 0x80);
+		global.bad_cb_test_rv = bpf_sock_ops_cb_flags_set(skops,
+								  BPF_SOCK_OPS_ALL_CB_FLAGS + 1);
 		/* Set callback */
 		global.good_cb_test_rv = bpf_sock_ops_cb_flags_set(skops,
 						 BPF_SOCK_OPS_STATE_CB_FLAG);
---8<---


>    verify_result:PASS:good_cb_test_rv 0 nsec
>    verify_result:PASS:num_listen 0 nsec
>    verify_result:PASS:num_close_events 0 nsec
>    verify_result:PASS:tcp_save_syn 0 nsec
>    verify_result:PASS:tcp_saved_syn 0 nsec
>    verify_result:PASS:window_clamp_client 0 nsec
>    verify_result:PASS:window_clamp_server 0 nsec

