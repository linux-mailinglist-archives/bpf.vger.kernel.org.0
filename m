Return-Path: <bpf+bounces-77600-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F5FCEC54B
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 18:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 38F0430019EC
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 17:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0260A29D26E;
	Wed, 31 Dec 2025 17:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FIlTGmMX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EBA2877D6
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 17:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767201090; cv=none; b=P58Vr+WsbL50spz6OpONEBfYKbZdWAWAOKmLvbrszWl9fmR8SuBjsKE/J3E+yMIToCg0HynC7HoLqJCNpm+WfWuyOpPWbGVR8mR/chv+g1HFe4sdYjkVw6ULa8vCrjopXP7WMqcrrj8cOUvEyRUexw/ytVvNJQzvgRZkfa1GLws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767201090; c=relaxed/simple;
	bh=Ry///CZ0UmuFzVTygGJpRN/+kWGv/LiS2V5y3UZ8i9U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=exhxrrZKjiSvkBPAKuCgeL+ASAowQLuiFWkbOGv9HW/KEwL+RNHatYO5OBiXbGpmvU/1y7NHxUMBzILAGrNGRGk0oaFcd/Ha2tm/C+BePHkN30a2SmwTiUYEa+3JLlffDnTN0RIGz/WfmaD4Ej7cgteTV+OE/mOOekHYpRYH1Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FIlTGmMX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83280C113D0;
	Wed, 31 Dec 2025 17:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767201089;
	bh=Ry///CZ0UmuFzVTygGJpRN/+kWGv/LiS2V5y3UZ8i9U=;
	h=From:To:Cc:Subject:Date:From;
	b=FIlTGmMXayF+UoIS4UscnpA7k6sav5ldYnMlQZbGZa5n8Gzu2cjdG4AvyjWb4gL82
	 wQjKoqM/5/B+5h+xN63w6nw70N+PeKOgNlV6WVpAgLGoLsC6EvhLdPOmVwtwAkw7AQ
	 RByKOwZvHwrgzi5wyM/jduX26noTOOSGYmRE5KgMf2KV2AcD1vD+49jmmOQovUqZsN
	 e+2xt8dKujk1n72ZeAxtjl5ytcM89HBCu+Y+ESw5l3+pHV/W1NsBtl2kBole92TRuQ
	 NdDZby+pNGMnHhHvB5bpD+8XEeuPeGCNf2L6jSbNxNtOQk21imbi26l2rcvA6iZ6H7
	 UpYAtE4tFK3Ig==
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
Subject: [PATCH bpf-next v2 0/9] bpf: Make KF_TRUSTED_ARGS default
Date: Wed, 31 Dec 2025 09:08:46 -0800
Message-ID: <20251231171118.1174007-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1: https://lore.kernel.org/all/20251224192448.3176531-1-puranjay@kernel.org/
Changes in v1->v2:
- Update kfunc_dynptr_param selftest to use a real pointer that is not
  ptr_to_stack and not CONST_PTR_TO_DYNPTR rather than casting 1
  (Alexei)
- Thoroughly review all kfuncs in the to find regressions or missing
  annotations. (Eduard)
- Fix kfuncs found from the above step.

This series makes trusted arguments the default requirement for all BPF
kfuncs, inverting the current opt-in model. Instead of requiring
explicit KF_TRUSTED_ARGS flags, kfuncs now require trusted arguments by
default and must explicitly opt-out using __nullable/__opt annotations
or the KF_RCU flag.

This improves security and type safety by preventing BPF programs from
passing untrusted or NULL pointers to kernel functions at verification
time, while maintaining flexibility for the small number of kfuncs that
legitimately need to accept NULL or RCU pointers.

MOTIVATION

The current opt-in model is error-prone and inconsistent. Most kfuncs already
require trusted pointers from sources like KF_ACQUIRE, struct_ops callbacks, or
tracepoints. Making trusted arguments the default:

- Prevents NULL pointer dereferences at verification time
- Reduces defensive NULL checks in kernel code
- Provides better error messages for invalid BPF programs
- Aligns with existing patterns (context pointers, struct_ops already trusted)

IMPACT ANALYSIS

Comprehensive analysis of all 304+ kfuncs across 37 kernel files found:
- Most kfuncs (299/304) are already safe and require no changes
- Only 4 kfuncs required fixes (all included in this series)
- 0 regressions found in independent verification

TECHNICAL DETAILS

The verifier now validates kfunc arguments in this order:
1. NULL check (runs first): Rejects NULL unless parameter has __nullable/__opt
2. Trusted check: Rejects untrusted pointers unless kfunc has KF_RCU

Special cases that bypass trusted checking:
- Context pointers (xdp_md, __sk_buff): Handled via KF_ARG_PTR_TO_CTX
- Struct_ops callbacks: Pre-marked as PTR_TRUSTED during initialization
- KF_RCU kfuncs: Have separate validation path for RCU pointers

BACKWARD COMPATIBILITY

This affects BPF program verification, not runtime:
- Valid programs passing trusted pointers: Continue to work
- Programs with bugs: May now fail verification (preventing runtime crashes)

Puranjay Mohan (9):
  bpf: Make KF_TRUSTED_ARGS the default for all kfuncs
  bpf: net: netfilter: Mark kfuncs accurately
  bpf: Remove redundant KF_TRUSTED_ARGS flag from all kfuncs
  selftests: bpf: Update kfunc_param_nullable test for new error message
  selftests: bpf: Update failure message for rbtree_fail
  selftests: bpf: fix test_kfunc_dynptr_param
  selftests: bpf: fix cgroup_hierarchical_stats
  bpf: xfrm: drop dead NULL check in bpf_xdp_get_xfrm_state()
  HID: bpf: drop dead NULL checks in kfuncs

 Documentation/bpf/kfuncs.rst                  | 35 +++++++-------
 drivers/hid/bpf/hid_bpf_dispatch.c            |  5 +-
 fs/bpf_fs_kfuncs.c                            | 13 +++---
 fs/verity/measure.c                           |  2 +-
 include/linux/btf.h                           |  3 +-
 kernel/bpf/arena.c                            |  6 +--
 kernel/bpf/cpumask.c                          |  2 +-
 kernel/bpf/helpers.c                          | 20 ++++----
 kernel/bpf/map_iter.c                         |  2 +-
 kernel/bpf/verifier.c                         | 14 ++----
 kernel/sched/ext.c                            |  8 ++--
 mm/bpf_memcontrol.c                           | 10 ++--
 net/core/filter.c                             | 10 ++--
 net/core/xdp.c                                |  2 +-
 net/netfilter/nf_conntrack_bpf.c              | 46 ++++++++++---------
 net/netfilter/nf_flow_table_bpf.c             |  2 +-
 net/netfilter/nf_nat_bpf.c                    |  2 +-
 net/sched/bpf_qdisc.c                         | 12 ++---
 net/xfrm/xfrm_state_bpf.c                     |  2 +-
 .../bpf/progs/cgroup_hierarchical_stats.c     |  6 +--
 .../testing/selftests/bpf/progs/rbtree_fail.c |  2 +-
 .../bpf/progs/test_kfunc_dynptr_param.c       |  5 +-
 .../bpf/progs/test_kfunc_param_nullable.c     |  2 +-
 .../selftests/bpf/test_kmods/bpf_testmod.c    | 20 ++++----
 24 files changed, 109 insertions(+), 122 deletions(-)


base-commit: ccaa6d2c9635a8db06a494d67ef123b56b967a78
-- 
2.47.3


