Return-Path: <bpf+bounces-6839-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC83A76E6A9
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 13:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7066D2820F2
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 11:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C19B18B10;
	Thu,  3 Aug 2023 11:18:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D06D8F7C;
	Thu,  3 Aug 2023 11:18:43 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2073.outbound.protection.outlook.com [40.107.247.73])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B4E127;
	Thu,  3 Aug 2023 04:18:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FcY4JW1/VXfazm/fvTjidrsAypJTSiboTnOzY3kDR2oSX5OLKF/AaDhh+prn5B5uuspClQR8CpvVoU8FtwncNqDVCKa7ZbHitKCsADbo/vgl59fliB59eOIp+mioLyCmVnMiLmuASCgRdDB+kZ3fjGUFF/hFNr4K6PoWWZZ0rJuDgQ4sxsfA6Ptsgp8tWnrvjlCb8k+zzrBX6kiELlvlZEpaMvHzH1Aw4/9/oKLRjIpYy/wh4TRvpFOQwYBegx9fX+yIgRXdnm1HFyAB+D6pjlCC+VTrmTNAWWb9z8Ll7y34wa1/wLBdxP5Nl5qyjn3AxF42501mrVfRuTAQ9Vqrgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CFqWqjqBao8Osy4D3WLze5WJZUcvyGnjs1pnArso0Sc=;
 b=XvQEiXeP3xbOfTT+kt3eLx2d10NsufcZxrrZzpgl/mIWv0+IhbyQ44o3DjEUtEShBX2al/kW4/3wJ/ETcL60gh5xOw0MpygvFlqib+t63HWX5IfscTRbWO/V2SZbJqVQK0FzqCV7cwuHJDxNS+k0KoHI7N0pef10fBW31HrfrtMg/sx9n9FPTdQuIQCEPIS9R5KH3CwtYMVpvAd+DrmHi7zgFBG+W9I+Z3jHmqyRN0TPtGurJTnWkKgPkQxKlLG42arvZETIimYcdV5EswAP9C9r6SLBxhQdNLfgTKjfJdPNcRoXlUzGbPoCRIcn5gn4QbXBiqGa/1hCmJVru2jeNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFqWqjqBao8Osy4D3WLze5WJZUcvyGnjs1pnArso0Sc=;
 b=hUn78PPsywwNmqCbNwbJDYR6QaxI4gaDYrS0MW5rK7XEmPwUspPi8UulI0QPgw9OsHKlxOwfQqFD81KQxIUoqfZkohi9aWY0/ztbdqBoic3asCgkZJrpGWBAGzoduYbGtrK14v3Pt8XHrELOXzF+odRZijifSJ6PEWSqmuVBJ/0=
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by DUZPR04MB9793.eurprd04.prod.outlook.com (2603:10a6:10:4b0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 11:18:37 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e%4]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 11:18:37 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Jesper Dangaard Brouer <jbrouer@redhat.com>, Jakub Kicinski
	<kuba@kernel.org>
CC: "brouer@redhat.com" <brouer@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, "ast@kernel.org" <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "hawk@kernel.org"
	<hawk@kernel.org>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, dl-linux-imx
	<linux-imx@nxp.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	Andrew Lunn <andrew@lunn.ch>
Subject: RE: [PATCH V3 net-next] net: fec: add XDP_TX feature support
Thread-Topic: [PATCH V3 net-next] net: fec: add XDP_TX feature support
Thread-Index: AQHZw3VFF5NSBizeREOxLxVc18wksa/XS8kAgACl6SCAAEHAAIAAOPLA
Date: Thu, 3 Aug 2023 11:18:37 +0000
Message-ID:
 <AM5PR04MB31398ABF941EBDD0907E845B8808A@AM5PR04MB3139.eurprd04.prod.outlook.com>
References: <20230731060025.3117343-1-wei.fang@nxp.com>
 <20230802104706.5ce541e9@kernel.org>
 <AM5PR04MB313985C61D92E183238809138808A@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <1bf41ea8-5131-7d54-c373-00c1fbcac095@redhat.com>
