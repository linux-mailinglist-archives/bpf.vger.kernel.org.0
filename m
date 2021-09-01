Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF0F3FD3D7
	for <lists+bpf@lfdr.de>; Wed,  1 Sep 2021 08:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241994AbhIAGdo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Sep 2021 02:33:44 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:30912 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231501AbhIAGdn (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 1 Sep 2021 02:33:43 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1816QIbh023209;
        Tue, 31 Aug 2021 23:32:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=Sw8DTU1EjnjYMYrbny7ZyXwMVVJ9TPO6OQpjkjG6PXk=;
 b=JusScapEn1jSJjbEgzVE4lN75/3tK0F8DhDAgSdtCgmdr37guRqlfwOuVe6yR0oH/EZs
 RQCtUbW7rQsBQBnrtuh3lLTz+nQDAHqtMOwdcY069mcZCmNmmQ0QVPY5iC7GlfkSbF9c
 0FiRlmndLK1uLQib3HRJHe5yg5XTqpECoLQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3asrguvagr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 31 Aug 2021 23:32:30 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 31 Aug 2021 23:32:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFWPqU+eX5bcCpLuLsIlxheNqX+gJKXPqvm7MfUBpQ1o3fZoRnW027nRVxH2jBR6LfYEETGn1KozgL5KQeeVRF+izZ5OzOsnzQLA+PfBYciitbWZg8fb12gVTdnAd2yML2ENNzaLQ95QmgvkSOLV5KuBkUbxyG7e5GPe3EQL8q0ZGbzsBHfYmmth+PwYjyuBCuJAiSaKwzPBUcksYNQPYyfwoxfWIveteey5QpSYbDuPv/KNMpUzfd5RYSABJpXUTc5aAckqxzvDbC9D8xZR3dY3axiRb3kwOzNd0/STKWpCHhP8J5OCm0Eg80cv5LpDb6bBjUi/aWCSmII4hnZ/eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Sw8DTU1EjnjYMYrbny7ZyXwMVVJ9TPO6OQpjkjG6PXk=;
 b=aWD2rtc3xNu9m1wTPr4efcoVi/DUzJF2nZWynqUOBoUlKath3kfkG8BF1OcN7X8Bcv/KS+KSCLfdXbhgzJOY4k4bo/nfoYVZjJ7O7SnJr/zvt5TLVjHOYMMTJcQqV0Ku9yZHcqDBsduxnud9FCvScKN/MhDLJKkvoeNMq5FSW3WvcLtns96wpfuw/vKp33/7i+IuJIHHFs6iZKYNavxdgJTiT55FhqmCcbpa9RqJhMmU2B4TXOLQR7KtYTRjmnsoqz/ubc4gtNjfg064+3NoaX0U26FX1vsCk2MT/b7+xSCGAs89MpBRzVl8EFJ7BNRt6OVTlNFNfXMzGpr59PCJSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by SN6PR15MB4272.namprd15.prod.outlook.com (2603:10b6:805:eb::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17; Wed, 1 Sep
 2021 06:32:21 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::3c1b:1a10:9708:7e36]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::3c1b:1a10:9708:7e36%7]) with mapi id 15.20.4457.024; Wed, 1 Sep 2021
 06:32:21 +0000
Date:   Tue, 31 Aug 2021 23:32:17 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     KP Singh <kpsingh@kernel.org>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Allow bpf_local_storage to be used by
 sleepable programs
