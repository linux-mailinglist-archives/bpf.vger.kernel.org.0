Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84130429689
	for <lists+bpf@lfdr.de>; Mon, 11 Oct 2021 20:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234164AbhJKSLz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Oct 2021 14:11:55 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35930 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232071AbhJKSLy (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 11 Oct 2021 14:11:54 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19BI7P3B011736;
        Mon, 11 Oct 2021 11:09:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=aOVbXOSOEmPqHStZ8XCznYju4WeCVOP7dXZk9VUEKxA=;
 b=N/3EJRGmLq662jgWQuQpPNWArxy08nyrZID0Z9OkgxPGud8XRXSWZI+LwKSlDo6Jg/bF
 5cjrnbQH67ec2q5lvnEg5bMmZZbrq9TzvEQD5cPkLM15aIXauqUUbBhfr4uZkUGdlMJ/
 k2P73bRS6/NANrChMZaCuGNuLyYHAlFenvM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3bmhwukqh0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 11 Oct 2021 11:09:41 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 11 Oct 2021 11:09:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WATWHQwSkvIkkYP9Eq4SD2dy0Cdw9DBjklGT8iS/q10Ot/3bmtYgIlRw+14zggyWJEs5eDcwGnFKrNnwUaZhEQy/tB9fQNBi9dU1gripkY0wBuJJtRxXa6jLYTRQuSaQRBi+Qc9FmCidL6YwJx0aRQMwPh1pTuoVMsXgTRi1fmqG7rpUiUmaSUKfDm4ExrMnFtqJGe2y5YuG526EnZ5Yl90J7xW4zjgjbBHhsuUWBmc6eqZRreYF8Zdn1/7baClpbfp+X/O5y9u0pZExsJjD7wr91ym1d5JwjFb6qHjULzf07giEt0xsIt55Kg0xRVa43quGM2BrV4efczsUEks8bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3FqwSc1Pqk76djnyEcSylv5QhQGCXfoxzwMJxo1FNg=;
 b=E/VeInELfWzNXO0zV7OHzNEYthSHW9MCl7cZCSRrJgFsdtLRcF5LuXPuHeBK2OiNwYqojGqW1/h7/16CfHb62C8/fQXApdCIPReiGP1InecqS80KuBCnADP29SP1p9V4jakZisolKMbY432Ao0J35q/PRtsj+d8BMBiMFpiV/f7hAHkAlvMrxk5Cc1SABIkVAdcvZ+WsfbW41i8V8Y/X4hk9fAuuW2kPz3INpVnOxYZ0jrWVfsGJfDA53KER6VsyCAwWexy0UMr8zs5Mo3nSI9Wm81igS5SR8bscCPaShHfbfClmhXVvPVMr2SLrnR+D8fK5rS0gxy7XFAL3LUiang==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY3PR15MB4865.namprd15.prod.outlook.com (2603:10b6:a03:3c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Mon, 11 Oct
 2021 18:09:38 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::1052:c025:1e48:7f94]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::1052:c025:1e48:7f94%5]) with mapi id 15.20.4587.026; Mon, 11 Oct 2021
 18:09:38 +0000
Date:   Mon, 11 Oct 2021 11:09:35 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Qais Yousef <qais.yousef@arm.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rfc 0/6] Scheduler BPF
Message-ID: <YWR9339EvxX6Ld1U@carbon.dhcp.thefacebook.com>
References: <20210915213550.3696532-1-guro@fb.com>
 <20210916162451.709260-1-guro@fb.com>
 <20211006163949.zwze5du6szdabxos@e107158-lin.cambridge.arm.com>
 <YV3v3RkxOB6g/O+8@carbon.lan>
 <20211011163852.s4pq45rs2j3qhdwl@e107158-lin.cambridge.arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211011163852.s4pq45rs2j3qhdwl@e107158-lin.cambridge.arm.com>
