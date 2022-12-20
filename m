Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD2E651D29
	for <lists+bpf@lfdr.de>; Tue, 20 Dec 2022 10:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiLTJVa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Dec 2022 04:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbiLTJV0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Dec 2022 04:21:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A670BE9
        for <bpf@vger.kernel.org>; Tue, 20 Dec 2022 01:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671528039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ujmnLoyVJXLiCxEsBRx4BmSv6UWqVaJvSMF8bKF07KM=;
        b=GINXBYhfrq6M7QLszp30qpJrdiwrzg1vJEV1VyOuuGmh6G8qlnz/TMIeDqA0HLB7emFak+
        eKRL03iojgDECtdaIJX3SYsCvktf7EkG9jlJ7WlA3ttbLt+3nc4Sw2AC8HeTzw0NqIhRLc
        4Xe+K0O/E/XRcPok3ZLkLSBaZwF4RWU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-663-ptKNKHvKPmSNtTgWnIgI2w-1; Tue, 20 Dec 2022 04:20:37 -0500
X-MC-Unique: ptKNKHvKPmSNtTgWnIgI2w-1
Received: by mail-wm1-f72.google.com with SMTP id o5-20020a05600c510500b003cfca1a327fso6280872wms.8
        for <bpf@vger.kernel.org>; Tue, 20 Dec 2022 01:20:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujmnLoyVJXLiCxEsBRx4BmSv6UWqVaJvSMF8bKF07KM=;
        b=4sdOqjJd1i0zXyaWcmKCZASTXl7ALJZc02ZNBUhSaykU2p5drUs/kUZICDMLpjPscn
         K78lcGhUx5WQ9aDBZNYiZHjTLUikPyvkk2PRCFi5DbrPQbelsLf2XwzFRWE+0/6nxjKu
         9bA7BZii4T++IBjJIN40PGg3fryqBnnQNiHywa8uMBZPGBx0GizbuXpt7yCRSwmr4wJC
         GiXWGt91AMfgSzDYCcdT7PP/WOyRzKa9N5WEMeT3ylwNRqsLSk0/ziD4X/v6s3yOkiSB
         +sv2CedEM5oEhtg+NcLvS0Ir8TB2OCoLLWTwIbKgtSx17rhGlZfnI8xCX6jvm3gXcxH0
         wuyA==
X-Gm-Message-State: AFqh2krnuCtA18BgOfU0wcRDlsYCGjkZdkNCuGEqoHmOShFWxik/k7Wk
        73u3X+fPipVa0OWfUnv9MG6OG6ENffliGEyXCCbCaN++W3vzv+t2R9eNzW5a/OJm3k+JAtrqz3A
        Ki8EnuvfpkyEq
X-Received: by 2002:a05:6000:883:b0:236:70ab:4bbb with SMTP id ca3-20020a056000088300b0023670ab4bbbmr14407687wrb.1.1671528036168;
        Tue, 20 Dec 2022 01:20:36 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsivxyPNqa4ow7Gezj3o5cxRM8MurV1PJ518/If0yw9qu5gJmc6Iixr5Kz6J+CWQZYsy58Uaw==
X-Received: by 2002:a05:6000:883:b0:236:70ab:4bbb with SMTP id ca3-20020a056000088300b0023670ab4bbbmr14407667wrb.1.1671528035950;
        Tue, 20 Dec 2022 01:20:35 -0800 (PST)
Received: from localhost (net-188-216-77-84.cust.vodafonedsl.it. [188.216.77.84])
        by smtp.gmail.com with ESMTPSA id ck5-20020a5d5e85000000b00257795ffcc8sm12288226wrb.73.2022.12.20.01.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 01:20:34 -0800 (PST)
Date:   Tue, 20 Dec 2022 10:20:32 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, davem@davemloft.net, hawk@kernel.org,
        pabeni@redhat.com, edumazet@google.com, toke@redhat.com,
        memxor@gmail.com, alardam@gmail.com, saeedm@nvidia.com,
        anthony.l.nguyen@intel.com, gospo@broadcom.com,
        vladimir.oltean@nxp.com, nbd@nbd.name, john@phrozen.org,
        leon@kernel.org, simon.horman@corigine.com, aelior@marvell.com,
        christophe.jaillet@wanadoo.fr, ecree.xilinx@gmail.com,
        grygorii.strashko@ti.com, mst@redhat.com, bjorn@kernel.org,
        magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
        intel-wired-lan@lists.osuosl.org
