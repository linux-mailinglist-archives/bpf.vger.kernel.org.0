Return-Path: <bpf+bounces-6784-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A59BA76DF31
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 05:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FCEA281F78
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 03:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9AAB8C1F;
	Thu,  3 Aug 2023 03:58:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9E41847;
	Thu,  3 Aug 2023 03:58:24 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2061.outbound.protection.outlook.com [40.107.104.61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E77128;
	Wed,  2 Aug 2023 20:58:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZgUhyWGPNpMT14yZuLp7JwUVYilyOrqEh3TuS50xbMVb2BwCpFMzdySMpMpZkobbyL42TuqBOOQlW8CZRtKTgkuuoK0yHK3dZBv+MTb/aEM92Gk6e3YIdFyEJjBGLcXIC1KNEHjmIoNpXzK3l5ykMfmksp/L1sPh9hw5faYmZqa15KZUesPHkInkev8QcbhYCSvh3qTzWEU0TnzC/1Nco1qmP0Y5LY3JRThk6slh88p3oanUY9so4xTPxLGpl96shqZQyLywXaEycL17oxaN1dYVsCXpF/JUWFTL9yKj+oVoTMUddQ8AWhXOKYbQFfOryGMUIrE8gVzoRjGCs0LX3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nrqJVcHJSbqFLZR+/ciqoNQG8RLPx2PAKQXb+oJdTEo=;
 b=klLPfhcCvZhisSu97bU/5gnUesJKlyjng4nCGG38Euj6DiHsvo+dhbDDvG+V0PocZBJuVLMlJ0HD8gVG6skmJ5ED60+PcC+9f8MoBlbXb22Z9Q5TKmBKNWgxROe/3HlBtsU9u/eOvXKkPZt0hL1hy3eHyaON29jpDvBKcgjCPY7nBSwpIj/iOIfIkYm0zAys8NYyFz+JkUgnReYv18PnOE+x7AWgmr/4D89bxNWekpXQTTgxUJ67fXAxM7bFeFiUJvc8V2Kpur1IXzWj3r0PLpTp36E5B4sAxFV5cQ44bee56fty+wme+PsuEYq7sQTuAIB5av3o38jouvHdLaOSqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrqJVcHJSbqFLZR+/ciqoNQG8RLPx2PAKQXb+oJdTEo=;
 b=EVdQWH6iPHih/TXoMod5Po+EZlB5ed6ghvnT5zc4kiq684KnTt49HmnKQz1tnO+cNXUl9RCDBNEttH+GqHLA/h/rLGEjWlBkgUVvKUyJo+Wfl4EFw2Hu7f7bSPEju18umkfSHcGEVfeW/jwNwhG4kWz4M0EUqoE36T0k6is0IRM=
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by PAXPR04MB8317.eurprd04.prod.outlook.com (2603:10a6:102:1ce::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Thu, 3 Aug
 2023 03:58:19 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e%4]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 03:58:19 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer
	<jbrouer@redhat.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>, Shenwei Wang
	<shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, "ast@kernel.org"
	<ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"hawk@kernel.org" <hawk@kernel.org>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [PATCH V3 net-next] net: fec: add XDP_TX feature support
Thread-Topic: [PATCH V3 net-next] net: fec: add XDP_TX feature support
Thread-Index: AQHZw3VFF5NSBizeREOxLxVc18wksa/XS8kAgACl6SA=
Date: Thu, 3 Aug 2023 03:58:19 +0000
Message-ID:
 <AM5PR04MB313985C61D92E183238809138808A@AM5PR04MB3139.eurprd04.prod.outlook.com>
References: <20230731060025.3117343-1-wei.fang@nxp.com>
 <20230802104706.5ce541e9@kernel.org>
In-Reply-To: <20230802104706.5ce541e9@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM5PR04MB3139:EE_|PAXPR04MB8317:EE_
x-ms-office365-filtering-correlation-id: eade88ed-d3f9-4df9-6d2c-08db93d5dfc0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Khg8VpHfYhYFX7ALVzyz3KY76ndhsgGHXQILAs8FY2vKYRnKrvH19jfZ+HPfHRuuIwOzxnTWuSIIFZ1B9J9vG8TDdmZPuN24Vg6vnz5CVTZoZCyvjqxxvbgWYdI/ioTdOVwhbr6mi0Kx9/9Iz1zhlqqWbdxju5oVyVTr13cmuXoYvR4+xSi17qI8q0cW7W232yZfsqGLAkDG3COTEK/H27GiEf0GMo9/dQ/ybEcstdxW7hTyh7DhFy2sCDE0qqv+wjI2XtFeZx1+23I9aofq7kjoA0Kwirv3TWGbVa14Jx4GRfCU6EqgOHHTOEE9IRBH0+n0r7X72Hnu1f1xoKT7xrqmlo3sYRdVv9LWBzcoGNkg715AHP59RO38prDUA6oCY1xTu4+irzDy5Th+qMJp6lTpMSeIMHqDJndVpKuGHUx1yZpoUHLTWZbEz0K6wHzWeopfSW60I5ucGhaNAuD5+7Pom0wxLexXDbfddU6RdeQvTOONaech6LK14En2llkejGy8SwJGslcRZg+RESBchKE7B4LeQ5WosXJuoqRSTQcwYmWfu/cfPkKxv9v8Cp4AjoDc2BzCrnEYC6qsrFCFB5cAaZ4RonEJ/Bh4fuiQE9fDow/om7jsz+aWuNR3nXbg
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(451199021)(41300700001)(316002)(4326008)(2906002)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(44832011)(52536014)(8676002)(8936002)(5660300002)(122000001)(38100700002)(33656002)(26005)(6506007)(186003)(38070700005)(86362001)(83380400001)(9686003)(478600001)(110136005)(54906003)(7696005)(71200400001)(55016003)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?42bzrSeLiUoruVkjiXu2G8yQEaSFZoxgpYW3JYT0gavdITW1/d72V5786oPW?=
 =?us-ascii?Q?jTWf5EZHbQFpTagGre36OmYs5CNuBCQcYAvZYzT3tbfPOskrpbgVBTduf7sT?=
 =?us-ascii?Q?n3ZjzZ1GMoggadqJQ/Qrq1XyKTcrIjRYZSMo3EuuqBr2kY2eXuBmWuUazGiu?=
 =?us-ascii?Q?HEfS/2l82jTaaUa3bC9BXOYEilBJJdJ9ptpQvglbqjlOPjfQZFd4qKgIEy7t?=
 =?us-ascii?Q?fpTRQ68pO+T0F4sT9bis2em++3iJtH2B6NZHrHEki73s7R0afsnJJSuVu16X?=
 =?us-ascii?Q?KEjJfY3QRiaBXlppCAYXob2I2cTgpQBzWraR+hAvKRHJmuXp71VQUmQiOtmn?=
 =?us-ascii?Q?a7iRmQtBx40AWSjBCImtTCwaUJ8VdUk2z2EnNgMReZiPMkqDb7axi25xftbl?=
 =?us-ascii?Q?mvzw9GnE5Z2MMEe/FVpIvQ2S2HPNmvLrpVn+hiD8lBdoShUlyigAiJuyJA/j?=
 =?us-ascii?Q?qNxXLu411ehPxDJPl0iHFw5csUHy2flyf7VJv4c3pEi3sLWX4gcy4KH1jlS2?=
 =?us-ascii?Q?bST/7yDFOc+894MAOpm16UIBzftecKth2gqf8QlUm/T7FlTXR7vGUm5ZUynI?=
 =?us-ascii?Q?9lVUB0YojaDykL7lS9FQGDffe1Kilz7wDpK0/jast/ZHAuQKgO54z5l2FxWE?=
 =?us-ascii?Q?QixUhVEEXDCThtAxQ4ooGSjQvu62Ju//iY0qGP6QYoylWS/mp/U5dNR1LS2O?=
 =?us-ascii?Q?Uz56wzVqyXdn48jW2DY9cImzd+qnaYwv0mkgHjyd6EsCVMH68N7odMYRGiAa?=
 =?us-ascii?Q?5ACyEN+ADdBoCS+3ImpEPMyLsLgOAGV74o082AHFSbHS7RmP3axTcsQ729rZ?=
 =?us-ascii?Q?KG32V0qFKNdz9zrH33p2kP4bdT1lJkIaLrn/biNcxCMymEcyFP1rSwJjdZKU?=
 =?us-ascii?Q?WDUNCOmbn9ECjcNyxS50tuDxYpJXpaquTvXekBfez+LjH5gZA0JcQCorCnwa?=
 =?us-ascii?Q?J0J2i/Q4bEhHuk1FQ9E4fUZG6lJCNHu6e8mS+Iut0VlGa4n/HxjxAoKaqoNq?=
 =?us-ascii?Q?0H/tjRP6mIziMszTlyODzLfbzgeSKyjidv6T0RZWESVm2jsmiExH57zJAZ1v?=
 =?us-ascii?Q?/OrOiHfeJOSb448VCTsaAqdbMZHHkW3AVI+LokxYQ2JZNn5VVCpGq+z5QT1T?=
 =?us-ascii?Q?tcBribzQSF9G+/eqRD2hK1C0P9DZ1b2Z/3MHnr2ST74ko9CMPd1arqdoclsv?=
 =?us-ascii?Q?XAhsmVjZ05vi8M1ouu8t3aC9KeSv+zFPLyv6PnfSevTxwVWSmJqmzMv3YEM+?=
 =?us-ascii?Q?La20RV6clAquSGm2ciJL78pCND6ecrlPViA7f9hIQEfpdqQE7+Go5sUll9Ra?=
 =?us-ascii?Q?vLwwRMb42qQBzJbbNgJNFwVQ0py+2rqp3cIjV5J70eHMonZK5nMHdwuCgIJK?=
 =?us-ascii?Q?LmTEUEYI89ECPMES5Y7U//sj11Qb/Qwpdrh6mMs17qlGYRj32MN2wlO7gJeN?=
 =?us-ascii?Q?I6qO7HJm+ooxgnXVvxLXKREJgwLmGLmWkF7ez6c3qDr7AamavWXY26pSIb1n?=
 =?us-ascii?Q?bILhvMJAqnA1As7nvbU81UZZEAxbPHpXyDnFQTRIqbf7IVmV2lx7DrXB1XkJ?=
 =?us-ascii?Q?0rSpxyw4vrhen9wbCzo=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: eade88ed-d3f9-4df9-6d2c-08db93d5dfc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 03:58:19.3840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5xi0BhvUmoqLrMxJc085UB81zgAcraVZarr8/HJ1Pi+Fh8ziic3+z9QgtCZgjx0/sZzzJCp9ZW9/xxUKul06Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8317
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> >  		} else {
> > -			xdp_return_frame(xdpf);
> > +			xdp_return_frame_rx_napi(xdpf);
>=20
> If you implement Jesper's syncing suggestions, I think you can use
>=20
> 	page_pool_put_page(pool, page, 0, true);
>=20
> for XDP_TX here to avoid the DMA sync on page recycle.

I tried Jasper's syncing suggestion and used page_pool_put_page() to recycl=
e
pages, but the results does not seem to improve the performance of XDP_TX,
it even degrades the speed.=20

The result of the current modification.
root@imx8mpevk:~# ./xdp2 eth0
proto 17:     260180 pkt/s
proto 17:     260373 pkt/s
proto 17:     260363 pkt/s
proto 17:     259036 pkt/s
proto 17:     260180 pkt/s
proto 17:     260048 pkt/s
proto 17:     260029 pkt/s
proto 17:     260133 pkt/s
proto 17:     260021 pkt/s
proto 17:     260203 pkt/s
proto 17:     260293 pkt/s
proto 17:     259418 pkt/s

After using the sync suggestion, the result shows as follow.
root@imx8mpevk:~# ./xdp2 eth0
proto 17:     255956 pkt/s
proto 17:     255841 pkt/s
proto 17:     255835 pkt/s
proto 17:     255381 pkt/s
proto 17:     255736 pkt/s
proto 17:     255779 pkt/s
proto 17:     254135 pkt/s
proto 17:     255584 pkt/s
proto 17:     255855 pkt/s
proto 17:     255664 pkt/s

Below are my changes, I don't know what cause it. Based on the results,
it's better to keep the current modification.

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethern=
et/freescale/fec_main.c
index d5fda24a4c52..415c0cb83f84 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -77,7 +77,8 @@
 static void set_multicast_list(struct net_device *ndev);
 static void fec_enet_itr_coal_set(struct net_device *ndev);
 static int fec_enet_xdp_tx_xmit(struct net_device *ndev,
-                               struct xdp_buff *xdp);
+                               struct xdp_buff *xdp,
+                               u32 dma_sync_len);

 #define DRIVER_NAME    "fec"

