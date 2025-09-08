Return-Path: <bpf+bounces-67734-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2283DB496C2
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 19:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A2E1172278
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 17:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B602312839;
	Mon,  8 Sep 2025 17:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvtXDYDX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99C1C8E6;
	Mon,  8 Sep 2025 17:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757351678; cv=none; b=IHzr6ahxb4oss/2OZ+vgy+ndyH8iGkeyPSTYPZ0TiqdmYOLcIC4EeqL/oawlzFCBl4vc1yQhoSdUkbdwKJNV3QObQGXCN2pY1zY1du3/1ClYbauCO4+XhgM1tfm9D+ZDBgnQatRpUUfaNDVN+1Wc4V4U8dzvrILblmnPpwwKP2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757351678; c=relaxed/simple;
	bh=wvkeqx65sSJKzWss4FZcpi/7dcO4VYCJZ9nOeFspncA=;
	h=Message-ID:Date:From:To:Cc:Subject; b=nWRaKU1PqLd5HV0jRPlJZ0Khyhw889rSySc0w30lm0UGz9mezDVUBbozhdxSrgnxh1vyvpp0Ura38W9DB6uvBm8BBMf+yEk3ILmwaDkkOno2e9Pr9Y8h5hL775NgeSH5Bf0ljq/Oc5Nd+qT77oVsCY02kjHgiKvvhppiNMsafnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvtXDYDX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87A7CC4CEF5;
	Mon,  8 Sep 2025 17:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757351678;
	bh=wvkeqx65sSJKzWss4FZcpi/7dcO4VYCJZ9nOeFspncA=;
	h=Date:From:To:Cc:Subject:From;
	b=PvtXDYDXWtbIhjJHmrM2dDvPz3abub8XQ02C9APjhAn8iTHcjtY8NAszuuPcb3CEN
	 RgQvfJ1mdZSh0XBMHYoBOqg1d7HoxZtdrPF3icvX9rjTLfpZkPDQJRkaMcU4nVQMv5
	 55Z0Y3vz7+ZfsXw3LsKdz7g2IdmPLBtlPm4SIxnhqn1phzFsUHeKQ4wgsGfNlfWNhm
	 Yv70ddvVPLwZoShyih7sYPEiTw4B08dvFYcDn3TgcCKrcfVLOV+hZ25KubnI2Wl2zc
	 jZEkFuWLNuspvSa9paXtAXNsCqz7hnzwaEBRR//vsurT54FUPbd8VaAktMg9omlKaL
	 UrKPyImLqLAnw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uvfSe-000000075Ny-1hzo;
	Mon, 08 Sep 2025 13:15:24 -0400
Message-ID: <20250908171412.268168931@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 08 Sep 2025 13:14:12 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org,
 x86@kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>,
 Indu Bhagat <indu.bhagat@oracle.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 Jens Remus <jremus@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Florian Weimer <fweimer@redhat.com>,
 Sam James <sam@gentoo.org>,
 Kees Cook <kees@kernel.org>,
 "Carlos O'Donell" <codonell@redhat.com>
Subject: [RESEND][PATCH v15 0/4] perf: Support the deferred unwinding infrastructure
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>


[
  This is simply a resend of version 15 of this patch series
  but with only the kernel changes. I'm separating out the user space
  changes to their own series.
  The original v15 is here:
    https://lore.kernel.org/linux-trace-kernel/20250825180638.877627656@kernel.org/
]

This patch set is based off of perf/core of the tip tree:
  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git

To run this series, you can checkout this repo that has this series as well as the above:

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git  unwind/perf-test

This series implements the perf interface to use deferred user space stack
tracing.

Patch 1 adds a new API interface to the user unwinder logic to allow perf to
get the current context cookie for it's task event tracing. Perf's task event
tracing maps a single task per perf event buffer and it follows the task
around, so it only needs to implement its own task_work to do the deferred
stack trace. Because it can still suffer not knowing which user stack trace
belongs to which kernel stack due to dropped events, having the cookie to
create a unique identifier for each user space stack trace to know which
kernel stack to append it to is useful.

Patch 2 adds the per task deferred stack traces to perf. It adds a new event
type called PERF_RECORD_CALLCHAIN_DEFERRED that is recorded when a task is
about to go back to user space and happens in a location that pages may be
faulted in. It also adds a new callchain context called PERF_CONTEXT_USER_DEFERRED
that is used as a place holder in a kernel callchain to append the deferred
user space stack trace to.

Patch 3 adds the user stack trace context cookie in the kernel callchain right
after the PERF_CONTEXT_USER_DEFERRED context so that the user space side can
map the request to the deferred user space stack trace.

Patch 4 adds support for the per CPU perf events that will allow the kernel to
associate each of the per CPU perf event buffers to a single application. This
is needed so that when a request for a deferred stack trace happens on a task
that then migrates to another CPU, it will know which CPU buffer to use to
record the stack trace on. It is possible to have more than one perf user tool
running and a request made by one perf tool should have the deferred trace go
to the same perf tool's perf CPU event buffer. A global list of all the
descriptors representing each perf tool that is using deferred stack tracing
is created to manage this.


Josh Poimboeuf (1):
      perf: Support deferred user callchains

Steven Rostedt (3):
      unwind deferred: Add unwind_user_get_cookie() API
      perf: Have the deferred request record the user context cookie
      perf: Support deferred user callchains for per CPU events

----
 include/linux/perf_event.h            |  11 +-
 include/linux/unwind_deferred.h       |   5 +
 include/uapi/linux/perf_event.h       |  25 +-
 kernel/bpf/stackmap.c                 |   4 +-
 kernel/events/callchain.c             |  14 +-
 kernel/events/core.c                  | 421 +++++++++++++++++++++++++++++++++-
 kernel/unwind/deferred.c              |  21 ++
 tools/include/uapi/linux/perf_event.h |  25 +-
 8 files changed, 518 insertions(+), 8 deletions(-)

