Return-Path: <bpf+bounces-55870-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A90A88839
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 18:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B48817AA16F
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 16:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468F127F75D;
	Mon, 14 Apr 2025 16:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fr/MqTj7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9DD2741C3
	for <bpf@vger.kernel.org>; Mon, 14 Apr 2025 16:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744647288; cv=none; b=kok6ByzoUQpN0DAr4D1cN9n7ML5te+vGkqtqaBVMYYnvQGo90dL15V6SAIimH3TnpbTaxpkuZtiakApL6F2QYbyBfMCo3f8at/gwafCOVFVlXJiveSMfd9nQ6cfR8aRCgFymGgLMlar9pz3hI/yiAth0NAoqnjnRst4PoiVxE+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744647288; c=relaxed/simple;
	bh=Vw6pbJgFIn0EYbCiugur0VuQaw7nkbxKJiJtQ4po25U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J67Kqecxdlz2yAqvMzQ1NCS9Q42E5w5HOnlCThiGoiXiTRNOz1moSE5fkQp4dTf4tHIBxk2XG5PfWGTZg4mFpqrEOto9/MtkZAZKH72E00x0grGsISFs5ITr24bbS9cTR2uLNySVY+nXNWIt9GY45TPwoDAvZ5aQSyaEyuej9FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fr/MqTj7; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-3914aba1ce4so3833807f8f.2
        for <bpf@vger.kernel.org>; Mon, 14 Apr 2025 09:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744647285; x=1745252085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wz07nrQEHIIJJFJ0MqmIemfDa9qqqh7t53FViCfyWyM=;
        b=fr/MqTj70vxNMy3dpIdSCSLwC6WWxAogYV+vXHaH0X2dVX4KXl6Q9r+NQvYe9sOmix
         wbYYn0WgicdxRX8HCv3Zjcfg8iBzB/WcT9opZmN3B87NPSsMGCJ0aXNJDhAfrHK7yf0g
         C5AGlPZn6L4ft8LnKqwB06DRa6XHQsFO/hrw/+dzbRiiumo66cVB7kr7oa8epsjGEUeW
         Seytv4ob6yjLdSVGhQmpZbVmskJYZLnWW3giJimJC0FTgkzJNp/UpBwqAB6iEriwMqoK
         G7abk+LSlKFBQcHZlZF5hdWhveJsJgJtbXdNeCsOt5JPghgXkC1lnT3i+VavySIhKawD
         gB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744647285; x=1745252085;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wz07nrQEHIIJJFJ0MqmIemfDa9qqqh7t53FViCfyWyM=;
        b=nWeZI+C8eyeaOpmtBAqmhtcEW6otlvqpvBEHTp7V5RYrBubQM6ETr0EzAwYfr7c8Y8
         mx38k2KdrYXKNVTS6Gmt2z42cIi74BgElY5wAk8BrxFj5ijRTBU3iTxUMSpG3l5IrWmE
         GOSeIZ4DtvLov9R0jRwja0NOC4JiqpgpJ9IHuoT25ToRsLhi0nq2I5ipB7VsxJ+w6mQX
         GXJk6pg7g/HaOmqkB0CW/17IfYQDa8kSph3tGSgLcYfzK0ne2RMKfmYLZFTE0fcndyZm
         67tcM8jqQopk7aZBQz016WzBNDMrC9fcRu/x1p6k0N5KJkQct1Ixrs/dn7Bl5o4uSIa5
         kQJA==
X-Gm-Message-State: AOJu0YwCxdrVndrOuKXhgPiH2Ps7Fkf5QfFMbMPNeGlEqEBJO++ZV8tU
	ZPDJYVfLQrNZOGSpCv+hQUhP1mE2tNrLxwW9BtZy4LRz28I4nKozevZfrprcuiY=
X-Gm-Gg: ASbGncuHdISoH+ksId2Zq8V0ph/l0PDz5GHnTFsUlUpa1ACLG/O6SNYBwmGtOQ2xCva
	UNnHYLeAHQv6eGeVtdUgCKTqLovH6mfgNeNJx7M+tKJ7T3R09eVfNbLe4/hyNqz+DIQfo8jg/KF
	IDH4guwjATq4AQ9M+ZGyT95AsMSxu+SuLmrmVrNN34v7a1HbmObyauUYhzsvSyoeOZ5sOuPjdv7
	bQlvFIm9DU5XY3tDPQ3Avl583PuO0Tu5l3vg+YSSPoLD8gmXTw99qRbvkZGdScjLn3W9c1WlOwf
	qCqWWGSAYuPAJm9E8sLpEu+5A+w=
X-Google-Smtp-Source: AGHT+IHLBSPfoS4QNKWILCQbcX2HTej5wsmINr2ExkDplTr5ysPjE9qHtJy6rJpP9L/WOAbSGPx/Ig==
X-Received: by 2002:a5d:5847:0:b0:391:1218:d5f7 with SMTP id ffacd0b85a97d-39eaaebebd2mr11607912f8f.40.1744647284421;
        Mon, 14 Apr 2025 09:14:44 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae96c661sm11294808f8f.29.2025.04.14.09.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 09:14:43 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Barret Rhoden <brho@google.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next/net v1 00/13] BPF Standard Streams
