Return-Path: <bpf+bounces-26166-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E82589BE91
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 14:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18A071F23524
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 12:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177306BB2F;
	Mon,  8 Apr 2024 12:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PcICNonX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="evV9tN7J"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817ED6A029;
	Mon,  8 Apr 2024 12:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712577677; cv=fail; b=g0UZpYVwtYXdtpdycrKzIY42ICD1D54A4EWenfpYhHc9o8Nl04Dzyq3kq215K/zkn/D/KFJFb4rStUKLkHGX2bXaKMS6DGdZ67VR/RD+z5LfTqrJkaDnQl23m09rWBDErnJesHjnN+wa78TziGeYiz2/r2kViV5i9Yd6q8Vr7xs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712577677; c=relaxed/simple;
	bh=Bvbp3eBi3vtDMVhQOAJkJWO8taxX577qIhz4zXrKuPw=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I1WQzppPeZWfIbi7o330JVXbs+X++wA6qdjgnAVOxud7Zf/P4W+lRmCC6pG9WMTeyZwIgPrI13ec3HB23jnomHpFwHDxzzkbjhVirIyaSMuv0D+eEWYvZ2IeA10FoNOqw3/gegSQ3gElKJOS631tFMEbotj+Ow9fqdRmSdjCj1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PcICNonX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=evV9tN7J; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4386Zt0P020446;
	Mon, 8 Apr 2024 12:01:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=WOkYlaNWtmLTiCSUfS5f+MJuOWuipgTU1bVI7xsrhek=;
 b=PcICNonXaQ3/ypNzKJ9MjbOtJG0n36Fh6fGNBQEMwlFae3BjmWgDnZZteOORnMFJw72b
 l5BvbHerZZjt3AgK6EJiK+UdvPrRz1uqzYabgSopzrS3pe54na11WO4qtGlQ5HtgTIqt
 mHZUwLppaT7oUT/gIeEwP5e0FmyzYKDGlNWK/WZkFFy7sUlgw4ESbLeDc4QmbQX4Ep7s
 1nqNcYiLZSc95YjUANZnOjgU06CLL1EwfoNQP3xZ/6vLSwvUlMgQJgDdo/fUevm2Lc9A
 qovy/6XleNvHp8/NpaiiVpEca9+hVskj10NuDppPaSDdltjnS2JBWCD1pqgQ8kelPfnN 9Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xax9b2e26-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Apr 2024 12:01:06 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 438AxGBD007902;
	Mon, 8 Apr 2024 12:01:05 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xavu5bgg6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Apr 2024 12:01:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hgQdmEBhzdS0dIKuGC8J8QfW6Jy+yOHQmd+BoNYS4xlnCzGIWnP6w56yk2+wFhxtNBpMKcNaGzIxUhCG1BRNEKz03Z5FdQqxsVnmIJ8GJryTSys6vD01GTemJGUXzxtjzOvmE421vtFdrlZOzcgqb78Hbl9Ms9bsrKdaB81j5R23Qx28cSvho+U208up+p4ipGcyV+/A+0KLDdcAhLOgBNAPrQxdU8dt15ZrnC2911wXa8pCVjVS8hN5bTDGoG4920tVrr4Tf4LTD+rY/wJgBlYX5aj1fbg2RtmDnGWO+yC/ImLoPo0gMlcPynJJqf4sk5nUY8Wj5Ia1PD2kf9Xr/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WOkYlaNWtmLTiCSUfS5f+MJuOWuipgTU1bVI7xsrhek=;
 b=QGl/4GROUTXpayni+z6U+s0xTFr2/5Sgo3PfYKiIYQNx8xo7T+PC3NqvF5EuxK7IMB5ltgJ+0sDkVprNv5Fa0xdl/HLa5kTPniAFW4KzaShttyaNca2fDVoqoRoQbkIP2uCnlgOWnpFAYd0WOh9p/NgN8/AC3RWjErgnzhNczGX1nVdgTa5O9u1Ij9pTQ5rDPXJre4KjO9XpbfHOcwra6TXCDjPf5dC53eGW6fo368S/Jk8qGvx1/8nUh18sMpZJa2ErAznsvLdZD/99ArXnRcVPJ4CAYZxNa7cdApu9cjeltSGpaTvPc1yWhJFp9cc4RO45EeAJ9tgc6doWmis1Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOkYlaNWtmLTiCSUfS5f+MJuOWuipgTU1bVI7xsrhek=;
 b=evV9tN7JtED+AdnqZu5RgUT5ZgyqcC0ZuriVtPCdyNOEOx9q5UoXHmiY6MFc7YXizTyjNJPMCQPcDytpkGAcAsNcnm1VjDP/37MOa50jh6Ly1W9gjNo72WDHoLP2eD8drKnlAHbDLQC9+/fq0qd74geEYBA4ff2pn9KXt2PDkYk=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by PH7PR10MB5877.namprd10.prod.outlook.com (2603:10b6:510:126::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 12:01:03 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03%4]) with mapi id 15.20.7409.053; Mon, 8 Apr 2024
 12:01:03 +0000
