Return-Path: <bpf+bounces-68241-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CDAB55001
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 15:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DBBD1D6139B
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 13:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D9B2D062F;
	Fri, 12 Sep 2025 13:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hLUFs4b6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JOpV1X5p"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F30F1F16B;
	Fri, 12 Sep 2025 13:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757684944; cv=fail; b=YPmoX+nejiAsvhaQVC+ihSm+4SewuhOYXsBwUVWroVRXa9+1XJLIVDgF7tZ4SoUMq3K7vLxR798VL+2KTKHe+jrprvfJ+8zc34m93b+/glzo97jWso7znRbkFhhOYvJGWtLw9/FsWvZEbYASjRXQ+c9Mdzl8BdF4nZjD2bhrAh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757684944; c=relaxed/simple;
	bh=4Q38Bquho4JxWsZQMU6nf9/RxC1fBqinitxp5xiSvLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nEzRUbyVeX6ToP4+Q6TBX7lG2QJrlIwGZSu5gkuaZ0RwlObi4HE/r6MQdzp+2T/ThiRksfqFk0DRr7BdvwNsczUZzIz+V3+M7nFMyCk0wyZUG9b78eOGsN1vJZzVJA/eIptz+lauYHaK2YN7WLTth0SBxZlzc8iBxMmzdsdVhgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hLUFs4b6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JOpV1X5p; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C1ts1B027271;
	Fri, 12 Sep 2025 13:48:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=25tCSaVfBYU4/3OixvZueTDj0dkw+SxVLcxzxU+UBP4=; b=
	hLUFs4b6AqgqeHZvfrS5yndTl8BN9EuBUKB+euQubzmWkBIm1TCAn4mB/kz+sKtL
	Cn5t0s4ZB1BAcEnPwbRIHYQ2F9MT1Fm/OpIXrWjKa4yqmSbW7olOhQdX9NqEw/+e
	e1qdYk1trJ5Bfoaun5W0iETxNNZO3pxe0guR38VOO+EpxDe9wSXkCchb8zSS+FV9
	toUVTR8nQG8SzSc7/3wghbMcZM/dZah+nGauTwCRE9MpT9rqbfiz7fXO9yq7y/fH
	sPSAFmoxjln/RBBQ6Oj27HS1YNDJpjg1fk9q+KHQQZctaKdv1I1LSKSLd3PbZJKa
	bTS3t7GZmHqrWOwwzmF2Tw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922sj05jm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 13:48:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58CDVBu8030644;
	Fri, 12 Sep 2025 13:48:17 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012007.outbound.protection.outlook.com [40.93.195.7])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bddudhg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 13:48:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x+PvS8euCfXMZeZbzX7xbbLGhIaawePhUVWIfpNGjPXWz/12fF3l9DNlQLX0wnQWJ5gnC03EgVjniPpYZ5GNy0iNBDNUlLrj01q7UQ4YdWJJaiqv03VF3X/7UolKECGv5EVGYUXPjDD6sDkGOKmbiBaMaA30DBK1wW2QOvi9/cnz5G3zja5d4sc5Z7AM61A076TbnHD7/PvTzCdrbQbrBd/7NnWeXWmiWXAm1cLYrmHkfb+slw6zm94+LfzHzCq+ppgc+1/8mhdnuPqigacWXwHwLUqxqZ3y+nDEmDcWER+RF7nGXaA+WHbE+Yp5PLoLSi9TKADJAdPL1/+udQt8zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25tCSaVfBYU4/3OixvZueTDj0dkw+SxVLcxzxU+UBP4=;
 b=eIMgDdizrQ+5TN0V69Yn4J2m39ejPC24x2KhCHr8D6YUUWbfhLkKx/oow3U7X7beFusavGiBH1ejKx+v2r2dzzqhtjXYGckHuT2+AgOXWqVB1zckXiwW/ep/bq8gdUMqSRBFdsa1oOy+oStb9a7QeUqm+n5pIMKO7m/QU12fzBfsZJj8WsGtvQtLViHWTXRaZw+xdxllCwItR1kmuwbH2F1qKiPOltmDvRH6N98N43rKtrShiVWyTX6d7r03T8mvYjvnA/RFNmR/vhMmDSD3Deb6bQpVUR0DPWbGyhramPkVGCKKiO2Con+ZzMbtdRlMvdYVeZlACxbXUA8MN2epOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25tCSaVfBYU4/3OixvZueTDj0dkw+SxVLcxzxU+UBP4=;
 b=JOpV1X5pn1OtIIQHinrevJHmA07Ag9Flcz2N6J5fsMwGSuimyAtDfZTwQ1UacoL+OzEZVjV40pBsmW3rrl3Cmm/dEhsl4j0H64NezhCX2sjFB+Du5ceZ1qsnbR8RjxAFqMI7LGFu+AW/MaXvJtjEn1tk+3OqIh0O71KOlRYZ8/4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA1PR10MB7472.namprd10.prod.outlook.com (2603:10b6:208:454::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 13:48:12 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 13:48:12 +0000
Date: Fri, 12 Sep 2025 14:48:09 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com,
        baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        hannes@cmpxchg.org, usamaarif642@gmail.com,
        gutierrez.asier@huawei-partners.com, willy@infradead.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        ameryhung@gmail.com, rientjes@google.com, corbet@lwn.net,
        21cnbao@gmail.com, shakeel.butt@linux.dev, bpf@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 mm-new 04/10] mm: thp: enable THP allocation
 exclusively through khugepaged
