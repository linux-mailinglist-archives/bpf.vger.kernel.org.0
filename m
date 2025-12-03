Return-Path: <bpf+bounces-75939-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 80EFEC9DC06
	for <lists+bpf@lfdr.de>; Wed, 03 Dec 2025 05:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 14AAA4E1035
	for <lists+bpf@lfdr.de>; Wed,  3 Dec 2025 04:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A525255F2D;
	Wed,  3 Dec 2025 04:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="yUIFuovt";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="kANr2B0r"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823BD27732;
	Wed,  3 Dec 2025 04:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764736526; cv=fail; b=KkuP8ZtWqb+NabI3ZwlbN/hivhFp/dzsa1/C6iNrrN02BIl3gTDQVYbWY4aWNMVLKWyzDgbq3kTKSjUuFnoTQ4KHWSZtSWLB6siBLmYlB3Rq1Gi3GWnf0g67XPZJZqTNUoHZ9ka7QiPNcVIHEv/mpPW/u/qNnFjV+P6XVNv0RDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764736526; c=relaxed/simple;
	bh=Tfv1qmFxt+29QQLkVwX1rhzpWeDHeUp+rRqWORwBNJU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MaKpNubqzyill3hRMqXCepY6wbEjF1rQ5QJ+qDTreIZe0jvOOIKEkO/422IC2WvEHlnfRfV/NzNSXa7u7pk4fj+FufPl9lykW1Vrj4KotQlZ3IIy2BikGrsEyGI8KtQlthTuMBysL0Z7+bar5J2J4eDY0xaQvx58MC0obdVR/T8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=yUIFuovt; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=kANr2B0r; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B31uu5B215434;
	Tue, 2 Dec 2025 20:34:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=Tfv1qmFxt+29QQLkVwX1rhzpWeDHeUp+rRqWORwBN
	JU=; b=yUIFuovtyJwy/YMvwt4oZS1EQ6yN3ahoHpo6tWrwJYoEoK7cLQBv4P2Qp
	jsL0h26KbygLGj29P/7Hv8wOsIzUExwxT/rZK+v1Upn+xQH6QH9t6fpiJrPTIVKj
	eX9kQ4VxLc/6atYpj7VYN8PJkHdwLmNYAwg3NicfyuUHznng/D1TZuHUsR6/3egI
	wBYDBzDSk4LNH2d9GI+ZC/XxXaK6YkhkgxQg3hybdWsO8LJ28TabbBnJiAbDyU1A
	osO4sko/bJLgL5b9/yh/LARAD8jSPg+qYVOR7B7UMIyAwn0sHOysLzn15HTPYQit
	eiMXqDqCPDujz8BX0TC7I7N0bkigw==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11022141.outbound.protection.outlook.com [40.107.209.141])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4atc09870u-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 02 Dec 2025 20:34:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HV1D5Y/WBY7tOmwkDGBtMkIoJnqBh9JMJUsVSr/ATAKe2vA4UkBO+0+14H/ty6ZSjSJRLXNCTgh0FU2/D9pCNch6t+MVTHTLNmwa9vjGlZLLXk+RKMr0OOHCAKFJJTsSmlUHrofihWRo9oXcQz12BoYJKQinGNzEpNvX3V19nu3QCewRUomRIO4jjPk/KJItM5nz9KvBtwT0GeBeBnJiqocY44v5iefz1bYzvWcl/vllFBIf62pzWDFzjlaeSF1uSDyTJyIlBxjIMDWjdQyRXIHkuVJ6YJMyXmxEFoIRsYZ4nEF+rhWfHzyLSSFa9IqAyE6wFu6YgqvnEKNk7uH82Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tfv1qmFxt+29QQLkVwX1rhzpWeDHeUp+rRqWORwBNJU=;
 b=M+NgNjSNnZnHseFL4E3s0SJfTpB716Z/ANZjItZ2Ylkp2G34HDW9d03rAbDswlmFCUdChWyJQGrlVe9SHYjLW+2fvVE34W09O56fxuAP6gW3NkpWuQDBoFt3l1petOoiDJ9YPNKMT9qqeUYv9m6y4lnFab4xI63DFOEUMbJhywkgSGKGHsKHFMkw99KOwmMstg/2arM4SOjX6qkvghu4MPlN/eJ6BqhyADf+Zkjjc9aWNpz+V+WfPG1Jt2EecNAbR5Fdzh5GF0sLcq0KcYFD6btrdIFc/JOujDMFbJSCZbcKZfvtGPXrSS2P4vIb54MS4RkIGByU9HeoMjYkE13M8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tfv1qmFxt+29QQLkVwX1rhzpWeDHeUp+rRqWORwBNJU=;
 b=kANr2B0rxmGkZol1tjK7syKMe7t3udej+hv5XAQgGJin78s2GuBQbdT/ztvXdo6A4YimivgXg/sc7AIqQ/s+Pxzeg5DJiBwxCxaafU7WuBXFRVDQ1DzhmVuz+0FVSDok9apOh9bRFkK46Vs2PsaaPpuBVllzhUwBFjg9tc61tvDqiA8qu8naQcTI+2+pbBZkzqG2juUZV+qdcZcCS5tPUZWwXxHsEnavrFwb738nwjO56vD6yEi27cRV9UiPtaYgL3EnELrZvtKK3W7SXCUqK2+FxMPzn8eqG80JLecpOURqcpFOsqRA8j7ZsHgbyKHg+3MaVAhTUjILQI7PRCKTEA==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by CO6PR02MB8705.namprd02.prod.outlook.com
 (2603:10b6:303:134::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 04:34:39 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%4]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 04:34:39 +0000
From: Jon Kohler <jon@nutanix.com>
To: Jason Wang <jasowang@redhat.com>
CC: Jesper Dangaard Brouer <hawk@kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo
 Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel
 Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>,
        open list
	<linux-kernel@vger.kernel.org>,
        "open list:XDP (eXpress Data
 Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>,
        Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>,
        Alexander Lobakin
	<aleksander.lobakin@intel.com>
Subject: Re: [PATCH net-next v2 5/9] tun: use bulk NAPI cache allocation in
 tun_xdp_one
Thread-Topic: [PATCH net-next v2 5/9] tun: use bulk NAPI cache allocation in
 tun_xdp_one
Thread-Index:
 AQHcXkBJGnA/Z0TBbE2dy0yPlIYpvLUHaj+AgAcwkgCAAAvqgIAAA5KAgACuyoCAAAagAA==
