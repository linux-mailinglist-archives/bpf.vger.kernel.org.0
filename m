Return-Path: <bpf+bounces-62036-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EF5AF0919
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 05:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7CCA1C07130
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 03:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C36119F101;
	Wed,  2 Jul 2025 03:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvAIZR6I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E5CAD51
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 03:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751426267; cv=none; b=VwYUIQIh1SPW1tGT62ZQBWwkxEpPwTAjThroXdVWliV0CWH0sg6w4e3Ew53+GxhWUxVKO8psQuqOpMh+gYhK+5yWtUfmgaHSsHnCNGCVjOib1pHXkPAOzblYgkWm1hbPB12F8Fx3dsCXUWUO0oMOaHC30Ilr64dFm9VML2XpzJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751426267; c=relaxed/simple;
	bh=STLRqYYfDvxFq1a3WHpbDQN9cClmmObXBKXyucKeHtE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mKdmdTBKcc3oBi5WrlZ4F52ccGBBGjy8b1SiCfuPMwT3T3pPwRwaS9XU0yL9x4AkDWs2xmPsCxfeTB0FcViLLplXElmEcXP52VjPHRKizFiEAWT7zlzNBlQ2W7v7OtKuDU7qfAgZl/3XIL6f8X0a2rvEpZxWGhVvP1Snl7H1h8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XvAIZR6I; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-ad574992fcaso670923266b.1
        for <bpf@vger.kernel.org>; Tue, 01 Jul 2025 20:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751426264; x=1752031064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Roy9HDNV4sQzpEd+NQUasOP30XAKvXubYH3Pf/50kmY=;
        b=XvAIZR6IJFYrHFn0qnGTJlpWBuzYb+NkD1R8CP2cRjJka5YrtwV7Lq7+iW62EDf/bQ
         Edd3mf0XfTpP4q/hKEiLk7UeuxdRG2eQXdCbPtqYF2KYTG2VqR3MRSarJSzfvLuTm/Wq
         9VlAVaO3xb7qQKwSIjTpKrpZdfNUzbx0T0Ph4aqxNt5lXBNkE7QAT3puzD2g35cJ2dtV
         Sj9NiSptzQQmOK7/nmdR/ufmPNUVgy+TnonsgFKWbAIV1khgxHyRY4MJ84xI/uK78GcL
         Bq0huMt397+era2fPY/znqlhhRjdNZEoBsHlqIqNjfmDsTlDXHqaMXXoafoWj6Zx0Ehm
         OboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751426264; x=1752031064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Roy9HDNV4sQzpEd+NQUasOP30XAKvXubYH3Pf/50kmY=;
        b=wyQvURNRIJ9CBVFgGrwZBxZl9BYx/nGV4hYSRGlOjwH7SY+ut6TIVNMKCW8RwtZmwC
         cktCIwJLkftrjIp809WL+pm+KPMmbaKTokpt5R/yVS4brIO7Mfz6ZW/TV43XMaKZ33ur
         RQ1oLrusyWEv8+O1upDxfPEOT0CISY3qolFo2JsNwwO/FCaReO0gdjsYi05OapJx0j/E
         X2uEDZmHKhJmq3jVc2TDOEZU+UbeOGZesHCVWKgsAC7fDconaPugJBhNP8qdiApsqhMW
         a4w0Guq0B9aXuBOJuH02I8t10HV0trETh4zdZK3RdQYW3qS19DLHVUnFgv0pkwwXghDi
         1Xng==
X-Gm-Message-State: AOJu0YyLYZo1vEqTB0Wv0w23SG5Fd4YyEELjOYCmmzBfQpzK3JPrRJUg
	ZhIWVnxAyc8i6mr9ytQwbrZhm4qlz5oQ/xA2K/4ok+Lk0jy6TEvlpppoTOjg8mI3Uvw=
