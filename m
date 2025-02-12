Return-Path: <bpf+bounces-51223-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39092A31F7E
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 07:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AED23A982D
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 06:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAB51FF1AF;
	Wed, 12 Feb 2025 06:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="QGsb9wPm"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FD81DDA1B;
	Wed, 12 Feb 2025 06:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739343186; cv=fail; b=X+AZJSzZPnskMHLG6LTOiQaPEOTPRKiCkKBvVgTNXFnwdGIvKT8R+B0KhADviQkHYplWGnzoXzPvTld1dt8NsDM3x7k2x7IY0Q2toWtXVb7+y0HKX9548wKQir8Vz0Pj6LP73vcOqQUby5NTL50EyOx5OfllRyUsIO1xFmDBeiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739343186; c=relaxed/simple;
	bh=FAURdf6CDzBjEkU8X40ljeKJMvkGNm3Vk0jFYMZE/DI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V1Wz6UE9PR6NABgw2ZoCF9HG/EkLIO3tTSb4HjtVn2LphqcTgFqWqotWifak5S3gtWzgG7V6Jypu4ZC9KYa9YXn2ge6jG8HVlDWmrmnCU7jtgeI47SFpaRS1DWWAWVc8xAeeyAbP9PO1aRyhXV5Q8KK0Mfw8ip5LCeWPcCQLxR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=QGsb9wPm; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51C40X4k000340;
	Tue, 11 Feb 2025 22:52:44 -0800
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44rm8789r9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Feb 2025 22:52:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L7LS6VvdN5HApEKvKRvKBGMj/2TYXHperSxJU4E35HjywuCFk2/BCnvcr0Qfm7pzABULkTNykn9AuGHZ9HgkKKwcLKYSpzFSlogsSircYdhPz3PpHZdWCbG+Zmlq7R0TU6/PVGVFWjsdQilZP+v3IHIIttJy/dbal9+7j1pSSfSfcmbtIl3A2a7aELmU0yp0A8PY0Dq1lWRnv6n+vzWML0hO4iem9xpZolI7hAptYrpTRYCYmuPiES6P6qGSPwTZ2swOlsu/vKVkDRjUTDhb+c44kBvSWpacXNRIbwZAiSfrc6B7MR0iJGQ78N58yf3JupIvPq+cAA6F/n/Zjc7kyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FAURdf6CDzBjEkU8X40ljeKJMvkGNm3Vk0jFYMZE/DI=;
 b=XiN3Pqv0olcYOs4pymTy9WRICraNLgAzSjaWBaGrS8PE2APOFoAeG0PLwoVSmBS6Ue+te9H3u3kmfalns4jt5LdErXdFq67SEBiXImsu8tdtkOmN+Lzg6p3mfFY/cgRThNFS8BRRG+V10of1c3BI/C2aWwOfie9aHcZsvCd/hor+6DVOjIdHJIAom37AJmx8agsFyfEZCu0wE+sd9ug98FqpHN/C3sZHEobRAyxPhNqCySZ2kPKw3AMnPrdahiuZmoYBA8I/Qyl9X54XhIH+aGW0NkRDZXg+9ky4n5Fl9LtYWhtvLnTEsfO6Qfoa7yY6DGJbRBvwDIIZ4aeLMFCL8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FAURdf6CDzBjEkU8X40ljeKJMvkGNm3Vk0jFYMZE/DI=;
 b=QGsb9wPmagdliAzmacV9QSLKln89ti09N9uMwXUB/j3btzAj77VR34FfmnbXWG91W0LXa1uL04edIzNCZmuh2PAY2w5RfcApO+R2SpIiUpIcU/+vNlqumZFP3+ONb+YQ+mrArOQnwmN2KZALD+flXmtkZyjjev3jKHGDh1t6e+A=
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com (2603:10b6:a03:430::6)
 by MW5PR18MB5093.namprd18.prod.outlook.com (2603:10b6:303:1a8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 06:52:42 +0000
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::2bf5:960a:a348:fad1]) by SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::2bf5:960a:a348:fad1%4]) with mapi id 15.20.8422.012; Wed, 12 Feb 2025
 06:52:42 +0000
