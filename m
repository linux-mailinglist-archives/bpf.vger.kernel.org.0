Return-Path: <bpf+bounces-76540-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8917CB9737
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 18:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 65ABA30056ED
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 17:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651812DC790;
	Fri, 12 Dec 2025 17:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S5/iGAgL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zI5u/Qkh"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FB22DCC17;
	Fri, 12 Dec 2025 17:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765560434; cv=fail; b=AxsTNPdyB16TvMCXrlaFaslNb5kFPGxGJRu3Vy2K1/i7Ea2C1R1u87hi0C1x5K/GS349QT+JrEbQ5gslfteEBbc1i08Knpogn0NMIC5LGTa9k+oswZ/dju16pjj7TbH+CmFvzk3WtmCWX9mEMi9Ytt+W0ujh4Z+Ffp431refPqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765560434; c=relaxed/simple;
	bh=GT0bMseIb/0SovHgmMrvpJnGQpBb55EIT7kWgYZg9MQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dEAjHtYn29n8zh4aFwIeETRUrSLwFrEatdjL13EuLR29FA0ezyUcY/Y25YmNG8oIqDdbdcEpsv/0g1OD6C3kZ5wEovguyexQUeWCKS+jtzBIpVCB3jXgxhVoNhzX0iks4fjariylfaQI+n5WdDj5b0+K+4vsHcCsxr9ECgAv8T4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=S5/iGAgL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zI5u/Qkh; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BCHOqHH4152611;
	Fri, 12 Dec 2025 17:26:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=fAm0BHo5ZmUzXZnMkcFodZ+iziFzrOkSwQ1UMXH+xE8=; b=
	S5/iGAgLHaopNXGKnDUPvLFYYDXSi01LEuzAGdXp9UCvu5YzxvvSH2SqjrB0mJwJ
	9ryfuYkQ4deRlp+/N7V42yF3kl46r+0co6KMBvhVOIchBbKsREtrpaPpmRaD0m5L
	PG+uteTToLHpR2ihtVczTv+AHw6vABjphhz5r+Tfn5qJQIMLj4R3Nih6ARC2uUrT
	0Qdf51wWs4GIIzDz7+SsDXGOGZoQfhywSaUCY5fPklW4G2NBS8ppulpUOa2q6deN
	3oMoWOOfiwBrljYvVcYneVVfzhIjuyljS5t2KzLTzBzSOXnctT94umPt6MkCNIAT
	R+zKithL3JKBBQVVV1bh2w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ayc9q3ne0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Dec 2025 17:26:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BCH0l9I017466;
	Fri, 12 Dec 2025 17:26:32 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010040.outbound.protection.outlook.com [52.101.201.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4avaxd1p0b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Dec 2025 17:26:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IQ/SxVapPIgVcdodDE4RBZSia3DdZ/sx7CWpt2JUQ1hshQmfnfmC49XS8ZPBGZn4FLtPoTA/i61U3scknWEboaACoejJ7eLTTmVKLkFF1d/yK/N0XenzXRRwqrPH+Eiy/EKlZ9ysEMJUzz2Z2+MXFh61A7KDZTOf0BtLIGpaI9Om5peO6Ej7zUD/XC9wI3WUFduhQkGMB5+BgUq/rQjESkpVQc4gtoOGsguCmnGYvJn6eQZYFWq7dC7fCXHY9uMmUS1SHiyahTK7xsFhEryG6QxfLBZUONRQcg4tU97q8/rX1UsovPmek1PovJ8LIjU/zvjdQhMiMNwAa0Kp6PLKHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fAm0BHo5ZmUzXZnMkcFodZ+iziFzrOkSwQ1UMXH+xE8=;
 b=HdFd+1M/zvSoyOvmfkjQ/pYywmiV5sbTACcvPnviBNu2rxQyNri2DJhVVpxJlPEyeLHouDqgDevMg66SQ27Bc/JlHJ+mAGJ2uchkJP3Qkil1s8zSQsLu5EpT8t1rjQui9T85SY0vKb1yVhq3gbp1lcmQ5+GEqXgWL+p+IaxW88/emSqPBOcdG/7E5MV0vHqOrXOFGPNavFHMgY4Dojxn7fmf1fWj9nvqyrxAtYNOe5HAk4j63xusIRBu5TMie/Kq2CV75jmGKQv8/AZ0S1f+HXgzFDElJ4Kah47vIhRZaqWvfJ59C6ix06uTum/5b5U7pcpDvUZec4+C7Sn4MDIcUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAm0BHo5ZmUzXZnMkcFodZ+iziFzrOkSwQ1UMXH+xE8=;
 b=zI5u/QkhwFDhkwnz+ukDLWMo0H5A8Xtou/gvHDTbW7AwQl1jk7dYQIWuN2hve9v2zksp2R+IvaruY/52x6B6Wz1fplmZE8KcdNGVMDouZzVwoYe/PxcMbwfv+6K5N6wgfDNZHypVWUlVPT1+uTZZKdtPZ6NRIjOpM2dUZLY93cQ=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 SN7PR10MB6473.namprd10.prod.outlook.com (2603:10b6:806:2a0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.11; Fri, 12 Dec
 2025 17:26:29 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 17:26:28 +0000
Message-ID: <8f946abf-dd88-4fac-8bb4-84fcd8d81cf0@oracle.com>
Date: Fri, 12 Dec 2025 17:26:21 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 4/6] lib/Kconfig.debug: Set the minimum
 required pahole version to v1.22
To: Ihor Solodrai <ihor.solodrai@linux.dev>,
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
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
        Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
        Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
        Shuah Khan <shuah@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        Donglin Peng <dolinux.peng@gmail.com>
Cc: bpf@vger.kernel.org, dwarves@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org
References: <20251205223046.4155870-1-ihor.solodrai@linux.dev>
 <20251205223046.4155870-5-ihor.solodrai@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20251205223046.4155870-5-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0152.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::13) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|SN7PR10MB6473:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bc88acf-b756-4bfe-e6c3-08de39a3954e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dXpweWxvTW9JbG93aXNtU1l3c1lZRloyR3pGVERjZ3d1bkE1dzhjbXRrUGc4?=
 =?utf-8?B?dHcrTk1iUklkUS9nYlVDbjN1YWpLQnBMeXJ5UmV2WGR0L3ByZW91Nnd5Y2ZB?=
 =?utf-8?B?VVJqU3dlZ1FxNEhqY1JWcHdoY0NmdmMwTW0vQ2ZkVW1XUUFsTkZMN21YWFA3?=
 =?utf-8?B?UTlGT3dKaGhSanBVU1RjWlpZUVdpRmxKbUFmMkpjNVU5V1g0RFNHNlJsOGVT?=
 =?utf-8?B?dVo5RGdjWEpKeWR0bFlZTERTcDdjZjlsV0cxU09zZEY0S0tzK0h3ejM3cEVu?=
 =?utf-8?B?TnhlVDZFTHZCTHVITUNvdUFvbFU2c2lCRHgyWElFZ3RIVFNkVUlZWHAvVEhG?=
 =?utf-8?B?bmtnNXJCcy85MW1hd25palVFRHZLWFlmR0N5ekN4TEcwUExpc0pVTHpnUlFw?=
 =?utf-8?B?alIxU2x4SzlnOU1JZ2Z6cmxYT1h4WmVFOW5leVJDWkR4ZUpXZmxTSStvUytE?=
 =?utf-8?B?a3NyNHZEc3YxZ1FFNGxib2lidHRLdVh1dUFXN01XOGloU09nZUFRU3dhelZj?=
 =?utf-8?B?Q0svSzVmTjdnVXFNWDhYYUcyTWozaXhvMTRlamRQV1IvWWY3TnV0cURGU1N3?=
 =?utf-8?B?Q0d1SlZvdTZzbkRlODBWdjB2NXZOQ2VjTzgrU0hFaVNVRE9yS0dyY3FBcWhl?=
 =?utf-8?B?TzRmclFzVDZubVAzQTJxeGR0M2czQ1hIUmtncTE4RTlhYU4wTFZRQlpzaExh?=
 =?utf-8?B?azdzWE9sZVFQdzIzeGliNVJ4dVpnVU5KdjBsWlpBNWEyNmgrU09nRFlvanlV?=
 =?utf-8?B?K3hlcUNRbG92VFhTWWp6bHI2ZytBYlp3eWRJUFZrZGp0d3d5bkRCUC8rVThL?=
 =?utf-8?B?WDhOMWVwUnQwZHZ3RTBySXY2L01lcGN2NmJJWURWNEVZdGNnek1ObFJNSU1y?=
 =?utf-8?B?YktpdmJvelNUVkJSQWwrV1BpUnhKclA4SjhBR2VxRDl6OVlLQ3d6dWhRVjMw?=
 =?utf-8?B?WWQ4NTVvNlRRU240M3ZCQ3RsN0ZOUWdhUGhJdFJGeDdMQVJkRFQreGlUZDB4?=
 =?utf-8?B?YUhUTUM0ZGMvVU1SRDdXNThiOGVZNUVxVG9lTy9ianQ5bkpIcncxY0NSUnpj?=
 =?utf-8?B?eGR3YkJuOEpjclNja1pHeHVEMW9JQ3NzSnR3cGF5RVdZMWIyczhZUlNod0h4?=
 =?utf-8?B?L2RqVFZoL0JSeUQwQWtDZ1hodDNBSWo1QWwyejB2MGtpNi9uWnFOY3lSYVhG?=
 =?utf-8?B?NXFSTGRNcmlGMFV4TTZtQkpPSWpGdkRlZGlwY0VCaEFOemcxc09xckpEczRp?=
 =?utf-8?B?dDM5a0JMRDBvVUlWeXQwc3JCMjZTMTVnaUlHcEFMZ0VyL2JTQzYvbTJmRGVk?=
 =?utf-8?B?d0xERTdnVGNWKzllN20raUJFcU1Oc1JhaThxemtaYUxzTGt2YnpCVkdxR01i?=
 =?utf-8?B?MWxZdGpzekdsRmdlWnNTRm9oMDFtQm80eldleTZxMCt0NkdqMVFHOUwvaUxo?=
 =?utf-8?B?cWkxeUJDaVdSVG9Pb3IxWDE4ZEYrN3FoMXRkMjZVL0dudDdJOXdEMjY0cCtV?=
 =?utf-8?B?ZnhYUkI0Q003ZDdMT2RyNmdqVThSUzhoN3NlRDB1UEhxdzFJNTUrZkkvMlY0?=
 =?utf-8?B?YlVDS0R2dVhkSndhM0VCMXh0dFZGbXhMK3FCbGJIdmtTbnhwbWcrRllubEJ6?=
 =?utf-8?B?YWJQUCt3czJFVVlVN1NUVXJ1V2ZLU0J2WDUrandURkFUQ2hkdWhpZEpjWmRZ?=
 =?utf-8?B?ejllMERrREJ6SWtieWwzV1R4U3I2MmFyczZ0UVlSbWxoYS9Qb2ZqSGdSTU96?=
 =?utf-8?B?Vkd0VVV1UFc4TXR5RnhjUWxjM3ZheUhGVmZlVmlwME5KeCtHeXNwM2cxbkho?=
 =?utf-8?B?OU5HT0FSVCtsTXQ4RSt3L3VRbzZTTC9GMU1jL3J2cGdMc3RUY3VGc1dMVy9t?=
 =?utf-8?B?TXJUanduKytOU0FNSmFIcTlqYlU4UGY1bzlVV2FjZzRiczJ3QytLclBTeExV?=
 =?utf-8?B?Y3JnSmd3eGMzMkJQeVlqY1FvZ1hIUEdKenpvc1liaXlqbkx5TWVXVTVoNUVt?=
 =?utf-8?B?akRrNXFyT1dIVkN5Q0dla1hCTnVWaDZYY1IzZG03dG1vUytScGxRYmhaSE9X?=
 =?utf-8?Q?s33W1P?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmRENDlJclZGdVhnYmtEaXptd3hzbmV4cEM3Um5QRi9sQysxeDNCR1JzVlBM?=
 =?utf-8?B?R1piNzZrRFUzRnpTdGtVL2RTL3lJSlBWY2ZxMEE2Um1nTzZ4MXJERmRRWVNQ?=
 =?utf-8?B?VzQwUUlkeGg2ZlY4TnpTbWhtZTdPS3o0RjhKcXVXc2w1MnV6MThSa2xDQmVz?=
 =?utf-8?B?K1NqWkdsSWZtTGkwZVlHMjR1RTNCaWNoTHdYUUF6ZGxPVFZhbXluV0JNYm1n?=
 =?utf-8?B?SUxQYlFlU0Q2d1dTMS9BUnFIYVQrR043WTBlMmQ4SVFnMStmR3BMZmVhN21s?=
 =?utf-8?B?c3V0eFdmZmlyRjNHVE01ZHNqS3licmlSamo2alVDVDdJSlBwS1h4NlNRalJn?=
 =?utf-8?B?M1lic2MrbWFjUnEvMURSSm0yYVNxRlhxUTkrZlFWMHVRMzRBa0ZYU01Na1lD?=
 =?utf-8?B?NnFtcVhZemRrMU00ZTVzTmNDL1l3NnF4dCs2MVg1bG1KQVRuZXJYY2MxenlL?=
 =?utf-8?B?cjhpMjRtUmI2WnJmUndqMlV0azl2QitFTnQyL1A3dGVsS2V6Z244WUJUSDRM?=
 =?utf-8?B?bG55TDRQL3VHdFBHNG5sdjEyRVJuOW5XeVZGRGNtSkdlTlFtWWpDakJ0enBO?=
 =?utf-8?B?YnY3UTRUZ0RzSTlxS3RzT2NQby9BbkxmbkRHVCtPWXBzZE8zeUN2YjFQVHE4?=
 =?utf-8?B?NE9qdlFpWmlocmRtUVNZNlcveVFsZVBKSFdaaklNMUVqWnFhR3hYSWJwUmJm?=
 =?utf-8?B?RGt1elJPLzN4N1F6L05QOC9wa0c1TVVGQXg3dEMyN0VtaXA3YjdVL2M4Qzhl?=
 =?utf-8?B?N2xEcFZjcmtRNkN4NGowMVFkdXFUNDVSQXlnUjl2czVSSTArYko1aHBHRzBJ?=
 =?utf-8?B?MTlTdWZGcUJaa3Zqb3RBdFRKQ0tRK0lmb3dQODFPZTFKeWIvSFBvSCtxbElH?=
 =?utf-8?B?TXoyRnpaY1RFSHBLRkI2Y3Y5QnRMQittQVpCNXNkVHFqUyt2YVNIQkZPOUJP?=
 =?utf-8?B?S1ZHTDhLVDBndVZNMUZaZzJwZnFkNlhLSytSSncweFdkSnRVT2taWm1pRjc4?=
 =?utf-8?B?QmhEV3dNaXYyNUM1eGNFZXFqVEN4SGNoT0NMM3FJdlFjVlBabWp1SmNhNE5i?=
 =?utf-8?B?aFl5WXFxN3llcCs5VVFsWjZoSjREY0JWRjkwY1ZieFBOVGpIYnBaMTlaakdG?=
 =?utf-8?B?NmpvVnhjWjltTmVGNnE0OG4xUkhySEg0SGwxODdOYTV1Q0RaV1h5ZW4ycXB2?=
 =?utf-8?B?dmtsZ2h4VWNSUklSU2ltV3RUMmExRnRQZnNMMldKWGVrbnRTV2FWYU1hUzhq?=
 =?utf-8?B?SithNHc4MjkzODJBN205Mi9kUWhiYmdlTzA5MEMvNEl3UmxmemU0ZjRNVllK?=
 =?utf-8?B?QzVidEtNNWh3aGZ1R3h4RVpHT2QybDhjV0FUbDBLWHZkZ1pLVVRhR1RGZGlD?=
 =?utf-8?B?eGdjM3ZXWmYwano4Y2Q2dU1Oc0hvSEZ6UndzN2hDNStsQ09FVWFhaWFGNldC?=
 =?utf-8?B?Y3hKc2x4V2F5cjZSaUpxQm15akZaWURUVUVWaWZJczdyZTNKWjR0Z2VMNlVZ?=
 =?utf-8?B?SitSSE9keWJyNjBEeVQ1QWRBUmUyRGhjQllCcFZXYk5uVVFFZmI4OWx0MUJM?=
 =?utf-8?B?dHJYM2tSZHNrZjZxdnRHUjVGZVJsZktZd2hXNzQ5MlNUZmNLN3dodjM5ZGFq?=
 =?utf-8?B?QkJZQXg4NERWaG5wTnhtVUs2STR6eEZ3aXRxaGlsdkxvTzQzcGNHcnRhUDFt?=
 =?utf-8?B?RlNiL0tnS1pWRFlCV3VsdkQ1dDdmY0hLUFVEK2xBdkUzN3BRR2puekNMWnlT?=
 =?utf-8?B?cGxPZ0lSNTZ3RU8xQnBJQlV1b21hdGpVU2lzbkZqTTg4T0VMQVJWeS9Ecm1l?=
 =?utf-8?B?WTM4WmZxd1dWZXFkeWZuWTloZ2IxaUpOVmNzTFcwSFRqdlJjbzh2TEt1YTdK?=
 =?utf-8?B?V0N1azFzZTBodmdHWE1FVmVoMGxqNFRHQ3RTaENPd0NuM2FTS1c0a2xHUWIx?=
 =?utf-8?B?WXEwb0gyV3FKUkpEV1dlMVBla3lxR3IvWmw2NGJPbUlmYVFlMUdzbW5vRjRC?=
 =?utf-8?B?YmZVTnBweE9VUFV4cWU2OXRHWmZFT05kL2t3WmFDUGl0eDNUTEJnd0Ntd0M4?=
 =?utf-8?B?OWhBUDlIVncvV2FnZlJCOTMrZERwbnJTRG5FWmZWNEtnKzRXZ1FUaVl0NVgw?=
 =?utf-8?B?SUhsWTl5VCtmdmFmc2JKcld4R3FoSDgwb253V2lQOGRtMVNBdnUyam1SUVVY?=
 =?utf-8?B?bkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	v0P7nqY4t9M4X1MGIio6tQesRV45EFGhjE8SlO++o0sVjT3hiNM4f0Qsox9eJg8st1r1YhQAm+pWZJgR0iRiOiBvsf0932bRcBGug51Ky5wGNOz9cmvysNYrrKfN6nSd6gNWgaPVs0CzsLNY1oAo0aLw8DT/PQbMNDMNE8YdlFVG/VL58cjHiErKARKLJ3TnepAn9DLNC0mrxqPHD1ZYVMeYXIfPSXmCaubAMsrBhiCUZ1HcErOgzQGLgS0ZnaWCb4AYqzFp30d1AUb7o4OtEmErmt2hiSoTIcDUAidwowaonat4ZOw4gKdRhPT5SQDwko5I24re8EySjN/xT7uPLxNyOtbLn4OzV+NVn2rIjzb8m2/GoB3UqBDgkTWBKjUV3PfIcjBsBT9C0mniefOozwCX7sSp0W6jo+OMVXJ3rCx37Nk3PtoarBKVGhW8O0kxo36bxM8thyo39hFKn+R+nxMieRJ0hmTOCrEK+kmmVLhfqThYKFdSPMOigcJ/grJSOqfuAg2EweauZtcmb3ucCEn7RjN+LAbUr5moZ75eYFrOwtRSE/Ha2l/lk4j5CpRe09ylkEdEKa8pQSn+g37jKDp5f8I/GZUcKCehPlSO2H4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bc88acf-b756-4bfe-e6c3-08de39a3954e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 17:26:28.2820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YkamVPTs1zkIR4JDVlfPE8WfQzR1SFTAVamnnEiqFQKJsqkXZS1yxjVE99IcO422uXjOut5LrX4EICFH7jdmIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6473
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-12_04,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 bulkscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512120139
X-Proofpoint-GUID: 36PMtSIMxDtiTv3ChMCtHt_0cSBTfNvR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEyMDEzOCBTYWx0ZWRfXwoP3Ub4KgRwF
 whMVdxIbvCvvph9kUeMmNcgI5F8y9P6fVku82Jh8Jhz2DqlUPI35w1lEAuE4GQxwSfzwTwY1W9X
 cTTqbdkF3pKhriYzn7wuF0O/2RvAxjApnVc/CrYCSrvIWqAf25SjGh2PfZafgxqvbp687MvdY28
 wUsq5tL+cJjePKnYqZ0mofq3iOkWVgUcvFXH/7+64sCaezPfTGKP+jTGXL2thSLhFxwporQTDMu
 3qoIhxlMvBgJaiEJxbhSHlUAAcRSawhO5DjmvUHAw14GfMjzdLgPWDOzPdiASpZC3Y9N1YnTvW+
 QUYyIXLpp3RGVVtmL5eTdjj6Zr2Qc/cKR6mJLf8lN33NnqSlux9gth004D8B66SHoXkvGYFotA8
 il5Rl248X1cIpOkHrKcwH6p2LP16Mg==
