Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76D95D5F0D
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2019 11:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731010AbfJNJg0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Oct 2019 05:36:26 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55190 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730667AbfJNJg0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Oct 2019 05:36:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LsMYLS/Y8cXFlMO0GSn0Yr3BGu1XV5VAX95XcUxBpz0=; b=XvAnoRVKvYRsEt/t8d+FAEQPl
        B2q8swT9UjlU8sRDS9hAToqyHzJLXEvw6tO47ML5EE88nfG6Cs+/lglrJiXTvJsdGiwk7Gn3B+fOg
        d/KVk71GetGtHjFPkZmmNP9hpm3XNZPvZKHXKJtyG7MXCIxjQO+9ogr3UoyhzPcBvUkXJ/2FGwzjo
        MT6aDZxByHv6N7QmSF865+Q8m+FdLf45V1GFwZm+UvbwvUKCoYXYwRB7Z7buZsr8Uk/Y1Vjd9nu88
        SBtwYHS6X1OCWrTuYhgDYfYKmmcGs4/l3uPYqMJ7urLlxx9FG5EHeWRdIq4jHkLNqjUvIcQ2btmcQ
        ytw851Dow==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iJwlY-0005EW-2w; Mon, 14 Oct 2019 09:35:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 717FC300F3F;
        Mon, 14 Oct 2019 11:34:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 555A926530285; Mon, 14 Oct 2019 11:35:44 +0200 (CEST)
Date:   Mon, 14 Oct 2019 11:35:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        primiano@google.com, rsavitski@google.com, jeffv@google.com,
        kernel-team@android.com, Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Ingo Molnar <mingo@redhat.com>,
        James Morris <jmorris@namei.org>, Jiri Olsa <jolsa@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        linux-security-module@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Namhyung Kim <namhyung@kernel.org>, selinux@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH] perf_event: Add support for LSM and SELinux checks
Message-ID: <20191014093544.GB2328@hirez.programming.kicks-ass.net>
References: <20191011160330.199604-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011160330.199604-1-joel@joelfernandes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 11, 2019 at 12:03:30PM -0400, Joel Fernandes (Google) wrote:

> @@ -4761,6 +4762,7 @@ int perf_event_release_kernel(struct perf_event *event)
>  	}
>  
>  no_ctx:
> +	security_perf_event_free(event);
>  	put_event(event); /* Must be the 'last' reference */
>  	return 0;
>  }

> @@ -10553,11 +10568,16 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
>  		}
>  	}
>  
> +	err = security_perf_event_alloc(event);
> +	if (err)
> +		goto err_security;
> +
>  	/* symmetric to unaccount_event() in _free_event() */
>  	account_event(event);
>  
>  	return event;
>  
> +err_security:
>  err_addr_filters:
>  	kfree(event->addr_filter_ranges);
>  

There's a bunch of problems here I think:

 - err_security is named wrong; the naming scheme is to name the label
   after the last thing that succeeded / first thing that needs to be
   undone.

 - per that, you're forgetting to undo 'get_callchain_buffers()'

 - perf_event_release_kernel() is not a full match to
   perf_event_alloc(), inherited events get created by
   perf_event_alloc() but never pass through
   perf_event_release_kernel().


I'm thinking the below patch on top should ammend these issues; please
verify.

---
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4540,6 +4540,8 @@ static void _free_event(struct perf_even
 
 	unaccount_event(event);
 
+	security_perf_event_free(event);
+
 	if (event->rb) {
 		/*
 		 * Can happen when we close an event with re-directed output.
@@ -4774,7 +4776,6 @@ int perf_event_release_kernel(struct per
 	}
 
 no_ctx:
-	security_perf_event_free(event);
 	put_event(event); /* Must be the 'last' reference */
 	return 0;
 }
@@ -10595,14 +10596,18 @@ perf_event_alloc(struct perf_event_attr
 
 	err = security_perf_event_alloc(event);
 	if (err)
-		goto err_security;
+		goto err_callchain_buffer;
 
 	/* symmetric to unaccount_event() in _free_event() */
 	account_event(event);
 
 	return event;
 
-err_security:
+err_callchain_buffer:
+	if (!event->parent) {
+		if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN)
+			put_callchain_buffers();
+	}
 err_addr_filters:
 	kfree(event->addr_filter_ranges);
 
