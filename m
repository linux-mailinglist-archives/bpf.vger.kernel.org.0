Return-Path: <bpf+bounces-44851-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BB29C9021
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2024 17:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 251C41F27A19
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2024 16:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8598618CC17;
	Thu, 14 Nov 2024 16:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jOiUdxfR"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2048.outbound.protection.outlook.com [40.107.21.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5EC18C907;
	Thu, 14 Nov 2024 16:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731602916; cv=fail; b=A0V5f70JxtSnN8aO7kEU1sb7UJy/lnSdZdOZmkKhi+88RH5wDrycUm0L4mi3SU77teZxKhfqPkJ2uqz5XVW30FkonoDU12dmskQKW640P53wZvbBD4GwWyqx8CLkwB/AF52caHbHWTeBDwICCmR9XbgmiSWJ+hVb7zCiECtY6qM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731602916; c=relaxed/simple;
	bh=/ywDMbDzzxDUqtY2Ck3rc3ljoVMNiZpAt14nK6jQxJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d5jk/2zPVXmSVxChFq449iN5hndY4uHRtyapJpjGZmWWssQEDPicS5INdMe6AWGLh/l7fm6zkiZw/wZE1R676LJE8AbWgtJHNQqo0l2AgTP5P3gPtYTN3aNTMmHQUC3BtXGM5WI7bj/SxrLl992H2uxirHxBk9ZdBCjU/GS0LCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jOiUdxfR; arc=fail smtp.client-ip=40.107.21.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WyqsScC6LEgoerzmur2LeaFU2DxcDcun99mCAG9Y8WCE3ZtFBor7pIwDjtC8dzTdcJrQNLDmZQyuwQRHDYJiSFevQQV4Du0054/qRzVC37Fe9FM7eNcGgE6D/BrhRsLV41u9r4WAWHUZxgoRLqKthPI/ebLkKkMvcyKcQhxDsIla9MI5RB42eND1PdnJLkj857XVCUxuux7g0cvDHjj2KBH0mMWRWZxYEkHaXcm7VcCPIth6rJtalSgdVzG0NJVmo7a1uLpasO7W/UwarPDgbkdtHYFSQecNTv8oUNI1053YoKQufOmrJZcog4ix2tatQ8RJoDJjiiTHr2b5DprB9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jbao3XRKimQAZ/FWQ/Z64keA/6Hqw8lZBwbXcKCusF0=;
 b=aTZZHyxuTO2bEz2+i7eL60Y2by7/N2AlTt0AFAOsHzL9lE3pqtzzO5EXKqBaP2k2tG+fp+V1LjIvajocEyMMG/shfoUL8qOVfMfpr/tQFmz6avm8tXVWX4iIuEU5z3GIWH0IPzyacAWWBMq2IHpEco3IehI4zOiYLL4wXq4F5Q7bAofI+AupbnDbRpFi1yY5bDOfLqRTUHzCAF55FG8fG10I5on87ekU2ktD8Kfi4knQlFFEdgm7JZ9CdHTekj9XMAUHHCC0vMm4vs1Fv9rHneD5Krv96mSvSX14eHs6GhFVg1sQ+uU2icqZP1ITS99HdKa5Xi2rlf6T30PA8USnoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jbao3XRKimQAZ/FWQ/Z64keA/6Hqw8lZBwbXcKCusF0=;
 b=jOiUdxfR/GEEK3MdZ/dZ1zPSKMrXLUin0lQnzfqwyhVoj54vd2ikHDJxMzXfgJJrQCBKJ2tbg4N+06O116Z/FiwJxB+scscw+bapl9fv7pRm7Jkiadq98k8daFjecl8RrjdYr/qUaDqeW6Aa1yRaS+FlE4dPmDMT3VCQuj4LC9i0x91u61BdOgYu38JeLMbg4PSFN4LM4eIaqsvoU+vfzBnHF58dpKl6c5Q0J+uAKhRDmPY32atEZYaL7cgmwpnAHa6wp64Xr8ilS4T7NcG6JujmbcyLkOpa3kpR3AaqmZ+2F+UQ0lW+fYxBZ2LakKxemW9RWbdxmrEEm3xZI+cnvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI2PR04MB10594.eurprd04.prod.outlook.com (2603:10a6:800:26f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Thu, 14 Nov
 2024 16:48:30 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 16:48:30 +0000
Date: Thu, 14 Nov 2024 11:48:20 -0500
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	alyssa@rosenzweig.io, bpf@vger.kernel.org, broonie@kernel.org,
	jgg@ziepe.ca, joro@8bytes.org, lgirdwood@gmail.com, maz@kernel.org,
	p.zabel@pengutronix.de, robin.murphy@arm.com, will@kernel.org
Subject: Re: [PATCH v5 0/2] PCI: add enabe(disable)_device() hook for bridge
Message-ID: <ZzYp1G+cVlzPvBXb@lizhi-Precision-Tower-5810>
References: <20241104-imx95_lut-v5-0-feb972f3f13b@nxp.com>
 <ZzTL/b4BEAGvSa1Q@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZzTL/b4BEAGvSa1Q@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: SJ0PR03CA0122.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::7) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI2PR04MB10594:EE_
