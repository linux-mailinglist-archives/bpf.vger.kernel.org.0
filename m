Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB416D3C39
	for <lists+bpf@lfdr.de>; Mon,  3 Apr 2023 05:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjDCDtZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 2 Apr 2023 23:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjDCDtY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 2 Apr 2023 23:49:24 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BAC3C0D;
        Sun,  2 Apr 2023 20:49:23 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id qe8-20020a17090b4f8800b0023f07253a2cso29064746pjb.3;
        Sun, 02 Apr 2023 20:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680493763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hSpCeiWTLoNYlU3twoSjpjdZE17k0wnur+N9kd3ceos=;
        b=UDzO5m2bxIlbtquMzTiaD9SBh/1Ll5orRQHwLU1tcsMwddSoJtoYW9I7cvqcAITTl2
         Yven6Mtx+1ihD7D/yVWaVQRt8o9veePW0gk7qHKtp2JHQJNQCtOVyZbZY9RXzCc/hzNl
         dwAJ1umihAx86gjUz7/R0z9NWcZrHAK4A9pFeq3+h7T/nzhscq6PTkLJAoRR6xpX3gye
         EJjXgJzmow2hVaFWnRekGBBLFq+ucO8r+/Y+Lj2ktIX+cF4p1PvI7DYQEx9PHP0LPO6P
         Ka5qChfM9RrWySkBKqRJKrsiy0e6ualwh0EV84drXdMdONZ+Lkqz9yS8ejszLMNEkLCQ
         SpCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680493763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hSpCeiWTLoNYlU3twoSjpjdZE17k0wnur+N9kd3ceos=;
        b=S2VfC+2zloOL7fHYQ1F1C2mme1Syf/WsJIKShWcKry34gDkDq7sGQWdmEJ3gbiCwzD
         8FNWbI/aCHhVPKevXU90ccUbhS5szbee3HTS7JYp4hb0AyszgtpyYn5U1F3Rk6a5i/dq
         R3PxeXO27Lsz26EgLpFxbu5oB7iKK5tzDV2ilIN+xKEJHVRfs4w+GYM7cy4gb4QVtJdR
         YF2WZpRDVYj5twHoAOqpPtN6v7+wXZVSoZIqR2ElInc6OkkkOpyjluzfZ2uC6BXhDRir
         1x2x4pbA8zXAO6RAz3YN/KQEU7JOUsb9nWUbEzI5Y1rofqd9zzZC5Xo8QlYRaV18//E4
         pA1Q==
X-Gm-Message-State: AAQBX9cR8gykrWczvPubIUxg97cNMnWQIMoXDREv4jHi+5Qy3B33VSvS
        PA4kNnirgHYDZ+BXTxqCEA8=
X-Google-Smtp-Source: AKy350YEYTjQiQCDWWPDqEZAq/rydKgT/KdSw/z/RNS9JqK/Wq+MuuhAhjNwSWlz7uOn7hGwMoyijg==
X-Received: by 2002:a17:90b:3e82:b0:23f:78d6:6ac5 with SMTP id rj2-20020a17090b3e8200b0023f78d66ac5mr38049590pjb.19.1680493762758;
        Sun, 02 Apr 2023 20:49:22 -0700 (PDT)
Received: from debian.me (subs32-116-206-28-12.three.co.id. [116.206.28.12])
        by smtp.gmail.com with ESMTPSA id d4-20020a17090ac24400b0023a9564763bsm8686912pjx.29.2023.04.02.20.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 20:49:22 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 328FF10679D; Mon,  3 Apr 2023 10:49:19 +0700 (WIB)
Date:   Mon, 3 Apr 2023 10:49:19 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Joe Stringer <joe@isovalent.com>, bpf@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, corbet@lwn.net, martin.lau@linux.dev,
        maxtram95@gmail.com, john.fastabend@gmail.com
Subject: Re: [PATCH bpf-next v4 1/2] docs/bpf: Add table to describe LRU
 properties
Message-ID: <ZCpMv1UHM1Vn+/ha@debian.me>
References: <20230401200651.1022113-1-joe@isovalent.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gOT6x8ZZfn7TPL2q"
Content-Disposition: inline
In-Reply-To: <20230401200651.1022113-1-joe@isovalent.com>
X-Spam-Status: No, score=1.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--gOT6x8ZZfn7TPL2q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 01, 2023 at 01:06:50PM -0700, Joe Stringer wrote:
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Flag                     ``BPF_MAP_TYPE_LRU_HASH`` ``BPF_MAP_TYPE_LRU_PE=
RCPU_HASH``
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +``BPF_F_NO_COMMON_LRU``  Per-CPU LRU, global map   Per-CPU LRU, per-cpu =
map
> +``!BPF_F_NO_COMMON_LRU`` Global LRU, global map    Global LRU, per-cpu m=
ap
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D

The header column entries should also be bold (as above is two-way
table).

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--gOT6x8ZZfn7TPL2q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZCpMvgAKCRD2uYlJVVFO
owS0AQDMY5hCmbxTWOgc4GZ4EC7lIyyxIEufR490v1nrcveRDAD7BHmuGdo6O1YO
7RC3GG6d7RG+8LnYQ0J0oNXniZ71LgQ=
=6tC6
-----END PGP SIGNATURE-----

--gOT6x8ZZfn7TPL2q--
