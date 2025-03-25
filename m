Return-Path: <bpf+bounces-54626-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEA2A6ED24
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 11:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB0443A834F
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 09:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABC6253332;
	Tue, 25 Mar 2025 10:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VW+99bHl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Hn3BdWXB"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42720254846;
	Tue, 25 Mar 2025 09:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742896800; cv=fail; b=kk9Tfj7L9w0H5BwB+TbtGUuliA5joZ8zfWtuv0yrvikVFIDmkMSp2wWU+FZAynvcfeRp4z5yAfmbg+o6F/6+9NKQW0UKTqQKGIPopSEyeOIhwkyzNeLcQ+WoFhmTAnGfu1JYQZL6B/Sm/gGQUouKR18NJ1j5F9W8H1mw0bJ9JOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742896800; c=relaxed/simple;
	bh=RDP5PAnmrPfFrunmQQMztf5aHNOlRgb8c0DC4OrdqRE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JRSwHKDfbnITaZ8AKjvsmkbRyV0muU3D64ZowmxTsMxFZzSI6Dm4j+L4PLal4vhnFHAcj6aaTOnOyl1itZbsyruvg4/RC+cO4Wkb8kPiKsl7StHEuC/EeMSLYdy+OAzEgk6f+jljxtx78eTMTQHk5e5k+GfXntYV3L9IVQdHDsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VW+99bHl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Hn3BdWXB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52P2tvNM002209;
	Tue, 25 Mar 2025 09:59:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=G/QKCZUUTFh9b/1whquO41ct27TMX3FT+NHssMsBdDg=; b=
	VW+99bHlK8SN4jUrJb8Q0EVFJNwlomIM4szLx6CdTWhcYbxELW8yeowfCqrJnjM2
	Y3Q2gEPZ5mXsnbe9+PxsjYzI8Esrq/bPhaQyRgVpt0vEFSzhaUarQHUDVFQ1QALK
	VRFiYg75M3U6FH3kSwY8TPo64u0gfseeHkhOo7caEVdFNMZYFI53eQYB9bTTcyXb
	TdiTkkQ5k7LbCcKbGB23cbf6WvA6FQO/onzUUWqY/aMPksCS/Ncbt9F/8a1PPGiF
	DTuPOeL8waPx+zoXUcgAbLAMmbQ3PD1AGtimU/8BYpLpTZy4T3CLyT0RadD62nPj
	okBj+3xU8k7TdWAkyd+MqA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hnrsej7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Mar 2025 09:59:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52P9tjrO015884;
	Tue, 25 Mar 2025 09:59:30 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45jj91m5su-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Mar 2025 09:59:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zIt1/DYCZmuVoHft+DQJ/pqOD6r1zs6snvAzM/0w0NpE2UijjNd1HuFpc2JPLb4siYYITVw1qbuaQebx4H7IppZp+xof29N+uww7DAw3hbLlHTsB5HkTzFnmgHRWRXSbsAkyRsZeAj+Ca89iBHdHP69RqMrOAPloiHScvtjkCsijDySZD3FTjcAlstswWEFfZ83IHFF/bJOfpSgT0hhPqwdpJTVLNwnT1GPBfqg/i1wZ5+EdOlzX7+2iebsJQSbwDBSfImIBl490ltrLfYfSoz2UDpikAD7uuRdWUipUjgJiuxMiPScrQaEtVlXsM6BjPeNOKloMTUrVygqivNEJFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/QKCZUUTFh9b/1whquO41ct27TMX3FT+NHssMsBdDg=;
 b=onOtsOlxxzau7XAvoyMReQUWiF8pwHFtAB7uArdk6w/8ITJzuVGnwWtY+iqQGFvJW3eNoDkaNJsDl70hCFSyfgmsuN4XzDxTEOhBJ+/04bvVZCxQlDSlhgrBl4z0xIZFjtjJrBBDVkjWJuxGnuJbcBIup+thJTWWMsp6A7Vx6qw186EUDrWTqB2iKUUB8KGngFEb7tnQMfjYonfZIIqNkhd6ULxHl69JlX7p7OkjlE+GL870H2RCJya7qnbNa5utPl79IgYiGmhzCCVrpM0JVtILdwEDNOdw9Gw9hey5e5snL2XFys9ajL7Atn8oBf1oGmU88YelkW5Ghm3WL7agZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/QKCZUUTFh9b/1whquO41ct27TMX3FT+NHssMsBdDg=;
 b=Hn3BdWXB6/Y55uoNZAHeLkzJ9gKSRX6jOKWVisWSElEw2I26GjnhXur8uP5xDCJMEETTmRC1/aAi414FxrY8X2Ekq8lU9KFMFTkrdas7u8F/WtxKol8cfFjkv4sKDkhU0tGaGvxEzkM4ELdxG025pyJ0Iefh0LWYlZ+AZlLs6E4=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DS7PR10MB5005.namprd10.prod.outlook.com (2603:10b6:5:3ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 09:59:28 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%5]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 09:59:28 +0000
