Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 826A6424647
	for <lists+bpf@lfdr.de>; Wed,  6 Oct 2021 20:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbhJFSwQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Oct 2021 14:52:16 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:4900 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229564AbhJFSwP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 6 Oct 2021 14:52:15 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 196GfGeY017722;
        Wed, 6 Oct 2021 11:50:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=QERhE9EtIK2KMbQeXw05WTvxyzy7W+uPg/f00Z/DzSs=;
 b=kMYXbfjychsheQ5pjcYB5FFUf+wG47A+DsAqFaS60O5WhQrj7Ag7hf3MRFiU++QXUO0w
 BFwfcQqAcDsmdwhQJeNEQ3GWVKuHyTwIbVTJLccEgTYGv//2SmsTsleGC71qgG4+tU7J
 act3f7zJZMOgo9SjSNZD20aa5JzpbPIP8Jg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3bhfhj9604-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 06 Oct 2021 11:50:10 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 6 Oct 2021 11:50:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hAhY9mkk9gtMS7n831QXCXehg6SJr1J8h5Vhzd4QNtAhjirDZRU4/1N/7o+lFkEmw82HA+rPeLLJdOOM+z3V4JhYLkBMtJfXg+s6vBSYRLSPBB4clAzQXki/VdL0Mn0lXZiKKZujWMCS0lYrjuGGZGxcH1Hso+6rMbedSKq6qO/qJXWJiK62LNWwsfqAVIiPVoB78dEnIhjNETuuQpB9xo+yv+olKXv3qgfR1A4a4cjTR3TiBuIhriMBXtPkU4U+PkbWOxfGNG4XSpQVpkpZ0MXeXoOb+jJtYzHW0CI2xydy4v582qDAqVN9VbXLZEwS7CoxcV2A7OuMtL9yAW4gCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eRKL01LMs1CMSwAK+MTF4n0wyl2pg+HFaMu+W8Rsy0o=;
 b=PJ20dJpZb6Ws8oEqGEe4ivWm9/2JRnRwJW7xNXacWwGYyowj1ed0HVN1FACBG+8jS47LTeq61JhruOlqsM/+Uq09eVDpLXoe7KBCChy8p3RgxQBttEbVMyuP7loklkfpumwyJBkXnOJH0fQbDlgQpGbToiPHMvjzK5u8bv3dEJPSBIBFAUZDu+GjGRB4EAPDA6rRDncLFqs87oJQ5HghU92h3rQ7k/6wci0UO5GxRLWMiG7VuCvru4c42rFAnO0rTCA164FrTmPGp6wUv97KzYIhcNDgpZvLjKqh9VWDIaWywNSZGktZVnvMKbunys6VIiAy8QpRudnPLXgB5ZUJig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY3PR15MB4961.namprd15.prod.outlook.com (2603:10b6:a03:3c4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Wed, 6 Oct
 2021 18:50:08 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::1052:c025:1e48:7f94]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::1052:c025:1e48:7f94%5]) with mapi id 15.20.4566.022; Wed, 6 Oct 2021
 18:50:08 +0000
Date:   Wed, 6 Oct 2021 11:50:05 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Qais Yousef <qais.yousef@arm.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rfc 0/6] Scheduler BPF
Message-ID: <YV3v3RkxOB6g/O+8@carbon.lan>
References: <20210915213550.3696532-1-guro@fb.com>
 <20210916162451.709260-1-guro@fb.com>
 <20211006163949.zwze5du6szdabxos@e107158-lin.cambridge.arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211006163949.zwze5du6szdabxos@e107158-lin.cambridge.arm.com>
X-ClientProxiedBy: BYAPR07CA0041.namprd07.prod.outlook.com
 (2603:10b6:a03:60::18) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
