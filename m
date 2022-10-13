Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574F75FD3B4
	for <lists+bpf@lfdr.de>; Thu, 13 Oct 2022 06:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbiJMENo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Oct 2022 00:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJMENn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Oct 2022 00:13:43 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69849127BC6;
        Wed, 12 Oct 2022 21:13:42 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id e129so558717pgc.9;
        Wed, 12 Oct 2022 21:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yI0iiintCNSYXW3Cl1VzfCO/HumDMQ6YBRetL05i6As=;
        b=XqWNDHH792o3El1h+l9zC/HzMMGGOxQ3OrTvKYTMuHxcc5g6obaruk8K97+pC/GTmC
         3y5YtqbgDLWnGoL7vSddk7QYzwyVlKudoIiX8kLapGJMzuCOEAPZ3QyTlZ3GjCyxIVhr
         yzJ4YmxRnBckgqaRK8/YKFXQdWVAMOpVmSqTCC6lxfgEtAq33StX69omdwFVIUBc6aZb
         0VfTdjk1Oyc0rhTumw7XTXxoPV9tFRM6npXH/IdLfOYMyWaavuTDdy54s710LPigrFNl
         YzoWKuKeiEucbeISHy2aZMGSNplmTF4uh6pd/W89wygozn64qTlDILYgXVu+gvII1g5a
         lAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yI0iiintCNSYXW3Cl1VzfCO/HumDMQ6YBRetL05i6As=;
        b=RXg0pW9TkeWxLzOJ3fY1gZTuuKv/kkjA6UnnPzQhnqabZv+fIZjxGPMovAPNpxdeLg
         hhs4Bml00NyQiM/lEB7XAaWqow11RSDGG7HgZVNTygeCa2tgbmHkZ4cxlHeBpP9g9f/1
         7EadGxHgV83LWSp8NmYer/PET50t3r5VIVhN+chWo4I7QgD9iNl1c+/MGBjVx4mod0Vd
         d2r1c5cFq+uuepti18moIT34wTArCSfitn0ahVYHT3ZhDSDi7JBNuBG/7MXufKBIJD6M
         Z2EvTuyfR0lQG1d2Sb0DNA5ORE8p+62hs5X/HEZ5Go7JVYP8nDqN8QDKl6akMseuzfv8
         rg5Q==
X-Gm-Message-State: ACrzQf0KAHY8ea3+66mfptCRV4lcdzT0ePLnvUrVswXUBIHzlbM7XNtu
        ZJzEwCoidFSK3LPkjF2tnEk=
X-Google-Smtp-Source: AMsMyM50wtt32gjG9zlBPe1CVsO5VHjcfmL4ucc2bVT8uu9WdJ70Mv5VN/fKUJcZhJi1vAG90dpUAg==
X-Received: by 2002:a63:4c23:0:b0:45f:eab4:4f47 with SMTP id z35-20020a634c23000000b0045feab44f47mr23304463pga.532.1665634421741;
        Wed, 12 Oct 2022 21:13:41 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-21.three.co.id. [180.214.232.21])
        by smtp.gmail.com with ESMTPSA id c13-20020aa7952d000000b0056323de479bsm700650pfp.120.2022.10.12.21.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 21:13:40 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 39057101314; Thu, 13 Oct 2022 11:13:36 +0700 (WIB)
Date:   Thu, 13 Oct 2022 11:13:36 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Donald Hunter <donald.hunter@gmail.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH bpf-next v1] bpf, docs: Reformat BPF maps page to be more
 readable
Message-ID: <Y0eQcOsbrmBXqdUP@debian.me>
References: <20221012152715.25073-1-donald.hunter@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PGIwu2yxln04EdUi"
Content-Disposition: inline
In-Reply-To: <20221012152715.25073-1-donald.hunter@gmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--PGIwu2yxln04EdUi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 12, 2022 at 04:27:15PM +0100, Donald Hunter wrote:
> Add a more complete introduction, with links to man pages.
> Move toctree of map types above usage notes.
> Format usage notes to improve readability.
>=20
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> ---
>  Documentation/bpf/maps.rst | 101 ++++++++++++++++++++++++-------------
>  1 file changed, 65 insertions(+), 36 deletions(-)
>=20
> diff --git a/Documentation/bpf/maps.rst b/Documentation/bpf/maps.rst
> index f41619e312ac..4906ff0f8382 100644
> --- a/Documentation/bpf/maps.rst
> +++ b/Documentation/bpf/maps.rst
> @@ -1,52 +1,81 @@
> =20
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -eBPF maps
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +BPF maps
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +BPF 'maps' provide generic storage of different types for sharing data b=
etween
> +kernel and user space. There are several storage types available, includ=
ing
> +hash, array, bloom filter and radix-tree. Several of the map types exist=
 to
> +support specific BPF helpers that perform actions based on the map conte=
nts. The
> +maps are accessed from BPF programs via BPF helpers which are documented=
 in the
> +`man-pages`_ for `bpf-helpers(7)`_.
> +
> +BPF maps are accessed from user space via the ``bpf`` syscall, which pro=
vides
> +commands to create maps, lookup elements, update elements and delete
> +elements. More details of the BPF syscall are available in
> +:doc:`/userspace-api/ebpf/syscall` and in the `man-pages`_ for `bpf(2)`_.
> <snipped>...
> +.. Links:
> +.. _man-pages: https://www.kernel.org/doc/man-pages/
> +.. _bpf(2): https://man7.org/linux/man-pages/man2/bpf.2.html
> +.. _bpf-helpers(7): https://man7.org/linux/man-pages/man7/bpf-helpers.7.=
html

I think you can just write "see :manpage:`bpf(2)`" without linking to
external site.

Otherwise LGTM.

--=20
An old man doll... just what I always wanted! - Clara

--PGIwu2yxln04EdUi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY0eQawAKCRD2uYlJVVFO
o1bVAQD5WwbLMw3d422kOy7AsWPETUWqvcKpRKLUrB+XUotXPQD+P4luJGpRfu6A
B3iAQR5TnVALOqZ2HSXSh6V9yd9oaQg=
=5tkV
-----END PGP SIGNATURE-----

--PGIwu2yxln04EdUi--
