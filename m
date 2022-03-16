Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70034DB641
	for <lists+bpf@lfdr.de>; Wed, 16 Mar 2022 17:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350251AbiCPQg4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Mar 2022 12:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234162AbiCPQg4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Mar 2022 12:36:56 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55375DE68
        for <bpf@vger.kernel.org>; Wed, 16 Mar 2022 09:35:41 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id g19so4430079pfc.9
        for <bpf@vger.kernel.org>; Wed, 16 Mar 2022 09:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=275NXYJb5aDtfGLgJwV8jy6NeIY7jYYNXA4F+p+7cbI=;
        b=ca3YzU4ecHyoF5z9aV8JSuIo/aHcR1av61umXYi8JxoeJeLfrsg6bHwTJ+7QfqMAY2
         W5AJIv4jxXQqUafuQZkfyhG7dP7qQFMBfcbxYK74ZjEXybe+6DGMthl8sYjC6VHmBtKT
         MgGAvgJYWvrZvnpwYny8tHp5qwO1Wwa0sh9mJT0E6i5rD4MskKotZI7ypsp4Co/l2tVm
         PnXhHqsdCtll4ouLcB65KDtuFEfQHm4tvaRbUiniF8ugw9gwtPknP2TGah+iUDshxBkc
         uQ1LypK8NDdZHngCEYebr8//kv5aJfMWaTrpDvEKnEJy4RRIzqMPGcpT2Y/SZd0ZsZ03
         SUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=275NXYJb5aDtfGLgJwV8jy6NeIY7jYYNXA4F+p+7cbI=;
        b=DM379HLIQ0EblwCD/Ihy+tjIvFgFiFrHPzhsVXgXKNGSX+h/6OqlpZ1/NFs/68keuL
         fNnors3RGX9cZ1ilVfDOnHN/WDXLLAqw9fwA1GkGcA3NuB8zOtlVFGId2MbhFIfzzIsc
         hQqDT9vTYSdHuuaFF9mdL02Cu/PnzBmzW66Hpw5ETf1ni+AKiKjZq1TAbRkg48pHdXx3
         xl8FjZINiunzC4U6/9NydFQeL2Q0FCCoqqUgoKmxc8lpBpUdP2TMICZKT74lcEtIYf1T
         6KW1MHEBUm+8VTFmKBkgt/LWhecvFyP/9reH9hk3Rl2tg9lJPDg/xuFHoEn5LdwPU5jA
         hIQw==
X-Gm-Message-State: AOAM530XjZ3X7zjyisIMqo8dOKqIl3sM+8tDFTYozTTE28IhD0gHHeij
        sz9ggULf4qq0HkjdwQsAI9HP8T4vTGB/NfmjhBld1A==
X-Google-Smtp-Source: ABdhPJy0dfdrNHDXfzLhLoV648rli3spqHAE3tjA1YC2TLkbHATBCWj+SMR8ittEPqKuL6E9L0btG1d4/XdhA5vNQAc=
X-Received: by 2002:a65:6091:0:b0:35e:d274:5f54 with SMTP id
 t17-20020a656091000000b0035ed2745f54mr383547pgu.200.1647448541147; Wed, 16
 Mar 2022 09:35:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAJD7tkbQNpeX8MGw9dXa5gi6am=VNXwgwUoTd6+K=foixEm1fw@mail.gmail.com>
 <Yi7ULpR70HatVP/8@slm.duckdns.org>
In-Reply-To: <Yi7ULpR70HatVP/8@slm.duckdns.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 16 Mar 2022 09:35:05 -0700
Message-ID: <CAJD7tkYGUaeeFMJSWNbdgaoEq=kFTkZzx8Jy1fwWBvt2WEfqAA@mail.gmail.com>
Subject: Re: [RFC bpf-next] Hierarchical Cgroup Stats Collection Using BPF
To:     Tejun Heo <tj@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hao Luo <haoluo@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        David Rientjes <rientjes@google.com>,
        bpf <bpf@vger.kernel.org>, KP Singh <kpsingh@kernel.org>,
        cgroups@vger.kernel.org, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Tejun,

Thanks for taking the time to read my proposal! Sorry for the late
reply. This email skipped my inbox for some reason.

On Sun, Mar 13, 2022 at 10:35 PM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Wed, Mar 09, 2022 at 12:27:15PM -0800, Yosry Ahmed wrote:
> ...
> > These problems are already addressed by the rstat aggregation
> > mechanism in the kernel, which is primarily used for memcg stats. We
>
> Not that it matters all that much but I don't think the above statement is
> true given that sched stats are an integrated part of the rstat
> implementation and io was converted before memcg.
>

Excuse my ignorance, I am new to kernel development. I only saw calls
to cgroup_rstat_updated() in memcg and io and assumed they were the
only users. Now I found cpu_account_cputime() :)

> > - For every cgroup, we will either use flags to distinguish BPF stats
> > updates from normal stats updates, or flush both anyway (memcg stats
> > are periodically flushed anyway).
>
> I'd just keep them together. Usually most activities tend to happen
> together, so it's cheaper to aggregate all of them in one go in most cases.

This makes sense to me, thanks.

>
> > - Provide flags to enable/disable using per-cpu arrays (for stats that
> > are not updated frequently), and enable/disable hierarchical
> > aggregation (for non-hierarchical stats, they can still make benefit
> > of the automatic entries creation & deletion).
> > - Provide different hierarchical aggregation operations : SUM, MAX, MIN, etc.
> > - Instead of an array as the map value, use a struct, and let the user
> > provide an aggregator function in the form of a BPF program.
>
> I'm more partial to the last option. It does make the usage a bit more
> compilcated but hopefully it shouldn't be too bad with good examples.
>
> I don't have strong opinions on the bpf side of things but it'd be great to
> be able to use rstat from bpf.

It indeed gives more flexibility but is more complicated. Also, I am
not sure about the overhead to make calls to BPF programs in every
aggregation step. Looking forward to get feedback on the bpf side of
things.

>
> Thanks.
>
> --
> tejun
