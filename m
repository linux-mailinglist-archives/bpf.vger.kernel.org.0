Return-Path: <bpf+bounces-56782-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 906BFA9DABD
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 14:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55A007A88FD
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 12:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18B7610D;
	Sat, 26 Apr 2025 12:36:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAD14A02;
	Sat, 26 Apr 2025 12:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745670998; cv=none; b=XJQaXYrs41rGIaeexkN6CKEofyTvnJ755kxqd/Xv3clT9jcJZn8RP653ytexf7UI5UZPT2IfokzBmuXd1BxB/fKzXyMf0x0OwtcwSGX2wGESieEf9MgNjyzM7aiXxe5/QW8svsrUMSwlQk/UkssQp8MwcH/KKLaHl+Ob06k78TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745670998; c=relaxed/simple;
	bh=c1/6bhetYzynX5wt9IYS4FQqt0Cw7IxKGHtBcV9vP/c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=udvaH+2x1jchdh30mDoC/uxzEHtxWkelM/i/iOFhqgnoS7p1kR80klcqoCtbapmRJoShubEuAIPgBEwgsKb+feKBhuxeOxUdLT7UXvBzNCLjXPxi3y3ETWU/lnvNFjcP1QF6Of1yFFBjiHaz6hGPKXczThUdAk+lKAYzIsJvxOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29D9CC4CEE2;
	Sat, 26 Apr 2025 12:36:36 +0000 (UTC)
Date: Sat, 26 Apr 2025 08:36:34 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Linus
 Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>,
 x86@kernel.org, bpf@vger.kernel.org, Tejun Heo <tj@kernel.org>, Julia
 Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
 cocci@inria.fr
Subject: Re: [RFC][PATCH 1/2] kthread: Add is_user_thread() and
 is_kernel_thread() helper functions
Message-ID: <20250426083634.25897a33@batman.local.home>
In-Reply-To: <202504251601.5D29BF8F01@keescook>
References: <20250425204120.639530125@goodmis.org>
	<20250425204313.616425861@goodmis.org>
	<202504251601.5D29BF8F01@keescook>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Apr 2025 16:03:16 -0700
Kees Cook <kees@kernel.org> wrote:

> > +static __always_inline bool is_kernel_thread(struct task_struct *task)
> > +{
> > +	return task->flags & PF_KTHREAD;  
> 
> nit: maybe do explicit type conversion:
> 
> 	return !!(task->flags & PF_KTHREAD);
> 
> but that's just a style issue, really.

I may use Boris's suggestion (which I thought of doing originally too)
and have this return:

	return !is_user_thread(task);


> 
> Reviewed-by: Kees Cook <kees@kernel.org>

Thanks.

> 
> Thank you for not using current->mm -- KUnit, live patching, etc, all
> use current->mm but are kthreads. :)

Yeah, Peter was stressing this.

-- Steve

