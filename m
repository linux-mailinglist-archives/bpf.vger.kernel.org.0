Return-Path: <bpf+bounces-32290-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CA490ACF4
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 13:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3F451C20DCB
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 11:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B739B194A5A;
	Mon, 17 Jun 2024 11:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kp9p+fy8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qUNhSskG"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EB022EFB;
	Mon, 17 Jun 2024 11:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718623825; cv=fail; b=llRrhzBssMQEYTUQ1FbGdVBtp0Rx4Kc3gpFFVzYurlXvqU30Z+KildGsV3Py4CHEcge253yTWNughiMeH/Sd+0Mrpgr3Zlc8BjNurEqHFK5Wq6oMkHwAvlPHMgO/oRoCLqWv/p56Jqkr2N7P/DJyeUQai1dYijzO433qgq5L3aw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718623825; c=relaxed/simple;
	bh=PTqWuI1wVUY4qrNvEGQyC5WwWUFXII9GPpvPMLQdthk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I2kifeIOHr8g5VLmWdPmzr9El3XJGYkkL3plqjtv0HEiWIAs2QhsaFQoD7lwFG5xCnRtsTqLD+KBbhqf0KTAxZRb85STcXjo0qK1x0pyE0jHZEnkEItdfgHD6lyivUNkO/sdiGwLGcdETEMsC6jydw/CL2Mr/mi5ZbLy5/iIHL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kp9p+fy8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qUNhSskG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45H7fxcj026604;
	Mon, 17 Jun 2024 11:29:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=7QkBu4hz4YX/4LP49oWG1XSvJn3RAdNrpfPPTzD5snM=; b=
	kp9p+fy8Gs+uaI/75q9mzjG1YER20cQ7sUa7HUxp6oRI6iN0pQBjNibWu+jCOJ4n
	Xm0BYWuRRirxKuwChSxLAJT6dILWJZQx6w8LqEHz46Asi5EU7/8vjsGmrMbZX7E8
	07QT7aq9oiD++HxFU23564TCE6C3X74nlgs9rldAUU12sGjE0sMZ4I3ZKHRvxR/g
	NGP640cLFjZW9weeirHC+8/V5DTsFjBg5Ve6WVT51KEHiwpSlWf9+u1lL+ZTmfVi
	btnJVr6eTN7aAXCyY9UoSYUjdpTYOCpTyeiV9ZRQiYjGl8ZSiG0+e90tC1dobhag
	zoxT8i1ZJ7xOGe6WPlrlDQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ys30bjcxw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Jun 2024 11:29:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45HAREYU007472;
	Mon, 17 Jun 2024 11:29:56 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1d6b39r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Jun 2024 11:29:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbBef3G/lGboqvw6Gaw0bvPhx2VIY+FB+QKcpBg3lKruM9qyV/4g7KXVr1oKRt24kGM6Junm0Z0Io1blOByKuvlLDze03IxoMkVjDItoZE7aX34pLKIilN8EXA10VDML3QuPK8Tnq9lJiLcjwWl9aOWdqV6vAv4ZcjpzvvgJPMfLrEG4z9a6ubcpJzhUvRDCVwEw96bzB858WMxe7tZcYX3MDwMsmwQzbiQ5JASRa1v0/II4GQU0jSf0wiRvsk59Fs56a3ilD1WFrugR6Uthl+tfmLeukyd5C1siuypom+oI6JI6UlUbTuK8SPxyNg/q758GTVUmhz1nGfZvrzaoKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7QkBu4hz4YX/4LP49oWG1XSvJn3RAdNrpfPPTzD5snM=;
 b=cxLFKWMr8j5yu1NsKvZd0XqagBXJGBIHD0by+LhkZC3HPJ0Q7KSFnnVipqIoGLXVOLHYNlHZTTLLeCg+hVW/iiCyIw2CvVClsDhQbAeTN0aISzYRegszyJ9BMhi3AIp+TyOAHjGuoOw/dh9kTqYcJ1Qy3YFwHZ7JpjhKuR5bUSBjUrzXNjg1glg61BkVYgneoxO2gAXmPVqgYqc5FfQNhQrWFR8aWtF0T1daQgqW9Ysjdoe+UjxaElb7V9xabiC6EkVB6/nqzGqvOg4u2KmSapOFTJey8kMuMKsqjsIRZJGVXtPSV02sAcCFslCLnvwuSzkXyj0+3eKzg6X2Gj34PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7QkBu4hz4YX/4LP49oWG1XSvJn3RAdNrpfPPTzD5snM=;
 b=qUNhSskGVfcOdwVanxtYFn48HmVTX4FIMe4moO/TPz6F8MKHXTTjhge2S2CIxcS9iKMadAC+tcQhEEiaxQy68oa8IIHGVRvZKWx3sBOo7ftP/2cK5Xcll8nA2Be+pt5KKUsIE6/S/dbQzmIAY4QElScrNlSX32xw9xy00XBzF40=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DM6PR10MB4283.namprd10.prod.outlook.com (2603:10b6:5:219::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 11:29:52 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 11:29:52 +0000
Message-ID: <0c0ef20c-c05e-4db9-bad7-2cbc0d6dfae7@oracle.com>
Date: Mon, 17 Jun 2024 12:29:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] libbpf: checking the btf_type kind when fixing variable
 offsets
