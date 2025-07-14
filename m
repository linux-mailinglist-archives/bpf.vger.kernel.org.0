Return-Path: <bpf+bounces-63152-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6765CB03B35
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 11:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 373AF3B16DE
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 09:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81168242D98;
	Mon, 14 Jul 2025 09:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JNQlAstO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mxkFudEe"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A39236A70;
	Mon, 14 Jul 2025 09:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752486219; cv=fail; b=Ay092yBtEQol6z8N5NovsQ3EOvLkES3Ytdc4u6dSlJCjk6Sfs47hRmc1KquFU6AXwYiDW53aCFok8rE9cejfwP5VpiQlWWtv1tDChrVOtHrUUepkQVQkZGh5VV8ghv4nhjflPqj6wz6RT1JdgcXOeshWp4xHQH6PGp1okswDE4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752486219; c=relaxed/simple;
	bh=fJoLx0lXILOTHIw2DDOU8C/WcU5cwGQMDhCOi4K74nQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FhIWNkEYK/+chS8z9MgUrtSHYfcxW8UTaka713mG5mj1yVr9PZhgkQlGTkzC8+Y356t8tb+sAn0AfRnEtFS+ypQBXA7qjD2hVxqCw6HPuu8z3K32qYACf+upHD/J+1x1yaVYPx0DP14xYycj/jqgfJeW1u4H4VuuKW8zoxx0cgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JNQlAstO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mxkFudEe; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9Z6UE018885;
	Mon, 14 Jul 2025 09:42:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=8syefDwiWKawH6iUEw
	F8Obol59agjLA+Cq+2hTv+IJU=; b=JNQlAstO46xr+e4bfDffNpLvqE/++nCXLx
	1eCInEJoL7AhYaZw5Mk87Rin+EMv15hoh8eixSDtpkDUDfToYyzL8UZ5psLbhyec
	NBXR39zduJPlzLcMwmHIIHX7Wk/hvAt5LglcoybK+kPcGOHzWxfrxLFBt5ItBCRQ
	FuaWJyV01At4Qm6O55t7mjeaNo+bAcmxcuLtgVr5/Lr6boadujU9OQoKzoBucCCl
	po5hyso9CU/+wDDw1FIzZY2JwUUrwFuPqw+D5Qo9hde5cJ4yXF8WpEyNBmIDlA0i
	Ps+CLVIKgWH0V4JdGNvTRqWHOrq0ycmb0EWdlWpE+o3r3kecYX0A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ufnqmja3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 09:42:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9LnH4023714;
	Mon, 14 Jul 2025 09:42:53 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010054.outbound.protection.outlook.com [52.101.61.54])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue58bgx3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 09:42:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kUGuUiioOTcM44Br+McQuYc6tmNc8cYmwCZmqW0TbuYoZTxx5KlhOph3jceWbEzjjYLnv/IzQuYvb47OS9ziFPI7RZYNnmDYWNBn3jEtQn24yvYtJaKkaze2PdNiCfRB+W9VHkqpmC3mGt8D4F+jtJ4hIfa8gCaDmAFa8j6PZ5fAdU3NkC4SrqatiK4QQq+fRVLKxZC2j6wm6qJG8jX1yyMIo/r41wYyEa1wlMTft8C7MuV0T0MXkfBWw5DgLLNzYbEldzpUwMeSMoLLiqdds97RP++N1c0VJ4tMJkX78v0F7lH0P0OfUNqMn3naw4ubGk/TPnZNs6IPCU3D+ghbXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8syefDwiWKawH6iUEwF8Obol59agjLA+Cq+2hTv+IJU=;
 b=xF7WetPuy3KJNE47BmefcFbAwGMIuljRVAORotyMoCmNlMatHIn314FUgnzgcoivqi+oGM3v4kuIBG8iV3skjc9AxLEziV/FmHeBU3qCZRUlsFdPQdIVz/iZta7aiKpvvRu/DdZWmcHQOolme7lzCGyvN6ipcwa002d9wD0BlsOuggJQ5pn/0py9mXO8hGkTTRa0PUE4Pp+vMKFQjerJWB5lo81nSorRXUaCw5wSpn015xHTkAxsu0q26Ib3ZpaZ23yQgyne+KhtKzBPzTehzaTyJJdMznM18YdnaiLolJJeUCdSBrSbOslePx/d85NYZ/9H/pPqvbHkp6tjgAbAxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8syefDwiWKawH6iUEwF8Obol59agjLA+Cq+2hTv+IJU=;
 b=mxkFudEev6T67gYVv89PsLRl3zCeekpUV+vfg79HMQUV4DoQXIQ5fFSoGSJDND4UnqKY06+SjB64ar0n4CkxHhavaMOKNf6Yyy4lQOssoMH8W41XmIiUNtji0dX54VXbGszmW9Q4wD6hHm3XBq8QSEJu0oO/AnbSXzUCg37jBtM=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DS7PR10MB7278.namprd10.prod.outlook.com (2603:10b6:8:d8::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.25; Mon, 14 Jul 2025 09:42:49 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%4]) with mapi id 15.20.8901.033; Mon, 14 Jul 2025
 09:42:49 +0000
