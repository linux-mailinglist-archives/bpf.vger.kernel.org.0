Return-Path: <bpf+bounces-67350-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0751B42BFA
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 23:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87EC4582857
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 21:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BC42EB5AB;
	Wed,  3 Sep 2025 21:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JBRbyKl9"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82FDEEC0;
	Wed,  3 Sep 2025 21:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756935234; cv=fail; b=JA3okF9PHtAtk1vnv+Ce9EK8IJBCTsCCwECNLzKqrEB/vAxrN8ikcqR/Nw8FYeCse9uWztsIyDLYS0TliKj5LkSA82oX14mkrdFcbd5wuiu5RVmq0eJl55QrkqLCwmNgAORSaP2+2Yn4kHhtMiPEwaVU0xMI0H2Rgh4406s3rJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756935234; c=relaxed/simple;
	bh=0X0KEwHRG+34+rvfWiOr2SUxNahprtnu9pxzSCHwb6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AqN47NNaCxWMjUlnvBEPzgn28TsgXbC6zO1zsK4UbI6/QOhQem+lgYtNE9lz983gy7U6HE8R68mJ/PGT+hW0ZkikxzXZE5alkBetavsDifHNJj9dnD2wiigdDGIAKiHvbUA8QTRpJoeD/4Ovrd0vb1EHf7DkHdjYZPGS8KSE3nQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JBRbyKl9; arc=fail smtp.client-ip=40.107.244.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RbgwaNuAVdf+4u9mzUaHVUJSL/yNCR2ww6UFN1Ogf13re2BocUSsmUFScd8MMpK7MLn8FLCO5d2Wxku0evDJcfGo+1uUtvjMR02uetLjV/Wf/4kuBbIpzwh88otP9pxwHXqukTTl0snX9RbnVwtx4BoZwT8Hsjck+A4VIKhXIVqH6igQ24i5VFdpdWTdoNppr+NSqys2/8JnOHefolyTiIQP2N0DCkkMF5/OVIAvFl9hHkjfgojGPyLWs69lefQVmGKboGmsb5N+CdrEJfS+I/jC56MiP5QiTVp+bVS7uOrC4B1ZZeZrwbM044yhVorxyuSQ4/pAC4DwINQ2BfwIPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L7sI720yXGM+ppYJgs7ZR2NDFPBGNT1EQXbpLiYSO0o=;
 b=WL3MLTKWGjeHZbS15st3sqgYZdmmKQ3r+1yPBsz2jBzUkl+zb2ztjQ2C1DR+/2es17F3RWVfU1623d1icp3k99GXY+XN368b2gaYPJsHgslHLeokhaTJr7UR8/JmXqTpyYkPK2yUxSFf1d40SVc21VN6eSNyZEBMD1miZ/83o8Z0F2TTSkaq4gldN1pSzxqGpsaQHpvo30yFHiSzz0rOeU82MmBgEijfya4ew3JlzAsf7RKS3ddoO8NMCQtEczQiWO7E8YWIyXDG82x9QOs70Z2uVwYEyB7iiQim7PxxIVtAsrLindCGgFgFfovwYroK0WVEJ8WqiLpWRHas33E+7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7sI720yXGM+ppYJgs7ZR2NDFPBGNT1EQXbpLiYSO0o=;
 b=JBRbyKl9mZb1bPlrN9ixEp+nMDxpyfF9sI9wlRyZSZIBItbMJ0S6XPssWhoQbfGhTbm188jFRYI1yc8XmbAjXcK55W3JNOD01SQ7ylxG1YruVREG538x+xlD74le5OtwJwjLcXdrohpOyxNr6N/Jl9nUB47nXP76kNaWAJAWzr9SU/EjeN0tJ1baTBkjkj99tGBdw+Y4v3LuWquOyaHpsZuMh6FaYVM5aEaQVtLC8QvYKJAC6FOjsuJzLwimzjqXLJPP6KPqpMNJ/QgPDNyJpPYQ19NUdw/f9DuMTqMUWfCSZFDtSL9Rjvl5ikpn4HnIpn1AZwD/OP4R1hJgGiSbXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA1PR12MB7151.namprd12.prod.outlook.com (2603:10b6:806:2b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.29; Wed, 3 Sep
 2025 21:33:47 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 21:33:47 +0000
Date: Wed, 3 Sep 2025 23:33:44 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luigi De Matteis <ldematteis123@gmail.com>
Subject: Re: [PATCH 07/16] sched_ext: Add a DL server for sched_ext tasks
Message-ID: <aLi0OOISvMNn7j59@gpd4>
References: <20250903095008.162049-1-arighi@nvidia.com>
 <20250903095008.162049-8-arighi@nvidia.com>
 <aLidEvX41Xie5kwY@slm.duckdns.org>
 <20250903200822.GO4067720@noisy.programming.kicks-ass.net>
 <aLin8VayVsYyKXze@slm.duckdns.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aLin8VayVsYyKXze@slm.duckdns.org>
X-ClientProxiedBy: MI1P293CA0023.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::9)
 To LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA1PR12MB7151:EE_