X-ClientProxiedBy: MWHPR20CA0038.namprd20.prod.outlook.com
 (2603:10b6:300:ed::24) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:b876) by MWHPR20CA0038.namprd20.prod.outlook.com (2603:10b6:300:ed::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19 via Frontend Transport; Mon, 11 Oct 2021 18:09:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c1abf91-3913-4127-6136-08d98ce24a3a
X-MS-TrafficTypeDiagnostic: BY3PR15MB4865:
X-Microsoft-Antispam-PRVS: <BY3PR15MB4865D920E4AF48D4F0ED69DABEB59@BY3PR15MB4865.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XtdLovR6H9llfrnJI9FRVHeka32aqnyvXRKJX7qaGc8d9GpiRbKUEY7Zks4v2Z83xVBCuggx1Gmceo08XLTJRltVmygdfrQMthwgWvalLK/uAC4N3bweyBAp4muM2fGczM+ok/9a40TXafK99wrfXI8628rwvVyvSHyx1FJbbhqX8CJ29vyVExwRPTM/JCl7A80kg14i+AEw5hWtXrRn3rDZJ9GyCpLNwp3Q89w4FUU/Sn/RzP87d6YwYuthGgF5C55rC3YqCpgqHMnMImNh6NPSM76k9R/ihhfHyC1ySs/D18PfvOe3Gr7OmNrZstSCiRc6nzYuudX+76SLJxAbQd/gvZ/joJNpYC8o/usxvebU/gqc84ioJQGtYu688cSOKPXQBMaq1EEfwZxEAZKDiMlocFbXpw/c0PK1TKXQh4B+DgK9EEpVwHzS4D6fbI7iY58Wy2bAwv3Syzrb1b8kcPiqkZqkAyHxq7ae4Sp2Iv5U4XJmuJuz8htirtFGFtA6r8jXO4w3KSr8ZK7Dwcd2Pd+vMgBeOc8iuVgPmxlKmGRDGiN7tIkz3R/bL3m1QtnhsKbPxPNrx4pelskSou5Y3wZQUL+N5qJpTvPr8fayzrJ2AADtJ0FncbWmgf7kHW9Wl9sjKv7koK9zaDnrEVkZ7eKZWvvepGDwHbM3l/Hna3t7HifxgPQ4vxOOIqRttGQHIChqhMQz0Yh7PKueGRTdsxiialUwfe0UH/lnhWsetBhLzLpjK74/fPApG5OIGMTYtJ8c10gXJnpgMaJy+vJYJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7696005)(5660300002)(6506007)(52116002)(508600001)(54906003)(966005)(6916009)(2906002)(6666004)(66476007)(8936002)(66946007)(66556008)(55016002)(53546011)(8676002)(30864003)(186003)(9686003)(4326008)(316002)(86362001)(83380400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nax5W1w7YmLjFP4L+CZzgo5u8mDE9th3NnK2DdtBvtR5kEd9EPxAq5JCbFG9?=
 =?us-ascii?Q?8AgqoVXrYzO4DTeZ5jiu0gcCKXmU712eNtWcKsO6l5DR4aRiPXC5cfyiz6Pd?=
 =?us-ascii?Q?CF4AXXRZsQhYq5GbzFCYt0LTx5bdBtzxwUt4/mndCcqmInJQteZuVCp3w8Db?=
 =?us-ascii?Q?ont7ddPoz2m04tK2KVW/kpiiRyCzonxUGSd7FFo0gyaJQ43Oz9xvNiFpeqt2?=
 =?us-ascii?Q?05HXEOy9g+uL5ck03uMgjVXk6GKrX9IRWcapmce8pbFHvjwtmXhGTBIFmh4i?=
 =?us-ascii?Q?XtPUHdlqWchEzFQz1CS29g9nonTMPPy227S7WWwBN5zO8bZNFVQIWlE35FnA?=
 =?us-ascii?Q?NV6ueAJquK6Cj1cTB5mrJDrBk4mpE3ycvOiPnyIUfIo5Y7Dqlii+MTket7a0?=
 =?us-ascii?Q?lOAvGAfXG1FFPvId0mJDaEmqtCQtb5i6sKcFS187edzgMwnLWiO8w5z4jlxh?=
 =?us-ascii?Q?oQHrN/UdMCDJeFoSdlACURuZDzkaoeUsK6XUDKyvyEzQV/enNvAiDHlvZvnY?=
 =?us-ascii?Q?fuXEAW6xAeZBr/z+kFELDqORG/siIsFS9SfGGTS6rYJ9CUgFCut13jLE6qUo?=
 =?us-ascii?Q?U4l5MqP7SV90mT72ObHanO11zRHA7AGLobt4KtHvr1q6JowOuGr+MFlwHy0V?=
 =?us-ascii?Q?Mon5dAkXuQyL69zFKAYJx7W75i+w1Fv55AYL7csnkCYUZXd71Xd7sMXuJp24?=
 =?us-ascii?Q?KN9NuUXUsKUtfCbb3F9gPChLkrm+BeRN4TTkysa0Mw2qzFtEa0G4jgeHXghh?=
 =?us-ascii?Q?nVC7HcOy1ObZtuk8mhA4u3ZLz9vDl8dk3YrRxRlD3Zwi09aWkxx5N/KNW4NK?=
 =?us-ascii?Q?zyFS4C1y8llkHTvsztELxf1Gc8UtVt0jd0Jl6N2uVIFM4hNN5zX0juKT90mN?=
 =?us-ascii?Q?7/bLwRJ+wCrPUURfLLS2MWOOTUmXG3c8eOBqY8ARey3GFtayQszGpVWHuh/m?=
 =?us-ascii?Q?hUpIfg9kM/PHXWosTGQyOIogSzmSkC6s6oKDLTvoTTqsc3zOoEFbHpCDANic?=
 =?us-ascii?Q?cM3ddvbJFZ6XlyMVUmmPxDYwe/2qO1RkGAL9tBznrgknZ37Jw0BtrGNddRnc?=
 =?us-ascii?Q?i3nyp8eWPEXKjPUrY4T0g1Y62TAdS95EPSUnTDzv5YlGIMHWN044yjio+NMu?=
 =?us-ascii?Q?kdvDMx+5YBju1ET7iCRQdP8iUoMho/QzqrE92eeyJwv7GIr81IuxFftQyA3p?=
 =?us-ascii?Q?/Swf8f4i7gGFf9F2Yam3I1ktY+5t0+6xJIxOKvMrul2dpmekagk+nzuZX1XC?=
 =?us-ascii?Q?6Qm9ATvHVE8ozI2JcPAVbW0+tuKQNRDvN3F90yQIke19zU+qo49GUTDjz7rd?=
 =?us-ascii?Q?Eb3g4eNheq6HYOtepLplmhW/1Cs2am/Fx/O+qiJpjtpqIg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c1abf91-3913-4127-6136-08d98ce24a3a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 18:09:38.6862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qwun7BpY/TfiQ8R/5PjetRQuuLJaKvk0SOVEr2a7Aj9G6sfEept08spO+MKYo8Fh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB4865
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: zl8Z6Z08xrQcalv1C8ofW_N9trwod9E0
X-Proofpoint-ORIG-GUID: zl8Z6Z08xrQcalv1C8ofW_N9trwod9E0
X-Proofpoint-UnRewURL: 3 URL's were un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-11_06,2021-10-11_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 suspectscore=0 impostorscore=0 malwarescore=0 mlxscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110110106
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 11, 2021 at 05:38:52PM +0100, Qais Yousef wrote:
> Hi Roman
> 
> On 10/06/21 11:50, Roman Gushchin wrote:
> > On Wed, Oct 06, 2021 at 05:39:49PM +0100, Qais Yousef wrote:
> > > Hi Roman
> > > 
> > > On 09/16/21 09:24, Roman Gushchin wrote:
> > > > There is a long history of distro people, system administrators, and
> > > > application owners tuning the CFS settings in /proc/sys, which are now
> > > > in debugfs. Looking at what these settings actually did, it ended up
> > > > boiling down to changing the likelihood of task preemption, or
> > > > disabling it by setting the wakeup_granularity_ns to more than half of
> > > > the latency_ns. The other settings didn't really do much for
> > > > performance.
> > > > 
> > > > In other words, some our workloads benefit by having long running tasks
> > > > preempted by tasks handling short running requests, and some workloads
> > > > that run only short term requests which benefit from never being preempted.
> > > 
> > > We had discussion about introducing latency-nice hint; but that discussion
> > > didn't end up producing any new API. Your use case seem similar to Android's;
> > > we want some tasks to run ASAP. There's an out of tree patch that puts these
> > > tasks on an idle CPU (keep in mind energy aware scheduling in the context here)
> > > which seem okay for its purpose. Having a more generic solution in mainline
> > > would be nice.
> > > 
> > > https://lwn.net/Articles/820659/ 
> > 
> > Hello Qais!
> > 
> > Thank you for the link, I like it!
> > 
> > > 
> > > > 
> > > > This leads to a few observations and ideas:
> > > > - Different workloads want different policies. Being able to configure
> > > >   the policy per workload could be useful.
> > > > - A workload that benefits from not being preempted itself could still
> > > >   benefit from preempting (low priority) background system tasks.
> > > 
> > > You can put these tasks as SCHED_IDLE. There's a potential danger of starving
> > > these tasks; but assuming they're background and there's idle time in the
> > > system that should be fine.
> > > 
> > > https://lwn.net/Articles/805317/ 
> > > 
> > > That of course assuming you can classify these background tasks..
> > > 
> > > If you can do the classification, you can also use cpu.shares to reduce how
> > > much cpu time they get. Or CFS bandwidth controller
> > > 
> > > https://lwn.net/Articles/844976/ 
> > 
> > The cfs cgroup controller is that it's getting quite expensive quickly with the
> > increasing depth of the cgroup tree. This is why we had to disable it for some
> > of our primary workloads.
> 
> I can understand that..
> 
> > 
> > Still being able to control latencies on per-cgroup level is one of the goals
> > of this patchset.
> > 
> > > 
> > > I like Androd's model of classifying tasks. I think we need this classification
> > > done by other non-android systems too.
> > > 
> > > > - It would be useful to quickly (and safely) experiment with different
> > > >   policies in production, without having to shut down applications or reboot
> > > >   systems, to determine what the policies for different workloads should be.
> > > 
> > > Userspace should have the knobs that allows them to tune that without reboot.
> > > If you're doing kernel development; then it's part of the job spec I'd say :-)
> > 
> > The problem here occurs because there is no comprehensive way to test any
> > scheduler change rather than run it on many machines (sometimes 1000's) running
> > different production-alike workloads.
> > 
> > If I'm able to test an idea by loading a bpf program (and btw have some sort of
> > safety guarantees: maybe the performance will be hurt, but at least no panics),
> > it can speed up the development process significantly. The alternative is way
> > more complex from the infrastructure's point of view: releasing a custom kernel,
> > test it for safety, reboot certain machines to it, pin the kernel from being
> > automatically updated etc.
> 
> This process is unavoidable IMO. Assuming you have these hooks in; as soon as
> you require a new hook you'll be forced to have a custom kernel with that new
> hook introduced. Which, in my view, no different than pushing a custom kernel
> that forces the function of interest to be noinline. Right?

I think a relatively small and stable set of hooks can cover a large percent
of potential customization ideas.

> 
> > 
> > > 
> > > I think one can still go with the workflow you suggest for development without
> > > the hooks. You'd need to un-inline the function you're interested in; then you
> > > can use kprobes to hook into it and force an early return. That should produce
> > > the same effect, no?
> > 
> > Basically it's exactly what I'm suggesting. My patchset just provides a
> > convenient way to define these hooks and some basic useful helper functions.
> 
> Convenient will be only true assuming you have a full comprehensive list of
> hooks to never require adding a new one. As I highlighted above, this
> convenience is limited to hooks that you added now.
> 
> Do people always want more hooks? Rhetorical question ;-)

