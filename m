Return-Path: <bpf+bounces-47126-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 790919F5043
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 17:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 282D67A5E22
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 16:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B551F76A8;
	Tue, 17 Dec 2024 15:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="I4y6Gvnx"
X-Original-To: bpf@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2063.outbound.protection.outlook.com [40.107.249.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E191F75B7;
	Tue, 17 Dec 2024 15:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734450639; cv=fail; b=XldHUfkgItcZSjU9ea/XnOTqP+AHR8RAXKZiaV3q9tq3c4HaA9x27waEPODmsJ9QkgdlUZA/vKEZZQDQbqhYSOh9nAd32zht0DnCoeO76zLYJ3r4qKvKRaMfQHK/c9DnGmqFp31lt0OL8yxxnDAG179et1HqtARDOh1ZD+kylX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734450639; c=relaxed/simple;
	bh=e7hEFl57HyyeVUY9Bwb/v4eXjAlmT17jTd/fT0Su6b8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LVfVkl5R0nW6BWFnGi+xDCRHfoIc7d3e6Jovd7uNfqrCEx1xg9JznTZmOWADnYU5CfEdJW2H6q1F6sAukRVX0+kKhFcNfuTIU8E4qC7r2ywK86ShXXtfe+YBSLVVgu2HSolgSkBOCl+QvxPa3vPKjvOUHgEGxuJ1ocF/eDHeJMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=I4y6Gvnx; arc=fail smtp.client-ip=40.107.249.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tpoE7Wee7v1XDARMQ6TbPKu6z8Sx3QyJgrPUSbQUkGaOKEtKvJwtr8dsb70XcgPtttEgMlzetK3y862AXlH3XBhDtJ7Tw5ehdRazRNR2miCFLcM7X3Ri3vQu4EDTYTUIpVgl9iFnWbJaTNToi7WV4Y0E78vTkioEfICVcq9Iy+fC2ZJB/3+2UOZsvFuQobFZDSAX2bk2SpC2zVwBTbe+G14oqDczqArYiI1Z5L8gG+EgIgWF0V9bYiZlO+cvtISvCSf/JV22bGZBNXkA3qao0kKFSpQVEHUj3qp6/RVV1pE2Q/9I3yKEhoMsOUECNSMmWslmLOUO2aglHxpt5Aew7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u0XDGucpZJw/XriDJle/NOV07+tucQOs/1sZhr0+XTk=;
 b=f/Omj/Mfx2P8+fRa6971/N3jo3zqfTjhouxLlsO1kbGh2IeY9b1jJzYQvQmYA6M8zWgqwerpQHxEX0tj0X+PgZ/3V0TF3GGGx67cooazOkxfZJiEbCUMrGZFy6+nO4NBsasaVopvSX2gFt8s8XPFjcPKvp4EF45HMM0fcWV44FL2nkHdXlhoi6f8q6jwUyYCNk+9yWiv5UmI8TJ/+Uo2EwU1TR2J4XsU8FJsmWhAC9LvDmcql02Sii9t5UsdVmsmTmQKajW7kqTxRJLAJhMfj4VgguJrPm7wzXdZkMGuTHovh3085ewsTyGRkr4xic6Pmjpe7WmBXS8nbshtNEo67w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0XDGucpZJw/XriDJle/NOV07+tucQOs/1sZhr0+XTk=;
 b=I4y6GvnxcZh7MvsEpzPCDVep+Pq44LqYu4a9WkNW6R9bvlK+mqpWRdRmWJ3Rk1DNUpJ06ODQG9iVc/VeqhS/x0+C+Nh/9WG/oQQd2YUo9/oVHc13EGNJDOvqb1QkoliOS2DQLKL8r1+cwCK4qWFA5d1XfXNRXjaqE5eoiQAAnWzVJ4g6YXkOVIea7iQXaddXYQYQj4PEJRK7d7CvWrZDJu8h46ww+qBQDKDorQaOEv9nGEZH18yUAPUWfFv+EAvyV9XzE+FX5loQ6XJGWQqRAhNdqlYVRV0+ZDNnXFrPHCDg2VjvswnWgrovjEqxSF6UnoorkhR/KWlsAQIQ4ZnlyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PAXPR04MB9123.eurprd04.prod.outlook.com (2603:10a6:102:22e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Tue, 17 Dec
 2024 15:50:34 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%4]) with mapi id 15.20.8272.005; Tue, 17 Dec 2024
 15:50:34 +0000
