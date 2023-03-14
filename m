Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE1876B9DAD
	for <lists+bpf@lfdr.de>; Tue, 14 Mar 2023 18:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjCNR5y convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 14 Mar 2023 13:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjCNR5x (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Mar 2023 13:57:53 -0400
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854DB76B4;
        Tue, 14 Mar 2023 10:57:52 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id j6so4590604ilr.7;
        Tue, 14 Mar 2023 10:57:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678816671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PpqmR5FGblTUCTS1MnsgIvKqvurAy+dKc3s6nFwCqg0=;
        b=WuLBA1CrNcteftdXP4OzRssv0UCpwk6bPrQ0I4Lruo+oesHlAcW+EDk4sD/Wy2ey11
         1rzJ+aAofPFyvAEUfBXjr8ndpktA/v+vk0d4wLbvgm2gyfo6MssCtxxTMpLYAafz7zli
         WmJJ54gbJ7JudXr2sH1YLQ1ksEGftDojl2ufB8UUED8vYZLH2QaBY3I4hG76svlpDX70
         xgwlSnFxcKLCbgSovXEVao7fBkuwsqY1fAHaVU7gjasENnWGx9a3DC7MfQhWAMSDCEFe
         /oJ3SX+FF1k2mjSqes6+cvQcVI8Ku7JLhddRMPFK0d0QGLD3RZRbOhAp5eujNDUBmPko
         qhSQ==
X-Gm-Message-State: AO0yUKWuydVyykx40VaMdsBVMe4BK3pOIC3rn4XJPtjyNynWq1Ccl34O
        hGWwqU/nTELMR4OaN4kvPsY046xURfxZP2nkFs+owLcv
X-Google-Smtp-Source: AK7set+oWO7uxZNcxezoNglqkni5RC4P6boAGCI7NJtJfa15OOr/snj7IE8Sbl7MntPQWtOb8fjXbrvF+Xay+KFz390=
X-Received: by 2002:a92:d346:0:b0:313:fad9:a014 with SMTP id
 a6-20020a92d346000000b00313fad9a014mr1969666ilh.5.1678816671660; Tue, 14 Mar
 2023 10:57:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230307233309.3546160-1-namhyung@kernel.org> <f5b3de20-797c-4ff6-a85b-06c85b4eaa1b@amd.com>
 <ZAtG43JZkUoO9XkF@kernel.org> <ZBBc5SQK2OhIGtGy@kernel.org> <9b2a3f48-44bc-3719-9ba1-b60f9382a5ba@amd.com>
In-Reply-To: <9b2a3f48-44bc-3719-9ba1-b60f9382a5ba@amd.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 14 Mar 2023 10:57:40 -0700
Message-ID: <CAM9d7cjWbm1AcgEVx4ruYCtqxFVwEt_6SjoipmMPJRoUpk-hAQ@mail.gmail.com>
Subject: Re: [RFC/PATCHSET 0/9] perf record: Implement BPF sample filter (v4)
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Song Liu <song@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>, Hao Luo <haoluo@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

On Tue, Mar 14, 2023 at 8:27 AM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>
> On 14-Mar-23 5:09 PM, Arnaldo Carvalho de Melo wrote:
> > Em Fri, Mar 10, 2023 at 12:04:03PM -0300, Arnaldo Carvalho de Melo escreveu:
> >> Em Fri, Mar 10, 2023 at 03:28:03PM +0530, Ravi Bangoria escreveu:
> >>>> It requires samples satisfy all the filter expressions otherwise it'd
> >>>> drop the sample.  IOW filter expressions are connected with logical AND
> >>>> operations unless they used "||" explicitly.  So if user has something
> >>>> like 'A, B || C, D', then BOTH A and D should be true AND either B or C
> >>>> also needs to be true.
> >>>>
> >>>> Essentially the BPF filter expression is:
> >>>>
> >>>>   <term> <operator> <value> (("," | "||") <term> <operator> <value>)*
> >>>>
> >>>> The <term> can be one of:
> >>>>   ip, id, tid, pid, cpu, time, addr, period, txn, weight, phys_addr,
> >>>>   code_pgsz, data_pgsz, weight1, weight2, weight3, ins_lat, retire_lat,
> >>>>   p_stage_cyc, mem_op, mem_lvl, mem_snoop, mem_remote, mem_lock,
> >>>>   mem_dtlb, mem_blk, mem_hops
> >>>>
> >>>> The <operator> can be one of:
> >>>>   ==, !=, >, >=, <, <=, &
> >>>>
> >>>> The <value> can be one of:
> >>>>   <number> (for any term)
> >>>>   na, load, store, pfetch, exec (for mem_op)
> >>>>   l1, l2, l3, l4, cxl, io, any_cache, lfb, ram, pmem (for mem_lvl)
> >>>>   na, none, hit, miss, hitm, fwd, peer (for mem_snoop)
> >>>>   remote (for mem_remote)
> >>>>   na, locked (for mem_locked)
> >>>>   na, l1_hit, l1_miss, l2_hit, l2_miss, any_hit, any_miss, walk, fault (for mem_dtlb)
> >>>>   na, by_data, by_addr (for mem_blk)
> >>>>   hops0, hops1, hops2, hops3 (for mem_hops)
> >>>
> >>> I think this and few examples should be added in perf-record man page.
> >>
> >> Agreed, and even mentioning cases where it overcome problems like the
> >> filtering you mentioned for AMD systems.
> >
> > So, what do you think is best? Wait for v5 or apply v4 and then add
> > documentation and other touches as followup patches?
>
> I'm fine with both :)

Unless there's an objection, I'd prefer you take the v4.
I'll send a documentation update later.

Thanks,
Namhyung
