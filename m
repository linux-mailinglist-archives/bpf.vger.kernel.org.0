Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4EE6C6EB4
	for <lists+bpf@lfdr.de>; Thu, 23 Mar 2023 18:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjCWRYD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Mar 2023 13:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbjCWRYC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Mar 2023 13:24:02 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5420329168
        for <bpf@vger.kernel.org>; Thu, 23 Mar 2023 10:23:43 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id r11so90006774edd.5
        for <bpf@vger.kernel.org>; Thu, 23 Mar 2023 10:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679592222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=todo6HuqQZot5Mfc8z7RptIc3RxhtmWvSh9+mq+TaPM=;
        b=qR0PF+IHsgw7tcf6e0K6I1cAEtzkfthkj4HD91OCuHPGEmqMX84Q86uhdO/v9mkH7V
         tmw9AppfCL4uNabXEq/84DJTvbG5km0I/OZ8c8KKMSCo++tk57RudL+JRN9+9uLaqz0o
         Jrk6y8JlRczs0awiyYBC5UFY5rsZRcidxlvwKRcVylO/dFjc3MdDC6+JMmvSEv4WtY5R
         5q9rU7lxxX4kNFF0TLS+xMqRtGrlKz0g51KH2S8vADsV1INFHYd0Tfx5EmF1DUQtFDlc
         MAT/H2MmjEpe6r4/RZZybtkztOAZ3GrDWw46W1WU8nSnpSRhwgW0tHB98AQftF4RSE+T
         H20g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679592222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=todo6HuqQZot5Mfc8z7RptIc3RxhtmWvSh9+mq+TaPM=;
        b=GjCNNdAfYn5eNlZfgQjWnMH0f+byIQtka97PNx+fd8NONNKcUf01MhkpmOqdmEZ2vn
         p0hvONOJXB2IihMTu2kFWjzFVU4vk3YHNbD/hCwNstvmGPqTVpaJDYm46Gw3JjWF83an
         32jpyvSIbWlE8RpFqolQ+D5xsx8yNWySFXCDMfW5hPHkgtTS3nsptmhyWspa+vzK5gYN
         nfQrPfd8nSML6A61zAOtudx38XhndICz1op1t2Uw8QYGNhSVJadccbruw0oqGSHkTBoR
         J+rRMLyIhgvnlMGPgyV8IQ1WPXgapnRMkM5kDQ3m+ZqIDzqgZMYnVyj5iUr1pNgOL+KO
         lANQ==
X-Gm-Message-State: AAQBX9eHuUvdmDvYc0UbAmqyUOUyLjubqALQ6chBBYmHUcrR4Xs39nxu
        +pai41ImQMBa9MabarwQ+hG7TB+EAIfLFgPgU+ULrviX
X-Google-Smtp-Source: AKy350YD7LZl6LYdGBUaU2HrclK1c2SylFsvGuO7HseEkE6bxhLDXN0UopTTyqw/4/6AsT5KLS6XJRITp4GNi805VDs=
X-Received: by 2002:a50:d694:0:b0:4fc:f0b8:7da0 with SMTP id
 r20-20020a50d694000000b004fcf0b87da0mr119374edi.1.1679592221645; Thu, 23 Mar
 2023 10:23:41 -0700 (PDT)
MIME-Version: 1.0
References: <CADvTj4o7ZWUikKwNTwFq0O_AaX+46t_+Ca9gvWMYdWdRtTGeHQ@mail.gmail.com>
 <CAEf4BzbEaTbEn1j9vLtmS1-8uJf0Bz-8wfmZj8N4Mmedt29nag@mail.gmail.com>
 <c55f31dc3ae7e346e2a6d16d3e467e5460346b91.camel@gmail.com>
 <CAEf4BzZ-x4U5NM7wsCcuESGXkoBbf_pk3CwJzA+gsj=WLwHSkQ@mail.gmail.com> <9ee3c62518ec9fc3aa72c4b59a997cda17acc376.camel@gmail.com>
