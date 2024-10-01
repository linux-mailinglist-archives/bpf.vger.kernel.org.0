Return-Path: <bpf+bounces-40718-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5F798C84D
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 00:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28CA5281DAB
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 22:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F551CEE9A;
	Tue,  1 Oct 2024 22:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AmrBvzP3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uuLiatbC"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEA119CC39;
	Tue,  1 Oct 2024 22:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727822174; cv=fail; b=YPCg8cRLRfha67qrUNJRdJdmTNa48cUq2nZ4XRXk5xJwH2h33+lYe+vpaOPRyCZ+pW+OIor+duj8bZSC33czZuyM7IytlOaKdh9hhLY98CAjfiwYECucqrq+PyxpoO47N70r22vObzal5Ex3chvT3qxJdqSrJ2FaDGGqU1MZsDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727822174; c=relaxed/simple;
	bh=3yWvj6TXBfesFFsgnCo7KYWZkkOeyqg7cW7R2nryQ4k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=jl5enlroo0i07fA5a0EvfbxjQ40bdXz3vrMUnQ8gxwBPpxwB42A1rkUgwdUD0tprdB0NTGjpuVW9Te3CeR3MxGepMgUVpJXIP9D9vVdY6PAr6Fm5BBFkVLTp2BLctMsWGHonrhN0qEB7S9vXJ8tgZ2i+5NCpgOU1SV9tptaebEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AmrBvzP3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uuLiatbC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 491MMcv4009812;
	Tue, 1 Oct 2024 22:36:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:in-reply-to:references:date:message-id
	:content-type:mime-version; s=corp-2023-11-20; bh=1smrrblDgQYaEB
	u88O9vp2GI6SBOQYzm/SoqvNOh9+w=; b=AmrBvzP3jglWkAiT3y9RXVYsacfcQa
	z0dlJGZdUGUQO5jZqBQKFrrbvdsYN1mDLJ0PTb5FWUqnPjXFKPns9dFo1fvujgna
	P8T/HBoZ68Imh40Y8lNOZO7PVBuroYPYUyGQX/nRrMqyZZcVkMbAmerqwMrB7ex4
	fj8TsXBbVTcVn3jqhxaOpswWM04oNrjiKXN9caxu2L5jNvS15Vt1yZfhwkdT8rJO
	3dFRGJkXUGBulpIQHZ4RYzwm1G17cNpIFOe34iFBXcr7xWeovsyvajtibhXvoYuW
	UYNTzma2gWmT6xdurqIeAwS2qxNHfmbyJgRPxOqjI/34jmZeBIm5oiRQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x87d7fh3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Oct 2024 22:36:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 491Ke9VE040820;
	Tue, 1 Oct 2024 22:35:58 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x8885cy3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Oct 2024 22:35:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hRIA87zs03or41Ff3o0D6bB8Z5STQbR8eBk5KRrzi+GG39eaJXKh2DwY3fgRo7UbjR+y9Av0bsnvuxh18nFAT2al0EQG5t3lPHhAHBVuEt+ST9YKPtrZ1JnC3db9B5niKytaSQF5V9hNRRkK2IsVy4LjcRFBxHFgyDbTGh9urZr6v5IxQUrFET4bDaPK0DYYIZVuaqtUquLB2XqUw9IrbksFi9IjOfJ43b4QoOEcclexM8iFlWwfvwq0MlpcgADhyL+TOFNOdJbxWcley3jqblahIyN/r9sdyW6tSGsiD8BKLwMHg1PMy68cFOukB6hlk820YttQF0zbDDOWvhgdHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1smrrblDgQYaEBu88O9vp2GI6SBOQYzm/SoqvNOh9+w=;
 b=Gbo9c+FX7jT8hwhWYMIxvl8/XXgRmVdKw+eJq12z+pvDo7Dwv6jCiODqta4e6vsdmdJvWFkI5UnaXqRIYKqzV/jcv8QROPhskvdfu/CO7bH0/cnU+xMtM5kUXTt8XxL6CYGYkgX24nFkjE/lBSx9lCzz4m/NC5Uv+lJLT4WFZkAP5SPmw0iomS2j+j1cn1OzIaygCbOwnTIG+lvJx8VLK7aipF1L0+Y/Ekf+RbU3uv7EcXhZYnhL3IApAplAKQBPcDNGIF+roF6aRkznXtymObD9jidEkksCvvTBE/wUDLQqjnFJS0grwEInIX4ZZl52S9RL5ZXTJqpJKvSpekb/Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1smrrblDgQYaEBu88O9vp2GI6SBOQYzm/SoqvNOh9+w=;
 b=uuLiatbCcd7uiKgS1pXFjeXcgj5ImNjvNmwQ8tDwCUeq5yLGrDdEv78lX+kvqrftaGe6Xeha3f+TYwXkl3Xo1zA5w/gUGHlFuQ4gVlITPAZlRkNpg58DRoE1CYQN2M+GoexBhpQinCMePKGFeg1i3BeHWXd/2HM7d6aCd+qL5F0=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by CH3PR10MB7435.namprd10.prod.outlook.com (2603:10b6:610:15c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 22:35:55 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%3]) with mapi id 15.20.8026.014; Tue, 1 Oct 2024
 22:35:55 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: bpf@vger.kernel.org, dwarves@vger.kernel.org,
        linux-debuggers@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCH dwarves v2 4/4] btf_encoder: add global_var feature to
 encode globals
In-Reply-To: <ZvwQR_LFnjxQNPIY@x1>
References: <20240920081903.13473-1-stephen.s.brennan@oracle.com>
 <20240920081903.13473-5-stephen.s.brennan@oracle.com>
 <ZvwQR_LFnjxQNPIY@x1>
Date: Tue, 01 Oct 2024 15:35:51 -0700
Message-ID: <87a5fnmoxk.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0876.namprd03.prod.outlook.com
 (2603:10b6:408:13c::11) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|CH3PR10MB7435:EE_
