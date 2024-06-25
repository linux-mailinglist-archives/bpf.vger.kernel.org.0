Return-Path: <bpf+bounces-33071-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E652916DB7
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 18:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E571E1F244BB
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 16:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FAD171084;
	Tue, 25 Jun 2024 16:06:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B16170841
	for <bpf@vger.kernel.org>; Tue, 25 Jun 2024 16:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719331563; cv=none; b=UmZsUBSlOzAphKrq60yLBSp7lBe+0dKYhajHPiXYllV0bDmxk8zBLvLRdjaYZ50dmBt+rpD0+2Ypz8Z92tGaRjWRZ5K/+ScNFRmixUozZhE9aPgXnJKa+gPOv1JRoc1/Vov4yVRVm9Cao8hnybN93eRkDX5AJvoJFpVig1pkSQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719331563; c=relaxed/simple;
	bh=3RzGrlZS6EMdgsJORIPeYBQrygitvAUCFNmjI9q3rZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M/UdHIoqRWQWTiynCjel82odgi+DSAZJDTitrmTHZpKrhxrBPHuccuXPXT5DwfYDCQ2gTM4Sgquiz24gDpyOxr4bKcSmpJRi1fAPas/44VE0j1vj2GOSLV9NLfHPYsttWxjumTNg04xDuUbqnyNTkIPW8rdl3QYEKmCr4LqGtM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav415.sakura.ne.jp (fsav415.sakura.ne.jp [133.242.250.114])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 45PG57m2071672;
	Wed, 26 Jun 2024 01:05:07 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav415.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp);
 Wed, 26 Jun 2024 01:05:07 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 45PG56hW071668
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 26 Jun 2024 01:05:07 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <ea56efca-552f-46d7-a7eb-4213c23a263b@I-love.SAKURA.ne.jp>
Date: Wed, 26 Jun 2024 01:05:02 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpf: defer printk() inside __bpf_prog_run()
To: John Ogness <john.ogness@linutronix.de>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
 <martin.lau@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <345098dc-8cb4-4808-98cf-fa9ab3af4fc4@I-love.SAKURA.ne.jp>
 <87ed8lxg1c.fsf@jogness.linutronix.de>
 <60704acc-61bd-4911-bb96-bd1cdd69803d@I-love.SAKURA.ne.jp>
 <87ikxxxbwd.fsf@jogness.linutronix.de>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <87ikxxxbwd.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/06/26 0:47, John Ogness wrote:
> On 2024-06-26, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:
>> On 2024/06/25 23:17, John Ogness wrote:
>>> On 2024-06-25, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:
>>>> syzbot is reporting circular locking dependency inside __bpf_prog_run(),
>>>> for fault injection calls printk() despite rq lock is already held.
>>>>
>>>> Guard __bpf_prog_run() using printk_deferred_{enter,exit}() (and
>>>> preempt_{disable,enable}() if CONFIG_PREEMPT_RT=n) in order to defer any
>>>> printk() messages.
>>>
>>> Why is the reason for disabling preemption?
>>
>> Because since kernel/printk/printk_safe.c uses a percpu counter for deferring
>> printk(), printk_safe_enter() and printk_safe_exit() have to be called from
>> the same CPU. preempt_disable() before printk_safe_enter() and preempt_enable()
>> after printk_safe_exit() guarantees that printk_safe_enter() and
>> printk_safe_exit() are called from the same CPU.
> 
> Yes, but we already have cant_migrate(). Are you suggesting there are
> configurations where cant_migrate() is true but the context can be
> migrated anyway?

No, I'm not aware of such configuration.

Does migrate_disable() imply preempt_disable() ?
If yes, we don't need to also call preempt_disable().
My understanding is that migration is about "on which CPU a process runs"
and preemption is about "whether a different process runs on this CPU".
That is, disabling migration and disabling preemption are independent.

Is migrate_disable() alone sufficient for managing a percpu counter?
If yes, we don't need to also call preempt_disable() in order to manage
a percpu counter.


