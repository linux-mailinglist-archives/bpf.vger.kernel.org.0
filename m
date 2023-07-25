Return-Path: <bpf+bounces-5786-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD947604F5
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 03:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 848732816EC
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 01:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A15C187B;
	Tue, 25 Jul 2023 01:59:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEE17C;
	Tue, 25 Jul 2023 01:59:00 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2070.outbound.protection.outlook.com [40.107.15.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C86C10EF;
	Mon, 24 Jul 2023 18:58:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MMTJJK5YUvlkHlvey6YUhdt7B6QGl8ejy8zuaU55bNxiH5nBwMgTbUdjd/t0aJyG88eS19SpaUOTQF5IvyAj9SbNz2xaqSc4/TRA4qwiLN8MST1ogU/9Gjz5Jz/HvYLBrpRVxf/jc+bNnTcfQHjpJgqvkeimLjV5zPGw5a/FuSZbLIbMOpN9I3Y+fa71sV7Y9JhYjQl9/ivXn/MqJXKz9rXxQlcdqs/6jF/2rQuZoxoX8e/lZJ3/viMGT0itz1FIWrqBH0wnzz8CJobB+yi6LvfYxUBLHBnovrAJEKnVQlfjXTTM4fpH8ENVdQs1m0RsW1mxDlT9ztZ7QEbYWphYmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X5RVhpUDhHjLcAN/omb2co52hX+ucgslwjq3TJlREyU=;
 b=ZvcPiqjEeoU8TUXOpKuwezd1qTqK82NC5h6hLKRChkrb2VaXmU+kRdJeZmCB+k/2OtvIzTx1iSeSCPzK40/VqZEqD38QkkqUZP3M7xLCrqN++EZ4OerB05hBDUgYrc9JcXPCOL/zEEqh/nA9wYtrjF5SgbHn3NFfvI0AlSkVa4G4cTzE8bJBBcsN9SoYM9iqdiB8cCJHji78PF1O1NTvTtiYs+AAyPx/g+8sfZDYhG2u0SPFnIA0h0Xm8cUzL+NH8LgoQXfXTaTFCRWD7QERp4JmZsb64eNEnEFsY+6k+6hrhZG8S4PBEf7yC9rJ+DEsY6VdPupHRa5WDPCPmpY6Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5RVhpUDhHjLcAN/omb2co52hX+ucgslwjq3TJlREyU=;
 b=SBCDwSW9raARNe5SovTKqsDeKT4VYN6S5Ku4eXwd+mrHEBYgtm3gnxJHOP5yIJY0dS9eBK8v4oFpSa6PwS+GlLgFtADSAU3H+tKOrdw2J68dn/K8UCc7kkG9iQxD4FdIvjAEFqWjCPaTYrMAIqEgQNwQCLVKDuCwsFBN+qpyWX0=
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by AM8PR04MB7459.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Tue, 25 Jul
 2023 01:58:57 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e%4]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 01:58:56 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>, Shenwei Wang
	<shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, "ast@kernel.org"
	<ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"hawk@kernel.org" <hawk@kernel.org>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [PATCH V2 net-next] net: fec: add XDP_TX feature support
Thread-Topic: [PATCH V2 net-next] net: fec: add XDP_TX feature support
Thread-Index: AQHZu5ybOg7SzSs11UO7ZvJlDvllLa/JnG+AgAAeEuA=
Date: Tue, 25 Jul 2023 01:58:56 +0000
Message-ID:
 <AM5PR04MB313905A73DB27CE3741E18E78803A@AM5PR04MB3139.eurprd04.prod.outlook.com>
References: <20230721062153.2769871-1-wei.fang@nxp.com>
 <20230724165157.7094468a@kernel.org>
