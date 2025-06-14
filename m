Return-Path: <bpf+bounces-60649-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1547AD99C4
	for <lists+bpf@lfdr.de>; Sat, 14 Jun 2025 04:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B47873BB21E
	for <lists+bpf@lfdr.de>; Sat, 14 Jun 2025 02:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FD91953A1;
	Sat, 14 Jun 2025 02:46:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDDB15746F;
	Sat, 14 Jun 2025 02:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749869184; cv=none; b=MDvYm3EF/eUzNzeVRnOJrMmAoJsgDwfwETQlw+uGDNCqOi89Y9UKvNAt6++WT3fxgbARPrem6HPV2W0Uku3ObzYZERHTkge5X8UD4Xhxb1xUDBdhhYhfqPayzMBL6qT4aPEhjuLiviAJDIG2dRo9ZIzIYdzw24ol3Mh3XzEaLFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749869184; c=relaxed/simple;
	bh=tO09DpsSPf5OLDazQv/DfSYXGXfDYhmqqdnykU40oGg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ZND5c2uh4pFBQews1osjtRrQxK0jW9qB/GgDDiAvqGCDNA+d9S5q9Xw4mzDWC6Ag6I2etDBBEQo+sx9XC0jln+L+CTgeHE9T/8DbBuSflM3Zp8fQR0lbzqhJtZiRDKjeuJd2Qz2RU6hiw/yxWBGMuKMJU9xuqycDQ9m6eocrLs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 5CBE4161ADE;
	Sat, 14 Jun 2025 02:45:40 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 3DF9380009;
	Sat, 14 Jun 2025 02:45:37 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uQGvM-00000002Smv-0LPo;
	Fri, 13 Jun 2025 22:47:16 -0400
Message-ID: <20250614024715.935871344@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 13 Jun 2025 22:46:07 -0400
From: Steven Rostedt <rostedt@goodmis.org>
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
 Namhyung Kim <namhyung@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>,
 Indu Bhagat <indu.bhagat@oracle.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 Jens Remus <jremus@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v10 02/11] perf: Have get_perf_callchain() return NULL if crosstask and user are
 set
References: <20250614024605.597728558@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Queue-Id: 3DF9380009
X-Stat-Signature: fftx6wqwzd5up73u5qa14rsnawapwoyj
X-Rspamd-Server: rspamout05
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19YQQ6ows32X7Rgpbzet1mrfTXPKPXEawg=
X-HE-Tag: 1749869137-870351
X-HE-Meta: U2FsdGVkX1+2pV/i/1GJsW2PANrFg89gdJm9yQ6FOLEyM4aK5AITKQ5QbfKPFWno9SPASEiRVaqAEJtYdu0EW+c+gCqMiJIjfJJ90Np7BYt1UZbCBbAubdFtXWVqpIhG5WHGPDy/n4dwEbGtcWyglvmQVyB+++q6D19tTZhtak1nFVwQ06dU3szdxJRHjMvyw97FHbFPmOsGYJggH8QpP+l05QRblAn2iSV7S82xllXR2NiXGtytXOI6XEx98fs4cvrrgKcxy5cfOJBAX+tl2+xl/c+yQqiW5uUQWaGmq4KB8YvEhMOdGEZDu9RXm3DfPlsXTichs8PL0Av3mOsYkpl19QHk4lragX5JIJbeoMpDb73dHgrla1TOfJ9z3gL8gijvW+HMKw7iU34L5KTBc4x0UfOCmYvn+1SIww6eCdQ=

From: Josh Poimboeuf <jpoimboe@kernel.org>

get_perf_callchain() doesn't support cross-task unwinding for user space
stacks, have it return NULL if both the crosstask and user arguments are
set.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v8 (v9 is the same): https://lore.kernel.org/linux-trace-kernel/20250509165156.135430576@goodmis.org/

- Allow crosstask for user and kernel in get_perf_callchain()
  Instead of exiting out early if crosstask and user is set, also check for
  kernel, and still allow the kernel stack to do the crosstask.
  Not sure if anyone does that, but it should not break what use to work.
  (Andrii Nakryiko)

 kernel/events/callchain.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index b0f5bd228cd8..cd0e3fc7ed05 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -224,6 +224,10 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 	struct perf_callchain_entry_ctx ctx;
 	int rctx, start_entry_idx;
 
+	/* crosstask is not supported for user stacks */
+	if (crosstask && user && !kernel)
+		return NULL;
+
 	entry = get_callchain_entry(&rctx);
 	if (!entry)
 		return NULL;
@@ -240,7 +244,7 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 		perf_callchain_kernel(&ctx, regs);
 	}
 
-	if (user) {
+	if (user && !crosstask) {
 		if (!user_mode(regs)) {
 			if  (current->mm)
 				regs = task_pt_regs(current);
@@ -249,9 +253,6 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 		}
 
 		if (regs) {
-			if (crosstask)
-				goto exit_put;
-
 			if (add_mark)
 				perf_callchain_store_context(&ctx, PERF_CONTEXT_USER);
 
@@ -261,7 +262,6 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 		}
 	}
 
-exit_put:
 	put_callchain_entry(rctx);
 
 	return entry;
-- 
2.47.2



