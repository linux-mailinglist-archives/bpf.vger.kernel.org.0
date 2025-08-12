Return-Path: <bpf+bounces-65444-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AB7B22E96
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 19:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01C9C164B97
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 17:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637E22F657F;
	Tue, 12 Aug 2025 17:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lJaKn0Rr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SdUoV7JI"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC739242D74
	for <bpf@vger.kernel.org>; Tue, 12 Aug 2025 17:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755018558; cv=fail; b=HUlxK0s2scRwuhvHE28kfvuDJe8i0sB00DxBD+C0lkT+M1p6ZaczPrc2Uecv9RO+s8dRMuznnL810waEf+WyD2OejtsIIigLTYzflbBEjNcKBzLk+f35/KrB72LsevK0yWOEnlQQ7imkAmR9LFLNjk1j9/2lPCWvf0BB4guNzbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755018558; c=relaxed/simple;
	bh=hNEdqCJybbuh/aTZlkuST8XfzFlKRyT/ONa+DvJBD6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dbY+wsaFWWKCC4rEOLGdiAlWOy/tzDiPRMmJSK+v6gMrA9XNLCjV08szR08tz96CGHQxKCmcto8K5Yyt93Oxk27bRXOeW8Z450PplIDkc6auP7kY0vQTpA2zN39/m7RMaN706fVJgyQgRBzHp6ERq60mJsw0JKxif/8QfbXi+sU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lJaKn0Rr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SdUoV7JI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CDC0E2007853;
	Tue, 12 Aug 2025 17:08:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=vSCQWwpiSeg/6k/liY6BezYXDR1Nxfps+7zGaK4esMQ=; b=
	lJaKn0Rrpp1yvj7je9yq5Jf47lqcmqps7nq8JC2APkb3FGIeciB9Z3qpgv7QSlNP
	dqY4zV+6G8/nHkD40ZakJYcGJ/zQwEY5zmS126LILV9PzkT6dHk4JP4ey3NILgMV
	Xa3RQJ9YvcWyF2UbZwbTq21KCBNa9QvcIGb4Q439BtXjUcPVmrZjqkDZDoBBGllQ
	ffeL42Bkw8smTbX7tdAV2jBvb7N/5iTsLloOAuOx+x8H3UYWmbk1i1azaX+wLTl1
	00yudsEKxdrVoOGMAMzavLmDJxNuacZLCwdphrJ6KKsq//9Dlrx7kQWBbu+yN7Qb
	6O/QVjVNvOBqbtWYr7MLAA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dxvww413-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 17:08:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57CGHHiE006444;
	Tue, 12 Aug 2025 17:08:51 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsa1s54-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 17:08:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PCCNCOeC2KqTwLX0NQXDkhR7F1xcSIljz4+DKcJxDSVA9fux8S2XvUw3zmQI3zZntkUZ/c+U8SxN6qAtO7Y4Ypuc7f1j93ILNlYblrMqwSkGYwpWjSXogOiNJiT01tzVtJEzt8kBSgg80vCteTUUbA3QgwdUr1v/FxpoNxCyxGsO/m6dp6JDFL/Vc/EBIftTLVSar4YDhnLE97StZf91F8v9r0aIuu7Kbm1+xVzS0l0rczAF3SgJL2Z4JkWnXstP+vl1LtojC7s0X8NJBAboGhTljErKpmaYvwnFMx7oOdyRjfoUazEHWKuus7ZEeITT2EW7bxScX83FXftpomJ74Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSCQWwpiSeg/6k/liY6BezYXDR1Nxfps+7zGaK4esMQ=;
 b=mfF/YYE4RvBcJ7Q63z5ce4bOvDCux3cOni2Wip5WsE/ceOQxO1RyCyVrQL0ohRiy6CbghRF4NJufqxiEOt+ySEQxYoqy4YxWjC7vEK0GlFMG00HKZoyFtydcNLH0B4QNC8ZpzuVM4mwArGRHWx3mXgoFL0OfZxKIeEsC1XeZnhQF3HYs0pdPj6hGJ7RkuLrlqISnu68pqfcvGGqJMxgRr5JFdWVp8pi8/2MC3PdSxRXgAOO67nfe6OpgDLPmDxfSR/qSx0jH36gYR002jk5Bdah3KAHEP90xg7HoZVIpELGPxFgTFSA1n6F2IJUDdqgR7oCuMnF0kBtoRqvPT7OjAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSCQWwpiSeg/6k/liY6BezYXDR1Nxfps+7zGaK4esMQ=;
 b=SdUoV7JI5rcAkj//cX/HmZM1d9yYxIBa6AgRcj7TSovlbY54oEauApV5KyslSxy5YtWLmiihtlVgKZVgyQsYFHTxyfmhktf75dl/fDfsPOyPBFfJYrGDOgEakSi7oqgLsE46758blac3VEipIVG83DZbY8IgAdgFJozyxya0KE0=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH0PR10MB4741.namprd10.prod.outlook.com (2603:10b6:510:3d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.14; Tue, 12 Aug
 2025 17:08:48 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9009.021; Tue, 12 Aug 2025
 17:08:47 +0000
Date: Wed, 13 Aug 2025 02:08:36 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeel.butt@linux.dev>, Michal Hocko <mhocko@suse.com>,
        Sebastian Sewior <bigeasy@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v4 6/6] slab: Introduce kmalloc_nolock() and
 kfree_nolock().
Message-ID: <aJt1FHnavjRv5CzI@hyeyoo>
References: <20250718021646.73353-1-alexei.starovoitov@gmail.com>
 <20250718021646.73353-7-alexei.starovoitov@gmail.com>
 <aH-ztTONTcgjU7xl@hyeyoo>
 <CAADnVQLrTJ7hu0Au-XzBu9=GUKHeobnvULsjZtYO3JHHd75MTA@mail.gmail.com>
 <aJtZrgcylnWgfR9r@hyeyoo>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aJtZrgcylnWgfR9r@hyeyoo>
