Return-Path: <bpf+bounces-63695-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C29DB09AA2
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 06:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD32D1C45A6F
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 04:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2BE1DDA18;
	Fri, 18 Jul 2025 04:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhGOvFzb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7081317BBF;
	Fri, 18 Jul 2025 04:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752814265; cv=none; b=bCVRQ+sY/KN34EqsQ0hOSNm9P+GJxih4iRLEC4aiKlz9ndpGyTt+wrplJhn0Dtvrl/G5xJS6U9j1whYMLq0fXX5EvFbXMH4sSWrSDBhMncCSUxWYs6X2+LQxsHY8H5+/ms1RJeN2QX/h322CsDB8ZtE7cOSsV8iyt0FBBzvkXDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752814265; c=relaxed/simple;
	bh=WvOO/fsDfLtx7+vDyzxC+q0rPMbrzC09rOCjnUbd6gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=InXufYlpdqX7v71C/YUYoL6Qqb4bEUh8mw1uAxBDaGSS5LsT7FzDqr2vTwn54ojwwohxOnQlJnyjAUXwRxcJvslCUK79aRM/QsH8ialBGqcsoE3RxDuDd7xlw9B0HAtj9jTf3EXUQjNT42+Cjn0z8LC0WuPV6SaOuVp/1+Mzy4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhGOvFzb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30FADC4CEED;
	Fri, 18 Jul 2025 04:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752814264;
	bh=WvOO/fsDfLtx7+vDyzxC+q0rPMbrzC09rOCjnUbd6gw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UhGOvFzbr5xEoM+yH1C3g5f6bSiZthJtVwSfnqmbdxldgbmqMrG3XyYjbszvjEDQ3
	 NczbV8Zy3/PPSw76+zeKhK4TbK82UeMbg+hMBMTfimLavxUW148bvwtwJxZTzYk28e
	 if2ms+e61O0t9hXd9wozYhsVmgY1mY2RzH5EvRaoZiRoDMOXyuTPnz4hF/EmEvg/Ue
	 kv+ibgb4hU0w7obxZ6MJNMVqZZ/eC+NaVcezGR8ImMrvwlv+G+BrQEGrpT+zVOz+bQ
	 aco28xSgELEu5GDQlj6y+26TWjb5qD9T1jvFSQPoAxho+kwqb4Zj/oyfJD9QZNe+tX
	 StXhonthzV7yw==
Date: Thu, 17 Jul 2025 21:51:01 -0700
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
Subject: Re: [RFC PATCH v1 06/16] unwind_user: Enable archs that define CFA =
 SP_callsite + offset
Message-ID: <sotffno5desd3ajyjd42rq52yrtztddwjbbh3xpa6v7fb63v36@bwoq4s7j5why>
References: <20250710163522.3195293-1-jremus@linux.ibm.com>
 <20250710163522.3195293-7-jremus@linux.ibm.com>
 <qoiocmdhuuaox5v5ig2ui67qbuxkvzl4z3ft4gdp7p3c4b4zfq@trjthmmculkf>
 <ae46c02a-d871-4b26-97f4-bd82361ab8bc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ae46c02a-d871-4b26-97f4-bd82361ab8bc@linux.ibm.com>

On Thu, Jul 17, 2025 at 11:27:45AM +0200, Jens Remus wrote:
> On 16.07.2025 23:32, Josh Poimboeuf wrote:
> > On Thu, Jul 10, 2025 at 06:35:12PM +0200, Jens Remus wrote:
> >> Most architectures define their CFA as the value of the stack pointer
> >> (SP) at the call site in the previous frame, as suggested by the DWARF
> >> standard:
> >>
> >>   CFA = <SP at call site>
> >>
> >> Enable unwinding of user space for architectures, such as s390, which
> >> define their CFA as the value of the SP at the call site in the previous
> >> frame with an offset:
> >>
> >>   CFA = <SP at call site> + offset
> > 
> > This is a bit confusing, as the comment and code define it as
> > 
> >     SP = CFA + offset
> > 
> > Should the commit log be updated to match that?
> 
> I agree that the commit message is confusing. Would it help if I replace
> it with the following:
> 
> Most architectures define their CFA as the value of the stack pointer
> (SP) at the call site in the previous frame, as suggested by the DWARF
> standard.  Therefore the SP at call site can be unwound using an
> implicitly assumed value offset from CFA rule with an offset of zero:
> 
>   .cfi_val_offset <SP>, 0
> 
> As a result the SP at call site computes as follows:
> 
>   SP = CFA
> 
> Enable unwinding of user space for architectures, such as s390, which
> define their CFA as the value of the SP at the call site in the previous
> frame with an offset.  Do so by enabling architectures to override the
> default SP value offset from CFA of zero with an architecture-specific
> one:
> 
>   .cfi_val_offset <SP>, offset
>   
> So that the SP at call site computes as follows:
> 
>   SP = CFA + offset

Looks good to me, thanks!

> >> +++ b/arch/x86/include/asm/unwind_user.h
> >> @@ -8,6 +8,7 @@
> >>  	.cfa_off	= (s32)sizeof(long) *  2,				\
> >>  	.ra_off		= (s32)sizeof(long) * -1,				\
> >>  	.fp_off		= (s32)sizeof(long) * -2,				\
> >> +	.sp_val_off	= (s32)0,						\
> > 
> > IIUC, this is similar to ra_off and fp_off in that its an offset from
> > the CFA.  Can we call it "sp_off"?
> 
> My intent was to use the terminology from DWARF CFI (i.e. "offset(N)"
> and "val_offset(N)") and the related assembler CFI directives:
> 
>   .cfi_offset register, offset:  Previous value of register is saved at
>                                  offset from CFA.
> 
>   .cfi_val_offset register, offset:  Previous value of register is
>                                      CFA + offset. 

The distinction between "cfi_offset" and "cfi_val_offset" is confusing,
unless one already happens to know CFI syntax (not likely for us kernel
developers).

We don't need to match the DWARF CFI directive naming.  Let's instead
optimize for readability.

I think "sp_off" is fine here, its semantics are similar to the existing
cfa_off field.

The semantics of ra_off and fp_off are different, but those are getting
removed in favor of nested structs in a later patch anyway.

-- 
Josh

