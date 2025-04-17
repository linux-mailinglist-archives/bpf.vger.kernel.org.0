Return-Path: <bpf+bounces-56155-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8EE2A929E1
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 20:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBDEC1663FA
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 18:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCEC254B18;
	Thu, 17 Apr 2025 18:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UHcHEjDN"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886781D07BA;
	Thu, 17 Apr 2025 18:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744915432; cv=none; b=Rssj/WAq9UCjnAIvWvvfOfsipeefsGDVDE7l0BjNRCkS88j0SVhRQ2ge0s2bSL5l8LfrbK8CcJuskwS6QPwH2LPBe75AOf3c9kn2f/dx81z8emQ3NqhjD/lDM+Tn/UKl0oUoQ0YmWMEgWPnnGVAvGBdYSOY2aubbDv5gC+wTnYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744915432; c=relaxed/simple;
	bh=4Wf4cddPliO1/227XJM9I0ZusnnKJaOrUTUevHmuqhM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Qu3r1gydFMY8X08/ej7A1Ws/cDfCoFI4bp0JTrbcc582IWzAYoVLfLXkl2MaxOPjHyshKEjXyP1BZ9Gb82hwTB0wYQutPMEULEgXGUbmevBSiuVHTfrY2SJ53yCZu0WjowE2J1uyYUUkLoosKXh9bE00jcxGTgT1nlDjXlo3eQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UHcHEjDN; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744915427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vg5zFmLWG03eX0vMZyo4RIATZU1L46uJRdK/srxwg2g=;
	b=UHcHEjDN6ZR8xOddEau+gniB+oTlzN6HZs7AhYcqejbOEh6cw1m9ZNXFQ9wwU0MYNlAMZA
	ELwb/t8jJQbIDywNga3AI6t0uFUA2xc3Z7fYroqz5HbsXySMtZNs+L+6JaXIAa7KFkEKMM
	DveTHLoNFYXR3596BdNpemAx7m5qrAs=
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
Subject: pull-request: bpf-next 2025-04-17
Date: Thu, 17 Apr 2025 11:43:37 -0700
Message-ID: <20250417184338.3152168-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net-next* tree.

We've added 12 non-merge commits during the last 9 day(s) which contain
a total of 18 files changed, 1748 insertions(+), 19 deletions(-).

The main changes are:

1) bpf qdisc support, from Amery Hung.
   A qdisc can be implemented in bpf struct_ops programs and
   can be used the same as other existing qdiscs in the
   "tc qdisc" command.

2) Add xsk tail adjustment tests, from Tushar Vyavahare.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Cong Wang, Maciej Fijalkowski, Toke Høiland-Jørgensen

----------------------------------------------------------------

The following changes since commit 0f681b0ecd190fb4516bb34cec227296b10533d1:

  net: ena: Support persistent per-NAPI config. (2025-04-08 12:34:32 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

for you to fetch changes up to fd23ce3eb4a1005bd109977856d12ec0fde7ef75:

  Merge branch 'bpf-qdisc' (2025-04-17 10:54:41 -0700)

----------------------------------------------------------------
bpf-next-for-netdev

----------------------------------------------------------------
Amery Hung (10):
      bpf: Prepare to reuse get_ctx_arg_idx
      bpf: net_sched: Support implementation of Qdisc_ops in bpf
      bpf: net_sched: Add basic bpf qdisc kfuncs
      bpf: net_sched: Add a qdisc watchdog timer
      bpf: net_sched: Support updating bstats
      bpf: net_sched: Disable attaching bpf qdisc to non root
      libbpf: Support creating and destroying qdisc
      selftests/bpf: Add a basic fifo qdisc test
      selftests/bpf: Add a bpf fq qdisc to selftest
      selftests/bpf: Test attaching bpf qdisc to mq and non root

Martin KaFai Lau (2):
      Merge branch 'selftests-xsk-add-tests-for-xdp-tail-adjustment-in-af_xdp'
      Merge branch 'bpf-qdisc'

Tushar Vyavahare (2):
      selftests/xsk: Add packet stream replacement function
      selftests/xsk: Add tail adjustment tests and support check

 include/linux/btf.h                                |   1 +
 kernel/bpf/btf.c                                   |   6 +-
 net/sched/Kconfig                                  |  12 +
 net/sched/Makefile                                 |   1 +
 net/sched/bpf_qdisc.c                              | 461 +++++++++++++
 net/sched/sch_api.c                                |   7 +-
 net/sched/sch_generic.c                            |   3 +-
 tools/lib/bpf/libbpf.h                             |   5 +-
 tools/lib/bpf/netlink.c                            |  20 +-
 tools/testing/selftests/bpf/config                 |   2 +
 tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c | 180 +++++
 .../testing/selftests/bpf/progs/bpf_qdisc_common.h |  31 +
 tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c | 117 ++++
 tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c   | 750 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/xsk_xdp_progs.c  |  50 ++
 tools/testing/selftests/bpf/xsk_xdp_common.h       |   1 +
 tools/testing/selftests/bpf/xskxceiver.c           | 118 +++-
 tools/testing/selftests/bpf/xskxceiver.h           |   2 +
 18 files changed, 1748 insertions(+), 19 deletions(-)
 create mode 100644 net/sched/bpf_qdisc.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c

