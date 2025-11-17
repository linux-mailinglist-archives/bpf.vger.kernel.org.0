Return-Path: <bpf+bounces-74720-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBD0C6432C
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 13:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A9F5C380D1D
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 12:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B60930ACEB;
	Mon, 17 Nov 2025 12:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rAghInXj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB94261581;
	Mon, 17 Nov 2025 12:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763383272; cv=none; b=RoegLqzluFpsz0f8WjJx7A34ngZ5afBasB62sh7za+TYoXp0ug+uufA/YJmiZ+S1vDeZb/zNo/CKe3ud2nwF6U4vwVabwScbhD+qayppFYprFl+TIQeLjN1dQ6cGqlGaYeXMtdpOco+COGFR8qx01E98NfVxADcu8qPazoeZ8NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763383272; c=relaxed/simple;
	bh=G7B7sXK5/nOS2b5UNuDw2icE+zrBHBKJ58WQB9V1/mQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QvIWvA54YzqmnwBd2SmCl23W7kvWA07TPM2muOrxG8qfJPE6s4nZfWVzIqfLbKTa1SL13ONFzUu+uiiV0mR66PRDZ6+gdpXei00CaDrF+E6ih9nY/QzyVv1wvpvhYrVRJ2/Buzqqmg2gvgD1V+cyQB358Lb42HE4hDGKLXui88c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rAghInXj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC422C4CEFB;
	Mon, 17 Nov 2025 12:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763383271;
	bh=G7B7sXK5/nOS2b5UNuDw2icE+zrBHBKJ58WQB9V1/mQ=;
	h=From:To:Cc:Subject:Date:From;
	b=rAghInXjn7I8DCuJ3H0tXfnbMCY1CxOX5FR702A8+PY4TVNSf0DzYokr+9MOIJnPL
	 CjdB9LUlMqkCEbzzswFMrNuDEknP2E5kE4+j57AHPM29w20WlQprFMOpapVG4REXhZ
	 +xsWtso8r3WOTBWw27zBN0czI2uzDZ0IPFzfY4I/c+Xkr9YPibSt3sjOvEtwll+qNp
	 q22cRgE4RM25kmiMRF3TZPHJ9Kzi3u7fz73tN10/QN2wZFFTRa2Ma9D93CS2lxkTqD
	 fsxkwFavdneXGMrdW/TUHr0PIXKOkg/XIHaURzcuO7x80wm5tiT+9p213R40/6x3YP
	 vaIddgcZgjUdg==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	David Laight <David.Laight@ACULAB.COM>
Subject: [RFC PATCH 0/8] uprobe/x86: Add support to optimize prologue
Date: Mon, 17 Nov 2025 13:40:49 +0100
Message-ID: <20251117124057.687384-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi,
the subject is bit too optimistic, in nutshell the idea is to allow
optimization on top of emulated instructions and then add support to
emulate more instructions with high presence in function prologues.

This patchset adds support to optimize uprobe on top of instruction
that could be emulated and also adds support to emulate particular
versions of mov and sub instructions to cover some of the user space
functions prologues, like:

  pushq %rbp
  movq  %rsp,%rbp
  subq  $0xb0,%rsp

The idea is to store instructions on underlying 5 bytes and emulate
them during the int3 and uprobe syscall execution:

  - install 'call trampoline' through standard int3 update
  - if int3 is hit before we finish optimizing we emulate
    all underlying instructions
  - when call is installed the uprobe syscall will emulate
    all underlying instructions

There's an additional issue that single instruction replacement does
not have and it's the possibility of the user space code to jump in the
middle of those 5 bytes. I think it's unlikely to happen at the function
prologue, but uprobe could be placed anywhere. I'm not sure how to
mitigate this other than having some enable/disable switch or config
option, which is unfortunate.

The patchset is based on bpf-next/master with [1] changes merged in.

thanks,
jirka


[1] https://lore.kernel.org/lkml/20251117093137.572132-1-jolsa@kernel.org/T/#m95a3208943ec24c5eee17ad6113002fdc6776cf8
---
Jiri Olsa (8):
      uprobe/x86: Introduce struct arch_uprobe_xol object
      uprobe/x86: Use struct arch_uprobe_xol in emulate callback
      uprobe/x86: Add support to emulate mov reg,reg instructions
      uprobe/x86: Add support to emulate sub imm,reg instructions
      uprobe/x86: Add support to optimize on top of emulated instructions
      selftests/bpf: Add test for mov and sub emulation
      selftests/bpf: Add test for uprobe prologue optimization
      selftests/bpf: Add race test for uprobe proglog optimization

 arch/x86/include/asm/uprobes.h                          |  35 +++++++---
 arch/x86/kernel/uprobes.c                               | 336 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------
 include/linux/uprobes.h                                 |   1 +
 kernel/events/uprobes.c                                 |   6 ++
 tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c | 129 ++++++++++++++++++++++++++++++++-----
 5 files changed, 434 insertions(+), 73 deletions(-)

