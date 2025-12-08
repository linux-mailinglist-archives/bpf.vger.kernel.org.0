Return-Path: <bpf+bounces-76294-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E16CADBCE
	for <lists+bpf@lfdr.de>; Mon, 08 Dec 2025 17:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BF463056C4F
	for <lists+bpf@lfdr.de>; Mon,  8 Dec 2025 16:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907F42E62D1;
	Mon,  8 Dec 2025 16:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FIJFqT/u";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DP9H2/fc"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F222DEA75;
	Mon,  8 Dec 2025 16:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765210967; cv=fail; b=sklL2/vKYlAYyWdFY093iZoQIx0uF1N6nEAMsTnS8zPVFIP+UENQhj0hSg7x2cYcL2UqM9vUE4UrArzusKQhipwGGrQ2I3AEEHlHZOF8LVcu5dfX0T7ZOFWsdMPaNXYUGJzhraK8T+EovP4aHwHL4Ba0lGJ47lUTjGftnDXsEFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765210967; c=relaxed/simple;
	bh=uDHVHhGJnc8ujki9jfjYpwatVKgqSLDxLEkAt6dF+EY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZVTtkqpJ9+M3CsjGAcJMJpFA7tPo6x3+9idWZY0m529dC0q1YisltOCXHhZM53C7XlNx48QaRkWRQCmsuZaEWPdVA5YLBZ1Ifm4RCDcUWo/LM+9Wg8w8cAl+R6wzkI/XLQn4ROlh1EmFHjOSTXp+zo/V5fKNtEJpfeF4tWFC8Ls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FIJFqT/u; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DP9H2/fc; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B8FKwBc2642720;
	Mon, 8 Dec 2025 16:22:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=OmnWaHBMsrbBHOVec+RbubdSY882kL/5CpHInrtk4Pc=; b=
	FIJFqT/uxEZGQRolzs0ncTkuBZhmH7rQ+wno2T6CW96SsI3uU0SoP2tAnOiHkRo0
	8HmEiaq/UYY0l3p+DkpXB+LoJWYe+bIQWbjIV2JsjKA7hR6N2HTDe2eGgWAL5d3x
	HjuR+gPNUBeXVq6XQnXpsnMihV8Azt3vZ8iNOtadkJ0bsniLzXwjVGCkp34/aDM0
	G6/grg0a7qT4Vg2yIOdTyUxcbd3KqfHI0t6PjdLJT+UQYhG7bPn2fE3MkQ6aBMR4
	L0Z+qHGt15ewVQ7TZWOxu2MCgF/birJ6TZve7kjyK7tnSChPxJ+M1yzy09Wav74P
	IvFJ1clpr4JiOfxC2PFyhg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ax17y83eb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Dec 2025 16:22:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5B8FEgSx039883;
	Mon, 8 Dec 2025 16:22:15 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012008.outbound.protection.outlook.com [40.107.200.8])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4avaxhqqmp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Dec 2025 16:22:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v7TdVLEj/8OQmOyXZEUalv4Il5H2e7ykFxJrmv6LKWAMZbXbogNXDRcZdwf2r2keZP5iYKyw0SNLhGNUur2fcLAQVXILEUM9R86tOlQQfAlmJFSUntjLtLFTdKSpP6RQu5UqY6t6S8UaeuAXYm72CgVHn5l4VcPlz6QSKM1h6YncFyUt+D+pxy23rcCFX02CU1Q2oBcHSE/kO7zNogIa/9IrMLfr0NY/zJ/C5vq6kARqlMobeLi1ScHf07dvofIwgqdOtACl8jk7Myb3+VmnrWjvM1A9at6AV6UhpGtXrjM0JiGFtfK6LeMq8YvKroolR0jZT38YiROad6TcVREQww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OmnWaHBMsrbBHOVec+RbubdSY882kL/5CpHInrtk4Pc=;
 b=UbU2vIlLDyMmr/TBVn7Vmo4JiE/5rm4wU2GX8d0lSR1D+AFOXK38niwvPzVMGOG5xz0DmLpj5aEqhwnM3Fy7/uwtgl2LRQIrZn/IwlUDZkl/XmExKmcKFve8PyMHP+hON8FTm2ag7wLHwQ1YJiVXY3iyBkwBcgvShe/qcnURhLHkX7Kh2VZTJK5Be/Sfk7xgxgFmSeQFLE0kqZ6wdmbwK0/L9wAYT/R0Am9igd7mXS8Ucpr8d0KSKNNsyGpuHsFLRs0GdeL+OUfroGVK3SIKXXkfyKEqRYFG7aRcWHP1bj0OG6zZzglnVZcQSsYRMrpAPEdDGgeBJ3SvZuzxDIoplA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OmnWaHBMsrbBHOVec+RbubdSY882kL/5CpHInrtk4Pc=;
 b=DP9H2/fcftS7traFp/whBmPOk7yxQxawZrLU3jVBl2hONohkWxeaQpwhMRost1cZ9KKc8kN23+NsKVjJGpr4gvRrB9Vz6RfJvbB5irm+BHLfiQ8/egrLHIyZjd+/PHaSP26K7Sd8Gj/BtNNGxRBu+Hn/XL/CmrfUvRRP8PJkvDo=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 DM4PR10MB5918.namprd10.prod.outlook.com (2603:10b6:8:ab::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.14; Mon, 8 Dec 2025 16:22:11 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 16:22:11 +0000
Message-ID: <ba74c79f-6f65-47d5-972a-af35b3aec4bc@oracle.com>
Date: Mon, 8 Dec 2025 16:22:02 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v2 2/2] pahole: Replace or add functions with true
 signatures in btf
