Return-Path: <bpf+bounces-71232-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55602BEAF9A
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 19:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 196297458E1
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 16:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DC32EAB7D;
	Fri, 17 Oct 2025 16:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hQQMSSB2"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC5A2EA755;
	Fri, 17 Oct 2025 16:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760719986; cv=fail; b=KyHMs6Gco8n5VIzPdxPI7mmh8tZ6CjdexPbd3C9BW5zXh0qqR5sbTHQ3BhlIfnYZLc5wunk5AhNG5PJnqjCuwwhgKy7JqXt3lyNCASFP3msaBCS1Af6r87FA+7r1Fye9E1NUxJrmwxil6waTz9yuBwTOIKpMKPPAp9hNjG4hhZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760719986; c=relaxed/simple;
	bh=9GHoh1PxaSi6s4DQktfL2QoNonXaa/qW6UvZLGCCHBU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OaMPKaiavw1MLY+OB9Ln+HqGGiULVugQ2NOeHV1hqoLJehgcOeGgo5cXKW/ioD6AvCt7qJXVoAHbfjyB6PY7fuFecSJyX+yytD8Inm7I9kBBcIv6dfwTwDG4Jd1hUeuJyCSxhKL/41pSd7Q8a9AR4tDePyXEYdh1r/YxQQd6iuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hQQMSSB2; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760719984; x=1792255984;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=9GHoh1PxaSi6s4DQktfL2QoNonXaa/qW6UvZLGCCHBU=;
  b=hQQMSSB2AgoRDrIeCukxr7az/UIG3EAgIrB1IvnufVYRb8TQYOgHKEAR
   OxvVCdGbpWdwtX/EShgN6jlT2gZDd6Q4yTkt1gNvYf6qP3oFIGqssK+Dl
   Mieo8uk3u9TQ5Pzy2YpmMRDtPsr6/Tjlz3vS2S45m9t3YEd3+k5dMivAV
   +F1Oe0XPAishuLR0CKVY4UMpbA70Boumj/ztagpRSrqOu0+8dc/DdOc8M
   3fBJON2jZ+Oikv9WKVwyCKYuvjQgHk0EGZ/AbXvdMg8dq6c2So8tkfKpW
   sIYUVwTnorvBLDR2c0L5pAF83aMd4gPCYngc7WO3X7v3KAUnB+crhq7+y
   A==;
X-CSE-ConnectionGUID: IXiE/gtBQzqLJ8rEnV7u4w==
X-CSE-MsgGUID: XCcsEoBTSOK2U7sfIb1zzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11585"; a="88404330"
X-IronPort-AV: E=Sophos;i="6.19,237,1754982000"; 
   d="scan'208";a="88404330"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 09:53:02 -0700
