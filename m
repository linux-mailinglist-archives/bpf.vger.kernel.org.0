Return-Path: <bpf+bounces-56754-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A381EA9D600
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 01:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09CB09C0C0D
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 23:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A51296D2A;
	Fri, 25 Apr 2025 23:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vr3vLE2q"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B1D296D04;
	Fri, 25 Apr 2025 23:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745622200; cv=none; b=pFtaoo46OpnLIALnTJ3A9XdMNLoErrfhmPEQGyu/0RV944i7rVQ7/wf6tVb8t6fomJZt4YPuI3WmqfMYkNTgZGNWB54vmQNShWQ646/qXe19GrdSUHP8rEZQkKB8oHyj+CdhLH8PT/yISf3WsdQC3T7xnUNTOxuaKIXZRhvg0Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745622200; c=relaxed/simple;
	bh=HPDTCVI0kaASK1Ubw5yHoaNdg3VSMyENwPAPqkgC0f4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eGB7hnr5C5RQD4/EGJTt5Qjk7RtPSbImVbjA2K+lC7F0tH/Ho8lOc5qUNzayomtOiCQvztCXlWeCZ4cbjoq86xwrv2lCn4wYmQCdcrOB+ZjCGmf9VIW+BaZAJ6vRMqI7b2Vj3E2vDCQ7JTCwJ8+hdsSXVpXdnTna8cKXhcc0CsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vr3vLE2q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3023C4CEE4;
	Fri, 25 Apr 2025 23:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745622199;
	bh=HPDTCVI0kaASK1Ubw5yHoaNdg3VSMyENwPAPqkgC0f4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vr3vLE2qnPJODv0tf3Z77FzuM2uGoCo443ocJY+vPMmlJzvh6vF6/2VHrbZmoXapK
	 P3mmCYzQlpjFIvS4pvUlMFYT47FT6svjqSVvNUiqutFQ57avrXyGUVuW2SaU6nRb/P
	 ZdMOsGr3/13JNJDYcSHw6eji+aQjahvQbodbqp2d2VP5x7aFPdKpxOQvzPvk4jZs4B
	 GvFbNYz00NBIbUnXEuFZL7qzlMLM6NzfCfB8OTJlKH+7iEHnvX3dpCT4Dsi3I9rnJn
	 hiXJT4S5ibqFYcd5RuWy1nIiZbiwbTBBH9VgSi+CP8MB8LUyv9etCQG+f39eYyk5f9
	 E0OGorAST+WhQ==
Date: Fri, 25 Apr 2025 16:03:16 -0700
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
Subject: Re: [RFC][PATCH 1/2] kthread: Add is_user_thread() and
 is_kernel_thread() helper functions
Message-ID: <202504251601.5D29BF8F01@keescook>
References: <20250425204120.639530125@goodmis.org>
 <20250425204313.616425861@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425204313.616425861@goodmis.org>

On Fri, Apr 25, 2025 at 04:41:21PM -0400, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> In order to know if a task is a user thread or a kernel thread it is
> recommended to test the task flags for PF_KTHREAD. The old way was to
> check if the task mm pointer is NULL.
> 
> It is an easy mistake to not test the flag correctly, as:
> 
> 	if (!(task->flag & PF_KTHREAD))
> 
> Is not immediately obvious that it's testing for a user thread.
> 
> Add helper functions:
> 
>   is_user_thread()
>   is_kernel_thread()
> 
> that can make seeing what is being tested for much more obvious:
> 
> 	if (is_user_thread(task))
> 
> Link: https://lore.kernel.org/all/20250425133416.63d3e3b8@gandalf.local.home/
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  include/linux/sched.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index f96ac1982893..823f38b0fd3e 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1785,6 +1785,16 @@ static __always_inline bool is_percpu_thread(void)
>  #endif
>  }
>  
> +static __always_inline bool is_user_thread(struct task_struct *task)
> +{
> +	return !(task->flags & PF_KTHREAD);
> +}
> +
> +static __always_inline bool is_kernel_thread(struct task_struct *task)
> +{
> +	return task->flags & PF_KTHREAD;

nit: maybe do explicit type conversion:

	return !!(task->flags & PF_KTHREAD);

but that's just a style issue, really.

Reviewed-by: Kees Cook <kees@kernel.org>

Thank you for not using current->mm -- KUnit, live patching, etc, all
use current->mm but are kthreads. :)

-- 
Kees Cook

