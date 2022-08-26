Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847925A25EF
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 12:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245563AbiHZKhm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 06:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242864AbiHZKhk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 06:37:40 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23DED570D;
        Fri, 26 Aug 2022 03:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661510259; x=1693046259;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=9hnCuIQP0Do9Va8hiUiS3qPMSpvIWNQCjLORaXq96rM=;
  b=SkN7+8A8mFTAywJwapYZC4VN9VBqMP4vOj9mMlam4gdn8rex+34AVvYA
   jkCrdxf0cXhuzs0exIQ9fsVGQYS1CfbEh27VgMcmeSL3C2Rf2Meubusmq
   1oer5ZqlWeavcdZyEyOZltAWsoyw5t+eJGDIayszalqzYlqL4edfK6AVr
   fhHY+h50PEMqZBcvaAHI7qZcaVyHkL1RpmBez/0Rl0cMu49HTAMK+Don0
   /FEMlYNvh6xs8Ll/r9hACXjuHis34AXg6mV8u0MpCdROhHiOrR1kYnkFI
   xp9eVdmiJTv7SkHsXVlo8rbu6Iyir0OQtp/x2XfRw+ecUE6gMfsGONl16
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="293220362"
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="293220362"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 03:37:39 -0700
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="606726872"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.50.209])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 03:37:26 -0700
Message-ID: <12acbe02-bd73-07bb-d0e1-cb13dcd790c0@intel.com>
Date:   Fri, 26 Aug 2022 13:37:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v3 11/18] perf dso: Update use of pthread mutex
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
 <20220824153901.488576-12-irogers@google.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220824153901.488576-12-irogers@google.com>
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
> Switch to the use of mutex wrappers that provide better error checking.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/dso.c    | 12 ++++++------

Some not done yet

$ grep -i pthread_mut tools/perf/util/dso.c
static pthread_mutex_t dso__data_open_lock = PTHREAD_MUTEX_INITIALIZER;
        pthread_mutex_lock(&dso__data_open_lock);
        pthread_mutex_unlock(&dso__data_open_lock);
        if (pthread_mutex_lock(&dso__data_open_lock) < 0)
                pthread_mutex_unlock(&dso__data_open_lock);
        pthread_mutex_unlock(&dso__data_open_lock);
        pthread_mutex_lock(&dso__data_open_lock);
        pthread_mutex_unlock(&dso__data_open_lock);
        pthread_mutex_lock(&dso__data_open_lock);
        pthread_mutex_unlock(&dso__data_open_lock);


>  tools/perf/util/dso.h    |  4 ++--
>  tools/perf/util/symbol.c |  4 ++--
>  3 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index 5ac13958d1bd..a9789a955403 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -795,7 +795,7 @@ dso_cache__free(struct dso *dso)
>  	struct rb_root *root = &dso->data.cache;
>  	struct rb_node *next = rb_first(root);
>  
> -	pthread_mutex_lock(&dso->lock);
> +	mutex_lock(&dso->lock);
>  	while (next) {
>  		struct dso_cache *cache;
>  
> @@ -804,7 +804,7 @@ dso_cache__free(struct dso *dso)
>  		rb_erase(&cache->rb_node, root);
>  		free(cache);
>  	}
> -	pthread_mutex_unlock(&dso->lock);
> +	mutex_unlock(&dso->lock);
>  }
>  
>  static struct dso_cache *__dso_cache__find(struct dso *dso, u64 offset)
> @@ -841,7 +841,7 @@ dso_cache__insert(struct dso *dso, struct dso_cache *new)
>  	struct dso_cache *cache;
>  	u64 offset = new->offset;
>  
> -	pthread_mutex_lock(&dso->lock);
> +	mutex_lock(&dso->lock);
>  	while (*p != NULL) {
>  		u64 end;
>  
> @@ -862,7 +862,7 @@ dso_cache__insert(struct dso *dso, struct dso_cache *new)
>  
>  	cache = NULL;
>  out:
> -	pthread_mutex_unlock(&dso->lock);
> +	mutex_unlock(&dso->lock);
>  	return cache;
>  }
>  
> @@ -1297,7 +1297,7 @@ struct dso *dso__new_id(const char *name, struct dso_id *id)
>  		dso->root = NULL;
>  		INIT_LIST_HEAD(&dso->node);
>  		INIT_LIST_HEAD(&dso->data.open_entry);
> -		pthread_mutex_init(&dso->lock, NULL);
> +		mutex_init(&dso->lock);
>  		refcount_set(&dso->refcnt, 1);
>  	}
>  
> @@ -1336,7 +1336,7 @@ void dso__delete(struct dso *dso)
>  	dso__free_a2l(dso);
>  	zfree(&dso->symsrc_filename);
>  	nsinfo__zput(dso->nsinfo);
> -	pthread_mutex_destroy(&dso->lock);
> +	mutex_destroy(&dso->lock);
>  	free(dso);
>  }
>  
> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> index 66981c7a9a18..58d94175e714 100644
> --- a/tools/perf/util/dso.h
> +++ b/tools/perf/util/dso.h
> @@ -2,7 +2,6 @@
>  #ifndef __PERF_DSO
>  #define __PERF_DSO
>  
> -#include <pthread.h>
>  #include <linux/refcount.h>
>  #include <linux/types.h>
>  #include <linux/rbtree.h>
> @@ -11,6 +10,7 @@
>  #include <stdio.h>
>  #include <linux/bitops.h>
>  #include "build-id.h"
> +#include "mutex.h"
>  
>  struct machine;
>  struct map;
> @@ -145,7 +145,7 @@ struct dso_cache {
>  struct auxtrace_cache;
>  
>  struct dso {
> -	pthread_mutex_t	 lock;
> +	struct mutex	 lock;
>  	struct list_head node;
>  	struct rb_node	 rb_node;	/* rbtree node sorted by long name */
>  	struct rb_root	 *root;		/* root of rbtree that rb_node is in */
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index a4b22caa7c24..656d9b4dd456 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1800,7 +1800,7 @@ int dso__load(struct dso *dso, struct map *map)
>  	}
>  
>  	nsinfo__mountns_enter(dso->nsinfo, &nsc);
> -	pthread_mutex_lock(&dso->lock);
> +	mutex_lock(&dso->lock);
>  
>  	/* check again under the dso->lock */
>  	if (dso__loaded(dso)) {
> @@ -1964,7 +1964,7 @@ int dso__load(struct dso *dso, struct map *map)
>  		ret = 0;
>  out:
>  	dso__set_loaded(dso);
> -	pthread_mutex_unlock(&dso->lock);
> +	mutex_unlock(&dso->lock);
>  	nsinfo__mountns_exit(&nsc);
>  
>  	return ret;

