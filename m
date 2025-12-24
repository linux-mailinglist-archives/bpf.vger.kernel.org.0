Return-Path: <bpf+bounces-77424-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1481CCDD09B
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 20:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 882913027A55
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 19:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1153433D6FC;
	Wed, 24 Dec 2025 19:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxzo1uxo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E840B33D4FF
	for <bpf@vger.kernel.org>; Wed, 24 Dec 2025 19:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766604314; cv=none; b=TSBc0eYJYtykvJq4swmGRjkdUXvTSS7jnGz4ma1pVLSGd+617yBynBOHs+RWQXyy5CS3Crph/LC2b8nvqWDyi1N8J2TyRlICGKD0qclbj/t4LwjPPvnHuLwBc18FYWoaNg0+LspIVWRxxP22qM87Q29oDXP3Hfm+b/q3oLZc/Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766604314; c=relaxed/simple;
	bh=m/wM7xjRsezXXJQl1C5Td8XANSeGemBz36Or5ZwwMlo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rvxBvXXCGbk0ZAtxBQpFgar5kxHYO4w1t2v6233KOXSYNfQ2xo/YfGWZLslUOrWXSc9RzF/QuWDRCyBZitJAe1h0G32v2It1JTVc8b2KvAf97CVMDRllY+YYSZtlWnlU71/bJSIBpmOi0OFIN34M2poqWJx+nUW+lvNF972ghPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rxzo1uxo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2751C116C6;
	Wed, 24 Dec 2025 19:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766604313;
	bh=m/wM7xjRsezXXJQl1C5Td8XANSeGemBz36Or5ZwwMlo=;
	h=From:To:Cc:Subject:Date:From;
	b=rxzo1uxo8aXUl1FYuy2E7myLrxUZtVBAms3qGj50Lz5k+CPirC4wKMJOq8Shq9eVm
	 abA1EsY2OtnfzRLDdGFowTHo7ghF/3rNgc5xZx83gk0NJVVpi8rQ1THvHfo5zjJdD0
	 JfgEOIqLYS/+T9VJSb95vquF4f1Qi+deJOJIPXkr7chNBQD/az0Wd/8XCqlYvDQ8jW
	 h5m7tsHCDjnTOfSuSNK4FyT7QvqftZt/KjhQya6jR/05OGlMJIRdT5vjSkHJn3vnEl
	 wMGpHJadNGzfzkXWXAZbPJxwbw0GYMyKYrs9/OLBvjjaGAAsRZXC409glvc6AS+wRb
	 DBHv9h4Ok6LZA==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH bpf-next 0/7] bpf: Make KF_TRUSTED_ARGS default
Date: Wed, 24 Dec 2025 11:24:29 -0800
Message-ID: <20251224192448.3176531-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This set makes the verifier assume KF_TRUSTED_ARGS by default for all
kfunc and gets rid of this flag.

This works because:
  1. Context pointers (xdp_md, __sk_buff, etc.) are handled through
  their own KF_ARG_PTR_TO_CTX case label and bypass the trusted check

  2. Struct_ops callback arguments are already marked as PTR_TRUSTED
  during initialization and pass is_trusted_reg()

  3. KF_RCU kfuncs are handled separately via is_kfunc_rcu() checks at
  call sites.

Puranjay Mohan (7):
  bpf: Make KF_TRUSTED_ARGS the default for all kfuncs
  bpf: net: netfilter: Mark kfuncs accurately
  bpf: Remove redundant KF_TRUSTED_ARGS flag from all kfuncs
  selftests: bpf: Update kfunc_param_nullable test for new error message
  selftests: bpf: Update failure message for rbtree_fail
  selftests: bpf: fix test_kfunc_dynptr_param
  selftests: bpf: fix cgroup_hierarchical_stats

 Documentation/bpf/kfuncs.rst                  | 35 +++++++++----------
 fs/bpf_fs_kfuncs.c                            | 13 ++++---
 fs/verity/measure.c                           |  2 +-
 include/linux/btf.h                           |  3 +-
 kernel/bpf/arena.c                            |  6 ++--
 kernel/bpf/cpumask.c                          |  2 +-
 kernel/bpf/helpers.c                          | 20 +++++------
 kernel/bpf/map_iter.c                         |  2 +-
 kernel/bpf/verifier.c                         | 14 ++------
 kernel/sched/ext.c                            |  8 ++---
 mm/bpf_memcontrol.c                           | 10 +++---
 net/core/filter.c                             | 10 +++---
 net/core/xdp.c                                |  2 +-
 net/netfilter/nf_conntrack_bpf.c              | 30 ++++++++--------
 net/netfilter/nf_flow_table_bpf.c             |  2 +-
 net/netfilter/nf_nat_bpf.c                    |  2 +-
 net/sched/bpf_qdisc.c                         | 12 +++----
 .../bpf/progs/cgroup_hierarchical_stats.c     |  6 ++--
 .../testing/selftests/bpf/progs/rbtree_fail.c |  2 +-
 .../bpf/progs/test_kfunc_dynptr_param.c       |  2 +-
 .../bpf/progs/test_kfunc_param_nullable.c     |  2 +-
 .../selftests/bpf/test_kmods/bpf_testmod.c    | 20 +++++------
 22 files changed, 98 insertions(+), 107 deletions(-)


base-commit: f14cdb1367b947d373215e36cfe9c69768dbafc9
-- 
2.47.3


