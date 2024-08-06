Return-Path: <bpf+bounces-36496-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 856D6949928
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 22:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A89AE1C21509
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 20:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A2F15E5CE;
	Tue,  6 Aug 2024 20:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IQosWs3v"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2076.outbound.protection.outlook.com [40.107.104.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA460224CF;
	Tue,  6 Aug 2024 20:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722976435; cv=fail; b=LdrU6bmMsRr/rRloenlinhhOKxZn71Ml7yeCDehrG+1dVQf2+ouFugy4NdY2rnpDdjXvkpVwBQIRWJRk/aESGVEHExS398JFs+B4UZQY2pIH/qvUxlNj2deSDaBP59VF/J58wxAxcTSK10Jyeck85yBxSCd+x8l4frIu1/ehzg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722976435; c=relaxed/simple;
	bh=g7Q8z2uGJg/pKsf9ZpESJQBP4AJ3ysS95UjEKh+onsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OLdYcmrkB0feIun+hemW0ZuEKOLOr/geujg9ElK8noaBoFpFg+h9BJKy7UxpTNiUEq+jjmvZ5NYCdisTzPEPjfoNX/Z33r7O5XpDRfKeg+7rSSE7l1xbloSSK8aDDuEqjsdpD4evZ6t9QROBGdcQ/3btsdl+S+Bwcvu5ka+NN7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IQosWs3v; arc=fail smtp.client-ip=40.107.104.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mFmTfD3skuwe6kwBTNOB7zY4qz6n19MA6GGPB3JYZEgByBMVcdbGr9vWjj8ruDb26X7oeZ4Yr9+qtXOcg9D5gK80/fCHEUlRVnvbCscO5CYf2/irGsP0sd6GayEbI0rU/gyVQYz7b+aa/3hLYFvuVTwHQ/IxSWRndmSjIlGf8c3UL30+RnhE2we62sxr4SoaNrbpu0Z3Zq4hjNwE4pbCCTWtugfj4r6srbqdIkZNWlwXl3RyBL/mOma/KvcwjjsU9ndxq5sS89KzYV/5xRH7bNOdjKeo/KcuUss6R6E2O7q1RKq5uaklNFGIplGaI8jbBY8lf5FA/D11cSm27ejVRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8E+sEkA4nqUusZWZU7q6Kw0qzLd+asV2nlR87CRVfmg=;
 b=jcqK6g0WMeyAc/TB3LDy/ATcrtq0Md1lA813vUdlOnghl+fcBBkoPYyuXAzVpJl0+fpNetrNxBgMnqwplcH3EXf9BM9g70ivhiMJ8Et65KIKFtFiGOsQKsCgCvj3cwUtoM6SxdW7ppYe0qAalIPAGeiJWRoTIiYa28PNMhgpBW6gYAms61Ju9b9bZ4EoaJ+NdJziRhiIUoaaSex+DPxQd2ahOQNdCp1IKTyrrRatUGRQWer2qPpPEhIEQRMZNXwT2fBcQZz15BNlb2XP2w2ODr+oCl7nGIgRHmNhdakbURKN7bwPtPpmE7CPg8IL1VaZn0nsJLOs0V43k/0Pq70Cwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8E+sEkA4nqUusZWZU7q6Kw0qzLd+asV2nlR87CRVfmg=;
 b=IQosWs3vibU7lqao8deonSXjwnCfCnU14v6kmgbS8vhYuar7VMoOOGeyp8qA0pBp2gu9eMkKg33fTmhPni2w4fqExSINbpPFDPUJEPpVqXTH12JaWrsEra46Ldfw9RQmlLwFCdbL6MiVVkFGogjwt8WtISqf/sEgkd8Z7hcv+SvbCnvH3zgmNJsi0tzB/oRo63l2Ghc1yDFQ7zVMCJXUb6OoJZnYK+k+8BmjqijfJlD7oWsVsaf1l71Ea94EedZbqJzh/6jgtrA9geF7heBvbzv69D/dZiGuXH5zNKWBydNI8ovBGbAae35NCihwch9MVoV42LuS7EhGuMpyfpDbqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7975.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Tue, 6 Aug
 2024 20:33:49 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 20:33:49 +0000
