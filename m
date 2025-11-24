Return-Path: <bpf+bounces-75378-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A40C81F1D
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 18:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E79E34E4B01
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 17:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227E72BEFE8;
	Mon, 24 Nov 2025 17:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Cd+uAzO9"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F5223C4FA
	for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 17:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764006108; cv=fail; b=pSE/2BI/424H7mCwpGXw6QTac9JVwNIgmGEAto7U60k7vXY0UeK6OL/ZPd1uEKo1jSHnKE9LEzwr6dXIppiV7ha/Am2XsILq31tGp1qcHywCVC5CZwk1rRShEySRhcX6UVIq2JMZg3e+X80DNfRTpNR7C4Ofn5CNr+yHPONnaoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764006108; c=relaxed/simple;
	bh=fAHW7wbxPc/aQqMpIC0dv4Zode3igbDiXRg4bBv+pI8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z/mwR39/c/YiTimY8FtSmmbB7k2DDxCLAd2BCXOgkBGUKReOc9fEzXoAhD0NY7cC4An+cRle0cNVUCGbEpmsS4nsNOtl4HhvoDCw/385w1JagGad3YJHcAc9Lk7VGrktHJ/hrJIjGGijwOWFBUSR89rUXf/sNE3Xg9fDxFaEa1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Cd+uAzO9; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 5AOEnQZe043690;
	Mon, 24 Nov 2025 09:41:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=8URGJREV6EEay/oZI7pryEwb0fRipG3DT7cymiC1Tho=; b=Cd+uAzO9MVlW
	C8aorsIrh+jc/NyHmpw78ckXfxINY9vzqwgyQUW0445IBUfhQxg6Gpd5qVpybtrL
	DFkZkc9V3fFiEcWzqzxuV5IWdXMOmYwu6ZDhDIIiaquvqfaXx1n4DHq5R7QnwaTn
	J3Hl5z6OtRb860d4UjwZPkgll3OZLcMLiJxWTnL0Q4+7MN2z4DhRtUfTDY82Lkze
	B4kZfG5/zCMKI6zUK259QuBA/Oc8S8gYpx3tQT/1AUSChdIyflEn0XlHXkozUIHN
	YH8vS6a+b4QtQUhhv4eHUemJRWFowd7mCe8iSCnZrWgAOnz4EuAMKqaQD/x6gOKz
	1XbF1s9+Bw==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012015.outbound.protection.outlook.com [52.101.53.15])
	by m0001303.ppops.net (PPS) with ESMTPS id 4amsfd1ghx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 24 Nov 2025 09:41:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bjY3zZ6/nzt/c/Jveq4I2FTFCe0nT6i27n+0fB8lqSO8jbTF8kxrBWdodjfDwLvTdyrIXRN8U6BM0qlRmuCWgw741RodHNnQ48nk1YlDtk3QUcf7ViKgprTckifY+1lYvq7p/IlHoLd9Ldd89IANkjZSizEgrv9ZGeZU/e5/p62Tokneb43+D36Pn4vaCeUzuFYwL9QgBE9pLhgnn5bGElh1m/AbtAuZC2x6yBi5591b/ZXfOggS6Lwd3fsRlDy/QONjCKpVwrFct1ml0hVCRYwF5bWn83aD6e+nJJMApEpmgyWX2unuSFusMLz5YFKLpm2+4JW3UGEhfRltMzNTIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8URGJREV6EEay/oZI7pryEwb0fRipG3DT7cymiC1Tho=;
 b=i2UPMn9treOo0iMX9NxhaNkcYojUZTaNKL9m7iSQRtmlxNDLnTX/jKO1ZughI3yFa/PKHS3Tr9LG1ISo9/+V9wB1WjFGbOC9FpYz0Ns+4+I4AedSEXPmwSiHp4cUW7a+K90EFOJ9TXunnUzAAPzOjXukfFugoD4bMM95RDi/gXdAn8jvA8yAVMY5TaG96sEiC0U3e9O1d5SeNyX2bW7zw/SQoXSwp2xBvTtOL1PRAGjZC1iZpFTIqYtIuY0kgxElZihAMQNs2Rk0G6xN6n4ZOza785s/MLdmE6VZioUBpeE1zUdKnWVGvHQ9CpGTd6YJMnpjv3PSXOUoa9MoUYV4lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by BLAPR15MB3860.namprd15.prod.outlook.com (2603:10b6:208:279::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 17:41:09 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e%5]) with mapi id 15.20.9343.011; Mon, 24 Nov 2025
 17:41:09 +0000
