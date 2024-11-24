Return-Path: <bpf+bounces-45552-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 200719D7933
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 00:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 526AD162EDC
	for <lists+bpf@lfdr.de>; Sun, 24 Nov 2024 23:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDB318BBBB;
	Sun, 24 Nov 2024 23:49:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B20C15B0FE;
	Sun, 24 Nov 2024 23:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732492173; cv=none; b=dwang76WWarV0HWeorUkkNcmhCqXqW/yBmJMDfqYtwN832640jH/bydAIMy3AbEH1W5bh9D7i6t5GYPYW4eRFnEUqLhim53zRf4j10fdyq++C+92AIOZEc5o3tCgqzg8QdyaoiqGJ44PXHqYTLBb5TCee2AdbUH7Bzc0pgZGT/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732492173; c=relaxed/simple;
	bh=buTPZlN65lMGJBazM3hNeM4DQXyrNPB3yDoAlbvmLqQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Ktdi4sNABwRE5N5TTnLGlMvB+gQ+mdDfhdErXELtYMPV4RvJhQoBBc9+w7XFIjodjB+C4IEikLvIE33gnltPYUxVc3eJZqLRsloRRhYc7FaFIxcdNi3tRZ1pmzSxCamaKrRNAap056j9QPVANVVaAO2LCEkxg3y8RZgTLdLm0t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A950EC4CED7;
	Sun, 24 Nov 2024 23:49:32 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tFMMs-00000006vjf-3qP9;
	Sun, 24 Nov 2024 18:50:18 -0500
Message-ID: <20241124235018.769193679@goodmis.org>
User-Agent: quilt/0.68
Date: Sun, 24 Nov 2024 18:49:42 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Michael Jeanson <mjeanson@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Alexei Starovoitov <ast@kernel.org>,
 Yonghong Song <yhs@fb.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Namhyung Kim <namhyung@kernel.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 bpf@vger.kernel.org,
 Joel Fernandes <joel@joelfernandes.org>,
 Jordan Rife <jrife@google.com>
Subject: [for-next][PATCH 2/6] tracing: Move it_func[0] comment to the relevant context
References: <20241124234940.017394686@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

When introducing __DO_TRACE_CALL(), the iteration over it_func moved
from __DO_TRACE() to __tracepoint_iter_##_name(), but the comment
relevant for this iterator was left in its original location.

Move the comment to the relevant context.

Fixes: d25e37d89dd2 ("tracepoint: Optimize using static_call()")
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Michael Jeanson <mjeanson@efficios.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Yonghong Song <yhs@fb.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Jordan Rife <jrife@google.com>
Link: https://lore.kernel.org/20241123153031.2884933-2-mathieu.desnoyers@efficios.com
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/tracepoint.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 425123e921ac..d390e8cabf02 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -210,9 +210,6 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 #endif /* CONFIG_HAVE_STATIC_CALL */
 
 /*
- * it_func[0] is never NULL because there is at least one element in the array
- * when the array itself is non NULL.
- *
  * With @syscall=0, the tracepoint callback array dereference is
  * protected by disabling preemption.
  * With @syscall=1, the tracepoint callback array dereference is
@@ -316,6 +313,9 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
  * We have no guarantee that gcc and the linker won't up-align the tracepoint
  * structures, so we create an array of pointers that will be used for iteration
  * on the tracepoints.
+ *
+ * it_func[0] is never NULL because there is at least one element in the array
+ * when the array itself is non NULL.
  */
 #define __DEFINE_TRACE_EXT(_name, _ext, proto, args)			\
 	static const char __tpstrtab_##_name[]				\
-- 
2.45.2



