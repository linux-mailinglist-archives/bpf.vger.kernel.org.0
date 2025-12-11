Return-Path: <bpf+bounces-76461-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4747ECB5204
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 09:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B54D23010AB6
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 08:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB8A2D8791;
	Thu, 11 Dec 2025 08:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="r1K5mUMw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="g+x9ncKU"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AC128F5;
	Thu, 11 Dec 2025 08:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765442229; cv=fail; b=t6wI0ryAew66Xfp7MbD+YgcNRGfehgP3UFTzYjB7B51vks66kiGiK6mLGR/V5pQDXSdQMNYom2aXjZRFsKAcSAckIqleWf2BEZI/2LG1pqmg5yKA30Bepr+SHF5cOdmm/aR7Son1CRy6fDJ5txbPCoAHYiNnNHMz2ltKifSCGd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765442229; c=relaxed/simple;
	bh=8NL1+oKEEui7g0yrf6RJcHeisOAbzFKRF5qqE5kwlMw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p9mytH7k6kJlmabdZ1X3rTdntg0iixcmi9ZZFZvkFgzadPEfNqyBxj5nr47pa+5OBhe9IVzFJbcHgFQQbGEjX1qpSt//ZwMPTiuqhBMZppWhACSgX33Sy5YlEVW9x8aXROTrUNZNm2oAvs9d+pokzTRF7bhyaI3FeMRnpmTsWFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=r1K5mUMw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=g+x9ncKU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BB3oXbS428593;
	Thu, 11 Dec 2025 08:36:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=0e24IILqFxfikN/ldGbJkj9lG9kG1/NkjD1LB+NTwbE=; b=
	r1K5mUMw2jzzGonofezz/L+7sIfmeL2msUf68y6KIH/43eWNnxScsiZmuacYBN2N
	B06hGA+Uz9muwQFqMSKO7nalBfjTqiQgT8eIR+whlqmHB4cMrHl7u5prVD5Glmrr
	rL70WHiDZ3Nkx+LO/wUphGGYno18PnM9TWgAajaGnNzONYnMiOPHU4CrxqvHh8+P
	MA9K5PbqlUU2mtWiBNMGcmblqJ5mdI5bFJMvpBut/m6+1S3oHFmgPQrgjYjUFB65
	vNbbO1YVqPeTpYN/Z1h8BGrz2genJggMGlS7jwpxOaOIZpMQisVHwsGzxGBJJwpA
	5iPLITgaPvmGpbnkfVzNeA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aycqb94eb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Dec 2025 08:36:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BB6o06c040016;
	Thu, 11 Dec 2025 08:36:15 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012040.outbound.protection.outlook.com [52.101.53.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4avaxnckpt-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Dec 2025 08:36:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lZI7fdUxQfa7slZhD65vhIrUXi7CjT5oEBKxsuRMArZ/tQMlnh4tTb/8HF+RQLyHtDxHr2k6X+0y4n0C3z3sQDFxLwfub+ENAleXmATDjQAJ1/IUf7rNH9zizGkm0OzbfbFUTiFk+isghd3jxCYuwUWKpbpOvW+UKXqkkssWKjJ4kCp15rXGqq0z7tiPi7B4OxvjMuaYYiV8pxlUzdANE6W2GPORVZcYxEp6teNyWGIiHIxBAXPIKaYAFb1Tg1a7oxKB88tGudnHIzJlj8oHvzhDtwaYJN7Nhj40W6iQ/ZK3pa7krs6LSHKHsp++A0JgL6T+4WV0hIqGZlvuBY3u6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0e24IILqFxfikN/ldGbJkj9lG9kG1/NkjD1LB+NTwbE=;
 b=jQkn1MDMFwkwu0F6xt6GAp1cNRUMqketx4Y1HEZz5gNREG42Jt/iT0wQ2NnARr49FtLjawMyLnk42haQ4LmtPpKQNYzdCYias4DTxmsSQq/zhRaEslusW5cCAH2xFepsJowMhsLqyXcNPtpqJuyZFQgbyVIJm2zF5HwyHzoKVBq/iqxhKfOApQVUiaEssZyf9IPTYyrfDlQUX1vcwfONvdLxnAGrNmVddNu5sk0O6zM6xoS82IYZAZmIDRORA0Dm0ZA89mHoLj9BRZCYBv6UIqcgRBNCEOQq3qSjhKkRMNrAiyaM0Ek5EyKsXXSnJsLGl/3dYE+uXtcLbrDYJ3NvSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0e24IILqFxfikN/ldGbJkj9lG9kG1/NkjD1LB+NTwbE=;
 b=g+x9ncKU+DgQCI/NjATNzFpbU3sp7L5bhzJm8U+D5/J7zCqmGgyHK+LPv+uGpHSCEqXFpdpqp0IGSs8K3TwiQQ3zMA69yVMXspRd3f+76k/kHjHwdVJ5OGHJjcoEkUGtca6MGb4y1YI0E1irf1/l07NLq60lj1On977IEn5gOUI=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 BLAPR10MB5122.namprd10.prod.outlook.com (2603:10b6:208:328::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Thu, 11 Dec
 2025 08:36:13 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 08:36:13 +0000
Message-ID: <060ad1a8-a457-4adf-b8ee-f43bd3dd5ac2@oracle.com>
Date: Thu, 11 Dec 2025 08:36:05 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 bpf-next 04/10] libbpf: Add kind layout encoding
 support
To: bot+bpf-ci@kernel.org, andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        dwarves@vger.kernel.org, bpf@vger.kernel.org, ttreyer@meta.com,
        martin.lau@kernel.org, clm@meta.com
References: <20251210203243.814529-5-alan.maguire@oracle.com>
 <6e0f6354688867327290334013a595b8d548820a7d374cbe607a86cc5bedf293@mail.kernel.org>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <6e0f6354688867327290334013a595b8d548820a7d374cbe607a86cc5bedf293@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO0P265CA0007.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::18) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|BLAPR10MB5122:EE_
