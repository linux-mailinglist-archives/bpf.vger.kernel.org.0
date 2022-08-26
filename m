Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE0B5A2390
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 10:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245290AbiHZIud (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 04:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245511AbiHZIuS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 04:50:18 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1C032DB9;
        Fri, 26 Aug 2022 01:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661503815; x=1693039815;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=QBRLETGvncTRL0lzh7ch6U3+EDLdG+HLMX8Hw3Ab734=;
  b=clA/n1vuiM1T4wjHhwqxeptIAHtaawyUHWuiAUB5j0vWO1xTluEE7kUu
   /lxxW4NlZEpbOqnyCJqHMQLiMy+Cc7dKjAE0ONzEFsTNugUWIqRmvf0Q6
   WL4+4QlFVvxaC4svEN6rnt1YdshuE6mtbidcEVCkVbMXropxjGuA7T/Vp
   TNRy1PKieQC2LaJ3MQnOplH1TvJp6qlha0xTeoamrRrZX31JRFldPATAh
   Rw6aN4tF1Lo8xpXIdrEGWLN+fmvPPoF4gcbJLkP9gnI8dpVJ2pu0Kd/+L
   Fyl2cfkgZcxDdnez3spmeuP2NexhPXRGZ90NlSkFKpfXkxAUIpHjb9ofw
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="294464126"
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="294464126"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 01:50:13 -0700
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="671381337"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.50.209])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 01:50:01 -0700
Message-ID: <40f723d1-a030-983b-93b3-63791321ae4c@intel.com>
Date:   Fri, 26 Aug 2022 11:49:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v3 01/18] perf mutex: Wrapped usage of mutex and cond
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
 <20220824153901.488576-2-irogers@google.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220824153901.488576-2-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 24/08/22 18:38, Ian Rogers wrote:
