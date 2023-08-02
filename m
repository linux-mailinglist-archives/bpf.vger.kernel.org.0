Return-Path: <bpf+bounces-6693-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F55F76CA37
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 12:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E3D31C211E1
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 10:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD9B63CB;
	Wed,  2 Aug 2023 10:00:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D922463B6;
	Wed,  2 Aug 2023 10:00:10 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on0630.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0c::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4B23C0B;
	Wed,  2 Aug 2023 02:59:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KeDEpvdRtuXZm8WgmDfCiIIBYXY+KPE9Zo+D7vKjSqa8xcXwWrEc1Sed8dDCHgBGiz4MMdvQwz1wTj/QMWdMC/rnYkSbNCMkkTHWRqPkFj9SWY22gtOkMN6apIkPFxQJtZDxVLhzJdfBN5UpWcbzwvAKu40hZjVgClJon93V+ikXFmsc8siFpERBUQCeoBSQcXVndFCy/4FMn6huNV9gkw/AhhwB1pNg3F40mQS+15rEewVVFbZRs23RibSiPZNtrCeM71oJlhSOKpG1/3n4IyP/8DifAwX7Kbx09Q6ACFrESZWKVzx0EonjI+eJu8uJaxY+PoH49pDkbW3UNq1bfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T5eNl1vL5jtETytTH5w63uQRJEjE7o89BvUjU7wVa+c=;
 b=KR0wfdfSRG7l7G0IPZMCZmREX5TfaXETNegoTotdWuIClLChx+cHNB1VaxlNi/mHqL/iL91mejJaKblnF943VHR1g9lqp9chUI5rf+MJCgcwHZ/CqoahoCnmO0BJOI31apCj5yRpQibvwBjO/7AVB7E2+GtNHfCDmFhiDSuQCV4yeAXvZnNN4NThg1Oa2uFTqXRQ+vGAI0gaHcYACEWZlKHDiGi0sDByIt6wPIoIjqiKbzxSQ08KdiYv/yniiaOWDTGpjzv9zgdcEkWXqyFJOSOd5yC50N7cOgMKRotGeeLQrXhYgs9s8K0BK6ASPaIfHuU+vmWTxECpuoTTjn9osg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5eNl1vL5jtETytTH5w63uQRJEjE7o89BvUjU7wVa+c=;
 b=Mhu/jgVnLtSjbHLfJPb1lSWbqHVJVABKj6+tDn06vnMCntt0yWE60Ex7qMIuiOO1pzmtA57p97Zk1obaJjzNcnmMFn+8lYbEhVFK3INvPsSgua12Av77mmNrCCZrR7HTnuXk+BHUQrLaRMIDg3pk35Ck4RH+Y3ZmQtazGT2/oxg=
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by AM9PR04MB8828.eurprd04.prod.outlook.com (2603:10a6:20b:40b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19; Wed, 2 Aug
 2023 09:59:14 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e%4]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 09:59:14 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Jesper Dangaard Brouer <jbrouer@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, "hawk@kernel.org" <hawk@kernel.org>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "brouer@redhat.com" <brouer@redhat.com>, dl-linux-imx <linux-imx@nxp.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>
