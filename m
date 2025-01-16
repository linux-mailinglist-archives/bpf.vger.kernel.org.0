Return-Path: <bpf+bounces-49033-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A92D7A13424
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 08:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C78071887C75
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 07:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524BA19CC17;
	Thu, 16 Jan 2025 07:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="atuTw00F"
X-Original-To: bpf@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098DE156F3C;
	Thu, 16 Jan 2025 07:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737013499; cv=none; b=JOzhJCw2dU9hasyenSiNSy5KqAcIveytBJfe+W+rLKlnE8kR6krjVIjjLT36jwsqD7CM9AwtVXR6GiitoGPSwttq1Px94rv35kOMeae0pmI3mg3Q12Fflfy6PtwZgVsN6Ta76ds9sQ3zeIcQAZMcrhqxSojhAeUvn1BqIDJVSIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737013499; c=relaxed/simple;
	bh=IkUWEiqCfwgcBMl8YOcCwEabkRVt2+J0NgUDk6KCzns=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MQRgfDx1q3a4UMLvb9r8m7GAL1Gu3a8btyc2panlUTtVBzEfcNyXxD7n7oYKLv0CobWDtALg9LZm5GwCCw6Q3DU7dbLQ0HZziGuo2D3tsgswOCMFNh0IW8t+4rViUjTq/8Vhhvt4Lqq7DyjZHMCzE98aZY6fxFT1WWDsA231cI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=atuTw00F; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737013489; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=azLCkbmXd5YdO8Cf2z7LXr4xJzgS0q6e+uJE53oNtj4=;
	b=atuTw00FnkvhM7i0wtHoJti1FIYfCG8Y9zevLGzVRNlmnUEJeMugvdcyqsUpvWtdFQXq9KwB/9vpS/1FdBBCQdPH8WgTYWw4ULz1/ArQUmoxyPbV1DIAhmeL4oP+PbufVsEdhGLy6Jm/gM7om42jMxNS1yAh1CS+zGWD4i7mw6I=
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WNkukTj_1737013482 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 16 Jan 2025 15:44:48 +0800
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
Subject: [PATCH bpf-next v6 0/5] net/smc: Introduce smc_ops
Date: Thu, 16 Jan 2025 15:44:37 +0800
Message-ID: <20250116074442.79304-1-alibuda@linux.alibaba.com>
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

D. Wythe (5):
  bpf: export necessary sympols for modules with struct_ops
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
 net/smc/af_smc.c                              |  11 +
 net/smc/smc_ops.c                             | 131 ++++++
 net/smc/smc_ops.h                             |  33 ++
 net/smc/smc_sysctl.c                          |  94 +++++
 tools/lib/bpf/libbpf.c                        |  41 +-
 tools/testing/selftests/bpf/config            |   4 +
 .../selftests/bpf/prog_tests/test_bpf_smc.c   | 397 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/bpf_smc.c   | 117 ++++++
 15 files changed, 896 insertions(+), 22 deletions(-)
 create mode 100644 net/smc/smc_ops.c
 create mode 100644 net/smc/smc_ops.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_bpf_smc.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_smc.c

-- 
2.45.0


