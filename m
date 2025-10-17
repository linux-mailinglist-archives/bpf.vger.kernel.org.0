Return-Path: <bpf+bounces-71251-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 63AACBEB559
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 21:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF7704FD021
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 19:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C98E33F8C1;
	Fri, 17 Oct 2025 19:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ILMeI6iF"
X-Original-To: bpf@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011002.outbound.protection.outlook.com [40.107.208.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7EB33F8A7;
	Fri, 17 Oct 2025 19:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760727997; cv=fail; b=uE2F22KURQro0KMZDb6r6xG1nBC5G05jTY9PgHB9mhcRytU3+rBYETU4FHpHGAq3kuD5xKc2g6EGUHGHzpoLkt/tMXRDoEjpYm+iuIqk73FFWcK3wdCnnJj6ouTtwmqmpWSYeBPvwHHZegnmsHzffrmBTFmBrVKxuRf2WHkGE6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760727997; c=relaxed/simple;
	bh=pHBYf+/ppcCw1Pu7HT4IRKLQmAdAoOjFh1r4sVPlu20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aj2BJtXl/TbFygDRZQzuJOZwPke/8LAinviO/phX9UoQ7+6WVWyHWELO6Wt24RmAfdnNNkuOHjMt6NFzlwpoempF9r9b132FONdi1L554JwJkFE+rrla5GWAtxs3eQTM/CHNu80Dq3Jq+wCh1318x87XkUfA90NI4qU14hZCv2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ILMeI6iF; arc=fail smtp.client-ip=40.107.208.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h5321jvH5cytcaIJl6oxZR/LmFRMdV6fu6tzSRaGsTqHL6WRRLZkE7kgL2uufj2+HU3mTfWsBMhaNwGuRy5Z9XmiiuRt/tmUjtASx6+YX00NhkttOdBIZ90unCc4Dcjeo+SJfepRlB+i3SSyLjnrW7PIq103I23Bn65tHmHgdlE7vCOQhyIsEnjhy+RN0Y8mBheAk5snlFPMOinCHnqeu8EC7lEZ6dgquvubPYFQgtyr6GyjW6qRJupayrMOOPW7grka9fcY+Y4DA1JHzsQg6CAjycavv4WmUJKGLI3Ddg5zXmNNf+ZBN7YHpFTvIsPkB+azUqJVDyuGbk0Mj/GDCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=70uwq+hknwH440jzXsSijU8b/7oTjEUoeRWKC/1nQlg=;
 b=Dy8qBSbdYh6R9vy9NmSGA+lLDP1mPC+sDZh6LycNK/9KOxfHdu9ZEOZ6ms9OzL1jRCupUuSyqS5fqVUtMDS6vKyh6EdVdI72hNVspe0Q8LlyqPLQQ6ue9Fz5oD66jCcG+p9OckpfIW2bl87n+ZPva0L/m7kSfMzzEPIeHfMJW0N3F12AK8E2gRbeSLERAUrZSJcQuxM8cqeUjXIn/WdoWwuxXXYlGrzvV7tSDSicPL/9BxEvQFiLsCqXQymahfFtNs7Ik13Yp7fBdrU0RwycYr50i92+H1a01VhefPuCiRApTZqiuFmnfvu4PhcYkxbMHR7dLAt7WNoHCBdK62JHqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70uwq+hknwH440jzXsSijU8b/7oTjEUoeRWKC/1nQlg=;
 b=ILMeI6iFP+3JO4rokqdcOfHa0TBJqe/qvmvcip/ETX0os4mHUzBlS9ah/9BpNgHdtKsDsrsZWh3QJLEmMp9m22mZLAAAAv1/8bHL+IctbodE16p3aogskTikj6zAJIpBPuJooWCKwpURubvuWLE5y4nj3CliJsFGhLDHKfQdD2ARb3qWDRwNkm/Gd8/a9iMyTPugDdF3XibPPOfb9JImIOKFRdcfY4/xEbVX4aCPGpbGsQRkDefr+WA73FsSyVeRtlcIPaP4lAj+Zd1nWR2cvMM62I00blspxXdeS0nwXY1QCLGgztCryE3Ghp3RnU1Vi8Qx0bj/Hq47Hd0FpfuV/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB6234.namprd12.prod.outlook.com (2603:10b6:208:3e6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 19:06:33 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9228.010; Fri, 17 Oct 2025
 19:06:33 +0000
Date: Fri, 17 Oct 2025 21:06:25 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: [PATCH 06/14] sched_ext: Add a DL server for sched_ext tasks
Message-ID: <aPKTsSd8uk6RB28s@gpd4>
References: <20251017093214.70029-1-arighi@nvidia.com>
 <20251017093214.70029-7-arighi@nvidia.com>
 <aPJlIUF-KkdOdDvM@slm.duckdns.org>
 <aPKR23mnuuUdmHhZ@gpd4>
 <aPKTN7-JtZVT7wG5@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPKTN7-JtZVT7wG5@slm.duckdns.org>
X-ClientProxiedBy: MI1P293CA0017.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::13) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB6234:EE_
X-MS-Office365-Filtering-Correlation-Id: f4de000e-1534-4797-7811-08de0db0497a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FdjbV2ouYSJUHojsw0B4ZVzzSUXSsIXipRz53/rHepPEKKMNEuW9iEbEn6Oj?=
 =?us-ascii?Q?kyUOYtMhTZoddNz0QanUq2qy5DLCiVTXeFtt1yutWjBNT6KeTtU1cQpeUlmF?=
 =?us-ascii?Q?yM7nDAwO4wyNYyxVpguVmc7I8BwXLUJxXouzqJXrgpLwtzeIIsBQ0uvYQWVq?=
 =?us-ascii?Q?0eAw9j6x97bpZyg+Oe3KxiAOltrroRPeZDsByXbCfUaHVi64Tk6GOJnS2ZIN?=
 =?us-ascii?Q?vQpfpepGa3cl1Wxafnho8qapsbSw8sXwX0wFyOR9Gw1HthDGV65VCnhSMUas?=
 =?us-ascii?Q?nXrN0qMW8ivSTZS3JSQijlY0aOkbNod5tS/7bKtBPJuM/JaiXgPcUXMKHRKO?=
 =?us-ascii?Q?BFZlGSAwYpVnFzjeEbUt/ZZ5ICls9p5uUh0Uvq6JoEdXbh6RlEUB1n6Ck/0f?=
 =?us-ascii?Q?ozuoUr4blyrHNxQchiW4KR5+8nPg7wH/TOXXNPlSh6AMQtVGyEncfM44fQwe?=
 =?us-ascii?Q?9C2OKvX9Svi7+Ep+dLVohHH0sL6AmHZxF8h3TcdIuw9aL2YbBVH1jKbwGgT6?=
 =?us-ascii?Q?TXznu0zFUgcGB1Dt1pBsaZB7cKB8ucA2NgkLYhazi6F7oiP2PMFljhglkgAg?=
 =?us-ascii?Q?PmLT9LBi5d/URpg+vfdlTEen4xt9yi3SFRlCv/4rK80KuRwJbvr+oH7/lE1t?=
 =?us-ascii?Q?3CdiZtaruD1f++lzKW5Y9zlS/ysusmFaXVSbdVQrQnAR3ZmCLDSpyJ7mW67a?=
 =?us-ascii?Q?J/zFjgLQzPCkJJbDi3HRq7YBM1PIYUh8Hequg/R7xGKUZDCEulRJCH/pcXWl?=
 =?us-ascii?Q?cygiSTGMjKjgIWuCm5KbMAh22SL3DP8QnqwgHERO/qZAqJmrekU5xNyQQiPg?=
 =?us-ascii?Q?Kwavc+JMJL1wfDaSkBsJW+n1Mz115NxIn1Q60Bh9VTpiqqj3yJf4ySTCz+uI?=
 =?us-ascii?Q?8ZFFNgQ1RlP5ublp/sf9+5SvfJAyFgWCaI4y/M5xbSsf1Hp7zKCkPukQLsdo?=
 =?us-ascii?Q?BjijQ1VZ9o4226xqtsd7CoVyv3XlBVZE8SvGKht6GnGtg4vtA4ss4HJUUhLg?=
 =?us-ascii?Q?XuYZq9N7QTyg9ejoqmxmO1as1FcI0J5EvPVLLnIS2WWejN9uiAIn/BJ+hmXh?=
 =?us-ascii?Q?2C4/sAQRIlu213fQDoWvyafAYJIzs7zz3WvHco6fIQUv6OjqSgELrw8XFxYn?=
 =?us-ascii?Q?3M8SVgUtch6Hh1c40OzaJB+EMuKHjYd9FPlhgAHVGnJ6U+PPw+U6r+ftoEJ3?=
 =?us-ascii?Q?lDM/iI9X8KgOF2+Gepx9otKZwX6CTtGo76/CSm+WaSTrnoDJq/tvb+eiddyL?=
 =?us-ascii?Q?w/gBCM+lT3G/ghwG5S4RGPJ+ir0F44RQrBEIqJ5g96zIsgFio4xfsK7DuwMB?=
 =?us-ascii?Q?viwhSPZqwrbYyo3tDVRs178bgWrpH/VeAIDIEGXMCXKtcwP1jayhLx/kKmJ4?=
 =?us-ascii?Q?jELGHEN1lpPdTZwn/1SlntGaNjZSlkdUdkoHjeS5CAM6uPG9HE/6F2T/8qIZ?=
 =?us-ascii?Q?zUTDf5aEkZgZ4kF2FwHXeBA8jdi5prCB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AP5ribN7lL+673bw0hNF+svydtg20CK4C48TeL+AgZi534i8+pxvjviw4VtS?=
 =?us-ascii?Q?8s+gQhb0ofPX7TAUcByBv7ZLPo6VES9NnzoBsMheRLqRqswlcUdAzHRWrYuv?=
 =?us-ascii?Q?csoeJrq3oWYMscbvLG+SQ5gy2xsRla+9yLLTG1K8cOp6slv9fY9dHrQ0su/2?=
 =?us-ascii?Q?DnLBrwdXZhG/7df//BujcLBGuwSxaOiwXmHCdKvjpBb8unlEgajAI+5RAVtD?=
 =?us-ascii?Q?S7FNs/kTe9y9ZHpt8XzJZhTk5Ng16fqYocGkPMFbANTXd+OZxsNWo/rL0db1?=
 =?us-ascii?Q?rQALSdhmi5F9QVKbZ+DByF4Y6Ibn7IPRDOR5zdM8d5AYnxKNUX7CoC0gvf0p?=
 =?us-ascii?Q?5kGeb3i48XlL08nzIOISvfwgLHRZMfJiM66Pttiud17eBbAowemo0Og4wI+9?=
 =?us-ascii?Q?hrBDKNR1r1SMm77i/u1UBrZfgI8J4n4ASzOWL9vy+LkkHW7LCv33zFAbblct?=
 =?us-ascii?Q?kErEvcPQGSZsuxtatI55N6rkeFxQnzisKaHMQRNvPmO0hdyRSfPLj3WTliQ+?=
 =?us-ascii?Q?TkikpwQCd3yb62tHJE8VxZ5/JSDJ7m/EYglnwkyrbkdG1Xf/7W3dVo2435aw?=
 =?us-ascii?Q?6iEqpZ5cS4QGjn5uQjHWvtBIGZfN+a5DJCmZm4e9nzTG51vmwnWwQMR8HpTQ?=
 =?us-ascii?Q?wUQUhqEEB+fJEgxInACljEzfN6C+NRfO+k6MAxgbUG6IFwePw6gtprgYXTcp?=
 =?us-ascii?Q?9dPr8hq9wP5AJbWfBS1842+66eCO051UrjhjYzpKd3iQHQuFUEdSJfIbPcH3?=
 =?us-ascii?Q?rMiOaXMhLFzeqNQRmvVkWipxKzIQndb6fndZmD3DONfh64eJZCaVwWTnAz9x?=
 =?us-ascii?Q?6lfct/dYIyO+NW9KCYC4kiTGsGLfd38Wrc9yoUHlM2xRp3iYYYDrcX/7zFY5?=
 =?us-ascii?Q?HV3zn/qmYaQBZ5PTYBpsNevjcuKQkA98Bd2n71nXcHktQTpywmQZoE5T4Gf6?=
 =?us-ascii?Q?eCelKXNNYQNHqWGqpnGbwqrex34njhlS7ZfX+bmSGsf45dA5FEjMicFeBUun?=
 =?us-ascii?Q?4AzFOWeuMJdiq5sxHbx/WfjvVgwgMwXeW2bkQrDgRx8TORUU5IY503KZsOIj?=
 =?us-ascii?Q?KMEvAt2/739Duf/fSx5ZhP7to1FBndZRsbnbupEpbrt3aIbT3aeBYw0pP7w+?=
 =?us-ascii?Q?Yz7wKvSi2prRdZTLE+7h0ydJ0ggaoWNODU+iFT1/AhbjACwuOoX51HHE/1oo?=
 =?us-ascii?Q?6NKGdmQh9ELDjg17BW6QfUAt38Tc9nFZdkMu9HDWkh/N5FR+/XPu/qU/iFSd?=
 =?us-ascii?Q?H+uc29qygK61C3GAIgdd3vekf85T3nsiTnkuhEk8HJ00bRUQsSBTASUvKY2l?=
 =?us-ascii?Q?llG4DAW/NCbexJdxMN4wjmdcsXUZRFiGuo8sOq5VeBSPsQT8vEH8+asJEHVQ?=
 =?us-ascii?Q?h2ZvcEPgvxS5fd8uaBonkTlcDBaRtOsxYHQvQQqRhQg1NmgCrwJuwZmLLrzz?=
 =?us-ascii?Q?6HckIPgP1uhuIEgxDqWrZyV7kYp38bl1FM3SOaA0KWT0Mk938icsZgDeGCHf?=
 =?us-ascii?Q?IrJBsrF7R4d8aWkEnUzMI5Ua69LumC/O1kFodyAZJR3NxzNBXX56YwjvVmZI?=
 =?us-ascii?Q?F6neaX2kI4gftmaQQxyQ3Src0vAG3P+enNahOEmi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4de000e-1534-4797-7811-08de0db0497a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 19:06:33.2751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 89gN3Y0gEsVnfdojB/f7qyo7asn+3t42oLfLtRQlmuuc5VqNSExCyttA0/O+T5rtKaIsFSt/DZJRtus9FDefMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6234

On Fri, Oct 17, 2025 at 09:04:23AM -1000, Tejun Heo wrote:
> On Fri, Oct 17, 2025 at 08:58:35PM +0200, Andrea Righi wrote:
> > On Fri, Oct 17, 2025 at 05:47:45AM -1000, Tejun Heo wrote:
> > > On Fri, Oct 17, 2025 at 11:25:53AM +0200, Andrea Righi wrote:
> > > > +static struct task_struct *
> > > > +ext_server_pick_task(struct sched_dl_entity *dl_se, struct rq_flags *rf)
> > > > +{
> > > > +	return pick_task_scx(dl_se->rq, rf);
> > > > +}
> > > 
> > > I wonder whether we should tell pick_task_scx() to suppress the
> > > rq_modified_above() test in this case as a fair or RT task being enqueued
> > > has no reason to restart the picking process. While it will behave fine on
> > > retry, it's probably useful to be explicit here.
> > 
> > Yeah, that's a valid point. Maybe we can add a new flag to rq->scx.flags?
> > Something like SCX_RQ_DL_SERVER_PICK?
> 
> We can factor out the internals of pick_task_scx() into a separate function
> and add a flag there?

Much better, I like that. Ok, I'll incorporate this change and send a new
version.

Thanks,
-Andrea

