Return-Path: <bpf+bounces-57195-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B476AA6C8C
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 10:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8BA2467852
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 08:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64B522A7E6;
	Fri,  2 May 2025 08:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BU1rar8B";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="elYHQq5I"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7B78828;
	Fri,  2 May 2025 08:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746174751; cv=fail; b=Pp+roA8OyAguHGHu792Zf3RZ+q2i/5jsJ8X6j5g9PwOfUHtHGcuDdR640ZZVZVTYWikTagoxvFVtQhpA83/EkDRKybr+dDugdvbWjNdgok0MniiDrlUdp1Yn8MvjlE8H6tqzmcqs29T90/srLM0Ja7VxNUSJNnbS3QVp671mWAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746174751; c=relaxed/simple;
	bh=52+3x1G+AH219qVa2uEKe9v+TSWdHhJ2kPJuZ1X6MLY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rchC4Zg/Kxh19ISsJ5qMlgG3UvhiAtaoojiIbp344ztWDsTf7Eu87+b14yqUQ28ANJGtxmWV3oKBICk4LPWqwAcCoEwC1mOHpdOn94p69bQarQ7S88WpZv3H+bPxoc0X9hIHlMhuco1xeMXLAy2yWird23Y8rIP2ULVMjF29NKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BU1rar8B; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=elYHQq5I; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5425WB8H013524;
	Fri, 2 May 2025 08:32:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=5FfIdidyDLu0cHoru3lUWROsxEqK0ezTz2HR/dkwou4=; b=
	BU1rar8BJ6SjstZTtbFzZSCrAX4pPmCjoCJ/DDmbTOz8SNgxnNMcga6l9l2GbGg6
	nFjuTF/jOc8ZVxneRARIHWeyPmKEj9YvMZLCAjOoBYozIQFl54/Q4xNN0iF2mZod
	jXz0eICPJcGqTXCnyAwP9uaqbkhIz9ZZCaykDYsuPHHUWq+vsU68izhfAL/mhfdT
	pyNYl/XqoAqO43R3FAur9RWOY/VSGyNeSXj3tFvXoo4vxUUjFybeA7FHaM8IYs6a
	qDyV1ByNY6dHxopdOXMr/7qBK1SQdSkOBHG6gIwI5A2SDb/sd7jIEGSTB3nvjS+R
	AxFGLcaO4fZomh1H403TNQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6ukw05j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 May 2025 08:32:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5427tXun013966;
	Fri, 2 May 2025 08:32:02 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nxdj615-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 May 2025 08:32:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tp2HFvutcjC9zVVa0J0CtDmh0DRvhiPuL0qNPpa1TycWKhBLVYO789WtlWWK5baaEdxfECnrMdyjK9sYXXKfuYqFNRvhOcYdCDtZ2TeRPArfFgTtBaO8qc5Hn9WWC2dNF9VXFNlSLsTWWKzZgBzzSOCVDKFt0HliQL8LdvUbiES9gcJgvIOPlHHz0j4rbQfsxsfJaGpSxNeTqM4laVHQmbyMaCLILUDQ3etiqkO0olNNxq3U+8uwvuDBYEq24Hb6kkhDQFpOFrLpc3fDbY68tBmGnHeu2vQjE5sYRHjPEazgFt6Bo3k7Vv7Vfvu0sDP+8BJ+kLyHI0/YDw22hKoSxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5FfIdidyDLu0cHoru3lUWROsxEqK0ezTz2HR/dkwou4=;
 b=lL0LdNGRPWmY+V7pmOPuGBx3TXkJcOcZSbz6FlXrwp9KK70xpfFxfOsquKpPVSzsSVfnTG8VOYmCV31FlfA+O/nUFhfm399oFWAwjKAaLSMoLg/Ix5VYATQj6r1xHU5M/gOGXxOOni64byTktJ3z9ThI6KfRzvNA6vk6gP3Jr3rV/ziixr92tDNRr421H4ERI0DxbbfYMrZRQLgYIkGWzGBgNd6PL65YwRsiMuxctfhg3AnjZwKvCxaBZrpd4DDSZnSsyA2I3x6CLACteM+5yTj+2+mi+BnOh+17BD/P/w1sqo5T8UuHnZuJgffJB+J6XJ2mZ3lzRxkC+WOCX9NZ4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5FfIdidyDLu0cHoru3lUWROsxEqK0ezTz2HR/dkwou4=;
 b=elYHQq5I8yctcSzuSM2uUbXKE4Q02biih6fWwE7SVvNpyis4w7bJTDWyJ1iY5JbYvOlTv5ho7HtwqeYosHZOCU5jGDWXVXX2PAtdszVRzOQh3OAHpi/6WXl4duCbZPnH6FjmwaZNiy4zzoE8SxOd9GnQgsvFxQD9MWZSGH7k0OM=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by PH7PR10MB6179.namprd10.prod.outlook.com (2603:10b6:510:1f1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Fri, 2 May
 2025 08:31:59 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.8699.022; Fri, 2 May 2025
 08:31:59 +0000
Message-ID: <7e7318c4-1592-4080-b548-acf898aef7b4@oracle.com>
Date: Fri, 2 May 2025 09:31:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/3] list inline expansions in .BTF.inline
To: Thierry Treyer <ttreyer@meta.com>
Cc: "dwarves@vger.kernel.org" <dwarves@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>, "ast@kernel.org" <ast@kernel.org>,
        Yonghong Song <yhs@meta.com>, "andrii@kernel.org" <andrii@kernel.org>,
        "ihor.solodrai@linux.dev" <ihor.solodrai@linux.dev>,
        Song Liu <songliubraving@meta.com>, Mykola Lysenko <mykolal@meta.com>