@@ -1487,7 +1488,14 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue=
_id, int budget)
                        /* Free the sk buffer associated with this last tra=
nsmit */
                        dev_kfree_skb_any(skb);
                } else {
-                       xdp_return_frame_rx_napi(xdpf);
+                       if (txq->tx_buf[index].type =3D=3D FEC_TXBUF_T_XDP_=
NDO)
+                               xdp_return_frame_rx_napi(xdpf);
+                       else {
+                               struct page *page;
+
+                               page =3D virt_to_head_page(xdpf->data);
+                               page_pool_put_page(page->pp, page, 0, true)=
;
+                       }

                        txq->tx_buf[index].xdp =3D NULL;
                        /* restore default tx buffer type: FEC_TXBUF_T_SKB =
*/
@@ -1557,7 +1565,8 @@ fec_enet_run_xdp(struct fec_enet_private *fep, struct=
 bpf_prog *prog,
        act =3D bpf_prog_run_xdp(prog, xdp);

        /* Due xdp_adjust_tail: DMA sync for_device cover max len CPU touch=
 */
-       sync =3D xdp->data_end - xdp->data_hard_start - FEC_ENET_XDP_HEADRO=
OM;
+       sync =3D xdp->data_end - xdp->data;
        sync =3D max(sync, len);

        switch (act) {
@@ -1579,7 +1588,7 @@ fec_enet_run_xdp(struct fec_enet_private *fep, struct=
 bpf_prog *prog,
                break;

        case XDP_TX:
-               err =3D fec_enet_xdp_tx_xmit(fep->netdev, xdp);
+               err =3D fec_enet_xdp_tx_xmit(fep->netdev, xdp, sync);
                if (unlikely(err)) {
                        ret =3D FEC_ENET_XDP_CONSUMED;
                        page =3D virt_to_head_page(xdp->data);
@@ -3807,6 +3816,7 @@ fec_enet_xdp_get_tx_queue(struct fec_enet_private *fe=
p, int index)
 static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
                                   struct fec_enet_priv_tx_q *txq,
                                   struct xdp_frame *frame,
+                                  u32 dma_sync_len,
                                   bool ndo_xmit)
 {
        unsigned int index, status, estatus;
@@ -3840,7 +3850,7 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_pr=
ivate *fep,
                dma_addr =3D page_pool_get_dma_addr(page) + sizeof(*frame) =
+
                           frame->headroom;
                dma_sync_single_for_device(&fep->pdev->dev, dma_addr,
-                                          frame->len, DMA_BIDIRECTIONAL);
+                                          dma_sync_len, DMA_BIDIRECTIONAL)=
;
                txq->tx_buf[index].type =3D FEC_TXBUF_T_XDP_TX;
        }

@@ -3889,7 +3899,8 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_pr=
ivate *fep,
 }

 static int fec_enet_xdp_tx_xmit(struct net_device *ndev,
-                               struct xdp_buff *xdp)
+                               struct xdp_buff *xdp,
+                               u32 dma_sync_len)
 {
        struct xdp_frame *xdpf =3D xdp_convert_buff_to_frame(xdp);
        struct fec_enet_private *fep =3D netdev_priv(ndev);
@@ -3909,7 +3920,7 @@ static int fec_enet_xdp_tx_xmit(struct net_device *nd=
ev,

        /* Avoid tx timeout as XDP shares the queue with kernel stack */
        txq_trans_cond_update(nq);
-       ret =3D fec_enet_txq_xmit_frame(fep, txq, xdpf, false);
+       ret =3D fec_enet_txq_xmit_frame(fep, txq, xdpf, dma_sync_len, false=
);

        __netif_tx_unlock(nq);

@@ -3938,7 +3949,7 @@ static int fec_enet_xdp_xmit(struct net_device *dev,
        /* Avoid tx timeout as XDP shares the queue with kernel stack */
        txq_trans_cond_update(nq);
        for (i =3D 0; i < num_frames; i++) {
-               if (fec_enet_txq_xmit_frame(fep, txq, frames[i], true) < 0)
+               if (fec_enet_txq_xmit_frame(fep, txq, frames[i], 0, true) <=
 0)
                        break;
                sent_frames++;
        }

