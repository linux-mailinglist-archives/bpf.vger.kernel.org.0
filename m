Return-Path: <bpf+bounces-72836-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC98DC1C87A
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 18:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 064811888477
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 17:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC5C3502A8;
	Wed, 29 Oct 2025 17:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QwVsVj0A";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ghCDgexB"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE241A9F96;
	Wed, 29 Oct 2025 17:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761759706; cv=fail; b=ku7V5DJqdTjRGspl7LL0pNOU5fronX+r9QNwpc039XkeEcZ7DJXQP5Elh2UmPMzkRZX8znvAsSo20n/X+8Vz8jVaPf7C2yXTmRwMcDtsk7Opuz0sDlvM+C5+p3zlWaojJ+to6WRDgVM8oJl34+JBOjqaDXNP/sWluVGLgZHdDCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761759706; c=relaxed/simple;
	bh=OPJTaovkkN32JT0eQoNaHn1nbypa0FbpjdA0KlPAY2U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k9JDl0H2chcgeYpLIIawJ+8jyiu/g8vySmVFbSfKcOMI3z2yVc6fxxPtHJU0CwH2V56ggew6nLk/TYtsEwaZP4z7ibJ8w09mDsv1UCbFmLEvnq6LYwaGN4lFjYowcLlcrfTp1Tf7mA0xiTL1S47MCwyAyPezFqIYsTO+ZhBtwlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QwVsVj0A; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ghCDgexB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59TGg5pl011317;
	Wed, 29 Oct 2025 17:41:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=9B46nNHlyopjCOa8TN3kzWDqomSuSfquteZdKML60b8=; b=
	QwVsVj0AeJaYZhuh+azxk8fEbNGCrL1p0oQfxlCEit+dvdqCqoj98MGFSS8OKMQ5
	itaEfuXCFJ2qJ0puYgX3QCCTPy1I0AnAK0nD/dgpoP5q4PmxNtUzcW4Os1u26KMO
	gjEaDYpbVVgfpmAnbOcSsNyVaWIJNrud2Gu/WWXjhu1yCEp4HRdfIaF3z3Tlo1+9
	LS61RHKoQu+ip0LYtoViKl5pPspAqAsEtqlBO36N7hX8Y7Ha1N2CrpE3LhSfqFpp
	JFPgBoHDr1MLNEXCyflhxDSvfmsz474a06dOn5JlkmuDP+vYs1JoFc32QzjoW0xN
	HVQ1pAPrUGooWugvrcB5KQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a33vxjg6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 17:41:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59THe2Pf016120;
	Wed, 29 Oct 2025 17:41:16 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011052.outbound.protection.outlook.com [40.93.194.52])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a34q7yy5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 17:41:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Appo/cGHl021dy6iQaimnbpGr8zXLU2Dav1C8LnSk0Y+SJzuhUDCHGWWqzkjVGboy2iCVa8K+BghpoiZVHFwdD3vEFMXtfrurvvx31c+2W51A1VVUSq9f47llLO4SM0zLpgO37uGg56Xhb0fy4lm2WJaPRp/1OMQo7P8JjeRjAuipwT9L4cr808lmM8VVRiyOWUeRI0/qk3V0On4sFwlSCSD+29sxki4pwrOG5X9c4MBcVR/yz7APXt62Kr4VidDvjVyqFSm9pkein0ks90879vxn2Y5fkcsiab1kGhHedqvAX9VFpg4Oh66YO7AKS1wdaImYopb50DTgIWTOFepkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9B46nNHlyopjCOa8TN3kzWDqomSuSfquteZdKML60b8=;
 b=nDmwoI1Q1Ph9LL9jcvkq6uZ7BO20ouECUGQVot5VwaYyc81AKe850hWvLupxPrIJIt3U/uO/72NO7hGDqXcOUctAmHvTRB9WijGxoCgqNuYsIZdcz0W7bP9JfDTsq9Ugvd73ptqnvqxs1en9DQ1tgzJmWBQhwrCAveMOq6vQym5Ib4h4ULJw50Qk5996OnOymhtXi3EYelqBbRd3HgJ1hUEoKtw78GPteFdBGSIdVjKrcl4ksF3/KpOmNjuggDpekTTNyI5vNOuBFZhrWgY0lM535BfVt0hvf1FXuuvloMt5ffgMJQJRvWcbJL66puAON3B+lHgEOkCzVb3VHy+Zjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9B46nNHlyopjCOa8TN3kzWDqomSuSfquteZdKML60b8=;
 b=ghCDgexBfoC6OEdLszy3g81VCNAZALGTazLUUm64LtECczur9lQC9Ywk9SU8edLetecQP2wqp6gWklyJEqpfk+jBCFDFqa2C484U9qVzk9/Q/7uFEmKxsrIjWGQo2Y1LMtix5A33DJ/AzZuDhcAtRD2w7zDE4lGByy2gjUYXQ1A=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 CH0PR10MB5018.namprd10.prod.outlook.com (2603:10b6:610:d8::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.18; Wed, 29 Oct 2025 17:41:11 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 17:41:11 +0000
Message-ID: <1a8cc336-f6e6-4908-aae1-ed3189219ec4@oracle.com>
Date: Wed, 29 Oct 2025 17:40:53 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC dwarves 3/5] dwarf_loader: Collect inline expansion location
 information