References: <20250416-btf_inline-v1-0-e4bd2f8adae5@meta.com>
 <ab9d66e1-bf54-4aa9-9f11-a3a1835acd8a@oracle.com>
 <7995874C-FE08-46CC-9CBF-AF337E7FB560@meta.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <7995874C-FE08-46CC-9CBF-AF337E7FB560@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P195CA0002.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::6) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|PH7PR10MB6179:EE_
X-MS-Office365-Filtering-Correlation-Id: e7799e0a-ab46-416d-31e1-08dd8953ce1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YlhReVBvei9DbzRCZGF0MmdPMnZpaXYzMHRWODM3bFo1NEY4MGtpWDZNUDRB?=
 =?utf-8?B?V05mVHQyK2FRT0NYUFlkS25VUTJpSXFyVmlPTEM0dVBPZHlVdVJOS2ZMR0lN?=
 =?utf-8?B?cnlYcjM2djNkV05qTGNQTXRDSmZHODh4M1hFakFnSDg1MzVaSmNBYmEzRnFP?=
 =?utf-8?B?MEs3b0ZuSTN4ZVZUM2o4dnh4RnE1UGVNWGZMNkFxeFFLL0VreXFGN2puTFRQ?=
 =?utf-8?B?WndyRUk1WFR6ZHo0aVR0RkZleHcyeXMzOVRhaDBOWDlmWi9uQ09RWWtTTjRB?=
 =?utf-8?B?ZWQ5MVVhUWoxK05ENmc0RFl2ZXI3RG5xWmxOaGxSVHlpVG1odnlYaVIvSHox?=
 =?utf-8?B?OE80VFRlWFB4NE5jbXpKYzhrSGNmNWJ5b3hCb3ZLaThRMUx5VmRLUjJZc1Vh?=
 =?utf-8?B?ZWtOSTRCWFJJMkZYTHdqZ09xVlk3VEdJVk40UjBnOFM2OHV4VVQ3VUtMeEV2?=
 =?utf-8?B?dFY1VU5KeEpJTlVFR2t2c0RBSE0za0h6WlU5WFN6dlp6d3Zyc29vclV1cUtt?=
 =?utf-8?B?RElrL2d1blE1c0tMTS9mQUZsc1J3MHNWS215U1JHaVBCNjRKQUJjZC9qTXZs?=
 =?utf-8?B?RVdoVFhaZlBRM05YS2M2cTlxVnNUYVgyMEF1b2k1aFlOZlpUdjJvQVM0U1pW?=
 =?utf-8?B?S05FdStmTGNlN0tFTkNLSjNyUXF6Tmp1dS92SUFTbDN5NDAxZFF6UzVEYUxr?=
 =?utf-8?B?TVhjZllMV0hnRWc5WG43T016SjBZVUxMZ1BjSjNMaFVBT3JUMEFlQWMwdmtH?=
 =?utf-8?B?M25IQndQNW9nZkw3ZVNCTnB3MHhGd3ppUTlpbDJ6L0VMYTltNGVnWXB3ZEpQ?=
 =?utf-8?B?bmduV0hpMHFHVjVVUTZKUWl0THVWSXcwWGQra01TQmozWWhOWFY3N21zWG9R?=
 =?utf-8?B?akZGWUhFWEVvTHNMQitZVzVSZUpxVzAxU1NUSlhmV2RxRTlKaTJGbFd1dFNy?=
 =?utf-8?B?czNTek1vL3FnWFJzT0ZlWXZqUVFFcFJIYWhnVUhMTzJjT3VpanhQa0VkMTEy?=
 =?utf-8?B?V1dERnRMalBudFM1OEI3bkdSMmpTWkkyNG0razZpVDhybUhvNzMzeFlCRnZl?=
 =?utf-8?B?UTJwL1lGd0NQOTVJOUlIOUU5T3h5bmNCS0NFalBWaFR3R1JzS09nOThKalB0?=
 =?utf-8?B?ejFMR1E3cFQvbHBjdmN1V0Mya2VvSkc3dWNtR0pvR2lTZXlKRTNFVERuSmxR?=
 =?utf-8?B?MzVKekI4bENrMFFPVjRybUU1aUZhT3VIOHFTNVgvZ0o2V0pkbVJIU0VyY0hv?=
 =?utf-8?B?dkNKM0ZGTUhLdEJHUldxRURPTW5sc2JxYWM4bW9IWUdGWFFiZkNrak9CRUM3?=
 =?utf-8?B?U21reU9ESS9ZSkV6M3p1eld4eDl1UkJTOWsvcE5pYXhhZm5oUHJUSGpRVE11?=
 =?utf-8?B?cFlGdXJjY1NLZVZyOXN0QlNoY2VKbGRtVzdaNWdMc3dJV2VsMG5XeDRwcUZ5?=
 =?utf-8?B?WGhTais5cHFROGNaNFUwS2gweWlJL3JZSmFuaVdFWWptVXdlcTNIWVd2NzJs?=
 =?utf-8?B?UldDRDBaeFBnRmkycWE5cSszbHgyVUp5amRjOEc0K25GdXJVQ1luN0hsTWlI?=
 =?utf-8?B?MVNzZEpUa1FvVllQR3JZQVRqa29LdlBpZDdJdGw0UjQyRGNqWGduRHdUNXBE?=
 =?utf-8?B?R1pXK2ZOVlZISG9yVVRXS2FTRkMrbk16aXRCYXQwaHd4YnhQeVl2T1FGdSt6?=
 =?utf-8?B?TFJIMVB1d25DejdySFpqRnZ6U3FnVVU0L2R2VE9neE9RMWo1OVkxaGUzakVh?=
 =?utf-8?B?elUrYXM1VTk1TlRZd1lpRDRoOTR6YkdQSDVhZ2NmYlRNYW5BVVVjV1Vzd3Z6?=
 =?utf-8?B?K3dVd00xZWZVL291MDNxazVKVlBhcTdMbERrSzduR1BXTWZEQ0grdFE1WHg3?=
 =?utf-8?B?Y1pQV1EzVnRpQnpFRkNuczhSR21BZndNTTJtTUkxRGRROE94cERmNTM5UUlW?=
 =?utf-8?Q?Rs3dvj3XhA0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SFVUNVV4RGJoMGZ1SCt2ZDZyOTRsdXhSell3NDQ4WVpwaFBBR1JiKzBLR2Mr?=
 =?utf-8?B?ZGlBUE14T3FEL2lrcWZZZXdrUlJiT1hhQkVSbUwyVGxkNlFNMzAxbmIzSTRP?=
 =?utf-8?B?NmVrdTFtOEV0dlFkUk1pajFrMFhwREFBS2EreWdVYnBrSExPd2xSL0N0bzVJ?=
 =?utf-8?B?QVZadFRncmdUUE5QR1RZSWtNcEpHNllkaG5nTTJFNVJXb3UrV2xXTVJSemhR?=
 =?utf-8?B?dUtYZ01tL1hrcFg1Ym1HT2dzSGFUMGxoVkl5ZkFRTXhCWC9LWXErMWw5TTlZ?=
 =?utf-8?B?ZkwzcXVlZU9tUzdQbjBGUm9QVFh2ZlN0VmFPZ3Rmc1lQejFNd2xySjZ3Mm81?=
 =?utf-8?B?K2tqVjFMREMvMGJ3Rkk2L25VTG0vdm9ULzFlV1k2WnRGb2hrSjNxSnM2UGlF?=
 =?utf-8?B?RVo1dWxNZGh6VkltbVFWdEFqcGZPNzhaMzI1R2RmR25USXZuaE5TYVRRei9F?=
 =?utf-8?B?MjhoU05menBVNVk1RHpFM3FwZC9HTm9qME5RK1lWdVVXMmx3NEVGc3IxMUov?=
 =?utf-8?B?MjdkL2VtTTRhcGY4b0ltSjcyOHB0ZURiWHdURm1QT1FNQ3BRclMrT05md1VH?=
 =?utf-8?B?NzZWb1JQeDN4TEQ4NVg5Z2wxQWFDWElrb0s3bDRmdFhqUTJkUCthVjdka1VS?=
 =?utf-8?B?SGs2TkJsUWJnSlFEbWJsY2Rqb3NuVTA3bHhxUE1aaEJIZFhseGs4VTBxaEkz?=
 =?utf-8?B?VWltV0o0VXB4Vkt0QUN4TlNtdkYxcVFqSjExcGwweU53RFdDbno1cEJwUHJD?=
 =?utf-8?B?VHVoa0F0MkxiSzlSR1hVbVVQT0xVY2tqaW5GeUUxVm1aL0pWOXA2U1Z5bHR4?=
 =?utf-8?B?bE0wWW9xVFh2UUl5WmcxaDBGcFdUdmpVYUJWaEJTVWd5RzFmVFlXYXIxUUdu?=
 =?utf-8?B?M3VaaWd1UkwvMjNlRjEyOCtXN2Rqd0NyR2pqa2NCd0lDamNZZ251RThXeXlB?=
 =?utf-8?B?Unh0QUFGZlhvMmVNQTVhaGR1WXc4YU9pVkxTQUt0eEpYQ2xBMGhkd1k1emdW?=
 =?utf-8?B?M2lRbDR6a1U3cC9uZVpFYkV2Nk5pRStXdHZwSlpQaW0rRU9MYSsxVW1BTkNj?=
 =?utf-8?B?NDRaQXFwUERCcDVwTXA2ajlybTI0YTdGb1hFcDNXdU5TcTZKZEx1WmF0Szky?=
 =?utf-8?B?akxSN1Fyc1FXMmo0eEJIMHEvMERLRG5TWW5RQzd4RmJXd2dUZm1WSkRpZ3hl?=
 =?utf-8?B?ZlZOdjJ0dnVJYzBCOUtLUDZwR1JIbFczVzZ2SkwwbkY2QzZydE1nTi84dkU1?=
 =?utf-8?B?RVRCTXhNRGpEQTErYUluMTN4OGhsQTI3cmpBZHg1RWRBK2Zadm0rRlZPdTVC?=
 =?utf-8?B?MGlNVkoxS0trRzhaZUlyUDdJTFFoWGhqcXhnbE1mdEQ1aEFqZmtpNmtKc2Jj?=
 =?utf-8?B?MFhpRVZwRGtNcngzOG5FaElnNHdpbDczb2ZqeENNaENoZzk1d0ZoT3N3UmZx?=
 =?utf-8?B?ZVZ2aWpZMHZncXR3aWpkNFF5a2dnKzA0R0hkSG1vdnkrVkFyV09Cb1ozMVYy?=
 =?utf-8?B?NTNmUUtkUVB4WDlJeUZwanN6L1pQQzJvdFd4T2M5TW5qbWFhZ3ZiUWVZdmxZ?=
 =?utf-8?B?Tk54Z21IYzZTMGVnQy9HcFJNQ0FQczdFNkgweFJXT1dyYzNmS2tnUkNtWWE3?=
 =?utf-8?B?cStHL2REQ3NLVXlYb1pHckRrOXFvSWFrcTA1dy9NS0M0ZmJIVHZKSjk0K3l0?=
 =?utf-8?B?RHRLcGNyZ0pDenRSSUwyRzlqR0hSUXkwVWNhQ2VJd1dUZ1Q1YlUvOUJnMVN0?=
 =?utf-8?B?cjI3ZThaQUsyb3d5cGQ1TkdBa1VGUUE4bnhFdmR5ektyVFd1cjRuMENyWlcw?=
 =?utf-8?B?UzRXWHRGN3VxMExEZlVlbnZWcnZkdzlCOEl4Qk54YXdFOXoxNUt4dCtHbWJI?=
 =?utf-8?B?VFJyR2VIOXhaWURmNnBNSXVoRm5jOFRHTGlhRXl5WnFIakZQUVRMYUFKNHcw?=
 =?utf-8?B?WWdob1RiUWxER280UzNCWE1ZUDlZWElvZTFybTA4TEhEbGJGUUlJMWFMbHAw?=
 =?utf-8?B?NVdENWowOHB5THo2ZW1kRkM0bTRnYy82bVlHUkc1RXkyUC9Ub1JySHFMaXps?=
 =?utf-8?B?ajZsaG5VMGgrLzBzK0lUVnkzRWFJNXJ1VlpZME5JMitzWFk1UHlxRXdLZlcx?=
 =?utf-8?B?c1BmalFWUHNwaXEvWWZqOVVXQjdOdUgyN3hra0tWS2NwSzVSaTZBb09IalNi?=
 =?utf-8?B?L1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	a2GaX9LeuyiQ1VcdeaQNuuW79pHzPAN6mhkqLuOqOAt3nN8l4BdyCHDWrQTCJkZ1TYr310pkQFWCCDOFrBDge8B7ymiJtgHKSYZvqRN64qiPhe3PTzkOo+A5rxBTyYpvc5ZNllYNfybBrOOA8YCXitW5Lcb9Xi6WN1xey/XX8upzarftzoVErTtOT2m0831oK9MqrsBza0w9QxS6hoxNu/Cq0SUYpF/Pt1mc3cH9dkx5BBUXwhgTgoMPJ+9EnTos9GYOIe65SW8dmuVSJtOq61LIz5WpcBeMdAXfaXAMQAQM42IOzcQGe7dk5+xuvqBwTK95R5154+KkhCkYE4Rk2jFbDuEBtZVrNvkRozSEHKUCJvdCjkboNAV31oKSzAdJrBXtiTn2a49AvSAxu1rVJXGA2Bovh/Vu9mUGBGZQ6m5iaYdjNuI1P6HPrdar0+OktXIUqsAglNZAnOD87osPyYWTL9VFtJesH8MCyovUSj7iyCSyh8ZHx2sj1HszfzMnV33cxR4zm/Ug0/FpvdTmgWCw99VgUrXnEFA6Fg6BcJWM6c69Wel3mGDHHR9m+TDIlGh4BHRi0S+5832MeFZYwHaveZCR6BPQ7QqooZt35q0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7799e0a-ab46-416d-31e1-08dd8953ce1b
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 08:31:59.0795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w8zGffJQgEK13FaKb0O8riv0VVGAf3iLVW/CvR04qA7sC5Tggqiod2KY49x1UM0/4VfkzoB3oTm9O8AAqxfFCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6179
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505020065
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDA2NiBTYWx0ZWRfX2sLCrj5nwfBO BAynYFdnyZ/kOaSzaFMov/UDCOb2mEC1+YpNHuIAvd54Z6GVbGnbdpwhWOFPWM4N1KyMW482sRM R2kyXqK/vM4Iib2DKDNdRwADc1O/PNZazKqXHTeQZ39ef3GMgvcejfBIt0PAxRaeuPmlPTQEd1m
 4p9wGpEnkKR7I79yegTXXDV+FE5OMG+rINvfQE7qGt5QCCqcGQyQv2ETGzJq5M3uvpfh9S01gkn fbk9rGeplTei6DTayUsJS4+LlFtekmHg9bV5YQ/dNYKPYexGXWl/CFxEA1wQJ8VuQNeyVervF89 lnSHgJwQYsYGJUIxKziGLxHVKsJJVSp5vPIiiZUch9yQIB9X3KH+poVUjiEVhJ9C/wBNz0pJmdX
 WMr/xA//Jla2zZluHHpIg2dHsRQGn4nloL42bg9HC1AQk4wXd/cFZAvBz7rJ27E2RiFjF1X6
