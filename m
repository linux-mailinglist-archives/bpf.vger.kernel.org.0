Return-Path: <bpf+bounces-56755-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA5CA9D606
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 01:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF60A466519
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 23:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6C7296D34;
	Fri, 25 Apr 2025 23:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7W5bR60"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F634635;
	Fri, 25 Apr 2025 23:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745622552; cv=none; b=Ket0yqsFLXxTZBCaD/ZvA7bbWu9c9sZdXVddFjqB+EK/EjTn+tUIxgIPlu0WCMhe6XIzIk4rSP5qDoZlVwzalcpSVRPD3TgZXfKWbyeWIuDxNXTX4VJqYr/G8DDNKZUmYLdODes1eNNHVcP8IGLdxT3FJQ12TTIoBWQBqfy4r1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745622552; c=relaxed/simple;
	bh=Z8WeYorZeDjDZWfM4rFlcel7nAPZCgpzkVZIFGzpr9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nBg0FZt6jmkibKM5IVPPdPts+BdvrxRtIAOO5KcAyc3qRX/i1/JSYdXyiYZm5OVoLZQduQbOYQJ+GxF1H9tW8asrTEUDiBO40ToSW66IycEGMufkA4VgRySQZkkTS2W7ovHp0Y7dOXsccD4dqfEf9gtg5I0sCPaQB6BliKQLlVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7W5bR60; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 175CFC4CEE4;
	Fri, 25 Apr 2025 23:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745622552;
	bh=Z8WeYorZeDjDZWfM4rFlcel7nAPZCgpzkVZIFGzpr9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i7W5bR60HZ/wlLofVNshaQsLtdPMd2kNRArwI3YjlQG2/GjWTmHTy9Oqb82F38LPw
	 LN8HWxdbRwPcrSaZ5KKtjpoQn7MKsPRjwyGASpJqObVMxLGDswnQlmb+a8irH2Tgh7
	 0CuLvUfRE9Ho0G6vNYyZ1lQRwLW0RvGqpFtyer51he6xbxJz102/s3fGsPRBxvoqxk
	 Rqp9dTVIoFsxMySu2tDpGSymU3emjg00eMgtXcymMP3QV8N3FhJHyjSPqmcNFbr+a9
	 EUTS4+1ILs6TYsuaqjIjgls1Wsz5SVLJz2Qmn4QdlHHTZBp2ke9T0xKDkXtx90h0Cu
	 2DOH+UwbEjnsg==
Date: Fri, 25 Apr 2025 16:09:08 -0700
From: Kees Cook <kees@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>, x86@kernel.org, bpf@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr
Subject: Re: [RFC][PATCH 2/2] treewide: Have the task->flags & PF_KTHREAD
 check use the helper functions
Message-ID: <202504251558.AA50716@keescook>
References: <20250425204120.639530125@goodmis.org>
 <20250425204313.784243618@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425204313.784243618@goodmis.org>

On Fri, Apr 25, 2025 at 04:41:22PM -0400, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Getting the check if a task is a kernel thread or a user thread can be
> error prone as it's not easy to see the difference.
> 
> 	if (!(task->flags & PF_KTHREAD))
> 
> Is not immediately obvious that it's checking for a user thread.
> 
> 	if (is_user_thread(task))
> 
> Is much easier to review, as it is obvious that it is checking if the task
> is a user thread.
> 
> Using a coccinelle script, convert these checks over to using either
> is_user_thread() or is_kernel_thread().
> 
>   $ cat kthread.cocci
>   @@
>   identifier task;
>   @@
>   -	!(task->flags & PF_KTHREAD)
>   +	is_user_thread(task)
>   @@
>   identifier task;
>   @@
>   -	(task->flags & PF_KTHREAD) == 0
>   +	is_user_thread(task)
>   @@
>   identifier task;
>   @@
>   -	(task->flags & PF_KTHREAD) != 0
>   +	is_kernel_thread(task)
>   @@
>   identifier task;
>   @@
>   -	task->flags & PF_KTHREAD
>   +	is_kernel_thread(task)
> 
>   $ spatch --dir --include-headers kthread.cocci . > /tmp/t.patch
>   $ patch -p1 < /tmp/t.patch
> 
> Make sure to undo the conversion of the helper functions themselves!
> 
>   $ git show include/linux/sched.h | patch -p1 -R

FYI, the "file in" test can be helpful. I use it to exclude tools and
samples regularly, and *I think* it would work for excluding individual
files too:

@name_of_rule depends !(file in "tools") && !(file in "samples")@

I've been collecting random notes like this here:

https://github.com/kees/kernel-tools/tree/trunk/coccinelle

>  tools/sched_ext/scx_central.bpf.c          |  2 +-
>  tools/sched_ext/scx_flatcg.bpf.c           |  2 +-
>  tools/sched_ext/scx_qmap.bpf.c             |  2 +-

I think these are fine. The Makefile is pulling in standard kbuild
Makefiles, so I think the correct include directories (outside of
tools/) are being used.

But yeah, easy mechanical change and a readability improvement. :)

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

