Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7730A5A2D8D
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 19:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243853AbiHZRel (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 13:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbiHZRek (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 13:34:40 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82519DB07F;
        Fri, 26 Aug 2022 10:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661535279; x=1693071279;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ip8q90Po+Q+1OXsIy8Hcx+ep0okAYSlpYuF9p4+W+iM=;
  b=PA2xFjmQ1bawlSdMbvvhe+0e+BgeKoJlos1prjea+TDNC51T7P4iaATC
   bFAZ4lgO2cOjWPjruqjamBHDbZTbYssvUyD9VPJTisrUqJW37Fegh4WO6
   aFXusm2K9oxoq9TjDMZRtpWq7MYe7ld2x+m2LLWXyh218/qSBby2Qufb6
   FGQsAbtRYUXBaZeCs373T4rDu0wtY4XfLvrHFzCE5DnYQALdEHauZQDgU
   znu+c2ZgKbUkMTs9tpF3t8lHsKiYy4vDZxyeZ7zrvloUvMznj4nlKBFvM
   +NJJfMACYl1+mW3hxQ9TG++wGovL8iep+zu64hLyHht/W3VGNJqmaob4D
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="320663669"
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="320663669"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 10:34:39 -0700
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="640140425"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.50.209])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 10:34:26 -0700
Message-ID: <dc25fa1b-1c29-755a-2fc9-b30ec79eb2ac@intel.com>
Date:   Fri, 26 Aug 2022 20:34:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v3 11/18] perf dso: Update use of pthread mutex
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
 <12acbe02-bd73-07bb-d0e1-cb13dcd790c0@intel.com>
 <CAP-5=fWCpoqAhLzdMn1zHXfKpsYg0LQPMSz6Uy82+QL_MQpc8g@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAP-5=fWCpoqAhLzdMn1zHXfKpsYg0LQPMSz6Uy82+QL_MQpc8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 26/08/22 19:05, Ian Rogers wrote:
> On Fri, Aug 26, 2022 at 3:37 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 24/08/22 18:38, Ian Rogers wrote:
>>> Switch to the use of mutex wrappers that provide better error checking.
>>>
>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>> ---
>>>  tools/perf/util/dso.c    | 12 ++++++------
>>
>> Some not done yet
>>
>> $ grep -i pthread_mut tools/perf/util/dso.c
>> static pthread_mutex_t dso__data_open_lock = PTHREAD_MUTEX_INITIALIZER;
>>         pthread_mutex_lock(&dso__data_open_lock);
>>         pthread_mutex_unlock(&dso__data_open_lock);
>>         if (pthread_mutex_lock(&dso__data_open_lock) < 0)
>>                 pthread_mutex_unlock(&dso__data_open_lock);
>>         pthread_mutex_unlock(&dso__data_open_lock);
>>         pthread_mutex_lock(&dso__data_open_lock);
>>         pthread_mutex_unlock(&dso__data_open_lock);
>>         pthread_mutex_lock(&dso__data_open_lock);
>>         pthread_mutex_unlock(&dso__data_open_lock);
> 
> Yes, these are all solely dso__data_open_lock that lacks any clear
> init/exit code to place the initialization/destruction hooks onto. I
> don't plan to alter these in this patch set.

Perhaps that could be explained in the change log.

But why not just add init / exit code.  Could be called out
of main(), or maybe use __attribute__((constructor)) /
__attribute__((destructor))
