Return-Path: <bpf+bounces-52113-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B02A3E821
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 00:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2A9D423025
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 23:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC10265631;
	Thu, 20 Feb 2025 23:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Lj45DVaq"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2DC1EB1B9;
	Thu, 20 Feb 2025 23:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740093107; cv=none; b=A5jL8sKeIp4QWEFqPGNVmDuzdVDBbj4whxdwrB5MTeKPtYfZ7uyM/d36h4GJYtLs5yX5ATftpyw5iKgaJEUF/k4YSQDRL0Wq2ntgwxovnjyDHLRU7ypqerf3jWF9m228A4a3U+6cfJEDKdj/dMVlzfA/G6p77LT/pBkvFNhNVEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740093107; c=relaxed/simple;
	bh=R0Fj56QDGOJyhVVHZjrG1Af8PrPuFhmH/B5G0gjo4Y8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hyuFsD/kK35lFGaQNt71SDvKmJ30NvW4/hNBPSoY0HY8gQfcf2CYXfOWNB+G7uuvCBCxlCYvckG1AY7uAcB1dbOUjGLRTt4D6oCZES5xjraHsHDCtIkws0rfIA0xfWWnjmlEumLYUyIIaSZjRg8JfKPZT0mTLE9aN1fGLd4x6oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=Lj45DVaq; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=JYy9jYhd6Up0RBcecZv1pGyDC9oApGZN2T90sAZAV0A=; b=Lj45DVaq5dFkoib6vMaBPlT969
	dGF6QZnqPgz4jklW4WIxoiHU68jAliEwKutCpf+lhq+jMIi66OtB4Um/HAkkDMmgaZooPIbRgQJzt
	8kv0rlq6EDmhWckG5BkCEtDGXjgi4fvmQUGLFcjEgqVxfhR32yrLph6O97XV66Ookucd+ql7RsUqk
	3A8gKhz0nIRbx5DhDuuInhIg/QWrK6a9tONGY8ycAcmaH6L6loKgRhyCnspxDCNIuswTUsvBkEKDW
	EJO8JMwZe3RG2RvJHOD7dhF8v5p4ap6ACk+njV86VDvrckzHbxNTkSLzklrYQbTEziK4InitECHgg
	Agfe4evA==;
Received: from 50.249.197.178.dynamic.cust.swisscom.net ([178.197.249.50] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1tlFQC-0001UG-0F;
	Thu, 20 Feb 2025 23:53:32 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: torvalds@linux-foundation.org
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Subject: [GIT PULL] bpf for v6.14-rc4
Date: Thu, 20 Feb 2025 23:53:31 +0100
Message-ID: <20250220225331.46335-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 1.0.7/27555/Thu Feb 20 10:43:53 2025)

Hi Linus,

The following changes since commit 05dbaf8dd8bf537d4b4eb3115ab42a5fb40ff1f5:

  Merge tag 'x86-urgent-2025-01-28' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2025-01-28 14:32:03 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

for you to fetch changes up to dbf7cc560007c8624ba42bbda369eca2973fc2da:

  Merge branch 'bpf-skip-non-exist-keys-in-generic_map_lookup_batch' (2025-02-18 17:27:38 -0800)

----------------------------------------------------------------
BPF fixes:

- Fix a soft-lockup in BPF arena_map_free on 64k page size
  kernels (Alan Maguire)

- Fix a missing allocation failure check in BPF verifier's
  acquire_lock_state (Kumar Kartikeya Dwivedi)

- Fix a NULL-pointer dereference in trace_kfree_skb by adding
  kfree_skb to the raw_tp_null_args set (Kuniyuki Iwashima)

- Fix a deadlock when freeing BPF cgroup storage (Abel Wu)

- Fix a syzbot-reported deadlock when holding BPF map's
  freeze_mutex (Andrii Nakryiko)

- Fix a use-after-free issue in bpf_test_init when
  eth_skb_pkt_type is accessing skb data not containing an
  Ethernet header (Shigeru Yoshida)

- Fix skipping non-existing keys in generic_map_lookup_batch
  (Yan Zhai)