X-CSE-ConnectionGUID: 7c3UhvdDTMGtJ66pHAURzA==
X-CSE-MsgGUID: Z9iw76s2S5C/4Ze3UX8vzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,237,1754982000"; 
   d="scan'208";a="181968424"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 09:53:02 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 17 Oct 2025 09:53:01 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 17 Oct 2025 09:53:01 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.23) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 17 Oct 2025 09:53:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w/RPhwNl5Bgy0aiw95S8p5y9hb0uMeZD/w1vlt2mnJxvt8TrIHCuuWrLSyF+LGFsJC+bU3AZavfoQlFnad9oY9vtOxbV2vF64vVwzuNBvaDoWrVqBcFX3CFca7NZB3b/LgihpiV+behZSdzqo7tfqcpT+oXIn6wqMjQLn2QCiWbmsxyVMJes9PIuOyfeZr4YwGmkY2ASqT1FJ/9f5MOTfbYkDDET/3xhpH36x/fXle0hIOr9JjnIcI86VuDiWhcIBFdnjzkwOHwuKFFgNpwbOgXRqFFd8r8O7ln7DVsUkaNd9wRz8AIS/X2bN2qYmooWSxdgZVJ4EBQxYcvrI2c8OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BakOxcCfJsAU9td6jnIAAYN2y+ERfV7c0HBoW4zlqJI=;
 b=VHFQoTTd1uGRJBiiSLPo/JXTDPJwlza/Zc5Xl2chy/o1yyCR090Kg6aSst6TPBFPjEucOS+NDnVAA3FOa3VHO/Wy7SE+56msYeyq87xuzGB2d6/bNcHJ/W94EIUGVu6yew3CuQV2/sOW6xqBmd30gY8pRfiKtdinpqmltRM97zAtlvfDmPUfGqU15QbyBvNAmPUoNhm5WTQU3yTp9kSVzUYOQXqWpxXMKm/JOR2el5dcb92+9UNBb+bUleQiRc6CbclPOq9PqbDimerene9/myMtrIWBqLFH7hIFcF4sJd2wrDWB6G78GR30l455vS44gpMG1phCET6a24hvxT/glA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 IA4PR11MB8963.namprd11.prod.outlook.com (2603:10b6:208:55c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 16:52:58 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9228.010; Fri, 17 Oct 2025
 16:52:58 +0000
Date: Fri, 17 Oct 2025 18:52:50 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <ilias.apalodimas@linaro.org>, <lorenzo@kernel.org>,
	<kuba@kernel.org>, <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>,
	<andrii@kernel.org>, <stfomichev@gmail.com>, <aleksander.lobakin@intel.com>
Subject: Re: [PATCH v2 bpf 2/2] veth: update mem type in xdp_buff
Message-ID: <aPJ0YqfH+pdSIbVS@boxer>
References: <20251017143103.2620164-1-maciej.fijalkowski@intel.com>
 <20251017143103.2620164-3-maciej.fijalkowski@intel.com>
 <87a51pij2l.fsf@toke.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a51pij2l.fsf@toke.dk>
X-ClientProxiedBy: TL2P290CA0025.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::20) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|IA4PR11MB8963:EE_
X-MS-Office365-Filtering-Correlation-Id: c0d36eee-dc91-4910-33d4-08de0d9da039
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?23oZhvDYyg8kswLwThF6IUDwiUVdxvdt3qn8kU8esNISeZ/Zl5WbSsZkIC?=
 =?iso-8859-1?Q?Af7RWeDCLSS3qPO4kLJG5K8YuPmQL0HXQhy8ETOl2/ocY7Fpl739s46B2r?=
 =?iso-8859-1?Q?VkjWJ47sVsaT2/W2Q1K1I5yq6UImAK4LK9Ih7Hb9Oza2LmkKOrV+94LazO?=
 =?iso-8859-1?Q?xLt0RkNxWoKduhYIywD0DWYW7TKAxtr90o/4rgSc7mDDMwErl8UjFcEpyF?=
 =?iso-8859-1?Q?JbNPeybiLvWDN7Cx8uMOo5IKKxX7ZPAHHHOfR91sL9PGobtGHybHx7Fhk/?=
 =?iso-8859-1?Q?9KRQvTNpafQ8f5cbfGcGYjL6eSa/9imteWq7HxaCwLrWtfsrgggaNmwMA0?=
 =?iso-8859-1?Q?rpgwAdF40CbMQyxSODMFs8DT3J9RfNFhQ4XLX4OrCKd/jdOgUboB/3dfZI?=
 =?iso-8859-1?Q?Cx9lPGEZLQ1vVJLSpBuNKVPlNBFNanGdkEQ79RRkPD5IS/GzNW5ANVxoRJ?=
 =?iso-8859-1?Q?wcYVwpaBdILN5Mpcp0lClLOWI8tbJ6bFKE+yYaKon2Igkjc3iPzLbUaPo6?=
 =?iso-8859-1?Q?aazfAm1Zb8AoVhFL8Cckqw07tZ2w+kSFkzceLhu3U/fAMaFe+ZbNXnoamJ?=
 =?iso-8859-1?Q?wte5Jv/nn1jHHviyECGhOL8zWBbXOx/QbT6GtnLzgl1Q4i9znorR8BpLp0?=
 =?iso-8859-1?Q?Comz6oTd3nglnA8R+PREIrprFpqwhy0HvMfpbBEMUMZlRIH794zxxpy9aT?=
 =?iso-8859-1?Q?ljy9y9UnQiOjky2C1TUopjfFr5JJgl2cblzN97O+vdA/hIxdI43LcfAm7c?=
 =?iso-8859-1?Q?WrMXZu8z27Nbr5y+I7+kA0QYdSTWRfFJby64KfX7PL4M6Hm5cfAVbyTyhW?=
 =?iso-8859-1?Q?emjvXNQdlurf/xkRmsoklYOdUg/QCn9wVZG7Gy5u9AsEctAZIBCXnjB96V?=
 =?iso-8859-1?Q?XWPOLYcFiThYXFfyciULjYe8oUw+/4yoa6iBOVKB6grm76GL3TivFnSd4t?=
 =?iso-8859-1?Q?2qJ4Db8rH0x6938w6KvDIhlGCU0QLb7hP/BOAT4ML41W8VzvUKV+ecUVhC?=
 =?iso-8859-1?Q?hGw2pKhnS2jNGKOjZ1ZUhcqqVxMM5LnbBos9q9BebxmC4kAVWAwnRjcmbf?=
 =?iso-8859-1?Q?yLvam4RZInuxfb2CatchDyDfdV6B7qEo/8uHmwThtim2ayUiyconiQWVbD?=
 =?iso-8859-1?Q?zthmWdfbeOSbfTtP3hILHwTCCvNCXxkmXGOWhv3Mg3kLAkz9sylzgg9Bjq?=
 =?iso-8859-1?Q?ulnFkCSmsGAO9UD5MwXvVbbQiCbq88jvbsBoTEeLGF9o/ICtiKu0iuNY4j?=
 =?iso-8859-1?Q?bHb2lju20DE11scyDUBSH0nj+AHFuprtVFpmyOaT3jAZDQ2mMC2uzDVp0M?=
 =?iso-8859-1?Q?Ufya0MgEC1w8l99QL5mwATH06CNl+R8+8BJW+4H41f+CNJjTLgfzwQYOaw?=
 =?iso-8859-1?Q?v7/37XWOWz+e8bPP0wvRkGXIi2Twd11M5pg3Id9JdH1mlOLvzwsXpAgypV?=
 =?iso-8859-1?Q?zBzqqiUGMMhwP6IEjBiMdPvdLTl1ALP51wE/Nw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?aZ+heZ8+iCoALK1PkcMOJrNcwwEqQCX/x9E9aN1MpcBTAqFFqDROnf6Xy8?=
 =?iso-8859-1?Q?fb/SBMnwZtEKnfNsKtx8ubsHAUEsxvJHn84+ciUGm7fGSqtll0TkAHNnGk?=
 =?iso-8859-1?Q?2JSapN01L4q2nrGblX7qhaNW3PP0Ap4Dl6PkP4JJL6ohd0orwLOxWfY2iW?=
 =?iso-8859-1?Q?4X2aJIXGDjVIy41iUhETthYQylws50M81gEnwNIlCJSEon8p8RA4Yzx6s5?=
 =?iso-8859-1?Q?Oi7UzhDEMl3sEkcnKVt0XIpE9oBoI5gEBGy/muEj6WGhexsUAQ+TEtGxD1?=
 =?iso-8859-1?Q?lvFiwASmK7U9I7vnti8TqAHzU/8Z/TWSyc5dPImLLJ3EG8DX+P6MHRJErg?=
 =?iso-8859-1?Q?NOF020rLZc14Cnj6i8ZFR3+vpCFPG+kistW+19uwI5fEfzV2Pv7uV3JxQz?=
 =?iso-8859-1?Q?h58YXtWgO/gHQMAMT/cUQmydNlj+PffS7SUEDTlvmQxJytoqevYMoObfAC?=
 =?iso-8859-1?Q?WotT0L2WyMEPCNb3qn4PUpLLlhbDUqf3YqXSENvsW2jw1cQvV6RvXEmR8J?=
 =?iso-8859-1?Q?MEuC6WZTSj8Iw+qA+/pDM+YbMS8rbzIdrF+mnzT1P0ua6/BQDlYjtq79/b?=
 =?iso-8859-1?Q?Qk+mEfuc3g/Nn06dqNCc53z8/gWvHDknPdoEQb4BbUMpMNqayw2BLi7yly?=
 =?iso-8859-1?Q?C+cWhgylSK0cahAHKp1T8041KzJbyloeRVmThftDHNvoVAWqfEmZiUh5SP?=
 =?iso-8859-1?Q?t2uBjMAVZyMKdGlnQBWg7jwisD16tKKAICkk7ftWto5J49HNelzbqkJXaA?=
 =?iso-8859-1?Q?2wQhDsNZM4agWi6RiH0UJUVKkmWFn2nvL87fvmCmIoB6wKlFA4XE2o37mf?=
 =?iso-8859-1?Q?/LYtVltY8ZY+Y+TmzaMtD5iP5GDIqKxqH9cB/7LSEwSGPphSzvo0hCIkDU?=
 =?iso-8859-1?Q?88jzvfAWQWXtyE4zHcesRk44TLItVrXUioI4Sn9cWdyIuD06GR9VF/+TNn?=
 =?iso-8859-1?Q?m4l8t0/XqlXfWUSLL9WUS3rQBKR/ZAJ2nCYUHUu1jGohTYqxIku/RKryb1?=
 =?iso-8859-1?Q?UZNM0h8B2dlHAEKRtfWiRTupYzW67fjEgoqYJ44/BhrSqOB8V4cFU3fk1B?=
 =?iso-8859-1?Q?4a9OOUKiAc9zBXLlQCFHyi5bSk4hWIUgmYt2nrW3U6xxzbPOKEFNX02Faq?=
 =?iso-8859-1?Q?d22s9pmvPB/eS8T4FS3ys5FwlbWLHu/hBCBQjMxXm1hYjGACjSiv+xO/RN?=
 =?iso-8859-1?Q?xtASM0G9jHHCxAihRU4ocVJ2byYPMGB09zU3/r3sgibUqB+2uiZcCZ5zyt?=
 =?iso-8859-1?Q?rxBRZEKJWz8YJ9Uo9TdsUi8H7o2oQO7Cb9POrWKngbHyQt3NxvxQ14h0U/?=
 =?iso-8859-1?Q?u16tOyXBD7vzNcbQ/cUKsT9pH7PMqJW49uXsxqcpLQRGM9dPlnimch4ma/?=
 =?iso-8859-1?Q?em/t+4GGbisWRAqigaoGUXqOQ3lCxOibw7SztPxLeZNymS5PEm5dJUmlpP?=
 =?iso-8859-1?Q?DrG6KkimIZq5tQsTEBb23oegsSumgIbSKXfDmkuG5OcgZTshehu2Pjn4b2?=
 =?iso-8859-1?Q?kcbYVX83uxPnKsGU+NL3rUeabjPvBug5zhGb/4LW/7SgtlWavioEacTByr?=
 =?iso-8859-1?Q?d4iXJlv+QLyuy5E7Rs65dXVPwCVGiDTN+ytNdlGka7zvFGKecc29MRv+Us?=
 =?iso-8859-1?Q?IuN2aNsE3lPCuM9sF7P/TJEFPjppez5yMBx7/sQuwQNiMC/lTHbX6A/A?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c0d36eee-dc91-4910-33d4-08de0d9da039
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 16:52:58.4805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ahF6KRsQ1RVXcXa5Jup+VHgZFzcCUrmRSZpSq6ZNAFHR1ENawLYYH95elfI3elh3sqU+vzG6ceDOyoLnMTSCt/lhUklB/Bdim0BWKLCAruI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB8963
X-OriginatorOrg: intel.com

