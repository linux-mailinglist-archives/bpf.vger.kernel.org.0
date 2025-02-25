Return-Path: <bpf+bounces-52495-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEA9A43997
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 10:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 039E2188C540
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 09:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD10263C86;
	Tue, 25 Feb 2025 09:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dn1f8oKG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iUQfbM5L"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5632263897
	for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 09:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740475981; cv=fail; b=tMuRqSTXGOaPxVxrjzCea4KHPHTp3wkQReeE8nrH3n5KOsraDggLZJ7DhdQ+castxUs2jHJ+McPqy8ZPWVGoj81qS4rAfYrmDSdgdPXvYyQDqN0OM0diooy0DgR373SWaVcLZJ2WqWOO8tPyvGrfHrvfpXWbOhHXva0QU9LVSKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740475981; c=relaxed/simple;
	bh=BuPngQreeyq5a867DjPBBCFbPKQKIoHl17YQ5G87/rY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NHaNfA6CW/tcPXi8tsAt+PWmPEavL0AEkWbHw2sH9cP2QlNRYk7JMC1ng7kW2E8FMAY26g+QKAda7LsaiBJvUsCPYTKYIfl9shNBDUCI+vVDA5aW1QuGg+rjByJuwRqySnhalXZgGKh4OxTdBhaObY9Md8JB5pPj250zYt+9bEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dn1f8oKG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iUQfbM5L; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P1Bn6w001682;
	Tue, 25 Feb 2025 09:32:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=rwCXMeuXkMM5nfx6QBw6SGtn2IhAJz+kLg7IQxVNjEE=; b=
	dn1f8oKG8OV53O1THAvrZQE+BRQR4jnXwbb6TMpJIOwVC/+O+EDo5ior5XQXLwM/
	nfWOW037GKtAcxf+qpCCpIHmpKqxDlp0GAjC1MpkbPcmjxctRnKU3hO/TpKIDSiB
	bGxIAnEV65gj6ar9x9izmeZmy3fX+k9mA2uqr/3bBU9+lLQ2FjHC9rrm3evGtU6d
	rMhUO4n3fP3cjKcf/Ke2/TzzIJAqyxiBcpf6bvqJf+tn7qKpWr1gmcsfpyga3qvV
	W8+h4p1lfXmEVWOfOzTK2G1v2RVO/oYZRWA4+hL/5dsd5nbpi2O0OKgH3CK9EC2M
	LTnJpDnk5rr9cNAGa8IGVg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y5604mat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 09:32:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51P7wvgP010247;
	Tue, 25 Feb 2025 09:32:24 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2041.outbound.protection.outlook.com [104.47.58.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y518mrfb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 09:32:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xMI3iZVcXl+72DDaM1Q3l5Y8QdzetoWLIIWpQLciZbyKuv5XN4S83vyDnS1LVp9buyQNqvl/wtQxxNoPqLHDKzDxp+QO9xao5kuCe6VKAn05CWTnKr6y1e+Cay7Aj6bjHy8RoR8SBew96b7zOrxqSX4x22dY7Jv+ZSbV2yx+WtXaEWkH1vFRfinBPvowyi2zn0gBfIsUNOLwqQI7jVwGg7xHZ1SN/wy9HIGMz1R/fs4E8xa8kq2SvsyN+0+013MuOJQCfP4x9nQuLwyIkEr9c3vMzh47w1G71hQih7KQDB5NSVrLUnlgxMCaqVhK4LhGNZqYt4aflfJX5h2O4v68sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rwCXMeuXkMM5nfx6QBw6SGtn2IhAJz+kLg7IQxVNjEE=;
 b=grycduW26BBdSyqypJhTvlTmY4zz5QzTjJGhXsdiZH7hzfpJfEWRmoH6jSj/Mk3veLcwAOVnMIyg1ocDrLxWNkDOUT//xnUwva7JtpHBFGbn4NtuZ5wgoxIcLnBoe04w79lyXGyKB6+h+k13Tlz2D1NtyfLaGK/zYqDw1NwGhAR89bCK7NFfkoQYrPFXFfKxGa/6i/eSTuAlEY9eD7Gm0dIYGy3/6bE0AJZmCCD0dM7257DOSP7gNhbFM9yFBf0DsAHWoFO98KLmxYv0UjXkdZOMcQ0vQuxxV79Rjeh57eYG3YbvjNksdfUPvs70aQ1Yj2Zg3sQ8fBzpl7pO8z1Rug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rwCXMeuXkMM5nfx6QBw6SGtn2IhAJz+kLg7IQxVNjEE=;
 b=iUQfbM5LLTGk5q8qlepXyuHWHDaQ6NO/8nkNAWDFFs+dEPNy1U+Scu06W6ZAa375joRrqOHZ5SvQvb/6oQQisxhQDPe6GHvEVf3NXCOzmkdSslkOfItdxJ7k5ORh9AjSPKUkORHULm+jCg1qf+DqczH/M5EIanc/Qx1v1qAFPvU=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SJ0PR10MB4477.namprd10.prod.outlook.com (2603:10b6:a03:2df::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Tue, 25 Feb
 2025 09:32:22 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 09:32:22 +0000
Message-ID: <4da34806-a49e-468f-ba4c-cebb84f40de2@oracle.com>
Date: Tue, 25 Feb 2025 09:32:15 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] kbuild, bpf: Correct pahole version that
 supports distilled base btf feature
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Pu Lehui <pulehui@huawei.com>
Cc: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
 <martin.lau@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
References: <20250219063113.706600-1-pulehui@huaweicloud.com>
 <CAEf4BzYJLKZpuEsbU-A1s7wtpG0YQKUHG3QDaQoDH8B+VY0oSQ@mail.gmail.com>
 <abf6baeb-ac7a-44da-8c00-a0bb409760df@huawei.com>
 <CAEf4BzaZRq+x3C=s3cFw2NH=E=e3xdv844Uk_UWVxxFZAOCzDQ@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4BzaZRq+x3C=s3cFw2NH=E=e3xdv844Uk_UWVxxFZAOCzDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU7P251CA0025.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:551::20) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SJ0PR10MB4477:EE_