Subject: Re: [RFC bpf-next 2/8] net: introduce XDP features flag
Message-ID: <Y6F+YJSkI19m/kMv@lore-desk>
References: <cover.1671462950.git.lorenzo@kernel.org>
 <43c340d440d8a87396198b301c5ffbf5ab56f304.1671462950.git.lorenzo@kernel.org>
 <20221219171321.7a67002b@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GGYTRaTKhvn+rvn6"
Content-Disposition: inline
In-Reply-To: <20221219171321.7a67002b@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--GGYTRaTKhvn+rvn6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, 19 Dec 2022 16:41:31 +0100 Lorenzo Bianconi wrote:
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Netdev XDP features
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > + * XDP FEATURES FLAGS
> > +
> > +Following netdev xdp features flags can be retrieved over route netlink
> > +interface (compact form) - the same way as netdev feature flags.
>=20
> How likely is it that I'll be able to convince you that cramming more
> stuff in rtnl is a bad idea? I can convert this for you to a YAML-
> -compatible genetlink family for you in a jiffy, just say yes :S
>=20
> rtnl is hard to parse, and already overloaded with random stuff.
> And the messages are enormous.

Hi Jakub,

I am fine to use YAML for this, but I will let Marek comment since he is the
original author of this patch.

>=20
> > +These features flags are read only and cannot be change at runtime.
> > +
> > +*  XDP_ABORTED
> > +
> > +This feature informs if netdev supports xdp aborted action.
> > +
> > +*  XDP_DROP
> > +
> > +This feature informs if netdev supports xdp drop action.
> > +
> > +*  XDP_PASS
> > +
> > +This feature informs if netdev supports xdp pass action.
> > +
> > +*  XDP_TX
> > +
> > +This feature informs if netdev supports xdp tx action.
> > +
> > +*  XDP_REDIRECT
> > +
> > +This feature informs if netdev supports xdp redirect action.
> > +It assumes the all beforehand mentioned flags are enabled.
> > +
> > +*  XDP_SOCK_ZEROCOPY
> > +
> > +This feature informs if netdev driver supports xdp zero copy.
> > +It assumes the all beforehand mentioned flags are enabled.
>=20
> Why is this "assumption" worth documenting?

I guess we can remove it.
@Marek: any comment?

>=20
> > +*  XDP_HW_OFFLOAD
> > +
> > +This feature informs if netdev driver supports xdp hw oflloading.
> > +
> > +*  XDP_TX_LOCK
> > +
> > +This feature informs if netdev ndo_xdp_xmit function requires locking.
>=20
> Why is it relevant to the user?

Probably not, I kept it since it was in Marek's original patch.
@Marek: any comment?

>=20
> > +*  XDP_REDIRECT_TARGET
> > +
> > +This feature informs if netdev implements ndo_xdp_xmit callback.
>=20
> Does it make sense to rename XDP_REDIRECT -> XDP_REDIRECT_SOURCE then?

yes, naming is always hard :)

>=20
> > +*  XDP_FRAG_RX
> > +
> > +This feature informs if netdev implements non-linear xdp buff support =
in
> > +the driver napi callback.
>=20
> Who's the target audience? Maybe FRAG is not the best name?
> Scatter-gather or multi-buf may be more widely understood.

ack, fine. I will rename it in the formal series.

Regards,
Lorenzo

>=20
> > +*  XDP_FRAG_TARGET
> > +
> > +This feature informs if netdev implements non-linear xdp buff support =
in
> > +ndo_xdp_xmit callback. XDP_FRAG_TARGET requires XDP_REDIRECT_TARGET is=
 properly
> > +supported.
>=20

--GGYTRaTKhvn+rvn6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY6F+YAAKCRA6cBh0uS2t
rDNnAP9RoSpPR93+gszTrBsVMLSSp5AzTlLLx7YHUTxLsyMxxgD+IN8mb+rWF7B+
XNQZPdvh0IgYgn1cKAUKey2wbHrjrAw=
=5s7n
-----END PGP SIGNATURE-----

--GGYTRaTKhvn+rvn6--

