Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0AE76E0124
	for <lists+bpf@lfdr.de>; Wed, 12 Apr 2023 23:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjDLVqk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 17:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDLVqj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 17:46:39 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5577A1FD2
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 14:46:38 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-504dfc87927so1270069a12.0
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 14:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681335997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/OHoFvHjhbqtibvsnDtEQaNSPla3K5z0BS1MJj2olM4=;
        b=Ojc1D+CFUcsiLN6DKSCZB75GbRN7J8aG2jSRwPk9vpoISxG7KOeEvr92i5yr9Dr2Ce
         bhvOPZYsPDc9sGukDjy5Ca1JWtqDuVqn6pKtj/ngOTYU826iK1yD/vSgNXEsiVDzeE14
         8GrUXHsDuT4P4q6T8lZCc1ywpjybQt2i1mVPHoU8j8RQeFQ3F11YCt3yCucfU6KhKF8i
         JhGUx4eAmwCEaJ1LFMpn4UfxzQ5UcPZ7tbp1xk9YgbtNECqQ9eyhXhPWONvwpqWzhipi
         p5NYK23d4XDg1LmqcFB2MPt4O1W+C6GeOWURJC4kmoj8+TunRBF7e1FPSnggFEgtNQxW
         5/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681335997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/OHoFvHjhbqtibvsnDtEQaNSPla3K5z0BS1MJj2olM4=;
        b=S8HXhQFPfIH/Dr4hwRuG+TccXS/yCZ0wRPk6qtmvfahx+P/HiHCLVcDuebCf5kqX64
         b10ezXRYKNe1uHUXL+UKdSC36TqfN7Xll3PUvDvQJkwgePjW1b0DoDUOJILDfqoHQlau
         hyx3vR4EalQ57f7XEmQlQglsiN/LC8D3jTy+d6XDRhmSmLEQEIj0U2OD6ItSebpTBYHG
         +S8BRynDc47NUt5J9LnpGDqly8Qq2oNi68aIu3d8zp4uIlQSdd19TTX0nJY1UecdJ7Ou
         S8l8rvryVgg17NHo5IrkT+UH/vBtPj7AUQmg2oQZAoU8VlDXKNrkZW1s6qNVUICtSwtJ
         dLfg==
X-Gm-Message-State: AAQBX9eEXdpbi1zB7VIbErK2M7SD8q2oxDHaUEHk8LDhb/4H8Zbijj2a
        cxJCxXEpD9l85UXySu1mVPa/aof/MJUiZZKSZEg=
X-Google-Smtp-Source: AKy350brBd9hakCX7UpMRfXh3vWIVMZjnQ4XUPab3Q11aW8QLoE39TD/xUEgoyJ1eDOEP34PzI41k+jntzH+XslG11k=
X-Received: by 2002:a50:d783:0:b0:505:3be:1bf4 with SMTP id
 w3-20020a50d783000000b0050503be1bf4mr97215edi.1.1681335996667; Wed, 12 Apr
 2023 14:46:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230409033431.3992432-1-joannelkoong@gmail.com> <20230409033431.3992432-2-joannelkoong@gmail.com>
In-Reply-To: <20230409033431.3992432-2-joannelkoong@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 12 Apr 2023 14:46:24 -0700
Message-ID: <CAEf4BzYJ7UoUW2dOiHf617J2hP0FwugKdBBqURdPUrs1hjtaZw@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 1/5] bpf: Add bpf_dynptr_trim and bpf_dynptr_advance
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
        daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Apr 8, 2023 at 8:34=E2=80=AFPM Joanne Koong <joannelkoong@gmail.com=
