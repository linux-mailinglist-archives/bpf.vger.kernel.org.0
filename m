Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC8762B0CD
	for <lists+bpf@lfdr.de>; Wed, 16 Nov 2022 02:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbiKPBwC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 20:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiKPBwC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 20:52:02 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D351225E9D
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 17:52:00 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id n12so40612261eja.11
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 17:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VstsHpgnZCMvTNVJNEXAkrEVrvrzN3I9m/hUhu15C6k=;
        b=iJ0uyKhFUgW3rqptqIZZEw2e/0k0JUVDu0HGz8sAX3TvprlaKl1tpVyURV2df1tCPc
         6NpE7P1SPQ2u5PSntUNO9Q5IhsvQhVkRYms9msMyGrozBKt6u0Tl2T3go+0WGphdeB2V
         1rIxUbEBXsn/wupeZsh+5xFhP5x/rr0ZpQ5pXGc/ccqlox5jzlT0iWBFeA+7IqYTKnyO
         i6uIpWhf5m5sPhDO7Gf2MOpm6F70j9FpjR1zolF9SGW5tOSAEOUrVry4LO7M1OyvcOGd
         CMnCPStT/M6UgY1eXZ9npZ/oUampigfb6xZzozLOr0vTRTs3K11QkHqbY64C/53o92Fp
         +STw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VstsHpgnZCMvTNVJNEXAkrEVrvrzN3I9m/hUhu15C6k=;
        b=VUHdqSIQvdR6mK5ib2MoulQOQhgzgNbUN2ThBKy2ATOFwZXzx/QrHzPR4gtgTHPmEx
         17mg8uHXwZIF1+Y9svl3UxgM4sQZL4Hlio0mhYCsqGmf89Pjp9bkFchG9cxv/81P7rT8
         T+a4UTb5m+mwnJzD76laTYcZ8Ce6734OWHN0fmgxl9dxvrEUkGNNZqdvktSeIQ+XG1Bp
         1rur92e4ePEzIV4wrP3xmv1JbxOe9+9lCDjbyTK4mJjcPIW6+Hvhh+IR18TOqBGjL1cu
         PWT1oQg0WrReSC63i7ytzepVE9l8vf959+LqbEO4Dpywz0MxhiXriAbnIbIiIcWNfikH
         zVgQ==
X-Gm-Message-State: ANoB5pmYg2zRZT6yfBpArCExUc4hGxlU7GCNCve2Vedhbcq8Kd2ZATZp
        6zK+bet7vuGKAYZVm4ZalNg=
X-Google-Smtp-Source: AA0mqf7QKdE1sWLFWLBe7xtUlKSKgG2UcZO5c1F6XJ+FiTKkdYEkREOu4awJAzoQvvd8SH+BCOCuPw==
X-Received: by 2002:a17:906:b2ca:b0:7ad:92c5:637a with SMTP id cf10-20020a170906b2ca00b007ad92c5637amr16303986ejb.87.1668563518792;
        Tue, 15 Nov 2022 17:51:58 -0800 (PST)
Received: from [192.168.1.113] (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id bc22-20020a056402205600b0045bccd8ab83sm6909270edb.1.2022.11.15.17.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 17:51:57 -0800 (PST)
Message-ID: <d1d5c46e31a9016a7e53e2e7877722af6f1f2027.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] libbpf:
 __attribute__((btf_decl_tag("..."))) for btf dump in C format
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com
Date:   Wed, 16 Nov 2022 03:51:56 +0200
In-Reply-To: <CAEf4BzYZ-oo38ATgv32=0LhFWYciGtwAUcpSeB3Aam8hJ5Yuzg@mail.gmail.com>
References: <20221110144320.1075367-1-eddyz87@gmail.com>
         <20221110144320.1075367-2-eddyz87@gmail.com>
         <CAEf4Bzbnd2UOT9Mko+0Yf9Kgsn-sGsV43MKExYjEaYbWg0WgZg@mail.gmail.com>
         <3d638bd465fb604ef01c1dc5a5a92617b90482d8.camel@gmail.com>
         <CAEf4BzYZ-oo38ATgv32=0LhFWYciGtwAUcpSeB3Aam8hJ5Yuzg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 2022-11-14 at 11:56 -0800, Andrii Nakryiko wrote:
