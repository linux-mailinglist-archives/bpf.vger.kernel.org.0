Return-Path: <bpf+bounces-46335-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A36F9E7BE6
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 23:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC71D16D863
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 22:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9A51FFC7C;
	Fri,  6 Dec 2024 22:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="AUoYZ9QL"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7ADC22C6D5;
	Fri,  6 Dec 2024 22:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733525141; cv=none; b=mlrYWyP+u8wBrTW3baO6futUS3qsk7fthPZBzkSR2/NofQtuERQCHz4ExIabM1ruO0/PIXCAZcF9wCBHEhSLTU3w/X5vwQWdpRcdPTQdMkz6ukghZ0XP3b1/YDyhp5SQqT6lk2hN0w/XMbMtNl+8JJpIAdpyH2gHN3cXnLYTJnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733525141; c=relaxed/simple;
	bh=SPq6ru6KeEu7S/DJ3r40M5+WSJlUxaW6SpmQGfhX2YQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Sts0j9uB8BL/xI8GyAMolsRo9hM4sh8KSjrosdqwqX857TXzKPc8UQL2YG90KcHX7R09ps+yShzmqh3x5RXgDGgZ+zN5NGIJVv7yEmKomIb2Or2m5TLnHiBAwOW512ILglCcJtUixF4MttlvmZlmeBibugmcR45HlL0ESvY7+E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=AUoYZ9QL; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=EDv7b+GrDXjsRKtyYoIJaRrs2yTN4GiCq+PXW32/j2Y=; b=AUoYZ9QLJ9NvvzMDdANLL2Dg7S
	yUps5jChAvRfa++KcL43tsdgZCxl6ShEJflCMZfgBejPSodAClvJ1aG3QV9XpTjfqEPnlwfD7hzOd
	3LEIk6AAmYuuyvmghsY1+py0zdH5KHC5Dj1E2qmGIiAdpIwK5KlzHB431zoKaZRTszYVnpD1JT4mT
	c0HN0hH9JJT00PaCpe3ilcpoGQdu0wozVcL4wN8Q7ok2bQWDlG9NwdXEJ28vQnSjHvAhNDevIKY/d
	Rkl5eBIp026UdOV2roqctIKqCFMT2vGapc38mzmWnMCzY0nURBreSmTd+BRK6MPlBIAvLI4iP9YFr
	cPk/DdkQ==;
Received: from 226.206.1.85.dynamic.cust.swisscom.net ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1tJh4q-0008Du-54; Fri, 06 Dec 2024 23:45:36 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: torvalds@linux-foundation.org
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Subject: [GIT PULL] bpf for v6.13-rc2
Date: Fri,  6 Dec 2024 23:45:34 +0100
Message-ID: <20241206224535.279796-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 1.0.7/27479/Fri Dec  6 10:40:14 2024)

Hi Linus,

