Return-Path: <bpf+bounces-63698-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0F4B09AE4
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 07:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA3AF7B2F6F
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 05:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7090D1E25F2;
	Fri, 18 Jul 2025 05:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="txoeRoOT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56CB10E3;
	Fri, 18 Jul 2025 05:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752815998; cv=none; b=LS+eWUJDqCALw4yc3l9RyKptPns24inK2h9BWh1WKKQYQNma1zVPKAVHB5BT8sZ/uBwZFrwYXARxAMRPsT7xjMX/p0ZUu0VexbN+3VhP9FILIMrAHV/xwKG9zx2DV3gNxEKPM1yGXTTsYkKqSmhKRPX7AYZM4AezeCwt6p8IugM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752815998; c=relaxed/simple;
	bh=H14cqUUN7unSm20jVmVhYHtI/P1gCTCcPHJlABdL4d8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVcpfPtXC6OlDP6whMV57DxBMbGdBEtEm/eX6zBiOfnplion+AVFjSavqfC0nNgBLz5XxofD/RSn5840J6qTOA/pzOPLU/wkxXv3dacb09mhLnECAj5oAFjVE2Wa3WvKl9XDvwUMeTcIfqeSKwwarX6O4UaWRjMU8VG3nWXlPsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=txoeRoOT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EAD4C4CEED;
	Fri, 18 Jul 2025 05:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752815997;
	bh=H14cqUUN7unSm20jVmVhYHtI/P1gCTCcPHJlABdL4d8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=txoeRoOTONFieFEUh6BVw8ZZYgIIS58fsNCROBBgTXvWeq7ijEOwbLNVrK6mzI5nT
	 x5AU8tG9FI/Mv8Rjaja4T6virr5QoJk22dEWClO8NpdcHkGT+VTwXPs8CcmIn5MO4J
	 k7jhGoU7Rbn9sIK+XCRS9Ejx09Bmw3CAYBBL3aD7zY+aCu1sfptTlFk9OOrpG46HMl
	 2pZtreoCS317iVHidBmtxjZaNgK91Ew+CLku42Nl+Mt7dLQFSGhY3y84I0z+TsHFeY
	 +PrexBv6faHkfWdQNAYJW8L/Ra/vd5YnN31b99TZXqKhh5K/08srSBUeHVstlpQh+K
	 d9kgHxUpET9mw==
Date: Thu, 17 Jul 2025 22:19:54 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, x86@kernel.org, Steven Rostedt <rostedt@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Indu Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, 
	Beau Belgrave <beaub@linux.microsoft.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, 
	Florian Weimer <fweimer@redhat.com>, Sam James <sam@gentoo.org>
Subject: Re: [RFC PATCH v1 12/16] unwind_user/backchain: Introduce back chain
 user space unwinding
Message-ID: <ddwondzj74rr3fgvsdnkch7trrcwltasb236hvvx5tnywf2lhu@vo47rcoyu2nc>
References: <20250710163522.3195293-1-jremus@linux.ibm.com>
 <20250710163522.3195293-13-jremus@linux.ibm.com>
 <a4dd5okskro2h45zmqgg3etj6uwici2hoop2uaf6iqrlaej7yh@xlduwjqke4ec>
 <63665c54-db44-452f-b321-1162ff6c3fe4@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <63665c54-db44-452f-b321-1162ff6c3fe4@linux.ibm.com>

On Thu, Jul 17, 2025 at 02:20:12PM +0200, Jens Remus wrote:
> >> +done_backchain:
> >>  	state->topmost = false;
> >>  	return 0;
> > 
> > This feels very grafted on, is there not some way to make it more
> > generic, i.e., to just work with CONFIG_HAVE_UNWIND_USER_FP?
> 
> I agree.  It could probably be made to compute the cfa_off and ra.offset
> or ra.regnum.  Let me explore that, provided there would be any acceptance
> for unwind user backchain at all. Note that Power is using backchain as
> well, so they may want to build on that as well.
> 
> > Also, if distros aren't even compiling with -mbackchain, I wonder if we
> > can just not do this altogether :-)
> 
> My original intent was to use unwind user's for_each_user_frame() to
> replace the exiting stack tracing logic in arch_stack_walk_user_common()
> in arch/s390/kernel/stacktrace.c, which currently supports backchain.
> Given that for_each_user_frame() was made private in the latest unwind
> user series version hinders me.  The use was also low, because the
> currentl arch_stack_walk_user_common() implementation does not support
> page faults, so that the attempt to use unwind user sframe would always
> fail and fallback to unwind user backchain.  My hope was that somebody
> with more Kernel skills could give me a few hints at how it could be
> made to support deferred unwind. :-)

I believe stack_trace_save_user() is only used by ftrace, and that will
no longer be needed once ftrace starts using unwind_user.

Maybe Heiko knows if that backchain user stacktrace code has any users?

If distros aren't building with -mbackchain, maybe backchain support can
be considered obsoleted by sframe, and we can get away with not
implementing it.

-- 
Josh

