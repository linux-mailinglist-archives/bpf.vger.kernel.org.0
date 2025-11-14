Return-Path: <bpf+bounces-74593-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D1ADBC5F8DE
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 00:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 243D04E1964
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 23:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3DB2EFDBF;
	Fri, 14 Nov 2025 23:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mXfsLYhP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ut74lyDy"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C135227E07A
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 23:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763161459; cv=fail; b=ewX0ihi+wZBh0mt42zPQovrvY6pFgx/ZLiiC8DQJstkMt0ErCFyTZnojOLSjqK28NJlfFApUpkKj4H/LTQluihLPJbw9Ys6/N5XHod/fFUxdQkJ/IwdiMgPNaCwlwP0eVnoQ5sML0QsIZBHM5AoSL7UuC8UdIOTXXaTw+5CrCu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763161459; c=relaxed/simple;
	bh=kkAO1XMdqA+haQrL/hojd9QtRple288NP1EjGmjZR70=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f0ZDOLTg7TEisHAIZVpIrp/qT2G8hon+CeMyOhdfkQDgHWJjvAaWdG3Fgpya2CuSejIRzVjqsDDUVbIFcepvHVwId9FScj3ol8hkXmqEjHQiTak/lZGRvUb9Z5sVCzfE46I3pajlPfxnsW3NhafhtwpwPwZi4Q3nbBWGIeoWEWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mXfsLYhP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ut74lyDy; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AEJuE5G014822;
	Fri, 14 Nov 2025 23:03:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=H7vAgVvjBlMIzJpxf4gG3hL1F0aZYQyVrRnl5n6v5R4=; b=
	mXfsLYhPgY/kjIcUtImakTDNCD/en02EILuikprCgHnYYjVq0eCOeHNb4iUDbdXj
	Qv6EgaVIqKvKDXoqfUQTt0ocY4mqJT7QlN9YH5n48IruGXHXw3NbTkUqBVbqKu06
	sDLAIN0L80TH7FcjF5c67AgZYe3w7uuGO82vN+R8sGWg3w0Oe+e2gHJv6LBuCh5D
	drhk4SAp+ZUABESN5sd13L05Pif3K0itTM63fPO1Ojaq+jQjaPy/RNhHN82nW39L
	tW/Yl3nnLY+wmRRBW6WJoqAY/cAiuY2jaOOnoCQns7yFbgbZAaokSNCLQLMZVXH8
	mXPJ/3r8LCpSEag4W1+geA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4adr8v24bt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Nov 2025 23:03:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AEKU0Lt010946;
	Fri, 14 Nov 2025 23:03:56 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010026.outbound.protection.outlook.com [52.101.201.26])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vaqwdf2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Nov 2025 23:03:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ec84qYkbRskHm1kQjqeDd51UXdznrle4Qx/YZZAn71XX7Vee/axdVqr0q6t8t1D5F/qidUaF8TIu6QFGoN/JxfsO2T1PJ14XkFIAKJ9BwFz/IWYXd8+D+/Qt6iSx6b7Iblkvyd2Zf0rVMdKD+B9gfg26uUa2PaH6HqkBR8V6AJYnldL+FyiWUEtvSELvcPiAeC1Qh4u4x5TOzicKIwD8lDhDw+kgPc3NJ2N4yZvJVdjIEmtONKDh1Vm1O5NyF5nky75L/zRcsX7Qnpw/P/qap+ejh06e24VkOLTj3LIh0ZQgafUWAhaB+KrZJPZaF+pFzSBgh9bmmmGFkCJxevdolA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7vAgVvjBlMIzJpxf4gG3hL1F0aZYQyVrRnl5n6v5R4=;
 b=RhNo2feOxiBVfn5AU+rn/7+GGThAeEEOEB8dych7V+dhsOqQYuZzmbFiRu4319tjcDLW+GGPjchsQ5MJMHolrPtgipWUzS4RGGHeKjq/mmWa/HWsLYTHPoIbYfe+DrUm1XwshWWbpXEwamc95gk3iRG0MytCDsqdqLU/EC6kYhzx2fXGXJulPcA+cnthIOsUg56LD7AJ+mjabACnrTFQNf78Do6GcGR3rNQWjkmekopMIMZBBEjn1Q9Iu8bmM0f8/uGovxAibft90ALT77H+Wtfa64wpgjQjfS6GAXAaL4zGjvYd/6rkLAsFcFwldDxzGDHmpn1iHYsL/EBVZyshqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7vAgVvjBlMIzJpxf4gG3hL1F0aZYQyVrRnl5n6v5R4=;
 b=ut74lyDyXSX8XAxErorqrB0BPgnzCwH7cpjWnVRHTnqKefaLzXW7+TZKJfyx/Kr02BNPM6MGjsdsaP2+N0dcpdWSGnWYi5T1DFoMIZcQnZd1WUHLGI5IyfOdiVdjmysTxYictGcV/FK0J2VMk7mnIflXUgklNfubdHoCiMW3N2M=
