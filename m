Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18B76C6E31
	for <lists+bpf@lfdr.de>; Thu, 23 Mar 2023 17:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjCWQ5N (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Mar 2023 12:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjCWQ5M (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Mar 2023 12:57:12 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8B2B5
        for <bpf@vger.kernel.org>; Thu, 23 Mar 2023 09:57:11 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id eh3so89648798edb.11
        for <bpf@vger.kernel.org>; Thu, 23 Mar 2023 09:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679590630;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1UiNcgKJk5Ockh0QkEB7yiupoKT+uowmNc0GqeUY4nw=;
        b=eBS0GNOIdciOY3L+hDDfePLD9olXKtMhZzV0HxrR2DuOh4NIL056ve4psI2Od7BXkJ
         MPTE2qmaUFio4vB9xWxX0DnZ+r8jss8SrnpNKb/WM3Wd5QScK8E8HDMqhbL7Ez+KhxxM
         sB/xca6m7P8q5a3m8Jl8PPikw+XHvXav2/IKijp/pynKT7S1cEGpvabkJ10dZSYqkX2t
         ENZFg6mmOH6WdW90rdVEC9WqlE0U5DaGZbZ1GPeYpu1w2YCs7kT/zWCIzPUfsMfpeWsD
         Qscrmoet1hytgL6/hkRagD2Fy2iy6sQChhxPGJ9pg+EI2YLzIRouOtBn2Npopp2/nlaT
         XmeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679590630;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1UiNcgKJk5Ockh0QkEB7yiupoKT+uowmNc0GqeUY4nw=;
        b=lPrPZW7T4pUU4Q+5Rpkz+92KmiMmRfCAyNxde/8Ty70EmWZX5k+tji0DEWq7baZRIo
         8ZF+xVXEweymwgLTCxkLq9INPhb0rREaN8rB6eQecvl2NkVQ2lkjc7WykEJFu05sOFlx
         TYqstd/MRTkyIklbFZWuv8ZmkXAlBLmJaNgOvQcl90372oGWoKMAixTVbyJ7cfhX+s2E
         b8ufVngH4GVaJu2SZhW+gPHTQGtCisY66iYb54nsjQUbouIoAWyVyeG+IGo2t9A13jNh
         PvFIVSj/9B2ZALpPt6X82M40v2HMM4t/qObttspT37dgeD16hQSxR+TZGptyUYQLsOdt
         AL3w==
X-Gm-Message-State: AO0yUKWnRjxO3HJ/mZMFWySMySBdWDeqY/l8b/MhIkDZaNmFJRiYAnom
        E+Gn1JYGxZBow2BAs01YExVT8SLqOmo=
X-Google-Smtp-Source: AK7set+z6HhCWQ7e35TdAeSqhCJfUZe8nQN01HTyi8Xke/XGEkTIKD0zXoyWgUjlc4+6apvyvd/Cvg==
X-Received: by 2002:a05:6402:1c95:b0:4af:7bdc:188e with SMTP id cy21-20020a0564021c9500b004af7bdc188emr6847737edb.16.1679590629782;
        Thu, 23 Mar 2023 09:57:09 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id q28-20020a50aa9c000000b004fb556e905fsm9442715edc.49.2023.03.23.09.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 09:57:08 -0700 (PDT)
Message-ID: <9ee3c62518ec9fc3aa72c4b59a997cda17acc376.camel@gmail.com>
Subject: Re: GCC-BPF triggers double free in libbpf Error: failed to link
 'linked_maps2.bpf.o': Cannot allocate memory (12)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     James Hilliard <james.hilliard1@gmail.com>,
        bpf <bpf@vger.kernel.org>
Date:   Thu, 23 Mar 2023 18:57:07 +0200
In-Reply-To: <CAEf4BzZ-x4U5NM7wsCcuESGXkoBbf_pk3CwJzA+gsj=WLwHSkQ@mail.gmail.com>
References: <CADvTj4o7ZWUikKwNTwFq0O_AaX+46t_+Ca9gvWMYdWdRtTGeHQ@mail.gmail.com>
         <CAEf4BzbEaTbEn1j9vLtmS1-8uJf0Bz-8wfmZj8N4Mmedt29nag@mail.gmail.com>
         <c55f31dc3ae7e346e2a6d16d3e467e5460346b91.camel@gmail.com>
         <CAEf4BzZ-x4U5NM7wsCcuESGXkoBbf_pk3CwJzA+gsj=WLwHSkQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2023-03-23 at 09:36 -0700, Andrii Nakryiko wrote:
[...]
> >=20
> > The documentation says that `realloc(ptr, 0)` frees `ptr`.
> > So, I assume that issue is caused by handling of empty sections.
>=20
> yep, thanks for repro steps! It's a quite interesting behavior. There
> are two reallocs involved:
>=20
> First, dst->raw_data is NULL, dst_final_sz is 0, realloc succeeds and
> returns non-NULL pointer (which according to documentation can be
> freed with free()). All good.
>=20
> Second one, for second file, we have non-NULL dst->raw_data returned
> from previous realloc(), we pass it to realloc() with dst_final_sz
> still 0. But *NOW* we get NULL as a return (and original special
> pointer "helpfully" freed for us). This we handle as -ENOMEM and exit.
>=20
> Amazingly non-error-prone behavior, of course.

Yep, a surprising behavior.
Can't find any historical context on why this was the choice.

>=20
> > This is easy to test using object files produced by LLVM:
> >=20
> >   $ touch empty
> >   $ llvm-objcopy --add-section .foobar=3Dempty linked_maps1.bpf.o
> >   $ llvm-objcopy --add-section .foobar=3Dempty linked_maps2.bpf.o
> >   $ bpftool --debug gen object linked_maps.linked1.o linked_maps1.bpf.o=
 linked_maps2.bpf.o
> >   libbpf: linker: adding object file 'linked_maps1.bpf.o'...
> >   libbpf: linker: adding object file 'linked_maps2.bpf.o'...
> >   Error: failed to link 'linked_maps2.bpf.o': Cannot allocate memory (1=
2)
> >   free(): double free detected in tcache 2
> >   Aborted (core dumped)
> >=20
> > The valgrind output also matches the one attached to the original email=
.
> > Something like below fixes it:
> >=20
> > diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
> > index d7069780984a..ff3833e55c55 100644
> > --- a/tools/lib/bpf/linker.c
> > +++ b/tools/lib/bpf/linker.c
> > @@ -1113,7 +1113,7 @@ static int extend_sec(struct bpf_linker *linker, =
struct dst_sec *dst, struct src
> >         /* no need to re-align final size */
> >         dst_final_sz =3D dst_align_sz + src->shdr->sh_size;
> >=20
> > -       if (src->shdr->sh_type !=3D SHT_NOBITS) {
> > +       if (dst_final_sz !=3D 0 && src->shdr->sh_type !=3D SHT_NOBITS) =
{
> >                 tmp =3D realloc(dst->raw_data, dst_final_sz);
> >                 if (!tmp)
>=20
> let's maybe document this quirk instead of preventing realloc() call:
>=20
> /* comment here explaining the quirks of realloc() API and it's
> inconsistent runtime behavior */
> if (!tmp && dst_final_sz > 0)
>   return -ENOMEM;

Agree.

>=20
> Eduard, are you going to send a proper patch for this? Thanks!

Will do, need to figure out how to encode the test case within selftests.
Still, would be good if James can confirm that the issue is fixed on his si=
de.

>=20
> >                         return -ENOMEM;
> >=20
> >=20
> > BPF selftests are passing for me with this change,
> > objcopy-based reproducer no longer reports error.
> > WDYT?
> >=20
> > James, could you please test this patch with bpf-gcc?
> > (you will have to re-compile libbpf and bpftool,
> >  I had to separately do `make -C tools/bpf/bpftool`
> >  before re-building selftests for some reason)
> >=20
> > Thanks,
> > Eduard
> >=20
[...]
