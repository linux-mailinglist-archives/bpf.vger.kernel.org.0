Return-Path: <bpf+bounces-64775-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA52B16DCA
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 10:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D507622BF5
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 08:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C64329E10F;
	Thu, 31 Jul 2025 08:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="i/rxYP1f"
X-Original-To: bpf@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A728729C35C;
	Thu, 31 Jul 2025 08:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753951373; cv=none; b=C89z+ZzahjCm6tYzXgB6wCyet0Vib70RlGdkWxpsS01ZGUtxl02SDQVnj8fnNjD0yq78u4hVoPMCldt8DDEmykPM+OqPmOcdQZF2HDWNTkCP/8COXAh4wLpxHMGTEpd6Jsxm6dxekHSY8goGXMMEBJFgDRXe55ATBIpOOqzcMDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753951373; c=relaxed/simple;
	bh=XJ2zGGB/PxqgOFtOSX9h5mswS1Wwp0kU/lMvORm9/t0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OEz+N7wjxqQoe5dup0u+tVtpMtt6O0JK6oVioOKSrj5Q3r0t4eGyce19zF6FU3M9utLX8XohMgm4CI4oq+sqaT1lI/+BCp+0oGdSyUSo/Nxt4sy9Snqjl2WkLnvsvbuCzQaL7AXkCQP5K4i9rFh9+TND193gscbOk2Vld5kX8e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=i/rxYP1f; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753951368; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=AU1sjQom/y8TUT5U80ZfkzDLj8w9VkHGHIfk54RL18U=;
	b=i/rxYP1fqpSAClAnPlBqV0RVIq11xEKCJ3J7pXPSTgRelVMqktviYKO7aKWYGQteX8OcQy7behY9WEv13rMnXOCuGAyiq4OGTILKIOK+TcSSQ3/d6Ca9yQpkDCUX94HwQJxPbPnIs5JV8f/+aqhmIVgKfnDrAtgRP5iAX1zMThk=
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WkXYUie_1753951360 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 31 Jul 2025 16:42:47 +0800
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
	Mahanta.Jambigi@ibm.com,
	Sidraya.Jayagond@ibm.com,
	wenjia@linux.ibm.com,
	wintera@linux.ibm.com,
	dust.li@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com
Cc: bpf@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	jaka@linux.ibm.com
Subject: [PATCH bpf-next 0/5] net/smc: Introduce smc_hs_ctrl
Date: Thu, 31 Jul 2025 16:42:35 +0800
Message-ID: <20250731084240.86550-1-alibuda@linux.alibaba.com>
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

D. Wythe (5):
  bpf: export necessary sympols for modules with struct_ops
  net/smc: fix UAF on smcsk after smc_listen_out()
  net/smc: bpf: Introduce generic hook for handshake flow
  libbpf: fix error when st-prefix_ops and ops from differ btf
  bpf/selftests: add selftest for bpf_smc_hs_ctrl

 include/net/netns/smc.h                       |   3 +
 include/net/smc.h                             |  53 +++
 kernel/bpf/bpf_struct_ops.c                   |   2 +
 kernel/bpf/syscall.c                          |   1 +
 net/ipv4/tcp_output.c                         |  18 +-
 net/smc/Kconfig                               |  12 +
 net/smc/Makefile                              |   1 +
 net/smc/af_smc.c                              |  14 +-
 net/smc/smc_hs_bpf.c                          | 131 ++++++
 net/smc/smc_hs_bpf.h                          |  31 ++
 net/smc/smc_sysctl.c                          |  90 ++++
 tools/lib/bpf/libbpf.c                        |  37 +-
 tools/testing/selftests/bpf/config            |   4 +
 .../selftests/bpf/prog_tests/test_bpf_smc.c   | 396 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/bpf_smc.c   | 117 ++++++
 15 files changed, 886 insertions(+), 24 deletions(-)
 create mode 100644 net/smc/smc_hs_bpf.c
 create mode 100644 net/smc/smc_hs_bpf.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_bpf_smc.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_smc.c

-- 
2.45.0


