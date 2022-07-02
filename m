Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61CAD563EB2
	for <lists+bpf@lfdr.de>; Sat,  2 Jul 2022 07:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbiGBFux (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 2 Jul 2022 01:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbiGBFuw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 2 Jul 2022 01:50:52 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D45E192BC
        for <bpf@vger.kernel.org>; Fri,  1 Jul 2022 22:50:51 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id c13so432687pla.6
        for <bpf@vger.kernel.org>; Fri, 01 Jul 2022 22:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8qtzQsHSUiJ4njxuFZSHmk7WzYx/9S8h0IgnGcSJp0Q=;
        b=XbpRXQnjxt6+EHcIDifmMhgCz9P8NjZYvPJBAcZpS+YAbhdr4Mf7ucGl3K9kDWb3Sk
         +omwUSF8e7r/y9zsWXeYQTGko6DwIp1zn8qlu0/b97RKhhQur2P7I6eOomkFo2PU1ALH
         hgR0bVsN0kiKxy8apJ780YH98SbKF0ZRzjbv68R9DXzZ8zDo3WWIaeYNFgNMUcwHJtm3
         NA2FDZizt58+qGaSs1wCCGy6jERhpsILnicGek6cuTJ4TWYSyapTs3JoLWOCGZTy6FS0
         aAtJWrvejyeFPvDiCh/SKTO4KRN+neIA605mh/Dpcy9lOJCa++OhJPONojzpSN0nzgZD
         6ydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8qtzQsHSUiJ4njxuFZSHmk7WzYx/9S8h0IgnGcSJp0Q=;
        b=j/f1uBHWXgXmBZuCNIBZxNWfR4dl1ZXBipDjhAw65KO7BOGQKVcRQbr9AH8ww8osTi
         MeDg1GnN6JW0H3zNeVw80De8BeQ3r6EfttKkSEESUEziNhPD61IJonpGGQBzxh+PbYxt
         HQ7lTxH3INpYLNh9v3zZNo3rl5wTTQammUN10w52A9LY1tfya4BPOOKSEfam0r8lUp3q
         DqfVDEwysE2oZ3f7UdqSIt38El+EzCTNTSkJZPm4T5cS6cJdJXDOLpxEzNHqIdxZWGAa
         fGjd1Fn4voRS18/H1m635NbNhsMPtXR8VfyB/WKcUpKGlqOwYuw+2BbDc5592G/WvnlN
         PShg==
X-Gm-Message-State: AJIora/i33dcgQ/ALfq5xRscLio2ogYVHO1EIFvMPyzuuzsP67lLcpqk
        1phP01g2GP1peUQnYEJznSu9TOjJXxaFv7vHxd0z/Q==
X-Google-Smtp-Source: AGRyM1vbSQdXGyH6L0zs8jtlDMyZ8BzhUpRxx/EAh8d4seGyQA8pdfr8jTcN+NEamh6jseV0fEVo1N0tm0Twp8/02rc=
X-Received: by 2002:a17:90b:3b92:b0:1ec:b866:c398 with SMTP id
 pc18-20020a17090b3b9200b001ecb866c398mr20816134pjb.237.1656741050960; Fri, 01
 Jul 2022 22:50:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220702033521.64630-1-roman.gushchin@linux.dev>
In-Reply-To: <20220702033521.64630-1-roman.gushchin@linux.dev>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 1 Jul 2022 22:50:40 -0700
Message-ID: <CALvZod7TGhWtcRD6HeEx90T2+Rod-yamq9i+WbEQUKwNFTi-1A@mail.gmail.com>
Subject: Re: [PATCH] mm: memcontrol: do not miss MEMCG_MAX events for enforced allocations
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        bpf <bpf@vger.kernel.org>
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

On Fri, Jul 1, 2022 at 8:35 PM Roman Gushchin <roman.gushchin@linux.dev> wrote:
>
> Yafang Shao reported an issue related to the accounting of bpf
> memory: if a bpf map is charged indirectly for memory consumed
> from an interrupt context and allocations are enforced, MEMCG_MAX
> events are not raised.
>
> It's not/less of an issue in a generic case because consequent
> allocations from a process context will trigger the reclaim and
> MEMCG_MAX events. However a bpf map can belong to a dying/abandoned
> memory cgroup, so it might never happen.

The patch looks good but the above sentence is confusing. What might
never happen? Reclaim or MAX event on dying memcg?

> So the cgroup can
> significantly exceed the memory.max limit without even triggering
> MEMCG_MAX events.
>
> Fix this by making sure that we never enforce allocations without
> raising a MEMCG_MAX event.
>
> Reported-by: Yafang Shao <laoar.shao@gmail.com>
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Muchun Song <songmuchun@bytedance.com>
> Cc: cgroups@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: bpf@vger.kernel.org
> ---
>  mm/memcontrol.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 655c09393ad5..eb383695659a 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2577,6 +2577,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>         bool passed_oom = false;
>         bool may_swap = true;
>         bool drained = false;
> +       bool raised_max_event = false;
>         unsigned long pflags;
>
>  retry:
> @@ -2616,6 +2617,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>                 goto nomem;
>
>         memcg_memory_event(mem_over_limit, MEMCG_MAX);
> +       raised_max_event = true;
>
>         psi_memstall_enter(&pflags);
>         nr_reclaimed = try_to_free_mem_cgroup_pages(mem_over_limit, nr_pages,
> @@ -2682,6 +2684,13 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>         if (!(gfp_mask & (__GFP_NOFAIL | __GFP_HIGH)))
>                 return -ENOMEM;
>  force:
> +       /*
> +        * If the allocation has to be enforced, don't forget to raise
> +        * a MEMCG_MAX event.
> +        */
> +       if (!raised_max_event)
> +               memcg_memory_event(mem_over_limit, MEMCG_MAX);
> +
>         /*
>          * The allocation either can't fail or will lead to more memory
>          * being freed very soon.  Allow memory usage go over the limit
> --
> 2.36.1
>
