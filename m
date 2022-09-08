Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525FE5B11A9
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 02:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiIHAzS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 20:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiIHAzR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 20:55:17 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E47F72FC4
        for <bpf@vger.kernel.org>; Wed,  7 Sep 2022 17:55:16 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id x1so11901866plv.5
        for <bpf@vger.kernel.org>; Wed, 07 Sep 2022 17:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=zagBQl2adnX5VZMOkat5zu/LCiPv311sTmjSHTIdD60=;
        b=U8lGaw6mlTLZpNuwL93yPETgdYauxNUDsBwvNnv4X3PA4Irt3mFrmHh/EgDzGOiMZW
         f8ZrbwOQFGXWyZn4GB9oR1bATtnPCZoboenBw6pe3PYi/xwhwazebyO1nbfIAoiVbdAF
         gTl155LPcUFb73eHXp1AuOu2nn+TZKJYKNA2SePZJ3ScPk+8DMlAgfKJFfwHnsODfRQP
         SkkyEx6kDxg64ja0iJGNP6hhLYPJlUSjx8gUtizdXQPYTK6cZr6LmUUtU+WLrz60sYz0
         CW7tiybt7NhGK/GJM68HZZu3EebZKCXV2nlCD0tzu+soMRXhMF+qalxVCdjmLO20wkmW
         ePWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=zagBQl2adnX5VZMOkat5zu/LCiPv311sTmjSHTIdD60=;
        b=d8SZ1odKCcSkm//rJYGKOzL/ORo5XWQt8zwBv/rvHDVCJK0cgZRo2aQ9phIQrmHHDJ
         0v8moEuK2nmKzecxu5MFi9uW6YIUDHMV7wuy3afM6KhbbXjK45x5QVCpOeYINtamCe34
         //Rg3mcuAwKn9TGAUywwbpL+E/BNR19isqMBsbQzLgtuzyRpl3hNfzokkIOR8aytQVGC
         bh+XdJu4KxzVjBk5a/xaox4ZW+44lo+vdkO+tuxpGJiGB/yMqUAYVvKQRl9hOt+I37T/
         YZuW5BtTNi/jLcMIJuPiSY/q/yuup72Gvs0YHAO+eBN0ZI55EYc0O6Mpe+BPVZE6l92S
         sfRQ==
X-Gm-Message-State: ACgBeo13x15P5kW8dr70oZM2FmWR5p3/IMu8CaaCC0Lqq7rEuDzb4WVg
        V9OIbEMe+ehZ7C4kiLkIMew=
X-Google-Smtp-Source: AA6agR4fTrxQXnX+RNSf2Cf6vLnoJgVy0sFZcABPh5AY+OBohdfpQJd/Z8qK0ag1NiMwYi4hLMlA+g==
X-Received: by 2002:a17:903:291:b0:172:f018:cdce with SMTP id j17-20020a170903029100b00172f018cdcemr6328397plr.91.1662598515548;
        Wed, 07 Sep 2022 17:55:15 -0700 (PDT)
Received: from macbook-pro-4.dhcp.thefacebook.com ([2620:10d:c090:400::5:66c4])
        by smtp.gmail.com with ESMTPSA id j14-20020a170902da8e00b0016ee328fd61sm13100855plx.198.2022.09.07.17.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 17:55:15 -0700 (PDT)
Date:   Wed, 7 Sep 2022 17:55:12 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Subject: Re: [PATCH RFC bpf-next v1 21/32] bpf: Allow locking bpf_spin_lock
 global variables
Message-ID: <20220908005512.ld66ck456g2v74tj@macbook-pro-4.dhcp.thefacebook.com>
References: <20220904204145.3089-1-memxor@gmail.com>
 <20220904204145.3089-22-memxor@gmail.com>
 <20220908002742.cqwwahxa5ktaik3r@macbook-pro-4.dhcp.thefacebook.com>
 <CAP01T75bEtRU4FC9ipqP+uQ_zo8qmOX=TkykzAb2bycN3f=xLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP01T75bEtRU4FC9ipqP+uQ_zo8qmOX=TkykzAb2bycN3f=xLg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 08, 2022 at 02:39:46AM +0200, Kumar Kartikeya Dwivedi wrote:
> On Thu, 8 Sept 2022 at 02:27, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Sun, Sep 04, 2022 at 10:41:34PM +0200, Kumar Kartikeya Dwivedi wrote:
> > > Global variables reside in maps accessible using direct_value_addr
> > > callbacks, so giving each load instruction's rewrite a unique reg->id
> > > disallows us from holding locks which are global.
> > >
> > > This is not great, so refactor the active_spin_lock into two separate
> > > fields, active_spin_lock_ptr and active_spin_lock_id, which is generic
> > > enough to allow it for global variables, map lookups, and local kptr
> > > registers at the same time.
> > >
> > > Held vs non-held is indicated by active_spin_lock_ptr, which stores the
> > > reg->map_ptr or reg->btf pointer of the register used for locking spin
> > > lock. But the active_spin_lock_id also needs to be compared to ensure
> > > whether bpf_spin_unlock is for the same register.
> > >
> > > Next, pseudo load instructions are not given a unique reg->id, as they
> > > are doing lookup for the same map value (max_entries is never greater
> > > than 1).
> > >
> > > Essentially, we consider that the tuple of (active_spin_lock_ptr,
> > > active_spin_lock_id) will always be unique for any kind of argument to
> > > bpf_spin_{lock,unlock}.
> > >
> > > Note that this can be extended in the future to also remember offset
> > > used for locking, so that we can introduce multiple bpf_spin_lock fields
> > > in the same allocation.
> > >
> > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > ---
> > >  include/linux/bpf_verifier.h |  3 ++-
> > >  kernel/bpf/verifier.c        | 39 +++++++++++++++++++++++++-----------
> > >  2 files changed, 29 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> > > index 2a9dcefca3b6..00c21ad6f61c 100644
> > > --- a/include/linux/bpf_verifier.h
> > > +++ b/include/linux/bpf_verifier.h
> > > @@ -348,7 +348,8 @@ struct bpf_verifier_state {
> > >       u32 branches;
> > >       u32 insn_idx;
> > >       u32 curframe;
> > > -     u32 active_spin_lock;
> > > +     void *active_spin_lock_ptr;
> > > +     u32 active_spin_lock_id;
> >
> > {map, id=0} is indeed enough to distinguish different global locks and
> > {map, id} for locks in map values,
> > but what 'btf' is for?
> > When is the case when reg->map_ptr is not set?
> > locks in allocated objects?
> > Feels too early to add that in this patch.
> >
> > Also this patch is heavily influenced by Dave's patch with
> > a realization that max_entries==1 simplifies the logic.
> 
> You mean this one?
> https://lore.kernel.org/bpf/20220830172759.4069786-12-davemarchevsky@fb.com
> 
> > I think you gotta give him more credit.
> > Maybe as much as his SOB and authorship.
> >
> 
> Don't mind sharing the credit where due, but for the record:
> 
> 15/8: pushed my prototype:
> https://github.com/kkdwivedi/linux/commits/bpf-list-15-08-22
> 15/8: patch with roughly the same logic as above, comitted 24 days ago
> https://github.com/kkdwivedi/linux/commit/4a152df6a1f6e096616e02c9b4dd54c5d5c902a1
> 16/8: Our meeting, described the same idea to you.
> 17/8: Published notes,
> https://lore.kernel.org/bpf/CAP01T74U30+yeBHEgmgzTJ-XYxZ0zj71kqCDJtTH9YQNfTK+Xw@mail.gmail.com
> 19/8: Described the same thing in detail again in response to Dave's question:
> > This ergonomics idea doesn't solve the map-in-map issue, I'm still unsure
> > how to statically verify lock in that case. Have you had a chance to think
> > about it further?
> >
> at https://lore.kernel.org/bpf/CAP01T77PBfQ8QvgU-ezxGgUh8WmSYL3wsMT7yo4tGuZRW0qLnQ@mail.gmail.com
> 30/8: Dave sends patch with this idea:
> https://lore.kernel.org/bpf/20220830172759.4069786-11-davemarchevsky@fb.com
> 
> What did I miss?

Just that I saw Dave's patch first. Yours 8-22 private branch I glanced over
and simply missed that patch. github UI is not for everyone.
As far as that notes thread it's hard to connect words to patches.
Re-reading it now I see what you mean.
Feel free to keep the authorship for this one.

Please answer btf question though.
