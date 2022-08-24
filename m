Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9688D59F739
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 12:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235175AbiHXKPP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 06:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbiHXKPO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 06:15:14 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BAC4454C;
        Wed, 24 Aug 2022 03:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661336114; x=1692872114;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=F3hdBdWFw9/N+cVdceQJWxxc8Y/utx6ligUGZLp/CII=;
  b=cQMpBQKt7Yyk96JQ6wAy8DzybVEdQTYXA0B6IyXAvlpq4E1bK/1i7Xoc
   CJNT2xRLLCDiqCqh4/CHjPy8zwQFE0RObaZ+BJ9rSnKYwcIk/OGm7tWh9
   bUj3rqvnNoEmTbxMTqi+fVgzmVs8biJg/PlX700eXjgHKM3xTQ8uJRP3h
   ZJP77B5sr93tp1CL7GbobaGmJ8/ftHrG5BzrOGlyTsgk5XiN5fMGZ69bh
   OECJR6CwMrE5aKgoPMpnCSmd8oIna3B3vZjPBjQqLUm5qoLbTKtPN6vd/
   rcno1WJXj0nJE3laUuSZtrVgEuOjvHxt7ClOZ3RLbxbHl+4IvLTsvlB1J
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="380218898"
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="380218898"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 03:15:13 -0700
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="586375894"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.51.108])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 03:15:00 -0700
Message-ID: <02152f40-1dc5-7f1b-ad88-61ecb146a3da@intel.com>
Date:   Wed, 24 Aug 2022 13:14:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v2 07/18] perf record: Update use of pthread mutex
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
 <20220823220922.256001-8-irogers@google.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220823220922.256001-8-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 24/08/22 01:09, Ian Rogers wrote:
> Switch to the use of mutex wrappers that provide better error checking
> for synth_lock.

It would be better to distinguish patches that make drop-in
replacements from patches like this that change logic.

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-record.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 4713f0f3a6cf..02eb85677e99 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -21,6 +21,7 @@
>  #include "util/evsel.h"
>  #include "util/debug.h"
>  #include "util/mmap.h"
> +#include "util/mutex.h"
>  #include "util/target.h"
>  #include "util/session.h"
>  #include "util/tool.h"
> @@ -608,17 +609,18 @@ static int process_synthesized_event(struct perf_tool *tool,
>  	return record__write(rec, NULL, event, event->header.size);
>  }
>  
> +static struct mutex synth_lock;
> +
>  static int process_locked_synthesized_event(struct perf_tool *tool,
>  				     union perf_event *event,
>  				     struct perf_sample *sample __maybe_unused,
>  				     struct machine *machine __maybe_unused)
>  {
> -	static pthread_mutex_t synth_lock = PTHREAD_MUTEX_INITIALIZER;
>  	int ret;
>  
> -	pthread_mutex_lock(&synth_lock);
> +	mutex_lock(&synth_lock);
>  	ret = process_synthesized_event(tool, event, sample, machine);
> -	pthread_mutex_unlock(&synth_lock);
> +	mutex_unlock(&synth_lock);
>  	return ret;
>  }
>  
> @@ -1917,6 +1919,7 @@ static int record__synthesize(struct record *rec, bool tail)
>  	}
>  
>  	if (rec->opts.nr_threads_synthesize > 1) {
> +		mutex_init(&synth_lock, /*pshared=*/false);

It would be better to have mutex_init() and mutex_init_shared()
since /*pshared=*/true is rarely used.

>  		perf_set_multithreaded();
>  		f = process_locked_synthesized_event;
>  	}
> @@ -1930,8 +1933,10 @@ static int record__synthesize(struct record *rec, bool tail)
>  						    rec->opts.nr_threads_synthesize);
>  	}
>  
> -	if (rec->opts.nr_threads_synthesize > 1)
> +	if (rec->opts.nr_threads_synthesize > 1) {
>  		perf_set_singlethreaded();
> +		mutex_destroy(&synth_lock);
> +	}
>  
>  out:
>  	return err;

