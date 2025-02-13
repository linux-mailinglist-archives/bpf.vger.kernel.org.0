Return-Path: <bpf+bounces-51445-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A9EA34A27
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 17:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 991B5176D88
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 16:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE8E280A24;
	Thu, 13 Feb 2025 16:21:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115D327FE6B;
	Thu, 13 Feb 2025 16:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739463696; cv=none; b=SrFghITmPWY2TiWBFa+0j8ZU5PChtk1RR5rxRet3OwZudh8ZYEICVDF/yM6jJAbJAcBfZAU6F8FSbdXW4dUy/nCXIVu6VGaUn2pQ9khrMx1GYxWrh3IfN91eFLL7o3qbIKRp6U9Ne57hoU8VrmPg9D/Yc2P/bZ3GW3uSRXu4uhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739463696; c=relaxed/simple;
	bh=wZwu3dRXSpsPU781WWc0GLMKXfLrt3NN07IElLsCoJ8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ALZXGRWmUcaj1/dzQb5TNcg2WmtYWsdsEJvgTvZUGvhiYYT0mcFXQcYY1g2LJ0Nz2zlbrmTkPsK9UvPA/rcWC4e+ANi986kW40HLlewBeUI9w9BcjuLaO99H19R7nOfQC6OfbzAib9kLqje6mzMg7vMSQdw/lKLjKstoC5jjE3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF2A0C4CED1;
	Thu, 13 Feb 2025 16:21:35 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tibyE-00000001qcT-1IiE;
	Thu, 13 Feb 2025 11:21:46 -0500
Message-ID: <20250213162146.158076547@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 13 Feb 2025 11:20:52 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org,
 bpf <bpf@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 linux-s390@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Masahiro Yamada <masahiroy@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas@fjasle.eu>,
 Zheng Yejian <zhengyejian1@huawei.com>,
 Martin  Kelly <martin.kelly@crowdstrike.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Josh Poimboeuf <jpoimboe@redhat.com>,
 Heiko Carstens <hca@linux.ibm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v3 5/6] ftrace: Update the mcount_loc check of skipped entries
References: <20250213162047.306074881@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Now that weak functions turn into skipped entries, update the check to
make sure the amount that was allocated would fit both the entries that
were allocated as well as those that were skipped.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index e3f89924f603..55d28c060784 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -7111,7 +7111,29 @@ static int ftrace_process_locs(struct module *mod,
 
 	/* We should have used all pages unless we skipped some */
 	if (pg_unuse) {
-		WARN_ON(!skipped);
+		unsigned long pg_remaining, remaining;
+		unsigned long skip;
+
+		/* Count the number of entries unused and compare it to skipped. */
+		pg_remaining = (ENTRIES_PER_PAGE << pg->order) - pg->index;
+
+		if (!WARN(skipped < pg_remaining, "Extra allocated pages for ftrace")) {
+
+			skip = skipped - pg_remaining;
+
+			for (pg = pg_unuse; pg; pg = pg->next) {
+				remaining += 1 << pg->order;
+			}
+
+			skip = DIV_ROUND_UP(skip, ENTRIES_PER_PAGE);
+
+			/*
+			 * Check to see if the number of pages remaining would
+			 * just fit the number of entries skipped.
+			 */
+			WARN(skip != remaining, "Extra allocated pages for ftrace: %lu with %lu skipped",
+			     remaining, skipped);
+		}
 		/* Need to synchronize with ftrace_location_range() */
 		synchronize_rcu();
 		ftrace_free_pages(pg_unuse);
-- 
2.47.2



