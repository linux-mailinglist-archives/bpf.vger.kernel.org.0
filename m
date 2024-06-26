Return-Path: <bpf+bounces-33197-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 696BE919ABD
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 00:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12A7F1F27112
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 22:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397F719412E;
	Wed, 26 Jun 2024 22:33:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE79194120;
	Wed, 26 Jun 2024 22:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719441195; cv=none; b=fULitN5xLyE7G9EttlpjUhMZs/ZLRQXUzoHwVxBEIRMywMAOIruqJIdZX+mcLHf4sE1PGVRQmdaU5AJONzP8KExFKv9pVo56je74VrRmt6cGed7AKqeRfILIdXVPyLbgM66ar2q/FgwfUCuvHl6IF2bNPVWg5Sd9DxJjCArIl9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719441195; c=relaxed/simple;
	bh=JQYBQcqcfLjdYNmJlkp5aPNCO8WC2EaCSgh4coPDav8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M6xkW1qgeuRMin2n6sZ4sGGdT8Ny93LtEE4MuJ5Fn4YQr07ulpQ5gh2GbbsytC1ugtz4b4B5dNQMR2fJ35A8PNnlZE/DNHmzhbbNV3AgrwhOpiJ8nKK2bsw72UxeH6O4+0NDTngIJPGH0kzwOHLVfxrXSLSLL9Zcmk6Mi9vHZEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618AFC116B1;
	Wed, 26 Jun 2024 22:33:13 +0000 (UTC)
Date: Wed, 26 Jun 2024 18:33:11 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, John Ogness
 <john.ogness@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Petr Mladek
 <pmladek@suse.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, bpf
 <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bpf: defer printk() inside __bpf_prog_run()
Message-ID: <20240626183311.05eaf091@rorschach.local.home>
In-Reply-To: <f6c23073-dc0d-4b3f-b37d-1edb82737b5b@I-love.SAKURA.ne.jp>
References: <345098dc-8cb4-4808-98cf-fa9ab3af4fc4@I-love.SAKURA.ne.jp>
	<87ed8lxg1c.fsf@jogness.linutronix.de>
	<60704acc-61bd-4911-bb96-bd1cdd69803d@I-love.SAKURA.ne.jp>
	<87ikxxxbwd.fsf@jogness.linutronix.de>
	<ea56efca-552f-46d7-a7eb-4213c23a263b@I-love.SAKURA.ne.jp>
	<CAADnVQ+hxHsQpfOkQvq4d5AEQsH41BHL+e_RtuxUzyh-vNyYEQ@mail.gmail.com>
	<7edb0e39-a62e-4aac-a292-3cf7ae26ccbd@I-love.SAKURA.ne.jp>
	<CAADnVQKoHk5FTN=jywBjgdTdLwv-c76nCzyH90Js-41WxPK_Tw@mail.gmail.com>
	<744c9c43-9e4f-4069-9773-067036237bff@I-love.SAKURA.ne.jp>
	<20240626122748.065a903b@rorschach.local.home>
	<f6c23073-dc0d-4b3f-b37d-1edb82737b5b@I-love.SAKURA.ne.jp>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Jun 2024 07:15:25 +0900
Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:

> On 2024/06/27 1:27, Steven Rostedt wrote:
> > On Wed, 26 Jun 2024 09:02:22 +0900
> > Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:
> >   
> >> On 2024/06/26 8:56, Alexei Starovoitov wrote:  
> >>> You are missing the point. The bug has nothing to do with bpf.    
> >>
> >> The bug is caused by calling tracing hooks with rq lock held.
> >> If tracing hooks do not exist, this bug does not exist.  
> > 
> > Could you expand on this. What tracing hooks are called with rq lock
> > held? You mean the scheduling events?  
> 
> Yes, trace_sched_switch().
> __schedule() calls trace_sched_switch() hook with rq lock held.
> 
>  #2: ffff8880b943e798 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:559
> 
>  __bpf_prog_run include/linux/filter.h:691 [inline]
>  bpf_prog_run include/linux/filter.h:698 [inline]
>  __bpf_trace_run kernel/trace/bpf_trace.c:2403 [inline]
>  bpf_trace_run4+0x334/0x590 kernel/trace/bpf_trace.c:2446
>  __traceiter_sched_switch+0x98/0xd0 include/trace/events/sched.h:222
>  trace_sched_switch include/trace/events/sched.h:222 [inline]
>  __schedule+0x2587/0x4a20 kernel/sched/core.c:6742
>  preempt_schedule_notrace+0x100/0x140 kernel/sched/core.c:7017

So you are saying that because a BPF hook can attach to a tracepoint
that is called with rq locks held, it should always disable preemption
and call printk_deferred_enter(), because it *might* hit an error path
that will call printk?? In other words, how the BPF hook is used
determines if the rq lock is held or not when it is called.

I can use that same argument for should_fail_ex(). Because how it is
used determines if the rq lock is held or not when it is called. And it
is the function that actually calls printk().

Sorry, but it makes no sense to put the burden of the
printk_deferred_enter() on the BPF hook logic. It should sit solely
with the code that actually calls printk().

-- Steve

