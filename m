Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704A45B12A6
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 04:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiIHCrx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 22:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiIHCrw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 22:47:52 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF726CF79
        for <bpf@vger.kernel.org>; Wed,  7 Sep 2022 19:47:51 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id y15so1291758ilq.4
        for <bpf@vger.kernel.org>; Wed, 07 Sep 2022 19:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=F0V3Q69Dfh9U3idCQ5zoaJWqNyDIbFU9SJAjb82VWQ4=;
        b=GSXT+BDrEIkHdygtut3Q3XfmCHdfl3lGdk8Yx4BY059SgNwI7QJEgrtHA80A4jsKQL
         56tZ2c75Ie43VpAnUJW3qpqPxvfK7Hko5nOzEivcEw0jnJ1s7+yrdsrHx61jNIVMWrm/
         PqNA6Ws8APgHrOk9Ke2Z77UXMeAWmyltRD1fniP7t4wfCmTIHPMhS91hA+vbEjlgmgaC
         a+zMiGbePkX/nFmyttjKcFXD/bw0Msp+1SWCeDh+7l/XTz+zKvwe2IWTnyG6Y/AhXV0h
         Tl7bdLrfzsMrLgVYI0cWgJQS6Zn5E48AsH2RQMd4tDGLU5v8tR3WsS0yQ5cThyPUX4jD
         ho0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=F0V3Q69Dfh9U3idCQ5zoaJWqNyDIbFU9SJAjb82VWQ4=;
        b=GoE7anMlh3sTpOBK1vwttNTFoBSjg5RFbuqmVKCFNfsbQcaS6VlYXZM3uWXahcb9Om
         i7pHFzB/69G0bxiGXNpAGLGB2kQqoT272aPR8yCc69fI347UniP4wIUG3onpiXeA/4gL
         W4/Iks4vixdpzjsh0oI1U7uZfnv3bMwjKYW2RY2MKPAcInfEy7VQLBfFrcnKLc90mwUm
         DbPQ++azo7zvUmlsri0VkOUOdCWC2MuZTnsjfpDPM2Fa2fy/Nbif/N6YrfCFa5f6CX1E
         5EpbyfpInQhRxv5UaRfYma7D13wCMt4NcFTIAG7asxtIxW1IDVdsBtLwcdPt7NYonXTa
         vpvg==
X-Gm-Message-State: ACgBeo1RWperUSfqepBOoxtfQ/u/98giF3f0haYDv1byljBN3CSBqOel
        NYAoCfR87FWktOwdHU5cJWSZ0jRRdiztSct8r9c=
X-Google-Smtp-Source: AA6agR64GhT8jsrsnH3ChJvKjIx7mChyuu85wc6hM51rDmKliO08c9TljNc8YYyWCD41ptOF0JfEmaO7Yt+8jiU83yI=
X-Received: by 2002:a05:6e02:170f:b0:2f1:6cdf:6f32 with SMTP id
 u15-20020a056e02170f00b002f16cdf6f32mr778867ill.216.1662605270945; Wed, 07
 Sep 2022 19:47:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220904204145.3089-1-memxor@gmail.com> <20220904204145.3089-6-memxor@gmail.com>
 <20220907190023.x6syddvu2xgxb47d@MacBook-Pro-4.local>
