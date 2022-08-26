Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E715A26A8
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 13:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245546AbiHZLND (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 07:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244972AbiHZLNC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 07:13:02 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01E1D31F7;
        Fri, 26 Aug 2022 04:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661512381; x=1693048381;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=3r4b9fNqoE5fw/Wja2N6QhB8LgGuDbCrGO8y5pnVRGo=;
  b=XQNB3MGVNIsumnH+1KSMdSzCsOjAGPSAKFJlW2hEa7NzqY9Ht9fa2rl2
   w+hmIugXPgZsgP6PKSMkZnn4ft27cZHNs69PP/lpbPAR+oZENBDfxRPWi
   snqhnQZv3P3vY5yylmFTbri/Y0ulfVGz6GC1xL7BmMVRWYhQi5AmrQz8t
   BDhMYcF2gKfi/D1LOolVqsOSsJt7U3v+Ahr3kk7hTgQj9gvmkBXYUYr1d
   90z/+chKdiLTQJItMS9cUZk280oe7HpjVDOmY8Ao9zo4l2q8vDyT5RMUm
   IImAq3pZf/hezFMkDELan1GCsxraIS0KVXHkfSOLIGQexMZ9m5yphYKcI
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="295756583"
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="295756583"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 04:12:59 -0700
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="606734124"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.50.209])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 04:12:47 -0700
Message-ID: <b87631c8-aa36-b72d-64d7-9343ddeebdc3@intel.com>
Date:   Fri, 26 Aug 2022 14:12:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v3 15/18] perf mutex: Add thread safety annotations
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
 <20220824153901.488576-16-irogers@google.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220824153901.488576-16-irogers@google.com>
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
> Add thread safety annotations to struct mutex so that when compiled with
> clang's -Wthread-safety warnings are generated for erroneous lock
> patterns. NO_THREAD_SAFETY_ANALYSIS is needed for
> mutex_lock/mutex_unlock as the analysis doesn't under pthread calls.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/mutex.c |  2 ++
>  tools/perf/util/mutex.h | 72 ++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 69 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/mutex.c b/tools/perf/util/mutex.c
> index 892294ac1769..ec813093276d 100644
> --- a/tools/perf/util/mutex.c
> +++ b/tools/perf/util/mutex.c
> @@ -50,11 +50,13 @@ void mutex_destroy(struct mutex *mtx)
>  }
>  
>  void mutex_lock(struct mutex *mtx)
> +	NO_THREAD_SAFETY_ANALYSIS
>  {
>  	CHECK_ERR(pthread_mutex_lock(&mtx->lock));
>  }
>  
>  void mutex_unlock(struct mutex *mtx)
> +	NO_THREAD_SAFETY_ANALYSIS
>  {
>  	CHECK_ERR(pthread_mutex_unlock(&mtx->lock));
>  }
> diff --git a/tools/perf/util/mutex.h b/tools/perf/util/mutex.h
> index c9e110a2b55e..48a2d87598f0 100644
> --- a/tools/perf/util/mutex.h
> +++ b/tools/perf/util/mutex.h
> @@ -5,11 +5,73 @@
>  #include <pthread.h>
>  #include <stdbool.h>
>  
> +/*
> + * A function-like feature checking macro that is a wrapper around
> + * `__has_attribute`, which is defined by GCC 5+ and Clang and evaluates to a
> + * nonzero constant integer if the attribute is supported or 0 if not.
> + */
> +#ifdef __has_attribute
> +#define HAVE_ATTRIBUTE(x) __has_attribute(x)
> +#else
> +#define HAVE_ATTRIBUTE(x) 0
> +#endif
> +
> +

Multiple blank lines

