Return-Path: <bpf+bounces-67306-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CECFDB4244F
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 17:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B77D1BA78EE
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 15:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087F8311C1E;
	Wed,  3 Sep 2025 15:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f8dUii+I"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD4630DEC0;
	Wed,  3 Sep 2025 15:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756911749; cv=fail; b=h6RNhXZTnvC7iku5j3wBn4QJ7e1g+MHvfT0T18yNaM3DA4ckpSaSlhiOpW087WJvUniHwneLRSXxl9/WXej0YGsBYSqWrFkhNwd+7V3Yqkq3JibsvVoUhYOf/MQO8WIAtsifXAWw1CwieMQiQXHNWo38qSZdKetIGLafnF191vk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756911749; c=relaxed/simple;
	bh=Um8lInFiaJaFrrTyEySzUbMq2K2BLFjQZRlInqnpzCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VMAM5BMfTUhrPdmkbQLro4dwaAdgkqufYYeydf+ln0fFDXYgPjluLBF7yxpsZnLzwc8bOhBrVTQWX7KYq2ig6eOoknOA5j94qQRoWPptsRu9CKj3dk0YJ4a5RgQpckLEZDWG7XucoLJNkNbY+1JuH7bMK9DuKbFo9aovsNU1ia8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f8dUii+I; arc=fail smtp.client-ip=40.107.237.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o4Bp7d9Cc/UhDgGg9KjrxosFpmPyZ88/IMxPBS5Wf550DRN5+hT1cU1W90R+cX1Mnbw3M5Tjx7KqdiaCeBA2sjUHhm5NJsGSdLrtVlrdbVEd9PGjMYwqpwD9vpJmdJB4zaoyrqws5QirJUZ8fryY3oAYYfs46zoWSCJkmKuFNBCDzv1pfvWwtaNLJBGcqZx8maVKDrWchFTKQhY3VF1uhsu2qSbjx8gmrfrbAX7bTuyqqusovs/H2AIW3AH6ApMzOhfpmCKTz6kxwKRPGoiySWrsaa1wkX0pIiOfRC4W+pyiO1a/8twOuy+AWu2UTj+tNsxGx5a/2+RYO4DF2A46Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FhDgREVKqHT5JW76Rco9qWw48VdwqCKPLsLGp0CT4ko=;
 b=YxjwDP5a8gonabNXqnOAM8CpbGuT1Qiq33CehJzoBoZQCFYKHtTSLyxkCNduoq/hfj30GTGoCJq/w/3HvuhLC4O19LXXDbnQkobPPOXgP9hdnQdUiEFZpMsLR0QYfovSuND7TUGrTokOeqY0x/Om1ObVl6sDsLHSzP3Yu9WjkhS8i/n+L3O3CXDBnZTfYkPjsi8JYrcUuCLrpAyGIuEgn/Sau8/SWFUip4/WacLa5dSoKAIYnkfIm+nZRrhFBK5kyS4IOTYLmy4GoIlq4tviiTDD+llmjE9trBDTdIf/5gqEbdmwKsefKlMVFMqVc3a2WwgFqCS2n3kRK/VFpV8hXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhDgREVKqHT5JW76Rco9qWw48VdwqCKPLsLGp0CT4ko=;
 b=f8dUii+IY7Y3F22xMwgANxCKlWi0tDaBlfSrYSmnYJApiPklQBQ4xLa/zwqOxnCs1FVlTNT1xmtrNaf1LBB6UYZpDkVaqbPtrhTO7ZhSRTIDliScQ60khvDdocVUqYYJDa1QL2wh0/Gklgdcf/wRVrb0GHR8U/2D48CbYyzMSM2jI2lEAFbfsY9cXQGKh8CDXPd7LJys/Is5r0CfgDu+SKRPPMY9KxtPmgPa9TWsWNN/d+YrP4s+SghQSDhDQRBU3VFoizdipY3/MyJwLuMz8sYTahqDhuDbD/QMPSMT6hum8KmHJbs+cr6RATqq7Ms68SoLdo2rh0o9/40clqlyaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ2PR12MB8953.namprd12.prod.outlook.com (2603:10b6:a03:544::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Wed, 3 Sep
 2025 15:02:22 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 15:02:21 +0000
Date: Wed, 3 Sep 2025 17:02:17 +0200
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
Subject: Re: [PATCH 03/16] sched/debug: Stop and start server based on if it
 was active
Message-ID: <aLhYeQZBcTsz2KLG@gpd4>
References: <20250903095008.162049-1-arighi@nvidia.com>
 <20250903095008.162049-4-arighi@nvidia.com>
 <aLhUB86NwnaQ8bMf@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLhUB86NwnaQ8bMf@jlelli-thinkpadt14gen4.remote.csb>
X-ClientProxiedBy: MI2P293CA0003.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::16) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ2PR12MB8953:EE_
X-MS-Office365-Filtering-Correlation-Id: ae6aa02c-1c26-4a9f-0887-08ddeafae258
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fdEnjzgjN/Bl/WghZlwjusXZw+bvy85fBH1OTkxnyd7+pgZInrxTj3pwDyf/?=
 =?us-ascii?Q?19WrGuwFn2WLfM4dwJsayL4WKDCBXsHDEvs2Gnz1X1VeGTTYb46O1KwG7NpS?=
 =?us-ascii?Q?SQJ5pGYreUodt+fBColMw18O2uKISIjzxYfhltWrFXZKRb2WXbB35NbGmG4I?=
 =?us-ascii?Q?xuQXwB32hVpGp9SWoLT6GnjTNnbGQDiqnJt8B3ketp4i8rShRs5gtEyKChfb?=
 =?us-ascii?Q?BSsDQIBLfk9uMiHZwxTiD6ZTOes/aACwDchMbl9FJURwU3d0pMbghIj9n30E?=
 =?us-ascii?Q?QfhNszDuno0UdcMz3fH9M82/QxBZL1NkkO74eK98bprJdZFGAfEaCYH9iRd4?=
 =?us-ascii?Q?XAVvgDNcuOOuIPjXY0BfTjM9BdiZ/tljEC12HiSK0Miu/PtDvwSWWfgYt1Um?=
 =?us-ascii?Q?Wa8J8yijU8qYICKQDdoQPWlCRiMAclY5mRvwjeQaPXxFrhyD8pyYTAlIrg8V?=
 =?us-ascii?Q?svfTx+Jbj4uTkb/mrSJtCWWBVC+NqDrPLTjm1i+rTGqfM6KhOCUZzs8ghE89?=
 =?us-ascii?Q?nYK/cY/jMtlmjiEYJW3NbPmS29ep8O8CtYGcpti77GLooBQwUQPN8C4Keydj?=
 =?us-ascii?Q?L2sJC2Z8BuiEjCEiV4dTNZ1saz5zUITIJcx90vEH/GVnsndv7/oL3DDiNijh?=
 =?us-ascii?Q?JdbKnMgnsPmo6tOT/LpEoQvQIIFZeaG0Q7AA3K71CmChSGE6LIVc5YmkouOg?=
 =?us-ascii?Q?p5CUAlUnKWzKJkQkinyDzfVjsKOBkYwsMeSDVBkVTeahiF6fhznomcYEUHJa?=
 =?us-ascii?Q?sWQJTQGSFweF492u2qDN4tkPr5TBhIY34Lhq0Bzx6ew7LPhq8N7izAxQPiZ8?=
 =?us-ascii?Q?AyGF5q8DNzCGIGLu0eYR390sMRlawT+1X3aFxbpE50iGbNLS12bzRRCqs/eN?=
 =?us-ascii?Q?3RtkdueuVAXur6PjKlngGcLD6sLDM0inRVbQOyWjcMsU/bNBHSbt56lqjvA/?=
 =?us-ascii?Q?RqmniKPKC/SoGTmLkWXjQ2Grv03VURd242FgLyVhZJCQlkVg2w0ajoNtRzKD?=
 =?us-ascii?Q?WWmMPBGnuZvLoazRudOUsJuFIm0zABS4NdznMHvoehvPb73rTSIB7qfTep6T?=
 =?us-ascii?Q?HmMmvMbFWd33giq689mMEPJeN1Pepi5g5qMtIuev+DHv/4CzGcg6YA9wBAyX?=
 =?us-ascii?Q?H3hTLB16J7jdZcSiYdEB9WCETabaCXxXncTNAZbfO4/cYTv5PrKdtwrzeciV?=
 =?us-ascii?Q?4ihxqMQnb/sPtq25UH1wSR2hnk2holUpEt2nveUQORq1yKiVbEpQzh8xuJIM?=
 =?us-ascii?Q?f7AVXt8biZ+9X62eqq5ixp67zUmKkSx895MZac5Lkodh6ITZ8FNT6HoR/pz7?=
 =?us-ascii?Q?t/phkZ339y8Csd5NEHHiAr9/VAMKUmFacoAXkWszGvK4ELo+nN9t+KbkLh3V?=
 =?us-ascii?Q?oMUXG4C//YNULmkSZxrdD8UecwnTf2HhB5OYrMKyAd4isC1VtjwUKi540K8E?=
 =?us-ascii?Q?t8VrrS1W3mE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i+BM+K8E0+wfY2sBa93fDYkx107Yct8cmg5gVD4nU31Qp7qBMhmZ3UnLMAAC?=
 =?us-ascii?Q?O7KwEnh9qJZSSDT9jREEPsDmgL2eWgvYBW7TM4/uY5AZLtpCocvLSURrXmRh?=
 =?us-ascii?Q?AiDEGwX4QuUnCKUT3lrRuYFGSAjH5SB51S0eoIAByXxlsQPK1u+b3dS8CVdY?=
 =?us-ascii?Q?/LtMH6t8yrPzlWs6r+PQS9a0SDb/+/DSIjpX4Ps9NtgGQnHmXwAGe32bulB0?=
 =?us-ascii?Q?Me6W8coddZwDo67+iEGqrdJM0enz6DCutk/1ZrCv8PWj8UT0b53gLCAzBOtv?=
 =?us-ascii?Q?97AsbXPDxukf/NEWoT1WiB0BXru8rN5u6jx7o8JV8Qz45oexii4VmMkDTjpa?=
 =?us-ascii?Q?KMIDijx57neTx1aXZVDNQRc0lCvkIOTEhCPxXbHlc+mJRqHojCTOOhO73Bls?=
 =?us-ascii?Q?25z9D8qyqKOC/51U3kCH7LPcYQDBmRsfFV4cXEjWe4XZqI4+l7D3VdHMrEJy?=
 =?us-ascii?Q?uAg1mPLW1yyefL/VhnFIBz/iPkJw9Nh3SZAMsMK57PAPTO2eF5yBVpQ4w9PD?=
 =?us-ascii?Q?udqyIGwkzsV8mYfGTjaL28AbM7nQzOq8ja4tq0NZdbBPf0khKBboArmC80zR?=
 =?us-ascii?Q?1FVMgmgHoQgddJC6D2DTpTNXWC+xQ/99yizjVf0Q80RTAPNuNrZF9j/i/pTN?=
 =?us-ascii?Q?tRxnCZBOi/qf7COUFK7Nuayc0Bgg+9hReAQ+p/s+CSMQVH/PJQlgWDfSeWJL?=
 =?us-ascii?Q?ePcIv+C5PHzthS5E1A+XQs9wH3bnpcjJLn8HOh8VzonyEXiir/Xxw07CPE5d?=
 =?us-ascii?Q?mH36EX/WBV/5bKmXlQnMNbFGlFwhyOKRE81RlxiDpUISfz+ALUsjZ/szbyIB?=
 =?us-ascii?Q?Sh8QasMZBmeNju6ynAcEscmvJlZSxgqbnLIB0Xt3bN8Jao9KKgjxPzQ9B8y3?=
 =?us-ascii?Q?qchQFX1GaBblD/gTbfG5lsJr0Pbo4KFUO4IMdnO+/j6B+cabEoGu/2NV9850?=
 =?us-ascii?Q?Wc9byriuX4FlefCZfjYVcq2JsvzBf24TFf/gPfvxX1/iBwUGu3ocDTPxMsu1?=
 =?us-ascii?Q?Whwch0OUlXhUzSwXrVoKj1Y22hwNqbRLWduMtw84LfktY2Zf5kL8neixhKKO?=
 =?us-ascii?Q?BqpqYNNt4pktSkgnNWv21+6RjxOEAVaESmEzjj9MjCCEcdDxNiiMWM3vBQqQ?=
 =?us-ascii?Q?Qmft8RWczCcYnjOsS44kZDNGqpieLJMJRr07zN2pcWwOzQTWcXxjYd+bgvN4?=
 =?us-ascii?Q?qKLjyt9wr8QfSlEXJ977t2eOXkviw+xXkke+AL2dR9HShStur7XKxPtVSiNg?=
 =?us-ascii?Q?nBx64JCP+rNXd+D+i+eSXer9ePAmhaiOOX606vjmdIbn3QQNzoh9VdTfnqfs?=
 =?us-ascii?Q?ltsQGj+hYuZTEvKsqzw1DJQ9ukBt9GDIRRT96gP/K9R9XN/3mAnW3cmWKUcJ?=
 =?us-ascii?Q?AptRPUT6Dm4JplKrH3uOOpN+DDm3hdwMMjvLQLt649VMzzVmDcUfU3oM79E4?=
 =?us-ascii?Q?jfH+hqvnYOanwY4W43QAORLPqG87rQYfTjBr0IFSIXWIj+JCcrkY8Rx3HC5F?=
 =?us-ascii?Q?bVDlEqEKmg/apnpM1Mr+NMz0GGrl9Lwev6vraiqE1NNoJMc1uH5Gu3jil0Db?=
 =?us-ascii?Q?WdcwlrL/+EnFkTwiGqFQZ1yWnIp2qsU7udusQ7jJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae6aa02c-1c26-4a9f-0887-08ddeafae258
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 15:02:21.8960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x1e03+NGdTVWXR5CamryByCrQiTUcgKhfuxt6vwkLkXBvsajJxWLEkRwYoQkCWhN2oF6iD2Stfr9Z3cqepV5zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8953