Message-ID: <42226608-bbb1-4d58-9de7-dfbb3a38d064@lucifer.local>
References: <20250910024447.64788-1-laoar.shao@gmail.com>
 <20250910024447.64788-5-laoar.shao@gmail.com>
 <a2c122f5-ab6a-4242-9db8-e5175d5b27b3@lucifer.local>
 <CALOAHbCSudQ9y1UdD4YjuUFGae5bRu8_0bgThJV4WgwLwtcwew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbCSudQ9y1UdD4YjuUFGae5bRu8_0bgThJV4WgwLwtcwew@mail.gmail.com>
X-ClientProxiedBy: LO4P265CA0144.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA1PR10MB7472:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b986b4c-4a8c-4db9-6651-08ddf20303e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WjFQTEM4YzQrNHVsRDB4UmluQitvWUJIWWNPMk9WbW0wSCt0WklZV2pFOFhJ?=
 =?utf-8?B?WTFvRzd3dEY2VmpPdTBpVjhPT3RzU09HOTFJOU8yVWU0VmtZU1pWOXRIUFZn?=
 =?utf-8?B?T20vVHpFbUpENFZ2WndCcVdJb1VwWGNxanVOZ2VQTFk4S0pxWW1URmtEc1Z4?=
 =?utf-8?B?THk3WnIrZ1ZsN0ZSM2RtR2ZqNmN5SWdJdktWaWIzeTZDWVo1L0hkNy9PTFpx?=
 =?utf-8?B?bWVhOVN5blFZN3RKZS9wWFI5ZEJhMGtMYksyU1RaRVBJMEMzeUtTU2Q4eEtE?=
 =?utf-8?B?RWxVWWpIbEI3TkFTVnZwTTRQN1ovOUwxSWFtTU9vWUFqNmVIbUpWRmZjSHdr?=
 =?utf-8?B?b1dqeGJGemNqcGNaTkZlak5WZDg4bklSM1JQRDRzbWY3QmNCeVYweG5TVzhW?=
 =?utf-8?B?S1RBMkdmdmtISi94WXVGamdCUXlRYzc4K3MwOFBNNVFtWWQzSmp0R213cHMz?=
 =?utf-8?B?VGl6YUtpMyt1dnN6RVFjVXp0dGswWHIrbkpQaitNQTFaaTVzaGZjVWx1T3pT?=
 =?utf-8?B?MlRqR21JSTgzOGJudFZOTjdpMFZNclFTVDd0bER5dGdiOTk5a3VOT294SkNO?=
 =?utf-8?B?QW9ydjhjdTl0K2h5R09aZmU0NHZGbUpFMmphbTRFRGQ3anFVa2tJWVJsU2Zv?=
 =?utf-8?B?dHducjFzc3JiR3Njcjltc2FiWkJ4N29GZmpJZEN3STFrY2xHeFIrU2hmOHlP?=
 =?utf-8?B?TjhzQjAyK2xlWTNRcFJBMWtaVWoxNnRkMEZxSWZ0QTIzRWhsbHlnN3FaYnli?=
 =?utf-8?B?SnUvbUtWUkF6VVFRT0loY1FHRXBhR0JmRWRra0VkNTZQQzE2UHEvcnJiYWZm?=
 =?utf-8?B?cG1tQTdyZDFOZlhCU0dDVzduWVg3bmNIcTA4b1crQkhpZlMyeGZoZ3NpTmdm?=
 =?utf-8?B?TjJBbm5Sb01LYzRSRlZvaVFLMDh6NnJhdUxTNFdaOHBtU0tmOTJ3T1VGN0p6?=
 =?utf-8?B?eTlsM1RRdWtkRk1yeVhQcmJDc3VUZWo0YThxQ3EyaitlRnpXbW9nTkk2ZVMz?=
 =?utf-8?B?cWVzNW5kWVBWYk9WSkpIRHBGQ1lYeTBia1V2MUxDZHJHK3IzU2MwRDZwZkFB?=
 =?utf-8?B?LzF4b2xMWTQ5OVBpcmFqU05VQm10UVJsRDhodnBhWGZNR2Z6dmgrQ1BhbTBH?=
 =?utf-8?B?QkJkSkpoUk1uU2d3Mjg4YSt4b3VyZXkyODR6bkZEMi8raUg3bDNxaG9WMndS?=
 =?utf-8?B?UVpHdFdaNFZmalM4V0EvSW8yVXVzUkxzb2VRWGxTY1BzaTFNc1lTdklmUnVo?=
 =?utf-8?B?dSs4T1ZFUUFtSjRlVFBtUFIyZ0orL0diM2QxVCtUK3BpL3cvOS9ZRFRVNks1?=
 =?utf-8?B?b1N0YVFYb3MrdUpmOVNSOXhZcWpKVjliZlRPUUQzRmYwaFpJQmtCMVhMSUNi?=
 =?utf-8?B?U3Z3OHhzK0FGZGRUTW5TRkYyS3RsZFhWTWFFeEN1TDFvMzFMUzZiODUram5R?=
 =?utf-8?B?TDRPWTAyTjdaVGZDcmtDQlpmVHZEZEtNWFVTdkEzbjJGalZlR2FNQlo4YVhj?=
 =?utf-8?B?bUhCMURrU29MZ29xdEFCRHdkYkV5QTV4WnFybkUvTmkvcmZjRHhLRmN5OHdZ?=
 =?utf-8?B?eDByZEo0dUFsTzJEb3M5WHh3dlNzNWN1Ny8wQiszc2UwM21TYXpZUVRlVllU?=
 =?utf-8?B?SjhlakVGZVVqZFRFUTVJMlZxOFZOUktTanlqZGQvMUpXN0dSTXlQV0ZYU2xS?=
 =?utf-8?B?SG44OHQvVWNVRUpleDdlNWh1VE1ORG14Z0JveFNKandHSURlNWh5QWczZ2hW?=
 =?utf-8?B?dngzNXBmVWpXT043REdUbjJDcDlMRGFLS3M0U2xQS0l0ck8zNTJHbDJyZ1lH?=
 =?utf-8?B?YTIwYXFCcTUzdzg5bkUrY1BzU21FUG1JZGhSYTF2NjZmS2ZaNTN2eDFFdG11?=
 =?utf-8?B?ZmVBNHFSODFvNWl3YloweVdSblY2SlpISHBGbndwWDcwdlkxbmxOL083Z3la?=
 =?utf-8?Q?xTIhGdQgNro=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGc5Y0t2TVo4L3ZNNTVEbWhneGJFbnFlTEhscklBR0NTcWkzcmdURHZHOUgz?=
 =?utf-8?B?RzVQbk1Fc0dIT0h2cFIvN0xWQWtTdm8xRHVOSnBHTGVXZkVwU2dXWEhKcW01?=
 =?utf-8?B?ZWhQK3B5TUUra2RHbzZJOUdyRmZVL1h2U1FhUGUxZWJ6RFY2NWVoVkxtdkIx?=
 =?utf-8?B?T2JYcTc4OTU4VVVVOFFMMVNRdXNjTmpMRlRGSGJkUnI3ZW82MUJZYmdDeHll?=
 =?utf-8?B?ejFaY0diS2gyUkE5Q3JtN3poRWM1Qnp2T0djRlU1dzJaL0IwYUN5U1RKYXpG?=
 =?utf-8?B?b1R3OHVtOEpoNGdrNXhtSm42MXAwMUNVTTMwUUJtSjBOK0EzbjNKTjdJdkIz?=
 =?utf-8?B?WnJCcWlxeUZOQlRSUlMxZ3F5b0NXVkRsalg5dGNyWE9BdDljVVdQMm9ZRWRS?=
 =?utf-8?B?N3EzNVBIWDhCSTRwVlhYaFBTOWF1dFR5U0JiRldMa28vdEtOL1FkNlNLYUc5?=
 =?utf-8?B?Rzh1VkxnMlFKRWk2NFRYdlY1OHRmSVovbGQyYlNZZkc5Q3IyRGduUTJUcUJK?=
 =?utf-8?B?V0l6akQzOWZPTW1iUU1wWS9pYkNETFRCdi9EcFJCZlFibzVUaEhSbFg4QlR5?=
 =?utf-8?B?WEhWYW5rQlB4NEFSOFAwalNDZUtIdlNaU3FpTjUrYUpOYktjT1BnRlljNHRX?=
 =?utf-8?B?Y05rQzc3VlhkaXdVWGcvOVlJMmUvOENVMmUrcDZ3dEk4T1BqRHMzS2lDT0ZZ?=
 =?utf-8?B?UlFCbjR2bW5VTkpEZXh6aHdDYXFGc3lGRXdWNWdtanJpLzQvd09zVkhOSnB0?=
 =?utf-8?B?TVZIQTJWSVFPbHYyS29rQy9XUDZoOVZ0aGZkSUwvNk8rL21DRzZhZEcvNlRQ?=
 =?utf-8?B?K2RmdTV2R2paQjhQK1BaaTFuclpjamhJS2NhbXBZc1hpRHNNQTZ5K1BkdDlp?=
 =?utf-8?B?OUcvblZSQytSR2hwQ24yQXVidkZ2MEZ0YUk5dUJHelNuRmtuZjkrNHZkSjEz?=
 =?utf-8?B?UkZpMlBJSW5hYS93cmI0MUZqaU9RNDA3akpwS1JoNHNGSVloeHFEYitzRzRi?=
 =?utf-8?B?Um5OSFlWWU9TK2FwTFRIWXZpandMZnFWZmZxUWNtTkJrY1ZrNVNDQUk4V2kv?=
 =?utf-8?B?QTFoYmxwbFNBb05LY2V3QmRXZUxDVEpDMjNIUE0xTVZUODBUejVvSUQrb09E?=
 =?utf-8?B?UG9qaGFybjh4emZJRStOQ1lKdm1iQWg0dGlNMm1RTzVpcEpjRndqK1lZbzZW?=
 =?utf-8?B?OVhsSzQzQmplSnpZZWdleWdCUzhwSHlkZkU4V2JnMitzOTQyTklSbDhhRktz?=
 =?utf-8?B?Ti9PQU5qd1NraWRHSmZVcFRnWTQ4REY2dzF2SVNyUGJvWUk5dWxLamZjRzhl?=
 =?utf-8?B?SHIxWUZNV1owVG5Yck5ZajdXaStzcTdVZW1RemJabmZXMEpXSFJSN0lXQmlE?=
 =?utf-8?B?MmhUUVVwcTg1dGpDOWp3STNaankwbkY0aklpN0F3SFhmZVo4blJMUkFmZ3FE?=
 =?utf-8?B?cmszOW05VnQ1TFV5R2I1djZUNFY3SW9sOW03eitvQ2FxeDljVTJRdlNTd09Y?=
 =?utf-8?B?RmF3bHRQbVlMWDZKMm55Q09FcXNzK084Vmk1ZjRNa2RNQXlJa2RhMFZsZHRl?=
 =?utf-8?B?eFFwVFQ0eEdKWS9ubkRiZWkwWldCV3NsbWpySUM5UTVoN1FxMUZLRi9JZm5x?=
 =?utf-8?B?L2ZoUFhUQmhIV3hxZGR4aThpWmhOMmhkU1RtZEthRWptbWxVeWZOVGk2ejZi?=
 =?utf-8?B?eWxYRkRVY3BPbklwZVJBNGlwNkVLSjRDS2tBNXRCR1BXRk5lQlZ5Y25BQlRq?=
 =?utf-8?B?MEg5OFVpazljdXhGTkduVmtZM1NVZU5SVUtXZ1dWeVJMeVdSUWplZFAzU1Ir?=
 =?utf-8?B?a1pGdVB0YTUwSDhyVmRiV05qcUlhb0IyQmtQTk81eGJVcEdaTVVuM1VkZHZz?=
 =?utf-8?B?YTBmanFBTUlrKzB0Tml3YU9wcUovdENsTGlBN09sa3lmNlNvdXhCLzhnaVdV?=
 =?utf-8?B?UFczaE8yMitESWhjNEM1NGVYc0Npb0Y3VjJxWEVYd2UvSzFmZkJqMFdZTmF0?=
 =?utf-8?B?SkJJRGhxcW9YUnRhYnljRjJzbGd6ZGdzVUZ3aU1WeXlSRkVKM0x1SjV4S3pD?=
 =?utf-8?B?OVlHZDZONmdCdkxINnA3MmExOTkyYTVFa1hXS08yQkZ2QVc0ejBOcVUzcEFD?=
 =?utf-8?B?Tk5POXMreXJ5VDRkeHQxMUU4WkgvbHQwMWxQVWNGUmJMK25uK3I0emIwNndk?=
 =?utf-8?B?R0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4ekdlcGO7cTsuCRjbu3Y29/gk/o14CEnh4pegslKB9iQZxZlPthjUmr61KXqdT/XhmyZgEU8Uh0nkG6m4OcC0iVjdCVM9cwsTZlOKDhy+09lnKNe290PgyFvHJHDmFtmaq9uqRELIeTaH9TJc8lXPYZHgI5BNmmApIWjx1FzjcXnUW4678hJDhGHe6QnoLGr5/zVQ1cYQQ+ZG8Ok5GCQ0JNzlYhd6WNvVKQQ4zJlc6OZAiPqqHsbkbbE9T8qevPpDIzi7FC0ZtGtHaCaVia3t52plbTEbDysNvV2B86ikpFtsKgTOlIJeM1IDDfIxXd09s2fUu8ynJSIwP7mC4XjFmX833FjyszLpreRShcPuV7XD7oQzdxUfoKIvTjgkGKqcZOU9+PV2kvT1JddVT0t8Gbu5lUF+Mdt32TbUWET0TZVLglbJeOpkYDL0cCaE8eDkfDRUDpmlhZ+8qrqD9GZArDoW+SowxCdY3x3Y6BfZUbSxoB2AE5QSMG+CsqZfXoZOrBLMkC25VoVc1e0sDc7VSSlJDWn9uV2V0nutofN8lrrqsBef4+2QMw0J8DORWeZ/vbSaDpDcVJMURsBn+goy5v9/bBid+04yUTleZDP46w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b986b4c-4a8c-4db9-6651-08ddf20303e4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 13:48:12.1390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4pVtI37xaNwxK3BXxtKT6X2oEFw0rnNHaxs7g5wSNTGwNr46TgJVAxM4V9i3WBWw8KqbGFOxi1mQetaHKesuVLvM0tOe6fv9JTzc0pdmCQQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7472
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_05,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509120129
X-Authority-Analysis: v=2.4 cv=esTfzppX c=1 sm=1 tr=0 ts=68c424a2 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=Dkfo5gNjDrQQqrOv2mgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE2NSBTYWx0ZWRfX4DiPbOpDNf9V
 PT4uAiArsq7fM8uQbAPamF+q+u9mh1Bv9MZ+/LEKPt94BOA7ioqGjFSHUBHRzG+aqyBcQovpO+G
 ZQaEYZv2SUm9DX/abEKexXzeTaRZSPv58P/XsHX1zUWXqANKUiybBPQ+0bUHnYBSJK40g21+YY+
 85sGyXCEfpEQP3adozn+KT23tXy91AK7FznjThuAXh5PMlUPglYB14e6NI4pHEBg+U9nUgOFtAa
 eSlEncsjZXZOHEq7YJiQnFIe0pEkvj/inXkC+c9R137/8TrcP4qc/UeCUBXgA27CrXh7OZXgckk
 a0JFBgLHQs/d0iHhvswOyCkvXZ8u3K0lQ5e7v562Qp7hbVNTUH+zI3FwCKZgjX24er2qzEuTe4a
 m8q5LkMs