Message-ID: <82928441-d185-4165-85ff-425350953e80@oracle.com>
Date: Mon, 8 Apr 2024 13:00:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/PATCHES 00/12] pahole: Reproducible parallel DWARF
 loading/serial BTF encoding
From: Alan Maguire <alan.maguire@oracle.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, dwarves@vger.kernel.org
Cc: Jiri Olsa <jolsa@kernel.org>, Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, bpf@vger.kernel.org,
        Kui-Feng Lee <kuifeng@fb.com>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <linux@weissschuh.net>
References: <20240402193945.17327-1-acme@kernel.org>
 <d9ebf954-bfac-4819-993b-bbf59c69285a@oracle.com>
Content-Language: en-GB
In-Reply-To: <d9ebf954-bfac-4819-993b-bbf59c69285a@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0012.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::24) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|PH7PR10MB5877:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	YjZclu6NyLdI8LXZAP6K8H1OtDlxkJ4D7zwrHGDKAovSo/5ed8sQ1UqCy4KKp0ry7EsnStkeTKbemPpww0t65HJRY/mNnyt8DlNP8cN+nXxujYNvvpNXmT8YwgU7p8uLtEGhWnzcIBXIiBgUAXcED2m5ej3RNrmSEvXum1/zUGInxuet45t6DtvNxalnIjo9CQcamzD6mAknzPvjHU7hm9fgXCnhrnR0CfISaej62q83P9i0ZD6LCAwyH1ixi202LwJG2kwM4laWI47GWjWO4h9MBcIlv1neHKjLap9eixsYDrlmZVnh1EL2ww1WHsAofbhOoMgQNciBeL0kk1T5rJD7s7hXiZcbOmj3kJPG7xtDXQiQjyqVxZh3zaBm+xfM5HRRDJe9NMra12rzquuL9i9RicbR5FRdHNp/D7Me45Ib+f6XJiqvWbnCFUYDZkx4h6xvYQp9CivflLbfu1xRl5u4zeqaGW8xa0Ge8/mXyYuCAjAejhvz5uvX71Cxfv2K46dcMJcED7gxcmbaV1cVdUqT33xblKSO6Y55RoVD78Fi8SVu95fRX32cycZmxnBaICZHheruH5xcTFhC2kiDvxOLQ8uznliqxZfioLZd6g1lNUjYliEfjG4KAbBRdEIn
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TVBXUlVaYTNhUWNRTWdVSitKZmo1bzRHd2FEVThNYkZRWVJXclo3RDRQUUJ2?=
 =?utf-8?B?azJDTXMrZktObllLaDEvdElxOWZwZ0s4U2NiQnJnd3BEWC9rVndUV0FJb09B?=
 =?utf-8?B?SjVUdS9PUTZQNm4rdVRFYW5TZEt6OHR4Z1BXenIzbDBqWVZ2WWlwOGs4Y0RJ?=
 =?utf-8?B?UDdONjg4VkNEMTFxRDQrNkp5VDdyQWNHRzFOdXhCVDNDcitIeFRiRGF5VUZo?=
 =?utf-8?B?dXAvUjA1U3RyckpXajU0dis3QUw5YmtuZlMvb280QWpGVzFhcnFqWWE0NGUw?=
 =?utf-8?B?TS9kYUZuUmRXNHVnekdZcGJ1dzljK0VEZVVHZTVwNi9DeVJ1dTZ3eFY1eHdi?=
 =?utf-8?B?R0lNOEY3TmkwQ3ViVC8zNXdiYm9BWHlabEpFYTR2bW81OUpWMmowRmlqd2dD?=
 =?utf-8?B?Y3VvZG1ZMXVaMkhwaEcvQU1NL0ZnWjdLZFdsVGNJd0x4YnNCdGxPbTJBUXVx?=
 =?utf-8?B?TUkrc1Zvak4ydTdDMDVsdHpEK2t2ZjNKRGNoV0o2LyswYmhaUHVHbjlsN2R6?=
 =?utf-8?B?bmtuZ1Zsam14M3RtOFoyVmNXeGIwTkdDekFrZy9mMDdSRFlLZUpMeDVOUVUr?=
 =?utf-8?B?UHBLdzFDOEExcUJObHJ1OWh6N3g0UzdmcFgwZG0vTG5jWk9WbDI3R0kwQnVJ?=
 =?utf-8?B?WGRXZEtTV2UwSlVNamdOM3J6M1pJQ2JVUmxOckdrYzFYRHhzQ2RlVUdnamRH?=
 =?utf-8?B?dmZ1TWVsVVptRjFtYTFTMnFPS2VWUGkwZmRMK2xUdHZJam4ydzlXY2hNZmRz?=
 =?utf-8?B?MGRWQVhkRVpYcUlzbmFEQXEwSU9XNC9TajVyNGxJRFQvTG5WYk81TkNSdzEr?=
 =?utf-8?B?cDY1UnJDTnZyT2E3QWVXV0ZWU3ZEUUdoUEhjWENIS3k5czRwb0Z6MnN0aE5C?=
 =?utf-8?B?ZSt5ZjU5YXJSZlU2cnZOWVhGRkttME8weVpzVjU5MFQvRVJLNUZ6RHNaUnll?=
 =?utf-8?B?QTZuOWNvMUxVSkVQQngwN2RETERSbzkraXhkdWFWUUc5UG80K1RzREpQclpI?=
 =?utf-8?B?S0xTVW9tclBENGYxdURjMGR0SEtNa21udWxUbU9OQlpLb0tOc0EyNjhFTHJR?=
 =?utf-8?B?Q3JtTUxWT3lNbUVBRUtWaW1jaGgvWDBFSGpTcVZ3ZGRhUVlhSWdIVk1HVjJR?=
 =?utf-8?B?TllqTmhheHBrVkV3SWhwUUViUzNyNms0STJxQkpHemVUN1V4MDVzc1ZjUTBW?=
 =?utf-8?B?QUZyR2NIY1VGdEMzOFZIVUp5MVVRbURZL1lyYVlLMUxaTFVzMUVMUkxxaHFN?=
 =?utf-8?B?ODJmQ216a0J1eHpzclJYZVROK0EvM25pc3ovdW0wL3AwVHpXRkJCeWZ1YW1X?=
 =?utf-8?B?amZkNThJWVpvZ1JLejFrSlFWTzUvZjBrZ2FUTmRiQXU0N2FNRjJHTmQxQ1dl?=
 =?utf-8?B?QVdLZEROU1IwK2Nyb2tyc2tPM1FGYnJ1bXZEUFFvWlR2Sk0vdE5CZ0N1VXZR?=
 =?utf-8?B?NDFkNHFxVDF6NUlMQXJpUXJqeGhpdUgwSkw4UzVtV3R0VVR0cWRETEdoM3oz?=
 =?utf-8?B?Q04xNXpwRkRNczNvVUEwZ2t4QWpva3lpTUZsMXpOWkRObDhvMWZUWm8yM1FI?=
 =?utf-8?B?azFhQWE4Vmt2d1R0N2g4STcvVGVydVZvTXZQQTBWZUN5Y1JKdnUvc1o1N1NM?=
 =?utf-8?B?eXJEclQ1TDNSYVRPOElDSjRnOVJrODcxdFdrMEdZRjIzV3JrWjRTZEhvU3lm?=
 =?utf-8?B?Z1dnM0JhY2xsMXcwek9BUGhUVXdGcEtNZ2tlMVhsd3BWa3BVOGNzMjk3QzVx?=
 =?utf-8?B?bXIrTmYzVjhpUTJyK1E5UmdMVzkreDBLZTZPaDVxZVZJVWdoQ0s0ay9yc3pF?=
 =?utf-8?B?VThERkltcnNIQlBCMjgzYVlaR1VPTEg2TENNMFRKbW9hRU9CeFZ1NkNzbnRJ?=
 =?utf-8?B?ZkdNRC94QlNwNlo0MEZBNVRPbCtoNlhlaHVLTVltbk9wU0lNbWlSR3ZGZEhh?=
 =?utf-8?B?RnZObHRYWmpxcVJSYkZDUk10cmI2Q3FRZFdZUW10cDkrUVU0U2h0SVV2VlZV?=
 =?utf-8?B?dHcwTFU4OTdscHNCZ2NQOVgxcy9hV1FSMm9iVVRNSHROTjhETGZ3RnpGKzZu?=
 =?utf-8?B?bEo0dVNxcjhUWm4xTHZSU2pNalE1RE1kS1h5a2szOHBuNU1Ibk5iWWo1ZFJn?=
 =?utf-8?B?U1YwOEVBQ2JlQmdxbkYyc0VtenNJSndQREJNRU55R25TeDBkVnQ2T3RnczV6?=
 =?utf-8?Q?BHOKG4AKlstzXrJDMPnK0XQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	R68wYUqNCO2D6BnNNd0T0CvoZL4WHupRl5WR30/Fq0OskU07Vo+QWd3a9WasRVrqUFKuzyak76806QxDz3+psiXgZJmZ6K9WOPHbjDx7CC26NmO0EaibIFx2r5kKtKQWu1JUkUEvl8b6BSmFzR/rVAJ4LNGDLVaHdmvEEH4rOBanJ7/KQhHy5T6rZyC/xHsk0h0f+LaFEU0yp+X/L6NTa7Zo8aLSW8HYGuJsAb4NgIl2J3W58yFFsNZzPSIjfuppCtWUUbnCwL+N47+o0qKLFWg8e300Vh4GFRHRxzHbdF12P6mchP4xxUBWfq2gZEmUaUxgEIdz61SoPUZLkmHMfN2RmeIFJV9n9SE0vbtQh+Y7EiPi/iRipdnOaffgwczfF8lI/msoaeK481hi/f1hIatq7nQ338SxSZIjQ5Hwc4lETL8F5PQk2neOkfSnAFT8rLYP3QPZ4nVgZxJb2aqSEet482y7DynbxXyh2hI2CMNnt28+/IBHuIRza3/T/wxw7/qi61cRZAd86HLmskJo/s+OAMIN1WdtfNDx1dlNLDN8P/9MSlE1MWUcJQ4UCsmMxSwLLFlbAGxYkWAs6MfEnnIgj1lLnQH/QzO+kgd3DLA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c1e0560-ee53-4015-8790-08dc57c3904c
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 12:01:03.2154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pi8TuXFF2dHeyFoyu6YltsZETg5q7VvgAsMAcv/7xgk3hLiaJ6xmFqN3koVJIRN2rlRJ2fYz10waopDi1ew8Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5877
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_10,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404080092
X-Proofpoint-GUID: -AeF_ccYiwZaM3Z0FThO-bhj7QyJpNaK
X-Proofpoint-ORIG-GUID: -AeF_ccYiwZaM3Z0FThO-bhj7QyJpNaK

