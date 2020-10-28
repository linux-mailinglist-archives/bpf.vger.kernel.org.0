Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 751DF29D50E
	for <lists+bpf@lfdr.de>; Wed, 28 Oct 2020 22:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728634AbgJ1V4m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Oct 2020 17:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728633AbgJ1V4l (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Oct 2020 17:56:41 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76264C0613D3;
        Wed, 28 Oct 2020 14:56:41 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t22so286221plr.9;
        Wed, 28 Oct 2020 14:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q0deFER1y5zH2dnb8wEA8nqaA8hp/wl10D8xfdso/0c=;
        b=DdrTWbJkBqbLsnyefrkAsK0JQLW/j43ySTRFlT2YhIuPRzBZoxzes9lqvDs1XYFr1M
         Qbk4xZlfYZjxMzPuXICnNi2vFpZRdooS41ZoW34Vzsl5B04oJhvVQYsqzJAwQ5jt9u48
         EXd6jeJQu1m7TlIJPVAMq/FtTexBsc3tW7GMwPBkeuQDseOzpfqHbuvhHZ4O8Nbo8Gad
         YtscQbM9tVl7GPxX8T3xMaio3LEU+VIt0CjSYReAqTPSClw2CEOaVVaWzTRl0Yq2DdV5
         326CaoG+9BUMVeMRGS2T833z/ZEChB98wm/Agz0jaoP9TM5xLUycjnBaNQBB/fp5mTxf
         CbdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q0deFER1y5zH2dnb8wEA8nqaA8hp/wl10D8xfdso/0c=;
        b=nruYa54BnPsJuEFAFBEHvA4CJE3DCGg4jt3paxysKL1iJPcxwz3+30TlE/q+RhIKjR
         wRwhFXMNigqw2ioZ0OKI1/dRH2yCrXym8owv5P/xfxJ/3BTpkPaJyyYyIGAE+pzSCe70
         lNZ4MYG17Ja6hhVDQKGYzswZ+Z5NCthHyJcRS7I7JwBCfozpU9loMtWppxZ6uG2Nzc+e
         7YELJZdbSgvuX4pJt2KoIDS8zDXZUAnY09PZ9TKpLdwF65UkXqJcoW9yjaOMNZXrhjnI
         uOpMQRLMBqCFaj9NBOdz9K3LIScjF37lH3NjS8YGvxOmW8rpoWKfg3G7K+/Bli2AS24M
         J1Kg==
X-Gm-Message-State: AOAM532Y+oyZ2jBwPBqdaY9zH6nVPOiFpDFC9zKHF1OhBVGQXp+b457M
        kLTocn11h+pXKbDugoevnj3+lVuy2HfUAQ==
X-Google-Smtp-Source: ABdhPJymJjE2L2a9NUrMrih2ODObIj/y609DDc4WIfVc9enlv0bVkzgNhyftNNcqrAdIECpWfAE/bQ==
X-Received: by 2002:aa7:8055:0:b029:15f:cbe9:1aad with SMTP id y21-20020aa780550000b029015fcbe91aadmr1173932pfm.71.1603920238453;
        Wed, 28 Oct 2020 14:23:58 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::4:1c8])
        by smtp.gmail.com with ESMTPSA id x26sm514837pfn.178.2020.10.28.14.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 14:23:57 -0700 (PDT)
Date:   Wed, 28 Oct 2020 14:23:50 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
Subject: Re: [RFC PATCH 1/6] tracing: introduce sleepable tracepoints
Message-ID: <20201028212350.jj4mbnbk6hdcbymo@ast-mbp.dhcp.thefacebook.com>
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

bpf kept 'sleepable' as a name. 'faultable' is too misleading.