Date: Tue, 17 Dec 2024 10:50:22 -0500
From: Frank Li <Frank.li@nxp.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, alyssa@rosenzweig.io, bpf@vger.kernel.org,
	broonie@kernel.org, jgg@ziepe.ca, joro@8bytes.org,
	lgirdwood@gmail.com, maz@kernel.org, p.zabel@pengutronix.de,
	robin.murphy@arm.com, will@kernel.org
Subject: Re: [PATCH v8 2/2] PCI: imx6: Add IOMMU and ITS MSI support for
 i.MX95
Message-ID: <Z2GdvpzT6MOygG4W@lizhi-Precision-Tower-5810>
References: <20241210-imx95_lut-v8-0-2e730b2e5fde@nxp.com>
 <20241210-imx95_lut-v8-2-2e730b2e5fde@nxp.com>
 <Z1sTUaoA5yk9RcIc@lpieralisi>
 <Z1sdbH7N1Ly9eXc0@lizhi-Precision-Tower-5810>
 <Z1v/LCHsGOgnasuf@lpieralisi>
 <Z1xs6GkcdTg2c73F@lizhi-Precision-Tower-5810>
 <Z2FDp1zQ7JzxQKJT@lpieralisi>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z2FDp1zQ7JzxQKJT@lpieralisi>
