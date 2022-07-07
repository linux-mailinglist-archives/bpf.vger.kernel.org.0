Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0A756A738
	for <lists+bpf@lfdr.de>; Thu,  7 Jul 2022 17:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235474AbiGGPox (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Jul 2022 11:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiGGPow (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Jul 2022 11:44:52 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB272F3B1
        for <bpf@vger.kernel.org>; Thu,  7 Jul 2022 08:44:51 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id ez10so2977851ejc.13
        for <bpf@vger.kernel.org>; Thu, 07 Jul 2022 08:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f0eWi5rDiGajbml66KrzPb2nGOrm6POqtc3uDDIFjbk=;
        b=iu+LZTBSEVdIzeb9mqfNlxRtlCoYA4IG7/Q5b8psqXj6tDkdpMbvSQBnqNxXH8SjC6
         8rraeh5SOsa66+LKowst4IOj31zNZodKRQG69Fb6BUHPxuBLVCwOpO697NFD93tLXBJC
         3KavEFUbALgqXER7OnhbVRVSQxhE92p9wRJeAv/et55ArAjvy7P99XNUBMcvRreAhh8t
         3IxOGeBWV8jUpkL1qpPDD6CBvMFX4FhSmKKLq5CYR0vomya7CnlWgErl0T45tx9VwMy4
         aJ8N5fI0vxRdBHSgLFMo7S8ts5asuvWnMYcrcTPxJV+/KCs7I6/1y8AGoa5aBp3buHV4
         SWSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f0eWi5rDiGajbml66KrzPb2nGOrm6POqtc3uDDIFjbk=;
        b=NV1sFTo6TeEqu2kwYYQWDOQm2t21t44eZv+2aZgSj6EVM6PAziTepdcmyo4iNuQcUP
         sHxwwN7kXZZbAeNsvL6Lkx/77ITOXY+PMTSy5eDhd3sg2LD/KbB4hVbwWl3+wFi7ULcr
         aMK/1RyHCWygYZ39uU/UxvOxClBB7k8ceYMJO0bdotYlh/vSre7/WHcjC7J9hEORx4oT
         R2haQeTIC0yYc3Bcr4sSQQ7Z6oLRCATXs2j/mmrlFCtIjUdMcJ2GkMKK5uBuR3GSBJoV
         Fi2yUphohKaqKyqpNFulW0LRurt88G0syjmUSooaoPQp9fxFg8Y/9L/ESS+GRresepJb
         cw6g==
X-Gm-Message-State: AJIora/R2bOUrkBJW+xPPt3ckcQJShOheQmxz6WYZSG3xiPCs2JD0woT
        M9XhqeBD61L6nT+nsBL9iyioYBv8dTsz0Az/DMc=
X-Google-Smtp-Source: AGRyM1t4J4haU/zZ9jX80t7qew5Jw2LVRgD5AfmwROthSGmYGKnNGikKo7g8zEz161C/cPDdJORVSifLF5b3koHN0X4=
X-Received: by 2002:a17:906:6146:b0:722:f8c4:ec9b with SMTP id
 p6-20020a170906614600b00722f8c4ec9bmr47691713ejl.708.1657208689506; Thu, 07
 Jul 2022 08:44:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220706155848.4939-1-laoar.shao@gmail.com> <20220706155848.4939-2-laoar.shao@gmail.com>
 <20220707000721.dtl356trspb23ctp@google.com> <CALOAHbC4RG_G2wjU0Nj_A9MhrHiQ7GXR7Yp7BCr+7dDmXwR-4w@mail.gmail.com>
In-Reply-To: <CALOAHbC4RG_G2wjU0Nj_A9MhrHiQ7GXR7Yp7BCr+7dDmXwR-4w@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 7 Jul 2022 08:44:37 -0700
Message-ID: <CAADnVQKJ44nmxzUDAkckXJ2mzJAshvzzGFP-oPT=NO3rGW7pQA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Make non-preallocated allocation low priority
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hao Luo <haoluo@google.com>, bpf <bpf@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 7, 2022 at 3:28 AM Yafang Shao <laoar.shao@gmail.com> wrote:
>
> On Thu, Jul 7, 2022 at 8:07 AM Shakeel Butt <shakeelb@google.com> wrote:
> >
> > On Wed, Jul 06, 2022 at 03:58:47PM +0000, Yafang Shao wrote:
> > > GFP_ATOMIC doesn't cooperate well with memcg pressure so far, especially
> > > if we allocate too much GFP_ATOMIC memory. For example, when we set the
> > > memcg limit to limit a non-preallocated bpf memory, the GFP_ATOMIC can
> > > easily break the memcg limit by force charge. So it is very dangerous to
> > > use GFP_ATOMIC in non-preallocated case. One way to make it safe is to
> > > remove __GFP_HIGH from GFP_ATOMIC, IOW, use (__GFP_ATOMIC |
> > > __GFP_KSWAPD_RECLAIM) instead, then it will be limited if we allocate
> > > too much memory.
> >
> > Please use GFP_NOWAIT instead of (__GFP_ATOMIC | __GFP_KSWAPD_RECLAIM).
> > There is already a plan to completely remove __GFP_ATOMIC and mm-tree
> > already have a patch for that.
> >
>
> After reading the discussion[1], it looks good to me to use GFP_NOWAIT
> instead. I will update it.

Should we use GFP_ATOMIC | __GFP_NOMEMALLOC instead
to align with its usage in the networking stack?
