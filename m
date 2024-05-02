Return-Path: <bpf+bounces-28445-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6660A8B9BC9
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 15:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E72091F23207
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 13:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A7013C66C;
	Thu,  2 May 2024 13:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YGPOZw3d";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qai7K1Iq"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1847441E
	for <bpf@vger.kernel.org>; Thu,  2 May 2024 13:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714657429; cv=fail; b=D51voMNtJQltmfm/1SVhnHy05OnIX7qKmmQ9mpoGIHG/Vz/xGBp99KXl9zxaErfty1IEBiEwSzJab9D7uKtI8nP8NPUTjtmjub/zRN38qF8rR0WXl9RbVwaIefnX72NQWM6b6Og/fk4pP1q0n5M+Zf0w8488mCgks4nx89RgLJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714657429; c=relaxed/simple;
	bh=xJqqlXoYOa4zjZhTiFT6sPo0Hr701cIp2rwJSqN/Pnk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bCsqS/JguTnaCbedz4SeEO/oJWb7fm5WnLx6neTr6d3UPVcgn+48lmPjMZ/SSRep7kp62ODMi5gGMyJgCU9yCyRGh72X5IneDSU6IfSuVb9+shwkcLzMKa8hW44tpRroF1JoROctkcwLmPggHenhrG51fdkqnGl3WTgsNNzH9Sw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YGPOZw3d; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qai7K1Iq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 442CddTm004092;
	Thu, 2 May 2024 13:43:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=VNYWk4tJ+YG7m2d8bUMTbAYKFfve1NQ5ilg1Tc9jjhc=;
 b=YGPOZw3d08DkwTEkeaZr1B0ge8mF36TBiCfBdoBuFso+yvCiWQsaE6U3D9NilwNAsHWz
 uM/nlVuWMdANN2ppmOWc7isXRPdjBrc4D2EN+8gxlxInoG/ovxMLEmZFmyMan5GzNtFR
 UGGtaG35SfcXxOGSO5ne05CWkQH2LEyR2L6Z4ySAd9H5W7YObKdb0yRird/ILOwWnJSQ
 4ycA3lwk60/dUL34yFbxqn4oAiR94PTMnV7cmmxK2e2TpZBkJfgi/eBGsZ4TO3+bFYpO
 Y2FD9ow7qYYjWj7vuSUyEt6/W5+4EvHA6hNdyRufmwINASsgGNwtWHts1w4bO19MSuLA Vg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrqy369bg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 May 2024 13:43:28 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 442CRdhH002160;
	Thu, 2 May 2024 13:43:26 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqtgy037-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 May 2024 13:43:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MFUE9pioVVkmwKLUlKSNQSEZqPHeXg3P/+UN8wBQ/6msZgrsTy2vRwrh38tHXaezbG5Q/JP+Q1kcK9Y6AT01uBWvUG1I3S0nqmjvhfdB7ye08mD8bXxkTZL2fjywO8OSMWzUZr+zs+dQw/LIpxbJQxCRmUjuADLp+j8adKVYzdmkr0h2KzooLIFA7PSTAJyQzqEhXPiovsclLE2rzqQgFkLGRlwBsqZwF4TYIW3Rbfg/vSs/ZW0VnLbTcN/4LM1tX6X48tJw05pSG4WYHQN9KW/6OAvSB1uIjl4gXwk+3l6WPKBqaIFTD7TcG/fSG2bg+Ze/MBXS7Rsj20Lix2hNeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VNYWk4tJ+YG7m2d8bUMTbAYKFfve1NQ5ilg1Tc9jjhc=;
 b=U+zAO7MvyqjomdmN1Az5SCI4oJPHXw4qX7zZ4q5IWcrXTy3Dl3s0A1f04Hl/qM+tZOtadrEydlmfT8JT/PtLUWCOlW3FhmyzkGl3eaqkAixWfoaOTEZBvS0dc1vbNoGj0ila54axbL4bhTRDIcQE3vezbrRa1AfsXuyxoa+oxn8EzK0Y0cuXoGA7dqXaG0z7lzdz2DzW8SkIwkNEjDK+VB6XVghRu7XWMjnnrrpxgzDZMnQ6aPXL9OR/Uwrw7ZBI5SGCUxl2Pv+gXpPlqp4a2heI7h34WnnYCDohJitcpDBnInSpu0Eal+xfR9Iu0eWp4nW2BIPNiHcdD1eaJGkUaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VNYWk4tJ+YG7m2d8bUMTbAYKFfve1NQ5ilg1Tc9jjhc=;
 b=qai7K1Iqved4ZeGa7l0Z0G/1O55msM8WBfHz1a1fl0FuodxP/DeEEEWf+2h5atVzAnzEHT/Dd0Wq3KGaregeu4wPP2uwvtJZ/Px/zZs7RKwK0ifbSUOXJ9zaUJMCEIUsGDT98RZUB33luCONNqCw45wTpoKgTsECjlBC2e9GY7o=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by PH0PR10MB5596.namprd10.prod.outlook.com (2603:10b6:510:f8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Thu, 2 May
 2024 13:43:25 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03%4]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 13:43:24 +0000