From: Suman Ghosh <sumang@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Geethasowjanya Akula
	<gakula@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linu Cherian
	<lcherian@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        Bharat Bhushan
	<bbhushan2@marvell.com>,
        "hawk@kernel.org" <hawk@kernel.org>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "ast@kernel.org"
	<ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "larysa.zaremba@intel.com"
	<larysa.zaremba@intel.com>
Subject: RE: [EXTERNAL] Re: [net-next PATCH v5 1/6] octeontx2-pf: use
 xdp_return_frame() to free xdp buffers
Thread-Topic: [EXTERNAL] Re: [net-next PATCH v5 1/6] octeontx2-pf: use
 xdp_return_frame() to free xdp buffers
Thread-Index: AQHbeHRMkvDltmfsOk27Y2q9umEI8rNA2LCAgAJrvrA=
Date: Wed, 12 Feb 2025 06:52:41 +0000
Message-ID:
 <SJ0PR18MB521689E55D82269FF7416E3ADBFC2@SJ0PR18MB5216.namprd18.prod.outlook.com>
References: <20250206085034.1978172-1-sumang@marvell.com>
 <20250206085034.1978172-2-sumang@marvell.com>
 <20250210175415.GI554665@kernel.org>
In-Reply-To: <20250210175415.GI554665@kernel.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR18MB5216:EE_|MW5PR18MB5093:EE_
x-ms-office365-filtering-correlation-id: f7e2578c-315b-4e03-98f4-08dd4b31d8de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TTRIQ0R2R0VNdTdJTlB3VFBVanJBTVZCQ05pVGl1ZzRLanVFN3Q5RTBUNjc3?=
 =?utf-8?B?QS9YZTdyVzdnWjBzc2dla1NFT2pOMEFxTElQanUrNlBBTUtsWEhOd3ovMkor?=
 =?utf-8?B?bTZ4WmtEWXcwdVBxRDFqZkYvN2lqbWNjTVlWeUVlbFdiSjZraG1jcnd2Sm94?=
 =?utf-8?B?WGE4aTlnQXozWUk0V3cyMGpRK3lSUDZWWWVUczNYMXJiL1VhMXlBbzFJNURG?=
 =?utf-8?B?ZlhXMENiUWpia3NnWEc0aWFRUXZaTnhNdms1VUJpZ2FLZHZCbGQzWFBSVDBJ?=
 =?utf-8?B?czlQOHBOMzM4dzFRMDF1SDBPUWdEVzlKV0p3d2FtWjIyZE1JaVpuUC9Mb1BO?=
 =?utf-8?B?UE92VTNkSHE0VldaWGNsb1NZMGVnMDNKNG9nTTF0czMzaEFoR2gvTFUzN0JP?=
 =?utf-8?B?WjdDT2gwY1dOMThLQ2RRN1ZiOHZ4UnJmUVNOempVVmJOeDQ1UHBQa1ltU3Za?=
 =?utf-8?B?azNpZTAzb2dUV1NSVmE3WTJjMTVPYnBrT2t5ME9SbU5pQ0FYTHdGb0c4T0NE?=
 =?utf-8?B?SWtkNzJtcGlZdVJwZGlTYnEyMW13d054aEFoeXM5aytFc29SQ3hWU2NBZm53?=
 =?utf-8?B?WmN1aWJXWlRkYXByNDc4a0RROFk4aFl4a2doYkp0MmZSQkNJMis0Sk9wRXh0?=
 =?utf-8?B?VkNINS9nclF0MlBzUTdVb0QwZDBEWldTOFhWdHRkN29WSmtLTWIranNCVjYr?=
 =?utf-8?B?cGZ3M013NkVmTTEvcUJQUlFFWGV4R3labkZDZFo2N3FRNnNzVE0wS0Z3T1ps?=
 =?utf-8?B?MnU3UFVyaXA5a2FOOUpxTm1Mb2pFOWlNTWszMmpUZnBPTFdrV1BicDgxWlkz?=
 =?utf-8?B?VEV4azVtd1Q1cG9rYkRLRlZtZmV4dmF5T0ExNDVDL3IzWTNoWVdIR2dWR0k5?=
 =?utf-8?B?bDdENUcrUnRQaXUrU1RSVnJpZVB4dWlDSjVpeEV0ZGRMcVhSUXQrZHpUN1lS?=
 =?utf-8?B?SmVxdjJOWTB3ZTY4Y2tZNUdTM0FJc0hwKzRlN0xacjFYSWxlbWdCMUlUVWRu?=
 =?utf-8?B?NHJyZE44MHgzVXdiMWlXZVp3d3dwT1BQazlIZjR4UHBOZm9lcmJKUGFwUUkv?=
 =?utf-8?B?MDJ6TENuWVVwSXdtY1hMalJQdnlpUk1SeVZkMU9ZVTZweThDRitTeEdIQVJ4?=
 =?utf-8?B?RGdJejg4eWZkQW5uNlUvSFZid0RvRzU5UGwxUjg2VU9CWDRzNWhIUXJKWEl4?=
 =?utf-8?B?WE93VHBYRUZrdTU2RlVkWnkwc0RyYk9TdWRnWndxVWRjZEREVFR1NWg1VlJ4?=
 =?utf-8?B?UVlkd3lwK0ZnZ1pLZlJJWnJkOFF6RGtwTG1MeW0zZWJ2dFBVaGRiU3d3RGZN?=
 =?utf-8?B?Y25oYlkxOG1iYXMyeStSaWRsbHEyeUJLWGtRMHh4Z3RKbjFaWXg3ZWhaNW9J?=
 =?utf-8?B?TzhZWVRWL0FodWFhSXFKcWlUOXRTY2RoUHBIbnFCdkZxbVRDbWl2OHFvSW1O?=
 =?utf-8?B?dWd2RnVIVDUyb1E4MThKTnVqM2o3U2JqczZDSjNWMzZUOEVjTGQ1clllL3FK?=
 =?utf-8?B?aTY2ajQ0OGx1eDhrc2d3OGhOeVluaDRMck1VTU9DQklDb09adkZLeFE3QnMy?=
 =?utf-8?B?bHhEUGFmbDc4UU9VWjhaZ05UcTBkZUhRRFlrQ2lkbmVBQmd6RE1WcStzR0Rw?=
 =?utf-8?B?SHUxa1I3YWoyd1pWMUJOSW85QmNHTnhkSXNTR0R3Qk0wWVg1T3NoTHNHQVlU?=
 =?utf-8?B?cUZ5Q2FsWTZOWGt3QTJFdjFYVEJZNkpSNXdLTjNOc0dxNmgxMnI3NFd6TEpJ?=
 =?utf-8?B?QzZoL1dPTXhraSs0bnNuZ1hBN052c1cwRjRKdloySlc4dzFnOHdrTlQ2bWRM?=
 =?utf-8?B?ZFYxazdEaHVGNy9QSnY2UDAyeGhiQzBZb2dERElSc1dlUUovaDVPWGFZN2gx?=
 =?utf-8?B?WTBsZElON2tPNFpZSXJ5Nm02eDBMUlFrdkgwalRCaU1MMmZnWk8rR2FURzVy?=
 =?utf-8?Q?D3+0hHVXfKy823diSfOlSlmn8bMtSeSN?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR18MB5216.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TVlVdk5IWDdDRHhnOG0xNUI1b2ZvVms0L2ZvYzEyZ2VuejkyZnBJOUd0anMw?=
 =?utf-8?B?aWx4ZlVIRzhURkJzNlNvYlhNYkpKMVo0cHhVci9WejZUWTQ0d1UrUXM0TFNC?=
 =?utf-8?B?ZDZXRk93OGNFMm42S3FyVUlKMWFKcS91cUNPV3J3M1p0TWVVRFNHU2ZpeE51?=
 =?utf-8?B?TlZFTGFYblUvVk9lbTIyZ212Y21ZQ2dZTnNJd0o1bzlFN0ZlcUlkdUwram5S?=
 =?utf-8?B?U3piWStaVVhqbE5iVW5IQUtkOFlkQk5YYjFXTXIzWk1VaVhvd0ZVZHpobnJq?=
 =?utf-8?B?S1c0b1VqTmNlb2t5L1hFRytkQWlMU0lVSFUyQ0VUZHhBd1N0OXJtS0pna3BE?=
 =?utf-8?B?R3FnSkZmMi94QWdyZ1BoUlZVQU11ekNOUDZEQWNxQjBHczJlNmU5a0FrRDQy?=
 =?utf-8?B?VUtQTDhlUmhxbmljSE1YbkwwdUZnVEhTTkgweGhwcXFlNm1ubWE5aUNrZ01P?=
 =?utf-8?B?aWtwZ0MwL2ZOSGdpcWVZemZmOFdYdkcvbWo2WnVjVktLWnhCS0FYOXk5QTFX?=
 =?utf-8?B?WWxVZmY2WVJwVUNwbVEwaHZTaW5JbjVmRE80STQrbkRscmpTR01mMGEwekNn?=
 =?utf-8?B?RXhleDhQUy9rUmhzYUtVZktiVFhUbTAwd2dtODFQN05aRFhJMzRDM1huU3ln?=
 =?utf-8?B?aERlbEZhQk96WjZPTHE4MCsybURtRllCUVg1ZHFGT1pvRmxid2NMb3pPZ2Jl?=
 =?utf-8?B?RmE4ZmxQMFd5TS8vaDF2VmJhQytqL0o5czlXeDhSdkV3eUZJNDBSclY0RTMw?=
 =?utf-8?B?RGlGa0gzQnlnaHhKMkg4YkdsMk1PU1J6eDJsckdJb0tWR214NGNXU3RXTWRo?=
 =?utf-8?B?Y28zd1VJL3NUMUl4SFZXZ1lYK2xLTXBnY0Z5YW5zdW85NkVWc09xb2k0MG9L?=
 =?utf-8?B?NjVwaFVaNk5rbDF4clJNckxmTU5KQVhJMzIydnRwZ3YxQk1iZDhldFp5SDBk?=
 =?utf-8?B?emFLeWVkTGFoaDZwRGpicEdTMitiOUNGQU9aUy82WThxTm1VN0FEMWFYbE5v?=
 =?utf-8?B?YlErQmdvUC9Hd05nVnY0R2FURXlacmFJYy8xekUra1NES21tTkVKbGxmc1lp?=
 =?utf-8?B?UittSEgyVjZnL0taajZ3dDVMZWZ3UmpyTjVZUFlEUjFZKzRGRUdjcnZ6Rjcz?=
 =?utf-8?B?QzZPanB3Yk5heEtTcmlaR0hFdlRQRlhLRGIxam9pRzJGc2RWb01yZ1Vpb3ZG?=
 =?utf-8?B?Ym5FUkNnaENtNmQyeWlLUmt5YlR6NUwwS0tVMTVxNlpOVDc0WnBWK3pMbEhl?=
 =?utf-8?B?RW9wMUx4TWM5QUJnanFZdTRCdllNZVh4bG8vdkNmTHo4Y3dWUG9pSm9ZcEwr?=
 =?utf-8?B?alJvMmtOSDhhcnlFREJBcHg3QXJROUdJNUtmNmJQbTRYSzZ3S0ZyNjUybGlq?=
 =?utf-8?B?Wkdvd2dKRjVvMFBPblJ0MlNJWGVvOUNMNUhwdzZnMEhjUUhKcHhRM0lMU0lJ?=
 =?utf-8?B?TVF3S1dvV25sKzNzNG9DaExEL25salRhMEhZQ0RSVnFETzFxMytCOEJiM1li?=
 =?utf-8?B?NkpISlUxRzlYWnlGTUxka0g1QTg0RnpXNTc3VHJLc1laY0hIOVhTRHFmN0pB?=
 =?utf-8?B?Rjdhenp4MWJuU281MU9HakpZcnpmNVBjc2I0Zk1GazlEcGt6bXpqT3BnOC94?=
 =?utf-8?B?MGtSUjFGVVZRZmMvT2NZYkxSby9NR2JBbU9ZQUJxSTNJVFJoaUdWbmFMYmxZ?=
 =?utf-8?B?NU9vY21KeHp0cmN5dk90eGF0eVVnUkN3enQxRmwwUUUxMkp2QXNwU3hZOG9U?=
 =?utf-8?B?bUtDUCtaVUZnWHl2NHZXODl1MEpzZnczaUtMTzRVZjlML3ZteXRZUFBrdVdH?=
 =?utf-8?B?NkJMcDVMLzVob2RrT3lTczBTS2ZEVHdzZEV2ZkUzaHhHMVVwZ3lIampMV285?=
 =?utf-8?B?RnNiQ2J2QWVhZnRuZGhkVUJhbExKa0JkWXZ6eFN1VDVWVDRLUU9FS0g2ZFIy?=
 =?utf-8?B?M1NZR2VIa2VtRlg0YWgweWNORlZ0SlBwZHBERjF0QU1nYkhyQ0ZsSXBIbTQv?=
 =?utf-8?B?SDBNZG5RZTl1VlRGUjVONS90bHNmV29GdGM2R054M3FQQ2ZoVktnRzZITXJj?=
 =?utf-8?B?eFlxOGwyTEFVeDBMaUFucXVPT3VKMHRxZ2tVbDFBZ2p5UE1hU3NEMVNlUEVk?=
 =?utf-8?Q?PNlc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB5216.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7e2578c-315b-4e03-98f4-08dd4b31d8de
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2025 06:52:41.9959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p7T85TwgJKa7WN0oWMDgRlViiIMoqysgPY9ExcvyC+dH43yDne7QABxuCVameNUCXow8fl6TqexDAV3MDEFqbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR18MB5093
X-Proofpoint-GUID: 637zCo0Wye9ENuCHMngo-ht7mUBIgQbh
X-Proofpoint-ORIG-GUID: 637zCo0Wye9ENuCHMngo-ht7mUBIgQbh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_02,2025-02-11_01,2024-11-22_01