- Several BPF sockmap fixes to address incorrect TCP copied_seq
  calculations, which prevented correct data reads from recv(2)
  in user space (Jiayuan Chen)

- Two fixes for BPF map lookup nullness elision (Daniel Xu)

- Fix a NULL-pointer dereference from vmlinux BTF lookup in
  bpf_sk_storage_tracing_allowed (Jared Kangas)

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

----------------------------------------------------------------
Abel Wu (1):
      bpf: Fix deadlock when freeing cgroup storage

Alan Maguire (1):
      bpf: Fix softlockup in arena_map_free on 64k page kernel

Alexei Starovoitov (2):
      Merge branch 'bpf-some-fixes-for-nullness-elision'
      Merge branch 'bpf-skip-non-exist-keys-in-generic_map_lookup_batch'

Andrii Nakryiko (2):
      bpf: unify VM_WRITE vs VM_MAYWRITE use in BPF map mmaping logic
      bpf: avoid holding freeze_mutex during mmap operation

Daniel Xu (3):
      bpf: verifier: Do not extract constant map keys for irrelevant maps
      bpf: selftests: Test constant key extraction on irrelevant maps
      bpf: verifier: Disambiguate get_constant_map_key() errors

Jared Kangas (1):
      bpf: Remove unnecessary BTF lookups in bpf_sk_storage_tracing_allowed

Jiayuan Chen (5):
      strparser: Add read_sock callback
      bpf: Fix wrong copied_seq calculation
      bpf: Disable non stream socket for strparser
      selftests/bpf: Fix invalid flag of recv()
      selftests/bpf: Add strparser test for bpf

Kumar Kartikeya Dwivedi (1):
      bpf: Handle allocation failure in acquire_lock_state

Kuniyuki Iwashima (1):
      net: Add rx_skb of kfree_skb to raw_tp_null_args[].

Martin KaFai Lau (1):
      Merge branch 'bpf-fix-wrong-copied_seq-calculation-and-add-tests'

Shigeru Yoshida (2):
      bpf, test_run: Fix use-after-free issue in eth_skb_pkt_type()
      selftests/bpf: Adjust data size to have ETH_HLEN

Yan Zhai (2):
      bpf: skip non exist keys in generic_map_lookup_batch
      selftests: bpf: test batch lookup on array of maps with holes

 Documentation/networking/strparser.rst             |   9 +-
 include/linux/skmsg.h                              |   2 +
 include/net/strparser.h                            |   2 +
 include/net/tcp.h                                  |   8 +
 kernel/bpf/arena.c                                 |   2 +-
 kernel/bpf/bpf_cgrp_storage.c                      |   2 +-
 kernel/bpf/btf.c                                   |   2 +
 kernel/bpf/ringbuf.c                               |   4 -
 kernel/bpf/syscall.c                               |  43 +-
 kernel/bpf/verifier.c                              |  31 +-
 net/bpf/test_run.c                                 |   5 +-
 net/core/bpf_sk_storage.c                          |  13 +-
 net/core/skmsg.c                                   |   7 +
 net/core/sock_map.c                                |   5 +-
 net/ipv4/tcp.c                                     |  29 +-
 net/ipv4/tcp_bpf.c                                 |  36 ++
 net/strparser/strparser.c                          |  11 +-
 .../selftests/bpf/map_tests/map_in_map_batch_ops.c |  62 ++-
 .../selftests/bpf/prog_tests/sockmap_basic.c       |  59 +--
 .../selftests/bpf/prog_tests/sockmap_strp.c        | 454 +++++++++++++++++++++
 .../selftests/bpf/prog_tests/xdp_cpumap_attach.c   |   4 +-
 .../selftests/bpf/prog_tests/xdp_devmap_attach.c   |   8 +-
 .../selftests/bpf/progs/test_sockmap_strp.c        |  53 +++
 .../selftests/bpf/progs/verifier_array_access.c    |  15 +
 24 files changed, 726 insertions(+), 140 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sockmap_strp.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_strp.c

