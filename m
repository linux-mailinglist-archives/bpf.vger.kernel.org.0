Return-Path: <bpf+bounces-17844-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD32813554
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 16:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BD33B20D90
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 15:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B9C5D91E;
	Thu, 14 Dec 2023 15:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="vWKzeF6a"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D520E8;
	Thu, 14 Dec 2023 07:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702569291; x=1734105291;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=I5jhm5cy2oaJAdCnM0BrbT9/Gr+ONF1EVY3nTyJ7IbE=;
  b=vWKzeF6aVqO/xJO34Cnffmd8MmmbXOJE1Num3QGy0kJfAPawQ9TG4/qb
   dVwcL3NlLXp4HgLNqx9U/VHosL4MJV1MTA4Y0H66vGDy3jS7XepMDhxYy
   7RWTBm0mb2nuLKQD8kjpYq4vhLuw9RYpVJULzkhyv1D8K6qC2KTgkpA7Y
   Q=;
X-IronPort-AV: E=Sophos;i="6.04,275,1695686400"; 
   d="scan'208";a="259098496"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-f7c754c9.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 15:54:49 +0000
Received: from smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2c-m6i4x-f7c754c9.us-west-2.amazon.com (Postfix) with ESMTPS id 91AEC40DAD;
	Thu, 14 Dec 2023 15:54:47 +0000 (UTC)
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:13558]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.43.236:2525] with esmtp (Farcaster)
 id 5c140d4b-8ed2-4673-ad51-e60ad6eefaf2; Thu, 14 Dec 2023 15:54:46 +0000 (UTC)
X-Farcaster-Flow-ID: 5c140d4b-8ed2-4673-ad51-e60ad6eefaf2
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Dec 2023 15:54:41 +0000
Received: from 88665a182662.ant.amazon.com (10.143.92.5) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Dec 2023 15:54:37 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Eric Dumazet <edumazet@google.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH v6 bpf-next 0/6] bpf: tcp: Support arbitrary SYN Cookie at TC.
Date: Fri, 15 Dec 2023 00:54:18 +0900
Message-ID: <20231214155424.67136-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC002.ant.amazon.com (10.13.139.196) To
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
node goes down, all the connections through it are terminated.  Keeping
a state at proxy is painful from that perspective.

At AWS, we use a dirty hack to build truly stateless SYN Proxy at scale.
Our SYN Proxy consists of the front proxy layer and the backend kernel
module.  (See slides of LPC2023 [0], p37 - p48)

The cookie that SYN Proxy generates differs from the kernel's cookie in
that it contains a secret (called rolling salt) (i) shared by all the proxy
nodes so that any node can validate ACK and (ii) updated periodically so
that old cookies cannot be validated and we need not encode a timestamp for
the cookie.  Also, ISN contains WScale, SACK, and ECN, not in TS val.  This
is not to sacrifice any connection quality, where some customers turn off
TCP timestamps option due to retro CVE.

After 3WHS, the proxy restores SYN, encapsulates ACK into SYN, and forward
the TCP-in-TCP packet to the backend server.  Our kernel module works at
Netfilter input/output hooks and first feeds SYN to the TCP stack to
initiate 3WHS.  When the module is triggered for SYN+ACK, it looks up the
corresponding request socket and overwrites tcp_rsk(req)->snt_isn with the
proxy's cookie.  Then, the module can complete 3WHS with the original ACK
as is.

This way, our SYN Proxy does not manage the ISN mappings nor wait for
SYN+ACK from the backend thus can remain stateless.  It's working very
well for high-bandwidth services like multiple Tbps, but we are looking
for a way to drop the dirty hack and further optimise the sequences.

If we could validate an arbitrary SYN Cookie on the backend server with
BPF, the proxy would need not restore SYN nor pass it.  After validating
ACK, the proxy node just needs to forward it, and then the server can do
the lightweight validation (e.g. check if ACK came from proxy nodes, etc)
and create a connection from the ACK.

This series allows us to create a full sk from an arbitrary SYN Cookie,
which is done in 3 steps.

  1) At tc, BPF prog calls a new kfunc to create a reqsk and configure
     it based on the argument populated from SYN Cookie.  The reqsk has
     its listener as req->rsk_listener and is passed to the TCP stack as
     skb->sk.

  2) During TCP socket lookup for the skb, skb_steal_sock() returns a
     listener in the reuseport group that inet_reqsk(skb->sk)->rsk_listener
     belongs to.

  3) In cookie_v[46]_check(), the reqsk (skb->sk) is fully initialised and
     a full sk is created.

