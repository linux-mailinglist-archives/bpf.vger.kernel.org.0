Return-Path: <bpf+bounces-79327-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E4DD38732
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 21:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6492B303980D
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 20:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEBC3A4F3C;
	Fri, 16 Jan 2026 20:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aPYk3HE/"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958FA3A4AAD;
	Fri, 16 Jan 2026 20:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768594653; cv=none; b=CSGJoQ3Njji05S/piZgXmgx+LRZSgb3zse3yyw8OcmQplfru9GnsflPnqH4dsv4l6IupiYvar3U24rVuPCSAIWgs+avVR82ooCyEp2pZehWMVLEOUhtEn3eSNy0peqrb+rmqPrwzjO2may9LCn8BRwyufpqtThINdKk9gAFwQhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768594653; c=relaxed/simple;
	bh=7Zb0ywyqdkGqJlCEzwwZJipVLnwF8Nf0+xdJC05Cwlg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TM6kOjlmxI7U4Y+Zamph/MlvUh6fATxdbkPD4uwubjhtxuMNf2bDsntggykNJ91Vm74mrEpUdEZgB112EKE7Lp8DvVCYy8y9jtSFvu6qrskDlLztYk8zrbXUvpWTwIoPDaZxTnedVoeGaF2DApuZbxqy/gUVJtU8jZxKFIq+wd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aPYk3HE/; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768594638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qh3soA85ykLGQnjp7pmcKzzjNJku8ckJD/dsruePygY=;
	b=aPYk3HE/PeR3v1SedZSNbv9CGYR06w1kV0qD4BJAC8SIjYdaHnBbC71EAlq7MlR+7QcIsD
	nPgL03M4QhYpU6IUJTdRVup/7uQSc6sQIBnWzvJtlB12kzUd3sGh+GEMCyxcioXq7wcobw
	0+aFptkbHvM+L9FT0pzaLeXaudoIvHs=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Mykyta Yatsenko <yatsenko@meta.com>,
	Tejun Heo <tj@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Amery Hung <ameryhung@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: [PATCH bpf-next v2 00/13] bpf: Kernel functions with KF_IMPLICIT_ARGS
Date: Fri, 16 Jan 2026 12:16:47 -0800
Message-ID: <20260116201700.864797-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This series implements a generic "implicit arguments" feature for BPF
kernel functions. For context see prior work [1][2].

A mechanism is created for kfuncs to have arguments that are not
visible to the BPF programs, and are provided to the kernel function
implementation by the verifier.

This mechanism is then used in the kfuncs that have a parameter with
__prog annotation [3], which is the current way of passing struct
bpf_prog_aux pointer to kfuncs.

The function with implicit arguments is defined by KF_IMPLICIT_ARGS
flag in BTF_IDS_FLAGS set. In this series, only a pointer to struct
bpf_prog_aux can be implicit, although it is simple to extend this to
more types.

