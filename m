Return-Path: <bpf+bounces-66701-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7CCB38A35
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 21:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5819F1B22DA5
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 19:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D346C2EA480;
	Wed, 27 Aug 2025 19:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CUO0J+5q";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WBdHqp80"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDEA2E1EF8;
	Wed, 27 Aug 2025 19:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756322951; cv=fail; b=NFbfC5OOjmSOtV10c2LuefYcY5v+6Zmbijcb9nImoSs+V/JdcF12gogoqXCBWgFo6nmEB7qqNL7fTPagjGwl3neZs/z/vuk22ygQG28HCZ/FAdala7D5FZbnqcZWuMY4aIblN3x0Odv9nyS1BMmi58tcbQmxHceBw7sBSWGOEjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756322951; c=relaxed/simple;
	bh=BWiqgKKffAYsVVDUE/24mepekwLeg/3cW171MYxM1/E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UOjaU1ARwUUYmNG7AgOG303Wm7UCAaVITOClTNKcDVPp/FdIoDQ+PzvPEkQLqVlivkjzCbKwlURb75I1XwV6WAbRZ7BvRO7IWuvA8+nk4h1YXeJLThRPQbaKsRNK2B4Djo7cZqNI6xm9eGpLXYI0zd8q0CC7kXZhKjI5CuOJ8ps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CUO0J+5q; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WBdHqp80; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57RJCQ9K029046;
	Wed, 27 Aug 2025 19:28:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=KTsNZ5HvTAqDlcyjXMl4n+sRF161TIxv5YhYM7LXp1s=; b=
	CUO0J+5q+2JvoTWlmBHzICaU1YvieXstDP1aZ3IWMEbAjp/4Bu9592bYe9Rfvwfw
	D91IjaUsnuRB/aQ6DvmEWGw5U6orBLO+kB9J3PZf5ZbzPP2HWvKzh/aHOQa4d2iI
	3X6q9u8M50hkMxC8D7PshkVElA45MeR1LMm4xknOuXLx7God/BvU82HNIXNWWURH
	cTJilzvdArQMAlhD3XFaxyhIABVp80xbZG2TgKs3LWSat7HRmBkb5+xSb2uRM6VD
	yxtUwlAeQ06bDF0uJRRCmuaodFLUaRDFaHnESZWSfSLg/j03zvKWigxA7SmLJoNA
	Uv2+5u6oxTwYGN9dh7zvUg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q58s74wr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 19:28:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57RIrga4018989;
	Wed, 27 Aug 2025 19:28:45 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q43b3yj9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 19:28:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iUIbglrJkc3UUudIPtMbCJPGo51SiHRn4k8f8dK1kYL8FgO4+S1uBLpkLdEl4mZMH3GiFuJHyVHEP/piaL8iqHtjnqDVNY3dEsp/c1ynVD5dcV8gC7mCEc6ekxWa8XflLPtDWVS5frYYSAyMo3lRZPG9D1/pIdlIWYFLfTNSqsYaaN5WG9yPaeMnM6nNFgIOQ2orrTPfkukOenRcQ4TMvkoy098yf2CJCDMSsd33ChpsmzoyVfWIeB1Cq5WEQmT+3yRZzlPQM4KSisUTZaxU+TlPfYpQGGKINmLdVJ+uh8PKWEtRDR0I+KXLGTq4JRD22cKmO3h7EdNNRgC5Un5TUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTsNZ5HvTAqDlcyjXMl4n+sRF161TIxv5YhYM7LXp1s=;
 b=AdtvVDNLME8N8qkid1qlimxbCYUXmHxgmsKtHXSbJBBfcKeI9c3WJs80wv0dIBccqFwuAdbFDURPIaKGGocJbq1pzo0/sdjFAQB9+LDTFZHGAfWP94wl5YCwjpjYVwMpyOEqk5mHUYv0njVOb803RTodcqQABvLW7xgNmiPO+15MMLm7tKsoeE30ZAHjUd1Kkf5iUa6Q7+r8evUnGIhL+vE3YXpM5gjsuYAplY3KlNguM2652h6Ovlq4xS58YoHMff5tVkrmW6wiTZ78qUc44sP/0DzybJIQyv5cwMeNJo+vjYRWABxkK4VY/qSx1Q2o2QW9A3ULjUZ3k86KcWN6vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTsNZ5HvTAqDlcyjXMl4n+sRF161TIxv5YhYM7LXp1s=;
 b=WBdHqp80XLahtdxeD2t2jUI1UuiqqSxznJOYIHMEXIZB0TwrtWLNXxYi45b0cAwooI2UNPOnllpHjZ06sy3OFyaGUNFDWHXDvidKOz/gpU4CEYPX73KwFkFkJDx5rnDdrhv2oOhazOL/6xUPX1qf7d1WH14cSMQsK35szyGlYJo=
