Return-Path: <bpf+bounces-58875-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1802EAC2CD6
	for <lists+bpf@lfdr.de>; Sat, 24 May 2025 03:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20163A413C7
	for <lists+bpf@lfdr.de>; Sat, 24 May 2025 01:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469F01C862D;
	Sat, 24 May 2025 01:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDUbeTqs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CCE1C32
	for <bpf@vger.kernel.org>; Sat, 24 May 2025 01:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748049534; cv=none; b=X8AlT7QIN1hCTZqFo7hjnlzaZrho+fPt0BcX1OZxxvIkWNRPWdT6AhvT0NvGD0L8Zu8ZRdBeUZgpUE5Qy3VreROdw+1LsIqsB3VqQZTis4AhLn9HqW4PlmTF3i6HlWUSM0hAdkaLkfKCTojVw5GhkCK+CZth7q44hHqQXvysVng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748049534; c=relaxed/simple;
	bh=mFVh+IfKx+j5X6wGFpluJ0mKmIWFm0XU8LD6EkwHziU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d11GIIei4DjFzDPhFkRFslJiChALg91bwqIJuM78BaX9wJaRHCgCebBJl3IkW7H3gioOaYeiiDyqVXsBvhKcpLX4J+djbTM4wp6kAuiD+RkSKXNLE4KGopsB0HxSwjJhmY58YEKC9mHNyKbxT1mMaXPhbFKq5CpmmaojuNJajVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KDUbeTqs; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-3a37a243388so390134f8f.1
        for <bpf@vger.kernel.org>; Fri, 23 May 2025 18:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748049531; x=1748654331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iflPHyOsOhLpmPWf4fxmKLNjHEwQh6+/Ugt9VZLwaUE=;
        b=KDUbeTqsghHdKpm5wQ3/KH23+q2sN61I7IM2xtEulieE/sVHt1OVeLY0T3HUsA6Zgr
         3eF3A8fRfabbbtJ5Lqi7IJxtbrPaiZVPAqVzVBPddThVhZS9/BZSfZ4p/9wJhhsJqQ52
         0byNaG+68wNQ5yO9BuhasXspc0lfs9quNpBZDvrtKXi/b9Jo91OrRxVcC6y6mik4Ei2f
         YVg30NyOHTEUAvQhDd2GEZVmbGpWGZ4NYZkBnBy4hbmPULeeZvJr0umgS5zjx+euEwNx
         q7dIYYlJzEOQmCi18rbkherFJtPFGqMpSa7g++Tbqi3jX62DbV+gnQMDLOY6ka0exR9i
         FLxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748049531; x=1748654331;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iflPHyOsOhLpmPWf4fxmKLNjHEwQh6+/Ugt9VZLwaUE=;
        b=pRwj20M9iZ0Vvpgz7dnkuKLm2nWzx3u/5jmH3WuQIrUT6mnHH0CWb9/a+FIrvvDRKG
         Niut/M8b+c7Q3NUiQAX21picoqqK380yfFLxGf+dBbCFvJIM9Ch2hnkMnlKXs8gjPhdE
         AMdgKVZzibHrfcg7Bi9+oaAvI/XX86a3i4G2Pr8PO3m8tLvGqBDPT9g6D/xetWEkA9Ya
         4Z1taCngDAFn8UWGpx3JVhwmrIRx1FihJjXPlp6BqOSoChBHEoh838lzPKln16BS74oQ
         YaRgao4DqYk9+gO1fDJfIqVTw6i3Br62v3pzrFwjvZ9Y7eHIrOnL3UYtXekFZm3j+C40
         Bn+w==
X-Gm-Message-State: AOJu0Yyn/HIooX2AJJS/Y1BtEG8d+r1PT6QXw+W0JMYYnC0YCJHq5DvT
	WA6XAZrC8Yg94SjmQvkm/PnE27c7N3Tbfic3l0v/edoFlOs/VkIjnnPXEn/6XKyb+1g=
X-Gm-Gg: ASbGncu1VvJ7oXYeH+b2MCXCd0Ov5Q/ZFOft/O4Lei4u/Cpj9U/ybKMgkYWAu5+d4fR
	LdCnheb8GUSBDPKw9E41yPFuFFhGqYhZANIzfo3EcZP8MumSiFv9pfSQ+n9zslElVT+OFXo/61T
	jIZpNwytP2t/WmZ6CYPKiS8i0xR0oovFVEOkMhBSTmuxKDqDgP7yteVCyAUXhXnisreqd0QKlef
	Z6hoAI5jFg2SydFqtJwdcqBRIntnl1boPHRfV9bPbWY5d9+60jOxHK++rg8VC5B3vUeIYqvQBHk
	N9omIuWGo3NKSTXTg5gAr8Jicxaf2Umh1va4PE0n
