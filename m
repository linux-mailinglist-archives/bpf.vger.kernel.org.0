Return-Path: <bpf+bounces-66813-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E29B39A7D
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 12:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DE861883559
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 10:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9277330BB86;
	Thu, 28 Aug 2025 10:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="f9kk101j";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="m67kFxEl"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF302C21CF;
	Thu, 28 Aug 2025 10:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756377813; cv=fail; b=jAk5rEzZF6ZY4cy+cHwDGObt8/GRaxOtS1JlB4EcIr9BhU+Ht0ZA/tRNED2ekj/1tNLM4OZjpjUF+qrAFia0hWxBpxkCXI/2lYOcOoIXC0hnmcRbhMcl36JxX7oEOoGMhFW6eNBYRimJtqMg/MLcDV50aXwMEUw5Jwc5FGgCi+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756377813; c=relaxed/simple;
	bh=qsEBgtkG8gmy8dBgR/zG/wV6HeHep7ZDQlvWqlJa3Ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U0E9ew3NTVqN9zopzDoGbtxfialRzdtdyXQ+W4iJpWcF54OH3McrcdBbUXDpH8Zm6MBhA63prKwlayJaZvHiL0MwY9Q0JejVaOaVXEQpfssF+hdaqqHRGfTQraLf/Lii3CSvBqbP6GY6q1oUURsDxaXo/Zm1GwRW75WXd9FLKQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=f9kk101j; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=m67kFxEl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57S8uJKO008061;
	Thu, 28 Aug 2025 10:42:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=W8gAdf3Wh+wVFdslAB7oZkMQDkMYqk2SykSGDA7SnAc=; b=
	f9kk101jx3jxygeG8WOnDlH6LMa5j4NqJY9o69P0d1B94tHIJRKHzhRr/UIirca1
	g7wQ6D2TPS6vHu5D78fcu14CkHi2PHDOk/DW8PZY39kHAcrq9qOx2SzHc/W7A2pD
	XLa85/UgCmFTQuApZ4QTi+UJGGOqPp2+xQy8pO18ZlQi+l2AIsR6kOEwkEF4lTHW
	rY5GQmBEPg2XFlGMopHYcsbvKvuQO5Pn0R2h1xKz8ZVri+RrxX8ew3pk0jqPrIDb
	AJaBEILQYZswwBWaM0BSUAqxc90kjq8pe24M8mnvAlFLx8F2dVB5jubUEeQ9K6dN
	ZGoXS0O3aMciJf3Oj8eYBQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q42t833q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 10:42:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57SAAi0J027318;
	Thu, 28 Aug 2025 10:42:41 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q43bktmx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 10:42:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WNh5rzl5oY4X5xCh5TCcz/+fmiyY4iibXcbhulkEUBWeZ6RGqrdN0Ke3rvcJ5Lyme7D0C+CzCHGWUXpGCzt1Hu0GIpdSvwvxv60BVihDb0khWhywRyhP8oBMXQ5i3XgoWKxM9yC3DR/n0gMgyntvjZlpk+yNC9Bfaxbs2VKrlooI9zGviL2Uu7BkDf59yqWfimi5k0ecHnHmdS2g1VXuzW4KgWRL2zy70RaSjesewC+esdmTSJZHMEr5HZfooQUD0RKBg++ysioK4Y+tlDsNTuiQbVO2OVlv6CQ9szTLR/C1y6c/vd+5AjnqQijxoxYnjUOYLR5dnTxj6OXDgyOT9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8gAdf3Wh+wVFdslAB7oZkMQDkMYqk2SykSGDA7SnAc=;
 b=WJoDaF3DX+kaAIhvztkF+YguVLRGEXOHu/6LJrCyVprt3C9W+I1i9WWCAT/rPBf7/1XUKP4V4KlV+C6hVDv0/mRDYyhwUTabEHufh5MwzoNeawfEDMFajGeMdoloSyBbIvNTZUYoVR2FuvI6AcuG1rF4ng+i7N80qHF8iwPqQqjxqHmB5Rs9ZCKCQo7Pvr+cyufwJ2rqjoNl4nCU0IDBVZNDDwu5sH11UMC9xAlkwVbxjZjBm7oAVPu2+VpDyL6Kv0Mylw9Y7mpfeYb8nZQOofPnjz/7nFk3UkYIcOcjkPqqCP9+b/WHr5b6Gg7OVUNYwuE4QrFXiKkVyVYFP7Cx/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8gAdf3Wh+wVFdslAB7oZkMQDkMYqk2SykSGDA7SnAc=;
 b=m67kFxEltaGyxTYW5JGBLgS0nSdvSm2uw/Z4qmhY751gGX85HC/2dnC+1K99BISwc3Lzsz0wFFswrUbPTsIQf9vQ7B3LEkWsPcSWFbkcjgO8QxjE8sdLhD4L26nl0e20UrxdzcHZzdjMQii67Xqvt88qmTD15lKjqtTNUEM2ATU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MN2PR10MB4269.namprd10.prod.outlook.com (2603:10b6:208:1d1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.19; Thu, 28 Aug
 2025 10:42:34 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 10:42:34 +0000
Date: Thu, 28 Aug 2025 11:42:30 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com,
        baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        hannes@cmpxchg.org, usamaarif642@gmail.com,
        gutierrez.asier@huawei-partners.com, willy@infradead.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        ameryhung@gmail.com, rientjes@google.com, corbet@lwn.net,
        bpf@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH v6 mm-new 02/10] mm: thp: add a new kfunc
 bpf_mm_get_mem_cgroup()
