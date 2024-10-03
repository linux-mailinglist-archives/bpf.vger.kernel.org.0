Return-Path: <bpf+bounces-40861-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A98198F6EB
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 21:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C74E282000
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 19:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BE61ABECD;
	Thu,  3 Oct 2024 19:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="i6x4W+AY"
X-Original-To: bpf@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011000.outbound.protection.outlook.com [52.101.65.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0731A76CF;
	Thu,  3 Oct 2024 19:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727983108; cv=fail; b=P9FaCFq7JxqRVXh+e71kU51NYFTKRCYuKlY3aBwCMuPEZOmlJ5ZbwbXiqU6hhGpCK7iryvgRm5zgQNAiLd1bGGKvjHc4UwSFYrLoQAkGTglPArdi1583ch+s8Ebt+SzTS0f+yry9qAWIDJQiCB9O9C0EoUgH/zX3cg9ocPWqx5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727983108; c=relaxed/simple;
	bh=xYVuPYTfR+G3siglx/Y66Ow3geM3UB/GNvGd4ZUfGGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cdo+G0WIKp7YtSz1f09yd7wOje8Hc5VJf/Ri9/ap8FcEf5XrrEhZWI4ifDp8cRmavc1Q/b3KnieEL4l7WfR5Y5xLo3uFOjJjn5j0bbin5alXcIQT0pm+xJaXYb7V7z4Upj4IW7NGTsbQtyV/dw2sRj30cxj1f1FWPPviEfvFpeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=i6x4W+AY; arc=fail smtp.client-ip=52.101.65.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UZojg5x+Wr8ixgz01fYH+eHIpTRWv9IP48ZAbqyODHYBZ4c6RXeQEJMH9FjJBXin5GpCOFNmdjpWzbCKFI3C2IKDCXTgcYMVwvk5uVwLjcQF0BXoRSIV9a1JvQ3VhGiLdXKoUGEa5Zr8WEfOVS7hU3K9l7t2nxhI5B8U4PVh9Sw4BBMCRnB4WA7mT2tRDH8KSz2jMY3MrOL+2YxRfTDrfqBiiM+okQmHZMrzih+4hfsbvh1Lx9ZFRJw11BDzGcOiA/Z46suLusY/8eKCxct1f9huYB2xp+oGsnILIu/HTntUSOlz3yzW2Wv/jovfDMIVTtJYw+ZrBFjYCe3K4ULnOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tai8R9Orj6TQwRoCcXL9ClyjJiaQg+HAC7pd4QaL5BY=;
 b=NWZjezG3HiJB4hwORPgVwVaqsINHNcr35zliBWYcpMOlBCElvXEhI5bXV/lO2tMrx0eukYWUyBtjL/84ylx2X8i39gPukxrxAF0AyTh4K0fmtz9D8X05In+Y8HGTLTT63AAnpY3ATcuNFHhv/i4KKN9Mb/UTIiVuj6LwRFxgR15W/owesBJ03TbcDQV59ryrXynI08pNRiwinQiDEDhcdQ5jLxVYFmBtBaW6CFGqz9dXUkK1lbDfI5cDFU2cu9dVkf2ZC7hcNlGzuU8a0jGbAKxzhkBWIpxac+hBTFfSAl4GPhPp8sReUTokQlcp1cwhQ5RfrSWez52cags5SIv+7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tai8R9Orj6TQwRoCcXL9ClyjJiaQg+HAC7pd4QaL5BY=;
 b=i6x4W+AYsZ7yP+lxbKNIS4bx4dKt0lgGX76bfCh6xx0AhMyYH8b1D9c9043UtM2FnCslFwbXRtu2k3myRbCZrRlpNSGbANrrxgb5KQBnhy31kHlqFaTO1P93j8PKZ8LsOX/vCS1Lz2Ourxkqp+XIX5ZwqOKPwty+gzl9PRjMWQuXG7IoEjjbMfeaT/s6lrnsw2Fn5PGDMdYxgsGzjOxDxniZqBsYDwWWFle7yQc6An5YcG/TvGrBGfbrsl801jgdaXnPaaLP8/8GjQtEjftT6CnbTFBZVl4kF8IUORbtj2mhuRdfZB5F1oXyF3ZLwkFRKyaWJdqo/pe6Y1IG6EZ0aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB10554.eurprd04.prod.outlook.com (2603:10a6:102:484::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Thu, 3 Oct
 2024 19:18:23 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 19:18:22 +0000
Date: Thu, 3 Oct 2024 15:18:12 -0400
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
Subject: Re: [PATCH v2 0/2] PCI: add enabe(disable)_device() hook for bridge
Message-ID: <Zv7t9HnRsfTxb2Xs@lizhi-Precision-Tower-5810>
References: <20240930-imx95_lut-v2-0-3b6467ba539a@nxp.com>
 <20241003051528.qrp2z7kvzgvymgjb@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241003051528.qrp2z7kvzgvymgjb@thinkpad>
X-ClientProxiedBy: BYAPR06CA0005.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB10554:EE_
X-MS-Office365-Filtering-Correlation-Id: 1702d244-ecb7-4a27-dfb6-08dce3e025d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bjdVQ0pFdnM1elgvZ0JGVElxaWZZMlZQZmtmcyt5MURyZDd2bzE5azhldDgw?=
 =?utf-8?B?S3VmbUx6SGtBbS8wN0E1UUtNZkNwdnZtL3pDVDllcmxNWXUwTmJZemhobG1D?=
 =?utf-8?B?dmtJQTdJa0xxN2xLd2FTdmVCanFyaHBUbVg4Zmw0L2Y2NXdGRWZXRnlHTHFC?=
 =?utf-8?B?TFpVa3paaVdxNjZMSU1IUldWV3FUS013cFpEaGhpOS9pYzRmN0pWOXBKbzdI?=
 =?utf-8?B?NlRrdm9IT0dCYy81UWJlcTJ2SUYxNmZhbU9KZzRHcVhEYkhpWTg1dmVTNVlD?=
 =?utf-8?B?eGVsMHB5TGtFV2dzL0kyaEp0MjY2VWFFb3RwN3N2UnMxN0pNUU1oeC9Kc2Uv?=
 =?utf-8?B?czRzcEVDQk0wbmN3WVFNbm9iN0xWWXJtaXB4eWxzczNDcmFWa1JaeEZVQWly?=
 =?utf-8?B?RVRZNmY2aHhMbE92cVZoOWRZOWRUS0FrV21xMm9Nc2Q5alNveVcyaEp0Y3NW?=
 =?utf-8?B?bFFTRWQzRnVaRmJySzBQY2hlMmIxY2UzZEpoUjIyWU1vbUdFMU5pQ1RVOERV?=
 =?utf-8?B?dTVoWnpkaFJ4ajJDb1E2SzVneFFRNzNpRHQ3ZjB2bm1Bb1lYWHliRnVKL3hB?=
 =?utf-8?B?UTE0TGppRlFNbGlsM05jK1VUL2ZFTnVOMGdYRW1ubmpsVTFUOEJoOFFyVWRR?=
 =?utf-8?B?b3IwbGhGNmJoY2lPMzB0RlBnWCtjb1lBTVFNaHFOaEM3ejIxaHVEd09ORTVN?=
 =?utf-8?B?K2Irb2RpRW5JRm1OTHF3K01XZml2U0lLbmoxZkpFd29ydk1jL1BqVjNkTmRo?=
 =?utf-8?B?bEE0VTFSOVIrdWx2RnY5SEM4dWZ4bTVHaTBRVllKQU92Y0ZPM3UzUkl2dlBx?=
 =?utf-8?B?Z0REQXdCKzV2QWFHK3M1QzFHQ2NKVk1SbTh6NGVjYmlwdk9RYXR1M2ZKaFRa?=
 =?utf-8?B?NExJUWJrNU5pM3doSXhDTEpnVWtqUlAvQWlvQnU5Sk4vTGZtNFpXVkZSTzlJ?=
 =?utf-8?B?WXZIajdndzJOZzhqMVlDZCtqV0xTWExZSjJqKzN4UFNzdjRGMm5yUjhvWlhM?=
 =?utf-8?B?cG1ncllOU2pSTDlQNXl1TlRSb3NYQldjeTFjVFdJdWEzWUFEdkhCamlmSDJD?=
 =?utf-8?B?OWxjWFMvVFZpbVFpT2NlOVMvV2NoeUVERFlEKzFYZ0xhc0xzb2gyS083b3lT?=
 =?utf-8?B?WEllSXdMdE1zTXpDbnA0ejQrQzVaY3NRSDRDYzJ5d3IzTlkzcGUrVlJ4VXNp?=
 =?utf-8?B?ejZ0U09wZHNSMHo4UU1RT1MrbFlOcGZUZWd5c01uOHFjTDNpUHRrWSs3Q1Ey?=
 =?utf-8?B?aHJFbmxjOUNkT2gyMkpGaHRFODcrdXNlVFlOTW9tTy9HckhWU1Nrd2lBQmFV?=
 =?utf-8?B?VU9Za0JSN1pMQmhKdVVOcmxCT0lsNkRsdlp0ZkpUak92azZCaXYrREE2OWVv?=
 =?utf-8?B?Sm40bS8vcEh0NEpPRFVpS1ZzV1l6UTZCai9wNnlOTU1HM2xOWi9FZGlJbSt2?=
 =?utf-8?B?aTE2b2V5SWpzdzNmWUpiU05rNUZGa3ZDSUZyK2VTWEdtMXdpcjBPYWdReFpt?=
 =?utf-8?B?Zks0eWhFY2M2R3daaVZzMEErTzRPYXl4YzhFMXlGemsvYTFaNElxVUFDUkNG?=
 =?utf-8?B?elRES2prQ0lXVnJSUVNZR2FmREhFZFVydmE5ci9hTEtLaENoVXJpZFlYTzNy?=
 =?utf-8?B?dmE1TWl5OFRHWTZjRkZOTTlXaEFmU3dIQU1jQys0QzllRGlUQmR2eVBBNUhE?=
 =?utf-8?B?Tk9Zc3RnM20waTdNeXdCVERwbC9CZml6TTZsTExQOFErTFc3eERuZHZQeFcr?=
 =?utf-8?Q?XqqcmoI3xZKwFBi9xI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czErYWJOakdJckFQaElydUU2eXhSK0lSR1hCUzI4NHl4YytPZWZGY1YrMzVL?=
 =?utf-8?B?emFoc3pmWThsNmlja1hrbS9JYXRmKzJOTnowcmNxOVkzM0pqcXRWWGtwMzZY?=
 =?utf-8?B?bmpBZWlNT0h1amRkdjhLM2pkVnZ5YnRIMC9naGtKWnJqaFNyOUJrZTU3Yml4?=
 =?utf-8?B?eVAvNmI3Mkx3dFBzbTRwZWtDQmtKNnlEclByRzhXYUliQW0vVmVqN3pJMHgw?=
 =?utf-8?B?M0svRWgwUVBENEJKZWtjMWZkREhPWlErY3JIVk95NERuNFJrUnRnZzFjL3Ux?=
 =?utf-8?B?UGtLUEE4VUdZcSs5a2pOZ0kvdzNOYTlYdlhpemZLbDR6U2pNMWdsNUlEUG5C?=
 =?utf-8?B?MU9jWSsweTlCazRXN3JkR1o3L3JHdEs2b3MwTXRiQ2FOSldoNWFHQVdPdVlp?=
 =?utf-8?B?QWxaVVZWblh2L2JuUzRnYmM0cHM5aUtCTVpYRjVlNkJ6UEprcFBCWEpUaVdL?=
 =?utf-8?B?UVh0UWhQZHd2RzZVMEw5elVacUszRnJYVHRKUytOeGdtdE02Q3ZFVmZrQ1Av?=
 =?utf-8?B?ZnRPeUdEVGk3MFJTN2lpdW1GWklZOUp5WFBvcjVqSUNWU3V1WmlLZkFsME5n?=
 =?utf-8?B?OGRrZ1JLeThtd2RtZ0RPVHJhbGhlamp6bVRjL2l3NnptYmJOV1g0SktIMW9r?=
 =?utf-8?B?aW9rQlp4N1Bxa0cvcTdPTVpJc2d2ZFd4WXBpRmQxSklKM2NlVXZPeFVyL1Nm?=
 =?utf-8?B?ODM4UEdxM0gvVzR3eFp5ZExXbUFCZ25zVDZVQ2IrOFVpVVVGenluRGRyam1k?=
 =?utf-8?B?ZnhrcGZoL3N6a0lMR25qOGFWVjFUZFZNWVJaMmFQS01GdWxjZkppcmJyS0Rp?=
 =?utf-8?B?dWRUZlM1NUsraUZ4VkxGbS8rOTRNWmFMLzFFcXNMMnRSOEs3ZTY0Q0ZneE04?=
 =?utf-8?B?ZzF6VVZ0cWZjZ1Jna0dYWnB2RVBQVS9Nd1ZuM3NVampzY0lZWkdxR0xHRmFk?=
 =?utf-8?B?dlB3V2E2S1FCeS84MkFjWm1zd2RYU2c0Qzh1VXFWdFBidDBia3lkbDU4dG52?=
 =?utf-8?B?OWErTDNQNjhrYzY4VTFGcWpJSEVoRm12cElGRHhUWGx2am5Xc1N0bUNQc1F4?=
 =?utf-8?B?ZlY3cmFweGRKZE9LUEZmOWpBMGExc0NjaEQxU0pFeWZrR3NZd3dBM3RzK3Y3?=
 =?utf-8?B?UVdPdjhnOXZHMTBUK1YrcHhqZ3ROMmJxQzF1SmE2eE80UmhtdFcvS0xBdXI4?=
 =?utf-8?B?eVVvZXVTSFY0MWVNSDRqYjlVTk1Pa1E0Y09ZOXB4am1salZad1p2c21oV3gv?=
 =?utf-8?B?ak9HTjA4V0V1M3ZiQ1ZQaHY4SlNWcFlOc3VDV2tsUXRvcTB4STk2Y1ZBOG9N?=
 =?utf-8?B?RFREWi91TzJFNXcyUlNjZU96NUJVdTFxSmVFQllkcXN1aERwQnJVN2hMTzdO?=
 =?utf-8?B?NXdrdTdBSnZMakYxNFU3MDFGallablFtS2JMNGlCendsRUFWYjc1TmkxU090?=
 =?utf-8?B?LzVLeDNRK2pJa0JXTUxVaHQ5OHdOYVpRNmdvaEVPc3MvdTR6bUU4bUFWUGZC?=
 =?utf-8?B?UnQ3TCtnaktHQmUySVlBaVVlZlVpL2dUbllVMVVqL0ZRUjJrQWlTSWV1a0hU?=
 =?utf-8?B?SWtneHJQekszb0ZrOSsxUW5mWjNycG4xWHJnV3ZwMGVBN0sycWlFeGx1Ni92?=
 =?utf-8?B?VWJzc0RmVDNQR1VKbDhVcDJxWlgrMnFDaW9WR0w1MkV3Vjd0d2R6YTJBMkRS?=
 =?utf-8?B?WWJvSWowTHU4ZDVTVFBRUHlObTRGRnZ4di9OeGJQM3Fkbnl2bzRVekk3Vk9X?=
 =?utf-8?B?bDVOL0JmbStWTDh4dmF6N0U2TjdPUTdQRWRUU016djZvQzVVVkV3QjF3czBu?=
 =?utf-8?B?Z2E1WjhNbFdOemJQcENNckYyODU5SVR3bmJSRThkdi9DOS9Uc1YyMEJQZExU?=
 =?utf-8?B?NFRpRWxCUmtsZUJBVHcwQlJxZFNWc1JyR3VyeGhkUFo2cllSRjdEOHl5bDhi?=
 =?utf-8?B?UWxqNzhmU3lmWXJ4dDlTcmI1RWIxQXpjcitRMS9USU5wVFk0TjhYT0NiTUIw?=
 =?utf-8?B?djRWY2paRXpvN0xSOERkYjRWVkJXYnBmMStXY3VhcGpjcDhwOXZCMGl3dHVL?=
 =?utf-8?B?YVgxOFY2aUxaQ3lJV1A0d2xMTnVmb05wYkxTbFJRdXFaYVZTcm1ZMlY1MTRu?=
 =?utf-8?Q?a7qqwd5BY5CBge5YZ0NnZQ7jD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1702d244-ecb7-4a27-dfb6-08dce3e025d6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 19:18:22.8314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A95S4WAd+UR6AAZeHWp02bTttHrIwPHSv6FEQYW8YkGrK8n1OjLzbKleRVLz3bIrbKrJknAdD6YV0mJxPq0Iaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10554

On Thu, Oct 03, 2024 at 10:45:28AM +0530, Manivannan Sadhasivam wrote:
> On Mon, Sep 30, 2024 at 03:42:20PM -0400, Frank Li wrote:
> > Some system's IOMMU stream(master) ID bits(such as 6bits) less than
> > pci_device_id (16bit). It needs add hardware configuration to enable
> > pci_device_id to stream ID convert.
> >
> > https://lore.kernel.org/imx/20240622173849.GA1432357@bhelgaas/
> > This ways use pcie bus notifier (like apple pci controller), when new PCIe
> > device added, bus notifier will call register specific callback to handle
> > look up table (LUT) configuration.
> >
> > https://lore.kernel.org/imx/20240429150842.GC1709920-robh@kernel.org/
> > which parse dt's 'msi-map' and 'iommu-map' property to static config LUT
> > table (qcom use this way). This way is rejected by DT maintainer Rob.
> >
>
> What is the issue in doing this during the probe() stage? It looks like you are
> working with the static info in the devicetree, which is already available
> during the controller probe().

There are problems.
One: It is not good to manually parser this property in pci host bridge
drivers.

Two: of_map default is bypass map. For example: if in dts only 2 sid, 0xA
and 0xB. If try to enable 3rd function RID(103), there are no error report.
of_map will return RID 103 as stream ID.  DMA will write to wrong
possition possibly.

https://elixir.bootlin.com/linux/v6.12-rc1/source/drivers/of/base.c#L2070

Three: LUT resource is limited, if DT provide 16 entry, but LUT have only 8
items, if more device enable, not LUT avaible and can't return error. of
course, it may fix dts, but It'd better that driver can handle error
properly when meet wrong dtb file.

>
> > Above ways can resolve LUT take or stream id out of usage the problem. If
> > there are not enough stream id resource, not error return, EP hardware
> > still issue DMA to do transfer, which may transfer to wrong possition.
> >
> > Add enable(disable)_device() hook for bridge can return error when not
> > enough resource, and PCI device can't enabled.
> >
>
> {enable/disable}_device() doesn't convey the fact you are mapping BDF to SID in
> the hardware. Maybe something like, {map/unmap}_bdf2sid() or similar would make
> sense.

It is called in PCI common code do_pci_enable_device(), hook functin name
should be similar with caller. {map/unmap}_bdf2sid() is just implementation
in dwc.

stream id is only ARM platform concept.

May other host bridge do difference thing at enable/disable_device().

So I am still perfer use {enable/disable}_device().


Frank

>
> - Mani
>
> > Basicallly this version can match Bjorn's requirement:
> > 1: simple, because it is rare that there are no LUT resource.
> > 2: EP driver probe failure when no LUT, but lspci can see such device.
> >
> > [    2.164415] nvme nvme0: pci function 0000:01:00.0
> > [    2.169142] pci 0000:00:00.0: Error enabling bridge (-1), continuing
> > [    2.175654] nvme 0000:01:00.0: probe with driver nvme failed with error -12
> >
> > > lspci
> > 0000:00:00.0 PCI bridge: Philips Semiconductors Device 0000
> > 0000:01:00.0 Non-Volatile memory controller: Micron Technology Inc 2100AI NVMe SSD [Nitro] (rev 03)
> >
> > To: Bjorn Helgaas <bhelgaas@google.com>
> > To: Richard Zhu <hongxing.zhu@nxp.com>
> > To: Lucas Stach <l.stach@pengutronix.de>
> > To: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > To: Krzysztof Wilczyński <kw@linux.com>
> > To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > To: Rob Herring <robh@kernel.org>
> > To: Shawn Guo <shawnguo@kernel.org>
> > To: Sascha Hauer <s.hauer@pengutronix.de>
> > To: Pengutronix Kernel Team <kernel@pengutronix.de>
> > To: Fabio Estevam <festevam@gmail.com>
> > Cc: linux-pci@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: imx@lists.linux.dev
> > Cc: Frank.li@nxp.com \
> > Cc: alyssa@rosenzweig.io \
> > Cc: bpf@vger.kernel.org \
> > Cc: broonie@kernel.org \
> > Cc: jgg@ziepe.ca \
> > Cc: joro@8bytes.org \
> > Cc: l.stach@pengutronix.de \
> > Cc: lgirdwood@gmail.com \
> > Cc: maz@kernel.org \
> > Cc: p.zabel@pengutronix.de \
> > Cc: robin.murphy@arm.com \
> > Cc: will@kernel.org \
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Changes in v2:
> > - see each patch
> > - Link to v1: https://lore.kernel.org/r/20240926-imx95_lut-v1-0-d0c62087dbab@nxp.com
> >
> > ---
> > Frank Li (2):
> >       PCI: Add enable_device() and disable_device() callbacks for bridges
> >       PCI: imx6: Add IOMMU and ITS MSI support for i.MX95
> >
> >  drivers/pci/controller/dwc/pci-imx6.c | 133 +++++++++++++++++++++++++++++++++-
> >  drivers/pci/pci.c                     |  14 ++++
> >  include/linux/pci.h                   |   2 +
> >  3 files changed, 148 insertions(+), 1 deletion(-)
> > ---
> > base-commit: 2849622e7b01d5aea1b060ba3955054798c1e0bb
> > change-id: 20240926-imx95_lut-1c68222e0944
> >
> > Best regards,
> > ---
> > Frank Li <Frank.Li@nxp.com>
> >
> >
>
> --
> மணிவண்ணன் சதாசிவம்