Message-ID: <e9c86b63-7715-4232-869e-8835eead9a8e@oracle.com>
Date: Tue, 25 Mar 2025 09:59:22 +0000
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
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <458b2ae24972021b99e99c2bad19b524672b0ac0@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0021.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::8) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DS7PR10MB5005:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a45b0a7-df30-433a-3db2-08dd6b83bab0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZVVpbUdOTXdCMkRLcldwT0JKWnhiRXBRZlZzaVB3Y0NrRzNLakZhRGhwUVlC?=
 =?utf-8?B?S0tHWFF1U1d5eXdUbjNnT0doWmdpK3Yzbll3Mnc1bnZTOW12RG9reG0rRC9Y?=
 =?utf-8?B?ZitnL3VpcUVTTVl4L3VubWVxb3p4YnFEVm4rWlUyTUxmV0dxcW9BSzJYNWpr?=
 =?utf-8?B?S3JGZ2RPbGQwM0FaMnYvc2xKSzdnOWcyR21Rck56TGJPci9pKzJ1cEs0aTBt?=
 =?utf-8?B?N1VnREpCeEJWaVI4RysvZ1J6TE45OE9GOWNHNnVRZzRRbzA5UCs4N3htZURE?=
 =?utf-8?B?Nmw3M2EwV1QvakJ2N3JLaE9SWlBTQUZXVFRpVW9nMWM0ZytaTmNqR2ZlV2ZQ?=
 =?utf-8?B?Z0F2aWVINFpVU1Z4NmZVWTZZWkRVTWZkNlFEdFNnKy9SZnpybWVaM2tOQTlu?=
 =?utf-8?B?VlVPci9MOXdFU29mRFRRNldVcWZJQ2sxdGw1YjVOTkVtM3Z6amhLSjI0WGNR?=
 =?utf-8?B?QVc1QkNzbm1yQXNjU3ZsL2FJYlJ6NFlZUXBaQlY0YVVqTnZFYzRFc2ZIYWpL?=
 =?utf-8?B?OGdjTUZwank4MjVMdTZsTWxLY0FtNERtMGNFamJDeGZmcThsTitqbFhaS0wr?=
 =?utf-8?B?TjZZWXIyWldVZzErNGNLcGp6WXo3RHBEVXg4N0lKOTFvcW9xSS9PNmRxdWNT?=
 =?utf-8?B?eVFmVy9veGluMHpPNXZSd3JtOTlodWFSblRwaUoweWtoWFF6KzdOeVo2TmNV?=
 =?utf-8?B?WlFuaXZCV2dBOGVobm9DdmY0YkwxRlZDL05SKzhxR3VQK0x0eW4vQjNpZGY1?=
 =?utf-8?B?N2tFT0o5UWVVWE9udlM0Z1BvbjJmVlp4cENBdElCRHJTL0FVUk1hbkJkUUJC?=
 =?utf-8?B?MmN6WVJTczRuRVh0M0Y3TWh3UUZNaFZabDZJZXFSZkh4Z3FWRjJXeC9iOWRY?=
 =?utf-8?B?UkRpTGs1QkhRN1NIQjlFRFlnTVlhOHJwSENPdEtEYzY0RDI4VzlYdURlcUFH?=
 =?utf-8?B?SzlLemd6VnlUTzJrT01mNkw2Wm9MWDdPU2xQTlBLNnBIekxEcTd5M3BrSmlH?=
 =?utf-8?B?Q3FDWm1XTGk2VVZQWDhoWDAySU82QU9MQ2Q3UXNVUWF6c2NRVk5GdDFpNEpQ?=
 =?utf-8?B?RTFzWUd4QS9kVTM2cm5GV0drRDhSSVNGOEpOdUJJR2JvZU0ycDBJdzlPWEFa?=
 =?utf-8?B?YmxvK2wxZnNhT3dsMGQvODh1YWJTSGlQa1h3T3pkcHM4V2wveTZOK1VjRXRL?=
 =?utf-8?B?NERSaDNPa2JHcWdBOUwxUVdGb0VXam5Xb2lJUldHMG1hN3FjTUNCcDZUMTVH?=
 =?utf-8?B?RnRJVVZrdE5ONlFHMDB2dzFha2U0UnVkcU9UakpPOWFESTlzL3huSTZndTdv?=
 =?utf-8?B?bXhrZVFaaDdwbld3U3VheUZueDRFRDJ3azV3b1BOUVptbVdNTlNjSWZxUlor?=
 =?utf-8?B?T2FkSkxMRG81RFo3SFlDREpMK2lMSzROYnNqOGNLSFlhU2VZK2xjcGw1NHdB?=
 =?utf-8?B?eERhSnBZS3JPSUUzV1Z6SjV0MzNINnM4SDhxOXIrR1VXbkU0SmpxQjM5cDF4?=
 =?utf-8?B?WUEya09Qa25mbUYwSFd0N0hxSjBTYVFyUnZQcVc4RzBuNUNld0llem9ReTE4?=
 =?utf-8?B?RnFYNDlVQ01CNGtRMG9DV0Z1dnJsRWJXM2l1UGZGalFoekxCWlAvTkxwdzRJ?=
 =?utf-8?B?cFJsK2d5MGFNWkdEWGpabDJOM0ZZQWpRVVJCQXlZQkU4SGtqZEp2VFE2ZTlw?=
 =?utf-8?B?V1J6RzNBUVRDTlZPWTNjVm15S0xJOTlEQkJXVy90aC9TRUZTQ0MzMzRTT09X?=
 =?utf-8?B?WGoxdVhPK0pSOUg3Sm9IcVFHNWozWFRxViszelV6TVFPdzZRVnJ1TGxjSHF3?=
 =?utf-8?B?aWlYa3lvRUM3UlVKR0Q5UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THIzSERuOE45VXNhQWJ4bkJQeWlGbEgwTEhWMEJIRzB1OEtOYXM1SWVOOVFP?=
 =?utf-8?B?ZVJ6MytiUERNdHJzTjBvakIyNDBLUEkrakNGUUVqSzJDUU5Vc01YUDc1YlNU?=
 =?utf-8?B?ME5BT2Q5ZFF2YVFscmNwWDRiU3pyOTBubFhOeXZZS0J4b2wyOTkweHpSeUs5?=
 =?utf-8?B?RjNMQTBzTFk0QmNVRWJlcElTN0lxWHFSQUd1Y1JEcTU5eHRMd3ZIeWJHMnRu?=
 =?utf-8?B?b1dBYzh4NGwrLzhMQ3gzcng5ZTlCNGZsTlhIQ3dVK0RsRVRSd3ZWYkQ0N0Fy?=
 =?utf-8?B?WDN5aXJEaWZqald2bEdKU1MwTGFBZEhUREF2Vk5mNkFGbm5jVnlRdXdzcDRU?=
 =?utf-8?B?aUpIM1NyTm1rMzEvY0NkZFgvOTVOU01jM2VyNlNjNmNUUVNzakxlZmRFZ3N3?=
 =?utf-8?B?eEFpWVltc3dHZi9uVW9OcHlnaUVKUjlmNDV2M3E5OEZzcGlqQnN6VlE5QmFC?=
 =?utf-8?B?MWR5VkFwM0dXclB1S2V4Zy9jSG8wL1pkRXBBYzFQUlRhM2FUMFFWTEhzLzNt?=
 =?utf-8?B?b0VoUlRMYXAyQXRJcHNPSkxBdWpVUE96NFBwbGdpZzJwYWxPcHZTUzBHb2hH?=
 =?utf-8?B?Zjd5TGN3MDNCWVJIQzJ4akFRS3lkSlltaUJWdE9JQUJEdXhtTURkcXpIQ2pJ?=
 =?utf-8?B?N2dlUk9QU0VQS3ZZOFpRbldzMVU2am9PM3dxMlNtZ2VCeTVZTWVrR0ppOFF2?=
 =?utf-8?B?WkEvQUpoK2pUQkl5Njd6SlZUamdxeWd6dXJZVjhNU1BwczhpaGhzWU5wa1pS?=
 =?utf-8?B?U2xlOEt3VGY3V1gwRExCUEdIOXVacSs3NnJhUDVHelZJSVlnTHNZM0hPREZk?=
 =?utf-8?B?Rkpaa2dUNlhUa3h5Q204TjVRd1JaeURSTVpmdVJjREpXa1F3cThJNjUyVkp1?=
 =?utf-8?B?YWxMV1NxMCtBMzNSZVM4UFlKQ0ZFdnpUR2FENDFCbXlUM05SbVRZaHQ0SVJZ?=
 =?utf-8?B?NGZwdE1YMGNjVDdHZ28zNXhLdTFhOSt4bVN6VGtMTmZpdERJRTBvMVRVeTUv?=
 =?utf-8?B?WHFIMGtsOW5RKzBZcWc2eXRaZFVoeTRXZU5RUlR1YVNnZkwyNXMwS2RyWTZu?=
 =?utf-8?B?RGNXTmdRNkhyM3lrNE8xTkh3RjdEZE8xQWgxL3pkTGFwNnYwc0EvRTFULy9P?=
 =?utf-8?B?STRLN002MEZXRWhjRm9wK0NQTXNuK0VUeU5MK1NoY09jWnFUcHEyQTQ5TEZO?=
 =?utf-8?B?aGtzMFliT0NHbUZVRnNuM3d1aXZhLytCODBNZlBycWNDcDI1U2dIckhHM3Rs?=
 =?utf-8?B?eWo5TGhmYkY1SDk5ZnU2dS9qbFZ4QUZTOGEvVTMxSkVYY09kMWRXRGROWlN3?=
 =?utf-8?B?ZVhhTGc4ci9YM1pwRzZDU1RXNXBCVWJTM0liQUxSejF1WUJGR2FPNmtsd0Nz?=
 =?utf-8?B?SHZ0OFNlbEZvRVBsMTJneHdzVWkraElqbU51S0l3K2FxZUV3Z1hlZ1pVM1FT?=
 =?utf-8?B?aWMyL0l2T09Kbms5ZThabCsvRnZESnNjNWlacGloUGFzcFl2MCtzOVJOWTF2?=
 =?utf-8?B?K0orMFQ1L1pTelpaaVhaOGFFK1RQRUNGdFBUYjdMYXVyUU1DR3VMbnFyZ2tM?=
 =?utf-8?B?Zk5LVHpPTG5TNGpSZmtGdTN5R29pemxrTUk5OTVHYXR6bGd4SVNMQmR6TXMz?=
 =?utf-8?B?RExucW1JVHgwUUtxMzRKUFdtaEppOTZ6YUM2d242NUtOa2dZZ0MxOVJaM3px?=
 =?utf-8?B?b3E5ei9GV0tYOGt6MG1yRldUZXRWeUo4Y3VIMU05cmplb01OTlJZTVl1MDNX?=
 =?utf-8?B?a3dpbHY2d2VHQkFCa24rZ1pYZzBjR0JnTkdJZDN5dEtucmJNcllvM0dGWGpQ?=
 =?utf-8?B?WGxPRWwwWWxQOW9DK25TdWRlUDVRd2JPdEhWZmt0ZlB1bStzSUR0VnpoY0d6?=
 =?utf-8?B?NVhTaWpLTHhON3p0bnNPdEE0WUk0aGNmMXZTRzM1THB1RWw0Ly92eUtIeitE?=
 =?utf-8?B?TDRYTHN2RWFaaW9tazBpZWREaDFENlZoYWt4S2tIVkM1ZnNyNTVMYU1aaURZ?=
 =?utf-8?B?RDJOMHcvZGlhNzNkbVBvRGxBUnY3SVJDZU13QUZocmROSUNKVnJWVk56YWR4?=
 =?utf-8?B?S2ZBY0NZSjFYNUtUR3NXNHBrTncvbE1NZEZ6RVl2ekR0aUpOL3JkQmZ3ajZO?=
 =?utf-8?B?c08vbStudXFTbHIyUGZjendFYnlCQ1pVdDlHbzR3L1VCZEI1RHBSTS8wVFBx?=
 =?utf-8?B?dEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jFhkZ1nv1rlqMeQmlzOPqN+6uVLEzFn1k11foMyGNLMtSBckW/rpoW75b3OlAep3B99rM7ZcaFSRpeDl103esNEzezdzwMxWb26vGK6oCB3DPr40gfMVI2JxfhQAIqddd5p3gUwuCwjfwJZ/PT2CKlE3MMmpcBqaPb0t1HyzNI6eeL4QWcs+KKsCYbJJt1k4cBdNbD6+Ff24nqKIGvzm3tUo+mGm7d1UDwkDNit6kJseK+JRhPANGUcC86ggJ9Gr9iHQmo1SlkMtsZ5LJu4STyT03kp8PU6Gq2s2JOzgu5sQDfknQq6/Pz2q9fuAroWio+ehvDnq4S2aj2S/3tDinxja53goMYv1xVh99GcvSqmS8NYJdZJGthPfV1zBRPiWTKsNxMHl4PkYCieni2ot4A4YdADBNvKJYoeP/03Sfc+figz4whIwL64wVUUBTc7VcjnS6q+1ibsYBS61mdKfFEcTsD8iEn/06BdF/kHz7a/RYrwzYoqeUqityUkiUVfVCbFZAOFR6AFxsNRWUtwCOMA771h+PuEeBD+IGq21LsGPOmBdYBOebqZzcXyA0N5jciQZCLjoFMw7M/lJgLlPYN01x3HrnLXWr5YLpf3QFa4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a45b0a7-df30-433a-3db2-08dd6b83bab0
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 09:59:27.9100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /fF6qtNPE88kRJ2nQv5Ttb9wQ0Ewrdbs7mAXJ0wiU8kpI8yAGWPcVDjlYZrZxB7deNJAbVffDb60vCGPISfOfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5005
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_04,2025-03-25_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503250069
X-Proofpoint-GUID: YWUw7PWLMbUPt-wIIGp1NcHe-IoKo1kO
X-Proofpoint-ORIG-GUID: YWUw7PWLMbUPt-wIIGp1NcHe-IoKo1kO

