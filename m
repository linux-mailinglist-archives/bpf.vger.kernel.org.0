Return-Path: <bpf+bounces-71601-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F13D9BF7E6A
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 19:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AC94188F3A9
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 17:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FAE355817;
	Tue, 21 Oct 2025 17:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="p6G4fiS/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="d5fseBje"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F91F3557FC;
	Tue, 21 Oct 2025 17:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761067692; cv=fail; b=p4gyNL2uremGtnCKrGltfOSNJl47IAOUvtHbaIJ1FT27mJ7FJVZbBZcsvfYRYFHgHkz82QqIAhDzeRySjAsnIgqTV1rL16rD0Qa2s0W0cy6KsQIfehWvblBy/3gsF1qMW1tpz69lqLQ0DbSV+k/LNmQZVpga5FuGS6TsJNshxsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761067692; c=relaxed/simple;
	bh=Bn+z9ZSTXlhx3crtkOWNFmkiUSsKr3pBQE5we87xKD4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NVCAUCDl7lZeHgYXZiX2MohW4sHMLEqdER77abpOXehDlwHQubORoAFDrO31nX4xtavabRG5uD1buIhQbDFl6GEwIkke5UnnmTI5NcYwjJU4zwq08FJUDZPeIIZh1OoahZHExDvlSNKMa7igHV6CW5aKidqj+u9O/Lb6HespcTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=p6G4fiS/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=d5fseBje; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59LH4GWd013637;
	Tue, 21 Oct 2025 17:28:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=5Fr59o+uCU8DnMSeq2pSViBlz2lKmnheViAc1nnLFH4=; b=
	p6G4fiS/Ptuh17RVk7w77KjCsnTGi8Il3DDigsDtsNGL7FqgBD8O0FLculoFvfJl
	BIJopCwwWVC5wCm/ppnxzgeztOzerlCYkHYbP43QJ0bxl8xy2yyxmYIqDsOcOHXy
	Yn0NZyxWeHMFDg6gIMl9T9g3txQoLvdM4l4TYWZ4vELbzaF4hh217O/gSP9jebtX
	WLKpo5wGcsdVOSbgkXrrcZGjDUgyVWC+6on5B8ty9inXbW32AdkDv3V065U52gbN
	X5X2QVUHltNHxX65Q0MWwMJhvP+63fTrgzP/wv+qQDMn0+gY1shW6E93mlUhzm/3
	atXcJ2bGQM3gcDPmGFVdCQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v307644q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 17:28:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59LH85JU013650;
	Tue, 21 Oct 2025 17:28:07 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013039.outbound.protection.outlook.com [40.93.201.39])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bc49pb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 17:28:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OQfvJGqCFEwqTOvjZ6Y+hrEvvKiRBJWl0DWUKGty3HsVYIAyzhNG1mpoefbgNUNNd2m7DWNw/WYXLz4sfMblz62108HjJmlrOKMTJZKfSTlL4WEPE/nFT13LZnxCttmvMM6dDI+gxFscbJ04hJjM30vBfbK1rNbavr40JLKv+JqXPi+LuNrgwnzvm/Jj4zd34oSFMd+8nMMjit15O+PCyj2ItkAvfZu5IXEBMu/3z7lWKsJUCNurZtmQAvQ3Y6qJg8F11DF9i5bbmWomGUCKtizzVmh0cQS8/9ucr/fgrURDFs/z8VxPomdJpcI6Gj0R2coSt/gs0E/W/+qYbDrp5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Fr59o+uCU8DnMSeq2pSViBlz2lKmnheViAc1nnLFH4=;
 b=CcZvjYwEe0najXW+a9GYXQM8zoaq/8VRTE6mrb5cwMYhwHP6lhtDJNXirDA1h0jzE/ypvaWmQt7+T1xG267G2T2Ti2ff+IgvYO0IFAEgWePzYjA4PZEXyXXmxu8Wp1rJfKIlWmIa8/FOEPYkiUMrzFss+oY01r9XSlW6T93hdqVP6uvLOdccte+cNnkoJ4khfWs29h87W3PI998f+ln57X2ve5s9fN1bYcIQKhKrbn2KgH1PdlDJDCWhOWl9OEmeUh6UcgS5NgV0lDgRGNSkgbWDOUlSwzMcoE2IIz++cevOgweK7Uow0F5jO2HIKqWks+FLAZ7oTn3Stk4bpOuzTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Fr59o+uCU8DnMSeq2pSViBlz2lKmnheViAc1nnLFH4=;
 b=d5fseBjejxF4VQX4EVcSvGjiS2GhJq8IflwI8gThQ6sflCfcMNJrV5PYoMswA06WkKxL2qDmGV8yAOvblBxw3mnXSPFcORCJOOAQbLCkG4TOJUG3Sn9LGSyPsy9ftxPvL0xRVrUWE3ZB3HnohWR0+gcsAOFdL5rszf00V9I2FRQ=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 IA1PR10MB7213.namprd10.prod.outlook.com (2603:10b6:208:3f2::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.16; Tue, 21 Oct 2025 17:27:47 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9253.011; Tue, 21 Oct 2025
 17:27:47 +0000
Message-ID: <e8b8b84a-b132-44f0-827b-668f32755ff7@oracle.com>
Date: Tue, 21 Oct 2025 18:27:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 5/5] btf: add CONFIG_BPF_SORT_BTF_BY_KIND_NAME
To: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Eduard Zingerman <eddyz87@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Song Liu <song@kernel.org>, pengdonglin <pengdonglin@xiaomi.com>
References: <20251020093941.548058-1-dolinux.peng@gmail.com>
 <20251020093941.548058-6-dolinux.peng@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20251020093941.548058-6-dolinux.peng@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P265CA0025.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::6) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|IA1PR10MB7213:EE_