Received: from CY5PR10MB6261.namprd10.prod.outlook.com (2603:10b6:930:43::22)
 by DM6PR10MB4204.namprd10.prod.outlook.com (2603:10b6:5:221::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Wed, 27 Aug
 2025 19:28:43 +0000
Received: from CY5PR10MB6261.namprd10.prod.outlook.com
 ([fe80::4a7d:7fe5:63c2:445]) by CY5PR10MB6261.namprd10.prod.outlook.com
 ([fe80::4a7d:7fe5:63c2:445%4]) with mapi id 15.20.9031.024; Wed, 27 Aug 2025
 19:28:43 +0000
Message-ID: <c41268ae-e09c-43e3-9bd3-89b762989ec0@oracle.com>
Date: Wed, 27 Aug 2025 20:28:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpf: Mark kfuncs as __noclone
To: Eduard Zingerman <eddyz87@gmail.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        Andrea Righi <arighi@nvidia.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        David Vernet <void@manifault.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250822140553.46273-1-arighi@nvidia.com>
 <86de1bf6-83b0-4d31-904b-95af424a398a@linux.dev>
 <45c49b4eedc6038d350f61572e5eed9f183b781b.camel@gmail.com>
 <a3dabb42-efb5-4aea-8bf8-b3d5ae26dfa1@linux.dev>
 <a7bcc333d54501d544821b5feeb82588d3bc06cb.camel@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <a7bcc333d54501d544821b5feeb82588d3bc06cb.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0032.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::6) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR10MB6261:EE_|DM6PR10MB4204:EE_
