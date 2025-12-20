Return-Path: <bpf+bounces-77261-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4E4CD3667
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 21:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9DCA3011F8D
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 20:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1EE30DD08;
	Sat, 20 Dec 2025 20:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="C8BraqxR"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E66423741;
	Sat, 20 Dec 2025 20:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766260841; cv=fail; b=R4hgdBpf29Pr7Zhaj33MPTOB/dlMYziUQy5qKcWogkUHX4P99aRRajM9EUGlq6Nr4v0niANo5vlXpHdj5l1uE/ch7ZAwiqM+6gTnKHhCreQsZajKtoPZr0u3hr2OUmpTFbNtQS9LP+cfbuIeNWu4yMF38nhcoSaZk6uTzXSJths=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766260841; c=relaxed/simple;
	bh=+Z8CmL1qarQul3oJBZhhWEEJSxP/X2e20kJvDZyqixQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VlRYnO2zJXZUvy6OruowkND1y+NIPnR1Vch3SWFnvj91kzGSzT2Svp5sXMEEVmE3fYTcJIpTVkdYWJSYe9SYwb7Ox11H/azuXnLVuwtX14n7W32CcVXhnpyrjHU5qYALPsodTqX6Oz+z7on7yyFbuEFZGq59Z6s98W+b8f9W0SQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=C8BraqxR; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BKAswC1891201;
	Sat, 20 Dec 2025 12:00:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=H/SRPeTBGKT3f13Ci/rPDX2UcgJHIDhAqAbzx+tiikY=; b=C8BraqxRzdFw
	G0n3xneqKpwNgB7YKxsmQ6XfvXxmJt6ZVyIcZSevRWNNfdXuA3Od3Hz85BWWkdzQ
	OiZ4a2gSFYIvTib1x3XEbzRF/aIbMYx3qfNuKmT+tgyhbdyz3GW8sQUfze+o2O2N
	+1a0/gTmClQt6LrXsPt4fRvmxjHvqJInYtab6hGiQZI+SoMvTirt46glFEdbyCWM
	cVJOeLS631RRzi5TE3SS5zrJOR2e1SkYi+zIifnletn4J+9tqyFAS0t1Fh9ANh53
	08W3RZS4nwzLjHemck48Of3rW2VEB1QAuPVfQHVsRaffAfzXxuRo43k20kcAH+mG
	kepjGybiKg==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010022.outbound.protection.outlook.com [52.101.56.22])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4b5r01u6xh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 20 Dec 2025 12:00:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mNsk25wleX0c5uc3x0TRAcRYlsXVZBMd18Z5YF6JALYcFOWT/Q38+xaMjDNC/U0zXhnsOx8fFgHQv0Dxx1nPvaOQw+bFpoMKEVPngOuejfdIm9KxJCk2fMbEpUA7mFWs3GvuHdYmzdJrEnFE/5g4gKqBwBauPRVxu97oiWHvhoSKkBt/YUPi+pps5FQ2BsLZJIBbBN53TEdBO24wRR8jkTXVCY74K2mmjDel9bEEz8MBmuKMecnx+al6wGU9Yv9IJ4tQcCQnIZM1pIKEx186F3jVJwga1HGOz5/JklYSHtrlWtFryyTiuhDc6ApR3FSPIymq+Rkt75lLkrrtmUotBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/SRPeTBGKT3f13Ci/rPDX2UcgJHIDhAqAbzx+tiikY=;
 b=Laz9sy5GAZ4tG1W8o0GJETNEDV5I7PElOITQr2rzGqmW9SuQIatU//Ees33grb47UM4mXJWpUNECYng6hYfrn0W7PX+fmSLpZawZn331rLMePZ/iL7GwzHUxjrtJQs5zZ2ERasEPTQBsCSwblJz3PFQiTTFdZfmZ79QifNbJzUFBvRDp2QZDpSouQ5U0VN+3kEYf1/DsGsmqCqe92hKdkXFKDXSqIwPyrKkLI5nnPhEZNqe14kip+kgyHVelVe+57od0TXsuCpDmnditVJtvvymazyRSErCuuoY8m8RjrYt9psg7dQ84AI0PwoZnVGV/MetqOhxG5nofxhjrwcchJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by SA1PR15MB4822.namprd15.prod.outlook.com (2603:10b6:806:1e1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.10; Sat, 20 Dec
 2025 20:00:07 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e%5]) with mapi id 15.20.9434.009; Sat, 20 Dec 2025
 20:00:06 +0000
