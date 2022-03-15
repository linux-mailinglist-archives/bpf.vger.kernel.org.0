Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39464DA434
	for <lists+bpf@lfdr.de>; Tue, 15 Mar 2022 21:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235380AbiCOUtL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Mar 2022 16:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241084AbiCOUtK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Mar 2022 16:49:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E22624A
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 13:47:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1B3DDB81899
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 20:47:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF2CBC340EE
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 20:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647377273;
        bh=C1sPbWWrsbrG3pUjB1lGFEDIkWD5ZDZe1V5hsfqtres=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RvAl1pw+F0jhyYBkozYP8qapX/mDTDI2ECc32KAg8ndSPulSZIpiwi3i33T1MWhP4
         u1e0L0NknxIk6kM019RY4iMCYPp7KdFh9GxUjC+Ol8VFxXsoh2/cpXBjCelc2w7f5b
         ja71FeH7YN3Qno1O17Hvuyz7iD5mjv0nDn0dzS2Qq4o+vXndXvxRsGq4do3rBUQhV8
         +s2yDVI1PAL0+Kns8XfdxQ4X4P6tUA25eBeuzMC/n0fwWa4YGRdqNBN4psuJlXPBao
         15zHwklilCk5u4Q87XRQzWv4JkWYgqTcJDfiwKngRRG82F4SJ8dL7cKsjTCKHi6YWZ
         oJAAfun5LB5ng==
Received: by mail-ej1-f53.google.com with SMTP id dr20so156505ejc.6
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 13:47:53 -0700 (PDT)
X-Gm-Message-State: AOAM5333t5tIBqxDb1WgXofXmm62417G1biKSugdtUjDecegWLnv6dh9
        BwAI1s8fZFzdatuMO3eQKhoCU9juIfsdpWpAp6qhQA==
X-Google-Smtp-Source: ABdhPJwU87gCgyB0WKJ5xykaOTA3YcJUcLzEdg5xNwc5XlmMz1fr6XuZF7ePaGlfE4uBhestayHfdVBPfgGb5//9Z9g=
X-Received: by 2002:a17:906:4c4b:b0:6da:a5d9:7af9 with SMTP id
 d11-20020a1709064c4b00b006daa5d97af9mr24250341ejw.336.1647377271860; Tue, 15
 Mar 2022 13:47:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220312011643.2136370-1-joannekoong@fb.com> <CACYkzJ6TWGOWk5UTh6juuEO2xYheu7MEh-m=R8h20sCG5sV71g@mail.gmail.com>
 <20220315190455.7v6wjovhrhnezvxi@kafai-mbp.dhcp.thefacebook.com>
 <CACYkzJ5P8frjjvQR5Q=nhsXiTyEsuJU4wY3w-Mbk2pbAVM8vJQ@mail.gmail.com>
 <CAADnVQL1Fa3uDSqaJu=0F1FjF7P_=VnXEj_8xKPDVmtCvPo06A@mail.gmail.com>
 <CACYkzJ5AWNDkmFqCCMXKN3ZCpuZmEqsFuqi4yVeU8euoJ7puzw@mail.gmail.com>
 <CAJnrk1bTSuoDf4FJr3nSiYWc_eAtXfZzyQ4GYLhAfyoAWVhpxw@mail.gmail.com> <CAADnVQLj__9CrxVhDDCNzrVaw=A1MhS1YTg9xVx+oQnG3f50EA@mail.gmail.com>
