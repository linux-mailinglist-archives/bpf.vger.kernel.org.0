Return-Path: <bpf+bounces-7203-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C688D77355C
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 02:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8020928161B
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 00:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F61337C;
	Tue,  8 Aug 2023 00:19:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6427D36A;
	Tue,  8 Aug 2023 00:19:57 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2065.outbound.protection.outlook.com [40.107.6.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72976E67;
	Mon,  7 Aug 2023 17:19:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=adk0TL33GwV3+H2U895G5tv8/KZF9coe9fVreOrT2joon9Yuv1XtG5J4vH9vxcqQ18a46FXq8+sYE1MJ8NrdtJTk39lUhF11QU98CKhGXPlBSaXxHo2lPp6EstA78nYCSrVHAd45cnptRmJECigSkmEqXcaMlb6Pm3vXLwlyi1JBFZkFbfuERghkaA93GQuzCSC8ITfhX00cKGvBHrz2lCgqMAPLKf0dQ27gDX0YFieQqHTuRJwcCsWtGDg8VigG3Hm5yW3137lqsPqCvIWZDjJUMdWPDVrY94cHTOU6umiATXOK4w8xsPsyTO82NEHIpScICCMY2o8a3Vyf9nO/sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZhKrRawhj3ZQjpsFfGNncBPZ340KoXjvs6jB5K9Y/m0=;
 b=RjgY81RlEjoW0c4gND6O9hhXq9FPZ43SUTYXlI31AMZX0XKXjpCoR7kzQJ7CRD6pUEKZhD262PkrPOcKe/AFtQMBQDJbvV63euaJLqFEO5x7CBnU181/KO2UlA5Hl5lBa1fsxWMtI7YpxjhfiCJzwZwNDN8OpPjxnN7sSaPskLUZFU4T5dmNDe+e4S9CfjvuP+nd47o4nRVxzc9XjNGwO0ZiCEVWLQOYv5B0ggAbkQxvxQOM0WsGvHNSj1S+QUgWfnlV6OCVrK7GJA6K5agfGbLZBwU4FwoAHs72CP29duYQwgPu8oI4KgBN0bRpTaF//N+JgdPejm55ZRVmOTMHkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZhKrRawhj3ZQjpsFfGNncBPZ340KoXjvs6jB5K9Y/m0=;
 b=NhV1zrrqTqYjB0tgaRfAHXpoyWk2IdeluucJPaLfzSIoklKAU3KFejwdg4jssLIvGr0Cox2c2bxG4rSARVuYvXSeFfOoa/Vjwpz8Ei7DijqSQNLlQBI9PU++LAFay/BgI5S1QeUX3cgQ9vvLTFdY7cdbjBJywIHJqwSqhTOjPvk=
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by AM9PR04MB8084.eurprd04.prod.outlook.com (2603:10a6:20b:3ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Tue, 8 Aug
 2023 00:19:53 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e%4]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 00:19:53 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Jesper Dangaard Brouer <hawk@kernel.org>, Jesper Dangaard Brouer
	<jbrouer@redhat.com>, "brouer@redhat.com" <brouer@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>, Shenwei Wang
	<shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, "ast@kernel.org"
	<ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, dl-linux-imx
	<linux-imx@nxp.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	Andrew Lunn <andrew@lunn.ch>
Subject: RE: [PATCH V3 net-next] net: fec: add XDP_TX feature support
Thread-Topic: [PATCH V3 net-next] net: fec: add XDP_TX feature support
Thread-Index:
 AQHZw3VFF5NSBizeREOxLxVc18wksa/XS8kAgACl6SCAAEHAAIAAOPLAgAAgSoCAAOhtQIAApJaAgAR1gPCAAIPNAIAAgVEw
Date: Tue, 8 Aug 2023 00:19:53 +0000
Message-ID:
 <AM5PR04MB3139CF5A3DB00FD66F956EAA880DA@AM5PR04MB3139.eurprd04.prod.outlook.com>
References: <20230731060025.3117343-1-wei.fang@nxp.com>
	<20230802104706.5ce541e9@kernel.org>
	<AM5PR04MB313985C61D92E183238809138808A@AM5PR04MB3139.eurprd04.prod.outlook.com>
	<1bf41ea8-5131-7d54-c373-00c1fbcac095@redhat.com>
	<AM5PR04MB31398ABF941EBDD0907E845B8808A@AM5PR04MB3139.eurprd04.prod.outlook.com>
	<cc24e860-7d6f-7ec8-49cb-a49cb066f618@kernel.org>
	<AM5PR04MB3139D8AAAB6B96B58425BBA08809A@AM5PR04MB3139.eurprd04.prod.outlook.com>
	<ba96db35-2273-9cc5-9a32-e924e8eff37c@kernel.org>
	<AM5PR04MB313903036E0DF277FEC45722880CA@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <20230807093354.184bc18b@kernel.org>
In-Reply-To: <20230807093354.184bc18b@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM5PR04MB3139:EE_|AM9PR04MB8084:EE_
x-ms-office365-filtering-correlation-id: 43ee7ef7-6ec4-40e8-9081-08db97a52fd9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Tu4UU4XWMD9DKSFtTXjIfGK8r1OOtGyhuHnVkGY75JlNSNmZsOiNjNAcBGZ+ivGriPV/nhHB0t0O9n6UUwUVZrIBhwvBQm5v/1Gv+3+qnmx+4BMYtQvZmTRVY6PBkbYGX21pq+5KUKUmhuyAzU32IpHT8g60ak/RpoppheSFF/yEtC/5MpkNdBtYS2FQTQfKI0w3z9p3v8VsraIEVHPHJ4yAlbz3Fqg3oUO+DPTZSqB3zeXBuEuMAPVergrde7VNNXVhURYeMVc8clBCLkANCT3PyUJOS+Rw9YGu9hqDln62tHM87Bg1XNNxUdC6MP2KZ3s8TT3qodfQmOVzpHv4z84JgHflKegS3LBPygwmDrlAmK75yul67XJ1Gf72ErFB49+LU7BMkRIYOrAwuPmwGwSkcsLVCzxk4D1euOSHO30boCtqW0s6XLWPyPzBV+KebeLP9vrSMngladZ/2xsJT9MJz9bHavO3fVD7OKJtfhi0alnrrDLdaMww7EN66u0xqeDyRpKJjUSxg6F9MdjGnCkKIBcaPBS93xXwsN2M5tUoKpjlaTEW+Z2AkEBqsIfGdbR/4FI9tbwDgwcbe8JWMRtjvcGUVujJdg2wmToURWnvlwfWHBe+Atu9oEjYeU+6toIrHqF3WAkC7x8i6Opqya5DFwxaNkmc4wJdUMeRCvFAi8DdpkKgVvSFUdjesiNI
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(136003)(366004)(90011799007)(451199021)(90021799007)(186006)(1800799003)(26005)(6506007)(8676002)(316002)(66556008)(6916009)(66446008)(4744005)(4326008)(76116006)(66476007)(5660300002)(64756008)(2906002)(66946007)(41300700001)(8936002)(7416002)(52536014)(9686003)(71200400001)(7696005)(44832011)(478600001)(122000001)(54906003)(55016003)(38100700002)(38070700005)(33656002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?k7rltsE/S0I8/mNRuvgQYVuCCebFmJpv3Dhb5zwA+ms/GYe8x3JRgNNKK2Yg?=
 =?us-ascii?Q?jS0U+PEUIlb9d1xii95QCItm5eYtOMy/PcnhHx23WuhMNRIKg7KVT9c4B4JF?=
 =?us-ascii?Q?fwi2BHqsbXKMPyG0EGmC2oNDc1VvVKGoKa6lzvcAHAMCD/rk1jzPGS3YG5Gi?=
 =?us-ascii?Q?Gy35fZdFZBpwS3FYwm/ydkZEWtOe6E0cbHEMbQAV2RLCatrO+9N7cl2Mm6xM?=
 =?us-ascii?Q?xZrVXX0BSV3KM3HaeZw2F2fOGZV7y13srQDAZKv7eICHbG4ui7vbGDfk2Uo9?=
 =?us-ascii?Q?Iosg8v2edBaiubxZ0YSDml2i9NKFriRTMZrQdddYW1f6fweH+GJpSUwrrP3y?=
 =?us-ascii?Q?Va3onNAe/iNEVUBbrmjJuJ4xsDTHPGhmy+IbcJ+o9mQ4ZHAjhD33WisAasfs?=
 =?us-ascii?Q?C37/VaPpFdc6ByUkgFS6hln9pzr0/RCohbhcIaVI++IhxbaT/eRmmrf48IZZ?=
 =?us-ascii?Q?IA9imtdIPDYtLMHeTqyEVMHR5x42Vmfb8DrUZVh/PLwSbUZsq7D9VZDt0Qg2?=
 =?us-ascii?Q?jY6YAXf9E7DdjlkZE9QoORaL0klwljQInU+AVgqBruO9ZEhTdizbmwv9tVuz?=
 =?us-ascii?Q?jk7eQOGOmLYUheM9d/yCQFWkW8MkvccmZAwYuf8K7sJO5bsuPvDh1zmn2R7n?=
 =?us-ascii?Q?8RRbjkJsI5h6aoZMMS0pAAEnO8FghUPXd3rHMoO/LWXMItpzvmY0kZ/7kzuv?=
 =?us-ascii?Q?kR8QuP/aKxs5I8tLsP7q2M9DdnChN+Ctt6DsOPwEdGm/qoZkvkUsTOAmU9db?=
 =?us-ascii?Q?lnDdlNonyY9+tc+ogV5J8S4g9Azd69ZSuMAqroE1LPP3lZshRKkzHrITRz+S?=
 =?us-ascii?Q?VqyuAL0syeHNOT9IRuUREpKfixFn9v/sLnh1T/ZsB5u2eUrh4MIcI4taG2D/?=
 =?us-ascii?Q?9SdlbfcUKlRTCuEmHkPujrAHNDXMUf9TutfGAGG/AMa7VIfLfMnDSBwDiHHc?=
 =?us-ascii?Q?tVQNfD4UckL/g1gbrkhRYTZ0BOmYavq29nceYaQCwWRHrKJDIui2ln9SlUcE?=
 =?us-ascii?Q?AfKru0Kgfl1MS7zHDWTgsZNdrMoZ7Dc2UIFnS/0MqZjx3KYLBSI13ssB6sHT?=
 =?us-ascii?Q?c1XrTNkDXGI01q5XT5Fswc4Afk2xMNw637zCFR6JxpJpkRd5Ak6Pwy3kwYP3?=
 =?us-ascii?Q?wDV71LhPWGR4+H9K/j8fcZ09P+FiEFFfWlEQev4MhLtuJCGmDo/ZwxzZAU1w?=
 =?us-ascii?Q?gE+hK7fmEAYdSbu68B6DLy2ZLAGbOc/vJjNyRpj0vYON1+j8r07Siw4SiZsC?=
 =?us-ascii?Q?qaotCcIs7+Zvg6dFdzg+u88a/hnUYCevJ0qNaPXvGzPs3yncpLnvZZnLjGud?=
 =?us-ascii?Q?SX39P0Qj3A8Rx1MTcbp6FO2ylUmvmBos7jA8V6DOB/h2W1Jw5Z2z9djLq0Jb?=
 =?us-ascii?Q?BeQ0sUwAqTyZxt/zEbSGpflm1n9VeVoT38HvF3Mhu/PqFZbqnNfQxSIUTmeU?=
 =?us-ascii?Q?3LTnOs6BaPS981PkhrfrIoVJR8Ae0Y9Z7q5GTWsYA1AirUkte76xEmMTxeiD?=
 =?us-ascii?Q?UI9hdkUb4w++noAPVo0HXKO5CFpIBri9+Qg3z8qUTreecvwiP5Vn7OgQD8G0?=
 =?us-ascii?Q?5HYDtndubXEsPyaW748=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 43ee7ef7-6ec4-40e8-9081-08db97a52fd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2023 00:19:53.1148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5q2fvLtG3z13wHptyaIczTg5bc520L1/kvFYYGH64C1j3hNFizTUiURTCrJH80xb+hcOFvN8YAc/Q5vVZ/oCrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8084
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> On Mon, 7 Aug 2023 10:30:34 +0000 Wei Fang wrote:
> > ./xdp_rxq_info --dev eth0 --action XDP_TX Running XDP on dev:eth0
> > (ifindex:2) action:XDP_TX options:swapmac
> > XDP stats       CPU     pps         issue-pps
> > XDP-RX CPU      0       259,102     0
> > XDP-RX CPU      total   259,102
>=20
> > Result 2: dma_sync_len method
> > Running XDP on dev:eth0 (ifindex:2) action:XDP_TX options:swapmac
> > XDP stats       CPU     pps         issue-pps
> > XDP-RX CPU      0       258,254     0
> > XDP-RX CPU      total   258,254
>=20
> Just to be clear are these number with xdp_return_frame() replaced with
> page_pool_put_page(pool, page, 0, true); ?
Yes, I used the page_pool_put_page() to instead of xdp_return_frame() when
I tried the "dma_sync_len" method.

