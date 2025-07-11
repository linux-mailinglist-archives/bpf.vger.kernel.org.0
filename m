Return-Path: <bpf+bounces-62999-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55439B0134C
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 08:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FDEE582DAA
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 06:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1A81CF5C0;
	Fri, 11 Jul 2025 06:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eW+Z2ZDF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gMBqN9sL"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DC41A2632
	for <bpf@vger.kernel.org>; Fri, 11 Jul 2025 06:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752214059; cv=fail; b=BOqONo8sOMVSBd99b4QF9/uxf/MNHi0SWGLhmQh2VIg41yi/Y9GN5sM/EXHDrg9flxnpWiV/c1Ro0rEk5t8aGCS2uB6hYeQv7tIvY7sUxDheg8uYhm7bkHJDjCpNz/Fmx5w9LwXpfDpjX/WsD7L985sO/SbcnL+ypoVrhlE34gg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752214059; c=relaxed/simple;
	bh=OU5RQrAAfomeo85zdR7Xuyv0QveI9GyphsTWJ8Z0XdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eTYVxdrL0w4VrqiZFarvwDJsVNnzJ+eG7gwPtjkxRKDvo97yBfoan7ZIbewI3L8oOsuQ6hqvYnlg+uUMLuwVOkoJPUKy32JmfR1hgBrDmhXW6UBaeZoEpdzlfuBNQ1GErfiKKc5iDSleXvH69iCWAbmL+v/lAtEZ4/S8NZB+tV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eW+Z2ZDF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gMBqN9sL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56B5YqVm008694;
	Fri, 11 Jul 2025 06:06:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=acPCIRNgR+hUS5bumbp9U52cuPeMmakW0u9+R/K2buU=; b=
	eW+Z2ZDFxp5aQ5k8K7DxeeuVwoy43OwIkh+4V422YhjQ7pcpeznJNTz+i1w4GvJs
	40dyrHqe9s90Lo7wVdVWQP+3RYxDZQg1ZLG19gnsBnKFZmqUaSlXQwzEzY9KMaV6
	cVHHJ/26yqylOpv/zrjCuVQH/owzNM0k5fdLZTYTK/8yAGCmOcPsNGtusnVFWDRg
	o0qDQvsOiyGFda7247y6IR9ORiK70F+CDyXgRzKzL4fESUhF84MQO15G6h+nthl7
	lJW5Ho/d+kLwWiko5zeM7DbbdlxwpHpP/7bz6W56TVb6a5Ei14VwnAnb3QM375SL
	QVzI3zYLtvq9PdwJrwPzOA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47tvht81h6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 06:06:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56B62cEk021566;
	Fri, 11 Jul 2025 06:06:49 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgd4v6t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 06:06:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=COmRPOSB4bI9UEhX3Ta30a0ZYyjHCctRQllrIclkDrHO7b9lkrXF9zsnWl0PxlMeMjVc+22otf1DMOOeea0Q7UJbAA4j97zvRbJzBPC7g5x4ELorQopZSpbKLXB/FR1bbmyjdY75Yk0Uuc1Az/FIxl11xmL5v8O6vsEwz47jQv9hPMo0DUaXWzhqWBL42BTP6tbxJQAfVLKASEncrzKG+fX6maj9UlN3YvyXb+Auvgl5fekfMbiX8fPv8Mm1EmqmQR9jM/HCuiKoJHLVH4w8uOJfHSHbVX6hi7gEoVAb8HxEeOXPAmYrOebIRRnU2EVzy/vMxQSm/RYg2aCJBCdG6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=acPCIRNgR+hUS5bumbp9U52cuPeMmakW0u9+R/K2buU=;
 b=VPXdglPjLuyfsdHUgtslBr2ZENY/thLyPoUPQBGrvrSfju/ar+lX9qKW+Mzw4F6fB2+74xNMtMg0q0CoPCIG+T7g2L11qZ3fBSimiYAZMLaOlqlvQ8A2ftNkFtOcvzMW0JpRfOQIPuef4CsqjCBezTAeeLUJ2slYvVeqriwFAxT1W7xbLSUAIrd3CHndEvDnO4F2PqZ5JNR/nQvCmuQOyb/ebxuB008CtI/mW25zW0wiVYIk6AXzuT+DLy4Rvz9sgs/210XtDWlpKKf8QYydNekDVLq2W6vh0mDSL2vUUtowXFE5KARY4cl5OHVu4seLxPX2N6OTk+jBkBkY2j0b4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acPCIRNgR+hUS5bumbp9U52cuPeMmakW0u9+R/K2buU=;
 b=gMBqN9sLllPCfLdNcOAQVt975yTeXH2gRESfzj9YFz4Y7/wPY3JeWyCaNOS42AvIs0JYuzC+iwrrDuR6ysc6o1gsf5ZOo09+Kimi6A+6fKfPyvelRPtAZILlx/ja8oVkJPrzcz34PwSVR3KB9ciFnVYyVOxOn8Y2jiAnb72WOT8=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH8PR10MB6502.namprd10.prod.outlook.com (2603:10b6:510:22a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Fri, 11 Jul
 2025 06:06:46 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%4]) with mapi id 15.20.8901.028; Fri, 11 Jul 2025
 06:06:46 +0000
