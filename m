Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809846CC60E
	for <lists+bpf@lfdr.de>; Tue, 28 Mar 2023 17:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbjC1PWS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Mar 2023 11:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbjC1PV5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Mar 2023 11:21:57 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1C2EFAF
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 08:20:19 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-53d277c1834so235877687b3.10
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 08:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680016784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZcS8n/4+59b+VXd6eXMn877oxhRuuiSj8mRyLdeW/tM=;
        b=Ar4Zra7am34XuPMhOvIUcA5xD0kVon3c99ACx4qVdYKc7PvMpeZbPc7LV4yiktxx93
         ugQcjwZKj3vROoqeRauJSOBpb/R7U0idQKpJU7syI6uOUqxt1iBIF8l4r9F7EviaUoDi
         5eGZKwhRwKRZxVY+kApK4O0HT7InuJX8mw3M0HfrCXDYjBj5bNd8FOTKy3yI06ZWgwjO
         HPR0Gz42df+GFqUpBoW8UGumfJGgpC4TxJYcxJ2J6DfmavIUYu4J0xle/MsU2yYWX7OR
         ESI5YObo7wWB9KiZs8NeKzMtj5Q2PHwXIhtBG2Qb1iBMLwwQvMGYO3D8HHRZ3Q70iOfB
         d1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680016784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZcS8n/4+59b+VXd6eXMn877oxhRuuiSj8mRyLdeW/tM=;
        b=1cj0ammqgZm+Eo54IcOP+ScF7g6UxsdGI1HDMf9ZdDvh2nhn42/Y0FqDZwoAjk6HCs
         NkmxjEjSfU8V6+fLUr4wrgeyNml+avsboU0Afp/MGiNW8/ffDqUIf7P3hHKpO/tEOsJT
         5l7ph+uvJjJleR58DIwTAyi76f6zkl+D7DNYPJADlpB+QJhQ7zLfg2x+KNI2I6mPhRqw
         WbapBkJw1QOHX6RyXEEkmAwiBUhosT5ARcUNsB4pWKzEQo9NyyBQaFcviMym8tt1rJVF
         oxC3gk++DxQ7/jjuzG5ZdZngw4ZJJjb3rjzyhGQlJRbw/yS9bVFidYIGrDGldxm69BxY
         FK+g==
X-Gm-Message-State: AAQBX9dtzMXe+G4yfH5pcpNwnR0earXLWvLeTZQ+UXvIKK6PoVvxdEqd
        nLTeup0vw9Buc3GanPxpoQQWHBYmf28yCMkC5v7Tyg==
X-Google-Smtp-Source: AKy350Z9cmGM4H/7sFJEBekvmzlUQ1sUU694LWzJhS2SSks5o5zMh8yAhNT3YmusP5qBVLKJW5eonGGOovifhFPxfcU=
X-Received: by 2002:a81:4406:0:b0:546:63a:6e23 with SMTP id
 r6-20020a814406000000b00546063a6e23mr2281889ywa.0.1680016784433; Tue, 28 Mar
 2023 08:19:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230328061638.203420-1-yosryahmed@google.com> <20230328061638.203420-9-yosryahmed@google.com>
In-Reply-To: <20230328061638.203420-9-yosryahmed@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 28 Mar 2023 08:19:33 -0700
Message-ID: <CALvZod7wJ-e-dHEhMynquiqQWFU2j+05wUyUe_yv_rBqJLu2rw@mail.gmail.com>
Subject: Re: [PATCH v1 8/9] vmscan: memcg: sleep when flushing stats during reclaim
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
> Memory reclaim is a sleepable context. Allow sleeping when flushing
> memcg stats to avoid unnecessarily performing a lot of work without
> sleeping. This can slow down reclaim code if flushing stats is taking
> too long, but there is already multiple cond_resched()'s in reclaim
> code.
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Acked-by: Shakeel Butt <shakeelb@google.com>

> ---
>  mm/vmscan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index a9511ccb936f..9c1c5e8b24b8 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2845,7 +2845,7 @@ static void prepare_scan_count(pg_data_t *pgdat, st=
ruct scan_control *sc)
>          * Flush the memory cgroup stats, so that we read accurate per-me=
mcg
>          * lruvec stats for heuristics.
>          */
> -       mem_cgroup_flush_stats_atomic();
> +       mem_cgroup_flush_stats();

I wonder if we should just replace this with
mem_cgroup_flush_stats_ratelimited().