X-MS-Office365-Filtering-Correlation-Id: c54062f6-07f3-4606-0d54-08dce2696957
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uq3KfBm3PvUxyDiYrPUtcwpJyYvN+QPJXKMGf/zItQBsiNK71M5WrUkDtd+p?=
 =?us-ascii?Q?truBDmKhj0a+cmH3fxUpMzvijDB97UlPMfvxwt8K+fBXimahyerZp35ArKEP?=
 =?us-ascii?Q?PLOFJExFs+zqedin0bpJTxgQbldTwyqEzl0RvJ+Ce3+R5edjJPBV1yEXiTwG?=
 =?us-ascii?Q?e/KD/hDrShdQat0VzPnS4iOApKyphFR6UFFtteSoQCJPfV+7lbU06Remjv1v?=
 =?us-ascii?Q?9fhvHoFOErkRu4bR9nzz9kHwSq9l3nVgfnFJoBcFVekwNXSNXwAHhbMZFXWn?=
 =?us-ascii?Q?O4mmEvX1N0qIwboWnfMiAh6B7c4Vbl3Rchc0L0tJD6KWndplqxLE1SipDBT2?=
 =?us-ascii?Q?TqV+RNbMYpxIENFtz/AxFBXaSuXZ0uPF2NfRZe8ECtzrTSNV1FFIpkRJFVgY?=
 =?us-ascii?Q?+y00HxR/KySqLZ0lxjgYk/DI7gBPvu6Tn6j0pGTG/EDxSVIpUGl4Qspv61KJ?=
 =?us-ascii?Q?rkNpjFgbC8dZGXEQjfq/ADl2yugQ+/Au4plx0xCRN6z5GXzl8CmSBwSdIr7j?=
 =?us-ascii?Q?L6Wlj7b4uGA9Y99/kCynRrvoCsBYHTP3VcNBD3mBEw7g2+aB5WFRHGMaQRWs?=
 =?us-ascii?Q?3y4cHIlEJd12u5hoxoEZqTar12cdcg3EBXHS6Ca9eCw8usuvfAMCgG/wVB20?=
 =?us-ascii?Q?+D0UTs0iN0DHgDuinC6r+upzyHJYpsS1nO4baVRW/liiELvtWp4W+VwV0Cly?=
 =?us-ascii?Q?34PYgM2Iilo6zgHfwq91cXK4DQkZ+33Jaa9oWpPdHjGG55yttjmRYFSoK+Jr?=
 =?us-ascii?Q?S5GOF+a9X9gTPrTx+149oDp7Lky0RhSftaFsGZEQKsKFQxbXyQdX7h6pwQKQ?=
 =?us-ascii?Q?II/35oXa64g0ANM/TaEXDV3N3k2WM6Ns/EUNuzS8/EHgbvx0R+HrBJbgdMgm?=
 =?us-ascii?Q?p3VcgPxmoak/zwUMNpOcxHQB8IrMZwJys7sa78tz8QhC9RXN/PGf+c/hbCv8?=
 =?us-ascii?Q?9CbHnd7jIfQwrPcZT9xqJdwAqEyoOQ1oyjESHLi1587KaZr9Nj0T/a+Q+WK6?=
 =?us-ascii?Q?9+yObfR+1rj/qRWrAenyOsmq+lcNgzz8y6v7EIsMgqvfAFIYdhSEbOFHmbU6?=
 =?us-ascii?Q?pWPjsMsRE7zOJXBLWvlrUQ/1ATxnKPER0TtLytTWts95KZyCtCxS25qtyYjP?=
 =?us-ascii?Q?17ky0+pNzwd5R2D/grmR0vrivUCjxB7d65cp0qp074k2InEgnVauiSvx4ez+?=
 =?us-ascii?Q?SJr47l1/34tk4eOL6Bzx+lMYFZjENPy1W1np4zoVP1bltCj9TO34n0X6rQuH?=
 =?us-ascii?Q?VfnqtQJvdvTk7e/Ix5SCRQ2TCpKm3eILbIQ+9J90gw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6+6ROWu/VxhagokFfto4/zC3bP4uWAiR2dt/fAJV2z3Wb3cgItmjTvHE+yeJ?=
 =?us-ascii?Q?7z0zNP/tu45Mrgf9kasbkgLNh3wVP/lDnBnPHl35lEbBRPOm26CnD6lshE12?=
 =?us-ascii?Q?wGff07NzrP5yiZKKmynl+vEZoku8WcKR7nG732IbPjLC5Aau0Y4xn74DcXo+?=
 =?us-ascii?Q?JFm0NmJmq/49kLCTWyfwDWb8SVQmsNX0IzaUF7CWrgM+2I/Dm8nTdiB8o76S?=
 =?us-ascii?Q?6agqXUhAIr/gP6mcB2jPcJpubovtQnDCrCqe/UeqwzrQ6WJs39+ugU4vUsIj?=
 =?us-ascii?Q?k4AjGxIYIjTM1Q/yrCL7rR9OFNP5Qd19maEiyQZI1vRQPcvXDJizj+7T0AoD?=
 =?us-ascii?Q?kQSgtO1HgK+M3a7XxC92v4GW8Z/cisPxu8Cilkz8IJSX0C+/9Vvk3BVsJf80?=
 =?us-ascii?Q?ZUWmnvfSUiKFgkmAih/NQzXezqtrDIO9gjm/S1MNVMwyJGNWNsEhxOOnihE6?=
 =?us-ascii?Q?ZOSHilK2QWm+gUYGAurPBxgGmEPEOrmXzgCYD+qxc5GFxZpb2s2+/jn0hab5?=
 =?us-ascii?Q?QKwyyiLpv6GPKB8KZiSz9fnomPeYvq8VEjZMFxqc6F1+MT+sWq1v3MHGYFmE?=
 =?us-ascii?Q?pIlV9scjP+CRN72kkxvr0dItQJTy5ObE7JU5z/2IRkrUHZRw97Ce4Cshw1f3?=
 =?us-ascii?Q?25JrKVoJfADgypUUlu8q3Onw22wRmS43RTORCKYD9zypBoX7DAkq5R9mLAnv?=
 =?us-ascii?Q?sDNXqnlpn3R95co3cOJlx2bGMBntHqbxZEpv/CSTPYkJyenSXwGGrhneAhDW?=
 =?us-ascii?Q?fJ317Dm0v5N8kM0w7wAq/XAPmvkCYVGGgdMGbwsOE7syjCC/5E3kgl0CKbxH?=
 =?us-ascii?Q?8Fy+GTFfsxE6zW/j+Mg331pYmOwGvaym8nkiNCTRdYcIJ2eVFQk7lNwP6P1z?=
 =?us-ascii?Q?K/tQ67xq+ykQgE5U+p0U6VnWBNnEzuy6oM3f9+YLzTf07v75WITxQ74UB4Y8?=
 =?us-ascii?Q?DXrTTlLb6kcLd/lBeAgI6q1doqr2bjWSPLrpYFn3pNZqIZr/VGXsiS9SDIhc?=
 =?us-ascii?Q?viMKTZQ6eyI+b08MM3fa2e1+/cBKa4F4l3vKmU8VI7hnMepOqoPnVf5cM5tJ?=
 =?us-ascii?Q?4H4PPRN5TecJ3De7mDYYTJw7r0N3ixv7U6DtdKoJNbon1R4TXmOnd52StUXp?=
 =?us-ascii?Q?mv1fb1JVJ6jD4Q4TQUSqj3a7TFYrB9pAqixBG+QWd61Nve3sH7T2+p4gFYad?=
 =?us-ascii?Q?Wugs1DotWC1audNmniPQJtIXJv9QLCA8A/tDOiXDjga/COP+4AvbRLHsHll0?=
 =?us-ascii?Q?R9hzEXFjSx9/Cy+csjzA0DPPl12GB2Wj5XmLBQBnVT6ws7oqtXN4NzLRcvHn?=
 =?us-ascii?Q?t8KIclj4ywOl5DK81/JFmifRRuzhbUWJ8lFHtItKCzikXub8zpYmfrTB5lhj?=
 =?us-ascii?Q?pHIsIf0Gz81IAo2LqUgS4QjHjO/+vS5GEoBsWdQZpgrm9hKNHlPmOmEOhOqE?=
 =?us-ascii?Q?7Ovff8yELB88vZoh42R4UKY+nwJNmjqYCCAUE2KYdq7+aZMNHIb4xdejjlHL?=
 =?us-ascii?Q?UCEQDbHaKYO1a4tNWZZ5fSA74je4eaPJmXgd+I0WM7z48LLWbF/fBagWYXxu?=
 =?us-ascii?Q?urvm1cmTu9w4c8kfDDSdYGMXjNToxZicTBGP+RfnnQASI9sIYYUR3BmLOIZp?=
 =?us-ascii?Q?IO79reKdVU7aN24AKuIcuFY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0TlvAmc3uPqL1h3FwZhV9XZFDoc/ZFJNXpLH+xlxe+7P4yS3jgk5G2VfITEH8KpWkuJXYRNCLFA8yBHwBPdcBLqo74Cjk415RoeuT7rnBusgsU7pEjPmtZYkS/1EZb2Bx2fndhDp8GeSRJQ3XAl6wPkCSz8piOBGw3JKpeRkICGzUwrx6BeLlfMw+vol0EHs8+gaytnDEi2iCFdZXcQZdRfPdGmJoEWhyK7fzNnXQpZdXfGZMlQsE8ZwkwYhg9b2LZmZKXc5MyASu6gZjFuWzdD++/uV3Ip8wF9fJiCgJhcRd84GIS7IFAt1oiZtl9er87pIIAL/5kr7ZhTmlcpdJHMcNiOlCihc0Q3XVB9HK6wIzSCJyC29Rrh7/I7BKdGXpctSXaTBxyF6rvMH2QBGJhpdLUZIdpxPHByqiy8B9IqBjWOSqFdpf+k+30ZTwvPWnBmbaLMSLqfuwLY2uC7B8yReS21ZReG3irlmfS1J8GbErx6CIUfNko9uIDAjyla/JFbMZSYq/PH5TXkmrnU7EdEFC7YoNxpQPctbWOZQocmFFNIoajo0/idlNi53Uq80oO4q6ItQWeSobW572tmHFguREmTXd9JNc9hwYzLQDPs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c54062f6-07f3-4606-0d54-08dce2696957
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 22:35:55.0219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u8ZzMCenuNuOADKCmhcNcri10os8e5U9HIfeeJevDdt9gR041X3yU1sW5Xqj6GZIsOyLFjrrubIg1b08glhtOMJc4o0j5KV6h3/1D6KLyxQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7435
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_17,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2410010149
X-Proofpoint-GUID: XylPVvbd3qln6xPFB-iTy9ZUxmJXlR7x
X-Proofpoint-ORIG-GUID: XylPVvbd3qln6xPFB-iTy9ZUxmJXlR7x

