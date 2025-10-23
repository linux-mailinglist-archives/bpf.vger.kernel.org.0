Return-Path: <bpf+bounces-71874-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 934A4BFFE8C
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 10:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 72DBA4FE7F2
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 08:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86F72F83B5;
	Thu, 23 Oct 2025 08:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BJDJidOH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="R2meSy0M"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CBC2F3622
	for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 08:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761207968; cv=fail; b=IVG8BA5YQu39lwMxPp3uI7Vq2xRB5/m+geDpe5YFVWU/mT611C7QVSisXw3SCtnmBfXyddt6anbyH2RxWDJGmN7XL6yE5kAgSuz1g/LZs6V2+fEdjyoZkKNvKPWxOauEnRtdOLzNOzagH0/hZVLq+oLOfDqVnufIKEy8qnGBQ90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761207968; c=relaxed/simple;
	bh=1RPca2EVZ3Dltx9oilx+mrTq4O/hWHa1rVWWxl5N2QA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hfqW/DB/+Y54F14YOXEBh2JOiDWxuvVCjCuvWuZYQkG+SLea9F5NdDt9sgqlLFCMvcjKIE7gO9HS92CqJZhTYrHbwc145y164RMEFlOC6Ulv31O+cOz5B5/qQzrBDbTl4FmnbNd/EGAmf+bPv8oH8eG73yO3IXzTl+VX7zQSTmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BJDJidOH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=R2meSy0M; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N7uYOr002336;
	Thu, 23 Oct 2025 08:25:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=OJKBREWDDftZVsBX43HEfghwXAhCW+6jGvlPgcu4Qf4=; b=
	BJDJidOHDJ9VsyL4LyA38AgIrtsdRMkjxb24CxKGjt45kaam0A1rYfoxgQBwGA9l
	hQ+aMoGzNTTIG95YA6zDnY1xQItTCziwyjGGGbV/7lS13HgEfOmhqDlopGyYikrr
	KYQQSJGh9/tJFYpBwgbm4G+9hlxxKWr9AqazCg8XXr2qWGNfI/JCdtGWmlgSKWr2
	5GGzfMhbg+THfAEpdOsABRLSl3GsQu+hIsTBb6qSbWlV/DDJD4UZcTDlPbqyskHl
	W/ZoETPw/P79SnCotnySb2fHO3NhVV7MGX0XKiOvHlNO67Nmx1yFfeoHhLpW6Gxz
	Dm88sxWVVKQ+x69x6tKmKQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49w1vdrdcj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 08:25:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59N7NxMN025308;
	Thu, 23 Oct 2025 08:25:38 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010030.outbound.protection.outlook.com [40.93.198.30])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49xwk8s1h4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 08:25:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NuGfWGGX9kwzi8Zzij9acmkvfRGEhj8wAzysyfVGerXprIwLjO35quPpxHGE7zksUghYHxWU0yTQTyg63eZQeqhVcFi2OmZ6C1zFLIX25U6jeP33WJkww4FDzFA3mSQBgHJVOpIMx2w4Ms59ZIqYmOEqURVMCW+S+X/g+DOovrwJsVstry+Y8TVEnyqZvgs7kK3m77FbcRkNkx2PEgve269GjPVzeNs2auY7rr1MMgjyK92A4gTQhYIYPYcf9FlodKOC3iRB9nDlaxowf7KxhuClQt7HQLr2VZQRU1gcskQt4sXqyw22iRst4hw/+jvt75utS5mIGbaP/eRqw2wmGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJKBREWDDftZVsBX43HEfghwXAhCW+6jGvlPgcu4Qf4=;
 b=gdQMwaLRKXMRg4pSMMf5xQMxBNlM6rZEyajBfRm9KLeGqa1Mx8SG0nmajQe484GywNq/GrDBsGP7rNOgjsH0OkhdRRxNwaVRZH9xu++qEA8UKGJUcK5r1MZuuygCyyCn9b5huJkUQ/vqbziuzHGDJTuX9bL7BENNOR5Y4CxKRl4tYz4/YB/lGz1gNVogsJ1IgB1tYYXESWLWF5OAfRFrwHWsvi7Pkh1dfHphqnJQXAw8u9LbJezZg5QhnqbyM0oqo8iYM9mDHIHREXXZ0QY65QXMGpDEmdjrQIlkvzZb4UogkTNR3KIAXy6rsuiKrad9YA1JlaJR9usVEpeufZAy8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJKBREWDDftZVsBX43HEfghwXAhCW+6jGvlPgcu4Qf4=;
 b=R2meSy0MN4U6SQort3a70IZLsy3V6VsdoXkjJXYI5573tLRhCh7r6vHMEz0+J1SSAY9kI9HZACGU+BcD3+vn+Zxw63l10254XtMYH4Sp0nJI4S36uLZcCK0cAhhxN6jDF0YGT207+n+a0OqDvLFF1sbQZd+meztHjnyL3buHx/4=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 BN0PR10MB4918.namprd10.prod.outlook.com (2603:10b6:408:12e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.12; Thu, 23 Oct 2025 08:25:35 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 08:25:35 +0000
Message-ID: <5341ac49-448c-4aa3-b322-c781cf8815c8@oracle.com>
Date: Thu, 23 Oct 2025 09:25:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next 03/15] libbpf: Add option to retrieve map from
 old->new ids from btf__dedup()
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, acme@kernel.org, ttreyer@meta.com,
        yonghong.song@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        david.faust@oracle.com, jose.marchesi@oracle.com, bpf@vger.kernel.org