On 24/03/2025 18:47, Ihor Solodrai wrote:
> On 3/24/25 11:07 AM, Ihor Solodrai wrote:
>> On 3/23/25 4:11 AM, Alan Maguire wrote:
>>> [...]
>>>
>>> hi Ihor, I took a look at the series and merged it with latest next
>>> branch; results are in
>>>
>>> https://web.git.kernel.org/pub/scm/devel/pahole/pahole.git/log/?h=next.attributes-v4
>>>
>>> ...if you want to take a look.
>>>
>>> There are a few small things I think that it would be good to resolve
>>> before landing this.
>>>
>>> First, when testing this with -DLIBBPF_EMBEDDED=OFF and a packaged
>>> libbpf 1.5 - which means we wouldn't have the latest attributes-related
>>> libbpf function; I saw:
>>>
>>>   BTF     .tmp_vmlinux1.btf.o
>>> btf__add_type_attr is not available, is libbpf < 1.6?
>>> error: failed to encode function 'bbr_cwnd_event': invalid proto
>>> Failed to encode BTF
>>>   NM      .tmp_vmlinux1.syms
>>
>> Hi Alan. Thanks for testing. This is my mistake, I should've checked
>> for attributes feature here:
>>
>> @@ -731,6 +812,10 @@ static int32_t btf_encoder__add_func_proto(struct btf_encoder *encoder, struct f
>>  
>>  	assert(ftype != NULL || state != NULL);
>>  
>> +	if (is_kfunc_state(state) && encoder->tag_kfuncs)
>> +		if (btf__add_bpf_arena_type_tags(encoder->btf, state) < 0)
>> +			return -1;
> 
> Actually, I added this check in a different patch so the failure must
> have happened in a different place.
> 
> In any case, the point remains that it's better to check for feature
> availability (hence for API availability) in one place. Your
> suggestion to add a feature check makes sense to me. Thank you.
>

Great; so let's do this to land the series. Could you either

- check I merged your patches correctly in the above branch, and if they
look good I'll merge them into next and I'll officially send the feature
check patch; or if you'd prefer
- send a v5 (perhaps including my feature check patch?)

...whichever approach is easiest for you.

Thanks!

Alan