Arnaldo Carvalho de Melo <acme@kernel.org> writes:
> On Fri, Sep 20, 2024 at 01:19:01AM -0700, Stephen Brennan wrote:
>> Currently the "var" feature only encodes percpu variables. Add the
>> ability to encode all global variables.
>> 
>> This also drops the use of the symbol table to find variable names and
>> compare them against DWARF names. We simply rely on the DWARF
>> information to give us all the variables.
>
> I applied the three first patches to the next branch that soon will move
> to master,

Thanks!

> but the last patch I think does too many things and ends up
> being too big.
>
> For instance, you could have done the btf_encoder->skip_encoding_vars
> transformation into a bitfield in a separate, prep patch, also you
> mentions "this also drops the use of the symbol table", can this be made
> a separate, prep patch?
>
> There was a conflict with some new options I added (--padding,
> --padding_ge) and I fixed that up and made the series available in the
> btf_global_vars branch, can you please go from there and split the last
> patch into smaller chunks?

Yes, and thanks for staging it all up, I'll work from there.

> Thanks for your work on this! I noticed that this is not the default,
> i.e. one has to explicitely opt in to have the global variables encoded
> in BTF, so that would be interesting to have spelled out in the chunked
> out patch that introduces the feature, etc.

Agreed. While I wish it could be the default, best to keep it opt-in so
we can explore how best to integrate it. I'll be sure to document it
better in the commit body.

> Also since we have it as a feature and can ask for global variables
> using --btf_features=global_var, I don't think we need
> --encode_btf_global_vars, right?

I had included the option because most of the other BTF features had CLI
options corresponding to them. I couldn't tell if that was desired, or
if it was just for backward compatibility. Sounds like going forward,
BTF features don't need a CLI argument so I'm happy to remove it.