In-Reply-To: <1bf41ea8-5131-7d54-c373-00c1fbcac095@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM5PR04MB3139:EE_|DUZPR04MB9793:EE_
x-ms-office365-filtering-correlation-id: dd6a4c4d-9457-4dc2-d0c7-08db94136202
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 TShPdCa8HzxkZ7seAWv+tH/TtkSAbrrRbLPow87Drbg4qOjllgJkYk/3FcThDJL4YLb/n1J9mzeqJDMM51MOnENXHlV1h4K+RsBGa+zoXRAG9VywVPSifEtT2X4eo/6kmM59qX7BMd1kJaDjb97kmR5mSNHoOZ+tVqMtCQBrwM4i0NG7wIjnc8a2DrcksrQ5r4G6GuuufRlPAVrOlbvSMk4Xo4cCMDLQreq2/xjFItQ26jaklDqeW6/T+j36zu1dQlelKFT9hldRDfp348xHY09bCBN23XcaAvdpu1flsMDq6RwYJ9H724J0CehClOVG8BTgf+kUt/sxZWsdJK4hliOic+q+hKuf8rxbSjjTYNQr9FK6cvPcYLcsMdnMairiIp23S9xDDn4kyHFpyfwO9ZmNzZK+4qZIXCHm0ORFkosSQmKHLmcU/ae5jX2y85hwxAgJvD/7Zz7D9AidBHLX43EboHAl6RZDugFUm/2rvp1jm50yD9++KDl0vo3YH8Zds+NwLWGDFv0mcg99+8uBKDS9MxGADgYzhhEyGceAl8fejD7fytECF4bkyJXBeAwjZs/ftF+YNv/vSOWcBXOYPxBZcAxU4acbQ3aVlU7Qxsw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199021)(41300700001)(66556008)(66446008)(316002)(2906002)(4326008)(76116006)(64756008)(66946007)(66476007)(44832011)(52536014)(8936002)(8676002)(5660300002)(122000001)(38100700002)(33656002)(26005)(186003)(38070700005)(6506007)(86362001)(83380400001)(9686003)(478600001)(45080400002)(110136005)(54906003)(7696005)(71200400001)(966005)(55016003)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?WstuBPdLnZ2VnY5HRvwvjM9wjVOdVlwyDCI5tsWnMuC0noSRoVR1b/utxPKz?=
 =?us-ascii?Q?XIT87qbFajscM/xsLe7o596oayXRQQEZlurZxQNEbxZ+J7zmHuch9paGyTEv?=
 =?us-ascii?Q?7kGLKfy62gW9Yexk+IUzVCM0/Mh5Aqc9OfRvGtK48QFw+8LsYSl1GiKX/kdc?=
 =?us-ascii?Q?yMVuBWiG159lJ1aTZWcP8nk8UQNVhDpBpqlIqWX/aDgVVOU3plmoBSuyaHzM?=
 =?us-ascii?Q?6ygLZgAc1e+/xkps8YbbGVKLq2qejmc6pIzTysITjYUGE0O6K0mCmvACNWAE?=
 =?us-ascii?Q?Y2+eK19AwqFixovRlOhclAqkRdwFSfuEgcUylbSymlDAl8ek3/M7lIpubReq?=
 =?us-ascii?Q?ymPAK4ejFFFw23HEz+8qePkMm7+O+Sc24IYrHp2m5oncCnKJbtmzSE52o7f4?=
 =?us-ascii?Q?fdNCBtC6DK/f6FSiSbQ2Jm2MGceMh5ajH4aNvBDoYX7rEHCtUGTtdIqm1sz9?=
 =?us-ascii?Q?r4paqve3xMArKnbA0IWZUJpzNp3ACZ65i4lR4xND1nBe+A+cwfy90Qt7zXlh?=
 =?us-ascii?Q?U7gApjmuZSZT2ecS09o2lK06UdF0jSNeDURWFsnNmiZpppctcjtlcl+VEOWj?=
 =?us-ascii?Q?NgvJMWy+vUHTFw4t6eh0Fc/AH17Cb9y+spS8kOZ8eNZ0HYn75x4tezrJD75g?=
 =?us-ascii?Q?oZJvo6UMloXqtCFWWxPCUuzyakp1AkllUBGJGzuZqWDLO+VREcs47tJUCO8W?=
 =?us-ascii?Q?Cwa54VzIZZ11JUzvClau560RmVZYIhbTUE9bdx4VokOGhTRPjtP8ffqrbGyU?=
 =?us-ascii?Q?PoYhaKAUZ+V0QAMhPL8Zjb/hP55zBnQktQyTMytORxFMLLdP7KfH2fyqrH0V?=
 =?us-ascii?Q?edFbpSdEgESNstBNNih2EPuUOw2lHgawbKl4KIp5v+9lwvayyXbf70JMER0/?=
 =?us-ascii?Q?yT57A5YbBJiNUCCntzx25BNG2odkzh9s7OIF70vYy338YDCeCj2aC4jEQNEY?=
 =?us-ascii?Q?MehrEEJHzFq93ZUjv4DCcBZu+RFpFECIJwRqzFSlu5RvJfUM5gbnxCo2nQk1?=
 =?us-ascii?Q?bOjJQYzO7rl0kBFGRputzrYIKqCn2alnV2RYF//5CiuJi2VRac5SbtdcUjOz?=
 =?us-ascii?Q?xjSwAHGTYJJ5HY9J/LiLb3IJi0Wt8vnv0bVZLWQDuvliYC22F3nNwfNN21Xj?=
 =?us-ascii?Q?bY/pODydfH1SBCM54Rj+k1OM3/OApoviIB6unSAqEo0jsFOawg+h/BHJhGhD?=
 =?us-ascii?Q?n/PlOUplhaQtuE3MudcuY089/BozMU5K6jGD/WJO+qh4L1pFkkJ2TSobzJHs?=
 =?us-ascii?Q?Iusy0dusq4G6poTlhEi+31zP46zGpi7b64l/BRUGcsrPUItXKLuCc79sNkEP?=
 =?us-ascii?Q?QTEnoB8dlszO/C1qFG3MEu/cdi/GSYQaoTE/HE3+fNOkR0wEi5h2LdDNd7ql?=
 =?us-ascii?Q?E3J19B3c63bvk4jPxcTVe1jPOsvrLM1dAxg4ldoMUJD07MaD6Sz246rMIFk3?=
 =?us-ascii?Q?P+ZjXOnxt7PwkMmCfUcvCi9lfqxXp7u5umwEwl+7D5TXty58+3Xg9TOdW34k?=
 =?us-ascii?Q?ZOj1aqvD107H0wjZO0dA9RE9tcm+wMUtH0rZ3zBtr3Dl0KgIZCXeGB9qHGNU?=
 =?us-ascii?Q?3ma8/7fgvx+CoDF/Q+E=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dd6a4c4d-9457-4dc2-d0c7-08db94136202
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 11:18:37.2375
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +XHmjMUUAmFY1OlZ2bzsX1ncgJITeBdxm9H0BSA6dsxUGeM4uUEZ9A/2LfmMAqt/0mag/SDmWav+4XCr2NLddA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9793
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