> +#if HAVE_ATTRIBUTE(guarded_by) && HAVE_ATTRIBUTE(pt_guarded_by) && \
> +	HAVE_ATTRIBUTE(lockable) && HAVE_ATTRIBUTE(exclusive_lock_function) && \
> +	HAVE_ATTRIBUTE(exclusive_trylock_function) && HAVE_ATTRIBUTE(exclusive_locks_required) && \
> +	HAVE_ATTRIBUTE(no_thread_safety_analysis)
> +
> +/* Documents if a shared field or global variable needs to be protected by a mutex. */
> +#define GUARDED_BY(x) __attribute__((guarded_by(x)))
> +
> +/*
> + * Documents if the memory location pointed to by a pointer should be guarded by
> + * a mutex when dereferencing the pointer.
> + */
> +#define PT_GUARDED_BY(x) __attribute__((pt_guarded_by(x)))
> +
> +/* Documents if a type is a lockable type. */
> +#define LOCKABLE __attribute__((capability("lockable")))
> +
> +/* Documents functions that acquire a lock in the body of a function, and do not release it. */
> +#define EXCLUSIVE_LOCK_FUNCTION(...)  __attribute__((exclusive_lock_function(__VA_ARGS__)))
> +
> +/*
> + * Documents functions that expect a lock to be held on entry to the function,
> + * and release it in the body of the function.
> + */
> +#define UNLOCK_FUNCTION(...) __attribute__((unlock_function(__VA_ARGS__)))
> +
> +/* Documents functions that try to acquire a lock, and return success or failure. */
> +#define EXCLUSIVE_TRYLOCK_FUNCTION(...) \
> +	__attribute__((exclusive_trylock_function(__VA_ARGS__)))
> +
> +

Multiple blank lines

> +/* Documents a function that expects a mutex to be held prior to entry. */
> +#define EXCLUSIVE_LOCKS_REQUIRED(...) __attribute__((exclusive_locks_required(__VA_ARGS__)))
> +
> +/* Turns off thread safety checking within the body of a particular function. */
> +#define NO_THREAD_SAFETY_ANALYSIS __attribute__((no_thread_safety_analysis))
> +
> +#else
> +
> +#define GUARDED_BY(x)
> +#define PT_GUARDED_BY(x)
> +#define LOCKABLE
> +#define EXCLUSIVE_LOCK_FUNCTION(...)
> +#define UNLOCK_FUNCTION(...)
> +#define EXCLUSIVE_TRYLOCK_FUNCTION(...)
> +#define EXCLUSIVE_LOCKS_REQUIRED(...)
> +#define NO_THREAD_SAFETY_ANALYSIS
> +
> +#endif
> +
>  /*
>   * A wrapper around the mutex implementation that allows perf to error check
>   * usage, etc.
>   */
> -struct mutex {
> +struct LOCKABLE mutex {
>  	pthread_mutex_t lock;
>  };
>  
> @@ -27,9 +89,9 @@ void mutex_init(struct mutex *mtx);
>  void mutex_init_pshared(struct mutex *mtx);
>  void mutex_destroy(struct mutex *mtx);
>  
> -void mutex_lock(struct mutex *mtx);
> -void mutex_unlock(struct mutex *mtx);
> -bool mutex_trylock(struct mutex *mtx);
> +void mutex_lock(struct mutex *mtx) EXCLUSIVE_LOCK_FUNCTION(*mtx);
> +void mutex_unlock(struct mutex *mtx) UNLOCK_FUNCTION(*mtx);
> +bool mutex_trylock(struct mutex *mtx) EXCLUSIVE_TRYLOCK_FUNCTION(true, *mtx);
>  
>  /* Default initialize the cond struct. */
>  void cond_init(struct cond *cnd);
> @@ -40,7 +102,7 @@ void cond_init(struct cond *cnd);
>  void cond_init_pshared(struct cond *cnd);
>  void cond_destroy(struct cond *cnd);
>  
> -void cond_wait(struct cond *cnd, struct mutex *mtx);
> +void cond_wait(struct cond *cnd, struct mutex *mtx) EXCLUSIVE_LOCKS_REQUIRED(mtx);
>  void cond_signal(struct cond *cnd);
>  void cond_broadcast(struct cond *cnd);
>  

