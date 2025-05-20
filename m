Return-Path: <bpf+bounces-58625-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B862ABE803
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 01:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAE634C5B80
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 23:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F9F25EF96;
	Tue, 20 May 2025 23:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpceNWV/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D9D25CC73;
	Tue, 20 May 2025 23:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747783570; cv=none; b=f/UXKYUJ5+2S1Es7+VeshTQj5Ivxm6gNirms1pGimo1i5IZuBVX5GDo9n1ZRtIKsPbFSbA9qg28T4laRL/fue3V4ZL/oDR9Qhl9EJf0Yv8gcF1NTmalRmw40F4+GdN+0xjB/GGaTjO5aVpEpxb1FKNrbyI2XCxO84qeuAoYB8lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747783570; c=relaxed/simple;
	bh=E1ZGX7mjtvtFpechp+ozrWQKmmJfrP8auppqbj8TNPk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=SCbJObsJe1pTIkg8O1TanLXfI9pFBKUJBs8Q1Z/DrAsmnv72r8D493En17OdPFqDbHoZ+B2okgXH8d4nHcwK5iXgYkCKc32hyggyWF4zP2Lbm3ZMO1HBBSwvK4VfZ8VYigpchX67BfkeZHR9k3iszuAjyviv+7qeeMTiHV++apc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpceNWV/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 345C0C4CEE9;
	Tue, 20 May 2025 23:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747783569;
	bh=E1ZGX7mjtvtFpechp+ozrWQKmmJfrP8auppqbj8TNPk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RpceNWV/vzujP6ckRNkuYvJlrjIqYVzZxmLVsbhekdpSUnuZ0kUTlWW3nnCMcfUfs
	 JqZXpS1NytxfFT3oSFjWHiIuAQ0j/On7uB3f8y+MJCAO85FwR8ChlCDpF9QMylCuVR
	 Om+IeDiQnpW/MEBYklLS6S3qVgTVAIApmpLROdC4QidlpQG5u8y8TC5CLb6mGmr7Hi
	 QrjbZ//CIx8ykX3mrrhsOUAXlPZrljWz/rVdxMMQgthdtmFFLdyYadUF5lZSOGngDZ
	 pyF10aT05VMWfTYj2g6SI0OqnFbg3DMKwVo1saN3SwAdj2oouv76SehoVEuBmoxciZ
	 hFDqjkqpYX6ow==
Date: Wed, 21 May 2025 08:26:05 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH v9 00/13] unwind_user: x86: Deferred unwinding
 infrastructure
Message-Id: <20250521082605.b4bd632ef1312778ea51dd71@kernel.org>
In-Reply-To: <aCfMzJ-zN0JKKTjO@google.com>
References: <20250513223435.636200356@goodmis.org>
	<20250514132720.6b16880c@gandalf.local.home>
	<aCfMzJ-zN0JKKTjO@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 May 2025 16:39:56 -0700
Namhyung Kim <namhyung@kernel.org> wrote:

> Hi Steve,
> 
> On Wed, May 14, 2025 at 01:27:20PM -0400, Steven Rostedt wrote:
> > On Tue, 13 May 2025 18:34:35 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > This has modifications in x86 and I would like it to go through the x86
> > > tree. Preferably it can go into this merge window so we can focus on getting
> > > perf and ftrace to work on top of this.
> > 
> > I think it may be best for me to remove the two x86 specific patches, and
> > rebuild the ftrace work on top of it. For testing, I'll just keep those two
> > patches in my tree locally, but then I can get this moving for this merge
> > window.
> 
> Maybe I asked this before but I don't remember if I got the answer. :)
> How does it handle task exits as it won't go to userspace?  I guess it'll
> lose user callstacks for exit syscalls and other termination paths.
> 
> Similarly, it will miss user callstacks in the samples at the end of
> profiling if the target tasks remain in the kernel (or they sleep).
> It looks like a fundamental limitation of the deferred callchains.

Can we use a hybrid approach for this case?
It might be more balanced (from the performance point of view) to save
the full stack in a classic way only in this case, rather than faulting
on process exit or doing file access just to load the sframe.

Thanks,

> 
> Thanks,
> Namhyung
> 
> > 
> > Next merge window, we can spend more time on getting the perf API working
> > properly.
> > 
> > -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

