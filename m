Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D257670CCC
	for <lists+bpf@lfdr.de>; Wed, 18 Jan 2023 00:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjAQXKN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Jan 2023 18:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjAQXIK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Jan 2023 18:08:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F044FC30
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 14:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673995331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ckm+P7EhQq3tMMMLdp8ksaD5nCqQSrg8dglbOqFaLx0=;
        b=KELBuq9um50YUfHZJK+g/UZsOwq3A4BBHkXMZ7PhsIRMOEED8tkg9vnuBuR8D8TylAf0eP
        ywoiaUXa99Rmk8YTJJ+dDma3fiWis9+jZYlzlN4NzjBxFPhnfLhazwgB5VCHVJra6iJADj
        zcNLwWdXfl6X5DAckXQWNBl3l+yUcy4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-625-bVJi3x5GM-62gpgnUnsZ9Q-1; Tue, 17 Jan 2023 17:42:10 -0500
X-MC-Unique: bVJi3x5GM-62gpgnUnsZ9Q-1
Received: by mail-ej1-f71.google.com with SMTP id oz11-20020a1709077d8b00b007c0dd8018b6so22661406ejc.17
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 14:42:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ckm+P7EhQq3tMMMLdp8ksaD5nCqQSrg8dglbOqFaLx0=;
        b=Nkx/FLLT0lB4SjeqAt5Uc53kNr/u1KXU9xQEY2uFvISDngwKq2pved+BiDohB9dApV
         F2su7sUyjQN5PngDpIgap6x/q5/ttt/Vy+BQ1s5iZAGfhwF7PuVGiSRS1vN1+HPcFp89
         fOyIk9IwWS8Ya4n0YmFrFqonbG8zCN9zQdRAomzERGPMkQDroaNzgu1JRwoM52nVj8Jv
         oRWW9ZVu7actDGDWVphjnZiyZWWejt4QTfBSP+xzP/ORi3/LwxEUCe5i7k3Po2jGoCPV
         xgcrr9FquBCRZWn5ZH9B2frEXu70RUwzarP/Eln1UqN7zzeJDeLtPxD8ZMk7Eu+3gg9w
         ij4g==
X-Gm-Message-State: AFqh2krEzfIooXeZie22n1Neu/UFY5dP/MD3UgbpKpIgfw3zhJHBRooM
        7DrKpOtXzNL1GuYvOhnhLNTeMfYuokam9IzaVw+MvQ4fNsh27mxdLA83jlK7f0xonEc9vv+StJf
        VzMsnu9GjBYuN
X-Received: by 2002:a05:6402:524f:b0:49e:498c:5e16 with SMTP id t15-20020a056402524f00b0049e498c5e16mr233094edd.30.1673995328855;
        Tue, 17 Jan 2023 14:42:08 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuDr1iHNfiv83GpdqhTGHecaw7zHQhGvun8ZtQyqVRaaW66IzMTkNbHSjSCSrZOSdtI91JbXg==
X-Received: by 2002:a05:6402:524f:b0:49e:498c:5e16 with SMTP id t15-20020a056402524f00b0049e498c5e16mr233070edd.30.1673995328510;
        Tue, 17 Jan 2023 14:42:08 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ku12-20020a170907788c00b0084d4564c65fsm11480669ejc.42.2023.01.17.14.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 14:42:07 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 385EA9011B1; Tue, 17 Jan 2023 23:42:07 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@corigine.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, davem@davemloft.net, kuba@kernel.org,
        hawk@kernel.org, pabeni@redhat.com, edumazet@google.com,
        memxor@gmail.com, alardam@gmail.com, saeedm@nvidia.com,
        anthony.l.nguyen@intel.com, gospo@broadcom.com,
        vladimir.oltean@nxp.com, nbd@nbd.name, john@phrozen.org,
        leon@kernel.org, simon.horman@corigine.com, aelior@marvell.com,
        christophe.jaillet@wanadoo.fr, ecree.xilinx@gmail.com,
        mst@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com,
        maciej.fijalkowski@intel.com, intel-wired-lan@lists.osuosl.org,
        lorenzo.bianconi@redhat.com
Subject: Re: [RFC v2 bpf-next 2/7] drivers: net: turn on XDP features
In-Reply-To: <Y8chM32w/ZWsOOT+@oden.dyn.berto.se>
References: <cover.1673710866.git.lorenzo@kernel.org>
 <b606e729c9baf36a28be246bf0bfa4d21cc097fb.1673710867.git.lorenzo@kernel.org>
 <Y8cTKOmCBbMEZK8D@sleipner.dyn.berto.se> <87y1q0bz6m.fsf@toke.dk>
 <Y8cboWSmvoOKxav2@oden.dyn.berto.se> <87sfg8byek.fsf@toke.dk>
 <Y8chM32w/ZWsOOT+@oden.dyn.berto.se>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 17 Jan 2023 23:42:07 +0100
Message-ID: <87pmbcbx6o.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Niklas S=C3=B6derlund <niklas.soderlund@corigine.com> writes:

> On 2023-01-17 23:15:47 +0100, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Niklas S=C3=B6derlund <niklas.soderlund@corigine.com> writes:
>>=20
>> > Hi Toke,
>> >
>> > On 2023-01-17 22:58:57 +0100, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> >> Niklas S=C3=B6derlund <niklas.soderlund@corigine.com> writes:
>> >>=20
>> >> > Hi Lorenzo and Marek,
>> >> >
>> >> > Thanks for your work.
>> >> >
>> >> > On 2023-01-14 16:54:32 +0100, Lorenzo Bianconi wrote:
>> >> >
>> >> > [...]
>> >> >
>> >> >>=20
>> >> >> Turn 'hw-offload' feature flag on for:
>> >> >>  - netronome (nfp)
>> >> >>  - netdevsim.
>> >> >
>> >> > Is there a definition of the 'hw-offload' written down somewhere? F=
rom=20
>> >> > reading this series I take it is the ability to offload a BPF progr=
am?=20=20
>> >>=20
>> >> Yeah, basically this means "allows loading and attaching programs in
>> >> XDP_MODE_HW", I suppose :)
>> >>=20
>> >> > It would also be interesting to read documentation for the other fl=
ags=20
>> >> > added in this series.
>> >>=20
>> >> Yup, we should definitely document them :)
>> >>=20
>> >> > [...]
>> >> >
>> >> >> diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c=20
>> >> >> b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
>> >> >> index 18fc9971f1c8..5a8ddeaff74d 100644
>> >> >> --- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
>> >> >> +++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
>> >> >> @@ -2529,10 +2529,14 @@ static void nfp_net_netdev_init(struct nfp=
_net *nn)
>> >> >>  	netdev->features &=3D ~NETIF_F_HW_VLAN_STAG_RX;
>> >> >>  	nn->dp.ctrl &=3D ~NFP_NET_CFG_CTRL_RXQINQ;
>> >> >>=20=20
>> >> >> +	nn->dp.netdev->xdp_features =3D NETDEV_XDP_ACT_BASIC |
>> >> >> +				      NETDEV_XDP_ACT_HW_OFFLOAD;
>> >> >
>> >> > If my assumption about the 'hw-offload' flag above is correct I thi=
nk=20
>> >> > NETDEV_XDP_ACT_HW_OFFLOAD should be conditioned on that the BPF fir=
mware=20
>> >> > flavor is in use.
>> >> >
>> >> >     nn->dp.netdev->xdp_features =3D NETDEV_XDP_ACT_BASIC;
>> >> >
>> >> >     if (nn->app->type->id =3D=3D NFP_APP_BPF_NIC)
>> >> >         nn->dp.netdev->xdp_features |=3D NETDEV_XDP_ACT_HW_OFFLOAD;
>> >> >
>> >> >> +
>> >> >>  	/* Finalise the netdev setup */
>> >> >>  	switch (nn->dp.ops->version) {
>> >> >>  	case NFP_NFD_VER_NFD3:
>> >> >>  		netdev->netdev_ops =3D &nfp_nfd3_netdev_ops;
>> >> >> +		nn->dp.netdev->xdp_features |=3D NETDEV_XDP_ACT_XSK_ZEROCOPY;
>> >> >>  		break;
>> >> >>  	case NFP_NFD_VER_NFDK:
>> >> >>  		netdev->netdev_ops =3D &nfp_nfdk_netdev_ops;
>> >> >
>> >> > This is also a wrinkle I would like to understand. Currently NFP su=
pport=20
>> >> > zero-copy on NFD3, but not for offloaded BPF programs. But with the=
 BPF=20
>> >> > firmware flavor running the device can still support zero-copy for=
=20
>> >> > non-offloaded programs.
>> >> >
>> >> > Is it a problem that the driver advertises support for both=20
>> >> > hardware-offload _and_ zero-copy at the same time, even if they can=
't be=20
>> >> > used together but separately?
>> >>=20
>> >> Hmm, so the idea with this is to only expose feature flags that are
>> >> supported "right now" (you'll note that some of the drivers turn the
>> >> REDIRECT_TARGET flag on and off at runtime). Having features that are
>> >> "supported but in a different configuration" is one of the points of
>> >> user confusion we want to clear up with the explicit flags.
>> >>=20
>> >> So I guess it depends a little bit what you mean by "can't be used
>> >> together"? I believe it's possible to load two programs at the same
>> >> time, one in HW mode and one in native (driver) mode, right? In this
>> >> case, could the driver mode program use XSK zerocopy while the HW mode
>> >> program is also loaded?
>> >
>> > Exactly, this is my concern. Two programs can be loaded at the same=20
>> > time, one in HW mode and one in native mode. The program in native mod=
e=20
>> > can use zero-copy at the same time as another program runs in HW mode.
>> >
>> > But the program running in HW mode can never use zero-copy.
>>=20
>> Hmm, but zero-copy is an AF_XDP feature, and AFAIK offloaded programs
>> can't use AF_XDP at all? So the zero-copy "feature" is available on the
>> hardware, it's just intrinsic to that feature that it doesn't work on
>> offloaded programs?
>
> That is true, so this is indeed not an issue then. Thanks for the=20
> clarification.

Cool - you're welcome :)

-Toke