X-ClientProxiedBy: SEWP216CA0043.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bd::13) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH0PR10MB4741:EE_
X-MS-Office365-Filtering-Correlation-Id: 5371943d-2f35-4788-adff-08ddd9c2e68a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d2lQMWM4VUlnMDdNZ2gwbE9neVByVGl6eU05cXBMek1uTElxa2hSK0VGcEJp?=
 =?utf-8?B?cXUrVm9hMFRrUHFBalNTbnc4aXh3MGNodm9jWXhsMlpJb3dPdXBPd3pkbzNW?=
 =?utf-8?B?MEJjNXE4eHMyT0k0czlBSmpQRHNrUWJpMWZHVU9mQ2xDK29iS21zY1AreDdw?=
 =?utf-8?B?YW82eFprZ2hGZ0FBTFovc0xNS28yaGd4cnJZTlhMaGFJWFk1d0lIcmN3MnBy?=
 =?utf-8?B?Si84cXVKUXpWVnZ6c2xDWEVzV0JtWTRDMGtaS2g4NUc3U2VrbFFQRFBaa2I0?=
 =?utf-8?B?aVFZM004amtYVHhGa1BxeUJLbTFLbkJmOUVTQmh2bk45a3lXNEpKNmVNTHlw?=
 =?utf-8?B?V3dpaFRnRFBDOFVCamZCVFBreFJPTjdRVEVFSjdDMnpHOStyUEhqNnZHYjE5?=
 =?utf-8?B?Mko2dURkWFZoK3F1K094VDcra2FRdG5OamIzM1RvdUxJbDJNSTdNOElCeGxM?=
 =?utf-8?B?WGI0d25MSUV0b3M0ckVaSk1CZXkvVFB4QkY4WXdHQXU5UWg4VGNQTDVEaWZM?=
 =?utf-8?B?NUkwWEM5eGU3UnZvakJ4Nm5sdUZQOWtOZ0RYOGZ2ZUQrL0xpeEpJY3N3VFlJ?=
 =?utf-8?B?Sm12TEd0dlJLQ2pKVU4veng1VXgydG9zUW42WnF6c080aHZmcmswN3EycThU?=
 =?utf-8?B?UWcxTUErWFljTmxRb3VUeGMrMTFlM0VYcGp5dHQ4ZTRpYk1lYnZRQWFFMmxq?=
 =?utf-8?B?dnR1b0JNNHBndEh3UGsrcDlCN2Ixa3ZKdnRpTFBzM29BUHlKVWp4QWpxRExO?=
 =?utf-8?B?MVdES1BSVXpwdStPdFRPRjFnVGpFOGRjVjZ0a2hBdWFMQ1JEbHMzM2JwYXF2?=
 =?utf-8?B?Zm5JcTZ5cTgzaVhuSzJ2MGJDMUdIN2RMRTVINEgvRFhXWThQZWY3a0FTVmpE?=
 =?utf-8?B?cTZsL1lLQXVXdmtFUExITStCQ3JSZzJ2MHRIb2xONHhadzQvcGpLenFlMkRl?=
 =?utf-8?B?SHRoa1JPSW5vTGtZaEZ5RUEvcERxdFNlbTA1eHowc0cyS1BnVzQ4d2o5aFN5?=
 =?utf-8?B?N1YwSWhXazZMZFFiWGVDOG92TUVLQkNXM2k1WVdEZmtyVEQweVpsL016ai9C?=
 =?utf-8?B?ZHdlODkvV01TRUs2anh2aEl6OEgweEMvRk91N1ZHcGxqaTNDY0RadTFnazUy?=
 =?utf-8?B?VTlEMzd3YUptZCthUkV6WmdvSEY3a1A1Ymx2Q3hZTzAvMUt1K3BRSmxWTmlZ?=
 =?utf-8?B?MnFWRGY1WVhpZ25id0QybXVEQUdQaks1cEJ0ZFcwRGRDSWh3TFVpUjZ4Z1Jw?=
 =?utf-8?B?L0lub3MvS3J5czU2ZENNM3pteXBVamxTNkZWSnQ2eGg4b1JuQzZ1blhuNHZz?=
 =?utf-8?B?R0ptYXU0Ny9YbDJOSnRoSi9UR2FkcHc0Z1dpQkdPa0dkZXBSb1FpOGlXSkNK?=
 =?utf-8?B?QUZZbEM2a1N2Ulc3SDlCdlI3WHJwUk84ZDAxU0ZEZ2xmazVGekhhQi91dXMy?=
 =?utf-8?B?TWFKMTMwbHBEVCtEWGF1eHlOWERFOGJyb3JMWmsrbVZXTEVsbndMUTRkMTBp?=
 =?utf-8?B?cENCZzU2YWlYVVM5SzIvS2xtQ0hoYjUzcHg1Y1pkNEI3MVFrR2VNNllJVmda?=
 =?utf-8?B?eWFhSlpQOVRQQVNSVGI5amhPK0tESTM5YkIraitQemF5a2FvQTg3NVN0MU5S?=
 =?utf-8?B?OE5KZnpYUXVYQ3VIL1ZyNnV2enVOZGlxRjc5QzJNcTBndjlpaERHd1h3UmhE?=
 =?utf-8?B?a281YlRvVkhFbzJjdnMvUWs2ZXcxOENZYzVHVG5wWkp4eVN3cmNjdG9WZDVZ?=
 =?utf-8?B?MjJxSVZCMjg5bXpzUUwvb2dmdHQvUVl4bHJRWjVEU0tZMmNPVFYzM3JxSFFj?=
 =?utf-8?B?a2dkdFoveThYT2VxVmx0aTNaamVUS0o4Tk04a2h0emJEb3Nmb1k2bm5PbTVV?=
 =?utf-8?B?SjJIVmdaNmVsRllXR0duQ05xZ2xldTNzWEVtVE9HOWlGcVV6QkYvQXFvS2NZ?=
 =?utf-8?Q?t4G91FUt3uI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1UzRDNRU3pRLzBhS2dJbnpiRnRPVlRXLzdwdDZHSkUwK0lIQTdGalNVTGdG?=
 =?utf-8?B?SFNpYzN1RFloT09QYUZnU2puSXozbHJoQVM1MGtXTmJNWkhOU3lmSGpaTFVp?=
 =?utf-8?B?ZXJXWnFrSTNIaTlMOGxLUE1SWklqanpsSCt2cW8rSHdyWlU4MUNWQXJQQW81?=
 =?utf-8?B?KzdTN1QrdmZUclEvd1hYdnJ5anAxeTQzbFNBTDlXOGx0QmpzWDVsUklEZlI3?=
 =?utf-8?B?QkdYTS9iSTZGR3JlOGVDRUNTS00zZFh3UVpZbEJoanIyd3gxNjNzTDJsblRt?=
 =?utf-8?B?aFJ2MkJBMjBwL3VzMDZ0akwyWnNkdW5BZG5oTVlFSjRxSHExajVuUnBrSVpC?=
 =?utf-8?B?cnlnNWQ0R3A0Q2pMa0ttRFhqamZOSE1kT054Q3lwbGZjeWNnd1ZEc3d2RWxy?=
 =?utf-8?B?eWZFZTl6MkQwejExdGp2aVVId01uMldpZHhIMEdCYXI0aDZXU1RYeHdQVW9G?=
 =?utf-8?B?aFVvWVhHM0hqdGFMNThSMFNBT052SWRhdndQN1JiYm1yRXh3ekdFUE5Yd1d5?=
 =?utf-8?B?bGIzTEZ1QzFUWjdhU0R4VHI0TFQ0bSt6YXRaZmZDNm1zeEZsTDBhZTVZeXgv?=
 =?utf-8?B?R0NJQjhwcjlTNzJkUGprTWs2ZUxHLzFQeC9uYkZBWEM3NDVoZ3hxZHUwUklB?=
 =?utf-8?B?Y3k5VFpUQS9NdElKend5eGlYUnZDd3pIZTJoNUltYmRUVWgrMDlMODlWRm5W?=
 =?utf-8?B?MmtSM1gvNGFxem5BaWR1ak5jbFFYK2xWc3lCVGRoV0VyOHdpMTRTMnZkVHl2?=
 =?utf-8?B?NFBFUHhiZDZqbjUveGQvQTV4MGFWRmdkVm5GTllYMHJzWjhUSU5Gc0ZvTEsw?=
 =?utf-8?B?UnBrcm5rL1ArV2djWEJlb0RGZ0tRQndyaGJudHVTZDlLVWZncUo0eTBTUkls?=
 =?utf-8?B?NEVvcnd2SE92V2x5REdZZmhCWWwrQjlzclpDSHAwR3NYS0c4cVBlcGpOTFd6?=
 =?utf-8?B?MXp0TUdFZ0tQWWYrLzNEVXlyT1pQclExRUpZcHA5VUlxdmhyVXFaRkU4Ujkx?=
 =?utf-8?B?ajVlT2pTM1hkZmMzS3Yxa2JFdDlhRi8ybEIxWEZ4cWhKMHkzeTNJRUJ1bmZH?=
 =?utf-8?B?cXFsWE1tclFkR1AyWXBMb1FsTUFvdnVPbkMvaFUrd3AxbWZubnhJOG9oMDBY?=
 =?utf-8?B?aW5sUGZ5djROTzB3STU1dXFhYkFqQ1ZmcUM1UmorVWd0OUFJMWsyRW9xOUpZ?=
 =?utf-8?B?czIrM3BSZExraFNDeWhBdzJKeWdBZ1F5dDBLU25STkpLWVJSSVBLWGFITHFq?=
 =?utf-8?B?cnk0VnJMRVFoR2lQZktRd2laWDgxZXQxWW9xOHJZcjIxNG0xQWpISEw3czFj?=
 =?utf-8?B?VjN2dW96VTN1TmFpVVdLZ3RVdHpWVlVrcmVZaW9YMGpvNzhqSUR3RHQvbWVD?=
 =?utf-8?B?ajFuK3ZNZkQvRzloaTV0ZHNteGoxLzdLZFhZMkc5Z1l5QnVYSU9QZ252cFlJ?=
 =?utf-8?B?ZitsQ3FjZzBFQ1VHMDk4d0dxVkRzVTBHaUN5QWpqcmsxWEZkclNsUGcvQTl6?=
 =?utf-8?B?T0VybEtOUGpZaWR4RzdXaXE4K0c4YUx2VUcxSzRtdGtSbzlKUjB6cXFzd2Fj?=
 =?utf-8?B?eUV3bEw3eXZ1dmJ6S2tHQWx5ak12empBaTZDTDA0cTBzd2J5Z05FbHJWWWtS?=
 =?utf-8?B?L2VYYXhRT3Fzc0h3c3lMNk5LOUsraWlXYlY4WUJ1bXFYNW9pTUI0ZCs4M3Vj?=
 =?utf-8?B?SUN4UFB3cWZkOFJWTnNHNjlKN0RMRVpmUmZlV2xrN1paVXlIMVRYN2syTlZi?=
 =?utf-8?B?WWhHSUczN1BhWU8zeVM2RnorNUF4aEF0cS9MMGNlbUF6UWVzSithRzFueXJE?=
 =?utf-8?B?TEVBQVpXK1RkUFpxTU1SQTFsVW14Rk83d2Z3K3BSMi9oUk9JcDlXUmNjejBK?=
 =?utf-8?B?SGpDVUIzZ3NvWldCVlFCWWx3SW03Y2hnN2JYYXVKSzdqSGpqejZpYmxnYm5K?=
 =?utf-8?B?Q1drWUpxYkJOZVlxa1hyMFpMUHRWRllxb1pTemJMSkhCUDYzeWFIZ2ZuOVY4?=
 =?utf-8?B?eVV2NDlXOE9yN3ZHb0pRaGRMR2dSdmdSRnQyMkc1WDRPcEVKZEFQc3l3dDBi?=
 =?utf-8?B?WWJHMVNlc21vS2lYTE5kd09TL3VTeWpqeklDUVJnbHE0OE82YWZkSXFwTGpw?=
 =?utf-8?Q?W+AwptaBXLLdEwSAIQPkTGYtJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lhQVt/ieJ8wOc6fHoVaf/xYc2Mql/SEByrbP0hbeRle/45H9xMVA6BQ10xlph7UysFB5UIDJqy4xYtWCBkz0J/iNa+kD/NLuBdSgH3W78ENksrkHQ9O4wynPAUFbZFF2Bg6SGBJmNxmDLG1oxa6Qnc8V0vZd8+JQkBxBb9AvEkaSXBPxXofGurlOeZXIsg85iLjblOs/h9fgZ+dOOeL5LFGVWu7SzHTAb5u3he543sUdRqw0AMukslyYM17Yg0o7RnHDzCqrZRUkbR72mwGyUgk20Hxunp8Zb/AdkCCDJkdGwS3oz8U9vfsvHbXBAIJGuDP34pQSjAoby61olv+A0xZVb2VfmhB8zkpJQrLxiaIkh/MelPXWt+07967e1R3WdeUp5vQoUfdFtYvfgTk3LYw8CU3HV95fR35FEgOtGhLWcjA9wbRbL7SUwHb/cdirE8/nMbhbYSSzldDbHqo2Q0u5G8lHvxWVAYOw80PZAJzF5g3/JyzPgbC9LWukLvhcz7aScks5oIngQm2nENLZW0jENRHGUJ1DwOyKg/olNyU+2JjwCmfyvsV0yhF4az60XT0z8M6vkCxLCsc9U7GhJEL/Rq/bf8lDeR7E5rszRaY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5371943d-2f35-4788-adff-08ddd9c2e68a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 17:08:47.5194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VQ/HYvBeG5Gqbf6rVBagrGsQFU5fCUf7pqEhyaecWkvt9KXp7S4HursblEOVO5iepC9JTL5riXXCQrlrO1UieA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4741
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 spamscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508120164
X-Proofpoint-GUID: T54cOxbJuVSEnOC0v8bsdApZF9Un_yRh
X-Proofpoint-ORIG-GUID: T54cOxbJuVSEnOC0v8bsdApZF9Un_yRh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDE2NCBTYWx0ZWRfX+S0C01RfrNQc
 2zWu2AS/MaMLi9gvNtRM42qdy7F/VbdB/uXZf7JVZd3ao26/0GGhpDsAMWZsrGsG0ob2OxTLoJ9
 2VgwFlPsQFfoFeLocAnYHSC9qygbkKf98OnkCJKojGOo7vrEgMUKohYMQfRzZrL5+x8EJa3UwB7
 SUmKhe7kuKguTSerkf4/lLbav9gkr3TmXoNLv6CS3pyx3ho424zFIrnfj8zJD+b8MKLe0bGMDjx
 7mexzYVZZ4bct2k4FHiSSl0yd4uBcmQQViR6on/uGqz6c6oiptwADL341tGU5rKkC0Thoogb5ok
 n0TUDIN0GdsMWX3GMGIC++1NXuA9wEbhfMwXD0xpvFyzUB0LmSiBOnlJ9dCEGd+yx0b9Mfw4pCs
 dT6gui7n0ycdznCVT6qUixbLeMA59jsmvQNhz3TjxJnkMuCosfT+HBu82lZQwmIOMBVW4rta