To: Yonghong Song <yonghong.song@linux.dev>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        bpf@vger.kernel.org, David Faust <david.faust@oracle.com>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>, kernel-team@fb.com
References: <20251130040340.2636458-1-yonghong.song@linux.dev>
 <20251130040350.2636774-1-yonghong.song@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20251130040350.2636774-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0462.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::18) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|DM4PR10MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: 47b49c60-a2f6-4c39-c242-08de3675f0a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y3Fwbi9kbkxNZE9VTUlOZXRFeGVNcnpIU2RsdGUyY0V2Q1FJbHBNZlFaZ0lu?=
 =?utf-8?B?ZzI0NXpoVHE1b2JMSEhuQ3FsakZiKzhWRVp6QWY4MDcwRlB1dFJLcTF5VkNu?=
 =?utf-8?B?TFFpb2kvRUNTRDc2UndrbW5zdVhHZ1hDVG5PbXFVelZOY1YyTGJ2UjV0ZUlC?=
 =?utf-8?B?eTNTUDYwRWMyeWhUcldERmVUME8ydUtnTHRuOWQzTW5QUHFwWXVKbEFPZkd2?=
 =?utf-8?B?MTN4WHJJM3MraEoyQy9FM1NONnF4aERQaC83a1NSTDBjQ0hpNDZPYlByYUQy?=
 =?utf-8?B?VythNmlCdS80THhPcU9odHRzZlgwWHJjR2Y4RUFjcG82ME1rNmdjT1VtR1RX?=
 =?utf-8?B?UnBCTk95bWh1R0wxcWhaemJZd2NoK3RQNHV2UW8rMDQ3ZVRSK2cwUFpnS2Jj?=
 =?utf-8?B?cVhqMVR6dm40VlMrUUZNUHArdXhWcDlhdTBobnlQU1hkNXpLUnNSTUk5N1Mw?=
 =?utf-8?B?cVRiZjl3ckI3aFovRW1wbk9ZV2tHNjFiWVZSVEJQNCtrbFk0RkZnWjNvVnNo?=
 =?utf-8?B?MGZ1eElwdHV6QlhPMjFiTEdmYU4yVkl0YnZUTzd0WldUUUlZU2g5NlY5ejZC?=
 =?utf-8?B?YS96TzNUSUVsMXY2Tk5sMTRGZWRJa2o4WksyaEVHZHZaK3lvWUZST1FQbUhp?=
 =?utf-8?B?SG1hLzNURnh1dHpzYkNEQ205ZzZXKzE1NUZXMzlPRjF4UUQvR1FWMTNVWlBZ?=
 =?utf-8?B?UmZqRXFWdG9nMDJrdlBmanVxUENudWdQTmV4bUp4b0UzR3pUaUg0eURaT0dh?=
 =?utf-8?B?TXBUR3NhV3FuK1gzSHhIQ2JTSnhVSktoMkFjV1RYTlM5a0t2bEJFbktHVjJB?=
 =?utf-8?B?dnB0Nnc2SmxCOURKOHRxODZEM3B3WkVOZ005L0RHT2pTeDRpU1JYam1ZZnQx?=
 =?utf-8?B?Vm82bWJWT3U3eHBsMUVYR2NtNW40aE5ZL010M29LWkpORVFwM0FDTER5ekE0?=
 =?utf-8?B?eC9NUGQ4N1FNMDZBVmtLZU0yMEswaTNRUWNpTFVTZmRoQ1dtam5rZGZpRzdP?=
 =?utf-8?B?NHlzRTR2c1VJeUdiTE5lbnNLcCtRL25kMU4yUGhOMkJoUWRRaTBITmx3MGhO?=
 =?utf-8?B?VFJMQ2hTdUo1Yi90TWM2ZS8xeHU1aXVkVVZIMmxTU3JtdlNpZjlDUU1NK3Ni?=
 =?utf-8?B?UmJZT2psZjAvUThhakp1OFl0Zmt5R2g4R1puZFB4eWVsUWFlMm1aVURqa3NT?=
 =?utf-8?B?aUZEY1Rod3dIRHd3ejlaS1ZPRDh0OEgrWFR4NnF3eWM4Tm9oSUhJMnIxekhk?=
 =?utf-8?B?R29NcHhFWDRGbG9BS3c3Um4vL1dWZU52TURNZ3hXRkZOVXJtY0I1bHUrc05G?=
 =?utf-8?B?ejQ4ZjVzVmRkdTBPR1hJdTQvb1ZkbHN6MlcxWUgrcStQQytJYkFBdTJWdG1E?=
 =?utf-8?B?UTd5VDROOHQvajl5THJrYUQxZy8rR1hJSys3NXVpNERJMVEzTnBnZXluSDZu?=
 =?utf-8?B?THp5Y1d0QzhRMW02bFFBLzNQOHNnRGdhanAvSGhLd0lsSlBjZEVFYmsvQWtp?=
 =?utf-8?B?c2ZwNWJWUXpNemN2K1hPa3BTellsYmVQUWR5ZE9YWEU5bmVraFdMa29pRlB5?=
 =?utf-8?B?OTFvcnZlOW0zTDltTVBncnhBaEpuRExHekFEYXJtbVFkS1pKVFJCVDJaQ3J6?=
 =?utf-8?B?UGx5WWVWUlB2SDRJWlBLMnNhRTI2WXVnOU8yeEFzdEdSUk9LSmpOU1NmMXZX?=
 =?utf-8?B?QnFQQUt2aUJ2TzdhYkk0RVEwYnhWaElLZGdNcWpoMXBxNTZMUWtkMDBmUGcr?=
 =?utf-8?B?b1Z6ZXhQOE9DNEFVeXN3Q2oyZmNJUW5rbkxOZm9NYmlaM3ZDS0F3eFlMU1J1?=
 =?utf-8?B?WXM0cTh0dGJ4SzJTVVRHUmVTWWlxWloxVVFRdDZlQzJOM0huajNUa3kxL2xv?=
 =?utf-8?B?c2FPRGdHZVVRUXVpdlQydWRqZlJueDI2T1BoTU44SHozcEJMWEJtemNyVHFp?=
 =?utf-8?B?L0Y5Unl5M3NzUE8zckxibzdqZmpHTjFIQWFhdkVuTGlGZXphdVJ1bFczVXp4?=
 =?utf-8?B?QzJ6d1VHeFd3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzNjWHFrOTNlU0FnQ0tyS2VTZnRxc0JKTkZIYTc3TWZsbDg1eVFWNlJGYWxE?=
 =?utf-8?B?MHJ1QU5YV2g0SFEwcmR5UTk1Y3l0NmF4V1JaYU1ObjVkZ2xMU1JLeHZaQjFx?=
 =?utf-8?B?YUhiZzhyMEFPZzFxZUxJekQ4Y3VKbU1tUGVaKzBCZzJFdVMrSCs3NXFlNHpG?=
 =?utf-8?B?Y2IvbWtxdFptMDFRVHhNaUNQYzFCZ2M2M2FDV0VXYWVkdDk4elRsSFR6S2hE?=
 =?utf-8?B?V2lta3RmaXZBdCtXVHFZMWl1K1ZMYUc0dTJ4Z29nbUhuTU1NSGxlL1I3Q09S?=
 =?utf-8?B?eGN4UUo1NjVubjZnbUdtbkpGcEhuMExxQkM4U0I1UldBZWZBYW5nMnEyaG5y?=
 =?utf-8?B?MkRjeE1aTVdUMU1MMUZjOURkUm1RU28zbE45VjgxeC9pNmgrZVFtdkp1eERL?=
 =?utf-8?B?L21UTzh4YjY0NHlxWDdHVkNTS1daL2gzblYvQkpGMDRyVUdQRGxsenJadEJG?=
 =?utf-8?B?dE1HRFgxdjRWbU5DK2RjOTU2RnNnYUdlYUlYNEgxSjB3VzhJV2xxMUtjY3lQ?=
 =?utf-8?B?WDhJMllrbStZWmd5by9WTS96MUV3blpCbnVUeTRaS3I5ZVBCcDRHenhRM0Iy?=
 =?utf-8?B?Y0pNeFVUa0dtTHR4a0dvQ2sxdHRVY3o5L09oWDl5M2VRTk1tM3ZjckFndnps?=
 =?utf-8?B?bFk5YStsT1FBd0M5ZHRTaURQRDcvd1dzcGs2QS9LZ1NQazVzaU5uZzR5VFNI?=
 =?utf-8?B?L1VVelUvTm9qbnpLSStHZ0xzbjRvRFJwMnN1YUlTMmE3aHNTUi81eU1mTkw1?=
 =?utf-8?B?Y3MzeE5WdVN1dTI4NHc1ZkpnNm5nbUJvUHFmK3RqMTdYbmdJejBYZnpjbjRF?=
 =?utf-8?B?SHhINk5GcU9HVjZlMlBIWWJjaTk4emdwRWN0QThrNnlGTG1kR2JGditHWVVz?=
 =?utf-8?B?OElSdERJMWpNMDNUZjc1Ykgxc1d5b3QvVmtLZ1RWamlnWE9nL3NNSEEvcEg5?=
 =?utf-8?B?N1l5RFJyUi9xdVFtYnM1ZWt6TzJOTWZNeEF5bUk1bDBLbEc2cXhGd1A2K083?=
 =?utf-8?B?WGwxZFoxdlUyVnZibjd0NHNVUUFrMFJjOUMwbDV2OUdCSk8xWDc2a1pqcmN0?=
 =?utf-8?B?RGhyUFVlZTRaRjRjRzZnZEh2Nk9hOEVkSS9XK2poaWF2cGo0Um1GMUxiTUM5?=
 =?utf-8?B?ZmRFSk1zbDlrRW0vVEhFUkYyc1J5MzU1UEd2OUdRL0Rwazhrb25jbi9sTDlp?=
 =?utf-8?B?N3B2dUU2NEhmMCtsWXRHT1NxVFZMVjZZTjVIeUpmRmJaVXpRZ3hYZ0tHQlNJ?=
 =?utf-8?B?NENHN3MxaW51Y2h5d0JDR0djZlZXNnFNSjUyc290cUpJS25rRjkyL3lrcVVK?=
 =?utf-8?B?d1paOVpqdENwNDdEZmxHNXl5Y0hYNUw4cTlCVkdId2IwbHFIRktERWVNdWZ2?=
 =?utf-8?B?K1BtYmZJV0NjbTJYdG84Mlh4amdXR3NyRUFIQ1Jwb0NXd1F1eUZiSHZ5Mk5P?=
 =?utf-8?B?NTdtL05ZQmMzRTJxVjJsU3JFeHRMakZmdDNMMmVRYlNIQmFRVFVMbTVHYzRl?=
 =?utf-8?B?NVZTZlllcmpvK2FZS0NUYVhCallQV2huWHJVV0ovSWpLN1I5aC9vMnowSDJB?=
 =?utf-8?B?eXB1a3NHbk9uL3V5UkVyV3RsZXJQOFoxb3dPYTBRM3V5L05LU1ZsdXFiOEdN?=
 =?utf-8?B?WWN0OXdNdlBta1ZIZUtscTlHRUhoNlBNM2NlZzRsdXFCVzB0bG9zanprRHhH?=
 =?utf-8?B?K1JNR2hPTWxqVmZaTjRKUXQ5MnBnRXVORnZjWDhTNVk4VjkwcEdnMnc1My9M?=
 =?utf-8?B?VWx1OEI5L0dMSjBvV25XWDN1M0RnSkF1TEk4eDNJM1NwTGdTZTJnUkR4MXpY?=
 =?utf-8?B?d1JBRlFSaTdqSzh2d0QxbEhSVTRYQ3A1bjdjVEQ3bWNwY2JEdWZZYm9kMTQv?=
 =?utf-8?B?d1Z5K2gvTkFlcEFoSWZEVVZScWlEdHo5SjdjQmNvR1kydlNPWkQ1MDh5RDBM?=
 =?utf-8?B?ZWdONndiNmMyNHdWdEJlaDdzcUpDWkQ1TzZxdjNGSlQ0amIwQTVvMXBNZnNx?=
 =?utf-8?B?VDZKbkFGMTJhaHAxeHFFQVRxenhJL3BhRzhIaFZwV0lsMjZaTjJJV0Z3WlJl?=
 =?utf-8?B?dk9IazZQS2diWVNlM0xQdmxQUi9TQVY4eHdTSk1oMHRQL2pkN3kyeHJkVGQx?=
 =?utf-8?B?emlYOG11Ri9ZMW1aQzlWVS9QSGdCaGZhK0V6QjFVUWJJNkpaSmxTOXZiUHh0?=
 =?utf-8?B?bmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tdJ/ftVjs7/fPet/BGZZY9IjxTcjezx30k4PBF6O7Ii1nDknJrhkFOLDMJ7uGQgVNlb86rNG/B61ezeCiW2on0gx0gVTkNO7wps7uzvQJQ+Hlv9fGlHsuW4d0ZA/QdsXf2A333bTtt8jete7r4JLzKwLWyNg4jJhinuMPmSBLc80PYMLhxM2oQ8v833PIWs6BJnMl/vKxA6K18pdM5mdCJJYDitzVjoqyppxw49XEuHuRWLbqDsDogOvsOKaK11/qkXWDQJWy5dj/O8ejPzK0pQJQ9cATgjpoF6ymm6lNYtr++9nh3CVQOuPXHJhl9yHeOU5sw3xv4ru+IhQA+0u26bRxMGliRi0sMj8/lhgc5wfZI8qAsRNpdo+40XGh+Ij6s5OjHn/WNMt4okFkpWc2bEunzdRYtzt1Qd7UDo/CmyFE5WTROoYs+LpqBEY+qgpDasF/dmrCDqRnd67T6ssOuLERhQ/9Acx7ToxXtAsY9IniXZFCi8KqvgSoiZ2uq3D+40aMrXhxLgWUllINg7vv7I0qFSpDAaL9APX0oVotVRIIl6DwSR44ctPepsI/CtepH1YFXEy+FKhRnwAx6vZnIN1xQoJwXqy/Zm0xvEKR3s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47b49c60-a2f6-4c39-c242-08de3675f0a2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 16:22:11.1796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4SDnHt/4+duKbW8GAyZneQ1Xkli5FJmNsHu9iVM7X6VeBqaQeDzfxJtIQwIfgivN4DUM5fMMK94VnDNqjwS1vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5918
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512080138
X-Authority-Analysis: v=2.4 cv=bL4b4f+Z c=1 sm=1 tr=0 ts=6936fb38 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=OeGUaOgzXAwiHrPWGKgA:9 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:13642
X-Proofpoint-ORIG-GUID: 3ohylX2CjawcvGfeG2XWzdXoh9WSlW6d
X-Proofpoint-GUID: 3ohylX2CjawcvGfeG2XWzdXoh9WSlW6d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA4MDEzOCBTYWx0ZWRfX+rMqW2LzGrwG
 8Tt/g6oPu38iXJeWKUBnhWxqT+kVt4P1x0eoFT+TiVzDs7sA5yq0wa4+PLs0n3KVkoj67lJ7Lal
 eyhZtFFcPeVkHlYJCsaqLRbwp088mzhjrxY91nRBajSSlGRsraNpyqKPmkJ+VIPEqtCJNbj8PpJ
 6rAfEUNmXAC21r/Ty8bhcNrIfaRq8r8u8gnr6s/oiYPZq+es6yCbMmL2CioKkN3fPx9BK92Fq62
 tFhsFi2TWnz65LlGYs/NujGvECT9Ozfa1zHUOwDyJdsJ+kvTGtb8yvcHmSu0HVsaYW0ZkH/SAwL
 ELLgOEK9kEm/XwhFiSWdkCQts4VyFfS2lMK5rL22aVVkBhqen+Zz/tdTiUJi5nCGIIXQDuBO7t4
 Q0S2dcXipm2D8/RlbXATCMb+gqVnErHgpw3mDq6/VpMwpdICTag=