Date: Mon, 14 Apr 2025 09:14:30 -0700
Message-ID: <20250414161443.1146103-1-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7352; h=from:subject; bh=Vw6pbJgFIn0EYbCiugur0VuQaw7nkbxKJiJtQ4po25U=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBn/TOI1GJjlNLfzeY2yj+e06ANkGKzuU2F4KYH3WdR zXJAUqGJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ/0ziAAKCRBM4MiGSL8RymBXD/ 9JPFLwqcFPfopRb/VTbX36gFRwFHV4IBemVdysA1m9b3ttljVRlsURroVrPCGfJg0CVoycmBPrkNoI 3H1TfxVoKneu03740ybbHXF4skRcWAMyBMycVgWaQ01vUkv6Ni90S7CLOh3YiBy8fHHP1turJ27zSb /bNsP4vZwPk18NYYR2CjUt/wvnMoE9MjyvTS1xnyK+9vEKDVQpp2VNt5fPvX5w/aT5kKSK4CVTUNCk eUDixDx4qSbBE2zDPUGogBYldJxmESgd/GE+7gthngg5UjzmbGoLgD9yNfTjo0naABiYJwiAUsnbkf XP8KADxjlJdV+u0ddmua0tySed0RT275o0pIUxKQCZV6Em5P/fTTGenCaBWN+xk9ipp6pLmxtsifDe R6TiaW9V3HRTbM/2ONQpnV2SI8KbfCxUnOP0oqcB+HEyYd7zCIew1WPtsBE3VoT/4SxG0WPely/WK6 beOgYiD3iM3rS2ZYMYWGjND1F+F472YgnwN4bV4U0u2373kC4bm2ENnRpvOAxVDhZEJzgz1mOGR28g isLqAlMRUrZ2/jqTi9plVY0IQu4WXvgpImyBMSb550Kaq2EinxyNv/HYkS7rXDMQ3n3D5JWCo7X+Eh ZypbdiC0D4auvwGioeeklbDwShj7KZfAztu9NW01bNI79oZQZMY0XW6LiMpg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

NOTE: Temporarily based off of bpf-next/net due to Qdisc related fixes.

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
the stream leads to memory allocation. Allocation itself relies on the
bpf_mem_alloc() API, but in case it fails, we use try_alloc_pages() to
construct a bespoke bump allocator to carve out elements. If this fails,
we finally give up and drop the message.

Three scenarios (rqspinlock deadlocks, arena page faults, and cond_break
timeouts) are covered for reporting errors to user space, the format
looks as follows (with file:line info for BPF programs to pin point
source of error). The output is as follows:

ERROR: AA or ABBA deadlock detected for bpf_res_spin_lock
Attempted lock   = 0xff11000104a875e0
Total held locks = 1
Held lock[ 0] = 0xff11000104a875e0
CPU: 5 UID: 0 PID: 764 Comm: test_progs
Call trace:
 bpf_prog_stderr_dump_stack+0x83/0xc0
 bpf_res_spin_lock+0x8c/0xa0
 bpf_prog_0f369a1fb6eb23d7_foo+0xe5/0x140: [stream_bpftool.c:62]
 bpf_prog_986cfd896eb75e8c_stream_bpftool_dump_prog_stream+0x7e/0x2e1: [stream_bpftool.c:93]
 bpf_prog_test_run_syscall+0x102/0x240
 __sys_bpf+0xd68/0x2bf0
 __x64_sys_bpf+0x1e/0x30
 do_syscall_64+0x68/0x140
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

ERROR: Arena READ access at unmapped address 0xdeadbeef
CPU: 5 UID: 0 PID: 764 Comm: test_progs
Call trace:
 bpf_prog_stderr_dump_stack+0x83/0xc0
 ex_handler_bpf+0x4a/0xa0
 fixup_exception+0xde/0x310
 kernelmode_fixup_or_oops.constprop.0+0x2f/0x70
 exc_page_fault+0xdd/0x1d0
 asm_exc_page_fault+0x26/0x30
 bpf_prog_0f369a1fb6eb23d7_foo+0x10c/0x140: [stream_bpftool.c:67]
 bpf_prog_986cfd896eb75e8c_stream_bpftool_dump_prog_stream+0x7e/0x2e1: [stream_bpftool.c:93]
 bpf_prog_test_run_syscall+0x102/0x240
 __sys_bpf+0xd68/0x2bf0
 __x64_sys_bpf+0x1e/0x30
 do_syscall_64+0x68/0x140
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

ERROR: Arena WRITE access at unmapped address 0xfaceb00c
CPU: 5 UID: 0 PID: 764 Comm: test_progs
Call trace:
 bpf_prog_stderr_dump_stack+0x83/0xc0
 ex_handler_bpf+0x4a/0xa0
 fixup_exception+0xde/0x310
 kernelmode_fixup_or_oops.constprop.0+0x2f/0x70
 exc_page_fault+0xdd/0x1d0
 asm_exc_page_fault+0x26/0x30
 bpf_prog_0f369a1fb6eb23d7_foo+0x111/0x140: [stream_bpftool.c:67]
 bpf_prog_986cfd896eb75e8c_stream_bpftool_dump_prog_stream+0x7e/0x2e1: [stream_bpftool.c:93]
 bpf_prog_test_run_syscall+0x102/0x240
 __sys_bpf+0xd68/0x2bf0
 __x64_sys_bpf+0x1e/0x30
 do_syscall_64+0x68/0x140
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