X-Authority-Analysis: v=2.4 cv=dpnbC0g4 c=1 sm=1 tr=0 ts=689b7525 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=u_yLzlMnM3ZEJNpmmnEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13600

On Wed, Aug 13, 2025 at 12:11:42AM +0900, Harry Yoo wrote:
> On Tue, Aug 05, 2025 at 07:40:31PM -0700, Alexei Starovoitov wrote:
> > On Tue, Jul 22, 2025 at 8:52 AM Harry Yoo <harry.yoo@oracle.com> wrote:
> > >
> > 
> > Sorry for the delay. PTO plus merge window.
> 
> No problem! Hope you enjoyed PTO :)
> Sorry for the delay as well..
> 
> > > On Thu, Jul 17, 2025 at 07:16:46PM -0700, Alexei Starovoitov wrote:
> > > > From: Alexei Starovoitov <ast@kernel.org>
> > > >
> > > > kmalloc_nolock() relies on ability of local_trylock_t to detect
> > > > the situation when per-cpu kmem_cache is locked.
> > >
> > > I think kmalloc_nolock() should be kmalloc_node_nolock() because
> > > it has `node` parameter?
> > >
> > > # Don't specify NUMA node       # Specify NUMA node
> > > kmalloc(size, gfp)              kmalloc_nolock(size, gfp)
> > > kmalloc_node(size, gfp, node)   kmalloc_node_nolock(size, gfp, node)
> > >
> > > ...just like kmalloc() and kmalloc_node()?
> > 
> > I think this is a wrong pattern to follow.
> > All this "_node" suffix/rename was done long ago to avoid massive
> > search-and-replace when NUMA was introduced. Now NUMA is mandatory.
> > The user of API should think what numa_id to use and if none
> > they should explicitly say NUMA_NO_NODE.
> 
> You're probably right, no strong opinion from me.
> 
> > Hiding behind macros is not a good api.
> > I hate the "_node_align" suffixes too. It's a silly convention.
> > Nothing in the kernel follows such an outdated naming scheme.
> > mm folks should follow what the rest of the kernel does
> > instead of following a pattern from 20 years ago.
> 
> That's a new scheme from a very recent patch series that did not land
> mainline yet
> https://lore.kernel.org/linux-mm/20250806124034.1724515-1-vitaly.wool@konsulko.se
> 
> > > > In !PREEMPT_RT local_(try)lock_irqsave(&s->cpu_slab->lock, flags)
> > > > disables IRQs and marks s->cpu_slab->lock as acquired.
> > > > local_lock_is_locked(&s->cpu_slab->lock) returns true when
> > > > slab is in the middle of manipulating per-cpu cache
> > > > of that specific kmem_cache.
> > > >
> > > > kmalloc_nolock() can be called from any context and can re-enter
> > > > into ___slab_alloc():
> > > >   kmalloc() -> ___slab_alloc(cache_A) -> irqsave -> NMI -> bpf ->
> > > >     kmalloc_nolock() -> ___slab_alloc(cache_B)
> > > > or
> > > >   kmalloc() -> ___slab_alloc(cache_A) -> irqsave -> tracepoint/kprobe -> bpf ->
> > > >     kmalloc_nolock() -> ___slab_alloc(cache_B)
> > >
> > > > Hence the caller of ___slab_alloc() checks if &s->cpu_slab->lock
> > > > can be acquired without a deadlock before invoking the function.
> > > > If that specific per-cpu kmem_cache is busy the kmalloc_nolock()
> > > > retries in a different kmalloc bucket. The second attempt will
> > > > likely succeed, since this cpu locked different kmem_cache.
> > > >
> > > > Similarly, in PREEMPT_RT local_lock_is_locked() returns true when
> > > > per-cpu rt_spin_lock is locked by current _task_. In this case
> > > > re-entrance into the same kmalloc bucket is unsafe, and
> > > > kmalloc_nolock() tries a different bucket that is most likely is
> > > > not locked by the current task. Though it may be locked by a
> > > > different task it's safe to rt_spin_lock() and sleep on it.
> > > >
> > > > Similar to alloc_pages_nolock() the kmalloc_nolock() returns NULL
> > > > immediately if called from hard irq or NMI in PREEMPT_RT.
> > >
> > > A question; I was confused for a while thinking "If it can't be called
> > > from NMI and hard irq on PREEMPT_RT, why it can't just spin?"
> > 
> > It's not safe due to PI issues in RT.
> > Steven and Sebastian explained it earlier:
> > https://lore.kernel.org/bpf/20241213124411.105d0f33@gandalf.local.home/
> 
> Uh, I was totally missing that point. Thanks for pointing it out!
> 
> > I don't think I can copy paste the multi page explanation in
> > commit log or into comments.
> > So "not safe in NMI or hard irq on RT" is the summary.
> > Happy to add a few words, but don't know what exactly to say.
> > If Steven/Sebastian can provide a paragraph I can add it.
> > 
> > > And I guess it's because even in process context, when kmalloc_nolock()
> > > is called by bpf, it can be called by the task that is holding the local lock
> > > and thus spinning is not allowed. Is that correct?
> > >
> > > > kfree_nolock() defers freeing to irq_work when local_lock_is_locked()
> > > > and (in_nmi() or in PREEMPT_RT).
> > > >
> > > > SLUB_TINY config doesn't use local_lock_is_locked() and relies on
> > > > spin_trylock_irqsave(&n->list_lock) to allocate,
> > > > while kfree_nolock() always defers to irq_work.
> > > >
> > > > Note, kfree_nolock() must be called _only_ for objects allocated
> > > > with kmalloc_nolock(). Debug checks (like kmemleak and kfence)
> > > > were skipped on allocation, hence obj = kmalloc(); kfree_nolock(obj);
> > > > will miss kmemleak/kfence book keeping and will cause false positives.
> > > > large_kmalloc is not supported by either kmalloc_nolock()
> > > > or kfree_nolock().
> > > >
> > > > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > > > ---
> > > >  include/linux/kasan.h |  13 +-
> > > >  include/linux/slab.h  |   4 +
> > > >  mm/Kconfig            |   1 +
> > > >  mm/kasan/common.c     |   5 +-
> > > >  mm/slab.h             |   6 +
> > > >  mm/slab_common.c      |   3 +
> > > >  mm/slub.c             | 466 +++++++++++++++++++++++++++++++++++++-----
> > > >  7 files changed, 445 insertions(+), 53 deletions(-)
> > > >
> > > > diff --git a/mm/slub.c b/mm/slub.c
> > > > index 54444bce218e..7de6da4ee46d 100644
> > > > --- a/mm/slub.c
> > > > +++ b/mm/slub.c
> > > > @@ -1982,6 +1983,7 @@ static inline void init_slab_obj_exts(struct slab *slab)
> > > >  int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
> > > >                       gfp_t gfp, bool new_slab)
> > > >  {
> > > > +     bool allow_spin = gfpflags_allow_spinning(gfp);
> > > >       unsigned int objects = objs_per_slab(s, slab);
> > > >       unsigned long new_exts;
> > > >       unsigned long old_exts;
> > > > @@ -1990,8 +1992,14 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
> > > >       gfp &= ~OBJCGS_CLEAR_MASK;
> > > >       /* Prevent recursive extension vector allocation */
> > > >       gfp |= __GFP_NO_OBJ_EXT;
> > > > -     vec = kcalloc_node(objects, sizeof(struct slabobj_ext), gfp,
> > > > -                        slab_nid(slab));
> > > > +     if (unlikely(!allow_spin)) {
> > > > +             size_t sz = objects * sizeof(struct slabobj_ext);
> > > > +
> > > > +             vec = kmalloc_nolock(sz, __GFP_ZERO, slab_nid(slab));
> > >
> > > In free_slab_obj_exts(), how do you know slabobj_ext is allocated via
> > > kmalloc_nolock() or kcalloc_node()?
> > 
> > Technically kmalloc_nolock()->kfree() isn't as bad as
> > kmalloc()->kfree_nolock(), since kmemleak/kfence can ignore
> > debug free-ing action without matching alloc side,
> > but you're right it's better to avoid it.
> > 
> > > I was going to say "add a new flag to enum objext_flags",
> > > but all lower 3 bits of slab->obj_exts pointer are already in use? oh...
> > >
> > > Maybe need a magic trick to add one more flag,
> > > like always align the size with 16?
> > >
> > > In practice that should not lead to increase in memory consumption
> > > anyway because most of the kmalloc-* sizes are already at least
> > > 16 bytes aligned.
> > 
> > Yes. That's an option, but I think we can do better.
> > OBJEXTS_ALLOC_FAIL doesn't need to consume the bit.
> > Here are two patches that fix this issue:
> > 
> > Subject: [PATCH 1/2] slab: Reuse first bit for OBJEXTS_ALLOC_FAIL
> > 
> > Since the combination of valid upper bits in slab->obj_exts with
> > OBJEXTS_ALLOC_FAIL bit can never happen,
> > use OBJEXTS_ALLOC_FAIL == (1ull << 0) as a magic sentinel
> > instead of (1ull << 2) to free up bit 2.
> > 
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
> 
> This will work, but it would be helpful to add a comment clarifying that
> when bit 0 is set with valid upper bits, it indicates
> MEMCG_DATA_OBJEXTS, but when the upper bits are all zero, it indicates
> OBJEXTS_ALLOC_FAIL.
> 
> When someone looks at the code without checking history it might not
> be obvious at first glance.
> 
> >  include/linux/memcontrol.h | 4 +++-
> >  mm/slub.c                  | 2 +-
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 785173aa0739..daa78665f850 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -341,17 +341,19 @@ enum page_memcg_data_flags {
> >         __NR_MEMCG_DATA_FLAGS  = (1UL << 2),
> >  };
> > 
> > +#define __OBJEXTS_ALLOC_FAIL   MEMCG_DATA_OBJEXTS
> >  #define __FIRST_OBJEXT_FLAG    __NR_MEMCG_DATA_FLAGS
> > 
> >  #else /* CONFIG_MEMCG */
> > 
> > +#define __OBJEXTS_ALLOC_FAIL   (1UL << 0)
> >  #define __FIRST_OBJEXT_FLAG    (1UL << 0)
> > 
> >  #endif /* CONFIG_MEMCG */
> > 
> >  enum objext_flags {
> >         /* slabobj_ext vector failed to allocate */
> > -       OBJEXTS_ALLOC_FAIL = __FIRST_OBJEXT_FLAG,
> > +       OBJEXTS_ALLOC_FAIL = __OBJEXTS_ALLOC_FAIL,
> >         /* the next bit after the last actual flag */
> >         __NR_OBJEXTS_FLAGS  = (__FIRST_OBJEXT_FLAG << 1),
> >  };
> > diff --git a/mm/slub.c b/mm/slub.c
> > index bd4bf2613e7a..16e53bfb310e 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -1950,7 +1950,7 @@ static inline void
> > handle_failed_objexts_alloc(unsigned long obj_exts,
> >          * objects with no tag reference. Mark all references in this
> >          * vector as empty to avoid warnings later on.
> >          */
> > -       if (obj_exts & OBJEXTS_ALLOC_FAIL) {
> > +       if (obj_exts == OBJEXTS_ALLOC_FAIL) {
> >                 unsigned int i;
> > 
> >                 for (i = 0; i < objects; i++)
> > --
> > 2.47.3
> > 
> > Subject: [PATCH 2/2] slab: Use kfree_nolock() to free obj_exts
> > 
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
> >  include/linux/memcontrol.h | 1 +
> >  mm/slub.c                  | 7 ++++++-
> >  2 files changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index daa78665f850..2e6c33fdd9c5 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -354,6 +354,7 @@ enum page_memcg_data_flags {
> >  enum objext_flags {
> >      /* slabobj_ext vector failed to allocate */
> >      OBJEXTS_ALLOC_FAIL = __OBJEXTS_ALLOC_FAIL,
> 
> /* slabobj_ext vector allocated with kmalloc_nolock() */ ?
> 
> > +    OBJEXTS_NOSPIN_ALLOC = __FIRST_OBJEXT_FLAG,
> >      /* the next bit after the last actual flag */
> >      __NR_OBJEXTS_FLAGS  = (__FIRST_OBJEXT_FLAG << 1),
> >  };
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 16e53bfb310e..417d647f1f02 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -2009,6 +2009,8 @@ int alloc_slab_obj_exts(struct slab *slab,
> > struct kmem_cache *s,
> >      }
> > 
> >      new_exts = (unsigned long)vec;
> > +    if (unlikely(!allow_spin))
> > +        new_exts |= OBJEXTS_NOSPIN_ALLOC;
> >  #ifdef CONFIG_MEMCG
> >      new_exts |= MEMCG_DATA_OBJEXTS;
> >  #endif
> > @@ -2056,7 +2058,10 @@ static inline void free_slab_obj_exts(struct slab *slab)
> >       * the extension for obj_exts is expected to be NULL.
> >       */
> >      mark_objexts_empty(obj_exts);
> > -    kfree(obj_exts);
> > +    if (unlikely(READ_ONCE(slab->obj_exts) & OBJEXTS_NOSPIN_ALLOC))
> > +        kfree_nolock(obj_exts);
> > +    else
> > +        kfree(obj_exts);
> >      slab->obj_exts = 0;
> >  }
> > 
> > --
> > 2.47.3
> 
> Otherwise looks fine to me.
> 
> > > > +     } else {
> > > > +             vec = kcalloc_node(objects, sizeof(struct slabobj_ext), gfp,
> > > > +                                slab_nid(slab));
> > > > +     }
> > > >       if (!vec) {
> > > >               /* Mark vectors which failed to allocate */
> > > >               if (new_slab)
> > > > +static void defer_deactivate_slab(struct slab *slab, void *flush_freelist);
> > > > +
> > > >  /*
> > > >   * Called only for kmem_cache_debug() caches to allocate from a freshly
> > > >   * allocated slab. Allocate a single object instead of whole freelist
> > > >   * and put the slab to the partial (or full) list.
> > > >   */
> > > > -static void *alloc_single_from_new_slab(struct kmem_cache *s,
> > > > -                                     struct slab *slab, int orig_size)
> > > > +static void *alloc_single_from_new_slab(struct kmem_cache *s, struct slab *slab,
> > > > +                                     int orig_size, gfp_t gfpflags)
> > > >  {
> > > > +     bool allow_spin = gfpflags_allow_spinning(gfpflags);
> > > >       int nid = slab_nid(slab);
> > > >       struct kmem_cache_node *n = get_node(s, nid);
> > > >       unsigned long flags;
> > > >       void *object;
> > > >
> > > > +     if (!allow_spin && !spin_trylock_irqsave(&n->list_lock, flags)) {
> > >
> > > I think alloc_debug_processing() doesn't have to be called under
> > > n->list_lock here because it is a new slab?
> > >
> > > That means the code can be something like:
> > >
> > > /* allocate one object from slab */
> > > object = slab->freelist;
> > > slab->freelist = get_freepointer(s, object);
> > > slab->inuse = 1;
> > >
> > > /* Leak slab if debug checks fails */
> > > if (!alloc_debug_processing())
> > >         return NULL;
> > >
> > > /* add slab to per-node partial list */
> > > if (allow_spin) {
> > >         spin_lock_irqsave();
> > > } else if (!spin_trylock_irqsave()) {
> > >         slab->frozen = 1;
> > >         defer_deactivate_slab();
> > > }
> > 
> > No. That doesn't work. I implemented it this way
> > before reverting back to spin_trylock_irqsave() in the beginning.
> > The problem is alloc_debug_processing() will likely succeed
> > and undoing it is pretty complex.
> > So it's better to "!allow_spin && !spin_trylock_irqsave()"
> > before doing expensive and hard to undo alloc_debug_processing().
> 
> Gotcha, that makes sense!
> 
> > > > +             /* Unlucky, discard newly allocated slab */
> > > > +             slab->frozen = 1;
> > > > +             defer_deactivate_slab(slab, NULL);
> > > > +             return NULL;
> > > > +     }
> > > >
> > > >       object = slab->freelist;
> > > >       slab->freelist = get_freepointer(s, object);
> > > >       slab->inuse = 1;
> > > >
> > > > -     if (!alloc_debug_processing(s, slab, object, orig_size))
> > > > +     if (!alloc_debug_processing(s, slab, object, orig_size)) {
> > > >               /*
> > > >                * It's not really expected that this would fail on a
> > > >                * freshly allocated slab, but a concurrent memory
> > > >                * corruption in theory could cause that.
> > > > +              * Leak memory of allocated slab.
> > > >                */
> > > > +             if (!allow_spin)
> > > > +                     spin_unlock_irqrestore(&n->list_lock, flags);
> > > >               return NULL;
> > > > +     }
> > > >
> > > > -     spin_lock_irqsave(&n->list_lock, flags);
> > > > +     if (allow_spin)
> > > > +             spin_lock_irqsave(&n->list_lock, flags);
> > > >
> > > >       if (slab->inuse == slab->objects)
> > > >               add_full(s, n, slab);
> > > > + * #2 is possible in both with a twist that irqsave is replaced with rt_spinlock:
> > > > + * kmalloc() -> ___slab_alloc() -> rt_spin_lock(kmem_cache_A) ->
> > > > + *    tracepoint/kprobe -> bpf -> kmalloc_nolock() -> rt_spin_lock(kmem_cache_B)
> > > > + *
> > > > + * local_lock_is_locked() prevents the case kmem_cache_A == kmem_cache_B
> > > > + */
> > > > +#if defined(CONFIG_PREEMPT_RT) || !defined(CONFIG_LOCKDEP)
> > > > +#define local_lock_cpu_slab(s, flags)        \
> > > > +     local_lock_irqsave(&(s)->cpu_slab->lock, flags)
> > > > +#else
> > > > +#define local_lock_cpu_slab(s, flags)        \
> > > > +     lockdep_assert(local_trylock_irqsave(&(s)->cpu_slab->lock, flags))
> > > > +#endif
> > > > +
> > > > +#define local_unlock_cpu_slab(s, flags)      \
> > > > +     local_unlock_irqrestore(&(s)->cpu_slab->lock, flags)
> > > > +
> > > >  #ifdef CONFIG_SLUB_CPU_PARTIAL
> > > >  static void __put_partials(struct kmem_cache *s, struct slab *partial_slab)
> > > >  {
> > > > @@ -3732,9 +3808,13 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
> > > >       if (unlikely(!node_match(slab, node))) {
> > > >               /*
> > > >                * same as above but node_match() being false already
> > > > -              * implies node != NUMA_NO_NODE
> > > > +              * implies node != NUMA_NO_NODE.
> > > > +              * Reentrant slub cannot take locks necessary to
> > > > +              * deactivate_slab, hence ignore node preference.
> > >
> > > Now that we have defer_deactivate_slab(), we need to either update the
> > > code or comment?
> > >
> > > 1. Deactivate slabs when node / pfmemalloc mismatches
> > > or 2. Update comments to explain why it's still undesirable
> > 
> > Well, defer_deactivate_slab() is a heavy hammer.
> > In !SLUB_TINY it pretty much never happens.
> > 
> > This bit:
> > 
> > retry_load_slab:
> > 
> >         local_lock_cpu_slab(s, flags);
> >         if (unlikely(c->slab)) {
> > 
> > is very rare. I couldn't trigger it at all in my stress test.
> > 
> > But in this hunk the node mismatch is not rare, so ignoring node preference
> > for kmalloc_nolock() is a much better trade off.

But users would have requested that specific node instead of
NUMA_NO_NODE because (at least) they think it's worth it.
(e.g., allocating kernel data structures tied to specified node)

I don't understand why kmalloc()/kmem_cache_alloc() try harder
(by deactivating cpu slab) to respect the node parameter,
but kmalloc_nolock() does not.

> > I'll add a comment that defer_deactivate_slab() is undesired here.
> 
> Wait, does that mean kmalloc_nolock() have `node` parameter that is always
> ignored?

Ah, it's not _always_ ignored. At least it tries to grab/allocate slabs
from the specified node in the slowpath. But still, users can't reliably
get objects from the specified node? (even if there's no shortage in
the NUMA node.)

> Why not use NUMA_NO_NODE then instead of adding a special case
> for !allow_spin?

> > > > +              * kmalloc_nolock() doesn't allow __GFP_THISNODE.
> > > >                */
> > > > -             if (!node_isset(node, slab_nodes)) {
> > > > +             if (!node_isset(node, slab_nodes) ||
> > > > +                 !allow_spin) {
> > > >                       node = NUMA_NO_NODE;
> > > >               } else {
> > > >                       stat(s, ALLOC_NODE_MISMATCH);
> > >
> > > > @@ -4572,6 +4769,98 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
> > > >       discard_slab(s, slab);
> > > >  }
> > > >
> > > > +/*
> > > > + * In PREEMPT_RT irq_work runs in per-cpu kthread, so it's safe
> > > > + * to take sleeping spin_locks from __slab_free() and deactivate_slab().
> > > > + * In !PREEMPT_RT irq_work will run after local_unlock_irqrestore().
> > > > + */
> > > > +static void free_deferred_objects(struct irq_work *work)
> > > > +{
> > > > +     struct defer_free *df = container_of(work, struct defer_free, work);
> > > > +     struct llist_head *objs = &df->objects;
> > > > +     struct llist_head *slabs = &df->slabs;
> > > > +     struct llist_node *llnode, *pos, *t;
> > > > +
> > > > +     if (llist_empty(objs) && llist_empty(slabs))
> > > > +             return;
> > > > +
> > > > +     llnode = llist_del_all(objs);
> > > > +     llist_for_each_safe(pos, t, llnode) {
> > > > +             struct kmem_cache *s;
> > > > +             struct slab *slab;
> > > > +             void *x = pos;
> > > > +
> > > > +             slab = virt_to_slab(x);
> > > > +             s = slab->slab_cache;
> > > > +
> > > > +             /*
> > > > +              * We used freepointer in 'x' to link 'x' into df->objects.
> > > > +              * Clear it to NULL to avoid false positive detection
> > > > +              * of "Freepointer corruption".
> > > > +              */
> > > > +             *(void **)x = NULL;
> > > > +
> > > > +             /* Point 'x' back to the beginning of allocated object */
> > > > +             x -= s->offset;
> > > > +             /*
> > > > +              * memcg, kasan_slab_pre are already done for 'x'.
> > > > +              * The only thing left is kasan_poison.
> > > > +              */
> > > > +             kasan_slab_free(s, x, false, false, true);
> > > > +             __slab_free(s, slab, x, x, 1, _THIS_IP_);
> > > > +     }
> > > > +
> > > > +     llnode = llist_del_all(slabs);
> > > > +     llist_for_each_safe(pos, t, llnode) {
> > > > +             struct slab *slab = container_of(pos, struct slab, llnode);
> > > > +
> > > > +#ifdef CONFIG_SLUB_TINY
> > > > +             discard_slab(slab->slab_cache, slab);
> > >
> > > ...and with my comment on alloc_single_from_new_slab(),
> > > The slab may not be empty anymore?
> > 
> > Exactly.
> > That's another problem with your suggestion in alloc_single_from_new_slab().
> > That's why I did it as:
> > if (!allow_spin && !spin_trylock_irqsave(...)
> > 
> > and I still believe it's the right call.
> 
> Yeah, I think it's fine.
> 
> > The slab is empty here, so discard_slab() is appropriate.
> >
> > > > +#else
> > > > +             deactivate_slab(slab->slab_cache, slab, slab->flush_freelist);
> > > > +#endif
> > > > +     }
> > > > +}
> > > > @@ -4610,10 +4901,30 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
> > > >       barrier();
> > > >
> > > >       if (unlikely(slab != c->slab)) {
> > > > -             __slab_free(s, slab, head, tail, cnt, addr);
> > > > +             if (unlikely(!allow_spin)) {
> > > > +                     /*
> > > > +                      * __slab_free() can locklessly cmpxchg16 into a slab,
> > > > +                      * but then it might need to take spin_lock or local_lock
> > > > +                      * in put_cpu_partial() for further processing.
> > > > +                      * Avoid the complexity and simply add to a deferred list.
> > > > +                      */
> > > > +                     defer_free(s, head);
> > > > +             } else {
> > > > +                     __slab_free(s, slab, head, tail, cnt, addr);
> > > > +             }
> > > >               return;
> > > >       }
> > > >
> > > > +     if (unlikely(!allow_spin)) {
> > > > +             if ((in_nmi() || !USE_LOCKLESS_FAST_PATH()) &&
> > > > +                 local_lock_is_locked(&s->cpu_slab->lock)) {
> > > > +                     defer_free(s, head);
> > > > +                     return;
> > > > +             }
> > > > +             cnt = 1; /* restore cnt. kfree_nolock() frees one object at a time */
> > > > +             kasan_slab_free(s, head, false, false, /* skip quarantine */true);
> > > > +     }
> > >
> > > I'm not sure what prevents below from happening
> > >
> > > 1. slab == c->slab && !allow_spin -> call kasan_slab_free()
> > > 2. preempted by something and resume
> > > 3. after acquiring local_lock, slab != c->slab, release local_lock, goto redo
> > > 4. !allow_spin, so defer_free() will call kasan_slab_free() again later
> > 
> > yes. it's possible and it's ok.
> > kasan_slab_free(, no_quarantine == true)
> > is poison_slab_object() only and one can do it many times.
> >
> > > Perhaps kasan_slab_free() should be called before do_slab_free()
> > > just like normal free path and do not call kasan_slab_free() in deferred
> > > freeing (then you may need to disable KASAN while accessing the deferred
> > > list)?
> > 
> > I tried that too and didn't like it.
> > After kasan_slab_free() the object cannot be put on the llist easily.
> > One needs to do a kasan_reset_tag() dance which uglifies the code a lot.
> > Double kasan poison in a rare case is fine. There is no harm.
> 
> Okay, but we're now depending on kasan_slab_free() being safe to be
> called multiple times on the same object. That would be better
> documented in kasan_slab_free().
> 
> -- 
> Cheers,
> Harry / Hyeonggon

-- 
Cheers,
Harry / Hyeonggon