Message-ID: <20210901063217.5zpvnltvfmctrkum@kafai-mbp.dhcp.thefacebook.com>
References: <20210826235127.303505-1-kpsingh@kernel.org>
 <20210826235127.303505-2-kpsingh@kernel.org>
 <20210827205530.zzqawd6wz52n65qh@kafai-mbp>
 <CACYkzJ6sgJ+PV3SUMtsg=8Xuun2hfYHn8szQ6Rdps7rpWmPP_g@mail.gmail.com>
 <20210831021132.sehzvrudvcjbzmwt@kafai-mbp.dhcp.thefacebook.com>
 <CACYkzJ5nQ4O-XqX0VHCPs77hDcyjtbk2c9DjXLdZLJ-7sO6DgQ@mail.gmail.com>
 <20210831182207.2roi4hzhmmouuwin@kafai-mbp.dhcp.thefacebook.com>
 <CACYkzJ58Yp_YQBGMFCL_5UhjK3pHC5n-dcqpR-HEDz+Y-yasfw@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CACYkzJ58Yp_YQBGMFCL_5UhjK3pHC5n-dcqpR-HEDz+Y-yasfw@mail.gmail.com>
X-ClientProxiedBy: MW2PR2101CA0018.namprd21.prod.outlook.com
 (2603:10b6:302:1::31) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:954e) by MW2PR2101CA0018.namprd21.prod.outlook.com (2603:10b6:302:1::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.1 via Frontend Transport; Wed, 1 Sep 2021 06:32:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1fc45cff-35c6-4a96-d443-08d96d1240ae
X-MS-TrafficTypeDiagnostic: SN6PR15MB4272:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR15MB4272D359E47B3F82FD5AD42FD5CD9@SN6PR15MB4272.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UplQhbbzZZNpW0F/un0W58iD7hu1x3lrc59dvJGtD1wEVaCYvjEHZSoTdydHiMBcRvRVBadfVB8ozpatjCFb76P7++ymFk20Dun1rxoYkLIIz75C4g4++aiHtHdl6gHC+86oO2B/FD23i88shXmoMSI7+5UTAFstH29L1B+3pdhIdVPMuq7cQq9My2MUbKSQG7pp5+XPdDyndTnr4xrnTtpb2EFDhoe64NL4gKAnIaCm/YCbH4ejf3nz4l5bRoN/avOdsWanZ+tSMCIRhU7tDZ71MLa40M55WZkp6z7nuxNaE45jCh35+366l7UNc0H+XC8uqu2bTIaF7sXsM3qOOU9G217czGdKbyOlT/VXs4BaWuIjwh5B9SLO4bPczFYuli/l4IClVU4LOPUCVQm4RiTu9thMKubEF9HfJlhFaqDpC1QQjdX675GDEQc6qNR8O1Wkm0kcBYFrGRMUTXnZ71RW3MqADlR/9ABywnX7Ij5j//96mXg9AK1+e9an1EoKWHBBBRTH54j5jCR2/viCJ7siU1c3xCfIIUPBzCpbs44coHc7EA6DGNEREOrxvZ0GC2P0/kN1YQyeHuTKz3SDnnD+jgkmmvepbyhdN02/l4Rt7jIkO2GybqvXXzezcHMicvGMGFQsI5UCodWoeov3cCvwXe2ifoDtHHECwhJAIttpTGEqtMLnb58a9+V20niUce+Ns3NNKbF15cM4YV2TsxziB7QnaPFSHXCrOwTvZPY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(8676002)(52116002)(7696005)(316002)(86362001)(5660300002)(83380400001)(2906002)(186003)(54906003)(55016002)(9686003)(30864003)(4326008)(8936002)(6916009)(66946007)(966005)(6506007)(1076003)(478600001)(6666004)(38100700002)(66476007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n+KbMn7RX887CsHPDXvt5lovGnGkVNHLItdf0n+QX5At+S00GtLPpdjr6Wh9?=
 =?us-ascii?Q?ApWH7ZCPqQJ72LB9iW/3s6m4YVaA4DBmTbfv0jH05bKSgE05Q+gT42Yb9kK7?=
 =?us-ascii?Q?Q5FL1tq+MrhbCKhxDjgR08uFD2LornXiUiYeQrDjbFaAlsx5Nx0Me2alCRbR?=
 =?us-ascii?Q?8xZ9U87qTcaZgeQV6CBIuTWn470+osKOEnGXITmZxMO51A16prN/WgOfluy1?=
 =?us-ascii?Q?506ur7dxK1IBc40Nlg8eMYovuleGb/JF7JFUGshjd20Wuts8PbnIFNx3wVgl?=
 =?us-ascii?Q?cM48whyJjTzGUQqOlF48lqhmNYZ+GYT2Oyvg49N0RNcNHT0yxNs/ZIiGnTmA?=
 =?us-ascii?Q?tq+uN7vjWz+5SjiKnBniXK8EOl+XyMPZcSPUkWcfW6Rsk3Ydm/KvY8vIlLOQ?=
 =?us-ascii?Q?PHxIz/fvzlvcZD+BfYpmtOOekVSyNfin/hs3NVfAtd9R+U++uUoUwZoNFDf9?=
 =?us-ascii?Q?hkO9mm/SqE/u3s3A28S7JAOpEC2r/9cIOXSErbcOzI0khPJuJjE7i4C0/gSL?=
 =?us-ascii?Q?Qx5W/7ORGFkiCCMF18OeYPnQmRZUvrf+Zy2k+7VJwJPrZ/n3DODQOucUP/qD?=
 =?us-ascii?Q?n/jmeIfhPDGwSVXfmkqzN4Ttf8HuIJbMSCeVc8UUyiJDgceY/s25/FC9o9Bd?=
 =?us-ascii?Q?33cR7aNK9kUl0qe8IXG40lKqObW5vtMdn4wBSC0/FBV14nw0UsPZYwrz0tmv?=
 =?us-ascii?Q?LNllJ4p3h8T9g/wYlu+fLPhYFdw/SS2WXbq2ZoaI7oa1wOzjrHvJLqEiRVOt?=
 =?us-ascii?Q?AYrFeSM5USC0aM4SeSs8bXdxHmqCUiNpmkzJ6QvPRKm7M2QJwSULiGCL7uQB?=
 =?us-ascii?Q?ImD8HmVO6kyfHmtJXosx7dx7YcEpRVXR2hNQhtAnp3Afm7+sSQb/PIToOlbC?=
 =?us-ascii?Q?gCtF9ckI9z0WUb+ZBmF99nuTcRE5F5SbrwpQyCXhcrDIhsxTbqlRFxqyT73i?=
 =?us-ascii?Q?tzoCD8v2Nv5ZUY/f6h/gyLoYwiJYOYTwc/gAJDRjrFaDfw0+/rBpAo1huUEN?=
 =?us-ascii?Q?nC2oUnmknzY9XdUaXHSHsXvzYtnTUGpEXlJyCmhVZ1aOyh/10dTZnB5ji/02?=
 =?us-ascii?Q?BYFkzxQGXBqyNk8oJQXB1AQKM7K+88C7P+oCGCas7kilqBqNsZ0j5o9Pk3GE?=
 =?us-ascii?Q?re2ToXkyiJ+ixyqTi7YtukKzwED9K/nm5nz8+qXZLVRkGlrUo5+IgkTQNPMn?=
 =?us-ascii?Q?N0bDqgxpjMoez1Vf1O0tDLuupdTo0vOGMEnLJ85RO6kq2ZIq4IgXGeueZkVF?=
 =?us-ascii?Q?D7au34Js8+LmDn1oi3Zzzm0OnOljdcWp/A+mkjJ3uxB4A9jFz/l+/mVWro2v?=
 =?us-ascii?Q?HigODR/gA8Sxhd2FD6b3+8OTKvqrY1+Uw9IFDRJBsFH1Dg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fc45cff-35c6-4a96-d443-08d96d1240ae
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 06:32:21.3984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q0ZjTShovYarNfMsrB1nItetpeO7ExCmPmMva+1qG03UKf/+AyQezOJ6N8miaBrZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB4272
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: dngs4bojLAK0UDTM2X2KedmKG148GJip
X-Proofpoint-ORIG-GUID: dngs4bojLAK0UDTM2X2KedmKG148GJip
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-01_02:2021-08-31,2021-09-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 adultscore=0 mlxscore=0
 phishscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2109010035
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 31, 2021 at 09:38:01PM +0200, KP Singh wrote:
[ ... ]

> > > > > > > @@ -131,7 +149,7 @@ bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_storage,
> > > > > > >           SDATA(selem))
> > > > > > >               RCU_INIT_POINTER(local_storage->cache[smap->cache_idx], NULL);
> > > > > > >
> > > > > > > -     kfree_rcu(selem, rcu);
> > > > > > > +     call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_rcu);
> > > > > > Although the common use case is usually storage_get() much more often
> > > > > > than storage_delete(), do you aware any performance impact for
> > > > > > the bpf prog that does a lot of storage_delete()?
> > > > >
> > > > > I have not really measured the impact on deletes, My understanding is
> > > > > that it should
> > > > > not impact the BPF program, but yes, if there are some critical
> > > > > sections that are prolonged
> > > > > due to a sleepable program "sleeping" too long, then it would pile up
> > > > > the callbacks.
> > > > >
> > > > > But this is not something new, as we have a similar thing in BPF
> > > > > trampolines. If this really
> > > > > becomes an issue, we could add a flag BPF_F_SLEEPABLE_STORAGE and only maps
> > > > > with this flag would be allowed in sleepable progs.
> > > > Agree that is similar to trampoline updates but not sure it is comparable
> > > > in terms of the frequency of elems being deleted here.  e.g. many
> > > > short lived tcp connections created by external traffic.
> > > >
> > > > Adding a BPF_F_SLEEPABLE_STORAGE later won't work.  It will break
> > > > existing sleepable bpf prog.
> > > >
> > > > I don't know enough on call_rcu_tasks_trace() here, so the
> > > > earlier question on perf/callback-pile-up implications in order to
> > > > decide if extra logic or knob is needed here or not.
> > >
> > > I will defer to the others, maybe Alexei and Paul,
> >
> > > we could also just
> > > add the flag to not affect existing performance characteristics?
> > I would see if it is really necessary first.  Other sleepable
> > supported maps do not need a flag.  Adding one here for local
> > storage will be confusing especially if it turns out to be
> > unnecessary.
> >
> > Could you run some tests first which can guide the decision?
> 
> I think the performance impact would happen only in the worst case which
> needs some work to simulate. What do you think about:
> 
> A bprm_committed_creds program that processes a large argv
> and also gets a storage on the inode.
> 
> A file_open program that tries to delete the local storage on the inode.
> 
> Trigger this code in parallel. i.e. lots of programs that execute with a very
> large argv and then in parallel the executable being opened to trigger the
> delete.
> 
> Do you have any other ideas? Is there something we could re-use from
> the selftests?
There is a bench framework in tools/testing/selftests/bpf/benchs/
that has a parallel thread setup which could be useful.