Date: Fri, 11 Jul 2025 15:06:33 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, bpf <bpf@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Shakeel Butt <shakeel.butt@linux.dev>,
        Michal Hocko <mhocko@suse.com>,
        Sebastian Sewior <bigeasy@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v2 6/6] slab: Introduce kmalloc_nolock() and
 kfree_nolock().
Message-ID: <aHCpkPBPEiSECFc6@hyeyoo>
References: <20250709015303.8107-1-alexei.starovoitov@gmail.com>
 <20250709015303.8107-7-alexei.starovoitov@gmail.com>
 <683189c3-934e-4398-b970-34584ac70a69@suse.cz>
 <aG-UMkt-AQpu8mKq@hyeyoo>
 <e9bab147-5b36-4f9a-85b0-64740b84e826@suse.cz>
 <CAADnVQ+G340va8h2B7nNO00mWxbP_chx3oHW2PYrKt2AfOZS8w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+G340va8h2B7nNO00mWxbP_chx3oHW2PYrKt2AfOZS8w@mail.gmail.com>
X-ClientProxiedBy: SE2P216CA0099.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c2::8) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH8PR10MB6502:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e09eadb-79f9-4bc1-4e3c-08ddc0411d80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bXVEVWkramREdlFLMjRmQVVQaXY3Ykk3WEVZb3dqTHVGd1Q1OEdWWFlIdHhH?=
 =?utf-8?B?OEtLVzRhMXY5Nkh4SEFFTmJZdS95WURiYmp0RW4zS2Jta2NPcVVWN2tPNkhx?=
 =?utf-8?B?OXJsLy9hcUwyRWZKcFc0c2JOMU9KR1VSeGk2Vk5TK21Bb3JXZXllSU02SmJq?=
 =?utf-8?B?dE9iNGcwNXlkeGg0TXNyZkpEVXJUSStrM2FUeUVhRVZMQXNnMkxUUkNMcnkw?=
 =?utf-8?B?RGZRblhOcDltT1FHUkF2MEYxc3BuZDVHVDZsUFQxLzJ6bzlRcmJTaEgvai9m?=
 =?utf-8?B?cVNGM3JKUXZMUERZYTVhK1dzaGc3a041WmYrZ0pwdDU5OXBWMzFSMDAyV1g1?=
 =?utf-8?B?RWs0K0QwdXA1V3B2azMrRjJGM2JsbGdCbGNmNDliQXlITWV3Y0h1emdUU0FV?=
 =?utf-8?B?RHJ5b0g1VjNLUktCVFBBVlUzVWZ6S3FwejNZR2lISDQ0VXBZNXFtNlVQbmFW?=
 =?utf-8?B?WHg1WnFLclN5UkRGTitxdFpyVEt1Rld4OXU5VHlOSUdsRjJwZXlNVFNveS9B?=
 =?utf-8?B?RlRyL2hQZHJ0d3FKOFQrclhXMENxOUhnOFRDNGl6TEZKMG5kUWlHbFJ6RUpF?=
 =?utf-8?B?UjBhZzd1QjFraG9RMzlnM2x1NU1yYzFmRzd1K3o2ZkwzTXgzQ09xNCtHZ20z?=
 =?utf-8?B?T1dxUWQ5MmdaaXQ2djh0UzRLclBBUmNCOUc5SDk5RjA1ckN0VTAyN2dHRmc5?=
 =?utf-8?B?V2IrOGZEdkozWW5mSGtaVGU2VWozOXF4TlRYMmxraFBpOWZ2M1loUUtFZkhJ?=
 =?utf-8?B?c2dJZER0MmVXNnpITzFTOWlhc3FGL2ZlTmIwamxSRm40UWdqa1NTY2tTTVQ5?=
 =?utf-8?B?TW9ockIvaUh4a3liUlRWVVdyVldkRkpSbkRTZWlPb0czMisxcm1iMk9IREhw?=
 =?utf-8?B?YUtETXcrTXVucGFodVlpbHBYVmVvdW1EZlVoUDd1VWpJR2djc2FLUkRWS3dQ?=
 =?utf-8?B?emN3RlVvM2lETmhVV0NHck9NN3QwVjRBN2MvN3ZqL1dkQkUxb1VINlEyb1FK?=
 =?utf-8?B?Y3J1RDR5YWxFSi9MZElTMUJUU0RvTExVWWh1ZkxjRDd6K0I4WklrZTFoREJh?=
 =?utf-8?B?Z3NJN3pwWTFINHFVdmJQbUJoMTlKMmg4b3Iza0NKdnZrWUt2dWlZYnFZdDBB?=
 =?utf-8?B?dFFCbkp4UGNmKzhPMURSb2xJZG9kcWZLQzgzaldwNVRuOTBxUUNaOTI4R3dV?=
 =?utf-8?B?Z3JxaHpDeWswLys5c3lUZU9Rck9rTFJ1cW5JUk5RVVNSdWs3RG9iQVlvOUpV?=
 =?utf-8?B?Q0xyWkIyRHlEeEczNTc1dGQrZ0g1QTdTVC9pQTcxRXd6ZWZVZVhkREpNUGRZ?=
 =?utf-8?B?UXZrSG9sdlk2QTBtOHN6MVJOREVuYVZwTEdyOVlyZHVoVXhmTTRvdDBoV2Uz?=
 =?utf-8?B?bnJvSEZpY1ZsakV1YmNQSElEY1doNlFDL0hkcWhpcjZhdlVucVc5ZTQ3RnZ6?=
 =?utf-8?B?ZHBBOThGVnlPUGlTMjZXdmNTdVhjWjJhMmJqakUvdW9nOWRLQktqOVVGTW5V?=
 =?utf-8?B?cUFlb0dwelNVSndNdUgrMzE5YkV2QmxMUG1KTjJVZS8vMFJsVWQ5cDBpYU9w?=
 =?utf-8?B?MWNpREQ1cHVzKzJ1a2pQSWFJZ2VzcndNTWhDQ0hyVjY5djVJcks3ZlBNWjRX?=
 =?utf-8?B?eEM0NlYvbldmL0taWVVNNWJ3eG5oRTJlYzVLTVhlN2FrTFFTa1p0ajc1ckpH?=
 =?utf-8?B?UDRQKytFVGpIUFFnQ3ZYWHhzYXI2SlVzazNCRkx4QXZWRlpDWkg1Si9aUDZa?=
 =?utf-8?B?MmpDYzFCTmt5eWpMY3hESTQ0R3g1RDJuQ3Nnc1NDY1NxS2llQ0NiQ0phU3ZW?=
 =?utf-8?B?TzBLRmlwdHhGU3lUZkExT1MrRGoyN3NUQXkvUXFxMnJVQk9tcnJqNFdyQnA5?=
 =?utf-8?B?YVVTbTlhRWFqcDJwN1FnY2Y3TElHRnFtU3hzcS8xamhIaTNOT1R5eDkwN2k4?=
 =?utf-8?Q?dYDcwQp+l/8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STExeFViVVpwZHIvdnhXb3BRSXFFN0Zzc1AvbWR4YlY3N1krNVZPMlpFdjdB?=
 =?utf-8?B?Unl6RXZNQ2JaRENuT2tJYW9qV2g3OWRBeXpRdTdSb1ZZeXdLY1BuM1pRbTRv?=
 =?utf-8?B?T21uL3JDdy9qTDI4c3JrdDcva1cyNHdGZWpScnlnc3JNczJCa3I1cW1VVkhn?=
 =?utf-8?B?azlWT1krYnlMSW91bDZ0YXgxd2VOSUdzNnFLQkdJUmdEdDFFaDcvZUJvV21q?=
 =?utf-8?B?cFljWFA0MENVQlhPRzJVck5TRUQ4OXVXekpKZlZOMTR6cFdtd2E1WHpKMGNG?=
 =?utf-8?B?d3FocWo0S2JBK1paVEtDZ2NBcnd3SktwbGFGVEdkVW1TaGdsS1NOeUVla2lw?=
 =?utf-8?B?UGp5SEl3U3hBSWkzaUhGaElLL2lJc0tDVzlSSzMzRGZKbnVUZTNKRmpQMDIw?=
 =?utf-8?B?b2RhejA5cmhYN0tzNCtCSWNSVXhkWGtiVzg4YTZ4bUxLbFpFTWIyWElMQ2Q0?=
 =?utf-8?B?ZWV2ZkNDclhXenZOYk5QNHd5ZHNscmhTZVIxUC9pLzNHci92bG1vbzNRdm9p?=
 =?utf-8?B?VHhBOGlXdlJLUUdYeEg5ZFJxaENTMStYWE5iMkFlbGVITFBFYzJJNDJ6bHJP?=
 =?utf-8?B?NHU0SnBvWllVbDBXeUdPbEZWLzljQzV6RnordU9KTFJiNlgwM3UxeHlPNStM?=
 =?utf-8?B?TC9NeHV3SWwrdG53WWJTWEdzQ1FSdCtqUFBMN2U4cGJzNXpsUFJ2M1dWSS9a?=
 =?utf-8?B?aW9NVHIrL0I3c2hJOXhXd1FyZmkzREpxd2Y1L3ExVE5PNGxMQjJkZU5Gamhk?=
 =?utf-8?B?OUpWaE0xVHk5MDRidkMzL1c5V0d4MzVLemlpeS9TNHdMbG5HTHk4NFV0YnZI?=
 =?utf-8?B?a0tDYlhQdUc4ZUoyaU9UTUVTY0VOSW0rcHZvRzlVSXR6YkFCZU94TGlnMWh6?=
 =?utf-8?B?RC96RkxndVBCdy82UHFCa1RsYlNVUWtmZmF4K3labG9MS21LcTZ5amNZeStI?=
 =?utf-8?B?R2RCZFVJSGlmQU42L0tiVys0NEdGUy9EMnhsc2dpd05ZelMvazBGWVhiUEUw?=
 =?utf-8?B?b3RQV1lzZmswbGc5WmNtK283bEswYmU3d0NoWHZHSEpNU3lVdU93dzI2WjZF?=
 =?utf-8?B?NGVUS3l2MDQvVjhNY0JyRkpPSFEyU1gxSS9mV1dJMXRZTzhUNlB2QmJvMDFh?=
 =?utf-8?B?d1Z0SHNEZW5QYTlvUFlPcDFROG55Q1R0UEpJSlArNnNTcy9vNHQxRjJBbTNp?=
 =?utf-8?B?S2lRektEdEsybm9uMytvRFAwUnJhaEJyQVRENmdYQVlkTXVXR01SL1JmRHMr?=
 =?utf-8?B?b1dxN2FReWdWaTFiamQ3WVY1OXRQK3poSzNGVFJRL2pkbmZscGdSc1Q0QnFj?=
 =?utf-8?B?UlJ6LzFGcmpIUzNEUVpJWitaN3RLVmhGeHhnTERFRmFqVDEvdnFSaEtzU25D?=
 =?utf-8?B?VFAvMnJBWk16SitONVhKQ0k4akR3QUpPaERsc1pVenVhcFJjYlJsNUxybzVI?=
 =?utf-8?B?UldVdi9Id0xqMkIxeituY1kyYWdabk56WWFwRDV3dUpHd2cxaU5BU21ZNGxX?=
 =?utf-8?B?UXp0dVRZaSt1aitudHVoV2JJUE5oUHVlOHJBTzJJL25XaHJRVW41dzA0QXo5?=
 =?utf-8?B?a25kcmU0ekM0QkNjL1FHR3FjSk9MRnF3SWFvZ3o1OUN1Qldqb0NyMDVPTDFq?=
 =?utf-8?B?WTF5OHpuS0RtSU5EUWtoejZKS05GZVQ0bWJZTEl2bnBTWFIyTDczTG1pY2Iw?=
 =?utf-8?B?Ujd1QnNSMEd0ZUs3cmFKVkNUSWVXbThXUU03cVhmZzRYMERwVUVQTVYyZVVp?=
 =?utf-8?B?TFkyQncwbEdKUVc4UXF6T2lpK3A4YkVCSVh0Yi92ZHlpYy90M3NwS2drZXRB?=
 =?utf-8?B?aU1XbmpSV1BSMitPTFhsQkVhV28rbTlpNTRmazAxclJFVFh5amZiL3lFZnpZ?=
 =?utf-8?B?azl4bldxWlo0VjRwZjNSSG84WVdndkxtSUlXay94Z1ZVNlA4RDFxb1Z3WE41?=
 =?utf-8?B?RzlVOHJaNFV6bm45by9sOExCMWZubDFZaVJmZkxwT3dqK0U1Y2pPTlIvaVY3?=
 =?utf-8?B?UVhhRUZpUm5tb05Qa1N4YlNMQUVrZ3EzcVhQZ1pCanQ4WUFlUmJqRW5scEVk?=
 =?utf-8?B?SE96OFhuMUhHNHR6bGhUbWQrbjVOOCtyQjRubkFJM00yanh3aVJQd1ZzYURs?=
 =?utf-8?Q?gVf8SavGLBEieSxNujHDjXk8K?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MIRDd798b/1A/iJ1iIErwdQMsaAka8ncW3z0D4sxkGuE9vDjrB8+H/FpWtRWbsmq5gF8NRbi/zj07xzfw/+L6sWfX6Me+5gtOIeRRnpSpcu8Vk0QqmTCn3Lf3sOy38jjm4syhOGGgfUuwN2s70aXoNd9w+tjKAQ6OQ8jxLcb7TtzTnJFD2MQAJUIZppVI0l94MKDynx7l20b/yFl2IzWV0epyAaqLFG9SNO2FQGSN47BdsYwSEKp7Ks0C5VUqxQt2y1UC0IGzXhE4BwX9R1IK7sQPvxF2oqrVc3W7+ffjorM72gvVUorRD6xapOCNehnxtHNXg+2+LPPvRDp2ly+azlMlDgUUoEwXb1PoyxnkVWZS39McSoQObVtW6zCZwxdRcfL+/RUvUaguV9OvUkVmPTlONtYIqi/w28JXV2PEH16rsR1BKLXh8GsOsw8KscNMLfV2Qgxe1YmLl4jATY0Xf+Kwd8tMNAcJtZ/mjhC2BrJP8sGHN08ZtGetLohex6vYbc1Rr3+hQsYQ5TEScS5rZfIZH2IJZOA/zEvrQE5rCr5bbbULoh5NNfHUCGKyH8lRpuK0dtGn+R2g86YnW8yVXlp9xxLkKyEo8aHXtqP2mg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e09eadb-79f9-4bc1-4e3c-08ddc0411d80
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 06:06:45.9218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yn84z3J4JEqgk3YqpxJ5Qlys00eZlv05bkX2A9XStiTn0hSaPOWAsbbaZ7QAWNrKizY+0f5eD28ADYf/4sNaBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6502
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507110040
X-Proofpoint-GUID: 5gd_U1PVumoGzOLujiPXI5_eVfv_pmZZ
X-Proofpoint-ORIG-GUID: 5gd_U1PVumoGzOLujiPXI5_eVfv_pmZZ
X-Authority-Analysis: v=2.4 cv=a60w9VSF c=1 sm=1 tr=0 ts=6870a9fa cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=mdBpV4qoPZ0RuuOWGssA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA0MSBTYWx0ZWRfX/yqVYlOvBsF+ rfraYeEMetGyMHSrk6JlzDBLUfCUQouinEwFTQ++hRq9Ss+JHFWsENV2cbPGPrE0RuxEwiE/+wf D9p6uYP9/SR8OoInUcf4hGFhNcp3OHNqtqlK43PtyKwm7zxPS+rJQhK8L9qL+Zggtr2jpxXKrPW
 WXYJ28ieIpSHj7qZJ3O/UM1r6d4KYUilJiuLt00bfSeiI/mb9oRSjkidOcH+/NkVCjGImFOgDaI KBNkRQhiHFHjvdjYGHS3DaT7xRN+1ualAQX2ZvshGI7jWrHpl6I2Iad441SscSVaj0WnvSvzB4J LOl6P8Fp7TSFH5Q1s2XIsErHA1+aH9aSm7fWYgwkmCWUOK6LaMjTu8n7LtyZdwu042U2IfbJjdd
 PHBdHE9lhRKxnGXjihbwb14wQZ2bWBY07Vbh654Xlpw9xQnHTnUlYlWAkRMu+deCtOc7yCAo