X-Gm-Gg: ASbGncvnsiAiBa80JzSFlDGA7G4+bxLDsjZRVP9N8tqNzDiylZupAHFWx6yOAsTaHq+
	6QybScqC06fmqyJe9fIwMcDSC3aFCDoE5rFNDW6Iv1VWPK4RCr0fRbCDPxT3qbYtm/saUjgAohL
	ePBLwg+K6oQRCM1OsKmJzvoStISa8DT5WqlLY4ViZsibXNY8gyehES/Q/ZlhobkcPf7/5qCXioN
	m85PpTQlOqUj13hF4ItBo/+9zoozBjWyNm84oY1C1+W3VKaftaMtHWelx7ZWIIciPfZLHG0sBOV
	4IUSW0BOrq4J6eqiZZMB2SEuYW0S+u7PgziDgdcwxutxCn7VPRp1
X-Google-Smtp-Source: AGHT+IElBGaKQwHb2K0kslnf7KT0II/c/RDtozFWShblG+1JaGHXc5/ry1o0nSbHMLLimiezFk+CWA==
X-Received: by 2002:a17:906:6d47:b0:ae0:bdc2:994d with SMTP id a640c23a62f3a-ae3c2c7d104mr84197366b.55.1751426263322;
        Tue, 01 Jul 2025 20:17:43 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c01a24sm994401466b.75.2025.07.01.20.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 20:17:42 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Barret Rhoden <brho@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 00/12] BPF Standard Streams
Date: Tue,  1 Jul 2025 20:17:25 -0700
Message-ID: <20250702031737.407548-1-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8089; h=from:subject; bh=STLRqYYfDvxFq1a3WHpbDQN9cClmmObXBKXyucKeHtE=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoZKFQq/NXpVKoaJhR9bjENwKn887nku2BiruHEwLu hCAy9N+JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaGShUAAKCRBM4MiGSL8Ryrf3D/ 40pHbmOypMpeaDsaYpeaYDu1B05B9KI598lbnyfXELwK+gI9JqmeYBjfnD7WqypYesbAgwsr5t0FUQ APq7gqGTJSw0KIH0CNjpbDJcaPazSj5CY83ILYLrCKoi5ZvL4rl9jDENFWcT/LYfJLABAdv+KoJfey 0yJvXCVsAp2esQrkTQXEFyW7gLg7YFHC9OVs7V4Mo7AF/zaF+chotzAVfawRYjn+Q53lbdKZr7C3HR rNeqOiM4N05a9SJnthx/f4/yejUA12eLsom4ZHGdFgEVb3FQ+0VW2J0TMYAMxU0egpE4wLoc7cRzHj hr4KC58D4PsaKCMzLFMWy9/l5OBzO18bA1xLdpSQNxwxsWcYlQ+2Jq3tNYw6lNR30020JgFSPoINr9 uxbPP4ECt2L/QU0rUR79C209bvP7uHK+LiJT0R3u/caDiiqr/gYXk3x0BBXzNRc8um5K6WoWUVlLsZ CofN03cCEL6+mjtq47c0TPqHDi95DkpMPpDU+/2iLOnGvpP/JLPmAj13nyw0m5hbZFLPxSKWiEBlCH E2mmdudu6gxgmta1ISJnSeE+vo0byWoPWxNtCjWjoRw2Y3rxYfCJLR9wUZfRWAuI9tkJHowPy841dj uhQT4i8KxxYK2ZmBpGEjKQVFitoVH+eJfK3g1EGCK0viCbV/tYDlUcFYe4Ig==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

This set introduces a standard output interface with two streams, namely
stdout and stderr, for BPF programs. The idea is that these streams will
be written to by BPF programs and the kernel, and serve as standard
interfaces for informing user space of any BPF runtime violations. Users
can also utilize them for printing normal messages for debugging usage,
as is the case with bpf_printk() and trace pipe interface.

BPF programs and the kernel can use these streams to output messages.
User space can dump these messages using bpftool.

The stream interface itself is implemented using a lockless list, so
that we can queue messages from any context. Every printk statement into
the stream leads to memory allocation. Allocation itself relies on
try_alloc_pages() to construct a bespoke bump allocator to carve out
elements. If this fails, we finally give up and drop the message.

See commit logs for more details.

Two scenarios are covered:
 - Deadlocks and timeouts in rqspinlock.
 - Timeouts for may_goto.

In each we provide the stack trace and source information for the
offending BPF programs. Both the C source line and the file and line
numbers are printed. The output format is as follows:

