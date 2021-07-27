Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9073D71C4
	for <lists+bpf@lfdr.de>; Tue, 27 Jul 2021 11:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236000AbhG0JOr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Jul 2021 05:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235940AbhG0JOq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Jul 2021 05:14:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24968C061757
        for <bpf@vger.kernel.org>; Tue, 27 Jul 2021 02:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YUkK8bzRXtHOBN2No6rmJdL7lALIJEXehABnj+h0A4w=; b=PZ4cBtkRZcPAxIJsFbVJZ5Rpp3
        4AVyiAp9UhJWPimLW+vwA6XBCN3bq4+BP0KwLUqrZY/Ixp8Dz8fDv8srddmDk3GuhI+cRlQ0xhKgI
        z3QSaJq0grmZSqmyb0GSjOYN+f/SQSXO8zgVJLQTmRNO6AFCNBJtmjCRSGwo7zPd7W8iVStkrbs6/
        qk1W7lIl8B2vQbyVSjGJBWqhsXrEz60F6TBAz7KK0yWEjxXwTFzdHyiK7bXkUPZqowlppp/cOONOq
        j699tmNIdQuGRZNAiwuEWA7qU+CYRA0/wVRAiKLjz6/ML+YeLGQil7duonk9NrCmVLJ54WSShFXSM
        7jB49ePw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8J7t-00Erja-3n; Tue, 27 Jul 2021 09:12:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B64BC300233;
        Tue, 27 Jul 2021 11:11:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A073B213986EE; Tue, 27 Jul 2021 11:11:48 +0200 (CEST)
Date:   Tue, 27 Jul 2021 11:11:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
Subject: Re: [PATCH v2 bpf-next 05/14] bpf: allow to specify user-provided
 context value for BPF perf links
Message-ID: <YP/N1HR6GAanBd9m@hirez.programming.kicks-ass.net>
References: <20210726161211.925206-1-andrii@kernel.org>
 <20210726161211.925206-6-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726161211.925206-6-andrii@kernel.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 26, 2021 at 09:12:02AM -0700, Andrii Nakryiko wrote:
> Add ability for users to specify custom u64 value when creating BPF link for
> perf_event-backed BPF programs (kprobe/uprobe, perf_event, tracepoints).

If I read this right, the value is dependent on the link, not the
program. In which case:

> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 2d510ad750ed..97ab46802800 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -762,6 +762,7 @@ struct perf_event {
>  #ifdef CONFIG_BPF_SYSCALL
>  	perf_overflow_handler_t		orig_overflow_handler;
>  	struct bpf_prog			*prog;
> +	u64				user_ctx;
>  #endif
>  
>  #ifdef CONFIG_EVENT_TRACING
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index 8ac92560d3a3..4543852f1480 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -675,7 +675,7 @@ trace_trigger_soft_disabled(struct trace_event_file *file)
>  
>  #ifdef CONFIG_BPF_EVENTS
>  unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx);
> -int perf_event_attach_bpf_prog(struct perf_event *event, struct bpf_prog *prog);
> +int perf_event_attach_bpf_prog(struct perf_event *event, struct bpf_prog *prog, u64 user_ctx);

This API would be misleading, because it is about setting the program.

>  void perf_event_detach_bpf_prog(struct perf_event *event);
>  int perf_event_query_prog_array(struct perf_event *event, void __user *info);
>  int bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *prog);

> @@ -9966,6 +9968,7 @@ static int perf_event_set_bpf_handler(struct perf_event *event, struct bpf_prog
>  	}
>  
>  	event->prog = prog;
> +	event->user_ctx = user_ctx;
>  	event->orig_overflow_handler = READ_ONCE(event->overflow_handler);
>  	WRITE_ONCE(event->overflow_handler, bpf_overflow_handler);
>  	return 0;

Also, the name @user_ctx is a bit confusing. Would something like
@bpf_cookie or somesuch not be a better name?

Combined would it not make more sense to add something like:

extern int perf_event_set_bpf_cookie(struct perf_event *event, u64 cookie);


