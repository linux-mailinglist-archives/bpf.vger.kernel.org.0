Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5CF6A5199
	for <lists+bpf@lfdr.de>; Tue, 28 Feb 2023 04:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjB1DES (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 22:04:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjB1DER (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 22:04:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D34EF90
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 19:04:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C88CB80CA7
        for <bpf@vger.kernel.org>; Tue, 28 Feb 2023 03:04:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1FD9C4339E
        for <bpf@vger.kernel.org>; Tue, 28 Feb 2023 03:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677553452;
        bh=bvonhwo7EaTwwWiZSgKl/TZR0LAT6mIFDxWSW4+TUss=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Cx90qdeqY628VWt45GIsg7WDrAsNDRUPx/5pmf9JeWSUiawSqs9SI0mXwMLPbLHly
         Y5N3RSUzUW414I0Ggc7UyXaZvoKMfgtZywmNkZXLBx5+YV3xOEihOx9pXYBHcCj+Ab
         i48wPTo8RpnR3cVcTrPoLfuMm7Z0ldjMd+cd+H6rjNuq7IfzjlCwfYb+E2tUcVNAuW
         GQ3hom+Ev6UoJwB8wFYi3TbOf0XScVC026dHQC8iKbRSKfoWDNuS6c/tcpj2RvtqRa
         nNLK8prPe2J2/flQa6xc8/PmbMB7bjA6i59/OqeXp7d4cR3Ym0+Kh7obLsTFYYgt25
         KDN40GlnrYcUQ==
Received: by mail-ed1-f46.google.com with SMTP id cq23so34376467edb.1
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 19:04:11 -0800 (PST)
X-Gm-Message-State: AO0yUKU2JnIM9IioJjydRZQjkdP0iJAudAAuC2Gp5Dh6z4F7HYRwjLW/
        JrReB+hmdt6f735mgXRwuqLt1vpNbPc1XpTmlRSdeQ==
X-Google-Smtp-Source: AK7set+zN8Ha7pNEme0V2ud4VryPCrvA3iI2Yz3aXuzEOQoGjxTG/Z9M0e4g6cBfnD7eCaQnbRro8rszBBUP227KG1E=
X-Received: by 2002:a17:906:5f97:b0:8b0:7e1d:f6fa with SMTP id
 a23-20020a1709065f9700b008b07e1df6famr416081eju.15.1677553450135; Mon, 27 Feb
 2023 19:04:10 -0800 (PST)
MIME-Version: 1.0
References: <20230225154010.391965-1-memxor@gmail.com> <20230225154010.391965-3-memxor@gmail.com>
 <86a26e3d-08fc-cee5-68f0-8000b490a9f0@linux.dev>
In-Reply-To: <86a26e3d-08fc-cee5-68f0-8000b490a9f0@linux.dev>
From:   KP Singh <kpsingh@kernel.org>
Date:   Tue, 28 Feb 2023 04:03:59 +0100
X-Gmail-Original-Message-ID: <CACYkzJ7XBa1B03GRW1f61dmaadh9Z1sR8t9Qvf47s5jVgtwmXQ@mail.gmail.com>
Message-ID: <CACYkzJ7XBa1B03GRW1f61dmaadh9Z1sR8t9Qvf47s5jVgtwmXQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/3] bpf: Support kptrs in local storage maps
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        David Vernet <void@manifault.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 27, 2023 at 10:16=E2=80=AFPM Martin KaFai Lau <martin.lau@linux=
.dev> wrote:
>
> On 2/25/23 7:40 AM, Kumar Kartikeya Dwivedi wrote:
> > Enable support for kptrs in local storage maps by wiring up the freeing
> > of these kptrs from map value. Freeing of bpf_local_storage_map is only

from a map value.

> > delayed in case there are special fields, therefore bpf_selem_free_*

This needs a bit of explanation here, can you add a bit more
description in this commit's log as to what these special fields are?
It would be great if the commit descriptions are hermetic and self
explanatory.

> > path can also only dereference smap safely in that case. This is
> > recorded using a bool utilizing a hole in bpF_local_storage_elem. It

nit: bpf_local_storage_elem

> > could have been tagged in the pointer value smap using the lowest bit
> > (since alignment > 1), but since there was already a hole I went with
> > the simpler option. Only the map structure freeing is delayed using RCU
> > barriers, as the buckets aren't used when selem is being freed, so they
> > can be freed once all readers of the bucket lists can no longer access
> > it.
> >
> > Cc: Martin KaFai Lau <martin.lau@kernel.org>
> > Cc: KP Singh <kpsingh@kernel.org>
> > Cc: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >   include/linux/bpf_local_storage.h |  6 ++++
> >   kernel/bpf/bpf_local_storage.c    | 48 ++++++++++++++++++++++++++++--=
-
> >   kernel/bpf/syscall.c              |  6 +++-
> >   kernel/bpf/verifier.c             | 12 +++++---
> >   4 files changed, 63 insertions(+), 9 deletions(-)
> >
> > diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_loca=
l_storage.h
> > index 6d37a40cd90e..0fe92986412b 100644
> > --- a/include/linux/bpf_local_storage.h
> > +++ b/include/linux/bpf_local_storage.h
> > @@ -74,6 +74,12 @@ struct bpf_local_storage_elem {
> >       struct hlist_node snode;        /* Linked to bpf_local_storage */
> >       struct bpf_local_storage __rcu *local_storage;
> >       struct rcu_head rcu;
> > +     bool can_use_smap; /* Is it safe to access smap in bpf_selem_free=
_* RCU
> > +                         * callbacks? bpf_local_storage_map_free only
> > +                         * executes rcu_barrier when there are special
> > +                         * fields, this field remembers that to ensure=
 we
> > +                         * don't access already freed smap in sdata.
> > +                         */
> >       /* 8 bytes hole */
> >       /* The data is stored in another cacheline to minimize
> >        * the number of cachelines access during a cache hit.
> > diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_stor=
age.c
> > index 58da17ae5124..2bdd722fe293 100644
> > --- a/kernel/bpf/bpf_local_storage.c
> > +++ b/kernel/bpf/bpf_local_storage.c
> > @@ -85,6 +85,7 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, v=
oid *owner,
> >       if (selem) {
> >               if (value)
> >                       copy_map_value(&smap->map, SDATA(selem)->data, va=
lue);
> > +             /* No need to call check_and_init_map_value as memory is =
zero init */
> >               return selem;
> >       }
> >
> > @@ -113,10 +114,25 @@ static void bpf_selem_free_rcu(struct rcu_head *r=
cu)
> >       struct bpf_local_storage_elem *selem;
> >
> >       selem =3D container_of(rcu, struct bpf_local_storage_elem, rcu);
> > +     /* The can_use_smap bool is set whenever we need to free addition=
al
> > +      * fields in selem data before freeing selem. bpf_local_storage_m=
ap_free
> > +      * only executes rcu_barrier to wait for RCU callbacks when it ha=
s
> > +      * special fields, hence we can only conditionally dereference sm=
ap, as
> > +      * by this time the map might have already been freed without wai=
ting
> > +      * for our call_rcu callback if it did not have any special field=
s.
> > +      */
> > +     if (selem->can_use_smap)
> > +             bpf_obj_free_fields(SDATA(selem)->smap->map.record, SDATA=
(selem)->data);
> > +     kfree(selem);
> > +}
> > +
> > +static void bpf_selem_free_tasks_trace_rcu(struct rcu_head *rcu)
> nit. May be a shorter name, bpf_selem_free_rcu_trace() ?
>
> > +{
> > +     /* Free directly if Tasks Trace RCU GP also implies RCU GP */
> >       if (rcu_trace_implies_rcu_gp())
> > -             kfree(selem);
> > +             bpf_selem_free_rcu(rcu);
> >       else
> > -             kfree_rcu(selem, rcu);
> > +             call_rcu(rcu, bpf_selem_free_rcu);
> >   }
> >
> >   /* local_storage->lock must be held and selem->local_storage =3D=3D l=
ocal_storage.
> > @@ -170,9 +186,9 @@ static bool bpf_selem_unlink_storage_nolock(struct =
bpf_local_storage *local_stor
> >               RCU_INIT_POINTER(local_storage->cache[smap->cache_idx], N=
ULL);
> >
> >       if (use_trace_rcu)
> > -             call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_rcu);
> > +             call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_tasks_tr=
ace_rcu);
> >       else
> > -             kfree_rcu(selem, rcu);
> > +             call_rcu(&selem->rcu, bpf_selem_free_rcu);
>
> Instead of adding 'bool can_use_smap' to 'struct bpf_local_storage_elem',=
 can it
> be a different rcu call back when smap->map.record is not NULL and only t=
hat new
> rcu call back can use smap?
> I have a use on this 8-byte hole when using bpf_mem_alloc in bpf_local_st=
orage.
>
> >
> >       return free_local_storage;
> >   }
> > @@ -240,6 +256,11 @@ void bpf_selem_link_map(struct bpf_local_storage_m=
ap *smap,
> >       RCU_INIT_POINTER(SDATA(selem)->smap, smap);
> >       hlist_add_head_rcu(&selem->map_node, &b->list);
> >       raw_spin_unlock_irqrestore(&b->lock, flags);
> > +
> > +     /* If our data will have special fields, smap will wait for us to=
 use
> > +      * its record in bpf_selem_free_* RCU callbacks before freeing it=
self.
> > +      */
> > +     selem->can_use_smap =3D !IS_ERR_OR_NULL(smap->map.record);
> >   }
> >
> >   void bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool use_=
trace_rcu)
> > @@ -723,6 +744,25 @@ void bpf_local_storage_map_free(struct bpf_map *ma=
p,
> >        */
> >       synchronize_rcu();
> >
> > +     /* Only delay freeing of smap, buckets are not needed anymore */
> >       kvfree(smap->buckets);
> > +
> > +     /* When local storage has special fields, callbacks for
> > +      * bpf_selem_free_rcu and bpf_selem_free_tasks_trace_rcu will kee=
p using
> > +      * the map BTF record, we need to execute an RCU barrier to wait =
for
> > +      * them as the record will be freed right after our map_free call=
back.
> > +      */
> > +     if (!IS_ERR_OR_NULL(smap->map.record)) {
> > +             rcu_barrier_tasks_trace();
> > +             /* We cannot skip rcu_barrier() when rcu_trace_implies_rc=
u_gp()
> > +              * is true, because while call_rcu invocation is skipped =
in that
> > +              * case in bpf_selem_free_tasks_trace_rcu (and all local =
storage
> > +              * maps pass use_trace_rcu =3D true), there can be call_r=
cu
> > +              * callbacks based on use_trace_rcu =3D false in the earl=
ier while
> > +              * ((selem =3D ...)) loop or from bpf_local_storage_unlin=
k_nolock
> > +              * called from owner's free path.
> > +              */
> > +             rcu_barrier();
>
> Others lgtm.

+1

>
