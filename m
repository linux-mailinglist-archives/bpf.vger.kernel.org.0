Return-Path: <bpf+bounces-23027-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 036B686C4C5
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 10:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27A351C20EFB
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 09:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9827659150;
	Thu, 29 Feb 2024 09:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LzyEvfgu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LbTcVW5n"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1256758235;
	Thu, 29 Feb 2024 09:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709198285; cv=fail; b=TuOuy0QQ18vS34zF6tEDA7s4j4n5fzGDMgCzeiLJ1k6358EYBvdeZqfzdabOFbJy8P/KvHLwYTkT8snO1aEpaw4Qq+LJ7QNCh5vaoDat8z5Vh3/7nc1APC1OTRFe0ZuEkJjkpuTmfOGAqayVQcvrSh5FDQ71B20rYwVRox1FqU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709198285; c=relaxed/simple;
	bh=jxt0PgetA33dZYcH/oPEH+lgmATmo0jcIXhb36fQxzI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c9C8wWd86L7onLn87iyueYXT9qPm/tbaG0vhUArc6Nxc10TxrbOsGvwJfyUd2hJTb0bqOslCyerk4kcG8CkISvFWSfQ1hy/Y4uW6cmRGvKSn4XpO65IJIW9i9EfPk5HRzWGH4VVVj/UUqjfPlzJV3klTrQnnMxoIayH/5N07aPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LzyEvfgu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LbTcVW5n; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41T1xdah012468;
	Thu, 29 Feb 2024 09:17:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=R0v8TkAKlS5XDCNs9XvsCiuh5LqFMMn4PxVIYy2rG+Q=;
 b=LzyEvfguxtEyHgzmviWo5Bfp7VDkUlDNxBeaE3zSqRMSvxr8OMR1bUD2qL7ViAN2rFo2
 tG5MIWk/zmARb+2NJ0ivLdm/uJIaKRvYn1rd0k7kXMqoNK/IhTH+ymOC7/Ph2R/GicRu
 3YrnK1KaUUUpQ5zn+aF4H8P4OQ81Ejdx9qjFC48Did5KwqHUQjwt9Y7E6zisVkrQOM1/
 z0Z56jJMxZusK16x6ar87HQ1YnFCbL8VbNdaEVqvLGz/eCnK7Y5pPCYRZYP2eAVf6uOJ
 K3KgxCqsWhZ1MYQnvEf5sDnstwz9eON+5YOmirmrk+akIwI/BY19eaB43Huu9cF7i6hS bg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf82uch91-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 09:17:50 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41T94Sm7025496;
	Thu, 29 Feb 2024 09:17:50 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6wgpweb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 09:17:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RhNWULRmhclxmz6NkHO9yxd8xxg7Xof9VMnsTDE//dA66E+5X9EfUUBxIACfAzCoD/SvPnl3vdj/0Ka9joOJo8nXX8oAQjiRqzvPtBZP2Xe3/M+sCq7lBvNrl5+QFUJOb5/2E9287M2y6la4WzuPpv/wL+2Xhp1Bcp9gpMFuP3QHFin9GqnGqN6DUWsYp4gJ9Z2IkrV05pMpvEow5GU1a0h9werTXs/KCTmucc/7C8pVS6hTYAnc9mFf6UU9V8EqNurJHch0LIjUHywq5fsqnclysWX6TK8F3PIrXAey2pgEzc6fE+4ZsYPVsb4Q9TMjnDP8u5xk+5l2AHn9J1/xnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R0v8TkAKlS5XDCNs9XvsCiuh5LqFMMn4PxVIYy2rG+Q=;
 b=b0sSYccJe1pH6EnsxbmjS3N38hz6Gd5VhlnF0k/4S6VvHyvRYRkebT0ac6LKZSF9Yduz45S2Bz9J5BakmNh9fyHbdodItE07Y1nR+FJQOv+qdu7ltVHZWyDD4PNhz2QgtZs7qUjTdZuVzYRvXZLDXgoAuhZERVj8uhrfEZAk6nGTNSKM3Io3NkYUZkiATtakM3T+JRNIOa0Rlp8h5lqZiSsHpj81k3Ybgep2SaUtUFwA34qFHm7DP3NK7/LsMPCpqiLQpws7M9g6A0ECQchZ/JuchK0gRa5ZVCC9nwALWgff5uAAparfxFtQyYz8wcFrVbbHNPK/tthDvYVVQ7jL+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0v8TkAKlS5XDCNs9XvsCiuh5LqFMMn4PxVIYy2rG+Q=;
 b=LbTcVW5n4RC0s23/3lkTpVmX5qalaCE1PSaJLaKeunabPNXD8m2IKerAtwdk3mTMGs8z7Lb8utIy9JjO/vNBFTadU+l3J2U+CXP66Nc178FXVapsrL/wRn80SEjaTgOcBUCt0+uzqT+E0IERwDvBPf608ubPZH2mauLKUHMZ/w0=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CY8PR10MB7244.namprd10.prod.outlook.com (2603:10b6:930:6c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Thu, 29 Feb
 2024 09:17:48 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b3b:c19f:bbba:7f70]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b3b:c19f:bbba:7f70%7]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 09:17:47 +0000
