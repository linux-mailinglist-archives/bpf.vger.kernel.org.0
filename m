Return-Path: <bpf+bounces-11846-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 953C47C443E
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 00:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 935641C20F30
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 22:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01999225DA;
	Tue, 10 Oct 2023 22:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Qf8mflRi"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C158B31599;
	Tue, 10 Oct 2023 22:36:16 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6115198;
	Tue, 10 Oct 2023 15:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=+//m0KI4ZPTKPBh3GBzx8/nuQJX7FHzq6yrhqUaHjYg=; b=Qf8mflRi2rWQG+3qJrpL7GqVa1
	DoXyqQJMgN8c2dyHTgXuJ8NCrnu0hJCW0nx/Y3S1WE1JejPVNHq+0PQA6ucgmUBotQJeaYOlIFo1H
	QwSVMkWJgfBBrP2Ma0Od5Z3byDfvGR623QtoaqxVP9S7DRI+QTJwhJiDmgR+xl6u8Y8sOKwLJ4Srt
	imaAdNHVvc/fMoKAMym9njsY+Wn2rlX8ltnfFiokngMkBX3V7rbqoEOTxNbIik/NxTxqhhzGVHgJZ
	WXcEdMgpBY1WDIGDBY6BU961ixvoqQX42KOaY7VSuo+R4W8zOuJ0/lHydYZDAi2iRizbshW6sS4iG
	Xs+qZ3dw==;
Received: from 226.206.1.85.dynamic.wline.res.cust.swisscom.ch ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qqLKl-0003H0-2a; Wed, 11 Oct 2023 00:36:11 +0200
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
Subject: pull-request: bpf 2023-10-11
Date: Wed, 11 Oct 2023 00:36:10 +0200
Message-Id: <20231010223610.3984-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27057/Tue Oct 10 09:39:11 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net* tree.

We've added 14 non-merge commits during the last 5 day(s) which contain
a total of 12 files changed, 398 insertions(+), 104 deletions(-).

The main changes are:

1) Fix s390 JIT backchain issues in the trampoline code generation which
   previously clobbered the caller's backchain, from Ilya Leoshkevich.

2) Fix zero-size allocation warning in xsk sockets when the configured ring
   size was close to SIZE_MAX, from Andrew Kanner.

3) Fixes for bpf_mprog API that were found when implementing support in the
   ebpf-go library along with selftests, from Daniel Borkmann and Lorenz Bauer.

4) Fix riscv JIT to properly sign-extend the return register in programs.
   This fixes various test_progs selftests on riscv, from Björn Töpel.

5) Fix verifier log for async callback return values where the allowed range
   was displayed incorrectly, from David Vernet.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Lorenz Bauer, Magnus Karlsson, Martin KaFai Lau, Song Liu

----------------------------------------------------------------

The following changes since commit c4d49196ceec80e30e8d981410d73331b49b7850:

  net: sched: cls_u32: Fix allocation size in u32_init() (2023-10-06 11:43:05 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev

for you to fetch changes up to 5356ba1ff4f2417e1aebcf99aab35c1ea94dd6d7:

  s390/bpf: Fix unwinding past the trampoline (2023-10-11 00:08:46 +0200)

----------------------------------------------------------------
bpf-for-netdev

----------------------------------------------------------------
Andrew Kanner (1):
      xdp: Fix zero-size allocation warning in xskq_create()

Björn Töpel (2):
      riscv, bpf: Sign-extend return values
      riscv, bpf: Track both a0 (RISC-V ABI) and a5 (BPF) return values

Daniel Borkmann (6):
      bpf: Fix BPF_PROG_QUERY last field check
      bpf: Handle bpf_mprog_query with NULL entry
      selftests/bpf: Test bpf_mprog query API via libbpf and raw syscall
      selftests/bpf: Adapt assert_mprog_count to always expect 0 count
      selftests/bpf: Test query on empty mprog and pass revision into attach
      selftests/bpf: Make seen_tc* variable tests more robust

David Vernet (2):
      bpf: Fix verifier log for async callback return values
      selftests/bpf: Add testcase for async callback return value failure

Ilya Leoshkevich (2):
      s390/bpf: Fix clobbering the caller's backchain in the trampoline
      s390/bpf: Fix unwinding past the trampoline

Lorenz Bauer (1):
      bpf: Refuse unused attributes in bpf_prog_{attach,detach}

 arch/riscv/net/bpf_jit_comp64.c                    |  18 +-
 arch/s390/net/bpf_jit_comp.c                       |  25 +-
 kernel/bpf/mprog.c                                 |  10 +-
 kernel/bpf/syscall.c                               |  21 +-
 kernel/bpf/tcx.c                                   |   8 +-
 kernel/bpf/verifier.c                              |   6 +-
 net/xdp/xsk_queue.c                                |  10 +
 .../testing/selftests/bpf/prog_tests/tc_helpers.h  |  16 +-
 tools/testing/selftests/bpf/prog_tests/tc_links.c  |  64 ++---
 tools/testing/selftests/bpf/prog_tests/tc_opts.c   | 271 +++++++++++++++++++--
 tools/testing/selftests/bpf/prog_tests/timer.c     |   6 +-
 tools/testing/selftests/bpf/progs/timer_failure.c  |  47 ++++
 12 files changed, 398 insertions(+), 104 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/timer_failure.c

