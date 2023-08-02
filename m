Return-Path: <bpf+bounces-6707-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC1776CCB8
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 14:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 778C61C2127A
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 12:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A5B6FD1;
	Wed,  2 Aug 2023 12:33:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C778C746A;
	Wed,  2 Aug 2023 12:33:39 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2087.outbound.protection.outlook.com [40.107.21.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5AE26B0;
	Wed,  2 Aug 2023 05:33:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iyiGlEvLvfQ11Lsapaz7OnD7sH2/ljnOO96qsu8i6UNf7BgjWVmv/Ao1AiUTwAD6tW5sZcDoul49Vm5KkehSN/Vy49HEL2HAkrjichwx9pnz//m1vKTc2oYPxV7M9LfsQgA3UWxb8rsn9oG+PNz2fwLIHvKcLzdVckfyCVS3JeGnbiSE3DoS74n+cd5QJZvJhRAZtm78o0q/8IvvIyYWMR5B8eoX/ikyvLpVsp/iH96e6wy6ZbBCq68pI/iPl1GJsQ1i+zWhJtkpmMJFbwesgMwTjLZ1kMJ1MuEPBVVJ2TAh9jAzXgkHqrIiaAQEJEGYHFrPPnFdIItZsR+RfS9yug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TkoppINBLfamUneXUPV6yyRaqg5azFjlc2NK4pZ0Tuk=;
 b=RAxSyor5/ozXkJT/P1EkghLt9onkFNouu+LmCSIb6udJTeCo3m7R/fb0KexE0Lh8PMWeJyx/kz0VUqJBaBMReGD4ZEFBTP1FNJQmyaZN21QbzCRRemv2v1y7nzwMeEKjfBk+58WQg/7m+OoYknUEJqGrAYXaHA8J175vIDdtZN8JIxC5UeGqOrZ6K/9phEIqeX57gMw+4dGiclNuaG5duhAY2dQ+SbY6tvohmSFwRltiGoJEMuKLsTBtTew5dyb9lKfafm5gUCbQw/FGcX890BbwwtujCQUE3z/bdeLTj50YeeFYyJxOTB99X9lMi6PtQFDymMqVicL3nxup3KBa8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TkoppINBLfamUneXUPV6yyRaqg5azFjlc2NK4pZ0Tuk=;
 b=E3cqcxp5NlPz2NPqViqHFU+dsIoT0KlcM9peQF9tcMLKnTeLubKUvXQjW4xZZi4UnveoBen7zp7aFqOLhOcFDnGb64xYDIUOlCJGedgECv5sK1HScQLWnGS8Dic8fyM2w5b7Q9e+S3GopjY+od0T5CKkVbA9Y3dg12PhIy0olag=
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by AS8PR04MB8740.eurprd04.prod.outlook.com (2603:10a6:20b:42d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 12:33:34 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e%4]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 12:33:34 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Jesper Dangaard Brouer <jbrouer@redhat.com>
CC: "brouer@redhat.com" <brouer@redhat.com>, dl-linux-imx <linux-imx@nxp.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, "ast@kernel.org" <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "hawk@kernel.org"
	<hawk@kernel.org>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH V3 net-next] net: fec: add XDP_TX feature support
Thread-Topic: [PATCH V3 net-next] net: fec: add XDP_TX feature support
Thread-Index: AQHZw3VFF5NSBizeREOxLxVc18wksa/WwA6AgAAZpQA=
Date: Wed, 2 Aug 2023 12:33:34 +0000
Message-ID:
 <AM5PR04MB3139E5A9A0B407922A33BF99880BA@AM5PR04MB3139.eurprd04.prod.outlook.com>
References: <20230731060025.3117343-1-wei.fang@nxp.com>
 <3d0a8536-6a22-22e5-41c0-98c13dd7b802@redhat.com>
