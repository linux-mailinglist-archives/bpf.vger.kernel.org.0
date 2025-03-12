Return-Path: <bpf+bounces-53907-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7B4A5E208
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 17:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52436189FC69
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 16:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100A923C8D8;
	Wed, 12 Mar 2025 16:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P22azg/A";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YKLIoOCY"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A6D1D6DBB;
	Wed, 12 Mar 2025 16:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741798271; cv=fail; b=WxMPfJxZrld7WKkCNnEdmQSrC3sGPouBMG+hY1sgHGVaLlRXwodLD0rqiDov7JdK8IeDKwXPKrCOdA871KNjCh43s56ZzXhxgpnZ5ieDiTITOZfA9BmFJ8dFx3eZ94stKzsi0tRNgxahjHbmi5w+yxZPb4pRtjSapA3vLDQNg0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741798271; c=relaxed/simple;
	bh=ovX9+b8U7Y0E9U9mLGGxgwQvDUEzjKpl+hwRyrQax+g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qKqOxo6Qz3OI69Y/a825SXeRwWp3dT2pKFT/fv22gkcQfjzmXZXaFQ7lcrMT22CuB9xmTBnlnX5P+Ne+slC5lH6r1uIeLWz1fT13TzIs6DNkYhC+G+f7FJ7i14qQkeokUSPX2JKMtD8FXSz5Uu+FjnZHB8DWqRr3iGmz8hAWucs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=P22azg/A; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YKLIoOCY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52CBoa2D024759;
	Wed, 12 Mar 2025 16:50:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=+P/VgRQzuhVIHe3oFkO7sQFnpiUlcXXH/xnp+ig35kQ=; b=
	P22azg/AZ2FvY3lItpkcqrqC12KWco7AVP6fSJhAZKSb0U6gjU2OV5MyTlOGs9Pc
	ejDqGy9KwjB8V0cd5GkqmrU1sLvUcjDqY7rSO++601kCgj8ByRskBGPx9N/zc1pu
	LAihDvBuzOJbtGMFswvofYkvY1GmF90fdzXfI6rVBIHDG1cCie8ev0DmqVCjbfLr
	dm+sq3Ndw1Drn1bQ2OE20UxgyJEZfO4mY01VtUXhL9MQYrx70Tk/yDpUixZU9lBS
	9Osf+AaH/DnxkkjtlkgUZWllisSNVOY8ZC0Ux+Oqf6b3og7EExkJqhCxSw/xnTE9
	K/P723Y88V0n0gcarbd5+A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au4dt94s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 16:50:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52CGMZj6022278;
	Wed, 12 Mar 2025 16:50:48 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45atmvgnns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 16:50:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ci3iV1xwFw90c6m2b6mxQ68Pr30u8FHMyUHGdhGGDWcNcPtADVovWPpUSLrDucAu+svsbDbRtKFrIjTnVr11hstyVlR8SKHt1r1Q8yBNhaf1LHYIUUSjJzytQTXmcybvF4QGBOHE65xmUV7qnZy7K4XZUm8UacAo9nMjOr7MqIpB2nOUCboC6czyu14iedYnzS9zQ7lUAp+48gU36IyDnTvL3gjyWOCxNbI+Kn6yjhogp5/M+kdneuhV1Fa43WCRMDUWT5DsMB14d/mh/69pzqXGftw3YyrCYEFrQtghPZOtSP1URTcg+wqHnpADHp3ZMAUfBaCzdxlr0qOmE+kKkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+P/VgRQzuhVIHe3oFkO7sQFnpiUlcXXH/xnp+ig35kQ=;
 b=IqVN4083lUYtzvSA2iyFo3fyEjoAUqNEIjfc+yjQFy5z6/D+Naupvycg0u9PID6IPnEu7cGttthQpEOy3IxsWEfoS35mM6o2+JMqIkDiB78LKuVJpOIWLxoxtS7ZMUNOgi2OBHyHPoLL5kVa5iGrzp9Q4wpyf6UdjJXcdiY5Nw8hdvqH0mCTHMTaNJaTNislyw3poizUTEggw2/xUBCe6wqJgdkeB2IKFSNioF7JjW/dauf5fMoASMIOxdW7KLfnqBWOpSPgUY8GA8/p8HeV2r6cd2XIdXl9dVAi/F3b23kH8F79AMCNaP/COZj/0ASVoahiVCLDSGSlhuCfRZC7NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+P/VgRQzuhVIHe3oFkO7sQFnpiUlcXXH/xnp+ig35kQ=;
 b=YKLIoOCYEJcTTCAS//B1CDLJ9SV7CtTrK7hDDEVbNVluAMXfs9JLM7stM4Fe6SMDNBflzsvkQWww2N238d/+aqH6aKHma/pnnF461gZE8ij7TBGSPPebJ6seVCHAKDl2eYWtp6moLCoDt3sdsBccjmGf+VpnpScURO7BBRxqgWI=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DS7PR10MB7155.namprd10.prod.outlook.com (2603:10b6:8:e0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 16:50:45 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 16:50:45 +0000
