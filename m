Return-Path: <bpf+bounces-38579-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6449667DB
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 19:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63A282826B5
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 17:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E1C1BA888;
	Fri, 30 Aug 2024 17:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Shd4Thyx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DHwTrUcE"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188AF14C585
	for <bpf@vger.kernel.org>; Fri, 30 Aug 2024 17:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725038502; cv=fail; b=EG9Fn2V5oArkxycrhhqQF6hJIb8zqJKQ1LYBG1RAh6HPKKyFl717SmdxXiiUkPs/VKX9P5l2WBRtEYrTLjjUdOC3huM2UxFhlbJPOSL17MN0x4T1jPWurZfIFYdDJSbHi5MwT4VnaUDvbDKt4+n68rZfZPpMXhkrJRE0PTP+fL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725038502; c=relaxed/simple;
	bh=cZ3rzqb/euj4tiWAwbfvsidIXwJMnwD3qIPDnK88KqE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SEHNpWzZk6WT95VtO4Zmia0Yt6p1u6DI1qgCozJKXCGsc6NNPLcR0AqlN1FOmEkCJY63KTzZfdguaXnnH33zqAxCC/hrP7qoyqoyUm6NtOXDRj/xw1vc+LBdaKrTExul+dLj/T2hbV7XWioDbkSU0oHJ70by1hsRAbOg69/UZug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Shd4Thyx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DHwTrUcE; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47UFnxLZ021833;
	Fri, 30 Aug 2024 17:20:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=mnPhv3T3weFIC/Uz8Rd6ZrzPrPZfwdMNkv9UbP0ewgE=; b=
	Shd4ThyxJBF9i7ahP4z4RMTGZx7dQPYqok77i4M9cF0UDZs7f2yQsuZ1yZROisUy
	HQtFYpTmeN5vkx5jy0yoR0EvfY0f4H7pyPYqv2n/M5PohKwQVKHfMgKBBTkm2vlm
	KPbWkAi4R84vYQPwC9AfiSrvJHTt08nywL7jaYF7wNo1SZllhmzrekrGIFIXqB0u
	QukD67XBbzcssJyuuw+DRtD4JgCskkJM7IJyrFrXRBt2YMiliWzwGUDHVkKc/7tf
	qfou9B+yr+nBn4G8RZbzhwTuHnjeo76VAfbbgREfG8CXSSnoMFQ6MmAWEOTKiC+G
	l7Q+mF5YoknbgLfgulHgYg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41baa914b7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 17:20:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47UFwehW036832;
	Fri, 30 Aug 2024 17:20:43 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4189jpueht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 17:20:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DQIZJVZwgMCqIM60eKKhCEs7a2u0yZ8ES8Wndd3iPnTGMahj9RBzD7ZNYZ0rnMtiyag3WCGlhRHoJ4s0072lkCUw9r365eLKjIN82LETZ/iwGb0qjQ5+5rYIEw2SIkMTSWmOFQcqqn5iVJSdjrLsUpBc30w5MrnD1N/OyNgLMJKkwPSu+y5WiSAdhs7t9DWZLR/OAFDhoWSfh8tEIsK/mdV0UG35XE7Jj4lwfVNW0Y0/UxilkNulp64QmxvZMRoxtf5slt6DC2+HwxU4Lm0tV+TlEN7juS5KHK9aYILJWH3A730eVmzj4qcIdz7syiK08nROZGzo8OU6t239Grl0Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnPhv3T3weFIC/Uz8Rd6ZrzPrPZfwdMNkv9UbP0ewgE=;
 b=fHD6OO/IMSGAPVQrgZVHtbU4iXs8K2Hfssc87z4V4CwCAvbXHn04o+M5i+9XIRpayRoF0DENKIixfQmsqtDbGuS6Loar44n5CNvGJ/K+vW9xFS6POAh85h0xXATWlUV5w4xs2PcTGQkaUhHjaPidPkxuHGjqERcKyGs0zalq9a8st9B73VmRP4fjkYMqtKjxfq1TC/jJ89O44Vp376bVQs+mS7FjKezxI5K+OrJBQ9p1JIy2PNPDF3w3EZL6+y86bLgDSokhAGE6p6/+qFePgW24/v4UQT9214WFmR+UjmXokH+zsMpfZITCOOUOqptqDSlgFRRdbymCaMj7lD5JBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnPhv3T3weFIC/Uz8Rd6ZrzPrPZfwdMNkv9UbP0ewgE=;
 b=DHwTrUcEIC7eELh5oeOstfLwARhZPMW8zM7Dhhr836+lvjeav40yVG12HI9A/nv3gHH5ywXq1cFCb+KzLdIyD7ReDAdWGpGOESScTdLDzeiK+PDLQQZ9ecIUOp+POAN9tIVHOEq8VnnM4JNprKarcAJF7OWkL9GewaNS/MzGCFw=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by LV3PR10MB7795.namprd10.prod.outlook.com (2603:10b6:408:1b6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 17:20:40 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 17:20:40 +0000
Message-ID: <71dcef0e-9fa3-49c4-9ea0-ed97adf3c488@oracle.com>
Date: Fri, 30 Aug 2024 18:20:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] bpf: Fix a crash when btf_parse_base() returns an
 error pointer
