Return-Path: <bpf+bounces-48044-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 692EAA036E3
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 05:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEE823A3674
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 04:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26599157A72;
	Tue,  7 Jan 2025 04:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="R27ENXXl"
X-Original-To: bpf@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55835EC4;
	Tue,  7 Jan 2025 04:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736223448; cv=none; b=nVXhgHqsAKEX+l1YxyegJyDMSKSi9yLXAScnnGtrvI9/WCaO0zTPDxmYCKQkf/oJcPLWSLieAX/5xRj6x0POJGIieL0N41qFks4W+4adYcuk/pEdAIPsKiwaG0dFFb2GKtpQN/q8lKx1zQhuLNOCIGs32jN3/JNdT/TCQBfBtqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736223448; c=relaxed/simple;
	bh=uMpDJn4WL/ugF/STMkBP72XWPwlkjNOQtdWJGhDr3xk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HdfMSkByk4FwFMBNnUHbyJCdZBLzrhxNjQQojJCcq5ELeHJ5QCiL4aVM3hKVEXKUwI4HNMDb/FJN39i+5kV1R4jBQ+Xu4be6EjcR0NoyLmGlTNjIMM7Dp7ZO8IGtGdgsNl/r6+qrvkm9SU/fgEQ7JUWYA9sfazQfY/cE0N8K01A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=R27ENXXl; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736223442; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=bOH18qK4nR/W2tKNNGJkI+f12+0zwrmAacbo4a/CAX8=;
	b=R27ENXXl9Xl+N8tFk+0qlAg6Z7a/yADE0Ue5dt1I9VhROgJvk+K/kP94GPKYKlrzWrc5pzPbNuLklOWYH/Lgz5yQsx/c3c/nI5JB7mhfrckbyisCAjG9ly/dGZqONc+LI9wSJ/ocsejE2EhVwap1j2xrD8WUBsuhkDjHnrob3So=
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WN9KZYS_1736223435 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 07 Jan 2025 12:17:20 +0800
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
Subject: [PATCH bpf-next v5 0/5] net/smc: Introduce smc_ops
Date: Tue,  7 Jan 2025 12:17:10 +0800
Message-ID: <20250107041715.98342-1-alibuda@linux.alibaba.com>
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

D. Wythe (5):
  bpf: export necessary sympols for modules with struct_ops
  net/smc: Introduce generic hook smc_ops
  net/smc: bpf: register smc_ops info struct_ops
  libbpf: fix error when st-prefix_ops and ops from differ btf
  bpf/selftests: add selftest for bpf_smc_ops

 include/net/netns/smc.h                       |   3 +
 include/net/smc.h                             |  51 +++
 kernel/bpf/bpf_struct_ops.c                   |   2 +
 kernel/bpf/syscall.c                          |   1 +
 net/ipv4/tcp_output.c                         |  15 +-
 net/smc/Kconfig                               |  12 +
 net/smc/Makefile                              |   1 +
 net/smc/af_smc.c                              |  10 +
 net/smc/smc_ops.c                             | 130 ++++++
 net/smc/smc_ops.h                             |  30 ++
 net/smc/smc_sysctl.c                          |  95 +++++
 tools/lib/bpf/libbpf.c                        |  25 +-
 tools/testing/selftests/bpf/config            |   4 +
 .../selftests/bpf/prog_tests/test_bpf_smc.c   | 390 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/bpf_smc.c   | 116 ++++++
 15 files changed, 873 insertions(+), 12 deletions(-)
 create mode 100644 net/smc/smc_ops.c
 create mode 100644 net/smc/smc_ops.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_bpf_smc.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_smc.c

-- 
2.45.0


