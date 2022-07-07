Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E074B5696BC
	for <lists+bpf@lfdr.de>; Thu,  7 Jul 2022 02:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbiGGAHa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Jul 2022 20:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234749AbiGGAH3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Jul 2022 20:07:29 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0DA2DA8F
        for <bpf@vger.kernel.org>; Wed,  6 Jul 2022 17:07:26 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31cbcba2f28so49725097b3.19
        for <bpf@vger.kernel.org>; Wed, 06 Jul 2022 17:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oBkjfLfTEe2MgY1tbr+b+YRDO7m34AyR7isp5tYHsyE=;
        b=Z7AjiUhHDTpQXIK5bWfF18O1wlVwizlxsJhPWgycIxNfqamCT8q4eNshfVTUlTWxhe
         GjJTiKHROX3m+xYIv6QRj7edR0KpUycKzHK19fOZ4ARls+HFQZfNC2s4/ebdEBWprw5c
         m1yGFm9MFAes4M/8bJNTO4fvKqXXVA9hDw270MjM9wcexGb8PIjH4wRuN/gmUyPT/9s3
         mDqqXZqzOGDbGAd4ZqFCywVqqKbEz0pfbw6Jc9U6BgH4G16nxVE47F3g5xC7q5XzBO37
         lUqNrfvShb/mFbP1jiiL9jNvm9JQN3qGIyoyREhdW11u7+NwiQNVzJ/RHYW2S+N3WzC7
         ZhwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oBkjfLfTEe2MgY1tbr+b+YRDO7m34AyR7isp5tYHsyE=;
        b=dAV/BqZVfpfWhsFLZrqaFy82mKRIZ4PAdUpV5OOGIZlPY3rM/BD7w7p57r/bQ7BIs5
         AnolMV4nVrNu/Nu03XbjQzH/ZrrmTpHAuCyNiy9LU6eRWFT8agF0wH85u9vALHp723RH
         fVYf4KjiX+mRvXMdOaZ4wXRLq22CrGFAD1BZGKUvYe2Y/GC3OJ0/k8ap5k5JxmKhtyXl
         g7ldxD7gvA6gw2YmGhuVULk5YLQG7CVdiaFcbGA7n/dgwHcumEoSrO3zYz7Ai19/B5o6
         08A8puEv868/djSJfNK/C9oTHarK7Hi6owQeLv21q84QeWFQMQRIg3YEim+6axohyte1
         Xr9w==
X-Gm-Message-State: AJIora8Y2AbPXfkMMI7Ls4JSHKnsh2pryd1VU6HG7BipEYpaKwnQC2SX
        SIKBayIF7IvX3TestdK2Morp8otZ41jrOg==
X-Google-Smtp-Source: AGRyM1uTurFidR9Y6QsPzCPcVaFPYCIzXq/t8W3PN13Eo4HbuKd2k129zCsQPbGnBCCf8ExYJuVYm9Jl/K8c9w==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:28b])
 (user=shakeelb job=sendgmr) by 2002:a05:6902:1026:b0:66e:93aa:b4ae with SMTP
 id x6-20020a056902102600b0066e93aab4aemr5977002ybt.575.1657152445268; Wed, 06
 Jul 2022 17:07:25 -0700 (PDT)
Date:   Thu, 7 Jul 2022 00:07:21 +0000
In-Reply-To: <20220706155848.4939-2-laoar.shao@gmail.com>
Message-Id: <20220707000721.dtl356trspb23ctp@google.com>
Mime-Version: 1.0
References: <20220706155848.4939-1-laoar.shao@gmail.com> <20220706155848.4939-2-laoar.shao@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Make non-preallocated allocation low priority
From:   Shakeel Butt <shakeelb@google.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        quentin@isovalent.com, roman.gushchin@linux.dev, haoluo@google.com,
        bpf@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 06, 2022 at 03:58:47PM +0000, Yafang Shao wrote:
> GFP_ATOMIC doesn't cooperate well with memcg pressure so far, especially
> if we allocate too much GFP_ATOMIC memory. For example, when we set the
> memcg limit to limit a non-preallocated bpf memory, the GFP_ATOMIC can
> easily break the memcg limit by force charge. So it is very dangerous to
> use GFP_ATOMIC in non-preallocated case. One way to make it safe is to
> remove __GFP_HIGH from GFP_ATOMIC, IOW, use (__GFP_ATOMIC |
> __GFP_KSWAPD_RECLAIM) instead, then it will be limited if we allocate
> too much memory.

Please use GFP_NOWAIT instead of (__GFP_ATOMIC | __GFP_KSWAPD_RECLAIM).
There is already a plan to completely remove __GFP_ATOMIC and mm-tree
already have a patch for that.

> 
> We introduced BPF_F_NO_PREALLOC is because full map pre-allocation is
> too memory expensive for some cases. That means removing __GFP_HIGH
> doesn't break the rule of BPF_F_NO_PREALLOC, but has the same goal with
> it-avoiding issues caused by too much memory. So let's remove it.
> 
> The force charge of GFP_ATOMIC was introduced in
> commit 869712fd3de5 ("mm: memcontrol: fix network errors from failing
> __GFP_ATOMIC charges") by checking __GFP_ATOMIC, then got improved in
> commit 1461e8c2b6af ("memcg: unify force charging conditions") by
> checking __GFP_HIGH (that is no problem because both __GFP_HIGH and
> __GFP_ATOMIC are set in GFP_AOMIC). So, if we want to fix it in memcg,
> we have to carefully verify all the callsites. Now that we can fix it in
> BPF, we'd better not modify the memcg code.
> 
> This fix can also apply to other run-time allocations, for example, the
> allocation in lpm trie, local storage and devmap. So let fix it
> consistently over the bpf code
> 
> __GFP_KSWAPD_RECLAIM doesn't cooperate well with memcg pressure neither
> currently. But the memcg code can be improved to make
> __GFP_KSWAPD_RECLAIM work well under memcg pressure if desired.
> 

IMO there is no need to give all this detail and background on
GFP_ATOMIC and __GFP_KSWAPD_RECLAIM. Just say kernel allows GFP_ATOMIC
allocations to exceed memcg limits which we don't want in this case. So,
replace with GFP_NOWAIT which obey memcg limits. Both of these flags
tell kernel that the caller can not sleep.

