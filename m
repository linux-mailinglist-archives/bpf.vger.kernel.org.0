Return-Path: <bpf+bounces-45111-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EF69D1879
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 19:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B228E1F23F1C
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 18:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E931DED6A;
	Mon, 18 Nov 2024 18:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="giMV+ukl"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1C41E102A
	for <bpf@vger.kernel.org>; Mon, 18 Nov 2024 18:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731956023; cv=none; b=ACTyJdyjxfabf9NssKE2l09nEEWj8NhEIaTMo7U7ISAB8c310rB86/2pueKHgbtKK37FFSSa4sSyQmXfuzu0r+uFptrtWKcKPOTEYZkS7YE/AnTO7+dRIhEJznk7K+Vp6pBGGwybHNmZO6947KRRgzL84gMKmbr2+MOCvVZy41k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731956023; c=relaxed/simple;
	bh=cbQ+DWCjCkcMhndSa1EJpMWde5gxCWPfifJ4v+szBg8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qc1lWD4JDbErQiglZ7kttO/73/dSPPcO9Ytigx/9AcKK6b1JzBY+2z+GmWsbvpU1Adg03YpfjU2wsVvYPLNBVbg5tjK7AgpdMFzdoTLiVcHfbd2uZQ8fWifZKZLa/QyOjqLTfCZx4WyUG5ywkwV9FfcWdbvIA6eIknUTMGL9DE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=giMV+ukl; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 4AIH0wlw026767;
	Mon, 18 Nov 2024 10:53:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=jYrVHfEGyH4EbntrDl
	Zf8F+8Pcr1VWl218ESKtvEgFA=; b=giMV+uklhA21IxeUhNFLFNHQ9iQfn78xbZ
	E+7N5ZXIPvLsNxxGkDD5fabad4SXvQ1VtC06gqrx0sRyYxGmJmruaN/efkGcbkWK
	lx3MQcPNUlTToZRlYLrbBKvgE+nDNhArhhiLWkEqlaKkOWe4vTVD087iwoc3cfi5
	iM8wlwFC7xn4yONLK0HqSv/Aqn9HJg6Roudc75EBHFnXZGK1E/CpBF4RuXkbcvc3
	MiqL5qVZGN1qTq8TKjP3hHbqW+W2wDV5+wcjGocg0t1gC6vU6qq28tJjll4CXHmk
	CV6SK7p8rqTDwBqSYYXDTH15ikGoUPmRRxGNd6VF4qoUHgknMAHQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 4309m20vdy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 18 Nov 2024 10:53:02 -0800 (PST)
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server id
 15.2.1544.11; Mon, 18 Nov 2024 18:53:00 +0000
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
        Vadim Fedorenko
	<vadfed@meta.com>,
        Martin KaFai Lau <martin.lau@linux.dev>
Subject: [PATCH bpf-next v7 0/4] bpf: add cpu cycles kfuncss
Date: Mon, 18 Nov 2024 10:52:41 -0800
Message-ID: <20241118185245.1065000-1-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: qTCmlufkbmIuGvAUzHx338WfVDDTKZBy
X-Proofpoint-GUID: qTCmlufkbmIuGvAUzHx338WfVDDTKZBy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

This patchset adds 2 kfuncs to provide a way to precisely measure the
time spent running some code. The first patch provides a way to get cpu
cycles counter which is used to feed CLOCK_MONOTONIC_RAW. On x86
architecture it is effectively rdtsc_ordered() function while on other
architectures it falls back to __arch_get_hw_counter(). The second patch
adds a kfunc to convert cpu cycles to nanoseconds using shift/mult
constants discovered by kernel. JIT version is done for x86 for now, on
other architectures it falls back to slightly simplified version of
vdso_calc_ns.

Selftests are also added to check whether the JIT implementation is
correct and to show the simplest usage example.

Change log:
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
* explicitly mention what counter it provides (Andrii)
* move kfunc definition to bpf.h to use it in JIT.
* introduce another kfunc to convert cycles into nanoseconds as
* more meaningful time units for generic tracing use case (Andrii)
v1 -> v2:
* Fix incorrect function return value type to u64
* Introduce bpf_jit_inlines_kfunc_call() and use it in
	mark_fastcall_pattern_for_call() to avoid clobbering in case
	of running programs with no JIT (Eduard)
* Avoid rewriting instruction and check function pointer directly
	in JIT (Alexei)
* Change includes to fix compile issues on non x86 architectures


Vadim Fedorenko (4):
  bpf: add bpf_get_cpu_cycles kfunc
  bpf: add bpf_cpu_cycles_to_ns helper
  selftests/bpf: add selftest to check rdtsc jit
  selftests/bpf: add usage example for cpu cycles kfuncs

 arch/x86/net/bpf_jit_comp.c                   |  61 ++++++++++
 arch/x86/net/bpf_jit_comp32.c                 |  33 ++++++
 include/linux/bpf.h                           |   6 +
 include/linux/filter.h                        |   1 +
 kernel/bpf/core.c                             |  11 ++
 kernel/bpf/helpers.c                          |  39 +++++++
 kernel/bpf/verifier.c                         |  41 ++++++-
 .../bpf/prog_tests/test_cpu_cycles.c          |  35 ++++++
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/test_cpu_cycles.c     |  25 +++++
 .../selftests/bpf/progs/verifier_cpu_cycles.c | 104 ++++++++++++++++++
 11 files changed, 352 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_cpu_cycles.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_cpu_cycles.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_cpu_cycles.c

-- 
2.43.5