X-ClientProxiedBy: SJ2PR07CA0013.namprd07.prod.outlook.com
 (2603:10b6:a03:505::15) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|PAXPR04MB9123:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bf170eb-0470-4b00-0048-08dd1eb28aa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Tmp3ZFZzUVVYRERUZ1V2Um0zSnhrbDFBR1o5ZDFlVjZ6VXBYUkpSZ2NyU1kx?=
 =?utf-8?B?WjNleFlGNHNRSUhzQlBqaWlINWNONElPMzM1cnZCQklwV2hqQXVNSTY2WTJz?=
 =?utf-8?B?aUYwVGVURFBxVlNEbFc3dTBRamJwNzQzMXd3a0RNSVhJZ0NaVnIvRmlJMGJN?=
 =?utf-8?B?WWpmRXFEdzRVRm92YVJRU0lRbEVPK0NPQ0dHajJQeTVSN1RLYlhId0NLVkpV?=
 =?utf-8?B?R0QyKzNoZnFJQ3hVUnpZUmdKbVlkSmZvelNDdGRjcmpWL1RDWlBUZlBUaDEy?=
 =?utf-8?B?QnV2d1dWQU0zNno1SVcyYU5MZ3praDVUOU5lUkNHRmp5bkt0MmVTekkwQ2tu?=
 =?utf-8?B?RVdRR1Y2bGQ1OGJudEhoWTJERFY2Q211NDFSTHNaak1UTDc3SWFGTlBQWEN0?=
 =?utf-8?B?VVNKNlFMdDhmUUE2ZHErMmVyRFpSd2pscFoxQ290Um9kNmxFMnpXc0JyN2lG?=
 =?utf-8?B?VmpwRmZmRVdndXFxYWV2MDhSVkFZaXRYR2pUcFViYVZCOUlmQktkZDh6ODRB?=
 =?utf-8?B?QUVBcXZwOU1weFVqREF1SjFWbVY2aVo1bXhBYXJVL2d5elV1RkNvUEZjQndj?=
 =?utf-8?B?dXB5V05menROb0w2bEJqaWxQSDIrUkdZMW9HQWF6cTFiaW81dWUrWTBOUlpD?=
 =?utf-8?B?RDNvZ3JRT2FsbUtqN25FWFRtL0c5OThHZzVmWExZS2JiWXhHYUpZV2ZTcHpm?=
 =?utf-8?B?djZOclc1d1VjVk9ObXUzM1lNUzVkYkEzNllxdXF6bkFvN0lzQTR2UU9renpG?=
 =?utf-8?B?enpkc3RuR25VM3RMSTNtTVUwRlhHM0pBc2sxM2ZBb0JJekplUXJtOTlocitT?=
 =?utf-8?B?R0FLN01PY3BPYWQ0MzBYMmcrVUEvWC9xUmVPUFZ5eE1Fa0lSK0RSbEVGemRF?=
 =?utf-8?B?d1VVTXNocW9jazd2c0tOR0VKUzhVTFVlMTJxNEFZTG1SUDZrd2lJMVdZNnRr?=
 =?utf-8?B?NHZJbjRNZ1NVNWVlYXJYRkhQQVg0VjVhNUFkaWM4ZWJDclhkYml1TXc1TVhq?=
 =?utf-8?B?RVIrdVp2R0Rqb21xbE1wMTlRUko3TEE4cEJMUWpyWW9JU2UzZUlmUXBwR2U1?=
 =?utf-8?B?Y1RLOGM1V2MxVzVqVFNTUjVwamd3ZmFEVjB5VDFqNnlOVlQ5b3dyTlpwaEsr?=
 =?utf-8?B?SWFqblJVaURBbU10OFI2aDQ1MU9IeGNLS3NObDBHRkxDcHdCVktDODhhYkdz?=
 =?utf-8?B?RGpZbkVNUGxIbGFGaVBNbkhsdjYvM0tQWklLc2Y5aEorZ3dUKzBNclNqM2lE?=
 =?utf-8?B?MVVrWmFrd0FQUktrR01KMi9hcGxwUHBqMkk1cDk2R25RM2hSS1IyeXlERlh0?=
 =?utf-8?B?MzZpaEtHQ0ZaVy9JWldoQW5GdzFaUWZwakhXeStpT1JoendvOC9OT3hrRFJl?=
 =?utf-8?B?RDRLQzJ5cXNuYzdFU09jbWdOdEgxS2lrYTV2Qk1KVDg4Q21nay9HQ0ZSa0ZQ?=
 =?utf-8?B?c1hJVjZSNUdsdlFSSGRxWDU2VVdFZzZ4K1FtYlhaR3ZYNDVUTmlyRmxaaCtN?=
 =?utf-8?B?S0FyYTc0bVBXVHNqdnpNMkR3VUkrVjlvK0lmYjVwQ1BqcS9iNitmTWVaMmVS?=
 =?utf-8?B?eXBPWEVTQ0tVb28ydGJRTm9BZmhhcjArbmlwMWRybXJWaDBaSDR0aUxDZENy?=
 =?utf-8?B?YWIrL1BIZkFtYk1IdmZ1bkFEZzlUN0VtQVNHZWtEYm53QjRNMTFHVDVZUWpI?=
 =?utf-8?B?NVhyVSszaDJxckJZOWM4U3orSmlGUVZvdXp4WXI0VFNhYk41cUppSFVUN1Vx?=
 =?utf-8?B?a2lFRjIxTVJXWVJxSkNHWSswWDhxcjJtQkpEVkhXQlBRdFkyL1Z2UTZuMi9H?=
 =?utf-8?B?WjdVaGJ5c0NlRGZNZ1c3Nm1hR084MUZscXdCT3QwMlZSZVBNV2FqNUZRTk1X?=
 =?utf-8?B?Tzk2dHJhaG5iRnJ4QjUvQzlCazAyY1VzdlErS3RaN2w5SmtWbDh6c1MzUXRa?=
 =?utf-8?Q?OFLjvuyvGIFcW3FdaF+ABhuM/jUU/X/9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDJEdzd1VSs4MUE0WFNMYjZBb1ZmOHJsbk9HVEU3aVoxV09ma252V2R1U2JQ?=
 =?utf-8?B?U3NINllZNmw3OCtkaHh4Ky82NDl4SG9PZ1JhNXlGYVJkeW5QUmJ3R0hMRUlh?=
 =?utf-8?B?NUYyOGxLdWFSaU83WEtSL3Z6djEzSE5mVmlqZURaL25ubE9XTWEyUWJqL05u?=
 =?utf-8?B?WFFMc2pxeDBVVTVZdk9idTJQYWlrU0ZEWTZGNGdSVEs1bm5NenAzdFducHB1?=
 =?utf-8?B?M3RMaVBKY0ptSldORG5BRGhkcElhWWlzcUhPMUh6N2FaNFhBbWxLVEVndDV4?=
 =?utf-8?B?Q01RQnBLWjdvcHRXVjRtcVFhN3RPdXBhTzRkYmpVMXBNNzVCTVpsMkdRQmVs?=
 =?utf-8?B?TWFvSmI5ZDh2cEM1OGIyYnVRM2VqZTgzZzM2MG50Y01qaGRtM0VETUp0QWFK?=
 =?utf-8?B?RUF4Wjkyc1RQS0lQdm5GL0FZakcwU3p4YkZuSGp3TEhSNVFUb3lSWEdwUTBo?=
 =?utf-8?B?Q083Y1lLaVlkTTBYaG5NeEU5bW1RbGJNY2dtOCt4dlh0dmpUK0JiSTlFaEJL?=
 =?utf-8?B?NkJudmVFdHkvQzZZcDJkNmVOOTV0V2JkUlUvNnUzYndXcjROMzJBZ1BnUEJV?=
 =?utf-8?B?SHJ2RGdBeUhOWTk5WjBtMVJwNmw5WkhKYkZtM25XUllaZFB1aE1ZeFYrM2E0?=
 =?utf-8?B?dEt6QnJmbEJSZG5OdCtmM0lxa1B4TkY4VUJ1TDZudnRPN3FTZFArSjZoTmpG?=
 =?utf-8?B?eVpKWnNNak1MTmdmTWEyT0p1TzZIY1lEWGJ5TXJ5ejQzcXJYbzdoUThMZFhV?=
 =?utf-8?B?VUE5V1gxbTh5TE9RRTcrZHFyb3p1ZThOeWdwSzhtejJIMUozL1l0ejVyUjBT?=
 =?utf-8?B?S2gxcHRqcW5wZktFeVp0SGtESVlBcmt6ZUxFK2NRanV3clpZb0J6QisyeVB0?=
 =?utf-8?B?Y1Ewck1FY3Fkb0NJaStPcUlVRFlocyt2ZTJ0TXNzUy9oY2tQclgwL0RobTE0?=
 =?utf-8?B?U05PTVkwN29vYllUZUFhM01rYm5nL01ZNnJxRXdzakhIc2Q4cHhoUk4yWVBW?=
 =?utf-8?B?QzFJMnIvZE95ZXFOOXZESk5KdjR2RVd5cmVlZnJrL2Y1VnNVdE9YT3BYT3BG?=
 =?utf-8?B?OUd5bDROQTVVeW5qQWFMQlpGUXgzWDE5N1dteWQwRytyOFV3RDc0REtCU1dk?=
 =?utf-8?B?SXN1UHQ0TnVFS1JwNUk0UklvcDE3QTZQUER6ZXNKaURPNktCOHUzaU1sVG5k?=
 =?utf-8?B?MGw2YTQyUVZaTDVQUWRRRXB3ZUhadWxOSEJBSDkvQ3lyQjZ5MkxQTjAyVW9u?=
 =?utf-8?B?bHhHS3ZIa2w0WktSbDNlZVhVOTQ2NUNRcXJMS1ZLT3JlL1RxNExySXppMVNp?=
 =?utf-8?B?dTE0WVhGSnc0eVE2RnFIWDJuVnV3SEpWbHdTaTNlaGlqSmtZMnRoUW41eE1J?=
 =?utf-8?B?YzlLVzE1aThOeW9ZTWdaSk44T0s0RjNqYzNnTndsOGc3eDVLeWplT2FWVzlM?=
 =?utf-8?B?aXdrOExKcnhOWDdSL1RQeWM0QmRCWVM3U2p3Vm4yUFZWdkVRSVNxZ2VRbVAr?=
 =?utf-8?B?RVFaMjJCbDJnWlowTHJzU2dlclppQ0dNelZiSGRTMksra2k3ZCswZ3BmNW5v?=
 =?utf-8?B?bVpVcXZMVGkreTErY1JNdllvTEhlMW8xL29sZW9EbDN0cW1zSDBvamYvVjR4?=
 =?utf-8?B?RHJNeU1sUTNhRmlpTFBweU5pMVE2YTMzZUx2T2NhWU5WOVh5ckpKMXo0VFZk?=
 =?utf-8?B?L3BQMldYbndrQ0ZVNFJLbk9LTE4wS2lHdmtIZnlYemlOc0dwS3FRV1E3Q3pY?=
 =?utf-8?B?WDc0N1c0MDFoT3J0dnFSN0dEVWozbmlZd00wSWF2TlZ4ZUQ2NWxjVFQ5SlRL?=
 =?utf-8?B?dlF4bjlGS21qbUkxSmVGM0pzYjVJUzZGOENWUEk5V0FtVGVYNXh4RjZwS2o4?=
 =?utf-8?B?YmJuejhtTVc1R1VmcWpXNUVuVktTNnJ0Y0xWMW1rek5mRHFFM1JSaGczSGc3?=
 =?utf-8?B?K3JYYWZLWW9GeTh1VTZad2dYQ2NIMWN6UzZMZDJ3b2s1eHFzUktSeGx4NHFy?=
 =?utf-8?B?ZmdhTEFVSk0xQ29SMTZJNUVmR1pkb3I1cmJKRUJBWDlnc2tZSmxkN3c2UUJB?=
 =?utf-8?B?U2RCVW1ZUnJUa1ptbnQ3d1NydGxJV0RYQUorREJyQkJCK2Fta0gyWDI3Q3Zx?=
 =?utf-8?Q?jnt/giOVTx2aEYjZDZAViKv8j?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bf170eb-0470-4b00-0048-08dd1eb28aa8
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 15:50:33.8994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UC1cC4hjxbOQF6yOzvAyr/q9+wo4F9oYIywLMZFpAiG3QBhtnDJIgPkE/l8QjLvDNbfnoohHgqgkSyJBDZjP9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9123

