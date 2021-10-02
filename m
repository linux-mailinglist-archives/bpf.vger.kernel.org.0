Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8808A41F881
	for <lists+bpf@lfdr.de>; Sat,  2 Oct 2021 02:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbhJBAPd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 Oct 2021 20:15:33 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:12764 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232132AbhJBAPc (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 1 Oct 2021 20:15:32 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 191NBRHY009586;
        Fri, 1 Oct 2021 17:13:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=LYX5EnH5ILDHSNg4vtv3idyAomSsgFK4oqiXMPN1PSY=;
 b=C+5ox0ORb87aRh214bf7XJDvA1NrJgGmkf/9eF+Gy58acnnH6dzJpr7+lmDgA0J+ijAA
 4z86xJww29DzgqoEIYpQ233Qjlr37VHODPSfXrSXGbx1KWvGZFtDkqTzhlxvdsGaDN33
 dW/jluhYbvHvb94nggYBkvvZCX7WhnbTHRk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3bebsj893q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 01 Oct 2021 17:13:35 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 1 Oct 2021 17:13:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kk1uEQ7qC6Rd34tOZK6vWZ87dyZyEvkI+FZzY454K9t8Q8fls6vNFU9Ih3ejSW6ukEMvnYMFxI/F4W6tZPBBTrfS9RZiOAPxroF7EvYRaqu9nGmneR6W3XYY2xC60IPh/jkqt62d5ThwowWwkEBmLs/hmcGt5kvUH8sv7Dif1ZLwn/mwakRIs8nPv/b+b9eqS/G3V2VAL7irn/VOGQRsfI3uWxqEAkIo1H7yeucJKlKmSmxg+aS3rz/6tLFkR/LOAK/Ti/5LIy6kzRNLB3nZ/JxS9JwNO+olSzGmySe3y7PLoHHP69rR/AiaCT01sWdzVaRDNzWFO8GtIb3CyCfBAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LYX5EnH5ILDHSNg4vtv3idyAomSsgFK4oqiXMPN1PSY=;
 b=SojYGSayPGvwYmCGIKb6nVXoGt8tLSfFl5ZbUiKZApzmDmFk0LjMZ0cNMPtpAbS0oxMMjI+bPOZB4A5wCmGwqQd+YOutoxhiQ3kzm3oJVoL2Wp/OjbGxOcNbQDqunOq33LuHftOF6iS4pJlOX9pkQYbNC33QZ6mmXvFzNyRTSGiQ9Dqt3Ka8zW7In+plsWn9yFRaJrX4SNML5ze3oPR/yEoSlxVLGiFndQA1yjHUKd9bjM49gxUQ3jkjm2ppWrrq6v2Y7HDq6updc94hzUIOmck5RuNL7aSpFeXKk9FQAxIHmy6oJN4nmk/DNHHs5jYMtnZxdY5daoti0Iqn5cbBAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY3PR15MB4929.namprd15.prod.outlook.com (2603:10b6:a03:3c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Sat, 2 Oct
 2021 00:13:33 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::1052:c025:1e48:7f94]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::1052:c025:1e48:7f94%5]) with mapi id 15.20.4566.019; Sat, 2 Oct 2021
 00:13:33 +0000
Date:   Fri, 1 Oct 2021 17:13:31 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Barry Song <21cnbao@gmail.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rfc 4/6] sched: cfs: add bpf hooks to control wakeup and
 tick preemption
Message-ID: <YVekKx9lP0qlOaPt@carbon.dhcp.thefacebook.com>
References: <20210915213550.3696532-1-guro@fb.com>
 <20210916162451.709260-1-guro@fb.com>
 <20210916162451.709260-5-guro@fb.com>
 <CAGsJ_4xr0Xg3B1seT5_kcb26ZQgWaakR8QGOB-N62wehfXkt_Q@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAGsJ_4xr0Xg3B1seT5_kcb26ZQgWaakR8QGOB-N62wehfXkt_Q@mail.gmail.com>
