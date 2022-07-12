Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 638A35720DD
	for <lists+bpf@lfdr.de>; Tue, 12 Jul 2022 18:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbiGLQcj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 12:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbiGLQch (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 12:32:37 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CBACC01B
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 09:32:36 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id s27so8019665pga.13
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 09:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=36hChXhZD7e1BU/dCd5AJq0lPf1x1NPmuTN2tiYyqjA=;
        b=n7ZqeU7FP4t8OZIU4MjHTqGUXqcx3+vlKlvrKCLQLjt+yzW680ldGOeekZTql0alb+
         9VkZBDwTTM84TYnklqeE1egnG0iijOn5hTss7iT8dmY1asJQ78EvwC/o8bVcwQ/NESXb
         fp4M+orUI5M8SBluiWSlzk2OLHcEg/QdfnCRz+bQdguB6QB4ZftrjsDo5+I5TlqLanB8
         1+CTfYNBq/EBIn2vXVI0hPQJfR4tFQZJMEbAvMGSJlAQrtRutLh1POlBif0UOGpcEuTs
         7kTliSXb4LDnob31gooijEbqSlAagHDiI7+E7nOJgQuBrgb7C5y/NKmxPU8awEe0agWD
         uTfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=36hChXhZD7e1BU/dCd5AJq0lPf1x1NPmuTN2tiYyqjA=;
        b=wp8ksj1dvtgfzD8bhh04NtoAqbK503d54fqV10uFE6X5zOAQSYVVa4EkWnoaQAn14t
         aadnBB4fxbd1cOftC2rbrpWNywwE9+AIH2Rn5ZTSYWunbGKXGWNEzcnJkbRY+xei7vyq
         6e+OVWAMwRMy+4u0hAg1HRWcu5yKu+ig4pHJO7/hrlrCzhvoIJgpDfEaFDfdsqykeMvy
         c85LiRSPGsJ/7w1bmrHm0r044hCiND3v2YN/yt700jlOvUE2AQAkFuKkwlPjbiixVFR0
         fubdXKtalsnZhs32vRToqC975uzWdLs088D0u6QJwhwrtV2GeDYCvrQpuoH1sFK+T8IF
         jmYw==
X-Gm-Message-State: AJIora+8/Wpz7+lSava5TNFRV14diNB+wNnXKErm8Y+IPqlIN9Z1HmKP
        HaLpJiWYold2uHJbhrYRfMY=
X-Google-Smtp-Source: AGRyM1uhOPbLyK+2uJv53/vsPqdhlVh6Yck3gq7c1UoyjUwufYFEuAvg5FaopQhIYlah2Rti2loT1g==
X-Received: by 2002:a05:6a00:9a0:b0:52a:e646:d90c with SMTP id u32-20020a056a0009a000b0052ae646d90cmr4586657pfg.86.1657643555999;
        Tue, 12 Jul 2022 09:32:35 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id 70-20020a621549000000b0050dc76281d3sm7165937pfv.173.2022.07.12.09.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 09:32:35 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 12 Jul 2022 06:32:33 -1000
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
Message-ID: <Ys2iIVMZJNPe73MI@slm.duckdns.org>
References: <20220708174858.6gl2ag3asmoimpoe@macbook-pro-3.dhcp.thefacebook.com>
 <20220708215536.pqclxdqvtrfll2y4@google.com>
 <CAADnVQL5ZQDqMGULJLDwT9xRTihdDvo6GvwxdEOtSAs8EwE78A@mail.gmail.com>
 <20220710073213.bkkdweiqrlnr35sv@google.com>
 <YswUS/5nbYb8nt6d@dhcp22.suse.cz>
 <20220712043914.pxmbm7vockuvpmmh@macbook-pro-3.dhcp.thefacebook.com>
 <Ys0lXfWKtwYlVrzK@dhcp22.suse.cz>
 <CALOAHbAhzNTkT9o_-PRX=n4vNjKhEK_09+-7gijrFgGjNH7iRA@mail.gmail.com>
 <Ys1ES+CygtnUvArz@dhcp22.suse.cz>
 <CALvZod460hip0mQouEVtfcOZ0M21Xmzaa-atxxrUnR3ZisDCNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod460hip0mQouEVtfcOZ0M21Xmzaa-atxxrUnR3ZisDCNw@mail.gmail.com>
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

On Tue, Jul 12, 2022 at 08:25:24AM -0700, Shakeel Butt wrote:
> Another very obvious example is the filesystem shared between multiple
> jobs. We had a similar discussion [1] on LRU reparenting patch series.

Hmm... if I'm understanding correctly, what's discussed in [1] can be solved
with proper reparenting and nesting, right?

> For this use-case internally we have a memcg= mount option where the
> given memcg is the common ancestor (think of pod in k8s environment)
> of the jobs who are sharing the filesystem.

Can you elaborate a bit more on this? We've never really supported correctly
accounting pages shared across cgroups because it can be very complicating
and the use cases aren't that wide-spread. What's being shared? How big is
the shared portion in relation to total memory usage? What's the cgroup
topology like?

Thanks.

-- 
tejun
