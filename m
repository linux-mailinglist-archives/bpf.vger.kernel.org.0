Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1035D636D79
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 23:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiKWWpP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 17:45:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiKWWpM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 17:45:12 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB6D1541A1
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 14:45:10 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id t62so20547928oib.12
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 14:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sHBF341UB7UVlHmjLxw21h/DhRvlIsP/VwMIHyOu0Cw=;
        b=piTIC4RWLLhWFa20X04ciY3/ovKm6ZGqbrUhJVEYbjaGbJgL30zeNbSV1A2+3npDXf
         CxLYIAytQP1m9ZtVrPpjGncL7AFzlXGrjgvWUfIyTLAneMdpcjPbHXJqwkIBKuIQBYvW
         idSORnpLZ2hVXUYpHweQhTJf7X5v/rWMLKCDtUm4n4kvVFZ9cvdb4YOZ1F8pMMcF4BwJ
         EIkzITj3m1T7rmbDqhTFIX9HsJSBnAWEniPSIwcCdz4h6FyqqRvqxgAJQddufaplAGB6
         yBcKhesbwFlmNrTy1MjUufzDup/IZ9OGL0gOzBs34hCSrGw/SQhLas4DRS/glVdiC/MW
         a05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sHBF341UB7UVlHmjLxw21h/DhRvlIsP/VwMIHyOu0Cw=;
        b=UJGNU2Y4kc3gkSvaEd5iSZYaFJFvaULIwBMHKoSPpFOc1WWM4ARBrLI9htVy295cai
         2LdGwfg1KdzY5CRGWCJKSytr1WZJehs5QRuzqtmDXXUnZaI5xGpOPnV9UhHkQ57Zs9mI
         CHoVslKK4SVeGTBsAtWkSwa/UVaQn1Ro9bEkCenLp8u2nXmE2vcEqCuIuswjYMGNxlj0
         En0eVRB42vu+h3HD999GBjQhWanGTEjCxzTXhymVSHisuqXvTRCmr+qj1kn2R1kK0HT7
         e2joiKyk/kl+RcCCvsBODEeV9a3bnPvTzVokeeonIgTIjiU42EzdI+STNYLF/j6jP7VZ
         qnHA==
X-Gm-Message-State: ANoB5pnuT8BbPvVxO7niqbadvkQxyWFVPwpCiL14tYUPigb0ejQussLw
        ERljcxjilyZwI5MkwITJEUMBU1oET1bVzHbV5j31HQ==
X-Google-Smtp-Source: AA0mqf7PGz+vykGSlqIhYyKX/n87PS0N5FoNzdp7q5bptfquGdsGcag2okw3SO4SmV5j2h56tDSb5HMZBiRV9jZpfmo=
X-Received: by 2002:aca:674c:0:b0:35b:79ca:2990 with SMTP id
 b12-20020aca674c000000b0035b79ca2990mr2237880oiy.125.1669243509383; Wed, 23
 Nov 2022 14:45:09 -0800 (PST)
MIME-Version: 1.0
References: <20221121182552.2152891-1-sdf@google.com> <20221123144641.339138-1-toke@redhat.com>
 <20221123144641.339138-2-toke@redhat.com> <Y36e0Qt9eLtLZXmO@x130.lan>
In-Reply-To: <Y36e0Qt9eLtLZXmO@x130.lan>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 23 Nov 2022 14:44:58 -0800
Message-ID: <CAKH8qBueYO_8h292bayYq1CeS3U4Phv4hr=zjDWz87nmZ9eyhg@mail.gmail.com>
Subject: Re: [xdp-hints] [PATCH bpf-next 2/2] mlx5: Support XDP RX metadata
To:     Saeed Mahameed <saeed@kernel.org>
Cc:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        bpf@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
        David Ahern <dsahern@gmail.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Anatoly Burakov <anatoly.burakov@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 23, 2022 at 2:29 PM Saeed Mahameed <saeed@kernel.org> wrote:
>
> On 23 Nov 15:46, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> >Support RX hash and timestamp metadata kfuncs. We need to pass in the cq=
e
> >pointer to the mlx5e_skb_from* functions so it can be retrieved from the
> >XDP ctx to do this.
> >
> >Cc: John Fastabend <john.fastabend@gmail.com>
> >Cc: David Ahern <dsahern@gmail.com>
> >Cc: Martin KaFai Lau <martin.lau@linux.dev>
> >Cc: Jakub Kicinski <kuba@kernel.org>
> >Cc: Willem de Bruijn <willemb@google.com>
> >Cc: Jesper Dangaard Brouer <brouer@redhat.com>
> >Cc: Anatoly Burakov <anatoly.burakov@intel.com>
> >Cc: Alexander Lobakin <alexandr.lobakin@intel.com>
> >Cc: Magnus Karlsson <magnus.karlsson@gmail.com>
> >Cc: Maryam Tahhan <mtahhan@redhat.com>
> >Cc: Stanislav Fomichev <sdf@google.com>
> >Cc: xdp-hints@xdp-project.net
> >Cc: netdev@vger.kernel.org
> >Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> >---
> >This goes on top of Stanislav's series, obvioulsy. Verified that it work=
s using
> >the xdp_hw_metadata utility; going to do ome benchmarking and follow up =
with the
> >results, but figured I'd send this out straight away in case others want=
ed to
> >play with it.
> >
> >Stanislav, feel free to fold it into the next version of your series if =
you
> >want!
> >
>
> [...]
>
> > #endif /* __MLX5_EN_XSK_RX_H__ */
> >diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers=
/net/ethernet/mellanox/mlx5/core/en_main.c
> >index 14bd86e368d5..015bfe891458 100644
> >--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> >+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> >@@ -4890,6 +4890,10 @@ const struct net_device_ops mlx5e_netdev_ops =3D =
{
> >       .ndo_tx_timeout          =3D mlx5e_tx_timeout,
> >       .ndo_bpf                 =3D mlx5e_xdp,
> >       .ndo_xdp_xmit            =3D mlx5e_xdp_xmit,
> >+      .ndo_xdp_rx_timestamp_supported =3D mlx5e_xdp_rx_timestamp_suppor=
ted,
> >+      .ndo_xdp_rx_timestamp    =3D mlx5e_xdp_rx_timestamp,
> >+      .ndo_xdp_rx_hash_supported =3D mlx5e_xdp_rx_hash_supported,
> >+      .ndo_xdp_rx_hash         =3D mlx5e_xdp_rx_hash,
>
> I hope i am not late to the party.
> but I already expressed my feelings regarding using kfunc for xdp hints,
> @LPC and @netdevconf.
>
> I think it's wrong to use indirect calls, and for many usecases the
> overhead will be higher than just calculating the metadata on the spot.
>
> so you will need two indirect calls per packet per hint..
> some would argue on some systems calculating the hash would be much faste=
r.
> and one major reason to have the hints is to accelerate xdp edge and
> security programs with the hw provided hints.
>
> what happened with just asking the driver to place the data in a specific
> location on the headroom?

Take a look at [0], we are resolving indirect calls. We can also
always go back to unrolling those calls as was done initially in [1].

0: https://lore.kernel.org/bpf/20221121182552.2152891-3-sdf@google.com/
1: https://lore.kernel.org/bpf/20221115030210.3159213-4-sdf@google.com/

kfunc approach seems more flexible than an all-or-nothing approach
with the driver pre-filling all metadata.