On Fri, Oct 17, 2025 at 06:33:54PM +0200, Toke Høiland-Jørgensen wrote:
> Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:
> 
> > Veth calls skb_pp_cow_data() which makes the underlying memory to
> > originate from system page_pool. For CONFIG_DEBUG_VM=y and XDP program
> > that uses bpf_xdp_adjust_tail(), following splat was observed:
> >
> > [   32.204881] BUG: Bad page state in process test_progs  pfn:11c98b
> > [   32.207167] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x11c98b
> > [   32.210084] flags: 0x1fffe0000000000(node=0|zone=1|lastcpupid=0x7fff)
> > [   32.212493] raw: 01fffe0000000000 dead000000000040 ff11000123c9b000 0000000000000000
> > [   32.218056] raw: 0000000000000000 0000000000000001 00000000ffffffff 0000000000000000
> > [   32.220900] page dumped because: page_pool leak
> > [   32.222636] Modules linked in: bpf_testmod(O) bpf_preload
> > [   32.224632] CPU: 6 UID: 0 PID: 3612 Comm: test_progs Tainted: G O        6.17.0-rc5-gfec474d29325 #6969 PREEMPT
> > [   32.224638] Tainted: [O]=OOT_MODULE
> > [   32.224639] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> > [   32.224641] Call Trace:
> > [   32.224644]  <IRQ>
> > [   32.224646]  dump_stack_lvl+0x4b/0x70
> > [   32.224653]  bad_page.cold+0xbd/0xe0
> > [   32.224657]  __free_frozen_pages+0x838/0x10b0
> > [   32.224660]  ? skb_pp_cow_data+0x782/0xc30
> > [   32.224665]  bpf_xdp_shrink_data+0x221/0x530
> > [   32.224668]  ? skb_pp_cow_data+0x6d1/0xc30
> > [   32.224671]  bpf_xdp_adjust_tail+0x598/0x810
> > [   32.224673]  ? xsk_destruct_skb+0x321/0x800
> > [   32.224678]  bpf_prog_004ac6bb21de57a7_xsk_xdp_adjust_tail+0x52/0xd6
> > [   32.224681]  veth_xdp_rcv_skb+0x45d/0x15a0
> > [   32.224684]  ? get_stack_info_noinstr+0x16/0xe0
> > [   32.224688]  ? veth_set_channels+0x920/0x920
> > [   32.224691]  ? get_stack_info+0x2f/0x80
> > [   32.224693]  ? unwind_next_frame+0x3af/0x1df0
> > [   32.224697]  veth_xdp_rcv.constprop.0+0x38a/0xbe0
> > [   32.224700]  ? common_startup_64+0x13e/0x148
> > [   32.224703]  ? veth_xdp_rcv_one+0xcd0/0xcd0
> > [   32.224706]  ? stack_trace_save+0x84/0xa0
> > [   32.224709]  ? stack_depot_save_flags+0x28/0x820
> > [   32.224713]  ? __resched_curr.constprop.0+0x332/0x3b0
> > [   32.224716]  ? timerqueue_add+0x217/0x320
> > [   32.224719]  veth_poll+0x115/0x5e0
> > [   32.224722]  ? veth_xdp_rcv.constprop.0+0xbe0/0xbe0
> > [   32.224726]  ? update_load_avg+0x1cb/0x12d0
> > [   32.224730]  ? update_cfs_group+0x121/0x2c0
> > [   32.224733]  __napi_poll+0xa0/0x420
> > [   32.224736]  net_rx_action+0x901/0xe90
> > [   32.224740]  ? run_backlog_napi+0x50/0x50
> > [   32.224743]  ? clockevents_program_event+0x1cc/0x280
> > [   32.224746]  ? hrtimer_interrupt+0x31e/0x7c0
> > [   32.224749]  handle_softirqs+0x151/0x430
> > [   32.224752]  do_softirq+0x3f/0x60
> > [   32.224755]  </IRQ>
> >
> > It's because xdp_rxq with mem model set to MEM_TYPE_PAGE_SHARED was used
> > when initializing xdp_buff.
> >
> > Fix this by using new helper xdp_convert_skb_to_buff() that, besides
> > init/prepare xdp_buff, will check if page used for linear part of
> > xdp_buff comes from page_pool. We assume that linear data and frags will
> > have same memory provider as currently XDP API does not provide us a way
> > to distinguish it (the mem model is registered for *whole* Rx queue and
> > here we speak about single buffer granularity).
> >
> > In order to meet expected skb layout by new helper, pull the mac header
> > before conversion from skb to xdp_buff.
> >
> > However, that is not enough as before releasing xdp_buff out of veth via
> > XDP_{TX,REDIRECT}, mem type on xdp_rxq associated with xdp_buff is
> > restored to its original model. We need to respect previous setting at
> > least until buff is converted to frame, as frame carries the mem_type.
> > Add a page_pool variant of veth_xdp_get() so that we avoid refcount
> > underflow when draining page frag.
> >
> > Fixes: 0ebab78cbcbf ("net: veth: add page_pool for page recycling")
> > Reported-by: Alexei Starovoitov <ast@kernel.org>
> > Closes: https://lore.kernel.org/bpf/CAADnVQ+bBofJDfieyOYzSmSujSfJwDTQhiz3aJw7hE+4E2_iPA@mail.gmail.com/
> > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > ---
> >  drivers/net/veth.c | 43 +++++++++++++++++++++++++++----------------
> >  1 file changed, 27 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> > index a3046142cb8e..eeeee7bba685 100644
> > --- a/drivers/net/veth.c
> > +++ b/drivers/net/veth.c
> > @@ -733,7 +733,7 @@ static void veth_xdp_rcv_bulk_skb(struct veth_rq *rq, void **frames,
> >  	}
> >  }
> >  
> > -static void veth_xdp_get(struct xdp_buff *xdp)
> > +static void veth_xdp_get_shared(struct xdp_buff *xdp)
> >  {
> >  	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
> >  	int i;
> > @@ -746,12 +746,33 @@ static void veth_xdp_get(struct xdp_buff *xdp)
> >  		__skb_frag_ref(&sinfo->frags[i]);
> >  }
> >  
> > +static void veth_xdp_get_pp(struct xdp_buff *xdp)
> > +{
> > +	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
> > +	int i;
> > +
> > +	page_pool_ref_page(virt_to_page(xdp->data));
> > +	if (likely(!xdp_buff_has_frags(xdp)))
> > +		return;
> > +
> > +	for (i = 0; i < sinfo->nr_frags; i++) {
> > +		skb_frag_t *frag = &sinfo->frags[i];
> > +
> > +		page_pool_ref_page(netmem_to_page(frag->netmem));
> > +	}
> > +}
> > +
> > +static void veth_xdp_get(struct xdp_buff *xdp)
> > +{
> > +	xdp->rxq->mem.type == MEM_TYPE_PAGE_POOL ?
> > +		veth_xdp_get_pp(xdp) : veth_xdp_get_shared(xdp);
> > +}
> > +
> >  static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
> >  					struct xdp_buff *xdp,
> >  					struct sk_buff **pskb)
> >  {
> >  	struct sk_buff *skb = *pskb;
> > -	u32 frame_sz;
> >  
> >  	if (skb_shared(skb) || skb_head_is_locked(skb) ||
> >  	    skb_shinfo(skb)->nr_frags ||
> > @@ -762,19 +783,9 @@ static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
> >  		skb = *pskb;
> >  	}
> >  
> > -	/* SKB "head" area always have tailroom for skb_shared_info */
> > -	frame_sz = skb_end_pointer(skb) - skb->head;
> > -	frame_sz += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> > -	xdp_init_buff(xdp, frame_sz, &rq->xdp_rxq);
> > -	xdp_prepare_buff(xdp, skb->head, skb_headroom(skb),
> > -			 skb_headlen(skb), true);
> > +	__skb_pull(*pskb, skb->data - skb_mac_header(skb));
> 
> veth_xdp_rcv_skb() does:
> 
> 	__skb_push(skb, skb->data - skb_mac_header(skb));
> 	if (veth_convert_skb_to_xdp_buff(rq, xdp, &skb))
> 
> so how about just getting rid of that push instead of doing the opposite
> pull straight after? :)

Hi Toke,

I believe this is done so we get a proper headroom representation which is
needed for XDP_PACKET_HEADROOM comparison. Maybe we could be smarter here
and for example subtract mac header length? However I wanted to preserve
old behavior.

Thanks for review!
Maciej

> 
> -Toke
> 

