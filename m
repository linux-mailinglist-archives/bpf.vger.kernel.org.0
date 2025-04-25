Return-Path: <bpf+bounces-56727-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2EDA9D31C
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 22:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2E00465EF3
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 20:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C87224220;
	Fri, 25 Apr 2025 20:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RsMZoNfV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="g46hal+9"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A21221F02;
	Fri, 25 Apr 2025 20:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745613417; cv=fail; b=qkAWxanLutuhoO8DchxLRb4n+2dYqG7Rx4zp8sDDvnOlwRoCzq7l2VkZe+C3jj1jw+xmGl18vfoTdsn6pUdaMK+Lyc5scfWo8AkPxmtUgKhE4zMMgAAEn/0pCErv5A8Qn7SaQF/4+nMKQ6EBeVv6C/AZ5/wyQewcUDeZlM/P7Ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745613417; c=relaxed/simple;
	bh=fjHqkAD6Y/WVhCjQ0dy160KKokpeLXEly+FIOToSbXI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UqRw+WfoU5sVMWlWHBho3P3KHqNzM3YiYU1EPF00RIE2RHinrYa7AzqMJwNDoN8wvaKzozjJoiOA0KfEQ+rRfXO+Md3sfoYhNTbV76claSn4FJ/t9De5G1KDk8TX4RVCbweo4nOmRjoLRLegQ63zjwm4RdQWF86Lm7t518XVEs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RsMZoNfV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=g46hal+9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PKW1eW022600;
	Fri, 25 Apr 2025 20:36:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=nAGz0qXJJGvhHFkMC1QoO6YcZiTlUa1tk7895hJ16b4=; b=
	RsMZoNfVYDp8Ji24XYdS7r2xLmIUvPD/6XHVE4JxSuNhDgx17k5tYvdgmYYTa7mR
	5iyDe6w0f3jt0jpRgRv5kypH3TVQSh2wgtf4VSontr6hMLT0Dqdf8LTjto4TgAoR
	3LoRr8btLEMwII2rmlgd8QtmU0+GgqFoWfyAopU2o760P0USj606hgBi1VFlUaMB
	JzRdAKhedallY2PsZjcegN0X/1Hr+nPvi2ukpVIep5w6w+kzOGQrsvTj9tknC94w
	rU+UfIHHB2vSA65W9hWEkZHYg6+aYe1PW8+7Z34pTzwkKaq2AtwvhddrUNn19nK9
	heUq7lFU/9MiafXI/oWgCA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 468hgt80tm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 20:36:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53PIi0Jk013908;
	Fri, 25 Apr 2025 20:36:41 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17013078.outbound.protection.outlook.com [40.93.6.78])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 466jxs42uy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 20:36:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tXRlRQx7hRL5c0lYBsWk7RQwYdONb63NKZLqOrEbQJrGNP7kz7lFfi1+7Hh18tzrN7pjlNJxDLT7O+xIQVeesxbaZFrcAdl9k0XPPCsYIgPjowUvsRrvke7F7oJGTE4YIeOe/yxfSFeHs3wIvYs8dR/0s+L+zS4+/yDydK+UREg8gkd1i9hVgeG6zlViyP8oiuVe8j3RLohhAhdc+D/G0KGKPFHSGonOnKizy3TiLBrwYBBDIIZ9TwO0T8jTiUC/eWyiMULW4ypnMPNv7Ku3ppS/Se8+i3Lyxss6S137PtV7+PEtpvrrTXP/q7KhJmDaChaT79DRmGZWZTFu6InuPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nAGz0qXJJGvhHFkMC1QoO6YcZiTlUa1tk7895hJ16b4=;
 b=NF8UCJT5MZkrVmMbS/t13WXyQ1SqSsYkjmI5EN4hACp94I0jTEsR7QPaOZGIeAW85yU7z3DW6stvgclSKCFAhIKfmZYcm2CCbaTrRlaMhEwePyISJ5tYEhOdkSkYHvVfn8UbjRAgA4KdWlRh6gZeUhr/hgdfdpUdJOiKtqKO5iXIqDrC6zfVixTvAbupvWg+vmO/FVHPfKLMvyPDEyuPlWh1coIagaP1S9JfwBr/rTO4oanAVQVYqCe/uyPFegweuqFvllHhghWxVyMET0gJJk1yXe0x3x7Pn1sH2xDn7eijgfw8S8/r94x/8y0XkBYqkgxR3PRt4U4BfVwTVqmGfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nAGz0qXJJGvhHFkMC1QoO6YcZiTlUa1tk7895hJ16b4=;
 b=g46hal+9HwDuAQeiUzbEp6OEuHSJgVacrWRCdzCjutwiIsEl3NOwTG5nUzJLUkeWg203zZVWSw5o8LXICUBpveEzhruwfAfJQCBDlyMfxEWPrL5T3xDzreh1sBSxm4JGLbYHED33/P4PtUd8+3+VnPXx02fYWgZfn7ut5jvC7gQ=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CY8PR10MB6908.namprd10.prod.outlook.com (2603:10b6:930:87::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 20:36:26 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 20:36:26 +0000
Message-ID: <4aa02e25-7231-40f4-a0ba-e10db3833d81@oracle.com>
Date: Fri, 25 Apr 2025 21:36:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: pahole and gcc-14 issues
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>,
        Ihor Solodrai <ihor.solodrai@linux.dev>, bpf <bpf@vger.kernel.org>,
        dwarves@vger.kernel.org, Kumar Kartikeya Dwivedi <memxor@gmail.com>
References: <CAADnVQL+-LiJGXwxD3jEUrOonO-fX0SZC8496dVzUXvfkB7gYQ@mail.gmail.com>
 <076e52f6-248a-4a41-a199-3c705cb3d3c5@oracle.com>
 <CAEf4Bzb9ozx056hm3=zh=4Sh_62EydK_wtJkNpgH9Yy0cuSsUQ@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4Bzb9ozx056hm3=zh=4Sh_62EydK_wtJkNpgH9Yy0cuSsUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR10CA0078.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::31) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CY8PR10MB6908:EE_
