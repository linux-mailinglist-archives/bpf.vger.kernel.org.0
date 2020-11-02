Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 538222A3354
	for <lists+bpf@lfdr.de>; Mon,  2 Nov 2020 19:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbgKBSv3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 2 Nov 2020 13:51:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgKBSv3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 2 Nov 2020 13:51:29 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D242EC061A04
        for <bpf@vger.kernel.org>; Mon,  2 Nov 2020 10:51:28 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id b18so12409958qkc.9
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2020 10:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Rxilry/ji3nfiO3JLB2z5Ve/eVy0zWt8AyEvNUngD2c=;
        b=dKtG6LmAlh3COooqJe2opsc1vsdAPado7jNhzT70IvKawfZtenI/Woq5VZgoB0+zZ1
         m6OKk6LlKYnTnR6JxLDAm7d42kdgHj268lvzUjwxWfTYn5ds2bZAC9IgCf0sbhuiKKyl
         HxSiwHd5jFd/3DD72IanvqHDuEWCb2grAqguE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Rxilry/ji3nfiO3JLB2z5Ve/eVy0zWt8AyEvNUngD2c=;
        b=WgKHQ13UlmcNMzy88xcCy620MVExNKw1vhxmXkNCZ9XIkbojLJsa/amVjdV8pTKNrR
         lEt6Fx30CK9/0UgtQM9m4SjLcksfZrjpvj1z3ogZsC1FGJsUEkFFUm8lMZoRMF1F1pzw
         PWwcZ4VosFI9oGgQOXPG1lbpJ6NWImO2/Yjtb1lG4VOOl5Vly70ZqRRV9/UBYhufGrQC
         rfqigAOIkpt7XtcZ97sagA9AteFbbAhG9TSHZwMBE3VSyAuqJjY5bPgsbyGwNzog9eKP
         Yk2Vw0Zgo4HOsfpx2v7RpeUS+C6/iLix4yU1gjBPDIQsXwa99wi7jInmAPcEdNl3I7uF
         VJ1w==
X-Gm-Message-State: AOAM531TYoVxz7jS3HrYHkk9X36nWm9CNIFwP+8l2AZLZoKtbzf9mSFk
        aRMz7EeATxqo7/DDngOSl4shUw==
X-Google-Smtp-Source: ABdhPJzV3CsOTGlK/Pijavy7T/2537LjiZA3HhuqFIwRJyt8vCTUlZuhQJM8aH8pir7Z8yJb9pi6Qg==
X-Received: by 2002:a37:9a46:: with SMTP id c67mr16146337qke.292.1604343087896;
        Mon, 02 Nov 2020 10:51:27 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id x22sm8543868qki.104.2020.11.02.10.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 10:51:27 -0800 (PST)
Date:   Mon, 2 Nov 2020 13:51:26 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Michael Jeanson <mjeanson@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>, paulmck <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, acme <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [RFC PATCH 1/6] tracing: introduce sleepable tracepoints
Message-ID: <20201102185126.GB595952@google.com>
References: <20201023195352.26269-1-mjeanson@efficios.com>
 <20201023195352.26269-2-mjeanson@efficios.com>
 <20201026224301.gi4bakmj3pov5zyu@ast-mbp.dhcp.thefacebook.com>
 <1631556114.38532.1603805828748.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1631556114.38532.1603805828748.JavaMail.zimbra@efficios.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 27, 2020 at 09:37:08AM -0400, Mathieu Desnoyers wrote:
> 
> ----- On Oct 26, 2020, at 6:43 PM, Alexei Starovoitov alexei.starovoitov@gmail.com wrote:
> 
> > On Fri, Oct 23, 2020 at 03:53:47PM -0400, Michael Jeanson wrote:
> >> -#define __DO_TRACE(tp, proto, args, cond, rcuidle)			\
> >> +#define __DO_TRACE(tp, proto, args, cond, rcuidle, tp_flags)		\
> >>  	do {								\
> >>  		struct tracepoint_func *it_func_ptr;			\
> >>  		void *it_func;						\
> >>  		void *__data;						\
> >>  		int __maybe_unused __idx = 0;				\
> >> +		bool maysleep = (tp_flags) & TRACEPOINT_MAYSLEEP;	\
> >>  									\
> >>  		if (!(cond))						\
> >>  			return;						\
> >> @@ -170,8 +178,13 @@ static inline struct tracepoint
> >> *tracepoint_ptr_deref(tracepoint_ptr_t *p)
> >>  		/* srcu can't be used from NMI */			\
> >>  		WARN_ON_ONCE(rcuidle && in_nmi());			\
> >>  									\
> >> -		/* keep srcu and sched-rcu usage consistent */		\
> >> -		preempt_disable_notrace();				\
> >> +		if (maysleep) {						\
> >> +			might_sleep();					\
> > 
> > The main purpose of the patch set is to access user memory in tracepoints,
> > right?
> 
> Yes, exactly.
> 
> > In such case I suggest to use stronger might_fault() here.
> > We used might_sleep() in sleepable bpf and it wasn't enough to catch
> > a combination where sleepable hook was invoked while mm->mmap_lock was
> > taken which may cause a deadlock.
> 
> Good point! We will do that for the next round.
> 
> By the way, we named this "sleepable" tracepoint (with flag TRACEPOINT_MAYSLEEP),
> but we are open to a better name. Would TRACEPOINT_MAYFAULT be more descriptive ?
> (a "faultable" tracepoint sounds weird though)

What about keeping it might_sleep() here and then adding might_fault() in the
probe handler? Since the probe handler knows that it may cause page fault, it
could itself make sure about it.

One more thought: Should we make _all_ tracepoints sleepable, and then move
the preempt_disable() bit to the probe handler as needed? That could simplify
the tracepoint API as well. Steven said before that whoever registers probes
knows what they are doing so I am ok with that.

No strong feelings one way or the other, for either of these though.

thanks,

 - Joel

> 
> Thanks,
> 
> Mathieu
> 
> > 
> >> +			rcu_read_lock_trace();				\
> >> +		} else {						\
> >> +			/* keep srcu and sched-rcu usage consistent */	\
> >> +			preempt_disable_notrace();			\
> > > +		}							\
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