Message-ID: <a7db8a91-7345-4070-a8c1-7ceba6c14eda@meta.com>
Date: Mon, 24 Nov 2025 12:40:59 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpf: cleanup aux->used_maps after jit
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bot+bpf-ci@kernel.org, Anton Protopopov <a.s.protopopov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>, Eduard <eddyz87@gmail.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        Ihor Solodrai <ihor.solodrai@linux.dev>
References: <20251124151515.2543403-1-a.s.protopopov@gmail.com>
 <02181509c0573bc63b5c111cb1dadb0e9d1577ff5465dcaaa902181a0fdedc3c@mail.kernel.org>
 <0b55b083-987c-44d2-a3a0-a4dfa9a078e9@meta.com>
 <CAADnVQKObG_rRmXW1L+eOzwe5265Gtrz=MLfL+mh4UuiYN_NsA@mail.gmail.com>
Content-Language: en-US
From: Chris Mason <clm@meta.com>
In-Reply-To: <CAADnVQKObG_rRmXW1L+eOzwe5265Gtrz=MLfL+mh4UuiYN_NsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0PR02CA0011.namprd02.prod.outlook.com
 (2603:10b6:208:530::33) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|BLAPR15MB3860:EE_
X-MS-Office365-Filtering-Correlation-Id: 2101169a-dd0f-4530-23aa-08de2b80a72f
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXRRTkUrUGFyUjlQeFNnOGZNbkd2bHVOZGxjVlQ5Yk5VaXVXSFRkbXpsbVNY?=
 =?utf-8?B?cUVUYmNZWk55UlBhRHIxOG1EemVKYXh6TzVYM3BmR0VVM3huTFZmVkhRQU9X?=
 =?utf-8?B?RHpWNms2amhWNnBXRmtLUU1IbXlubVV5eVpHNy9zSlpjMzRFUmxQQ2VrQmlB?=
 =?utf-8?B?cllCNzZQNSt6eGpabEV1dlV3cHdLN3lUYXlqNzFoaGpZcEQ0ZWlxZ1dHQW5r?=
 =?utf-8?B?RjNSV2NSeFZmSTNPUG9SSXVEUTQ3WkY4ckkzQVloNGtDVVB6VkVEei9CcHAv?=
 =?utf-8?B?cW52dUFjM3RHT01GTXZhVUdLc1hEVWNtL2tOM1lsellKUE9yS1FXZ1NmNUw0?=
 =?utf-8?B?RkxPOWZWaVgwTVBFL0hZcDBydnJxdnVVaXhweEd1UUNraHA1MEhjMEszMTJC?=
 =?utf-8?B?dU5ib1NuYUdwNnNPZHUzcGY2T2k0djRmME5rRjFRbm90d2dLRGlOMWdKY0Fq?=
 =?utf-8?B?bFR6bWJvYnQ0cDVLQndhMXlZbTY1RjhpcVJyZWhQVi9YMzZiV0FZcVJEcUln?=
 =?utf-8?B?bmVoZlAramZCbTVUbkl2QnFwZENJUklqMmxwS0MvR0ZNSWwwZzhGMGplTUZ3?=
 =?utf-8?B?M2czUUN6eEpYdUsvcVlRV0ROR2JJbFMybGVwTFNNUHdjTHBid2FYRUNsV3RU?=
 =?utf-8?B?Rlg5dFEyekhaZUczTVYwZFVsREhjdFgyeWVEUjc2OVRScElDMjAvMU5MdDBj?=
 =?utf-8?B?aTVMU1pPL3djR0ZBMDlKSUlnQUJ2UVUrNmVHaUYvd21pVUlRU2FUb2tkQWFs?=
 =?utf-8?B?ZGUrZ3l1elRXNVpGOXprVm5uOSs4ODVuTVozbjlVZ0x4VEtNcnMxbWowcmxi?=
 =?utf-8?B?ZzZPZ3VyUHpDMG9EczBSTUpudFliY01oYU5kSTF2bkFIVVROYkYvQ005MGUv?=
 =?utf-8?B?OUR2L2FGZ2VhNTBIVWZzRTFZWENQRXFkTUVoNDRRenlLQVhWVmxYMU5JTzE5?=
 =?utf-8?B?TFFEOFpwTVlxc0g2MDJUQW9ta0ZmTUd1QXVnbmF2QVU1eHpCRDBOOVhUNUtQ?=
 =?utf-8?B?WStnRFdjWEhvT2lxMVR3a3RJeFVaeVRYQzF2OC9mWnlYRmZrM3ovSitVZ3Rq?=
 =?utf-8?B?RnZKeUs4NWp0ZVFGZlBsMFMwTzNHRVo1dzR5TmJxRXM1VUU4VSs5M2dMVzdL?=
 =?utf-8?B?YTBhTDRWMnU5NTdxY0x3MHVsVGJHOXpVcnFTVzF3S2NEN2hPUEF6T0U4TFlm?=
 =?utf-8?B?VGl2MWRXbWVENjR1TjQ3QXBuRUtQbjMvZ2N5eTRnTVV3L0p2cEN6djZhL0RU?=
 =?utf-8?B?NWtCZU1SUjdTNG9OblcwZXpQZnJkMHRZVXpLeVY5UHB1R3ZDQW1KYVBMU3Bw?=
 =?utf-8?B?YjlDb2M2THZGZWdIWDA3Z3piNGJUa3h2LzdtNGcwU3A3Q3ZWV0RuOWJrQkla?=
 =?utf-8?B?NjZZRUcrYkFsNjB4RjNDcU15K284UVdQZGJlNStSbzJKY1ZHVUFOWjlpRGRy?=
 =?utf-8?B?WlRNWmJRYXB0UC9vKzgvWHJLK1hIWlVTK2t6cXhWTll2VnJUdHdqWGl4Zm81?=
 =?utf-8?B?SnNmMXlLRm1MeUFvWHJLZEh6M0FlYlJZaFROZkZVN1cxSTluR01iZkZWcUhY?=
 =?utf-8?B?cTJPTWVmTE9IYnQreG8rQTh0dzY4NytGWnhCaTlJVGNhZDNLMzNBWkdoSjZD?=
 =?utf-8?B?R1lDRUpxWlJ3V0FvbXN0VEI0QkdTS3hXLzZTYUgwUWNZRkN1UEVSaW9yTjNT?=
 =?utf-8?B?NUthQVNUcnZINGlBQkc3VmZvRFRrUTY2MS9yS1BFKzRHb2JiNGV2dWtxV3dq?=
 =?utf-8?B?cmhkNlAyUEcyUE5uUDNYQk4zUU9McUhOQS9XbWQ3eUNHNG1YWXZOOXpkV09o?=
 =?utf-8?B?VUpOcGNhQU9DSlRTUitTS3hzaXNjS3VkMkRrRkRKRFhXM1JyN2FYRWJIUmNw?=
 =?utf-8?B?OHhDOUxWVUZ4cFFQdEtra3A1cWNmakdkR0QydHN1LzJlVTB3UHczQStUa2xL?=
 =?utf-8?Q?swCvO0bpI5Cgs8BArwYRdelDGSd8LNVo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmNLSHppQy9kMC9zWFhiMFpLeDl1a0poWVZUK0UrMWRnNlR0T0VjYzZSMVBY?=
 =?utf-8?B?Q3BzQzJOUjVDS3RXcWVHN3gwbC95WkZUMzZYVmRtOFpqdG1QWjI0cWU1V3M5?=
 =?utf-8?B?QlRCeFFnbG0rODdza1lkUnBsVVR4LzZmQy9TZGYvaHBpZUZRS3IvTmFzVk1n?=
 =?utf-8?B?RW4yNm8vQkEvTjgvVWY4MlRUWHZaNDl2RVFJcDZyeDRYL2g0eVNDQmcyaGxC?=
 =?utf-8?B?aVJFQlhqS1pWa2xFNEh2TjB4MExJdzZEQUhZeFFjdE1EQ1FrNVpob0gzOFB0?=
 =?utf-8?B?aG03VktkWTJVUE9la2h0OUIveGNuMEhVdkJ6TVh3TXhYclE4TFlWcWIvMzRI?=
 =?utf-8?B?ai9yclBCR3F6cm5zMEJlU3Y3QW82ZWN1MDlyZm9MaS9TU21EcGZnSEtxQkIx?=
 =?utf-8?B?K3ZlRnlySUlPc05QT1kwekxISHhTNzdiSDNDUytZMGl5UVFTeG83cjNLV3Ax?=
 =?utf-8?B?VnNNT2ZuWmQvK2syOGlNa1dCM2RsdkxvNXhFZzNZbVpyODBVaHJXNXk0ZEJn?=
 =?utf-8?B?TzN2ZUx1dVJUWUpuanRNcU1hOSt3bE4wRlNjbmRSVFRxdXFsSStlMnZXTGZw?=
 =?utf-8?B?Z2VSRW9PczN5ZjZnNmVWcThqV200a2xFY1ZzbElDWkZDWC9qMkV1WWJ2Kzk5?=
 =?utf-8?B?a0dBNm04RFhZaWMvNE1LbGVPdzhZd2dzQW5jcnhJT1VPbUU3eGRDbkJHc0x1?=
 =?utf-8?B?eHhUS1Zka2RrUzdUaVBuaUVobUdrWHZiQjE4T0VNVE14bUg3a2lnYXgxeWs3?=
 =?utf-8?B?a2xPMGI5RE94QUhSTDgyYWFjTC9pTDRGZlBreUkyN1hucFMrN3NxSDR5RlJE?=
 =?utf-8?B?aFdFRk42WlA2TWo2WG1zd0VVTFM3WXBidkhwaG85akEyRG56L3R0SzNZdmFP?=
 =?utf-8?B?OXFDUis3NG10VDNZM3Z0SU5Rd2swaGN2SmRDTmxyVGpWbndhUm8vZ1pVZEdX?=
 =?utf-8?B?ZVRhVWxqdkdTTHUvK1Njdkp6RWxIK3QyQ0R6SVNSYXRrcUZkcmo5bCtkc3oz?=
 =?utf-8?B?NGNQdTZVenNNcEZDRXVtZVQ4NWZwWlZuYVY3NXhaYkNtVmlqd1VkQmNxRHo1?=
 =?utf-8?B?aFFrR1o0RTc4aFJ6dEVJMkpyNmZWWHpyUWF1cTFESUxUU0RCcW5YUEVQVHJ6?=
 =?utf-8?B?L2ZCUG5kWmxpenFuaVgwRy9kdCtoYndvMGYxZmFEMlRxQy9MZU9COWFNdUFN?=
 =?utf-8?B?eHhLM0lJa0RZMjZiNmdtUGoyNGFjVlIxSmpWY0xVcTE1L3VEYUMxSThPQlZz?=
 =?utf-8?B?SnkxOEMvKzJ5SmdMakJHWlY2R1NTRUJlNlNhUE9jZjF4Mk1RTEdnOUxHVGRr?=
 =?utf-8?B?R2xvUXg2Y21lUjF2cXdaZnBJekZMWDlkNWpSaTBwOU5ESHFqYXYvbDVka25j?=
 =?utf-8?B?TjRzaFZqRzBMK0hjenhKNURGZk1xakoyVDNCSW4xekdHa3lldWJUUitoUncz?=
 =?utf-8?B?cWxvdDAzRHo4cTFFdFdrWDl1K1g0WlBSVU41WmN2aXJXWHhtM3l1bHQ2M2p0?=
 =?utf-8?B?VzVBd2EveUY3WTNpR2tFb1ZRZ094cDFpSklkTDh0RCt5bHVQc2JMZTR3ZGQ5?=
 =?utf-8?B?VVFXdVhHd3J0NjZJU290MzBqSlRlTE1aMW9xZSt2djFZaXFmM2F1WkpGWi9D?=
 =?utf-8?B?NUF1U0pBRkNHTlZOU0dpWXNmNnYyU0dSN1JCM0FMYy93TUp3WmpmZUI0Qk5n?=
 =?utf-8?B?Qzg0YWZmTjBqYUxjQlBtbjhrMkFEZkxTUjlRb0RQRC9ueTdEUk5meUdXWHVi?=
 =?utf-8?B?OE1rL1hKV2JwbDg2QzB4aGJjTFkzUzhZcVhZYWpwNUdFWDlZbm5Lam4zU3ZN?=
 =?utf-8?B?ditEZmdmVGF2MVBrMkZuRWZQaklPUzhMenFMekdTdVF6b0NuWHRaZ2t0M3I5?=
 =?utf-8?B?cFpacnR5MldkazlKY212aktLcFh4Nm1OV1VQK2FUSFBwbzRrWjlmZkFEa2Ix?=
 =?utf-8?B?WHZLNi9YcWUycmV4eExUU1I5cGpCdkg0R2hhVklIMURib0owQkFKUFNRUS9B?=
 =?utf-8?B?MXpEcGViOG4rUys3RHl5ckF0UEErM0J2aTY1REhuQkZ5MWdDVVpDdVJMY2lQ?=
 =?utf-8?B?WUpzT25takNJdFl2eTh1UXdRNUIvemtPMThoVEpOa2dOTXcxWjJrMXRnQ3Qz?=
 =?utf-8?Q?ZhO2bvo6H0sof6rEEQ25uZZu9?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2101169a-dd0f-4530-23aa-08de2b80a72f
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 17:41:09.5360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s0G054uQ9wpjNfXT2NOkT2D7IZnkO1+x28QWLc8ci+GSzK5j7ZHYs6ySmZ636ToC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB3860
X-Proofpoint-ORIG-GUID: G16a63UaMRk1yreD9MbnMwuvO5l6SLN4
X-Authority-Analysis: v=2.4 cv=a7s9NESF c=1 sm=1 tr=0 ts=692498b6 cx=c_pps
 a=0joluOkswiQ4lQw5hT3+aQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VabnemYjAAAA:8 a=VwQbUJbxAAAA:8
 a=VUZzxFtxbOyOODl_ffcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI0MDE1NCBTYWx0ZWRfX+sUqZfpqD4Gh
 E0Do4/TZybC8Dk/rHemtVmPGg/vKNDg63d5AgZUTnRUYDNU+gzQlT1aqi373LkMJbsFZq7jUhWt
 KkH+fMZU27EcqgWW+AYiREtbkbihzthSqQB5i8It7daCi3dKauAFV3gsuHG2jTh6VXklJ591mvc
 6Bq/Wz12zfTvob86tBfCBtOozT/yhNGGWuHOev+jGLiDvCVft9h0h5+tZMi4/4JbJiWyvKuO/Pu
 dBH0V2QejtY5MMaPMnyDMrjkCQ7RdaV+D/eiErk6tIUcsMSfsHPp83tSK0b8MSI+xFjgf7R8T+c
 vsk3oO8Ifqmhs4QIM6rHhI4eQAAagmhygeGf2mBvQq9KScmSZhCaMx8o88Hetk/g7GzFZ6eVJW6
 HBTX1k2peUjOIK/s0eEOhi5jThP/Qw==
