Return-Path: <bpf+bounces-43865-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB399BAAC9
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 03:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43E271F21D1F
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 02:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17B516C695;
	Mon,  4 Nov 2024 02:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VZrsG8Q5"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2083.outbound.protection.outlook.com [40.107.20.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82877603F;
	Mon,  4 Nov 2024 02:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730687140; cv=fail; b=TfbQWL+wBr/CRUGvQM8fjShi+n4sOLXdfV77jweRJ/tXfZ9Q1Ujsm58CeOgcwjKOdRbiNewxo5eLuZMW78SqOrqAsMtuLGSAUx52dh81SUKyxBR9Wyay0tITTPvruNLVu0i8yOLPQFUFRdKVvrUWpYiQ73vZavGAXpGKOYY0HpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730687140; c=relaxed/simple;
	bh=uKy4jDBDPk6BDFl5qe9QA9++oL5JbId+I5aNwvcgDxw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ToVKhTlPb5Pr7qwGo1Y8cPmye2TqCQodxXl3ax7jDTRsPmByli8gLA7njM4L9EH4IX3CHt6vWCUNY+BBrSrUl4RmdZSuGpoQzn5V9hE+fg/i3Ar6sKwJav0sKpj0U/1liW+F8aVkFFTxqOk3I9gH7HOnzoBBbDxoe1UMELNkMdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VZrsG8Q5; arc=fail smtp.client-ip=40.107.20.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pVX50IECDwn1AG9tg6s3jArC7QBMyptg+7RvvRg8ziP5C3CnqqGT49TdU/VAFvuQczrOP2XO1YZVauNVnZCfIfFqQvojxBBStXByG+vOlA6ABNsfx6QBb5naL5haVPc3SIJbrO4ZINRo+CruXLMddsat26QMd8XK+sAu8MC4/OAD5IjABE4EXK3LeLA5mAmh+Qx+Cs5WQ2Jckr8/1cMNQKxWUnJT1d6xkYgHTglThM6uP3xcv/QUdmrDtqH//KjvJ66gXLwJlAqBJibBZD/H2D7MIYyEwv7d3eJLrq8t5tx46yLbv7jUDIH5HoZkJ1UsordQInXhgVYE0c8omct0zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uKy4jDBDPk6BDFl5qe9QA9++oL5JbId+I5aNwvcgDxw=;
 b=KoUx4ZC2UHgh+eoz4u+5JV3oi8x6Ojoj7hgH9sXv1UhbP69z4q6IrZIfZU6lnfP6SKWTtAy9bXrnl4zZMA869Bv05otmCoPKU6uEpCaOB9ULzE7GesArXZzUkzgezXQAVk+Rq7LzUIWQ76bokX3laog3YCi/2zNMqR1NVtZ/MZiSmOeDay/ROc0kh+pazD0pCnhWRrHYQM4i0eNByD/2SCb8vrnpBmMLfb2B/UtIpdk7C9Ix/cD6IOxErZzK3+uvzC5ztS8oaLrdH0ubA9Szl8oLdaO2zQGayBF6SKscOhS9+h/vxFpxq6/eqc6SPhy1H+yhXZyfjCS3wDnslAPeEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKy4jDBDPk6BDFl5qe9QA9++oL5JbId+I5aNwvcgDxw=;
 b=VZrsG8Q5LcSMRRaOvNAmMAPopgBzHlWdGZXeuJ2K8KjIlxB3semFYUH9vCSmbOlpdH/lYxmxRu8Hcr8/0iqodkJ6kZIDy7vsXVqI0HbacI5NBCa4Tj9LmgJ/uzVnI5qjkCl5B9G8dWaw12Sr13GYSdeet59Udy+dEtyguz4Zjc/hSZrRyNCaCHbOtkqucUuXoalHgc7FSNxE8BdPhwMF65E9gP+iteGbYGENyJpLhQMANzVgB0Y3vsdwTqY69s8l2DyhA6lVcujNQ5tvyCHBg7EVY7HRAS6puBiHEAMTeUAMZaR3j3GgTKcnIaxpGmmGSTaRFf5chNS/T5A2JXQ7qA==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PAWPR04MB10007.eurprd04.prod.outlook.com (2603:10a6:102:387::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Mon, 4 Nov
 2024 02:25:34 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%6]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 02:25:34 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Frank Li <frank.li@nxp.com>, Bjorn Helgaas <bhelgaas@google.com>, Lucas
 Stach <l.stach@pengutronix.de>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kw@linux.com>, Manivannan
 Sadhasivam <manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "alyssa@rosenzweig.io" <alyssa@rosenzweig.io>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "broonie@kernel.org"
	<broonie@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "joro@8bytes.org"
	<joro@8bytes.org>, "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"lgirdwood@gmail.com" <lgirdwood@gmail.com>, "maz@kernel.org"
	<maz@kernel.org>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "will@kernel.org"
	<will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: RE: [PATCH v4 2/2] PCI: imx6: Add IOMMU and ITS MSI support for
 i.MX95
Thread-Topic: [PATCH v4 2/2] PCI: imx6: Add IOMMU and ITS MSI support for
 i.MX95
Thread-Index: AQHbLKG8879Aeg02bUGYrBQu77yDI7KmaDZg
Date: Mon, 4 Nov 2024 02:25:34 +0000
Message-ID:
 <AS8PR04MB86762A9082F41E05547A9D908C512@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20241101-imx95_lut-v4-0-0fdf9a2fe754@nxp.com>
 <20241101-imx95_lut-v4-2-0fdf9a2fe754@nxp.com>