Why do you think that the list of the hooks will be so large/dynamic?

I'm not saying we can figure it out from a first attempt, but I'm pretty sure
that after some initial phase it can be relatively stable, e.g. changing only
with some _major_ changes in the scheduler code.

> 
> > 
> > > 
> > > > - Only a few workloads are large and sensitive enough to merit their own
> > > >   policy tweaks. CFS by itself should be good enough for everything else,
> > > >   and we probably do not want policy tweaks to be a replacement for anything
> > > >   CFS does.
> > > > 
> > > > This leads to BPF hooks, which have been successfully used in various
> > > > kernel subsystems to provide a way for external code to (safely)
> > > > change a few kernel decisions. BPF tooling makes this pretty easy to do,
> > > > and the people deploying BPF scripts are already quite used to updating them
> > > > for new kernel versions.
> > > 
> > > I am (very) wary of these hooks. Scheduler (in mobile at least) is an area that
> > > gets heavily modified by vendors and OEMs. We try very hard to understand the
> > > problems they face and get the right set of solutions in mainline. Which would
> > > ultimately help towards the goal of having a single Generic kernel Image [1]
> > > that gives you what you'd expect out of the platform without any need for
> > > additional cherries on top.
> > 
> > Wouldn't it make your life easier had they provide a set of bpf programs instead
> > of custom patches?
> 
> Not really.
> 
> Having consistent mainline behavior is important, and these customization
> contribute to fragmentation and can throw off userspace developers who find
> they have to do extra work on some platforms to get the desired outcome. They
> will be easy to misuse. We want to see the patches and find ways to improve
> mainline kernel instead.
> 
> That said, I can see the use case of being able to micro-optimize part of the
> scheduler in a workload specific way. But then the way I see this support
> happening (DISCLAIMER, personal opinion :-))
> 
> 	1. The hooks have to be about replacing specific snippet, like Barry's
> 	   example where it's an area that is hard to find a generic solution
> 	   that doesn't have a drawback over a class of workloads.

