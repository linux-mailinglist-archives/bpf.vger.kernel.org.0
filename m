Return-Path: <bpf+bounces-30004-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B6E8C9053
	for <lists+bpf@lfdr.de>; Sat, 18 May 2024 12:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0A46B211D2
	for <lists+bpf@lfdr.de>; Sat, 18 May 2024 10:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8E21BC4B;
	Sat, 18 May 2024 10:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THRL/g9R"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD708BE2;
	Sat, 18 May 2024 10:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716027202; cv=none; b=tWzarlg+RpUzdgAnZPKnqMlA3Kwdpba2WSt1DdCet/7mvjhF/gp/btEPn5aWSx2K2i4l4aG06F5QjjljrZK6GM5O/a6AMnBCZJ0LpJWtAgxh71B10MklA5Yej+kQCWM3tyZBLQxpROLiQfZzP9FYB0VorGtIY0qs+9+vxaE1904=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716027202; c=relaxed/simple;
	bh=mfl9Go0rRSr5015FRhkOtNWa4A3p3T/8H/Aem5VSDGI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J6aoP/3Q/NKv/4fqrs9HUOSXmJNoDOcuO+/Ewr7+g6tANXCratzcr67SzEkV7gG+3Iw7tOfIvZHiKSMZksohl/ZikB7J+XExxtio3+Etx+kgpMAOlvfVlqLUhqo19FdY8X+hrvajR7hhRCmJ1nd2aCMXB3UUFfPPNCgP7p+7370=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THRL/g9R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD56C113CC;
	Sat, 18 May 2024 10:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716027202;
	bh=mfl9Go0rRSr5015FRhkOtNWa4A3p3T/8H/Aem5VSDGI=;
	h=From:To:Cc:Subject:Date:From;
	b=THRL/g9ReJiyoNn5SGViN3KKyzZSE+zayercVkDnmCvZxX2t6Q2W1gSxvFJ2mpvd7
	 KMXiYa1MEDqF2Hs48jou3CGm7g1ptYcFtwziGeQwGQ0ijCreaQpy9de/CAfvpBxGSF
	 P8ouk4Hm9NS+UM1pQ5+jH8ypMy0FL+/wwcI8gInbKWMYRK3Yjv6rn4qLP+kvU2q15c
	 GqmyksKM9R8r/y4JTFmaCn5PQIQ24S0xFTDr6SgSWP8qKa1AN2E0kHex1xmOMSz9Bl
	 i3grsEwFn8E0is5GPaSaRF37b7S6/OBr4qK1a3xjKVFyDfzzge9TOgHYqc6vrYHYES
	 H/83zg5zXqtyQ==
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
	lorenzo.bianconi@redhat.com,
	toke@redhat.com,
	fw@strlen.de,
	hawk@kernel.org,
	horms@kernel.org,
	donhunte@redhat.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 0/4] netfilter: Add the capability to offload flowtable in XDP layer
Date: Sat, 18 May 2024 12:12:34 +0200
Message-ID: <cover.1716026761.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce bpf_xdp_flow_offload_lookup kfunc in order to perform the
lookup of a given flowtable entry based on the fib tuple of incoming
traffic.
bpf_xdp_flow_offload_lookup can be used as building block to offload
in XDP the sw flowtable processing when the hw support is not available.

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

Changes since v1:
- return NULL in bpf_xdp_flow_offload_lookup kfunc in case of error
- take into account kfunc registration possible failures
Changes since RFC:
- fix compilation error if BTF is not enabled

Florian Westphal (1):
  netfilter: nf_tables: add flowtable map for xdp offload

Lorenzo Bianconi (3):
  netfilter: add bpf_xdp_flow_offload_lookup kfunc
  samples/bpf: Add bpf sample to offload flowtable traffic to xdp
  selftests/bpf: Add selftest for bpf_xdp_flow_offload_lookup kfunc

 include/net/netfilter/nf_flow_table.h         |  12 +
 net/netfilter/Makefile                        |   5 +
 net/netfilter/nf_flow_table_bpf.c             |  94 +++
 net/netfilter/nf_flow_table_inet.c            |   2 +-
 net/netfilter/nf_flow_table_offload.c         | 161 ++++-
 samples/bpf/Makefile                          |   7 +-
 samples/bpf/xdp_flowtable_offload.bpf.c       | 591 ++++++++++++++++++
 samples/bpf/xdp_flowtable_offload_user.c      | 128 ++++
 tools/testing/selftests/bpf/Makefile          |  10 +-
 tools/testing/selftests/bpf/config            |   4 +
 .../selftests/bpf/progs/xdp_flowtable.c       | 141 +++++
 .../selftests/bpf/test_xdp_flowtable.sh       | 112 ++++
 tools/testing/selftests/bpf/xdp_flowtable.c   | 142 +++++
 13 files changed, 1403 insertions(+), 6 deletions(-)
 create mode 100644 net/netfilter/nf_flow_table_bpf.c
 create mode 100644 samples/bpf/xdp_flowtable_offload.bpf.c
 create mode 100644 samples/bpf/xdp_flowtable_offload_user.c
 create mode 100644 tools/testing/selftests/bpf/progs/xdp_flowtable.c
 create mode 100755 tools/testing/selftests/bpf/test_xdp_flowtable.sh
 create mode 100644 tools/testing/selftests/bpf/xdp_flowtable.c

-- 
2.45.1