X-MS-Office365-Filtering-Correlation-Id: 04db5b59-0ca4-41ef-1719-08dd557f4e58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|10070799003|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RVB3SzdYVE44WnQxYThYYXAwSTF3alF4ZFRNaHR2TnU5VWd2eXVzcjBQcEl2?=
 =?utf-8?B?SWJmdWlwKzVvZEVpR2s2MXQ1dFF6M0dmYS83NzVGVm5zbU5pWEduZ2s5cE5O?=
 =?utf-8?B?WkxnVDJua1pKc0VHbHRwWHloN1FYbW9iVnJYMGtxcTdVVHg2ODUwRlVEeisr?=
 =?utf-8?B?NGlkUmlwUDZWcVBFMFErcUx0aGpMUm9TTkE4M3k2UlVsdkZPT1lxdWcxNTdw?=
 =?utf-8?B?MmwxWlVtU2tZSHZhY1p2SGRQbjZMekt1YVYxM0lWL2RJVERoRFFuNlBzVUpE?=
 =?utf-8?B?bU1kTjZiSzJ4R1pZa2JmeER1L2xzdDFqN3RhWkFVMFhnaHdWTDNsS2JXOEdN?=
 =?utf-8?B?RmlYbXdhdXdUdFFvYWwrS0hsNUY0YXh4bXFuaU1wSHB5cmxUYjlWZ09jMWFP?=
 =?utf-8?B?VEkxSXdOekhtZXhQOEtKbjFOaTQ2dlN1b29rS1V2SE1GNHZKeVkrdjVHNU44?=
 =?utf-8?B?RS9HVlVCUk1XblFMWk0yaURJUnNYejdsOXJXbWFpdERTeFdHeFBqc2RZNCtZ?=
 =?utf-8?B?S2JGdFJVc29lNFJ2c29yczFGak5NVlFYL25GSmUwOUt3QXhheVNyR2NGaTQz?=
 =?utf-8?B?S1FBSzdyLzh3U2hpTldRcm1BS2lDMFRyZzJSSzVzY05ScnpyeUQ4Wm5sRnJI?=
 =?utf-8?B?MVJyN0lGZTN6V3ZGd091c2dwYjdlbWJFTmlXWjl5QXJuVkJ0K0R0NFlZVE1F?=
 =?utf-8?B?RmNJNHg3ZW9xU0xvQzFpdUtST2J5a09lQmhpQlNsTmNhTXJrK0xyNDZmV2dG?=
 =?utf-8?B?VzcrejJwb0JBMkVQaGVhbWdxQ29ucTQ1UXlNUkFkNHR1cDNFaHRZbDZLczVh?=
 =?utf-8?B?OHZma20zYU1yTXhrWWtGYTZTRTlaTlFaU1JiZlcvMkR3YW5qVUJQYm4wdDFH?=
 =?utf-8?B?Ykk4MjFFcHJrbFhDNFAzR3dNR25WanFiRmRBL0twSUlQMzlRektQcFk3SDVD?=
 =?utf-8?B?WmF0L0dIR2lZYmRpMTJ1TWNUREM3Tk1FODVqOU44TnFTY1R6MVkwSlIzeVYy?=
 =?utf-8?B?Zm5NMllpNk1JV0hTMUlFRlNUY0dsWmMyd043c3o5a3JOL3lrbkF2bDEwdjJI?=
 =?utf-8?B?NmxibERJNmF4MVEyRVVEMXVpM1RpcEhzMktQM2tWUldteTh1SDBySFJlRytV?=
 =?utf-8?B?MzF2cUVaTzhIUkZNL0sxdXd6QUFwa0ZwdlBmNCs0NU5iakxnVnVxdnRVZHdj?=
 =?utf-8?B?UjY2bTY5Q3NyN09PanFnNm9KeUJaRXpiQ0Jma0ppRmJBRnQ3dWlZSHdreFFO?=
 =?utf-8?B?NEZ0dDB3R3ltQit5SVJBUS9VV1N6L0NMRVM0VFdQT2RhQVhJV0JJOXRqdndp?=
 =?utf-8?B?d0Y2TEN2S1BMMlFlK3QwVmxUdDlQT0xxem5jQ0ZFU0o4RHR0TTJPYS8yYWxZ?=
 =?utf-8?B?UHBKc01HY3c0ZWJWZHN0VDh3Zkp0UEduazZHMlNma2NUUjFzVTFFT3U1SHVq?=
 =?utf-8?B?YjNhR1FnY2hrUmFjQWU0NDViTE5jVFkvZ0RxanF2c3dXaVNJK0lUUkxJQUdo?=
 =?utf-8?B?NzRxdWZJdUUvUEsyclNyTlJBdFVObFdHVlN1YVBQYW5tcXpKakZjNnZZR25q?=
 =?utf-8?B?YVpKLzJWUmZMaEVDRzhlalpwNXY2R2pyUWgxNnFNQ2hQNTliYVVzN3ppYXA2?=
 =?utf-8?B?SHVyUy9Nak12UTNmUFBDM1Y3WlNwY3pYL040OExZeTRRM0RZNXA0UnVwRWp1?=
 =?utf-8?B?VHlpcEJuQ2pNWXlqTUVjWHUvRVpuMHM3T3RvcisxVGJTMVFEMjZSWW1zemh0?=
 =?utf-8?B?RHgvZSsyRXdPZXJjam9zTXJTQ3ZDdzZpTzRxS3hlNm44TzlmVHhQOWhCTmto?=
 =?utf-8?B?N21OSkdvMDk2UDBaMDlWWjRtWFNQU3BjMHA3OVZMVk1DSFZPUEMwR0dLbXYv?=
 =?utf-8?Q?mKWBeSf1ijaH7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(10070799003)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3lRNHhiRHQ2OTlaUGtWTWVweUFFSjVOSEROV0VmRHVZTlZCMDVKaFNOZXR0?=
 =?utf-8?B?Nk8zcjF0ZTIrZE1nWEtNRlRROG1aUWxYT3RIVzFCM3JkajIyczlLbnFMVHhn?=
 =?utf-8?B?Y3lxMHpqMFUvOG9ZUUJnV010MTZBbVNqejh0MndVZ1d2eWo4Vm45UG1zU2ll?=
 =?utf-8?B?R05iQjB5dkw3aERlUmZrTXRqU0hVcENFQUlUejlyS204aGVpeGF2TTJmaC9n?=
 =?utf-8?B?TEJmbUJkZGdhYm1MRWM0WDlabWZxK0JveHZFNDhITmZod1p6UzZDU3hHOTJx?=
 =?utf-8?B?b2hUUmJKMVNoaXZKTW9iRHNrL3dQU3ZINlhMQ3ZFZHRjUDFvQmE5aXdSUEFN?=
 =?utf-8?B?MHhtb1k4Yk1ZNzI1TUViMGkrczBBdVN0a0hHeVU2ZGs0MkFRd2pkT1lLb2d3?=
 =?utf-8?B?S2xSSElIeGI2NXlVVllMVHZJZXhvQmlZV2xnNHpWUFcwOU1rY0hlM015N1U5?=
 =?utf-8?B?VEtuWW1yRmI2UGR5Q3BXcERoWlFPQW1TVm9BdU1hdUU1SkNtTFY3ZkEzd1Ay?=
 =?utf-8?B?SnU2eXZuZVNocy8yQlhab1FqZjV2aDd6RFNtUU1NWnBmMHpSRGtQeUU2NU5S?=
 =?utf-8?B?NWw1UGpIOGRGU1ZSbVR3Si84a3lqd2V0UysxM2NnMnBFNFl1ZzZHWEhjcHBY?=
 =?utf-8?B?TDhNdklueEZwd1lrVXZxNnFqZ3E1Wk1hRmxDNHZ0Uy9rRS8yeEgyZDdmL2s0?=
 =?utf-8?B?K0RIQnhVVDRiVk1SRlB3SG9vQ0FsaFdqUzhMUkNVU3RnWU1uUHdZbS9STzBV?=
 =?utf-8?B?UXRZcHlueUdPNlByOUMrVEQ5bWFlK3ZKS1BDK0lKSDdCSXNkUUlQcGRBUWNw?=
 =?utf-8?B?WTBvMXpwVmdIY1NQWVhJYkw2R3VSUk40WEFueEU4bHp0WFRiK05CeCtFY0FO?=
 =?utf-8?B?VlFNK2NENU1nNVoyazFMVFg5S1JvSEppck5rRFJoMWNJZkJ1ZXN3TEVWb1pl?=
 =?utf-8?B?L0gwWitweVBUd0NZUDYvMGM4alNMSDFnM1l6UGRwaFVRcjJpbHE4SkNHVUdw?=
 =?utf-8?B?OW1sUE9VRTFYL2xFRUlDUm5KV1B2YWtlaGZjWWcwR2lhc2RVTDc1M25xS21F?=
 =?utf-8?B?cWwxV3IwTytyaUE1WnMvdTNDOXRtcEk2eXgzVW93RGpSNUQ3YWh5ajBXb0Y2?=
 =?utf-8?B?eGg2M3VZbWR6and6L2c4VTE2N1R2RnZLVDUvSjcwMlc0VloyZXNDOWZhRUlv?=
 =?utf-8?B?Zjd1OWQ1dlRCODlHc25MMW9qQTl3YVhWb1dwM1lFMnRIUVZHb3pBV3RmRTdZ?=
 =?utf-8?B?QlRYRGRlczhYUW53bTRNRFJiNGdYZHF2b0RQVnJialpJT2JTRUdRWHZWZ21B?=
 =?utf-8?B?SFVFOVFDZFBYTUhKNllpVksrU25uTDBNQjN3SXcrS2ZZbVhuSjE0cWgvSDJE?=
 =?utf-8?B?dzg4NEdDR1ZVVnBGdU54a0pteEFJY1ZaUkV6SGVFWENxVWszNkJRUHk3c3BP?=
 =?utf-8?B?dVNvZWFKZVN3QktiQXRiYjRrY2tBYVUxNEJlRjgwaHNFdUJoQ21VRmQxa21N?=
 =?utf-8?B?NnFBUFcrVnB3Y21RZE9GaWVmNjAxa1dZNnh2VVhlOGlGN2dEVWc4Tmg5ZzJr?=
 =?utf-8?B?ZTZBbGZ4WGhDVlArc1lQNmd1UjRDcEZZZnEzVGw2eXIwcnRDcXU4K1hiZVhu?=
 =?utf-8?B?eTd0a3FVaG5NeWdtblJITlhLL1NjQzBwdG0yc0xoSm9RV0NmUDR1aW9jWnlt?=
 =?utf-8?B?dzRRT2RJRlBlV1N6S2xXMUEycXBlK3g0OGxJcTM2RERpd1JGbCtDVE1QTVNO?=
 =?utf-8?B?NDFZNW9ZNjhLOWdrQ2NRdmRaakllK0xRNG1QcXQzMEpVazI5SWZJWkYxOVlp?=
 =?utf-8?B?K2I5V1Z4VzV5Yk9Ja0ZzY21LL3BYVE9INjRPeEVBZW5FNVNjWmdpR3Z3K2la?=
 =?utf-8?B?YytlbUI0VDRtb000ZWpjeE9iK3VadlBlcTRPVWVBVlV4ait4N0JqSmIvY3Nx?=
 =?utf-8?B?bUFTd0tDK1d4SWxZQ0NvbGR4c2JJZU45cllEZ0JhdkNZY3F5RFRjYThVbklH?=
 =?utf-8?B?WDZVcHdPbGNpTHM4cW1EeldOeldMcU82MjhyZi9zRkduc21KNGF6enV1ZHBh?=
 =?utf-8?B?RTZBY3I3cWtoMEJRTm1RcDMrSUtvU200RkxnWUJwMTRwclh2d2JEV2IxUGVh?=
 =?utf-8?B?U3MrZVVKdjBYMS83YUNGNG1SaHQ2N2RJcENiV3N3SVZ3OHhmazlkUTZpZmZa?=
 =?utf-8?B?YytTdC9vcG1KT2djVlpkbURxRG0rVW5wMjFoL3I1TjVWaDN2RDc4QU1iVXpF?=
 =?utf-8?B?S1lDb3hKNkVndjhPQTdjVTY2ZFBRPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xyyWqJ5tVveU+2oT3g3UTknN93il+wi+BNSGjeXE7UA7apudMWaeccfoDwKzWOelvbA0UYUOikgjHjLOBVXpMS4h3dMBwMN7hW2Y/ETzWXslkrB0jV7dBJ6b2XgYh30NLiUVJLA+KuBcd7DwxLY13hGm5JsEEGRToId3kxa7DaCINagM48Bo0gOCCpWjPwqSoiPFTib6wArSE8Z0Cui68nI2eaDr0K5j7lZCBTF975sdJTlo9yrbncdJKvCvuHhpxDEeO2N+StBKvMhQgIbXvJMz78yaGxkuT39YJ8+FAeOh4iYlwDY1YgK12nhTvgk/yhRT7dnNYV1g+87tmS1UuJ4v+nuCsdAjO47MOqEeZAqDZpwrfpdu3FxPF2Nex9c36tfegi74lTZTQfltMz1iZBIEPGOrfNz9soiKcklwB3aWufX/biZDiDNQe3pwT8uRV104+Q+u+NWm1/3Fa2144lO/ruTjDQX1ZF9ttEX/pxSBrwVao9UYbnpcie3homTW6ekAbm7X+PhHYPnzbUMpPhBxp5G03tJJdHSnOKGW9I+Hfbr0/3daaeqQs62z3oPk2KKV5RZHIhQuGn9EF+VDRIXdtkV+1sdGSugKcxq/Rk0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04db5b59-0ca4-41ef-1719-08dd557f4e58
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 09:32:22.2425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nyAwO3fqoXYsMZ0uNkKBN9gwnFJ+/LqO1fd3fx3212ycsgmwDA4x7kc4tWpZkT65pkS5rslui/rmH2yQLxsgJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4477
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_03,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502250065
X-Proofpoint-GUID: dCLoLFkpPXLQ3BsNrsiXEyhBfHdWMxor
X-Proofpoint-ORIG-GUID: dCLoLFkpPXLQ3BsNrsiXEyhBfHdWMxor

