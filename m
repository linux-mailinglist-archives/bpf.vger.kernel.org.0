Return-Path: <bpf+bounces-64688-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25773B1582F
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 06:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46BE754101C
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 04:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFE41DED66;
	Wed, 30 Jul 2025 04:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HEJas3s6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aWIbJexK"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB46C1D514E;
	Wed, 30 Jul 2025 04:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753851405; cv=fail; b=i0e52W21K3xuqvZLpCrBR5ckfiB9QGYQ/Fs5DmAKg6xE1+J6d6nHp2VL6vMBOPTvN3gZWFduP8NGpOXFR3F97U3Zlq27npHMK3eZRqZVucIqdv85n6jEgdmP38C0coRLDNf8dpxkpN5YMN7q7XYNgPvX4Y7jF6H2pHBcOh3+EKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753851405; c=relaxed/simple;
	bh=NGXgtpZICbCMfJf6FNJ7Fq5QTXTUr0mtdrEQ7CBdOUg=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rzv+V8XONcguIEmfiIId0TJRTmMwNlmzcTknc7RU4oW1DvEmLLBpj2wforA9TLYu0cCyiGIMbjpTIaNkuby+dtHTmTwbdNoWHAU0UzjhyOjCSiCFbqm/LGQ3Uk++J8HslDsdZt4XmYpHyDenP0WMDx3tghLJsa63Vp5YHoCRATc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HEJas3s6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aWIbJexK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56U4DjVZ029618;
	Wed, 30 Jul 2025 04:55:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=UHqjXaM6iWBBNVj0nfuWxY649MOhk/ej6Ru/00eAAK4=; b=
	HEJas3s64LCISqFn9iT9TLypc+Tx0MRb+WTC89rRxYl9/dFUbmFnS2y/LdWC/PeD
	yS6PXK77w9M07FXyHwnq7gc9BMjwLIK4VaC8lVHxTgbQG+pe7ouK8nrplbuxE01H
	SKyZjcgsbZtLxGNRk8BB/UBYglK15Dh2pDJkQ0F65IRZ2ftFkLxUqxsVD5PsgPAL
	JXg8Dl9Iz+ZYNbslyiEGzOrFK3eMqdAjCKvFxWiAuZg/+eGUvOnzRctGSNYyd8AP
	9YD2SVxeap5odzEXzwADCAIU2Wibbr8j1zWnH1bzrBkdJ77aoeyLMYGCWM64xYej
	bUYorkL8rbGrSzMvedbrLA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484qjws3rv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Jul 2025 04:55:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56U497G5011528;
	Wed, 30 Jul 2025 04:55:45 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 484nfahsvp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Jul 2025 04:55:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IMgYS55SIp7JxiDPoheey5Qa2mc5GboOQZvc1oXFLoE7THMUQvW7DKoxNRVrTwB/HQfKtlPI2sKuu+VbPu6xqBQNmbDJLxE0doazpPs9isrmyvJuEqzC8ocLHQdbl9JIsfnqsBu3FAI4QF5kv+a/B94WSTzH/aH7ksUDSqDlK1DZ37FNobUYjmzJnB0GhM26HkIQmelcfvKd/T9NdHNrHrNj9ZnXP6ZHmX+Dh/2jxD5ScXg3DtBASDVza1aCJmAyAb8q9VdO8F/E2QBRWeeqZ4FKsTXQ7kFnK3dJS3TzdQgqv8d/0+3WlBJaZWmikjqCDD4k0bU2BoWrFkLr3CRY/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UHqjXaM6iWBBNVj0nfuWxY649MOhk/ej6Ru/00eAAK4=;
 b=HN9PcsqBSaUV7OOB6uBFZ/rKruaJTxB5FHIPpgdyizGX/oVhvr4eOWI5+zIbd8ydG32dC6DoxSW2+/uZeFokm6mNDGGIKYSCupfdaKhYdCuCoojirkO4j8ev2hxacnrbdi07021xbsN1O6kyn4cOdw2OXBDHH57xUalcjYcbfAyWvZmW2QQAznNKI1N5QTfAGa8puUOGBKUnKku4V3E4lgjxO1kzjrE7RJOvaMla2Mc0H7jFiV008eZiBJD9bLj0oclE9P2R2YwFcnW6QMC8Y0jKxaiwA6vk5UscWVawOnGlVYkCXeTIdop71oH0Bb9578U8UyjIRL6XKpXW0C91Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHqjXaM6iWBBNVj0nfuWxY649MOhk/ej6Ru/00eAAK4=;
 b=aWIbJexKJ9FB0tH6C7n4u3i87sAJj1PjuLlaQOXPu7ObkgetXu1qV1WQASceUk2hvyq5qeB6UmFEIFpWhwiR73agp5Osz8CkAcM+kwHLV3ww0714WQowYNj2qdfZB335v1ShQwLYI01pGGc9eyqAESNSqPTre/X/WdqRE91XUIg=
