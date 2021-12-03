Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07168466F3C
	for <lists+bpf@lfdr.de>; Fri,  3 Dec 2021 02:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbhLCBu5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Dec 2021 20:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbhLCBu5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Dec 2021 20:50:57 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95D0C06174A
        for <bpf@vger.kernel.org>; Thu,  2 Dec 2021 17:47:32 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4J4wgQ392hz4xR7;
        Fri,  3 Dec 2021 12:47:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1638496050;
        bh=odhTNYDTLdHXrJ2LzkRdOAoB8l2dgHzkW8CVc5SVGNU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=R848chqek1lxcZFM2xAQ2+so6G/OTlTzQzh+z9M61A0Y6sTUMz6/1ffPxBUXyLd2c
         trgAbFR/aeCUEsf9ukZYygAE/aA80NLw+YMCTOM66wVWg3rPHSE2Z9YG3IUvYhnqkh
         6hj04Kh2ChJ8zM3fFFKM1wCjPa6kqQ0mGwm+BCqQBORDy0BcKQAQNU0hsex/AV3ATw
         Lf37Oq68Fjs3CzDDEtElxJDjs1T7Mp9zxEB515vKUIlaS1PNI3HGlyR0YCgoYgOUFQ
         w2DQ20sBQkuIP7nMwWn3mFukoozENcqPGsTiP/ZxZThZOaxq/LigJDgrJ04m/atYKx
         2va+B+bcwbjlA==
Date:   Fri, 3 Dec 2021 12:47:27 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH bpf-next] perf: mute libbpf API deprecations temporarily
Message-ID: <20211203124727.5a718792@canb.auug.org.au>
In-Reply-To: <CAEf4BzZe7bc6cRopJG4L6Et8OjCiGym8XzJPx_8NpyScwg_i=A@mail.gmail.com>
References: <20211203004640.2455717-1-andrii@kernel.org>
        <CAEf4BzZe7bc6cRopJG4L6Et8OjCiGym8XzJPx_8NpyScwg_i=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/eye5sTTJEmLnp.ZjUOdi/zA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

--Sig_/eye5sTTJEmLnp.ZjUOdi/zA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrii,

On Thu, 2 Dec 2021 17:00:40 -0800 Andrii Nakryiko <andrii.nakryiko@gmail.co=
m> wrote:
>
> This patch (when applied to bpf-next) should fix the build failure you
> reported in your recent "linux-next: build failure after merge of the
> bpf-next tree" email (that I didn't get directly, but thankfully
> Alexei forwarded to me). Can you please also cc bpf@vger.kernel.orgfor
> future bpf-next tree issues, as that's a more directly related mailing
> list (ideally also cc me at andrii@kernel.org directly so that we
> don't rely on Gmail not dropping the email, I've, unfortunately, had
> multiple problems with this recently). Thanks for understanding!

Hopefully that patch will be applied soon :-)

I have added the bpf list and you to my contacts for the bpf and
bpf-next trees in linux-next.

--=20
Cheers,
Stephen Rothwell

--Sig_/eye5sTTJEmLnp.ZjUOdi/zA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmGpdy8ACgkQAVBC80lX
0Gy1ZAf/QqvJFdlxOR38WaAp621uDeSv/+3+Tty84LEdm3ddEVD2KYkO9pQ62Ys7
9obQQt1VOSkEpQzk2ApRqBXPG0LsCqY2X0L4QimtlhBSZ3gnJAoX4MPt4jBeCLR2
v1if4NxGRaY4XYBbMBVEslvudxEG9PxgyuKqw2lsXyiwVKSNn/MM2+d19RE4fE4l
4LAQnY2sQu9/8xNbIU67jbIn2b49Zzz79uRYwIwGpmUjlgMwH+zCWEeTMAdXFyNR
YiHgQXI85D6xk33oFV6/qi0DqoFqzpkDyjLlwjqzvwVAbTp/4YDXAYv/HQQ7s6Yy
sQwlJVWi0oIGnXj5lV5HlAsBNtU7SQ==
=fR9b
-----END PGP SIGNATURE-----

--Sig_/eye5sTTJEmLnp.ZjUOdi/zA--