X-MS-Office365-Filtering-Correlation-Id: 43bfba76-7590-4ebd-e630-08ddeb319089
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UkRKWEFqWXhPMnpSSE4yditCWEJsVGJLQjc5VGJXcjVINjh1eDBTeGdOWFpw?=
 =?utf-8?B?OHdVQWhwRGIwc2EwcEdMNVpXbHRTdjRPVDhCWlBLdVBmK01ROUM2VytiWlM2?=
 =?utf-8?B?OEY4ODRtb3RYRnRJN1lPaCt6RVBVVGxMWjZ4UXlSbjJQek05T1dCTDNBa1FM?=
 =?utf-8?B?b20rUjZpRlZuQWt3WFA2Y09lY0haWUYyTW9MakpHemg0a1hkN0pxR3RYWHQ2?=
 =?utf-8?B?NVNLMFZOYzYwNUV0Ym9XQkE2STNjd3h6Qyt3b0s5ZFpWRjNjMVlPR05ESUpz?=
 =?utf-8?B?OEdjUlJjT3VqZ0xjczNJR2ZtVEFYbnhMeEZzWGtoeGw2KzdUWlcycENMc1NO?=
 =?utf-8?B?R1VpZE9zc0Q3Nk1MN2RiVFlDbHREM285bkM3dFR1WXgyajk2ejZDYXVXQ1dl?=
 =?utf-8?B?MUpjWG15dFZJWnVyTzMvb01oZVo3bWg2ZTR4Y3Y4OXhiRC9pb0RldDJUYkJF?=
 =?utf-8?B?d3lKazJKaUkyNTAyc2JwL1hzeFlYT25nR0YvZHFEOFBSbDd6clJ6NEpKTjVm?=
 =?utf-8?B?Y01WNGlxVEVQOExPUXRDblV6Y0pCalB1QVEwQ09zeDZTcFE4ZnNsNFRTOHpI?=
 =?utf-8?B?TFF2UGRQZFJWVzhCSW9SK0UxZVRlSTUxQzJpd2JDcHF4cnBVQ0RrTEsvQitZ?=
 =?utf-8?B?RkJoZGo4dWVTN0NoZUtudlFyQ0xNbHMyUVlSUk9WZElyaHVJeXdENnBXK1pO?=
 =?utf-8?B?d0xRL25hUFFsTGZYdWVZc2txT1BOcHo2dEFmMmpxT2g2RDNYUEpmSmFiS05q?=
 =?utf-8?B?NzNjZmd1ZkU2Q1lDMWwza3JHbmE1Z1d1NlV1RjBRQ3J0bEtHSVB2WmtKYTVP?=
 =?utf-8?B?bXVRazVkaTVENWI2ZGxQdGswYzVsWk81YVQzb0E5RnZSUFA5MDJpTFVzN0xV?=
 =?utf-8?B?dFBsTDRLWFhIV2FNWnpkV20zMkFha082OUlTb0JaVnR0VjZ5emwyVUZFNURw?=
 =?utf-8?B?MmVmSVlwc1gycmpPZDFrcXdESDdvbzZHN2trVDQ1d3d6cFVGODRCSW1jOElo?=
 =?utf-8?B?UERyU3FZMEVRR1pMYWx3QWRaampPdmRzZGw4RC9qZi95VCsrNmRqY2g5NWhW?=
 =?utf-8?B?eDM0M2FFeWNMOEVPSk9QbkRabVl6UDUzU0U4RUNMazd4djQyRGVtQjdJcExv?=
 =?utf-8?B?NFQrQzJ5SXFudmMwZ2t4QTY1UkhnUkg4T2ZKSEl3Rzl0K3IvVlRIYzRWNm1m?=
 =?utf-8?B?d05yaGU4SXZzU3cwaXlnL0Z3OEhldllFWjBBYXc1Q3BVQkhKZGxFTTZuOTk1?=
 =?utf-8?B?WDFpeHRHQ2FLbWF5K0ZuSW9LZ0ljckE5VWdNUHBBUDlUUnY0T09CVkhwQlR6?=
 =?utf-8?B?RWxHN3lwVEZURU5tZ1NCTFBjRWJQbVB0Yk9wTThKT3piZlRucmREano0UHJG?=
 =?utf-8?B?bWF1M0FNYjFzRTNWZStYSEdiSHdhc1NMZ0dHWHFSNGNKak9DbFZ6djVDV2dU?=
 =?utf-8?B?NzFSOXFOanhoK1pEQUxnS09qRUI0ZHVIamc5ZmJWNGlKZm9Sa0FxTU94MWQy?=
 =?utf-8?B?UU1STlAyTUljVldIYldGalNhUitTY3VUWG52aVpxbTByaWk4ZjI5cmlRZkwv?=
 =?utf-8?B?ZFdVbmZQYW12UlNkREd2MU45ZmErOWM0QnhwMi9NS29pOER5RDlrNEF4d2tl?=
 =?utf-8?B?Wi96NmhDa3J6YVplQ1k3WU9BZkVSNjBFaU94bmJHZDZ3dUJpRjNwdXdCVm1F?=
 =?utf-8?B?Y25sZVQrNDBzSmt1Tk03RUJub0VCalZGcVpWUzBXMVEzU3NMU0xIZEpIZXNn?=
 =?utf-8?B?b3hLL2o3YS9leTZ5YWZNVnozNllqZ043MWpyakV2MmVUdnNvMjZkekJYZ3dI?=
 =?utf-8?B?QVYrNDVWQnBLM3RlSEpSUExvbS9KNi83NXV5NDlQck5pRm4vVExURFMvcGNB?=
 =?utf-8?B?amNJeDRXd1hMSnpmM3lJOUdyK2YvbitZNjdIWGxyc0lhb01NM25iLzgxTjEw?=
 =?utf-8?Q?+lNwlhkx+hg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZXlKemhZNVdmalpmMXpYODA1NmZuWmE5OE5KYmVFdjM3Q05UM3MzZTYwM1Iw?=
 =?utf-8?B?UjhzZUhSdWcxVnJFV1l4UytEVWZHYUQ5RDA5T0dHL3BNTmJabUs5KzExVXEr?=
 =?utf-8?B?UXg3U0plUVpMeGU2S096YW40Ym5rNHBXS1IzendFVkE1cVZrTzlMSzlpT1g3?=
 =?utf-8?B?NzlpQW5INU14dFBUY01aV0dTTjB5NnZRU3N5VzM5UEhJbEZkOGIwc3ordWtI?=
 =?utf-8?B?SEpoMksxWXhyUWpvcGY2MGRGQUdGL0U2aVFiOVdkWG5PNGNpTWVmOW14dVZw?=
 =?utf-8?B?OHU4K2dSNW1rQ3pva3dNeGF1QmtCQWpnUmhSOGNFZXloYlorTXMrNlBPbFpm?=
 =?utf-8?B?ZGErdGRiSEhIUDZrc0dHUnhISDhUcWwzZXFjMUQ1ZU9CR2RWV0xrMFp2YzA5?=
 =?utf-8?B?T3p2Qk5YN0dYMGVvWXdBY1lTOGdKQkpKc2hnZEtDa1N1NXhOWlNqUlpzRTJj?=
 =?utf-8?B?eGc1MFV5SitjRTRhMVBCQzJ1aE1Cb3NMaFo1V2RhR1NudldHNTI3Rk5tQnpv?=
 =?utf-8?B?UEhPU2FWZ1M4WEY2TXU3K1dHTklHSWVpbVE5UDV0VmpMNnNuUzE3VERKcjJt?=
 =?utf-8?B?dHpWbkRyR2Vkc0tRK0srRVY2Tk5DcTVVY2JXWnM5QVV0am0wL3Q1bEx3MlVJ?=
 =?utf-8?B?UkdrWWorSHFrQWJaK2hINWM3L3l1QzlYVkFuKzBoTFZIZnBJbllMaUtBQ0Y3?=
 =?utf-8?B?TVlMNVd6dmorZ0phMGdNQjdaTnRsOWMzZngrQXBBSEtUQWlza09uM3MybldI?=
 =?utf-8?B?YUUwWjJjSjhxMDUvMTJjL0dsczh2Q2ZaTkJFcWt3WmdUMEg2K3pzaHlraVhz?=
 =?utf-8?B?djhXelI3WXRxa2Qxa0F1RUk3elhxeDQ2YXRrS2QxK0M2dTVOeVVWYWliMkNt?=
 =?utf-8?B?MjNqWGVyNCtlMXFQNXdHQ1FobTcrWTRaRmNpSFVqR2FkMTdBcFRGN1NRS2Fl?=
 =?utf-8?B?VEpjYWhpZXlmT0RYQW9hWjV3ZTd6UTZrTVB6MHBXczdpclgyMFJ2cWwyWjFX?=
 =?utf-8?B?SHcrQ2pMMWVBc0JyVWkxdFIwZ0RTZnUwSTdIaE5Bd2JyZ3N2WEsrNTB6RmZv?=
 =?utf-8?B?azl0NjNrVGdscVdmRXcyV29DK1ZzaytoSWdGTTBiMHVzc1hhNUJCNzZQcTQw?=
 =?utf-8?B?djNESkhIblgwRk43VUJHUllQRitLYWVjYW5rQXU1SysyWHAzVVFQWExIMU5k?=
 =?utf-8?B?azY0NFpKTnpSOERKc1N0NHQzRUQxdzhTOHY4a2o0eFQ1bUZJQTNRbFd5K2xr?=
 =?utf-8?B?U2YvU0dMZVlwTERyUGllakVDYlZSaUxQNi9Mam5jeHA1OWFrVG5PMTlyZk83?=
 =?utf-8?B?YXEzNWpYQmMrV1E1MG83VE91eEZBa0NJVW9wZmRZTjZPSFlITUJZbnU3akhl?=
 =?utf-8?B?dDNSWmRUVTN4ZGhZdjB0aDJSNkl0cmZTbDh5LzBidnh5SlZnOEhndytHdTdY?=
 =?utf-8?B?RzBKeFQ0WHI2NERmUVRMVGQ3WlY2eVd4RkJNd0d3VG5jeGxoeVRsVzdtSzVX?=
 =?utf-8?B?LzZZSjRPcStnUUdFaHFNbEFKWnBMRFIyTWN1bHRvN3NLUWVyWGhKUU1oVUgy?=
 =?utf-8?B?d25SVVpzUXhpUDBUSGhNaFpXWjQwSUUrREZrZDNTMmovRGVPMzh5S2U2RVdK?=
 =?utf-8?B?M3RBYzJNZU0wK2o4SnNhYmFuL2RyaC9KTUhYMElBcXJMQkVKMzB4S1VSUjJ0?=
 =?utf-8?B?QnQreEVKTnd2RnhlYUJIMHljNnU2M2htbE5pRVZ5MXRKNmlHaEp3RmorRlpr?=
 =?utf-8?B?QXlFVmFjZW9RQ0g3dlNYRVYyYW5OYndTcXlSQU9jbkxQQXVGb21ObVc0eDZE?=
 =?utf-8?B?bFBFVmU0Q0gwSnFpdmtnM0ZnbG9HTE1xcjBIbkdhbFNaZmY3UlFubUpVcmFS?=
 =?utf-8?B?cEJ4ZTdJanduNHV3d0lleUw3a0JROEFFMEw3Zzlvc1V2TDBYbFpsN2tUeHV3?=
 =?utf-8?B?Qjlpb1JiNmVaVndnTHJ6R08zd0k4aVp2TlNDWlRQTkhVcjhyZmdRK0o0Vklw?=
 =?utf-8?B?TklJcW8xbm1kZ3QxODZOOFU1WW9LU1Y2WUZBamptZzc4SWxIYlVIQ2cyYkNU?=
 =?utf-8?B?SUh1WktnZ3VTZmtFbDNvZi84TTJLTkFHdkErcVl3QUtZN281K0tjUUFxVEVN?=
 =?utf-8?Q?YI1slODPHcDo06yWe2kUpY6/1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43bfba76-7590-4ebd-e630-08ddeb319089
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 21:33:46.8951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iQ6tLfn9GweTXo98dem7kMEjCxhbt41QNGYxONhs8uOXB8zI9ggg4Baq+tXpXQVYmUXs+gy5lFcz9t+kXMxRgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7151

