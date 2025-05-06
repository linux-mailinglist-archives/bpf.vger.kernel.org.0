Return-Path: <bpf+bounces-57529-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 434B9AAC7E3
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 16:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A10BE4A3DC8
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 14:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1B328312C;
	Tue,  6 May 2025 14:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="oKeQFzMP";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="hf38WvGn"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6444F278E5D;
	Tue,  6 May 2025 14:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746541541; cv=fail; b=nSSJOjUWKOvBev4NVKry2KRaWsjlScrv62Y4JMaAVYGyVT4mYheso4MFbC09PYAlAcC3ZhmxM9+yJlKa7OoyfJJ2gDC19K6WgZu6C12tf/rCXVro5dnNJ0/k1B83ps+j9YqVOFCcGPvnJ1ZGUMfJnc4JulHITfDPFt0r7QiwLx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746541541; c=relaxed/simple;
	bh=BgDZQ1Hbc9YfhcJNA8AeoLLdotiG9+HPIvvdXNyr3Ss=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HVexhQuzylbpUSOvc8ZbGaK8ZUhL/MLwvltx1b10qJesZOImdDrtfTHub5oh3+SRKNMwmDvvj9IXno8CA/ASJy7jCyPbAAaK6a0d2zo7DojAgopYbRx5K4EFrSOLHKtjdBdV+izFTIjhRiaKUmYPBtZJaeCSMv/EC+RPZRiMsLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=oKeQFzMP; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=hf38WvGn; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 546DRMuL014390;
	Tue, 6 May 2025 07:25:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=dWdP2uLHRAnd2JpaF8AR6R18qYbHpBKl77qHJPCND
	/k=; b=oKeQFzMPSAMWmyl5CA2vf+NFiNl/dc8DxX31N2g/oBNQlM0pu8JfGDSTT
	ZJw9PGdqg5BLyo9E+GGnNJqM1Ocr8o4JJhvgXRBZfbREFVmDQmnK0o/+uJx6UgqG
	5lyMoEk8igCXS4/x+HvLkEOsMUlTrlo5908XHx5I3DSG7T4cjNuY8kb6nNTQhgu9
	btH1foya4cmBee2z727NH5QAiNGZ9fhMPuxZelp8aECXQDfPxsvwTogAmtVleoh6
	n4umILhLJ4AePvUSFysZqa9HUoTohwBsTE+c64I1PQQSqn4DTWkxUMXUTXegKz6Z
	XHBIQb6hpo/WTvVrsbbSTnnG9QIFw==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 46dgp8x9cx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 May 2025 07:25:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m1VNaJ8UvXJNKQ99jkrCJ8EjEx2BNEd4QCJKktrMMcob3fYNvzUIGmpUP8bZKiGNqld+vv1O7DWIurZqQ20JqPJMoStPeLpbn2r4mNd6dqKx2VdiEhV5pvPZncpD4tQKKeQ+U0o4OamVlLR2vqokANvqYRrBv+B816Qs/1HtEvfiw2d7OF6Lv2IJLWFKP2Z+mbm/AFZfRX2DPVoefEDlO60rNdmite6Z6RwDe+S8AwoAuidAc0jw46KHhVbMW2LyKXPyo2kRGCdxo036KeywtiASAena9xm1FVppa8ggbtCumqfWJBgagP+Elgytx3EAszNiZX1MorzMyYhbLvSbpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWdP2uLHRAnd2JpaF8AR6R18qYbHpBKl77qHJPCND/k=;
 b=YRVAsIM1FeHHs+NZZFViEer0KNFMEAubtyOENOEf25gmgR//cWriDwPEnPSBZBPwRcBhPrzEAhTUl/AkIUgiJYPzU8JW+uNQ5S3B/YYZH60BqJmGEcz19SeWvtU96UES49tb3hyz7ubtsrGNpuz5/EedDdup1EkowX/GLuQWP/6MipAv+eDlTvRoo2Hw5Gnj8U8ARiPnj3vUHH5ScNdhUxemRkc7KEEaQrD/XJxyMr8mQxYJ2mFHzN1ZRM6bjQc6tcp9vAvXijjWQWwF1E2voLTVBZscmOqe8DxI87sEYF/5unS8PyYQ/hCvaa0JCrpHqxE9iWaF9yBVvNx1xaTfTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWdP2uLHRAnd2JpaF8AR6R18qYbHpBKl77qHJPCND/k=;
 b=hf38WvGniDkhPp6R7K1vhGv4/GBeDPl8BBvjMAlyQMC0wtLR7x/l301RSb1T7gctOuJzzdeTKPYmzfhT7yIJWQj7XcngN9pCotaN44aRRZU+EdCuBNqZW/mQqHQi/RtYnCwxV1sMPyH0DfgwMne4LQ+ghh3j8k8bGG1xmJIf6Yb0bAFhVc+fWvzZzk1NWHoU+8UQ1irdJPB1LsTlDmuKaxdnOhu4zJYWqOf4DnnWoxpvzOzUQr4691wb4G7f4PYrXzuJS89HrlOJJvXw5UgzvbMzCCHiGe37SWYkkJ0jl9hIdufLxAoMqraCC0yI8AvFsBaAKAiV9sp+E6KaHNdOfQ==
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10) by IA1PR02MB9181.namprd02.prod.outlook.com
 (2603:10b6:208:42b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.20; Tue, 6 May
 2025 14:25:15 +0000
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054]) by LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054%4]) with mapi id 15.20.8699.012; Tue, 6 May 2025
 14:25:15 +0000
