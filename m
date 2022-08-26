Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1D55A2774
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 14:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbiHZMMz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 08:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiHZMMy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 08:12:54 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546CADDA93;
        Fri, 26 Aug 2022 05:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661515973; x=1693051973;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=8gzeq3HsKshBpNjIIChQDXSz7Xg1mcO3yxgdPGuVa2A=;
  b=Gm0FsFNVYtMIw82tYTf+GLrn3cxVX3qlqqUBH0bZ7n3oEGGie4gahSGr
   4xCGcZHP3iLZO09rcuwJnhjRKglQONhlTJtn1R3c+6h3L/6AevD6waC53
   KDzqHioXHlmdlcMt49ADYRKl17ffF4HmO42f2yyEWdLxvvb1/maobyk4Y
   Qa2YCw0Yv/Kd+QqAUMIfSY7XAHo+X+jk0e3PFyxlpxJTA/zYA95gPdGW9
   Ni7TvGiYAh3L/aOwEhUmaqEHpQ63Qxu/5PHv3yo/Xgx0K3A0JKJhsomIE
   spTW77D3YZyYt0dOnseX7Za+lu9O0uCLyu8P5NEmtv2/Z5nBE2Lt83una
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="295764431"
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="295764431"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 05:12:52 -0700
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="640034953"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.50.209])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 05:12:40 -0700
Message-ID: <a7176263-7dc8-6cbd-af2d-5338c4c4b546@intel.com>
Date:   Fri, 26 Aug 2022 15:12:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v3 16/18] perf sched: Fixes for thread safety analysis
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Weiguo Li <liwg06@foxmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Dario Petrillo <dario.pk1@gmail.com>,
        Hewenliang <hewenliang4@huawei.com>,
        yaowenbin <yaowenbin1@huawei.com>,
        Wenyu Liu <liuwenyu7@huawei.com>,
        Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Leo Yan <leo.yan@linaro.org>,
        Kim Phillips <kim.phillips@amd.com>,
        Pavithra Gurushankar <gpavithrasha@gmail.com>,
        Alexandre Truong <alexandre.truong@arm.com>,
        Quentin Monnet <quentin@isovalent.com>,
        William Cohen <wcohen@redhat.com>,
        Andres Freund <andres@anarazel.de>,
        =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>,
        Colin Ian King <colin.king@intel.com>,
        James Clark <james.clark@arm.com>,
        Fangrui Song <maskray@google.com>,
        Stephane Eranian <eranian@google.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Zechuan Chen <chenzechuan1@huawei.com>,
        Jason Wang <wangborong@cdjrlc.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Remi Bernon <rbernon@codeweavers.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
References: <20220824153901.488576-1-irogers@google.com>
 <20220824153901.488576-17-irogers@google.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220824153901.488576-17-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 24/08/22 18:38, Ian Rogers wrote:
> Add annotations to describe lock behavior. Add unlocks so that mutexes
> aren't conditionally held on exit from perf_sched__replay. Add an exit
> variable so that thread_func can terminate, rather than leaving the
> threads blocked on mutexes.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-sched.c | 46 ++++++++++++++++++++++++--------------
>  1 file changed, 29 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 7e4006d6b8bc..b483ff0d432e 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -246,6 +246,7 @@ struct perf_sched {
>  	const char	*time_str;
>  	struct perf_time_interval ptime;
>  	struct perf_time_interval hist_time;
> +	volatile bool   thread_funcs_exit;
>  };
>  
>  /* per thread run time data */
> @@ -633,31 +634,34 @@ static void *thread_func(void *ctx)
>  	prctl(PR_SET_NAME, comm2);
>  	if (fd < 0)
>  		return NULL;
> -again:
> -	ret = sem_post(&this_task->ready_for_work);
> -	BUG_ON(ret);
> -	mutex_lock(&sched->start_work_mutex);
> -	mutex_unlock(&sched->start_work_mutex);
>  
> -	cpu_usage_0 = get_cpu_usage_nsec_self(fd);
> +	while (!sched->thread_funcs_exit) {
> +		ret = sem_post(&this_task->ready_for_work);
> +		BUG_ON(ret);
> +		mutex_lock(&sched->start_work_mutex);
> +		mutex_unlock(&sched->start_work_mutex);
>  
> -	for (i = 0; i < this_task->nr_events; i++) {
> -		this_task->curr_event = i;
> -		perf_sched__process_event(sched, this_task->atoms[i]);
> -	}
> +		cpu_usage_0 = get_cpu_usage_nsec_self(fd);
>  
> -	cpu_usage_1 = get_cpu_usage_nsec_self(fd);
> -	this_task->cpu_usage = cpu_usage_1 - cpu_usage_0;
> -	ret = sem_post(&this_task->work_done_sem);
> -	BUG_ON(ret);
> +		for (i = 0; i < this_task->nr_events; i++) {
> +			this_task->curr_event = i;
> +			perf_sched__process_event(sched, this_task->atoms[i]);
> +		}
>  
> -	mutex_lock(&sched->work_done_wait_mutex);
> -	mutex_unlock(&sched->work_done_wait_mutex);
> +		cpu_usage_1 = get_cpu_usage_nsec_self(fd);
> +		this_task->cpu_usage = cpu_usage_1 - cpu_usage_0;
> +		ret = sem_post(&this_task->work_done_sem);
> +		BUG_ON(ret);
>  
> -	goto again;
> +		mutex_lock(&sched->work_done_wait_mutex);
> +		mutex_unlock(&sched->work_done_wait_mutex);
> +	}
> +	return NULL;
>  }
>  
>  static void create_tasks(struct perf_sched *sched)
> +	EXCLUSIVE_LOCK_FUNCTION(sched->start_work_mutex)
> +	EXCLUSIVE_LOCK_FUNCTION(sched->work_done_wait_mutex)
>  {
>  	struct task_desc *task;
>  	pthread_attr_t attr;
> @@ -687,6 +691,8 @@ static void create_tasks(struct perf_sched *sched)
>  }
>  
>  static void wait_for_tasks(struct perf_sched *sched)
> +	EXCLUSIVE_LOCKS_REQUIRED(sched->work_done_wait_mutex)
> +	EXCLUSIVE_LOCKS_REQUIRED(sched->start_work_mutex)
>  {
>  	u64 cpu_usage_0, cpu_usage_1;
>  	struct task_desc *task;
> @@ -738,6 +744,8 @@ static void wait_for_tasks(struct perf_sched *sched)
>  }
>  
>  static void run_one_test(struct perf_sched *sched)
> +	EXCLUSIVE_LOCKS_REQUIRED(sched->work_done_wait_mutex)
> +	EXCLUSIVE_LOCKS_REQUIRED(sched->start_work_mutex)
>  {
>  	u64 T0, T1, delta, avg_delta, fluct;
>  
> @@ -3309,11 +3317,15 @@ static int perf_sched__replay(struct perf_sched *sched)
>  	print_task_traces(sched);
>  	add_cross_task_wakeups(sched);
>  
> +	sched->thread_funcs_exit = false;
>  	create_tasks(sched);
>  	printf("------------------------------------------------------------\n");
>  	for (i = 0; i < sched->replay_repeat; i++)
>  		run_one_test(sched);
>  
> +	sched->thread_funcs_exit = true;
> +	mutex_unlock(&sched->start_work_mutex);
> +	mutex_unlock(&sched->work_done_wait_mutex);

I think you still need to wait for the threads to exit before
destroying the mutexes.

>  	return 0;
>  }
>  