X-MS-Office365-Filtering-Correlation-Id: 22cc8402-4082-4ccf-1b48-08dd04cc2b3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d3R0NVlJenVTMkdwcG01L2NJTUZLek4yRjk3MlZLQTE3T2lYbjhYeW1Sczcz?=
 =?utf-8?B?VUM4V3FLUUl5SWJmc3Mwd3cyMmlGb2FVSFdKaDdvRDRObjVYR09nVXlaQXNv?=
 =?utf-8?B?SEdFT1NycENXVnc3NmpCdUkxT2t3YTNWblMzN3Q1RjlzaTNOeUdQUkh0Unlt?=
 =?utf-8?B?UmxQMVJqbUJ4LzZvK3Y4UjBoYWZGb01lUHdMNkZ6NlBwUzJIZWJ4d2YrT1k5?=
 =?utf-8?B?UjgvUUFHNHhUWU1VSlZVRzFvVjJBQ2xhSmpVOEs1SERab1hXZFpSY1VUa0J6?=
 =?utf-8?B?bktMQlo3K0JtNG1hZUxkNzNKVmdqa3A0YmVjZCtUdDhpWXVKdzJma1dFb3RE?=
 =?utf-8?B?Q1ZIMWJaWkVtWmE2bERLdDdyUk82dTBKL2VWcW5zRmYxQWg0a3dLMzRSMUZu?=
 =?utf-8?B?Q0xIV2tDaTRhTkxVV0NEcittWVhNMXRwK24xYkpWT1d1UnJnQURvOE9LRHlr?=
 =?utf-8?B?Lzk3K3hLVS9zbDg4c1FYOFlnZStMUG9STTE2YXY0eGtLZkxxTk5aeUVaMkJr?=
 =?utf-8?B?SFM3TGw2dHNKOU1ZQmRxb01BRndqRFlIMnZIaFNvbkNNUHptZ0RhQ3F6Q2dP?=
 =?utf-8?B?RXNQbnVvWHM2NG9MVkxBOXR4aFNkSlNPb3owNDVKNGE2bzloNjBVcGh6M0tq?=
 =?utf-8?B?UkROZnhiSSs0QTZLL3hETkwxaTN3c2hmQnFUWW1WQ2szWU9OclkwRTI2eHhJ?=
 =?utf-8?B?VjdKNkdXS0ZjNkI0QkRjSnJQSzlqM2N4clRkV1o2dUE5OHNTbGNHM2gva2hr?=
 =?utf-8?B?bm1uTktCTTMzems2S2hETUx0cG9SNDgwbXpHY1pIS216bTB2VEFTMnVUeGtB?=
 =?utf-8?B?TTE3ajBTT3hJRzhyQjBzN05VWnp6Q3ArTnc2Yzl5OUZ0U0VRTkdiQ2dkYjVG?=
 =?utf-8?B?bEpiM3Uzd0xhUC9QUTNub1BDRkhVQU9GL3Q0MENhUjhGbFdSc28xUnRySEpu?=
 =?utf-8?B?UDNPbmc3bHdVMTJiL0NOYXlNTC9HeUh1enluRmE5ZmVJZE9oVHcrS0tNblNu?=
 =?utf-8?B?Yk9xS0o0bGhqM0lXVVBiRUtubDhadGtialMzM0xrTE5USUIxUjBmYVZJeDZJ?=
 =?utf-8?B?VU9NK3V0MXZRbGJiNzNWSUN3MmkvZXBJdEFuYUQvRzR0QWU3TE0rM2paaHZD?=
 =?utf-8?B?SEdZcVNDMlZiOEtQbnVEcnU3dnQ1bWVQR241TUwvTFVSN3MwTFBabjl6UGlz?=
 =?utf-8?B?MDJLSUdQOGVYbGtzRHB1L2NhRUdDQXFnTEQvYzRJWlB4QUtFdzVTV2dJZm0w?=
 =?utf-8?B?dTVoOUFZQmF3RWZzQkRibzJpMTB6WFRqYmZXQXROSHFPWHl1cWVoUElJbmtL?=
 =?utf-8?B?OXNDb2ZvSlk5YWhzTjI0c3A2dWN5SmI4anplQkw2UWwvZEFQMEJ5WUJXU0tC?=
 =?utf-8?B?UzhRY1M3QnYxYmR6L29qRm1ycmZ0VkRLOWpuMXpMTVVTNys3US9TWE5mUTFz?=
 =?utf-8?B?ZEJ2bzNoUDVabllqVnZJMTlVNDRQM1FkYnBrT2FrR3hwdEdIVk9tQTZ0RzlL?=
 =?utf-8?B?bzBXeHVscVgwMFRoS2dnTWlKRHp0anM5VndOaFhQZ0pnWE5WWEEzdzV3UjF3?=
 =?utf-8?B?SDlpbHhmQWU3eUxDSmxqaWI5T0ZsMWY2cURaUS90d09sNmxWU0FWMlpsY05x?=
 =?utf-8?B?NndpcUpMMFpzWFNZWnhoT3ZKbmZqLzQzQ00ybVpqa1Z4b1F4akNjME5qckE4?=
 =?utf-8?B?bWU3NnpVcnVibzF6MUduMjNPVHZyUkpUbGJjc1h4bmJZbk52T1VGOHF0VTFy?=
 =?utf-8?B?UWFmUVdWWUZBbGRuN3lUb29BRXoybm1uZ1dkSmllUGZBWHRTUWd4OHZDWkZD?=
 =?utf-8?B?eGtQS0h4aENES3ZEV0cwOGZXQzBtNmM5STE5c3ozT1lIb3BZTE00RGI3bHhk?=
 =?utf-8?B?YXA3dVMycEJMa3pIV1NObFhiNzRNWHd1RVExdlVjVTZEamc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjhDNmFwcTh5cmtGZFkvYWVqUGNjMlZJWEtuUlhIcmZJQ3JBcmttWkc4S2I5?=
 =?utf-8?B?RitDV1M2Q2pjcEF0UnZsQVRjellGbmhkY0NRTHdSKzg1Zng4OTdzUE5PQytp?=
 =?utf-8?B?U2YyLyt3WCtXU0MrRFAyZkRaS2ZuZktyY2VJZTIxWTRtUlRNckFhM083RUZH?=
 =?utf-8?B?Q1Zsb2VMWG93QjlZc3pxZDQrRzY1bFVsaW93NU5HcXQ1TXVEZVNFcmNrUzRP?=
 =?utf-8?B?WHVhQ0I4bVJTTk9CTGV1WjZtQlZORkU1S3NPKzlOQW1RNmVCcnphTEhDOU9J?=
 =?utf-8?B?R1haZUtpbXkrckpXc2NDV2dYVmNTSDZtNThwWWdwNng4Q09yY0t5RGhUbmQv?=
 =?utf-8?B?OER6emREMkxDWnNUQTBZOEM2NldMVlFhZVYwejhjLy93WkZ4WXdKOFdoQ0xu?=
 =?utf-8?B?WGlaOFExdld0ZHR1eEhTSi82Zy9jTElYMFRuMHJBNWRabFZSZDJwN0I1Y0w0?=
 =?utf-8?B?RlBlRTFSRW95ZTlXc0cyZFhmTjRSRTJCNURUeUtMK0pTV3I3L3IxOEdhb1ZE?=
 =?utf-8?B?STJsMHExSlpyMFJUeGVwaWNhL3hlcldxVmgvMC9zNWl4bVNxZkt5bGNRNGVU?=
 =?utf-8?B?cmt5OGtvRnF4dkNqR1JyNVpqQUJOUUtpMjRoL3NYbHJBOGhXbDRrQWdVNENN?=
 =?utf-8?B?QVFyWVhZR1Zwbk9ZR2puYkFkZ1VHZFJsU3pWaWNVMm10OVBQenBPVXVvOFNK?=
 =?utf-8?B?a0FLVVpIQldRdGhBbEp5WlMvU3NsNzlYUWJxb1ljTjI1dHdTVlovT0hWYWNY?=
 =?utf-8?B?aTdlZlZaUGsyUHNGRWp0UnplMk4zZ2VvUjBJMGlKQm1nVDQ1aEx5WGhXS0ho?=
 =?utf-8?B?VXI4bFh6MVlFSmUvVXFFRWlIMDBSRVlCbTFBWW1ZeUdnVGVhakMvZEdhSXR0?=
 =?utf-8?B?Qys2cnE1MWdmOXM4R3RiUmgyS3U2R1NMa21KKzRFZDJDTWV1Wlc4ZnNQU1hW?=
 =?utf-8?B?OGxvOUZOV3d6Y3hhRXRrRzdHdTcvTkRzMm5Ma1JLUG9UWUtiZGFWQWUwU0VD?=
 =?utf-8?B?KzVjOTFRWjlzVGdPbm8zVjl4aGZjeE41UllubWI3bFhEdE9TY0VQNnFlVWJs?=
 =?utf-8?B?b3N1WUdBMXlpYU5kNWg3UnZqTk5jWmlESm83aEhFVkhmVDBxN2kxTFNiUGk3?=
 =?utf-8?B?UWJmajBLZDVXbmlZbjhRb2hOQ2M4cnJ5VjltcmtCeDRtSXZVeThnNzRtS2RK?=
 =?utf-8?B?UUNYK3ZzNlRTWVcrVml3T1h2RFVjSTRBWEJVaDZ2LzNHak9GU0M2QndzMURP?=
 =?utf-8?B?UjF5djNKcFZQcmNsdGp4Qzk0YzNrQWZuYSt3U21OaVd3OXJGcS9UYU5vL2Fr?=
 =?utf-8?B?OEdmSTZqVVoyUDVmS2FQZ2hNTDVTcUpvQmVPbFZLejBHalVNd3FQZkF1Qmoy?=
 =?utf-8?B?b3h5MjdpRlBKOEFsQk1lUDYxc0dDV0dOZzdVYXpaTFFFSWJOVGtMRWxxQlN4?=
 =?utf-8?B?UkZyYUZaN2c0dlJnZndOMGRYRzZTbXV3UXo3OVZnQ1FodmllcFU2ZmwzN2Fl?=
 =?utf-8?B?SzBvRWxjRjY0VWpIK284VXJnTDZWYml4aGNTUU9LdTNxUWhWUmtYbHZ1R083?=
 =?utf-8?B?Zy9uZjVINWJ0OEpJR1ZSYnFBR0duN21qVy9rclhsN3VJb2ptd1prMmlFODJ2?=
 =?utf-8?B?dk1oT05VdnJWMnRqc0Nma1NyU2M2R1FqeVpBSnk1QUlYRFVVRm1OV1laUnZO?=
 =?utf-8?B?YkQrYnVjd1p3bWxJR0tDRml6eUJxNjJvcktyalJnVEdhSWg5WTdBSUN2aTAz?=
 =?utf-8?B?SXFqb1hoMnpTNWJrMmNaUjc5clZ5RlNGTGF1ekE0c2lQd3JIandIbGh1Wmhv?=
 =?utf-8?B?R1F1amhiSlhYaFNqZlNvRFBFeTlRa1g0NE15QzBsUGhqYndaR3k5UzlVM3ZF?=
 =?utf-8?B?bWppR1BlT25PL1lqK28zVkc4OW5KaFNKVU85YUFyS2xRd0ZUdHF1VlBsYUlC?=
 =?utf-8?B?R2QxY0cxalRKbEhDUjNDbkMyenVaVVhhb3UrYmNBRHZ2UmZjRWVsNHlvanh3?=
 =?utf-8?B?SHVnZXo0aURCNE4yTjU3MTJXb3h3R2NLeVhnVG5lUkc2WXZzbHcxSDNBZ0NL?=
 =?utf-8?B?enFleVd6WVRLZXdHa3ROQ1FmOXd1ZDBTQjd6U0thWG5Nd3R5UG9sVGNvQ08y?=
 =?utf-8?Q?SenjAKHwMM7tEW7klbU+nAlaa?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22cc8402-4082-4ccf-1b48-08dd04cc2b3e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 16:48:30.3464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hPPrQngCqcODNBclzldA1ldkti5GYGmYNCo4ow/YSr83tM8RYK0QDbhIcQICft0Sftom4z96RaBygKZrSpiEhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10594

