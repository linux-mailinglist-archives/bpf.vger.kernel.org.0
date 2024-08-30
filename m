Return-Path: <bpf+bounces-38541-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9546965DFB
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 12:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A4451C20E10
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 10:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350B5185953;
	Fri, 30 Aug 2024 10:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i+0+Yswe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="U4KIYelH"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08FD17B508;
	Fri, 30 Aug 2024 10:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725012352; cv=fail; b=nfyi6fubHVY1cO+/h88kMi97RIMfX8uJgXl64Y2PQR+y/Tk/QFBMXfiKDzqrpQKjgkmpfmFT15SFnly7+8vUCMNHK4+lAhqBX6IK54YfksUr8DNRGpqvYB/aXy6AS9jTcG4M3pqtgqJT/tMXptF93hOor5JIrh//iky2y8hCma4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725012352; c=relaxed/simple;
	bh=BOffw71Jjn7ds5IkFf/t5UEMacyVTu7ZLhqd/YCCYvg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PgYOjQNIWU3kt/uvJUnKO4bF97zY7OzdQCj1s0ygTiEgTwhsvuonxtRP1dlJDY97sQz/zxw+6EL+ZZDEYkSDuoMJ3AwxbraB23HDs0R38EVDXgk1IwPx0nRGL98EynCDImH63tGZQoBKZfMtZkVdsCmfz+64A2OTtr4+i47jR6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=i+0+Yswe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=U4KIYelH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47U7tVQl014628;
	Fri, 30 Aug 2024 10:05:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=ZijDVxMkNvmXFN4NGJzc2iK7lqQKTr1Ka8hcKSTtNSM=; b=
	i+0+YsweZ8depfhKTFpDKwdu++TYoAMXk8EYwjAQyF4bmRK1yheNnb5xBXx0oSpB
	FjCOgzQbK1tyUobh5xu4skrtgRnaACUVuyVActLIp43C2vELgIQTWfo0RUdaZWHh
	3/OmKRKQSL1hHDYDQ2H47iwlWDpj9nizJSlmqsnWN6UAxpeNdBGHDeUf4td0PFgw
	AshqVRZjinbKdkRbxNnnwr1kOWKRDkycDE4VLxKJRZsJ4/OBWfr1aqNj+DNG8+29
	1Ty2dLUzfiEL06XXUIm8nmb8Pdvul5jEh9S12l560gE0e6bsj7w8yG1h0XXIXnsL
	Ym9af8L5PCrCkDGeunVa2w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419pugxau1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 10:05:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47U8kWab016688;
	Fri, 30 Aug 2024 10:05:38 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 418a5w92t8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 10:05:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zV6AzhqesKVX9GAQGlt2iA6NEIloiV3kHcfWP+Md33wnn4NF2X0BrQQYh7X5L7T44NWnmm4+IypU2tSQGa9QHVOVcFalpE7OL9NfXhQ/4KDM4mNLIZlJ98iuCPLFEdYl9CzZmhWeILUONF6D7hHhrFROsYfmQvadogdlJmD1uZh6PtCi2lWYCdYJkQsemK12o4E8z2JgMKA/JXa38WEHXDsT/aUVpaT/upZycgJBqRBfcejhFGu/d6+6O7bhFl7qdUHQ3e7tlO8UIfk/0CCG5js7lp2xn0NnH5zIfmvRwy02encFAy2NHW3K04K+qtcKJb57KDX6jdInMM2fcarwZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZijDVxMkNvmXFN4NGJzc2iK7lqQKTr1Ka8hcKSTtNSM=;
 b=aSq+cbQW+tC62frGGRTltyOvcb7iqUjQ9SlU6V6o34wXLOMeiOHKvSm7U1bj2l9pXxGBnYAwWOjsqieINUrt1HcR2N0ls3RBRHTor/Z/PqfZGtFCNXvZGY6cI3QjJAcNnXPjOYAN+DAThJbSu0HPxNt8ECqgCrIyFTF3JJZ1k2VgBLaiVHIJvgzL7ZvgVx/kPxeVp/HeZb9kg535CKUyr0z/ym2Jh6iBp0q6Up9nLet3oCshTQJfZI29aW05NmTsBTG/6KOP4ayKEGvYLbv8xVJJJVFHg6tOgjI0YosBTNB9vHWM9uluEWsLCD7k9KyxipqbjvCAbgtoio3h/c+89g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZijDVxMkNvmXFN4NGJzc2iK7lqQKTr1Ka8hcKSTtNSM=;
 b=U4KIYelHcjOpTpjqH4xtkJjI/Xzp5pCSrncM0bFE7YYS23K9n0T5DtCzZrIkm2MjBPIrqNQJ4mMMlfffcIaPJpzV5FdO/QixeMsG0co7f5amNaq2hGfAFbzyU3N00CTpenI9D5VkpZqpS0lFhynDjLUeMFEV8uceOK7AQanvUSk=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by MN6PR10MB7998.namprd10.prod.outlook.com (2603:10b6:208:4fc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14; Fri, 30 Aug
 2024 10:05:36 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 10:05:35 +0000
Message-ID: <860fe244-157b-46cf-9b41-ee9fd36f9c1e@oracle.com>
Date: Fri, 30 Aug 2024 11:05:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: FYI: CI regression on big-endian arch (s390) after recent pahole
 changes
To: Eduard Zingerman <eddyz87@gmail.com>, Song Liu <songliubraving@meta.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        "dwarves@vger.kernel.org" <dwarves@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>
References: <6358db36c5f68b07873a0a5be2d062b1af5ea5f8.camel@gmail.com>
 <442C7AEC-2919-4307-8700-F7A0B60B5565@fb.com>
 <322d9bac47bc3732b77cf2cf23d69f2c4665bc36.camel@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <322d9bac47bc3732b77cf2cf23d69f2c4665bc36.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0532.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::14) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|MN6PR10MB7998:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a1bd1e2-61b3-42c0-b10b-08dcc8db4ab3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dDVIaUhoWWhKcGhwNmRxaHlyRHNYUGhyY1VmamtHUENJR3lrRVFyUzRYNzAr?=
 =?utf-8?B?SDB4YTRQYThhVkFRV0QwdGw4L1hTMlRtZU1MNlZXK20zV01xekhGOVNyWG1M?=
 =?utf-8?B?MTE1bzBCN1A3QktjK3c0UHd4TkZMaXBZNFRRQkc2b1J3dGtlSlhwR2p3aW5V?=
 =?utf-8?B?VkZDNXk4U2FPdzY5S29KSXRaUE9iaElIRUY4eWtvN0FCU3pwM0FkQTcwZ09v?=
 =?utf-8?B?Wk1RT0FBYkltL1Y2TGl6SGhhMFJkb3M3dUNrSXZhZlZzNFY2cEVHeTFDTDlm?=
 =?utf-8?B?TmVpbVBHOEp4MHlHYlR4ejN1SkFsSFViR1lYdHRKUFVGUkpxYk5VZXk1VWNy?=
 =?utf-8?B?bE5CeTA5bjVTNjI0RW95WXlZeGt4Sm9UWGdMRnJpd2FyN1ZlbjRMbG1lL2dZ?=
 =?utf-8?B?VDl5c0g4Y2NOUkdIdXRMc1R4ek1RTW1BS2VmQWYvS3FIdkFQdTEzdXZZOXRi?=
 =?utf-8?B?TjRVak1meGJVZDV1RkhJVDFhM0xFUGVwbmhkSGM1Z3lFLzUxWjUxeU4yWWt4?=
 =?utf-8?B?VDlKU0l5M255UDJtWUUyZVpxcXluQWR2SzY4UTBPWjkwU0VLNXZ3SG91a1lO?=
 =?utf-8?B?Sm1vd0ZEekJDSCtITndkdG9ZTUprVUdBbi9ZZVNWTTl3dmdlbldtRzJDS3RU?=
 =?utf-8?B?VDE2VzdGSkpNUXBQS1A0bURnVHp0T1IyenFNblBnSWtSV2FaOFdjd29MdDZu?=
 =?utf-8?B?UUJ3R2cvRUREamYzdkFHUXZ1ckZxRFZtYXRWZ1hwaXRLYmFuZHNTcGpBOTRW?=
 =?utf-8?B?RHVtMGNUUEk5NGFKTmtKU3I3Q05oMjBDNU1TOStCSVVJUlUxU1lqdFBVcTQz?=
 =?utf-8?B?dXVrcEhTMWsrMXd6UlBmeW9JUm8xa1VLVjJpMVpJMjFyNTlyZVNiZGUzYVdt?=
 =?utf-8?B?VHBiR3NOMTBrSGNpaWIwZ1Y4S1dSSkFicVNmQjVnYk5wam1KNnhsWVBJT3NV?=
 =?utf-8?B?OFVQUUdlSzU2SVFtUktqQXZHTEVyYTVzSUM4Uis3NVg5Q1g1ZDg5dXhLYi9F?=
 =?utf-8?B?dVhTWHBYeVM2d0lIbDdPcEsyR3phQ0RYc25KdVNzZDVIWjZzSDRpc0FuKzNY?=
 =?utf-8?B?NmljY2R4L05kOHg1a2phVkZBVGl1c2MyZ0piVEJGRGs0MTdaWmVFSEIrZzBB?=
 =?utf-8?B?cVp6VTJBbkhXenREOTZjVWU2NEZpQjBzYTNYMVRhU3JXZ21TUHI4MFFsUlhV?=
 =?utf-8?B?VFFIVVl6UDExZnNuYzBtR2pjc3pWWlNVN2xRbzZCaGVIT3IzNDFHeGl2b3RV?=
 =?utf-8?B?aFQzOVcxdzRQZlYrMURNQnNtMHAxckxaT0hYM0FIMnZyYm9VckJsOEdsL0pW?=
 =?utf-8?B?RTBTeUNoT1dxRE1SbEhnN2xSV0FhOEJRNDZLYVRxbnNwUjJzSkVUNThQY3V5?=
 =?utf-8?B?UXBxRDRFZi9YdlBvR1VqcVJQMk1tamtCajMrRXZ4TXFDUXNyc1kxRHpreCt1?=
 =?utf-8?B?WlhkMWVpM1JHZ1JDbXZ3a0puQVdtL0ovSWYwTUNrWGhmblg2NCtTUjBwSlBQ?=
 =?utf-8?B?VzcxeGxRaTNBVm1nWFU3YUtkR2xrL0FkRlpNVkZqSm1IWHREV2JLUlJTQjFa?=
 =?utf-8?B?TDhET09VcHNZODNUYlFuSEpHb2QrYU0rL0twb3BhY0VCU3MwcDhNSUpCMGtq?=
 =?utf-8?B?dnN6anNJbW1RVjRiUjlkV25MS2s3eUtJQWF4Q1J1NVRCemJWZEpOS1p1cUN5?=
 =?utf-8?B?MEFhNjdraG1sR3o1akxITUVRZFlEZTVDODJXL0NvTlhpeS9PelF3R3J1QzRG?=
 =?utf-8?B?UXl0VjFzalRFaHlSMGozR05pQkRMYkVITWg3ZlpJbTBQSnVHb0FFc1FBYzFn?=
 =?utf-8?B?TkNIZnAwdUczQVp1c2tLUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZitvaTFwbHAwc3FCMVdleE9PdE5peGkvcUFpL2E1emJ0cVhLM2Z6MW9BSjJJ?=
 =?utf-8?B?LzliZ3Q3RTFQKzlhTlBHYjV4dFhXMVcrWmk5ZWZEdUZqck01T1dZOTRnN3lM?=
 =?utf-8?B?dVczTWgwdUdJdDBybmdVVUFsYUdzM1JTT2Rsb1ZFaDdRbFg5bFdWZFdaLzV4?=
 =?utf-8?B?ZldieDhVa3kxd29VMWE4T2hJbDhXOFl2UWlLWVVoTUVORGdreFRCSkthaERS?=
 =?utf-8?B?aUV2bm42UDd6YU5ud1k0VDlMd2pzNmM0aDNKTFBDeXZvbmRJbUdidzREdnJw?=
 =?utf-8?B?Nm01Y0tWdEtzTWQwSjJ4RmVpWTFjcWJCZk5QU0dqNS9Ra1RpeGdSa3I3cTFL?=
 =?utf-8?B?Lzh4YndEL3hSQXNNTUhZdE5XWG82VGpwMkVaUkhjbWo4VlZmRk5YZkJjTndP?=
 =?utf-8?B?alFoUTJJOTFZYU1YYkNBdDg5bkVZY29JbktodDRBc29NcS9vb2ZMMVVFVFhi?=
 =?utf-8?B?S2g2aHd0bDFxSGd1cm11cUN3bHNEU3pja0QzNExNOHdsR0VXQjk1R3hMZXRH?=
 =?utf-8?B?ZmQvMWlUbzZBSUZzMWJXVkVxOHZBQnZjVW1YeUJnQWpXQjQ4cW1uM2ozcWdj?=
 =?utf-8?B?T2xINmlWVVJmRHBRZGw4b0w5YTNTUTNWYnE5RkpTTmNUSERENTlmZE54QU9a?=
 =?utf-8?B?RE9FeTZ1S2c0MzlIcU9ZUjRLZWpwMXBsemNjZEZMdXI2bGY4Ym5iZk9kR3dz?=
 =?utf-8?B?dU52Vzd5K0hkV2QvNWVLSTEzeDR1K1RoaHpMa2VBcUFnaTFwUjdxMGRZcDFy?=
 =?utf-8?B?U0VuMENXandGZHducHk1aVF0UFJwOHFnaXA5c0V2VDlaRkEwTDFtek5aUGdZ?=
 =?utf-8?B?bllBRlhEd1ZhVUp4bHh4L3QvWVpDRVRINDFLL24zZ0IwQS9DdDFkWlJ6WWZO?=
 =?utf-8?B?bHNXYVhYWFRJeXgzT2MrR2ZWazhMN29rSFJrZFViTzJobVVzNVVuVkhzalhF?=
 =?utf-8?B?WVZhUm04Zkp1dzlpdllDTUMvT1IvWmo0cFVjWEdhd05nVnZSU21zR2ZrSGtw?=
 =?utf-8?B?NkJ4Y0F6UDRXSEZnN1ZiT1FEWXQwbkRoYVIzMFpORG9lRTFGc3FrTkJ3eFNV?=
 =?utf-8?B?cFlxdDVYMlNEcEpKeXRyMHVhUTB0REpTQ2V6VGZjSEEzLzl1Yk43YU4zQXMw?=
 =?utf-8?B?NFM5SDNGT3g3OFVIQmxSeHgyUVZ5KzlGYUNqRW1NQ2NlUmduWHVwR0d6b3pq?=
 =?utf-8?B?TmZKc0FoSGltRDd4SDloZXlvd0FtZFh3MDVJTFptT1d5NSsvMFJtSk9hNC9M?=
 =?utf-8?B?UTB3TjBmOXFXcUhJS1VYTmxNT1pOdHpuaEJPMzcrbisxQzBwRzNNUkFJdEh6?=
 =?utf-8?B?RFRzSnlscnk2VkgwWHhoZ0dmNGM4dTJSL01JbjFzbjd6VGZyR2lwS2RXbHl4?=
 =?utf-8?B?TFhaVGJtVFBSUU9YMUpydFQrYWRHRkZsOXRCYlBVek93WEUwOE4vYWFWUHdB?=
 =?utf-8?B?cjRLSXZCUk8ra3JUVjNIblpmRHdNVHBKVjBtTG5YRWYvdmpjMHQwVXNWZUVJ?=
 =?utf-8?B?OU02dENRZUxtc25lREdRQStLL3pwSnFHbFZudXl5R3NwTFp0YjE0cG15OHU4?=
 =?utf-8?B?VXFuTnFQbWdEQ1VodVVtc2ZvTEJSb2d6VXZWRnorak83UTA1b3RDdkt3bWZT?=
 =?utf-8?B?aFVwWklBcExjRzM4SzlTTEVOSkNQOXA3aGpia3VJTE9nQXFaN2sySUZVZERD?=
 =?utf-8?B?dEM3ZU4wcFE0Rk0vUGNQekQ0ejVzVjYwajBrdlowRHFjNm5ma3ZjMzZxWjg1?=
 =?utf-8?B?c0ZRZEt3SjNlbzJVdlZ1UnlLeGUxcGlUbmZmL1ZPNXhVeUxLUFBSN25hYlY5?=
 =?utf-8?B?UUdvWmlNZmNGK0poWmZ4NnVJTEx0VVluT3lweFl6dHZsWXdobWZFZEtUMjdI?=
 =?utf-8?B?MlJBMC9XRGhnVTB6S3laYjNrTWNidWo2VkhIU0RRZnQ3ZTlsaStHRERCYlZV?=
 =?utf-8?B?di9hdmJHUUlTK1UxMWZ2NVNNM1hOdnVTM2ZwdnRwc0V1aVBXT2YxQmFLN3li?=
 =?utf-8?B?YXNrNmdLN1JMUysxZ2NkQ0oyQW5lWUQ0czRLZUY0MTFVWnkwTzlIRGUzSmVu?=
 =?utf-8?B?clpEQUc1ZW5ya1NQQkVHQWxzd1pRRC9BbVkwQ2wzc0lsR2VzSHo2V25JQWNO?=
 =?utf-8?B?QXVoWVRtQzFENDdKdkE3OWQyK3JFdzBvRjFLRlVsbk81WHlJcHlTQzlnUjVv?=
 =?utf-8?Q?f1216tFZzfz9bzYyLBOxEWk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kw619iqKU4nzdVBgHEoamnVWWbRnVvQfiZXWRCx6CEomeupP7E6O82SHtgdltFWOoHiNT7t00ot01QbAYo2+UBOul2go8VYIOpCpEiX00dK0aZyP+rsmSzmv4ayYA9Xg7w+fxiZUM+Ssz+jGMO1DS/6J1sOaVfx0W3bIy7niwOazj0q/b7GZmqXi6uxE3AYWPk0FvtiOoQknAOtTWP5a1FN51s1mPv2BuvDz3pwqmkhh7ELqHJ8+koEeuQlMpqAVfC60WWN1Yz7VwrI+2WD8BPS3O8FycOGGRZiEGi+FChVlLtx0OOjwdo7tgaf6JtF3Y9EGXx3uFwzrWPXuTEaMjNz7HofYsO5x7QVJ1Xi81L5L42rH2F3v4z6Gd874rU11+xUD7oAjZIqkTpnpKlLaskEOB46GzI4wqOG1o8jOCnf0oK/gu1tV6UiqrtMKcGnHhPZnkEw8ABSG6sYVqw9nswq76jqXWC9a2d7eZuGB33yJay6WSorTHGn01t0hOzW2FHq38m3sgjoeyHdpJr7vm4hmxBPzXOiWW4UkFM/oyrju/ZktxDNe7T1S20uTd0SL6VWGadk1PBkln4Wsd3GAtsn9q0psslqeZ8wU+rcCPBE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a1bd1e2-61b3-42c0-b10b-08dcc8db4ab3
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 10:05:35.8085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ijiQlJ5CWImGcqSzfxTSYIqiLDIsEPyRRCQJmADj0tZ77TifCtliet8tQA3z1Bq5rX/FjywZg08r+hvSZ1CBJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7998
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_04,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408300075
X-Proofpoint-GUID: rTDzDT8a9U8hIhz2rqP9aN0ZcnE5Ah4E
X-Proofpoint-ORIG-GUID: rTDzDT8a9U8hIhz2rqP9aN0ZcnE5Ah4E

On 30/08/2024 10:21, Eduard Zingerman wrote:
> On Fri, 2024-08-30 at 02:49 +0000, Song Liu wrote:
> 
> [...]
> 
>> Clarification: 
>>
>> With the regression, _both_ .BTF and .BTF.base sections (or at 
>> least part of these sections) are in little endian for s390:
> 
> Hi Song,
> 
> Understood, thank you for clarification and sorry for confusion.
> This makes sense because btf__distill_base() generates
> two new BTF structures and both need to inherit endianness.
> 
> Thanks,
> Eduard
> 
> [...]
> 

thanks all for the quick root-cause analysis and proposed fixes!
Explicitly checking these cases in the btf_endian selftest is probably
worthwhile; I've put together tests that do that for non-native
endianness but just noticed you mentioned you're working on tests
Eduard. Is that what you had in mind?

Arnaldo: apologies but I think we'll either need to back out the
distilled stuff for 1.28 or have a new libbpf resync that captures the
fixes for endian issues once they land. Let me know what works best for
you. Thanks!

