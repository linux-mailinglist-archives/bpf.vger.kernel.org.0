Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 944A12999D0
	for <lists+bpf@lfdr.de>; Mon, 26 Oct 2020 23:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394648AbgJZWnH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Oct 2020 18:43:07 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:51625 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394645AbgJZWnG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Oct 2020 18:43:06 -0400
Received: by mail-pj1-f67.google.com with SMTP id a17so3997202pju.1;
        Mon, 26 Oct 2020 15:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5MfRXofF9NlrBG9ZLP3LfU6oLq4PML8/2jaAtOVRPAE=;
        b=GEesgwUvUQx4cf0Qe1lkyvKBaJjqtEle2qmu0urkRafskaqjdbpMeWf/VtJYR4AOr1
         SEI3t8eyiGbBN2BAb9qTkOTv0yeB2aUXL32AsAmyfhPTsphAk2iv6193YqoDdYyPk8YL
         b+aJlQSs8OZhZ+VEYlrXMKWXE4Z/aW4N2na7MUCaiMiJmKeHSx8iNM8AH8U1uNLTGleM
         PxQJIZYgIJ2OGCNMkfxeXnm3CIiIFDIcCHH096yC6+PSzLUqSPabSt10PRIKJk87liEU
         8YgRwBBj72/8VSxMWI3AAnHLp+3GIoXZSqZG+tAFIvCSqWIPq3A5luFBfqul19us01WU
         MVzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5MfRXofF9NlrBG9ZLP3LfU6oLq4PML8/2jaAtOVRPAE=;
        b=H9595bHcHoXapJNuPaC4uhJoieDF/gRxAHtlnrvCCc3khVKDek0MxzoQGuHCxwqM5h
         4hgwCPEdySY3lxJEOnFrytoprj5uY+ZSTVB9nwvlOoTGCA+YVDh1bQ6OgHRyXbVnD/ET
         lvcced7XqNr/k//RgwgxZ9iF0BlG54zID+MORD6mtWWI12N0JA3sZsyzKuIpOOIKC2Je
         XgSedhCJRu8wqY5Y7WnOGkJnBw1z2IzSqkCqo1a6sUrXKyQb+jdXlu0405nRJtptQRJI
         z3MiWNH+JVp9xrOQBWxq6W2OXpScLnpdFvl+QXAs4okoTRimsNBRVwl12zn+u5SF8qdb
         edpg==
X-Gm-Message-State: AOAM5337ZWT1jIZp98ECTgBul2TqW6jhywxve7k1rDItnGZupYBks3yk
        dgh2PuUnfWaqcXeGXLqatB8=
X-Google-Smtp-Source: ABdhPJwcxuwbKgQ6X3xbkftQBCMvgARuDZaWPpd81LUnrw9AZKB6TdU30C5OwqH62tUfNSGuou0Y+A==
X-Received: by 2002:a17:902:690b:b029:d6:41d8:bdc7 with SMTP id j11-20020a170902690bb02900d641d8bdc7mr45315plk.7.1603752185932;
        Mon, 26 Oct 2020 15:43:05 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::4:e0b4])
        by smtp.gmail.com with ESMTPSA id i1sm12086337pfa.168.2020.10.26.15.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 15:43:04 -0700 (PDT)
Date:   Mon, 26 Oct 2020 15:43:01 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Michael Jeanson <mjeanson@efficios.com>
Cc:     linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>, bpf@vger.kernel.org
Subject: Re: [RFC PATCH 1/6] tracing: introduce sleepable tracepoints
Message-ID: <20201026224301.gi4bakmj3pov5zyu@ast-mbp.dhcp.thefacebook.com>
References: <20201023195352.26269-1-mjeanson@efficios.com>
 <20201023195352.26269-2-mjeanson@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201023195352.26269-2-mjeanson@efficios.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 23, 2020 at 03:53:47PM -0400, Michael Jeanson wrote:
> -#define __DO_TRACE(tp, proto, args, cond, rcuidle)			\
> +#define __DO_TRACE(tp, proto, args, cond, rcuidle, tp_flags)		\
>  	do {								\
>  		struct tracepoint_func *it_func_ptr;			\
>  		void *it_func;						\
>  		void *__data;						\
>  		int __maybe_unused __idx = 0;				\
> +		bool maysleep = (tp_flags) & TRACEPOINT_MAYSLEEP;	\
>  									\
>  		if (!(cond))						\
>  			return;						\
> @@ -170,8 +178,13 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  		/* srcu can't be used from NMI */			\
>  		WARN_ON_ONCE(rcuidle && in_nmi());			\
>  									\
> -		/* keep srcu and sched-rcu usage consistent */		\
> -		preempt_disable_notrace();				\
> +		if (maysleep) {						\
> +			might_sleep();					\

The main purpose of the patch set is to access user memory in tracepoints, right?
In such case I suggest to use stronger might_fault() here.
We used might_sleep() in sleepable bpf and it wasn't enough to catch
a combination where sleepable hook was invoked while mm->mmap_lock was
taken which may cause a deadlock.

> +			rcu_read_lock_trace();				\
> +		} else {						\
> +			/* keep srcu and sched-rcu usage consistent */	\
> +			preempt_disable_notrace();			\
> +		}							\
