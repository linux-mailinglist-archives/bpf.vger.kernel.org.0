Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F9A68C52C
	for <lists+bpf@lfdr.de>; Mon,  6 Feb 2023 18:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjBFRwo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Feb 2023 12:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjBFRwm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Feb 2023 12:52:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35509234E1
        for <bpf@vger.kernel.org>; Mon,  6 Feb 2023 09:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675705916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mlRJLRWU+QLY6PbqmarKNgR64+48L0bA/Gs+xHYUriQ=;
        b=WgV52KViRrwPnKhA1eYx+6a+bIy72GjjhwJLOhGMgQm/Lu0DnejQ4Hxgnpa0j0+s/WC+DU
        uytA0JGl48kcbmn13RHXzWiCr8mUnaojMQvXi9W5wrjBqzOUC5idleofhtpRdpgg93HmYY
        CFGpMIIUQb9zd8Jmsn1axGbSZSbxrrU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-264--5_1pNMdOu2E8yagcj7BOQ-1; Mon, 06 Feb 2023 12:51:47 -0500
X-MC-Unique: -5_1pNMdOu2E8yagcj7BOQ-1
Received: by mail-wm1-f71.google.com with SMTP id j20-20020a05600c1c1400b003dc5dd44c0cso6064822wms.8
        for <bpf@vger.kernel.org>; Mon, 06 Feb 2023 09:51:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mlRJLRWU+QLY6PbqmarKNgR64+48L0bA/Gs+xHYUriQ=;
        b=QkjFVoMf8fgc2ir+kz6PUMvvYVOg7+4RwhesAh7mU/Yg/JYGPo0PIvyYp+pHohUqJL
         MI4Fno00UzSBLQKEwLRaRXPC/1CpP4BE8yYpUGCNwRAI2ZMZt7b3WMA5ciQu65s7kE3M
         fqO2apv52Ifvn5gkgao669d2ibQJOJAISaVx4/OEIMrkUjmNJnrEKOp2vN10KwEqmO3b
         v8WkjAl7gnUFmfe3CilbTIq+/AjPyG6riHjtD9nRNh3GGbyAcGbO79z6QyXYLn6xmUVh
         EwDc1j7gOBRBvkp0k0yFrdiNbX33RlS6qKlilI1dM6hpszFjFli3DG+tLQOWRHRJ9cUD
         2zLA==
X-Gm-Message-State: AO0yUKWgSws75yFwraQw7IPh9qTnh2pppoEH9rD9aU/nCjdHXt8YYhvE
        SZb46hVTVAIeoMPk314d9Dd7hIZACvo/zTiWhNRvHQhOmPYPPyxxeePDta+2NoEV4LYef4Vza4r
        LovYJ7H+jsLE0
X-Received: by 2002:a05:6000:118c:b0:2c3:eaff:aae8 with SMTP id g12-20020a056000118c00b002c3eaffaae8mr4148322wrx.18.1675705905625;
        Mon, 06 Feb 2023 09:51:45 -0800 (PST)
X-Google-Smtp-Source: AK7set/jopiaZxKFKO3pCbMvWC+VuXKtxGr5ytcErWQGGo9ALq6JVHmNnRL/MUSFHrpeC8zCTeM38Q==
X-Received: by 2002:a05:6000:118c:b0:2c3:eaff:aae8 with SMTP id g12-20020a056000118c00b002c3eaffaae8mr4148302wrx.18.1675705905453;
        Mon, 06 Feb 2023 09:51:45 -0800 (PST)
Received: from localhost (net-188-216-77-84.cust.vodafonedsl.it. [188.216.77.84])
        by smtp.gmail.com with ESMTPSA id h12-20020adff4cc000000b002c3d814cc63sm8520154wrp.76.2023.02.06.09.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 09:51:44 -0800 (PST)
Date:   Mon, 6 Feb 2023 18:51:42 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
        sfr@canb.auug.org.au
Subject: Re: [PATCH bpf-next] net: add missing xdp_features description
Message-ID: <Y+E+LoX3MXGFKFEf@lore-desk>
References: <bec12badf6eea84c426bb51f1eb249b2e8c6a421.1675679509.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="F3LIzPc3zLpgQSRy"
Content-Disposition: inline
In-Reply-To: <bec12badf6eea84c426bb51f1eb249b2e8c6a421.1675679509.git.lorenzo@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--F3LIzPc3zLpgQSRy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Add missing xdp_features field description in the struct net_device
> documentation. This patch fix the following warning:

Hi all,

Please drop this version, I will post a v2 to fix indentation.

Regards,
Lorenzo

>=20
> ./include/linux/netdevice.h:2375: warning: Function parameter or member '=
xdp_features' not described in 'net_device'
>=20
> Fixes: d3d854fd6a1d ("netdev-genl: create a simple family for netdev stuf=
f")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  include/linux/netdevice.h | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 0f7967591288..645787259172 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -1819,6 +1819,7 @@ enum netdev_ml_priv_type {
>   *			of Layer 2 headers.
>   *
>   *	@flags:		Interface flags (a la BSD)
> +*	@xdp_features:	XDP capability supported by the device
>   *	@priv_flags:	Like 'flags' but invisible to userspace,
>   *			see if.h for the definitions
>   *	@gflags:	Global flags ( kept as legacy )
> --=20
> 2.39.1
>=20

--F3LIzPc3zLpgQSRy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY+E+LgAKCRA6cBh0uS2t
rMavAP9H/YoqULSX3mOIKTBqlGAK06welxEG8vKUCFs/cMGN4QEArNT+GgGAnzCE
8jAsDmTzm+E04LHE8shsc5hGeGocnAw=
=yoP3
-----END PGP SIGNATURE-----

--F3LIzPc3zLpgQSRy--

