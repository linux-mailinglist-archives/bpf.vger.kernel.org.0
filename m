Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773066CB0FB
	for <lists+bpf@lfdr.de>; Mon, 27 Mar 2023 23:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjC0VtM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Mar 2023 17:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjC0Vsy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Mar 2023 17:48:54 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C48B1FE3
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 14:48:52 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id ew6so41914341edb.7
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 14:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679953731;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QPzuF47o2L5Qq9Xg7DXFTgMzn4134xmU7/wIPDpG6fc=;
        b=ndaHbD83sFkZgj+KuuiuyTE4cg0Yc+VvzeAKOOBcRhw71I9AaEkzsi4kmbYM3Ngx7f
         uzQIbSb2ukNUeHq3X0iHpoMvy1K7ScQ2ZPRwmbGPARF8+zglnX7hVm7746Wf7JmanpnV
         pV4phPRRAx75oyHD5R7IrEEkjpnDo39wP1pezGhk7Nw9iY7PVuRJInoxuU4y6fVAekcl
         lp8B3Q6D+7UAlEtb5by7318b1Ysi8SminlSzl9t+o2eNNGe/HmQtv3MwUGKy3fHROlJG
         9ENUPCcB0dI4lTGK8l3xnzUCCKfbczjVvPQRdgxfrYh5fC/DvhCJZj1NmPyGaA5yZrKS
         ex8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679953731;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QPzuF47o2L5Qq9Xg7DXFTgMzn4134xmU7/wIPDpG6fc=;
        b=CXfWr6GQvr1UWH0FSL8Ae0bUZQFfxpkPP+qxFKvgnQpJKW19LzPAeAcRSh5iv7jTS6
         Yq7Xd2WUGO3vLFUyBw5gBq1ZkUD5ydlCF/i5KEMAC5wQ+6ozLJuCkK6zeh3sFXjRqiiT
         kJXnSM9eAZKJzh9a3xLEl1z5wd2qIb8R8/UW94K6Q7nj31UZ57s6+dfse4pcwCQqaHWa
         snXoz2GxqYLvyiOZu2MILJ8UVwG23b22/oxVFe81GIDpyDMz2PS3h8xVFdcboOKIbdep
         AI8IuSY8Fy8lbqHoOAuioXgXc8iVnqcekZty5S08M561DtGIXgk6o8GiLNIFqKD6r7BH
         JdVg==
X-Gm-Message-State: AAQBX9cCTv68OqoRnZa1vALWBuVdIi/mxycGYQCCJiRYwwdzR05iUhvv
        0ggI62M2S2LwK5nQaLQvvLI=
X-Google-Smtp-Source: AKy350aVHI72HJ1NLNDf9V2ljIz2vq6oqJgXru0sLJx9fMPW/hYwHZGQxAB6iSz01PYyYinPhGy1VA==
X-Received: by 2002:a17:907:6f0d:b0:946:b942:ad6a with SMTP id sy13-20020a1709076f0d00b00946b942ad6amr285266ejc.38.1679953730893;
        Mon, 27 Mar 2023 14:48:50 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id le1-20020a170907170100b00930d505a567sm14454686ejc.128.2023.03.27.14.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 14:48:50 -0700 (PDT)
Message-ID: <55da8c265fda2b45817ef70bdc57e4c2d168b74d.camel@gmail.com>
Subject: Re: GCC-BPF triggers double free in libbpf Error: failed to link
 'linked_maps2.bpf.o': Cannot allocate memory (12)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     James Hilliard <james.hilliard1@gmail.com>,
        bpf <bpf@vger.kernel.org>
Date:   Tue, 28 Mar 2023 00:48:49 +0300
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
> On Thu, Mar 23, 2023 at 5:57=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > On Wed, 2023-03-22 at 22:18 -0700, Andrii Nakryiko wrote:
> > > On Wed, Mar 22, 2023 at 9:26=E2=80=AFPM James Hilliard
> > > <james.hilliard1@gmail.com> wrote:
> > > >=20
> > > > I'm seeing this gen object error with gcc does not occur in llvm fo=
r a
> > > > bpf test(which uses both linked_maps1.c and linked_maps2.c) in
> > > > bpf-next.
> > > >=20
> > > > I presume there is a bug in GCC which is triggering a double free b=
ug in libbpf.
> > > >=20
> > >=20
> > > Could you somehow share .o files for linked_maps1.c and
> > > linked_maps2.c, so I can try to repro locally?
> >=20
> > Looking at the stack trace, second free is reported here:
> >=20
> >   void bpf_linker__free(struct bpf_linker *linker)
> >   {
> >         ...
> >         for (i =3D 1; i < linker->sec_cnt; i++) {
> >                 ...
> >                 free(sec->sec_name);
> > here -->        free(sec->raw_data);
> >                 free(sec->sec_vars);
> >                 ...
> >         }
> >         ...
> >   }
> >=20
> > And first free is reported here:
> >=20
> >   static int extend_sec(struct bpf_linker *linker, struct dst_sec *dst,=
 struct src_sec *src)
> >   {
> >         ...
> >         dst_align =3D dst->shdr->sh_addralign;
> >         src_align =3D src->shdr->sh_addralign;
> >         ...
> >=20
> >         dst_align_sz =3D (dst->sec_sz + dst_align - 1) / dst_align * ds=
t_align;
> >=20
> >         /* no need to re-align final size */
> >         dst_final_sz =3D dst_align_sz + src->shdr->sh_size;
> >=20
> >         if (src->shdr->sh_type !=3D SHT_NOBITS) {
> > here -->        tmp =3D realloc(dst->raw_data, dst_final_sz);
> >                 if (!tmp)
> >                         return -ENOMEM;
> >                 dst->raw_data =3D tmp;
> >                 ...
> >         }
> >         ...
> >   }
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
>=20
> Eduard, are you going to send a proper patch for this? Thanks!

