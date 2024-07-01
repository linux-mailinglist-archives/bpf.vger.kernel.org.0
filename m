Return-Path: <bpf+bounces-33526-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4575391E770
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 20:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB9A41F2248E
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 18:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5354016F0C3;
	Mon,  1 Jul 2024 18:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="p2o6wrOG"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2055.outbound.protection.outlook.com [40.107.22.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8003BA34;
	Mon,  1 Jul 2024 18:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719858551; cv=fail; b=Efyj6/Bj1XnTDMZg3h6UjFdgQIcCDEm+6o5uf/c6ip9tNohEmV2o776PL7yr3ZCvDKMrlaEnoQJNciRlDYs+ks/8OS9m8sKUIF6SFZo7V+GWf/EHpOmHN4mOtC1vjVlbmceE22iNemjaedObU/I+9ZtbHSzs27jZL0uPoJ6V310=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719858551; c=relaxed/simple;
	bh=Lr8se/tRCbqYVmz+mIaFblRh0/gnnknBp2nn7V3+GZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hvxgg4lEFbVFm8nBxKiFLWeolqOLN5Itsvo1f5aq72qAswMeiMqFRQEsEsCmGPjS/jMAMRnQdWpqeD9iYanLed4BcsZ4h1OxYNx2uLtFru6l3SlRlf+hnMQ9YSkq8RZ18cV6SuEdDYZZe8ELg2MolhFOaEpRHIYr8Z+nOP9Jnkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=p2o6wrOG; arc=fail smtp.client-ip=40.107.22.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Szsedf3v7OxAZgTMncEeOckyszGzkkVkwxjkD4wU81ev8W2tNh9xSTFUzZyel1cvib8CWUNzjtKY+e/Q3Lnngw1wwkKYcsJWJAtNKRkQGHqwKow/fHXZqhoEBUUlFpcXq0M1zc9A2ILa0AuvNrf8+w5AzS8uWs/wkaUp+k7CNrwXlG0m9ekF0l/brY22PbOYQ/bf153JpjsVsBg2ir9lMv4qIHgQ6wnbLhRQzwl5p7iGlX8YuXulkyR9B/auhP4KBthsgzqtG06W7lDYZTY+1o2XU80MrDSBPxsAeqAT5oDSHgs1c/dxeqV+1MJpp7C4D0eqsm1RNSc65XQaYP2vJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sCr0tT/IZvixXGwaIocG2UEeeN8qhbw7ihpVCOeDSMM=;
 b=l9Pkz9pzXOSL9XrxD+T5m5whm3Hb+VhXTxG29IrgrMxkBJjwBkmGEiNcei7gJj0sX5t2U+RQfIUQwTiLY2hWNodaVfqypmZjLCUGd/etzlu7MVkKR3HflUVEb5lt8GrdbNmlRX8aOSGSgdIWFMSOEAfZg4cm/3jS23hsP351wB9IsJaKxrVKsQhJlwGr51WCq8E/jEilfHCPEKAcXrk/6RpsV2WfcN+fCCl91CPZzX36uCTjhzXu47acC8DP0q+WuK0NGtcIomY4gQxsBq7fIH3I75B9CyuTMrMv6LJm3WrV2q6O6zfmuSwzlkYlDds5hlXX2CWjIiVYZ+yVAVd9dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sCr0tT/IZvixXGwaIocG2UEeeN8qhbw7ihpVCOeDSMM=;
 b=p2o6wrOGJBGoHzZ7mH8kHtsbyXvJV4CH6d+iwhYFtbcqtz+mOYJxzSWWtTK9DuVFH6VgBjvyefIP82Fn+s56H/OpzctQRO7pG/a8QrUExVHSWHSw0DlIjMMylK4vdlLaKOJ63zWTLdWeIU569fesFL7jzSnMkqqT0TRxJTr1Y3I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB9194.eurprd04.prod.outlook.com (2603:10a6:10:2f9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 1 Jul
 2024 18:29:06 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 18:29:06 +0000
Date: Mon, 1 Jul 2024 14:28:54 -0400
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v6 10/10] PCI: imx6: Add i.MX8Q PCIe root complex (RC)
 support
Message-ID: <ZoL1ZgfQFucAEqoP@lizhi-Precision-Tower-5810>
References: <20240617-pci2_upstream-v6-0-e0821238f997@nxp.com>
 <20240617-pci2_upstream-v6-10-e0821238f997@nxp.com>
 <20240630165103.GE5264@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240630165103.GE5264@thinkpad>
X-ClientProxiedBy: SJ0PR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB9194:EE_
X-MS-Office365-Filtering-Correlation-Id: 88c1b624-95e2-422e-cbf4-08dc99fbb0e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TEJUc1hCQUtoTGpEVWZjZzdSNlowdUpYQk1uWGkyTksxSnhPK21KUFFiYUNZ?=
 =?utf-8?B?cU5aNnZacHBLSWJpUFR4RUdrVnRKV01SRitaVDFSRnRrNnhvaGtEbnNwY2pH?=
 =?utf-8?B?WnFaejFmbm4zNEl3M2V5V1UzU0FkQktSQzBPdDN6eGlVVmdsa01ZbTVNNDF5?=
 =?utf-8?B?d3Z3VGF2SFVTSVlCUmRKUkJzQXhRdlpFKzFjd2dYVUJOYU01YVNiNTNwMHRy?=
 =?utf-8?B?LzgzenNGMlpQNlc1SnpkR3NNWlVaNEZWNitBRkVTWloxQk1uSDNxVXo2Z0la?=
 =?utf-8?B?V1lLNmVnQnZvdWtQOGpoUjhwakhrbmlCTS9GbnhkK0d3K0VPSnZQcXAxNVRG?=
 =?utf-8?B?dHk4Z3pYdklCU2IxV0oyZWxtTlJ4WlYwdE1MNDhBSkUwc21SN3lGMFZGRUhO?=
 =?utf-8?B?eVFSdWRLMFROVHNXOXcwejU3dEZhbTNtS3llK1dKVXhnSnlJc21EZmljc0lP?=
 =?utf-8?B?dWZnN0d5QXlZc3hZS3J2SXowU3ljRi9LKzBPTVZ4cjhZTndKSlJVd0Z4c1Mz?=
 =?utf-8?B?Wmg3Vys0dHR3cFM4WWtRczg5dDJxbDFsZlRnWjVBU0d4V2VuOTNoR2VUM3ZH?=
 =?utf-8?B?a0g2cVBpNHlHUVNYVXplZ1ltUHR5RmEvT2Y2TytFVS90VmV0UHgrZlRyeThB?=
 =?utf-8?B?NFRWdk0rNXorTXh0YzVpeWFEVHBqWHhSK3U3REJEdytyMUk0Vk9WTVM1S3Ev?=
 =?utf-8?B?eWl1WC9MNjAvcEViN0FxMStqTEcyT3lUaTdZcVhycy8wTmYwZWtKL0dXYlZk?=
 =?utf-8?B?QjJPTnJUZmFTZ0dhQnhqMVlnTlhpZkp3S0taNVdraWVvMk5vcndCQ2ZQYnZB?=
 =?utf-8?B?M0Z1YThib2pjT1dOV2xDcWQxdWxmRDhsSWxBVU52OGNlSVJST0t0Qm1iK012?=
 =?utf-8?B?YmlndmFDRUJtdnMwTkx2UjczVGtyd3NkZ0hYMWF4QStYVzFybTd0bzdyTEcz?=
 =?utf-8?B?WkIzOXNhZm9aUWtxeDdKKzRvRXlnbno2aEUyVTM3VktVSXJadGJ4YTA2cWRK?=
 =?utf-8?B?SHJZVUdqOTBjYm1GekszZmVPTUZaZ1RCOXYzdDZnRHNkM0NCMGU1UWNnOTlE?=
 =?utf-8?B?TzJ0K1hPYWI0cklBc2NmUm1TQ1d3TGtpcG1UaDVuMnBpdHg4aFYrSEtmZG5q?=
 =?utf-8?B?OXBXc2o0dnJNMEZBbVlYY1l4S3ROcGZaMXFtMjQrZjUyQng4Z3A0REtMZm5k?=
 =?utf-8?B?aEFhWHdMYjluOXpIQ1dwMytFVE5GQXkzcGVPTGw3eThrbVJzZjZEdDg0b2g4?=
 =?utf-8?B?TzFLTkJOdE1KS2dTWWg5eTVxMDB1a3o0TXllM3VKS2NKME50Z2RtaUc4aUg4?=
 =?utf-8?B?M2F6cll3NTBsZWVjdGxpMTlYYXdLL3VTOVI2T21pNkM5cXpOVU8wU29hNjRC?=
 =?utf-8?B?c1dSdnk3Yng1MEd1ODR5WFpoRzdFR0NMZzNjTzEvb1FyWmxma0VSaWlBZzEy?=
 =?utf-8?B?TENUNGRCeGlDVjcwdTNRditBbjhwUEVIbWUwazY0SnVQYStoMGxJc3VtUkw4?=
 =?utf-8?B?OVRuV2E0b25LdkFmQmY2V00yM25HSkJSaDVEYnE5WVErRDBaSUVsN01DcXNN?=
 =?utf-8?B?UzR1dG5uWmJhQUttbDQ3NzFOUTlrU2VDMmlUNUY4YzlCREhqdUpYWHBnUmZW?=
 =?utf-8?B?a0p4VWJvR3RXOXk1SnVhVnJKcm1sYjFIMXQyNUxTOWFTdTNsRkNhcm9qcTlU?=
 =?utf-8?B?OFZGUTVQTllMZVRpSWtzRDZ0anM5WmIwSDhTTnM2bFd6ODM1bmZvajBEdHlP?=
 =?utf-8?B?S3RQSjQwSjREak5vb0pQWVFFWnlyUW9sdmlKOHdvMVRweG5YUlJTZnA4VG8z?=
 =?utf-8?B?VFNwNzhrMVlyVWlwb1JkSmFPaVcxem9oU2xITFFrMEFFYTJnVWU3cU1XdWhN?=
 =?utf-8?B?Qy9BOFBBSVRMWkZyL3l3RGZlUXR4bW1pNnFwSG1zR1lHdXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDA0K0JVTjhEZHRDdmxPQkFuMjJldHBlSjM4NENoRjhCVGdzazlZMkw0SWJs?=
 =?utf-8?B?ZVdSamRsWlZNMm9PNVpDanZnN1pSRzJyN0hKOXFCd0pkUTNzVDVBSzNEZGVh?=
 =?utf-8?B?M1M5blhndkNYTVFMNFZNZEMycW1LOUx1cWpPLzQ4Zk13UlZmd0V1ekprVmQy?=
 =?utf-8?B?MGZqL3M5VXQ5WU9xbk9Ec0xQVm16RHg4WWFsUGZUa09xczd5UVozMVp6alZj?=
 =?utf-8?B?S2p1U3VqcnBzd0N4U2RiWEtXMGNzR1FIS0o4VlNEOUhvTkJuYWsyNHVVTkpy?=
 =?utf-8?B?OHNGY1d2dWNZc0dHMUJtUzh1VEFjbnJaN0FkTFdTY3VvZFNZL2EwMnNuVUQx?=
 =?utf-8?B?QTBmMnR6UDk4VFZ0ejZXZDJhRHBSeisvMzA4YWtEbFltb0p4bWN1YS9WeDJL?=
 =?utf-8?B?R2N1a0dZRXdZM21kaDZsZG5DdWxudzIzZ0dMOFdHUkhURDRQZEplL3p3QUVJ?=
 =?utf-8?B?ejRxa0hyRThuVVpwMVg5L0pBeGEySDlYaWJqUEk3VUJFWUxjZFF2Q0VmMU1O?=
 =?utf-8?B?azltRDJOcDAyZ0FMSXRXREpHYVdRV2N2YS9aZDFhQngvc1lSTnR0QXhXY3dU?=
 =?utf-8?B?ZE5JWmcydXo4am1uRG85Z2d2a1Zmd2JwcVVwbUNhd2trN0R4TkZSeWlLUU55?=
 =?utf-8?B?QlZCR0tRZE5WbHo1Q1BNU1haS3dmYlU3YnBlMU92TkxqTjlIR3JWelkvWnpX?=
 =?utf-8?B?QUZoWFp1aUxTYkNhWnpoS1I5N3Z6MTBlb01RRUlMMks3ZXRXdk02MHV6Z29F?=
 =?utf-8?B?Wm5zRnBjMFhVOW9KWkdNa2xIZWlLMk1aeVhkTEwrUW8xeW1yN0VwcWI2QU1M?=
 =?utf-8?B?RjExZDBQRnNCTHg4UnBzM054OTJFdC90NVJIVENlRmoxS1ZUUVQ2MkxHV0RH?=
 =?utf-8?B?dG5uUDRlcDBPNmNPSFVvWTVPM20yQVNFWE9PS2xMREVTUXkrd09VZzgrdndv?=
 =?utf-8?B?V1c5aWw1TStSWVBSUEdNMTBRSVlwa2ZZTS94QWxnVm1MU2JseXRFbjFNN1gr?=
 =?utf-8?B?Ym5jL05YZ3BRYWZaSUFMQzg5cWdtM2VmSHM5ei9Tc1JhbWJkanhXb295dEE2?=
 =?utf-8?B?ZDk4Wk5kTGprTlNPaVBqajRudURTL0NNWWc2U01UZUM5WERCUzk3ZDVNdXdt?=
 =?utf-8?B?SHBFZ0h6SzE5TzVSbGl1aERqdVJrQ2tCS1dzSWZvVnhZTDN4U0xhZmRkd1NC?=
 =?utf-8?B?dDAxNXZqaGlOR2Z6MWRBb0NZU3FiVVBYeVlkUUIzR09XYzlJZVd6cFBTckdR?=
 =?utf-8?B?YnBxcEZYc1ovK09lUXZQUXF3OUZNZ3NhQjZHM08rV3B0VTA3bldaRGVHdEg1?=
 =?utf-8?B?aWVMeDJzZnZyMDk1aVpZQ1JMUStTN3FlU3BwYUI2dExsTXJrRnhvQlVmdDJo?=
 =?utf-8?B?a2ZLNFZGK29SOENQdUJPYW9pQ3ZNcmJrMExwTE9kcXFpMmM4NjN1NDlLZE9i?=
 =?utf-8?B?QVdKN2l0N243azhINzlkVW92WFpUeFh2ajRqcTBMYTZ0VjArTkxUd2RycDJO?=
 =?utf-8?B?YnhSeWRvb0ZKaEY0aS9rcmxpbnJvK0ZhQUkvaEJzR1pmaDlyWkp2NGRzbFRs?=
 =?utf-8?B?VzkydGVRWnoxMEkrazZubEk2NDlDSkVmUnR5UlBoOGQ5eUVxVW4zaHU1VkNM?=
 =?utf-8?B?dGpickt4cGlmOHpsNlJPaXNNUDB1T2xnVlZtcDJockRCYUgxRTEzSkwrT2k4?=
 =?utf-8?B?bldoZkdHbWtqZFBHUVVCZDdibjEvNTZtVWlHcDhzTmZ5VDRBT3RVeW9qbW42?=
 =?utf-8?B?eGRmeUVKa0U5ZFRYRmplN0JTTnNtQUhKbTRObDhzOU1FZ3BrSW0xUGoydVdV?=
 =?utf-8?B?OEtxWUgzSE9YSW1hVGY3WDUvMW85dTFwNnlXMDl5bDg2c1hCendyNGR1aWFh?=
 =?utf-8?B?b1lta1R2cldLLzZYWHBpOFFGTVdnVWtna3JjcnhUMnhJeGxPbHRvQ2J6bmV1?=
 =?utf-8?B?NHFKTHpKaURNdGFNKys5ejFQdXlnSm1YQldkekNUdDk1M250TG44YlBLQk8v?=
 =?utf-8?B?d2x1dTBnbzZGcWFaTWFGeHZlZitHc3BoVEZKblFISWlYZFgwd2lRRkpUT1Jv?=
 =?utf-8?B?b0xBR1NEZHlScGtUTEZkNDJ5bWlYL3k4VGQwR3ZtTllQUFVkTzM1eVBrakNK?=
 =?utf-8?Q?GoCY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c1b624-95e2-422e-cbf4-08dc99fbb0e0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 18:29:06.4541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r8gsBBB62Y0BJ7WjzERrhV/yIjFb6DBlzCxscf7ebIb4VAcgaMDPaa5VTI96JDHSRHs0eIUldHojejW+WhCeyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9194

On Sun, Jun 30, 2024 at 10:21:03PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Jun 17, 2024 at 04:16:46PM -0400, Frank Li wrote:
> > From: Richard Zhu <hongxing.zhu@nxp.com>
> > 
> > Implement i.MX8Q (i.MX8QM, i.MX8QXP, and i.MX8DXL) PCIe RC support. While
> > the controller resembles that of iMX8MP, the PHY differs significantly.
> > Notably, there's a distinction between PCI bus addresses and CPU addresses.
> 
> Do we know the reason?

It is IC hardware design. Some high bits of address was changed in HSIO
subsystem.

Frank

> 
> > 
> > Introduce IMX_PCIE_FLAG_CPU_ADDR_FIXUP in drvdata::flags to indicate driver
> > need the cpu_addr_fixup() callback to facilitate CPU address to PCI bus
> > address conversion according to "range" property.
> 
> 'ranges'
> 
> > 
> > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c | 35 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 35 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > index 18c133f5a56fc..d2533d889d120 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -66,6 +66,7 @@ enum imx_pcie_variants {
> >  	IMX8MQ,
> >  	IMX8MM,
> >  	IMX8MP,
> > +	IMX8Q,
> >  	IMX95,
> >  	IMX8MQ_EP,
> >  	IMX8MM_EP,
> > @@ -81,6 +82,7 @@ enum imx_pcie_variants {
> >  #define IMX_PCIE_FLAG_HAS_PHY_RESET		BIT(5)
> >  #define IMX_PCIE_FLAG_HAS_SERDES		BIT(6)
> >  #define IMX_PCIE_FLAG_SUPPORT_64BIT		BIT(7)
> > +#define IMX_PCIE_FLAG_CPU_ADDR_FIXUP		BIT(8)
> >  
> >  #define imx_check_flag(pci, val)     (pci->drvdata->flags & val)
> >  
> > @@ -1012,6 +1014,22 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
> >  		regulator_disable(imx_pcie->vpcie);
> >  }
> >  
> > +static u64 imx_pcie_cpu_addr_fixup(struct dw_pcie *pcie, u64 cpu_addr)
> > +{
> > +	struct imx_pcie *imx_pcie = to_imx_pcie(pcie);
> > +	struct dw_pcie_rp *pp = &pcie->pp;
> > +	struct resource_entry *entry;
> > +	unsigned int offset;
> > +
> > +	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_CPU_ADDR_FIXUP))
> > +		return cpu_addr;
> > +
> > +	entry = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
> > +	offset = entry->offset;
> > +
> > +	return (cpu_addr - offset);
> > +}
> > +
> >  static const struct dw_pcie_host_ops imx_pcie_host_ops = {
> >  	.init = imx_pcie_host_init,
> >  	.deinit = imx_pcie_host_exit,
> > @@ -1020,6 +1038,7 @@ static const struct dw_pcie_host_ops imx_pcie_host_ops = {
> >  static const struct dw_pcie_ops dw_pcie_ops = {
> >  	.start_link = imx_pcie_start_link,
> >  	.stop_link = imx_pcie_stop_link,
> > +	.cpu_addr_fixup = imx_pcie_cpu_addr_fixup,
> >  };
> >  
> >  static void imx_pcie_ep_init(struct dw_pcie_ep *ep)
> > @@ -1449,6 +1468,13 @@ static int imx_pcie_probe(struct platform_device *pdev)
> >  		if (ret < 0)
> >  			return ret;
> >  
> > +		if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_CPU_ADDR_FIXUP)) {
> > +			if (!resource_list_first_type(&pci->pp.bridge->windows, IORESOURCE_MEM)) {
> > +				dw_pcie_host_deinit(&pci->pp);
> > +				return dev_err_probe(dev, -EINVAL, "DTS Miss PCI memory range");
> 
> -ENODEV
> 
> - Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்

