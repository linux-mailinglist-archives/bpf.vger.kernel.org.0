Return-Path: <bpf+bounces-54246-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D44CBA6620E
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 23:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23D52179F13
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 22:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3229204F6A;
	Mon, 17 Mar 2025 22:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="dvQlupfH"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE39199252
	for <bpf@vger.kernel.org>; Mon, 17 Mar 2025 22:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742251857; cv=none; b=GVQY2Z3626fqgv0iTlEFeKnAcvl2jHS0d93KCTwzxpInbC9jVZ2hhzQSyBBjpfTakhNQQug0QVoPoQXonu08NdYZNP6K19NLJB+6ZVrRFJI5czGvMjFItgIYdtPbxfmMDzX+gBcLj6biITA6Broxaug/qDhP5SYks39ShaTSbKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742251857; c=relaxed/simple;
	bh=1/ECLoCoolYnXDbRiNCG2C+WSyEAGeWwbWo7Wc7a6No=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DljI9DipJzwv0hevJp9B3mtUn0micSNPHH1O6ijL4uBXmTdDIRdCx9OsIrPmn0zmTypI1b0BL3pBFaKS8Y6od0rGnRvpLqcoDUT0sy38je6JlMi7HgD4jYr/lPtaHd9LUR9p6fYep4YqkFXU5G3ine+Z0YPhQZKfQMmDSm/wZ4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=dvQlupfH; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 52HMl7f2005224;
	Mon, 17 Mar 2025 15:50:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=lJxUBpZ0K/rEWVLYED
	k+euYh01igjb2c5X6PSsQsdTk=; b=dvQlupfHAXx9zUsvPFRiV6/3X3gQIsZzEY
	uW4fNaQ5wF1WUqd6HSekpjJaCO597Dw4zPKqOCxgwOTKb/E9JxZJXhmrlLP/tSan
	iqYzcAOxdd4G5IWekqR2YX3TaGaSnYBou7+alwIRK3I3B6MM4boFbStwaOTzl9f4
	kfO8vjXdO8fF6++7DC94rKmyozvCJFs5V5gDNaWb9VCVWgQdwJ9h/5mE1jKHL9hJ
	Ifi7FO++BZHzRsvqEGQiUiL8dFzujPqCopBe3r/OQ6wKMDexX4LGUYfWPS+OV0f8
	LO6x8YE9TIvP8lozxP9zB0MDuug2PtHExakPybPMR5pQtbIHtRiQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 45evu280qv-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 17 Mar 2025 15:50:13 -0700 (PDT)
Received: from devvm4158.cln0.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server id
 15.2.1544.14; Mon, 17 Mar 2025 22:49:39 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Borislav Petkov <bp@alien8.de>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yonghong Song <yonghong.song@linux.dev>,
        Vadim Fedorenko
	<vadim.fedorenko@linux.dev>,
        Mykola Lysenko <mykolal@fb.com>
CC: <x86@kernel.org>, <bpf@vger.kernel.org>,
        Peter Zijlstra
	<peterz@infradead.org>,
        Vadim Fedorenko <vadfed@meta.com>,
        Martin KaFai Lau
	<martin.lau@linux.dev>
Subject: [PATCH bpf-next v11 0/4] bpf: add cpu time counter kfuncs
Date: Mon, 17 Mar 2025 15:49:28 -0700
Message-ID: <20250317224932.1894918-1-vadfed@meta.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 3hV7aOdN8cvnkDkixURFrz0rmgAp_QqH
X-Proofpoint-GUID: 3hV7aOdN8cvnkDkixURFrz0rmgAp_QqH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_09,2025-03-17_03,2024-11-22_01

This patchset adds 2 kfuncs to provide a way to precisely measure the
time spent running some code. The first patch provides a way to get cpu
cycles counter which is used to feed CLOCK_MONOTONIC_RAW. On x86
architecture it is effectively rdtsc_ordered() function. The second patch
adds a kfunc to convert cpu cycles to nanoseconds using shift/mult
constants discovered by kernel. The main use-case for this kfunc is to
convert deltas of timestamp counter values into nanoseconds. It is not
supposed to get CLOCK_MONOTONIC_RAW values as offset part is skipped.
JIT version is done for x86 for now, on other architectures it falls
back to get CLOCK_MONOTONIC_RAW values.