On Wed, Nov 13, 2024 at 10:55:41AM -0500, Frank Li wrote:
> On Mon, Nov 04, 2024 at 02:22:58PM -0500, Frank Li wrote:
>
> Any comments for this patches?
>
> Bjorn and give ack at v4 and Marc Zyngier give test/review tag at v4. I
> just drop these because change to use helper function and funtionality is
> the same.
>
> After this patch merge, I think apply's bus notification can convert to
> this way.

Bjorn:
	Can I keep your ack tag in next version? you give ack tag at v4,
but I change to helper function at v5. I plan send v6 soon to fix mani's
comment about patch2.

Frank

>
> Frank
>
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
> > Above ways can resolve LUT take or stream id out of usage the problem. If
> > there are not enough stream id resource, not error return, EP hardware
> > still issue DMA to do transfer, which may transfer to wrong possition.
> >
> > Add enable(disable)_device() hook for bridge can return error when not
> > enough resource, and PCI device can't enabled.
> >
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
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: Marc Zyngier <maz@kernel.org>
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Changes in v5:
> > - Add help function of pci_bridge_enable(disable)_device
> > - Because big change, removed Bjorn's review tags and have not
> > added
> > Marc Zyngier't review and test tags
> > - Fix pci-imx6.c according to Mani's feedback
> > - Link to v4: https://lore.kernel.org/r/20241101-imx95_lut-v4-0-0fdf9a2fe754@nxp.com
> >
> > Changes in v4:
> > - Add Bjorn Helgaas review tag for patch1
> > - check 'target' value for patch2
> > - detail see each patches
> > - Link to v3: https://lore.kernel.org/r/20241024-imx95_lut-v3-0-7509c9bbab86@nxp.com
> >
> > Changes in v3:
> > - disable_device when error happen
> > - use target for of_map_id
> > - Check if rid already in lut table when enable deviced
> > - Link to v2: https://lore.kernel.org/r/20240930-imx95_lut-v2-0-3b6467ba539a@nxp.com
> >
> > Changes in v2:
> > - see each patch
> > - Link to v1: https://lore.kernel.org/r/20240926-imx95_lut-v1-0-d0c62087dbab@nxp.com
> >
> > ---
> > Frank Li (2):
> >       PCI: Add enable_device() and disable_device() callbacks for bridges
> >       PCI: imx6: Add IOMMU and ITS MSI support for i.MX95
> >
> >  drivers/pci/controller/dwc/pci-imx6.c | 176 +++++++++++++++++++++++++++++++++-
> >  drivers/pci/pci.c                     |  36 ++++++-
> >  include/linux/pci.h                   |   2 +
> >  3 files changed, 212 insertions(+), 2 deletions(-)
> > ---
> > base-commit: 06fb071a1aefbe4c6cc8fd41aacd0b9422361721
> > change-id: 20240926-imx95_lut-1c68222e0944
> >
> > Best regards,
> > ---
> > Frank Li <Frank.Li@nxp.com>
> >

