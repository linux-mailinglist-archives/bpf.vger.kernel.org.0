Return-Path: <bpf+bounces-6665-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B190C76C306
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 04:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64C70281402
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 02:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FE7A5F;
	Wed,  2 Aug 2023 02:43:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCDE7E6;
	Wed,  2 Aug 2023 02:43:20 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2047.outbound.protection.outlook.com [40.107.104.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D361BFD;
	Tue,  1 Aug 2023 19:43:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RyZ8Xpr3tr3nd35BgWuo+p277WY3H9uXIgPEbkQJrjqWe31CCjz1foFnPE7DOHW9180J72OrMRlZIyLjDM4CLE+0aeYWaDrdEFrSkRwUaUALHEks30iue7vNIiidTKTWe9FRVh8nYCThOtjfx4b9xkkZxsB4pGp2TVmNbScIEvKghe2PG3fKtPqnTgzG1jwWgmZPHJeC0K/FT4fLsOitGma6qiKmxCikLYbawiiBZOmdhkS9W9MXUWYygwMnBeuZeQ8HGz8lFSBeqKrQdfvZQW/5yRVWSbdkbLS+gOWiJhxd/eZZ3tWI7Eu2SuY16tfILaBYnevomhnFv+u63t3ErA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9JtlXZ36JouyBFOFuM9o4bzb6VjBwcrk4al28Co5Xjs=;
 b=f0cJj4Z8HSuYZz5EYl63OgRGprHtCL+1eZtTwe4avx49HIQCy2zRgWH86v6efP7pAdtnDcjqPAuyU+ui7ddVW37eRZR2Cs608oIJFGUEqUzQe7I/9CJqhafdPLiAvSjK83XebXnPw3wJaQgYLaqor3TJmkH25C0L97fu8gjPnecxUAgKP6tJ+Tq+Gl/q5DhirBxiG2N7KxqS4IxO5hgbT3k60onImOrt1Z/GnLvE5f7/BmM/gSqNWEPXJ3jY+QkDRsF5M+IxHpiIrb1MLL4s4c4wEu1880X9sVS9jORQDJwRlDPDdQa37xtp+oQ0QQ2yKTaVKTElZo7o1APGFmLJqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9JtlXZ36JouyBFOFuM9o4bzb6VjBwcrk4al28Co5Xjs=;
 b=K0TUP+s5op7RSwycZrNduV2qvECsBQd/QcgAAqUo2B0gep9D2TLm7FkT5346MyVSN1fnXnZVpGIqog2Lrp5MYFRwJYg4XwbQmkWAArNf6ZGQJvi6UCg/SCMyJbSeceZmdG6SHrUHUOk9zY4Zh/u19j9Kh1Q1zSNSVarDAgq9UB4=
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by AS8PR04MB9094.eurprd04.prod.outlook.com (2603:10a6:20b:445::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 02:43:16 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e%4]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 02:43:16 +0000
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
Subject: RE: [PATCH V3 net-next] net: fec: add XDP_TX feature support
Thread-Topic: [PATCH V3 net-next] net: fec: add XDP_TX feature support
Thread-Index: AQHZw3VFF5NSBizeREOxLxVc18wksa/V/2KAgABLGEA=
Date: Wed, 2 Aug 2023 02:43:16 +0000
Message-ID:
 <AM5PR04MB313902042437FD2D89A7677A880BA@AM5PR04MB3139.eurprd04.prod.outlook.com>
References: <20230731060025.3117343-1-wei.fang@nxp.com>
 <20230801145723.7ddc2dba@kernel.org>
In-Reply-To: <20230801145723.7ddc2dba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM5PR04MB3139:EE_|AS8PR04MB9094:EE_
x-ms-office365-filtering-correlation-id: 742df579-b87d-4436-cd29-08db93023937
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Cb1mNr2EVluyP0p439Di7axCTZGmWLxD9NW5R/wrZlpxGzBViNgAC0kLACPHQiiNs5PEhoRaPJtKjJ1+KcVcXQZVLE21G6E7Yq3tQGQJa0OPo7+ecsNyuC8CY5nvLq6NbM0gEH5thi7QVENAdpvNgBTdsoN3Gey5X3Dc2n+7ijT8wMUUZV4o5fgv4MNKKySbLnq3qFPsikwZG7d6ld8TQt8aoYdEqikJ1sjrmXTebYNs7PJYqYGbWarazq34YsqHZegScHZT4UIFUp+QpiGquMerKVO6tVCGFAjWrrdHXohHvOYqaFRArqCQfxDziDL6dmT5xUWeljh94eJGWc4pd1mO24gS5HKMPDxvuFGKDznm8zDyFAqMf+CNoFvO6XTn83k7+xAZr7O0Oa7btoxdoRY61rszu92ZSjRFTxwzsJk0RWP+5xsEqlCjeoucl9ANo7wO73VJHOgqUfHG7LapSD1Pvlth4A5azR5lgVzeitxpnyLy0z1MxcVfNUE4BVhBlpRFl/gehOCs6mzL1UmKEZFcZXOzTijoh+ulf8466MvhDikirQCzT2KUEciRE3PU4KgAu7k5cYEHpghzahdZVEIQbU+H0ElAzVrQPVSFY4byOt80CsJVrpYfrXRjTiCJ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(136003)(396003)(346002)(451199021)(55016003)(186003)(9686003)(316002)(86362001)(478600001)(122000001)(54906003)(38100700002)(76116006)(71200400001)(66946007)(66556008)(66476007)(66446008)(33656002)(64756008)(7696005)(6916009)(4326008)(6506007)(41300700001)(26005)(52536014)(8676002)(5660300002)(8936002)(4744005)(2906002)(38070700005)(7416002)(44832011)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?OhV6Emw3PiPbLe4hFrUhkmiqXxlix3GLJ3xl52uhbAC+IafXAtmeKceyByBk?=
 =?us-ascii?Q?GKnqXyEb6DB4VwJ/1/qXQlkcXQsFLxws4wSWhp8dPAfUQxR2vQhduVtxZ+Nz?=
 =?us-ascii?Q?KuGmN+va6K3PCmSAdgVNTYRUouTwj0VPieFNKnK9c/8OmXeXon5Kedf8lyQ5?=
 =?us-ascii?Q?YeSZSH4iOMU9leGqyIWykWYQrgDqD5z8bmtKbzsSNFJLEPZ/U7xmCfayKWf0?=
 =?us-ascii?Q?bcPNyjUN0TL6z+F9JOYZB5jwQ9GWB9o18fSNClrm6wy4bO29WcJZdKTlgE/H?=
 =?us-ascii?Q?ne7HOLZEFbspkBU68jW5V3cJOFmBtnvMX8HhWUvCKIi82Q5yt7WpuwXPPyvk?=
 =?us-ascii?Q?Jsu7mVyMjx+JIxHcOg1gEi6csLRLzh30nnKZBclcvjCP42gorsUGMzDuDHtK?=
 =?us-ascii?Q?q7InCMLcNOKENi8iHQdjfO2j233BkvW2ZTgIfUP5Ls5XqM7RgjHI15sOXOIv?=
 =?us-ascii?Q?G1wGzlZXGbnlWegkgbKuej5C2sHMME/yVl+j+q/swpYp1kdYJuhCvA2wpEaq?=
 =?us-ascii?Q?9UwBjdCTsGimQPStYVKXyVs3+O9mtFpKNaI4k4snXGwR5fgTrMIDrpCiCrNL?=
 =?us-ascii?Q?JLEGu+x/QqBHpcMVN7s1bGrmCVX1vfZH4laP77hKYCPZO0xBBmGqoIGfsuOW?=
 =?us-ascii?Q?LgsYgJaObqg9SsPvCFfAZu+ReGf4tdamza9qxXtpy+N6r02FZq12ggdw6/7Y?=
 =?us-ascii?Q?oiTZ3fuJQnrQwsxeifrmHVvXktxRn5aNtbDbeTdbDWrOyJCjPEbgv4VivTf/?=
 =?us-ascii?Q?KSAKHHqjJaNDi8jYmnvq5o8rSlQ0O+rLdxPJUGqX8jPoox6Ai71q8QMcviA6?=
 =?us-ascii?Q?ZY9w5XB4e+2l0Ya5hFwj5jCrwQQEdGksBuGtQUvUd+mkykW2oFmVIAXE5tnF?=
 =?us-ascii?Q?OzE0PIjkPZe7lNscZT9F0n4nK4nvmCzv5zW/ERPMEVYL2wtOJpXrC7TKEtIU?=
 =?us-ascii?Q?iMpiVEKWqIpdGIDtjhE9T2J/VE88F6s9yd804EBhZtP2sbwm2yuoNIWQzKmV?=
 =?us-ascii?Q?hvJJ0ZYOgpvxkBhdjJ5afYa0bcWhLOwgtzWBjEqQ9tJrDBRwSDKYGA4h/Kl2?=
 =?us-ascii?Q?XTbTDQh9BC0R4eAzjX2Z0MvrVQRn4fwMhCZHGkZ338QED+EuCX3VH31dYTq0?=
 =?us-ascii?Q?SDc1fVe9f/L4SW9nZNP53MMmU6QpMard1feYOHyN/cmKh6kwml3fzBj3riBB?=
 =?us-ascii?Q?MmMonRV/M7TQUPTm5Y2F5fD6WjtW57jjOxSLecxzxme/ZbIWR4VARREs32zI?=
 =?us-ascii?Q?x1nGdvIdcQ1mUc635+bEikqg6Tv0MrYKZeC6Pb7SsO69R+pf+y5tStCOxnZC?=
 =?us-ascii?Q?K3Y3lGLXH5gYX7jdefkQZnsxpBh+KTmJbCe1X/TgQK1Rm+WI3LreONsLYW4s?=
 =?us-ascii?Q?UF+3vvmHz8SWhdrpD7M3eWx6ZFKK1mkDgq4WFltg27GJzveZSoT6KPsiF1bQ?=
 =?us-ascii?Q?Rv6H1PDMbFLqlef8w6FkBrZp5PbFzb6pvp9nf9M9zLiTmn6Yytlkm+8f4Pef?=
 =?us-ascii?Q?b+WbEPNKleaxkiJ/Kf+KgNJvCfyV4Qk10vQud12yaqC0UHE9tvU3KBgUi5ro?=
 =?us-ascii?Q?SJaTvI4PdHy7m5y0ZaI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 742df579-b87d-4436-cd29-08db93023937
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 02:43:16.2204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5aTxNIMmm9ZFN8zvjujoh9PhKXvbtelQiTx1y2LbpD5Jninbs98Ns1zCFh6c8BQHTRa2nnkpqlf4HAbW8AJq1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9094
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> -----Original Message-----
> Subject: Re: [PATCH V3 net-next] net: fec: add XDP_TX feature support
>=20
> On Mon, 31 Jul 2023 14:00:25 +0800 Wei Fang wrote:
> >  	case XDP_TX:
> > +		err =3D fec_enet_xdp_tx_xmit(fep->netdev, xdp);
> > +		if (err) {
> > +			ret =3D FEC_ENET_XDP_CONSUMED;
> > +			page =3D virt_to_head_page(xdp->data);
> > +			page_pool_put_page(rxq->page_pool, page, sync, true);
>=20
> The error path should call trace_xdp_exception().

Thanks for your reminder, it made me realize that the error processing of
other XDP actions also needs to add exception tracing. I'll add the excepti=
on
tracing for XDP_TX in V4 patch, and add the tracing for other XDP actions i=
n
a separate patch.