On Thu, Jul 10, 2025 at 12:13:20PM -0700, Alexei Starovoitov wrote:
> On Thu, Jul 10, 2025 at 8:05 AM Vlastimil Babka <vbabka@suse.cz> wrote:
> >
> > On 7/10/25 12:21, Harry Yoo wrote:
> > > On Thu, Jul 10, 2025 at 11:36:02AM +0200, Vlastimil Babka wrote:
> > >> On 7/9/25 03:53, Alexei Starovoitov wrote:
> > >>
> > >> Hm but this is leaking the slab we allocated and have in the "slab"
> > >> variable, we need to free it back in that case.
> 
> ohh. sorry for the silly mistake.
> Re-reading the diff again I realized that I made a similar mistake in
> alloc_single_from_new_slab().
> It has this bit:
> if (!alloc_debug_processing(...))
>   return NULL;

Yeah but we purposefully leak slabs if !alloc_debug_processing(),
the same in alloc_single_from_partial().

> so I assumed that doing:
> if (!spin_trylock_irqsave(&n->list_lock,..))
>    return NULL;
> 
> is ok too. Now I see that !alloc_debug is purposefully leaking memory.
> 
> Should we add:
> @@ -2841,6 +2841,7 @@ static void *alloc_single_from_new_slab(struct
> kmem_cache *s, struct slab *slab,
>                  * It's not really expected that this would fail on a
>                  * freshly allocated slab, but a concurrent memory
>                  * corruption in theory could cause that.
> +                * Leak newly allocated slab.
>                  */
>                 return NULL;
> 
> so the next person doesn't make the same mistake?

Looks fine. Probably add a comment to alloc_single_from_partial() as well?

> Also help me understand...
> slab->objects is never equal to 1, right?

No. For example, if you allocate a 4k obj and SLUB allocate a slab with
oo_order(s->min), s->objects will be 1.

/proc/slabinfo only prints oo_order(s->oo), not oo_order(s->min).

> /proc/slabinfo agrees, but I cannot decipher it through slab init code.
> Logically it makes sense.

I think the reason why there is no <objsperslab> == 1 in your
/proc/slabinfo is that calculate_order() tries to choose higher order
for slabs (based on nr of CPUs) to reduce lock contention.

But nothing prevents s->objects from being 1.

> If that's the case why alloc_single_from_new_slab()
> has this part:
>         if (slab->inuse == slab->objects)
>                 add_full(s, n, slab);
>         else
>                 add_partial(n, slab, DEACTIVATE_TO_HEAD);
> 
> Shouldn't it call add_partial() only ?
> since slab->inuse == 1 and slab->objects != 1

...and that means we need to handle slab->inuse == slab->objects.

> > > But it might be a partial slab taken from the list?
> >
> > True.
> >
> > > Then we need to trylock n->list_lock and if that fails, oh...
> >
> > So... since we succeeded taking it from the list and thus the spin_trylock,
> > it means it's safe to spinlock n->list_lock again - we might be waiting on
> > other cpu to unlock it but we know we didn't NMI on our own cpu having the
> > lock, right? But we'd probably need to convince lockdep about this somehow,
> > and also remember if we allocated a new slab or taken on from the partial
> > list... or just deal with this unlikely situation in another irq work :/
> 
> irq_work might be the least mind bending.
> Good point about partial vs new slab.
> For partial we can indeed proceed with deactivate_slab() and if
> I'm reading the code correctly, it won't have new.inuse == 0,
> so it won't go to discard_slab() (which won't be safe in this path)
> But teaching lockdep that below bit in deactivate_slab() is safe:
>         } else if (new.freelist) {
>                 spin_lock_irqsave(&n->list_lock, flags);
>                 add_partial(n, slab, tail);
> is a challenge.
> 
> Since defer_free_work is there, I'm leaning to reuse it for
> deactive_slab too. It will process
> static DEFINE_PER_CPU(struct llist_head, defer_free_objects);
> and
> static DEFINE_PER_CPU(struct llist_head, defer_deactivate_slabs);

+1 for another irq work for slab deactivation
it should be rare anyway...

> Shouldn't be too ugly. Better ideas?

-- 
Cheers,
Harry / Hyeonggon