X-Google-Smtp-Source: AGHT+IGGQ3XnBiA+vgTS+Xofjf5xz9uD5P0pK631nOUUQQKCA8Nmjuzgjk6Jqa46CwTtNomm/qOwkg==
X-Received: by 2002:a05:6000:2481:b0:3a3:712e:c4c9 with SMTP id ffacd0b85a97d-3a4cb499875mr1075471f8f.52.1748049530775;
        Fri, 23 May 2025 18:18:50 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:4::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f1ef032esm166384995e9.9.2025.05.23.18.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 18:18:50 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 00/11] BPF Standard Streams
Date: Fri, 23 May 2025 18:18:38 -0700
Message-ID: <20250524011849.681425-1-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6536; h=from:subject; bh=mFVh+IfKx+j5X6wGFpluJ0mKmIWFm0XU8LD6EkwHziU=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoMR3Okb91HLXEHocPoz/EdF9CgNwuHDSfS7uEUgS+ fppkkSmJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaDEdzgAKCRBM4MiGSL8RyrymD/ 0degBfKbnYymfNA5ewk0HUatym/Hagwig8R4H0TUKggdQ0u9QmIEl9loQPl+zvZNbLHndnVbiB6Nwp C3QNIZNh9KaOBfHJC55VLyqMQ2yAf14iHdM8OAjOdz1hLMUIWNKaM2zZ2WCkmW8vdRYxSJPzTupaTv +xzJWburcZE2uXu2At8IMnsvPgCrC1/j0XDLyhoT+XwU6CQ1nhCv6wk8jJ2ZD8x5e/rV7s/CtN+IiT Q2XU/SAv1GKw3QDiKl+2e9gWQONC0L+k2KG32OSyNt6Zw89Tq8saxsxgNDCo+JF2kuxCudenJk+iHV YXKPl/tasc9PYzsL6qM9B4+wa9lJR/i0WzoICbeZT9T4QN6N6dUA3OQA6vWSwDiniw4X8lSXyMjCtV teH/KGLighdv7V7t4YM1CToTnPnAjfiN8by8hF/nLlukgWkgcu458QlDVdlAetqDlgKT/n4FvsAi9U ZSMUBBRjUdemiIO62hjNVXScNGfYAVyrVMKco5RAafLXTWwWrA44YPkk1vQKzReS22ekUqnC23i8J+ Cxddsq/hrtBxQoYfSvvQpIu4NewRi+aKIcRqotEGvbAfOPExPGk20T7m13UQM3IQanijAWD0R7gt7g R+L7/69UlEUNEx7XKqguzQXeGjvtFR86uBzSPOOv7KsFZ1+7wkAWseC4w81A==
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

Kumar Kartikeya Dwivedi (11):
  bpf: Introduce BPF standard streams
  bpf: Add function to extract program source info
  bpf: Add function to find program from stack trace
  bpf: Hold RCU read lock in bpf_prog_ksym_find
  bpf: Add dump_stack() analogue to print to BPF stderr
  bpf: Report may_goto timeout to BPF stderr
  bpf: Report rqspinlock deadlocks/timeout to BPF stderr
  libbpf: Add bpf_stream_printk() macro
  libbpf: Introduce bpf_prog_stream_read() API
  bpftool: Add support for dumping streams
  selftests/bpf: Add tests for prog streams

 arch/x86/net/bpf_jit_comp.c                   |   1 -
 include/linux/bpf.h                           |  85 ++-
 include/uapi/linux/bpf.h                      |  19 +
 kernel/bpf/Makefile                           |   2 +-
 kernel/bpf/core.c                             | 112 +++-
 kernel/bpf/helpers.c                          |  26 +-
 kernel/bpf/rqspinlock.c                       |  22 +
 kernel/bpf/stream.c                           | 544 ++++++++++++++++++
 kernel/bpf/syscall.c                          |  27 +-
 kernel/bpf/verifier.c                         |   5 +-
 .../bpftool/Documentation/bpftool-prog.rst    |   7 +
 tools/bpf/bpftool/bash-completion/bpftool     |  16 +-
 tools/bpf/bpftool/prog.c                      |  50 +-
 tools/include/uapi/linux/bpf.h                |  19 +
 tools/lib/bpf/bpf.c                           |  16 +
 tools/lib/bpf/bpf.h                           |  15 +
 tools/lib/bpf/bpf_helpers.h                   |  16 +
 tools/lib/bpf/libbpf.map                      |   1 +
 .../testing/selftests/bpf/prog_tests/stream.c | 110 ++++
 tools/testing/selftests/bpf/progs/stream.c    |  75 +++
 .../testing/selftests/bpf/progs/stream_fail.c |  17 +
 21 files changed, 1159 insertions(+), 26 deletions(-)
 create mode 100644 kernel/bpf/stream.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/stream.c
 create mode 100644 tools/testing/selftests/bpf/progs/stream.c
 create mode 100644 tools/testing/selftests/bpf/progs/stream_fail.c


base-commit: 079e5c56a5c41d285068939ff7b0041ab10386fa
-- 
2.47.1


