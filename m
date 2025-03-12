Return-Path: <bpf+bounces-53904-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B09C1A5E132
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 16:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E696517919C
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 15:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55E82566E1;
	Wed, 12 Mar 2025 15:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="L/lnu3kh"
X-Original-To: bpf@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013027.outbound.protection.outlook.com [52.101.67.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5DC2033A;
	Wed, 12 Mar 2025 15:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741794932; cv=fail; b=sbwYRrd31sxJCDwO/zC9aONqPhUyyv4FSep1bfOHwMK/CW0waVItMnW+RR/AOK3n8j2Jpj7KjmedlK9h0gx7qGAHtE0daxxgeWwZXXbh7HB3GoeHRvdiJ4YoUG+NME35M3fmBBayil8KtLFMe1tFIoHOxuFO4baJW2yKqq+Uz5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741794932; c=relaxed/simple;
	bh=r79E8J8iB0UDd1bJ783TOoP82l6Wy9m9IVkdQb2ycWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uyd3WSt4gAhiXGjFrohRaEHP4Ue6gc8AVp8NQ0wt4EQ/CvB8ZyTj970KhX/WzE/w74myEs0h0IL1L26IQ7H7WqHX4onLhLjXcwa0NN5PjTsuc3F4mKvXhmCADEuQyDorNMFp7d2P36CYyO5VEBlLCx1FhbiC92XqJUExZnuJYek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=L/lnu3kh; arc=fail smtp.client-ip=52.101.67.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GK78duC4gWB17TfTrp7TeLXO9WxeNcZwi1Wc9IkpuyMK5uv2iVjsjaqtVhf1DTASuZNj69H4xdQc3YzgBr3Pgf1k2mdAyqw4okh/JYl/JPH3e3sBUVeh4fImbbz3kbK59HzyNWR36xcRBuYJroBR8MQ6iXBuEzWbVLibY648ERPll0PN1hGPnTh9uxjmDz8w/3wP3IeRM/ek9Onktw2asqrGTj70R/IGmUBeuITukUXzPyYWgkY44ep7TrKrQCDoIg7V7zbLTZvTXkNljfhU1w9zyCHzPIjLBGDLos8rCaTgpJAoZnAmjk3bSHPH1JzbgAhucLp4g0jDmZN+YaOZ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zpeh+JWSdfC1eghSEPaP1TCaKvhKugSlHjxXOKdD7lo=;
 b=Zk09F0F9eTpsqA7466VFVCXt968lZogLaLIOXRHNG3avnagVp1HJDF5CGqluKgWtGszoA8UzJPUBO7Y6ibsSCp6gqlUCb27UsHgHclC81Zq3rA3+yn80gaCFT1Ty3bXlyJTxg6vB/muxT+4A6Ppo6akd3+OA9WL7tga8J3atC5P7sipzbPUxGFo3A2oHuznUJHkH2p+dJcXE+kGMIfCCv4e0jumAjT9sSsNpdNTNwRMz8DJdrfu6lHMD9A5+Xaih9ddEzPPvG9NKQgQEEhr6NgTOS4U+puGAML/ljFh5tMTxM+d2YgV4rdLEOgUwkCqVhU/cbpAyoq5PfXcynEkenQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zpeh+JWSdfC1eghSEPaP1TCaKvhKugSlHjxXOKdD7lo=;
 b=L/lnu3kh+F9xj7Y72IX9+DBFXp+a0xW5psO6Lrn/zDwdzcTS383SlSg6mAHUIf7SRUy+HJYI8VEwEHuU6fYMjVgfOV4+bA8z3flgruQsvRcKtbCq3utWe2DZBnFxXgHlKvmju/P3tpgR1khHxd/NtxitnGfQRlPhp0SnH6/YCGEuN7xb7mkF+IpQhtTEpcTCoYGExkOVwdMUTfJ+5brL97Kh643EopFk7VDXN+4L0hCiF0FEgNPoEBCPAWV6PCZSAVYbGhULThTlS8DUUvjw8Vw1YCsfE00e4b8Vi9ErhxJUy6/MuzNPRZ8tHvJb0e1xxH/+rhA6RmYVulpRbhpuVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PAWPR04MB10008.eurprd04.prod.outlook.com (2603:10a6:102:38b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 15:55:27 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 15:55:27 +0000
Date: Wed, 12 Mar 2025 17:55:23 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Furong Xu <0x1207@gmail.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Serge Semin <fancer.lancer@gmail.com>,
	Xiaolei Wang <xiaolei.wang@windriver.com>,
	Suraj Jaiswal <quic_jsuraj@quicinc.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Gal Pressman <gal@nvidia.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Chwee-Lin Choong <chwee.lin.choong@intel.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH iwl-next v9 13/14] igc: add support to get MAC Merge data
 via ethtool
Message-ID: <20250312155523.rs6544cbsvyn5ojj@skbuf>
References: <20250309104648.3895551-1-faizal.abdul.rahim@linux.intel.com>
 <20250309104648.3895551-1-faizal.abdul.rahim@linux.intel.com>
 <20250309104648.3895551-14-faizal.abdul.rahim@linux.intel.com>
 <20250309104648.3895551-14-faizal.abdul.rahim@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250309104648.3895551-14-faizal.abdul.rahim@linux.intel.com>
 <20250309104648.3895551-14-faizal.abdul.rahim@linux.intel.com>
X-ClientProxiedBy: VI1PR07CA0282.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::49) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PAWPR04MB10008:EE_
X-MS-Office365-Filtering-Correlation-Id: 59e2fc16-dd60-4576-d856-08dd617e4f00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Cb7vBEyWouJeaC+e9SBxE2B83CFipG1nqee8BFe1lTfwJalQmWILumO4Qusw?=
 =?us-ascii?Q?u+tTLcGGaf0InryIEDK7YGUsz3qdpPG9YSLHkiZ4dYVY7vfO/iRuf2JAOcTw?=
 =?us-ascii?Q?RHmxvKCLzBJP7j7oYgWMKc1wD5pH4yOtrHpozlOJablN/CyMTqRYkH4vq2tO?=
 =?us-ascii?Q?wPwDHKZ3fj39sFVS5hdIL7OtRpXNAW0E5bfeLONSwe6wZLaf5jpB6ySWVDht?=
 =?us-ascii?Q?W45A/erKkG1isvft9nxkVb8N4ZlJrLZphdBSyREp7tTqZl3ooTGEkEYNga7a?=
 =?us-ascii?Q?cDM7DOaK/HLyLqV009qAAE8mpJMWhk5tIQ+NV4rdOgLjP8FMF+brLQSoUKop?=
 =?us-ascii?Q?246IOZvijrreUbeZaO1pyNjmIhuJhlkOxM01ytaxLVp2ChNXSw283wedSoyW?=
 =?us-ascii?Q?KOql7ZABvFlYrqABq3tRq3VsIn0mZJmvsO7nhyInwP/WYM5ldFm4jkbchV2l?=
 =?us-ascii?Q?Xk2lzvegVvtuUkFQZHUsFaBFwaP1/rXAthNknrNd24rfsZJvULiYNS6PqdCm?=
 =?us-ascii?Q?+uJ+n5RF2z3xIqHxii1RdGryEJMOcUpz2lXfHM/hFCXDwryNgEC81WUs0FdO?=
 =?us-ascii?Q?Cjn0ONn9rWw2mYqO8xiZzcrfmlHzv/1rV6pwgFCyhxeRGYE/X+IlHZKvkosd?=
 =?us-ascii?Q?jPMSpxbhVxMfPgmLC5vUWBJlEca2UCsMb3FQ+GHEaoxOChOeRXQoKVOJg/DU?=
 =?us-ascii?Q?6C5FCFFtU6LIN8mqeAlXBCMoKZ07A7/qoDjFmd6qc1oMd0AgRM4BwDDf4Egn?=
 =?us-ascii?Q?ieWw+vPb88yzzBY6adtaDLNo5gH2iVGr6V7n6J/LED1JgWJ/I9Aa0Nof/DsB?=
 =?us-ascii?Q?7t70/MmcPac15Wf01fjbawQC/Sp8WG8b4UIZZgrnbv0IfkFvyNTpkH9oOfuM?=
 =?us-ascii?Q?1sYXYY1vyLVoX8qsUH5n6vtp3kLOOYTxc9anzaOHiwdu6ECQGiU8TF3YX1K+?=
 =?us-ascii?Q?oyKAt6rpRMNSrK//7gCnOLYWC5zvGp5iXFk12LdS+2FA8VORWytsuLTdUXkF?=
 =?us-ascii?Q?Dr3+tGjt6BKpmwmAcW3BMhPdNy5YwfdI/qcRg79TGWIsXWJhty0NnZLNMexJ?=
 =?us-ascii?Q?bLszn9vmJvO+xVWImd82wHj9gU4WAfVYwWb1CVzeGrjLQiif/WxqOW3Ka4x8?=
 =?us-ascii?Q?ZoREx/KjWRSqMIRQL56mP1h58O9/7vMnnHJbW68oOU85aYEkPDvMIZtcoK7h?=
 =?us-ascii?Q?NWU151nIlsZn1N4hHnuruo0Uk2j9dOSURTsLSbtGDCznkhfKcI8vXAfvUJCj?=
 =?us-ascii?Q?AXrAUHS0BRFclABjypGh7+2Ihk8Voq/zJQY9Gc7e/i4pnIl7brnkYI8Hv+l/?=
 =?us-ascii?Q?Kv/cDp6BjL04mM03l7DHSdJnXOKP52Qle01LqQyEhTkqqB7mZ8tx5LjanaZp?=
 =?us-ascii?Q?B9S4g1+RclptlpuY20r3XwIj+cEv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jd716TYiww8xBRCw5c4P77R83kIoHzAzrI6f91df6htWqRX/b/wWOWB9UMUU?=
 =?us-ascii?Q?KPCbofi9pePtAnRdKE+D4zj1l3Wh05LIyGgXs34m3RhNhTlkL/HtGTH0NIyv?=
 =?us-ascii?Q?3dK2TF/LaWfoA0b/vK6rBHW2aoVi/+9Pghw2t/gFtpcn1btOk9DkIpT8cEI1?=
 =?us-ascii?Q?RZYtvRXqYrldjaa0euvWJn79NL5APMB12AimsLeuBOn8QlP4T5NfZCBJwmnf?=
 =?us-ascii?Q?wRD4xLrhg5S8Io+JcG9KgLd+YRpkrEUhzdQqy3Tzdj0sYT5/ZPER4SJZpOm9?=
 =?us-ascii?Q?Q9/Q6/uB0Im9ZM7NH0BBNiB/D6IOaVC0bg9Nrc8p7xZbOfTlWBSv7T8rQFA1?=
 =?us-ascii?Q?DB18Ij4gbfsXNMxaqKdcId/4C+Wl8zszT1/L1lpdSgwqHiuDe2N/gST0Fe8M?=
 =?us-ascii?Q?cbYl3XyWkiLojBwGf3EirQnayCXOPGz+2SwXG6fXX+wM4PK5BkN2AoVk1I01?=
 =?us-ascii?Q?YwyvIfV69b7AugbaxnjoIlj3jJ12YuzQeFiA2jdJ4YmuJaxYj4CYyXNQwyi2?=
 =?us-ascii?Q?7wjk+cZ+5LbUdp0WTudSSLsOcyt0Qll61jq8kyCB8chFHlwaW3pzajOzW0DR?=
 =?us-ascii?Q?tJvPYuysXiMhWCYhbZ+jw1cxV6FjA90qarwchw1QtYkgRIeZbTcqSBQN6CXU?=
 =?us-ascii?Q?TIb6UhnEHjD8KDGL3uBJXsUZ0jN2i8E9bStRFFr5ELFnzApiCDawTvkPPT4q?=
 =?us-ascii?Q?JkstChFAA4xJWI6wcO6AJ8zN0NWdZv2j3gz2vkHjhVz5bgPz2IFldZZdbRU7?=
 =?us-ascii?Q?m18Hapu0ceQZzH46PMLb6WO8lArxySfCf+lMB6hqGGi7qZDS4xg8gtnNDMqF?=
 =?us-ascii?Q?u6TIAbDoflH6Q25Za+LayWqfpZ7cftDPTV9zsnlgsdXiLdHZZ+zIbeX7/sTQ?=
 =?us-ascii?Q?uaHNWJv8PUK7caKZCD+Uxuet3o7UDlegHqj+H03TjjIc5J5qveYU5hU19S0G?=
 =?us-ascii?Q?uDIaWrT/uQoaGhdrjEYtMb7arr+Gep9YCVervrgF5R2KbtWMq2lj6XKwStJi?=
 =?us-ascii?Q?qJYZwtmXy/XXz2kmDXdP5jTA+o6iObv7j8e9SxmLMFwl9RKdRJQ2NXcH9Rg1?=
 =?us-ascii?Q?w9NBQ/UBz5wwSjunK+gIOH2hArPuzPw8IqT1/9MnPAetCZjAXEjcncr9NCz3?=
 =?us-ascii?Q?/scQV6fdAs35dHZ2Z7BizNXrggfncBlF/jA++pT+nOmAJa8oRG9y2AoR4wtq?=
 =?us-ascii?Q?J2f0WeP6eXlhXMefaszoMbhyS3dWlPh2Z789kMy03Mnomuxnh7ReLGNBfGFC?=
 =?us-ascii?Q?kfGE1DX84JgEfhEuLGGiadPQBE10Sj0vCoO4tppTlLs5vkJjXRLQSZu7pxiY?=
 =?us-ascii?Q?d/4iWHaT11OTjABfWnbc9+fTkJxhjUXMlT/40tHATiufe5yVhfX8ZV4ANm28?=
 =?us-ascii?Q?XkjqLxbCzunEXlWUQI/6gVbMz+d0rI2DNK69c+qtIRn7awaOwuI5LX0qdDUW?=
 =?us-ascii?Q?ScEU5xdPs8hGLdi5xBcStKqSwMe8ZMW8fFkUZVL7Eu/L2JEveTc8ylSJrCLI?=
 =?us-ascii?Q?3QP/ZrBeNy1orHcZqtPUKAJcz4DPPve98/AQgiP575mSQlEBQWyzo6B9LwfS?=
 =?us-ascii?Q?/m2ITjt0v4s4g+xYdRZrEh1ErGFZYqfxJ7uF3iPk3RzKS83W/88JpzyCs/gE?=
 =?us-ascii?Q?+Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59e2fc16-dd60-4576-d856-08dd617e4f00
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 15:55:27.7016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Y7qEV4yfLc5cGB+D/iAnJ17MYOcPUu+uXWC2EkCeUqFF9O0HvF+gHOe6Bmx6y4rPsHUIeL3HFGzKHyQIDVrlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10008

On Sun, Mar 09, 2025 at 06:46:47AM -0400, Faizal Rahim wrote:
> Implement "ethtool --show-mm" callback for IGC.
> 
> Tested with command:
> $ ethtool --show-mm enp1s0.
>   MAC Merge layer state for enp1s0:
>   pMAC enabled: on
>   TX enabled: on
>   TX active: on
>   TX minimum fragment size: 64
>   RX minimum fragment size: 60
>   Verify enabled: on
>   Verify time: 128
>   Max verify time: 128
>   Verification status: SUCCEEDED
> 
> Verified that the fields value are retrieved correctly.
> 
> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

