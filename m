Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25BC36D04CC
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 14:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjC3Me1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 08:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjC3Me1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 08:34:27 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD10E273C;
        Thu, 30 Mar 2023 05:34:25 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id g17so24322319lfv.4;
        Thu, 30 Mar 2023 05:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680179664; x=1682771664;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ggXhUKUwm9DY9z4cWjwYTXxx4kU0AoG0OBgXPBVx/Mo=;
        b=kQ+2tbXuhdvsGmzgwSS7I3vkL9lqxuoTLN6DyGLHhkC8ZGeAz7+iNseKOq5zHNA94w
         KPOLvYztHs8Akce6JlGwibLYuyHj3pIx86IOJRbeVfscpd2FQIyl/smHZfKyVhG3K0+N
         LUKUlz0CDLqg8/CD5HKIxko3hGXFbdRqVNvRK2sZfW7pi9NCjIRjj6HQEInaIVdwBOed
         RzPRWY58MhMmbPdlV1RUerk8tt1hjb2ErXz95Tn9UeMREVobjtwGnhfk8+glVfHX6PlI
         rQu/b8d0JI7rdYawT2O9Qi5D7EEt9ik3bAnm5ltO533lH/i95T/uwkER1qrtRvd+Ko8f
         hCng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680179664; x=1682771664;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ggXhUKUwm9DY9z4cWjwYTXxx4kU0AoG0OBgXPBVx/Mo=;
        b=Q9E4RhaNXupIrwU7S+InCOVm2ahqKUfx9kknQ/WID1RkB9n+OcbIWyiIn9Ucm/N+qi
         qr6G2IRY6T0YUdZq7y2gTBlYUDqOsLn/Eyg9NDEciiItJHRQlnuOCYSipGw7TFMEfwaW
         cJnnVlF4UISUl1K0IFs5SwThBadrEEPOlxY1ExGR4GL03Svsf7r6z0j0L0taiH8BHnrM
         c0wNnm6KFGmWAMY7SXpA+yAih7J8HpH8eZcNJmEBgQJ5YFIrYJK7V/uKPMLOIu452zsC
         unDOYh1YHUbhxIyNSiguv64o6tyS747X2VXAYNbCfVfUhE3Pm5U9o9bV1tqb5HB2pJ73
         x3/g==
X-Gm-Message-State: AAQBX9e057lGOElysq2tuJ6+cvRLTalfPjuujLSDO92Gk5X0Tl3zQJ3P
        MSiyVJEf/QRHirmBrfA5KF8=
X-Google-Smtp-Source: AKy350ZBMuyOHLR1mXFvyhzq2G/qKc1BKt+uQahAq1TgMisujfBZOl6IuvyOzBzUa7DzUGw7KJrNVQ==
X-Received: by 2002:ac2:4352:0:b0:4d5:8f3e:7852 with SMTP id o18-20020ac24352000000b004d58f3e7852mr6752642lfl.49.1680179663888;
        Thu, 30 Mar 2023 05:34:23 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id d7-20020ac25ec7000000b004e887fd71acsm5783091lfq.236.2023.03.30.05.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 05:34:23 -0700 (PDT)
Message-ID: <4bf1422bf63f9d3fe9b22ab3befa04ed072af9b4.camel@gmail.com>
Subject: Re: [PATCH dwarves v2 1/5] fprintf: Correct names for types with
 btf_type_tag attribute
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, jose.marchesi@oracle.com, david.faust@oracle.com,
        alan.maguire@oracle.com
Date:   Thu, 30 Mar 2023 15:34:21 +0300
In-Reply-To: <ZCVygOn0+zKFEqW2@kernel.org>
References: <20230314230417.1507266-1-eddyz87@gmail.com>
         <20230314230417.1507266-2-eddyz87@gmail.com> <ZCLy0hjyR3KuYy3e@kernel.org>
         <f4803213ab27c65517eea19a12be78dd4ec9f6b0.camel@gmail.com>
         <ZCMHKFdmjVpOSNsJ@kernel.org>
         <50a160d802ad3f84e91cf05c8f541e0c2e388fc8.camel@gmail.com>
         <ZCNZcl1mkC9yhwDD@kernel.org>
         <fabfc71fd43be48f68019c911c6a3af1412f4635.camel@gmail.com>
         <ZCRctmB2yrwgsNMh@kernel.org>
         <f9664121426c5665ff0fc8cb61c466689beadd36.camel@gmail.com>
         <ZCVygOn0+zKFEqW2@kernel.org>
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

