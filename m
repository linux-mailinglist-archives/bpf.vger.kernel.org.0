Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06FE46BC58C
	for <lists+bpf@lfdr.de>; Thu, 16 Mar 2023 06:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjCPFSc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Mar 2023 01:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCPFSb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Mar 2023 01:18:31 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8734FA4B01;
        Wed, 15 Mar 2023 22:18:29 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id l9-20020a17090a3f0900b0023d32684e7fso4945548pjc.1;
        Wed, 15 Mar 2023 22:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678943909;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lQkThabclSFSrHGkVJhUFLMeitSegsGICR7uAMH5ljA=;
        b=BE+qN+1QWaTed4BsGauV2Ri3pefR5tuFT20PGI/ArdoWosFZS14/w9Uh5sKPvXaEEv
         Wb4+bydqPAPvhv8BuhK/auhUBSE5rLdFqqUmy6b9z6UQBgmG1Xk9Tyf+RQ9XjqtZTPA+
         KLy6B5OMwWdda25FZDZrlpXy4iOi9Z3a1MquILGzZ6D3wTL7Yjv3S7h6Of6vLTS0e0I4
         qf/UfF5Wooz1tn0H+8nw6HteIAMij5GCAXrqHJzVhFcOta4eSkj5QKmmKl3EI90f9LEB
         3rZAeYmALxCNzZg2aOyKoglwPtHaDYhsXN0NE5EwFleeZfEqNe1jD+w2XmCBmKgYgmpx
         0kSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678943909;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lQkThabclSFSrHGkVJhUFLMeitSegsGICR7uAMH5ljA=;
        b=8M1hps6kLP5qgkvytg8Gt7T1bx+HuNXcb8bmy5MFf4vfAs84d1JvjaxvtzmPlNfN38
         lSRZ3pvulPcr8+8r7Rz0wZYQG4umjYxIqdkcE6sWeo8ZLFyuOjYl4eIxnuwszFtl+FYN
         6Bu66VsdzJyBe8dZtYM+FZBUPpdBJFPhRKTaKFlEe7GRHt027jpyaVWF/TFlMiB2XlZ5
         PMkn0Ul8yCHypUTW5mVKNovu9PWej4cIDJbQ1Z9Eky5LTj1t9m6UprUUiz2H2eS3SGND
         PuPz43BL1z5d38dMPzux1BR8JaSOWuROT/ZXUIHbJUfF0YasGeO5R+MC7/dqFNhNwRJ8
         smhw==
X-Gm-Message-State: AO0yUKWFYZXgtV7zcrFhFBwmezePZv/U6jeE2rth8yveXyoUjEm/Udyc
        fbxqBxMWKkNYl2vR0SK5bBE=
X-Google-Smtp-Source: AK7set9pwYn/0Xs8MzesfRiBTkcJdFM+9hnGUi2AiBSNyCiGA4Ur8oy3VTgaMyMJh2hzKoGUBW5DzA==
X-Received: by 2002:a17:902:db07:b0:19c:be57:9c82 with SMTP id m7-20020a170902db0700b0019cbe579c82mr2186934plx.65.1678943908829;
        Wed, 15 Mar 2023 22:18:28 -0700 (PDT)
Received: from google.com ([2620:15c:2d4:203:894e:b93:8c44:3d78])
        by smtp.gmail.com with ESMTPSA id q11-20020a170902f78b00b0019ee0ad15b4sm4477573pln.191.2023.03.15.22.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 22:18:28 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
Date:   Wed, 15 Mar 2023 22:18:25 -0700
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Song Liu <song@kernel.org>,
        Hao Luo <haoluo@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 02/10] perf bpf filter: Implement event sample filtering
Message-ID: <ZBKmoeGAmlhv+yvc@google.com>
References: <20230314234237.3008956-1-namhyung@kernel.org>
 <20230314234237.3008956-3-namhyung@kernel.org>
 <ZBHxRaP7BC+qDzJ/@kernel.org>
 <ZBH0s5P2KV5bJR3h@kernel.org>
 <CAM9d7cjrFT=c-Obw8TsVk3ntGtUEUoGzco8mUssiSPvuZN-iKw@mail.gmail.com>
 <ZBImvCSuWFUgjgQj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZBImvCSuWFUgjgQj@kernel.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 15, 2023 at 05:12:44PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Mar 15, 2023 at 09:51:03AM -0700, Namhyung Kim escreveu:
> > On Wed, Mar 15, 2023 at 9:39 AM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > Em Wed, Mar 15, 2023 at 01:24:37PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > Em Tue, Mar 14, 2023 at 04:42:29PM -0700, Namhyung Kim escreveu:
> > > > > The BPF program will be attached to a perf_event and be triggered when
> > > > > it overflows.  It'd iterate the filters map and compare the sample
> > > > > value according to the expression.  If any of them fails, the sample
> > > > > would be dropped.
> > > > >
> > > > > Also it needs to have the corresponding sample data for the expression
> > > > > so it compares data->sample_flags with the given value.  To access the
> > > > > sample data, it uses the bpf_cast_to_kern_ctx() kfunc which was added
> > > > > in v6.2 kernel.
> > > > >
> > > > > Acked-by: Jiri Olsa <jolsa@kernel.org>
> > > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > >
> > > >
> > > > I'm noticing this while building on a debian:11 container:
> > > >
> > > >   GENSKEL /tmp/build/perf/util/bpf_skel/bperf_leader.skel.h
> > > >   GENSKEL /tmp/build/perf/util/bpf_skel/bperf_follower.skel.h
> > > >   GENSKEL /tmp/build/perf/util/bpf_skel/func_latency.skel.h
> > > >   GENSKEL /tmp/build/perf/util/bpf_skel/bpf_prog_profiler.skel.h
> > > >   GENSKEL /tmp/build/perf/util/bpf_skel/kwork_trace.skel.h
> > > >   GENSKEL /tmp/build/perf/util/bpf_skel/sample_filter.skel.h
> > > > libbpf: failed to find BTF for extern 'bpf_cast_to_kern_ctx' [21] section: -2
> > > > Error: failed to open BPF object file: No such file or directory
> > > > make[2]: *** [Makefile.perf:1085: /tmp/build/perf/util/bpf_skel/sample_filter.skel.h] Error 254
> > > > make[2]: *** Deleting file '/tmp/build/perf/util/bpf_skel/sample_filter.skel.h'
> > > > make[2]: *** Waiting for unfinished jobs....
> > > > make[1]: *** [Makefile.perf:236: sub-make] Error 2
> > > > make: *** [Makefile:70: all] Error 2
> > > > make: Leaving directory '/git/perf-6.3.0-rc1/tools/perf'
> > > > + exit 1
> > > > [perfbuilder@five 11]$
> > >
> > > Same thing on debian:10
> > 
> > Hmm.. I thought extern symbols with__ksym are runtime
> > dependencies and it should build on old kernels too.
> > 
> > BPF folks, any suggestions?
> 
> Fedora 33 also fails, see below, but these work:

Maybe I can declare it as a weak symbol.  How about this?

Thanks,
Namhyung

---8<---

diff --git a/tools/perf/util/bpf_skel/sample_filter.bpf.c b/tools/perf/util/bpf_skel/sample_filter.bpf.c
index 57e3c67d6d37..52cbdd1765cd 100644
--- a/tools/perf/util/bpf_skel/sample_filter.bpf.c
+++ b/tools/perf/util/bpf_skel/sample_filter.bpf.c
@@ -17,7 +17,7 @@ struct filters {

 int dropped;

-void *bpf_cast_to_kern_ctx(void *) __ksym;
+void *bpf_cast_to_kern_ctx(void *) __ksym __weak;

 /* new kernel perf_sample_data definition */
 struct perf_sample_data___new {
@@ -118,6 +118,10 @@ int perf_sample_filter(void *ctx)
 	int group_result = 0;
 	int i;

+	/* no kernel context support, no filtering */
+	if (!bpf_cast_to_kern_ctx)
+		return 1;
+
 	kctx = bpf_cast_to_kern_ctx(ctx);

 	for (i = 0; i < MAX_FILTERS; i++) {

