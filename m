Return-Path: <bpf+bounces-56955-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB029AA100C
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 17:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A636484026D
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 15:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B32C21CFFD;
	Tue, 29 Apr 2025 15:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iqWBDe/y"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06CA2192E2
	for <bpf@vger.kernel.org>; Tue, 29 Apr 2025 15:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745939391; cv=fail; b=savA5bb4icxaZ4eFy2jC1Woq9a7lLZX8kJ+GM/ShyIA74b8hmwHc7PBfOfUHsNhCZoGlOybX+4zffgVCJ8FnGkCWbzgujhvSn+wSvci0iSfbVw44IiogNpLwdC6kF7xdBiKtoTuPF1irOCSvrJuEFRvQPlkQbZZQQPWaNlQDdTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745939391; c=relaxed/simple;
	bh=ePQyYN1JfjVBcXzJKL1+6u2NR5+CobtXRKZoLcRAt4Y=;
	h=Content-Type:Date:Message-Id:Cc:To:From:Subject:References:
	 In-Reply-To:MIME-Version; b=GDWJURSJN2lYPerhSW/Anq1XgaQ23Iiy4GFxKAq/rHVtVaZztQpexoP9ZR7/wVB111JTL0rK4fcqffXmkhQlLl50Ut0O9b7nr5lC7A1q/RT0/pMUMHGBKAY8NVjtu30GBVFQu9yqRfKrdUtskq40D/v0NFaGZYXatv5Rp8WZr4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iqWBDe/y; arc=fail smtp.client-ip=40.107.92.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dTu7OrEZbKaCQkfJu9ZiErY62qELh271HQDRu7IeIZ6Y+zUODptZszzdqNKdZI2sdKcjhH+h9mJR6nq2A/XSUPyCRHrAFlmD0/Ji6gLbmY9DQwvInZK9nq+sac6GKIMuFca5gXUqbOsDmumrThtFguqewOtXSdjB0kyhBpwH2ydqGXSmTzKHqvvTgJ0TlRq1I6iOgcuVmu+z5MWU44c+GmyfbxR4Yqs0JDHRSHBEyOP8jOXVozbSovOP26v1UXOq+WMLoPkOt/yejHRx/RSsFTncDa/Oy0M37DjZcXW8fMfew2nhPyGWmlHm8NmnzSctJZRF1sAFupp0HzbhlNNgfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vmLpCfZOyfTGHhmumthvslnO9rvY4roljJxrXUxYZY0=;
 b=Di+kex9HVlqloCiX8UhW+gXs+qappEee+TEJpHW64ZuWMa+A+IUBogJ31SKM61yro8u335XLoyWSpGzmbmrsNnEjpLPz050HO8YLMjiuQiRZbXKiL2TdOrqa3uV/hVINGxsOGv3FScYJEogxEiaMfQT42/Uy4DVszObRjPkhhGxLzvATQNitUZu0G+ZZztORo6xEtTG+eg3nIkF0JtOhY6ck3jqxqWuNetwp/cbcKKDKg1AMI4D1uunpDiwBXmslqTTyIkabst8PxoP4/eGo4+EHYili93tSlzd2GdU+oA79/ai59Qqonotef3jvmhanLSJmkdL/gRb/xr5CjiYByw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmLpCfZOyfTGHhmumthvslnO9rvY4roljJxrXUxYZY0=;
 b=iqWBDe/y1UZMSlDlF6h2FyPMzkR5vadi5/DFbi+msNollFv+cgDvo6tLNMm+7X5JHRfLNrC7f57x0KHHlZpRrNNhvK/ZbFQQkBLUbg0xR1KvRWmWpMC50yGLkC+Kri0wr09b+rC1FlOGUS3/sZQt+KQjwGt0LAjyaXP1X5wK1+dvwTTID9OeNH7eDeIEZQjjOg92sDyrZnTsunH6VRWfHKy1V+nunK9gHht3+mRFS6hPprCpLa8FdYpPDP0q+z/u1qWrNjnDvo4evsOkdzoiJ4l4XtZ5Tr5eim/x4aRXEGwuFp/Cq6X/IjTDpe7sOa4L1hs+QBVmvGR6Bwq9q8iC9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MW6PR12MB8836.namprd12.prod.outlook.com (2603:10b6:303:241::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Tue, 29 Apr
 2025 15:09:46 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 15:09:46 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 29 Apr 2025 11:09:44 -0400
Message-Id: <D9J7UWF1S5WH.285Y0GXSUD30W@nvidia.com>
Cc: <bpf@vger.kernel.org>, <linux-mm@kvack.org>
To: "Yafang Shao" <laoar.shao@gmail.com>, <akpm@linux-foundation.org>,
 <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>, "David
 Hildenbrand" <david@redhat.com>, "Baolin Wang"
 <baolin.wang@linux.alibaba.com>, "Lorenzo Stoakes"
 <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 "Nico Pache" <npache@redhat.com>, "Ryan Roberts" <ryan.roberts@arm.com>,
 "Dev Jain" <dev.jain@arm.com>
From: "Zi Yan" <ziy@nvidia.com>
Subject: Re: [RFC PATCH 0/4] mm, bpf: BPF based THP adjustment
X-Mailer: aerc 0.20.1-60-g87a3b42daac6-dirty
References: <20250429024139.34365-1-laoar.shao@gmail.com>
In-Reply-To: <20250429024139.34365-1-laoar.shao@gmail.com>
X-ClientProxiedBy: BN9PR03CA0431.namprd03.prod.outlook.com
 (2603:10b6:408:113::16) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MW6PR12MB8836:EE_
X-MS-Office365-Filtering-Correlation-Id: 020e9b26-cd52-4cfb-ba75-08dd872fe0bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ckhoNnVDLzd5SVA1SWllT2l3ZjZuOTk3Kzd1UFp3SGRGdnJicktuY1l2Qjd4?=
 =?utf-8?B?WVQ1M2dBcGtxMDhpYW9YYW93R0hJVmNDa3IvVmNSOW1XMTh1QTBTUkdLNStL?=
 =?utf-8?B?eDhxNloyZ2d4bFNYem9uazdoM0xxNTBaTkhzS2RGTDRhVWEwVC93RTUvWkN4?=
 =?utf-8?B?N3hRcHVjTEx6UW04N3VCem8rNjNZalJMaWhMVHBxUVNBU1Z0Z25qSkxEQXpZ?=
 =?utf-8?B?eXJEaU9BZUhXOS9IZHVHWFJuSUg2MWFqdWNXSUl5SnlnUHZRdkR4dGVoeGR5?=
 =?utf-8?B?RUVBQzNTbU9KNFhDRUZoT1BZRC9zcDBmV0dCN29IM013ZHRkMy9tbjlYVXB2?=
 =?utf-8?B?a1FvWklQdnZGRUF6VC90RkVDZVFkcEEyZktJejE1LzVwaklFc01hcTNRVkRi?=
 =?utf-8?B?bWFKdWpDbHpjekc1Q04rMUxKYkVpTnZ4NFJjRWNOelluZmJMRXRQNVlMNml4?=
 =?utf-8?B?Skl2dEREZEh3Zm9MQXZDWlNRRVNEc3E2UzB6UjFLbkh4L0hsbnNnTkxiYjRL?=
 =?utf-8?B?VXdRMm1qeWRLWUg2SXJwY1lwV0gycVlUSy82K2taS0VnWHhxSVJxTzZaSnVv?=
 =?utf-8?B?S3BrQnd4WlhhNXl5OC9nME9pdCt2ZGU4YUNnK1JWanVkZEtFczNKd1RmQ2NE?=
 =?utf-8?B?YVoyUHByQUUvRTBHdG5nQit4R3p4STFxeUxSNEdES04xU0c2Q2hyTmZZSVMz?=
 =?utf-8?B?RlQxOU12Mkgxd3R0aXcyVS9UVlZ2U2p1OUNvb0J6WWpXc0ZteVBJYnp0czg4?=
 =?utf-8?B?WjYrOHJiNTBqUTcwc1V2K2k5OG13Nzc0YXJhSkl5ZzkyRkpvYmtzRzBxTHZB?=
 =?utf-8?B?c0FFM2FzVDNUck53bXQ5bTJsUTduZkRKbVJ3OUVWQ1RXdlVJbXVoYkdaL2hV?=
 =?utf-8?B?d29Jc3lXQkFBYTZiZGJFaEpCcjR1RWJPV1lhV0lDdTUybGV3RmJWcnBUcFFX?=
 =?utf-8?B?SnVtSHNacWlYMGFVOThGK2ZiV0ZNU09tU094TytUcWdwV3g5SmpqZW9kSFU3?=
 =?utf-8?B?VngwdjVQM2I0TW9vNG9RSVV3bHZZdW5RYWs0UWFzRitlbHcya1Aya0tFeDVO?=
 =?utf-8?B?R2MvY2JDY0Y2OWh5NFF3cUFpdGh3SHhEeW5TaXh0bSthSHVOK21WVVlwM3RL?=
 =?utf-8?B?MWw3cEFVOUd2ZEt2QUs2MUE4bXU1QTg2NzdDMFJjN2ZoOXJVeUdUT1NJd0o3?=
 =?utf-8?B?eWRLYkRmUVlJL0M4OEcxSWJnaHpaM2dBM0lpOVZXNUVoNDhuRzkzZE9xL1Ju?=
 =?utf-8?B?STVCMm0zUEovMHhuLy9kckMyV0Z5RXRnR2JVZHhUa3d0ejNtRTdtbytmZnVk?=
 =?utf-8?B?cVJXOTdIRXRjamRjU1puSkNjRVZIcHRCZlVCaGpQTjEyS0oxcDNKV0VSSURU?=
 =?utf-8?B?eWExaDEwL1VsdldzRjVZRTkvRWhDYVU3NEoxbnVJV21kVlVZSkdlNDBIQlVt?=
 =?utf-8?B?YTJwUEgyN1Y5djNKSUt5ZlkwelpCTHZ5dmpEWFY4N0FYOTdiYnVMMjNtZ05Q?=
 =?utf-8?B?UzAzc0JncjErTFhzNWVkajV5bFhzSkJJZjA3OWlhYThtb1dEcHdmMUlhMU04?=
 =?utf-8?B?Zm56WDZXMkpjK1RuZkV0cTRRblE4dUFtOGRJRVNHbEU3UHg3Y3lhOXR2RXBq?=
 =?utf-8?B?b0V6TGp2aExZS2ZzaVJXTnJiY2pORnRHUGdicGthM1BIY3kxdm9JazRIL21j?=
 =?utf-8?B?T1VwUk5WWGUzYXJnclcyK0QxS1VSTzVIS1B1S1RQSU14YlhjcXIza0lUNDFw?=
 =?utf-8?B?L0RDMElOZ1Y1azJWK01VNmIvVWRWWk1WOFdsYnROeittQS9GUGIvR2xUcThJ?=
 =?utf-8?B?alBFV01LQ2VMV3c5VEdsYUFGb2FsRzVUM3ZVWEpXNzVaREtHMFNKZ2pIV2dE?=
 =?utf-8?B?Ky9tUFFvbGpHd0NvTENLL0dETk5RT0ZsaWl5SmxpdEFHRGtiTWRxZ3E3QkZa?=
 =?utf-8?B?Z3lTMWhYMmZBWHVqUzRWK2FVMFFLN3FwcFNZNFYzbFpMUGVlKzArRjM5c0N1?=
 =?utf-8?B?TTRHaGpseW9RPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2Vxejc3OFVpVG5xVzkrZEhwWUpSV1lkL0NQKzI4Zk4zVWRPMlVDUHlLZVpo?=
 =?utf-8?B?Mm8wRkE3VGZ4K1hodjJFejNPMTJaejdtdG1GUStzYVVXUWxMUE5DVFhTVllH?=
 =?utf-8?B?UGMyY0JlRFBRY0k5djBSQ2MyMDd0MUFEVVpNRVU2YkNveFBzWlpFS2ZIenFn?=
 =?utf-8?B?Tm9sNGd2WXR4aUF6WjBTVExlemxMSWgxRXdBenhScldkNWZVWVhKMU80OUo0?=
 =?utf-8?B?WXloWEtSS3JseFRrRkpWNllBWklKWnRFbFlveVFVOWgyWWV6cmY3TWg3ZGJ0?=
 =?utf-8?B?QVgrd2NyY3h0QUlCaGtSM3Y5UVcwQWd2Q1luRitWUzdNYTUrQmpPeklWTVgx?=
 =?utf-8?B?emx0VEhRWVp1UkdrMUp3STQzRWR1VWNkRXJhUW1QKzd5U0RJQjdkN3VVaXIx?=
 =?utf-8?B?WW53S2M5eWtKVlRRZzR0VUFFV2xtVXRQY0lRNW5Ob1Q3M0NxUWlQZVd4ckZX?=
 =?utf-8?B?Z2Q3Y3IvaVIxaXZ5UG5IdWtrZURDL1ZOUVJ1cUZsOUJZODV4MjBPVE5HU1RH?=
 =?utf-8?B?dW5wSHBMMUhVMlVwTVQ5akg1QXJ4RDh0YzNwVmVGK0R3c0xQRFo1K1pUdUxl?=
 =?utf-8?B?c2x3aXo5b1AwNnhVQzdlMTd5MlF2dzdNNFZrVDNoK0RBa3JMRGlkQzhtbEFC?=
 =?utf-8?B?RjZLcmRuOTNjc2FZVkx5MFhPbFhnanlQcW5uMy95c2sxcllTUEw0V1VaYWQ3?=
 =?utf-8?B?UEVIQzlQaXRjUGF5dmpQVVVuSU9HWHVjeXRjZ3ZmMzI3VFlqczI4VHFTRFNV?=
 =?utf-8?B?Qk41dHhUR0VnaTRPSDJQU25NQnk2bWlFME0rWS9sZ3prc3krTllpN1Yyd0tT?=
 =?utf-8?B?L0M3b3hIajJsa1YwTDNielIzNUowU3pMeU5SUVd0RUtJbEkyalk5YklvUGVE?=
 =?utf-8?B?bW9YckhkUEVuR1RhVVphOTF4dE15SHJnWTN6eVd3dVo3NkhnUnJnUFhYYXdZ?=
 =?utf-8?B?RUc0TEpkVTFwRlpER0pFaitONEZROUt4ZzlKeVNJazQ0ZFhndFppR0NIWENa?=
 =?utf-8?B?MExDM21LdEdGL2NWaEN0Ylk2cldDeWFlb0R4S2FkeG1WNDhzaGpoMDNEaVZ2?=
 =?utf-8?B?c2F1OWhoRXJ4SDdOM3RaWStPdGlxWFRMSVJPUTRUZmJYenh6T20yWXU1MUJR?=
 =?utf-8?B?bnFPSVRhZE8vK3B6Mnl1L0NkMFhhR0E0MWdyeFFHUkdBQkFDRGJXdzNWcllt?=
 =?utf-8?B?bWYzbWkvVkRJcWYydVN4MEdBS1AyTVc2U3YvZjJjcm5VaHRpQ3U1R2xKTVJM?=
 =?utf-8?B?a2U4OHoxRzdPNHNodEhuMlVOOC9HWDBsYjcrRHFLWHZLYXp1ZDZxbHl2dHRT?=
 =?utf-8?B?SlBwajluY3RsQmhlNTllUDZQeGtuZE5BaDl5LzQ5NU5Ta0RHYmkrN3VscnNU?=
 =?utf-8?B?enBEeTQrME9GclNqaXNzdmdURFcrL1pQM3RZMk9OcVdDcXUvdDF6MU5IRk1i?=
 =?utf-8?B?NDFDaHNrbXBMNS9Ca2RsQlM2QUlEK2xJcndEZVVoT1hLYm55OUYxY3pWejJ2?=
 =?utf-8?B?V1lUNGdLTXVoRHJhZE5nOTV2WjFWYnpNNHJKMHNsR3RZWlN3WWpUVitBLzFi?=
 =?utf-8?B?OUx3cWU5Si9LWkJzSkh4MURqZUg2ZVRGalF0U0szSnUvWmw4TUF4cUJNbFVa?=
 =?utf-8?B?WnBtTkpWMCtpMFhxMWZxQUtGSVdzUGFaeHVzQ3ZGcVo5SEFxZTVFdVR6L25E?=
 =?utf-8?B?cUxjWnNMY0wzc2tjaUlXWjAwamVUYWc4UE5Fc2FhTGt2QkdwK2pDbSt1MUwy?=
 =?utf-8?B?OHJQdG9NelFoQWFMcmFEUGppWlZ4Yzh5YjlTbGdjT1ZLS2xjMGhoZlhrU1lk?=
 =?utf-8?B?Qm00VmlsckZZRmc2dlJ1Si81Y3lHQWJIL3BxR2UyeXlsWjV0YWpMR3R3MWVM?=
 =?utf-8?B?Ym4rdEdCYkNXNkVueUtBUnlqMS9qUnlqVE16dzcxVG1rWG92TnhxbHBTT2ps?=
 =?utf-8?B?T1ZZaTFtaXpPYjdhUXR3VFlYWWNSR2x4MW1NUnNVc0lXWGpvWEVLMzZnNTNE?=
 =?utf-8?B?bVM2bFJpUG1CWXFjM1c3ckNCcUI1UnBHVXovZlpQSTdKK2k5KzIrVjFoZ2lw?=
 =?utf-8?B?N1RKK1F2QVRTVUxGbTZyWVFjQ20xdndEb0xsWDk1TWNpVGxiSE5KUXh3K0F0?=
 =?utf-8?Q?ACXncLMkppW7ZFV/zU+grYNW3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 020e9b26-cd52-4cfb-ba75-08dd872fe0bb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 15:09:46.1316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fjldK3zD0+29QNoCwbxgqJeDAz9c02smWxc+N6COLgisM3/A6/NlgU6XeRRMKTte
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8836

Hi Yafang,

We recently added a new THP entry in MAINTAINERS file[1], do you mind ccing
people there in your next version? (I added them here)

[1] https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/tree/MAINTA=
INERS?h=3Dmm-everything#n15589

On Mon Apr 28, 2025 at 10:41 PM EDT, Yafang Shao wrote:
> In our container environment, we aim to enable THP selectively=E2=80=94al=
lowing
> specific services to use it while restricting others. This approach is
> driven by the following considerations:
>
> 1. Memory Fragmentation
>    THP can lead to increased memory fragmentation, so we want to limit it=
s
>    use across services.
> 2. Performance Impact
>    Some services see no benefit from THP, making its usage unnecessary.
> 3. Performance Gains
>    Certain workloads, such as machine learning services, experience
>    significant performance improvements with THP, so we enable it for the=
m
>    specifically.=20
>
> Since multiple services run on a single host in a containerized environme=
nt,
> enabling THP globally is not ideal. Previously, we set THP to madvise,
> allowing selected services to opt in via MADV_HUGEPAGE. However, this
> approach had limitation:
>
> - Some services inadvertently used madvise(MADV_HUGEPAGE) through
>   third-party libraries, bypassing our restrictions.

Basically, you want more precise control of THP enablement and the
ability of overriding madvise() from userspace.

In terms of overriding madvise(), do you have any concrete example of
these third-party libraries? madvise() users are supposed to know what
they are doing, so I wonder why they are causing trouble in your
environment.

>
> To address this issue, we initially hooked the __x64_sys_madvise() syscal=
l,
> which is error-injectable, to blacklist unwanted services. While this
> worked, it was error-prone and ineffective for services needing always mo=
de,
> as modifying their code to use madvise was impractical.
>
> To achieve finer-grained control, we introduced an fmod_ret-based solutio=
n.
> Now, we dynamically adjust THP settings per service by hooking
> hugepage_global_{enabled,always}() via BPF. This allows us to set THP to
> enable or disable on a per-service basis without global impact.

hugepage_global_*() are whole system knobs. How did you use it to
achieve per-service control? In terms of per-service, does it mean
you need per-memcg group (I assume each service has its own memcg) THP
configuration?

>
> The hugepage_global_{enabled,always}() functions currently share the same
> BPF hook, which limits THP configuration to either always or never. While
> this suffices for our specific use cases, full support for all three mode=
s
> (always, madvise, and never) would require splitting them into separate
> hooks.
>
> This is the initial RFC patch=E2=80=94feedback is welcome!
>
> Yafang Shao (4):
>   mm: move hugepage_global_{enabled,always}() to internal.h
>   mm: pass VMA parameter to hugepage_global_{enabled,always}()
>   mm: add BPF hook for THP adjustment
>   selftests/bpf: Add selftest for THP adjustment
>
>  include/linux/huge_mm.h                       |  54 +-----
>  mm/Makefile                                   |   3 +
>  mm/bpf.c                                      |  36 ++++
>  mm/bpf.h                                      |  21 +++
>  mm/huge_memory.c                              |  50 ++++-
>  mm/internal.h                                 |  21 +++
>  mm/khugepaged.c                               |  18 +-
>  tools/testing/selftests/bpf/config            |   1 +
>  .../selftests/bpf/prog_tests/thp_adjust.c     | 176 ++++++++++++++++++
>  .../selftests/bpf/progs/test_thp_adjust.c     |  32 ++++
>  10 files changed, 344 insertions(+), 68 deletions(-)
>  create mode 100644 mm/bpf.c
>  create mode 100644 mm/bpf.h
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/thp_adjust.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_thp_adjust.c




--=20
Best Regards,
Yan, Zi


