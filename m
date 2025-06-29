Return-Path: <bpf+bounces-61807-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83841AED1CF
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 01:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA380171731
	for <lists+bpf@lfdr.de>; Sun, 29 Jun 2025 23:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8B024167B;
	Sun, 29 Jun 2025 23:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VKUruxET";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Pw7S1ZbC"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB73512B71;
	Sun, 29 Jun 2025 23:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751240166; cv=fail; b=H0L2docz+N1B/Zs/zF2jA3Bxs8ZyMfN3B+pNbKhgQ8zkt8+FQRrYWLgWveLV9WkJYvFvG0riiO8Pdi5wLoPKQkfof6ipnNeFclY8FjDguGtqgLzH0H0qzgmlK26zumdylZFdkNDPxnvPKk11cIVSzX/pJhzwFulg9DI07HPezNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751240166; c=relaxed/simple;
	bh=0NVc/cgGeF0AwnHSW7atE22o5VP6wPE50SkX/dJnfSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XkFKjw5Gciql3O5JDOrRLK+ohT6z+0ySI8YnE9DwmOftYduxQOvZxG3Rjgu8nSs07ynfWx0B7eoOjS160O9QkO8dKbT2WnHg0gbhrt8dojpQHbsZE8zAQdOfqwtAj+SXrqDS+zW5aI6m1zLjPAyorUCGu2CA0trjugs2/X4cM2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VKUruxET; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Pw7S1ZbC; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55TMiiLo006765;
	Sun, 29 Jun 2025 23:35:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=LHf2ceRp0t76cQbe1x
	COEXRC8D6nzX2j74ztEKL/zJw=; b=VKUruxETALWg6KBDwEoHhJzg8/V8fts6QF
	ODyF3GXKsg3S7/kD2cKFMKlwMFzM/Gkx+S4hdCHyRDo4edQTtpFCuga6NoFM2A0z
	gIF8DfDqA30HGLwb0XnWaWZUTXTTYpflpiAB9Bqs6gsH76ilqhYFsvQ2Q9Tb+Xzo
	x0BCMrFLtV65fgXCd/q5S4Y93NmMc/vYO77/FZLwU0Y0mYbWYj+SYgrZSL+k09Xq
	DFljSTipkjCHtiFh5bc2dwE4jdEwUFdiqfe7F9fvognmL+yIXBweZffXWxpmXo8R
	9ZreqiIeMeAu7BSPA7ffyF1vT7hKVnd4LZj9NFVq/nwEFSV4ZrAw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j8xx1cx2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 29 Jun 2025 23:35:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55TKeuFl013656;
	Sun, 29 Jun 2025 23:35:09 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47j6u7q0s1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 29 Jun 2025 23:35:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HsccylyQUpgiAHKlmsa9FyGEZHrKsK4XzKObHBgHcg0HuHws63eUwBoqv6hcflaIqw/RTQ9tPVqMg9DeyLi1YjSljecn0+zgZ+zG/TNh2/BVOFObckDxEo+myeg0PCXvlRqWmd7kFSlmgQDaY4EGdbKuTpap7b/qveWc2ekEYNAwnAOe7K4i9SCshoTsHjk1oO3j/rRZjzLdksyYK0a6y5VssL5uD3Mr0r73mGWv1jgrw9Y3gKjE7q3+RmcPUDSQvc8jmj5OzehUiSsLYdMbLo78o4ULFE14dd2Zzdj10TQbGxPhzqy8TQl208u6N4ykQ0e3FbDJYYJvcE3TZQDB6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHf2ceRp0t76cQbe1xCOEXRC8D6nzX2j74ztEKL/zJw=;
 b=j9Tr5a+dYVFGeznVedOgy9g/MEruwL9xgm3MuipmLvzNdBqVjbrhBu4chd4taElopUml2BxMbCQ+/GKAuSyp67Siar6dVicy8wn8cVsre4fElUxtn6Y0Hm6Mo7lJhABvfj53Jb6Z3pZzzXPfk0RKicoJTTBJEuj63MMsRchXEivQyYC58u1TFJQ/wOM4JCp5KWe8PiNQAoIKQEWNTFnZXCzRGvtQVa98sczvOSRqzb+6fJiUDuDZmyhIGKid3L5NcE7Bkfbt/IN6c3Un8GvGOJLOmdciTXbxQ5PqNqREJDa7Rq2jlLI+/I2NKQaVfc1jg+ZNmlSJwXRCVI2uP+58yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHf2ceRp0t76cQbe1xCOEXRC8D6nzX2j74ztEKL/zJw=;
 b=Pw7S1ZbCS1MftJNx+iz8hCpvUaSxXuXnQ53xByq7iYw7HHtIhYRtIoSdTxel+wiDqkTvmseo/8aaTFyhrl6TFu94927ulq0UZlHuWObZLXbvNFCcA//Uy44SOm3bDGoZaj2kItZdyfFaIiig+akfovp6dG/HXIHxuCdeMjeyTNg=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by MN2PR10MB4205.namprd10.prod.outlook.com (2603:10b6:208:1d3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Sun, 29 Jun
 2025 23:35:05 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%6]) with mapi id 15.20.8880.021; Sun, 29 Jun 2025
 23:35:05 +0000