To: Eduard Zingerman <eddyz87@gmail.com>, dwarves@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, acme@kernel.org, ttreyer@meta.com,
        yonghong.song@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        david.faust@oracle.com, jose.marchesi@oracle.com, bpf@vger.kernel.org
References: <20251024073328.370457-1-alan.maguire@oracle.com>
 <20251024073328.370457-4-alan.maguire@oracle.com>
 <6558dc0590b174174321899af9981053db76845c.camel@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <6558dc0590b174174321899af9981053db76845c.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0011.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::23) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|CH0PR10MB5018:EE_
X-MS-Office365-Filtering-Correlation-Id: a7cf2507-c128-47f1-3094-08de17125951
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WGRHbWZnditMczlVUS8zTjZvaUk2aHI4Q3Z4S0FBY0VvV01WNGdCM2h1aHFx?=
 =?utf-8?B?RGp1aGpFYzBJYUpockltMnBMeTFEek1TMEtDY3RUTXV4Ym9BdWFtZGJGTVZr?=
 =?utf-8?B?a3JvU3BrWTMwOXRCMStvRjZBMSs4Yi9rSzc5bC93R2tQNXpUVW1yeGc1LytP?=
 =?utf-8?B?QzJWL1d6ZHlWc1puNmRHNUlQUDgxdmY3SGQ5K2VlNGJzbURMSUNVZTlpZUd0?=
 =?utf-8?B?VWgrUGFqWEhLVmgzL2VUWnd1RjhaUHJXZGk0cFBsK3EvYUpDaXlFVEczaS92?=
 =?utf-8?B?YXhwQXN0Ni81UGtiNUl5Q0pSNFpuLzdVWHJRamo1VEQ2RW5nUDdNbWkwbjh1?=
 =?utf-8?B?RXBmZmJaYWNBMW1QaWdDWG9LQVpBT3BXSUZ0Umx1UHF0cGxGaDRWMkFnZjVR?=
 =?utf-8?B?YThUMGJnS09ocy9VVjZ2NEQwOGEydjJxRXBxUmRtcTArOUxYaDRzZ0V1M0xT?=
 =?utf-8?B?T29jN3ZHb2FsYjhvbkwzY1FrU3diU1BLNDZSZHRRWjZkTEFsS0xYTkJpUkdX?=
 =?utf-8?B?NjZHaE5xOU1mckh4UTBDQ3lXNWJJUnlEbCtUUVNCT1hLYnVxZXJKQ0RNSnFO?=
 =?utf-8?B?eEpEMnFOd1RFbERNY0xRSmxEL1o4RFRKOWJna3NKOWJYdlN0SkJtRWNHOHUw?=
 =?utf-8?B?K2RsaURmOEdoYWN6OW9FMzFUOERxVFUzNDRCU1AvczYzQ2lwRUZKOTIyaEZF?=
 =?utf-8?B?VzdWVThvUG0vbWk5M0U4SWRXVVdSK2Z3RThwcUQvMmg5T2x1eTJ5dXptUVVZ?=
 =?utf-8?B?Y1U4bThiVjhYd3RSTkRlK3BYYlB3Z2YvZkJZcTdOeUY2VkwxL1pQQzRNOUZm?=
 =?utf-8?B?d1NGWXcwbEtTRXAzSXh5eGMvWmRicDhGbjNoYnpMczdsaklZaXVBUGVPSHkr?=
 =?utf-8?B?NWt5NjRoSXMyekFya3JrclJxSFUvelREZGZ4LzhUdWYzaTZ6WTVYL3J1NmRz?=
 =?utf-8?B?T3NpV3pDNmx4citIVHdpOGZuODZvNDQ3THUzdXhDa3hwN1BndjdsUnBzT3Jp?=
 =?utf-8?B?LzdYZlVKSDRCb09rdE02b0o2b0dUL2Njd2t2ZW16UzU2aXZsbERzRFpoTDlN?=
 =?utf-8?B?SDJ3K1RLM0ZnWTlsUXdkZzB2ZTVoSGtlNWdkZWg0SzdRbmY0aVlML0RneHJK?=
 =?utf-8?B?ZWpoODJmODZmSlFieGQxNnNocldCVnhFZWhNeG9OT3VUaWJRbEkyUlY3Qmps?=
 =?utf-8?B?cHg3V2xEMnEyVnB0Rml2NFRsZFlFNGV5ZEg0bHVrOHNXdFFsdzNOdXhYcXND?=
 =?utf-8?B?NGlDM1hOMGxIdDFPUkVDV2wzbENBLzdEdDc3SUY4ZVV5TGxSTnBFMWo1Ymlj?=
 =?utf-8?B?WlF2SmRyRVFZUklRTDY0SkhJbHVDSGNHb0NkNXR4K2w3T2FUWGNYakk1RkxQ?=
 =?utf-8?B?Qi95Z3pDWURKaTEyVHhYZXVBaGxVZmlQNXAwZy8ySUpVQ0JVOWdjb2FzZTZN?=
 =?utf-8?B?emdnL0RmcUh4Q3NaTjN2cTkrVXpqV0JTKy84Wk92Y3NXRjVubnRsNVdDb3Bo?=
 =?utf-8?B?aFRQUzZGSVJSZW9Ca3huQUZiRnlvY3VvaGYzNlcyRWNVTWtpTFhkQWpqbGlR?=
 =?utf-8?B?NWVPNmhhYlBUNXovU04yLys3TitRdVllYTBIRG52SXpwdnN1bmhGNmt4WkV0?=
 =?utf-8?B?RXhQU2xFa2hCUHUwd0p6TFYyL1hiT1VGWHBFOVRPRjRnVEhOdi9LbUNZNXVH?=
 =?utf-8?B?ajFQY0ZQK3NwYzlOR1IwdXNoMnNHNjJMNk9kUmhyVHp3d1d5alE5LzRLRGhl?=
 =?utf-8?B?WFVmazN6NkJuQUF0Q3JEVzBDeTZ0L3hBNUdtRjc2Y1pJVi9xRTNVRGVzeVkx?=
 =?utf-8?B?S3BTbTFGYWxXK011QWpVR1RUeHZrVVVYNndreDVHRzdkamxLd0FjQXFaaWxE?=
 =?utf-8?B?ekN1RUhDVFlZelBTaGFqYk1IaUswVWtmUlJTYmo4cjFPUTNwd1hDbmxDaWZJ?=
 =?utf-8?B?QXlhakFMeEFOKzQzK2FSUUtxaGhNbys0Q0RzNTZ6MkVPUTBuUHlNd0FaYmQz?=
 =?utf-8?B?QmVsRXNNRzFBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1BoUnNCR00xUDFmc3NjUFJRelBUMElMM1NnZWNpTm9YVWJpUm9rQVYwYTE1?=
 =?utf-8?B?V1lFRXVOR1REQmlONGF4bDh6OGxueEhqS1BYQlpSMWlYdEF1SElmYUwxcGsv?=
 =?utf-8?B?azhxcm9xUTZ0UGZHSVFYY1k1ZUxybm9oZW9NSGtRWmNOcjVvOWpaRDA1akR3?=
 =?utf-8?B?OW1PUE1wdXQxL2tWdVhpWDR1eWFnUmJmZUJLREpWU0hid2p2QXVpd2JHc1ZT?=
 =?utf-8?B?bjJSbk5LamZuSEFEWXZNUFNXQ2ZVY29BQnNPR3BFRlNIVityVlRlcXdjbnc0?=
 =?utf-8?B?V1lNdm5PakpqZnNaYzduRXVUVG9XWE5mYm1SNjV5MmxhYXA3ZFF4cVcvbUVl?=
 =?utf-8?B?KzRYK2Fhd3hudFdyTk8veE5LVERQT1crM2R5RVFES1Z4WjNqaDBTRUxodSt3?=
 =?utf-8?B?TXgremtUTjRhcDM2K1dxOTdWcjJueVlJTUUxellJRHRTMzZQZWpxcmhYS0hV?=
 =?utf-8?B?dFQwSnBLa0VVdUlHTWU3Z2NLcUh4VVI3QmREbmdxeXNHR0pvWFphYm01Sm85?=
 =?utf-8?B?YjZ3SXVZSWRPTEl6WCtqS1FjeGJaYkw4ZHhsaVNJd215MzY3eGlrTXpUV2xH?=
 =?utf-8?B?MWtRdzhKSnlTVEh2czJzK3JjczR0Z09BT2tYOVc1emlXZ2R5cGdJb3luK3N1?=
 =?utf-8?B?RXdTOUYzYVdpanluaG9BR3AzdnJaUDhZR0luNStFdkNEOUFvcTY5WmFkNXRM?=
 =?utf-8?B?azNOYUQ4RnBuYlRubSt6TWdnWHdrdEFqRkcyc0FmNHV4ZGVsRDNFWk9WeGlQ?=
 =?utf-8?B?NEJRczFkM0tYWittT3R4NFRCUDBHeUs5SEFMT0kvMG5kMTMrdUxnSUtmWFhx?=
 =?utf-8?B?TmNsVTNXbEJmTGUvVzZpbDQ4V011aXVXeGFXU3A5OEJFQVlmREsxYjZuSFNM?=
 =?utf-8?B?Q1pnZHpOMWZTaDlkQTlVMGVObXJ4SVBEVW1wdE9yTWN2MnBCeUZIWGx3dW4y?=
 =?utf-8?B?M29NUTkvUEFWTEpkdEY1UHpzbS9KTWx5blppZnRwR0NWcE03a3hlTzVteFdD?=
 =?utf-8?B?QkFoZzU1QXE3RUQ5RHpEck9qaEJTZW5pRFdrR1ZMRkZOTHJBaFp3M3RtSDMr?=
 =?utf-8?B?SDhUNVlSSXJhQnhYS2UrbVdpd2U3TndURGgyME5jV2JzRmlaeHZlSGpNUVJv?=
 =?utf-8?B?MzhtNjlRNk1KdXhWd0I0TURmeWhXWDZHVEZYTUd6RlJ0NTdhemNSL1BIOHY2?=
 =?utf-8?B?Sk4wZEZPUGpGU3Q4NmQzZTk3NXJ3N1lGWTdDc1p6endXQlkxWm1wdDFiUE9N?=
 =?utf-8?B?VDN5MnM4eWdkdkZxcnhLeXI5OFJrenI1eHRSaWxiUklkeTJpRWVBcmk5dC9R?=
 =?utf-8?B?TWFtQTZjeGhBUzBkdDRnNXpZaTRDVEV4RXpwU1ZaTVY2VkZQK1doem1FUnUv?=
 =?utf-8?B?RzJubzhnaFpsY1QrZkNCelVRRXh2RXloSkEwV1pLQ1RyUGtZRXB0NHNYOVFr?=
 =?utf-8?B?MUhzZFViUDdJeHJDWi95MTdDWGQwU0xRcFZ6bnREVGRPQTlTNTBQY04yT203?=
 =?utf-8?B?cXRoUTZPK3Nsb0V3bmpqR09vdk5GSW9tSENMUU5qLy9JV0FhRFRNeG1IR01q?=
 =?utf-8?B?V1ZXQ2QwYmtobGtjVlRZMFlaMTZqV2lDMHlxVW84RlNUWktobklVaklOTnRI?=
 =?utf-8?B?RWZ0czVSVEMrbjdSRzdCUVBHMkQxVzY1akthZDJGY0lNdUZPcHc0SnYvSUhO?=
 =?utf-8?B?dkZ4QkVVWVZXd25Tbzd0enNHRHl4YkVGc1FGNi9iVXY4QzIzNGt6WER3QytS?=
 =?utf-8?B?V2laU3VzaTBTN1NXVXhXbzhyMTlsRlp6TW5sd0F2dzloU2lBMEhIVW0xNU1T?=
 =?utf-8?B?WUxENWxqYU1TTjMzUHNzdWgwcHBBcmdWM1NvN1J0SGxzenpGbThyY2ZHc3Rw?=
 =?utf-8?B?Y0E5VkRRT0oycTJITkdXazUwRmgzYkpIa0xRa2RYdVYvZ2wraklUNVdWOWRF?=
 =?utf-8?B?aGllUjdUdlBEbXVoT2dVaUcyRHZQTUxXc3ozb3VpSnJ6ZXBIdUJ3S2ZpQ3ho?=
 =?utf-8?B?cFNIaDBzUHBRcERnNGdZTFI3bllWZDZqTzlNazRhbHhFVzducHFXZXFQVW5a?=
 =?utf-8?B?bTlhc2trLzIzdWtKRFNaQms2T0pqdkdleUFERGUxalgwZTBrN1RPVUt3WkU0?=
 =?utf-8?B?Mk5ISHd1SUtMTXV1MmJOaUFkbUgwKzNJb0hON0ZrNnJnaEN6alg2am5ERGRs?=
 =?utf-8?B?T2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	w0LcRl278LZhCpeQ/BAUnvTPY86C40c2vxQS0sgl31GmrGZoMGvfg8xCw1IqA0lNxMY+PinZA4VgBvvzsFosV1xDNgafxA2cVM3tW/qQV/DVvfhS8CJC9DdqYbz7+wEs0auKi9o71o0jVSR2YJ11UrC1fIEs/DE6X5u4CXDdRXRCgoADKdPi8holNuazn2KyhrpxmnfNf2kDKvQif6qaQ4wEMVnHsnOXhby136fIuOwNv1Xyfncb1zOlc9QL+pudPfyn3DvS7a45NVnVe9Y11d/MvHjOT4ixyr/LnqgsZZVvaqgQYna9PfrT7XAhaROZsl234IgY6950DdBj5L7XVNbOgW0RveTNTJdQX+emm87SkzApzPZch5gSa+WZF7aCjaOl+f40UGZxjeVjIBUSJsWmwrVwAJymeh9wFwdYGPOcKpHSBCxKJfYO2nUQlKyrBA+KeC5zGNabS2beYfDI9s6vmgxWRDZT1qkM1HwzqCVqN/V+Xf8yJDc4AwvT2d677fwEbF01/xi2B+ogg7j6Gefg3OcU0tvlB1MIvO9sl7YXD1/R3nm+YSUSxAQr/ARr7Vsk5BOc2vopGGTSsTCRIA3fBKEBK4qiz729WttQhe0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7cf2507-c128-47f1-3094-08de17125951
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 17:41:11.4915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I4u3BXFoF8myyDqHTG3FJmmLVYD3bsZucbVG4vxaq/0FlryuP+69GSE6fzWyFrwzCCe6KXoHcIWb1jASxiBdZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5018
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_07,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510290140
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2MiBTYWx0ZWRfX2qhh/q7x1qLz
 Wjp6VM7LU16AffQgbaL5LTk2+DZHycBgQI/09Xhd5NSmWpwyikjj8XwI4PuZz7+ELxRjTnsBVy+
 gtDlN3vJo/YsVZozGJ1AJeqiWYQFVmwN7KB/J1TeG8GzyX3C4oUw2YmS3AQh31BbBqOHxJY0GHg
 B33sYg6/SiWS4MEqW7Hab7tV+1Bydj0hkBuiWv2Tj0A4Zq/d0nXEIP1QKir9TgAUYAWgr/NzgFA
 fjqKPvJ7miOoE+1ldKGvLjyKXwLApJiLzSx6NfypfKC6R5A2wi2eszWMbG1G0+A3WdBbHehkXL1
 0LSJGJYpfnCDG/FtSHiNUTcWE5cxo3rzB644tp24gGCyCjTRL6brN9mXYgvdmUoY0ysTh5xYP3T
 2ILYPXhnYVL90qerhsaJ1OXzWjd7ncVb4rXpTkU69pWVSkf2Fi0=