ERROR: AA or ABBA deadlock detected for bpf_res_spin_lock
Attempted lock   = 0xff11000108f3a5e0
Total held locks = 1
Held lock[ 0] = 0xff11000108f3a5e0
CPU: 48 UID: 0 PID: 786 Comm: test_progs
Call trace:
bpf_stream_stage_dump_stack+0xb0/0xd0
bpf_prog_report_rqspinlock_violation+0x10b/0x130
bpf_res_spin_lock+0x8c/0xa0
bpf_prog_3699ea119d1f6ed8_foo+0xe5/0x140
  if (!bpf_res_spin_lock(&v2->lock)) @ stream_bpftool.c:62
bpf_prog_9b324ec4a1b2a5c0_stream_bpftool_dump_prog_stream+0x7e/0x2d0
  foo(stream); @ stream_bpftool.c:93
bpf_prog_test_run_syscall+0x102/0x240
__sys_bpf+0xd68/0x2bf0
__x64_sys_bpf+0x1e/0x30
do_syscall_64+0x68/0x140
entry_SYSCALL_64_after_hwframe+0x76/0x7e

ERROR: Timeout detected for may_goto instruction
CPU: 48 UID: 0 PID: 786 Comm: test_progs
Call trace:
bpf_stream_stage_dump_stack+0xb0/0xd0
bpf_prog_report_may_goto_violation+0x6a/0x90
bpf_check_timed_may_goto+0x4d/0xa0
arch_bpf_timed_may_goto+0x21/0x40
bpf_prog_3699ea119d1f6ed8_foo+0x12f/0x140
  while (can_loop) @ stream_bpftool.c:71
bpf_prog_9b324ec4a1b2a5c0_stream_bpftool_dump_prog_stream+0x7e/0x2d0
  foo(stream); @ stream_bpftool.c:93
bpf_prog_test_run_syscall+0x102/0x240
__sys_bpf+0xd68/0x2bf0
__x64_sys_bpf+0x1e/0x30
do_syscall_64+0x68/0x140
entry_SYSCALL_64_after_hwframe+0x76/0x7e

Changelog:
----------
v3 -> v4
v3: https://lore.kernel.org/bpf/20250624031252.2966759-1-memxor@gmail.com

 * Switch to alloc_pages_nolock(), avoid incorrect memcg accounting. (Alexei)
   * We will figure out proper accounting later.
 * Drop error limit logic, restrict stream capacity to 100,000 bytes. (Alexei)
 * Remove extra invocation of is_bpf_text_address(). (Jiri)
 * Avoid emitting NULL byte into the stream text, adjust regex in selftests. (Alexei)
 * Add comment around rcu_read_lock() for bpf_prog_ksym_find. (Alexei)
 * Tighten stream capacity check selftest.
 * Add acks from Andrii.

v2 -> v3
v2: https://lore.kernel.org/bpf/20250524011849.681425-1-memxor@gmail.com

 * Fix bug when handling single element stream stage. (Eduard)
 * Move to mutex for protection of stream read and copy_to_user(). (Alexei)
 * Split bprintf refactor into its own patch. (Alexei)
 * Move kfunc definition to common_btf_ids to avoid initcall proliferation. (Alexei)
 * Return line number by reference in bpf_prog_get_file_line. (Alexei)
 * Remove NULL checks for BTF name pointer. (Alexei)
 * Add WARN_ON_ONCE(!rcu_read_lock_held()) in bpf_prog_ksym_find. (Eduard)
 * Remove hardcoded stream stage from macros. (Alexei, Eduard)
 * Move refactoring hunks to their own patch. (Alexei)
 * Add empty opts parameter for future extensibility to libbpf API. (Andrii, Eduard)
 * Add BPF_STREAM_{STDOUT,STDERR} to UAPI. (Andrii)
 * Add code to match on backtrace output. (Eduard)
 * Fix misc nits.
 * Add acks.