X-Proofpoint-GUID: 7-6XhxlKnDrcW1KcAiow83eTq6XWSO6y
X-Proofpoint-ORIG-GUID: 7-6XhxlKnDrcW1KcAiow83eTq6XWSO6y

On Fri, Sep 12, 2025 at 02:17:01PM +0800, Yafang Shao wrote:
> On Thu, Sep 11, 2025 at 11:58 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Wed, Sep 10, 2025 at 10:44:41AM +0800, Yafang Shao wrote:
> > > Currently, THP allocation cannot be restricted to khugepaged alone while
> > > being disabled in the page fault path. This limitation exists because
> > > disabling THP allocation during page faults also prevents the execution of
> > > khugepaged_enter_vma() in that path.
> >
> > This is quite confusing, I see what you mean - you want to be able to disable
> > page fault THP but not khugepaged THP _at the point of possibly faulting in a
> > THP aligned VMA_.
> >
> > It seems this patch makes khugepaged_enter_vma() unconditional for an anonymous
> > VMA, rather than depending on the return value specified by
> > thp_vma_allowable_order().
>
> The functions thp_vma_allowable_order(TVA_PAGEFAULT) and
> thp_vma_allowable_order(TVA_KHUGEPAGED) are functionally equivalent
> within the page fault handler; they always yield the same result.
> Consequently, their execution order is irrelevant.

