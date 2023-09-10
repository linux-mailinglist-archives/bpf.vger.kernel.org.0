Return-Path: <bpf+bounces-9606-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF1C799CEE
	for <lists+bpf@lfdr.de>; Sun, 10 Sep 2023 09:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA07A281495
	for <lists+bpf@lfdr.de>; Sun, 10 Sep 2023 07:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFDB20E1;
	Sun, 10 Sep 2023 07:42:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3EC1FA5;
	Sun, 10 Sep 2023 07:42:41 +0000 (UTC)
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D34E1A5;
	Sun, 10 Sep 2023 00:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1694331760; x=1725867760;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=XZDMHjLCzBJxfJOUjPli1J6tIJe9V4NdWBGiZIZwthc=;
  b=pzcxciN6m3hkzK7M0KSqauKdQvqu6Acm81JLeT6HhXm+St/a5GjLVMm6
   Hhb4jMWaCowwswQjgcS2DZLhZip0HSZ0b43zCYrscVB3eShrRVYhoxBKG
   wwU9WOPVsoMFGN2jFD1NYbKSmWqglwCdzc1L7n1WBxhG+By8rLmK5crdo
   4=;
X-IronPort-AV: E=Sophos;i="6.02,241,1688428800"; 
   d="scan'208";a="607025360"
Subject: RE: [PATCH net 1/4] net: ena: Flush XDP packets on error.
Thread-Topic: [PATCH net 1/4] net: ena: Flush XDP packets on error.
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-32fb4f1a.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2023 07:42:37 +0000
Received: from EX19D001EUA002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
	by email-inbound-relay-pdx-2b-m6i4x-32fb4f1a.us-west-2.amazon.com (Postfix) with ESMTPS id CCA68C062B;
	Sun, 10 Sep 2023 07:42:35 +0000 (UTC)
Received: from EX19D047EUA003.ant.amazon.com (10.252.50.160) by
 EX19D001EUA002.ant.amazon.com (10.252.50.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Sun, 10 Sep 2023 07:42:34 +0000
Received: from EX19D022EUA002.ant.amazon.com (10.252.50.201) by
 EX19D047EUA003.ant.amazon.com (10.252.50.160) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Sun, 10 Sep 2023 07:42:34 +0000
Received: from EX19D022EUA002.ant.amazon.com ([fe80::7f87:7d63:def0:157d]) by
 EX19D022EUA002.ant.amazon.com ([fe80::7f87:7d63:def0:157d%3]) with mapi id
 15.02.1118.037; Sun, 10 Sep 2023 07:42:34 +0000
From: "Kiyanovski, Arthur" <akiyano@amazon.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, "Paolo
 Abeni" <pabeni@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "Arinzon,
 David" <darinzon@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>, "Bshara,
 Saeed" <saeedb@amazon.com>, "Agroskin, Shay" <shayagr@amazon.com>
Thread-Index: AQHZ4lyQaTI54ci/w0SwCkbcyjFanbATrxIA
Date: Sun, 10 Sep 2023 07:42:14 +0000
Deferred-Delivery: Sun, 10 Sep 2023 07:41:47 +0000
Message-ID: <ed993d0d419443d2965015a504cb730b@amazon.com>
References: <20230908135748.794163-1-bigeasy@linutronix.de>
 <20230908135748.794163-2-bigeasy@linutronix.de>
In-Reply-To: <20230908135748.794163-2-bigeasy@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [10.85.143.179]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Precedence: Bulk
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> -----Original Message-----
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Sent: Friday, September 8, 2023 4:58 PM
> To: netdev@vger.kernel.org; bpf@vger.kernel.org
> Cc: David S. Miller <davem@davemloft.net>; Alexei Starovoitov
> <ast@kernel.org>; Daniel Borkmann <daniel@iogearbox.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Jesper
> Dangaard Brouer <hawk@kernel.org>; John Fastabend
> <john.fastabend@gmail.com>; Paolo Abeni <pabeni@redhat.com>; Thomas
> Gleixner <tglx@linutronix.de>; Sebastian Andrzej Siewior
> <bigeasy@linutronix.de>; Kiyanovski, Arthur <akiyano@amazon.com>;
> Arinzon, David <darinzon@amazon.com>; Dagan, Noam
> <ndagan@amazon.com>; Bshara, Saeed <saeedb@amazon.com>; Agroskin,
> Shay <shayagr@amazon.com>
> Subject: [EXTERNAL] [PATCH net 1/4] net: ena: Flush XDP packets on error.
>=20
> CAUTION: This email originated from outside of the organization. Do not c=
lick
> links or open attachments unless you can confirm the sender and know the
> content is safe.
>=20
>=20
>=20
> xdp_do_flush() should be invoked before leaving the NAPI poll function af=
ter
> a XDP-redirect. This is not the case if the driver leaves via the error p=
ath
> (after having a redirect in one of its previous iterations).
>=20
> Invoke xdp_do_flush() also in the error path.
>=20
> Cc: Arthur Kiyanovski <akiyano@amazon.com>
> Cc: David Arinzon <darinzon@amazon.com>
> Cc: Noam Dagan <ndagan@amazon.com>
> Cc: Saeed Bishara <saeedb@amazon.com>
> Cc: Shay Agroskin <shayagr@amazon.com>
> Fixes: a318c70ad152b ("net: ena: introduce XDP redirect implementation")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/net/ethernet/amazon/ena/ena_netdev.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c
> b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> index ad32ca81f7ef4..f955bde10cf90 100644
> --- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
> +++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> @@ -1833,6 +1833,9 @@ static int ena_clean_rx_irq(struct ena_ring
> *rx_ring, struct napi_struct *napi,
>         return work_done;
>=20
>  error:
> +       if (xdp_flags & ENA_XDP_REDIRECT)
> +               xdp_do_flush();
> +
>         adapter =3D netdev_priv(rx_ring->netdev);
>=20
>         if (rc =3D=3D -ENOSPC) {
> --
> 2.40.1
>=20

Thanks for submitting this change.

Acked-by: Arthur Kiyanovski <akiyano@amazon.com>