On 30/11/2025 04:03, Yonghong Song wrote:
> Overview
> ========
> 
> The llvm pull request ([1]) is able to emit dwarf data for
> changed-signature and new functions. The new dwarf format has
> tag DW_TAG_inlined_subroutine and directly under CU. There
> is no other change for existing dwarf. See further down examples.
> 
> When building linux kernel with [1], additional functions will
> be added to dwarf:
>   - A function with signature changed compared to source.
>     For example, original function foo(int a, int b) is optimized
>     too foo(int b). The foo(int b) will be added to dwarf
>     and the original foo(int a, int b) is not touched.
>   - A function generated by the compiler which typically will have
>     '.' in the function name, for example, in thin-lto mode,
>     a function could be foo.llvm.<hash>.
> 
> A new feature 'true_signature' is introduced in pahole. Only if
> 'true_signature' is enabled by pahole in linux kernel, pahole will
> either replace the old function with new function for correct
> signature in vmlinux/module btf, or add new functions to the btf
> like foo.llvm.<hash>.
>

hi Yonghong,

The true signature approach makes sense, but I wonder if we could align
the LLVM DWARF representation a bit better with what gcc does today. Jose
or David can chime in if I've got this wrong but my understanding is that
we have 

1. An abstract representation of the function, corresponding to the source
representation. It uses a DW_TAG_subprogram and declares the name,
parameters etc but doesn't have any attributes like low_pc/high_pc associated
with it.

