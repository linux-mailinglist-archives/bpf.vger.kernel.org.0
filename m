Return-Path: <bpf+bounces-38743-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9A0969044
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 01:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39B4D1F24048
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 23:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD33188A04;
	Mon,  2 Sep 2024 22:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="h9pO8vhx"
X-Original-To: bpf@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012032.outbound.protection.outlook.com [52.101.66.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D8D18786B;
	Mon,  2 Sep 2024 22:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725317848; cv=fail; b=BVHB9/RZhk7bJ1XsLD8ac+Ta6oY8XIYqAZjYq3dzGl5iCj1Kr99Kd6J5YHMg67/wRAtQugxR5wU+QviXgbArw4jLdAaAYNn2k66lE05AR+AqvL+dwaNlzg0VgR5GgIdfbewdbJ+rLXpOCVXwysnlceudIspdETUzcfWTDIR8tZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725317848; c=relaxed/simple;
	bh=7/QXU3zDFWckrcBMF2dIb6Lx/6slWivIRZSiY2JxeD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VVh5RbDISJlA50363/z1A7Xznc8Nao2gTLpQNel/gYtxayc47sScYl3UbO7sDGaPp7ktXrG5XPYqxtK46utY3D88Tw7nZFrClD3NXax5i/FiMyOy34ON5Ww81BLmubsynohRLhw2l7WFx9grUQNcSjz3FMuV0+vbrKCdgfcSGac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=h9pO8vhx; arc=fail smtp.client-ip=52.101.66.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U8uH1rFWsRwK1LTUAO50ThnKWhRv8bz6iPVXQK+sQzsvPXv6NR6VH9z36Wz4tjZ+wqajs7cLNyZRrY2sEhc3Vs6MkktZwVpB6DRDNEYerQrD4sp8S38mc5THt4FBj8FgcGwTTekeKqrcNEhNJoK+n9IRQ4T0ytYmvGDWEcRht5EtF+ekgYwzm3/M+t2J4n4tcn+8fxmhrykK2OtAE0GcPhypf98Koqf6aLvp/fz6rb4c1Ba52jV+aUD0X2U/7BVqmd9kbsaKY8RykCpdXLZewRQ42Shf24WS5RzjItZJ5ly+YxQuuSNFL/e3ikuCzNf3hy8DfAmMA7T6JgLZG3iZDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=284M1jPG87nEEAxH0pcfsM2eeoz4Qgav8hb0FdIsjWM=;
 b=cGykV7lrE0w47LAUIu9cNDPQTAJzCHXQJ2M+y4pKn8Fn2u5Rad+L5nTLeeAlGADZu/kKvKZNmf3cpg+Nx0SN5zCD/ox+FHeGY72P6+XvqcexPxmqARV1cmI7nNjAfp/43KM/zGZvTBVCuoSC24EU76d0cv13uxJa1WCiAiocihtCcfg90wCC2vb70fZhdY/ZEUFu/8+2zKQe+/RYRs1bM7Fledyky7hbPIP/bNCtXE8nyNgVIDBSTfJIQloGff2A6JBWG7/j+xGKoUHOsRrfmuMJ4PmM8Rh+/X0FJj1dslnaljY+QWnEXj1rtGbg4F77i3oVUeXAtVV/vKTbZ1me0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=284M1jPG87nEEAxH0pcfsM2eeoz4Qgav8hb0FdIsjWM=;
 b=h9pO8vhx1qIIGelv0pqw+GbeV384pj0v9n1p9QrCxqK1Zhrc8ZSMojOHJgYNvKdB0Eg9Br/q0FfOPGb6HMy+U6AexinD6v79bj5fHWyGt4/Pl73ad7wTHkqqEJG+vvrpXV7/eH+geH2nWHevKNlzCONVYwj0qyQ+aF0zB2YEqywVV+e/EqkHIp9BnLyDv35E98q34MObQZ1inT6exMXeuLwr6PCRoKMbEp+Z8+6tgdN56PWROxicHAly+hcthEKX+rBfZFoNyOpa46y0U3hdQs7Tc42F8K2QDGLdrwznn2zn+eb4NU3PSuFNhu6z4pv9Op7PF1CaKQmx1fgN118VVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10606.eurprd04.prod.outlook.com (2603:10a6:150:207::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 22:57:20 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7918.020; Mon, 2 Sep 2024
 22:57:20 +0000
Date: Mon, 2 Sep 2024 18:57:10 -0400
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v8 01/11] PCI: imx6: Fix establish link failure in EP
 mode for iMX8MM and iMX8MP
Message-ID: <ZtZCxrrVCfPKHdvJ@lizhi-Precision-Tower-5810>
References: <20240729-pci2_upstream-v8-1-b68ee5ef2b4d@nxp.com>
 <20240902205934.GA227711@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902205934.GA227711@bhelgaas>
X-ClientProxiedBy: BY5PR04CA0025.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10606:EE_
X-MS-Office365-Filtering-Correlation-Id: 83f6bae7-38b9-43f3-aa3a-08dccba299ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B8qCb8QUOaLeNr9c1ejygFpJfq6gV4TW6g4oeeM+AUU/PEyla7GTZdSxcZyK?=
 =?us-ascii?Q?Vd5YuxGtrW5n1Uh2LWld7lmiPlwPbl87KgPdkeilfECda2VH/y9aW60hlKAw?=
 =?us-ascii?Q?bL3qwQZbJkpMVZ7S1xiIF5Fn7fixCzaOTsEWN2FW7kyHh61YyiJEmifEXEd7?=
 =?us-ascii?Q?mMVEsz5rrWmStG2yluCX9tXHQEGomuH0JDj7iKmyX/7uLhVsigtXzUNd7yFa?=
 =?us-ascii?Q?dVY0YPa7nnrl6md3NMq7RaiXxHhpPgsBRnvzIxILFhUJ1My3Z0n+Uyng9nEq?=
 =?us-ascii?Q?w7EDfTIv0Wf2mw8NooFSrAjX7mO3LPUW8h+DSV3LIVIhQrnXiVRqGiMFTLZB?=
 =?us-ascii?Q?UyfFI2PGnT2eHeSgm1NrSNPW1ozEAqfxUQFwW+53NvyqVt1O0qhL3McLcdCw?=
 =?us-ascii?Q?IvZr4c42jN4CZzl5/QxLeJ0pfk0OZmlBFTcXdvk7Rxh9OAJltL3OzmBTI+j9?=
 =?us-ascii?Q?F9mtxuH51GkHNY89rYJqBsBeqGjNYcwVBEIYaAGmIbLeXQAZNVFKGtYa+vCX?=
 =?us-ascii?Q?BqiHXgxfkxfqaHm20nZ+MH0DC85n2MBB13YrideLatBJDpBenR2+JQA4ewYQ?=
 =?us-ascii?Q?99Wq6Zl941fWCkRxACtpe/H8wBJyxrTqyGkwfa7Zd5po7sP2CtnZPrdlMYYe?=
 =?us-ascii?Q?OFQ82jMf9LsA1muJwkjENnl0sJCeV7BDPC2yJYrWppARICYmqBGu88YksiQE?=
 =?us-ascii?Q?fdyo9pM/fhnvkSIrgLLmQztgywrCh8q0dThKfTIAtIxBmXZN3+p1FYRC3nki?=
 =?us-ascii?Q?VfZpEANQplo62i7Heryx8RMqvUIp4Z2qsj2PrxRxs/8IOapLKfkPlfUlzIKD?=
 =?us-ascii?Q?bOHgqrzU3WGPPIWmJN99B2Sp+RwTxb78S8Riis9JaFclnfVn0K96jAy4A2g/?=
 =?us-ascii?Q?XIJ0GMdwgSWpEnWOTWoAqw+Jr/LV7vuUnLR5G4WZgB5r+KOXJcMoY8CArWjo?=
 =?us-ascii?Q?6KEoI6uzqKAB0wll9qOLuJDHSDdL5KdPLau/h3i28g4/SD895ewLxsUqNovx?=
 =?us-ascii?Q?M4kL/iw7bzU/5kZJbEDbyEdX9qp5sacDXWzTLhFLxDb/y8Jgb9gKMdZB3rBx?=
 =?us-ascii?Q?nuHXdnEeJYzZqldzE/LaejK8AB7a6IUFV4+vOwC4l3JkvJrk0m7b2zo9FxGX?=
 =?us-ascii?Q?CPZeB2cckjefNfOO1I35ASNb7X6o7bFXkYsr1nX9QgYnYMZNSQtnmyZ/Z5r6?=
 =?us-ascii?Q?u92FLE5fjLkagsMpHPMVxDK5ud6lGeGm7cAqIROPc6q2Op+heYl98wLwrPm9?=
 =?us-ascii?Q?K+o47N9CabmcoFAaMtTxKITuEGLQiVZQ+cGqc6UKZLToqIKkwsU70ZuJAm+h?=
 =?us-ascii?Q?TENq/AN2EtbC/mwJiO6RV1EukCjZ8cJHliS5R6pyr+fwwbqoqZQqsIhTL0XY?=
 =?us-ascii?Q?vz0fpkgSyag92WB2CwpXlE+SvkbJpvc67vry0EcZoy28hh2UlQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u7YD1+VVI8gYPr2O8Dmx96H+47hms0BYTAqsGBorOicOBbD+r3ZG4maVwoWe?=
 =?us-ascii?Q?AWt8yt6/4Y4wn8ly+0th1JvVzRyzPpm+6yFOmJNC503ls4KIkLuz2gZasBg0?=
 =?us-ascii?Q?jam2LJaSRkAvsKtCXiKF33ZvoeMmF7+0+vOJxl5VROWfFjeQIJQokE3WS8eJ?=
 =?us-ascii?Q?Q+5AE9TodjOZUmpf93VLG/UAAu+Xn3eS+OT/IdPPZimh8UFtreRiKboLw8Ia?=
 =?us-ascii?Q?MVvCDyDm511w69mqLXNVa/5YyPWvTmGcGIXG9+sn5gSrhXht3c3nC7A4beKf?=
 =?us-ascii?Q?Zvql+jd8S/KSihlX7TyZHP8rKgLDelpXKRT/VM8erY3Qq63og4HedbxFxp7M?=
 =?us-ascii?Q?dnxDuEodcW6Z93Bx01jp/p2aA0+EZv2OCC0xunD6EJDAXrCDHYFTIRax4aZA?=
 =?us-ascii?Q?rsY9kxZ7iOzZtUaHg0TbPpjjZvJSQ5p2+d+wfLeDnLaDM2B19sMgXN9W1q5v?=
 =?us-ascii?Q?5bKk24U6CA0ARi/Pf4dxEUrfyjdwBHPEa+T6fARlE35dcxfxV/jGlqAWSN2F?=
 =?us-ascii?Q?cyy8Y3chcBx33EhNOjdl4q+itvZ9roHZ+zzX5JnBEx8QgmZauEPqZuEXKkHI?=
 =?us-ascii?Q?SL87ptFpyDOVw8g0xaRNxQWs4INh0j8VXZzQ1Qsdxd5pGVbAwvWBTCuLS8Hk?=
 =?us-ascii?Q?a0pvUlu+YcRg8wVew41AjmVXAwVD6xdrkMX3e1vfmJgoIy7s7H7X4onU2A2N?=
 =?us-ascii?Q?bI+IQw67q28E3bGkc/hRWe/Syxk9FRdEno6/oJ0Rh5tNRwL8p5X8JFqOrcu3?=
 =?us-ascii?Q?eLrRmBs4eI72FqoGZez7n2/ISW3+WBkRXvLHrQbP+kd/Tt+ON1q4rdzHNfer?=
 =?us-ascii?Q?s9A1faRZGsCMcstwrqwGDGEIOTeWowAHCWre+O8+SUiqvIjd1JIHsyVJSONf?=
 =?us-ascii?Q?Rde6kpaisImUjV7WYneKUgMft16N6rd6J8NHZxd52c+glfIE8fDzJau9QPmn?=
 =?us-ascii?Q?rGZb6YQ073VNxqNu7CoYnHQfER/W7cdqtas7FNl4N9xQyp7DJKonkD+vfhIR?=
 =?us-ascii?Q?cqOGp45rLygCc1RBlt4OzmnVO1wUvPJzpKcTNaZOmKBSFS049Fn6hSD5RYYt?=
 =?us-ascii?Q?Yy2e2dxAW9pzITMa8qJjMOdoeizGgOqXAy4wfr0CC9V4z3QYy1A2X6KU+gjN?=
 =?us-ascii?Q?0UgP1QBF5UJ3Ut4pJ9og/5QxbXn/HFhTseA2PX37MqaOPfzbdmy5Erey1PPT?=
 =?us-ascii?Q?dqT9binFr7SrByE1/mi3G+rWbKPPOkGboAPlOw19o2vvygc4QfMbjN6H51RW?=
 =?us-ascii?Q?8mtt9RAtk+HdB4CIGXCCOr1M3+Qp8NMMz7tXFCZeoKJVSgmSIYPbwmfiA3bU?=
 =?us-ascii?Q?oovu92V6soOnWFY73p/JhWIDYob1nLOsp3rq6QEv93Y5sQhCpaJFeXgtJHkU?=
 =?us-ascii?Q?BmS3guAwtG0xpk8iytAt44k2i8MItcc/4gezZJf6ToW/U9WKKHg3yABsS/Zt?=
 =?us-ascii?Q?3vmBns3CuVk04kDfS6yf+hhlGNt0y+e9KC9ogi3/WnWPnYWSYJHrfj39isk3?=
 =?us-ascii?Q?5Hsnk561oLSh6gxBjbGtDLP7IHc4tdMINW0aylsEtrNuQlqLHyn1BEzTVel1?=
 =?us-ascii?Q?aL3L8gchoYUzoAFX97q6dGVg2NJNuH/3bTqTDF5p?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83f6bae7-38b9-43f3-aa3a-08dccba299ef
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 22:57:20.8890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9RQTFPokPFU8I7op+oU+DbZts6WRsEMytFG8ct/yzOHHvPB3N9DYumTO699s0QRigGpLo671DvSQyLXddINEuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10606

On Mon, Sep 02, 2024 at 03:59:34PM -0500, Bjorn Helgaas wrote:
> On Mon, Jul 29, 2024 at 04:18:08PM -0400, Frank Li wrote:
> > From: Richard Zhu <hongxing.zhu@nxp.com>
> >
> > Add IMX6_PCIE_FLAG_HAS_APP_RESET flag to IMX8MM_EP and IMX8MP_EP drvdata.
> > This flag was overlooked during code restructuring. It is crucial to
> > release the app-reset from the System Reset Controller before initiating
> > LTSSM to rectify the issue
>
> What exactly is the issue?  What does it look like to a user?  The
> endpoint doesn't establish a link correctly?

Yes. Link can't establish.

>
> > Fixes: 0c9651c21f2a ("PCI: imx6: Simplify reset handling by using *_FLAG_HAS_*_RESET")
> > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
>
> Does this need a -stable tag?

Yes.

Do I need repost it?

Frank

>
> 0c9651c21f2a appeared in v6.9, but this could arguably be v6.11
> material if it fixes a serious issue.
>
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > index 964d67756eb2b..42fd17fbadfa5 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -1562,7 +1562,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
> >  	},
> >  	[IMX8MM_EP] = {
> >  		.variant = IMX8MM_EP,
> > -		.flags = IMX6_PCIE_FLAG_HAS_PHYDRV,
> > +		.flags = IMX6_PCIE_FLAG_HAS_APP_RESET |
> > +			 IMX6_PCIE_FLAG_HAS_PHYDRV,
> >  		.mode = DW_PCIE_EP_TYPE,
> >  		.gpr = "fsl,imx8mm-iomuxc-gpr",
> >  		.clk_names = imx8mm_clks,
> > @@ -1573,7 +1574,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
> >  	},
> >  	[IMX8MP_EP] = {
> >  		.variant = IMX8MP_EP,
> > -		.flags = IMX6_PCIE_FLAG_HAS_PHYDRV,
> > +		.flags = IMX6_PCIE_FLAG_HAS_APP_RESET |
> > +			 IMX6_PCIE_FLAG_HAS_PHYDRV,
> >  		.mode = DW_PCIE_EP_TYPE,
> >  		.gpr = "fsl,imx8mp-iomuxc-gpr",
> >  		.clk_names = imx8mm_clks,
> >
> > --
> > 2.34.1
> >

