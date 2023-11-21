Return-Path: <bpf+bounces-15571-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C837F364D
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 19:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76E02B21103
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 18:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C923522094;
	Tue, 21 Nov 2023 18:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="kiaBsYVz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7393F110;
	Tue, 21 Nov 2023 10:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1700592182; x=1732128182;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IHixAHhojhqDKX1MpvKPKEJH/md3GgMpTtulY7CorTo=;
  b=kiaBsYVzbifPp3MrwIY9LY1pdPFcfFqCzfemjjEocRqszkTefCII3lJF
   Tww4518LUarPiesy/PGi0LAnKiuLlAHrNOFZ8pZKwrdOt7BTrj86cQaOs
   dUhAigsy6RfMDOIP2XNKcSohd64+EpGsf6ZQOtMDgf7LUrXNJYEtKe+3C
   I=;
X-IronPort-AV: E=Sophos;i="6.04,216,1695686400"; 
   d="scan'208";a="45393175"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-fa5fe5fb.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 18:43:00 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2c-m6i4x-fa5fe5fb.us-west-2.amazon.com (Postfix) with ESMTPS id 1256840D96;
	Tue, 21 Nov 2023 18:42:59 +0000 (UTC)
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:58992]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.56.167:2525] with esmtp (Farcaster)
 id 22748138-2f85-49f8-83fe-3267437bc3fd; Tue, 21 Nov 2023 18:42:58 +0000 (UTC)
X-Farcaster-Flow-ID: 22748138-2f85-49f8-83fe-3267437bc3fd
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Tue, 21 Nov 2023 18:42:58 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.30) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Tue, 21 Nov 2023 18:42:54 +0000
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
Subject: [PATCH v3 bpf-next 00/11] bpf: tcp: Support arbitrary SYN Cookie at TC.
Date: Tue, 21 Nov 2023 10:42:34 -0800
Message-ID: <20231121184245.69569-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.170.30]
X-ClientProxiedBy: EX19D043UWC001.ant.amazon.com (10.13.139.202) To
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

  Patch 1 - 6 : Misc cleanup
  Patch 7, 8  : Factorise non-BPF SYN Cookie handling
  Patch 9, 10 : Support arbitrary SYN Cookie with BPF
  Patch 11    : Selftest

[0]: https://lpc.events/event/17/contributions/1645/attachments/1350/2701/SYN_Proxy_at_Scale_with_BPF.pdf


Changes:
  v3:
    Patch 10:
      * Guard kfunc and req->syncookie part in inet6?_steal_sock() with
        CONFIG_SYN_COOKIE (kernel test robot)

  v2: https://lore.kernel.org/netdev/20231120222341.54776-1-kuniyu@amazon.com/
    * Drop SOCK_OPS and move SYN Cookie validation logic to TC with kfunc.
    * Add cleanup patches to reduce discrepancy between cookie_v[46]_check()

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
 include/net/inet6_hashtables.h                |  16 +-
 include/net/inet_hashtables.h                 |  16 +-
 include/net/tcp.h                             |  49 +-
 include/net/tcp_ao.h                          |   6 +-
 net/core/filter.c                             | 113 +++-
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
 16 files changed, 1393 insertions(+), 202 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_siphash.h
 create mode 100644 tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.h

-- 
2.30.2


