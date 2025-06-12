Return-Path: <bpf+bounces-60535-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6C4AD7E2D
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 00:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C7883B3695
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 22:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955E42DECB4;
	Thu, 12 Jun 2025 22:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQyL3YmH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1530921B9C5;
	Thu, 12 Jun 2025 22:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749765730; cv=none; b=TthvEJiAhb+jIe1lXY9VgJldVFIP8Z6M885eoZhOuBMWrZER5AaJ7u53EKNkhs6gV+0FwcKqyllGdCEp+P0AKPcHcQKY6Exq3y7K6ixYAdFzfVSx0PofD56xn7kFbJyJB6mSUcJlb8CSB/qS0+RxUd3iWpsCXLYk9gx+n4qRQ2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749765730; c=relaxed/simple;
	bh=FSByyf8m0UgAvd7O4m9MAASg5nLIbzx8Gm82j24ErLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VL319ZXvwsYk6fAPLWQGEIGsMz7DSwFrcywZeV5c7CpyDNLpELo8GIrkAlLxdKc8QVhBfIwCeNZ7RTlyiSXuEjowc2d1NRbfVGYo/pCV0Dd6/53CcsnXYSGSHe4TZ37E3mGRmgiQMV/t5VuvXCgSjJpNGgE6uxPzv6CmAZ0CFrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQyL3YmH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E3A5C4CEED;
	Thu, 12 Jun 2025 22:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749765729;
	bh=FSByyf8m0UgAvd7O4m9MAASg5nLIbzx8Gm82j24ErLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iQyL3YmHYPx9iMTZ/0mR8JLnfgh6jwPeEsWhpHQUXVS9fFTvMXdZCFpjlgJs2Vuc/
	 46XTCnSt4fq0L7Au4pIrnBofvMw4nNz7ONnm5PGsqHzCahUKK/GKNfHsx7XAvChEo9
	 khEBKpLa+1p92ToFsdXS6qUYiL5MSCBc78g8AEa8w/dFED850bc814aiq4C79Q+ueb
	 poeRRbgsJRQ2D/h0K0yeRs7MqnK9vEqgWFd+ykcbUThQcvKpzo3gcWbUmUHhmEl1ni
	 CdzhLo5oCJfVo/Ik7CJzmLjxMbwAnB4r4fkQT1QiAZ/q/sKEULDZvVp7SulmMk8ma/
	 IEkvS9RGPCH0g==
Date: Thu, 12 Jun 2025 15:02:05 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, 
	"Jose E. Marchesi" <jemarch@gnu.org>, Beau Belgrave <beaub@linux.microsoft.com>, 
	Jens Remus <jremus@linux.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v10 00/14] unwind_user: x86: Deferred unwinding
 infrastructure
Message-ID: <ldnmzsofhpy7rxk7rslgs5mevep7s22ltaqd7pxuoshs67flvm@cakolwpjdkwm>
References: <20250611005421.144238328@goodmis.org>
 <CAEf4BzZ9-wScwgYAc5ubEttZyZYUfkuAhr3dYiaqoVYu=yWKog@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZ9-wScwgYAc5ubEttZyZYUfkuAhr3dYiaqoVYu=yWKog@mail.gmail.com>

On Thu, Jun 12, 2025 at 02:44:18PM -0700, Andrii Nakryiko wrote:
> On Tue, Jun 10, 2025 at 6:03 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> >
> > Hi Peter and Ingo,
> >
> > This is the first patch series of a set that will make it possible to be able
> > to use SFrames[1] in the Linux kernel. A quick recap of the motivation for
> > doing this.
> >
> > Currently the only way to get a user space stack trace from a stack
> > walk (and not just copying large amount of user stack into the kernel
> > ring buffer) is to use frame pointers. This has a few issues. The biggest
> > one is that compiling frame pointers into every application and library
> > has been shown to cause performance overhead.
> >
> > Another issue is that the format of the frames may not always be consistent
> > between different compilers and some architectures (s390) has no defined
> > format to do a reliable stack walk. The only way to perform user space
> > profiling on these architectures is to copy the user stack into the kernel
> > buffer.
> >
> > SFrames is now supported in gcc binutils and soon will also be supported
> > by LLVM. SFrames acts more like ORC, and lives in the ELF executable
> 
> Is there any upstream PR or discussion for SFrames support in LLVM to
> keep track of?

https://github.com/llvm/llvm-project/issues/64449

-- 
Josh