Message-ID: <e3566528-5441-4467-8a3b-4aa52c031984@lucifer.local>
References: <20250826071948.2618-1-laoar.shao@gmail.com>
 <20250826071948.2618-3-laoar.shao@gmail.com>
 <299e12dc-259b-45c2-8662-2f3863479939@lucifer.local>
 <CALOAHbAwTZQViuZQZpor9iMHr8w8AvptQTb5TEHrekN6FSjLxw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbAwTZQViuZQZpor9iMHr8w8AvptQTb5TEHrekN6FSjLxw@mail.gmail.com>
X-ClientProxiedBy: GVZP280CA0053.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:271::9) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MN2PR10MB4269:EE_
X-MS-Office365-Filtering-Correlation-Id: 81f03748-dcdd-45b4-2a34-08dde61f990d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U0NqRlVYaXVOZUxyaGdyWGR6NStock1PYWhJYUZ2d0FJVEF3V3FlYlJLaWJq?=
 =?utf-8?B?L2JJRGNZMnM4NUtOQ1BDWTRCV3puYmkyNEdZMEROTFBLZ1FuMUo2KzhKOGRP?=
 =?utf-8?B?US9EcDdiNE9LZzFwRkFiZWtheTQraXZKMUg4MEZKQ2NCcC9lT0hveDlRazRR?=
 =?utf-8?B?NDJ1OFZxUmk4cEhhQzRqK1pNWGcvTElvRGtnMHlyNXVVMU92Uk1HM1J5SitF?=
 =?utf-8?B?WGYwV3VWZkJQZVpuQlQ5dmFJYkQ4bWJCLy9ISUZBaDd6bDZLWU1QcDRpK0VK?=
 =?utf-8?B?Q2YxWmIzaldFRXVZN256WUVnNVB1U2lIczRWSVpOSFFENWdkUkxKeUdJL1FZ?=
 =?utf-8?B?Q05kTVRGWE0rNkppUkNnampxRnhsWU90OWxtSmc4d1MvU2NjUjFsZENDM05O?=
 =?utf-8?B?L2tMS3hvUGFocksvemdCM1U0RXd0US95TnVOT1BzQ2lYaGw2R241Mlk4T2Ny?=
 =?utf-8?B?aTBJQ0k0NnlLQllNSk1GRytsNEVsMFprUWJQWHBKU1g3c2VTMjdXT3l6TVRs?=
 =?utf-8?B?UzhCN0IxcnJ6ajlMY1ZBM1hwTlYzdjB4cThWNnNLc1AxaE5XR0tRQ1ZHWUFU?=
 =?utf-8?B?b2tPVDFMRVJQTmJjKzZSejk3TEI2bGdwN2JGRDc4Q1lzNS9OZ2VhbUhSUGMr?=
 =?utf-8?B?RnFoTTE5enUrK2dCTURoUFdaUkxURzhTaC8rRWJFdjlRQThTQTIzbmc2V2NP?=
 =?utf-8?B?OXRTQURXbDJDcDNYVDRiOTJ3UjdUcnRVQWYvY084QVZtakRaNUNYMCtHd1RY?=
 =?utf-8?B?d0Q2c3gyY3dJRHAwY2NuNFcwRC9KZTlBZHlxN2k0UFpiMDJjbEJMMXUvUDgr?=
 =?utf-8?B?V2Z3bC8xdXRKb1lRWnFUOHdEMlUvL09zdjVtQlpMZHlKNWNvL2NEZDYrdUp4?=
 =?utf-8?B?aDdVMk1sUUZSenFQSlluTzJCMEplZXFpTE9QTXRUcWNMSTVoaGVXMmNEbjdV?=
 =?utf-8?B?V1RjSDFaQktuWHFRU0VBeFNmWWZabFdjSXpqQndWVHRDMVk1czNWbStPSUhU?=
 =?utf-8?B?emoyVVJiRDBCL2w4c3hVblNDNEVyYlBZTTREWjFqalNtdHdpVlZpanJhbkl6?=
 =?utf-8?B?enFNTEJHYTMremhrQkpJejRGZVBSNW8xdjg3NFQvQ1AvbGhXZDZQbUx1eVpM?=
 =?utf-8?B?RE1ta2cyZHhUYzJHVExBMndXMDFMRExISndFUXZNT3BQWXBUM05PNjg2b3Rp?=
 =?utf-8?B?ZVVNaFZ2Z3VrRmVuTSswSUhZUkxnNTk5SkNOVHNzMjFoQ29PSnhOQ3BFdzAr?=
 =?utf-8?B?Ui9KcnBnbkd6MGVjTnQ3L25UQXpmZHpTQWFNc0Y1TlZjQXJYdzlKVlJ5dHF2?=
 =?utf-8?B?Y1FldUdoNHZ1aWJZRVgvdS84Y0xVS1NENVJXOFBRaEpqelVJZGFJbmZKWElO?=
 =?utf-8?B?RVJpdStPR09mWE5BYjE4b1lhZVdZRnBnSmVxSHY2S0Exck0yT1dXLysvbm4r?=
 =?utf-8?B?V0haaGR0clRTdWVlSXpoR3FObEdGY3hNTDFGVXNMWmdYK0xqUlN6U3dnYzZk?=
 =?utf-8?B?OCtNWEZqM1hVcC9hei8yeUljL09tTmkxOGw0R0RXdXJFMzl4bjUzTWRueTFM?=
 =?utf-8?B?aVdxN3cxTHhPcFJsVkk5ZG5MSWl2UHh6MU9HNy85UXRyemtyR29SWFNNRkph?=
 =?utf-8?B?ZGFjeVhEQnNoOFByQWMyTFhBU1pYQ252b2JjeGtWQ3FrNWF1eDltN055Rndq?=
 =?utf-8?B?RWRtOVBBRE1EVkJEMHlnSkNKMU1nNWJrc3BSRnBwclB6YjU0Ti8ydUd4N0pj?=
 =?utf-8?B?RjFlWUNsSkRLeDdJMFZxbVVpaGVFZHlQRGNoNWU0NDl6VXlKaFZkMjJXb3R0?=
 =?utf-8?B?M3Y2ZzdBZGRBcHk2SXI0cTgvdUMwNjRhdDljVWxIRk1zRkVPKzRXTVFDcy8w?=
 =?utf-8?B?MEtoV0t1V0dHdWVKZ3UrRnNFUzQvc1NteEpUNC95SW5hTEx0QTZuZzdabGpN?=
 =?utf-8?Q?X24Ul/GM5Do=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGx2MnQ4WXlrOVA4MmdrWW1HZjhNbm1NbWFlWWUxbFpyNFJnVkxJYjN5VzYw?=
 =?utf-8?B?aFpZYnZ2aW12eE1NSFhtYmxXZTBQMkd6dTAzaEo2MFNzcE1PR2t4c3llR1p3?=
 =?utf-8?B?YUl3Z1ZVNUpiaW43ckpoTlRtbnQycFJGdEtqNzZNTEFUcVRCTmF2RmJzdm01?=
 =?utf-8?B?MWhyQTdjNC9GM2liUXBlQitWMWVKcjFrNGcrYWRVMmRnNGthRnBRNDA0L0Fq?=
 =?utf-8?B?OU1GczhoL1IzcTBhK0Y0UGNWQXViclYyZm1iZ1dnY1Fyekd1RkR2akJYRlFG?=
 =?utf-8?B?VVQ2WEs1LzlGMFNGR0NUWDlyQ3RqZTZCbFk4NXZ0MU9zL2k3d2k2QmNQR0NG?=
 =?utf-8?B?RkIvcDlaQVBYTG5xazVxMjczUE5QTXM0L1RXVEovUk9hNyt2cGdkYkkwTU5a?=
 =?utf-8?B?QmZQbFdJRTYxYXlrSGlvaFdkZ0FXQktyU2lFcFlQTDhyaDBFM21CMXNzZ2VU?=
 =?utf-8?B?dEJvOWFLQ1pRVGd5OW9oZ0M2ZjFtTkhkajd1UWVGdEhzVExMVmNEaUd0UUVr?=
 =?utf-8?B?ZlJzTjV3dkNBUkE4eU4zM29LYUV0bisyV2FQSTUyNmNMVElIcTdQRTlCOG0v?=
 =?utf-8?B?dHBxbTEzMEp3TXZtN2dCaEx6dDVWcHE2QjQrcHBUS0p4RkdEcUQ1c1o1UHYw?=
 =?utf-8?B?d21iMzVWVVUxOHQ4LzNWOG1lM1RJV0N1NDcrMlkyMDE5VVJnNVJYeUNRellG?=
 =?utf-8?B?Si9xRkVHRXBReTNhVFBmMmJJUGhyV2U5T3Jpb2R4ZkdHSmQ1UkxIcUZOZ01m?=
 =?utf-8?B?R0tCOTJhdkFCZ0wvM2VXaDhXSXFqVXFVVUZuSG9ZZ3lvNXMvek12OHBub1Fp?=
 =?utf-8?B?MEZwV0EraGZiVkFlbmFiS1h6MThINDAyeWI1RS8yNUlvcU5BU3JERjN1dkdZ?=
 =?utf-8?B?Zi9oS3d4eXF5RTloWFhlNlBRVG04MlhBWlo4NFEyMStqR3BEd003QW5JMWQ2?=
 =?utf-8?B?VU9iL2U1bjg3clpyZ1dSYkg5U2xXc1hDVWJDb05Ka05FNXdBaTdmWXhGZGhZ?=
 =?utf-8?B?Yy9Vb1dqeVhTYjBqOUJLRjV1SnFMOUw3bWRTQUZBdHpKb0NUKzBXaTdQaXF6?=
 =?utf-8?B?eTlBck9nRWFSYllXZGN4MVpJMUdKU1hJdkl4UkV0RHFCelhDcWhCQ2tiektS?=
 =?utf-8?B?dTRRSWlmRk5BRytScFk4WFNOekRxbE5xcmhSMU9YLzczb3NlUGxqd1NvaDlB?=
 =?utf-8?B?YXJUYXE0Uzd1a2N2aVBuNDkxTTh5aHFFaTZlZ0ZZYVZzaW9JdUZZUFRqcktD?=
 =?utf-8?B?MWFlVGxCUXJRZ2R1L3FWckpsQnRHQlYraW5ZK2pNOUNtcFc5SFVPYkp3cUla?=
 =?utf-8?B?ZlRzeFpnMmh6dEllb01CeGdZQzdlUDRQTGdmcGxkNmY4aEV0YWJzcVE2VnlX?=
 =?utf-8?B?MkVjMmdtTVZDR0ZZT3RpK1M3L0xQaS8xY3FBcmJXaG8zVWhZVHRqZGF4d0lP?=
 =?utf-8?B?aURBS0ZGT1RsclNEYXlNRXRBeUlZOGRQMHRDMk45ZXh6SmtxdFNSU1lZQXIz?=
 =?utf-8?B?TTlPV0d4cGFJNW84YWVidG5PVDNDVWQzeDIxTzYvWnNJTVhmWCt3ekdjalBQ?=
 =?utf-8?B?aHZON0VrVFBpMVE5Ukxwak5RdmNiaGFUS1MvNmhJdUJ3WUM4NjhjaERyZ3N0?=
 =?utf-8?B?UDBERFZ3aTVpUzJ6WDJwR2tiRTdTK1JsQ0JKMnBMUUZJMERscDUyREJBVGJw?=
 =?utf-8?B?d2l6QzIrRHMxTzQzNWhJYmVtc1BKTjNXLytyUFRhWURTS29NRVV6c05rRjJP?=
 =?utf-8?B?QjZEenBWUHR1WjBBZHE2Mk1FeFBWSzZzbWFMVWk1a29uakFUcGxwMXhBcHA2?=
 =?utf-8?B?K3RpMzhBaUsvbVV1cVpxOTY0TFlnY3E0cHV4UWZyekI3Q2VhdEIvNzE0Y1ZN?=
 =?utf-8?B?ckF0Y1kyTkhDeXhWNEtQRkZheXFFNGlKUmZyVHVnd2NxY2JWZEJuTWFEa1FO?=
 =?utf-8?B?eVNEK2JtQXF1VUg0V29nRWlmb0ZqZ0xRb3R5ZDFrVnBNTVhEZGh0bWNPM0l1?=
 =?utf-8?B?cnhjYkJxcVlCUmlIc1hTRzlReDVOTjBBMC95STMvaU05YjNsaE1BMU9xWHpt?=
 =?utf-8?B?SGxLeUlMSVUzZzg2bmliM20rdXVaU21iQ0g5bzBPSnU0d09TdTE5eVpqS0Vz?=
 =?utf-8?B?Y1dodjROV1ArdDFMTjlzUzNuN3g5cFBjZ29sb2JFTUZhQndnTjB4T1NRQkF2?=
 =?utf-8?B?Wmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3er+aE28ozciRMmtQLbWFhqCEkSI3iIXt3386iNXGFO2bxlcmZMCzIJgjLRGD5jd27Eh0kiXx5JL5tTCBxGLN5ZsFWabEpZOmmC5dosDeJ5DpLXE4LNE/YQitJjMoICRVLVgOWcpAu1Ynod/XVVOcqUrN7PaqY7kRPX1N5GUzCunho+z7UXrVpW+rx/XBlE1e5chFbf/mkunHLswKamB9nFYLR3BxO+B6yUN3pr4iGXwTWtXhelHF00cdPM5vt5UPeED9BLTbxhk3V/2O3e0ElI86mtqMy16PxNPsyDwp4wqmXH2iggXtC5e7kaGysowwB9irEaIGIZi2J9LrORMGdxZfk/JeShYkQfy2vPSP8T8Lg8VIcdBZRYmb563JGkmNHGXYKaPLTr7kYMZkD9WHU1TLL8NU9uY7yFgLX/7fPuTGTItMDqJBEZdxy5I2Fp/C3p89adlK/OIiRBntOjVCmdfkUnTj9EZE1rylMUpRm4wDbyS0QBGWqFkGCazT670IIMYy+a2WXDKX09TkJ5HEDukDnVnLSmIV9SAmnpB+r6rfRQnhxAJjMa7UhY2hcQ5P9Eh9d5XwSUaiNAKaWRwLK4CexsyI1z4RO4qmaFgUOY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f03748-dcdd-45b4-2a34-08dde61f990d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 10:42:34.3240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AtCvvXUyVqXvj/S8OSiRYNjpb77C3jRVLVkQxZw3wqNUeVK7MbphbMvfpBiEQEJdtrZdUHEj79KS/3rSLO2MNgxPXdsmnbPKx1r/XlKzwq0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4269
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 adultscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508280089
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxMyBTYWx0ZWRfX6++oC3WER722
 VO4HLGf+gToRAUn1Qyf8DMdpbDRmFotcdANwnAFtMG6KsW6h52XqF4i94tgGyRRBKyOntg37yWY
 sqhJfEECTZZbs4AXrAJ9SB8grux/WDDgnm6x+z2k0oau4tjRfsAlzmBophy0zQsVqbunh40fugM
 pnmxFyCNZ2H5qhpJtMNxUKMRzkQFl/Zu1WjAGc8HNEy+QbQzjs5AKbO+qACpgW7KYnxOi0RhKi+
 q2E4PXhFNHaApjhgkb5F1xFP9avJw0wPDDLS/SWWAXkT8bwwQtTgRw6nb033Dk5zdww6Y3yYzcL
 JHEtmA7YJ0sdADY6uruQh/WFi1oaYknCl4jwXaSnRdixI8EcY7F3I06+iV8Nlhq2PAKjWWlUCD1
 oqKlZYO1
