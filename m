Return-Path: <bpf+bounces-38828-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1D796A7CA
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 21:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D2E11C24487
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 19:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43C81C9DC9;
	Tue,  3 Sep 2024 19:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="droGvN5T"
X-Original-To: bpf@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010047.outbound.protection.outlook.com [52.101.69.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456221DC726;
	Tue,  3 Sep 2024 19:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725393038; cv=fail; b=Me6YXSuADrajJ2eTSTeAnZrRdQ4iS/TOGGtsrDenj4ptKlChiDy/ChWRxgMQnyAc2kGek45rgG+gdbYhoP6Ndvk5CIMRU1x8HE7U7Z1jreISdeDpeoqS1IsAbdOUrDFzRECq990CowKmZ/NR005gDMu02W5gRM92m7sijVi/5s4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725393038; c=relaxed/simple;
	bh=aHNqExdmCfSiSeXxsWGt0zhCXKkSNoDE46s1e3qKStM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pxq535zTMDGnqS+yPYFhMBzMUoHrKHvNA3T0YnbaPQzhXYlMMEI3NRTnAenTSDtasY0lC/zenYSAYVvuQfg9m4o0R9Su4O8n1VHtZs/yOjd6/N0lcdEEmc/mwP5Bj5SDEAxQBqGImoN1wHH8JFuJqkDIO41p5Y+EMY3mbAFxQFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=droGvN5T; arc=fail smtp.client-ip=52.101.69.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FFouBFdseYuBXO+IE0R8z5XdUP/cO+k0xmh596+a9RKApSfn7+noxu3arTopVXNgjI6Sxz0m1TK+O1QcAgyRPZjNDlFDWBp9qZP28DKm0uJpRJXkYwJzdsu7NiXnCHaiAwaiFFqJGyTvX43rFkvmHGGexMbqpDKSphzD06sfVlYxEr0NecreQ5HU0FSQDNopDsOfswKbwGO/2az+74h1w2OJUKD5CgsIIXewzl2s1LRh1uae65k5KHBO3ZaP5dn7Zwqy6CIdvXAI9L/VyKJQG5VLScN2aqE6SrucUx8BcCVrjcwdfMhJYxXjFoJ0FvpUxELqU7kdE62f5KPWH9WKKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lGFc7mPQJsC93ZIc7FTWxYP0mlCPc4XRCh7l2eEMR9Q=;
 b=pHejfQMueVZmpbHFS050qKT9lTAGmaj96mEEqYXeUUwKbf+j3feKxl6VDZ6GxuNU22bYx3WkJ3jF4fZLx10kR9LRoH2zeNKNqbcBc8IljhiSwLW5eULfovU6KYNl4GDrTzGT98F8PUf/hHDChZhTfGn+WzqXjAN57xkjHwbxLRQj12TptTz6MNlKoRXC/fAicXzm3b3W1BMzpFleGqXoqktetK+9R7f2xf3qilKfFes9R5rKphSktE+CFNh/TkaY710QreEvCFR+TNZ/fyMUc64g6pDdoufePSV4J3Vl+DLpNZRJ/MdXuvdklmM44TCfmZfzkKu5r/whr0I3NAsG7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lGFc7mPQJsC93ZIc7FTWxYP0mlCPc4XRCh7l2eEMR9Q=;
 b=droGvN5TuWB8hJgpFpitCasqBA00XY64Y2j2T6hMS2h6lxT2f6YCY7hSI7Rk/942xaM2+1Dy+9clNglFrSj/RxTstbVWm8Etd9rQvSnKk+KnQYN582MLrAudJcyDAiMT10/K7KnxHMlzsD9QsSTMa/ZgUWwj4DInCze7hcI+cswoRNeIiVl/u5AflxlLSQ1dUMkCiFK4lv0Xh0sSxu8POuJ2sBS+hs9K5XEwtO5PXGyZb3VgUz7EDJxb+su65AtV7iQdruKZT9KsvLfFapkEglgkfvaDqw8gYz/tErS0afPQc9wyXtbjMQxAU6PymWURDqnyLE/BIPmx0QZOTQiixw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10590.eurprd04.prod.outlook.com (2603:10a6:800:264::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 19:50:33 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7918.020; Tue, 3 Sep 2024
 19:50:33 +0000
Date: Tue, 3 Sep 2024 15:50:22 -0400
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
Subject: Re: [PATCH v8 04/11] PCI: imx6: Rename imx6_* with imx_*
Message-ID: <ZtdofnRRoa2WZ1Vf@lizhi-Precision-Tower-5810>
References: <20240729-pci2_upstream-v8-4-b68ee5ef2b4d@nxp.com>
 <20240903193739.GA230579@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903193739.GA230579@bhelgaas>
X-ClientProxiedBy: BYAPR07CA0014.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10590:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b6b7b29-8aff-4707-a940-08dccc51abed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7Yl0zhe9ocl/1JfrtenxRkLc/hqIMZpQMtkP7M/KqjYR5fWLMw6pmchthd5b?=
 =?us-ascii?Q?9AsvXWsLKQ8m8koSnJuvpsgsxQnDkI5NwInuSBHzragk1KjqInkxhrjzp8jK?=
 =?us-ascii?Q?oxQ3wWuBmMiD6CpOvgwYSLubguG2sVoNnb68GXfMQmA0nnA7McFRo65dkc6c?=
 =?us-ascii?Q?2wY5taseSzVbD1ZgU9mv5kTr6NIUw+INNQU1RptE0M/P6S6ht5h0nPwW15Ux?=
 =?us-ascii?Q?5ghz6MdxOh+T8XRrgONTGMHaqqlvf/eZSeY/4oV2XhDp4nJcCZZ5ukWnu0Yz?=
 =?us-ascii?Q?tgiCfOVj8D5iQlKwk9GKRbRRaclEnr1MNsJqzhskWOjsdiD3ciJllThoPe/A?=
 =?us-ascii?Q?3UqMtHBO79PiAQtXWRUixS35kk/eqZyhp7+wqs8LyB5yU70hO/DV5oPVo+nZ?=
 =?us-ascii?Q?Nu0o/sL9QMmkUPvWRbP+xt4ARkLoiXs3Fv32q5btrwr8taVUKKSAdZ0DkhvG?=
 =?us-ascii?Q?2GWxtO+OOWBCo3GCK8usevZFuhMMohtnif1DNfEWjE7zU9ummP3itEdL7QuM?=
 =?us-ascii?Q?KxmWgjZqwK2d42kNMWNa0GNN4wslWgdSXA3UrK01HV8YGTIPO547y54bkrSy?=
 =?us-ascii?Q?YC6kvXDJ3mg2uhnx89ooHi+MpAOSPIWJbMznZ1d4UdVk/k6eKV00Vrxul8V5?=
 =?us-ascii?Q?IYK+HfcEFyuCoeubU+LphBjYNbW9gknBCMt3820XNJsMRKN1F6QYJ2BA5yXz?=
 =?us-ascii?Q?u1jwnNdqaEkt7TLuKZFnzYHcC7QWJjgLKRT9dJxYwEhcT5Sv/jIzHsFQ8y7O?=
 =?us-ascii?Q?fZ3cS/MAOdv4Sp3W7/ieMJDcZJudEfbNuRfoKqu9OUBTGF8bzA2PUe4ZWUZ/?=
 =?us-ascii?Q?Ugtcw1YBQEs3FDj4amO63PPvOpKOI5TkkaA/9djwvQYmdHG6UdesdI6fnXKs?=
 =?us-ascii?Q?0pozot1BgFJeiadiYZK048U0hwZIBbDPs2vj7Cmjc/KTrMKfGCTHbxKUenAa?=
 =?us-ascii?Q?rs7vdiMvV6JatI57+U+BTrUgNxHXL4Zm56rN/zWcDY9tn18/7IIZOBH5rNUn?=
 =?us-ascii?Q?Zar+EuJdL4VufaKjGKkhq3wB9S3B8xbnYus26wXFWMCsT2tSaK0AH2a9uGX/?=
 =?us-ascii?Q?lPG3TMxIhxseL9JkuhsgrFWnxNa3yf+LHSEHiZXRk1o69sC93WXOmkwYP8Lq?=
 =?us-ascii?Q?JXXE1EaaecFAglna6/ScfbwKaS2b+EVFLdwtkIWOEFC2JqKLeaZudl8dUyte?=
 =?us-ascii?Q?wWreKrjQZc32JxweSH/2m64zJ5fYD3oz+FP05yNB/WQ5an5B4XSxGJYQ89vP?=
 =?us-ascii?Q?PEkRxLH9W3w3cLO8Ab2xDe/lTzPCgipra4+8WcgvyBfmfwusnkwPHZ4d8Vd1?=
 =?us-ascii?Q?XJYMz8JKrOC7kJtccCAjcv+UiF5FCjHdlMoXUtDe1cZhxjF2t3H4VWS/ni+w?=
 =?us-ascii?Q?dRIHTFVFM5YjwnbSoLCm0VAuOM0BARcI/vvWGGbF4l1qaCXF0w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HQYXP8cRhRhdaaJCx7U0oq5/OvhSS2pn+PSHFaX3DqLIp66XIxsoVvhgozvk?=
 =?us-ascii?Q?0lvqZsV/0HtMfjNuFVNiL83bYGEzBMUhMNYmJagmblrXguiAB9kSvBo2x8Be?=
 =?us-ascii?Q?yNZx0Vgl/iAI6dlZzYDtoREKjK2fyj2RpEKpp1mK7N1HPceyQ8ES9dhiIArO?=
 =?us-ascii?Q?i91H9LWzgkougHT8GmMVAr45BTu/A5ZYbrjxvwlmiX2exRlF/6MrFBLYl9fp?=
 =?us-ascii?Q?bYgbWd0qWVmcr7/YVBZ08hGPgqecnXNjRHOILfbkB06lkNJFTeKYaUEvSYWo?=
 =?us-ascii?Q?1Q2EqM8Wmmv+ei82L/bXolhksowiAed6FJzMzRt5+pkGusa211a87DrUZKDY?=
 =?us-ascii?Q?0sZMdNXoQ7GCZ1lnSTOP+AKnv5ozr49CoPuZdIFJJWTbSdnjkRtsea7rMbD7?=
 =?us-ascii?Q?w3cFH5nuYcng24ZBkltmPIHUN1DcLF4/Yj2KbNqt9TT/9jKazJwX4L2TYxn6?=
 =?us-ascii?Q?hF58X/5tuAdF4N0AETttQuKLvE9Obne4ORPkf3hXjYB6LqtW83yI6FOG6cnw?=
 =?us-ascii?Q?6sqm0+r22cOGS/5DCQPx8dJimCnOSoG4ipxjdamt1cbX3PFAX0AFYJMvapOB?=
 =?us-ascii?Q?E9NRqszOQ6pfcLUM9hOZNBj8egytHJjAA9iafhUB09daoZXbcFuof34eV4ZE?=
 =?us-ascii?Q?g2rkyVa5TQ8LAqxT63y7xVSO1q4K/s7avXA2/LWeEWrIDi3oEzv5jVdvJas6?=
 =?us-ascii?Q?p2PPrV/qOr+VnPta+CE0oGoqEwN2FTgLfMw61w1PCX+xxxErs2NnvoSVLuyh?=
 =?us-ascii?Q?Z2IjOAVkz7PbqxuHFXrqKQeTK2CPHJaYdYH7USnlp5+Qk7E2KUGXg3JsDUwx?=
 =?us-ascii?Q?XqNfuB67aEOH9WL6ilkXwXQsLzJA2oilUj6QuJuAFYPRPc2VuhkpjABZQfuA?=
 =?us-ascii?Q?g22saGz4h8mHCQjWJto1+O1SBnX0MxT36kVg7ltqY5UZAkWDiwpUYegBny3q?=
 =?us-ascii?Q?e+z2Sxl2aBr7U8fH8iIw5GHLB/IsEVwv0c7unhlzgeRPB1YKvJdMUIhnfYIB?=
 =?us-ascii?Q?dMoV0OkCeTBv3oU5HBxe7lL5jfdAaA53SOxC7lGCr4NpQV+kVxyX1nbi1pRx?=
 =?us-ascii?Q?79tT4+VdVgfrZecZJp/gmZp56/BL5K8UqLaH/4A0s28eokYsxFfcbK98u1gK?=
 =?us-ascii?Q?0XrvHxnicS7eiaROhuDSXNNyoSAP0j2n3B+15RMaWtYA7DzIooli7TvoUn1H?=
 =?us-ascii?Q?4Fxt+kDvIpv0kn9KjK/QyacfQ+tMYWtubSInoDQYYmpInOh5is6pPkJJJoAg?=
 =?us-ascii?Q?0WlQ3RdWewRIKU0hInYwR0xkQBuKoCvWa2UHzSBIcjVKVxd/LBEjBZmw678W?=
 =?us-ascii?Q?M4vj5d7gtcAWPkn261XR21daaXSW6QM2km6K6WwmeU2Q0fnkLWi7PKnU1EY8?=
 =?us-ascii?Q?ADZIWceBBnIjvBZiarsqxzDgeZHlAiZwxkJShVq/lhDpDVTwZnHP3XJ8uKvF?=
 =?us-ascii?Q?3nHbFvcYiDe6LXiUBzfaG+RMOGaJVnYIwMIXtLgnCBzzmHPS/dJE8XQgNK58?=
 =?us-ascii?Q?eY42JsgfbXv32BIu57hT5bR3iYRWA78pI7Hknpnpdnicj29JuK+Q/o1soUtN?=
 =?us-ascii?Q?QicXlvfTzkS18pPLsmI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b6b7b29-8aff-4707-a940-08dccc51abed
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 19:50:32.9901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gVBX5POs1Qfz/bIZ3XQvZ3LrknmAwS67tqrYBU5LHiAuYr8747vF3RvfbQvcrjkLq8vOSMgAPE6SGNrt2fdTRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10590

On Tue, Sep 03, 2024 at 02:37:39PM -0500, Bjorn Helgaas wrote:
> On Mon, Jul 29, 2024 at 04:18:11PM -0400, Frank Li wrote:
> > Since this driver has evolved to support other i.MX SoCs such as i.MX7/8/9,
> > let's rename the 'imx6' prefix to 'imx' to avoid confusion. But the driver
> > name is left unchanged to avoid breaking userspace scripts
>
> s/let's//
>
> It's not a proposal, it's what the patch *does*.
>
> s/But the driver name is left unchanged/Leave the driver name unchanged/
>
> s/scripts/scripts./ (add period)

Good capture, sorry for this error.

>
> > -#define IMX6_PCIE_FLAG_IMX6_PHY			BIT(0)
> > -#define IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE	BIT(1)
> > -#define IMX6_PCIE_FLAG_SUPPORTS_SUSPEND		BIT(2)
> > -#define IMX6_PCIE_FLAG_HAS_PHYDRV			BIT(3)
> > -#define IMX6_PCIE_FLAG_HAS_APP_RESET		BIT(4)
> > -#define IMX6_PCIE_FLAG_HAS_PHY_RESET		BIT(5)
> > -#define IMX6_PCIE_FLAG_HAS_SERDES		BIT(6)
> > -#define IMX6_PCIE_FLAG_SUPPORT_64BIT		BIT(7)
> > +#define IMX_PCIE_FLAG_IMX_PHY			BIT(0)
> > +#define IMX_PCIE_FLAG_IMX_SPEED_CHANGE	BIT(1)
> > +#define IMX_PCIE_FLAG_SUPPORTS_SUSPEND		BIT(2)
> > +#define IMX_PCIE_FLAG_HAS_PHYDRV			BIT(3)
>
> Good opportunity to fix the whitespace errors while renaming these.
> IMX_PCIE_FLAG_IMX_SPEED_CHANGE and IMX_PCIE_FLAG_HAS_PHYDRV end up
> with the wrong indentation.
>
> > -#define imx6_check_flag(pci, val)     (pci->drvdata->flags & val)
> > +#define imx_check_flag(pci, val)     (pci->drvdata->flags & val)
> >
> > -#define IMX6_PCIE_MAX_CLKS       6
> > +#define IMX_PCIE_MAX_CLKS       6
>
> Could also make these look nicer.
>
> We can touch these up, no need to repost.

Thanks.

Frank

