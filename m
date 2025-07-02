Return-Path: <bpf+bounces-62121-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E41FAF5BE5
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 16:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E0201895AEF
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 14:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BAB30AAD9;
	Wed,  2 Jul 2025 14:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/fvOfLn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8810D30AAC3;
	Wed,  2 Jul 2025 14:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751468298; cv=none; b=Nt14NPAW8AQcIbvKQDyIpQJO2GRzpPC14bS9HAjJYAYmrQ/iijxsAQ2C3JRwR2xC63APwUcl3/JptQ4PlOwuvPjMTjCNu5glaB7WJp9zXM36twFEyxRBABVRHRrKWhtYN74zTjUWk7IRPg69jHZWIRmnM85vipsch1nz4Io3uSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751468298; c=relaxed/simple;
	bh=2HtvpdknLcJGK7pMASC/gnPCo3BIfqDcGzsSm6pwrbE=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=aLeqtPChHZbhy4GlMhJVFLEbi3AqUfqn7mlf2Gz2M31J+XDBNQXEfXnUyVGgVDH5F4J/P+hLkNNDGhJ78M/jqNlLJCbqMp2tHyFr3t4bMe9uOvmBPZVjh9LA+s96C5g0r8ldY1IfJoKj5I7yGpV+l9iY23VyuJuClsRCnNztSXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/fvOfLn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9158BC4CEE7;
	Wed,  2 Jul 2025 14:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751468298;
	bh=2HtvpdknLcJGK7pMASC/gnPCo3BIfqDcGzsSm6pwrbE=;
	h=Subject:From:To:Cc:Date:From;
	b=c/fvOfLnt/ZiYz51pY94OSLS/BLJUnSNgT+0MJtpFFpgeE40eK0WfancXzbDxMcSg
	 qtt1E9fpLRs1dkkK+xz78HSudxmwGeuptEqKIn6aliPoNowV6eA9tkX7utBcQGEHs/
	 w5Sb+iDVRQf4/rIhYWkvspy1112NUOa0Hu930L9WPXHJFkw94GVC2KNbHgpByNyh2M
	 THE3ps4nwml5XXcFNv3MyHUtF6upbsG9zrov9qFXWCkBTwvVW8Lr09aJ7vi2PfSpUn
	 VpxqZeDB6kBqHL/vR035b0vhScml89OyZuehXkt5krHPqLDUFeOU+zGsqI25D1wWuc
	 MScwygnpq0q6A==
Subject: [PATCH bpf-next V2 0/7] xdp: Allow BPF to set RX hints for
 XDP_REDIRECTed packets
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, lorenzo@kernel.org
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <borkmann@iogearbox.net>,
 Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 sdf@fomichev.me, kernel-team@cloudflare.com, arthur@arthurfabre.com,
 jakub@cloudflare.com
Date: Wed, 02 Jul 2025 16:58:12 +0200
Message-ID: <175146824674.1421237.18351246421763677468.stgit@firesoul>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

This patch series introduces a mechanism for an XDP program to store RX
metadata hints - specifically rx_hash, rx_vlan_tag, and rx_timestamp -
into the xdp_frame. These stored hints are then used to populate the
corresponding fields in the SKB that is created from the xdp_frame
following an XDP_REDIRECT.

The chosen RX metadata hints intentionally map to the existing NIC
hardware metadata that can be read via kfuncs [1]. While this design
allows a BPF program to read and propagate existing hardware hints, our
primary motivation is to enable setting custom values. This is important
for use cases where the hardware-provided information is insufficient or
needs to be calculated based on packet contents unavailable to the
hardware.

The primary motivation for this feature is to enable scalable load
balancing of encapsulated tunnel traffic at the XDP layer. When tunnelled
packets (e.g., IPsec, GRE) are redirected via cpumap or to a veth device,
the networking stack later calculates a software hash based on the outer
headers. For a single tunnel, these outer headers are often identical,
causing all packets to be assigned the same hash. This collapses all
traffic onto a single RX queue, creating a performance bottleneck and
defeating receive-side scaling (RSS).

Our immediate use case involves load balancing IPsec traffic. For such
tunnelled traffic, any hardware-provided RX hash is calculated on the
outer headers and is therefore incorrect for distributing inner flows.
There is no reason to read the existing value, as it must be recalculated.
In our XDP program, we perform a partial decryption to access the inner
headers and calculate a new load-balancing hash, which provides better
flow distribution. However, without this patch set, there is no way to
persist this new hash for the network stack to use post-redirect.

This series solves the problem by introducing new BPF kfuncs that allow an
XDP program to write e.g. the hash value into the xdp_frame. The
__xdp_build_skb_from_frame() function is modified to use this stored value
to set skb->hash on the newly created SKB. As a result, the veth driver's
queue selection logic uses the BPF-supplied hash, achieving proper
traffic distribution across multiple CPU cores. This also ensures that
consumers, like the GRO engine, can operate effectively.

We considered XDP traits as an alternative to adding static members to
struct xdp_frame. Given the immediate need for this functionality and the
current development status of traits, we believe this approach is a
pragmatic solution. We are open to migrating to a traits-based
implementation if and when they become a generally accepted mechanism for
such extensions.

[1] https://docs.kernel.org/networking/xdp-rx-metadata.html
---
V1: https://lore.kernel.org/all/174897271826.1677018.9096866882347745168.stgit@firesoul/

Jesper Dangaard Brouer (2):
      selftests/bpf: Adjust test for maximum packet size in xdp_do_redirect
      net: xdp: update documentation for xdp-rx-metadata.rst

Lorenzo Bianconi (5):
      net: xdp: Add xdp_rx_meta structure
      net: xdp: Add kfuncs to store hw metadata in xdp_buff
      net: xdp: Set skb hw metadata from xdp_frame
      net: veth: Read xdp metadata from rx_meta struct if available
      bpf: selftests: Add rx_meta store kfuncs selftest


 Documentation/networking/xdp-rx-metadata.rst  |  77 ++++++--
 drivers/net/veth.c                            |  12 ++
 include/net/xdp.h                             | 134 ++++++++++++--
 net/core/xdp.c                                | 107 ++++++++++-
 net/xdp/xsk_buff_pool.c                       |   4 +-
 .../bpf/prog_tests/xdp_do_redirect.c          |   6 +-
 .../selftests/bpf/prog_tests/xdp_rxmeta.c     | 166 ++++++++++++++++++
 .../selftests/bpf/progs/xdp_rxmeta_receiver.c |  44 +++++
 .../selftests/bpf/progs/xdp_rxmeta_redirect.c |  43 +++++
 9 files changed, 558 insertions(+), 35 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_rxmeta.c
 create mode 100644 tools/testing/selftests/bpf/progs/xdp_rxmeta_receiver.c
 create mode 100644 tools/testing/selftests/bpf/progs/xdp_rxmeta_redirect.c

--