In-Reply-To: <20230724165157.7094468a@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM5PR04MB3139:EE_|AM8PR04MB7459:EE_
x-ms-office365-filtering-correlation-id: 1d42dfbe-0671-4828-65f2-08db8cb2b485
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 5XGoFU27LdwSnMPC8SAGYk/5XyuTuTglR7MkTiiASar34mz5sppViQRwsaoBgED2pFDtXe1XV8QCzzcGeeR3xx0FChWQsn+QP4kkvfe6vW5ziomp2zPCiVQYaPPyoa1XbVLPqkZkpmE16r0fXgu8RPiwEdcvmSAPsVrXFUfbsgGdw0WoXZ5US4jdzzarj0o8tcceR6aNQrhiHUh7sRboOqpplHcauETr4kgrVKlbmCMhoZzoscyKZuJJtBnbGEsUaTE9CB6Zr+lkKZZpih8J1xRdkRsq+mja2rWYf4RBCbYldzwgu/BcrIFaqMCCpcSxytIh6R06vefKkIJzUqimVU40LEtc1OQm+Y5Riz6cxPrQIREpxspnCzxTDN1C1qRARiqTnixyfNbRkMu9qE6hfZieYPmgPqZwRmGNCTMnPj+pDQG7Kb2SJD4YCuK7lEdNSnmRXf3uOOc5UCzV6fNg7rAoCwoDR3VAyS9t/XBuM9j0bgm10df3TfiNs6fVK33gAqc+X2QgE5U72CeB1HbfCH9etxyj+5scigyfKS+0onky9IChdbcEb26q2/w/fhxhKSc5qSckUysSmbefwEBhAN0kDgGO1ZgyiiiMZru9/iixXd9SGL3AA7s3sVm7lzev
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(451199021)(186003)(26005)(6506007)(52536014)(44832011)(5660300002)(8676002)(8936002)(7416002)(2906002)(122000001)(86362001)(55016003)(38100700002)(6916009)(4326008)(316002)(76116006)(33656002)(66476007)(38070700005)(66946007)(66556008)(64756008)(66446008)(478600001)(7696005)(9686003)(41300700001)(71200400001)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PIZs3z6h67yzIopnyinQ6e6ql7veDA4mGeM5gNWYDF8cLU0BsFk9BRzAysTY?=
 =?us-ascii?Q?NVPgkgYF0SS7EhyaKn17n/sgwCD2xlLdSKhK5n5g7IbQfuA3GdCFHjaYFkEW?=
 =?us-ascii?Q?qQn2/O2Mgk37+8hk9nacQVqmb6Fe09t4FLQ/GSUH5grcPsny5UxBd742s9p5?=
 =?us-ascii?Q?L6VBsPRpTM2C01NfXVxVfPAZ9UauVnlTogmc4sshg+oH7sjRd3a69Tjrda4X?=
 =?us-ascii?Q?c0p0n4RqAsKcsLGJ7KugvwXQAt69Vm2bS2MTDRI74WQW+gSKjQMiQeA5V8tH?=
 =?us-ascii?Q?OpUvRC7ZwQscx4Tbwil3OGcaYPYq8KJvUcczs+qPQKtLWsXowehbISm5iEy2?=
 =?us-ascii?Q?8P1Irn3gCa+N7DKHMLCXCRbiLbG8Gt5IK2cZxKXzXXezeenzRpAVV38LhN9v?=
 =?us-ascii?Q?vA/aY26qkXERGeNMkiMnh7O77S3MWo93mRn/5xszhX6tOc5tX1fRO/pN+DX2?=
 =?us-ascii?Q?C1Wd6DZeq7r+JzaTqheTM+ncwT8PzJRw2Ru4lWfx+INHWcqCijUJOcfl7UH3?=
 =?us-ascii?Q?6M98hDEFqSFny4ZzbPkWVU22HsmVWRosE9g+p/2n86Pt7DorA8tnCPn963/U?=
 =?us-ascii?Q?i1sFhsupFp5AyeBdCh9wsxDgqI4EgUPX8AWaApQhw/s6UmNkHZU1hzMNqIQ4?=
 =?us-ascii?Q?xNE0VdvpGIJVxQyHeNBPwJFHdGFC7OCjVcf8u8ZyJfQLQ4bDg/UFAJzP/p8/?=
 =?us-ascii?Q?V2hjbJUPcpj5K6TlE7rgCDtUGX0M9kxg6M4ZOo2vrVttyGglNbc3JtIDuY+H?=
 =?us-ascii?Q?Ld+ayyYEhE0/I1y6+dGt8UzFxBt1oesTarKhrbEkEOAloEliW7qicnBBT52m?=
 =?us-ascii?Q?Sa7oCrMDBSbWmMAG2MfEkyozfyjxsR48QeTvqOurWkxCqOQjHOQoKnc+ZjMI?=
 =?us-ascii?Q?OnJEQNlRgH9uv4ahoCqxcoBD1Mfk7Jsr0rY6qtFxk5YBFzlZ6T06K8NpmdYV?=
 =?us-ascii?Q?t0m5CdQTeLW33NIwtkAaaBt413AuSSDwMFgElhGYHnQ2/YnAouHS0OXJzjr/?=
 =?us-ascii?Q?2qMbO9bgvDGftFvYrTNFYnE1aTtqQayXrh3I7cJaJueCKkViI3P6Nj51hZcJ?=
 =?us-ascii?Q?SKrSNtwt4DAHvsuhE6kIuj0mVQ+Qy7dOlOaYp99kSZJYImU6+8plws4fvkzo?=
 =?us-ascii?Q?UGR513Und50678gv+rP8o5kLq/SJLeEK/iFLnIJGAFHaikyR4hUTFvgdfM0z?=
 =?us-ascii?Q?ZljYQxWNg6xEufdv+Hc0y+95nRKnL/1gy5dokfzIGmBH6G56E99FDsbBSO/0?=
 =?us-ascii?Q?SRpnkCq+kU0oGouJf1xMqINAY5N9q3H1dpAxn9yD7tFGvcwyKUOTh/oE+7Yi?=
 =?us-ascii?Q?5zc/qzPcdkXrbOagerlORx2vpoPIehVhsP+5Tm0v4tDN/taCAKNh0BAdrJSZ?=
 =?us-ascii?Q?AqkNzppQVf93ujatsHFsZG27Umkf/XY/4ZpiWb2QEMKXZDOIwTQQHmGM0Pj7?=
 =?us-ascii?Q?jdAl9ARPkwyeHuTGxjGKNkA9G3A4OHuRI9D9DAH5GZ84P8xIXNtUXpf/a0Go?=
 =?us-ascii?Q?nJ000QE/PNtVP37k6YltA2PyBMvrTGOJcO8TMKp9G04ONbVN1NAIzml9v5rE?=
 =?us-ascii?Q?u/l+WBMyoZ5bqkkfyJU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d42dfbe-0671-4828-65f2-08db8cb2b485
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2023 01:58:56.3278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xn9J/0NrdYpN3NNiIytI+tOv2eIcSPuVajpAmX2aSNZhMhZtwSqSMg66bCfXvYCSIfs+SnK/Wug1JMVVQDJ/Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7459
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> On Fri, 21 Jul 2023 14:21:53 +0800 Wei Fang wrote:
> > +			/* Tx processing cannot call any XDP (or page pool) APIs if
> > +			 * the "budget" is 0. Because NAPI is called with budget of
> > +			 * 0 (such as netpoll) indicates we may be in an IRQ context,
> > +			 * however, we can't use the page pool from IRQ context.
> > +			 */
> > +			if (unlikely(!budget))
> > +				break;
> > +
> >  			xdpf =3D txq->tx_buf[index].xdp;
> > -			if (bdp->cbd_bufaddr)
> > +			if (bdp->cbd_bufaddr &&
> > +			    txq->tx_buf[index].type =3D=3D FEC_TXBUF_T_XDP_NDO)
> >  				dma_unmap_single(&fep->pdev->dev,
> >  						 fec32_to_cpu(bdp->cbd_bufaddr),
> >  						 fec16_to_cpu(bdp->cbd_datlen), @@ -1474,7
> +1486,10 @@
> > fec_enet_tx_queue(struct net_device *ndev, u16 queue_id)
> >  			/* Free the sk buffer associated with this last transmit */
> >  			dev_kfree_skb_any(skb);
> >  		} else {
> > -			xdp_return_frame(xdpf);
> > +			if (txq->tx_buf[index].type =3D=3D FEC_TXBUF_T_XDP_NDO)
> > +				xdp_return_frame(xdpf);
> > +			else
> > +				xdp_return_frame_rx_napi(xdpf);
>=20
> I think that you need to also break if (!budget) here,
I think there is no need to break again here, because if the "budget" is 0,=
 the code logic
will no jump here.

> xdp_return_frame() may call page pool APIs to return the frame to a page =
pool
> owned by another driver. And that needs to be fixed in net/main already?
Yes, you are right, I should fixed it in net tree first, and when the fix i=
s merged
into net-next tree, I will send a 3rd version of this patch.

