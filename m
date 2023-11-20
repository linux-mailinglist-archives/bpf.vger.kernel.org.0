Return-Path: <bpf+bounces-15422-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FB37F202D
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 23:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FCE02816CE
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 22:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DC53986A;
	Mon, 20 Nov 2023 22:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="HAMbgSGJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A998ED;
	Mon, 20 Nov 2023 14:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1700519050; x=1732055050;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=750eeQ8eu1EFPfZfVFvXiy4ZQduJOnsHJq5S10VazyE=;
  b=HAMbgSGJGDFZgmV9l7/OF7Mik90P0+BjfUQpPxTyTPgwBLItRMBMZoy3
   iXjlfpqAdVtJwjPCGtPTw/3O4hs4OW07x6CE9OoUtYf2tIquNZrDIjl2G
   gxWUOU1qizmRq+ERvBA/1pJG8gc/4mvfGdQhuNl0hiWjR1DGTpH5mdYLX
   g=;
X-IronPort-AV: E=Sophos;i="6.04,214,1695686400"; 
   d="scan'208";a="254294742"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-47cc8a4c.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 22:24:07 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1a-m6i4x-47cc8a4c.us-east-1.amazon.com (Postfix) with ESMTPS id D5D521601ED;
	Mon, 20 Nov 2023 22:24:00 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:47729]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.48.37:2525] with esmtp (Farcaster)
 id cabc0162-18a5-4a13-b26b-b73fca3b8c3e; Mon, 20 Nov 2023 22:23:59 +0000 (UTC)
X-Farcaster-Flow-ID: cabc0162-18a5-4a13-b26b-b73fca3b8c3e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 20 Nov 2023 22:23:59 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.171.26) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.39;
 Mon, 20 Nov 2023 22:23:55 +0000
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
Subject: [PATCH v2 bpf-next 00/11] bpf: tcp: Support arbitrary SYN Cookie at TC.
Date: Mon, 20 Nov 2023 14:23:30 -0800
Message-ID: <20231120222341.54776-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.171.26]
X-ClientProxiedBy: EX19D045UWC004.ant.amazon.com (10.13.139.203) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

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
module.  (See slides of LPC2023 [0], p37 - p48)

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

This way, our SYN Proxy does not manage the ISN mappings and can remain
stateless.  It's working very well for high-bandwidth services like
multiple Tbps, but we are looking for a way to drop the dirty hack and
further optimise the sequences.

If we could validate an arbitrary SYN Cookie on the backend server with
BPF, the proxy would need not restore SYN nor pass it.  After validating
ACK, the proxy node just needs to forward it, and then the server can do
the lightweight validation (e.g. check if ACK came from proxy nodes, etc)
and create a connection from the ACK.

This series adds a new kfunc available on TC to create a reqsk and
configure it based on the argument populated from SYN Cookie.

    Usage:

    struct tcp_cookie_attributes attr = {
        .tcp_opt = {
            .mss_clamp = mss,
            .wscale_ok = wscale_ok,
            .snd_scale = send_scale, /* < 15 */
            .tstamp_ok = tstamp_ok,
            .sack_ok = sack_ok,
        },
        .ecn_ok = ecn_ok,
        .usec_ts_ok = usec_ts_ok,
    };

    skc = bpf_skc_lookup_tcp(...);
    sk = (struct sock *)bpf_skc_to_tcp_sock(skc);
    bpf_sk_assign_tcp_reqsk(skb, sk, attr, sizeof(attr));
    bpf_sk_release(skc);

For details, please see each patch.  Here's an overview:

    patch 1 - 6 : Misc cleanup
    patch 7, 8  : Factorise non-BPF SYN Cookie handling
    patch 9, 10 : Support arbitrary SYN Cookie with BPF
    patch 11    : Selftest

[0]: https://lpc.events/event/17/contributions/1645/attachments/1350/2701/SYN_Proxy_at_Scale_with_BPF.pdf


Changes:
  v2:
    * Drop SOCK_OPS and move SYN Cookie validation logic to TC with kfunc.
    * Add cleanup patches to reduce discrepancy between cookie_v[46]_check().

  v1: https://lore.kernel.org/bpf/20231013220433.70792-1-kuniyu@amazon.com/


Kuniyuki Iwashima (11):
  tcp: Clean up reverse xmas tree in cookie_v[46]_check().
  tcp: Cache sock_net(sk) in cookie_v[46]_check().
  tcp: Clean up goto labels in cookie_v[46]_check().
  tcp: Don't pass cookie to __cookie_v[46]_check().
  tcp: Don't initialise tp->tsoffset in tcp_get_cookie_sock().
  tcp: Move TCP-AO bits from cookie_v[46]_check() to tcp_ao_syncookie().
  tcp: Factorise cookie req initialisation.
  tcp: Factorise non-BPF SYN Cookie handling.
  bpf: tcp: Handle BPF SYN Cookie in cookie_v[46]_check().
  bpf: tcp: Support arbitrary SYN Cookie.
  selftest: bpf: Test bpf_sk_assign_tcp_reqsk().

 include/linux/netfilter_ipv6.h                |   8 +-
 include/net/inet6_hashtables.h                |  14 +-
 include/net/inet_hashtables.h                 |  14 +-
 include/net/tcp.h                             |  49 +-
 include/net/tcp_ao.h                          |   6 +-
 net/core/filter.c                             | 111 +++-
 net/core/sock.c                               |  14 +-
 net/ipv4/syncookies.c                         | 273 +++++----
 net/ipv4/tcp_ao.c                             |  16 +-
 net/ipv6/syncookies.c                         | 112 ++--
 net/netfilter/nf_synproxy_core.c              |   4 +-
 tools/testing/selftests/bpf/bpf_kfuncs.h      |  10 +
 .../bpf/prog_tests/tcp_custom_syncookie.c     | 163 +++++
 .../selftests/bpf/progs/test_siphash.h        |  64 ++
 .../bpf/progs/test_tcp_custom_syncookie.c     | 570 ++++++++++++++++++
 .../bpf/progs/test_tcp_custom_syncookie.h     | 161 +++++
 16 files changed, 1387 insertions(+), 202 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_siphash.h
 create mode 100644 tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.h

-- 
2.30.2


