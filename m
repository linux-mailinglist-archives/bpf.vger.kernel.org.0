Return-Path: <bpf+bounces-71576-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B732BF7174
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 16:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E7FDE4FA364
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 14:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCD232B9B4;
	Tue, 21 Oct 2025 14:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qwtruial";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FRAYizdk"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACE2226D16;
	Tue, 21 Oct 2025 14:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761057175; cv=fail; b=eIl1e6ZTOVVAdKXPkHuLnRqqwAUUchd/dOVZ7SPRFG/Nt9vB1ZKWZJsHCip/+MfMDd6zGU98p4dPOsoAQuh9u9emsawGkc/OkyhZHoE9/jwJjiqTkowGg3HwU6MbNlAhKwTdRncdEdBQOSNHst5eyjtY9RJWsC5JxCPOV3Ibayw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761057175; c=relaxed/simple;
	bh=etyIywLAifk+MD7KHAkvt5RWvgc/t/P53XlVGY4pX7Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HJIBvVODSiA7LzQef0VlmElybHYmaePNDwybB/DXd6SBbmG8KFqMnQBHwdkWhifb/MGCg79i7/ph/6Jt314grC2PIPlue3/iAlfU24y+GukRFX5YIKS49Hd6iyiNAcrVVCYXtoFFqlDnbwZ1bHF1jS2eP4m6tjjweL/SJmKtIZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qwtruial; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FRAYizdk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59LEIxv8031011;
	Tue, 21 Oct 2025 14:32:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=guXxn4u9ergHVeQ7WqWOwY5XwoKQkTJApHRdH+88fBg=; b=
	qwtruialtL507VaowzV4ddVOJ7m4EO8O4p5x/qole4dkV5+5cfBDHDInNv0tkqY3
	DuwmOx5tvVOAjB3Pl/GndNbFBZcJM2CRZM38Cx8ofSh7uDE6dR2im22AiTYyCKGK
	C/e9QtgF66Iv8FUmsJ1uMBLy/rXTQ96m0S6w0CFi4EAMUAPjEr+wBQUsSbXAaxez
	+xh2z0RYVK7QJ0cDt+ytL0Vc/pN02QX6PNaWC4/uN/utSGZ9+eAq8pFXprItB9VS
	NWzLI9X9RX5AaLyeFxxTglVJ7KN/GnDrM6X8A1WL4KvBSIx+YQqmoxyEdYG4NzS3
	xlVYWG36ZqTfCy3yFFrL2g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v2ypwgsa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 14:32:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59LDw4S2025489;
	Tue, 21 Oct 2025 14:32:21 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010066.outbound.protection.outlook.com [52.101.56.66])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bbxfkd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 14:32:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dwYbJMgVBE8l9MFqGjFYcVRPmz09FNyLvLIvgv3ZayqC9zSTlLbLpF6Zr74kHb1h6tOR01Y0MDAvzBhpT1b91lu5qMNmY9rYug21Mg/4QkLamTvT8TFjQum/FC8LDUU4XxuXSvRyJQutfZ9kTIub9UsZrO6unSlvNnPa7w0KZxjUjx9s35OcGK3a4e0d9jbtl5vCUhDO7fVjvHw3clt0UXfQO13W9qrB0BhDAn3Ps8Dc0HwXgQuKGFNBLQEU/4P1ti3RfE1gPXTkXuO7mdU6Ia+HwLQ9QFwwxD0pO5Jg3kV58kq/TIXrmTkRP2yqBSFv4eYF8FmUEprLRv8UMcEg0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=guXxn4u9ergHVeQ7WqWOwY5XwoKQkTJApHRdH+88fBg=;
 b=nbzjDRDlaCpNTIWv0uORlYbyZER+teCNOAg84l2ZD/wXTO0ivtNPKcn46ogIvD7V0EidSiUhPKNibvvTM0HmZhGpobynt76rm8RqDq9a5GR0VhigJAbqt2GZYPsfDup1FzeIWK8XetricazZ4jVnM1iyud+/HTYtEeEBeOCGv4QIe98KXaE75d4XhrFB1sGx6hb6R/igExVFoNUvI42LbuhBqRTAu1EL5CJWaFjFB1ypqy7nQUstAL0cdP4P7LbYVsjD4Kcz0DLWuGeuIMfeYYDZc6ZPhReZlqqaEoDXPey/eLUg+U8CyHqDKIe0qSMDCBNN7lbBkrPVDZ59izBiqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=guXxn4u9ergHVeQ7WqWOwY5XwoKQkTJApHRdH+88fBg=;
 b=FRAYizdkd4NDGWgcbdyYPingUcffdPuOMYsgLOaRnK5IGpdf6jSqKKkS5lzroxElBgN76Vp1xwu0EnOGW2q1jn8JxWDFaI61P+XZe3yEskwdJko60I1XHcedu9i9DlS+zI6ajZgsRvKt5gjIFoexSSKA4X+sW7TrI+BieT7P5q4=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 CO1PR10MB4594.namprd10.prod.outlook.com (2603:10b6:303:9a::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.12; Tue, 21 Oct 2025 14:32:13 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9253.011; Tue, 21 Oct 2025
 14:32:13 +0000
Message-ID: <caf3969f-658d-41f9-9de9-9ef3a3773ee8@oracle.com>
Date: Tue, 21 Oct 2025 15:32:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves] pahole: Avoid generating artificial inlined
 functions for BTF
