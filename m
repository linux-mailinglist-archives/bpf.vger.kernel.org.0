Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B79763FDF8
	for <lists+bpf@lfdr.de>; Fri,  2 Dec 2022 03:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbiLBCHX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Dec 2022 21:07:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbiLBCHW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Dec 2022 21:07:22 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96529D49D4;
        Thu,  1 Dec 2022 18:07:21 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id q12so3592403pfn.10;
        Thu, 01 Dec 2022 18:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6/xJejn7lxcKkGFwbiEwKFAcY7A3VU62mqZWjzoxtHs=;
        b=mLOLMRuaHHhL/qHeGRv7oD0O6ibFK70oECWPm01RX49BOXMQgVtaMx6tW1MK3YpuuX
         dDHRrZUzhpM3xoTf7kWQIWcBjigSLWjhMNQjGlCR2m25CAwyDVBoeI87bYxOhCRqfmdk
         /0R2pl2wBn+o1LI7HWNOZTJa1hkUnoFe/xO7bRCMWulWP3ePd0JyR6OJIFvAZ0a5nxFs
         X+yAPHs8bl/GfXyp3ukBArL9wtTm79IpVG5uIGxyDuiQrUQ2kuHtSZu2np0svdSt0UGY
         3yAOHcXxCJiEtBaK81Jyk++GwIAKTB1T54lWyJIOLR+AoKczNiQxHwEZoqyEmlGVANdK
         XaTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/xJejn7lxcKkGFwbiEwKFAcY7A3VU62mqZWjzoxtHs=;
        b=bpYsYUXBaSwW2iHQsegSt/Off6oSqW9gFcbP0haStli5urQXlmduatoPHSjfg2syHH
         0KRygycWLg1qDBVKLoDTLPVb20Jc1IkawA+1Id4D0x4e8tthxswvYkwjkpquS5fEQRm0
         P7DximZWg+QE1fhCdIAnz6mZ2Nz+6OSCsPVwq+lqjqLu/JgiSSgkORff7n1Xx/ybgsxp
         MbYIBmbl/dGVyMV2M3aFXYDBay/Sryo8Xr6hWVBjHUkN1yGl98k+JuD4Z+xeok//b+BJ
         uF7bGfgb/vqCHLBbKbo8SZm9Yv0tblWKguR+CrLftlprzv5Gs9QBmxgFsqj8fZOu1iRU
         fCGA==
X-Gm-Message-State: ANoB5pm4Loh5albqdUKy7kErqTu0z1b6NGbl+A3LuIFw3abT7fgbyKh2
        wQTDHRFl36hEzVxV7bRqdyu2OENKmEA=
X-Google-Smtp-Source: AA0mqf6IoO+seDHtF6ALvFsegFTRz57JxTLw4GiIZHxypLk/EKqIKFj6ObWQPTx537Ta4sxSr4DrYg==
X-Received: by 2002:a05:6a00:1413:b0:56b:8e99:a5e9 with SMTP id l19-20020a056a00141300b0056b8e99a5e9mr49606429pfu.24.1669946841126;
        Thu, 01 Dec 2022 18:07:21 -0800 (PST)
Received: from debian.me (subs03-180-214-233-26.three.co.id. [180.214.233.26])
        by smtp.gmail.com with ESMTPSA id b5-20020a170903228500b00186ad73e2d5sm4342551plh.208.2022.12.01.18.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 18:07:20 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 47E751044C3; Fri,  2 Dec 2022 09:07:17 +0700 (WIB)
Date:   Fri, 2 Dec 2022 09:07:16 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     mtahhan@redhat.com
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org, jbrouer@redhat.com,
        thoiland@redhat.com, donhunte@redhat.com, john.fastabend@gmail.com
Subject: Re: [PATCH bpf-next v2 1/1] docs: BPF_MAP_TYPE_SOCK[MAP|HASH]
Message-ID: <Y4ld1BsRrXaPtz0L@debian.me>
References: <20221201151352.34810-1-mtahhan@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cXOd5jt22bP2DGnc"
Content-Disposition: inline
In-Reply-To: <20221201151352.34810-1-mtahhan@redhat.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--cXOd5jt22bP2DGnc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 01, 2022 at 03:13:52PM +0000, mtahhan@redhat.com wrote:
> +When these maps are created BPF programs are attached to them. The list =
of
> +allowed programs is shown below:

Automatically attached BPF programs?

Also, "The allowed programs are:"

> +.. note::
> +	For more details of the socket callbacks that get replaced please see:
> +
> +	- TCP BPF functions: ``net/ipv4/tcp_bpf.c``
> +	- UDP BPF functions: ``net/ipv4/udp_bpf.c``

"... please see ``net/ipv4/tcp_bpf.c`` and ``net/ipv4/udp_bpf.c`` for
TCP and UDP functions, respectively"

Otherwise LGTM.

--=20
An old man doll... just what I always wanted! - Clara

--cXOd5jt22bP2DGnc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY4ldzwAKCRD2uYlJVVFO
o3vqAP9DDTvIAhV7zgWCl5Yqc3NB2lZlztTUMaxqEiuEU754igD/VIG7semAcmZ6
uCkAK5zIOsLuer5R+1yN5v4zsBeInwg=
=GVME
-----END PGP SIGNATURE-----

--cXOd5jt22bP2DGnc--
