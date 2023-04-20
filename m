Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D829C6E8A99
	for <lists+bpf@lfdr.de>; Thu, 20 Apr 2023 08:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbjDTGpc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Apr 2023 02:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbjDTGpb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Apr 2023 02:45:31 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BF8272D
        for <bpf@vger.kernel.org>; Wed, 19 Apr 2023 23:45:28 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id t15so1613128ybb.1
        for <bpf@vger.kernel.org>; Wed, 19 Apr 2023 23:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681973128; x=1684565128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FjmVOB9Fu0y6ipLQl7qPD5QOgaBMqIWI8n92Ln78HNw=;
        b=HO6/oknLET6MgmlsusxcUHAL/28gG43/E5bk4uunLtkN87tOslVlw17A9WMN7Sa2Hb
         dBlNIG5IRHj0PFqWvW/0Uu208ZN7mNTXvI4UrpICxMftfAlrhtiKk+vQYbUWmlnA7yiw
         s//5rJncBNEauF5JXNCeqPAYjytEMV4oxa8kQDb/Je98g/E6NifOEvkWclA0cG7m4/AN
         iRVAYY9FiZk+pSrXTodsAVArBR1QSZIuoQ+OUZQgw2fXLoYf+qBgPjzsC7iRQxLRMok3
         XClnTOGWLELiujHZeTpnIlR0yeoE13i+pJbAge6B2Bz+UmUpeMmCm1VFIJkr01u6ZFGZ
         dinQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681973128; x=1684565128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FjmVOB9Fu0y6ipLQl7qPD5QOgaBMqIWI8n92Ln78HNw=;
        b=R6AUcMN1QVtXreym+zmEgJMMsK8qMr+u85q3NnT3m769+538Q8KLc6Tw0UDjIGtX/E
         gI69Z7ghAHfzKVPwvHN6md0VjtsDJdRSRuH/Y8mmj5vcdC9HyQE2xhqCUZOQsCWsyLaY
         JwbSz25zTTaDI0tc/daJlXUGO/hs05xkAQGKeoCj5jYngz8O1BF7D132iB1tH2hwxN1m
         yJoJrCVXffaHnq7ZJt/ZyT1H397ofw5TUsz89g2GGqRxzhHuvy5RvZ9O/3B3mkiOLMFZ
         SQPnjpYhqa+WAU3Rti4k5Mmd7zW+rkdUkQIfKCGQLUUgpvCJIc0c126b45DHtP8GSrxV
         9Pvw==
X-Gm-Message-State: AAQBX9dRJgG9Fd44MPxbHLvmTCMMAFlyuE3cVdOq6qndA9AiV5HI0ucD
        mcL3v6DqOM55ja6a1ekM9Adm2ip4GiRcTTkpDmI=
X-Google-Smtp-Source: AKy350YdChXguDyJWHsSPb7jaAAy8HhC5/QIQc3k14s1nnYUr/YzE1kQny7Vx41bmItM91D7S8u4ZQqqdz/fNXoYe+c=
X-Received: by 2002:a25:cc57:0:b0:b96:3344:c211 with SMTP id
 l84-20020a25cc57000000b00b963344c211mr387856ybf.10.1681973128119; Wed, 19 Apr
 2023 23:45:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230409033431.3992432-1-joannelkoong@gmail.com>
 <20230409033431.3992432-3-joannelkoong@gmail.com> <CAEf4BzahPnJ08-eqh2S_jZ+wca4-DCq5JjFKQOAfgb+oYRqdkg@mail.gmail.com>
In-Reply-To: <CAEf4BzahPnJ08-eqh2S_jZ+wca4-DCq5JjFKQOAfgb+oYRqdkg@mail.gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Wed, 19 Apr 2023 23:45:17 -0700
Message-ID: <CAJnrk1bvC6Zp2y=9TVAyz5nmQ=+7CO9PhEfPbwawVid6mcrrEQ@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 2/5] bpf: Add bpf_dynptr_is_null and bpf_dynptr_is_rdonly
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
        daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 12, 2023 at 2:50=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sat, Apr 8, 2023 at 8:34=E2=80=AFPM Joanne Koong <joannelkoong@gmail.c=