This makes sense to me, and this is a good topic to discuss: which hooks do we
really need. I don't think it necessarily has to replace something, but I
totally agree on the "hard to find a generic solution" part.

> 
> 	2. The set of bpf programs that modify it live in the kernel tree for
> 	   each hook added. Then we can reason about why the hook is there and
> 	   allow others to reap the benefit. Beside being able to re-evaluate
> 	   easily if the users still need that hook after a potential
> 	   improvement that could render it unnecessary.
> 
> 	3. Out of tree bpf programs can only be loaded if special CONFIG option
> 	   is set so that production kernel can only load known ones that the
> 	   community knows and have reasoned about.
> 
> 	4. Out of tree bpf programs will taint the kernel. A regression
> 	   reported with something funny loaded should be flagged as
> 	   potentially bogus.

2-4 look as generic bpf questions to me, I don't think there is anything
scheduler-specific. So I'd suggest to bring bpf maintainers into the discussion,
their input can be very valuable.

> 
> IMHO this should tame the beast to something useful to address these situations
> where the change required to improve one workload will harm others and it's
> hard to come up with a good compromise. Then the hook as you suggest could help
> implement that policy specifically for that platform/workload.
> 
> One can note that the behavior I suggest is similar to how modules work :)

The important benefit of bpf is safety guarantees.

