Return-Path: <bpf+bounces-31347-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CFF8FB7F4
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 17:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6F961C208FA
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 15:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D111494DB;
	Tue,  4 Jun 2024 15:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ForJMept"
X-Original-To: bpf@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2083.outbound.protection.outlook.com [40.107.241.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753DC148840;
	Tue,  4 Jun 2024 15:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717516096; cv=fail; b=ohcNbx0aXvhCTmxP5YvXUaCrMsoPoMY93zQOBjIOeBH29R8geUl9rQfshTnoiUTRbGA2QPNYP5vRjNcs5ArAZ54rEGt3go101wQ4sXxyK94P4o8eQPRmpMJ1z1q+iMqJADrICJQdsoIvSozR/Yv4pXX2CZCUGsHWzHSjkDFJmSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717516096; c=relaxed/simple;
	bh=2NFnKCrgkq9+flKZHAJY+CTo3v1jB0tUs/+EKP0nh6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m8YBLN8vGNh9L5qteJ/s4gbDj+8QBv2DqHdEnq1ancn0P9F8ybFxf2by1Xb/ALMjarlmJMdWAnlMFnjFVj1WVDmSwSyhzZLpaHxxaiKZHIzyVLehA2ud+6cQvqK424ZWlroekzx79tjuo5aEfDL859gdZJHEoa3MrN5D33FM7JM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ForJMept; arc=fail smtp.client-ip=40.107.241.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AYeKutLBQm/nG749CdWlEvr0SLfLVt5g4WzwFNK6EV7QlVi7fjucZEP4T1fh8ZnedgfrjiDFjACgckbsJbAR3WSMcz2Xes4lUQKAwA4iJvaCUuTqaroeJrtz5SFPh+cyo9G0efpZ0DdNyCM279R72gM5JrjhIdNrZL40hrDL5mHBZOscxJwMIB5q6kAku+JIpP0ged3CGOoVrxAVAxFV422+w42JNeECnntNovgM1WwJ+gJ8DPu0DBwMbTgFB/y4r6liLZ6XChFOcAUTQoYowLzIQf++KTMj7WHDAtvdzwTNtAOK5dlr8AXGRnaT2GFfQybJ1YMf5wRFEfxuUAm9kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kB14oQywLqx6JFqGLhd7OH7RQfzwxCX35qGV5tEfRxc=;
 b=l4bo4WKWipMBddfNpoIuA0PtOMubYz+rPeU914R8nH3bo0kS+Af8UwFgbNGO6waACLLg/WPddjoZeraThvjcaor8pBVqqBlBEy5gdGwpBk/UePPlGEnx0uT40JZHmgcl/Es8zBxE84tm7TykzoUaO6ntQJbPUbzj+hg5R7ADK16vUZR8zzGUKel8sEZObfmG6hodIrUFonCdhYUtaYTXgPPN81CkGzaFFzduSqeLmzR+li/8iW8lDDE++YFqgwbwIoCHEeAi+MC+YNvCCCQTWhbCeEGj+1MW8gujcWjcYihKGEQvfWD3JU+FASoXVzaO1o8m7on5ppRrf7OurVQh/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kB14oQywLqx6JFqGLhd7OH7RQfzwxCX35qGV5tEfRxc=;
 b=ForJMeptZpqgspLhpWNxyve1GkPzNENI6nN0fxpZHt58BrzduF02yy1quEoCd//1yUaDBJ8Vv4jsxphTyGylD+wggJbbFl0vNQtMQkktMTcKT3jixNh299p0wNI52ozFmQf1VcMtWykPuw/7ihTPTquG+c4H12a/l7J3wo7U4rU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7577.eurprd04.prod.outlook.com (2603:10a6:10:206::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30; Tue, 4 Jun
 2024 15:48:11 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 15:48:10 +0000
Date: Tue, 4 Jun 2024 11:47:58 -0400
From: Frank Li <Frank.li@nxp.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Bjorn Helgaas <helgaas@kernel.org>,
	Richard Zhu <hongxing.zhu@nxp.com>,
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
	devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>
Subject: Re: [PATCH v5 08/12] PCI: imx6: Config look up table(LUT) to support
 MSI ITS and IOMMU for i.MX95
Message-ID: <Zl83LikwgjpHUZc7@lizhi-Precision-Tower-5810>
References: <20240603171921.GA685838@bhelgaas>
 <3d24fecf-1fdb-4804-9a51-d6c34a9d65c6@arm.com>
 <Zl4v10Od99et+tLX@lizhi-Precision-Tower-5810>
 <86cyowlog0.wl-maz@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86cyowlog0.wl-maz@kernel.org>
X-ClientProxiedBy: BY5PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7577:EE_
X-MS-Office365-Filtering-Correlation-Id: 538fe47a-ef27-438f-bb2d-08dc84adbc85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|1800799015|52116005|376005|7416005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aPcOu6s9XVJbNO0y7LRFO6OJ/Z9t68iBzYOpVLclt6ZGy2iyH9pFu+3URiNy?=
 =?us-ascii?Q?DYlK6fcj/Adt23U8F37fd8YsbOkLZUbf3AhJjVzh9yjy2uqi/SxW/6Rdn9Rv?=
 =?us-ascii?Q?r+ykjNnj5a02ZaNnhCGpC0T9kQfSfTUEQzZSgJ8UpC5nkOw/kXwkFpPb5ZjG?=
 =?us-ascii?Q?5NvRvar03BiMikwy1u2S+b9l4NNXcDnggkK6nHbq7Q01qLsVFij2rQ4U3oqz?=
 =?us-ascii?Q?zpvwXL6JDRckJO3xjZw/wRVceOzqa3uVCxH2nlAcq1Srd8bHvukUpVbK6S/F?=
 =?us-ascii?Q?MZ/8b2jFBoiMhdAYH0M9x2zxfcDGOrIFWTpWMXfj1aHwpELyphr6CAF/F7Fd?=
 =?us-ascii?Q?JO83i+suAgfWnkUn04MSKA7cd5X8O7LGfTHNB5bTQAkepixLf8duQNiup68l?=
 =?us-ascii?Q?x9pLi53qya6YYpHf5BthD/WKXkHLtdM8LM0bO1Cn6a/fn+KNGVwLDXSCam8O?=
 =?us-ascii?Q?IXPUqIOlm0b43RUrzVdJs17S2v2FEYaFuQ6xBifazctV84jrofqVe3ZaqWZD?=
 =?us-ascii?Q?3DsJcAKiJ6ur1S+TmYAEIrLZaTSWDXdJy3rFU4nSZOidtyBMLWHYy3VSHyYY?=
 =?us-ascii?Q?mYg8M5KmSum52zjxwtbnqWwQ0aW8WQJRqvSzg5OSUkwYrJmBc9D7Be00Zmvf?=
 =?us-ascii?Q?AFe+aPSeTzx+AWPr6ofshUP1Q5w7v4XzwCYKzBtscHbNQY1v52OUV7Hs5gmu?=
 =?us-ascii?Q?0kBSrEjNYy5cb6kiHx5bmpX0uoBZUHD/ycX2yXkcgbifOuCnxUkF52CTEI2E?=
 =?us-ascii?Q?8zob+qYjknqpEBxEg//XGI85lfqvsuskksJONbjLV172JFn0ncg07tCgvl0R?=
 =?us-ascii?Q?Frq1JD1Kmdba2TtkHfFDzPTuANP04FtN+X39rL66b43aMgE3s7KqFHLUurb/?=
 =?us-ascii?Q?BIHMpEaKhcMyBEq5O3fcemVYWeVdcH5iaPQKvOBaaVoZf7r4tqt2oeFY6+mq?=
 =?us-ascii?Q?yoSYIMzktQr+3dLbzNU35gUcVzilnHs7ZpSxveiyZlbeK7dYfrPvQlxpsPfW?=
 =?us-ascii?Q?Y8F+snZ62ffIIFzhlLUiGYKCtBCNoCwwAiuCIvyyWb/9/BAL/AKLt4AhJ6rI?=
 =?us-ascii?Q?B3biGTaLpJ+Sd77JtQ0GPAmuMMxdc1zfT97YXgZKaSg+uH54VFTtkzkFOHBi?=
 =?us-ascii?Q?veBh1zK3QVgA4QsvUa3fzJlC566AgeB6FhqkebH2CEY9JC4nABCOXorQH8UL?=
 =?us-ascii?Q?A/K7QmOkm9XUnWoyC6BCPzW+r1AgN8CNZI3xHxRoGKxwsCzeDqSy525QZ2yD?=
 =?us-ascii?Q?wJ7Q9vMiawho+OFXklGOfGEqP9H47DH9qB4KcytQO62zvsqcVEi5s/uPVfwr?=
 =?us-ascii?Q?JtIOdU//C4T5zzqWRe2RpEnOhPOsBQKNGUe0zLsUY4Z+XXVeTPlI/UkOchgy?=
 =?us-ascii?Q?+914dZ0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(52116005)(376005)(7416005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q4cJu96EVeGqW5iTwGugmMtBf64rEH62v/ZfOYopOI7MlmmRZKmVo+fbWWsx?=
 =?us-ascii?Q?DNk6+GOKL0xiyeSQVvBrhfySl+W8MudwiravWlxO3910MVQgL6MxZ4msZZpp?=
 =?us-ascii?Q?tPdklvrCy7uzkF+U4Zx/O/D/gZtGEyOJg7ZP/SMW0ZeXh0RM4+dfmttR0T+6?=
 =?us-ascii?Q?hpC+JLCzFqhwl3duIiOCvy2z4F35oenf6cKE9nc3ka0c4qdUwj87n9Ulzj9Q?=
 =?us-ascii?Q?AHt0IiB71A1JnA71lQ0VgNkNJ9jBBH3dCCwfQtuf2umP+DiWrz3EFg12/haf?=
 =?us-ascii?Q?lS/JfH/0a5Qa7wOv6mP+2A71tsVyg06NCaWrk8q0Cuy16ed2Cx9NzsLrUqxJ?=
 =?us-ascii?Q?IsYBUW50XE3+c6gwgO9fX8uXdom1C3lKvzTxjfKLgotij3tYvmiQf2VjcjY6?=
 =?us-ascii?Q?3TLuh240Ea4QeiPxVhY9tZQ6L1DewbGn+HLRfWIwQyQKRoyIv5dMdsq2xX49?=
 =?us-ascii?Q?IeImJxXqgqeFDLacT7URIstUDEXaeXpDfgn2Y6lnWfSH1CIImUvROiRQNqRA?=
 =?us-ascii?Q?iCQ8QAqPI0imdVpWG6ZFBjik5dHyV/sE/QyfHh/AoGDL+NzmsdHKcKbK89Y2?=
 =?us-ascii?Q?ik7hoI6ylaEvHH5FqOSKiTMPLix1WB37X7W4/0bLtq1acMNKX3ynHpVhO31Q?=
 =?us-ascii?Q?wBM5dcyWFeVoVOTL7ipcys8eSOSCyjWbl+5u3SnsVjYer8DwjZegFUb/O8dW?=
 =?us-ascii?Q?Uta1ZjTrCtQGbDw+cEVMun0Bvz1yjwQwyZDaPo1ysehVSqzjua8gYYPazG+2?=
 =?us-ascii?Q?uIpkX/zPgI4iMkfdzJDklBqE7/6WeOzFvNC36a43LuOXkhC9C6D7oupjHBAI?=
 =?us-ascii?Q?1PTsJs20WNL0N3d8eVwpyHSgFIhjmdn++bfsvhXDiXJ9qbj4jPgbUmejTN17?=
 =?us-ascii?Q?+Io56xU+U7k/tFzBWAYWsaB5aVUbPswcf7x8kVb03pEcqVyIyoM2u4r5m1oO?=
 =?us-ascii?Q?BRLU1PmKl/Kft10UwsuF44WZxqtHbAb/U6irEgXYBT0Q7oqTVUfT+PIHMzcK?=
 =?us-ascii?Q?bLCl9B+c9Vlb8BnoEt4uK6WuvRmEWcpXX4nGgq37sgOT//EDrFKSXTfbA/gl?=
 =?us-ascii?Q?SHlvsvHEDhpsmO7Q6qmfqYy0a7g3pn75uSO9cHxz0jNNGMDWAWVM1hxSt63S?=
 =?us-ascii?Q?kVek2e/vBsCL/l93B4+DkyWiKcfh7HerLgrRgjZQTqR9AV9ZbBHkgH2EJEsn?=
 =?us-ascii?Q?UFG0hyJOO7eMiARGi527/8leFq9M3Uo6MZgEzAYn1BcX5Hq+73Vh1xR4ckPC?=
 =?us-ascii?Q?E4D1gJ4e4h5gNIOvNzAquQX6uIrFYGFM85/oMsan4ckA6pMC/KjhDYkHJ5fN?=
 =?us-ascii?Q?TJgaexOWULOx0PWwJ91kYdE+qSD/+hilrOAscNnrwd+APGKa4CWZjVQk1gZP?=
 =?us-ascii?Q?sB0Q8GNdzrksze0dFeZUtPU3VoGtmTdyOWnp5B4L6lz9aKGGpHOexL/O7Ka0?=
 =?us-ascii?Q?3CT8lZU7Yx+uALXg4S+3anEqCEUUPjZ8cgoflHA8bHVTM1aSNyIY26AHVyRx?=
 =?us-ascii?Q?v1svyF5dS24ohm9EP33C4dh7X6qrsJmgVKazcsmC/H62tLWaALrfCRmNimyK?=
 =?us-ascii?Q?FbrXBobluECxTFmH3ek=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 538fe47a-ef27-438f-bb2d-08dc84adbc85
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 15:48:10.8507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2JMOaqqdiBZ0D1CR1Du0aX5BQxEvydyhBN3PZTUU67F4twhr9QiKJkRDIOIwkm3tFdzs836CXuhiJhV2At+cDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7577

On Tue, Jun 04, 2024 at 04:25:51PM +0100, Marc Zyngier wrote:
> On Mon, 03 Jun 2024 22:04:23 +0100,
> Frank Li <Frank.li@nxp.com> wrote:
> > 
> > iommu may share one stream id for multi-devices. but ITS MSI can't. each
> > device's MSI index start from 0. It needs difference stream id for each
> > device.
> 
> That's not quite true. We go through all sort of hoops to find about
> device aliasing on PCI and allow devices that translate into the same
> DID to get MSIs.

Could you please point me the code location? I remember I met error when I
try to enable MSI for EP support one year ago.

https://lore.kernel.org/imx/20221124055036.1630573-1-Frank.Li@nxp.com/

I remember that it is failure try to allocate more irqs with the same DID. 

Frank

> 
> Of course, just like the IOMMU, you lose any form of isolation, but
> you get what you pay for.

Anyways, if there are one quirk in PCI system, bridge driver can detect
PCI devices add/remove. it will be better if assign stream ID as need,
compared with static allocate.

> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.