References: <20251008173512.731801-1-alan.maguire@oracle.com>
 <20251008173512.731801-4-alan.maguire@oracle.com>
 <CAEf4BzZHS8w8On8W2Ez-r+pmdurw+w=4Yo2bA0fxeYhKhqE7bA@mail.gmail.com>
 <129305e3-adb9-450a-b777-5d42f231c1df@oracle.com>
 <CAEf4Bza_nnCzn-cOqP170XbqpM2=D5afhnM2Ow_BadmfM8UNXA@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4Bza_nnCzn-cOqP170XbqpM2=D5afhnM2Ow_BadmfM8UNXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0044.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::23) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|BN0PR10MB4918:EE_
X-MS-Office365-Filtering-Correlation-Id: 05bd6283-b11a-4412-e073-08de120dbd68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?biszcUtHNEVjbjM1bTZhV3ZQb2xIdnhWNW96N3hlS1lIaXJZUXJtZk1DOEdp?=
 =?utf-8?B?N2d1bWR2c1R6cEVzdVJwMGlKbkdVZGtYTThLVnBXZFozbHlQOE9tSW92R09X?=
 =?utf-8?B?TFdwWklENHlldzhFcnlRbW5yQ2R6Y0VoSlc5YjVmMzRsR2t2NG9xSUFvbnh4?=
 =?utf-8?B?TGlEYSt4b2lqRStDcTN1VzZYVm92N3B3MmZQQlhuQndSL3lBblhXUWx5cjBJ?=
 =?utf-8?B?YXNseGJUQVBKZEhuZkJpKzRUMXdyUHZob3Q4eTU4OEpQMGd1MlBTNXFsSUJj?=
 =?utf-8?B?ekYzajhGYUZxU0hJcTY3VHdxSW1LWUJCYXVUQzZtSldCeFNvMmRHL0Z4ejBK?=
 =?utf-8?B?eC84Tm9pMjY4WmV6aXZBT1BESEhaeEtGcm9QeEI2SDJKbk92eDhEenc3SEh5?=
 =?utf-8?B?bWs3YUJpSkVOeXZQV1RnMVovdk9LNjhNNFRuYXJJc3dRT2JMenQxUjJOYnBE?=
 =?utf-8?B?SGozUWEzS1BaaGpiOHNTR0NLZXZGOUtUUmZTcFJjM3VvQ0xwQ1JYaE95R3Ev?=
 =?utf-8?B?QkJDYjQxb3djalFPZC9YblFvRmFmZldMQlJ5Zk5adzVoWWVvMjZPNWZ4Q2tu?=
 =?utf-8?B?M2R2L3c5K0dEOSs3TmVYTytrT09XZURvTHpUbm1OR3dFRXBjcnFIb1ZEbGtB?=
 =?utf-8?B?UzlFWWxsMUZGcVViVldpTXM0YmgzZk16eXBjbDlzY2Z6T3cyQ1ZVZnMxSXll?=
 =?utf-8?B?VzA3amhOb2VFUVNaOGNydGhTbEVFOXNwWG1FaTBVN0dWdDJNUnBOMCsxTG96?=
 =?utf-8?B?MUN3dVB6MklheFN6ak9WbzczcVVxL1F4NElxTjNnVGt4QkRQVUZ1Tmwzc2dM?=
 =?utf-8?B?V2N0SnFIOUVtSkN5ZEFXS3BBdllNR1hKenhyYndMYUFpNGJOMWg1d1JpNnpm?=
 =?utf-8?B?Wm1ZOTMyZUQ0WTk4WG9ZV2N1aHlxclNkM3VqVnAvditEckxTVDZTSlB6TUtT?=
 =?utf-8?B?dENCU3BKTExhbGdrUlhaVUsvTDNVUjF6UzcyTWRrYkNVNzRyR2M1ekh6dVcy?=
 =?utf-8?B?ODFsSW5MS0JqZzFMZFU4dzVOY0dxajZ5ZkNmMm1ieWtycDFhNkpCSkFtbHNl?=
 =?utf-8?B?VDhJN1ZyTVFqaU9rSkJlSVRCUWphdW93a0EwTlF1ZWpPYzM1VWtZSjFSVFVq?=
 =?utf-8?B?TTVGbkFjNERBaVJvemI1V3pJZFdBODNhWmM1RDdNWTRzb0Y4Qi9DODgwWFFR?=
 =?utf-8?B?dHlmR3lhTDJNN3ovek9ncEFoN2R5ZTloeGZYWEQxeVc3UHo2ZnAxN3NJSzQ3?=
 =?utf-8?B?bURFNzhyL2RhNk1BRE52WDlKMTZpR01WN0RLczZFV2kySTBVelE0c0xPa3Jr?=
 =?utf-8?B?RXRZNnRsTS9EZExxVzBoZXQzRTZOMGdPbGwvOTMvNjdDYWpPazkwYnlPSnVR?=
 =?utf-8?B?ODRsSkY5WlhFTlhVbWxkUUE2cXU5L3hveDBFc1RhSjB1MkVZcG5sbGVua3VD?=
 =?utf-8?B?YzNiYzJMZ2pRa2ZSaWNhK0xzUHBEcFBWeXhSb2ZkbzNYN3BRYXd4aFU2MEtV?=
 =?utf-8?B?a3hVU0xVQkcxRWU0UDVRd3RkWnVnYWlTcWg4b1czdmVnVVRtYU5kbFZyYWov?=
 =?utf-8?B?Ui9hdVdrd0lSRGdvbUpTZjRGamN5V2xNRHdwSk96TG8wNk40ZDFRRUVQWjh1?=
 =?utf-8?B?L2dEYkoxNW9WNlNIczZyQXdOb2l6QzNocUFSendrZlIyMGZaMEYvQVZYTnpw?=
 =?utf-8?B?VGFlSmd4eVN5K3FaZS8yb2t3YkptMG1XbVhQNUR4NUg4Q3VDSlZ3QnZ2SC9z?=
 =?utf-8?B?T1ZhY09sWUw2Q2QwV3pkTTJJOTFscUpMZ1AvU3V2ODIvYlBwNVp0VnAxTTN3?=
 =?utf-8?B?UVg2T1NncnFXZEFEWU12K0RLZXRwK2o5UjVXZ082K1hrY0hBTkxhZUVKNEI5?=
 =?utf-8?B?YkZ3N2RrTzk2cDFkNjVmSnAyckZjSHJuUmpteGZ5akJXenl4OEtwMUphSEdx?=
 =?utf-8?Q?YYAyHbaNGmjVaEmgZ0ppQGNjFToghmB1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2wrVzdFS1lnenlxL3VwR0hxN3VqNE0rL3VXTmhwT1AwL2ZiaWxuczFqWVBF?=
 =?utf-8?B?ODdKSnBra21wNEQvQ3doR2lRMzhsU1RGNklWck9zL1Z1UXFUdXlEQ0JjVmdG?=
 =?utf-8?B?Z0VvNHdwUSswbWF4emRGU0J6Q0x1TFhranRXcFA5cFhnSTNDbDdkWGpXRldv?=
 =?utf-8?B?RHlCTGFYVi9LMlZybncyT1FLY0xnZTg5OCtSbEhwN2ltUUxYczB6d3dvUmZH?=
 =?utf-8?B?VmdtV2NLV3RUZnBxYTdUOVBHdnlJQ3dvaHdBYlJ3V2dodWhlM1lyKzRMTzEr?=
 =?utf-8?B?RnZRTE1hQjNFbEJGcUhFRnh1a2JFVjM4VWxIQlV3c1M2WHhacVdjbEF3S2ph?=
 =?utf-8?B?VVpXZjVKVTM5WE1nK2FrYmpWc25sMTlaUjEvazlRZlcyZlZpODc0bTBLelhv?=
 =?utf-8?B?Y1pEZVhNbnFkSGZDWWhRT1RSQi9xTDFxT2ltYmJuaUF4cEJtblJ3Mk5jNkhu?=
 =?utf-8?B?Y3RQZmUyakg4b1VpNmR0VTBYRnYvd2IvZUxVbHl4SDBBMVptR05YbXhnRWho?=
 =?utf-8?B?bWNzTHFoaW5TSm1xU0hEdEJIekJnRjBURDA3SVB0T0NvM1pQbjVKSEhpalZl?=
 =?utf-8?B?dHpmbzNJd2Q3eGpmUFNuYVF5aWZVaWRFVUFLTngwbzJCOVdGQzFKemRMOEdo?=
 =?utf-8?B?cDAyTXB0UFliWlE5Y0NKUHVobElDZ0p2clJlbHV6S1lyRW1rVEc0SUlNbTRi?=
 =?utf-8?B?KzlBZ2FIMGFzWkxGOVY2NTRRelkyeFlEZlhLMHFKSFl6SXc2WlVXeFRTQ1p1?=
 =?utf-8?B?RlVPTEdxK1hyMGtOQTJodHBhclprRTZWZ2pET3R2QmI4MFZsQjJPK1hESjA5?=
 =?utf-8?B?c3ZEd2kyRTZqT2RKZ0hKYjc0ZVNKSFB0d1E1cG42MDd2VVJmaTQzTmlTNXpW?=
 =?utf-8?B?dFk2VFRLajNrWjFHdGg2Nm04K1FGZ3FwV1QwMzJJMEZyVFNFd0RYbTBQczJi?=
 =?utf-8?B?VUI2ajJSR2pqUm1nby9BMzRoQjk1N01xUHNwaXhQRU5aSXlrRlkvL1d0NnlW?=
 =?utf-8?B?WVQxMFdscWRMVHk4YjBMV2x6UkVQLzE5em5RdHBKb3JyamVCN1Jxc0pGRjhx?=
 =?utf-8?B?T2xJNURkM1hkZXBYSXNiYU50MWJ2bDZ6K0laMGluRjlrM21TSmJYS1MyUy9u?=
 =?utf-8?B?RVhZSW1uenpjSytmR0F2c3VqV3k2SHB5WEd6L1hOOHNSVVdkTDNBTElLcDNP?=
 =?utf-8?B?c0YzQ2U2R2k2ZURuRDhMbXhHUEo3bCsxaEJZYWZzYlVrbGhWOVdCa0tvR2h2?=
 =?utf-8?B?bFdXN2Q3UWlwMDB0Z0tsU0Z3bGpsVXJ2RjRSbXZvNlFBb3JEMHk2ZW5qZm9i?=
 =?utf-8?B?N1pOcE5BMkVsWTJjYWowd3VnQnRTbk5qdjY1eXFvaXZNMXRPTVB6dVY3elFV?=
 =?utf-8?B?dmxsNVg1MkpTTTNURHFDaHl4ZkpYcVBZTThMSE5tdHFhL3BQa0pXL0Y3Y1cy?=
 =?utf-8?B?dlM0bWJKUm5Nd3hORzVvWldBN2VMNStNOXV4YVNxTzBJQkFwZkVIczJiT01p?=
 =?utf-8?B?cjBjVTZDMHJ2QzhNVTNQdDdQb1lxaFExZWhFOHFsVU9zQlhDbHBpUmJjQ3RM?=
 =?utf-8?B?dmcrc0doeWFtS1NvSTR3Y3RscnVUTU5SdnhFaHNSdnl5VXRLVDNZRHlhSXdj?=
 =?utf-8?B?T3BlNDJnWkNqdkhjTExyWTlQSVYyNFMxTUJKUEQvVG1LakJaLzR5T2RONXlr?=
 =?utf-8?B?UzNzWkNCTmpNRHBwbzRzZ3JGY3NGenNURjBkV1NZUngxajl6cDlkT0NPS05o?=
 =?utf-8?B?ZGtDbWRISm1aNUU2OGVSeEt5aTdMVlpSNGloZFpLSUVvVlFtWlFxa0FZNGNN?=
 =?utf-8?B?dXk3b3JyMDVFWUowa2J4Q2RrOXMvdkJqbDc2V1B6ZnBJeXVRTGtDVGU5WjZE?=
 =?utf-8?B?ZlBSVzZ6OFIzblpCN2JYVU1aVFFRNnBDWEJmV2psOGllRGloaGhtSTgzVWkx?=
 =?utf-8?B?T1ZaUFdoc1NJUFZoK3owdkpUZEQ5ZGVmL2I3dmVpcS9WQXVBd1Myci9iWXJw?=
 =?utf-8?B?aHd1dnNIcjBMTXpBSHR3YlZNNzhDQyswZ25BeWQ3VnBJZWl6djNkY3FTemRY?=
 =?utf-8?B?cUMyUFRvY0NVR2NNQnR0OXBNWXdYcUxOU1ZDd3lhdlJMd1J4TlpyRE43YWhV?=
 =?utf-8?B?SjBuaVM2RG5OUVladi9Mc0dFVXI2VEFiano4eFo3Nmw1TXhrNG5ObzVmSkJQ?=
 =?utf-8?B?Qnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tI1ygG7cM6UZy2I+v72qBKrgeD+0KIKkuAbXIk7Fqe6pCkAQeS3svq0yLNISqddH31x7p8BB73jbtw5uBzMW2Snkayrjrif4ajwzqFf4fYX4rJCxnvdpVCc5t/Z2VKV5v6wEwoiUG7pH4uhbst6sE5sfeBoy2h0rHiv4m9cE3/bMx1YChwqcKPqtIR7G1nxHdLfmmHgR4FlKXLEtU6ETdzKXo6i5wLU7HpzFCMzWYppWj3nmPnQD8gepRpxJ6p4F5Np5wDCLwI/QYQ26FU9KWjWBMNdSDNZ0iwnsO4tPbylXFoto3KY4oZVk4YMYQRj4ILv0Gz2E0Y9dEffhvmK8f8pLTNO37tD4rfvcrm5ZewwTXX4vVDuGEQacJECWrnjoUVi18ces3HAc82OJy+/zZBAPsj72ELUFAePOEYQFFE3kL2aWLC/z5OjyEhlFL3dNjaf1ZBImpXK4pq53HKAeJrsqE89qL+ClJxxbJ2YbVMg7jYF4bCps6QzyCbEt6Vc9q0uUUdby5f2Zlb+ks2s9FpTRfmGJIxwDwmDajXaWIC9aAHdwYi9y8fgzj93Uh9YBiU3HOpusfGVKMg+RN3xCOipYYWd4XrmrFMcSF/ZuIqY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05bd6283-b11a-4412-e073-08de120dbd68
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 08:25:35.7730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 13A8Un7urh8jQiSO1xqAATvIF2fkneS3ipvS6q0EttfzP3JRkKifdFd6rMHhxMaVf9QwPOQxMkFK74weI+NRGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4918
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510230074
X-Proofpoint-GUID: 47noRl_tfF-zXvfCX1fj2LEi8HUS7IsT
X-Proofpoint-ORIG-GUID: 47noRl_tfF-zXvfCX1fj2LEi8HUS7IsT
X-Authority-Analysis: v=2.4 cv=WaEBqkhX c=1 sm=1 tr=0 ts=68f9e684 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=YRZC6GErYjglifw3LiEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12092
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE5MDEwNSBTYWx0ZWRfX24X1twgM5pV8
 UZWmioLezNVu5O5SEg5kcG2atOF04NnK+7m7ZnbC5jtgG4p2Uvy+JUlECeMOBc+/gej67bWDvph
 nnRh3TKHPR/n2EHWS50ch9AgO9scXxBH2wdayE3EtALcA8F7OzAqvcixKFlIf1JY19tsZpdRUhm
 BhXFW1srKs1y2d3Ztjo2SB42rHML8Rb2vKE/U+XR72rsgi/2LrjpxlxVJVhIqFmk2g3To5ZFung
 MP+fuWOvzC+xPokzIiEe644U7pSInjLer4RxWq98lMxOs6Jv4pr+uBcA7dxPMBmc/7TrP/WaU0J
 t50mhY7M3W3e+VYi1jZWLEf9sbDCDayfRQE9z2CyW7i6sOGatI1sX5GlM22Jy44X/Z1E7zp1uL6
 Ld/BmGVPzaqSkwZf8m8WZKJLO4NNKmY5LEXDyKOSvMFL3x1oLS4=

