Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B226BA59E
	for <lists+bpf@lfdr.de>; Wed, 15 Mar 2023 04:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjCOD3b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Mar 2023 23:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbjCOD31 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Mar 2023 23:29:27 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021815AB41;
        Tue, 14 Mar 2023 20:29:02 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id p20so18646263plw.13;
        Tue, 14 Mar 2023 20:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678850942;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y5R/cI7TwWfezMpaOcvOvboGtJ12otQ+8XRuoypBee4=;
        b=hWYjUDw+JcnVahVBQyC2oh51nhXDZdz7TLegnfeXc1j1lgUB1Rh+kqlwdFJqn7AgLU
         Yaz+G7vKIgkaJpSFWwMjhoMYkzLkphjkdxkq5Lpy8uqTRnqWu1UPZcBBicOTovLPP2Rk
         zl82phAPbT0pmLTHINWG7amxpH3qYzjQGTI2KOEVxw35PYIGWZ8pdHNj6C13FGFmFRDK
         vF+EVxhaQpYf7VRF5q4K4HSpevjyhz0CqNHiMxrxw0HVoPVRm2LnW8ugMHh0FHwoT9Yi
         eWllSgpdbWogndzzXNVC8dQ0IrcJ0byfBachpa6eJj7gUXlBM2lnm/WeiEH/D8TBF4In
         I4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678850942;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y5R/cI7TwWfezMpaOcvOvboGtJ12otQ+8XRuoypBee4=;
        b=c6oWTdZovY6mrEz9tSb9MmZTgYmuWBbvkKwQ1uSp4MeSo63qUOEdYdvrstxMcd3tVq
         ZH3eKzBS98rI5JAYeymLtVHiGDV/c/c7/uzXsHzkGvhbZgV7TBl35LARVxEfx6MLkcGq
         81mzoj5nSaJ2iOuFftlhp7hrXWc0zXetHST3VFbJMFt3oWa1piuES5Kb/AGCikhGWwtL
         4NZtv/fA+Fp6HT0+DhUWq8eetEzJNQLjVqqiv2h7TxPPXY49zJN9P5lIMToKwLbe6X3J
         ppM7hI+FY8UzjnSnZDBcU/VbSQlTQrPES2QRzXFNXArqgzOd1qUBxppNO94RDy97bIUN
         z7AA==
X-Gm-Message-State: AO0yUKUco0dnZf2J2Ilxdt8ZJfG3kvyRGBeV5YXomQlrbotFdM+F+bmu
        KqAlUkgCDwKZm/ZyuVX2gIE=
X-Google-Smtp-Source: AK7set/RY2VgORdDYf9YUYNcWxftVuo+OPUeF21C0k3GDr8ha6RqcsqN3/P4HgQVkUKK7fN2N6pvsw==
X-Received: by 2002:a17:902:ecc7:b0:19e:8688:86fe with SMTP id a7-20020a170902ecc700b0019e868886femr1477105plh.42.1678850942252;
        Tue, 14 Mar 2023 20:29:02 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-17.three.co.id. [180.214.232.17])
        by smtp.gmail.com with ESMTPSA id jy11-20020a17090342cb00b0019edf07eb06sm2465198plb.122.2023.03.14.20.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 20:29:01 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id BF9FB1067B8; Wed, 15 Mar 2023 10:28:56 +0700 (WIB)
Date:   Wed, 15 Mar 2023 10:28:56 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     David Vernet <void@manifault.com>
Cc:     Sreevani Sreejith <ssreevani@meta.com>, psreep@gmail.com,
        bpf@vger.kernel.org, Linux-kernel@vger.kernel.org,
        andrii@kernel.org, mykola@meta.com, linux-doc@vger.kernel.org
Subject: Re: [PATCH V3 bpf-next] BPF, docs: libbpf Overview Document
Message-ID: <ZBE7eMsAifEQgRQv@debian.me>
References: <20230310180928.2462527-1-ssreevani@meta.com>
 <ZA7wm8scokV+XPav@debian.me>
 <20230313125947.GB2392@maniforge>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DH9SxApjontiwtqc"