Message-ID: <2a2e5e68-5a74-487d-adb2-5e46911e160f@oracle.com>
Date: Wed, 12 Mar 2025 16:50:39 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves 0/2] dwarves: Introduce github actions for CI
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>, dwarves@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Song Liu <song@kernel.org>, Eddy Z <eddyz87@gmail.com>,
        Jiri Olsa <olsajiri@gmail.com>
References: <20250306170455.2957229-1-alan.maguire@oracle.com>
 <a469919eb5be205dc9c44ee40566ea1ae2bbc757@linux.dev>
 <CA+JHD929w2i8TsEZUHqoMsmJ20-OF5C6ytHng0UobN2W0ptmag@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CA+JHD929w2i8TsEZUHqoMsmJ20-OF5C6ytHng0UobN2W0ptmag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM9P195CA0006.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::11) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DS7PR10MB7155:EE_
X-MS-Office365-Filtering-Correlation-Id: 0774141f-f42f-4fac-ca32-08dd6186089f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?LzhyRE9sdXV4WE00R2MrSTZFNEE4ZnRBYVpkMWZhdjdFTU5Vc1hjQ0NQL0dC?=
 =?utf-8?B?Y2xrRVhGMXkyMXh4ZXdKNHMrT0JIeTBsc1dDRlIwSkFVcFNjQWtCZXlCWnpM?=
 =?utf-8?B?RE8wdGt6Rmxlc1JDdktNYllXbTczYzJuYnJ3bUgzWENVa1M1RjF1RnNuakdq?=
 =?utf-8?B?UmhFMnpnTE1VZHdCSCtseDVyNXJzaEs3M3NWYnJYNnlsclVYWkJEZ2xRakRV?=
 =?utf-8?B?R2xoVFdpVWx2cG1RdC9lYXJBalE5bDhMSll6cHRpb3NTcE1KSGVHUmxydVVr?=
 =?utf-8?B?NHc3Z3k2UFowM1pkb2g4dEphUlVDekp0TklDTEdwbVFzWTUvVzZkRTNPRWpL?=
 =?utf-8?B?Z0lMd3BaM21BS2ptUTlqU3VnSURxdVR4Y2xPQVZScGh1WFVQVUUxT0ljS0FC?=
 =?utf-8?B?U0VjRXZQTVdqV1BWK2c3alZjT3d0Ry9UZHlBYWY5ZWdGdEpmSzB4WUdvSGFJ?=
 =?utf-8?B?ejFYbWJ1NEhkdFY5OU1jam1ZcXVpWlJrZW94dFlrVHl3MmtHVGJDM2sxa2g5?=
 =?utf-8?B?d3Q1LzNBWkw2Y2I3Si8yWkk3QVcyWURlc0N1K0hnWWZISTlPNXpWSnVFd0Ew?=
 =?utf-8?B?YW1wNVhIb1U0eEVnVE5BbkFLeHhuT2g1SlV4aU1JRXo0ZEIyWEwrUXl5TUpG?=
 =?utf-8?B?Rm12eG1wOVJhZndrSzB6QnlpMk1TMDV0M2RRVkp4clpZMnk1Z0Z1YmdYdnNi?=
 =?utf-8?B?UFlWMFZWaUxqOXo2UGpGekwycDBJSE1DQmdNYVZ1WHprVHpQTnJNUkg1b1ht?=
 =?utf-8?B?TTU3TGVqa0VNQVZ0aVhBVUhuSXBNZ0huS1FKdFdmNHdUbjVVd0JlaTlEbVRU?=
 =?utf-8?B?WGZiOVFIb3hBc3JGUVlYTGhxVzlWQUhqYXFtRGpxYVRLLzYvNU9BUmxJeGR0?=
 =?utf-8?B?S0JFN3ptUmhYVER5RFg0Sk5DNm8vTnJEb1RIWTdnQzJJTmlzbERQcDBOeE1l?=
 =?utf-8?B?VDJBZm1CbVZEUGhnN1RPOUpINWdQVWFlK05vSHpaa1BLTDRSYXRqUVBpWUkz?=
 =?utf-8?B?dlV0Z2tmby9LTEh2a1lyNm84d2Z6V1owajVEYTRTM0hMTXAzdDhqWHJsSlc1?=
 =?utf-8?B?MmFMYlhzRGE4aWlHcWsrWkliQWw1YTZXa01zeFhoVFVXdk5vU0o3dkxRZEJy?=
 =?utf-8?B?S3RVd2NCWGhWdEgreVgydFk1VXF5UFF1bjZYU0h5OEh2UkMyd0NzMUJiZDVs?=
 =?utf-8?B?MXVZZmRRNTQrZ25JTWp5U2FVR0dKZnU4VU1QRUlWaUJ4NzBucEZiYzJCWllC?=
 =?utf-8?B?OU01R01aQUsxQWlOazlFQ0FpOWk4Q1VyMzJucmdJT0tTU3dyN3QvVG1CTm4z?=
 =?utf-8?B?elRja0xtVnBBV282NlBlWGVBUi9GSHFTcUowbkkvQkVQVkZWVDVrWVZacjlh?=
 =?utf-8?B?US9rYjI5OTFhRVJ0aVZ6Q2JKZmIrTDJhYUVTWjM4SEtKOFJCQmlVaFM0bURo?=
 =?utf-8?B?OVFacTZ2V0J4eURlL0gyYjVzY2RmYnIyRkQyWG9KRTdJKzZPSi9HUVc2MEFm?=
 =?utf-8?B?ams2VUhMZ3haVE1ZRlFkdTdraWwxWVNiZ0ZFQmNwRjJqbHg1UHc1VXBna2pj?=
 =?utf-8?B?Y2RiREcxOUVlQmpjbS9TS1Z4U2JmQ2UyY2UrSlR2ckNyRzBvZVAxWER2eVNW?=
 =?utf-8?B?ZTZGNkt0M3pKUkRVU1ViTG1FWkFOTEtiNVRLNkJ0R1VrazlDSG5HWFBkYS9a?=
 =?utf-8?B?b3QrNU1ITnZXeVNWVC8vK1VsNGVmb2dSYnFDQlhpVlhpU0c3aUdXQk5TeWFN?=
 =?utf-8?B?UTluQ0d6a0s3TkFKRkF2VW5oTnBTMy9CQ09tWDlVbllzaE04NFlTWWxCSGZX?=
 =?utf-8?B?Y2J3YmYrR1pJTDBqdmFFQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RzlNTURMTlJHLzJzZWEzck5wMTVKVjYyQjVRTlBQM1pqc3lyR2htVGdMNko0?=
 =?utf-8?B?SnBydGt6ZlRETDRmNzRpbjRHb2FxbGU5RmFRbjFuVE1XSDQ0aXUralF5Tkdl?=
 =?utf-8?B?N3pZTmY1M3ZiYkNDcE5vUm03dFlJMVk1bWdVR0swaCtUa0pKZ2h3VkJqdU14?=
 =?utf-8?B?dWRGSU5ZZ29oY1lWUHd3WGZyTStZMzFTeUc1YU9TVzh3Qnl4cVJzeldDMW9w?=
 =?utf-8?B?c2ZzbXlSQnI3ZXVnUnRhTDlIVVF5eTQ4anZUWHdQeDZuZnJCaUZST1JYbElI?=
 =?utf-8?B?cyt0TThOMFVJS09NaUxnZEliVjdMbFMvM0lwTzlFUFpDaUNPY0YyMkFFbTRu?=
 =?utf-8?B?ZjVUZERJbkt4ZSs5bmhHMWdNNzdubStSalVLYUFqc2M5UmxJUkZuTzJTSTVK?=
 =?utf-8?B?S3BKdkY2Qm82TFA1TFJMbXd4U2VoRUJiODR0OEQ3VHV4Wm4xUWZEWlRTMUVs?=
 =?utf-8?B?WFJmcjVVTGs1YjJhSjE4c3hQT0JGYlFhVk9IR0xhK0w4N1h6S3VzSysvdTdL?=
 =?utf-8?B?RGFIM1JadlYvVEFNTVNRdHZSWmVGOUJGMWxsTVFpSXZsa3JhdTdNektuRit2?=
 =?utf-8?B?OGhqdU9qc0pDZ1VKRFB6dThpSUdHK2NRaWhnRUZ2cDdlM0d5YzFlNGpweE5K?=
 =?utf-8?B?dFE0UnM0bG1Ma3BKa2FicmZqVjhvUXdNaVl2WTVKYXU0VjBOUjJmQ2VUTS9u?=
 =?utf-8?B?dG43OG8xVzRIWkNOL0w2dHZ6NFZQYTVlWEg0UzkyZFV3RHphdFBubXZldGFu?=
 =?utf-8?B?dWhWV3R5YVZtZmg0ckNnelZVYXVSZE42ZDRmTjl2VTdIbUoxbkIwdllTb1RM?=
 =?utf-8?B?KzAvaDdsblR2ZWE1VFhlTFM4YmRVeFNBejQwRVZsS2c3YkdXZEYyajZMTEpa?=
 =?utf-8?B?U2VhaFRscWhIOWNUa1JtU3BsdE1PWDcrUVBXWWJtVk5NWks2eEFyN0NzVU9s?=
 =?utf-8?B?R2NCR09vRzZpVmVwTUdXeUQyNkR2UXRTT2tYeG9IZlNhVG1WUkNQYmI2M09q?=
 =?utf-8?B?R0NjRm1uTUFYTHpWL1VmaHNlWERwdXNyN2VISVRiUW9QTjBNVlZVU2RGRG1X?=
 =?utf-8?B?TjhzZmp2eFpPR3pNaVpUN3M2MEx6ZGYwaFZZNitnLythWDlyVkVOU1laZ2JG?=
 =?utf-8?B?MG5RRlkyVndSZk5oTVo2NFE0RENldGNtZkJaUnFLTXFjQUFGanRpbzJBS0E5?=
 =?utf-8?B?VmthYnU0QWxuMnl1bDJkZUw1WTVyeWhjWkhNVTF1OS9DRXFzQzI0em9RUEJk?=
 =?utf-8?B?Tlp6R3ZEZU5pUlROY2xZOVhwNEJod0dRaFBGWktGbVpiNGJIdHNseUZMNDZ4?=
 =?utf-8?B?S3g2c3hUSVBUS01EVFlJdWxVSGNnZW4yd295UmhaYUNCa0xuT3N2VnpWWHhP?=
 =?utf-8?B?dzI0aTZmdlJZQ2V2WlJzNE43ZmNWSy92bWtZUWw3bURiSTdHS0Faem1tUWts?=
 =?utf-8?B?K3dtOHBTUXRTYmJPWFZjU0dFdzN2QzRrMU42VjlqMVZTYnVyc3hGNFNrYWdo?=
 =?utf-8?B?NE11THJSSEcyUXVGekpOZ1A0UTMvdUh5QWJZV1F5SHpIb2RQNURFWDJHRlIv?=
 =?utf-8?B?V01yZG4vclpSRVNveUdhbTNwUHJuM1dIT2lmd2xhZEN6cDV4VmdWOUxteFJa?=
 =?utf-8?B?aUd6ZXRIb3kyY0dTNEhqR2ZDeGJabndFdU9GbEFSanZaQ1dCZjQ2VFVrV1Jt?=
 =?utf-8?B?OXBnbnhwRFNRYVRXUC9qSi9aU3laOFF3RDlVN3N4YkVRVklaVXlnNVQvK3Fi?=
 =?utf-8?B?QW5BaWczeUYrZDd6VEpLRjZUN3dPYWxlalQvU1laSHVKa0I2WUROQy83NVZn?=
 =?utf-8?B?bVNQZFh3WHU3WVRYU08rYm5sRzFPS2pkZDk4Y1FpbXlPTmdFTDVTTzRGTFh1?=
 =?utf-8?B?dWI0aEFvcnpERnhPSExGMVJvL3NJclduY3d1NnFKVjl6cGJQUHBDQVBOM1dD?=
 =?utf-8?B?UjRXckdBSm8zaXBXeURXcWlheGhqWnl6Smhjak8vbWZpOHFURkM0TmNtc1JY?=
 =?utf-8?B?UUI3cFZvR0F3WGpqMWlCYVdqMjJ3U3hmSmFYdWxzc0JiWjl1SHFzMjYwNUs5?=
 =?utf-8?B?RFJCMVg1ditrSHRCSW5EVS9jRDdLdTBlTjhWb3FLNE5wWktYaXJwZ01ZS1RZ?=
 =?utf-8?B?L3RtaHU3TjRpaWc1bXJpOGE5Z0FUQkhCN01jSDVWNzA0clJMTjlwTXhBOUVE?=
 =?utf-8?B?S3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3scKi/yHvQ6WNOoQN/Nxf8vGQNFJD3PXEppbhNA5blWVNiwVuk1dDvda/XokOk+mKvKRi4tt4B1VJRsWzIQqHsua+NxfNtN8dhXYKUtmyS8lT8CaBlJgBtjDZklDCyBCoRnmgffiHVT/9czUspDuqe4D+nEV+hh6yZcgo+eraApotryTWsTFFDzrcHpcNnImaC/qqsls0Cyf43+xcz+DHIHCaMLBffW8r9yKYvHP+ZMzx2tn8OJsqcmDEZIeYG0llhLP6QZy90UrzJmoI14IeW1rPN25mr4Uk32TPM8CRCzdsxL25SUhHfDxMUAP2BwR5lIIEHlu+Vys3f4KbBjFXXu/xfJuk9nO70AiaP7U0kux41AgQMvoYTSHLwjTa8TTrwJFrj9qg5aTfMW7A2Ftoq8nH1MBLgbbWFU2UWMQ5nzUd9ZTCkfyg3Td+OTbbpBSFmC/OgIBRg7AJetfQ+lT1bmc443Fobh3BpUT/i4KxyXCukQPNNWA0cAPJtip+OXkB6RkfyAH6u98XLgk6+qzhP91kHCv3boX3Qm4jO1EeJjIQnuTQuoTu5hr1eVvLgpo/Ak8rbTxH4HK6NDBiveUKA4yeTKJAXtrGI5FxKPvWbQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0774141f-f42f-4fac-ca32-08dd6186089f
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 16:50:45.6011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E2k8pNdjHRkGjerEQnO/wL72IRx0rkXDNLgcmb70NcWTlbKV/F9pyDs752jvsgDMyZMFfG6YSPSLvLVNBwcFmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7155
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_06,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503120115
X-Proofpoint-GUID: rxdyxzUMvABv-tN62Dc41vccvMqeo4iJ
X-Proofpoint-ORIG-GUID: rxdyxzUMvABv-tN62Dc41vccvMqeo4iJ

