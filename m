Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F100E62EA28
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 01:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbiKRAWB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 19:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235016AbiKRAV4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 19:21:56 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E349663C5
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 16:21:55 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id n20so9387730ejh.0
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 16:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lleBEqhafl5hxMh2Mpucx88L2dqsFz6P0hkAqJOSiVE=;
        b=WzqY8bWlCc/tQlDjusoSzRH4SVWghK2+j/7f68CUBgtHYZCnep42TzqRBA775lhIDD
         HH9ErIN/Ku/Jzh54Y7f9wDh/rpZCl4RBusrILyK/f7i7YoGicMzw4dh9cT6IoDaBW1Bi
         LXoM3Z6AFZk63JOIhfDWWBgqUZzW/XFWDckV7ZwT5BuzXr0p8/yMx71JAckDPYWD+MUR
         q2+0HGm5EJEZgYI3JxSdpjykSD647b0Y7vchbH0hK9vzrrcGmJMXvqG2wREB2F0hXBq/
         4lrT0HkoM98cqL8vf4lktv609vPDMeWxQujdVwpt6Ha6hwTuFcNP0LZo0GIFvXMd4J2C
         +sEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lleBEqhafl5hxMh2Mpucx88L2dqsFz6P0hkAqJOSiVE=;
        b=NK3PtvdUSVQjwXA3o856WmknNQo2iG/7uIUWa4NHSCo+sKONgP0PzcyCbmWWg1yQUS
         BBj7supUCjhjStNPkid/FHUX8CuhwQv0Sf7rRA8uDBb4AypjFZrKS1Xcca4lZB0d8/X6
         MOIQA0kcD61bU9WALgq5f1e8anmuWLiqIoZxLhJFf7PPCYqJnWM5C0UyDkFmdfxiRyg6
         +By/Gpn8ME+gq3QUd+0kED03Y7QbwgYi5X010ZVmOsoXH1WelzN7juAVozRkOHdvCvx4
         IZRDYHsD2MGUU6QoBtqp3oZrns3WdIp7AYcwoY5ksBqUfDnOgxJByaLYDz/FjA2iU2hp
         VvBg==
X-Gm-Message-State: ANoB5pmkR6nPJ/RDLgpA4f8S1cq8oa1ncU469GiWe+dWjGABNW7Ss4wU
        dt8gxkmT/gzPAUKXdFocWnATfxImGvBMtCOPvNDppcQADxI=
X-Google-Smtp-Source: AA0mqf561Hnl6NzKBsl9979RaAYSeqSZVt8iyFd4kMe7dPOHinOg6iSr0UOB4EXfiuGIWOIU7LuyNtnOhuP5cNQVJUY=
X-Received: by 2002:a17:906:8055:b0:78d:99ee:4e68 with SMTP id
 x21-20020a170906805500b0078d99ee4e68mr3835305ejw.302.1668730913911; Thu, 17
 Nov 2022 16:21:53 -0800 (PST)
MIME-Version: 1.0
References: <20221110144320.1075367-1-eddyz87@gmail.com> <20221110144320.1075367-2-eddyz87@gmail.com>
 <CAEf4Bzbnd2UOT9Mko+0Yf9Kgsn-sGsV43MKExYjEaYbWg0WgZg@mail.gmail.com>
 <3d638bd465fb604ef01c1dc5a5a92617b90482d8.camel@gmail.com>
 <CAEf4BzYZ-oo38ATgv32=0LhFWYciGtwAUcpSeB3Aam8hJ5Yuzg@mail.gmail.com> <d1d5c46e31a9016a7e53e2e7877722af6f1f2027.camel@gmail.com>
In-Reply-To: <d1d5c46e31a9016a7e53e2e7877722af6f1f2027.camel@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 17 Nov 2022 16:21:41 -0800
Message-ID: <CAEf4BzZ4H-BYFAHZmxCD+0ky495=ZY6Qv4wZOYYPNOd=hjHm8g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] libbpf: __attribute__((btf_decl_tag("...")))
 for btf dump in C format
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com
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