Date: Mon, 30 Jun 2025 08:34:48 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Byungchul Park <byungchul@sk.com>, willy@infradead.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kernel_team@skhynix.com, almasrymina@google.com,
        ilias.apalodimas@linaro.org, hawk@kernel.org,
        akpm@linux-foundation.org, davem@davemloft.net,
        john.fastabend@gmail.com, andrew+netdev@lunn.ch,
        asml.silence@gmail.com, toke@redhat.com, tariqt@nvidia.com,
        edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com,
        leon@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
        vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
        horms@kernel.org, linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
        vishal.moola@gmail.com, hannes@cmpxchg.org, ziy@nvidia.com,
        jackmanb@google.com
Subject: Re: [PATCH net-next v7 1/7] netmem: introduce struct netmem_desc
 mirroring struct page
Message-ID: <aGHNmKRng9H6kTqz@hyeyoo>
References: <20250625043350.7939-1-byungchul@sk.com>
 <20250625043350.7939-2-byungchul@sk.com>
 <20250626174904.4a6125c9@kernel.org>
 <20250627035405.GA4276@system.software.com>
 <20250627173730.15b25a8c@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627173730.15b25a8c@kernel.org>
X-ClientProxiedBy: SL2P216CA0173.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1b::13) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|MN2PR10MB4205:EE_
X-MS-Office365-Filtering-Correlation-Id: 2744631f-5272-4dc6-c508-08ddb765937f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cuwff+7b8pd1mMBQBZzpaxZdDJMYcU6ZjyqypuaQh1wx/E0CgQNWFkAcBp0G?=
 =?us-ascii?Q?jZ2Ya426NuizubhOdDUqps/jto/h/WrVuEDzOxJCE9mIvlnNTJ4HUFptQk+O?=
 =?us-ascii?Q?SSycA6UTLYW6frPi8fx2PZKyjIu23StyE1jphI8z1GPJtuBqc8vykMavuSjI?=
 =?us-ascii?Q?GM3u23xmRmhS3cMGm+cPFd94vLolKbfoYhB65sNxQnRGiQJXTzDehw6uEcyw?=
 =?us-ascii?Q?+gPwUvxfml+WORgDD56t9yZJ1D96EGcy5+IhSkc0Lk2HMc42JM60uDe6ZSFf?=
 =?us-ascii?Q?yQUpXJoVCn8zauqfqLc7tMqkFrlJgp5Ag6vwrkUNLvw4TOWeAFUQiM5s4qct?=
 =?us-ascii?Q?vS7HGdADFaIv12UVhwzSqLyNNj/QgKAxYwyIsXRKdmZooIbICRZfHVKRgsir?=
 =?us-ascii?Q?HOw5pooOyjy+UlrOB4KJRvmGYz/s81FFvKE6w/ihY2bpnZOZpK61soaXeQhK?=
 =?us-ascii?Q?o9AH8TwfmgtN9nnzsBnuSdcKpJVXziulkBrNP/RYW+qqm7c0/dOywUxNPUWD?=
 =?us-ascii?Q?T+g21NE1clw/RCCfAzJZzp+e3g8UxC/V5b0EKojNu92VbYwFhfcLo1jiPCaD?=
 =?us-ascii?Q?OTeLOguw3xEkQqZgILrL3szGSTCXCm3TzWwsKDHMNtAueEVMOvd3xhxvK4q+?=
 =?us-ascii?Q?E5jPEan7bF18sGqPQzkpo8Z1NEvUe3XO9v7sSoxwhNHpXsYmi9Y2/X2X/0wJ?=
 =?us-ascii?Q?sRI90K0XEL9jkCXy44WvZDY/CV8hltqfwnr+WkqOHVzuHgpV7fu53jjdQVtW?=
 =?us-ascii?Q?LjBfS7IMwK7SHZ6oswY036+Njel1yfBmAQ61PNuimbCbZNpOV4Nxys1sSKKt?=
 =?us-ascii?Q?si85Ty2AVMc3VJKPAsRq9rCmoVGv9l3oKF6BZiXg7VI8TwBmJYim/1RtykJs?=
 =?us-ascii?Q?GWwX2hDEFfkQ4RHZOHsO6aRr3xq1NSBgJwN/3mZJNRLZCcCMnN11RtceVgAb?=
 =?us-ascii?Q?gfoFy/+Zo+JEVbiGPTwHxRhml0halkqoELTsCAeGOiSgwbiUbeMi3AFCa+SC?=
 =?us-ascii?Q?Yx82wKxB4gF6BQOK/GC/dM3gxRtHB4lzZ165O+cxK368RvbF0o792bWxhQ0V?=
 =?us-ascii?Q?K3+t7+0wkFlN/LoyLEkRgpxZTFB3oGYrgi4olTEWh1smU62kUDc4ZhG/nhAV?=
 =?us-ascii?Q?noadd37UD4A+a8pEitQHEVzvnnLi54i9IdNJF/MOU+TERHDjCxZxmtZ0Kqlt?=
 =?us-ascii?Q?akGq4VlhthdXaXNOqcfYuUa6d2FPHtTZS3jKS0TuznyWnfO81UTeNKRNobe3?=
 =?us-ascii?Q?/qCNJeX26cb1u8jO0W36/ajoLG9s2vE3HBqmJGsDla87DEqunFnT+CNjxWtO?=
 =?us-ascii?Q?pNGm6zE2uvEW+AN5awMwbg00tt4xjbW9+pDKnBf7o6f4ZO5dxEGgA623xUz5?=
 =?us-ascii?Q?IS2+2gWZQhcW1459YNYMOUkYPvOe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EZgImIeDyukTCEQRpfJLs8fQqfBgab0BYoZvlNcoSm2V9o0VBW+0S6SfkBac?=
 =?us-ascii?Q?0m0B8a/GtN7vKh1RJ5RAxlAKcR7zw8FEHR1qsgOrADaj2tRlepyuZ04aeyJD?=
 =?us-ascii?Q?cZlErAuFIl2LM1qt72q7AY+N6TSG1VxNZYpFBnU33b2YPNDzFWrYUHjr01dR?=
 =?us-ascii?Q?BB/x+wYgyu67DmQ4Mo6lb4o/O2iOobU4qLv6gQxomjoHN5pOaZ44bUwTeltC?=
 =?us-ascii?Q?RCnHJ/QxSdXAp6pkRJGtZjzFPwGw9EAsQVL0L4XCKI1IcCTHAJTKdxqVDbG0?=
 =?us-ascii?Q?55L4HZ+CsQqd/zTgIcLucY1g5k/vq0rrDMt5l/GmOpvfd9o+HeqFBCTABYNP?=
 =?us-ascii?Q?j9eky6bxQSlb/vGylksdio+p9RYLuEb73u6UKLiYf+7abull3mtYaDGfz+wl?=
 =?us-ascii?Q?cLAw2DzYs7nG6t+XEAwSmzmhMOpXyHeNLMFJDpsPMIo71aai4B/QOVlvqaYX?=
 =?us-ascii?Q?xbPQ20AtAMdtNg/dJ8xY4ge1Zk7FtjnZClcg1ZiqlHFr+IAcC6goqYOYuGjE?=
 =?us-ascii?Q?MCpyBy42IviRdFGW8r8V4PGK6v9kubsGu5/ko/xzJ9v/Q8oKcvUp1Fp2KZRn?=
 =?us-ascii?Q?7W52d6TdTSTW55UI8cr+XCjAAN/0pKCPemGoMELCQPaT9usyGC+qA49SmsSm?=
 =?us-ascii?Q?mJnLb0QwfgDCgAqWacXnUtUgEFbmU7b/3ZWckKAD1S8Fsr4jlfQAsuXNMIoR?=
 =?us-ascii?Q?rdUve769M9EPJlL6ox+5k+R7e8hrmBU+Iftv8PMl6dbU/q8gcqFl4IYsDaBQ?=
 =?us-ascii?Q?xhJPsdz2ZxeV8bc4qKfJ1+hCLf9Np4tP8rE3wrbGpMhuRXCUg4zVpWOx62sM?=
 =?us-ascii?Q?e9oeUK3DAJNibkncBpv/k8jd3nMz7XDBIUBh/KCHi4ZWFsstctAlMmSLJAji?=
 =?us-ascii?Q?Zfd5MjH17ieyFw2OfiEUq/bco+YlYhddvj9IY26EGD7ECvs9vof6hl4Uwsbi?=
 =?us-ascii?Q?8IfNkxRzbslmoRCgBkJfEFHPumiClUmVjzQNO5U9AvjgQU4IyqQgEu3OVZX3?=
 =?us-ascii?Q?s3rnXoWWPEx8nrOS/5GXs0Pfm1dRlx7FC1eglaJHg+9fNehPluWmab8RZ4LV?=
 =?us-ascii?Q?OXCD5QjkaBmTU9Q26m/6SoMIJiyFM+joPtpELV1ZlLLcflSHzCmciUfjBJUF?=
 =?us-ascii?Q?4ni1LDdgSmTfidaaKMjS/JEfKfrcJ2bj+wnTwK9SpEg+e1aGhzYUFWsjIb5O?=
 =?us-ascii?Q?JFrPiJgolvzhWnB1i2ft7B6TUjV+LWc1hI1kWk7rr+wMnI1d/c+5BEoteAge?=
 =?us-ascii?Q?j8EHvQyEbN6fn9DlvLpCC3raCL6BJbcWS9zG+xZyzVI0VYM1PI5cywDm37hz?=
 =?us-ascii?Q?ZQjxdR41N548pY/6KwqlKmwXpQboZkZiU2O/RU0hc9L7OLRqeppNpV0brYbo?=
 =?us-ascii?Q?dSsgx0/zlxtM5MqFJxbr13mUpwAd1jP+l8iK80d+dItQgHi+pffe3CIRpqQH?=
 =?us-ascii?Q?3IrdHA7DtnvYOOdwnaT8MYwZNht+13B5Tj29JFlla2zz56ub2aO2fjkPABRK?=
 =?us-ascii?Q?a1Hl2WcmUxLoND97gzbGUyukNLc00Kw3COneGRYwRZJ8lFa2jYA80Y41205P?=
 =?us-ascii?Q?n0nOA7iQpcFeLfZ2qndI9kskIMaRHWULZYJQpmt8?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fqv+jBCwtJ6tZdwYl3AzIiyo+PlXgis4XaiwR4BJxelMRv121HlOs2E/dM2+zuoLUinAZkh36Hbuy1DG34OUgeSp93ILt6qHoaRxja5HLezTKTI6gLR85+4KUrDkxep486kbe85nH5buL3iKf0sqNA+nE7LEFHyQVJki5EIsrJeciqwG6z4tUQXgxP3yvqi7VyxahOd67jclAp7yUTbYs1QLxzlZB3fQISi5mxeFBT5k5NC2vWzIdoJMKqGGxvkNpXGo5pltgUPNfWi6aKI+wcXRcwsx854g5rYGlpwcMDi8FQf2CNkgfYzrPzKftzXspsOENBsamURlDeEjvK6TjFy2FrokaGqC6K01znG6jIQ2aaTAJtyfiN1IXCfGhLR/qwFDorshLo07J7g+Zuu0DOresF5DSlcfeR/oNIDAdehJKQkvno1N8GrpLGZWqRqYqAonyE5rp4TvuDQUTjfdrczvvrrqmJbNtHIUJ77vxJDVFQBNgRg/X1BIpSMyNPAKsXSOffCnggwB9mUs3Cxb4DY0O+xjl/hIwO6ZgpKH2PEUGRodkRINX2QuaWGrqtQtaOcNv042KU2rkXsVpb5owSF7MmBGOS6JpTskY8jtaNg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2744631f-5272-4dc6-c508-08ddb765937f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2025 23:35:05.4533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pvyZoks0tnbM9vAVCKp86GsO1YWJtEy0i1VbLo/D7Gz8bxOQgIEue/YY/J+dRi8Hu9lKbHHD4WKgfy7gPvc7Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4205
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_05,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506290199
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI5MDE5OSBTYWx0ZWRfX3MkdtfMXATQD fzhNsHVw3q+HqWUmlNLYSLEhRaDKGX0EktLgi/V2LHtxM8pmEPDPvZTcsCvr4Hg68l68r5ZMSSw 1wvFvL2k5D1iJKQ/pafORnQ3DHSMGpk1mehIE+CaN3v3PbK6cU7ogjt2TKLN5I9jUs1/tynG9yI
 6eJEOgHHfMBkoxQeb2bVQR86o2FD91PvMYiftSM8PMe6oMVSLIo+TyAhP1kCSqJI7N4akrhYkp/ UKuujhBa7s+S/dohoSTJ7sn07BAlDD+AqXTYRAAYDIduFl7Vg91liUjgJyG+HEbeYXYtoOGs/Jo h4LBCV7Dx3RogPvEzHznciXp3gxDm9+jBAYnjpgnPy6TP813Mjw+rAbZtAFHK0yYEjiVU0RJjdv
 1JSbnBV8XbD1RygZda3fQGKdIpkbR8crH5cNvOkVLSj0sY4EJKTiF6SnZmIaUJK74qJXlBHY
