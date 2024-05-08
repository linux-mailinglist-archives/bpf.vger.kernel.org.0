Return-Path: <bpf+bounces-29124-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3828C0641
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 23:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF5912814B8
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 21:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE5E131E43;
	Wed,  8 May 2024 21:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iBbBi7iC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E995131BA5;
	Wed,  8 May 2024 21:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715203571; cv=none; b=dhGIomptxp2MkyeKKYqCIGqY9DKFfZaz0aY2a8+5Cw9otM5WitTfhhE8kg6Z+GITndBW+eyNAbnTI0x58jsBYEwE0vuwXLfntgXec8xUXcPGD1QvXWm9yfYH4VnlthhY8Y58+Q4ChUUcXInjn6S7TBx7KnXRS3sqyVh23Aih/Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715203571; c=relaxed/simple;
	bh=jC4/tDWF+DXydkKwS4U4tonr/b7NgqdXz976VdA1gQw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QhdrP1UxYjCcnJ43uSwQMahyVEHyD3HDg9mwmitR4KKsbMNbplrciNwtkjwLU7ns4iYtMVhNioXEKwSvo0OKIJGuTtnu2kApmvO2XLLGAF4KgZkriA7ye/UUc6AAefNjAcUgYhS2SrMBTWrc0mgn7bZfsSN8WIp3elwIUyzS48w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iBbBi7iC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2B91C2BD11;
	Wed,  8 May 2024 21:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715203571;
	bh=jC4/tDWF+DXydkKwS4U4tonr/b7NgqdXz976VdA1gQw=;
	h=From:To:Cc:Subject:Date:From;
	b=iBbBi7iCSjvumvPAFRmnIVnArDqj5xI5HxXKvnq91/VeCUZmyxxu13nioLy1MeiVq
	 VRA4Bt9in7wFbXkhg74E9eLYnvp8Y92DLvAauwdEkt7LZmOlF8GGVOOk/EW5F4C8aQ
	 f8hwuzzSX9g6Rou3v+u+SikOvoJu3MrlgXBWgkUOWbWs6bA661Qadwa/wJtQF9HG6/
	 Up3T3h76j2Q8+XCCw0xuFLvY5/g62fTP16g8C7qRAXfcbxjiBlnD1cM4zEDWnq5yJo
	 3Bq/w76pxM62dnxTVHCVs9X12kaol8M+CfiMGbPZ5K/GhrSV3kgayqe83bidMew8Mn
	 MAnir3cFQugzA==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: x86@kernel.org,
	peterz@infradead.org,
	mingo@redhat.com,
	tglx@linutronix.de,
	bpf@vger.kernel.org,
	rihams@fb.com,
	linux-perf-users@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH 0/4] Fix user stack traces captured from uprobes
Date: Wed,  8 May 2024 14:26:01 -0700
Message-ID: <20240508212605.4012172-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set reports two issues with captured stack traces.

First issue, fixed in patch #2, deals with fixing up uretprobe trampoline
addresses in captured stack trace. This issue happens when there are pending
return probes, for which kernel hijacks some of the return addresses on user
stacks. The code is matching those special uretprobe trampoline addresses with
the list of pending return probe instances and replaces them with actual
return addresses.

Second issue, which patch #3 is trying to fix with the help of heuristic, is
having to do with capturing user stack traces in entry uprobes. At the very
entrance to user function, frame pointer in rbp register is not yet setup, so
actual caller return address is still pointed to by rsp. Patch is using
a simple heuristic, looking for `push %rbp` instruction, to fetch this extra
direct caller return address, before proceeding to unwind the stack using rbp.

Consider this patch #3 an RFC, if there are better suggestions how this can be
solved, I'd be happy to hear that.

Patch #4 adds tests into BPF selftests, that validate that captured stack
traces at various points is what we expect to get. This patch, while being BPF
selftests, is isolated from any other BPF selftests changes and can go in
through non-BPF tree without the risk of merge conflicts.

Patches are based on latest linux-trace's probes/for-next branch.

Andrii Nakryiko (4):
  uprobes: rename get_trampoline_vaddr() and make it global
  perf,uprobes: fix user stack traces in the presence of pending
    uretprobes
  perf,x86: avoid missing caller address in stack traces captured in
    uprobe
  selftests/bpf: add test validating uprobe/uretprobe stack traces

 arch/x86/events/core.c                        |  20 ++
 include/linux/uprobes.h                       |   3 +
 kernel/events/callchain.c                     |  42 +++-
 kernel/events/uprobes.c                       |  17 +-
 .../bpf/prog_tests/uretprobe_stack.c          | 185 ++++++++++++++++++
 .../selftests/bpf/progs/uretprobe_stack.c     |  96 +++++++++
 6 files changed, 359 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/uretprobe_stack.c
 create mode 100644 tools/testing/selftests/bpf/progs/uretprobe_stack.c

-- 
2.43.0