On 06/03/2025 23:45, Arnaldo Carvalho de Melo wrote:
> 
> 
> On Thu, Mar 6, 2025, 6:14 PM Ihor Solodrai <ihor.solodrai@linux.dev
> <mailto:ihor.solodrai@linux.dev>> wrote:
> 
>     On 3/6/25 9:04 AM, Alan Maguire wrote:
>     > libbpf and bpf kernel patch infrastructure have made great use
>     > of github actions to provide continuous integration (CI) testing.
>     > Here the libbpf CI is adapted to build pahole and run the associated
>     > selftests.  Examples of what the action workflows look like are
>     > at [1] and [2].
>     >
>     > Details about the workflows can be found in patch 1.
>     >
>     > Patch 2 fixes an issue exposed by the dwarves-build workflow -
>     > a compilation error when building dwarves with clang.
>     >
>     >
>     > [1] https://github.com/alan-maguire/dwarves/actions/
>     runs/13588880188 <https://github.com/alan-maguire/dwarves/actions/
>     runs/13588880188>
>     > [2] https://github.com/alan-maguire/dwarves/actions/
>     runs/13588880200 <https://github.com/alan-maguire/dwarves/actions/
>     runs/13588880200>
> 
>     Hi Alan. This is great! Glad to see you're working on it.
> 
> 
> Indeed, having these tests in place is a really great development.
> 
> 
>     I haven't read through the changes yet, but I already see that most of
>     the CI code was copied from libbpf. Just want to note that you might
>     not want to reproduce all the workflows from there in dwarves. And
>     also there are inconveniences with local actions and ci/managers
>     etc. I think it's worth it to try and eliminate as much of that code
>     as possible, given you're starting from a blank slate.
> 
> 
>     If you haven't done so already, you might want to check out "pahole
>     staging" job that I tried on BPF CI infrastructure some time ago:
>     https://github.com/kernel-patches/vmtest/pull/330/files <https://
>     github.com/kernel-patches/vmtest/pull/330/files>
> 
>     It's a bit different from libbpf, as it reuses BPF CI workflows. But
>     you might get some ideas there about simplifying dwarves CI.
>