To: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org
Cc: daniel@iogearbox.net, song@kernel.org, andrii@kernel.org,
        eddyz87@gmail.com, haoluo@google.com, yonghong.song@linux.dev,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240616002958.2095829-1-dolinux.peng@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20240616002958.2095829-1-dolinux.peng@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P265CA0025.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::6) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DM6PR10MB4283:EE_
X-MS-Office365-Filtering-Correlation-Id: 54171d11-42fc-4d0f-d0ea-08dc8ec0ce48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|7416011|376011|1800799021;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?YlMvelJlejY3eVhSaGVkbVBsTCtkUkRFdmM3aGZwaFk4Vmc1a0xCWUR1aW1N?=
 =?utf-8?B?ZWNMZWprbXQxS1pDakpKZ3RxazRDd1Y2Nkl3WHRtczV2TmRENWJ5T0g3Tk1J?=
 =?utf-8?B?cHZMeXhnL2lFSXNsOVRUSndDSm14a2hPT1lJTVRnR2VYcU03bTFvS1dhSCtD?=
 =?utf-8?B?R0Y5UnVQSkxsOUowdE9RMlVlWmZvUWJ2Ulg1UzMzQ1NDdENVRHJwMFVoUk5M?=
 =?utf-8?B?RnVNRVNEU1dDalg3ZWxrWmp6eHdKTWlJcVIyT2xPQzRKVXRJNWkrMXV4elRm?=
 =?utf-8?B?QWpia0d5dCtvaFUrYk5zbVpKZkZRMWtGNENqbTgzbDMzZ1JpNTZ3VXgwc1R3?=
 =?utf-8?B?RGlYU1A2TmVaNE9tQkJaTUhyTHZpUHJqVEJHTHpMR0tjbG5JN3hrVG8wNHQz?=
 =?utf-8?B?akpub2dNOXNUWi9reDQ2bTR1ajJGU29iUVN2Q0Y3WTJRVit4dStIM3hLSGdO?=
 =?utf-8?B?b09BY3UveEJTVmpMM0QyK1JyamU2T1dlcTJZVGpVRllCTGtHUk1aaEJwK0RG?=
 =?utf-8?B?Q2JjRW9TaFJEN2JzaTFYVUYwVDBqZi9lWGRFbk00dUxHVmtRaXBPRDAzcGxi?=
 =?utf-8?B?aFhNOGdWb0ZiazREbjdGaCtiRWpsZ01Pb0hyeHpXKy9paXV1YVltK3RkRHpO?=
 =?utf-8?B?T090QmZ6Ujdndk13L2crdUpSRXRLMEJKVmxUWHlSKzVZNXZJZnBFTlk2YnlZ?=
 =?utf-8?B?U3JnaStIeHQ3eXNQWmYzRDVQazNuWlkvY0FoOWtMZzNoVllTUVFDYW8xdUJ4?=
 =?utf-8?B?OHNybnVjd1Z4Tjh5SU1PenB5MStDMXRuTThrNkI1czUzeVhERHRMbU1sY3Zh?=
 =?utf-8?B?ak16M0pwN2ZGQ2pEOWREZkE5RnNiUlpEZHV6VjBwRDhsNWdxT1J5QUF5dU1X?=
 =?utf-8?B?NTl3NWdXOWU2dEVsL2NibVZHWTFaVXdtbExGdnJsRFUwR1NIQkYzK1Z2Nkhw?=
 =?utf-8?B?TFdjSjE4YkRKZVlTVjgxVXowZ1orTEg1UFpUQWQ0SU9tRzBUTjhXbFJVMUFC?=
 =?utf-8?B?cnBzR0hHZkFGcGRrRjByRktFZmxqd2piOE91dWIyMm0zZ3VaWUdjN3E0Vk5J?=
 =?utf-8?B?WU05eUhYdzBCZlpEcVVqMlc4Y015SnVWeUxhd3VuUE1GTFJiRVZlc2FyNWNG?=
 =?utf-8?B?M3E1bDhxbjJUWElhOXhpbE5jSTF6SEt0d2VIWnVXVWNQcWJtY1BNK3VlTW5H?=
 =?utf-8?B?d0pqZVVHWnZCYy9WODkvVlBMV2V2djJYa2FyR2IwNGZxTFVLR2dlbzR6N3Fp?=
 =?utf-8?B?YnNQTVFWMzJBeEM4UVZJbDhkcWFJSUlEMlNGYVR2SDZhajIwRmRTUkk1VEdx?=
 =?utf-8?B?UWVMMk5nVFlwd081dHU2Mmt1U25OMXNteW1hSjhKQUdPWUZUL2h1L2dvRnN3?=
 =?utf-8?B?ck1kajF1VGpvNnliVVlUMTgxcVR3c1puYndvMFpZV2xUdm1XOTRMcWg0NUZj?=
 =?utf-8?B?UWhUaGppZXBrejNPZkZTZy9SNEhQbWJvak9LbVJFdkg1TFYyMVBrNDg4T09T?=
 =?utf-8?B?MXlLMy8wUkZYWlhyZWN6T01wenZZUUsyaWdzMTRqT3RWaE1Ddk9MN2cvOEZU?=
 =?utf-8?B?akpwUTVQc28vZ1dKRmo2TUVTZHlnSUo4Wnc1OUxJWDJGNFh2TjYxdjhOZUk4?=
 =?utf-8?B?N0ZMM1NZakxzM0JWaSszWXlTcVgremN0TFBkM1cvU0dSWEpPTWZIMEtkVVRn?=
 =?utf-8?B?NXRxMmR3KzduTFNmR2EzalFLaDlHQXNvYm5BN0l4VDhZSlRVV09qUzF3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(7416011)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OEV4SG0xVE1yM01FcjlBb0tXeWhuQlY5RFQ4NFArWGhTaHhVTWRiTVhsUWdx?=
 =?utf-8?B?eWN1YnNWWVFPSzZUcnhyZGJXOHFBcDRzYStQak5Ua2c4U0lyYlE1a3ZKaDZx?=
 =?utf-8?B?NnVPLzVmVmR3WW5wMEVrN3gxRThEeHJCSDVqalJxbVFQTzBuT3BWN01iY1Uw?=
 =?utf-8?B?eU56ZEEvQzhXRmlhZUlVa0RyVDVTaGc1Nkxaa2RaRGpiUHFLeFE1TVpWQ2NK?=
 =?utf-8?B?NGh6eWpxcm8xU0RoL0tNM09Ub01OanBFQXlDQTBHbVMrOEFCdGFhMnUvb1oy?=
 =?utf-8?B?SzY5c3NQbHh1M3VPNUJRZVBmc3p5OWZXOEJXNjdaVWxxeGRuTXFRWHZ0aWtT?=
 =?utf-8?B?MmdSWDFKQTBnVTlWaFhyd3dzYWRBbVBTOTdyb2E3RUhIWUEvTDJUaDJGUWNJ?=
 =?utf-8?B?TXVZSVZ3ZWwwM1J6YVg0bjZmeXBxbzhmNk5Jb3BPa2ZIcjE0QUoxRTFoVTlB?=
 =?utf-8?B?OERMYnhGMXljVEdUOGU2UG9yZS91SnNuT0pxNlNaVzdvV0VHVjQwU0JaeDNU?=
 =?utf-8?B?MTg3ckNBR0lCdnAzNTZFZmZIVFBlbXVybDdvRmY3ajRmRHFJSkV4Zy9iSjhh?=
 =?utf-8?B?NlhSUFBHY0cvZy9PL3Nhd25SdWtBelhuSFRFYjBBbVQ3UDJEWFlML20wM0tQ?=
 =?utf-8?B?b0t6allNd2VYa29tZExLMks2c0F1THRuYVpzMXNmZ1hqNk5HSTJjL3VkTjZt?=
 =?utf-8?B?dXBJbnJZbDMvL2xla3pCRlpDYUlQL2ZjNnBtZHU1T1Z0cXhnMjRaSTIwWlFp?=
 =?utf-8?B?akw5eWtaOWN4UTRDdEtraUxwbUs5RSswN0NPS3Fkb0JrcWhDME5HcENQRnNK?=
 =?utf-8?B?d0pRQlhQQWR1QUJUd09YYVh0MjF5N2RycDZoZURkL3A5NnlOeXc5eGgvYVB3?=
 =?utf-8?B?QjNrUFlGbngrbDRYNU8zUm8zaTdoR1orQTFyb2NNZjdpaXV0dmpTa0pMUEdY?=
 =?utf-8?B?dFhEWS80ZDVnYWlIazcwLzJUNDFlU0FsYWthTnNHUk5CK3B2RlhsNm1ZN0gr?=
 =?utf-8?B?OXdzTkNQeUdvLzU1NUxLQU5uc2c1Tm9TU1lXUUVUVUdRb3RiZDFOQlpxUHo0?=
 =?utf-8?B?QmE0NmF0Z1g1bHl0YnlkRFI1UHJkazFhdGlweDNRWTlNTEd4YkN1OHcwWGw5?=
 =?utf-8?B?OUVPMDBwSks0UEREN3dwTjZsdGhvTVFBN0U3OGF4UEJmR080eDlXNVYxV3hC?=
 =?utf-8?B?dWtFQTNCS3JPMjN4MFBUc2tNVHkrRURNV090Tnh0ajhGMDRuNGdQYlFrWGtQ?=
 =?utf-8?B?TUFDUExxakdXalhxSkhKaWNkU0F1dFZQY1hoYVZ1MzJEcGFvMjlnK3FoL2NM?=
 =?utf-8?B?V09YNDJ3MVdMaDZJemtPKzF6VmFGajZCMk1QWkFHOFUyUGxSemlFZndQV3kz?=
 =?utf-8?B?akVkUW5QRkxUbzJ6WklxeDZBamY1MWtiWjQvYVJoM3RFcVkrYlh5ajRWSjZm?=
 =?utf-8?B?MmpIYnJwNktjSCs5OGVmVWVHS1IyelovLytiRGtkdGpRUGgrQzh3blYvL2Z6?=
 =?utf-8?B?alVrdnRGTVRlaG5YMUpsdEFWVG9ldHB1cnNnUWpMZU56bFVDeGFScTFDSDNs?=
 =?utf-8?B?YmpGRERqTUlKbFA2WmRIdHdxTW9BaTlmM1VNK2xXdkdJVWk3cnZiOW83OUFv?=
 =?utf-8?B?QnVhM00yQmlzSFMzUzJBOFZlaFBSbWxrdTNrOXpFUTR5dDk3MGJiTGR1WlY0?=
 =?utf-8?B?Qm80THZ0QnFzRVl4TUFhOUo3SUR5ZzM1STJaLzEreHE4STNwY0ZRMUpLazh0?=
 =?utf-8?B?cGdJeERaUnI3TVRaREkrT051eGNOZy9tZ2l3OW9YSlI1cEJpQ0ZyVlp3aDVM?=
 =?utf-8?B?VTN5dzkxQjUxMDBCTlVrL3I0b3I5OE1SRlc3ZUhickhMMmpmcmRqMks5Zkp6?=
 =?utf-8?B?aWU0cHdPR1VCS0krOXIzazVacnMrTVhjdWdSYjFjUjJmbjJNbzdVRFFHS3Zn?=
 =?utf-8?B?ZVdsdzhjNmpXSUdXSDZ3dmVRQnNkb25XTnFPaEdNeThCWEl4Mm9yeFV3NmUx?=
 =?utf-8?B?cHVZTTV6QjBBQUdYMnhOa3llRE1iNE5PRzg4OU9VbE5ibmpJV3ZGOGtKcWJ5?=
 =?utf-8?B?cGozWEtmbHhidUpBQytHNlU1UTBITVc1VFFXVnVkTXptZVVhQzk3d3ZyczRr?=
 =?utf-8?B?c2QybUVLSnpTNDZ0UC9GYTNMM1czSGlhWThNTVFqV01xVmFZcHV2ME95aGxK?=
 =?utf-8?Q?L9A5csXGwZ03sMiAMdWSeso=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	D5z6QwzUJnra5GeQZpewTG3MNKpjf/ptsgykVYPdCxWNuTq0sAKhLg5GSEBq2SRrS/2aiZ3OKsXFAwz2dh/xlyhXCXwgNy7XlF8k22VPEW6N9KxFodCvmgt1OQ/abSOX7QLzU8uVP9ivIoyQa0ZjPfMC+Q49EKzbxtjV7V20z2xbmnITua0U3jzjF8gQzQvXMkWfAoASWDYyttSJhlXAjqIBy4p3I60cxtnkTnLdJnWA5SjgtnAMGbQqwPguRnymdU8oseIE39F9Tu5Xz6nOczs0c+SpqEKquEflUSvj0PX0+dwqwbu7GQ8LW92lrnyDvqGz27+83Yk8UcbpAMGc9xd6mUfxsIP+5tUnpoLZWAkysNdwPj6T3mikbMDxFFdrW7P/H0I5D6kMbJTmnGxPz/uXiUnFelbUi0hPPWL8054jOuok1089nXUKw26MlaQnYxhqIyYAQgBGdrFeiSZraRdICAVFlT4fwLCXUU44omEToCadhNT3LOedwdbVh23oQpd+PIoHVnMLDTArtKjkwvsAbvYDZZjt3Cnl1i6f/JnCeCFzc0XgPKhnVSy/ZOYGwaks6Xqde5xJ7hYEIWWEVSt51m/ONvtJfzoqTp2J9ZM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54171d11-42fc-4d0f-d0ea-08dc8ec0ce48
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 11:29:52.7078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nlkAvEL/6/SvAobsP54qs+zmWw8RQRxAunALhyxiVzouY7/UEQ8HQL/mgIagK9ahGDsALdP4O5QhAtIi/9kaFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4283
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_09,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406170088
X-Proofpoint-GUID: dxOQuHg-t4Wi3voqcsE5f-yoMu9lHPGa
X-Proofpoint-ORIG-GUID: dxOQuHg-t4Wi3voqcsE5f-yoMu9lHPGa

