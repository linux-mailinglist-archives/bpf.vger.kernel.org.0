Return-Path: <bpf+bounces-68740-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F536B836AF
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 10:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A0893B9429
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 08:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C8F2F0685;
	Thu, 18 Sep 2025 08:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XPy0yXI+"
X-Original-To: bpf@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B802EE272;
	Thu, 18 Sep 2025 08:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758182638; cv=none; b=KY2zEwTN0S2Qy0gVmfFouB1FrYSOlSRc12xarHSC4IRSxBUHtxUkkwAV0JP/kKQTu+ohQIuws5OFrAFUw+vacnxXM5vIk1RmsvduMil1Ud2ckQOI2AoVEA+PKjAbXfMv94b+idRCjKiRXQATEJ2lsHm97QqFyjjziKgmmfO2hfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758182638; c=relaxed/simple;
	bh=YQZTH7tPL5tZOiDigTtIiUXnn7Zl/OqHBVf/WRWvy6E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rBrPJPDGbMb5vAxvtrOoAhbIzGHjWqJ5gE5ENKuMM5YMnAQO2ePDPajOPD8m1aKhenuFLvEqge+KL4AAxc9m+1SEn2JuIVW5sWcvYE9O03dJM3UF3TOe8UdhiiH4mhlW4PegUnSJPbxdS5RntdlAfBVRbto3EJTdEHAW+rF9vno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XPy0yXI+; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758182627; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=o8zVttKRsDZXMwAMsefgpttoLLuOJgFi3OBVDXrLxLA=;
	b=XPy0yXI+VKFx1rEAnVYam6AopG2UyZ/bVTc5JPYb6zo3NAaVH971WOqnttHLq5eflayqZm8GI37RscD0H+ktVP8ZnWO5WMIPigESe8fwCdcfBSxF2rvAKmpqhBKdEX3WwkSfpoE+QnPoQJz3l3o7jq+llAuVdEC/wKNpfQqIw5A=
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WoFEU0W_1758182622 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 18 Sep 2025 16:03:45 +0800
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
Subject: [PATCH bpf-next v2 0/4] net/smc: Introduce smc_hs_ctrl
Date: Thu, 18 Sep 2025 16:03:37 +0800
Message-ID: <20250918080342.25041-1-alibuda@linux.alibaba.com>
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

D. Wythe (4):
  bpf: export necessary symbols for modules with struct_ops
  net/smc: bpf: Introduce generic hook for handshake flow
  libbpf: fix error when st-prefix_ops and ops from differ btf
  bpf/selftests: add selftest for bpf_smc_hs_ctrl

 include/net/netns/smc.h                       |   3 +
 include/net/smc.h                             |  53 +++
 kernel/bpf/bpf_struct_ops.c                   |   2 +
 kernel/bpf/syscall.c                          |   1 +
 net/ipv4/tcp_output.c                         |  36 +-
 net/smc/Kconfig                               |  10 +
 net/smc/Makefile                              |   1 +
 net/smc/af_smc.c                              |  10 +
 net/smc/smc_hs_bpf.c                          | 137 ++++++
 net/smc/smc_hs_bpf.h                          |  31 ++
 net/smc/smc_sysctl.c                          |  91 ++++
 tools/lib/bpf/libbpf.c                        |  37 +-
 tools/testing/selftests/bpf/config            |   4 +
 .../selftests/bpf/prog_tests/test_bpf_smc.c   | 396 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/bpf_smc.c   | 117 ++++++
 15 files changed, 896 insertions(+), 33 deletions(-)
 create mode 100644 net/smc/smc_hs_bpf.c
 create mode 100644 net/smc/smc_hs_bpf.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_bpf_smc.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_smc.c

-- 
2.45.0


