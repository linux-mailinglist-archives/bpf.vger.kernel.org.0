Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281A54DA40C
	for <lists+bpf@lfdr.de>; Tue, 15 Mar 2022 21:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351731AbiCOUee (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Mar 2022 16:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241887AbiCOUed (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Mar 2022 16:34:33 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC6B13D55
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 13:33:19 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id u7so467487ljk.13
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 13:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U90ZSe83d/KPT8KetTmppIVel887DQyXx6DoIWVIqZ4=;
        b=ofD53QexEhUFWSwFotedCX3vd5jJ8y7q3BlCpNBErPg7xiX9ji54yR2Kei/VzksZyY
         gl+ILBOUFSgZyh35uSp45yZSm7/Vetzs1Dn0T8SQMmzRa4RZB8rj4b5gkfEGuRkB4DNe
         nWGdx4TR+xU7i8IKyVFCp/xUcjmHQG6melbHl9tD3BQjKtS1nlC4XMqaSZHm78O/5NDQ
         kdalkc/qJx4ozoUrp29AfDBlRxfVzz9V8Bg2FeG46E0fAcaYPmeupnN4r7fJvw6Kiho+
         tPkLdfxmqguklwVoJp9JQDhb7fll/sPwOnjQrehmfy6DVBkt7u+KTRtjOJfQD7KElewk
         nNhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U90ZSe83d/KPT8KetTmppIVel887DQyXx6DoIWVIqZ4=;
        b=46NCc5Anbuj/8X4N7V7demiwq4SXygyX1LNEA4PoBMS+sqBkeKGcO4DjfS+N2vVgP2
         LH72/JWj7BXMHVLGD3ZD99NkPUcEX4bV2xEf/u/hxgScEiLcNevZ4LNFo0von+8O/OPU
         ThOfOwT6xuh5z809JXWL4WS+Pe1bgEuE1SiX1TsN1pH4O7P+xuY+l68w7Y3kvnT04d/1
         91fEwYTcU/O7skaUyVz2mtHHsfTj/FMGYRMIq01kcBImME1iVBPWEOVrZlaYXrm8Q3r9
         Is8xIYs0WoRPLCmLaIYy0zccRolc4cHyut/mpF3A5gyKRDCGYUDg0gx29+Syl6uc88CF
         6jLQ==
X-Gm-Message-State: AOAM532sTAfb5/QttKon9CxECa54YiQcF8Fwcp+19QGqSUji3JgcQ2Kz
        DLqM8Mc313//Nu94kD4edbIktWen9idV3QmB7G8Gs+I835BVICnm
X-Google-Smtp-Source: ABdhPJwBoC8RbdwnHbaWBBUr8Ut90aKIcvUiVDEYO6VVV2rvD/NUXK3hvghvZvo7PwpSzOktM04cRYPeDaSTJbE6S+U=
X-Received: by 2002:a05:651c:1502:b0:249:2ed0:ae24 with SMTP id
 e2-20020a05651c150200b002492ed0ae24mr8903349ljf.70.1647376397357; Tue, 15 Mar
 2022 13:33:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220312011643.2136370-1-joannekoong@fb.com> <CACYkzJ6TWGOWk5UTh6juuEO2xYheu7MEh-m=R8h20sCG5sV71g@mail.gmail.com>
 <20220315190455.7v6wjovhrhnezvxi@kafai-mbp.dhcp.thefacebook.com>
 <CACYkzJ5P8frjjvQR5Q=nhsXiTyEsuJU4wY3w-Mbk2pbAVM8vJQ@mail.gmail.com>
 <CAADnVQL1Fa3uDSqaJu=0F1FjF7P_=VnXEj_8xKPDVmtCvPo06A@mail.gmail.com> <CACYkzJ5AWNDkmFqCCMXKN3ZCpuZmEqsFuqi4yVeU8euoJ7puzw@mail.gmail.com>
In-Reply-To: <CACYkzJ5AWNDkmFqCCMXKN3ZCpuZmEqsFuqi4yVeU8euoJ7puzw@mail.gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Tue, 15 Mar 2022 13:33:05 -0700
Message-ID: <CAJnrk1bTSuoDf4FJr3nSiYWc_eAtXfZzyQ4GYLhAfyoAWVhpxw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] bpf: Enable non-atomic allocations in local storage
To:     KP Singh <kpsingh@kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Joanne Koong <joannekoong@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Tejun Heo <tj@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
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

On Tue, Mar 15, 2022 at 1:08 PM KP Singh <kpsingh@kernel.org> wrote:
>
> On Tue, Mar 15, 2022 at 9:02 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Mar 15, 2022 at 12:51 PM KP Singh <kpsingh@kernel.org> wrote:
> > >
> > > On Tue, Mar 15, 2022 at 8:05 PM Martin KaFai Lau <kafai@fb.com> wrote:
> > > >
> > > > On Tue, Mar 15, 2022 at 03:26:46AM +0100, KP Singh wrote:
> > > > [ ... ]
> > > >
> > > > > >  struct bpf_local_storage_data *
> > > > > >  bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
> > > > > > -                        void *value, u64 map_flags)
> > > > > > +                        void *value, u64 map_flags, gfp_t mem_flags)
> > > > > >  {
> > > > > >         struct bpf_local_storage_data *old_sdata = NULL;
> > > > > >         struct bpf_local_storage_elem *selem;
> > > > > >         struct bpf_local_storage *local_storage;
> > > > > >         unsigned long flags;
> > > > > > -       int err;
> > > > > > +       int err, charge_err;
> > > > > >
> > > > > >         /* BPF_EXIST and BPF_NOEXIST cannot be both set */
> > > > > >         if (unlikely((map_flags & ~BPF_F_LOCK) > BPF_EXIST) ||
> > > > > > @@ -373,11 +373,11 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
> > > > > >                 if (err)
> > > > > >                         return ERR_PTR(err);
> > > > > >
> > > > > > -               selem = bpf_selem_alloc(smap, owner, value, true);
> > > > > > +               selem = bpf_selem_alloc(smap, owner, value, mem_flags);
> > > > > >                 if (!selem)
> > > > > >                         return ERR_PTR(-ENOMEM);
> > > > > >
> > > > > > -               err = bpf_local_storage_alloc(owner, smap, selem);
> > > > > > +               err = bpf_local_storage_alloc(owner, smap, selem, mem_flags);
> > > > > >                 if (err) {
> > > > > >                         kfree(selem);
> > > > > >                         mem_uncharge(smap, owner, smap->elem_size);
> > > > > > @@ -404,6 +404,19 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
> > > > > >                 }
> > > > > >         }
> > > > > >
> > > > > > +       /* Since mem_flags can be non-atomic, we need to do the memory
> > > > > > +        * allocation outside the spinlock.
> > > > > > +        *
> > > > > > +        * There are a few cases where it is permissible for the memory charge
> > > > > > +        * and allocation to fail (eg if BPF_F_LOCK is set and a local storage
> > > > > > +        * value already exists, we can swap values without needing an
> > > > > > +        * allocation), so in the case of a failure here, continue on and see
> > > > > > +        * if the failure is relevant.
> > > > > > +        */
> > > > > > +       charge_err = mem_charge(smap, owner, smap->elem_size);
> > > > > > +       selem = bpf_map_kzalloc(&smap->map, smap->elem_size,
> > > > > > +                               mem_flags | __GFP_NOWARN);
> > > > > > +
> > > > > >         raw_spin_lock_irqsave(&local_storage->lock, flags);
> > > > > >
> > > > > >         /* Recheck local_storage->list under local_storage->lock */
> > > > > > @@ -425,25 +438,37 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
> > > > > >         if (old_sdata && (map_flags & BPF_F_LOCK)) {
> > > > > >                 copy_map_value_locked(&smap->map, old_sdata->data, value,
> > > > > >                                       false);
> > > > > > -               selem = SELEM(old_sdata);
> > > > > > -               goto unlock;
> > > > > > +
> > > > > > +               raw_spin_unlock_irqrestore(&local_storage->lock, flags);
> > > > > > +
> > > > > > +               if (!charge_err)
> > > > > > +                       mem_uncharge(smap, owner, smap->elem_size);
> > > > > > +               kfree(selem);
> > > > > > +
> > > > > > +               return old_sdata;
> > > > > > +       }
> > > > > > +
> > > > > > +       if (!old_sdata && charge_err) {
> > > > > > +               /* If there is no existing local storage value, then this means
> > > > > > +                * we needed the charge to succeed. We must make sure this did not
> > > > > > +                * return an error.
> > > > > > +                *
> > > > > > +                * Please note that if an existing local storage value exists, then
> > > > > > +                * it doesn't matter if the charge failed because we can just
> > > > > > +                * "reuse" the charge from the existing local storage element.
> > > > > > +                */
> > > > >
> > > > > But we did allocate a new element which was unaccounted for, even if
> > > > > it was temporarily.
> > > > > [for the short period of time till we freed the old element]
> > > > >
> > > > > Martin, is this something we are okay with?
> > > > It is the behavior today already.  Take a look at the bpf_selem_alloc(...., !sold_data)
> > > > and the later "if (old_sdata) { /* ... */ bpf_selem_unlink_storage_nolock(..., false); }"
> > > > Most things happen in a raw_spin_lock, so this should be very brief moment.
> > > > Not perfect but should be fine.
> > > >
> > > > If it always error out on charge failure, it will risk the case that the
> > > > userspace's syscall will unnecessary be failed on mem charging while it only
> > > > tries to replace the old_sdata.
> > > >
> > > > If the concern is the increased chance of brief moment of unaccounted memory
> > > > from the helper side now because GFP_KERNEL is from the helper only,
> > > > another option that came up to my mind is to decide to do the alloc before or
> > > > after raw_spin_lock_irqsave() based on mem_flags.  The GFP_KERNEL here is only
> > > > calling from the bpf helper side and it is always done with BPF_NOEXIST
> > > > because the bpf helper has already done a lookup, so it should
> > > > always charge success first and then alloc.
> > > >
> > > > Something like this that drafted on top of this patch.  Untested code:
> > >
> > > I think this looks okay. One minor comment below:
> > >
> > > >
> > > > diff --git c/kernel/bpf/bpf_local_storage.c w/kernel/bpf/bpf_local_storage.c
> > > > index 092a1ac772d7..b48beb57fe6e 100644
> > > > --- c/kernel/bpf/bpf_local_storage.c
> > > > +++ w/kernel/bpf/bpf_local_storage.c
> > > > @@ -63,7 +63,7 @@ static bool selem_linked_to_map(const struct bpf_local_storage_elem *selem)
> > > >
> > > >  struct bpf_local_storage_elem *
> > > >  bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
> > > > -               void *value, bool charge_mem)
> > > > +               void *value, bool charge_mem, gfp_t mem_flags)
> > > >  {
> > > >         struct bpf_local_storage_elem *selem;
> > > >
> > > > @@ -71,7 +71,7 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
> > > >                 return NULL;
> > > >
> > > >         selem = bpf_map_kzalloc(&smap->map, smap->elem_size,
> > > > -                               GFP_ATOMIC | __GFP_NOWARN);
> > > > +                               mem_flags | __GFP_NOWARN);
> > > >         if (selem) {
> > > >                 if (value)
> > > >                         memcpy(SDATA(selem)->data, value, smap->map.value_size);
> > > >
> > > > @@ -404,6 +408,12 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
> > > >                 }
> > > >         }
> > > >
> > > > +       if (mem_flags == GFP_KERNEL) {
> > >
> > > It seems like what this check really is (and similarly for the other
> > > mem_flags based check you have below.
> > >
> > > "am I called from a sleepable helper"
> > >
> > > and I wonder if, instead of the verifier setting mem_flags, could set
> > > a boolean "sleepable_helper_call"
> > > which might be more useful and readable and is more relevant to the
> > > check that the verifier is
> > > performing "if (env->prog->aux->sleepable)"
> >
> > I think you're proposing to pass a boolean flag
> > into the helper instead of gfp_t?
> > I think gfp_t is cleaner.
> > For example we might allow local storage access under bpf_spin_lock
> > or other critical sections.
> > Passing boolean flag of the prog state is not equivalent
> > to the availability of gfp at the callsite inside bpf prog code.
>
> Ah yes, then using gfp_t makes sense as we may have other use cases.
>
> I think we can follow up with the changes Martin suggested separately as
> the current behaviour is essentially the same.
>
> In any case, you can add my:
>
> Acked-by: KP Singh <kpsingh@kernel.org>

Thanks for the discussion, KP, Kumar, Martin, and Alexei!

For v2, I will make the following changes:
1) Allocate the memory before/after the raw_spin_lock_irqsave,
depending on mem_flags
2) Change the comment "*mem_flags* is set by the bpf verifier" to
"*mem_flags* is set by the bpf verifier. Any value set through uapi
will be ignored"
