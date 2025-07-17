Return-Path: <bpf+bounces-63658-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6144AB094D2
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 21:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BD7B7BCA7D
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 19:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834942FE36F;
	Thu, 17 Jul 2025 19:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ddttC3Cv"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E3F2FE371
	for <bpf@vger.kernel.org>; Thu, 17 Jul 2025 19:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752779884; cv=none; b=WSGCO9dGuEreOTHckgFQ2vLmsGMSnCoEmwaeNsI3D/QZlGpLXxWrRLVb7JIsx5GAFAx7PPPUKQ+G6EQLY9ncKcks0fUlIYg/QY3qFE0yGrZjDHX8b5mAv8Qo5oSrn4KMYao3aqDkg/Dy1ZsJb+B4cG/BLm9aKO3IaOwgvS39pZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752779884; c=relaxed/simple;
	bh=TCZ16/m/JcR+KOcW3zLkSxjiy0cw3kk7UNgRMp8JkBI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mehjyJZ8hVOSq3jSA4Gk30sqzSXb0HRZPK3k3J87vSiDBqO3a8Ltyi11bOOa/h7838b2SLrWdsTHtC0acUDaOQUZqBM3IEfW3CHs0Drk613/O1BAFN0VfHOQxBK/uO1rM/wTvRJk1B8RVCGjXPU0an3PU9XgzGZGWbkisCNCZ2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ddttC3Cv; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752779869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=w70L6V3f6rZMpo2My9D3+7foPd+Gh2XyPQDgGDEOEwA=;
	b=ddttC3CvnuZqBKJ7V5kQVz3uuS4hh2ZFnQTlQDXldYUXxWKonHBZQysl7cCRz0427iTAwB
	xieBWK05nS/2hg+0wr79ByR5yo0Hv9GQ4TzEXJASnp0xQLcBddAVWDALwLxzAngR8yewRF
	SY3VKWK3FzYDeKnAC9pwfdO986TtQ4g=
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
Subject: pull-request: bpf-next 2025-07-17
Date: Thu, 17 Jul 2025 12:17:31 -0700
Message-ID: <20250717191731.4142326-1-martin.lau@linux.dev>
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

We've added 13 non-merge commits during the last 20 day(s) which contain
a total of 4 files changed, 712 insertions(+), 84 deletions(-).

The main changes are:

1) Avoid skipping or repeating a sk when using a TCP bpf_iter,
   from Jordan Rife.

2) Clarify the driver requirement on using the XDP metadata,
   from Song Yoong Siang

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Kuniyuki Iwashima, Stanislav Fomichev

----------------------------------------------------------------

The following changes since commit 8efa26fcbf8a7f783fd1ce7dd2a409e9b7758df0:

  tg3: spelling corrections (2025-06-27 10:25:57 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

for you to fetch changes up to ef57dc6f52e4949527f82a456cb9a637a55209ea:

  doc: xdp: Clarify driver implementation for XDP Rx metadata (2025-07-16 16:36:11 -0700)

----------------------------------------------------------------
bpf-next-for-netdev

----------------------------------------------------------------
Jordan Rife (12):
      bpf: tcp: Make mem flags configurable through bpf_iter_tcp_realloc_batch
      bpf: tcp: Make sure iter->batch always contains a full bucket snapshot
      bpf: tcp: Get rid of st_bucket_done
      bpf: tcp: Use bpf_tcp_iter_batch_item for bpf_tcp_iter_state batch items
      bpf: tcp: Avoid socket skips and repeats during iteration
      selftests/bpf: Add tests for bucket resume logic in listening sockets
      selftests/bpf: Allow for iteration over multiple ports
      selftests/bpf: Allow for iteration over multiple states
      selftests/bpf: Make ehash buckets configurable in socket iterator tests
      selftests/bpf: Create established sockets in socket iterator tests
      selftests/bpf: Create iter_tcp_destroy test program
      selftests/bpf: Add tests for bucket resume logic in established sockets

Martin KaFai Lau (1):
      Merge branch 'bpf-tcp-exactly-once-socket-iteration'

Song Yoong Siang (1):
      doc: xdp: Clarify driver implementation for XDP Rx metadata

 Documentation/networking/xdp-rx-metadata.rst       |  33 ++
 net/ipv4/tcp_ipv4.c                                | 269 ++++++++----
 .../selftests/bpf/prog_tests/sock_iter_batch.c     | 458 ++++++++++++++++++++-
 .../testing/selftests/bpf/progs/sock_iter_batch.c  |  36 +-
 4 files changed, 712 insertions(+), 84 deletions(-)

