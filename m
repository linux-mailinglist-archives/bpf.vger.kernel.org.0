Return-Path: <bpf+bounces-783-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0FB706B52
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 16:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 528681C20FAE
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 14:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F219F33D6;
	Wed, 17 May 2023 14:37:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5451C26
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 14:37:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B54C433D2;
	Wed, 17 May 2023 14:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684334231;
	bh=MSMKpHVxjhuOiWe8EX7pIeXK9wTVhKm+8TLKljz9Tvk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RTGuTi0leCH8jpWQgMrRYaq+0tgsQluLk8CslVOGjxPziciB0EvxKruVNfTibsd9q
	 UA1URyIUnlhffj026F1FYQ8YyIT2Ng3sW7ANSiDWfk44Ag17qh/GzG2GCupdVMGSHZ
	 hPeYL2fvTfK02zSHFDYlgJ3E4hQ+XrZtYedbZEPmEkbK+fdZNhtHOijxpPBbfmk8mU
	 Nr3qzebvoqunooMiCasWGB9Ap81aDRPCBp1lhJQOACJDvfTeZidwHIa8tm5Q9Ms2Cl
	 AUz0+nnXX045v+2R1j5kZ1LdOy3jnyIOEWMys2p+mlptq6Za3VA143M07eJDn8xXFL
	 PHlciCTq/le0A==
Date: Wed, 17 May 2023 23:37:07 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, Florent Revest <revest@chromium.org>, Mark
 Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, bpf@vger.kernel.org
Subject: Re: [PATCH v11 09/11] selftests/ftrace: Add tracepoint probe test
 case
Message-Id: <20230517233707.a3696258ea700925764586c1@kernel.org>
In-Reply-To: <168432121009.1351929.4077460131525842825.stgit@mhiramat.roam.corp.google.com>
References: <168432112492.1351929.9265172785506392923.stgit@mhiramat.roam.corp.google.com>
	<168432121009.1351929.4077460131525842825.stgit@mhiramat.roam.corp.google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 May 2023 20:00:10 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Add test cases for tracepoint probe events.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  .../ftrace/test.d/dynevent/add_remove_tprobe.tc    |   27 +++++++
>  .../ftrace/test.d/dynevent/tprobe_syntax_errors.tc |   82 ++++++++++++++++++++
>  2 files changed, 109 insertions(+)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_tprobe.tc
>  create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/tprobe_syntax_errors.tc
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_tprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_tprobe.tc
> new file mode 100644
> index 000000000000..afc8412fde6b
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_tprobe.tc
> @@ -0,0 +1,27 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: Generic dynamic event - add/remove tracepoint probe events
> +# requires: dynamic_events "t[:[<group>/][<event>]] <tracepoint> [<args>]": README

Hmm, there is a space between keyword and README, which allows selftests runs this
without fprobe. This needs to be fixed.

Thank you,

