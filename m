Return-Path: <bpf+bounces-30713-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 216EB8D1912
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 12:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 863171F2628C
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 10:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8072416C458;
	Tue, 28 May 2024 10:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Ql2R6Eke"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85F317E8F0;
	Tue, 28 May 2024 10:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716893973; cv=none; b=L9FdjFGSD+lLgG8kOsj4Jwq/fuayxwFZmMAHa8dpudLWSmfMTYpWwK/KrCvXz7wOGK3Y2XBA8TFrihDPuTSxBrR8g5qSoBWXRKlGMw/VnrTXZeD3lX4HKHwgNIHqiPHG0QGS1IIm47G1251SzKh5HMwzAz7QdPyXbcDnSzMtubo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716893973; c=relaxed/simple;
	bh=Zwclxo8uDsIen+bm06C2VqVRVoKofqDRrV5Zmus/3qc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=bo9pKw0Zb6PdY/kAxTaHTlPXtE8gsN+1AsHpUxKIgjOPdBSuCjBtICY+DJB4DKNYdp9qcTs6uOE2B4buw2wqMA4VqwiTe1LSpDT/5eJeaA6JrB/eYRLCJqrblSIBbpe/+58Yj0nhDe8P5RctR3kZYyR31XJtZiUMYhU72OmFkJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=Ql2R6Eke; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=q8Xuv5FaJiM2/quKX6bmmqnQXAi2Tg4XwUL9n+IdHWQ=; b=Ql2R6EkeFG0ZFimtB4nrx5IA6h
	EVvJzIMT9PQK3r8GuardqxsTC3kcDjXs9JHtzdzIMot5K8OVcrruPYJXEkqEYz9vDxnaLdEPFEv9g
	dlapy05LcWAGt97nNs1HqjZ3x22cGRjcD8ozGEFz7E0ljCj8U70m4V9VcZ2PC2q55BT720kcbHH0J
	j9G2pxENut9P1HRJVMSW7S/qZhiwLDzIf3LpjrcLSEz/H4DT0+/1jBGhCFEjZT28go2i1AEE8hkKL
	PaEH1Fud9BND97wF3K1MDT4Fsw+LNJDKL9EaHX/cqilxqFGaOCBSwcut0AtKPL5Qbl8uWYv176Qhm
	LYGRGk+w==;
Received: from 14.248.197.178.dynamic.dsl-lte-bonding.zhbmb00p-msn.res.cust.swisscom.ch ([178.197.248.14] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sBuY9-0007ga-0Q; Tue, 28 May 2024 12:59:25 +0200
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
Subject: pull-request: bpf-next 2024-05-28
Date: Tue, 28 May 2024 12:59:24 +0200
Message-Id: <20240528105924.30905-1-daniel@iogearbox.net>
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
X-Virus-Scanned: Clear (ClamAV 0.103.10/27289/Tue May 28 10:30:59 2024)

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net-next* tree.

We've added 23 non-merge commits during the last 11 day(s) which contain
a total of 45 files changed, 696 insertions(+), 277 deletions(-).

The main changes are:

1) Rename skb's mono_delivery_time to tstamp_type for extensibility and add
   SKB_CLOCK_TAI type support to bpf_skb_set_tstamp(), from Abhishek Chauhan.

2) Add netfilter CT zone ID and direction to bpf_ct_opts so that arbitrary CT zones
   can be used from XDP/tc BPF netfilter CT helper functions, from Brad Cowie.

3) Several tweaks to the instruction-set.rst IETF doc to address the Last Call
   review comments, from Dave Thaler.

4) Small batch of riscv64 BPF JIT optimizations in order to emit more compressed
   instructions to the JITed image for better icache efficiency, from Xiao Wang.

5) Sort bpftool C dump output from BTF, aiming to simplify vmlinux.h diffing and
   forcing more natural type definitions ordering, from Mykyta Yatsenko.

6) Use DEV_STATS_INC() macro in BPF redirect helpers to silence a syzbot/KCSAN
   race report for the tx_errors counter, from Jiang Yunshui.

7) Un-constify bpf_func_info in bpftool to fix compilation with LLVM 17+ which
   started treating const structs as constants and thus breaking full BTF program
   name resolution, from Ivan Babrou.

8) Fix up BPF program numbers in test_sockmap selftest in order to reduce some
   of the test-internal array sizes, from Geliang Tang.

9) Small cleanup in Makefile.btf script to use test-ge check for v1.25-only
   pahole, from Alan Maguire.

10) Fix bpftool's make dependencies for vmlinux.h in order to avoid needless
    rebuilds in some corner cases, from Artem Savkov.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Andrew Jones, Andrii Nakryiko, Björn Töpel, Christoph Hellwig, David 
Vernet, Joel Granados, Martin KaFai Lau, Nick Desaulniers, Pu Lehui, 
Quentin Monnet, syzbot, Willem de Bruijn, Yonghong Song

----------------------------------------------------------------