In-Reply-To: <9ee3c62518ec9fc3aa72c4b59a997cda17acc376.camel@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 23 Mar 2023 10:23:29 -0700
Message-ID: <CAEf4BzaFaGtgq_UE5vJzS2bpBdX6wfDrokbg63B2KzyhmH1MYw@mail.gmail.com>
Subject: Re: GCC-BPF triggers double free in libbpf Error: failed to link
 'linked_maps2.bpf.o': Cannot allocate memory (12)
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     James Hilliard <james.hilliard1@gmail.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 23, 2023 at 9:57=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2023-03-23 at 09:36 -0700, Andrii Nakryiko wrote:
> [...]
> > >
> > > The documentation says that `realloc(ptr, 0)` frees `ptr`.
> > > So, I assume that issue is caused by handling of empty sections.
> >
> > yep, thanks for repro steps! It's a quite interesting behavior. There
> > are two reallocs involved:
> >
> > First, dst->raw_data is NULL, dst_final_sz is 0, realloc succeeds and
> > returns non-NULL pointer (which according to documentation can be
> > freed with free()). All good.
> >
> > Second one, for second file, we have non-NULL dst->raw_data returned
> > from previous realloc(), we pass it to realloc() with dst_final_sz
> > still 0. But *NOW* we get NULL as a return (and original special
> > pointer "helpfully" freed for us). This we handle as -ENOMEM and exit.
> >
> > Amazingly non-error-prone behavior, of course.
>
> Yep, a surprising behavior.
> Can't find any historical context on why this was the choice.
>
> >
> > > This is easy to test using object files produced by LLVM:
> > >
> > >   $ touch empty
> > >   $ llvm-objcopy --add-section .foobar=3Dempty linked_maps1.bpf.o
> > >   $ llvm-objcopy --add-section .foobar=3Dempty linked_maps2.bpf.o
> > >   $ bpftool --debug gen object linked_maps.linked1.o linked_maps1.bpf=
.o linked_maps2.bpf.o
> > >   libbpf: linker: adding object file 'linked_maps1.bpf.o'...
> > >   libbpf: linker: adding object file 'linked_maps2.bpf.o'...
> > >   Error: failed to link 'linked_maps2.bpf.o': Cannot allocate memory =
(12)
> > >   free(): double free detected in tcache 2
> > >   Aborted (core dumped)
> > >
> > > The valgrind output also matches the one attached to the original ema=
il.
> > > Something like below fixes it:
> > >
> > > diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
> > > index d7069780984a..ff3833e55c55 100644
> > > --- a/tools/lib/bpf/linker.c
> > > +++ b/tools/lib/bpf/linker.c
> > > @@ -1113,7 +1113,7 @@ static int extend_sec(struct bpf_linker *linker=
, struct dst_sec *dst, struct src
> > >         /* no need to re-align final size */
> > >         dst_final_sz =3D dst_align_sz + src->shdr->sh_size;
> > >
> > > -       if (src->shdr->sh_type !=3D SHT_NOBITS) {
> > > +       if (dst_final_sz !=3D 0 && src->shdr->sh_type !=3D SHT_NOBITS=
) {
> > >                 tmp =3D realloc(dst->raw_data, dst_final_sz);
> > >                 if (!tmp)
> >
> > let's maybe document this quirk instead of preventing realloc() call:
> >
> > /* comment here explaining the quirks of realloc() API and it's
> > inconsistent runtime behavior */
> > if (!tmp && dst_final_sz > 0)
> >   return -ENOMEM;
>
> Agree.
>
> >
> > Eduard, are you going to send a proper patch for this? Thanks!
>
> Will do, need to figure out how to encode the test case within selftests.

I think the fix is simple enough and the issue is understood enough
that it's fine to not bend over backwards just to simulate this
situation through more Makefile magic.

Though we can probably use a bit of asm directives to add an empty
section to linker tests.


> Still, would be good if James can confirm that the issue is fixed on his =
side.

+1

>
> >
> > >                         return -ENOMEM;
> > >
> > >
> > > BPF selftests are passing for me with this change,
> > > objcopy-based reproducer no longer reports error.
> > > WDYT?
> > >
> > > James, could you please test this patch with bpf-gcc?
> > > (you will have to re-compile libbpf and bpftool,
> > >  I had to separately do `make -C tools/bpf/bpftool`
> > >  before re-building selftests for some reason)
> > >
> > > Thanks,
> > > Eduard
> > >
> [...]
