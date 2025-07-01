Return-Path: <bpf+bounces-61965-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF1FAF026D
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 20:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A56F4E46F2
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 18:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1035428312B;
	Tue,  1 Jul 2025 18:04:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CFB28032D;
	Tue,  1 Jul 2025 18:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751393065; cv=none; b=twOtmv075yYMCB/kkFSbzlATeIJt9snAJY0E+Xof8SXvuNVYG7iNURnpLP2X6d9iIgC8LD3y+VvYobzTJq4k7wV/eALpDi1IGstbXPJZiLIsil/ubMajdN8PBVSAH1rhw0Lfg84GCn7HCNkFX9/bp/8Jq6MT8ydsK7OgjSUeSkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751393065; c=relaxed/simple;
	bh=INPL5mykLyHh9BAddpKD33kEw5Zh1QT3Mw8WI6pEDxg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=XWAE+7AP6XyAryCF34cV7Ec+02m8cmEVdZELbmrmk6h+fUkac+/NFr0K4tAk2bGMGubXvFj4Lcj9jJy4sQ4eR7ROpK+PVbc+5uZH+oU/zcEjFOa2svDz/WIvV3r4o3IHdYrJzw0M4TZDDH9cQiOSnEt/OdNu3euNznee/vbnYBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 0CFDDBA5E0;
	Tue,  1 Jul 2025 18:04:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 8B75F18;
	Tue,  1 Jul 2025 18:04:17 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uWfLk-00000007g0E-05dU;
	Tue, 01 Jul 2025 14:04:56 -0400
Message-ID: <20250701180455.872384844@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 01 Jul 2025 14:04:12 -0400
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
 Andrew Morton <akpm@linux-foundation.org>,
 Jens Axboe <axboe@kernel.dk>,
 Florian Weimer <fweimer@redhat.com>
Subject: [PATCH v12 02/11] perf: Have get_perf_callchain() return NULL if crosstask and user are
 set
References: <20250701180410.755491417@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Stat-Signature: 9e7goc9a1kip16qfkakpdef5h3igtoty
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 8B75F18
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+a27bIlBW3R5rVNigKqT3jicHlXSOqmsY=
X-HE-Tag: 1751393057-410247
X-HE-Meta: U2FsdGVkX1+ugqMjWqnch2DVuPFAL5NBDwQF7X4X166VlJL2rwFtiaYXtnk4y67y1o5/375pk8wvKf+5QmWCnu1BAh5EPneqkUgaLDWgjVZN1rWl4nyO7HKtlEL9hyiSpzBXuLWjJRO3nR46gHaE61Ln3cdrTGqATRWy0HPCE+DtJUJmj8+82fCwY9RpQkV6yDWvfAPCFO6Z+qzO2watUNcjSGQo5Q9uH9KrHJ1Z+uN29juPCF9+7rDhcnClP9ALV9tmYcONR4Ee9mB+rSoCCLnfi7mV7vBb4fuAX4QSO21oU0oZr11Spcv68IVblY98S/1gcvKybUsYrwXUFcy5rty62CS/lF/3CwEWtjI11rOsmK2YeKWa+ZKa2VjZdcfPnUbHBNRkneGkrei4X5pFT3IQnbOqD2XU5+IVRLyO1EA=

From: Josh Poimboeuf <jpoimboe@kernel.org>

get_perf_callchain() doesn't support cross-task unwinding for user space
stacks, have it return NULL if both the crosstask and user arguments are
set.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
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



