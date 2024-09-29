Return-Path: <bpf+bounces-40469-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFD4989278
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 03:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4E341F212F7
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 01:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C573C134AB;
	Sun, 29 Sep 2024 01:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="T1b0009k"
X-Original-To: bpf@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013057.outbound.protection.outlook.com [52.101.67.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F188AD2F;
	Sun, 29 Sep 2024 01:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727573512; cv=fail; b=RAKiNqp+7ha7+Zc8+qqjk/lBV5A8hOZFF9vH/3gc+8dRctMylXnFDcsb8jflRsq5Ac/hp3fk9FIMmVaq73bNk/5FoRX6mkDMjWkv7KVF+kHSbJWxnK7GoGoup8gAEbOaF5iSQrt0NIGUCc4UAY1WXecYhHoqiIGX06/DQq1z3P8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727573512; c=relaxed/simple;
	bh=AnNOw3I8Ia+hFtvVQR+/0GEcROEws2GQhlJNKClbgqE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HZgrkH7x259/h2OKPpy06OBeD5stWg2Uu1SMegEFrPzLsA3JcePa3najSKnC3mD+MAYCFw9EazzDLF5hTCAZsV8dluFkPVeJljjytKDmjm4KCpbmjTEMUgJ8biFGbbBZJbCjqXRn4t+wY48+BBM3T6Q9kXIj4fK9rfAwhuXI6WM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=T1b0009k; arc=fail smtp.client-ip=52.101.67.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NcjDYslTXJSmGZtYhBimNlxJTTRIMvBqJ4i1hQSSM5s0F2cxXz58M5YDbZv8P8KSVH9d3fxxc2GMVVpr2Lw3okriPHCD3oflBczgZ/N5lQ9L0M9Q2H2PTmfHHnp7TizUKvw7vMv+h0qJ2LAzKqZq5pnpjCPzwQi6culg3XUUXtASgHtjLIgu/BF79pTKEgcUm8Nd3YoODaZYtxH1GNa57lO1PVUNbd5rxqZoju2/kjpLD4WAVKBOnVQc5ZSpr9S0n1gMYPJh728VPaV+YSgLScViOiv+/VJF1FfuWglkxhj/iH9hHunx85Ln6lQplmasD5J4Jgk2HnEMA7u5v79Zfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F6ahNzUi1HOxyrY/Fa9agt+3YeeoNBsM3it6HdYgctc=;
 b=yQe6NOIzbEGMnXAhgSS1Wd5eJFQB1mup+DizI9QQcm4OSpyS3IUQYs6up3jDwl9vtPyHgWRxxjCXZKuP3zr8QOY+sJ8qLMNgemuT4/PiMQgTpeaSEnhhL3lc31dXjn4C8yVQ2YGfkETsmU7O3hRTVANq6qwSh7zpvuwZmiXL/C3aUf0skWuW7s2qzZBL7vmZSjnjoe7+SJOONjh6Do6U5DRACVVxmYIHmxUA2gKnTsA707cP4UkOYnuK8hNxjb9U8IqCFyHqO1zqvQmfAYo+gvUo0PokiMpkpnwFhN3NJ8FPtp6a7c7LuYlB57RAMIA4KkkjdPBENu9DZhZUzm2CXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6ahNzUi1HOxyrY/Fa9agt+3YeeoNBsM3it6HdYgctc=;
 b=T1b0009kBBNzbUNfJb4wGtQDj7Y005/S75jqoqayb3Y/zCXt8ymqG5k5Hqd0rcIvki1YOPlooYlKNqkEoYRF21R2TvCLs+KFHcp6CyuB4DuWAJw9ccyTsdC+i7dXG3lkvEl/A/vgNKA9HvJwX0zA7CtL58zIS4eqreEKGt6nUZluH62UdyJFlwm6EyMZ0ttsNyKM6FWwq8JMx7OqIpADxJhQ116Ol3rbp7uiABCjjWJWypnSM3YKB4LmMzNFm9Jt3cgJyHvZ/gy7t1p01sG86ojzazSGvu1dDmWAxJf0P5leVY7/7929Z/483E0CFt77Vv0VzRB1Kmlv+WzJ3/nF7g==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB8PR04MB6777.eurprd04.prod.outlook.com (2603:10a6:10:11f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.24; Sun, 29 Sep
 2024 01:31:46 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7918.024; Sun, 29 Sep 2024
 01:31:46 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>, "ast@kernel.org" <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "hawk@kernel.org"
	<hawk@kernel.org>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH net 3/3] net: enetc: reset xdp_tx_in_flight when updating
 bpf program
Thread-Topic: [PATCH net 3/3] net: enetc: reset xdp_tx_in_flight when updating
 bpf program
Thread-Index:
 AQHbCnHT295KDDvRD0aXaVmRMCCprrJgpnMAgAANdRCAAAkBgIAD4MDAgAchygCAAknPMA==
Date: Sun, 29 Sep 2024 01:31:46 +0000
Message-ID:
 <PAXPR04MB8510D6740CA5B37622A7298E88752@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20240919084104.661180-1-wei.fang@nxp.com>
 <20240919084104.661180-4-wei.fang@nxp.com> <Zu1y8DNQWdYI38VA@boxer>
 <PAXPR04MB85101DE84124D424264BB4FD886C2@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20240920142511.aph5wpmiczcsxfgr@skbuf>
 <PAXPR04MB85105CC61372D1F2FC48C89A886F2@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20240927143308.emkgu7x5ybjnqaty@skbuf>
In-Reply-To: <20240927143308.emkgu7x5ybjnqaty@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DB8PR04MB6777:EE_
x-ms-office365-filtering-correlation-id: b67ab49c-140c-4b91-2fea-08dce0267b6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Zgu087IqRKDiH6u6C2C2Cvwjhstqv9Mx8/QjXsYD3e03Zix4v3aCJCKO4p4B?=
 =?us-ascii?Q?IkVXxAImOTzvAE5/i4lCn4VMk/E5hCTQmIOioTaXcT1BfVygY5vrxfy20zv5?=
 =?us-ascii?Q?JxZdP4RBTppTNQS1PQ0DBjijDEddMdbvgklPTzjeArJqnGGRtdKWr42HrVVd?=
 =?us-ascii?Q?YebWGOyB0ki6VcoQBnob67UEKFBjtZN4rMXgzRFPbDtMbDy2wGKQ8wk19D6X?=
 =?us-ascii?Q?bAUbECe/Cy6g/Vd213zbo78R4PXKhoRY+T/smisdbqr2bTDMLNp8baJO9J2x?=
 =?us-ascii?Q?wX9IEfYwj6zTk3nkt+NJ92ey8im1AWlcxJjoWBudzAB18FEg5kS3oiQ4z/5a?=
 =?us-ascii?Q?g7WavGkWXZG877XFO54MAjEi4vBHaOucWTtyA6Upr0Im3ugpu45oqMbygYsy?=
 =?us-ascii?Q?2OaLB+sSpef0VNND9i22iK4bcMQtlgmh6iJlMx9KJgBJqWaSQyKry5FWKeoE?=
 =?us-ascii?Q?uHe1pdMRhM0+BgCXky3QFgCh5tltqFlnKGgnRZAF1JKVWTz2TRDhmg3nnVgV?=
 =?us-ascii?Q?9bUJ+wWEsKGE/WjdihT58ReXZZVRG9Y2ekmj6PNR0uI7qnJ0m2nDBfE2ACdA?=
 =?us-ascii?Q?06cP7+Lb1kIptrlIyf8KGC9Gmt/G0/wqS66r5TpDSye2h7S/CR4ZzzOjrAsQ?=
 =?us-ascii?Q?u/iqv8yvonXhvnT1orCfwPZ6G+h4L5nni7paDLl61o1E8GpwmNaIrDzDfnKA?=
 =?us-ascii?Q?p7PhfBNA45s249DvaqPZUyAmRb6fo2cKQjdZ5BBGo1ZsH2URosrk8nEFyJxp?=
 =?us-ascii?Q?oq2rCQJAhmcYKvGIutvxzLbzpKD9vF2O0+BcR6H/XsTduLvCIPXf530SZGJ8?=
 =?us-ascii?Q?P0TItbuN7ga21HlomcYM5erE1RFpgqpfermtAE7aZTZl2sq0Muf3iINGHpN1?=
 =?us-ascii?Q?9JpYw0zl+tkDGIMiZakrwmFzk8aQHfwrVhd05mEMco/7zARJoyjHdSWDfK9K?=
 =?us-ascii?Q?R1qwyMnJyKHUVLHVKq5EU8RzQEMIAnPGcwweZtSwgHLNgE7vktIJTX57KTH6?=
 =?us-ascii?Q?qr6dyVsBZduLt0n6wA41lH5dNyAHAbPO1yW/TASlEH2IMgQU58kKeUHaNOnO?=
 =?us-ascii?Q?ROCKDnfojCzXlrl4nQ1fLv3DWkyVyTIf/AUkffuE3zx/PXobG60msYrqrL9i?=
 =?us-ascii?Q?1aiplEbU7Forjwuyq/eZ5ZWaibqs8yifROEzHMw1SYSupk9dkxZXuaU54r+t?=
 =?us-ascii?Q?11KYpc12NQjU3HTAVKT+nXrJaV/9lIMZ9DMVDOjM/QPdMOinkswmNNQDbtKo?=
 =?us-ascii?Q?+C6NkH0yQwlrn7nlhxvJgUzl0Zv+KZYoBGbFhAs3AdiTshi76hy0ysd0F+Mi?=
 =?us-ascii?Q?rnIAkTRmyaCydfdQyUedHh/R47HBaIaqINVDCM3T+9Wf8Q3VosxcihG9Uyuh?=
 =?us-ascii?Q?j3KKqUZMkk6w9RKWhCD9XNOoLm8YStILDMiFS8K9p6Zj+Lgn4g=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?vx3iB4KoieKegIszgayqSqXmEiFLqq/Pa9CwigA8wg/amUT9zf6bA9R9DAPZ?=
 =?us-ascii?Q?VuM9DWFzIrVpZRycYxr2DkbRSZpzLDG6jLMtUMVK2kJnKsSrVhtoik3INH5T?=
 =?us-ascii?Q?WeXifqqQs2tLFGI38l40uiM+bdEk0+RWIAAGvfbqe1MfFJBB9elWEMHReXn2?=
 =?us-ascii?Q?cI3FbLAyaqm62xq/a+ktLDWnvXQLmhjItltc9l67fEB6FiExtB7qpd3cCGlc?=
 =?us-ascii?Q?Vmj3fHaA4tE3px2Riod/WHsd0NFnR7164hPG7nNifsULj9DyVqyCFQ+dpRF7?=
 =?us-ascii?Q?FakFOzX3ADbRKBRYuNDmA5aCZ5PxUHe2v/463Pbv+DcltzLMXtOrSLhflOBY?=
 =?us-ascii?Q?KQiOqCRXlQIff4v43gsFyWC6GNGhRzEZM+6ie7U1rDVOCTYg6XU2+TKcCzCR?=
 =?us-ascii?Q?lEQ8CI5g46X42qrZsSjVGP3+UeKEDZXpNV6b5rVcT4y9t42Kk02VeuIBDl1X?=
 =?us-ascii?Q?TbgeHHr0HK7Mlk8iKBDnKNtAKUarEQUb1iIdMLsZfA6I3VJNJiDc5ko912RX?=
 =?us-ascii?Q?9Pf80sYi2tweBaCzkBs2L6ODkKCi4kfQLxbQM+vA0miC1o/4TMCNgG9t7wSc?=
 =?us-ascii?Q?v8pRhoRfFGonpcwp8Onh8KIPHcSg0ZYGHVxDJ+JJoTlb38gkhaTYnwuF9xfj?=
 =?us-ascii?Q?8yGQSPG+kreFbqc3YiJ1K6NvSRzj7c/OCRfh8t/Bdh8SLEyU0JvA7GJCJNhZ?=
 =?us-ascii?Q?qCncGtdQO43wKtFizcVXF6MxWt88flOSKDny7juGCvdz6lY7alC4FmsR9MH+?=
 =?us-ascii?Q?SSzkmie9+xebI+aI7YXaIrc1dbEj2i1Zg1ynf9LlSnCmhTigOhEl3s+oCNVu?=
 =?us-ascii?Q?+cs2UbZSKkiJ0UZAgqm3jx4KoPLUXK1HFfUV9EYPXNT5KjX3gSlIy7ketVnB?=
 =?us-ascii?Q?OvUygPIDZVFFavG1emcxqLhv4aS2PQO7J4a2BU+jw1/9Xjfj2w51wJXEFeGt?=
 =?us-ascii?Q?S0UrpuZs1A4oW3NTe7ucXQuaZMX8fph5RQpKW05WllYXVoUFHqyKSGncL/yR?=
 =?us-ascii?Q?IRmjnL/R+ejBux3XnoOUWWnJTJDdM2MkRIY4e7kHyMR+lSOLy3meOZtjQBdp?=
 =?us-ascii?Q?tas0HZijDybMmEksPcqUcz5B7ubEl8Z6zoa8vHjabBOP17my2mTTCuxCC145?=
 =?us-ascii?Q?U5f77ocCFjkVcSa4BGM5sntfd4iZ9jCKBkmi32ZZ9fTOaE4Wt1VMHpZEoH0Y?=
 =?us-ascii?Q?c2hlWqIsJpBjKLeMJqdD4FEMFBmDMLB6/Ny6YsjaCM9410f7q2NjxrOCg9cM?=
 =?us-ascii?Q?6JWP6oo58ndZWXEDn1JMj7lyuUcmJP+pxhfcnS6IeilNKLnwyqxTAEW7ItE8?=
 =?us-ascii?Q?iithIWkV/jYaXBXhA6UrFZ6EHK+B/VhAT9uvgSH70LeivOuKpWHv0J5HaufY?=
 =?us-ascii?Q?XYoWxqGbIub0w2C5T4IgLk2WNFh5ZEODV44VIK1gNjsSbDBigY688XQg9wHu?=
 =?us-ascii?Q?3DgP7lFvGlKkf2N9pz+8kYtcRXlqX7I2RQNRZnLkqSLHbih6wSdxyl3JCBJE?=
 =?us-ascii?Q?pVdYx/nHLK5CsMZpVPYK5LXx79U2pIFe3rBB59T6r4cA+BJomus6TfIcHJ/2?=
 =?us-ascii?Q?QSFvcgndUaAg/P9v0aw=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b67ab49c-140c-4b91-2fea-08dce0267b6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2024 01:31:46.3604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m1iZ8yqu3MAeUrGRQL4CCcTQXAv39vAmVY//R2F0ABPQ/QlqV2dlYG/76iJNw/aAd4gb+Fjm4/aQqN+zs1zdbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6777

> Hi Wei,
>=20
> On Mon, Sep 23, 2024 at 04:59:56AM +0300, Wei Fang wrote:
> > Okay, I have tested this solution (see changes below), and from what I
> observed,
> > the xdp_tx_in_flight can naturally drop to 0 in every test. So if there=
 are no
> other
> > risks, the next version will use this solution.
> >
>=20
> Sorry for the delay. I have tested this variant and it works. Just one
> thing below.
>=20
> > @@ -2467,10 +2469,6 @@ void enetc_start(struct net_device *ndev)
> >         struct enetc_ndev_priv *priv =3D netdev_priv(ndev);
> >         int i;
> >
> > -       enetc_setup_interrupts(priv);
> > -
> > -       enetc_enable_tx_bdrs(priv);
> > -
> >         for (i =3D 0; i < priv->bdr_int_num; i++) {
> >                 int irq =3D pci_irq_vector(priv->si->pdev,
> >
> ENETC_BDR_INT_BASE_IDX + i);
> > @@ -2479,6 +2477,10 @@ void enetc_start(struct net_device *ndev)
> >                 enable_irq(irq);
> >         }
> >
> > +       enetc_setup_interrupts(priv);
> > +
> > +       enetc_enable_tx_bdrs(priv);
> > +
> >         enetc_enable_rx_bdrs(priv);
> >
> >         netif_tx_start_all_queues(ndev);
> > @@ -2547,6 +2549,12 @@ void enetc_stop(struct net_device *ndev)
> >
> >         enetc_disable_rx_bdrs(priv);
> >
> > +       enetc_wait_bdrs(priv);
> > +
> > +       enetc_disable_tx_bdrs(priv);
> > +
> > +       enetc_clear_interrupts(priv);
>=20
> Here, NAPI may still be scheduled. So if you clear interrupts, enetc_poll=
()
> on another CPU might still have time to re-enable them. This makes the
> call pointless.
>=20
> Please move the enetc_clear_interrupts() call after the for() loop below
> (AKA leave it where it is).

Okay, I will, thanks.
>=20
> > +
> >         for (i =3D 0; i < priv->bdr_int_num; i++) {
> >                 int irq =3D pci_irq_vector(priv->si->pdev,
> >
> ENETC_BDR_INT_BASE_IDX + i);
> > @@ -2555,12 +2563,6 @@ void enetc_stop(struct net_device *ndev)
> >                 napi_synchronize(&priv->int_vector[i]->napi);
> >                 napi_disable(&priv->int_vector[i]->napi);
> >         }
> > -
> > -       enetc_wait_bdrs(priv);
> > -
> > -       enetc_disable_tx_bdrs(priv);
> > -
> > -       enetc_clear_interrupts(priv);
> >  }
> >  EXPORT_SYMBOL_GPL(enetc_stop);
>=20
> FWIW, there are at least 2 other valid ways of solving this problem. One
> has already been mentioned (reset the counter in enetc_free_rx_ring()):
>=20
> @@ -2014,6 +2015,8 @@ static void enetc_free_rx_ring(struct enetc_bdr
> *rx_ring)
>  		__free_page(rx_swbd->page);
>  		rx_swbd->page =3D NULL;
>  	}
> +
> +	rx_ring->xdp.xdp_tx_in_flight =3D 0;
>  }
>=20
>  static void enetc_free_rxtx_rings(struct enetc_ndev_priv *priv)
>=20
> And the other would be to keep rescheduling NAPI until there are no more
> pending XDP_TX frames.
>=20
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c
> b/drivers/net/ethernet/freescale/enetc/enetc.c
> index 3cff76923ab9..36520f8c49a6 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -1689,6 +1689,7 @@ static int enetc_poll(struct napi_struct *napi, int
> budget)
>  		work_done =3D enetc_clean_rx_ring_xdp(rx_ring, napi, budget, prog);
>  	else
>  		work_done =3D enetc_clean_rx_ring(rx_ring, napi, budget);
> -	if (work_done =3D=3D budget)
> +	if (work_done =3D=3D budget || rx_ring->xdp.xdp_tx_in_flight)
>  		complete =3D false;
>  	if (work_done)
>=20
> But I like your second proposal the best. It doesn't involve adding an
> unnecessary extra test in the fast path.

