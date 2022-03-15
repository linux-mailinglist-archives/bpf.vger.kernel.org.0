Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928A84DA37E
	for <lists+bpf@lfdr.de>; Tue, 15 Mar 2022 20:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351487AbiCOTw6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Mar 2022 15:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351480AbiCOTw6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Mar 2022 15:52:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2741275C
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 12:51:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 790B061714
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 19:51:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D194CC340F6
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 19:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647373903;
        bh=GP6jjdn6jZqasuqBbdaGSBKnlI9AxIaIxRznK347J0o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BQuoPk6laH3DGXWHkmryxKkKyCspGdBqSwXwoiPoNlSU5W7W5xMXp6D/k0xTakPF3
         tudZ18JasizgWc4g9CcYGwQCoDw43UYcLoukUBIuVdg2yky+pi/6KJNk0XVt6OVJJ5
         T2UyFX6wkEY/1EfCZO0NwPKV9xGflRp0/GXXMJYk9vc1KkVu+yt507Z6YZDHLttrzl
         iL5ASTYRcrtWr00dYLy/SWIraWEMfuFvI300rWqwX96qFU4dIHMV4mzL8Lfeo/Wu3k
         fYdE/8GElncv+C9u/DVb8phhAM7zbjfeyXiB/L7jU7AbKc232DcJdg4CkJnSmRa+og
         8iuTU7Hhrf6tQ==
Received: by mail-ej1-f45.google.com with SMTP id bg10so43880156ejb.4
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 12:51:43 -0700 (PDT)
X-Gm-Message-State: AOAM531iCLHZccfEb3YdwbFvnVQAh8/iTpyzEv7Ui3HX+P98Ia1q9FZb
        z2fk6+S8RuirB4RsrbB2ZjSUMb/31pH8nvokp4zFKw==
X-Google-Smtp-Source: ABdhPJyupnN9bz3Co2Z1aVDS4A8Zi4axHNHWhdLxXQI9avuKW8GI/+CLR7yJpZ2lRmV6SPFVA8BHJWAsAaOIjgD3CYg=
X-Received: by 2002:a17:906:a1c8:b0:6da:a635:e402 with SMTP id
 bx8-20020a170906a1c800b006daa635e402mr24927774ejb.598.1647373901878; Tue, 15
 Mar 2022 12:51:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220312011643.2136370-1-joannekoong@fb.com> <CACYkzJ6TWGOWk5UTh6juuEO2xYheu7MEh-m=R8h20sCG5sV71g@mail.gmail.com>
 <20220315190455.7v6wjovhrhnezvxi@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20220315190455.7v6wjovhrhnezvxi@kafai-mbp.dhcp.thefacebook.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Tue, 15 Mar 2022 20:51:31 +0100
X-Gmail-Original-Message-ID: <CACYkzJ5P8frjjvQR5Q=nhsXiTyEsuJU4wY3w-Mbk2pbAVM8vJQ@mail.gmail.com>
Message-ID: <CACYkzJ5P8frjjvQR5Q=nhsXiTyEsuJU4wY3w-Mbk2pbAVM8vJQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] bpf: Enable non-atomic allocations in local storage
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Joanne Koong <joannekoong@fb.com>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        tj@kernel.org, davemarchevsky@fb.com,
        Joanne Koong <joannelkoong@gmail.com>
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

