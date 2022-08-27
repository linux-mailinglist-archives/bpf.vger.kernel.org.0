Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9E45A3575
	for <lists+bpf@lfdr.de>; Sat, 27 Aug 2022 09:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236442AbiH0HLh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 27 Aug 2022 03:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233391AbiH0HLg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 27 Aug 2022 03:11:36 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7DFB9403;
        Sat, 27 Aug 2022 00:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661584295; x=1693120295;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5//vesnR6q4a/EAJehddmLIvKMXBYIPt2MNCh84f7z8=;
  b=HDGGL2FSw2Z0BqVL3O0LKqQY8SzAMplJSwPbGFk+YQX+txVqwGad30PR
   V+/bHgeHK3JYGP3pG5/ZuzL3kJyVrKY4xdXO1TU8pvG1pyz1RcRrlgxX9
   VarGk0DzuY6wypE3j8ibXEA8sku6AwV79A8EI42VM7xakKevLN9e45fx8
   baIbola4VjhCoQ8Q+lRocAsxseCenHK9ie+/4WeckpvuJmalqs0ARDVyI
   7WJw7eq3SUdBOREF9lLJoCp/KL3e4HZG2PwrDrUbX4lvB4rUs62acsw1J
   uE4VSNtyDjFpyA1NzoCOY1ep6uGUl3xD8+a5Liin46C0YIZ5R2WGcnrf4
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="295418832"
X-IronPort-AV: E=Sophos;i="5.93,267,1654585200"; 
   d="scan'208";a="295418832"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2022 00:11:35 -0700
X-IronPort-AV: E=Sophos;i="5.93,267,1654585200"; 
   d="scan'208";a="671747248"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.52.233])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2022 00:11:23 -0700
Message-ID: <bdbd520a-b1c4-01c4-18bb-f1c2b553371d@intel.com>
Date:   Sat, 27 Aug 2022 10:11:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v3 09/18] perf ui: Update use of pthread mutex
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
 <b0f86189-be17-d1e7-d23c-692eeee2b5ec@intel.com>
 <CAM9d7ciroc1XzRL+W34D5G7kCp4KCzRxjyRqnO2OXj=-ZaMTLQ@mail.gmail.com>
 <CAP-5=fWvf66snfmUfaTQ6BZ9EmsmBs0PUT8PAfehW74bnEE5nQ@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAP-5=fWvf66snfmUfaTQ6BZ9EmsmBs0PUT8PAfehW74bnEE5nQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 26/08/22 23:52, Ian Rogers wrote:
> On Fri, Aug 26, 2022 at 1:40 PM Namhyung Kim <namhyung@kernel.org> wrote:
>>
>> On Fri, Aug 26, 2022 at 12:21 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>
>>> On 26/08/22 22:00, Namhyung Kim wrote:
>>>> On Fri, Aug 26, 2022 at 11:53 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>> Below seems adequate for now, at least logically, but maybe it
>>>>> would confuse clang thread-safety analysis?
>>>>
>>>> I think it's not just about locks, the exit_browser should bail out early
>>>> if the setup code was not called.
>>>
>>> In those cases, use_browser is 0 or -1 unless someone has inserted
>>> an invalid perf config like "tui.script=on" or "gtk.script=on".
>>> So currently, in cases where exit_browser() is called without
>>> setup_browser(), it does nothing.  Which means it is only the
>>> unconditional mutex_destroy() that needs to be conditional.
>>
>> Yeah there's a possibility that it can be called with > 0 use_browser
>> on some broken config or something.  So I think it's safer and better
>> for future changes.
> 
> I'd thought about a:
> static bool ui__lock_initialized;
> but the issue is shouldn't it be atomic?

No, it is only accessed from the main thread.
