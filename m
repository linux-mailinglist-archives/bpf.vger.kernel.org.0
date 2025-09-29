Return-Path: <bpf+bounces-69932-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2F4BA821E
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 08:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CB1C16E1AD
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 06:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71662BDC3B;
	Mon, 29 Sep 2025 06:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NGGwuuW6"
X-Original-To: bpf@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89C51D516C;
	Mon, 29 Sep 2025 06:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759127657; cv=none; b=lfNncoxDQa3WQPzcmCKTkUn6CJdDyuwiinHykx0xexBlyxUzGptvL/l0F1RvUC43NhlO+NHoMejLJHUDmGEOSYyyrnjhpDvkrG73Minr8d2OvPb+SyB9+xcFlqMc7aElD7Hemk2vcJ4FnelxozjRWL4s9HzWhLFhshC92OUZ4wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759127657; c=relaxed/simple;
	bh=0JBOT16bqREsg6bBh1GdoAoUwO3B4Q17yGAx/pqNMXs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WTBH4fGZjni8aUNy/EP0oTUaLOKaTrSHmM2Z4G1OMkZJVU6xXuY+XPWTpU4LKn4nmIkxsCr+TypSZavF56mWfvpgqZXUZhoY+9VZw8FGJHyBrDM+0ZobHsVSzLEY1/300tKnxtoVggl+HXo0Ce9eVKqvS9B220+XjROiK89xrrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NGGwuuW6; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1759127645; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=JfvgI++WoZZ+9KLdtA6+XaUxm0nhhXpZ8xv36V65QA8=;
	b=NGGwuuW6aNwpN1zoZAAxteo9MQ+Hv8A0U9GrTgXEYt08NjgGhlBHv+w/WO2xlX0WcA38C9nVjn0ygrZhwSojEc6Ic0SYOvFinqBQN1aola2Bkk3WQRvUZ5WLIrg1aKIoNwbepMQTxHlqr6hF6nHmA9CTC2lAIxKGmv8/ySTH96s=
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0Wp07vZL_1759127640 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 29 Sep 2025 14:34:04 +0800
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
Subject: [PATCH bpf-next v3 0/3] net/smc: Introduce smc_hs_ctrl
Date: Mon, 29 Sep 2025 14:33:57 +0800
Message-ID: <20250929063400.37939-1-alibuda@linux.alibaba.com>
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

D. Wythe (3):
  bpf: export necessary symbols for modules with struct_ops
  net/smc: bpf: Introduce generic hook for handshake flow
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
 tools/testing/selftests/bpf/config            |   4 +
 .../selftests/bpf/prog_tests/test_bpf_smc.c   | 396 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/bpf_smc.c   | 117 ++++++
 14 files changed, 878 insertions(+), 14 deletions(-)
 create mode 100644 net/smc/smc_hs_bpf.c
 create mode 100644 net/smc/smc_hs_bpf.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_bpf_smc.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_smc.c

-- 
2.45.0