On Wed, Sep 03, 2025 at 10:41:21AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Wed, Sep 03, 2025 at 10:08:22PM +0200, Peter Zijlstra wrote:
> > > I'm a bit confused. This series doesn't have prep patches to add @rf to
> > > dl_server_pick_f. Is this the right patch?
> > 
> > Patch 14 seems to be the proposed alternative, and I'm not liking that
> > at all.
> > 
> > That rf passing was very much also needed for that other issue; I'm not
> > sure why that's gone away.
> 
> Using balance() was my suggestion to stay within the current framework. If
> we want to add @rf to pick_task(), that's more fundamental change. We
> dropped the discussion in the other thread but I found it odd to add @rf to
> pick_task() while disallowing the use of @rf in non-dl-server pick path and
> if we want to allow that, we gotta solve the race between pick_task()
> dropping rq lock and the ttwu inserting high pri task.

Yeah, patch 14 is fixing this, but this needs to be changed, because we
dropped the patch that adds @rf to pick_task(). I'll fix this in the next
version if we decide to stick with this way.

About balance() vs @rf, IIUC after pick_task() drops the rq lock a
concurrent ttwu() can already enqueue a higher-priority task, so the race
isn't really specific to @rf and it's more about making sure we don't start
using @rf in ways that rely on the pick being stable until the actual
switch, right?

If that’s correct, extending @rf to pick_task() wouldn't make things worse
than what we have, though sticking with balance() may still be the safer
incremental step...

Thanks,
-Andrea

