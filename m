Return-Path: <bpf+bounces-64772-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F2CB16D35
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 10:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2E2A7ABD0A
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 08:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B694A29E111;
	Thu, 31 Jul 2025 08:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lUzYJejS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Lriat3T4"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F39229E0EF;
	Thu, 31 Jul 2025 08:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753949357; cv=fail; b=uh8dBiSU0crEwpsashit5mvFvZyISKD9shtR1t5SABK5ekRbJV9PuXzn3yL1S5uOFZ+bwxkvcNxPQ6zVaEKAQDiibHHPbPOjiAX3prtmDzb2n85AGbg/ADpSy3ShRXf9CoKjzjk9EWAttifdp4hXYPoJJ2BO9Jt/JLNkFYqKo30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753949357; c=relaxed/simple;
	bh=uudrXfJXTOWP7yVRZD727oniTX0J8FEwpNH5X9orKwA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MoEHCMEo907JaESI8GCJyHmu4WeM5ndDXnTE7H48BVL/IgUbNe1+JSjuUCugZUhU/nISHg0Rogza7MMDqVYJBHvvLwgSfSuF+cpU2qPAWauAFDsjJlTi+3yDbBPqxf4JyPVghzVA150p3YVDQFR8wwgNRMNEF6dFq29NNHeQ3x0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lUzYJejS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Lriat3T4; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56V7C3NB009880;
	Thu, 31 Jul 2025 08:09:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=vnnEtto7YHJlPdzXqW5Jqk7amAMLyW2yPrBTK4rUz6k=; b=
	lUzYJejSmCC51LkmxXeDuaFaJ8Ud/0R4vEvIkHYZLg3SuxsZZaWj2pulYxS76Oc9
	lqaVojl7BpjQVgbjHeHQ4qfv31jlz0TnKaXN2jpE71WxyIbVhHjfdAcvjkrtmGGE
	MWttkTDWnOX8YHjuWvQX2N13HN0QyAoySorYk88x/+kI57ZcBviCwtNOoxwR4pj4
	cciEHEFgEvaUOvL8LRLD/BxGdSQBDg29dcmGS2rRSpYfCFR/grZ8Fz42z1UhIFm7
	RAB0NCdjxdngeTCgg28ai9awY7ZRm2A+pNtwmi7KaITcc/G6pz5s8Qbgqa89I8md
	U6lVxUp2JZ4fFx0zjeqarw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 487y2p0eyq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 08:09:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56V6dcVl034491;
	Thu, 31 Jul 2025 08:09:11 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 484nfcduhd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 08:09:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lf2f2Ij0nm7eqyHtLvjZ/rRTs2XxYQh80YtOVGk8M+9uwHsvVs1w+vG5WQNWFksZ2sYW7clkbV1g9W09FdXmx69oyGFNT5SViP7/lvntHagtfqeJEmyN+yuhQ4+B2YNDedLDm9eQhetqu2xdIyMPMxbFzezkVE2PW1WHEA8ZF1COO/0CJ7qpjpBQfSG9vQVl2OYeWdy93n3hINk/xpd9G32Q37ghjSitvMc3y0o50ryhoYVFqhpZsgY1NYVeIlBriA0qMxlr14bah4vj3P6Y7/1FpfjuEHfYXcd9SIlDkqE63jervXP6wll6wduCieNHL+WWultzb+WtW2r1lhOAGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vnnEtto7YHJlPdzXqW5Jqk7amAMLyW2yPrBTK4rUz6k=;
 b=ZnSShfjbbHteYKbM+vHz9RMAgh559aFavhg9dJ42aX61/6u7+miZHP6r9oocGPaMtdRaZrXtepCC7JEAx/ibtC7sGibwIsZ2R11s/H+x+7tE2AFNi3bqWA5LiEf/IKiqS85noPb4eeCPYVfd/NCw7A2kvgZul1UeguFqswcVFzZoLsynma2qU3foEJjAu4CW7AAtvvuGTBiv+7DF6PvOfsMvcrKPFOUT9MDprjD72xvyz4guAHgxSR3EgoFFrxZw9nRHkdVGDplEnIAXFlUzhTKa93SQ/WA0b09Ty4kNpudJpXNqwHw16//62M0twCChk55kISRhDhYZ6Ulp53u+lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnnEtto7YHJlPdzXqW5Jqk7amAMLyW2yPrBTK4rUz6k=;
 b=Lriat3T4kltluBGDMc9DlQkr/yQzqelpLd7ieOCvP2LXP5pc8H4pVSlVTPmifwzF1KZUvlpHLzwvyrF9wYFa1DVt6XCflS68zbPnIKjrc3eDNO/tepYhGEpGzB3hcUvJsHWO0lG3lX6dfT7EcyQoVJwNylMqbyVgOhxTDeJJ5UA=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 LV3PR10MB7981.namprd10.prod.outlook.com (2603:10b6:408:21e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.13; Thu, 31 Jul
 2025 08:09:08 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%6]) with mapi id 15.20.8989.010; Thu, 31 Jul 2025
 08:09:08 +0000
