Return-Path: <bpf+bounces-7510-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D34C7784E6
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 03:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F8931C20F38
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 01:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EC4A3D;
	Fri, 11 Aug 2023 01:27:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EDF7F1;
	Fri, 11 Aug 2023 01:27:00 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2082.outbound.protection.outlook.com [40.107.20.82])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA21B2D58;
	Thu, 10 Aug 2023 18:26:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dK8MssYLvDDYxQaMs3Vh0SFfJLpSRIe1/NA8hdn9j7fvAJTFo2OqQGFXuWyyA8IBxAw9mwySLgfyOlMVIRd1VkBIQyOfv5ooQjyF3SwNPjpWxCyvscC4bf52zylx9YZP8gMIzYUtnAadAFbkkft4+tiwZGmJAsUy8G4QZwojOQUnJvjY0WohIH+rsXi1wPuhPwcFyre2jFddBssk/nf4wYwtxh7lMNGihLXz4m7e9fi5+wDQPLP7npQ5uYwQEHAheOKOwbEo5B8hco4y/BiIDm83BU+qxycohIM3pxgqbysr9sSYz6JiHLfRp7SBt5AWjUuym6rtbSb4NGatBAyWGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Goqnhb8WsS4SULRc98RCjibmZLaOMzjcWgpRLEEYbYk=;
 b=QycWodxTI3pwY9ZzgAuobXs0WQ4LNum8ExlCUjL7IXQlmHzLMaMbVjVjSglVPnCcy/o4cozh07Z00xI1MmeLAaFPAd/JWJRcygNSqpRUNCJ9IXYKxi7/QOyzMbaS1Vw9na+kWtXOCYX+MntTWTSDuQkyU4c2K4E/oomsadMBThZpOYa5VjTSkv4KTCxR3emxT5m/N993eQEveGOhhBaxwAE60qjByfAbCpt0kt7knJcddGmwxcBxxcYcO1CnQ0gvldbwXg1zqlT9+Nf4fhZDeQuEALcdDCITWYOW7u/nC4iIejV3jfpRCIWPNzAmKaDbdGo63un2mh5JRxBCZn1L/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Goqnhb8WsS4SULRc98RCjibmZLaOMzjcWgpRLEEYbYk=;
 b=AFRwU0xlwbLulPfZqyY/7z2Q82i9qNoGj+n/yZGuHB/QioinIHlLqbWBXujXOLOfO0w07D3IaBWIa8LScJE7nLHyXb9l4za2niaQ/Y2dqSkB9GTrSi5/WLIw9pdldWD38blH701plxNfS6aNFPkolegN3cCi7irLm6xAA7gpyOU=
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by AM0PR04MB6852.eurprd04.prod.outlook.com (2603:10a6:208:18c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.19; Fri, 11 Aug
 2023 01:26:56 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e%4]) with mapi id 15.20.6678.019; Fri, 11 Aug 2023
 01:26:56 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "larysa.zaremba@intel.com"
	<larysa.zaremba@intel.com>, "aleksander.lobakin@intel.com"
	<aleksander.lobakin@intel.com>, "jbrouer@redhat.com" <jbrouer@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: dl-linux-imx <linux-imx@nxp.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [PATCH V5 net-next 1/2] net: fec: add XDP_TX feature support
Thread-Topic: [PATCH V5 net-next 1/2] net: fec: add XDP_TX feature support
Thread-Index: AQHZy1dCnxQwOLKBq0eoj4kIh1yvrq/jjtGAgAC/ZrA=
Date: Fri, 11 Aug 2023 01:26:56 +0000
Message-ID:
 <AM5PR04MB3139BB2A930C4D7297FDA3348810A@AM5PR04MB3139.eurprd04.prod.outlook.com>
References: <20230810064514.104470-1-wei.fang@nxp.com>
 <20230810064514.104470-2-wei.fang@nxp.com>
 <a7ede79c-8d5f-0036-7b8d-67c736cea058@kernel.org>