X-MS-Office365-Filtering-Correlation-Id: ea57bcda-8d06-42ca-398e-08dde59feeb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MEg3VVlpeXV4emlNaFVZT0x3d1hQU0NJaVpqR3RBaUp0akM5ZkUyZVFhMGZU?=
 =?utf-8?B?ejA4eHVITExhYVhiTFFmZDFnQ1FQV1RkSmtvcjZMbVd5K2hvOG8xQUFpaWYz?=
 =?utf-8?B?K3MycTBRVUJuanQ0cDVqZnNoN1lhd0xqL2xSd09tNTJVdHAyY3FPRkE3SU10?=
 =?utf-8?B?SGlhVnBZYUpzcXRBV0wySGp3d1oxbmY0K3g1elJUNDhPeTArYm5sSlFvZXFs?=
 =?utf-8?B?bmpnVXczTkUyakJBTEZWRmY3UjZlWk1RU1pwMXhnV1lXQkxwSHQ4U3VjSFFr?=
 =?utf-8?B?UDFIM3NnQktkRnlEbFY3ejVnTkZwMSt5akUwUW56TkZvOTRFNldWazZFTUht?=
 =?utf-8?B?ZEtibmcrak1wSnBDWVpNQ1BVaFh4Rkw0OGE3a2JKSXdZVEkzV0RhZkZYRUJ5?=
 =?utf-8?B?ZTd1aHp0T0NkSXZPQS9GSjNSYjNkTDRUd1J0QUFMWTZVSUw3U2JubGVvZ3JE?=
 =?utf-8?B?UWpKdmhTeDBSQUZLQ0d1b2JWZHBTdVBpRGNsOVJwQlV0TVRZV3VwOHJKQ3Rl?=
 =?utf-8?B?V04vNkVrdDdTZWxYRVY5SlY1aVNPcFEzeTQ0WE9HclpZSERIZm1yMDUwNTRp?=
 =?utf-8?B?MC9lekhSU0p4TEZXa2xyeXppSDdmZEsxNFRpN0N1Qkl2UUlpNmREbjNlcUVY?=
 =?utf-8?B?c0gzc1FKZ293UGRDMUlQNW9TWnlFMUlza09uY2pPdnpmZkw0T3REb1NIa0dk?=
 =?utf-8?B?OG9lbWVWL3J0dmJQbkwvY2JJU0k5YVFZcGFnYjNWNWRpMmV5c1Y1eXhyLzk1?=
 =?utf-8?B?QzFGNTdUSU8xUEx1WTZHMElvZjcxOUpsUUo0SWh5WmU3WkNraUNpYkMrYzkr?=
 =?utf-8?B?VmZLc3BLUXpOazRPUlU0RmRoYkpGb3BWZTNoSmFkZjdYRkd2QXNQc1NWR2Yx?=
 =?utf-8?B?cEtBZnpoNGZUbnhrT2hDcDNmWXJFM2ZNM2RtRVBtUTFCV0tOY0VzNmNoZkYr?=
 =?utf-8?B?THhSelFpMlNLRFZjM2UvTUMxci9MQXdmTEZmU29ZcVRaZ21TWlQxcTU5OHc0?=
 =?utf-8?B?cEVsSE1iekQ1eWNxY2lNc01RKzcvckkvbzl6QnF6TERyNHFQeDZqcnVtOWk4?=
 =?utf-8?B?c2MrdS9kaUxzT3NBZW9vWkhGRG50Z2laZ2ZZRnh6czQ4MmpUUXpSUklRWmND?=
 =?utf-8?B?amlYSXhyUDFrWmhVRlUydmtNdDFOOXN2MllBaTNTSEVjOVhENGpqakc5K3Zy?=
 =?utf-8?B?d3p2NzlpV0hwVGduejhUNG1uRlYvN1A5TkNGMlV0dm5lSVZlQUdwYk91RzYx?=
 =?utf-8?B?cE5QVktYWnF0dXJZNXhSTlEzRHlheE9SNkUyQzhjaUd2bkhDQVF2WUV0OG1Q?=
 =?utf-8?B?VGRrK3dSK0F5NEFWMmphTFBYdThkYW00ZUhIUXBQMC9JMktpYkdsUncxMnBz?=
 =?utf-8?B?UHZRUS9HSXVzWXBHWUw1VXVPQ1JtNnY4bFlRcVBKTzlQK2RDUEx4MWdhTGJr?=
 =?utf-8?B?SFg2R1Y0MDlMTE5JaEhuQ3FnbCsxZTRMVjBSS2JIVlVFVENtQWd5ejZhQlFk?=
 =?utf-8?B?QUY5bVFXNk5LTWJacG1jVEhJRTY5K0tuZW50Z2s0aDVmU0s4WVJEakc4T3FP?=
 =?utf-8?B?WThhQ0Qzc1B6R3ArbE44bjcrSlVzQ0FsYThYdzZHWmpCRnUrQzl2V0lTRzJu?=
 =?utf-8?B?cHdXUUEraXFVK09rSHFJK1A3d2pWOENHMjJLQzlNY3FiUW93cERYQVR5bWo0?=
 =?utf-8?B?dmtqZ3lKSWd6cTZObGl2VFg1Wm02Z21FWEo2dEJUVlpFOWJwOHpBL1lYd2Mz?=
 =?utf-8?B?MFVxOUFLM0t6OXBUeWdZVGtWS2hBalFsNTdmTzlrdUkzdG12UnZTcllXOU1P?=
 =?utf-8?B?Q0REKzFiVzZWZTlzUk0wcjRXcFhURlZqZXZzbDAyWXorN01jc1o4dnROeWN6?=
 =?utf-8?B?SENQSFRqU0VCMkt6TndOOHhaNEszamxEbTAyZTVJSkgyY0M1RmV6OExHVzVi?=
 =?utf-8?Q?2bOgTkwVVlM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR10MB6261.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnJaa3YxbVA4RWJQeEkwcThpRktXeUx5M1NVREgvS0JzT1JMbWNiZzdqaU84?=
 =?utf-8?B?TzcyNHlFVkhRbDRFOEw4L3QrMDdHSkxJWHl1NUlpZkxrT0ZuM09ENGl0VzBR?=
 =?utf-8?B?S21jcTM2WE5PL0tUQUdKSXNYbE41TzhTdHcwTFlRZzYycHl1OGhybzV2TEND?=
 =?utf-8?B?a0g0SFBjSXNPMHZITml2UzZCTGVHUkhqbTBQWEZ4aGtoSkMxQ3g3bE83KzAr?=
 =?utf-8?B?eEFCSzZCdklmM0tXUkc4L1hiZzJKMEtWRk8yc2tDWDVqNldzYmdXUlVYcElE?=
 =?utf-8?B?MnlyRENBUU10WS9Ed09oYkc5MjZJWkJ2UkwvMkpOY0kyU215MVB5ZGxBS29H?=
 =?utf-8?B?eXk2a1VBa05JNUlWWE5jaVpuSjgwT3pZa2lrUWVHTGVPZTJjN2N1SjVibFZ5?=
 =?utf-8?B?ODlHVXlQV2RpTlJhRkdSWVF3Mm5mQnlGUy9tNDY4d0VtR1RZdUZLb2JTanR6?=
 =?utf-8?B?eTdQMHArNlpSdG9XenN2czBPd2FBQjliVkhCYXpnRU50dDhXYTJSWEUzS1pt?=
 =?utf-8?B?QjJ0SVV3ei9XYWlhR3V4NGF6dGZscEdEM0VWRENwR1hmaEdCekFNbHJIVTVh?=
 =?utf-8?B?RXgzN3E2Rjh6S3cvdncvd2wxdXpSbjZtVDlEYkk2SjNQQ1hTb1F2ek5aUmNo?=
 =?utf-8?B?dTB5bDIxRkd4cjBMMXZjS2s4QzlpK2R3ejBaRElWQnlpNjBLZVc1b2JBNUVy?=
 =?utf-8?B?WG11czJ5eXZib3hLamJXcEE5NzROa3JuV2ZOTWhEcEY1UjVvZkNSdUxJTnhx?=
 =?utf-8?B?WjMybXVUc3dhb3FBUVVDZmFhaHd1a3IycWRSNU5oTW55cjROSktxVkFoYktD?=
 =?utf-8?B?eFljMHVrU1FyNVpZZW9LZTJQUFVjd3grbnZwN3FxTEFwbVVzKzNlVjd4dzlv?=
 =?utf-8?B?TkNzWEViaVBlREJCcWRjd0M5YmZxczFta2FNcW1sMm5GRFU5RFMvZ3NjdEsz?=
 =?utf-8?B?M2crNHhFSmRNbWVoRnhVc2pvVkVPNEVCYTVlQTh5K1djWjFYK29IblpDOVVX?=
 =?utf-8?B?enk0QjVJV2xnTVNVcUVPMHhxUXYzNmt2dXJIWEcxcVNjdElpbGYxVEdJZitM?=
 =?utf-8?B?SHZDWS9NeHZ5eFpZQWFtSmR3cUs4UGhDZFo0NFRjbzJGR1RYNVZaMFRnenQ2?=
 =?utf-8?B?Sms0SGc5MDFKRDZWNHRWZ3o5bU1EMmM0WG5jMUhMTHQ5M2Y5TFhpODBaaEFD?=
 =?utf-8?B?bTdjMmpOZFpsY3JQQjNDWWIvbk5odkp4VlpLZDFPdzFDYWxzQlJld2V5WUdP?=
 =?utf-8?B?MDAvZ0FHbXZETU1rRHNoc2pxTlNHK0xyRXprOUNkRE45cHFGazBZZXVHZHNJ?=
 =?utf-8?B?TDI0bjJDQm5NYUs1bFZyVzJTOWNRY2NmRmp1UTV6TlZsclpjMTFybHVQRWYw?=
 =?utf-8?B?UXhWYVpjYVBOa2NMeHZyMG9Wdlp3ZnY5NXdvSFRaZmlpOEhnS0hVRHhHdFZl?=
 =?utf-8?B?d0V2YXJVRVVsR2hGRjJzQ2RLMURDUU9zT3lkSyt2dWMxaGsrQTFHbVlKUUZi?=
 =?utf-8?B?SEJFZ2t2eWt5TXB5dnBFVklUYThTUzJFTHducnZaWlYxRm5UVENPZ2JEZXFt?=
 =?utf-8?B?VmhVaTVFWjQ1UTRWK3UrbjRmRFdFekttQkhIN0tBdGVKeG1sOUtybStMWFlu?=
 =?utf-8?B?NFdUVDRWckg2d2RnbUNiM1RhTFQxUi8wTkNTN2EyWk9mQmt4VkhDdEd6YnlX?=
 =?utf-8?B?dFdUdzRxTnN2UlJmMEhsNDZtNDFPYjVaWUt4WnFodE5leERhWTZ3QnllTEFL?=
 =?utf-8?B?WTRIUi92SjFoZlE0SktWY3VYcUl6UkZQSHhnREd3LzZlUm1aOUVXcEFxSzJl?=
 =?utf-8?B?NnhRY2dGNkNuTGpLZDFnSWNlS3VjQ3ByS3owZmFHbXMzSHdTc05LVEsxM0hy?=
 =?utf-8?B?Y0VPWlFhTnpiL3RYdDhZaGkrcy9MOGowRmpoQmtQQjMwZUxyakNkcEJmWlVr?=
 =?utf-8?B?bFVTVkRvYWJIcG9BOUZQMGRwZVRaVU5sMVNxRzBsRGRZTVhZQ2dQa1NMQ21I?=
 =?utf-8?B?K1YzNW5mSFYrcWExQkVMRGdtT0F5MFlVUW5JbmV2cnFOcFIwckkrMG13UUVw?=
 =?utf-8?B?M1NZT2tjT0VncHhxUGh4RHpiYlZDYmVRck9EeldwYTVLdmR2cE8rZ01nWWlw?=
 =?utf-8?B?eWJmQ3oxWityU2w5RFVwaE9aOFJGVWF6RVRNajZMWkxFcjNmbHk0ZG1uL00x?=
 =?utf-8?B?c1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8ICLxrYEETmolLUvJXakboELUyJhaSqLovenRqbAUtZKDy//65OCGfhrDxnirCa4Ev3Y6om3dcCwKLcvFcu2OGT9CtmUPsiMNzuqEwuWMgsCmJYvDroVW/1zYM2G7ajfvolcEEO5SW2kZ5d4aPnImb/tvwSWuKnXJ8f8hK8fFbztZ9kVwXCFLUZ2Kr97T0FkEXbZMfNo95kbTK0KoBz+74ctV5S5fbvshSvbadftJqcdfY0E5b8UznXiu0wSEw4X9dqo/scF00GdhoDONUC8F1ut/eD8k8E6DPWGlxscHhZWKyEzpycUFTyf9z/0QsOPjtkmUQ+3KIOMRjh+u/mHGbfbscahcBuoJb3REgo6OO1COnacyJX5XH4GNMvQf/x4NuI5dycLhZsGK36SE2vb9AClxk5iDEEatlYBnSV2GENSnxQ3XnjdByE7dY51kB8GSHTvi6GTAd7d+ICCu2nNb6Bt7UZDOAhmyxgvh4MtcYFRI/NwUYqPeSNagieOkjTKHB4421DC8+TGiHGlppOo6JRGUr1ab3wSXOZ0+2MkfyG0dpR1eYIMNpmLBf/Xvf4LGLhVMjNfvU1/joXY5FXM9/RLdlwxSUzC3M2/pcDhnjk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea57bcda-8d06-42ca-398e-08dde59feeb0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 19:28:43.0222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5v3BIlFPX1JrvPuRgI2VPR1Qsk68iXycCKvcl2XU0DCTCEuQP6f0hx/wUz6GrzSKsELhvjf1Sv9gCQw+L8MyzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4204
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_04,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508270167
X-Authority-Analysis: v=2.4 cv=J6mq7BnS c=1 sm=1 tr=0 ts=68af5c6e cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=AIjuZtE1ZiTHHMLNHBAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: rsj9oeDfOcpxxy6BQ-GFrAJximt_AeQq
X-Proofpoint-ORIG-GUID: rsj9oeDfOcpxxy6BQ-GFrAJximt_AeQq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAyNyBTYWx0ZWRfXw2DvSY0U+9UD
 iX4zbIXfqdkba+P40vaQihy+lD1n5UUgV4lOdkr0POPxNMK6u3niipHRO4hh3DXnDqCuudIarTj
 rI+aqbUT/y5gDN7TfdJKDlwZ3pHpBTZSCXaxzGdqEqT+mOKZ4I2UwkabKq9LDk2YWro2OqvBnhZ
 nq1tC33JDnwPLullhABEWNxqNxhzRF1sUXeYclis4GqDu8Bvv41tYVpLkJGreoGn4DQiSyKKZwG
 On9rEUbi51lDrOt0YKR4eWeTaVkiGPjboii/WIF40s6jBDc7Hg8g/J1Zj1r3IulRTUd4gT1UBex
 YGgxEZWWWjP3IE96zpXOvzdWF//c0I7gNEzMJpnzux43dsc/QdFuJeuKkLu4XqEKq2Pg1MpfPPJ
 zaIoT5SD