X-Proofpoint-GUID: Al0TSP961McvDCe36BWIkyyGLOP2f98I
X-Authority-Analysis: v=2.4 cv=A5VsP7WG c=1 sm=1 tr=0 ts=68148303 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=ROgfYr79WGuyu3dZ7A4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Al0TSP961McvDCe36BWIkyyGLOP2f98I

On 01/05/2025 20:38, Thierry Treyer wrote:
>> 1. multiple functions with the same name and different function
>> signatures. Since we have no mechanism currently to associate function
>> and site we simply refuse to encode them in BTF today
>> 2. functions with inconsistent representations. If a function does not
>> use the expected registers for its function signature due to
>> optimizations we leave it out of BTF representation; and of course
>> 3. inline functions are not currently represented at all.
>>
>> I think we can do a better job with 1 and 2 while solving 3 as well.
>> Here's my suggestion.
> 
> I see how your approach covers all these problems!
> I would also add the following issue, which is a variant of 2 and 3:
> 
> 4. Partially inlined functions: functions having a symbol, but is also
>         inlined at some call sites. Currently not represented either.
> 

exactly, should have mentioned that too as this is a real pain point for
tracing; we think we are seeing every time a function is hit, but since
it is partially inlined we do not.

>> First, we separate functions which have complicated relationships with
>> their parameters (cases 1, 2 and 3) into a separate .BTF.func_aux
>> section or similar. That can be delivered in vmlinux or via a
>> special-purpose module; for modules it would be just a separate ELF
>> section as it would likely be small. We can control access to ensure
>> unprivileged users cannot get address information, hence the separation
>> from vmlinux BTF. But it is just (split) BTF, so no new format required.
>>
>> The advantage of this is that tracers today can do the straightforward
>> tracing of functions from /sys/kernel/btf/vmlinux, and if a function is
>> not there and the tracer supports handling more complex cases, it can
>> know to look in /sys/kernel/btf/vmlinux.func_aux.
> 
> Sounds good to me!
> Laying out the format of this new .BTF.func_aux section:
> 
> +---------------------+
> | BTF.func_aux header |
> +---------------------+
> ~  type info section  ~
> +---------------------+
> ~   string section    ~
> +---------------------+
> ~  location section   ~
> +---------------------+
>

