Return-Path: <bpf+bounces-60641-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0432EAD985B
	for <lists+bpf@lfdr.de>; Sat, 14 Jun 2025 00:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A74E417D9B4
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 22:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1197B28E59E;
	Fri, 13 Jun 2025 22:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D1hpeS9y"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D377D223DD1;
	Fri, 13 Jun 2025 22:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749854686; cv=fail; b=pDDag7xwMIW7pHJZYLXQZ4+qz7oiFAjuNcHph5AvQGp6amc3ixELqwSfgWIEBdQ4h3aI4xXiit/Lks3RLfPtr6ZdmJ/W/wpMc5D9wCIkTC5Iu44lApZEbbrSdA6iVB1+GqMdbs46mXKWT+zJJzAGg7TITKvD5OWmZrJtv72U6HU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749854686; c=relaxed/simple;
	bh=Pou8CgdI8AEQypkSax0H2hFUVKz06rhBHb0WvzdGljM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L3W/mXdEN6jUExJNzIoZoR9phUAPznAI3wdooGBxjaeeCQIB+XWktijDMME23FH1wxtUd/cgjBSlYLcdiDa7kV5gQ0DbZEdyAmz6ksCgXTI2sGTQCq1gECE9xmr+UeEXmoIkQyesXL6f7EHPf+yrPwu5tf5vNC2LftR+vc/ubog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D1hpeS9y; arc=fail smtp.client-ip=40.107.237.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KBaCB9nvBqxCYZjJfGHpucRLYatCUUMQq8gjkn/1oXJwxFNHqdpcpxWWOme8ia4ENHPpo5nj4sRUQnwXLgXON0L3txByBVJASPnqu6ETGfPZHq3pnLN61jcMJYTgD3u98XSkTj/7e3Et7eQaYeHcrYAqM8Tp+kDfRbDlx4QwvPUfuh2h0X4gF1RowhnNkmH0c0dNmCwjSpVr2D0/cj9TGJLvrPbhpH8jDdShjmOyX/ebMuv7cTzRuN4RC/EJYr2wiekLcP9FpiNSRUH9ZXfISB4slC8YU3cJruobD/LhbyY1VO2TL9d/mvfW63SxS5zMSKVYwOBctYM4OhHKFYK+zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EUrZEGLyILigY7ahT15kcKTFuvs6CejG+R7rOnIBLOg=;
 b=c8V2rU1BYioKRTvnWjZF3y57t7H4kSkMEgr/I+eNQ+m3RnhraSNszBZ+kmAS9Dk6ShFc3ch4GtOZIYJbIB6VNlGKEabAzPweCzuHxbM3jvdQKdoenIXMPDGNhn01soQtOuBC0tnL/Qyss6hDdp+XSU/CS4VepMEEimXieSSbM1TfMUeryIx6wx5grkde3fwyYT2kbRSBjKGcUU+IGswl2iAE+KmVd9pGC8Q8agfmri4GBU173y5+5WmvBCiL1cT7hZx2gVTs0uTU3x7dSUBIUctM9YnvlJyfAQsE03ly7EVijRR2dMo6y/sCiPxDISH6d/AGrlLFBDDpLM+lhLYtDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EUrZEGLyILigY7ahT15kcKTFuvs6CejG+R7rOnIBLOg=;
 b=D1hpeS9yvPn8bneKztqMnlJU3xmbk9xYO0QwJ/aYiBZiVmn+KwM2WEBWa3SbtgWOHksrMJBknbmTDs9jKvAaxhWXcL62bWibsTRd1lluaygRuwmMD3rW0WsDWb0Mt/lv3BXv9XcQOUA/LHMywLZICftWrqwA/Woo/mOZqd+2QCTWhqkostXWvQV9NL+4GLwu4zXgDozPORSVfZKR+R++Af+6Cp3XHx9RFeCvFbTtqMDtOy/hR66brhnhYx81MIiUirMuaASsrzioDQPIEndqPvuiCRwr+1fKfH2DSwPLHmzYBI8yFeEDBRndoEkNUDXpQ8XgwlXB45YHI27rfPnwfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM6PR12MB4057.namprd12.prod.outlook.com (2603:10b6:5:213::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Fri, 13 Jun
 2025 22:44:41 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%6]) with mapi id 15.20.8792.039; Fri, 13 Jun 2025
 22:44:41 +0000
