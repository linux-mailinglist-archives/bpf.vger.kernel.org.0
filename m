Return-Path: <bpf+bounces-73386-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B7FC2E37C
	for <lists+bpf@lfdr.de>; Mon, 03 Nov 2025 23:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FCD13B0DC9
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 22:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDA72D593D;
	Mon,  3 Nov 2025 22:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1KiEJAK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C7935979;
	Mon,  3 Nov 2025 22:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762207774; cv=none; b=N414xR4JehTaOujxUhshozUBQOF23DpPHsv0UbKcJa6O3RJ27dhGo39+b6CQarWG+L39f2qyNRoI5/FhcINIM6UA6tgKX/5jy4xxY89fJEguRDdLPTZhZ1mS1uoY5s/YlKIsgYm4bK8qKzHVJApHeZ/0xZ0+aZnZAyD1PgPX77Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762207774; c=relaxed/simple;
	bh=cToBP15321gy7MkEptb4GyQF51qomz/Aqlu5YiC0HIw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X478QIvAnjJq7nxAg9qxeQqu/p7EjfJDm7sZaGvvkujfzF9pQs0dlmgP8+4NgkTVLUir2lQgmfzceS0+AUIpRlLyFAsIdmwUQ1tNDcbWDGPySvnGSaMtb5u9Q4ujBxd6pSCCPWCUeJzP89hLLD8IJ82I9ioxcsbuZG6ai5SNu8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1KiEJAK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F23B4C116B1;
	Mon,  3 Nov 2025 22:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762207774;
	bh=cToBP15321gy7MkEptb4GyQF51qomz/Aqlu5YiC0HIw=;
	h=From:To:Cc:Subject:Date:From;
	b=U1KiEJAKlnH4WUnbeWMmukTX8SFMad8yf1mPSaUSE94p/hPIiJvH5YXIj9D1uow6/
	 +FI7vCkQCzgBtvxRGHQSGdli1vMt3hpVLAJEkb3XXSE6CWOCmxYnTMd77eztEsOZMe
	 YBwdCB2lXDz3UN4GGr8qmeTq+r6EqxToQ+5lErhGVQYf+0jrJfOLgH1uw/Ts6F3h5a
	 JyEOS4DZB/Uass1VgkpZmwc30ih2O6rfcaXhXBCvpz+RGRHsPmRJEmVCwZulWO2QBR
	 xL6FbUNAonljuL64q/MTvCV+jo6jxjqCRG/er4GaeMrJGmarbwj7/Yx5Bhl4u5LiLm
	 /DITgd9ERIkmA==
From: Jiri Olsa <jolsa@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org,
	Yonghong Song <yhs@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCHv2 0/4] x86/fgraph,bpf: Fix ORC stack unwind from return probe
Date: Mon,  3 Nov 2025 23:09:20 +0100
Message-ID: <20251103220924.36371-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi,
sending fix for ORC stack unwind issue reported in here [1], where
the ORC unwinder won't go pass the return_to_handler function and
we get no stacktrace.

Sending fix for that together with unrelated stacktrace fix (patch 1),
so the attached test can work properly.

It's based on:
  https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
  probes/for-next

v1: https://lore.kernel.org/bpf/20251027131354.1984006-1-jolsa@kernel.org/

v2 changes:
- added ack for patch 2 [Masami]
- added test for raw tp unwind

thanks,
jirka


[1] https://lore.kernel.org/bpf/aObSyt3qOnS_BMcy@krava/
---
Jiri Olsa (4):
      Revert "perf/x86: Always store regs->ip in perf_callchain_kernel()"
      x86/fgraph,bpf: Fix stack ORC unwind from kprobe_multi return probe
      selftests/bpf: Add stacktrace ips test for kprobe_multi/kretprobe_multi
      selftests/bpf: Add stacktrace ips test for raw_tp

 arch/x86/events/core.c                                  |  10 +++----
 arch/x86/include/asm/ftrace.h                           |   5 ++++
 arch/x86/kernel/ftrace_64.S                             |   8 +++++-
 include/linux/ftrace.h                                  |  10 ++++++-
 tools/testing/selftests/bpf/prog_tests/stacktrace_ips.c | 150 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/stacktrace_ips.c      |  49 +++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/test_kmods/bpf_testmod.c    |  26 +++++++++++++++++
 7 files changed, 251 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/stacktrace_ips.c
 create mode 100644 tools/testing/selftests/bpf/progs/stacktrace_ips.c

