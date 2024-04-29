Return-Path: <bpf+bounces-28120-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DB08B5F39
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 18:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFD76283783
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 16:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A478625F;
	Mon, 29 Apr 2024 16:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Xh1yZ5Fu"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2077.outbound.protection.outlook.com [40.107.20.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF6B85C66;
	Mon, 29 Apr 2024 16:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714408720; cv=fail; b=CM02pAA0WPtV0uwT+V+MysoAmFJV7OMMu2Fx0ZQSvoueJLL55qthgbSnMKg4WSren1NuvrPCvKYYAOETx73AinBw/aw94ZOXk/bry+nysyvFbT5QYU/D/3n+wHhMKl5GV6M81E1bg5PsdsTO/UuzNHORy7NakKPFmcc8BOF1V3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714408720; c=relaxed/simple;
	bh=wIeWFH+/bqlL0VkcBOXEpLhyz7on7ViRJQcx2JzHbE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EKIfqN1JWYcG6a6e/+7pJo/4ax+LLMH+pCTAQHBFNbVLeHAPctRE6gXT5xPnJJd6rI8mQCTUkzx/M2dRS8COipHcobKbNmcKv+V/tRhOtSNowwdUBHtkN1g8ogeM223vvuS13AXPZE4uX7TiQJ6Mtjt8jv/lVh6VLbU9QC5Ipyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Xh1yZ5Fu; arc=fail smtp.client-ip=40.107.20.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jzIv+HriZbXbMUBzq3aCOTSIZjDYyHldvyb010D31s2TnTtWIO28jceunOwtaSdhDk7ISwS+galo45TtoP/a6GGg496ulF8nhB7+Anu102POlXxSHMbSdkAN+BkpzHFfwRpEMWLoXc2bV3NrFGP2VsVED5CtLr4bPTsjBFvgS9ydH4PozGl05aAT6hd03YFXqvo3zgVWmM9VBAOc/3uG5kTdcoxDqTKdclo8sB9/wjKkfO5go3wh5pDEo5jktDxnniH4o+bI/EtPbQuMBgALf+2WdfEKwYi72LVVqV28Af/jE3Ccrs7uYtUvqD/Ttb9+dgLzRp4e10i1mv2a6VQDqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SXw+C3h0bhBKXSKdFZydf2DAkoeyuqS/CXAF4s9q5q8=;
 b=lVWr6NTRG7xcWI8KPCgALpJyDnspk4sHuLfitd1yn4RdlK3iWaKwNw+IAN86kjGVbEFqB7dgANY3AJ+B440CBtxW8Zj2v8/T01DJxJetG5UcoPutZMzf5gmqu850HnLuH4kDdsgUj5DPHYyorwTG64CUbvddUrEQthOaD0Zp/1YIPnsWwlITIjYsloXA/QrSi7NtfGeUWzNcbZFr4UYQOF96US6OLuQiAaKRiXGqzI4tm325PGMQQPRgLzHBy/4/5mMf330tqjRqkHnE3PWsiYeEBys5dOR4qB6vN6GeqPp8/ZeaXb9EWPkZLUnbFV8tmtbPmwaeJt3iNB8aF29z7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXw+C3h0bhBKXSKdFZydf2DAkoeyuqS/CXAF4s9q5q8=;
 b=Xh1yZ5FueAvwq93bFE+yLziw6kTnAfuZ9Rf7hGrMDHf7ebvn+7VJRz82kW1VwetBTEFDl0R3y6epJ5MiO5zcyea4JXpciknd/jhBtDZj4+Kn1fP8+SE0GEtQQVUEdn+4RiYt2uRvZWepa4o3GdLaZHGgPFPljS+rSy//RTY2Ito=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB7144.eurprd04.prod.outlook.com (2603:10a6:20b:11b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 16:38:33 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 16:38:33 +0000
Date: Mon, 29 Apr 2024 12:38:22 -0400
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
Subject: Re: [PATCH v3 07/11] PCI: imx: Simplify switch-case logic by involve
 core_reset callback
