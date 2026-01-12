Return-Path: <bpf+bounces-78623-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C67FD157B4
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 22:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3648F3014D8B
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 21:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7CD342512;
	Mon, 12 Jan 2026 21:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/HpJcvk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25821C84D7;
	Mon, 12 Jan 2026 21:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768254594; cv=none; b=PQ3IY/p99Ca69iifHu50xi4i89MNGrfViDJvx+YrtmrnTUxWxim7vCu+FxZ36M/tPm0Vhk2UhK+cprS+zOQwn1NFYpmXxAzYAi4LvpW1BC9VhrVG/WaPEx6zbD6Gyaqnnl6+DaeM+7oM1DTgywsdQcgfWXnKKDSSFQdg0jVTOAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768254594; c=relaxed/simple;
	bh=wK3oWlfmzgUkIOKIOk13WvnRaq5ft+fmJNEEYdzsOsg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JqeSsYYnfx15uvUMfQGRGchep8JFwtKtFTeaG+llSyO0ZW0qawsawDwCOJJNwcFjYvBwO8uXPSZimmmkEjrTvVYjJMP7+CKpJ2TmNNkwUseaH7yXANHxviIiheZizODelqkjVu02YUl/39LYGtWKONyxHlwVMDj2iurRNPwtW3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/HpJcvk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC8B4C116D0;
	Mon, 12 Jan 2026 21:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768254593;
	bh=wK3oWlfmzgUkIOKIOk13WvnRaq5ft+fmJNEEYdzsOsg=;
	h=From:To:Cc:Subject:Date:From;
	b=J/HpJcvka69GsY4IcDvzjhEUbo9ctVp9Fk6Er2EItjfPgtkQXxDc0lBIBdbCbiGkI
	 RaGv8p7tdCyllpmS55JBHKyWAs07Q9l+hwpZ+xExZx4orT73xn2ajfymiKMrja4btS
	 c/8zrhrxbCxVDclTn5buG75gTPTzJ6aHTqz4b44HCqN8fMdAWcxwXY65CQAuGpzRSe
	 FSnnM8XOve+LFf6NyDKTVjwM6oFTZP5S4i7EGJfvXOMTrPTRkAjRETCy3oFOfQxEQ1
	 G3df/Ced9b2VhYmjU1ctZ3zie8O9YtpTQoVS+Vux444UWtHAjH+zzgQwP6qrZml1GL
	 enqWTeA3uvhYQ==
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
	Andrii Nakryiko <andrii@kernel.org>,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next 0/4] x86/fgraph,bpf: Fix ORC stack unwind from kprobe_multi
Date: Mon, 12 Jan 2026 22:49:36 +0100
Message-ID: <20260112214940.1222115-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi,
Mahe reported missing function from stack trace on top of kprobe multi
program. It turned out the latest fix [1] needs some more fixing.

thanks,
jirka


[1] https://lore.kernel.org/bpf/20251104215405.168643-1-jolsa@kernel.org/
---
Jiri Olsa (4):
      x86/fgraph: Fix return_to_handler regs.rsp value
      x86/fgraph,bpf: Switch kprobe_multi program stack unwind to hw_regs path
      selftests/bpf: Fix kprobe multi stacktrace_ips test
      selftests/bpf: Allow to benchmark trigger with stacktrace

 arch/x86/include/asm/ftrace.h                           |  2 +-
 arch/x86/kernel/ftrace_64.S                             |  4 +++-
 kernel/trace/fgraph.c                                   |  2 +-
 tools/testing/selftests/bpf/bench.c                     |  4 ++++
 tools/testing/selftests/bpf/bench.h                     |  1 +
 tools/testing/selftests/bpf/benchs/bench_trigger.c      |  1 +
 tools/testing/selftests/bpf/prog_tests/stacktrace_ips.c |  3 ++-
 tools/testing/selftests/bpf/progs/trigger_bench.c       | 18 ++++++++++++++++++
 8 files changed, 31 insertions(+), 4 deletions(-)

