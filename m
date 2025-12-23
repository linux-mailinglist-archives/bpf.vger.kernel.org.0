Return-Path: <bpf+bounces-77365-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D72DCCD9919
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 15:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD7B93026BC9
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 14:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35D430DEC4;
	Tue, 23 Dec 2025 14:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="UAgAQ5P6"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0FA298CC9;
	Tue, 23 Dec 2025 14:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766499025; cv=fail; b=MO3R3NOEuNktk2XxXlBnWwMGVo3U/A5HKGT5xtz/GSWi+6+g+6BZlXb5IVN9z5ofTPzx4duVcZu5QWuEfN3XzpUh3170qMo/Eu5E8QeWTFZXUS7DGhsA8SPO/angmahrhXNZ7VjuG3xqLLaBs8ZXWz5UjY2Fdc7a/Gvs9dIA9cg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766499025; c=relaxed/simple;
	bh=+Fshz22KshpqVhzmc9kR8WrHHixJczcbO2k3Qu1CoYw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uJ6ktppMrnYAxHK4Ag0JLWIO8Ir0LE2qUSG9Llk6k5iL6WXlZ/6LdI9Q20p54pfmGVuI6ImNTaJh5GRXtEgMn2OU77xvR3Pl3Nhjydx4eBsYJ2JeUK6ZViB7s5Wf9rgMExus7aeINeGElvuaYLoAMPDITcmUdptGljteLuqQUak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=UAgAQ5P6; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BNDtjHO358964;
	Tue, 23 Dec 2025 06:09:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=2uQn5Tt0uLDuof1ujSYBSm68EC1Jn0Nac+ybd/g4Cb0=; b=UAgAQ5P6BCua
	Ht6+ql5Wz1BqAJlgKv5iy8V8YKp7PHLFwqroG/f+Txc2qwbnYJ8rk1pAUqIWsPaH
	i8gjZDKV8moAm/RMssOKjwvZIMjj8tkhTOgBbQi1z5WzXAEBRermgV7l7qNbQQEO
	MoqtL45uCnE9nAY0qka5eya7UTOO3BVYbJyetYLgbwPxMlPgUDeJh7k1BG3dNASo
	oW7+ukl+Yo90j0vBvBZcPOqdAawbPjUsHz2iG1y4N+ho9LZzJG2zbx+x5lgYSWnX
	fKMM8A1+/l1wzJQK4vc5ykmet4Xt8ZfcEzZqAnhpGXk89ZVqi0I86cfSR1P7xmFK
	zu7SnUNWKQ==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010061.outbound.protection.outlook.com [40.93.198.61])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4b7vd50363-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 23 Dec 2025 06:09:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ai+YkIFVA7cAkwQWycLmvgEr2zX1dXhRIKjg8gWTD10pbkodKUo/SvVhq8Z+zOB8GtszMadd2y7wwvXjsgvGRHUbJ+a0MUTHoSk3VtRwClcp+lERY+FMnzG/Zyu8t5lS0tMG4fn7SoYrCEclqIeFZrGUkQA4/hgMHVYlSyQskdrCA4eW5gTj5i2Nk0F1F3oB/qThUsD5CKJOEmP1KieLPqfYK6ovangId+iDzIroVHUpmyIgr86feX4kUc7Ru4lWmN9NKYpsCk5PFyKVMJzx550kiCwybOmm8/Jp3wYPmi6pIi5e+qdjbgwzWLfPnMad/DKErFLEwn33Japj+ZfsGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2uQn5Tt0uLDuof1ujSYBSm68EC1Jn0Nac+ybd/g4Cb0=;
 b=J8xdA9h1y9QktBVRWLZs017853MnEEgnnKgh8kJUYHeg0FkVsqhH3Q+XRPxWMbzRbPINbZ95bL9UCsTBh2ZENGIfGyTVZKoxlGq/73Aj5gvJkRTGJMPrFLyS4Ncoikbjkkfg1Kg/eAr4Zwohkd2rIsqTj6pEbxzCqappvP3lcy9C3Te3rTTXI2HSoP9ExbrokuGx9CJehJBhVDuqAo5PsnNdhiKsbFi5EBWbTgfUxvPQm2ae7LGUriXUHw5mPv2nUXQe7LiyUQcQTk+ymATm3YEQyI0ULX6efVJC4Qgn86GsjkJBzfswdrasYHb0vAB/9KdX49ZRMQvBgRnS/wZm9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by DM4PR15MB5613.namprd15.prod.outlook.com (2603:10b6:8:10a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Tue, 23 Dec
 2025 14:09:52 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e%5]) with mapi id 15.20.9434.009; Tue, 23 Dec 2025
 14:09:52 +0000