>
> On 03/08/2023 05.58, Wei Fang wrote:
> >>>                   } else {
> >>> -                 xdp_return_frame(xdpf);
> >>> +                 xdp_return_frame_rx_napi(xdpf);
> >>
> >> If you implement Jesper's syncing suggestions, I think you can use
> >>
> >>    page_pool_put_page(pool, page, 0, true);
>
> To Jakub, using 0 here you are trying to bypass the DMA-sync (which is va=
lid
> as driver knows XDP_TX have already done the sync).
> The code will still call into DMA-sync calls with zero as size, so wonder=
 if we
> should detect size zero and skip that call?
> (I mean is this something page_pool should support.)
>
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c index
> 7ca456bfab71..778d061e4f2c 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -323,7 +323,8 @@ static void page_pool_dma_sync_for_device(struct
> page_pool *pool,
>          dma_addr_t dma_addr =3D page_pool_get_dma_addr(page);
>
>          dma_sync_size =3D min(dma_sync_size, pool->p.max_len);
> -       dma_sync_single_range_for_device(pool->p.dev, dma_addr,
> +       if (dma_sync_size)
> +               dma_sync_single_range_for_device(pool->p.dev,
> dma_addr,
>                                           pool->p.offset,
> dma_sync_size,
>                                           pool->p.dma_dir);
>
>
>
> >>
> >> for XDP_TX here to avoid the DMA sync on page recycle.
> >
> > I tried Jasper's syncing suggestion and used page_pool_put_page() to
> > recycle pages, but the results does not seem to improve the
> > performance of XDP_TX,
>
> The optimization will only have effect on those devices which have
> dev->dma_coherent=3Dfalse else DMA function [1] (e.g.
> dma_direct_sync_single_for_device) will skip the sync calls.
>
>   [1]
> https://elixir.b/
> ootlin.com%2Flinux%2Fv6.5-rc4%2Fsource%2Fkernel%2Fdma%2Fdirect.h%2
> 3L63&data=3D05%7C01%7Cwei.fang%40nxp.com%7Cb81436deb63d41dd41a1
> 08db93f454cb%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63
> 8266449821982804%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwM
> DAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%
> 7C&sdata=3DCSi%2Fzld%2FucIYo6VDb9YdO91D8HKV1tbzPq8fB5X%2Bs3s%3D&
> reserved=3D0
>
> (Cc. Andrew Lunn)
> Does any of the imx generations have dma-noncoherent memory?
>
> And does any of these use the fec NIC driver?
>
> > it even degrades the speed.
>
> Could be low runs simply be a variation between your test runs?
>
Maybe, I just tested once before. So I test several times again, the
results of the two methods do not seem to be much different so far,
both about 255000 pkt/s.

> The specific device (imx8mpevk) this was tested on, clearly have
> dma_coherent=3Dtrue, or else we would have seen a difference.
> But the code change should not have any overhead for the
> dma_coherent=3Dtrue case, the only extra overhead is the extra empty DMA
> sync call with size zero (as discussed in top).
>
The FEC of i.MX8MP-EVK has dma_coherent=3Dfalse, and as I mentioned
above, I did not see an obvious difference in the performance. :(

> >
> > The result of the current modification.
> > root@imx8mpevk:~# ./xdp2 eth0
> > proto 17:     260180 pkt/s
>
> These results are *significantly* better than reported in patch-1.
> What happened?!?
>
The test environment is slightly different, in patch-1, the FEC port was
directly connected to the port of another board. But in the latest test,
the ports of the two boards were connected to a switch, so the ports of
the two boards are not directly connected.

> e.g.
>   root@imx8mpevk:~# ./xdp2 eth0
>   proto 17:     135817 pkt/s
>   proto 17:     142776 pkt/s
>
> > proto 17:     260373 pkt/s
> > proto 17:     260363 pkt/s
> > proto 17:     259036 pkt/s
> > proto 17:     260180 pkt/s
> > proto 17:     260048 pkt/s
> > proto 17:     260029 pkt/s
> > proto 17:     260133 pkt/s
> > proto 17:     260021 pkt/s
> > proto 17:     260203 pkt/s
> > proto 17:     260293 pkt/s
> > proto 17:     259418 pkt/s
> >
> > After using the sync suggestion, the result shows as follow.
> > root@imx8mpevk:~# ./xdp2 eth0
> > proto 17:     255956 pkt/s
> > proto 17:     255841 pkt/s
> > proto 17:     255835 pkt/s
> > proto 17:     255381 pkt/s
> > proto 17:     255736 pkt/s
> > proto 17:     255779 pkt/s
> > proto 17:     254135 pkt/s
> > proto 17:     255584 pkt/s
> > proto 17:     255855 pkt/s
> > proto 17:     255664 pkt/s
> >
> > Below are my changes, I don't know what cause it. Based on the
> > results, it's better to keep the current modification.
> >
> > diff --git a/drivers/net/ethernet/freescale/fec_main.c
> > b/drivers/net/ethernet/freescale/fec_main.c
> > index d5fda24a4c52..415c0cb83f84 100644
> > --- a/drivers/net/ethernet/freescale/fec_main.c
> > +++ b/drivers/net/ethernet/freescale/fec_main.c
> > @@ -77,7 +77,8 @@
> >   static void set_multicast_list(struct net_device *ndev);
> >   static void fec_enet_itr_coal_set(struct net_device *ndev);
> >   static int fec_enet_xdp_tx_xmit(struct net_device *ndev,
> > -                               struct xdp_buff *xdp);
> > +                               struct xdp_buff *xdp,
> > +                               u32 dma_sync_len);
> >
> >   #define DRIVER_NAME    "fec"
> >
> > @@ -1487,7 +1488,14 @@ fec_enet_tx_queue(struct net_device *ndev,
> u16 queue_id, int budget)
> >                          /* Free the sk buffer associated with this las=
t
> transmit */
> >                          dev_kfree_skb_any(skb);
> >                  } else {
> > -                       xdp_return_frame_rx_napi(xdpf);
> > +                       if (txq->tx_buf[index].type =3D=3D
> FEC_TXBUF_T_XDP_NDO)
> > +                               xdp_return_frame_rx_napi(xdpf);
> > +                       else {
> > +                               struct page *page;
> > +
> > +                               page =3D
> virt_to_head_page(xdpf->data);
> > +                               page_pool_put_page(page->pp, page,
> 0, true);
> > +                       }
> >
> >                          txq->tx_buf[index].xdp =3D NULL;
> >                          /* restore default tx buffer type:
> > FEC_TXBUF_T_SKB */ @@ -1557,7 +1565,8 @@ fec_enet_run_xdp(struct
> fec_enet_private *fep, struct bpf_prog *prog,
> >          act =3D bpf_prog_run_xdp(prog, xdp);
> >
> >          /* Due xdp_adjust_tail: DMA sync for_device cover max len CPU
> touch */
> > -       sync =3D xdp->data_end - xdp->data_hard_start -
> FEC_ENET_XDP_HEADROOM;
> > +       sync =3D xdp->data_end - xdp->data;
> >          sync =3D max(sync, len);
> >
> >          switch (act) {
> > @@ -1579,7 +1588,7 @@ fec_enet_run_xdp(struct fec_enet_private *fep,
> struct bpf_prog *prog,
> >                  break;
> >
> >          case XDP_TX:
> > -               err =3D fec_enet_xdp_tx_xmit(fep->netdev, xdp);
> > +               err =3D fec_enet_xdp_tx_xmit(fep->netdev, xdp, sync);
> >                  if (unlikely(err)) {
> >                          ret =3D FEC_ENET_XDP_CONSUMED;
> >                          page =3D virt_to_head_page(xdp->data); @@
> > -3807,6 +3816,7 @@ fec_enet_xdp_get_tx_queue(struct fec_enet_private
> *fep, int index)
> >   static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
> >                                     struct fec_enet_priv_tx_q *txq,
> >                                     struct xdp_frame *frame,
> > +                                  u32 dma_sync_len,
> >                                     bool ndo_xmit)
> >   {
> >          unsigned int index, status, estatus; @@ -3840,7 +3850,7 @@
> > static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
> >                  dma_addr =3D page_pool_get_dma_addr(page) +
> sizeof(*frame) +
> >                             frame->headroom;
> >                  dma_sync_single_for_device(&fep->pdev->dev,
> dma_addr,
> > -                                          frame->len,
> DMA_BIDIRECTIONAL);
> > +                                          dma_sync_len,
> > + DMA_BIDIRECTIONAL);
> >                  txq->tx_buf[index].type =3D FEC_TXBUF_T_XDP_TX;
> >          }
> >
> > @@ -3889,7 +3899,8 @@ static int fec_enet_txq_xmit_frame(struct
> fec_enet_private *fep,
> >   }
> >
> >   static int fec_enet_xdp_tx_xmit(struct net_device *ndev,
> > -                               struct xdp_buff *xdp)
> > +                               struct xdp_buff *xdp,
> > +                               u32 dma_sync_len)
> >   {
> >          struct xdp_frame *xdpf =3D xdp_convert_buff_to_frame(xdp);
> >          struct fec_enet_private *fep =3D netdev_priv(ndev); @@ -3909,7
> > +3920,7 @@ static int fec_enet_xdp_tx_xmit(struct net_device *ndev,
> >
> >          /* Avoid tx timeout as XDP shares the queue with kernel stack
> */
> >          txq_trans_cond_update(nq);
> > -       ret =3D fec_enet_txq_xmit_frame(fep, txq, xdpf, false);
> > +       ret =3D fec_enet_txq_xmit_frame(fep, txq, xdpf, dma_sync_len,
> > + false);
> >
> >          __netif_tx_unlock(nq);
> >
> > @@ -3938,7 +3949,7 @@ static int fec_enet_xdp_xmit(struct net_device
> *dev,
> >          /* Avoid tx timeout as XDP shares the queue with kernel stack
> */
> >          txq_trans_cond_update(nq);
> >          for (i =3D 0; i < num_frames; i++) {
> > -               if (fec_enet_txq_xmit_frame(fep, txq, frames[i], true) =
< 0)
> > +               if (fec_enet_txq_xmit_frame(fep, txq, frames[i], 0,
> > + true) < 0)
> >                          break;
> >                  sent_frames++;
> >          }
> >


