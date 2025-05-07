Return-Path: <bpf+bounces-57672-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 868E9AAE78F
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 19:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BF2A1C02115
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 17:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAD821ABAA;
	Wed,  7 May 2025 17:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibFIzDSK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206811A0BF1
	for <bpf@vger.kernel.org>; Wed,  7 May 2025 17:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746638246; cv=none; b=X5PmbiEeo1jYrL4MVrMB76yBac6JuOfN23B5I0DmZCDSuFJEYsWlfZveM9jFQjVGMDoCUsKJBw3q84fqRE2PDjh8G13Xw3Bt8Shynpkh58qnrNN8QVTOqMcFAHTA6xSyIXec8APCmhphk3C+RDXZQIfbFZ3YB8SLrE1lf02j7a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746638246; c=relaxed/simple;
	bh=oqX2UMG7NTqszgcetG7351BAgZt9PfDaToWHfAlPH4I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bzS1I93GKrGsDobTQrU7opgUftL04zTbh2l418n2dRRK8BCC+omdH2Bx7JYm2bMwIPxcx7/3OMj3aVHxOMCMwMK5NDF75ZZyPh16zFNUMY2l8u5zMnlOUbRRb0mKBRV5AsgHxZ3CVmuCc7ou0O9Tfc2EWfoe37MYocMNaDzKtks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ibFIzDSK; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-43cf3192f3bso1454865e9.1
        for <bpf@vger.kernel.org>; Wed, 07 May 2025 10:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746638242; x=1747243042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rJSEqPi5wjqLFWwphGD6qIRgwPtjExPFCPb0VhCWuoU=;
        b=ibFIzDSKl7L9IvhpGjoWzi4yPcEml7XEC/2okIAMfDBnzjMqCatLXxBF3IB7OAvLNC
         wK1BgSWJL0ee3QMSgGJp/70T0GGtkDXhJJEAt4LnDvlSofr6NR0R01I8VV/NrsLafkpx
         KYlSn32Osx6k8NUzc8wiONThxqvbsh1gnVHZReB/pIma/5JgrZqivqCDwPj+U5E+pASY
         GBtKNFFTteNe+l73p4SezcYYkq+57M1/LCjYsOM8FVsBDBBrJ03+nhiiCUI8fRcoFCQa
         hZpTsatEKOeaVEXG7tMYShatfv0OY57bibZNq8+tjN/LWPv6Ls24Hd5G5bOfuffk1lgw
         lN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746638242; x=1747243042;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rJSEqPi5wjqLFWwphGD6qIRgwPtjExPFCPb0VhCWuoU=;
        b=fyLo/gELjz/NQqLtkBsk30+t8x8BfZIdRbXl1oUKw+ozU8Rzpp+MwSOYRYjXU7K3tD
         AnGMMzzwmkoYmOrChfToMXWYWJDNlURUFn4ays0n4L0vrYVumOd2/FGgtncwUOrXJnMa
         PmGKnXCN70a2Up0qSwvoOWeh/7F5GbHfsL/1XCdnbXwdUBihrRB2U2tZzBSkUg1hlLk6
         spMaJpJ+4LYUIzYeFQcxj8wJBGBjl/5MTU0wH/H5YBa+t19HXki1h+OA7NOIobXJsl3C
         cTu6WgvZLZwZ4BEdW6ENoKBMXlfIwv/m8i4TIgGYWQsM80W4F+uSeKQglZqYy1YFxbc7
         aghA==
X-Gm-Message-State: AOJu0Yz4/nHLChgUVXGHjQchGkpZSKEg+058IB3RR8ycTEQYwLUkn37C
	owCveF2eycbLLUQRozAS35CasoMBKrRjPKMpwkUDMrNMIOwMvLH1YjT10UXU0pU=
