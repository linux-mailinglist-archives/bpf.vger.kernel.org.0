Return-Path: <bpf+bounces-64929-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 927E2B18873
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 23:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BA883AC429
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 21:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A371728751A;
	Fri,  1 Aug 2025 21:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jslcEZqK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227FF4207F;
	Fri,  1 Aug 2025 21:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754082172; cv=none; b=eSQ/GNgyukxdvGTiLNq0+aD1lv9Ah63F1x3UduUfakjW6caC8ULm5XDReJS0YaXnIWSbAlL0Get7ZQcM7j1vCPxgxBc8hcEVYNpd35UoB3ySXELWinQR7V133aGep1xckS9YU7vGqEn/6OWROFEOiqDVx/opNuWRJSDMFvLdr94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754082172; c=relaxed/simple;
	bh=ayyylkq7rdFa1jgiPcSRwE0mQe0Oe76IsLxcC+7LEV4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d6IhA+GajN7GeczR3k37nmLBDtNr3EbwryvmfyzV7V+UlxS7/TpyvALcWmqiKSCRObQEY5Kr3Bd+bkSKGlCb6wdmwkD6g3VzNWsnU1U3VpVAWXVLl/p++qL088XE8qNQoEYmQSCGSsuiCeQsMPvmEz1Gjj43F3UFNQX5caV2rZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jslcEZqK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41DE0C4CEE7;
	Fri,  1 Aug 2025 21:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754082171;
	bh=ayyylkq7rdFa1jgiPcSRwE0mQe0Oe76IsLxcC+7LEV4=;
	h=From:To:Cc:Subject:Date:From;
	b=jslcEZqK0veZp0ElsZzOSM4XH3KJQmF8lr62kDqMAcqerFGKm1CanZx/xyvZO7LDa
	 EHCsR+FTmdF4pcVljdatfliyGRlPCrwsa5/rtGtnsrAxpCV6kd2+u8op4rARLazy8W
	 ykKV/4nCx3Zbw4yPQsfMBlzYAA3Ggk+b7nXBaB6wGixVmC0tuZ7Sf+vFvSOj8a+3Pa
	 lXFME12DFEzann0rT67aPQ+ukAL4t0znL/G53xY8AjGcAAWe9E6923LygG9sXWzlq7
	 9SUSJpZr83xfkANBYPtmvBkZsNSh0gY/gwgkn6QxLJTDVkdbJX0U6lk4pbQlRSiwBF
	 jRoj+hpZLyl0w==
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
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: [RFC 0/4] uprobe,bpf: Allow to change app registers from uprobe
Date: Fri,  1 Aug 2025 23:02:34 +0200
Message-ID: <20250801210238.2207429-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi,
we recently had several requests for tetragon to be able to change
user application function return value or divert its execution through
instruction pointer change.

This *RFC* patchset adds support for uprobe program to change app's
registers including instruction pointer.

There's a hiccup with instruction pointer change.. if uprobe handler
changes instruction pointer, the current code will still execute the
original instruction and increment the (new) ip with its length.

This makes the new instruction pointer bogus and application will
likely crash on illegal instruction execution.

I think if user decides to take execution elsewhere, we can skip
original instruction execution (patch#1), but I might be easily
wrong and overlooking something.. hence RFC ;-)

thoughts? thanks,
jirka


---
Jiri Olsa (4):
      uprobe: Do not emulate/sstep original instruction when ip is changed
      bpf: Allow uprobe program to change context registers
      selftests/bpf: Add uprobe context registers changes test
      selftests/bpf: Add uprobe context ip register change test

 include/linux/bpf.h                             |   1 +
 kernel/events/core.c                            |   4 +++
 kernel/events/uprobes.c                         |   3 ++
 kernel/trace/bpf_trace.c                        |   3 +-
 tools/testing/selftests/bpf/prog_tests/uprobe.c | 162 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 tools/testing/selftests/bpf/progs/test_uprobe.c |  38 ++++++++++++++++++++++++
 6 files changed, 208 insertions(+), 3 deletions(-)