> +
> +echo 0 > events/enable
> +echo > dynamic_events
> +
> +TRACEPOINT1=kmem_cache_alloc
> +TRACEPOINT2=kmem_cache_free
> +
> +echo "t:myevent1 $TRACEPOINT1" >> dynamic_events
> +echo "t:myevent2 $TRACEPOINT2" >> dynamic_events
> +
> +grep -q myevent1 dynamic_events
> +grep -q myevent2 dynamic_events
> +test -d events/tracepoints/myevent1
> +test -d events/tracepoints/myevent2
> +
> +echo "-:myevent2" >> dynamic_events
> +
> +grep -q myevent1 dynamic_events
> +! grep -q myevent2 dynamic_events
> +
> +echo > dynamic_events
> +
> +clear_trace
> diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/tprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/dynevent/tprobe_syntax_errors.tc
> new file mode 100644
> index 000000000000..c8dac5c1cfa8
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/dynevent/tprobe_syntax_errors.tc
> @@ -0,0 +1,82 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: Tracepoint probe event parser error log check
> +# requires: dynamic_events "t[:[<group>/][<event>]] <tracepoint> [<args>]": README
> +
> +check_error() { # command-with-error-pos-by-^
> +    ftrace_errlog_check 'trace_fprobe' "$1" 'dynamic_events'
> +}
> +
> +check_error 't^100 kfree'		# BAD_MAXACT_TYPE
> +
> +check_error 't ^non_exist_tracepoint'	# NO_TRACEPOINT
> +check_error 't:^/bar kfree'		# NO_GROUP_NAME
> +check_error 't:^12345678901234567890123456789012345678901234567890123456789012345/bar kfree'	# GROUP_TOO_LONG
> +
> +check_error 't:^foo.1/bar kfree'	# BAD_GROUP_NAME
> +check_error 't:^ kfree'			# NO_EVENT_NAME
> +check_error 't:foo/^12345678901234567890123456789012345678901234567890123456789012345 kfree'	# EVENT_TOO_LONG
> +check_error 't:foo/^bar.1 kfree'	# BAD_EVENT_NAME
> +
> +check_error 't kfree ^$retval'		# RETVAL_ON_PROBE
> +check_error 't kfree ^$stack10000'	# BAD_STACK_NUM
> +
> +check_error 't kfree ^$arg10000'	# BAD_ARG_NUM
> +
> +check_error 't kfree ^$none_var'	# BAD_VAR
> +check_error 't kfree ^%rax'		# BAD_VAR
> +
> +check_error 't kfree ^@12345678abcde'	# BAD_MEM_ADDR
> +check_error 't kfree ^@+10'		# FILE_ON_KPROBE
> +
> +grep -q "imm-value" README && \
> +check_error 't kfree arg1=\^x'	# BAD_IMM
> +grep -q "imm-string" README && \
> +check_error 't kfree arg1=\"abcd^'	# IMMSTR_NO_CLOSE
> +
> +check_error 't kfree ^+0@0)'		# DEREF_NEED_BRACE
> +check_error 't kfree ^+0ab1(@0)'	# BAD_DEREF_OFFS
> +check_error 't kfree +0(+0(@0^)'	# DEREF_OPEN_BRACE
> +
> +if grep -A1 "fetcharg:" README | grep -q '\$comm' ; then
> +check_error 't kfree +0(^$comm)'	# COMM_CANT_DEREF
> +fi
> +
> +check_error 't kfree ^&1'		# BAD_FETCH_ARG
> +
> +
> +# We've introduced this limitation with array support
> +if grep -q ' <type>\\\[<array-size>\\\]' README; then
> +check_error 't kfree +0(^+0(+0(+0(+0(+0(+0(+0(+0(+0(+0(+0(+0(+0(@0))))))))))))))'	# TOO_MANY_OPS?
> +check_error 't kfree +0(@11):u8[10^'		# ARRAY_NO_CLOSE
> +check_error 't kfree +0(@11):u8[10]^a'		# BAD_ARRAY_SUFFIX
> +check_error 't kfree +0(@11):u8[^10a]'		# BAD_ARRAY_NUM
> +check_error 't kfree +0(@11):u8[^256]'		# ARRAY_TOO_BIG
> +fi
> +
> +check_error 't kfree @11:^unknown_type'		# BAD_TYPE
> +check_error 't kfree $stack0:^string'		# BAD_STRING
> +check_error 't kfree @11:^b10@a/16'		# BAD_BITFIELD
> +
> +check_error 't kfree ^arg123456789012345678901234567890=@11'	# ARG_NAME_TOO_LOG
> +check_error 't kfree ^=@11'			# NO_ARG_NAME
> +check_error 't kfree ^var.1=@11'		# BAD_ARG_NAME
> +check_error 't kfree var1=@11 ^var1=@12'	# USED_ARG_NAME
> +check_error 't kfree ^+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(@1234))))))'	# ARG_TOO_LONG
> +check_error 't kfree arg1=^'			# NO_ARG_BODY
> +
> +
> +# multiprobe errors
> +if grep -q "Create/append/" README && grep -q "imm-value" README; then
> +echo "t:tracepoint/testevent kfree" > dynamic_events
> +check_error '^f:tracepoint/testevent kfree'	# DIFF_PROBE_TYPE
> +
> +# Explicitly use printf "%s" to not interpret \1
> +printf "%s" "t:tracepoints/testevent kfree abcd=\\1" > dynamic_events
> +check_error "t:tracepoints/testevent kfree ^bcd=\\1"	# DIFF_ARG_TYPE
> +check_error "t:tracepoints/testevent kfree ^abcd=\\1:u8"	# DIFF_ARG_TYPE
> +check_error "t:tracepoints/testevent kfree ^abcd=\\\"foo\"" # DIFF_ARG_TYPE
> +check_error "^t:tracepoints/testevent kfree abcd=\\1"	# SAME_PROBE
> +fi
> +
> +exit 0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