X-Authority-Analysis: v=2.4 cv=M/9A6iws c=1 sm=1 tr=0 ts=690251be b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=UF6iUOY8elGBXQVhsp4A:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12124
X-Proofpoint-ORIG-GUID: G8J9Wyct8odZ0w2H4cJQ40mZ8P7ftAf7
X-Proofpoint-GUID: G8J9Wyct8odZ0w2H4cJQ40mZ8P7ftAf7

On 24/10/2025 18:55, Eduard Zingerman wrote:
> On Fri, 2025-10-24 at 08:33 +0100, Alan Maguire wrote:
>> Collect location information for parameters, inline expansions and ensure it
>> does not rely on aspects of the CU that go away when it is freed.
>>
>> (This is a slightly differerent approach from Thierry's but it was helped
>> greatly by his series; would happily add a Co-developed by here or
>> whatever suits)
>>
>> Signed-off-by: Alan Maguire <alan.maguire>
>> ---
>>  dwarf_loader.c | 277 +++++++++++++++++++++++++++++++++++++++----------
>>  dwarves.h      |  48 ++++++++-
>>  2 files changed, 266 insertions(+), 59 deletions(-)
>>
>> diff --git a/dwarf_loader.c b/dwarf_loader.c
>> index 4656575..a7ae497 100644
>> --- a/dwarf_loader.c
>> +++ b/dwarf_loader.c
>> @@ -1185,29 +1185,54 @@ static ptrdiff_t __dwarf_getlocations(Dwarf_Attribute *attr,
>>  	return ret;
>>  }
>>  
>> -/* For DW_AT_location 'attr':
>> - * - if first location is DW_OP_regXX with expected number, return the register;
>> - *   otherwise save the register for later return
>> - * - if location DW_OP_entry_value(DW_OP_regXX) with expected number is in the
>> - *   list, return the register; otherwise save register for later return
>> - * - otherwise if no register was found for locations, return -1.
>> +/* Retrieve location information for parameter; focus on simple locations
>> + * like constants and register values.  Support multiple registers as
>> + * it is possible for a value (struct) to be passed via multiple registers.
>> + * Handle edge cases like multiple instances of same location value, but
>> + * avoid cases with large (>1 size) expressions to keep things simple.
>> + * This covers the vast majority of cases.  The only unhandled atom is
>> + * DW_OP_GNU_parameter_ref; future work could add that and improve
>> + * location handling.  In practice the below supports the majority
>> + * of parameter locations.
>>   */
>> -static int parameter__reg(Dwarf_Attribute *attr, int expected_reg)
>> +static int parameter__locs(Dwarf_Die *die, Dwarf_Attribute *attr, struct parameter *parm)
>>  {
>> -	Dwarf_Addr base, start, end;
>> -	Dwarf_Op *expr, *entry_ops;
>> -	Dwarf_Attribute entry_attr;
>> -	size_t exprlen, entry_len;
>> +	Dwarf_Addr base, start, end, first = -1;
>> +	Dwarf_Attribute next_attr;
>>  	ptrdiff_t offset = 0;
>> -	int loc_num = -1;
>> +	Dwarf_Op *expr;
>> +	size_t exprlen;
>>  	int ret = -1;
>>  
>> +	/* parameter__locs() can be called recursively, but at toplevel
>> +	 * die is non-NULL signalling we need to look up loc/const attrs.
>> +	 */
>> +	if (die) {
>> +		if (dwarf_attr(die, DW_AT_const_value, attr) != NULL) {
>> +			parm->has_loc = 1;
>> +			parm->optimized = 1;
>> +			parm->locs[0].is_const = 1;
>> +			parm->nlocs = 1;
>> +			parm->locs[0].size = 8;
>> +			parm->locs[0].value = attr_numeric(die, DW_AT_const_value);
>> +			return 0;
>> +		}
>> +		if (dwarf_attr(die, DW_AT_location, attr) == NULL)
>> +			return 0;
>> +	}
>> +
>>  	/* use libdw__lock as dwarf_getlocation(s) has concurrency issues
>>  	 * when libdw is not compiled with experimental --enable-thread-safety
>>  	 */
>>  	pthread_mutex_lock(&libdw__lock);
>>  	while ((offset = __dwarf_getlocations(attr, offset, &base, &start, &end, &expr, &exprlen)) > 0) {
>> -		loc_num++;
>> +		/* We only want location info referring to start of function;
>> +		 * assumes we get location info in address order; empirically
>> +		 * this is the case.  Only exception is DW_OP_*entry_value
>> +		 * location info which always refers to the value on entry.
>> +		 */
>> +		if (first == -1)
> 
> <moving comments from github>
> 
> Note: an alternative is to check that address range associated with
> location corresponds to the starting address of the inline expansion,
> e.g. like in [1]. I think it is a more correct approach.
> 
> [1] https://github.com/eddyz87/inline-address-printer/blob/master/main.c#L184
>

thanks for this; I'll try tweaking it to work like this. The only thing
I was worried about missing was DW_OP_entry_value exprs since they can I
think be referred to from later location addresses within the function.


>> +			first = start;
>>  
>>  		/* Convert expression list (XX DW_OP_stack_value) -> (XX).
>>  		 * DW_OP_stack_value instructs interpreter to pop current value from
>> @@ -1216,33 +1241,154 @@ static int parameter__reg(Dwarf_Attribute *attr, int expected_reg)
>>  		if (exprlen > 1 && expr[exprlen - 1].atom == DW_OP_stack_value)
>>  			exprlen--;
>>  
>> -		if (exprlen != 1)
>> -			continue;
>> +		if (exprlen > 1) {
>> +			/* ignore complex exprs not at start of function,
>> +			 * but bail if we hit a complex loc expr at the start.
>> +			 */
>> +			if (start != first)
>> +				continue;
>> +			ret = -1;
>> +			goto out;
>> +		}
>>  
>>  		switch (expr->atom) {
>> -		/* match DW_OP_regXX at first location */
>> +		case DW_OP_deref:
>> +			if (parm->nlocs > 0)
>> +				parm->locs[parm->nlocs - 1].is_deref = 1;
>> +			else
>> +				ret = -1;
>> +			break;
>>  		case DW_OP_reg0 ... DW_OP_reg31:
>> -			if (loc_num != 0)
>> +			if (start != first || parm->nlocs > 1)
>> +				break;
>> +			/* avoid duplicate location value */
>> +			if (parm->nlocs > 0 && parm->locs[parm->nlocs - 1].reg ==
>> +					       (expr->atom - DW_OP_reg0))
>> +				break;
>> +			parm->locs[parm->nlocs].reg = expr->atom - DW_OP_reg0;
>> +			parm->locs[parm->nlocs].is_deref = 0;
>> +			parm->locs[parm->nlocs].size = 8;
>> +			parm->locs[parm->nlocs++].offset = 0;
>> +			ret = 0;
>> +			break;
>> +		case DW_OP_fbreg:
>> +		case DW_OP_breg0 ... DW_OP_breg31:
>> +			if (start != first || parm->nlocs > 1)
>>  				break;
>> -			ret = expr->atom;
>> -			if (ret == expected_reg)
>> -				goto out;
>> +			/* avoid duplicate location value */
>> +			if (parm->nlocs > 0 && parm->locs[parm->nlocs - 1].reg ==
>> +					       (expr->atom - DW_OP_breg0)) {
>> +				if (parm->locs[parm->nlocs - 1].offset != expr->offset)
>> +					ret = -1;
>> +				break;
>> +			}
>> +			parm->locs[parm->nlocs].reg = expr->atom - DW_OP_breg0;
>> +			parm->locs[parm->nlocs].is_deref = 1;
>> +			parm->locs[parm->nlocs].size = 8;
>> +			parm->locs[parm->nlocs++].offset = expr->offset;
> 
> I think this should be `expr->number`:
> 

Hmm, I thought the bregN values signified register + offset
dereferences? Or are you saying the offset is stored in expr->number?

Thanks!

Alan

