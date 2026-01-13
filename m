Return-Path: <bpf+bounces-78668-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE06D16F2B
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 08:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 150F73036C5D
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 07:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED60369962;
	Tue, 13 Jan 2026 07:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hyhvPR/p";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dzy94Q0k"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8903330FC3E;
	Tue, 13 Jan 2026 07:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768288056; cv=fail; b=fzliEEY12BRLY5saYiaVZ7F3zq79nLp0BmhnX39wq1f5A5vq79eGR9cT50Szb7LDwZIwUMGPGtDVV9Ku2n0Imc50kwJIEI3AQC2Wo0AgIG1OInCEEwShOFvQfgtmCyitxxAgE5Ho5cWFv/WanhEDekUEN+yzgAH7GElNjGNzZhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768288056; c=relaxed/simple;
	bh=ZkVioZoQEblILDDD/IAPdEHAUWZ/vtd+aK4v0hDU384=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G7ZlWwVDSfT5b4LaPGbWCxquBqQpqCCBBBmD+w74KR+/sL+b6FZtPc64YLbQtVufOvMhM1fOsydBjFyuqpo5t9RobYqQVNzlcqWrEPsCRbztaX5YMGiPcSrshAqh+Kmzo6x+pU/dvX4LBfNnHfn3RsexrBYmMdtbBv+2S8N/7Q4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hyhvPR/p; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dzy94Q0k; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60D1gfYd2419467;
	Tue, 13 Jan 2026 07:06:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Vem8sAy1HUGf23xkRn
	Jma35B0ldz4fhz06+qpkqir4Y=; b=hyhvPR/p8anuJR7o74HIfZiUfAY8lyJXP7
	0h5gwja1hj3umeJPGMZnNzNlxfKyoPGW660QeFtV7u3R8zIZbY4rzfPgmmapcRb8
	x9L1e5XhT7IdUx5+46whVRo8habGsRQVcG37ok2fJp8NqI5qvzSm8kWCQ3ERzIfw
	kxB+1zKRumZsyjMbnHl6sqOI3BcMvT/yYUvs8axvoAXIZuPj1LlLPsNpu1hMkJmN
	rvSdqpoIaLAjY6VCZnrYXc6FTGHjd66xFd9xZHDHT9hmnBFq7EixEpgUkVX7TJ6j
	wlumk9QNanaNUzI87CGw4y+TvNASgT1v4b59/5Pdu7TzGQaOrfSQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkre3txss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 07:06:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60D5qXwD029363;
	Tue, 13 Jan 2026 07:06:53 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011006.outbound.protection.outlook.com [40.93.194.6])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7j56ah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 07:06:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eRS3lNlJKI48Tjht57OaFn/zDSCPHGHSLux5QtmNiXz12926r2ghX4LCrc2FhqmH8J2EBNihTmuyhq8W6KJAteILXWW7BtkCUfd+zVwHWEZMMCfFLLtHOZvjPqWJFn2LE4apNG7UyPNdH09SBpLlYo5b37PCE6mUEoJtcvQ/2FSA5PXbteTBwZ4SsxHMDvLJTYKj+OZ1vQAZ4KOMiEHM/vGqOgrf9ojgn+X0yypZFMvHcToS3Mq1llxUuzSVPgD9mQiYOU0V6BID29HQPftE5WPIDEC0djogh6dFSaJhAvJgCo6Wrt1NIOfTKtiCe2Yv2UIE17IdFlMjNhEcWMtoJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vem8sAy1HUGf23xkRnJma35B0ldz4fhz06+qpkqir4Y=;
 b=TW1Kbga/5OdiNgDP/tZPcBpHY10Nv0EiAuBMfptCZhG84EetAjmqFl48qUVVWxjEEJCkIBUMYpxEdzrQp/NLTRiaVM/CaYdZiD1pyEGhKD0XMug6AiI4UJ7cDX/yiaAl8XJkCovcry124gLfbhlnJC6A2eUMoDVrvirx1Zp1S+srkZRnrOqoUwfSDI3a3TghLs3F7DtjU5Jc58GZwZffXnAAEPHFUF8KjKDTMfCTaYEcyTqqb+ECzjkpfLDzclwdyWQi4f8X89CFcWmbfDrDo4GIVQfGNQ7JQmYWjyamSarKOOvIN5iu5PMl8ACYKKfw/Q8oxpRn7toFdKM1fAPkvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vem8sAy1HUGf23xkRnJma35B0ldz4fhz06+qpkqir4Y=;
 b=dzy94Q0khJOetoTE/+OV8aRwhzm3KrpuePrAxj6Z9zZX5VvQyVliQzxfY2RHPSGYihow8GyQvcscNpubCaw0LeY0mTbewyp/XLvlWFV7YS04NrizMGHt6b83+kiGDJApSOSAhh2q1mFkSGIkv/Cg/g0Ab494v0FRmiB8iIXBWBU=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by MN6PR10MB8190.namprd10.prod.outlook.com (2603:10b6:208:501::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 07:06:50 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 07:06:50 +0000
Date: Tue, 13 Jan 2026 16:06:40 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Petr Tesarik <ptesarik@suse.com>, Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        bpf@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH RFC v2 02/20] mm/slab: move and refactor
 __kmem_cache_alias()