From: Jon Kohler <jon@nutanix.com>
To: ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org,
        hawk@kernel.org, john.fastabend@gmail.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, jon@nutanix.com, aleksander.lobakin@intel.com,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 2/4] tun: optimize skb allocation in tun_xdp_one
Date: Tue,  6 May 2025 07:55:27 -0700
Message-ID: <20250506145530.2877229-3-jon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250506145530.2877229-1-jon@nutanix.com>
References: <20250506145530.2877229-1-jon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:a03:40::19) To LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR02MB10287:EE_|IA1PR02MB9181:EE_
X-MS-Office365-Filtering-Correlation-Id: a1ecd0d3-8ad7-4774-ee23-08dd8ca9d1a0
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QlJXr/Vj5dmxf2f0BmYLvjAmmpr/AtiE9pJykI/VHzAIef6kEt6aMIg1Tk+6?=
 =?us-ascii?Q?IY2ReQjo02oYqa6L1iLOIlWgb6yNDHYeGoakFsuY8jWdjbPrUZ6VNEtLtJdJ?=
 =?us-ascii?Q?36Lzh3tt3c/f3dwLdgfTCfQ844Dzp1MF2E5faMZvklIT+OCMxeceKakLnAoX?=
 =?us-ascii?Q?HjWWL0Fuzy4AzejT3m468KcfgL86sIZTZx02B+xkvRRqG3Oi7TMGIGcZxLjE?=
 =?us-ascii?Q?Lp8dnMZFAZOE2KS9zibTe96mm2mkl2+csFZ1yZN/8xBPgGIDGwptLEx3fVta?=
 =?us-ascii?Q?gkaS5cmwz34csm7QNDYok/YF+Qp+iLSkq+qnWmsrB4Gm9PqhiI45EOWIZQOf?=
 =?us-ascii?Q?C/+OOAupUCP0R2+0eYtd7Nzhn2ZWtLT6bkmRmc3kuJAraJnw53mlBqtLBP05?=
 =?us-ascii?Q?Sp1Q3iNZKRnTcKDl+3gbohDaKUDOiQ3bF+NvoApF1OoOy2zW5JcXgfY6si5M?=
 =?us-ascii?Q?wbmwFh/FR1AuEOsYoeJCRqVzfyz+1ilMoC9LxJYViZPoyyERQCxu6Tw7FcbL?=
 =?us-ascii?Q?8ahB1wRPvX1OpKNjK+gUsE4CumF8HLQ2n1AM0i5GJB6YAULzKxQqExA2mH51?=
 =?us-ascii?Q?imCCHsMevhBqcdxgs9VoPMXabLnuqX0g7htZk1pOHur4oXftDzHTT3TAnisR?=
 =?us-ascii?Q?8fqzLgEI4zGtL/fRhbNTszx0euTAhupr3gmZE2RE5tGSubLdrMnYrXijFuop?=
 =?us-ascii?Q?m5SDTsT44UZ1kY2TKYdX2NTbDU5cxz5aCcvc0Z0Prnj2CGqqdJJXk74AfBj/?=
 =?us-ascii?Q?ARVmXs+vZbAdHIPTt0R70/3ZfYpje/ite7tFjrSo8wduN1IWm6zr9SCAAbRr?=
 =?us-ascii?Q?OUyf/GaJZsZIEV4UGM9DSjV3h+3xjnIot5rBYAeshGcdQwaxJaaDLdt4fHvD?=
 =?us-ascii?Q?JVPTF+Q6nyh1Hs68DRKkUDsqt+59jQsSZ8m3BL61JpEBPQyk768YnA9QzbE8?=
 =?us-ascii?Q?Ie0q30wpfGiNeH2ckTt5CuO9OifdMot/eKUQ7DNa+OXsqXT5GDu+rj9NgYNF?=
 =?us-ascii?Q?o00eazbznRADdw58F1iSKFw5ym8uZdDK27z2g1V8UMdnXgTFGEZfyrI8U8NH?=
 =?us-ascii?Q?vAuhVSOV9gbZIP2QaRYg4KTCNOnc17rKTQsYL6a+pzJH+rezgFKWca2FszjW?=
 =?us-ascii?Q?NVqf4EZSnp+PHZkl3co5J1ikDa4Ue7IyeAbOoPnOdQAawAg0mr1MnD97jVpo?=
 =?us-ascii?Q?HKeXmPubbHY7lCk2wfD6yvjAK+IUNLxok5lu/UR0Ijj2Yv8avtPCvieVfAfJ?=
 =?us-ascii?Q?b3yJbp+6x+yibfx4FIP2rfh7UTfCxTuSfONdeS9wPjBLT7IkGcAjPgfl4L/S?=
 =?us-ascii?Q?UTuSjP7qHByi4xr93uM/PSHrCzd3KK8JY4Ig1dDlJQjJ1P6Nz0ga3mC15Zy4?=
 =?us-ascii?Q?0Dtsann3Nl478WjpBslYPy8fTFguYH47TrKVKRRAItLQIYbxQPcssUBDDs9u?=
 =?us-ascii?Q?La53bppAh0sck3Cy5mnR+V7q2kkW1MrtxWACLmN+DpjDFNm/CJSU3g4AJgzr?=
 =?us-ascii?Q?3/TcFri0ePnGQvY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR02MB10287.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cN7eob9elZunp+uQ0FasAehIDpaoeCU3ePEIQuXxH546bLBFVUVSqSLFmxtA?=
 =?us-ascii?Q?CNs/m/t9ngPZGY5sKXJJd3EP1rE/ZWbNqn8WFh6bTWFAZQBIBaM56XI+U1K0?=
 =?us-ascii?Q?w2v2WlR1j8sYSkjoLbjoEbQFfBwxaddJoddCQTKSrOY+aE1WJm0cCaDBdt4C?=
 =?us-ascii?Q?JzgISH21vHYwo/gmxzpJjS0KSBDft2zk2KjVg9HrqleykeywRkQHAnB6pHvO?=
 =?us-ascii?Q?Jq0dOgHA+xrXmz1E9Zgjh9kw9seWvvHa/7BhxFH1AnprUTrNFsHFNwxJn++J?=
 =?us-ascii?Q?qN17YiMhM2ZFRS89FW5ZwGSZGead/kPSYPAJ6W0lhFmC6tv5NoVCMP2OcEf3?=
 =?us-ascii?Q?4YUtQETLhL0IwvV6NrTHCPeZq9Iyxu0ccWOEEOzlRw7xFny0Kcwb3ALg0Yio?=
 =?us-ascii?Q?pNVSfm7IcRsFDmD4ToSNs23JO7L2mF8PDfGqK5vJKmyGIBBHlR0OzRxzZAyE?=
 =?us-ascii?Q?3wrphsyDNH1jORt4O2GUELXBFG1zqbpiGKgRwH06KOqmOd2OkZDut5sjWdsx?=
 =?us-ascii?Q?bTd+sKdf0F7CaCufoEBjMoyE0XGGR/ZlFiLPlMDUvUyVVK+yHJfHX6/mJ6Jw?=
 =?us-ascii?Q?/ayQ/e6BmwvR3aijKFGC1yl7RVI7bh7dQHBMlHW9Stf+nH9SiE9lrV9MQu1x?=
 =?us-ascii?Q?NisPzTibic7yz6Q6WyAo6hOZBVlcvFTNGTic2FIzAl2VhoLW6UYf6hYG9BoF?=
 =?us-ascii?Q?X7NBjLy3iStXkL725zY0oN/chzfWpzERjG/bQNuTmT+yFE2fjW0wDC8Qoo4f?=
 =?us-ascii?Q?tYzbxdvDPsfKwLxW0eUUn6QPW/GKKRUdKY8EL3XeGwoRyHfGC1xhkCmId1uZ?=
 =?us-ascii?Q?FzOc/4YCJ+afme5w+Sjd155xMuTjFxR5dhBhFH4oZW8HStV4mwtLNfVCVNwj?=
 =?us-ascii?Q?Py6jvQHBeHP8/hg6M9ZtH5X19GyEAOAieWPdovbXg/DWV5IJvwxHNmBq880/?=
 =?us-ascii?Q?vRANKpYeuv3TX51ynYGSrE9Lcv/V04qotwAxTV/1Pr/qAYzriElzxYsD3h25?=
 =?us-ascii?Q?DxI9pIFHew8KlpvgdGSON9Qxu9llgnycZJw2x3M0jbwFX1fcPApm/rqFRIt2?=
 =?us-ascii?Q?dFQ23r6FtniLSJUfNXeKz6VM1cI/+2ONDJYPOFKlGfgrIEZoVwR8nBYv4kt3?=
 =?us-ascii?Q?QbTws4n4g2ElKY45KvNGZ3AYbaPaDJNaQdWHRGc2b6h5GlDMazFHy+SG6YDp?=
 =?us-ascii?Q?eqbvFWcngti/lRyIeQe6n48lAX81xZXiubC9Tx5pnLPY9j+ilYr6C3P96kdH?=
 =?us-ascii?Q?V9moACyxsOm1MwCZZ/P4AP17WX26RH1Czw2nP3yaIk+u5HUHH6hs8daUiWmw?=
 =?us-ascii?Q?V1b5uidJXJ/ahl/D2D1rJ4C3Z5edP5DoKYMycwcw/6hkM4mcWRBl4Vdi5gyX?=
 =?us-ascii?Q?oSqCkXFgk/XzIrnob+KlKuuBT9Jm6Zb38R4T8/iegpIVqg8YuJNeeHUvAkAW?=
 =?us-ascii?Q?Rb19a5tV+mprJTUB2uBGp4mZ1kpf2n/2cR3opVYXENtZKKieGGEOXyXQQcHW?=
 =?us-ascii?Q?I5/YYfZJ2wkByc70uwMFIJeMLmbZR1bHjqBs0tP8Bw7fntdiXf+Y3voVvPdw?=
 =?us-ascii?Q?K+STDp09ED48QXyTtjrM6AKohKy8Bnrt36XkHOy9gM9ZOBH5Z8HYsKnro+Jl?=
 =?us-ascii?Q?cg=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ecd0d3-8ad7-4774-ee23-08dd8ca9d1a0
