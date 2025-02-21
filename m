Return-Path: <bpf+bounces-52177-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7249A3F7C3
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 15:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C9B04254A2
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 14:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16C1211267;
	Fri, 21 Feb 2025 14:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NRa0R1AY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OZ1/5A+x"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAA7210F59;
	Fri, 21 Feb 2025 14:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740149537; cv=fail; b=bgG34KVUxuTBGHMoN7X+pHVUyXWPZQuPhz5YwmVCpxAeaaP9YfhUhzhB7CxHy7bG/7NFhLOamBmHWfZdp3bczFUawbdewGL9FQ/RGxws9aMfMf297aixYm5qEW7M2mnccPblh3rzxUEButFl8Hoew4toCFh/KBSk4s0X2OHAWX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740149537; c=relaxed/simple;
	bh=FNjkVPCdVjcPdqlynEg/ODB1c05kmNMuecDZUxgInvk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aKJsZSrec7/s/qut6FCZorW8pR/69R0qOg1gcP/3dDKKQfL3hkPUtkHqtUe4rn44rjmRXnDIt4m4yC/Tnz/6hOs1dReFYTfJ4i9BUvTIt5mo+2YWuIwvWrV8OicgQqmnRz7jhqN7BItMxfEieNsgirCzdVBBJuY7l2eTWrLik6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NRa0R1AY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OZ1/5A+x; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51L8fc4t027792;
	Fri, 21 Feb 2025 14:52:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=WWf1nqoSpYb7DP3zndfLijq2ca8vs3HfpZyGm8e7zv0=; b=
	NRa0R1AYybBZBn8C9IzPFrUUbQGfHNBnn3xa47IH3aighBtD3DyoLUk6un1iddQR
	bJfH5mSJj01P7pge8DMLnkORUEeSF8qkMjaolaEJRlFBqZYIvuzKncnSpc7tA9QH
	RO8+7bi/XCgQj6/SAinY5xhxUyfJZ2FQVmwnFXDLVa/MzQ+Wk27l5Rkkc7R6OrHo
	jtVBmAmfIjIOzm/jcYFfG9j221t/Uu79ExLu6Mw7+Ku3QoHPeVK9R8E+kVca+Z2u
	0vNYsebqM9y9Gcl30eaxkSSmqJHCZcRZy3JdyIsgiRS42XKGHKSEpluk5mRvxJTQ
	HL1wflvURZxtOefVgT20bQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00pxc4c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 14:52:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51LESJen012116;
	Fri, 21 Feb 2025 14:52:02 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44w0b5q1u0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 14:52:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GUUFsytKwIxWefIWt5bNOnMFP1fpugtpOxY3YSGxu6ADgFInoSp7S4Ipe2r7SqV+u/UHVDV/sXqCkNSynQxdydi0T89auGz0M1O5PeTTvzizwPebjm1XnB/dlI79bdbL+peX3S/5NYM6Zq/KMMDYtLLsZQPCRn74HzZJp5ypSAVzmoBaxigj/95kGhhJ/VUeheJ84o5S4Jq1lrETsuRjfZbEsHuTUoaUAaKiTxlsavuIrCF22Wq6gTrjZzxaJqj3D+3hE5ZwtsAZ1N7I7DARMzGMxUEFUSeaXkFhXrNYi7CeG68+PZkUGC2edZBHQdt90A77BkNj7Y/4wabMULGD2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WWf1nqoSpYb7DP3zndfLijq2ca8vs3HfpZyGm8e7zv0=;
 b=IDApbKiaaDN4dL6d6ACI2r6JMGNNKWQM6qSnYfdXS2jNz5EPl3/ed/8l+JsGFKWVnFTY/tJ8jLYt+8DlsjzSi2q27xZMgVBmxQ6NlxzxTTznxqJJpY+MQYF4c1dY/9Yoz0njnuDWBGzpQwOHyDhrmZPXPyj75vOEhsIS7kwOPZtcY0EqGy+X7JA7GytE4FVI4uPeduBPY8TeflEXk03LmIC9XpGrcY7FvvHxjz5glFeyB+h2OW8lxY7meerVWN9BwJwkZJmLP3JUi8+CZE2RJOkgAMe401CdUOzkBt+g5AA4+o+LTMBmHsatB03BGZecwpL+Urvf6bvaJA6MN2c46A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WWf1nqoSpYb7DP3zndfLijq2ca8vs3HfpZyGm8e7zv0=;
 b=OZ1/5A+x2E2yRbb5jm13qjGqSMItmi5YudIEvsdlmsLgK5l2GZYoHL+kbz+1IvT/vthwGs/HQa/gJ0ZJ9ybT16r1MibsRLMZ7tdBY/ixbyL7L4N1oTJ3vwnoH0uhSgDV+AZ5NSjE8mhfo3pW8SPWzpStZLo9N5ysL02i4qFg2HI=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DS0PR10MB6895.namprd10.prod.outlook.com (2603:10b6:8:131::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Fri, 21 Feb
 2025 14:51:52 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 14:51:52 +0000
Message-ID: <221ce8b6-fab9-4f63-813b-6bd83dddf1a6@oracle.com>
Date: Fri, 21 Feb 2025 14:47:01 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 0/4] btf_encoder: emit type tags for bpf_arena
 pointers
