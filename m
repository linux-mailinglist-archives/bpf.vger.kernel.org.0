Return-Path: <bpf+bounces-61620-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 521ACAE9219
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 01:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D17687A6E8B
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 23:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CC02FCE21;
	Wed, 25 Jun 2025 23:16:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EFE2F5497;
	Wed, 25 Jun 2025 23:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750893366; cv=none; b=pigYBlXMYxvlO6b9tlVfr8VAIlFEEby4BxGxoH5eQfLxLabVSRLbB24MyCZFEQSxvODtOBrVvb8uUldwFTU8AsLCj3Cjj5XPyc4+W7LalmHdpTIJO0mWgLdKzs28h7/oGhjYpZfIYYGsrKJzJIu4h2A172LE3Vd103ED8UhgJ1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750893366; c=relaxed/simple;
	bh=W0V4txT2VqsqxUALEjtx7r8CsT4+EoEiM6gy9naSJcM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=AuxyCa1DPGuTFJSeduKEdpDHs8fx+AcMnEWDloc87cj6Snh7G/bm0SElgwsZSC5+mKZuSPLEkoh8BylVKggaZuANENP1C7jpHw2XJP53Tn8or/MbjwkRYv+Gea9AVImXgNY6tZII8n9eMGHPx5XLAto+XI+rg+e9+Bx6QRdaFpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 89363104867;
	Wed, 25 Jun 2025 23:16:01 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id 2D0AA17;
	Wed, 25 Jun 2025 23:15:57 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uUZLq-000000044gm-1Lqk;
	Wed, 25 Jun 2025 19:16:22 -0400
Message-ID: <20250625231622.172100822@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 25 Jun 2025 19:15:44 -0400
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
 Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v11 03/11] perf: Use current->flags & PF_KTHREAD instead of current->mm == NULL
References: <20250625231541.584226205@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Queue-Id: 2D0AA17
X-Stat-Signature: 8awn5n4x18skqdsj7a7fb8gdf9bock5t
X-Rspamd-Server: rspamout06
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+v3d6/TViyaAoIBSiRhmJcrZ8wW5TPm9A=
X-HE-Tag: 1750893357-171058
X-HE-Meta: U2FsdGVkX1+bN8xFD2uyi8X7VkIW4ToZOCWPRb9vQHFmdj7QGi/qz74rDTULSB0d9NelKCRG0HGYt5AvNRZX2ewVBuSvEY8BYJw87KRGEeLg8zyl48Kee2lq5ZAMUhT3XzsYSUxcaTWU89FVzI4A2DXveO3w0ulM7x3SdqIBmcRRGxxk6l4yWsQ9K24R7smgU6ktXQY338DwXRfwS+gzPbzdDrWtbLQ6wK94Xm5eXDSIcyjuyQRyPyKu4R20jQCkrP4ITHbPQy0hPt5Ffks2auaGi1duUjXnybmobGV8pWhJWZdWeXVPQv1i1Bu9FbV3rIhQWJ7DiH348SHEqq86BQdpABMs/tPs+wpyVm51iia/UmJq6i5fMmdpYo6fF7koY+BK9WRMk2Vp9amFH81AhqnucTxF+S9no9z0rGYV/AAxeqRdaqvBwfwnUPSH1c5fGwTNnktRgOPXLuwX2c5EUJLTziAr/W6LCWO0kz5UVEA=

From: Steven Rostedt <rostedt@goodmis.org>

To determine if a task is a kernel thread or not, it is more reliable to
use (current->flags & PF_KTHREAD) than to rely on current->mm being NULL.
That is because some kernel tasks (io_uring helpers) may have a mm field.

Link: https://lore.kernel.org/linux-trace-kernel/20250424163607.GE18306@noisy.programming.kicks-ass.net/

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/events/callchain.c | 6 +++---
 kernel/events/core.c      | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index cd0e3fc7ed05..42d21761cb4d 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -246,10 +246,10 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 
 	if (user && !crosstask) {
 		if (!user_mode(regs)) {
-			if  (current->mm)
-				regs = task_pt_regs(current);
-			else
+			if (current->flags & PF_KTHREAD)
 				regs = NULL;
+			else
+				regs = task_pt_regs(current);
 		}
 
 		if (regs) {
diff --git a/kernel/events/core.c b/kernel/events/core.c
index ca7e9e7d19bf..ae371007a2a6 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8054,7 +8054,7 @@ static u64 perf_virt_to_phys(u64 virt)
 		 * Try IRQ-safe get_user_page_fast_only first.
 		 * If failed, leave phys_addr as 0.
 		 */
-		if (current->mm != NULL) {
+		if (!(current->flags & PF_KTHREAD)) {
 			struct page *p;
 
 			pagefault_disable();
-- 
2.47.2