Message-ID: <93dbca4e-bd58-4b9a-a3c6-595810727121@meta.com>
Date: Sat, 20 Dec 2025 14:59:56 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 5/7] mm: introduce BPF kfunc to access memory
 events
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, inwardvessel@gmail.com, ast@kernel.org,
        daniel@iogearbox.net, shakeel.butt@linux.dev, mhocko@kernel.org,
        hannes@cmpxchg.org, andrii@kernel.org, martin.lau@kernel.org,
        eddyz87@gmail.com, yonghong.song@linux.dev, ihor.solodrai@linux.dev
References: <20251220041250.372179-6-roman.gushchin@linux.dev>
 <8f23848b8ac657b4b4a2da04da242039c59e9ad9826a8d5fa0f5aee55acfecc9@mail.kernel.org>
 <87a4zdepdh.fsf@linux.dev> <dfc73fd6-9e5f-4b62-ac3f-7c9a327dd7fc@meta.com>
 <87zf7d6ll1.fsf@linux.dev>
From: Chris Mason <clm@meta.com>
Content-Language: en-US
In-Reply-To: <87zf7d6ll1.fsf@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR22CA0010.namprd22.prod.outlook.com
 (2603:10b6:208:238::15) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|SA1PR15MB4822:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b1df9e8-3cdd-4f1b-6445-08de40025f5a
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N3ZtQkcwOXgwVXJ1eUNtZVp1bVFBN1h5MGpvWmpsSzJvV0wvNGl2L2o3V3A1?=
 =?utf-8?B?RUhQU2I4M21uTmpJNk5TZStLcXlJTEdySEI3cS8yZzVzOVhXYjFBa3ZtVGZu?=
 =?utf-8?B?T3NPN2ZnSXdjajF3RDQ4ZmtMZnVrbkJidyswWkRXL0RuSXoxTFNKZEk4Z3Fn?=
 =?utf-8?B?YXJKK0RHSGliWVg1K2ttQWdleVpXazFPV3VIWWxQdVNBMndhWStSWkErY0o0?=
 =?utf-8?B?bnBBRE9QUjJnUjBOYURBSlpjVDZKc0I2MzczMkxyTWtiM3lCeVNWbXQzeTcy?=
 =?utf-8?B?R1dXWVJOUDEzRHU0N3pkSVlvcEhzZDI4ZzhTVWsyRVF4bUtYVmxCMUE2VUR5?=
 =?utf-8?B?U2hmY05UbExZMHdiTjBxQncxYnZLeG5SRkI5eDVmZC9KYzRPaWt3Y2dia09u?=
 =?utf-8?B?dmxBZnJvbXZ3OGZmbTlLdFk0T3BkS2xpb2pJUWxnd05udnBtVTZhaCtYV1A0?=
 =?utf-8?B?YkdaYjFwN3JUNUk1bEp2U0tHUktadkVHZXFoczRlV2ZNODBETFZDekh1WDY4?=
 =?utf-8?B?M0NrV2NOcGVxUzMrZXNZdmRHKzNwUlpUT3FuaHU5MUtaei9Dd0xDU1J2VGVu?=
 =?utf-8?B?bGcyR04yNlFQakhscmtFV2llbjA5VzlGbFl4UTZ0cVhBdVBlSlEwM016Z0ls?=
 =?utf-8?B?cVd6TGp1cUJ1ZmgxRU5zY3pRRU9wbG1XczhQZU4wcWxYZk9uR29NYVc3R2NE?=
 =?utf-8?B?VkRnRGRZZFlMU1RJZmp0NE40WGtaa1lzbTA1d2hOS0hmYmo2MUxMT3FWQSt1?=
 =?utf-8?B?YVg3c2t0blA2NjNzTCs3bTF3N0M0TU80dWxleWJKNVdPeHlKQmRuV01GNEhL?=
 =?utf-8?B?TlFmWmRRMGcrR1FBNUFubkxGcTNYdENjUDZHbE5iME8yY2k0b3ZYTXJNTmZB?=
 =?utf-8?B?Z2lMdnZiUkJNdEZZMG5mQ2ZZbGNOYkVKYkZkTGtEMWovTWRMcmZrMml0cTdV?=
 =?utf-8?B?dlhVeldXUHl0VWpLREFvYm0zTUk3Qmd1czc0Tis3QUgrMDBGbW5ycG9WWStx?=
 =?utf-8?B?cnlJMUVXeVNHT2xRM01CUnhjS2JRL3p0amhPMHNyQjM3bGZpN1pNVW1Od3Er?=
 =?utf-8?B?Q2pSWS9XeWc3UzBLenREV1NjVUd1SmZGdXFoZkZmemt3Q1NyclVUd01SWWJ0?=
 =?utf-8?B?MGNxajJubWVxSFo3LzdXYWd3U2RKRHZ2MEhQeUk4am96OWhtNWpaKzNETmYz?=
 =?utf-8?B?N29sTzJhVHNXcytkQUdieWhFTHVxbjFLOU9RRmFjNXJMN041aHNuVTlzUm5F?=
 =?utf-8?B?cmNaUkpTeVUzNmZWODlXb2NwVlRHb0xlQys3TlFCTXhXNkNHa2dBVTUxOHVK?=
 =?utf-8?B?Sko1aVpQbGlnZm1neGh1TXVmcTJwOHpIbTZhQzlCV2FZSldwMFY1Sm9rNDNr?=
 =?utf-8?B?Rk92Rk5jdVM0SmdlTVQ3bVhHRXlPNlRxcld5dkpjcFc4M2llS2tZYzYyTjVl?=
 =?utf-8?B?VnVZL1laL1k4UG8zT2VZTGpuRk5WMWdLeGh6cmRRWFpobmtLTVE1Y1pOL3JT?=
 =?utf-8?B?Tkc0Y3FKc0NrekRHRm5odDM5R3M2aXZNTXFwUXppTXkzdTQ4R0EzdzBoU2RY?=
 =?utf-8?B?YzdFWjdid3JaUW12bTAxOFBQeUg2Smo5SHBJNHJCaGdLSjBMcE5ycXk4cTJh?=
 =?utf-8?B?eTgxS2FTcytzZVdzWldVUStINDhtcTFEbzJNUkdDYVJjUDNpQ1VXV245eVUr?=
 =?utf-8?B?bnVrNFl1M2IyallHQkptejQwcnM3TWRucFRpVFhyTVF1Q3ZUV1AvUGdLZUtR?=
 =?utf-8?B?U1M1NDhjbzZ5RXR4V2lFRVdGOUd0VlNENmtqZ2ZCNmRnYjR2TWZkT3l4VkQ0?=
 =?utf-8?B?UnRiWWRIcFNKS3R6Nmo2YTYzbGF6T0lzdHFzc3pzcy9rQkVNckVBeDdKN0Va?=
 =?utf-8?B?RWNyMFpSRVcwU05hQnRTdk8zRzJpQTF0djhNNzhTZjMyUC9nUGdQNS9YT2hB?=
 =?utf-8?B?ZjUxYnFmN285bXFncU4wbldqMi9uUnUzVTFHR1FMemtIWkh2K1d0MXl4MGcw?=
 =?utf-8?B?ZHloOFVBckVRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2VqaEw0RUgvOE1rWGtUaC85UHArb25LekNaQWZhODRmWlZjQ0ZYcFRIcDNa?=
 =?utf-8?B?ZUxKWTRDVE5LRlJabGdaVE5adk9HdTVUN0hQYXJaL09NWUVHb1ZNSmV6OUZt?=
 =?utf-8?B?RVZyRlR5YjJvMG93TFo4bFZ1NkR0UUh6VkljcGxZQVFsQWtURjV0OUdlQkE5?=
 =?utf-8?B?aHJ6K2lmVFE0dDJ5aVRHK0dvanB6c2F2WU9tWU9VaTZuek5JZDV5aDBWbElH?=
 =?utf-8?B?MXNGRkRyajhYL3VjNkY5Sy9DVGVwbXkwSWtWWnlDWUd5VXJtaVFVZ09yTzVY?=
 =?utf-8?B?M2puME5FSzIrNmFrKzBXS3NOSW9zSHlCUzBMVHJySHhrRVNsdVEvbDhRSE5y?=
 =?utf-8?B?WkhCSHdQSUNOcHlxeXBKU1c3RUxhNDlLVmhvMzFwOHMxdlhINUd2ZUdKWHdG?=
 =?utf-8?B?SURTaVIwUlU5YU50RTRwekZ4R3AyWlNlQ05XSDhKOFlJb1pyS3Y0K2JWd3pr?=
 =?utf-8?B?RUEyTjd3Vk1paUhadWNoQ0RTR2U4Zk5SaUJlNzhZelI0Q1VNMDgxcDljdmN5?=
 =?utf-8?B?TGQxWGVJRkJwTzFDeHRMRVB4emZFQk96aTFiaW9zMytFK1pNbk81ckhjbXN6?=
 =?utf-8?B?UllPYUg4aDZmWjZla2tNMEIrMG96NWFya1JtcmlYL2EzaWhVZ3dJTTBqNVVj?=
 =?utf-8?B?K0w3UHpoQWd1Y25nK1padllWTTVDNS8yZGFqeEtRaFM1cW9WZFd2Q2twZUdX?=
 =?utf-8?B?dGptZzMvaGRuSlVhRjJ4MkYrdTNsWGdSN2M4aEx5MjlCeHM0ZmlzUmZoMEJQ?=
 =?utf-8?B?Q0FjeStubFlNT2ZWcVkvbnoyZGtTMmpvY3E0ZVA2TFhVR3FmNUt0Q1ZwYXA5?=
 =?utf-8?B?RXpCVGhma0Y5dkpqQnRPeXRmUGM3RENDdUJId0tvRnhGZ2tUODJFSU8yamlj?=
 =?utf-8?B?RTg5WTY0YzdDdnRaUCtyK1BBeXNRUGRDNFRNZW5pQVR5Wndna3RNeHJOb25t?=
 =?utf-8?B?VmZlTUNaY3NrWWlFdEM3YjMyNnkvWlYrTkpKMnFMNEtsR3hYWTZ0Q1k5UHFm?=
 =?utf-8?B?QjBmRU5aOTRRcWFOa2dBd3F0MjlZQzlhTFJHem1yS0pKMnNpK0hOQjZiSXp5?=
 =?utf-8?B?Z3hweGZCc0JnMlZUUXdOYVVDckNlcUFhMk5lOXJzNm52MzlIZGpBN0FYY2hB?=
 =?utf-8?B?eWFsaktCK3hhWGd0ZXRqUFQ1dVNnOWRzOXM2bjFxTW9HOW1YRmdMdWJCT1Zp?=
 =?utf-8?B?NWRtbXorT2pyNERGUDFKbllLbDFlS2ZDWG02VzNHMmVIRklPdzJIckU4QXYz?=
 =?utf-8?B?TkdweUl2eVE0dXdCUTVkRXlVMGdKaUc5dUt1anpSNzZrdFB0UzBYUlVRbU4v?=
 =?utf-8?B?MkdFbjlzZjM3aytBQU8wVmRDcnNYRFArS1BOTlc4NWFYYk9kR2dSYnhGaUd1?=
 =?utf-8?B?dlhKUDZoRFZMOGkxcGNVYlRvSThJN1N0UjhpRjBocUwyQWZaKzBJVTVaV0Jm?=
 =?utf-8?B?ZEE0bWZwbTQrbE0yR0FjSTVNeVNzT0lLbi9iMU95SVllbjZ1ZmJYWGlTa1la?=
 =?utf-8?B?NGl6NWZkUlE2UDg1bmF4eWNMSjF0R0lQajRyZHRGQWp5TUpJSHJWZlMwN3M5?=
 =?utf-8?B?a1ZyOFhjVDIyaXlOYk15Tmd1MzlVTlJBSmN4TW81SUZrM20rTmdLNUR2RkhQ?=
 =?utf-8?B?Q2U1VlNSR0JFU2VVT0tSMlZFVXpqMTRkTTFiSG9yekFQSjI0VU1NSmU3d0Vz?=
 =?utf-8?B?UGhMc0xXVXR0R1hGU01BTFM0RU1tNndyRENFOTN2dUljQnFpalNiRE1YK09U?=
 =?utf-8?B?NUxhSUlXZFVETkNtMVIzWGE3UHpWUjZ0a0VrRGVyMGtZYkZIWE5ZZWZSTDA4?=
 =?utf-8?B?STA4NkRpNFR1dkR2WnQwQXNiTldnZGJMQUpKRTVVWmlINDAzT0c5ZnlWQ3BP?=
 =?utf-8?B?bFI2STRwa3NVeWVZT1J6cld6Y2Y4cmFodUFZNEZTVUdhWUlCbHZjWUJ5ODZm?=
 =?utf-8?B?bWNIRzVFZDc3MWhWMXhvamdVMUZjbmg3cmFuYlVSeXZya2JLWXV2enJGMWhr?=
 =?utf-8?B?eFlBWGxsRXV2RmNKY2N0MVFIYlpzVjB0NlhBOWlibXdMSjd0dDk5aG53NERG?=
 =?utf-8?B?TGJVMnh0bEJzblJUMEVHZ05nVHYwVDJtV2hJL0Q4MndWRnpqSjJtVFlRYXlI?=
 =?utf-8?B?N0daYmpRbjc3WXR2Y0M1TmdYTGttcmFuS0xMVVlEUFdCN3l2SmVwVkJ1dERp?=
 =?utf-8?B?NklRUDVKUllOUzBvd0l5dXh0OTYwSmw0Ukh1cmJkWXp1OTlwZ2YraUlzc2Rq?=
 =?utf-8?B?b0xHeWUvQVFoUklpTk1NaVdqMkxmVEZqOEtVMEVuRmJyR0ozTGdsRWNwS2Yx?=
 =?utf-8?Q?1F8sov/6vWwYxDNOmj?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b1df9e8-3cdd-4f1b-6445-08de40025f5a
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2025 20:00:06.8005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VTOfi28EkEje17oP/ZOnGXcfanqtLOutSgAGqgYJeMDWwKsjPKsuD2wpnf/swVdU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4822
X-Authority-Analysis: v=2.4 cv=Y6P1cxeN c=1 sm=1 tr=0 ts=6947004a cx=c_pps
 a=wVrytDogCwW2gNy9sPioUw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=VabnemYjAAAA:8 a=VwQbUJbxAAAA:8
 a=FHWzWsagOwG3KEq3DAsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: 08Ec1pLhkRwVhTnDXSluJyYnbLaYSlJk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIwMDE3NiBTYWx0ZWRfX+9fDKWmNpi/0
 0QXIHGH7UfRqs99T8PrRjRJUS5DL7zmTOt3AgH2YJmlpdmNoD/GYcuTx8YkGnOkLj+VbxZeWWhm
 NlzEh4bt8+o8BTizOKYUUpGkFjY0xPeJrsILv4JDsUQVtq2PIWW/egcLcPHcd1JZiQ2zWharYom
 F9Yhb9/pyo+57p1jbmtVLdd6210RjJ/SkAQLRLjGn1kMPD1iU5D/jL9lcHhuJFHukmGjz5n9QCn
 nBv3OPtyJHCKqLrA5qb3oaTfbB/vvBdrkxaoBFCpWiweboAZ+Xth3KSqnpxDHI26aqHUjtdW3rH
 R3KNe3D9UAnmYQU1yH1H8+BKCvG/sn5W/4alhnMuv38yDfFd9keFkxMpRz8RvCHgjoyI7GS/k07
 GwhxvfkjMSDj3BJi1GoFesU7OSdwlmazg9YaeGyxkcPr5FutP6nLXlyXtqSy1ILzyenSE/3ELtv
 hwt5YBcCTcjc1+d5RSw==
