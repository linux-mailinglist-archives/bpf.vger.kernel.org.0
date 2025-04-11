Return-Path: <bpf+bounces-55753-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0185CA863E5
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 19:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 832833BB0F2
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 16:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A90221702;
	Fri, 11 Apr 2025 16:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tj30wpO4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7B521ABC3;
	Fri, 11 Apr 2025 16:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744390718; cv=none; b=LLo3Dz6ej+po6tAYt2i8mrHo9OpwPb1f9YVMsbPvv+QpDJmi6zU+80Yu3yY1s/5hy7yOITcpo2/yGnZoZlLNx67Yp2oqhPE2Xa9iuBmTp4p/cvy2Q3oS62j01U54RC2rdpQvHgkaQtxSHD8zBfdF/uB6Ym25EO/xOEfYl0CzueU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744390718; c=relaxed/simple;
	bh=rXC2h7N+zCJTLf5mSn8BGnc0vi7ZNLXkniN3xpZug7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kM1YKX31L9nVH9ueJMM8xkBtpm1j2xfcKBxTWEBN2SFApKeQuf/kogeQv9foQ0YDAt8WqrXxR15DmwJAD1r7TnMyPA+/We6n53nQWccASoAIrY+zeRY8KCH3VzPgdUZHIep8uGIrw/IOzgt6DJxAsMYMi7klr0uB4VZMPUhTGnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tj30wpO4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA4A2C4CEE2;
	Fri, 11 Apr 2025 16:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744390717;
	bh=rXC2h7N+zCJTLf5mSn8BGnc0vi7ZNLXkniN3xpZug7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tj30wpO4ECW3eofoOPzaWgvKlvqLvE3+5GWW1Sx+YaAdErtMJB14lT58F0zfz89VM
	 yCzMrh2hJTnVE6bmpCX/wJyZZ9PgJOzz/KWR1KBXth8kVmz6WhZSw9aomptl0AMXpg
	 oJ01mNJbrYKGf8lXFTxzpfuI74zP+p6erL83m8929c2qHKyAgdHAXxLUVhumO25+Pd
	 yELysP/0bDFDosGbB0jBtUWxvbiEGurKCB0qygXYIGj5VRe2A0rVRFaZHiHNQk9FZL
	 merQ729vf6yAJO7yhRz9GcCIVLDrV3FWO61RFb/2nsmTkVV9B3CG3Q8/BP3lZKqB/A
	 yUeOg6FkPJUnA==
Date: Fri, 11 Apr 2025 17:58:32 +0100
From: Mark Brown <broonie@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	Donglin Peng <dolinux.peng@gmail.com>,
	Zheng Yejian <zhengyejian@huaweicloud.com>, Aishwarya.TCV@arm.com
Subject: Re: [PATCH v4 2/4] ftrace: Add support for function argument to
 graph tracer
Message-ID: <2edc0ba8-2f45-40dc-86d9-5ab7cea8938c@sirena.org.uk>
References: <20250227185804.639525399@goodmis.org>
 <20250227185822.810321199@goodmis.org>
 <ccc40f2b-4b9e-4abd-8daf-d22fce2a86f0@sirena.org.uk>
 <20250410131745.04c126eb@gandalf.local.home>
 <c41e5ee7-18ba-40cf-8a31-19062d94f7b9@sirena.org.uk>
 <20250411124552.36564a07@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fMVW2VbKSe/epRWr"
Content-Disposition: inline
In-Reply-To: <20250411124552.36564a07@gandalf.local.home>
X-Cookie: You will be awarded some great honor.


--fMVW2VbKSe/epRWr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 12:45:52PM -0400, Steven Rostedt wrote:
> Mark Brown <broonie@kernel.org> wrote:
> > On Thu, Apr 10, 2025 at 01:17:45PM -0400, Steven Rostedt wrote:

> > > Hmm, I wonder if there's junk being added into the trace. =20

> > > Can you add this patch, and show me the output when it fails again? =
=20

> Can you show the information before this output, to see what it is actual=
ly
> testing?

