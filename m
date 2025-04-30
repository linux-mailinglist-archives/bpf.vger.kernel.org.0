Return-Path: <bpf+bounces-57055-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 330C3AA501E
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 17:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 604CC4E5107
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 15:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06948261593;
	Wed, 30 Apr 2025 15:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ry69veyY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="t1Mzim9m"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CA4261365
	for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 15:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746026552; cv=fail; b=Ee4OR4H42JqbF2RmLIohfAmHT4/MZNLbbuK6sYy2SR19oiVaoCNTg9J4wiuvnb2cKwJzItphIqZARCSDqAuKBOna71U9fpjA5waLPaMj7L21y5Q+MuUW3ooo8jE9Bm7DzWP2gvR2zUcWJ6Y3VMzPh40+qWnSruarAFDy1PARq1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746026552; c=relaxed/simple;
	bh=PcYjZzpNBVK/w/2kZuxmEZi7mCfsxuccrva4h6NcA/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TwcpUhCC6GBDEjnXdOF7+BiVrAr9uLEhWSG4Lf8shKHGKA7Ct8XVJGfShgtO2rmzgv5z7V2mbMXzfLTqV42Z4EEtsb8spX6odXdsPsSN2zHGQP+BUxBl+xu6R9ev6myZXo2IAe3hRppojaf7OYzj7yQfDkgLhrjqXPkOCf8J5hc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ry69veyY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=t1Mzim9m; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UDahq4015608;
	Wed, 30 Apr 2025 15:21:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=blJycbjEZw7NNFiODQEB3tvbhpsa3j7tFQze85xkMvg=; b=
	ry69veyYImCtp63fq527iFHtJR3bt/3iNyz10dR2VTeTx7iYM2OaQTdG3lG5sxBq
	VWNqQYu880Z6zQ3CsJbQB8T2CaHFEXWZDovIDNtnvcSUZzwqDICpptctEFgvsgdQ
	J6cbxO3Pye6m/esD73GShgXRkZBjWAr6tqEVsvoeqJDVS2tmamC4ngbwYcJ+f5fi
	yQJIK0c9Z+FXtrIy5gQpv0EwPeCklMmkPTYESicmn/Vl+BNDnO++O9bEjisXyOGb
	aQJbQW80j1m7Zc8vT9MHBe2eQDw7fRXNSzN2MHij5pWf7ng1SCWWn3J7353aSozw
	WvWT1hX66NOIugCuTtPQZQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6ut9eue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 15:21:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53UEUCMb033509;
	Wed, 30 Apr 2025 15:21:54 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2047.outbound.protection.outlook.com [104.47.57.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nxbf7hy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 15:21:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cdz1owsRgrFOsI9GseCgyNMClRCoUbKnUAa/rOPXS4Jz9xfu1YZqutAVCl3OadJC8oFyGxB1VZDQF+ItD5+mMHtVSgh24iwtK2WDVd1NcM5IdxnoP6PKWhgg+QltOrAMVQBXQ9PX69blB08DP8tIZ+/YdCE5oz/p3wOUedjmMdl51A1jhagb0TM7sbfDtPfVUyQ0C87YtW8EgeQmxl9PtN0Ld0UapYfZf4CLLqz0DZevvsFxbtZWjQX37grtX+6I9V9YbrkU3IurdZ1hz0XChTHyQXx0u3AIRVx97gSJUam1qaKPNWBbDTEriv+TNOcYc14+JS2Yc/xTP8wkLCUxBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=blJycbjEZw7NNFiODQEB3tvbhpsa3j7tFQze85xkMvg=;
 b=qxIrCDx3soKWN7aA9q3EogYexRpPQBk4aWRlB1owpn+eND01ElHe0PrauKVzrcSgOj/HSdpwrybQsIQ7rSvjWT5RcY7xCX+flsw2LGEq6YW771UMbRnm+7+wt9bTHEII+W40HBcFiTw2pDSgHr8R3E7FWGWM23w7xruLHDvIZ7fYVrsC2zi2ApnRgJhp/faJqDUYgqqpkFVYypwO7CSU3ueRsbJJT5Zj/AcjZnahGawxUmLVM6knDsDzEvbb5Ei84yxE6fzHFNLBcqKTGbTzI0xG3OEPPbw5549Z+puK7L1q2xhDMXopyCO6+dfsC/h6PXIEFWl1qylsviJFltImxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=blJycbjEZw7NNFiODQEB3tvbhpsa3j7tFQze85xkMvg=;
 b=t1Mzim9mSW8Byz9HwwLCXqkRh6BhmSPAK8yA1xL9uukh1yjALVf181CJ4kxoGdcy2W6pYil8QAkGgTL4maOEQOGk1JuyZDZfVjpJLKdw0kQNWp1LcJzkFnXXM1N3W27I6UD510s0LPgup4ZzOmH2pEqCiIjk+C2qN97xc2537ss=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by DS7PR10MB7153.namprd10.prod.outlook.com (2603:10b6:8:eb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Wed, 30 Apr
 2025 15:21:51 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8699.019; Wed, 30 Apr 2025
 15:21:51 +0000
Date: Wed, 30 Apr 2025 11:21:47 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Zi Yan <ziy@nvidia.com>
Cc: Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        David Hildenbrand <david@redhat.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, bpf@vger.kernel.org, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH 0/4] mm, bpf: BPF based THP adjustment
Message-ID: <mnv3jjbdqx3eqrcxjrn5eeql3kpcfa6jzyjihh2cdyvrd7ldga@3cmkqwudlomh>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Zi Yan <ziy@nvidia.com>, Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	David Hildenbrand <david@redhat.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, bpf@vger.kernel.org, 
	linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@suse.com>
References: <20250429024139.34365-1-laoar.shao@gmail.com>
 <D9J7UWF1S5WH.285Y0GXSUD30W@nvidia.com>
 <CALOAHbBfSat7-qOjKseEJy=w5MVF7um3vYKPCb0VMbEgw-KAuw@mail.gmail.com>
 <42ECBC51-E695-4480-A055-36D08FE61C12@nvidia.com>
 <CALOAHbCtBB81MKV5=rTM03qt=qCF-CWctCmF0xjxDo_sXwaOYw@mail.gmail.com>
 <8F000270-A724-4536-B69E-C22701522B89@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <8F000270-A724-4536-B69E-C22701522B89@nvidia.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YQZPR01CA0102.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::24) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|DS7PR10MB7153:EE_
