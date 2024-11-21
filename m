Return-Path: <bpf+bounces-45306-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E03059D44CF
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 01:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A143C283AA1
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 00:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52ED1230989;
	Thu, 21 Nov 2024 00:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="i2Jd+lOz"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4B9230980
	for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 00:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732147762; cv=none; b=CYbLJr+5+RpiCQNUBN6K6W2hSCeKaeaY83nk8sNNxktEzTczRxO+8P1xfd38weyYBP7uhu9vtkZucqXw3t1Sii9A/YwQ/4iCwCViNK3Vd4CWwrN9Nb21rmPeep5pgLIRR2GhWHGbACI9t05aeguccRQxJzb0kjr5E9WZCPKaYaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732147762; c=relaxed/simple;
	bh=rN1f5fMEUwCD5UzE6AJf+HpQw8qWkyJL0xqJZAuu09A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cPA7SMn7fRBeRoGkVbMfqPXYhaNyoZMs2znn7+gHYKYCLw528NrfthCsdFIMxCOtpwRhdXR/syI6GM48vdp8lOSQJ+KnvFm9u9NJFtfEbmgxcs08iAB5VzXWuW9sod+D5RnDse9/z2ervwjJUD0cLaTwH9dAjpec5jMovHQnFnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=i2Jd+lOz; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AKKZ2mU001523;
	Wed, 20 Nov 2024 16:08:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=5ptKhG3369ZgFWxKvn
	65B4kBV2Mj0gLcRZxwmnoKIl4=; b=i2Jd+lOz182Hzojte3uZU/YbGvt7NAvLQK
	e49w/z/aUMJ47ago7sR0OLoxbY5ptF0nnbcttejDbwW0mfXwNwdyIP5kChlUkdXN
	Q/QX3VrFq3DyWzXO1Vf6p1e8uIDsXH7qv1cewCeBy00PtOzFflrIQJQ8YavpYrRK
	7n4Uds53tDtwKbc9guU6zyo5HSc2C1ZPvoyfuBGTfgimBTUtLufNAJvltetlQCrx
	UFWm6L1+/uPrzfq8ZP3kvBZ/kYWdPMLht1YIk5lAnwFhxf2DjfB/Jx3JDKQ/QNyj
	wiD76pQm4MwvlNHbXbe/1KpuXpuEhXA4cPEQehw1b+XxeK2H0S1w==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 431pxah760-13
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 20 Nov 2024 16:08:30 -0800 (PST)
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server id
 15.2.1544.11; Thu, 21 Nov 2024 00:08:26 +0000
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
Subject: [PATCH bpf-next v8 0/4] bpf: add cpu cycles kfuncss
Date: Wed, 20 Nov 2024 16:08:10 -0800
Message-ID: <20241121000814.3821326-1-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: SzaX-7BwAfofol47sgtMAt298lucogdG
X-Proofpoint-ORIG-GUID: SzaX-7BwAfofol47sgtMAt298lucogdG
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

Selftests are also added to check whether the JIT implementation is
correct and to show the simplest usage example.

Change log:
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
  selftests/bpf: add selftest to check rdtsc jit
  selftests/bpf: add usage example for cpu cycles kfuncs

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