I'd say we could keep location info in the type section; that way we
benefit from existing dedup mechanisms (though we'd have to extend them
to cover locations).

>> In that section we have a split BTF representation in which function
>> signatures for cases 1, 2, and 3 are represented in the usual way (FUNC
>> pointing at FUNC_PROTO). However since we know that the relationship
>> between function and its site(s) is complex, we need some extra info.
> 
> We have the same base as the BTF section, so we can encode FUNC and
> FUNC_PROTO in the 'type info section'. The strings for the new functions'
> names get deduplicated and stored in the 'string section'.
> 
> The 'location section' lists location expressions to locate the arguments.
> As discussed with Alexei, _one_ LOC_* operation will describe the location
> of _one_ argument; there is no series of operations to carry out in order
> to retrieve the argument's value. This also makes re-using location
> expressions across multiple arguments/functions through de-duplication.
> 
>> I'd propose we add a DATASEC containing functions and their addresses. A
>> FUNC datasec it could be laid out as follows
>>
>> struct btf_func_secinfo {
>> __u32 type;
>> __u32 offset;
>> __u32 loc;
>> };
> 
> We'd have a new BTF_KIND_FUNCSEC type followed by 'vlen' btf_func_secinfo.
> I see how 'type' and 'offset' can be used to disambiguate between functions
> sharing the same name, but I'm confused by 'loc'. Functions with multiple
> arguments will need a location expression for each of them.
> How about having another 'vlen', followed by the offsets into the location
> section?
> 
> struct btf_func_secinfo {
> __u32 type;
> __u32 offset;
> __u32 vlen;
> // Followed by: __u32 locs[vlen];
> }
> 
> Or did you have something else in mind?
> 