X-Proofpoint-ORIG-GUID: 36PMtSIMxDtiTv3ChMCtHt_0cSBTfNvR
X-Authority-Analysis: v=2.4 cv=SYn6t/Ru c=1 sm=1 tr=0 ts=693c5049 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8
 a=UWoE4YdSp6q-zFXLahQA:9 a=QEXdDO2ut3YA:10

On 05/12/2025 22:30, Ihor Solodrai wrote:
> Subsequent patches in the series change vmlinux linking scripts to
> unconditionally pass --btf_encode_detached to pahole, which was
> introduced in v1.22 [1][2].
> 
> This change allows to remove PAHOLE_HAS_SPLIT_BTF Kconfig option and
> other checks of older pahole versions.
> 
> [1] https://github.com/acmel/dwarves/releases/tag/v1.22
> [2] https://lore.kernel.org/bpf/cbafbf4e-9073-4383-8ee6-1353f9e5869c@oracle.com/
> 
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  lib/Kconfig.debug         | 13 ++++---------
>  scripts/Makefile.btf      |  9 +--------
>  tools/sched_ext/README.md |  1 -
>  3 files changed, 5 insertions(+), 18 deletions(-)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 742b23ef0d8b..3abf3ae554b6 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -389,18 +389,13 @@ config DEBUG_INFO_BTF
>  	depends on !DEBUG_INFO_SPLIT && !DEBUG_INFO_REDUCED
>  	depends on !GCC_PLUGIN_RANDSTRUCT || COMPILE_TEST
>  	depends on BPF_SYSCALL
> -	depends on PAHOLE_VERSION >= 116
> -	depends on DEBUG_INFO_DWARF4 || PAHOLE_VERSION >= 121
> +	depends on PAHOLE_VERSION >= 122
>  	# pahole uses elfutils, which does not have support for Hexagon relocations
>  	depends on !HEXAGON
>  	help
>  	  Generate deduplicated BTF type information from DWARF debug info.
> -	  Turning this on requires pahole v1.16 or later (v1.21 or later to
> -	  support DWARF 5), which will convert DWARF type info into equivalent
> -	  deduplicated BTF type info.
> -
> -config PAHOLE_HAS_SPLIT_BTF
> -	def_bool PAHOLE_VERSION >= 119
> +	  Turning this on requires pahole v1.22 or later, which will convert
> +	  DWARF type info into equivalent deduplicated BTF type info.
>  
>  config PAHOLE_HAS_BTF_TAG
>  	def_bool PAHOLE_VERSION >= 123
> @@ -422,7 +417,7 @@ config PAHOLE_HAS_LANG_EXCLUDE
>  config DEBUG_INFO_BTF_MODULES
>  	bool "Generate BTF type information for kernel modules"
>  	default y
> -	depends on DEBUG_INFO_BTF && MODULES && PAHOLE_HAS_SPLIT_BTF
> +	depends on DEBUG_INFO_BTF && MODULES
>  	help
>  	  Generate compact split BTF type information for kernel modules.
>  
> diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
> index db76335dd917..7c1cd6c2ff75 100644
> --- a/scripts/Makefile.btf
> +++ b/scripts/Makefile.btf
> @@ -7,14 +7,7 @@ JOBS := $(patsubst -j%,%,$(filter -j%,$(MAKEFLAGS)))
>

hi Ihor, a small suggestion here, and it is orthogonal to what you're 
doing here, so just for consideration if you're planning a v4 since you're 
touching this file.

We've had problems in the past because we get pahole version from .config
in Makefile.btf

pahole-ver := $(CONFIG_PAHOLE_VERSION)

and it can be outdated.

Specifically the problem is that if "make oldconfig" is not run after
updating pahole we don't get the actual pahole version during builds
and options can be missing. See [1] for an example, but perhaps we
should do

pahole-ver := $(shell $(srctree)/scripts/pahole-version.sh)

in Makefile.btf to ensure the value reflects latest pahole and that
then determines which options we use? Andrii suggested an approach like
CC_VERSION_TEXT might be worth pursuing; AFAICT that recomputes the
CC_VERSION and warns the user if there is a version difference. Given that
the CONFIG pahole version requirements are all pretty modest - it might
simply be enough to recompute it in Makefile.btf and perhaps ensure it's 
not less than CONFIG_PAHOLE_VERSION. Just a thought anyway. Thanks!

Alan
 
[1] https://lore.kernel.org/bpf/CAEf4BzYi1xX3p_bY3j9dEuPvtCW3H7z=p2vdn-2GY0OOenxQAg@mail.gmail.com/


