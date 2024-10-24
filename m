Return-Path: <bpf+bounces-42997-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 498FE9ADA07
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 04:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80791B2232D
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 02:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA1C153BF7;
	Thu, 24 Oct 2024 02:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="M7UC2xOv"
X-Original-To: bpf@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D59339A0;
	Thu, 24 Oct 2024 02:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729737786; cv=none; b=b5qhAMydjAVNDVFjjEIOvwNEJVr8g2pxVytfuvSOhTBcd/va8Oc73SnD2x6ziIQwc13Odes1D/Qx/gLpmKanhB4am5Bf1mYyJ9VLly6H+cS56+CLv4ogOgXMXFORyBoSXAPbmaB1FQyvsXFlXPgEvnifjZSUd/rfUd5uPQW/uyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729737786; c=relaxed/simple;
	bh=OFaifoyoM6J8Ghm/SXcou8L3XcLpZT6uGQMnJkP2Wvo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=kcZU0qIiCpY2GDdhEnysJ1WpN6NZ6R4inKcmeIDq+Eunikg+My/eP9mfwfMXaP0viGveasrNNvy1E7kBBSOPaxePJmYm4GjDmte2vRfVYbQ6GIfeAUb3juan6Q0UX0MDCmImzP5qyJAVQoJNIv25trsasHyJhErKJD3jiykRPag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=M7UC2xOv; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729737775; h=From:To:Subject:Date:Message-Id;
	bh=sDytZK0efgZmAticAYihnFM+kLylDMMKsvzdyem9PIM=;
	b=M7UC2xOv4J/fAxI0Fsdv2ajLE+pBAjhU7eNuREs4QDQ2PUF/tXi9Ai3qCM7e7eO0EBULQarkfGM0MxZjRuAd1fovhT2lL/cQ4Icx0ku6aiQQA81ay5FBbUF0e9W2+sh7r1ILYxe+OWKbKq/V5kvdPZTsySCi/9D2o3/yEV89sDU=
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WHnU0ED_1729737768 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 24 Oct 2024 10:42:53 +0800
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
	bpf@vger.kernel.org,
	dtcccc@linux.alibaba.com
Subject: [PATCH bpf-next 0/4] net/smc: Introduce smc_bpf_ops
Date: Thu, 24 Oct 2024 10:42:44 +0800
Message-Id: <1729737768-124596-1-git-send-email-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

From: "D. Wythe" <alibuda@linux.alibaba.com>

This patches attempt to introduce BPF injection capability for SMC,
and add selftest to ensure code stability.

As we all know that the SMC protocol is not suitable for all scenarios,
especially for short-lived. However, for most applications, they cannot
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

This patches implement injection capability for SMC via struct_ops.
In that way, we can add new injection scenarios in the future.

D. Wythe (4):
  bpf: export necessary sympols for modules
  bpf: allow to access bpf_prog during bpf_struct_access
  net/smc: Introduce smc_bpf_ops
  bpf/selftests: add simple selftest for bpf_smc_ops

 include/linux/bpf.h                                |   1 +
 include/linux/filter.h                             |   1 +
 include/linux/tcp.h                                |   2 +-
 include/net/smc.h                                  |  47 +++++
 include/net/tcp.h                                  |   6 +
 kernel/bpf/btf.c                                   |   2 +
 kernel/bpf/verifier.c                              |   2 +-
 kernel/sched/ext.c                                 |   5 +-
 net/bpf/bpf_dummy_struct_ops.c                     |   1 +
 net/core/filter.c                                  |   7 +-
 net/ipv4/bpf_tcp_ca.c                              |   1 +
 net/ipv4/tcp_input.c                               |   3 +-
 net/ipv4/tcp_output.c                              |  14 +-
 net/netfilter/nf_conntrack_bpf.c                   |   1 +
 net/smc/Kconfig                                    |  12 ++
 net/smc/Makefile                                   |   1 +
 net/smc/af_smc.c                                   |  38 +++-
 net/smc/smc.h                                      |   4 +
 net/smc/smc_bpf.c                                  | 212 +++++++++++++++++++++
 net/smc/smc_bpf.h                                  |  34 ++++
 .../selftests/bpf/bpf_testmod/bpf_testmod.c        |   1 +
 .../selftests/bpf/prog_tests/test_bpf_smc.c        |  21 ++
 tools/testing/selftests/bpf/progs/bpf_smc.c        |  44 +++++
 23 files changed, 439 insertions(+), 21 deletions(-)
 create mode 100644 net/smc/smc_bpf.c
 create mode 100644 net/smc/smc_bpf.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_bpf_smc.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_smc.c

-- 
1.8.3.1