Date: Mon, 14 Jul 2025 18:42:30 +0900
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
Message-ID: <aHTQrso2Klvcwasf@hyeyoo>
References: <20250625043350.7939-1-byungchul@sk.com>
 <20250625043350.7939-2-byungchul@sk.com>
 <20250626174904.4a6125c9@kernel.org>
 <20250627035405.GA4276@system.software.com>
 <20250627173730.15b25a8c@kernel.org>
 <aGHNmKRng9H6kTqz@hyeyoo>
 <20250701164508.0738f00f@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701164508.0738f00f@kernel.org>
X-ClientProxiedBy: SL2P216CA0221.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:18::15) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DS7PR10MB7278:EE_
X-MS-Office365-Filtering-Correlation-Id: 16887f6e-25b6-4844-6f84-08ddc2bacb63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RytYJo+ww1IaGhAEpcA3OhGj/R5QtKOvoL3KqQ8/B7Kb0XUgAp+d2xBiH1Ar?=
 =?us-ascii?Q?Wfz0GNd7zGwh9EHmBEs8/Rldlwp5i0catXEqEpSKcBFkpnOnuxyjDDs1nzlM?=
 =?us-ascii?Q?d8y27D5tXjguCp4Nd2chfwY7GCzLjaO/Xn3cqSD/0bojZkExJew94xHiY0uv?=
 =?us-ascii?Q?Q6Y6qb60NVzENr4EhKvQl0Wqenk1ic7UbR4ENJOZL474nZaJyzDMd+Lvmvk5?=
 =?us-ascii?Q?oPEmYiAbIiQjcR22zUZh3WkTtrqZcDZ+ySvAsuwesvLVzS8JRz5gBfr9wHvc?=
 =?us-ascii?Q?PVLn7MdAQb206QdnvA3iImf3rSFXnXBLEOZfmVvO0ts5J54WmtG6A2OX6F+Z?=
 =?us-ascii?Q?sCbXt0PNAG9Er7nRKxJwBu4PuncXbWYoSXeihgCSi1vVguzz7uA9LbgiKR5z?=
 =?us-ascii?Q?vU36ZdbgggC95LAskyRKTKB1Jtl8okKnzWvntNeyaQBVndCrTPsirQ+LRoB6?=
 =?us-ascii?Q?pbyK936PQDM1J27QsElt0182kPWObQgsMOw0zELHniqZ8NubXEDy+ialbfNa?=
 =?us-ascii?Q?0/HqckANKO0ZimIjxCv/6gbLy0BiDGUjTK4tfJhW/TtLuSw+hKIUb3JmLjEI?=
 =?us-ascii?Q?/R3SS34m1vZ21iuVs+eXwL/C+UMs0Eg8uf75nuQPGvNs0ulUli/vlvMwL1C/?=
 =?us-ascii?Q?sqSbRDz3LHY2n1iucVujXCj8BgjD80Ws6+aV/D38b4AoG5Ufrg14ZTYN4fLd?=
 =?us-ascii?Q?V9XQmuoB/7tyR9HQ+VKMfjsmq/CQ1I0MIgvFoMIciTYA9DHaee4/pdL8QZJB?=
 =?us-ascii?Q?iyAIRUuR48VA8+l7KRLeOLJXkIIRvsHQQ2RpLU9nwFHSz64WmoZlsVbFAtTj?=
 =?us-ascii?Q?KgussRosNo/KNj8exwQa80uoZbRYv7Wa8Crev/aLT3TIbQhioE4vUQokGVUN?=
 =?us-ascii?Q?VNL/8VfAiBuQ54eDpunf00X4f2LpbGtgz//TAFpV9cXQwOY1VonNZ2mIBuyQ?=
 =?us-ascii?Q?3XEPKrcWy+Z3m+St5aNQogvoh6sP8tDG7UisWVu5v+tB/U0P6ysrmUD3veg/?=
 =?us-ascii?Q?NzBvO/kY2+PmLIbMyQTKxhGM6Kg0gIWoGkFlxpc0BdahBImbIfCDCqbhYwGz?=
 =?us-ascii?Q?SM8t/mFRVrfM7cZQ91Y/n+4tBRmZRBwEtDTObj1+1FA1DrrTHZzxMuSS6E6A?=
 =?us-ascii?Q?4TUJfQegnk8WgBVqFAFcqwVue+Zo1YQsZ7H/mpa0U1G6XdKbemYPjhd3pgW4?=
 =?us-ascii?Q?QiC/MB9TuXeH9CCMm0vtkv6WZla7NoRLDbAC0VNIe5NRYm38081hhwQFQl6B?=
 =?us-ascii?Q?3IlfJXctsfV4V1gK3SblNinqWbvmsiTdgyIhA89ga0fu96oEqh5Y8NTfOXGc?=
 =?us-ascii?Q?2FAAUQsWH6R2MgHH98fm6j6ur9ICEPWTwfE25DDqmGrVJpXzn7uxOCdDCBiE?=
 =?us-ascii?Q?xqNuu3zZC60G0NL9NcQX8p36yKnF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fW4LI/7raJo3V8qkQ2+hSqB+DR98qau/W4uVsE5ghVdIV5BkZyAknCm5XcG5?=
 =?us-ascii?Q?C+r1eZAFfm8N8A8yG7UfDhXlfTfyguNIuXucSe1Y2bC40aoBhBHkHfHgXwme?=
 =?us-ascii?Q?BSWw+7kP5iOgGuC8ZDVad3rF7DT5xC7wV4X6RlMxDtxU8+c4/cY8ij2XuVJ+?=
 =?us-ascii?Q?YBzD1trL+uqU4hDzJQ64xbHrqgdRFzoy0IpSOf/diDo+m5yS0rK2cHfnAcmc?=
 =?us-ascii?Q?7U8yAGvV2HME0V2/EKfE7sq9w/xppaEt1xfOHU9eVBdRrYwlPtd+45p8oE2I?=
 =?us-ascii?Q?5hFEVxmdOgvIS0VY8nHVdSpbbVI8MEhZxLc7v5QiQXmaLoyB3S9S7qUhknBP?=
 =?us-ascii?Q?cBtJJRd6Fp5kL6dvSCnNkEx8O8PH53+/QgdGL7vARsQyOoaM5+kopgMnbwuO?=
 =?us-ascii?Q?2sz4CWWWeQUVaOBh2PUK9mzsuVWmLp3zHN2RhEzJfEvtmnCZKxzMGKg+GL/d?=
 =?us-ascii?Q?D9gl0zmm5CjLlRJqzMck8JAj8SwGMefgGc+5nlpYxepzAF5IgHrqb2jyIBWX?=
 =?us-ascii?Q?kpmMAGa6U3X+ZNL1fRHsRS2AGTyCpsGqL3h686PxLn4hDxm3LmP5iCC8ABn5?=
 =?us-ascii?Q?XHwle+BrVs+NSk2eiK3mOt40it4YYK743bDrgeD28NS1Drf/AwaMY79lEC8j?=
 =?us-ascii?Q?zzqUU/ZzkMKHvHxbgUzlpDqdNmCp4x9I7J1zQXvn8cJk0end+J545xV6gk90?=
 =?us-ascii?Q?9/MhqbCK2yutyXrJ1kQw8ZOoX0rcZrME57ZMcL3biYNHOfZwHcjbqvhvP29p?=
 =?us-ascii?Q?cLyg8I5cPtmZuvDrWg4dY6v5JM6OYAYEildS8DDtJ/qHHhPVRXkIyCvQdU3w?=
 =?us-ascii?Q?zt3kVVyPvfBA3/z1+17HEYw+AwrJPO8ihH+OErYnPfJNG4LqX7yHpOcuQ2mt?=
 =?us-ascii?Q?f7Y/asKFHhBAgDGWUIIDg5EY307qj6j4An69ksUoYWrZsa+zTOAkhYNk+bR0?=
 =?us-ascii?Q?Wqcu4ct9IHQXdPjQDzRFl67Og9GRn/bIIYLI7UGzB1Mfg+Fd8/kCD2puFKZL?=
 =?us-ascii?Q?aZujk99C9LmwZhd1u6TYZAS34/78z98SMwNASYmmoVaUr5HU7c5KPPCGbNC1?=
 =?us-ascii?Q?X56t6xFBz7+4EmnANCjKSqh/lj1HtW08kXik0CbAPkU04ut2HDg+Q8g4thO8?=
 =?us-ascii?Q?8VtSLN5JUTKEI78Z/0KW9eiSdbnIhXh7Cd5yN9WWgfZZOZ7kxv8x6dFHVjxo?=
 =?us-ascii?Q?/FfVdJKubBFo2UiparFtozBbuEXxacBDtewrds1cep+yxxRity3RY+X373Uy?=
 =?us-ascii?Q?G1cA9qcDVXeou69PirF/OURKAGUttFA3XwosffABd9wJsJIZ5SNFdz4ZEkPF?=
 =?us-ascii?Q?eir9Cy8YSFoFkteXd5i3jJqXbMhG2BS+Eg+o7y+lhk3bNqmQ9YTgr0mLPHjD?=
 =?us-ascii?Q?KCFniYqLM30u0ROQ0fqlalwu8MMJnGpy2CgO/3j2JKzTSs9Nx0CjR5U6Y/lP?=
 =?us-ascii?Q?8gJWscerCZcES4fUZDD23xoArDvX7p4+QZaenW2qH58I4LT7PaB5YQNwfv7J?=
 =?us-ascii?Q?bTNxBErGeMdzbZjH1uCJqUA5ZsUcMnvykvLDOaUo1JXpt0e7cyXLW4zmlpYE?=
 =?us-ascii?Q?YsyY9J6YZyWlOv+jgTDiHYRH4z2qt2d34W09eP8j?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	f9eAQwINKM8KngFmzKbSwIH/eI9QVfQRvTLnjig+K/KL6UiA0o6RWXkVpvWUTdGLgOkW+bjf5FRwhkQ6pEkLaWeSLeaIaK/1G6Oj9ReGzbjU2PZUG4JqCWi8p8mXEqiZ60rS6QoTIxu6C51uckjALyHxgy/pEH2BXCK0W76y68Sd1D4Qd1rl9DsNs1awCZS8SZ86EWsRX3NJi7iCIVQHg1G/0eHdeyRpAJDmFt1p8MkqCIxb9zLn3PdJ5l5/6q0jBJrrUQ1WYGTJvFF44HJuojSHdzyKc8xLs4xwtG9IZyTqkKRppXpsNaggWJUEUDxdRrcsE7b4Ljc75RASX4ZO9k7z82b7EvDyQkNJT3qQt0M794Q8nERSVkhGOmEIHM1115keBgN0IoVqGmjbqzlTrB4ypjjou/ifg9HgPL1rPEIooO730mOuEf0ur1uZ5Hcplu3ogqqgmN0vNsTftZ7hO8hmZ7/GA664b3uPljlWRQHvCAcgbUs18wd+1vB2Lqo9Gtzyxmgo1nX9h5hvCmuyLfpJyWJJGvg2Z9cVFWVPetckPTaGZcytQWcR2sPGfP+W3QGfEdUFY4YKW6YjYkZGZksiSLgglIpx5EVV3zhHKTg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16887f6e-25b6-4844-6f84-08ddc2bacb63
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 09:42:49.2106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3J1W9J6HEbNPxW5p5DGFxx+PaJupkhyqiq/BfSXIfoXGNFStMmGV1xX5apMuSW1qPB5HX/Mn5LjPFkE+/8kA8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7278
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507140056
X-Proofpoint-GUID: 5wY00jgPgOWpcV8CLe6BQUnen5t00aiD
X-Proofpoint-ORIG-GUID: 5wY00jgPgOWpcV8CLe6BQUnen5t00aiD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA1NiBTYWx0ZWRfX9OMiI47e6MSu 3VKiqXdwD97QgCdC97Ct8j4Wfd51MM0+97xF2GgPNyosOjPpQPQDTttbUgHmqNqJeLNdCq4fe6B eSYalIKsxlfNQJ+uW5cdWzYgBbkeI5RPNuVoX3nIVBdnGBL/gG7HrwnnJX1+R9UesrHYApDKHch
 O7HDPh6mrcpBNgBWs2aKEMLxsTfbloYubVpIw50kfKwQQJFIHKNxKVrJBnPd6n+p1oCOVA/bz51 jUQ7cVXjxf0tSEWMga+XXA1yp/heJL8udnFy0veSUB2jSWXFgGHd2z7V57uTn+T8HMSy12vzDVS zHJPf2PVMoswANcbC5rbEJwTnFCh0VLii4mreyMPR04zQWaKrZdB4X7uk3dyFRE1847bmFRjVis
 kIx+OLyKxcHl3xSM5M3cxjIL+u2xw88LzsTExfbIBJICqGkc1d2g2RDfpslwUA0PRtcK0h/y