To: Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com
References: <20240830012214.1646005-1-martin.lau@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20240830012214.1646005-1-martin.lau@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P189CA0069.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::7) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|LV3PR10MB7795:EE_
X-MS-Office365-Filtering-Correlation-Id: 0835b23d-7f15-4e9e-c44d-08dcc9181270
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MjYySWhnSFN3NWpqWkRQNzh0ZXVvd3ZBcHNENit2SGJNMkduN0FpWitSVWR0?=
 =?utf-8?B?OFlHYjdtSEkvM041MFk3NkJUa2ZSaVNWNGhKZHZMYkFvRGhoTElyeWdMcVZY?=
 =?utf-8?B?UWFLczA0OEpwbkRKcTIvOFFEbzBIZTZrc1BJczJWZk05RWs1TysvbmN1TVZv?=
 =?utf-8?B?N3pnY29XL2pNanRBczRYRzJPUThYbFdRTzZZK0JnNEg5UDlqNTVnejNOMnBH?=
 =?utf-8?B?MDJEZ1VFQVJqM2RBNkxzeTRCUkZpSVNOYlhKNEpOYk01R2RtOHd6ZGh6dGtP?=
 =?utf-8?B?S2RpaENpbWNMbldzSDh5OGkwdVpjTXJVVlhySkVmZS9ZSlBJc2RMSWFuamNR?=
 =?utf-8?B?Q2xxejRCdnloWVQ5RFhpdjduL0RVL3FpcEpEQkNuMHl1TlhoT2RBWjIwSUZo?=
 =?utf-8?B?LzFqeW92eXNSeXozWHhMQmEvOENha0d4VFlad01TOTVjQkx5UGhlYmZiUndZ?=
 =?utf-8?B?Smx5dXpwREcybEtncUZrY2NyL0xzWllzTjcvc3MzaGZsTXNHZFBtZ2xndmd1?=
 =?utf-8?B?SlZYS0ExNGRKT1hiVHNwbjh5cVdNSGdicHoxS3pPcjZqMlFiMW1adVl2Zndp?=
 =?utf-8?B?N0xuZHFXNlJKblFvWUNPTGJSSEtWRHgrME9meFZMcUlSeGF6cjIwaXNTZHlY?=
 =?utf-8?B?UDVUTmtJZWJTUmYwVXJ4Q2dKQUViUnFMS2MxOU93aWhseXl6Z0VMSkJVeUdG?=
 =?utf-8?B?NnFhckQvVkZ1QkxLZFgyRVNScTJuRGNoZnVlRnJrUTFDVXlhZHFpMDFlVUZk?=
 =?utf-8?B?aW82QUhiM3ZlQXRaU2ZDeWIralFQaHZvTnl3cTd2Y0NFT0lnbzIwbTkwSU1r?=
 =?utf-8?B?Zm1oSjNua3U0UDg2aWhQdklTNmlISGVCZ2NnOFRIK2pJdVMzbDlqdEhZN2Qr?=
 =?utf-8?B?U2JxeUpXYlpoSGZqT2NPcHZMTEYxZDRVcGMzdjhicFlqcFl4QXVGY2syak9H?=
 =?utf-8?B?K0xwWmhGQVhFZEI2Y1lZUkxEMGVhekJKYS9RdnVPamppeFZXYitNZGFjWHpq?=
 =?utf-8?B?WEdEampMYk5MWjNISjJMWFoyb1Uva1RzOVorTXNsNXFaZzlPT1pmSllWSlN3?=
 =?utf-8?B?bFZxK1gxRlpIVUdWWnJsc3drMVhrWVFnTmk4TXJMaHUyNnNoWEVlVHNIUHdh?=
 =?utf-8?B?a29jenBqMVRVOUNUdFlmQ1UwMGJaeE15VHdhTDJ1NzlQVkVTMm9OMTBYOTVz?=
 =?utf-8?B?ZmNJRC9vMVN3NmFpY3lyaUk5TlpxM05ncUg0SXdaaGozcWJ2VkF1UHhrbEIw?=
 =?utf-8?B?SjMvQUw4bGFIcXlwRExZSnlpbjBiZ0lCNytXaEtuUWFhS055QklkZVgxOWhs?=
 =?utf-8?B?MWxzbHlRN0l3elBQTkFiTnZ5TGczUnNROU9FaU5idEdSaUgySENINERlUG5E?=
 =?utf-8?B?MHZ6eTEzMk56bndCSlNGUXVYTVFTZ0JzbkQzWnhGK3R3cHZtSVc0S0FlejBY?=
 =?utf-8?B?MlBwem1XMi9aZk40RjcrQmUzTjV5VWdnODNLcWY5QzY1SUZaWGwveTVQakVN?=
 =?utf-8?B?czNNTlg2UFphNzRuZk0xTkROOVQwb1FRRDQvaHRSaDZXaWdSZTdURy9KdDZo?=
 =?utf-8?B?K1RVcUdzVzFJVTlHRHFidHlyZ1JlTnlmdkdhaUxVOUdZU0pmMnBWRE5wVXVV?=
 =?utf-8?B?cVA3UW10VGdTdUFSMHJObzk2U0lvMU12dUtxcE5SV2xvN09yNFBWdFZ4OUxV?=
 =?utf-8?B?TUZZQ002SEV6VGFsZnZiNWMyMWdJTm11TS83emJnUWtRQ254Nk14VmVKWkFm?=
 =?utf-8?B?VTVaeUt2TG1heG1idkNtMjlDZW50alQrR3hmdTdSRGQ1dU9xZnMwb21VSlZN?=
 =?utf-8?B?MEJMN0x2R1hHUlB0OG0xQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZE8zQVhNY3JTcVNoWnZ1dVplK0dXSWFybVhZK0R3a1FxdmFrTFd5dnB4a1p5?=
 =?utf-8?B?bFdUelArOTNyTXBoaUNXQjhkZURKQjNwVUxhRzdKTkVILyt4YkFMNWcvd2Mz?=
 =?utf-8?B?VDBWOEZaaUU4U1VMWFZ1VG1PZlRic3hiS0l2aVBLOTE5ZG5pVzJnbnhETTUz?=
 =?utf-8?B?b3Y4eFV6UVozVFlUSXpLVVJLdHJZZkNiVUJSY3NCVjJ5dWcxcWMxaGlGOFoy?=
 =?utf-8?B?TE9wSVg3UkRhbW1iNE1KUFB5NWw4UEZBZjBsWXFMaXBLQnZQdURZc0tSamdM?=
 =?utf-8?B?VW8xanY4ZVNuWXVGYzRYWmhOU3duOTlRcUVYNTMxVVdyckgxMlJIMGVBK2tz?=
 =?utf-8?B?UzAydERQNVFHci9rM3BSRDdCVGl1d2dWejNoTzRmUEdWYjArRnZicnZkM2RY?=
 =?utf-8?B?UFc3UmxrbVplWGpzSjNGbDdwVGZldCtLYkFlNlRaOGVMMVRvTHR1RGN6M1NC?=
 =?utf-8?B?Z0N6NTU2N0M4ODBCaS9ySDZkMDBoNnA1aHVvNFc1V2gyZ29GeXg1Y1ZvaTJq?=
 =?utf-8?B?N1dMZDhnVGlxN2dmdGpWUlQ5dFZSdGJPY1RsWElVYm9sSG5NWGFGT0RwSll4?=
 =?utf-8?B?d28yS0RJNlE1WE5mWGtCQk1SNzR2L01GbXVZbXdqWElKZlMwbVNHelRpM09l?=
 =?utf-8?B?dUhJSXYrTHpWaGlOMzFpVmR2SHJLR2JwUC9WaHBuTy85UUU1bEZiR1pncXNm?=
 =?utf-8?B?Znh0cFNqY3pkVTBtUEl1N3hFaEFJaU44UDFSVlVpTnFzZ0UvbEp6V0pRNFFB?=
 =?utf-8?B?enVmYkV3NUJmSW9Fb0Ntb3VubXl6Qkg1LzVvbzIxWjFlOW04cDVFaVNzT1pE?=
 =?utf-8?B?RldRQWlqditQTFpjQWs2SVFMWFNUNjVVdjdlL1BUamd2Y2orbzFGVitnajhs?=
 =?utf-8?B?YTNVODF4T1l3d3RvWEQ5VnB5OTFLMGxpRk4wbFpKdmRKTXJjQi9aK1NFbzh3?=
 =?utf-8?B?cjNuRk5Vc2lsTE5CQWdBV0Foc2U1OXo5NjRKTC96amtUdUNaMjNaWFpuWjRj?=
 =?utf-8?B?WHhxSEpzRmJSWXlCb3RYVUo0azFTb1RicG5ENW9KSEpoTHM2UC91djFwQ21C?=
 =?utf-8?B?MlltTXNyek1xS2JlM2kxbHhaaHFVZitMUTZrL1ZlL3ltVGFCYjVqUGlrRVYz?=
 =?utf-8?B?Sk10cXBabzFkakxUdFNTeWZPMzJYanRJM0ZjbVczS0pXZXJYVGxweXNXQjB2?=
 =?utf-8?B?eTk0ZnU3clhZYkg5QzduYjM1UE0zYUp5YjhmSXFyK2p5dWVsZjl3Ry9SZnQy?=
 =?utf-8?B?eWNoV3dvQVM2Mi9qN3BoWmFaNDl3MEZqU0d6WDhkWXRwSjFSWUtZR2FaWUE4?=
 =?utf-8?B?Z3dtWVhKWWpkT3huTVk4MTMwWlBTK3NWNnp4Uis5cG10K1o2RDhQWmVzblVz?=
 =?utf-8?B?VWJFWXRJUTRVeTQrWHJKVXhOTStsK2xiT3QvSVBRVHhSQ0JjWWorZE5Fb3ZU?=
 =?utf-8?B?dWFrRU50ZkZydG1vMnRIUXp4cHpxWWdQSWtUckZIN2VaRWU5MndTS3VidTlD?=
 =?utf-8?B?ZjdmTVhYdE11KzE3VlNkRGh5TjM1SjA4eW1PN2lBbGVpK2JUcm5jaGx5bmNi?=
 =?utf-8?B?Uzdrc05MTVVJb01JbVkxRklLUGtIUGJncGhXN2RZek0yQjFucm4vaWVsVHMx?=
 =?utf-8?B?MUJTYi9NNTk1Nkh2S3A4bmlBU0l1WXoyMnhyRy9ZcFI5NW93UGZaMU90bktr?=
 =?utf-8?B?TGVvb3FqNWJQT2xvQnFpTk5ZQjF4dXg0Z1d1UTRzajg5VDM2a0xaL2NKcG1W?=
 =?utf-8?B?V1ROejFrOW9MeXd0emRlM1dMS2hkYjdGZE5KcDRhc2tCL1pudmV2RjR0cU9W?=
 =?utf-8?B?RXYyYTdiY1ZpNkxnSWt5V044UlBXenpoY0tyK29UaVBCKzlydUxlUWRjbENK?=
 =?utf-8?B?dzduRjU0c0l4ZFlNWEhYNkRlRVBWbUh5OFFiUHdlSDE3V294aFVEVVF5cmdR?=
 =?utf-8?B?aFM1VStCTzZZNHZ4V1o3QnhRQkduYVRJYytvMVJFSmlnd2R0Y0haSGhVeVBY?=
 =?utf-8?B?OW5PM1hUbVExaDNHTTdQTW5SdGhjYU9rcHlONCs2YkRyR2hUZG0xYkJxdFRZ?=
 =?utf-8?B?RnpZZGhmREM3RDhCeUlEcXpnUU5FRTl5SlhMVklaM25PaHlKbnpiQWEvUWtW?=
 =?utf-8?B?YTZLU2tGTHE3WHlTY2wxS1ZvNWFxSmhkKzJPbi9tK2tDdHVjQmtHNExwWUNI?=
 =?utf-8?Q?LTdX+9z2vbxYOJs2NrxW0gM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SH3a3FMhBlSXcgpFMBoi9UwIF4PcJy2OsD2CIcVpNCGgAXpfOnztbz5DOe8ewCc84aqBrOWTbgGlVDKuQGdmXlAnqs568HMWHsPJmlN8E+fGjiF8V1XYlhI4aqFMRUb6Rzr/j37alrM8tnDvHSmvVQYTI3+cE1Qv7qh8e7SrKTeRtAYsQBDMN9z7G1RlL7zL7Vs0vVOxtdZAcUvtk3tL1auif9M+SoAHgrpanNb1XZ+86SzLB1guvs44YkPbWfxbB3Y/irN2/jg6YFA/49hlCMZ+EodZllWV8mz9Xu7xh7+/vA58kgtKF+czR+W2Jf/9mMnh/Gp6uWplBL7gJ0CApvw1JPNQ9czsMPAVg3Gl9MUhlxdL8DpZ4coVahsFqvmiwB/SVFz9n58KPIWGoHKYrPRnmjYwbj/oIhQFfWK3LTvpsTZSQlowP1CIK7F3QUhOtQ90RmcM/LWCKbAJBkpegDGr3kZIUcVrFIb0w88PzNQl1eNREDTCUOZ7+UR8d1K4zn3XcxqaHOmFcqC7wwUmXkj9HiW1J8wa8sEmJXcoXs4xUtq1vWp1W2idtyY24JGgIYnby3Yd4YzZwYwJWBi7TTxpV4Xbs5F8wb2Ahw9OoDI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0835b23d-7f15-4e9e-c44d-08dcc9181270
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 17:20:40.8215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tn3ym6uOFCHP6OzTjvJWnROAU2Okk+lPS5Wc3Ov/U6Awa9yxCKt4TfrabYQvMNrd4vBzhCZWmTZixvmD06C15w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7795
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_10,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408300132
X-Proofpoint-GUID: YGA9K10TvvsV1BQ8j7s0w5GDfeDdYVMc
X-Proofpoint-ORIG-GUID: YGA9K10TvvsV1BQ8j7s0w5GDfeDdYVMc

On 30/08/2024 02:22, Martin KaFai Lau wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> The pointer returned by btf_parse_base could be an error pointer.
> IS_ERR() check is needed before calling btf_free(base_btf).
> 
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Fixes: 8646db238997 ("libbpf,bpf: Share BTF relocate-related code with kernel")
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>


Thanks!

Alan

