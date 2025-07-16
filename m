Return-Path: <bpf+bounces-63477-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07918B07D8E
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 21:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 739CC1897BC3
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 19:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF24C29DB71;
	Wed, 16 Jul 2025 19:25:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29BB13D503;
	Wed, 16 Jul 2025 19:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752693932; cv=none; b=b/pThbYU4Ub4WeZcmgykN7XQFNLHwUYaTwZknFEaZ9V1+ZoI4gyobS34AiOkfDb8HpWvogAsR3VIQT6rmMtYSvgM7iCh60vsuWe7aKkxPHsFj1D08cP85kp3sr+uN5hvhXI5L+Fh0SUVSfSI7qWbHGfL2VY2W/EaiWEVY9rXAYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752693932; c=relaxed/simple;
	bh=Hv63yMay8mbhFM4zLLO5m/N2tIfthDwtdzQ7Esa2S80=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ky1/6eCEnuns+Jd0U6kZJ/oTgEpl79HUuWOX3Jcr7oRHLHyvQ+i3EoWIkDAdr4GwMbkK0bZkYBN5mi4zJIHDMyglL0D9xqAIEqQ0o5A+zdkzCClgE4RnRCh9YZH1ZV0+jLgzKafPFyMuNZm95T/tAREla0MgYiUgekHP7NLBZzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 8201114051A;
	Wed, 16 Jul 2025 19:25:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id CE1E920025;
	Wed, 16 Jul 2025 19:25:16 +0000 (UTC)
Date: Wed, 16 Jul 2025 15:25:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Andrii
 Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, "Jose
 E. Marchesi" <jemarch@gnu.org>, Beau Belgrave <beaub@linux.microsoft.com>,
 Jens Remus <jremus@linux.ibm.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>,
 Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>, Sam
 James <sam@gentoo.org>
Subject: Re: [PATCH v13 10/14] unwind: Clear unwind_mask on exit back to
 user space
Message-ID: <20250716152515.20699c64@batman.local.home>
In-Reply-To: <20250716143352.54d9d965@batman.local.home>
References: <20250708012239.268642741@kernel.org>
	<20250708012359.345060579@kernel.org>
	<20250715102912.GQ1613200@noisy.programming.kicks-ass.net>
	<20250716142609.47f0e4a5@batman.local.home>
	<20250716143352.54d9d965@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: yqzgk9yxdrffy97jtommr38674rsztpz
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: CE1E920025
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1++iWTZbjkHMBToQzNUvwO99krfymIct90=
X-HE-Tag: 1752693916-499051
X-HE-Meta: U2FsdGVkX1/+uRuX2HxufIA1KYgJgnoqc5TCl/FWSkKdz8KThzUUeGFW3dCnqRBdDkJX7qOICyzu7TKJJXgqieZ3HscvgW+0Z4D7q5xXB1naLq0n/YNYZrULMskuZPHNKNjOC3jeo6WobKCiZfhB7Ks9VatY5T/0aNOhL/IOe4Fb7RskgwcSBCPlX6sqvpTGQdNSGbu2FLKbO9GWPmSp2CDzJLYu3Hv7ZD350/I8RyhKugeiNIT+eDKMrEnb7LL1LmUQU32ry+hdx1c/3TF/mj+fM6+hN39d7EVcw5XKxpUTDArpAaQ0VVLv1VT0vd6CCTSzQyLIVOgkeSK9i6UPmraFuCeBDsvGAQew+1ATPrZUQM0hN4xkGqK+uPLZ3Ii9

On Wed, 16 Jul 2025 14:33:52 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> [Task enters kernel]
>   request -> add cookie
>   request -> add cookie
>   [..]
>   callback -> add trace + cookie
>  [ftrace clears bits]
>   callback -> add trace + cookie
> [Task exits back to user space]

Another solution could be to add another unwind mask of completed
callbacks. Then we could use the fetch_or(). I guess that could look
like this:

diff --git a/include/linux/unwind_deferred.h b/include/linux/unwind_deferred.h
index 15045999c5e2..0124865aaab4 100644
--- a/include/linux/unwind_deferred.h
+++ b/include/linux/unwind_deferred.h
@@ -61,8 +61,10 @@ static __always_inline void unwind_reset_info(void)
 		} while (!try_cmpxchg(&info->unwind_mask, &bits, 0UL));
 		current->unwind_info.id.id = 0;
 
-		if (unlikely(info->cache))
+		if (unlikely(info->cache)) {
 			info->cache->nr_entries = 0;
+			info->cache->unwind_completed = 0;
+		}
 	}
 }
 
diff --git a/include/linux/unwind_deferred_types.h b/include/linux/unwind_deferred_types.h
index 5dc9cda141ff..33b62ac25c86 100644
--- a/include/linux/unwind_deferred_types.h
+++ b/include/linux/unwind_deferred_types.h
@@ -3,6 +3,7 @@
 #define _LINUX_UNWIND_USER_DEFERRED_TYPES_H
 
 struct unwind_cache {
+	unsigned long		unwind_completed;
 	unsigned int		nr_entries;
 	unsigned long		entries[];
 };
diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
index 60cc71062f86..9a3e06ee9d63 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -170,13 +170,19 @@ static void process_unwind_deferred(struct task_struct *task)
 
 	unwind_user_faultable(&trace);
 
+	if (info->cache)
+		bits &= ~(info->cache->unwind_completed);
+
 	cookie = info->id.id;
 
 	guard(srcu_lite)(&unwind_srcu);
 	list_for_each_entry_srcu(work, &callbacks, list,
 				 srcu_read_lock_held(&unwind_srcu)) {
-		if (test_bit(work->bit, &bits))
+		if (test_bit(work->bit, &bits)) {
 			work->func(work, &trace, cookie);
+			if (info->cache)
+				info->cache->unwind_completed |= BIT(work->bit);
+		}
 	}
 }
 
Instead of adding another long word in the tasks struct, I just use the
unwind_cache that gets allocated on the first use.

I think this can work. I'll switch it over to this and then I can use
the fetch_or() and there should be no extra callbacks, even if an
already called callback is requested again after another callback was
requested which would trigger another task work.

I'll update this patch (and fold it into the bitmask patch) with the
fetch_or() and create this patch as a separate patch that just gets rid
of spurious callbacks.

-- Steve