On 16/06/2024 01:29, Donglin Peng wrote:
> I encountered an issue when building the test_progs using the repository[1]:
> 
> $ clang --version
> Ubuntu clang version 17.0.6 (++20231208085846+6009708b4367-1~exp1~20231208085949.74)
> Target: x86_64-pc-linux-gnu
> Thread model: posix
> InstalledDir: /usr/bin
> 
> $ pwd
> /work/Qemu/x86_64/linux-6.10-rc2/tools/testing/selftests/bpf/
> 
> $ make test_progs V=1
> ...
> /work/Qemu/x86_64/linux-6.10-rc2/tools/testing/selftests/bpf/tools/sbin/bpftool
> gen object
> /work/Qemu/x86_64/linux-6.10-rc2/tools/testing/selftests/bpf/ip_check_defrag.bpf.linked2.o
> /work/Qemu/x86_64/linux-6.10-rc2/tools/testing/selftests/bpf/ip_check_defrag.bpf.linked1.o
> libbpf: failed to find symbol for variable 'bpf_dynptr_slice' in section
> '.ksyms'
> Error: failed to link
> '/work/Qemu/x86_64/linux-6.10-rc2/tools/testing/selftests/bpf/ip_check_defrag.bpf.linked1.o':
> No such file or directory (2)
> make: *** [Makefile:656:
> /work/Qemu/x86_64/linux-6.10-rc2/tools/testing/selftests/bpf/ip_check_defrag.skel.h]
> Error 254
> 
> After investigation, I found that the btf_types in the '.ksyms' section have a kind of
> BTF_KIND_FUNC instead of BTF_KIND_VAR:
> 
> $ bpftool btf dump file ./ip_check_defrag.bpf.linked1.o
> ...
> [2] DATASEC '.ksyms' size=0 vlen=2
>         type_id=16 offset=0 size=0 (FUNC 'bpf_dynptr_from_skb')
>         type_id=17 offset=0 size=0 (FUNC 'bpf_dynptr_slice')
> ...
> [16] FUNC 'bpf_dynptr_from_skb' type_id=82 linkage=extern
> [17] FUNC 'bpf_dynptr_slice' type_id=85 linkage=extern
> ...
> 
> To fix this, we can a add check for the kind.
> 
> [1] https://github.com/eddyz87/bpf/tree/binsort-btf-dedup
> Link: https://lore.kernel.org/all/4f551dc5fc792936ca364ce8324c0adea38162f1.camel@gmail.com/
> 

