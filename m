Return-Path: <bpf+bounces-55076-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65416A77B6D
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 14:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BC1E3AE24B
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 12:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941D920370D;
	Tue,  1 Apr 2025 12:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FmMM6gwQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ItveSpd6"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4BD1EBA18;
	Tue,  1 Apr 2025 12:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743512297; cv=fail; b=cSdm+ieXQNOgBPyCUSSgXKgCi0qzsDr4dW3RKZOXvJeS3Iyed5JROdJscW60pcB/OO8//1mzcE4TwwpajxvmEPvF+zkk756FdiowRDr9+XjWHGPaM3UBiwV37932rO5RnkA+r99obP8Tg5WGnviMSyNn+ocWFZBTvqAfh/PNRpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743512297; c=relaxed/simple;
	bh=vFjxaJtgvSOqIpmAmMw5gEKimiVxNk2fTsJbgkmpxWw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PFvAYlqzuepYFk0K+WEWq9DqHTN/33vdnPDmK6G83dbRRCDp9/DoAlBtCkIZAaQS95e4jC8QC+/vO3bNreur7K1NpACaFJocNr2lx2ayk2g+uBBQEsof6j/2Li7zbJ8PrFREzGyfbEHbtnYj7vnruF8oY52AWEzzugb6xuB+cJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FmMM6gwQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ItveSpd6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 531CQtjR004214;
	Tue, 1 Apr 2025 12:57:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=dvSRuRGP6tO5c5R6l6Rm/m2JlBWeQ3NjA2lXRCvGI+Q=; b=
	FmMM6gwQGoZG+QLDxjV+Wi8cJdF8aoSEi5v5tq+76RM2quufI0y8x8UNisg/m/wH
	ab/vh2ngDSdkMdPoVS7DAjuRvryNMlqQtlyiWiDW/C5XkaZmUgCvArYexitOCjSI
	9wTp2qzdu+t6m6jFGKUOCPdKY/voj5dpwp7LwlK/w4NcjicNjPGLyx1K/spgXdG5
	znb3GoM79z/aiPfXy3IQRULE/r3QJl8CD6+ciihQSPjO0mcCZ8KJRXAuKa4f9pVZ
	0A6ebxugpQzGeDCaI8f3GoScGOc9d3DZVrFasVyNfjesPdkFEGt8K337SzeNKvBG
	U3rbO1V6uhGjTopcfQ6lzA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p8fs87n3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Apr 2025 12:57:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 531C3LfK032694;
	Tue, 1 Apr 2025 12:57:34 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45p7a9bvm3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Apr 2025 12:57:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ItJoP0P00MzC2cXRhvgv2NkfbUA1Ir8uqTl9qg0NAhreeLS2QnTosvhzzSdlNC0/uOdfs/Dekg3t6qbRDw95zroRpKepxjKfBZmaAq4o4BSwjmoDGNuIEIEli/tLGNURZubkdHm/DCpbDEzpMO6SovFE68OS94Qd5Yv5NQDFfdn3raRS1/3QIg3mBH6i5BOrGgKbvHFJ52bdYg9HLqt7wfZnJVLmcdPupFwwgpiDahPyBvC7DAOG9obK7AW89OfMrSO1nCX0NtEhtsiqkwLT0LzPAedxdzgtNaVpWmrD4YyGt46HtheZaLJp+hqczeo57JlSHubUypSROb7Nq9jqxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dvSRuRGP6tO5c5R6l6Rm/m2JlBWeQ3NjA2lXRCvGI+Q=;
 b=gmbhgSHksKMu+x1tQoOHZKHSKXyjYt9sWLodjcO888rBYBOPMkaRpmoQ2Yw5ndhk+W/tcgDudYe+kkMw8WHlvXoghbMe6Jtkg0jb2ciqDqC3ZSW+ZolsDwffn2sKJLLxqtrcLj0EZge2I2RPchuz9niwdhlYF21DrUXhyHm9+2A4PsdZfvbC3bfd1aMdyf2G9OwSeHN7+d3YlGBnepklDB/IOwxJUPFhkkIr+skXzOBzrouI9o2oP+FmF0FoygyxzL/3QhSOitqd/Dpl2ntZ2CGjgiAoHVqzkaJfXGfsx3/+f35uYJ5aWZ/XzNetICGvah76Esa+2qp5OTbQaxrvCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvSRuRGP6tO5c5R6l6Rm/m2JlBWeQ3NjA2lXRCvGI+Q=;
 b=ItveSpd6wP9QYw+NTG3CVIIC4HXboU8pUNXnMDO1anY/2+gvJXWqR7m+u9DPK1ZW9jjmuKeRAgUgbofxaKH1NXVfdM862vk4EPQqBNIlBdsJ+JCR6X4baX9+fu3BFp6p5jmDH71gf+I5Rgh41WxVJZvcmEyoudtSobctUbUuOQI=
