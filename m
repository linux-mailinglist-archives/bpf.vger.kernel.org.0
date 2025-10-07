Return-Path: <bpf+bounces-70539-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC72BC2C40
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 23:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F4783E1DF4
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 21:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F75C255F57;
	Tue,  7 Oct 2025 21:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1skvaZE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F18824466B;
	Tue,  7 Oct 2025 21:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759873171; cv=none; b=JxdjzpFgGHeSDorTSUVlgsSuUxBpfA1odp4U97c/bK3d28LGkEbOk88CMVXtIjL6eaHUITHxQ/g3lXZjsGJeA4WyL7O7iF6MBE5vIUhlSkJhQUnNIjDkAG8E+lKuKUfxfQWkoOaReguwkSX3pLm9qTlmIs6NXseiIoUQa9SBoSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759873171; c=relaxed/simple;
	bh=jM8FzE1jnKYaUEic1kVMyhuwPx8EOkgaxfUa1l5WN2g=;
	h=Message-ID:Date:From:To:Cc:Subject; b=dguh9YgpzyxtCeiTOwVZ6t8ZtIVnR24381zEP9dQASr3cC8Be4NtKsikPZW0a2ti/iVJRFc2w5NSxwcSXFNtWxIMr2g6N9jCC/skCs3XtqMZIDaIK1kjeMN+dJuojPHf+42RFf1D95O6JWVUNPDqtTD68zJEHJQ2fyo3nBX+PZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1skvaZE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4675EC4CEF1;
	Tue,  7 Oct 2025 21:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759873171;
	bh=jM8FzE1jnKYaUEic1kVMyhuwPx8EOkgaxfUa1l5WN2g=;
	h=Date:From:To:Cc:Subject:From;
	b=S1skvaZENJclSiZ+3H926/Wr6f0Sf+gdrtH9b8yvaevazCajzvrJ7PzQm/rOn9+gh
	 nYLqSvlMMkPtM3ugXJdrJTSdB2VDopYhlq0GAuLStl7LrHcjvhPh7FtPUWKKhbJthE
	 vnFq5npT+8PKXPwNHf29bH0Cgd1mgTTyZkScBIW9ivVzkHx2PN8Rtfei6qlTrr+mgs
	 Dw5eE1oD47husFTgLSv5YctVaqJ1B6YCJh1GZdigarDOoNlngQidzMuhXQ+5rZYhia
	 HtGiti9YHW5/ihnEzWc8kiVI0bVjVsKEORdpx/G82CTaQnmPfHMYsP+bzo0yt9CQ0P
	 ePG6/LSx0VI0A==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1v6FQx-00000007XfA-28lF;
	Tue, 07 Oct 2025 17:41:23 -0400
Message-ID: <20251007214008.080852573@kernel.org>
User-Agent: quilt/0.68
Date: Tue, 07 Oct 2025 17:40:08 -0400
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
Subject: [PATCH v16 0/4] perf: Support the deferred unwinding infrastructure
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

This is based on top of tip/perf/core commit: 6d48436560e91be85

Then I added the patches from Peter Zijlstra:

    https://lore.kernel.org/all/20250924075948.579302904@infradead.org/

This series implements the perf interface to use deferred user space stack
tracing.

The patches for the user space side should still work with this series:

  https://lore.kernel.org/linux-trace-kernel/20250908175319.841517121@kernel.org

Patch 1 updates the deferred unwinding infrastructure. It adds a new
function called: unwind_deferred_task_init(). This is used when a tracer
(perf) only needs to follow a single task. The descriptor returned can
be used the same way as the descriptor returned by unwind_deferred_init(),
but the tracer must only use it on one task at a time.

Patch 2 adds the per task deferred stack traces to perf. It adds a new event
type called PERF_RECORD_CALLCHAIN_DEFERRED that is recorded when a task is
about to go back to user space and happens in a location that pages may be
faulted in. It also adds a new callchain context called
PERF_CONTEXT_USER_DEFERRED that is used as a place holder in a kernel
callchain to append the deferred user space stack trace to.

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

Changes since v15: https://lore.kernel.org/linux-trace-kernel/20250825180638.877627656@kernel.org/

- The main update was that I moved the code to do single task deferred
  stack tracing into the unwind code. That allowed to reuse the code
  for tracing all tasks, and simplified the perf code in doing so.

  The first patch updates the unwind deferred code to have this
  infrastructure. It only added a new function:
    unwind_deferred_task_init()
  This is the same as unwind_deferred_init() but it is used when the
  tracer will only trace a single task. The descriptor returned will
  have its own task_work callback it will use and it allows for any
  number of callers, not a limited set like the "all task" deferred
  unwinding has.

- The new code also removed the need to expose the generation of the
  cookie.

Josh Poimboeuf (1):
      perf: Support deferred user callchains

Steven Rostedt (3):
      unwind: Add interface to allow tracing a single task
      perf: Have the deferred request record the user context cookie
      perf: Support deferred user callchains for per CPU events

----
 include/linux/perf_event.h            |   9 +-
 include/linux/unwind_deferred.h       |  15 ++
 include/uapi/linux/perf_event.h       |  25 ++-
 kernel/bpf/stackmap.c                 |   4 +-
 kernel/events/callchain.c             |  14 +-
 kernel/events/core.c                  | 362 +++++++++++++++++++++++++++++++++-
 kernel/unwind/deferred.c              | 283 ++++++++++++++++++++++----
 tools/include/uapi/linux/perf_event.h |  25 ++-
 8 files changed, 686 insertions(+), 51 deletions(-)