On Tue, Nov 15, 2022 at 5:51 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Mon, 2022-11-14 at 11:56 -0800, Andrii Nakryiko wrote:
> > On Fri, Nov 11, 2022 at 1:30 PM Eduard Zingerman <eddyz87@gmail.com> wr=
ote:
> > >
> > > On Fri, 2022-11-11 at 10:58 -0800, Andrii Nakryiko wrote:
> > > > On Thu, Nov 10, 2022 at 6:43 AM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
> > > >
> > > >
> > > > [...]
> > > >
> > > > >  static int btf_dump_push_decl_stack_id(struct btf_dump *d, __u32=
 id)
> > > > > @@ -1438,9 +1593,12 @@ static void btf_dump_emit_type_chain(struc=
t btf_dump *d,
> > > > >                 }
> > > > >                 case BTF_KIND_FUNC_PROTO: {
> > > > >                         const struct btf_param *p =3D btf_params(=
t);
> > > > > +                       struct decl_tag_array *decl_tags =3D NULL=
;
> > > > >                         __u16 vlen =3D btf_vlen(t);
> > > > >                         int i;
> > > > >
> > > > > +                       hashmap__find(d->decl_tags, id, &decl_tag=
s);
> > > > > +
> > > > >                         /*
> > > > >                          * GCC emits extra volatile qualifier for
> > > > >                          * __attribute__((noreturn)) function poi=
nters. Clang
> > > >
> > > > should there be btf_dump_emit_decl_tags(d, decl_tags, -1) somewhere
> > > > here to emit tags of FUNC_PROTO itself?
> > >
> > > Actually, I have not found a way to attach decl tag to a FUNC_PROTO i=
tself:
> >
> > I'll need to check with Yonghong, but I think what happens right now
> > with decl_tag being attached to FUNC instead of its underlying
> > FUNC_PROTO might be a bug (or maybe it's by design, but certainly is
> > quite confusing as FUNC itself doesn't have arguments, so
> > component_idx !=3D -1 is a bit weird).
> >
> > But regardless if Clang allows you to express it in C code today or
> > not, if we support decl_tags on func proto args, for completeness
> > let's support it also on func_proto itself (comp_idx =3D=3D -1). You ca=
n
> > build BTF manually for test, just like you do it for func_proto args,
> > right?
>
> I can construct the BTF manually, but I need a place in C where
> __decl_tag would be printed for such proto and currently there is no
> such place.

after func prototype definition:

$ cat t.c
#include <stdio.h>

typedef int (* ff)(void *arg) __attribute__((nonnull(1)));

static
int blah(void *x) { return (int)(long)x; }

int main() {
        int (*f1)(void *arg) __attribute__((nonnull(1))) =3D blah;
        ff f2 =3D blah;

        blah(NULL);
        f1(NULL);
        f2(NULL);

        printf("%lx %lx\n", (long)f1, (long)f2);
        return 0;
}

$ cc -g t.c -Wnonnull && ./a.out
t.c: In function =E2=80=98main=E2=80=99:
t.c:13:9: warning: argument 1 null where non-null expected [-Wnonnull]
   13 |         f1(NULL);
      |         ^~
t.c:14:9: warning: argument 1 null where non-null expected [-Wnonnull]
   14 |         f2(NULL);
      |         ^~
401126 401126

Note that blah(NULL) doesn't generate a warning, which means nonnull
attributes are applied only to func_proto.

>
> As Yonghong suggests in a sibling comment there are currently no
> use-cases for decl tags on functions, function protos or function
> proto parameters. I suggest to drop these places from the current
> patch and get back to it when the need arises.

decl_tags for functions and function protos are natural extensions of
decl_tags for fields/structs/variables, so let's do the proper support
for all conceivable use cases instead of doing this in a few months
again. There is not ambiguity here.


And btw, we do have decl_tags for FUNCs right now, and that seems
wrong, because FUNC itself doesn't have arguments, it only points to
FUNC_PROTO. So it seems like decl_tags should be moved to FUNC_PROTO
instead anyways?


>
> > >
> > >   typedef void (*fn)(void) __decl_tag("..."); // here tag is attached=
 to typedef
> > >   struct foo {
> > >     void (*fn)(void) __decl_tag("..."); // here tag is attached to a =
foo.fn field
> > >   }
> > >   void foo(void (*fn)(void) __decl_tag("...")); // here tag is attach=
ed to FUNC foo
> > >                                                 // parameter but shou=
ld probably
> > >                                                 // be attached to
> > >                                                 // FUNC_PROTO paramet=
er instead.
> > >
> > > Also, I think that Yonghong had reservations about decl tags attached=
 to
> > > FUNC_PROTO parameters.
> > > Yonghong, could you please comment?
> >
> > yep, curious to hear as well
> >
> >
> > >
> > > >
> > > > > @@ -1481,6 +1639,7 @@ static void btf_dump_emit_type_chain(struct=
 btf_dump *d,
> > > > >
> > > > >                                 name =3D btf_name_of(d, p->name_o=
ff);
> > > > >                                 btf_dump_emit_type_decl(d, p->typ=
e, name, lvl);
> > > > > +                               btf_dump_emit_decl_tags(d, decl_t=
ags, i);
> > > > >                         }
> > > > >
> > > > >                         btf_dump_printf(d, ")");
> > > > > @@ -1896,6 +2055,7 @@ static int btf_dump_var_data(struct btf_dum=
p *d,
> > > > >                              const void *data)
> > > > >  {
> > > > >         enum btf_func_linkage linkage =3D btf_var(v)->linkage;
> > > > > +       struct decl_tag_array *decl_tags =3D NULL;
> > > > >         const struct btf_type *t;
> > > > >         const char *l;
> > > > >         __u32 type_id;
> > > > > @@ -1920,7 +2080,10 @@ static int btf_dump_var_data(struct btf_du=
mp *d,
> > > > >         type_id =3D v->type;
> > > > >         t =3D btf__type_by_id(d->btf, type_id);
> > > > >         btf_dump_emit_type_cast(d, type_id, false);
> > > > > -       btf_dump_printf(d, " %s =3D ", btf_name_of(d, v->name_off=
));
> > > > > +       btf_dump_printf(d, " %s", btf_name_of(d, v->name_off));
> > > > > +       hashmap__find(d->decl_tags, id, &decl_tags);
> > > > > +       btf_dump_emit_decl_tags(d, decl_tags, -1);
> > > > > +       btf_dump_printf(d, " =3D ");
> > > > >         return btf_dump_dump_type_data(d, NULL, t, type_id, data,=
 0, 0);
> > > > >  }
> > > > >
> > > > > @@ -2421,6 +2584,8 @@ int btf_dump__dump_type_data(struct btf_dum=
p *d, __u32 id,
> > > > >         d->typed_dump->skip_names =3D OPTS_GET(opts, skip_names, =
false);
> > > > >         d->typed_dump->emit_zeroes =3D OPTS_GET(opts, emit_zeroes=
, false);
> > > > >
> > > > > +       btf_dump_assign_decl_tags(d);
> > > > > +
> > > >
> > > > I'm actually not sure we want those tags on binary data dump.
> > > > Generally data dump is not type definition dump, so this seems
> > > > unnecessary, it will just distract from data itself. Let's drop it =
for
> > > > now? If there would be a need we can add it easily later.
> > >
> > > Well, this is the only place where VARs are processed, removing this =
code
> > > would make the second patch in a series useless.
> > > But I like my second patch in a series :) should I just drop it?
> > > I can extract it as a separate series and simplify some of the existi=
ng
> > > data dump tests.
> >
> > yep, data dump tests can be completely orthogonal, send them
> > separately if you are attached to that code ;)
> >
> > but for decl_tags on dump_type_data() I'd rather be conservative for
> > now, unless in practice those decl_tags will turn out to be needed
> >
> >
> > >
> > > >
> > > > >         ret =3D btf_dump_dump_type_data(d, NULL, t, id, data, 0, =
0);
> > > > >
> > > > >         d->typed_dump =3D NULL;
> > > > > --
> > > > > 2.34.1
> > > > >
> > >
>
