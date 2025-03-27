Return-Path: <bpf+bounces-54800-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D74A72B5F
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 09:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFA7118989D7
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 08:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2B92054E1;
	Thu, 27 Mar 2025 08:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oNOth5O8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WFZd+x9V"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8229204F81;
	Thu, 27 Mar 2025 08:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743063804; cv=fail; b=RAaWDYnh6df8jCImk7giSi4aVK3wg0gUc8RuJc0jme/BXXXYTmfGShcObuhPf5+ihG/bDSpPe2upsH9m6fGjEozpxFkKbVrkeCklG5jAOuo/koBrxr3pKQOp78IemwBFAbYVb2spF/gtP7369yx4jWAB/4+tgwSxQLX0W4tjLGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743063804; c=relaxed/simple;
	bh=ezUPvgdEixRCotBZyuQHijv9GbCH8Nu9sHcz0LQIcNY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d2WZR0Enejdu0HrM0PfTes01CnWi14X9SW/NdyAubnac+isZUl2z7h6380FQz57J0uaJOxYO58/J7BiWftSzwOPJadocX1L0PujHwHokeR4glsTTROJYqLXHdI6pYp1f0vlZfzL41mK3bVVMe3FSSU9IWstLUEWM8jd3wJzx2LM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oNOth5O8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WFZd+x9V; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52R8N4np032562;
	Thu, 27 Mar 2025 08:23:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=hsGWwWyHVS9gQMnJJCkrU4jWYEBXBFucYhY0+qE9UeQ=; b=
	oNOth5O85lcFSCJL21QqKxw38NwsZXKR124VOLshKAKU4qVMA05ZNfKRrVH35q+0
	QHJYbLV8wrfF0CHg2cDQQVTTYJsAe0yKFzat21KsU/jWP95RSaZ/1pqAv+LlFobn
	LQd/rzNPV2feYfiE6c8ZmDQhR3zzg5sG8kf0ItN2lhsyHxvYp6Nzp+3xNjIbaNm4
	G60IUVIXI+1IDRYZ+IIvYPOHVPFDmLqa0WnKROVTQj+TGMrsLGPnAjgbQwpUQoeu
	qg5PLmyM4Wcvk6gwJUlEeVZ0sudC7pHKHH4WAXwAvOyKtC3924LSCntuTXA4bFou
	gI/IGMukFjIjN3swxSoEYw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hnrskxyk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Mar 2025 08:23:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52R7c7IU036488;
	Thu, 27 Mar 2025 08:23:03 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2049.outbound.protection.outlook.com [104.47.70.49])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45jj5eywqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Mar 2025 08:23:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mwnTfuf8LzMxrzzfbiJ5SZHUnwOJoT2MAHr9wW6Z6WosXIIWw0bqitgQ+l3QsQSSN0Ba8MESJTqFSHD+STRy70R9EOXuLNxR2jsZjQk+09+zYrUu5DiiMHNJXI8ohYVlmjU0rsQabILKZ1mQ0LGDaqkeCCfhTI/kT6pE196u6ZVfF9RfA7m4A2Vbh5gFFgGP8nxUSjD9I2qLot7E4UgMsc7POxb0LlfuZvsR1nHXE72mLX3pAEK4aSoKo9U08krRCNxA4OJ2ZrcRU2Ydj8tNeEtXNIR5Z8vstS3AvdX7y8BQ/C8jzWwcv/FTB2B1S1ilyU9dr05p8VPG6QOrL59Rew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hsGWwWyHVS9gQMnJJCkrU4jWYEBXBFucYhY0+qE9UeQ=;
 b=sbFYaYvJTPQm9a/JZ0dRD0iPgdh6MLDyOuBg2kpZqsxUiDfNP1zeXivbJCCYXCWgKvqa5mLlZ/UY1u6VKqWef3vkkfMR4c/eibs/lYS4a1O7rBdldDIfVkD0FDDv60zQb8k8f3iOpUgbUBfay4hAg9svG+iYAJ619JFZsBXAArXY9h3syhwDe5KVwlIPwNuJcR9px9Kq35kBSkIg1U7DiCxDXzACHOcSVy1nLdKwDDTXtI6D00ZUsEeAxe8afydl/ChD9oE69ZVfFAe0SHi4li9Px90KcJdfqdVmPMApvjhPumICV5DGrJU3rA2FgJeVySlg0e+hhkEBOsMItoB/xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hsGWwWyHVS9gQMnJJCkrU4jWYEBXBFucYhY0+qE9UeQ=;
 b=WFZd+x9VJf8nlLz53Rx9ssTt+8+yM/03nShLKTcFy3bZKh3NBQqVaCUl+oktdA5VURuLjThQM+1FWZUSYOzR+VbrIo0VYMhRxBxBqZY4kEwO/RbyxJ/MixzMvmhsOij7SAuNKgdejCxEw5rXGWsjMdkpr5L6b5SvRJlhinUM9QA=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by LV8PR10MB7727.namprd10.prod.outlook.com (2603:10b6:408:1ed::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 08:23:00 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%5]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 08:23:00 +0000