X-MS-Office365-Filtering-Correlation-Id: abe3fd19-af05-4094-fd68-08dd87fabb48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cUV0VU1hNVB2TSs5OU43RytFNjFxUHBmTmJKTk1ySUtGSkF5L1N4MEVVNCtU?=
 =?utf-8?B?bURRSE1Rbk1GeUp4c3ZkZXlwcVBLMXN5a1BrdTFYckVxbG5wZGJoREJ6WldT?=
 =?utf-8?B?YWFEVGtDL0dYQkRPTEd3NkdqWHhLTWN2R3ZBQUE2MENjY3FuNUl3VEhjQXJG?=
 =?utf-8?B?OEkvNndZYkMyYWk0OEw0Ly91MFBWT1VYV3FOczY3clp1ODBpbUVyWjZRRUdp?=
 =?utf-8?B?SGRwTjJKUklTQUtCVkNobzh6THRuNzVXeEtEYXpobVNFQ1d2dGpFdnlUYkZT?=
 =?utf-8?B?ZjBia29TWk5CU1N3Z01QMmxpZ0dGdzdJWkI2WnlPamludGNpbnFNbVY0V1Ax?=
 =?utf-8?B?ZjQza21mWWhJZGZUbGI2bHZLcFBZeUhQN1J2TU9oK1I4eEY1SThCdnBlb1lC?=
 =?utf-8?B?QWlVQWNvSW5za0hNOHkycEJQN0ZpRGVKVHJVcTZLeGxMcmxTb0xUUmZaS0VJ?=
 =?utf-8?B?T0o4ZEZDb2hnVk5HSThxU1NNaDQ5eHF4RWlmRS8zayt1aEVVczdQT0J5YVdU?=
 =?utf-8?B?aWFBQys0cEFraDhTZWVIcG51RitDQmZhS1pLUm5rMlpxZkJOdlJ2c0QvRi96?=
 =?utf-8?B?Y1creXhncUlxMzdvRGN6Q3FzTW9UQS9kTkJVeEUzTDJsWkJCOGJSeDhYWEhO?=
 =?utf-8?B?RE52V3Z2U2dHVGJLRnFXbkY2aWt5bEhtbXFPT2hJbHZwYUpYSkl3WHVmaWU1?=
 =?utf-8?B?MWdyMFpNQ1UvRVBIc1hDbEhBbkJsbmdOcCtodjFGVVFlZVFVR3U5bjRINFQr?=
 =?utf-8?B?Qis0K25nOGV5ZTJlNWJKQ0NkZFZhL3A3MHBxOG9pN1lMU1hmUUhnU1lTU05B?=
 =?utf-8?B?QXBJaGR5VXRnZlZEUG5Sc2gzNG1FMXAzTTlYL3JmMU1ucm56akUzYkZiYS8y?=
 =?utf-8?B?ekdZQ2lhUU1qQ05OMm9Wa0FFNnBjM2VvODVyVzEyQ2NCTmFtdGo2Um5IU2s2?=
 =?utf-8?B?d1FtKzFiUVdEM1U5WE45UFJVVWRnb1BvNHBDMi8vVklzM0JVd1NCckRvUzV0?=
 =?utf-8?B?TzhlbHJoaXN4Qm5yTVp0U21lYk9VNTBHcldwM05iL1hjbXNTR3RLREV6d1Q0?=
 =?utf-8?B?Z2F0SEk2KzZyVC9xTHZxaVByS3k2aGF4M2VvbmUrc0FjRGFSR29WZG9sL1R4?=
 =?utf-8?B?YmFQUkYrcHpKdklaTzUwOUwxRVZJaUV1QllYQU9DcWh2NFBJSzZkQmU4SFFz?=
 =?utf-8?B?dmd1cjJmQ2JMWDRmU21peE1SZitWZ3NLZGtsWXBQMkV0Y2dYZHVSZ1EyZFhv?=
 =?utf-8?B?Q3NTZGppY2h5WTBuRko5UGRZVnQ2MnBGMVh3REExSHMzcjdpNkMyTnNSUGRz?=
 =?utf-8?B?WVhJazJ6b0RzTm5id3loNXZJT21BMHRTT3hlOFB2SFRYanA4Y05DQU1EbTFT?=
 =?utf-8?B?c0o0amxkVXBqT04yM2JuNFFFZ1RiVzNaRkV5UjV4ZDlMbjk2eTNpamhYSTVx?=
 =?utf-8?B?WGJERUtuN2NUajZzd243ZURnVm1QcmdpQmdwc3BzOTI2ZzYrZVNVSTdlY2R6?=
 =?utf-8?B?YS9UTmovUGZ1bXFGZFl6bGdiVHhXZ1B5QUhNeVU1bWF3SURiTzg5L3BtV3hU?=
 =?utf-8?B?ZWo1WlFrVFhnWGtzWGM1M1pLUmU2cEdYWkZ5cUhkUFppY0UvajQ2VkgvUm9x?=
 =?utf-8?B?ZXJNSktENVF1YjRtWVlMaTNhdDNWd05YcU5HaHdMMDZqRjFncERwem1HWjM3?=
 =?utf-8?B?b09YRHIvQWpJU3ZGUFlsWm84WVB6VDJNb2g1MjdrSlY0MU9IbVY2TE8xcXJW?=
 =?utf-8?B?dzltZUhsaFJjWnRNRDF2NXd2VDJtWXQzT2hNTVZYTi84ZWEvS0FNa2VndUZu?=
 =?utf-8?B?d2FmUzF2dmZIeUpUaloxdXhNVXdQajNnOEJuR0d4N1gzQzNtczZLMWlKWWVa?=
 =?utf-8?B?K0VLY1VLbVVnNlA1L0hLOUlJYmQyVUVRMk5rRURqRjlVRTNqUGM4Nlc3MWtP?=
 =?utf-8?Q?IhGpG7peOpc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2RISEc4eHN1U3lQOUpPdm1xVDd5VlN4Wm1YSHN2MEhUVnhOb294eXBBRFB1?=
 =?utf-8?B?cUpkTWRXSWlCM0tuWndIWEhGMmxqdjArZVhUY3dZSHdZSlV0NUMxQkNCWWFB?=
 =?utf-8?B?WmNQeG11S1hsaTVTQ1Z2dlZNa1FHRCtEZzN4dDdvdWhqV3ZlaXZnb1hmeEVv?=
 =?utf-8?B?ODIyUFRhSTBKbUh5ZzRxZ250a3FOSTJCQjlsOG9QMiszenNISWUvRVNrVXJl?=
 =?utf-8?B?cU9qQURjcEU3ZUQ0ZTJoL1hLdGpodTJtNkVseE9MRDRKdTRrcSs3Nkh5K0ZV?=
 =?utf-8?B?Und6WjBTUXVKVzkzYjk2VGp5REx4ajY1RjBFVXdSYy8rS3pkRVZOUVN6SHIy?=
 =?utf-8?B?Q2dLREFrMmlLY0twdkdvRjBaODAxbDRhRnhUNzB1akNWalMySEhlSExrRzFk?=
 =?utf-8?B?ZlBmK2dCVm5udG0xK1A5a0Y5R2FTUXh4ei9Pc24ydW1PYThWTkZxbkhSbEhp?=
 =?utf-8?B?UGRKR2k5bzFrTDFxL2FCMjM5R3IzMm1tczNObFRIMUtoaU0rM2daR1NTSmRD?=
 =?utf-8?B?bUg3RklIbEJ3dktZdk04TDl4QjJzY1ZvWEpyTXRhcGxxODhzVUVNT1hVSGxU?=
 =?utf-8?B?RHl1WnhEQnBVeTRUbTdjaG9JekpBWVFOa3h0cGRhRXV4K2NDdk5nWm5MWVQv?=
 =?utf-8?B?NExvamRtY3Z6dWI1N2VicENYTGsyL2FadzFnU3c4UnErSVVEaS8vV3c0VkFD?=
 =?utf-8?B?bHBEOXd3TWZRWW43WHFrdlBkWmNyWUdta05YQ0l1dkgzSStrUXh0bzFUaXJk?=
 =?utf-8?B?dzlFeXVqVzVwK0pxVlNBMHFGVnpwc2JVQkE3eEFRYU9rRlcydjlGaGtoOXFO?=
 =?utf-8?B?ajJmS283Rm9vYVFyNFpIQ0dlakJGNmJLWWRrd1IrZ3hUWTZlSG1ncGtBMTlw?=
 =?utf-8?B?R0NwcTZKNWFkaUFEYWdjQk9BajdEVHpGREpOL2tnbmZGMC81ZVFRZFk0Mnph?=
 =?utf-8?B?dGRUbm9vUjJ2TURtNXdwNk5UNnp2R2Y2ZkNJWkJPdHdXV3B1SG9VZ0pKWStO?=
 =?utf-8?B?R21BTlg0Y1dweXUrV2ZzM2ZvcThyZi81aVE3S3dwL1FMV3lKb2g1dHhsYlhE?=
 =?utf-8?B?NUpCd2ltUWpVYlJQVzllREpOYmEvbytndVZteERMZWJVT1hLcisyMWRJN3Bx?=
 =?utf-8?B?TmpGVWsyR0xBZmNwM1ZXbzlXdHJ5cUZVRkpMdEdUNG5TaGs1cGsrN2oyUGYv?=
 =?utf-8?B?eEtNc2t3NFBrdi9mczJZTUgxWjBPNzNxYTdCeUsvUTNhYkFhYjQvbWxWbUlF?=
 =?utf-8?B?QlFIYVZBV2VGWFRMN0czSEp2MmJPSUtpbmxudnVDbkdJK1FwdWdMcVd1aUxu?=
 =?utf-8?B?OUwwdWZHWFBoNVNsWFo1bndyMHJSZC90VTRsUFJKbGdQRW91Z1h1bElRbHhF?=
 =?utf-8?B?Z2t4WDV5ZUdNTlZRMk5ndHRmLytrTEZyajl0bWVpNTlVeE1aQTQ4eGNlYVJh?=
 =?utf-8?B?OG9TYlE2a2VITncvRHlyVjhXaUdTU0U2Q3ZzRkVZOFlGMkhEdXd1YUxha0Vz?=
 =?utf-8?B?eTVHTEFYcjVVOTlpR3pQQktMVXdIZTFrdDFVU1ZvalZRQUtodDVZWlFTbVFM?=
 =?utf-8?B?YmxqTEJISUp4aWI0MkZvNmFVKzJ3QlUxR24wc2ljMTd1cE1nZDJpYnZ5OHBT?=
 =?utf-8?B?S3ZSMzJTRUc0QXF2OUNxRnA0WUhKdTRkOHFnQTBHeWNXd2wza1ljdjQ0M3VX?=
 =?utf-8?B?ekUxU0hPZFJzeUtrdmtGb0ZzR1IwUXROL2prd1ZHSis0bWFCVmtFaFJ3YWs3?=
 =?utf-8?B?cjdlRUc1cW9aUWs4SkVsbDN1MzlOWEFQZUEzU0haRUQzbDUxR3ljNEVvVFdS?=
 =?utf-8?B?NUtrR3dweUI5MkJPZ2V3QlNLVWRXOEJOazcwZ0JCTmgwd2xoWkZka2J5akUw?=
 =?utf-8?B?bG1vUk5ucElydUJTMVdrR2txUnNhbTFSaVNqc0plRkVpMEFSMlIvVDB1a3dq?=
 =?utf-8?B?cVdmTFpQYytsYi8vSktwcUgvcEFOMTc4dU12QkJCNVBaU1JxNGd3c2diU0Z5?=
 =?utf-8?B?L0ErK1phdW11aXdzVGpwSmJtbCt1MHlaRDV0MzhVa1REMkY0eUVZOVhMcHl2?=
 =?utf-8?B?by80YitMNkJjS040NTBjRzhrdnA5dGVSM1FYblhmQ2RnNUhwWmphUU1hWDNE?=
 =?utf-8?Q?nidBdQYI8YFS7EmYFcFhXkmZq?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FeqbsamVxwqg2s5UQusfJpD6kMhYq3u++lHb5zKKyRyjJfcrW6vHv/SGKSBv0/i65fKUJA+l+YW1J5xKMbnP4ZHlaZmE0M3yWG7R2sZhc1FIQzgAExSLtllX5kzKKMMhuvegEaBWgquDsy8emXTR7yNs6ilU4lxi35H/o+DmTZvPUKMWD/OmJqYk2Ct4mx3jGrxaIDmsxP1kPlAo5ETLQIwzf2/XvFJZi48MZ4NVLtx8TNaSvYZMjIc8zgD2RU9olKACX0yz6l/b39aEIkRBNh+AWmfXpjaS5ukVBWu3T3mZKNGRipkRFLD2v7VRN6EzeG7eFyrUFGTROVIZUM8jd/PM94oFDOglz6B831TotrWGcpi720f8xmK115swMBoJcYZw+UTbQzYfUK3B1QST47jO7gc9S/PA6UMXm76VMT3+7iKM/pKzLaE7FAY2VFSKKClUIHuAl1DVOYFdydSYHsTBRqxAUUh2aJ5PaoJbfPUdfz0p24Gq1tB8XBIDrnRPi3q/w8zf9Z8zVPCLAetEiEtHJHL3z+Iv2cxdplxvH4TvqsLnj5arCbpjY0cjUuwQcceFOrnPof6bFvLNDxPuybgiGzwQ/XsvPXvj6zKRCok=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abe3fd19-af05-4094-fd68-08dd87fabb48
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 15:21:51.1817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UwYqYS8INC7gNtkIV5KF5tABW0rHXaHW41VWCjtW3DFPK9T0wQ3pcsB2/e6qsVpiRlTjRLOqLurOeS75Hx3tLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7153
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_04,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504300109
X-Proofpoint-GUID: Jrq_mQkKa7MGqfYr24eyejxmjfG0qzAJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDEwOSBTYWx0ZWRfX0d0U546x3CXS bPnL6pasSKXtmVarcSPTcqq/hke3YI7BSY0+UA0OxFo5+It6kn+FutdxseGKo1h3ObvmgEVdW0N Gg548pD5Mlx2xgFxwQzulJYo7Au47O7780XZn4E9Uak9H6daaVGqQu4jqrLX2WD0pXLz+J+hflP
 1GpsQ2irs/8pzF4VQM4cM7VBc5Ipf1OEkq6yHcbTV+b3kSGrLMLMMeti4Z9cP8gHZNNTkNJvzMT 25QljTFGiAFsEVFAuv8Ui4aVsIZu0uHtzEK0rpTznuQ0xQKHZh/tQ0QgrdeHyxsYYzCDXO0jGkb NBNxXaTprPwb1vvtp9Z3zJj8ewfGu/mwQKgY/EL3nTOX3+TTEKhaZMZnbmgL/UTmlEB0iJcfHtk
 B2NOrKW1GT2YkAVIxVSYKswDjindw0mhlMyJ+PAtVUwXKOoWsTntnykktT+oV957eGABVCGT