Content-Disposition: inline
In-Reply-To: <20230313125947.GB2392@maniforge>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--DH9SxApjontiwtqc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 13, 2023 at 07:59:47AM -0500, David Vernet wrote:
> On Mon, Mar 13, 2023 at 04:44:59PM +0700, Bagas Sanjaya wrote:
> > On Fri, Mar 10, 2023 at 10:09:28AM -0800, Sreevani Sreejith wrote:
> > > From: Sreevani <ssreevani@meta.com>
> > >=20
> > > Summary: Document that provides an overview of libbpf features for BPF
> > > application development.
> >=20
> > It seems like you ignore some of my reviews at [1]. Anyway, I repeat
> > them here, augmenting my new comments.
>=20
> Sreevani, please be sure to reply to and address all reviewers'
> comments. I've also requested that we not use these internal Meta tags
> on more than one occasion, so please be mindful of it for future
> patches, and take a bit of extra time to double check that you've
> addressed all reviewers' concerns. I also suggest reading over [0],
> which specifies that new versions of patches should include descriptions
> of what's changed from prior versions. Please see Joanne's patch set in
> [1] which serves as a very nice example.
>=20
> [0]: https://www.kernel.org/doc/html/latest/process/submitting-patches.ht=
ml#the-canonical-patch-format
> [1]: https://lore.kernel.org/all/20230301154953.641654-1-joannelkoong@gma=
il.com/
>=20
> Bagas -- just FYI, a quick git log would have shown that this is only
> Sreevani's second patch. I don't think she intentionally ignored
> anything. It's likely just an artifact of getting used to the kernel
> review process.

Oops, you mean this v3 is actually v2, right?

> > Why did you add heading overline and change the heading character marke=
r?
>=20
> I assume that Sreevani is following python documentation conventions [0],=
 which
> suggest that #### with overline refers to the highest-level heading in a =
page.
> This is suggested in Sphinx documentation [1] as well.
>=20
> [0]: https://devguide.python.org/documentation/markup/#sections
> [1]: https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.h=
tml#sections

OK.

> > You may want to also add :lineos: option or manually add line numbers
> > if you add :emphasize-lines: so that readers can see the line number
> > it refers to.
>=20
> What is :lineos:? I don't see it anywhere else in Documentation/ and if
> I add it, the docs build complains:
>=20
> Documentation/bpf/libbpf/libbpf_overview.rst:177: WARNING: Error in "code=
-block" directive:
> unknown option: "lineos".
>=20
> .. code-block:: C
>   :lineos:
>   :emphasize-lines: 6

You forget to indent both options (see [1]).

>=20
>   //...
>   struct task_struct *task =3D (void *)bpf_get_current_task();
>   struct task_struct *parent_task;
>   int err;
>=20
>   err =3D bpf_core_read(&parent_task, sizeof(void *), &task->parent);
>   if (err) {
>     /* handle error */
>   }
>=20
>   /* parent_task contains the value of task->parent pointer */
>=20
> I personally think adding line numbers is overkill. The highlighting is
> already a nice touch, and gets the point across without the additional
> visual cue of line numbers.

But if the snippet above is instead long, how can one looking for the
emphasized line number when reading doc (especially in .rst source) other
than manually counting from the first line of the snippet? See
Documentation/RCU/rcubarrier.rst for example of manual line numbering
(and [2] for the related patch).

> > BPF apps are application that use BPF program, right? I thought that
> > despite there is libbpf-rs, I still have to develop BPF apps in C.
>=20
> It says that at the end of the paragraph?
>=20

I was confused between BPF apps and BPF programs, since I was accustomed
that apps and programs refer to the same thing.

Thanks.

[1]: https://www.sphinx-doc.org/en/master/usage/restructuredtext/directives=
=2Ehtml#directive-code-block
[2]: https://lore.kernel.org/linux-doc/e458e625-9a4e-da3f-13cd-a5b56fc36edf=
@gmail.com/
=20
--=20
An old man doll... just what I always wanted! - Clara

--DH9SxApjontiwtqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZBE7cwAKCRD2uYlJVVFO
o+5LAP9ugSb7TIpgtudL99VV//HsXkhOZ4qpN75tVchCYTxoqwEAgeT+i1PLPcaC
mGP+wG++6bhn9vLMJid7GJ0qACAwvgg=
=nrQt
-----END PGP SIGNATURE-----

--DH9SxApjontiwtqc--
