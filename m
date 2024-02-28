Return-Path: <bpf+bounces-22883-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB3B86B33E
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 16:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF68F1C20C3F
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 15:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060F115CD57;
	Wed, 28 Feb 2024 15:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="duIgZNhC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D0115A4BA
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 15:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709134627; cv=none; b=OPvm/wBlKw2z8WalFuNbBaVBx3XAD0iniTU8y7T50qycwE9S+0gfYh2edmikyJsEk6UHTd5bgeBsCQ/ZYQ6N1hViVZ/K0P9EsDBWlcOrivENY9HEimS6OQC0kchEmaLFGZVfhtJNpq6vecGn/LU7DNJ7NXmnJkIb0/AuDwEHRbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709134627; c=relaxed/simple;
	bh=1z3csMbqgTnig1Ap5wKmTsY0Lst2nCNabT3ZpCaFRnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FAFPnOdyvvsmO4x4P5Tzvt5S9XeBVwWnxvrLxmZm2Cfnjyh4hq+4RCw5pSJuXvtDGDFUBmbQHT6C3g9PZmWH+i5GnpoWJ6ft9dhMEQHMjRNB+/iAuf6Rvk178fi1aG5gdja01tIaTRuCCOWNF0Lvqew7r8jAY1nY7zj80qKNDc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=duIgZNhC; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7c79664c71fso31706239f.0
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 07:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1709134625; x=1709739425; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+1L5Cy3MF3D28gxGbrEAMOoAtbtxWDY6AIiI05ilOZU=;
        b=duIgZNhCkzu/GlO8Nmb5lBwmgawrAPnclTIjVKaOoBK2xBZpa6sYiiiqPvq/Eax0Kr
         +Jiapc4sodqRY/K6hSymBGxEd6GrxAeYpvkRARaqxDgqXDDzTPp2X0Fiurgy07YAKqM3
         M6S6gWDVs6AyPy4ebAgp3LR25kzA6Gr8L4joQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709134625; x=1709739425;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+1L5Cy3MF3D28gxGbrEAMOoAtbtxWDY6AIiI05ilOZU=;
        b=YEhnm8ovhpK9VXoJL5MyCd2yjSIWXXZgStDDM8qbqWLrcyCA38In5QfIvTvEt9iDEn
         jDRuEDKn6NH4JvQ4Z77A0SSTjx7ruFjLUWQDsKIF+qTriTAA2hl5rOg0+KGoFJ2+TUBS
         RtjEQIj6B00oz1FmZffc+MkBo+8ldN0xLUjK1Emz3BB0DmHyIxrKZlpHNSIZNhD/nvVe
         Fi4AWYfc8kLX0BfHY8kcEHRYw4zaT6pfflc3sj6sfLy+Vdjkf5cPKhhDdtUXpqZhyv9H
         Izojj0eOotP4cn3V7Jbqyj7XaX+oOS0UkZnz63gLUHiTu3PqRFz0OD06jS4rjIRZejfO
         ZW1A==
X-Forwarded-Encrypted: i=1; AJvYcCXbKGa0pwrs30N/nPesRcv5p2ZiWwxetsHPAwYubj6sCEJu4EgY+Ded3c7HylFntbKXbwLRh7YGkQDS3S33e+6UEiJN
X-Gm-Message-State: AOJu0YzglAe7rZPUaLT+0kQ732F+nPQ99nXiCJKkk6ryX43Px5veMTwH
	k5/uOMHOw7o+draChG7jPalt5N9VFuwmRWHWASqSoxayAtzfu/ztMmDSEQeEh8s=
X-Google-Smtp-Source: AGHT+IGIt7SvuAAFaGoVPqQsRHX38gNH9YqddTrGnKhyIY+DDMwRPA8ZDs9TWbPbPClAi+idGj8S1w==
X-Received: by 2002:a6b:7216:0:b0:7c7:f935:9668 with SMTP id n22-20020a6b7216000000b007c7f9359668mr1610582ioc.4.1709134624954;
        Wed, 28 Feb 2024 07:37:04 -0800 (PST)
Received: from [10.5.0.2] ([91.196.69.76])
        by smtp.gmail.com with ESMTPSA id d2-20020a056602064200b007c791c3c528sm2334495iox.9.2024.02.28.07.37.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 07:37:04 -0800 (PST)
