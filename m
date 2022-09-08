Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CACA85B11D5
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 03:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbiIHBJM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 21:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiIHBJL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 21:09:11 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F3BC6B4F
        for <bpf@vger.kernel.org>; Wed,  7 Sep 2022 18:09:10 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id r17so7026225ejy.9
        for <bpf@vger.kernel.org>; Wed, 07 Sep 2022 18:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Iwg1iSMaCupnXmkAyKIAjdaIvIVLsNqYoWMacWsoG9o=;
        b=Mt4eeWbiPfWAPEC0KnUmGEBwogA5SlGpKP+RGRbtV1WmL8caVcmKy63ylG1+cjcKkU
         MVnCcjPQ75XW6qYV5RtXPO08AMqZVFnQ9cJ6IfIyLmGECvcmIaGV4yrSaHj5wm45neIv
         ZftlekPW5qQ94gm/143gyEHuGeuEfH+Jv7UTSpXsKb1TN3ML53ZYNxJdbwPYwr9AT2g9
         yzTAU1MgI83m7brkrLPtD8q8ho9mDQdycoM4EqU5sihaDX5GyDXZ7MFs0r8P0SXOO6Zz
         lbQ3B0waxgGSnxAQPQbVyeTIZ5MkIkCsDB3KC1Mx2QMpm+8qn5ASBr34CGyqRXJaI6o/
         3CaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Iwg1iSMaCupnXmkAyKIAjdaIvIVLsNqYoWMacWsoG9o=;
        b=5EhN5clVkD0PZ5m5I1K2TwyjKQhh8RVnbB26SIMoXKwb4UiG55QkoX5zB/jSn5tqSg
         InF8Dly1+dgpoOi9G/lHjMO8RebHzY204hi86Dj2m1HWaNC+vb5DP3LhKYkMKcos6wVS
         g9oC3AD1rP0IL7XLZDEdWAJYDqIwBjtkmBhdoWWSIxkG68uZh04NlVTAY73lAZJdy8O1
         ZxO9I8gEet9rteTYmGqerGdQhze/JMU4+Kn09oOqtm7lC/RpmVQu1HOgYOPfsUWRlzGs
         qVZN8ZTvQY+ZrmVu+LbhC3igkq3SDmY5N9Im9aaPOQghRaSQVcy3xW2qxj5Ae7w/0JR7
         ww7w==
X-Gm-Message-State: ACgBeo1iNJkOY82KRjHRNAEnHpDfAYvK0eBUgWT7Unx6lwTNmun3V81W
        l4K8dqi0tRtw7QvbnOxMc/uvf8tLNbeXukpmzoo=
X-Google-Smtp-Source: AA6agR60LOcWXCiTpxh528qjP0XnVXroxQu3x0I/eGK5mH9ygRTkC4KGRk7Ldmkp29QdESPER4jlLuCKYNvQjwF1Drs=
X-Received: by 2002:a17:907:a04f:b0:772:da0b:e2f1 with SMTP id
 gz15-20020a170907a04f00b00772da0be2f1mr1400378ejc.327.1662599348362; Wed, 07
 Sep 2022 18:09:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220904204145.3089-1-memxor@gmail.com> <20220904204145.3089-22-memxor@gmail.com>
 <20220908002742.cqwwahxa5ktaik3r@macbook-pro-4.dhcp.thefacebook.com> <CAP01T76nqGs0gW2MPJVMNu90j7DT6GChU0PKS1KZQt7SHb6ypg@mail.gmail.com>
In-Reply-To: <CAP01T76nqGs0gW2MPJVMNu90j7DT6GChU0PKS1KZQt7SHb6ypg@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 7 Sep 2022 18:08:57 -0700
Message-ID: <CAADnVQLvRKiqVLy-SqC-fJjfqGHYvYUXQMRuT3vTzVA7BfoEGw@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v1 21/32] bpf: Allow locking bpf_spin_lock
 global variables
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
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

On Wed, Sep 7, 2022 at 6:01 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
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
>
> It makes active_spin_lock check simpler, just checking
> active_spin_lock_ptr that to be non-NULL indicates lock is held. Don't
> have to always check both ptr and id, only need to compare both when
> verifying that lock is in the same allocation as reg.

Not following. There is always non-null reg->map_ptr when
we come down this path.
At least in the current state of the verifier.
So it never assigns that btf afacs.