On Tue, Dec 17, 2024 at 10:25:59AM +0100, Lorenzo Pieralisi wrote:
> On Fri, Dec 13, 2024 at 12:20:40PM -0500, Frank Li wrote:
> > On Fri, Dec 13, 2024 at 10:32:28AM +0100, Lorenzo Pieralisi wrote:
> > > On Thu, Dec 12, 2024 at 12:29:16PM -0500, Frank Li wrote:
> > > > On Thu, Dec 12, 2024 at 05:46:09PM +0100, Lorenzo Pieralisi wrote:
> > > > > On Tue, Dec 10, 2024 at 05:48:59PM -0500, Frank Li wrote:
> > > > > > For the i.MX95, configuration of a LUT is necessary to convert Bus Device
> > > > > > Function (BDF) to stream IDs, which are utilized by both IOMMU and ITS.
> > > > > > This involves checking msi-map and iommu-map device tree properties to
> > > > > > ensure consistent mapping of PCI BDF to the same stream IDs. Subsequently,
> > > > > > LUT-related registers are configured. In the absence of an msi-map, the
> > > > > > built-in MSI controller is utilized as a fallback.
> > > > >
> > > > > This is wrong information. What you want to say is that if an msi-map
> > > > > isn't detected this means that the platform relies on DWC built-in
> > > > > controller for MSIs (that does not need streamIDs handling).
> > > > >
> > > > > That's quite different from what you are writing here.
> > > >
> > > > How about ?
> > > >
> > > > "If an msi-map isn't detected, platform relies on DWC built-in controller
> > > > for MSIs that does not need streamdIDs"
> > >
> > > Right. Question: what happens if DT shows that there are SMMU and/or
> > > ITS bindings/mappings but the SMMU driver and ITS driver are either not
> > > enabled or have not probed ?
> >
> > It is little bit complex.
> > iommu:
> > Case 1:
> > 	iommu{
> > 		status = "disabled"
> > 	};
> >
> > 	PCI driver normal probed. if RID is in range of iommu-map, not
> > any functional impact and harmless.
> > 	If RID is out of range of iommu-map, "false alarm" will return.
> > enable PCI EP device failure, but actually it can work without IOMMU.
>
> What does "false alarm" mean in practice ? PCI device enable fails
> but actually it should not ?

