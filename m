Return-Path: <bpf+bounces-34697-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE9293018F
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 23:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 426EFB21BCE
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 21:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BCC4965E;
	Fri, 12 Jul 2024 21:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="XxVnuL75"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C626224EA;
	Fri, 12 Jul 2024 21:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720819496; cv=none; b=iaDFED1j9pK6UwrWwvqCdAtBcit6gALBk1PB/2bXcvSq2s+gFoXWKIhAc/RgT8qO2/G31tKfe13nsaHP5aEJBgVvVb+cDE02oUEHejCBAP1eMBiiTa7LV8HhfN49gadUKcHv1Ddhz1hY3P+QKhXjXmFgHfrpKDZ1dcnKrmwu62I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720819496; c=relaxed/simple;
	bh=JlQyWU5B3b7UpROtTAH6wqup9WtrxxVxZKENaiUoCJk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Upp+OzBFRFP1QKk7gGGAnwlWtgNLqmCi2P8jgQX/fRkh3mFh7ayaVZddvSmCjMORhax49NwMm2oeasQbWULqbPRhEN2SUDgEzQ5P36AF5hozA3UqsT7N1JWyeGorL6+aXamBNfav2FRackze6P0wGo2vkTM7ZZZeaD74v+479C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=XxVnuL75; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=uG8TirAv6SFV8Gokhps728H3PBAD8q5M9Sh5gAdGkWE=; b=XxVnuL75DUUqbLmtMPRXSuWDE3
	z60i26F8dvNxUI0qlSTRJ6nKg6hLHmaF5ombCUefAE5u1Uo178g9xeHaebsd3/E/GZD5Ps12ov+7T
	LypxTgZJGzj4UzBqjBXLonKfKoY0eNH7ke3Ju81GObp53XkO766rfJJe8/rrUZk3Vgq6ARiHC6ot5
	LJ18Y+NrWXJB33z7+Y5EA/XemrR+8bBLQuPtQcy0tdxi9Y3/thABUGoiSVkPKr0CV9aiMQbr4Wjck
	qmJKGVR3KGx9zycVI67fuSEQzxrQma9R/6wadxRV0VLiXsFt+vdXWkUE4Zo96U9NU58whRqVGCuP+
	Ku4V89rQ==;
Received: from 226.206.1.85.dynamic.cust.swisscom.net ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sSNl2-000PhF-Tp; Fri, 12 Jul 2024 23:24:48 +0200
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
Subject: pull-request: bpf-next 2024-07-12
Date: Fri, 12 Jul 2024 23:24:48 +0200
Message-Id: <20240712212448.5378-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27334/Fri Jul 12 10:35:53 2024)

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net-next* tree.

We've added 23 non-merge commits during the last 3 day(s) which contain
a total of 18 files changed, 234 insertions(+), 243 deletions(-).

The main changes are:

1) Improve BPF verifier by utilizing overflow.h helpers to check for overflows,
   from Shung-Hsi Yu.

2) Fix NULL pointer dereference in resolve_prog_type() for BPF_PROG_TYPE_EXT
   when attr->attach_prog_fd was not specified, from Tengda Wu.

3) Fix arm64 BPF JIT when generating code for BPF trampolines with
   BPF_TRAMP_F_CALL_ORIG which corrupted upper address bits, from Puranjay Mohan.

4) Remove test_run callback from lwt_seg6local_prog_ops which never worked in the
   first place and caused syzbot reports, from Sebastian Andrzej Siewior.

5) Relax BPF verifier to accept non-zero offset on KF_TRUSTED_ARGS/KF_RCU-typed
   BPF kfuncs, from Matt Bobrowski.

6) Fix a long standing bug in libbpf with regards to handling of BPF skeleton's
   forward and backward compatibility, from Andrii Nakryiko.

7) Annotate btf_{seq,snprintf}_show functions with __printf, from Alan Maguire.

8) BPF selftest improvements to reuse common network helpers in sk_lookup test and
   dropping the open-coded inetaddr_len() and make_socket() ones, from Geliang Tang.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Alan Maguire, Daniel Borkmann, Eduard Zingerman, Jiri Olsa, Kumar 
Kartikeya Dwivedi, Mirsad Todorovac, Quentin Monnet

----------------------------------------------------------------