On Thu, 2023-03-30 at 08:29 -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Mar 29, 2023 at 07:02:45PM +0300, Eduard Zingerman escreveu:
> > On Wed, 2023-03-29 at 12:43 -0300, Arnaldo Carvalho de Melo wrote:
> > [...]
> > > > > diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
> > > > > index 1e6147a82056c188..1ecc24321bf8f975 100644
> > > > > --- a/dwarves_fprintf.c
> > > > > +++ b/dwarves_fprintf.c
> > > > > @@ -788,8 +788,15 @@ next_type:
> > > > >  			if (n)
> > > > >  				return printed + n;
> > > > >  			if (ptype->tag =3D=3D DW_TAG_LLVM_annotation) {
> > > > > -				type =3D ptype;
> > > > > -				goto next_type;
> > > > > +				// FIXME: Just skip this for now, we need to print this anno=
tation
> > > > > +				// to match the original source code.
> > > > > +
> > > > > +				if (ptype->type =3D=3D 0) {
> > > > > +					printed +=3D fprintf(fp, "%-*s %s", tconf.type_spacing, "vo=
id *", name);
> > > > > +					break;
> > > > > +				}
> > > > > +
> > > > > +				ptype =3D cu__type(cu, ptype->type);
> > > > >  			}
> > > > >  			if (ptype->tag =3D=3D DW_TAG_subroutine_type) {
> > > > >  				printed +=3D ftype__fprintf(tag__ftype(ptype),
> > > >=20
> > > > This explains why '*' was missing, but unfortunately it breaks apar=
t
> > > > when there are multiple type tags, e.g.:
> > > >=20
> > > >=20
> > > >     $ cat tag-test.c
> > > >     #define __t __attribute__((btf_type_tag("t1")))
> > > >    =20
> > > >     struct foo {
> > > >       int  (__t __t *a)(void);
> > > >     } g;
> > > >     $ clang -g -c tag-test.c -o tag-test.o && pahole -J tag-test.o =
&& pahole --sort -F dwarf tag-test.o
> > > >     struct foo {
> > > >     	int ()(void)   *           a;                    /*     0     =
8 */
> > > >    =20
> > > >     	/* size: 8, cachelines: 1, members: 1 */
> > > >     	/* last cacheline: 8 bytes */
> > > >     };
> > > >     $ clang -g -c tag-test.c -o tag-test.o && pahole -J tag-test.o =
&& pahole --sort -F btf tag-test.o
> > > >     struct foo {
> > > >     	int ()(void)   *           a;                    /*     0     =
8 */
> > > >    =20
> > > >     	/* size: 8, cachelines: 1, members: 1 */
> > > >     	/* last cacheline: 8 bytes */
> > > >     };
> > > >    =20
> > > > What I don't understand is why pointer's type is LLVM_annotation.
> > >=20
> > > Well, that is how it is encoded in BTF and then you supported it in:
> > >=20
> > > Author: Eduard Zingerman <eddyz87@gmail.com>
> > > Date:   Wed Mar 15 01:04:14 2023 +0200
> > >=20
> > >     btf_loader: A hack for BTF import of btf_type_tag attributes`
> >=20
> > To be honest, I was under impression that I add a workaround and the
> > preferred way is to do what dwarf loader does with
> > btf_type_tag_ptr_type::annots.
> > =20
> > > I find it natural, and think that annots thing is a variation on how =
to
> > > store modifiers for types, see, this DW_TAG_LLVM_annotation is in the
> > > same class as 'restrict', 'const', 'volatile', "atomic", etc
> > >=20
> > > I understand that for encoding _DWARF_ people preferred to make it as=
 a
> > > child DIE to avoid breaking existing DWARF consumers, but in
> > > pahole's dwarf_loader.c we can just make it work like BTF and insert =
the
> > > btf_type_tag in the chain, just like 'const', etc, no?
> > >=20
> > > pahole wants to print those annotation just like it prints 'const',
> > > 'volatile', etc.
> >=20
> > Actually, if reflecting physical structure of the DWARF is not a goal,
>=20
> Well reflecting the physical structure of DWARF _pre_
> DW_TAG_llvm_annotation was the goal, but now, since this was done
> differently of DW_TAG_const_type, DW_TAG_pointer_type, etc, as one link
> in the chain, to avoid breaking existing DWARF consumers, we ended up
> with this annot thing, but the internal representation in pahole can
> continue being as a chain, as BTF does, right?
=20
Ok, I'll rework the patch-set and we'll see, my expectation is that
working with BTF style structure would be simpler.

> > forgoing "annots" fields altogether and treating type tags as derived
> > types should make support for btf:type_tag (the v2 version) simpler.
>=20
> I think it should simplify as we're used to these chains.
> =20
> > Then, getting back to the current issue, I need to add
> > skip_llvm_annotations function with a loop inside, right?
>=20
> You can, to remove them completely and its like they don't exist for
> dwarf_fprintf.c, but what I think should be done is to actually print
> them, to reconstruct the original source code.
>=20
> You can start removing them and we can work later on properly printing
> it, so that we can get 1.25 out of the door as there are multiple
> requests for it to be released to solve other problems with using 1.24.

Understood, I'll send an update that ignores type tags properly today,
after some testing, and add printing as a follow-up.

>=20
> - Arnaldo
> =20
> > > > Probably, the cleanest solution would be to make DWARF and BTF load=
ers
> > > > work in a similar way and attach LLVM_annotation as `annots` field =
of
> > > > the `struct btf_type_tag_ptr_type`. Thus, avoiding 'LLVM_annotation=
's
> > > > in the middle of type chains. I'll work on this.