Date: Tue, 6 Aug 2024 16:33:38 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>,
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
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, devicetree@vger.kernel.org,
	Jason Liu <jason.hui.liu@nxp.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v8 00/11] PCI: imx6: Fix\rename\clean up and add lut
 information for imx95
Message-ID: <ZrKIotkhvAnt87fX@lizhi-Precision-Tower-5810>
References: <20240729-pci2_upstream-v8-0-b68ee5ef2b4d@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240729-pci2_upstream-v8-0-b68ee5ef2b4d@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0294.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::29) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7975:EE_
X-MS-Office365-Filtering-Correlation-Id: 5447b24f-6955-4542-0822-08dcb65713fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|1800799024|366016|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZGRsaXdiUERvd0tiUXNjMi9UWUkvVlpNampnZUZWeUhXTGhqdERjN1pqN0l2?=
 =?utf-8?B?Mi9nU3pxRERpeGpuM2tBcXhiZVFwQTFnSi9ITWQxNnUzL3VDbW8zT0Rma20r?=
 =?utf-8?B?WlR1elNVSWVQWVZuN0p3NmVEdVlWb1NCN2hpQ1ZWQ3dRd2FtdnVmUnlaWE1N?=
 =?utf-8?B?RG1DVEhBTW43UklkUTF4ZjB0T2VJUzBWT2d5d0FteXI1N0tkMDhjSGRIMVdV?=
 =?utf-8?B?dU5VMXRkb2daYTBMTi9aZzFiUFBlaDMxcDlJQThQVTh4aEFwd295STUrc3JR?=
 =?utf-8?B?eDBmYURSOFJsKzlhS29NdkYwTUhyNHFPMUQ1T3JjUCthVTVsb1ZKTDdUR25F?=
 =?utf-8?B?dHpreVJoR1hKT29YbmRjeFBHMmpGYWpHTlZPSHd1OGFvWVJmS0JWa09sZysz?=
 =?utf-8?B?U3o1cGMzQ2JscmdDdUY3MkVOTjcvZkN2UFZicXNGMVNwTExHNVBxdERIV09D?=
 =?utf-8?B?MFdFNzM5NW92RkhsU3YxM2ROK0xHUDRTaTFNVmRjVDFacjRnZ0Q5TklnRTBj?=
 =?utf-8?B?S3pmRU8vNi9xazh1SFRpNGRjeWdDdHRzZUljQTVBbUFxd2ZrdGVqY3A1cmFI?=
 =?utf-8?B?c0ZwcFlMRWdNcTNKeUd4NVByajZ4WmVsNFc0TjExV2IxcHVXOC9DZkZpSnM3?=
 =?utf-8?B?WVZrL0FVcmtQTkVRSXBIcjBQUCs3ZmxlaHVwSVlzb1IvUTFocWVYcUR0aENY?=
 =?utf-8?B?aTc0MzZHRklReitOK0dqQmh5d2lKV0tFS0MrSWhxWnZsajNuZW5jajAxZzFF?=
 =?utf-8?B?cVpCWFJWQXBnenVmTHNVYWxGdHdpcWhmUFllUzNBMWs1VHh2ZGpoZGVxVHNN?=
 =?utf-8?B?RHJQNFNhSGZNOU1qYmtueERwN1ZvVmRxMnBZczRuS0xJeGM5WHppUVBoRzZs?=
 =?utf-8?B?Ti9vcE5Ndk56VmJXSWF4dEdMSEI5Uk1rUVpWOXVMUzdQSWlOay9vWWhRSHVl?=
 =?utf-8?B?ZUQxOGdMOEZWWCtSVUZxeWlQQXV2d1R6QXM3akRXbm5xQ1dmTWtGRHB4eXg0?=
 =?utf-8?B?MFZYc2p3MURuM0twNC9lb2RLdWwraEt1b0pJc1NGWVJjVHRMck9pNWs5NGJ0?=
 =?utf-8?B?dHZDUWl4UldGNEZyRHJodDVidTRyRndNd1FWd3VhcWs5YnFXM2IrUTA0OWJE?=
 =?utf-8?B?bVBhZEUrSi9aeUNGNVRCZ005T0F2c0hNblE3Yy9PWE1VL00rWVdCTEpqNTUx?=
 =?utf-8?B?d0JGVkFNS1N5N1YycXg4VHJpSzkxSm1vWWkyakZZRlVDNjJQVFdUVlA5Sks0?=
 =?utf-8?B?QzNVd1lWWndUemxWZm5tdFlhcWlJUWltekJIMDBlazdZT3hxNGFHTExwUlRF?=
 =?utf-8?B?dWt1amM5NWNSQzBTejlZYnRtYzJPSTBqTDB1U0NvclNLZC8zNDhDTkUveWxm?=
 =?utf-8?B?SGpTNWxQSTkrcXdGNkZERnpkQmN1akMzQkY3RnIxeURPN3N3REF3NUV1am9K?=
 =?utf-8?B?bE90QVZTSjRqZndURVBJb1poZ2NHK0VYWXRBcnladDVjRG0yMkZyd2JlK1N5?=
 =?utf-8?B?RTVOM3h3eWVwREF4dlExcUQyelFKeWl0NVRBS0RWTFhUckcyL2Qxd0FJeWx4?=
 =?utf-8?B?NHNaUkFJTXZwNjVVTHgzVGF1T0RNOWxkdTNJVzZpLzVRWFdoWm5pcDExa0pU?=
 =?utf-8?B?elk3ZzJPU3JZTTlYNzdVdXhSQkphUnJubGV6VUdUWXhZSzNSamRUYTJXS2xD?=
 =?utf-8?B?aGYzQjgvdEZweFk1eUFFVjdQV2FXeHFDNFlGczVzQXFKYlhoZEhpZjgvZnZp?=
 =?utf-8?B?OVdWUDFuZDFudUFhQ3FrT3dSVjVMSXZranpMR0pDb1Q4SG9xL0RpUHRVZjNW?=
 =?utf-8?B?cmVLdXRUUFJsbUh5M1NuVjNONHBKNi93ZVFHVmtucmNmT2R3MWRUdk9RVmw5?=
 =?utf-8?Q?+7TO2fF2C0qyI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(1800799024)(366016)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3ZneVNiS2ZLNHNZdStYYitXVGN6UzlOMjl6VEtXWUN5VWxhZ1NDclFaZVcz?=
 =?utf-8?B?RHBkaTBwb09WQjdhYUY0b3VKK1FFZHdsNllxbmkyeDlVdmNDRUFuNlcyMjV6?=
 =?utf-8?B?OG01SzBNVlhqTU9VNnBiTkowODlReXNXNTRmemJFbVd0UERpdkVWTldrbyt0?=
 =?utf-8?B?NURsL1FDdkoyQUVWZkZKbHhQbUZTY2ZjcGtLT0ZxNExTQ1VMdXFPQmdZZFM5?=
 =?utf-8?B?S1ZuSzQzT2hZSHU2djBwb3ZzbDhpTFlGWjZLK0tCNzhLanl6OENialk5WlhV?=
 =?utf-8?B?cXErWEcrZ09GZ3JITzY1R0tCaS9zZjViS3VENmlGQmc2UmpuNzhuNUxBUHVj?=
 =?utf-8?B?VWlrSHNQUi9hamNhcGhYQUVRNDhvRnJWSEFNVlZzMnlYWWJzbVNpaUd3TTJz?=
 =?utf-8?B?T0svRm5NVmVlanpGNVpydDVhUk0wcG9VazdaQzJvZEJqenMvc0tSbnQzV01N?=
 =?utf-8?B?UFpmRXlheTRGZlhYUlQ5anRNTHd6b3ZldjkrQzVBdkpPZEtMNWNHcHJOaldP?=
 =?utf-8?B?cVZhZ3BnR1UxY0wyMVJxTWE1ZVFzVG8zRTRlOWlZWDRnZkJBZlZIblc2Z1Rk?=
 =?utf-8?B?SDY4eXkyL3VBekFlcTdtaWdIVU1SMWtWeUw5Y3RpYkM5TTM3aE1tZjZ1Yk9Y?=
 =?utf-8?B?YmJSUitqUndmMm9LOThhWGlpUDNyZjNxcWJ6SHVHRm1aUHNtcFlaTXlTNEtH?=
 =?utf-8?B?UUtESFVTTlJJNzF5ZjVGc1Z0c1RCQVF1NTBVTDNjUG9hNG9lUldIakRiRmpL?=
 =?utf-8?B?Tmg5RGwwbG4zT0dnV1lvVmQyZ1BzaHczdmdSdFNCL0puNUdyRDlkcXBVWXJo?=
 =?utf-8?B?QjEvd2hYQmp4bkt0dDduSUpXc1B6L3d6OHlDTGZiejAveFZnYUg5dy90U3g4?=
 =?utf-8?B?bDNRYzVpZmIyclRncDlkNHBLWXM0MTV2M1d1QnhaSXNRU0gxUEgvMzMrc0NQ?=
 =?utf-8?B?N3p1bnJRMzIybi9oaEpYeUcxRU5oSERpNWw5MndXanAyRW15RzhlRk52L3pK?=
 =?utf-8?B?dm5mSCtCMDVvamdJek44UjRvak9pVWJ6b2Z4eXR1VWZTeklLdUtGSExmN3h1?=
 =?utf-8?B?bGJGSlBpMVNoYWRuSFN1MzFxL3E3WGk0bUluTDN0QWhGZTd3WG9hbFgxb1Uw?=
 =?utf-8?B?R1ZPOFlPVGU5bHdKUTlVT213QXpabjNQKy9EWDhCWTl1WnNlUU40c0ZndW11?=
 =?utf-8?B?VnJHQndGUVJDbVloTndoSzBjZTJMRUkrRnRRNW1rY3R1cWJMVWNpakhUdVd4?=
 =?utf-8?B?SkNkaU1rL2xaemkyc2hKOTdXbDQ5eWM2RnFxdlNpQWQ5Ty8zOXhYeFZHSUEv?=
 =?utf-8?B?bFY3U1VWRHFMU2dLbWVIeStXTXhiOHFBYjNqcDlxT2Y2eEUxRzFxNUN3aTIy?=
 =?utf-8?B?aWNXVUt1TktoMEZMYXRJeXFZUEFJYis2cWs1dDduTWRvcVBWYXJqZ0ZoNG9F?=
 =?utf-8?B?NzBJUy9pQ0E5N0dBWnM0ZU0vVThwZVBhMVpmWEZmd3VtZ2JNQWZKRGRyTTdi?=
 =?utf-8?B?dUdIY0hGTXN3dnFXV245ajRUZ2hHdlpRTG02RmhzMmswN096a3lKMnJYN3I3?=
 =?utf-8?B?ZDFKcnA1SGUzMkhJbTkzZGlBQlhSWG1YbEx2TjU0bzRHU0hTcTlGSUk2M0R6?=
 =?utf-8?B?MUhNUGRxdXp0YXFTN1BxSlFqRUxWWGQva3Q1SVBwNzNjVFJ5WmpZMVZwc1Zj?=
 =?utf-8?B?Ym1mam1pVHF5d0Y2VTJaQXZoU1dyWC8rak9ONDFPYWI4djg4aWRDaG8wWk40?=
 =?utf-8?B?eG1XN1FIU1FDajRoQTV4aGt3eWYyWU1GZGFlTTEvaklpWmNtWUI5Ni9KdExo?=
 =?utf-8?B?dmV4ZEtHRHRTRG03andqTDQrWlhwS094SzNXQTVMR3N0NWVCcGU1VzlxOVcv?=
 =?utf-8?B?azBSQXdkejYvaHFUYWgvRWFQT0xxTSs2aWgxS2NsTTVGaWdMaWNpUUp3VlRZ?=
 =?utf-8?B?VUoyQlZjMWtOSWM3d3E2VEZMKzVRMi9nSHVyVmdYdEp1T1cvMFB4b0kwdkIz?=
 =?utf-8?B?eDlmQnI1VnZzOVI1cmhacEVxNGFKa2dSS1M4WTA5ZHk3eUltT3I3S2ZzR2Mw?=
 =?utf-8?B?eDlGMGsrWmJhMWtwYWhveDIzMWkzTHlxNFRGcnJJcnJmTDVmaVkvZzZmcHdq?=
 =?utf-8?Q?VW/RfW6k4wJB64fUBmOyCQc3A?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5447b24f-6955-4542-0822-08dcb65713fc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 20:33:49.4738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EepMHjDIB21Luv+U4IyyqleF0wkRV69MggTdO4xFmxuL/a5m2chvh3Ua+yW7mLmWkTwPIUaNsaaU0asmOgm/qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7975

