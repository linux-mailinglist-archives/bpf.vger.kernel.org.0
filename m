Return-Path: <bpf+bounces-42741-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2719A9760
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 06:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C6C3B224ED
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 04:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3417824AF;
	Tue, 22 Oct 2024 04:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vze4eSMH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B99D200CD;
	Tue, 22 Oct 2024 04:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729569698; cv=none; b=ZiKiF9tI/s7H4ryB/1M9Y+UjjL63fIitcfOsKWiAn0vXon4Vbl9nZCHUqcKK0NgA0CpmjT6Goz73LM0knVKM8wuDwLHNeuBCvUvwWSg4mswQ9eqfY+lth8LB4fMHZK8Rfpe41r42/tgmJcjwI92Bi9CJ1gkrrlEQgl7ztOotmdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729569698; c=relaxed/simple;
	bh=fPXbsF4kyNIhImmlGQ3JVWmhC8p/wdo0pc+43o7C9Y4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rYOIShOkWyfC47NbdlWD+bs98y6I4denzeSU/9O7RFEtSRRc8SblyIq6Tdf5U6LenovqwlL9B0nfokfvKoL+LZtGtdR+QLwgd57Ty2SPrCA/YaqV/v71RKwHl7/2a9u2ZONGqmZ5FOp9oamd78k3oBATcLSkKINK8RpFcs3YdNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vze4eSMH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C582FC4CEC3;
	Tue, 22 Oct 2024 04:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729569697;
	bh=fPXbsF4kyNIhImmlGQ3JVWmhC8p/wdo0pc+43o7C9Y4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Vze4eSMH3jmHsdKtGswJpBgjlcovOtHJFXKDP39vCXc9KhG5goYmV7+D815zluuan
	 kykhjjAnq8V8bbcO212RAtz/+jEd1AjHwM+Q+P0aEpRl/3BqH5JeIMerzUvtnTBzM5
	 7hBlBLQJeZFmAL9AgnaVDuokUrBCRXTk5KJey+RYFKe36tcSLebNmuvoOq+XyQuZNX
	 uhDbzJJjCcJIVM9DHTGRtp5LSu27ecYJcVKYjg592VZqc8+MehgRt9Oi2PPPVLkTVl
	 ca39n6riB265anzmnyue7snGHpGEbzLK14vpp7TVIiOmYNvSL/TXF5FjhOQrC68AET
	 8swa+1tsWgnPg==
Date: Tue, 22 Oct 2024 13:01:34 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Liao Chang <liaochang1@huawei.com>
Cc: <oleg@redhat.com>, <peterz@infradead.org>, <mingo@redhat.com>,
 <acme@kernel.org>, <namhyung@kernel.org>, <mark.rutland@arm.com>,
 <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
 <irogers@google.com>, <adrian.hunter@intel.com>,
 <kan.liang@linux.intel.com>, <linux-kernel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
 <bpf@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] uprobes: Remove redundant spinlock in
 uprobe_deny_signal()
Message-Id: <20241022130134.baf9e1f140b2664dba15d410@kernel.org>
In-Reply-To: <20240815014629.2685155-2-liaochang1@huawei.com>
References: <20240815014629.2685155-1-liaochang1@huawei.com>
	<20240815014629.2685155-2-liaochang1@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Aug 2024 01:46:28 +0000
Liao Chang <liaochang1@huawei.com> wrote:

> Since clearing a bit in thread_info is an atomic operation, the spinlock
> is redundant and can be removed, reducing lock contention is good for
> performance.
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> Acked-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> ---
>  kernel/events/uprobes.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 73cc47708679..76a51a1f51e2 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1979,9 +1979,7 @@ bool uprobe_deny_signal(void)
>  	WARN_ON_ONCE(utask->state != UTASK_SSTEP);
>  
>  	if (task_sigpending(t)) {
> -		spin_lock_irq(&t->sighand->siglock);
>  		clear_tsk_thread_flag(t, TIF_SIGPENDING);
> -		spin_unlock_irq(&t->sighand->siglock);
>  
>  		if (__fatal_signal_pending(t) || arch_uprobe_xol_was_trapped(t)) {
>  			utask->state = UTASK_SSTEP_TRAPPED;
> -- 
> 2.34.1
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