Message-ID: <34157878-c480-44bb-91d6-9024da329998@oracle.com>
Date: Thu, 29 Feb 2024 09:17:44 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fix linux kernel BTF builds: increase max percpu
 variables by 10x
Content-Language: en-GB
To: John Hubbard <jhubbard@nvidia.com>, Jiri Olsa <olsajiri@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, dwarves@vger.kernel.org
References: <20240228032142.396719-1-jhubbard@nvidia.com>
 <Zd76zrhA4LAwA_WF@krava> <856564cf-fba4-4473-bfa9-e9b03115abd1@oracle.com>
 <983b98db-79c0-4178-b88f-61f39d147cf7@nvidia.com>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <983b98db-79c0-4178-b88f-61f39d147cf7@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0482.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::19) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CY8PR10MB7244:EE_
X-MS-Office365-Filtering-Correlation-Id: 9796321b-b139-4030-2c33-08dc39074b83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	iruO7lj5Wzxer82rN0o/tmkmeEm+VMPx1EaQvoJcDe9k1BNgpEogxqoSRXyyRH+bUzi3Fn4AgoTyLLzIe7B1gOBhzNJsymAgk7AC4fZx9yrgzBQfs1+ykKywD5zrb7+9/Bc7rZW41yb7FyzyHRAza9/0+f4+C5CCgZBaAimsXYljW1Ml9zSQladKxavLSpwNUcB6jRn7CJSGXY/72Bf5NRpqXMJ1sdS6XOeQ9s94cIn+bmnbFGrg3FRrGnFEuGfZbNZhzHIVZ5GbrFfP5xR6RQVY2UZRF9KSq18EjoG8iaFciTdQSRM3ngRdvoyoDlAhvkk4Kf+wFyFwG2DzLFu7TDeTsRhgiL3TDQsu0JmVMaWvGhHWn5uIDMliOp7hPNWM7ZC1wvT0WArmi1LquBpsO2FJtPQqsHDfAlWCYAfPR6asNZXvFLfFhJc7YH8YRtebdAGyFjgxfvIT/NuxoNpEcllFTnJy+B7CifxqfZX9R/RizHH7/Z0nLv4N+KJQ8gj3LdPaSBjLxmZTaJyowyfz7tCq3WZ3M7tYL7/y4vzTxGkWEExvVlGpeukluvC1Qge67/y/kDg8rn9udgzjox6gvz7r+Id9szdOtT99Xs7b59cPa012vz33QPdtUg5gALiokIbWKSjVlhQczmafa20cAQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TUU5YkRreEIzVFF0U3ptTlFDdkY1aDhYR2pYa0NWNm5VSHhybVJ2Slc1V3lI?=
 =?utf-8?B?UEdxRlh2eG4xSFdHRU01bmpOb0hlblRtemNKMUI3WXY3S3Y0MmEzNkpld2Zr?=
 =?utf-8?B?b2l6YXF1bW42M2h6ZS9NME1YWVRDbHlFd1ZMVFZRNmZWYkt3alo3QU1qQmVW?=
 =?utf-8?B?aHpOZVJsQU1lc0R4NDZjMGVTVkI4OVZabmM0cVN2ajl6enQ1LzlHai9Db3FB?=
 =?utf-8?B?dEFJdlF2a1FoSmN5Yjc4K2prN1NWUVpUTXYvOTZTR0dRd0g4RGx4WTZ1Q09D?=
 =?utf-8?B?dlVBZTBodE9RaSt1dDZ4THR1WXhOSURzTExObzFqVkgrMnVPNHdoOEw2MHNW?=
 =?utf-8?B?WlFOZERKS0VXVWRwbUhkckJrMzFZb3hTVmZLZ21sU1R6LzJ0TjQ4K04rR2VH?=
 =?utf-8?B?WlVBZnpBbitYR1daSHhla2l2NHRLUlYwR1dPTkJrS1J6djR3UzFCQnVOWE5E?=
 =?utf-8?B?NENNUXVjamtxeHRzdCtOcURwemlpT1ZicHFOMDMxenlnOXdIR0d2UDdFRmtB?=
 =?utf-8?B?MG41TkJSWXFndEUxbWNsOXQwNklYUm1QTUh2cld5SlVVcHdmN3hkMk9JVkVU?=
 =?utf-8?B?VnVXWjdBSG01Ti9VN0FIUWl3ZTVHdmZEV3RqbFQvT1g0UnVtOHRxTjJmMVNZ?=
 =?utf-8?B?bGg4WGFYVG8xMG9rWFhEN0pkU1c5bitUNWJHTGJYU0VodVdTa1FpOGpUY2VK?=
 =?utf-8?B?OGVreWdYZmliaGpJOXlHYlhrU1UwNUQ0a09TYnFHQTdRb2JwWUlGN2tGbmI1?=
 =?utf-8?B?d2hZRjVKZ09McXkzQzBRR1l0TVNpbFRkYTUwTDhUamxlaVlUWklEV3F5eUlR?=
 =?utf-8?B?OXRpdk5Nc0NtNDJEWDFsVDVFdjNjM052S082b01yNkdac1JKNitNVkgwcTZX?=
 =?utf-8?B?NC9QbEhjYUNaUEJpcGpVUlZ5Ynl5Z3U0dXpYT3h0NjcwN3I1OFp3WElBcm1s?=
 =?utf-8?B?ajJWLyt6d0lFa05hVGxMTDF5U2NIcDN2WGw2NDlxUTlJZ2ovc1FFY0RsTE5X?=
 =?utf-8?B?Nzg3Ym1SVHJkQk9Dem0xRUV2Z28xS2o3a1l5QURWQjNqVEpjbXhVWmFXV3Zv?=
 =?utf-8?B?MFdabS9iaGdIaWVlMDJScTM4ZEl2ckRMa0ViM2ZqKzZyMVBjdXJjNXFQcXNJ?=
 =?utf-8?B?UjAwSE05SEFEdHdSVGc4OXRlbmZ0d1pPWnBuR3pNWUNSalNwTDZaKzBEY2F2?=
 =?utf-8?B?cFM1Zk1MSjF4TnZEYWxVUWVMSnYzcEhkeEN4aGRpQUNzZWdPcG5UMytkTW9r?=
 =?utf-8?B?TEg1SzZLenAzWk10SVcwQTRLRE42Qzk4VTdCa1pwNWxsUXVTbU9WVU5UOEZm?=
 =?utf-8?B?bTRyWXhlc2VwK0dJTzZhL3ZLcFBIVmZESkVMWWZYNmlhbyt6Q243UFNOSkZs?=
 =?utf-8?B?YTdWaDZ0NWdrWm1XVU9kYWFIYWZsa3lmSHR2UmJvZGcvdXdYR0hISldrSFFi?=
 =?utf-8?B?RDdPYVE1UHl5a1dSQ2Jza0NYRWJwOTNMN3N0cEZmK28vYm1Qa2QxalNlbzBK?=
 =?utf-8?B?b28wMnRtdWpxQU4vTVF4VThlcU5rZGVOZGVYUEZXOUtuUmJKWWRUZzNVdzR2?=
 =?utf-8?B?MmZaS0FYaVNHakZXWVpPM2hMN0w2SUdMOVpWV3pLMnk3UHNISU5HOENsVXF5?=
 =?utf-8?B?OEJDU0cyVTRLNUpWQi9GanA4Z2RLWjB4NjZwV3VXS1RVM28wR0VOUnJ2U3Vz?=
 =?utf-8?B?ZEp5YitYcHl0cEZ0NEFBV0FFWW9KN0EzUVRrQ2NRTS9Ralg2ZGdaRWsxRDdr?=
 =?utf-8?B?TnM2bm55elk4bVVzOSt1Myt1VVhOaEVYamhQejBjQmNaTmI3d3c4ck4zQUdl?=
 =?utf-8?B?UGt5NEJxeUphQjZhQm01WnZsKzNjUFJJSENTV3FjNmxMcE4vdXB1aklMRlFN?=
 =?utf-8?B?aG1ibERYdkc1N2NVVzhhdnVkWE54czJBNWFDMStKdmpmV3ZidXVkdFNBUlk4?=
 =?utf-8?B?TmZYVnlIRHlUSUJsdTFLSEZHVVRKN2Uxa0VNdmQrZHZPUGxkTzMyNWFGdHdG?=
 =?utf-8?B?NFVETWlpN2RXUU83N3E0L25ZdHVHVlRNaE1hbkRBKzk3OFc4S3RIQlZYQWNl?=
 =?utf-8?B?VDV3eDllQkg2akQrMU42S01OY29zS2ZtT3h5QXJOTFgxVE14V1JPNytOVzBo?=
 =?utf-8?B?eU9vcGs4TjhiYng1YUZKNWIzSTZwTlNqSG9IUndiNStOQi8xR1gzVm4wcUJ4?=
 =?utf-8?Q?UMPxXOsYjmPbTlC4TiBCdzw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	2rlFgKf3WrNwVmRu/hSkhNmUffiSR8ephq/xBCRDmOsjztML4wvxw0bPLE1Emekmi0c/mSPXkZgI/POh9NyTEy1Q35nvnfjpwlegr05WU/8JqvzfleMwh3JEMuEd4dcJT5cXnrlepLXLavCpQE7juR/PPzShXya5r3DTWwUEeAJpkwbm+w1SnvD/f1qxT/pnSRRjcRgKzTfl0Y7pAByr51+06Wzt1rtEs/KN0oKvMiH5rI6V1kboaOf0q5bflcFoEmBmIW8rfPO5gGj0w8XtthRB1U/OqdHPYfsAovVck2ucsPqWF98Dy246qTBSIq+/xJs0/4jWjYQYyX2LqwsHgJV5Z7oSAwVU2nHAF/1pZrnz5/ms+VqG3NgXiIZlronKWzNo9ZvgSfLLtHAsbD4TgMM++KO3sBU+mgekYNv6jTRmMLi4XWAygQCzAY3CdrFPnf3suzmWnjsSynbfidRaqGiBqBqibdyowMiFhO4U1knlyh9/mzultWFthD9McvwHqn06Kv3VytqRlwMAwUcR+0R02KIR0oi4ar9IZSrHLIoy20qaEpodel2NwTtaxiNujw5/l49zpDer16KI330PaCyJs6CS7c+z/cCu5kzOU9g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9796321b-b139-4030-2c33-08dc39074b83
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 09:17:47.6054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tsfMBN5gpi7nPrXRec4LwKymul0Jfr5ToLXIi0aJCR47FL7bvsCowQsm4bm16obegcbJqEtMmxNeM+BtYzIRDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7244
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_01,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402290071
X-Proofpoint-GUID: 7usWozouejJDCoANSD_-P_QJxZA_tRKA
X-Proofpoint-ORIG-GUID: 7usWozouejJDCoANSD_-P_QJxZA_tRKA

On 28/02/2024 23:21, John Hubbard wrote:
> On 2/28/24 04:04, Alan Maguire wrote:
>> On 28/02/2024 09:20, Jiri Olsa wrote:
>>> On Tue, Feb 27, 2024 at 07:21:42PM -0800, John Hubbard wrote:
> ...
>>> do you have an actual count of percpu variables for your config?
> 
> That's a very reasonable question...
> 
>>> 10x seems a lot to me
> 
> Me too. This was a "make the problem go away now please" type of "fix". :)
> 


Running

bpftool btf dump file vmlinux |grep "] VAR"

...should give us a sense of what's going on. I only see 375 per-cpu
variables when I do this so maybe there's something
kernel-config-specific that might explain why you have so many more?

>>>
>>> this might be a workaround, but we should make encoder->percpu.vars
>>> dynamically allocated like we do for functions
> 
> Yes, that's a much better design imho.
> 
>>>
>>> jirka
>>>
>>
>> Good idea Jiri; John would you mind trying the attached patch? Thanks!
> 
> It works perfectly for me. For that patch, please feel free to add:
> 
> Tested-by: John Hubbard <jhubbard@nvidia.com>
>


that's great, thanks for testing this John!

Alan

> 
> thanks,