X-Authority-Analysis: v=2.4 cv=U9ySDfru c=1 sm=1 tr=0 ts=6874d11e b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=SiqW3_QkAAAA:8 a=JuA7HyeyfWqgm0kLeRkA:9 a=CjuIK1q_8ugA:10 a=0-oVHmElw7bdUHZZ8WX8:22

On Tue, Jul 01, 2025 at 04:45:08PM -0700, Jakub Kicinski wrote:
> On Mon, 30 Jun 2025 08:34:48 +0900 Harry Yoo wrote:
> > > Ugh, you keep explaining the mechanics to me. Our goal here is not
> > > just to move fields around and make it still compile :/
> > > 
> > > Let me ask you this way: you said "netmem_desc" will be allocated
> > > thru slab "shortly". How will calling the equivalent of page_address()
> > > on netmem_desc work at that stage? Feel free to refer me to the existing
> > > docs if its covered..  
> > 
> > https://kernelnewbies.org/MatthewWilcox/Memdescs/Path
> > https://kernelnewbies.org/MatthewWilcox/Memdescs
> > 
> > May not be the exact document you're looking for,
> > but with this article I can imagine:
> > 
> > - The ultimate goal is to shrink struct page to eventually from 64 bytes
> >   to 8 bytes, by allocating only the minimum required metadata per 4k page
> >   statically and moving the rest of metadata to dynamically-allocated
> >   descriptors (netmem_desc, anon, file, ptdesc, zpdesc, etc.) using slab
> >   at page allocation time.
> > 
> > - We can't achieve that goal just yet, because several subsystems
> >   still use struct page fields for their own purposes.
> > 
> >   To achieve that, each of these subsystems needs to define
> >   its own descriptor, which, for now, overlays struct page, and should be
> >   converted to use the new descriptor.
> > 
> >   Eventually, these descriptors will be allocated using slab.
> > 
> > - For CPU-readable buffers, page->memdesc will point to a netmem_desc,
> >   with a lower bit set indicating that it's a netmem_desc rather than
> >   other type. Networking code will need to cast it to (netmem_desc *)
> >   and dereference it to access networking specific fields.
> > 
> > - The struct page array (vmemmap) will still be statically allocated
> >   at boot time (or during memory hotplug time).
> >   So no change in how page_address() works.
> > 
> > net_iovs will continue to be not associated with struct pages,
> > as the buffers don't have corresponding struct pages.
> > net_iovs are already allocated using slab.
> 
> Thanks a lot, this clarifies things for me.

You're welcome :)

> Unfortunately, I still think that it's hard to judge patches 1 and 7 
> in context limited to this series, so let's proceed to reposting just
> the "middle 5" patches.

Could you please share your thoughts on why it's hard to judge them and
what's missing from the series, such as in the comments, changelog, or
the cover letter?

-- 
Cheers,
Harry / Hyeonggon

