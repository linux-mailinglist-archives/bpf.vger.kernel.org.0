Return-Path: <bpf+bounces-30286-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C858CBF45
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 12:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D636B21284
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 10:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2C280035;
	Wed, 22 May 2024 10:31:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F3150269
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 10:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716373869; cv=none; b=aZW2JHOvgSkptG5g3oGP/WFyUcHU4+FVRtj6nnfYh3oMh3ylJuA2syY/mJnV+MhM/J5ZkK46P7uoKY6EimEsXtlpIDvtL1bEs3qNKUJBeZtpW+z+3brogdHylxC5d8xE0QQSOyiaICm+YrD1JursizqhY5YK+2EViLGBTPRWu3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716373869; c=relaxed/simple;
	bh=rxFk8HEHcSjxEGIA+UOVFBH3zOZ9OBbzCE67oj1TzPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l1jgSI3BpjBx5hWS/7Qhg0tZCcaOpMJL6iOj7lsyCRnbgTUglxyOpgnL3sVAgLaAQ9HyuVDladYYeuR9IgKDOciuLBBjqSoinAWXjO5m0i6IQa56fgaXfQDJF3R5Yx7d8CHpo6/EUsBbKt9/0knhP/ffvnMDUYV2szqhZHlClrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav119.sakura.ne.jp (fsav119.sakura.ne.jp [27.133.134.246])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 44MAUxO7084776;
	Wed, 22 May 2024 19:30:59 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav119.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp);
 Wed, 22 May 2024 19:30:59 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 44MAUwdV084772
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 22 May 2024 19:30:59 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <f77290fe-a94e-498b-bbbf-429ba0ce49c2@I-love.SAKURA.ne.jp>
Date: Wed, 22 May 2024 19:30:58 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpf, sockmap: defer sk_psock_free_link() using RCU
To: Jakub Sitnicki <jakub@cloudflare.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
References: <838e7959-a360-4ac1-b36a-a3469236129b@I-love.SAKURA.ne.jp>
 <20240521225918.2147-1-hdanton@sina.com> <877cfmxjie.fsf@cloudflare.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <877cfmxjie.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/05/22 18:50, Jakub Sitnicki wrote:
> On Wed, May 22, 2024 at 06:59 AM +08, Hillf Danton wrote:
>> On Tue, 21 May 2024 08:38:52 -0700 Alexei Starovoitov <alexei.starovoitov@gmail.com>
>>> On Sun, May 12, 2024 at 12:22=E2=80=AFAM Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>>> --- a/net/core/sock_map.c
>>>> +++ b/net/core/sock_map.c
>>>> @@ -142,6 +142,7 @@ static void sock_map_del_link(struct sock *sk,
>>>>         bool strp_stop =3D false, verdict_stop =3D false;
>>>>         struct sk_psock_link *link, *tmp;
>>>>
>>>> +       rcu_read_lock();
>>>>         spin_lock_bh(&psock->link_lock);
>>>
>>> I think this is incorrect.
>>> spin_lock_bh may sleep in RT and it won't be safe to do in rcu cs.
>>
>> Could you specify why it won't be safe in rcu cs if you are right?
>> What does rcu look like in RT if not nothing?
> 
> RCU readers can't block, while spinlock RT doesn't disable preemption.
> 
> https://docs.kernel.org/RCU/rcu.html
> https://docs.kernel.org/locking/locktypes.html#spinlock-t-and-preempt-rt
> 

I didn't catch what you mean.

https://elixir.bootlin.com/linux/latest/source/include/linux/spinlock_rt.h#L43 defines spin_lock() for RT as

static __always_inline void spin_lock(spinlock_t *lock)
{
	rt_spin_lock(lock);
}

and https://elixir.bootlin.com/linux/v6.9/source/include/linux/spinlock_rt.h#L85 defines spin_lock_bh() for RT as

static __always_inline void spin_lock_bh(spinlock_t *lock)
{
	/* Investigate: Drop bh when blocking ? */
	local_bh_disable();
	rt_spin_lock(lock);
}

and https://elixir.bootlin.com/linux/latest/source/kernel/locking/spinlock_rt.c#L54 defines rt_spin_lock() for RT as

void __sched rt_spin_lock(spinlock_t *lock)
{
	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
	__rt_spin_lock(lock);
}

and https://elixir.bootlin.com/linux/v6.9/source/kernel/locking/spinlock_rt.c#L46 defines __rt_spin_lock() for RT as

static __always_inline void __rt_spin_lock(spinlock_t *lock)
{
	rtlock_might_resched();
	rtlock_lock(&lock->lock);
	rcu_read_lock();
	migrate_disable();
}

. You can see that calling spin_lock() or spin_lock_bh() automatically starts RCU critical section, can't you?

If spin_lock_bh() for RT might sleep and calling spin_lock_bh() under RCU critical section is not safe,
how can

  spin_lock(&lock1);
  spin_lock(&lock2);
  // do something
  spin_unlock(&lock2);
  spin_unlock(&lock1);

or

  spin_lock_bh(&lock1);
  spin_lock(&lock2);
  // do something
  spin_unlock(&lock2);
  spin_unlock_bh(&lock1);

be possible?

Unless rcu_read_lock() is implemented in a way that is safe to do

  rcu_read_lock();
  spin_lock(&lock2);
  // do something
  spin_unlock(&lock2);
  rcu_read_unlock();

and

  rcu_read_lock();
  spin_lock_bh(&lock2);
  // do something
  spin_unlock_bh(&lock2);
  rcu_read_unlock();

, I think RT kernels can't run safely.

Locking primitive ordering is too much complicated/distributed.
We need documentation using safe/unsafe ordering examples.