Message-ID: <f1d1e0fb-2870-4b8f-8936-881ac29a24f1@joelfernandes.org>
Date: Wed, 28 Feb 2024 10:37:00 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: raise RCU qs after each threaded NAPI poll
Content-Language: en-US
To: paulmck@kernel.org, Eric Dumazet <edumazet@google.com>
Cc: Yan Zhai <yan@cloudflare.com>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
 Simon Horman <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Coco Li <lixiaoyan@google.com>,
 Wei Wang <weiwan@google.com>, Alexander Duyck <alexanderduyck@fb.com>,
 Hannes Frederic Sowa <hannes@stressinduktion.org>,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org, bpf@vger.kernel.org,
 kernel-team@cloudflare.com
References: <Zd4DXTyCf17lcTfq@debian.debian>
 <CANn89iJQX14C1Qb_qbTVG4yoG26Cq7Ct+2qK_8T-Ok2JDdTGEA@mail.gmail.com>
 <d633c5b9-53a5-4cd6-9dbb-6623bb74c00b@paulmck-laptop>
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <d633c5b9-53a5-4cd6-9dbb-6623bb74c00b@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/27/2024 1:32 PM, Paul E. McKenney wrote:
> On Tue, Feb 27, 2024 at 05:44:17PM +0100, Eric Dumazet wrote:
>> On Tue, Feb 27, 2024 at 4:44 PM Yan Zhai <yan@cloudflare.com> wrote:
>>> We noticed task RCUs being blocked when threaded NAPIs are very busy in
>>> production: detaching any BPF tracing programs, i.e. removing a ftrace
>>> trampoline, will simply block for very long in rcu_tasks_wait_gp. This
>>> ranges from hundreds of seconds to even an hour, severely harming any
>>> observability tools that rely on BPF tracing programs. It can be
>>> easily reproduced locally with following setup:
>>>
>>> ip netns add test1
>>> ip netns add test2
>>>
>>> ip -n test1 link add veth1 type veth peer name veth2 netns test2
>>>
>>> ip -n test1 link set veth1 up
>>> ip -n test1 link set lo up
>>> ip -n test2 link set veth2 up
>>> ip -n test2 link set lo up
>>>
>>> ip -n test1 addr add 192.168.1.2/31 dev veth1
>>> ip -n test1 addr add 1.1.1.1/32 dev lo
>>> ip -n test2 addr add 192.168.1.3/31 dev veth2
>>> ip -n test2 addr add 2.2.2.2/31 dev lo
>>>
>>> ip -n test1 route add default via 192.168.1.3
>>> ip -n test2 route add default via 192.168.1.2
>>>
>>> for i in `seq 10 210`; do
>>>  for j in `seq 10 210`; do
>>>     ip netns exec test2 iptables -I INPUT -s 3.3.$i.$j -p udp --dport 5201
>>>  done
>>> done
>>>
>>> ip netns exec test2 ethtool -K veth2 gro on
>>> ip netns exec test2 bash -c 'echo 1 > /sys/class/net/veth2/threaded'
>>> ip netns exec test1 ethtool -K veth1 tso off
>>>
>>> Then run an iperf3 client/server and a bpftrace script can trigger it:
>>>
>>> ip netns exec test2 iperf3 -s -B 2.2.2.2 >/dev/null&
>>> ip netns exec test1 iperf3 -c 2.2.2.2 -B 1.1.1.1 -u -l 1500 -b 3g -t 100 >/dev/null&
>>> bpftrace -e 'kfunc:__napi_poll{@=count();} interval:s:1{exit();}'
>>>
>>> Above reproduce for net-next kernel with following RCU and preempt
>>> configuraitons:
>>>
>>> # RCU Subsystem
>>> CONFIG_TREE_RCU=y
>>> CONFIG_PREEMPT_RCU=y
>>> # CONFIG_RCU_EXPERT is not set
>>> CONFIG_SRCU=y
>>> CONFIG_TREE_SRCU=y
>>> CONFIG_TASKS_RCU_GENERIC=y
>>> CONFIG_TASKS_RCU=y
>>> CONFIG_TASKS_RUDE_RCU=y
>>> CONFIG_TASKS_TRACE_RCU=y
>>> CONFIG_RCU_STALL_COMMON=y
>>> CONFIG_RCU_NEED_SEGCBLIST=y
>>> # end of RCU Subsystem
>>> # RCU Debugging
>>> # CONFIG_RCU_SCALE_TEST is not set
>>> # CONFIG_RCU_TORTURE_TEST is not set
>>> # CONFIG_RCU_REF_SCALE_TEST is not set
>>> CONFIG_RCU_CPU_STALL_TIMEOUT=21
>>> CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
>>> # CONFIG_RCU_TRACE is not set
>>> # CONFIG_RCU_EQS_DEBUG is not set
>>> # end of RCU Debugging
>>>
>>> CONFIG_PREEMPT_BUILD=y
>>> # CONFIG_PREEMPT_NONE is not set
>>> CONFIG_PREEMPT_VOLUNTARY=y
>>> # CONFIG_PREEMPT is not set
>>> CONFIG_PREEMPT_COUNT=y
>>> CONFIG_PREEMPTION=y
>>> CONFIG_PREEMPT_DYNAMIC=y
>>> CONFIG_PREEMPT_RCU=y
>>> CONFIG_HAVE_PREEMPT_DYNAMIC=y
>>> CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
>>> CONFIG_PREEMPT_NOTIFIERS=y
>>> # CONFIG_DEBUG_PREEMPT is not set
>>> # CONFIG_PREEMPT_TRACER is not set
>>> # CONFIG_PREEMPTIRQ_DELAY_TEST is not set
>>>
>>> An interesting observation is that, while tasks RCUs are blocked,
>>> related NAPI thread is still being scheduled (even across cores)
>>> regularly. Looking at the gp conditions, I am inclining to cond_resched
>>> after each __napi_poll being the problem: cond_resched enters the
>>> scheduler with PREEMPT bit, which does not account as a gp for tasks
>>> RCUs. Meanwhile, since the thread has been frequently resched, the
>>> normal scheduling point (no PREEMPT bit, accounted as a task RCU gp)
>>> seems to have very little chance to kick in. Given the nature of "busy
>>> polling" program, such NAPI thread won't have task->nvcsw or task->on_rq
>>> updated (other gp conditions), the result is that such NAPI thread is
>>> put on RCU holdouts list for indefinitely long time.
>>>
>>> This is simply fixed by mirroring the ksoftirqd behavior: after
>>> NAPI/softirq work, raise a RCU QS to help expedite the RCU period. No
>>> more blocking afterwards for the same setup.
>>>
>>> Fixes: 29863d41bb6e ("net: implement threaded-able napi poll loop support")
>>> Signed-off-by: Yan Zhai <yan@cloudflare.com>
>>> ---
>>>  net/core/dev.c | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/net/core/dev.c b/net/core/dev.c
>>> index 275fd5259a4a..6e41263ff5d3 100644
>>> --- a/net/core/dev.c
>>> +++ b/net/core/dev.c
>>> @@ -6773,6 +6773,10 @@ static int napi_threaded_poll(void *data)
>>>                                 net_rps_action_and_irq_enable(sd);
>>>                         }
>>>                         skb_defer_free_flush(sd);
> Please put a comment here stating that RCU readers cannot cross
> this point.
> 
> I need to add lockdep to rcu_softirq_qs() to catch placing this in an
> RCU read-side critical section.  And a header comment noting that from
> an RCU perspective, it acts as a momentary enabling of preemption.

Agreed, also does PREEMPT_RT not have similar issue? I noticed Thomas had
added this to softirq.c [1] but the changelog did not have details.

Also optionally, I wonder if calling rcu_tasks_qs() directly is better
(for documentation if anything) since the issue is Tasks RCU specific. Also
code comment above the rcu_softirq_qs() call about cond_resched() not taking
care of Tasks RCU would be great!

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel
[1]
@@ -381,8 +553,10 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
                pending >>= softirq_bit;
        }

-       if (__this_cpu_read(ksoftirqd) == current)
+       if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
+           __this_cpu_read(ksoftirqd) == current)
                rcu_softirq_qs();
+
        local_irq_disable();