X-Gm-Gg: ASbGnctzJC/N1cno3vlG3b19a5xENzxNJ1sB0xUIy9rF9EAa0S/Zi4yZL4CyeCDTpYr
	OT7qzK4E6t8qG7YIlhyPK9dUlyYBrEoDwdSPogCyx5HwmoJbeKumNU7/IHERwoZpNxkdpKcaxkS
	aJadpv+ZmXm6uQv1N9pF/9YuCmC/5zFeYtmUZ788IohRVqqlL4Zk6T1uNc3HxxYCw0d7CP/knmP
	Py5efT/rZuvGIc6M1psoyfA4phhh3nqda591rVNhE0qa+PBpL/AKt/sHmbhmZufJk6xOdrBVgtK
	kAg7nLH86zL3y6CIdaLHaPYqsqk=
X-Google-Smtp-Source: AGHT+IHPIa8AlAs9bdFVGUE3mfQdkz7vPpnUcX3S2qi1pQTfe02teJ2EILS4aSQfk308WQLqLiryxg==
X-Received: by 2002:a05:600c:8106:b0:441:be49:d775 with SMTP id 5b1f17b1804b1-442d02e4b06mr3540965e9.5.1746638241946;
        Wed, 07 May 2025 10:17:21 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd33103dsm7319195e9.10.2025.05.07.10.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 10:17:21 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 00/11] BPF Standard Streams
Date: Wed,  7 May 2025 10:17:09 -0700
Message-ID: <20250507171720.1958296-1-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7343; h=from:subject; bh=oqX2UMG7NTqszgcetG7351BAgZt9PfDaToWHfAlPH4I=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoG5WI81ktyubJuqfAl+Bv5s/RAH9ij12GdYFX2BlR DL0TgnaJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaBuViAAKCRBM4MiGSL8RyohqD/ 9ciwgroOCLtlBzJidwU2wKLz72HisPvCumFmLbf53J08bZWccHFK0crgG1iaZi8JlL9/6jqcd/Uepz HURDRcMCZW8P15OqKUF8vfCznCqI9jRtOjylIGnW+7wZZWG4IijFfWYVxPBhOID3bx13M8LZeHdY2Z 9dBk/MTpN4yuf7z1LzA+E2yztEHqRH5oQj+nIqUs1v9NVZXWdIl0oSTJ3B8wYODWyEdinrX2KfP1zE UxSLUfQL3oEbxhZWMRs5Rq7cQtwXL807gyGLqK1ontP7NI4UmfIt9VVf8Qo5osOfzRrutoEJQ5eLmr NK7Zmq1Br8vT86pQedqGfR27Miruq98K7dyULCmjXo9LNzCKg439vD+j8t+qhWpuKJWP1xxhATBq/N 0G6RWk+8J81NION5Y6POvfedO3ccMZEs/w14Ai7TyYC7AnLwtPT/jtul8Myg4vO3HyAvQZDa6PTPdC TZDYFGMy54yAsGLy8jLEfla6qOtMuy6Bmq+b/taalXerH9vcAo6DXOLkb4Sa5b1PSemOFYW8w/H2SC C4+j+gJZtIDfG2kmG7bXkJJrCFlA/Qnpma0p9XAadQM0YG8+BaIVz7mmrhq0JttpJtILWqjK9tjx+7 1JLRGrTkx4BPXDaFtVPF8KESIbuiBMQQCHuQQL1Fog+ddEzV6gzK8iTEqQuw==
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

Three scenarios are covered:
 - Deadlocks and timeouts in rqspinlock.
 - Arena page faults.
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

ERROR: Arena READ access at unmapped address 0xdeadbeef
CPU: 48 UID: 0 PID: 786 Comm: test_progs
Call trace:
bpf_stream_stage_dump_stack+0xb0/0xd0
bpf_prog_report_arena_violation+0x90/0xb0
ex_handler_bpf+0x4a/0xa0
fixup_exception+0xde/0x310
kernelmode_fixup_or_oops.constprop.0+0x2f/0x70
exc_page_fault+0xdd/0x1d0
asm_exc_page_fault+0x26/0x30
bpf_prog_3699ea119d1f6ed8_foo+0x10c/0x140
  *(u64 __arena *)0xfaceb00c = *(u64 __arena *)0xdeadbeef; @ stream_bpftool.c:68
bpf_prog_9b324ec4a1b2a5c0_stream_bpftool_dump_prog_stream+0x7e/0x2d0
  foo(stream); @ stream_bpftool.c:93
