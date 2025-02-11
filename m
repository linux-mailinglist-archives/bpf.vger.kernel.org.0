Return-Path: <bpf+bounces-51171-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9297A313B3
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 19:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BEBC18859DA
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 18:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3559F1E32D6;
	Tue, 11 Feb 2025 18:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LmExT9aM"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134F1261567;
	Tue, 11 Feb 2025 18:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739297126; cv=fail; b=aL6fL2DXCAtV0guART5zAeARlIl2F1Xj9z12ECPNhbQMznb60vA5IOko+0Xkz6TZ+sdYYs0vlg39S2v8VaYfzFlLiH6lftGK2h29ITldrf9Y4Lyfqlgzl95/+PQGPRsMOkDmyHInSnmWbQJ6+Nn9Q8gLbdIeQnh9KfHEjww3wlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739297126; c=relaxed/simple;
	bh=k68q1Mcyw4vESxzbBUK6Rnu/tVJSLGSNTeGCokDQugg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=keg4KcUZ6Am0oTYscnHEPyp7rSLqWznqokmAqeqGbqUIkkuhleoHuHGII/Pu5Auq07qipPRaNucFL4UzJH4ggRAqnWz7jgF4X54HzJnVXJuqcUWTPJMyQ09zkJ4Ny4tq0oXkafmSqaEEOoIpPFJg7ruuOPRs07g1LKThQ/RRaso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LmExT9aM; arc=fail smtp.client-ip=40.107.220.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ySJdFmAZi2lUDYSq74ZQ9euYILUUqSSSwxGBNe0K/exVRjMfUI5yf/XGnbrCdM2LscB5UQ4mnFmai2LmAFBzOWx4+rEnn4gH2G6XRRkOb5WoEy4CXdBxDlPXuX9mVm/+wctAger3MbrhJgIbN0enf2Bo/gx4zrPDLas6R/kuusJGLNCG3Q71AW33fEOFGGA8swfqqqD3YnN3MH2RQ1STxcMz/aLOey0Q+xTuEIDXf1jJ//KuBFKk7TGWBJtzss6vwdt99JrOD0tSsZNtxaE5/e+zG3wqCQng0SOZNdf57wuYepkOfXhDhx9XJXB6pCRajx0102k07xM1vqQi8Uw8og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pFX9dzoPlJico7JaI/eObHloMk3PmQumRSZTLRuTQCg=;
 b=V7ZXipx89pwNh0pocghBpJwcy68wQEvVfNy15yTaqnmRpK6x3Z+3KaJZIOsw/ljMrADPJ8c7ciAgMB0vH2+yoXI8WL/Url4V99v/bQYRmIULn0aCtFo4zr31I9dBgum87gTguVIZf3bpO3zqkq8xCHkFnoHAFNpDb/Esfa+TnkZr9dkTJ0vOfHc+w0hIkr500mhEL/A1tyAUH90auUXy6ZJDLgpxG8EaNSESQN/+w5BM/8g/9I1kZinsAfv/Yj5UsJMG67MyDk9cnVzae81bEti4pFyen4LzL2BzZZus/clp265QKw/Eu8aiRie7WaLuctaln/VFYmwDG7RQFb9gzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pFX9dzoPlJico7JaI/eObHloMk3PmQumRSZTLRuTQCg=;
 b=LmExT9aMlqDnUYlqxSvzcARceNSycPLk0PrgS8XOdBpq+YprTtItR2hfGtGE8AiKpf6FwFyUHzudoLpQtd4zQAYe/E20NYuYrFRhXbGdDtG0kZ/JswcFq210yhcgwMUXANdB7f1NuT6GzfgGbLeXQw9s80O0xY0QLSTQ3gkqoJr1xV388l9eeYFwYIK8H6o7QOV/ZSkVAtuZlRFhShyulggy0+3mpZ0lArK3hbYQRI3o5k/fBGbs1vfC5ZXK1iHHqOuAshW1NisPfaMRrxdBuFnQCKnsixdispER1Afbd/ZYWw7tSkYecRz40krrlW7bVM1zJla7Xk8H9OSBVER5JA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 18:05:21 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 18:05:21 +0000
