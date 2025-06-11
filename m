Return-Path: <bpf+bounces-60287-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9777AD4803
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 03:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5BB917D2E6
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 01:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0721531F0;
	Wed, 11 Jun 2025 01:36:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2E4128819;
	Wed, 11 Jun 2025 01:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749605800; cv=none; b=WTQJbMJK+ZljHrbxVjt47aHchj1CV1IvZIi+G08t9iHKgbWDX2KHyLsrsTLAK/JQ66X0APhy+YKPZ7qNmOEo95Y6wUvBhrnjaS4l2rOzoKgcy/IZE5vjRIEI+Ok9mjsKl1p9eYo2M+i+PDH3DehOD8/SrAH1hjNvbA+Dxy1j8Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749605800; c=relaxed/simple;
	bh=6DE7KZOXrlLO0p0yUtPCwZQ+NilkphXCklG8RJnYqCw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=jAnItPAJwWFL8QVGQH7Bjkx2qF3f0pCVTvLKpg020RnVSG4EqEAzWK49wJMD5SSjQrBrMxF5cc4gbKuEU/F3B4PiCJS6dA7AG0vwqQUkGZDymH7btCbijdjwvZUBpnwOgMlsoGWmxO1uFfu2o5O4EDnUzqxQ0m7fs6OCvVPl2DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id B1246121696;
	Wed, 11 Jun 2025 01:36:09 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id CA12920025;
	Wed, 11 Jun 2025 01:36:06 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uPAPK-00000000wMx-3a7d;
	Tue, 10 Jun 2025 21:37:38 -0400
Message-ID: <20250611013738.704387553@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 10 Jun 2025 21:34:23 -0400
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
Subject: [PATCH v9 02/11] perf: Have get_perf_callchain() return NULL if crosstask and user are
 set
References: <20250611013421.040264741@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Stat-Signature: w6kx4d6a9gsqpkgoukaxqapbn1kfzenz
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: CA12920025
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19V+ORyrBgBaadoUL+gVsgo9gHHR6p5g48=
X-HE-Tag: 1749605766-755570
X-HE-Meta: U2FsdGVkX1+6AYwZjwOR3Kj+8d1HTA87ZImBfDgj1VWM4sz/dAAbyJLPpvp/oB28LbtFbGZOCF9pe1gtj/JM2mQXueJHV7Z0yMPe51iMy1bN8WqlQHqdTfG3GxlRVvGNs9LE1GIMC0a2qcjZe/TMuhbIHonbwcqLeNddnhSBXrrOG5dTm51wNVxTJ3tNXJBB4qT8S4mkRoWwgOW/S+GeLbzyPX/7Quu8RY9QXE17PJeWKIlaNui4yJSS0peQ/Ln8bTt+bzNmaxUlCdOJLZc+5VNeinatAxxPcPF13GnA/V0tKBsD/p+TBiJLOzTMjCGgYEI5Kxv7a+K3gCuzzyYH0GeYLrdrE8Lj3/W+dEv+ooqRBw6/Ut4xUVVNaKCi8aa4nxZUxWzvLYT4qZEBo/PuYUaV3qZBWJIajQVN7/iyr1o=

From: Josh Poimboeuf <jpoimboe@kernel.org>

get_perf_callchain() doesn't support cross-task unwinding for user space
stacks, have it return NULL if both the crosstask and user arguments are
set.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/events/callchain.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index b0f5bd228cd8..abf258913ab6 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -224,6 +224,10 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 	struct perf_callchain_entry_ctx ctx;
 	int rctx, start_entry_idx;
 
+	/* crosstask is not supported for user stacks */
+	if (crosstask && user)
+		return NULL;
+
 	entry = get_callchain_entry(&rctx);
 	if (!entry)
 		return NULL;
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