Message-ID: <23c71e42-7da8-42ed-a93b-0d81dca99f3e@meta.com>
Date: Tue, 23 Dec 2025 09:09:35 -0500
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
 <87zf7d6ll1.fsf@linux.dev> <93dbca4e-bd58-4b9a-a3c6-595810727121@meta.com>
 <87pl862m0w.fsf@linux.dev>
Content-Language: en-US
From: Chris Mason <clm@meta.com>
In-Reply-To: <87pl862m0w.fsf@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:208:36e::22) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|DM4PR15MB5613:EE_
X-MS-Office365-Filtering-Correlation-Id: abefee20-8e57-4556-5834-08de422cf0ba
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RlJQUVBKSnJWWUlQMmo4L204Y2tLajRCb1JRK0tQN2ppNUNueGtWWHVQV0hy?=
 =?utf-8?B?TkJ5dm5TWE9RV1pjRytWMnV2WGFpb2RJR2NDeWVndDhyeXVJQUtqd214c09v?=
 =?utf-8?B?QWk1Y3J3NTVTdUZ4L3Q1bTRQQzhUZkhUQjFZeU03bnJURncvN094VEFPRllM?=
 =?utf-8?B?QmNYdW14aVN6NGwrdjIyTHMzS2hPRzhwbE1mNUNBVFJ6TGc0bnFQTGpudWNU?=
 =?utf-8?B?ZjcwaXFsZGg1VFB0MWZNZW1kTVJGUEM2Z3U3a3JCWHVpcG5QQlp3K2s1TEh1?=
 =?utf-8?B?bW90L3crWC94VXAxV0Y1dzlGQ1ZZNENUMGhMU2ZYcnJoRUViRGVuZDJkN2RI?=
 =?utf-8?B?Y3ZzUGIvWXBqb010T1BJMkRpTE5BSkZVOGQxVXQyT24rcmhKNTJFMG9NdHRS?=
 =?utf-8?B?Z3ZtWkRjNVFIQTFvZjY2a2s2Qkt2d2tJNkl0Sm1YNFZrbWR4M0duRXBIbFQy?=
 =?utf-8?B?R3FZYmpSakpkRnJpQkNWQ3lWMUVJazhaM1RYY25CelpHNi85U2o3ODZWUDVn?=
 =?utf-8?B?Zm85RlZVcWJBc1lSVjBpYmozRXMxeEhrd0xoVGtvYUllMHU3Z1VUdVoxVStn?=
 =?utf-8?B?cjFCZW8rUEExeGpRVURxd25xOGZjLzQvUTBnZEtWcTkraVlyeHV3UEkvSnA0?=
 =?utf-8?B?dVcyeitVSGFwWi94Slh5akFZNHJrczlRU3NMWU5SK3g1SjlhTkVEaVFrOGo1?=
 =?utf-8?B?bFNiMmdZamVoU0ZvL0JUT3lXZUkwTEtnbVRvSTY5WE9QNUVsSGx4aXlGeDRK?=
 =?utf-8?B?dW5FV1FrdWJmdFVuQkVhamNyRWF4bTZrU3NvMm9jNjdkNFgyNjh1aUtheHBr?=
 =?utf-8?B?c3pMRStybUJCSkFHbFMxQzBMS1lNSXdMU2Z6NzBkNGNjMjFTSzkyMW10SEpB?=
 =?utf-8?B?cHN0b0krUlFLNE9WbTVXam50bDJGSmhFc2hMUktaWjJsWkZ4U1RHdElCdTAx?=
 =?utf-8?B?Nm5VcHl5TitMaFRCQ1ZDRG1kaTFGSXJpYkc4U3ZPRU9LTkhyTDhVSjNtcHc4?=
 =?utf-8?B?aHg1YlorNTdmdFZURXdhWnVvcWRvZHlTdEliQ0VaUHBYVHIvNE5VMmIrZVpL?=
 =?utf-8?B?NFVTQWJCYWhZczJtb3pjR0VNMDY2UG11anU5K1JzOVVuQWVkV3d1THBmSGVu?=
 =?utf-8?B?S2d1eXRLbXI2V3B6MTlPc1ZLOGd4dWtZNEU4RGIrN2RQU3hrbC9iVWhaM0Fm?=
 =?utf-8?B?M3dSaUpHM21aa0JIeFlJdXlOQ2JNQ2ZqNFA1TXZIcVgvdU9keGlraHMwTDN0?=
 =?utf-8?B?QlRacHJWY21hYkFqbFQ5VFV2UVBXbUdYb3FFUUI5REdRMXlKRVNZUXdpNnE2?=
 =?utf-8?B?c3Y3cDdqZDB3Z3dyWFB1N0VQd0Zad3pNK2pYVENvWEZ6QmtGaVNCbGkweEUr?=
 =?utf-8?B?YmM5UkRuanNhMHMrbjd4WDdZbHkzRWxubW0wVmxJdTk1S3VoQTg4djlsYlR6?=
 =?utf-8?B?Z2lPNUdVR0E1N2d0c3ZFcUdZYXlZK0ROTFNXT0lvYW5zZmI4T2F1MDFONzNs?=
 =?utf-8?B?anFPa1dNbTM3SDkwaTVvTThzQ0dES1V2OCszR0dvL0JyRUNLVnpLampDKzNY?=
 =?utf-8?B?eXFFZnQ1UzVIOWlwTzlyR2UrQUpEU3l5aHVhcUtDQVdnVmRGbjRlci9QUHhn?=
 =?utf-8?B?MHlyL1ZDS2x1TnJzTXJKTFJYMCs5b0FzRm9nUUxTMldGZjFEcWpTYVdlTUJB?=
 =?utf-8?B?WHpTRE9JeE9IVldHMmJSUFJ0K2tucjhQNzlLU0tUL1AySjBCc0kyaitYQ1c0?=
 =?utf-8?B?aDQxenBBRDR0RlNqQ0FFWlJBSlBKOURqVjVyQ1hTWjgrbUsxQkRjUDhiVm9q?=
 =?utf-8?B?ZWRBTi9TNC9LNzRhc042aDZ6ZVd2ZDM1RnJxLzNFWlpUN0tjWVZsMzdlVDhY?=
 =?utf-8?B?cWRzNjBBRWdocFY0Zi93UWNRSnBKMUtUQjlQZVNnaEh4VTJkRVQzUzEyemdl?=
 =?utf-8?B?VnQ5NVkrbHc2SFlPVVVTc1RIMzAvL2ZHZmVmSDExRHZtUEhlN1RFZ0xrL2Y0?=
 =?utf-8?B?dkVkODFLZXVnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OW9iUWUwSTdCL0tlbWV6cGhjUVRFQks5TGQ5RlgyVWFGVzRBTUFjYUdwM09J?=
 =?utf-8?B?R2FQYXhqWEdxdHg1M0hyZitYUGlGU2F2RmMvb1VkaUcrWUFTa0NQc1NlR1pO?=
 =?utf-8?B?YTJFWVFiNWZ5emo1VjYrNnBPWWdjQzZ4RUN0dlFqN0FpWTJZZG0yYWZzVEo3?=
 =?utf-8?B?d1pHSzRvOGdZL1hrQktUZk1FZkRGTGFYdFhDdXFKWk1qTGVHeUhRSWNya1ZB?=
 =?utf-8?B?Smt5aVdIMjJUT2Z1U0lxOFZlam01M0FybTJsYWlZakNaQit3OWd4d0JOZGs4?=
 =?utf-8?B?SzVhSFY2MzZhNWpXM3dINVdGbjJmVUNoYXZzRFRkWDJmcWcyOEU3MkdJaC9v?=
 =?utf-8?B?a0sreXBQckRtOU15QVQ0S2ZYYXFhMmZKcm5ZVHBlR1piUzRDU3FHYVdRcHdY?=
 =?utf-8?B?Zk9LZ2NMK0MvdlJqTlNteWZNYWdCZDhFM1FQVWlNbDZPdUJRdUk1VWRxNExL?=
 =?utf-8?B?M25OOXNuMFRWcndzOHBxNFBmQ050b2hoTmEyOTRxQXA1VDdZbUZsYVFyYTRl?=
 =?utf-8?B?cnVtMStsS0NySmR5L1dubzl1OVhiWFRBNDNqRXIrTGpKY0F1enV1ZUZmRXd0?=
 =?utf-8?B?d2VkK1EweGlacVcvdHNFV245RkJ5dXpkWHNwS0wvdDlZVnRYYllVV1ZacnhV?=
 =?utf-8?B?YXZKY0E1RjBUeWFLRFpHM2ExRFY3ZjdpZFhrSXdLWVBqVS9RSmdpeHI3amEy?=
 =?utf-8?B?eS9GVnBRUHBReUIxSEhIaE9EZ2FmYkVaNFVCaDdUS0xPVkpCcTh4aVZDTko0?=
 =?utf-8?B?aHRWcFBtL0xOTjBUU0pWbXZOcFVOWXlnd3Jla1R4M0dkOXdzdXQrWVdIOFpN?=
 =?utf-8?B?NFB1eHBHYWZLeStUVHJwZ3d6YTNyKzNUcytQc0FqSE9sWEdsME5HenhjbnE3?=
 =?utf-8?B?ZGhPOGw5emw0dEpEaHlMSnBaYnJjL0ZVQ0dDWFJvNkRpZUJSa0lqcVFHQ04r?=
 =?utf-8?B?Z1BJdDBtdmFGTjJON0ZUWkdBMXR6SXJHNnA2STRoUnkrc0J3SGVjcW1tdTBQ?=
 =?utf-8?B?QU9naGxRTzYwaFdOb0lpa3packpQeXZycnpWZnp5RDNDeWYzUzMxTUgvRVJJ?=
 =?utf-8?B?VjlnZjZnaFJoN0dkNFUvTnY5NkRtSjVyL3M5RVRLVDVIdy81S2VYb3Z0SE9u?=
 =?utf-8?B?VzhrZk5mcEVzVUt5RzFPcDB2dG5ZTEpRek4rdS9FTzU0TVc2eGQ2aU5sWmhP?=
 =?utf-8?B?a1c2L0NUcUdQblpMWjB2akN4TmdvKzNhRVRrS09rUFNvNnlNTml2VmY0UnVi?=
 =?utf-8?B?bTBEMkorTE9xUVVBY2c2SUJ0dTdlUWR6UjhoM0FGVGNlOFVuSEdnbytuK3FX?=
 =?utf-8?B?S3l6Qk9xb01FMTN5RTJqcFpjSkVhWENsVjFwMEFGc0kwbXdaWDhaNklIVVNJ?=
 =?utf-8?B?Z2ZtMUtLZkZ4alNLS0E4Q3B2Vys2a0lXQVFKREhCMEhsRXQ3QVBnc1c3d1Vq?=
 =?utf-8?B?Y2NWTENDMHpGNWNRRXJ3aC9Sa0NoeWozZms4ODFNc09KMXpnQjBaanN4RC9l?=
 =?utf-8?B?bFFzTmdpRm5KeXR2cFVZMktPZE8vMGVlMTFnYmY5cHd4Z3JFTFhNOGd1ZlJR?=
 =?utf-8?B?djd3T0FMeEhsT01MZ3AvRFFucG9tODhvczd1eG9tYktxUTdtNm11d2R1UlhJ?=
 =?utf-8?B?eUx6djRNb2ptNFdKcXFLenB5R0I1SW16QlRtcVhrN2VWL2hWeUhBcllWRml2?=
 =?utf-8?B?NVRVTzBleW13ZktDd3k4ZlNZWHRaZk0raHVZeTVvd093cklUMUFGYTlZcENW?=
 =?utf-8?B?cVZTTmZTSkVIL3Uzd0FnblQ2OFp1ZkZjWGdvV0twbXJRcnBVcW1aMEpFOUNr?=
 =?utf-8?B?Q0Z3L0ZUK3lyK1JySk55S3RORXlRd3RETFFtN2Jmemc0UlptK1RjN1BFT0da?=
 =?utf-8?B?OFdDaVRLOHU3aUUvKzgrK0NXN1p4MTFrWXB6aDNPb1lPcVlkcE9RSWRjYnBC?=
 =?utf-8?B?a1dIU2MrWlp5a200Y3J3TlJ1ZWVEeUg2cFMvSUJFWG43TU0rSmlmcGNaVWl2?=
 =?utf-8?B?S1RPQUEyZ1gvOUx5NWNwcU0zQytmWWMwQWRmYnZRb2pqZ21tQUUxdlczK0tx?=
 =?utf-8?B?bXdJR0xqblFHT2F0VWVrME1zTkptc1NIaitXVTRaSEpQUm1DZUpKZ1JGcG9K?=
 =?utf-8?B?Q1dvYnMyc0drKzRwZHZUOFhZc3FHZmh2YlV3cU5telFXRmwyNnczWDY3Zy8r?=
 =?utf-8?B?enZwWFhkWW9keEhwSHBPYmRudUlmaUF0L3F6MzdOUkU0b20xK3dNLy9EYWla?=
 =?utf-8?B?L0J3TzZROWpHaUFYOXZTeGJYVUtoVllQdnlxWnlXYjZIY1ZqMjMzSnU0cW44?=
 =?utf-8?Q?oWFnZPU6M6Z8QRFU/i?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abefee20-8e57-4556-5834-08de422cf0ba
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2025 14:09:52.0462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E+bTygbqZH62641ov9TbhQbDQTd3+43MFP1p/HAt6BconaU0A1JjexD2RjyqsjeC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR15MB5613
X-Proofpoint-GUID: e1DiOYzjfWfpLSqfQlddve78a32XSsmL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIzMDExNiBTYWx0ZWRfX1NU9n9Kjo7Un
 2bq0iZOYTvH+a44lECAKeAmD3QmnhhaDrwBIzGjOQSswvlMUO76PYGo4xh/QuYwD0mLmoVrUJyK
 SqWb25ZCAqMsRnOnAsjgQSseIQTD1dp3qRqOWbgtH8j3GyqYIMMdu05FL0bNOG92EKxR3xZEUlj
 p7Mhh0ZUEQ/ZN/Iw7+RzYdP3lfFT9moj3wdes9qTdFxoxkDm0R66weNU8IbPm3vCncvLwZyz+em
 2pl/H+rz0P+37f7Nvo658aDL9Ho8A4qtvasuIbLFVpIZoJPwLKabWD3y4NjnilUv8UTlCONc5U2
 XEO5cKFW1TNB1xp0CakPQ70x8wg50tYlitOgPTkHi6F1rbFMkY6p5VeabP5koHuQjT3hUFJxeML
 VKAcnHBFFXfYdAsoHwYA40ud0aelXTHiRp5xgzqYwEiJj2u83nDGJ2q57CY4Sl/rPEVB2Guj+dn
 5mjrzYzWBZXhCH4foEw==