X-Proofpoint-GUID: G16a63UaMRk1yreD9MbnMwuvO5l6SLN4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-24_06,2025-11-24_02,2025-10-01_01



On 11/24/25 11:55 AM, Alexei Starovoitov wrote:
> On Mon, Nov 24, 2025 at 7:56 AM Chris Mason <clm@meta.com> wrote:
>>
>> On 11/24/25 10:30 AM, bot+bpf-ci@kernel.org wrote:
>>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>>> index 2e170be64..766695491 100644
>>>> --- a/kernel/bpf/verifier.c
>>>> +++ b/kernel/bpf/verifier.c
>>>> @@ -22266,6 +22266,15 @@ static int jit_subprogs(struct bpf_verifier_env *env)
>>>>              cond_resched();
>>>>      }
>>>>
>>>> +    /*
>>>> +     * Cleanup func[i]->aux fields which aren't required
>>>> +     * or can become invalid in future
>>>> +     */
>>>> +    for (i = 0; i < env->subprog_cnt; i++) {
>>>> +            func[i]->aux->used_maps = NULL;
>>>> +            func[i]->aux->used_map_cnt = 0;
>>>> +    }
>>>> +
>>>
>>> The patch correctly fixes the use-after-free issue. However, this isn't a
>>> bug, but should this have a Cc: stable@vger.kernel.org tag? The bug being
>>> fixed affects released kernels where bpf_prog_free_deferred() will call
>>> bpf_free_used_maps() on the dangling func[i]->aux->used_maps pointer,
>>> potentially causing kfree() to be called on already-freed or invalid memory.
>>
>> I took a pull request for the review prompts this morning that adds
>> Fixes: suggestions and verification.  If Alexei or others here would
>> rather have this disabled for the BPF reviews, I'll make them default to
>> off.
> 
> Disable it pls.
> In this case Fixes tag point to a commit in bpf-next,
> so nothing to backport and, in general, we pretty much
> never do "cc: stable" unless it's a critical fix.
> I believe Greg and Sasha don't rely on cc: stable much.
> Automation will figure things out based on Fixes tag.
> cc: stable is an additional signal, but not mandatory,
> and we prefer to avoid extra lines in the commit log when they
> are not necessary.
> 
> Fixes tag is a different story. We definitely want it for fixes
> and related changes even when they're not necessarily a fix.
> But a generic AI comment "should there be a Fixes tag?" will not
> be useful. If it can say "Should there be Fixes: sha ("bpf: ..")"
> that would be nice.

Agreed, it shouldn't be hard for AI to suggest the Fixes: tag and the
commit being fixed.  I'll work on this.

I've disabled the Fixes: prompt by default, looks like one more review
got in before I turned it off.

-chris


