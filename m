Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194866CFD35
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 09:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjC3How (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 03:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjC3Hou (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 03:44:50 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F15FA
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 00:44:48 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id r11so72988682edd.5
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 00:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680162287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=28SBvYRFwm/SwjBANXWTAMmx79zC2hxmQLZYCOkhW7w=;
        b=XC/JQkgUrkQzY6HHF2NhZnpoRWT+0wS9HXMuIuwQTp9rKch4Ytd7OHq7B6ZlYzmoIN
         Xe41PjKT72i8B3/cXTSXEg1IQnDraLRQMJMHYetoWWGjFqE2CxvPrvXHNDWgl87bYMsh
         WdwVVICevoPuzBNIHuJDvQJT1mrphxjAYc2j6LK0KPxJhcnJrlmseiUrxuyv1lwNRTJp
         +FSGoMUedD4yHquuhjfw7Y6nZWzvHcf/ctNL4xVIvIW4rnVlbcVv+Of3qtdTGXL9EZos
         GIk26f60XOLEveR9GlABACeWhYk6kSbAGJ2+4SHw417+h1IQRhKDpuqZ5Zdtzx5YFgxE
         fTzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680162287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=28SBvYRFwm/SwjBANXWTAMmx79zC2hxmQLZYCOkhW7w=;
        b=imNNTC7iOGZlH8AyTP48mK3uuyN1iOcc9zbYZ1AiPzaXacMLCr4EFgHRj3w+yoPZ7V
         EmDDL2hg31b9nQhmsDzSXBAad43WMpSJB0kV4DV3bERZVNmqpQlS2KWIc0GjKUlV1o88
         QjIZqDrla/CxjDpr5dt0yAwL21TVdQUUWbwljnk/wS5fwh1Kc+KgEHW0NjbxGg/lfTNH
         iQ0lenIB6YdL6tM1c/o84sV+/j1fqYAXL+PwsQn/oTwFmAi55Mz1KmgBfG+X85HJR+NG
         D5XPYe8u8JXBCnIijiExwOnKbryr9vRRV6oxsN/l9Na2EBrXF4dZ05MfSF1o3bNgaU+S
         c+4g==
X-Gm-Message-State: AAQBX9fdXI0kerJ3AaQO6GWPcwEfFNXSejO6Fz+jnFrDbcGiVRgxj9E7
        vwuWYyjSom+VvB+qJIzBUhKyumbGZI2c9SBcfvyx1w==
X-Google-Smtp-Source: AKy350Z2KiVhFd/82j7EL2NLG85NtAr3M5UdBgwY+5zjpWCG5Fmbo31OIzhdc+eigDSu41dkZqEu1wLkOLOe8mIznuc=
X-Received: by 2002:a17:906:a86:b0:933:f6e8:26d9 with SMTP id
 y6-20020a1709060a8600b00933f6e826d9mr11660266ejf.15.1680162286676; Thu, 30
 Mar 2023 00:44:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230328221644.803272-1-yosryahmed@google.com>
 <20230328221644.803272-9-yosryahmed@google.com> <ZCU9ByZybEi5G5sl@dhcp22.suse.cz>
In-Reply-To: <ZCU9ByZybEi5G5sl@dhcp22.suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 30 Mar 2023 00:44:10 -0700
Message-ID: <CAJD7tkZODvLZOfGaO3gjC2udKNg_G0mA2CT57djjJXrrHNEbbg@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] vmscan: memcg: sleep when flushing stats during reclaim
To:     Michal Hocko <mhocko@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
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

On Thu, Mar 30, 2023 at 12:40=E2=80=AFAM Michal Hocko <mhocko@suse.com> wro=
te:
>
> On Tue 28-03-23 22:16:43, Yosry Ahmed wrote:
> > Memory reclaim is a sleepable context. Allow sleeping when flushing
> > memcg stats to avoid unnecessarily performing a lot of work without
> > sleeping. This can slow down reclaim code if flushing stats is taking
> > too long, but there is already multiple cond_resched()'s in reclaim
> > code.
>
> Why is this preferred? Memory reclaim is surely a slow path but what is
> the advantage of calling mem_cgroup_flush_stats here?

The purpose of this series is to limit calls to atomic flushing as
much as possible, as flushing can become really expensive on systems
with high cpu counts and a lot of cgroups, and performing such an
expensive operation atomically causes problems -- so we'd rather avoid
doing it atomically where possible.

>
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > Acked-by: Shakeel Butt <shakeelb@google.com>
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > ---
> >  mm/vmscan.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index a9511ccb936f..9c1c5e8b24b8 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -2845,7 +2845,7 @@ static void prepare_scan_count(pg_data_t *pgdat, =
struct scan_control *sc)
> >        * Flush the memory cgroup stats, so that we read accurate per-me=
mcg
> >        * lruvec stats for heuristics.
> >        */
> > -     mem_cgroup_flush_stats_atomic();
> > +     mem_cgroup_flush_stats();
> >
> >       /*
> >        * Determine the scan balance between anon and file LRUs.
> > --
> > 2.40.0.348.gf938b09366-goog
>
> --
> Michal Hocko
> SUSE Labs