On Tue, Mar 15, 2022 at 8:05 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Tue, Mar 15, 2022 at 03:26:46AM +0100, KP Singh wrote:
> [ ... ]
>
> > >  struct bpf_local_storage_data *
> > >  bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
> > > -                        void *value, u64 map_flags)
> > > +                        void *value, u64 map_flags, gfp_t mem_flags)
> > >  {
> > >         struct bpf_local_storage_data *old_sdata = NULL;
> > >         struct bpf_local_storage_elem *selem;
> > >         struct bpf_local_storage *local_storage;
> > >         unsigned long flags;
> > > -       int err;
> > > +       int err, charge_err;
> > >
> > >         /* BPF_EXIST and BPF_NOEXIST cannot be both set */
> > >         if (unlikely((map_flags & ~BPF_F_LOCK) > BPF_EXIST) ||
> > > @@ -373,11 +373,11 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
> > >                 if (err)
> > >                         return ERR_PTR(err);
> > >
> > > -               selem = bpf_selem_alloc(smap, owner, value, true);
> > > +               selem = bpf_selem_alloc(smap, owner, value, mem_flags);
> > >                 if (!selem)
> > >                         return ERR_PTR(-ENOMEM);
> > >
> > > -               err = bpf_local_storage_alloc(owner, smap, selem);
> > > +               err = bpf_local_storage_alloc(owner, smap, selem, mem_flags);
> > >                 if (err) {
> > >                         kfree(selem);
> > >                         mem_uncharge(smap, owner, smap->elem_size);
> > > @@ -404,6 +404,19 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
> > >                 }
> > >         }
> > >
> > > +       /* Since mem_flags can be non-atomic, we need to do the memory
> > > +        * allocation outside the spinlock.
> > > +        *
> > > +        * There are a few cases where it is permissible for the memory charge
> > > +        * and allocation to fail (eg if BPF_F_LOCK is set and a local storage
> > > +        * value already exists, we can swap values without needing an
> > > +        * allocation), so in the case of a failure here, continue on and see
> > > +        * if the failure is relevant.
> > > +        */
> > > +       charge_err = mem_charge(smap, owner, smap->elem_size);
> > > +       selem = bpf_map_kzalloc(&smap->map, smap->elem_size,
> > > +                               mem_flags | __GFP_NOWARN);
> > > +
> > >         raw_spin_lock_irqsave(&local_storage->lock, flags);
> > >
> > >         /* Recheck local_storage->list under local_storage->lock */
> > > @@ -425,25 +438,37 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
> > >         if (old_sdata && (map_flags & BPF_F_LOCK)) {
> > >                 copy_map_value_locked(&smap->map, old_sdata->data, value,
> > >                                       false);
> > > -               selem = SELEM(old_sdata);
> > > -               goto unlock;
> > > +
> > > +               raw_spin_unlock_irqrestore(&local_storage->lock, flags);
> > > +
> > > +               if (!charge_err)
> > > +                       mem_uncharge(smap, owner, smap->elem_size);
> > > +               kfree(selem);
> > > +
> > > +               return old_sdata;
> > > +       }
> > > +
> > > +       if (!old_sdata && charge_err) {
> > > +               /* If there is no existing local storage value, then this means
> > > +                * we needed the charge to succeed. We must make sure this did not
> > > +                * return an error.
> > > +                *
> > > +                * Please note that if an existing local storage value exists, then
> > > +                * it doesn't matter if the charge failed because we can just
> > > +                * "reuse" the charge from the existing local storage element.
> > > +                */
> >
> > But we did allocate a new element which was unaccounted for, even if
> > it was temporarily.
> > [for the short period of time till we freed the old element]
> >
> > Martin, is this something we are okay with?
> It is the behavior today already.  Take a look at the bpf_selem_alloc(...., !sold_data)
> and the later "if (old_sdata) { /* ... */ bpf_selem_unlink_storage_nolock(..., false); }"
> Most things happen in a raw_spin_lock, so this should be very brief moment.
> Not perfect but should be fine.
>
> If it always error out on charge failure, it will risk the case that the
> userspace's syscall will unnecessary be failed on mem charging while it only
> tries to replace the old_sdata.
>
> If the concern is the increased chance of brief moment of unaccounted memory
> from the helper side now because GFP_KERNEL is from the helper only,
> another option that came up to my mind is to decide to do the alloc before or
> after raw_spin_lock_irqsave() based on mem_flags.  The GFP_KERNEL here is only
> calling from the bpf helper side and it is always done with BPF_NOEXIST
> because the bpf helper has already done a lookup, so it should
> always charge success first and then alloc.
>
> Something like this that drafted on top of this patch.  Untested code:

I think this looks okay. One minor comment below:

>
> diff --git c/kernel/bpf/bpf_local_storage.c w/kernel/bpf/bpf_local_storage.c
> index 092a1ac772d7..b48beb57fe6e 100644
> --- c/kernel/bpf/bpf_local_storage.c
> +++ w/kernel/bpf/bpf_local_storage.c
> @@ -63,7 +63,7 @@ static bool selem_linked_to_map(const struct bpf_local_storage_elem *selem)
>
>  struct bpf_local_storage_elem *
>  bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
> -               void *value, bool charge_mem)
> +               void *value, bool charge_mem, gfp_t mem_flags)
>  {
>         struct bpf_local_storage_elem *selem;
>
> @@ -71,7 +71,7 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
>                 return NULL;
>
>         selem = bpf_map_kzalloc(&smap->map, smap->elem_size,
> -                               GFP_ATOMIC | __GFP_NOWARN);
> +                               mem_flags | __GFP_NOWARN);
>         if (selem) {
>                 if (value)
>                         memcpy(SDATA(selem)->data, value, smap->map.value_size);
>
> @@ -404,6 +408,12 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
>                 }
>         }
>
> +       if (mem_flags == GFP_KERNEL) {

It seems like what this check really is (and similarly for the other
mem_flags based check you have below.

"am I called from a sleepable helper"

and I wonder if, instead of the verifier setting mem_flags, could set
a boolean "sleepable_helper_call"
which might be more useful and readable and is more relevant to the
check that the verifier is
performing "if (env->prog->aux->sleepable)"


> +               selem = bpf_selem_alloc(smap, owner, value, true, mem_flags);
> +               if (!selem)
> +                       return ERR_PTR(-ENOMEM);
> +       }
> +
>         raw_spin_lock_irqsave(&local_storage->lock, flags);
>
>         /* Recheck local_storage->list under local_storage->lock */
> @@ -438,10 +448,12 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
>          * old_sdata will not be uncharged later during
>          * bpf_selem_unlink_storage_nolock().
>          */
> -       selem = bpf_selem_alloc(smap, owner, value, !old_sdata);
> -       if (!selem) {
> -               err = -ENOMEM;
> -               goto unlock_err;
> +       if (mem_flags != GFP_KERNEL) {
> +               selem = bpf_selem_alloc(smap, owner, value, !old_sdata, mem_flags);
> +               if (!selem) {
> +                       err = -ENOMEM;
> +                       goto unlock_err;
> +               }
>         }
>
>         /* First, link the new selem to the map */
> @@ -463,6 +475,10 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
>
>  unlock_err:
>         raw_spin_unlock_irqrestore(&local_storage->lock, flags);
> +       if (selem) {
> +               mem_uncharge(smap, owner, smap->elem_size);
> +               kfree(selem);
> +       }
>         return ERR_PTR(err);
>  }
>
>
> >
> > > +               err = charge_err;
> > > +               goto unlock_err;
> > >         }
> > >
> > > -       /* local_storage->lock is held.  Hence, we are sure
> > > -        * we can unlink and uncharge the old_sdata successfully
> > > -        * later.  Hence, instead of charging the new selem now
> > > -        * and then uncharge the old selem later (which may cause
> > > -        * a potential but unnecessary charge failure),  avoid taking
> > > -        * a charge at all here (the "!old_sdata" check) and the
> > > -        * old_sdata will not be uncharged later during
> > > -        * bpf_selem_unlink_storage_nolock().
> > > -        */
> > > -       selem = bpf_selem_alloc(smap, owner, value, !old_sdata);
> > >         if (!selem) {
> > >                 err = -ENOMEM;
> > >                 goto unlock_err;
> > >         }
> > >
> > > +       if (value)
> > > +               memcpy(SDATA(selem)->data, value, smap->map.value_size);
> > > +
> > >         /* First, link the new selem to the map */
> > >         bpf_selem_link_map(smap, selem);
> > >
> > > @@ -454,15 +479,17 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
> > >         if (old_sdata) {
> > >                 bpf_selem_unlink_map(SELEM(old_sdata));
> > >                 bpf_selem_unlink_storage_nolock(local_storage, SELEM(old_sdata),
> > > -                                               false);
> > > +                                               !charge_err);
> > >         }
> > >
> > > -unlock:
> > >         raw_spin_unlock_irqrestore(&local_storage->lock, flags);
> > >         return SDATA(selem);
> > >
> > >  unlock_err:
> > >         raw_spin_unlock_irqrestore(&local_storage->lock, flags);
> > > +       if (!charge_err)
> > > +               mem_uncharge(smap, owner, smap->elem_size);
> > > +       kfree(selem);
> > >         return ERR_PTR(err);
> > >  }
> > >
> > > diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
> > > index 5da7bed0f5f6..bb9e22bad42b 100644
> > > --- a/kernel/bpf/bpf_task_storage.c
> > > +++ b/kernel/bpf/bpf_task_storage.c
> > > @@ -174,7 +174,8 @@ static int bpf_pid_task_storage_update_elem(struct bpf_map *map, void *key,
> > >
> > >         bpf_task_storage_lock();
> > >         sdata = bpf_local_storage_update(
> > > -               task, (struct bpf_local_storage_map *)map, value, map_flags);
> > > +               task, (struct bpf_local_storage_map *)map, value, map_flags,
> > > +               GFP_ATOMIC);
> > >         bpf_task_storage_unlock();
> > >
> > >         err = PTR_ERR_OR_ZERO(sdata);
> > > @@ -226,8 +227,9 @@ static int bpf_pid_task_storage_delete_elem(struct bpf_map *map, void *key)
> > >         return err;
> > >  }
> > >
> > > -BPF_CALL_4(bpf_task_storage_get, struct bpf_map *, map, struct task_struct *,
> > > -          task, void *, value, u64, flags)
> > > +/* *mem_flags* is set by the bpf verifier */
> >
> > Is there a precedence of this happening for any other helpers?
> Kumar has also mentioned the timer helper.
>
> >
> > You may want to add here that "any value, even if set by uapi, will be ignored"

I guess this comment is still helpful if a user is not using the
bpf_helpers header
generated from the uapi doc strings?

> >
> > Can we go even beyond this and ensure that the verifier understands
> > that this is an
> > "internal only arg" something in check_helper_call?
> The compiler is free to store anything in R5 before calling the helper, so
> verifier cannot enforce it is unused or not, and the verifier does not have to.

Thanks Kumar and Martin.

>
> >
> > > +BPF_CALL_5(bpf_task_storage_get, struct bpf_map *, map, struct task_struct *,
> > > +          task, void *, value, u64, flags, gfp_t, mem_flags)
> > >  {
> > >         struct bpf_local_storage_data *sdata;
> > >
> > > @@ -250,7 +252,7 @@ BPF_CALL_4(bpf_task_storage_get, struct bpf_map *, map, struct task_struct *,
> > >             (flags & BPF_LOCAL_STORAGE_GET_F_CREATE))
> > >                 sdata = bpf_local_storage_update(
> > >                         task, (struct bpf_local_storage_map *)map, value,
> > > -                       BPF_NOEXIST);
> > > +                       BPF_NOEXIST, mem_flags);
> > >
> > >  unlock:
> > >         bpf_task_storage_unlock();
