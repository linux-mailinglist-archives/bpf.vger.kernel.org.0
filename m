Return-Path: <bpf+bounces-23065-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C9386D0FC
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 18:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BAF61F21768
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 17:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E13757EC;
	Thu, 29 Feb 2024 17:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="O2ImKm7B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810B470AF0
	for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 17:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709228530; cv=none; b=MwdJNaoGu/UuOsEVfgAs6XiCswu8vgNIUt9Hlxt2XGTO+TrV2FuXsYcpL887SggcW6mbH7NS/Dg9Zb34QJN1L7k9fD+r9sewCXA0fbOZ8C+i57S7NGc/Hx88YJISDQlsE3HGh1bMcxVLqWd8ignaecG/1cQtnZ9/Xw/xMo5XUpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709228530; c=relaxed/simple;
	bh=lI8Z0o/WbksD0Syi1oUjCSh1ZwManR98OCOJPvTowag=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=YCwzntLtX+QvGrcVixR0w4WYSILRnigtfC+I6xd8m23u6+2090X1wq47QJqd7OzVJOgLPluUOBkZzp/GxKyV/aafqnGGLL1fYZQSt8+sPJKD9bh9gpGdnonYVIT9tI+ZefsbCWRfBGlD4iIZjKd1MmgLduhPCjCT4wQl3vpKLuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=O2ImKm7B; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-690494d2e97so6095376d6.0
        for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 09:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1709228527; x=1709833327; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HwUZzbGwWNKUk3Gmh7J0YXdK3z+y2JIeVXKnvWA5F3o=;
        b=O2ImKm7B1+OHcs5iKm46YmZzhchGhOwFFC6Pt4ASm+epxmciNwIjjdneosuqTb5Aog
         Blg880R0bqT6yIpO8r7WgsPMvh5Updf8P7fmrKQntnAU8aGexgl6XRZS3/5+tatVzCje
         2VxyKYbcWx8bQcUo981uRCViN0FX71m1Bwb5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709228527; x=1709833327;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HwUZzbGwWNKUk3Gmh7J0YXdK3z+y2JIeVXKnvWA5F3o=;
        b=GKOcv9mmIXJNL+92EmmjJc4flrpPFV3V25Inn86aw+8fx3hWWHbIXwepv5YVYqczGx
         RSaDYGfRvfmqjzSd5PhE4aYi5L6JnFEvZWSmN3NNYcybUDGh1hLCOV/kKsDU0X8/hEpp
         wsRaq1Ekp3GkIxIUYtlKaKDVTGOgYg0m+KQV80vp2dOK7u053IWT73bJQ7z4Gx4S9Daz
         Ru7ZH9nVJVzGB+Rg4Jvl6KGzzGQ86x1yeAQG2r8FhCuL2FI9hfMmqU4i5vYqZd+m6PG/
         RQ5dq18ulD0RSy/VzZNX6NN1Vv7KTNRMO4eHmMUTusNHmWva1b3GodOSQnHvWhSlzv4y
         dEKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXS1JMdZKDga2uIhT5nMEWSbZaTFlYW22f1X5TOdvaBvJ17w2yO1IymRv+n0NINclZ5B2qpbEKahgJKPC9cdI71l2Ff
X-Gm-Message-State: AOJu0YzlHhKkfKn2tgNSY2jxji2ioMMaf/qNpFOazDs7lmP8kAB40cTU
	iwhf1lGqIwL4cQuLi+8ZmDIZRVPQZjOSLhd4swUrhKXiOQ67nwtUTxxbIINww08=
X-Google-Smtp-Source: AGHT+IHYyHSNE7TBg6k1p5ActEtS8XwoP7+w6+E7w4xT/25SssyA6f41oyBxsiesr1O2mMmH10GKdQ==
X-Received: by 2002:ad4:4b28:0:b0:690:4902:7f17 with SMTP id s8-20020ad44b28000000b0069049027f17mr3088723qvw.21.1709228527337;
        Thu, 29 Feb 2024 09:42:07 -0800 (PST)
Received: from smtpclient.apple ([192.145.116.187])
        by smtp.gmail.com with ESMTPSA id em19-20020ad44f93000000b0068fdb03a3a3sm959077qvb.95.2024.02.29.09.42.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 09:42:06 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Joel Fernandes <joel@joelfernandes.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] net: raise RCU qs after each threaded NAPI poll
Date: Thu, 29 Feb 2024 12:41:55 -0500
Message-Id: <10FC3F5F-AA33-4F81-9EB6-87EB2D41F3EE@joelfernandes.org>
References: <55900c6a-f181-4c5c-8de2-bca640c4af3e@paulmck-laptop>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Yan Zhai <yan@cloudflare.com>,
 Eric Dumazet <edumazet@google.com>,
 Network Development <netdev@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
 Simon Horman <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Coco Li <lixiaoyan@google.com>,
 Wei Wang <weiwan@google.com>, Alexander Duyck <alexanderduyck@fb.com>,
 Hannes Frederic Sowa <hannes@stressinduktion.org>,
 LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org,
 bpf <bpf@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>,
 Mark Rutland <mark.rutland@arm.com>