X-Proofpoint-ORIG-GUID: Zayh2pTIkN5VGOSKYbe7nKEgglw6hett
X-Authority-Analysis: v=2.4 cv=RqfFLDmK c=1 sm=1 tr=0 ts=68b032a2 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8
 a=HyJSQkIb8svAWcuHeOEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Zayh2pTIkN5VGOSKYbe7nKEgglw6hett

On Thu, Aug 28, 2025 at 02:57:03PM +0800, Yafang Shao wrote:
> On Wed, Aug 27, 2025 at 11:34 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > +cc cgroup people, please do include them on this stuff.
>
> sure.

Be good to cc on future respins for the whole series also! :) just so everybody
is in the loop, thanks!

>
> >
> > BTW I see there is a BPF [STORAGE & CGROUPS] section in MAINTAINERS and
> > kernel/bpf/cgroup.c etc. anything useful there for us?
>
> BPF local storage can assist in implementing this feature. However, we
> still need to introduce a new helper, bpf_mm_get_mem_cgroup(), to
> retrieve the mem_cgroup from an mm_struct.
>
> >
> > On Tue, Aug 26, 2025 at 03:19:40PM +0800, Yafang Shao wrote:
> > > We will utilize this new kfunc bpf_mm_get_mem_cgroup() to retrieve the
> > > associated mem_cgroup from the given @mm. The obtained mem_cgroup must
> > > be released by calling bpf_put_mem_cgroup() as a paired operation.
> >
> > What locking guarantees do we have that this is all fine?
>
> As explained by Shakeel,  no locking is needed for this stuff.

Thanks, I responded there.

>
> >
> > >
> > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > ---
> > >  mm/bpf_thp.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++-
> >
> > Also not to be nitty (but I'm going to be anyway :P) but I'm not in love with
> > the filename here.
> >
> > So now we have
> >
> > - khugepaged.c
> > - huge_memory.c
> > - bpf_thp.c
> >
> > Let's maybe call it huge_memory_bpf.c for consistency?
>
> makes sense.
>
> > And obv as mentioned
> > before, add it to the MAINTAINERS in the THP section plz.
>
> will do it.

Thank you on both! :)

>
>
> --
> Regards
> Yafang

Cheers, Lorenzo

