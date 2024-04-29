Return-Path: <bpf+bounces-28055-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9428B4F14
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 03:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C36E1C2139A
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 01:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC19624;
	Mon, 29 Apr 2024 01:00:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1307C7F;
	Mon, 29 Apr 2024 01:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714352449; cv=none; b=X4Af5mfsvkB7+hex8yWlpViM2LZ4dMqrNd6ui3TpYdG1R8RSus68fYe/3CIrXkEAaCWolOWkD9mQxcLbMb1g+0JZGGvUrZQqEQXz1cnVqLcW6ijIqVKIdcFxguG20SKzxPTXVMNJlFYrKSUTHUtoF4sJ/3obPaDh/ylzdnoKkOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714352449; c=relaxed/simple;
	bh=etxDARaiQCIvJBPFCwe6H3mQwF1npXNEqvXf+0RiTUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gSuzgBodDpFgm1eVdN8hhcyLCiDlhbwaUvoqs4n80Jud3JvyMWf1Uzy3SWK0bBUXL0NAu1GwzRV6jkx6nJJZBU3WVV8BKitP+OFh+9S8lcKjEPH8kFCEIpvCigfjnlEy4sl07bE6LLsm6b17Mk5ka6JziU+YB8NB98Hmwy0HdJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav311.sakura.ne.jp (fsav311.sakura.ne.jp [153.120.85.142])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 43T10VjC039860;
	Mon, 29 Apr 2024 10:00:31 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav311.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp);
 Mon, 29 Apr 2024 10:00:31 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 43T10VJT039857
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 29 Apr 2024 10:00:31 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <a93a0b0f-4607-46d6-937d-0ddf3544bb2d@I-love.SAKURA.ne.jp>
Date: Mon, 29 Apr 2024 10:00:30 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [bpf?] [trace?] possible deadlock in
 force_sig_info_to_task
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Hillf Danton <hdanton@sina.com>
Cc: syzbot <syzbot+83e7f982ca045ab4405c@syzkaller.appspotmail.com>,
        andrii@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <0000000000009dfa6d0617197994@google.com>
 <20240427231321.3978-1-hdanton@sina.com>
 <CAHk-=wjBvNvVggy14p9rkHA8W1ZVfoKXvW0oeX5NZWxWUv8gfQ@mail.gmail.com>
 <20240428232302.4035-1-hdanton@sina.com>
 <CAHk-=wjma_sSghVTgDCQxHHd=e2Lqi45PLh78oJ4WeBj8erV9Q@mail.gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAHk-=wjma_sSghVTgDCQxHHd=e2Lqi45PLh78oJ4WeBj8erV9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/04/29 9:50, Linus Torvalds wrote:
> On Sun, 28 Apr 2024 at 16:23, Hillf Danton <hdanton@sina.com> wrote:
>>
>> So is game like copying from/putting to user with runqueue locked
>> at the first place.
> 
> No, that should be perfectly fine. In fact, it's even normal. It would
> happen any time you have any kind of tracing thing, where looking up
> the user mode frame involves doing user accesses with page faults
> disabled.
> 
> The runqueue lock is irrelevant. As mentioned, it's only a symptom of
> something else going wrong.
> 
> Now, judging by the syz reproducer, the trigger for this all is almost
> certainly that
> 
>    bpf$BPF_RAW_TRACEPOINT_OPEN(0x11,
> &(0x7f00000000c0)={&(0x7f0000000080)='sched_switch\x00', r0}, 0x10)
> 
> and that probably causes the instability. But the immediate problem is
> not the user space access, it's that something goes horribly wrong
> *around* it.

I can't recall title of the commit, but I feel that things went very wrong
after a commit that allows running tracing function upon lock contention
(run code when e.g. a spinlock could not be taken) was introduced.
That commit is forming random locking dependency, resulting in flood of
lockdep warnings.

> 
>> Plus as per another syzbot report [1], bpf could make trouble with
>> workqueue pool locked.
> 
> That seems to be entirely different. There's no unexplained page fault
> in that case, that seems to be purely a "take lock in the wrong order"
> 
>                 Linus


