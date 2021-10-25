Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F12C343A5D2
	for <lists+bpf@lfdr.de>; Mon, 25 Oct 2021 23:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbhJYV3B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Oct 2021 17:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232689AbhJYV26 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Oct 2021 17:28:58 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C145C061231
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 14:26:26 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id s136so11978148pgs.4
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 14:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2fNJb298Duxoc3HaUlc7Nf67pHRtdIDXApm1+Pxj1CY=;
        b=TRqNlEXzHsdKTmPnnwk8ZuzVAreo87ING3F8W9WSUyNo4p77FsHs+6hAFCTFjYtSxQ
         T5FA6kieCvJOBGjblwVzlSD0BBLfceotvpOTPjKgajGY0lOcLq9nAdK0v4y9JmxZ9pEY
         5P6Vede0VGDZnBZ3bin+D6Nttc084+XGmRXho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2fNJb298Duxoc3HaUlc7Nf67pHRtdIDXApm1+Pxj1CY=;
        b=mWFZopnudAlwbnUSSsPuxisic3PyKAMWzvB8wC/G6+BwQ4iMv37/nhjbk0rJFpkQ+I
         avkiugf6AUqv2gzbE8GybWHysp6RP8SPfMp9MN1ZS75rzogUjvUN5pn4kQnb6S38YqEp
         c1mw4Ut11l5SBktKHXUbkTq2Zlr1d90y5UL4Ku5U5rM+NjQ8g/32N6bxvNOU9044ML0o
         fZPufZuJT8I3J2nuFViiWnc9tuKhHBCv6I6tYq/vv8ALenjOX3VHShXg8Ihe5i/ezNfm
         t7kPTqY0DHVrtmYrj1O9herEhRkZ5y1U3YXrws8QSv40kfLZqHzbSb8jb1NFxfT0wVeP
         Tiwg==
X-Gm-Message-State: AOAM532F5OrtuycolDllc68eNDLMwAp6YE91vRFzW/5MejlE5WlXgxZE
        H2XyS++3seN2NFg8ICG/I5eYvg==
X-Google-Smtp-Source: ABdhPJyZvuEMI5RNT65jhw/Gxgqo6oZ5d4AtEJIdaWdwCgtF89fexmlMVa3x/LPVtV6kewwQYslSEA==
X-Received: by 2002:a62:5ec2:0:b0:44d:47e2:4b3b with SMTP id s185-20020a625ec2000000b0044d47e24b3bmr21508392pfb.38.1635197185593;
        Mon, 25 Oct 2021 14:26:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s2sm25055172pjs.56.2021.10.25.14.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 14:26:25 -0700 (PDT)
Date:   Mon, 25 Oct 2021 14:26:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     akpm@linux-foundation.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, arnaldo.melo@gmail.com,
        pmladek@suse.com, peterz@infradead.org, viro@zeniv.linux.org.uk,
        valentin.schneider@arm.com, qiang.zhang@windriver.com,
        robdclark@chromium.org, christian@brauner.io,
        dietmar.eggemann@arm.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, davem@davemloft.net, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        dennis.dalessandro@cornelisnetworks.com,
        mike.marciniszyn@cornelisnetworks.com, dledford@redhat.com,
        jgg@ziepe.ca, linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, oliver.sang@intel.com, lkp@intel.com,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH v6 09/12] tools/perf/test: make perf test adopt to task
 comm size change
Message-ID: <202110251426.2921B7BDD7@keescook>
References: <20211025083315.4752-1-laoar.shao@gmail.com>
 <20211025083315.4752-10-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025083315.4752-10-laoar.shao@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 25, 2021 at 08:33:12AM +0000, Yafang Shao wrote:
> kernel test robot reported a perf-test failure after I extended task comm
> size from 16 to 24. The failure as follows,
> 
> 2021-10-13 18:00:46 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-317419b91ef4eff4e2f046088201e4dc4065caa0/tools/perf/perf test 15
> 15: Parse sched tracepoints fields                                  : FAILED!
> 
> The reason is perf-test requires a fixed-size task comm. If we extend
> task comm size to 24, it will not equil with the required size 16 in perf
> test.
> 
> After some analyzation, I found perf itself can adopt to the size
> change, for example, below is the output of perf-sched after I extend
> comm size to 24 -
> 
> task    614 (            kthreadd:        84), nr_events: 1
> task    615 (             systemd:       843), nr_events: 1
> task    616 (     networkd-dispat:      1026), nr_events: 1
> task    617 (             systemd:       846), nr_events: 1
> 
> $ cat /proc/843/comm
> networkd-dispatcher
> 
> The task comm can be displayed correctly as expected.
> 
> Replace old hard-coded 16 with the new one can fix the warning, but we'd
> better make the test accept both old and new sizes, then it can be
> backward compatibility.
> 
> After this patch, the perf-test succeeds no matter task comm is 16 or
> 24 -
> 
> 15: Parse sched tracepoints fields                                  : Ok
> 
> This patch is a preparation for the followup patch.
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Suggested-by: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Petr Mladek <pmladek@suse.com>