X-Proofpoint-GUID: 08Ec1pLhkRwVhTnDXSluJyYnbLaYSlJk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-20_04,2025-12-19_02,2025-10-01_01

On 12/20/25 1:43 PM, Roman Gushchin wrote:
> Chris Mason <clm@meta.com> writes:
> 
>> On 12/19/25 11:41 PM, Roman Gushchin wrote:
>>> bot+bpf-ci@kernel.org writes:
>>>
>>>>> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
>>>>> index d84fe6f3ed43..858eb43766ce 100644
>>>>> --- a/mm/bpf_memcontrol.c
>>>>> +++ b/mm/bpf_memcontrol.c
>>>>> @@ -103,6 +103,22 @@ __bpf_kfunc unsigned long bpf_mem_cgroup_usage(struct mem_cgroup *memcg)
>>>>>  	return mem_cgroup_usage(memcg, false) * PAGE_SIZE;
>>>>>  }
>>>>>
>>>>> +/**
>>>>> + * bpf_mem_cgroup_memory_events - Read memory cgroup's memory event value
>>>>> + * @memcg: memory cgroup
>>>>> + * @event: memory event id
>>>>> + *
>>>>> + * Returns current memory event count.
>>>>> + */
>>>>> +__bpf_kfunc unsigned long bpf_mem_cgroup_memory_events(struct mem_cgroup *memcg,
>>>>> +						enum memcg_memory_event event)
>>>>> +{
>>>>> +	if (event >= MEMCG_NR_MEMORY_EVENTS)
>>>>> +		return (unsigned long)-1;
>>>>
>>>> Should this also check for negative values?  The enum type is typically
>>>> signed, so a BPF program passing a negative event value would pass this
>>>> check but cause an out-of-bounds read from memcg->memory_events[].
>>>>
>>>> The similar bpf_mem_cgroup_page_state() in this same file uses:
>>>>
>>>>     if (idx < 0 || idx >= MEMCG_NR_STAT)
>>>>
>>>> which checks both bounds.  Could the check here be changed to:
>>>>
>>>>     if (event < 0 || event >= MEMCG_NR_MEMORY_EVENTS)
>>>>
>>>> to match that pattern?
>>>
>>> No, the bpf verifier enforces event > 0.
>>> It's a false positive.
>>
>> I'll add some words here to the bpf prompts, thanks Roman.
> 
> I'll try to play with it too, hopefully we can fix it.
> 

https://github.com/masoncl/review-prompts/commit/fcc3bf704798f6be64cbb2e28b05a5c91eee9c7b

Seems to do the trick here:

[ ... ]

  6. Missing negative check:
    - The function only checks event >= MEMCG_NR_MEMORY_EVENTS
    - Unlike bpf_mem_cgroup_page_state() which checks idx < 0 || idx >= MEMCG_NR_STAT
    - However, event is an enum memcg_memory_event, not int
    - Enums in C are typically unsigned when all values are non-negative (starting from 0)
    - The enum starts at MEMCG_LOW = 0 (implicit) and all values are positive
    - A negative value passed to this enum parameter would be extremely unusual and would require explicit casting

  Let me verify the enum values are all non-negative:

  Looking at memcg_memory_event enum:
  enum memcg_memory_event {
  	MEMCG_LOW,        // 0
  	MEMCG_HIGH,       // 1
  	MEMCG_MAX,        // 2
  	MEMCG_OOM,        // 3
  	MEMCG_OOM_KILL,   // 4
  	MEMCG_OOM_GROUP_KILL, // 5
  	MEMCG_SWAP_HIGH,  // 6
  	MEMCG_SWAP_MAX,   // 7
  	MEMCG_SWAP_FAIL,  // 8
  	MEMCG_SOCK_THROTTLED, // 9
  	MEMCG_NR_MEMORY_EVENTS, // 10
  }

  All values are 0 or positive. Since the parameter is typed as enum memcg_memory_event (not int), and BPF programs use constants from vmlinux.h, the lack of a < 0 check is acceptable:

  1. BPF programs using enum constants can only pass valid values (0-9)
  2. Even if a computed value were used, the enum type constrains the interpretation
  3. If a negative value were somehow cast to this enum, the unsigned comparison event >= MEMCG_NR_MEMORY_EVENTS would catch it (negative becomes large positive in unsigned comparison)

  Wait, let me reconsider this. The function parameter is enum memcg_memory_event event. In C, enums are typically represented as int under the hood. If someone passes a negative value, the comparison event >=
  MEMCG_NR_MEMORY_EVENTS would be signed comparison if event is treated as signed int.

  Let me check if this is a concern:

● plugin:semcode:semcode - grep_functions (MCP)(pattern: "memcg_memory_event", path_pattern: "bpf_memcontrol")
  ⎿  Searching function bodies for pattern: memcg_memory_event (filtering paths matching: bpf_memcontrol, limit: 100) at git commit 0f92b93b6e42765a13c933e4e9cb268f8d77cf3c

     Found 1 matching line(s):
     … +3 lines (ctrl+o to expand)

● Let me think more carefully about the signed/unsigned comparison issue. The comparison event >= MEMCG_NR_MEMORY_EVENTS involves:
  - event - an enum (which in C is typically int, signed)
  - MEMCG_NR_MEMORY_EVENTS - an enum constant (value 10)

  If event were negative (e.g., -1), then -1 >= 10 is false, and the function would proceed to access memcg->memory_events[-1] - an out-of-bounds access.

  However, I need to consider the BPF context:
  1. Per bpf.md: BPF programs use enum constants from vmlinux.h, and the compiler substitutes valid values at compile time
  2. The verifier tracks scalar values: Even if computed at runtime, the verifier tracks value ranges
  3. KF_TRUSTED_ARGS: The memcg pointer is validated, but this doesn't affect the enum parameter

  Let me compare with bpf_mem_cgroup_page_state() which takes int idx and explicitly checks idx < 0:

  __bpf_kfunc unsigned long bpf_mem_cgroup_page_state(struct mem_cgroup *memcg, int idx)
  {
  	if (idx < 0 || idx >= MEMCG_NR_STAT)
  		return (unsigned long)-1;
  	...
  }

  The difference is:
  - bpf_mem_cgroup_page_state takes int idx - explicitly signed, needs both checks
  - bpf_mem_cgroup_memory_events takes enum memcg_memory_event event - enum typed

  For the enum case, per the BPF documentation loaded earlier:
  DO NOT report as bugs: Kfuncs that take enum-typed parameters and use constants from vmlinux.h without explicit bounds checks.

-chris


