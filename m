Return-Path: <bpf+bounces-55254-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6EDA7A8E4
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 19:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA68C1883EEB
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 17:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE028252908;
	Thu,  3 Apr 2025 17:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TntbLmk2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NXw6ETOn"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65752250C16;
	Thu,  3 Apr 2025 17:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743702564; cv=none; b=EAOtmMyngcYNohHDBpO4kCdCLcLlyArmGYLiStBGT0hqYGvxmm7sp5MNQsxDx9iSyNalwbTfRpsnDFxUkZFUdRcmliXZ0eXvGskxgqVIfxbf4bS0JxsJTLAPqULSNu3PzX3DsbtcuVryWsZhlvYbTCOS3cX741KLDLO5cex22dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743702564; c=relaxed/simple;
	bh=uC8A235nV5hDJs26eYs9bsiXlIDfQqbrWSJ+0H8VMh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jae/0RkgLmEDNwlqWtm6Uf0eEgFamwkMrW4dEG01BjgVGyYfx9rjq7jLG3QuipU1tESmIrWovh5P4+RiMD5LYRwFBEuM6XELqPdcDhWBsxg9mon3u4EtigY1ePN2hDD2QKa4bfhzAZEPBcKFge5Mc/PC5t6mk1UDl8XON39G0Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TntbLmk2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NXw6ETOn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 3 Apr 2025 19:49:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743702558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x3miVKVcAqJiYVnZa0G3WVeXM1wcDhomDqNBC5jtQKs=;
	b=TntbLmk2ICoXpOGltxhXn7TsZr9vndRCGVMtQq9v9A4aMUfYK5VRA1IlrrJmfk+A14SmOM
	wZ2OP6HKwTXXebuuHvHRMTqodziWBt/fei1gUrOxWmdLcBseqRU0dTk6GZ7dQ+Mrabe2Tb
	v6eZpuZtVlPb8DRl3yLMo/lwOoWbWySBYB37QemmoP3+oRbkXghOdgjM+eaARxjbQLQTxr
	69cVbSM2bNts3UodDqGpUdlCKkA6HN6v6MPI2SJpxFl1h/ynKyYqhahfdEn6Nop4o1DGrq
	E/pWzLzdrEchRLIAwUQXkvU6CrKbz1/+GiNGiw/qBAvE07CaeuZTz9WnhFgtyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743702558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x3miVKVcAqJiYVnZa0G3WVeXM1wcDhomDqNBC5jtQKs=;
	b=NXw6ETOnxAJl6TipKslu2W01i4S8aiY9G/05eWVVQxIQoSxs7QnDURKhkS/2k9NiztUCz3
	tuyjhgpRzEpAwtBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
	mingo@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, rostedt@goodmis.org, oleg@redhat.com,
	mhiramat@kernel.org, ast@kernel.org
Subject: Re: [PATCH tip/perf] uprobes: avoid false lockdep splat in uprobe
 timer callback
Message-ID: <20250403174917.OLHfwBp-@linutronix.de>
References: <20250403171831.3803479-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250403171831.3803479-1-andrii@kernel.org>

On 2025-04-03 10:18:31 [-0700], Andrii Nakryiko wrote:
> Avoid a false-positive lockdep warning in PREEMPT_RT configuration when
> using write_seqcount_begin() in uprobe timer callback by using
> raw_write_* APIs. Uprobe's use of timer callback is guaranteed to not
> race with itself, and as such seqcount's insistence on having hardirqs
preemption, not hardirqs

> disabled on the writer side is irrelevant. So switch to raw_ variants of
> seqcount API instead of disabling hardirqs unnecessarily.
> 
> Also, point out in the comments more explicitly why we use seqcount
> despite our reader side being rather simple and never retrying. We favor
> well-maintained kernel primitive in favor of open-coding our own memory
> barriers.

Thank you.

> Link: https://lore.kernel.org/bpf/CAADnVQLLOHZmPO4X_dQ+cTaSDvzdWHzA0qUqQDhLFYL3D6xPxg@mail.gmail.com/
> Reported-by: Alexei Starovoitov <ast@kernel.org>
> Suggested-by: Sebastian Sewior <bigeasy@linutronix.de>
> Fixes: 8622e45b5da1 ("uprobes: Reuse return_instances between multiple uretprobes within task")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/events/uprobes.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 70c84b9d7be3..6d7e7da0fbbc 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1944,6 +1944,9 @@ static void free_ret_instance(struct uprobe_task *utask,
>  	 * to-be-reused return instances for future uretprobes. If ri_timer()
>  	 * happens to be running right now, though, we fallback to safety and
>  	 * just perform RCU-delated freeing of ri.
> +	 * Admittedly, this is a rather simple use of seqcount, but it nicely
> +	 * abstracts away all the necessary memory barriers, so we use
> +	 * a well-supported kernel primitive here.
>  	 */
>  	if (raw_seqcount_try_begin(&utask->ri_seqcount, seq)) {
>  		/* immediate reuse of ri without RCU GP is OK */
> @@ -2004,12 +2007,18 @@ static void ri_timer(struct timer_list *timer)
>  	/* RCU protects return_instance from freeing. */
>  	guard(rcu)();
>  
> -	write_seqcount_begin(&utask->ri_seqcount);

> +	/* See free_ret_instance() for notes on seqcount use.

This is not a proper multi line comment.

> +	 * We also employ raw API variants to avoid lockdep false-positive
> +	 * warning complaining about hardirqs not being disabled. We have

s/hardirqs/preemption. The warning is about missing disabled preemption.

> +	 * a guarantee that this timer callback won't race with itself, so no
> +	 * need to disable hardirqs.

The timer can only be invoked once for a uprobe_task. Therefore there
can only be one writer. The reader does not require an even sequence
count so it is okay to remain preemptible on PREEMPT_RT. 

> +	 */
> +	raw_write_seqcount_begin(&utask->ri_seqcount);
>  
>  	for_each_ret_instance_rcu(ri, utask->return_instances)
>  		hprobe_expire(&ri->hprobe, false);
>  
> -	write_seqcount_end(&utask->ri_seqcount);
> +	raw_write_seqcount_end(&utask->ri_seqcount);
>  }
>  
>  static struct uprobe_task *alloc_utask(void)

Sebastian