Date: Tue, 11 Feb 2025 19:05:16 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Yury Norov <yury.norov@gmail.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Ian May <ianm@nvidia.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] sched_ext: idle: Per-node idle cpumasks
Message-ID: <Z6uRXG7mGMfH6fAV@gpd3>
References: <20250207211104.30009-6-arighi@nvidia.com>
 <Z6ju7vFK5TpJamn5@thinkpad>
 <Z6owBvYiArjXvIGC@thinkpad>
 <Z6r9H6JukZi19dQP@gpd3>
 <Z6r_NZui9GibrQHY@gpd3>
 <Z6sddk2otmAVrfcb@gpd3>
 <Z6tciKa58iqWZ3eM@thinkpad>
 <Z6tf3Rn0pamy3g1_@gpd3>
 <Z6tie5F-AkGkiV74@gpd3>
 <20250211113827.302fd066@gandalf.local.home>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211113827.302fd066@gandalf.local.home>
X-ClientProxiedBy: MI2P293CA0006.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::18) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|BY5PR12MB4116:EE_
X-MS-Office365-Filtering-Correlation-Id: 710ba82b-9e87-4230-ef32-08dd4ac6a636
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XfGnXO+dvU6OFa/MB6PISa9PcqypoT68KGixYUNVTfTdizUpCdiYTfkrmFuL?=
 =?us-ascii?Q?ode+qWWPXrGDVUuZO3zFcfxmkZE4H+huiV6tKOGGEuS8E9K8IPcCSXSTaI4C?=
 =?us-ascii?Q?t6WCI18u4E86zv74ciI5D/NCXCNPQ49jdTfgCOdaxciwdiqBQHD5d3uxT19X?=
 =?us-ascii?Q?IhvS/lScYr96sx5Ag8IVYN7kD4Af9qih6QG2dnrGcfD+KXGAqL6aV+nc8TX4?=
 =?us-ascii?Q?A3S/nMyoAA8Wd4TEQZ3etL6/ijQqrroFX9BVUqiZhEsCHvxYfGmmjIMCbg2q?=
 =?us-ascii?Q?/crgHcVo5RNw/aMKEo/7BitavCIeYcgPvk2VxyHyfM8oZ7PUYF3aZhUaye6r?=
 =?us-ascii?Q?ECth5bGTfAktD3SLKLJn7HPPWM3IYhEfW3lPxz01dTvDLCYWLAmiq67wJPX7?=
 =?us-ascii?Q?TUetZ6Qk94eOl6brIu6D1OhmY5lWBO6ReUmc5T16usMoz1YiB3zN9RoCYl1t?=
 =?us-ascii?Q?3ajCqLWF/8RpJMGXwI1vypFpsM5WM0SkDu6PfeSWDE1y+v4EImXIHVqel5yL?=
 =?us-ascii?Q?NvBI3wUvIq+Jr4WSCO4byOsbxcaSRkqfmYFtEhHU7f30JpHJFfm0uLZZWbmZ?=
 =?us-ascii?Q?uWIuPVhsj16xzm1WCQXeP1t2+dJFGZfH0lWop5oZEBXdIAbW9EU1jq6Un4lW?=
 =?us-ascii?Q?Fw9032+sPkXL0iNt91V6ANy87tGa/ycpSUx9ta5Qt1JcW/x2/eUdYcQknmd9?=
 =?us-ascii?Q?sUQJxfK8T0Y4d2T7TLyX95bVN+3aHWaBet67e6Lwto2UIBUy881YfnrqEAWj?=
 =?us-ascii?Q?zm3BprFGWdwIoeKwY9c5okUQbiSfa1ZcEg7ebvmJ3VAivItLq09RDh037kv6?=
 =?us-ascii?Q?2W6Z1H6q2KuibCiO7stSzo5N+Hs/QNvPu/V0w18OLPmTweqsvNrlTJFQ9Fh9?=
 =?us-ascii?Q?bM68dp8UBOZ7vSc6vdaR5ftHFpFc1boYxDiDhzhFwLa40Nh4S3BAp0iopSU7?=
 =?us-ascii?Q?Pgue/pCcebmaoc0M9vIOsYlBVciMhygd+Jp42qcbkjiMyivLt6LRYaxnmSL0?=
 =?us-ascii?Q?lvuhxXwGXv9lPnpLFAzXrsph+JTnGOwIqKt71hfGnchJN3YPp4VPnabHJLV0?=
 =?us-ascii?Q?wL2AO2vY1lu9yGAWFoha68lsLlPp8Q9ub+n52E6c80VbU8E2CNqZjRn+AjrR?=
 =?us-ascii?Q?ZSqYGfVzusOWXdazgcBQE9BnON/yLwxzVfhQgCFC3ekL3YiO8MlHUcaJGeNB?=
 =?us-ascii?Q?cXwNO0e7g1WL4cEcCwvjsE6gCNMtJEGxC2lmrlAictAEWtGIuTH3cMYibAMH?=
 =?us-ascii?Q?AVYVwAhH14Rf5zKPnaoF4dp/uyGTEh4wMT6yBuWwYuhEVoQHJgM6VzAzV+2Z?=
 =?us-ascii?Q?PGUnqZUDEe/EF/MxJ1T2Sp5SZVQobV2Cs9cG8gZb05HhfONVhTLTVl7MmOVN?=
 =?us-ascii?Q?h9mqIIqTLw5y+97QnUnjtFlQePGJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZN+uXBtjfxOKMG0DKMKWfbupzeVfQvsjJ80PD8l6c2dNJfmPRAG6vhC6Izf7?=
 =?us-ascii?Q?GVp6FKSaYsjW78V/jhF6oP9OQUsPzoFVqUUXmUJsJJXx7dYcZjIajeJur9/4?=
 =?us-ascii?Q?5z//nJm+roQhYIC/KmCFl1IxTzMpSApysJHT6YOaLn5K/Pr+l2QUHt5pzgwf?=
 =?us-ascii?Q?fRUbX/iw4a3U0H7LxXIGIyHzpyGOZhmdILmi1hKsf9oDHqMuyyJn3gg5x+bf?=
 =?us-ascii?Q?pxCWjNeESS5jcxqG+l/94ICW7R7BatPWOLaZPJti4moJ1OPGhKn9gSdcGedw?=
 =?us-ascii?Q?zwLZvLDLvPNFICkDz1rQCLbRLAud7ykzCeKN9XqiF3Xq+VHeNwsvhepyaZnh?=
 =?us-ascii?Q?X2rOD6xaJf7odvUd7z5a9Mty+FIxMw77Xyey3ecGI9VL4Q+oMh8HwXtNC4Wh?=
 =?us-ascii?Q?rl9EwlSU9NmqLS58SwGziDqtCK3t7GKBvGddCStIkzLZUlleHslYZOnf9Ot4?=
 =?us-ascii?Q?j4bJE6C+D2gpAWCXQUXKs1sbMLc01POtY4Wm0QBLJmsgtpXF2UUau5hsPkSR?=
 =?us-ascii?Q?Zv9MaovKSchswm1IGrAJoDMSyW7D3lycI+9VWA5CJnYZMYTaB08t/vEOJOT5?=
 =?us-ascii?Q?r4+W4IH7OmUfba1HPzVXAcUAxphkUqRZ7vKaEw6c5VvRhHsIqyy9tlSFBRbK?=
 =?us-ascii?Q?CNHb1lZInb0s3i5dCezCuHDzQRbfW8Wk8EoCf3nP6E895tsVkwHJ1q+/1KN6?=
 =?us-ascii?Q?VItnVDNOv3UjbvD4MZnM98wzOlvH04FNRW1pop/TYGOrxZqIh2SykkZDoIt6?=
 =?us-ascii?Q?wEZUViYZLd0iQav4NCnpPzB+Ov6BDBy2yT605FEozCsgjTCx+pmAjfC1WNy/?=
 =?us-ascii?Q?r8tcGeRJZQmuXCip7oK4/Yd74qxDw03vdhQzrFBuTTZv24Rtswm4S1/VUO+/?=
 =?us-ascii?Q?EMyrGIy2FQ7DXfLsrwDxDK/7U1Mgs41Ijgxs1zdp5PlsSfgKIU0lPgjaK9WR?=
 =?us-ascii?Q?Qlua7Pluy/1FeJW7HH5jCW9zyhRpXtKw5fmqNgUeup722WeYWqC3Q680T56X?=
 =?us-ascii?Q?wuZRIZAQGo82srF5YbgYlqhhiLIxz7lZ5cd2x67HiKWWozPuzLw0ewd/WkZv?=
 =?us-ascii?Q?QEMdHrjsJCuQAGXBWVmrnVisfnNySGa1yNvq57/bETHMrP64Phs671S+XLTj?=
 =?us-ascii?Q?vM+YP0CsFNC5E9Y8VGI2LU8OWoiHNcswe0RYKxGwPZUkDOFuEf9UqQtLr79e?=
 =?us-ascii?Q?Fj77nmxdGxOXEGDVCeMGst9uR5n2cLt/7dLBz9kwUAnfTT8uSnMbiX3QvRO+?=
 =?us-ascii?Q?qud+2jh0x5bjL7VlgWq0JnWAloHoy8B2h1QIo8zMFeI8bFMMAlCWzhOCa0C8?=
 =?us-ascii?Q?5c2v5U5AZCM2HDCiy87DOYqiN0M1kWPunDesmV8aauQWthnEIye1qtq1+RGq?=
 =?us-ascii?Q?Qs8BqgAGibv0IgXugS2l7VVtS6+RJeoT5HrNWITpL8xoisLOjmyekr8TYsnB?=
 =?us-ascii?Q?pEadeJpxCGa6n1Jc2/OvAMUJprr8xYnRXlcerwlZGq7tJr9lYd36g23ne5bF?=
 =?us-ascii?Q?3fmvXrktSyQsV+14F7lCGz9yid2isAVPztsMIX2qsI3TfbMw4yMZPTlD4wc/?=
 =?us-ascii?Q?R+UBGcB98MhLdgvVh0j+kOmY3rgnM4KnS71Hq1Wz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 710ba82b-9e87-4230-ef32-08dd4ac6a636
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 18:05:21.1220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bg4R2FKZJcN8VH6sqBybIAHvlq1P+18rhEdkeK9xtea1BPG9bsjjFwembbswWl/gwgyk3S/Hc1OlfK33Ga1rpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4116