X-MS-Office365-Filtering-Correlation-Id: bd6d50cc-69f0-417b-591c-08de389057a9
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?aFBPa2lEYTJZU0V4MXJ3SEtTdW56UVBkUjIxV0Mzb0pxMkFoazB6WjNJeUJT?=
 =?utf-8?B?dzNVK0pmOFBidmxWWWtacHFsV1NVdG04RURQQTJjVWRxczNYTndHMlEwYXAr?=
 =?utf-8?B?Nnh1TTY5SnlCWHZJODVpbERmNlk1TytIREIxOXBiUnZQa2h3di9jQ2VhaHVT?=
 =?utf-8?B?eDhnVUZDREcxaTdweTAvaW04bGsvUk84dFh0UUNyMXNFWjBPNWE4Z015cnFD?=
 =?utf-8?B?cmNzMkFwZ0l3bXM3REFid0tiWDdiVjZFUEIzc3poTXNWeXo5TXZ2OWJtQ1Iy?=
 =?utf-8?B?MDZkUGFVUC82M0ZKU1VSMGxLR2U3NW9uZCtnZERWK0hJT3RCUFBnVGh4a0o5?=
 =?utf-8?B?NzhTUm5LUVNJZTlBN1BGcG5JeWRJR0Q1YTNSS25xdlBEQTBMVG5GZ1gwTkZM?=
 =?utf-8?B?Rkd1L0hGdHMwK01OVC90UStmSmVZQzZ0c2JLMXovQzRhajJPYWp5R05wUkFi?=
 =?utf-8?B?dy9zV0ltaWZGMXFhWXo2ek5uUVJZbVk1N3RDenFZVmVEdytNVTZxaFRiaXVY?=
 =?utf-8?B?VVJhN3ZsaXE0aW1tWGp5b2hlR0RRdCtTdWhERVppTTVBdzc0L3MxY2V0M0hM?=
 =?utf-8?B?bnBqTzkwdzZOai92bzY0bEZtbzFPMWwrK3dPNXd0blE4aFJCd3BEck9mYzF0?=
 =?utf-8?B?cS9waVV6Zms4Y3JxbEZHclBCRzYwRHZhYmhqcFBQb3NMOFY5WW5RbE9aV1lB?=
 =?utf-8?B?ZFRGWHQxUGtXQ2Z0ZjBleU5LSDd0TjZXMi94V2JmWFpxTEdyNXlObWJBWGlP?=
 =?utf-8?B?Q0x3aUdlUjBOZTBvOHZielpLZVY1dk9qRFZSWHBMQ0lsZTFwcjRIalJGaDhm?=
 =?utf-8?B?Ry9FTGE2dVRPWjQ3aWg5L1MxSE9wbG1IekxKRjQ1emkrYW9hUUhBb2xuTHJ3?=
 =?utf-8?B?Y0tuV2cxZ2F6OVlnYU1wR0gvenRsMDNvQjhtRkhzL085L3N5ZXozVXlnS250?=
 =?utf-8?B?d1N1bUpRYTMzejJoNFZUam9wT1NLMCtOM09Ucld1WFVhVlB3b2kxMjJqbC96?=
 =?utf-8?B?Vm8rWE14T0Qvei9iQUhEdk16dnhNcG4xYVhqT0JxcFN3RFYvcHJHdVd6d2VR?=
 =?utf-8?B?Q1hzakhld0gzcXFnNjRwWmUzMitkczRKWTN6Z2ZvbFJFZXNaUjAySVFlWWxK?=
 =?utf-8?B?Ukd5bnRKWm91dHBzcTFQRXl3c3pnaFkzeC9OaWowQ29JNEt3UWpRcHRxL1hn?=
 =?utf-8?B?eVRadzh0ZEtmUmt3OGpBTldicHdrSjhFMHJ3TmhzRmo0cWVpamZhdFlScUtj?=
 =?utf-8?B?d0VHOUt0bHRDdjE5UEFiWEZWdElWcHdhV2g2cS9SMTZEWXhIWWJ3Z0JWdlo0?=
 =?utf-8?B?YnQwd0tnVTZmQnY4N0hXRHhmdEQxZDNubVpFSUhLdXo1Mi96UHVnTzdCL1hi?=
 =?utf-8?B?ekZEMXhwem4va0lHNUdKTXlyZy8yNDFDU0tpNHJsQ0RKN1ZWKzlXNktNSjdl?=
 =?utf-8?B?RjdZeHpyL21mb1l1Q0xVRDRiYUUzdDJwNnlMbDlyOVBoMG9vZUZ2elgxdnQ5?=
 =?utf-8?B?a2VJYXhrQm1DVDVIbDBUcFJhM25hTDZyMFhBa2UvdzM1eHlRU1dNbXhBQXcr?=
 =?utf-8?B?b2Nxdml3VUh1L21FMkZnWFU4L01COWxUOTBjb1V2ZjFWVzkydldMa3o1WWJD?=
 =?utf-8?B?WHR6Sm5yK1hBVWV1ZURFVTJyQjJpdzBFeUdYZ1ZQTHN2SkJXUisrcFhkNnNP?=
 =?utf-8?B?MTdpNkRXU3dyVDVtVlhUUWZMUU1jWjVvRldrZDl4S3gzSEJHYVByTVNzTkpY?=
 =?utf-8?B?Sm1MSFM5YmRTK2xNK1E0NER5SDZJWjhPZkRrOHBpTHRBdGNWdlFJR2Y1NS9s?=
 =?utf-8?B?QnF5ZDRZcU50bmdHSnpYdlpldDNrb2tOMTBGbEF4d0lxc1BpOTQ5VzZPN256?=
 =?utf-8?B?NzdwV0lieEhncmxDL2sxc0R6Ri9DZlZ5MlhLT0J1cGJ6cE1tTjdtdlo3M3F4?=
 =?utf-8?B?WTF4ck85Sk1GbTArZkNDRjU1N1E0TXhPSmxiL3lvTUVGd0hHZkZWalFvQjZW?=
 =?utf-8?B?UHl0MEV6UDZnPT0=?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?cXdEdkFpMTVKRDJvdHRiSElTRXhvOTYxZnd2amRMSTk3SyszeVZVMmxLODVM?=
 =?utf-8?B?N090Z1Yzem1VclZIQUE0NGpjZTMzYlRuSUoxUHM0M2xYMi8zbWZIZkZZTEVL?=
 =?utf-8?B?ZEN1ditCelhZTlVVbEt3NEdUdjg2U2NVa0h0NDFxbTcwWnBsNjgvK1BNNGVh?=
 =?utf-8?B?dWRJUTZHYWVCVkY3L1h2V0NlVGVvTFFUNVNMcDUrekZUY0lySk1aN2pXSDht?=
 =?utf-8?B?MDA5NEVsQlg5dVljaUVCRmkvWlFyN0Jwanl4eGdCWmZ6QlRRUWwrOEp0V3Ry?=
 =?utf-8?B?UnVCQmU0Q0c1UnN3U1ZKd01TL1RQZHYrblJBSVlUb21Odi9oeFlNRUhqaTN4?=
 =?utf-8?B?ZWhRZGpCUDk2R2oyQ01Wd2wzTHAzTWV6UXZBWUNjWXI0eGVjNm4yTkEvSVhD?=
 =?utf-8?B?eUgrMk5QWnFjR1ZKNmlXVUdJNTZuY2JPd3MzamdZVXdGOTVyczZjOHJOb1ZO?=
 =?utf-8?B?N0tTcFZ1NVJ4a3hQelNhL0IzMjdRZlJrcFlieUVCRVlITDl4N21SUTk2VWIz?=
 =?utf-8?B?bnlKQS93NkROM2R1cHNwTWxGRDNYTzh3anBTRzhXVnIyQjd4Zlc0Nk9EdmNS?=
 =?utf-8?B?TlR0bmxBQ1dpdEhLd01EZG41d0xNREdhR3o4UkVwTTdaZm01Nkt6K21iZ3Iz?=
 =?utf-8?B?dHNtcXRZU3pvNXU3SkNtWEIwc3lkazd3V0N4VDFkS1lmYUhKWWpUcWRlam5i?=
 =?utf-8?B?YVd5QlZTdEU0eUxja2VvYUZsT2ZNbTNHYkgyRG1NZHcwYmdUZFp1SklBemth?=
 =?utf-8?B?MzVJbzd6ZVpJVFZrUXZtcWtIdmZpdmdwaXlaT29xTGRSZUZKNjA4TVh6dFJF?=
 =?utf-8?B?SzFWK240MFZNWTRwcGNqN1FEa2JSYXYxdEdjZFpkazhYbko0by9ZUk8rNDd6?=
 =?utf-8?B?VWRWUjlCU2tlcm9OWWhhaGMwN2ZUNWxid3QxWk9iR2hJMGgrNlZxdk1GaW9R?=
 =?utf-8?B?YXJaY3oyUzNmWHFiM1lXKzFFUTJOcUIvWFhqSWh1bHJpVVo4Q2VCeExuRmNy?=
 =?utf-8?B?ZFJOVlB4QnpBUGFPVGJ1QWJnUkl3NVRJclhYa3JYWGFKWVVjK05Yd0tWNDlC?=
 =?utf-8?B?Y0hjb2trcldzeGlUdVZwWW0ydlhrTUZkeG4rVzNiV00zTGNFZFh5dXhyWlE4?=
 =?utf-8?B?Ni9SQ3d3TmhCcno4R21Ic3JhVVJ5bzdoK0VBV0NYTkY4SHhzNFltOG9GMXpT?=
 =?utf-8?B?STlrQkwveEVRTkl4a3RyQmRIcEthNVZnSDdWODFTR0hHWkZ5Sk1ZblB6WmNj?=
 =?utf-8?B?bldpNExaWTlXbmlTbWNtVlNHQURtMEVWYlJiK0xFTWxvVGtsY3JJbFlIKzZZ?=
 =?utf-8?B?SCtHTFY0bmFUVzZaNU1qSEtqQlk4eS9OdzdLWk4rL2tNb2xGQTduTkN3eGVC?=
 =?utf-8?B?Qld1OE96WEJPTEFhVk9COEZ6dXFPamI3c3B1SzNndGw4VjlzM3lWTWtQWHJP?=
 =?utf-8?B?eHlCWXppeUo3anQzQWQ0K3h3b29XK09ibDJpSkVZOXJnZTI0WDJETmc0bEly?=
 =?utf-8?B?OCtkL2dLQ3VWaWZXRTM3MEFIM1JwcjFqT2ZnT0gwaDRGQmU0cnhqUllXd3Y0?=
 =?utf-8?B?R2JsZXZrYVN0VElqOFQxb0ZUU2pZcVZ4VmxwMmJwaUQ4S3JMdVphV1ZyU0Nq?=
 =?utf-8?B?L1Qrbk9XWGJZa3paaXc2SGVtVWRvR290dGw4aWcvQ1IvWVc5MCs2UVJOeS9y?=
 =?utf-8?B?bjRodS96b01OL2g0MmkwbFAwM2E2OERvNFdoSHZ6a3FhSTRRV3k0OEp4R0NY?=
 =?utf-8?B?c3dySVlheE8zczA4cGlTWUJHT0tMNlhMdXZscFFORU12WnJ0RU4vSnFnRmNn?=
 =?utf-8?B?dGhoQm1zeWtlUzdXUWRCcmtvM3NEUXhXZDhCbytVemo2a09pOGFIdVN1TEJ1?=
 =?utf-8?B?WGF2VHQyTktXNDFYaWFCMTZiSHQyS0RFZndEcFBoMGFGbEFTb2tMRHR5dVJo?=
 =?utf-8?B?Qy8wSENYazVLeXEyTGRMRFJCL21QeW1yNUpVRHIzNmM2bzJQY2h5YzJLNXl5?=
 =?utf-8?B?RFB5ekNRTnd5TUhqWCtHbG94MVgzUVp4czZkaHAzNG14L0w5MGxrb0E2UzZi?=
 =?utf-8?B?S2d0S3F1bDNYUTl4TXB6cStHMnc2aU5RRStTZDQ5OVVPakxoQUlGa0d1Umsy?=
 =?utf-8?B?UzEzdFZvZmxOdGpya0NRclZSN2htRTNjYTFxS1dxMlNycVREaFJManRMK1h2?=
 =?utf-8?B?blE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PH6ajbcFOmkg0a3QKECoqLjWMemT7MEk8UxTQrmu7thwr/VGOvxA7muYgflrFncewHFYfXqLYg7k1jeCbBSnNkWp24TIX0CZtokWsANU3XS7IXDY2ZU06kifpn29e8a4y6KJ0zHoqTuMLZdCp7rhsX4N12V3CEs9aJ0fGWVtl6/oLaJkW4GYphx++md+c3E4wlf7RuhzN2m4TziYs8DgrGc4gBIToCWdmricidqUWLyAGU2uJI2tyn8PI8vqFdZ59cc+jlOa20+9lgx+onbroQPkfUeO+16E6FhcqTWiUrVNegVvaEzzTCOszxlit/sNYuP65anXh1V3ChyvlEr1uDDyRNYtZjFVrk4e7c0qifBgf4czKc37GhDMUHhLBWrrKX24+8FQh0mUFVlnZ79QYKWf0eCAh5Ymkw/Lfp9QZU9kikGSh+/XsvyTm83PgUO7/SIOxm8dwyBKR/oVdJknbkctqdMylbQfVsUA7KV7P2yYc8npkXwC81EPo2BcvtZLizOFPBeOiZr0NJpw3fC6blM84ZpxVSYiIEokoa+NWT8hhiPEuWFXL2ajUAYWYxTPfxlMChmBDeIeS/9zGAEjJL2r946VhJbjEumix9f/URs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd6d50cc-69f0-417b-591c-08de389057a9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 08:36:13.1914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1j+ygFQb534VmBFHfYmDI0/JZjCGAWEmjMpdWKQZoxWxNJT0u10WZP8iWxKWwkPsgn+1Vj++70mXNMZFGTKzAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5122
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-10_03,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512110063
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjExMDA2NCBTYWx0ZWRfX3no9pK4YO7Md
 waGn0Wwz7am7CEqZnLDjcMEY1kYfmaarnjM32PIVJkiXwt6NPaa09ypWaNQ7wEpp3dLsCYfSJ0+
 7mP+yHDa8tzNXRMfB7+kdxxpz9VWY5qVXMvNTtiDl1nFREZ0ys9o5AEl4hvu7smlH55cUpzsCoo
 v+f1pZG3l81CHYaMhYr7qGKLYlNdeoAMExRMwHmmaNQbSEH4sHPEh53TtOC0H9v2wKtNMTSPl+n
 HDakvjUKNttwt6/nHWIJYkzZ8gW/S6X2r6wP9cxXFbXpF56uxWpYXpYmIxSnjjxacXvAMTEfKrP
 h3rdJQtLI8ja/1OHZdr6r3qhwFgCgzsa+9IjpaqATEXcWOCsaSIT19ORYJHSE2u9rN63s2/JZyZ
 M/Uaqn0GX8XoqLr2DljkZnL44UcExqfNgf938WH3yDQAaIbKoR4=