It seems hard to definitely demonstrate that by checking !in_pf vs not in this
situation :) but it seems broadly true afaict.

So they differ only in that one starts khugepaged, the other tries to
establish a THP on fault via create_huge_pmd().

>
> The change reorders these two calls and, in doing so, also moves the
> call to vmf_anon_prepare(vmf). This alters the control flow:
> - before this change:  The logic checked the return value of
> vmf_anon_prepare() between the two thp_vma_allowable_order() calls.
>
>     thp_vma_allowable_order(TVA_PAGEFAULT);
>     ret = vmf_anon_prepare(vmf);
>     if (ret)
>         return ret;
>     thp_vma_allowable_order(TVA_KHUGEPAGED);

I mean it's also _only if_ the TVA_PAGEFAULT invocation succeeds that the
TVA_KHUGEPAGED one happens.

>
>  - after this change: The logic now executes both
> thp_vma_allowable_order() calls first and does not check the return
> value of vmf_anon_prepare().
>
>     thp_vma_allowable_order(TVA_KHUGEPAGED);
>     thp_vma_allowable_order(TVA_PAGEFAULT);
>     ret = vmf_anon_prepare(vmf); // Return value 'ret' is ignored.

Hm this is confusing, your code does:

+       if (pmd_none(*vmf.pmd)) {
+               if (vma_is_anonymous(vma))
+                       khugepaged_enter_vma(vma, vm_flags);
+               if (thp_vma_allowable_order(vma, vm_flags, TVA_PAGEFAULT, PMD_ORDER)) {
+                       ret = create_huge_pmd(&vmf);
+                       if (!(ret & VM_FAULT_FALLBACK))
+                               return ret;
+               }

So the ret is absolutely not ignored, but whether it succeeds or not, we still
invoke khugepaged_enter_vma().

Previously we would not have one this had vmf_anon_prepare() failed in
do_huge_pmd_anonymous_page().

Which I guess is what you mean?

>
> This change is safe because the return value of vmf_anon_prepare() can
> be safely ignored. This function checks for transient system-level
> conditions (e.g., memory pressure, THP availability) that might
> prevent an immediate THP allocation. It does not guarantee that a
> subsequent allocation will succeed.
>
> This behavior is consistent with the policy in hugepage_madvise(),
> where a VMA is queued for khugepaged before a definitive allocation
> check. If the system is under pressure, khugepaged will simply retry
> the allocation at a more opportune time.

OK. I do note though that the khugepaged being kicked off is at mm_struct level.

So us trying to invoke khugepaged on the mm again is about.. something having
changed that would previously have prevented us but now doesn't?

That is, a product of thp_vma_allowable_order() right?

So probably a sysfs change or similar?

But I guess it makes sense to hook in BPF whenever this is the case because this
_could_ be the point at which khugepaged enters the mm, and we want to select
the allowable order at this time.

So on basis of the two checks being effectively equivalent (on assumption this
is always the case) then the change is fairly reasonable.

Though I would put this information, that the checks are equivalent, in the
commit message so it's really clear.

>
> >
> > So I think a clearer explanation is:
> >
> >         khugepaged_enter_vma() ultimately invokes any attached BPF function with
> >         the TVA_KHUGEPAGED flag set when determining whether or not to enable
> >         khugepaged THP for a freshly faulted in VMA.
> >
> >         Currently, on fault, we invoke this in do_huge_pmd_anonymous_page(), as
> >         invoked by create_huge_pmd() and only when we have already checked to
> >         see if an allowable TVA_PAGEFAULT order is specified.
> >
> >         Since we might want to disallow THP on fault-in but allow it via
> >         khugepaged, we move things around so we always attempt to enter
> >         khugepaged upon fault.
>
> Thanks for the clarification.

Thanks

>
> >
> > Having said all this, I'm very confused.
> >
> > Why are we doing this?
> >
> > We only enable khugepaged _early_ when we know we're faulting in a huge PMD
> > here.
> >
> > I guess we do this because, if we are allowed to do the pagefault, maybe
> > something changed that might have previously disallowed khugepaged to run for
> > the mm.
> >
> > But now we're just checking unconditionally for... no reason?
>
> I have blamed the change history of do_huge_pmd_anonymous_page() but
> was unable to find any rationale for placing khugepaged_enter_vma()
> after the vmf_anon_prepare() check. I therefore believe this ordering
> is likely unintentional.

Right, yeah.

>
> >
> > if BPF disables page fault but not khugepaged, then surely the mm would already
> > be under be khugepaged if it could be?
>
> The behavior you describe applies to the madvise mode, not the always
> mode. To reiterate: the hugepage_madvise() function unconditionally
> adds the memory mm to the khugepaged queue, whereas the page fault
> handler employs conditional logic.

Right, so we suggest the order

>
> >
> > It's sort of immaterial if we get a pmd_none() that is not-faultable for
> > whatever reason but BPF might say is khugepaged'able, because it'd have already
> > set this.
> >
> > This is because if we just map a new VMA, we already let khugepaged have it via
> > khugepaged_enter_vma() in __mmap_new_vma() and in the merge paths.
> >
> > I mean maybe I'm missing something here :)
> >
> > >
> > > With the introduction of BPF, we can now implement THP policies based on
> > > different TVA types. This patch adjusts the logic to support this new
> > > capability.
> > >
> > > While we could also extend prtcl() to utilize this new policy, such a
> >
> > Typo: prtcl -> prctl
>
> thanks

Cheers

>
> >
> > > change would require a uAPI modification.
> >
> > Hm, in what respect? PR_SET_THP_DISABLE?
>
> Right, when can extend PR_SET_THP_DISABLE() to support this logic as well.

Yeah let's not touch that please :)

>
> --
> Regards
> Yafang

Cheers, Lorenzo

