Return-Path: <bpf+bounces-45634-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3509D9D5F
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 19:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83CF9164B3B
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 18:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257F21DDA3F;
	Tue, 26 Nov 2024 18:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VpDxYPfc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922961DDC05;
	Tue, 26 Nov 2024 18:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732645790; cv=none; b=NomFU4u1hPsrfzXTo9i3+uZLdeZGjtD6lZABJ2lNM5MCIuw8yC2g1kNcR4bJjgNOdudn8TwJwCOirLTafjz2qMyn9u3OuE6PtJYCiQ7OJx/TKim0pTQxKjszAjXii08JtosoivKUL2b3h369RRfzsBj50diPeIeDAa8uEuoywjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732645790; c=relaxed/simple;
	bh=iohwLySxzBUL3SHrHutQ/bJn3BNIDjL9Rfaikvvg65s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4UwQDqWg0h/wmtlJGsKv0q5ZlzzFLEENNU8pgRQz7wEh7lsOeElq9KgU7BX4HJOx8sk/0/3JHjqvRRhZMiEgVK1WggbaM5fkCJaVqChYye6UiBFOw3nFc2MDeodNpaWqY5cN4AWn/pznJEbfqCr2d3moPKgX3Frg6Yc3aFek/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VpDxYPfc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA42C4CECF;
	Tue, 26 Nov 2024 18:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732645790;
	bh=iohwLySxzBUL3SHrHutQ/bJn3BNIDjL9Rfaikvvg65s=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=VpDxYPfcaGkbEahFxItT6WIbWqLnne8BVmW8rybYDAoFWfuKhaJjWBpFfsCJVDent
	 GdD1PPvC4pvXERY1NuVt68g4B56AVIiEFw4pVZ0cSUvI+B91+idNcv8jcpeK2+RvrV
	 Dk9/bsshxQI3ax37Q8gKNdgBtQuQjkSidNm4e0qP1Jbrex3lQLWSwzsRv24VojO0bR
	 ChgtEwxve5K6RaYB17wIU/53Kx4yNp4x63teJZdxZhFGpGReDJayCiseQK1oXzDLG6
	 uMC0KjDPY0gWGHiZmo8Wg1WFHFu6Z9pq/pzPdWpeZRbsyNdI0pUItrDmn6Dj6MAg6+
	 +E/cw7WxywJRw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A7C18CE0EA5; Tue, 26 Nov 2024 10:29:49 -0800 (PST)
Date: Tue, 26 Nov 2024 10:29:49 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Michael Jeanson <mjeanson@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org,
	Joel Fernandes <joel@joelfernandes.org>,
	Jordan Rife <jrife@google.com>, linux-trace-kernel@vger.kernel.org
Subject: Re: [for-next][PATCH 4/6] rcupdate_trace: Define rcu_tasks_trace
 lock guard
Message-ID: <95a1c581-0107-4d6d-a751-565add025b91@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20241124234940.017394686@goodmis.org>
 <20241124235019.106333158@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241124235019.106333158@goodmis.org>

On Sun, Nov 24, 2024 at 06:49:44PM -0500, Steven Rostedt wrote:
> From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> 
> Define a rcu_tasks_trace lock guard for use by the syscall enter/exit
> tracepoints.
> 
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Michael Jeanson <mjeanson@efficios.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: bpf@vger.kernel.org
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: Jordan Rife <jrife@google.com>
> Cc: linux-trace-kernel@vger.kernel.org
> Link: https://lore.kernel.org/20241123153031.2884933-4-mathieu.desnoyers@efficios.com
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  include/linux/rcupdate_trace.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/rcupdate_trace.h b/include/linux/rcupdate_trace.h
> index eda493200663..e6c44eb428ab 100644
> --- a/include/linux/rcupdate_trace.h
> +++ b/include/linux/rcupdate_trace.h
> @@ -10,6 +10,7 @@
>  
>  #include <linux/sched.h>
>  #include <linux/rcupdate.h>
> +#include <linux/cleanup.h>
>  
>  extern struct lockdep_map rcu_trace_lock_map;
>  
> @@ -98,4 +99,8 @@ static inline void rcu_read_lock_trace(void) { BUG(); }
>  static inline void rcu_read_unlock_trace(void) { BUG(); }
>  #endif /* #ifdef CONFIG_TASKS_TRACE_RCU */
>  
> +DEFINE_LOCK_GUARD_0(rcu_tasks_trace,
> +	rcu_read_lock_trace(),
> +	rcu_read_unlock_trace())
> +
>  #endif /* __LINUX_RCUPDATE_TRACE_H */
> -- 
> 2.45.2
> 
> 

