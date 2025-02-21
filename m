Return-Path: <bpf+bounces-52138-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D82A3EAB6
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 03:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F2353A53F8
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 02:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CB018B46E;
	Fri, 21 Feb 2025 02:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Hk8zQ/h6"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF862AE69
	for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 02:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740104489; cv=none; b=E0caJufcXm2UVLG4kmvoEyRQQWhDHqiAFZBRZp3/9//3pJ79PolLOhr4jmc+ork1V/1hhVAZZC9/vpNqxv848hcOilJYQSz91xWUbuxSfy4Ng9pxf7gEzKD2qhRmItvk4DP5N0nPc5LaJzyyOiiea1eQlnzf54BDfr1V9Bq6X2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740104489; c=relaxed/simple;
	bh=32NqSzH9nK4+7eUoBTF2WVEObSuF6BQK4VoxLW/38K8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aaBvGsqul0+FD1myBfp8gU5No67pNtmuCXUU6KH5bamjSfd6jYIYv8at4wttXd3clgiWxLtNVAq1UYqJohEJID3huiyqG+8iq6TmCEkcWjhRaWXWH4Dq9KjmNr7tI64mG/g7Q4LK+4q8G7YTU93yHhbgfgtaj4CX84oTRV9VSms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Hk8zQ/h6; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740104485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rHlvTlPX8lID06At4M15/Ip4VggY0vSsyeD8jBZY/gs=;
	b=Hk8zQ/h6VAek++n6M6yz8S5Wmhb5DcvWZA/QRrHCpWiZA1tYXHUHKtiN9gQSBouXvFizro
	2d+FoZwyClQeyN7vyjaOZl71744oqPHturynWsRP0IAP8mVA18n8/xxXNXIrLHSGaVO5+j
	Dpm1K2oBzdnup63tBHjyYlP/WFlI9FU=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: pull-request: bpf-next 2025-02-20
Date: Thu, 20 Feb 2025 18:21:04 -0800
Message-ID: <20250221022104.386462-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net-next* tree.

We've added 19 non-merge commits during the last 8 day(s) which contain
a total of 35 files changed, 1126 insertions(+), 53 deletions(-).

The main changes are:

1) Add TCP_RTO_MAX_MS support to bpf_set/getsockopt, from Jason Xing

2) Add network TX timestamping support to BPF sock_ops, from Jason Xing

3) Add TX metadata Launch Time support, from Song Yoong Siang

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Choong Yong Liang, Faizal Rahim, Jakub Kicinski, Kuniyuki Iwashima, 
Maciej Fijalkowski, Stanislav Fomichev, Willem de Bruijn

----------------------------------------------------------------

The following changes since commit 7a7e0197133d18cfd9931e7d3a842d0f5730223f:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-02-13 12:43:30 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

for you to fetch changes up to 494a04413cb194f869b4b3133b07dfbc607165aa:

  Merge branch 'xsk-tx-metadata-launch-time-support' (2025-02-20 15:13:46 -0800)

----------------------------------------------------------------
bpf-next-for-netdev

----------------------------------------------------------------
Jason Xing (14):
      bpf: Support TCP_RTO_MAX_MS for bpf_setsockopt
      selftests/bpf: Add rto max for bpf_setsockopt test
      bpf: Add networking timestamping support to bpf_get/setsockopt()
      bpf: Prepare the sock_ops ctx and call bpf prog for TX timestamping
      bpf: Prevent unsafe access to the sock fields in the BPF timestamping callback
      bpf: Disable unsafe helpers in TX timestamping callbacks
      net-timestamp: Prepare for isolating two modes of SO_TIMESTAMPING
      bpf: Add BPF_SOCK_OPS_TSTAMP_SCHED_CB callback
      bpf: Add BPF_SOCK_OPS_TSTAMP_SND_SW_CB callback
      bpf: Add BPF_SOCK_OPS_TSTAMP_SND_HW_CB callback
      bpf: Add BPF_SOCK_OPS_TSTAMP_ACK_CB callback
      bpf: Add BPF_SOCK_OPS_TSTAMP_SENDMSG_CB callback
      bpf: Support selective sampling for bpf timestamping
      selftests/bpf: Add simple bpf tests in the tx path for timestamping feature

Martin KaFai Lau (3):
      Merge branch 'bpf-support-setting-max-rto-for-bpf_setsockopt'
      Merge branch 'net-timestamp-bpf-extension-to-equip-applications-transparently'
      Merge branch 'xsk-tx-metadata-launch-time-support'

Song Yoong Siang (5):
      xsk: Add launch time hardware offload support to XDP Tx metadata
      selftests/bpf: Add launch time request to xdp_hw_metadata
      net: stmmac: Add launch time support to XDP ZC
      igc: Refactor empty frame insertion for launch time support
      igc: Add launch time support to XDP ZC

 Documentation/netlink/specs/netdev.yaml            |   4 +
 Documentation/networking/xsk-tx-metadata.rst       |  62 ++++++
 drivers/net/ethernet/intel/igc/igc.h               |   1 +
 drivers/net/ethernet/intel/igc/igc_main.c          | 143 +++++++++---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |   2 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  13 ++
 include/linux/filter.h                             |   1 +
 include/linux/skbuff.h                             |  12 +-
 include/net/sock.h                                 |  10 +
 include/net/tcp.h                                  |   7 +-
 include/net/xdp_sock.h                             |  10 +
 include/net/xdp_sock_drv.h                         |   1 +
 include/uapi/linux/bpf.h                           |  30 +++
 include/uapi/linux/if_xdp.h                        |  10 +
 include/uapi/linux/netdev.h                        |   3 +
 kernel/bpf/btf.c                                   |   1 +
 net/core/dev.c                                     |   3 +-
 net/core/filter.c                                  |  80 ++++++-
 net/core/netdev-genl.c                             |   2 +
 net/core/skbuff.c                                  |  53 +++++
 net/core/sock.c                                    |  14 ++
 net/dsa/user.c                                     |   2 +-
 net/ipv4/tcp.c                                     |   6 +-
 net/ipv4/tcp_input.c                               |   2 +
 net/ipv4/tcp_output.c                              |   2 +
 net/socket.c                                       |   2 +-
 net/xdp/xsk.c                                      |   3 +
 tools/include/uapi/linux/bpf.h                     |  30 +++
 tools/include/uapi/linux/if_xdp.h                  |  10 +
 tools/include/uapi/linux/netdev.h                  |   3 +
 .../selftests/bpf/prog_tests/net_timestamping.c    | 239 ++++++++++++++++++++
 .../testing/selftests/bpf/progs/bpf_tracing_net.h  |   1 +
 .../testing/selftests/bpf/progs/net_timestamping.c | 248 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/setget_sockopt.c |   1 +
 tools/testing/selftests/bpf/xdp_hw_metadata.c      | 168 +++++++++++++-
 35 files changed, 1126 insertions(+), 53 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/net_timestamping.c
 create mode 100644 tools/testing/selftests/bpf/progs/net_timestamping.c