Date: Sat, 14 Jun 2025 00:44:28 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, bpf@vger.kernel.org
Subject: Re: [PATCH v3 00/10] Add a deadline server for sched_ext tasks
Message-ID: <aEypzNZHMBBFON2h@gpd4>
References: <20250613051734.4023260-1-joelagnelf@nvidia.com>
 <a8200977-689d-4041-936b-3a92eac1bbe9@nvidia.com>
 <b6754f5c-039c-4cae-8279-4a574fa055d1@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6754f5c-039c-4cae-8279-4a574fa055d1@nvidia.com>
X-ClientProxiedBy: MI0P293CA0005.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM6PR12MB4057:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d589554-677d-4cb4-ad45-08ddaacbe237
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?84WNLIQtoqhPJorU4KGz1Sq8YsDt/YSFZO5VKug19DhmtU/So75KipVjwUL9?=
 =?us-ascii?Q?fuzZxdZXfxvxBgmLnZNgh4d8akVlqDABKW6o08slotJ1iaha0ZT2HDSQQF8J?=
 =?us-ascii?Q?+mu+t7FptkVy6tTG+IwTmHUPsOHGhLNUUFibrv3zIuwc0SX+kh+LWhK2C+vh?=
 =?us-ascii?Q?IIvdF+Ssjr/xKab3N4GPfFjxwK0zI4OsWcMcLgzZ0s6VEf9BO/fB4/Dj8MxP?=
 =?us-ascii?Q?vlWQ0TPqjnCzEzcoY3axReur7DEjRKbAGExHlEwgQlONLNslmeUR1CglxaLl?=
 =?us-ascii?Q?FAQQt4bGU/9acCZtQ9cVKKj19UYZv5rGHtQ4yEzCZK5oXjDxgilI0xljv45f?=
 =?us-ascii?Q?dXgqPd+Hm3DCLOrxX14+YxTpIvGvIFGZlMqcYl4KgnetB6qKoDLyPwyIJi+n?=
 =?us-ascii?Q?ZKyfbA9lPZ206hwdzG6BEGPFFBoJgSk+eXK69sHk7NFix60A81y+C3OUl5NR?=
 =?us-ascii?Q?qWLa61V2c8xHetj+caDZWOsq9CgLqH0NFvem1h0svWIvWQBoVFY4bFi/EQ0k?=
 =?us-ascii?Q?GmQRrT0dcLE1avoWB3VQLK0ghBUuqljDhxanHh1xCkr+MZ/umQZw4ydc7K7Z?=
 =?us-ascii?Q?55y8uZpfld3EtKQcPvGK9aumtqekZpTEUTebwNfBrNNjCN/IT3vUUbuNpHUQ?=
 =?us-ascii?Q?+zpyMWJDGKaegFM/lbRlpl3L9KsLNQAQcu8gVmeGO9eVJBwtNwBuS44zuNGy?=
 =?us-ascii?Q?KDUBk5zWy1LQnz2YFYEQ2zzaFRmgu4iIrigFlOLlTc10kjrOo8NV6WQwDFub?=
 =?us-ascii?Q?+hEpfTHQZBSj5QLt0NF9UH7s7qM+vwQ5SGoOmZJtUZjXrG1RHWQf8J1o0UFh?=
 =?us-ascii?Q?Uppml/F/oTbUxFBtv+PuJV2CpvqxxUgKF09F8DNP1TIUEZfvrThMubAIQHA0?=
 =?us-ascii?Q?3Z0RbrYEeUllDvVJuKHR+bRBGj0bwBiLzp3reXvm1T/nZOcH7z9KKtwV123Y?=
 =?us-ascii?Q?IAlXx+1cGHquy0cpz+iH7vpLR9G8BC3J5pZDeakUjcie2k86kr7mGj3Z8LfP?=
 =?us-ascii?Q?nw6p9f01xGDtDaz7jri9QUK1w+BRIsS+g7kRvZ45uECQ4/T+AQ6Q8Tg4+Nhx?=
 =?us-ascii?Q?eFfLJFJTFSX0P1YZQ66dU0YXI6W9jYrI1N++mEQIKMfY6M0Mh1aqvixgNyD6?=
 =?us-ascii?Q?CjOXbPjqCa2V0a4/uBhzy7q8+JX/B2chApQdDB3Ruu0KuXIMz8MHnZkCipHV?=
 =?us-ascii?Q?IGnn4Y7rHJxNj1RGekonWC0i0PoS9ywqKVqtvBCWgaR5jMTH9PxxbiNsupmG?=
 =?us-ascii?Q?3iMe9F6fzT1nbOx+m6TxFCeWk8uxC01sYaFzLj/OWNutnJPzV0gzX337ed+A?=
 =?us-ascii?Q?XSgS+vMlQ9yjUWuxUk+GVwPxJ+PB+b99kCTzTTDWf+ODruuCSIIw1v3RXW54?=
 =?us-ascii?Q?Ru03estH/x4vfzXsqVGfOGvTiz4MRKE0/5xrd/dojbhOfO51h79Nx1WauPuM?=
 =?us-ascii?Q?+1DMpzBRe9U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?91R1XYiHyHsT1K7DbdiWjHpR/npgEx4ydhUqQf5bVDnsh8kvRsYpjieQz/Fs?=
 =?us-ascii?Q?1DdNGJClZ3F4gKoEZxCeBDHMSNs+VoTVu4PmJ8yhbR0jLshs88NbkDw8B9cU?=
 =?us-ascii?Q?WuokxOd40wIP3T/LfHpbajiEpLIDlu9Dcpp5jlfr1XPT6gf+IFmzS72fWyQT?=
 =?us-ascii?Q?YGjgqzmEZuGRXAtlJvF7evioBQtM+2FU1x4n4BIJQRzfld3HiuH8r+a88fw7?=
 =?us-ascii?Q?BMm4zaqxSi+s/Ts7VVRT7y+Xkh5IPMkn3zwB1RlMorRM3l0zaoVhWjo/HTu+?=
 =?us-ascii?Q?Xnm/KGq8ONKnya3YkQ/A6NSRHR14i3SJ16hZ0OAah302Xrgz4XLi8FgTiDYs?=
 =?us-ascii?Q?Akbp9QqRPxVjCZfVDnVHmXBaUDGvRhuct4Ro34xT5pzMpe/YiXMsZ819F6LL?=
 =?us-ascii?Q?usHLGqd/x3uYk1jHXT+GXg2X9QHNl90SB3NqzM600hz6fJpAe3w0Z/0+Q+Nl?=
 =?us-ascii?Q?ItsBmh4uTjLjKJwbGpyirX34O5cPF3BZI16i0yrTbk+znf1ky08iJnJvb3a7?=
 =?us-ascii?Q?l1kPBeChjaV9XLXMnSS9ifTHlsvWPbEO9G6hNbkME2cn+uSKXaAZYzjsqS9Z?=
 =?us-ascii?Q?WpXRnL9ID2o6MTOWGSs7Ye3cihMKLioYaeZv+hikZ1ajJGLwdpFX62AZz1/a?=
 =?us-ascii?Q?AH1AxBAPGB5kM3v5PUk4s+nzPf/kReBkrJA+SF+Y1tyuVcHWArSalUeZYfnH?=
 =?us-ascii?Q?FLatWiCmEubpYZE3itemEciu0B+aTD2usu3OP4Vf1ALMnN5I2uYlRew4SH4O?=
 =?us-ascii?Q?1KOGjqqzD2PwCC+e/Gy/d97rCBC8ZbpA1hZSRusWlWsQ9FVzcAE1bDlo1ZLb?=
 =?us-ascii?Q?jg3XdjFVxHeSVGhE2o4auXfgCivXsCfnLWWVDnRmvJpeHZ57RrXG9sNqC0Se?=
 =?us-ascii?Q?bhnMGtuc1q+nxMM7NWphHUA8Ulz27I9657yLHs8YCubDSb0pOlMZQkrPmf/T?=
 =?us-ascii?Q?wBEIB8HqD/L3pwmH6MsTEBCr2UwmX1rZK5aWh21zyd+ZkVZVN+/h+wFUS12O?=
 =?us-ascii?Q?snGwjT36aIbLB6Fy1Hj8AeDzDttWOhCdEOqlytHdWb7WYny1M24W8z6Lh5hE?=
 =?us-ascii?Q?FHDGScmePxY/WgZ21JD4IUNJtqCS593ov0FFDp1bbkgzkZTW4NJcsIveDbqO?=
 =?us-ascii?Q?aTY5SIoNWOys11lpGzk9VuuqIwstv8dLliJgOmPEFwRcg0zP9qv/rku6M8la?=
 =?us-ascii?Q?/Teob63NGzYZit7L6sCT43Yw5cxGTo8AeIkRTTQzAlpclAEk+jAL0BLPTgTv?=
 =?us-ascii?Q?UyaqXEMF1lPxEsFyBOCGeAWQD8WrSDWBAMpe/h4CXmRoxSpeSBZTa5HOs8YL?=
 =?us-ascii?Q?f+VwysymeiT10dWSwATwL+NbJ/35mKfUwK1Z8le3/JrCjFEKf0S6IF2rmb/v?=
 =?us-ascii?Q?FMKg+usPPg+w3/yhdgWe5elS9xIHix7a9mPlUbPBR5/bi0YeXuYoZFTuywjW?=
 =?us-ascii?Q?SYmpNWd8ZeV5BrhPdU9hECrp0QgZ5yEn/eeq71o3dPcgvtv23YvXLeH1qCM4?=
 =?us-ascii?Q?DXsLzsGSXE1rMhFFryoGFo1/2yW8DXBwnlNh0XvsPanvW41BHyR50ewOT0yo?=
 =?us-ascii?Q?RXTX+nhbGoMcnV3dXfdtNvYBGc/4dKiLmlPcE+Yb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d589554-677d-4cb4-ad45-08ddaacbe237
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 22:44:41.2117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LyOnQVu+d1VHtxRwUGN+eHcGlZXQ/ziJmlFPM5Lrt6zkqcvCeYdProi7WyEd6g22yjx7r5+fIaO7+zEQ2s3AQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4057

