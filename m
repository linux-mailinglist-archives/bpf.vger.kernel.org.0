Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825905901D7
	for <lists+bpf@lfdr.de>; Thu, 11 Aug 2022 18:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237073AbiHKP5b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Aug 2022 11:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237682AbiHKP5K (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Aug 2022 11:57:10 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8FFA9241
        for <bpf@vger.kernel.org>; Thu, 11 Aug 2022 08:47:37 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id m5-20020a170902f64500b0016d313f3ce7so11704020plg.23
        for <bpf@vger.kernel.org>; Thu, 11 Aug 2022 08:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=IuUmi8yK7ttP9DMj21dovzQZGBY13PHX+qXyVjOX3zQ=;
        b=cLRlgW077jVAPqEiOj0qYsBikpH8O3puBBLslNGoTJgjF+b6BVpcKOPNHdjwOf1qhd
         WYFRk5UNOu6AaulRni5vLlf7GW5zVXomALlhHClxvCP5XwkyY+3FIvChzlzJWIKHISej
         3dJtNuIgl6TunDKCi65jDWXH6efqru55AYzfUf+yd3/4nugqcTGRPMaYGmICdKi40VZS
         eYVqxbDXxqtewL3hR5/7q/aMFBblbiJjNIeHXPa0br4ciHHZZhVqySwVQYNBNeu4g32I
         3/JPvv40f1szRuqKM7+juNmXs1XeHM1Fkpuw41YVFQv78GctEgqO8glWf/DVbAOYA1t5
         V6EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=IuUmi8yK7ttP9DMj21dovzQZGBY13PHX+qXyVjOX3zQ=;
        b=x4D5ZK+ktCl+7dBfRulivpBBpTAzOn+WUdE0EEpGr8iM0KFmLGLQaJHtEYY5i8SgjV
         QHljLJYMXvbY5wrCV2Rqj2S1WGfGS430xO5Pnj3r2XtW9KAxtalEw1MIp5TlA2sP1lza
         JpfYmTtffex/c/Q+eqPGMYVBA2n0W3ww0VrcBYaKGgK5oscRZSyzwLn3I6vQDVV4mxjE
         lF8/drbHJqBOj7qNjxCERNPQepnS7pAJPXn5EjAdQMNmRKNsNt0VW/NgdDfZGysIIDVZ
         GF+dX817kpaZUGvauCh8pnR+lRSqmix4ysnH8nUhUThptos0/OcQjjDcQ122AC+UvP+R
         J/ZA==
X-Gm-Message-State: ACgBeo2UwN0k7z4Svpp7bVP6EJOeASFbmeEeQjRpNnaW4XaGyu1qWYY4
        Zdwpp0V4/mBbiDUsmsdn0+OYnYBzoAHZLA==
X-Google-Smtp-Source: AA6agR5jU6SuRrnL1iSm+IArLzseac+oOI/Drs50eHZDtXnirQjPsSD2P965Ps18qhwgee7fgN00JA/weOPVFA==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:28b])
 (user=shakeelb job=sendgmr) by 2002:aa7:8096:0:b0:52d:d5f6:2ea6 with SMTP id
 v22-20020aa78096000000b0052dd5f62ea6mr32956638pff.0.1660232854787; Thu, 11
 Aug 2022 08:47:34 -0700 (PDT)
Date:   Thu, 11 Aug 2022 15:47:31 +0000
In-Reply-To: <CALOAHbBk+komswLqs0KBg8FeFAYpC20HjXrUeZA-=7cWf6nRUw@mail.gmail.com>
Message-Id: <20220811154731.3smhom6v4qy2u6rd@google.com>
Mime-Version: 1.0
References: <20220810151840.16394-1-laoar.shao@gmail.com> <20220810151840.16394-6-laoar.shao@gmail.com>
 <20220810170706.ikyrsuzupjwt65h7@google.com> <CALOAHbBk+komswLqs0KBg8FeFAYpC20HjXrUeZA-=7cWf6nRUw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 05/15] bpf: Fix incorrect mem_cgroup_put
From:   Shakeel Butt <shakeelb@google.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, jolsa@kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 11, 2022 at 10:49:13AM +0800, Yafang Shao wrote:
> On Thu, Aug 11, 2022 at 1:07 AM Shakeel Butt <shakeelb@google.com> wrote:
> >
> > On Wed, Aug 10, 2022 at 03:18:30PM +0000, Yafang Shao wrote:
> > > The memcg may be the root_mem_cgroup, in which case we shouldn't put it.
> >
> > No, it is ok to put root_mem_cgroup. css_put already handles the root
> > cgroups.
> >
> 
> Ah, this commit log doesn't describe the issue clearly. I should improve it.
> The issue is that in bpf_map_get_memcg() it doesn't get the objcg if
> map->objcg is NULL (that can happen if the map belongs to the root
> memcg), so we shouldn't put the objcg if map->objcg is NULL neither in
> bpf_map_put_memcg().

Sorry I am still not understanding. We are not 'getting' objcg in
bpf_map_get_memcg(). We are 'getting' memcg from map->objcg and if that
is NULL the function is returning root memcg and putting root memcg is
totally fine. Or are you saying that root_mem_cgroup is NULL?

> Maybe the change below would be more reasonable ?
> 
> +static void bpf_map_put_memcg(const struct bpf_map *map, struct
> mem_cgroup *memcg)
> +{
> +       if (map->objcg)
> +           mem_cgroup_put(memcg);
> +}
> 
> -- 
> Regards
> Yafang
