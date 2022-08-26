Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662875A2FBE
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 21:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbiHZTNo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 15:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiHZTNl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 15:13:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B2B98CB4;
        Fri, 26 Aug 2022 12:13:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8726DB83117;
        Fri, 26 Aug 2022 19:13:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3BB3C433D6;
        Fri, 26 Aug 2022 19:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661541218;
        bh=JE597L0A8gq9ni57nPTbmMIrbFvwDzfCUptaHqm/PD8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=llIVgHlns//rbdeTSXSMeKly1n1//+21QUco6oCapWf30ICEfWmSE0BwDs9Gppwby
         Q74BxtWgot+r8SAsvro02yInv4G7BD1J7DfBgWrzuuxnJf85wtrzEQTc9CrfjQk0nH
         ZUksYFBilRTg59WqWKZ7zC+abisJaposQOz8wqKAfpAtFoHcmC5n4TGDhm80QYQ4oI
         16OsjtzdR6aaaxZLsBoeQRWYilvc8My2Mce4OZI4KL1PNn/T1lkiD/JOFKdoocJXRx
         u5EMdf1RsMU/4kBFqeiOvqT8Tq4ewyvXyAzeewn0qmVbxXgirW8loLME+y3UBKaHxE
         SE9puroD7iMcg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 36438404A1; Fri, 26 Aug 2022 16:13:35 -0300 (-03)
Date:   Fri, 26 Aug 2022 16:13:35 -0300
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
Message-ID: <YwkbXwLGXitFuEfV@kernel.org>
References: <20220824153901.488576-1-irogers@google.com>
 <20220824153901.488576-16-irogers@google.com>
 <Ywj4vnYp6KGrrwl+@kernel.org>
 <CAP-5=fU0Kc+ZhVBXWz1zup1wFGUf8EOyaRREmfXDfD+hGGoL6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fU0Kc+ZhVBXWz1zup1wFGUf8EOyaRREmfXDfD+hGGoL6w@mail.gmail.com>
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

Em Fri, Aug 26, 2022 at 10:00:43AM -0700, Ian Rogers escreveu:
> On Fri, Aug 26, 2022 at 9:45 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Wed, Aug 24, 2022 at 08:38:58AM -0700, Ian Rogers escreveu:
> > > Add thread safety annotations to struct mutex so that when compiled with
> > > clang's -Wthread-safety warnings are generated for erroneous lock
> > > patterns. NO_THREAD_SAFETY_ANALYSIS is needed for
> > > mutex_lock/mutex_unlock as the analysis doesn't under pthread calls.
> >
> > So even having the guards checking if the attribute is available it
> > seems at least clang 11.0 is needed, as the "lockable" arg was
> > introduced there:
> >
> >   37    42.61 fedora:32                     : FAIL clang version 10.0.1 (Fedora 10.0.1-3.fc32)
> >     In file included from /git/perf-6.0.0-rc2/tools/perf/util/../ui/ui.h:5:
> >     /git/perf-6.0.0-rc2/tools/perf/util/../ui/../util/mutex.h:74:8: error: invalid capability name 'lockable'; capability name must be 'mutex' or 'role' [-Werror,-Wthread-safety-attributes]
> >     struct LOCKABLE mutex {
> >            ^
> >     /git/perf-6.0.0-rc2/tools/perf/util/../ui/../util/mutex.h:35:44: note: expanded from macro 'LOCKABLE'
> >     #define LOCKABLE __attribute__((capability("lockable")))
> 
> 
> capability("lockable") can just be lockable, the capability
> generalization came in a later clang release.
> 
> That is change:
> #define LOCKABLE __attribute__((capability("lockable")))
> to:
> #define LOCKABLE __attribute__((lockable))
> 
> and later clangs take the earlier name. Do you want a v5 for this 1 liner?

I did it and I'm now testing, thanks.

- Arnaldo

diff --git a/tools/perf/util/mutex.h b/tools/perf/util/mutex.h
index 48a2d87598f0d725..29b5494b213a3fc9 100644
--- a/tools/perf/util/mutex.h
+++ b/tools/perf/util/mutex.h
@@ -32,7 +32,7 @@
 #define PT_GUARDED_BY(x) __attribute__((pt_guarded_by(x)))
 
 /* Documents if a type is a lockable type. */
-#define LOCKABLE __attribute__((capability("lockable")))
+#define LOCKABLE __attribute__((lockable))
 
 /* Documents functions that acquire a lock in the body of a function, and do not release it. */
 #define EXCLUSIVE_LOCK_FUNCTION(...)  __attribute__((exclusive_lock_function(__VA_ARGS__)))

- Arnaldo
