Return-Path: <bpf+bounces-11289-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7B37B6FF7
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 19:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id B864F1C2040F
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 17:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6657D3B2BA;
	Tue,  3 Oct 2023 17:37:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E5CD2EB
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 17:37:31 +0000 (UTC)
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC050A6;
	Tue,  3 Oct 2023 10:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1696354646;
	bh=v6YWBoTIP+f7aIOUjc6YmisDl139de8ayHYE7Lvve78=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ohQsuWp6hs+97S0a6HF2z3/HYRXs5V6dDmDnJ1DP8cWkEo55lQSrfRastyeD7vynp
	 whSwJjXGxff2X6th22IsOfTBK36dJaKjcdgWz0KT1ysARfHPyh+9IsmMj8+hVQyvUk
	 Jw3xwqrraglrP1p2T9N+NK50/0Xd0VBEZkywzujgEfNx/VNuaTLeuq3wy6bL4j81WH
	 eAG19cQEptGjO1Kzu5drvWfPbphpF9K+qzpM3HHCNBMrhrLXs87Eeuk3fpnEuGFlmN
	 xlW1qRzD0WDF1xpo07dyGWrxP3ay+Rd5ETmhl8DUhXCCgo9dbDa3bwSiqIjn723c35
	 BNvsxPcHGLzug==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4S0Q4k2rDBz1VlH;
	Tue,  3 Oct 2023 13:37:26 -0400 (EDT)
Message-ID: <fab2b062-4fcd-a8f5-88fa-8afeec20fe5b@efficios.com>
Date: Tue, 3 Oct 2023 13:37:26 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH v3 1/5] tracing: Introduce faultable tracepoints (v3)
Content-Language: en-US
To: paulmck@kernel.org, Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Michael Jeanson <mjeanson@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>,
 Yonghong Song <yhs@fb.com>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 bpf@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>
References: <20231002202531.3160-1-mathieu.desnoyers@efficios.com>
 <20231002202531.3160-2-mathieu.desnoyers@efficios.com>
 <20231002191023.6175294d@gandalf.local.home>
 <97c559c9-51cf-415c-8b0b-39eba47b8898@paulmck-laptop>
 <20231002211936.5948253e@gandalf.local.home>
 <5d0771e9-332c-42cd-acf3-53d46bb691f3@paulmck-laptop>
 <20231003100854.7285d2a9@gandalf.local.home>
 <99ec6025-c170-459c-8b43-58cf1a85f832@paulmck-laptop>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <99ec6025-c170-459c-8b43-58cf1a85f832@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/3/23 13:33, Paul E. McKenney wrote:
> On Tue, Oct 03, 2023 at 10:08:54AM -0400, Steven Rostedt wrote:
>> On Tue, 3 Oct 2023 06:44:50 -0700
>> "Paul E. McKenney" <paulmck@kernel.org> wrote:
>>
>>>> That way it is clear what uses what, as I read the original paragraph a
>>>> couple of times and could have sworn that rcu_read_lock_trace() required
>>>> tasks to not block.
>>>
>>> That would work for me.  Would you like to send a patch, or would you
>>> rather we made the adjustments?
>>
>> Which ever.
> 
> OK, how about like this?
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit 973eb79ec46c16f13bb5b47ad14d44a1f1c79dc9
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Tue Oct 3 10:30:01 2023 -0700
> 
>      doc: Clarify RCU Tasks reader/updater checklist
>      
>      Currently, the reader/updater compatibility rules for the three RCU
>      Tasks flavors are squished together in a single paragraph, which can
>      result in confusion.  This commit therefore splits them out into a list,
>      clearly showing the distinction between these flavors.
>      

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks!

Mathieu

>      Reported-by: Steven Rostedt <rostedt@goodmis.org>
>      Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/Documentation/RCU/checklist.rst b/Documentation/RCU/checklist.rst
> index bd3c58c44bef..c432899aff22 100644
> --- a/Documentation/RCU/checklist.rst
> +++ b/Documentation/RCU/checklist.rst
> @@ -241,15 +241,22 @@ over a rather long period of time, but improvements are always welcome!
>   	srcu_struct.  The rules for the expedited RCU grace-period-wait
>   	primitives are the same as for their non-expedited counterparts.
>   
> -	If the updater uses call_rcu_tasks() or synchronize_rcu_tasks(),
> -	then the readers must refrain from executing voluntary
> -	context switches, that is, from blocking.  If the updater uses
> -	call_rcu_tasks_trace() or synchronize_rcu_tasks_trace(), then
> -	the corresponding readers must use rcu_read_lock_trace() and
> -	rcu_read_unlock_trace().  If an updater uses call_rcu_tasks_rude()
> -	or synchronize_rcu_tasks_rude(), then the corresponding readers
> -	must use anything that disables preemption, for example,
> -	preempt_disable() and preempt_enable().
> +	Similarly, it is necssary to correctly use the RCU Tasks flavors:
> +
> +	a.	If the updater uses synchronize_rcu_tasks() or
> +		call_rcu_tasks(), then the readers must refrain from
> +		executing voluntary context switches, that is, from
> +		blocking.
> +
> +	b.	If the updater uses call_rcu_tasks_trace()
> +		or synchronize_rcu_tasks_trace(), then the
> +		corresponding readers must use rcu_read_lock_trace()
> +		and rcu_read_unlock_trace().
> +
> +	c.	If an updater uses call_rcu_tasks_rude() or
> +		synchronize_rcu_tasks_rude(), then the corresponding
> +		readers must use anything that disables preemption,
> +		for example, preempt_disable() and preempt_enable().
>   
>   	Mixing things up will result in confusion and broken kernels, and
>   	has even resulted in an exploitable security issue.  Therefore,

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


