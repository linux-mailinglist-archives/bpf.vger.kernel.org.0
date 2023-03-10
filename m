Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7BDE6B5381
	for <lists+bpf@lfdr.de>; Fri, 10 Mar 2023 22:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbjCJV4i (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Mar 2023 16:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbjCJV4R (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Mar 2023 16:56:17 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1C012115E;
        Fri, 10 Mar 2023 13:52:53 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id n6so7064232plf.5;
        Fri, 10 Mar 2023 13:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678485142;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pETZAj5VDBvPkB0dnNFpPaZAzmDWUE3HyOC8UG6486I=;
        b=BcE8zC29FE4ucoAxuYrDJSIUsa/GDWb6ro30pP5GXLlmimrsNkqadlgAyUT44Fnvek
         Uw0wOh4YoetAjRzWk7Lv1Ef7lxg/Qk2otnAvHUgm5xG64XV++LijUWQzeNdX5W0tBi9k
         rb681CNRA7q02z+ZOIE3TBBA2mTZ49g94jmjliJkPFTq1KTSCE8nFBWzuQpADrhPQ0KP
         Fjxb4fI//sEhuqFpnNmizKeTSj8qf5ILvRlB/SUneLbXvIQed8kx5WgBGNC0NXiBOB0c
         k+w054A4sEySu8v6PPm3VtkEwAPAQfWart/5ysi2pYrSy+p4zCtZ78dPCkYiMNWOQm5w
         8Asw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678485142;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pETZAj5VDBvPkB0dnNFpPaZAzmDWUE3HyOC8UG6486I=;
        b=z/22Xi+fLTqmCQAOb8lqDtomerc0GPN6YmX4D4H4ftTqPoei1uP4twVVqGjMXGi79D
         860fb4I+LI3wKd9GIENBAMxYKlG0cWE/1RAeHdl/w1plmZYDC9603tw/e39lnG5jijZR
         K/MGT5oEScjkEZ1gUa5cbjDZ6oIo/02wCBN8l/1BxsDZMWxR+FYoarJR4KqCqK5UznIZ
         jFMF7d3PGHgWLHM4UUgKDSTMB6lICPrJjA1WkgBdZom2Nvtkx4o5SPAQVI1k8RvxyZTR
         qbZKXpS6r1EaXpCX3TBdiR5xQdSbmSQIiaChrR+iafLRBo30IU7h0ZT4ApvM5HNG7tTO
         Drsg==
X-Gm-Message-State: AO0yUKUFtVn6DqW4z8BOCspzShOg93HX0Wl6nBKu/c9PpXTGipnhR9Ey
        WNESmnun++5LGy3TyDMkTue0fqO3y04=
X-Google-Smtp-Source: AK7set+2KaDA+xbWXSJRMpqyskgCjo29jnRwLsb/oaT5Fa1npZhwXDqaAp7Vl5IC6+KDJDn8BbGmXg==
X-Received: by 2002:a05:6a20:a121:b0:d3:6238:11c8 with SMTP id q33-20020a056a20a12100b000d3623811c8mr315109pzk.20.1678485141662;
        Fri, 10 Mar 2023 13:52:21 -0800 (PST)
Received: from google.com ([2601:647:6780:44b0:e32f:ca65:5413:8ef7])
        by smtp.gmail.com with ESMTPSA id k10-20020aa790ca000000b005897f5436c0sm253555pfk.118.2023.03.10.13.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 13:52:21 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
Date:   Fri, 10 Mar 2023 13:52:18 -0800
From:   Namhyung Kim <namhyung@kernel.org>
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
Subject: Re: [RFC/PATCHSET 0/9] perf record: Implement BPF sample filter (v4)
Message-ID: <ZAumkq2L2bo8wDCk@google.com>
References: <20230307233309.3546160-1-namhyung@kernel.org>
 <9f692bd9-94e4-ee60-2174-561685b9b39a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9f692bd9-94e4-ee60-2174-561685b9b39a@amd.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Ravi,

On Fri, Mar 10, 2023 at 12:10:28PM +0530, Ravi Bangoria wrote:
> Hi Namhyung,
> 
> Sorry, I should have tried earlier prototypes but missed it.

No worries and thanks for your review!

> 
> > Maybe more useful example is when it deals with precise memory events.
> > On AMD processors with IBS, you can filter only memory load with L1
> > dTLB is missed like below.
> > 
> >   $ sudo ./perf record -ad -e ibs_op//p \
> >   > --filter 'mem_op == load, mem_dtlb > l1_hit' sleep 1
> >   [ perf record: Woken up 1 times to write data ]
> >   [ perf record: Captured and wrote 1.338 MB perf.data (15 samples) ]
> 
> On my zen4 machine:
> 
>   $ sudo ./perf record -d -e ibs_op//p --filter 'mem_op == load' -c 100000 ~/test
>   [ perf record: Woken up 6 times to write data ]
>   [ perf record: Captured and wrote 1.436 MB perf.data (30966 samples) ]
> 
>   $ sudo ./perf mem report -F sample,mem --stdio
>   #      Samples  Memory access
>   # ............  ........................
>            30325  L1 hit
>              477  Local RAM hit
>               89  L2 hit
>               75  L3 hit
> 
> This looks good because IBS hw can't filter specific type of instruction
> and thus unfiltered data will contain "NA" types of memory accesses, which
> is absent here. So mem_op == load filter seems to be working.

Good!

> 
> However, if I add "mem_lvl == l1" (or l2 / ram) in the filter, I see mostly
> all samples are getting lost:
> 
>   $ sudo ./perf record -d -e ibs_op//p --filter 'mem_op == load, mem_lvl == l1' -c 100000 ~/test
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.019 MB perf.data ]
> 
>   $ sudo ./perf report --stat | grep SAMPLE
>     LOST_SAMPLES events:          1  ( 0.8%)
>     LOST_SAMPLES events:     136332
> 
> What am I missing?

It seems IBS PMU doesn't set the mem_lvlnum field in the data source.
As I said in the patch 7, 'mem_lvl' actually uses mem_lvlnum fields
instead of mem_lvl because it's preferred according to the comment in
the UAPI header.

/*
 * PERF_MEM_LVL_* namespace being depricated to some extent in the
 * favour of newer composite PERF_MEM_{LVLNUM_,REMOTE_,SNOOPX_} fields.
 * Supporting this namespace inorder to not break defined ABIs.
 *
 * memory hierarchy (memory level, hit or miss)
 */

I'll post a patch to set it separately.

> 
> 2nd observation, invalid expressions like 'mem_op == load, mem_dtlb == l1'
> are not failing, instead recording misleading data:
> 
>   $ sudo ./perf record -d -e ibs_op//p --filter 'mem_op == load, mem_dtlb == l1' -c 100000 ~/test
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.047 MB perf.data (614 samples) ]
> 
>   $ sudo ./perf script -F data_src | grep "TLB N/A" | wc -l
>   614
 
Good point, that's the limitation in the current implementation.
I think it needs to keep the target sample field along with the
constant so that it can detect unintended uses.  Let's me think
about it more.

Thanks,
Namhyung
