Return-Path: <bpf+bounces-68155-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6DBB538B6
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 18:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A2FF3B0518
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 16:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE112352FDC;
	Thu, 11 Sep 2025 16:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jWZC9S1s";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ab9t5uQD"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D151634F46A;
	Thu, 11 Sep 2025 16:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757606713; cv=fail; b=M3kmqrLTichWKJuQ+u+Sf52CjKpBpCTO4dvRDYbebulH90bOTWe9gzvg7NNp0rkE/mF3rKciVrjVSEZ1pi7ApJkvv/ZkfkIKY+wamCwFkqC4MvImE6GwjVXYFXOYHkWPKg7FcqA/TKDimqCIhqEgYXzIYWNnJr55iUTO6UZbmyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757606713; c=relaxed/simple;
	bh=CXwEsh8BSZV9L/OIR6PsT32JR5jTTERBxjco2j6fJ/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IkQQhcLIO4x2UMcLQsVxeIFY0FzqjL4KKj2FKrHVY+OV2Q4xp28fE9ayA/IK+wLH0JkFJekusZPQ7byXJkxc9b5NwkHOUQGz3n36AB4gXajhNw9r4uVFrTPaLqQPrB5rHMaPyOQHpCGuveYik9eWj11rTdsBa5HryOAVjCNFabo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jWZC9S1s; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ab9t5uQD; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BFtwJC030982;
	Thu, 11 Sep 2025 16:04:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=lXYU0aa+KfVwk20XnB
	12cpHT/UHymbqJEw3fRd2Uerk=; b=jWZC9S1sV4Z1Ooqxx12l3kPlqdLWEW+AQU
	WzU3S1rLJNs+CZJorkawfDXQOWYRpJoHK50CtpC/AxCwll/wy9dpOCkmh6pQYgm+
	AeL3OL+MDLOGR1HcLrUgs6GvTuqNijMX82XceC9TQJKg54uwrioRI1MILNedXJN0
	yfkL9sBUnc9hMWGA7R14Tf5+D4BUqTSQJaHHkvBjP9cVbv7F+Atw4jG6H1SysDVe
	0rWsPBeI0B/eZlRABxle2WUshx3Pi6A2EJcvkKAFosh08wd5uMG+vBHf93U5lnhe
	AybUTjc1DUdX1dJi3IbN1kDhlRVSmcjDyFGoRBYcmFzlWguLXpEw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922966mf4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 16:04:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58BFvmDq038950;
	Thu, 11 Sep 2025 16:04:22 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011063.outbound.protection.outlook.com [52.101.62.63])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bdcn9bd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 16:04:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SS3VJByGcLK1kREtQriPCDblFYS1qhb1x8RiBqofdP99dQJENNdTep4TSpAQt8kyk6TZPyp12pzc/k46drxOfC8MdDL4qyQu/RFuXrRNDPKxhfCXbwSLqm51EwPcPpvu2gHUVd4y8fASxSRFc3CL/LbsKrbnJ10Jmv+f4S1fRlB4fhxZxJhOYh8yHtFYp/K6Gb5up7xcG0GISUeFpRQ/Uami0H6y5F0TPJAttev0YUk4unGmLfhmH0s2DRIoTTTe6KAtFiCbQxRDySLYvzjHaZHSR6wchCNsqWapUYWx4bm6/N9xSCj5dunkMFVksSflA4VeNr68BgsMZXEV3ogNJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lXYU0aa+KfVwk20XnB12cpHT/UHymbqJEw3fRd2Uerk=;
 b=n+vgsQMoAVkhjZRvqwyFM+PNK3MRz9fdNd4Ks0RQq+0OYL4lgbU1OdPiEIDExrTRiWzSKC1fZ/IBLkn6NVPmM2kjsXua8EE5SDToGTpHf3uS7PVQuc1SAhdrx+ktawDcVTZsxClHRlf9NbxyCqF1wwOpvKhC/yzkag+Hstv+Khx+/lwrgq2ivar/5WLvefOei37K0NvKr58UJhICNERQ/0K9TORMyQBCvFvgleti8uEdCMUKiy93prbVOoUSgdM+OH92FjfA/5BBL9zCyV+NDy1Od5KNIsdGFc96n+wN/5aJqiVWhm+k37+/EvdWUQFtY2GIBrIohHx1xTRGrPnfRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lXYU0aa+KfVwk20XnB12cpHT/UHymbqJEw3fRd2Uerk=;
 b=ab9t5uQDlplWSL/2HnVRCDuBuP1f1l6FRhymhQYW1vK1FFj4tGU7mPotrrAJWQh0LKdXNVmny7CHCcPGIc7YyJlNXp6ULYnrBGj7Y2pw4H5prfD+e9nwps53OaOx+AhLmSrhmW8MhwbRbEWRYOVdaWP348oq/vMQIvB6ap5y6xY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH2PR10MB4342.namprd10.prod.outlook.com (2603:10b6:610:a4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 16:04:19 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 16:04:19 +0000
Date: Thu, 11 Sep 2025 17:04:16 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com,
        baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        hannes@cmpxchg.org, usamaarif642@gmail.com,
        gutierrez.asier@huawei-partners.com, willy@infradead.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        ameryhung@gmail.com, rientjes@google.com, corbet@lwn.net,
        21cnbao@gmail.com, shakeel.butt@linux.dev, bpf@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 mm-new 05/10] bpf: mark mm->owner as __safe_rcu_or_null
