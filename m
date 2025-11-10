Return-Path: <bpf+bounces-74111-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5C7C49BD0
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 00:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 43C8B34B8AD
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 23:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89356302165;
	Mon, 10 Nov 2025 23:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MWHIysfd"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA972BE7B8;
	Mon, 10 Nov 2025 23:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762817083; cv=none; b=XKVoGNp499/LJjfWhuqzC03AszeedyIJjJ0I37OFpNfwlz1Cgnt1vnKLpl5rXcIAP72hXEcQcII7R3fnaNtWQYu8RXEH+bW7No975d1gaE3pGKBYA3r2xx8x9LtT4aei1nk59+S4kr6IvLyAiVYNRrBTvpHfzSyaqMra9zDZ4cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762817083; c=relaxed/simple;
	bh=r80tioTPhyY4lMUANBvsimcxmwecLhqiQRn8QWgg34A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y/XYmy/2R1qWfxL3LdKSSTVVGHa7Bhst4YWnwBMPF1iTBE7Aw4ayy2SdVGC1Rw1B7TVmoN6vQLIAkZ85EOIsQmdCCPQ2/yvzFFeN1HFcTCQqOIOe2QbPMA5e1Om8qDkmhxWDGn8x0lhGBW+UwISGDMlwsS3qrmrfiHRtVoERX1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MWHIysfd; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762817079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wCp3LiSgZlPvERLktapqB6xCrsEYOIYu9wujYyjr0Wg=;
	b=MWHIysfdVhIalz/j2hU9CVyf2umDZZUkNR3ejd06t8y6qyX+z9lZsw16XTtrz37Lv2kfP7
	v8GAgOkbQntyQTOwOHuwn/ijNsYpUpisTBFaRA72g8yuduET2bkBjyllieQzZ2Yi+21UN2
	o2NLcfWbQI5MwH5mLKJDwTEWZZ26KNk=
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
Subject: pull-request: bpf-next 2025-11-10
Date: Mon, 10 Nov 2025 15:24:27 -0800
Message-ID: <20251110232427.3929291-1-martin.lau@linux.dev>
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

We've added 19 non-merge commits during the last 3 day(s) which contain
a total of 22 files changed, 1345 insertions(+), 197 deletions(-).

The main changes are:

1) Preserve skb metadata after a TC BPF program has changed the skb,
   from Jakub Sitnicki.
   This allows a TC program at the end of a TC filter chain to still see
   the skb metadata, even if another TC program at the front of the chain
   has changed the skb using BPF helpers.

2) Initial af_smc bpf_struct_ops support to control the smc specific
   syn/synack options, from D. Wythe.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Dust Li, Saket Kumar Bhaskar, Zhu Yanjun

----------------------------------------------------------------

The following changes since commit a0c3aefb08cd81864b17c23c25b388dba90b9dad:

  Merge branch '40GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue (2025-11-07 19:15:36 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

for you to fetch changes up to 67f4cfb530150387dedc13bac7e2ab7f1a525d7f:

  Merge branch 'net-smc-introduce-smc_hs_ctrl' (2025-11-10 12:00:47 -0800)

----------------------------------------------------------------
bpf-next-for-netdev

----------------------------------------------------------------
D. Wythe (3):
      bpf: Export necessary symbols for modules with struct_ops
      net/smc: bpf: Introduce generic hook for handshake flow
      bpf/selftests: Add selftest for bpf_smc_hs_ctrl

Jakub Sitnicki (16):
      net: Helper to move packet data and metadata after skb_push/pull
      net: Preserve metadata on pskb_expand_head
      bpf: Unclone skb head on bpf_dynptr_write to skb metadata
      vlan: Make vlan_remove_tag return nothing
      bpf: Make bpf_skb_vlan_pop helper metadata-safe
      bpf: Make bpf_skb_vlan_push helper metadata-safe
      bpf: Make bpf_skb_adjust_room metadata-safe
      bpf: Make bpf_skb_change_proto helper metadata-safe
      bpf: Make bpf_skb_change_head helper metadata-safe
      selftests/bpf: Verify skb metadata in BPF instead of userspace
      selftests/bpf: Dump skb metadata on verification failure
      selftests/bpf: Expect unclone to preserve skb metadata
      selftests/bpf: Cover skb metadata access after vlan push/pop helper
      selftests/bpf: Cover skb metadata access after bpf_skb_adjust_room
      selftests/bpf: Cover skb metadata access after change_head/tail helper
      selftests/bpf: Cover skb metadata access after bpf_skb_change_proto

Martin KaFai Lau (2):
      Merge branch 'make-tc-bpf-helpers-preserve-skb-metadata'
      Merge branch 'net-smc-introduce-smc_hs_ctrl'

 include/linux/filter.h                             |   9 +
 include/linux/if_vlan.h                            |  13 +-
 include/linux/skbuff.h                             |  75 ++++
 include/net/netns/smc.h                            |   3 +
 include/net/smc.h                                  |  53 +++
 kernel/bpf/bpf_struct_ops.c                        |   2 +
 kernel/bpf/helpers.c                               |   6 +-
 kernel/bpf/syscall.c                               |   1 +
 net/core/filter.c                                  |  34 +-
 net/core/skbuff.c                                  |   6 +-
 net/ipv4/tcp_output.c                              |  31 +-
 net/smc/Kconfig                                    |  10 +
 net/smc/Makefile                                   |   1 +
 net/smc/af_smc.c                                   |   9 +
 net/smc/smc_hs_bpf.c                               | 140 ++++++++
 net/smc/smc_hs_bpf.h                               |  31 ++
 net/smc/smc_sysctl.c                               |  91 +++++
 tools/testing/selftests/bpf/config                 |   5 +
 .../selftests/bpf/prog_tests/test_bpf_smc.c        | 390 +++++++++++++++++++++
 .../bpf/prog_tests/xdp_context_test_run.c          | 129 ++++---
 tools/testing/selftests/bpf/progs/bpf_smc.c        | 117 +++++++
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 386 ++++++++++++++------
 22 files changed, 1345 insertions(+), 197 deletions(-)
 create mode 100644 net/smc/smc_hs_bpf.c
 create mode 100644 net/smc/smc_hs_bpf.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_bpf_smc.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_smc.c

