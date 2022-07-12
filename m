Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582F35721D4
	for <lists+bpf@lfdr.de>; Tue, 12 Jul 2022 19:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiGLRgb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 13:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiGLRg3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 13:36:29 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA81C4440
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 10:36:28 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so9059007pjf.2
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 10:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RfyxacdG5IBfbLaiFP2j7TVDH6sp4yfvSyLKPWelm6k=;
        b=CD/x8J0HVROAHqRiCfTs/QVrM6JiSO4KL/DiAEZBOmWr9E2Bsxl+gQy7zzOCWSogUT
         EiNV0LsSZBzJM6agV8sin+F5q9ztsTaEAQIfjpuSQfD/B1gA5Wbp9lSo0+LtAxk11+Bl
         J77eE//HmXsLTmr6jZauLbdhagd4GFv2TfkPwqCYy4jmoedpKC1TEbS6QLJTSEI5RvKa
         UNLFn3wMwnVTzOsvj0OJzHNba8JMVzs7PqGp54+3MdiBA9wXlR02wJppDKd8zT+IF81K
         7Hw08LYy4l1hl4gIFft0+X+zGXqylt7i5EIjVwnwrfUAjlDyQjGwdP3bTZR75odsxRcm
         0LAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=RfyxacdG5IBfbLaiFP2j7TVDH6sp4yfvSyLKPWelm6k=;
        b=rKZt2jhPFcWr7RN/vl5HUSSajjC7oF7Ky9Aoi03nW/vbzy1tS80RkritNlkvjttt9z
         myb/clSyRMwhRibZKe+gVI6MAb6vm06NGqfK+g9828lM1dVE7AhVnaj7wVkF3VsiDCNu
         llchTQtqWbyfAhuLkyNUrWs2n9+J1oCB8zWlVEELxsHWfW3Ps7Huz8r4ps8SE6cVF1Us
         HIDGprVf3ajB7NfjF0A8LmppV9Lz0LHlYt6Uxs4PC4wLX417cx6HHae7O2oWR8CRUZ07
         MbQv4DYnn7kpddaBX2XMxONEiqkbKorWrAsRFnvaNZro/B4KZATMQkifr72ht5Q2YH5W
         6FFw==
X-Gm-Message-State: AJIora/mzby3kaz8f833zJrlAxved+2rU7D238t62Y+95P9DuT5wY+re
        wRuqdBBTggUiXj3VRgKRxOo=
X-Google-Smtp-Source: AGRyM1uPiM4XB+sGsiyBgP+kGPc094jqM3zJi0w8a2Mp8psGHVrhbPHoS90xy5TK6RKQjaprsqzuEQ==
X-Received: by 2002:a17:902:ef8f:b0:16a:463e:296c with SMTP id iz15-20020a170902ef8f00b0016a463e296cmr14090025plb.138.1657647388128;
        Tue, 12 Jul 2022 10:36:28 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id x13-20020a17090a46cd00b001ef7c7564fdsm9309170pjg.21.2022.07.12.10.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 10:36:27 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 12 Jul 2022 07:36:25 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        linux-mm <linux-mm@kvack.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH bpf-next 0/5] bpf: BPF specific memory allocator.
Message-ID: <Ys2xGe+rdviCAjsC@slm.duckdns.org>
References: <CAADnVQL5ZQDqMGULJLDwT9xRTihdDvo6GvwxdEOtSAs8EwE78A@mail.gmail.com>
 <20220710073213.bkkdweiqrlnr35sv@google.com>
 <YswUS/5nbYb8nt6d@dhcp22.suse.cz>
 <20220712043914.pxmbm7vockuvpmmh@macbook-pro-3.dhcp.thefacebook.com>
 <Ys0lXfWKtwYlVrzK@dhcp22.suse.cz>
 <CALOAHbAhzNTkT9o_-PRX=n4vNjKhEK_09+-7gijrFgGjNH7iRA@mail.gmail.com>
 <Ys1ES+CygtnUvArz@dhcp22.suse.cz>
 <CALvZod460hip0mQouEVtfcOZ0M21Xmzaa-atxxrUnR3ZisDCNw@mail.gmail.com>
 <Ys2iIVMZJNPe73MI@slm.duckdns.org>
 <CALvZod7YKrTvh-5SkDgFvtRk=DkxQ8iEhRGhDhhRGBXmYM4sFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod7YKrTvh-5SkDgFvtRk=DkxQ8iEhRGhDhhRGBXmYM4sFw@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

On Tue, Jul 12, 2022 at 10:26:22AM -0700, Shakeel Butt wrote:
> One use-case we have is a build & test service which runs independent
> builds and tests but all the build utilities (compiler, linker,
> libraries) are shared between those builds and tests.
> 
> In terms of topology, the service has a top level cgroup (P) and all
> independent builds and tests run in their own cgroup under P. These
> builds/tests continuously come and go.
> 
> This service continuously monitors all the builds/tests running and
> may kill some based on some criteria which includes memory usage.
> However the memory usage is nondeterministic and killing a specific
> build/test may not really free memory if most of the memory charged to
> it is from shared build utilities.

That doesn't sound too unusual. So, one saving grace here is that the memory
pressure in the stressed cgroup should trigger reclaim of the shared memory
which will be likely picked up by someone else, hopefully, under less memory
pressure. Can you give more concerete details? ie. describe a failing
scenario with actual ballpark memory numbers?

FWIW, at least from generic resource constrol standpoint, I think it may
make sense to have a way to escape certain resources to an ancestor for
shared resources provided that we can come up with a sane interface.

Thanks.

-- 
tejun
