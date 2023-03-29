Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDFBB6CEE9F
	for <lists+bpf@lfdr.de>; Wed, 29 Mar 2023 18:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbjC2QF0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Mar 2023 12:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbjC2QEo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Mar 2023 12:04:44 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CDA65A7;
        Wed, 29 Mar 2023 09:03:54 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id b20so65428273edd.1;
        Wed, 29 Mar 2023 09:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680105772; x=1682697772;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9+PTMgMb1uDuXcr/T04yJ3YfU4pZJmc2CjMbSMMWPRk=;
        b=UuiB6j8IliGHFkVWqIs5A505BUdSmCNcLut8okEq8ZZD66vBD0fVpBTX/RJjX5iLRR
         8AZFXXAPyyRbOkW3iu/OgIkgamyGC7rpVC1X8fKA5VQNCnxi9cjJAmif0YezujgFJflI
         WeabZrugdrrLMiSH56Z48zsFnd0wml2VU7UZt3hWunlwx6l97qVWrPnOy6ESncqbYwZF
         ih61QOYFuUVskv+qstGaMEjsOV+FLg1+1+hUIiTK8xRQJL6f3SJ84y3VMD8mR5shyWg+
         Ji6V/aBy9E5pz7iL0wld2kVvtL3GiEcR4FIp5/Lq2h1EyzG+geMYNkfGEjsAReN9x3OZ
         n9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680105772; x=1682697772;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9+PTMgMb1uDuXcr/T04yJ3YfU4pZJmc2CjMbSMMWPRk=;
        b=McwHzS4ZSXvWSbW7IEkesMKquyb/hRR34DJfuuKjmsmHsd+1DjOc71HE9RI7/AtNtr
         7iBDzvXx8KG6YmCGqOJsnoXUV/jT1TLnSV+DzAd0YYZJirYOkqpg/X4aOWHJ7VPVJTZu
         qXSTMbQR96rWSzyR8Gozkgppte9WLAfPBKZsqI4gTWvxZNoSES6B1YGBNEXf9MBPR4vy
         vihhNgCho6vBulFhT10CQbLCeiQdOQHRrW1uO3baHcnPF7/P8QRUofswd+2u1J6pbtdM
         gE7l9P0ZZ/aCd6aiTO2NQMX3zf5H6ABPB9yf/RONBmgxHvnga9ZXIlZ76Yu+YpIDw0Dp
         5IXw==
X-Gm-Message-State: AAQBX9fNjBZfS9EJjYIELowGmuO9pr5KK6Y5WiUW3kH3DSE84ZQXUh5N
        YCCA05gxjnCCxAKDzk/0LKWX6ED/rxaYwQ==
X-Google-Smtp-Source: AKy350bVpNijXnnSOg+agaEisC/QGGLGzKtFpzZyo4diLmUkLhVXE656ZR1ns5KxBKW+wDeNsO9Pdg==
X-Received: by 2002:a17:907:1706:b0:946:c033:4d18 with SMTP id le6-20020a170907170600b00946c0334d18mr7751622ejc.13.1680105772583;
        Wed, 29 Mar 2023 09:02:52 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id rk28-20020a170907215c00b00933b38505f9sm14083064ejb.152.2023.03.29.09.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 09:02:50 -0700 (PDT)
Message-ID: <f9664121426c5665ff0fc8cb61c466689beadd36.camel@gmail.com>
Subject: Re: [PATCH dwarves v2 1/5] fprintf: Correct names for types with
 btf_type_tag attribute
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, jose.marchesi@oracle.com, david.faust@oracle.com,
        alan.maguire@oracle.com
Date:   Wed, 29 Mar 2023 19:02:45 +0300
In-Reply-To: <ZCRctmB2yrwgsNMh@kernel.org>
References: <20230314230417.1507266-1-eddyz87@gmail.com>
         <20230314230417.1507266-2-eddyz87@gmail.com> <ZCLy0hjyR3KuYy3e@kernel.org>
         <f4803213ab27c65517eea19a12be78dd4ec9f6b0.camel@gmail.com>
         <ZCMHKFdmjVpOSNsJ@kernel.org>
         <50a160d802ad3f84e91cf05c8f541e0c2e388fc8.camel@gmail.com>
         <ZCNZcl1mkC9yhwDD@kernel.org>
         <fabfc71fd43be48f68019c911c6a3af1412f4635.camel@gmail.com>
         <ZCRctmB2yrwgsNMh@kernel.org>
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

