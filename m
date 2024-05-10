Return-Path: <bpf+bounces-29475-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F96E8C262F
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 16:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18492B21968
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 14:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCFF12C814;
	Fri, 10 May 2024 14:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bb6wNfsP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2337127B73;
	Fri, 10 May 2024 14:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715349705; cv=none; b=mb2lmaBq93yX1QQVq+FuGvPHhN6+5pt7SnXTk4q2fqRo/I3xBKG+Nhqcejyam6BFu9E4suVqv7LrYS2/PAeO+Qw6APN7I6OhPM/W5wx4qITR4SIP25p+IEkgv8KkGev9QFVS9jpv7MLEpghALzHL2gsQ6PbiVsbDe0JjV8dtNaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715349705; c=relaxed/simple;
	bh=QCptGrRqFhwfmyWBeIqXw+7grUpksZBFVOpjvtwDSFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HRcT9kIkSga8TnoeAn1tAFLwNuEd/9WZ9f4fjY1RBuSxDJIPAebM76IiS/AhMeFkHysZBkyomENBllyK8mtn09OIhMzwC2ccMlRgbumPtbt2f4x/Sbc6FhdMdNSmRRp62MDMK+IqK/si0uYgWvVmEflvU1RLlQ6u1gFYz0pviTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bb6wNfsP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBCF1C113CC;
	Fri, 10 May 2024 14:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715349705;
	bh=QCptGrRqFhwfmyWBeIqXw+7grUpksZBFVOpjvtwDSFQ=;
	h=From:To:Cc:Subject:Date:From;
	b=bb6wNfsPMJjEy6J0tOcNYmLf1xZhMhr55ngSvyx0jJtYVuhy/GUoFj+OU0IgmlhLS
	 Er4aYL/sGgQ3QW88JDbqJYIwRtC8YzETr3YKs2Io4QtL6BMZYozTTwnQrzhkVWD09z
	 K5m90E1IKghXvIikM2Q5SOAXUcsH1wQqjUBSxrKGt4izS6XeVZRF+eTYksyT7jgCTY
	 4MHFK98GfVgeRKrSzeiymNUje8xfq+Ud2vzAmn7OKJNVvlhdVflhnXzp50abiRuTKl
	 dckLTevTAVHaJcA98/+zyyHzjSMgIyYpbjObOMosJv6fYoqKnm7Af/mQXo3nqon/2I
	 uZoS5JIsDtsaQ==
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
Subject: [RFC bpf-next v1 0/4] netfilter: Add the capability to offload flowtable in XDP layer
Date: Fri, 10 May 2024 16:01:23 +0200
Message-ID: <cover.1715348200.git.lorenzo@kernel.org>
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

Florian Westphal (1):
  netfilter: nf_tables: add flowtable map for xdp offload

Lorenzo Bianconi (3):
  netfilter: add bpf_xdp_flow_offload_lookup kfunc
  samples/bpf: Add bpf sample to offload flowtable traffic to xdp
  selftests/bpf: Add selftest for bpf_xdp_flow_offload_lookup kfunc

 include/net/netfilter/nf_flow_table.h         |  11 +
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
 13 files changed, 1406 insertions(+), 5 deletions(-)
 create mode 100644 net/netfilter/nf_flow_table_bpf.c
 create mode 100644 samples/bpf/xdp_flowtable_offload.bpf.c
 create mode 100644 samples/bpf/xdp_flowtable_offload_user.c
 create mode 100644 tools/testing/selftests/bpf/progs/xdp_flowtable.c
 create mode 100755 tools/testing/selftests/bpf/test_xdp_flowtable.sh
 create mode 100644 tools/testing/selftests/bpf/xdp_flowtable.c

-- 
2.45.0