On Tue, Feb 11, 2025 at 11:38:27AM -0500, Steven Rostedt wrote:
> On Tue, 11 Feb 2025 15:45:15 +0100
> Andrea Righi <arighi@nvidia.com> wrote:
> 
> > ...which is basically this (with GFP_ATOMIC):
> > 
> > [   11.829079] =============================
> > [   11.829109] [ BUG: Invalid wait context ]
> > [   11.829146] 6.13.0-virtme #51 Not tainted
> > [   11.829185] -----------------------------
> > [   11.829243] fish/344 is trying to lock:
> > [   11.829285] ffff9659bec450b0 (&c->lock){..-.}-{3:3}, at: ___slab_alloc+0x66/0x1510
> > [   11.829380] other info that might help us debug this:
> > [   11.829450] context-{5:5}
> > [   11.829494] 8 locks held by fish/344:
> > [   11.829534]  #0: ffff965a409c70a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x28/0x60
> > [   11.829643]  #1: ffff965a409c7130 (&tty->atomic_write_lock){+.+.}-{4:4}, at: file_tty_write.isra.0+0xa1/0x330
> > [   11.829765]  #2: ffff965a409c72e8 (&tty->termios_rwsem/1){++++}-{4:4}, at: n_tty_write+0x9e/0x510
> > [   11.829871]  #3: ffffbc6d01433380 (&ldata->output_lock){+.+.}-{4:4}, at: n_tty_write+0x1f1/0x510
> > [   11.829979]  #4: ffffffffb556b5c0 (rcu_read_lock){....}-{1:3}, at: __queue_work+0x59/0x680
> > [   11.830173]  #5: ffff9659800f0018 (&pool->lock){-.-.}-{2:2}, at: __queue_work+0xd7/0x680
> > [   11.830286]  #6: ffff9659801bcf60 (&p->pi_lock){-.-.}-{2:2}, at: try_to_wake_up+0x56/0x920
> > [   11.830396]  #7: ffffffffb556b5c0 (rcu_read_lock){....}-{1:3}, at: scx_select_cpu_dfl+0x56/0x460
> > 
> > And I think that's because:
> > 
> >  * %GFP_ATOMIC users can not sleep and need the allocation to succeed. A lower
> >  * watermark is applied to allow access to "atomic reserves".
> >  * The current implementation doesn't support NMI and few other strict
> >  * non-preemptive contexts (e.g. raw_spin_lock). The same applies to %GFP_NOWAIT.
> > 
> > So I guess we the only viable option is to preallocate nodemask_t and
> > protect it somehow, hoping that it doesn't add too much overhead...
> 
> I believe it's because you have p->pi_lock which is a raw_spin_lock() and
> you are trying to take a lock in ___slab_alloc() which I bet is a normal
> spin_lock(). In PREEMPT_RT() that turns into a mutex, and you can not take
> a spin_lock while holding a raw_spin_lock.

Exactly that, thanks Steve. I'll run some tests using per-cpu nodemask_t,
given that most of the times this is called with p->pi_lock held, it should
be safe and we shouldn't introduce any overhead.

-Andrea