Subject: RE: [PATCH V3 net-next] net: fec: add XDP_TX feature support
Thread-Topic: [PATCH V3 net-next] net: fec: add XDP_TX feature support
Thread-Index: AQHZw3VFF5NSBizeREOxLxVc18wksa/WwA6AgAAHZ4A=
Date: Wed, 2 Aug 2023 09:59:14 +0000
Message-ID:
 <AM5PR04MB31394F01926FB20F95262E0A880BA@AM5PR04MB3139.eurprd04.prod.outlook.com>
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
x-ms-traffictypediagnostic: AM5PR04MB3139:EE_|AM9PR04MB8828:EE_
x-ms-office365-filtering-correlation-id: e8ed27eb-872b-4e82-d1e4-08db933f2095
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 lcXt0eqQ1COR05sEjEfI6N3jItDOPFs2KuPIIfW+hzy6eqWmH0sx0uKoBxFyYuD8Vk8AG2SeXoh/dMHXsizeL95mCfHDZ//CGiRxI2NBPf+SkbIamTmPwDiLsvZLDw79nC7rVny8ZRKmqzTWfcekj8Fq3fq7ZsxbWasUFYRKRTvzA+uV3ZXgq00Y3Io6Ss5LYGZrU4b4mw/G3+hVcvCrvCikyPzAzEDmihJcDhoixN5+DW3mD+KqMNjUiCoQzuElrSE+vl41aTe9HkDloehOe9EKgx2beUpB0Xh72/hGUdPMNA2VHKFMwzS7FF2HnwifQeWyliOju7o8/Ii/pYPdnB2E5PGMqremXGMEIVny591EQhIpWsHPmoEafMAlRqM+9eVfPw28lHUjPcTTRQ6Dwhd1CouRAo84BP0FTbQWRBsqW8VQVOfr37ZLVmAev8o6SGCU7Gz8A3XV5qG2h8zonILlIi7+wlefY7Vx8SOsmZBxYNYU6YLBV6E5V6RuDfsVWA/G8bigqucc2jIdOWJtjq7uiPt0mmH6GIKBd4yePdG9Q6gQ2GESmD1fyHtPU0k6S6Id3glO3lPpTYZh38pYByvyi84y4hPToR9Seyf68yfiPzGoEc8wV4hEMW3eRw8d
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(451199021)(30864003)(45080400002)(33656002)(478600001)(86362001)(9686003)(966005)(71200400001)(7696005)(316002)(8676002)(8936002)(41300700001)(5660300002)(4326008)(44832011)(66446008)(66556008)(66476007)(64756008)(52536014)(83380400001)(7416002)(55016003)(110136005)(54906003)(76116006)(2906002)(38100700002)(66946007)(26005)(38070700005)(122000001)(921005)(186003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?xyFaGHVhT9SWy0fp3fSn7N6JVu2Pzfmks7qvvzqLqTHx6sfzJLG5RmK9vQvZ?=
 =?us-ascii?Q?8BCF6+0h4WoBB7JfWRKPBnV61CfdROyH+G34wb0RdnW6fw4Jw3myBW/WRUv1?=
 =?us-ascii?Q?FMQ/oiyiYML4PVshzdhgkh6UTW7YSJ8QPtUX354b0bXxuSsEOd2O53e1R6PS?=
 =?us-ascii?Q?6txymc1W2fEKp02UFhn5QUQjBtVoOn8nRZR7nHnvktYcRSLYR6+F2HdFBkvW?=
 =?us-ascii?Q?TJ75OfdaEIB6D3oflHFfrR+Fpwby0InyFeOAty2i3+Qgtp+wzoQc3KEnJ0zp?=
 =?us-ascii?Q?wH3e9pj8f68xzmyEznK1UDvvIDd0RcXcgwWHX/QwPsPC1+QxdZC8j+YQ4OWv?=
 =?us-ascii?Q?/j7+TtJK29CdRaMH0QQTbCeJmqhtPkC0sgcmWch/EXdT4SyQAw5DJON5GR+m?=
 =?us-ascii?Q?gY2p7TCa6YwWc+fwxzVn15qONtxl16kMUmYejD4wxPKrvSrlo5LJiB52lfOS?=
 =?us-ascii?Q?cz/7EticgpLON5eYUokeGDpvSn6ggxQxMQQS6dgap55dlTVMU4Z/puQHLoBF?=
 =?us-ascii?Q?9pwSn8rXDuk5XGVr4wYXLwSb5opI5TMOlhaKgBAlFCZwKIKI/XD5joXZDhA+?=
 =?us-ascii?Q?4dHUwGVPIHyWMDft49aT/o8Q7XfJU3g90iXabgArJGqZoXwPJiRHZvrVZyqn?=
 =?us-ascii?Q?vZe9Do5UIxktxuHi32tptUNQf/UTm2H6yJqUF+Fvj3fbiq2RVfT6B4mk6OcB?=
 =?us-ascii?Q?I1KrCIOhXizuDuLksDzB7CCsK6Y4KlXKuI9rrMy/BX92wNpHQRZELDNE4PWs?=
 =?us-ascii?Q?qPpUFogaQaypQ9nLyqPbaSXNdzdxWm8O17OGMkc6Jdj44B2pXxjdHY6jX0dT?=
 =?us-ascii?Q?+lX5oNQ/5yrxzbD6lZpdWsl07f5L9u2e8fa15kolpyOi3dRdQ5aKWvJ+rRgk?=
 =?us-ascii?Q?ppIEJDLIXUi/tZrAvH8vlh2S2kXxafbT/QUctcAJs4YcWWXMI4D5h9a1zi8S?=
 =?us-ascii?Q?qBjfJzvI6K2aexcvHY7FU8MxF392bSOPW5XULiBgWER8kL4ARMxEibC25Gth?=
 =?us-ascii?Q?Zp2SVTyaw9JQLlBKS9iZnOYKHsUxvtzJaYXnlnhe9byoyZo5i9VsdAYIR4Qd?=
 =?us-ascii?Q?fHxxDWczbzM/WJvw5cItQygDQCQtk8m95U96y7LSBNS8eKGe1F+RC7V4lsAs?=
 =?us-ascii?Q?8NBLd8VH9IdDmG/ehj96ENCqUDm1hxVAVt6P9PwwgJK/x5Np53LatWueS+s1?=
 =?us-ascii?Q?4oy6BPF6kwxhHc9FStXZtYz6d6TtfhCFFU0ZIARmSMpE7OFHr2PxbTdSi+Gc?=
 =?us-ascii?Q?5i2w4Bh22ilPUuLTsPT6ep/LPjDQ8WzZmHz4f7neGY0hlxU4Ask25iLUIx4o?=
 =?us-ascii?Q?+59lyKCKBRbFXGtG/ZlxstHFPWVYg8Zem+z/PSo5U1hWwj0u9bjsDzhP7JQV?=
 =?us-ascii?Q?nCmOkpSIjcKCwxSNrzdeJPAMhDDW5bw5/yZu5t7CfnclTtAiV99I0Xaxg0A5?=
 =?us-ascii?Q?vvpFaT7Us5HoDPFu1r2o2KCcEGaFMjWUJuPVygeLtT9dg3gEQnAGPiPij5aR?=
 =?us-ascii?Q?cTJhMUYOI2CsnyPkWctc578fF71YWFG8Uo5rV+LFfQK0XXj4+yQqdoV2Qn3a?=
 =?us-ascii?Q?KXszIoJExKCMxM+UhyQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e8ed27eb-872b-4e82-d1e4-08db933f2095
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 09:59:14.1730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JYcasbOmAEQLs4/fOzcepKYBHkOGW9pDqHdQ+43Rikd29BfR6DwlxDDQe3HA6uoJoYUFHV0L3sL7TLP/i5UvOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8828
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
	T_SPF_PERMERROR,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

>
> On 31/07/2023 08.00, Wei Fang wrote:
> > The XDP_TX feature is not supported before, and all the frames
> > which are deemed to do XDP_TX action actually do the XDP_DROP
> > action. So this patch adds the XDP_TX support to FEC driver.
> >
> > I tested the performance of XDP_TX feature in XDP_DRV and XDP_SKB
> > modes on i.MX8MM-EVK and i.MX8MP-EVK platforms respectively, and
> > the test steps and results are as follows.
> >
> > Step 1: Board A connects to the FEC port of the DUT and runs the
> > pktgen_sample03_burst_single_flow.sh script to generate and send
> > burst traffic to DUT. Note that the length of packet was set to
> > 64 bytes and the procotol of packet was UDP in my test scenario.
> >
> > Step 2: The DUT runs the xdp2 program to transmit received UDP
> > packets back out on the same port where they were received.
> >
>
> Below test result runs should have some more explaination, please.
> (more inline code comments below)
>
> > root@imx8mmevk:~# ./xdp2 eth0
> > proto 17:     150326 pkt/s
> > proto 17:     141920 pkt/s
> > proto 17:     147338 pkt/s
> > proto 17:     140783 pkt/s
> > proto 17:     150400 pkt/s
> > proto 17:     134651 pkt/s
> > proto 17:     134676 pkt/s
> > proto 17:     134959 pkt/s
> > proto 17:     148152 pkt/s
> > proto 17:     149885 pkt/s
> >
> > root@imx8mmevk:~# ./xdp2 -S eth0
> > proto 17:     131094 pkt/s
> > proto 17:     134691 pkt/s
> > proto 17:     138930 pkt/s
> > proto 17:     129347 pkt/s
> > proto 17:     133050 pkt/s
> > proto 17:     132932 pkt/s
> > proto 17:     136628 pkt/s
> > proto 17:     132964 pkt/s
> > proto 17:     131265 pkt/s
> > proto 17:     135794 pkt/s
> >
> > root@imx8mpevk:~# ./xdp2 eth0
> > proto 17:     135817 pkt/s
> > proto 17:     142776 pkt/s
> > proto 17:     142237 pkt/s
> > proto 17:     135673 pkt/s
> > proto 17:     139508 pkt/s
> > proto 17:     147340 pkt/s
> > proto 17:     133329 pkt/s
> > proto 17:     141171 pkt/s
> > proto 17:     146917 pkt/s
> > proto 17:     135488 pkt/s
> >
> > root@imx8mpevk:~# ./xdp2 -S eth0
> > proto 17:     133150 pkt/s
> > proto 17:     133127 pkt/s
> > proto 17:     133538 pkt/s
> > proto 17:     133094 pkt/s
> > proto 17:     133690 pkt/s
> > proto 17:     133199 pkt/s
> > proto 17:     133905 pkt/s
> > proto 17:     132908 pkt/s
> > proto 17:     133292 pkt/s
> > proto 17:     133511 pkt/s
> >
>
> For this driver, I would like to see a benchmark comparison between
> XDP_TX and XDP_REDIRECT.
>
Okay, I'll do a comparison test.

> As below code does could create a situation where XDP_REDIRECT is just
> as fast as XDP_TX.  (Note, that I expect XDP_TX to be faster than
> XDP_REDIRECT.)
>
Could you explain why you expect XDP_TX should be faster than XDP_REDIRECT?
What's the problem if XDP_TX is as fast ad XDP_REDIRECT?

> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > ---
> > V2 changes:
> > According to Jakub's comments, the V2 patch adds two changes.
> > 1. Call txq_trans_cond_update() in fec_enet_xdp_tx_xmit() to avoid
> > tx timeout as XDP shares the queues with kernel stack.
> > 2. Tx processing shouldn't call any XDP (or page pool) APIs if the
> > "budget" is 0.
> >
> > V3 changes:
> > 1. Remove the second change in V2, because this change has been
> > separated into another patch and it has been submmitted to the
> > upstream [1].
> > [1]
> https://lore.k/
> ernel.org%2Fr%2F20230725074148.2936402-1-wei.fang%40nxp.com&data=3D
> 05%7C01%7Cwei.fang%40nxp.com%7C9a2fc5bab84947e4bea608db933aa5
> e9%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638265652320
> 018962%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV
> 2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3Dwc
> xe8nBeLS9uQrbphuNI18owgDNHJq9478V53KybWB8%3D&reserved=3D0
> > ---
> >   drivers/net/ethernet/freescale/fec.h      |  1 +
> >   drivers/net/ethernet/freescale/fec_main.c | 80
> ++++++++++++++++++-----
> >   2 files changed, 65 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/freescale/fec.h
> b/drivers/net/ethernet/freescale/fec.h
> > index 8f1edcca96c4..f35445bddc7a 100644
> > --- a/drivers/net/ethernet/freescale/fec.h
> > +++ b/drivers/net/ethernet/freescale/fec.h
> > @@ -547,6 +547,7 @@ enum {
> >   enum fec_txbuf_type {
> >     FEC_TXBUF_T_SKB,
> >     FEC_TXBUF_T_XDP_NDO,
> > +   FEC_TXBUF_T_XDP_TX,
> >   };
> >
> >   struct fec_tx_buffer {
> > diff --git a/drivers/net/ethernet/freescale/fec_main.c
> b/drivers/net/ethernet/freescale/fec_main.c
> > index 14d0dc7ba3c9..2068fe95504e 100644
> > --- a/drivers/net/ethernet/freescale/fec_main.c
> > +++ b/drivers/net/ethernet/freescale/fec_main.c
> > @@ -75,6 +75,8 @@
> >
> >   static void set_multicast_list(struct net_device *ndev);
> >   static void fec_enet_itr_coal_set(struct net_device *ndev);
> > +static int fec_enet_xdp_tx_xmit(struct net_device *ndev,
> > +                           struct xdp_buff *xdp);
> >
> >   #define DRIVER_NAME       "fec"
> >
> > @@ -960,7 +962,8 @@ static void fec_enet_bd_init(struct net_device
> *dev)
> >                                     txq->tx_buf[i].skb =3D NULL;
> >                             }
> >                     } else {
> > -                           if (bdp->cbd_bufaddr)
> > +                           if (bdp->cbd_bufaddr &&
> > +                               txq->tx_buf[i].type =3D=3D FEC_TXBUF_T_=
XDP_NDO)
> >                                     dma_unmap_single(&fep->pdev->dev,
> >                                                      fec32_to_cpu(bdp->=
cbd_bufaddr),
> >                                                      fec16_to_cpu(bdp->=
cbd_datlen),
> > @@ -1423,7 +1426,8 @@ fec_enet_tx_queue(struct net_device *ndev, u16
> queue_id, int budget)
> >                             break;
> >
> >                     xdpf =3D txq->tx_buf[index].xdp;
> > -                   if (bdp->cbd_bufaddr)
> > +                   if (bdp->cbd_bufaddr &&
> > +                       txq->tx_buf[index].type =3D=3D FEC_TXBUF_T_XDP_=
NDO)
> >                             dma_unmap_single(&fep->pdev->dev,
> >                                              fec32_to_cpu(bdp->cbd_bufa=
ddr),
> >                                              fec16_to_cpu(bdp->cbd_datl=
en),
> > @@ -1482,7 +1486,7 @@ fec_enet_tx_queue(struct net_device *ndev, u16
> queue_id, int budget)
> >                     /* Free the sk buffer associated with this last tra=
nsmit */
> >                     dev_kfree_skb_any(skb);
> >             } else {
> > -                   xdp_return_frame(xdpf);
> > +                   xdp_return_frame_rx_napi(xdpf);
> >
> >                     txq->tx_buf[index].xdp =3D NULL;
> >                     /* restore default tx buffer type: FEC_TXBUF_T_SKB =
*/
> > @@ -1573,11 +1577,18 @@ fec_enet_run_xdp(struct fec_enet_private
> *fep, struct bpf_prog *prog,
> >             }
> >             break;
> >
> > -   default:
> > -           bpf_warn_invalid_xdp_action(fep->netdev, prog, act);
> > -           fallthrough;
> > -
> >     case XDP_TX:
> > +           err =3D fec_enet_xdp_tx_xmit(fep->netdev, xdp);
>
> You should pass along the "sync" length value to fec_enet_xdp_tx_xmit().
> Because we know DMA comes from same device (it is already DMA mapped
> to), then we can do a DMA sync "to_device" with only the sync length.
>
> > +           if (err) {
>
> Add an unlikely(err) or do like above case XDP_REDIRECT, where it takes
> the likely case "if (!err)" first.
>
> > +                   ret =3D FEC_ENET_XDP_CONSUMED;
> > +                   page =3D virt_to_head_page(xdp->data);
> > +                   page_pool_put_page(rxq->page_pool, page, sync, true=
);
> > +           } else {
> > +                   ret =3D FEC_ENET_XDP_TX;
> > +           }
> > +           break;
> > +
> > +   default:
> >             bpf_warn_invalid_xdp_action(fep->netdev, prog, act);
> >             fallthrough;
> >
> > @@ -3793,7 +3804,8 @@ fec_enet_xdp_get_tx_queue(struct
> fec_enet_private *fep, int index)
> >
> >   static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
> >                                struct fec_enet_priv_tx_q *txq,
> > -                              struct xdp_frame *frame)
> > +                              struct xdp_frame *frame,
> > +                              bool ndo_xmit)
>
> E.g add parameter dma_sync_len.
>
> >   {
> >     unsigned int index, status, estatus;
> >     struct bufdesc *bdp;
> > @@ -3813,10 +3825,24 @@ static int fec_enet_txq_xmit_frame(struct
> fec_enet_private *fep,
> >
> >     index =3D fec_enet_get_bd_index(bdp, &txq->bd);
> >
> > -   dma_addr =3D dma_map_single(&fep->pdev->dev, frame->data,
> > -                             frame->len, DMA_TO_DEVICE);
> > -   if (dma_mapping_error(&fep->pdev->dev, dma_addr))
> > -           return -ENOMEM;
> > +   if (ndo_xmit) {
> > +           dma_addr =3D dma_map_single(&fep->pdev->dev, frame->data,
> > +                                     frame->len, DMA_TO_DEVICE);
> > +           if (dma_mapping_error(&fep->pdev->dev, dma_addr))
> > +                   return -ENOMEM;
> > +
> > +           txq->tx_buf[index].type =3D FEC_TXBUF_T_XDP_NDO;
> > +   } else {
> > +           struct page *page =3D virt_to_page(frame->data);
> > +
> > +           dma_addr =3D page_pool_get_dma_addr(page) + sizeof(*frame) =
+
> > +                      frame->headroom;
> > +           dma_sync_single_for_device(&fep->pdev->dev, dma_addr,
> > +                                      frame->len, DMA_BIDIRECTIONAL);
>
> Optimization: use dma_sync_len here instead of frame->len.
>
> > +           txq->tx_buf[index].type =3D FEC_TXBUF_T_XDP_TX;
> > +   }
> > +
> > +   txq->tx_buf[index].xdp =3D frame;
> >
> >     status |=3D (BD_ENET_TX_INTR | BD_ENET_TX_LAST);
> >     if (fep->bufdesc_ex)
> > @@ -3835,9 +3861,6 @@ static int fec_enet_txq_xmit_frame(struct
> fec_enet_private *fep,
> >             ebdp->cbd_esc =3D cpu_to_fec32(estatus);
> >     }
> >
> > -   txq->tx_buf[index].type =3D FEC_TXBUF_T_XDP_NDO;
> > -   txq->tx_buf[index].xdp =3D frame;
> > -
> >     /* Make sure the updates to rest of the descriptor are performed
> before
> >      * transferring ownership.
> >      */
> > @@ -3863,6 +3886,31 @@ static int fec_enet_txq_xmit_frame(struct
> fec_enet_private *fep,
> >     return 0;
> >   }
> >
> > +static int fec_enet_xdp_tx_xmit(struct net_device *ndev,
> > +                           struct xdp_buff *xdp)
> > +{
>
> E.g add parameter dma_sync_len.
>
> > +   struct xdp_frame *xdpf =3D xdp_convert_buff_to_frame(xdp);
>
> XDP_TX can avoid this conversion to xdp_frame.
> It would requires some refactor of fec_enet_txq_xmit_frame().
>
> > +   struct fec_enet_private *fep =3D netdev_priv(ndev);
> > +   struct fec_enet_priv_tx_q *txq;
> > +   int cpu =3D smp_processor_id();
> > +   struct netdev_queue *nq;
> > +   int queue, ret;
> > +
> > +   queue =3D fec_enet_xdp_get_tx_queue(fep, cpu);
> > +   txq =3D fep->tx_queue[queue];
> > +   nq =3D netdev_get_tx_queue(fep->netdev, queue);
> > +
> > +   __netif_tx_lock(nq, cpu);
>
> It is sad that XDP_TX takes a lock for each frame.
>
> > +
> > +   /* Avoid tx timeout as XDP shares the queue with kernel stack */
> > +   txq_trans_cond_update(nq);
> > +   ret =3D fec_enet_txq_xmit_frame(fep, txq, xdpf, false);
>
> Add/pass parameter dma_sync_len to fec_enet_txq_xmit_frame().
>
>
> > +
> > +   __netif_tx_unlock(nq);
> > +
> > +   return ret;
> > +}
> > +
> >   static int fec_enet_xdp_xmit(struct net_device *dev,
> >                          int num_frames,
> >                          struct xdp_frame **frames,
> > @@ -3885,7 +3933,7 @@ static int fec_enet_xdp_xmit(struct net_device
> *dev,
> >     /* Avoid tx timeout as XDP shares the queue with kernel stack */
> >     txq_trans_cond_update(nq);
> >     for (i =3D 0; i < num_frames; i++) {
> > -           if (fec_enet_txq_xmit_frame(fep, txq, frames[i]) < 0)
> > +           if (fec_enet_txq_xmit_frame(fep, txq, frames[i], true) < 0)
> >                     break;
> >             sent_frames++;
> >     }


