Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17CB6EF996
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 19:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbjDZRrI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Apr 2023 13:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234916AbjDZRrH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Apr 2023 13:47:07 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70D91FDE
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 10:47:04 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5069097bac7so13152936a12.0
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 10:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682531223; x=1685123223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DRb0Mucb5wwLPh+dkCap/xkaK3FnlNEVUgtVybH7xUk=;
        b=bw0dDyt+uOzn2juDFskvXjavtIVgm54tDIHrA1eWzsJR6G5n+OHhz82Bt0Ci5662Eq
         5xvwq3RVoKTDY3GK3b2SBBw2B5ObLvIsAcLpjK8VSORp+CO7anrYgxbfreFQ7SKvIRAx
         i8XRaMqVSETEMs2/Fiwncq2Pu2gH5+77ZrctSnsBpjGt/vXUg550ol0pJMpiGMWeIe5G
         DufePWWqxFoSHEkK9I0TQVvHoSUfGGwTwGNUkaa4YO/REu88Ng/Qh6YAj2cRSbHjoqh2
         mhiS6c/fYd19DNedsxmF4aJxQywoF40TNosjx/9Xf+8C7ELmGyaYCinVogZmNvCTL5MZ
         v2+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682531223; x=1685123223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DRb0Mucb5wwLPh+dkCap/xkaK3FnlNEVUgtVybH7xUk=;
        b=gmDbuwYTtnzz/a0sPNgSWGwbONV5UG28BxgI62fXwze7tlhkS6O9r5sDUauut1/9+H
         CK4/9ao7FB5KA67sT4coyun5Z6loMqcmK11BU0d+dOwY+BNhAI3yShSaUc5NvWdgk0NF
         mZ7Q09sgEcMX4ajFzfwHmemnGwphAGJWv6EjUkmGsT7zjPnU8hr8KNWwJyfOwq8z6EbR
         knASbcYQmzt3AnOEVnpwFeGxjWICX7dKQHbXXPbOqgyss8NAQBwyJDYimW8DCxABc+Jc
         gvxLV6xHP12+KvLuUX2suhU5nh/B1YHJ9pO9ZsIfwXiH6hawm3LOXKvPQYijshK1jxrI
         reRA==
X-Gm-Message-State: AC+VfDxulu6PF8VxfXkZfK/D8yrCv0vi/3RpfNdS+7HiUpb2jPmccM5j
        Sg5ZJkqjGyfkkePlLjUrcDNw/Vu3HacF+ZKT0vK5NlsX
X-Google-Smtp-Source: ACHHUZ6WkY6D5ixNY1c7w6S8d/3CnHl0Qlg8QZZIU/AFndh6dEGe5I6ei82M4KVa32uvUSmzOExyPKP9i7GiApAXzPg=
X-Received: by 2002:a05:6402:40f:b0:509:f221:cee2 with SMTP id
 q15-20020a056402040f00b00509f221cee2mr5709586edv.32.1682531223041; Wed, 26
 Apr 2023 10:47:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230420071414.570108-1-joannelkoong@gmail.com>
 <20230420071414.570108-2-joannelkoong@gmail.com> <6446dca6c74fd_389cc208e3@john.notmuch>
 <CAJnrk1aVu8Jo8LBsu8_dyVe6uFWR7BWpyQMuR-QkfT03uVie7A@mail.gmail.com>
In-Reply-To: <CAJnrk1aVu8Jo8LBsu8_dyVe6uFWR7BWpyQMuR-QkfT03uVie7A@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 26 Apr 2023 10:46:51 -0700
Message-ID: <CAEf4BzbA3DvsQgsgkWnrHUXOnFuL-doVqe2_Yo0=NQDTn5HgKQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/5] bpf: Add bpf_dynptr_adjust
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org,
        andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net
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

On Mon, Apr 24, 2023 at 10:29=E2=80=AFPM Joanne Koong <joannelkoong@gmail.c=
om> wrote:
>
> On Mon, Apr 24, 2023 at 12:46=E2=80=AFPM John Fastabend
> <john.fastabend@gmail.com> wrote:
> >
> > Joanne Koong wrote:
> > > Add a new kfunc
> > >
> > > int bpf_dynptr_adjust(struct bpf_dynptr_kern *ptr, u32 start, u32 end=
);
> > >
> > > which adjusts the dynptr to reflect the new [start, end) interval.
> > > In particular, it advances the offset of the dynptr by "start" bytes,
> > > and if end is less than the size of the dynptr, then this will trim t=
he
> > > dynptr accordingly.
> > >
> > > Adjusting the dynptr interval may be useful in certain situations.
> > > For example, when hashing which takes in generic dynptrs, if the dynp=
tr
> > > points to a struct but only a certain memory region inside the struct
> > > should be hashed, adjust can be used to narrow in on the
> > > specific region to hash.
> >
> > Would you want to prohibit creating an empty dynptr with [start, start)=
?
>
> I'm open to either :) I don't reallysee a use case for creating an
> empty dynptr, but I think the concept of an empty dynptr might be
> useful in general, so maybe we should let this be okay as well?