Hi Joel,

On Fri, Jun 13, 2025 at 02:05:03PM -0400, Joel Fernandes wrote:
> 
> 
> On 6/13/2025 1:35 PM, Joel Fernandes wrote:
> > 
> > 
> > On 6/13/2025 1:17 AM, Joel Fernandes wrote:
> >> sched_ext tasks currently are starved by RT hoggers especially since RT
> >> throttling was replaced by deadline servers to boost only CFS tasks. Several
> >> users in the community have reported issues with RT stalling sched_ext tasks.
> >> Add a sched_ext deadline server as well so that sched_ext tasks are also
> >> boosted and do not suffer starvation.
> >>
> >> A kselftest is also provided to verify the starvation issues are now fixed.
> >>
> >> Btw, there is still something funky going on with CPU hotplug and the
> >> relinquish patch. Sometimes the sched_ext's hotplug self-test locks up
> >> (./runner -t hotplug). Reverting that patch fixes it, so I am suspecting
> >> something is off in dl_server_remove_params() when it is being called on
> >> offline CPUs.
> > 
> > I think I got somewhere here with this sched_ext hotplug test but still not
> > there yet. Juri, Andrea, Tejun, can you take a look at the below when you get a
> > chance?
> 
> The following patch makes the sched_ext hotplug test reliably pass for me now.
> Thoughts?