Received: from CY5PR10MB6261.namprd10.prod.outlook.com (2603:10b6:930:43::22)
 by MN2PR10MB4173.namprd10.prod.outlook.com (2603:10b6:208:1d1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Fri, 14 Nov
 2025 23:03:52 +0000
Received: from CY5PR10MB6261.namprd10.prod.outlook.com
 ([fe80::f46a:ffe2:b67f:7884]) by CY5PR10MB6261.namprd10.prod.outlook.com
 ([fe80::f46a:ffe2:b67f:7884%2]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 23:03:52 +0000
Message-ID: <cd326ce3-bff1-4003-912c-659db8da6bf9@oracle.com>
Date: Fri, 14 Nov 2025 23:03:45 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/2] bpftool: Allow bpftool to build with openssl
 < 3
To: Song Liu <song@kernel.org>
Cc: qmo@kernel.org, kpsingh@kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        yonghong.song@linux.dev, john.fastabend@gmail.com, sdf@fomichev.me,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
References: <20251114222249.30122-1-alan.maguire@oracle.com>
 <20251114222249.30122-2-alan.maguire@oracle.com>
 <CAHzjS_vO3GseC0MsUpGDFdTULNYsj4rmWXt6kADa26zioSswgQ@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAHzjS_vO3GseC0MsUpGDFdTULNYsj4rmWXt6kADa26zioSswgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0619.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::19) To CY5PR10MB6261.namprd10.prod.outlook.com
 (2603:10b6:930:43::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR10MB6261:EE_|MN2PR10MB4173:EE_
X-MS-Office365-Filtering-Correlation-Id: e349f901-ee48-4738-e676-08de23d2142f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VHIyK3VOdkJkS2QzVThTNy9nYmxTMzVsbEFGbnZSQTd2M1k1eVN1SmRXNmtk?=
 =?utf-8?B?TllsNk5kVnk1S1ZvcUQzUm1QZjVkZTRPTVBiZXVaRE8xdU1lRG1FT0sxekFE?=
 =?utf-8?B?dXZaZUpQRFQyUGNLMDluU2QyaDltdUxCaVJYK1dVaWpuOWhBSnE1RytlWUhF?=
 =?utf-8?B?bWEzZktDZTJIejBtZHROa0o0dGhSdWtRUjUya2JnWXdObVg4TnE5QVg1ZnFG?=
 =?utf-8?B?YThYNk1tRXNLVzBqc1lUSS8xTGRIQjJDWFo5Z2NzZmlDdVNvS2hWdkM3WGhx?=
 =?utf-8?B?bkkxak5CcytGbjJwcDU2aHc4cWhnNkdkb1V1REowSnQ0SHNKeTZKZDEzelI5?=
 =?utf-8?B?K0Y0WUg1Rk4zdjBGaDdnWTRJUWlINGR6dXZzbDRacEpHSEkxdDE3QzFMTzRo?=
 =?utf-8?B?WlNqSk9tQ3ZBNEx1U094TkFMNUNJUjRvL042YlR1c0tPRjRXSHp1VjhSb2xs?=
 =?utf-8?B?WW4vWi8wLzY2cjRuNEtjbkZFb3g1aWFtSU0ydFkxSk1ZY1luMGVUdDVXczc1?=
 =?utf-8?B?Q29PemJNTlMxRlhpbFpnRFNsYXFmdkJEWUpVbFBwZU8wTzdFWE0rc01qWlZy?=
 =?utf-8?B?R2tRODlQSldkRFg5cUwvUFhvRWFuWTFrNDRPRFRSNFV6dUZmb0xyN2hySGFE?=
 =?utf-8?B?M2pEdTcySGhmVitpRmdXWDVtTzYza1diNzRCMTI4MDFBZjlvRkMrWXZTaHAy?=
 =?utf-8?B?S09qaW1jRVdiQ1pHYlRSMDZJYnE0NVNFdkVGTWZpcy8vbUJGemp2RitGWkc4?=
 =?utf-8?B?RGdaQ2wyNEpycnpCdmtCcTFQT3hTdGVxaHpSdjM3Q29DTCtIS2xnOW8ySnhQ?=
 =?utf-8?B?a3doSy9jUnZ3NVFqUnVIR0t2bzZVMVpCOFgra2tEaHJOc3ZJaG5NZG1ZSkVv?=
 =?utf-8?B?ZU5ULy9mVjhCU00xS25BZC9zRGw3L1htYjFCenV3dEpEV0UzTWRzQVJEb1c4?=
 =?utf-8?B?bFcvT2tFeEFjU3JhSkVZak9vRDVUQVYydXVFdU14R1VpRkJXRnhmMGpvYXBH?=
 =?utf-8?B?MlZsT1RZZGliYWZtdDVSSlJES29QbVYrbmFFV1NwT3hzSW1sb205M2NYTmoy?=
 =?utf-8?B?eFZaWml2NlNEdXIyVHpUZGJuaWVjbFNzb1ZGSTNwaWl4dkdVc1VscmpjZ1Ax?=
 =?utf-8?B?SGdNVTlpWEkvVUtJRWVSM1cxMWlWRjlvVWlhaE9va25oM0pkMERUeDFtcWdE?=
 =?utf-8?B?dWQ5VmEraEM5N2JQeWdHVCtXOU5qYllQUW9Wb3AwdFQ2WjVWbmhiUnJuenQy?=
 =?utf-8?B?MmhRU043eXhYTmhhVG9VYTM3UlJDTzR0NUdvaVVtaGFSaWdCUGpFY2l0SEZB?=
 =?utf-8?B?MUZDUDFPMkV2RDdVd0ZSUmZZTm9XdGpKaVhpQlVrazBIQ2dvL2wvVGVzNUJM?=
 =?utf-8?B?ODZkYTlPS3BZSS9Ga2lqLzhRbUtDdEZJZ2hzUDV6cXFkZ002ZnRqSU5HUEd2?=
 =?utf-8?B?M0oxcHRna1VTNU1TblZNaWJXQXhQUzRzRnhwSGVOZ0NwM3JEU0dSK3lvV2tq?=
 =?utf-8?B?WHdWcGt1OVM3cUxKcFFvKzMycDNiSEwwOUp6MTBPNUxHZk0rQU1rQ1l3eWxs?=
 =?utf-8?B?WjYzRVAxc0k4S0R5VzJHaGJjR1lwdDhBVlRsN1NsSmtxSE1tTEJUNW5CSkhK?=
 =?utf-8?B?QlU0czUwMG5jcjdMVWFWcjEra1hWWnE5OFREOXptdFdjNFNXc2VkWk5vZEli?=
 =?utf-8?B?R3hoQTVsVFI1NXg3bUU0czNZbHdDVWdhQ3FmZ3hQVjY0VUhiYWhSNm94OVRt?=
 =?utf-8?B?eWt1bEExUURCWEFVQUZzTHAzSlBHNGdUV1JpMStOeEFsQVRxeVNtNjBEZ0tI?=
 =?utf-8?B?cGFkT2IyZytsRUVzdHVyazIxTTR1LzFSUDlVVG1waHgwZHFmVS96S2JxQ0VD?=
 =?utf-8?B?QjVZVzBSUVVUckxCV2dnTlJIUGpGVFVDa2ZKUzdvZUlHeG5iaWNkVmNxaXhT?=
 =?utf-8?Q?ZamwGH5h7euTHWNCVBVhNkkbDxKHO8X2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR10MB6261.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmVGRitDbnI4U3haWFBRd2Z4VHdKdzRCeURIcHVycUZHMG1PS0c3c0RKZ2dC?=
 =?utf-8?B?NUdQUnhPM2J6WENOcW9OM21WVlB4MnROVjNTNkg3alpySHdhYzJHZ1JGK0Rh?=
 =?utf-8?B?dzVRckhMWnJDQlMvZzZOcnZLZzRMK0tkTURhV1J5dFo0MFgwdXRDKzdpUGZr?=
 =?utf-8?B?Rkt2U0JKWFpnYkVqQU5RN1lTMVh4ZlF2VDNjcUcwSkNQRTZ4ZlpnOVdLdkpv?=
 =?utf-8?B?cDZycDJ1UmV4L0ljMWNDK0hMQ0ttQVZRYWd3MjN4OTJSZUxXQmJVWWk4bW5V?=
 =?utf-8?B?ZUlZVERWTDVra0tmc2ZBVlpsLzV5OVUzeVovSDVabzNZaXg2TEZwZjl1S1cv?=
 =?utf-8?B?MGVNNDUxUHVCM29pY3FNNVMvMkNYdzdvL0RGUWg0dVNBL3hwZ1dlblJqK3NP?=
 =?utf-8?B?RU0wcDBDNG5lUFp4TGFGdjQveDMzc085NU1uaVZ5ZG9lYjBNY2UvUFg5V0dM?=
 =?utf-8?B?WG42cnVvdTU1T0t4cXlYdjJnUXhhZXI2WHZQQ3IzZUhxYmw2QzhWQlpuWkNT?=
 =?utf-8?B?Y1Q1NWZwSmZ6MEpuTlZHT2xWYkNjQXo4a0h5a2VnOW9LQStmS2xQNm9uS0Rl?=
 =?utf-8?B?U0FCME5xekhIeXdsb1Y5M1J2VnhNUE1PbndueXR4MVJpQmZ5dmEzNXc5SG4w?=
 =?utf-8?B?UnFFNnVzbm1XVnBTNHNna1J2ZFlnZ1YrMEpDV21nMHZTZEJTTkZ0a09HWXE5?=
 =?utf-8?B?dGZDY0NoU1VvcHV5aStBK05rNFZnaUJZM1c4WkhPODhZUGowTUVtbEZTNFpR?=
 =?utf-8?B?WHB6NjNPaWg1TkJUSGFZZURNY3A1OXZBU2psb09IMXZ3YUJtNHdFN3RvbFNv?=
 =?utf-8?B?dFFSNFBUcmtyUkl6WG5zRU9oNml5MXR3dXNZZFI5cFRsYXpwRDRHazAvbnln?=
 =?utf-8?B?RHplbUZESE81Q1lpU3FsTFlJQ1REUlhYMFlBaDk4dzZRRlRGcVdvcnN0N3ZN?=
 =?utf-8?B?UUxiSGFnUnBsaGFYQkIwdFQvdUZLUlFDWGgzaU5DOGxFbkFrSFdpWGRwRjA0?=
 =?utf-8?B?TThsR01wejh4Mkh2ZHZ4OGR1QmRuL1BkZG9OVDBTMzBxTzI0c1dkSlNkeEVa?=
 =?utf-8?B?NDBMRkV3MzRvc1pNSTRwVlVad3VGbnpCYzBRU0h3S3lEcU12YmtJRmQzSTRG?=
 =?utf-8?B?cDdmYU9CTk9ETkN6RWRabUMzV05JR082cUpzTDVidlpkWU91alpHU3JoaDRx?=
 =?utf-8?B?SU14ei9DRU5McFlFSTJERzUvN0cxdjIweUU4Ylc1WjJpL0JkMExZb0pVU2U5?=
 =?utf-8?B?WHNDTVlwbnRzQkxaRSs1WGZmNlgyTFU0Q0szcXVJMDNIY1BSeURhMVJNOVhX?=
 =?utf-8?B?Z203a1JhVVJyK2NRaVdtQVM0aHdpeW01TFNNTXA5QmNhdFdJM3Z1dHNzbFZw?=
 =?utf-8?B?SWRDU3ZwdVFoMnUwcTROV1RtM01XaFRoYlZEenVtWnRhTzZ6U0QwcXp0a2VK?=
 =?utf-8?B?bzJ6QTJnTnJRV3JEN1hnWXFjeWQyNm5GbVB3VVJQZ3RuZGlJdzBnQUUwTUxi?=
 =?utf-8?B?MVVjNzU0cjRYaVE5QkZQSnNJaGJudVM1NEJ6Nm8rZlhsMmdFb3hYTEhadHM1?=
 =?utf-8?B?VUVVTWdjUG5tOTF0WHJmT3JZbDlTTm1ZZjNtazRtcVJ2a2lNTFNhNHBIQS95?=
 =?utf-8?B?Q1dJTUovL25vYTVFN1BIS1p6SFl6d0lFQW9pczc4dExZeDBHSXlsV05vZWF6?=
 =?utf-8?B?YVF6QTFzN1pReGdVbUozYTlYTXU3L1QwZ1dGZi9Bai9laHhiUThWdkQ2azM1?=
 =?utf-8?B?QkZJaWdIajdoS09IOXVIUTdJaVdaeGFaeWFlMGNOQnJpUjREb2VoYlRJcEd1?=
 =?utf-8?B?UThyaURNNGZoUHhUWmtiNmUzRVdvOTFWRVltYVJxamxKRDNOdGtCV21Dd3l5?=
 =?utf-8?B?aEM5bU11WHZ5cFpQL3dnam81b3JHS0Z3RlhIdTlyYXl3Si8wYVcvTVBaNmxO?=
 =?utf-8?B?STRiODhHYm9FK0pVbElDZWc5S3pKUEVLUDh3RlZBeERuOXEyUkJlVmF2T2lM?=
 =?utf-8?B?VmVTV3Ird3V0SWFwOTFRUGUzTGUvTmVGekhrUyt0WENHZHRIOXBHZ1k2ZWNT?=
 =?utf-8?B?ZjBnS3NUWnNkQmhvSUJ3NExRemxpa29Ka2tHVWFqVm11N0JrSTNyRFNnai9o?=
 =?utf-8?B?Y2U2L3RzbkI1N2drL0xhWnd1anE2SEtMd3dHRlVrNjNESCt1bmhNTmZjYkk1?=
 =?utf-8?B?YWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Wy/jit9z/FhBAlo1qFHlIQMu2Ofeur5wYYACYdoxuDSzjHj7YqYvrQuH0SGUW2AlZoVxP6uynvv3U9YBMudvIs6EGiaWCJa4yoc8dB+rX1p4o7K7iAyy1X5sX6vY5NCjmCHsZbE5ou2h57+mbWfHU/jUKEmBrsf+/lbcz2rCKogTNf+ruYGlFlMjW5YamndBKfG4+yVwnpgxp9+g4YB1Aabv8AS+MAjDc3R9p+3n+vDNFKPbvHnu82e+6mWXPSHllZJrNDABDgmq5W7NshONSlM/oXIwtBlbWppu6cWAjxpBdnIiiDJLIajpJBGKLNJ0eiPbKDOF7w4tvUyW3oueqvNQhIa7ETD19zlUT2+G6WYhCymXn7/iz1wig+Sx6cngPydgHjrYnrhyDiDeD3vb5ofnnJRBueMc5i2ZGR8/7d9+q+9KB6GkjvfSd16kd7T52En/dqkI2UYGzn/BdEAZhccrb6Z38SHbmMA7kLasshpypX1Ow0k11KxQPYCQTO6KXSjZh0I/9DBjuULPtueICGPLZbjF4vP88xbliY2D6EXdyUGCKSm/mm3wiyGfZ7rlSjQA5ngQejgto+B5+SHtx16uNV+nA1AUucAp/qemYQA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e349f901-ee48-4738-e676-08de23d2142f
X-MS-Exchange-CrossTenant-AuthSource: CY5PR10MB6261.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 23:03:52.5806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D2sZKnaUejqKaZClo+O7fvIQS+zeVDi52wBx4Rh5/t5n011lDqbPM7G0vD9nEk0w+UsSO+7pl/Ny/e5bckW40Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4173
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_07,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511140188
X-Authority-Analysis: v=2.4 cv=YP6SCBGx c=1 sm=1 tr=0 ts=6917b55c b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Ntg_Zx-WAAAA:8 a=yPCof4ZbAAAA:8 a=Mf8EKPRXe_-vWJf47Z4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=RUfouJl5KNV7104ufCm4:22 cc=ntf awl=host:12099
X-Proofpoint-ORIG-GUID: lxFqwMcJ0kf-bO4URtYv9661ii9sRj6O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDE3OCBTYWx0ZWRfX6n59LBCCDoJp
 lFvpyQ/uU6rA1HI/M6E5iYgmnLUNE4Jxk45wCdio/TWk5EhnIbDIjZstQlZG1FCdS64kricCEzB
 uAzpUUJNrXHbm+rsw4XWZhi8h0Jryx1WkaZQ7UB3lrLzolg3r1T+vbhfbdkPcwmoGB+DupTLtl9
 f3tPg5xevWjWJQuS81k+Ti1431fZvVzEeBW8Vnf7etc3KnPvXPcH4yP4H/bqzmLVFoDKZeda8gW
 t6P3qvXYSnSynKiGmSRegUo1JR4nydhNRbSRHN3k8nJASqgdK5GZ2EiHbq0bjhlXN7qlMuaiZzV
 /9necQ/WOxtgSkLIkRA5zSvqd3GqlkYS35SK1KmDZx3YrksdqyWPe5SgffUTywILYsBcX0ib8H5
 r5mq2X7foh9nAT27Z0OOwYFnb8q7N5rNcypkJoRM/4QCqjxaoV8=
X-Proofpoint-GUID: lxFqwMcJ0kf-bO4URtYv9661ii9sRj6O

On 14/11/2025 22:55, Song Liu wrote:
> On Fri, Nov 14, 2025 at 2:23 PM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> ERR_get_error_all()[1] is a openssl v3 API, so to make code
>> compatible with openssl v1 utilize ERR_get_err_line_data
>> instead.  Since openssl is already a build requirement for
>> the kernel (minimum requirement openssl 1.0.0), this will
>> allow bpftool to compile where opensslv3 is not available.
>> Signing-related BPF selftests pass with openssl v1.
>>
>> [1] https://docs.openssl.org/3.4/man3/ERR_get_error/
>>
>> Fixes: 40863f4d6ef2 ("bpftool: Add support for signing BPF programs")
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>  tools/bpf/bpftool/sign.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/tools/bpf/bpftool/sign.c b/tools/bpf/bpftool/sign.c
>> index b34f74d210e9..f9b742f4bb10 100644
>> --- a/tools/bpf/bpftool/sign.c
>> +++ b/tools/bpf/bpftool/sign.c
>> @@ -28,6 +28,12 @@
>>
>>  #define OPEN_SSL_ERR_BUF_LEN 256
>>
>> +/* Use deprecated in 3.0 ERR_get_error_line_data for openssl < 3 */
>> +#if !defined(OPENSSL_VERSION_MAJOR) || (OPENSSL_VERSION_MAJOR < 3)
>> +#define ERR_get_error_all(file, line, func, data, flags) \
>> +       ERR_get_error_line_data(file, line, data, flags)
>> +#endif
>> +
> 
> We have func=NULL in display_openssl_errors(). Shall we just use
> ERR_get_error_line_data instead?
>

It's a good idea, and I tried it - unfortunately we then get a
"deprecated in v3" warning when we build with opensslv3. So this was the
only way I could think of to build on v1 and not get warnings with v3.

Thanks!

Alan

> Thanks,
> Song
> 
>>  static void display_openssl_errors(int l)
>>  {
>>         char buf[OPEN_SSL_ERR_BUF_LEN];
>> --
>> 2.43.5
>>


