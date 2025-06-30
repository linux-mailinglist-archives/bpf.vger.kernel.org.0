Return-Path: <bpf+bounces-61858-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 772E5AEE4C1
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 18:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07BFF3A6214
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 16:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAF728DF06;
	Mon, 30 Jun 2025 16:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qtD4F3rz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC73828C5D9;
	Mon, 30 Jun 2025 16:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751301321; cv=none; b=a7KlUb0EC6HvPstlZjn2v73jP6ddUZPmrcwkabbGC/Kg7lvKgBr8Aky90ylG8meGd55d4xjyzi9oK/S/HF7Vmolsmg2SurB9FhXUGs+vomu2gwy9mJYSgOKLON1Q8zJYpyADBfBze8WeKpkNE/8qUuLe+Uuyxrsrpe7vnURABU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751301321; c=relaxed/simple;
	bh=SIsBG0bE6nVpLYGGzrorldUCYalfWsYLdprcRg+JujY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GLNZ6ip1V3sJdJik45ONmYVRUcRFyYjcwoFWEFPUkzncxjLwck7sgTHQnspUGMCrlsdYpWMfTgpTko+RlwlF7Yg0HXY8U8Do0669PkKqjPc+i3RM1qit6GsUeneQM10uU9VXRMrtXkWl9LAvdsT+LrDpY1RIKJLVJKEcEVYBNC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qtD4F3rz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D63AC4CEE3;
	Mon, 30 Jun 2025 16:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751301321;
	bh=SIsBG0bE6nVpLYGGzrorldUCYalfWsYLdprcRg+JujY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qtD4F3rz1jSJAySp7brJDviaCYCb1oXFEXYzexxwNzUm777WkleHoLoaCHvPVnJ3U
	 8ikDP69a8TG5SfA5ZuAH6+jVCuoMs/57eT+rmfgjebWE7eswSvRcLei39T5nCSkr9M
	 ISgeOsazaBwnjbx2Uyi/NfEONkF0lLRjF9cAV8129aV4VZdvF2u6mRjTIShRd5jLGm
	 9geP1aoN7pYIE5xc4RszrodEFOt9v6NoV9WcxqKO4bAQ54mo49iMCfPE5bVB5Xa09M
	 AJJW67Fn/5+7gX5c/N1DQhR5uXc5aLytVWZf7tcq/rYZSCdNRj1Ag36QTJH1AduRav
	 a23zkXX8prl9g==
Date: Mon, 30 Jun 2025 09:35:19 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Florian Weimer <fweimer@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrii Nakryiko <andrii@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v11 00/14] unwind_user: x86: Deferred unwinding
 infrastructure
Message-ID: <aGK8x1Oo6Pgl6rGV@google.com>
References: <20250625225600.555017347@goodmis.org>
 <878ql9mlzn.fsf@oldenburg.str.redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878ql9mlzn.fsf@oldenburg.str.redhat.com>

Hello,

On Mon, Jun 30, 2025 at 02:50:52PM +0200, Florian Weimer wrote:
> * Steven Rostedt:
> 
> > SFrames is now supported in gcc binutils and soon will also be supported
> > by LLVM.
> 
> Is the LLVM support discussed here?
> 
>   [RFC] Adding SFrame support to llvm
>   <https://discourse.llvm.org/t/rfc-adding-sframe-support-to-llvm/86900>
> 
> Or is there a secone effort?
> 
> > I have more patches on top of this series that add perf support, ftrace
> > support, sframe support and the x86 fix ups (for VDSO). But each of those
> > patch series can be worked on independently, but they all depend on this
> > series (although the x86 specific patches at the end isn't necessarily
> > needed, at least for other architectures).
> 
> Related to perf support: I'm writing up the SFrame change proposal for
> Fedora, and I want to include testing instructions.  Any idea yet what a
> typical “perf top” or “perf report” command line would look like?

I think you can run "perf report -s dso,sym -g none" then it will show
"Children" and "Self" overheads.  If callchain in userspace works ok,
you will get non-kernel entries (symbols start with "[.]") having more
children overhead than the self.

  $ perf record -g -- perf bench sched messaging
  
  $ perf report -s dso,sym -g none | grep -F -e Children -e '[.]' | head
  # Children      Self  Shared Object           Symbol
      63.09%     0.01%  perf                    [.] run_bench
      63.09%     0.00%  libc.so.6               [.] __libc_start_call_main
      63.09%     0.00%  perf                    [.] cmd_bench
      63.09%     0.00%  perf                    [.] handle_internal_command
      63.09%     0.00%  perf                    [.] main
      63.09%     0.00%  perf                    [.] run_argv
      63.09%     0.00%  perf                    [.] run_builtin
      63.02%     0.00%  perf                    [.] bench_sched_messaging
      62.79%     0.00%  perf                    [.] group

Thanks,
Namhyung


