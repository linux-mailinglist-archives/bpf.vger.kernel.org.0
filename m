Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FC75A384D
	for <lists+bpf@lfdr.de>; Sat, 27 Aug 2022 17:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbiH0PSm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 27 Aug 2022 11:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbiH0PSl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 27 Aug 2022 11:18:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BB83F32C;
        Sat, 27 Aug 2022 08:18:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A9BA9B808C0;
        Sat, 27 Aug 2022 15:18:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 133A0C433C1;
        Sat, 27 Aug 2022 15:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661613517;
        bh=R/FPlgh+i14+wvCo3ye35JKDBc9ySPLXlmivzP/hCn0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dzCuGaUc9VTghk2gQjzIr5ca2JYaVqPKhs5InSyKAUWLn6G34sldIYA9Bm8aGsyzY
         sBMhnrfQRz0j8wOM2KUcn8QN5HUEPyDyy6TgLbqbRAXr2BU++Z/rzQLKp4Uc+WH9jW
         aRVf3Xok72JKal9Wbw+Jkq0bw40HNdZ78v3IOVDd+PahpwdcogBh3Le2zKBtcpay6C
         cS/jGJAZt5YQD9+blS+03LYa2wqowTeC/bv6fQUA8qgGWiMhlVhw85IEM0hTjydhMM
         IkUrcHOY2WsFYsBeHQ5q7VN8YvIHgOJ4l+LNH7R2y1J7D/GA3JLiW6MWSlAewWKzVZ
         sSXKNw0KvlSAw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 58330404A1; Sat, 27 Aug 2022 12:18:34 -0300 (-03)
Date:   Sat, 27 Aug 2022 12:18:34 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: [PATCH v4 00/18] Mutex wrapper, locking and memory leak fixes
Message-ID: <Ywo1yt/2liQwDQot@kernel.org>
References: <20220826164027.42929-1-irogers@google.com>
 <0026becb-4e17-9e5f-0f59-9796d689c238@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0026becb-4e17-9e5f-0f59-9796d689c238@intel.com>
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

Em Sat, Aug 27, 2022 at 10:04:44AM +0300, Adrian Hunter escreveu:
> On 26/08/22 19:40, Ian Rogers wrote:
> > When fixing a locking race and memory leak in:
> > https://lore.kernel.org/linux-perf-users/20211118193714.2293728-1-irogers@google.com/
> > 
> > It was requested that debug mutex code be separated out into its own
> > files. This was, in part, done by Pavithra Gurushankar in:
> > https://lore.kernel.org/lkml/20220727111954.105118-1-gpavithrasha@gmail.com/
> > 
> > These patches fix issues with the previous patches, add in the
> > original dso->nsinfo fix and then build on our mutex wrapper with
> > clang's -Wthread-safety analysis. The analysis found missing unlocks
> > in builtin-sched.c which are fixed and -Wthread-safety is enabled by
> > default when building with clang.
> > 
> > v4. Adds a comment for the trylock result, fixes the new line (missed
> >     in v3) and removes two blank lines as suggested by Adrian Hunter.
> > v3. Adds a missing new line to the error messages and removes the
> >     pshared argument to mutex_init by having two functions, mutex_init
> >     and mutex_init_pshared. These changes were suggested by Adrian Hunter.
> > v2. Breaks apart changes that s/pthread_mutex/mutex/g and the lock
> >     annotations as requested by Arnaldo and Namhyung. A boolean is
> >     added to builtin-sched.c to terminate thread funcs rather than
> >     leaving them blocked on delted mutexes.
> > 
> > Ian Rogers (17):
> >   perf bench: Update use of pthread mutex/cond
> >   perf tests: Avoid pthread.h inclusion
> >   perf hist: Update use of pthread mutex
> >   perf bpf: Remove unused pthread.h include
> >   perf lock: Remove unused pthread.h include
> >   perf record: Update use of pthread mutex
> >   perf sched: Update use of pthread mutex
> >   perf ui: Update use of pthread mutex
> >   perf mmap: Remove unnecessary pthread.h include
> >   perf dso: Update use of pthread mutex
> >   perf annotate: Update use of pthread mutex
> >   perf top: Update use of pthread mutex
> >   perf dso: Hold lock when accessing nsinfo
> >   perf mutex: Add thread safety annotations
> >   perf sched: Fixes for thread safety analysis
> >   perf top: Fixes for thread safety analysis
> >   perf build: Enable -Wthread-safety with clang
> > 
> > Pavithra Gurushankar (1):
> >   perf mutex: Wrapped usage of mutex and cond
> 
> For all patches except 9 and 16
> 
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

Added it, did the usual round of tests and pushed out perf/core, we can
continue from there.

It also contains Adrian's "multiple recording time ranges" series.

Thanks!

- Arnaldo
