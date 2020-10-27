Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1ADC29AD82
	for <lists+bpf@lfdr.de>; Tue, 27 Oct 2020 14:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752348AbgJ0NhM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Oct 2020 09:37:12 -0400
Received: from mail.efficios.com ([167.114.26.124]:44956 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752347AbgJ0NhL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Oct 2020 09:37:11 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 3D86E2C212D;
        Tue, 27 Oct 2020 09:37:09 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id uOhxkHk0w0PA; Tue, 27 Oct 2020 09:37:09 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id E0F1E2C203F;
        Tue, 27 Oct 2020 09:37:08 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com E0F1E2C203F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1603805828;
        bh=5vxbruFVegvc+6TjTUjdAWbbpMPPX6No3cdGEm7syY0=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=XfwWiQxr7vg4LSL6tApC2uCPISf2hu6lBusE69I8zAy/icwY5kzj1hTV4Kmjx0AF+
         0HaDK11C9EvwAJpxnrwSCcu34p62jB+V/u5VJ0D4/5s8OPZ631SDvGQMLLLt2yokVG
         iWp2fEYw5QAkYI5dmxWrpVkBXAsG2nGf+gV3bbZxmOZru1cflkG1m6na9prE1ShHzB
         d3s2k9cNj3pIe0HxwnNSlgee7Fwa7jzP6u2v9IDJbO43LIKh13L4Iye47Ig1KsmtOY
         S6KkTevvTbh9AgjlCHKUDNb2xPLRESx4CoKQ3ClrWEt+zOn5YWqRUq0epIrSuERo63
         nMVEA19qfBvSg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vn7AgBRFUqT6; Tue, 27 Oct 2020 09:37:08 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id CD58A2C212B;
        Tue, 27 Oct 2020 09:37:08 -0400 (EDT)
Date:   Tue, 27 Oct 2020 09:37:08 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Michael Jeanson <mjeanson@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>, paulmck <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, acme <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        bpf <bpf@vger.kernel.org>
Message-ID: <1631556114.38532.1603805828748.JavaMail.zimbra@efficios.com>
In-Reply-To: <20201026224301.gi4bakmj3pov5zyu@ast-mbp.dhcp.thefacebook.com>
References: <20201023195352.26269-1-mjeanson@efficios.com> <20201023195352.26269-2-mjeanson@efficios.com> <20201026224301.gi4bakmj3pov5zyu@ast-mbp.dhcp.thefacebook.com>
Subject: Re: [RFC PATCH 1/6] tracing: introduce sleepable tracepoints
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3968 (ZimbraWebClient - FF82 (Linux)/8.8.15_GA_3968)
Thread-Topic: tracing: introduce sleepable tracepoints
Thread-Index: 4pHNdC5/eJo5J7MQUBxo9CiBOWhRyg==
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


----- On Oct 26, 2020, at 6:43 PM, Alexei Starovoitov alexei.starovoitov@gmail.com wrote:

> On Fri, Oct 23, 2020 at 03:53:47PM -0400, Michael Jeanson wrote:
>> -#define __DO_TRACE(tp, proto, args, cond, rcuidle)			\
>> +#define __DO_TRACE(tp, proto, args, cond, rcuidle, tp_flags)		\
>>  	do {								\
>>  		struct tracepoint_func *it_func_ptr;			\
>>  		void *it_func;						\
>>  		void *__data;						\
>>  		int __maybe_unused __idx = 0;				\
>> +		bool maysleep = (tp_flags) & TRACEPOINT_MAYSLEEP;	\
>>  									\
>>  		if (!(cond))						\
>>  			return;						\
>> @@ -170,8 +178,13 @@ static inline struct tracepoint
>> *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>>  		/* srcu can't be used from NMI */			\
>>  		WARN_ON_ONCE(rcuidle && in_nmi());			\
>>  									\
>> -		/* keep srcu and sched-rcu usage consistent */		\
>> -		preempt_disable_notrace();				\
>> +		if (maysleep) {						\
>> +			might_sleep();					\
> 
> The main purpose of the patch set is to access user memory in tracepoints,
> right?

Yes, exactly.

> In such case I suggest to use stronger might_fault() here.
> We used might_sleep() in sleepable bpf and it wasn't enough to catch
> a combination where sleepable hook was invoked while mm->mmap_lock was
> taken which may cause a deadlock.

Good point! We will do that for the next round.

By the way, we named this "sleepable" tracepoint (with flag TRACEPOINT_MAYSLEEP),
but we are open to a better name. Would TRACEPOINT_MAYFAULT be more descriptive ?
(a "faultable" tracepoint sounds weird though)

Thanks,

Mathieu

> 
>> +			rcu_read_lock_trace();				\
>> +		} else {						\
>> +			/* keep srcu and sched-rcu usage consistent */	\
>> +			preempt_disable_notrace();			\
> > +		}							\

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
