Return-Path: <bpf+bounces-32897-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 960F2914AE8
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 14:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFB521C22BC2
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 12:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C0C13CFB6;
	Mon, 24 Jun 2024 12:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="PUURHREi"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533911E4AE;
	Mon, 24 Jun 2024 12:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719233024; cv=none; b=PvlITHsQ0F9UsfslT4I5vauNtsSqMt+YHIbZTBPONW3IdTimvg+0U4Z+S/akDHUSI+5Z+diBHwHcr0bCIoGpBQLLXxiROPby8tm/e8bNGiloilSFWqEtxRghYlTVoTgtB9Watb14x4ejy+LbQ46KtAAAjipDpcE8UhKKp6kcLlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719233024; c=relaxed/simple;
	bh=ibwVwKOALsKK92E8Whm3+DfnDFeae2zev5i+x3smQdo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aIcjae0Umfx6GFX3k2UrjTAp07h2i5ahGR2puyQLNxwvLqjk3wMblD0S2Bl78C9CpnlYDrAHZds3W/JCqIGo3TK0fzn8lHrAysp0VoRXS5rgbvNSwZSQP0AfIYqcKTvO080Z6mEvsYubGJVYKZpORaAI7VxCaXPd5piakZoeqv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=PUURHREi; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=q3Yp0BpC1JwAc5h1uplrrayDdiQnQvT3K7EBGl94OgY=; b=PUURHREirA1J+aDuJFCYs9pLAu
	hhGO1meI2uveyJXl5XhDE6czSFuX0R3/6d8Gfk/9yUn6/xCNI6N3YRgRxa1TdOqpb1PGSkHLwKCi4
	zdD/QPkxye/u16MMHyhtlT6qfxtKG/WvztMEnlCe9eBmuW/4f01iugliszFhkjjMmEyHQnAYblUOv
	RJqQE52UjcATBvP30r2QjkNAPfFRDs/0j6tTn3u92i0EFq0q67Tmxtj7VpLDdjX0cFUunjRCGTnrX
	AtDkd994tfZIky26HWujtWhyXZANyy3h/5TtAiEVS+dUF3hZeqDXWmI2re2XZS/cNCW7VncMU6l/y
	zVOqzwRA==;
Received: from 38.249.197.178.dynamic.cust.swisscom.net ([178.197.249.38] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sLj2h-000CII-D7; Mon, 24 Jun 2024 14:43:31 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
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
Subject: pull-request: bpf 2024-06-24
Date: Mon, 24 Jun 2024 14:43:30 +0200
Message-Id: <20240624124330.8401-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27316/Mon Jun 24 10:26:29 2024)

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net* tree.

We've added 12 non-merge commits during the last 10 day(s) which contain
a total of 10 files changed, 412 insertions(+), 16 deletions(-).

The main changes are:

1) Fix a BPF verifier issue validating may_goto with a negative offset,
   from Alexei Starovoitov.

2) Fix a BPF verifier validation bug with may_goto combined with jump to
   the first instruction, also from Alexei Starovoitov.

3) Fix a bug with overrunning reservations in BPF ring buffer,
   from Daniel Borkmann.

4) Fix a bug in BPF verifier due to missing proper var_off setting related
   to movsx instruction, from Yonghong Song.

5) Silence unnecessary syzkaller-triggered warning in __xdp_reg_mem_model(),
   from Daniil Dulov.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Barret Rhoden, Bing-Jhong Billy Jheng, Eduard Zingerman, Jesper Dangaard 
Brouer, Muhammad Ramdhan, Pengfei Xu, Zac Ecob

----------------------------------------------------------------

The following changes since commit 143492fce36161402fa2f45a0756de7ff69c366a:

  Merge branch '40GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue (2024-06-14 19:05:38 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev

for you to fetch changes up to 7e9f79428372c6eab92271390851be34ab26bfb4:

  xdp: Remove WARN() from __xdp_reg_mem_model() (2024-06-24 13:44:02 +0200)

----------------------------------------------------------------
bpf-for-netdev

----------------------------------------------------------------
Alexei Starovoitov (6):
      Merge branch 'bpf-fix-missed-var_off-related-to-movsx-in-verifier'
      bpf: Fix remap of arena.
      bpf: Fix the corner case with may_goto and jump to the 1st insn.
      selftests/bpf: Tests with may_goto and jumps to the 1st insn
      bpf: Fix may_goto with negative offset.
      selftests/bpf: Add tests for may_goto with negative offset.

Daniel Borkmann (2):
      bpf: Fix overrunning reservations in ringbuf
      selftests/bpf: Add more ring buffer test coverage

Daniil Dulov (1):
      xdp: Remove WARN() from __xdp_reg_mem_model()

Matt Bobrowski (1):
      bpf: Update BPF LSM maintainer list

Yonghong Song (3):
      bpf: Add missed var_off setting in set_sext32_default_val()
      bpf: Add missed var_off setting in coerce_subreg_to_size_sx()
      selftests/bpf: Add a few tests to cover

 MAINTAINERS                                        |   3 +-
 kernel/bpf/arena.c                                 |  16 ++-
 kernel/bpf/ringbuf.c                               |  31 ++++-
 kernel/bpf/verifier.c                              |  61 ++++++++-
 net/core/xdp.c                                     |   4 +-
 tools/testing/selftests/bpf/Makefile               |   2 +-
 tools/testing/selftests/bpf/prog_tests/ringbuf.c   |  56 ++++++++
 .../selftests/bpf/progs/test_ringbuf_write.c       |  46 +++++++
 .../bpf/progs/verifier_iterating_callbacks.c       | 146 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/verifier_movsx.c |  63 +++++++++
 10 files changed, 412 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_ringbuf_write.c

