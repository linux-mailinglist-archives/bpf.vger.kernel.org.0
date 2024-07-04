Return-Path: <bpf+bounces-33897-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C00579279CF
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 17:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E34731C248D1
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 15:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0627E1AEFC7;
	Thu,  4 Jul 2024 15:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Hy71x+nu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uQG2i6lL"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C771E497
	for <bpf@vger.kernel.org>; Thu,  4 Jul 2024 15:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720106255; cv=fail; b=VZIfcoStDRAz9jCOvpR21azSF1KcbqDj3lplRMA33xMlYfUVxRduoo4sQd8zx40SDlno5nEgvQj31hEzNH1y3k+ryFuEy99ov37C/PI91bf1MGXgHgRGinoIcVX3Casm/QQYufuT2aRjJupimCV2dSHNeXxcwJQFpYlDmWFDvbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720106255; c=relaxed/simple;
	bh=CDiFL8qCiX2B3c5gne0pRt2tNxa8FKPFqV88/n2qE7A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dfQ2IPeufjAui5c7cT9Ogb2aHL04Kmc1rYa69Jp+ZPMKdSL5KKUKTlAXTLHWf8F+pe/WGeS2ATiaxeb8ITNd2MuIysDpUyCGcvNIbkU0Fz0jwwnVNKvi1wMhnHy2/cRjnxsF+9y8YQvrt/VjoPeVd1ohCT0wYe0ebCPqFZTsbIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Hy71x+nu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uQG2i6lL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 464Dft1W025837;
	Thu, 4 Jul 2024 15:17:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=SQLlFFRXnmk5Jl4ItC36hqvNoiU835UrxRIn1HHL7xo=; b=
	Hy71x+nu4/+A477hMsbG2RKYMN7BuGXakPknLrqpOWfvbija8k+VwVlELA5ZMrb7
	a6dcb6jpmMXCqTces5oM49U1H4w9xXrUDjThDEnfA5bqN5jgJB6A+6+7CmND6+zB
	WfRTxBwEJEsH4mWkLkYnYX0IxaeRN9LM0otnpJT6ueh3p7my7jBB4dWSu3e/Se1L
	f3kQTDMJPVYmfWnpstZ7SqfBW2P6VzcY/kBcwpvPBR5lQwU1Yo/bLxV6Et50pAd9
	ijvB2E6uTuIjisGBqwWkpR221TLrfdnvvbV76yodIAgBxAxdXaf4m/9SqpYBC4hZ
	ztiLQvRgMGjwWJxKRDDLtQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40296b2gnq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jul 2024 15:17:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 464FCKC9021794;
	Thu, 4 Jul 2024 15:17:07 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4028qgkf2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jul 2024 15:17:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TRdqWM3dSw7TPIvpN9v+Wn9ogenRMeGSB5nOiEgybK+StDAjdAsH+w1tXNV+OOXd+RFWCr8Uk4/RSm45eZ4stc3AkuI2mej4LBQQ4grB6rZCumDQBcxEMt5IhCnTOmF4YyxeIMkYSGwabP6P+4z6hgPla2T9L1GSUo4HMQYB/bVCBDeIxBnHw9x2Ia8rHoEqz6ETRMR9vTVJgI58CClYa+ATzpSGwJFyI4RWEMdXLSQfcS0gjoK56grpTaRNy/gFrHkadPDwfB8ZuzT0SPgzwFMvJRp/4Uxrolyj72ETLE0bp1b9mEtWG6gq8emAfJqTBojxgHoWGqoRx1kTgQA65w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQLlFFRXnmk5Jl4ItC36hqvNoiU835UrxRIn1HHL7xo=;
 b=bSCjT5Gd2jDtwpfexOlDlG9AtkCk8cqrWVkr8smwkBTGCEgv2txiIPVkEVYUVWBuJKwXz+ZfSlvP1E2Own6kmgVa1yunBpWl4FagvxiRaFP9/ge8Cdn2P/9/GWjMDbZZGWSSBboE07K/MzrPfSqaR3GY8IRJsEPJo9gUzALGEgDwrLZVjOtN0ytxq0GjOPDu0kLOEgPpZKq0KMEtdqxElrU4d2H7clsWPLcXj3fiUNo9az208AHkryMrcqGZ3WQbTJhx4qLkKjaLXRKnN6IEM4QI0xLlRLmfetHxcSmkV58gJkmL6DzXAJTs/F3uEstyUGsoh4yA3nyBmHLoCH1VtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQLlFFRXnmk5Jl4ItC36hqvNoiU835UrxRIn1HHL7xo=;
 b=uQG2i6lLJnV4HpWBXIUfNXeot+XfNRpPVNRKOQmQ4WFKMkVwYv7KHRCe2Yb2KAYOzZCooHRC9UFXgvIY7szyODQGfXR5Sy9dcdXixCVu+0HsM0aab4WcH6lEwfoOOLdnkygzunv3jDBu4gQOoSGOvO6b0k82r0Fha5EBxkIYYGU=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SJ0PR10MB4653.namprd10.prod.outlook.com (2603:10b6:a03:2d7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Thu, 4 Jul
 2024 15:17:04 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7741.025; Thu, 4 Jul 2024
 15:17:04 +0000
Message-ID: <13891abf-3c88-4369-8fe3-0fb8f5673038@oracle.com>
Date: Thu, 4 Jul 2024 16:16:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/2] libbpf: fix BPF skeleton forward/backward
 compat handling
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com, Mykyta Yatsenko <yatsenko@meta.com>
References: <20240704001527.754710-1-andrii@kernel.org>
 <20240704001527.754710-3-andrii@kernel.org>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20240704001527.754710-3-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0083.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::23) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SJ0PR10MB4653:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b76b4c3-09b5-47a7-0d65-08dc9c3c5ca2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?akFkOTV5QlFJM21mRGUraGN3K3FtNkRnVWRTaHgySmdIUjVzNE9yb0JXcURa?=
 =?utf-8?B?R1hYWDZsK3U0Yy9ueWtHYkZ3VGZMK05Ec2p0UjFJcHFJdWxCb0hxK2NRSURm?=
 =?utf-8?B?YkRsaDJPMk9ONHlWU0ZnWmw2S1p4QnhFS09mby9DUWs5RzUwL2Fhd05RRzlC?=
 =?utf-8?B?bDk3UDNqUll5eDYwcVlxem1PZWtjVGRHZUdhVTZ2MUszUTB4UXFDWDc3Y096?=
 =?utf-8?B?VXhlUFliMkphYTFJbU13KzltdXJGcGhpYkE5QWNjaFRsYk96M0dEUjFaN3Na?=
 =?utf-8?B?RHpVdGovUDBYWEdTeWhaU3B3ekFxYzQxYVRVQ0hRTTVlZGJxS1ZKVUJrWDBa?=
 =?utf-8?B?blVlVG8xYlFuMWhwSmJRdUZYcnRFVkpQY2tSbnVmQzRIUlp0ZkFnMms3T2p0?=
 =?utf-8?B?UVpNczRDeEd4SFR2R0ZyZXdtUEJlT2t6RnhuMUZVenM2c1dXT0g3MUpYeWx4?=
 =?utf-8?B?OXNzeDZMR2d1eDMybUhEcGRtTlVpS2NxVGoyVTc2eStFZGFpUy9KZjZoRUZi?=
 =?utf-8?B?SnY5VS91QlY5SU1CKzBhY2t6TFYyVW45RTNiWW1lUnRDOHE1N0EwVkxvVW1h?=
 =?utf-8?B?VmFhZkVrd0l2Z3hyRWU1Vm8yMG5vcDlMa3BzMkJDNWxwVmtrbTBXd1p2UW5F?=
 =?utf-8?B?WERJK3crVGp0MXowSnBRRTF1ZEplNWxabktDK1paK0hJbGdTYWo0RXVXaUJ1?=
 =?utf-8?B?VTg0SUQxMnZ1Qkp5bFR0TExVVnhUZWdVT3d0MFlxRSs2TGxjVk83ckVoRGdp?=
 =?utf-8?B?RHBWNGxtcXBGVEtzVzY1NTRHVUUreDZKczgvK0diYU0zaldlZnVWSHBIRjVx?=
 =?utf-8?B?SkUxNy9iekxtVXdMM0xIdFFqQ2pYajE5K3gxZWR6QUREczBFNG4vN09jWXVV?=
 =?utf-8?B?OU11QlRTeXljSnJtZ1hueW5RRndTUVBMckkyNzlQeURDZ2MwWTJsZGtVOVBs?=
 =?utf-8?B?bkpVclh4dTIwY0d0b1VuQkxuejZldk9iQkJYMUEyWDlic0dYK1dCZjE3MURm?=
 =?utf-8?B?MFpNYnA3NzB3c040eU1kdG41dk9vNnB5dDFXWGFHSUhsTXEzK0RsOE9uWEJs?=
 =?utf-8?B?TStwcWxxbFJoTGlGdkUrbERJemNBWjF5L0JxTVNlMXplem1CN0pRSmw3Z2RZ?=
 =?utf-8?B?WXlqMXRMdERFTFEzdE1jemZsa3k1QlhZK2hwWmUzR0NXb0J4WnRXY0thSXZt?=
 =?utf-8?B?N0k1dUNDS0wwNVFDQmlHc3JnNVdOUVYwRzk2U01qK0gybXlxTkZzd0cvM1lk?=
 =?utf-8?B?NWx2WENkMUhuMWxPekZSNFB1WXZTTm5zakp1U2xxUkFydGFjYy9Ueko1MXJu?=
 =?utf-8?B?SUJQSG42b0FnVm12VjQ4L1ZubE9MdHd0V2Z6YWJ6VnpPUSsrL25sVW1FNEpx?=
 =?utf-8?B?YVBqWVZUVG4yK2IyTlBWelo2R1dQekozNGVPYk1hRW9QbVhneUxVT0NwMjhO?=
 =?utf-8?B?RmpCQ0VXN0l5ZVF1TEE5Tm9lYVFiMFVKTjFtbWZtalF6ZGNaTklOZWMxVnFG?=
 =?utf-8?B?Sy8zbFl6ZFZ5ZS9hOTF6TUZQR1RjZjVOUitnSFQvN3p4emFZc3F3b1c5bWp2?=
 =?utf-8?B?OTJEQ3kzTllqeGlEemlNNllUSzBXY3NubHFTa3BUd0xLdW9VUUlsTjF3WTMy?=
 =?utf-8?B?NDR4RjVzRThXOTBTV0ZqNm1DRjJ2eW03UTJ3amhwUEVXTXppOERQNGlqcGlE?=
 =?utf-8?B?bmV1VnR1K3NwZGRuRU56NU5HdjBCMkM2b1FzMXIxOXVsakF1YXI5dFdzS3dR?=
 =?utf-8?B?N1FZaXQwVjU5cWVvYUpqMW9ZL0habzNOZnBZZGVYTVZMNVd0REtxaWVkdFFi?=
 =?utf-8?B?Qm1OUDZIbVV3NjdOcmx6QT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SlVQeTZxalhkQ0xRUkowZ1VKSytBNWpSeTRrZWxsVTcwZ2NBczJ0Uk5QUXJ4?=
 =?utf-8?B?cnpuVmtGbXZOQmR6NkJBN1Y5WHpqMC9RVDFjcmx6NjIwVXRLOFdDaFVFcHpI?=
 =?utf-8?B?cXhXeXVRdDVGMlhZUHV3a3l1Ym5zL2dQYTZyY0wrbEMzdEdORy9rNVcyTWM0?=
 =?utf-8?B?M0VMK2xUeml5cnJHcmk0QU44eWJhaTZCWkRpYm50UTVkaDBjNFpTOWJISFpJ?=
 =?utf-8?B?QXRZZGgxcjFyd1JwcGkyMFZIQXZPLzVReThHNG92czBUN29FeUJVYkxHMERJ?=
 =?utf-8?B?WTVpODd0U3lxb1hBVGxNMG5XdDdiTEkxNnZaRHdGb3U5cGJrN1N2dWozb29E?=
 =?utf-8?B?SkpRYVhKNGd2OXkrMkxXdXhtQjRxUWRaZDhFUUJnMWQ3MFJPVzZZVnpNWFhH?=
 =?utf-8?B?NGwzREhCeEhya1RQMGpNUFpXRlV3VzF3T2RkSGhFd0pQQ3VSd3JFMFAxb3Z0?=
 =?utf-8?B?b0RrZDMvRTM4V045cDB5b0pFZTZKZ0dwQ2dob0JJNHFvbFFjdUtSMGhyTXd4?=
 =?utf-8?B?V0FRTmhrbWpNLytpcDVjOStRK1F1UHRlazBTVEN5SUh0VEhuZk4yaTFYQ2N0?=
 =?utf-8?B?cUc1MTZDSnlOWnNUd1NJRHZ2eGdnSXNreDJzUmQybjdOazhPYk9DeTUzZkh4?=
 =?utf-8?B?clNLM21GL3I4TU1QRjFtT3ZPb1JEZjJxS3AyaHg3VzRKR0xMbG9COHRNaGN3?=
 =?utf-8?B?VnA0MWpxZ3lDaWVVK1ZsS1ZnREZyTzZBL01RRnNEVjRycmU3Zldad0xHMnIv?=
 =?utf-8?B?dUxlYmt0YVRocTVZS29CMEw1STFPWTE1dU1BcFhFWEZ5OFcwWHRyYlhlUDIz?=
 =?utf-8?B?RC9kRSthcTJHamh5SVFIbnU2aHdyVUdNeUNHU0Y3Q01MZ01qQTkzNlNjOXlK?=
 =?utf-8?B?UHJ5STlucExNUnluY1djZWdIYkRxR0wrUGRnSVBPc3k0eU1xTlQ2YzJWM0M2?=
 =?utf-8?B?QngvMVVJRUlyVlFNNVI5TEEvcHhETE13VklFa2FNUmNOZUhBK2NMaXFJVmU0?=
 =?utf-8?B?b1dwYUY2OEVGVWJKNjNaUkVuNDRyTEV2TVQ0MzFZTGJIYXNFanVmNWJ3WERB?=
 =?utf-8?B?emNianBQYmVyeThoYjBreFh3OEtnRGF1ZGlIYzRoenF6YmRxVkg4OTJWOGh5?=
 =?utf-8?B?OTZ3UVFiSjZ1R0J3NzVCSlJNWGd3TGZJN3M0WXZFOE9uUEZ1K1lFeXZNeTRj?=
 =?utf-8?B?Zyt5WExTZU9GTE1DRS85eWNnSnd0VHo0Mkc1c2JsNkNiTFFKaG12OEE5alNJ?=
 =?utf-8?B?SEYzaHZuaVVJK09NUkFrWlhyc1FoTTJNSGVoMXRrT1FtTzcwNXVmQ3F2L3B6?=
 =?utf-8?B?cHc4OUtlZmtKbUwyU3JoZStuekFidlBQdmdRUWdxYVRCNFlIKzNmbWFXS2wv?=
 =?utf-8?B?V0dHamlRR1hGRzRxUWtFMXlCMHBnbmxiakhvZStYNGp6MjVqSnJWZmhVd0Vo?=
 =?utf-8?B?NzBxbGN4eUo4VE13QlVrUmZwaUNsZHBqTXVWVW9vSlJkQ2VFcmJVYXBIWGpz?=
 =?utf-8?B?RDVWeVVjUTByN21IbjBtZlAxV293a2xhV1piNUxxL253V1JEbGZkRGpmOUxu?=
 =?utf-8?B?S2w1ZDBybzdsZHNpVzJEQjJ4Qi9GRitRdzVVb000UDJJN3BneURPT1A5WWpL?=
 =?utf-8?B?a3VFSkUwWVgwNVpDYkVvYWNYWXN3cGw1bVlQMTFqcFlMK0NMUXZrMFFGZHNS?=
 =?utf-8?B?eHVvR3JCQitlemQ1VW5KQ2x5b0h4ZkJHQTN0dUtyMDV1anZIM05vSUNYTUUy?=
 =?utf-8?B?Zm5zWURTcFIzajRBQ1hib296TmxKZWNjS0pZRDdhbE82dnJtUGdlMThTdW5o?=
 =?utf-8?B?YjFnYVpZRmZDdjZ5VG5FaEh3ZTFLVVRQL3IvTlh4amhhR0xKQlFsRmVvWGMy?=
 =?utf-8?B?MU9uSmlHQlAxT0RjZHA5Y1phZHFoYzVWMGtmc1VLc3FvOCtsMmhRcTZma3E3?=
 =?utf-8?B?aUVzWVAra2Y1WnJOTmJBemJIVGo3MXhrcFZ4SkY0aWlKdmJPb0lRRXdIcUhJ?=
 =?utf-8?B?M2RVSG0vYnFYL0g5UEdRL3I5ZzM2OGhDWXlxRW1hYVRRWGJrRTJWdEFWRGdL?=
 =?utf-8?B?c3o4K2pDK0ZNS0h1UnJ4L3AzVFo2RENmaEprdUtMRFBOSlg4c3B1aFBhVEtw?=
 =?utf-8?B?NFdpTWZrN3M2YlZzL1lNb2RKaXFNek1EVkVYZHE1SzE0YktIYnNiL0hraEpi?=
 =?utf-8?Q?benuybHn4Cg8Doxq/NZNTcM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	r2b2x6pGENPDzJIN31oNGpLhh6kaly0K+wMT10UlgE7+JOyNyXY34Xz7SoHaZpYxCrfejmzfj3oBd3B+O09QpsdS2ro9gapJnDN28JUa0ebALU1x/FqqoMCDwbQXKp07sVXZ2uAbLacRArv/4OTovEzX2SJ+CHNyEGJFuKT9ZBxTzhuovAsSj5Q3TILtd8bWzAo42LUn9cMhT3ahBP7Eazzmv8GgR+zAA1mT+2FubouvfJEr01pPDBsnSXrvw06eHuBrIWq0JlfFTIDX+PypWxK3VxJAI+S43Qby9bRe10dLGVSCSpJCf4Dc6zQhOOx5OHcHUyH5SUfxUJKIae6+i0cdBihdd5YSnyO8xp4t8DNz/qn5U9Gmz8FErO5HOAWBtLmxdwt5MKe/hLk9PYXikhY26i+N1Q0vaSAKUmVt6s6Ez4KG2qnk+M6IV9afMbZmKeLyOOiv07HJg9dmgW04OaGmEQZLaccVZ6XM6RMDmM/cMiE4MNg2WJl8y7AvJ1FtpESUEbfRGxHS7idGHu4OQd3oPv/FvmTQsVKqLh7Ko+t5F/b2y4sXTMXEq2mrFsFtPtWUN/Fid3gJ2geClK0iV7osJIaNizrF347QRPEBBJs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b76b4c3-09b5-47a7-0d65-08dc9c3c5ca2
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 15:17:04.7666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ce7gcWImFE+e9YXttj4cCOLKOELKZk37eWfs0amCxTAHfUf+DxBz9UiO+AfutXU6SHbku5Oezj/klI4qAgZhjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4653
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-04_10,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407040109
X-Proofpoint-GUID: FIfwGN8HI3o3u0Dlv1fu8ITXRWxqZnnz
X-Proofpoint-ORIG-GUID: FIfwGN8HI3o3u0Dlv1fu8ITXRWxqZnnz

