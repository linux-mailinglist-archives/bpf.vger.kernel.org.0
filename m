Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD10860DC90
	for <lists+bpf@lfdr.de>; Wed, 26 Oct 2022 09:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbiJZHxC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Oct 2022 03:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232944AbiJZHxC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Oct 2022 03:53:02 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87AF372682;
        Wed, 26 Oct 2022 00:53:01 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id t10-20020a17090a4e4a00b0020af4bcae10so1420802pjl.3;
        Wed, 26 Oct 2022 00:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3X0WtYDknfUWiKBqsKZQOjyWjaRF3bZQgdQNY8pZSH8=;
        b=KZzdgBhnIn90K48dq5HDXj4rTIVmzuQLciBfV00Z2ViwqHEU54eaXYhgnT4RpvhD51
         7IiYdRGA6QFUwyOp4+JFOh4TgAjJ6RlEPw+ZdHOo4ib4IejoG7YHjiaJUW5VyczwXnEX
         VAySvxnPKFhj4QOPEsUL9doFZ+/OUuXT54MiQcx3m/yBJLhj/kCp1TJBR7J8BPZZUjb1
         TGj/IfG/2rZ1fuh/t0K8G8bBjI8c41WzISAA4RKrNIFE7tM4wEQXWMXVp+HjBUs7axq+
         Eqwz3DXsL5kzbCLcfU00s7YPggzfgS0ptLDNA3eUbmi/DwNH7MG+ISCIhkC6itLwc6ny
         fx0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3X0WtYDknfUWiKBqsKZQOjyWjaRF3bZQgdQNY8pZSH8=;
        b=UQMEw2DdlLeQ7zbyL9isVYZeAjNmIec4dVJJpK22P6z1olEDcn46YNj5X0xHcdLyd/
         fbHpOZ8Xogsix2Aw8p3ORrJ9zu7u2eQVaDZNzpv3Nj1wRi2pFTqbX3uuRfGm0A9qMlTh
         eBmIWX7DFiqI5pSEUO6aFuCIAsb1KNjJSN9tUm8ge2smVjkGikWNupHswZute6IIcABO
         Ijlv8VT4duu14kjRPsLUl4fLlfE9Kmiikds7h5Q/g0kDKk1cCYR/owGsSzVvZJlsY2r+
         zHDuxljzkIxqcg3OYcLpHiM9VAZPa80mjJaEjndgCEciP3U/lrwwZrK5Ir5i+6frQoEQ
         hjSQ==
X-Gm-Message-State: ACrzQf2zwBbOxpRORPdWbTcUGRkwjM2QcVuqfG3iyTNo36rTPDGt4U2f
        tAwF/AemRHKG9KKchWLTv4c=
X-Google-Smtp-Source: AMsMyM5xVAMU1kMGz/ewSxutFsEIJCY7IwNN0i49n54YQP+l/4FFuY3xdjm5UdoiEaYAEZfJKpufxA==
X-Received: by 2002:a17:902:d2c1:b0:186:9e90:6ad with SMTP id n1-20020a170902d2c100b001869e9006admr17036131plc.2.1666770781025;
        Wed, 26 Oct 2022 00:53:01 -0700 (PDT)
Received: from debian.me (subs09b-223-255-225-233.three.co.id. [223.255.225.233])
        by smtp.gmail.com with ESMTPSA id b5-20020a170902d50500b00186985198a4sm2335620plg.169.2022.10.26.00.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 00:53:00 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 1A341101C72; Wed, 26 Oct 2022 14:52:54 +0700 (WIB)
Date:   Wed, 26 Oct 2022 14:52:54 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Xu Kuohai <xukuohai@huaweicloud.com>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH bpf-next] bpf: Fix a typo in comment for DFS algorithm
Message-ID: <Y1jnVvcqVF8GanWZ@debian.me>
References: <20221026025941.2621795-1-xukuohai@huaweicloud.com>
 <CAADnVQ+Pe73yjys+fjW1TBPscCmv6K9ur5bDPr2056ejwBBdZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="47eVnAhvGpnp4nSH"
Content-Disposition: inline
In-Reply-To: <CAADnVQ+Pe73yjys+fjW1TBPscCmv6K9ur5bDPr2056ejwBBdZg@mail.gmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--47eVnAhvGpnp4nSH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 25, 2022 at 11:32:55PM -0700, Alexei Starovoitov wrote:
> On Tue, Oct 25, 2022 at 7:42 PM Xu Kuohai <xukuohai@huaweicloud.com> wrot=
e:
> >
> > From: Xu Kuohai <xukuohai@huawei.com>
> >
> > There is a typo in comment for DFS algorithm in bpf/verifier.c. The top
> > element should not be popped until all its neighbors have been checked.
> > Fix it.
> >
> > Fixes: 475fb78fbf48 ("bpf: verifier (add branch/goto checks)")
> > Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> > ---
> >  kernel/bpf/verifier.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index b83a8d420520..96ba5ea6d1a6 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -10662,7 +10662,7 @@ static int check_return_code(struct bpf_verifie=
r_env *env)
> >   * 3      let S be a stack
> >   * 4      S.push(v)
> >   * 5      while S is not empty
> > - * 6            t <- S.pop()
> > + * 6            t <- S.top()
>=20
> Even with this fix the comment is not quite accurate.
> I wonder whether we should keep it or delete it completely.
> At least please use 'peek' instead of 'top'.

I think the comment should be in words (like other code comments in the
kernel) instead.

--=20
An old man doll... just what I always wanted! - Clara

--47eVnAhvGpnp4nSH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY1jnUAAKCRD2uYlJVVFO
oyu9AQCeNlPJ7ghAPXOlIl89E68coYAZwcHC9wJLcKB6bCk8twD+Oo5a/j8Z1hNp
w3yE0p8rAlWX1EWftpLrD2DebbOD3g0=
=WY7J
-----END PGP SIGNATURE-----

--47eVnAhvGpnp4nSH--
