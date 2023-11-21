Return-Path: <bpf+bounces-15586-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA507F36D0
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 20:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B20F2823A1
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 19:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C905B212;
	Tue, 21 Nov 2023 19:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="iIL65mGH"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8848512A;
	Tue, 21 Nov 2023 11:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=/hjIueDZ+uBL332IyO4l6P2oWRA58WLJYhHKA0zENV4=; b=iIL65mGHp1XZ2ttNpNUITrOSpA
	qQzsPiMSsbuSyPirkWARjBGDraFooBaxDjQWtItSWOhgMTUOx2wuyU1YVGMkhgRXIPx7UBwHC0m65
	BNdr59DG2hkG0rcbi2eQek0rz4CtSf+xIR9lS333jiIFpuPMU9ktNT0h7+bNimfNyhp4n1sBqaFqs
	h+hJvdCaz/XtVcEGDk2/XshrFPoG36YHl5IXOSN5toVK0jk1pIS8Ig9OxoVe/2+smZcNp2WppFSmv
	1attFmrXOmg+ME/nIAOBr2uTBLUna7ww7FjCNhRwgXxEk8fGj/b8dFhcpGtTHtoMziQ9ENUYsOwT+
	lTy0ovUw==;
Received: from 226.206.1.85.dynamic.wline.res.cust.swisscom.ch ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1r5WSo-000IwZ-Gc; Tue, 21 Nov 2023 20:31:14 +0100
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
Subject: pull-request: bpf 2023-11-21
Date: Tue, 21 Nov 2023 20:31:13 +0100
Message-Id: <20231121193113.11796-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27100/Tue Nov 21 09:39:58 2023)

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net* tree.

We've added 19 non-merge commits during the last 4 day(s) which contain
a total of 18 files changed, 1043 insertions(+), 416 deletions(-).

The main changes are:

1) Fix BPF verifier to validate callbacks as if they are called an unknown
   number of times in order to fix not detecting some unsafe programs,
   from Eduard Zingerman.

2) Fix bpf_redirect_peer() handling which missed proper stats accounting
   for veth and netkit and also generally fix missing stats for the latter,
   from Peilin Ye, Daniel Borkmann et al.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Andrew Werner, Andrii Nakryiko, Nikolay Aleksandrov, Stanislav Fomichev, 
Youlun Zhang

----------------------------------------------------------------

The following changes since commit 76df934c6d5f5c93ba7a0112b1818620ddc10b19:

  MAINTAINERS: Add netdev subsystem profile link (2023-11-17 03:44:21 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev

for you to fetch changes up to acb12c859ac7c36d6d7632280fd1e263188cb07f:

  Merge branch 'verify-callbacks-as-if-they-are-called-unknown-number-of-times' (2023-11-20 18:36:41 -0800)

----------------------------------------------------------------
bpf-for-netdev

----------------------------------------------------------------
Alexei Starovoitov (1):
      Merge branch 'verify-callbacks-as-if-they-are-called-unknown-number-of-times'

Daniel Borkmann (6):
      net, vrf: Move dstats structure to core
      net: Move {l,t,d}stats allocation to core and convert veth & vrf
      netkit: Add tstats per-CPU traffic counters
      bpf, netkit: Add indirect call wrapper for fetching peer dev
      selftests/bpf: De-veth-ize the tc_redirect test case
      selftests/bpf: Add netkit to tc_redirect selftest

Eduard Zingerman (11):
      selftests/bpf: track tcp payload offset as scalar in xdp_synproxy
      selftests/bpf: track string payload offset as scalar in strobemeta
      selftests/bpf: fix bpf_loop_bench for new callback verification scheme
      bpf: extract __check_reg_arg() utility function
      bpf: extract setup_func_entry() utility function
      bpf: verify callbacks as if they are called unknown number of times
      selftests/bpf: tests for iterating callbacks
      bpf: widening for callback iterators
      selftests/bpf: test widening for iterating callbacks
      bpf: keep track of max number of bpf_loop callback iterations
      selftests/bpf: check if max number of bpf_loop iterations is tracked

Martin KaFai Lau (1):
      Merge branch 'bpf_redirect_peer fixes'

Peilin Ye (2):
      veth: Use tstats per-CPU traffic counters
      bpf: Fix dev's rx stats for bpf_redirect_peer traffic

 drivers/net/netkit.c                               |  22 +-
 drivers/net/veth.c                                 |  44 +--
 drivers/net/vrf.c                                  |  38 +-
 include/linux/bpf_verifier.h                       |  16 +
 include/linux/netdevice.h                          |  30 +-
 include/net/netkit.h                               |   6 +
 kernel/bpf/verifier.c                              | 402 ++++++++++++++-------
 net/core/dev.c                                     |  57 ++-
 net/core/filter.c                                  |  19 +-
 .../testing/selftests/bpf/prog_tests/tc_redirect.c | 317 +++++++++-------
 tools/testing/selftests/bpf/prog_tests/verifier.c  |   2 +
 tools/testing/selftests/bpf/progs/bpf_loop_bench.c |  13 +-
 tools/testing/selftests/bpf/progs/cb_refs.c        |   1 +
 .../testing/selftests/bpf/progs/exceptions_fail.c  |   2 +
 tools/testing/selftests/bpf/progs/strobemeta.h     |  78 ++--
 .../bpf/progs/verifier_iterating_callbacks.c       | 242 +++++++++++++
 .../bpf/progs/verifier_subprog_precision.c         |  86 ++++-
 .../selftests/bpf/progs/xdp_synproxy_kern.c        |  84 +++--
 18 files changed, 1043 insertions(+), 416 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c

