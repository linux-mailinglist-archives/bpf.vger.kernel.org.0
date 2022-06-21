Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DFD553EEB
	for <lists+bpf@lfdr.de>; Wed, 22 Jun 2022 01:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353746AbiFUX2j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Jun 2022 19:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355280AbiFUX2h (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Jun 2022 19:28:37 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F42430576
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 16:28:36 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id i15so13849646plr.1
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 16:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vwcIftnXJAkvEoF6fWQk3kCUqAZlBwoDcF9sZVeuSD4=;
        b=GGqQdJEuWG9fZ3BBPU3FUGch7OGYrjQR7WRKodWKv4qyIZfh9EooAcadQkSLWy02iN
         KhK9uznHQtC29O0acVji9VyIwZv8Y0bKCg+REQee+IMu9s625+kc8uuLYh6D8hvsGYcs
         YS+9qyA/QWnakTOZrLggsX/rE6ix1wJK1VnSyM6851WfwY4mahel3YEPFTkF4DoylycX
         5cYmty4GhLXJTZtCV2Ji9FvS7XZecIHsvqG5idMYsjIqSafVrHwvvGVHCUuHX8ILig+m
         Wp+vCmH2QtkdgfJ6rtJFaCNEx47qErzFEfhMss2p5YTnBSDoKeLx1orkI2b2BcvZ2OBo
         0Vmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vwcIftnXJAkvEoF6fWQk3kCUqAZlBwoDcF9sZVeuSD4=;
        b=3Z0NFp4QDK1viF2MJ3yyA/Ih2/eBJyiv6vWuBbOJos4NWGF8tj6JenZ1gUbURtGRKf
         Z9ObRhpAMUNoILI3f6EiggA9pyjFloXVBhF1qCxcIvqEpsKgnrziqgLI2o6xXE5bT2bt
         A0DCSckzXac4/sYqbRfd2s/jTwxJrxOb+/mtfihSc30MYd0QJTZhqVrIin9E+j06iWpB
         h9O6sHOYytrs8IrvCK4gYwJJohWafLA256MLI3l7MZMFeHLsXclhUcxTVNzhSbqIxCyG
         FOX+Xvco5ry52oxae1fdHdpoPEfHZBnAV+bOiPsT6Nw26boUh5VR8IkTKnhbsulsJWyu
         ZWVA==
X-Gm-Message-State: AJIora86xtvmyrYsn64kVw0mkm3VmiTPqAE5zoTVEAwiPpcAZbJK8U91
        vRhg7b6ybYuRYx26LA8n0E4=
X-Google-Smtp-Source: AGRyM1tQuOwvwRGn2S1JFaZp6d9rBeWsVG0m1VNeOMpBS8YCnObqhvpm4okhrFSeWYUWYuqhFnLX5A==
X-Received: by 2002:a17:902:728d:b0:168:d0cf:2246 with SMTP id d13-20020a170902728d00b00168d0cf2246mr31274003pll.74.1655854115844;
        Tue, 21 Jun 2022 16:28:35 -0700 (PDT)
Received: from macbook-pro-3.dhcp.thefacebook.com ([2620:10d:c090:400::5:29cb])
        by smtp.gmail.com with ESMTPSA id p188-20020a62d0c5000000b005251fc16ff8sm5605898pfg.220.2022.06.21.16.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 16:28:35 -0700 (PDT)
Date:   Tue, 21 Jun 2022 16:28:31 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        quentin@isovalent.com, hannes@cmpxchg.org, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        songmuchun@bytedance.com, akpm@linux-foundation.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        vbabka@suse.cz, linux-mm@kvack.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next 00/10] bpf, mm: Recharge pages when reuse
 bpf map
Message-ID: <20220621232831.nkw2e7ezfy55p6hg@macbook-pro-3.dhcp.thefacebook.com>
References: <20220619155032.32515-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220619155032.32515-1-laoar.shao@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Jun 19, 2022 at 03:50:22PM +0000, Yafang Shao wrote:
> After switching to memcg-based bpf memory accounting, the bpf memory is
> charged to the loader's memcg by default, that causes unexpected issues for
> us. For instance, the container of the loader may be restarted after
> pinning progs and maps, but the bpf memcg will be left and pinned on the
> system. Once the loader's new generation container is started, the leftover
> pages won't be charged to it. That inconsistent behavior will make trouble
> for the memory resource management for this container.
> 
> In the past few days, I have proposed two patchsets[1][2] to try to resolve
> this issue, but in both of these two proposals the user code has to be
> changed to adapt to it, that is a pain for us. This patchset relieves the
> pain by triggering the recharge in libbpf. It also addresses Roman's
> critical comments.
> 
> The key point we can avoid changing the user code is that there's a resue
> path in libbpf. Once the bpf container is restarted again, it will try
> to re-run the required bpf programs, if the bpf programs are the same with
> the already pinned one, it will reuse them.
> 
> To make sure we either recharge all of them successfully or don't recharge
> any of them. The recharge prograss is divided into three steps:
>   - Pre charge to the new generation 
>     To make sure once we uncharge from the old generation, we can always
>     charge to the new generation succeesfully. If we can't pre charge to
>     the new generation, we won't allow it to be uncharged from the old
>     generation.
>   - Uncharge from the old generation
>     After pre charge to the new generation, we can uncharge from the old
>     generation.
>   - Post charge to the new generation
>     Finnaly we can set pages' memcg_data to the new generation. 
> In the pre charge step, we may succeed to charge some addresses, but fail
> to charge a new address, then we should uncharge the already charged
> addresses, so another recharge-err step is instroduced.
>  
> This pachset has finished recharging bpf hash map. which is mostly used
> by our bpf services. The other maps hasn't been implemented yet. The bpf
> progs hasn't been implemented neither.

... and the implementation in patch 10 is missing recharge of htab->elems
which consumes the most memory.
That begs the question how the whole set was tested.

Even if that bug is fixed this recharge approach works only with preallocated
maps. Their use will be reduced in the future.
Maps with kmalloc won't work with this multi step approach.
There is no place where bpf_map_release_memcg can be done without racing
with concurrent kmallocs from bpf program side.

Despite being painful for user space the user space has to deal with it.
It created a container, charged its memcg, then destroyed the container,
but didn't free the bpf map. It's a user bug. It has to free the map.
The user space can use map-in-map solution. In the new container the new bpf map
can be allocated (and charged to new memcg), the data copied from old map,
and then inner map replaced. At this point old map can be freed and memcg
uncharged.
To make things easier we can consider introducing an anon FD that points to a memcg.
Then user can pick a memcg at map creation time instead of get_mem_cgroup_from_current.