On 27/08/2025 20:13, Eduard Zingerman wrote:
> On Wed, 2025-08-27 at 10:00 -0700, Yonghong Song wrote:
>>
>> On 8/26/25 10:02 PM, Eduard Zingerman wrote:
>>> On Tue, 2025-08-26 at 13:17 -0700, Yonghong Song wrote:
>>>
>>> [...]
>>>
>>>> I tried with gcc14 and can reproduced the issue described in the above.
>>>> I build the kernel like below with gcc14
>>>>     make KCFLAGS='-O3' -j
>>>> and get the following build error
>>>>     WARN: resolve_btfids: unresolved symbol bpf_strnchr
>>>>     make[2]: *** [/home/yhs/work/bpf-next/scripts/Makefile.vmlinux:91: vmlinux] Error 255
>>>>     make[2]: *** Deleting file 'vmlinux'
>>>> Checking the symbol table:
>>>>      22276: ffffffff81b15260   249 FUNC    LOCAL  DEFAULT    1 bpf_strnchr.cons[...]
>>>>     235128: ffffffff81b1f540   296 FUNC    GLOBAL DEFAULT    1 bpf_strnchr
>>>> and the disasm code:
>>>>     bpf_strnchr:
>>>>       ...
>>>>
>>>>     bpf_strchr:
>>>>       ...
>>>>       bpf_strnchr.constprop.0
>>>>       ...
>>>>
>>>> So in symbol table, we have both bpf_strnchr.constprop.0 and bpf_strnchr.
>>>> For such case, pahole will skip func bpf_strnchr hence the above resolve_btfids
>>>> failure.
>>>>
>>>> The solution in this patch can indeed resolve this issue.
>>> It looks like instead of adding __noclone there is an option to
>>> improve pahole's filtering of ambiguous functions.
>>> Abstractly, there is nothing wrong with having a clone of a global
>>> function that has undergone additional optimizations. As long as the
>>> original symbol exists, everything should be fine.
>>
>> Right. The generated code itself is totally fine. The problem is
>> currently pahole will filter out bpf_strnchr since in the symbol table
>> having both bpf_strnchr and bpf_strnchr.constprop.0. It there is
>> no explicit dwarf-level signature in dwarf for bpf_strnchr.constprop.0.
>> (For this particular .constprop.0 case, it is possible to derive the
>>   signature. but it will be hard for other suffixes like .isra).
>> The current pahole will have strip out suffixes so the function
>> name is 'bpf_strnchr' which covers bpf_strnchr and bpf_strnchr.constprop.0.
>> Since two underlying signature is different, the 'bpf_strnchr'
>> will be filtered out.
> 
> Yes, I understand the mechanics. My question is: is it really
> necessary for pahole to go through this process?
> 
> It sees two functions: 'bpf_strnchr', 'bpf_strnchr.constprop.0',
> first global, second local, first with DWARF signature, second w/o
> DWARF signature. So, why conflating the two?
> 
> For non-lto build the function being global guarantees signature
> correctness, and below you confirm that it is the case for lto builds
> as well. So, it looks like we are just loosing 'bpf_strnchr' for no
> good reason.
>