> 
> > 
> > > 
> > > So my worry is that this will open the gate for these hooks to get more than
> > > just micro-optimization done in a platform specific way. And that it will
> > > discourage having the right discussion to fix real problems in the scheduler
> > > because the easy path is to do whatever you want in userspace. I am not sure we
> > > can control how these hooks are used.
> > 
> > I totally understand your worry. I think we need to find a right balance between
> > allowing to implement custom policies and keeping the core functionality
> > working well enough for everybody without a need to tweak anything.
> > 
> > It seems like an alternative to this "let's allow cfs customization via bpf"
> > approach is to completely move the scheduler code into userspace/bpf, something
> > that Google's ghOSt is aiming to do.
> 
> Why not ship a custom kernel instead then?

Shipping a custom kernel (actually any kernel) at this scale isn't easy or fast.
Just for example, imagine a process of rebooting of a 1000000 machines running
1000's different workloads, each with their own redundancy and capacity requirements.

This what makes an ability to push scheduler changes without a reboot/kernel upgrade
so attractive.

Obviously, it's not a case when we talk about a single kernel engineer and their
laptop/dev server/vm.

> 
> > 
> > > 
> > > The question is: why can't we fix any issues in the scheduler/make it better
> > > and must have these hooks instead?
> > 
> > Of course, if it's possible to implement an idea in a form which is suitable
> > for everybody and upstream it, this is the best outcome. The problem is that
> > not every idea is like that. A bpf program can leverage a priori knowledge
> > of a workload and its needs, something the generic scheduler code lacks
> > by the definition.
> 
> Yep I see your point for certain aspects of the scheduler that are hard to tune
> universally. We just need to be careful not to end up in a wild west or Anything
> Can Happen Thursday situation :-)

Totally agree!

Thanks!
