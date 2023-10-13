Return-Path: <bpf+bounces-12184-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5789F7C9002
	for <lists+bpf@lfdr.de>; Sat, 14 Oct 2023 00:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88C4B1C212B7
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 22:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A362941D;
	Fri, 13 Oct 2023 22:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="o66FlYyz"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E573A21A0A;
	Fri, 13 Oct 2023 22:05:15 +0000 (UTC)
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36639B7;
	Fri, 13 Oct 2023 15:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1697234714; x=1728770714;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mI7coQFdhEGnguDbH2wh9Qo/10gHOhyBrnmUIiYC6IY=;
  b=o66FlYyzMMSohM5qknC+NwGy9HeXEqcBPqgNEz5t5iph338Os1QAAA9T
   6PPegrAd3vDtv8q4NGjxp/uRu9W+Fm36A2RGQ7xuvEAUzjx5ls9PzVYKV
   yhpP1y+gAP4PAyC0RL6DwhpSQddtNkSD82APUrDa1ljNSKBKbWqoYArps
   I=;
X-IronPort-AV: E=Sophos;i="6.03,223,1694736000"; 
   d="scan'208";a="35768345"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-bbc6e425.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 22:05:10 +0000
Received: from EX19MTAUWB002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
	by email-inbound-relay-iad-1a-m6i4x-bbc6e425.us-east-1.amazon.com (Postfix) with ESMTPS id 7C9D680811;
	Fri, 13 Oct 2023 22:05:05 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Fri, 13 Oct 2023 22:05:04 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.170.60) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Fri, 13 Oct 2023 22:05:00 +0000
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
Subject: [PATCH v1 bpf-next 00/11] bpf: tcp: Add SYN Cookie generation/validation SOCK_OPS hooks.
Date: Fri, 13 Oct 2023 15:04:22 -0700
Message-ID: <20231013220433.70792-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.170.60]
X-ClientProxiedBy: EX19D043UWA004.ant.amazon.com (10.13.139.41) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Under SYN Flood, the TCP stack generates SYN Cookie to remain stateless
for the connection request until a valid ACK is responded to the SYN+ACK.

The cookie contains two kinds of host-specific bits, a timestamp and
secrets, so only can it be validated by the generator.  It means SYN
Cookie consumes network resources between the client and the server;
intermediate nodes must remember which nodes to route ACK for the cookie.

SYN Proxy reduces such unwanted resource allocation by handling 3WHS at
the edge network.  After SYN Proxy completes 3WHS, it forwards SYN to the
backend server and completes another 3WHS.  However, since the server's
ISN differs from the cookie, the proxy must manage the ISN mappings and
fix up SEQ/ACK numbers in every packet for each connection.  If a proxy
node is down, all the connections through it are also down.  Keeping a
state at proxy is painful from that perspective.

At AWS, we use a dirty hack to build truly stateless SYN Proxy at scale.
Our SYN Proxy consists of the front proxy layer and the backend kernel
module.  (See slides of netconf [0], p6 - p15)

The cookie that SYN Proxy generates differs from the kernel's cookie in
that it contains a secret (called rolling salt) (i) shared by all the proxy
nodes so that any node can validate ACK and (ii) updated periodically so
that old cookies cannot be validated.  Also, ISN contains WScale, SACK, and
ECN, not in TS val.  This is not to sacrifice any connection quality, where
some customers turn off the timestamp option due to retro CVE.

After 3WHS, the proxy restores SYN and forwards it and ACK to the backend
server.  Our kernel module works at Netfilter input/output hooks and first
feeds SYN to the TCP stack to initiate 3WHS.  When the module is triggered
for SYN+ACK, it looks up the corresponding request socket and overwrites
tcp_rsk(req)->snt_isn with the proxy's cookie.  Then, the module can
complete 3WHS with the original ACK as is.

This way, our SYN Proxy does not manage the ISN mappings and can stay
stateless.  It's working very well for high-bandwidth services like
multiple Tbps, but we are looking for a way to drop the dirty hack and
further optimise the sequences.

If we could validate an arbitrary SYN Cookie on the backend server with
BPF, the proxy would need not restore SYN nor pass it.  After validating
ACK, the proxy node just needs to forward it, and then the server can do
the lightweight validation (e.g. check if ACK came from proxy nodes, etc)
and create a connection from the ACK.