> wrote:
>
> bpf_dynptr_trim decreases the size of a dynptr by the specified
> number of bytes (offset remains the same). bpf_dynptr_advance advances
> the offset of the dynptr by the specified number of bytes (size
> decreases correspondingly).
>
> Trimming or advancing the dynptr may be useful in certain situations.
> For example, when hashing which takes in generic dynptrs, if the dynptr
> points to a struct but only a certain memory region inside the struct
> should be hashed, advance/trim can be used to narrow in on the
> specific region to hash.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  kernel/bpf/helpers.c | 49 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index b6a5cda5bb59..51b4c4b5dbed 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1448,6 +1448,13 @@ u32 bpf_dynptr_get_size(const struct bpf_dynptr_ke=
rn *ptr)
>         return ptr->size & DYNPTR_SIZE_MASK;
>  }
>
> +static void bpf_dynptr_set_size(struct bpf_dynptr_kern *ptr, u32 new_siz=
e)
> +{
> +       u32 metadata =3D ptr->size & ~DYNPTR_SIZE_MASK;
> +
> +       ptr->size =3D new_size | metadata;
> +}
> +
>  int bpf_dynptr_check_size(u32 size)
>  {
>         return size > DYNPTR_MAX_SIZE ? -E2BIG : 0;
> @@ -2275,6 +2282,46 @@ __bpf_kfunc void *bpf_dynptr_slice_rdwr(const stru=
ct bpf_dynptr_kern *ptr, u32 o
>         return bpf_dynptr_slice(ptr, offset, buffer, buffer__szk);
>  }
>
> +/* For dynptrs, the offset may only be advanced and the size may only be=
 decremented */
> +static int bpf_dynptr_adjust(struct bpf_dynptr_kern *ptr, u32 off_inc, u=
32 sz_dec)

it feels like this helper just makes it a bit harder to follow what's
going on. Half of this function isn't actually executed for
bpf_dynptr_trim, so I don't think we are saving all that much code,
maybe let's code each of advance and trim explicitly?

> +{
> +       u32 size;
> +
> +       if (!ptr->data)
> +               return -EINVAL;
> +
> +       size =3D bpf_dynptr_get_size(ptr);
> +
> +       if (sz_dec > size)
> +               return -ERANGE;
> +
> +       if (off_inc) {
> +               u32 new_off;
> +
> +               if (off_inc > size)

like here it becomes confusing if off_inc includes sz_dec, or they
should be added to each other. I think it's convoluted as is.


> +                       return -ERANGE;
> +
> +               if (check_add_overflow(ptr->offset, off_inc, &new_off))

why do we need to worry about overflow, we checked all the error
conditions above?..

> +                       return -ERANGE;
> +
> +               ptr->offset =3D new_off;
> +       }
> +
> +       bpf_dynptr_set_size(ptr, size - sz_dec);
> +
> +       return 0;
> +}
> +
> +__bpf_kfunc int bpf_dynptr_advance(struct bpf_dynptr_kern *ptr, u32 len)
> +{
> +       return bpf_dynptr_adjust(ptr, len, len);
> +}
> +
> +__bpf_kfunc int bpf_dynptr_trim(struct bpf_dynptr_kern *ptr, u32 len)

I'm also wondering if trim operation is a bit unusual for dealing
ranges? Instead of a relative size decrement, maybe it's more
straightforward to have bpf_dynptr_resize() to set new desired size?
So if someone has original dynptr with 100 bytes but wants to have
dynptr for bytes [10, 30), they'd do a pretty natural:

bpf_dynptr_advance(&dynptr, 10);
bpf_dynptr_resize(&dynptr, 20);

?

> +{
> +       return bpf_dynptr_adjust(ptr, 0, len);
> +}
> +
>  __bpf_kfunc void *bpf_cast_to_kern_ctx(void *obj)
>  {
>         return obj;
> @@ -2347,6 +2394,8 @@ BTF_ID_FLAGS(func, bpf_dynptr_slice_rdwr, KF_RET_NU=
LL)
>  BTF_ID_FLAGS(func, bpf_iter_num_new, KF_ITER_NEW)
>  BTF_ID_FLAGS(func, bpf_iter_num_next, KF_ITER_NEXT | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DESTROY)
> +BTF_ID_FLAGS(func, bpf_dynptr_trim)
> +BTF_ID_FLAGS(func, bpf_dynptr_advance)
>  BTF_SET8_END(common_btf_ids)
>
>  static const struct btf_kfunc_id_set common_kfunc_set =3D {
> --
> 2.34.1
>