Here's a bit more of the context - this is literally just the ftrace
selftests so it'll be doing whatever that does, there's a huge amount of
log splat generated when enumerating all the triggers.  I do note that
it appears to assume there's a ping binary which might confusing things,
though I'm surprised that'd be a regression rather than something that
just never worked:

# # + reset_ftrace_filter
# # + [ ! -f set_ftrace_filter ]
# # + echo
# # + grep -v ^# set_ftrace_filter
# # + read t
# # + disable_events
# # + echo 0
# # + clear_dynamic_events
# # + again=3D1
# # + stop=3D1
# # + [ 1 -eq 1 ]
# # + stop=3D2
# # + [ 2 -gt 10 ]
# # + again=3D2
# # + grep -v ^# dynamic_events
# # + read line
# # + [ 2 -eq 1 ]
# # + [ -f set_event_pid ]
# # + echo
# # + [ -f set_ftrace_pid ]
# # + echo
# # + [ -f set_ftrace_notrace ]
# # + echo
# # + [ -f set_graph_function ]
# # + echo
# # + tee set_graph_function set_graph_notrace
# #=20
# # + [ -f stack_trace_filter ]
# # + echo
# # + [ -f kprobe_events ]
# # + echo
# # + [ -f uprobe_events ]
# # + echo
# # + [ -f synthetic_events ]
# # + echo
# # + [ -f snapshot ]
# # + echo 0
# # + [ -f options/pause-on-trace ]
# # + echo 1
# # + clear_trace
# # + echo
# # + enable_tracing
# # + echo 1
# # + . /opt/kselftest/ftrace/test.d/ftrace/func-filter-pid.tc
# # + do_function_fork=3D1
# # + do_funcgraph_proc=3D1
# # + [ ! -f options/function-fork ]
# # + [ ! -f options/funcgraph-proc ]
# # + read PID _
# # + [ 1 -eq 1 ]
# # + grep function-fork trace_options
# # + orig_value=3Dnofunction-fork
# # + [ 1 -eq 1 ]
# # + cat options/funcgraph-proc
# # + orig_value2=3D0
# # + echo 1
# # + do_test function
# # + TRACER=3Dfunction
# # + disable_tracing
# # + echo 0
# # + echo do_execve*
# # + echo kernel_clone
# # + echo 5190
# # + echo function
# # + [ 1 -eq 1 ]
# # + echo nofunction-fork
# # + enable_tracing
# # + echo 1
# # + yield
# # + ping 127.0.0.1 -c 1
# # ./ftracetest: 179: /opt/kselftest/ftrace/test.d/ftrace/func-filter-pid.=
tc: ping: not found
# # + sleep .001
# # + cat trace
# # + grep -v ^#
# # + grep 5190
# # + wc -l
# # + count_pid=3D2
# # + cat trace
# # + grep -v ^#
# # + grep -v 5190
# # + wc -l
# # + count_other=3D0
# # + [ 2 -eq 0 -o 0 -ne 0 ]
# # + disable_tracing
# # + echo 0
# # + clear_trace
# # + echo
# # + [ 1 -eq 0 ]
# # + echo function-fork
# # + enable_tracing
# # + echo 1
# # + yield
# # + ping 127.0.0.1 -c 1
# # ./ftracetest: 179: /opt/kselftest/ftrace/test.d/ftrace/func-filter-pid.=
tc: ping: not found
# # + sleep .001
# # + cat trace
# # + grep -v ^#
# # + grep 5190
# # + wc -l
# # + count_pid=3D2
# # + cat trace
# # + grep -v ^#
# # + grep -v 5190
# # + wc -l
# # + count_other=3D17
# # + [ 2 -eq 0 -o 17 -eq 0 ]
# # + grep -s function_graph available_tracers
# # function_graph wakeup_dl wakeup_rt wakeup preemptirqsoff preemptoff irq=
soff function nop
# # + do_test function_graph
# # + TRACER=3Dfunction_graph
# # + disable_tracing
# # + echo 0
# # + echo do_execve*
# # + echo kernel_clone
# # + echo 5190
# # + echo function_graph
# # + [ 1 -eq 1 ]
# # + echo nofunction-fork
# # + enable_tracing
# # + echo 1
# # + yield
# # + ping 127.0.0.1 -c 1
# # ./ftracetest: 179: /opt/kselftest/ftrace/test.d/ftrace/func-filter-pid.=
tc: ping: not found
# # + sleep .001
# # + cat trace
# # + grep -v ^#
# # + grep 5190
# # + wc -l
# # + count_pid=3D2
# # + cat trace
# # + grep -v ^#
# # + grep -v 5190
# # + wc -l
# # + count_other=3D3
# # + [ 2 -eq 0 -o 3 -ne 0 ]
# # + cat trace
# # # tracer: function_graph
# # #
# # # CPU  TASK/PID         DURATION                  FUNCTION CALLS
# # # |     |    |           |   |                     |   |   |   |
# # 0)  ftracet-5190  | ! 537.633 us  |  kernel_clone(); /* ret=3D0x1470 */
# #=20
# # 0)  ftracet-5190  | ! 508.253 us  |  kernel_clone(); /* ret=3D0x1471 */
# #=20
# # 0)  ftracet-5190  | ! 215.716 us  |  kernel_clone(); /* ret=3D0x1476 */
# #=20
# # 0)  ftracet-5190  | ! 493.890 us  |  kernel_clone(); /* ret=3D0x147b */
# #=20
# # + fail PID filtering not working?
# # + do_reset
# # + [ 1 -eq 1 ]
# # + echo nofunction-fork
# # + [ 1 -eq 1 ]
# # + echo 0
# # + echo PID filtering not working?
# # PID filtering not working?
# # + exit_fail
# # + exit 1

