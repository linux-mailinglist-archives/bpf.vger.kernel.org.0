Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB715571B4
	for <lists+bpf@lfdr.de>; Thu, 23 Jun 2022 06:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiFWEjt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jun 2022 00:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238983AbiFWD3z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Jun 2022 23:29:55 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC453584F
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 20:29:54 -0700 (PDT)
Date:   Wed, 22 Jun 2022 20:29:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1655954992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7m7PQ41eyC1auFWCI8Zpow+ZtCZNE5Ds6mZn3mJOYLE=;
        b=gqcrSqAIqvA4tGnnDQSdrA4QcBbGIY4GjjVlUblJoFA6Ga6YgvXJiLKzSMQzckepJfBCGh
        6ymvLL545ttlYYvLsqsmxCJscoLt+9n+UwUoDNDvJNzjzj/9uup/3ZvspazXP9RaXTMg2r
        Xom5H1CZu6Teuici16/sjaWd7KXrLdQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        quentin@isovalent.com, hannes@cmpxchg.org, mhocko@kernel.org,
        shakeelb@google.com, songmuchun@bytedance.com,
        akpm@linux-foundation.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, vbabka@suse.cz,
        linux-mm@kvack.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next 00/10] bpf, mm: Recharge pages when reuse
 bpf map
Message-ID: <YrPeJ5L5mSI/MqrP@castle>
References: <20220619155032.32515-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220619155032.32515-1-laoar.shao@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

Without going into the implementation details, the overall approach looks
ok to me. But it adds complexity and code into several different subsystems,
and I'm 100% sure it's not worth it if we talking about a partial support
of a single map type. Are you committed to implement the recharging
for all/most map types and progs and support this code in the future?

I'm still feeling you trying to solve a userspace problem in the kernel.
Not saying it can't be solved this way, but it seems like there are
easier options.

Thanks!