> From: Pavithra Gurushankar <gpavithrasha@gmail.com>
> 
> Added a new header file mutex.h that wraps the usage of
> pthread_mutex_t and pthread_cond_t. By abstracting these it is
> possible to introduce error checking.
> 
> Signed-off-by: Pavithra Gurushankar <gpavithrasha@gmail.com>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/Build   |   1 +
>  tools/perf/util/mutex.c | 117 ++++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/mutex.h |  47 ++++++++++++++++
>  3 files changed, 165 insertions(+)
>  create mode 100644 tools/perf/util/mutex.c
>  create mode 100644 tools/perf/util/mutex.h
> 
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 9dfae1bda9cc..8fd6dc8de521 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -143,6 +143,7 @@ perf-y += branch.o
>  perf-y += mem2node.o
>  perf-y += clockid.o
>  perf-y += list_sort.o
> +perf-y += mutex.o
>  
>  perf-$(CONFIG_LIBBPF) += bpf-loader.o
>  perf-$(CONFIG_LIBBPF) += bpf_map.o
> diff --git a/tools/perf/util/mutex.c b/tools/perf/util/mutex.c
> new file mode 100644
> index 000000000000..892294ac1769
> --- /dev/null
> +++ b/tools/perf/util/mutex.c
> @@ -0,0 +1,117 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "mutex.h"
> +
> +#include "debug.h"
> +#include <linux/string.h>
> +#include <errno.h>
> +
> +static void check_err(const char *fn, int err)
> +{
> +	char sbuf[STRERR_BUFSIZE];
> +
> +	if (err == 0)
> +		return;
> +
> +	pr_err("%s error: '%s'", fn, str_error_r(err, sbuf, sizeof(sbuf)));
                              ^
Still needs \n here >---------^

> +}
> +
> +#define CHECK_ERR(err) check_err(__func__, err)
> +
> +static void __mutex_init(struct mutex *mtx, bool pshared)
> +{
> +	pthread_mutexattr_t attr;
> +
> +	CHECK_ERR(pthread_mutexattr_init(&attr));
> +
> +#ifndef NDEBUG
> +	/* In normal builds enable error checking, such as recursive usage. */
> +	CHECK_ERR(pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_ERRORCHECK));
> +#endif
> +	if (pshared)
> +		CHECK_ERR(pthread_mutexattr_setpshared(&attr, PTHREAD_PROCESS_SHARED));
> +
> +	CHECK_ERR(pthread_mutex_init(&mtx->lock, &attr));
> +	CHECK_ERR(pthread_mutexattr_destroy(&attr));
> +}
> +
> +void mutex_init(struct mutex *mtx)
> +{
> +	__mutex_init(mtx, /*pshared=*/false);
> +}
> +
> +void mutex_init_pshared(struct mutex *mtx)
> +{
> +	__mutex_init(mtx, /*pshared=*/true);
> +}
> +
> +void mutex_destroy(struct mutex *mtx)
> +{
> +	CHECK_ERR(pthread_mutex_destroy(&mtx->lock));
> +}
> +
> +void mutex_lock(struct mutex *mtx)
> +{
> +	CHECK_ERR(pthread_mutex_lock(&mtx->lock));
> +}
> +
> +void mutex_unlock(struct mutex *mtx)
> +{
> +	CHECK_ERR(pthread_mutex_unlock(&mtx->lock));
> +}
> +
> +bool mutex_trylock(struct mutex *mtx)
> +{
> +	int ret = pthread_mutex_trylock(&mtx->lock);
> +
> +	if (ret == 0)
> +		return true; /* Lock acquired. */
> +
> +	if (ret == EBUSY)
> +		return false; /* Lock busy. */
> +
> +	/* Print error. */
> +	CHECK_ERR(ret);
> +	return false;
> +}
> +
> +static void __cond_init(struct cond *cnd, bool pshared)
> +{
> +	pthread_condattr_t attr;
> +
> +	CHECK_ERR(pthread_condattr_init(&attr));
> +	if (pshared)
> +		CHECK_ERR(pthread_condattr_setpshared(&attr, PTHREAD_PROCESS_SHARED));
> +
> +	CHECK_ERR(pthread_cond_init(&cnd->cond, &attr));
> +	CHECK_ERR(pthread_condattr_destroy(&attr));
> +}
> +
> +void cond_init(struct cond *cnd)
> +{
> +	__cond_init(cnd, /*pshared=*/false);
> +}
> +
> +void cond_init_pshared(struct cond *cnd)
> +{
> +	__cond_init(cnd, /*pshared=*/true);
> +}
> +
> +void cond_destroy(struct cond *cnd)
> +{
> +	CHECK_ERR(pthread_cond_destroy(&cnd->cond));
> +}
> +
> +void cond_wait(struct cond *cnd, struct mutex *mtx)
> +{
> +	CHECK_ERR(pthread_cond_wait(&cnd->cond, &mtx->lock));
> +}
> +
> +void cond_signal(struct cond *cnd)
> +{
> +	CHECK_ERR(pthread_cond_signal(&cnd->cond));
> +}
> +
> +void cond_broadcast(struct cond *cnd)
> +{
> +	CHECK_ERR(pthread_cond_broadcast(&cnd->cond));
> +}
> diff --git a/tools/perf/util/mutex.h b/tools/perf/util/mutex.h
> new file mode 100644
> index 000000000000..c9e110a2b55e
> --- /dev/null
> +++ b/tools/perf/util/mutex.h
> @@ -0,0 +1,47 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __PERF_MUTEX_H
> +#define __PERF_MUTEX_H
> +
> +#include <pthread.h>
> +#include <stdbool.h>
> +
> +/*
> + * A wrapper around the mutex implementation that allows perf to error check
> + * usage, etc.
> + */
> +struct mutex {
> +	pthread_mutex_t lock;
> +};
> +
> +/* A wrapper around the condition variable implementation. */
> +struct cond {
> +	pthread_cond_t cond;
> +};
> +
> +/* Default initialize the mtx struct. */
> +void mutex_init(struct mutex *mtx);
> +/*
> + * Initialize the mtx struct and set the process-shared rather than default
> + * process-private attribute.
> + */
> +void mutex_init_pshared(struct mutex *mtx);
> +void mutex_destroy(struct mutex *mtx);
> +
> +void mutex_lock(struct mutex *mtx);
> +void mutex_unlock(struct mutex *mtx);
> +bool mutex_trylock(struct mutex *mtx);

Might be worth noting that mutex_trylock() returns true if the
lock is acquired, inverting the logic from pthread_mutex_trylock()
but consistent with the kernel's mutex_trylock().

> +
> +/* Default initialize the cond struct. */
> +void cond_init(struct cond *cnd);
> +/*
> + * Initialize the cond struct and specify the process-shared rather than default
> + * process-private attribute.
> + */
> +void cond_init_pshared(struct cond *cnd);
> +void cond_destroy(struct cond *cnd);
> +
> +void cond_wait(struct cond *cnd, struct mutex *mtx);
> +void cond_signal(struct cond *cnd);
> +void cond_broadcast(struct cond *cnd);
> +
> +#endif /* __PERF_MUTEX_H */