For me it gets stuck here, when the hotplug test tries to bring the CPU
offline:

TEST: hotplug
DESCRIPTION: Verify hotplug behavior
OUTPUT:
[    5.042497] smpboot: CPU 1 is now offline
[    5.069691] sched_ext: BPF scheduler "hotplug_cbs" enabled
[    5.108705] smpboot: Booting Node 0 Processor 1 APIC 0x1
[    5.149484] sched_ext: BPF scheduler "hotplug_cbs" disabled (unregistered from BPF)
EXIT: unregistered from BPF (hotplug event detected (1 going online))
[    5.204500] sched_ext: BPF scheduler "hotplug_cbs" enabled
Failed to bring CPU offline (Device or resource busy)

However, if I don't stop rq->fair_server in the scx_switching_all case
everything seems to work (which I still don't understand why).

I didn't have much time to look at this today, I'll investigate more
tomorrow.

-Andrea

> 
> From: Joel Fernandes <joelagnelf@nvidia.com>
> Subject: [PATCH] sched/deadline: Prevent setting server as started if params
>  couldn't be applied
> 
> The following call trace fails to set dl_server_apply_params() as
> dl_bw_cpus() is 0 during CPU onlining in the below path.
> 
> [   11.878356] ------------[ cut here ]------------
> [   11.882592]  <TASK>
> [   11.882685]  enqueue_task_scx+0x190/0x280
> [   11.882802]  ttwu_do_activate+0xaa/0x2a0
> [   11.882925]  try_to_wake_up+0x371/0x600
> [   11.883047]  cpuhp_bringup_ap+0xd6/0x170
> 
>        [   11.883172]  cpuhp_invoke_callback+0x142/0x540
> 
>               [   11.883327]  _cpu_up+0x15b/0x270
> [   11.883450]  cpu_up+0x52/0xb0
> [   11.883576]  cpu_subsys_online+0x32/0x120
> [   11.883704]  online_store+0x98/0x130
> [   11.883824]  kernfs_fop_write_iter+0xeb/0x170
> [   11.883972]  vfs_write+0x2c7/0x430
> 
>        [   11.884091]  ksys_write+0x70/0xe0
> [   11.884209]  do_syscall_64+0xd6/0x250
> [   11.884327]  ? clear_bhb_loop+0x40/0x90
> 
>        [   11.884443]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> It seems too early to start the server. Simply defer the starting of the
> server to the next enqueue if dl_server_apply_params() returns an error.
> In any case, we should not pretend like the server started and it does
> seem to mess up with the sched_ext CPU hotplug test.
> 
> With this, the sched_ext hotplug test reliably passes.
> 
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>  kernel/sched/deadline.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index f0cd1dbca4b8..8dd0c6d71489 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1657,8 +1657,8 @@ void dl_server_start(struct sched_dl_entity *dl_se)
>                 u64 runtime =  50 * NSEC_PER_MSEC;
>                 u64 period = 1000 * NSEC_PER_MSEC;
> 
> -               dl_server_apply_params(dl_se, runtime, period, 1);
> -
> +               if (dl_server_apply_params(dl_se, runtime, period, 1))
> +                       return;
>                 dl_se->dl_server = 1;
>                 dl_se->dl_defer = 1;
>                 setup_new_dl_entity(dl_se);
> @@ -1675,7 +1675,7 @@ void dl_server_start(struct sched_dl_entity *dl_se)
> 
>  void dl_server_stop(struct sched_dl_entity *dl_se)
>  {
> -       if (!dl_se->dl_runtime)
> +       if (!dl_se->dl_runtime || !dl_se->dl_server_active)
>                 return;
> 
>         dequeue_dl_entity(dl_se, DEQUEUE_SLEEP);

