Return-Path: <bpf+bounces-28168-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A2B8B6482
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 23:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D42CB2194A
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 21:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137AE1836DD;
	Mon, 29 Apr 2024 21:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="d6MzEwo/"
X-Original-To: bpf@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2043.outbound.protection.outlook.com [40.107.7.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784B1181CE1;
	Mon, 29 Apr 2024 21:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714425821; cv=fail; b=Fg4TZyE3rcQArWVmA0F/4YQojqTAk4gwdQEyUO0Ba/HTkpvhXcTrEdJOdjLqkx118X/AmiDDK+5MFYQhbs8Kf7crZ1IK6XSbDIsUvysvE8OAMpRAC6G88EsthqXM+q0hjVVsLSytnAjyAxZfD6hO0RFsb3jGiGWwgFX9YGyNmx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714425821; c=relaxed/simple;
	bh=dbFVGZrXHsxeQfBwlmW6ahfnkz/suxU3emapI86IKoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fJILCtvsKpivJ4OorseHw0UEUJn5xqpRcCCLGCaWjM84vGljinFMuG2nDqza5U2McIyYis+U/BH9kEXR5IWqb0YElXnSmNCbd5bHb1QyOZZ+Kq4ObLU5VocAaxlrulev5DSFi+iKhTHa9a9W4C6rthbrQiEDXZc74kC8VgmtYLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=d6MzEwo/; arc=fail smtp.client-ip=40.107.7.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ah8oEM2b8/WAqfmy3RYHXVkl74SQG+k6jtrR9UdoTsxSw29BdYupciXIKLwesMNM/B39JDyeI7DeTlkmczjFTaGvgm0Zcm7rlUVybpDp3khp6lO/WkTdrw1jrIjc2DqKIZS0eM8bz7QiRzgbGvd1T6nUWOrpvF8FVPA6+GGQYEc/cjDKArYZdg9lgO7vGKr2lo2HNzN6IY7QEx2Y0jCG6SMdhjvUw9lk59yHjzw//EPO0LaD4JN4ahuHvyBwcOXb820AM//Sjyh850kvN3usLxirBko1y4SWweL74y3TmkDJpfPyaZQE7VSrsJoshZ4Cy9EKJtoq482p9k0C/654gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4DQvtZbSPDRyZuSAxNADOMVHq8fsFg/nMiEvobaKmWw=;
 b=LSTXic4uCmm0MIxzBlrNxUuK0e3TvJMCgJJwQSy3vNE21eYs8Q8G+LhEvW/Dd0bPDHpJwutXAugSlLaVX16WRMqx1RbcmxdJ7RnX43sOP3LWBoemoyKHD+6q0QWhIxWsOwFQ9IHfpYOB8sRI0UTXCKPsHJec27PHejtWJ30bAzs0SK/CAGHn7ZXiGSuYeQhgrikNG6HTOpsm/BQo+dpTgtwQq3HtWwT6BTfQAL928eWWz5C8PmjI5gJNlHMfPV6ZhXPzmzMdFZ5R0MF76jDxM3bKC0q/n6nwDs7EW6fFB1DAvgWPYVm0jPFAd12L4OSkEdRsx7cw24QTkjJRl1XCZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4DQvtZbSPDRyZuSAxNADOMVHq8fsFg/nMiEvobaKmWw=;
 b=d6MzEwo/jIwD7g6IvZDj1h1yugmRvgkwoIhGWhWvV99WiVfSzs0BY/q9QRUIDFyBDl4yCYn+2reXvMwk8uzX/Cv6W0wA3ZJ83Tg008WZ7ZdtXLN36do7TwxIZtb3TmoR37HMyDaqQ6ifC9u3fgoGjO0uJynnTvVd8Ypx9aKgipQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8524.eurprd04.prod.outlook.com (2603:10a6:20b:433::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 21:23:36 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7519.035; Mon, 29 Apr 2024
 21:23:36 +0000
Date: Mon, 29 Apr 2024 17:23:23 -0400
From: Frank Li <Frank.li@nxp.com>
To: Rob Herring <robh@kernel.org>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
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
Subject: Re: [PATCH v3 10/11] dt-bindings: imx6q-pcie: Add i.MX8Q pcie
 compatible string
Message-ID: <ZjAPy05fGLqX6W1I@lizhi-Precision-Tower-5810>
References: <20240402-pci2_upstream-v3-0-803414bdb430@nxp.com>
 <20240402-pci2_upstream-v3-10-803414bdb430@nxp.com>
 <20240429154823.GD1709920-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240429154823.GD1709920-robh@kernel.org>
X-ClientProxiedBy: SJ0PR13CA0042.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8524:EE_
X-MS-Office365-Filtering-Correlation-Id: 34a8eede-ae56-4695-e6a8-08dc6892a117
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|1800799015|376005|366007|52116005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UkZxaS9qR1lwNlVSbmlJRlRtS1licUV0clpXWk05MlNzaU9wU1ZaS2UwZEI4?=
 =?utf-8?B?ck4zeDJ2SDJPTGdneHhlRzNoMlNmcXpTaDJQd0NQMDNPVis0MHA3aEVZaVlw?=
 =?utf-8?B?ZTJ6WUcrYTk4SVNmR1I0VEZVTHU0TnBncnh4M0lrZVgyQ0JtZnFTUHpaL0hB?=
 =?utf-8?B?Y3ZVWlpWQVZpQmtwazNwS3lzS2dXdFo4OFcwWWphYXJ0a293aWdScDRzZjhX?=
 =?utf-8?B?K3MyZUkzMlU5T0hhMUVNUmdycUVCVDFsekxiNWRCSktrZGFteTFCb081VWhh?=
 =?utf-8?B?OVlodCtFOFVjYmNsMUxrM3lDTzZYVnZmWFZTMnpDY2ZWR2NnR1pDNGlxcnFz?=
 =?utf-8?B?TUZ6MGRtbjJValRjbzV6Q3JhMjhyMFFUTDRtMlFXakpVVE9OdWV3SUdBRFpX?=
 =?utf-8?B?Z0VxSXg1ejRBQi9xUFZsVUlpK0k5Ti81M2dwcHlCaHpBUVpreDdSa3VpaFNG?=
 =?utf-8?B?UVpaKzVKMU5RWmhqR0oxcDVmR1NoeU1qN1F1dHlOL0dqYjB6VkRFbTNxQWQ4?=
 =?utf-8?B?bHhmOFNXSnlHNGZrK2tNVzdhSTIyOTl2R2gzYWhqeWM0NUlqRDJoeGJ1dHVT?=
 =?utf-8?B?YW8rVitmalBvQVlrZndXb1duVWlkSTJoRU9hMjJZWFdhODVUZ2M4aG1iVnhN?=
 =?utf-8?B?YzFhWW4rd1grYU5MY0p5Y2hzVWQ4aE5UUkVqdzQvM1Y1dVlGZ0JFOGRWOFp0?=
 =?utf-8?B?SzVMbUNXV09qTGNFTHBoU2svU1hDaTZhVG9hbXkwbTN2cGNDVThhVFpEUTIw?=
 =?utf-8?B?RC9vVlV0NE0xYlZCNG8xNFprR2pRWmZRM2IwbzU3T3lFRUFPMW44RGtBcWNw?=
 =?utf-8?B?em1YZ21zQmFzSWhHUlNuRlBjSEF3ejd1K3lBOTNtWUdvZ2gweHhOZW9GRUhZ?=
 =?utf-8?B?UGJCbDBsc0xtRS8ya1o2Y0xOQUVLbE5ZZFVFWTgvMW1zSUFqYm5nWE1hSXNW?=
 =?utf-8?B?YUo2ak95U0thMjVmSU56YlNRNERtMDl0amdESzdPczlQQWdNd2Ivb0lTTGxS?=
 =?utf-8?B?bzFobHQwaU9hUng4OWhaZlFHSVdYVTVKdW8xNWRmSU5WVTQwWVJENDhqamZI?=
 =?utf-8?B?cEhKTW5OcFBkcWQxUGFRSGlXUXFnK3JvcXEwQ1BaM1p3SXEvcnIzc3NtRmEz?=
 =?utf-8?B?MFJKMi9wU2xlYnhrMmozMDl3cCtlL3FEWHNhU1VtMjFVUHlpaXZRTWlKTHcr?=
 =?utf-8?B?ZEFhWmljMHVMNkl5ekxScEVKUWNNNXRHYTVXb3NwWWZBVmlDajRQb2NxeGt2?=
 =?utf-8?B?SjF0ZXBPVWg1RUZ6SzBwaCtYSFJta1QxeXAvYnFzdEV1SFhCWU5uaVJlNEk4?=
 =?utf-8?B?dzZOWExWV01kWm1zZ0JWc0d1WE9tdHg5ZmljclpCRWFsaDBYVEc1R01LSlhW?=
 =?utf-8?B?UWlqVndZaXpFTDhjVmhYaVIvMlFDVjROOXJ1OUdkVENSMkpEWmU0clpqSGFt?=
 =?utf-8?B?RldUdUQ4WUFNUVdEZmdqMFZrMHdySTIxRjZmMFREQXczOGp1MTlYUHZ2NjFW?=
 =?utf-8?B?Z3dQMVZ2T0c4MGk5eHRpVFcvVzVmNWtmalJ0YmluMmhMNUpjanBHaTZoTHNu?=
 =?utf-8?B?Q1VpcTF4Q29EN2Mxc2I4Z3J2RndrMktrNjdtQlE1WEpPdk5OQllFSUhiam5L?=
 =?utf-8?B?SXRSYitkSjNZbUs5ekhyY2p6enpES013OWlodzE3M29SNUtMeExWV1RsbW9y?=
 =?utf-8?B?L2NjTmx5Y3I2TitIWWErWSsvemg4RjZiVUExSWh4Z0pvSFJNc3g5VWxBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1ZJb0Q4TDA2MEt5MmI4WnVkWSszMG80YVFYT0pQR3I3bjFjaE4reXp4bjdI?=
 =?utf-8?B?UVlreFB0T0tuWHNvZjl5YXp1c3d6ck1pOEp3bi9hMWFIRFUyVHcwR0ZQSTNR?=
 =?utf-8?B?RjVNc3hNRUhwNk1tbkkySCtHM29UVk5sb0Jqb3FtQWo2ZGwzdVVBeW45dHhk?=
 =?utf-8?B?anZHN2RCOVpZSkp3ckVkU01uRzczTlU2eUNjZHFpb3BjLzk0bFgzYjVOUkcx?=
 =?utf-8?B?U3hMT25IbUZkcHk2VmlaSExPcVRRQmtwTlJpc3dxdHJUbEZpRk1pTm8wY1Ax?=
 =?utf-8?B?ZFF2UXdTNHYwSHU4Y3VjK0gyNkx1UnpBT3M1WU9NZmZDakVsYmszbEw0QTJm?=
 =?utf-8?B?Q09ESS8zOFRIVWZSdTNDbGY3eGp5Nm9pTkcvUHptOFVxUW45VkU5b2VnbVgy?=
 =?utf-8?B?WnFFOUxaNnBpTmluSW1acXJQa1lTeDVtZlZMaGJONGF5cURvanBodDU0aTZH?=
 =?utf-8?B?YnNQSW5JMmRmSmYzU0UwbUhWNmMrdUVGbmlORlZBZ3hsTTB3ckZHZGhPbmlw?=
 =?utf-8?B?N3RndDVFVGEwU1lTREZuM1ZndDl4aERXb2JqNEZ5eTkxWHlFMXJNb3RVL1B5?=
 =?utf-8?B?NlRBb01BbHZ4d1dobDh3Mmp6UEFyeEdMcWlsMUNLc1FQTG9ZdnlyZU04L05X?=
 =?utf-8?B?ZmY4MUJRSkU3ay9IRk1aeTh4WGZ4bzR1NWlKOW0rYmlHc0lURTFIL2EyaDND?=
 =?utf-8?B?a1FjTkxuUFNidHQzSkFXblpxQ2FndDNzSGxPank3RkR3YTNIRlhWczl3ZkVW?=
 =?utf-8?B?WEIrcE1sODIwK0EvdUZQZy9ZNXNObmlsS2dsRGFscHEzTnhBc0ZHdkVQNzZk?=
 =?utf-8?B?Y1A4c0ZkdnREc0swMDF1dUJnb2FJUE9nYm55M1BFYXFZWEVLQ0ZYZjBnYVh0?=
 =?utf-8?B?S0RoMmhTYUZySmdIOHpCZkNudm8vbGs4R1dqTmsxQ2dVQVJQc1AzZ3ZZWlIv?=
 =?utf-8?B?czJQT1Nnc0FGOExjMFVlQllWWnlGUnRXTlFvdTlsNlFlSHhHUWFSMkdVekt1?=
 =?utf-8?B?OG9OL2xNVzhuNEFGa2dJWmFucVZBYWFFY1J1Y0NnMVhUVmRYNXFlVjRMdFMx?=
 =?utf-8?B?ZzlxSHliTDAvQ0ptRkx1dmk4eUJ4VkhmRzRuZGxsSGhPR3cxQUZuNGZERUQ3?=
 =?utf-8?B?Z0JmQzNmM1JxMFpGR0svbk1NNFBWSllUQ2ZIQmxFOVJYeHhyYUhvdkRNbHdl?=
 =?utf-8?B?UVRJWTZjenEvQ3VtaHFscjZyNUNuOU9FYkppVmZ4N29EcENRckN3QmUzVjU4?=
 =?utf-8?B?UWpZdU9tQW1FazJtNWwxYWdIS2VCZFZwZmZCSm4rWXlFQnNhMmlqdG9ac1Zn?=
 =?utf-8?B?Y0hvUlQ3SDIwdnFCcTVpUU5CS2RISlEwTmc1WWNrN0RYVDJXb3NRZHRNbU5I?=
 =?utf-8?B?cWdFbDlsYkRpbWM4dElGUko1VDFQM0c0d1J1cGZPZXNJSTFQbk44TittU1Jx?=
 =?utf-8?B?YUdLeU9ZTWgzelRNL0oyekZwOHFWZkcwQlVvT1JvWm5BbnZmVUIvWlV1ajhp?=
 =?utf-8?B?cUxXYkFxYnVJWXdIZHRKSTEwSkZhdHMrQS9EUHhjeXR1YVEwc0FsME1hSmg3?=
 =?utf-8?B?TmNmK3dmd1JibDFaWjJHU3ErWUY5eXVKeHE4ZDRVOVNrR0dNa0ZTTmRUaXZY?=
 =?utf-8?B?dVgvTTBLdnpKcnB5cmlJRk9pS1gvSU5xZGEwdEVKTXRJMmpXNEo3V1pzMGlP?=
 =?utf-8?B?QzhxdVk4SFVVYnNxTkg0OUxmTEtnQUtJVXhJRUJCNDA4azBqckxzVXE1RTRz?=
 =?utf-8?B?K3hTTGo5dVlqb25tWUp6N0xFWHJkVjV2MjA0S3h6YmN4YzVwNWI2NDE2Y1Fl?=
 =?utf-8?B?MndpajN6ZnlYdEFlS2Q1OFFHTXpURTdpbTFRWm5qREFMWGY3NEIvd3E0WkhZ?=
 =?utf-8?B?enFjazV3QTZmd2pYL1Q4Tzd6RVc2cTBLZzgwVVV5RW9icU5wb0tLRDB2Rm5l?=
 =?utf-8?B?emxTWHlSL1ljUmQwbmVySHh1ajRuVGJmWFU4eTBDNll6aFowUjkxakRla2FQ?=
 =?utf-8?B?U0g1WGI0MnoyaUxNaytaK3VjVVV4cFFHQWQ2ODI0WExWS1VNUnZDTmNVNUdz?=
 =?utf-8?B?ZG8vOEpMbTM3cWV3QnhOYkE0RXMwa0x0MkdxY0MydnhJWC85RzQ4TjN2UTk3?=
 =?utf-8?Q?upiIBW67t5SIzFXhAJCVr6fDu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34a8eede-ae56-4695-e6a8-08dc6892a117
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 21:23:36.0355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kIK3cRQ3aQjZa1MTB/a/CzouZoywrlkmxAWt0Az7m9hk4+NFa5th00KmFlgT33wzEut6uqaAhdReP9yq2gwW5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8524

On Mon, Apr 29, 2024 at 10:48:23AM -0500, Rob Herring wrote:
> On Tue, Apr 02, 2024 at 10:33:46AM -0400, Frank Li wrote:
> > From: Richard Zhu <hongxing.zhu@nxp.com>
> > 
> > Add i.MX8Q PCIe "fsl,imx8q-pcie" compatible strings.
> > 
> > Add "fsl,local-address" property for i.MX8Q platforms. fsl,local-address
> > is address of PCIe module in high speed io (HSIO)subsystem bus fabric. HSIO
> > bus fabric convert the incoming address base to this local-address. Two
> > instances of PCI have difference local address.
> 
> This is just some intermediate bus address? We really should be able to 
> describe this with standard ranges properties.

Yes, Maybe dwc's implement have some problem. After read below doc again
https://elinux.org/Device_Tree_Usage#PCI_Address_Translation

                  ┌──────┐  ┌──────────┐                                 
┌────┐0x18001000  │      │  │          │                                 
│CPU ├───────────►│      ├──┤  Others  │                                 
└────┘            │      │  │          │                                 
                  │      │  └──────────┘                                 
                  │      │                                               
                  │      │   ┌─────────┐                                 
                  │      │   │         │            ┌───────────┐        
                  │      ├──►│ HSIO    │ 0xB8001000 ├───────────┤        
                  │      │   │ Fabric  ├───────────►│Bar0       │ TLP mem 0xB8001000   
                  │      │   │         │            │0xB8000000 ├───────►
                  └──────┘   └─────────┘            │           │        
                  Main Fabric                       ├───────────┤        
                                                    │           │        
                                                    │           │        
                                                    │           │        
                                                    │           │        
                                                    │           │        
                                                    │           │        
                                                    │ DWC       │        
                                                    │ PCIe      │        
                                                    │ Controller│        
                                                    │           │        
                                                    │           │        
                                                    └───────────┘        


dts should be

ranges = <0x82000000 0 0xB8000000 0x18000000 0 0x07f00000>
		       ^^^^

u64 imx_pcie_cpu_addr_fixup(struct dw_pcie *pcie, u64 cpu_addr)
                offset = entry->res->start;
{
	... 
	return (cpu_addr - entry->offset);
}

NVME can work. let me do more test.

Frank
> 
> > 
> > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  .../devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml |  5 +++++
> >  .../devicetree/bindings/pci/fsl,imx6q-pcie.yaml        | 18 ++++++++++++++++++
> >  2 files changed, 23 insertions(+)

