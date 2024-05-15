Return-Path: <bpf+bounces-29803-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CD48C6D8C
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 23:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F17611F223C5
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 21:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A04915B134;
	Wed, 15 May 2024 21:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PG8IImBV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44D82F877;
	Wed, 15 May 2024 21:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715807587; cv=none; b=fBUTOFyH/kMPmmZOOx2FtQCuPuRb5QJlraLKgT25KkFI1OEcfaaOqBK4m8X7+2kDFxq18yyRzK8/Pm3Yokl85EDbCg+A8S1tz6Idnqso9znmKfcNYbX3unMeELTTO8munNQ2sKo0IoDUphoQCtXgJgcLyKoGlPZZzx31WNaed2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715807587; c=relaxed/simple;
	bh=+5pn0fNQseGmkdeOb2fvncVa1+iPrrMB4OLD3WVKe2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XcBjhrZ8XcTn/GlQwFNyr2sCp5H1e80QiqW2paJf2rD14VXITvhETjkHb/PUniN2p645yZ5x9HbfzJwmNyQQWt3J0c8AJ/bW8iJ61mee4IPJauaaqGqERBJsV3xcjG2YCcXeHYII6UN706yMr1y+k+pZTQyWrDU6hqjkxAYbWu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PG8IImBV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D6BC116B1;
	Wed, 15 May 2024 21:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715807586;
	bh=+5pn0fNQseGmkdeOb2fvncVa1+iPrrMB4OLD3WVKe2g=;
	h=From:To:Cc:Subject:Date:From;
	b=PG8IImBVtUSOSbWKWpGNUmh2l24TolXbnI9svpFYKV74VzsmrGk1mS+ZtEXdSr11O
	 dtf7PsGac1s0T1EkUbFt67OTAqSnWAfS3RoCDHfs6I6aQvDN6LwQkfIeZ9YCdji1YD
	 Y+GNUBlxlh01j9Dmzhi9RzWsB4U3VKmt8NtYnd7PeD9az+jh2sfhh9siGfJxbwav3B
	 YAvs5uVfBNJyG68Q73IxpLjcq843Fu2sBTV9+6rfQsWx2iOeNVW7W+WzoBDsR4Td1B
	 umKf1w9Or48EN7Plx1vJ7Ch7s1itpXTe1x+eEeXhX348xVQltSabPUzPX/hqhoe+U+
	 v9s8EAEilvsrg==
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
	donhunte@redhat.com
Subject: [PATCH bpf-next 0/4] netfilter: Add the capability to offload flowtable in XDP layer
Date: Wed, 15 May 2024 23:12:53 +0200
Message-ID: <cover.1715807303.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.45.0
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
 net/netfilter/nf_flow_table_bpf.c             |  95 +++
 net/netfilter/nf_flow_table_inet.c            |   2 +
 net/netfilter/nf_flow_table_offload.c         | 161 ++++-
 samples/bpf/Makefile                          |   7 +-
 samples/bpf/xdp_flowtable_offload.bpf.c       | 592 ++++++++++++++++++
 samples/bpf/xdp_flowtable_offload_user.c      | 128 ++++
 tools/testing/selftests/bpf/Makefile          |  10 +-
 tools/testing/selftests/bpf/config            |   4 +
 .../selftests/bpf/progs/xdp_flowtable.c       | 142 +++++
 .../selftests/bpf/test_xdp_flowtable.sh       | 112 ++++
 tools/testing/selftests/bpf/xdp_flowtable.c   | 142 +++++
 13 files changed, 1407 insertions(+), 5 deletions(-)
 create mode 100644 net/netfilter/nf_flow_table_bpf.c
 create mode 100644 samples/bpf/xdp_flowtable_offload.bpf.c
 create mode 100644 samples/bpf/xdp_flowtable_offload_user.c
 create mode 100644 tools/testing/selftests/bpf/progs/xdp_flowtable.c
 create mode 100755 tools/testing/selftests/bpf/test_xdp_flowtable.sh
 create mode 100644 tools/testing/selftests/bpf/xdp_flowtable.c

-- 
2.45.0


