Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFEF67DF22
	for <lists+bpf@lfdr.de>; Fri, 27 Jan 2023 09:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbjA0I3z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 03:29:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232461AbjA0I3y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 03:29:54 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201022D44;
        Fri, 27 Jan 2023 00:29:54 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id p24so4246519plw.11;
        Fri, 27 Jan 2023 00:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8zIr5gAVnWijcyRaLm+OnfSZglQ9EcoIIIGF0BoAjyQ=;
        b=YWGl3SYdESIJohPgPUPXBxEjhsN3/Q9Bj2pSbYOb7p+IzWMotAiuUlbo8zjzZIqKmd
         G1MYB98UjDR3xW7mUooubXf8rSMVHoqOFz/P75ulnt3Mki347snb1aWjRsv2JwjWtV1m
         Xl4oCmO9trDJWVvi9ke7eCGXuhcBwGtSXhA31cL/OvE8amNpsEi5cQ6WNijohbuvGNfl
         9X/Aoh8rZi8Pdqp4NgIqw32HZWne6kpNA5dn/cm0ZUfwh5nyqUYvQJ1LB8QSFnOSO5Hy
         7FobIwqhcHEhsJ1X02g5K4EUh5KPNRn8csFksnOIsskRasFQmM5XnOefzhr+OpzyxZ0m
         6rKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8zIr5gAVnWijcyRaLm+OnfSZglQ9EcoIIIGF0BoAjyQ=;
        b=MP/E+YY37EIG+S+Zv74gYXlPB0H8E9viUI+SNi+5TEC3A58DoysWT3PJ0ELK1wnmuB
         brinOUCYuIOaV5jw+DpQlGIYodUgStwnmq4gFQvBNgFni0DqgttryFKMaBjnjqi/dF1G
         qm8hs8w2Z9Wsmb6HyUArvDDr7t7WH1FkRVhHVNRIh4AAXbKy4Rh4azQHDF/uM7oLn7CE
         dYhvNwQXUOHL/nKd6E06eupa7yEcJTYrF7vsRhqBUR9gijRB5S6FZDm4j6npX7APIPxk
         Sitp6vUqHayCyBoTyVVleTgj3sXcA/DbJZin956VLdIHiyuzofJvUDxx1lUjsF5+ywME
         Tszg==
X-Gm-Message-State: AO0yUKU2k1muM0z2xikESvGHEK/dJAQdirBeLJm9ZdnBWb9+9+r+jkrt
        oD94PuVC6bMBD/3zoUj9ryc=
X-Google-Smtp-Source: AK7set9TFkR92TOLXtRegT9TQsmGNdp61otzkT1Ysia7b69lp2ouzPTQQx9rNlyWk9A6sDr8+yuLTQ==
X-Received: by 2002:a05:6a20:3f93:b0:b9:5fc6:9ed6 with SMTP id ay19-20020a056a203f9300b000b95fc69ed6mr3975620pzb.37.1674808193509;
        Fri, 27 Jan 2023 00:29:53 -0800 (PST)
Received: from debian.me (subs02-180-214-232-24.three.co.id. [180.214.232.24])
        by smtp.gmail.com with ESMTPSA id t21-20020a056a00139500b00588d5c8b633sm1265496pfg.51.2023.01.27.00.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 00:29:52 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 7B1A0105582; Fri, 27 Jan 2023 15:29:50 +0700 (WIB)
Date:   Fri, 27 Jan 2023 15:29:50 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 04/35] Documentation: bpf: correct spelling
Message-ID: <Y9OLfsdbciFfn8ci@debian.me>
References: <20230127064005.1558-1-rdunlap@infradead.org>
 <20230127064005.1558-5-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8VtioyVUTN4tisD6"