Message-ID: <aWXvAGA_GqQEJpB4@hyeyoo>
References: <20260112-sheaves-for-all-v2-0-98225cfb50cf@suse.cz>
 <20260112-sheaves-for-all-v2-2-98225cfb50cf@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112-sheaves-for-all-v2-2-98225cfb50cf@suse.cz>
X-ClientProxiedBy: SEWP216CA0081.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bc::7) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|MN6PR10MB8190:EE_
X-MS-Office365-Filtering-Correlation-Id: afa86f52-3b4e-4d13-1a7a-08de527252da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dKJmIlv6eZpEnZ6712YVeWJNu34M37hQDiIX2CDwx/Sho+4bdKRvNFtqMqi8?=
 =?us-ascii?Q?jbtcH8z88/oL67ceBDTnB8G7Ofbag9TW5aO0RjpmjnFzTvkC5xiH4oVDRCgg?=
 =?us-ascii?Q?MF+P2ZbRSlYScWMtNr76gGkyCf93HoeFVaiTR0avNs4JY7i51a1UCpA4vQG/?=
 =?us-ascii?Q?UpPI35R/OXjgh6GKUvmiOo/sTuP4Ys57vj3gGOfYza5ky1cbIT99kSV8mcoT?=
 =?us-ascii?Q?SLK/qtLOwbYWKBm6Al/oBfPHfJApToUtkoLSn+c1YmK2BQbyo/Id4TjmYIzO?=
 =?us-ascii?Q?Z8v/HN2/6Rs9mo+KUMwDqAgClU9Q73ojNQ/PUfFgfWZe88hv21pxPWL4v249?=
 =?us-ascii?Q?PGYzoRPGftJp4AoNCLVGy8rbDQ2T8xLaxkJ17ssFZ9Kro7hxcG8m1sE2QAyF?=
 =?us-ascii?Q?Hol/s2EQdJfhoNmpsa+vd6fH5uJJZ3Pxwq6U2OKyOX4E0Invr/+8nEqv7zQf?=
 =?us-ascii?Q?8r8hJ1Agu3y+rwwhlfRDEAjsvgHwHctDyrUHKt418CQ4mt6UTZddirP3OsTN?=
 =?us-ascii?Q?9kUto1Y+bHb26roJWh/CnN4WW1chKAUlENRR5l8TU8f+stYY81UKH75pCcNK?=
 =?us-ascii?Q?x3Lf3nYXws6x3XM1L9rR/8MPU65rCFo96/n6Ip6FlsoWBy2Xbr/iAN8sOhXK?=
 =?us-ascii?Q?4UMhY6ucZeIG85JZRJ1bq7M8TQzl/spSCnqfO5ROAqSHe8tmlPcRqyyd9Z21?=
 =?us-ascii?Q?GrcjoJwqj6y/CYS5AZaIybD07ewMPx4RNUX0E9UtrHXNhHzD9H/jkstQ9j60?=
 =?us-ascii?Q?qpR3Jj26gPkN05BHG1j7IQZLOqFwjUPek2YZHU32Pzc75GUp4uTGMwDYDSmt?=
 =?us-ascii?Q?JvdzY/WRzv7FZ19dg2P0tu+gFRTrSwBQN7VjKKB2I38Lr3oY3k17/vWO+pbr?=
 =?us-ascii?Q?VKZb1TDk/JbfphBGKb0BnXON8JnnSW6rf2nbp+xRJZ4KakUTM+WetGQelUMM?=
 =?us-ascii?Q?Iu5I08t/hrcxpMtYVXIC9TeB1HbBExlHpKPBUIkaGeN9JSvAJyj/fOYIcsAl?=
 =?us-ascii?Q?uvOzrqNAYd4h2N+HIvpXEfiwel9+FqCdygdhIWvVIalxHxBBuNU055ghVYKV?=
 =?us-ascii?Q?tZgfGQcNAsB1mxDEP1Dfge26hkkhtenkrUySK5Ql0DLE8X+PrMostlOzkm/m?=
 =?us-ascii?Q?51W2kdVUIYDkjKNmndy/GMdbyQpF+zA9oTNKrnkYBFWFi0XhK+YGwGkYZGyn?=
 =?us-ascii?Q?iKgm0nA0sQtfu1RdS0l/9XwKWm31Kt3B8xQdic2ef9MX5Ma466k0y6ZXWYzz?=
 =?us-ascii?Q?DdNBHjXeNxccE9jcu2RZ34JsFXS6SYoLLTNDMRA50q+1UIesus4kBff+7iZi?=
 =?us-ascii?Q?k62YVjmuPt+RlQ+UI2X4Fpxfp6Q0wotJly6hoWapa5k7Rjqwvfv9W4Q8LCpL?=
 =?us-ascii?Q?odTs4L1pSFKcgB68QQOoHTIWRUgNriU/Eq8S2JlcpXGceUo6Z8Z8wRkFVZBJ?=
 =?us-ascii?Q?NxNofU/8BtWmp/8vujnMdfTGgj8vNQmh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BkkkVndHTYuOLP80Sb/V0vaIMku1hMlQPfrWqE/t4I/wAnU8cNMlUyDIATCM?=
 =?us-ascii?Q?1iFpZ56kW5gadUNiOg67Sm//MxZl53pr0tw3a30QGme8X++7dqLsKorufdTc?=
 =?us-ascii?Q?X0eWB5+eXCpkaT8nv8t6bmq3NWeGh8ULMaAO51KNVYXjwRDp/HVgXgZ9qe3e?=
 =?us-ascii?Q?2XSHJ+LTX1ZqYiRWDV6BtwiAhL3UDTGNfNZK0IwJQEY10RPi5zPzt10UJHwQ?=
 =?us-ascii?Q?15LOhLKfIj5/ZnDhOnsiIt0ejyivZk70GlJWmQVNuS+q6cBwpNOSBO6h5JKa?=
 =?us-ascii?Q?uLnxCGb0oDVnrJhs8y9tOMcfHghgPGmLXCyvSU3+O/6N2jyQtG7RMLAtIW/J?=
 =?us-ascii?Q?Q6cbnJqKfbIoY7RakG1H8OincVsqcNHuW2ZcFN4grrWi4wwVazRmlmJxY5It?=
 =?us-ascii?Q?KVkASFrRimvkFUQMrxOkCEylwSz+R3zAOykUU9z/mfLXXK1a4j9w2HRVmAfv?=
 =?us-ascii?Q?M+OPHPMbNX1GbQLtxRIjsN855qHcezleG5+i4l6pQqPSURnVq6oFgxSEXF0X?=
 =?us-ascii?Q?V5+WgBHTd8Up0kFr5jFrVhl1nXBv80VZcQf986kCflzs2zB/Y/TN50tmeXjA?=
 =?us-ascii?Q?WdRCIdhPduxGD+j/yisBfBYzVV6jjnFq34GFTgKdHLnkirAtKOYpfzDUPJ+J?=
 =?us-ascii?Q?ecIx8CEyTVDbXSW5Wlx/ln7Kxg3Yeq63uww2jgnEH+Wf/usUPqSBa04G6rJq?=
 =?us-ascii?Q?ZbjUvFmveEHeCHAzmoDY3wAC2lclP7i2x9Fl0otGCYCC1bYkaDVeZxt0QF54?=
 =?us-ascii?Q?ZwTcAxnt8i17uOmdGo+wTpG8T5xYeNR9m6WGv8e4yWx/OnTzybQub37BD2L/?=
 =?us-ascii?Q?I9fJoIQFP1wRkV/2+3id5QcNgzeXchEru/TOskv0Z0wdktBYuzDSUjnO+gIj?=
 =?us-ascii?Q?fHCM1Lwhp40N9lzBPDvqJ/oDEbMRN44P5WbFFQacbtjEefVTvzKvHgY4Vuhs?=
 =?us-ascii?Q?GEnEFaX+tZfXTkHkiDMECfKroZcLOhDr+Kn4u/JLSrsTNiBVarUvWjgx6v1+?=
 =?us-ascii?Q?skKJSe929Oxy3SETv8niDXG7daNoSstCbH6LAq0QT8Y56r+7LCZnim/iNTZQ?=
 =?us-ascii?Q?ZVAmtN8DmCisu4fL7XTIw+msxyrOFkU4uvTHgE1/bz7AbH/L8/ku5L+0d2O/?=
 =?us-ascii?Q?ZbWZhXszalnkPXKHXZ/YPICUXwl207hlYb7rcc5YpIRdQHs7mx/f9x6xFEa4?=
 =?us-ascii?Q?qPRbMwMqvl3FFoDsoD0TX3hqqXoQoPWcb43pxRmTMedSm/EGyf38LmqEpwY9?=
 =?us-ascii?Q?GAOlJEkFG6DK3JI0BOCdB+ltPvRcnxZnTZg/koWRdyIUYNB/hxUlmE2VTWJR?=
 =?us-ascii?Q?xHTGOjrirwuIt0pQkGrRi6/U6+XC8ZmYKnry1Z+c+oLwF6JNDXFI1Lb1khCl?=
 =?us-ascii?Q?M22N2hPULCQECJtbCDEE4lFLj+CkKPoY8cJ60dnKaZgO/F7Ab36+ylXk0YP5?=
 =?us-ascii?Q?TR47XXDGITaEmG6eLmX3Qsww/lHbqcXgY+Rz1rBBCz+xEGjTv2xnrlADY8S5?=
 =?us-ascii?Q?qz0t8aDPeyK4lbvfDvs0BJiS59ad2ytC67lrJBr9WUlSdluTwhT8VTrPVaki?=
 =?us-ascii?Q?2f13BNFsHtpOdO4PguZ2vVIFGYckIpVxSMwvPryEEp3A0SdYNSAtcNDx9B1B?=
 =?us-ascii?Q?vnt+3uZFazfLi6XvMSPUncUJW1D+KICgO56wgI9e8slO5SjLaVygSMqpFRBE?=
 =?us-ascii?Q?/Cg9NRpbjXaPJYmYEZSnUtLaSj2ctLy8frmwVyvxEuRHacIR+HGE/xp/OqOx?=
 =?us-ascii?Q?fs/pto3RZg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ixshtUTNuhODL+CLywgXps/qaXxz84fNue0RcvQkeMoWjzhOwCrXINAD7/PecNzG18COSGbx9PQavYyVewSkut/2eEvDPBBC27cd5vWVtQrBIEo7KOaHq6TY5y1Wt+Ksqo0W8DSZnCOL/grvIB0zdqmD1Vzch5T8mH9HOpiAvnDIA1XMkxCiiVb/S68noVVCbg5GFGLBuYUXn48B0lM8koyNm24oO4S43FHlIVsJMNcgBmhaC68iKSQxSavoeBlXFhWxRHaV8JxaODYUo2Cr7zzpQIZscJlP4n0KkRhyiPcXgMiICwnz17GJgoQmMNUNbCwSQogdKBE1edvWLRArVNq3iPqmaNdk2Tew6Jxi/UAut+bKif5e25s6T2tCujR/BOlfH+8TILbS0k9pQ3bjB7WMMEwLqZPbNbeB0ZxzIRuC3q1GzcI24aTNn/FBnKCcxxwCeirUxxm+9wlPLr7rKP2IMqNhsHyCxBbQcCh2E6yshT6v5NDgLEtGpa06cycf/PJpo8kd9iF7js2daTdbQ/Uq59yqpoH+mMsZvY4WRWXyVo9KjqovWaR4g+W/XaheFr0D7RnalttR5QW4ILYtjI1QOGtz6ScrMOXcv3/1ZF4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afa86f52-3b4e-4d13-1a7a-08de527252da
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 07:06:50.4413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kHGdqfpEaaTRvetNZwev4e+V7DFKqpqn6ldT7QV577ocsX9mTiUuqJoIJwork4HjIjwwDmnmglVXjcuc6dxFGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8190
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_01,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601130057
X-Proofpoint-ORIG-GUID: iaGCeIHJVVwuwo0taLNVNzhhCOQYONnW
X-Authority-Analysis: v=2.4 cv=YKOSCBGx c=1 sm=1 tr=0 ts=6965ef0f b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=Pqqr0_FuijpkObcXNtcA:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:12109
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA1NyBTYWx0ZWRfX0Vgy/e3UyAiQ
 mCvjTW2VzNLq3V3VHtEw1TWxVZYYU80Ux+RYR0w1Wy88zgrxKuQhbyimfTsLykrgMcO4TfweiJY
 aCKsq8qDagS+rorU+EOik3Rb++BsL8oXj5/bVNg3ZbcKURqNyspwFL/yG/iODsfh174ASRKDzbj
 8qw6pUc935mA27zGcnFpeB0lFMN8Kp1OtCuDLK8+RLCuoVUbJyhMV4+8nx+fPDtd245Kg+Aogn/
 J2fzIqu9hQgFH6ls/m2WZjRYXtY8AsN2JwdCAhyrfdacBtVi+Xk+v9zRj/F8bjgg75fnfW7ukg1
 7vgDIRiUQyz9+iJdze2Aw7fwv3pKupBCwpsXBhnwXeuiQq6k2R0nOU4gG3ChcSN6vzj+s19mWQ2
 sgkjVPKiKwXe1VsROlS8hQohAQPwcVYdojbXTCEs7sQxQDRhQb/BaSbnXiGG1wxaZgUN07RfGrH
 YvGfmfnkTOV1k6qMlHxNYEgG/A5bI8rWNJEcihIU=
X-Proofpoint-GUID: iaGCeIHJVVwuwo0taLNVNzhhCOQYONnW

On Mon, Jan 12, 2026 at 04:16:56PM +0100, Vlastimil Babka wrote:
> Move __kmem_cache_alias() to slab_common.c since it's called by
> __kmem_cache_create_args() and calls find_mergeable() that both
> are in this file. We can remove two slab.h declarations and make
> them static. Instead declare sysfs_slab_alias() from slub.c so
> that __kmem_cache_alias() can keep caling it.
> 
> Add args parameter to __kmem_cache_alias() and find_mergeable() instead
> of align and ctor. With that we can also move the checks for usersize
> and sheaf_capacity there from __kmem_cache_create_args() and make the
> result more symmetric with slab_unmergeable().
> 
> No functional changes intended.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Looks good to me, so:
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