On 20/10/2025 22:03, Andrii Nakryiko wrote:
> On Fri, Oct 17, 2025 at 1:57 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> On 16/10/2025 19:39, Andrii Nakryiko wrote:
>>> On Wed, Oct 8, 2025 at 10:35 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>>
>>>> When creating split BTF for the .BTF.extra section to record location
>>>> information, we need to add function prototypes that refer to base BTF
>>>> (vmlinux) types.  However since .BTF.extra is split BTF we have a
>>>> problem; since collecting those type ids for the parameters, the base
>>>> vmlinux BTF has been deduplicated so the type ids are stale.  As a
>>>> result it is valuable to be able to access the map from old->new type
>>>> ids that is constructed as part of deduplication.  This allows us to
>>>> update the out-of-date type ids in the FUNC_PROTOs.
>>>>
>>>> In order to pass the map back, we need to fill out all of the hypot
>>>> map mappings; as an optimization normal dedup only computes type id
>>>> mappings needed in existing BTF type id references.
>>>
>>> I probably should look at pahole patches to find out myself, but I'm
>>> going to be lazy here. ;) Wouldn't you want to generate .BTF.extra
>>> after base BTF was generated and deduped? Or is it too inconvenient?
>>> Can you please elaborate a bit with more info?
>>>
>>
>> Yep, the BTF.extra is indeed generated after base BTF+dedup, but the
>> problem is we need to cache info about inline sites as we process DWARF
>> CUs and collect inline info. Specifically at that time we need to cache
>> info about function prototypes associated with inlines, and this is done
>> - like it is done for real functions - via btf_encoder__save_func(). It
>> saves a representation of the function prototype using BTF ids of
>> function parameters, and these are pre-dedup BTF ids.
>>
>> And it's those BTF ids that are the problem. When we dedup with
>> FUNC_PROTOs in the same BTF, all the id references get fixed up, but
>> because we now have stale type id references in FUNC_PROTOs in the split
>> BTF.extra (that were not fixed up by dedup) since we didn't dedup this
>> split BTF yet, we are stuck.
>>
>> There are other alternatives here I suppose, but they seemed equally
>> bad/worse.
>>
>> One is to rescan all the CUs for later inline site representation once
>> vmlinux/module dedup is done. That would make pahole much slower as CU
>> processing is the most time-consuming aspect of its operation. It seemed
>> better to collect inline info at the same time we collect everything else.
>>
>> Another is to put the FUNC_PROTOs (that are only needed for inline
>> sites) into the vmlinux/module BTF. That would work, but even that would
>> exhibit the same problem as even those FUNC_PROTO type id references
>> would also get remapped by vmlinux/module dedup.
>>
>> So it's not an ideal solution, but I couldn't figure out an easier one
>> I'm afraid.
> 
> Ok, this makes sense at the conceptual level. This might be useful
> overall. But I don't like the implementation, sorry.
> 
> The size of mapping "table" is fixed, it's btf__type_cnt(). So just
> make caller allocate u32 array of that size, and pass it in. Libbpf
> will then maintain/populate provided array with original type ID ->
> deduped type ID with an absolutely minimal amount of overhead and
> extra code.
> 
> so just
> 
> __u32 dedup_map;
> size_t dedup_map_cnt;
> 
> inside btf_dedup_opts ? (and we request user to specify count just to
> avoid surprises, we do know the size, but user should know it as well)

sounds good, will adjust in next version. Thanks!


