Return-Path: <bpf+bounces-66871-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA1AB3A978
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 20:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D799A0202D
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 18:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395B82701D0;
	Thu, 28 Aug 2025 18:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X916Y52k"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992BE2652A2;
	Thu, 28 Aug 2025 18:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756404216; cv=none; b=LLBtJVz/nI2gDnXI46pJTkg07mRumHjsFtV5+WeY2s/fRyJJdVW+xhbyhnypLMMzIRIrbVk9LwrggCIqCao4ZtqQ/2JxPepqzkvr6p9LEudiqDu0+tGwE5KscSWVhlOW7vOlP3GVo1WrB/F0IngU8LaJIk35qg78FG2XjAe8HnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756404216; c=relaxed/simple;
	bh=vfbt2SZ6nqgsEUTnkrxBr9gEI1neBhMBF0zlWhgN6BI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=GExt4WCoR1rYH5sWM6+bf2UEvoqFzPh82shRoPJjlHP4t+aepQXpewsnPsJ5n6Pp+wn8ycsb8FN+kirKC0QdqL++m9qrycRPbNiEoz9aS7S1qxaHHRp7nLeiOtBVtYilQG8oqERQR5gCf3/DawFQNCssmVSyqD+9OnkYGMWq6MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X916Y52k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 503A5C4CEF5;
	Thu, 28 Aug 2025 18:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756404216;
	bh=vfbt2SZ6nqgsEUTnkrxBr9gEI1neBhMBF0zlWhgN6BI=;
	h=Date:From:To:Cc:Subject:References:From;
	b=X916Y52kDkzOAB+YN2ufHn8u7Sn7d/kgdzqIqwhxrpiZmjGJ2Akl05HnGzpeyTLG5
	 peaABt7rQ81tMFaoNnU11XZKT2t1/vJ6x8QSHcdVl1LuY9KGrXp5uMAp+Dtz8Np65I
	 Wn4X/DGw8e1Nil2NRhX/S2mj7iliGlEZ4ToYTtUPqovvmhsIHQ2q8Zi5KV3UtYP8Xr
	 LlOnCmg24Q/UMGCg4ULhuwc2oMjdXn5GjGJwTfpZ+t7Hs2lwgIvGEHYrAw4WIMt/z4
	 AQIqBmbGYJoadAoQMVY/8B2dh0r2L4okhzEaJvPqI/jGBUcBZN92eDhvTK6Rgn1hcU
	 0vGMUV8vY1skg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1urgyb-00000004GCm-0qNe;
	Thu, 28 Aug 2025 14:03:57 -0400
Message-ID: <20250828180357.052318722@kernel.org>
User-Agent: quilt/0.68
Date: Thu, 28 Aug 2025 14:03:04 -0400
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
Subject: [PATCH v6 4/6] tracing: Have deferred user space stacktrace show file offsets
References: <20250828180300.591225320@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Instead of showing the IP address of the user space stack trace, which is
where ever it was mapped by the kernel, show the offsets of where it would
be in the file.

Instead of:

       trace-cmd-1066    [007] .....    67.770256: <user stack unwind>
cookie=7000000000009
 =>  <00007fdbd0d421ca>
 =>  <00007fdbd0f3be27>
 =>  <00005635ece557e7>
 =>  <00005635ece559d3>
 =>  <00005635ece56523>
 =>  <00005635ece6479d>
 =>  <00005635ece64b01>
 =>  <00005635ece64bc0>
 =>  <00005635ece53b7e>
 =>  <00007fdbd0c6bca8>

Which is the addresses of the functions in the virtual address space of
the process. Have it record:

       trace-cmd-1090    [003] .....   180.779876: <user stack unwind>
cookie=3000000000009
 =>  <00000000001001ca>
 =>  <000000000000ae27>
 =>  <00000000000107e7>
 =>  <00000000000109d3>
 =>  <0000000000011523>
 =>  <000000000001f79d>
 =>  <000000000001fb01>
 =>  <000000000001fbc0>
 =>  <000000000000eb7e>
 =>  <0000000000029ca8>

Which is the offset from code where it was mapped at. To find this
address, the mmap_read_lock is taken and the vma is searched for the
addresses. Then what is recorded is simply:

  (addr - vma->vm_start) + (vma->vm_pgoff << PAGE_SHIFT);

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index e5b7db19aa53..3e9ef644dd64 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3136,18 +3136,27 @@ static void trace_user_unwind_callback(struct unwind_work *unwind,
 	struct trace_buffer *buffer = tr->array_buffer.buffer;
 	struct userunwind_stack_entry *entry;
 	struct ring_buffer_event *event;
+	struct mm_struct *mm = current->mm;
 	unsigned int trace_ctx;
+	struct vm_area_struct *vma = NULL;
 	unsigned long *caller;
 	unsigned int offset;
 	int len;
 	int i;
 
+	/* This should never happen */
+	if (!mm)
+		return;
+
 	if (!(tr->trace_flags & TRACE_ITER_USERSTACKTRACE_DELAY))
 		return;
 
 	len = trace->nr * sizeof(unsigned long) + sizeof(*entry);
 
 	trace_ctx = tracing_gen_ctx();
+
+	guard(mmap_read_lock)(mm);
+
 	event = __trace_buffer_lock_reserve(buffer, TRACE_USER_UNWIND_STACK,
 					    len, trace_ctx);
 	if (!event)
@@ -3164,7 +3173,16 @@ static void trace_user_unwind_callback(struct unwind_work *unwind,
 	caller = (void *)entry + offset;
 
 	for (i = 0; i < trace->nr; i++) {
-		caller[i] = trace->entries[i];
+		unsigned long addr = trace->entries[i];
+
+		if (!vma || addr < vma->vm_start || addr >= vma->vm_end)
+			vma = vma_lookup(mm, addr);
+
+		if (!vma) {
+			caller[i] = addr;
+			continue;
+		}
+		caller[i] = (addr - vma->vm_start) + (vma->vm_pgoff << PAGE_SHIFT);
 	}
 
 	__buffer_unlock_commit(buffer, event);
-- 
2.50.1