Message-ID: <4533a41b-8e13-4441-b1be-b359282788c7@lucifer.local>
References: <20250910024447.64788-1-laoar.shao@gmail.com>
 <20250910024447.64788-6-laoar.shao@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910024447.64788-6-laoar.shao@gmail.com>
X-ClientProxiedBy: LO4P265CA0084.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH2PR10MB4342:EE_
X-MS-Office365-Filtering-Correlation-Id: 9afb0cb9-0ff9-423a-d6a1-08ddf14cdd9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Atx3Lrc7R/wNGRvbdctGN/UtYIz4FRXT3k02IbmTa6/pMbGz5tOFyIg7H09U?=
 =?us-ascii?Q?B9q1/Mh7Pa1cJywPDVatNpX8dJb0wa9mDszXEa5SNqHOBLZaBdTTW9f88BCo?=
 =?us-ascii?Q?uSQG3IGvwzbmh9iFgrQP9zM9Sa996V7ixqEGFjA+On5sRrF0jQj2JOKtMCis?=
 =?us-ascii?Q?6U1/H4Zs4gp5sXs38V2W2gj2q3Q9Hw/sliH/QaLY5LFVOVsQpwYcqo++HBnM?=
 =?us-ascii?Q?4wYhq1CBjN0+s99yL/L9cVZffmqKdKwRjIKpUyGprydM8BLzGdBwApEfFA2T?=
 =?us-ascii?Q?bxc1CCdaWeSkp9iYs1+W9LEYLkeaPkzWfQuMjq8uSs/HrZeUVCvjm/qKONcg?=
 =?us-ascii?Q?dWPXEOohzDTyTXYRWJbpyz5x3bjRnmtb1RFUG1NKJkXaMqwCPGpohk6SN+47?=
 =?us-ascii?Q?5i+kFfgW8UFU3+c/bhUHXble2BeWQZSsFPMztX+pY3UTE6xHqQn7glUBeiwS?=
 =?us-ascii?Q?zLCKWaX43oR4/9qKdAUe6Z0GKGpfLtGwFHL4AKtwTcmmsAntAue+3zT+YLmu?=
 =?us-ascii?Q?GaLEpUr6XAMGswvaY1AaDkvSkpc0RjT5YeFi3W7himla2FMl0BDb1Xsmvz9d?=
 =?us-ascii?Q?AOtC63ddCwODeIjEXkhxFyAWzzUjV/nHvbP3TT9f3RnW/SmhSqnlG/Zza8p5?=
 =?us-ascii?Q?Gyu0E7+JtyXigrMFFmZxp3OcXEYBVwAFYiAOWq4zAwJJgAKQW+XQUaEdp+ER?=
 =?us-ascii?Q?1gKDiu6HNjO8JSHv3Jxy2Tzd2kmSQiALo8iYVXqN0GgGCCgw4f/4Me0no7ph?=
 =?us-ascii?Q?OblBLQKld5YdPCdZR5SgpXBXQsJuJd4us9ZFhTeXD9Wep/40mMLgBaoqKuWj?=
 =?us-ascii?Q?VBoltF5nOEHjsGQdRfbQQ1FHeHVsKqfbl3qedCgmlWcBI49B6qVeU6CUT5r2?=
 =?us-ascii?Q?sx6lbxeNp+XyxJda6sDuM8av/aaixZrc1bJRaPl5J/QkwUVR+rJvYBbtbzl4?=
 =?us-ascii?Q?/1k7qyS5dskRyXkHj1ljle+D94yBIC3AUYUkkmnCOWCNZxm3TWQxxsz0BJi8?=
 =?us-ascii?Q?qyprrMyMbwNrKaItpq0qk7Jb7Gqs+C8e5JfUeIrbhqtcy+SocGRvodtl+KAr?=
 =?us-ascii?Q?HD5/GgBYwoMD9PdK5wp5nPGDpOQMMGNafaZ2ppFEzjPoZSVUgTewcivAeL9I?=
 =?us-ascii?Q?KP7LhfySneHsHobNR8ebXfkfBDMkTGBSoTLCp79A6RFI1qOUeYdDEVmL8P0V?=
 =?us-ascii?Q?BthLjpLUDHi2W0vgwiueSIlZNveWkbKqpy+JvzIhT9RULnkLDdZpV9YplzsF?=
 =?us-ascii?Q?IIJBam3JN39qjIkusZEE6HEZle01HCn/bI9RO0x2q/Sn6dnV7bP1k8i9wuRe?=
 =?us-ascii?Q?qV4OR+duvw9ryCuuwidx+McMtJbBBGku4G4eD94Ti1myVM5ehH8RnL/C2Mkd?=
 =?us-ascii?Q?r27ciqJ8LRprioYU705cwRRnXh2Vky0jc4QEGHWnLkzB40pjukbGhp97NLl2?=
 =?us-ascii?Q?nOFuqhGzp8Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l0Z52Y/nHpHM0maZp6yi1XPiam6iz8KIR+tV9V4CNWg+61cswoiGaemjpQO+?=
 =?us-ascii?Q?nJDooEazOwDDKi2NRbxz74WvO8T2fxasR2W1E9CUoWok6xiTjT0KfkO1v3W/?=
 =?us-ascii?Q?t3BDsEEg51opZo/qQbtB8XYt6CqrdfnVPbHpTFlo6vr5xkA+CtCZM5V0xiUi?=
 =?us-ascii?Q?+JxavQqGgP3LxOsyOnmjs6Kx6WqrE9DGRUHtdcqrBZzCFSQLgLmfxdRvPkcc?=
 =?us-ascii?Q?oVlZ3zMBsYNBQ+/tO/jaQYqU5GLWDb3m5XlQkwJxjiB58MUgftIqcjIbZ8Cj?=
 =?us-ascii?Q?hTHoSaBKmHgrUtdlnrL5O9WvDkGlKTAL8AZ8gZa55ZTi8lzUcTujXurteTtm?=
 =?us-ascii?Q?bUUeo0LVAVmrSvNvYuwJKt00dKZh6I0EW+GaaVArGU1/TQMRy1dQ3tUBoKvS?=
 =?us-ascii?Q?2Au3r1Iy8wI5d3CagJryT6gSWA7dmbdc2Md1Xb2p3BS7RfQ5og+K8rJD/HEG?=
 =?us-ascii?Q?GFWIlKZssPZzo6HMQZD1RV5pgrRVsib7/9unxZunGi5JrQzfFbWN1xDAaTwS?=
 =?us-ascii?Q?EtpBBpPmPLSfOjWJiP5wW/WVpRcqW2gvpEM1Wfc6f2b/rwjSDlO21jMXqurh?=
 =?us-ascii?Q?tVoJKzpekfcsUVy2Ng9cWb/jFBm4NcNqvJ87I2j5CsvnKBlyfy3sTg3XvP13?=
 =?us-ascii?Q?9jsiW0ArtOSXllx6+H5am452QL/uI3KEjmADwMz7eBlUt8RWKo4gGLR7UUyZ?=
 =?us-ascii?Q?qZyB7uQzk/u3txZZd6DKUKWcWVpyIqVrxV0SE4+Jj/y5cnYblYRZgkQ9uA8u?=
 =?us-ascii?Q?o8IzzHHB2VFYzTMqdB0Q7gxwYmXTzsFIwSd3acf7Fte1+g1g+bf/gpKr1xsS?=
 =?us-ascii?Q?Fsj22KgpBLUgZXWNdEVG/LGUNGCsXybY2txXvyFkQV2exX4cVmwRlsSEbUVe?=
 =?us-ascii?Q?IHfIWTELD3DM+HQ9FhixwEcGaXs4E0Vx7M6PhrZyf0cFyeU1iPfbAbdY6+sr?=
 =?us-ascii?Q?8M/1+dN5ztrgKKabO7OfBAhC6EJXcHkHKcWojIGcESTwJW+QjqfA3JlNkn85?=
 =?us-ascii?Q?dN3ppaErAwH9JZoPzdbFhKB34MJWvCGNY666Iyvm/JEU6DWjGAfXbm/QI4F2?=
 =?us-ascii?Q?r0yHOY9HkN8+q6gmNX4Df3Yx3mECN56/JquTqtEnih8Lfe/WY+VwIkzM1srM?=
 =?us-ascii?Q?Fc9T1aqxHJuiSx6QiHRPfcI+yXODoAnd/lcqNDOhKimdWoGZd7t12BRVWhyA?=
 =?us-ascii?Q?Lrw2w+2Wh/aHirFpJ0RNjk8eSICuJHGk56Y7Rbd461anIcdvd28monHl2D+s?=
 =?us-ascii?Q?ZEhuKG6iK2vEEuRHM49I1zOGWpzwXEsMjqXt0DIn8fxVJcwn4KjoHiZeNHn/?=
 =?us-ascii?Q?Hr9GF1ovGMd2VkL1MbM4WjinX6flhaKu4VJBsmJXZzF1or4jGYwdDh+thrHV?=
 =?us-ascii?Q?lmiIoDNAUGAPIkdFZNsRRgoFCrzoBaNfENrtyqsZJd9l/qPxZzynYJKn+6e1?=
 =?us-ascii?Q?9G8L9dJKWzwFU8OX9Ag3x23oDZiJY6MdHa3888j6bM1LxuCID8eUn58uhjJW?=
 =?us-ascii?Q?K4Vcj/C/ZCL3BX6Z940CQRK0zT+S+MYm2PpcpIEhC/u1IUO1L2szUIw8Rnn9?=
 =?us-ascii?Q?rv+bCfpMKIcb2hoZu5e/yXGHw+tAj8M24jzXs00iWXbrBMXpNV8ll9C0ddHh?=
 =?us-ascii?Q?8w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mGGYpLqPtBkXdTdz9IkSIoxswcTEe5aTswy7v4zR2v82xAvDVirWBokqbYFkQYI6iwFo9A+qlbRzvLEoSry7GiGcXDFm/ON8ZwVKOmYy14TmvFTvSQkH78FC3/G7zaGHgtwoNIJrMbbzCvofFIF4d/oQ83e84hCHLkCUsutWhn/fdIy1IcuVs2utKKbpWLFI1+vbHxYtBxiT5ZhWka1yRRL94VU48COUpQaZYmt4kT+NN05DY0Tl78TzrS0ngebZmg1tBDM+I3FgIVoEaWJ76pIuhpyPRwZQO5eYc+RM1Q6/VVCzUdfC5jfQYYH7gA3HInlTno8e0F3fDMFJChUYRzQYftTfgLrki33XLZRLALmYGk9/kPIAXSDUjNERC4O+vH2I83J1nLRXDFvVKxViXEQxlorb0Ag2crA3I0W33DcJHL3WBFrPZM04qN+oEguXqULnhBuLIkga1cGDaH8JqMltMwQhWKhoHqWroel8pPwqV2qSNTXWvQCZdewPXeuxe+cofdvd6GIcCW0nZcDja40D7A3an/NfWxXKo0f2P4uRJsi4niJocSYdv5/dLAVy7rDHPGUXWSC9xqVbjTtfqPmL6B47Iu9bdWjr+F/StbA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9afb0cb9-0ff9-423a-d6a1-08ddf14cdd9f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 16:04:19.5596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E2KyiYpxde2Yj72drdd+L8xY9wUzrkuYFjpVhtDZiJZ/PB4bxnMH1WBeyE1QrVp5qHwLN0Uw/CMPIo72z7m0FEElZlyJN+o4IckUtE9u140=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4342
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_02,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509110143
X-Proofpoint-GUID: oy7jbwYWbhkxgAZzbKFUMkBviOgdbjzG
X-Authority-Analysis: v=2.4 cv=CPEqXQrD c=1 sm=1 tr=0 ts=68c2f307 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=pGLkceISAAAA:8 a=F2brVLm_J3i40XxYJ58A:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:12083
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1OSBTYWx0ZWRfX3Q2DyavfGQX5
 x0Z9bQiMSr1CoWSYWMVrktZfgJqgU0aa2uuvBrHmUjAB4I0RGuCFFArjGibnrspvcqONouIDb1j
 biq11GWddgNMk4U6RHQxv2yR9RTC51HoaAxeSqfU7inqWQ2tS9V6uUJ70okxssx0dNpGnkKN7my
 pivre7Aq9hdaGI5xSJqzcQSlJo7hCQCeIUWYp75qfG0S54w/eZB7UVeYClxrxGlqfxZ0Dm3CgXe
 SqWNoD9X7DlYyvFjDUxf8oTlm3RKKks61oXTqkmDtVMFcDz3wQ8LdZrK4XTH1z4TrrWTmN0EUXs
 Fksa+Kh1QDTtIn8R8LQfCFIBYhF8olYBpn05LsPvoP/tEUJygPOBHQBTyURsHPb5BZxIAJxrjpm
 kzNteDZ6Yv3VH1oCSr2NqYXVO8Zw9g==