To: Jakub Sitnicki <jakub@cloudflare.com>,
        Yonghong Song <yonghong.song@linux.dev>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, dwarves@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Matt Fleming <mfleming@cloudflare.com>, kernel-team@cloudflare.com
References: <20251003173620.2892942-1-yonghong.song@linux.dev>
 <874irswi4a.fsf@cloudflare.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <874irswi4a.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0573.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::6) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|CO1PR10MB4594:EE_
X-MS-Office365-Filtering-Correlation-Id: 39f2c8e3-80c6-4c53-e84c-08de10aea06f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M0I3aVNHU2JydWVHR3FtVnZFSjFTRDN3ZUdkQkIwTGxieWF0WlVrMityb3g0?=
 =?utf-8?B?WVR2cE5iTUlPc3hmb2YxSWpBeVNoYTRybGdsNjd1QTlJNFQ4SEk1OGUzY1VX?=
 =?utf-8?B?OXhpR1pUK2RoZU9rOVZUME9rWEhuQ0hZbmVVNC92LzFMd29adWl4ZCtHcWI4?=
 =?utf-8?B?QjA3SWkxMTh6bDI0R2Q4c2VjdlVNYTgrTzhHYmJzeU05NlVHajB6VXdyK3li?=
 =?utf-8?B?ZVNPV0NLZDBXMG1UZlBDQzQ4dkJWaXBjM1hoak1KV0k0U2ExTmpuRWM4NVBv?=
 =?utf-8?B?NjY2MnJkNVlKZ2dFMnZqVDVWQkNMczFTMUM1ZXowUml3NXJOSkJ3RWxpRnFW?=
 =?utf-8?B?YWFVRzVNYzlaUmFBNFFjckxpRVk2elRaOE1sOTRNTE8vUXI4c1E3bStqMW13?=
 =?utf-8?B?WHN0R2U5TUtDbTBFWXd1UnlDSkNHYVhOTlhZK05rZWlBYWE5WlV6cHd4S3hW?=
 =?utf-8?B?OVpad2Y4UEV1YkIvbVZKNFZyTUlIZG9sYXM3U25QRzR3OHJ1eU9FSEtZc0hz?=
 =?utf-8?B?UzBUQ2NSY0x3NFVtbXNSYkRqSVBJY1dmOVVDYSsxM0pyRGRZcTN6bnR5UDk4?=
 =?utf-8?B?ckNTNDBYL2hJYy9hR1BQU2dNSy84ZUpRNFBZSFEvTnA5aFFuSjNNVXk1VzJn?=
 =?utf-8?B?VmI0N2NvVFZZWXl3Tk1XV1h4V0NBNlVTM2IxNDZHMW5mb2k2RmFueWNNeWpP?=
 =?utf-8?B?YjhvOGE5enFtdnZGMUhLMXp2ajduUlZOdTZhRXNMSk1VQllqTzEwQkNYMmEr?=
 =?utf-8?B?aURzTWZreFBaR0JVTk01M3ozM0pXOWJBcnRmdXFCSk1mdTJpMk1YREUyeHFq?=
 =?utf-8?B?VW11Tmg4c3JlbG1kcjJPcFV3YUk4RTExNmx6dE8wUjltOFk3NXNTRzNLSU1W?=
 =?utf-8?B?ZWhaK1FGOVE4LzZSUHV5dG1JUjhqOGYwdzRSV0JHc0J2ZnlHWWMxditibGtP?=
 =?utf-8?B?VEhNalBJbzNZb1NiZGZ4dmQvUFNYRTQ4ci80a2JlUHIzSFFvTlhsZjU3SWk0?=
 =?utf-8?B?WlIzeUVoQ1lGNDJJR1RueVNlaEtZNFkySlkyN1EwZlFtMjh6UG1kaXB6QXRC?=
 =?utf-8?B?dDM4b2RCQXpoZUpZL2NPNWN5M1NpTWxkRjJ3V0UwVzdoRnRvSzNFYmtsWTJG?=
 =?utf-8?B?c0ZpV3ZqVVlCdTBkUjVGTGdBVmtGejBiaUp4VnFjdmxsMm02ZmxaUVg3K0di?=
 =?utf-8?B?aGhXZE94R290RFVuUjdMdTFxL3hrL2oxY0JncmxDcHd6dWFXdUI0SEo3Ry9w?=
 =?utf-8?B?bFZhZXZHWnZtK0JaeWdMMGZsMkVTVTloVUpSMGUvc080enBRd1Nmck5pR1dM?=
 =?utf-8?B?Vm9OdjlpY0llQ1J6a0tpdUZKWXJ5c0xGNHAvMGtmMzhqcXpJNXBxa01qYm1Z?=
 =?utf-8?B?MjFucXYvRkcwTXdIakhNSC9lNS9LejZHVWZORmVkdW9GbXk2UDRMRGMxUTJt?=
 =?utf-8?B?eTVhL01xbVFMcTFxQ2hWdmhxb2lXZVd4cXRsTHkrMWtSeDlPV2tFaGcvUzNk?=
 =?utf-8?B?MEw2QVUwMkdIeXhKbXo2c3gzZFMxWUJzYk1ERUtSK3hTQmxtZHhUU0FoYjFQ?=
 =?utf-8?B?UWNoRHpaUEpoZ3BUMjd2U2d6U3paaFRYc0lsZ0xtTEFJM2RDUWZ2UzNOZUVo?=
 =?utf-8?B?KzVlNHpKM1J2Tno5NEZadjRUd09QeTQ0aDNxYnlCMEJ3UGtOYU1tQXl0NTZC?=
 =?utf-8?B?SVNBZDE3OExqT0NhOElIY0pkbWtIRGFPQ0NQSm13WEFFNnAwVnJSbTBUYmJq?=
 =?utf-8?B?ZmtaczVUbnZ6ajR4bW9zSnk0c2RLbjMxaGY4VkZPcnNSU0lCZjBraEtxbU1r?=
 =?utf-8?B?alpuYi9Rc0owVG9zdEZpSFRNQnBoZjJqTG1qYlp4NE5NQ1dnN1h3dnM1YVRL?=
 =?utf-8?B?bC9ZK0ZNSFN4aHFxa1lzcW02Tm5lSnBYeWN1OVEyK0dBbFRwdWYxR3BqWHVN?=
 =?utf-8?B?Z0F6VkRLNnRXcml3dUxDYndXVnNkWnFkZWFOSk1RemxZSEhCcCsraGh0b25B?=
 =?utf-8?B?bHJvaUcxZURRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OTBqNGpRaVl2UFJrbnN3bXNEa0lGNXdxRWJtNFF5ZmJkNXlUTDFNRkdNekRt?=
 =?utf-8?B?Q1M0eEdsQ1RiblBNTmxvYm1QZ3BzNDBIQmZ3T0JuaGFEQXpWTEJOOFRFMkVn?=
 =?utf-8?B?VUNTTmVMcWJjdkd4WkMvckt2STdCTE1Cc3FadWZ0SG91WWRna1JQS3ovWW1D?=
 =?utf-8?B?ZEoxZlgxNGZvRjdsWkNUckkraW1BZlFucStqSytSaWNuVm16NVVjZ1VjUnd1?=
 =?utf-8?B?SGkvb1owK3VCeE5OWUVQOE1SK2traitNN1QxMFV5Z3VhS0xSeXh2Q09MQSts?=
 =?utf-8?B?ei8wTzBSRVVjM1cybU9MMmdyOUQ2UnJKOFhCbXF3d05TRklWSHNmWWR2RnZj?=
 =?utf-8?B?LzZvTXp3RTZMb3MxZE1nTXZSRWFQMWVza0xpQm8vaFJuUHdGZTk2NE1oaklx?=
 =?utf-8?B?c3BsVGl6WHVTWmZKRi9PQW9CNi8wNmVvOUt1TjlsYVQwNGIvZDhhbjZKczFv?=
 =?utf-8?B?TmozWUowTGtoQUhwTThveHRCa1c3TWIyY3M3SElwTGNiNTFoNjg4RjZ5OE5q?=
 =?utf-8?B?WlNzbEthSzhkUWNoaTNvdUdJcVhDTUl2cDd3VncwenNNSW5VOGdCTFgxNHI4?=
 =?utf-8?B?YUE2SktNUVRGSFVRcDcyVng5V3ByYUlWTitnMHVoWmhQdlRYVXIzWFpaL0tk?=
 =?utf-8?B?bkNkVlZKN2tnK29VbTh3VVhTZFhOREtjRHVJMDl3ZFdmZWNpQ1Q2dytyZmJC?=
 =?utf-8?B?Mks4K0NnWU04NEo3UEo2YWlsK1VyQWRDSUhaYjBVellFUUN4cU9xbE5pQ0VR?=
 =?utf-8?B?UFAzNk1IYWhpV0lLcWxONllDcFhyVmk3aHVkZWVoQ0V0dlVPY2gzUU9lWXlO?=
 =?utf-8?B?YURUaVhHVU4vdWpYRm13emd0VmR3MTBHbHNxaENoQWt1MDBia3AxMmhvY2VG?=
 =?utf-8?B?UTJORHNsK1VZQ05UdFhkSlVBNG9wNlRiQ3lhUTZQS0pibmJJYVVrUlJnTWFK?=
 =?utf-8?B?cElBek5OaGJWekkySkF2NFIyUjREQnpEU3BaNzZmS2NQZEZtUFhEVUphMXRV?=
 =?utf-8?B?eFVjTXNhUUZKR3FPcWdHQTFva2dMZWNtZXh3Q3BTRlpSQzJtNTAvZTVVNzQ3?=
 =?utf-8?B?SEFVaXMxVGs3WWxJcTZ2bUNQVGp4QXE5K2V2cXFzVFpsU01wU09MRURSMjNm?=
 =?utf-8?B?SndnWTFMTEVxK3dOY3o4N3l6WHBXbUVMZDltbE9TWmUxTHo1eUxuUDlqZnV1?=
 =?utf-8?B?QzRIWSszVjZvYXNlYTlXcEE1bWpOUGhVUy9meERUZk5aRGxYWEhHL2ZJWHlr?=
 =?utf-8?B?QnNnQVcwRjJENUU0RmNSbVE5RlArV25MaEdWWUU1d0g5Qks3Z3BHZXMvTHo0?=
 =?utf-8?B?SnVLL0xjU1JML0JLaWloNDJOWkhtemVxRDBLanJVUm9KRlg1cVBJUFF3T2g3?=
 =?utf-8?B?bk5JNng1b3FJcHFDdWJXMFk3RzJFaGNjZlpCMmZNaGptSHNWWlEweUdUMVd0?=
 =?utf-8?B?anVPU05odDBrNFJ3N3F1UGlZSG5EZzh3MVR4MTJicTFnRlQvYncrajFsTk9r?=
 =?utf-8?B?U1hpWmxha2VHbERmRzJGd2ZJaU5vb25ncGhuOG5HcXZvTko1YlJHaXdBaHp4?=
 =?utf-8?B?amdnNTUrL04wTjgvK2txS1BtTm4rNlh0Vit5WVpoSHduQys0OWk4K2dZeGdS?=
 =?utf-8?B?VTF1dUVTVVZyMFQ2dGU1OXhOamJQdmZuUTVUWERjK2Y3Kzd0VENhb2EwOUtv?=
 =?utf-8?B?bnM5ZENOb0o2eEt4SkY0ejd6R1ZYaCswRTFrVlU0KzczMzdUSEIzNzRDamZj?=
 =?utf-8?B?cjZtOEswd0pPUStueGg5dmJLUVRMU0gzVk84VjFkU0t3YTliVElnKzFiRCti?=
 =?utf-8?B?V3BrQmdEYkRrSjI3UDZNckQxUzZreDh0blZNcFBnZkthQUtRV1FxNSt3QW96?=
 =?utf-8?B?MjgxRlJEVW9TQ0tXS2xEYW5remFpc1NvSjNvQjZuZzZpbGVjbEh5NUxLRDZ1?=
 =?utf-8?B?a1J2ZUpwZy9hSUNmVXVDZE9ZK3ZobEtyTmt3SjBJT1YrdTNFalhkd2Y3UmNN?=
 =?utf-8?B?WEw1Y1ZzblhHaDVtNytHS0thbkNKMU9vV2JGNUVkSndrT05MNWVRZWtSVlBj?=
 =?utf-8?B?d1NqZE00THhzaEZhUmV0TTlRWFZxY1BuL1Vmbm5wSHhpNk9mRGJXMktKVk5h?=
 =?utf-8?B?SEJZUU1NbS82dlo5Z05BOHNmenNMb0VhUUs1UVNIZmlXMTdsTnhkclgwWnFY?=
 =?utf-8?B?MkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NHxG+nCeXpBh3viFUvVpL7GvmYz5H6PlcegSMYa0wjqBERKVlzcO9jxFFxa+u6ilpKCVQkJOwGe9sPXotwr9elzURjwwXRAZvsYIsOz293P5NCf6U+Lyp8QUVCujThm/rWgrxCPjvGGQd2v4jw/DqcZwYrhXgmuYPLLDSr++dJFDbS0ojoVhdjam6ygm9iCBf+eyaYPql057LmJImcdp7afM4B4DXEFjBDb+MKgf1l9nCG3zUXAf4jiNMf0Nq7OCus4QTSwZSmszpuj/wIGUZAOB0bkW/FYJV4uG32QdCx/3pltXZU7LXAfnqXreb6GwLwA6/dwh8CXKa/vHmdPUYZ+R7uqlFI8SdXRrioWVYPvG0EamntctkoDdPyqOCrXqSAfHkgr7mWCuOgU35jVthJbR/nWbvdfGlGtXFVzoc/NYoroLCnUbVif+NpPTf+JqjIdEsCxfdthgP6XmHpdIFkgb0qVfTBMhIVEnsUC0EFpyZn52INdCiPGTYVH2fHzLYOyFuxyvusTC9EzgOgzOhYpWWIPSIrX3F0ZDaocv7Rj9AJ47GzMtKZxmqwVhZ+mVbzL32ukXNqRvFSCc5DamLR5h8LUXGrr6orD9nwG+BPA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39f2c8e3-80c6-4c53-e84c-08de10aea06f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 14:32:13.7922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YQG55Mh3MT/1g2WcS8ivKtEzIfEEczp5c35jm30ui1pdSY2UVw+x2ZOhcD+jcMT1waGG72FQ6xaqAEv9Lv5h0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4594
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510210113
X-Proofpoint-GUID: QgZVQgQuySQTnXHpDIqoE8Gr6d2JYcvI
X-Proofpoint-ORIG-GUID: QgZVQgQuySQTnXHpDIqoE8Gr6d2JYcvI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfX82AeAT6DAP2A
 NTmw1FuOS335zaCNKnzmXDPH/WDSs99PEdPLoqnAconW7FWhoscZRQKswc+ZZEm7XGb5NFlQiNh
 73r8Bc9oGZo+WI3t5DGByCMs1gzhI7D7hdmeD2p/dtTYvFHYDjNOMyMLBehBFOyaBdMGHM9z8bG
 q7p07bwCLNzxpXVdY53x61x5lFmcgerQjTZcrWF/uf8jyIkfiFs8AQjHk0QntZSCJpweOaledhK
 i8fioHkdjXIODQsQO8O1JTNW2n20keUEJJ2QTg6R8CKJ9csTSuhAWKC9bbLVm694R5IfKX/ooDK
 xsJTIOaDr9h/rqZMKS9QbPbgA6PODwbpHLQoLRHe2D0Doa3TmocySNt8YMgFmG5VPGWQFhaTOGy
 oLN8QEJgmCbx/cm+gmgbOWB3gM2A5w==