Message-ID: <487f1944-69f4-473f-a908-5be2a852ff51@oracle.com>
Date: Thu, 31 Jul 2025 09:09:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] pahole: Don't fail when encoding BTF on an object
 with no DWARF info
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: dwarves@vger.kernel.org, bpf@vger.kernel.org
References: <aH-eo6xY98cxBT1-@x1>
 <92260366-5a4f-42bb-8306-2d8e25aba4e8@oracle.com> <aIE3j4kcn7pzLA4P@x1>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <aIE3j4kcn7pzLA4P@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0098.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::14) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|LV3PR10MB7981:EE_
X-MS-Office365-Filtering-Correlation-Id: 711942a9-dca9-4bc0-4063-08ddd0098631
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a29LYW1jN2s2MzlHczFOQXNBaWE1Q3lodTNhbm5nYlZYS0VkTzcycGQ3VHo1?=
 =?utf-8?B?M2lQUCs5RjhUT2I4YXRMcDJ6SnhaMXZNRDR4YTdqNzhCVXIwd3JxRm9GU1hn?=
 =?utf-8?B?QUJPdWhnT05aT1M0MHRJYWJ0UHdwd1o1WHc0V1ZBdjRTczN5S0NOQ1huV1hX?=
 =?utf-8?B?MFphNTNPbzg0cjRSN01vcnV3Sk1ROFIvZm5QeXNxSDY3SzFDbUJ4RHppQ2Rt?=
 =?utf-8?B?Wmc1cmdvWHRyQllGRDNTU2hNVVhIUDAzeUluVExPdEZDMitWbmdreGpCdjQ5?=
 =?utf-8?B?dG5rNytOSzEwTCtrSjBQYW14RkVCVEtWSXFwR1B1UjlOSDYvcU9VMTVFWnRx?=
 =?utf-8?B?RVcvdDlZTUFVdlpLeXIyUjJOYytFMjladVhxNHV2ckNJYkErOFZ5d3ZseUtk?=
 =?utf-8?B?ZGJPTCtrYjhoZnZ4ZmxLRGw0S284OVdpZEV0NVVsUVBSRHViRGNnU1dYRVhJ?=
 =?utf-8?B?cXRaMHVxMnkxbkQ5aThyVDVDTXR5YitiWGpqK1htQ1JDUk0wbUlhWkpLdEpN?=
 =?utf-8?B?MytMS0N0Ty9TeXk3VFdPZ3Mvb1gwYk1sS2w4MzMyditweU54cGZNay9ybHJu?=
 =?utf-8?B?MEM5UDJaZlQvOHcremo2TGJ2STdERlBEbUIzZ3EvZndtWjFLTnd0VUp6NWZB?=
 =?utf-8?B?RHR1T3d4eWdlc0IvNDQyQ3N5YWlSclp4UnpjcW9YTTBhVkd0SXFNd2U4OGFI?=
 =?utf-8?B?cXJEdGhqVllVRDZLZld2TlJGclpqczlGTXArcmVFM3FwWXFLSnFXN3VuNVVO?=
 =?utf-8?B?WjJEVWR5N2RpSjhVc21SbWFnMy9CYWVYb0RFdlFoVEpERVZYYW5xRWZuYzVP?=
 =?utf-8?B?OU1DU0lHbnhMZm40UGx2RmFsN1htYmdyb2FnYnRvSzJ3czZLYklpdFUvY3Fa?=
 =?utf-8?B?VlRrbGNSK2wxeGZzZXRIby9kUnBwSWEvdS8yZ2FvaExmenR4ek5UK0s0Q3ZU?=
 =?utf-8?B?V3BOSkpNZjdNTXEwRm1LbGhUNVIvZ2NOdXoxcXpFR1VSMWhhbGJWbzJiMVJK?=
 =?utf-8?B?NFlFMGdNLzNvdXhPN0dkRVdTbFFUV1paSGdwVnFWQ0xqVWxRTkUxcWFNRnc1?=
 =?utf-8?B?OXM1N3N1bHMxZU9iMzFXdUV6a0RQZTBUK0tnVXJrR0d6QVhNK0ppRllDUTRx?=
 =?utf-8?B?dTVCTHBSQzhEUlh3aXhsemVIeDFaaFV6UnlzSmxqYkpPVlNWRjdvZVp2aXJV?=
 =?utf-8?B?U0F4OWsyRXNYZzcxOVl3ZGRwT1Z5VlM0U3JPcS9qR3ZKUkpBQ1FkWTh6Q08x?=
 =?utf-8?B?djdJSVBzQk1RN0xoTjJjU1Z0SElEdUduSzNIcGl6YWQ4alZocmhNYnNYbkpW?=
 =?utf-8?B?aWJqWnpYYlFwTEhxdFFncS9sTzFRNUFqczRRNUFZVlh3VFBVbml0ZDd1Q3Fq?=
 =?utf-8?B?eDh5aXp4cml3SnYyL2JndVNRQjVaWUo5bURaQlR1NnUvME5YUllsSEN3dXdW?=
 =?utf-8?B?YTR1blJMb2hmS3d2enVlems2TTNOZGNoMlJnUGpQWG1VenVNQ1Vpd0RVR0Zu?=
 =?utf-8?B?OHlUZ0xkUWszMytHVFZ6UVV5UTB1aXlJdXZBKzVlWVZtTngrc0ZJemxScVox?=
 =?utf-8?B?RWNmSmVrazI1b2FMVERENWdFdXdjM0JqNERVSjZFcm8zRnZ5RGVEK2xBTjFx?=
 =?utf-8?B?N2hvYmhmMnBHWEFYOEprdkhLem9CaE1KY3ltaUpybFd3KzF2SElRelJtcDdM?=
 =?utf-8?B?K0JmNGJmOGVSYUwwWFZ2UEJhMTJlbXRxUFQ2RWU2RFBDZFdvcE01RGljVnRp?=
 =?utf-8?B?b1FVanVsbS9qVkFqWWgwU25YdTFJdVh5L0pTT2RnYnpwSTdSQ1RXZk5zR0FT?=
 =?utf-8?B?eG5jUzVGMkkwcEU5aTh4OTBGOHBlaGZxc2xxa3JHcW1jL0lMRWsxQ0tvalRx?=
 =?utf-8?B?ZGxMSzkxbVJQSWZKL3dtaENEZ3VEcSt4eGNyOUpaY0Z2eFFsK3g0d202Uks0?=
 =?utf-8?Q?ciZFRrlgG6M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWxMZnNBa2djUWJWOWhmZzNxUnVHUVBtTkZnNkxCbzc1OTRuK0pOOVRqWmRO?=
 =?utf-8?B?WXNDTzdPdXdMQ1FpTm45QVJpeFlTcWtJM0RKVzB1UExvSjZHVzcyRTVzUFp4?=
 =?utf-8?B?VW1hWHgwOEc0S2ZFWktaOVEvVkQxcDN3K21wYU9GeGpFRlVpamx6TzVjbEpL?=
 =?utf-8?B?bHJRR2VMMVgzTmQyZXVBRy9EVDVuVVlUTzNEWTliSVJHdStaM0daTmpiTWVq?=
 =?utf-8?B?NXdxQ1d5K1ZXTWkwTzNsbThjZDRHVFNjdTR6ckZjcHduRlZtMzFsRkRVWmdN?=
 =?utf-8?B?WE0xdE4zZjRXT0JvTVhMWXFhRVd4UmJOOHhWQmNJRkNRK084Y3NXUEdyNy9l?=
 =?utf-8?B?ZS90VjlJaW1oYnBNalo3WTdaMC9SRTNaakJJVGUyK2lwclkwc05sZU5WOTZz?=
 =?utf-8?B?SUhrTUhGNHBOazQvNlZ3N3gxVkRNT2RvQ1lkRUxqSXVNRzhmOGdocVk0emZN?=
 =?utf-8?B?dHVrVHREd3g1RUs0RlU2ZXRhYm9QaHdwUjFsSlJlNTd2bE1YMlpCN05DbVFw?=
 =?utf-8?B?UkVvRDNvU0RjMUliWU56c01CNnUxVlJORFUrYlI1ZWh5T1V6Rm9yeXUxSDZZ?=
 =?utf-8?B?VFFubi9zSUxFWlMzZlk3YUV2SHQ2ZjdQU2h3ZFZjSG95ODRZK1RRbmdYa1VO?=
 =?utf-8?B?VWdvZDdOS1dRcUpKazdsb2xZWENFbUo3TnpOZk9zVXlUSGpzK3pFN0RvQnEy?=
 =?utf-8?B?MkRMVk9zWDNMUjk1Qk5xVk44YjBHdWpMMFFkczVrWTFMR1grWVJpc0dEeFhp?=
 =?utf-8?B?dzloQ25TOWwzTlpyek9OQk02aXNJcUJTYmJSaC9Id2dXcWhtTVg3Q1JmVDdo?=
 =?utf-8?B?TllSUjBRSjBZNEtaVElEVk5ZNTliUkdhQlpRNXYwK1FTU2l6MVZSMmpYc0RR?=
 =?utf-8?B?VWVpSU5LL0pUUXNNZ0ZjTlhEakIzbDk0bi83YXI3QzJ3cG1pRm5Wa3F6Rkpa?=
 =?utf-8?B?QUlucUswN20rWWxWQmp5aERwbU43WFdRMHo5NzdlV3FiS292ZnFSMnFTYkhT?=
 =?utf-8?B?cGcvRld5SDh4Q2JvMTREckFyU2MrbDhuY09ndXd5MGdRWGtkdUNLN2UyT0RN?=
 =?utf-8?B?RGlJZmtxMzQvQkJEZXV5aEhzNkE4Ty90SGgrbXAxbWpLckxRWTB3a3kxL3VC?=
 =?utf-8?B?dmJhdzdtWWRacWkwcC9JMzNpSDI1cjROR1VyVHNzSFlURzBFd2x1eFJ3QXlX?=
 =?utf-8?B?WlcvelVlVkVNM08wNzd6YXcwcUI0TGZmOVFNeWc4QUNlcVMxa3dnZU1Vc1Y4?=
 =?utf-8?B?eG5LK25aWnQ4TGx2TjV6blErblhEK3QrdS9uUWZmSWsyL3VSNE54aU0vYmpK?=
 =?utf-8?B?cVZYNU5STE9GUWZSMWROalpXaVVaQTRGS1l1WnY2TkJ2bUhraTFqTktnY2Zi?=
 =?utf-8?B?bTQyN1NvYWtTMnNMajlwVVNyY0dHcjU1S084OUppOEJvMUtHU3J2Y3BkUGFz?=
 =?utf-8?B?SW51RlEzWWhYeXNZa1p1MFdhN09tUmFwd1ZhaTZlSW9tVUMxMlAzbldjMkwz?=
 =?utf-8?B?aGtzYXFYTHFsVFc4N2FtT3packh6S2cwbmRwWkJ1RXpxTko0MEcxWHphcXRR?=
 =?utf-8?B?dU51alphMnYzVGI1SjFYZjRHK3RkcU5XODlYWXVHMU5SeUY4TVRaenRpL2Vl?=
 =?utf-8?B?cno1RDRoU1Z1ejhLS21KR2JBc3JWK09SNDRFcG1UNklWa2JYdG9lMXE1d2tj?=
 =?utf-8?B?T0tQS0dkMDVxK09EcjNoaW01Q1pDWk9CcmcyTU5raDhyTEtJRnFFQ3RrVGhU?=
 =?utf-8?B?VzZrbkJpUVRwMjM5enpQeE5VUHEvN1NSSXpoYkQ4OGdaam45RmZnek1iREV1?=
 =?utf-8?B?NlVjMHlJeEkwMndjUnNsQjNkaFdGOENsNkdiT0N4aEdTQzRubUVaUWh2eTY2?=
 =?utf-8?B?TmtRaFVneTJsY2tSV3VsV1ZPUlh5NE82ZnAwWUwxTWxXU1JJKzZtUmI4ZkE0?=
 =?utf-8?B?eVBMTWNweHd1bnpncGNMUTh0b2gyalVBOUR6Wm84cEx3RWFoWC94WmpkWEkz?=
 =?utf-8?B?QVR4SitYVlZKZk5Vd3BjVmxHVHIxWXcvaVZZdDR3Kys0TlcvMzNVUFN3SWVV?=
 =?utf-8?B?SU9GQmxmOXR0VUtYaXRXSzh4K01Fc1lORDFYWXhNSU50NXowRnlyN2FIdS8y?=
 =?utf-8?B?YVExQVRUWThkd2ZSSjdPMGR3ejJReVdNTGI1ZTBsSFh4ckhraUdLWmdjemJZ?=
 =?utf-8?B?a2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TF/vb4aiiN0ck+7ZXMU3djLetYl8mKSzeuJgEZRo76RAURFSg9t+QFh5oZCKwADtX1wan8MK8dMRDFHZGv1o4DG0dJwoFqymVAipPfcWDaTxUwW8T+oJr0RQkao8dfobYPBZ/PRXcRgnhxODB99eQZ0cC5XZI9Ys16AnyFKITHL6DFGTYwu8cTwELiStaXQTu5GpUjuQFHT0v3HkQ/18WaPZCnoLtukUZTtjF2ysavR5+sFs1DGLcs0rYOhKLL7pQVMYFneod8NyGEqY/R25JitckSLTwiNO+sHz+NjShIdqs/3A8i2reuT27hIUfGrVjMIPMkwU4TzrvLNc7CzELlEPtypDMzBXBDMXuWDmdRVmVx8bDlBeP5MP+HfPk2UEh5ie109+6ihRxZB9+OlufgqmBeh2+zkwyq9WoWbDGFsI+O0quivTu7UOO9QBEVWiwRFu6HXrgsGUO61H2f459wX+ETJWljFqkws5D8SpU/QrCTR80G+ATumiRLi79u7LS3p81Ptjnp58l36Tu6DQs8ZCi4KJU3U90+b20AJaxZeID/NnW6Da4vwjnhEPyxr6WuX5chcZ3pqvyLkG1uFAjh5xdjwMcbeBdBWjPqRinpQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 711942a9-dca9-4bc0-4063-08ddd0098631
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 08:09:08.3773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JE7oazxpTmqKPvwkzikfYv2I5T81qvzqFaAyfq+UuD4fpMlSmzbszHC6Iohnbfu+FsO2zSoHDkayS56EF6Ly/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7981
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_01,2025-07-31_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507310056
X-Authority-Analysis: v=2.4 cv=COwqXQrD c=1 sm=1 tr=0 ts=688b24a8 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
 a=yPCof4ZbAAAA:8 a=VIoVQtpcpcpaXxwSQqYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Wpy6h61pdNoNOhgB0_U5LoOjuFFFSXJZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDA1NSBTYWx0ZWRfXx2esRde1g+iN
 JryqYDFmUQ99lHQ3toUEdV6m5CSXiCR9XxpSTG+fpdfhN5zIjaENRnv2l01uGiQbTveUY+bdQo2
 fGD219qtsk0jAwBOwd2O2a/T5HuVAKlKvEjMvAGdQRmr/+L2Xbez8hPsRYXV7enhLjJIjbl2h4W
 cc5Nb4Gsum+EPqLBO7DSryYLLYHIlr9Vf2aB1tmDn2+oDKQa9ZJmxPRrxdOR3vRD6xxCQT/HkRT
 SGvATdirkZg4TdccKtUgCW0vZx1KVEedPE10K7DjJvLwRv1BXLEF+/l1XlLO08EBgh4P6kHiw7F
 OzF/mdrd0cYF/+cpxp38fTjc5tx5GMlK4cCpuNcnNy1ZBUvgwhT2PCryJ34BNhCt9mGK4QFzWn6
 6Q62jvGuFF2d6c4CCAknhyq+J8ByWVOrtFi0qOQwBmSrV0/ToeMHAlbrx55HSLVyIl6PNtX0
