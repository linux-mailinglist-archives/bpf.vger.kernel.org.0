Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601AD6CFD73
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 09:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjC3Hzb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 03:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjC3Hz3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 03:55:29 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E388E1FCC
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 00:55:27 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id eg48so72969221edb.13
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 00:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680162926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h5tWbYU5Ovnx4S3KN05HeMF9MQhwKdT4wgU3e8coEAg=;
        b=CKaS6HBjsJ/8/OyRJWU/IIHaTdpRU7TNj95drpPAb7CtZThIyxrmIWaKZBQn/DOv1x
         emhAGX3xKn00R3oNM398Sr3mFprCDzivxLy/znSI9eeZ/pw66A9v0YN2EzQHfVXPhVjT
         kr1ryivtAD/0r4jpzHjJcrTKWfcPbeOSknV8seiKFhrH5h5lOG/fO0KWYH8a0bsfaa6/
         abESZ4KxjVvzKKoqo8bXx7oOROI+V6YSOSpV0NkUGo8ySqAW2y434yfj/hHDPQ5dk0/W
         XFpZ/ourVOgMxr/4/82xPsTUlLwmkDP5dfTF9DFoz5VWWBMKyueXFRzWysnxkVKprxJs
         wttQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680162926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h5tWbYU5Ovnx4S3KN05HeMF9MQhwKdT4wgU3e8coEAg=;
        b=LISMLg3AAQbhpClcg1C8JDTT+3Jln7tp1qyFtKNcpw1ZQRRQWqId25No3hiAVX3O4v
         IAnQAVmBSRbcZzvPeRkMTIQ/U5ZvvBIcjkaWUX8LO7UJbk08X9AT6GsEkmUiRctrTaB7
         SZA38kOIlcc1271Yka62Bf22TfqrZQSWh3i0Qls1fYYu3VFyJRdA13B8Nd9LbA5k5adm
         GF0IQt+vVsmDSFsAnyfsM74Wm/mgcUq6G9c/oESERprG5bvDTUdykg1eITHKy5Q14/Ms
         EdwPGdtrSzivdasLF1gsXGZOPs2VvGjtdbl7CcZdYGft06kGGBRgSJJaodoCoOk2EFvG
         dsnQ==
X-Gm-Message-State: AAQBX9c7s5baq45PlS8LF2xPggn4GfAOWj9BrlMX1g7+Zaybvg/T8d/8
        w+66o+gXiTNBYIwBAbFQXbAu9yUuxD83eQwF818XIA==
X-Google-Smtp-Source: AKy350YcqInxIQbykpj1GeKom6UlRjlcV90pMLr2lDnaE4i3kospZjU3y3SUnkTdHfIThJQbVclsZcWhGBL8uWlbtw8=
X-Received: by 2002:a17:906:2a15:b0:933:7658:8b44 with SMTP id
 j21-20020a1709062a1500b0093376588b44mr9941916eje.15.1680162926191; Thu, 30
 Mar 2023 00:55:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230328221644.803272-1-yosryahmed@google.com>
 <20230328221644.803272-9-yosryahmed@google.com> <ZCU9ByZybEi5G5sl@dhcp22.suse.cz>
 <CAJD7tkZODvLZOfGaO3gjC2udKNg_G0mA2CT57djjJXrrHNEbbg@mail.gmail.com> <ZCU/zzgWSZb/ux6J@dhcp22.suse.cz>
In-Reply-To: <ZCU/zzgWSZb/ux6J@dhcp22.suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 30 Mar 2023 00:54:49 -0700
Message-ID: <CAJD7tkaCK6e3a-T_5z3Ea3OFwiJjHoUfrEPGDW-wqduOr-5pVg@mail.gmail.com>
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

On Thu, Mar 30, 2023 at 12:52=E2=80=AFAM Michal Hocko <mhocko@suse.com> wro=
te:
>
> On Thu 30-03-23 00:44:10, Yosry Ahmed wrote:
> > On Thu, Mar 30, 2023 at 12:40=E2=80=AFAM Michal Hocko <mhocko@suse.com>=
 wrote:
> > >
> > > On Tue 28-03-23 22:16:43, Yosry Ahmed wrote:
> > > > Memory reclaim is a sleepable context. Allow sleeping when flushing
> > > > memcg stats to avoid unnecessarily performing a lot of work without
> > > > sleeping. This can slow down reclaim code if flushing stats is taki=
ng
> > > > too long, but there is already multiple cond_resched()'s in reclaim
> > > > code.
> > >
> > > Why is this preferred? Memory reclaim is surely a slow path but what =
is
> > > the advantage of calling mem_cgroup_flush_stats here?
> >
> > The purpose of this series is to limit calls to atomic flushing as
> > much as possible, as flushing can become really expensive on systems
> > with high cpu counts and a lot of cgroups, and performing such an
> > expensive operation atomically causes problems -- so we'd rather avoid
> > doing it atomically where possible.
>
> Please add that to the changelog. While the intention might be obvious
> now (although cover is not explicit about it either) it can cause some
> head scratching in the future when somebody looks at this commit without
> a broader context (e.g. previous ML discussions).
>
> with that
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks, will do for the respin.

> Thanks
>
> > > > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > > > Acked-by: Shakeel Butt <shakeelb@google.com>
> > > > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > > > ---
> > > >  mm/vmscan.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > > index a9511ccb936f..9c1c5e8b24b8 100644
> > > > --- a/mm/vmscan.c
> > > > +++ b/mm/vmscan.c
> > > > @@ -2845,7 +2845,7 @@ static void prepare_scan_count(pg_data_t *pgd=
at, struct scan_control *sc)
> > > >        * Flush the memory cgroup stats, so that we read accurate pe=
r-memcg
> > > >        * lruvec stats for heuristics.
> > > >        */
> > > > -     mem_cgroup_flush_stats_atomic();
> > > > +     mem_cgroup_flush_stats();
> > > >
> > > >       /*
> > > >        * Determine the scan balance between anon and file LRUs.
> > > > --
> > > > 2.40.0.348.gf938b09366-goog
> > >
> > > --
> > > Michal Hocko
> > > SUSE Labs
>
> --
> Michal Hocko
> SUSE Labs