Hi Ihor,

There is a bit of redundancy in the way things work currently alright in
the vmtest workflow [1] since it uses libbpf/ci/setup-build-env@v3 to
set up LLVM etc and also builds pahole. That latter step isn't needed as
we are building pahole ourselves later on in the workflow in order to
test the current changes. But aside from that the only other libbpf ci
operation is getting the linux source via libbpf/ci/get-linux-source@v3.

In the case of the dwarves/pahole workflow I wanted to concentrate on
the steps that I normally do when testing changes: build pahole for
x86_64, aarch64, build a bpf-next kernel with it, and run the dwarves
selftests. BPF selftests are already covered by BPF CI and thanks to
your work we get pahole testing in BPF CI when changes land so that's great!

The build workflow could perhaps be simplified a bit, but I wanted to
preserve the value of having a matrix of toolchains (clang/gcc). There
may be more efficient ways to achieve that; hopefully we can evolve the
workflow to be more succinct in the future.

> 
> 
> I'll try to take a look as well.
> 
> 
>     Another question is: are you sure about merging CI code upstream? Both
>     for libbpf and kernel-patches/bpf the CI code lives independently of
>     upstream and is synced from time to time on github. My guess is, it's
>     because .github code is unlikely to get merged into the main Linux
>     tree (which also makes sense).
> 
> 
> I don't see a problem on having it in the pahole main repository, to
> stimulate adding new tests while developing new features, no?
> 

