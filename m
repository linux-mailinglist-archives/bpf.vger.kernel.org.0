Return-Path: <bpf+bounces-55667-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE615A84ACD
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 19:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B21E4E0CA3
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 17:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643DA1F03F2;
	Thu, 10 Apr 2025 17:16:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F64D1876;
	Thu, 10 Apr 2025 17:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744305386; cv=none; b=PWj7fJiP63xdAFyvSwsOKcWRzN3v1gedksUL9sowKyPnf7h0grwRQ0lPKVuuWTNTWlRAVubt+e3hiCTMUyZXjprr4fdwzzL1urn7BxrJid7y8QpZNKLTkbOxkIEyHQkcJCko6w5o6zFmNk8+hzokLaY4NlA4tUJzdPxIch+YBCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744305386; c=relaxed/simple;
	bh=6KmnUnyzGKdChNK+elMwGMuTYev97wZ4A+99rDaakJo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rT1cKLPjz0ltG6RS1210bSC+klB9WDcSioYYVbADWUy5xOIjrUQ/dR/q043mrhO62YQfhoCts3md2LJmZZFUsc7mzRZX/mJ9IhKBNGq5E84te46wnIl6bz5K6q9OqJi2Gpxo/t8El2BOF6m1iDc3HVHIZ9TRDARthycDGR9jaDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD5DDC4CEDD;
	Thu, 10 Apr 2025 17:16:23 +0000 (UTC)
Date: Thu, 10 Apr 2025 13:17:45 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Sven Schnelle
 <svens@linux.ibm.com>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Guo Ren
 <guoren@kernel.org>, Donglin Peng <dolinux.peng@gmail.com>, Zheng Yejian
 <zhengyejian@huaweicloud.com>, Aishwarya.TCV@arm.com
Subject: Re: [PATCH v4 2/4] ftrace: Add support for function argument to
 graph tracer
Message-ID: <20250410131745.04c126eb@gandalf.local.home>
In-Reply-To: <ccc40f2b-4b9e-4abd-8daf-d22fce2a86f0@sirena.org.uk>
References: <20250227185804.639525399@goodmis.org>
	<20250227185822.810321199@goodmis.org>
	<ccc40f2b-4b9e-4abd-8daf-d22fce2a86f0@sirena.org.uk>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Apr 2025 23:34:16 +0100
Mark Brown <broonie@kernel.org> wrote:

> We've been seeing the PID filters selftest failing for a while on
> several arm64 systems, a bisect I managed to run without running into
> any confounding issues pointed to this patch which is in mainline as
> ff5c9c576e75.  It's in the ftrace code, but I'm not immediately seeing
> the relevance.  Output from a failing run:
> 
>  6190 18:38:41.261255  # not ok 48 ftrace - function pid filters
>  6191 18:38:41.274039  # # execute: /lava-922575/1/tests/2_kselftest-ftrace/automated/linux/kselftest/ftrace/test.d/ftrace/func-filter-pid.tc
>  6192 18:38:41.285261  # # + checkreq /lava-922575/1/tests/2_kselftest-ftrace/automated/linux/kselftest/ftrace/test.d/ftrace/func-filter-pid.tc
>  6193 18:38:41.296551  # # + grep ^#[ t]*requires: /lava-922575/1/tests/2_kselftest-ftrace/automated/linux/kselftest/ftrace/test.d/ftrace/func-filter-pid.tc
>  6194 18:38:41.307877  # # + cut -f2- -d:
>  6195 18:38:41.308157  # # + requires= set_ftrace_pid set_ftrace_filter function:tracer
>  6196 18:38:41.319397  # # + eval check_requires  set_ftrace_pid set_ftrace_filter function:tracer
>  6197 18:38:41.319681  # # + check_requires set_ftrace_pid set_ftrace_filter function:tracer
>  6198 18:38:41.319905  # # + p=set_ftrace_pid
>  6199 18:38:41.330653  # # + r=set_ftrace_pid
>  6200 18:38:41.330936  # # + t=set_ftrace_pid
>  6201 18:38:41.331161  # # + [ set_ftrace_pid != set_ftrace_pid ]
>  6202 18:38:41.331367  # # + [ set_ftrace_pid != set_ftrace_pid ]
>  6203 18:38:41.342045  # # + [ set_ftrace_pid != set_ftrace_pid ]
>  6204 18:38:41.342330  # # + [ ! -e set_ftrace_pid ]
>  .......
>  6364 18:39:15.411636  # # + grep -v 7190
>  6365 18:39:15.411865  # # + wc -l
>  6366 18:39:15.412073  # # + count_other=3
>  6367 18:39:15.412554  # # + [ 2 -eq 0 -o 3 -ne 0 ]
>  6368 18:39:15.412773  # # + fail PID filtering not working?
>  6369 18:39:15.422776  # # + do_reset
>  6370 18:39:15.423055  # # + [ 1 -eq 1 ]
>  6371 18:39:15.423278  # # + echo nofunction-fork
>  6372 18:39:15.423485  # # + [ 1 -eq 1 ]
>  6373 18:39:15.423681  # # + echo 0
>  6374 18:39:15.423873  # # + echo PID filtering not working?
>  6375 18:39:15.434095  # # PID filtering not working?
>  6376 18:39:15.434377  # # + exit_fail
>  6377 18:39:15.434602  # # + exit 1

Hmm, I wonder if there's junk being added into the trace.

Can you add this patch, and show me the output when it fails again?

-- Steve

diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
index 8dcce001881d..0699ec6d7554 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
@@ -72,6 +72,7 @@ do_test() {
 
     # count_other should be 0
     if [ $count_pid -eq 0 -o $count_other -ne 0 ]; then
+	cat trace
 	fail "PID filtering not working?"
     fi
 
@@ -79,6 +80,7 @@ do_test() {
     clear_trace
 
     if [ $do_function_fork -eq 0 ]; then
+	cat trace
 	return
     fi
 
@@ -93,6 +95,7 @@ do_test() {
 
     # count_other should NOT be 0
     if [ $count_pid -eq 0 -o $count_other -eq 0 ]; then
+	cat trace
 	fail "PID filtering not following fork?"
     fi
 }

