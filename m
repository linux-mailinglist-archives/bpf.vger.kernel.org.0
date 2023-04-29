Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017D46F2210
	for <lists+bpf@lfdr.de>; Sat, 29 Apr 2023 03:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347251AbjD2B1r (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Apr 2023 21:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347074AbjD2B1q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Apr 2023 21:27:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B48E7A;
        Fri, 28 Apr 2023 18:27:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FD74614AD;
        Sat, 29 Apr 2023 01:27:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37002C433D2;
        Sat, 29 Apr 2023 01:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682731664;
        bh=ZRDTKQMp+p7TvmVO01meyOc6q5mUqaXyAqx63RFLezc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kH51t25Nv9/QlCnFMxvjJEZTIvlN4IdUxvigW0bQr4wYmjxzbzR6efFqQ4o9aXX6h
         OlHCeAmgwEJDt1dDnSoPI+7iuZylBzBqmXifY3oJ95DKoGPwNYKL4zV0mS/XaIysKF
         683w0BqCv/SJL+ulP0udxr//8DAWLF+qUd5QTiGAN2UaI2gegOxD1Fr/y12JWNeUCW
         YlzctBaZx5PaQLUqz5GXuD1b6zhSeWjoV+/F8G9R2r7l78LIEwPPblVeG/IAdn9UUv
         rRukjxPNPxfFo9NaKcYc7UUrv3ngkTyHevUg85qoiiazT/TUxIHCgPpCmu5ybY14Em
         7fq2M2/nGy0tg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 45BE6403B5; Fri, 28 Apr 2023 22:27:41 -0300 (-03)
Date:   Fri, 28 Apr 2023 22:27:41 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        Andrii Nakryiko <andrii@kernel.org>,
        Hao Luo <haoluo@google.com>, Song Liu <song@kernel.org>
Subject: Re: [PATCH 1/2] perf lock contention: Fix struct rq lock access
Message-ID: <ZExyjXm6OF5oScGU@kernel.org>
References: <20230427234833.1576130-1-namhyung@kernel.org>
 <CAP-5=fX3pmozMci+hSSV3Nve6H6RUzusPY2_S7HeEtRJnZH7nA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fX3pmozMci+hSSV3Nve6H6RUzusPY2_S7HeEtRJnZH7nA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Apr 27, 2023 at 05:32:08PM -0700, Ian Rogers escreveu:
> On Thu, Apr 27, 2023 at 4:48 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > The BPF CO-RE's ignore suffix rule requires three underscores.
> > Otherwise it'd fail like below:
> >
> >   $ sudo perf lock contention -ab
> >   libbpf: prog 'collect_lock_syms': BPF program load failed: Invalid argument
> >   libbpf: prog 'collect_lock_syms': -- BEGIN PROG LOAD LOG --
> >   reg type unsupported for arg#0 function collect_lock_syms#380
> >   ; int BPF_PROG(collect_lock_syms)
> >   0: (b7) r6 = 0                        ; R6_w=0
> >   1: (b7) r7 = 0                        ; R7_w=0
> >   2: (b7) r9 = 1                        ; R9_w=1
> >   3: <invalid CO-RE relocation>
> >   failed to resolve CO-RE relocation <byte_off> [381] struct rq__new.__lock (0:0 @ offset 0)
> >
> > Fixes: 0c1228486bef ("perf lock contention: Support pre-5.14 kernels")
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied the series.

- Arnaldo

 
> Thanks,
> Ian
> 
> > ---
> >  tools/perf/util/bpf_skel/lock_contention.bpf.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > index 8911e2a077d8..30c193078bdb 100644
> > --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > @@ -418,11 +418,11 @@ int contention_end(u64 *ctx)
> >
> >  extern struct rq runqueues __ksym;
> >
> > -struct rq__old {
> > +struct rq___old {
> >         raw_spinlock_t lock;
> >  } __attribute__((preserve_access_index));
> >
> > -struct rq__new {
> > +struct rq___new {
> >         raw_spinlock_t __lock;
> >  } __attribute__((preserve_access_index));
> >
> > @@ -434,8 +434,8 @@ int BPF_PROG(collect_lock_syms)
> >
> >         for (int i = 0; i < MAX_CPUS; i++) {
> >                 struct rq *rq = bpf_per_cpu_ptr(&runqueues, i);
> > -               struct rq__new *rq_new = (void *)rq;
> > -               struct rq__old *rq_old = (void *)rq;
> > +               struct rq___new *rq_new = (void *)rq;
> > +               struct rq___old *rq_old = (void *)rq;
> >
> >                 if (rq == NULL)
> >                         break;
> > --
> > 2.40.1.495.gc816e09b53d-goog
> >

-- 

- Arnaldo