On Wed, 2023-03-29 at 12:43 -0300, Arnaldo Carvalho de Melo wrote:
[...]
> > > diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
> > > index 1e6147a82056c188..1ecc24321bf8f975 100644
> > > --- a/dwarves_fprintf.c
> > > +++ b/dwarves_fprintf.c
> > > @@ -788,8 +788,15 @@ next_type:
> > >  			if (n)
> > >  				return printed + n;
> > >  			if (ptype->tag =3D=3D DW_TAG_LLVM_annotation) {
> > > -				type =3D ptype;
> > > -				goto next_type;
> > > +				// FIXME: Just skip this for now, we need to print this annotati=
on
> > > +				// to match the original source code.
> > > +
> > > +				if (ptype->type =3D=3D 0) {
> > > +					printed +=3D fprintf(fp, "%-*s %s", tconf.type_spacing, "void *=
", name);
> > > +					break;
> > > +				}
> > > +
> > > +				ptype =3D cu__type(cu, ptype->type);
> > >  			}
> > >  			if (ptype->tag =3D=3D DW_TAG_subroutine_type) {
> > >  				printed +=3D ftype__fprintf(tag__ftype(ptype),
> >=20
> > This explains why '*' was missing, but unfortunately it breaks apart
> > when there are multiple type tags, e.g.:
> >=20
> >=20
> >     $ cat tag-test.c
> >     #define __t __attribute__((btf_type_tag("t1")))
> >    =20
> >     struct foo {
> >       int  (__t __t *a)(void);
> >     } g;
> >     $ clang -g -c tag-test.c -o tag-test.o && pahole -J tag-test.o && p=
ahole --sort -F dwarf tag-test.o
> >     struct foo {
> >     	int ()(void)   *           a;                    /*     0     8 */
> >    =20
> >     	/* size: 8, cachelines: 1, members: 1 */
> >     	/* last cacheline: 8 bytes */
> >     };
> >     $ clang -g -c tag-test.c -o tag-test.o && pahole -J tag-test.o && p=
ahole --sort -F btf tag-test.o
> >     struct foo {
> >     	int ()(void)   *           a;                    /*     0     8 */
> >    =20
> >     	/* size: 8, cachelines: 1, members: 1 */
> >     	/* last cacheline: 8 bytes */
> >     };
> >    =20
> > What I don't understand is why pointer's type is LLVM_annotation.
>=20
> Well, that is how it is encoded in BTF and then you supported it in:
>=20
> Author: Eduard Zingerman <eddyz87@gmail.com>
> Date:   Wed Mar 15 01:04:14 2023 +0200
>=20
>     btf_loader: A hack for BTF import of btf_type_tag attributes`

To be honest, I was under impression that I add a workaround and the
preferred way is to do what dwarf loader does with
btf_type_tag_ptr_type::annots.
=20
> I find it natural, and think that annots thing is a variation on how to
> store modifiers for types, see, this DW_TAG_LLVM_annotation is in the
> same class as 'restrict', 'const', 'volatile', "atomic", etc
>=20
> I understand that for encoding _DWARF_ people preferred to make it as a
> child DIE to avoid breaking existing DWARF consumers, but in
> pahole's dwarf_loader.c we can just make it work like BTF and insert the
> btf_type_tag in the chain, just like 'const', etc, no?
>=20
> pahole wants to print those annotation just like it prints 'const',
> 'volatile', etc.

Actually, if reflecting physical structure of the DWARF is not a goal,
forgoing "annots" fields altogether and treating type tags as derived
types should make support for btf:type_tag (the v2 version) simpler.

Then, getting back to the current issue, I need to add
skip_llvm_annotations function with a loop inside, right?

> > Probably, the cleanest solution would be to make DWARF and BTF loaders
> > work in a similar way and attach LLVM_annotation as `annots` field of
> > the `struct btf_type_tag_ptr_type`. Thus, avoiding 'LLVM_annotation's
> > in the middle of type chains. I'll work on this.
>=20

