Return-Path: <bpf+bounces-43817-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 552E59BA1B7
	for <lists+bpf@lfdr.de>; Sat,  2 Nov 2024 18:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE26A1F21498
	for <lists+bpf@lfdr.de>; Sat,  2 Nov 2024 17:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414C11AA7BA;
	Sat,  2 Nov 2024 17:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BG6mX/+Q"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2087.outbound.protection.outlook.com [40.107.105.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED6C2FC52;
	Sat,  2 Nov 2024 17:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730568424; cv=fail; b=pSEwtIP4M4qefqLczIILWlRXks49XK0QRek0Wfe5T9fWaoKEcFF94WcbTlkdbCEo9o5SoljqU0eW4syI9wQRcCL0fI+cJKcmdHKleoKmX3HnrhJt2wOppDH+rCGVjYKk4kpP5m8ZoViRdFaDiTFyhG/gD1ABdEVCQA1UzDgl0z8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730568424; c=relaxed/simple;
	bh=OvCkSEScvCzZfCpDdwXZCxhlNYH0EjkRTV/6VNDBewQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nDUbKU6R7VV/HShXhogU2lTUis2baLJxbFlPLNl8OOoQGlsjepY9vPctxXtmjCl+DyhWE5f4ujkeJ1fNs0p6BZz9pflyb0RrEdR2jGBl/Uf0YPtAJ/A0f0ra4kCO2np0z3yNJGwQ6nj1J9xm7QvN0CZSChROTbHQdq7aXbSkA/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BG6mX/+Q; arc=fail smtp.client-ip=40.107.105.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IpmeiyFi4yb2+MvbP2a9PTzcpMUIV/+LVwG1u2L3wWUOMx1erRoC/dyk2XvHrV/O0Y+3Jh8fWx6hkK3d4VUdrw9mL7lAcBhDeyD7pFumOKKQtEWZg1JQsQuPXkgk99t9FSLfh2Ifc+ZbEpqNYV87LotbPIv/TceTDFCNikQBtOTd7XyGEV/dtOPjswrs5XKpO+n9xUtBMduG2gbt9MGOKgLbB4iUU+4hlN/u2CVO9DneZ1uuwaRX0nJgUJ7CMHeUoDKZtb5a67+CddaIb/iTPm38cqtfS5dT0F4LVpsglrMNAD/DuVoU/dk1PIt/zDfaNgD6ew26utTGUNa4nkGjHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8CiEsyTelyPyyHHt7AXKwYGgixTONpffpu2KaD51OE=;
 b=jhfVFZgDKeO1kEwDaQwPNz6nrLhQo7AdT427X/PIzWotzEKmmHBbjBUYaIwFTnNTi0oyJLNQbaFv96aUABr+s3v9MpJH7904Znr0u71etv4R8MUhFaGz2ZoDsl1U0zilyRo6BCjMVJdq8LvItFqT/oxFkBYKq3VJB37ZgxKayBY4zt2I2CW2P5j6PZz7883OIOdz7GRCCYUCkpZy8dC6549qcz6a5TxlVKv5H2eXlYUaj9mW7nSTkfDZRVhecsqlC4+QGoT5B9EWzcAckQODdibruiu02RKPD2AezNyTab3K2GJvO4e9d/OhUtaS33hbbddQnGD6BPyaOqiCBHmjaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8CiEsyTelyPyyHHt7AXKwYGgixTONpffpu2KaD51OE=;
 b=BG6mX/+QjhLYSDYJ17SGciRUvyAUQEKHGswUaZ9ACAATVhaIjpvaLlVFCai7YAW5wfmk+2hVJCv2S171OsmIgNZZIZERla/3DzzulNT7QWzIFYCc2yk6zRY34qxG3o3DAoLumn4U94ajxH1R7IDpoLTkmCDNSj+LL9KAU+XKXidXWDBp0H7SCUFqFebXD9WEGBzPpVRr8zHQs/Sw3771R0FkJ68QS7UdhqRnsd3HrTIDaboCqUhiFkLWq7pGNb7WTwcpmEpCmcKMJ2GrfVxciO2TYMmDQx4HzdH7xqlMyx13oqlsz+J6xsdCSpEczLnPK3LLh4MlIEqwmNNSDaHJQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7289.eurprd04.prod.outlook.com (2603:10a6:102:8a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Sat, 2 Nov
 2024 17:26:58 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8093.027; Sat, 2 Nov 2024
 17:26:58 +0000
Date: Sat, 2 Nov 2024 13:26:46 -0400
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, alyssa@rosenzweig.io, bpf@vger.kernel.org,
	broonie@kernel.org, jgg@ziepe.ca, joro@8bytes.org,
	lgirdwood@gmail.com, maz@kernel.org, p.zabel@pengutronix.de,
	robin.murphy@arm.com, will@kernel.org
Subject: Re: [PATCH v3 2/2] PCI: imx6: Add IOMMU and ITS MSI support for
 i.MX95
Message-ID: <ZyZg1nlSPf5rvm8q@lizhi-Precision-Tower-5810>
References: <20241024-imx95_lut-v3-0-7509c9bbab86@nxp.com>
 <20241024-imx95_lut-v3-2-7509c9bbab86@nxp.com>
 <20241102114937.w7jt7n7zr3ext5jo@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241102114937.w7jt7n7zr3ext5jo@thinkpad>
X-ClientProxiedBy: BYAPR01CA0040.prod.exchangelabs.com (2603:10b6:a03:94::17)
 To PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PR3PR04MB7289:EE_
X-MS-Office365-Filtering-Correlation-Id: 22db35ea-b87d-414e-d38b-08dcfb638e04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RXFVZ05zL2xlTjRvQUVsZmNwR2ovcG9oSVR0Nm5oVkVCVkd5VldmSi81c09G?=
 =?utf-8?B?ZzEvMWVFaVdhdzl4R1A4K0tkV2pFM0RHTW5rVENyUFdkWnE3R2lvaTZOWGJq?=
 =?utf-8?B?eHJ6eGwxVkp0SnE0YjAvTGlYb1JuSnowbGF1ZkdQSjV2cXgzUEhCN05PNkNu?=
 =?utf-8?B?S2N2RCsxT3pya1FWWEhiVm5tbzdkciswcXVhYS80b3JTZStUd2JnMGR4aTJK?=
 =?utf-8?B?aFNJQks1OGRia0c2eGNjRmhuQndiNjdKbjRQMDVrWTdnVndDcUx3eHJCOUpK?=
 =?utf-8?B?R3B5K0x4ZGpqWmFDRWpISjZ5czU4czBnTHluR2ZlekFmc3pjMGIxanh5VEla?=
 =?utf-8?B?TzFYU0trWXdWNXZTT1c2RXgzOGczOXhqTmNvYk9pa205M2Vxa1Vhbm10QnBJ?=
 =?utf-8?B?TzI3Q29uR1Bjb25DSGR2eHpMWFltZnY0elJ5VFpjNFJYZGlMVU9iTi9yRmdW?=
 =?utf-8?B?VG03TFlxalZkclEvUG4rQnVrNXpnbUZvL1p3YndJN1B2L3lVZjR6VnVwZVow?=
 =?utf-8?B?UG9xaTdEV25DYVJPSjlHQmczOS9rQzlCVHdRZjdmMGQzMzNBenVLMmlHWDJ5?=
 =?utf-8?B?WlBwZU5XRzhGZEtkYk5YT25NTGNWNDcwbUdRbDNqdEJrb3JqOG04bTViS05t?=
 =?utf-8?B?NmQwWnVGbk1RMW1yT1RId0pYZGNJcS9EKzZpemUrQ0VPMTh5c0VHaXd4WVhE?=
 =?utf-8?B?aExPYmRIR0twbDZXTWRBc1Z1dVJ2dFFWVGVIU05LeW45ak5ZU2NGZWpDU2dY?=
 =?utf-8?B?UWhyRkVGR0YxSnFmN0JhMjdrWFVvN2xxTy85TWtYY28rSGhzM3IyT3VOc3Z3?=
 =?utf-8?B?M2VoNlBnRDEwYlBxUHNvWWlwWmdVRzVsUkJaVEU5Q2txUUlqdEVLSFlVQW01?=
 =?utf-8?B?aHhFRDVhTnlNWEFqK0c2U3E4ZnFiRW1CVmV4VkxubW1hSmdIQXpkZkRJWUwy?=
 =?utf-8?B?ckRMb2RBakpLc3BjZmVhckp5QW8vL0NvZ3BQU1Rzd3JGcHBnZ2pzWG5lbTRH?=
 =?utf-8?B?cHRwWGtoVm9VTk8rdm1xRW5NdDRsS3BPclJRV245Ylh5M2JCeGR4TWpkNWFl?=
 =?utf-8?B?TnUxUWJrK0tsc1ZNT1FQSmcvZWNxWXlpbDNuU3g2Z1o5ei9vN2RhV1gvdTdL?=
 =?utf-8?B?ODBJNWt1akxBYlZXWkxNbGwwTDZ0MGFROGdjdk9oaFdvM29pS0NyRkY5dnBi?=
 =?utf-8?B?UWIxK1Rib0pyd2pmYVVkSlNHWlVnb1R0dmNKS2ZsVXozeTF6Z1ZubFdxWlNO?=
 =?utf-8?B?elV6ZEtRZi9Pd1lBS2VzV2wvNGdRTlY0bW9QUXYvbHRTOHFERUo2ZjdNc2dn?=
 =?utf-8?B?NTlHRTB6R0R6Sk9Gc0VscWVRTkxjTlFVSFN2RHpodjB2M1AralpJRU90UkJw?=
 =?utf-8?B?a2RwQmRkamlPZWN6Z25JWlBUaHNIdnhGUzB2bEQ2UkVuWVZ4dVJNR28zSU43?=
 =?utf-8?B?K1BlbS9pa0ZCd3l4R3NZd2w5ZS9VR0NEWGZLK21VN1lYbXdvcVJ0b0VqSzFa?=
 =?utf-8?B?U3UrUlhFUTk3VlljMG0xUEQwaWFUZjJ0dzRrUzBhMTZGOGRlWFZSVHIwaTJO?=
 =?utf-8?B?cDBhaDF2UlJRMEtHUHE0TUpZamVoUUNkaE5lL295aTlIa1J4NjZrOGJvNk14?=
 =?utf-8?B?ODQxNlRYekZKUGo0NjFWdGx0L21ZU28xdnF0RDJwYXFvMkdlYkhrQWFLZ2V0?=
 =?utf-8?B?dnlqY1Y0cnQ1ZGg1bVFOU2xKSHJLd1NweHNSUDBtd04veHBoQjljYmppUVIw?=
 =?utf-8?B?Tmw0dDV1NXF2Y1JqWHJsT1IwMTBucDRyM0orT0htcDdoUlkyL0Z6STM5cWFM?=
 =?utf-8?B?RTFpaDZxT2M3b3VDcTVPeDRQYUYwRnJrK214MitvNXBSRHBVT0ZTT3FJOGJ3?=
 =?utf-8?Q?XHs55U+jsUpcy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dU1PQXlYZldDV1A2b1V1UGsrc1hJK2M4aHhZVVlBVExhQlh2d241NzhnNjh6?=
 =?utf-8?B?WGFoY2h3Wm9yMUVSMHAraXZ6WHJXM0QvKzhZQ3dueEtnbDU0NTVJUWZSdUVE?=
 =?utf-8?B?dkVKNnF3aVFXNWhwOFVINXRLQ2xINmEvTnBTRmpERXVnd1Y3S1prb09iOTNh?=
 =?utf-8?B?bjZKU0xENjdhZU80Nk5nK3lzamg1b24vVXBtZTN0ZU5Kc09ZWm81S010SlBX?=
 =?utf-8?B?UUwxNEkzYW9YMENDYWN6clpKT2FkK2dqNE14Q1RKVndrWDN2NGtYWTFaTkdh?=
 =?utf-8?B?dkZTeDBTTTBhVlFFQXFuay8zQkxrdzNkR3VEMkxXM2lORnhrN0hCdXg3SG9H?=
 =?utf-8?B?Y0ZFZnU0RjZyM1JZUzBiNFlTZG05UVRWRkF4Ny9IVXV4bkZmR1VIZkIrSXhh?=
 =?utf-8?B?S2N6R3kyMjJ0dlJVejBYV0JRT1g5SzNxSnlGU2VnZDQ4TGhTNDZKUXVSYmhq?=
 =?utf-8?B?c2VKZmpQUG4vV2dtR0EwVGp2SEpmcjd6aEJjV1NBcnNKZ0hSYUticzU3NU56?=
 =?utf-8?B?MWxNMWdCak8zZGU0dW90ak4zT0RyRHhKZm1uMDlMVGk4TTVsZ2pGSGNqd2dv?=
 =?utf-8?B?R0FjVms4NkJZZW5TMFZLWXQzR0hMVmlsWFZLeDNWRThVL3V0SUoranphUjBn?=
 =?utf-8?B?Z0RickpKNlYrVzVDcXlGNmFsczB3QWRJNmFCNDlxalhqY1p1ZDJ5dzZocnRo?=
 =?utf-8?B?OHZxQlJ5VHVISUI2YXpMN1FBS0gzUTZNMFZ5VWg4TTBKdDM2UnY3dTcrK3FI?=
 =?utf-8?B?eDJZVlpLSFZiVTl5ZklxYmZkV2ZjU0NreGhEbzVIZk12aG0remRVOVh5emNG?=
 =?utf-8?B?WHZyQmV5S1hGQVhkM3hkYzBvYnB2UnNQc29lSHdYcG54MGR4VmpkNmpiWmhj?=
 =?utf-8?B?aVQwdnc0TUQxWFN6SzVlZG9zZHZtRFZ6S2ljZEwxMjg4cElOMnVySzlHUkZV?=
 =?utf-8?B?enJSdDNHclVOTDFlVGdlc0N4MDZoQzI5dXNSTkQrelRyMTlzWkFReE1uR0h0?=
 =?utf-8?B?dDVmTnNjUkF5UHZEdHJ3ZDY5ZkxOYzZDZEw0NW9PMWx6UTV3UXVkcXdKcmNp?=
 =?utf-8?B?aEQ1WTdjVU1mVVVaL2p3aThKOVltdUk5elJlUmIzZTAvSGRJUVo0TWwzcmow?=
 =?utf-8?B?aW9rK0FBRVpxY2sxcTdJc2Z1Yzc3M0NFQ1Q0SFB5cy94V1NaRWxsVmdUSEky?=
 =?utf-8?B?ajZvTkxVK2VzYS9lelhaVXZtcmN4TXlUOHNmSS9nWm1SY2svZ25OQ25vSGIw?=
 =?utf-8?B?QU1DWjlvcGRTWisvMUFVcCt5T1ZQSHpWa1JLcTA1ckhmRUl3SWluWnJYTmFm?=
 =?utf-8?B?Z0dwMmpESkRBb2RZNFlBM2ZxOFM1MkpadmJJeEVVYUpmdTFQVWcyRXBYSStO?=
 =?utf-8?B?L1hJeVk1YUtzU2lDblA5bVdvWlVtaTRBNkxUYnV4TEUzRURlUzhRM05Ib2tO?=
 =?utf-8?B?UDVmaUdjNUg2Sm8rQkc0T0QrNG9VL2RReURZNFlLRkwzZHB6TFh3blhjSExM?=
 =?utf-8?B?OEVlRWZsM3ZGUXd0c2R3QjhSOEJRMzVLVTkzOTM1dDZ5cFQ0cm9YRjByTDF4?=
 =?utf-8?B?NnQ4S2E2VU4wbmU3ZERpaWp2L2NMYk00Z1I0STJNemRhYWdFaGhmVkNIa05I?=
 =?utf-8?B?K01xQmhYWWl0SHNpRWxPQS9ITENMcyt6NHdjQ0REdjJ5Ky8yMTM0YnRDV0dl?=
 =?utf-8?B?OHpYN3Z1RDl4bVNtek5KZERvT25hTTg3ZjI0QzkxSWRMQmtGeStrVE80ZWcy?=
 =?utf-8?B?a3dlR0R6d3VoL1FxREI3VmFNOHZLbmJpRW12U3J4SWV5NXE5dHJmZ1N2TmNO?=
 =?utf-8?B?VXM0T1FkTnpra0N6ZDRuSHJ2d2tyQmJleTJJU2Z6QTlreGtWdUx6UUh5YVc0?=
 =?utf-8?B?My8zRC9jc2dMdVUzMkdhWWFhS3p2Tm1MRmJSQ2ExelZtdm1laDJMamt0NHcy?=
 =?utf-8?B?R28vbTl1aVBpNlQ3ZmZFQXFVVTN5MkUrS2NUcExXMGhLVm5CTVltRk9ldUdj?=
 =?utf-8?B?enY4WlVxQ1F5WkZsbU10RWJNZzJQMzJ2UUVwUEtKRVZDUTF5UFY4NjhKQyt0?=
 =?utf-8?B?b1dUZ2pLLzVGUWJCZzlocFNlU2xkaWlqTTYwb3ZzTTNGWnRtd1A1MkU3Rjhs?=
 =?utf-8?Q?Ovh8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22db35ea-b87d-414e-d38b-08dcfb638e04
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2024 17:26:58.5430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8C+VRkG+7eabQ6cleR3CdIMLfGxh4k2YNvRB8nLkO1FDowDD9hPQeLM6ATWqXuiA13okDc7ep4q3iohamj64dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7289

On Sat, Nov 02, 2024 at 05:19:37PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Oct 24, 2024 at 06:34:45PM -0400, Frank Li wrote:
> > For the i.MX95, configuration of a LUT is necessary to convert Bus Device
> > Function (BDF) to stream IDs, which are utilized by both IOMMU and ITS.
> > This involves examining the msi-map and smmu-map to ensure consistent
> > mapping of PCI BDF to the same stream IDs. Subsequently, LUT-related
> > registers are configured. In the absence of an msi-map, the built-in MSI
> > controller is utilized as a fallback.
> >
> > Additionally, register a PCI bus callback function enable_device() and
> > disable_device() to config LUT when enable a new PCI device.
> >
>
> Callbacks are not *addition*, but it is how you are implementing the LUT
> configuration. Please reword it so.
>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Change from v2 to v3
> > - Use the "target" argument of of_map_id()
> > - Check if rid already in lut table when enable device
> >
> > change from v1 to v2
> > - set callback to pci_host_bridge instead pci->ops.
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c | 159 +++++++++++++++++++++++++++++++++-
> >  1 file changed, 158 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > index 94f3411352bf0..95f06bfb9fc5e 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -55,6 +55,22 @@
> >  #define IMX95_PE0_GEN_CTRL_3			0x1058
> >  #define IMX95_PCIE_LTSSM_EN			BIT(0)
> >
> > +#define IMX95_PE0_LUT_ACSCTRL			0x1008
> > +#define IMX95_PEO_LUT_RWA			BIT(16)
> > +#define IMX95_PE0_LUT_ENLOC			GENMASK(4, 0)
> > +
> > +#define IMX95_PE0_LUT_DATA1			0x100c
> > +#define IMX95_PE0_LUT_VLD			BIT(31)
> > +#define IMX95_PE0_LUT_DAC_ID			GENMASK(10, 8)
> > +#define IMX95_PE0_LUT_STREAM_ID			GENMASK(5, 0)
> > +
> > +#define IMX95_PE0_LUT_DATA2			0x1010
> > +#define IMX95_PE0_LUT_REQID			GENMASK(31, 16)
> > +#define IMX95_PE0_LUT_MASK			GENMASK(15, 0)
> > +
> > +#define IMX95_SID_MASK				GENMASK(5, 0)
> > +#define IMX95_MAX_LUT				32
> > +
> >  #define to_imx_pcie(x)	dev_get_drvdata((x)->dev)
> >
> >  enum imx_pcie_variants {
> > @@ -82,6 +98,7 @@ enum imx_pcie_variants {
> >  #define IMX_PCIE_FLAG_HAS_PHY_RESET		BIT(5)
> >  #define IMX_PCIE_FLAG_HAS_SERDES		BIT(6)
> >  #define IMX_PCIE_FLAG_SUPPORT_64BIT		BIT(7)
> > +#define IMX_PCIE_FLAG_HAS_LUT			BIT(8)
> >
> >  #define imx_check_flag(pci, val)	(pci->drvdata->flags & val)
> >
> > @@ -134,6 +151,7 @@ struct imx_pcie {
> >  	struct device		*pd_pcie_phy;
> >  	struct phy		*phy;
> >  	const struct imx_pcie_drvdata *drvdata;
> > +	struct mutex		lock;
>
> Please add a comment on what the lock is guarding.
>
> >  };
> >
> >  /* Parameters for the waiting for PCIe PHY PLL to lock on i.MX7 */
> > @@ -925,6 +943,137 @@ static void imx_pcie_stop_link(struct dw_pcie *pci)
> >  	imx_pcie_ltssm_disable(dev);
> >  }
> >
> > +static int imx_pcie_add_lut(struct imx_pcie *imx_pcie, u16 reqid, u8 sid)
>
> s/reqid/rid
>
> > +{
> > +	struct dw_pcie *pci = imx_pcie->pci;
> > +	struct device *dev = pci->dev;
> > +	u32 data1, data2;
> > +	int i;
> > +
> > +	if (sid >= 64) {
> > +		dev_err(dev, "Invalid SID for index %d\n", sid);
> > +		return -EINVAL;
> > +	}
> > +
> > +	guard(mutex)(&imx_pcie->lock);
> > +
> > +	for (i = 0; i < IMX95_MAX_LUT; i++) {
> > +		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, IMX95_PEO_LUT_RWA | i);
> > +		regmap_read(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, &data1);
> > +
> > +		if (!(data1 & IMX95_PE0_LUT_VLD))
> > +			continue;
> > +
> > +		regmap_read(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, &data2);
> > +
> > +		/* Needn't add duplicated Request ID */
> > +		if (reqid == FIELD_GET(IMX95_PE0_LUT_REQID, data2))
>
> So this means LUT entry is already present for the given RID (a buggy DT maybe).
> Don't you need to emit a warning here?
>
> > +			return 0;
> > +	}
> > +
>
> You need to bail out here if no free LUT entry is available. But I'd recommend
> to combine two loops to avoid having duplicated IMX95_PE0_LUT_VLD checks and
> program LUT only if there is any free entry available.
>
> > +	for (i = 0; i < IMX95_MAX_LUT; i++) {
> > +		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, IMX95_PEO_LUT_RWA | i);
> > +
> > +		regmap_read(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, &data1);
> > +		if (data1 & IMX95_PE0_LUT_VLD)
> > +			continue;
> > +
> > +		data1 = FIELD_PREP(IMX95_PE0_LUT_DAC_ID, 0);
> > +		data1 |= FIELD_PREP(IMX95_PE0_LUT_STREAM_ID, sid);
> > +		data1 |= IMX95_PE0_LUT_VLD;
> > +
> > +		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, data1);
> > +
> > +		data2 = 0xffff;
>
> data2 = IMX95_PE0_LUT_MASK;
>
> Also add a comment on why the mask is added along with the RID.
>
> > +		data2 |= FIELD_PREP(IMX95_PE0_LUT_REQID, reqid);
> > +
> > +		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, data2);
> > +
> > +		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, i);
> > +
> > +		return 0;
> > +	}
> > +
> > +	dev_err(dev, "All lut already used\n");
>
> "LUT entry is not available"
>
> > +	return -EINVAL;
> > +}
> > +
> > +static void imx_pcie_remove_lut(struct imx_pcie *imx_pcie, u16 reqid)
>
> s/reqid/rid
>
> > +{
> > +	u32 data2 = 0;
>
> No need to initialize.
>
> > +	int i;
> > +
> > +	guard(mutex)(&imx_pcie->lock);
> > +
> > +	for (i = 0; i < IMX95_MAX_LUT; i++) {
> > +		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, IMX95_PEO_LUT_RWA | i);
> > +
> > +		regmap_read(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, &data2);
> > +		if (FIELD_GET(IMX95_PE0_LUT_REQID, data2) == reqid) {
> > +			regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, 0);
> > +			regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, 0);
> > +			regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, i);
> > +
> > +			break;
> > +		}
> > +	}
> > +}
> > +
> > +static int imx_pcie_enable_device(struct pci_host_bridge *bridge, struct pci_dev *pdev)
> > +{
> > +	u32 sid_i = 0, sid_m = 0, rid = pci_dev_id(pdev);
> > +	struct device_node *target;
> > +	struct imx_pcie *imx_pcie;
> > +	struct device *dev;
> > +	int err_i, err_m;
> > +
> > +	imx_pcie = to_imx_pcie(to_dw_pcie_from_pp(bridge->sysdata));
> > +	dev = imx_pcie->pci->dev;
>
> You can assign these at initialization time.
>
> > +
> > +	target = NULL;
> > +	err_i = of_map_id(dev->of_node, rid, "iommu-map", "iommu-map-mask", &target, &sid_i);
> > +	target = NULL;
>
> What is the point in passing 'target' here?

See https://lore.kernel.org/imx/b479cad6-e0c5-48fb-bb8f-a70f7582cfd5@arm.com/
Marc Zyngier's comments:

"Perhaps it is reasonable to assume that i.MX95 will never have SMMU/ITS
mappings for low-numbered devices on bus 0, but in general this isn't
very robust, and either way it's certainly not all that clear at first
glance what assmuption is actually being made here. If it's significant
whether a mapping actually exists or not for the given ID then you
should really use the "target" argument of of_map_id() to determine that."

See v4 https://lore.kernel.org/imx/20241101-imx95_lut-v4-2-0fdf9a2fe754@nxp.com/

+	target = NULL;
+	err_m = of_map_id(dev->of_node, rid, "msi-map", "msi-map-mask", &target, &sid_m);
+
+	/*
+	 * Return failure if msi-map exist and no entry for rid because dwc common
+	 * driver will skip setting up built-in MSI controller if msi-map existed.
+	 *
+	 *   err_m      target
+	 *	0	NULL		Return failure, function not work.
+	 *      !0      NULL		msi-map not exist, use built-in MSI.
+	 *	0	!NULL		Find one entry.
+	 *	!0	!NULL		Invalidate case.
+	 */


>
> > +	err_m = of_map_id(dev->of_node, rid, "msi-map", "msi-map-mask", &target, &sid_m);
> > +
> > +
> > +	/*
> > +	 * msi-map        iommu-map
> > +	 *   Y                Y            ITS + SMMU, require the same sid
> > +	 *   Y                N            ITS
> > +	 *   N                Y            DWC MSI Ctrl + SMMU
> > +	 *   N                N            DWC MSI Ctrl
> > +	 */
> > +	if (!err_i && !err_m)
> > +		if ((sid_i & IMX95_SID_MASK) != (sid_m & IMX95_SID_MASK)) {
> > +			dev_err(dev, "its and iommu stream id miss match, please check dts file\n");
>
> "iommu-map and msi-map entries mismatch!"
>
> - Mani
>
> --
> மணிவண்ணன் சதாசிவம்