Date: Wed, 3 Dec 2025 04:34:39 +0000
Message-ID: <AABBC143-F665-44F8-8C5F-79805429A53E@nutanix.com>
References: <20251125200041.1565663-1-jon@nutanix.com>
 <20251125200041.1565663-6-jon@nutanix.com>
 <CACGkMEsDCVKSzHSKACAPp3Wsd8LscUE0GO4Ko9GPGfTR0vapyg@mail.gmail.com>
 <CF8FF91A-2197-47F7-882B-33967C9C6089@nutanix.com>
 <c04b51c6-bc03-410e-af41-64f318b8960f@kernel.org>
 <E9CF75DC-118F-44A7-9752-C6001A1BADFF@nutanix.com>
 <CACGkMEtLQWzRLL3yGiUEvyM31fhcUiafHoGzFSnuF-XdDN0aUg@mail.gmail.com>
In-Reply-To:
 <CACGkMEtLQWzRLL3yGiUEvyM31fhcUiafHoGzFSnuF-XdDN0aUg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV0PR02MB11133:EE_|CO6PR02MB8705:EE_
x-ms-office365-filtering-correlation-id: 1c07b442-3ec4-4fa7-9887-08de32254561
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ODg1eXN2VnJwNEVuV2hTUDVyZWlTQ1daY2c1RmIxUThCRVgvZ002K016Ry9a?=
 =?utf-8?B?ZDhFSytyYkxYYldYSnl3SmNETHZvME55Szc3aXhSbUxpYkNmV3R0dkYvRG1o?=
 =?utf-8?B?MERLMXhJdmNUbnJxbG5wcUR6Q1FweElyc3VXLzEvRFdtcW0rbk5OeWVyYmFs?=
 =?utf-8?B?WUJPbU4zYm4wSlZkbVp5V1V2bUpLYjg0NE9VM2FZbkFhbGx6Tm5tQUIySUpY?=
 =?utf-8?B?QkRUb1A2MUkwTUVDYkd1Q09kY1ZPS0xzOXN5eEdhZ0tFT0U5SWdENmN5dDUy?=
 =?utf-8?B?Z3FiV29DTnJHNHR0eEJkbHJweC9HWmthejgybWFpVU5BdXliU3ZHdjFzVU9J?=
 =?utf-8?B?dC9GK1MvL3BkUGJDTkF0TzJ6MHhqeU4zd01VV05xdmZjSlJxc05JSHlFWTBh?=
 =?utf-8?B?WG5nOG1RUGJwMk0vSitWRkdyVWxOK3JwbzAyeW4xeC9EZk1QSE9ER3NYSHVX?=
 =?utf-8?B?SnBpb0VNT1B6RTdwckR4QTJsRWRrK1VmcGlpL1liM05jbWltZGVhbUQrdzhv?=
 =?utf-8?B?K0NMMHYzWklSMGdsU3NTLzlRaDUwSk9kWjFsL1R2NlVBSlVBdE9jcit2NzE1?=
 =?utf-8?B?RVlpdnFKbTdGaGlNbzJkV1d4N2RZT0lNMVY2dCtBUytOSWZrTnRaVDV5NTU0?=
 =?utf-8?B?alNhWktwdVFkeFdRVExmWmV3SENXSmcvUUdvUTFGMytVaVNKZnhrUFpDZmJh?=
 =?utf-8?B?UFo0UkZ0NkxUcFBlTFhyUlBBTWZYMlUxUjhZdDIrQUhUTWlMWnlpK0hxYk9k?=
 =?utf-8?B?NC9WSVYySlYvQjY4THlwMy9FWlhLekNxMEpOYittUmlPZGpaNDBkbHhPa0Q1?=
 =?utf-8?B?OUpvVWVaR3RlK1B3dWE2TFBObkszU2NkYm8zWkhSYmlVZEEzTENOemZGUjFa?=
 =?utf-8?B?RjR6NHMwTWhEaW9Rd05wZ0gxSDZpbVZQVk5FbW5hb0c3L053REZIVDlIUmFG?=
 =?utf-8?B?QXFzZE5MSHVFRnZQT0FQOHFpbkJ4Z2NacGZOUWJmMHB3YVpDdHoxNnhWVWgv?=
 =?utf-8?B?Q1pwa0hGc25JRlhMTXZWS251dEw4SFdESnFPc25WUUtMRkdOcllWNjhscU9H?=
 =?utf-8?B?SEZKYU9HcmYzMmR6WFZBYVhnaGViaDhGeFo5bnJNRS9zWXdoNWcyZ3VNMVNM?=
 =?utf-8?B?NkpacDZEMExFVkRFbFdKZ0JUeFU1aFg0dUVMcGpJMi9SYy9GNWRsRW1Wa3JQ?=
 =?utf-8?B?WEFTakFSTm9EemVWQVhIL095c045eEhzaWp0WGoyQmNFc21WRGF4SEdiQWQ2?=
 =?utf-8?B?aW9tVUVWaXhVYWVid2ZHQ0t6NFZiVEp3cThMdG1XYk1rYW4wQ2o2YnlzTWpI?=
 =?utf-8?B?ajVxc05RMUx6Wm5qU0FqUFdTRnBRVlNtQjFOUFhwVVltWkxyTTBZbHNlL2N1?=
 =?utf-8?B?TmdMQTl0bCsyN0d4VmdyNVpQREx2VE14UjJrenhDTHJJU0xzV0crbjh3Q1Y3?=
 =?utf-8?B?eGVtSi91anFMMElMdnhYeTkxQXpVZXg4UjZYV0dQVWZ4WUFoOU9DdFhObHNR?=
 =?utf-8?B?eE84T3R0aEI4WWRJNnR6bVY1Y3YzQjhWeERqU2hhdGtRZDlNUVBLMkc1VzR5?=
 =?utf-8?B?aFFJdDRZTUIvTUJiZHZWZVh5K2JUMmFyZVcxb01oZlM5R21SamR3cHNGaXMv?=
 =?utf-8?B?NFMyc01TanYwWUNFYW5PNkFtbFp4NVZXNnR6SXplME9WelVGSmlkU2pWOXQv?=
 =?utf-8?B?UWNxdXFhZHVCclY3aGxOM2dmS3dyZElPdXBUbW4xdUhvYmZjdkxNODJkZDBJ?=
 =?utf-8?B?MVRFSlR5ZFNrUmZMSVc2Q2psdUZTd3BuZmVXd3dxRlJrc3lHdCtacThrMXc2?=
 =?utf-8?B?TXdJSGU4ZkNtVkRjS2VmbUVpQlZHRlVIWFRmNmc3R1RncW04RThZTkloSGNI?=
 =?utf-8?B?TmJ6c0N1Wkgra2ZOZjV3SXdxa2laeU9HbElJOGNjTzJZNk1TNWVFc2R6Y0lP?=
 =?utf-8?B?QmhIT0g1aUpsWkFwTkNMbHlQLzIxSzJ0Nm5kcXp6c0N5RCtTNHNMWllFaGVT?=
 =?utf-8?B?dGMzRForZjVFMzVsSm1SVW5hNkZxNDlKZERjY2NSMzFSbS9CcmJRMGxZVUJt?=
 =?utf-8?Q?lI0aly?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV0PR02MB11133.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZVlyeW1yZ2FQZ2crTXV2OHpXeVhhUHlnRVRtUzl6MWttdC96OGhzWFY1d2Uv?=
 =?utf-8?B?Q05nV09KaW96ZHNLMk1vd0FvazQrcDB6Mkg3dWVackR2bFkya243dFF1cS9a?=
 =?utf-8?B?dHk2SnhkMmczYTlHSjl5QktLbHBjTUswUU5KMVhVSzloSktkYUNDaXEyczlO?=
 =?utf-8?B?UE9VY3JORHRBend6Ry9YY3pkcGZ2S0VtMXM1MFgwR09BcG4yRnd5S3JXRlJn?=
 =?utf-8?B?MVNYVGhTV01WWHU4d0NIZUYybjlYUFcrWld0UWpkMzJveTAyS0owYmFCakVN?=
 =?utf-8?B?OE5WQnd3WWsveS9PWGdpOTNkOUNuOENvdmRCbFNIZGpRR0NRemJBRHRrUUtY?=
 =?utf-8?B?Y05qVWM2Q2N5Zm1HQjYrVXpzQXA4cXRnNWV4WG1mMWRteUtwNXM2YWtQOGN6?=
 =?utf-8?B?akV3M2VTYzVEQjhuY2tacTJvRWNad1Q1UkNTYWRZWVR4VWx5RWg5ajJLaCtF?=
 =?utf-8?B?QldSc1Q1M2lsRWpCaEJUYk9QaEZMTjlqK2dSQ2VyeGxGS0s3VGpQOE0ycFFs?=
 =?utf-8?B?clphbng5UnR1eU9GcFdpYkRncDZWcDRuNURiQ3ZQanV2MTBIY054dnNERnBV?=
 =?utf-8?B?VUxPUzlEcFFwSXpOYWFYSjV2V25Nd1g3UEdxUDNFTWMzdFJodTc0TlRqak45?=
 =?utf-8?B?SENqcVdwcjRNVVJla3QwMFBWeFUwWXIrYVRwK0MwYkp6aFBYK2dUeXJuT3pF?=
 =?utf-8?B?TlcyeWFQTDNVQlBiN0FUbHNsYlVFZlJmdmtNUnorT2JIUnZiT2xhOVNsTnln?=
 =?utf-8?B?TVRMV2JFamRZS2hHOFVzTzhvMS9ObndtWnY3eG8yMGV6SVhJZ1BVeUQvTXAv?=
 =?utf-8?B?bzN0Y2l2cUhiMnYvejIvamZ3UXhVVnZhTFlYQXZXTW0wNmx6VUcwYmRHd2N1?=
 =?utf-8?B?TWFzUTdDbVdYRTh5aWtmaGpRZlNMOWNyK00xRGUwak1oS1RESXFwYjFyQzFM?=
 =?utf-8?B?dGZLSHBnSXc5d0JhR242NXkvOG5Sbzd0Z2VpUng0N0ZwSm02ajZkTW85MStw?=
 =?utf-8?B?RHRyQ29SeW43bk1HOEpIQ1BPTDNLT045Y3pDMVJISGk2VzlEVXVNQnJjcEpY?=
 =?utf-8?B?RUpadFVTRkVhMzJ5ZENmMUEwbGtPOEtnMG9RMEdtNVpZM1RjVWNtenJRdm1V?=
 =?utf-8?B?bHdOL0p4Um5sdHJiUDVGMHZDNG53aS9zbFA0RTRpMjJiZ2NxNXplQTROSWRW?=
 =?utf-8?B?UEdWS2tPdTk2d0lxemswVEEvbXpGUWVHZWtYV3crSCsrdCtDZ3hBa1RQV2Fx?=
 =?utf-8?B?RjNlbldYNUFqS3FablNwOVphQ0VaaGZpR1VFVHdmMmdMSnM3eWVMWjdlVjg0?=
 =?utf-8?B?ams1YjZiN2JUNXZZUnBWYnZjcythRFdESkNob2N0dFVWaDd1Uk41bk5OQTBh?=
 =?utf-8?B?UXBPZGNtMXVyQnFHeTdBVVdWc3ZYSTRYOFAxMkhvVjlPL2h2d3NSOW95U0Ns?=
 =?utf-8?B?MXlXSEM5SWdCRmF0NVdRd3pUOC9XOUY3bEdyUzFoL2NNTGNuVGRjMEFHWm0z?=
 =?utf-8?B?NEUzVFg1elBZYVpRbzlSQmFqWnYyVnVxald1OVB6TlpjZEQxcnM0R0VodFV5?=
 =?utf-8?B?SGFGeXprcUM2T2tmSEM3ME5td1lyQUFoeDg2RVduUjd6Vyt1enVEdThSNmwx?=
 =?utf-8?B?Mms5SzByMzM2eTd4SGNCeXJySXdYNjg5US9oK2JNK2hYRkZFUFd6MERxby9J?=
 =?utf-8?B?aVdQMEdSdWNyb1RseUJoV0xvNWwyVjVMd0wwU29RSGw2RWpyRTl2UHV4SVR4?=
 =?utf-8?B?MGFySG9HK3ZZenVJWHg0anRsQ3FKelV5bjlpcnRlT0czZFdZSjV1dnZOZFBI?=
 =?utf-8?B?bE42UjhDZE03ejF6S1FTME5uYXFEZnAySGxyZnNHYUZra3NmUVYvck5aeURh?=
 =?utf-8?B?c3dwQlRlRXRRQjBZMmZ1MEs3YitrOFBpZzZ1YmNiNWtRaXdKdlVETWlSdVFK?=
 =?utf-8?B?elZhMmpvWVNsK2M2YktMYjFuUlhHb1NXbk81QktqdjlvV09NaXJFRGFpR2Nv?=
 =?utf-8?B?NHpDaGJwQUt0bDNCM0NPTjFMLytCMkNNVys5QWttdTNqcmFkYzNaMFRvcVBy?=
 =?utf-8?B?WEhHYW5aS0VoQ1g5cVhFZVBSZ2RmK0tGeTVvSCtuZkFCV3hBVklwcytyeHVJ?=
 =?utf-8?B?QTJNZkJ3eld0SjZPK3hCNzkrRGZCNzNhY0dZR2FZRS9VL3J4cHBkMXZlaUJM?=
 =?utf-8?B?VlV6MkY0RHBmUHRLU3RvNlBjUFQvK01UbXU4TDhrN2hMT2RTTnllV1dIdkJq?=
 =?utf-8?B?WmpiNDM3ZzZVTEx5WEFhVUhLWFNRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F39DEC4B83A444C90AF2F8601A521E6@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c07b442-3ec4-4fa7-9887-08de32254561
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2025 04:34:39.1829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x9C01OXSaZGBqd/fKVPRdYW7+LkBkL3PsHLu0eRUI5jtoU2NdtaggdzCi9o3ZQ0DRNO7iXFRA8r/zzWKqUs1XV10BETYy0pgab3Tea757/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB8705
X-Proofpoint-ORIG-GUID: 28sFrtmx09nlnmN1XZqSf1Y1OZHoTwG1
X-Authority-Analysis: v=2.4 cv=HdgZjyE8 c=1 sm=1 tr=0 ts=692fbde1 cx=c_pps
 a=akgGQRVw8jCujCvxOk+VwA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=SqVMTP5faZQvhJ5aI78A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 28sFrtmx09nlnmN1XZqSf1Y1OZHoTwG1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDAzMyBTYWx0ZWRfX3xaGvgzbb4sw
 7447GpkySjfUOG1MTosnXYREeMuwe4HD5QbXkxw6I3JT15GTbUXx/zVwai7lNobF2nne05qX2md
 drA1OyM7qqsH48zgob2hJP4BCYArK5N6l0TEqNvXU6JB/0B1xdfhR7md+reprdjyg25DVHbRhpS
 fijrFAzw96CO+glyHmzsyO3x6nSyYSB6r0eDhnuQzuFglKbVhkrhWEtf4CG6qM9UQhaJNfKUB8/
 Obhq0YkTTh6VLGyBqHAUV85c0Tlw7poGA6LKWdRF9J4xqardW0a2caVI9fScsejbFwnWtQ7E+Di
 olJKfGdIrHYiEPtyVaOPAIiYfvLTpCAjKsD5oEhsQUiyjN4M/L6iN9blzRFutGxkYUiAe2cqbxO
 riJTeYUCkQ3QZVdOke2pLKN73jcfeg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gRGVjIDIsIDIwMjUsIGF0IDExOjEw4oCvUE0sIEphc29uIFdhbmcgPGphc293YW5n