X-MS-Exchange-CrossTenant-AuthSource: LV8PR02MB10287.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 14:25:15.2869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rKZt2uS+BkEyKGeYkjtEq54rl4E/5gzWwnEipVjSbestFRVQj0XBYlpZmNGnvAbWVKsfDuwwR2/9gmlYQ90cQp2OPhsSXaWzuPRH4TlX6Rw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB9181
X-Authority-Analysis: v=2.4 cv=R6cDGcRX c=1 sm=1 tr=0 ts=681a1bcd cx=c_pps a=clyc6YhGvfCRRXf4btgSWw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=0kUYKlekyDsA:10 a=QyXUC8HyAAAA:8 a=64Cc0HZtAAAA:8 a=ffVvEST6HvfN9k-9IdoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDEzOSBTYWx0ZWRfX0Xo9wrK0smYR HKPPjWjHmuUllybHmSb0nvSE7BjOwMFFJNeQZFG83u9Uf353deGtClWlNxMHIh8KxRoZHZG+hK7 9GqlT9un1yAr6YxaiPrKeVaZ6uLaIkM4DMMZZGN0a3XrHIWO6eOBV+xPpL4ZfY8A5pVw8NasiYv
 CtLHItFvoJcQXAIaRaVXgH/l/RljyveHjp2CIc5hanf+hr4K41y/b5H/xpV6hiyHVchXIA+Hk0t Ps7gUb5X/DZgiHwJPK4aPbsLCo8HYI+87Rdo+FvFXTiIOEsPg9/ppc5Y1RvujEQHYGy3vF3D/gC 2goHudTvSDmNfo893pD0x0eZHn44BKN1TfxYXBNvUU5VUkrTd19Q3KUASrLqw4Cz3VqX1pchnvb
 bcUhdxSBj+B/Arz98CvPQnD761hoXUR7bzsuqnIabjgbgtjAETC/tLiQCdPzC6oI2mYCY7Y5
