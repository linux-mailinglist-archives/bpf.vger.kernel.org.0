Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2261A6B1E71
	for <lists+bpf@lfdr.de>; Thu,  9 Mar 2023 09:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjCIInA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Mar 2023 03:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjCIImY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Mar 2023 03:42:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983FD7A96
        for <bpf@vger.kernel.org>; Thu,  9 Mar 2023 00:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678351264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=txvAL0k71w0phuLTTzfLzT/AthnjsOBVGnwEr0rkbww=;
        b=RLVVJ3QVuTkqkAABPB/b3syYvUn0rbntpkv88y4F1qTYLTnyf5s9vAl8sCbUBZo3UQz/JU
        BBtWocgA16YSc1auHFPN/o1nng1zvbPG4QxZAOwGddkkTbrwGQvuo2X1VVez+0d1i05hxi
        aCwbMS9Fx+HrJm0Kv7dMigJTJlRdcuw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-DHLpcmi1OVqtzvTYHrz06Q-1; Thu, 09 Mar 2023 03:41:03 -0500
X-MC-Unique: DHLpcmi1OVqtzvTYHrz06Q-1
Received: by mail-wr1-f70.google.com with SMTP id x3-20020a5d6503000000b002c8c421fdfaso230406wru.15
        for <bpf@vger.kernel.org>; Thu, 09 Mar 2023 00:41:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678351262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txvAL0k71w0phuLTTzfLzT/AthnjsOBVGnwEr0rkbww=;
        b=R7tZfC+p5qpvaeD+Lk728xqK2sg3AftvYW4UtkemamSunHKL6fFfwokKGXSKAV0Tk+
         FSsY0YSFI9xegKxEq/zFPCXC4svyW60XsLE9MSRKPgFT53g8YaAVp4o6HnuLuvx4/sj9
         5xOIiDncFUHlqCxfR2I5QBeslHy0urp0aoUtinpqVmGHZpl5oCV5wuoDZ2dluKP3Mmse
         0HddyeSiTuRhtOu8AktsCviwTCsqGmzlsHPcIMRF5sS7CaMLSwBt0YEwOEomOYa796Iq
         7u7+rW4RMMQ/3JAtkaMkEQ7hgDPEn/JKcHHnL7YoOzISDyuY5jH65NUA6EsJBH9yA8RY
         26rA==
X-Gm-Message-State: AO0yUKV0ckgu3ajHbERkSgy94c1Xv45dOg7auMFMshKLY/+NI5Z0OdKJ
        PziJmDsDW7la3FUfrx9r4FrM/seW0/fjbu/AQAkNdDTljOZMNocyyErLHUv5CvoU1vU5Vackdh4
        yOn7/rB0YxtNM
X-Received: by 2002:adf:e44c:0:b0:2c7:1c07:dd5d with SMTP id t12-20020adfe44c000000b002c71c07dd5dmr14145949wrm.59.1678351262206;
        Thu, 09 Mar 2023 00:41:02 -0800 (PST)
X-Google-Smtp-Source: AK7set9YEbAog0IupS/NJKlG2lX6MaVa+Hyi9ViY5DwCDKqzqFF64fpd91WersUu63cL7Ph9WGJM9Q==
X-Received: by 2002:adf:e44c:0:b0:2c7:1c07:dd5d with SMTP id t12-20020adfe44c000000b002c71c07dd5dmr14145934wrm.59.1678351261806;
        Thu, 09 Mar 2023 00:41:01 -0800 (PST)
Received: from localhost (net-188-216-77-84.cust.vodafonedsl.it. [188.216.77.84])
        by smtp.gmail.com with ESMTPSA id f2-20020a5d4dc2000000b002be5bdbe40csm17098012wru.27.2023.03.09.00.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 00:41:01 -0800 (PST)
Date:   Thu, 9 Mar 2023 09:40:59 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Tariq Toukan <ttoukan.linux@gmail.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
        hawk@kernel.org, john.fastabend@gmail.com, saeedm@nvidia.com,
        leon@kernel.org, shayagr@amazon.com, akiyano@amazon.com,
        darinzon@amazon.com, sgoutham@marvell.com, toke@redhat.com,
        teknoraver@meta.com, Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH net-next 7/8] net/mlx5e: take into account device
 reconfiguration for xdp_features flag
Message-ID: <ZAmbm8geLNUMZhK5@lore-desk>
References: <cover.1678200041.git.lorenzo@kernel.org>
 <8857cb8138b33c8938782e2154a56b095d611d18.1678200041.git.lorenzo@kernel.org>
 <c2d13e84-2c30-d930-37a4-4e984b85a0e4@gmail.com>
 <ZAiuKRDqQ+1cQb2J@lore-desk>
 <03095151-3659-0b1b-8e67-a416b8eafa2b@gmail.com>
 <20230308233236.41ff3fd2@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7s7G5fzOUfsVe8Zr"
Content-Disposition: inline
In-Reply-To: <20230308233236.41ff3fd2@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--7s7G5fzOUfsVe8Zr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, 9 Mar 2023 09:23:10 +0200 Tariq Toukan wrote:
> > > Hi Tariq,
> > >=20
> > > I am fine to repost this series for net instead of net-next. Any down=
sides about
> > > it? =20
> >=20
> > Let's repost to net.
> > It's a fixes series, and 6.3 is still in its RCs.
> > If you don't post it to net then the xdp-features in 6.3 will be broken.
>=20
> minor heads up - patch 2 will now apply to lib/nlspec.py
> I just moved the enum classes there as part of another fix
> but the code and the changes should be identical
>=20

ack, fine. I will fix the conflicts rebasing on net tree.

Regards,
Lorenzo

--7s7G5fzOUfsVe8Zr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZAmbmwAKCRA6cBh0uS2t
rPdBAQCtC/5FHUGblH7edu4s5fj4nJfMWN1K+/zqyyvRJ9OnTQD/RCvtpA+nd7eF
/okUnr/qSAp9ldckGwGMYDrZjmG+ow4=
=eDr5
-----END PGP SIGNATURE-----

--7s7G5fzOUfsVe8Zr--