ERROR: Timeout detected for may_goto instruction
CPU: 5 UID: 0 PID: 764 Comm: test_progs
Call trace:
 bpf_prog_stderr_dump_stack+0x83/0xc0
 bpf_check_timed_may_goto+0x4d/0xa0
 arch_bpf_timed_may_goto+0x21/0x40
 bpf_prog_0f369a1fb6eb23d7_foo+0x12f/0x140: [stream_bpftool.c:70]
 bpf_prog_986cfd896eb75e8c_stream_bpftool_dump_prog_stream+0x7e/0x2e1: [stream_bpftool.c:93]
 bpf_prog_test_run_syscall+0x102/0x240
 __sys_bpf+0xd68/0x2bf0
 __x64_sys_bpf+0x1e/0x30
 do_syscall_64+0x68/0x140
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

There is a lot of minor things to address before this is mergeable, but
the main logic and approach should be set in stone.

TODO (in order of importance)
-----------------------------
 * Add an API for kernel writers to stderr streams to allow them to
   stage messages to a llist_head and then atomically splice in a bunch
   of messages into the stream to avoid interleaving from multiple
   threads. Each "message" consisisting of multiple printk statements
   then appears as a contiguous sequence to the user space.
   This will simply be a stage + commit API on top of an object pinning
   the llist_head that will be del_all'd and then add_batch'd to the
   stream->log.
 * Add bpf_printk() macros for streams.
 * Add kdoc comments for kfuncs.
 * Add more corner case tests, and negative cases.
 * Enforcing memory consumption limits on the log usage, so that
   in-flight log memory is bounded at runtime.
 * Support bpftool filepath printing and JSON output.

Alexei Starovoitov (1):
  locking/local_lock, mm: Replace localtry_ helpers with local_trylock_t
    type

Kumar Kartikeya Dwivedi (12):
  bpf: Tie dynptrs to referenced source objects
  bpf: Compare dynptr_id in regsafe
  selftests/bpf: Convert dynptr_fail to use vmlinux.h
  selftests/bpf: Add tests for dynptr source object interaction
  bpf: Introduce bpf_dynptr_from_mem_slice
  bpf: Introduce per-prog stdout/stderr streams
  bpf: Add dump_stack() analogue to print to BPF stderr
  bpf: Report may_goto timeout to BPF stderr
  bpf: Report rqspinlock deadlocks/timeout to BPF stderr
  bpf: Report arena faults to BPF stderr
  bpftool: Add support for dumping streams
  selftests/bpf: Add tests for prog streams

 arch/x86/net/bpf_jit_comp.c                   |  21 +-
 include/linux/bpf.h                           |  63 +-
 include/linux/local_lock.h                    |  58 +-
 include/linux/local_lock_internal.h           | 207 +++---
 kernel/bpf/Makefile                           |   2 +-
 kernel/bpf/arena.c                            |  14 +
 kernel/bpf/core.c                             |  29 +-
 kernel/bpf/helpers.c                          |  58 +-
 kernel/bpf/rqspinlock.c                       |  22 +
 kernel/bpf/stream.c                           | 595 ++++++++++++++++++
 kernel/bpf/syscall.c                          |   2 +-
 kernel/bpf/verifier.c                         | 104 ++-
 mm/memcontrol.c                               |  39 +-
 tools/bpf/bpftool/Makefile                    |   2 +-
 tools/bpf/bpftool/prog.c                      |  71 ++-
 tools/bpf/bpftool/skeleton/stream.bpf.c       |  96 +++
 .../testing/selftests/bpf/prog_tests/dynptr.c |   2 +
 .../testing/selftests/bpf/prog_tests/stream.c |  57 ++
 .../testing/selftests/bpf/progs/dynptr_fail.c |  43 +-
 .../selftests/bpf/progs/dynptr_fail_qdisc.c   |  38 ++
 tools/testing/selftests/bpf/progs/stream.c    | 150 +++++
 .../selftests/bpf/progs/stream_bpftool.c      | 142 +++++
 .../testing/selftests/bpf/progs/stream_fail.c |  38 ++
 23 files changed, 1597 insertions(+), 256 deletions(-)
 create mode 100644 kernel/bpf/stream.c
 create mode 100644 tools/bpf/bpftool/skeleton/stream.bpf.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/stream.c
 create mode 100644 tools/testing/selftests/bpf/progs/dynptr_fail_qdisc.c
 create mode 100644 tools/testing/selftests/bpf/progs/stream.c
 create mode 100644 tools/testing/selftests/bpf/progs/stream_bpftool.c
 create mode 100644 tools/testing/selftests/bpf/progs/stream_fail.c


base-commit: 93cb5375fb16693273144e7627e4fe27b811003a
-- 
2.47.1