Yes, there is no need to artificially enforce a non-empty range. We
already use pointers to zero-sized memory region in verifier (e.g.,
Alexei's recent kfunc existence check changes). In general, empty
range is a valid range and we should strive to have that working
without assumptions on who and how would use that. As long as it's
conceptually safe, we should support it.

>
> >
> > >
> > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > ---
> > >  kernel/bpf/helpers.c | 26 ++++++++++++++++++++++++++
> > >  1 file changed, 26 insertions(+)
> > >
> > > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > > index 00e5fb0682ac..7ddf63ac93ce 100644
> > > --- a/kernel/bpf/helpers.c
> > > +++ b/kernel/bpf/helpers.c
> > > @@ -1448,6 +1448,13 @@ u32 bpf_dynptr_get_size(const struct bpf_dynpt=
r_kern *ptr)
> > >       return ptr->size & DYNPTR_SIZE_MASK;
> > >  }
> > >
> > > +static void bpf_dynptr_set_size(struct bpf_dynptr_kern *ptr, u32 new=
_size)
> > > +{
> > > +     u32 metadata =3D ptr->size & ~DYNPTR_SIZE_MASK;
> > > +
> > > +     ptr->size =3D new_size | metadata;
> > > +}
> > > +
> > >  int bpf_dynptr_check_size(u32 size)
> > >  {
> > >       return size > DYNPTR_MAX_SIZE ? -E2BIG : 0;
> > > @@ -2297,6 +2304,24 @@ __bpf_kfunc void *bpf_dynptr_slice_rdwr(const =
struct bpf_dynptr_kern *ptr, u32 o
> > >       return bpf_dynptr_slice(ptr, offset, buffer, buffer__szk);
> > >  }
> > >
> > > +__bpf_kfunc int bpf_dynptr_adjust(struct bpf_dynptr_kern *ptr, u32 s=
tart, u32 end)
> > > +{
> > > +     u32 size;
> > > +
> > > +     if (!ptr->data || start > end)
> > > +             return -EINVAL;
> > > +
> > > +     size =3D bpf_dynptr_get_size(ptr);
> > > +
> > > +     if (start > size || end > size)
> > > +             return -ERANGE;
> >
> > maybe 'start >=3D size'? OTOH if the verifier doesn't mind I guess its =
OK
> > to create the thing even if it doesn't make much sense.
>
> I think there might be use cases where this is useful even though the
> zero-sized dynptr can't do anything. for example, if there's a helper
> function in a program that takes in a dynptr, parses some fixed-size
> chunk of its data, and then advances it, it might be useful to have
> the concept of a zero-sized dynptr, so that if we're parsing the last
> chunk of the data, then the last call to bpf_dynptr_adjust() will
> still succeed and the dynptr will be of size 0, which signals
> completion.
>

+1, empty range does happen in practice naturally, and having to
special-case them is a hindrance. Let's keep it possible.

> >
> > > +
> > > +     ptr->offset +=3D start;
> > > +     bpf_dynptr_set_size(ptr, end - start);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > >  __bpf_kfunc void *bpf_cast_to_kern_ctx(void *obj)
> > >  {
> > >       return obj;
> > > @@ -2369,6 +2394,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_slice_rdwr, KF_RE=
T_NULL)
> > >  BTF_ID_FLAGS(func, bpf_iter_num_new, KF_ITER_NEW)
> > >  BTF_ID_FLAGS(func, bpf_iter_num_next, KF_ITER_NEXT | KF_RET_NULL)
> > >  BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DESTROY)
> > > +BTF_ID_FLAGS(func, bpf_dynptr_adjust)
> > >  BTF_SET8_END(common_btf_ids)
> > >
> > >  static const struct btf_kfunc_id_set common_kfunc_set =3D {
> > > --
> > > 2.34.1
> > >