bpf_prog_test_run_syscall+0x102/0x240
__sys_bpf+0xd68/0x2bf0
__x64_sys_bpf+0x1e/0x30
do_syscall_64+0x68/0x140
entry_SYSCALL_64_after_hwframe+0x76/0x7e

ERROR: Arena WRITE access at unmapped address 0xfaceb00c
CPU: 48 UID: 0 PID: 786 Comm: test_progs
Call trace:
bpf_stream_stage_dump_stack+0xb0/0xd0
bpf_prog_report_arena_violation+0x90/0xb0
ex_handler_bpf+0x4a/0xa0
fixup_exception+0xde/0x310
kernelmode_fixup_or_oops.constprop.0+0x2f/0x70
exc_page_fault+0xdd/0x1d0
asm_exc_page_fault+0x26/0x30
bpf_prog_3699ea119d1f6ed8_foo+0x111/0x140
  *(u64 __arena *)0xfaceb00c = *(u64 __arena *)0xdeadbeef; @ stream_bpftool.c:68
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
 * Simplify memory allocator (Alexei).
   * No overflow into second page.
   * Remove bpf_mem_alloc() fallback.
 * Symlink bpftool BPF program and exercise as selftest. (Eduard)
 * Verify output after dumping from ringbuf. (Eduard)
 * More failure cases to check API invariants.
 * Remove patches for dynptr lifetime fixes (split into separate set).
 * Limit maximum error messages, and add stream capacity (Eduard).

Kumar Kartikeya Dwivedi (11):
  bpf: Introduce bpf_dynptr_from_mem_slice
  bpf: Introduce BPF standard streams
  bpf: Add function to extract program source info
  bpf: Add function to find program from stack trace
  bpf: Add dump_stack() analogue to print to BPF stderr
  bpf: Report may_goto timeout to BPF stderr
  bpf: Report rqspinlock deadlocks/timeout to BPF stderr
  bpf: Report arena faults to BPF stderr
  libbpf: Add bpf_stream_printk() macro
  bpftool: Add support for dumping streams
  selftests/bpf: Add tests for prog streams

 arch/x86/net/bpf_jit_comp.c                   |  22 +-
 include/linux/bpf.h                           |  91 ++-
 kernel/bpf/Makefile                           |   2 +-
 kernel/bpf/arena.c                            |  14 +
 kernel/bpf/core.c                             |  95 ++-
 kernel/bpf/helpers.c                          |  63 +-
 kernel/bpf/rqspinlock.c                       |  22 +
 kernel/bpf/stream.c                           | 552 ++++++++++++++++++
 kernel/bpf/syscall.c                          |   2 +-
 kernel/bpf/verifier.c                         |  21 +-
 .../bpftool/Documentation/bpftool-prog.rst    |   6 +
 tools/bpf/bpftool/Makefile                    |   2 +-
 tools/bpf/bpftool/bash-completion/bpftool     |  16 +-
 tools/bpf/bpftool/prog.c                      |  88 ++-
 tools/bpf/bpftool/skeleton/stream.bpf.c       |  69 +++
 tools/lib/bpf/bpf_helpers.h                   |  44 +-
 .../testing/selftests/bpf/prog_tests/stream.c |  95 +++
 tools/testing/selftests/bpf/progs/stream.c    | 127 ++++
 .../selftests/bpf/progs/stream_bpftool.c      |   1 +
 .../testing/selftests/bpf/progs/stream_fail.c |  90 +++
 20 files changed, 1383 insertions(+), 39 deletions(-)
 create mode 100644 kernel/bpf/stream.c
 create mode 100644 tools/bpf/bpftool/skeleton/stream.bpf.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/stream.c
 create mode 100644 tools/testing/selftests/bpf/progs/stream.c
 create mode 120000 tools/testing/selftests/bpf/progs/stream_bpftool.c
 create mode 100644 tools/testing/selftests/bpf/progs/stream_fail.c


base-commit: 43745d11bfd9683abdf08ad7a5cc403d6a9ffd15
-- 
2.47.1


