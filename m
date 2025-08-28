Return-Path: <bpf+bounces-66868-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 257E0B3A974
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 20:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8D41A02755
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 18:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963DE264A97;
	Thu, 28 Aug 2025 18:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uk0Lw9gy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1300E30CD84;
	Thu, 28 Aug 2025 18:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756404216; cv=none; b=VpehZEoAUeTd3eIn9+FXY1P5WXi2EJ4f5Su1V68v0JWHqojLaNWD255nruQEQ4F8G0OUW3kSSYZjKxoac2oP8hzJ1NHzuc9LpdeKpExQxr9GCPaKis/Hrpa8KIrgc1Cs3PUy7qL0HE/ajx92+DuN/pqf+iSvTYuPonwU3lppq0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756404216; c=relaxed/simple;
	bh=len1TqcKGRiWgn4i9K88WT0rfFP/JPV1Xx3J5okLYhI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=AgyD//GIv66u8nAkt2swyCkfST86XoXGkhVyRUGDV6KnpEJSvepXLm8h5DLliHpnyVjyhlW2TEaB36pdjGyp3RA+YAieNmLaNfVdKVQnWNm97Cb1sJyPM1nTjPjiaE7eAhdx9aNrExSnnoEQ588tmtXplDuLpV5eFv3/iAhYn/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uk0Lw9gy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DADF6C4CEED;
	Thu, 28 Aug 2025 18:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756404215;
	bh=len1TqcKGRiWgn4i9K88WT0rfFP/JPV1Xx3J5okLYhI=;
	h=Date:From:To:Cc:Subject:References:From;
	b=Uk0Lw9gylnba4ypnY+JeVoxsq3OIvYUi/IDBRUuPwiRaVicREVR478oxPIZweAr4H
	 VF431oNQc36kJHvP9+H2B18r2JaCyT0cedHccHVNwSwpvA8/gO8aE6GJbisBjvgDpt
	 tj3leRlUeXhwLFhR8Fh3YxjEAo5mwMCBiAnFTGAY94e+l1A2fSxAI4EkU4chDZTr0j
	 6xSdONqNDCnleQKBya9365kh/uO9TMLpFMx6cc6EUefrVoq1xH6Abq4fel1FmXn67k
	 U122bFoZ/5EGufmcdwiyUjDG4he7HL60oK7uciqSooGqvnVU8bMrRifkNfiBYBBDiw
	 aV3bEvbRSIypg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1urgya-00000004GBK-2uqk;
	Thu, 28 Aug 2025 14:03:56 -0400
Message-ID: <20250828180356.546256287@kernel.org>
User-Agent: quilt/0.68
Date: Thu, 28 Aug 2025 14:03:01 -0400
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
Subject: [PATCH v6 1/6] tracing: Do not bother getting user space stacktraces for kernel
 threads
References: <20250828180300.591225320@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

If a user space stacktrace is requested when running a kernel thread, just
return, as there's no point trying to get the user space stacktrace as
there is no user space.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v5: https://lore.kernel.org/20250424192613.014380756@goodmis.org

- Also add check for PF_USER_WORKER to test for kernel thread

 kernel/trace/trace.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 1b7db732c0b1..2cca29c9863d 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3138,6 +3138,10 @@ ftrace_trace_userstack(struct trace_array *tr,
 	if (!(tr->trace_flags & TRACE_ITER_USERSTACKTRACE))
 		return;
 
+	/* No point doing user space stacktraces on kernel threads */
+	if (current->flags & (PF_KTHREAD | PF_USER_WORKER))
+		return;
+
 	/*
 	 * NMIs can not handle page faults, even with fix ups.
 	 * The save user stack can (and often does) fault.
-- 
2.50.1



