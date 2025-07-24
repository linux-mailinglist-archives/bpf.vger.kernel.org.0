Return-Path: <bpf+bounces-64292-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA32B11062
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 19:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 865CC17BE0C
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 17:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905172EB5AA;
	Thu, 24 Jul 2025 17:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b5pfyYom"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E9B7080E
	for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 17:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753378409; cv=none; b=ou1dZVaO+WRnoQt48aSU/by7TlfH17iDMii5x3CSWGo4dECU4Wu6FX9a9xY7T6UNg90ChD3QIXzAv1PcdZ8ZF/nJsGPLJYNvlns48AAYA+2iAKTPJqcJwCBYRHADknWrs2QL7HNEugqsBzlW3fhH06NtV0oXcBFJCR9tFt3x0t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753378409; c=relaxed/simple;
	bh=AYPuPRueMTtTDDvyhBdbWXHwLNm6A4WjXLn678ZxEnM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H+HXeP4jLjlB1TODsyBa4DXj1RfCKoP4rs6ztAe/fD6YEdZL2ISn3nNaU39GsUhmMqQhao3mpiKqmR5UVJJ0K4ITXTg5a/1eENR0Z2YnsdrcroeAYvDNc445PvSHhKTarcA9qks3s0mI7mGP/ogyCAy2fE+rVfCFbfNbDf/PPGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b5pfyYom; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753378394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KaAaOR/yrj9esdeBVvnwEmdJzS/QjSBjfQooYj1qkVs=;
	b=b5pfyYomEGRanjVOGJx60yrqPMDF7ZOz54QlGoOxjd5q6b2mC1xP0ZgW1NhAnNWR+bIXRT
	cQdI3NCeJgoQJjw5OMu+5kekzODys9m7iMlr/srEKQ+lF9MtK/BJWHrVeSzKMfk46+W0cy
	DgkTnaAemoxuip36yLPCNdKTGWujddo=
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
Subject: pull-request: bpf-next 2025-07-24
Date: Thu, 24 Jul 2025 10:33:06 -0700
Message-ID: <20250724173306.3578483-1-martin.lau@linux.dev>
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

We've added 3 non-merge commits during the last 3 day(s) which contain
a total of 4 files changed, 40 insertions(+), 15 deletions(-).

The main changes are:

1) Improved verifier error message for incorrect narrower load from
   pointer field in ctx, from Paul Chaignon.

2) Disabled migration in nf_hook_run_bpf to address a syzbot report,
   from Kuniyuki Iwashima.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Eduard Zingerman, Florian Westphal

----------------------------------------------------------------

The following changes since commit dd500e4aecf25e48e874ca7628697969df679493:

  net: usb: Remove duplicate assignments for net->pcpu_stat_type (2025-07-21 10:43:07 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

for you to fetch changes up to ba578b87fe2beef95b37264f8a98c0b505b93de9:

  selftests/bpf: Test invalid narrower ctx load (2025-07-23 19:35:56 -0700)

----------------------------------------------------------------
bpf-next-for-netdev

----------------------------------------------------------------
Kuniyuki Iwashima (1):
      bpf: Disable migration in nf_hook_run_bpf().

Paul Chaignon (2):
      bpf: Reject narrower access to pointer ctx fields
      selftests/bpf: Test invalid narrower ctx load

 kernel/bpf/cgroup.c                              |  8 ++++----
 net/core/filter.c                                | 20 +++++++++----------
 net/netfilter/nf_bpf_link.c                      |  2 +-
 tools/testing/selftests/bpf/progs/verifier_ctx.c | 25 ++++++++++++++++++++++++
 4 files changed, 40 insertions(+), 15 deletions(-)

