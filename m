Return-Path: <bpf+bounces-56756-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 159EFA9D614
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 01:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EF179C5F46
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 23:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D352973A2;
	Fri, 25 Apr 2025 23:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AD0NmSEu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A5C217F35;
	Fri, 25 Apr 2025 23:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745622890; cv=none; b=nm+8412F4qtu1x3wPmbf9qkvyb5HlbGH1OKgfxt/aOFSRhaJtDvmCqXkf3vJkkonEbT421x1XWLMYS92RaIViu8vysycsSQPmbb1o4ToMRqTVHqE07cnefqPEkNCos+Scjn8rFu9rynLbib6uJgKGaFAo16CE/9JCTyGlXIga1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745622890; c=relaxed/simple;
	bh=JdXp4QcNii7lr5YrjbRnmJUEV8mHsfSY4nFGWJ71+NQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=gLkk4Y4Y47W73HfombKYZUY+KkFuD2jxKd8nYR9OL1gISGmZV9cnREpufHpKfc4fE9EmTiD7+cayE/BzfTYaefN5S3NIRHcyUIG1n2cXTfP1GG7ps5sJlWFWN6Z3IDl7MgrSXyhuDzEZXXOlTObLpWBahyqoXOKUdMXIFFB9BSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AD0NmSEu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0065C4CEE4;
	Fri, 25 Apr 2025 23:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1745622890;
	bh=JdXp4QcNii7lr5YrjbRnmJUEV8mHsfSY4nFGWJ71+NQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AD0NmSEuOcbX0jToQUQgnEBLVMcv59zc8nxbeG9UIvdY2QuN6WYU9hSpboVz8/5hv
	 7NGsY90wMAfaeGrIBZPcv3miNiZ77QMGY1GqLAFcXA0tgV26W8xlPy5MXHtEfbfJSA
	 ThxdiPZVIOEnthGQwZYB5fwRTjg5n7ThAPgET2nU=
Date: Fri, 25 Apr 2025 16:14:49 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra
 <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>,
 Ingo Molnar <mingo@redhat.com>, x86@kernel.org, Kees Cook
 <kees@kernel.org>, bpf@vger.kernel.org, Tejun Heo <tj@kernel.org>, Julia
 Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
 cocci@inria.fr
Subject: Re: [RFC][PATCH 0/2] Add is_user_thread() and is_kernel_thread()
 helper functions
Message-Id: <20250425161449.7a2516b3fe0d5de3e2d2b677@linux-foundation.org>
In-Reply-To: <20250425204120.639530125@goodmis.org>
References: <20250425204120.639530125@goodmis.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Apr 2025 16:41:20 -0400 Steven Rostedt <rostedt@goodmis.org> wrote:

> While working on the deferred stacktrace code, Peter Zijlstra told
> me to use task->flags & PF_KTHREAD instead of checking task->mm for NULL.
> This seemed reasonable, but while working on it, as there were several
> places that check if the task is a kernel thread and other places that
> check if the task is a user space thread I found it a bit confusing
> when looking at both:
> 
> 	if (task->flags & PF_KTHREAD)
> and
> 	if (!(task->flags & PF_KTHREAD))
> 
> Where I mixed them up sometimes, and checked for a user space thread when I
> really wanted to check for a kernel thread. I found these mistakes before
> sending out my patches, but going back and reviewing the code, I always had
> to stop and spend a few unnecessary seconds making sure the check was
> testing that flag correctly.
> 
> To make this a bit more obvious, I introduced two helper functions:
> 
> 	is_user_thread(task)
> 	is_kernel_thread(task)
> 
> which simply test the flag for you. Thus, seeing:
> 
> 	if (is_user_thread(task))
> or
> 	if (is_kernel_thread(task))
> 
> it was very obvious to which test you wanted to make.

Seems sensible.  Please consider renaming PF_KTHREAD in order to break
missed conversion sites.