Yeah I think we're less constrained as we're not a kernel tree, we are
just hosted on git.kernel.org. Arnaldo rightly pointed out we should
have some instructions for how to trigger actions and use them to test
changes; I'll wait a bit for additional comments etc and send a v2
incorporating that (into the toplevel README perhaps?).

Thanks!

Alan

> - Arnaldo
> 
> From smartphone 
> 
> 
>     >
>     > Alan Maguire (2):
>     >   dwarves: Add github actions to build, test
>     >   dwarves: Fix clang warning about unused variable
>     >
>     >  .github/actions/debian/action.yml | 16 ++++++
>     >  .github/actions/setup/action.yml  | 23 ++++++++
>     >  .github/workflows/build.yml       | 37 ++++++++++++
>     >  .github/workflows/codeql.yml      | 53 +++++++++++++++++
>     >  .github/workflows/coverity.yml    | 33 +++++++++++
>     >  .github/workflows/lint.yml        | 20 +++++++
>     >  .github/workflows/ondemand.yml    | 31 ++++++++++
>     >  .github/workflows/test.yml        | 36 ++++++++++++
>     >  .github/workflows/vmtest.yml      | 94 ++++++++++++++++++++++++++
>     +++++
>     >  ci/managers/debian.sh             | 88 +++++++++++++++++++++++++++++
>     >  ci/managers/travis_wait.bash      | 61 ++++++++++++++++++++
>     >  dwarves_fprintf.c                 |  2 +-
>     >  12 files changed, 493 insertions(+), 1 deletion(-)
>     >  create mode 100644 .github/actions/debian/action.yml
>     >  create mode 100644 .github/actions/setup/action.yml
>     >  create mode 100644 .github/workflows/build.yml
>     >  create mode 100644 .github/workflows/codeql.yml
>     >  create mode 100644 .github/workflows/coverity.yml
>     >  create mode 100644 .github/workflows/lint.yml
>     >  create mode 100644 .github/workflows/ondemand.yml
>     >  create mode 100644 .github/workflows/test.yml
>     >  create mode 100644 .github/workflows/vmtest.yml
>     >  create mode 100755 ci/managers/debian.sh
>     >  create mode 100644 ci/managers/travis_wait.bash
>     >
> 


