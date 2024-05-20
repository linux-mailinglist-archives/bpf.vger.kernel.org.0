Return-Path: <bpf+bounces-30033-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE328CA064
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 17:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 658A22822AF
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 15:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDEA137915;
	Mon, 20 May 2024 15:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gAIrO1hr"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2072.outbound.protection.outlook.com [40.107.105.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3708D137747;
	Mon, 20 May 2024 15:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716220772; cv=fail; b=PFHcXigZmLIl034YPMX+09Yj001x+n6Y2aCaHUnAUrGP60pPqr7DT2D2xtb9bRbmNibJWiogd0sDMxDJeY7Bi1c4Yq9JFKiuNa77W/kTnzyPzRn1u9NYPQD+PtxwcB75whhQ4sknHbpcPj0yr3lM9qEqvedcx9NG0+jgM62bN+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716220772; c=relaxed/simple;
	bh=MGPCFFgE2fdhHlP0SPhhvoJC/wt7k8NY3IVvQiqcEQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bxgOBZAeyqgVNYU28I4tR6Gn8HSO9DehE6EpgJvcg6/lzA4PSR5n0X4tsST08qYGqMi9M2OLdHkCzRKe98p9I3Jp3IKv+EoHJ6fPnSe86G/q89IfPu9Z1pcbpjaoymD7dl1fJ7qfbUb8QzDBsF6zdYa2KjweXhJAy6JtHZPecEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=gAIrO1hr; arc=fail smtp.client-ip=40.107.105.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IDUn+zhhUWBSzyBf0+6by6atTDH/yHmyXAvHA7xGqqJhaRPytwml9Mh9rDeSFDQ2bxgjkqnbJ3+EMIxy0OMabmROFR0bsnAnuqNND4Cm5ManAWXcS5x3cXZi2lAuBRt1hcBg1F6upeiW57bdeK7YB0tDPv9smSFB6zpmBLV3aQLMpskAqD15G+EAHEb58uJo+xA3ZtVMhkMnWnp+91pixddwdHoRqIukG9qOuHtx+ciSHWrUnEZD3RwJABAxs444cnCPSgdh7Za03T7HBmkJHLI33PFZQN1hVq5OLgMzQnMYfbbXcoowwEinjiWki/t6GNlZzdW7RmRwJ+QHFavqIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ge9FaRa6r3fjej23Pdj/Xeq2v/1DoKTAc4Dw+6Wr3vo=;
 b=Rdw9IKhMSqaRm8IjYr0GdWlCnJgGqWq9ioMUHYmKqs2jKGTe6eGrDW+0P0wT/wWuQbkKvly9Ax0pnoLQHEOb0wx9QKaN/GHs1vTvTsmpaAJFYFXcR75mHRxISwxxTOgqXeMSZ3sRF1F8BQ914y8TopOlVVSTN2nl8H4HIBrWyqmmJdUPAwHwLlrVpo2ifhK/GN6kywDw4v2vgL80DhMPatGFp69yd94H7+tPjdE/znJh26ztAxkaEuvJa3xdJ6vPAoty/7ongJZ/V1OQytCrfA2t+AFLIKTlk9GrMvApdCxBZ5+ONb67Dfg+FolhTkicAcOUv5Wq+3IRhnqYMTgCQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ge9FaRa6r3fjej23Pdj/Xeq2v/1DoKTAc4Dw+6Wr3vo=;
 b=gAIrO1hrlBw7VdifakX0YYKC6BuxVWbawzQj+coIBWR46F1o12Xulpp4qwAjB6VXL4Wx+PcRSrTgu/mqM+jtSLbJHLBavgjbEuDfH5Vgiaghyxl2HyV737C8ul8/mnkOadNzYvSgHCG1RvS8xX7BbdEXbvyB1x7uI8Jmd9HwtLo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB10368.eurprd04.prod.outlook.com (2603:10a6:102:445::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 20 May
 2024 15:59:26 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 15:59:26 +0000
Date: Mon, 20 May 2024 11:59:16 -0400
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
	Jason Liu <jason.hui.liu@nxp.com>
Subject: Re: [PATCH v4 00/12] PCI: imx6: Fix\rename\clean up and add lut
 information for imx95
Message-ID: <ZktzVPsLexhMVY1Q@lizhi-Precision-Tower-5810>
References: <20240507-pci2_upstream-v4-0-e8c80d874057@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240507-pci2_upstream-v4-0-e8c80d874057@nxp.com>
X-ClientProxiedBy: BY3PR04CA0028.namprd04.prod.outlook.com
 (2603:10b6:a03:217::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB10368:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b790a0c-b1ad-4dfb-4098-08dc78e5d30a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|7416005|1800799015|52116005|376005|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MzR3YnVuSEgvclg2ajN4Mmh1VnJOMHlZUHcySU1nR0hFSU1kajd1TGJUdkxM?=
 =?utf-8?B?aklUbVJHNUN4ZGZhemFLVEF2aWZLTnovVVZlVUR0cHZiM1NNZ2NuTThjRnh6?=
 =?utf-8?B?bmJGYTVnTTR4TVJWVUhjeG1PMVhqRkxKN09EYlltLzJRSmluOU5nVUE1cnEy?=
 =?utf-8?B?bG16L2tRSC8vNFdvdmIyKzY4NWhRWHNrL1Z5SjJCM3dOYTdBc0c1TUxpREky?=
 =?utf-8?B?cndjSlNZWWY3M0Fkbnhwd0g3NTIzblZpK1g3b0dkTFk0cit5NDdrQUxZdmV0?=
 =?utf-8?B?aHJiRDUrNXU1UVplNlVwTjRBVnBPY0NHWmN3N2pZZ0ZNS29lY2luOFJQU0t2?=
 =?utf-8?B?ZzFKd0dpbEJ6NzZ4MkMvZWRxWm9LOFdvSUVXdDd2V3FTc09oS1dmbTJhRmg1?=
 =?utf-8?B?TXJrNkVxT3ZLMWJoVmUyYUpQTk91R1BaKzVPRVc0cWZ2Tk5VSGdVWEF5R3dD?=
 =?utf-8?B?clJES3YrakYrTGpKOWt2T0l1L3FKM2IrQzgzTU16dmxLZE1FUkdXbUQ4bmcr?=
 =?utf-8?B?LytiWVBtSjNrR09hMWgzeUFmWWpKZi9GNzJkODBCUE9tRXlZWFZ2dkZqYUtz?=
 =?utf-8?B?MThqdUZLUndQbnRIckl0dXVTSHIxMW9IOERSZ3ZxZjhTd2VDcGpycWlac0xW?=
 =?utf-8?B?TTRkemQxbS9HeGpQeUV5eVRvdEtMam01dWppbzJuVlFTU214VUd0bnd1Q0ln?=
 =?utf-8?B?UnRNd1hDQUk3dDNYcGRvaWMvQkFrcWp3bWljUUNqUzFRWmQvSitNYTFzMkJF?=
 =?utf-8?B?STdHSTF2SXF4VmhCY000SmZmRW9meUZYS1V5SktCWVF6NUhra3NnYndkS0hu?=
 =?utf-8?B?aUUwRFM4YmtwNUxlUEh6WGUxQzRoc3pja2Q5YllxSVN4cVgyQnlCSm5KVlVE?=
 =?utf-8?B?cDByZkY3d1ZQa1ZDcWU1V2JmdXJoRWs1amtwRGVPNTVoUmZHYTRjNGROc21m?=
 =?utf-8?B?bmVoNXlzSStTSmFnY1R4ck1tUTYzOEdrR09YODlSNUxnZkU5eTJIcHRrbEln?=
 =?utf-8?B?R3daK2Q5NmIrY0lUbjZ4WklMY24vQ1NabWZTaVM1UFYvZ012K01nVmwzQWJ4?=
 =?utf-8?B?U01Uc2tydDBUL1JoT1ZTdFhObDJ0Q01aTG1sUW05TXpUaE1zakh2U0U2SFBW?=
 =?utf-8?B?WGJ2OVhwYlo0SU5GYU5PNTNlc0JkTURLbEpBRVBHKzZLSWZUR0k5V0YwSERZ?=
 =?utf-8?B?QWVYSEZUODEvWlcra091UVFSeVlVaTRRNkpxd2Z2ZkJDaXJLRzlCUzdjdDIw?=
 =?utf-8?B?bVZoblNFOGVRZFVMWkNmQUVsSWdtVVZTZEF3SHpJTTJNTHN1azBOQjk0SXhz?=
 =?utf-8?B?b1NBc1dmS3l6SXhWd0dXellldXJ5RGN0MEc4MG85YlVqZFJ3a1lXTHYvOFJT?=
 =?utf-8?B?c3lWQXlWRktFQ09xSWtySW5xYUFwKzNIazZOYWI0bGJ0N0VIQmt1U1kvUTRC?=
 =?utf-8?B?NzlYYnVKd3dXSEdFdXVFSFNWQ2tMYnNZclJ5YjNDZ2pzSDlOcjFkVEQ4Y3dX?=
 =?utf-8?B?QmRKZzR3SFVLRWNLUGsvQXhRdGtYZXcvNmNZeXZQcDMvOE1WU2xEUkx4VjFO?=
 =?utf-8?B?bFNabzlLTjlTZjJJVHBYbEV4a1Q5bzJMTUx4UGRLQmpGQTlYWG5lY1JJbHFY?=
 =?utf-8?B?M0gwa0ljbFQ3U29tWXlaTWFmMnRJVjlJeWJ0TVVXV3pvY3FwVnk4M2tNT1FG?=
 =?utf-8?B?TFpBM29jaUVhYy9vY1BRcmVKWEpFUGJ1WWQ4ck9NeDlueTdyM2RHRkJqeUJF?=
 =?utf-8?Q?Tiw+t+fTr52UTF0l+k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(52116005)(376005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TnVaSk9QRXpvNzJmS3pYMjNKc2c0T2dRMHNENGMzWnBsK3VmQkt4aE0xVDcw?=
 =?utf-8?B?dm9DY2ZhR3F6WFg4aVpaRWNsQ2NVOEZxbSt4UE83cmRGN3NtOW9sellpazJS?=
 =?utf-8?B?SU9uRGxuWGJqS2FzQXFRa3JzazJpMndnemd6ZHNIWWltcU9pYmY3YlpQWDQv?=
 =?utf-8?B?NTlJNVEyaGkzZGp5eXdLMElSeUxpUnh6N0hYR0I0VUZiTkRHUFZuSDlrRXpV?=
 =?utf-8?B?NGpKV05EOFMzZ25aV0FPSE12a2srMzRlVDROOWFxdktvSGlLUXp6VWpQNHVH?=
 =?utf-8?B?bWZBdWlYRC9kcVQwY3dydzgweXV5TDJjTi84cXB0SkN0NUh3ZDZTWTNjU0cy?=
 =?utf-8?B?YlBoaHZyMStzQjVSNjJIOWg3RjltbHQ0UGxSZ1N6Mm52KzljNzBTRGFKdUds?=
 =?utf-8?B?TnZhTDJ6WGRmYlBpdmJ6eTBNcE5pRkVObHJ4Vm44d1RTS0dhY1dob2ZvdDBw?=
 =?utf-8?B?eTRlQ3hzbUhORUZMczltQy9lM2FiTWlHQm1aZkxzZDFGSVJKb3FNOUJHNk9O?=
 =?utf-8?B?UXNTd3ZTWTh4L05TeE8ySlJTUkI4RS9PU3ZlRSswQUxZcGZuN2UyNStzb2I1?=
 =?utf-8?B?WG01aEs4MUh1SDVvKzdGZHZ3SmtYZHBLZzJBckszcGE1ckZiTlJiOHdWQVda?=
 =?utf-8?B?MmJBYW1HaDBjSnlaV1NucmxiaktMclB4M3RJUlhiZm9VbllqcUhmYUlYQXRp?=
 =?utf-8?B?OEZ0d1hxM1N5Z013WWREcUVGNy94am5jRzdzRzRRMTF6UHE5cm9SaS9JSWNB?=
 =?utf-8?B?M1Y3TnVCVEVwYTdXV0FPaHVicmxCN3lGdklzTmIyWXVELy8yVEk4Um5KU25H?=
 =?utf-8?B?ZERsOWozS3ArOHhONEd5aU9IM2w4VFMyU2FWa2xwanNsSzU5b2szMXBYYllR?=
 =?utf-8?B?WHFIZ3phbzlRaUdoK3MyeGZjZ0lLYXdoYThHZkhiQWpMQ0lHdHJzMVI2Z0tX?=
 =?utf-8?B?S0w1UWVkVmhqWEdEcDNZRk50T3lud0NncVpXcHUyRGVzbG9wUHpiY2ZzU1Bj?=
 =?utf-8?B?UFJCQURkZGE4V0VtSFQxSDRXcTI0WHFTR1ZxWWhZYm5KcU9DNFVPMnJObWNp?=
 =?utf-8?B?dnNiUEtSck5hNktRcWxTbUpsa1hRT1B3MDJGalRySzdlSnZka2tYaDB2aXZJ?=
 =?utf-8?B?UXBjWFUzSklzdXNGVTJEZHQ4R3VoKzdLM0JKRGlmUml5cU9QQ0VVTmRKam9D?=
 =?utf-8?B?alI1amp1SnB0MUlSdVZXenRVc2NWTzViZkxZRFN3Q21aZGZ5RmN1SzhTM2Z0?=
 =?utf-8?B?UlNGdUxPVncyMjJ0MXFtK3hOaEt2Sm5CeklhYThtWFlMcmMwMkNDc2pwK2ZR?=
 =?utf-8?B?UGw3RnVXZXUvSFdtazBtd3Fnb1JzQ3ZQYnJmU3d6K3RSL2Y2NE5TR2RVbm41?=
 =?utf-8?B?NEhoSjBxMm1zRW1hRDFyUlZXNll6MTRhbTJHZEdnWmYxamdVbXVQY01LMGtI?=
 =?utf-8?B?Q2FOblBLTUl4MWFyeGlSMUNXcXVsY0Qzc3pqVEhMYmtIUWJ1MXpVVUtUM1o4?=
 =?utf-8?B?L2RMeFhKTU1HUTRsMUo4dGtWc20zTmhub1JLVENTYlZZZXZ1K1VQaDY5NUZk?=
 =?utf-8?B?d2ZZKzUxZzlldzFmcE91a3g4OHd5emw1TkpzL0FtcjdoajhTR1VybjFTQmFx?=
 =?utf-8?B?ZXphQ2R2WDNBUDBDN3MwMlVsU1R5Tkg3ZlhKallTci83VEVBdXc1N1JEcUxn?=
 =?utf-8?B?bXJ6UGZuNXJYeHEwRndSbFlPa3Z2UTVlQmVxZTJDOUs4blRRR2xhOUZrMWJr?=
 =?utf-8?B?M01WWTkrdTQwUVhoUG9scVh0MWtGajJWaFpBaEk3ek5ZbExKNWlEWG0zaHEw?=
 =?utf-8?B?bEdRM2ZTVzZIeFpEWk5CUEpzeDZTQ0pKTkxyNVB6N1BKbnZQdXR0NlBWemo1?=
 =?utf-8?B?dy92eTd6TnNHQWZwN2JoOXpjcWZzUUZQdUp3Ym5NTHFWenAyMWFSVWN4SEN2?=
 =?utf-8?B?endrRG0rODhGK1JSSUNkWW5kbGpUdWFnNHV2ZXlaeVB1QVJjaktITGVxN1dj?=
 =?utf-8?B?SlRUU0J6SFJjSDAwNzFvWGdydmhDSDFlbXpmN3AyUFZORXgxUnNCZjZTQnU2?=
 =?utf-8?B?MlR1YlBTZ1NDSyt6Sm9KV2ZKS1ZDbnpIdjR1ektnbUF3aEpDUkNwNmwxVkls?=
 =?utf-8?Q?PCLMf3n+/fTrglfXD4plujt7x?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b790a0c-b1ad-4dfb-4098-08dc78e5d30a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 15:59:26.4147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VJPIiCouuw4ojj35JFKy/iae5kRd5uaWC1NlBapBxGIN15KOpUF5cNqYfNI/KTrrsazV06oqYU0/s8J2UFv3Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10368

On Tue, May 07, 2024 at 02:45:38PM -0400, Frank Li wrote:
> Fixed 8mp EP mode problem.
> 
> imx6 actaully for all imx chips (imx6*, imx7*, imx8*, imx9*). To avoid     
> confuse, rename all imx6_* to imx_*, IMX6_* to IMX_*. pci-imx6.c to        
> pci-imx.c to avoid confuse.                                                
> 
> Using callback to reduce switch case for core reset and refclk.            
> 
> Add imx95 iommux and its stream id information.                            
> 

Mani:
	Do you have chance to check these again? I fixed what your said
at v3.

Frank Li

> Base on linux-pci/controller/imx
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
> Frank Li (8):
>       PCI: imx6: Rename imx6_* with imx_*
>       PCI: imx6: Introduce SoC specific callbacks for controlling REFCLK
>       PCI: imx6: Simplify switch-case logic by involve core_reset callback
>       PCI: imx6: Improve comment for workaround ERR010728
>       PCI: imx6: Add help function imx_pcie_match_device()
>       PCI: imx6: Config look up table(LUT) to support MSI ITS and IOMMU for i.MX95
>       PCI: imx6: Consolidate redundant if-checks
>       PCI: imx6: Call: Common PHY API to set mode, speed, and submode
> 
> Richard Zhu (4):
>       PCI: imx6: Fix establish link failure in EP mode for iMX8MM and iMX8MP
>       PCI: imx6: Fix i.MX8MP PCIe EP's occasional failure to trigger MSI
>       dt-bindings: imx6q-pcie: Add i.MX8Q pcie compatible string
>       PCI: imx6: Add i.MX8Q PCIe root complex (RC) support
> 
>  .../devicetree/bindings/pci/fsl,imx6q-pcie.yaml    |   16 +
>  drivers/pci/controller/dwc/pci-imx6.c              | 1193 ++++++++++++--------
>  2 files changed, 736 insertions(+), 473 deletions(-)
> ---
> base-commit: 9d8b196fd12e52820a40c21297a97ea6186aa87e
> change-id: 20240227-pci2_upstream-0cdd19a15163
> 
> Best regards,
> ---
> Frank Li <Frank.Li@nxp.com>
> 

