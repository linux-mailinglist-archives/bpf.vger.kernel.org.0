Return-Path: <bpf+bounces-38382-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A50D964101
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 12:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C54512847AF
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 10:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1121591E8;
	Thu, 29 Aug 2024 10:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KWt8hHCi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pqMMngfk"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F4118C90F;
	Thu, 29 Aug 2024 10:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724926403; cv=fail; b=OV9XNuuZ/kKV4p4ImP2ISFNevo1PByGfAfL+67/B4oPIMFDC+A2zVJT90KUyBb9S+WJfal+ryFlpkPge0vULYe7Minar59jAWGloCViw0Q+2CIXKAzGjTO+cXLKSYl2ripAP/H33GFskHtQMchOVmNJlE3HFpWFOuVSVq0W3xds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724926403; c=relaxed/simple;
	bh=8fEjBNMcYSLXGyf2TR1FxE1uYXs6tBoDNjKF/Hethlw=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=act8hxR+JdmUEj+tN2AemJsTh5Su7zcpZQTx0gCoyjb4r2qX92gi56iCFZgxErpRophJSWU10g0Wwv1Sh5wcudiYdwqRljpQk0QDIktTFUXoSf1Q1c85030V6pwpL3UuZZrC9blO6AOYjGL0umQ3b5Y3gdw1Co5qUntXYmmyHYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KWt8hHCi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pqMMngfk; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47T9ZqO0026247;
	Thu, 29 Aug 2024 10:13:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:from:subject:to:cc:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=i9O6NWyaQqBofwEuy8DLgR5cvjSLtIgEermnatbGdIc=; b=
	KWt8hHCiXst28a03gROqmFViGE6EJu5qS3vNoZN+hqz0RSaPDzSdr4tRZM1NoIjY
	ubdqqEJm5O/FnTgPMmFSHPXpvX3K6VPKD3LYSW2bmRbzQYhEBrWxoZ5dLGXDZS+z
	qB8IIbleugdGZ31zgFI0CXAojJzhkdTUVDq7Ulqxz0xbpL+o/GG0Avt/ppAPER/U
	GcM8SHiRiw/ocf3U2S1QNCKTo1By329lreyJ8dP8YIOCplANRci9o8+MU0LaCU4j
	4ZpbRtlx5+VzcDpS5KkXFuZUwX/DU6e2ruEVAbJGubV+QUMEqxoeZnxSyibA5waY
	g6gImZnLaS4Csowe6xWK2g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419purbuyn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 10:13:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47T9JhKX036587;
	Thu, 29 Aug 2024 10:13:02 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4189jn1g75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 10:13:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k9J6rnaIw2aI6vO8foqjwhWJJN8R9unZpxSCPJ83kI6lhPpVRLNsIox/qbpk/R1cXyd1O6CRW31N38Gs2fkcaOsecyY1AuTfh4ebSDZeT8CPiWxKVJGj+HCmC4OilM1V6YKoYThNNuHw0+UUtZsMN/2BA04jZeK1XXRKrw8wuncA7APhkzyplLUilllQEMdOaNoSCnP3OupEZqfdkgEgBQ+GppNr3QCHbu1UF9kEbGBOEDdEiIllhqwYy8mokjWylukHZXnnghihzECY7Tv2tPujbJjfXN3JAKKPiK+Lo1EXofLQlfd3ji2A5SkV1he5gvNQOQdAWbqvx+NSCeMiZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9O6NWyaQqBofwEuy8DLgR5cvjSLtIgEermnatbGdIc=;
 b=SPiKMSZupdxJgTtGwR0FcY8USR+agxzzDPnqCIuRYNVbCHIJ+dWA0Wm3SzCXWCU9slgPfa1VgdORm3uAsrAotCnQSdWvmWkPZkpN9kIJoJttvzCHz/y+mWk9zdUtuIHVyXA6tGtk9AnyU+LBhxde+m8JgZo0gCmLO6o6LGg8ily3XiurjACMn/KO0yeGWX5O59DWYWzohDo8VtbfPKyb3xQWJ2z5Pi+2LhwHwbdyCRYNdLX8HsX3QmnhmGsE2fEXmOeP6OL1gWv0/JmAWvcq1a0HQ4dbikh86VNvJLWdZzUzKXKjx8w7h2PDhAXHsTsEPX2Gwu7bJV+X1n/rfeHezA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9O6NWyaQqBofwEuy8DLgR5cvjSLtIgEermnatbGdIc=;
 b=pqMMngfkvxl2oAxJtLSMJ8/JNeow4+n6SDZw42uWlMLzKAI7/8cI0H1YrCyrmdn8vllPowDDfrcnWI0N+WrvBX9EY2fgpsMni0tuVBj59xQDViFbkRR0u8D0VoD+hCvZ0e60HUsgdkX9kfwI0XLQhsN8cW074+GOJXNeNg3nueM=