Yes, you are right. It should work without iommu. but return failure for
this case.

> That does not look like a false alarm to me.

My means:  return failure but it should work without iommu. Ideally
of_map_id() should return failure when iommu is disabled. It needs more
work for that. I think we can improve it later.

>
> >
> > Case 2:
> > 	iommu {
> > 		status = "Okay"
> > 	}
> > 	but iommu driver have not probed yet.  PCI Host bridge driver
> > should defer till iommu probed.
> >
> > Worst case is "false alarm". But this happen is very rare if DTS is
> > correct.
>
> Explain what this means.

It return failure, but it should return success if "iommu disabled" and
"RID is out of iommu-map range".

>
> > MSI:
> > case 1:
> > 	msi-controller {
> > 		status = "disabled";
> > 	}
> > 	Whole all dwc drivers will be broken.
>
> What MSI controller. Please make an effort to be precise and explain.

For example: ARM its, I use general term here because some other platform
such as RISC V have not use ARM ITS.

pcie {
	...
	msi-map= <...>
	...
}

DWC common driver will check property "msi-map". if it exist, built-in
MSI controller will skip init by history reason. That is also the another
reason why Rob don't want us to check these standard property.

Without MSI, system will failure back to INTx mode, same to no-msi=yes.
But some EP devices require MSI support.