The verifier handles a kfunc with KF_IMPLICIT_ARGS by resolving it to
a different (actual) BTF prototype early in verification (patch #3).

A <kfunc>_impl function generated in BTF for a kfunc with implicit
args does not have a "bpf_kfunc" decl tag, and a kernel address. The
verifier will reject a program trying to call such an _impl kfunc.

The usage of <kfunc>_impl functions in BPF is only allowed for kfuncs
with an explicit kernel (or kmodule) declaration, that is in "legacy"
cases. As of this series, there are no legacy kernel functions, as all
__prog users are migrated to KF_IMPLICIT_ARGS. However the
implementation allows for legacy cases support in principle.

The series consists of the following patches:
  - patches #1 and #2 are non-functional refactoring in kernel/bpf
  - patch #3 defines KF_IMPLICIT_ARGS flag and teaches the verifier
    about it
  - patches #4-#5 implement btf2btf transformation in resolve_btfids
  - patch #6 adds selftests specific to KF_IMPLICIT_ARGS feature
  - patches #7-#11 migrate the current users of __prog argument to
    KF_IMPLICIT_ARGS
  - patch #12 removes __prog arg suffix support from the kernel
  - patch #13 updates the docs

[1] https://lore.kernel.org/bpf/20251029190113.3323406-1-ihor.solodrai@linux.dev/
[2] https://lore.kernel.org/bpf/20250924211716.1287715-1-ihor.solodrai@linux.dev/
[3] https://docs.kernel.org/bpf/kfuncs.html#prog-annotation

---

v1->v2:
  - Replace the following kernel functions with KF_IMPLICIT_ARGS version:
    - bpf_stream_vprintk_impl -> bpf_stream_vprintk
    - bpf_task_work_schedule_resume_impl -> bpf_task_work_schedule_resume
    - bpf_task_work_schedule_signal_impl -> bpf_task_work_schedule_signal
    - bpf_wq_set_callback_impl -> bpf_wq_set_callback_impl
  - Remove __prog arg suffix support from the verifier
  - Rework btf2btf implementation in resolve_btfids
    - Do distill base and sort before BTF_ids patching
    - Collect kfuncs based on BTF decl tags, before BTF_ids are patched
  - resolve_btfids: use dynamic memory for intermediate data (Andrii)
  - verifier: reset .subreg_def for caller saved registers on kfunc
    call (Eduard)
  - selftests/hid: remove Makefile changes (Benjamin)
  - selftests/bpf: Add a patch (#11) migrating struct_ops_assoc test
    to KF_IMPLICIT_ARGS
  - Various nits across the series (Alexei, Andrii, Eduard)

v1: https://lore.kernel.org/bpf/20260109184852.1089786-1-ihor.solodrai@linux.dev/

---

Ihor Solodrai (13):
  bpf: Refactor btf_kfunc_id_set_contains
  bpf: Introduce struct bpf_kfunc_meta
  bpf: Verifier support for KF_IMPLICIT_ARGS
  resolve_btfids: Introduce finalize_btf() step
  resolve_btfids: Support for KF_IMPLICIT_ARGS
  selftests/bpf: Add tests for KF_IMPLICIT_ARGS
  bpf: Migrate bpf_wq_set_callback_impl() to KF_IMPLICIT_ARGS
  HID: Use bpf_wq_set_callback kernel function
  bpf: Migrate bpf_task_work_schedule_* kfuncs to KF_IMPLICIT_ARGS
  bpf: Migrate bpf_stream_vprintk() to KF_IMPLICIT_ARGS
  selftests/bpf: Migrate struct_ops_assoc test to KF_IMPLICIT_ARGS
  bpf: Remove __prog kfunc arg annotation
  bpf,docs: Document KF_IMPLICIT_ARGS flag

 Documentation/bpf/kfuncs.rst                  |  49 +-
 drivers/hid/bpf/progs/hid_bpf_helpers.h       |   8 +-
 include/linux/btf.h                           |   5 +-
 kernel/bpf/btf.c                              |  70 ++-
 kernel/bpf/helpers.c                          |  43 +-
 kernel/bpf/stream.c                           |   5 +-
 kernel/bpf/verifier.c                         | 245 ++++++----
 tools/bpf/resolve_btfids/main.c               | 452 +++++++++++++++++-
 tools/lib/bpf/bpf_helpers.h                   |   6 +-
 .../testing/selftests/bpf/bpf_experimental.h  |   5 -
 .../bpf/prog_tests/kfunc_implicit_args.c      |  10 +
 .../testing/selftests/bpf/progs/file_reader.c |   4 +-
 .../selftests/bpf/progs/kfunc_implicit_args.c |  41 ++
 .../testing/selftests/bpf/progs/stream_fail.c |   6 +-
 .../selftests/bpf/progs/struct_ops_assoc.c    |   8 +-
 .../bpf/progs/struct_ops_assoc_in_timer.c     |   4 +-
 .../bpf/progs/struct_ops_assoc_reuse.c        |   6 +-
 tools/testing/selftests/bpf/progs/task_work.c |  11 +-
 .../selftests/bpf/progs/task_work_fail.c      |  16 +-
 .../selftests/bpf/progs/task_work_stress.c    |   5 +-
 .../bpf/progs/verifier_async_cb_context.c     |  10 +-
 .../testing/selftests/bpf/progs/wq_failures.c |   4 +-
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  35 +-
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |   6 +-
 .../selftests/hid/progs/hid_bpf_helpers.h     |   8 +-
 25 files changed, 838 insertions(+), 224 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/kfunc_implicit_args.c
 create mode 100644 tools/testing/selftests/bpf/progs/kfunc_implicit_args.c

-- 
2.52.0