Received: from DS7PR10MB5278.namprd10.prod.outlook.com (2603:10b6:5:3a5::9) by
 PH7PR10MB7765.namprd10.prod.outlook.com (2603:10b6:510:308::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Thu, 29 Aug
 2024 10:13:00 +0000
Received: from DS7PR10MB5278.namprd10.prod.outlook.com
 ([fe80::eb46:3581:87c4:e378]) by DS7PR10MB5278.namprd10.prod.outlook.com
 ([fe80::eb46:3581:87c4:e378%4]) with mapi id 15.20.7918.019; Thu, 29 Aug 2024
 10:13:00 +0000
Message-ID: <235234d8-a223-4170-876a-6ccbf552c09c@oracle.com>
Date: Thu, 29 Aug 2024 11:12:46 +0100
User-Agent: Mozilla Thunderbird
From: Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCH v3] bpf: Remove custom build rule
To: Alexey Gladkov <legion@kernel.org>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-kbuild@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Oleg Nesterov <oleg@redhat.com>
References: <CAK7LNATb8dbhvdSgiNEMkdsgg93q4ZUGUxReZYNjOV3fDPnfyQ@mail.gmail.com>
 <20240828181028.4166334-1-legion@kernel.org>
Content-Language: en-GB
In-Reply-To: <20240828181028.4166334-1-legion@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0189.apcprd04.prod.outlook.com
 (2603:1096:4:14::27) To DS7PR10MB5278.namprd10.prod.outlook.com
 (2603:10b6:5:3a5::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5278:EE_|PH7PR10MB7765:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eb7680a-9c52-4b0b-5bd1-08dcc813290c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N1J4UHdOMFZkZFgvMkJiaU55MXQ5S21GVVl6M29uZ1M1OGdaSU50SmxycHBU?=
 =?utf-8?B?Y1JQUUEwYnpmNm5NaW5YYlFOVHhWbE9IWkdmSXBIUEJpdnFsZ1B0cWhPUFZX?=
 =?utf-8?B?TllrY3g4ckFRbkRabFl5WTh5RWl0WG9oekVHeHlaaWE5bE4rZ2kyaFJsUnRl?=
 =?utf-8?B?S2xMT0dySktBQ2xDbGlvN3pjN1ZqSkIrNjFaZ250REZ1VnlWM0cvOTM0RmQx?=
 =?utf-8?B?d2NVMmFJRUUzaURQMnd3SFU3TE1GMERmcHdUdmJNZVZ6cFhxVmFFS3RpaHRv?=
 =?utf-8?B?cCtEUURyYSsyVmtTOUtPKzF4RmY0dEZCNUtNb0oybEhIT1FtMzN3OXlHRDBz?=
 =?utf-8?B?RU1waXBQTXlFTGxGK1RYWnpYZEEraGtaZmMvbU5vcTlaenZuTXdzcjBaUWJt?=
 =?utf-8?B?QXBtMG9ZWE13UjZLbXMxcWJ2MEhPVUVPTHBiTkYvb3Jpai9LRFpjSXptcXcx?=
 =?utf-8?B?Zi9JM2ZFK1EwaGlYVDF6aW1Dc0tSV2NhOVUxb0JPZ3R3YlFhZEt4SkFXUnU4?=
 =?utf-8?B?ZGdaVlVVU0hBSlpEUThyTjA2YU5odUtaWWs0ZUNzU2FTc1VRanNFV3VkRVkw?=
 =?utf-8?B?MVVVc1U0SEREclRxT0xpUUFnN0RTQXRhTGQvUGtOMkFibTU5NEc5NVFrSVJn?=
 =?utf-8?B?K2NQeUp4ZjhiRTVjaXlsTVNQRzdrQlBRa2l4QTBMMXZNY3JMejdZeE9SNmhS?=
 =?utf-8?B?eE45aGtLT1V5Znhnd1BDVWUrN2MvL29KQTIzT0FvTll4SWpGQmk1aERUWnNh?=
 =?utf-8?B?N2dTRmZqMXpLS21IM2x3SkY5TW8yd3RjREMyRlZJYklhSlBVMmU0NUdEakhO?=
 =?utf-8?B?bVF0REZNakJnRGtYeVMxenFpVFpWaGlFRjBzdjVFZjRaTFhsazl1N1JTTVZI?=
 =?utf-8?B?UStMblFNUFpiTFVSS3hDZFNvd2hnZ0dkZWtjYXk0dEtCcEVERGsvVmFhT3N3?=
 =?utf-8?B?dXZrTlI2cXhlRUpZV0VybVZvcXNRazlkQjhMdVM3M213QTZSbGtTbnFtM2t3?=
 =?utf-8?B?MWRNakhzS3YvV0RBZ3BmNGtZbjYzWm4yS0pmWS9JbHRLNmZuSm5HSEZRUVdX?=
 =?utf-8?B?cDZoL1VkZGo0NGpNWnVDN1JRNDVVUG4zT2tYY1JSL2g2S3dpSDdoUEY3UHBD?=
 =?utf-8?B?VTcwelgyZ3FUQzZRUXlzbHhMWGRLTFQ3QzdmVE5UNXBYQ25YcFY1eldkR1ZE?=
 =?utf-8?B?dnMwdHQ3b0FWU2YxUk9iM21JelV4MUdNVFNqZytwSlY5SmsyVVVaK0wyRGNL?=
 =?utf-8?B?TTMzRmNhaDFIajN5cS9MakFoR3owZ1M2dG1ZaU1hQlVMOFErMWxJZEJKb1dG?=
 =?utf-8?B?bXpYNmkxUUxEMENRT1ZyRVhSNEJWWlo0UUc5cjVQc0l6eC9vT2pCK2NxWFFv?=
 =?utf-8?B?ZjY3OTFFUS9KRGNIc1Zzb0dtWTBvTFkwb2FFY3dNd0tkd2I4UVY0OUIyYjNm?=
 =?utf-8?B?UkNySmc5QUNYbDhneC9oTXVERDNadXdUZmRrMkViVlJ4NEhrM1Z5eTk0VEwz?=
 =?utf-8?B?TE5PdEZTN0FoZU1BbVJzYXVOWjVQLzArZVVuL281ME1TcVFreGY4b0FtbUoz?=
 =?utf-8?B?akYwRGZVUUZEczFMY09NY2RMOFpoYjl1TVYvMWRCcG5SVXlxSHE3NFVCVGJT?=
 =?utf-8?B?bWI5TENpTU1vMnRPNWFLTGl0b3J1ai83c2FGbWlJRCs2MzhxYjVET016Z2lJ?=
 =?utf-8?B?eHJMZ2NSRlU0Zjc5YzgwYm5FRHNQdWtMM2xqbzJheWlGVm92bkVJYnRFODV2?=
 =?utf-8?B?aUtObktWVTM5Qmx4VjB1amV4c2FNRXJDdUpIMERzc2J2aTZyalpnWVplbXJi?=
 =?utf-8?B?WVhQaDRzRnJlV01FVnAwdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5278.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czdHc0xZeGsxRWZtenorLytuYzJJZmZKYVd2Nzd1bnAxdU9tbXVpWEFGU3dn?=
 =?utf-8?B?TWVBZERWdVFrbU9DaGJKTUhrQTJPZjNvbUlDdUxXMDIyYlY1ZzVMcG1GalZW?=
 =?utf-8?B?bE8ydlVPd2N0WVBnMGkrb2JxUXoyM3VnZ0l4ZDFSMDQyOWZySE1UL1VDU3pD?=
 =?utf-8?B?dFdyYTY5VGs5T2lOM0ZzUFdHbndGZFhXaVBaU1BIV0JZTGpaM0hOckh6MWt5?=
 =?utf-8?B?S0s2Y3J3QWp6TkovMStQT3VJSkhFSXp1RXdxYzh2ZW1vT2VoKysyWkNzZ2Qx?=
 =?utf-8?B?cFlGNzNDeXZyb2tUTG5NdlZCR2VSNENMT2FtTndJUGtJcEMvRnpWdHBqVEYw?=
 =?utf-8?B?a292NEJTcEhodXNLc2MwUjRPSXFGcjhyZmF6NmgvOXZRLzR3K3R6eXIxc2NU?=
 =?utf-8?B?amZSTUQ0eDdKM1NrTEV1NnE3cld6dXR2d2MzRVo4RGFUekphczZBS011SVpN?=
 =?utf-8?B?SWwzS2tTZ0JERmJNcFU2cEQxcXNoNTQveTJMVVBLaVZIa3Rxd1k2Q2VibGNT?=
 =?utf-8?B?RStreDJPcitFaWdPOEdpcW1tSjdRQTlBZnFqWnRVUFVPSVgvd1RzN04xRnVs?=
 =?utf-8?B?MWJjeWJLRC9nbUdQazJ1SlgzWlhhckV3bDVhVUg0MzVVREdpUzZ0bi8yU21G?=
 =?utf-8?B?b2l5blN6MGNlK1RLR24xbHUya0ZJQXVVdnNJYW1velJwUkdjUEhjYjU3T2RB?=
 =?utf-8?B?SjNmVkEzU3VSemM0eXlhUk1UaFlnMFh3TVZ6LzduQVQ0Ky9lVFRobVB4bDM2?=
 =?utf-8?B?K0UwazZGMEZwakhhSnlYMEMvRkFYN2RKYXJQQ0xFSlVwQmFwZUcwbjZJblJH?=
 =?utf-8?B?UlR0bFhOY2lhbS9CcWJaREc2YU9qUW92cEk5U0xVQm1FNVVhVXlnd0FJaFYy?=
 =?utf-8?B?K250cTZ0bEczeDUvb01EUCttY1dsTmhjN3JZNC96M0o2TEdyTUV6VEVmUGw3?=
 =?utf-8?B?NWNrc013VjlTdnRFdjdkU2FwVE5DZ2swRnZYSjRkK1RsYnN3emZEU2o1eHBC?=
 =?utf-8?B?QXdHa2Fpdk5BZlFvNmpjMEthcHRvbXZ3aEVNaXNUbFcwRy9WRFRjRk45Qm9T?=
 =?utf-8?B?ZkFDT011WjNGZkd5WGtTOFZJb1VlYzFabXRKeG5LSFV4SS9KYThNak1CeWtr?=
 =?utf-8?B?RzJVVXZNNnJTbWMvc0wvT3Vrbm5ieS9zdmFobm1wRUhrWGIxWWt6VjlwdlRq?=
 =?utf-8?B?aDhGSjl3L2xkQ1hEd2FKU0ZPVXdJU3lZZmNRMG5CdUR2RlRBN1NZMHh2dlA3?=
 =?utf-8?B?VGN6VG1ENmNPUWdySHdVS0xObVl3Znk3Qk5sKzh4YXZXRTRzanIvOEtybDFH?=
 =?utf-8?B?djhnZzZUdDBnT3Rjd3lJYXA3ZzFWQkJ2UGdSNGQ3Z0RWMHpFTTlLYmVham1H?=
 =?utf-8?B?N2dqU2FubXh4Y05yZThxMkpiSThYV2MrWU0xdElDRWRZaElpV0dJRDlaSzhR?=
 =?utf-8?B?bU54c2d3SEtqelRnVnF6dFpkUUF4TWkwaE1BS1R3UHlyd1pUN3IzMGNWL3lL?=
 =?utf-8?B?ZjBWeXpsVFo4c0VxNDFtVFlUNHlmYzZGUmJubG1maG5vM3VXeURpSlBtcHI3?=
 =?utf-8?B?VyszSmxpZTJkbFpGakZQelBJeDdNelVoTDFnYTliT2ZGV2xJcnUyajJBUlRi?=
 =?utf-8?B?bUwzSTBEd01mRXhybVRLbHl6bUNOS1E0cHlYOXVWK01yRHFqUWVXQ3FZL0dl?=
 =?utf-8?B?aU5RSUtGL0ZncDJEcWJMRHJUNVgxYXRlakxUSG5PUDdNbUJndjdUYWdvYVpk?=
 =?utf-8?B?eFUzN0RWRmlERzRCcGhLTm9xTXBVR1Yyak9PMytaN2d2RW03VE1kK1BXTEhj?=
 =?utf-8?B?cnNvSS9wTS94bkh4SU1iK3hYZFQ2a1o4OGxTRW1qdFVHL0hmVVZya05EZktU?=
 =?utf-8?B?OVZlaUxGQWU1Slhmam1KekQ4cE1Pb3FUaWZMUCtlOTU3N0JtRWdDSXJERWQ2?=
 =?utf-8?B?SkU2WXJXTnZRVmJNbGlESmowcEI0K0FGZFZ3RW5VZ0FSTmRvZC9UWmhBYTU3?=
 =?utf-8?B?OVJCWUhucVlkeVBEUERoMlVrOVFkdHlXQmRyWXhaeTdDM0w4NFZ2V1BhdlhG?=
 =?utf-8?B?UW44L2N5cCsvR0RWUE9lOTRJcSttUEZHemJiMVNPUlpWMUZjazRWUW1nL3FO?=
 =?utf-8?B?blp6dkhBS2FSWVk0cnZlWG9kaDZzeVlSbFQyMDJNMGg2a2FsZ2hOeVlSd3lU?=
 =?utf-8?Q?1EWQPXodQswMadxYVQfbYQg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	E4vkc5TUk8zqYH1FpTumpqHV8ZkSdUZeRtC54sDAI+fH9JCNcW58oKtP9pgGZTgz/tAzDW/KUnYLH4OICjxjLl4YCFqXBCe0nf5DaAah5ttg7YssPNQtD2dHskJAdKq6RQgpDw0yfVT4JEEWhn+jQPMGr6zQ1mV0eZwuD1J62YVjxAoqafHcoXycuDO+q0rPbH62lRsvpqaGOSITZiPSdG4R0vI8Kna9/jhYV65I0uKAMmmO42Y9osbnEAkGLd3JRlROJcIh8OanIUrRzVDs6x6NEz3OfB8qLOI5n66ex+ySbg9NlNnaobnrxkqK5XPMVsigzKEgsNQgh87VQ58m+uEVFqmNgHziBs8rbVfF6K1z7W0YRmzwaNTuX7zoVserk7LJBSxEkg0+BsnFetjKABRqNfRVebonRekk9PzxFb8v3bvmpP4VBRguAGfkZH8N1hOTEfEZ8BVKpcwaFqcH5gflAx4oYZNdnHbznFn8cYqWEa4f8JHgx6dKegh2qT+3D2x6sS4MzHt3PceJ/zHzuXT/kZFjuSvvCOecE3YiQahE8yPV6faFNNU23dliAf9LDRj6uEa5/JhmdrJf7vrgazRXLvfNiH0+LySerad5o3w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eb7680a-9c52-4b0b-5bd1-08dcc813290c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5278.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 10:12:59.9371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NYztKS450OZSCytWMfQcqv/L3KK8GnNxZEwLGwHFDA2OkqKK6LVWgEpPmw2aqPiX0aDG3FyjJTVjYvuvoIaAgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7765
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_02,2024-08-29_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408290075
X-Proofpoint-ORIG-GUID: hMGSaAwRcxvu0ZKI6Z10kB6dl_s2t9y4
X-Proofpoint-GUID: hMGSaAwRcxvu0ZKI6Z10kB6dl_s2t9y4

On 28/08/2024 19:10, Alexey Gladkov wrote:
> According to the documentation, when building a kernel with the C=2
> parameter, all source files should be checked. But this does not happen
> for the kernel/bpf/ directory.
> 
> $ touch kernel/bpf/core.c
> $ make C=2 CHECK=true kernel/bpf/core.o
> 
> Outputs:
> 
>   CHECK   scripts/mod/empty.c
>   CALL    scripts/checksyscalls.sh
>   DESCEND objtool
>   INSTALL libsubcmd_headers
>   CC      kernel/bpf/core.o
> 
> As can be seen the compilation is done, but CHECK is not executed. This
> happens because kernel/bpf/Makefile has defined its own rule for
> compilation and forgotten the macro that does the check.
> 
> There is no need to duplicate the build code, and this rule can be
> removed to use generic rules.
> 
> Signed-off-by: Alexey Gladkov <legion@kernel.org>

Tested-by: Alan Maguire <alan.maguire@oracle.com>

The aim from the BPF side is just to share the btf_iter.c,
btf_relocate.c and relo_core.c files for both libbpf and kernel build.
Those files need to live in tools/lib/bpf because the libbpf standalone
repo on github is built from tools/lib/bpf.

Since the approach in this patch continues to support that while it
doesn't break other things like check targets it's definitely preferred.

Thanks for the fix!

Alan

> ---
>  kernel/bpf/Makefile       | 6 ------
>  kernel/bpf/btf_iter.c     | 2 ++
>  kernel/bpf/btf_relocate.c | 2 ++
>  kernel/bpf/relo_core.c    | 2 ++
>  4 files changed, 6 insertions(+), 6 deletions(-)
>  create mode 100644 kernel/bpf/btf_iter.c
>  create mode 100644 kernel/bpf/btf_relocate.c
>  create mode 100644 kernel/bpf/relo_core.c
> 
> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> index 0291eef9ce92..9b9c151b5c82 100644
> --- a/kernel/bpf/Makefile
> +++ b/kernel/bpf/Makefile
> @@ -52,9 +52,3 @@ obj-$(CONFIG_BPF_PRELOAD) += preload/
>  obj-$(CONFIG_BPF_SYSCALL) += relo_core.o
>  obj-$(CONFIG_BPF_SYSCALL) += btf_iter.o
>  obj-$(CONFIG_BPF_SYSCALL) += btf_relocate.o
> -
> -# Some source files are common to libbpf.
> -vpath %.c $(srctree)/kernel/bpf:$(srctree)/tools/lib/bpf
> -
> -$(obj)/%.o: %.c FORCE
> -	$(call if_changed_rule,cc_o_c)
> diff --git a/kernel/bpf/btf_iter.c b/kernel/bpf/btf_iter.c
> new file mode 100644
> index 000000000000..eab8493a1669
> --- /dev/null
> +++ b/kernel/bpf/btf_iter.c
> @@ -0,0 +1,2 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include "../../tools/lib/bpf/btf_iter.c"
> diff --git a/kernel/bpf/btf_relocate.c b/kernel/bpf/btf_relocate.c
> new file mode 100644
> index 000000000000..8c89c7b59ef8
> --- /dev/null
> +++ b/kernel/bpf/btf_relocate.c
> @@ -0,0 +1,2 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include "../../tools/lib/bpf/btf_relocate.c"
> diff --git a/kernel/bpf/relo_core.c b/kernel/bpf/relo_core.c
> new file mode 100644
> index 000000000000..6a36fbc0e5ab
> --- /dev/null
> +++ b/kernel/bpf/relo_core.c
> @@ -0,0 +1,2 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include "../../tools/lib/bpf/relo_core.c"