X-MS-Office365-Filtering-Correlation-Id: fc783bd4-0dc7-4d52-1ae6-08de10c726c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d216T0J2a3pZR1ExZDhkR2k0NEl2ZzRhdndIbXdtcW1lQzl4UXpURnFoQ0Fn?=
 =?utf-8?B?WWk3dWZOeGdMb0VzL3E5VEo3bzk3Z3Q5MkFLRzJ4aE9JeFYycEhkNHN4VzA5?=
 =?utf-8?B?ODNaOWs4QnRXNWs1WUlncnFtRzdVcVNhd09tM2FjOHBnSkw1TytnWkZzVHBV?=
 =?utf-8?B?eGFVdjJJK1hRNGNuVGNsRkRCWnl0ZzlCMjJXb0FKSTduTHZRelZ4WGJpVEpm?=
 =?utf-8?B?RGdrMnBuZnVmWFRxUmQzRkZHR2pmMyt2Y3A0clFrNkdMVkxjamZQOE9nd0sv?=
 =?utf-8?B?ZDdsUlNRZGdaQ2szUzdpVzRXSGkwTng3UkZ6TUxWeGZkaXNVUG1nMVFuZEZR?=
 =?utf-8?B?ZlB6bFNITk1aZ3hCZFZiZWNWbHZ4Ukh1VVlLd1VkMXEvaG5XZkFFa3JldGo4?=
 =?utf-8?B?L3pRc2hnQU5WN1Y5b2VHbHZaUWJPTkRraE5aK3h5TCtBdXhsaUh6NWdBZHNF?=
 =?utf-8?B?QktoLy9naUh6QU1uQ1Q0YmtzQ3lVU3NnU1hRc1dlTHNwazUwVHVMOG9xZXps?=
 =?utf-8?B?NllZeXZyMjBYVzNWVjFQbEVEZVFSTGQyWjJLQzlETFVuVGs4TjVyS1VaSzd4?=
 =?utf-8?B?OWhjTDNlZFpDNHFJVFViUy96YWpyUVRZOElLRHdPRlpDTzg1aHVPY0xsaVd3?=
 =?utf-8?B?cWF1elFIWWhJYVlQbS9PUHIzcUd4WnJSSXB5eTBnWk1RQzdiTWtOZm9BYjVL?=
 =?utf-8?B?TmxLdlQ4K1lhOUg5TEVrajRodjhjUjJKc0Y4SW5DckhDRUI3czQ5R0gxN0Vs?=
 =?utf-8?B?d3NGRVZVSjdsOXcrMFg5cWdzeFZXaFpKSjB4aWFlTFlpcXlZR0hNaFlhYjAz?=
 =?utf-8?B?T2FWWE9RNkFpbjZIeUlBZUNyZEcyN29YMmFOMzc0cnJxTCtVUk5NQXhYWCtY?=
 =?utf-8?B?cmxxK0hGdUprVlBCMTF5aEljcWlmNXptVlpIR2tqbkVaWTFkU2xLZ2ZoSVZp?=
 =?utf-8?B?a0NBajcycFlmdStKNnZXMExuUFdubE1BMDlDMDQwcERPRGhKWmxZckdZMVph?=
 =?utf-8?B?c2hxa0xFUmZWaUtiWEhwZzQvWktsWms2QTdva25XaDd6UkVkaFJpMWtVeDIw?=
 =?utf-8?B?NTdCbi9hVkRwVGRRdHJYYmQveVh6bnNGcmhEbC9HNk0wcTdYckRZUjNsekd6?=
 =?utf-8?B?UERPelFGeXY0eEFuV2xwaDhUZmo4ZUN0ZFQwRG1SL2Q2OVRNdW1CME5NbWlx?=
 =?utf-8?B?S0NOT3RlODhRNWY0Qi9kRjZ5Wi9rZTJ3dGNhK2Q5QWNOKzdsM3krVWV5SWFy?=
 =?utf-8?B?WGtHZ2p0NmNVNkFnS0xyTmFxZWpmb3IwWEVtcmlqcmhuQnFrZ0N6ZEo3ZGQ1?=
 =?utf-8?B?SWdWUlFsVTJrQzhSci9mZGV0KytjeW5mZWEvSi9acFpMbjV4RjcwSnB5Mlpn?=
 =?utf-8?B?QVlsMDZmRnpLeEdCcDd6N2I1OEhrT20vQmRCdHpvT0hzRkZhQURibHI4a3du?=
 =?utf-8?B?K3YyVUxJVGJRcXlOOXhaMVhmRFdJK2Q4NFBCRDRuaHcvNnRYQy9sZmpNSSs4?=
 =?utf-8?B?T3VHQVhWSDJQSk1BWDZVZCtUb01CckJVNGtyQWtZZ01QQWEyVXZvb2g0Z0pn?=
 =?utf-8?B?VnhnazhXbDI1bXAyak1iczFaS2F0N2szaU1rU1hudnhsaEFuajFnNnFON2gr?=
 =?utf-8?B?YXRuR1hkTk1POGxoeHlEblRjS1QxQlhYVmF0UUJWRTQ2N3ExUE9lVVo2TFN3?=
 =?utf-8?B?Y3QyS3NrU1pNS3JPQ2pzUkI0YUR1N3p0NG5jRGw1WFFXWWV2UjZVY08vQjUw?=
 =?utf-8?B?Y1Q1N0tzQWt3RWx2SEl2QmttOERlclZPV213d0s5bHU5Q0x4cWd3T1VxNmdT?=
 =?utf-8?B?d05vbUgxeFhHMDBmWnk5WE15VW5WRkNXVEc0d0JYRHlVV0g1MWZzZVNWS2M4?=
 =?utf-8?B?VzZ6aEJ0MWpmVVZBV0sxd0E3SlgzMm5iQjhQVUxTeWNvdVpIelprdmcwU1VQ?=
 =?utf-8?Q?cMtjRgATj1xAlLYE8duz1p6MCOBRTNq8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Lzk4NVFBWnhnaGQ5TlhRb2MzNFhGSUl6Y1dtRC8ybmZWNitSMHVaanpWa1Ba?=
 =?utf-8?B?dE9NVW5WdmwvOUpjWUp6ZGpNeUNMK24zUWhnSGloRmJ4WGF6NkpwMER0Vi9k?=
 =?utf-8?B?b0QyU2x4OTBCVWtNMEw0WFR1MVo3TVFUZ3NUOGxML290VC83YXh2eFR3Y05Q?=
 =?utf-8?B?ejNGQmVMdEFML1g5MnJMaXErTWhSWTI1Qm95cmppeS93UHd4TGhqaFFocU10?=
 =?utf-8?B?NEtvTWc0Yy9tbXUvaVVzWlpMMWg1M2NpRFJTZ2R3QXZsa1RSbE51UEh1VTlP?=
 =?utf-8?B?R2JmREhpcHZuZ2pyODFRU2NNNTl1ZzZrbm1yZlBtSHpDMndRYjBQeWJTVlN4?=
 =?utf-8?B?eUM5WE9GWi93WDdsWjhuY3J1RC82WnovTmRmYy8rNHNSRDdKR0tuV2VjQmpM?=
 =?utf-8?B?Qjc5VjhtWXhXN2FUSU8zeGEzaVF6VDZvSk5sS3NEOFBOdHlQWUVKUlVvOUFL?=
 =?utf-8?B?aWdlRnlxWHB1VnJPV0Nyajdyb0oxUGN3ekc2UGF4d1JMdVVVWnVtWW1sb1du?=
 =?utf-8?B?dHJXbkR0ZEV2TU5xYTJMTjBreXdTQ01GZXlUc1V2RWpPc2V3MHRKOWNHV3Uz?=
 =?utf-8?B?MEcwNWtIa2pXNG90dTV6bkc0Z0s3WHRac3I1UUNocTdFZmtIMWFESHRhZkVM?=
 =?utf-8?B?VzdtR1Z2V2JXM2UwTWxKbm9Zc2t5aW9YRzZIamhpLzlrYUFZR0s5eUE3dDUx?=
 =?utf-8?B?OWttTGlKTHpPTm0rWmJaeW1zS2U5U2dBT1BBeGNTM3IzdGhWbFJOYkp1UW12?=
 =?utf-8?B?YWtqMTgrdUEyNTZTSGpYMGo1WjhmbGo4dnhuNW5wY0MvUUlDTlZ4citUYTEr?=
 =?utf-8?B?SnpHM2g4Wi9jZVRZd1FTaVNlMis2VW9lbXcxUzVSaHBxZnBYWW9LSkhET09S?=
 =?utf-8?B?OGxRQWFodW8xU2tyUjV5MzlLZXhzS1M5SnFrMkNGc3ZxSlM4dE93ejJpK0NW?=
 =?utf-8?B?M1hycGZ0Y3hDL1prdW9FNjlvOUp3VkV1UFRzbFRPMU1uTjl2cmdEYWhnc0hT?=
 =?utf-8?B?RytZSFlOR1dKOW9GRkxVcEdUWnF4ZEQvTkxhSWkwejFWckpjbW5yY2hMWEVR?=
 =?utf-8?B?UC9NajZyakFjQUw3T0VkcCtkTnNwUnExUnhkQ2xHRkhxU0h2MXpwb0lGZ2Ur?=
 =?utf-8?B?NnJ0dExVcFFoRm5wNFJjVlAzR3k3UmNGdEtmc21aeUorVkNRZERqa0VwMTIy?=
 =?utf-8?B?cGVBVEVWY1UyM0Z0ZlZUZ2wyTm4xN1pSYmV6MmFHdkx0Z2ZsR2hnZWRIdFNJ?=
 =?utf-8?B?ckxabGdqTFlWM3hjaCtEbXF3RTRSSGlvUm55WXRnWm9CTGIrdzFXSERobTcr?=
 =?utf-8?B?bjlEN05aVG94K0F1a2YvM1pqTi95Rko1bkJRbzBJRWFWcjFzTkhaeGJ0VUNJ?=
 =?utf-8?B?akZHaUhJRXR0SUw4K0JXVGI0aEpMR3RtY2lIdEYvWjRDTm5pV1lOb0hTcnRZ?=
 =?utf-8?B?eWJDZVNicGZqS3lkSDNOU0J4K2dBU2NZYjlBcU9sZDk0bVZDTi91cXFzNW9O?=
 =?utf-8?B?K3JvQUsrZG9lb2t4TlhZRWFyWGxYWmVsMDZwVkJ4NXFkUVhCNHRHdTd0Uktm?=
 =?utf-8?B?RjkxVHg2OEFPblMxQlF5UWFGc214dHZIS0FTdnRTQVU1dnE1NEtMZmoyUTBJ?=
 =?utf-8?B?WjU0b1VvZkk5QWZ6UFowdjMxd0tiYW5XRmkydlF4VWx3SkZ0K0p4Q25XVjlx?=
 =?utf-8?B?VjZBQlVUd2RRM2x6bkVmM3ZlcFlUK2RkSUR6MkZLc1hKMVNteDdjdkJSU2k3?=
 =?utf-8?B?Mk9ZWkg3SnR2SFBIQVRGYk9LMFRadzVsaEVGWWdQaW1tclpyVXNpT3NpRFVp?=
 =?utf-8?B?azlFaWdxaWttVVd0MXF2Y1BkRDE4QVBvOWJ6azNZQXhGT09uQ3duZnlaWVk1?=
 =?utf-8?B?R3hsODhIRDZ3VE43MDBRUTlETTkwWmhhWFRaemRYaFA4YmFSOW5Dek1zdXVq?=
 =?utf-8?B?WlFwRmNvVVBTQ0lEREgzWXdwc0VGM1V0bU9IMWJ1UXMxT0dQdGd5SFUvZytk?=
 =?utf-8?B?ZHpjL3lJMmZURHVtT042SEthc0NuZjIxYXhhdEdTMUhqcDdMbjd1cGZvYnU4?=
 =?utf-8?B?dXBCODRRcTRERkVhYnBoZEd3MTRzTklQOXpBR29zYnpnK0trMjJOUFlJaHR4?=
 =?utf-8?B?aFR3WXlkSCtMSU9CK0NEZ1U5M3RQYitMQ0xscDhCYTJqS2lLaStKOEdqU05u?=
 =?utf-8?B?ZkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	17U4udAnlERjUYZ04wyOHmkmEHslq3LxC6qDQL/MEhofFZoLmSNGGCyG2EHBrj7ugHrRpDN34IkZAArcJghNNkIluM4z2eGJRCB84DWSGIQRHvWhXsS35FCGGF9jdMgIJf5bz5qu8SXfFw0x6+ljkCO1+28vXjBT2vJwMecm2ZUTNPjWZ84nmfAwfhFqX+OIaQX/m+7LcETPP0mnpfCQduLdPQs2fMkI5ADRnOOXUwImmASGvCLKy62NhzmAhIISR9gvo7EoZW0mj07KQCsbWVhDfApYxJZv85KEIYEqj/+UfzuM6db+riChTN6y5LdDOuZuMXmECLW7b3sA994MBBDDcBrcfh95VqSXAtmyS+EMQbuwV9+ENNX//OnJbzMMoiJwwCmmQgDtt59YNnZcBFwOVq522MewwkuaAETeNuIjB6WZ0/aO//ZdgY+T5ZrHzgbvV9Nb3aqNffk3IzeCtbSdKAW63Mm3mCGp7Z+AfK6ZhAWbiNaNJZHtsr7GsRfiDFNVUGX1jNST836xkZdKm5Bgb5+zs/8oblwGOeHSchRYnVsxm/9AI/odafikBFdS4KtOvsR6x/PycFkRi9pUfLTq5pudO6BcIFOTn4iMSsA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc783bd4-0dc7-4d52-1ae6-08de10c726c0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 17:27:47.0969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uLRFPZLHKbQ7+abfS/JdH2IDgspLxauJHJszZ+rhZ/f+XKuCwuvEr0lA85XHgsrYLaAt34cVXaigCao34G7Ecg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7213
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510210139
X-Proofpoint-ORIG-GUID: IsfDlU-psroNF9Nmt1VAfAvAryBgeTUo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfX8P4RkHEjFCbE
 K/hly2KbarY9qZ9YgCUJ7SYVROeVu5FCvXUK0JfYl31IMcGHBwExuF6I/888DKibu+MOvoIhMLz
 z+6x/vIXLciBgV4NKA4uL+uvPkhLSIPNiKzvbddOFlkGgJYQ4ns8ww+kI3epV8fZaFwtro31xGM
 N0Ag28Ra0+Fanjx9zCqA/RTsIBafk464emw8OFmeAdL/TJaklblMP8/yQo0eDE3dOZyny4E9DXO
 h4/KzCUK+mUMNs0MHNyO0pIwCJQC9r/hlclceiubHjdnAWButPvkv3gVyWOXhuI8zs0rOIdxfYO
 WXA9YNLRL86dTljBu2mPauIJhvVaFcT5ILRBabHbaF/YZFmLYOTYetoZNEJVo/ywh+Dh8hbyV9v
 UFG3veCid3+2nCcs5CdTT6Qq3uVUmg==