X-Authority-Analysis: v=2.4 cv=ZuHtK87G c=1 sm=1 tr=0 ts=68124012 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=GoEa3M9JfhUA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=XzwWPLk4AAAA:8 a=Ikd4Dj_1AAAA:8 a=MmX3beqar3F4Cmst_r8A:9 a=QEXdDO2ut3YA:10 a=eD7Ax5M-l9OxXO5vTfaj:22
X-Proofpoint-ORIG-GUID: Jrq_mQkKa7MGqfYr24eyejxmjfG0qzAJ

* Zi Yan <ziy@nvidia.com> [250430 11:01]:

...

> >>>>> Since multiple services run on a single host in a containerized env=
ironment,
> >>>>> enabling THP globally is not ideal. Previously, we set THP to madvi=
se,
> >>>>> allowing selected services to opt in via MADV_HUGEPAGE. However, th=
is
> >>>>> approach had limitation:
> >>>>>
> >>>>> - Some services inadvertently used madvise(MADV_HUGEPAGE) through
> >>>>>   third-party libraries, bypassing our restrictions.
> >>>>
> >>>> Basically, you want more precise control of THP enablement and the
> >>>> ability of overriding madvise() from userspace.
> >>>>
> >>>> In terms of overriding madvise(), do you have any concrete example o=
f
> >>>> these third-party libraries? madvise() users are supposed to know wh=
at
> >>>> they are doing, so I wonder why they are causing trouble in your
> >>>> environment.
> >>>
> >>> To my knowledge, jemalloc [0] supports THP.
> >>> Applications using jemalloc typically rely on its default
> >>> configurations rather than explicitly enabling or disabling THP. If
> >>> the system is configured with THP=3Dmadvise, these applications may
> >>> automatically leverage THP where appropriate
> >>>
> >>> [0]. https://github.com/jemalloc/jemalloc
> >>
> >> It sounds like a userspace issue. For jemalloc, if applications requir=
e
> >> it, can't you replace the jemalloc with a one compiled with --disable-=
thp
> >> to work around the issue?
> >
> > That=E2=80=99s not the issue this patchset is trying to address or work
> > around. I believe we should focus on the actual problem it's meant to
> > solve.
> >
> > By the way, you might not raise this question if you were managing a
> > large fleet of servers. We're a platform provider, but we don=E2=80=99t
> > maintain all the packages ourselves. Users make their own choices
> > based on their specific requirements. It's not a feasible solution for
> > us to develop and maintain every package.
>=20
> Basically, user wants to use THP, but as a service provider, you think
> differently, so want to override userspace choice. Am I getting it right?

