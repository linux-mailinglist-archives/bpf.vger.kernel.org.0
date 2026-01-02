Return-Path: <bpf+bounces-77693-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFA9CEF1F6
	for <lists+bpf@lfdr.de>; Fri, 02 Jan 2026 19:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6F6E303A0B4
	for <lists+bpf@lfdr.de>; Fri,  2 Jan 2026 18:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3862FD660;
	Fri,  2 Jan 2026 18:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jM2dtjy4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F912FD1B5
	for <bpf@vger.kernel.org>; Fri,  2 Jan 2026 18:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767376848; cv=none; b=KixKL8jsIcMkdccolNWeAptZjzyN7OJP8T6fsQizEP0bJUw05KXV04dxwZYB6b7f7DCi/QuGToJ/P+g15Eg1L7L61ZqS2KzNrZsqBZsNNeiPU+K+RbIDVG7q568DTWU8PtxrEYExltQLENY9+umjSZTrTKZmG5RQBbEnV+O46Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767376848; c=relaxed/simple;
	bh=qAZcr+m9HfIU6QEoQ4y9EsXP9rKuq9XK669c7BrDUGk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ujR/Dy6emUC/jeo3vnic8bEkSXpiggqHr3074VDra/eDvASwOo4hljYFjwHhDu5MAZ5ZRMMZVm2m8+q/cg2I4gZPqG+x3ZmVFBL60dhGbU2G5JV7NTiX+uLranLRca+s0oTrGNE5QjnHcUkAQOfoZQSb1D/zuk9ax210XMUXi4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jM2dtjy4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 296EFC116B1;
	Fri,  2 Jan 2026 18:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767376848;
	bh=qAZcr+m9HfIU6QEoQ4y9EsXP9rKuq9XK669c7BrDUGk=;
	h=From:To:Cc:Subject:Date:From;
	b=jM2dtjy43RWqtJyui7I8WWa0LStbLOjx8FcB9On2dyu/tg6sYJMpXh7NsVdRj/VGm
	 qhCZ3p9ZO/P8bsmOcywsA6vS1VakhItQWiyqcgIXYjeDXA6KgBYQZjswz3hLJq9s8s
	 699swuK5WMWwCroE5S7Dr1ZH80M+gHWZf/SZWuuL29w92dgOSKpsPKE2A4uV4vTtOn
	 JxtYqTl4Uua1bsxf98GQ3i+4QBra8cpO7YMEUtEXGGhHm/JZzstGcbxDLaQ3mGC8J9
	 0FVRbuUonMCChtMwmNYD6rYb+1gN9QDWXlWqd4L1/YfmlkCCFRhmvU+9WMh2DYWEW9
	 UHCgbQtDXZ6RA==
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
	"Emil Tsalapatis" <emil@etsalapatis.com>,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 00/10] bpf: Make KF_TRUSTED_ARGS default
Date: Fri,  2 Jan 2026 10:00:26 -0800
Message-ID: <20260102180038.2708325-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2: https://lore.kernel.org/all/20251231171118.1174007-1-puranjay@kernel.org/
Changes in v2->v3:
- Fix documentation: add a new section for kfunc parameters (Eduard)
- Remove all occurances of KF_TRUSTED from comments, etc. (Eduard)
- Fix the netfilter kfuncs to drop dead NULL checks.
- Fix selftest for netfilter kfuncs to check for verification failures
  and remove the runtime failure that are not possible after this
  changes

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

All bpf selftests are passing. The hid_bpf tests are also passing:
# PASSED: 20 / 20 tests passed.
# Totals: pass:20 fail:0 xfail:0 xpass:0 skip:0 error:0

bpf programs in drivers/hid/bpf/progs/ show no regression as shown by
veristat:

Done. Processed 24 files, 62 programs. Skipped 0 files, 0 programs.

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

This series introduces two intentional breaking changes to the BPF
verifier's kfunc handling:

1. NULL pointer rejection timing: Kfuncs that previously accepted NULL
pointers without KF_TRUSTED_ARGS will now reject NULL at verification
time instead of returning runtime errors. This affects netfilter
connection tracking functions (bpf_xdp_ct_lookup, bpf_skb_ct_lookup,
bpf_xdp_ct_alloc, bpf_skb_ct_alloc), which now enforce their documented
"Cannot be NULL" requirements at load time rather than returning -EINVAL
at runtime.

2. Fentry/fexit program restrictions: BPF programs using fentry/fexit
attachment points can no longer pass their callback arguments directly
to kfuncs, as these arguments are not marked as trusted by default.
Programs requiring trusted argument semantics should migrate to tp_btf
(tracepoint with BTF) attachment points where arguments are guaranteed
trusted by the verifier.

Both changes strengthen the verifier's safety guarantees by catching
errors earlier in the development cycle and are accompanied by
comprehensive test updates demonstrating the new expected behaviors.

Puranjay Mohan (10):
  bpf: Make KF_TRUSTED_ARGS the default for all kfuncs
  bpf: Remove redundant KF_TRUSTED_ARGS flag from all kfuncs
  bpf: net: netfilter: drop dead NULL checks
  bpf: xfrm: drop dead NULL check in bpf_xdp_get_xfrm_state()
  HID: bpf: drop dead NULL checks in kfuncs
  selftests: bpf: Update kfunc_param_nullable test for new error message
  selftests: bpf: Update failure message for rbtree_fail
  selftests: bpf: fix test_kfunc_dynptr_param
  selftests: bpf: fix cgroup_hierarchical_stats
  selftests: bpf: Fix test_bpf_nf for trusted args becoming default

 Documentation/bpf/kfuncs.rst                  | 184 +++++++++---------
 drivers/hid/bpf/hid_bpf_dispatch.c            |   5 +-
 fs/bpf_fs_kfuncs.c                            |  23 +--
 fs/verity/measure.c                           |   2 +-
 include/linux/bpf.h                           |   2 +-
 include/linux/btf.h                           |   3 +-
 kernel/bpf/arena.c                            |   6 +-
 kernel/bpf/cpumask.c                          |   2 +-
 kernel/bpf/helpers.c                          |  20 +-
 kernel/bpf/map_iter.c                         |   2 +-
 kernel/bpf/verifier.c                         |  16 +-
 kernel/sched/ext.c                            |   8 +-
 mm/bpf_memcontrol.c                           |  10 +-
 net/core/filter.c                             |  10 +-
 net/core/xdp.c                                |   2 +-
 net/netfilter/nf_conntrack_bpf.c              |  22 +--
 net/netfilter/nf_flow_table_bpf.c             |   2 +-
 net/netfilter/nf_nat_bpf.c                    |   2 +-
 net/sched/bpf_qdisc.c                         |  12 +-
 net/xfrm/xfrm_state_bpf.c                     |   2 +-
 .../testing/selftests/bpf/prog_tests/bpf_nf.c |   5 +-
 .../bpf/progs/cgroup_hierarchical_stats.c     |   6 +-
 .../selftests/bpf/progs/cpumask_failure.c     |   2 +-
 .../testing/selftests/bpf/progs/rbtree_fail.c |   2 +-
 .../testing/selftests/bpf/progs/test_bpf_nf.c |   7 -
 .../selftests/bpf/progs/test_bpf_nf_fail.c    |  57 ++++++
 .../bpf/progs/test_kfunc_dynptr_param.c       |   5 +-
 .../bpf/progs/test_kfunc_param_nullable.c     |   2 +-
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  20 +-
 29 files changed, 234 insertions(+), 207 deletions(-)


base-commit: c286e7e9d1f1f3d90ad11c37e896f582b02d19c4
-- 
2.47.3


