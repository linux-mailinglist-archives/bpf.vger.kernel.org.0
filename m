Return-Path: <bpf+bounces-62925-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E392B00650
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 17:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31D681897CDC
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 15:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC3D27466E;
	Thu, 10 Jul 2025 15:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ba5iY86u";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rDEAunqz"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2E81F63D9;
	Thu, 10 Jul 2025 15:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752160812; cv=fail; b=AtOmVL2nLseK5n3wwvVILZDr1fe5KDWgyZ70PWNr4o6ViHFKEx9Jja/dnoC46xx0FcZNJZmEc+uYXluofO2aZzupvgvbRNXs8zZ06wV81mmTM9Wb5y1aP3w/UQ2qswzo2ofg43J+O5ByTFhqGZsvsxfRIGwpl1byMTaM9y1JDGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752160812; c=relaxed/simple;
	bh=dgj28Xqk7YpA7e21XVWLCQDcWduWGrK6LAGqKZVCxTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=psckuan/N6XHveIG8iEHumrhFIwuaPNScWxOpkCcUJiP8KLN7PrVvjd0V8+f79eDsCgzudf46U8ox4sfJMlIGHcsuBtEhtDPrWZjIzcJkiKxkqOdgWGC0fV8vkay0LkwPQaYNl5chXDoKqkFA9rDeE8vowZXt+angKbRASAz07Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ba5iY86u; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rDEAunqz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56ADILuG021306;
	Thu, 10 Jul 2025 15:19:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=rEXERqDIaOs9oveY0y0rOCUqv7S8AFnaV6nfwA/X7y4=; b=
	Ba5iY86uhi/6MaFq7+bvD2Gttxb7m+L46M0tCcYrbQdoqgnDhXbFdRX5IgY6OxQD
	hvV/HLoe2F+2XDLrJxvxm7G6Q9y6+a5QwV/+fUKR878vTdHqdDPjBeweUL4anknC
	3dsR+fp+GoeOgwy9VXRaHfKjT0ZL0E9oY0zkfuk6N0C9WjH43tPvV2DbV8g4oTv6
	aL4YsjKkwfRjW7QM4u+W4w8ppbbr2mUAF85auf6HvdGvYbZlymVFpZNLi7ncUAXg
	Zj1XZZ1Z9hrAnCQ8WiLt+wcZVPwaGWep4FXSsPBUq5S+Cou7kLBQfsUHlTbm7Y1h
	sBaK+5g4HWwp+jezMUD+qg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47te8w0agc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 15:19:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56AECYK5040528;
	Thu, 10 Jul 2025 15:19:46 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010048.outbound.protection.outlook.com [52.101.61.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgcncny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 15:19:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ufEhAM7ZuyggQfJKJh4rSRk6+UZ9JAYa3dTRWNovHc+6Knu2bTdxbLziI0wavvW3foqqz/7FuSCDnt6dag/E3tm4iQLiTqFdvFoLonrwYW5Lh/pPtbiVMFkX/bWBiV34rtFXUe1zThGIWKz19J04aIUUTZJDLfW4LcOLtWLT1p5n6y062CyMo8X9vUwOO9nNcaY2IlkggLUAEbdFFsSzeVN3z+VRVJun2uV6l9qx9F14xG9LrJAJNxFuzQPp24HE6hf9boCzZp94cSMQLTl8KIi6UofO+jO+IkXiuafBWWQUnV7FEzdDxeqj1dnPn1luxBF9m7HdIL5pmfRl7/hyQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rEXERqDIaOs9oveY0y0rOCUqv7S8AFnaV6nfwA/X7y4=;
 b=M4uls9295S9sRBuBn2rObLyqwBRsoMqf2tmLTNNzTcdb3+3zpMBpg39Ks53qghue09WujU6Jgi4vjiMTScxZOdgT5qm3+ldH97qr3Pznh/+vC9CAAimx7CEA7QvVoqcSzkhgoZWFLNYO+Q+8GTN7pDt14PjOTv/eHGSFtrH2//YSF9OKRzjdjnj35jAXjKmZo8O2VAJxOHCsoOzsJs0Opndi+XMQe2cr1bAsbaElmINFu3CjEzp+ZmLOc8AEQPWOXsOk7f3vdPf/lELnSQyO5JRXjqUgO2nKkb+tXGj+Cg8htlAy3fqLR0gC8v9J00PQau3Tontp41kFY2D5WcocUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rEXERqDIaOs9oveY0y0rOCUqv7S8AFnaV6nfwA/X7y4=;
 b=rDEAunqzxlqeutEMWs24DcwGqMDURSooBBSRZsTnVKzJPA8KenkM8L/DOBs823LhheLSFgqh0rrItXdf7guulNHsC4kO/XHEtl5zZO5nQULa5sE5TzdBCRSrcfdabBCtWsnRF2bwj/EoXKurk6iYOZWdRcFdUGbuT9mF5jYy5YM=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS4PPFD57E5FBF5.namprd10.prod.outlook.com (2603:10b6:f:fc00::d4d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.24; Thu, 10 Jul
 2025 15:19:43 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 15:19:43 +0000
Date: Thu, 10 Jul 2025 16:19:40 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vitaly Wool <vitaly.wool@konsulko.se>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Uladzislau Rezki <urezki@gmail.com>,
        Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, rust-for-linux@vger.kernel.org,
        Kent Overstreet <kent.overstreet@linux.dev>,
        linux-bcachefs@vger.kernel.org, bpf@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>
Subject: Re: [PATCH v12 1/4] mm/vmalloc: allow to set node and align in
 vrealloc
Message-ID: <aedc2b36-b3b0-4367-aa68-ba9f8a110b52@lucifer.local>
References: <20250709172345.1031907-1-vitaly.wool@konsulko.se>
 <20250709172416.1031970-1-vitaly.wool@konsulko.se>
 <nsacpwgldqdidsqkqalxdhwptikk7srnhjncmjaulnzcf6nsmu@fisb5w4aamhl>
 <D0D76B82-E390-498E-AE84-1B2CA6C0F809@konsulko.se>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D0D76B82-E390-498E-AE84-1B2CA6C0F809@konsulko.se>
X-ClientProxiedBy: LO4P265CA0178.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::9) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS4PPFD57E5FBF5:EE_
X-MS-Office365-Filtering-Correlation-Id: b99456ab-8fa5-4831-5024-08ddbfc5326e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXBvRGVTbHNoUTNrbHB6MVNwRTlIL1JMZmxQb29sR2FSQWdta0hnckduU1gr?=
 =?utf-8?B?K0k1MnlGRUd4M1lRT3pHVGhJUlRaOW9RSk9qZFBsSHBQVTF3bDNxamJlaEUv?=
 =?utf-8?B?R0YwUzFUR1FuWHhiY3MwYzRRaGh6QnRFYUozVnJwZjZpaGNtbHJhc0JzZFBn?=
 =?utf-8?B?aThzTmlWbTNFMU95cTlQUzg0SE9tUEZKMUdqZkhmS3RjMTg3TVQxNVJxVHJV?=
 =?utf-8?B?VlVIZS9GMDAzZTMzTDdKbEVmRzNtTFY3S2xSMmpXRnRTc0hNL1Fxc0FDWkxU?=
 =?utf-8?B?NFVHVlBhTGZhNGw5ZEIxaGFLZmFtSXU0dFZnTlVRamw5aXAvSHdteW5FWlE1?=
 =?utf-8?B?Tkhha2kxTFFKWVBRUzhTV2Q3TGVjejE3VUx3bzBFVmRFc3BYREJ1cm50VEJv?=
 =?utf-8?B?TU9Sdnk0SXEyZHVBQ0thVEtqN0JXeWNqbk9Cc1ZOalZVSE1PalRjUHFwY3U3?=
 =?utf-8?B?eEtuaE1rZzF1bUxKNkRCR3hHeU9UZ3NMZnpveCt4d0JnSzhsdUF0K20xN3ll?=
 =?utf-8?B?bUlpeTdnMTIzdnBzQnhBSXFkcDIyYlM5UGZwL1M2WlpWdTc3QldWTUY4RUZN?=
 =?utf-8?B?a0ZFTDY0cnFwMy9qY05vSWFJbWNhY1BqUHhHamFlRTdUcmp6YXp2eitvNk5W?=
 =?utf-8?B?cldsUmNKWTZ4ZjBLR0FMclM2RVU1TGoyS2M2ejRvRUFxaTRnUzY1ekN0VmNi?=
 =?utf-8?B?Um82NU5sNS9rQjdZc3FvVHFqamw3M3IxY29YdlFpdHBHR3dFcUFnamtMWUF2?=
 =?utf-8?B?OWFieUdEVlF6N2xFZHpBMHJDZnI3THk3OGdlWWtNd2cvRFMyWUlyTEI1ajRH?=
 =?utf-8?B?c2NLNGhIdlhDRlBCTFRCSVNydU9EZGdaeTZ2cnBvNWFoa1Q0TzgwK2ErUHBj?=
 =?utf-8?B?UmxpOFhQZ2dUS21jR0VhUEdORG52dkVuek9pR2dqay9VUmVVYWFzTXRrQndS?=
 =?utf-8?B?emNXaENpUi80NER0WVp3VG1ScURzRnRVQjVURllRUm5xcElDVWNTZ04zZUpR?=
 =?utf-8?B?SUltQ3JXUE8weEd5SFIwdHBxQU82RUV1MG1XZFAwV1hESjlXUkFKZTNxUHBR?=
 =?utf-8?B?T1o4UU5tV1MyRzNxeUYybU9SQ0VoTlJYVUJvUG5teXNKbmYrQlVQbkpaTHBF?=
 =?utf-8?B?VDhxeDQ1ZjVOMDFCQmtyVHpGM1dQY1puell5Q2tVaTdkd0JoZFJNUGlWSzZK?=
 =?utf-8?B?WFU1aWZuMWNyKzdDSzVvSlEzcFRLWTRkNHR0aEFWWElJZjgvYkpuaktrZzdY?=
 =?utf-8?B?eC9aejN2UE8yOWgya01ZVG5NR3FjVjlwd3FiZkFQeEF1MUo5ZjhtVFkwV1R5?=
 =?utf-8?B?aGZ5Uzg1ZmFyRisyemx5Mlllek9Ib0RkRm1aYzB5L2NJQjFYTXlyemhYcDJN?=
 =?utf-8?B?UFRaMk5hUE9kaVpaWkx2NzU5bXdjendWcWxRamc0cU5QZ2NlcUkwSHRWc1Zy?=
 =?utf-8?B?WjA4bjlSbm1PTnRURzB2L0tCaDdYMFVnV1IrcHNZOFRzMXlZSkRjWDJkekZs?=
 =?utf-8?B?Y3lDNHhobFArYjg1aEdqRkJXNnNZT1hxaGZMMjQ3NU1UUHdtbmNMeThtMytX?=
 =?utf-8?B?Z0VmVkRZdzhMS1lEdXhCbkpVVWVKM0h2c1RCTVlNUUUxSGUxM1EvTVl0QU04?=
 =?utf-8?B?WUhQcFVNSHVpa2dod1N6cTRWcjhidWQzVTR3L2hUWjQ1bkZUTzJyNmM3ZDBH?=
 =?utf-8?B?c3lIWkxqUVh0UlJrZUN2WXY0TEM5ZExUd3lKdGFESG9iVDZ2QlZMVkJtMW5j?=
 =?utf-8?B?QmZZZXBsQUdYNnNpUVY4UW1WanRyWWtHQXMvck5qMWRKdmlUR1YyTUQxMWdO?=
 =?utf-8?B?QXdFT0ZHM29EMW1WWWl2UkNONDZ6anN0dnVCNVZkbjJEMlI1b2RNdUtZYzNW?=
 =?utf-8?B?TjdjbTBidVJNQ09SSXErQjhlaGErdnYzUWMzR1Rpa0ZxSUMzU2hkVUU5YkMy?=
 =?utf-8?Q?1MfyT425U+4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SjBncisrRjl5bHZJa2x2MDFqc3pDZDkyZGRPeHJnOXRDQzdGbUdEcExkMFFq?=
 =?utf-8?B?Qi8zbjFHZzNNNkJiQ25IVkkrZUZHU0lObS9hSE5hMnhjcXJmbWNrRFl0bEJy?=
 =?utf-8?B?Q2hsYlkrcysvbkNwUE4zeFE0aEZSZUxrcU1zMVY5L1BQK0E2VlVIU2QrN2dl?=
 =?utf-8?B?L3dHSjdJcy8rYWo4MEFVNGZjSDZsMFBzN1BHc3ltUWNWQVdOeVNoWjJFczF2?=
 =?utf-8?B?ekxVWS9GNGszV3ZvQkRPbTJ5OGsyU3BESnhRT2xtN3NhMUJZMnNhdXlxbW84?=
 =?utf-8?B?aS9aTFZBQzgwdm1FTmFnbXZnckw3ZG5qRUFoZENTUjU5MnhnYlBhZ2hhK2k2?=
 =?utf-8?B?Zk1qOTFrUE93dE5BK3dpcTZMU09ESDkzSmtoZFNPd1I0RExxak5MTDVYSWFm?=
 =?utf-8?B?WHd1dDZXRkF1ZmhtQlQ5cXNzL05hb3hSTllWOE9qSUkvMXpLYXZUNnlOQytJ?=
 =?utf-8?B?NWI5eElsYjFacDZreGliMXRINGdpNGs1T2R3M0hmclBQMk5HejRHNnpEK2Za?=
 =?utf-8?B?Zk1yekpNWlJrdVdnN3RWL2hQOWl6dDYwdnRLWWRHSXBZM21DczlMcGZ6M0s4?=
 =?utf-8?B?MzRsdTJIb3RSNFJEa3NHTWxyQXZuYkJ4M1dnMm0vT0xpbjhyRW1raFpPSlhr?=
 =?utf-8?B?dW10SWlzZE03ckFmVkhQaFNEaFJMUmdPRHU1SWJ3dHdHL1VNTENJOUIwdkNX?=
 =?utf-8?B?eFF5WVBLUm9NYWZTL04yUGtMb3lieXdjZ0JibDg0L1pSUk5GSnlyVEkrSlE1?=
 =?utf-8?B?dFFvd2hic0lZSzdTTTd1bDBORmNjdElqZTRoNjJKaHE5WlVLYjhIRVdOUVBL?=
 =?utf-8?B?aUtwOFBldnhQd0cyOEpEUFJNZDZVVDNmNzdUZU5aRTQxMXFUQk9PVFhMUnBC?=
 =?utf-8?B?Qm1IRDI1M1p0dzJkVDJvVTVlbG85SEVXY0tLRkcva1p5c3BiT1VwOUR0azQ4?=
 =?utf-8?B?ODg4akFxOHNtSUErQm84Y2QyRXVtNktMUFpBTk1FSzBaVW4zbXI5VzBvcFQ5?=
 =?utf-8?B?NndHVzhhN2hRdDhteUJUM2lRdjN0K0w1dkw2a29YeVVxOXNUWHBiU1h6Z3Fy?=
 =?utf-8?B?YmxWNkdRdHkzbi9vMWFGN0MrQ0pyOGhMaEU5eHVMMUxDUDRnRG96SGx0VTN0?=
 =?utf-8?B?cEVON2l5MEpPMHZHUVJHdHUzQ09JSldKSFFIRHhsbDhOSm1aYnNnMXdiUWlW?=
 =?utf-8?B?N01SVXBvSmt1MlpZMlAvclFMZ1dTVnBnOGhNWHlGMGpicE9zZldMQnlnWUJO?=
 =?utf-8?B?Y2J4a3ZZenR1R0VBRGxVMWZkM3VPMk9qRmdJbERZQVBlWnViaVh1dFJtT1ho?=
 =?utf-8?B?cmVLQkJKdCtqLzJhaVlnVzVLbjZJeXZaTzlXQlJHa3RHVGE1WXJrbGJ1SnQ3?=
 =?utf-8?B?RDViQ25jWDQ4aS83T0dPQzdDRlNpUWJFWUlaNVg5MXRwSllqSGUzcmk1UXlO?=
 =?utf-8?B?NWdFWUpDdTNMZ095eGp4bDh1MFZ0amVBb2JTY0VxSVR5aFRGL0FzMVd1cGVC?=
 =?utf-8?B?Y1JSdzN1RmZEMzBEUU9xNVkrQ3l5NUhvVm0zbzBMTUlyQ2ljOVNwOWVJd0Ey?=
 =?utf-8?B?bDArUEtVek15N0tGQ1liNVZnZkJEbGxZSWV3OVFaRTVIZVZFYiswaXRrbzh4?=
 =?utf-8?B?MVVYKzBWT1Y4bmU3dGh3SEtVeUYycHZqOUx0bkxMNlBDWEJpY21IbjNoZnlC?=
 =?utf-8?B?bkhINlNiOWtBbGEvUzlVNVpSYlRrM2l4YTE2eEh6aXFOVE5uS1psYStGSE5w?=
 =?utf-8?B?MzIzUUtiU2JmekMwcWh5cjBOSE1lN2xCVW9PUlRqWWRiTjdyNmlSbkg0MER4?=
 =?utf-8?B?dmNFYU1pRnVXSUU1K25OUVpseWFzeUVnZHBxV0MrZWFpVmFTVDBCMGdpc0Q3?=
 =?utf-8?B?Q0s3M0NkcmVmM0xaWlUyQS8wNWNlOStDcm1PN3lPcTFIZ2dCcWwzaGRVajZu?=
 =?utf-8?B?T0FHT1d3QnRheFd5eTVLTVk5aHd6TXJZRUR3WGxSZmtpSCtybW9ISzkrenVp?=
 =?utf-8?B?QSsyTndyZ1dSb1lzZHNQR1AyTkZGY2ZnZlJPRTEzY0t3WE9MclgvdjJRand0?=
 =?utf-8?B?cWFJT0pYM29OTzE0NzhUSVdzcDJGQ0FLR1RlYmxwV1gzcC9BRzhhdU9VUi83?=
 =?utf-8?B?RHJGT1plWHZ2cXJMbThPczdydzhwSFQwUkJxS3BjdzRxWHgxTlBBL2ZZRGdi?=
 =?utf-8?B?ZkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	I6iSiribLG56L5t956hHmgXbmPuU96k39S7crPvlCtXzhFb5rIYtHJZnzoJOgFGtojU1OsA0dUAiqLnjLmWaU4agB8OTzUk4NIoJidX6nQjmbi0hATCa+H8IHxLubddOU7S2df8BJxB74sZ0NttCkN2Wlxjq8VitNjJSvjHME+e0qT1XGfw0zs5sMi3J2I1Fce7ox86b9KIgnm+QVqq6zsjbMShvk7ZizWSPcODymE4/7+fVkAiqErakH0VThSH8TGPwr2D3RnfQWwhdqjajKYAukjuyX/wB1rFoxqHIFJl4kVChACsLTGNLWLBm7h+3QssqOw1yo99ZWrFJe2V8Xr2sVP1QEXAi1PLnkj2LDnfQ//xJ5Jd5jnyKc69Y+Ii2/bv0QoCZYdvxBFv3zsjupGC5vr6IIAK/KBdlIDeZxmWa0+lvSRzWCN/Dvmo+uJbLq6G8XMUQdiOID6Kw5MCQy6T8ZasurbIE/O6J1i/IloWb8ebAmv0BtsPFT0LxN8k99qNHb4kEKUl+A6xOeUrcJuASiCRra7kYt54TXCqfZw2VTUKRyfAjxw8oEhcGsZUxLvp0g2BVpA7jbQfpVguxtzMytXalpNModtsQH2It9qs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b99456ab-8fa5-4831-5024-08ddbfc5326e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 15:19:43.2787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6LGUw6s3w5V/d16+G2KLH3SfVDDKfBLRRYUQvhc7L364mVaGvvt9ctS9fWCA1aZCcNfm5Okhe6qI4dMCBgJtPsMU5/Blj0SSZT9IS78MJd4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFD57E5FBF5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507100132
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEzMSBTYWx0ZWRfX0/uhztAaMh9Z 1oh8Wiut/VLHNhbpD7zItslkRlem67cCIlqQR2Rj5/SzUcgS1Cq589lJUL8nzijxCC0HbX8tVqx kfaEXmas4/QcIAosFVKLSNwVS9bA3Kx3tyyyAcaDfjZxIKZxfHjQHncjR3de5LpId2OvJU/D+AY
 16FozmIsGFIr+zQPWE0yJgD320cWU9qzSwj1CcjqN6st2wAoE6TAQRJDR0riRFySHfy/R68Beae r3mHiltOXrfL9x3NtK3yBu/1swNvFJJkyCQHmj0XBqASOxVNZiIoAHj6mH5/TFgcrQ00LAB3lPA V2pfZgXcaoZXcroms+/VY3s/J5DJOorcYIEJ9H/1FF8lvUugoHFs6KMcm1rHQcw++BnKniDFxH6
 Qy9/W9fvhfbBovxd/A18WIVAk/btwsHzQzcvYxzBbh/sDNEk4wgf/jLPmpWml93MOI3tFRoy
X-Proofpoint-ORIG-GUID: MLXmFqmCGVhSuIvrCBjceRNAsh2wsoSm
X-Proofpoint-GUID: MLXmFqmCGVhSuIvrCBjceRNAsh2wsoSm
X-Authority-Analysis: v=2.4 cv=O5M5vA9W c=1 sm=1 tr=0 ts=686fda12 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8 a=WicMf2zBfVUbSQQ01gUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10

On Thu, Jul 10, 2025 at 08:21:19AM +0200, Vitaly Wool wrote:
>
>
> > On Jul 9, 2025, at 9:01 PM, Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
> >
> > * Vitaly Wool <vitaly.wool@konsulko.se <mailto:vitaly.wool@konsulko.se>> [250709 13:24]:
> >> Reimplement vrealloc() to be able to set node and alignment should
> >> a user need to do so. Rename the function to vrealloc_node_align()
> >> to better match what it actually does now and introduce macros for
> >> vrealloc() and friends for backward compatibility.
> >>
> >> With that change we also provide the ability for the Rust part of
> >> the kernel to set node and alignment in its allocations.
> >>
> >> Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.se>
> >> Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> >> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> >> ---
> >> include/linux/vmalloc.h | 12 +++++++++---
> >> mm/nommu.c              |  3 ++-
> >> mm/vmalloc.c            | 31 ++++++++++++++++++++++++++-----
> >> 3 files changed, 37 insertions(+), 9 deletions(-)
> >>
> > ...
> >
> >> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> >> index 6dbcdceecae1..03dd06097b25 100644
> >> --- a/mm/vmalloc.c
> >> +++ b/mm/vmalloc.c
> >> @@ -4089,19 +4089,31 @@ void *vzalloc_node_noprof(unsigned long size, int node)
> >> EXPORT_SYMBOL(vzalloc_node_noprof);
> >>
> >> /**
> >> - * vrealloc - reallocate virtually contiguous memory; contents remain unchanged
> >> + * vrealloc_node_align_noprof - reallocate virtually contiguous memory; contents
> >> + * remain unchanged
> >>  * @p: object to reallocate memory for
> >>  * @size: the size to reallocate
> >> + * @align: requested alignment
> >>  * @flags: the flags for the page level allocator
> >> + * @nid: node number of the target node
> >> + *
> >> + * If @p is %NULL, vrealloc_XXX() behaves exactly like vmalloc(). If @size is
> >> + * 0 and @p is not a %NULL pointer, the object pointed to is freed.
> >>  *
> >> - * If @p is %NULL, vrealloc() behaves exactly like vmalloc(). If @size is 0 and
> >> - * @p is not a %NULL pointer, the object pointed to is freed.
> >> + * if @nid is not NUMA_NO_NODE, this function will try to allocate memory on
> >> + * the given node. If reallocation is not necessary (e. g. the new size is less
> >> + * than the current allocated size), the current allocation will be preserved
> >> + * unless __GFP_THISNODE is set. In the latter case a new allocation on the
> >> + * requested node will be attempted.

Agreed with Liam, this is completely unreadable.

I think the numa node stuff is unnecesasry, that's pretty much inferred.

I'd just go with something like 'if the function can void having to reallocate
then it does'.

Nice and simple :)

> >
> > I am having a very hard time understanding what you mean here.  What is
> > the latter case?
> >
> > If @nis is !NUMA_NO_NODE, the allocation will be attempted on the given
> > node.  Then things sort of get confusing.  What is the latter case?
>
> The latter case is __GFP_THISNODE present in flags. That’s the latest if-clause in this paragraph.
> >
> >>  *
> >>  * If __GFP_ZERO logic is requested, callers must ensure that, starting with the
> >>  * initial memory allocation, every subsequent call to this API for the same
> >>  * memory allocation is flagged with __GFP_ZERO. Otherwise, it is possible that
> >>  * __GFP_ZERO is not fully honored by this API.
> >>  *
> >> + * If the requested alignment is bigger than the one the *existing* allocation
> >> + * has, this function will fail.
> >> + *
> >
> > It might be better to say something like:
> > Requesting an alignment that is bigger than the alignment of the
> > *existing* allocation will fail.
> >
>
> The whole function description in fact consists of several if-clauses (some of which are nested) so I am just following the pattern here.

Right, but in no sane world is essentially describing a series of if-clauses in
a kerneldoc a thing.

Just it keep it simple, this is meant to be an overview, people can go read the
code if they need details :)

>
> ~Vitaly

Cheers, Lorenzo

