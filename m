Return-Path: <bpf+bounces-47908-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91468A01D59
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 03:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ECB7162653
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 02:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF35913775E;
	Mon,  6 Jan 2025 02:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="PplxVzKy"
X-Original-To: bpf@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FD013AF2;
	Mon,  6 Jan 2025 02:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736130163; cv=none; b=E6VBPrWZzWVY5qR5ZAups12mcfMM+y74Ced/ZDNFzrh81KZurFRcUd4W/QBf/yq9L6lLzG4lF+0m9JmrTYMGe4JioqeqiJLXUJwX3mJOUJhU+N62RN3qVn8aJZjBUqAMRAO+jf/GChga92EYjvtl9/mWWDKR21SvPKqwQuo7NEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736130163; c=relaxed/simple;
	bh=/UAKx7+AH+uKFvvq+tKZtYpMunACvUkqXk9VOc13SZI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M94iz1DUt03Hgslz7fnFc3p62DjmlobzCZM0al8z7cXCNytaMTPzs9PoErLLmg0P0UHu11QsdGrLo/aeIEn6eVfskdc92xC0C8Gz/WxnKMdsrNhqbO/VPVng+UHaXDOQCTt2JIgaqC4QSk0tQHy24iBNbTGPLnistKFUsfRzOpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=PplxVzKy; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736130152; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=VumQ49wdkkurC+YY2fqX2Z+oQ35Z2HVWdlfuuZ3OLz4=;
	b=PplxVzKy3Swj1HsaCa/PgmjUYjhqu6aVkIMDzago1naSuJq7dL+ujdA3FjxOKOma8vCu3CF8KoiUH/VPvlsDwdx/fy9+2EHO2g3Am/oX0pSTN6gWSqMDV4bJyFdJKH13+XXsJsvsGAyAZ/WQpYtkc+UXzk0mN7hYHC48Vy0eIuM=
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WMzlXTX_1736130142 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 06 Jan 2025 10:22:30 +0800
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
Subject: [PATCH bpf-next v4 0/5] net/smc: Introduce smc_ops
Date: Mon,  6 Jan 2025 10:22:17 +0800
Message-ID: <20250106022222.80203-1-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patches attempt to introduce BPF injection capability for SMC,
and add selftest to ensure code stability.

Since the SMC protocol is not suitable for all scenarios,
especially for short-lived. For most applications, they cannot
guarantee that there are no such scenarios at all. Therefore, apps
may need some specific strategies to decide shall we need to use SMC
or not, for example, apps can limit the scope of the SMC to a specific
IP address or port.

Based on the consideration of transparent replacement, we hope that apps
can remain transparent even if they need to formulate some specific
strategies for SMC using. That is, do not need to recompile their code.

On the other hand, we need to ensure the scalability of strategies
implementation. Although it is simple to use socket options or sysctl,
it will bring more complexity to subsequent expansion.

Fortunately, BPF can solve these concerns very well, users can write
thire own strategies in eBPF to choose whether to use SMC or not.
And it's quite easy for them to modify their strategies in the future.

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
  3. Chnage CONFIG_SMC=y to complete CI testing
  4. Change smc_sock to smc_sock___local in test to avoid
     compiling failed with CONFIG_SMC=y
  5. Improve test cases, remove unnecessary timeouts and multi-thread
     test, using network_helpers to start testing between server and
     client.
  6. Fix issues when the return value of the ops function is neither 0 nor 1.

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


