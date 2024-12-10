Return-Path: <bpf+bounces-46481-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE429EA70D
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 05:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AE2A288725
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 04:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41BF226194;
	Tue, 10 Dec 2024 04:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tBEOA5V0"
X-Original-To: bpf@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B6C223C78;
	Tue, 10 Dec 2024 04:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733803779; cv=none; b=OhL+D5tuKy8tIr0Q1btAefmTFxjkELjoo9MLfRqvCk5+OwiPTRk1IAaazXaeXX3v1Gg1iCF0xC7vkX8KiNsIlIEe+vyQOH2tVYVE9P987EfDZSWkMaXkTEKE5sK0OTq7P5sDI3RRSSj7GG0ZmdKvBWwHbYNrM5rfFg6hvQ+2Xd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733803779; c=relaxed/simple;
	bh=g9mkesjaUq+e5IZEottqPnsqKLrsHTRONfsXjeGbtac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q2QfeW/NeYsQG0+KX//70iEAWT3/hP5IA/KGA4asgYSFT21CwG8LeRX2qQjtK9yoyDfA3zxYlHO833nU3iL04A+JM3wjGKQTzNbeO5X1IBzsLfGXAkrc45q+wvVRKbsz6dBvYXbnfij5qs9f++NVelgSwKDCd2udx5S8Aem2iTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tBEOA5V0; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733803774; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=6/Q1dEfws+7LpmLlumD7UVn5idRysTZwYHoRdWNn8ws=;
	b=tBEOA5V0JHj0eLFO1v1YHxhdfu+7Gtl6E1cohD8BYL+RB5LyCH3GO9EL2byi5/+wmg1/kyMRG6CG4RAv2El8KHdVzrCjw78QGtuk7gei7Y6v8s+9bV1qIHI+kFT4PhT1OMBjGMcoDT8Vr9823d0+nbfCgqjy6FzGoa0EVC2xi+c=
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WLDSEVj_1733803444 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 10 Dec 2024 12:04:09 +0800
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
Subject: [PATCH bpf-next v2 0/5] net/smc: Introduce smc_ops
Date: Tue, 10 Dec 2024 12:03:59 +0800
Message-ID: <20241210040404.10606-1-alibuda@linux.alibaba.com>
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

D. Wythe (5):
  bpf: export necessary sympols for modules with struct_ops
  net/smc: Introduce generic hook smc_ops
  net/smc: bpf: register smc_ops info struct_ops
  libbpf: fix error when st-prefix_ops and ops from differ btf
  bpf/selftests: add simple selftest for bpf_smc_ops

 include/net/netns/smc.h                       |   3 +
 include/net/smc.h                             |  51 ++++++
 kernel/bpf/bpf_struct_ops.c                   |   2 +
 kernel/bpf/syscall.c                          |   1 +
 net/ipv4/tcp_output.c                         |  15 +-
 net/smc/Kconfig                               |  12 ++
 net/smc/Makefile                              |   1 +
 net/smc/af_smc.c                              |  10 ++
 net/smc/smc_ops.c                             | 150 ++++++++++++++++++
 net/smc/smc_ops.h                             |  31 ++++
 net/smc/smc_sysctl.c                          |  95 +++++++++++
 tools/lib/bpf/libbpf.c                        |  34 +++-
 tools/testing/selftests/bpf/config            |   3 +
 .../selftests/bpf/prog_tests/test_bpf_smc.c   |  25 +++
 tools/testing/selftests/bpf/progs/bpf_smc.c   |  27 ++++
 15 files changed, 453 insertions(+), 7 deletions(-)
 create mode 100644 net/smc/smc_ops.c
 create mode 100644 net/smc/smc_ops.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_bpf_smc.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_smc.c

-- 
2.45.0