Thanks,
Stephen

> That will also make the patch smaller, and even if it was required, that
> would be something to have in a separate patch.
>
> - Arnaldo
>  
>> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
>> Tested-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>  btf_encoder.c      | 347 +++++++++++++++++++++------------------------
>>  btf_encoder.h      |   8 ++
>>  dwarves.h          |   1 +
>>  man-pages/pahole.1 |   8 +-
>>  pahole.c           |  11 +-
>>  5 files changed, 183 insertions(+), 192 deletions(-)
>> 
>> diff --git a/btf_encoder.c b/btf_encoder.c
>> index 97d35e0..d3a66a0 100644
>> --- a/btf_encoder.c
>> +++ b/btf_encoder.c
>> @@ -65,16 +65,13 @@ struct elf_function {
>>  	struct btf_encoder_state state;
>>  };
>>  
>> -struct var_info {
>> -	uint64_t    addr;
>> -	const char *name;
>> -	uint32_t    sz;
>> -};
>> -
>>  struct elf_secinfo {
>>  	uint64_t    addr;
>>  	const char *name;
>>  	uint64_t    sz;
>> +	bool        include;
>> +	uint32_t    type;
>> +	struct gobuffer secinfo;
>>  };
>>  
>>  /*
>> @@ -84,31 +81,24 @@ struct btf_encoder {
>>  	struct list_head  node;
>>  	struct btf        *btf;
>>  	struct cu         *cu;
>> -	struct gobuffer   percpu_secinfo;
>>  	const char	  *source_filename;
>>  	const char	  *filename;
>>  	struct elf_symtab *symtab;
>>  	uint32_t	  type_id_off;
>>  	bool		  has_index_type,
>>  			  need_index_type,
>> -			  skip_encoding_vars,
>>  			  raw_output,
>>  			  verbose,
>>  			  force,
>>  			  gen_floats,
>>  			  skip_encoding_decl_tag,
>>  			  tag_kfuncs,
>> -			  is_rel,
>>  			  gen_distilled_base;
>>  	uint32_t	  array_index_id;
>>  	struct elf_secinfo *secinfo;
>>  	size_t             seccnt;
>> -	struct {
>> -		struct var_info *vars;
>> -		int		var_cnt;
>> -		int		allocated;
>> -		uint32_t	shndx;
>> -	} percpu;
>> +	int                encode_vars;
>> +	uint32_t           percpu_shndx;
>>  	struct {
>>  		struct elf_function *entries;
>>  		int		    allocated;
>> @@ -735,46 +725,56 @@ static int32_t btf_encoder__add_var(struct btf_encoder *encoder, uint32_t type,
>>  	return id;
>>  }
>>  
>> -static int32_t btf_encoder__add_var_secinfo(struct btf_encoder *encoder, uint32_t type,
>> -				     uint32_t offset, uint32_t size)
>> +static int32_t btf_encoder__add_var_secinfo(struct btf_encoder *encoder, int shndx,
>> +					    uint32_t type, unsigned long addr, uint32_t size)
>>  {
>>  	struct btf_var_secinfo si = {
>>  		.type = type,
>> -		.offset = offset,
>> +		.offset = addr,
>>  		.size = size,
>>  	};
>> -	return gobuffer__add(&encoder->percpu_secinfo, &si, sizeof(si));
>> +	return gobuffer__add(&encoder->secinfo[shndx].secinfo, &si, sizeof(si));
>>  }
>>  
>>  int32_t btf_encoder__add_encoder(struct btf_encoder *encoder, struct btf_encoder *other)
>>  {
>> -	struct gobuffer *var_secinfo_buf = &other->percpu_secinfo;
>> -	size_t sz = gobuffer__size(var_secinfo_buf);
>> -	uint16_t nr_var_secinfo = sz / sizeof(struct btf_var_secinfo);
>> -	uint32_t type_id;
>> -	uint32_t next_type_id = btf__type_cnt(encoder->btf);
>> -	int32_t i, id;
>> -	struct btf_var_secinfo *vsi;
>> -
>> +	int shndx;
>>  	if (encoder == other)
>>  		return 0;
>>  
>>  	btf_encoder__add_saved_funcs(other);
>>  
>> -	for (i = 0; i < nr_var_secinfo; i++) {
>> -		vsi = (struct btf_var_secinfo *)var_secinfo_buf->entries + i;
>> -		type_id = next_type_id + vsi->type - 1; /* Type ID starts from 1 */
>> -		id = btf_encoder__add_var_secinfo(encoder, type_id, vsi->offset, vsi->size);
>> -		if (id < 0)
>> -			return id;
>> +	for (shndx = 0; shndx < other->seccnt; shndx++) {
>> +		struct gobuffer *var_secinfo_buf = &other->secinfo[shndx].secinfo;
>> +		size_t sz = gobuffer__size(var_secinfo_buf);
>> +		uint16_t nr_var_secinfo = sz / sizeof(struct btf_var_secinfo);
>> +		uint32_t type_id;
>> +		uint32_t next_type_id = btf__type_cnt(encoder->btf);
>> +		int32_t i, id;
>> +		struct btf_var_secinfo *vsi;
>> +
>> +		if (strcmp(encoder->secinfo[shndx].name, other->secinfo[shndx].name)) {
>> +			fprintf(stderr, "mismatched ELF sections at index %d: \"%s\", \"%s\"\n",
>> +				shndx, encoder->secinfo[shndx].name, other->secinfo[shndx].name);
>> +			return -1;
>> +		}
>> +
>> +		for (i = 0; i < nr_var_secinfo; i++) {
>> +			vsi = (struct btf_var_secinfo *)var_secinfo_buf->entries + i;
>> +			type_id = next_type_id + vsi->type - 1; /* Type ID starts from 1 */
>> +			id = btf_encoder__add_var_secinfo(encoder, shndx, type_id, vsi->offset, vsi->size);
>> +			if (id < 0)
>> +				return id;
>> +		}
>>  	}
>>  
>>  	return btf__add_btf(encoder->btf, other->btf);
>>  }
>>  
>> -static int32_t btf_encoder__add_datasec(struct btf_encoder *encoder, const char *section_name)
>> +static int32_t btf_encoder__add_datasec(struct btf_encoder *encoder, int shndx)
>>  {
>> -	struct gobuffer *var_secinfo_buf = &encoder->percpu_secinfo;
>> +	struct gobuffer *var_secinfo_buf = &encoder->secinfo[shndx].secinfo;
>> +	const char *section_name = encoder->secinfo[shndx].name;
>>  	struct btf *btf = encoder->btf;
>>  	size_t sz = gobuffer__size(var_secinfo_buf);
>>  	uint16_t nr_var_secinfo = sz / sizeof(struct btf_var_secinfo);
>> @@ -1741,13 +1741,14 @@ out:
>>  int btf_encoder__encode(struct btf_encoder *encoder)
>>  {
>>  	bool should_tag_kfuncs;
>> -	int err;
>> +	int err, shndx;
>>  
>>  	/* for single-threaded case, saved funcs are added here */
>>  	btf_encoder__add_saved_funcs(encoder);
>>  
>> -	if (gobuffer__size(&encoder->percpu_secinfo) != 0)
>> -		btf_encoder__add_datasec(encoder, PERCPU_SECTION);
>> +	for (shndx = 0; shndx < encoder->seccnt; shndx++)
>> +		if (gobuffer__size(&encoder->secinfo[shndx].secinfo))
>> +			btf_encoder__add_datasec(encoder, shndx);
>>  
>>  	/* Empty file, nothing to do, so... done! */
>>  	if (btf__type_cnt(encoder->btf) == 1)
>> @@ -1797,111 +1798,18 @@ int btf_encoder__encode(struct btf_encoder *encoder)
>>  	return err;
>>  }
>>  
>> -static int percpu_var_cmp(const void *_a, const void *_b)
>> -{
>> -	const struct var_info *a = _a;
>> -	const struct var_info *b = _b;
>> -
>> -	if (a->addr == b->addr)
>> -		return 0;
>> -	return a->addr < b->addr ? -1 : 1;
>> -}
>> -
>> -static bool btf_encoder__percpu_var_exists(struct btf_encoder *encoder, uint64_t addr, uint32_t *sz, const char **name)
>> -{
>> -	struct var_info key = { .addr = addr };
>> -	const struct var_info *p = bsearch(&key, encoder->percpu.vars, encoder->percpu.var_cnt,
>> -					   sizeof(encoder->percpu.vars[0]), percpu_var_cmp);
>> -	if (!p)
>> -		return false;
>> -
>> -	*sz = p->sz;
>> -	*name = p->name;
>> -	return true;
>> -}
>> -
>> -static int btf_encoder__collect_percpu_var(struct btf_encoder *encoder, GElf_Sym *sym, size_t sym_sec_idx)
>> -{
>> -	const char *sym_name;
>> -	uint64_t addr;
>> -	uint32_t size;
>> -
>> -	/* compare a symbol's shndx to determine if it's a percpu variable */
>> -	if (sym_sec_idx != encoder->percpu.shndx)
>> -		return 0;
>> -	if (elf_sym__type(sym) != STT_OBJECT)
>> -		return 0;
>> -
>> -	addr = elf_sym__value(sym);
>> -
>> -	size = elf_sym__size(sym);
>> -	if (!size)
>> -		return 0; /* ignore zero-sized symbols */
>> -
>> -	sym_name = elf_sym__name(sym, encoder->symtab);
>> -	if (!btf_name_valid(sym_name)) {
>> -		dump_invalid_symbol("Found symbol of invalid name when encoding btf",
>> -				    sym_name, encoder->verbose, encoder->force);
>> -		if (encoder->force)
>> -			return 0;
>> -		return -1;
>> -	}
>> -
>> -	if (encoder->verbose)
>> -		printf("Found per-CPU symbol '%s' at address 0x%" PRIx64 "\n", sym_name, addr);
>> -
>> -	/* Make sure addr is section-relative. For kernel modules (which are
>> -	 * ET_REL files) this is already the case. For vmlinux (which is an
>> -	 * ET_EXEC file) we need to subtract the section address.
>> -	 */
>> -	if (!encoder->is_rel)
>> -		addr -= encoder->secinfo[encoder->percpu.shndx].addr;
>> -
>> -	if (encoder->percpu.var_cnt == encoder->percpu.allocated) {
>> -		struct var_info *new;
>> -
>> -		new = reallocarray_grow(encoder->percpu.vars,
>> -					&encoder->percpu.allocated,
>> -					sizeof(*encoder->percpu.vars));
>> -		if (!new) {
>> -			fprintf(stderr, "Failed to allocate memory for variables\n");
>> -			return -1;
>> -		}
>> -		encoder->percpu.vars = new;
>> -	}
>> -	encoder->percpu.vars[encoder->percpu.var_cnt].addr = addr;
>> -	encoder->percpu.vars[encoder->percpu.var_cnt].sz = size;
>> -	encoder->percpu.vars[encoder->percpu.var_cnt].name = sym_name;
>> -	encoder->percpu.var_cnt++;
>> -
>> -	return 0;
>> -}
>>  
>> -static int btf_encoder__collect_symbols(struct btf_encoder *encoder, bool collect_percpu_vars)
>> +static int btf_encoder__collect_symbols(struct btf_encoder *encoder)
>>  {
>> -	Elf32_Word sym_sec_idx;
>> +	uint32_t sym_sec_idx;
>>  	uint32_t core_id;
>>  	GElf_Sym sym;
>>  
>> -	/* cache variables' addresses, preparing for searching in symtab. */
>> -	encoder->percpu.var_cnt = 0;
>> -
>> -	/* search within symtab for percpu variables */
>>  	elf_symtab__for_each_symbol_index(encoder->symtab, core_id, sym, sym_sec_idx) {
>> -		if (collect_percpu_vars && btf_encoder__collect_percpu_var(encoder, &sym, sym_sec_idx))
>> -			return -1;
>>  		if (btf_encoder__collect_function(encoder, &sym))
>>  			return -1;
>>  	}
>>  
>> -	if (collect_percpu_vars) {
>> -		if (encoder->percpu.var_cnt)
>> -			qsort(encoder->percpu.vars, encoder->percpu.var_cnt, sizeof(encoder->percpu.vars[0]), percpu_var_cmp);
>> -
>> -		if (encoder->verbose)
>> -			printf("Found %d per-CPU variables!\n", encoder->percpu.var_cnt);
>> -	}
>> -
>>  	if (encoder->functions.cnt) {
>>  		qsort(encoder->functions.entries, encoder->functions.cnt, sizeof(encoder->functions.entries[0]),
>>  		      functions_cmp);
>> @@ -1923,75 +1831,128 @@ static bool ftype__has_arg_names(const struct ftype *ftype)
>>  	return true;
>>  }
>>  
>> +static int get_elf_section(struct btf_encoder *encoder, unsigned long addr)
>> +{
>> +	/* Start at index 1 to ignore initial SHT_NULL section */
>> +	for (int i = 1; i < encoder->seccnt; i++)
>> +		/* Variables are only present in PROGBITS or NOBITS (.bss) */
>> +		if ((encoder->secinfo[i].type == SHT_PROGBITS ||
>> +		     encoder->secinfo[i].type == SHT_NOBITS) &&
>> +		    encoder->secinfo[i].addr <= addr &&
>> +		    (addr - encoder->secinfo[i].addr) < encoder->secinfo[i].sz)
>> +			return i;
>> +	return -ENOENT;
>> +}
>> +
>> +/*
>> + * Filter out variables / symbol names with common prefixes and no useful
>> + * values. Prefixes should be added sparingly, and it should be objectively
>> + * obvious that they are not useful.
>> + */
>> +static bool filter_variable_name(const char *name)
>> +{
>> +	static const struct { char *s; size_t len; } skip[] = {
>> +		#define X(str) {str, sizeof(str) - 1}
>> +		X("__UNIQUE_ID"),
>> +		X("__tpstrtab_"),
>> +		X("__exitcall_"),
>> +		X("__func_stack_frame_non_standard_")
>> +		#undef X
>> +	};
>> +	int i;
>> +
>> +	if (*name != '_')
>> +		return false;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(skip); i++) {
>> +		if (strncmp(name, skip[i].s, skip[i].len) == 0)
>> +			return true;
>> +	}
>> +	return false;
>> +}
>> +
>>  static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
>>  {
>>  	struct cu *cu = encoder->cu;
>>  	uint32_t core_id;
>>  	struct tag *pos;
>>  	int err = -1;
>> -	struct elf_secinfo *pcpu_scn = &encoder->secinfo[encoder->percpu.shndx];
>>  
>> -	if (encoder->percpu.shndx == 0 || !encoder->symtab)
>> +	if (!encoder->symtab)
>>  		return 0;
>>  
>>  	if (encoder->verbose)
>> -		printf("search cu '%s' for percpu global variables.\n", cu->name);
>> +		printf("search cu '%s' for global variables.\n", cu->name);
>>  
>>  	cu__for_each_variable(cu, core_id, pos) {
>>  		struct variable *var = tag__variable(pos);
>> -		uint32_t size, type, linkage;
>> -		const char *name, *dwarf_name;
>> +		uint32_t type, linkage;
>> +		const char *name;
>>  		struct llvm_annotation *annot;
>>  		const struct tag *tag;
>> +		int shndx;
>> +		struct elf_secinfo *sec = NULL;
>>  		uint64_t addr;
>>  		int id;
>> +		unsigned long size;
>>  
>> +		/* Skip incomplete (non-defining) declarations */
>>  		if (var->declaration && !var->spec)
>>  			continue;
>>  
>> -		/* percpu variables are allocated in global space */
>> -		if (variable__scope(var) != VSCOPE_GLOBAL && !var->spec)
>> +		/*
>> +		 * top_level: indicates that the variable is declared at the top
>> +		 *   level of the CU, and thus it is globally scoped.
>> +		 * artificial: indicates that the variable is a compiler-generated
>> +		 *   "fake" variable that doesn't appear in the source.
>> +		 * scope: set by pahole to indicate the type of storage the
>> +		 *   variable has. GLOBAL indicates it is stored in static
>> +		 *   memory (as opposed to a stack variable or register)
>> +		 *
>> +		 * Some variables are "top_level" but not GLOBAL:
>> +		 *   e.g. current_stack_pointer, which is a register variable,
>> +		 *   despite having global CU-declarations. We don't want that,
>> +		 *   since no code could actually find this variable.
>> +		 * Some variables are GLOBAL but not top_level:
>> +		 *   e.g. function static variables
>> +		 */
>> +		if (!var->top_level || var->artificial || var->scope != VSCOPE_GLOBAL)
>>  			continue;
>>  
>>  		/* addr has to be recorded before we follow spec */
>>  		addr = var->ip.addr;
>> -		dwarf_name = variable__name(var);
>>  
>> -		/* Make sure addr is section-relative. DWARF, unlike ELF,
>> -		 * always contains virtual symbol addresses, so subtract
>> -		 * the section address unconditionally.
>> -		 */
>> -		if (addr < pcpu_scn->addr || addr >= pcpu_scn->addr + pcpu_scn->sz)
>> +		/* Get the ELF section info for the variable */
>> +		shndx = get_elf_section(encoder, addr);
>> +		if (shndx >= 0 && shndx < encoder->seccnt)
>> +			sec = &encoder->secinfo[shndx];
>> +		if (!sec || !sec->include)
>>  			continue;
>> -		addr -= pcpu_scn->addr;
>>  
>> -		if (!btf_encoder__percpu_var_exists(encoder, addr, &size, &name))
>> -			continue; /* not a per-CPU variable */
>> +		/* Convert addr to section relative */
>> +		addr -= sec->addr;
>>  
>> -		/* A lot of "special" DWARF variables (e.g, __UNIQUE_ID___xxx)
>> -		 * have addr == 0, which is the same as, say, valid
>> -		 * fixed_percpu_data per-CPU variable. To distinguish between
>> -		 * them, additionally compare DWARF and ELF symbol names. If
>> -		 * DWARF doesn't provide proper name, pessimistically assume
>> -		 * bad variable.
>> -		 *
>> -		 * Examples of such special variables are:
>> -		 *
>> -		 *  1. __ADDRESSABLE(sym), which are forcely emitted as symbols.
>> -		 *  2. __UNIQUE_ID(prefix), which are introduced to generate unique ids.
>> -		 *  3. __exitcall(fn), functions which are labeled as exit calls.
>> -		 *
>> -		 *  This is relevant only for vmlinux image, as for kernel
>> -		 *  modules per-CPU data section has non-zero offset so all
>> -		 *  per-CPU symbols have non-zero values.
>> -		 */
>> -		if (var->ip.addr == 0) {
>> -			if (!dwarf_name || strcmp(dwarf_name, name))
>> +		/* DWARF specification reference should be followed, because
>> +		 * information like the name & type may not be present on var */
>> +		if (var->spec)
>> +			var = var->spec;
>> +
>> +		name = variable__name(var);
>> +		if (!name)
>> +			continue;
>> +
>> +		/* Check for invalid BTF names */
>> +		if (!btf_name_valid(name)) {
>> +			dump_invalid_symbol("Found invalid variable name when encoding btf",
>> +					    name, encoder->verbose, encoder->force);
>> +			if (encoder->force)
>>  				continue;
>> +			else
>> +				return -1;
>>  		}
>>  
>> -		if (var->spec)
>> -			var = var->spec;
>> +		if (filter_variable_name(name))
>> +			continue;
>>  
>>  		if (var->ip.tag.type == 0) {
>>  			fprintf(stderr, "error: found variable '%s' in CU '%s' that has void type\n",
>> @@ -2003,9 +1964,10 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
>>  		}
>>  
>>  		tag = cu__type(cu, var->ip.tag.type);
>> -		if (tag__size(tag, cu) == 0) {
>> +		size = tag__size(tag, cu);
>> +		if (size == 0) {
>>  			if (encoder->verbose)
>> -				fprintf(stderr, "Ignoring zero-sized per-CPU variable '%s'...\n", dwarf_name ?: "<missing name>");
>> +				fprintf(stderr, "Ignoring zero-sized variable '%s'...\n", name ?: "<missing name>");
>>  			continue;
>>  		}
>>  
>> @@ -2035,13 +1997,14 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
>>  		}
>>  
>>  		/*
>> -		 * add a BTF_VAR_SECINFO in encoder->percpu_secinfo, which will be added into
>> -		 * encoder->types later when we add BTF_VAR_DATASEC.
>> +		 * Add the variable to the secinfo for the section it appears in.
>> +		 * Later we will generate a BTF_VAR_DATASEC for all any section with
>> +		 * an encoded variable.
>>  		 */
>> -		id = btf_encoder__add_var_secinfo(encoder, id, addr, size);
>> +		id = btf_encoder__add_var_secinfo(encoder, shndx, id, addr, size);
>>  		if (id < 0) {
>>  			fprintf(stderr, "error: failed to encode section info for variable '%s' at addr 0x%" PRIx64 "\n",
>> -			        name, addr);
>> +				name, addr);
>>  			goto out;
>>  		}
>>  	}
>> @@ -2068,7 +2031,6 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>>  
>>  		encoder->force		 = conf_load->btf_encode_force;
>>  		encoder->gen_floats	 = conf_load->btf_gen_floats;
>> -		encoder->skip_encoding_vars = conf_load->skip_encoding_btf_vars;
>>  		encoder->skip_encoding_decl_tag	 = conf_load->skip_encoding_btf_decl_tag;
>>  		encoder->tag_kfuncs	 = conf_load->btf_decl_tag_kfuncs;
>>  		encoder->gen_distilled_base = conf_load->btf_gen_distilled_base;
>> @@ -2076,6 +2038,11 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>>  		encoder->has_index_type  = false;
>>  		encoder->need_index_type = false;
>>  		encoder->array_index_id  = 0;
>> +		encoder->encode_vars = 0;
>> +		if (!conf_load->skip_encoding_btf_vars)
>> +			encoder->encode_vars |= BTF_VAR_PERCPU;
>> +		if (conf_load->encode_btf_global_vars)
>> +			encoder->encode_vars |= BTF_VAR_GLOBAL;
>>  
>>  		GElf_Ehdr ehdr;
>>  
>> @@ -2085,8 +2052,6 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>>  			goto out_delete;
>>  		}
>>  
>> -		encoder->is_rel = ehdr.e_type == ET_REL;
>> -
>>  		switch (ehdr.e_ident[EI_DATA]) {
>>  		case ELFDATA2LSB:
>>  			btf__set_endianness(encoder->btf, BTF_LITTLE_ENDIAN);
>> @@ -2127,15 +2092,21 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>>  			encoder->secinfo[shndx].addr = shdr.sh_addr;
>>  			encoder->secinfo[shndx].sz = shdr.sh_size;
>>  			encoder->secinfo[shndx].name = secname;
>> -
>> -			if (strcmp(secname, PERCPU_SECTION) == 0)
>> -				encoder->percpu.shndx = shndx;
>> +			encoder->secinfo[shndx].type = shdr.sh_type;
>> +			if (encoder->encode_vars & BTF_VAR_GLOBAL)
>> +				encoder->secinfo[shndx].include = true;
>> +
>> +			if (strcmp(secname, PERCPU_SECTION) == 0) {
>> +				encoder->percpu_shndx = shndx;
>> +				if (encoder->encode_vars & BTF_VAR_PERCPU)
>> +					encoder->secinfo[shndx].include = true;
>> +			}
>>  		}
>>  
>> -		if (!encoder->percpu.shndx && encoder->verbose)
>> +		if (!encoder->percpu_shndx && encoder->verbose)
>>  			printf("%s: '%s' doesn't have '%s' section\n", __func__, cu->filename, PERCPU_SECTION);
>>  
>> -		if (btf_encoder__collect_symbols(encoder, !encoder->skip_encoding_vars))
>> +		if (btf_encoder__collect_symbols(encoder))
>>  			goto out_delete;
>>  
>>  		if (encoder->verbose)
>> @@ -2156,7 +2127,8 @@ void btf_encoder__delete(struct btf_encoder *encoder)
>>  		return;
>>  
>>  	btf_encoders__delete(encoder);
>> -	__gobuffer__delete(&encoder->percpu_secinfo);
>> +	for (int i = 0; i < encoder->seccnt; i++)
>> +		__gobuffer__delete(&encoder->secinfo[i].secinfo);
>>  	zfree(&encoder->filename);
>>  	zfree(&encoder->source_filename);
>>  	btf__free(encoder->btf);
>> @@ -2166,9 +2138,6 @@ void btf_encoder__delete(struct btf_encoder *encoder)
>>  	encoder->functions.allocated = encoder->functions.cnt = 0;
>>  	free(encoder->functions.entries);
>>  	encoder->functions.entries = NULL;
>> -	encoder->percpu.allocated = encoder->percpu.var_cnt = 0;
>> -	free(encoder->percpu.vars);
>> -	encoder->percpu.vars = NULL;
>>  
>>  	free(encoder);
>>  }
>> @@ -2321,7 +2290,7 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
>>  			goto out;
>>  	}
>>  
>> -	if (!encoder->skip_encoding_vars)
>> +	if (encoder->encode_vars)
>>  		err = btf_encoder__encode_cu_variables(encoder);
>>  
>>  	/* It is only safe to delete this CU if we have not stashed any static
>> diff --git a/btf_encoder.h b/btf_encoder.h
>> index f54c95a..5e4d53a 100644
>> --- a/btf_encoder.h
>> +++ b/btf_encoder.h
>> @@ -16,7 +16,15 @@ struct btf;
>>  struct cu;
>>  struct list_head;
>>  
>> +/* Bit flags specifying which kinds of variables are emitted */
>> +enum btf_var_option {
>> +	BTF_VAR_NONE = 0,
>> +	BTF_VAR_PERCPU = 1,
>> +	BTF_VAR_GLOBAL = 2,
>> +};
>> +
>>  struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filename, struct btf *base_btf, bool verbose, struct conf_load *conf_load);
>> +
>>  void btf_encoder__delete(struct btf_encoder *encoder);
>>  
>>  int btf_encoder__encode(struct btf_encoder *encoder);
>> diff --git a/dwarves.h b/dwarves.h
>> index 0fede91..fef881f 100644
>> --- a/dwarves.h
>> +++ b/dwarves.h
>> @@ -92,6 +92,7 @@ struct conf_load {
>>  	bool			btf_gen_optimized;
>>  	bool			skip_encoding_btf_inconsistent_proto;
>>  	bool			skip_encoding_btf_vars;
>> +	bool			encode_btf_global_vars;
>>  	bool			btf_gen_floats;
>>  	bool			btf_encode_force;
>>  	bool			reproducible_build;
>> diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
>> index 0a9d8ac..4bc2d03 100644
>> --- a/man-pages/pahole.1
>> +++ b/man-pages/pahole.1
>> @@ -230,7 +230,10 @@ the debugging information.
>>  
>>  .TP
>>  .B \-\-skip_encoding_btf_vars
>> -Do not encode VARs in BTF.
>> +.TQ
>> +.B \-\-encode_btf_global_vars
>> +By default, VARs are encoded only for percpu variables. These options allow
>> +to skip encoding them, or alternatively to encode all global variables too.
>>  
>>  .TP
>>  .B \-\-skip_encoding_btf_decl_tag
>> @@ -296,7 +299,8 @@ Encode BTF using the specified feature list, or specify 'default' for all standa
>>  	encode_force       Ignore invalid symbols when encoding BTF; for example
>>  	                   if a symbol has an invalid name, it will be ignored
>>  	                   and BTF encoding will continue.
>> -	var                Encode variables using BTF_KIND_VAR in BTF.
>> +	var                Encode percpu variables using BTF_KIND_VAR in BTF.
>> +	global_var         Encode all global variables in the same way.
>>  	float              Encode floating-point types in BTF.
>>  	decl_tag           Encode declaration tags using BTF_KIND_DECL_TAG.
>>  	type_tag           Encode type tags using BTF_KIND_TYPE_TAG.
>> diff --git a/pahole.c b/pahole.c
>> index a33490d..b123be1 100644
>> --- a/pahole.c
>> +++ b/pahole.c
>> @@ -1239,6 +1239,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
>>  #define ARGP_contains_enumerator 344
>>  #define ARGP_reproducible_build 345
>>  #define ARGP_running_kernel_vmlinux 346
>> +#define ARGP_encode_btf_global_vars 347
>>  
>>  /* --btf_features=feature1[,feature2,..] allows us to specify
>>   * a list of requested BTF features or "default" to enable all default
>> @@ -1285,6 +1286,7 @@ struct btf_feature {
>>  } btf_features[] = {
>>  	BTF_DEFAULT_FEATURE(encode_force, btf_encode_force, false),
>>  	BTF_DEFAULT_FEATURE(var, skip_encoding_btf_vars, true),
>> +	BTF_DEFAULT_FEATURE(global_var, encode_btf_global_vars, false),
>>  	BTF_DEFAULT_FEATURE(float, btf_gen_floats, false),
>>  	BTF_DEFAULT_FEATURE(decl_tag, skip_encoding_btf_decl_tag, true),
>>  	BTF_DEFAULT_FEATURE(type_tag, skip_encoding_btf_type_tag, true),
>> @@ -1720,7 +1722,12 @@ static const struct argp_option pahole__options[] = {
>>  	{
>>  		.name = "skip_encoding_btf_vars",
>>  		.key  = ARGP_skip_encoding_btf_vars,
>> -		.doc  = "Do not encode VARs in BTF."
>> +		.doc  = "Do not encode any VARs in BTF [if this is not specified, only percpu variables are encoded. To encode global variables too, use --encode_btf_global_vars]."
>> +	},
>> +	{
>> +		.name = "encode_btf_global_vars",
>> +		.key  = ARGP_skip_encoding_btf_vars,
>> +		.doc  = "Encode all global VARs in BTF [if this is not specified, only percpu variables are encoded]."
>>  	},
>>  	{
>>  		.name = "btf_encode_force",
>> @@ -2047,6 +2054,8 @@ static error_t pahole__options_parser(int key, char *arg,
>>  		show_supported_btf_features(stdout);	exit(0);
>>  	case ARGP_btf_features_strict:
>>  		parse_btf_features(arg, true);		break;
>> +	case ARGP_encode_btf_global_vars:
>> +		conf_load.encode_btf_global_vars = true;	break;
>>  	default:
>>  		return ARGP_ERR_UNKNOWN;
>>  	}
>> -- 
>> 2.43.5