The following changes since commit 4b377b4868ef17b040065bd468668c707d2477a5:

  kprobe/ftrace: fix build error due to bad function definition (2024-05-17 19:17:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

for you to fetch changes up to d9cbd8343b010016fcaabc361c37720dcafddcbe:

  bpf, net: Use DEV_STAT_INC() (2024-05-28 12:04:11 +0200)

----------------------------------------------------------------
bpf-next-for-netdev

----------------------------------------------------------------
Abhishek Chauhan (3):
      net: Rename mono_delivery_time to tstamp_type for scalabilty
      net: Add additional bit to support clockid_t timestamp type
      selftests/bpf: Handle forwarding of UDP CLOCK_TAI packets

Alan Maguire (1):
      kbuild, bpf: Use test-ge check for v1.25-only pahole

Artem Savkov (1):
      bpftool: Fix make dependencies for vmlinux.h

Brad Cowie (2):
      net: netfilter: Make ct zone opts configurable for bpf ct helpers
      selftests/bpf: Update tests for new ct zone opts for nf_conntrack kfuncs

Dave Thaler (6):
      bpf, docs: Move sentence about returning R0 to abi.rst
      bpf, docs: Use RFC 2119 language for ISA requirements
      bpf, docs: clarify sign extension of 64-bit use of 32-bit imm
      bpf, docs: Add table captions
      bpf, docs: Clarify call local offset
      bpf, docs: Fix instruction.rst indentation

Geliang Tang (1):
      selftests/bpf: Fix prog numbers in test_sockmap

Ivan Babrou (1):
      bpftool: Un-const bpf_func_info to fix it for llvm 17 and newer

Martin KaFai Lau (1):
      Merge branch 'Replace mono_delivery_time with tstamp_type'

Mohammad Shehar Yaar Tausif (1):
      bpf: Fix order of args in call to bpf_map_kvcalloc

Mykyta Yatsenko (1):
      bpftool: Introduce btf c dump sorting

Thomas Weißschuh (1):
      bpf: constify member bpf_sysctl_kern:: Table

Xiao Wang (3):
      riscv, bpf: Optimize zextw insn with Zba extension
      riscv, bpf: Use STACK_ALIGN macro for size rounding up
      riscv, bpf: Try RVC for reg move within BPF_CMPXCHG JIT

Ying Zhang (1):
      bpf: Remove unused variable "prev_state"

yunshui (1):
      bpf, net: Use DEV_STAT_INC()

 Documentation/bpf/standardization/abi.rst          |   3 +
 .../bpf/standardization/instruction-set.rst        | 261 ++++++++++++---------
 arch/riscv/Kconfig                                 |  12 +
 arch/riscv/net/bpf_jit.h                           |  18 ++
 arch/riscv/net/bpf_jit_comp64.c                    |  12 +-
 include/linux/filter.h                             |   2 +-
 include/linux/skbuff.h                             |  68 ++++--
 include/net/inet_frag.h                            |   4 +-
 include/uapi/linux/bpf.h                           |  15 +-
 kernel/bpf/bpf_local_storage.c                     |   4 +-
 net/bridge/netfilter/nf_conntrack_bridge.c         |   6 +-
 net/core/dev.c                                     |   2 +-
 net/core/filter.c                                  |  62 ++---
 net/ieee802154/6lowpan/reassembly.c                |   2 +-
 net/ipv4/inet_fragment.c                           |   2 +-
 net/ipv4/ip_fragment.c                             |   2 +-
 net/ipv4/ip_output.c                               |  14 +-
 net/ipv4/raw.c                                     |   2 +-
 net/ipv4/tcp_ipv4.c                                |   2 +
 net/ipv4/tcp_output.c                              |  14 +-
 net/ipv6/ip6_output.c                              |  11 +-
 net/ipv6/netfilter.c                               |   6 +-
 net/ipv6/netfilter/nf_conntrack_reasm.c            |   2 +-
 net/ipv6/raw.c                                     |   2 +-
 net/ipv6/reassembly.c                              |   2 +-
 net/ipv6/tcp_ipv6.c                                |  12 +-
 net/netfilter/nf_conntrack_bpf.c                   |  68 +++++-
 net/packet/af_packet.c                             |   7 +-
 net/sched/act_bpf.c                                |   4 +-
 net/sched/cls_bpf.c                                |   4 +-
 samples/bpf/cpustat_kern.c                         |   3 +-
 scripts/Makefile.btf                               |   4 +-
 tools/bpf/bpftool/Documentation/bpftool-btf.rst    |   6 +-
 tools/bpf/bpftool/Makefile                         |   3 +-
 tools/bpf/bpftool/bash-completion/bpftool          |   3 +
 tools/bpf/bpftool/btf.c                            | 138 ++++++++++-
 tools/bpf/bpftool/common.c                         |   2 +-
 tools/include/uapi/linux/bpf.h                     |  15 +-
 tools/testing/selftests/bpf/config                 |   1 +
 tools/testing/selftests/bpf/prog_tests/bpf_nf.c    |   7 +
 .../testing/selftests/bpf/prog_tests/ctx_rewrite.c |  10 +-
 .../testing/selftests/bpf/prog_tests/tc_redirect.c |   3 -
 tools/testing/selftests/bpf/progs/test_bpf_nf.c    | 108 +++++++++
 tools/testing/selftests/bpf/progs/test_tc_dtime.c  |  39 ++-
 tools/testing/selftests/bpf/test_sockmap.c         |   6 +-
 45 files changed, 696 insertions(+), 277 deletions(-)

