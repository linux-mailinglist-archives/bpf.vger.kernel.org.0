Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B595A2FC8
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 21:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbiHZTUs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 15:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbiHZTUr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 15:20:47 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756346CD32;
        Fri, 26 Aug 2022 12:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661541646; x=1693077646;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+Ad09Os/PUvK/J76FchENgrJ52K2/K/VEG9kiQ+ar/Q=;
  b=n9is3YBMJkvP0neh/9fwPpzcliUTZb1yENjweqwxbDJNA672BiOklqhC
   SFbeelea1gRq9pMFixEZU8bXlq+g8TsWlQEyypN7LL8WRwhazzgGjdFd1
   jxEu2XPGknTI0/3nFRgzRFejLNauhoyENVZd5/Hmn9Un9wn6E9EQheAle
   c64UHOLJa5XLFhjwiMj0SgdTi3/5y4GqzixCaC8yCP5hcdOReTPRHc2NB
   JqJedaaCCVpCADcoPq/jseJEosAipNV1fyvWA6IK3PRTNIZQupKYoYLIB
   0ZdtetuN3HbR6lZAM078WnvkQ9bI4+05H3JnXtVkQsGsgHVbFzwqXMEkv
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="293320759"
X-IronPort-AV: E=Sophos;i="5.93,266,1654585200"; 
   d="scan'208";a="293320759"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 12:20:46 -0700
X-IronPort-AV: E=Sophos;i="5.93,266,1654585200"; 
   d="scan'208";a="671588431"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.50.209])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 12:20:34 -0700
Message-ID: <b0f86189-be17-d1e7-d23c-692eeee2b5ec@intel.com>
Date:   Fri, 26 Aug 2022 22:20:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v3 09/18] perf ui: Update use of pthread mutex
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
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
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, llvm@lists.linux.dev
References: <20220824153901.488576-1-irogers@google.com>
 <20220824153901.488576-10-irogers@google.com>
 <2cf6edac-6e41-b43c-2bc1-f49cb739201a@intel.com>
 <CAP-5=fVVWx=LZAzXsxfuktPHwki1gYbV4mcmvJp_9GTDS6KJcQ@mail.gmail.com>
 <a9b4f79d-cdea-821e-0e57-cd4854de6cf4@intel.com>
 <CAP-5=fW7t9tcJpyUbv8JAo-BFna-KS6FC+HkbuGx6S=h+nBMqw@mail.gmail.com>
 <43540a3d-e64e-ec08-e12e-aebb236a2efe@intel.com>
 <CAM9d7chBnZtrKe6b8k+VYk1Nmz8YnNWSMmyLydH6+Otvw4xGeA@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAM9d7chBnZtrKe6b8k+VYk1Nmz8YnNWSMmyLydH6+Otvw4xGeA@mail.gmail.com>
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

On 26/08/22 22:00, Namhyung Kim wrote:
> On Fri, Aug 26, 2022 at 11:53 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>> Below seems adequate for now, at least logically, but maybe it
>> would confuse clang thread-safety analysis?
> 
> I think it's not just about locks, the exit_browser should bail out early
> if the setup code was not called.

In those cases, use_browser is 0 or -1 unless someone has inserted
an invalid perf config like "tui.script=on" or "gtk.script=on".
So currently, in cases where exit_browser() is called without
setup_browser(), it does nothing.  Which means it is only the
unconditional mutex_destroy() that needs to be conditional.

> 
> Thanks,
> Namhyung
> 
> 
>>
>> diff --git a/tools/perf/ui/setup.c b/tools/perf/ui/setup.c
>> index 25ded88801a3..6d81be6a349e 100644
>> --- a/tools/perf/ui/setup.c
>> +++ b/tools/perf/ui/setup.c
>> @@ -73,9 +73,17 @@ int stdio__config_color(const struct option *opt __maybe_unused,
>>         return 0;
>>  }
>>
>> +/*
>> + * exit_browser() can get called without setup_browser() having been called
>> + * first, so it is necessary to keep track of whether ui__lock has been
>> + * initialized.
>> + */
>> +static bool ui__lock_initialized;
>> +
>>  void setup_browser(bool fallback_to_pager)
>>  {
>>         mutex_init(&ui__lock);
>> +       ui__lock_initialized = true;
>>         if (use_browser < 2 && (!isatty(1) || dump_trace))
>>                 use_browser = 0;
>>
>> @@ -118,5 +126,6 @@ void exit_browser(bool wait_for_ok)
>>         default:
>>                 break;
>>         }
>> -       mutex_destroy(&ui__lock);
>> +       if (ui__lock_initialized)
>> +               mutex_destroy(&ui__lock);
>>  }
>>