Message-ID: <Zi/M/rdiGGF6TGYj@lizhi-Precision-Tower-5810>
References: <20240402-pci2_upstream-v3-0-803414bdb430@nxp.com>
 <20240402-pci2_upstream-v3-7-803414bdb430@nxp.com>
 <20240427101950.GL1981@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240427101950.GL1981@thinkpad>
X-ClientProxiedBy: BYAPR07CA0053.namprd07.prod.outlook.com
 (2603:10b6:a03:60::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB7144:EE_
X-MS-Office365-Filtering-Correlation-Id: 70f1b0df-9754-4d49-7938-08dc686acf03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|1800799015|52116005|376005|7416005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UHk4K1VEY1JaaEFNMnhXZ1FueXVJbmFYejI2dWFtdmV1amdYdFpYcGNzNDlL?=
 =?utf-8?B?NWhER1JxR2tVZXNOeFNLU2RGMWtYbzJLNVhqWi9WQzJZcHFiaHpNTWwyd2Z0?=
 =?utf-8?B?TEtSZklKOU9RdHhyZTJ2OEsxUDUrbmN3djYwZ3BqQzhUb2ZuNW42TGJCMlpy?=
 =?utf-8?B?UWJFTmRlM0ZzUzdNQ0x3bi9Nai9FYXE5MGJxZXV6QlhWaFh4OG5BU1NpOTI1?=
 =?utf-8?B?MmF0MkFQTWdlMmFrOEhBSW8wbFBMdE9Ld0ZneUFmQVJsRmlDSk5YTlVWYytl?=
 =?utf-8?B?R0pqV0tnb212YStTa2ZYaEFBYlpCbUZTZjgwT3pmRDMvOXE2bVVFMnZIZm1F?=
 =?utf-8?B?Z3ROeE9Da284QU9CYVVIdzhoM3Awa3pNbTlHWUhjbEZzeXV4ZGJ4T2RSZk9k?=
 =?utf-8?B?WE5wQzVBN1hiNjRXamF1MkhkNXBQVGFrZmsvdFptZjY0UW5reTdIbTBSMVpI?=
 =?utf-8?B?NXowM3FoVVRCT3hOZkRkdENkOWVVdWZPTWYxNTFsS3JTK3R4SXpuM2NzWm45?=
 =?utf-8?B?Z01QaXJlZWlCblp1b3prSGtaNlkwME5RWjhlN1QzTU9DU0RGQlZPMlZQWmR6?=
 =?utf-8?B?YUlseXRVUnA1UXpUK0NPOTZVeWpxcEx3a2IwOXVmSjA4MWJUTFFxTGdleUdE?=
 =?utf-8?B?TUFlcGFSZjBWbW53cU5VbHdhQWV0TXljNGx1enFiMzk3Q25EQUF3VzcvbE9p?=
 =?utf-8?B?bXB1NDI2cXNqM2xjakE1UWVuRUY3b0pIcEJOOVNxTERrQ2doeXdRWmVzbVAz?=
 =?utf-8?B?dUNPRGJuN2s5dVpoM1hXNVlUcG5xZHAvWnNrMWdiNG5QUU1kSDZKZjdraEN6?=
 =?utf-8?B?ODlZMXVhdnphV3hFalhRUlp0cjFqM3VDYVdKMDV5blhDRUFxQTBVemRrajJa?=
 =?utf-8?B?bHFwNVN5K3ZhZ2VPallObUdNcktvODZxWEhpZFFHaDZsOU9uWU8yZDlWTVN0?=
 =?utf-8?B?OGNzMjQ4WTVVY1JOQU40V2wySWdmamxHelJ2ajVacWFtcDk1L2szeGRibGZL?=
 =?utf-8?B?dFpjUktwUC9iWTNVNGRVREtWYk9JMFNRQ2pZcWFySW41MkhhOXZKOEdFdjNR?=
 =?utf-8?B?MFdzYnhMVEROM3lialZ0bTNrN1ZqTGZQNEU2c0plZ2t5VzhYZ3FVRDh0Rzc2?=
 =?utf-8?B?T3NOTmFmTE1PYmNNLyt2ZGNQeXVSTnhmVzNOenBHV2lpY0pLM3MxZjBtT3RJ?=
 =?utf-8?B?b2kycEVpUno3dk1GY1FIZ3pXZzZVUmNYRjBZK0J2MnpyNHZ5cG8xT1ZRd0dG?=
 =?utf-8?B?L1JmN2hnaFNmcWFWbmxNV1RHWnRLT3FNNnQ2aHNZVmJQaWZVUFBSNjExeW00?=
 =?utf-8?B?cWJXaWVuYkYxSzVEbzV4UnBOZEtXN3lJYTZGVjZCUnFpRTI2TXpGTGR6aVpp?=
 =?utf-8?B?UEZSZ2dLVG1WaitpM3I2TCtWamdiTmJGWmVJM1c4N0lTTEUrQkNVT2J3N0lX?=
 =?utf-8?B?M3RxekxWL0Nzb2ZndFZ3M2Z6cUVQd05CY0lkdlpTS054ZFB1SEdEQnJDVTcx?=
 =?utf-8?B?VWFiNWpBQSt6UTlWOGtWazk5TW42c3R5QW9NeWVkdTMzd21SWnJnRGpud1Yz?=
 =?utf-8?B?MVBRKzNKQ29YMjFNVElBam14TGYrdGE5dTZlZWgzNE9KVHViVk9rNmIrMTcr?=
 =?utf-8?B?RWQ1NFZSMGdER3E5MDFKTmVBc09rTTBnT1V1NlFMcy9KTW9aZEJrUnJvbzF0?=
 =?utf-8?B?eUpNdEdhYkI0ak9Nb1V4TDE3ODNBOWNEdTRoOW1SdnNJb1FsVXl6TFNIRFJJ?=
 =?utf-8?B?NkFBY092N0hVZ0ZXOHMxY2xmcy9KSVJBWG94ZGNCcGorQXY4NTVUWklGbG1O?=
 =?utf-8?B?YW1WbFNzbUpNL2hsbFp2dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(52116005)(376005)(7416005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUR6cEdJeTB1dnhYVEphaUtCV2RET2VrYWpDQUhYaGFOWmk1S0pwZ3NUdGRr?=
 =?utf-8?B?TGl5V3RTWlRLc1VkbitYK1d3T0FMWTViNTlCZFpiTXIxWGtzSDlqM3JvL2ZY?=
 =?utf-8?B?N1VPM21wRnZsMXVVb0UwV0VBekFDMG1tSGNuMWRqdzBuMXBPOVMwNTFDNUdQ?=
 =?utf-8?B?UzZOTmU0emovNmNUV2RDNXdCZE8wUVBNZzNpTm5yMDZWZ0R1Z3NoSHQ5MDR2?=
 =?utf-8?B?UUNwYnNHWjZHYVBSWWUvOXhydmJGQ29odktvdE9BeW9QSjIvOWxQME5tZnhN?=
 =?utf-8?B?dzRhZ3F2OGxnR1pVb3BjMlBLYmMzTjR0VlZTZU1MbjkrYmtvSzRaMXVNY2gw?=
 =?utf-8?B?ekVXUWxVRk9SL1VTRzRuUnByMmpQb0VMTmNaWVhybEJUeHFnQUs2MFhpclR6?=
 =?utf-8?B?S3hMb2RNcW1LSnplUm5wa0didXoyeWM0Skl1SmlyUUx2ck9LVWpHQmtCSFlV?=
 =?utf-8?B?L2QwY3I3N0s2ZmtCZm5uanFUTndySUl1L0cxYk4wdDJqaWo0djhIbW1lMGh2?=
 =?utf-8?B?em9OQXFIYzY1MFhnZnBnd1hFTVdranJtY3FodnliUUhhRmVvV01pdC9IYnlS?=
 =?utf-8?B?bDJ3bmFYc1JDR1N0RWtHOTd0MFFLd3EyUDE2bklxalNaa0pUOE1lWG9BQTNl?=
 =?utf-8?B?TDJDRStDSTBYRGhEaXo1MVJJT3JDd2dnSkhTb3R4bllDMit1RDJuQklROXE0?=
 =?utf-8?B?R01TTGJ5Wmo4MnltWHo1RGs2Z2VPeHJrcXA3clgvQ3FEaUhBcVFyUEI5NkpX?=
 =?utf-8?B?NlVsUGVqclJjSWV0dHhueG9mcVJ2MzdyZTBCNGhWVVpQTDgyNVVQWDRINllr?=
 =?utf-8?B?b1dXMEZTUmNXdC9NUlRGa0VoeDIrSDY3MDNGUDdTemJXYlg2aFIwejZIZG1k?=
 =?utf-8?B?QVdvUERrNkIzQVFIWGVOK0I3TXRsdEhnUzBXSVIrQm5ESFhFRjk3ZU9zYU1a?=
 =?utf-8?B?YlQ5WUVCeXJRSVgwWERFRGllR2dZeTd2VVNXMEwrQ216ZTE2Z3VYNUtJOW9R?=
 =?utf-8?B?WEo1and6eGNGY3paVmhWR3N6UDFiR2dMNlgvNkVCK2JhMVlHQy9ZRnJpZ3ZR?=
 =?utf-8?B?Tmc5Y1B6SHU2SkZwd1hCV2lZMFpkNFZ1M1M1RHlKR0wrVi9aRFM5d3BPcXRr?=
 =?utf-8?B?NWNvY1dsZ2dUanAwL0hlbitHSXg2MGFvZmJ1VmdEUU1lOHF5TmJiSWhzcmRk?=
 =?utf-8?B?azBNelY4QmZtbG8rc253aTZ3Z3ArQ01BRHQ0U1MzZEh3U0NhSnFiMTNXaU1q?=
 =?utf-8?B?ajZvRzlyVWlsdzE0S3k4QjJLcVY0NThzTDBUcFNlcDhablpQbHAyZDd6SjVn?=
 =?utf-8?B?YUVNZVU1b3JvVVVlSzd0bitFczJ2blFnTHYyMjNxK0Nnd2w5WDdQOWIzWFpE?=
 =?utf-8?B?aUZkbDNYT0tITGU1V00yck5ZTmc4aEVzSmVESWdBMWt2TW81OTlYM3c2Vll4?=
 =?utf-8?B?OFRRNGtFSFVSSWZ6cEhSVzh6L3h1QmFIZ1ZCSld2dEFEM042cWdzdmJXeWFN?=
 =?utf-8?B?Z1Vhczk2N1ZWVmdVU1I4bFY2dEV0T2NJREtLUUg3K3BabEx1UzJwOUZMeGZJ?=
 =?utf-8?B?b2tIUnBRaDFoODNCU1YvYlYrL0lId0M2TTlFeDVuVlB4UDBKYU9acXp4MkxN?=
 =?utf-8?B?OU1FZDVHeEVaMk1TWUJ1VHJkSlY3cTkxOHp2N05nNDlYTUFDMksvaTlSZm8w?=
 =?utf-8?B?am1LNkl1TmFrK0tOQTJ0MzJPNndqU0RoWlBSc0xVdExKV2FsdlBNcEt6aS93?=
 =?utf-8?B?dUhKNzB2Y2dXNTVTTFJoOFdHbGxVaUhsdDVBMzNSSkVjam9GN0ttOHlZY0w1?=
 =?utf-8?B?Q25BcnFJamNmS056TG55SnljdXNEMzViVmlHRWdQclNPV0dKVEh6cU1xVHVG?=
 =?utf-8?B?SCsrWG5rK09sSnBWMzViVEJkb0htUzU0VHVMemtpRnJpNWdCNjdjaTloR0lD?=
 =?utf-8?B?NE1hRlBzOEc5bW9Xd0svMXFad0U2R0FDa2FaTndscFNVUk1SSklLcTYyeGFO?=
 =?utf-8?B?aFlQU1pGNFVWUmlQek9YRE1ZSlNuRDhjalpGeisvZ1p0Ukp5TkNGWUc0V0Ju?=
 =?utf-8?B?RVFoL3Z5ZXhoWitVWk1zWExTVDJJR2hvUWxqKzZNWmdsS0RBS3Nhaks0M3lk?=
 =?utf-8?Q?JcFFFxpsjv1En+5Ejts3wZwxv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70f1b0df-9754-4d49-7938-08dc686acf03
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 16:38:33.1375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lv1HzTQznJG+jZhnXT6nj7avS4YAlRZTxUmAkwcPVOVPbWAjHmwkM6Fj7k4pL4QUGFHBnLwCaKErzHo1GRreqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7144

On Sat, Apr 27, 2024 at 03:49:50PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Apr 02, 2024 at 10:33:43AM -0400, Frank Li wrote:
> > Instead of using the switch case statement to assert/dassert the core reset
> > handled by this driver itself, let's introduce a new callback core_reset()
> > and define it for platforms that require it. This simplifies the code.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-imx.c | 131 ++++++++++++++++++----------------
> >  1 file changed, 68 insertions(+), 63 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-imx.c b/drivers/pci/controller/dwc/pcie-imx.c
> > index 77dae5c3f7057..af0f960f28757 100644
> > --- a/drivers/pci/controller/dwc/pcie-imx.c
> > +++ b/drivers/pci/controller/dwc/pcie-imx.c
> > @@ -104,6 +104,7 @@ struct imx_pcie_drvdata {
> >  	const struct pci_epc_features *epc_features;
> >  	int (*init_phy)(struct imx_pcie *pcie);
> >  	int (*set_ref_clk)(struct imx_pcie *pcie, bool enable);
> > +	int (*core_reset)(struct imx_pcie *pcie, bool assert);
> >  };
> >  
> >  struct imx_pcie {
> > @@ -671,35 +672,72 @@ static void imx_pcie_clk_disable(struct imx_pcie *imx_pcie)
> >  	clk_bulk_disable_unprepare(imx_pcie->drvdata->clks_cnt, imx_pcie->clks);
> >  }
> >  
> > +static int imx6sx_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
> > +{
> > +	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12, IMX6SX_GPR12_PCIE_TEST_POWERDOWN,
> > +			   assert ? IMX6SX_GPR12_PCIE_TEST_POWERDOWN : 0);
> 
> Earlier, this register was not cleared during deassert. Is if fine?

Just missed power off cycle, it is functional. But I think it's better
to match old logic to let review easily. 

> 
> > +	/* Force PCIe PHY reset */
> > +	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR5, IMX6SX_GPR5_PCIE_BTNRST_RESET,
> > +			   assert ? IMX6SX_GPR5_PCIE_BTNRST_RESET : 0);
> > +	return 0;
> > +}
> > +
> > +static int imx6qp_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
> > +{
> > +	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_SW_RST,
> > +			   assert ? IMX6Q_GPR1_PCIE_SW_RST : 0);
> > +	if (!assert)
> > +		usleep_range(200, 500);
> > +
> > +	return 0;
> > +}
> > +
> > +static int imx6q_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
> > +{
> > +	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_TEST_PD,
> > +			   assert ? IMX6Q_GPR1_PCIE_TEST_PD : 0);
> > +
> > +	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_REF_CLK_EN,
> > +			   assert ? 0 : IMX6Q_GPR1_PCIE_REF_CLK_EN);
> > +
> 
> Same comment as above.
> 
> > +	return 0;
> > +}
> > +
> > +static int imx7d_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
> > +{
> > +	struct dw_pcie *pci = imx_pcie->pci;
> > +	struct device *dev = pci->dev;
> > +
> > +	if (assert)
> > +		return 0;
> > +
> > +	/*
> > +	 * Workaround for ERR010728, failure of PCI-e PLL VCO to oscillate, especially when cold.
> 
> What does 'especially when cold' means? I know it is an old comment, but still
> it is not very clear.
> 
> > +	 * This turns off "Duty-cycle Corrector" and other mysterious undocumented things.
> 
> Same comment as previous patch.

It is copy from old comments. How about keep the same here. And improve at
difference patch? I copied key content from formal errata.

/*
Workaround for ERR010728 (IMX7DS_2N09P, Rev. 1.1, 4/2023): 

PCIe: PLL may fail to lock under corner conditions

Initial VCO oscillation may fail under corner conditions such as cold
temperature which will cause the PCIe PLL fail to lock in the
initialization phase.

The Duty-cycle Corrector calibration must be disabled

1. De-assert the G_RST signal by clearing SRC_PCIEPHY_RCR[PCIEPHY_G_RST].
2. De-assert DCC_FB_EN by writing data “0x29” to the register address 0x306d0014. 
3. Assert RX_EQS, RX_EQ_SEL by writing data “0x48” to the register address 0x306d0090. 
4. Assert ATT_MODE by writing data “0xbc” to the register address 0x306d0098. 
5. De-assert the CMN_RST signal by clearing register bit SRC_PCIEPHY_RCR[PCIEPHY_BTN]

*/

> 
> > +	 */
> > +
> > +	if (likely(imx_pcie->phy_base)) {
> > +		/* De-assert DCC_FB_EN */
> > +		writel(PCIE_PHY_CMN_REG4_DCC_FB_EN, imx_pcie->phy_base + PCIE_PHY_CMN_REG4);
> > +		/* Assert RX_EQS and RX_EQS_SEL */
> > +		writel(PCIE_PHY_CMN_REG24_RX_EQ_SEL | PCIE_PHY_CMN_REG24_RX_EQ,
> > +		       imx_pcie->phy_base + PCIE_PHY_CMN_REG24);
> > +		/* Assert ATT_MODE */
> > +		writel(PCIE_PHY_CMN_REG26_ATT_MODE, imx_pcie->phy_base + PCIE_PHY_CMN_REG26);
> 
> Why does this workaround a part of core_reset handling? This function doesn't
> look like performing reset at all.

According to errata document, it should be step 2,3,4.

> 
> - Mani
> 
> > +	} else {
> > +		dev_warn(dev, "Unable to apply ERR010728 workaround. DT missing fsl,imx7d-pcie-phy phandle ?\n");
> > +	}
> > +	imx7d_pcie_wait_for_phy_pll_lock(imx_pcie);
> > +	return 0;
> > +}
> > +
> >  static void imx_pcie_assert_core_reset(struct imx_pcie *imx_pcie)
> >  {
> >  	reset_control_assert(imx_pcie->pciephy_reset);
> >  	reset_control_assert(imx_pcie->apps_reset);
> >  
> > -	switch (imx_pcie->drvdata->variant) {
> > -	case IMX6SX:
> > -		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
> > -				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN,
> > -				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
> > -		/* Force PCIe PHY reset */
> > -		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR5,
> > -				   IMX6SX_GPR5_PCIE_BTNRST_RESET,
> > -				   IMX6SX_GPR5_PCIE_BTNRST_RESET);
> > -		break;
> > -	case IMX6QP:
> > -		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> > -				   IMX6Q_GPR1_PCIE_SW_RST,
> > -				   IMX6Q_GPR1_PCIE_SW_RST);
> > -		break;
> > -	case IMX6Q:
> > -		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> > -				   IMX6Q_GPR1_PCIE_TEST_PD, 1 << 18);
> > -		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> > -				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 0 << 16);
> > -		break;
> > -	default:
> > -		break;
> > -	}
> > +	if (imx_pcie->drvdata->core_reset)
> > +		imx_pcie->drvdata->core_reset(imx_pcie, true);
> >  
> >  	/* Some boards don't have PCIe reset GPIO. */
> >  	if (gpio_is_valid(imx_pcie->reset_gpio))
> > @@ -709,47 +747,10 @@ static void imx_pcie_assert_core_reset(struct imx_pcie *imx_pcie)
> >  
> >  static int imx_pcie_deassert_core_reset(struct imx_pcie *imx_pcie)
> >  {
> > -	struct dw_pcie *pci = imx_pcie->pci;
> > -	struct device *dev = pci->dev;
> > -
> >  	reset_control_deassert(imx_pcie->pciephy_reset);
> >  
> > -	switch (imx_pcie->drvdata->variant) {
> > -	case IMX7D:
> > -		/* Workaround for ERR010728, failure of PCI-e PLL VCO to
> > -		 * oscillate, especially when cold.  This turns off "Duty-cycle
> > -		 * Corrector" and other mysterious undocumented things.
> > -		 */
> > -		if (likely(imx_pcie->phy_base)) {
> > -			/* De-assert DCC_FB_EN */
> > -			writel(PCIE_PHY_CMN_REG4_DCC_FB_EN,
> > -			       imx_pcie->phy_base + PCIE_PHY_CMN_REG4);
> > -			/* Assert RX_EQS and RX_EQS_SEL */
> > -			writel(PCIE_PHY_CMN_REG24_RX_EQ_SEL
> > -				| PCIE_PHY_CMN_REG24_RX_EQ,
> > -			       imx_pcie->phy_base + PCIE_PHY_CMN_REG24);
> > -			/* Assert ATT_MODE */
> > -			writel(PCIE_PHY_CMN_REG26_ATT_MODE,
> > -			       imx_pcie->phy_base + PCIE_PHY_CMN_REG26);
> > -		} else {
> > -			dev_warn(dev, "Unable to apply ERR010728 workaround. DT missing fsl,imx7d-pcie-phy phandle ?\n");
> > -		}
> > -
> > -		imx7d_pcie_wait_for_phy_pll_lock(imx_pcie);
> > -		break;
> > -	case IMX6SX:
> > -		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR5,
> > -				   IMX6SX_GPR5_PCIE_BTNRST_RESET, 0);
> > -		break;
> > -	case IMX6QP:
> > -		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> > -				   IMX6Q_GPR1_PCIE_SW_RST, 0);
> > -
> > -		usleep_range(200, 500);
> > -		break;
> > -	default:
> > -		break;
> > -	}
> > +	if (imx_pcie->drvdata->core_reset)
> > +		imx_pcie->drvdata->core_reset(imx_pcie, false);
> >  
> >  	/* Some boards don't have PCIe reset GPIO. */
> >  	if (gpio_is_valid(imx_pcie->reset_gpio)) {
> > @@ -1447,6 +1448,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
> >  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
> >  		.init_phy = imx_pcie_init_phy,
> >  		.set_ref_clk = imx6q_pcie_set_ref_clk,
> > +		.core_reset = imx6q_pcie_core_reset,
> >  	},
> >  	[IMX6SX] = {
> >  		.variant = IMX6SX,
> > @@ -1462,6 +1464,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
> >  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
> >  		.init_phy = imx6sx_pcie_init_phy,
> >  		.set_ref_clk = imx6sx_pcie_set_ref_clk,
> > +		.core_reset = imx6sx_pcie_core_reset,
> >  	},
> >  	[IMX6QP] = {
> >  		.variant = IMX6QP,
> > @@ -1478,6 +1481,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
> >  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
> >  		.init_phy = imx_pcie_init_phy,
> >  		.set_ref_clk = imx6q_pcie_set_ref_clk,
> > +		.core_reset = imx6qp_pcie_core_reset,
> >  	},
> >  	[IMX7D] = {
> >  		.variant = IMX7D,
> > @@ -1491,6 +1495,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
> >  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
> >  		.init_phy = imx7d_pcie_init_phy,
> >  		.set_ref_clk = imx7d_pcie_set_ref_clk,
> > +		.core_reset = imx7d_pcie_core_reset,
> >  	},
> >  	[IMX8MQ] = {
> >  		.variant = IMX8MQ,
> > 
> > -- 
> > 2.34.1
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