X-Authority-Analysis: v=2.4 cv=Nu7cssdJ c=1 sm=1 tr=0 ts=68f79976 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=euf5n70jI3hEusatVSsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22

On 21/10/2025 13:32, Jakub Sitnicki wrote:
> On Fri, Oct 03, 2025 at 10:36 AM -07, Yonghong Song wrote:
>> But actually, one of function 'foo' is marked as DW_INL_inlined which means
>> we should not treat it as an elf funciton. The patch fixed this issue
>> by filtering subprograms if the corresponding function__inlined() is true.
> 
> I have a semi-related question: are there any plans for BTF to indicate
> when a function has been inlined? Not necessarily where it has been
> inlined, just that it has, somewhere, at least once.
> 
> When tracing with bpftrace or perf without a vmlinux available, it's
> easy to assume you're tracing all calls to a function, when in fact some
> calls may be inlined within the same compilation unit.
> 
> A good example is tracing the rtnl_lock - there are multiple inlined
> copies, but neither bpftrace nor perf can warn you about it when debug
> info is absent.
> 

hi Jakub, see the RFC series at [1]. The goal is to represent inline
sites in BTF such that we can see when a function has been partially or
fully inlined, or indeed when optimizations have been applied to its ,
parameters which result in it being unsafe for fprobe()ing - in these
cases we skip representing such functions in BTF today.

