Return-Path: <bpf+bounces-72319-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B07C0DEF0
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 14:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8F2E1889A6C
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 13:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5173825CC63;
	Mon, 27 Oct 2025 13:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uqnGFa9j"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA10C2E413;
	Mon, 27 Oct 2025 13:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761570850; cv=none; b=g12bJlcH2luy9iarTZKbYpnzmKtaJngeLO6GRAADZuqWCRnRKgugQsJ58MiVbh+cp4aUn0nn2mM1leboPaWBG1r4yJmwwzdZObGmzYBIfHQzb54iBUBZSbcrfrPI22u+iMw5HnlOCgUruDrpny0NIFNisYGXiVVfBJ0hpx0rdQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761570850; c=relaxed/simple;
	bh=Z3cyUG2ymJAyzIQOv6HDBeTXMiclsGEwYplTVZ3LTcE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xi+eNw/Ob8UxqgjggRsnfYEbPxRer5k4EIqFKaqEvaRoNy8I+VKZ8JoYlT0lfTYdL3i/kTLmGVrBQ+n61Urvp9KI7YErsA9LMSiiwFclmNmMOgeuSSuXQ1ok69sAfFZP1Znx+FnSUFpSw4OqDMFp15bEnEbtfiTEW/hMuWvenkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uqnGFa9j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D068AC4CEF1;
	Mon, 27 Oct 2025 13:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761570846;
	bh=Z3cyUG2ymJAyzIQOv6HDBeTXMiclsGEwYplTVZ3LTcE=;
	h=From:To:Cc:Subject:Date:From;
	b=uqnGFa9j8QwyCCC5cudkQM93nrLyRyl6bNIsP074dRrO2Wut/ykj1d+0Bko/KCNLf
	 rnPVv+6kwRvU+MendXF9enmdS1orVjuPvFQ6o+qrRg8tUX6dlj+uEMc8lPZYmpNoYL
	 Aevzr+4/WARosHDEM1yNNvA2dZNPVwYpoGo8xmknWin4+LSI4pVepF8jZZP2p8JOr2
	 QSEUdNHAMG/W79DR+boWomvDoneXqpW2X04eb8t/IxHYUxW26V7nMGNwe8TbIR+i9S
	 tf6OCwdFhTbqJ3dqxPpIrs7wmt82rSYwXpMZjBnYZv8Gjb0P3H96bE3GJ7Mn3lb6fy
	 o7UY+iUM4mQOQ==
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
Subject: [PATCH 0/3] x86/fgraph,bpf: Fix ORC stack unwind from return probe
Date: Mon, 27 Oct 2025 14:13:51 +0100
Message-ID: <20251027131354.1984006-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.0
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
  probes/core

thanks,
jirka


[1] https://lore.kernel.org/bpf/aObSyt3qOnS_BMcy@krava/
---
Jiri Olsa (3):
      Revert "perf/x86: Always store regs->ip in perf_callchain_kernel()"
      x86/fgraph,bpf: Fix stack ORC unwind from kprobe_multi return probe
      selftests/bpf: Add stacktrace ips test for kprobe_multi/kretprobe_multi

 arch/x86/events/core.c                                  |  10 ++++-----
 arch/x86/include/asm/ftrace.h                           |   5 +++++
 arch/x86/kernel/ftrace_64.S                             |   8 ++++++-
 include/linux/ftrace.h                                  |  10 ++++++++-
 tools/testing/selftests/bpf/prog_tests/stacktrace_ips.c | 108 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/stacktrace_ips.c      |  51 +++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/test_kmods/bpf_testmod.c    |  26 +++++++++++++++++++++++
 7 files changed, 211 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/stacktrace_ips.c
 create mode 100644 tools/testing/selftests/bpf/progs/stacktrace_ips.c