The kfunc usage is as follows:

    struct bpf_tcp_req_attrs attrs = {
        .mss = mss,
        .wscale_ok = wscale_ok,
        .rcv_wscale = rcv_wscale, /* Server's WScale < 15 */
        .snd_wscale = snd_wscale, /* Client's WScale < 15 */
        .tstamp_ok = tstamp_ok,
        .rcv_tsval = tsval,
        .rcv_tsecr = tsecr, /* Server's Initial TSval */
        .usec_ts_ok = usec_ts_ok,
        .sack_ok = sack_ok,
        .ecn_ok = ecn_ok,
    }

    skc = bpf_skc_lookup_tcp(...);
    sk = (struct sock *)bpf_skc_to_tcp_sock(skc);
    bpf_sk_assign_tcp_reqsk(skb, sk, attrs, sizeof(attrs));
    bpf_sk_release(skc);

[0]: https://lpc.events/event/17/contributions/1645/attachments/1350/2701/SYN_Proxy_at_Scale_with_BPF.pdf


Changes:
  v6:
    * Patch 5 & 6
      * /struct /s/tcp_cookie_attributes/bpf_tcp_req_attrs/
      * Don't reuse struct tcp_options_received and use u8 for each attrs
    * Patch 6
      * Check retval of test__start_subtest()

  v5: https://lore.kernel.org/netdev/20231211073650.90819-1-kuniyu@amazon.com/
    * Split patch 1-3
    * Patch 3
      * Clear req->rsk_listener in skb_steal_sock()
    * Patch 4 & 5
      * Move sysctl validation and tsoff init from cookie_bpf_check() to kfunc
    * Patch 5
      * Do not increment LINUX_MIB_SYNCOOKIES(RECV|FAILED)
    * Patch 6
      * Remove __always_inline
      * Test if tcp_handle_{syn,ack}() is executed
      * Move some definition to bpf_tracing_net.h
      * s/BPF_F_CURRENT_NETNS/-1/

  v4: https://lore.kernel.org/bpf/20231205013420.88067-1-kuniyu@amazon.com/
    * Patch 1 & 2
      * s/CONFIG_SYN_COOKIE/CONFIG_SYN_COOKIES/
    * Patch 1
      * Don't set rcv_wscale for BPF SYN Cookie case.
    * Patch 2
      * Add test for tcp_opt.{unused,rcv_wscale} in kfunc
      * Modify skb_steal_sock() to avoid resetting skb-sk
      * Support SO_REUSEPORT lookup
    * Patch 3
      * Add CONFIG_SYN_COOKIES to Kconfig for CI
      * Define BPF_F_CURRENT_NETNS

  v3: https://lore.kernel.org/netdev/20231121184245.69569-1-kuniyu@amazon.com/
    * Guard kfunc and req->syncookie part in inet6?_steal_sock() with
      CONFIG_SYN_COOKIE

  v2: https://lore.kernel.org/netdev/20231120222341.54776-1-kuniyu@amazon.com/
    * Drop SOCK_OPS and move SYN Cookie validation logic to TC with kfunc.
    * Add cleanup patches to reduce discrepancy between cookie_v[46]_check()

  v1: https://lore.kernel.org/bpf/20231013220433.70792-1-kuniyu@amazon.com/


Kuniyuki Iwashima (6):
  tcp: Move tcp_ns_to_ts() to tcp.h
  tcp: Move skb_steal_sock() to request_sock.h
  bpf: tcp: Handle BPF SYN Cookie in skb_steal_sock().
  bpf: tcp: Handle BPF SYN Cookie in cookie_v[46]_check().
  bpf: tcp: Support arbitrary SYN Cookie.
  selftest: bpf: Test bpf_sk_assign_tcp_reqsk().

 include/net/request_sock.h                    |  39 ++
 include/net/sock.h                            |  25 -
 include/net/tcp.h                             |  42 ++
 net/core/filter.c                             | 116 +++-
 net/core/sock.c                               |  14 +-
 net/ipv4/syncookies.c                         |  40 +-
 net/ipv6/syncookies.c                         |  13 +-
 tools/testing/selftests/bpf/bpf_kfuncs.h      |  10 +
 tools/testing/selftests/bpf/config            |   1 +
 .../bpf/prog_tests/tcp_custom_syncookie.c     | 171 ++++++
 .../selftests/bpf/progs/bpf_tracing_net.h     |  17 +
 .../selftests/bpf/progs/test_siphash.h        |  64 ++
 .../bpf/progs/test_tcp_custom_syncookie.c     | 572 ++++++++++++++++++
 .../bpf/progs/test_tcp_custom_syncookie.h     | 140 +++++
 14 files changed, 1218 insertions(+), 46 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_siphash.h
 create mode 100644 tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.h

-- 
2.30.2


