Return-Path: <bpf+bounces-33066-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 436D6916C8F
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 17:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1ACC1F2D059
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 15:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A8916FF55;
	Tue, 25 Jun 2024 15:08:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F034816FF4A
	for <bpf@vger.kernel.org>; Tue, 25 Jun 2024 15:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719328121; cv=none; b=C5wETm7oB8R5Rpyo0ai7VZf8OyKphLqc9dRxMhY8D4PJ5wrXcTlwffEcLXffKiHIRQnzae1zm9r9+4qANeyk/Uj4Yid8E998fXQ0KZWB8gvZvtw2FybUESkxrxMggr99HitrTZcU0LeP05nmtY3nvllp4zUaJsZtLw1kUzbwgUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719328121; c=relaxed/simple;
	bh=FJJb1ND/Hw5n8Lg55dkxnTRE+HdfB3T4SIUDinzkTMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OB3QOsQSH1An3AXToamoI/diBmvwFlEKfHxJt7v7glFM0HSz5fZl5rVAoVPrs6rCJ8jqPSz5hYAK4QDBoogt/UwEbwxKFcGgDmSJlZtJ5C8JXZBqdVyjsAOGMafkGWrPNJFQfwnEoxXc+P9y15Z3XsduE6GV1VN2kuFpywghY8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav119.sakura.ne.jp (fsav119.sakura.ne.jp [27.133.134.246])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 45PF7etM062223;
	Wed, 26 Jun 2024 00:07:40 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav119.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp);
 Wed, 26 Jun 2024 00:07:40 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 45PF7bBq062214
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 26 Jun 2024 00:07:38 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <60704acc-61bd-4911-bb96-bd1cdd69803d@I-love.SAKURA.ne.jp>
Date: Wed, 26 Jun 2024 00:07:37 +0900
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
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <87ed8lxg1c.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/06/25 23:17, John Ogness wrote:
> On 2024-06-25, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:
>> syzbot is reporting circular locking dependency inside __bpf_prog_run(),
>> for fault injection calls printk() despite rq lock is already held.
>>
>> Guard __bpf_prog_run() using printk_deferred_{enter,exit}() (and
>> preempt_{disable,enable}() if CONFIG_PREEMPT_RT=n) in order to defer any
>> printk() messages.
> 
> Why is the reason for disabling preemption?

Because since kernel/printk/printk_safe.c uses a percpu counter for deferring
printk(), printk_safe_enter() and printk_safe_exit() have to be called from
the same CPU. preempt_disable() before printk_safe_enter() and preempt_enable()
after printk_safe_exit() guarantees that printk_safe_enter() and
printk_safe_exit() are called from the same CPU.


