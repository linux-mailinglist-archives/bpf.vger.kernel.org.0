Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924116B6E63
	for <lists+bpf@lfdr.de>; Mon, 13 Mar 2023 05:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjCMEUy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Mar 2023 00:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjCMEUx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Mar 2023 00:20:53 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BF13D917;
        Sun, 12 Mar 2023 21:20:50 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id a2so11564074plm.4;
        Sun, 12 Mar 2023 21:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678681249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1RfkTOaRgCuVzM9oTbMJxfejkweTzswvuv7FcjSaan4=;
        b=IRV6wJBFdqdpXXaMGPesjSegQZBsdmMXEljRE5qWBag8BRGG0aaqPo3/J5qMzRQYvn
         DVRd6CvXj3nMAaOvosMEIi+kgpBdj/IpaakaEgRJCA+GLo8wra1wn2tUoVfmlisTDtqs
         FC9tXsq8omgNXum/nERGE9Z6r7fIOTuCGs9cfRCBE9PZOU0qcx3H6WZuMyXFBORCltt2
         6SmpPskaMWW+EvBmp9RSakB0tkqlB2cZmsy3IzXLxCBtQeiLPWfDJm0X2WHn7it67AgE
         8jobXfeYF//6PwrY9vxZLaNDXNKz0g+wekAKYUPfd69GKs5ybmLyNzYrMJoXAyDauRhn
         SK+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678681249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1RfkTOaRgCuVzM9oTbMJxfejkweTzswvuv7FcjSaan4=;
        b=XDJ29g6OHBz0isLDXgUFRyq++NyclHEi7fzSoYrBIquxNE0uqo4imcejF+s/bYz4s2
         czicSkQpYTyTccPLZwDj7BwzgP9yPTvo3/FWONeZ6pLnrT8aNc7ww1rO6Y+Xyq3+Glyf
         E9wWyJ/OdtCedylzLJcDq4Eoxo13b9gR/o00gldefTa8+hpWNp3bFDJYYRCqGD7QCfdE
         z/iaSkOB3zquhX1C24bssaKBz+LxUuxt+5wjl9fRuaNlxMNTRrrBePSWgorOCN+RBLEN
         UNMMjlH5zfMp5s64wqnbQxNrBctF0g2S9jsVC3Q+ZQ7l15DBKq38M/UOiZIpTISLX4jF
         oOBg==
X-Gm-Message-State: AO0yUKU6IHlru9sOODUleJerhgUi/3nS7fniFR+2XeD5RMnfL6SZcBcs
        qOWrapvUcItOFpCcXQWpRRE=
X-Google-Smtp-Source: AK7set+SbrsG/j53YfKx6j6nNALdzc7jjPvruQqmH7U6bQwmhDwp79NkEpht3c7WFz6sC0L3atD70Q==
X-Received: by 2002:a17:90a:514a:b0:23a:f4b4:630 with SMTP id k10-20020a17090a514a00b0023af4b40630mr18195195pjm.23.1678681249559;
        Sun, 12 Mar 2023 21:20:49 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-24.three.co.id. [180.214.232.24])
        by smtp.gmail.com with ESMTPSA id bg1-20020a1709028e8100b00199203a4fa3sm3565896plb.203.2023.03.12.21.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 21:20:48 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id ABAFB1066BC; Mon, 13 Mar 2023 11:20:45 +0700 (WIB)
Date:   Mon, 13 Mar 2023 11:20:45 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     David Vernet <void@manifault.com>
Cc:     Linux BPF <bpf@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        "Tobin C. Harding" <me@tobin.cc>
Subject: Re: [PATCH bpf-next] bpf, doc: use internal linking for link to
 netdev FAQ
Message-ID: <ZA6knaEQcddfTCyS@debian.me>
References: <20230313025119.17430-1-bagasdotme@gmail.com>
 <20230313030938.GA152792@maniforge>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Q6XoaOYKM2RAcQLK"
Content-Disposition: inline
In-Reply-To: <20230313030938.GA152792@maniforge>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--Q6XoaOYKM2RAcQLK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 12, 2023 at 10:09:38PM -0500, David Vernet wrote:
> This regresses all of the warnings I fixed in d56b0c461d19da ("bpf,
> docs: Fix link to netdev-FAQ target"):
>=20
> [void@maniforge bpf-next]$ make -j SPHINXDIRS=3D"bpf" htmldocs
> make[2]: Nothing to be done for 'html'.
> Using alabaster theme
> source directory: bpf
> /home/void/upstream/bpf-next/Documentation/bpf/bpf_devel_QA.rst:125: WARN=
ING: unknown document: '/process/maintainer-netdev'
> /home/void/upstream/bpf-next/Documentation/bpf/bpf_devel_QA.rst:150: WARN=
ING: unknown document: '/process/maintainer-netdev'
> /home/void/upstream/bpf-next/Documentation/bpf/bpf_devel_QA.rst:207: WARN=
ING: unknown document: '/process/maintainer-netdev'
> /home/void/upstream/bpf-next/Documentation/bpf/bpf_devel_QA.rst:232: WARN=
ING: unknown document: '/process/maintainer-netdev'
> /home/void/upstream/bpf-next/Documentation/bpf/bpf_devel_QA.rst:398: WARN=
ING: unknown document: '/process/maintainer-netdev'
> /home/void/upstream/bpf-next/Documentation/bpf/bpf_devel_QA.rst:414: WARN=
ING: unknown document: '/process/maintainer-netdev'
>=20
> And it also causes the netdev-FAQ links to once again be broken and not
> actually point to anything.

Hi,

I don't see these warnings in my builds. I'm using Sphinx 2.4.4
(virtualenv, install with pip3 install -r
Documentation/sphinx/requirements.txt). I guess your Sphinx version
doesn't support :doc: directive.

Also, did you enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS,
and CONFIG_WARN_ABI_ERRORS?

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--Q6XoaOYKM2RAcQLK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZA6kmAAKCRD2uYlJVVFO
o8OWAP48sSl0DsjbnOGHtRP96KAwySjWpXf7YAyH078PlGKiVwD9Edi+WCG206kQ
+nzqwaX/7hCjxJdqyIxrC6w9PPkHFgM=
=gcNa
-----END PGP SIGNATURE-----

--Q6XoaOYKM2RAcQLK--
