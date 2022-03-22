Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53744E4967
	for <lists+bpf@lfdr.de>; Tue, 22 Mar 2022 23:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238553AbiCVW4E (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Mar 2022 18:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238495AbiCVW4E (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Mar 2022 18:56:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F84527F9
        for <bpf@vger.kernel.org>; Tue, 22 Mar 2022 15:54:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C29360FEF
        for <bpf@vger.kernel.org>; Tue, 22 Mar 2022 22:54:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBD0FC340EC
        for <bpf@vger.kernel.org>; Tue, 22 Mar 2022 22:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647989675;
        bh=jCI8/YE6s6WtTWiPikMuL+IKtzN7vs147QxMrZfq6gI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ft4sp6JPI1VSIK5KPKhy50a/srDS08192+a6895yVFkcFKMS7LGl5GiYbJLa26Kwa
         xPKXCJN4qxRugEXnXkwE+mq2MT6vr07AL0dxTHo9wB0WR/Gzl0xwLb9HK2TdO8+ffj
         K//Op+DZ6zGGfh0ZHayj0p7HiDmX7Ia0ozyD8tHjJBESTsFoaSniRe1D4W/6BGctUi
         eeZ2P2l1RxebsuMHaxBE7xfSKZ9+SpFHME5EOxRFe8zWGs7U8frhaOFgsUGFiYJPgK
         Ah/YzVitnam9kItKVXyaReo7iHDm0Slj11ns/Yd+iH2A2yySj1xDnfrvcLDx358Lvv
         4mcrMPQ/1EpDw==
Received: by mail-ed1-f47.google.com with SMTP id b15so23468764edn.4
        for <bpf@vger.kernel.org>; Tue, 22 Mar 2022 15:54:34 -0700 (PDT)
X-Gm-Message-State: AOAM531AaPfSe+crl1/KAPLU1oh/qBw+gb2Wei0g8sWwI8RrADjWKsy8
        7daAXLFVYKGcYMkIOObtNP7OnkqxnVjRQ3AKx4XYXQ==
X-Google-Smtp-Source: ABdhPJyoHYRsAT0HhNKUYSCiceYjhGUqELlOLUAbhg3D3+jHZd32u5y1FdXBdFppzjw3WQUhEwC9iwljJWLPR62tX5w=
X-Received: by 2002:aa7:c157:0:b0:418:f8e3:4c87 with SMTP id
 r23-20020aa7c157000000b00418f8e34c87mr29740349edp.271.1647989673137; Tue, 22
 Mar 2022 15:54:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220322211513.3994356-1-joannekoong@fb.com> <20220322215656.xkfzvuc3blrl7mlq@kafai-mbp.dhcp.thefacebook.com>
 <CAJnrk1aRAXeDQKQq7zUPoJSb8oOFbb+jgtdF2_ttjcQL+Oo13A@mail.gmail.com>
In-Reply-To: <CAJnrk1aRAXeDQKQq7zUPoJSb8oOFbb+jgtdF2_ttjcQL+Oo13A@mail.gmail.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Tue, 22 Mar 2022 23:54:22 +0100
X-Gmail-Original-Message-ID: <CACYkzJ5R5CbiY7ZWo4sj84+e_QZVXB+GxJPd7yaj6fccX-KZXA@mail.gmail.com>
Message-ID: <CACYkzJ5R5CbiY7ZWo4sj84+e_QZVXB+GxJPd7yaj6fccX-KZXA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] bpf: bpf_local_storage_update fixes
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     Martin KaFai Lau <kafai@fb.com>, Joanne Koong <joannekoong@fb.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 22, 2022 at 11:38 PM Joanne Koong <joannelkoong@gmail.com> wrote:
>
> On Tue, Mar 22, 2022 at 2:57 PM Martin KaFai Lau <kafai@fb.com> wrote:
> >
> > On Tue, Mar 22, 2022 at 02:15:13PM -0700, Joanne Koong wrote:
> > > From: Joanne Koong <joannelkoong@gmail.com>
> > >
> > > This fixes two things in bpf_local_storage_update:
> > >
> > > 1) A memory leak where if bpf_selem_alloc is called right before we
> > > acquire the spinlock and we hit the case where we can copy the new
> > > value into old_sdata directly, we need to free the selem allocation
> > > and uncharge the memory before we return. This was reported by the
> > > kernel test robot.
> > >
> > > 2) A charge leak where if bpf_selem_alloc is called right before we
> > > acquire the spinlock and we hit the case where old_sdata exists and we
> > > need to unlink the old selem, we need to make sure the old selem gets
> > > uncharged.
> > >
> > > Fixes: b00fa38a9c1c ("bpf: Enable non-atomic allocations in local storage")
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > ---
> > >  kernel/bpf/bpf_local_storage.c | 11 +++++++----
> > >  1 file changed, 7 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
> > > index 01aa2b51ec4d..2d33af0368ba 100644
> > > --- a/kernel/bpf/bpf_local_storage.c
> > > +++ b/kernel/bpf/bpf_local_storage.c
> > > @@ -435,8 +435,12 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
> > >       if (old_sdata && (map_flags & BPF_F_LOCK)) {
> > >               copy_map_value_locked(&smap->map, old_sdata->data, value,
> > >                                     false);
> > > -             selem = SELEM(old_sdata);
> > > -             goto unlock;
> > > +             raw_spin_unlock_irqrestore(&local_storage->lock, flags);
> > > +             if (selem) {
> > There is an earlier test ensures GFP_KERNEL can only
> > be used with BPF_NOEXIST.
> >
>
> I agree, we currently will never run into this case (since the
> GFP_KERNEL case will error out if old_sdata exists), but my thinking
> was that maybe in the future it may not always hold that GFP_KERNEL
> will always be coupled with BPF_NOEXIST, so this change would
> defensively protect against that.

Didn't we discuss that we should not do this?

"The GFP_KERNEL here is only
calling from the bpf helper side and it is always done with BPF_NOEXIST
because the bpf helper has already done a lookup,
so it should always charge success first and then alloc."

Right?

I think we should add some comments about this in the code.

Also, on a side note (as it's from an older commit),
the flags logic seems to be getting more and more
complicated.

/* BPF_EXIST and BPF_NOEXIST cannot be both set */
if (unlikely((map_flags & ~BPF_F_LOCK) > BPF_EXIST) ||
/* BPF_F_LOCK can only be used in a value with spin_lock */
unlikely((map_flags & BPF_F_LOCK) &&
!map_value_has_spin_lock(&smap->map)))
     return ERR_PTR(-EINVAL);

if (gfp_flags == GFP_KERNEL && (map_flags & ~BPF_F_LOCK) != BPF_NOEXIST)
    return ERR_PTR(-EINVAL);

esp. stuff like

unlikely((map_flags & ~BPF_F_LOCK) > BPF_EXIST

I think we should be more explicit in what we are checking so that
it's easier to read.

>
> > The check_flags() before this should have error out.
> >
> > Can you share a pointer to the report from kernel test robot?
> >
> I'm unable to find a link to the report, so I will copy/paste the contents:
>
> From: kernel test robot <lkp@intel.com>
> Date: Tue, Mar 22, 2022 at 11:36 AM
> Subject: [bpf-next:master] BUILD SUCCESS
> e52b8f5bd3d2f7b2f4b98067db33bc2fdc125643
> To: BPF build status <bpf@iogearbox.net>
>
>
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
> master
> branch HEAD: e52b8f5bd3d2f7b2f4b98067db33bc2fdc125643  selftests/bpf:
> Fix kprobe_multi test.
>
> Unverified Warning (likely false positive, please contact us if interested):

It's indeed a false positive then.


>
> kernel/bpf/bpf_local_storage.c:473:2: warning: Potential leak of
> memory pointed to by 'selem' [clang-analyzer-unix.Malloc]
>
> Warning ids grouped by kconfigs:
>
> clang_recent_errors
> `-- i386-randconfig-c001
>     `-- kernel-bpf-bpf_local_storage.c:warning:Potential-leak-of-memory-pointed-to-by-selem-clang-analyzer-unix.Malloc
>
> elapsed time: 723m
>
> > > +                     mem_uncharge(smap, owner, smap->elem_size);
> > > +                     kfree(selem);
> > > +             }
> > > +             return old_sdata;
> > >       }
> > >
> > >       if (gfp_flags != GFP_KERNEL) {
> > > @@ -466,10 +470,9 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
> > >       if (old_sdata) {
> > >               bpf_selem_unlink_map(SELEM(old_sdata));
> > >               bpf_selem_unlink_storage_nolock(local_storage, SELEM(old_sdata),
> > > -                                             false);
> > > +                                             gfp_flags == GFP_KERNEL);
> > >       }
> > >
> > > -unlock:
> > >       raw_spin_unlock_irqrestore(&local_storage->lock, flags);
> > >       return SDATA(selem);
> > >
> > > --
> > > 2.30.2
> > >
