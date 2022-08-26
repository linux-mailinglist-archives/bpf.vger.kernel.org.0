Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3FF5A2FCA
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 21:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243923AbiHZTVK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 15:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235389AbiHZTVJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 15:21:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FD7B07F6;
        Fri, 26 Aug 2022 12:21:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB19461E86;
        Fri, 26 Aug 2022 19:21:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C381FC433C1;
        Fri, 26 Aug 2022 19:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661541667;
        bh=QvGGfd4u3ZgGNQzPE8cvR++tbeSXUZdTtSLRfphuRE0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hpZWFIk7lRrtsGJa4ByLTO07Az2diNblNKXw38vxSFZWOD5B5cddPYiKIDDRz4a//
         9z+u4etBw19PB9BzhBsiLLLgBx4B4Rnxz+QfB3YAMd476DOnri7C5lM19u5jIlagix
         oyLfXFn7SoKxxcABMjSlmAHd3zMGL7jkuBIlDS3Mcy7ARZF68/7kuiTDVuFYFyO1FP
         c/1LWUsqCALw5vcgk/UF6mHPL8w0GyN87zfyXVQf4r1XtzTLVJkh6yCcy/brxEi5Hx
         lZCD8w78PS5G2+p4ExhYnVdXG3fOZfd25Gpr4SPH8C0qPG1Ctj+sXhTeORATjWmyxq
         JTDkKV//4dBzg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9B00B404A1; Fri, 26 Aug 2022 16:21:04 -0300 (-03)
Date:   Fri, 26 Aug 2022 16:21:04 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
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
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, llvm@lists.linux.dev
Subject: Re: [PATCH v4 00/18] Mutex wrapper, locking and memory leak fixes
Message-ID: <YwkdIBsQEKXG3/rE@kernel.org>
References: <20220826164242.43412-1-irogers@google.com>
 <CAM9d7cgQZsbwWSdRNQqUE+GsSgPVqFmKs9LJ5b6ta2-dax5T2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cgQZsbwWSdRNQqUE+GsSgPVqFmKs9LJ5b6ta2-dax5T2Q@mail.gmail.com>
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

Em Fri, Aug 26, 2022 at 12:08:06PM -0700, Namhyung Kim escreveu:
> On Fri, Aug 26, 2022 at 9:42 AM Ian Rogers <irogers@google.com> wrote:
> >
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
> For the patches 1-7 and 10-13
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks added it, will try to get what is done so far merged and then we
can go on addressing the other issues brought up in this thread.

- Arnaldo