The fix makes sense; what I was trying to figure out is why we're only
seeing this now with the above repo.

So as I understand it, the reason the kfuncs end up in the .ksyms
section is due to the "__weak __ksym" tagging recently added to
vmlinux.h construction from BTF via

770abbb5a25a ("bpftool: Support dumping kfunc prototypes from BTF")

We see as noted

[112] DATASEC '.ksyms' size=0 vlen=2
	type_id=84 offset=0 size=0 (FUNC 'bpf_dynptr_from_skb')
	type_id=90 offset=0 size=0 (FUNC 'bpf_dynptr_slice')

So that makes sense, but prior to the above series, we also tagged
kfuncs in this way before via bpf_kfuncs.h. So there should be no
difference there.

And with an upstream kernel I don't run into this problem.
	
The only thing I could come up with is we were usually lucky; when we
misinterpreted the func as a var and looked its type up, we got

		int var_linkage = btf_var(vt)->linkage;

...and were lucky it never equalled 1 (BTF_VAR_GLOBAL_ALLOCATED):
	
		/* no need to patch up static or extern vars */
                if (var_linkage != BTF_VAR_GLOBAL_ALLOCATED)
			continue;

In the case of a function, the above btf_var(vt) would really be
pointing at the struct btf_type immediately after the relevant
function's struct btf_type (since unlike variables, functions don't have
metadata following them). So the only way we'd trip this bug would be if
the struct btf_type following the func was had a name_off value that
happened to equal 1 (BTF_VAR_GLOBAL_ALLOCATED).

