Return-Path: <bpf+bounces-71394-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9489BF190A
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 15:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2376E188C096
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 13:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339843191DA;
	Mon, 20 Oct 2025 13:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ukXo/foZ"
X-Original-To: bpf@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011048.outbound.protection.outlook.com [52.101.57.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376561C3306;
	Mon, 20 Oct 2025 13:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760967497; cv=fail; b=G9qzO+hr6LvZ6/5s8p4nqMtJfnbDH8EXO8KxKTmbvTVuPMnEgH9fk0M2phu7E1dACMN9gttGZZbaGQ6JNWq8eSTNRw5imUBPQqifJujYucwgvPDYsl9smeTbSqNvqVMibua3zv6jeAQZYkDzMMEwJwnXsTt1tuDat9eufTRAH8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760967497; c=relaxed/simple;
	bh=T4f3Qd8N3bhjQB/QeNwU3M9JsdTQywYY0AvxWxyvTmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sPLJ1PUK3zCoxlRitzlMm4pCkLNSQzT/duaRCmuKPBn+FK5aFTg087TIymdVZ0b0wP1Txvdao7gae+0P7n7Ex3joHy8xx+3Pa2qccrbwJ41N1VNIuuvBjSBeVMtBRnn8Pmv2yKa5C52/DryirVXLZtcXE4RzckYVraLVzrsday0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ukXo/foZ; arc=fail smtp.client-ip=52.101.57.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YiOsUMViwMjvi3e+r1JBb1JkiJD2uxiaEGaYdV+TSxjO0wrM+uQAbkhRntm3NgoblJbQ4q99Xnwng86o1VrgBtSwuzf+5vSg+pWO6ZvUUcbda3yJkug+AMbpVVAMg/zNcX+Vx+ZXodsl5ADHOyhpCHeH/MVnachchw/5wJYv69ZhzLwTehlEKjZW8XjtPaQQ5EpitqyIRKNDwfydlzi13QbWXM0POlOWrFn8R15Lh48A//Ay+MrVhVBIDWnAmpCntDzYT8bxdTP8BORGqPwFIo7XELcVBmimZHIIWM9AjGq+IR2VoPLU6pgzGFLv3O2GFJf7fY1PT4bkmep0DCwX/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jODA44V5I4ClCSnjKeZuI2H11A5nZOCM9Ef0M6bOSKE=;
 b=v0QZVfd9BXJOUR4gs1Bu6syrnePJbsZZBeYZmN8mn4EU+qxm6RKXEwSet9sRIUI4mB1rk52SbNRS0Xmfe2lvVGNzpoWpWcPV8L5jFmRFw4YfWejPw4/cYngY8HBdyvXmth9PM/udXeggcUIIwf4vbKTXUFJanegnMhTj1jKwP73IRo+DtLwOXZV5wcEp6ewmc0SNaLJxSXGN7jRn0GYVzloNw8GyXL0T+zE5cQWQrEquj9cs6FXCFlZkIGMeeLFJ9QANbNBHtikkF/ZcaO4P/5vPwyBRrgjRK/0xrtarFArtew3kADD0So0e1ABqxsITVQb9tEzysbtzob5uE3yvqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jODA44V5I4ClCSnjKeZuI2H11A5nZOCM9Ef0M6bOSKE=;
 b=ukXo/foZVH+ZcSzvDhcMdaR9M9S7v3uiyFCWmwRI/yv18cG3ENe1sieSv9Kd9/ivZFcjYiur6FiPK2aeLfxUm6Th/FAfQXALO4w+94swoiVL92Xc9Dgqw8Yg+4znvpfLhuHBifPWwIK203UfoswHtisOR4r9mbZCS0beNmqV12yHSRqqdxEa/INBtIfIExcb3l38tbIydIlfz9rlei3OL9Lg3r+JkEwe1HRmrkmPS3/uWXKe5UEtguYwmuIBwEoRIK+KE1veQxw0KLWGtq9W3D5R3FtdcpCJ0RmKBhsOO17QymkUrrt/3MwZrRudv4cnjBKgmGXeGbfiVzHzJ5iGwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV3PR12MB9187.namprd12.prod.outlook.com (2603:10b6:408:194::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 13:38:12 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 13:38:11 +0000
Date: Mon, 20 Oct 2025 15:38:03 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/14] sched/deadline: Return EBUSY if dl_bw_cpus is zero
Message-ID: <aPY7O7NNs2KyKpb-@gpd4>
References: <20251017093214.70029-1-arighi@nvidia.com>
 <20251017093214.70029-5-arighi@nvidia.com>
 <aPYFv6YcxqWez8aK@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPYFv6YcxqWez8aK@jlelli-thinkpadt14gen4.remote.csb>
X-ClientProxiedBy: ZR2P278CA0038.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:47::7) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV3PR12MB9187:EE_
X-MS-Office365-Filtering-Correlation-Id: f2afb530-2f7e-4438-bb07-08de0fdde9a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1+BsaDNcBso++LVQcLI1W6jZlPUAWJ1g8jdIrD6tDxrnvJatjWRxRrNOZ8+m?=
 =?us-ascii?Q?7lilgrFwLb+2o3HSeFnjJg6+6toqUU/CU2/YEdO544LHtOacR5e2G3/pQSlk?=
 =?us-ascii?Q?AECIFkGSVqjLqJqYRqvvgfaLMBJTk3v8H5+ky4HsZaZVyPFcAsyRItKpDXYZ?=
 =?us-ascii?Q?H2NZyMPOOLwG7gKa2llS7qh0JpvAXaMIbf3oIYDmX4wzF2wxQHExmn0/yYWG?=
 =?us-ascii?Q?taZdmXOI7S1iaN9VDDvIls/3+JEc3/WsH2fSBxyiPaez3OSoeNyvHUYTAFIH?=
 =?us-ascii?Q?wkEIruCMv6k3btp1/oc8VBd+3k6PZn5M9Og45pQURrCClJvrCfbtXTtJM9kR?=
 =?us-ascii?Q?81zdg4rnqqENUORXVI6nM1AzF/yCSiyizXw69D05FRYm8rYHkDGZIZdKtSV9?=
 =?us-ascii?Q?tpvPPNR6uGSjVB9cVjl5DmdR6zR20KlblAOGdI5dps7MSOzf7O+snBRIvB9z?=
 =?us-ascii?Q?qnrPu5N/n2oSFRhyWtA8dQjmOjijG1r0gCcKrVKDEXl6em1knX2EmVGYWNbH?=
 =?us-ascii?Q?cZrs/AHU0tSshTeE8o/acqRBMKjpmkcB1F4PVBYdFXD8T/g1bMhfiWokfZUs?=
 =?us-ascii?Q?CPdZn3HxtGWtnmPL94F2eHSLll3gU/yGKe9W4cTrY60aKRC+1t0bpw1BnG09?=
 =?us-ascii?Q?tB2PLYHcjBqT9FXJW4Zfmx2zXzRo9ZLRXVZw7HHl8W3NcvZgmEKrDKENqX6d?=
 =?us-ascii?Q?t6AUz+k9oKKSDCJIkpPbnPz0kNufrYzc2HLTCYweqQxWLBQ58EGBkb8ibHcu?=
 =?us-ascii?Q?LDFE2M52rriXpu5zSVrgK/x/QpRzQPxGucol00yYXoHhzVkxXlu8hwIaXNRU?=
 =?us-ascii?Q?awHvurHd2p3CKFdlbtn8Fld5yOg/hm1g9y//x60EwVUMCqLcnNOvR6s8bv7i?=
 =?us-ascii?Q?sfsArCuhDGglmEriMDDsE+9IJkrxcWh0gLMVhaev6C67nWR1jdYX8e+nR7fI?=
 =?us-ascii?Q?M/TS7vvT+XhgalHXwd5k4m+OMfj48eoCbVAbDgXMRU8vrrN+KZ+4N1Q0gB1L?=
 =?us-ascii?Q?OecaCSAH+o8yIGS8uNpyCGWQqoQSpQuS+wRuxqq+k0YxJ0cTfV13BNpZGlju?=
 =?us-ascii?Q?+NFL6dZVWfNNM97eSDLfhc692n4wpcSpITKEZdguc+KR6m0a5p7IVX4sfR8j?=
 =?us-ascii?Q?GXG3eOYqkf3mNzNv8sbCNgdHITOenW21jFBDM1IXlYpTfnNn7FrJYF5ItXqC?=
 =?us-ascii?Q?BYCPxmnhFE1HDQv62M85Fob2c3bc0p1DSWwTeTazjEWE3YuqGMPFxGK2bUSY?=
 =?us-ascii?Q?bxiB12uxvGICGMY5v1cCpTtnMcUqHdmubJmC1xT6ryZA5vjmim8UAgBtZKKu?=
 =?us-ascii?Q?FQMRZPGhImGw8pUJU44UzFsr+nwGZh3is+nnYe7wtJNzWB0HuRi+CCmahR6W?=
 =?us-ascii?Q?w75GyLOh38B0SHa9g+N8XJXPSLCwA/Z5Im9SwA2FFYKx8ZMhdhnXenJhHJBf?=
 =?us-ascii?Q?lFwX9djNzfWy4b0SxctgeuIeGm7LH2zt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XLS9ifvJagg87wOumo4ACljULQOCKCLK83ELh2TgNKwuRH0QglESK9Z1iU8z?=
 =?us-ascii?Q?jTKdxD7kwD2/JSLx/xjEILgcjw82dwzs8J5hbBqOhXhr9LE0axJBA/B8f6F1?=
 =?us-ascii?Q?TcPwuUhwuFqBBO37k2DuJ8jyoiA2URWVtIrT0ZECH57HC2o1tzcmODgf4bib?=
 =?us-ascii?Q?ykY+c5AqRDbKqsRMzYTqAHprdwjE0H79rxKY3LL97cBuF/mGw5RL67/2KXIb?=
 =?us-ascii?Q?I14nNvcuvR3+4sL/Iht8bVs3rp9Xov2rLdp7Uyfir0Tb9dknSZHyLOLygkve?=
 =?us-ascii?Q?V8qlGa/cifsf8KdMvPX01YSmoeGd++v16H2iyjPaIYNFaCvLQMhENrJjNn2s?=
 =?us-ascii?Q?zLWV4/TOLa2dxptX+AWA7Dub/e4fRMpmN5F/2nZFgf+DxfNxywJ/eGtOaKwV?=
 =?us-ascii?Q?7F4sArC4U5VH/sO7oPumAB8sTGT+xAQMRH/rwyBxdlwGs74h+GfgCh/TEL8+?=
 =?us-ascii?Q?uJVWDlOf3EBYbkneULSr5wcjW2vtg7FImpTY7Lbbeif6XffB+9+LsbUY8idS?=
 =?us-ascii?Q?SWfXkihpk+94A/9xEaY9m/dmCMlpA8prc83ncm/aTjkXrHvGcuriKXKVzBiw?=
 =?us-ascii?Q?bDcsrzRcH4lB8uB6P8hPWOjaZCdnO5U6/BirOcM0V8JLeqK16/Kk+4v9Y1Oa?=
 =?us-ascii?Q?JSZ/R/eCB9W/reehLEumiYP1lU6vKelaJyhmFpEp3jyvcvWGx25Kn3rgY7hY?=
 =?us-ascii?Q?WG3IBiLXu1Q15oUnNJWPl/Vv4jQC7Atr0/BgjYvnYxsb3/2A4H+BZ8iykX/J?=
 =?us-ascii?Q?Am6x0Y0ONZHjDMF6pHMT14JUcccmTtYKs7HfJAmV2pzWYODo2KqZVs+8EnBb?=
 =?us-ascii?Q?H7H3b7SjmKHSMq4Nh3VYJZA3GT7CiYHk51wCP354pSLArKxuHrA5YUKncSq4?=
 =?us-ascii?Q?rkkI5UDf9myWxjl0Ubn47EJjYTZOlEO10Iv1XXtciv/yZf9Ww5+I9vhmNc45?=
 =?us-ascii?Q?+lAtPPXJBac92masfm5wb7z2WHTFPRqk+t1gM4QVNFwlIpymdlmqTdtlUDcF?=
 =?us-ascii?Q?M3bzBfXmF9/FdZpAlJ2+mQOkfDyJxHFnQtL4i1jn38dOhRg3wwHwySa/8N2c?=
 =?us-ascii?Q?HwWulIe+kwYUll0kgTk1Q77ukqUBo5urSqZBzfGRneZMFnZQVInyb/wAbYUH?=
 =?us-ascii?Q?fvSC4SnDMiZVaMudyYb0xwdAMx3hcZ9R4apz2BKcQ4XK3okgrZbrAkQIhW0j?=
 =?us-ascii?Q?NdSllo8FvC6SucHA8ttM+iMek8+ksx3FKlX2vcgZLwXOFYdqWETK4ghHheaN?=
 =?us-ascii?Q?ycnfisLvBlaLFapVt0kxMSR9ns06AyrhpbJ720A60zKeciANmmSArOj/rrlJ?=
 =?us-ascii?Q?5SvW8ZJkRFFjuQz0iMI2ATAQHoDQPicXm6UksXIDHoKmlzap1ytdRKNwMWT5?=
 =?us-ascii?Q?XXY8Znu+mTb7txgwlJWlisoGARccBrqZL8SOm51RP+ASq841WpIOuXpCKv/F?=
 =?us-ascii?Q?o4m939vB3/tlQ/2xE0HvzJ2CzZW+GjUvwh58biygVz2jyTppH7jaJI9L5KsY?=
 =?us-ascii?Q?7VtzvM6xm8sn8llE4f84MEfY0YFKLZpUxw2ZLFmeMOr6q5es3xBmIiCby69V?=
 =?us-ascii?Q?jEU8vkBgx49X2eFkxUt36yQH7EXFyISf9+h73tUQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2afb530-2f7e-4438-bb07-08de0fdde9a9
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 13:38:11.8616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kdKRc9DEt2aDM77CGU6iJ2NOpcz40VpMTpIhHBQuLDj8aT/+4yYS9kLf20VDqcP1QhB+uXsCSf1VXR/GYijHgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9187

