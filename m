Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526FB59F6B1
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 11:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236200AbiHXJqV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 05:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236768AbiHXJpt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 05:45:49 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B97E1277F;
        Wed, 24 Aug 2022 02:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661334329; x=1692870329;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=r14CxE1SBaJlMjpDav35DU25bLbY0RYb1m2G+BUYXHA=;
  b=l4bz7RWhjllMZQDhvFv3sgzAd1U/6GdKyjzDtbURNgw+2s/Mm+Q+7LZg
   D/VDnmEIPJI3YbW5BtST3Nn40MjgSxpv0UwjgClSEhx65gAT5X4mUHYNq
   mGNi12Xyr4TVSf5mRJ9/9He+x76xuBjP5ZkNMwGc/1aP5DUmKN8A5mpgK
   6mX4MrP+Li9AlAuzgLDky2eHoWBKLUPneMKbJqrj0GTswLELaTQFQjTlI
   oqKd9KPLRwi7dlhrCsONWFbRQIJeU7YSwpNNeJOymrXO9akHbOEPSRZ7s
   vpsqeYF2Bo8/c7LU/UYzgxj8kapt8yUpa3BjpZyOjUwl+bZmuVkexFLfl
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="291488061"
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="291488061"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 02:45:27 -0700
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="586365611"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.51.108])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 02:45:15 -0700
Message-ID: <4e68941f-1370-0c23-6f42-44f3e19e65f7@intel.com>
Date:   Wed, 24 Aug 2022 12:45:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v2 01/18] perf mutex: Wrapped usage of mutex and cond
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
        Adrian Hunter <adrian.hunter@intel.com>,
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
References: <20220823220922.256001-1-irogers@google.com>
 <20220823220922.256001-2-irogers@google.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220823220922.256001-2-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 24/08/22 01:09, Ian Rogers wrote:
> From: Pavithra Gurushankar <gpavithrasha@gmail.com>
> 
> Added a new header file mutex.h that wraps the usage of
> pthread_mutex_t and pthread_cond_t. By abstracting these it is
> possible to introduce error checking.
> 
> Signed-off-by: Pavithra Gurushankar <gpavithrasha@gmail.com>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/Build   |  1 +
>  tools/perf/util/mutex.c | 97 +++++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/mutex.h | 43 ++++++++++++++++++
>  3 files changed, 141 insertions(+)
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
> index 000000000000..d12cf0714268
> --- /dev/null
> +++ b/tools/perf/util/mutex.c
> @@ -0,0 +1,97 @@
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

pr_err() does not add '\n' so it needs to be in the format string.

> +}
> +
> +#define CHECK_ERR(err) check_err(__func__, err)
> +
> +void mutex_init(struct mutex *mtx, bool pshared)
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
> +		pthread_mutexattr_setpshared(&attr, PTHREAD_PROCESS_SHARED);
> +
> +	CHECK_ERR(pthread_mutex_init(&mtx->lock, &attr));
> +	CHECK_ERR(pthread_mutexattr_destroy(&attr));
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
> +void cond_init(struct cond *cnd, bool pshared)
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
> index 000000000000..952276ad83bd
> --- /dev/null
> +++ b/tools/perf/util/mutex.h
> @@ -0,0 +1,43 @@
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

Do these definitions need to be in the header?
What about just:

struct mutex;
struct cond;

and put the defintions in mutex.c.

> +
> +/*
> + * Initialize the mtx struct, if pshared is set then specify the process-shared
> + * rather than default process-private attribute.
> + */
> +void mutex_init(struct mutex *mtx, bool pshared);
> +void mutex_destroy(struct mutex *mtx);
> +
> +void mutex_lock(struct mutex *mtx);
> +void mutex_unlock(struct mutex *mtx);
> +bool mutex_trylock(struct mutex *mtx);
> +
> +/*
> + * Initialize the cond struct, if pshared is set then specify the process-shared
> + * rather than default process-private attribute.
> + */
> +void cond_init(struct cond *cnd, bool pshared);
> +void cond_destroy(struct cond *cnd);
> +
> +void cond_wait(struct cond *cnd, struct mutex *mtx);
> +void cond_signal(struct cond *cnd);
> +void cond_broadcast(struct cond *cnd);
> +
> +#endif /* __PERF_MUTEX_H */

