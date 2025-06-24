Return-Path: <bpf+bounces-61337-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D7FAE5A5F
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 05:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D853716807A
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 03:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2007A19F11B;
	Tue, 24 Jun 2025 03:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l05e5dgZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC17123774
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 03:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750734777; cv=none; b=bBcVq+h2a631BNUs60kSnP41m46zab+cplwacydOQlaitjsm+MbpUaPIHFzAMtPG2yrwLE+WcgFx953EnBg/rRS7J/1aBxdChoSQVN6GpnBS0JuBxD4gTbis49UumTplzmyW4Xye7owjr4gefwRuPlJYkGdf2o03BnLgsk2QqDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750734777; c=relaxed/simple;
	bh=mdl6BXqIOTyGoZWwkwM+KbhXGqbHqL5mEn19qFQ2vpI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O9QJIRI+CP8bErAPzyAr0WrWhLa5521DRbpwiIfQtKeKxEcQ0ECssHJGkI8hDlK5xRk1sDtBGdhmg7478rho7Jv+7FKjhvJxggYasshWn5P0aJ8PGus4ARdj4SciL2GcSvTfQhyN2AkruP7Oox7JK3qWpjQiPGcdnyJPLswyziI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l05e5dgZ; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-60707b740a6so7353543a12.0
        for <bpf@vger.kernel.org>; Mon, 23 Jun 2025 20:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750734774; x=1751339574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BY+w+fneLEsipBa67iCl6ybGwY6wOET8d/QL5ekaSCE=;
        b=l05e5dgZ8xhRBSZJ8kG3PBCKSyXAJnCQWlAqJlkQBkTdha6qj2dw6gFqDzrhLDOUTx
         k+HpW/MfAT2Lwyb3EemRYk2SEjUfIwctq26c55dg2xeAlJEt10D5xuxQ0NmsRVlc4Ju6
         +WuOcsdrwfBy2eTDCX+3MUmdbsb1Giv6T1zw6QHiSP9vW6jIdnl5XzcpQOjrbHg43f5t
         ZLmarvCw5Q+uHhfos9pIkKFGBn2WzMN6ftR3Tcsb5RTfXUtnzMCu4ng8z2l74JYeSHvc
         5QkTQT50W0n6f94C0JvPdCtisHX7vcLSDt4SCG24+TkmHak7+fTe0Y1O6LEomL8Jz/4b
         3f+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750734774; x=1751339574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BY+w+fneLEsipBa67iCl6ybGwY6wOET8d/QL5ekaSCE=;
        b=hpcIfVCQ63GHvYsYPVnvA0e5r4gxTUj0aUM3r4+VGABdlitafaGKU0MpX83BbhTK/Q
         KlZeHtmnzypOieZvVexDRUrwtjlo2EqWXqxGzioyS6TUVW2/Yiy8iKQas5ctxAKOFriJ
         pAlCPLnP6rbsfVuREfGRACSjZLmedUJp2nGzRRrgF7a/nBY+r1xz5ybgVvOTOzLNB0MD
         C6Ubo3VbFraQ0mMbyplG3kXSRO+XLW8lO3lnFcKPAdGRVKJNT1MQxiZjQ+Q2YeinJTW+
         73CBQaLgkCYRIptINk5DnvWwkBHBSRd8YcdG3pYhaDQiK0zmoBNgeyBVVroQUcKryfWZ
         MLHQ==
X-Gm-Message-State: AOJu0Yys+w734iKbtrqH1k3vO3oSR+MeNdPYB4vrviKosbSq5qug8s9j
	Mv1ypAEve7gZV7jHgCefRBjGzhK4tFRf8FNh556p5NdLl3DnTDwmQM1rBjuJJiRyDpslaQ==
X-Gm-Gg: ASbGncs4/U/Cb/9AyDec8xj80N5hSyFPuKUCinaX4XagoYaj0LSBl+fIINPBqwp0O/x
	E764M+CmZJ6osfszFb3Ky3pMynpQd7XiNMgrNtNjuU0Faxkz09TLpi4WJycBwbCavMEeAwIb6hs
	iaSVq7MvCc2k/yJsaL5hntUxK0GZmUK9RMk6ymFn/3g0pV+voSbkEa95/p0IKVGbABR4Eu0gnse
	H1ITNWVg4taTxyWipZQLj1n81i7be9QEbDeCVKp2YB4GvpBsrt4oGS7FC7xqUUEmtqFOpijmWDV
	L84DuW0aOFkz30BsMO58cO6MQH0NiAnFagYQct88UCbrEQKlUSY=
