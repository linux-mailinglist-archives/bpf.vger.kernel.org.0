Return-Path: <bpf+bounces-49349-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC6EA17A01
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 10:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56D191887480
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 09:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A011B6CE9;
	Tue, 21 Jan 2025 09:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b="Fud28zFB"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00007101.pphosted.com (mx0a-00007101.pphosted.com [148.163.135.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127011BBBCC;
	Tue, 21 Jan 2025 09:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737451095; cv=fail; b=jq3Uas/hIU54LMwa6b/58SBhZ9awiHyS56ZzABQl5P3AM3K86sK4H1XkdKFMZfBrTYLFj/qgxS3cMbm69WdgHzG8+64+urd4MCchE8/FlCzTWXPT0i6CXmvIYkchlDms/8iHlFaTNr0JmdSQF6GYPEpbzYAhR7KEEG/wei5CaEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737451095; c=relaxed/simple;
	bh=QPuqnga29xTXJtNIUqRIG4q05ShXbIpuxz9GZNwd+GE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SsWd2qOi1TczKpCbdhlw3oO498TUbwkKaYS+n849AFyuDIFIPh9VYqYPqdoMZQmQIDeLQjstHUuSlPCpWwVgCN2QCM82AJeQhTY+Ig3HSsd0mAYURTZ5O71NIozkOHlj6nYjzKAqe3zjBIFsWXjyKysPVhd5EZ4AsNkmWVgCRGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu; spf=pass smtp.mailfrom=illinois.edu; dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b=Fud28zFB; arc=fail smtp.client-ip=148.163.135.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=illinois.edu
Received: from pps.filterd (m0166256.ppops.net [127.0.0.1])
	by mx0a-00007101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50L8WNlV005664;
	Tue, 21 Jan 2025 09:17:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=illinois.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=campusrelays;
	 bh=y7ExWYvI8uE7mLQnZcN59vlhFUwVQR1DSixwTE69QZ0=; b=Fud28zFBP5gH
	th3aeSOBl5VZOtkJhB/7P5zRMaD8N+clNNnJ9nY3TIaIWWPp0xxzVzh+MrXVTSaF
	O84F+v6MPh9j6ttlRKosBEHR5P02UONXRKt+u3F5pInBnu2e3x+pkr9zHMMcoAoK
	D46Pl5W7lqzw5BIWNd9CPe5WMMubr4CXV0OMuqvJL4dR3vQnF9G78aqzlB81xG7U
	HUImFTBzq5ZUCGQbkbsax1deX6mOGugblQllV5lFTsDiCXTg9muiRiAnI6mhOrVd
	NwwapmKIoFsY3zpvuYzbq8zAo06RiBIqOyDBX4+/jxPQq883IDEpHKrGSOhVICCA
	G+Z5V77fTQ==
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2043.outbound.protection.outlook.com [104.47.73.43])
	by mx0a-00007101.pphosted.com (PPS) with ESMTPS id 449vda3jpk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jan 2025 09:17:38 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UI1mmjdAzJBpnXAcMsJuff5Oy6p1hhsRidjO5GHeo+GP8MCUmzQ9pYX8qefLCkvUdgS4SzUVOZnjD09/GkS+t2c3Mb6JUxrLrO5CfaMKcpj3El93Kg+Ohv72Z0TUotcbav9FkJLDPU49mv8iIcYwpC0U50yqdaZdjKYXqYRb1yY1QcazfilixknZReCS2en+KLSAmN7sekr/HqlTmQpAoYEtQCwTklkDK0OsrkYkmr9WNCdGvap177rIVSbOZSvyBoEYcLWmsQ5CnHPAChkbWB87GUPMkftKIuKqI3bJUfu/JWrkwqu4e27GG4h70dWtbNpiNx6EdYhIz1/OyIboIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y7ExWYvI8uE7mLQnZcN59vlhFUwVQR1DSixwTE69QZ0=;
 b=nEcvZKTkfKrYpd99AtULrugcPjcOOUQcEKR1P92oOpq9Z5fmbC/H9Iq3dIxkKdc/OfP8m7Vh7Qm28JgppbWNnL4WJdhl1fIRJW9qPFC9hvCMCzrKhPklNz6y7Xzql7dKOZcVhjbVzkSEJzEj4wPGuEmkp84P6orqnYoHC2XMsAdLoxuhzkwslFEXHeLh+RqP1o5xOLnpTBNcl5XOuMHcETPge6nD567zzz+0c0XOTwslqE3C5hhNVCTL8Mu4xdSNdYuHAPQKwNpX+eN7ITUjiaOPMDmdEJMxcHK9/K5we81rfw7sT3XhXoyiEUb6tRMjjJVU6YFOp94Gb4jJNpbQSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=illinois.edu; dmarc=pass action=none header.from=illinois.edu;
 dkim=pass header.d=illinois.edu; arc=none
Received: from DS0PR11MB7286.namprd11.prod.outlook.com (2603:10b6:8:13c::15)
 by BL1PR11MB5320.namprd11.prod.outlook.com (2603:10b6:208:316::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Tue, 21 Jan
 2025 09:17:35 +0000
Received: from DS0PR11MB7286.namprd11.prod.outlook.com
 ([fe80::d52:d2da:59c7:808]) by DS0PR11MB7286.namprd11.prod.outlook.com
 ([fe80::d52:d2da:59c7:808%4]) with mapi id 15.20.8356.014; Tue, 21 Jan 2025
 09:17:35 +0000
Message-ID: <71d07382-cad9-46ac-8c28-f0d1af2bd44c@illinois.edu>
Date: Tue, 21 Jan 2025 03:17:33 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] samples/bpf: fix broken vmlinux path for VMLINUX_BTF
To: Nicolas Schier <n.schier@avm.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Ruowen Qin <ruqin@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
 <martin.lau@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250120023027.160448-1-jinghao7@illinois.edu>
 <CAK7LNASn2aS6kcOy2Ur=tv_0fuEw8Gv06cVrOJ0x==AD9YRwRg@mail.gmail.com>
 <c07454ba-d124-45d0-815e-2951c566e0bf@illinois.edu>
 <7bed760c-7184-4719-8cda-1b7fcbc8577b@illinois.edu>
 <20250121-fair-succinct-cicada-e432d7@l-nschier-z2>
Content-Language: en-US
From: Jinghao Jia <jinghao7@illinois.edu>
In-Reply-To: <20250121-fair-succinct-cicada-e432d7@l-nschier-z2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR18CA0043.namprd18.prod.outlook.com
 (2603:10b6:610:55::23) To DS0PR11MB7286.namprd11.prod.outlook.com
 (2603:10b6:8:13c::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7286:EE_|BL1PR11MB5320:EE_
X-MS-Office365-Filtering-Correlation-Id: aac1ef3f-5a88-494e-361e-08dd39fc711c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vi9yOUg4c2txemFtTmx0NXo3WGdYS2wxVGdSMGo1SUhpdTFBaVJrSEkxUnIw?=
 =?utf-8?B?TlJTbHJjTXBlL2hINlY3Ny9xc0RCSklTMjl6U1lFaUZrM0hUdEhzVGs4Zmlj?=
 =?utf-8?B?VTlvbno2WE5BL0ZDbmM0MlJBVm0welkydlZmQWloQUVKUEpUSGZXNWR1NDIw?=
 =?utf-8?B?YkI1TzJyMHh1SWp5MnEyc0NUSThuVmRRaEJqUTRTMGNGeW1uTS9UYnVBaXhy?=
 =?utf-8?B?SjBpV00wUlJHZWF3WjdwWUZnS0oyajZjRFl3SFVSUmhFM1FFY3RnK0lQMTJv?=
 =?utf-8?B?RzZ0dzFyd2tMcUs4SGdjS3Bta01IUVhtS0pSSzA0TWdvV1Y3NWZsUXB2SkZu?=
 =?utf-8?B?dzdGSXc4RUpmbVlNVVp1Q2Nvcm55aUFNV2FZS0dTOVM4Y0dIUmFDNUVIRmJK?=
 =?utf-8?B?Z2luZ3hnSE5PekdEWnQvL2M2YUVnZTR5TzIvK3RCYTVNbE9NN3BDWmZRN0NM?=
 =?utf-8?B?emJHcXpPUnJzYUR0WkZrb0Z6S0drZ1pPRnR3dWh1ZVlraTVkS2ZsbHBoUVJR?=
 =?utf-8?B?akFyNnp3RmpHaHZLNmQ1RXA4UDcrN0V0L3BCVHRLWjFPd09HcGhOWlZOSjUv?=
 =?utf-8?B?RThBVTR1WEZBOHNWOGY1WnJlcDNZb0lpeFFKbUV4aUtXaUV1WEhuQklFTENw?=
 =?utf-8?B?WkNHZGkzTEJJdXp1R0dsY1pFbXBaZ3NoQXdqbG1UYnl5ajZNNEc5TWlucHVP?=
 =?utf-8?B?ZlBWVkRIc3FvSEdjUUY5bGFIbjVyZ0djZCtrd0VtOTU4V0pDdTRSa0oxMGJK?=
 =?utf-8?B?SERhUnlKRlBFVnlCNndhbVFVY1c0akc1M3pXTXJoVE9PWGttMlhxUzdoM3Br?=
 =?utf-8?B?a21VQmpOZStoOHp5aVRSYUgyc09IZm1jZ1BmR0lsL21RclgzcEZzalBwTHdK?=
 =?utf-8?B?cnYrUDN6UUlPY3I4OW94QjlaSGdab2xheThqbk9Eb1lmTnFQTVJYenB2UERN?=
 =?utf-8?B?YUxNUlV3cUlKNjNDOHBiOEhVVzFFUUpXMmpqV0VudVZlR2NLc0hCZFlOZHNU?=
 =?utf-8?B?YWJWUzdYOGJ2NHVMZjlUSmYvcUFEYmNZM1lDRkhYMEF0V2huZVJkdG5icG1n?=
 =?utf-8?B?Y3ErYjkvdSszRjIvT3p5Z21DclY1ZStNYTdqSG01eno4aVNuUWpoNUxjQWg4?=
 =?utf-8?B?R0w3SVMzeEk0UWxWbmJ6ZWxLSkhkSW52ZnBqQklXSEk4VDZWUXVNcmFKVm5Y?=
 =?utf-8?B?eDBsSE5BME05L3BpcVk2TWxlbmVaT0lTbGFCYlFQV1ZBbG5VUytkRWFQSkdx?=
 =?utf-8?B?UlcyS3laNmtyMzdvK1R5WXBrMk1uZUxmWEdWOUphSlg5L2Ivcm5mVWIxaDgr?=
 =?utf-8?B?ZU9IZStjOUJmYXVIcmVpalVZdVN0eHQvRkRjUjJ2NXBxLzFFbnFndVdNUWtO?=
 =?utf-8?B?VjVUenA0elFLbWZnZkppUVdOS1VGMmpZNlVtcy8zQlBCWUlUeDFaOGlhSStx?=
 =?utf-8?B?ZndjV3RNUkx6YmY1VEljTmpFb3k0dW80OVdqVjJGRldNSlRmanhMRTRBc1NF?=
 =?utf-8?B?THFRR2R4bU9UR0xYQ09FR2daWStvMW9EYnlaWTZ0NEg4dklkQWZpdDZzYjR1?=
 =?utf-8?B?VWVlRlo4UEc4OTB3dTNUeDN5OElmeCtrNkc4a0w0ZEpPNllXUU53NkRIbHBo?=
 =?utf-8?B?emhkMmtsTTJGejZQVVFhaS9oNkxZbUp2SnVhTUwwUG9PWk5mem5VOGQ2WGEv?=
 =?utf-8?B?SWlVdHRoWS9kcUYxYXRqbzZMVXBmY2kvczFEblRVaFVWOW9FMWxySG1WYWZT?=
 =?utf-8?B?SjhSVyt5MXAwZ241cXdyMEd4NVNib0xLR2VQOUUwTXBMNXZ0L0Y4dDhlYUhG?=
 =?utf-8?B?N0JsWEptMGlIZ1BpQU5BZmVud1RycXczdmdSQmUvS216THgzZ3hlRWlOUUR0?=
 =?utf-8?Q?o5dw4EaaxxToZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7286.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTRhWlc1ZTdFd0FjUU8xNU1HVDN4UkVvUlZZQ3FvUDhTKzZlM1pxYUI3RjFt?=
 =?utf-8?B?a2dHSndwVGkwUzMwVm41MjVmWUNBQWQxSFc3RSsvYlpjWTdSWmtrTzBBSEdQ?=
 =?utf-8?B?RWJ5ZUI3NUoxR0t6RzVPejd0NnBBYW9tc1M0dEhsRERNRWNWVTVjektlRUhU?=
 =?utf-8?B?aDMyM2hSUERZMTU1dzFhY0EzTVNvNVJDSnNhNXp1NUx6SXhVam1yZ0FtZVE3?=
 =?utf-8?B?bWU1aWw5d2l1WUhtb1JlYk9hOVZYM2o1c3lnSENsUFpUQWdaaW56NGJhckJj?=
 =?utf-8?B?bTVMdHpPeHdhaHRTd2h1OU0zYWxvREN6Ty9vSzR4aGRrcjVkMVcwQjVIT1J6?=
 =?utf-8?B?aUlhM0xxS1ZkcVNUeG9MbllLUmdGZFRCV0JrWHRWVXloOVZNdW9oYjhYcWVR?=
 =?utf-8?B?WDdLRG05czFxeGVIeWRIT1FCU1hZdmFDWVlzN1d0R25aeDlEQ09sSkt6WHBX?=
 =?utf-8?B?ay92Y1BIUHlRcjJybHlhY2hqSHpUZy8vWEJuL3FZbUx6ZnJrT29aZ3o4eCtq?=
 =?utf-8?B?aDZIZHlVbnllZUZiRnUxd0J4cFBSUlZhTGJTWmhZdDVTV0VZbGdIdkg2ZzZj?=
 =?utf-8?B?bnZBV0VHaDgzaWhnbGV6SmV3NnNVWnFmemdneGVTMXYyNDZWbVd6UVRPWDFJ?=
 =?utf-8?B?dStqbmFXNUNGdm1qTy9PVGJvbFYzVy9XVWIrZElOcFN1V2NHZ0hsdUVYRG9M?=
 =?utf-8?B?aGZFN2xLU2dVV3BBbGMwRndZU3IrTGlmV1dyckJQYXROQjlnb0haZTRxeThx?=
 =?utf-8?B?MjB1OG9mT0lacUJLc0lZd253ZHBBOTFvVTNUTGx5a3M2N1V5N1l0cW1Fa3Zl?=
 =?utf-8?B?ZlhSZkE1Slhmd2hYZmU5ZjRCcTFmMEFXTTE1M05ESmV2dkZVTkh5dTBCNEEr?=
 =?utf-8?B?SGNmYzVmSTlVbDhZa1Q1enp0Q1kycTROSGFXVGJMNXRSTytKMEtTNzlKbnRB?=
 =?utf-8?B?SEUyL3d6RlV2dUpUV0dxOGtVS2tZdWsxbDlINWs0dFJucmJEaysyU2R0MUZ5?=
 =?utf-8?B?dHFZd01SVndTS0M0bWdETXJyRG9SV0N2SjRTVW5zcGFaMmNYOWFmTkQwWEk2?=
 =?utf-8?B?M2JYOXY4K1BSbW5mV0xvTkpYWEExUUpFSVVjVUVqYmxveDNWM1lrYVFhaDla?=
 =?utf-8?B?NkplT2lTUVArT0FDYzR0b29VZXB3ZEE5WXhzZ3BvbzV3VGFKNEJJYWg5UFlC?=
 =?utf-8?B?K0V3SHgyUnNaYU53QnhzVXFkN2xYSkZxZGhmMTRBcDArM2xtc2s1SXRPVHhC?=
 =?utf-8?B?UWFqM1k4T2FzTVJiVlo4UTlSV3ROU1RpbDhlVGFlcXFSeW9lNXhmSFRCRXBj?=
 =?utf-8?B?NGVoOTY3V0FuYkd0Y1dBY1V3b2hjM0xNQjlhT3BFcjhnRzQ4UTVnRHk0dVMr?=
 =?utf-8?B?bUlBK2N3cXlOQXNwT3NhS1dZZURCQ2Z2UDVFUEVoRlVIbVJIV3NzTytVN0k5?=
 =?utf-8?B?eGZpREp5bzB4WVVVdUtoSnpiTFJGTWovWnYyaXcrc1pZQUpsOTU4ajFUVFBB?=
 =?utf-8?B?bGJ2Ui8wRnRHYldmN0txcHYxaGN2WFFQUTMwaDJyQzltV1hmS2t5dDRIT0hv?=
 =?utf-8?B?UEMxYnVhUlpsVFo2bmhVWVpYMmRIV0t4YUQ2NFRIU0dFWE9xWmd5eUdoYlBH?=
 =?utf-8?B?UFJWQnZxdmFpYllHOWpFQUZmMExBaDF3N2xIdUdTOW13RG41cEdNTmdOZDMv?=
 =?utf-8?B?bTBNOEtHMkNvNVdvUnVNb2ZYVFB4RFNRdW5uZGVpU20rTUR4dU1FL0lOdUFh?=
 =?utf-8?B?d0JPaHNsNENNcHlTcTJYRDF4eFdxNmhFbFBSQ0V3bWZ3OHB2Uy9iNVpkbTFa?=
 =?utf-8?B?bW4rbGF4M0V4cmYxZGMybndYajZWdGVMVnJrZXZIVTBib1pWRWtWNFp4YUw4?=
 =?utf-8?B?cUZqT1U3dUNqVVBjT2RaWWdWN29KOVFaWlkyL2JpaTlRQW54UHNYU0puaVRT?=
 =?utf-8?B?RmlOaFpRY3lUUFc4cFl5S1c4QTdUeHcvWmlic0tGRGFsTnhjWUd1WVJ2M2pF?=
 =?utf-8?B?K2V3MWFWcGFBaC9iQ2RqNUZxUlBQVy9ZWHE1bXBOZlphcDN4aGhLZ1RIUjVD?=
 =?utf-8?B?WmVML2w4OTNObGpmL3JTTDVBY2tWR0xOV0VLMXdEeEhhTlNhVm1XTUVYWW0x?=
 =?utf-8?Q?UP2jWpN5r0qcTKrqFuLy1rtZZ?=
X-OriginatorOrg: illinois.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: aac1ef3f-5a88-494e-361e-08dd39fc711c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7286.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 09:17:34.9950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 44467e6f-462c-4ea2-823f-7800de5434e3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H8rOotx4t1sWKb3gZi5SWsRsRFvySz0kOqHM99vkvBDPwEmg+tLHh7yQ5KiTwQ8Z3BpWM1kwm6idQHH66t+ysg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5320
X-Proofpoint-ORIG-GUID: 71V_5ZkureTg014LozKvZ1Eh_qdJl3-u
X-Proofpoint-GUID: 71V_5ZkureTg014LozKvZ1Eh_qdJl3-u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-21_04,2025-01-21_02,2024-11-22_01
X-Spam-Details: rule=cautious_plus_nq_notspam policy=cautious_plus_nq score=0 mlxscore=0
 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=999 lowpriorityscore=0
 bulkscore=0 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501210075
X-Spam-Score: 0
X-Spam-OrigSender: jinghao7@illinois.edu
X-Spam-Bar: 



On 1/21/25 3:15 AM, Nicolas Schier wrote:
> On Tue, Jan 21, 2025 at 02:48:54AM -0600, Jinghao Jia wrote:
>>
>>
>> On 1/20/25 6:47 PM, Jinghao Jia wrote:
>>>
>>>
>>> On 1/20/25 6:42 PM, Masahiro Yamada wrote:
>>>> On Mon, Jan 20, 2025 at 11:30 AM Jinghao Jia <jinghao7@illinois.edu> wrote:
>>>>>
>>>>> Commit 13b25489b6f8 ("kbuild: change working directory to external
>>>>> module directory with M=") changed kbuild working directory of bpf
>>>>> samples to $(srctree)/samples/bpf, which broke the vmlinux path for
>>>>> VMLINUX_BTF, as the Makefile assumes the current work directory to be
>>>>> $(srctree):
>>>>>
>>>>>   Makefile:316: *** Cannot find a vmlinux for VMLINUX_BTF at any of "  /path/to/linux/samples/bpf/vmlinux", build the kernel or set VMLINUX_BTF like "VMLINUX_BTF=/sys/kernel/btf/vmlinux" or VMLINUX_H variable.  Stop.
>>>>>
>>>>> Correctly refer to the kernel source directory using $(srctree).
>>>>>
>>>>> Fixes: 13b25489b6f8 ("kbuild: change working directory to external module directory with M=")
>>>>> Tested-by: Ruowen Qin <ruqin@redhat.com>
>>>>> Signed-off-by: Jinghao Jia <jinghao7@illinois.edu>
>>>>> ---
>>>>>  samples/bpf/Makefile | 2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
>>>>> index 96a05e70ace3..f97295724a14 100644
>>>>> --- a/samples/bpf/Makefile
>>>>> +++ b/samples/bpf/Makefile
>>>>> @@ -307,7 +307,7 @@ $(obj)/$(TRACE_HELPERS): TPROGS_CFLAGS := $(TPROGS_CFLAGS) -D__must_check=
>>>>>
>>>>>  VMLINUX_BTF_PATHS ?= $(abspath $(if $(O),$(O)/vmlinux))                                \
>>>>>                      $(abspath $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)) \
>>>>> -                    $(abspath ./vmlinux)
>>>>> +                    $(abspath $(srctree)/vmlinux)
>>>>
>>>> This is wrong and will not work for O= build.
>>>>
>>>> The prefix should be $(objtree)/
>>>>
>>>>
>>>
>>> I thought the $(srctree)/vmlinux is a fallback when $(O) is not defined, am I
>>> understanding it wrong here?
>>>
>>> --Jinghao
>>>
>>
>> I played with kbuild a little bit more. It seems that the way the Makefiles are
>> set up does not allow a sample/bpf build w/o O= when the kernel itself is built
>> w/ O=, as it directly invokes the top-level Makefile. If O= is passed to the
>> sample/bpf build, the $(abspath $(if $(O),$(O)/vmlinux)) part should take care
>> of that. With that said, please do correct me if I am wrong.
>>
>> --Jinghao
> 
> $(srctree) refers to the root of the kernel source tree, while
> $(objtree) refers to the root of the kernel object tree.  Even if both
> variables have the same value for the case you are fixing, it makes
> sense to align to the meaning of the variables as described in
> Documentation/kbuild/makefiles.rst.
> 
> In short: if you want to access file created during the kernel build,
> please always use $(objtree) instead of $(srctree).
> 
> Hope that helps.
> 
> Kind regards,
> Nicolas

I see. Thanks for the clarification! I will add this to v2.

--Jinghao


