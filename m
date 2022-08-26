Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4405A2CB1
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 18:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344880AbiHZQra (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 12:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344797AbiHZQqm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 12:46:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76928194;
        Fri, 26 Aug 2022 09:45:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 082BEB8320A;
        Fri, 26 Aug 2022 16:45:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D7C3C433C1;
        Fri, 26 Aug 2022 16:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661532353;
        bh=uwurhb6uWaOebjupXeNZEm8pE4a+eXlVCuut1S26Yfk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sAqLDHWloItJEjH8PfcOSoeuqQpvyN1aFGBG6D/TO+I0t3i7ZLPhG6I0m2pqKRRtF
         rqB5yp1yeomKuPiLxLT/nquCCuRGmPuwEe9zFk9DpWDcnIUWUWFb+YMiMf5AAnWcli
         UpZY+OAzBzfiqrO0cZCMLPgnJSlsPctRn8GBG81yt0tr4OAoQepVLpBahLicg6UY2C
         3Gqs5qKnRZF/61lgAwBrRmB7qkeAqwdn1b2LfLxYJuuU+XafMqz4wukoizmV150z/x
         IkSlQyfoD9SAOndIZNF0UmqXnOJQ8YQ2EbCbgLWqE7mHik3nPRCRTYI0z/68LXdu0i
         XDuO/sHJxMUTQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 74D6C404A1; Fri, 26 Aug 2022 13:45:50 -0300 (-03)
Date:   Fri, 26 Aug 2022 13:45:50 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
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
        Adrian Hunter <adrian.hunter@intel.com>,
        Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>,
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
Subject: Re: [PATCH v3 15/18] perf mutex: Add thread safety annotations
Message-ID: <Ywj4vnYp6KGrrwl+@kernel.org>
References: <20220824153901.488576-1-irogers@google.com>
 <20220824153901.488576-16-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824153901.488576-16-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Aug 24, 2022 at 08:38:58AM -0700, Ian Rogers escreveu:
> Add thread safety annotations to struct mutex so that when compiled with
> clang's -Wthread-safety warnings are generated for erroneous lock
> patterns. NO_THREAD_SAFETY_ANALYSIS is needed for
> mutex_lock/mutex_unlock as the analysis doesn't under pthread calls.

So even having the guards checking if the attribute is available it
seems at least clang 11.0 is needed, as the "lockable" arg was
introduced there:

  37    42.61 fedora:32                     : FAIL clang version 10.0.1 (Fedora 10.0.1-3.fc32)
    In file included from /git/perf-6.0.0-rc2/tools/perf/util/../ui/ui.h:5:
    /git/perf-6.0.0-rc2/tools/perf/util/../ui/../util/mutex.h:74:8: error: invalid capability name 'lockable'; capability name must be 'mutex' or 'role' [-Werror,-Wthread-safety-attributes]
    struct LOCKABLE mutex {
           ^
    /git/perf-6.0.0-rc2/tools/perf/util/../ui/../util/mutex.h:35:44: note: expanded from macro 'LOCKABLE'
    #define LOCKABLE __attribute__((capability("lockable")))

The next fedora releases are ok with it:

  38   124.89 fedora:33                     : Ok   gcc (GCC) 10.3.1 20210422 (Red Hat 10.3.1-1) , clang version 11.0.0 (Fedora 11.0.0-3.fc33)
  39   132.20 fedora:34                     : Ok   gcc (GCC) 11.3.1 20220421 (Red Hat 11.3.1-2) , clang version 12.0.1 (Fedora 12.0.1-1.fc34)
  40    21.44 fedora:34-x-ARC-glibc         : Ok   arc-linux-gcc (ARC HS GNU/Linux glibc toolchain 2019.03-rc1) 8.3.1 20190225
  41    19.43 fedora:34-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCv2 ISA Linux uClibc toolchain 2019.03-rc1) 8.3.1 20190225
  42   136.33 fedora:35                     : Ok   gcc (GCC) 11.3.1 20220421 (Red Hat 11.3.1-2) , clang version 13.0.0 (Fedora 13.0.0-3.fc35)
  43   137.73 fedora:36                     : Ok   gcc (GCC) 12.1.1 20220507 (Red Hat 12.1.1-1) , clang version 14.0.0 (Fedora 14.0.0-1.fc36)
  44   140.45 fedora:37                     : Ok   gcc (GCC) 12.1.1 20220628 (Red Hat 12.1.1-3) , clang version 14.0.5 (Fedora 14.0.5-6.fc37)
  45   126.80 fedora:38                     : Ok   gcc (GCC) 12.1.1 20220810 (Red Hat 12.1.1-4) , clang version 14.0.5 (Fedora 14.0.5-6.fc38)
  46   127.00 fedora:rawhide                : Ok   gcc (GCC) 12.1.1 20220810 (Red Hat 12.1.1-4) , clang version 14.0.5 (Fedora 14.0.5-6.fc38)

Is there a way to check if a "capability" is available for the
attribute? Otherwise we can additionally check the clang version?

For my tests I'll make clang 11.0 to be the oldest supported compiler
(i.e. just disable building with older versions), but wanted to let you
know since you try to check if the attribute is available and fallback
to doing nothing in that case.

- Arnaldo
 
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
> -- 
> 2.37.2.609.g9ff673ca1a-goog

-- 

- Arnaldo