X-Proofpoint-ORIG-GUID: SfDHNFLvOTcbhqsSv70FNaxWtgFt-MxJ
X-Proofpoint-GUID: SfDHNFLvOTcbhqsSv70FNaxWtgFt-MxJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_06,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Reason: safe

Enhance TUN_MSG_PTR batch processing by leveraging bulk allocation from
the per-CPU NAPI cache via napi_skb_cache_get_bulk. This improves
efficiency by reducing allocation overhead and is especially useful
when using IFF_NAPI and GRO is able to feed the cache entries back.

Handle scenarios where full preallocation of SKBs is not possible by
gracefully dropping only the uncovered portion of the batch payload.

Cc: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Jon Kohler <jon@nutanix.com>
---
 drivers/net/tun.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 87fc51916fce..f7f7490e78dc 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -2354,12 +2354,12 @@ static int tun_xdp_one(struct tun_struct *tun,
 		       struct tun_file *tfile,
 		       struct xdp_buff *xdp, int *flush,
 		       struct tun_page *tpage,
-		       struct bpf_prog *xdp_prog)
+		       struct bpf_prog *xdp_prog,
+		       struct sk_buff *skb)
 {
 	unsigned int datasize = xdp->data_end - xdp->data;
 	struct tun_xdp_hdr *hdr = xdp->data_hard_start;
 	struct virtio_net_hdr *gso = &hdr->gso;
-	struct sk_buff *skb = NULL;
 	struct sk_buff_head *queue;
 	u32 rxhash = 0, act;
 	int buflen = hdr->buflen;
@@ -2381,16 +2381,15 @@ static int tun_xdp_one(struct tun_struct *tun,
 
 		act = bpf_prog_run_xdp(xdp_prog, xdp);
 		ret = tun_xdp_act(tun, xdp_prog, xdp, act);
-		if (ret < 0) {
-			put_page(virt_to_head_page(xdp->data));
+		if (ret < 0)
 			return ret;
-		}
 
 		switch (ret) {
 		case XDP_REDIRECT:
 			*flush = true;
 			fallthrough;
 		case XDP_TX:
+			napi_consume_skb(skb, 1);
 			return 0;
 		case XDP_PASS:
 			break;
@@ -2403,13 +2402,14 @@ static int tun_xdp_one(struct tun_struct *tun,
 				tpage->page = page;
 				tpage->count = 1;
 			}
+			napi_consume_skb(skb, 1);
 			return 0;
 		}
 	}
 
 build:
-	skb = build_skb(xdp->data_hard_start, buflen);
-	if (!skb) {
+	skb = build_skb_around(skb, xdp->data_hard_start, buflen);
+	if (unlikely(!skb)) {
 		ret = -ENOMEM;
 		goto out;
 	}
@@ -2427,7 +2427,6 @@ static int tun_xdp_one(struct tun_struct *tun,
 
 	if (tun_vnet_hdr_to_skb(tun->flags, skb, gso)) {
 		atomic_long_inc(&tun->rx_frame_errors);
-		kfree_skb(skb);
 		ret = -EINVAL;
 		goto out;
 	}
@@ -2455,7 +2454,6 @@ static int tun_xdp_one(struct tun_struct *tun,
 
 		if (unlikely(tfile->detached)) {
 			spin_unlock(&queue->lock);
-			kfree_skb(skb);
 			return -EBUSY;
 		}
 
@@ -2496,7 +2494,9 @@ static int tun_sendmsg(struct socket *sock, struct msghdr *m, size_t total_len)
 		struct bpf_prog *xdp_prog;
 		struct tun_page tpage;
 		int n = ctl->num;
-		int flush = 0, queued = 0;
+		int flush = 0, queued = 0, num_skbs = 0;
+		/* Max size of VHOST_NET_BATCH */
+		void *skbs[64];
 
 		memset(&tpage, 0, sizeof(tpage));
 
@@ -2505,12 +2505,27 @@ static int tun_sendmsg(struct socket *sock, struct msghdr *m, size_t total_len)
 		bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
 		xdp_prog = rcu_dereference(tun->xdp_prog);
 
-		for (i = 0; i < n; i++) {
+		num_skbs = napi_skb_cache_get_bulk(skbs, n);
+
+		for (i = 0; i < num_skbs; i++) {
+			struct sk_buff *skb = skbs[i];
 			xdp = &((struct xdp_buff *)ctl->ptr)[i];
 			ret = tun_xdp_one(tun, tfile, xdp, &flush, &tpage,
-					  xdp_prog);
+					  xdp_prog, skb);
 			if (ret > 0)
 				queued += ret;
+			else if (ret < 0) {
+				dev_core_stats_rx_dropped_inc(tun->dev);
+				napi_consume_skb(skb, 1);
+				put_page(virt_to_head_page(xdp->data));
+			}
+		}
+
+		/* Handle remaining xdp_buff entries if num_skbs < ctl->num */
+		for (i = num_skbs; i < ctl->num; i++) {
+			xdp = &((struct xdp_buff *)ctl->ptr)[i];
+			dev_core_stats_rx_dropped_inc(tun->dev);
+			put_page(virt_to_head_page(xdp->data));
 		}
 
 		if (flush)
-- 
2.43.0