As an example consider

static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu);

It has - as expected - an abstract representation as follows:

 <1><6392a2d>: Abbrev Number: 47 (DW_TAG_subprogram)
    <6392a2e>   DW_AT_name        : (indirect string, offset: 0x261e25): __blkcg_rstat_flush
    <6392a32>   DW_AT_decl_file   : 1
    <6392a33>   DW_AT_decl_line   : 1043
    <6392a35>   DW_AT_decl_column : 13
    <6392a36>   DW_AT_prototyped  : 1
    <6392a36>   DW_AT_inline      : 1   (inlined)
    <6392a37>   DW_AT_sibling     : <0x6392bac>
 <2><6392a3b>: Abbrev Number: 38 (DW_TAG_formal_parameter)
    <6392a3c>   DW_AT_name        : (indirect string, offset: 0xa7a9f): blkcg
    <6392a40>   DW_AT_decl_file   : 1
    <6392a41>   DW_AT_decl_line   : 1043
    <6392a43>   DW_AT_decl_column : 47
    <6392a44>   DW_AT_type        : <0x638b611>
 <2><6392a48>: Abbrev Number: 20 (DW_TAG_formal_parameter)
    <6392a49>   DW_AT_name        : cpu
    <6392a4d>   DW_AT_decl_file   : 1
    <6392a4e>   DW_AT_decl_line   : 1043
    <6392a50>   DW_AT_decl_column : 58
    <6392a51>   DW_AT_type        : <0x6377f8f>


2. Possibly multiple concrete representations. For the above function,
the concrete representation after optimization is

ffffffff8186d180 t __blkcg_rstat_flush.isra.0

and has a concrete representation with parameter order switched:

<1><6399661>: Abbrev Number: 110 (DW_TAG_subprogram)
    <6399662>   DW_AT_abstract_origin: <0x6392a2d>
    <6399666>   DW_AT_low_pc      : 0xffffffff8186d180
    <639966e>   DW_AT_high_pc     : 0x169
    <6399676>   DW_AT_frame_base  : 1 byte block: 9c    (DW_OP_call_frame_cfa)
    <6399678>   DW_AT_GNU_all_call_sites: 1
    <6399678>   DW_AT_sibling     : <0x6399a8a>
 <2><639967c>: Abbrev Number: 4 (DW_TAG_formal_parameter)
    <639967d>   DW_AT_abstract_origin: <0x6392a48>
    <6399681>   DW_AT_location    : 0x1fe21fb (location list)
    <6399685>   DW_AT_GNU_locviews: 0x1fe21f5
 <2><63996e4>: Abbrev Number: 4 (DW_TAG_formal_parameter)
    <63996e5>   DW_AT_abstract_origin: <0x6392a3b>
    <63996e9>   DW_AT_location    : 0x1fe2387 (location list)
    <63996ed>   DW_AT_GNU_locviews: 0x1fe2385

In other words - presuming locations tell us that these parameters are
in the expected registers based on calling conventions - we end up with

static void __blkcg_rstat_flush.isra.0(int cpu, struct blkcg *blkcg);

We can tie it to the .isra.0 instance via function address from DW_AT_low_pc,
and the order change of DW_TAG_formal_parameters tells us the rest.

So it seems like the concrete/abstract representations _could_ handle
parameter order changes, missing parameters. The only case missing is
where we end up with a parameter _type_ transformation, like where

static int map_create(union bpf_attr *attr, bpfptr_t uattr);

becomes

static int map_create(union bpf_attr *attr, bool is_kernel)

I presume supplementing the concrete instance with a fresh (not abstract 
origin-referencing) DW_TAG_formal_parameter for is_kernel would work here 
though? Is there anything else you need for the true signature representation 
that such an approach is missing?

If we could bring these approaches a bit closer I think we could get pahole to
emit true signatures for LLVM/gcc using the same/similar code which would
make things more maintainable, and wouldn't require any deviations from existing
DWARF.

Thanks!

Alan
 