I'll let the perf folks comment on this one. :)

-Kees

> ---
>  tools/include/linux/sched.h       | 11 +++++++++++
>  tools/perf/tests/evsel-tp-sched.c | 26 ++++++++++++++++++++------
>  2 files changed, 31 insertions(+), 6 deletions(-)
>  create mode 100644 tools/include/linux/sched.h
> 
> diff --git a/tools/include/linux/sched.h b/tools/include/linux/sched.h
> new file mode 100644
> index 000000000000..0d575afd7f43
> --- /dev/null
> +++ b/tools/include/linux/sched.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _TOOLS_LINUX_SCHED_H
> +#define _TOOLS_LINUX_SCHED_H
> +
> +/* Keep both length for backward compatibility */
> +enum {
> +	TASK_COMM_LEN_16 = 16,
> +	TASK_COMM_LEN = 24,
> +};
> +
> +#endif  /* _TOOLS_LINUX_SCHED_H */
> diff --git a/tools/perf/tests/evsel-tp-sched.c b/tools/perf/tests/evsel-tp-sched.c
> index f9e34bd26cf3..029f2a8c8e51 100644
> --- a/tools/perf/tests/evsel-tp-sched.c
> +++ b/tools/perf/tests/evsel-tp-sched.c
> @@ -1,11 +1,13 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <linux/err.h>
> +#include <linux/sched.h>
>  #include <traceevent/event-parse.h>
>  #include "evsel.h"
>  #include "tests.h"
>  #include "debug.h"
>  
> -static int evsel__test_field(struct evsel *evsel, const char *name, int size, bool should_be_signed)
> +static int evsel__test_field_alt(struct evsel *evsel, const char *name,
> +				 int size, int alternate_size, bool should_be_signed)
>  {
>  	struct tep_format_field *field = evsel__field(evsel, name);
>  	int is_signed;
> @@ -23,15 +25,24 @@ static int evsel__test_field(struct evsel *evsel, const char *name, int size, bo
>  		ret = -1;
>  	}
>  
> -	if (field->size != size) {
> -		pr_debug("%s: \"%s\" size (%d) should be %d!\n",
> +	if (field->size != size && field->size != alternate_size) {
> +		pr_debug("%s: \"%s\" size (%d) should be %d",
>  			 evsel->name, name, field->size, size);
> +		if (alternate_size > 0)
> +			pr_debug(" or %d", alternate_size);
> +		pr_debug("!\n");
>  		ret = -1;
>  	}
>  
>  	return ret;
>  }
>  
> +static int evsel__test_field(struct evsel *evsel, const char *name,
> +			     int size, bool should_be_signed)
> +{
> +	return evsel__test_field_alt(evsel, name, size, -1, should_be_signed);
> +}
> +
>  int test__perf_evsel__tp_sched_test(struct test *test __maybe_unused, int subtest __maybe_unused)
>  {
>  	struct evsel *evsel = evsel__newtp("sched", "sched_switch");
> @@ -42,7 +53,8 @@ int test__perf_evsel__tp_sched_test(struct test *test __maybe_unused, int subtes
>  		return -1;
>  	}
>  
> -	if (evsel__test_field(evsel, "prev_comm", 16, false))
> +	if (evsel__test_field_alt(evsel, "prev_comm", TASK_COMM_LEN_16,
> +				  TASK_COMM_LEN, false))
>  		ret = -1;
>  
>  	if (evsel__test_field(evsel, "prev_pid", 4, true))
> @@ -54,7 +66,8 @@ int test__perf_evsel__tp_sched_test(struct test *test __maybe_unused, int subtes
>  	if (evsel__test_field(evsel, "prev_state", sizeof(long), true))
>  		ret = -1;
>  
> -	if (evsel__test_field(evsel, "next_comm", 16, false))
> +	if (evsel__test_field_alt(evsel, "next_comm", TASK_COMM_LEN_16,
> +				  TASK_COMM_LEN, false))
>  		ret = -1;
>  
>  	if (evsel__test_field(evsel, "next_pid", 4, true))
> @@ -72,7 +85,8 @@ int test__perf_evsel__tp_sched_test(struct test *test __maybe_unused, int subtes
>  		return -1;
>  	}
>  
> -	if (evsel__test_field(evsel, "comm", 16, false))
> +	if (evsel__test_field_alt(evsel, "comm", TASK_COMM_LEN_16,
> +				  TASK_COMM_LEN, false))
>  		ret = -1;
>  
>  	if (evsel__test_field(evsel, "pid", 4, true))
> -- 
> 2.17.1
> 

-- 
Kees Cook