om> wrote:
> >
> > bpf_dynptr_is_null returns true if the dynptr is null / invalid
> > (determined by whether ptr->data is NULL), else false if
> > the dynptr is a valid dynptr.
> >
> > bpf_dynptr_is_rdonly returns true if the dynptr is read-only,
> > else false if the dynptr is read-writable.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  kernel/bpf/helpers.c | 23 +++++++++++++++++++----
> >  1 file changed, 19 insertions(+), 4 deletions(-)
> >
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 51b4c4b5dbed..e4e84e92a4c6 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -1423,7 +1423,7 @@ static const struct bpf_func_proto bpf_kptr_xchg_=
proto =3D {
> >  #define DYNPTR_SIZE_MASK       0xFFFFFF
> >  #define DYNPTR_RDONLY_BIT      BIT(31)
> >
> > -static bool bpf_dynptr_is_rdonly(const struct bpf_dynptr_kern *ptr)
> > +static bool __bpf_dynptr_is_rdonly(const struct bpf_dynptr_kern *ptr)
> >  {
> >         return ptr->size & DYNPTR_RDONLY_BIT;
> >  }
> > @@ -1570,7 +1570,7 @@ BPF_CALL_5(bpf_dynptr_write, const struct bpf_dyn=
ptr_kern *, dst, u32, offset, v
> >         enum bpf_dynptr_type type;
> >         int err;
> >
> > -       if (!dst->data || bpf_dynptr_is_rdonly(dst))
> > +       if (!dst->data || __bpf_dynptr_is_rdonly(dst))
> >                 return -EINVAL;
> >
> >         err =3D bpf_dynptr_check_off_len(dst, offset, len);
> > @@ -1626,7 +1626,7 @@ BPF_CALL_3(bpf_dynptr_data, const struct bpf_dynp=
tr_kern *, ptr, u32, offset, u3
> >         if (err)
> >                 return 0;
> >
> > -       if (bpf_dynptr_is_rdonly(ptr))
> > +       if (__bpf_dynptr_is_rdonly(ptr))
> >                 return 0;
> >
> >         type =3D bpf_dynptr_get_type(ptr);
> > @@ -2254,7 +2254,7 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct b=
pf_dynptr_kern *ptr, u32 offset
> >  __bpf_kfunc void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr_kern *=
ptr, u32 offset,
> >                                         void *buffer, u32 buffer__szk)
> >  {
> > -       if (!ptr->data || bpf_dynptr_is_rdonly(ptr))
> > +       if (!ptr->data || __bpf_dynptr_is_rdonly(ptr))
>
> seems like all the uses of __bpf_dynptr_is_rdonly check !ptr->data
> explicitly, so maybe move that ptr->data check inside and simplify all
> the callers?

i think combining it gets confusing in the case where ptr->data is
null, as to how the invoked places interpret the return value. I think
having the check spelled out more explicitly in the invoked places (eg
bpf_dynptr_write, bpf_dynptr_data, ...) makes it more clear as well
where the check for null is happening. for v2 I will leave this as is,
but also happy to change it if you prefer the two be combined

>
> Regardless, looks good:
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>
> >                 return NULL;
> >
> >         /* bpf_dynptr_slice_rdwr is the same logic as bpf_dynptr_slice.
> > @@ -2322,6 +2322,19 @@ __bpf_kfunc int bpf_dynptr_trim(struct bpf_dynpt=
r_kern *ptr, u32 len)
> >         return bpf_dynptr_adjust(ptr, 0, len);
> >  }
> >
> > +__bpf_kfunc bool bpf_dynptr_is_null(struct bpf_dynptr_kern *ptr)
> > +{
> > +       return !ptr->data;
> > +}
> > +
> > +__bpf_kfunc bool bpf_dynptr_is_rdonly(struct bpf_dynptr_kern *ptr)
> > +{
> > +       if (!ptr->data)
> > +               return false;
> > +
> > +       return __bpf_dynptr_is_rdonly(ptr);
> > +}
> > +
> >  __bpf_kfunc void *bpf_cast_to_kern_ctx(void *obj)
> >  {
> >         return obj;
> > @@ -2396,6 +2409,8 @@ BTF_ID_FLAGS(func, bpf_iter_num_next, KF_ITER_NEX=
T | KF_RET_NULL)
> >  BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DESTROY)
> >  BTF_ID_FLAGS(func, bpf_dynptr_trim)
> >  BTF_ID_FLAGS(func, bpf_dynptr_advance)
> > +BTF_ID_FLAGS(func, bpf_dynptr_is_null)
> > +BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
> >  BTF_SET8_END(common_btf_ids)
> >
> >  static const struct btf_kfunc_id_set common_kfunc_set =3D {
> > --
> > 2.34.1
> >