In the case of inlined/optimized functions the proposal is to represent
them via BTF location data; not all of these locations will have all
parameters available due to optimization etc. However even absent that
it is still valuable to know such inlining has occurred as you say.

[1]
https://lore.kernel.org/bpf/20251008173512.731801-1-alan.maguire@oracle.com/

> $ sudo perf probe -a rtnl_lock
> Added new event:
>   probe:rtnl_lock      (on rtnl_lock)
>  
> You can now use it in all perf tools, such as:
>  
>         perf record -e probe:rtnl_lock -aR sleep 1
>  
> $ sudo apt install linux-image-`uname -r`-dbg
> Installing:
>   linux-image-6.12.53-cloudflare-2025.10.4-dbg
> […]
> $ sudo perf probe -d rtnl_lock
> Removed event: probe:rtnl_lock
> $ sudo perf probe -a rtnl_lock
> Added new events:
>   probe:rtnl_lock      (on rtnl_lock)
>   probe:rtnl_lock      (on rtnl_lock)
>   probe:rtnl_lock      (on rtnl_lock)
>   probe:rtnl_lock      (on rtnl_lock)
>   probe:rtnl_lock      (on rtnl_lock)
>   probe:rtnl_lock      (on rtnl_lock)
>   probe:rtnl_lock      (on rtnl_lock)
>   probe:rtnl_lock      (on rtnl_lock)
>   probe:rtnl_lock      (on rtnl_lock)
>   probe:rtnl_lock      (on rtnl_lock)
>   probe:rtnl_lock      (on rtnl_lock)
>  
> You can now use it in all perf tools, such as:
>  
>         perf record -e probe:rtnl_lock -aR sleep 1
>  
> $
> 
> Thanks,
> -jkbs


