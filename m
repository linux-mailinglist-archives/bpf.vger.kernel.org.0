Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B05E4166B78
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2020 01:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729448AbgBUAUp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Feb 2020 19:20:45 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44897 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729429AbgBUAUo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Feb 2020 19:20:44 -0500
Received: by mail-pl1-f193.google.com with SMTP id d9so94516plo.11
        for <bpf@vger.kernel.org>; Thu, 20 Feb 2020 16:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Plslq0a/WlH9+0wsRfxUN/LmRsw3WQkY4fgXi9ixwsc=;
        b=FkpuTNQLtoitah5hPi0YUKeg08H4CsA2euPhDcAkduZeFH/lBTvyv7io4vwS17q84B
         l1Sc/iSRu2T1VNHZHJ7j620/J86Ss52l7jHQbG9hZu38KIdCJ4qKJAZb6Zh8B4felH78
         4AhXAmizgyeP7Po6ZqhRnh/9JAR/OuzwwoVm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Plslq0a/WlH9+0wsRfxUN/LmRsw3WQkY4fgXi9ixwsc=;
        b=OUSrn9ECrwANf9NTbabPHD8fBp0IM9x2fCQGPvRfLMr79fO2gjfy9pXq+8DtjcdaUV
         jWIqldtXSv5tUww3RjsVUIZKE1R6P8IQV7Fsvo1aWuQqOXGum4QIVFScPjOIUJfwb1nU
         eIq4nfjJofwX5aEauapPbRw+0dBuyL87YsXFxbCzHtSPniwBJvMF8E0HTMGAj6IKUu8O
         96hzGf3waI/g6LT2Yl6BpsnKGpdPbQIdqruqiV1ngSyZC6BzQ+4xkceIP+mG7YxhmV1g
         XiiFDLLk0AYSy6uTgr7AvM5SjYMNvbFxD4+56131vxuRehg16mqshtbp1uo53tngwIsB
         bN+A==
X-Gm-Message-State: APjAAAWshLk3j6SO40VGczWVKoz0Yi7NtDvlhTqPmg0QxP/mX+c/HCZu
        6K/5I0UtysKVZsr0FHDU0k37PQ==
X-Google-Smtp-Source: APXvYqzqh/Pw6jbdTL7oDjQkv3YylBIF/nuO3giT5bTVTu7eSdsKg0IVHAgVcKWmbpqCQoqcpsVKTg==
X-Received: by 2002:a17:902:321:: with SMTP id 30mr35390771pld.130.1582244442771;
        Thu, 20 Feb 2020 16:20:42 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f9sm698180pfd.141.2020.02.20.16.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 16:20:41 -0800 (PST)
Date:   Thu, 20 Feb 2020 16:20:40 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sebastian Sewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Clark Williams <williams@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Will Drewry <wad@chromium.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [RFC patch 09/19] bpf: Use BPF_PROG_RUN_PIN_ON_CPU() at simple
 call sites.
Message-ID: <202002201616.21FA55E@keescook>
References: <20200214133917.304937432@linutronix.de>
 <20200214161503.804093748@linutronix.de>
 <87a75ftkwu.fsf@linux.intel.com>
 <875zg3q7cn.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875zg3q7cn.fsf@nanos.tec.linutronix.de>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 19, 2020 at 10:00:56AM +0100, Thomas Gleixner wrote:
> Vinicius Costa Gomes <vinicius.gomes@intel.com> writes:
> 
> Cc+: seccomp folks 
> 
> > Thomas Gleixner <tglx@linutronix.de> writes:
> >
> >> From: David Miller <davem@davemloft.net>
> 
> Leaving content for reference
> 
> >> All of these cases are strictly of the form:
> >>
> >> 	preempt_disable();
> >> 	BPF_PROG_RUN(...);
> >> 	preempt_enable();
> >>
> >> Replace this with BPF_PROG_RUN_PIN_ON_CPU() which wraps BPF_PROG_RUN()
> >> with:
> >>
> >> 	migrate_disable();
> >> 	BPF_PROG_RUN(...);
> >> 	migrate_enable();
> >>
> >> On non RT enabled kernels this maps to preempt_disable/enable() and on RT
> >> enabled kernels this solely prevents migration, which is sufficient as
> >> there is no requirement to prevent reentrancy to any BPF program from a
> >> preempting task. The only requirement is that the program stays on the same
> >> CPU.
> >>
> >> Therefore, this is a trivially correct transformation.
> >>
> >> [ tglx: Converted to BPF_PROG_RUN_PIN_ON_CPU() ]
> >>
> >> Signed-off-by: David S. Miller <davem@davemloft.net>
> >> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> >>
> >> ---
> >>  include/linux/filter.h    |    4 +---
> >>  kernel/seccomp.c          |    4 +---
> >>  net/core/flow_dissector.c |    4 +---
> >>  net/core/skmsg.c          |    8 ++------
> >>  net/kcm/kcmsock.c         |    4 +---
> >>  5 files changed, 6 insertions(+), 18 deletions(-)
> >>
> >> --- a/include/linux/filter.h
> >> +++ b/include/linux/filter.h
> >> @@ -713,9 +713,7 @@ static inline u32 bpf_prog_run_clear_cb(
> >>  	if (unlikely(prog->cb_access))
> >>  		memset(cb_data, 0, BPF_SKB_CB_LEN);
> >>  
> >> -	preempt_disable();
> >> -	res = BPF_PROG_RUN(prog, skb);
> >> -	preempt_enable();
> >> +	res = BPF_PROG_RUN_PIN_ON_CPU(prog, skb);
> >>  	return res;
> >>  }
> >>  
> >> --- a/kernel/seccomp.c
> >> +++ b/kernel/seccomp.c
> >> @@ -268,16 +268,14 @@ static u32 seccomp_run_filters(const str
> >>  	 * All filters in the list are evaluated and the lowest BPF return
> >>  	 * value always takes priority (ignoring the DATA).
> >>  	 */
> >> -	preempt_disable();
> >>  	for (; f; f = f->prev) {
> >> -		u32 cur_ret = BPF_PROG_RUN(f->prog, sd);
> >> +		u32 cur_ret = BPF_PROG_RUN_PIN_ON_CPU(f->prog, sd);
> >>
> >
> > More a question really, isn't the behavior changing here? i.e. shouldn't
> > migrate_disable()/migrate_enable() be moved to outside the loop? Or is
> > running seccomp filters on different cpus not a problem?
> 
> In my understanding this is a list of filters and they are independent
> of each other.
> 
> Kees, Will. Andy?

They're technically independent, but they are related to each
other. (i.e. order matters, process hierarchy matters, etc). There's no
reason I can see that we can't switch CPUs between running them, though.
(AIUI, nothing here would suddenly make these run in parallel, right?)

As long as "current" is still "current", and they run in the same order,
we'll get the same final result as far as seccomp is concerned.

-- 
Kees Cook
