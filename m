Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254986B818A
	for <lists+bpf@lfdr.de>; Mon, 13 Mar 2023 20:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjCMTPl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Mar 2023 15:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjCMTPj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Mar 2023 15:15:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1509234FA;
        Mon, 13 Mar 2023 12:14:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B489B811CF;
        Mon, 13 Mar 2023 19:14:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B2ADC433EF;
        Mon, 13 Mar 2023 19:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678734855;
        bh=LXMh4NvSmVKBlcVqMo1zkDaUAwShf4KNcqkkQcUaVJA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jpY3IHTZv4aO25v5UD6QgNlLNvH5SQufaCoqj60K9+AC04CTrR5jyW9v30vb5wOEc
         6YMoX0prQMTxf0tmgkBY5t3JcjPjwSGqAKTyQ2SkCw5OSZ+se90cc3VGFOqruurx04
         cv9evuqG/4F1L/Wnb22ICEZw3ufqk/QN8LW3YE72mpgl9RaNqNmTvC9PEUTMO0Bm4J
         9GXV5cM7qRQRML68Qh/C6Wf60hBbE6KmLe6kV+4e3RrKVhzp+THxJm9joS6Pzl/VLZ
         hEKTD4FgtPB25L/eeaVWsjs7WlUsGojQweXzf7C1T2P5oJvcJI67hBl/sDFuF1AKv2
         ZpVyImNC4247w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BA0FB4049F; Mon, 13 Mar 2023 16:14:12 -0300 (-03)
Date:   Mon, 13 Mar 2023 16:14:12 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH v2] perf lock contention: Fix builtin detection
Message-ID: <ZA92BKt4E7ZAogol@kernel.org>
References: <20230308003020.3653271-1-irogers@google.com>
 <CAM9d7ciyGagEiM6zSVjh9VpsiShLeRBUFjfGGLrzoqTD+hT9KA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7ciyGagEiM6zSVjh9VpsiShLeRBUFjfGGLrzoqTD+hT9KA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Mar 07, 2023 at 05:41:19PM -0800, Namhyung Kim escreveu:
> On Tue, Mar 7, 2023 at 4:30 PM Ian Rogers <irogers@google.com> wrote:
> >
> > __has_builtin was passed the macro rather than the actual builtin
> > feature. The builtin test isn't sufficient and a clang version test
> > also needs to be performed.
> >
> > Fixes: 1bece1351c65 ("perf lock contention: Support old rw_semaphore type")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied.

- Arnaldo

 
> Thanks,
> Namhyung
> 
> 
> > ---
> >  tools/perf/util/bpf_skel/lock_contention.bpf.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > index e6007eaeda1a..141b36d13b19 100644
> > --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > @@ -182,7 +182,13 @@ static inline struct task_struct *get_lock_owner(__u64 lock, __u32 flags)
> >                 struct mutex *mutex = (void *)lock;
> >                 owner = BPF_CORE_READ(mutex, owner.counter);
> >         } else if (flags == LCB_F_READ || flags == LCB_F_WRITE) {
> > -#if __has_builtin(bpf_core_type_matches)
> > +       /*
> > +        * Support for the BPF_TYPE_MATCHES argument to the
> > +        * __builtin_preserve_type_info builtin was added at some point during
> > +        * development of clang 15 and it's what is needed for
> > +        * bpf_core_type_matches.
> > +        */
> > +#if __has_builtin(__builtin_preserve_type_info) && __clang_major__ >= 15
> >                 if (bpf_core_type_matches(struct rw_semaphore___old)) {
> >                         struct rw_semaphore___old *rwsem = (void *)lock;
> >                         owner = (unsigned long)BPF_CORE_READ(rwsem, owner);
> > --
> > 2.40.0.rc0.216.gc4246ad0f0-goog
> >

-- 

- Arnaldo