On Mon, Oct 20, 2025 at 11:49:51AM +0200, Juri Lelli wrote:
> Hi!
> 
> On 17/10/25 11:25, Andrea Righi wrote:
> > From: Joel Fernandes <joelagnelf@nvidia.com>
> > 
> > Hotplugged CPUs coming online do an enqueue but are not a part of any
> > root domain containing cpu_active() CPUs. So in this case, don't mess
> > with accounting and we can retry later. Without this patch, we see
> > crashes with sched_ext selftest's hotplug test due to divide by zero.
> > 
> > Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> > ---
> >  kernel/sched/deadline.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> > index 4aefb34a1d38b..f2f5b1aea8e2b 100644
> > --- a/kernel/sched/deadline.c
> > +++ b/kernel/sched/deadline.c
> > @@ -1665,7 +1665,12 @@ int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 perio
> >  	cpus = dl_bw_cpus(cpu);
> >  	cap = dl_bw_capacity(cpu);
> >  
> > -	if (__dl_overflow(dl_b, cap, old_bw, new_bw))
> > +	/*
> > +	 * Hotplugged CPUs coming online do an enqueue but are not a part of any
> > +	 * root domain containing cpu_active() CPUs. So in this case, don't mess
> > +	 * with accounting and we can retry later.
> 
> Later when? It seems a little vague. :)

Yeah, this comment is actually incorrect, we're not "retrying later"
anymore (we used to do that in a previous version), now the params are
applied via:

  ext.c:handle_hotplug() -> dl_server_on() -> dl_server_apply_params()

Or via scx_enable() when an scx scheduler is loaded. So, I'm wondering if
this condition is still needed. Will do some tests.

Thanks!
-Andrea

