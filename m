Return-Path: <bpf+bounces-33438-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7BD91CF71
	for <lists+bpf@lfdr.de>; Sun, 30 Jun 2024 00:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36C3E1C20C86
	for <lists+bpf@lfdr.de>; Sat, 29 Jun 2024 22:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D91413E8AE;
	Sat, 29 Jun 2024 22:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJiKYfPY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB467142E77;
	Sat, 29 Jun 2024 22:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719700064; cv=none; b=C2MRzR6TeuNzqMnrylXUSvDf9E5wea7tF4ArPeTxZKBufTqCTxRZNs187j13s6E2ggTPZ35Usvxm7+L+TDxDpmNONCjsvkScI5J82vztxfHIeO/l5L3TLBwoyo+qjwYfzIgYgrnoexhwksKzic5vKcbabr6o+kVUl2M4qFH8LhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719700064; c=relaxed/simple;
	bh=PtFS88nmcz30DYT5C7kUK3SHhAweHdS13cFQJXizIQw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UlWnIiMCn9UwCU9168kw5g5zX3EUkZ5fmcEtdLd3/HHlgudcnGt2i0utvrAZ8VFD6yjdUcjRl7tnPidrd5NbMls6KnSWv1HcRbZyodZpivcDoJmvrIZWslHUQlwgVdJSuRCmWaCZfNNtpkvmVzyBX42OevZk7S13GEH8etbjA2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJiKYfPY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3936C2BBFC;
	Sat, 29 Jun 2024 22:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719700064;
	bh=PtFS88nmcz30DYT5C7kUK3SHhAweHdS13cFQJXizIQw=;
	h=From:To:Cc:Subject:Date:From;
	b=PJiKYfPYGWjFy1njUOvwnQR28pH0sSmAJzUnlgjzEMiiVuU3U9AufoktU9DSz+F7H
	 +hxuet9riLKkOwgB05lzr73Fmpab9WgT1HcaisuGOCQ8QOg82rTYE8CNLIlxjXGoHx
	 J2YpJVNxgNH1RPtqsBeUu5hcQqJg+Xlk4pMqp97eH55TyMbgSYo0sxQygFTf8UACee
	 aulbKxtxLhadKwRViUBNvoKIoyUkd7iKGmDqOZKYRzrE/sEA53HDLlj/y/iwo4+pNS
	 w6MnTO3/a4Fq3wJ926fn/TU1kQHp/6Hj4ucK4ayTStJGFlLHYKy5/QV+TMHfKCXQ/6
	 fNA63iKz5LlUA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: bpf@vger.kernel.org
Cc: pablo@netfilter.org,
	kadlec@netfilter.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	lorenzo.bianconi@redhat.com,
	toke@redhat.com,
	fw@strlen.de,
	hawk@kernel.org,
	horms@kernel.org,
	donhunte@redhat.com,
	memxor@gmail.com
Subject: [PATCH v6 bpf-next 0/3] netfilter: Add the capability to offload flowtable in XDP layer
Date: Sun, 30 Jun 2024 00:26:47 +0200
Message-ID: <cover.1719698275.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce bpf_xdp_flow_lookup kfunc in order to perform the lookup of
a given flowtable entry based on the fib tuple of incoming traffic.
bpf_xdp_flow_lookup can be used as building block to offload in XDP
the sw flowtable processing when the hw support is not available.

This series has been tested running the xdp_flowtable_offload eBPF program
on an ixgbe 10Gbps NIC (eno2) in order to XDP_REDIRECT the TCP traffic to
a veth pair (veth0-veth1) based on the content of the nf_flowtable as soon
as the TCP connection is in the established state:

[tcp client] (eno1) == LAN == (eno2) xdp_flowtable_offload [XDP_REDIRECT] --> veth0 == veth1 [tcp server]

table inet filter {
	flowtable ft {
		hook ingress priority filter
		devices = { eno2, veth0 }
	}
	chain forward {
		type filter hook forward priority filter
		meta l4proto { tcp, udp } flow add @ft
	}
}

-  sw flowtable [1 TCP stream, T = 300s]: ~ 6.2 Gbps
- xdp flowtable [1 TCP stream, T = 300s]: ~ 7.6 Gbps

-  sw flowtable [3 TCP stream, T = 300s]: ~ 7.7 Gbps
- xdp flowtable [3 TCP stream, T = 300s]: ~ 8.8 Gbps

Changes since v5:
- remove unused nf_flow_offload_xdp_cancel routine
- add missing __bpf_kfunc_start_defs()/__bpf_kfunc_end_defs()
- remove unused definition
Changes since v4:
- add missing BPF_NO_KFUNC_PROTOTYPES macro to selftest
Changes since v3:
- move flowtable map utilities in nf_flow_table_xdp.c
Changes since v2:
- introduce bpf_flowtable_opts struct in bpf_xdp_flow_lookup signature
- get rid of xdp_flowtable_offload bpf sample
- get rid of test_xdp_flowtable.sh for selftest and rely on prog_tests instead
- rename bpf_xdp_flow_offload_lookup in bpf_xdp_flow_lookup
Changes since v1:
- return NULL in bpf_xdp_flow_offload_lookup kfunc in case of error
- take into account kfunc registration possible failures
Changes since RFC:
- fix compilation error if BTF is not enabled

Florian Westphal (1):
  netfilter: nf_tables: add flowtable map for xdp offload

Lorenzo Bianconi (2):
  netfilter: add bpf_xdp_flow_lookup kfunc
  selftests/bpf: Add selftest for bpf_xdp_flow_lookup kfunc

 include/net/netfilter/nf_flow_table.h         |  15 ++
 net/netfilter/Makefile                        |   7 +-
 net/netfilter/nf_flow_table_bpf.c             | 121 +++++++++++++
 net/netfilter/nf_flow_table_inet.c            |   2 +-
 net/netfilter/nf_flow_table_offload.c         |   2 +-
 net/netfilter/nf_flow_table_xdp.c             | 147 +++++++++++++++
 tools/testing/selftests/bpf/config            |  13 ++
 .../selftests/bpf/prog_tests/xdp_flowtable.c  | 168 ++++++++++++++++++
 .../selftests/bpf/progs/xdp_flowtable.c       | 144 +++++++++++++++
 9 files changed, 616 insertions(+), 3 deletions(-)
 create mode 100644 net/netfilter/nf_flow_table_bpf.c
 create mode 100644 net/netfilter/nf_flow_table_xdp.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_flowtable.c
 create mode 100644 tools/testing/selftests/bpf/progs/xdp_flowtable.c

-- 
2.45.2


