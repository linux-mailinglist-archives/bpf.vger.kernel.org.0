Return-Path: <bpf+bounces-49555-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC70A19CB3
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 03:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CC04188F058
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 02:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E42085626;
	Thu, 23 Jan 2025 02:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OLav0dyd"
X-Original-To: bpf@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2405A17741;
	Thu, 23 Jan 2025 01:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737597599; cv=none; b=dJt/vISRGBSmzXIVLNX2KXeZ8vFRl1yffI5JU2QswhOcoQfx9Tktt752h+lFvnzptz74AQBCJinn4reFVVIBKQBW0gNzZVggrAFkiox5On3dosdEdES27bgXqKcJa61f+fv2hkMJbY9pbtwAuesKNk/tSJK6sjhIQwNSGXEoiM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737597599; c=relaxed/simple;
	bh=eRskHU/WUvePbwISvgcAgI72IVUm/QmGMMyssyqBQuU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ngZnGlJHeMGo6HvHfxRG6FzKwgJlcy4im8ucrtX5o1l3zl6MSdX4nhCCrTbNQhj8jGRRYdrtofR2c2NZ6akySP1xqtVt2VdvMFe5O3U88JkG5ZQBLFpHZrVC6PNEx7QKdSiggbCS/cynMfZNNTJyC0v9XM6Qn/3g5IcNvxKxGb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OLav0dyd; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737597588; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=rqkK4Fa05O4jYFfWx+iq53v/+mmKBvlIuTXvfqc+pk4=;
	b=OLav0dydfCQPBv7Mm28hxybRHbDLIdCG3t09rNiQPFsv++UdIaC2aDD3USDgTDEHpXs01ZbzacpfGMVjGBRCF/ub2q156I5TFCUbuN0uGf+X9SxBxe/I03mwww/iEhadeiPR8BRp+Gl6IsglkaiMvZsqmqxKjyVZfWmTdtKLUwY=
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WO9yfDO_1737597582 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 23 Jan 2025 09:59:47 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com>
To: kgraul@linux.ibm.com,
	wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	pabeni@redhat.com,
	song@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	yhs@fb.com,
	edumazet@google.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	jolsa@kernel.org,
	guwen@linux.alibaba.com
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v7 0/6] net/smc: Introduce smc_ops
Date: Thu, 23 Jan 2025 09:59:36 +0800
Message-ID: <20250123015942.94810-1-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch aims to introduce BPF injection capabilities for SMC and
includes a self-test to ensure code stability.

Since the SMC protocol isn't ideal for every situation, especially
short-lived ones, most applications can't guarantee the absence of
such scenarios. Consequently, applications may need specific strategies
to decide whether to use SMC. For example, an application might limit SMC
usage to certain IP addresses or ports.

To maintain the principle of transparent replacement, we want applications
to remain unaffected even if they need specific SMC strategies. In other
words, they should not require recompilation of their code.

Additionally, we need to ensure the scalability of strategy implementation.
While using socket options or sysctl might be straightforward, it could
complicate future expansions.

Fortunately, BPF addresses these concerns effectively. Users can write
their own strategies in eBPF to determine whether to use SMC, and they can
easily modify those strategies in the future.

v2:
  1. Rename smc_bpf_ops to smc_ops.
  2. Change the scope of smc_ops from global to per netns.
  3. Directly pass parameters to ops instead of smc_ops_ctx.
  4. Remove struct smc_ops_ctx.
  5. Remove exports that are no longer needed.

v3:
  1. Remove find_ksym_btf_id_by_prefix_kind.
  2. Enhance selftest, introduce a complete ops for filtering smc
     connections based on ip pairs and a realistic topology test
     to verify it.

v4:
  1. Remove unless func: smc_bpf_ops_check_member()
  2. Remove unless inline func: smc_ops_find_by_name()
  3. Change CONFIG_SMC=y to complete CI testing
  4. Change smc_sock to smc_sock___local in test to avoid
     compiling failed with CONFIG_SMC=y
  5. Improve test cases, remove unnecessary timeouts and multi-thread
     test, using network_helpers to start testing between server and
     client.
  6. Fix issues when the return value of the ops function is neither 0
     nor 1.

v5:
  1. Fix incorrect CI config from CONFIG_SMC=Y to CONFIG_SMC=y.

v6:
  1. Fix some spelling errors and code styles.
  2. Fix test failed under s390x.
  3. New approach to fix libbpf exceptions.
  4. Fix warning & failure when compiling "Introduce generic hook smc_ops".

v7:
  1. Fix some code styles.
  2. Added a fix patch for the potential UAF issue in SMC, which can occur
     easily during BPF CI tests.
  3. Fix the incorrect usage of rcu_replace_pointer and replace it with
     xhcg.
  4. Remove the forced type conversion in smc_call_retops.
  5. Use more appropriate assert macros for testing code.
  6. Remove unnecessary BPF_CORE_READ.

D. Wythe (6):
  bpf: export necessary sympols for modules with struct_ops
  net/smc: fix UAF on smcsk after smc_listen_out()
  net/smc: Introduce generic hook smc_ops
  net/smc: bpf: register smc_ops info struct_ops
  libbpf: fix error when st-prefix_ops and ops from differ btf
  bpf/selftests: add selftest for bpf_smc_ops


D. Wythe (6):
  bpf: export necessary sympols for modules with struct_ops
  net/smc: fix UAF on smcsk after smc_listen_out()
  net/smc: Introduce generic hook smc_ops
  net/smc: bpf: register smc_ops info struct_ops
  libbpf: fix error when st-prefix_ops and ops from differ btf
  bpf/selftests: add selftest for bpf_smc_ops

 include/net/netns/smc.h                       |   3 +
 include/net/smc.h                             |  53 +++
 kernel/bpf/bpf_struct_ops.c                   |   2 +
 kernel/bpf/syscall.c                          |   1 +
 net/ipv4/tcp_output.c                         |  18 +-
 net/smc/Kconfig                               |  12 +
 net/smc/Makefile                              |   1 +
 net/smc/af_smc.c                              |  14 +-
 net/smc/smc_ops.c                             | 131 ++++++
 net/smc/smc_ops.h                             |  33 ++
 net/smc/smc_sysctl.c                          |  90 ++++
 tools/lib/bpf/libbpf.c                        |  37 +-
 tools/testing/selftests/bpf/config            |   4 +
 .../selftests/bpf/prog_tests/test_bpf_smc.c   | 396 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/bpf_smc.c   | 117 ++++++
 15 files changed, 888 insertions(+), 24 deletions(-)
 create mode 100644 net/smc/smc_ops.c
 create mode 100644 net/smc/smc_ops.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_bpf_smc.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_smc.c

-- 
2.45.0