This series adds two SOCK_OPS hooks to generate and validate arbitrary
SYN Cookie.  Each hook is invoked if BPF_SOCK_OPS_SYNCOOKIE_CB_FLAG is
set to the listening socket in advance by bpf_sock_ops_cb_flags_set().

The user interface looks like this:

  BPF_SOCK_OPS_GEN_SYNCOOKIE_CB

    input
    |- bpf_sock_ops.sk           : 4-tuple
    |- bpf_sock_ops.skb          : TCP header
    |- bpf_sock_ops.args[0]      : MSS
    `- bpf_sock_ops.args[1]      : BPF_SYNCOOKIE_XXX flags

    output
    |- bpf_sock_ops.replylong[0] : ISN (SYN Cookie) ------.
    `- bpf_sock_ops.replylong[1] : TS value -----------.  |
                                                       |  |
  BPF_SOCK_OPS_CHECK_SYNCOOKIE_CB                      |  |
                                                       |  |
    input                                              |  |
    |- bpf_sock_ops.sk           : 4-tuple             |  |
    |- bpf_sock_ops.skb          : TCP header          |  |
    |- bpf_sock_ops.args[0]      : ISN (SYN Cookie) <-----'
    `- bpf_sock_ops.args[1]      : TS value <----------'

    output
    |- bpf_sock_ops.replylong[0] : MSS
    `- bpf_sock_ops.replylong[1] : BPF_SYNCOOKIE_XXX flags

To establish a connection from SYN Cookie, BPF_SOCK_OPS_CHECK_SYNCOOKIE_CB
hook must set a valid MSS to bpf_sock_ops.replylong[0], meaning that
BPF_SOCK_OPS_GEN_SYNCOOKIE_CB hook must encode MSS to ISN or TS val to be
restored in the validation hook.

If WScale, SACK, and ECN are detected to be available in SYN packet, the
corresponding flags are passed to args[0] of BPF_SOCK_OPS_GEN_SYNCOOKIE_CB
so that bpf prog need not parse the TCP header.  The same flags can be set
to replylong[0] of BPF_SOCK_OPS_CHECK_SYNCOOKIE_CB to enable each feature
on the connection.

For details, please see each patch.  Here's an overview:

  patch 1 - 4 : Misc cleanup
  patch 5, 6  : Add SOCK_OPS hook (only ISN is available here)
  patch 7, 8  : Make TS val available as the second cookie storage
  patch 9, 10 : Make WScale, SACK, and ECN configurable from ACK
  patch 11    : selftest, need some help from BPF experts...

[0]: https://netdev.bots.linux.dev/netconf/2023/kuniyuki.pdf


Kuniyuki Iwashima (11):
  tcp: Clean up reverse xmas tree in cookie_v[46]_check().
  tcp: Cache sock_net(sk) in cookie_v[46]_check().
  tcp: Clean up goto labels in cookie_v[46]_check().
  tcp: Don't initialise tp->tsoffset in tcp_get_cookie_sock().
  bpf: tcp: Add SYN Cookie generation SOCK_OPS hook.
  bpf: tcp: Add SYN Cookie validation SOCK_OPS hook.
  bpf: Make bpf_sock_ops.replylong[1] writable.
  bpf: tcp: Make TS available for SYN Cookie storage.
  tcp: Split cookie_ecn_ok().
  bpf: tcp: Make WS, SACK, ECN configurable from BPF SYN Cookie.
  selftest: bpf: Test BPF_SOCK_OPS_(GEN|CHECK)_SYNCOOKIE_CB.

 include/net/inet_sock.h                       |   4 +-
 include/net/tcp.h                             |  46 +++-
 include/uapi/linux/bpf.h                      |  52 ++++-
 net/core/filter.c                             |   2 +-
 net/ipv4/syncookies.c                         | 219 +++++++++++-------
 net/ipv4/tcp_input.c                          |  53 ++++-
 net/ipv6/syncookies.c                         |  94 +++++---
 tools/include/uapi/linux/bpf.h                |  52 ++++-
 .../selftests/bpf/prog_tests/tcp_syncookie.c  |  84 +++++++
 .../selftests/bpf/progs/test_siphash.h        |  65 ++++++
 .../selftests/bpf/progs/test_tcp_syncookie.c  | 170 ++++++++++++++
 .../selftests/bpf/test_tcp_hdr_options.h      |   8 +-
 12 files changed, 715 insertions(+), 134 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tcp_syncookie.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_siphash.h
 create mode 100644 tools/testing/selftests/bpf/progs/test_tcp_syncookie.c

-- 
2.30.2