Frank

>
> Thanks,
> Lorenzo
>
> > case 2:
> > 	msi-controller {
> > 		status = "Okay"
> > 	}
> > 	if msi driver have not probed yet, PCI Host bridge driver will
> > defer.
> >
> > Frank
> >
> > >
> > > I assume the LUT programming makes no difference (it is useless yes but
> > > should be harmless too) in this case but wanted to check with you`.
> > >
> > > Thanks,
> > > Lorenzo
> > >
> > > >
> > > > >
> > > > > >
> > > > > > Register a PCI bus callback function to handle enable_device() and
> > > > > > disable_device() operations, setting up the LUT whenever a new PCI device
> > > > > > is enabled.
> > > > > >
> > > > > > Acked-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > >
> > > > [...]
> > > >
> > > > > > +	int err_i, err_m;
> > > > > > +	u32 sid;
> > > > > > +
> > > > > > +	dev = imx_pcie->pci->dev;
> > > > > > +
> > > > > > +	target = NULL;
> > > > > > +	err_i = of_map_id(dev->of_node, rid, "iommu-map", "iommu-map-mask", &target, &sid_i);
> > > > > > +	if (target) {
> > > > > > +		of_node_put(target);
> > > > > > +	} else {
> > > > > > +		/*
> > > > > > +		 * "target == NULL && err_i == 0" means use 1:1 map RID to
> > > > >
> > > > > Is it what it means ? Or does it mean that the iommu-map property was found
> > > > > and RID is out of range ?
> > > >
> > > > yes, if this happen, sid_i will be equal to RID.
> > > >
> > > > >
> > > > > Could you point me at a sample dts for this host bridge please ?
> > > >
> > > > https://github.com/nxp-imx/linux-imx/blob/lf-6.6.y/arch/arm64/boot/dts/freescale/imx95.dtsi
> > > >
> > > > /* 0x10~0x17 stream id for pci0 */
> > > >    iommu-map = <0x000 &smmu 0x10 0x1>,
> > > >                <0x100 &smmu 0x11 0x7>;
> > > >
> > > > /* msi part */
> > > >    msi-map = <0x000 &its 0x10 0x1>,
> > > >              <0x100 &its 0x11 0x7>;
> > > >
> > > > >
> > > > > > +		 * stream ID. Hardware can't support this because stream ID
> > > > > > +		 * only 5bits
> > > > >
> > > > > It is 5 or 6 bits ? From GENMASK(5, 0) above it should be 6.
> > > >
> > > > Sorry for typo. it is 6bits.
> > > >
> > > > >
> > > > > > +		 */
> > > > > > +		err_i = -EINVAL;
> > > > > > +	}
> > > > > > +
> > > > > > +	target = NULL;
> > > > > > +	err_m = of_map_id(dev->of_node, rid, "msi-map", "msi-map-mask", &target, &sid_m);
> > > > > > +
> > > > > > +	/*
> > > > > > +	 *   err_m      target
> > > > > > +	 *	0	NULL		Use 1:1 map RID to stream ID,
> > > > >
> > > > > Again, is that what it really means ?
> > > > >
> > > > > > +	 *				Current hardware can't support it,
> > > > > > +	 *				So return -EINVAL.
> > > > > > +	 *      != 0    NULL		msi-map not exist, use built-in MSI.
> > > > >
> > > > > does not exist.
> > > > >
> > > > > > +	 *	0	!= NULL		Get correct streamID from RID.
> > > > > > +	 *	!= 0	!= NULL		Unexisted case, never happen.
> > > > >
> > > > > "Invalid combination"
> > > > >
> > > > > > +	 */
> > > > > > +	if (!err_m && !target)
> > > > > > +		return -EINVAL;
> > > > > > +	else if (target)
> > > > > > +		of_node_put(target); /* Find stream ID map entry for RID in msi-map */
> > > > > > +
> > > > > > +	/*
> > > > > > +	 * msi-map        iommu-map
> > > > > > +	 *   N                N            DWC MSI Ctrl
> > > > > > +	 *   Y                Y            ITS + SMMU, require the same sid
> > > > > > +	 *   Y                N            ITS
> > > > > > +	 *   N                Y            DWC MSI Ctrl + SMMU
> > > > > > +	 */
> > > > > > +	if (err_i && err_m)
> > > > > > +		return 0;
> > > > > > +
> > > > > > +	if (!err_i && !err_m) {
> > > > > > +		/*
> > > > > > +		 * MSI glue layer auto add 2 bits controller ID ahead of stream
> > > > >
> > > > > What's "MSI glue layer" ?
> > > >
> > > > It is common term for IC desgin, which connect IP's signal to platform with
> > > > some simple logic. Inside chip, when connect LUT output 6bit streamIDs
> > > > to MSI controller, there are 2bits hardcode controller ID information
> > > > append to 6 bits streamID.
> > > >
> > > >            Glue Layer
> > > >           <==========>
> > > > ┌─────┐                  ┌──────────┐
> > > > │ LUT │ 6bit stream ID   │          │
> > > > │     ┼─────────────────►│  MSI     │
> > > > └─────┘    2bit ctrl ID  │          │
> > > >             ┌───────────►│          │
> > > >             │            │          │
> > > >  00 PCIe0   │            │          │
> > > >  01 ENETC   │            │          │
> > > >  10 PCIe1   │            │          │
> > > >             │            └──────────┘
> > > >
> > > > >
> > > > > > +		 * ID, so mask this 2bits to get stream ID.
> > > > > > +		 * But IOMMU glue layer doesn't do that.
> > > > >
> > > > > and "IOMMU glue layer" ?
> > > >
> > > > See above.
> > > >
> > > > Frank
> > > >
> > > > >
> > > > > > +		 */
> > > > > > +		if (sid_i != (sid_m & IMX95_SID_MASK)) {
> > > > > > +			dev_err(dev, "iommu-map and msi-map entries mismatch!\n");
> > > > > > +			return -EINVAL;
> > > > > > +		}
> > > > > > +	}
> > > > > > +
> > > > > > +	sid = sid_i;
> > > > >
> > > > > err_i could be != 0 here, I understand that the end result is
> > > > > fine given how the code is written but it is misleading.
> > > > >
> > > > > 	if (!err_i)
> > > > > 	else if (!err_m)
> > > >
> > > > Okay
> > > >
> > > > >
> > > > > > +	if (!err_m)
> > > > > > +		sid = sid_m & IMX95_SID_MASK;
> > > > > > +
> > > > > > +	return imx_pcie_add_lut(imx_pcie, rid, sid);
> > > > > > +}
> > > > > > +
> > > > > > +static void imx_pcie_disable_device(struct pci_host_bridge *bridge, struct pci_dev *pdev)
> > > > > > +{
> > > > > > +	struct imx_pcie *imx_pcie;
> > > > > > +
> > > > > > +	imx_pcie = to_imx_pcie(to_dw_pcie_from_pp(bridge->sysdata));
> > > > > > +	imx_pcie_remove_lut(imx_pcie, pci_dev_id(pdev));
> > > > > > +}
> > > > > > +
> > > > > >  static int imx_pcie_host_init(struct dw_pcie_rp *pp)
> > > > > >  {
> > > > > >  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > > > > @@ -946,6 +1122,11 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
> > > > > >  		}
> > > > > >  	}
> > > > > >
> > > > > > +	if (pp->bridge && imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT)) {
> > > > > > +		pp->bridge->enable_device = imx_pcie_enable_device;
> > > > > > +		pp->bridge->disable_device = imx_pcie_disable_device;
> > > > > > +	}
> > > > > > +
> > > > > >  	imx_pcie_assert_core_reset(imx_pcie);
> > > > > >
> > > > > >  	if (imx_pcie->drvdata->init_phy)
> > > > > > @@ -1330,6 +1511,8 @@ static int imx_pcie_probe(struct platform_device *pdev)
> > > > > >  	imx_pcie->pci = pci;
> > > > > >  	imx_pcie->drvdata = of_device_get_match_data(dev);
> > > > > >
> > > > > > +	mutex_init(&imx_pcie->lock);
> > > > > > +
> > > > > >  	/* Find the PHY if one is defined, only imx7d uses it */
> > > > > >  	np = of_parse_phandle(node, "fsl,imx7d-pcie-phy", 0);
> > > > > >  	if (np) {
> > > > > > @@ -1627,7 +1810,8 @@ static const struct imx_pcie_drvdata drvdata[] = {
> > > > > >  	},
> > > > > >  	[IMX95] = {
> > > > > >  		.variant = IMX95,
> > > > > > -		.flags = IMX_PCIE_FLAG_HAS_SERDES,
> > > > > > +		.flags = IMX_PCIE_FLAG_HAS_SERDES |
> > > > > > +			 IMX_PCIE_FLAG_HAS_LUT,
> > > > > >  		.clk_names = imx8mq_clks,
> > > > > >  		.clks_cnt = ARRAY_SIZE(imx8mq_clks),
> > > > > >  		.ltssm_off = IMX95_PE0_GEN_CTRL_3,
> > > > > >
> > > > > > --
> > > > > > 2.34.1
> > > > > >