Received: from DS7PR10MB5278.namprd10.prod.outlook.com (2603:10b6:5:3a5::9) by
 IA0PR10MB7603.namprd10.prod.outlook.com (2603:10b6:208:485::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.38; Tue, 1 Apr
 2025 12:57:32 +0000
Received: from DS7PR10MB5278.namprd10.prod.outlook.com
 ([fe80::eb46:3581:87c4:e378]) by DS7PR10MB5278.namprd10.prod.outlook.com
 ([fe80::eb46:3581:87c4:e378%7]) with mapi id 15.20.8583.038; Tue, 1 Apr 2025
 12:57:31 +0000
Message-ID: <27afc430-face-4013-9b87-4168f38b6b23@oracle.com>
Date: Tue, 1 Apr 2025 13:57:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves] dwarf_loader: fix termination on BTF encoding
 error
To: Ihor Solodrai <ihor.solodrai@linux.dev>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org
Cc: domenico.andreoli@linux.com, acme@kernel.org, andrii@kernel.org,
        eddyz87@gmail.com, mykolal@fb.com, kernel-team@meta.com
References: <20250328174003.3945581-1-ihor.solodrai@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20250328174003.3945581-1-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0374.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::19) To DS7PR10MB5278.namprd10.prod.outlook.com
 (2603:10b6:5:3a5::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5278:EE_|IA0PR10MB7603:EE_
X-MS-Office365-Filtering-Correlation-Id: 210a0257-5197-4afa-c825-08dd711cc3ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UVFmZVI4MkxaNnhrK1hocE9Hb1NLenlYc2NpRFBibzhRc0xBRjMyL1RveEVy?=
 =?utf-8?B?eDJDU1IzQ3RTeCt3bUNIUXVIb3huUTdzSjNzVWxxQzZycFMrcVVGMVlYSHQw?=
 =?utf-8?B?bFQrQzlCT3F2SzBqZndxdmhiZ1VZcWNGQXRjZ1VSbGxjV2ljRU5aVTlXQkN1?=
 =?utf-8?B?TWhwbmg0eHM0dGV6UUt1VmVadTZTWUplNDFuVThqcXJVWXhQZk9UNWxORkdI?=
 =?utf-8?B?bnp1ZStWUFBMQzJuOHdVSy9aTjNPWHZJZTViTEtPNW92UENzdVBuMG1nNTdk?=
 =?utf-8?B?bW80K1l4TkdPY1lPblQ4QjR6WXZWSFQ5STQzdXV0Tkp1Y2luZ1NJRVVVcXhO?=
 =?utf-8?B?RE1YMGpEbEVxbHRReXl0YlZGU0tkQ2VPQmxrK0ROYkVjK3FYdDR0aUEvMldn?=
 =?utf-8?B?MnVsaWFqdmNpQ2F3dlh3THlXNjZhUWF3TVpUdU9UVTRUaW02U0w3WkNkaFpF?=
 =?utf-8?B?OHdScXNnd2Z1MUUxNnQrcjNNR3lKS0lWZXNSamNiV0tiY1phT0w5dnJZR1Jp?=
 =?utf-8?B?YXZxOE9WdGlkYktOanVIak8wQ2hCRGV1T3Q0K21oVk1lN1pvQWM2d0svdS9w?=
 =?utf-8?B?Zm1acExZKzV2ajZRdGE4SW5RcnpYMU94aWowTHBEN0ZBY2pIVThMVnE2YTZP?=
 =?utf-8?B?MnpCWEVFcmhISmhtMndINzY3eDBlWTFnbEE0SGFNQ256akMyMlN0Y2JQcTAz?=
 =?utf-8?B?TkJsMHc5amVYMzdpSEczeHdCZDB2dksxQkVIcGtManlVVzdSYXFjYzY5ay9r?=
 =?utf-8?B?U1pWWWZWVlNQeXFSdVoxaURKS0JZWkVMM09XSWtqMXN0eGF2VENKeTJRVjNr?=
 =?utf-8?B?M014bkxNb0luUVkyQTNFTHJIdHgrSkRpdVBnbFJFcW9hb0JHQytZRFdWd3p1?=
 =?utf-8?B?QVcreG1hME50Z1ZRc3BINHhVYWxXSXdzd2FRL0FmRlhLNGdUZ0FBSUtCdmVG?=
 =?utf-8?B?VlNTUStZK2R5NnRYQURheUNQMlhCdWxwLzBPTVlkeDZ5V2YzbTZubUZQOVNC?=
 =?utf-8?B?V25RL1pxY3BhWC9mVENvK0pSZjY5ckk4cjJVMHR1ZC85NTF0RlFIb1N3OG5O?=
 =?utf-8?B?T3hITG5Xb2lzc3BlU0I4VkFLTmhyUWNhcHAxYzFNT3MvbXRFZzI1Mk92OThB?=
 =?utf-8?B?eWNlcVcvbkgwWXZyWUM0ODlkdTdUUytBUnFWU0Z0dTZuWHJtMTBkZDRxa0pZ?=
 =?utf-8?B?Qlpuay9OclRwK2Fnb1ZBb3l1YnRJd0Y0dEJ2YmR1cFVaV1I0bmM2TVZzMDhS?=
 =?utf-8?B?ekEvT25SdWJyTTZ1SmkwcVdNdzB5S29HRzhyWlJJV3VuWFR4N2ltZjE0TWtx?=
 =?utf-8?B?Z3NKVlloOEFBQ0tINDFWN05jMmFZNnNHdnZuU0laT0d5MjVVbEhrbkwwVTZK?=
 =?utf-8?B?anRDQkFqM1hFTlBkckliei9iOC82czliLzlWUEduRng1Uk0rZ0RNNGJMY1VS?=
 =?utf-8?B?emNyY3VnbnFZWXNYWm04WW1HaUFqbEFpTkhJQ1FRY2piOXRmekpZTHNMSkVh?=
 =?utf-8?B?WWQ0ZEtqaVdXa3FBU3ZjMHJWRXo1dG9iWkdGYVBOOUpRWUJUVXBId2YxTndi?=
 =?utf-8?B?QTVMQmFpQnR4N08rQkk2N2JEL3p4WlNXM0U1bmczZ0MxZWlKZ24zVWpXeTVw?=
 =?utf-8?B?VmlFRVhySStjZW5pUFFiTDRQYkJsSlIxQ08rTHhhN0p4bUpDdmUvTENzT1ZE?=
 =?utf-8?B?V05qdW01ZDZwVUkrQkJnK2hpa3BKWUlDUEUyUHU1ZTdhWmJ2Umh3dGpJZ1hw?=
 =?utf-8?B?NXFDUHRIR2ZHazZDT2FLRlBUSjErell2bmtKWVRxQ2pFcUl6eHZ2dm9yYTRp?=
 =?utf-8?B?bXc3T01MQ2pSbzdWTjJtbWVtalJrekFsRnNOd3VBZ3ZKeGhKZTVIRTJzd24w?=
 =?utf-8?B?bWExVzQvbzlKTnRQSENjYk1IZE0wd3g5NUROVnQwWVRrMTZ5WFIwb2I1eVVa?=
 =?utf-8?Q?sPA7J5Wc62c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5278.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UEMyL2JVbDMwclhDVHNUbmc0MTNYYkVDeE9UL3FmbVUvcE5LeEMvdnAyaEVR?=
 =?utf-8?B?Z1Z2cmMwVzhKVXhtWHlRSkpsa08vcUxNNExtb3o2VGJINWhocVAxazNVWkNM?=
 =?utf-8?B?ZjVVajdoK2VyK3VJOURhZWI1VHZIZ2VzM3JaczBtUUFHQ3YzOFlqdXRHaTU4?=
 =?utf-8?B?UXR1eDZHaE1PdVR2L253eEZoYk9Md2t5RlpwZGFUYjNBMmFraGFlVks3eGNI?=
 =?utf-8?B?RFJoeVdTVjdjaTZzVEgvSG4wVGY1OFJMSnlsc3I2L1M4Y2pobVBCQkVtRTBV?=
 =?utf-8?B?RG1LUzZPcEpFa1dvM2drL0VwZldnSXBSVFJyc1N5TmczR3FRKzhvRzQwQThm?=
 =?utf-8?B?RDBWU1pFVmpNRkhhK2hCSUp5eUd0YXZvbkw1OVNWRXJRd2NHYnF6UldxSWtW?=
 =?utf-8?B?WmJlbmRTTmtjUkVQU25xNEQ3c2xUeDBxMVZnQXRaTElRWUYyTEtMNUJSeWlI?=
 =?utf-8?B?MnZkSzRpM2c5dHBJdWNkY1ZKa2ZQM1M3LzhxbmNuTXBaenQvNHU1ck1aaU14?=
 =?utf-8?B?R2ovTlM5YStkTjdQb2pTM1BJSysvUm52WmlqTlAySEUvZ2M5RXVUdm1RVFcz?=
 =?utf-8?B?Y2NQcUgzK3JlT2xTM3EwWWlHaVRpNFN2RmZDZ2V3V2x5UnlrN2NYQU80NWNn?=
 =?utf-8?B?UkttMkZkSlQ5L0srQzB5UW5xRlVIV1NTRWxmV0o2cUlmcTM5cHBIUTRveVNr?=
 =?utf-8?B?aHFmMUJNMjQ1UVkzTDdEMkN1VGxRamYwRWVIZHlhdFg3SC9jNWFuVnR3OGxY?=
 =?utf-8?B?bnBJdSsrQm0xc01ONzZHN3hwcDRhdGdBb0xtNXk0SytPWXZ0YVhUQUcrVU1m?=
 =?utf-8?B?Y1pqdDMrRk5MSzFYR1BwMVZ4blgwaXRTaXZlVDdzU1Y3N2VURWh6ZnRTdXE0?=
 =?utf-8?B?TzhyWkFiZk10S1VDV2tUOXlnSmw3NkxOeFJ3Ukpmdk1oY2oreWd2VEJPNW9t?=
 =?utf-8?B?K0JzYXI3RVJrWFBObE5kRy9mazd5cnBXTUs1ZzlVSWlqSUh3U1VLQ1E5anhU?=
 =?utf-8?B?ai9IK1hQalJQY3NXLzQyZWh6ekd3c0h0QjJuVnBWQS9XNitSRFV3eHhUVFo0?=
 =?utf-8?B?ME5RazFPSlk3eGdVNk5yVTRsdmJsQTNodVhOb3ZrbjFvVzRSUGk2akl4QzE3?=
 =?utf-8?B?SUhYWFZaby9vVlRsbjJRNTJHTGNUYThXMy9WcHRiYVVnSldJdkJsc1pyUUdz?=
 =?utf-8?B?WXl1YmlqVmxxT3pTazQwOEw1RHR4ZFBudVZsMDkxSnk2VlUvRnNoc05kN3Ft?=
 =?utf-8?B?QUQrQVNnQysva0Z2ZG5xdVJXdGlyMXhMWTVSUDNWOVowQmtydWtCdUZCdTdz?=
 =?utf-8?B?UVVxeHMxS1dqdVg5Mm5PQjlMR1dkK1lIWW1tT1BRRXRvQTBGb3lLaGVjUVZv?=
 =?utf-8?B?NlNLQ3AwUTJ0SkVmZFMvSmE0SG1wL3Zpb0hJUmxEbEdEMkx2NXpmWUpRZ0Va?=
 =?utf-8?B?V092MmsycUFjc0RUZlh0U2xJQlBWbVAvT2ZqNWtCNnovYmxBbFJSMGxOVlQz?=
 =?utf-8?B?dTd5SzBlUld5aTNETzZvZVppSEpzTUhLRWp6QXp2L0xYT05oZ3NwVkpKWnVZ?=
 =?utf-8?B?QTBucnJrdHM4OE5xUE8reWJ0UG5xeXV3VVNjNWk5NDBlcGxpYUpJMnZaVlpH?=
 =?utf-8?B?TnhLeFdpc2NMbWIxYW5qeDdtQXRXK2g2cCs2VmQ4TU9rcFFsRjFRYjZvditX?=
 =?utf-8?B?My9SL0k5ZHQ1OUdtUUhqSjRDWUdqMGlmOG1xbmtsR0dyOUx5d0E2UVE2YlpD?=
 =?utf-8?B?Yzl4ZFNpRzNNSUlwZmIvd2xGdGxOc1J6azR4QTNaa1NXL1UyZVJrcjZINjN2?=
 =?utf-8?B?dE1ZajFyVHgzRmN5OXJLbmVUeUpnMGtrek44UWpwK0EwZ0NIUzM2THUrOUIv?=
 =?utf-8?B?UlpSQ2pZdld1Qkg3NDhrNU1EQ0kweTFkODJwYnRycXpxNzJUMzl0ME9MelQ2?=
 =?utf-8?B?ZVBpck4xOVF0VjRPK2RsMSs0RStsem80djZtSEQ4ZWRRczBHbG9lQkFGUlRZ?=
 =?utf-8?B?dDY4L29EN3dDSU5YQ0I3bEhuaHVnUW5zSHI2azlFZlBXNVRkRU1VeWllSkEz?=
 =?utf-8?B?RUhiL1pGSTJzdTdtM2dwYmpBd0o2dUZxL1lOZk90Q1ZIMERSZjdzd1hFU2Ew?=
 =?utf-8?B?akRzL1ZTWW11ZHF2THlaczQrZW9ZVFhGNlZyUlBRK2ZhYWsxbTVoSWQ5VlVP?=
 =?utf-8?B?TWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	D+eyAljiD9B0S8YYYZkITp5AK8+Z3DperlOqXAyeLVQkbwf6PgeWB1/g5A7xDu90zziwJrKCRPTXGANELAR6NaoKzGjpEH6qO18c0RkP58aPcikZowSKUTbi/ocp3tGj2gP6skK0kEbzZk8bVxbt453nKRT4hTMj3J1Vw5e+ROFs0gGZGXHWOw7A6wg0fiHnhE51N4B9WlHkVj0Da9fpIFSWgfEK8P4diPUpmHaAsi3TiMpliEJiIrlMKJXAJpnvqaaiNpJQwrezB764heZvkA2Nf5lAznsv8zbZDFGUo8gmuQIyZdVBoC3NlfTsFj+uFb+8/wjW0ek76eBMygr27EKcsOVoQnYVZabGlXIoZz4FWU3NyggGQjD9WElvwnM/GAXDJ0FoVctOVW6r34z+QgeSDO7FrER529ug+SzL5ND6acJvSNKmBNdRwzAfVFCyWmI0wk6kw3RtSdXgTOciUZXNhETqI6j9zmXH9ZwCWmisLV+XiFUCoZgQEEU7lMLxgCXZ7EVyHNCzciYUdFZDehxal4tL5/Aua5BXn6B7AcQxe29/bibvnQf1yHajcPYWWLhSvdFVSSGm0hKUzG9mxUVtZvGrc5A1qBot/tumlqk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 210a0257-5197-4afa-c825-08dd711cc3ea
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5278.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 12:57:31.8959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mmlsU75Ib1+kNypuXhvs4i3Xtri6rL31sqDY0/uBga2G4W7iAfWlbmEPlAjQIOl1zFbHr09Osko0Gy/UUc55Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7603
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_05,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504010079
X-Proofpoint-ORIG-GUID: W8PY-x9WVOZlXUP3a5mZ7UobRLRr8-xY
X-Proofpoint-GUID: W8PY-x9WVOZlXUP3a5mZ7UobRLRr8-xY

On 28/03/2025 17:40, Ihor Solodrai wrote:
> When BTF encoding thread aborts because of an error, dwarf loader
> worker threads get stuck in cus_queue__enqdeq_job() at:
> 
>     pthread_cond_wait(&cus_processing_queue.job_added, &cus_processing_queue.mutex);
> 
> To avoid this, introduce an abort flag into cus_processing_queue, and
> atomically check for it in the deq loop. The flag is only set in case
> of a worker thread exiting on error. Make sure to pthread_cond_signal
> to the waiting threads to let them exit too.
> 
> In cus__process_file fix the check of an error returned from
> dwfl_getmodules: it may return a positive number when a
> callback (cus__process_dwflmod in our case) returns an error.
> 
> Link: https://lore.kernel.org/dwarves/Z-JzFrXaopQCYd6h@localhost/
> 
> Reported-by: Domenico Andreoli <domenico.andreoli@linux.com>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>

Thanks for the fix! I've tested this with the problematic module+vmlinux
BTF and the previously-hanging pahole goes on to fail as expected; also
run it through the work-in-progress CI, building and testing on x86_64
and aarch64, no issues found. If anyone else has a chance to ack or test
it, that would be great. Thanks!

Alan

> ---
>  dwarf_loader.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index 84122d0..e1ba7bc 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -3459,6 +3459,7 @@ static struct {
>  	 */
>  	uint32_t next_cu_id;
>  	struct list_head jobs;
> +	bool abort;
>  } cus_processing_queue;
>  
>  enum job_type {
> @@ -3479,6 +3480,7 @@ static void cus_queue__init(void)
>  	pthread_cond_init(&cus_processing_queue.job_added, NULL);
>  	INIT_LIST_HEAD(&cus_processing_queue.jobs);
>  	cus_processing_queue.next_cu_id = 0;
> +	cus_processing_queue.abort = false;
>  }
>  
>  static void cus_queue__destroy(void)
> @@ -3535,8 +3537,9 @@ static struct cu_processing_job *cus_queue__enqdeq_job(struct cu_processing_job
>  		pthread_cond_signal(&cus_processing_queue.job_added);
>  	}
>  	for (;;) {
> +		bool abort = __atomic_load_n(&cus_processing_queue.abort, __ATOMIC_SEQ_CST);
>  		job = cus_queue__try_dequeue();
> -		if (job)
> +		if (job || abort)
>  			break;
>  		/* No jobs or only steals out of order */
>  		pthread_cond_wait(&cus_processing_queue.job_added, &cus_processing_queue.mutex);
> @@ -3653,6 +3656,9 @@ static void *dwarf_loader__worker_thread(void *arg)
>  
>  	while (!stop) {
>  		job = cus_queue__enqdeq_job(job);
> +		if (!job)
> +			goto out_abort;
> +
>  		switch (job->type) {
>  
>  		case JOB_DECODE:
> @@ -3688,6 +3694,8 @@ static void *dwarf_loader__worker_thread(void *arg)
>  
>  	return (void *)DWARF_CB_OK;
>  out_abort:
> +	__atomic_store_n(&cus_processing_queue.abort, true, __ATOMIC_SEQ_CST);
> +	pthread_cond_signal(&cus_processing_queue.job_added);
>  	return (void *)DWARF_CB_ABORT;
>  }
>  
> @@ -4028,7 +4036,7 @@ static int cus__process_file(struct cus *cus, struct conf_load *conf, int fd,
>  
>  	/* Process the one or more modules gleaned from this file. */
>  	int err = dwfl_getmodules(dwfl, cus__process_dwflmod, &parms, 0);
> -	if (err < 0)
> +	if (err)
>  		return -1;
>  
>  	// We can't call dwfl_end(dwfl) here, as we keep pointers to strings