In-Reply-To: <20220907190023.x6syddvu2xgxb47d@MacBook-Pro-4.local>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Thu, 8 Sep 2022 04:47:15 +0200
Message-ID: <CAP01T75UoRUpvR6HsF8B4n0YiiRT91BNp5aVzp=5XPERYhoDsg@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v1 05/32] bpf: Support kptrs in local storage maps
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 7 Sept 2022 at 21:00, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sun, Sep 04, 2022 at 10:41:18PM +0200, Kumar Kartikeya Dwivedi wrote:
> > Enable support for kptrs in local storage maps by wiring up the freeing
> > of these kptrs from map value.
> >
> > Cc: Martin KaFai Lau <kafai@fb.com>
> > Cc: KP Singh <kpsingh@kernel.org>
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  include/linux/bpf_local_storage.h |  2 +-
> >  kernel/bpf/bpf_local_storage.c    | 33 +++++++++++++++++++++++++++----
> >  kernel/bpf/syscall.c              |  5 ++++-
> >  kernel/bpf/verifier.c             |  9 ++++++---
> >  4 files changed, 40 insertions(+), 9 deletions(-)
> >
> > diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
> > index 7ea18d4da84b..6786d00f004e 100644
> > --- a/include/linux/bpf_local_storage.h
> > +++ b/include/linux/bpf_local_storage.h
> > @@ -74,7 +74,7 @@ struct bpf_local_storage_elem {
> >       struct hlist_node snode;        /* Linked to bpf_local_storage */
> >       struct bpf_local_storage __rcu *local_storage;
> >       struct rcu_head rcu;
> > -     /* 8 bytes hole */
> > +     struct bpf_map *map;            /* Only set for bpf_selem_free_rcu */
> >       /* The data is stored in another cacheline to minimize
> >        * the number of cachelines access during a cache hit.
> >        */
> > diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
> > index 802fc15b0d73..4a725379d761 100644
> > --- a/kernel/bpf/bpf_local_storage.c
> > +++ b/kernel/bpf/bpf_local_storage.c
> > @@ -74,7 +74,8 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
> >                               gfp_flags | __GFP_NOWARN);
> >       if (selem) {
> >               if (value)
> > -                     memcpy(SDATA(selem)->data, value, smap->map.value_size);
> > +                     copy_map_value(&smap->map, SDATA(selem)->data, value);
> > +             /* No call to check_and_init_map_value as memory is zero init */
> >               return selem;
> >       }
> >
> > @@ -92,12 +93,27 @@ void bpf_local_storage_free_rcu(struct rcu_head *rcu)
> >       kfree_rcu(local_storage, rcu);
> >  }
> >
> > +static void check_and_free_fields(struct bpf_local_storage_elem *selem)
> > +{
> > +     if (map_value_has_kptrs(selem->map))
> > +             bpf_map_free_kptrs(selem->map, SDATA(selem));
> > +}
> > +
> >  static void bpf_selem_free_rcu(struct rcu_head *rcu)
> >  {
> >       struct bpf_local_storage_elem *selem;
> >
> >       selem = container_of(rcu, struct bpf_local_storage_elem, rcu);
> > -     kfree_rcu(selem, rcu);
> > +     check_and_free_fields(selem);
> > +     kfree(selem);
> > +}
> > +
> > +static void bpf_selem_free_tasks_trace_rcu(struct rcu_head *rcu)
> > +{
> > +     struct bpf_local_storage_elem *selem;
> > +
> > +     selem = container_of(rcu, struct bpf_local_storage_elem, rcu);
> > +     call_rcu(&selem->rcu, bpf_selem_free_rcu);
> >  }
> >
> >  /* local_storage->lock must be held and selem->local_storage == local_storage.
> > @@ -150,10 +166,11 @@ bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_storage,
> >           SDATA(selem))
> >               RCU_INIT_POINTER(local_storage->cache[smap->cache_idx], NULL);
> >
> > +     selem->map = &smap->map;
> >       if (use_trace_rcu)
> > -             call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_rcu);
> > +             call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_tasks_trace_rcu);
> >       else
> > -             kfree_rcu(selem, rcu);
> > +             call_rcu(&selem->rcu, bpf_selem_free_rcu);
> >
> >       return free_local_storage;
> >  }
> > @@ -581,6 +598,14 @@ void bpf_local_storage_map_free(struct bpf_local_storage_map *smap,
> >        */
> >       synchronize_rcu();
> >
> > +     /* When local storage map has kptrs, the call_rcu callback accesses
> > +      * kptr_off_tab, hence we need the bpf_selem_free_rcu callbacks to
> > +      * finish before we free it.
> > +      */
> > +     if (map_value_has_kptrs(&smap->map)) {
> > +             rcu_barrier();
> > +             bpf_map_free_kptr_off_tab(&smap->map);
>
> probably needs conditional rcu_barrier_tasks_trace before rcu_barrier?
> With or without it will be a significant delay in map freeing.
> Maybe we should generalize the destroy_mem_alloc trick?
>

Yes, let me take a closer look tomorrow and ask questions if any.
Otherwise I will rework it. Thanks for catching this.

> Patch 4 needs rebase. Applied patches 1-3.
> The first 5 look great to me.
> Pls follow up with kptr specific tests.

Thanks, I will split those out into another series with its own test.