On Mon, Jul 29, 2024 at 04:18:07PM -0400, Frank Li wrote:
> Fixed 8mp EP mode problem.
>
> imx6 actaully for all imx chips (imx6*, imx7*, imx8*, imx9*). To avoid
> confuse, rename all imx6_* to imx_*, IMX6_* to IMX_*. pci-imx6.c to
> pci-imx.c to avoid confuse.
>
> Using callback to reduce switch case for core reset and refclk.
>
> Base on linux 6.11-rc1
>
> To: Richard Zhu <hongxing.zhu@nxp.com>
> To: Lucas Stach <l.stach@pengutronix.de>
> To: Lorenzo Pieralisi <lpieralisi@kernel.org>
> To: Krzysztof Wilczyński <kw@linux.com>
> To: Rob Herring <robh@kernel.org>
> To: Bjorn Helgaas <bhelgaas@google.com>
> To: Shawn Guo <shawnguo@kernel.org>
> To: Sascha Hauer <s.hauer@pengutronix.de>
> To: Pengutronix Kernel Team <kernel@pengutronix.de>
> To: Fabio Estevam <festevam@gmail.com>
> To: NXP Linux Team <linux-imx@nxp.com>
> To: Philipp Zabel <p.zabel@pengutronix.de>
> To: Liam Girdwood <lgirdwood@gmail.com>
> To: Mark Brown <broonie@kernel.org>
> To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> To: Conor Dooley <conor+dt@kernel.org>
> Cc: linux-pci@vger.kernel.org
> Cc: imx@lists.linux.dev
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: bpf@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
>
> Changes in v8:
> - Rebase to 6.11-rc1
> - Add Mani's review tags for 2, 6, 8, 9, 10
> - Add fix patch PCI: imx6: Fix missing call to phy_power_off() in error handling
> - keep enable_ref_clk(), I will add more code to make disabe/enable symtric
> - Link to v7: https://lore.kernel.org/r/20240708-pci2_upstream-v7-0-ac00b8174f89@nxp.com