QHJlZGhhdC5jb20+IHdyb3RlOg0KPiANCj4gT24gV2VkLCBEZWMgMywgMjAyNSBhdCAxOjQ24oCv
QU0gSm9uIEtvaGxlciA8am9uQG51dGFuaXguY29tPiB3cm90ZToNCj4+IA0KPj4gDQo+PiANCj4+
PiBPbiBEZWMgMiwgMjAyNSwgYXQgMTI6MzLigK9QTSwgSmVzcGVyIERhbmdhYXJkIEJyb3VlciA8
aGF3a0BrZXJuZWwub3JnPiB3cm90ZToNCj4+PiANCj4+PiANCj4+PiANCj4+PiBPbiAwMi8xMi8y
MDI1IDE3LjQ5LCBKb24gS29obGVyIHdyb3RlOg0KPj4+Pj4gT24gTm92IDI3LCAyMDI1LCBhdCAx
MDowMuKAr1BNLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToNCj4+Pj4+
IA0KPj4+Pj4gT24gV2VkLCBOb3YgMjYsIDIwMjUgYXQgMzoxOeKAr0FNIEpvbiBLb2hsZXIgPGpv
bkBudXRhbml4LmNvbT4gd3JvdGU6DQo+Pj4+Pj4gDQo+Pj4+Pj4gT3B0aW1pemUgVFVOX01TR19Q
VFIgYmF0Y2ggcHJvY2Vzc2luZyBieSBhbGxvY2F0aW5nIHNrX2J1ZmYgc3RydWN0dXJlcw0KPj4+
Pj4+IGluIGJ1bGsgZnJvbSB0aGUgcGVyLUNQVSBOQVBJIGNhY2hlIHVzaW5nIG5hcGlfc2tiX2Nh
Y2hlX2dldF9idWxrLg0KPj4+Pj4+IFRoaXMgcmVkdWNlcyBhbGxvY2F0aW9uIG92ZXJoZWFkIGFu
ZCBpbXByb3ZlcyBlZmZpY2llbmN5LCBlc3BlY2lhbGx5DQo+Pj4+Pj4gd2hlbiBJRkZfTkFQSSBp
cyBlbmFibGVkIGFuZCBHUk8gaXMgZmVlZGluZyBlbnRyaWVzIGJhY2sgdG8gdGhlIGNhY2hlLg0K
Pj4+Pj4gDQo+Pj4+PiBEb2VzIHRoaXMgbWVhbiB3ZSBzaG91bGQgb25seSBlbmFibGUgdGhpcyB3
aGVuIE5BUEkgaXMgdXNlZD8NCj4+Pj4gTm8sIGl0IGRvZXMgbm90IG1lYW4gdGhhdCBhdCBhbGws
IGJ1dCBJIHNlZSB3aGF0IHRoYXQgd291bGQgYmUgY29uZnVzaW5nLg0KPj4+PiBJIGNhbiBjbGVh
biB1cCB0aGUgY29tbWl0IG1zZyBvbiB0aGUgbmV4dCBnbyBhcm91bmQNCj4+Pj4+PiANCj4+Pj4+
PiBJZiBidWxrIGFsbG9jYXRpb24gY2Fubm90IGZ1bGx5IHNhdGlzZnkgdGhlIGJhdGNoLCBncmFj
ZWZ1bGx5IGRyb3Agb25seQ0KPj4+Pj4+IHRoZSB1bmNvdmVyZWQgcG9ydGlvbiwgYWxsb3dpbmcg
dGhlIHJlc3Qgb2YgdGhlIGJhdGNoIHRvIHByb2NlZWQsIHdoaWNoDQo+Pj4+Pj4gaXMgd2hhdCBh
bHJlYWR5IGhhcHBlbnMgaW4gdGhlIHByZXZpb3VzIGNhc2Ugd2hlcmUgYnVpbGRfc2tiKCkgd291
bGQNCj4+Pj4+PiBmYWlsIGFuZCByZXR1cm4gLUVOT01FTS4NCj4+Pj4+PiANCj4+Pj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBKb24gS29obGVyIDxqb25AbnV0YW5peC5jb20+DQo+Pj4+PiANCj4+Pj4+IERv
IHdlIGhhdmUgYW55IGJlbmNobWFyayByZXN1bHQgZm9yIHRoaXM/DQo+Pj4+IFllcywgaXQgaXMg
aW4gdGhlIGNvdmVyIGxldHRlcjoNCj4+Pj4gaHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQu
Y29tL3YyL3VybD91PWh0dHBzLTNBX19wYXRjaHdvcmsua2VybmVsLm9yZ19wcm9qZWN0X25ldGRl
dmJwZl9jb3Zlcl8yMDI1MTEyNTIwMDA0MS4xNTY1NjYzLTJEMS0yRGpvbi00MG51dGFuaXguY29t
XyZkPUR3SURhUSZjPXM4ODNHcFVDT0NoS09IaW9jWXRHY2cmcj1OR1BSR0dvMzdtUWlTWGdIS201
ckNRJm09RDdwaUp3T09RU2o3QzFwdUJsYmg1ZG1BYy1xc0x3NkU2NjB5QzVqSlhXWms5cHB2ak9x
VDlYYzYxZXdZU21vZCZzPXlVUGhSZHF0MmxWblc1RnhpT3B2S0UzNGlYS3lHRVdrNTAyRGtvMWkz
UEkmZT0NCj4gDQo+IE9rIGJ1dCBpdCBvbmx5IGNvdmVycyBVRFAsIEkgdGhpbmsgd2Ugd2FudCB0
byBzZWUgaG93IGl0IHBlcmZvcm1zIGZvcg0KPiBUQ1AgYXMgd2VsbCBhcyBsYXRlbmN5LiBCdHcg
aXMgdGhlIHRlc3QgZm9yIElGRl9OQVBJIG9yIG5vdD8NCg0KVGhpcyB0ZXN0IHdhcyB3aXRob3V0
IElGRl9OQVBJLCBidXQgSSBjb3VsZCBnZXQgdGhlIE5BUEkgbnVtYmVycyB0b28NCk1vcmUgb24g
dGhhdCBiZWxvdw0KDQo+IA0KPj4+Pj4+IC0tLQ0KPj4+Pj4+IGRyaXZlcnMvbmV0L3R1bi5jIHwg
MzAgKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tDQo+Pj4+Pj4gMSBmaWxlIGNoYW5nZWQs
IDI0IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+Pj4+Pj4gDQo+Pj4+Pj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbmV0L3R1bi5jIGIvZHJpdmVycy9uZXQvdHVuLmMNCj4+Pj4+PiBpbmRl
eCA5N2YxMzBiYzVmZWQuLjY0Zjk0NGNjZTUxNyAxMDA2NDQNCj4+Pj4+PiAtLS0gYS9kcml2ZXJz
L25ldC90dW4uYw0KPj4+Pj4+ICsrKyBiL2RyaXZlcnMvbmV0L3R1bi5jDQo+Pj4gWy4uLl0NCj4+
Pj4+PiBAQCAtMjQ1NCw2ICsyNDU1LDcgQEAgc3RhdGljIGludCB0dW5feGRwX29uZShzdHJ1Y3Qg
dHVuX3N0cnVjdCAqdHVuLA0KPj4+Pj4+ICAgICAgICAgICAgICAgcmV0ID0gdHVuX3hkcF9hY3Qo
dHVuLCB4ZHBfcHJvZywgeGRwLCBhY3QpOw0KPj4+Pj4+ICAgICAgICAgICAgICAgaWYgKHJldCA8
IDApIHsNCj4+Pj4+PiAgICAgICAgICAgICAgICAgICAgICAgLyogdHVuX3hkcF9hY3QgYWxyZWFk
eSBoYW5kbGVzIGRyb3Agc3RhdGlzdGljcyAqLw0KPj4+Pj4+ICsgICAgICAgICAgICAgICAgICAg
ICAgIGtmcmVlX3NrYl9yZWFzb24oc2tiLCBTS0JfRFJPUF9SRUFTT05fWERQKTsNCj4+Pj4+IA0K
Pj4+Pj4gVGhpcyBzaG91bGQgYmVsb25nIHRvIHByZXZpb3VzIHBhdGNoZXM/DQo+Pj4+IFdlbGws
IG5vdCByZWFsbHksIGFzIHdlIGRpZCBub3QgZXZlbiBoYXZlIGFuIFNLQiB0byBmcmVlIGF0IHRo
aXMgcG9pbnQNCj4+Pj4gaW4gdGhlIHByZXZpb3VzIGNvZGUNCj4+Pj4+IA0KPj4+Pj4+ICAgICAg
ICAgICAgICAgICAgICAgICBwdXRfcGFnZSh2aXJ0X3RvX2hlYWRfcGFnZSh4ZHAtPmRhdGEpKTsN
Cj4+PiANCj4+PiBUaGlzIGNhbGxpbmcgcHV0X3BhZ2UoKSBkaXJlY3RseSBhbHNvIGxvb2tzIGR1
YmlvdXMuDQo+Pj4gDQo+Pj4+Pj4gICAgICAgICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+
Pj4+Pj4gICAgICAgICAgICAgICB9DQo+Pj4+Pj4gQEAgLTI0NjMsNiArMjQ2NSw3IEBAIHN0YXRp
YyBpbnQgdHVuX3hkcF9vbmUoc3RydWN0IHR1bl9zdHJ1Y3QgKnR1biwNCj4+Pj4+PiAgICAgICAg
ICAgICAgICAgICAgICAgKmZsdXNoID0gdHJ1ZTsNCj4+Pj4+PiAgICAgICAgICAgICAgICAgICAg
ICAgZmFsbHRocm91Z2g7DQo+Pj4+Pj4gICAgICAgICAgICAgICBjYXNlIFhEUF9UWDoNCj4+Pj4+
PiArICAgICAgICAgICAgICAgICAgICAgICBuYXBpX2NvbnN1bWVfc2tiKHNrYiwgMSk7DQo+Pj4+
Pj4gICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAwOw0KPj4+Pj4+ICAgICAgICAgICAgICAg
Y2FzZSBYRFBfUEFTUzoNCj4+Pj4+PiAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+Pj4+
Pj4gQEAgLTI0NzUsMTMgKzI0NzgsMTUgQEAgc3RhdGljIGludCB0dW5feGRwX29uZShzdHJ1Y3Qg
dHVuX3N0cnVjdCAqdHVuLA0KPj4+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRw
YWdlLT5wYWdlID0gcGFnZTsNCj4+Pj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0
cGFnZS0+Y291bnQgPSAxOw0KPj4+Pj4+ICAgICAgICAgICAgICAgICAgICAgICB9DQo+Pj4+Pj4g
KyAgICAgICAgICAgICAgICAgICAgICAgbmFwaV9jb25zdW1lX3NrYihza2IsIDEpOw0KPj4+Pj4g
DQo+Pj4+PiBJIHdvbmRlciBpZiB0aGlzIHdvdWxkIGhhdmUgYW55IHNpZGUgZWZmZWN0cyBzaW5j
ZSB0dW5feGRwX29uZSgpIGlzDQo+Pj4+PiBub3QgY2FsbGVkIGJ5IGEgTkFQSS4NCj4+Pj4gQXMg
ZmFyIGFzIEkgY2FuIHRlbGwsIHRoaXMgbmFwaV9jb25zdW1lX3NrYiBpcyByZWFsbHkganVzdCBh
biBhcnRpZmFjdCBvZg0KPj4+PiBob3cgaXQgd2FzIG5hbWVkIGFuZCBob3cgaXQgd2FzIHRyYWRp
dGlvbmFsbHkgdXNlZC4NCj4+Pj4gTm93IHRoaXMgaXMgcmVhbGx5IGp1c3QgYSBuYXBpX2NvbnN1
bWVfc2tiIHdpdGhpbiBhIGJoIGRpc2FibGUvZW5hYmxlDQo+Pj4+IHNlY3Rpb24sIHdoaWNoIHNo
b3VsZCBtZWV0IHRoZSByZXF1aXJlbWVudHMgb2YgaG93IHRoYXQgaW50ZXJmYWNlDQo+Pj4+IHNo
b3VsZCBiZSB1c2VkIChhZ2FpbiwgQUZBSUNUKQ0KPj4+IA0KPj4+IFlpY2tzIC0gdGhpcyBzb3Vu
ZHMgc3VwZXIgdWdseS4gIEp1c3Qgd3JhcHBpbmcgbmFwaV9jb25zdW1lX3NrYigpIGluIGJoDQo+
Pj4gZGlzYWJsZS9lbmFibGUgc2VjdGlvbiBhbmQgdGhlbiBhc3N1bWluZyB5b3UgZ2V0IHRoZSBz
YW1lIHByb3RlY3Rpb24gYXMNCj4+PiBOQVBJIGlzIHJlYWxseSBkdWJpb3VzLg0KPj4+IA0KPj4+
IENjIFNlYmFzdGlhbiBhcyBoZSBpcyB0cnlpbmcgdG8gY2xlYW51cCB0aGVzZSBraW5kIG9mIHVz
ZS1jYXNlLCB0byBtYWtlDQo+Pj4ga2VybmVsIHByZWVtcHRpb24gd29yay4NCj4+PiANCj4+PiAN
Cj4+Pj4+IA0KPj4+Pj4+ICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gMDsNCj4+Pj4+PiAg
ICAgICAgICAgICAgIH0NCj4+Pj4+PiAgICAgICB9DQo+Pj4+Pj4gDQo+Pj4+Pj4gYnVpbGQ6DQo+
Pj4+Pj4gLSAgICAgICBza2IgPSBidWlsZF9za2IoeGRwLT5kYXRhX2hhcmRfc3RhcnQsIGJ1Zmxl
bik7DQo+Pj4+Pj4gKyAgICAgICBza2IgPSBidWlsZF9za2JfYXJvdW5kKHNrYiwgeGRwLT5kYXRh
X2hhcmRfc3RhcnQsIGJ1Zmxlbik7DQo+Pj4+Pj4gICAgICAgaWYgKCFza2IpIHsNCj4+Pj4+PiAr
ICAgICAgICAgICAgICAga2ZyZWVfc2tiX3JlYXNvbihza2IsIFNLQl9EUk9QX1JFQVNPTl9OT01F
TSk7DQo+Pj4+IFRob3VnaCB0byB5b3VyIHBvaW50LCBJIGRvbnQgdGhpbmsgdGhpcyBhY3R1YWxs
eSBkb2VzIGFueXRoaW5nIGdpdmVuDQo+Pj4+IHRoYXQgaWYgdGhlIHNrYiB3YXMgc29tZWhvdyBu
dWtlZCBhcyBwYXJ0IG9mIGJ1aWxkX3NrYl9hcm91bmQsIHRoZXJlDQo+Pj4+IHdvdWxkIG5vdCBi
ZSBhbiBza2IgdG8gZnJlZS4gRG9lc27igJl0IGh1cnQgdGhvdWdoLCBmcm9tIGEgc2VsZiBkb2N1
bWVudGluZw0KPj4+PiBjb2RlIHBlcnNwZWN0aXZlIHRobz8NCj4+Pj4+PiAgICAgICAgICAgICAg
IGRldl9jb3JlX3N0YXRzX3J4X2Ryb3BwZWRfaW5jKHR1bi0+ZGV2KTsNCj4+Pj4+PiAgICAgICAg
ICAgICAgIHJldHVybiAtRU5PTUVNOw0KPj4+Pj4+ICAgICAgIH0NCj4+Pj4+PiBAQCAtMjU2Niw5
ICsyNTcxLDExIEBAIHN0YXRpYyBpbnQgdHVuX3NlbmRtc2coc3RydWN0IHNvY2tldCAqc29jaywg
c3RydWN0IG1zZ2hkciAqbSwgc2l6ZV90IHRvdGFsX2xlbikNCj4+Pj4+PiAgICAgICBpZiAobS0+
bXNnX2NvbnRyb2xsZW4gPT0gc2l6ZW9mKHN0cnVjdCB0dW5fbXNnX2N0bCkgJiYNCj4+Pj4+PiAg
ICAgICAgICAgY3RsICYmIGN0bC0+dHlwZSA9PSBUVU5fTVNHX1BUUikgew0KPj4+Pj4+ICAgICAg
ICAgICAgICAgc3RydWN0IGJwZl9uZXRfY29udGV4dCBfX2JwZl9uZXRfY3R4LCAqYnBmX25ldF9j
dHg7DQo+Pj4+Pj4gKyAgICAgICAgICAgICAgIGludCBmbHVzaCA9IDAsIHF1ZXVlZCA9IDAsIG51
bV9za2JzID0gMDsNCj4+Pj4+PiAgICAgICAgICAgICAgIHN0cnVjdCB0dW5fcGFnZSB0cGFnZTsN
Cj4+Pj4+PiAgICAgICAgICAgICAgIGludCBuID0gY3RsLT5udW07DQo+Pj4+Pj4gLSAgICAgICAg
ICAgICAgIGludCBmbHVzaCA9IDAsIHF1ZXVlZCA9IDA7DQo+Pj4+Pj4gKyAgICAgICAgICAgICAg
IC8qIE1heCBzaXplIG9mIFZIT1NUX05FVF9CQVRDSCAqLw0KPj4+Pj4+ICsgICAgICAgICAgICAg
ICB2b2lkICpza2JzWzY0XTsNCj4+Pj4+IA0KPj4+Pj4gSSB0aGluayB3ZSBuZWVkIHNvbWUgdHdl
YWtzDQo+Pj4+PiANCj4+Pj4+IDEpIFRVTiBpcyBkZWNvdXBsZWQgZnJvbSB2aG9zdCwgc28gaXQg
c2hvdWxkIGhhdmUgaXRzIG93biB2YWx1ZSAoYQ0KPj4+Pj4gbWFjcm8gaXMgYmV0dGVyKQ0KPj4+
PiBTdXJlLCBJIGNhbiBtYWtlIGFub3RoZXIgY29uc3RhbnQgdGhhdCBkb2VzIGEgc2ltaWxhciB0
aGluZw0KPj4+Pj4gMikgUHJvdmlkZSBhIHdheSB0byBmYWlsIG9yIGhhbmRsZSB0aGUgY2FzZSB3
aGVuIG1vcmUgdGhhbiA2NA0KPj4+PiBXaGF0IGlmIHdlIHNpbXBseSBhc3NlcnQgdGhhdCB0aGUg
bWF4aW11bSBoZXJlIGlzIDY0LCB3aGljaCBJIHRoaW5rDQo+Pj4+IGlzIHdoYXQgaXQgYWN0dWFs
bHkgaXMgaW4gcHJhY3RpY2U/DQo+IA0KPiBJIHN0aWxsIHByZWZlciBhIGZhbGxiYWNrLg0KDQpB
Y2ssIHdpbGwgY2hldyBvbiB0aGF0IGZvciB0aGUgbmV4dCBvbmUsIGxldOKAmXMgc2V0dGxlIG9u
IHRoZSBsYXJnZXINCmVsZXBoYW50IGluIHRoZSByb29tIHdoaWNoIGlzIHRoZSBOQVBJIHN0dWZm
IGJlbG93LCBhcyBub25lIG9mIHRoaXMNCmdvZXMgYW55d2hlcmUgd2l0aG91dCByZXNvbHZpbmcg
dGhhdCBmaXJzdC4NCg0KPiANCj4+Pj4+IA0KPj4+Pj4+IA0KPj4+Pj4+ICAgICAgICAgICAgICAg
bWVtc2V0KCZ0cGFnZSwgMCwgc2l6ZW9mKHRwYWdlKSk7DQo+Pj4+Pj4gDQo+Pj4+Pj4gQEAgLTI1
NzYsMTMgKzI1ODMsMjQgQEAgc3RhdGljIGludCB0dW5fc2VuZG1zZyhzdHJ1Y3Qgc29ja2V0ICpz
b2NrLCBzdHJ1Y3QgbXNnaGRyICptLCBzaXplX3QgdG90YWxfbGVuKQ0KPj4+Pj4+ICAgICAgICAg
ICAgICAgcmN1X3JlYWRfbG9jaygpOw0KPj4+Pj4+ICAgICAgICAgICAgICAgYnBmX25ldF9jdHgg
PSBicGZfbmV0X2N0eF9zZXQoJl9fYnBmX25ldF9jdHgpOw0KPj4+Pj4+IA0KPj4+Pj4+IC0gICAg
ICAgICAgICAgICBmb3IgKGkgPSAwOyBpIDwgbjsgaSsrKSB7DQo+Pj4+Pj4gKyAgICAgICAgICAg
ICAgIG51bV9za2JzID0gbmFwaV9za2JfY2FjaGVfZ2V0X2J1bGsoc2ticywgbik7DQo+Pj4+PiAN
Cj4+Pj4+IEl0cyBkb2N1bWVudCBzYWlkOg0KPj4+Pj4gDQo+Pj4+PiAiIiINCj4+Pj4+ICogTXVz
dCBiZSBjYWxsZWQgKm9ubHkqIGZyb20gdGhlIEJIIGNvbnRleHQuDQo+Pj4+PiDigJwi4oCdDQo+
Pj4+IFdl4oCZcmUgaW4gYSBiaF9kaXNhYmxlIHNlY3Rpb24gaGVyZSwgaXMgdGhhdCBub3QgZ29v
ZCBlbm91Z2g/DQo+Pj4gDQo+Pj4gQWdhaW4gdGhpcyBmZWVscyB2ZXJ5IHVnbHkgYW5kIHByb25l
IHRvIHBhaW50aW5nIG91cnNlbHZlcyBpbnRvIGENCj4+PiBjb3JuZXIsIGFzc3VtaW5nIEJILWRp
c2FibGVkIHNlY3Rpb25zIGhhdmUgc2FtZSBwcm90ZWN0aW9uIGFzIE5BUEkuDQo+Pj4gDQo+Pj4g
KFRoZSBuYXBpX3NrYl9jYWNoZV9nZXQvcHV0IGZ1bmN0aW9uIGFyZSBvcGVyYXRpbmcgb24gcGVy
IENQVSBhcnJheXMNCj4+PiB3aXRob3V0IGFueSBsb2NraW5nLikNCj4+IA0KPj4gSGFwcHkgdG8g
dGFrZSBzdWdnZXN0aW9ucyBvbiBhbiBhbHRlcm5hdGl2ZSBhcHByb2FjaC4NCj4+IA0KPj4gVGhv
dWdodHM6DQo+PiAxLiBJbnN0ZWFkIG9mIGhhdmluZyBJRkZfTkFQSSBiZSBhbiBvcHQtaW4gdGhp
bmcsIGNsZWFuIHVwIHR1biBzbyBpdA0KPj4gICBpcyAqYWx3YXlzKiBOQVBJ4oCZZCAxMDAlIG9m
IHRoZSB0aW1lPw0KPiANCj4gSUZGX05BUEkgd2lsbCBoYXZlIHNvbWUgb3ZlcmhlYWRzIGFuZCBp
dCBpcyBpbnRyb2R1Y2VkIGJhc2ljYWxseSBmb3INCj4gdGVzdGluZyBpZiBJIHdhcyBub3Qgd3Jv
bmcuDQoNCklJUkMgaXQgd2FzIG9yaWdpbmFsbHkgaW50cm9kdWNlZCBmb3IgdGVzdGluZywgYnV0
IHVuZGVyIHNvbWUgY2lyY3Vtc3RhbmNlcw0KY2FuIGJlIHdpbGRseSBmYXN0ZXIsIHNlZSBjb21t
aXQgZmIzZjkwMzc2OWU4MDUyMjFlYjE5MjA5YjNkOTEyOGQzOTgwMzhhMQ0KKCJ0dW46IHN1cHBv
cnQgTkFQSSBmb3IgcGFja2V0cyByZWNlaXZlZCBmcm9tIGJhdGNoZWQgWERQIGJ1ZmZzIikNCg0K
WW91IG1heSBiZSB0aGlua2luZyBvZiBJRkZfTkFQSV9GUkFHUywgd2hpY2ggc2VlbXMgdmVyeSBt
dWNoIOKAnHRlc3Qgb25seeKAnQ0KYXQgdGhpcyBwb2ludC4NCg0KQW55aG93LCBhc3N1bWluZyB5
b3UgYXJlIHRoaW5raW5nIG9mIElGRl9OQVBJIGl0c2VsZjoNCi0gQXJlIHRoZSBvdmVyaGVhZHMg
eW914oCZdmUgZ290IGluIG1pbmQgY29tcGxldGVseSBzdHJ1Y3R1cmFsL3VuYXZvaWRhYmxlPw0K
LSBPciBpcyB0aGF0IHNvbWV0aGluZyB0aGF0IHdvdWxkIGJlIHdvcnRoIHdoaWxlIGxvb2tpbmcg
YXQ/DQoNCkFzIGEgc2lkZSBub3RlLCBvbmUgdGhpbmcgSSBkaWQgcGxheSB3aXRoIHRoYXQgaXMg
YWJzb2x1dGVseSBzaWxseSBmYXN0ZXINCmlzIHVzaW5nIElGRl9OQVBJIHdpdGggTkFQSSB0aHJl
YWRzLiBVbmRlciBjZXJ0YWluIHNjZW5hcmlvcyAoaGlnaCB0cHV0DQp0aGF0IGlzIG5vcm1hbGx5
IGNvcHkgYm91bmQpLCBnYWlucyB3ZXJlIG51dHR5IChsaWtlIH43NSUrKSwgc28gdGhlIHBvaW50
DQppcyB0aGVyZSBtYXkgYmUgc29tZSB2ZXJ5IGludGVyZXN0aW5nIGp1aWNlIHRvIHNxdWVlemUg
Z29pbmcgZG93biB0aGF0DQpwYXRoLg0KDQpDb21pbmcgYmFjayB0byB0aGUgbWFpbiBwYXRoIGhl
cmUsIHRoZSB3aG9sZSByZWFzb24gSeKAmW0gZ29pbmcgZG93biB0aGlzDQpwYXRjaHNldCBpcyB0
byB0cnkgdG8gcGlja3VwIG9wdGltaXphdGlvbnMgdGhhdCBhcmUgYXZhaWxhYmxlIGluIG90aGVy
DQpnZW5lcmFsIHB1cnBvc2UgZHJpdmVycywgd2hpY2ggYXJlIGFsbCBOQVBJLWl6ZWQuIFdl4oCZ
cmUgYXQgdGhlIHBvaW50IG5vdw0Kd2hlcmUgdHVuIGlzIGdldHRpbmcgbGVmdCBiZWhpbmQgZm9y
IHRoaW5ncyBsaWtlIHRoaXMgYmVjYXVzZSBvZiBub24tZnVsbA0KdGltZSBOQVBJLg0KDQpTYWlk
IGFub3RoZXIgd2F5LCBJIHRoaW5rIGl0IHdvdWxkIGJlIGFuIGFkdmFudGFnZSB0byBOQVBJLWl6
ZSB0dW4gYW5kDQptYWtlIGl0IG1vcmUgbGlrZSByZWd1bGFyIG9sZSBuZXR3b3JrIGRyaXZlcnMs
IHNvIHRoYXQgdGhlIGdlbmVyaWMgY29yZQ0Kd29yayBiZWluZyBkb25lIHdpbGwgYmVuZWZpdCB0
dW4gYnkgZGVmYXVsdC4NCg0KPj4gT3V0c2lkZSBvZiBwZW9wbGUgd2hvIGhhdmUNCj4+ICAgd2ly
ZWQgdGhpcyB1cCBpbiB0aGVpciBhcHBzIG1hbnVhbGx5LCBvbiB0aGUgdmlydHVhbGl6YXRpb24g
c2lkZQ0KPj4gICB0aGVyZSBpcyBjdXJyZW50bHkgbm8gc3VwcG9ydCBmcm9tIFFFTVUvTGlidmly
dCB0byBlbmFibGUgSUZGX05BUEkuDQo+PiAgIE1pZ2h0IGJlIGEgbmljZSBzaW1wbGlmaWNhdGlv
bi9jbGVhbnVwIHRvIGp1c3Qg4oCcZG8gaXTigJ0gZnVsbCB0aW1lPw0KPj4gICBUaGVuIHdlIGNh
biBwbGF5IGFsbCB0aGVzZSBzb3J0cyBvZiBnYW1lcyB1bmRlciB0aGUgcHJvdGVjdGlvbiBvZg0K
Pj4gICBOQVBJPw0KPiANCj4gQSBmdWxsIGJlbmNobWFyayBuZWVkcyB0byBiZSBydW4gZm9yIHRo
aXMgdG8gc2VlLg0KDQpEbyB5b3UgaGF2ZSBhIHN1Z2dlc3RlZCB0ZXN0L3N1aXRlIG9mIHRlc3Rz
IHlvdeKAmWQgcHJlZmVyIG1lIHRvIHJ1bg0Kc28gdGhhdCBJIGNhbiBtYWtlIHN1cmUgSeKAmW0g
Z2F0aGVyaW5nIHRoZSBkYXRhIHRoYXQgeW914oCZZCBsaWtlIHRvDQpzZWU/DQoNCj4+IDIuIChT
b21lIG90aGVyIG5vbi1kdWJpb3VzIHdheSBvZiBwcm90ZWN0aW5nIHRoaXMsIHdpdGhvdXQgcmVm
YWN0b3JpbmcNCj4+ICAgZm9yIGVpdGhlciBjb25kaXRpb25hbCBOQVBJICh5dWNrPykgb3IgcmVm
YWN0b3JpbmcgZm9yIGZ1bGwgdGltZQ0KPj4gICBOQVBJPyBUaGlzIHdvdWxkIGJlIG5pY2UsIGhh
cHB5IHRvIHRha2UgdGlwcyENCj4+IDMuIC4uLiA/DQo+PiANCj4gDQoNCg==

