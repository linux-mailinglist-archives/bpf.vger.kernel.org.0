Return-Path: <bpf+bounces-53536-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC381A56072
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 06:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B55E63AC5B8
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 05:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678211990C3;
	Fri,  7 Mar 2025 05:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QnL6+z1i"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C0E1922C6
	for <bpf@vger.kernel.org>; Fri,  7 Mar 2025 05:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741326829; cv=none; b=ZT7UvmRHf9ETwLp/OABlZ4InyryOmMAOEZZkq1IOldtHZEcrINMvYSocX1/2C3SCOFVa/v604DM86uiymojJZmG499qOZvKnupmQGR6kL1qbnlNWNywCgDPmdSMbc9epVYG+zXdA0EvU3ItoGb8di36Ott4fONeLZjsCpsZiuuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741326829; c=relaxed/simple;
	bh=aQfYG8FZfpWlzffLnVm2Nnolyf9dIHwOFtO9wBCaqVg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JWbsFq8m5suCCRONuRk7gHHNa63168Q9QKu9IX+oBYpTI+ekpv7SY2ZNJ5euvye5OOhHo6ZgFfIAYx8ZegMQtQhW/wuQa3IRTGCvA7rvZ1hHWaR9bm4tU0+pWUqfSWSzfT5iFyQuW00YeOPtpxCoDIrhK94na9B+ChoB4Abd7M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QnL6+z1i; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741326824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=V9+iyQSEK0VITh9i3aNT5fQhLH5irNd+SUG9IphFoss=;
	b=QnL6+z1ilyWcymF6bNFt3iTsdtgNFESdli83oAiHgPZIo634y2NZGnMo90nM5Ry0dBGMEh
	xivkNI0Rw2c6tD7L/A2KT7hqbw+7Xw/lIYM5W7OpE1qNcjtEMBP8oObEOuSDfQ9pCg55Gu
	FFGxSMUCadsz7LqECHlWSRL7r54Pd/g=
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
Subject: pull-request: bpf-next 2025-03-06
Date: Thu,  6 Mar 2025 21:53:35 -0800
Message-ID: <20250307055335.441298-1-martin.lau@linux.dev>
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

We've added 6 non-merge commits during the last 13 day(s) which contain
a total of 6 files changed, 230 insertions(+), 56 deletions(-).

The main changes are:

1) Add XDP metadata support for tun driver, from Marcus Wichelmann.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Jason Wang, Willem de Bruijn

----------------------------------------------------------------

The following changes since commit b66e19dcf684b21b6d3a1844807bd1df97ad197a:

  Merge branch 'mctp-add-mctp-over-usb-hardware-transport-binding' (2025-02-21 16:45:26 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

for you to fetch changes up to 72aad21de5f65bea60c3064ad463b3793fb4b1c6:

  Merge branch 'xdp-metadata-support-for-tun-driver' (2025-03-06 12:31:09 -0800)

----------------------------------------------------------------
bpf-next-for-netdev

----------------------------------------------------------------
Marcus Wichelmann (6):
      net: tun: Enable XDP metadata support
      net: tun: Enable transfer of XDP metadata to skb
      selftests/bpf: Move open_tuntap to network helpers
      selftests/bpf: Refactor xdp_context_functional test and bpf program
      selftests/bpf: Add test for XDP metadata support in tun driver
      selftests/bpf: Fix file descriptor assertion in open_tuntap helper

Martin KaFai Lau (1):
      Merge branch 'xdp-metadata-support-for-tun-driver'

 drivers/net/tun.c                                  |  28 +++-
 tools/testing/selftests/bpf/network_helpers.c      |  28 ++++
 tools/testing/selftests/bpf/network_helpers.h      |   3 +
 .../testing/selftests/bpf/prog_tests/lwt_helpers.h |  29 -----
 .../bpf/prog_tests/xdp_context_test_run.c          | 145 ++++++++++++++++++++-
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  |  53 +++++---
 6 files changed, 230 insertions(+), 56 deletions(-)