On 24/02/2025 22:24, Andrii Nakryiko wrote:
> On Mon, Feb 24, 2025 at 4:16 AM Pu Lehui <pulehui@huawei.com> wrote:
>>
>>
>>
>> On 2025/2/21 8:30, Andrii Nakryiko wrote:
>>> On Tue, Feb 18, 2025 at 10:29 PM Pu Lehui <pulehui@huaweicloud.com> wrote:
>>>>
>>>> From: Pu Lehui <pulehui@huawei.com>
>>>>
>>>> pahole commit [0] of supporting distilled base btf feature released on
>>>> pahole v1.28 rather than v1.26. So let's correct this.
>>>>
>>>> Link: https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?id=c7b1f6a29ba1 [0]
>>>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
>>>> ---
>>>>   scripts/Makefile.btf | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
>>>> index c3cbeb13de50..fbaaec2187e5 100644
>>>> --- a/scripts/Makefile.btf
>>>> +++ b/scripts/Makefile.btf
>>>> @@ -24,7 +24,7 @@ else
>>>>   pahole-flags-$(call test-ge, $(pahole-ver), 126)  = -j$(JOBS) --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs
>>>>
>>>>   ifneq ($(KBUILD_EXTMOD),)
>>>> -module-pahole-flags-$(call test-ge, $(pahole-ver), 126) += --btf_features=distilled_base
>>>> +module-pahole-flags-$(call test-ge, $(pahole-ver), 128) += --btf_features=distilled_base
>>>>   endif
>>>
>>> Alan,
>>>
>>> Is this correct? Can you please check and ack? Thanks!
>>
>> Maybe Alan doesn't have time to reply at the moment. We can use the
>> following command to check that in pahole.git:
>>
>> $ git name-rev c7b1f6a29ba1
>> c7b1f6a29ba1 tags/v1.28~73
> 
> 
> yep, I was a bit lazy to search for specific commit ;)
> 
> I like this command, though:
> 
> $ git tag --contains c7b1f6a29ba1
> v1.28
> v1.29
> 
> regardless, applied to bpf-next, thanks
> 

Apologies I missed this. The change is perfect - while 1.26 will not
error out for unrecognized features like this, it's better to reflect
that the feature landed in pahole 1.28. Again, thanks for the fix!

Alan

