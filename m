Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E181694FAE
	for <lists+bpf@lfdr.de>; Mon, 13 Feb 2023 19:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjBMSrc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Feb 2023 13:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjBMSrc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Feb 2023 13:47:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C8D1CAF5
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 10:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676314005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R4rwifJ7hzrsSf9oaL2M6mHp/2UWoIjZ6w4a9g1fuFQ=;
        b=OW56Xy7mIuT2tdxpBoEQ8XczamvdmH+tMeOAHCMS3DOeLJlY49sL8IkfuRdexA5orImX1B
        oMlYpoKfZNarGaLE1mFb28F1jCZBg/P9/KqV0nECpZWwFLVGH1UdwsE4nplcC0b2tW2BZ5
        qFEwUTh5ZBPdwIBxkmU81Dva/26D3As=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-561-s7xgfYdYN8C7cCQcY0V9Mw-1; Mon, 13 Feb 2023 13:46:44 -0500
X-MC-Unique: s7xgfYdYN8C7cCQcY0V9Mw-1
Received: by mail-wm1-f69.google.com with SMTP id s11-20020a05600c384b00b003dffc7343c3so6573426wmr.0
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 10:46:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4rwifJ7hzrsSf9oaL2M6mHp/2UWoIjZ6w4a9g1fuFQ=;
        b=oIjIs17esUKZPF5iPBNLoH2ZawaZviLzolhYaqfEhHLoE991hIkxgM9EDuR4G7gRrh
         db6npuMU57nQQSbxJEUK3r3Z48GEtsYbb2Yd+iRix4RLJt6cuFkQlPt2Y0RzQqXB00MS
         igLC8KYjR+Wm2m5xY8GLHrxQmOjZsM1Lpu3DiecqYhsuLwEZX42pGYbsaOplPDLSeibh
         Zx5bqYnD8sQYWnA4E6jRA4r0diZUDcIyvf8uaCrYV3fmtEOP17NQwN7v4Ndp42yU5Mr0
         ytWJAGyL0ur0OkSQ88rxuCdncBYy/DTWhLl9rDrw/2XCF1kbzEb6Vsr6cECj6ePMpZjE
         vAdA==
X-Gm-Message-State: AO0yUKWt1Wy2le+NoKO2LrxKnrLwExEx4d9H4u1mfTSmbdqPE6RL4GTi
        VJ1d0hJvQKzFqLlBEicIg58dmB4LUwpcaDG3m2ZQfxMEikqSdV/CNWERqj/aaU+FiwxE5RUO/4p
        PXBZ+7+wqB/rp
X-Received: by 2002:a5d:4c8d:0:b0:2c5:4cd0:4b86 with SMTP id z13-20020a5d4c8d000000b002c54cd04b86mr8390461wrs.68.1676314002954;
        Mon, 13 Feb 2023 10:46:42 -0800 (PST)
X-Google-Smtp-Source: AK7set8use60YTtQ/nRWeIZymvYK4ScWliIaAORlA6GNgU1FMqvJBqOmyH9rxadQJtH8qL54QVA4QA==
X-Received: by 2002:a5d:4c8d:0:b0:2c5:4cd0:4b86 with SMTP id z13-20020a5d4c8d000000b002c54cd04b86mr8390442wrs.68.1676314002696;
        Mon, 13 Feb 2023 10:46:42 -0800 (PST)
Received: from localhost (net-188-216-77-84.cust.vodafonedsl.it. [188.216.77.84])
        by smtp.gmail.com with ESMTPSA id u13-20020a5d468d000000b002c54c92e125sm7816543wrq.46.2023.02.13.10.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 10:46:41 -0800 (PST)
Date:   Mon, 13 Feb 2023 19:46:39 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
        andrii@kernel.org, horatiu.vultur@microchip.com,
        UNGLinuxDriver@microchip.com
Subject: Re: [PATCH bpf-next] net: lan966x: set xdp_features flag
Message-ID: <Y+qFj2YIE4OAWcld@lore-desk>
References: <01f4412f28899d97b0054c9c1a63694201301b42.1676055718.git.lorenzo@kernel.org>
 <Y+isP2HNYKTHtHjf@lore-desk>
 <cfcc4936-086c-62f6-142f-1db1c42fb9d3@iogearbox.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="E9xNBS9TCKbvrYlU"
Content-Disposition: inline
In-Reply-To: <cfcc4936-086c-62f6-142f-1db1c42fb9d3@iogearbox.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--E9xNBS9TCKbvrYlU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 2/12/23 10:07 AM, Lorenzo Bianconi wrote:
> > > Set xdp_features netdevice flag if lan966x nic supports xdp mode.
> > >=20
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > ---
> > >   drivers/net/ethernet/microchip/lan966x/lan966x_main.c | 5 +++++
> > >   1 file changed, 5 insertions(+)
> > >=20
> > > diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/=
drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> > > index 580c91d24a52..b24e55e61dc5 100644
> > > --- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> > > +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> > > @@ -823,6 +823,11 @@ static int lan966x_probe_port(struct lan966x *la=
n966x, u32 p,
> > >   	port->phylink =3D phylink;
> > > +	if (lan966x->fdma)
> > > +		dev->xdp_features =3D NETDEV_XDP_ACT_BASIC |
> > > +				    NETDEV_XDP_ACT_REDIRECT |
> > > +				    NETDEV_XDP_ACT_NDO_XMIT;
> > > +
> > >   	err =3D register_netdev(dev);
> > >   	if (err) {
> > >   		dev_err(lan966x->dev, "register_netdev failed\n");
> >=20
> > Since the xdp-features series is now merged in net-next, do you think i=
t is
> > better to target this patch to net-next?
>=20
> Yes, that would be better given it's a pure driver change. I moved delega=
te
> to netdev.

ack, thx, in this way I do not need to repost :)

Regards,
Lorenzo

>=20
> Thanks,
> Daniel
>=20

--E9xNBS9TCKbvrYlU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY+qFjwAKCRA6cBh0uS2t
rAOfAP4tRV/NAj+9UfwP9fdY8qaRv0tonn9AKHsgEVpHEAcIwwEA9fTxC/+TRrqE
A+0VburuW01QpOQTDCZxB37wZjLJaQc=
=CuV2
-----END PGP SIGNATURE-----

--E9xNBS9TCKbvrYlU--