Message-ID: <cce7217a-7dd2-4c14-8e2b-9d4bd951cb61@oracle.com>
Date: Thu, 2 May 2024 14:43:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v9 2/3] pahole: Add --btf_feature=decl_tag_kfuncs
 feature
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Daniel Xu <dxu@dxuuu.xyz>, jolsa@kernel.org, quentin@isovalent.com,
        eddyz87@gmail.com, andrii.nakryiko@gmail.com, ast@kernel.org,
        daniel@iogearbox.net, bpf@vger.kernel.org
References: <cover.1714430735.git.dxu@dxuuu.xyz>
 <6d69d6dce917475ffe9c1bd7bc53358904f60915.1714430735.git.dxu@dxuuu.xyz>
 <ZjE85q0SJ1sve25u@x1>
 <2jjkwylnz7rjqkjpjb5li3n7g32uhrhx2uzwwthtgfqdf6bwzl@yjmuy24buoyl>
 <2bc24644-0289-48c5-8118-8be4fc1658a9@oracle.com> <ZjOWjjUmgCdNsXkD@x1>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <ZjOWjjUmgCdNsXkD@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0228.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::16) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|PH0PR10MB5596:EE_
X-MS-Office365-Filtering-Correlation-Id: 97676d04-13ca-4028-fe1a-08dc6aadd6df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VlVpWDRPcldCNFBlb1ZSL01lODJQYlFPZDVuUG9rRE9EN0VrSXlYNVE3RVZO?=
 =?utf-8?B?SUw3aEYzVXNudzFNUkU4aEpNdSs2WlRhbnVCdjE2ZTBQbVI1NkZXUms5a3cr?=
 =?utf-8?B?TjhBYy9hYUlkbytLNDduZnRMS1Z6OERqS2gyd2VZUTZWaWVIZU5tak9STUJK?=
 =?utf-8?B?SS9HMWJRZTI4ZXA4b1pGKzJzelc1WFFIM1FKSnIrVFpIVDhzblRqM1BtQU5o?=
 =?utf-8?B?V2ZBZEwrdkZVRUxuSk5VT0tuanAzT1Fwd2ZiSHpJZFZxYWxBekt5bWRrTTRT?=
 =?utf-8?B?c0k3ZVNhN0JpOXNyRHFoTHJuSjFDeDM0ZUxYSTJCV0YvMEU4bGVGODdsUU9B?=
 =?utf-8?B?YTVmU1hWWDJTK0RJZm5mZXBVZTBXNHRvNnBCNlN5WGZwcjhOWVhPSUxpNnRC?=
 =?utf-8?B?OFFiQjR5ZnQyNlI5dnovenpaMDI5d1VMOEdwS0tMTFY1b2Z0U3BmelJHeU9V?=
 =?utf-8?B?Q3YyRVVhWUJQUm9lakwwa0RITTM2VzgvM2xtZlFUbm1GSktaaTk1YlpzQlht?=
 =?utf-8?B?UnJvelZUQjI3Y0plTCthMnQvVkcrd25vN3FMRFMyRytyNnhTdDgwMGtGUXh1?=
 =?utf-8?B?eUxmQ3owa2pMcG9MYjk0Q3pXbjA4OVJxMHoxTVNiQmZwc0todGNpQnNvMk5D?=
 =?utf-8?B?NDBadFRTUmlFTVBmUTR5YWxGRjAvcUZtK3FXd3dFSklpam9iaTVLZWtXaEJW?=
 =?utf-8?B?RzJaeCtlUXpNanI5Wm1aVVFQWEp2eGJqVEdTdHNWa0d3U3NqTWEyeEVCODQ0?=
 =?utf-8?B?ZnZLa2oyc2dieDhkeWRWaTFNY0dBNFZRcFRCTzFZbktDcndEcm51Ym5ZS2p4?=
 =?utf-8?B?QzZGWXBMTDNJZTJIZVVqVllzdVJNYU5UYXRWTnZYeGlpVFlFWTlnYlQxM2tw?=
 =?utf-8?B?UjdabEsyRko1REp5dmNLcDI4SnZOZkVtYUxFYW1oK1NMeFNLZVBsK1VHb29F?=
 =?utf-8?B?d0VaSEIvcEdlZFBUWVNZWFdWZVV6V3ByWlUwT2ZYcnRSL0dubXVxdTFkaXNs?=
 =?utf-8?B?V0lFbGZyYVdBT0pmTXhkMFFKdkVsMEtZbGg0Q0RjcklpMzNoNEtWTERRSWg1?=
 =?utf-8?B?QnlVcStzOXd6THdsYXhIcWhvZnNKZWFXSTllakIrVXQweDVqYkk0QnUwaUdY?=
 =?utf-8?B?UTYralNhKzd2UkNSdFN2KzQ2Z01wQ2ZoSG10eCtncnJpTjF3Q0RieGFaakRs?=
 =?utf-8?B?MkJzNklSWGUxVzgwNU41NWd5Mm5uOFVzaGxuUnhoSnFkWjYxR2xiYWtFdkZ4?=
 =?utf-8?B?aDF2eTlBM0QyRXpRemZoeHVaUnRPQ1BWS0RCQXovQ1hYZ0JYM2Ntd2RhNVJ1?=
 =?utf-8?B?OWRrWGphVnpFWnhja21ncG9JVTBURzhtd0dLOW54NDRkRUpUbkFsWWRXRGJy?=
 =?utf-8?B?d0hjYXMraGV3Rk9LUmoyMTBrdHNOWlVKVU1nWW1yanFBNGpiWEo4TXprNHFB?=
 =?utf-8?B?MTdJUmgxckxwY3ZTVUxEMDhhYjVOVmFNMnRzVHRib2hEK05zaVZXMVpMd01J?=
 =?utf-8?B?TTRaOGVrSVhxWmcyU3BxS0FMcTVpcXNnNmFjbW1pZTZHSkphaHB0TVVZKy9z?=
 =?utf-8?B?cWFRamhXU0FBZEphc2lhdGdST3kyU3BDNG1MZTBzc3pPMjVuTlBpM2UwK0dC?=
 =?utf-8?B?Yi9oSmNGVGhUY2hNc0d2clQvS2d0TkJZdmVRcVVJUEw1UEFRd3ZDcXo2QlBk?=
 =?utf-8?B?dUFFemJkeWhMbzkxVjVpRDJjd0lObmVyejlwUVg2QitLM1pCZno1UEl3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZTczSnVpVVg3MnhrdVg3SDBWNzFYUlZVektHQjVzRXkrVUJpRHFyQVB0cUd5?=
 =?utf-8?B?MnZnS0h4L2xuQ0RNTkpHTXRYVEpjYXQyNGYxQXJtcW9tc1AxV2J1ajR0aHNG?=
 =?utf-8?B?NUd5U01YY0VKUi9sdUhOc2dmRVNxMEF3S3N3MXpyMS9CbVZKWmd5ZVQxaHlK?=
 =?utf-8?B?UEt3NEMxMlRKRVFMMDJwMW5MM0pJZjZadGRtT2dVVmN6SFpSTWNDNlUwYjVj?=
 =?utf-8?B?aFNrK3k0MmVDTmFPQXZmdjFZdis2NVpEa1dNd0lZK2VrSFR6aUxwMmplUWc4?=
 =?utf-8?B?Mmh4c3l4M2dlY09HVERBc3p3aDc1ZzIvYzFqM1UrUDJMMXo0aVZMZExuUWlN?=
 =?utf-8?B?SW9vSEhML2pzbFAyYXplamtNVTNpUHV4elZ2NXhpRm5Sak1lWGlFMXF6dVhm?=
 =?utf-8?B?S2Z4S1BMSWZzbXJ0V2dZcWhpQTB5OW9SS1NCSHJ1VkJNZkFkd3lvc2hGdzdt?=
 =?utf-8?B?OGJYc0t2WGJtMXRQZVp5VFRDclYyZ1h6VDFLNjBTOG45THFxWDVXRFQyZWZB?=
 =?utf-8?B?MC9rdlFWY0hweEJNTEtsY2xPdHFPdzlMZm9MUTZuaUs1dGViQXZGM05rREZZ?=
 =?utf-8?B?ZXZLK2loN1ZvdFBJcXBQUVM0K3lkcktxSytpQ2RVYmREWjMzWlNDanRmOElG?=
 =?utf-8?B?Z3YraThkWW1QWVlmTW9VTGhzZFZ5ajExVy9sTTk5d0s5dDFQTEdIUXRaWnFo?=
 =?utf-8?B?MUVmcWs4QjFRUi9jOFREODdBR1pUNm5XN1g5Z2VrTEQ4MVdld3pMQ3RnY1J6?=
 =?utf-8?B?SnAraTRFT0ZGSUUvZytJZ1l3ZDdiSDJZa2NpTjhyd2RFZnJCYWhYUXMyb1lk?=
 =?utf-8?B?OS9ZR2FHUGhOajRJdjRiTWh5SnAvb1JoS2hLMHZGMFUvaGltdjhUTnUraEww?=
 =?utf-8?B?RFdqRVExWTk4SlZlaHhFbkdWRUdyMVVYMXJmVjRJWWU0OXFlbWw5M0pma0hw?=
 =?utf-8?B?dGZtOGlTOHAxQXpDWEZDR3dTZWlBaEU0RjV3RFUzcVc5ZVBuQTlvdlo5T3pP?=
 =?utf-8?B?alFtTWgyK3NCcXFXbkVtdElSUmZhOWFqekgvNkE3Q2lTSDBvcFBvclpNcTk5?=
 =?utf-8?B?VVlvYmNoQk9XQzNHbGlZczF4b05qenZTRjRpcFVSa1BFejdQUEJIQ3JGeVVZ?=
 =?utf-8?B?NnltbFliZGdjYjJSNUM1cUplM0wzUjYwaTFHMDVCNzQ3MUhCVUxGc2tHVlk4?=
 =?utf-8?B?Q3k3V2Iva2JQRks4ZkNKK3ZGNnA4eVJJYTFQVUxRaHE0OG5rZ2JhWFFYOXk3?=
 =?utf-8?B?RmVnWW9raXEzVkdMUWhQcWZNSkthVlBsUUdxckQ3R0pldVppbDVrZmdmRkJF?=
 =?utf-8?B?ZzZ2RTZybVR6TldiVFBSZGxES25LNDBHUWF5S29uN0lkeUdwYlYraU12dGdh?=
 =?utf-8?B?TDZqcEZNM2RMR1RRT1hXcnppK2xqb201RENuVEV3ZXFxMUxCRVdsRCtJdTdj?=
 =?utf-8?B?Z2JnZzBaaGdSZUZhOGUwQ3ZWU2NTbDFxS0V2dHdPdGJXTTQ5QVRGK2ZER0lm?=
 =?utf-8?B?SmxlWDJpY0d0Wlk0WjV2bUs4S2ViZWNHTTJmK0R6QldjVCtkWE1qYU9sVXIx?=
 =?utf-8?B?WEI5QTJBWXl1Sm16SWkyQ2JHdmQvZ0NRa2tXcEpNbFFiN3ZIdFhTTnVXYktv?=
 =?utf-8?B?RWhNdTl5eDB2VkxzVkFycERGakRsWjJTZXgvOWtsd3d1dDRmS1pIZG41T3BF?=
 =?utf-8?B?ZlAzMGVha0FTNFpjMlRpa01oMW9RYjQwTFNjQkFIeWVEc1FXMEVIZDJGV1VD?=
 =?utf-8?B?TW9jYldNZ0Q2SUlyeStOR3JZVFVhM3RuM3o1MDd2NGZqR0ZkRGUvdFFpRCsw?=
 =?utf-8?B?UCswS3VQTmkyLzJjd01GdWoxbnczbCtZay9kcTRsc1dTeE5QaDBwaDdIZ1V1?=
 =?utf-8?B?M0NsVXk4RVl0Vk1ERDhNaG03MFFxbUlQeVR1eDJvaEh6TTFvbEsrd0g4QjVv?=
 =?utf-8?B?WE9CQWV3NlJZN0dITWgwamxrbVFLaTBWNG43V1QwajE4S0NPNEE2ME1HWjBj?=
 =?utf-8?B?N09VMEVQMjROUEtFYUpZZ1dqb0NpNG5yT0RZWjRUNGFmRjZqM05aQzZxZ0tX?=
 =?utf-8?B?SS9IMVc3WGtma3M0THoveTNja051ODVQQjh1L2I3RVVmNElwYzlSc2M1d1g0?=
 =?utf-8?B?cmxINm5aK2wrV0plM1lid2NTazRlVjNuaGFRU3hDK1JobFk5QTJjK0xwSWt6?=
 =?utf-8?Q?87+cJDYwb7ZT1brI7YEFeUA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	eZT+dX0i2J0ztQaZj6yuRJ3S979DPOFhzRfHjZ8lapbSVA9j9KkGKjzkUHV0ZywIt2PaoKhssJcpzSmCqzgxl8ug5qLZwax+YnLg01nGFovE0VWIMz67MwsDJ1BA3A1K8LouZZ4+Xgx/tKUGSizQaYd5KwPiIw5TM0uPeeaNjAHfNiVHt0xfzfQmmQAM6NlvEM/isWsNNlUNrhwmx66ddJlzsC+ESyO+Pi38SFwgFBD8duQiRxONV5K3Gv4ZHo34WU1RyahECJ+cqIE2hcMYVrViuZgKfjZuq2nCuoUWj9wcFl6cAsIQnEvqU8XPWjfJ5E8x5I/fcKmHxyuiokLtQl8NzPcD0PLDoptR3Tek96ZvGxpnBJxSN2TI33m8J8FroKaoqar+yolDVHXN16V6F9bT/9js97uh5sNGG6zejjOF4eVxeTiGKWhueldxVe5E7TGwlEszTbo97EqvYXQa8mM45Jp4Q8QuRNbEx9dkx/PQaV6uStXkSZJh+3pYUiNJq2y2tthjqVFmy6nS72n1QKU/TEV+r4nU7Ys14qxsoctfbHrR+EUIBb1ZTRa3PktFLl5SkJpmdabDf9d+hQXR3bDzcBq9t3ihE+m3mlir17o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97676d04-13ca-4028-fe1a-08dc6aadd6df
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 13:43:24.8786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6chdCkxu4lnd3x54jfuv5WsdmQGN+HNgd3H8OMaqiwDXfsO7vEN0gmKtOwaKYnBQHtFjeGzGXT1wLI4/0hah6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5596
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-02_02,2024-05-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405020088
X-Proofpoint-ORIG-GUID: 6QIgcqx0Flde-APVZ-rfAkxO8I_92SOO
X-Proofpoint-GUID: 6QIgcqx0Flde-APVZ-rfAkxO8I_92SOO

