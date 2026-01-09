Return-Path: <bpf+bounces-78354-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A10D0BEEF
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 19:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 72DA6305CB15
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 18:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776AB2E0405;
	Fri,  9 Jan 2026 18:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AmbduUQt"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323FE2DEA70;
	Fri,  9 Jan 2026 18:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767984579; cv=none; b=SmXpUiaWIuti7Pz08ozqCBUp3avGVNsfUhEBDdk8zIxNL/5KF8WOizHyCWqxsyoCMMvm9+rY9rTg7fW4G/0ZoeAVHQXw8ijK6Q1semR3++TqQyRdVQ8FFqW1Xu3QFixLsVk9MKseE9FfFO8IXQuNqSBk9IqktgV+0xoFVCKAw2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767984579; c=relaxed/simple;
	bh=vK2UmMO8h7KVieYaIxTUrkuf30QyV/hQOQhzVsKcz6w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=daEb5DB9eWZptX9WHEc6z0WB/13B4MgG2C6i52//LNg7iFStfx8FawSNqQ+ysi5n3Of5p9P49OAjbRl9x4NAL3k9IEYTjDUh8H6aEo0A5gxx3lZbGr/Dx7Cm1Sbl3X2MXu4iDon9fPJt+1p6brTrA2+ixm9rL3xWjeBaV9e9lWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AmbduUQt; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767984565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ab5DkkNPh3SFtvknH3++tX6PIlvk40xERYOZ8UrmrN4=;
	b=AmbduUQtPh/D8uUnQGUzRe2hpBXk0v4iKYf/caeuSve+DZ2gBmiYjnC/c+bvNc5zn5YrVi
	yfnEnsT7c6s3xxvD1Us9PX5XvJywHqesFGwJzkj96enWanqZ6cxLnmOT2k/KaFK+rv/L2C
	6c1s2Mi2fxa8n/FLeROj8bf19IuIRYw=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Mykyta Yatsenko <yatsenko@meta.com>,
	Tejun Heo <tj@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: [PATCH bpf-next v1 00/10] bpf: Kernel functions with KF_IMPLICIT_ARGS
Date: Fri,  9 Jan 2026 10:48:42 -0800
Message-ID: <20260109184852.1089786-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This series implements a generic "implicit arguments" feature for BPF
kernel functions.

This is the next iteration of previous work [1][2], although it's not
really a v3, as parts of the implementation have changed
significantly.

A mechanism is created for kfuncs to have arguments that are not
visible to the BPF programs, and are provided to the kernel function
implementation by the verifier.

This mechanism is then used to define new APIs, that use
KF_IMPLICIT_ARGS flag, for the kfuncs that have a parameter with
__prog annotation [3], which is the current way of passing struct
bpf_prog_aux pointer to kfuncs.

The key difference in comparison to earlier work is that the necessary
BTF modifications are done by resolve_btfids (patch #4) instead of
pahole. The groundwork for this to be possible has been landed
recently [4].

This approach simplifies the implementation and future maintenance as
pahole is an out-of-tree tool, while resolve_btfids is not.

Another difference is in handling of the "legacy" case. This
implementation is more strict: the usage of <kfunc>_impl functions in
BPF is only allowed for kfuncs with an explicit kernel (or kmodule)
declaration (that is, existing _impl functions [5]). A <kfunc>_impl
function generated in BTF for a kfunc with implicit args does not have
a "bpf_kfunc" decl tag, and a kernel address. The verifier will reject
a program trying to call such an _impl kfunc.

The function with implicit arguments is defined by KF_IMPLICIT_ARGS
flag in BTF_IDS_FLAGS set. In this series, only a pointer to struct
bpf_prog_aux can be implicit, although it is simple to extend this to
more types.

The verifier handles a kfunc with KF_IMPLICIT_ARGS by resolving it to
a different (actual) BTF prototype early in verification (patch #3).

The series consists of the following patches:
  - patches #1 and #2 are non-functional refactoring in kernel/bpf
  - patch #3 defines KF_IMPLICIT_ARGS flag and teaches the verifier
    about it, enabling __prog args to also be implicit
  - patch #4 implements the necessary btf2btf transformation in
    resolve_btfids
  - patch #5 adds selftests specific to KF_IMPLICIT_ARGS feature
  - patches #6-#9 update the current users of __prog argument to use
    KF_IMPLICIT_ARGS
  - patch #10 updates relevant documentation

[1] https://lore.kernel.org/bpf/20251029190113.3323406-1-ihor.solodrai@linux.dev/
[2] https://lore.kernel.org/bpf/20250924211716.1287715-1-ihor.solodrai@linux.dev/
[3] https://docs.kernel.org/bpf/kfuncs.html#prog-annotation
[4] https://lore.kernel.org/bpf/20251219181321.1283664-1-ihor.solodrai@linux.dev/
[5] https://lore.kernel.org/bpf/20251104-implv2-v3-0-4772b9ae0e06@meta.com/

---

Ihor Solodrai (10):
  bpf: Refactor btf_kfunc_id_set_contains
  bpf: Introduce struct bpf_kfunc_meta
  bpf: Verifier support for KF_IMPLICIT_ARGS
  resolve_btfids: Support for KF_IMPLICIT_ARGS
  selftests/bpf: Add tests for KF_IMPLICIT_ARGS
  bpf: Add bpf_wq_set_callback kfunc with KF_IMPLICIT_ARGS
  HID: Use bpf_wq_set_callback kernel function
  bpf: Add bpf_task_work_schedule_* kfuncs with KF_IMPLICIT_ARGS
  bpf: Add bpf_stream_vprintk with KF_IMPLICIT_ARGS
  bpf,docs: Document KF_IMPLICIT_ARGS flag

 Documentation/bpf/kfuncs.rst                  |  44 ++-
 drivers/hid/bpf/progs/hid_bpf_helpers.h       |   8 +-
 include/linux/btf.h                           |   5 +-
 kernel/bpf/btf.c                              |  70 +++--
 kernel/bpf/helpers.c                          |  47 ++-
 kernel/bpf/stream.c                           |  11 +-
 kernel/bpf/verifier.c                         | 247 ++++++++++-----
 tools/bpf/resolve_btfids/main.c               | 282 ++++++++++++++++++
 tools/lib/bpf/bpf_helpers.h                   |   6 +-
 .../testing/selftests/bpf/bpf_experimental.h  |   5 -
 .../bpf/prog_tests/kfunc_implicit_args.c      |  10 +
 .../testing/selftests/bpf/progs/file_reader.c |   4 +-
 .../selftests/bpf/progs/kfunc_implicit_args.c |  41 +++
 .../testing/selftests/bpf/progs/stream_fail.c |   6 +-
 tools/testing/selftests/bpf/progs/task_work.c |  11 +-
 .../selftests/bpf/progs/task_work_fail.c      |  16 +-
 .../selftests/bpf/progs/task_work_stress.c    |   5 +-
 .../bpf/progs/verifier_async_cb_context.c     |   6 +-
 tools/testing/selftests/bpf/progs/wq.c        |   2 +-
 .../testing/selftests/bpf/progs/wq_failures.c |   4 +-
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  26 ++
 tools/testing/selftests/hid/Makefile          |   4 +-
 .../selftests/hid/progs/hid_bpf_helpers.h     |   8 +-
 23 files changed, 724 insertions(+), 144 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/kfunc_implicit_args.c
 create mode 100644 tools/testing/selftests/bpf/progs/kfunc_implicit_args.c

-- 
2.52.0


