Return-Path: <bpf+bounces-45488-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A449D66E8
	for <lists+bpf@lfdr.de>; Sat, 23 Nov 2024 02:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4272B282EE3
	for <lists+bpf@lfdr.de>; Sat, 23 Nov 2024 01:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99F1D530;
	Sat, 23 Nov 2024 01:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Qpgc3IsZ"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9516229A1
	for <bpf@vger.kernel.org>; Sat, 23 Nov 2024 01:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732323602; cv=none; b=uGrjTc2+nqX8aKIOQAR+DVu4dhdnTRSRQPL0R0Yh2Xp2UuUQ68V3ca08lbiBn6wyGo1+fG5GqntU9wTtnqbcfLS3Iz9kDQ2uHEus4ECGpQ9570/Q7H25LOnAw0vD83e9CvrLT+J2is07S6Q1wHKzf5v8AsV6FYlp19MmGR3aPUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732323602; c=relaxed/simple;
	bh=5UhhS9hNdpNz4WSJU/4ZNIUvbgGZYx17poFMVZWbaQ0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XkEX7tXuBip0nezF3klezDwY3LpADaoMZN05ZxuoD41LYL0FvtEMqxiR3X8OEOG8ulDbTKA9coghOzB8KLARhMBXgRjlzMN3ibCao+EAdv+vRVvhLA4FpHypH7c87CNSjMOBHv7I7yKNfnUcdVJfY46h3WiWSZQrT+ImzxOg5Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Qpgc3IsZ; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 4AMH4Dbl027218;
	Fri, 22 Nov 2024 16:58:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=NHc/xNlAc/XFJn20N3
	1APz7SKuT5afkl9kNA2Tz1TZs=; b=Qpgc3IsZq4Qsgk5z+DNqe9eMckNg1gvXf5
	kWXjz2EYTgt3f0pcAsRUuwTJfrQU5hBUtdP6qC/txowmU6tb4fDBLCPlu2/a9LNi
	ZLTuXvwsyOMM16zyi6q1bE+zJwf/Tf/wZcdwEiPGRe42hxESU34WqxCwCTrtm0Qi
	rUP7JEE0OQFUu0MYYDa625u0PciS97NlJpR1qkMfzjxHEV3sCHlTbRNchFRUqXYL
	MjaLQPvYUCAdXKwx3/L2KldQEBuX/d1y/BWHYjdSWCPBJUQ0iLhmT4v5O14DtVV7
	fiuzyZklsOpAUNFVrp9yb7Wzr/oWf03jg8/voM3x+axomAa72O0A==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 432s19w917-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 22 Nov 2024 16:58:58 -0800 (PST)
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server id
 15.2.1544.11; Sat, 23 Nov 2024 00:58:56 +0000
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
Subject: [PATCH bpf-next v9 0/4] bpf: add cpu time counter kfuncs
Date: Fri, 22 Nov 2024 16:58:29 -0800
Message-ID: <20241123005833.810044-1-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 9wrLSDyTENuMxg6IoOAML7twahHV30U_
X-Proofpoint-ORIG-GUID: 9wrLSDyTENuMxg6IoOAML7twahHV30U_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

This patchset adds 2 kfuncs to provide a way to precisely measure the
time spent running some code. The first patch provides a way to get cpu
cycles counter which is used to feed CLOCK_MONOTONIC_RAW. On x86
architecture it is effectively rdtsc_ordered() function while on other
architectures it falls back to __arch_get_hw_counter(). The second patch
adds a kfunc to convert cpu cycles to nanoseconds using shift/mult
constants discovered by kernel. The main use-case for this kfunc is to
convert deltas of timestamp counter values into nanoseconds. It is not
supposed to get CLOCK_MONOTONIC_RAW values as offset part is skipped.
JIT version is done for x86 for now, on other architectures it falls
back to slightly simplified version of vdso_calc_ns.

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

 arch/x86/net/bpf_jit_comp.c                   |  66 +++++++++++
 arch/x86/net/bpf_jit_comp32.c                 |  41 +++++++
 include/linux/bpf.h                           |   6 +
 include/linux/filter.h                        |   1 +
 kernel/bpf/core.c                             |  11 ++
 kernel/bpf/helpers.c                          |  39 +++++++
 kernel/bpf/verifier.c                         |  41 ++++++-
 .../bpf/prog_tests/test_cpu_cycles.c          |  35 ++++++
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/test_cpu_cycles.c     |  25 +++++
 .../selftests/bpf/progs/verifier_cpu_cycles.c | 104 ++++++++++++++++++
 11 files changed, 365 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_cpu_cycles.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_cpu_cycles.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_cpu_cycles.c

-- 
2.43.5

