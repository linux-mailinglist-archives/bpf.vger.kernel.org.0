Return-Path: <bpf+bounces-44865-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 718159C9340
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2024 21:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A6F81F22E0B
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2024 20:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1321AC8B8;
	Thu, 14 Nov 2024 20:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XURbVFyk"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D501AAE1D
	for <bpf@vger.kernel.org>; Thu, 14 Nov 2024 20:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731616131; cv=none; b=IxBzl1Ruvn3FbIBxdLiSk/stB0fm345Nkc8l0bQIslpBbPu5lUy3BRuBjDVFYNHZxKSSm9ZjDIxRDi361wb1Rp34BnT28ORTcQt2w9KMTKUOYMD7q5/UVI//xt3w2qwLdgh4Ia2iPP0sk6gV2ESyRe4IkLeZUKTDMa/HPCEQpfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731616131; c=relaxed/simple;
	bh=Z5Ognq7lw2HAWunqOpKCdPtwBarj4MBAdsTm07h6Sos=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BM8W88fmXn2oh5Fnkb9MJJOvFfYd8kkoywk4idCdU2x9fdM2BrwVlfygYQgH60oeSj3GUhvoX7wuI6O+tZLeK/S7ZVUyD5FrZ4ITiZ+1kRmR86CcGdmnmeOiT2A5x6+1ZumQVGh0SXo4/3ydwJoVyl5qDS7a0BYkIjjTvGSPYBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XURbVFyk; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731616127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MhTsEtmVCd4GgZxWQiL5bXWykf/c3mGt0T84SKQe0zA=;
	b=XURbVFyk+V6UTjHBbCM5/jiUQmCKw1whf00ppWm5USjUROjshXMj7Wg+kYPXnC0+OcaFli
	uPO2bd0a7lywnfNuk3SVkZjwEF4m6ahuVPr7nU5rLrAEdo2goKbD3csL4mNyvlqiyLvDJL
	q2r0oeAuY0kQk5HuGv6A/1ViyQDsehM=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: davem@davemloft.net
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	martin.lau@linux.dev,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: pull-request: bpf-next 2024-11-14
Date: Thu, 14 Nov 2024 12:28:32 -0800
Message-ID: <20241114202832.3187927-1-martin.lau@linux.dev>
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

We've added 9 non-merge commits during the last 4 day(s) which contain
a total of 3 files changed, 226 insertions(+), 84 deletions(-).

The main changes are:

1) Fixes to bpf_msg_push/pop_data and test_sockmap. The changes has
   dependency on the other changes in the bpf-next/net branch,
   from Zijian Zhang.

2) Drop netns codes from mptcp test. Reuse the common helpers in
   test_progs, from Geliang Tang.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

John Fastabend, Matthieu Baerts (NGI0)

----------------------------------------------------------------

The following changes since commit 8d1807a95c7dbb9633817fba776fa2f5e7c5146b:

  Merge branch 'mlx5-misc-patches-2024-10-31' (2024-11-03 15:37:17 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git for-netdev

for you to fetch changes up to 141b4d6a8049cecdc8124f87e044b83a9e80730d:

  Merge branch 'Fixes to bpf_msg_push/pop_data and test_sockmap' (2024-11-06 16:02:08 -0800)

----------------------------------------------------------------
bpf-next-for-netdev

----------------------------------------------------------------
Geliang Tang (1):
      selftests/bpf: Drop netns helpers in mptcp

Martin KaFai Lau (1):
      Merge branch 'Fixes to bpf_msg_push/pop_data and test_sockmap'

Zijian Zhang (8):
      selftests/bpf: Add txmsg_pass to pull/push/pop in test_sockmap
      selftests/bpf: Fix SENDPAGE data logic in test_sockmap
      selftests/bpf: Fix total_bytes in msg_loop_rx in test_sockmap
      selftests/bpf: Add push/pop checking for msg_verify_data in test_sockmap
      selftests/bpf: Add more tests for test_txmsg_push_pop in test_sockmap
      bpf, sockmap: Several fixes to bpf_msg_push_data
      bpf, sockmap: Several fixes to bpf_msg_pop_data
      bpf, sockmap: Fix sk_msg_reset_curr

 net/core/filter.c                              |  88 +++++++-----
 tools/testing/selftests/bpf/prog_tests/mptcp.c |  42 ++----
 tools/testing/selftests/bpf/test_sockmap.c     | 180 ++++++++++++++++++++++---
 3 files changed, 226 insertions(+), 84 deletions(-)