The reason to have these functions is to avoid overhead added by
a bpf_ktime_get_ns() call in case of benchmarking, when two timestamps
are taken to get delta value. With both functions being JITed, the
overhead is minimal and the result has better precision. New functions
can be used to benchmark BPF code directly in the program, or can be
used in kprobe/uprobe to store timestamp counter in the session coockie
and then in kretprobe/uretprobe the delta can be calculated and
converted into nanoseconds.

Selftests are also added to check whether the JIT implementation is
correct and to show the simplest usage example.

Change log:
v10 -> v11:
* add missing IS_ENABLED(CONFIG_BPF_SYSCALL)
* reword "cycles" -> "counter"
v9 -> v10:
* rework fallback implementation to avoid using vDSO data from
  kernel space.
* add comment about using "LFENCE; RDTSC" instead of "RDTSCP"
* guard x86 JIT implementation to be sure that TSC is enabled and
  stable
* v9 link:
  https://lore.kernel.org/bpf/20241123005833.810044-1-vadfed@meta.com/
v8 -> v9:
* rewording of commit messages, no code changes
* move change log from each patch into cover letter
v7 -> v8:
* rename kfuncs again to bpf_get_cpu_time_counter() and
  bpf_cpu_time_counter_to_ns()
* use cyc2ns_read_begin()/cyc2ns_read_end() to get mult and shift
  constants in bpf_cpu_time_counter_to_ns()
v6 -> v7:
* change boot_cpu_has() to cpu_feature_enabled() (Borislav)
* return constant clock_mode in __arch_get_hw_counter() call
v5 -> v6:
* added cover letter
* add comment about dropping S64_MAX manipulation in jitted
  implementation of rdtsc_oredered (Alexey)
* add comment about using 'lfence;rdtsc' variant (Alexey)
* change the check in fixup_kfunc_call() (Eduard)
* make __arch_get_hw_counter() call more aligned with vDSO
  implementation (Yonghong)
v4 -> v5:
* use #if instead of #ifdef with IS_ENABLED
v3 -> v4:
* change name of the helper to bpf_get_cpu_cycles (Andrii)
* Hide the helper behind CONFIG_GENERIC_GETTIMEOFDAY to avoid exposing
  it on architectures which do not have vDSO functions and data
* reduce the scope of check of inlined functions in verifier to only 2,
  which are actually inlined.
* change helper name to bpf_cpu_cycles_to_ns.
* hide it behind CONFIG_GENERIC_GETTIMEOFDAY to avoid exposing on
  unsupported architectures.
v2 -> v3:
* change name of the helper to bpf_get_cpu_cycles_counter to
  explicitly mention what counter it provides (Andrii)
* move kfunc definition to bpf.h to use it in JIT.
* introduce another kfunc to convert cycles into nanoseconds as
  more meaningful time units for generic tracing use case (Andrii)
v1 -> v2:
* Fix incorrect function return value type to u64
* Introduce bpf_jit_inlines_kfunc_call() and use it in
	mark_fastcall_pattern_for_call() to avoid clobbering in case
	of running programs with no JIT (Eduard)
* Avoid rewriting instruction and check function pointer directly
	in JIT (Alexei)
* Change includes to fix compile issues on non x86 architectures

Vadim Fedorenko (4):
  bpf: add bpf_get_cpu_time_counter kfunc
  bpf: add bpf_cpu_time_counter_to_ns helper
  selftests/bpf: add selftest to check bpf_get_cpu_time_counter jit
  selftests/bpf: add usage example for cpu time counter kfuncs

 arch/x86/net/bpf_jit_comp.c                   |  73 ++++++++++++
 arch/x86/net/bpf_jit_comp32.c                 |  58 ++++++++++
 include/linux/bpf.h                           |   4 +
 include/linux/filter.h                        |   1 +
 kernel/bpf/core.c                             |  11 ++
 kernel/bpf/helpers.c                          |  12 ++
 kernel/bpf/verifier.c                         |  41 ++++++-
 .../bpf/prog_tests/test_cpu_cycles.c          |  35 ++++++
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/test_cpu_cycles.c     |  25 +++++
 .../selftests/bpf/progs/verifier_cpu_cycles.c | 104 ++++++++++++++++++
 11 files changed, 360 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_cpu_cycles.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_cpu_cycles.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_cpu_cycles.c

-- 
2.47.1

