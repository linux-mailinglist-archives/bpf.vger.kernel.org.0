Return-Path: <bpf+bounces-22473-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D7485EC9F
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 00:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79920283AD1
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 23:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137143EA8E;
	Wed, 21 Feb 2024 23:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="hJpAh9zT"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6962286632;
	Wed, 21 Feb 2024 23:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708557514; cv=none; b=mxSY7fo24sW8Yz68AK/irfTLowMDvnvp2bTDavjarnDCNdQir0VV6ddg4ellsZKVpbfcPo8N+JcADA5r0+bmdCG05cefpftKX+jgYUaaNCrte/qkd0Fgb5j0Dft7B16Bo2KNX9uDOyf3nokkjRKDH0NkFi3OI2c8UHlsJ87Bfn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708557514; c=relaxed/simple;
	bh=UDcGzGul9Icnjvt6qd6RLlmCUaupBeENA5OE/+plvLg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OBaolTfh7UWy7FkRAugDIV5eBTVhmjQCwVZJym4IzVrPOun1Se/AXpHzmhVL0sKc/OzXz/pd55uIPs6MGjYNx+Q3WDYgy3FIrKqBV4jW+ma0YriccI9emSi2Qe1R1ekfaGjBN24V7xjOFMPaaFbG394hG+4JmQpPrMP0sXAPHzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=hJpAh9zT; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=25B2YKkUbc7F6L5A9NU1leqoK1R6wInGRQ6Y4kq6IO4=; b=hJpAh9zTcKKj8xWLIcQE0guUHx
	TvOhf4E/z2863QluDWoBzPXksYeC/yKS5/uy20d3EpQkX4C9Pshcwqfl4LGSPA/FzrAVTWgjOjUtC
	g/JVTL2SMI0pu4+H4vAR05rWDDoHVfTT/rCbv1EM7nuf0M8UFvlnfILGwLniiJzzR23GnL8A1JA53
	alouzgOMqy8cXa0Erf2cmZbZNbyA2lGe/qR0paETlzsrl1+DlOEiZZt0SV9RSsctByNKPTPJhu+U8
	sMl4X0AHnppmHjs4us+ed4ZLiKFlz/Y8ZQem6aWGxth7N/VMMCQ77oVwcSF+Jr2iQ6Lkz97uV/wZZ
	k6sHrSCw==;
Received: from 13.249.197.178.dynamic.dsl-lte-bonding.lssmb00p-msn.res.cust.swisscom.ch ([178.197.249.13] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rcvr9-00035I-BR; Thu, 22 Feb 2024 00:18:27 +0100
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
Subject: pull-request: bpf 2024-02-22
Date: Thu, 22 Feb 2024 00:18:26 +0100
Message-Id: <20240221231826.1404-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27192/Wed Feb 21 10:23:23 2024)

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net* tree.

We've added 11 non-merge commits during the last 24 day(s) which contain
a total of 15 files changed, 217 insertions(+), 17 deletions(-).

The main changes are:

1) Fix a syzkaller-triggered oops when attempting to read the vsyscall
   page through bpf_probe_read_kernel and friends, from Hou Tao.

2) Fix a kernel panic due to uninitialized iter position pointer in
   bpf_iter_task, from Yafang Shao.

3) Fix a race between bpf_timer_cancel_and_free and bpf_timer_cancel,
   from Martin KaFai Lau.

4) Fix a xsk warning in skb_add_rx_frag() (under CONFIG_DEBUG_NET)
   due to incorrect truesize accounting, from Sebastian Andrzej Siewior.

5) Fix a NULL pointer dereference in sk_psock_verdict_data_ready,
   from Shigeru Yoshida.

6) Fix a resolve_btfids warning when bpf_cpumask symbol cannot be
   resolved, from Hari Bathini.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

David Vernet, Hou Tao, Jiri Olsa, John Fastabend, Maciej Fijalkowski, 
Oleg Nesterov, Quentin Monnet, Sohil Mehta, Stanislav Fomichev, Thomas 
Gleixner, xingwei lee, Yonghong Song

----------------------------------------------------------------

The following changes since commit 577e4432f3ac810049cb7e6b71f4d96ec7c6e894:

  tcp: add sanity checks to rx zerocopy (2024-01-29 12:07:35 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev

for you to fetch changes up to 4cd12c6065dfcdeba10f49949bffcf383b3952d8:

  bpf, sockmap: Fix NULL pointer dereference in sk_psock_verdict_data_ready() (2024-02-21 17:15:23 +0100)

----------------------------------------------------------------
bpf-for-netdev

----------------------------------------------------------------
Alexei Starovoitov (1):
      Merge branch 'fix-the-read-of-vsyscall-page-through-bpf'

Gianmarco Lusvardi (1):
      bpf, scripts: Correct GPL license name

Hari Bathini (1):
      bpf: Fix warning for bpf_cpumask in verifier

Hou Tao (3):
      x86/mm: Move is_vsyscall_vaddr() into asm/vsyscall.h
      x86/mm: Disallow vsyscall page read for copy_from_kernel_nofault()
      selftest/bpf: Test the read of vsyscall page under x86-64

Martin KaFai Lau (2):
      bpf: Fix racing between bpf_timer_cancel_and_free and bpf_timer_cancel
      selftests/bpf: Test racing between bpf_timer_cancel_and_free and bpf_timer_cancel

Sebastian Andrzej Siewior (1):
      xsk: Add truesize to skb_add_rx_frag().

Shigeru Yoshida (1):
      bpf, sockmap: Fix NULL pointer dereference in sk_psock_verdict_data_ready()

Yafang Shao (2):
      bpf: Fix an issue due to uninitialized bpf_iter_task
      selftests/bpf: Add negtive test cases for task iter

 arch/x86/include/asm/vsyscall.h                    | 10 ++++
 arch/x86/mm/fault.c                                |  9 ----
 arch/x86/mm/maccess.c                              | 10 ++++
 kernel/bpf/helpers.c                               |  5 +-
 kernel/bpf/task_iter.c                             |  2 +
 kernel/bpf/verifier.c                              |  2 +
 net/core/skmsg.c                                   |  7 ++-
 net/xdp/xsk.c                                      |  3 +-
 scripts/bpf_doc.py                                 |  2 +-
 tools/testing/selftests/bpf/prog_tests/iters.c     |  1 +
 .../selftests/bpf/prog_tests/read_vsyscall.c       | 57 ++++++++++++++++++++++
 tools/testing/selftests/bpf/prog_tests/timer.c     | 35 ++++++++++++-
 tools/testing/selftests/bpf/progs/iters_task.c     | 12 ++++-
 tools/testing/selftests/bpf/progs/read_vsyscall.c  | 45 +++++++++++++++++
 tools/testing/selftests/bpf/progs/timer.c          | 34 ++++++++++++-
 15 files changed, 217 insertions(+), 17 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/read_vsyscall.c
 create mode 100644 tools/testing/selftests/bpf/progs/read_vsyscall.c