X-MS-Office365-Filtering-Correlation-Id: 73f2a003-eea2-419f-0354-08dd8438d9ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YnBod0lld2I3N2Q4eUEzaGU2NmREcWtYM2RHdkw0cFZPWlYzMkprbHpWMDVm?=
 =?utf-8?B?RHFkNDBNMDFGWE5DQS9uSWcvNklEdjhwQXdHWklaY01CMW5QTzBuazI4VjVI?=
 =?utf-8?B?ckltSGZyVWdMTDVJcXFpVGhEdWpNU2pTWnpXOExtc0NaczNGd2NtUmR0SVhE?=
 =?utf-8?B?ZmZ6bVFvMFN6L0NWSzdBZlRPNno5c3BjWFEyc1hOMXdCb0NnY0pLZGlFVmpk?=
 =?utf-8?B?bFNjZ2t5WWhZY05IbU9tZjIxWS9zdFdzTUZ0bFNWVW9pNWFOVnFmUEdtUk1s?=
 =?utf-8?B?cW9JZFNBcDJoQ2gyUWVYOU5rS3ZNSUs3U0JMRGs4QlR2VjVJTVkvaVF6VFFk?=
 =?utf-8?B?cDNJVVhRem9aM1FmdW5UQUdlbFN4RmNzdWRBZVhtVUE1ZlBua2lidGxiRVl4?=
 =?utf-8?B?M0xUNnIrenlzSll2SEVaL1M1TmxkOERFNFJPeDhySFNQTUk4NStBZTFkcTlx?=
 =?utf-8?B?OW1oV3V3V1l2TGNsVjhkVGpmNW9mZWFDN1NZZG40T1d3SkY5MytZY2VQT25D?=
 =?utf-8?B?VStnM0Vra0JWYWkzRFdIbC8vNVZHZU1tVUR6OHJvdlNUR2Z1NTJXODBPMVpV?=
 =?utf-8?B?Ym1xR0EyblNLcmpwME10RDZrVnlGa1N2eE1Wb0JpTUlPUHFucFUwRnlITGVw?=
 =?utf-8?B?c2YyQXp6YXRIYVptbTBQVUR5ZGkxZG1rUG9tejBLSlVpNzU5L3BqditkU1VX?=
 =?utf-8?B?RmVsTE10MFZRRkVEN1h4VHVreVoyVEZ1YVIvelByUk9ScjFINzF5MHQzamc4?=
 =?utf-8?B?Y1psMENZMDdWNko0TTBzSnRiQVJxMlpsdmMvOHBXaUFrZXYvVGxCc1RRVEZz?=
 =?utf-8?B?RjE3SUxUdXN1U0s1eGhCN0NlRlZybVlPQmRUdEJLWFZFNnJUOW9qcXlqWERV?=
 =?utf-8?B?L0drdzBIdFZHN0hKamZvZWh1c1BCbStKSEZxeXYzN3gxcmhYK2ZZekFOM3N3?=
 =?utf-8?B?STMzRGdXelFhY29kMlI0OU96UTV6U08wQkx2MkhXbzM4b05wbGY4eDA4NzMw?=
 =?utf-8?B?cTIwYmViZ1I3NTI2dHVhUXlqeHMydEdyMmdSdk5KYmZMaGtWWkhDUUhIREtk?=
 =?utf-8?B?QjBkeXRnRzE5dG9GTFhndVZtTWZDTnh4bHYwdk5qbXhrV3prbFArM29PdXN6?=
 =?utf-8?B?V1FuMW44V29FWTg4RjZidUlGVkVGZEdTWjR3dGVTeHJRb1BRT2l4M2k1UW9P?=
 =?utf-8?B?TWtoQzk2dTh1d2UvM2EyOS9oVW45citISmRzS3V6WEp1bC9VWjJWS1dqNU52?=
 =?utf-8?B?VjNpVnNqUEQrSk5sMVdRcEM0d2laclBQdGl3M08xT0xtYTNKL2g0N3ZXNnZp?=
 =?utf-8?B?amFJdEFoaHE2YWEyZTlRUlJHV1ZCYXlNZUtBODVqYU9WWmVpZ1lHaVdBYVpV?=
 =?utf-8?B?aGFaT1hKaDJlbGZ4M3p6ZERSdmFhdG9yeW1BWkx3T0tZU1RWbU1WcjJqb0RI?=
 =?utf-8?B?SnNQT1dxVElYcGpLdEZFZGdUZnRCbWloOXg3STdCVk5PTFJ2MzJ6THYwUjFk?=
 =?utf-8?B?MjlsZE5PZkpLZ3FaWlJqRDE4TFJMQzY2MFo4bjg1L3ZTa0dseTVSOHVxeHd3?=
 =?utf-8?B?NkVrTU11UXJ5WjhLN1Z6d011TUJzenBIdjFiTUUzeUJZREVrY0lWY0ZXR2g2?=
 =?utf-8?B?Yk44bmtRL3JzSXUvZ0NyOXVYQ0E2Q1UwbnZSTlVhSjAycWhNQXVmWGRLNWVv?=
 =?utf-8?B?elBiZCsrTTRqbmZKc1JVTmUvZUhvWS9WbG0wZSt0UXduRzlRZ1diREJndzFu?=
 =?utf-8?B?ajRuMktyUVF1elpPVUxkYlJVRmpySnVSY2lNU1FFK3luTmdBNkdxTTJ4ei9G?=
 =?utf-8?B?UGloa0kwM3BFUml5MVlsamE3UkE0SlJyaFJodnZnWGZINjhaVEJHNzdRTmph?=
 =?utf-8?B?a3NMeE4rZVNMajltKzVwcFRJM1BsNk5aVGJucWtYRkpJSjJ1UjMwL3VDa1Er?=
 =?utf-8?Q?9uwVZ5hPCmU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REpzRTdMdUxzK0ZST2JkTW02NitrQTJ1dExmNWsvUlcxZmplWFR0MmU0VmI1?=
 =?utf-8?B?bDZxalpoOTFVcXRSdFdza0tOK1FZSUxBaGx2eHRpV1Z3cUFMd0EzMGpWSXVN?=
 =?utf-8?B?OTNFb3VTTjNjUktjQm45ejJQWVg1UVFjYnQxbTRpdEVjS3JhOC9NdG5zQ0xo?=
 =?utf-8?B?SlI5SU5GRStCTHZqcjZBMGNqNGJ1MVNpMHNQLzFLT3l2WTFEcVhGUFZ1SEZG?=
 =?utf-8?B?QWpTQXEzKzdqaXllU1k0R0U0SWlTK1dWRForYkRMeU9icnZ3YkNOZjRRa2Yy?=
 =?utf-8?B?b1pRTFRjK3hXaFMzOEc4Z0dzQjI4S05kTlFFYy95OFkrTXQ5dTdxWndSclh3?=
 =?utf-8?B?SkZPTC85emVIOXhsQjhvYkNWMGdnN2ZwbUVzUEIwZ21adFI3SW1zTDkzeEJR?=
 =?utf-8?B?T3ZRN0R3Uk0xamtSVnRIMExZemRiQ0tqK2xQa3N1QXdqRHd3OGtyVjNSQzVr?=
 =?utf-8?B?NmNtb0x6NGhNbWxGdTYwRktBRzRiMkw5S2NFNktQR2dTaGV4Z3hXcXpMaVp5?=
 =?utf-8?B?SnNlSHF5eEovOXNiNHFKclRDckUvMGxoMWtzY2hPVDdlQUtENHZKdHJWbGtk?=
 =?utf-8?B?b0VBUEdmK2VncHdqaUljOG84NzFJN2JKZVo4aDhQWUEvWnM0ZCtEUldoSGpU?=
 =?utf-8?B?TXVOV1dzZnlsNFlJWHVvbk4rTm9OdTE3Y1JSczRSdHpkZytoUWphYXNyeG5N?=
 =?utf-8?B?cVlhVWdZOHF4YURoME01L3RXdlM2TEFtZ1ZkM2JVNENqMGwwOVZOR2REOXNX?=
 =?utf-8?B?bDVJYXBxSlVoMHJYT0M4amtpdTBJOTFnUG0zNzNtTjUwd2Y5Q1pvTzNaYmto?=
 =?utf-8?B?WEkyR0FtclpNc3RxSURiRUxUTUdyNEttMjBmVW40bmhnT2dzUFpNZWgwVUpT?=
 =?utf-8?B?TjRaZWpUbFV5V2JTV29aNVA3ajJmb21RdHl3SzVlaU1GYzVpUEVLSVMxNG1s?=
 =?utf-8?B?UHJkdlNyUjBqV2VsNDFhclpqZEtKU0gwTVFMWUUyMWFqNGJsUSs4dTBKcDZT?=
 =?utf-8?B?UERhNmwxM1ZyOUtBN0NSZVNRYndDTHZRRTFFaXl4a3RKMk96dWlhSmNjL0t6?=
 =?utf-8?B?MXdNTGdBeTJCR25NK1R6Y0xHT1lXNWYrUjF5Z0hkYlV1NkNnTUNEYzk4L3Ur?=
 =?utf-8?B?b3Q5K2E3bCs4c2xMUHo0MktqcXZ0UFBjV1RTeVM3Z0krbUdZb1N3VlBDTUQz?=
 =?utf-8?B?TVFHU2tJaGRyNmdyQzMxMHlXTUVtdU9wa0gwSVM1Nm5QZEpBSEt1N1RyKzcw?=
 =?utf-8?B?NXE2OW5wRFgza0dpTTc4YVZXWVFwUEE1dlJqd2RIUVFtWG9vRUNLNmhWaXdI?=
 =?utf-8?B?dHNEUUxFaXZYa1B3K0E1ejBGNjlUYjBwNGRCK1Z0NC9EYWhybTJtZC9BTStk?=
 =?utf-8?B?U0RXWlA1NHZmWWlyL0dnWDAwK0MrVTF2b2hRYXNnVytJZ0k0MUJSc0o4V0pE?=
 =?utf-8?B?QjBqVUNmK1JKcTVxM2NkQlZLSkF4QW5udVZJT2xManZUSnpydUtnZGpqY2pu?=
 =?utf-8?B?aC8vTC85RW1iYzYyanpSMGFYbkRoTnd3NCtValAxelpqMFVSMmRmZUdZWW5r?=
 =?utf-8?B?ZkgwMktaLzRQejJIamFvU1BUK1kyQkFKMUtGOXplK3psM01Oai9GNlRJSzBz?=
 =?utf-8?B?RTJ4Y1NJVXhKZ01yTmhzL1hhNW1wV1BlRmF2Y3V5Wis4cE14NXZOUUxYU0pJ?=
 =?utf-8?B?T05vMWI5RnZFYmNaK0d1MklLckhLYS9UN2tNVmp5Q1R3WENvcmZUcHg3VkRz?=
 =?utf-8?B?bC9weE1wdFJHWTIxWWdzdFBKandCajBkWkNlR0ZkWUd0YVd5c1VuVW1YNjBH?=
 =?utf-8?B?aUg3a1VlbzZUUTg3QW01MDUxM0hsQzZmZHNaMWRIMTRVWXdxcDRXTjBwclJQ?=
 =?utf-8?B?ODNZNG9MK0JIUGdNOEtEZ1lCa1E4a05qZFVHLzVqSDNFSS9FdDJ3UG1rbDJM?=
 =?utf-8?B?aVBXeGQwU2hueXVzSmpvS1hYSjlLdzhRYno3Y1F0cjJITGRrTHBUT2lReWFq?=
 =?utf-8?B?SEdkWmFRTTl5T3FzUU1DRm1WTEFyTGRlZFd4NjB5RTAxYjJac29aZVM1c2dl?=
 =?utf-8?B?VXZRNlduNG04cXNVTjFYWkNsUU56SlhzQnNRVUViTGp4RjhuaWN0b1lKUjRy?=
 =?utf-8?B?RUVPSDhPNEd4Q2ZrYXNZTFkvSTVHUEh6dWhSaEJUWEF5ODQxR0dzdXpzWmNt?=
 =?utf-8?B?ZVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VzP6zFUdRELDfZ2ulWa7aVRQ3zuxPj2mKIYBIwQiYnGpD3qm1tur5V9pYfh6VTi4XzUxrv9XlbLLQAazz+LHnoPeeXeYC084SOMy4IuR8X41OlN1XCFFhKlVmumhLxNS6jIO/dMdQPbbXi7AHqqIdEhAH+Be8Pnv5IZDIVnnj+9kRrG5QfguF6lehviCU0TlfMvR6d40M2RBcWOT4L6hFa929WJFyFlzNU8jGDB+AM+xz9rlndw31Wo2HbsvxMEP+3A5S0Jjvc742kdFlZOU/Xy8LdTl+nLLGRmPdZueJBQIMs9QljATJ1AJNbsmWXXNHTx2tA9f9ZQ2vJ7dgB3NAA0Nv0Ba6FjU3BdNjRkdA1s4vTFJHGbgSiTRjhE4izD9mSm+MHc1GrfxorxFDKteIoUDW17IqmrAmfZRn6plC/yjEGZXt0JEYj9WFFhep5xb8Rz2pscTi3jNYxuAg5DxbtlaGT9Plufui3zfGoJ9N+HBOY4r5eLtT0Gi9nsV+i3Vf5MUC4sBXbY6y5llk1/BMglRw5YmYUQlu2VqaMsv8QVL3Ud9qMSgN5FCoFPhliVXKv7v1jecxRnr8wXv4gKCjHECUQXEmzkuW8mKh+rQeU8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73f2a003-eea2-419f-0354-08dd8438d9ce
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 20:36:26.5726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0lx238gn97vNFLpByZhenhhfslSvM11AJPu6CS+0DoMr+NcQghZqb4768f2ylFHB14sfJsFUsEkf/xRBx4eaIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6908
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504250147
X-Proofpoint-ORIG-GUID: G--sLev4Kra7nn5IaY_jhpZgTi-bM-zI
X-Proofpoint-GUID: G--sLev4Kra7nn5IaY_jhpZgTi-bM-zI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDE0NyBTYWx0ZWRfX1RqT9+SSILDm DM+pviI+yNbCVF8q+D5yokRW/9B7NzgqGACADqR0+U8WzqXpHIpU/9Fjsi91ML98Dwv+Zg9nl/d dMSzMxM1k0CZtpBDwNjzOXjDRjjQNWJtXvOX+oWiugpM7MZ/nZvDNmtE+83HL3bjqhGljazL9cI
 wq8K2EA48uLD4kR1kBlIXZLU3i+Fk3nKFM7LHEd7YB+Kf7a5BrG0YNtBMgd2Gpn2Ew3bgAuNI6f WQ/yO4j/o19YdyFTlH1WnpA3Nt2Q7y27gDwLSmkNXEHlDPafkvwPzxzgsb08iHkOh6LdfWAL8RV zWaYtE97E3SvjCKZ6xtd9Vu+C60PmpGoUR4jlTu8YW9qD6VJtjY8HO56Y+VjJtoT5f9QsTrAMcH bWopLrCI