In-Reply-To: <55900c6a-f181-4c5c-8de2-bca640c4af3e@paulmck-laptop>
To: paulmck@kernel.org
X-Mailer: iPhone Mail (21D61)



> On Feb 29, 2024, at 11:57=E2=80=AFAM, Paul E. McKenney <paulmck@kernel.org=
> wrote:
>=20
> =EF=BB=BFOn Thu, Feb 29, 2024 at 09:21:48AM -0500, Joel Fernandes wrote:
>>=20
>>=20
>>> On 2/28/2024 5:58 PM, Paul E. McKenney wrote:
>>> On Wed, Feb 28, 2024 at 02:48:44PM -0800, Alexei Starovoitov wrote:
>>>> On Wed, Feb 28, 2024 at 2:31=E2=80=AFPM Steven Rostedt <rostedt@goodmis=
.org> wrote:
>>>>>=20
>>>>> On Wed, 28 Feb 2024 14:19:11 -0800
>>>>> "Paul E. McKenney" <paulmck@kernel.org> wrote:
>>>>>=20
>>>>>>>>=20
>>>>>>>> Well, to your initial point, cond_resched() does eventually invoke
>>>>>>>> preempt_schedule_common(), so you are quite correct that as far as
>>>>>>>> Tasks RCU is concerned, cond_resched() is not a quiescent state.
>>>>>>>=20
>>>>>>> Thanks for confirming. :-)
>>>>>>=20
>>>>>> However, given that the current Tasks RCU use cases wait for trampoli=
nes
>>>>>> to be evacuated, Tasks RCU could make the choice that cond_resched()
>>>>>> be a quiescent state, for example, by adjusting rcu_all_qs() and
>>>>>> .rcu_urgent_qs accordingly.
>>>>>>=20
>>>>>> But this seems less pressing given the chance that cond_resched() mig=
ht
>>>>>> go away in favor of lazy preemption.
>>>>>=20
>>>>> Although cond_resched() is technically a "preemption point" and not tr=
uly a
>>>>> voluntary schedule, I would be happy to state that it's not allowed to=
 be
>>>>> called from trampolines, or their callbacks. Now the question is, does=
 BPF
>>>>> programs ever call cond_resched()? I don't think they do.
>>>>>=20
>>>>> [ Added Alexei ]
>>>>=20
>>>> I'm a bit lost in this thread :)
>>>> Just answering the above question.
>>>> bpf progs never call cond_resched() directly.
>>>> But there are sleepable (aka faultable) bpf progs that
>>>> can call some helper or kfunc that may call cond_resched()
>>>> in some path.
>>>> sleepable bpf progs are protected by rcu_tasks_trace.
>>>> That's a very different one vs rcu_tasks.
>>>=20
>>> Suppose that the various cond_resched() invocations scattered throughout=

>>> the kernel acted as RCU Tasks quiescent states, so that as soon as a
>>> given task executed a cond_resched(), synchronize_rcu_tasks() might
>>> return or call_rcu_tasks() might invoke its callback.
>>>=20
>>> Would that cause BPF any trouble?
>>>=20
>>> My guess is "no", because it looks like BPF is using RCU Tasks (as you
>>> say, as opposed to RCU Tasks Trace) only to wait for execution to leave a=

>>> trampoline.  But I trust you much more than I trust myself on this topic=
!
>>=20
>> But it uses RCU Tasks Trace as well (for sleepable bpf programs), not jus=
t
>> Tasks? Looks like that's what Alexei said above as well, and I confirmed i=
t in
>> bpf/trampoline.c
>>=20
>>        /* The trampoline without fexit and fmod_ret progs doesn't call or=
iginal
>>         * function and doesn't use percpu_ref.
>>         * Use call_rcu_tasks_trace() to wait for sleepable progs to finis=
h.
>>         * Then use call_rcu_tasks() to wait for the rest of trampoline as=
m
>>         * and normal progs.
>>         */
>>        call_rcu_tasks_trace(&im->rcu, __bpf_tramp_image_put_rcu_tasks);
>>=20
>> The code comment says it uses both.
>=20
> BPF does quite a few interesting things with these.
>=20
> But would you like to look at the update-side uses of RCU Tasks Rude
> to see if lazy preemption affects them?  I don't believe that there
> are any problems here, but we do need to check.

Sure I will be happy to. I am planning look at it in detail over the 3 day w=
eekend. Too much fun! ;-)

thanks,

- Joel



>=20
>                            Thanx, Paul