X-Proofpoint-ORIG-GUID: e1DiOYzjfWfpLSqfQlddve78a32XSsmL
X-Authority-Analysis: v=2.4 cv=QL5lhwLL c=1 sm=1 tr=0 ts=694aa2b1 cx=c_pps
 a=tFiMKzbuKqM0PzijJMXBtQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=VabnemYjAAAA:8
 a=yAGl06ve_2EzpbbmiqoA:9 a=QEXdDO2ut3YA:10 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-23_03,2025-12-22_01,2025-10-01_01

On 12/22/25 5:23 PM, Roman Gushchin wrote:
> Chris Mason <clm@meta.com> writes:
> 
>> On 12/20/25 1:43 PM, Roman Gushchin wrote:
>>>>> No, the bpf verifier enforces event > 0.
>>>>> It's a false positive.
>>>>
>>>> I'll add some words here to the bpf prompts, thanks Roman.
>>>
>>> I'll try to play with it too, hopefully we can fix it.
>>>
>>
>> https://github.com/masoncl/review-prompts/commit/fcc3bf704798f6be64cbb2e28b05a5c91eee9c7b 
> 
> Hi Chris!
> 
> I'm sorry, apparently I was dead wrong and overestimated the bpf
> verifier  (and ai was correct, lol). Somebody told me that enums
> are fully covered as a feedback to an earlier version and I didn't
> check.
> 
> In reality the verifier doesn't guarantee the correctness of the value
> passed as an enum, only that it's a u32. So we need to check the value.
> I've added necessarily checks in v3 of my patchset. It passes the local
> ai review without your latest change. Please, revert it.
> 
> Thanks and sorry for the hassle

Thanks Roman, I adjusted the prompt changes and looked harder for proof
of exactly what checks are done.

-chris

