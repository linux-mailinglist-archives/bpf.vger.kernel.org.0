Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFCAD6CC0B3
	for <lists+bpf@lfdr.de>; Tue, 28 Mar 2023 15:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbjC1NZl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Mar 2023 09:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbjC1NZf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Mar 2023 09:25:35 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BB5BBAD
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 06:25:25 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-545e907790fso113475347b3.3
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 06:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680009924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aKr9MaZxGZc9u8ZhIE9so1jdgqHxAOgc8JTrWbL9sqY=;
        b=i9jvfdCeB9SsJnyBiAbhdPLhoxjsfRopr7eARS5rGyPO0aOs26naUPy0TOlNDXReWF
         R5Ea79kbAr+glBAXFOfEsjm49+Nm5fB3G3LIqw9DO4pIhWqBfQICEKbBtdAas72TZMRa
         2naeIrUIfdDmFPzU0ieyV8VHQOarplR5OZFhsLhdFTJ17Qsili22215RkxE3w61P7NqR
         QN1VePuwazlq07Mx1/r+u1FhPyrqxDDF2mBmsHwUrqWufwHsPj0sdlguYWltwhWjNVjP
         5VKvQ0LXJosLvebPB+Yu1xwBQd5x8bAJlaPp08d3BXWvpGTaWuuE3u78gHSrMcThnKrJ
         Ve5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680009924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aKr9MaZxGZc9u8ZhIE9so1jdgqHxAOgc8JTrWbL9sqY=;
        b=gdQyjVrtUImLi4PWRw+GCKeSwgd7csCh9eV9yC6bNwy8QnciJFE4iE8xjQEUlhFgaM
         VDRYD3PdNwk9eRA+HZOXSK0c6/YrAfFTXVFn+Hu/N5IU/wyVpSBPrwPyvhBRxPz7eze1
         CQroaw9gADkbTsWx0oaqXGeyBMEeHeE7EIJlcaglZD6LyGMIXm2dlgb9Lb6f+Ar8Jb4s
         PE50LoCactUNdO+TvEX8b0poV6tRlMnzpfSh+CJ/R9gZMNWMsjbcDrRwhIwzVbHPpvUT
         KW08lEKNqc/xCO/Dkti8PFOTunxIjT4Qz54Lc49i00OKEhvCzR0egY6U6sXgHqaduMJs
         7LRw==
X-Gm-Message-State: AAQBX9cojn0L85z5QkX2bkXLhOBQl1GO5jtO/kaSrx0nrKcxf8ICeo5J
        S55Kt12RAgGk9iLMPW8C4PWqxpcrXeVyEe/MwotRag==
X-Google-Smtp-Source: AKy350ZqnYLSmT7eJTq65fiNra/60hMVxVRo2NTN5O7ip/pdM6ESKQ/7QeIH3HPcBu0i1k4EPDQhyQj9uL9p9e2MRY0=
X-Received: by 2002:a81:e546:0:b0:546:1ef:54f9 with SMTP id
 c6-20020a81e546000000b0054601ef54f9mr2180958ywm.0.1680009924474; Tue, 28 Mar
 2023 06:25:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230328061638.203420-1-yosryahmed@google.com> <20230328061638.203420-3-yosryahmed@google.com>
In-Reply-To: <20230328061638.203420-3-yosryahmed@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 28 Mar 2023 06:25:13 -0700
Message-ID: <CALvZod50Kh602rFii_=8q+_xdZTqHfDJyc_XNNTixGTqgcSDHA@mail.gmail.com>
Subject: Re: [PATCH v1 2/9] memcg: rename mem_cgroup_flush_stats_"delayed" to "ratelimited"
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 27, 2023 at 11:16=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> mem_cgroup_flush_stats_delayed() suggests his is using a delayed_work,
> but this is actually sometimes flushing directly from the callsite.
>
> What it's doing is ratelimited calls. A better name would be
> mem_cgroup_flush_stats_ratelimited().
>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Acked-by: Shakeel Butt <shakeelb@google.com>