The following changes since commit 9f16d5e6f220661f73b36a4be1b21575651d8833:

  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm (2024-11-23 16:00:50 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

for you to fetch changes up to 509df676c2d79c985ec2eaa3e3a3bbe557645861:

  Merge branch 'fixes-for-lpm-trie' (2024-12-06 09:14:35 -0800)

----------------------------------------------------------------
BPF fixes:

- Fix several issues for BPF LPM trie map which were found by
  syzbot and during addition of new test cases (Hou Tao)

- Fix a missing process_iter_arg register type check in the
  BPF verifier (Kumar Kartikeya Dwivedi, Tao Lyu)

- Fix several correctness gaps in the BPF verifier when
  interacting with the BPF stack without CAP_PERFMON
  (Kumar Kartikeya Dwivedi, Eduard Zingerman, Tao Lyu)

- Fix OOB BPF map writes when deleting elements for the case of
  xsk map as well as devmap (Maciej Fijalkowski)

- Fix xsk sockets to always clear DMA mapping information when
  unmapping the pool (Larysa Zaremba)

- Fix sk_mem_uncharge logic in tcp_bpf_sendmsg to only uncharge
  after sent bytes have been finalized (Zijian Zhang)

- Fix BPF sockmap with vsocks which was missing a queue check
  in poll and sockmap cleanup on close (Michal Luczaj)

- Fix tools infra to override makefile ARCH variable if defined
  but empty, which addresses cross-building tools. (Björn Töpel)

- Fix two resolve_btfids build warnings on unresolved bpf_lsm
  symbols (Thomas Weißschuh)

- Fix a NULL pointer dereference in bpftool (Amir Mohammadi)

- Fix BPF selftests to check for CONFIG_PREEMPTION instead of
  CONFIG_PREEMPT (Sebastian Andrzej Siewior)

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

----------------------------------------------------------------
Alexei Starovoitov (5):
      Merge branch 'bpf-vsock-fix-poll-and-close'
      Merge branch 'bpf-fix-oob-accesses-in-map_delete_elem-callbacks'
      Merge branch 'fix-missing-process_iter_arg-type-check'
      Merge branch 'fixes-for-stack-with-allow_ptr_leaks'
      Merge branch 'fixes-for-lpm-trie'

Amir Mohammadi (1):
      bpftool: fix potential NULL pointer dereferencing in prog_dump()

Björn Töpel (1):
      tools: Override makefile ARCH variable if defined, but empty

Eduard Zingerman (2):
      samples/bpf: Remove unnecessary -I flags from libbpf EXTRA_CFLAGS
      selftests/bpf: Introduce __caps_unpriv annotation for tests

Hou Tao (9):
      bpf: Remove unnecessary check when updating LPM trie
      bpf: Remove unnecessary kfree(im_node) in lpm_trie_update_elem
      bpf: Handle BPF_EXIST and BPF_NOEXIST for LPM trie
      bpf: Handle in-place update for full LPM trie correctly
      bpf: Fix exact match conditions in trie_get_next_key()
      bpf: Switch to bpf mem allocator for LPM trie
      bpf: Use raw_spinlock_t for LPM trie
      selftests/bpf: Move test_lpm_map.c to map_tests
      selftests/bpf: Add more test cases for LPM trie

Kumar Kartikeya Dwivedi (5):
      selftests/bpf: Add tests for iter arg check
      bpf: Zero index arg error string for dynptr and iter
      bpf: Don't mark STACK_INVALID as STACK_MISC in mark_stack_slot_misc
      selftests/bpf: Add test for reading from STACK_INVALID slots
      selftests/bpf: Add test for narrow spill into 64-bit spilled scalar

Larysa Zaremba (1):
      xsk: always clear DMA mapping information when unmapping the pool

Maciej Fijalkowski (2):
      xsk: fix OOB map writes when deleting elements
      bpf: fix OOB devmap writes when deleting elements

Michal Luczaj (4):
      bpf, vsock: Fix poll() missing a queue
      selftest/bpf: Add test for af_vsock poll()
      bpf, vsock: Invoke proto::close on close()
      selftest/bpf: Add test for vsock removal from sockmap on close()

Sebastian Andrzej Siewior (1):
      selftests/bpf: Check for PREEMPTION instead of PREEMPT

Tao Lyu (2):
      bpf: Ensure reg is PTR_TO_STACK in process_iter_arg
      bpf: Fix narrow scalar spill onto 64-bit spilled scalar slots

Thomas Weißschuh (1):
      bpf, lsm: Remove getlsmprop hooks BTF IDs

Zijian Zhang (2):
      tcp_bpf: Fix the sk_mem_uncharge logic in tcp_bpf_sendmsg
      selftests/bpf: Add apply_bytes test to test_txmsg_redir_wait_sndmem in test_sockmap

 kernel/bpf/bpf_lsm.c                               |   2 -
 kernel/bpf/devmap.c                                |   6 +-
 kernel/bpf/lpm_trie.c                              | 133 ++++---
 kernel/bpf/verifier.c                              |  27 +-
 net/ipv4/tcp_bpf.c                                 |  11 +-
 net/vmw_vsock/af_vsock.c                           |  70 ++--
 net/xdp/xsk_buff_pool.c                            |   5 +-
 net/xdp/xskmap.c                                   |   2 +-
 samples/bpf/Makefile                               |  13 +-
 tools/bpf/bpftool/prog.c                           |  17 +-
 tools/scripts/Makefile.arch                        |   4 +-
 tools/testing/selftests/bpf/.gitignore             |   1 -
 tools/testing/selftests/bpf/Makefile               |   2 +-
 .../lpm_trie_map_basic_ops.c}                      | 405 ++++++++++++++++++++-
 .../selftests/bpf/map_tests/task_storage_map.c     |   4 +-
 .../selftests/bpf/prog_tests/sockmap_basic.c       |  77 ++++
 .../selftests/bpf/prog_tests/task_local_storage.c  |   2 +-
 tools/testing/selftests/bpf/prog_tests/verifier.c  |  19 +-
 tools/testing/selftests/bpf/progs/bpf_misc.h       |  12 +
 tools/testing/selftests/bpf/progs/dynptr_fail.c    |  22 +-
 tools/testing/selftests/bpf/progs/iters.c          |  26 ++
 .../selftests/bpf/progs/iters_state_safety.c       |  14 +-
 .../selftests/bpf/progs/iters_testmod_seq.c        |   4 +-
 .../bpf/progs/read_bpf_task_storage_busy.c         |   4 +-
 .../selftests/bpf/progs/task_storage_nodeadlock.c  |   4 +-
 .../selftests/bpf/progs/test_kfunc_dynptr_param.c  |   2 +-
 .../selftests/bpf/progs/verifier_bits_iter.c       |   8 +-
 tools/testing/selftests/bpf/progs/verifier_mtu.c   |   4 +-
 .../selftests/bpf/progs/verifier_spill_fill.c      |  35 ++
 tools/testing/selftests/bpf/test_loader.c          |  46 +++
 tools/testing/selftests/bpf/test_sockmap.c         |   6 +-
 31 files changed, 813 insertions(+), 174 deletions(-)
 rename tools/testing/selftests/bpf/{test_lpm_map.c => map_tests/lpm_trie_map_basic_ops.c} (65%)