On 04/04/2024 09:58, Alan Maguire wrote:
> On 02/04/2024 20:39, Arnaldo Carvalho de Melo wrote:
>> Hi,
>>
>> 	This allows us to have reproducible builds while keeping the
>> DWARF loading phase in parallel, achieving a noticeable speedup as
>> showed in the commit log messages:
>>
>> On a:
>>
>>   model name    : Intel(R) Core(TM) i7-14700K
>>
>>   8 performance cores (16 threads), 12 efficiency cores.
>>
>> Serial encoding:
>>
>>   $ perf stat -e cycles -r5 pahole --btf_encode_detached=vmlinux.btf.serial vmlinux
>>              5.18276 +- 0.00952 seconds time elapsed  ( +-  0.18% )
>>
>> Parallel, but non-reproducible:
>>
>>   $ perf stat -e cycles -r5 pahole -j --btf_encode_detached=vmlinux.btf.parallel vmlinux
>>               1.8529 +- 0.0159 seconds time elapsed  ( +-  0.86% )
>>
>> reproducible build done using parallel DWARF loading + CUs-ordered-as-in-vmlinux serial BTF encoding:
>>
>>   $ perf stat -e cycles -r5 pahole -j --reproducible_build --btf_encode_detached=vmlinux.btf.parallel.reproducible_build vmlinux
>>               2.3632 +- 0.0164 seconds time elapsed  ( +-  0.69% )
>>
>> Please take a look, its in the 'next' branch at:
>>
>>   https://git.kernel.org/pub/scm/devel/pahole/pahole.git
>>   https://git.kernel.org/pub/scm/devel/pahole/pahole.git/log/?h=next
>>
>> There is a new tool to do regression testing on this feature:
>>
>>   https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?h=next&id=c751214c19bf8591bf8e4abdc677cbadee08f630
>>   
>> And here a more detailed set of tests using it:
>>
>>   https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?h=next&id=4451467ca16a6e31834f6f98661c63587ce556f7
>>
>> Working on libbpf to allow for parallel reproducible BTF encoding is the
>> next step.
>>
>> Thanks a lot,
>>
> 
> Hey Arnaldo
> 
> In testing this series I've hit a segmentation fault:
> 
> Using host libthread_db library "/usr/lib64/libthread_db.so.1".
> Core was generated by `pahole -J --btf_features=all --reproducible_build
> -j vmlinux'.
> Program terminated with signal SIGSEGV, Segmentation fault.
> #0  0x00007f8c8260a58c in ptr_table__entry (pt=0x7f8c60001e70, id=77)
>     at /home/almagui/src/dwarves/dwarves.c:612
> 612		return id >= pt->nr_entries ? NULL : pt->entries[id];
> [Current thread is 1 (Thread 0x7f8c65400700 (LWP 624441))]
> (gdb) bt
> #0  0x00007f8c8260a58c in ptr_table__entry (pt=0x7f8c60001e70, id=77)
>     at /home/almagui/src/dwarves/dwarves.c:612
> #1  0x00007f8c8260ada2 in cu__type (cu=0x7f8c60001e40, id=77)
>     at /home/almagui/src/dwarves/dwarves.c:806
> #2  0x00007f8c8261342c in ftype__fprintf (ftype=0x7f8c60272f30,
>     cu=0x7f8c60001e40, name=0x0, inlined=0, is_pointer=0, type_spacing=0,
>     is_prototype=true, conf=0x7f8c653ff930, fp=0x7f8c3804bc90)
>     at /home/almagui/src/dwarves/dwarves_fprintf.c:1388
> #3  0x00007f8c8261289d in function__prototype_conf (func=0x7f8c60272f30,
>     cu=0x7f8c60001e40, conf=0x7f8c653ff930, bf=0x7f8c27225dad "", len=512)
>     at /home/almagui/src/dwarves/dwarves_fprintf.c:1183
> #4  0x00007f8c8261b52b in proto__get (func=0x7f8c60272f30,
>     proto=0x7f8c27225dad "", len=512)
>     at /home/almagui/src/dwarves/btf_encoder.c:811
> #5  0x00007f8c8261b665 in funcs__match (encoder=0x7f8c28023220,
>     func=0x7f8c27225d88, f2=0x7f8c5805c560)
>     at /home/almagui/src/dwarves/btf_encoder.c:839
> #6  0x00007f8c8261b7fc in btf_encoder__save_func (encoder=0x7f8c28023220,
>     fn=0x7f8c5805c560, func=0x7f8c27225d88)
>     at /home/almagui/src/dwarves/btf_encoder.c:871
> #7  0x00007f8c8261e361 in btf_encoder__encode_cu (encoder=0x7f8c28023220,
>     cu=0x7f8c58001e20, conf_load=0x412400 <conf_load>)
>     at /home/almagui/src/dwarves/btf_encoder.c:1888
> #8  0x000000000040a36c in pahole_stealer (cu=0x7f8c58001e20,
>     conf_load=0x412400 <conf_load>, thr_data=0x0)
>     at /home/almagui/src/dwarves/pahole.c:3342
> #9  0x00007f8c8262672c in cu__finalize (cu=0x7f8c38001e20, cus=0x21412a0,
>     conf=0x412400 <conf_load>, thr_data=0x0)
>     at /home/almagui/src/dwarves/dwarf_loader.c:3029
> #10 0x00007f8c82626765 in cus__finalize (cus=0x21412a0, cu=0x7f8c38001e20,
>     conf=0x412400 <conf_load>, thr_data=0x0)
>     at /home/almagui/src/dwarves/dwarf_loader.c:3036
> #11 0x00007f8c82626e9b in dwarf_cus__process_cu (dcus=0x7ffd71eaf0d0,
>     cu_die=0x7f8c653ffeb0, cu=0x7f8c38001e20, thr_data=0x0)
>     at /home/almagui/src/dwarves/dwarf_loader.c:3243
> #12 0x00007f8c826270d2 in dwarf_cus__process_cu_thread (arg=0x7ffd71eaef50)
>     at /home/almagui/src/dwarves/dwarf_loader.c:3313
> #13 0x00007f8c816081da in start_thread () from /usr/lib64/libpthread.so.0
> #14 0x00007f8c81239e73 in clone () from /usr/lib64/libc.so.6
> 
> So for conf_load->skip_encoding_btf_inconsistent_proto (enabled as part
> of "all" and enabled for vmlinux/module BTF), we use dwarves_fprintf()
> to write prototypes to check for inconsistent definitions.
> 
> Program terminated with signal SIGSEGV, Segmentation fault.
> #0  0x00007f8c8260a58c in ptr_table__entry (pt=0x7f8c60001e70, id=77)
>     at /home/almagui/src/dwarves/dwarves.c:612
> 612		return id >= pt->nr_entries ? NULL : pt->entries[id];
> [Current thread is 1 (Thread 0x7f8c65400700 (LWP 624441))]
> (gdb) print *(struct ptr_table *)0x7f8c60001e70
> $1 = {entries = 0x0, nr_entries = 2979, allocated_entries = 4096}
> (gdb)
> 
> So it looks like the ptr_table has 2979 entries but entries is NULL;
> could there be an issue where CU initialization is not yet complete
> for some threads (it also happens very early in processing)? Can you
> reproduce this failure at your end? Thanks!
>

the following (when applied on top of the series) resolves the
segmentation fault for me:

diff --git a/pahole.c b/pahole.c
index 6c7e738..5ff0eaf 100644
--- a/pahole.c
+++ b/pahole.c
@@ -3348,8 +3348,8 @@ static enum load_steal_kind pahole_stealer(struct
cu *cu,
                if (conf_load->reproducible_build) {
                        ret = LSK__KEEPIT; // we're not processing the
cu passed to this function, so keep it.
-                        // Equivalent to LSK__DELETE since we processed
this
-                       cus__remove(cus, cu);
-                       cu__delete(cu);
                }
 out_btf:
                if (!thr_data) // See comment about reproducibe_build above


In other words, the problem is we remove/delete CUs when finished with
them in each thread (when BTF is generated).  However because the
save/add_saved_funcs stashes CU references in the associated struct
function * (to allow prototype comparison for the same function in
different CUs), we end up with stale CU references and in this case the
freed/nulled ptr_table caused an issue. As far as I can see we need to
retain CUs until all BTF has been merged from threads.

With the fix in place, I'm seeing less then 100msec difference between
reproducible/non-reproducible vmlinux BTF generation; that's great!

Alan

> Alan
> 
>> - Arnaldo
>>
>> Arnaldo Carvalho de Melo (12):
>>   core: Allow asking for a reproducible build
>>   pahole: Disable BTF multithreaded encoded when doing reproducible builds
>>   dwarf_loader: Separate creating the cu/dcu pair from processing it
>>   dwarf_loader: Introduce dwarf_cus__process_cu()
>>   dwarf_loader: Create the cu/dcu pair in dwarf_cus__nextcu()
>>   dwarf_loader: Remove unused 'thr_data' arg from dwarf_cus__create_and_process_cu()
>>   core: Add unlocked cus__add() variant
>>   core: Add cus__remove(), counterpart of cus__add()
>>   dwarf_loader: Add the cu to the cus list early, remove on LSK_DELETE
>>   core/dwarf_loader: Add functions to set state of CU processing
>>   pahole: Encode BTF serially in a reproducible build
>>   tests: Add a BTF reproducible generation test
>>
>>  dwarf_loader.c              | 73 +++++++++++++++++++++++---------
>>  dwarves.c                   | 58 ++++++++++++++++++++++++-
>>  dwarves.h                   | 17 ++++++++
>>  pahole.c                    | 84 +++++++++++++++++++++++++++++++++++--
>>  tests/reproducible_build.sh | 56 +++++++++++++++++++++++++
>>  5 files changed, 264 insertions(+), 24 deletions(-)
>>  create mode 100755 tests/reproducible_build.sh
>>
> 

