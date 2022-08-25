Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6763C5A1CCC
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 00:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244247AbiHYWy3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 18:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243874AbiHYWy2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 18:54:28 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034C4C6E8D;
        Thu, 25 Aug 2022 15:54:28 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-f2a4c51c45so26830670fac.9;
        Thu, 25 Aug 2022 15:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=E25nHVfEZ0WIQ/xBi9sgLNWD+V0k+33LB0vITX3myko=;
        b=cpcYrcMAnc9z4U+YP20lmVZIc94hG+waZXD5TXBb5IDbUy2uDLeJEvCLCVCOsOxgKV
         /ShVW1X6mzEVPK8MnxAEV5/1cv6etJEfnlCYihJlw1B6/dTlklOCcyTzLLhTtRgigv0m
         ifLAOPGPqzbnXz1SW2pk8dRJ/2oPsXOi66lgEA2VPGO8QQpeYPcTvJSutzQ97X1aaQ5y
         ESfEIaTx7bXCGA+miNvqm+L4QTGCQBgc82nLs3GEVbyqwOosLbUOox6I43RRKdoBWUnY
         O+7CA9o5JJQHHYKXG41/BbPa3Xoc0GQ8hucdtPvf0UPg8QEW1fX0Xh1jm5mIcDAyiFWq
         TMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=E25nHVfEZ0WIQ/xBi9sgLNWD+V0k+33LB0vITX3myko=;
        b=WQBwYbGfg8OEWtylQwvOaXMdX9EcEMJ9fjWAUwHL89qhIjFMaRK/VnzySnMnlzmyzK
         7ZRnuCLvoSZ82SOVhYA3PBLiy2yXvW8gbmuu07zM5pGKWPnOlSRPCiDBEAZBr8qMLIcP
         uO4v7/EA/K6DHCyCsRHxNLYy7nqAQvumXBZbhBxOyRBmFc9n8EdhH65U7PrsUU4tjlVv
         uKBKLTVfeUGw8dHipQHwAvZnHCXgReilZjvFGRJup4zodiUP7JXONyUyuCs4ZaI6typk
         p3eonddd9oispW1KDmDI0cCHvwuQtDyw/t9nCTq60hnzoGV1hBG+j9Crjf2ICit/gfMW
         rtnQ==
X-Gm-Message-State: ACgBeo2wI1B/Vc576vKXc0KRFkcsEziIEbW+YLw2P4P0i3zw52XYJUTV
        Wxl4JzsXaukDUSBJhTEAin0=
X-Google-Smtp-Source: AA6agR4hxLWJUOVrcwbviYCeBqHIoLzJP2cM4HgrKCRIhVeLLJEf9LzQ/Abd3HhrS8Bw0uKsYh1l1Q==
X-Received: by 2002:a05:6870:b294:b0:11c:eb9e:1689 with SMTP id c20-20020a056870b29400b0011ceb9e1689mr584877oao.222.1661468067372;
        Thu, 25 Aug 2022 15:54:27 -0700 (PDT)
Received: from illithid (ip68-12-97-90.ok.ok.cox.net. [68.12.97.90])
        by smtp.gmail.com with ESMTPSA id o32-20020a05687107a000b0011e37fb5493sm306361oap.30.2022.08.25.15.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 15:54:26 -0700 (PDT)
Date:   Thu, 25 Aug 2022 17:54:25 -0500
From:   "G. Branden Robinson" <g.branden.robinson@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>,
        bpf <bpf@vger.kernel.org>, linux-man <linux-man@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH] Fit line in 80 columns
Message-ID: <20220825225425.hp2ylp5rxq453ewl@illithid>
References: <20220825175653.131125-1-alx.manpages@gmail.com>
 <CAADnVQ+yM_R4vuCLxtNJb0sp61ar=grJh9KmLWVGhXA7Lhpmvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3rejfv3motdhmezw"
Content-Disposition: inline
In-Reply-To: <CAADnVQ+yM_R4vuCLxtNJb0sp61ar=grJh9KmLWVGhXA7Lhpmvw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--3rejfv3motdhmezw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[sorry for the big CC]

At 2022-08-25T11:06:55-0700, Alexei Starovoitov wrote:
> Nack.
>=20
> We don't follow 80 char limit and are not going to because of man
> pages.

If someone got a contract with O'Reilly or No Starch Press to write a
book on BPF and how revolutionarily awesome it is, it's conceivable they
would be faced with exposing some BPF-related function declarations in
the text.  In cases like the following, what would you have them do?

int bpf_map_update_elem(struct bpf_map *map, const void *key, const void *v=
alue, u64 flags)

Be aware that the author may not have infinite flexibility; publishers
generally impose a "house style" which restricts selection of typeface
(so they can't necessarily print at a smaller type size or with the
kerning reduced beyond a certain point to squeeze the text onto the
line).

Regards,
Branden

--3rejfv3motdhmezw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh3PWHWjjDgcrENwa0Z6cfXEmbc4FAmMH/ZUACgkQ0Z6cfXEm
bc71iA/+Ow7NqV7fKo/VYUvuUDpif1UnYPK9t/Ig0wjpJL0peHD+Rt7IbYK8DG5v
9cSJZxzzghWXsipjRsiR4Z6+IpQJVQVXr0/PXhu8FSfNCung0H3XKfgvLvOhPekn
UVXXsEC1LzXEycZzsC+xoraCgFg5m39WWhqUb4lZIdQXrX6ffMn1kBz/UbzKIN+O
it48ynF8wOOzYxffP+Iu+t5H9u8JQ4wBsE8EbNhxNG6oTUxkjIcM71wa8OoKzcwS
3SVPd3cOSjtM7uY1hppz1Vgr/2IgJBPbWveLsfnfYWDR3YrI8tYQ1OriFMDgHc3Y
kPQ4RgsemyhEmlsaZJlQW/5rR68w35mPh+2f0w0yv+2Cu+4B+fzQ3hErziMqv+Ah
Tn9DNi3vxwQDFDrlZa8AoGQheoHpp+xQQfenKIu4EiS7wVZeAXBvd3z728LM0yXM
W4My13JA8AUCvtk2EaJy3Tt39IjyLkku8WkRjFfhdhhhTTK7Flp+fQaqd9uMuODh
2Lq7Qy4KSVaD5Bg22tC4blDJNWBbWGT3hukxcq0dEbNdncIeR2G+/6Hw8ZBdXUBM
5Rsbow13lk0TRi1US79Qmhf+CW3WQfc1HMIfE21Lso+uvB4R2o03R+U0V9hBkn56
xHG5GurYh5DaiDdfJU3ieiHZN7PS6+SqnpEVHRYaJ4z4GhzgFiI=
=T6w9
-----END PGP SIGNATURE-----

--3rejfv3motdhmezw--
