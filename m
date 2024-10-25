Return-Path: <bpf+bounces-43184-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECED89B0F41
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 21:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5030287ABA
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 19:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C250420EA50;
	Fri, 25 Oct 2024 19:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="S3dib0Xn"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C232D20EA3A;
	Fri, 25 Oct 2024 19:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729885235; cv=none; b=KjwKDrVXg4TxwyFrtA32Jh0bG5q640mf4xwk47b31JFTIYfgvu7lnzF+Ljt41PLxfL2Wvo6trmDikCbpGyv0CEs0bham2kmv0lV7Bz32at8i2QFy1atbx11LjH6wZBfBElIHbHJZJ2JQllSL4C7lMBZM8Q7FJmKqMqEjIKsGTvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729885235; c=relaxed/simple;
	bh=cuHsbF5BJeQhkqgZ1M5w1kdP5LOKhqOgmlBowlwA5mQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DPhUhSb04oSkt5IzvttzuWNiQy+HmET00sAF1VX6VVgy1Z7RodulRshjXZLG1tfNdcrGdHnwnpfPDqb9DAcI7NaQi4BS2wmc/qOhZnAwj+nE18k6BQoSEiMVrZ2ssBaVW6hbILA036/A7BpMEWKiJLHxcBgZhtrgQXzeB2yeKyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=S3dib0Xn; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1729885230;
	bh=cuHsbF5BJeQhkqgZ1M5w1kdP5LOKhqOgmlBowlwA5mQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=S3dib0XnYQ9G60uQO6weLae63DKdqb57tMmEdUbPEe6GYxjs/KpVnTzHxoVDx+1sG
	 IthR7JVwVCgh+yLKTS1987qr466WskMQ0rfwft9rEXgIpsbh+js0lJBtQeh/hhUdh/
	 BYH7FdidyE8fMa5PKR/61wIIhzsfGjEe7igiKMXPng1Pwp3X409ADDLQubdOQ3W46a
	 GwL+eRUHYskfCp3mn2QEsT8tsvPRlWJfGlB5vVmOpQxZAsqxQ2nAL5Nnu0JlNRTq8R
	 SbUKqdb8Smsn7btDIB031UWAfn+z6SmoLsLn/eJakuv65pwMwVyEXhKSwRr7Jkoe6S
	 2iZzI+lz+800w==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XZtRd6Drhz19FS;
	Fri, 25 Oct 2024 15:40:29 -0400 (EDT)
Message-ID: <f31710d3-e4d8-43ad-9ccb-6d13201756a3@efficios.com>
Date: Fri, 25 Oct 2024 15:38:48 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1] tracing: Fix syscall tracepoint use-after-free
To: Jordan Rife <jrife@google.com>
Cc: acme@kernel.org, alexander.shishkin@linux.intel.com,
 andrii.nakryiko@gmail.com, ast@kernel.org, bpf@vger.kernel.org,
 joel@joelfernandes.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com,
 mhiramat@kernel.org, mingo@redhat.com, mjeanson@efficios.com,
 namhyung@kernel.org, paulmck@kernel.org, peterz@infradead.org,
 rostedt@goodmis.org, syzbot+b390c8062d8387b6272a@syzkaller.appspotmail.com,
 yhs@fb.com
References: <20241025182149.500274-1-mathieu.desnoyers@efficios.com>
 <20241025190854.3030636-1-jrife@google.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20241025190854.3030636-1-jrife@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-25 15:08, Jordan Rife wrote:
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 59de664e580d..1191dc1d4206 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -3006,14 +3006,21 @@ static void bpf_link_free(struct bpf_link *link)
>>                  bpf_prog_put(link->prog);
> 
> I think we would need the same treatment with bpf_prog_put here.
> Something like,
> 
> tracepoint_call_rcu(raw_tp->btp->tp, &link->prog->aux->rcu,
> 		    bpf_link_defer_bpf_prog_put);
> 
> static void bpf_link_defer_bpf_prog_put(struct rcu_head *rcu)
> {
> 	struct bpf_prog_aux *aux = container_of(rcu, struct bpf_prog_aux, rcu);
> 	bpf_prog_put(aux->prox);
> }

Sure, I'll add this in a v2.

> 
> Alternatively, some context would need to be passed down to
> __bpf_prog_put_noref via the call to bpf_prog_put so it can choose
> whether or not to use call_rcu or call_rcu_tasks_trace.

Also possible, but more cumbersome.

> 
>> -static inline void release_probes(struct tracepoint_func *old)
>> +static bool tracepoint_is_syscall(struct tracepoint *tp)
>> +{
>> +       return !strcmp(tp->name, "sys_enter") || !strcmp(tp->name, "sys_exit");
>> +}
> 
> I'm curious if it might be better to add some field to struct
> tracepoint like "sleepable" rather than adding a special case here
> based on the name? Of course, if it's only ever going to be these
> two cases then maybe adding a new field doesn't make sense.

I know Steven is reluctant to bloat the tracepoint struct because there
are lots of tracepoint instances (thousands). So for now I thought that
just comparing the name would be a good start.

We can eventually go a different route as well: introduce a section just
to put the syscall tracepoints, and compare the struct tracepoint
pointers to the section begin/end range. But it's rather complex
for what should remain a simple fix.

Thanks,

Mathieu


> 
> -Jordan

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