I'm working on a small 2-patch series at the moment to improve this. The
problem is we currently have no way to associate the DWARF with the
relevant ELF function; DWARF representations of functions do not have
"." suffixes either so we are just matching by name prefix when we
collect DWARF info about a particular function.

The series I'm working on uses DWARF addresses to improve the DWARF/ELF
association, ensuring that we don't toss functions that look
inconsistent but just have .part or .cold suffixed components that have
non-matching DWARF function signatures. ".constprop" isn't covered yet
however.

>> I am actually working to improve such cases in llvm to address
>> like foo() and foo.<...>() functions and they will have their
>> own respective functions. We will discuss with gcc folks
>> about how to implement similar approaches in gcc.
>>
>>>
>>> Since kfuncs are global, this should guarantee that the compiler does not
>>> change their signature, correct? Does this also hold for LTO builds?
>>
>> Yes, the original signature will not changed. This holds for LTO build
>> and global variables/functions will not be renamed.
>>
>>> If so, when pahole sees a set of symbols like [foo, foo.1, foo.2, ...],
>>
>> The compiler needs to emit the signature in dwarf for foo.1, foo.2, etc. and this
>> is something I am working on.
>>
>>> with 'foo' being global and the rest local, then there is no real need
>>> to filter out 'foo'.
>>
>> I think the current __noclone approach is okay as the full implementation
>> for signature changes (foo, foo.1, ...) might takes a while for both llvm
>> and gcc.
>>
>>>
>>> Wdyt?
>>>
>>> [...]