X-Proofpoint-ORIG-GUID: oy7jbwYWbhkxgAZzbKFUMkBviOgdbjzG

On Wed, Sep 10, 2025 at 10:44:42AM +0800, Yafang Shao wrote:
> When CONFIG_MEMCG is enabled, we can access mm->owner under RCU. The
> owner can be NULL. With this change, BPF helpers can safely access
> mm->owner to retrieve the associated task from the mm. We can then make
> policy decision based on the task attribute.
>
> The typical use case is as follows,
>
>   bpf_rcu_read_lock(); // rcu lock must be held for rcu trusted field
>   @owner = @mm->owner; // mm_struct::owner is rcu trusted or null
>   if (!@owner)
>       goto out;
>
>   /* Do something based on the task attribute */
>
> out:
>   bpf_rcu_read_unlock();
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>

This is one for the BPF people, but this seems reasonable afaict so:

Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  kernel/bpf/verifier.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c4f69a9e9af6..d400e18ee31e 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -7123,6 +7123,9 @@ BTF_TYPE_SAFE_RCU(struct cgroup_subsys_state) {
>  /* RCU trusted: these fields are trusted in RCU CS and can be NULL */
>  BTF_TYPE_SAFE_RCU_OR_NULL(struct mm_struct) {
>  	struct file __rcu *exe_file;
> +#ifdef CONFIG_MEMCG
> +	struct task_struct __rcu *owner;
> +#endif
>  };
>
>  /* skb->sk, req->sk are not RCU protected, but we mark them as such
> --
> 2.47.3
>