Message-ID: <97ab5e09-6240-4fd9-9411-19b689a21e37@oracle.com>
Date: Thu, 27 Mar 2025 08:22:56 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v4 0/6] btf_encoder: emit type tags for bpf_arena
 pointers
To: Ihor Solodrai <ihor.solodrai@linux.dev>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org
Cc: acme@kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
        mykolal@fb.com, kernel-team@meta.com
References: <20250228194654.1022535-1-ihor.solodrai@linux.dev>
 <9c3d6c77c79bfa2175a727886ce235152054f605@linux.dev>
 <27f725da-eeda-4921-b0f1-c84b95337e17@oracle.com>
 <b1a23727-098e-473b-8282-8fb0cbf97603@oracle.com>
 <68a594e38c00ff3dd30d0a13fb1e1de71f19954c@linux.dev>
 <458b2ae24972021b99e99c2bad19b524672b0ac0@linux.dev>
 <e9c86b63-7715-4232-869e-8835eead9a8e@oracle.com>
 <70bf9434663f748563e5e464ac76bab669d0acf9@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <70bf9434663f748563e5e464ac76bab669d0acf9@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0302CA0023.eurprd03.prod.outlook.com
 (2603:10a6:205:2::36) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|LV8PR10MB7727:EE_
X-MS-Office365-Filtering-Correlation-Id: abc61ae7-2714-4848-55d9-08dd6d089659
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cENUbWsyUHVlSkk2VnRYeXFqaW9BYUdUMTIzL0pPZDUwWnBndUVla2NMV25T?=
 =?utf-8?B?cWRLUmNTUTNkUjFWSzhnbXBqMXlNTlN1VHZLZ0ZFeVhaZVU3bnpSRlFEQXRp?=
 =?utf-8?B?Y1BVc0RlSlpWN3JXaFQ2U1VjOVJYdnorMDV5U2xrRlZYV0lGZ3Y4TU9LaXlW?=
 =?utf-8?B?TUlUTEV4ODZIWE1hMVhvZVFRcHV1MjNNV0hESk9hQnlZeDFBdkVsajNkckpi?=
 =?utf-8?B?VW56NGZXQUNVVXZDTHREOXZYRnFlUHZEeVYwUk01bFdYaVkwRTBuSGRadXVY?=
 =?utf-8?B?TEJBekUxdHAwUlh6VXJSOWdiWFBOalBzTHVZOWkvNUloQ0FTYkhJYWd3eGhO?=
 =?utf-8?B?Y0JreEVWSWdZUUlCbHlWb2RhbEZZUERmNGlFS3BOazNHdGJVMlFXRlYrOEJW?=
 =?utf-8?B?R3ByMVhWQmxwVmVZWmhCYkxtdWd2ZUZ0QVY3QkZJbitWTWpBSmdSekZJc2Uy?=
 =?utf-8?B?ejhQZWpuYko1ODJFc2dKTDhXNjZremR4dFRBN3lQUEY5T0l0cFhEU3YrbjVy?=
 =?utf-8?B?NmJhNzlHbHovR0d2RjRmL053VnVBUlZUdE1ZVEpkUkh4THhCWGFveFFVMlpO?=
 =?utf-8?B?dnovdXIzZXhDQ0c5cGJNbXMzWm1vZWkzYVdNRmhpM1RnWTJ6U21RUkhJVDRr?=
 =?utf-8?B?eCtSVG82MlJ3cEdDeStubTZ1MjZPTzlJbWlLQXgzNlFDWlRaczRNQ2ZsbGtS?=
 =?utf-8?B?V3J2a3VxeGtxam5tb3E1YU1GRnB0WWNSaDhlajFYSzZBeWJvNW1wVzR5eFh2?=
 =?utf-8?B?N1Q5bEV2NWVMbVFWQldJS0piMkg3TTRoejl2elJhZUNJZVVGeDZidnVFMlkx?=
 =?utf-8?B?dWdma0tTd0dEazVmTlp1dWlHRm5HeTMyQ3plenJIQzkvSTZaell6dUxlT3Qx?=
 =?utf-8?B?dldKZUJkcytvKy9GMSt4QVhVZE5lcHIyTTFabFAwYTBFWXo1cHkwbFdYOHhO?=
 =?utf-8?B?bVFyYjBOTlJBSXEyNEowNmg2MTd6T0RFQlV4WjRvbm05ZkJxQlZYaXdsd2Jw?=
 =?utf-8?B?c09mSlZZM2s2SGUzMVFxTmZoWlp1akhncHhJNWtuWU5kRHY3RzFXV1Z5WEl4?=
 =?utf-8?B?aitoeU9DRGRjSEFrWmpkNUtSaEtiSStRTEUwQXlSRDk4ZkRtUWtQRW0zV1l4?=
 =?utf-8?B?cENLOUFLbXgxSXcwckxPV1JmWittbWFicnBwMXREb08xbmpjWEpVdWVmeWpT?=
 =?utf-8?B?R1luNkQ3SGR1ZHF2QlRzZ2FQejJZNThUeEtzcnhvbDVvUHh1bS8yejhRSmRx?=
 =?utf-8?B?V2MxdStQREFNQ0VReGZOb0FMSHQyYzk4WEZkd1JmSzlIUFp0N3BaSXBYY1Fx?=
 =?utf-8?B?ellqbkYrSE9tNmRSZGJHRlpqVHV4b3BzVURGSzRmRzV0QVkyMGVvcVBjM3Y0?=
 =?utf-8?B?MVkvdnJEa0Y3QWlGMTgyMTFGQ0pQUlh2Z1Y0elhDYVJjd2ZOTmxTc1RPL29C?=
 =?utf-8?B?RUxCTFZudnRncFo1dllBbmpaQ2VhVTVUbjFHd2Q1WjNpWW5ZdHNmV1NmODV5?=
 =?utf-8?B?ZUVSaVEvM0FPV2ZlSURUV0hrdGNPV3NYMXNrODUraHdMbHA5RjNoNk5CTXVJ?=
 =?utf-8?B?em8wdzlmSFV0SDlhQy8ra29wUDZHK2I1WGpzdFdtNlhMVzkwaFd4aVdHTnA3?=
 =?utf-8?B?MFNUSExudXlVUFZqS0ZFWUlNclZjQkZOS09YQmptZ2duSFFKaHVRbWtCUDhX?=
 =?utf-8?B?cXN5WWtWY0l3bmZINStFMTh5MXlyeXY4cXdwWGdocTVlcXFOeWhPL1c1bnN3?=
 =?utf-8?B?R0p4TFNBcTl5YUdvQnRLUnVNdDIxTzNtcDRDMXp5dzhEOHZMUlR1N1N3bVVm?=
 =?utf-8?B?ZHQ4VG81WGpJN01IU2VvUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VWVMQ0ZhZ0dOUUgwaHZOK0dnSFYxSUFmSnlBbUphVUJwSFZUOWhQbVlwTUtZ?=
 =?utf-8?B?M2c0anBHTmdNZkE0VzNVMGdiRUx2SS9zUU10dytHVnUyd0x5TDdLUXRkcS9D?=
 =?utf-8?B?d0tGSDZNM1FhNTNGeWJlYjNEYjRyT3UveGhmWVpaU2FKU21sTytxZi9VYkhn?=
 =?utf-8?B?Z3pyMEtXYmFMUkZzSnN2MDZSMHNwT1kxL2xyY05BM1hxczdOMURmQmU2YjQr?=
 =?utf-8?B?QTJVWkpEMS96T0RjM1VZRXNPclpSZ0dKZXhzUVFlUFJacDA2MndTVVdpSjA5?=
 =?utf-8?B?V1ZFb0hUa2JlSGtlK0lEZUNuR1o3Z1lMUDBKN2JocTBkNW80SllHamlpSW1H?=
 =?utf-8?B?QlN2djJLS3cyNFJ6VUxMYktaMHBiZThpL2hDUEUzNXI5QkJINTMvTW9laXlm?=
 =?utf-8?B?aGNHTlJQcFgyTlB2YzhGV0VxQlRJM0xXTEQ0VjZZUEVuQjh1cTJxellHVEVm?=
 =?utf-8?B?UHNXZ0NCdjA1WElhRVVQOWxRUzEwVEFQcVloWDE0eDY1ZGtuSVM2K1BtUVVl?=
 =?utf-8?B?cVNaM3N2VVlGN3c3YVFkclY1K3VhUU5lc2hUdFNCZWlWekVKWUJyeDFRN1Uz?=
 =?utf-8?B?YnN1QXFMRStRNSs4QS84NlNrYytmS0V4cmNoVHRiQVZuWVRLYmcxdSsxbTJr?=
 =?utf-8?B?TWo0UjREekNWMmNCZ2lCdTVhV1AyMWxhZG1nTGZMM3hpQjBzelhxUVhoL0xt?=
 =?utf-8?B?RVl6a3czMUhEeWNjTUlKaVB0aTZGYmhzcm1hMHVjc3l5Y2JUbkVjcGhQVFVP?=
 =?utf-8?B?cXNLeUZpVTRLQU9RWGR3SGgwY3JlVHhGMERYL1M4TEFNU1JVbktaZGhPUU8r?=
 =?utf-8?B?dkVuSkJMZ0dGSldPQTFtSDV3UzJSM2tVRjFlRFhOVE5SMEhKUEdjNDFPK3VU?=
 =?utf-8?B?SnBTMHRwdzI0RjBaUmJ3MHRFbEl1WDFZMm92L1ptNnU1eFNZWUsydTRsZWVU?=
 =?utf-8?B?bENScVJHVG1IRDRDMWxoNUh4UW85c015OTQyaEYzc2NyWnMrUStkcnhpYmN4?=
 =?utf-8?B?V0Z2b2ZlWTAzYTQyMXY0QVk4b1lQZ1ZzNHVoVVhIYVEzOEFnanBQM3ljUHNY?=
 =?utf-8?B?Q3pGWWxMT1Bwa1hoV0M5Wkl6RHVLV0tpaTIxRnFFZkt5dloxTElJYThpWHFT?=
 =?utf-8?B?QXMrRWpOREVyMTFKNWdHWEZBeVhTaFQzTjBLclpPUmo4cGcwanZYdWhROGRk?=
 =?utf-8?B?MEVhT3JRSFRqbFpqR1YxZFhnNFdqUmZVWVM0empIYVpmaDlvZ0UvQ2ZpdXRj?=
 =?utf-8?B?empEZmVBVXloSUZFTEFuRGN6dDZQM2RaVHJFbENvSFlYOFZFa0xDWmNkaGFv?=
 =?utf-8?B?em5va1krRldnZmpPRzlpbXF0UXVOSzV4ajUya0gyUTJqTGxZd1dZQlRjclJu?=
 =?utf-8?B?ZkJPWDhQRXZNaTNNTHpSK3ZrVnc3WStaUkVSWVo3bE9PY3QyaGd2b3N5UlQ0?=
 =?utf-8?B?TDBjNDFScU43czQzd2JTQWR2SHMzZldhb2VCWUU3MTBsL0VBK2g3Mnp5dGU0?=
 =?utf-8?B?Rkx5ajhXUC9yRmJyUWRZZ3Z4MU9rUWFoUk9oNDI3cTU5ckhuN0haa3o2UEV5?=
 =?utf-8?B?a2tVTzdYZHpUWGJ4azduSnFuYnlPaVNLaERkRHRFYlgrc2lYbFZXTGMwbjJl?=
 =?utf-8?B?bk45a0xTQjhNMWQvN0hJY0JMaUZ0ZGVxK0laNnNrMnpNMlBnZUorbUJ0dHpE?=
 =?utf-8?B?ajdEeXlSTzhBU2w4OVUweEJybUZidDdmdTVlOEJydU52amlYcklOeHJFR1lk?=
 =?utf-8?B?bXplWFFjKytqY0c1UjRIMmlONklCK2NUMFRLMDM0U0I3L2pRL3V2VWZZUFFG?=
 =?utf-8?B?NXZybnhnSG11MUVLZ0RCdFgxcWs2b25Vc2JqbjhmU2lsOWZiWUZMbER6WDRI?=
 =?utf-8?B?ZWJBUXduVG1LcExkSHhMeHpUdjBlaDh4aFJzNitUd3ZQbzFmQ0J4T0NISTJw?=
 =?utf-8?B?WUhHcmRCNE9zQldKdkNSbGY3SWJKdG5ZSmk0N3Q4R05VL3ZRVWMxSHFFaGRO?=
 =?utf-8?B?MitHZzJhTGhHaGdYczU2YWhFSENaWHRORFVFcVVyQUhmR0RCeEI5Y0VxcTJl?=
 =?utf-8?B?NjhETkVnS0NlNEpOR3Yxd2Q2a09NUCsyQ3JSeTVRZ2xnS2RpeFA1eGw1dnZN?=
 =?utf-8?B?YzlZdDdlSk9mNVN4ekZ3c1U4YkRUL2prR3dBZWh6blZWeG5yYlQ0czlJYll6?=
 =?utf-8?B?alE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/7DIk98cosOmNAmbAqxtCguupCwf65rsdDQFoY7fzFqdIiaQpzrhnjCVwJ6k+WrI/J9EjKd6KNELUTct+5oWcNv6L5sJB50SS3FhaH+DcGIi0C6mmvZFJfKkHMmP8g6y+O7BnVQGFo4q4ERHt0nQUD/r8jPFUmzdfgRtfyDGMzMFgFPD5g1T5pFOeAndmLzPfsg7TVRVN40AE8jUSTwaGxQ2rTSNs6f03dq0tOZy6Q5MWybVSmUxCdJksFqUjvUYA2x/enzBXg97vmspDyvjnMx8oosS9dsGymp0z0HyA/niYpBXaYZ10ID8OW8wsxkzd5mw+lu9y1lnns4LjaaBmwIyUWylWyqdEiD8RCvzdTZmNPc40BAzPX/U3vmHKqUk+1UdFZAux/wetPQsOtLP9/b0pFMlLm4p0AGMYY43eYeBtShGOlSvCRIpB/WkcHCucKuRUozju/k/nhS3k0ArD9vrJPC5xA3yY+YqwIHWT9z6W4L66Et0Vwemi6xsaTvF8enpQExOk1t/r+2TvkPAdzsmzJ27U4IbDq0sc4AYDpboq3m72VTTbi6KtGVL/hQefLRujzpcZxYY4WWzFohyGKoW4OM5aqRiB7tZPvpHlMw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abc61ae7-2714-4848-55d9-08dd6d089659
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 08:23:00.8237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: paybrw810VwXEfaGjLYUHYvCWPU3HRnqDWzE602he2Xs8gEeaqy/qxcP2oyYvbOf/E5J5Sj9Y/CueIug6RSiMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7727
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_09,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503270055
X-Proofpoint-GUID: TooZL3gcUCuMu1JhJAyXWRsRhovQ5Tgq
X-Proofpoint-ORIG-GUID: TooZL3gcUCuMu1JhJAyXWRsRhovQ5Tgq

On 26/03/2025 17:41, Ihor Solodrai wrote:
> On 3/25/25 2:59 AM, Alan Maguire wrote:
>>
>> [...]
>>
>> Great; so let's do this to land the series. Could you either
>>
>> - check I merged your patches correctly in the above branch, and if they
>> look good I'll merge them into next and I'll officially send the feature
>> check patch; or if you'd prefer
>> - send a v5 (perhaps including my feature check patch?)
>>
>> ...whichever approach is easiest for you.
> 
> Hi Alan.
> 
> I reviewed the diff between your branch:
> https://web.git.kernel.org/pub/scm/devel/pahole/pahole.git/log/?h=next.attributes-v4
> 
> and v1.29 + my patchset:
> https://github.com/theihor/dwarves/tree/v4.kf-arena
> 
> Not a lot of difference besides your patch.
> Didn't spot any problems.
> 
> I also ran a couple of tests on your branch:
> * generate BTF with and without --btf_feature=attributes
> * run ./tests/tests on 6.14-rc3 vmlinux (just a build I had at hand)
> 
> I think you can apply patches from next.attributes-v4 as is.
> 
> Thank you.
>

will do; can I add your Acked-by to the feature check patch? Thanks!

Alan

