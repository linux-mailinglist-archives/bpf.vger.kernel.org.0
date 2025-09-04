Return-Path: <bpf+bounces-67394-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BDAB4337D
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 09:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00F093A5E73
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 07:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3814028A1CC;
	Thu,  4 Sep 2025 07:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=santannapisa.it header.i=@santannapisa.it header.b="NOiSe78P"
X-Original-To: bpf@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021080.outbound.protection.outlook.com [52.101.65.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B52428934D;
	Thu,  4 Sep 2025 07:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756969948; cv=fail; b=KdngFemba23Lw3G3ing37CM9umuXu4e8Yh4eHauN96N+zEbCqUz/RHkg42g802pZ0LxBhOVIIXbxmSzTbjL7fTRN+yNucPhq6K48mMl0/CBm4eubDB3VR/zduIUtNZJYwcjyYupRzF5aD9fe/3kR3NE4fQzpRX8DnJCGKpFS0NA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756969948; c=relaxed/simple;
	bh=43FYTOzxL8K3cojLNL8X12qTiMssqZkuyn29xnT1TEg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cGDORyFYMGReOdxMqYbdueETDSqEJ9HGOf4YswCieu0dG7kM9o2UkuYHj6FUQCLw+y6wKq3oQ9RHQ0syy/r/+Rc6x2RtKqr1FJz1cABOPxKKrScmoqoG4+cY/CgpP5RmVLbYohH8XfuJ/3rXXr7qKQECYnKAfoo1IQyXNN7ROvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=santannapisa.it; spf=pass smtp.mailfrom=santannapisa.it; dkim=pass (1024-bit key) header.d=santannapisa.it header.i=@santannapisa.it header.b=NOiSe78P; arc=fail smtp.client-ip=52.101.65.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=santannapisa.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=santannapisa.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JqZWD7nRFRw0oXB2FiV5rQuzhPU33YyZlWdSbB+dKrga8O5KDbkVuW1/NpocRz7n1ve97c1yW6UOZ+xFiUWH7Oya9AaVxAZ/ntPg8gjqRf+pl2of4EZ90khp6A6+oK2zGogoWxPYM1Csa5SN/aGQcX+87gTkw4KnH9pxVnkljlDAAQejUYhieCD41gTUWuWf7Ip7TwrB+YN0Pc9yLa7EbWDojH4QjINjwA61B9P0Jg7nHnBy0EqPujbLfdO7kAXUvwErQX/8O0o66EtSb0/pTvUq/CKuVFrRY5mTK5mPm/1CRViN0bHFVNvS4zueYC9CTPBqMPhvvHfnQHJ/54cQIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltWu29kWfwzMJqv5+54UJrTgoa2zO4vgWE9qPymIe8A=;
 b=Yl7QCmeHvEyw7BDnDNljDQdZa6wwviqypL+81ZDp0mfPEKMSO2fUFAv8uxgj8bM8bwCuhiZ2hBAe+08kFfK3tOtWmoP+CO6LyJmPf5RKyu7O4Ujl59UkoUQQJqFvvrgFtx3dKFVBTtEIOeaj0MjIcT7azzVF9S4WX1eqIFrRIlHZCLFfEzI93AOrgyVu3t8LnJxf1GseEIFRjb/XmXApeQ2YuXokgc8HfD3srWq0oJQIB8mUL8OHnxAvDOmlVSBBxrEuBR4eaNlgiO2y73TUKxTT+MkQisd1bBb+kZurUkqXF8VyoPzWhXhiJ83P73TZT61F9vt2ym4nXsd61/Kcng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=santannapisa.it; dmarc=pass action=none
 header.from=santannapisa.it; dkim=pass header.d=santannapisa.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=santannapisa.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltWu29kWfwzMJqv5+54UJrTgoa2zO4vgWE9qPymIe8A=;
 b=NOiSe78PsGAZamJl3xLAI7p6YAvQBTZC+f5dD6Hb2PIiORPHJx6Ch1c2fk8OyQ/0Rj4D76RSACMu23qRyyW2B4b6m04tcen8ULugqg/FV20ysPukWtkmV2/34GiGF56WMIoKSbMzYOxHPGPMBQ2Be+Jaj68RaRfvry6SziETFak=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=santannapisa.it;
Received: from PAVPR03MB8969.eurprd03.prod.outlook.com (2603:10a6:102:32e::7)
 by DB9PR03MB9663.eurprd03.prod.outlook.com (2603:10a6:10:45b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 07:12:21 +0000
Received: from PAVPR03MB8969.eurprd03.prod.outlook.com
 ([fe80::6bbe:2e22:5b77:7235]) by PAVPR03MB8969.eurprd03.prod.outlook.com
 ([fe80::6bbe:2e22:5b77:7235%4]) with mapi id 15.20.9073.026; Thu, 4 Sep 2025
 07:12:21 +0000
Date: Thu, 4 Sep 2025 09:12:17 +0200
From: luca abeni <luca.abeni@santannapisa.it>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, Andrea Righi <arighi@nvidia.com>,
 Ingo Molnar <mingo@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Joel
 Fernandes <joelagnelf@nvidia.com>, Tejun Heo <tj@kernel.org>, David Vernet
 <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, Shuah Khan
 <shuah@kernel.org>, sched-ext@lists.linux.dev, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yuri Andriaccio <yurand2000@gmail.com>
Subject: Re: [PATCH 05/16] sched/deadline: Return EBUSY if dl_bw_cpus is
 zero
Message-ID: <20250904091217.78de3dde@luca64>
In-Reply-To: <20250903200520.GN4067720@noisy.programming.kicks-ass.net>
References: <20250903095008.162049-1-arighi@nvidia.com>
	<20250903095008.162049-6-arighi@nvidia.com>
	<aLhWh9_bJ5oKlQ3O@jlelli-thinkpadt14gen4.remote.csb>
	<20250903200520.GN4067720@noisy.programming.kicks-ass.net>
Organization: Scuola Superiore S. Anna
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0052.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::21) To PAVPR03MB8969.eurprd03.prod.outlook.com
 (2603:10a6:102:32e::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAVPR03MB8969:EE_|DB9PR03MB9663:EE_
X-MS-Office365-Filtering-Correlation-Id: 44a8481e-3196-481a-9803-08ddeb8263d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+J9ZsZSwKQ4gq0aJtY7F9wll0LZqTBCZdiMc1LPgSML9ZSt5NUPpPVb1QQTe?=
 =?us-ascii?Q?qm3Vf8qLL2EQAGlH7ZGUrOs5Aa/0LqggAe92SQJto8otqBYG3X+fvnQ1epvY?=
 =?us-ascii?Q?RGMxzddUfx/c2jqCdogwIY8f87TwS3ZRpfegty+3kBpvV8p+yxCxZ0xqCxVi?=
 =?us-ascii?Q?RIdKz+pggqHbQ0pTAghUGbkjpAhZcX5XftsMvzZW19CCZwZ0EJxYRhvwdxxI?=
 =?us-ascii?Q?MfL7CkXWRf00UqKg2nQND6JHLK0LcdBTjyh53zL4BAPEJ0u7cdDSYAxxC+Uy?=
 =?us-ascii?Q?dyIjb78LGHhUbjrXfDt9W+uShZx0cH4Haf2UYxBvduJt9wNgiVOpRRCEEeQu?=
 =?us-ascii?Q?FguZO+3lmfaCfsMYuL6PMUvRrNNqJqPcwnkzusbLvcGppqgofHa+quKg0iF/?=
 =?us-ascii?Q?cgOg2ubTezKuoeXE6hv6OhZ+4rRy4lpouelCheeVO6FFUiGbHIrzHxw6kVK+?=
 =?us-ascii?Q?soUSgS8KKOqS20Ow0V8BLa2qifiFUsMViegf36IevhYW0qsnDIF103yvuVbK?=
 =?us-ascii?Q?1w4TNWXL7viyUM1kHAAgS8EA5oxr/nMZnNFoAOZWRozmNvKh7Y2wg1evVeXV?=
 =?us-ascii?Q?NymiorW70iXsyU2IH9hkAGtC3/VTWn58+00uWsh+N1O8vGEsfqRbAILd8nwW?=
 =?us-ascii?Q?BQl2rrlMmzPi8+N4sMCtkngBEK6v8tc6e6jNMh8cyGtUWc12oL6P/4pdsNup?=
 =?us-ascii?Q?UogmtYP89kofP3OuPIWiSLOzu21NcXn90CTihAc/7z5vX4BpOe7LEUHcnBIT?=
 =?us-ascii?Q?Wb5rzgqSlmAl0PIBI6mukWjYZyk/TYy5EtxWqqqq7oJXJcuWxPP1VvNTpunK?=
 =?us-ascii?Q?bcpr/+Tun/NrgyQy++X83lNrUMvD//NZRZ6EBCgsLyBqVpwFBbWbLeoRruD5?=
 =?us-ascii?Q?5L22slt9NDyTY9W7doS08pL9fEf8+/an1h8Mx63IqMWrxThfCTpp403o2JSk?=
 =?us-ascii?Q?fCs/nkmNnalbR12WitKk/6I36LOBy8kBlmUY+F8M3GwSxjKGVxz7Zn8eEyab?=
 =?us-ascii?Q?WDpjmag0Jd2t7xS1kjq3waOZRzW/Sfeok0lOE7Fp3zDHs3YYEEwsWS+W48h+?=
 =?us-ascii?Q?hyDdecnv4JYQ2DOyZcyLD/DpTuQr148F2UX/zcXBGi2HirWRcGSdLzJ7kJRk?=
 =?us-ascii?Q?Da76XHx7zuOgMZCBUky2ae/hzgtY8dkCBDFrC8vRYmI8HkVNzQPQN38/Knhk?=
 =?us-ascii?Q?+BBfEaQ8Yb+7d86JdjBznFRTtDypHW3N2TRn/QTP741fq3fP/GUUCXgnVGjJ?=
 =?us-ascii?Q?R6ozBsjOEdAXF+B4i+Lm5pFPJwDXr11cwp8c0rqV5RqeSVSmM8r+m+ohkEnQ?=
 =?us-ascii?Q?aAyC5ZwWrqOu9QaRCo/53JL+wBpwv6FfUl609FVab6K3O/RpsE2Y3/nCZivj?=
 =?us-ascii?Q?gUVZuDbs9fcnt3nulGYZklL/Di3g6YSfN8GpxnKOCI+kmwNGrLz0fNZWX5IP?=
 =?us-ascii?Q?cEHE7lxqg8Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR03MB8969.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZlYtF6XMQakMAXqRa2Xd/gZfA349GgJTSRb/Y4Ja1GFDJXqnUQJmlAmYUZWA?=
 =?us-ascii?Q?WHxFuB/gZYqh5V2QEF+/sHCfgR2KwYBpYPqRexnbcq8aLOyj6/+HzQJxFK+M?=
 =?us-ascii?Q?YOxHbW3WfzBE1QFB7VFwNHlkBumtYMH5htdXEId4C6IdKw4faDERQkSD+RZd?=
 =?us-ascii?Q?gGZWKvi0B1ZA3nNspynbEXKu5z/BJijwV3d14ojihkZLyIL4mS6om27Luo7z?=
 =?us-ascii?Q?0RWzwnJGNvdK9uhn7QT/efQkSmQ5CkcTd+gFuqzY+NGJEfgapNmjvIS4E+hV?=
 =?us-ascii?Q?u75lB/yckFOIZY9vcIXf3VvXwkIsGeGjEPajgw9gRZ3ylfNZtECoi/zl5jDD?=
 =?us-ascii?Q?8CrHIG/wjXodQ6tQ/kc7tHvMtqSh/udb1V/21o1jYn1edRr5xgw5U5wAixMU?=
 =?us-ascii?Q?Lt326pd1yV+wcuLBCALVDTayP18WIOirDTGn9P2prTxOHDBfd2C9UV24Mo+o?=
 =?us-ascii?Q?ES0W2gC2eCkFp0bDH/19DkPC+eHxh8h9EUuiQnAt+x7M+KVVeFYyP0vTH0O+?=
 =?us-ascii?Q?0aj7Dkj+dgxLmxVjsepQtXX9HpsO9cLML1aeJ0TPWgdL2O6sDDvdtUTU6tPG?=
 =?us-ascii?Q?1usR7hn8PcgKpXMl7wYa29YMx3FGykXuZnVLkC3saE6U4QLWxZmx7hG57VVp?=
 =?us-ascii?Q?o5+wQDEz2hTAyQaRsOjcnM9Piy2O1xyYn2Y1tbnGwiRIJoEK0IBACy0Q/zf6?=
 =?us-ascii?Q?tVH+3eKdGNNqpnP5fD4sJDlg2OCKXDJTsLZjcFsFjEgvJNcyuMVK21sLlIOq?=
 =?us-ascii?Q?m8ZJhCxTAGpJAdrpNjUiDBLERgtiTlR+eONJsTXYz+fow3wQPpebhDYaUIoz?=
 =?us-ascii?Q?aTQKZb4v2vL65qWx/mdjI7RWwIQ8MtjRyL+eOosp1bRzVSR1tSSnRa2CX2xS?=
 =?us-ascii?Q?uGn8iKLck/T2YlaenIFnDalVt4wD/3oOCiH8xIXNfHI99hUTDQ0A1NqNtwWp?=
 =?us-ascii?Q?EDnY5SGcmjuxiPBgQUf9spFtdaucbRmP9SsEUNe/GRjIyAHrX54M+eMrR8x+?=
 =?us-ascii?Q?ERYZlb3Jbd+HvsO3ZJwtKyARDMR5w3eu3LNQA6nFKSYS2a0WcE54nXhBqxtS?=
 =?us-ascii?Q?Xi9ElNQ6zVbhqnEH4OCOgrU3lRnhHib9lkqB4Baw59YOqG6Nax4hQ6reALfE?=
 =?us-ascii?Q?kW8u6SsHwrJIEy7WKt+r2etTjnCTLbFlrDSe1X6OEvbPT67ZOrt1Yv1idgQX?=
 =?us-ascii?Q?xEIFYy10q96VkEYRduODmqBQQwo5UhNokImiEOrwdZFu6UHjfE6+pdV7POGY?=
 =?us-ascii?Q?4AGYMWeXL7wbg9X2Y1oqcP16nop/sUoERvf409Az8afY0KfwtOCAiC0DW0Xt?=
 =?us-ascii?Q?yR64QmX9DPIyzIDRtLzPTsJ87GMlqHiWvkNp6padzOOlBVlyJAHDExVYJLpb?=
 =?us-ascii?Q?zg/R53lkGHOCcOzzI5KxinCvr3iG9eOZGMk4VI+EnHVeI5FNaMDTCFopmjkB?=
 =?us-ascii?Q?qrULbEdM1EeRx8e1BKuBEoCeZIlaQQCqtaQ8rWL2T+Z6pYGJOQfUnbcoOcDc?=
 =?us-ascii?Q?IoRwgixxenAL0F7OROHYkrjEURk6uQTlFanJAs3QIkbTIVJ9Hps3HYtpzF8o?=
 =?us-ascii?Q?ScKTrb9oJV8wGPxc6dnZig8+iKFmZaJBvNTWp0rGDlAiMNHZtBW8G79Gwo1w?=
 =?us-ascii?Q?LQ=3D=3D?=
X-OriginatorOrg: santannapisa.it
X-MS-Exchange-CrossTenant-Network-Message-Id: 44a8481e-3196-481a-9803-08ddeb8263d2
X-MS-Exchange-CrossTenant-AuthSource: PAVPR03MB8969.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 07:12:21.3072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d97360e3-138d-4b5f-956f-a646c364a01e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cmWsOnVwUyVYdE8qSfZQZy7m/zBJWZu2RpXCFxRBZm8OWHS1dnazsQ6FACIx6b9YLlJk3kcOlO+d9sF0p28KCDwwI4vvzmhJ+eeQvc0Muhw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB9663

Hi Peter,

On Wed, 3 Sep 2025 22:05:20 +0200
Peter Zijlstra <peterz@infradead.org> wrote:
[...]
> > Yuri is proposing to ignore dl-servers bandwidth contribution from
> > admission control (as they essentially operate on the remaining
> > bandwidth portion not available to RT/DEADLINE tasks):
> > 
> > https://lore.kernel.org/lkml/20250903114448.664452-1-yurand2000@gmail.com/
> > 
> > His patch should make this patch not required. Would you be able and
> > willing to test this assumption?
> > 
> > I don't believe Peter already expressed his opinion on what Yuri is
> > proposing, so this might be moot.   
> 
> Urgh, yeah, I don't like that at all. That reasoning makes no sense
> what so ever. That 5% is not lost time, that 5% is being very
> optimistic and 'models' otherwise unaccountable time like IRQ and
> random overheads.
> 
> Thinking you can give out 100% CPU time to a bandwidth limited group
> of tasks is delusional.
> 
> Explicitly not accounting things that you *can* is just plain wrong.
> So no, Yuri's thing is not going to go anywhere.

The goal of Yuri's patch was not to avoid accounting things... The goal
was to avoid subtracting the fair dl server utilization from the
utilization reserved for real-time tasks (assuming that
/proc/sys/kernel/sched_rt_runtime_us / /proc/sys/kernel/sched_rt_period_us
represents the fraction of CPU time reserved for real-time tasks).

Maybe we made errors in describing the patch (or in some details of the
implementation), but the final goal was just to ensure that
sched_rt_runtime_us/sched_rt_period_us goes to RT tasks; the remaining
fraction of CPU time is shared by SCHED_OTHER tasks, fair dl servers,
IRQs, and other overhead (the fair dl server utilization can be smaller
than 1-sched_rt_runtime_us/sched_rt_period_us, so some time can be
explicitly left for IRQs and kernel).


				Luca



				Luca