Who is the platform provider in question?  It makes me uneasy to have
such claims from an @gmail account with current world events..

...

> >>>
> >>> I chose not to include this in the self-tests to avoid the complexity
> >>> of setting up cgroups for testing purposes. However, in patch #4 of
> >>> this series, I've included a simpler example demonstrating task-level
> >>> control.
> >>
> >> For task-level control, why not using prctl(PR_SET_THP_DISABLE)?
> >
> > You=E2=80=99ll need to modify the user-space code=E2=80=94and again, th=
is likely
> > wouldn=E2=80=99t be a concern if you were managing a large fleet of ser=
vers.
> >
> >>
> >>> For service-level control, we could potentially utilize BPF task loca=
l
> >>> storage as an alternative approach.
> >>
> >> +cgroup people
> >>
> >> For service-level control, there was a proposal of adding cgroup based
> >> THP control[1]. You might need a strong use case to convince people.
> >>
> >> [1] https://lore.kernel.org/linux-mm/20241030083311.965933-1-gutierrez=
.asier@huawei-partners.com/
> >
> > Thanks for the reference. I've reviewed the related discussion, and if
> > I understand correctly, the proposal was rejected by the maintainers.

More of the point is why it was rejected.  Why is your motive different?

>=20
> I wonder why your approach is better than the cgroup based THP control pr=
oposal.

I think Matthew's response in that thread is pretty clear and still
relevant.  If it isn't, can you state why?

The main difference is that you are saying it's in a container that you
don't control.  Your plan is to violate the control the internal
applications have over THP because you know better.  I'm not sure how
people might feel about you messing with workloads, but beyond that, you
are fundamentally fixing things at a sysadmin level because programmers
have made errors.  You state as much in the cover letter, yes?

Thanks,
Liam


