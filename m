Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3735B6CB1F0
	for <lists+bpf@lfdr.de>; Tue, 28 Mar 2023 00:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjC0Wuo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Mar 2023 18:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjC0Wun (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Mar 2023 18:50:43 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48EF3212B
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 15:50:42 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id ek18so42453476edb.6
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 15:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679957440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GLnl8r9MyWkc/3OXrlx0PR1lNFDp+UojhRTHZ/rsZ+A=;
        b=gQ9Y8yPgT63nnia+F2kCqq1yUzxQXfKBVzIDlZq2J0NS9k0ZWO171W8OJgo/2Z7myE
         LE/P5ZqlcMe3CbTtH0JH15stROF+GETGooFlRmfGW5e0GgZlkQdP/XUMI2aisDBtpVdL
         SthO9DxsLozEc7jpSt6UulftsonloHsz/Vdx8aRchkg6pt2xgzYpAU8+E1SdpY9swcWj
         lkEXAKw7zHvPrgnQX0C/HTvUaKXkQQ9jhdLcFbIRIDO64UfY5OTiHFLIXbLtaA7efnQW
         8I2BE8miYIeBiS3KifABCTsjEYnMb+L4D41FmhQMA6QF4cDn5pqv5S/SLhrMHjC9UpIk
         yzXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679957440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GLnl8r9MyWkc/3OXrlx0PR1lNFDp+UojhRTHZ/rsZ+A=;
        b=IEGZGatM0LqDeXbZLnQNF7StUoe2+l3o7uk5Hjdqi3ftP6dF2Sku5fwmZaR6Wudal+
         b+imwhXumKUfjIW7yROCiTRUN7F64UORw2+AkLX/3ti50Ap3sgLCmhyL2joMoaak1ViI
         /90ob4+kvbsQDL0440MLV50iNFhcYBVa37S0RfAoYLA1W0KQ7K9EjAiMJf9NlgRaby4p
         4xZmYkjccW5Dl2+xTFyQk3JLzb1a8tgEd87Tm6/KZmNuXZq6TulfWgSG7EbMZCJ5prtf
         9IJ1HRP7ES7REEUaMDkkrbuMxVxmah04EHgacMzU/Q4EaESqkn+ETTEKLJtfFzmK5xR1
         uEcg==
X-Gm-Message-State: AAQBX9d2klyRJFKzSY9CmL+5twZXYuL/BvT+qWOhCoItC8asTr4j/NtX
        rYaavDg2Sf5aTLU3Dt8lOU1eE9bfZbXE1U/5oRXQpLJD
X-Google-Smtp-Source: AKy350bjdenrd4RyVdshiVWLFMWZCujJX9yJl4C00Pu1kMkG0mZCYoNDs9SaYrf4W7udIW5Ck2dYkNUPDeGmae6xM1c=
X-Received: by 2002:a50:d6c3:0:b0:501:d489:f797 with SMTP id
 l3-20020a50d6c3000000b00501d489f797mr6905661edj.1.1679957440198; Mon, 27 Mar
 2023 15:50:40 -0700 (PDT)
MIME-Version: 1.0
References: <CADvTj4o7ZWUikKwNTwFq0O_AaX+46t_+Ca9gvWMYdWdRtTGeHQ@mail.gmail.com>
 <CAEf4BzbEaTbEn1j9vLtmS1-8uJf0Bz-8wfmZj8N4Mmedt29nag@mail.gmail.com>
 <c55f31dc3ae7e346e2a6d16d3e467e5460346b91.camel@gmail.com>
 <CAEf4BzZ-x4U5NM7wsCcuESGXkoBbf_pk3CwJzA+gsj=WLwHSkQ@mail.gmail.com> <55da8c265fda2b45817ef70bdc57e4c2d168b74d.camel@gmail.com>
In-Reply-To: <55da8c265fda2b45817ef70bdc57e4c2d168b74d.camel@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 27 Mar 2023 15:50:28 -0700
Message-ID: <CAEf4BzYMrXrGs0MFTqN6yxjRby-ALDbeC1aMEFjdSHO_1AsOwA@mail.gmail.com>
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

On Mon, Mar 27, 2023 at 2:48=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2023-03-23 at 09:36 -0700, Andrii Nakryiko wrote:
> > On Thu, Mar 23, 2023 at 5:57=E2=80=AFAM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >
> > > On Wed, 2023-03-22 at 22:18 -0700, Andrii Nakryiko wrote:
> > > > On Wed, Mar 22, 2023 at 9:26=E2=80=AFPM James Hilliard
> > > > <james.hilliard1@gmail.com> wrote:
> > > > >
> > > > > I'm seeing this gen object error with gcc does not occur in llvm =
for a
> > > > > bpf test(which uses both linked_maps1.c and linked_maps2.c) in
> > > > > bpf-next.
> > > > >
> > > > > I presume there is a bug in GCC which is triggering a double free=
 bug in libbpf.
> > > > >
> > > >
> > > > Could you somehow share .o files for linked_maps1.c and
> > > > linked_maps2.c, so I can try to repro locally?
> > >
> > > Looking at the stack trace, second free is reported here:
> > >
> > >   void bpf_linker__free(struct bpf_linker *linker)
> > >   {
> > >         ...
> > >         for (i =3D 1; i < linker->sec_cnt; i++) {
> > >                 ...
> > >                 free(sec->sec_name);
> > > here -->        free(sec->raw_data);
> > >                 free(sec->sec_vars);
> > >                 ...
> > >         }
> > >         ...
> > >   }
> > >
> > > And first free is reported here:
> > >
> > >   static int extend_sec(struct bpf_linker *linker, struct dst_sec *ds=
t, struct src_sec *src)
> > >   {
> > >         ...
> > >         dst_align =3D dst->shdr->sh_addralign;
> > >         src_align =3D src->shdr->sh_addralign;
> > >         ...
> > >
> > >         dst_align_sz =3D (dst->sec_sz + dst_align - 1) / dst_align * =
dst_align;
> > >
> > >         /* no need to re-align final size */
> > >         dst_final_sz =3D dst_align_sz + src->shdr->sh_size;
> > >
> > >         if (src->shdr->sh_type !=3D SHT_NOBITS) {
> > > here -->        tmp =3D realloc(dst->raw_data, dst_final_sz);
> > >                 if (!tmp)
> > >                         return -ENOMEM;
> > >                 dst->raw_data =3D tmp;
> > >                 ...
> > >         }
> > >         ...
> > >   }
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
> >
> > Eduard, are you going to send a proper patch for this? Thanks!
>
> I finally got back to this and have a question which I should have
> asked on Thursday, sorry. Why do you want to preserve a call to
> realloc() when dst_final_sz is 0?

Because it's supposed to work correctly. Why is it weird? realloc API
is supposed to work with zeros, so I'd rather have one code path that
handles all the cases instead of avoiding calling realloc().

>
> Suppose we have N files all merging and having an empty section,
> then dst->raw_data would constantly flip-flop between 2 states:
> 1. special pointer to memory of size zero;
> 2. NULL.
>
> This shouldn't cause any issues but is kinda weird. If realloc() is
> avoided the dst->raw_data would preserve it's original state (set to
> zero by add_dst_sec()).
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
> > > >
> > > > > GCC gen object failure:
> > > > >
> > > > > =3D=3D2125110=3D=3D Command:
> > > > > /home/buildroot/bpf-next/tools/testing/selftests/bpf/tools/sbin/b=
pftool
> > > > > --debug gen object
> > > > > /home/buildroot/bpf-next/tools/testing/selftests/bpf/bpf_gcc/link=
ed_maps.linked1.o
> > > > > /home/buildroot/bpf-next/tools/testing/selftests/bpf/bpf_gcc/link=
ed_maps1.bpf.o
> > > > > /home/buildroot/bpf-next/tools/testing/selftests/bpf/bpf_gcc/link=
ed_maps2.bpf.o
> > > > > =3D=3D2125110=3D=3D
> > > > > libbpf: linker: adding object file
> > > > > '/home/buildroot/bpf-next/tools/testing/selftests/bpf/bpf_gcc/lin=
ked_maps1.bpf.o'...
> > > > > libbpf: linker: adding object file
> > > > > '/home/buildroot/bpf-next/tools/testing/selftests/bpf/bpf_gcc/lin=
ked_maps2.bpf.o'...
> > > > > Error: failed to link
> > > > > '/home/buildroot/bpf-next/tools/testing/selftests/bpf/bpf_gcc/lin=
ked_maps2.bpf.o':
> > > > > Cannot allocate memory (12)
> > > > > =3D=3D2125110=3D=3D Invalid free() / delete / delete[] / realloc(=
)
> > > > > =3D=3D2125110=3D=3D    at 0x484B0C4: free (vg_replace_malloc.c:88=
4)
> > > > > =3D=3D2125110=3D=3D    by 0x17F8AB: bpf_linker__free (linker.c:20=
4)
> > > > > =3D=3D2125110=3D=3D    by 0x12833C: do_object (gen.c:1608)
> > > > > =3D=3D2125110=3D=3D    by 0x12CDAB: cmd_select (main.c:206)
> > > > > =3D=3D2125110=3D=3D    by 0x129B53: do_gen (gen.c:2332)
> > > > > =3D=3D2125110=3D=3D    by 0x12CDAB: cmd_select (main.c:206)
> > > > > =3D=3D2125110=3D=3D    by 0x12DB9E: main (main.c:539)
> > > > > =3D=3D2125110=3D=3D  Address 0xda4b420 is 0 bytes after a block o=
f size 0 free'd
> > > > > =3D=3D2125110=3D=3D    at 0x484B027: free (vg_replace_malloc.c:88=
3)
> > > > > =3D=3D2125110=3D=3D    by 0x484D6F8: realloc (vg_replace_malloc.c=
:1451)
> > > > > =3D=3D2125110=3D=3D    by 0x181FA3: extend_sec (linker.c:1117)
> > > > > =3D=3D2125110=3D=3D    by 0x182326: linker_append_sec_data (linke=
r.c:1201)
> > > > > =3D=3D2125110=3D=3D    by 0x1803DC: bpf_linker__add_file (linker.=
c:453)
> > > > > =3D=3D2125110=3D=3D    by 0x12829E: do_object (gen.c:1593)
> > > > > =3D=3D2125110=3D=3D    by 0x12CDAB: cmd_select (main.c:206)
> > > > > =3D=3D2125110=3D=3D    by 0x129B53: do_gen (gen.c:2332)
> > > > > =3D=3D2125110=3D=3D    by 0x12CDAB: cmd_select (main.c:206)
> > > > > =3D=3D2125110=3D=3D    by 0x12DB9E: main (main.c:539)
> > > > > =3D=3D2125110=3D=3D  Block was alloc'd at
> > > > > =3D=3D2125110=3D=3D    at 0x484876A: malloc (vg_replace_malloc.c:=
392)
> > > > > =3D=3D2125110=3D=3D    by 0x484D6EB: realloc (vg_replace_malloc.c=
:1451)
> > > > > =3D=3D2125110=3D=3D    by 0x181FA3: extend_sec (linker.c:1117)
> > > > > =3D=3D2125110=3D=3D    by 0x182326: linker_append_sec_data (linke=
r.c:1201)
> > > > > =3D=3D2125110=3D=3D    by 0x1803DC: bpf_linker__add_file (linker.=
c:453)
> > > > > =3D=3D2125110=3D=3D    by 0x12829E: do_object (gen.c:1593)
> > > > > =3D=3D2125110=3D=3D    by 0x12CDAB: cmd_select (main.c:206)
> > > > > =3D=3D2125110=3D=3D    by 0x129B53: do_gen (gen.c:2332)
> > > > > =3D=3D2125110=3D=3D    by 0x12CDAB: cmd_select (main.c:206)
> > > > > =3D=3D2125110=3D=3D    by 0x12DB9E: main (main.c:539)
> > >
>