> Below are some more detailed illustration of new dwarf format,
> how compiler controls what to generate, and how newly added
> functions (e.g., foo.llvm.<hash>) could be used, etc.
> 
> Added Dwarf Contents
> ====================
> 
> The following are some examples from linux kernel.
> 
> Example 1
> ---------
> 
>   0x000411f0:   DW_TAG_inlined_subroutine
>                   DW_AT_name      ("split_fs_names")
>                   DW_AT_type      (0x00023368 "int")
>                   DW_AT_artificial        (true)
>                   DW_AT_specification     (0x00040d1f "split_fs_names")
> 
>   0x000411fc:     DW_TAG_formal_parameter
>                     DW_AT_name    ("page")
>                     DW_AT_type    (0x000233bb "char *")
> 
>   0x00041204:     NULL
> 
> vmlinux BTF:
>   [131534] FUNC_PROTO '(anon)' ret_type_id=14 vlen=1
>           'page' type_id=100
>   [131535] FUNC 'split_fs_names' type_id=131534 linkage=static
> 
> Signature changed due to optimization. The source signature is
>   static int __init split_fs_names(char *page, size_t size) { ... }
> 
> The vmlinux BTF will encode 'int split_fs_names(char *page)'.
> 
> Example 2
> ---------
> 
>   0x01886077:   DW_TAG_inlined_subroutine
>                   DW_AT_name      ("map_create")
>                   DW_AT_type      (0x01854182 "int")
>                   DW_AT_artificial        (true)
>                   DW_AT_specification     (0x01870e96 "map_create")
> 
>   0x01886083:     DW_TAG_formal_parameter
>                     DW_AT_name    ("attr")
>                     DW_AT_type    (0x01854370 "bpf_attr *")
> 
>   0x0188608b:     DW_TAG_formal_parameter
>                     DW_AT_name    ("is_kernel")
>                     DW_AT_type    (0x01855b14 "bool")
> 
>   0x01886093:     NULL
> 
> vmlinux BTF:
>   [119] TYPEDEF 'bool' type_id=120
>   [120] INT '_Bool' size=1 bits_offset=0 nr_bits=8 encoding=BOOL
>   ...
>   [106699] FUNC_PROTO '(anon)' ret_type_id=14 vlen=2
>           'attr' type_id=707
>           'is_kernel' type_id=119
>   [106700] FUNC 'map_create' type_id=106699 linkage=static
> 
> Signature changed due to optimization. The source signature is
>   typedef struct {
>         union {
>                 void            *kernel;
>                 void __user     *user;
>         };
>         bool            is_kernel : 1;
>   } sockptr_t;
>   typedef sockptr_t bpfptr_t;
>   static int map_create(union bpf_attr *attr, bpfptr_t uattr) { ... }
> 
> In the above, the second parameter 'is_kernel' corresponds to the
> second member in sockptr_t.
> 
> Example 3
> ---------
> 
>   0x0060dd56:   DW_TAG_inlined_subroutine
>                   DW_AT_name      ("enable_step.llvm.569499763459584554")
>                   DW_AT_artificial        (true)
>                   DW_AT_specification     (0x0060d396 "enable_step")
> 
>   0x0060dd5d:     DW_TAG_formal_parameter
>                     DW_AT_name    ("child")
>                     DW_AT_type    (0x006046b9 "task_struct *")
> 
>   0x0060dd64:     DW_TAG_formal_parameter
>                     DW_AT_name    ("block")
>                     DW_AT_type    (0x00605b99 "bool")
> 
>   0x0060dd6b:     NULL
> 
>   [90683] FUNC_PROTO '(anon)' ret_type_id=0 vlen=2
>           'child' type_id=321
>           'block' type_id=45
>   [90684] FUNC 'enable_step.llvm.569499763459584554' type_id=90683 linkage=static
> 
> No signature change. But the thin-lto promoted the function enable_step() to global,
> hence enable_step.llvm.<hash>.
> 
> Example 4
> ---------
> 
>   0x00b920fb:   DW_TAG_inlined_subroutine
>                   DW_AT_name      ("__ioremap_caller.llvm.766076626088609549")
>                   DW_AT_type      (0x00b83dd6 "void *")
>                   DW_AT_artificial        (true)
>                   DW_AT_specification     (0x00b8420d "__ioremap_caller")
> 
>   0x00b92109:     DW_TAG_formal_parameter
>                     DW_AT_name    ("phys_addr")
>                     DW_AT_type    (0x00b850b2 "resource_size_t")
> 
>   0x00b92111:     DW_TAG_formal_parameter
>                     DW_AT_name    ("size")
>                     DW_AT_type    (0x00b841dd "unsigned long")
> 
>   0x00b92119:     DW_TAG_formal_parameter
>                     DW_AT_name    ("pcm")
>                     DW_AT_type    (0x00b84562 "page_cache_mode")
> 
>   0x00b92121:     DW_TAG_formal_parameter
>                     DW_AT_name    ("caller")
>                     DW_AT_type    (0x00b83dd6 "void *")
> 
>   0x00b92129:     NULL
> 
> The corresponding vmlinux BTF:
>   [60222] FUNC_PROTO '(anon)' ret_type_id=17 vlen=4
>           'phys_addr' type_id=56
>           'size' type_id=15
>           'pcm' type_id=5633
>           'caller' type_id=17
>   [60223] FUNC '__ioremap_caller.llvm.766076626088609549' type_id=60222 linkage=static
> 
> For this one, the signature and func name changed for __ioremap_caller().
> The original signature is
>   static void __iomem *
>   __ioremap_caller(resource_size_t phys_addr, unsigned long size,
>                    enum page_cache_mode pcm, void *caller, bool encrypted) { ... }
> 
> Note that since '__ioremap_caller' is promoted to '__ioremap_caller.llvm.766076626088609549'
> and '__ioremap_caller' is not in kallsyms, vmlinux BTF will not have
> a function entry for '__ioremap_caller'. See below.
> 
>   [root@arch-fb-vm1 bpf]# grep __ioremap_caller /proc/kallsyms
>   ffffffff812c7b80 T __pfx___ioremap_caller.llvm.16406939874149108668
>   ffffffff812c7b90 t __ioremap_caller.llvm.16406939874149108668
>   ffffffff82c267f2 d __ioremap_caller._entry
>   ...
>   [root@arch-fb-vm1 bpf]# grep __ioremap_caller /sys/kernel/debug/tracing/available_filter_functions
>   __ioremap_caller.llvm.16406939874149108668
>   [root@arch-fb-vm1 bpf]#
> 
> Build Linux Kernel
> ==================
> 
> The following kernel patch is needed to support true signatures:
>   diff --git a/Makefile b/Makefile
>   index 088565edc911..a35dd86c7639 100644
>   --- a/Makefile
>   +++ b/Makefile
>   @@ -1002,6 +1002,11 @@ endif
>    ifdef CONFIG_LTO_CLANG
>    ifdef CONFIG_LTO_CLANG_THIN
>    CC_FLAGS_LTO   := -flto=thin -fsplit-lto-unit
>   +ifeq ($(call test-ge, $(CONFIG_PAHOLE_VERSION), 131),y)
>   +ifeq ($(call clang-min-version, 220000),y)
>   +KBUILD_LDFLAGS  += $(call ld-option, -mllvm -enable-changed-func-dbinfo)
>   +endif
>   +endif
>    else
>    CC_FLAGS_LTO   := -flto
>    endif
>   @@ -1009,6 +1014,12 @@ CC_FLAGS_LTO     += -fvisibility=hidden
> 
>    # Limit inlining across translation units to reduce binary size
>    KBUILD_LDFLAGS += -mllvm -import-instr-limit=5
>   +else
>   +ifeq ($(call test-ge, $(CONFIG_PAHOLE_VERSION), 131),y)
>   +ifeq ($(call clang-min-version, 220000),y)
>   +KBUILD_CFLAGS  += -mllvm -enable-changed-func-dbinfo
>   +endif
>   +endif
>    endif
> 
>    ifdef CONFIG_LTO
>   diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
>   index db76335dd917..2f66cc0bc2b5 100644
>   --- a/scripts/Makefile.btf
>   +++ b/scripts/Makefile.btf
>   @@ -23,7 +23,7 @@ else
>    # Switch to using --btf_features for v1.26 and later.
>    pahole-flags-$(call test-ge, $(pahole-ver), 126)  = -j$(JOBS) --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs
> 
>    pahole-flags-$(call test-ge, $(pahole-ver), 130) += --btf_features=attributes
>   +pahole-flags-$(call test-ge, $(pahole-ver), 131) += --btf_features=true_signature
> 
> Remarks
> =======
> 
> The llvm patch [1] supports remarks which help dump out some debug info,
> e.g., why a particular function is skipped or generated in special way. The
> below kernel build option can enable remarks:
> 
>   KBUILD_LDFLAGS  += $(call ld-option, -mllvm -enable-changed-func-dbinfo \
>       --opt-remarks-filename <prefix> --opt-remarks-passes emit-changed-func-debuginfo)
>   KBUILD_CFLAGS  += -mllvm -enable-changed-func-dbinfo -fsave-optimization-record \
>       -foptimization-record-passes=emit-changed-func-debuginfo
> 
> In the above, the <prefix> can be e.g. /home/<login_name>/tmp/lto.opt.yaml or
> lto.opt.yaml. If the <prefix> is /home/<login_name>/tmp/lto.opt.yaml, the extra
> yaml files will be list of /home/<login_name>/tmp/lto.opt.yaml.thin.<number>'s
> which represents each original source file. If the <prefix> is lto.opt.yaml,
> the extra yaml files will be in the build directory with lto.opt.yaml.thin.<number>'s.
> 
> For no-lto mode, the remark files will be in the same directory as
> the corresponding object file. For example, for kernel/bpf/core.o, the corresponding
> yaml file will be kernel/bpf/core.opt.yaml.
> 
> The following command can help find any non-empty remark file which can
> help debugging.
>   find . -type f -name '*.opt.yaml.*' -size +0c
> For anything with non-zero size, inspection should be able to find
> which function has some issues for generating true signature.
> 
> Currently, there are no remarks generated with latest bpf-next.
> The following is a remark example in the commit message in [1].
> 
>   $ cat test.opt.yaml
>   --- !Passed
>   Pass:            emit-changed-func-debuginfo
>   Name:            FindNoDIVariable
>   DebugLoc:        { File: test.c, Line: 1, Column: 0 }
>   Function:        callee
>   Args:
>     - String:          'create a new int type '
>     - ArgName:         ''
>     - String:          '('
>     - ArgIndex:        '0'
>     - String:          ')'
>   ...
> 
> Some Statictics
> ===============
> 
> Compare no-lto and lto functions:
> -------------------------------------------
> 
>   without -mllvm -enable-changed-func-dbinfo:
>     no-lto: 66051 functions
>     lto:     66227 functions
>   additional functions with -mllvm -enable-changed-func-dbinfo:
>     no-lto: 894  new DW_TAG_inlined_subroutine entries
>     lto:    2991 ...
> 
> vmlinux BTF size:
> ----------------
>                                        size
>   no-lto without new signatures:       0x623746
>   no-lto with new signatures:          0x62712e
> 
>   lto without new signatures:          0x6335b9
>   lto with new signatures:             0x642ea3
> 
> For no-lto build, the vmlinux BTF increases 14824 bytes compared to
> the build without new signatures.
> 
> For lto build, the vmlinux BTF increases 63722 bytes compared to
> the build without new signatures.
> 
> So looks like the BTF increase should not be a concern here.
> 
> Should Import Functions with Dot?
> ====================================
> 
> Current pahole removed ".<...>" suffix in kallsyms so the function
> name can match the source-level dwarf. This way, the vmlinux BTF has
> source-level function name.
> 
> There is a debate whether dwarf function like <foo>.llvm.<hash> should
> be introduced into vmlinux BTF. Current pahole searches kallsyms and
> for symbol like <foo>.llvm.<hash>, only <foo> is represented as an elf
> symbol. But for kallsyms and
> /sys/kernel/debug/tracing/available_filter_functions etc., actual functions,
> e.g., <foo>.llvm.<hash>, are encoded there. So it should be a good idea to
> be consistent using the same function name (e.g., <foo>.llvm.<hash>) for
> to-be-traced func name and the actual name in kernel.
> 
> In [1], function with dot (e.g., foo.llvm.<hash>) is allowed to be
> in dwarf. This paves the way to have such functions in kernel BTF as well.
> 
> Previously, fentry/fexit for function enable_step.llvm.569499763459584554() won't work
> since in vmlinux BTF, the name is 'enable_step'. But 'enable_step' is not in kallsyms,
> so bpf program load will fail. Now we have a function entry with name
> enable_step.llvm.569499763459584554 in BTF and the name matches with kernel, so
> fentry/fexit can be successful although this needs a little bit user work:
> 
>         skel = fentry_lto__open();
>         if (!ASSERT_OK_PTR(skel, "fentry_lto__open"))
>                 return;
> 
>         /* The fentry target is 'enable_step' or 'enable_step.llvm.<hash>' */
>         /* User need to find out whether either or them exist in ksyms.
>          * Let us assume enable_step.llvm.<hash>() exists and enable_step()
>          * does not exist in kallsyms.
>          */
> 
>         prog = skel->progs.test1;
>         bpf_program__set_attach_target(prog, 0, "enable_step.llvm.<hash>");
> 
>         err = fentry_lto__load(skel);
>         if (!ASSERT_OK(err, "fentry_lto__load"))
>                 goto out;
> 
> There is an alternative solution to handle the above in [2] which utilizes
> the kprobe_multi with option 'unique_match'. It should work in most cases
> except something like functions foobar() and foo.llvm.<hash>(). In such cases,
> unique_match 'foo*' will not work since it will match both functions.
> Maybe regex could be 'foo.llvm.*'. The above bpf_program__set_attach_target()
> approach seems more robust.
> 
> Linux Kernel BPF Selftest Resutls
> =================================
> 
> Tried with both no-lto and lto mode, there are no additional selftest
> failures compared to without this patch set.
> 
> Future Work
> ===========
> 
> We need gcc side to generate true signatures as well with ideally
> the same dwarf format.
> 
>   [1] https://github.com/llvm/llvm-project/pull/165310
>   [2] https://lore.kernel.org/bpf/20250109174023.3368432-1-yonghong.song@linux.dev/
> 
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  btf_encoder.c  | 46 +++++++++++++++++++++++-----
>  dwarf_loader.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  dwarves.h      |  4 +++
>  pahole.c       |  9 ++++++
>  4 files changed, 132 insertions(+), 8 deletions(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 3486fa3..229b34f 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -88,6 +88,7 @@ struct btf_encoder_func_state {
>  	uint8_t inconsistent_proto:1;
>  	uint8_t uncertain_parm_loc:1;
>  	uint8_t ambiguous_addr:1;
> +	uint8_t true_signature:1;
>  	int ret_type_id;
>  	struct btf_encoder_func_parm *parms;
>  	struct btf_encoder_func_annot *annots;
> @@ -144,11 +145,13 @@ struct btf_encoder {
>  			  skip_encoding_decl_tag,
>  			  tag_kfuncs,
>  			  gen_distilled_base,
> -			  encode_attributes;
> +			  encode_attributes,
> +			  dotted_true_signature;
>  	uint32_t	  array_index_id;
>  	struct elf_secinfo *secinfo;
>  	size_t             seccnt;
>  	int                encode_vars;
> +	int		   nr_true_signature_funcs;
>  	struct {
>  		struct btf_encoder_func_state *array;
>  		int cnt;
> @@ -184,7 +187,7 @@ static inline void elf_functions__delete(struct elf_functions *funcs)
>  	free(funcs);
>  }
>  
> -static int elf_functions__collect(struct elf_functions *functions);
> +static int elf_functions__collect(struct btf_encoder *encoder, struct elf_functions *functions);
>  
>  struct elf_functions *elf_functions__new(struct btf_encoder *encoder)
>  {
> @@ -206,7 +209,7 @@ struct elf_functions *elf_functions__new(struct btf_encoder *encoder)
>  	}
>  
>  	funcs->elf = elf;
> -	err = elf_functions__collect(funcs);
> +	err = elf_functions__collect(encoder, funcs);
>  	if (err < 0)
>  		goto out_delete;
>  
> @@ -1263,6 +1266,7 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
>  	state->elf = func;
>  	state->nr_parms = ftype->nr_parms + (ftype->unspec_parms ? 1 : 0);
>  	state->ret_type_id = ftype->tag.type == 0 ? 0 : encoder->type_id_off + ftype->tag.type;
> +	state->true_signature = ftype->true_signature;
>  	if (state->nr_parms > 0) {
>  		state->parms = zalloc(state->nr_parms * sizeof(*state->parms));
>  		if (!state->parms) {
> @@ -1436,7 +1440,20 @@ static int saved_functions_cmp(const void *_a, const void *_b)
>  	const struct btf_encoder_func_state *a = _a;
>  	const struct btf_encoder_func_state *b = _b;
>  
> -	return elf_function__name_cmp(a->elf, b->elf);
> +	int ret = strcmp(a->elf->name, b->elf->name);
> +	if (ret)
> +		return ret;
> +
> +	/* Two identical names, if one has true_signture attribute, make sure the
> +	 * one has true_attirube in earlier place. This way, the other function
> +	 * will be filtered out during later btf generation.
> +	 */
> +	if (a->true_signature)
> +		return -1;
> +	else if (b->true_signature)
> +		return 1;
> +
> +	return 0;
>  }
>  
>  static int saved_functions_combine(struct btf_encoder *encoder,
> @@ -1448,6 +1465,10 @@ static int saved_functions_combine(struct btf_encoder *encoder,
>  	if (a->elf != b->elf)
>  		return 1;
>  
> +	/* Skip if any of the func states represents a true_signature function. */
> +	if (a->true_signature || b->true_signature)
> +		return 0;
> +
>  	optimized = a->optimized_parms | b->optimized_parms;
>  	unexpected = a->unexpected_reg | b->unexpected_reg;
>  	inconsistent = a->inconsistent_proto | b->inconsistent_proto;
> @@ -2213,9 +2234,10 @@ static inline int elf_function__push_sym(struct elf_function *func, struct elf_f
>  	return 0;
>  }
>  
> -static int elf_functions__collect(struct elf_functions *functions)
> +static int elf_functions__collect(struct btf_encoder *encoder, struct elf_functions *functions)
>  {
>  	uint32_t nr_symbols = elf_symtab__nr_symbols(functions->symtab);
> +	bool dotted_true_signature = encoder->dotted_true_signature;
>  	struct elf_function_sym func_sym;
>  	struct elf_function *func, *tmp;
>  	const char *sym_name, *suffix;
> @@ -2224,10 +2246,10 @@ static int elf_functions__collect(struct elf_functions *functions)
>  	uint32_t core_id;
>  	GElf_Sym sym;
>  
> -	/* We know that number of functions is less than number of symbols,
> +	/* We know that number of functions is less than number of symbols plus number of true signature funcs,
>  	 * so we can overallocate temporarily.
>  	 */
> -	functions->entries = calloc(nr_symbols, sizeof(*functions->entries));
> +	functions->entries = calloc(nr_symbols + encoder->nr_true_signature_funcs, sizeof(*functions->entries));
>  	if (!functions->entries) {
>  		err = -ENOMEM;
>  		goto out_free;
> @@ -2251,7 +2273,13 @@ static int elf_functions__collect(struct elf_functions *functions)
>  			continue;
>  
>  		func = &functions->entries[functions->cnt];
> -		if (suffix)
> +		/* Currently, dotted_true_signature = true only available for LLVM.
> +		 * If dotted_true_signature is true, the ksym function name will be
> +		 * encoded as btf function name. If dotted_true_signature is false,
> +		 * for llvm the suffix should be NULL and for gcc the existing logic
> +		 * should be the same as before.
> +		 */
> +		if (!dotted_true_signature && suffix)
>  			func->name = strndup(sym_name, suffix - sym_name);
>  		else
>  			func->name = strdup(sym_name);
> @@ -2574,6 +2602,8 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>  		encoder->tag_kfuncs	 = conf_load->btf_decl_tag_kfuncs;
>  		encoder->gen_distilled_base = conf_load->btf_gen_distilled_base;
>  		encoder->encode_attributes = conf_load->btf_attributes;
> +		encoder->dotted_true_signature = conf_load->dotted_true_signature;
> +		encoder->nr_true_signature_funcs = conf_load->nr_true_signature_funcs;
>  		encoder->verbose	 = verbose;
>  		encoder->has_index_type  = false;
>  		encoder->need_index_type = false;
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index 79be3f5..96fc609 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -537,6 +537,19 @@ static void tag__init(struct tag *tag, struct cu *cu, Dwarf_Die *die)
>  	INIT_LIST_HEAD(&tag->node);
>  }
>  
> +static void tag__init_true_signature(struct tag *tag, struct cu *cu, Dwarf_Die *die)
> +{
> +	struct dwarf_tag *dtag = tag__dwarf(tag);
> +
> +	tag->tag = DW_TAG_subprogram;
> +	dtag->id  = dwarf_dieoffset(die);
> +	dwarf_tag__set_attr_type(dtag, type, die, DW_AT_type);
> +	tag->recursivity_level = 0;
> +	tag->attributes = NULL;
> +
> +	INIT_LIST_HEAD(&tag->node);
> +}
> +
>  static struct tag *tag__new(Dwarf_Die *die, struct cu *cu)
>  {
>  	struct tag *tag = tag__alloc(cu, sizeof(*tag));
> @@ -1487,6 +1500,22 @@ static void ftype__init(struct ftype *ftype, Dwarf_Die *die, struct cu *cu)
>  	ftype->template_parameter_pack = NULL;
>  }
>  
> +static void ftype__init_true_signature(struct ftype *ftype, Dwarf_Die *die, struct cu *cu)
> +{
> +#ifndef NDEBUG
> +	const uint16_t tag = dwarf_tag(die);
> +	assert(tag == DW_TAG_inlined_subroutine);
> +#endif
> +	tag__init_true_signature(&ftype->tag, cu, die);
> +	INIT_LIST_HEAD(&ftype->parms);
> +	INIT_LIST_HEAD(&ftype->template_type_params);
> +	INIT_LIST_HEAD(&ftype->template_value_params);
> +	ftype->nr_parms	    = 0;
> +	ftype->unspec_parms = 0;
> +	ftype->template_parameter_pack = NULL;
> +	ftype->true_signature = 1;
> +}
> +
>  static struct ftype *ftype__new(Dwarf_Die *die, struct cu *cu)
>  {
>  	struct ftype *ftype = tag__alloc(cu, sizeof(*ftype));
> @@ -2468,9 +2497,61 @@ static struct tag *__die__process_tag(Dwarf_Die *die, struct cu *cu,
>  	return tag;
>  }
>  
> +static int die__process_inline_subroutine(Dwarf_Die *die, struct cu *cu, struct conf_load *conf, const char *name)
> +{
> +	struct function *function = tag__alloc(cu, sizeof(*function));
> +
> +	if (function != NULL) {
> +		ftype__init_true_signature(&function->proto, die, cu);
> +		lexblock__init(&function->lexblock, cu, die);
> +		function->name = name;
> +		tag__set_spec(&function->proto.tag, die);
> +		INIT_LIST_HEAD(&function->annots);
> +		function->cu_total_size_inline_expansions = 0;
> +		function->cu_total_nr_inline_expansions = 0;
> +		function->priv = NULL;
> +	}
> +
> +	if (function != NULL &&
> +	    die__process_function(die, &function->proto, &function->lexblock, cu, conf) != 0) {
> +		function__delete(function, cu);
> +		function = NULL;
> +	}
> +
> +	struct tag *tag = function ? &function->proto.tag : NULL;
> +	if (tag == NULL)
> +		return -ENOMEM;
> +
> +	uint32_t id = 0;
> +	tag->top_level = 1;
> +	cu__add_tag(cu, tag, &id);
> +	cu__hash(cu, tag);
> +	struct dwarf_tag *dtag = tag__dwarf(tag);
> +	dtag->small_id = id;
> +
> +	conf->nr_true_signature_funcs++;
> +	if (!conf->dotted_true_signature && !!strchr(name, '.'))
> +		conf->dotted_true_signature = true;
> +
> +	return 0;
> +}
> +
>  static int die__process_unit(Dwarf_Die *die, struct cu *cu, struct conf_load *conf)
>  {
>  	do {
> +		// special process DW_TAG_inlined_subroutine
> +		if (conf->true_signature && dwarf_tag(die) == DW_TAG_inlined_subroutine) {
> +			const char *name;
> +			int ret;
> +
> +			name = attr_string(die, DW_AT_name, conf);
> +			ret = die__process_inline_subroutine(die, cu, conf, name);
> +			if (ret)
> +				return ret;
> +
> +			continue;
> +		}
> +
>  		struct tag *tag = die__process_tag(die, cu, 1, conf);
>  		if (tag == NULL)
>  			return -ENOMEM;
> diff --git a/dwarves.h b/dwarves.h
> index 21d4166..dfd43e1 100644
> --- a/dwarves.h
> +++ b/dwarves.h
> @@ -79,6 +79,7 @@ struct conf_load {
>  	void			*cookie;
>  	char			*format_path;
>  	int			nr_jobs;
> +	int			nr_true_signature_funcs;
>  	bool			extra_dbg_info;
>  	bool			use_obstack;
>  	bool			fixup_silly_bitfields;
> @@ -101,6 +102,8 @@ struct conf_load {
>  	bool			btf_decl_tag_kfuncs;
>  	bool			btf_gen_distilled_base;
>  	bool			btf_attributes;
> +	bool			true_signature;
> +	bool			dotted_true_signature;
>  	uint8_t			hashtable_bits;
>  	uint8_t			max_hashtable_bits;
>  	uint16_t		kabi_prefix_len;
> @@ -1023,6 +1026,7 @@ struct ftype {
>  	uint8_t		 processed:1;
>  	uint8_t		 inconsistent_proto:1;
>  	uint8_t		 uncertain_parm_loc:1;
> +	uint8_t		 true_signature:1;
>  	struct list_head template_type_params;
>  	struct list_head template_value_params;
>  	struct template_parameter_pack *template_parameter_pack;
> diff --git a/pahole.c b/pahole.c
> index ef01e58..b81d03a 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -1153,6 +1153,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
>  #define ARG_padding		   348
>  #define ARGP_with_embedded_flexible_array 349
>  #define ARGP_btf_attributes	   350
> +#define ARGP_true_signature	   351
>  
>  /* --btf_features=feature1[,feature2,..] allows us to specify
>   * a list of requested BTF features or "default" to enable all default
> @@ -1234,6 +1235,7 @@ struct btf_feature {
>  	BTF_NON_DEFAULT_FEATURE(global_var, encode_btf_global_vars, false),
>  	BTF_NON_DEFAULT_FEATURE_CHECK(attributes, btf_attributes, false,
>  				      attributes_check),
> +	BTF_NON_DEFAULT_FEATURE(true_signature, true_signature, false),
>  };
>  
>  #define BTF_MAX_FEATURE_STR	1024
> @@ -1817,6 +1819,11 @@ static const struct argp_option pahole__options[] = {
>  		.key  = ARGP_btf_attributes,
>  		.doc  = "Allow generation of attributes in BTF. Attributes are the type tags and decl tags with the kind_flag set to 1.",
>  	},
> +	{
> +		.name = "true_signature",
> +		.key  = ARGP_true_signature,
> +		.doc  = "Replace existing functions and add new functions with true signatures.",
> +	},
>  	{
>  		.name = NULL,
>  	}
> @@ -2013,6 +2020,8 @@ static error_t pahole__options_parser(int key, char *arg,
>  		parse_btf_features(arg, true);		break;
>  	case ARGP_btf_attributes:
>  		conf_load.btf_attributes = true;	break;
> +	case ARGP_true_signature:
> +		conf_load.true_signature = true;	break;
>  	default:
>  		return ARGP_ERR_UNKNOWN;
>  	}