X-ClientProxiedBy: SJ0PR03CA0242.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::7) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:2431) by SJ0PR03CA0242.namprd03.prod.outlook.com (2603:10b6:a03:3a0::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13 via Frontend Transport; Sat, 2 Oct 2021 00:13:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9698741-4c82-44f6-966f-08d9853978a2
X-MS-TrafficTypeDiagnostic: BY3PR15MB4929:
X-Microsoft-Antispam-PRVS: <BY3PR15MB4929CB971CD333CE81606E4BBEAC9@BY3PR15MB4929.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dwv4p5wmIF0GaqzyVgIuvJpSA6nywtGxea9NaOKphAFD09clpB03jQfhPAI/lUP9hggzLAePdH48RTvXhqG3VYDpzOFJGt/TIzwv8U5lFIZdUt6nUeu/0pfHU3S0rLwLSP6yFJc9gDSNgO0sHPJLMZg1AMXnwLeoWPaX/fh/++kdOtVNv6x+LQXCV+Ba0yrtXE4SSDzqJ0UiXb8T9v9XPk0sXTjvWbz/58YedakK4lD5EK9rUVTgEHYqxEiMMDDSa4XNGbIS4DrNkEpXlEXVQVJrUZWh46wNszofxrU3VPV86py6uVeR1HWOJmF+wNhHFJEvjXzVAZtfKs/ca8RQyWo9RvzkVwwpwO7iXit54VsHWIAqqgqEdj99OH373ovlqNxfjvlNpsmQS5ePU6C4VpSZnrdnUNnTaeJXwyvdHNMhAh/Ub5mn+dbgPjTPgWO2h0zzB6FGgvTl25eDdfrXDent6M7BqIya1CYOgSr3S8uSz16D2SdJZOm5sWp88iusMvtgJ84vFKPAYJzZMJ6YpTW+giwdMaZ5XkOE7o1DglzWQBMzbi1z/7JqVbEAZt31RcMKsDtQqhVP4atS0N4biaJycwtpVZe4l6FAwJ6fh1tdLKaKaz7JtfV4dlahE5A5pJlzE7oFbgnNU20flBXJ1ipkEY5yLMODPOkd+8U2G02cQtXx82pD2JpCgEoRYazyVckFbdOqMRCjZqUUCcaTjXD35RLdAYOpDCvYAjAh43sFY7xQUwP6zionKJPnAbxOxed1RKZsUS0FcO0wEz2YkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52116002)(6506007)(2906002)(66476007)(5660300002)(66556008)(66946007)(86362001)(55016002)(966005)(53546011)(7696005)(186003)(8936002)(8676002)(9686003)(6916009)(54906003)(508600001)(4326008)(316002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sYENaa5xKWcmkMaUcYqLSHx4IJkBaTQwwuSpYE8QqgTPr0Edzd0IGRFSv6xf?=
 =?us-ascii?Q?TLv0HWH/x5Dw931QFvG8dZJDZVC5llcSFXcuY21RH6vm2BuGiMr+13wTwjQU?=
 =?us-ascii?Q?eZDELzKFbCKVM1GwimM4f4td8dF1B3bHUv7PSzOlwXiQnJpAAWhgOq4uME87?=
 =?us-ascii?Q?H9fftbo0GAz7Znf+B123o55d+yJ8opMMEjFpzbgDwMogdbZlsxBr8/hEiHTU?=
 =?us-ascii?Q?YGD27Cpl5IduEMFF68rxAkwUUik/dO8TIZLLDI/2ZsbE+IQnVkMx/nb1BmXf?=
 =?us-ascii?Q?HggAORuAiRqHlHU6VXvkuMxJkH98Dv/W7mLwRDKMFJugphcLDvYrpjcI+z0J?=
 =?us-ascii?Q?knADQqS4CWwXh5HC8SLiwXMDnXgsR74lGkj1QnlXDeBkN+WZnswmad4/s0jg?=
 =?us-ascii?Q?B5er9JnphXnD7Vyxe8A8IUgbmckLHUNNgFZ5GspKJ/GzWcnxjQhEalnf+g/4?=
 =?us-ascii?Q?9jlgoWtqz12uCJPajMXSqaD5hb1IXvBgyXPer5bVemrsO/PpljVnRXReSENF?=
 =?us-ascii?Q?L7j5yxK82MD7bBvj/IKAdZGZaOrHcFlzB0n8b6af3HHhNx47rNuybtHsIQYd?=
 =?us-ascii?Q?7NSvbjjgAnxtKsoYZq6j9dPxxpvd/UVz2Atw6suEy5gn+coOO4AZ0BdHiONO?=
 =?us-ascii?Q?oQgjdiGKvuYfoK+P05XkKZUT5O8dtD67NXu1nq+4ctP8OH/t6gEkmxxknKlJ?=
 =?us-ascii?Q?6i/ABhmpBfkQEjmk8WFabkdqWIuYzO2O3wt6X9CqvLLtdTewFpRwm1ucjhYk?=
 =?us-ascii?Q?YhHn/Ud5lZqreCs9FyEJLi8m+1TzwYyzsnYrgzxHb3dKUVSWa+RZbBqC9NBQ?=
 =?us-ascii?Q?MpRYWhMwvKbFw2r+ViJdBsKR5h3ZUtKaj6bM4Fhtdw07U7Prd4JxaciZggE1?=
 =?us-ascii?Q?7GyrVZQRMGtTeI1U0naN1SsSl+vA80S7noAHqbcNeZzIZKLxkhpKINs3U2ko?=
 =?us-ascii?Q?bN9FwcDfy1Jw6EtHb6bvtsSTLPXJdGsd7dtd5otMkxf5MX1rQoP9PbwPiFbe?=
 =?us-ascii?Q?Rrnd0XM3JqXaAj31qrsvRBGFd4IXU0W0tjteWiVcMML0tFM//xc8S4Q/5sTP?=
 =?us-ascii?Q?8SVCTyC47BXDnzr6qeJpslKQWzeL2453lCqEzvJNVINSjlm5Qrox7d7YmVkT?=
 =?us-ascii?Q?UxvMwmgxUocS48aVoeLA6djrvHu4B6FldktlwAiwjCzX+CWjJJNlNbQVAyM3?=
 =?us-ascii?Q?+qZBsjiPLOtwpShawzrl0GMtw+5oDMLNL+rWIrnMd3UjbwrbULNW5rloGM6h?=
 =?us-ascii?Q?de8y9q2kJqGu0USs8kM3+mVWovbyVdTopv7iJvpkoKhSRweaAE8HAgI20zOM?=
 =?us-ascii?Q?P8tetgazlbLGEOzYWEb1k7ujye12naGkspgx721bEMPBWenj2NlN4IV2DMbI?=
 =?us-ascii?Q?Oic+frU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e9698741-4c82-44f6-966f-08d9853978a2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2021 00:13:33.4426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AnCecQqzZPnMpdkgJDW1pyq7qT3HsJQIZrhLEE+C1B2+qVV1R5ylVIR7PiOlIYZc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB4929
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: u3dwvnc0sOMWe_cRwxv7Rjnqv8dJdX0c
X-Proofpoint-GUID: u3dwvnc0sOMWe_cRwxv7Rjnqv8dJdX0c
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-01_05,2021-10-01_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 mlxscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110010168
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 01, 2021 at 04:35:58PM +1300, Barry Song wrote:
> On Fri, Sep 17, 2021 at 4:36 AM Roman Gushchin <guro@fb.com> wrote:
> >
> > This patch adds 3 hooks to control wakeup and tick preemption:
> >   cfs_check_preempt_tick
> >   cfs_check_preempt_wakeup
> >   cfs_wakeup_preempt_entity
> >
> > The first one allows to force or suppress a preemption from a tick
> > context. An obvious usage example is to minimize the number of
> > non-voluntary context switches and decrease an associated latency
> > penalty by (conditionally) providing tasks or task groups an extended
> > execution slice. It can be used instead of tweaking
> > sysctl_sched_min_granularity.
> >
> > The second one is called from the wakeup preemption code and allows
> > to redefine whether a newly woken task should preempt the execution
> > of the current task. This is useful to minimize a number of
> > preemptions of latency sensitive tasks. To some extent it's a more
> > flexible analog of a sysctl_sched_wakeup_granularity.
> 
> This reminds me of Mel's recent work which might be relevant:
> sched/fair: Scale wakeup granularity relative to nr_running
> https://lore.kernel.org/lkml/20210920142614.4891-3-mgorman@techsingularity.net/

Oh, this is interesting, thank you for the link! This is a perfect example
of a case when bpf can be useful if the change will be considered to be too
special to be accepted in the mainline code.

> 
> >
> > The third one is similar, but it tweaks the wakeup_preempt_entity()
> > function, which is called not only from a wakeup context, but also
> > from pick_next_task(), which allows to influence the decision on which
> > task will be running next.
> >
> > It's a place for a discussion whether we need both these hooks or only
> > one of them: the second is more powerful, but depends more on the
> > current implementation. In any case, bpf hooks are not an ABI, so it's
> > not a deal breaker.
> 
> I am also curious if similar hook can benefit
> newidle_balance/sched_migration_cost
> tuning things in this thread:
> https://lore.kernel.org/lkml/ef3b3e55-8be9-595f-6d54-886d13a7e2fd@hisilicon.com/
> 
> It seems those static values are not universal. different topology might need
> different settings.  but dynamically tuning them in the kernel seems to be
> extremely difficult.

Absolutely! I'm already playing with newidle_balance (no specific results yet).
And sched_migration_cost is likely a good target too!

Thanks!