On 02/05/2024 14:35, Arnaldo Carvalho de Melo wrote:
> On Thu, May 02, 2024 at 12:49:26PM +0100, Alan Maguire wrote:
>> On 01/05/2024 00:00, Daniel Xu wrote:
>>> On Tue, Apr 30, 2024 at 03:48:06PM GMT, Arnaldo Carvalho de Melo wrote:
>>>> On Mon, Apr 29, 2024 at 04:45:59PM -0600, Daniel Xu wrote:
>>>> Also 'decl_tag_kfuncs' is not enabled when using --btf_features=default,
>>>> right? as:
> 
>>>>         BTF_DEFAULT_FEATURE(decl_tag_kfuncs, btf_decl_tag_kfuncs, false),
> 
>>>> And that false is .default_enabled=false.
> 
>>> I think that `false` is for `initial_value`, isn't it? The macro sets
>>> the `default_enabled` field.
>  
>> yep it's the initial unset value. Specifying an option in --btf_features
>> flips that value, so for initial-off values they are switched on, while
> 
> So --btf_features=something may mean "don't use that feature"? That is
> confusing, perhaps the '-something' come in handy?
>

No, in fact --btf_features tries to move away from the model of having a
mix of enable and skip features. The reason we do things this way is we
inherited a situation where some features that would begin as off if not
specified (encode FLOAT) and some that would start off as on unless a
skip option was specified (encode VAR). Prior to --btf_features, we
accordingly had --enable-feature and --skip-feature flags for these.
However with --btf_features, all features are positive; that is, if
specified, we enable var, float etc; there are no "skip" features.

Under the hood however, we preserve the prior "enable or skip"
semantics; that's why some default values have initial values of false
(an "enable" feature under the hood) and some have an initial value of
true (a "skip" value under the hood. But none of that is exposed to the
--btf_features user; if a feature is wanted, they just add it to the list.


>> initial-on values are switched off. I _think_ the intent here is to tag
>> kfuncs by default, so we can add tag_kfuncs to the set of options
> 
> Probably, if they are present in the file being BTF encoded.
> 
>> specified in pahole-flags for v1.26. We won't be using "default" there
>> as we want to call out the flags explicitly.
> 
> Sure.
> 
> - Arnaldo
> 