Pj4gQEAgLTE0NjUsMTAgKzE0NzYsMTQgQEAgc3RhdGljIGJvb2wgb3R4Ml94ZHBfcmN2X3BrdF9o
YW5kbGVyKHN0cnVjdA0KPm90eDJfbmljICpwZnZmLA0KPj4gIAkJdHJhY2VfeGRwX2V4Y2VwdGlv
bihwZnZmLT5uZXRkZXYsIHByb2csIGFjdCk7DQo+PiAgCQlicmVhazsNCj4+ICAJY2FzZSBYRFBf
RFJPUDoNCj4+ICsJCWNxLT5wb29sX3B0cnMrKzsNCj4+ICsJCWlmIChwYWdlLT5wcCkgew0KPj4g
KwkJCXBhZ2VfcG9vbF9yZWN5Y2xlX2RpcmVjdChwb29sLT5wYWdlX3Bvb2wsIHBhZ2UpOw0KPj4g
KwkJCXJldHVybiB0cnVlOw0KPj4gKwkJfQ0KPj4gIAkJb3R4Ml9kbWFfdW5tYXBfcGFnZShwZnZm
LCBpb3ZhLCBwZnZmLT5yYnNpemUsDQo+PiAgCQkJCSAgICBETUFfRlJPTV9ERVZJQ0UpOw0KPj4g
IAkJcHV0X3BhZ2UocGFnZSk7DQo+PiAtCQljcS0+cG9vbF9wdHJzKys7DQo+PiAgCQlyZXR1cm4g
dHJ1ZTsNCj4NCj5UaGUgYWJvdmUgc2VlbXMgdG8gZ2V0IHNodWZmbGVkIGFyb3VuZCBpbiB0aGUg
bmV4dCBwYXRjaCBhbnl3YXksIHNvDQo+bWF5YmUgaXQncyBiZXN0IHRvIGRvIHRoaXMgaGVyZSAo
Y29tcGxldGVseSB1bnRlc3RlZCk6DQo+DQo+CWNhc2UgWERQX0RST1A6DQo+CQljcS0+cG9vbF9w
dHJzKys7DQo+CQlpZiAocGFnZS0+cHApIHsNCj4JCQlwYWdlX3Bvb2xfcmVjeWNsZV9kaXJlY3Qo
cG9vbC0+cGFnZV9wb29sLCBwYWdlKTsNCj4JCX0gZWxzZSB7DQo+CQkJb3R4Ml9kbWFfdW5tYXBf
cGFnZShwZnZmLCBpb3ZhLCBwZnZmLT5yYnNpemUsDQo+CQkJCQkgICAgRE1BX0ZST01fREVWSUNF
KTsNCj4JCQlwdXRfcGFnZShwYWdlKTsNCj4JCX0NCj4JCXJldHVybiB0cnVlOw0KPg0KPj4gIAl9
DQo+PiAgCXJldHVybiBmYWxzZTsNCltTdW1hbl0gYWNrLCB3aWxsIHVwZGF0ZSBpbiB2Ng0KPg0K
Pi4uLg0K