Don't know how to simulate the "sleeping" too long which
then pile-up callbacks.  This is not bpf specific.
Paul, I wonder if you have similar test to trigger this to
compare between call_rcu_tasks_trace() and call_rcu()?

[ ... ]

> > > > > > > @@ -213,7 +232,8 @@ bpf_local_storage_lookup(struct bpf_local_storage *local_storage,
> > > > > > >       struct bpf_local_storage_elem *selem;
> > > > > > >
> > > > > > >       /* Fast path (cache hit) */
> > > > > > > -     sdata = rcu_dereference(local_storage->cache[smap->cache_idx]);
> > > > > > > +     sdata = rcu_dereference_protected(local_storage->cache[smap->cache_idx],
> > > > > > > +                                       bpf_local_storage_rcu_lock_held());
> > > > > > There are other places using rcu_dereference() also.
> > > > > > e.g. in bpf_local_storage_update().
> > > > > > Should they be changed also?
> > > > >
> > > > > From what I saw, the other usage of rcu_derference is in a nested
> > > > > (w.r.t to the RCU section that in bpf_prog_enter/exit) RCU
> > > > > read side critical section/rcu_read_{lock, unlock} so it should not be required.
> > > > hmm... not sure what nested or not has to do here.
> > > > It is likely we are talking different things.
> > > >
> > > Yeah, we were looking at different things.
> > >
> > > e.g. bpf_selem_unlink does not need to be changed as it is in
> > > a rcu_read_lock.
> > No.  It is not always under rcu_read_lock().  From the patch 2 test,
> > it should have a splat either from bpf_inode_storage_delete()
> > or bpf_sk_storage_delete(), depending on which one runs first.
> 
> I missed this one, but I wonder why it did not trigger a warning. The test does
> exercise the delete and rcu_dereference should have warned me that I am not
> holding an rcu_read_lock();
hmm... not sure either.  may be some kconfigs that disabled rcu_read_lock_held()?
I would also take a look at RCU_LOCKDEP_WARN().

I just quickly tried the patches to check:

[  143.376587] =============================
[  143.377068] WARNING: suspicious RCU usage
[  143.377541] 5.14.0-rc5-01271-g68e5bda2b18e #4966 Tainted: G           O
[  143.378378] -----------------------------
[  143.378857] kernel/bpf/bpf_local_storage.c:114 suspicious rcu_dereference_check() usage!
[  143.379914]
[  143.379914] other info that might help us debug this:
[  143.379914]
[  143.380838]
[  143.380838] rcu_scheduler_active = 2, debug_locks = 1
[  143.381602] 4 locks held by mv/1781:
[  143.382025]  #0: ffff888121e7c438 (sb_writers#6){.+.+}-{0:0}, at: do_renameat2+0x2f5/0xa80
[  143.383009]  #1: ffff88812ce68760 (&type->i_mutex_dir_key#5/1){+.+.}-{3:3}, at: lock_rename+0x1f4/0x250
[  143.384144]  #2: ffffffff843fbc60 (rcu_read_lock_trace){....}-{0:0}, at: __bpf_prog_enter_sleepable+0x45/0x160
[  143.385326]  #3: ffff88811d8348b8 (&storage->lock){..-.}-{2:2}, at: __bpf_selem_unlink_storage+0x7d/0x170
[  143.386459]
[  143.386459] stack backtrace:
[  143.386983] CPU: 2 PID: 1781 Comm: mv Tainted: G           O      5.14.0-rc5-01271-g68e5bda2b18e #4966
[  143.388071] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.9.3-1.el7.centos 04/01/2014
[  143.389146] Call Trace:
[  143.389446]  dump_stack_lvl+0x5b/0x82
[  143.389901]  dump_stack+0x10/0x12
[  143.390302]  lockdep_rcu_suspicious+0x15c/0x167
[  143.390854]  bpf_selem_unlink_storage_nolock+0x2e1/0x6d0
[  143.391501]  __bpf_selem_unlink_storage+0xb7/0x170
[  143.392085]  bpf_selem_unlink+0x1b/0x30
[  143.392554]  bpf_inode_storage_delete+0x57/0xa0
[  143.393112]  bpf_prog_31e277fe2c132665_inode_rename+0x9c/0x268
[  143.393814]  bpf_trampoline_6442476301_0+0x4e/0x1000
[  143.394413]  bpf_lsm_inode_rename+0x5/0x10

> > > > > > > --- a/net/core/bpf_sk_storage.c
> > > > > > > +++ b/net/core/bpf_sk_storage.c
> > > > > > > @@ -13,6 +13,7 @@
> > > > > > >  #include <net/sock.h>
> > > > > > >  #include <uapi/linux/sock_diag.h>
> > > > > > >  #include <uapi/linux/btf.h>
> > > > > > > +#include <linux/rcupdate_trace.h>
> > > > > > >
> > > > > > >  DEFINE_BPF_STORAGE_CACHE(sk_cache);
> > > > > > >
> > > > > > > @@ -22,7 +23,8 @@ bpf_sk_storage_lookup(struct sock *sk, struct bpf_map *map, bool cacheit_lockit)
> > > > > > >       struct bpf_local_storage *sk_storage;
> > > > > > >       struct bpf_local_storage_map *smap;
> > > > > > >
> > > > > > > -     sk_storage = rcu_dereference(sk->sk_bpf_storage);
> > > > > > > +     sk_storage = rcu_dereference_protected(sk->sk_bpf_storage,
> > > > > > > +                                            bpf_local_storage_rcu_lock_held());
> > > > > > >       if (!sk_storage)
> > > > > > >               return NULL;
> > > > > > >
> > > > > > > @@ -258,6 +260,7 @@ BPF_CALL_4(bpf_sk_storage_get, struct bpf_map *, map, struct sock *, sk,
> > > > > > >  {
> > > > > > >       struct bpf_local_storage_data *sdata;
> > > > > > >
> > > > > > > +     WARN_ON_ONCE(!bpf_local_storage_rcu_lock_held());
> > > > > > >       if (!sk || !sk_fullsock(sk) || flags > BPF_SK_STORAGE_GET_F_CREATE)
> > > > > > sk is protected by rcu_read_lock here.
> > > > > > Is it always safe to access it with the rcu_read_lock_trace alone ?
> > > > >
> > > > > We don't dereference sk with an rcu_dereference though, is it still the case for
> > > > > tracing and LSM programs? Or is it somehow implicity protected even
> > > > > though we don't use rcu_dereference since that's just a READ_ONCE + some checks?
> > > > e.g. the bpf_prog (currently run under rcu_read_lock()) may read the sk from
> > > > req_sk->sk which I don't think the verifier will optimize it out, so as good
> > > > as READ_ONCE(), iiuc.
> > > >
> > > > The sk here is obtained from the bpf_lsm_socket_* hooks?  Those sk should have
> > > > a refcnt, right?  If that is the case, it should be good enough for now.
> > >
> > > The one passed in the arguments yes, but if you notice the discussion in
> > >
> > > https://lore.kernel.org/bpf/20210826133913.627361-1-memxor@gmail.com/T/#me254212a125516a6c5d2fbf349b97c199e66dce0
> > >
> > > one may also get an sk in LSM and tracing progs by pointer walking.
> > Right.  There is pointer walking case.
> > e.g. "struct request_sock __rcu *fastopen_rsk" in tcp_sock.
> > I don't think it is possible for lsm to get a hold on tcp_sock
> > but agree that other similar cases could happen.
> >
> > May be for now, in sleepable program, only allow safe sk ptr
> > to be used in helpers that take sk PTR_TO_BTF_ID argument.
> > e.g. sock->sk is safe in the test in patch 2.  The same should go for other
> > storages like inode.  This needs verifier change.
> >
> 
> Sorry, I may be missing some context. Do you mean wait for Yonghong's work?
I don't think we have to wait.  Just saying Yonghong's work could fit
well in this use case in the future.

> Or is there another way to update the verifier to recognize safe sk and inode
> pointers?
I was thinking specifically for this pointer walking case.
Take a look at btf_struct_access().  It walks the struct
in the verifier and figures out reading sock->sk will get
a "struct sock *".  It marks the reg to PTR_TO_BTF_ID.
This will allow the bpf prog to directly read from sk (e.g. sk->sk_num)
or pass the sk to helper that takes a "struct sock *" pointer.
Reading from any sk pointer is fine since it is protected by BPF_PROBE_MEM
read.  However, we only allow the sk from sock->sk to be passed to the
helper here because we only know this one is refcnt-ed.

Take a look at check_ptr_to_btf_access().  An individual verifier_ops 
can also have its own btf_struct_access.  One possibility is
to introduce a (new) PTR_TO_RDONLY_BTF_ID to mean it can only
do BPR_PROBE_MEM read but cannot be used in helper.
