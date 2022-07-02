Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C035640FE
	for <lists+bpf@lfdr.de>; Sat,  2 Jul 2022 17:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbiGBPYu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 2 Jul 2022 11:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiGBPYt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 2 Jul 2022 11:24:49 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA0CE029
        for <bpf@vger.kernel.org>; Sat,  2 Jul 2022 08:24:48 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id b81so2498477vkf.1
        for <bpf@vger.kernel.org>; Sat, 02 Jul 2022 08:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZYZxdXmI/oglg81rAbUCzetEWnT1Q+bPvxIhgaktwM8=;
        b=IVSWWCBj8x0AWjUc6w+J7bpVrU44M69imdesfjdBk5WShd97zxgnPZmCUC67U5YEF/
         D9GX3ccJxcJvoV76lcYQjRSv174srX1pjqfBNsJgUd+F6U/r4ykPHIzt3bqWMUqqKLud
         GuXcP1qhwrrhhDhkO3LiDiM9T+7/wfIXbMD35UfCPZKrUarI3Ja4XUfDBhmOE60HnaMq
         SSoc4CN0O+3+i7LQ1I2D3CxkYu1jyVf7/D/uV1CRsHievNI82KEaoq60oStuiw1p5MGd
         RUDeNiIkPo6iWIgA1E7C8p8tW13fXN7SvcBD0ODcYaVL+nlh++ImcLcnToulRrwiql/T
         Srjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZYZxdXmI/oglg81rAbUCzetEWnT1Q+bPvxIhgaktwM8=;
        b=x9JqxJVAtCgjQfCyswsZ5S6a+xAYwBMQ+7N7WPJ1JOpEadu+PdrvnhCHfYk1A9hbXl
         gGM8BWhj2ikxIuKmzJ0P4u0e8Ysz6u9mmYCY2NfaOZdm1nUatnG7u7AhJ1nU6sITJV7M
         yIsA7uOrfTcfnmd6YolFLXPrmCFy20iGP5rIs5V88x5tI18qZF5+7u7I5ols3wOWR6k2
         cyAk0hhBEoxg0pUCjKdjr4L6OzMccQ62zivfR6Sw/ZwzEdwmJZmtj+Vv7p5AR6gffcmo
         xmC2R6oJoiDlspwaZ5K9iXxCzUV2qhyD5tlhNNtkm0WOfXUTUf+AUnldQkCWrVuhGKKU
         k6tQ==
X-Gm-Message-State: AJIora8Rg4akJqRjDQYPp2rjdS6mWtvID8hWkqcR4Xz62FJf4lO4BILR
        kEs+A/xu5QLbXuodLSSuoW24Uh4VzQbnzjVrEAA=
X-Google-Smtp-Source: AGRyM1vP4VSPyWx6KiG+X/l6QGlfPV13N6qDlO3QVXdevWwtM0jnlh+r6nidF/V8xr5OwCPOf/I+KBb3YEab8SpvxSI=
X-Received: by 2002:a1f:a348:0:b0:36f:be56:9381 with SMTP id
 m69-20020a1fa348000000b0036fbe569381mr13893192vke.8.1656775487791; Sat, 02
 Jul 2022 08:24:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220619155032.32515-1-laoar.shao@gmail.com> <YrPeJ5L5mSI/MqrP@castle>
 <CALOAHbBXJkOqMZEzeTVy8JmMVjRr62n=69W5EQ=oTWyoeGVgNQ@mail.gmail.com>
 <YrfSXVDONpxcUDI+@castle> <CALOAHbC2j35V6wLh4+-m9_+EPPvFfT3KqkD_6JFsPYj78G6dSw@mail.gmail.com>
 <Yr/INyiQ3eV4ToIP@castle>
In-Reply-To: <Yr/INyiQ3eV4ToIP@castle>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sat, 2 Jul 2022 23:24:10 +0800
Message-ID: <CALOAHbCT=uAkp+HiJyfU-zOPfWnD2afHozUuZvrb8aiQyY6K1w@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 00/10] bpf, mm: Recharge pages when reuse bpf map
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>, penberg@kernel.org,
        David Rientjes <rientjes@google.com>, iamjoonsoo.kim@lge.com,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux MM <linux-mm@kvack.org>, bpf <bpf@vger.kernel.org>
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

On Sat, Jul 2, 2022 at 12:23 PM Roman Gushchin <roman.gushchin@linux.dev> wrote:
>
> On Sun, Jun 26, 2022 at 02:25:51PM +0800, Yafang Shao wrote:
> > > >                                              htab->map.numa_node);
> > > > And then we'd better introduce an improvement for memcg,
> > > > +      /*
> > > > +       *  Should wakeup async memcg reclaim first,
> > > > +       *   in case there will be no direct memcg reclaim for a long time.
> > > > +       *   We can either introduce async memcg reclaim
> > > > +       *   or modify kswapd to reclaim a specific memcg
> > > > +       */
> > > > +       if (gfp_mask & __GFP_KSWAPD_RECLAIM)
> > > > +            wake_up_async_memcg_reclaim();
> > > >          if (!gfpflags_allow_blocking(gfp_mask))
> > > >                 goto nomem;
> > >
> > > Hm, I see. It might be an issue if there is no global memory pressure, right?
> > > Let me think what I can do here too.
> > >
> >
> > Right. It is not a good idea to expect a global memory reclaimer to do it.
> > Thanks for following up with it again.
>
> After thinking a bit more, I'm not sure if it's actually a good idea:
> there might be not much memory to reclaim except the memory consumed by the bpf
> map itself, so waking kswapd might be useless (and just consume cpu and drain
> batteries).
>

I'm not sure if it is a generic problem.
For example, a latency-sensitive process running in a container
doesn't set __GFP_DIRECT_RECLAIM, but there're page cache pages in
this container. If there's no global memory pressure or no other kinds
of memory allocation in this container, these page cache pages will
not be reclaimed for a long time.
Maybe we should also check the number of page cache pages in this
container before waking up kswapd, but I'm not quite sure of it.

-- 
Regards
Yafang