X-Proofpoint-GUID: IsfDlU-psroNF9Nmt1VAfAvAryBgeTUo
X-Authority-Analysis: v=2.4 cv=csaWUl4i c=1 sm=1 tr=0 ts=68f7c2a7 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=IeNN-m2dAAAA:8
 a=L39iWhfrDxcwn-j_GCMA:9 a=QEXdDO2ut3YA:10

On 20/10/2025 10:39, Donglin Peng wrote:
> Pahole v1.32 and later supports BTF sorting. Add a new configuration
> option to control whether to enable this feature for vmlinux and
> kernel modules.
> 
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Song Liu <song@kernel.org>
> Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
> ---
>  kernel/bpf/Kconfig   | 8 ++++++++
>  scripts/Makefile.btf | 5 +++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
> index eb3de35734f0..08251a250f06 100644
> --- a/kernel/bpf/Kconfig
> +++ b/kernel/bpf/Kconfig
> @@ -101,4 +101,12 @@ config BPF_LSM
>  
>  	  If you are unsure how to answer this question, answer N.
>  
> +config BPF_SORT_BTF_BY_KIND_NAME
> +	bool "Sort BTF types by kind and name"
> +	depends on BPF_SYSCALL
> +	help
> +	  This option sorts BTF types in vmlinux and kernel modules by their
> +	  kind and name, enabling binary search for btf_find_by_name_kind()
> +	  and significantly improving its lookup performance.
> +
>  endmenu # "BPF subsystem"
> diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
> index db76335dd917..3f1a0b3c3f3f 100644
> --- a/scripts/Makefile.btf
> +++ b/scripts/Makefile.btf
> @@ -29,6 +29,11 @@ ifneq ($(KBUILD_EXTMOD),)
>  module-pahole-flags-$(call test-ge, $(pahole-ver), 128) += --btf_features=distilled_base
>  endif
>  
> +ifeq ($(call test-ge, $(pahole-ver), 132),y)
> +pahole-flags-$(CONFIG_BPF_SORT_BTF_BY_KIND_NAME) 	+= --btf_features=sort
> +module-pahole-flags-$(CONFIG_BPF_SORT_BTF_BY_KIND_NAME) += --btf_features=sort
> +endif
> +

perhaps it's useful informationally, but you don't need to wrap the
addition of the sort flag in a pahole version check; unsupported
btf_features are just ignored. Also we're at v1.30 in pahole now (we'll
be releasing 1.31 shortly hopefully), so any version check should be
v1.30/v1.31. I'd say just leave out the version check though.

Alan