X-Google-Smtp-Source: AGHT+IE7XZsWjFiFF/YdxDsOmQlaJ99uIcv1sYX8fCinAf/OfXzLeYMmzCUByLREx2A65dnfVVM16g==
X-Received: by 2002:a05:6402:1847:b0:609:9115:60f1 with SMTP id 4fb4d7f45d1cf-60a1d167659mr11436660a12.16.1750734773639;
        Mon, 23 Jun 2025 20:12:53 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c2f196f9asm362470a12.15.2025.06.23.20.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 20:12:53 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 00/12] BPF Standard Streams
Date: Mon, 23 Jun 2025 20:12:40 -0700
Message-ID: <20250624031252.2966759-1-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7446; h=from:subject; bh=mdl6BXqIOTyGoZWwkwM+KbhXGqbHqL5mEn19qFQ2vpI=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoWhWdhAyhRCmbhsm4ZsvwWDWJaDnRKr0EmeUvcUpK hCVUCpuJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaFoVnQAKCRBM4MiGSL8RygwND/ 9bR/0n1+yziSOtyZYDnfrudcapvcBaM5/2Hz+rji8tQgvcgkm19KNjvOSgXV1er+f/O2HrrQMuMbgk ppkaMMycW8KXeMmAkSIm8uoSX1x0qaUS4K/Hgh740X+yV9MmR/QMqQn2CYEq8vn+leCreAqmaMS//r MfXeVSyZfj/5kCymaqiXOT3a10X3Y/bjG6SMI0wKiG6RWtYkjwk6j9LL+G+dToAa/iOfapTxbIJT9c U9tvB405L7OAFaUP1a/r1J9bRsvukxo5+Qzk5+9pcNavJaOdnEvRNrsB6W/bdb+TF55I9hCxu/9qxY 5Xm1Mq5zlNPRjN02BL/ipP9zCPj27lT8i9cAKoDtL+I4Vzws0CnHThi1/4QutW9QJqXTkmsFEXglM9 jAyNOe1QBFHoxMBhbSIvztxP/UO1VbNT572CxFjMkJ5QiL+r0sklss6brgg4HQNs3gXREA+jq9BvJs 5rIXaxO+vV2n5B6Bk/nLQY9lFFVfab0iJLP4vZVUsBrJl6YGyRIcsUBhCxh05VJtjEZ6z7hMGV91qB h/n0PwCfj/zhrOZ9BEnrpJMg4QAeoLvMR9O7LvbQypTvgLSxwqYjuqYx6mWUpHKCt9ICv2xCeYD3vt L0PFS7HF/9By5TBpo4SiU44CA8zZCqgQhcPHL3ieBxQ9Tf+ShlpUG4jSJ1xw==
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
 include/linux/bpf.h                           |  80 ++-
 include/uapi/linux/bpf.h                      |  24 +
 kernel/bpf/Makefile                           |   2 +-
 kernel/bpf/core.c                             | 105 +++-
 kernel/bpf/helpers.c                          |  29 +-
 kernel/bpf/rqspinlock.c                       |  23 +
 kernel/bpf/stream.c                           | 529 ++++++++++++++++++
 kernel/bpf/syscall.c                          |  27 +-
 .../bpftool/Documentation/bpftool-prog.rst    |   7 +
 tools/bpf/bpftool/bash-completion/bpftool     |  16 +-
 tools/bpf/bpftool/prog.c                      |  49 +-
 tools/include/uapi/linux/bpf.h                |  24 +
 tools/lib/bpf/bpf.c                           |  20 +
 tools/lib/bpf/bpf.h                           |  21 +
 tools/lib/bpf/bpf_helpers.h                   |  16 +
 tools/lib/bpf/libbpf.map                      |   1 +
 .../testing/selftests/bpf/prog_tests/stream.c | 140 +++++
 tools/testing/selftests/bpf/progs/stream.c    |  75 +++
 .../testing/selftests/bpf/progs/stream_fail.c |  17 +
 20 files changed, 1183 insertions(+), 23 deletions(-)
 create mode 100644 kernel/bpf/stream.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/stream.c
 create mode 100644 tools/testing/selftests/bpf/progs/stream.c
 create mode 100644 tools/testing/selftests/bpf/progs/stream_fail.c


base-commit: 3ce7cdde66e65a400b2d1b2a7f72c499e1db26b6
-- 
2.47.1