In-Reply-To: <CAADnVQLj__9CrxVhDDCNzrVaw=A1MhS1YTg9xVx+oQnG3f50EA@mail.gmail.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Tue, 15 Mar 2022 21:47:41 +0100
X-Gmail-Original-Message-ID: <CACYkzJ6gJ5ncZ8-irB6v4pNXocZV24GGKzcnGKj1pUL652OVYg@mail.gmail.com>
Message-ID: <CACYkzJ6gJ5ncZ8-irB6v4pNXocZV24GGKzcnGKj1pUL652OVYg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] bpf: Enable non-atomic allocations in local storage
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Joanne Koong <joannelkoong@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Joanne Koong <joannekoong@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Tejun Heo <tj@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 15, 2022 at 9:41 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Mar 15, 2022 at 1:33 PM Joanne Koong <joannelkoong@gmail.com> wrote:
> >
> > On Tue, Mar 15, 2022 at 1:08 PM KP Singh <kpsingh@kernel.org> wrote:
> > >
> > > On Tue, Mar 15, 2022 at 9:02 PM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Tue, Mar 15, 2022 at 12:51 PM KP Singh <kpsingh@kernel.org> wrote:
> > > > >
> > > > > On Tue, Mar 15, 2022 at 8:05 PM Martin KaFai Lau <kafai@fb.com> wrote:
> > > > > >
> > > > > > On Tue, Mar 15, 2022 at 03:26:46AM +0100, KP Singh wrote:
> > > > > > [ ... ]
> > > > > >
> > > > > > > >  struct bpf_local_storage_data *
> > > > > > > >  bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
> > > > > > > > -                        void *value, u64 map_flags)
> > > > > > > > +                        void *value, u64 map_flags, gfp_t mem_flags)
> > > > > > > >  {
> > > > > > > >         struct bpf_local_storage_data *old_sdata = NULL;
> > > > > > > >         struct bpf_local_storage_elem *selem;
> > > > > > > >         struct bpf_local_storage *local_storage;
> > > > > > > >         unsigned long flags;
> > > > > > > > -       int err;
> > > > > > > > +       int err, charge_err;
> > > > > > > >
> > > > > > > >         /* BPF_EXIST and BPF_NOEXIST cannot be both set */
> > > > > > > >         if (unlikely((map_flags & ~BPF_F_LOCK) > BPF_EXIST) ||
> > > > > > > > @@ -373,11 +373,11 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
> > > > > > > >                 if (err)
> > > > > > > >                         return ERR_PTR(err);
> > > > > > > >
> > > > > > > > -               selem = bpf_selem_alloc(smap, owner, value, true);
> > > > > > > > +               selem = bpf_selem_alloc(smap, owner, value, mem_flags);
> > > > > > > >                 if (!selem)
> > > > > > > >                         return ERR_PTR(-ENOMEM);
> > > > > > > >
> > > > > > > > -               err = bpf_local_storage_alloc(owner, smap, selem);
> > > > > > > > +               err = bpf_local_storage_alloc(owner, smap, selem, mem_flags);
> > > > > > > >                 if (err) {
> > > > > > > >                         kfree(selem);
> > > > > > > >                         mem_uncharge(smap, owner, smap->elem_size);
> > > > > > > > @@ -404,6 +404,19 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
> > > > > > > >                 }
> > > > > > > >         }
> > > > > > > >
> > > > > > > > +       /* Since mem_flags can be non-atomic, we need to do the memory
> > > > > > > > +        * allocation outside the spinlock.
> > > > > > > > +        *
> > > > > > > > +        * There are a few cases where it is permissible for the memory charge
> > > > > > > > +        * and allocation to fail (eg if BPF_F_LOCK is set and a local storage
> > > > > > > > +        * value already exists, we can swap values without needing an
> > > > > > > > +        * allocation), so in the case of a failure here, continue on and see
> > > > > > > > +        * if the failure is relevant.
> > > > > > > > +        */
> > > > > > > > +       charge_err = mem_charge(smap, owner, smap->elem_size);
> > > > > > > > +       selem = bpf_map_kzalloc(&smap->map, smap->elem_size,
> > > > > > > > +                               mem_flags | __GFP_NOWARN);
> > > > > > > > +
> > > > > > > >         raw_spin_lock_irqsave(&local_storage->lock, flags);
> > > > > > > >
> > > > > > > >         /* Recheck local_storage->list under local_storage->lock */
> > > > > > > > @@ -425,25 +438,37 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
> > > > > > > >         if (old_sdata && (map_flags & BPF_F_LOCK)) {
> > > > > > > >                 copy_map_value_locked(&smap->map, old_sdata->data, value,
> > > > > > > >                                       false);
> > > > > > > > -               selem = SELEM(old_sdata);
> > > > > > > > -               goto unlock;
> > > > > > > > +
> > > > > > > > +               raw_spin_unlock_irqrestore(&local_storage->lock, flags);
> > > > > > > > +
> > > > > > > > +               if (!charge_err)
> > > > > > > > +                       mem_uncharge(smap, owner, smap->elem_size);
> > > > > > > > +               kfree(selem);
> > > > > > > > +
> > > > > > > > +               return old_sdata;
> > > > > > > > +       }
> > > > > > > > +
> > > > > > > > +       if (!old_sdata && charge_err) {
> > > > > > > > +               /* If there is no existing local storage value, then this means
> > > > > > > > +                * we needed the charge to succeed. We must make sure this did not
> > > > > > > > +                * return an error.
> > > > > > > > +                *
> > > > > > > > +                * Please note that if an existing local storage value exists, then
> > > > > > > > +                * it doesn't matter if the charge failed because we can just
> > > > > > > > +                * "reuse" the charge from the existing local storage element.
> > > > > > > > +                */
> > > > > > >
> > > > > > > But we did allocate a new element which was unaccounted for, even if
> > > > > > > it was temporarily.
> > > > > > > [for the short period of time till we freed the old element]
> > > > > > >
> > > > > > > Martin, is this something we are okay with?
> > > > > > It is the behavior today already.  Take a look at the bpf_selem_alloc(...., !sold_data)
> > > > > > and the later "if (old_sdata) { /* ... */ bpf_selem_unlink_storage_nolock(..., false); }"
> > > > > > Most things happen in a raw_spin_lock, so this should be very brief moment.
> > > > > > Not perfect but should be fine.
> > > > > >
> > > > > > If it always error out on charge failure, it will risk the case that the
> > > > > > userspace's syscall will unnecessary be failed on mem charging while it only
> > > > > > tries to replace the old_sdata.
> > > > > >
> > > > > > If the concern is the increased chance of brief moment of unaccounted memory
> > > > > > from the helper side now because GFP_KERNEL is from the helper only,
> > > > > > another option that came up to my mind is to decide to do the alloc before or
> > > > > > after raw_spin_lock_irqsave() based on mem_flags.  The GFP_KERNEL here is only
> > > > > > calling from the bpf helper side and it is always done with BPF_NOEXIST
> > > > > > because the bpf helper has already done a lookup, so it should
> > > > > > always charge success first and then alloc.
> > > > > >
> > > > > > Something like this that drafted on top of this patch.  Untested code:
> > > > >
> > > > > I think this looks okay. One minor comment below:
> > > > >
> > > > > >
> > > > > > diff --git c/kernel/bpf/bpf_local_storage.c w/kernel/bpf/bpf_local_storage.c
> > > > > > index 092a1ac772d7..b48beb57fe6e 100644
> > > > > > --- c/kernel/bpf/bpf_local_storage.c
> > > > > > +++ w/kernel/bpf/bpf_local_storage.c
> > > > > > @@ -63,7 +63,7 @@ static bool selem_linked_to_map(const struct bpf_local_storage_elem *selem)
> > > > > >
> > > > > >  struct bpf_local_storage_elem *
> > > > > >  bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
> > > > > > -               void *value, bool charge_mem)
> > > > > > +               void *value, bool charge_mem, gfp_t mem_flags)
> > > > > >  {
> > > > > >         struct bpf_local_storage_elem *selem;
> > > > > >
> > > > > > @@ -71,7 +71,7 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
> > > > > >                 return NULL;
> > > > > >
> > > > > >         selem = bpf_map_kzalloc(&smap->map, smap->elem_size,
> > > > > > -                               GFP_ATOMIC | __GFP_NOWARN);
> > > > > > +                               mem_flags | __GFP_NOWARN);
> > > > > >         if (selem) {
> > > > > >                 if (value)
> > > > > >                         memcpy(SDATA(selem)->data, value, smap->map.value_size);
> > > > > >
> > > > > > @@ -404,6 +408,12 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
> > > > > >                 }
> > > > > >         }
> > > > > >
> > > > > > +       if (mem_flags == GFP_KERNEL) {
> > > > >
> > > > > It seems like what this check really is (and similarly for the other
> > > > > mem_flags based check you have below.
> > > > >
> > > > > "am I called from a sleepable helper"
> > > > >
> > > > > and I wonder if, instead of the verifier setting mem_flags, could set
> > > > > a boolean "sleepable_helper_call"
> > > > > which might be more useful and readable and is more relevant to the
> > > > > check that the verifier is
> > > > > performing "if (env->prog->aux->sleepable)"
> > > >
> > > > I think you're proposing to pass a boolean flag
> > > > into the helper instead of gfp_t?
> > > > I think gfp_t is cleaner.
> > > > For example we might allow local storage access under bpf_spin_lock
> > > > or other critical sections.
> > > > Passing boolean flag of the prog state is not equivalent
> > > > to the availability of gfp at the callsite inside bpf prog code.
> > >
> > > Ah yes, then using gfp_t makes sense as we may have other use cases.
> > >
> > > I think we can follow up with the changes Martin suggested separately as
> > > the current behaviour is essentially the same.
> > >
> > > In any case, you can add my:
> > >
> > > Acked-by: KP Singh <kpsingh@kernel.org>
> >
> > Thanks for the discussion, KP, Kumar, Martin, and Alexei!
> >
> > For v2, I will make the following changes:
> > 1) Allocate the memory before/after the raw_spin_lock_irqsave,
> > depending on mem_flags
> > 2) Change the comment "*mem_flags* is set by the bpf verifier" to
> > "*mem_flags* is set by the bpf verifier. Any value set through uapi
> > will be ignored"
>
> "set through uapi" is not accurate, since this argument is not part of uapi.
> We'd need a paragraph to describe everything :)
> I would just leave it as "mem_flags is a hidden argument provided by
> the verifier".

SGTM :)

>
> Since respin is coming, maybe we can rename 'mem_flags' too?
> Typically the gfp_t argument is called:
> gfp_flags, gfp_mask, gfp_extra_flags, gfp, or flags.
> I'd pick gfp_flags, but fine with others too.
