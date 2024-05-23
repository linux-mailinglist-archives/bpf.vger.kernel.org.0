Return-Path: <bpf+bounces-30384-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7828CD1C2
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 14:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CB961C21011
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 12:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8353813C688;
	Thu, 23 May 2024 12:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNJcSTxU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F294E13B5B0;
	Thu, 23 May 2024 12:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716465990; cv=none; b=gzT3qb9syDQq1irTsMGqyMeYez8gOXvmUC7lSzy/n5VizY6O9gKqGDospITizaBbLfhx/orDwgkNjeAUwqImdpapHWSA3dI7PRzBQOekYJmxfFoza9sJFHWDngQN3XI1JCzGDkqotWbBr2TIySd/cj3VPJEi9+XkzSbh6JvPvhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716465990; c=relaxed/simple;
	bh=32RUCdj43ocdMDqq7keOomYt+BgvvmixO708yHMa+eQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VQ3+/6piLWLskZ8lx/aoJbo1zau3Jt/GAtrvaNGcmZQem5ci9lrfk46evOpw82fEUfSqU6qVz6HxzU+1OnFAOH5DNOLZULhp3Vt4MxWfB7UZ3Oz/gs9JU2I5L+Elsaa375PHATfJmnnUU8EW8h30bhk4A2OgYcPP3Glg8rkcrfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNJcSTxU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D84EC2BD10;
	Thu, 23 May 2024 12:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716465989;
	bh=32RUCdj43ocdMDqq7keOomYt+BgvvmixO708yHMa+eQ=;
	h=From:To:Cc:Subject:Date:From;
	b=KNJcSTxUu8K+ogmrX8Cx/Yhk5Yw6kqXODXQkaS/j9ASQMUE25BtMSJJrR7F87kY8Z
	 /aoIAd0HUOj+kK+Mhk/9dP92Z+HUOj/yTYFo8REhN/rWj5aPb0N7KXop4QdmEy6m2v
	 kah62sRA9gOrAP0MnGiIftmzgF2BUxc2yUa94jbZKIWPOc7d7SDIWeHbkDqTbtZF2G
	 vE15jKe4aY/JOrAZ76GVURi+M7iMjpWQCKImJSDSBSzLD8GgGSbdLkLOzf0kFk/agq
	 42bpGp8PfmPPiRvcT7X1PKfmyGT0AUEn1YkzlGtM/ItYZjRKwEBvt8+dvnXzCvfAWr
	 jciEirHymfpOA==
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
Subject: [PATCH v3 bpf-next 0/3] netfilter: Add the capability to offload flowtable in XDP layer
Date: Thu, 23 May 2024 14:06:15 +0200
Message-ID: <cover.1716465377.git.lorenzo@kernel.org>
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

 include/net/netfilter/nf_flow_table.h         |  12 ++
 net/netfilter/Makefile                        |   5 +
 net/netfilter/nf_flow_table_bpf.c             | 117 ++++++++++++
 net/netfilter/nf_flow_table_inet.c            |   2 +-
 net/netfilter/nf_flow_table_offload.c         | 161 ++++++++++++++++-
 tools/testing/selftests/bpf/config            |  13 ++
 .../selftests/bpf/prog_tests/xdp_flowtable.c  | 168 ++++++++++++++++++
 .../selftests/bpf/progs/xdp_flowtable.c       | 145 +++++++++++++++
 8 files changed, 620 insertions(+), 3 deletions(-)
 create mode 100644 net/netfilter/nf_flow_table_bpf.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_flowtable.c
 create mode 100644 tools/testing/selftests/bpf/progs/xdp_flowtable.c

-- 
2.45.1