On Wed, Sep 03, 2025 at 04:43:19PM +0200, Juri Lelli wrote:
> Hi,
> 
> On 03/09/25 11:33, Andrea Righi wrote:
> > From: Joel Fernandes <joelagnelf@nvidia.com>
> > 
> > Currently the DL server interface for applying parameters checks
> > CFS-internals to identify if the server is active. This is error-prone
> > and makes it difficult when adding new servers in the future.
> > 
> > Fix it, by using dl_server_active() which is also used by the DL server
> > code to determine if the DL server was started.
> > 
> > Acked-by: Tejun Heo <tj@kernel.org>
> > Reviewed-by: Andrea Righi <arighi@nvidia.com>
> > Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> > ---
> >  kernel/sched/debug.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> > index dbe2aee8628ce..e71f6618c1a6a 100644
> > --- a/kernel/sched/debug.c
> > +++ b/kernel/sched/debug.c
> > @@ -354,6 +354,8 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
> >  		return err;
> >  
> >  	scoped_guard (rq_lock_irqsave, rq) {
> > +		bool is_active;
> > +
> >  		runtime  = rq->fair_server.dl_runtime;
> >  		period = rq->fair_server.dl_period;
> >  
> > @@ -376,7 +378,8 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
> >  			return  -EINVAL;
> >  		}
> >  
> > -		if (rq->cfs.h_nr_queued) {
> > +		is_active = dl_server_active(&rq->fair_server);
> > +		if (is_active) {
> >  			update_rq_clock(rq);
> >  			dl_server_stop(&rq->fair_server);
> >  		}
> 
> I believe this chunk will unfortunately conflict with bb4700adc3ab
> ("sched/deadline: Always stop dl-server before changing parameters"),
> but it should be an easy fix. :)

Right, I also tested that in a separate branch, this patchset is rebased on
top of Tejun's branch that doesn't have bb4700adc3ab yet. But from a
sched_ext perspective everything seems to work fine either way.

Thanks,
-Andrea