X-Proofpoint-GUID: Wpy6h61pdNoNOhgB0_U5LoOjuFFFSXJZ

On 23/07/2025 20:27, Arnaldo Carvalho de Melo wrote:
> On Wed, Jul 23, 2025 at 08:00:31PM +0100, Alan Maguire wrote:
>> On 22/07/2025 15:22, Arnaldo Carvalho de Melo wrote:
>>> If pahole is asked to encode BTF for a file with no DWARF info, don't
>>> fail, just skip it.
> 
>>> This is the case, for instance, in this file in a kernel build with
>>> DWARF info generation enabled:
> 
>>>   $ pahole ../build/v6.15.0-rc4+/arch/x86/purgatory/purgatory.o
>>>   libbpf: failed to find '.BTF' ELF section in ../build/v6.15.0-rc4+/arch/x86/purgatory/purgatory.o
>>>   pahole: file '../build/v6.15.0-rc4+/arch/x86/purgatory/purgatory.o' has no supported type information.
>>>   $
> 
>>> Before it was failing when encoding BTF for it, now:
> 
>>>   $ pahole --btf_encode ../build/v6.15.0-rc4+/arch/x86/purgatory/purgatory.o
>>>   $ echo $?
>>>   0
>>>   $
> 
>>> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>  
>> Only potential issue I can see is that in the usual case of encoding BTF
>> from DWARF in the kernel we'd probably like to fall over if we can't
>> encode BTF due to DWARF absence. However current Kconfig dependencies of
>> CONFIG_DEBUG_INFO_BTF mean this can't happen in practice I think so
> 
> Right, this is an exception, just some .o files out of thousands end up
> without DWARF.
> 
> So I think that if we take --btf_encode as "Encode BTF from DWARF, if
> DWARF is available" is a good interpretation of intent.
> 
> - Arnaldo
>  
>> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> 
> Thanks!
>

Applied to the next branch of

https://git.kernel.org/pub/scm/devel/pahole/pahole.git/

Thanks!

Alan