Good point, didn't think this through. I guess we should probably
experiment here to find the most compact representation but could the
location be a BTF type BTF_KIND_LOC with a vlen specifying the number of
parameter location representations? Then we'd follow it with a location
representation for each (like what we do for struct members using a
vlen-length series of "struct btf_member"s in a BTF_KIND_STRUCT.
That would be easier I think than having variable length sec info entries.

The interesting question will be with deduplication of identical
location info, which representation is more compact? I'd say we should
try a few variations and see which one wins in practice.

>> In the case of 1 (multiple signatures for a function name) the DATASEC
>> will have entries for each site which tie it to its associated FUNC.
>> This allows us to clarify which function is associated with which
>> address. So the type is the BTF_KIND_FUNC, the offset the address and
>> the loc is 0 since we don't need it for this case since the functions
>> have parameters in expected locations.
>>
>> In the case of 2 (functions with inconsistent representations) we use
>> the type to point at the FUNC, the offset the address of the function
>> and the loc to represent location info for that site. By leaving out
>> caller/callee info from location data we could potentially exploit the
>> fact that a lot of locations have similar layouts in terms of where
>> parameters are available, making dedup of location info possible.
>> Caller/callee relationship can still be inferred via the site address.
>>
>> Finally in case 3 we have inlines which would be represented similarly
>> to case 2; i.e. we marry a representation of the function (the type) to
>> the associated inline site via location data in the loc field.
> 
> Here's how it could look like:
> 
> [1] FUNC_PROTO ...
>       ...args
> [2] FUNC 'foo' type_id=1   # 1. name collision with [4]
> [3] FUNC_PROTO ...
>       ...args
> [4] FUNC 'foo' type_id=3   # 1. name collision with [2]
> [5] FUNC_PROTO ...
>       ...args
> [6] FUNC 'bar' type_id=5   # 2. non-standard arguments location
> [7] FUNC_PROTO ...
>       ...args
> [8] FUNC 'baz' type_id=7   # 3-4. partially/fully inlined function
> [9] FUNCSEC '.text', vlen=5
>   - type_id=2, offset=0x1000, loc=0 # 1. share the same name, but
>   - type_id=4, offset=0x2000, loc=0 #    differentiate with the offset
>   - type_id=6, offset=0x3000, loc=??? # 2. non-standard args location
>     * offset of arg0 locexpr: 0x1234  #    each arg gets a loc offset
>     * offset of arg1 locexpr: 0x5678  #    or some other encoding?
>   - type_id=8, offset=0x4000, loc=0   # 4. non-inlined instance
>   - type_id=8, offset=0x1050, loc=??? # 3. inlined instance
>     * # ...args loc offsets
> 
>> If so, the question becomes what are we missing today? As far as I can
>> see we need
>>
>> - support for new kinds BTF_KIND_FUNC_DATASEC, or simply use the kind
>> flag for existing BTF datasec to indicate function info
>> - support for new location kind
>> - pahole support to generate address-based datasec and location separately
>> - for modules, we would eventually need multi-split BTF that would allow
>> the func aux section to be split BTF on top of existing module BTF, i.e.
>> a 3-level split BTF
> 
> Do you think locations should be part of the 'type info section'?
> Or should they have their own 'location section'?
>

I'd say part of the type info section as we can use existing dedup with
tweaks to support location info.

> For modules, I'm less familiar with them.
> Would you have some guidance about their requirements?
> 

For modules we use split BTF to represent the type/function info etc. So
we deduplicate the module type representation, removing redundant info
already in the vmlinux BTF. Then the split BTF that covers type info
only in the kernel starts at last_vmlinux_BTF_id + 1.

So if we are going to separate location/inline info, we'd probably use a
similar split BTF approach, but the challenge with modules is that we'd
be using split BTF on top of existing module BTF, which is itself split
BTF. So we'd need to support a 3-level split where the location-related
BTF can refer to types in the module BTF (split) or the base BTF
(vmlinux BTF). We haven't got any cases of such multi-split BTF but it's
something we've discussed in the past and would probably be quite
doable; would just need kernel and libbpf support.

>> As I think some of the challenges you ran into implementing this
>> indicate, the current approach of matching ELF and DWARF info via name
>> only is creaking at the seams, and needs to be reworked (in fact it is
>> the source of a bug Alexei ran into around missing kfuncs). So I'm
>> hoping to get a patch out this week that uses address info to aid the
>> matching between ELF/DWARF, and from there it's a short jump to using it
>> in DATASEC representations.
>>
>> Anyway let me know what you think. If it sounds workable we could
>> perhaps try prototyping the pieces and see if we can get them working
>> with location info.
> 
> I'll look into emitting functions that are currently not represented,
> because they fall in the pitfalls 1-4. That will give us the base for
> the new .BTF.func_aux section.

Sounds great!

> I'm looking forward to use your patch to simplify the linking between
> DWARF and BTF.
> 

I've sent a series to dwarves [1] that starts down that road storing
function addresses internally in pahole but not emitting them yet. Needs
more work but could be a basis for us to start working to emit function
datasec sections.

Thanks!

Alan

[1]
https://lore.kernel.org/dwarves/20250501145645.3317264-1-alan.maguire@oracle.com/

> Thanks for your time and have a great day,
> Thierry


