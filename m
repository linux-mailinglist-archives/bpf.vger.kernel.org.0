Return-Path: <bpf+bounces-5499-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E0675B41C
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 18:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 545571C21487
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 16:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2F019BB3;
	Thu, 20 Jul 2023 16:24:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C7018C33
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 16:24:44 +0000 (UTC)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B040C110
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 09:24:42 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-403a1d7d60fso8977001cf.1
        for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 09:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1689870282; x=1690475082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s74T/DS0uEk+n6R0wwBy5aetjEjuSLERJS55RIwoaX4=;
        b=IZzpQokKpB0UhARjk1C5AYsxhEoUwekbG1CIGPqpzF+J5EyUNV4fXvSh6ICM60s/l/
         l3LTb+/4oHtXOm/axHhrDe9RYyjLFUcJp/fjdEfH3AfdarB9wYiD6qDHqXQIUGTULJjY
         vw7yjUAGA6a1rzcc8PN64w16jP4JWgFnyix3oUPgbdJpcchORfcHKjhuGO7hDatwjMex
         Tgoo3H3N3xNYsZnI1oMU+JFxWEkqso9+qil3xyi6Lze7Drl2ReIPDqQjSEa8jAMYviY/
         z9eO+nZw1PsJ45lS/RFq6qSgkSD6Jl0gP4PD3UUJ8jAvUFV4u798afEKcJEM6QS2Vj9Y
         5HwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689870282; x=1690475082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s74T/DS0uEk+n6R0wwBy5aetjEjuSLERJS55RIwoaX4=;
        b=jxcpH3YZA08LPiT+qn/jmuoXa/VuU9ql/a8B7vjgCpKt2pObO0VkgV99PnlXs7lr0k
         G49Ps5yf1SiDbunGgoa5ghKTj64689x2Yd6iKbrdOn9ECw5ehwMgPbOnCv4C/j8m+67q
         iSzX7hR55bTMU5JoJnzYtcLt5mEa9ozTrP+tpVkRUZVApWmiVQN8A+VGMTjw1YxJTgbV
         VQFZ/Ijk2d25uRp2VI10WZQrA/Xuqi9suzv2k0x8UH6azcKlAu1ySb46kWSdIq3MgiS2
         Trn5mI1pxm/otqdN0igGQ3mZ6w2M5tbMF5rt5mYLvRUWAs0BQV+M9w8MbXfUnE+nCFri
         52kA==
X-Gm-Message-State: ABy/qLZdbtEZbIDc8BFkM2Juj77I3APoXCYCnAM+fvjZU17krXHM73ik
	imoW6EysBMoONib7cYpmTJtYNQ==
X-Google-Smtp-Source: APBJJlFgEYqldxkiOjJHk0bAl/tukxpRZVH2RVuIZHt9j9/eVwHSR5HC6Q+XrizCrjEJ9XxT5shHCA==
X-Received: by 2002:ac8:598d:0:b0:403:b4da:6e53 with SMTP id e13-20020ac8598d000000b00403b4da6e53mr3014943qte.44.1689870281860;
        Thu, 20 Jul 2023 09:24:41 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-8f57-5681-ccd3-4a2e.res6.spectrum.com. [2603:7000:c01:2716:8f57:5681:ccd3:4a2e])
        by smtp.gmail.com with ESMTPSA id s41-20020a05622a1aa900b00405447ee5e8sm457395qtc.55.2023.07.20.09.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 09:24:41 -0700 (PDT)
Date: Thu, 20 Jul 2023 12:24:40 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Efly Young <yangyifei03@kuaishou.com>
Cc: cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Michal Hocko <mhocko@suse.com>, Shakeel Butt <shakeelb@google.com>,
	Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [PATCH] mm:vmscan: fix inaccurate reclaim during proactive
 reclaim
Message-ID: <20230720162440.GA1015794@cmpxchg.org>
References: <20230720072708.55067-1-yangyifei03@kuaishou.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720072708.55067-1-yangyifei03@kuaishou.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 20, 2023 at 03:27:08PM +0800, Efly Young wrote:
> Before commit f53af4285d77 ("mm: vmscan: fix extreme overreclaim and
> swap floods"), proactive reclaim will extreme overreclaim sometimes.
> But proactive reclaim still inaccurate and some extent overreclaim.
> 
> Problematic case is easy to construct. Allocate lots of anonymous
> memory (e.g., 20G) in a memcg, then swapping by writing memory.recalim
> and there is a certain probability of overreclaim. For example, request
> 1G by writing memory.reclaim will eventually reclaim 1.7G or other
> values more than 1G.
> 
> The reason is that reclaimer may have already reclaimed part of requested
> memory in one loop, but before adjust sc->nr_to_reclaim in outer loop,
> call shrink_lruvec() again will still follow the current sc->nr_to_reclaim
> to work. It will eventually lead to overreclaim. In theory, the amount
> of reclaimed would be in [request, 2 * request).
> 
> Reclaimer usually tends to reclaim more than request. But either direct
> or kswapd reclaim have much smaller nr_to_reclaim targets, so it is
> less noticeable and not have much impact.
> 
> Proactive reclaim can usually come in with a larger value, so the error
> is difficult to ignore. Considering proactive reclaim is usually low
> frequency, handle the batching into smaller chunks is a better approach.
> 
> Signed-off-by: Efly Young <yangyifei03@kuaishou.com>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Hey, I didn't write the patch, you did :) Please change it to

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>

You can also add

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

[quoting remainder for new CCs]

> ---
>  mm/memcontrol.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 4b27e24..d36cf88 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6741,8 +6741,8 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
>  			lru_add_drain_all();
>  
>  		reclaimed = try_to_free_mem_cgroup_pages(memcg,
> -						nr_to_reclaim - nr_reclaimed,
> -						GFP_KERNEL, reclaim_options);
> +					min(nr_to_reclaim - nr_reclaimed, SWAP_CLUSTER_MAX),
> +					GFP_KERNEL, reclaim_options);
>  
>  		if (!reclaimed && !nr_retries--)
>  			return -EAGAIN;
> -- 
> 1.8.3.1