v1 -> v2
v1: https://lore.kernel.org/bpf/20250507171720.1958296-1-memxor@gmail.com

 * Drop arena page fault prints, will be done as follow up. (Alexei)
 * Defer Andrii's request to reuse code and Alan's suggestion of error
   counts to follow up.
 * Drop bpf_dynptr_from_mem_slice patch.
 * Drop some acks due to heavy reworking.
 * Fix KASAN splat in bpf_prog_get_file_line. (Eduard)
 * Collapse bpf_prog_ksym_find and is_bpf_text_address into single
   call. (Eduard)
 * Add missing RCU read lock in bpf_prog_ksym_find.
 * Fix incorrect error handling in dump_stack_cb.
 * Simplify libbpf macro. (Eduard, Andrii)
 * Introduce bpf_prog_stream_read() libbpf API. (Eduard, Alexei, Andrii)
 * Drop BPF prog from the bpftool, use libbpf API.
 * Rework selftests.

RFC v1 -> v1
RFC v1: https://lore.kernel.org/bpf/20250414161443.1146103-1-memxor@gmail.com

 * Rebase on bpf-next/master.
 * Change output in dump_stack to also print source line. (Alexei)
 * Simplify API to single pop() operation. (Eduard, Alexei)
 * Add kdoc for bpf_dynptr_from_mem_slice.
 * Fix -EINVAL returned from prog_dump_stream. (Eduard)
 * Split dump_stack() patch into multiple commits.
 * Add macro wrapping stream staging API.
 * Change bpftool command from dump to tracelog. (Quentin)
 * Add bpftool documentation and bash completion. (Quentin)
 * Change license of bpftool to Dual BSD/GPL.
 * Simplify memory allocator. (Alexei)
   * No overflow into second page.
   * Remove bpf_mem_alloc() fallback.
 * Symlink bpftool BPF program and exercise as selftest. (Eduard)
 * Verify output after dumping from ringbuf. (Eduard)
 * More failure cases to check API invariants.
 * Remove patches for dynptr lifetime fixes (split into separate set).
 * Limit maximum error messages, and add stream capacity. (Eduard)

Kumar Kartikeya Dwivedi (12):
  bpf: Refactor bprintf buffer support
  bpf: Introduce BPF standard streams
  bpf: Add function to extract program source info
  bpf: Ensure RCU lock is held around bpf_prog_ksym_find
  bpf: Add function to find program from stack trace
  bpf: Add dump_stack() analogue to print to BPF stderr
  bpf: Report may_goto timeout to BPF stderr
  bpf: Report rqspinlock deadlocks/timeout to BPF stderr
  libbpf: Add bpf_stream_printk() macro
  libbpf: Introduce bpf_prog_stream_read() API
  bpftool: Add support for dumping streams
  selftests/bpf: Add tests for prog streams

 arch/x86/net/bpf_jit_comp.c                   |   1 -
 include/linux/bpf.h                           |  73 ++-
 include/uapi/linux/bpf.h                      |  24 +
 kernel/bpf/Makefile                           |   2 +-
 kernel/bpf/core.c                             | 110 +++-
 kernel/bpf/helpers.c                          |  38 +-
 kernel/bpf/rqspinlock.c                       |  23 +
 kernel/bpf/stream.c                           | 522 ++++++++++++++++++
 kernel/bpf/syscall.c                          |  25 +
 kernel/bpf/verifier.c                         |   1 +
 .../bpftool/Documentation/bpftool-prog.rst    |   7 +
 tools/bpf/bpftool/bash-completion/bpftool     |  16 +-
 tools/bpf/bpftool/prog.c                      |  49 +-
 tools/include/uapi/linux/bpf.h                |  24 +
 tools/lib/bpf/bpf.c                           |  20 +
 tools/lib/bpf/bpf.h                           |  21 +
 tools/lib/bpf/bpf_helpers.h                   |  16 +
 tools/lib/bpf/libbpf.map                      |   1 +
 .../testing/selftests/bpf/prog_tests/stream.c | 141 +++++
 tools/testing/selftests/bpf/progs/stream.c    |  81 +++
 .../testing/selftests/bpf/progs/stream_fail.c |  17 +
 21 files changed, 1188 insertions(+), 24 deletions(-)
 create mode 100644 kernel/bpf/stream.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/stream.c
 create mode 100644 tools/testing/selftests/bpf/progs/stream.c
 create mode 100644 tools/testing/selftests/bpf/progs/stream_fail.c


base-commit: 212ec92295673a362453f8ede36033b61c7983fa
-- 
2.47.1