Manivannan:

	Do you have chance to review these again? Only few patch without
your review tag.

Frank

>
> Changes in v7:
> - rework commit message for PCI: imx6: Fix i.MX8MP PCIe EP's occasional failure to trigger MSI
> - Add Mani's review tags for patch 1, 5
> - Fix errata number in commit message for patch 6
> - replace set_ref_clk with enable_ref_clk in patch 4
> - using regmap_set(clear)_bits in patch 4
> - Use exactly the same logic with original code at patch 4
> - Add errata doc link for patch 6
> - Fix miss "." at comment form patch 6.
> - order include header for patch 9
> - use cap register to set_speed for patch 9
> - use PCIe in error msg for patch 9
> - Remove reduntant ':' at patch 9' subject.
> - Change range to ranges for patch 10.
> - Change error code to -ENODEV for patch 10.
> - Link to v6: https://lore.kernel.org/r/20240617-pci2_upstream-v6-0-e0821238f997@nxp.com
>
> Changes in v6:
> - Base on Linux 6.10-rc1 by Bjorn's required.
> - Remove imx95 LUT patch because it need more time to work out the
> solution. This patch add 8qxp and 8qm and support and some bug fixes.
> - Link to v5: https://lore.kernel.org/r/20240528-pci2_upstream-v5-0-750aa7edb8e2@nxp.com
>
> Changes in v5:
> - Rebase to linux-pci next. fix conflict with gpiod change
> - Add rob and cornor's review tag
> - Link to v4: https://lore.kernel.org/r/20240507-pci2_upstream-v4-0-e8c80d874057@nxp.com
>
> Changes in v4:
> - Improve comment message for patch 1 and 2.
> - Rework commit message for patch 3 and add mani's review tag
> - Remove file rename patch and update maintainer patch
> - [PATCH v3 06/11] PCI: imx: Simplify switch-case logic by involve set_ref_clk callback
> 	remove extra space.
> 	keep original comments format (wrap at 80 column width)
> 	update error message "'Failed to enable PCIe REFCLK'"
> - PATCH v3 07/11] PCI: imx: Simplify switch-case logic by involve core_reset callback
> 	keep exact the logic as original code
> - Add patch to update comment about workaround ERR010728
> - Add patch about help function imx_pcie_match_device()
> - Using bus device notify to update LUT information for imx95 to avoid
> parse iommu-map and msi-map in driver code.  Bus notify will better and
> only update lut when device added.
> - split patch call PHY interface function.
> - Improve commit message for imx8q. remove local-address dts proptery. and
> use standard "range" to convert cpu address to bus address.
> - Check entry in cpu_fix function is too late. Check it at probe
> - Link to v3: https://lore.kernel.org/r/20240402-pci2_upstream-v3-0-803414bdb430@nxp.com
>
> Changes in v3:
> - Add an EP fixed patch
>   PCI: imx6: Fix PCIe link down when i.MX8MM and i.MX8MP PCIe is EP mode
>   PCI: imx6: Fix i.MX8MP PCIe EP can not trigger MSI
> - Add 8qxp rc support
> dt-bing yaml pass binding check
> make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,imx6q-pcie.yaml
>   LINT    Documentation/devicetree/bindings
>   DTEX    Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.example.dts
>   CHKDT   Documentation/devicetree/bindings/processed-schema.json
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>   DTC_CHK Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.example.dtb
>
> - Link to v2: https://lore.kernel.org/r/20240304-pci2_upstream-v2-0-ad07c5eb6d67@nxp.com
>
> Changes in v2:
> - remove file to 'pcie-imx.c'
> - keep CONFIG unchange.
> - Link to v1: https://lore.kernel.org/r/20240227-pci2_upstream-v1-0-b952f8333606@nxp.com
>
> ---
> Frank Li (7):
>       PCI: imx6: Fix missing call to phy_power_off() in error handling
>       PCI: imx6: Rename imx6_* with imx_*
>       PCI: imx6: Introduce SoC specific callbacks for controlling REFCLK
>       PCI: imx6: Simplify switch-case logic by involve core_reset callback
>       PCI: imx6: Improve comment for workaround ERR010728
>       PCI: imx6: Consolidate redundant if-checks
>       PCI: imx6: Call common PHY API to set mode, speed, and submode
>
> Richard Zhu (4):
>       PCI: imx6: Fix establish link failure in EP mode for iMX8MM and iMX8MP
>       PCI: imx6: Fix i.MX8MP PCIe EP's occasional failure to trigger MSI
>       dt-bindings: imx6q-pcie: Add i.MX8Q pcie compatible string
>       PCI: imx6: Add i.MX8Q PCIe root complex (RC) support
>
>  .../devicetree/bindings/pci/fsl,imx6q-pcie.yaml    |  16 +
>  drivers/pci/controller/dwc/pci-imx6.c              | 989 +++++++++++----------
>  2 files changed, 542 insertions(+), 463 deletions(-)
> ---
> base-commit: c428091cdcf7f368ad9884f8caa68b79cd6c333a
> change-id: 20240227-pci2_upstream-0cdd19a15163
>
> Best regards,
> ---
> Frank Li <Frank.Li@nxp.com>
>

