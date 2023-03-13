Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1EC96B6E3F
	for <lists+bpf@lfdr.de>; Mon, 13 Mar 2023 04:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjCMDzX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 12 Mar 2023 23:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjCMDyo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 12 Mar 2023 23:54:44 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4021A23D9D;
        Sun, 12 Mar 2023 20:54:29 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id j3-20020a17090adc8300b0023d09aea4a6so1276247pjv.5;
        Sun, 12 Mar 2023 20:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678679669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O8lGczpgHLvE7RnSt7vYDGP1Ii5/BaRcHQ5j2XjpcEI=;
        b=AOEg9z4W6nyOpMfbmQ8mraE0Ga0hnpauG19ItBJTeGP9fLoQW9MFXqU+YokrGfJTcM
         uo25ngtFHQ2ylwarPi5Z1mcmHCOfVUhOooLgbyqSR/b0QlyUaAblPFmhBLWbtTZhiVlC
         KDn7gcJuoF0ngglfPDt67/NTlMZ01wBrJTpK/XZjzFjUQSKlU22p2QMJo+ZVf54nxVqY
         KopWejd1kZOUJOf0lz4oEhsjU+Ovd7EhKIJLQGrU6gVT4z0QTQMrMLdrGpjaZcQtkVt+
         0zALEIwKnnABKY1b4XpEOwnPkcSGp2wT11pK83PMJGH2LmBQFQBmc1VMfv7udr/qEb6b
         vjXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678679669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O8lGczpgHLvE7RnSt7vYDGP1Ii5/BaRcHQ5j2XjpcEI=;
        b=zrFo2fc38hUo7iHIpxg40NhheIjuFZag3jTPhFLivcZhrQCGxCoJ9CEHJ1b03ZVfrB
         YTODAcvM4RjiTaEMNMJAhETcOS7EIvZqVVJ2zLWeu9A0JbhgxPwH4IVrZcSBuMRCJ9+9
         eWgB/XwnJD1OsgHCNOkb3VW9TbThiIMZHBnPTqn/10cvgeHq3KW0KOtrbSu+6/uYmDn7
         bKbka5t0gR1wut7nvtcP9Glv4i+gtVc65mHup/R4U4/YMlp+LAYCG5PQ6/IG5NnUfBL4
         iwmDh00CYX1wUI4L1mseTtvzhl6H9sWxmhEGcos8Nza2t7sHS3HF04xZf3U5X2hYMoX0
         /Jng==
X-Gm-Message-State: AO0yUKW5j+QnT7IntSvaZnYd8Oe7eA65kwDFJy+KORmqPU0eT4oPevPm
        xpZJEjxi7xpicBnh5NN5dm0lCnG86w4=
X-Google-Smtp-Source: AK7set/iuYwAf5IXs0Bj0MqQMOX0grcoVOtMs+GxyLKr2Va0GQeA2Z/SRQEH36+H4IjtHwPmkUaPpg==
X-Received: by 2002:a17:903:187:b0:19c:dc38:3eb5 with SMTP id z7-20020a170903018700b0019cdc383eb5mr43603213plg.14.1678679668694;
        Sun, 12 Mar 2023 20:54:28 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-24.three.co.id. [180.214.232.24])
        by smtp.gmail.com with ESMTPSA id kk3-20020a170903070300b0019f11caf11asm3567020plb.166.2023.03.12.20.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 20:54:28 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 620CC106689; Mon, 13 Mar 2023 10:54:25 +0700 (WIB)
Date:   Mon, 13 Mar 2023 10:54:25 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Joe Stringer <joe@isovalent.com>, bpf@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, corbet@lwn.net, martin.lau@linux.dev,
        maxtram95@gmail.com
Subject: Re: [PATCH bpf-next v3] docs/bpf: Add LRU internals description and
 graph
Message-ID: <ZA6ecdQl3STWVAH6@debian.me>
References: <20230312190600.324573-1-joe@isovalent.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/TLMb2wQzVHenkud"
Content-Disposition: inline
In-Reply-To: <20230312190600.324573-1-joe@isovalent.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--/TLMb2wQzVHenkud
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 12, 2023 at 12:05:59PM -0700, Joe Stringer wrote:
> +Even if an LRU node may be acquired, maps of type ``BPF_MAP_TYPE_LRU_HAS=
H``
> +may fail to insert the entry into the map if other CPUs are heavily cont=
ending
> +on the global hashmap lock.

"Even if an LRU node can be acquired, ..."

> +
> +This algorithm is described visually in the following diagram. See the
> +description in commit 3a08c2fd7634 ("bpf: LRU List") for a full explanat=
ion of
> +the corresponding operations:
> +
> +.. kernel-figure::  map_lru_hash_update.dot
> +   :alt:    Diagram outlining the LRU eviction steps taken during map up=
date
> +
> +   LRU hash eviction during map update for ``BPF_MAP_TYPE_LRU_HASH`` and
> +   variants
> +
> <snipped> ...
> +The dot file source for the above figure uses internal kernel function n=
ames
> +for the node names in order to make the corresponding logic easier to fi=
nd.

Shouldn't the figure note above be in :alt:?

Otherwise LGTM.

--=20
An old man doll... just what I always wanted! - Clara

--/TLMb2wQzVHenkud
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZA6ebQAKCRD2uYlJVVFO
o6i4AQDDoDu50SECyZ8tCj9UQ5Re9A/ZXIMWk4B2eh4IX+7HFwD9EFtVr2ElHKiq
l5QvSUwTEuKlyXwZaxETArCgEMkVvAw=
=Yi4J
-----END PGP SIGNATURE-----

--/TLMb2wQzVHenkud--