The following changes since commit 746d684ea579927015cde53cff8fc365caaf93b7:

  Merge branch 'selftests-drv-net-rss_ctx-more-tests' (2024-07-09 16:31:19 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

for you to fetch changes up to e435b043d89a267bd6eb3d5650d2319805d7924a:

  selftests/bpf: Test for null-pointer-deref bugfix in resolve_prog_type() (2024-07-12 22:14:21 +0200)

----------------------------------------------------------------
bpf-next-for-netdev

----------------------------------------------------------------
Alan Maguire (3):
      selftests/bpf: fix compilation failure when CONFIG_NF_FLOW_TABLE=m
      bpf: annotate BTF show functions with __printf
      bpf: Eliminate remaining "make W=1" warnings in kernel/bpf/btf.o

Alexei Starovoitov (2):
      Merge branch 'fix-libbpf-bpf-skeleton-forward-backward-compat'
      Merge branch 'use-overflow-h-helpers-to-check-for-overflows'

Andrii Nakryiko (3):
      bpftool: improve skeleton backwards compat with old buggy libbpfs
      libbpf: fix BPF skeleton forward/backward compat handling
      libbpf: improve old BPF skeleton handling for map auto-attach

Daniel Borkmann (1):
      selftests/bpf: DENYLIST.aarch64: Skip fexit_sleep again

Geliang Tang (8):
      selftests/bpf: Add backlog for network_helper_opts
      selftests/bpf: Add ASSERT_OK_FD macro
      selftests/bpf: Close fd in error path in drop_on_reuseport
      selftests/bpf: Use start_server_str in sk_lookup
      selftests/bpf: Use start_server_addr in sk_lookup
      selftests/bpf: Use connect_fd_to_fd in sk_lookup
      selftests/bpf: Null checks for links in bpf_tcp_ca
      selftests/bpf: Close obj in error path in xdp_adjust_tail

Martin KaFai Lau (2):
      Merge branch 'use network helpers, part 8'
      Merge branch 'BPF selftests misc fixes'

Matt Bobrowski (1):
      bpf: relax zero fixed offset constraint on KF_TRUSTED_ARGS/KF_RCU

Puranjay Mohan (1):
      bpf, arm64: Fix trampoline for BPF_TRAMP_F_CALL_ORIG

Sebastian Andrzej Siewior (1):
      bpf: Remove tst_run from lwt_seg6local_prog_ops.

Shung-Hsi Yu (3):
      bpf: fix overflow check in adjust_jmp_off()
      bpf: use check_add_overflow() to check for addition overflows
      bpf: use check_sub_overflow() to check for subtraction overflows

Tengda Wu (2):
      bpf: Fix null pointer dereference in resolve_prog_type() for BPF_PROG_TYPE_EXT
      selftests/bpf: Test for null-pointer-deref bugfix in resolve_prog_type()

 arch/arm64/net/bpf_jit_comp.c                      |   4 +-
 include/linux/bpf_verifier.h                       |   2 +-
 kernel/bpf/btf.c                                   |  10 +-
 kernel/bpf/verifier.c                              | 180 ++++++---------------
 net/core/filter.c                                  |   1 -
 tools/bpf/bpftool/gen.c                            |  46 ++++--
 tools/lib/bpf/libbpf.c                             |  71 ++++----
 tools/testing/selftests/bpf/DENYLIST.aarch64       |   1 +
 tools/testing/selftests/bpf/network_helpers.c      |   2 +-
 tools/testing/selftests/bpf/network_helpers.h      |  10 ++
 .../testing/selftests/bpf/prog_tests/bpf_tcp_ca.c  |  16 +-
 tools/testing/selftests/bpf/prog_tests/sk_lookup.c |  82 +++++-----
 .../selftests/bpf/prog_tests/xdp_adjust_tail.c     |   2 +-
 .../selftests/bpf/progs/nested_trust_failure.c     |   8 -
 .../selftests/bpf/progs/nested_trust_success.c     |   8 +
 tools/testing/selftests/bpf/progs/xdp_flowtable.c  |  10 +-
 tools/testing/selftests/bpf/test_progs.h           |   9 ++
 tools/testing/selftests/bpf/verifier/calls.c       |  15 +-
 18 files changed, 234 insertions(+), 243 deletions(-)