So maybe the sorting changes to BTF order resulted in us tripping on
this bug, but regardless the fix seems right to me.

> Fixes: 8fd27bf69b86 ("libbpf: Add BPF static linker BTF and BTF.ext support")
> Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>

A few small things below, but

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

> ---
>  tools/lib/bpf/linker.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
> index 0d4be829551b..7f5fc9ac4ad6 100644
> --- a/tools/lib/bpf/linker.c
> +++ b/tools/lib/bpf/linker.c
> @@ -2213,10 +2213,17 @@ static int linker_fixup_btf(struct src_obj *obj)
>  		vi = btf_var_secinfos(t);
>  		for (j = 0, m = btf_vlen(t); j < m; j++, vi++) {
>  			const struct btf_type *vt = btf__type_by_id(obj->btf, vi->type);
> -			const char *var_name = btf__str_by_offset(obj->btf, vt->name_off);
> -			int var_linkage = btf_var(vt)->linkage;
> +			const char *var_name;
> +			int var_linkage;
>  			Elf64_Sym *sym;
>  
> +			/* should be a variable */
> +			if (btf_kind(vt) != BTF_KIND_VAR)

nit: could use if (!btf_is_var(vt)) here instead. It might also be worth
reworking the comment to acknowledge that we can legitimately have a
function in this section; i.e. something like
			
			/* could be a variable or function */

We handle the func case elsewhere in libbpf (see add_dummy_ksym_var()).


> +				continue;
> + 
> +			var_name = btf__str_by_offset(obj->btf, vt->name_off);
> +			var_linkage = btf_var(vt)->linkage;
> +
>  			/* no need to patch up static or extern vars */
>  			if (var_linkage != BTF_VAR_GLOBAL_ALLOCATED)
>  				continue;

