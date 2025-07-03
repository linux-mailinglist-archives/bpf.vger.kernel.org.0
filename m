Return-Path: <bpf+bounces-62330-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A642AF8212
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 22:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8891F7AF416
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 20:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A76129DB81;
	Thu,  3 Jul 2025 20:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPXN0NT8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384961A2630
	for <bpf@vger.kernel.org>; Thu,  3 Jul 2025 20:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751575709; cv=none; b=KgSieR9Z3aQCYKSzUUu6s5pR1dzjpsp0nuVwOL8488r2mAqzeRcu0s4VZOUf+p9h+97366ZAfT0NxVk5xvCt+ym7MPPSg/arOkKC1T1ZfyPJzjs2IHNTnqiZzXBbG9rJ5aI+3qkjWXPcttSuvu49uM4Zc6s/L16Ifx8nvO1ja6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751575709; c=relaxed/simple;
	bh=JTQ+DEMpnoC7NAmSsdiOQt9AkPIycLI34jBV63e7GUE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rhSn7pFWu0QjN7EIRlDX3k+K3SfPBuFQ4c31KOjSGM80YC0G4iO5snI4Qpg6hcQE1WG07O9GTX2KAR1EzI9mt8/5X3lxMEa6YQNzMzdUmvudmAH4B3kOgpOI4o4aWNNE5ZnFd4CFwzeqVQIu3Lxyslp8ZAa2PkWj6ny/MkpI/SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kPXN0NT8; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-60bf5a08729so515810a12.0
        for <bpf@vger.kernel.org>; Thu, 03 Jul 2025 13:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751575704; x=1752180504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5luhx7S9hClB30KT1KvDG6QsCl9bhQBOLl5dsl1NDOg=;
        b=kPXN0NT8BHw94KvdXAoqlPSPd+wxSmxLAyqzWs+LJDQIEksXFdim3EYid7ccIZ1WUo
         UTytwHiVnsYvU6yEZFbcIKBdL70W/2J+Jl632CSxk6cb5VhOrBN8aHr47DJzu56yujj3
         8rYrOmR6dQunAr0xaOEXdZjfz+0OvC1gtYO6rWoM2EBKR3Shoe8BTVEKqI7dHyi6f7RI
         mDYfS+D0iKMoPxjb0GjDiy6DzzJCwBjgFHiBfkZjYGbwamk0BwP6tBRRBUKc4lzbhJKR
         388HjavaMrbUNXXW9lnj6dZt5Daz4bpl0aHEWSsTOf69EfHxwHZcJhMWysAWk+gE/YgA
         UFZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751575704; x=1752180504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5luhx7S9hClB30KT1KvDG6QsCl9bhQBOLl5dsl1NDOg=;
        b=g74QuS2y/3feIwKWBevH09kO0ScTVnE3wWIkKT6RnH7Wt6iVReKBoyXLYAQRf4Komh
         pByj2ISC17MhM6BSXV5enqjEGHqVBstSU/6RkXL8bYbghUiqUhwJow+g4bNv4mZOW3Uc
         0OHrWZ8rIzX3WkHwdQ1vQLdufIRKsW/sS6LqRYrD2QcLRndHKI147c33kw3Hcy0vJ05o
         m5RkX8GaxOVODCc8yyvMYpeteK4PO1Xoarejy5BTyNNsME9mJNVqc6UeURANgBmoxxx4
         VYI0Yqm1dFHDLT1iIUi7LgNRI9+KGftUsEL6rz9Hd4vJKO+tApOJNAcp4I5guzK8eRdW
         0Ujw==
X-Gm-Message-State: AOJu0YyOMFStWzCS8Z4vU1drOdGmyl6V5q2GpC/mXWLUVNhBmEypaYEq
	PYmjn2IcM4Yt8EdgMJP/HV97h8YR2hOiAvK7D1WAQ7oJE6Ny09Rxc+eD52LdVft4+0A=
