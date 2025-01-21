Return-Path: <bpf+bounces-49346-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 238A7A1798D
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 09:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7A2D7A3877
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 08:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBCA1BC065;
	Tue, 21 Jan 2025 08:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b="BHHpx6tm"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00007101.pphosted.com (mx0a-00007101.pphosted.com [148.163.135.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EC8192B63;
	Tue, 21 Jan 2025 08:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737449385; cv=fail; b=HoLlNE39PvZI6Z9rUvwaFNkzESwsTMTIuc8rzXR/W0M5YAf7yuDrGnHaOJbEgjFGkydoUiQzj9M5g9+6lgVsNcuB8s27O0qW1JE+rLgcw+6NKGkq9p6+6RZs3RW9veOAoPauXHDWSMzP8jSsm9SZ2ySsMEf5Oef07sHqpCTM8vs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737449385; c=relaxed/simple;
	bh=mBSBi+tXv2T2hVwowDLjHlcnPcz8gM2fGe8lU+IRH1w=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YHbJGbabO8PiR+deNlGWC/5fjaRBfXTMz+cMY2sfunQyK8KUTetqj7PG6I6WhyX816oTMdpbjqz4ZYvQ/RAHv+Bw+lJp2ub+bptcfz7C6Mk1JWHvIqzjeomY8nzmO/pyTWkkThUQi/8WESHt3dMJhj2oSC4CVhkCfEv1JC4hE+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu; spf=pass smtp.mailfrom=illinois.edu; dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b=BHHpx6tm; arc=fail smtp.client-ip=148.163.135.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=illinois.edu
Received: from pps.filterd (m0166256.ppops.net [127.0.0.1])
	by mx0a-00007101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50L6SCZb015692;
	Tue, 21 Jan 2025 08:48:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=illinois.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=campusrelays;
	 bh=OGUg/bTeTsMcNjn16g8gc6i1fffG7NncCpAnaRXBZ9s=; b=BHHpx6tmFvs9
	d/aM7zWh1NcOgIpQcEC2S5bdOZEkRRKkyHQA472AHPi4bhJNakpHs2rqiQRayRfB
	yujU85r7DVcSq38o3AoijFcWmB5mJMVZNlDQTmOwTw9DX0imD3oGwzB0wL0OWWVa
	BKPZEFmNgnnsMkLQMoIpAXsMeyB4GBAimBB6j+PZlsJsMWTytQc5/Gg1fDwv3Gr+
	zyZyiog01mMwHns7RrVXxLgBb/EHjAAqoTM+7K8QVxeXe/8m3TswOjDaGXk/B9T9
	j2SkEgZPm+gOiP+tQDqGugKqEj3vQVEvfL7hP3s0g/vh8pHKhAduy0hGWCZEOko+
	N6mJ53C2UQ==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
	by mx0a-00007101.pphosted.com (PPS) with ESMTPS id 449vda3g7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jan 2025 08:48:58 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DJPhjupmoaAhaKVDeq/kJy77QcepwiNwrj+a2c12QR/rcx0x7PczuMG1Yy8ZfO7FCyyznXgsubzGwm2/bUCTk89C2LJZf/lgOemTn5miBz6dDyljZjjG+48vEx5hBGsztHnHylFnsdRaYWpYGmBqoJDlzCLlbXpVqGqnaCvP+zajvHEpXSAbLcnm7l1WvI87C1qqbfz6fbQEL4C+fZQAR+JY7xkXpALBCWkzStT0q5579V+9DM9j5xaZQaaq/e6/AT70x965qX4ZMxLdNM3N+jC+GdyNJLi1O2LWt3d6fwRfJRsy2xhNqCI28nICmv0vQW9pjJSTTz3sinzUkHzbnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OGUg/bTeTsMcNjn16g8gc6i1fffG7NncCpAnaRXBZ9s=;
 b=uqGs4aJf/s8sbLNqT5Y3D/od1CYa80jsReH6Nt0i+4px9gp56u8tF2c7RRvxzFqaoPoAd8hPKQ+CWzMZDi/NJqO7lTWvWeCZ191Frqo4KQ8xd963n3yiUiaxvIw0kNkfJKMOnj3dPbLJIk/dcRES7XPpnCysUXB2xLHVDRLQSqWH5CT20CV4MAUbZNeOG7zTzgg5i1GFyEVQ8RsckAU6BTVJvcScU9MdoZlKoQnsK2Kt8F1fyZ1eV3chdJo6FC4aElidTK2C+uo0jt2c0FFcC3LPWHB8EO13tZdCY1N3jW/XhLEWnDwHaM4WkYtGpX13Tl1SxPnudgPBUDSq0/Q3aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=illinois.edu; dmarc=pass action=none header.from=illinois.edu;
 dkim=pass header.d=illinois.edu; arc=none
Received: from DS0PR11MB7286.namprd11.prod.outlook.com (2603:10b6:8:13c::15)
 by BL3PR11MB6313.namprd11.prod.outlook.com (2603:10b6:208:3b0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Tue, 21 Jan
 2025 08:48:56 +0000
Received: from DS0PR11MB7286.namprd11.prod.outlook.com
 ([fe80::d52:d2da:59c7:808]) by DS0PR11MB7286.namprd11.prod.outlook.com
 ([fe80::d52:d2da:59c7:808%4]) with mapi id 15.20.8356.014; Tue, 21 Jan 2025
 08:48:55 +0000
Message-ID: <7bed760c-7184-4719-8cda-1b7fcbc8577b@illinois.edu>
Date: Tue, 21 Jan 2025 02:48:54 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] samples/bpf: fix broken vmlinux path for VMLINUX_BTF
From: Jinghao Jia <jinghao7@illinois.edu>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Ruowen Qin <ruqin@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Nicolas Schier <n.schier@avm.de>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250120023027.160448-1-jinghao7@illinois.edu>
 <CAK7LNASn2aS6kcOy2Ur=tv_0fuEw8Gv06cVrOJ0x==AD9YRwRg@mail.gmail.com>
 <c07454ba-d124-45d0-815e-2951c566e0bf@illinois.edu>
Content-Language: en-US
In-Reply-To: <c07454ba-d124-45d0-815e-2951c566e0bf@illinois.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5P221CA0018.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1f2::13) To DS0PR11MB7286.namprd11.prod.outlook.com
 (2603:10b6:8:13c::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7286:EE_|BL3PR11MB6313:EE_
X-MS-Office365-Filtering-Correlation-Id: d66b7697-e375-427e-5848-08dd39f8705d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VjJJY2s5aFA0NWFUY2tWU1dVZUw2aGNONGhKZzRTUVk1ejY1S3JtcCtuQW5D?=
 =?utf-8?B?bXhWZlFzbE0vd1RtVTdOQkJyRjA3L3VVcTI0Q0RPaFNRUlh4ajQrb2NtUTJO?=
 =?utf-8?B?c3hkNGdUODFkcnByV0lESzlvZDI2SnJ5dzFUbnB3ZlhMaWhsWm12ZG9qVnFy?=
 =?utf-8?B?aUl1VUdLZzVZeDErMDBaTXVDWk5zVGVFUnhlK3Qvb3hUME43T29kL3ZDQ3N2?=
 =?utf-8?B?VjRnaVlzbXNQMzFZR0VmRFZkVW1WS0dQQXpQeExwbi8wMkt6SVd0M3BLVmh5?=
 =?utf-8?B?WlppdE05blFrR2lKcnBxL1FNbjhyeDFncjRrNDNoa2Y4dU1oY3MrYStuNmkr?=
 =?utf-8?B?SWdlZzczcGR6MkZXMkpPNWkvRnNFQi9kZUlwNDJqYUdpZ3pyelRGeUVzeFUz?=
 =?utf-8?B?TE14c3h1YW1LNFBGSXdWSHFUdXBDS2lYMUJnTDUwOG1odmJxMGVVc3dodjFP?=
 =?utf-8?B?R1FDZXdVNlByTjJmUmlUMnRyTEMyZ0R6THlnQlVXak0wMUN3eWd5ZDVkVU16?=
 =?utf-8?B?dmxpQmJFTnpXQXl6a2dXQzh6RzRtNnFBTWtsY3JQdE92WnZJZUxVVGxmQXdG?=
 =?utf-8?B?a0lZems3M1UvK1RLYU5XSmd1RlBXSnFnN3NlKzZMWjhoYzFpR2czZDRmVVBq?=
 =?utf-8?B?N3VsdGg4bVNqazRDM0kvbmdOL0NYK3BwODhoYUJyZzNEcnNMQTRqMmo0NTBG?=
 =?utf-8?B?R3FYdjFoYnFJN0tWMmlLQm8vZ2dhLzVIUmd2OTAyVDVNWE1ZUlZFVS9zMGp6?=
 =?utf-8?B?OCt0T0I1MUFnZE1Fbkp1d05iM013WEQ0N0FGR0pPRFhvMHJMdmovRVBTc01S?=
 =?utf-8?B?SDczOVFsTy9NTlh3VkJSYmtIck5kcE1qa1JxZlBDUEovZ1RNcnlrRlNCOFFV?=
 =?utf-8?B?NGs4MUxETCtxZkgwUmtUR1dlVWFSeEgrU2RnSEJXZlhNeEppQnd1M0QxQ2Iv?=
 =?utf-8?B?S3FqTVJVejdRaDFtRlZXdFRPcExSMS9yenBjZFJmTlhLYzlZQmNhcFBUTG1U?=
 =?utf-8?B?Y2tQdEFPLzl0QzVWWngxaDJvL1hnWWFIL0Q0YnVnMUNudEVxNkxyQUpYRXRQ?=
 =?utf-8?B?V20xeUtRZldYY0lNOGFxU1ZHeXZtZHpDTVZxbVBDRUIvYWdRM3N3QnhqZVo5?=
 =?utf-8?B?NmhhemJoUzFBc0xYaTlFRFRLZ0lObHlGSmFCd09SOE9QOFRaRTRRbjdKU1Jo?=
 =?utf-8?B?aGoxd2pSdTI4NW9hSkRYSkUwTGxyVFA2cTRVNndtQ0crclR1SnF1WGFqdjRJ?=
 =?utf-8?B?NEc5bm5FQmFTSWpnRmtBTFhRbWltMmhsSmdqczNneEpvWHRobGtaakVxbEZ1?=
 =?utf-8?B?L0hZT2VKcnU4MnZiUlhFeDhuRThLM2JaMTJzdi9tbm9OMDZjMHVDWUh6c01U?=
 =?utf-8?B?ajBMSFFaa0Njb3hOaGx3OE9UeENzaldyVnE1a3gxTnNWcFYvSFY5ajcydXI1?=
 =?utf-8?B?cTR5Z2hWeHRoODNzWkxaTmlrVnBQcGV2eTM2c1NDQWVBbG51dmpoenR5alBa?=
 =?utf-8?B?djYwV0FDN3VaVVFuV1VsbVVxM21jRWJzMVQrcVJFcy9qRWJNSXJLSlgrNjB1?=
 =?utf-8?B?WkRVakk3dTIvdTl3WmpxUE9GQVRqTXBQZEZWV0JoZzJLUWxXdUk4cU16bU1F?=
 =?utf-8?B?WEV6WnRCcFRCU25EZCtUSjlCMWVsQnppN1NkcUtGK3FYTGlhM3Bad0R3Z0ls?=
 =?utf-8?B?c3pFQ0hsQ1NiYjJPUmc3MHFWaHJqaWh3eVNjdW1Kc1N2dzF1RFdIQTNXS2tm?=
 =?utf-8?B?R0JIR2sreEh6cjlsdkU1bFF6bjR0ME5aeWtGV3U2eFpWY2RvL0xLYmNiZlVP?=
 =?utf-8?B?alYvbGlKQ3h1ZUI1bTBGamh4SURGdkVvdWZsUnNGR0M1SStlNWFRQWVaVnhy?=
 =?utf-8?Q?4ZsT/g5EFR5T5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7286.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXdZaUNPWWNOMDBZMVdCWGJRL1FwcXVaSElnK0phSjFaZnFjZVhiWnlpTUx0?=
 =?utf-8?B?LzdLRitJdzN3Z2w2SzlvUVNtK1RjbUI1VlZSMzBKbHFmMGhVNGNMUE00bW1G?=
 =?utf-8?B?NDdraVltV2lVQytrdUZRaW5SNkY2d0FiTXIySkdnV2ZyMmJPL0VZMk92NHNi?=
 =?utf-8?B?NU5IV3hQVTNJaXhVL1A5SnZmLzhoMURoK3pnV0haSHZsSVhwTEpnR0pURzh3?=
 =?utf-8?B?SzRIVHF6cDZRTmE0RFFwUmtPRVlwdDZudXVDbnoyMmMvWlVMdnBJL21GQ3B3?=
 =?utf-8?B?L0xyOXlEZzBZVko0ZzZWMGtrSSs4c2RESk9YVmtScjNUd3A2Ni9OTkJmSnFR?=
 =?utf-8?B?TXIwOTFQdFNlL1ovN3ExelZDSTFPNzFIMVAwcUtUamV0ZDlDcmwzakhMNTV2?=
 =?utf-8?B?dkRqZkJxZ3ZXcnRLSjlZK2dIekw0anVFSEVDNzgxbDZwQXlUMDNxVHdTVVRt?=
 =?utf-8?B?dTBaWE9vYzZvZjF2VnZPcHhONnBHZWl0dkZId2R6WkQwRHdvOXJ0OUQvdmkw?=
 =?utf-8?B?d3RzeENVdHJzRVFuaUdHcjhJaElqM25TUTgvRm0yNEcrVndmWGNuWTliSEp1?=
 =?utf-8?B?MkV2TFJma1djRGE1Tkl4OVMwdnB1VTNpa1h0OENyeGwyVFVWNjJhS2JnL3hI?=
 =?utf-8?B?eVZmd2xnYXZKdHZvRFBmZjNxRjVBSzNtS0VSOXZ4THFhMEFSOEV5dmcvcXQr?=
 =?utf-8?B?ZTNEQTVwcE5HT29sNWx1YndGY3ZscHZSMzQ0LzNpMWdNV2FFRytHRkd6dnNh?=
 =?utf-8?B?OURscGgxSkt6OWJvQjlySkVBL1pRQ0VuQ0lUbWdYOG85UUZ4TzhZUzdqV3Bx?=
 =?utf-8?B?VjRPNzJzcU5OcTByVDhYZHpnR2gwd2RsQUxNYnpIcTRPMlRQMEpuR2xJZXpJ?=
 =?utf-8?B?REtRVTc2dFhBYU52aFdLenhHQkRYYVhBeCtxdFQ3T1U4eU12TlZxRC9mTCti?=
 =?utf-8?B?Zng0a0FQRHpmMUFOdFg4bEU2RzlWK3pNczZzbU5vaDVhYy9LNU44emVISlhO?=
 =?utf-8?B?UGZzM04yQngyaExWQVFNcnQrWnFJWXArZUhRbmxtV2d3b2Y1Mzhudm1XNG9j?=
 =?utf-8?B?bklsZW5ycUk3dGVjcDhleHdlSzJJV2ZUakJnYXJzMzl1eWpFWVVYeDFjdUhV?=
 =?utf-8?B?MVdaMldOMVNQRE81NnFObUx3bFRUOEFra0UwL2pjOEJGdVNWV0VOL2tsRHlL?=
 =?utf-8?B?alFneWR4bkpMRTFLempiMWN6cFFSK09DM2QwSHVaSWxHYWVZOFlQbCtDQ3Uz?=
 =?utf-8?B?RzZCN3RwQjJVcWs5bUpENFI5ODRKbkJWTlVDSzZoTG04Wk5McFNaVGNiTmNU?=
 =?utf-8?B?eGRlUW12YWlsTlZ1SVVHa3BPUHl0T2tJQ2U0WlVvUTZ4TzJKRmlzRDMxQmda?=
 =?utf-8?B?U3VCQllTcG9FMndxS2ZvVjJNT0dJeStBcXVISzR2Z3F0TUorb0VBMDNEUHpX?=
 =?utf-8?B?ZzNJeWxmcDlWMFpjd2pMSDlWeTQrUmlOZUt3cllvRGhWNUhxcjFrcUkyaGdt?=
 =?utf-8?B?SzV5eFRqV1hYL1ZMbUEyTHRWbFJXQ0tiZDVReUpkR2VjeC9LWkkvOE9uUDhh?=
 =?utf-8?B?R2VRQ3pkRU5LNTB4T2xWTTJzZHNLaXpleDJWNUdyQ1E1cXpTYURiY3V1VEVt?=
 =?utf-8?B?enpJMmVqNEh1eEFzZ1dSYkdOeGNHR3FFNDFwMG1ydVNKRDY4MXF1NXF2YlB1?=
 =?utf-8?B?U2xXVDlXQ050RXNOa0trdWVET29IN0ZsdFQyTHcwbGdUa21vZWFVNk0vUk1l?=
 =?utf-8?B?Qy83cHJXb0JGVDczSVJvNVE2cU1MdXZYVHNTZXByNEN6WWk5OVVmMlpqN2xQ?=
 =?utf-8?B?dHROTSt6RDR1dTFPbXNTTDVQbGxaNzN6NGFJQmZPN09BM1RIb25QOVpJcDU2?=
 =?utf-8?B?MEwzWWlXa3lFYnFBZlpQVHR2MytoUDYwTldFRUNCalRBNCt6ajFFUkNLRXhz?=
 =?utf-8?B?WG4vUGttZitkTmNLTHVFVWF6SU0rcmRvTHRab1hkd1A2UklIR1VhcXUyc0tu?=
 =?utf-8?B?ZXI0YjQ1bHViU084U0hsTGFBZ1lFVWp6cDVWTXZLa2ZOZTdwYjdOVm80QTls?=
 =?utf-8?B?YlZyS2prbUozczFoZVkvVXorQmdzVHNNVUNINHoxWGdKWGFZeDlLenZVQm9E?=
 =?utf-8?Q?MiTnnH3A7x5UHNeTk0GuXJhrr?=
X-OriginatorOrg: illinois.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: d66b7697-e375-427e-5848-08dd39f8705d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7286.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 08:48:55.8063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 44467e6f-462c-4ea2-823f-7800de5434e3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rt6rbJZr3vjnXkHVvaTPNOV5A78l8Ul62exonZMj5tt5S2deVR2rEo+90c0sQMyregF9+Vl0+na2oJvM20VOMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6313
X-Proofpoint-ORIG-GUID: goIvVI1WGqDhCALTKXeqLrKHi2rqZcMG
X-Proofpoint-GUID: goIvVI1WGqDhCALTKXeqLrKHi2rqZcMG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-21_04,2025-01-21_02,2024-11-22_01
X-Spam-Details: rule=cautious_plus_nq_notspam policy=cautious_plus_nq score=0 mlxscore=0
 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=903 lowpriorityscore=0
 bulkscore=0 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501210072
X-Spam-Score: 0
X-Spam-OrigSender: jinghao7@illinois.edu
X-Spam-Bar: 



On 1/20/25 6:47 PM, Jinghao Jia wrote:
> 
> 
> On 1/20/25 6:42 PM, Masahiro Yamada wrote:
>> On Mon, Jan 20, 2025 at 11:30 AM Jinghao Jia <jinghao7@illinois.edu> wrote:
>>>
>>> Commit 13b25489b6f8 ("kbuild: change working directory to external
>>> module directory with M=") changed kbuild working directory of bpf
>>> samples to $(srctree)/samples/bpf, which broke the vmlinux path for
>>> VMLINUX_BTF, as the Makefile assumes the current work directory to be
>>> $(srctree):
>>>
>>>   Makefile:316: *** Cannot find a vmlinux for VMLINUX_BTF at any of "  /path/to/linux/samples/bpf/vmlinux", build the kernel or set VMLINUX_BTF like "VMLINUX_BTF=/sys/kernel/btf/vmlinux" or VMLINUX_H variable.  Stop.
>>>
>>> Correctly refer to the kernel source directory using $(srctree).
>>>
>>> Fixes: 13b25489b6f8 ("kbuild: change working directory to external module directory with M=")
>>> Tested-by: Ruowen Qin <ruqin@redhat.com>
>>> Signed-off-by: Jinghao Jia <jinghao7@illinois.edu>
>>> ---
>>>  samples/bpf/Makefile | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
>>> index 96a05e70ace3..f97295724a14 100644
>>> --- a/samples/bpf/Makefile
>>> +++ b/samples/bpf/Makefile
>>> @@ -307,7 +307,7 @@ $(obj)/$(TRACE_HELPERS): TPROGS_CFLAGS := $(TPROGS_CFLAGS) -D__must_check=
>>>
>>>  VMLINUX_BTF_PATHS ?= $(abspath $(if $(O),$(O)/vmlinux))                                \
>>>                      $(abspath $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)) \
>>> -                    $(abspath ./vmlinux)
>>> +                    $(abspath $(srctree)/vmlinux)
>>
>> This is wrong and will not work for O= build.
>>
>> The prefix should be $(objtree)/
>>
>>
> 
> I thought the $(srctree)/vmlinux is a fallback when $(O) is not defined, am I
> understanding it wrong here?
> 
> --Jinghao
> 

I played with kbuild a little bit more. It seems that the way the Makefiles are
set up does not allow a sample/bpf build w/o O= when the kernel itself is built
w/ O=, as it directly invokes the top-level Makefile. If O= is passed to the
sample/bpf build, the $(abspath $(if $(O),$(O)/vmlinux)) part should take care
of that. With that said, please do correct me if I am wrong.

--Jinghao

>>
>>
>>
>>>  VMLINUX_BTF ?= $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS))))
>>>
>>>  $(obj)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL)
>>> --
>>> 2.48.1
>>>
>>
>>
> 