In-Reply-To: <20241101-imx95_lut-v4-2-0fdf9a2fe754@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|PAWPR04MB10007:EE_
x-ms-office365-filtering-correlation-id: 98032cde-c88e-43f0-ebd8-08dcfc77f665
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?S2Q4OExON2pYUVF2clMwZkRVanBQSDAzTkl3RlcxcVBSVWdMbU5qRDFrcUgv?=
 =?utf-8?B?eVVWOXFvRTlyUk5heFBiS0tSQU5NVnlKN0ZpSHJHWjRRbWRqekdydndqNVJY?=
 =?utf-8?B?a3dERm1LUVh5RmpqMG83VEkrMU9RUktSQWcwbVI5TkRtVU1VTWtvYldPVm9H?=
 =?utf-8?B?SG9pNUd4dTJjakwweWtvSTNZRnNHdlIwVkRYenUvT3JCV3IyUXRkMEhhT0tL?=
 =?utf-8?B?RGZVVTFXbXJrOWVVanZ0WVQrcHp6VHBvS0cvS0t4Wm9UY0xieFR0UHlSK1FD?=
 =?utf-8?B?R2g3RnUvVTNocHlLQzhOL2VLY3R1OExmc2d4UVQyYVRWSGMvVlVPSkw0QVBS?=
 =?utf-8?B?VGJja0FHbWpZNzNLNURkZGt4ZlBKRkRYZVcrVUxLNXoydTcreFJma0Vja1FQ?=
 =?utf-8?B?S09seGwzME5PdTd3QVhiWlhRTnBOUW5SQkxYbEpDS3pPUnNjSSsrbGdJVDR1?=
 =?utf-8?B?QjFWWWNZckxRNjM0VnJRc0JwU0ExMk9wWmVCMDRQMGs1NStrVEIzQ0pURVJo?=
 =?utf-8?B?WXRSMXRZYnRGaDZMUkd2MjZYQTRhWVMyRnJadXJ3YTZXOExTMnRONDNDSXZW?=
 =?utf-8?B?VkkzQ1J1S0RxWTA1T2x2eDhTSGVvSnJ6MG1zRS9melhkNXQzbitpV2dvQU9q?=
 =?utf-8?B?WTdJd2lONU9XYXRFaHBKL2RCUEhPYW5FTDZ6TUw3bE1TWk40NFNYZzFDdHZh?=
 =?utf-8?B?QVdwZkRLV0JkM2JJQXY0cm5aUGNCR2ZqeGNZa29ndFBOUk5IN01aY1ZaOHZl?=
 =?utf-8?B?cXpnTDNYNGFQZFlQS3FmOEpPRGR6S0N1eWZ1bmdnMDFIRWFaSTQ0cUx6cTEy?=
 =?utf-8?B?SENOU0FTdlpPRWZGWnZWN1FkYnBpeTZZVlV3bmszb1JXTlo0MlJId0l0aU9G?=
 =?utf-8?B?Q3lFL2lndG5sTS8vTlA5bjNuOXQ4a3dyeFJDSXlpNEdYaDU3ekQ1MzhPMVlH?=
 =?utf-8?B?UVV3NGVEbndYTHMrOXpTRlBVOW9TbVJsOE16bTBIQ0NSSUlYMG1hQUNtbU1k?=
 =?utf-8?B?MENlNnlZQ0VLcnBJTTVOMnd6NkdGWUs3ZkFCeS96OFNTb2FpcUtDeTBWN291?=
 =?utf-8?B?alNwY1NNVUQxRWdBYVBQTE1sbmhIVy92NHlLWnhKV3hSVnhURmsvVFl2UnBI?=
 =?utf-8?B?OXZUUTF3UUVDbHNFclZjcDUxVi95RXVYVWhlQUFlZWJJQ3NZOEVOWmhkTEND?=
 =?utf-8?B?QXNxSHZFVzNhT3J4QkhrV0lmYXNnTW42cEk0bjlTT2ZLbnF1aE9VenpwL01y?=
 =?utf-8?B?S0dzeDkvSUdCekE0THZ2TVJZalRyNGxwekFFdEpmc3dJd21CSHBNbFVxY3RB?=
 =?utf-8?B?SFJmRnFVNEtqTlVRNFZEeFJFTFUzeTRLZHVMNXhxcVVtWGd4enN3TC9JZFFT?=
 =?utf-8?B?Yk1QbFFla3I3UCtadk01UWlXUERsaGhjZThET3lmdWd2SGtOWWxuc0dyckgw?=
 =?utf-8?B?YTB1SjhBSW8xSTU5V0JXLzk4RVRHZXBZejF4Z1VacnFvbVphcERLc0ljYkNN?=
 =?utf-8?B?NTVVSHFGMFg4VDZRdlQ1SGJrWnZESnhsaEIxMlgrdEY4L2orUWlManpPZFU3?=
 =?utf-8?B?MUtRT3BRaTdLZ2RRVWlOTkE1Rm4zT1hkbVh5cEMrR09aTVBZSWkvd2E2VUJu?=
 =?utf-8?B?ZDJwWmQrVUEvQVQ0bk93cFY4aFdjTk1HTG5nMEZwU0pWTjlHVjZOQ0pMaUo4?=
 =?utf-8?B?VThNYmZzc1k3K0VmUXhHd1NyODZ5b2ttZ2FvZmlGbWRDUE1NR3BOKy9FVmtt?=
 =?utf-8?B?REEvTkFkOHBKbkx5N0J2OUVreWZ1TmtHM3dTMGdxSEYxZ1BUa3RrUGtJNG9E?=
 =?utf-8?B?S0JOejd1UXdIMVNsVXJVSWt0Y2NyNVFNSFk1eU9ualJIQ3BrYnZyeXplOXZs?=
 =?utf-8?Q?/tILtyLNAoLWX?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VE9YNjJsL1ZzM05Hc0dJaTJ0WkM1R3pabGprR3NtZm5uUVdibVYzU0kyYmY3?=
 =?utf-8?B?NENGNGd1dk1RM2U3WUlOTmcvR2M0RUdVR1hpWkxXR3pFUWhhdnBzeXRWWXAy?=
 =?utf-8?B?MDRRYTJXY2hCcXdYQmZ5dVdhZDVPT0lnMzZJZDM0cnU1TUJjem11SHE1Nko2?=
 =?utf-8?B?WjRMazhEdHl2TDlWUHNkWnRTMDBPMTZiYkgxUFdsZFlqekFJTm1yWjN2c0FT?=
 =?utf-8?B?YWtCM0Z1U2ZWclZoYlVTU1Q3cUVzUEcxeXQ1TG00SkVWN2NXQjAzaVVVUDlU?=
 =?utf-8?B?RlZrMnFpY202c3FGem5mcjNQUHd5TkVHd2xmYVZoRlpiZmllcXRjTDdPSkpw?=
 =?utf-8?B?VVdOSVJ4M0d3YnViSFl5MStHR3U5M2RQMUMwY0xUNkxPeFEvTE41Qml1bnlt?=
 =?utf-8?B?ZWVub1UrOVI5OTB0c0dJZm1yRXNDNTRIakZGS3d1VHRLOUE5SEIvTXkzZkQ3?=
 =?utf-8?B?TldIOTBYTUtUMlVMaTJtNWR3TzZxNUw5aHVqejZGZ1duNFBkVE1YS0ZtVElE?=
 =?utf-8?B?c01BSlVRSW1jbmE2UU90aGtkeHhKeVBnQ1NGdUZZTmZMdjZEODZ2TStQRDJG?=
 =?utf-8?B?NXo4ZHpQWTArWXFWZUtDdVEra0Y5NDVBU0h1MWpUU25XM1FpbGU5RjVqMDVP?=
 =?utf-8?B?UU4yRE8wREZ2aTdCT1BEYWZxczJIRklrZ256Y0FYMGNKRC9MZWZ6WlZ4dW9q?=
 =?utf-8?B?eDl2NlFGY3ZzTFBORXNyc0xlR2c1ZkpoN2FINDlXWnluSkF3U2h3bzgreWFj?=
 =?utf-8?B?Y0hNSGhFNjNtTTc4Z0QyU3JiQXJMVFBqNTUrRmdUYkdMTkhvM3lsc0pYUUtT?=
 =?utf-8?B?aXpPRVczQzMrSENCOXN6S2VzWlpOSjErc1hsSVpBR0lyTEhOdThIVW9RdWty?=
 =?utf-8?B?SGFrY3BpeWRJNGsyaHpkRHJPT2ZiSjhsUGJ6ODlwWTFzbHdjSTY3VFpWbEhL?=
 =?utf-8?B?N2t2QnQvdlB0SThNYllYQTRnSmdYUWsxZEk1blQ3UHB2M0VKUXU1NWRJeUpT?=
 =?utf-8?B?UEx3bEJ1YkpGUklteDBhY0Z2MkQ4b2NmVXdBV2NQN3huNWJYcU0yTTRzUG4w?=
 =?utf-8?B?Z2dnRzMxd0dBbTlKcFhSSmpxRXp3bm8rU3hXTW04eUVoRTB6UHRjUTdXV3c2?=
 =?utf-8?B?cHJPSHppak5pdTR5RzJxUHp4a0J1UkZHMFlFcUgvMm00cHVkemNuc2p6M0xB?=
 =?utf-8?B?bW5SUjhIYlk4OER3N0pEOFlJY0w1R1lIditjNG5hRzJNbUtFWDhrWUdPWitG?=
 =?utf-8?B?clN0YjVLK2VLbjdna3prOVJDNWRxUDdheGxoL0lZUnhQclVKMTlMNmkvcXU4?=
 =?utf-8?B?ZURURkcrZ0gzL1BSbU96bHhaMDhjcjF1MEsyOWJFbm9WVVNlaFNpOWZXY1Nj?=
 =?utf-8?B?T3BMQytZb2NGR0Jjck1ydmpnNUhPTDhESW9rejUvWkNkTUFzMTNhVXNWbHlm?=
 =?utf-8?B?SmlhaXVKRlUzSGRHUHhNak51ZW9BYkxjd0NqVEorQlM0Tytrb09Va2F6UTRY?=
 =?utf-8?B?aGZ4eHAxZ0FqYkxJKzVpM1BkZVh1QXZNbU9wdXdMM0FQRG5XV2R5WFN4WkNQ?=
 =?utf-8?B?NVRWQ2llQ2puYlNsc2pFMy8vdlYvVE0wZ2hOS1lKdktDdG9kL0NqbGpwR08z?=
 =?utf-8?B?UFcvSnVvTkFyUmdSZjZDRGxhVUV2WWRqUnhoQ3lhY1BKRTdNbXBMM0o3SW5F?=
 =?utf-8?B?UzllWnlNZ3NzNFY5dFVjbHNUeGRuUVg2VFVDdkFjYk1icVZpWE1iQTFXQUdS?=
 =?utf-8?B?aDFmeVYzb3BsdnNTbDdmSC81WUp3b3NhQUFVNVpucStzVmorUDVmcFFLMGJz?=
 =?utf-8?B?cUVFNHYvVUdzL0RLRldORTBFZEhycWkyY2dudGZFWEVqc1pTNDFncmd0MEFG?=
 =?utf-8?B?cHYzZ21MNlNYWDZiQy8vS3dFTXdaOERlTEZMdGlqem1mTjZJWjZSeEE4YXY4?=
 =?utf-8?B?M2hrbmhzRWdFMWh3K256QXFQVGdROVQvV0t2MkExNWJkWHZ3bnA0citwZHYz?=
 =?utf-8?B?dmZFeENCMHZhampMTzA1MUlHVEFZSjFsV0pDSndrRXNnN2s5RjJMU3gvUGFq?=
 =?utf-8?B?eU14ZkVxTjlJaEtPOVJVQkJYczNqZ1E5a2xwUklKNDRLTEhLL21BRzl5aEl0?=
 =?utf-8?Q?eqZ+Nl5d84cQu3U7YjT9fDmfI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98032cde-c88e-43f0-ebd8-08dcfc77f665
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2024 02:25:34.4580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oznxAtPSu3YMikO3Mx86rp8wvl7gOv79+08kOjNg24gAdBzSGezyMVND2mQEc3VAtk0q/bbrTaSgOvo32sqqtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10007

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGcmFuayBMaSA8ZnJhbmsubGlA
bnhwLmNvbT4NCj4gU2VudDogMjAyNOW5tDEx5pyIMuaXpSA1OjA1DQo+IFRvOiBCam9ybiBIZWxn
YWFzIDxiaGVsZ2Fhc0Bnb29nbGUuY29tPjsgSG9uZ3hpbmcgWmh1DQo+IDxob25neGluZy56aHVA
bnhwLmNvbT47IEx1Y2FzIFN0YWNoIDxsLnN0YWNoQHBlbmd1dHJvbml4LmRlPjsgTG9yZW56bw0K
PiBQaWVyYWxpc2kgPGxwaWVyYWxpc2lAa2VybmVsLm9yZz47IEtyenlzenRvZiBXaWxjennFhHNr
aSA8a3dAbGludXguY29tPjsNCj4gTWFuaXZhbm5hbiBTYWRoYXNpdmFtIDxtYW5pdmFubmFuLnNh
ZGhhc2l2YW1AbGluYXJvLm9yZz47IFJvYiBIZXJyaW5nDQo+IDxyb2JoQGtlcm5lbC5vcmc+OyBT
aGF3biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+OyBTYXNjaGEgSGF1ZXINCj4gPHMuaGF1ZXJA
cGVuZ3V0cm9uaXguZGU+OyBQZW5ndXRyb25peCBLZXJuZWwgVGVhbQ0KPiA8a2VybmVsQHBlbmd1
dHJvbml4LmRlPjsgRmFiaW8gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPg0KPiBDYzogbGlu
dXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4g
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBpbXhAbGlzdHMubGludXguZGV2
OyBGcmFuayBMaQ0KPiA8ZnJhbmsubGlAbnhwLmNvbT47IGFseXNzYUByb3Nlbnp3ZWlnLmlvOyBi
cGZAdmdlci5rZXJuZWwub3JnOw0KPiBicm9vbmllQGtlcm5lbC5vcmc7IGpnZ0B6aWVwZS5jYTsg
am9yb0A4Ynl0ZXMub3JnOyBsLnN0YWNoQHBlbmd1dHJvbml4LmRlOw0KPiBsZ2lyZHdvb2RAZ21h
aWwuY29tOyBtYXpAa2VybmVsLm9yZzsgcC56YWJlbEBwZW5ndXRyb25peC5kZTsNCj4gcm9iaW4u
bXVycGh5QGFybS5jb207IHdpbGxAa2VybmVsLm9yZzsgUm9iaW4gTXVycGh5DQo+IDxyb2Jpbi5t
dXJwaHlAYXJtLmNvbT47IEZyYW5rIExpIDxmcmFuay5saUBueHAuY29tPg0KPiBTdWJqZWN0OiBb
UEFUQ0ggdjQgMi8yXSBQQ0k6IGlteDY6IEFkZCBJT01NVSBhbmQgSVRTIE1TSSBzdXBwb3J0IGZv
cg0KPiBpLk1YOTUNCj4gDQo+IEZvciB0aGUgaS5NWDk1LCBjb25maWd1cmF0aW9uIG9mIGEgTFVU
IGlzIG5lY2Vzc2FyeSB0byBjb252ZXJ0IEJ1cyBEZXZpY2UNCj4gRnVuY3Rpb24gKEJERikgdG8g
c3RyZWFtIElEcywgd2hpY2ggYXJlIHV0aWxpemVkIGJ5IGJvdGggSU9NTVUgYW5kIElUUy4NCj4g
VGhpcyBpbnZvbHZlcyBleGFtaW5pbmcgdGhlIG1zaS1tYXAgYW5kIHNtbXUtbWFwIHRvIGVuc3Vy
ZSBjb25zaXN0ZW50DQo+IG1hcHBpbmcgb2YgUENJIEJERiB0byB0aGUgc2FtZSBzdHJlYW0gSURz
LiBTdWJzZXF1ZW50bHksIExVVC1yZWxhdGVkDQo+IHJlZ2lzdGVycyBhcmUgY29uZmlndXJlZC4g
SW4gdGhlIGFic2VuY2Ugb2YgYW4gbXNpLW1hcCwgdGhlIGJ1aWx0LWluIE1TSQ0KPiBjb250cm9s
bGVyIGlzIHV0aWxpemVkIGFzIGEgZmFsbGJhY2suDQo+IA0KPiBBZGRpdGlvbmFsbHksIHJlZ2lz
dGVyIGEgUENJIGJ1cyBjYWxsYmFjayBmdW5jdGlvbiBlbmFibGVfZGV2aWNlKCkgYW5kDQo+IGRp
c2FibGVfZGV2aWNlKCkgdG8gY29uZmlnIExVVCB3aGVuIGVuYWJsZSBhIG5ldyBQQ0kgZGV2aWNl
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRnJhbmsgTGkgPEZyYW5rLkxpQG54cC5jb20+DQpBY2tl
ZC1ieTogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KDQpCZXN0IFJlZ2FyZHMN
ClJpY2hhcmQgWmh1DQo+IC0tLQ0KPiBDaGFuZ2UgZnJvbSB2MyB0byB2NA0KPiAtIENoZWNrIHRh
cmdldCB2YWx1ZSBhdCBvZl9tYXBfaWQoKS4NCj4gLSBvZl9ub2RlX3B1dCgpIGZvciB0YXJnZXQu
DQo+IC0gYWRkIGNhc2UgZm9yIG1zaS1tYXAgZXhpc3QsIGJ1dCByaWQgZW50cnkgaXMgbm90IGV4
aXN0Lg0KPiANCj4gQ2hhbmdlIGZyb20gdjIgdG8gdjMNCj4gLSBVc2UgdGhlICJ0YXJnZXQiIGFy
Z3VtZW50IG9mIG9mX21hcF9pZCgpDQo+IC0gQ2hlY2sgaWYgcmlkIGFscmVhZHkgaW4gbHV0IHRh
YmxlIHdoZW4gZW5hYmxlIGRldmljZQ0KPiANCj4gY2hhbmdlIGZyb20gdjEgdG8gdjINCj4gLSBz
ZXQgY2FsbGJhY2sgdG8gcGNpX2hvc3RfYnJpZGdlIGluc3RlYWQgcGNpLT5vcHMuDQo+IC0tLQ0K
PiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYyB8IDE3Nw0KPiArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTc2IGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9j
b250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2Mv
cGNpLWlteDYuYw0KPiBpbmRleCA5NGYzNDExMzUyYmYwLi4xYmUxN2JjMzljZTU0IDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ICsrKyBiL2Ry
aXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gQEAgLTU1LDYgKzU1LDIyIEBA
DQo+ICAjZGVmaW5lIElNWDk1X1BFMF9HRU5fQ1RSTF8zCQkJMHgxMDU4DQo+ICAjZGVmaW5lIElN
WDk1X1BDSUVfTFRTU01fRU4JCQlCSVQoMCkNCj4gDQo+ICsjZGVmaW5lIElNWDk1X1BFMF9MVVRf
QUNTQ1RSTAkJCTB4MTAwOA0KPiArI2RlZmluZSBJTVg5NV9QRU9fTFVUX1JXQQkJCUJJVCgxNikN
Cj4gKyNkZWZpbmUgSU1YOTVfUEUwX0xVVF9FTkxPQwkJCUdFTk1BU0soNCwgMCkNCj4gKw0KPiAr
I2RlZmluZSBJTVg5NV9QRTBfTFVUX0RBVEExCQkJMHgxMDBjDQo+ICsjZGVmaW5lIElNWDk1X1BF
MF9MVVRfVkxECQkJQklUKDMxKQ0KPiArI2RlZmluZSBJTVg5NV9QRTBfTFVUX0RBQ19JRAkJCUdF
Tk1BU0soMTAsIDgpDQo+ICsjZGVmaW5lIElNWDk1X1BFMF9MVVRfU1RSRUFNX0lECQkJR0VOTUFT
Syg1LCAwKQ0KPiArDQo+ICsjZGVmaW5lIElNWDk1X1BFMF9MVVRfREFUQTIJCQkweDEwMTANCj4g
KyNkZWZpbmUgSU1YOTVfUEUwX0xVVF9SRVFJRAkJCUdFTk1BU0soMzEsIDE2KQ0KPiArI2RlZmlu
ZSBJTVg5NV9QRTBfTFVUX01BU0sJCQlHRU5NQVNLKDE1LCAwKQ0KPiArDQo+ICsjZGVmaW5lIElN
WDk1X1NJRF9NQVNLCQkJCUdFTk1BU0soNSwgMCkNCj4gKyNkZWZpbmUgSU1YOTVfTUFYX0xVVAkJ
CQkzMg0KPiArDQo+ICAjZGVmaW5lIHRvX2lteF9wY2llKHgpCWRldl9nZXRfZHJ2ZGF0YSgoeCkt
PmRldikNCj4gDQo+ICBlbnVtIGlteF9wY2llX3ZhcmlhbnRzIHsNCj4gQEAgLTgyLDYgKzk4LDcg
QEAgZW51bSBpbXhfcGNpZV92YXJpYW50cyB7DQo+ICAjZGVmaW5lIElNWF9QQ0lFX0ZMQUdfSEFT
X1BIWV9SRVNFVAkJQklUKDUpDQo+ICAjZGVmaW5lIElNWF9QQ0lFX0ZMQUdfSEFTX1NFUkRFUwkJ
QklUKDYpDQo+ICAjZGVmaW5lIElNWF9QQ0lFX0ZMQUdfU1VQUE9SVF82NEJJVAkJQklUKDcpDQo+
ICsjZGVmaW5lIElNWF9QQ0lFX0ZMQUdfSEFTX0xVVAkJCUJJVCg4KQ0KPiANCj4gICNkZWZpbmUg
aW14X2NoZWNrX2ZsYWcocGNpLCB2YWwpCShwY2ktPmRydmRhdGEtPmZsYWdzICYgdmFsKQ0KPiAN
Cj4gQEAgLTEzNCw2ICsxNTEsNyBAQCBzdHJ1Y3QgaW14X3BjaWUgew0KPiAgCXN0cnVjdCBkZXZp
Y2UJCSpwZF9wY2llX3BoeTsNCj4gIAlzdHJ1Y3QgcGh5CQkqcGh5Ow0KPiAgCWNvbnN0IHN0cnVj
dCBpbXhfcGNpZV9kcnZkYXRhICpkcnZkYXRhOw0KPiArCXN0cnVjdCBtdXRleAkJbG9jazsNCj4g
IH07DQo+IA0KPiAgLyogUGFyYW1ldGVycyBmb3IgdGhlIHdhaXRpbmcgZm9yIFBDSWUgUEhZIFBM
TCB0byBsb2NrIG9uIGkuTVg3ICovIEBADQo+IC05MjUsNiArOTQzLDE1NSBAQCBzdGF0aWMgdm9p
ZCBpbXhfcGNpZV9zdG9wX2xpbmsoc3RydWN0IGR3X3BjaWUgKnBjaSkNCj4gIAlpbXhfcGNpZV9s
dHNzbV9kaXNhYmxlKGRldik7DQo+ICB9DQo+IA0KPiArc3RhdGljIGludCBpbXhfcGNpZV9hZGRf
bHV0KHN0cnVjdCBpbXhfcGNpZSAqaW14X3BjaWUsIHUxNiByZXFpZCwgdTgNCj4gK3NpZCkgew0K
PiArCXN0cnVjdCBkd19wY2llICpwY2kgPSBpbXhfcGNpZS0+cGNpOw0KPiArCXN0cnVjdCBkZXZp
Y2UgKmRldiA9IHBjaS0+ZGV2Ow0KPiArCXUzMiBkYXRhMSwgZGF0YTI7DQo+ICsJaW50IGk7DQo+
ICsNCj4gKwlpZiAoc2lkID49IDY0KSB7DQo+ICsJCWRldl9lcnIoZGV2LCAiSW52YWxpZCBTSUQg
Zm9yIGluZGV4ICVkXG4iLCBzaWQpOw0KPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gKwl9DQo+ICsN
Cj4gKwlndWFyZChtdXRleCkoJmlteF9wY2llLT5sb2NrKTsNCj4gKw0KPiArCWZvciAoaSA9IDA7
IGkgPCBJTVg5NV9NQVhfTFVUOyBpKyspIHsNCj4gKwkJcmVnbWFwX3dyaXRlKGlteF9wY2llLT5p
b211eGNfZ3ByLCBJTVg5NV9QRTBfTFVUX0FDU0NUUkwsDQo+IElNWDk1X1BFT19MVVRfUldBIHwg
aSk7DQo+ICsJCXJlZ21hcF9yZWFkKGlteF9wY2llLT5pb211eGNfZ3ByLCBJTVg5NV9QRTBfTFVU
X0RBVEExLA0KPiAmZGF0YTEpOw0KPiArDQo+ICsJCWlmICghKGRhdGExICYgSU1YOTVfUEUwX0xV
VF9WTEQpKQ0KPiArCQkJY29udGludWU7DQo+ICsNCj4gKwkJcmVnbWFwX3JlYWQoaW14X3BjaWUt
PmlvbXV4Y19ncHIsIElNWDk1X1BFMF9MVVRfREFUQTIsDQo+ICZkYXRhMik7DQo+ICsNCj4gKwkJ
LyogTmVlZG4ndCBhZGQgZHVwbGljYXRlZCBSZXF1ZXN0IElEICovDQo+ICsJCWlmIChyZXFpZCA9
PSBGSUVMRF9HRVQoSU1YOTVfUEUwX0xVVF9SRVFJRCwgZGF0YTIpKQ0KPiArCQkJcmV0dXJuIDA7
DQo+ICsJfQ0KPiArDQo+ICsJZm9yIChpID0gMDsgaSA8IElNWDk1X01BWF9MVVQ7IGkrKykgew0K
PiArCQlyZWdtYXBfd3JpdGUoaW14X3BjaWUtPmlvbXV4Y19ncHIsIElNWDk1X1BFMF9MVVRfQUNT
Q1RSTCwNCj4gK0lNWDk1X1BFT19MVVRfUldBIHwgaSk7DQo+ICsNCj4gKwkJcmVnbWFwX3JlYWQo
aW14X3BjaWUtPmlvbXV4Y19ncHIsIElNWDk1X1BFMF9MVVRfREFUQTEsDQo+ICZkYXRhMSk7DQo+
ICsJCWlmIChkYXRhMSAmIElNWDk1X1BFMF9MVVRfVkxEKQ0KPiArCQkJY29udGludWU7DQo+ICsN
Cj4gKwkJZGF0YTEgPSBGSUVMRF9QUkVQKElNWDk1X1BFMF9MVVRfREFDX0lELCAwKTsNCj4gKwkJ
ZGF0YTEgfD0gRklFTERfUFJFUChJTVg5NV9QRTBfTFVUX1NUUkVBTV9JRCwgc2lkKTsNCj4gKwkJ
ZGF0YTEgfD0gSU1YOTVfUEUwX0xVVF9WTEQ7DQo+ICsNCj4gKwkJcmVnbWFwX3dyaXRlKGlteF9w
Y2llLT5pb211eGNfZ3ByLCBJTVg5NV9QRTBfTFVUX0RBVEExLA0KPiBkYXRhMSk7DQo+ICsNCj4g
KwkJZGF0YTIgPSAweGZmZmY7DQo+ICsJCWRhdGEyIHw9IEZJRUxEX1BSRVAoSU1YOTVfUEUwX0xV
VF9SRVFJRCwgcmVxaWQpOw0KPiArDQo+ICsJCXJlZ21hcF93cml0ZShpbXhfcGNpZS0+aW9tdXhj
X2dwciwgSU1YOTVfUEUwX0xVVF9EQVRBMiwNCj4gZGF0YTIpOw0KPiArDQo+ICsJCXJlZ21hcF93
cml0ZShpbXhfcGNpZS0+aW9tdXhjX2dwciwgSU1YOTVfUEUwX0xVVF9BQ1NDVFJMLA0KPiBpKTsN
Cj4gKw0KPiArCQlyZXR1cm4gMDsNCj4gKwl9DQo+ICsNCj4gKwlkZXZfZXJyKGRldiwgIkFsbCBs
dXQgYWxyZWFkeSB1c2VkXG4iKTsNCj4gKwlyZXR1cm4gLUVJTlZBTDsNCj4gK30NCj4gKw0KPiAr
c3RhdGljIHZvaWQgaW14X3BjaWVfcmVtb3ZlX2x1dChzdHJ1Y3QgaW14X3BjaWUgKmlteF9wY2ll
LCB1MTYgcmVxaWQpIHsNCj4gKwl1MzIgZGF0YTIgPSAwOw0KPiArCWludCBpOw0KPiArDQo+ICsJ
Z3VhcmQobXV0ZXgpKCZpbXhfcGNpZS0+bG9jayk7DQo+ICsNCj4gKwlmb3IgKGkgPSAwOyBpIDwg
SU1YOTVfTUFYX0xVVDsgaSsrKSB7DQo+ICsJCXJlZ21hcF93cml0ZShpbXhfcGNpZS0+aW9tdXhj
X2dwciwgSU1YOTVfUEUwX0xVVF9BQ1NDVFJMLA0KPiArSU1YOTVfUEVPX0xVVF9SV0EgfCBpKTsN
Cj4gKw0KPiArCQlyZWdtYXBfcmVhZChpbXhfcGNpZS0+aW9tdXhjX2dwciwgSU1YOTVfUEUwX0xV
VF9EQVRBMiwNCj4gJmRhdGEyKTsNCj4gKwkJaWYgKEZJRUxEX0dFVChJTVg5NV9QRTBfTFVUX1JF
UUlELCBkYXRhMikgPT0gcmVxaWQpIHsNCj4gKwkJCXJlZ21hcF93cml0ZShpbXhfcGNpZS0+aW9t
dXhjX2dwciwgSU1YOTVfUEUwX0xVVF9EQVRBMSwNCj4gMCk7DQo+ICsJCQlyZWdtYXBfd3JpdGUo
aW14X3BjaWUtPmlvbXV4Y19ncHIsIElNWDk1X1BFMF9MVVRfREFUQTIsDQo+IDApOw0KPiArCQkJ
cmVnbWFwX3dyaXRlKGlteF9wY2llLT5pb211eGNfZ3ByLA0KPiBJTVg5NV9QRTBfTFVUX0FDU0NU
UkwsIGkpOw0KPiArDQo+ICsJCQlicmVhazsNCj4gKwkJfQ0KPiArCX0NCj4gK30NCj4gKw0KPiAr
c3RhdGljIGludCBpbXhfcGNpZV9lbmFibGVfZGV2aWNlKHN0cnVjdCBwY2lfaG9zdF9icmlkZ2Ug
KmJyaWRnZSwNCj4gK3N0cnVjdCBwY2lfZGV2ICpwZGV2KSB7DQo+ICsJdTMyIHNpZF9pID0gMCwg
c2lkX20gPSAwLCByaWQgPSBwY2lfZGV2X2lkKHBkZXYpOw0KPiArCXN0cnVjdCBkZXZpY2Vfbm9k
ZSAqdGFyZ2V0Ow0KPiArCXN0cnVjdCBpbXhfcGNpZSAqaW14X3BjaWU7DQo+ICsJc3RydWN0IGRl
dmljZSAqZGV2Ow0KPiArCWludCBlcnJfaSwgZXJyX207DQo+ICsNCj4gKwlpbXhfcGNpZSA9IHRv
X2lteF9wY2llKHRvX2R3X3BjaWVfZnJvbV9wcChicmlkZ2UtPnN5c2RhdGEpKTsNCj4gKwlkZXYg
PSBpbXhfcGNpZS0+cGNpLT5kZXY7DQo+ICsNCj4gKwl0YXJnZXQgPSBOVUxMOw0KPiArCWVycl9p
ID0gb2ZfbWFwX2lkKGRldi0+b2Zfbm9kZSwgcmlkLCAiaW9tbXUtbWFwIiwgImlvbW11LW1hcC1t
YXNrIiwNCj4gJnRhcmdldCwgJnNpZF9pKTsNCj4gKwlpZiAodGFyZ2V0KQ0KPiArCQlvZl9ub2Rl
X3B1dCh0YXJnZXQpOw0KPiArCWVsc2UNCj4gKwkJZXJyX2kgPSAtRUlOVkFMOw0KPiArDQo+ICsJ
dGFyZ2V0ID0gTlVMTDsNCj4gKwllcnJfbSA9IG9mX21hcF9pZChkZXYtPm9mX25vZGUsIHJpZCwg
Im1zaS1tYXAiLCAibXNpLW1hcC1tYXNrIiwNCj4gKyZ0YXJnZXQsICZzaWRfbSk7DQo+ICsNCj4g
KwkvKg0KPiArCSAqIFJldHVybiBmYWlsdXJlIGlmIG1zaS1tYXAgZXhpc3QgYW5kIG5vIGVudHJ5
IGZvciByaWQgYmVjYXVzZSBkd2MNCj4gY29tbW9uDQo+ICsJICogZHJpdmVyIHdpbGwgc2tpcCBz
ZXR0aW5nIHVwIGJ1aWx0LWluIE1TSSBjb250cm9sbGVyIGlmIG1zaS1tYXAgZXhpc3RlZC4NCj4g
KwkgKg0KPiArCSAqICAgZXJyX20gICAgICB0YXJnZXQNCj4gKwkgKgkwCU5VTEwJCVJldHVybiBm
YWlsdXJlLCBmdW5jdGlvbiBub3Qgd29yay4NCj4gKwkgKiAgICAgICEwICAgICAgTlVMTAkJbXNp
LW1hcCBub3QgZXhpc3QsIHVzZSBidWlsdC1pbiBNU0kuDQo+ICsJICoJMAkhTlVMTAkJRmluZCBv
bmUgZW50cnkuDQo+ICsJICoJITAJIU5VTEwJCUludmFsaWRhdGUgY2FzZS4NCj4gKwkgKi8NCj4g
KwlpZiAoIWVycl9tICYmICF0YXJnZXQpDQo+ICsJCXJldHVybiAtRUlOVkFMOw0KPiArCWVsc2Ug
aWYgKHRhcmdldCkNCj4gKwkJb2Zfbm9kZV9wdXQodGFyZ2V0KTsgLyogRmluZCBlbnRyeSBmb3Ig
cmlkIGluIG1zaS1tYXAgKi8NCj4gKw0KPiArCS8qDQo+ICsJICogbXNpLW1hcCAgICAgICAgaW9t
bXUtbWFwDQo+ICsJICogICBZICAgICAgICAgICAgICAgIFkgICAgICAgICAgICBJVFMgKyBTTU1V
LCByZXF1aXJlIHRoZQ0KPiBzYW1lIHNpZA0KPiArCSAqICAgWSAgICAgICAgICAgICAgICBOICAg
ICAgICAgICAgSVRTDQo+ICsJICogICBOICAgICAgICAgICAgICAgIFkgICAgICAgICAgICBEV0Mg
TVNJIEN0cmwgKyBTTU1VDQo+ICsJICogICBOICAgICAgICAgICAgICAgIE4gICAgICAgICAgICBE
V0MgTVNJIEN0cmwNCj4gKwkgKi8NCj4gKwlpZiAoIWVycl9pICYmICFlcnJfbSkNCj4gKwkJaWYg
KChzaWRfaSAmIElNWDk1X1NJRF9NQVNLKSAhPSAoc2lkX20gJiBJTVg5NV9TSURfTUFTSykpIHsN
Cj4gKwkJCWRldl9lcnIoZGV2LCAiaXRzIGFuZCBpb21tdSBzdHJlYW0gaWQgbWlzcyBtYXRjaCwg
cGxlYXNlDQo+IGNoZWNrIGR0cyBmaWxlXG4iKTsNCj4gKwkJCXJldHVybiAtRUlOVkFMOw0KPiAr
CQl9DQo+ICsNCj4gKwkvKg0KPiArCSAqIEJvdGggaW9tbXUtbWFwIGFuZCBtc2ktbWFwIG5vdCBl
eGlzdCwgdXNlIGR3YyBidWlsdC1pbiBNU0kNCj4gKwkgKiBjb250cm9sbGVyLCBkbyBub3RoaW5n
IGhlcmUuDQo+ICsJICovDQo+ICsJaWYgKGVycl9pICYmIGVycl9tKQ0KPiArCQlyZXR1cm4gMDsN
Cj4gKw0KPiArCWlmICghZXJyX2kpDQo+ICsJCXJldHVybiBpbXhfcGNpZV9hZGRfbHV0KGlteF9w
Y2llLCByaWQsIHNpZF9pKTsNCj4gKwllbHNlIGlmICghZXJyX20pDQo+ICsJCS8qIEhhcmR3YXJl
IGF1dG8gYWRkIDIgYml0IGNvbnRyb2xsZXIgaWQgYWhlYWQgb2Ygc3RyZWFtIElEICovDQo+ICsJ
CXJldHVybiBpbXhfcGNpZV9hZGRfbHV0KGlteF9wY2llLCByaWQsIHNpZF9tICYgSU1YOTVfU0lE
X01BU0spOw0KPiArDQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyB2b2lkIGlt
eF9wY2llX2Rpc2FibGVfZGV2aWNlKHN0cnVjdCBwY2lfaG9zdF9icmlkZ2UgKmJyaWRnZSwNCj4g
K3N0cnVjdCBwY2lfZGV2ICpwZGV2KSB7DQo+ICsJc3RydWN0IGlteF9wY2llICppbXhfcGNpZTsN
Cj4gKw0KPiArCWlteF9wY2llID0gdG9faW14X3BjaWUodG9fZHdfcGNpZV9mcm9tX3BwKGJyaWRn
ZS0+c3lzZGF0YSkpOw0KPiArCWlteF9wY2llX3JlbW92ZV9sdXQoaW14X3BjaWUsIHBjaV9kZXZf
aWQocGRldikpOyB9DQo+ICsNCj4gIHN0YXRpYyBpbnQgaW14X3BjaWVfaG9zdF9pbml0KHN0cnVj
dCBkd19wY2llX3JwICpwcCkgIHsNCj4gIAlzdHJ1Y3QgZHdfcGNpZSAqcGNpID0gdG9fZHdfcGNp
ZV9mcm9tX3BwKHBwKTsgQEAgLTk0MSw2ICsxMTA4LDExDQo+IEBAIHN0YXRpYyBpbnQgaW14X3Bj
aWVfaG9zdF9pbml0KHN0cnVjdCBkd19wY2llX3JwICpwcCkNCj4gIAkJfQ0KPiAgCX0NCj4gDQo+
ICsJaWYgKHBwLT5icmlkZ2UgJiYgaW14X2NoZWNrX2ZsYWcoaW14X3BjaWUsIElNWF9QQ0lFX0ZM
QUdfSEFTX0xVVCkpDQo+IHsNCj4gKwkJcHAtPmJyaWRnZS0+ZW5hYmxlX2RldmljZSA9IGlteF9w
Y2llX2VuYWJsZV9kZXZpY2U7DQo+ICsJCXBwLT5icmlkZ2UtPmRpc2FibGVfZGV2aWNlID0gaW14
X3BjaWVfZGlzYWJsZV9kZXZpY2U7DQo+ICsJfQ0KPiArDQo+ICAJaW14X3BjaWVfYXNzZXJ0X2Nv
cmVfcmVzZXQoaW14X3BjaWUpOw0KPiANCj4gIAlpZiAoaW14X3BjaWUtPmRydmRhdGEtPmluaXRf
cGh5KQ0KPiBAQCAtMTI5Miw2ICsxNDY0LDggQEAgc3RhdGljIGludCBpbXhfcGNpZV9wcm9iZShz
dHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+ICpwZGV2KQ0KPiAgCWlteF9wY2llLT5wY2kgPSBwY2k7
DQo+ICAJaW14X3BjaWUtPmRydmRhdGEgPSBvZl9kZXZpY2VfZ2V0X21hdGNoX2RhdGEoZGV2KTsN
Cj4gDQo+ICsJbXV0ZXhfaW5pdCgmaW14X3BjaWUtPmxvY2spOw0KPiArDQo+ICAJLyogRmluZCB0
aGUgUEhZIGlmIG9uZSBpcyBkZWZpbmVkLCBvbmx5IGlteDdkIHVzZXMgaXQgKi8NCj4gIAlucCA9
IG9mX3BhcnNlX3BoYW5kbGUobm9kZSwgImZzbCxpbXg3ZC1wY2llLXBoeSIsIDApOw0KPiAgCWlm
IChucCkgew0KPiBAQCAtMTU4Nyw3ICsxNzYxLDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBpbXhf
cGNpZV9kcnZkYXRhIGRydmRhdGFbXSA9IHsNCj4gIAl9LA0KPiAgCVtJTVg5NV0gPSB7DQo+ICAJ
CS52YXJpYW50ID0gSU1YOTUsDQo+IC0JCS5mbGFncyA9IElNWF9QQ0lFX0ZMQUdfSEFTX1NFUkRF
UywNCj4gKwkJLmZsYWdzID0gSU1YX1BDSUVfRkxBR19IQVNfU0VSREVTIHwNCj4gKwkJCSBJTVhf
UENJRV9GTEFHX0hBU19MVVQsDQo+ICAJCS5jbGtfbmFtZXMgPSBpbXg4bXFfY2xrcywNCj4gIAkJ
LmNsa3NfY250ID0gQVJSQVlfU0laRShpbXg4bXFfY2xrcyksDQo+ICAJCS5sdHNzbV9vZmYgPSBJ
TVg5NV9QRTBfR0VOX0NUUkxfMywNCj4gDQo+IC0tDQo+IDIuMzQuMQ0KDQo=