To: Ihor Solodrai <ihor.solodrai@linux.dev>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org
Cc: acme@kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
        mykolal@fb.com, kernel-team@meta.com
References: <20250219210520.2245369-1-ihor.solodrai@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20250219210520.2245369-1-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0121.eurprd04.prod.outlook.com
 (2603:10a6:208:55::26) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DS0PR10MB6895:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d596a74-ada5-4357-a86a-08dd528746c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dVNScERCTHdOVnBRbXd5aGprYnlOUnZMOGNlTG53bFRHWnpsS1d2alRocC9D?=
 =?utf-8?B?bkZEb25pNzhwNzRLOEV4bkcyYWlpM0hIQVd2Y0JFaXByVVlTbzByN2kwak5p?=
 =?utf-8?B?UzIyc29NNTVQRWJzOVJiMnFvLzd0eFgrRDN0ZlJSSUZrT0ZKTFdKZjFNb2M0?=
 =?utf-8?B?eEhzRVVZc3JUeHYrRjFKelpkSW5kTWtrNTNzdi82clVHVFRsU2ZQY0FuMURz?=
 =?utf-8?B?WDNXUUVkSVdQcDlWM3FZaXZBcjRVZGszMnlKMVkrSE5jZ1J4NWhSQ3V5bVlD?=
 =?utf-8?B?ZkYzaE9KY2UrbFF0TENDZEJ2QjE1eWVyVVdUWERyNE4wOWx4c2ZYVW01M0hK?=
 =?utf-8?B?ZHpzM0hSRmhLL3EzTEZBOVJ3cFJFNmkxQlE4cW5UZnRVY09GMjlTa0NrVmN1?=
 =?utf-8?B?b3dYekFZQjZWV3NUb2VQOGJlRW1Wbkd6RXVXNFRFdWQ3YjY0YTV6TFFTZkw3?=
 =?utf-8?B?VG1tN1A1c05uM2l3eWxiL25xRlJ2NjdneW4wWEMwL3FBVWo0eTZlZmFqM1pn?=
 =?utf-8?B?bzh6T2VDRWRWbTR0RXlobGRtZGF3S2hPUXdrTVVHMUwrTExPeCsrVGpqM2lQ?=
 =?utf-8?B?ckJqYjVZWGhxUDFvY2lJMko2SEs4aysyZ0pOOVNvRGpFZGhrNFczc0NSUjRZ?=
 =?utf-8?B?Vkc1ZkFlYVdXaWpCWTVGUGczLzNaMEJpUVd2dGZZNGdoUG1nWDhVQ3grcXVy?=
 =?utf-8?B?ZUd6WStrUjFVM29yQ05JUzJybVRRS0JrZktNemZlYUNxaVNtNlhrT0JKaDZT?=
 =?utf-8?B?UzkxTGo0T1VJZlhmNXZvNHVqRloxRWxBamxpZ3JvTzBwaCt5M29wQldmczBT?=
 =?utf-8?B?bTVTdjVxMVVxL2xXUDRiVnNCRXFWU3VJTUlDZ3M5VFRGZVV2dklzYWpLS2pQ?=
 =?utf-8?B?ZGN0RWE4V1I4WHhoQWc2dlJDZU9xbDZFNkR2RDFrVGVxSWxPdUdxSlpQR21E?=
 =?utf-8?B?MmxvcVllTjRIK3E5SjFQdnVrVUZYNnJhclN2R2o3aTlUQUxDdm1FRkh2bEJT?=
 =?utf-8?B?elkvT29aZmMwc3NjK1ZyN1Z2VE1mTXJUM3d2S3NqR0FNandWVjRJeG0rNlRD?=
 =?utf-8?B?b09JbVg5NHRWSTJ5R2o0NVpJajRyOEFPczJqZGF6dFhXZFhzWHoyWTRnaktF?=
 =?utf-8?B?bEtHWkthS29hSDIrVmFVTHVlcjVHMERkdVk3NzhqZmNQNUZyVkZhcTB1S0xj?=
 =?utf-8?B?aGErUXFScFhOd2VZQ01yeVlHVENnekhVMEZzNWcrbGhXRzBzQlJ4eVovMnRJ?=
 =?utf-8?B?aHdML2VndS82alI4QVdCUytTc1ZBUWpkdkhUWVBCVlhoNmVzYWhqRmJBM3RR?=
 =?utf-8?B?RWFPVk1DT0pKaWIzcEtYMVVvWnIzam8xN2dWYmxxcnlqVlEyOHFQQnIwRU44?=
 =?utf-8?B?aXp0Z2xINlYwZ1pLcUJQaGtxLzBOT09HR0sxdjFjYVR5dDhTZktaME4rVzRD?=
 =?utf-8?B?QStvWlp3aHQ2NGJLOTJBbUJvNktjaE5uTkIreW5tRVdFK0lQRi9uNkVjOHUv?=
 =?utf-8?B?eEUrQlhwMUtUNnc2OEtYYVBESlE0cEVyNXNNK3g2a3VIWTVWY3UvcWpLdmVZ?=
 =?utf-8?B?Z2VJdFFmNjMzcW5SWFk5OUpQKzh0SEpNMnlHM1pmUS8zZnBiRXBlQi9ENkh1?=
 =?utf-8?B?T0c0RTVaQ2EwdnhiWXJzZWZHQlFRKzJtV09tdFA0UWEvVVdSYUdKbkU1ZEh5?=
 =?utf-8?B?SEo4eTNpZmpJUDZReXVDdFRBeFRScWp3cmxpd1dSU25zYjRaZUFneDZ3K3NX?=
 =?utf-8?B?QllJZHo3OHZ1aHZGLzV6OVRjaUZPTVNBNzVXSDJtMnRUUXIrZmNjQWkwUHNh?=
 =?utf-8?B?eXI2QUdxTEllRkpSSVJjZVorQ3ExMjNSWlI3aWlDWmxhaUtMY3VqNDA1L25H?=
 =?utf-8?B?bkJBUlQ3NUNBQlhZbitWTTl3UitqRXhSNlY0NFVwZ000aEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SEJYSVFOOEh0OUIzZ2N1VEIvR1RWRGtZdG1yWFVaNnlxeTdwZlJ3VUxuT1g5?=
 =?utf-8?B?QzhRVFR5QXdLQ1Zvak5UVHNkTTRqZUFLRVd1OHB0ditHbUcrN2ErT2lZUjds?=
 =?utf-8?B?c2RFbVRYWllYSEhCakxPSldCOXRIb2Q1UUxQZlIvYnR0bWM5VWFmNllGeTE1?=
 =?utf-8?B?UFE4bityWFFOVjVuclBpbU9pczJQTWpZWUU1OTJUM0pQRUpzZjJsajVub21P?=
 =?utf-8?B?R0NSSmRldzJLenhXSWFncjRiRXR3UGZyOUZlTXMycGRWSm1LKzllOExGNml6?=
 =?utf-8?B?NFdRbkMrWTRVNUJncUJTcGVuL2dsajJqakhXOWdwL29xUzJpQUh1VVB0TlZn?=
 =?utf-8?B?Zmo3TGoxRnJhWmlHc0hJUkVIYzJoc3FkcTd3Sys1L0poY3JuSDJFQ052c0ZG?=
 =?utf-8?B?M0RiMnRoa1d3dXY5L3htcTh3d1R4ZnlpWkxaZVlLSVlyMEVWYjFqUms5Sm1t?=
 =?utf-8?B?K3NVMjBpVVJZTTFhRUt1bEZhWWpDYTFZL1EzaGZpajBvMnpUbVZENWJCR3pl?=
 =?utf-8?B?NU9aNEVNVTlLbksxdmdnN09hTzlYeVVJeWJKSnJobnB3K1B2RmRDMSsyV2kz?=
 =?utf-8?B?WXVjMGFNR3VlRDRsU1l6bzd1UFd0c0I3S3VKV0RqTzVYM0NqVml1WFg1QXlp?=
 =?utf-8?B?RFdSMFpzRU05UGtSZksydkdIUStSa1BsQ1MrUlllbTE0NkFsYkVNbGdxdUFy?=
 =?utf-8?B?Qmp0MS9DMGg0TWxxVERKN01uanA3YTlEWWVDYXpEeFA1QTJIOENrQnUrNUZa?=
 =?utf-8?B?Z2dRTmNuREN6MHdZcEo3VE5lUFBZN2Z5UkVyV0lpZGxsdHNSRkVYMW5lNDYx?=
 =?utf-8?B?MDFpTUxaZWl1anhtVEhvVmQrajJ1bFVFSUhTZjdqMmkvSU81NnppYzFrZXFy?=
 =?utf-8?B?K2F6NE81enJua3Jtdld1bStiTnp0R3FXL1doV0tWMnBCOGx3bHBjN1pOdElK?=
 =?utf-8?B?Z21ja3IwUnd4dWllSjlpODlKMjZYWitCYWUrTkVybUw4amY4d3BvMGpML0VO?=
 =?utf-8?B?U0dTaHl5OHM3bDl2TlVhRTJkNkNwc0h1N0c5SmZjL2crOElBUkhMdEY1UXhG?=
 =?utf-8?B?bEdUTFZlS1p4WnpnbTI0d0NXOGtkSnRLTmQzNEIyNk93TG9SS2ZwZFluc3ln?=
 =?utf-8?B?T1loenNzQUNXSHl6akZsUXNmWTVaOEJJZTZNNm9ON3ptK0VPQUNSK25ZcXJt?=
 =?utf-8?B?L2VxbXRvSTJ5ZGRzUTgrWXZTNHJ6QjB2WFRpN2xLSkdGNmJMdmNYQmFESm56?=
 =?utf-8?B?UjA2R1gxN1QzOFplUzNDZGtBbWVGL0NPUWgvd1hTZUVjWVhZb0tXWHh4ZUkv?=
 =?utf-8?B?RGxpME1lbkZkUTAzWW40MGI4MktUUnIrNVBQNzVkWnBpNmJXM0hiNjdSdmVp?=
 =?utf-8?B?VU1QY2tQUGtiTG9kS2lMcHllOTExaUJCZy8yOTFTdHNUSFJuWGt2SnM0amJR?=
 =?utf-8?B?dmwvL3ZQNVpCTDlIZHYvR2J5VmlDdDVmb1ZudlgwY3NNQ082bXhVNzc0ZjdK?=
 =?utf-8?B?Sk8vdmdKMENCUkNoam5Ic1dFSUo5Zkg2Y2JEUm12bWVEck9CdGxNZFllUy9i?=
 =?utf-8?B?YmluNVlZMHQ3NVAxOHk1NmJ0b2VnWm1kMTdQYjZPK2F0NnRrZlp6OEdoL0NR?=
 =?utf-8?B?WXlMc1NjREZqSmhNbW5GMDQzay9zaVdiUEVxRDQ0UkJpenI2aUNlckNrWEhD?=
 =?utf-8?B?eC9PYTROTzNmOUFIZlJZcWEwTlJET2hieGs3NWFkak1hRHpuaVJNNTY1MnVO?=
 =?utf-8?B?MlVRV1ZzeHEwRDd5dkI3THFPSUxCbTdaOHQ5UGlHaDBMbGN5Y1FNU052Y0ds?=
 =?utf-8?B?U1daVjJWQTIwOHRDbENyelZXNWtUb0tvU2VpeXJ3UndXYWZpNkg3cFlUT0Rj?=
 =?utf-8?B?aUlxaUFGK1pWNFZ2YnE1Wm5VSUxieE1xRGVxMlNLaVdKUFpuWVFFOGZvTGs1?=
 =?utf-8?B?RHZ4Qm1XdlRqR1VJbFk2NVlNZytDWjcvVng2blUrMitYWVh3eDlMK3dHSzl0?=
 =?utf-8?B?a2paN0xaS3ZnM0ZydFovZkdZOUN6N202TkwvRVFTNnVDMXFHTmNWdXhWZW9I?=
 =?utf-8?B?ZFBZZ3BLdThxTnZ4UmlCYkNLVmFsaWtZYVdONGJJSUQxNlhXNjVXT1RyQk5G?=
 =?utf-8?Q?7sswNv/w/yl8iSgcSaTPH0WKk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yqWkFl/5rE519Hw1ECJgjap/vGH+6tdCD7hfVBJnZLCSWjgvRQCg4Hy2jfKULslYDnpKcAX0Yu9RALKaJsNmBmnBAcNxUxp9F3RVX7t7sdlcahCbJVilJIcUOpa6AqYrxcJ5MKHbHkSuOJV9jEeuTj2epw+xtmFpiLZGHauYNmmjlbI5sb6s2gEYTJjP1XrpuipZzlaP3nxCOiJ8pPWT1LXtpXjDR8p9n2dhn2PdXzPIFYwHsxYBbL8MncC2oI5p51NNIjVy1Y8c8anSEOpE8Fuhpt52nXLx7Q5gyFG2LKWl9lpUOS3FP+SA6texXAZm2of6ZTyPBafS+ykjdI3ZBdVicIUkqNA2SUmCa6D5IZ56WLP+o5FcL/S67qqn9kV21spuThupM5y4UTVq8vokKVDeq8hkYJEhbOLYwXCHyxKiBCtOS9JaGn3UrziHtOQDjbYaWvs7EjnutDFB+bI0jKNGqY/nJ1ot3U+F2/yljsjwIDn8pP1lgGKF91M8Tpg5xQe10iHCwUX4h7wifpbUsfzAdAjP92XR876raOM2hcVoRgHO4ELQdTTyzVI/hvspm/5z5sltJzuXLxETmfxyLfewAOZ7UlFAZUjo20Xg1YI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d596a74-ada5-4357-a86a-08dd528746c1
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 14:51:51.9506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tBadaUJdOmC/tEnwmbX8l8rOlDgXcSFx1QPxdY+jj3jDB/lwpfe7dHEp1a2uUYvYcC8PxTl5pUBdZaKzVcf6jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6895
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_05,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 malwarescore=0 suspectscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502210107
X-Proofpoint-ORIG-GUID: 89p-iH-sD6l-kVgi06cQWmA0sywz1mUL
X-Proofpoint-GUID: 89p-iH-sD6l-kVgi06cQWmA0sywz1mUL