In-Reply-To: <3d0a8536-6a22-22e5-41c0-98c13dd7b802@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM5PR04MB3139:EE_|AS8PR04MB8740:EE_
x-ms-office365-filtering-correlation-id: 0a22e14e-c85c-44d9-59fa-08db9354b019
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 pQllXwtVCC9RCCZBNpHPToJW1OHWy9Kn795+2/ZhjH7sH2dWi2y+17ECuTSwJ+FtjltyY1tfl5giN8cuA5nt4BRhoZs5dWJgcZ4Py/PoqH6sC7771zalI7PlWdRS3uCu+ifrRHrQv7nUcXldSNP92JLamIPIZ6XpPd4G7r7PkI5mMMHFrjPpxvW9B/DW3YQvdLkaoteKz5n1Dm20aFB9G+ciFoj+DQsi5fwFCKfmTN1ICXscKGokTZW0OYJ8VaMPv8Xi/BOFygiTwhKSXfBjssfihfTM3Xu8UAFLIZZ0UbRNX6jMpAyWaHn2DBUjkiCjYPHq+xQjAmpApCsBr3kC60ZiAtQs4tnT9Vy+EC/LoZw2IM41XgaGgk30JaOhorVA7Ryvm5hJzyEU4QSCNuwCxlB9NZsqxkxyYR6fy2EgUneQ4jXBn2zRQjUrksK7SqeIZIEJk6mRiuO+KYXGrW/3pQgvwjIMq/ujv86Y9GoKP4Uw9pYwiuiluGbXpdtI9YWwpzcK4CNoyMVGCg5EOgrefQftnBEzl3ooIs6EufwL5kE0N3QlVvJDcQMhAMsyE3I9ORTKyipFDx3dRgLaV7rzz16nE/uYtVSTDvfG3AYffIYTfqvwqsLkJ6nWZ44tkhOX
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199021)(186003)(8936002)(83380400001)(8676002)(26005)(41300700001)(2906002)(5660300002)(7416002)(38070700005)(52536014)(44832011)(55016003)(86362001)(478600001)(122000001)(54906003)(316002)(38100700002)(6506007)(33656002)(66446008)(7696005)(76116006)(66946007)(71200400001)(66476007)(66556008)(64756008)(6916009)(4326008)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ca4CNxQFUjPHpwcEyNn96s7YkS64hwGjAB7GJJjj/VgTq+PAhpvmaFceIpJH?=
 =?us-ascii?Q?7MXp/olXHBe6OC0BkAuS7OmkwIK1UFgzGNBm5LxH6GnxFfR1D8w4FvtdFESY?=
 =?us-ascii?Q?7hqGCNjHJ+MJBMmnlOI6JdP8Jm8F8/aJXRHijUqLm0Ksz6PMUMJUpKGeN1Vz?=
 =?us-ascii?Q?e3Da6wZrC5EIVFtl1rwa2dlkVKbgwFStu+uR91E1ufjeLzaKGXM+eSRIwWBX?=
 =?us-ascii?Q?qmPlfFVsyoQUbfpAaQwDWWW8vTwiuMeFNG27KPXVefVfZMZtHwn9dWlqirQa?=
 =?us-ascii?Q?z1V63MdjMWNotfXHk59HaVVJ6oW0/JpKiVRuofIbPrV0Sl6KCz8V9wxGbRd8?=
 =?us-ascii?Q?pKlyRTa2sS1nnU8Lbz7+lZTDK03t/SCt31y9orvhTAg+ZZHifV6nkaYoQicw?=
 =?us-ascii?Q?xk973UjjoOrYCOOiQonY9io7wy2+wMBgxHjCrLfyhvDjx5E1+mO1j8UclfuL?=
 =?us-ascii?Q?IkT0amuAIKqAbuX04LWqLB2vS1XfRx9iiv+3B0bHkdvp1vAB7J6w7fvSaCYu?=
 =?us-ascii?Q?l8EMOQwzX0tJjgYqruo73aKnVXvut/c6xchWdc8CxGKZ1zWtxx9cvDdVblXt?=
 =?us-ascii?Q?o0a5KliaSOjPiQVeGj2gQV2/j24bX+pDy3LaMm1UikCk61+jZJ2Y/uFmInuR?=
 =?us-ascii?Q?+uJQPfor5lsDGxeLuSuk9vq9d8xhc/uHuKGQ0pGKKfWBnVoGhb5dR/j/7aso?=
 =?us-ascii?Q?rUgpOvBQpvwT6qHpEkkh4gqMRrBJGWtB8b1h2r0hnLor58NtD3ZLFbWECIDf?=
 =?us-ascii?Q?EI2H9NmMdCTpZTkL+NoNgZ0WbnM8KtsQfmcwQ2DNYgi2dZSFE1FBYZsXbW6W?=
 =?us-ascii?Q?wwgOOOU4f3sQZb2CUvIgleRFiswUpocfjsSeTq079RWSvjZcmnSHXya+nSvk?=
 =?us-ascii?Q?P4aLGxJhXK+tSukSUQKPGeAsDQCraG8Wra8PtDT4nCglcMCbpnngRKynkO9e?=
 =?us-ascii?Q?PRhJ5vPpGOUYsbtPJLASVAkPIv3+/Zu9FPB8sSZybcWG6doeA4xSkF1Ss4V7?=
 =?us-ascii?Q?W7gI8uz4dsf8MiUymahk72sz1vn8F46FfMnKAw5p/yzq8Q5ryaFaPMVLF2ur?=
 =?us-ascii?Q?1y2yTa1N5nyhdtfexPQlhLGCsglmyzcMzN+yn97ogYEqPxxJv+mAYRxqEM/Z?=
 =?us-ascii?Q?RzVHli6tZgRdmfeZBiOAt8GN/wb/j6TrKezJQmBKYRj1IMRRItxaSCOLurbS?=
 =?us-ascii?Q?7azsys53ufX0u42AvZ1H84GBYG/6hocElOY1/fa+ugm2OpdY19Py0C751H92?=
 =?us-ascii?Q?HzmgPrfe9aTN8pYxInhUBe0PPPQUxiEdiL+sXAX+DPlUla/BG+DxgOGxU5hO?=
 =?us-ascii?Q?kK3Szu0zA2zW5nmcCdrEN0eOBCr3/bSUfqcov+Sa7Fe71E8DhlJNyO/Gy6NK?=
 =?us-ascii?Q?fFZWqV40vJi3fJZlFXAGozQoHV07ovQnd4V1JUuRZKPJS9fD9+aVx27qVzib?=
 =?us-ascii?Q?/gXX1rcrqR46A2UVc4w+XEzkbvehphTUG6iTTbWrd3/0a6hY/hl2fYHlZ4hZ?=
 =?us-ascii?Q?P8A+ZFCT3bNzoP4lTauuqRC/OBhK30PXWOWz6iGsFGHB17HlSCRgIQWpXgKh?=
 =?us-ascii?Q?O+Tzs/ItKlVJB+9oTMU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a22e14e-c85c-44d9-59fa-08db9354b019
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 12:33:34.3878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VfPjXrVsaIZUbaWtewvmkD+vo8CrIjE/VSZY8XeHOpHfmSmOoszSYeBMnhDVbi9XWlMs9eEqR7aL4rYmcrIFdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8740
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Sorry, I missed some comments before.