> > # # + cat trace
> > # # # tracer: function_graph
> > # # #
> > # # # CPU  TASK/PID         DURATION                  FUNCTION CALLS
> > # # # |     |    |           |   |                     |   |   |   |
> > # # 0) ftracet-12279  | ! 598.118 us  |  kernel_clone(); /* ret=3D0x301=
f */
> > # #=20
> > # # 0) ftracet-12279  | ! 492.539 us  |  kernel_clone(); /* ret=3D0x302=
0 */
> > # #=20
> > # # 0) ftracet-12279  | ! 231.104 us  |  kernel_clone(); /* ret=3D0x302=
5 */
> > # #=20
> > # # 0) ftracet-12279  | ! 555.566 us  |  kernel_clone(); /* ret=3D0x302=
a */
> > # #=20
> > # # + fail PID filtering not working?

> Also, is it possible to just enable function_graph tarcing and see if it
> adds these blank lines between events?

That'll take a bit more arranging, I'm running these tests as batch jobs
in CI infrastructure.  I'll try to have a look.  The only other test
that actually failed was:

# not ok 25 Checking dynamic events limitations

which isn't flagged as a regression (there's some other UNRESOLVED ones).

--fMVW2VbKSe/epRWr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmf5SjcACgkQJNaLcl1U
h9CPiAgAggkz82r8RoDubJVRud+x98LxPoIPna6IUbKevAQK+CGkWbmEWJX77awO
/A+HMoi4OUcfNX+SWPOSagloiNbMP9NfY2BEwvY+uGGvaQPYyA2IyVGWesGOyd70
jnYUksG90HY73ZBHm7QEBic1QvhOC8Q3xAfjW8hxk3MxPUxtooU+zKsD0m+zx4pt
yKf5BtqMMp0J9x4wFD3Nn13Blb2LidI9AIEC5iRNy8J5MOOUlo8wr0EG3lX3hFjd
DQPcWpfXMrDVwRhuT34pSC5OcSefbnQJFu2ABnUHGr353i6qXcJCLHuIaQ/3XREL
ZPTXEfC/Nis7fPWW4iDrZsM5LdtmJA==
=qupM
-----END PGP SIGNATURE-----

--fMVW2VbKSe/epRWr--