X-Gm-Gg: ASbGncuYts0KKpSp6CCA9Kr709Lns+Bj9Gyw9gkv8OaCJVpKq2jfNGRV+DjCL5CFaPJ
	Jeyxy9Qa6rAYcW5aSt0qsKwy6TH4VhgRm9M9TzwF4iGlpjq0iVxJwK/Mu63A5b2D+mTZFdGkAo8
	0l/X/C2PyHQCzGp36af0NP7r7Jt6byPvh/FNDBAkEKsxwZI3RRv6gitdxkBDBHR2VHT4z9jBuNL
	PXXil6ukPY3J5931faes5E0mrcI42cwZaE+M/G2JAsXAyd5VSkOtg6PKHULmHFO74gW2mX6ER0z
	9b0wf0KTPUvRpwbjnnaNXVEFucKo7gQH75FsoQPqB9RkpynSvvU=
X-Google-Smtp-Source: AGHT+IF5V6zu9DdIbv10rb1DqyKgJ8LxdFHB4Po8GmhiO+L+9Gid6CXarLeWxs3iWTJUR48iODj3CA==
X-Received: by 2002:a17:907:2dac:b0:ade:4339:9367 with SMTP id a640c23a62f3a-ae3c2aeee6emr890119766b.26.1751575703640;
        Thu, 03 Jul 2025 13:48:23 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:5::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6b08d11sm37780666b.138.2025.07.03.13.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 13:48:23 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 00/12] BPF Standard Streams
Date: Thu,  3 Jul 2025 13:48:06 -0700
Message-ID: <20250703204818.925464-1-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8320; h=from:subject; bh=JTQ+DEMpnoC7NAmSsdiOQt9AkPIycLI34jBV63e7GUE=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoZudKVlXLadUc9qXQS169PkPd6AnkFjE6Fp9PqV64 yOGJHd6JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaGbnSgAKCRBM4MiGSL8RyiMUD/ 4wGSzJLa3pv2K/pe5Of+bUWU8ySnSjjd55qDGHCDC1gzikUDdjnYqr6lw+4kR1fk4TaoyPDLZoE6O2 AwGYslS8t6r1Hq6BCOzHBBda6KrZ/8AHSup6hf6p9fvOG/KFJevMS3Q0W8fzr3ouW+qxB6O+80klz0 gS68gKgIyXbVfz0TFOo6Xx8fiHDWxUXkQTnVyfdGhNY33u/xtZZuQUTQyjoScFmNtaAifA6mCpXHNM zKPOtAlcmnmSOnWPbpQWbxQMeT6YGR9X0sYwoD/55E9Pi8mZgSw+VPGErXcEuavrVmwcDXMwyDIEAw XVBbnK7X0+B/94MahdqiZj4buJaFLj6VnVYAigYqx3/kcL/KrPDaBqRB9DW3VhgtPdZuANvX627SKL qX+w2HKseBgZjKWnrCvarm31bQ9tnVNzkbcVnhCda5FPtFN1qgHVowl+agqLm+T85DmMmytINUXP93 zKIZMrGG0ZFiadTpjsgm0ElVhv3dvIdLhufT9wcTGBw5BY2VVs54dMQZ6gWFGYP+pOnqVayk9pB7RI 17g/MWD/dTVTDXb6nWimlNRKHqYNW4yjZf8pc+TeW267+j32KepXojSURMX2WcGmGus7IJzMF9rvzW j8dMAM9kqGhiWaRSlw7GYZt3RDkY47FnQ9DE+kmGYSH1+/yBslrNBQNv3dWA==
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
v4 -> v5
v4: https://lore.kernel.org/bpf/20250702031737.407548-1-memxor@gmail.com

 * Add acks from Emil.
 * Address various nits.
 * Add extra failure tests.
 * Make deadlock test a little more robust to catch problems.

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
 kernel/bpf/stream.c                           | 526 ++++++++++++++++++
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
 tools/testing/selftests/bpf/progs/stream.c    |  79 +++
 .../testing/selftests/bpf/progs/stream_fail.c |  33 ++
 21 files changed, 1206 insertions(+), 24 deletions(-)
 create mode 100644 kernel/bpf/stream.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/stream.c
 create mode 100644 tools/testing/selftests/bpf/progs/stream.c
 create mode 100644 tools/testing/selftests/bpf/progs/stream_fail.c


base-commit: 38d95beb4b24301362f8bdae7fbdb82d74b803ca
-- 
2.47.1


