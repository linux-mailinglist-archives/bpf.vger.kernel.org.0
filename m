Return-Path: <bpf+bounces-73934-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25475C3E66B
	for <lists+bpf@lfdr.de>; Fri, 07 Nov 2025 04:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDCB1188ACB5
	for <lists+bpf@lfdr.de>; Fri,  7 Nov 2025 03:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED612459DD;
	Fri,  7 Nov 2025 03:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Ia0w6B3Q"
X-Original-To: bpf@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EB71DE2A7;
	Fri,  7 Nov 2025 03:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762487809; cv=none; b=jrESG9qZFJHobEJY5wmZV+GyOGnw7+kOpZLQVqk1hOtOj//vjdMwF2IqtX7ULqdK9L96/eVeHfkjOCZFBO4mylPE2JLinksHlCPAKWBMAlqxF4iQq18jcCG51+iNFu/Q0LHuwk4/GV4YFAvs6hWbKv2+iNhG2LntClPNe0h7i3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762487809; c=relaxed/simple;
	bh=IVc2RUkhKiVek0AYYU61rEaYNFiTYCteaVBngxzs3Tc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mFI0G0NNV8sKSF0sk2MkxqLt31HzyMHikEbrq5uJn4QE4T4ZAopg17fZYs3Be7EB1uwUHOvEtHW6eKaosWLGrDDaOnaorhgdwlBjU8VA85Qnym2pKIzxoQKOkaX5QnwOm64dUG52iCLsvuI94IcSItWSfz2Av+K5Qs4IY6afYts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Ia0w6B3Q; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1762487798; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=GF2M2zMDikm9WiulQgCUScfge/dNdtBmwtUwBDT7SNU=;
	b=Ia0w6B3QB3BxqB5+tfiRbW30CiD0nY7A2G2H5UogfOaBdZwM5K0gYBFr2LG9DGcLJ/lPha8ffjtbWsgTy9RNkfP0YDhCorN/vJe1NSgZVh/hwn7RCvw34jw/8EFh6JHitBq0NhkVtzctiKbivJckpeXSXsCqc6KkRxghFQssUSo=
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WrrauKt_1762487792 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 07 Nov 2025 11:56:36 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com>
To: ast@kernel.org,
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
	mjambigi@linux.ibm.com,
	wenjia@linux.ibm.com,
	wintera@linux.ibm.com,
	dust.li@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com
Cc: bpf@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	sidraya@linux.ibm.com,
	jaka@linux.ibm.com
Subject: [PATCH bpf-next v5 0/3] net/smc: Introduce smc_hs_ctrl
Date: Fri,  7 Nov 2025 11:56:29 +0800
Message-ID: <20251107035632.115950-1-alibuda@linux.alibaba.com>
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

This is a rework of the series from [1]. Changes since [1] are limited to
the SMC parts:

1. Rename smc_ops to smc_hs_ctrl and change interface name.
2. Squash SMC patches, removing standalone non-BPF hook capability.
3. Fix typos

[1]: https://lore.kernel.org/bpf/20250123015942.94810-1-alibuda@linux.alibaba.com/#t

v2 -> v1:
  - Removed the fixes patch, which have already been merged on current branch.
  - Fixed compilation warning of smc_call_hsbpf() when CONFIG_SMC_HS_CTRL_BPF
    is not enabled.
  - Changed the default value of CONFIG_SMC_HS_CTRL_BPF to Y.
  - Fix typo and renamed some variables

v3 -> v2:
  - Removed the libbpf patch, which have already been merged on current branch.
  - Fixed sparse warning of smc_call_hsbpf() and xchg().

v4 -> v3:
   - Rebased on latest bpf-next, updated SMC loopback config from SMC_LO to DIBS_LO
     per upstream changes.

v5 -> v4:
    - Removed the redundant sk parameter from smc_call_hsbpf
    - Reject registration when bpf_link is set, link support will be added in the
      future.
    - Updated selftests with new test heplers.

D. Wythe (3):
  bpf: export necessary symbols for modules with struct_ops
  net/smc: bpf: Introduce generic hook for handshake flow
  bpf/selftests: add selftest for bpf_smc_hs_ctrl

 include/net/netns/smc.h                       |   3 +
 include/net/smc.h                             |  53 +++
 kernel/bpf/bpf_struct_ops.c                   |   2 +
 kernel/bpf/syscall.c                          |   1 +
 net/ipv4/tcp_output.c                         |  31 +-
 net/smc/Kconfig                               |  10 +
 net/smc/Makefile                              |   1 +
 net/smc/af_smc.c                              |   9 +
 net/smc/smc_hs_bpf.c                          | 140 +++++++
 net/smc/smc_hs_bpf.h                          |  31 ++
 net/smc/smc_sysctl.c                          |  91 ++++
 tools/testing/selftests/bpf/config            |   5 +
 .../selftests/bpf/prog_tests/test_bpf_smc.c   | 390 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/bpf_smc.c   | 117 ++++++
 14 files changed, 870 insertions(+), 14 deletions(-)
 create mode 100644 net/smc/smc_hs_bpf.c
 create mode 100644 net/smc/smc_hs_bpf.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_bpf_smc.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_smc.c

-- 
2.45.0