> > @@ -1482,7 +1486,7 @@ fec_enet_tx_queue(struct net_device *ndev, u16
> queue_id, int budget)
> >   			/* Free the sk buffer associated with this last transmit */
> >   			dev_kfree_skb_any(skb);
> >   		} else {
> > -			xdp_return_frame(xdpf);
> > +			xdp_return_frame_rx_napi(xdpf);
> >
> >   			txq->tx_buf[index].xdp =3D NULL;
> >   			/* restore default tx buffer type: FEC_TXBUF_T_SKB */
> > @@ -1573,11 +1577,18 @@ fec_enet_run_xdp(struct fec_enet_private
> *fep, struct bpf_prog *prog,
> >   		}
> >   		break;
> >
> > -	default:
> > -		bpf_warn_invalid_xdp_action(fep->netdev, prog, act);
> > -		fallthrough;
> > -
> >   	case XDP_TX:
> > +		err =3D fec_enet_xdp_tx_xmit(fep->netdev, xdp);
>=20
> You should pass along the "sync" length value to fec_enet_xdp_tx_xmit().
> Because we know DMA comes from same device (it is already DMA mapped
> to), then we can do a DMA sync "to_device" with only the sync length.
>=20
I think it's okay if the frame length does not change, but if we increase t=
he
length of the received frame, such as add a VLAN header into the frame, I
think the "sync" length value is not correct.

> > +		if (err) {
>=20
> Add an unlikely(err) or do like above case XDP_REDIRECT, where it takes
> the likely case "if (!err)" first.
Yes, you are right, I will improve it.

>=20
> > +			ret =3D FEC_ENET_XDP_CONSUMED;
> > +			page =3D virt_to_head_page(xdp->data);
> > +			page_pool_put_page(rxq->page_pool, page, sync, true);
> > +		} else {
> > +			ret =3D FEC_ENET_XDP_TX;
> > +		}
> > +		break;
> > +
> > +	default:
> >   		bpf_warn_invalid_xdp_action(fep->netdev, prog, act);
> >   		fallthrough;
> >
> > @@ -3793,7 +3804,8 @@ fec_enet_xdp_get_tx_queue(struct
> fec_enet_private *fep, int index)
> >
> >   static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
> >   				   struct fec_enet_priv_tx_q *txq,
> > -				   struct xdp_frame *frame)
> > +				   struct xdp_frame *frame,
> > +				   bool ndo_xmit)
>=20
> E.g add parameter dma_sync_len.
>=20
> >   {
> >   	unsigned int index, status, estatus;
> >   	struct bufdesc *bdp;
> > @@ -3813,10 +3825,24 @@ static int fec_enet_txq_xmit_frame(struct
> fec_enet_private *fep,
> >
> >   	index =3D fec_enet_get_bd_index(bdp, &txq->bd);
> >
> > -	dma_addr =3D dma_map_single(&fep->pdev->dev, frame->data,
> > -				  frame->len, DMA_TO_DEVICE);
> > -	if (dma_mapping_error(&fep->pdev->dev, dma_addr))
> > -		return -ENOMEM;
> > +	if (ndo_xmit) {
> > +		dma_addr =3D dma_map_single(&fep->pdev->dev, frame->data,
> > +					  frame->len, DMA_TO_DEVICE);
> > +		if (dma_mapping_error(&fep->pdev->dev, dma_addr))
> > +			return -ENOMEM;
> > +
> > +		txq->tx_buf[index].type =3D FEC_TXBUF_T_XDP_NDO;
> > +	} else {
> > +		struct page *page =3D virt_to_page(frame->data);
> > +
> > +		dma_addr =3D page_pool_get_dma_addr(page) + sizeof(*frame) +
> > +			   frame->headroom;
> > +		dma_sync_single_for_device(&fep->pdev->dev, dma_addr,
> > +					   frame->len, DMA_BIDIRECTIONAL);
>=20
> Optimization: use dma_sync_len here instead of frame->len.
>=20
> > +		txq->tx_buf[index].type =3D FEC_TXBUF_T_XDP_TX;
> > +	}
> > +
> > +	txq->tx_buf[index].xdp =3D frame;
> >
> >   	status |=3D (BD_ENET_TX_INTR | BD_ENET_TX_LAST);
> >   	if (fep->bufdesc_ex)
> > @@ -3835,9 +3861,6 @@ static int fec_enet_txq_xmit_frame(struct
> fec_enet_private *fep,
> >   		ebdp->cbd_esc =3D cpu_to_fec32(estatus);
> >   	}
> >
> > -	txq->tx_buf[index].type =3D FEC_TXBUF_T_XDP_NDO;
> > -	txq->tx_buf[index].xdp =3D frame;
> > -
> >   	/* Make sure the updates to rest of the descriptor are performed
> before
> >   	 * transferring ownership.
> >   	 */
> > @@ -3863,6 +3886,31 @@ static int fec_enet_txq_xmit_frame(struct
> fec_enet_private *fep,
> >   	return 0;
> >   }
> >
> > +static int fec_enet_xdp_tx_xmit(struct net_device *ndev,
> > +				struct xdp_buff *xdp)
> > +{
>=20
> E.g add parameter dma_sync_len.
>=20
> > +	struct xdp_frame *xdpf =3D xdp_convert_buff_to_frame(xdp);
>=20
> XDP_TX can avoid this conversion to xdp_frame.
> It would requires some refactor of fec_enet_txq_xmit_frame().
>=20
Yes, but I'm not intend to change it, using the existing interface is enoug=
h.

> > +	struct fec_enet_private *fep =3D netdev_priv(ndev);
> > +	struct fec_enet_priv_tx_q *txq;
> > +	int cpu =3D smp_processor_id();
> > +	struct netdev_queue *nq;
> > +	int queue, ret;
> > +
> > +	queue =3D fec_enet_xdp_get_tx_queue(fep, cpu);
> > +	txq =3D fep->tx_queue[queue];
> > +	nq =3D netdev_get_tx_queue(fep->netdev, queue);
> > +
> > +	__netif_tx_lock(nq, cpu);
>=20
> It is sad that XDP_TX takes a lock for each frame.
>=20
Yes, but the XDP path share the queue with the kernel network stack, so
we need a lock here, unless there is a dedicated queue for XDP path. Do
you have a better solution?

> > +
> > +	/* Avoid tx timeout as XDP shares the queue with kernel stack */
> > +	txq_trans_cond_update(nq);
> > +	ret =3D fec_enet_txq_xmit_frame(fep, txq, xdpf, false);
>=20
> Add/pass parameter dma_sync_len to fec_enet_txq_xmit_frame().
>=20
>=20
> > +
> > +	__netif_tx_unlock(nq);
> > +
> > +	return ret;
> > +}
> > +
> >   static int fec_enet_xdp_xmit(struct net_device *dev,
> >   			     int num_frames,
> >   			     struct xdp_frame **frames,
> > @@ -3885,7 +3933,7 @@ static int fec_enet_xdp_xmit(struct net_device
> *dev,
> >   	/* Avoid tx timeout as XDP shares the queue with kernel stack */
> >   	txq_trans_cond_update(nq);
> >   	for (i =3D 0; i < num_frames; i++) {
> > -		if (fec_enet_txq_xmit_frame(fep, txq, frames[i]) < 0)
> > +		if (fec_enet_txq_xmit_frame(fep, txq, frames[i], true) < 0)
> >   			break;
> >   		sent_frames++;
> >   	}


