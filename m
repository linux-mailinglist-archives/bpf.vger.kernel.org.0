Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB466D56CE
	for <lists+bpf@lfdr.de>; Tue,  4 Apr 2023 04:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjDDChK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Apr 2023 22:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjDDChJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Apr 2023 22:37:09 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811B2CF;
        Mon,  3 Apr 2023 19:37:08 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id mp3-20020a17090b190300b0023fcc8ce113so34649600pjb.4;
        Mon, 03 Apr 2023 19:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680575828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CysjAL8xaOZiVUkW1bgeC1vlXFTE3Kt0mpBjBQvx5vc=;
        b=jYBkisAFXF77CKha6BzD2oKkQralA+8xeLjtsj9X/cinmUB8talM84UqVJ71ZHILCA
         01R+pUk16Jyj5OQdLsWebpE3xfTKXbB5e8C9ReJZWdMhERUvHhJLQGzdW7Zhrkb86iJi
         RvemFSqe/syjmXzv7RpgVOtQzvflBdwQY2b9ODTEyrbqjE6+BUOADScXTNEKEyp/svvI
         D2ao0xjfQC1s20RHF4FsuDbHRtVi134N48Ts4i/QepMdQWvcLPUw0741bZAAzVQ2Nk0t
         PWrYyySKXSMm6i2S6Mjy22kx4v/pX34BSt9X9pFksxmCAE9eQv225xoVebud9WaL7ESU
         /ywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680575828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CysjAL8xaOZiVUkW1bgeC1vlXFTE3Kt0mpBjBQvx5vc=;
        b=QxM3z6RnSPDhKCHDB3PxZF35inDwPfwKLzAUVawHshI5vw0g1ysO4bsqcZPRQBlf+s
         4EYincZMO2vFk+qW6i8U/xnDnTjGBknOaxPxMzDAdpXLyoVTzH56Id3O2pCV8mqx3xJ3
         Uiai8Os00HfNpMnlU2SB4MsKwX9WNdwamyUtvBY9If3hk084Bk2AKXPi160SblxqBvSr
         Uai0EOkv/PyX9C9X6I0Q8QwCwBDqbvVgB7ih43YvJl1Ras5uqiZ4ZxLSuj5EEV2SBYkI
         xXUxnaIEg/1AJS5zGqN/Ds103YkD5nmED3VLJbyo7tR5OGYA7cJDzsK3PyPj+ddpMHmj
         mTHw==
X-Gm-Message-State: AAQBX9eCy3CgAfudK5CezbfwUITCygVcH40njQovs9wCfnqSfSADlqqc
        WdPaLxhVa8Is7M3HlvqoDYZY8KFV58E=
X-Google-Smtp-Source: AKy350YaDqd6LcHIdtHsv2fSMxfA4CTRARCemBfenBRx5+D6uTEn+Eb2dPBcgKC4MuBsZ8p/W19UAg==
X-Received: by 2002:a17:902:c406:b0:1a2:6f9f:de16 with SMTP id k6-20020a170902c40600b001a26f9fde16mr1231952plk.11.1680575827888;
        Mon, 03 Apr 2023 19:37:07 -0700 (PDT)
Received: from debian.me (subs28-116-206-12-40.three.co.id. [116.206.12.40])
        by smtp.gmail.com with ESMTPSA id kr15-20020a170903080f00b001a1ca6dc38csm7228079plb.118.2023.04.03.19.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 19:37:07 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 3FE33106782; Tue,  4 Apr 2023 09:37:05 +0700 (WIB)
Date:   Tue, 4 Apr 2023 09:37:05 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Joe Stringer <joe@isovalent.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ast@kernel.org, corbet@lwn.net,
        martin.lau@linux.dev, maxtram95@gmail.com, john.fastabend@gmail.com
Subject: Re: [PATCH bpf-next v4 1/2] docs/bpf: Add table to describe LRU
 properties
Message-ID: <ZCuNUeMiARuEfaDY@debian.me>
References: <20230401200651.1022113-1-joe@isovalent.com>
 <ZCpMv1UHM1Vn+/ha@debian.me>
 <CADa=RyzmpE-XwOan0B5s20yi58EbM2VUFZDSLaGJQ3nnWgzvWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sctaaJx8NKROVx/r"
Content-Disposition: inline
In-Reply-To: <CADa=RyzmpE-XwOan0B5s20yi58EbM2VUFZDSLaGJQ3nnWgzvWw@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--sctaaJx8NKROVx/r
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 03, 2023 at 03:14:39PM -0700, Joe Stringer wrote:
> On Sun, Apr 2, 2023 at 8:49=E2=80=AFPM Bagas Sanjaya <bagasdotme@gmail.co=
m> wrote:
> >
> > On Sat, Apr 01, 2023 at 01:06:50PM -0700, Joe Stringer wrote:
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +Flag                     ``BPF_MAP_TYPE_LRU_HASH`` ``BPF_MAP_TYPE_LR=
U_PERCPU_HASH``
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +``BPF_F_NO_COMMON_LRU``  Per-CPU LRU, global map   Per-CPU LRU, per-=
cpu map
> > > +``!BPF_F_NO_COMMON_LRU`` Global LRU, global map    Global LRU, per-c=
pu map
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > The header column entries should also be bold (as above is two-way
> > table).
>=20
> They look bold to me already, do I need to take any action here?

Oops, I mean the "Flag" column is the header column.

--=20
An old man doll... just what I always wanted! - Clara

--sctaaJx8NKROVx/r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZCuNUAAKCRD2uYlJVVFO
o6r7AP90Nd8COJZ2duXcJIFCjeD3L6eJnBzXKv01yXVnqDrngwEA/InGECZz/nfj
ORcDT+zxcAiZ/Wfbpiuo3XsxSE6QCA4=
=BMwQ
-----END PGP SIGNATURE-----

--sctaaJx8NKROVx/r--
