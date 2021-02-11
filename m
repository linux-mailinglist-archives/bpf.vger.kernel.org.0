Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C75319333
	for <lists+bpf@lfdr.de>; Thu, 11 Feb 2021 20:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbhBKThT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Feb 2021 14:37:19 -0500
Received: from mail.efficios.com ([167.114.26.124]:58698 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbhBKThT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Feb 2021 14:37:19 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id A7F2C311016;
        Thu, 11 Feb 2021 14:36:37 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 7eMdqTb-xpIR; Thu, 11 Feb 2021 14:36:37 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 5519E31108D;
        Thu, 11 Feb 2021 14:36:37 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 5519E31108D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1613072197;
        bh=jJjUBAbEcdGN3E4oDebELKmHNg8R9P6mQJ6jT1OOAUc=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=AMyB5eBfwUD6WCZ3wC3Wtn70iAPVkcMiiKow/De+yEd7A4IZfal4kBJ8Ha3to9LkW
         JTVCfA4faSEEruzzs50B5xl137PhwJddpW+oBHOUx4jVr3JiPPluInxh4BAJWXgR0N
         2sJmdQUW/xt1Sekqd9R+wMHPTaDRxNoh8subWKY6ZLeo50pcC8Pj65ss9DHzYWjcPT
         qsOpxuYDIycphRUK9jKvH5o5AF+Hqf4Iu6bpaxlAZDTcQ+5kbrrYYVRbzZlO35/Y4G
         r0EA8cy05xKMGhwL4HhS7ZPi/FXE74Ta+r6GTyJW7KPqKo7dNx9mrPKnIOwIQS63MW
         IV7Rspa66m4nA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gx1bk8xZqs3m; Thu, 11 Feb 2021 14:36:37 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 40FE8310D66;
        Thu, 11 Feb 2021 14:36:37 -0500 (EST)
Date:   Thu, 11 Feb 2021 14:36:37 -0500 (EST)
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
Message-ID: <1087071545.17266.1613072197171.JavaMail.zimbra@efficios.com>
In-Reply-To: <20201028212350.jj4mbnbk6hdcbymo@ast-mbp.dhcp.thefacebook.com>
References: <20201023195352.26269-1-mjeanson@efficios.com> <20201023195352.26269-2-mjeanson@efficios.com> <20201026224301.gi4bakmj3pov5zyu@ast-mbp.dhcp.thefacebook.com> <1631556114.38532.1603805828748.JavaMail.zimbra@efficios.com> <20201028212350.jj4mbnbk6hdcbymo@ast-mbp.dhcp.thefacebook.com>
Subject: Re: [RFC PATCH 1/6] tracing: introduce sleepable tracepoints
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (ZimbraWebClient - FF85 (Linux)/8.8.15_GA_3996)
Thread-Topic: tracing: introduce sleepable tracepoints
Thread-Index: g60dIBLtDp5Cx+xLhMNhEnQdk8O8Vg==
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

----- On Oct 28, 2020, at 5:23 PM, Alexei Starovoitov alexei.starovoitov@gmail.com wrote:

> On Tue, Oct 27, 2020 at 09:37:08AM -0400, Mathieu Desnoyers wrote:
>> 
>> ----- On Oct 26, 2020, at 6:43 PM, Alexei Starovoitov
>> alexei.starovoitov@gmail.com wrote:
>> 
>> > On Fri, Oct 23, 2020 at 03:53:47PM -0400, Michael Jeanson wrote:
>> >> -#define __DO_TRACE(tp, proto, args, cond, rcuidle)			\
>> >> +#define __DO_TRACE(tp, proto, args, cond, rcuidle, tp_flags)		\
>> >>  	do {								\
>> >>  		struct tracepoint_func *it_func_ptr;			\
>> >>  		void *it_func;						\
>> >>  		void *__data;						\
>> >>  		int __maybe_unused __idx = 0;				\
>> >> +		bool maysleep = (tp_flags) & TRACEPOINT_MAYSLEEP;	\
>> >>  									\
>> >>  		if (!(cond))						\
>> >>  			return;						\
>> >> @@ -170,8 +178,13 @@ static inline struct tracepoint
>> >> *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>> >>  		/* srcu can't be used from NMI */			\
>> >>  		WARN_ON_ONCE(rcuidle && in_nmi());			\
>> >>  									\
>> >> -		/* keep srcu and sched-rcu usage consistent */		\
>> >> -		preempt_disable_notrace();				\
>> >> +		if (maysleep) {						\
>> >> +			might_sleep();					\
>> > 
>> > The main purpose of the patch set is to access user memory in tracepoints,
>> > right?
>> 
>> Yes, exactly.
>> 
>> > In such case I suggest to use stronger might_fault() here.
>> > We used might_sleep() in sleepable bpf and it wasn't enough to catch
>> > a combination where sleepable hook was invoked while mm->mmap_lock was
>> > taken which may cause a deadlock.
>> 
>> Good point! We will do that for the next round.
>> 
>> By the way, we named this "sleepable" tracepoint (with flag
>> TRACEPOINT_MAYSLEEP),
>> but we are open to a better name. Would TRACEPOINT_MAYFAULT be more descriptive
>> ?
>> (a "faultable" tracepoint sounds weird though)
> 
> bpf kept 'sleepable' as a name. 'faultable' is too misleading.

We're working on an updated patchset for those "sleepable tracepoints", and considering
that those are really "tracepoints allowing page faults", I must admit that I am
uncomfortable with the confusion between "sleep" and "fault" in the naming here.

I am tempted to do the following changes:

- Change name from "sleepable tracepoints" to a better suited "tracepoints allowing page faults",
- Use might_fault() rather than might_sleep() in __DO_TRACE(), effectively guaranteeing that all
  probes connecting to a tracepoint which allows page faults can indeed take page faults.
- Change TRACEPOINT_MAYSLEEP into TRACEPOINT_MAYFAULT.

Any objections ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