> On Fri, Nov 11, 2022 at 1:30 PM Eduard Zingerman <eddyz87@gmail.com> wrot=
e:
> >=20
> > On Fri, 2022-11-11 at 10:58 -0800, Andrii Nakryiko wrote:
> > > On Thu, Nov 10, 2022 at 6:43 AM Eduard Zingerman <eddyz87@gmail.com> =
wrote:
> > >=20
> > >=20
> > > [...]
> > >=20
> > > >  static int btf_dump_push_decl_stack_id(struct btf_dump *d, __u32 i=
d)
> > > > @@ -1438,9 +1593,12 @@ static void btf_dump_emit_type_chain(struct =
btf_dump *d,
> > > >                 }
> > > >                 case BTF_KIND_FUNC_PROTO: {
> > > >                         const struct btf_param *p =3D btf_params(t)=
;
> > > > +                       struct decl_tag_array *decl_tags =3D NULL;
> > > >                         __u16 vlen =3D btf_vlen(t);
> > > >                         int i;
> > > >=20
> > > > +                       hashmap__find(d->decl_tags, id, &decl_tags)=
;
> > > > +
> > > >                         /*
> > > >                          * GCC emits extra volatile qualifier for
> > > >                          * __attribute__((noreturn)) function point=
ers. Clang
> > >=20
> > > should there be btf_dump_emit_decl_tags(d, decl_tags, -1) somewhere
> > > here to emit tags of FUNC_PROTO itself?
> >=20
> > Actually, I have not found a way to attach decl tag to a FUNC_PROTO its=
elf:
>=20
> I'll need to check with Yonghong, but I think what happens right now
> with decl_tag being attached to FUNC instead of its underlying
> FUNC_PROTO might be a bug (or maybe it's by design, but certainly is
> quite confusing as FUNC itself doesn't have arguments, so
> component_idx !=3D -1 is a bit weird).
>=20
> But regardless if Clang allows you to express it in C code today or
> not, if we support decl_tags on func proto args, for completeness
> let's support it also on func_proto itself (comp_idx =3D=3D -1). You can
> build BTF manually for test, just like you do it for func_proto args,
> right?

I can construct the BTF manually, but I need a place in C where
__decl_tag would be printed for such proto and currently there is no
such place.

As Yonghong suggests in a sibling comment there are currently no
use-cases for decl tags on functions, function protos or function
proto parameters. I suggest to drop these places from the current
patch and get back to it when the need arises.

> >=20
> >   typedef void (*fn)(void) __decl_tag("..."); // here tag is attached t=
o typedef
> >   struct foo {
> >     void (*fn)(void) __decl_tag("..."); // here tag is attached to a fo=
o.fn field
> >   }
> >   void foo(void (*fn)(void) __decl_tag("...")); // here tag is attached=
 to FUNC foo
> >                                                 // parameter but should=
 probably
> >                                                 // be attached to
> >                                                 // FUNC_PROTO parameter=
 instead.
> >=20
> > Also, I think that Yonghong had reservations about decl tags attached t=
o
> > FUNC_PROTO parameters.
> > Yonghong, could you please comment?
>=20
> yep, curious to hear as well
>=20
>=20
> >=20
> > >=20
> > > > @@ -1481,6 +1639,7 @@ static void btf_dump_emit_type_chain(struct b=
tf_dump *d,
> > > >=20
> > > >                                 name =3D btf_name_of(d, p->name_off=
);
> > > >                                 btf_dump_emit_type_decl(d, p->type,=
 name, lvl);
> > > > +                               btf_dump_emit_decl_tags(d, decl_tag=
s, i);
> > > >                         }
> > > >=20
> > > >                         btf_dump_printf(d, ")");
> > > > @@ -1896,6 +2055,7 @@ static int btf_dump_var_data(struct btf_dump =
*d,
> > > >                              const void *data)
> > > >  {
> > > >         enum btf_func_linkage linkage =3D btf_var(v)->linkage;
> > > > +       struct decl_tag_array *decl_tags =3D NULL;
> > > >         const struct btf_type *t;
> > > >         const char *l;
> > > >         __u32 type_id;
> > > > @@ -1920,7 +2080,10 @@ static int btf_dump_var_data(struct btf_dump=
 *d,
> > > >         type_id =3D v->type;
> > > >         t =3D btf__type_by_id(d->btf, type_id);
> > > >         btf_dump_emit_type_cast(d, type_id, false);
> > > > -       btf_dump_printf(d, " %s =3D ", btf_name_of(d, v->name_off))=
;
> > > > +       btf_dump_printf(d, " %s", btf_name_of(d, v->name_off));
> > > > +       hashmap__find(d->decl_tags, id, &decl_tags);
> > > > +       btf_dump_emit_decl_tags(d, decl_tags, -1);
> > > > +       btf_dump_printf(d, " =3D ");
> > > >         return btf_dump_dump_type_data(d, NULL, t, type_id, data, 0=
, 0);
> > > >  }
> > > >=20
> > > > @@ -2421,6 +2584,8 @@ int btf_dump__dump_type_data(struct btf_dump =
*d, __u32 id,
> > > >         d->typed_dump->skip_names =3D OPTS_GET(opts, skip_names, fa=
lse);
> > > >         d->typed_dump->emit_zeroes =3D OPTS_GET(opts, emit_zeroes, =
false);
> > > >=20
> > > > +       btf_dump_assign_decl_tags(d);
> > > > +
> > >=20
> > > I'm actually not sure we want those tags on binary data dump.
> > > Generally data dump is not type definition dump, so this seems
> > > unnecessary, it will just distract from data itself. Let's drop it fo=
r
> > > now? If there would be a need we can add it easily later.
> >=20
> > Well, this is the only place where VARs are processed, removing this co=
de
> > would make the second patch in a series useless.
> > But I like my second patch in a series :) should I just drop it?
> > I can extract it as a separate series and simplify some of the existing
> > data dump tests.
>=20
> yep, data dump tests can be completely orthogonal, send them
> separately if you are attached to that code ;)
>=20
> but for decl_tags on dump_type_data() I'd rather be conservative for
> now, unless in practice those decl_tags will turn out to be needed
>=20
>=20
> >=20
> > >=20
> > > >         ret =3D btf_dump_dump_type_data(d, NULL, t, id, data, 0, 0)=
;
> > > >=20
> > > >         d->typed_dump =3D NULL;
> > > > --
> > > > 2.34.1
> > > >=20
> >=20