Content-Disposition: inline
In-Reply-To: <20230127064005.1558-5-rdunlap@infradead.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--8VtioyVUTN4tisD6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 26, 2023 at 10:39:34PM -0800, Randy Dunlap wrote:
> diff -- a/Documentation/bpf/libbpf/libbpf_naming_convention.rst b/Documen=
tation/bpf/libbpf/libbpf_naming_convention.rst
> --- a/Documentation/bpf/libbpf/libbpf_naming_convention.rst
> +++ b/Documentation/bpf/libbpf/libbpf_naming_convention.rst
> @@ -83,8 +83,8 @@ This prevents from accidentally exportin
>  to be a part of ABI what, in turn, improves both libbpf developer- and
>  user-experiences.
> =20
> -ABI versionning
> ----------------
> +ABI versioning
> +--------------
> =20
>  To make future ABI extensions possible libbpf ABI is versioned.
>  Versioning is implemented by ``libbpf.map`` version script that is
> @@ -148,7 +148,7 @@ API documentation convention
>  The libbpf API is documented via comments above definitions in
>  header files. These comments can be rendered by doxygen and sphinx
>  for well organized html output. This section describes the
> -convention in which these comments should be formated.
> +convention in which these comments should be formatted.
> =20
>  Here is an example from btf.h:
> =20
> diff -- a/Documentation/bpf/map_xskmap.rst b/Documentation/bpf/map_xskmap=
=2Erst
> --- a/Documentation/bpf/map_xskmap.rst
> +++ b/Documentation/bpf/map_xskmap.rst
> @@ -178,7 +178,7 @@ The following code snippet shows how to
> =20
>  For an example on how create AF_XDP sockets, please see the AF_XDP-examp=
le and
>  AF_XDP-forwarding programs in the `bpf-examples`_ directory in the `libx=
dp`_ repository.
> -For a detailed explaination of the AF_XDP interface please see:
> +For a detailed explanation of the AF_XDP interface please see:
> =20
>  - `libxdp-readme`_.
>  - `AF_XDP`_ kernel documentation.
> diff -- a/Documentation/bpf/ringbuf.rst b/Documentation/bpf/ringbuf.rst
> --- a/Documentation/bpf/ringbuf.rst
> +++ b/Documentation/bpf/ringbuf.rst
> @@ -124,7 +124,7 @@ buffer.  Currently 4 are supported:
> =20
>  - ``BPF_RB_AVAIL_DATA`` returns amount of unconsumed data in ring buffer;
>  - ``BPF_RB_RING_SIZE`` returns the size of ring buffer;
> -- ``BPF_RB_CONS_POS``/``BPF_RB_PROD_POS`` returns current logical possit=
ion
> +- ``BPF_RB_CONS_POS``/``BPF_RB_PROD_POS`` returns current logical positi=
on
>    of consumer/producer, respectively.
> =20
>  Returned values are momentarily snapshots of ring buffer state and could=
 be
> @@ -146,7 +146,7 @@ Design and Implementation
>  This reserve/commit schema allows a natural way for multiple producers, =
either
>  on different CPUs or even on the same CPU/in the same BPF program, to re=
serve
>  independent records and work with them without blocking other producers.=
 This
> -means that if BPF program was interruped by another BPF program sharing =
the
> +means that if BPF program was interrupted by another BPF program sharing=
 the
>  same ring buffer, they will both get a record reserved (provided there is
>  enough space left) and can work with it and submit it independently. This
>  applies to NMI context as well, except that due to using a spinlock duri=
ng
> diff -- a/Documentation/bpf/verifier.rst b/Documentation/bpf/verifier.rst
> --- a/Documentation/bpf/verifier.rst
> +++ b/Documentation/bpf/verifier.rst
> @@ -192,7 +192,7 @@ checked and found to be non-NULL, all co
>  As well as range-checking, the tracked information is also used for enfo=
rcing
>  alignment of pointer accesses.  For instance, on most systems the packet=
 pointer
>  is 2 bytes after a 4-byte alignment.  If a program adds 14 bytes to that=
 to jump
> -over the Ethernet header, then reads IHL and addes (IHL * 4), the result=
ing
> +over the Ethernet header, then reads IHL and adds (IHL * 4), the resulti=
ng
>  pointer will have a variable offset known to be 4n+2 for some n, so addi=
ng the 2
>  bytes (NET_IP_ALIGN) gives a 4-byte alignment and so word-sized accesses=
 through
>  that pointer are safe.

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--8VtioyVUTN4tisD6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY9OLfgAKCRD2uYlJVVFO
ozuXAQCB5UxjVhQ3xxWchRhur4lG5s9CYc/fsuW7jqlPKj/UXgEA0M4YfwzPwVTX
Dq1ic3dGsCjSy8H0B+vycS7Kr23SAgc=
=7ld7
-----END PGP SIGNATURE-----

--8VtioyVUTN4tisD6--