On 04/07/2024 01:15, Andrii Nakryiko wrote:
> BPF skeleton was designed from day one to be extensible. Generated BPF
> skeleton code specifies actual sizes of map/prog/variable skeletons for
> that reason and libbpf is supposed to work with newer/older versions
> correctly.
> 
> Unfortunately, it was missed that we implicitly embed hard-coded most
> up-to-date (according to libbpf's version of libbpf.h header used to
> compile BPF skeleton header) sizes of those strucs, which can differ
> from the actual sizes at runtime when libbpf is used as a shared
> library.
> 
> We have a few places were we just index array of maps/progs/vars, which
> implicitly uses these potentially invalid sizes of structs.
> 
> This patch aims to fix this problem going forward. Once this lands,
> we'll backport these changes in Github repo to create patched releases
> for older libbpfs.
> 
> Fixes: d66562fba1ce ("libbpf: Add BPF object skeleton support")
> Fixes: 430025e5dca5 ("libbpf: Add subskeleton scaffolding")

Great catch! I suppose it also sort of

Fixes: 08ac454e258 ("libbpf: Auto-attach struct_ops BPF maps in BPF
skeleton")

...since that introduced the new bpf_map_skeleton field. Not a big deal
since it's new and not a stable backport candidate.

> Co-developed-by: Mykyta Yatsenko <yatsenko@meta.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

I'm guessing that you found this when auto-attach silently didn't happen?

Nit: would it be worth dropping a debug logging message here


        /* Skeleton is created with earlier version of bpftool
         * which does not support auto-attachment
         */
-        if (s->map_skel_sz < sizeof(struct bpf_map_skeleton))
+        if (s->map_skel_sz < sizeof(struct bpf_map_skeleton)) {
+		pr_debug("libbpf version mismatch, cannot auto-attach\n");
		return 0;
+	}

...as it's a hard issue to spot?

For the series:

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