On 19/02/2025 21:05, Ihor Solodrai wrote:
> This patch series implements emitting appropriate BTF type tags for
> argument and return types of kfuncs marked with KF_ARENA_* flags.
> 
> For additional context see the description of BPF patch
> "bpf: define KF_ARENA_* flags for bpf_arena kfuncs" [1].
> 
> The feature depends on recent changes in libbpf [2].
> 
> [1] https://lore.kernel.org/bpf/20250206003148.2308659-1-ihor.solodrai@linux.dev/
> [2] https://lore.kernel.org/bpf/20250130201239.1429648-1-ihor.solodrai@linux.dev/
>

hi Ihor, just realized that given that this change depends on recent
libbpf changes, we should look at updating the series to include a patch
updating our libbpf subproject checkpoint commit for libbpf to get those
changes for the case where the libbpf submodule is built (the default
these days). We should probably have a patch (pahole: sync with
libbpf-1.6) to cover this. An example of a subproject commit patch can
be found at

https://lore.kernel.org/dwarves/20240729111317.140816-2-alan.maguire@oracle.com/

However I don't think those bpf-next libbpf changes have been synced
with the github libbpf repo yet. If the next libbf sync won't be for a
while, I don't think this has to block this work - we could just note
that it needs to explicitly be built with latest v1.6 via shared library
for testing purposes in the interim - but if there's a sync planned soon
it'd be great to roll that in too.

Thanks!

Alan

 > v2->v3:
>   * Nits in patch #1
> 
> v1->v2:
>   * Rewrite patch #1 refactoring btf_encoder__tag_kfuncs(): now the
>     post-processing step is removed entirely, and kfuncs are tagged in
>     btf_encoder__add_func().
>   * Nits and renames in patch #2
>   * Add patch #4 editing man pages
> 
> v2: https://lore.kernel.org/dwarves/20250212201552.1431219-1-ihor.solodrai@linux.dev/
> v1: https://lore.kernel.org/dwarves/20250207021442.155703-1-ihor.solodrai@linux.dev/
> 
> Ihor Solodrai (4):
>   btf_encoder: refactor btf_encoder__tag_kfuncs()
>   btf_encoder: emit type tags for bpf_arena pointers
>   pahole: introduce --btf_feature=attributes
>   man-pages: describe attributes and remove reproducible_build
> 
>  btf_encoder.c      | 279 +++++++++++++++++++++++----------------------
>  dwarves.h          |   1 +
>  man-pages/pahole.1 |   7 +-
>  pahole.c           |  11 ++
>  4 files changed, 158 insertions(+), 140 deletions(-)
> 


