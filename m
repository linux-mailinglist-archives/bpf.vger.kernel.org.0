Return-Path: <bpf+bounces-30836-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 748448D36FD
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 15:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24DFF1F259ED
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 13:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB41D527;
	Wed, 29 May 2024 13:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uZ+lFrTF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD72748D;
	Wed, 29 May 2024 13:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716987884; cv=none; b=LgrYVsCPL/DaANkglgxtiZnhkqTxRPaxBJ+C1am6eTV+TMjVKZ1j9zjRDVqSmik3Lipn48bnw7ysvIqCXkRJ+pJWu9rh33YNjjY9dBKDCKrytGUMpSD1EM7JjX0Rfi7KohbGbATsnbNcxWiA6f6bqaNWnx8bPs4mst/28rqWoCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716987884; c=relaxed/simple;
	bh=/JmrtSSabh4sHnn3D2MtOAexutK1tQy/JLlskSAIqRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t+c4CyfpaPg6h8HOOGTaPbEw2nNTb1VhqWw8ms5F8rpadD9HnWzV2PwWE6UY37N77LA8vl9kvGn7gv18XBlY435mmJnM0tOYb60ehU0swbDrT/jHPSCh0nay4ufqUjnFoWuEknXoWpc0r7H74Y6a3Qy0pEjfBhp+Weosv5e5qAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uZ+lFrTF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E13C2BD10;
	Wed, 29 May 2024 13:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716987883;
	bh=/JmrtSSabh4sHnn3D2MtOAexutK1tQy/JLlskSAIqRQ=;
	h=From:To:Cc:Subject:Date:From;
	b=uZ+lFrTFSo81jbIYXnpRft8oSLDSwRnqrjUXMxrhYOzddRP7vn63GxKldmVieEhMf
	 MOEpU5TFKGqkbDWvlfqQdTuIPJH4oNfQx7jTsTSfARQ7TIwuQnNKkBfmtzddeGiSGR
	 EL2p9F6KquyJjiMQj0DGN/Dk3Nby/2+/K5tLUcbEhSgMnGdjUMDdkjEPLItqcjwjrG
	 yuMWo6EkmTij8EeRvjOFhBFkMY+WKbRY7KdJiCK3kEekPL6Lh7MIPGQfaKUUke90R0
	 9qsbXFWNwVHCdL3KI7lJx0vZ2SPmDgjZbWOs8EO96tHTDTWwbQ2M/iMbWmP7e8PLo+
	 diReGTKG8t0VA==
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
Subject: [PATCH v4 bpf-next 0/3] netfilter: Add the capability to offload flowtable in XDP layer
Date: Wed, 29 May 2024 15:04:29 +0200
Message-ID: <cover.1716987534.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.45.1
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

 include/net/netfilter/nf_flow_table.h         |  18 ++
 net/netfilter/Makefile                        |   7 +-
 net/netfilter/nf_flow_table_bpf.c             | 117 ++++++++++++
 net/netfilter/nf_flow_table_inet.c            |   2 +-
 net/netfilter/nf_flow_table_offload.c         |   6 +-
 net/netfilter/nf_flow_table_xdp.c             | 163 +++++++++++++++++
 tools/testing/selftests/bpf/config            |  13 ++
 .../selftests/bpf/prog_tests/xdp_flowtable.c  | 168 ++++++++++++++++++
 .../selftests/bpf/progs/xdp_flowtable.c       | 145 +++++++++++++++
 9 files changed, 635 insertions(+), 4 deletions(-)
 create mode 100644 net/netfilter/nf_flow_table_bpf.c
 create mode 100644 net/netfilter/nf_flow_table_xdp.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_flowtable.c
 create mode 100644 tools/testing/selftests/bpf/progs/xdp_flowtable.c

-- 
2.45.1


