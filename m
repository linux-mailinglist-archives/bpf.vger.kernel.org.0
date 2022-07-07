Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A82D56A7E3
	for <lists+bpf@lfdr.de>; Thu,  7 Jul 2022 18:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235967AbiGGQUf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Jul 2022 12:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235881AbiGGQUe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Jul 2022 12:20:34 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043EB25EAF
        for <bpf@vger.kernel.org>; Thu,  7 Jul 2022 09:20:34 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id 189so18794164vsh.2
        for <bpf@vger.kernel.org>; Thu, 07 Jul 2022 09:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ci6aP7nKVQUaHARVmSRnYm57qnA3hBbkbfQkbvG0XxM=;
        b=bn2LAVeJrnwPGUJTR23aVQd2z1NTOuHTvpU/tYSYxdlwQuROcEQ3mFWTjFuR/eT9bz
         kOmuNckX3qdC7gTX86kUSMLc6ba6opfm5k4s8kIQPVFordq1Y8xDfPcR/yIE4vdjn1di
         nsxdWsPC0KBppiVaq34zd4k25zNJtoGIi/zZlu+PcrYCHpnMeLxpFHYFmM7BTP/0DFl5
         Wef945ienMtpNZsusurRYwMMfHESj7SYZ2z1J1QHb2k7ijZGQmdiT8o0IHVAFaBQtbM5
         AcZCaF1YddU4OgOsUBFxmCL9FGzfb7czqj4kPJ4MD/nQ1VJmCg9WZcUZrTDbkX4qf3+F
         4b8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ci6aP7nKVQUaHARVmSRnYm57qnA3hBbkbfQkbvG0XxM=;
        b=8JxU0nb/SLsmOz7KoUuD9AzcdHS0R09L9PWHAXp9VWIB/Lneym6zShewWO8sEWk0nh
         vJbUbAy+7mWpz437E2lTtMzxpC41egPnYywTrad3m9NkbrXBH8bCgA/YRc2N2KaNbJGW
         4CXQvnN1Xl834rm7foeg5fT5zGU2JXqhqvM3bzEwF9HQ/b00bbqZW7luMVZGUPcfc8+i
         u3FKrFQIdrl1PZGGpYiUcc/0LCjTH2Dc4N2clsPaACfdR4nu+XEx+Kyc3zEcS5cgOhi7
         0sZ3dbub7OdedLcJc0e2zXjk2fMnof/2ylLkq+Vgyqc4R+hZfO0L3vw+o9nSZITUxHX3
         vlmA==
X-Gm-Message-State: AJIora8doFV/WELO/xFV/ktfsB758Ujt48/7f90DlkQCDcVrO6eHLzLx
        WB/KOm3Pd3Ezy+q5XbuWUnxQwG1ONiUHCeenqxU=
X-Google-Smtp-Source: AGRyM1vEEck/CSTfqPPPCywcusjE/F0df+gWYrSoMQDaMK9O8h1v3u4YxUY9WEwcXcYOwfz537RsgK/t4A36exmbZYA=
X-Received: by 2002:a67:1945:0:b0:355:ab65:9db3 with SMTP id
 66-20020a671945000000b00355ab659db3mr27849908vsz.22.1657210833074; Thu, 07
 Jul 2022 09:20:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220706155848.4939-1-laoar.shao@gmail.com> <20220706155848.4939-2-laoar.shao@gmail.com>
 <20220707000721.dtl356trspb23ctp@google.com> <CALOAHbC4RG_G2wjU0Nj_A9MhrHiQ7GXR7Yp7BCr+7dDmXwR-4w@mail.gmail.com>
 <CAADnVQKJ44nmxzUDAkckXJ2mzJAshvzzGFP-oPT=NO3rGW7pQA@mail.gmail.com>
In-Reply-To: <CAADnVQKJ44nmxzUDAkckXJ2mzJAshvzzGFP-oPT=NO3rGW7pQA@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Fri, 8 Jul 2022 00:19:56 +0800
Message-ID: <CALOAHbBu=GwPCYqJVe98EOdO6ts6keZpA5uNtosbJJ0jwg5pDg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Make non-preallocated allocation low priority
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
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

On Thu, Jul 7, 2022 at 11:44 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Jul 7, 2022 at 3:28 AM Yafang Shao <laoar.shao@gmail.com> wrote:
> >
> > On Thu, Jul 7, 2022 at 8:07 AM Shakeel Butt <shakeelb@google.com> wrote:
> > >
> > > On Wed, Jul 06, 2022 at 03:58:47PM +0000, Yafang Shao wrote:
> > > > GFP_ATOMIC doesn't cooperate well with memcg pressure so far, especially
> > > > if we allocate too much GFP_ATOMIC memory. For example, when we set the
> > > > memcg limit to limit a non-preallocated bpf memory, the GFP_ATOMIC can
> > > > easily break the memcg limit by force charge. So it is very dangerous to
> > > > use GFP_ATOMIC in non-preallocated case. One way to make it safe is to
> > > > remove __GFP_HIGH from GFP_ATOMIC, IOW, use (__GFP_ATOMIC |
> > > > __GFP_KSWAPD_RECLAIM) instead, then it will be limited if we allocate
> > > > too much memory.
> > >
> > > Please use GFP_NOWAIT instead of (__GFP_ATOMIC | __GFP_KSWAPD_RECLAIM).
> > > There is already a plan to completely remove __GFP_ATOMIC and mm-tree
> > > already have a patch for that.
> > >
> >
> > After reading the discussion[1], it looks good to me to use GFP_NOWAIT
> > instead. I will update it.
>
> Should we use GFP_ATOMIC | __GFP_NOMEMALLOC instead
> to align with its usage in the networking stack?

GFP_ATOMIC | __GFP_NOMEMALLOC will continue to break the memcg limit,
so we have to modify the try_charge_memcg() code to make sure
__GFP_NOMEMALLOC takes precedence over the __GFP_HIGH flag, IOW, if
both of them are set we won't allow it to break memcg limit.  That
will need more verification.

-- 
Regards
Yafang