X-Authority-Analysis: v=2.4 cv=R8UO2NRX c=1 sm=1 tr=0 ts=693a8281 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=iFABrAoMAAAA:20 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=Es3bvXVKQ78J18-UYYIA:9
 a=QEXdDO2ut3YA:10 a=bA3UWDv6hWIuX7UZL3qL:22 cc=ntf awl=host:13642
X-Proofpoint-ORIG-GUID: PAskF_eFX5ouWkZcx66KEgF4Uvc4JrBN
X-Proofpoint-GUID: PAskF_eFX5ouWkZcx66KEgF4Uvc4JrBN

On 10/12/2025 20:55, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
>> index 4eb0704a0309..2133e976cb9c 100644
>> --- a/tools/lib/bpf/btf.c
>> +++ b/tools/lib/bpf/btf.c
> 
> [ ... ]
> 
>> -static struct btf *btf_new_empty(struct btf *base_btf)
>> +static struct btf *btf_new_empty(struct btf_new_opts *opts)
>>  {
>> +	struct btf *base_btf = OPTS_GET(opts, base_btf, NULL);
>>  	struct btf_header *hdr;
>>  	struct btf *btf;
>>
>> @@ -1111,6 +1141,17 @@ static struct btf *btf_new_empty(struct btf *base_btf)
>>  		free(btf);
>>  		return ERR_PTR(-ENOMEM);
>>  	}
>> +
>> +	if (opts->add_kind_layout) {
> 
> Can opts be NULL here? The OPTS_VALID() check in btf__new_empty_opts()
> returns true when opts is NULL (!(opts) evaluates to true), so this code
> could dereference NULL. Should this use OPTS_GET(opts, add_kind_layout,
> false) instead?

Will do.

> 
>> +		hdr->kind_layout_len = sizeof(kind_layouts);
>> +		btf->kind_layout = malloc(hdr->kind_layout_len);
>> +		if (!btf->kind_layout) {
>> +			free(btf->hdr);
>> +			free(btf);
>> +			return ERR_PTR(-ENOMEM);
>> +		}
> 
> Does this error path leak btf->raw_data? It was allocated earlier via
> calloc() but isn't freed here, while btf->hdr is freed. The same issue
> appears in the error path above at the check "if (!btf->hdr)" where
> btf->raw_data is also not freed.
>

Will fix.
 
>> +		memcpy(btf->kind_layout, kind_layouts, sizeof(kind_layouts));
>> +	}
>>  	memcpy(btf->hdr, hdr, sizeof(*hdr));
>>
>>  	return btf;
> 
> Also, when a BTF object is created via btf_new_empty() with
> add_kind_layout=true, btf->kind_layout is allocated but btf->modifiable
> remains false (never set to true). Later, when btf__free() is called, it
> only frees btf->kind_layout if btf_is_modifiable() returns true (checking
> the modifiable flag). Does this leak the kind_layout allocation for BTF
> objects created with btf__new_empty_opts()?
> 

We can free btf->kind_layout conditionally as long as it is not pointing into
the btf data section (as would be the case for parsed BTF). Will add the check
in btf__free().

>> @@ -1118,12 +1159,26 @@ static struct btf *btf_new_empty(struct btf *base_btf)
> 
> [ ... ]
> 
>> +struct btf *btf__new_empty_opts(struct btf_new_opts *opts)
>> +{
>> +	if (!OPTS_VALID(opts, btf_new_opts))
>> +		return libbpf_err_ptr(-EINVAL);
>> +
>> +	return libbpf_ptr(btf_new_empty(opts));
>> +}
> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20112692486