Received: from SA1PR10MB6365.namprd10.prod.outlook.com (2603:10b6:806:255::12)
 by DS0PR10MB8055.namprd10.prod.outlook.com (2603:10b6:8:1fc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 04:55:43 +0000
Received: from SA1PR10MB6365.namprd10.prod.outlook.com
 ([fe80::81bb:1fc4:37c7:a515]) by SA1PR10MB6365.namprd10.prod.outlook.com
 ([fe80::81bb:1fc4:37c7:a515%6]) with mapi id 15.20.8964.026; Wed, 30 Jul 2025
 04:55:43 +0000
Message-ID: <e0f46e35-5152-4d0a-a2f2-54b2f83a56c7@oracle.com>
Date: Tue, 29 Jul 2025 21:55:39 -0700
User-Agent: Mozilla Thunderbird
From: Indu Bhagat <indu.bhagat@oracle.com>
Subject: Re: [PATCH v16 03/10] unwind_user/deferred: Add unwind cache
To: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Jens Remus
 <jremus@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>,
        Sam James <sam@gentoo.org>
References: <20250729182304.965835871@kernel.org>
 <20250729182405.319691167@kernel.org>
Content-Language: en-US
In-Reply-To: <20250729182405.319691167@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0029.namprd02.prod.outlook.com
 (2603:10b6:303:16d::34) To SA1PR10MB6365.namprd10.prod.outlook.com
 (2603:10b6:806:255::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB6365:EE_|DS0PR10MB8055:EE_
X-MS-Office365-Filtering-Correlation-Id: d648dfde-7e79-4b79-8b75-08ddcf2556ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YjhyNUk2ckhVVmVEeFV1ZW1oNnhwbWFxV1pteWI2czZtOWVRdmpWb3hKNDhL?=
 =?utf-8?B?Vkh2c0J5ZHdZVkRNYU1ETFZ5QWZieFlpRDVVRHRHRHlJeEhrblo2V2JoQ0dJ?=
 =?utf-8?B?ZzNZUk9aTWFuWldlOFBpb2lqNmptSWhUQWpubDlTRklaZnh0VlluVEJxY1ZJ?=
 =?utf-8?B?WXhSL2cwVDNMNEs4VklRem5mZUtUM2FtbVZKZ2RYczVyY0lwNS84NlVaZ1NN?=
 =?utf-8?B?dENCZy9Gb3IyMmpuYlpJZTdqYUVQSGNFNDZLVUo2a29HOVNKMlpQRkJ4WVZH?=
 =?utf-8?B?V1poOVdOQW0xWUUrdFR1OHM1WHZjdUJCdEthang3VXMvNXVybmk3OTdKd0Jj?=
 =?utf-8?B?bHdUTVlMOFlic3E5SWQxQklJSXhLWWZHOW1aeUZtcWpHeGVTL1FXcyt0Z3Bj?=
 =?utf-8?B?bVN2L3hMRm1yTi92a2Y4aEJxd2tMVjArN0xTK29rMkh6QTVHZjlJV0JYZWtt?=
 =?utf-8?B?VldWUkpKSFRsdDF4ZmtjeVZ5NWpqQnN6Ty9JQUJTdHhHdXlVYjJ2RTFVSnFj?=
 =?utf-8?B?TCtNbW1YMm96RCtYRUV5R29GNDVPOUFsZGp0Y0FOd2FDelViRndGQWRlQWQw?=
 =?utf-8?B?bVB4c0pMWWtZN2VPS3cyNXRZbUtxMGx3MGdXVDdSZjJhYytpQTdGTUR3alow?=
 =?utf-8?B?YW5BUEhoRGlTVHVZeFNjREJLU0l4dGlDSjR2bmJobHJpb2RmVkRXMTdHMDh5?=
 =?utf-8?B?T1NSZTR3Vmx1c0hURjJ6M3BhTVRkZEZKVzdGdys3U244RE9YVHNZZktsKzZS?=
 =?utf-8?B?RVNLUzZXNG1JTWhwMURBRFZHblJkT1ladGR2S0hGVGJjUDJ2VlpTekdtUlBG?=
 =?utf-8?B?emNmZ2VrcXFCUSthMk5GRnEyU1EvRG5vVXlYUTlQM0NHNCtqL294RWJyN01h?=
 =?utf-8?B?UXZRWkN5L3kyTzlxbWFmdWJSTFNUVHNoOTdlQW81cWZ3eGI0dURJUW45UU5q?=
 =?utf-8?B?VmdUWnZYSjNHVG11WXV6aGUvTGFzMHBYdkpnZlBaOUE1QUJUenVSS3RnNk5R?=
 =?utf-8?B?OWhmcnNqczNNcUdISkV1YVk3MVhXMVRJcm1EMVM0Y0VtNjFSWmRZcW05OFcw?=
 =?utf-8?B?bENiNStMUTdEc1ByRlhiNWl6Sk01NVRMSFBacWRlYy9OeDgwcG8vc1pTbzh2?=
 =?utf-8?B?M0w2bXR6WHFUUjVSWEorWEx4d0duU0F6bUdRVmNEN3p3SG4xYjlkS0sxT1Zl?=
 =?utf-8?B?WVhZdjZqaW5KWXVHZGhCWVUreUg5allTbzB5K0t3L011UnJzcHQ0cDFwSXY5?=
 =?utf-8?B?M3JCOU1SaGtQNmpyZXVFcWhMdkN6djZSWlBKRnZyZ0QrdUxhQW5TQktPNEMv?=
 =?utf-8?B?U28yVFlUb0FjSkZEb0IwbzFvUXlBZUtWL1FiZ2JXN2NWQVZzd2RHRkNPQ1k2?=
 =?utf-8?B?ZjZ4OFJvWDVyWUtZejNJTVBlencwbWwwR3R0VHB4WVVacFkxbXppcHF6VjlJ?=
 =?utf-8?B?T0o2SnhMUzhGWjRDdFFOeEpBZGZzWnZrS2huZko1cUkxdVdvK3pBcUZhV1pD?=
 =?utf-8?B?SU9DOUFET3NtcU4ycGI3eUpYa0N3YVl1UktnN2tkVlNSVXVuOWc0c29BQXN6?=
 =?utf-8?B?Nis3VVVReUFzTEVsK29SV1RLYnEza0NMdmd0VENjYStIaTZXMWY1b09ZNXl4?=
 =?utf-8?B?TTY4bFU2NWxVeDhoNXBWM3pSNkZFMDBnQTdtbTMrcElveXhwYkFnOHN0bmVE?=
 =?utf-8?B?bzRpa2N0Q2FPTzlsanpUWDhKQk1zeEdNbTFVWG4zMU1zM2IvUS9xNDdIWE1V?=
 =?utf-8?B?TUVDWkp5REJuazFNNGtPcExjN01ic00xSFBPMUdPU2dndG5TR1huZ2lseXV4?=
 =?utf-8?B?ekl3WVg2TnJWcTVacHluZUkveHBmb09BY1ZXQi83RDg0M2FpVXN0cm1ubnVo?=
 =?utf-8?B?RVpwODJHL3FJTWk3SVFVOWVwOVd4dnhiS3BFOXJFOUJHK2Zvbjh4MW15Vjly?=
 =?utf-8?Q?ZGZTDZ4Pw1s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB6365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emdOZXhQNDZ1SmNYNU1yYzBySERWOU1ETnFkamJCMWt1MkxvZXNvQzRqcGxr?=
 =?utf-8?B?dDA0eDVFZGNFdzhqa1htRFk5RkE2cTI5bHZOQkE2TTBRZU96TTE3VG5HMHRy?=
 =?utf-8?B?RGZ3ZGVKcG43RUNYL3B1U1hKVVF0ZzA5Q21VaXhkVDJwODF3R2xnSWl3YjNS?=
 =?utf-8?B?aWhuTjl2QlhnY2JzK09RWjlpalVUZWxoR1JtVktsRHdnT2NnOXdCdjU0ejBi?=
 =?utf-8?B?SnFnY3B3UlVzTTFteFRxUWdscVBaSVZLRlhiTXFacGdlTGh6V1dQWkl3WEFs?=
 =?utf-8?B?ZlRzR2d5bk0yZ3hOa2E3eUR6dkZCQXdvTlI0Y0dseWFuN3VTS28zV01tZG5X?=
 =?utf-8?B?VEtaZkFhM1dRbUhiMWlRS1Z1WE9SdTBjNnFQREMrTW5sMlkxS09pQkJBbmhK?=
 =?utf-8?B?aTdiZEhSMzNlRHFhU05ERGMxWkJzd1JEc3d6Z1VGRGh4YnlFVzEzU1VSWFg1?=
 =?utf-8?B?MkRpMU1KNFVYZnVHeDRhSWlwRVF4NnptdlR2SnJVZWsvSmRJMFQ0L1FndDg1?=
 =?utf-8?B?dkVDTXVyZXZYSmdnaTMrYXZNTTBxeUE4eHAzZjdqODc0NjlxanppY0o0bUVw?=
 =?utf-8?B?WnZsWFA5RytsNm5wa1FGSXN3cEw1OW8rWVp6MDJtbUhrRjF2SUxYSzdBTWM1?=
 =?utf-8?B?ZmxVUzVSMkdtQ0llek5IeUt3Vk8xNEhaUHdsV2lKRGpBV0JtdlFsdkdQMTRk?=
 =?utf-8?B?OENzaW9tZXdrWEtvSTJmb0JpUHlLNFc5azdTa3BkMk1jQm1mTXlSWVI5ZmpF?=
 =?utf-8?B?Zy82MjU1TEI1MC84U3pUR3FLdS9lTWVHM1Y2QkNJOHEvNkN0SzJ0NDVxT08y?=
 =?utf-8?B?SnNjQ3VrU3BEQVMyRU5teWVneFZVV3Y5eHUxQTd4OThhZUxmc2tJb2lmalFG?=
 =?utf-8?B?ajdPeEdjbUcwZzBTQk1Tam5lVnJ0REtEcVRuUDNXb0hEcE9yR3kzNnErWjlB?=
 =?utf-8?B?UEhWclBVakx2N3NlWHp6ck8xS3djdFlwUVRVaEpLMitnS3R0R0NiTnduQ09v?=
 =?utf-8?B?RjBZcm9zSEVzeEkvMlc1a1FGVDgvRFRqL0RuQUNWL01YNlNUOWFmYUpqSVVU?=
 =?utf-8?B?emM5cTVYQlRpSHZTRTlXK01FaDN0TlpVZndKRmMrUXR4Q1Y2emVyODN0bG0x?=
 =?utf-8?B?UHRrS01yZG5YeGFIMmRGanpCd1prbW1JN1NMNlVxdElQWHcrRmxJaWFVUThQ?=
 =?utf-8?B?YndNblpsVng0MDd0ZTd6cmFUSkIyY3RMRXVJbkw3VUpTSjFRSjFDMkdzOTlT?=
 =?utf-8?B?NDdLQk5RaHFMZ0hMcy91TWhhQjdqRWFZSElyYVZDTDFJM3BSNEI4Zlh3bTNm?=
 =?utf-8?B?YjJhQ2dzOUVTRGFUdFU2K2lCajB3UittTDJwUmZuZ2dVcWg0TnllY3d3Qks1?=
 =?utf-8?B?a2k0NGY5K09FdjZrdG9pR2F2VzFjVi8rckZEb1RBeG5YWEd3ODdRL09ualV0?=
 =?utf-8?B?cWd1RWVzajlXY0V2cmhtb21ZRFM4bExLbCtuZHNFQWRLTmtEV3o1RWRyY2hl?=
 =?utf-8?B?UlhmS0FHdVpZSkVBbXNDbGFLTHJYdFBWZFR5emtKbCtpZDRWeWl3RGRaaHpI?=
 =?utf-8?B?bC85SnNnZkRCSzByVG14ZUFBUEFjY3M1UFYyK0tNREtKWGxsWlNNSVpQMXk2?=
 =?utf-8?B?TXIxVzBZZ3RxMm5jTmdiMXRKcTAwTGZuWldibW1Wd1pjaXVZOHVsbUl5ZUVz?=
 =?utf-8?B?QzZRdzJZRjNiWXFvL2EzWkJjS3YxeERkT2RWaC90WFptMTRUVkhrVFVla2I2?=
 =?utf-8?B?Q3ZSWVN3RGMrNjNZTkpzSG9lT29lYjhINldyaC9GNFZ0OG5QVnQ0SytIc3F1?=
 =?utf-8?B?aVBMY0t0alU4K3V1cHpCY2N5aGRTSlByZVV6cVQrclFjOVJJd2x3NTBrQ1h2?=
 =?utf-8?B?N0IxSENFc1UxcHdncVk2QXFKTGFjYndMU25KdTFaVCtzdDdVMy9BejQ5SlBo?=
 =?utf-8?B?dEVOMHRvdW5kTzNzYjgyYmI5TnQ3cHJNek00eDVybUpMbnk3b0J4N3N6QVhF?=
 =?utf-8?B?OEUzcnJXQ25ydjREcFZUTzAvNGQxU0QzR1FmMWRITTEyUk9HRjFqbkdQbE81?=
 =?utf-8?B?cUtwVXZZY0tNaHlBOEFseUpmSDlBZGUra3BtRWp4bHBuV0hTbkdmb2xCYzFN?=
 =?utf-8?B?WlpWbkM0VlpNcmgzdllMU3BpN2daeE9rVjNNR3VLUnIzcXRIK1dlYXVaUGt3?=
 =?utf-8?Q?i84Rbwh6fYpPFz9j/hhqGGI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AqM/NH9D6X7L/UcH/A6f9+L8jylVvRqZUJukjdeObZkvNq/iB6dIBLFb8XotqCeFiGltQOmt3ynMrYhFAY0Ab6hH0f/bpjbZI5dOQBfvptAovMxg9z1YDfeN7pERDs4b0EYs0rJaHiAwPr94n1vCCC/b/FncS07f9e90sRF90LadkvWP3EMh2yecqJ+Q8Cn13nfaMsd8s5J94kH9dgDgi7NkfXC5FdaxMfZCjLxwrQnBT0fIdi3nwaKWfXmuA92fZP8SmI7vSLhSEirjo20R+Rc6E/+nfNpscrTyMED/oUWYfTh99wDgC+ML9ZmYkTWpYNICJB27UVSwmUhKvZgndsvNc8NtWEd8pl37uBFG6QQSDUcRekhGOyVXu2aNOVgBVPHf+6DhOag862/+GzOn4f/fbYVNj+D+bYrv2EYR9kN1g/yOeW7+kvDBM2Uo8YXVoWbYQ4ZBsweIwCrqi7VOD5MHp31xli1zATttirMz7Kfq6ONkQ53XaQ0p5Qk1uyqzBxmSYCDCk+Fsk0+BAE/UIRoxdm1oFr2JAO1oBlzEBIkxnGhH6Dhx4s+QezbTQopCGiNi1Ka+G32719AZETScwUzQ3zEC5CU1+vwJjXEyKMQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d648dfde-7e79-4b79-8b75-08ddcf2556ea
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB6365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 04:55:43.7215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y78mq9CyBGQU70wMcWQ41gjnoCIU62ZexDR09w720lhxWG4qDiDE+PMlGwkPmTmFdLbeRJOgx/TwJU8IPOoMyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8055
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_02,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507300032
X-Authority-Analysis: v=2.4 cv=OvdPyz/t c=1 sm=1 tr=0 ts=6889a5d3 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=meVymXHHAAAA:8 a=BlFbigHyMx7Wt0vz_rsA:9 a=QEXdDO2ut3YA:10
 a=2JgSa4NbpEOStq-L5dxp:22 cc=ntf awl=host:13604
X-Proofpoint-GUID: GLsH1vOptIBoOM9RgaCUVSuckgAtFiQ-
X-Proofpoint-ORIG-GUID: GLsH1vOptIBoOM9RgaCUVSuckgAtFiQ-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDAzMiBTYWx0ZWRfX87gyoq0IZoZl
 uwcH3ezhBhNZeXTKnCGUdIZdlx3s+ZH/op+/SgMB2BffnHqAC8ohRHYwPx26yXmrvE/7QOqZdm+
 0vKg76W35Lx4GOwfke+lTBhDBqB3udv8aseD081xxmA0SFPBTWudwDQzuAbNHvLxPuDGO/6WSjh
 KD2a9U4hppFBZreT5rEJDh5Jc8ocTyj+b+PzZCy2h5ypqtjZ5Wk1XfdJ64Gw/eCCXhTSeYwx5VN
 9aJc/E/6ExEqHZl1+0nkVYdqPUtrLAcQW8w8unlrxWFm8k1PrMiGGES7Mw0qhYsD/n7zSCLsZnP
 mxaaYqNaL10C7DRCfsUbRNGaW2V1ADcn++LgFVwD9MbSMoTcXTIryg2FeF/2hpogQLybNeTXX7Z
 CdTr64dOJUVA9s9j4s3dKYQxJ+e1afcN39rRkrXAfs+axtPxg/RotVCPPNeWxewYR+2QkO9R

On 7/29/25 11:23 AM, Steven Rostedt wrote:
> From: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> Cache the results of the unwind to ensure the unwind is only performed
> once, even when called by multiple tracers.
> 
> The cache nr_entries gets cleared every time the task exits the kernel.
> When a stacktrace is requested, nr_entries gets set to the number of
> entries in the stacktrace. If another stacktrace is requested, if
> nr_entries is not zero, then it contains the same stacktrace that would be
> retrieved so it is not processed again and the entries is given to the
> caller.
> 
> Reviewed-by: Jens Remus <jremus@linux.ibm.com>
> Co-developed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>   include/linux/entry-common.h          |  2 ++
>   include/linux/unwind_deferred.h       |  8 +++++++
>   include/linux/unwind_deferred_types.h |  7 +++++-
>   kernel/unwind/deferred.c              | 31 +++++++++++++++++++++------
>   4 files changed, 40 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
> index f94f3fdf15fc..8908b8eeb99b 100644
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -12,6 +12,7 @@
>   #include <linux/resume_user_mode.h>
>   #include <linux/tick.h>
>   #include <linux/kmsan.h>
> +#include <linux/unwind_deferred.h>
>   
>   #include <asm/entry-common.h>
>   #include <asm/syscall.h>
> @@ -362,6 +363,7 @@ static __always_inline void exit_to_user_mode(void)
>   	lockdep_hardirqs_on_prepare();
>   	instrumentation_end();
>   
> +	unwind_reset_info();
>   	user_enter_irqoff();
>   	arch_exit_to_user_mode();
>   	lockdep_hardirqs_on(CALLER_ADDR0);
> diff --git a/include/linux/unwind_deferred.h b/include/linux/unwind_deferred.h
> index a5f6e8f8a1a2..baacf4a1eb4c 100644
> --- a/include/linux/unwind_deferred.h
> +++ b/include/linux/unwind_deferred.h
> @@ -12,6 +12,12 @@ void unwind_task_free(struct task_struct *task);
>   
>   int unwind_user_faultable(struct unwind_stacktrace *trace);
>   
> +static __always_inline void unwind_reset_info(void)
> +{
> +	if (unlikely(current->unwind_info.cache))
> +		current->unwind_info.cache->nr_entries = 0;
> +}

Should the entries[] items upto nr_entries (stack trace info from the 
previous request) also be reset to 0 here ?

> +
>   #else /* !CONFIG_UNWIND_USER */
>   
>   static inline void unwind_task_init(struct task_struct *task) {}
> @@ -19,6 +25,8 @@ static inline void unwind_task_free(struct task_struct *task) {}
>   
>   static inline int unwind_user_faultable(struct unwind_stacktrace *trace) { return -ENOSYS; }
>   
> +static inline void unwind_reset_info(void) {}
> +
>   #endif /* !CONFIG_UNWIND_USER */
>   
>   #endif /* _LINUX_UNWIND_USER_DEFERRED_H */
> diff --git a/include/linux/unwind_deferred_types.h b/include/linux/unwind_deferred_types.h
> index aa32db574e43..db5b54b18828 100644
> --- a/include/linux/unwind_deferred_types.h
> +++ b/include/linux/unwind_deferred_types.h
> @@ -2,8 +2,13 @@
>   #ifndef _LINUX_UNWIND_USER_DEFERRED_TYPES_H
>   #define _LINUX_UNWIND_USER_DEFERRED_TYPES_H
>   
> +struct unwind_cache {
> +	unsigned int		nr_entries;
> +	unsigned long		entries[];
> +};
> +

Should we use __counted_by ?

>   struct unwind_task_info {
> -	unsigned long		*entries;
> +	struct unwind_cache	*cache;
>   };
>   
>   #endif /* _LINUX_UNWIND_USER_DEFERRED_TYPES_H */
> diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
> index a0badbeb3cc1..96368a5aa522 100644
> --- a/kernel/unwind/deferred.c
> +++ b/kernel/unwind/deferred.c
> @@ -4,10 +4,13 @@
>    */
>   #include <linux/kernel.h>
>   #include <linux/sched.h>
> +#include <linux/sizes.h>
>   #include <linux/slab.h>
>   #include <linux/unwind_deferred.h>
>   
> -#define UNWIND_MAX_ENTRIES 512
> +/* Make the cache fit in a 4K page */
> +#define UNWIND_MAX_ENTRIES					\
> +	((SZ_4K - sizeof(struct unwind_cache)) / sizeof(long))
>   
>   /**
>    * unwind_user_faultable - Produce a user stacktrace in faultable context
> @@ -24,6 +27,7 @@
>   int unwind_user_faultable(struct unwind_stacktrace *trace)
>   {
>   	struct unwind_task_info *info = &current->unwind_info;
> +	struct unwind_cache *cache;
>   
>   	/* Should always be called from faultable context */
>   	might_fault();
> @@ -31,17 +35,30 @@ int unwind_user_faultable(struct unwind_stacktrace *trace)
>   	if (current->flags & PF_EXITING)
>   		return -EINVAL;
>   
> -	if (!info->entries) {
> -		info->entries = kmalloc_array(UNWIND_MAX_ENTRIES, sizeof(long),
> -					      GFP_KERNEL);
> -		if (!info->entries)
> +	if (!info->cache) {
> +		info->cache = kzalloc(struct_size(cache, entries, UNWIND_MAX_ENTRIES),
> +				      GFP_KERNEL);
> +		if (!info->cache)
>   			return -ENOMEM;
>   	}
>   
> +	cache = info->cache;
> +	trace->entries = cache->entries;
> +
> +	if (cache->nr_entries) {
> +		/*
> +		 * The user stack has already been previously unwound in this
> +		 * entry context.  Skip the unwind and use the cache.
> +		 */
> +		trace->nr = cache->nr_entries;
> +		return 0;
> +	}
> +
>   	trace->nr = 0;
> -	trace->entries = info->entries;
>   	unwind_user(trace, UNWIND_MAX_ENTRIES);
>   
> +	cache->nr_entries = trace->nr;
> +
>   	return 0;
>   }
>   
> @@ -56,5 +73,5 @@ void unwind_task_free(struct task_struct *task)
>   {
>   	struct unwind_task_info *info = &task->unwind_info;
>   
> -	kfree(info->entries);
> +	kfree(info->cache);
>   }