X-Proofpoint-ORIG-GUID: orPneQqbtHZEY04qyLGIP-EARWwI8qLx
X-Proofpoint-GUID: orPneQqbtHZEY04qyLGIP-EARWwI8qLx
X-Authority-Analysis: v=2.4 cv=QfRmvtbv c=1 sm=1 tr=0 ts=6861cdae b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=SiqW3_QkAAAA:8 a=rWtaEfNI2Jeq87HWh3wA:9 a=CjuIK1q_8ugA:10 a=0-oVHmElw7bdUHZZ8WX8:22 cc=ntf awl=host:14723

On Fri, Jun 27, 2025 at 05:37:30PM -0700, Jakub Kicinski wrote:
> On Fri, 27 Jun 2025 12:54:05 +0900 Byungchul Park wrote:
> > On Thu, Jun 26, 2025 at 05:49:04PM -0700, Jakub Kicinski wrote:
> > > On Wed, 25 Jun 2025 13:33:44 +0900 Byungchul Park wrote:  
> > > > +/* A memory descriptor representing abstract networking I/O vectors,
> > > > + * generally for non-pages memory that doesn't have its corresponding
> > > > + * struct page and needs to be explicitly allocated through slab.  
> > > 
> > > I still don't get what your final object set is going to be.  
> > 
> > The ultimate goal is:
> > 
> >    Remove the pp fields from struct page
> > 
> > The second important goal is:
> > 
> >    Introduce a network pp descriptor, netmem_desc
> > 
> > While working on these two goals, I added some extra patches too, to
> > clean up related code if it's obvious e.g. patches for renaming and so
> > on.
> 
> Object set. Not objective.
> 
> > > We have
> > >  - CPU-readable buffers (struct page)
> > >  - un-readable buffers (struct net_iov)
> > >  - abstract reference which can be a pointer to either of the
> > >    above two (bitwise netmem_ref)
> > > 
> > > You say you want to evacuate page pool state from struct page
> > > so I'd expect you to add a type which can always be fed into
> > > some form of $type_to_virt(). A type which can always be cast
> > > to net_iov, but not vice versa. So why are you putting things
> > > inside net_iov, not outside.  
> > 
> > The type, struct netmem_desc, is declared outside.  Even though it's
> > used overlaying on struct page *for now*, it will be dynamically
> > allocated through slab shortly - it's also one of mm's plan.
> > 
> > As you know, net_iov is working with the assumption that it overlays on
> > struct page *for now* indeed, when it comes to netmem_ref.  See the
> > following APIs as example:
> > 
> > static inline struct net_iov *__netmem_clear_lsb(netmem_ref netmem)
> > {
> > 	return (struct net_iov *)((__force unsigned long)netmem & ~NET_IOV);
> > }
> > 
> > static inline void netmem_set_pp(netmem_ref netmem, struct page_pool *pool)
> > {
> > 	__netmem_clear_lsb(netmem)->pp = pool;
> > }
> > 
> > I'd say, I replaced the overlaying (on struct page) part with a
> > well-defined struct, netmem_desc that will play the role of struct page
> > for pp usage, instead of a set of the current overlaying fields of
> > net_iov.
> > 
> > This 'introduction of netmem_desc' patch can be the base for network
> > code to use netmem_desc as pp descriptor instead of struct page.  That's
> > what I meant.
> > 
> > Am I missing something or got you wrong?  If yes, please explain in more
> > detail then I will get back with the answer.
> 
> Ugh, you keep explaining the mechanics to me. Our goal here is not
> just to move fields around and make it still compile :/
> 
> Let me ask you this way: you said "netmem_desc" will be allocated
> thru slab "shortly". How will calling the equivalent of page_address()
> on netmem_desc work at that stage? Feel free to refer me to the existing
> docs if its covered..

https://kernelnewbies.org/MatthewWilcox/Memdescs/Path
https://kernelnewbies.org/MatthewWilcox/Memdescs

May not be the exact document you're looking for,
but with this article I can imagine:

- The ultimate goal is to shrink struct page to eventually from 64 bytes
  to 8 bytes, by allocating only the minimum required metadata per 4k page
  statically and moving the rest of metadata to dynamically-allocated
  descriptors (netmem_desc, anon, file, ptdesc, zpdesc, etc.) using slab
  at page allocation time.

- We can't achieve that goal just yet, because several subsystems
  still use struct page fields for their own purposes.

  To achieve that, each of these subsystems needs to define
  its own descriptor, which, for now, overlays struct page, and should be
  converted to use the new descriptor.

  Eventually, these descriptors will be allocated using slab.

- For CPU-readable buffers, page->memdesc will point to a netmem_desc,
  with a lower bit set indicating that it's a netmem_desc rather than
  other type. Networking code will need to cast it to (netmem_desc *)
  and dereference it to access networking specific fields.

- The struct page array (vmemmap) will still be statically allocated
  at boot time (or during memory hotplug time).
  So no change in how page_address() works.

net_iovs will continue to be not associated with struct pages,
as the buffers don't have corresponding struct pages.
net_iovs are already allocated using slab.

HTH

-- 
Cheers,
Harry / Hyeonggon