In-Reply-To: <a7ede79c-8d5f-0036-7b8d-67c736cea058@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM5PR04MB3139:EE_|AM0PR04MB6852:EE_
x-ms-office365-filtering-correlation-id: b65045f2-6445-4e0a-7aed-08db9a0a0d26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 n4p7mVw9u+zjNa35MpB87Jtkpd2vbB7B048fF8TttzYaHKOadX6AQHi05f3fX+5U7hR94TjgZvPfAgu23BEsF7uRuOX8mee/QMS+u0negMt43+yEYqWf4eWk60mJ4YkQczn5QEt76KXiVneRn8i3sX/5OrLfzubmmrXT7Ja4uRk6mseqTduvyA7U34vhqEt51jx4gFbENlkOBwMKjnySSP6GlbgixJQcd7whgaSA+ctALpEOeHtVMZl24uCfUK5+LNGIOGCcA02ipBNwWx2WwWwId4YZsR2HsOmfGnELuzEpMPDz5RZwHeh8KjVCoZhdlBY/quRJTvVrwf9ImhicJnmvHAanNAsQ1EVf4V2Us415dr3k4FJx/pXIdZ2SYBJR6nx07wOJW1cbN9kAehrIHiQYuqxPcUGBFHKeZsLk9AW/NoE0Da7wb2jQJAhccune0GJKo3qaHRzUT3Dfmvf1Pt2reYIY+xtGxkBp/vXphD0r51y/iMtKpv7ISDKn8oXCF1TQHl5ni/mmmkQAcCQ+/rkalgxdyE5cyAKZDJy6P2CO0iuX8DyFvQpeseIzsUY5L1SGGCZm0oy8pu0XBh1xfXg1/kq1da8zkcEDWt6t2zkgq8p2zvzKZTvosqG8N6mn
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(346002)(136003)(366004)(396003)(451199021)(186006)(1800799006)(4326008)(38070700005)(66946007)(76116006)(66556008)(66476007)(66446008)(64756008)(41300700001)(86362001)(316002)(26005)(6506007)(71200400001)(921005)(9686003)(7696005)(55016003)(33656002)(83380400001)(110136005)(54906003)(122000001)(478600001)(38100700002)(2906002)(4744005)(5660300002)(52536014)(8676002)(8936002)(7416002)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?c07j2UyWvc0OEKkwmlUFGFks7pPwlKF5nlp0c+7CbyTRmktgrhHKdsQMEe2g?=
 =?us-ascii?Q?Lh/UDO71OTTtqveFbYKr8N/xFMzwT3dgZ05lGkVi65kjQlrtA0gPNEV4NZzN?=
 =?us-ascii?Q?NxyjhZ+b7JQsw0qYT4cy7gi5IPfb5nubv+kmxmrO82zvndR0Bs/OOgFarg1E?=
 =?us-ascii?Q?332s711LWOVL4dHAqGF1rIc2nhrqDa+VG9Ar9101J5vCqjwwE38zexjIKZ8y?=
 =?us-ascii?Q?x/RWpg3/gQ4WRnagpXQXbwHSKwXd0XwV9rVt18HQzfDvVYbH7YZURZCBimQI?=
 =?us-ascii?Q?9gqcqACbJkHYMZCcRffGtBCjY5BqZ17ee8coNM/N15Sl6Rl+Nci88M6Kxas9?=
 =?us-ascii?Q?P5+ngAuib+tmNPAIxDaCZjTzqxJWLY3pnsrQfrFIyoZ9zFRuL4D+uHLTC4ni?=
 =?us-ascii?Q?ApIIc7fg24+qoJQcJ7ZVEw8d+JcJfvjwMwgnv1mjD5sI6qtBRBbfwpm8oi9Z?=
 =?us-ascii?Q?wchT7arTynvpU4czPbNZ14Iko3RyVyIIe9KZSsFRq5ntABv+IVvcPEO063mO?=
 =?us-ascii?Q?kcn17sid63Z1EEQpp3uZimo9/UUudOW/sDDLXJBWilemk0/i4770btvD9IYJ?=
 =?us-ascii?Q?u8eYQwWdLn++4cvgK1NX2DqZioJXJ9yE39H4X37Flm2PbISzmYRXdUWulzod?=
 =?us-ascii?Q?4TqN9qln9K0kBuKbU2e5kOvA7bZqF/wPQI09fKNqp0g0red/Ikqg1pC7VYFu?=
 =?us-ascii?Q?XkftR26k1SRLpfvX0kvLBf/C53ZgkBixSdI+8LlLBZWeXEST+OO7Yo5fHeDZ?=
 =?us-ascii?Q?NCB+rEEWgNh9CptrxFM6pW9ZtmboJFkpRHk8kGP0rYZr4Izb/DKE2d7TzJYl?=
 =?us-ascii?Q?H9iuvG7KOGqI3qr+C9FTYdRzOtHYC0DUbEN33M6Wy5G+oOP/fpOUp6on2e8q?=
 =?us-ascii?Q?yuOJPLR3grjPGtS/ODnhCB4q1D5MviMZH3AZKsJozOMlQgPWkSGc7qW7/cmg?=
 =?us-ascii?Q?DPl+SaCtBHkR83BBj5rK1c+3PlDYTkI+rIQPe70PQ0+wxRBwDColcDioJmSY?=
 =?us-ascii?Q?Np+xXyLQVmgVsIb9ete/xCjrxbAlqvhka+Dljt8B6o/cEVYIao7wMyMdIisr?=
 =?us-ascii?Q?iOekiFbKTPrWrAlShYDPnMSfMB4PnOgp+6QngCrT7qWcWCTn6ip96vTrIMlE?=
 =?us-ascii?Q?vHyTQi/aRSoRTYzU9FKGdvoE0J22rBGWAgUk9XlNBuwQm4wDERUa51HDo3Fx?=
 =?us-ascii?Q?/rJInnbzZlzZ31xLOpnHazrgJjvS3ocgi2p3ettsnY4ShVLGUh7bS7nO3s6w?=
 =?us-ascii?Q?02DS/m9ABr9U+s7N+pQVYSGgj6UImE43B2E7+LmaRoaidk+x4+4tT9V8nQWN?=
 =?us-ascii?Q?4QGifUo/mExxQeny9cdtrJ0udeBCiMrJ8HpbSFJLtdISld/LRNPlCnhhnu4U?=
 =?us-ascii?Q?vrlIeljFuPcuknTIqDh93+qvN5fdl+ERfAv1aAQaUjPoHP9wZ3XmT3Rc4sGe?=
 =?us-ascii?Q?Mj+Gbp+FEcDw5xiYDc1JNJ3FCCdutYm3puAPNBDkBqPnFejWfemYkQggPSMb?=
 =?us-ascii?Q?u2yTXTxVAAb/z14CVw/pj/44AU5OlmGEJgw5LAIQO8izr0rWGQBSL5rcLR6S?=
 =?us-ascii?Q?+fCGryJwTG9+FU1YCQQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB3139.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b65045f2-6445-4e0a-7aed-08db9a0a0d26
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2023 01:26:56.3745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iHZWb8kvqJZKQdBB4/qpORfGa6UN2/5fIU7Dlt8PaTaka0c2hRER9r4VbLtMa/JpK4W3BvooJs9CogXxAXAv6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6852
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> If you add below code comment you can add my ACK in V6:
>=20
Okay, I will add the annotation to the code in V6. Thanks.

> Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
>=20
> > @@ -1482,7 +1488,13 @@ fec_enet_tx_queue(struct net_device *ndev,
> u16 queue_id, int budget)
> >   			/* Free the sk buffer associated with this last transmit */
> >   			dev_kfree_skb_any(skb);
> >   		} else {
> > -			xdp_return_frame(xdpf);
> > +			if (txq->tx_buf[index].type =3D=3D FEC_TXBUF_T_XDP_NDO) {
> > +				xdp_return_frame_rx_napi(xdpf);
> > +			} else {
> > +				struct page *page =3D virt_to_head_page(xdpf->data);
> > +
>=20
> I think this usage of page_pool_put_page() with dma_sync_size=3D0 require=
s a
> comment, else we will forget why this okay...
> I suggest:
>=20
> /* PP dma_sync_size=3D0 as xmit already synced DMA for_device */
>=20
> > +				page_pool_put_page(page->pp, page, 0, true);
> > +			}
> >
> >   			txq->tx_buf[index].xdp =3D NULL;
> >   			/* restore default tx buffer type: FEC_TXBUF_T_SKB */
> @@ -1541,7


