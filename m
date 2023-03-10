Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAF26B538D
	for <lists+bpf@lfdr.de>; Fri, 10 Mar 2023 22:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbjCJV5q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Mar 2023 16:57:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231996AbjCJV5X (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Mar 2023 16:57:23 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6ACB134ACE;
        Fri, 10 Mar 2023 13:54:10 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id v11so7053607plz.8;
        Fri, 10 Mar 2023 13:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678485204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q5Orq6OUo/pN9+uOJs2jd/JlG/R3HWqXG9hbMYSUELE=;
        b=OdOUYQg8vBDloWdBEQa/m7LLPmkva3gwZ5Rtxf+t+92qz9ykvr0rv1uF09z4qEElG6
         K6XlbZX7G5N5/C/gObBFthqXf2iQ1T0aCufWBK3uXNmX5k3snV2XRsD6uImH/R7a6w/9
         pY2Yz5f+w1ON7ZYLC8u2UsefYbBIIs8S+HZvkHaA+9136uvmULJCWvCmjMcUJ3f952I2
         1tCXKZSnH27RXUvvYyIByjxLNBc1zIXJGEKkN1tgyrS/GxQ1zYtTvhJ26Vs3BeBUHhIn
         6y65/ZuUk36xid7J6OjX8O/DdOOTBjy4Gqy/HfJCek36wKj4YvgG+RaGTFuY5YlkGn7M
         4C5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678485204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q5Orq6OUo/pN9+uOJs2jd/JlG/R3HWqXG9hbMYSUELE=;
        b=Cr0fRtNs2DWsMhuUSCCy2Fnm4GdG2UMHyrokYo+RuZ0tW/MuRI4P9BRhLXWNYk3Zhv
         L34udUl0aiwGxCJswZbcadOIEzwZgd4ble3VDmp3SpWlaGsH5k/iVBuJJQgZKj6XmiX7
         jJsKKXJEpVtQJ7ht9CJ79aky15g24hAwyzRO9+W7JftLCcNtmb0BzNNT0Hs+EfOzhMNH
         uWU0frqopPCmIHH7xRg1AJ2511wbkxipm+hsKHcEDinzXJib7SzQYEopFUKRe+0ln0Yd
         ByNcSQZi55zi9AawQhxf2zgkm2kvYwiydPreSUcFJEhsiBISZ3lIGyJ8Kd8J9Gc/0Lzu
         u6PA==
X-Gm-Message-State: AO0yUKV26Yc4FlcslZhMgqFglKIH4mG2d3rGbX3CoMDf/fuyuqAAVP0g
        M1JajaadqdqR2X5ECxeSSWk=
X-Google-Smtp-Source: AK7set8xo1mmbiK6cPqAoEvmR80uh4F+/9s9AuHEj1y23Y8JhipidTbK3rOp41I3C2fY8kjTw0mrxg==
X-Received: by 2002:a17:90a:1a49:b0:234:b964:570d with SMTP id 9-20020a17090a1a4900b00234b964570dmr27514917pjl.13.1678485204044;
        Fri, 10 Mar 2023 13:53:24 -0800 (PST)
Received: from google.com ([2601:647:6780:44b0:e32f:ca65:5413:8ef7])
        by smtp.gmail.com with ESMTPSA id o13-20020a17090ad24d00b002343e59709asm359880pjw.46.2023.03.10.13.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 13:53:23 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
Date:   Fri, 10 Mar 2023 13:53:20 -0800
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ravi Bangoria <ravi.bangoria@amd.com>,
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
Message-ID: <ZAum0AFE27UMjfpG@google.com>
References: <20230307233309.3546160-1-namhyung@kernel.org>
 <f5b3de20-797c-4ff6-a85b-06c85b4eaa1b@amd.com>
 <ZAtG43JZkUoO9XkF@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZAtG43JZkUoO9XkF@kernel.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 10, 2023 at 12:04:03PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Mar 10, 2023 at 03:28:03PM +0530, Ravi Bangoria escreveu:
> > > It requires samples satisfy all the filter expressions otherwise it'd
> > > drop the sample.  IOW filter expressions are connected with logical AND
> > > operations unless they used "||" explicitly.  So if user has something
> > > like 'A, B || C, D', then BOTH A and D should be true AND either B or C
> > > also needs to be true.
> > > 
> > > Essentially the BPF filter expression is:
> > > 
> > >   <term> <operator> <value> (("," | "||") <term> <operator> <value>)*
> > > 
> > > The <term> can be one of:
> > >   ip, id, tid, pid, cpu, time, addr, period, txn, weight, phys_addr,
> > >   code_pgsz, data_pgsz, weight1, weight2, weight3, ins_lat, retire_lat,
> > >   p_stage_cyc, mem_op, mem_lvl, mem_snoop, mem_remote, mem_lock,
> > >   mem_dtlb, mem_blk, mem_hops
> > > 
> > > The <operator> can be one of:
> > >   ==, !=, >, >=, <, <=, &
> > > 
> > > The <value> can be one of:
> > >   <number> (for any term)
> > >   na, load, store, pfetch, exec (for mem_op)
> > >   l1, l2, l3, l4, cxl, io, any_cache, lfb, ram, pmem (for mem_lvl)
> > >   na, none, hit, miss, hitm, fwd, peer (for mem_snoop)
> > >   remote (for mem_remote)
> > >   na, locked (for mem_locked)
> > >   na, l1_hit, l1_miss, l2_hit, l2_miss, any_hit, any_miss, walk, fault (for mem_dtlb)
> > >   na, by_data, by_addr (for mem_blk)
> > >   hops0, hops1, hops2, hops3 (for mem_hops)
> > 
> > I think this and few examples should be added in perf-record man page.
> 
> Agreed, and even mentioning cases where it overcome problems like the
> filtering you mentioned for AMD systems.

Sure, will add them.

Thanks,
Namhyung