Received: from carbon.lan (2620:10d:c090:400::5:b62f) by BYAPR07CA0041.namprd07.prod.outlook.com (2603:10b6:a03:60::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend Transport; Wed, 6 Oct 2021 18:50:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3f1458d-848f-4530-761d-08d988fa1e56
X-MS-TrafficTypeDiagnostic: BY3PR15MB4961:
X-Microsoft-Antispam-PRVS: <BY3PR15MB4961EB0072BEB728BD503B40BEB09@BY3PR15MB4961.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u9UR7spxsKdDePhJmWeBVGVkx18kqa8wT6kfPDBndjHtjVw1H3k6MONYAxaX+dVPI/7/9pY5PhTXyIeqH1HnXxXKTVqsXZPD3kTAgEuIKIKkapqYxgJU3LV/x/03+ut8CTUqFX9y3KwpKaOQyzPdRvcRchQ1xvR2v2gID6FEoWF1Wb/yDtEZeM3I0VWbLv6/WTuxI7pkodch4/MxmsLWf5EioF8v3otv36hkjrcmtNTaaa7pNCPtIiTk+O0at4vci9iANtwfTGPpMNX8jmIysUdYob2njMqzy8u6B1Y81aC0r6jMxilATTNFfoenMrXzGPg8d6fpkCVzGncS5+Ss/EEtKZm0Uo8LRVxg5iTH+TmtIJUEcm/0W1ii6vwFO90J32L4AxlNsJZ8OAUWqyxm8Lm/UL4ALAh3f/cjpBP7bDeE3+FJqAQsd+C1pr/oqgTlI+wAqOdIkyZGAcYkuhXGb5JUKXtrgttSQjYWB0CIKdnQHVaTdqMthIgooK4G1y9/ajDS6BNH8+ec8sKnwjRY/OUBpeRH7hWhXnFdUpEejmuHIbmbvnwbCIvxUugh72EB/qvnkzfD4vrhliIJPkzNcTzZe6rAj4yprsMeTJfzcmkGst8GZsUUZ61txxjH5q2kWRUmbAYbEXkqDMWjHTmigsw/jeTgnyRKpfAu/dz1KTsEZ2FlxfeWcpwdguvaNh67oINvSJcmhpITQ/yYj1okNpRo3gsyIW7K0v57rXHm8lrGvJw1a4Qp3+I+U7sEhyqT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(53546011)(966005)(86362001)(52116002)(54906003)(4326008)(7696005)(66946007)(8936002)(6666004)(8886007)(36756003)(55016002)(38100700002)(508600001)(6506007)(66476007)(2906002)(66556008)(8676002)(83380400001)(9686003)(186003)(316002)(6916009)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+onFmzTnAxbD/Wuww2EcZVSgDrDJz2NWodVkmepWBdO95MLCipl1w0UW2T7K?=
 =?us-ascii?Q?k5Ix4fIHRkUBKElzQtp3GrB0yUiovntaQsM3Mq44HH5OTwZUWcPSQQK16dI7?=
 =?us-ascii?Q?Bfyf4Mp+8rtwyEAVB7ZcKz3auC9g7QiuscTwTN1yXCW0EGuSRNNH/gwlCbvW?=
 =?us-ascii?Q?fTlh5vloM1EG9WKKAmHZm4Y+91otVNQCrYHXJHdLgAStLw4GZt98hhQedNJD?=
 =?us-ascii?Q?poNdeXNfnxI/dIqkQTyeWWGpdxeK7xck5tkuRzggKqoFqdLRXFxkuhZm2zD+?=
 =?us-ascii?Q?Qo04FdYNTFJvdoVp/wMIQjWMDNkNHA8KVqV2GCXy7+qUeQAzJq6LXTdV2qT3?=
 =?us-ascii?Q?qkNG8mXeZZCyJEyuMMquH9kAC4GHWE4pwSmZNmCtOaxl7ZEaSFr12qgbX9Td?=
 =?us-ascii?Q?/f3Q3U3NIKpqgWBPN13rsQpSsKVD3D2bMbA1XtHWYCcJeqymGjB/C1F9YdfG?=
 =?us-ascii?Q?mSuu+gSdc91zQPPp6AdYo2pFFtQ8exd9Ax1Y5he+JLeD495XfUhvgMF7Djdi?=
 =?us-ascii?Q?jUP5g7JIHwrcxikBqaENuY1+eFa8AZD5uCl7H7zCx2oIoofsAJnR8FrDZspr?=
 =?us-ascii?Q?F1c9F6LZVYzD8f1V6XmL15qCVYDuHP+GB3EV9g72dXYQVKYF8i+iS9Fhax6A?=
 =?us-ascii?Q?0cZiZ1Dv2fvWznaydZi3d5O6J2VGO2tI/Vsx3YaIPyd4T3TURM2E8rLhlNOi?=
 =?us-ascii?Q?azG202SsRYsipyAosncWfngYOLu6sHEof86Ey/cxeRTPEJQFnAMX46cBw3ho?=
 =?us-ascii?Q?QLVF4knKnCmFwYIdeBrIDV//d8s9yySdzsbpcw/dFLfD8O/xnPiAPc1PK5jd?=
 =?us-ascii?Q?WI5URS3u2xENlMDXXV5bL1XDPQ5jdGHeZ4SENcJCiLbPLPiz4xMspRYFjExK?=
 =?us-ascii?Q?G2KiOce9v7gusN7uBCv7NnxXZPXDHaja5SRwq3scShbzW242Nuqm581Ed8dJ?=
 =?us-ascii?Q?vGz/49NzEFzChQc1zGwe99/vfzg4KTpRzrbfea3wn47BvKSFDzASEHgKnXQy?=
 =?us-ascii?Q?2POlHkUwMYj0o2R02hOtkw5QY/0h2MLR4/ZFyP42rsYprQB9CA8qfYxAa4vh?=
 =?us-ascii?Q?0q/Ixbc0FY5spJVkUD+FExEGC6evFliBYedKojVsQXnpEMUJ8DzaI+SODb1m?=
 =?us-ascii?Q?BGwzLb5m9mYt71sjx/jrpw2bpAuk+tRFhsXvaMaGwFjJBolXeomCj/etY0rN?=
 =?us-ascii?Q?vXYzWHNaXtbMrTG6ObI7kc1PcmHi4b4LcThL021tibN0z7d1O7gH3Bf3Juu4?=
 =?us-ascii?Q?cRZsJ6Ne0JSfM48VHFynMVWOiACZS/+7XkJhd0NtjPsM8lHybyGjJXIjq87X?=
 =?us-ascii?Q?a8z3qxoszpP4E44X9EKrBsSoUzNvwIEZ2SJyttplrHyT3g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a3f1458d-848f-4530-761d-08d988fa1e56
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 18:50:08.4908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DGrHsxPoapwGpy0W5qvOKqPsDNwQlYfAX0rOaka+IVvh4kIaQ+wsElSFx0fVZCH7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB4961
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: UtMdRYOKYCtp34h7ui6i0ptW1D-dVTtE
X-Proofpoint-GUID: UtMdRYOKYCtp34h7ui6i0ptW1D-dVTtE
X-Proofpoint-UnRewURL: 3 URL's were un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-06_04,2021-10-06_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=999 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110060117
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 06, 2021 at 05:39:49PM +0100, Qais Yousef wrote:
> Hi Roman
> 
> On 09/16/21 09:24, Roman Gushchin wrote:
> > There is a long history of distro people, system administrators, and
> > application owners tuning the CFS settings in /proc/sys, which are now
> > in debugfs. Looking at what these settings actually did, it ended up
> > boiling down to changing the likelihood of task preemption, or
> > disabling it by setting the wakeup_granularity_ns to more than half of
> > the latency_ns. The other settings didn't really do much for
> > performance.
> > 
> > In other words, some our workloads benefit by having long running tasks
> > preempted by tasks handling short running requests, and some workloads
> > that run only short term requests which benefit from never being preempted.
> 
> We had discussion about introducing latency-nice hint; but that discussion
> didn't end up producing any new API. Your use case seem similar to Android's;
> we want some tasks to run ASAP. There's an out of tree patch that puts these
> tasks on an idle CPU (keep in mind energy aware scheduling in the context here)
> which seem okay for its purpose. Having a more generic solution in mainline
> would be nice.
> 
> https://lwn.net/Articles/820659/

Hello Qais!

Thank you for the link, I like it!

> 
> > 
> > This leads to a few observations and ideas:
> > - Different workloads want different policies. Being able to configure
> >   the policy per workload could be useful.
> > - A workload that benefits from not being preempted itself could still
> >   benefit from preempting (low priority) background system tasks.
> 
> You can put these tasks as SCHED_IDLE. There's a potential danger of starving
> these tasks; but assuming they're background and there's idle time in the
> system that should be fine.
> 
> https://lwn.net/Articles/805317/
> 
> That of course assuming you can classify these background tasks..
> 
> If you can do the classification, you can also use cpu.shares to reduce how
> much cpu time they get. Or CFS bandwidth controller
> 
> https://lwn.net/Articles/844976/

The cfs cgroup controller is that it's getting quite expensive quickly with the
increasing depth of the cgroup tree. This is why we had to disable it for some
of our primary workloads.

Still being able to control latencies on per-cgroup level is one of the goals
of this patchset.

> 
> I like Androd's model of classifying tasks. I think we need this classification
> done by other non-android systems too.
> 
> > - It would be useful to quickly (and safely) experiment with different
> >   policies in production, without having to shut down applications or reboot
> >   systems, to determine what the policies for different workloads should be.
> 
> Userspace should have the knobs that allows them to tune that without reboot.
> If you're doing kernel development; then it's part of the job spec I'd say :-)

The problem here occurs because there is no comprehensive way to test any
scheduler change rather than run it on many machines (sometimes 1000's) running
different production-alike workloads.

If I'm able to test an idea by loading a bpf program (and btw have some sort of
safety guarantees: maybe the performance will be hurt, but at least no panics),
it can speed up the development process significantly. The alternative is way
more complex from the infrastructure's point of view: releasing a custom kernel,
test it for safety, reboot certain machines to it, pin the kernel from being
automatically updated etc.

> 
> I think one can still go with the workflow you suggest for development without
> the hooks. You'd need to un-inline the function you're interested in; then you
> can use kprobes to hook into it and force an early return. That should produce
> the same effect, no?

Basically it's exactly what I'm suggesting. My patchset just provides a
convenient way to define these hooks and some basic useful helper functions.

> 
> > - Only a few workloads are large and sensitive enough to merit their own
> >   policy tweaks. CFS by itself should be good enough for everything else,
> >   and we probably do not want policy tweaks to be a replacement for anything
> >   CFS does.
> > 
> > This leads to BPF hooks, which have been successfully used in various
> > kernel subsystems to provide a way for external code to (safely)
> > change a few kernel decisions. BPF tooling makes this pretty easy to do,
> > and the people deploying BPF scripts are already quite used to updating them
> > for new kernel versions.
> 
> I am (very) wary of these hooks. Scheduler (in mobile at least) is an area that
> gets heavily modified by vendors and OEMs. We try very hard to understand the
> problems they face and get the right set of solutions in mainline. Which would
> ultimately help towards the goal of having a single Generic kernel Image [1]
> that gives you what you'd expect out of the platform without any need for
> additional cherries on top.

Wouldn't it make your life easier had they provide a set of bpf programs instead
of custom patches?

> 
> So my worry is that this will open the gate for these hooks to get more than
> just micro-optimization done in a platform specific way. And that it will
> discourage having the right discussion to fix real problems in the scheduler
> because the easy path is to do whatever you want in userspace. I am not sure we
> can control how these hooks are used.

I totally understand your worry. I think we need to find a right balance between
allowing to implement custom policies and keeping the core functionality
working well enough for everybody without a need to tweak anything.

It seems like an alternative to this "let's allow cfs customization via bpf"
approach is to completely move the scheduler code into userspace/bpf, something
that Google's ghOSt is aiming to do.

> 
> The question is: why can't we fix any issues in the scheduler/make it better
> and must have these hooks instead?

Of course, if it's possible to implement an idea in a form which is suitable
for everybody and upstream it, this is the best outcome. The problem is that
not every idea is like that. A bpf program can leverage a priori knowledge
of a workload and its needs, something the generic scheduler code lacks
by the definition.

Thanks!