On 25/04/2025 18:58, Andrii Nakryiko wrote:
> On Fri, Apr 25, 2025 at 10:50 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> On 25/04/2025 15:50, Alexei Starovoitov wrote:
>>> Hi All,
>>>
>>> Looks like pahole fails to deduplicate BTF when kernel and
>>> kernel module are built with gcc-14.
>>> I see this issue with various kernel .config-s on bpf and
>>> bpf-next trees.
>>> I tried pahole 1.28 and the latest master. Same issues.
>>>
>>> BTF in bpf_testmod.ko built with gcc-14 has 2849 types.
>>> When built with gcc-13 it has 454 types.
>>> So something is confusing dedup logic.
>>> Would be great if dedup experts can take a look,
>>> since this dedup issue is breaking a lot of selftests/bpf.
>>>
>>> Also vmlinux.h generated out of the kernel compiled with gcc-13
>>> and out of the kernel compiled with gcc-14 shows these differences:
>>>
>>> --- vmlinux13.h    2025-04-24 21:33:50.556884372 -0700
>>> +++ vmlinux14.h    2025-04-24 21:39:10.310488992 -0700
>>> @@ -148815,7 +148815,6 @@
>>>  extern int hid_bpf_input_report(struct hid_bpf_ctx *ctx, enum
>>> hid_report_type type, u8 *buf, const size_t buf__sz) __weak __ksym;
>>>  extern void hid_bpf_release_context(struct hid_bpf_ctx *ctx) __weak __ksym;
>>>  extern int hid_bpf_try_input_report(struct hid_bpf_ctx *ctx, enum
>>> hid_report_type type, u8 *buf, const size_t buf__sz) __weak __ksym;
>>> -extern bool scx_bpf_consume(u64 dsq_id) __weak __ksym;
>>>  extern int scx_bpf_cpu_node(s32 cpu) __weak __ksym;
>>>  extern struct rq *scx_bpf_cpu_rq(s32 cpu) __weak __ksym;
>>>  extern u32 scx_bpf_cpuperf_cap(s32 cpu) __weak __ksym;
>>> @@ -148825,12 +148824,8 @@
>>>  extern void scx_bpf_destroy_dsq(u64 dsq_id) __weak __ksym;
>>>  extern void scx_bpf_dispatch(struct task_struct *p, u64 dsq_id, u64
>>> slice, u64 enq_flags) __weak __ksym;
>>>  extern void scx_bpf_dispatch_cancel(void) __weak __ksym;
>>> -extern bool scx_bpf_dispatch_from_dsq(struct bpf_iter_scx_dsq
>>> *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __weak
>>> __ksym;
>>> -extern void scx_bpf_dispatch_from_dsq_set_slice(struct
>>> bpf_iter_scx_dsq *it__iter, u64 slice) __weak __ksym;
>>>  extern void scx_bpf_dispatch_from_dsq_set_vtime(struct
>>> bpf_iter_scx_dsq *it__iter, u64 vtime) __weak __ksym;
>>>  extern u32 scx_bpf_dispatch_nr_slots(void) __weak __ksym;
>>> -extern void scx_bpf_dispatch_vtime(struct task_struct *p, u64 dsq_id,
>>> u64 slice, u64 vtime, u64 enq_flags) __weak __ksym;
>>> -extern bool scx_bpf_dispatch_vtime_from_dsq(struct bpf_iter_scx_dsq
>>> *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __weak
>>> __ksym;
>>>  extern void scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64
>>> slice, u64 enq_flags) __weak __ksym;
>>>  extern void scx_bpf_dsq_insert_vtime(struct task_struct *p, u64
>>> dsq_id, u64 slice, u64 vtime, u64 enq_flags) __weak __ksym;
>>>  extern bool scx_bpf_dsq_move(struct bpf_iter_scx_dsq *it__iter,
>>> struct task_struct *p, u64 dsq_id, u64 enq_flags) __weak __ksym;
>>>
>>> gcc-14's kernel is clearly wrong.
>>> These 5 kfuncs still exist in the kernel.
>>> I manually checked there is no if __GNUC__ > 13 in the code.
>>> Also:
>>> nm bld/vmlinux|grep -w scx_bpf_consume
>>> ffffffff8159d4b0 T scx_bpf_consume
>>> ffffffff8120ea81 t scx_bpf_consume.cold
>>>
>>> I suspect the second issue is not related to the dedup problem.
>>> All 5 missing kfuncs have ".cold" optimized bodies.
>>> But ".cold" maybe a red herring, since
>>> nm bld/vmlinux|grep -w scx_bpf_dispatch
>>> ffffffff8159d020 T scx_bpf_dispatch
>>> ffffffff8120ea0f t scx_bpf_dispatch.cold
>>> but this kfunc is present in vmlinux14.h
>>>
>>> If it makes a difference I have these configs:
>>> # CONFIG_DEBUG_INFO_DWARF4 is not set
>>> # CONFIG_DEBUG_INFO_DWARF5 is not set
>>> # CONFIG_DEBUG_INFO_REDUCED is not set
>>> CONFIG_DEBUG_INFO_COMPRESSED_NONE=y
>>> # CONFIG_DEBUG_INFO_COMPRESSED_ZLIB is not set
>>> # CONFIG_DEBUG_INFO_SPLIT is not set
>>> CONFIG_DEBUG_INFO_BTF=y
>>> CONFIG_PAHOLE_HAS_SPLIT_BTF=y
>>> CONFIG_DEBUG_INFO_BTF_MODULES=y
>>
>> thanks for the report! I've just reproduced this now with gcc 14; my
>> initial theory was it might be DWARF5-related, but dedup issues occur
>> for modules with CONFIG_DEBUG_INFO_DWARF4=y also. I'm seeing task_struct
>> duplicates in module BTF among other things, so I will try and dig
>> further and report back when I find something. Like you I suspect the
> 
> This is a bizarre case. I have a custom small tool that recursively
> traverses two parallel subgraphs of BTF types and prints anything that
> differs between them ([0]). (I had to disable distilled BTF to make
> use of this, the issue is present both with distilled BTF and
> without).
> 
> I see that struct sock both in vmlinux and bpf_testmod.ko are
> *IDENTICAL*. There is no difference I could detect. So very weird. I'm
> thinking of bisecting, as this didn't happen before with exactly the
> same compiler and pahole, so this must be a kernel-side change.
> 
>   [0] https://github.com/anakryiko/libbpf-bootstrap/tree/btfdiff-hack
> 

thanks for the pointer to this! My initial suspicion was that we had
some sort of dups of slightly-differently-defined primitive types that
bubbled up through multiple structs in the module case since the level
of duplication is so high; a colleague ran across something like this
recently and indeed if I dump vmlinux BTF in C format I see:

typedef unsigned char u8___2;

...along with the original u8 definition:

typedef unsigned char __u8;
typedef __u8 u8;

However on checking I didn't find any references to the "wrong" u8, so I
don't think it is the cause (the definition comes from
crypto/jitterentropy.c so as a .c redefinition it's less likely to cause
chaos across multiple CUs).

Perhaps we should be thinking of cases where "#ifdef MODULE" leads to
different structure content, maybe something changed that results in
that leaking into core kernel structures like task_struct. Haven't had
any luck finding a common culprit across duplicated structures yet..

Alan