I finally got back to this and have a question which I should have
asked on Thursday, sorry. Why do you want to preserve a call to
realloc() when dst_final_sz is 0?

Suppose we have N files all merging and having an empty section,
then dst->raw_data would constantly flip-flop between 2 states:
1. special pointer to memory of size zero;
2. NULL.

This shouldn't cause any issues but is kinda weird. If realloc() is
avoided the dst->raw_data would preserve it's original state (set to
zero by add_dst_sec()).

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
> > >=20
> > > > GCC gen object failure:
> > > >=20
> > > > =3D=3D2125110=3D=3D Command:
> > > > /home/buildroot/bpf-next/tools/testing/selftests/bpf/tools/sbin/bpf=
tool
> > > > --debug gen object
> > > > /home/buildroot/bpf-next/tools/testing/selftests/bpf/bpf_gcc/linked=
_maps.linked1.o
> > > > /home/buildroot/bpf-next/tools/testing/selftests/bpf/bpf_gcc/linked=
_maps1.bpf.o
> > > > /home/buildroot/bpf-next/tools/testing/selftests/bpf/bpf_gcc/linked=
_maps2.bpf.o
> > > > =3D=3D2125110=3D=3D
> > > > libbpf: linker: adding object file
> > > > '/home/buildroot/bpf-next/tools/testing/selftests/bpf/bpf_gcc/linke=
d_maps1.bpf.o'...
> > > > libbpf: linker: adding object file
> > > > '/home/buildroot/bpf-next/tools/testing/selftests/bpf/bpf_gcc/linke=
d_maps2.bpf.o'...
> > > > Error: failed to link
> > > > '/home/buildroot/bpf-next/tools/testing/selftests/bpf/bpf_gcc/linke=
d_maps2.bpf.o':
> > > > Cannot allocate memory (12)
> > > > =3D=3D2125110=3D=3D Invalid free() / delete / delete[] / realloc()
> > > > =3D=3D2125110=3D=3D    at 0x484B0C4: free (vg_replace_malloc.c:884)
> > > > =3D=3D2125110=3D=3D    by 0x17F8AB: bpf_linker__free (linker.c:204)
> > > > =3D=3D2125110=3D=3D    by 0x12833C: do_object (gen.c:1608)
> > > > =3D=3D2125110=3D=3D    by 0x12CDAB: cmd_select (main.c:206)
> > > > =3D=3D2125110=3D=3D    by 0x129B53: do_gen (gen.c:2332)
> > > > =3D=3D2125110=3D=3D    by 0x12CDAB: cmd_select (main.c:206)
> > > > =3D=3D2125110=3D=3D    by 0x12DB9E: main (main.c:539)
> > > > =3D=3D2125110=3D=3D  Address 0xda4b420 is 0 bytes after a block of =
size 0 free'd
> > > > =3D=3D2125110=3D=3D    at 0x484B027: free (vg_replace_malloc.c:883)
> > > > =3D=3D2125110=3D=3D    by 0x484D6F8: realloc (vg_replace_malloc.c:1=
451)
> > > > =3D=3D2125110=3D=3D    by 0x181FA3: extend_sec (linker.c:1117)
> > > > =3D=3D2125110=3D=3D    by 0x182326: linker_append_sec_data (linker.=
c:1201)
> > > > =3D=3D2125110=3D=3D    by 0x1803DC: bpf_linker__add_file (linker.c:=
453)
> > > > =3D=3D2125110=3D=3D    by 0x12829E: do_object (gen.c:1593)
> > > > =3D=3D2125110=3D=3D    by 0x12CDAB: cmd_select (main.c:206)
> > > > =3D=3D2125110=3D=3D    by 0x129B53: do_gen (gen.c:2332)
> > > > =3D=3D2125110=3D=3D    by 0x12CDAB: cmd_select (main.c:206)
> > > > =3D=3D2125110=3D=3D    by 0x12DB9E: main (main.c:539)
> > > > =3D=3D2125110=3D=3D  Block was alloc'd at
> > > > =3D=3D2125110=3D=3D    at 0x484876A: malloc (vg_replace_malloc.c:39=
2)
> > > > =3D=3D2125110=3D=3D    by 0x484D6EB: realloc (vg_replace_malloc.c:1=
451)
> > > > =3D=3D2125110=3D=3D    by 0x181FA3: extend_sec (linker.c:1117)
> > > > =3D=3D2125110=3D=3D    by 0x182326: linker_append_sec_data (linker.=
c:1201)
> > > > =3D=3D2125110=3D=3D    by 0x1803DC: bpf_linker__add_file (linker.c:=
453)
> > > > =3D=3D2125110=3D=3D    by 0x12829E: do_object (gen.c:1593)
> > > > =3D=3D2125110=3D=3D    by 0x12CDAB: cmd_select (main.c:206)
> > > > =3D=3D2125110=3D=3D    by 0x129B53: do_gen (gen.c:2332)
> > > > =3D=3D2125110=3D=3D    by 0x12CDAB: cmd_select (main.c:206)
> > > > =3D=3D2125110=3D=3D    by 0x12DB9E: main (main.c:539)
> >=20

