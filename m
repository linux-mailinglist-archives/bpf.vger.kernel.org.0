Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B59BD3FC0B7
	for <lists+bpf@lfdr.de>; Tue, 31 Aug 2021 04:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239273AbhHaCMu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Aug 2021 22:12:50 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39358 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232187AbhHaCMt (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 30 Aug 2021 22:12:49 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17V2AnIl014698;
        Mon, 30 Aug 2021 19:11:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=tzsOsXzwM++RcTxomHTmJeBTjgLbu15qEpRZA9LpmPM=;
 b=B8ko+2nZIVF6rBWTvW2pNAwzF5YP4cM17hzltbdzPTeIpdlfYKzMd5bGqFn0MZvcm0oL
 feH8oNbzmYQe+08O9YrnuJAtFHFPrMwK3P7Nurs/tT9q1JWkOi4bQhE76VRWAurh1OdJ
 VMwmeWxgDLMucc/8+7qALeK7tWoAW1iNdiA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3aryscvfpe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 30 Aug 2021 19:11:36 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 30 Aug 2021 19:11:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QuqRiaUS9IUUagmAmyIXjUbPV17CFOldB6xcB9qUQODimVeCxqf08M2cGAkRRODpQqIw3nc3nacBf40JgsXuxB1kg+8j1L0HDlmmdysWym5aCbcIPuU/vKS8/x1zX6YYbLOYzszIx8rhX+drMM+e8Ft9ZScqhlL5F7fDb9ak7fMNiNv/RNLjQylX7yqBWrDAPrqd7yUtY+RRom/u58+I4gxJ1t54OEaCHSn7L4en/Kybj6Pmqpog9VgIdTNOy7EKqjvALjGNE4drdqAolNYKHN3GdXL6ck0Ud8hV5uN2qEpZRTmXAf28N5Ezff4Bbno8aGFsq42dTRhekPdQZC7kxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tzsOsXzwM++RcTxomHTmJeBTjgLbu15qEpRZA9LpmPM=;
 b=gQecLvFfgp+YdsmOzj4N9IZQHbsT+UrWHk+FKGjJcn7+fbQ4WJmPBHFNNXn+pmGM6Dg8gFSnsvWhGUio3cyYa+85004iqAocVKufsyKUqzLOycyVJbem8/qNksEA7EgAxui5nrth2mpmaZrUY6Wmg4gdQREVyPqjgWp+3XK9xyh8KDT8tFWieU4A1aCTge7tBmSf1lqjShQTcNPifCJI2pQNWL8yVPH9PBrJfrxWp5yd9ZEkjm3CBngB3pw4cWa1szlaW6IHk9j8bNmN6kIMImOhZhN49sddGU4ANSOye9dz7x0Ayya+jF0s9yzpKqEYl1HqhIRKjro9jVvCPVzWEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by SA1PR15MB4369.namprd15.prod.outlook.com (2603:10b6:806:190::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.19; Tue, 31 Aug
 2021 02:11:34 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::3c1b:1a10:9708:7e36]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::3c1b:1a10:9708:7e36%7]) with mapi id 15.20.4457.024; Tue, 31 Aug 2021
 02:11:34 +0000
Date:   Mon, 30 Aug 2021 19:11:32 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     KP Singh <kpsingh@kernel.org>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: Re: [PATCH bpf-next 1/2] bpf: Allow bpf_local_storage to be used by
 sleepable programs
Message-ID: <20210831021132.sehzvrudvcjbzmwt@kafai-mbp.dhcp.thefacebook.com>
References: <20210826235127.303505-1-kpsingh@kernel.org>
 <20210826235127.303505-2-kpsingh@kernel.org>
 <20210827205530.zzqawd6wz52n65qh@kafai-mbp>
 <CACYkzJ6sgJ+PV3SUMtsg=8Xuun2hfYHn8szQ6Rdps7rpWmPP_g@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CACYkzJ6sgJ+PV3SUMtsg=8Xuun2hfYHn8szQ6Rdps7rpWmPP_g@mail.gmail.com>
X-ClientProxiedBy: SJ0PR13CA0039.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::14) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:2258) by SJ0PR13CA0039.namprd13.prod.outlook.com (2603:10b6:a03:2c2::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.6 via Frontend Transport; Tue, 31 Aug 2021 02:11:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81484c9f-ff32-49ba-03b1-08d96c24a819
X-MS-TrafficTypeDiagnostic: SA1PR15MB4369:
X-Microsoft-Antispam-PRVS: <SA1PR15MB4369B8924C0E743BA55D4E2DD5CC9@SA1PR15MB4369.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: InW1sxlSxojUYXr3HIKWMgwDJdyDBG3v/0UuaoUBRevsLeb2mJLzabY+AT5/gedoq4w9ZQLcAO6DXEUbgG5r6nbhqjsL+VIu+yUt83Wskiu/Uu8D/TsNAzIlWugO+eSw4LnXXEICCflqQIEe7k5q+g3hUcqLsFE0SUmSeNicmYqCXTR/g4B4c1QIpZmbjufz80u6G8/g0oyPmxmklhuLlJa07D44L/+ZSxL9Na6KL6djh6PKsHliC4wWknSdmMCn5/UcfDyasYsPplvfOGwzuR97HzjKbifTkgbpRhWmVit+KiL8x5Y0XZL+YFOaikPJ+6sEloacKq0KIleT3REjHNWgM58b2vwFErBbnREUMHxTBxMJgOTtbc2HSs4TJeu0wEN14H3rpDyBUhh4Gvn2lJKqAi7r1Y8/U2ecFCRsEKIaxTIKUzK2dYdaqi8UMVwZE40oQIz3afKm16vHyg/hsqqgLixtJWZTc4QBSxagJCD1UsPqC8CxhNI0k+JcXB3z47kRpRvlAFxp2fACGg3Sp+IMBILNyVoBU8WUT1K/QHH2+kGmVZgbhaQhtiTg21RYg3c34AtdbA2q8VDhmSUxWuTxhX011Vs5t3Qg14v+NUWGt8/HucaKAsU8wgysc1rJgkIJHyh3ibQiFgEWK4yc3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(39860400002)(366004)(346002)(6506007)(8676002)(38100700002)(8936002)(4326008)(55016002)(66476007)(9686003)(52116002)(3716004)(5660300002)(6916009)(1076003)(7696005)(2906002)(316002)(478600001)(86362001)(54906003)(66946007)(83380400001)(186003)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CQDrS8k/2Bg9zxazAyJ9IoAHbXDN9MufK+1wEMdQjRLBh9m6TDc/lYFpqTuP?=
 =?us-ascii?Q?EYMMn3bUM2jZZxj0bMPh1/MHfAEzFVnRTRcc+MU8eLMxcW1D/N9Tsdnn53WT?=
 =?us-ascii?Q?YlUJg3R2e9ckf0CZALMFABvidP8D81Lm3NE+y9aufjG10WUejcM7Z6w4Mh6j?=
 =?us-ascii?Q?R7H/ZFnfb5gmYKC+R6yOsS3gd4a1gPIVlPjVwdIZQlDqKWnHSPeDsr500bB5?=
 =?us-ascii?Q?XOP2w0cUCxLynoelkQx8fGgAMsdohqkXSj/29QENaXsaz49DyCzPliFOyNAj?=
 =?us-ascii?Q?y/hL5FVY3EjdWvCtQLPh0sazbYv22XchFqtS6ey1SalzQGA20e7fOde42/LB?=
 =?us-ascii?Q?AHebUDa2Lq6HJ8Ly1jUsZZlKVS05hSAZYdcHszBW7L4CUYf8CmHorn5jHhJI?=
 =?us-ascii?Q?U35YZDF9cffqfl2WmUIvZGIDR0rrZ0rHu5NyxVxE6tNLg/PeOGgJ8cQGCHBt?=
 =?us-ascii?Q?0J6/EaEPFinO+l1qGRhbKYIy9tRNyQmmuFn9lbIU9dXw4CxMOwF7Jb0o5p40?=
 =?us-ascii?Q?KmlnKucKElXaqkcumsnErrbBoVf3hD9n3OaKxzFeAV6HizUB+12v6iHfFPkL?=
 =?us-ascii?Q?rItEaebOzHcpHyUSaX5O3H4bywzet97G45UDkIzb8MzUtnVOB2PHMAsv0XqP?=
 =?us-ascii?Q?YW+erINiXV6Dv56b5/BIBwExG1nEIldj/q0xC2qvvQ4HUgC0M39FKPnowRFk?=
 =?us-ascii?Q?njv6HfM6N1VzFuu0hAIxMet73gFE7/KFKyoIuXIpUB82xe8QpnSQVb+wti/t?=
 =?us-ascii?Q?n/fXKnsXxeg/bXgl+UUaEzeCHF0NjJU0RQZvS9byX4NUR/63RDiAYk3g53Dm?=
 =?us-ascii?Q?Ko0mD6mFS1bhBZ9oi9iBJB2gwh2qpyafVLPfUorNU0TblzyjRGu8eswhYEKc?=
 =?us-ascii?Q?LolhqBP8/qMiqVzwDttldwOF6NXlQMA0G0661SM0S2b8zvHvs+Kc3m/Wyxkd?=
 =?us-ascii?Q?6mdJybp5xSJSk/MxatTKbXN2zBcS5BIR98khYexyyWXnqLFMCMn1SW6XYfP6?=
 =?us-ascii?Q?NZtp9vDw6z2BNF+AFdv7aEwQTv4EKivgtdEE1m9pJU7Ekd6HqQndUuCgu7EI?=
 =?us-ascii?Q?CPK+JF5omyK6MEOS4aP3Ldth5cqcsJ/dqCghxL6eheZ4sylxDIsbStrjL+HO?=
 =?us-ascii?Q?0HeHsE5SaDtoOdVO+4JmwkG/rI/hM3plMMJc1UdxxLM2gl5BjrAD6TQ0g9QL?=
 =?us-ascii?Q?8Wzk+j/iF56LiZtH2uUn4gJEwuCv/FYKtN+d2I7B8jUxKcTTeI4dcuzB+SSa?=
 =?us-ascii?Q?y2k+FmSNSUWa4QDG7paO52sdGvYbruRigSpMqmdwIcPkx52Qs8u+6Mf4QqNw?=
 =?us-ascii?Q?8ZBTVEdZQoyxgdVrgtdo5s3bEHGKG3V8gPQdfJ1WXAKIWQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 81484c9f-ff32-49ba-03b1-08d96c24a819
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2021 02:11:34.6023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iYEzdZk22vKzv8QRgNgKZcHBYigdX1Fro5qBoandCmGT4N8ZAfAS7Yqfx5j3j5s3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4369
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: EEsmID0v2b9yKsicwyYqFwoBdNAuXHTT
X-Proofpoint-ORIG-GUID: EEsmID0v2b9yKsicwyYqFwoBdNAuXHTT
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-30_06:2021-08-30,2021-08-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0 mlxlogscore=999
 spamscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108310012
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Aug 29, 2021 at 11:52:03PM +0200, KP Singh wrote:
[ ... ]

> > > diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
> > > index b305270b7a4b..7760bc4e9565 100644
> > > --- a/kernel/bpf/bpf_local_storage.c
> > > +++ b/kernel/bpf/bpf_local_storage.c
> > > @@ -11,6 +11,8 @@
> > >  #include <net/sock.h>
> > >  #include <uapi/linux/sock_diag.h>
> > >  #include <uapi/linux/btf.h>
> > > +#include <linux/rcupdate_trace.h>
> > > +#include <linux/rcupdate_wait.h>
> > >
> > >  #define BPF_LOCAL_STORAGE_CREATE_FLAG_MASK (BPF_F_NO_PREALLOC | BPF_F_CLONE)
> > >
> > > @@ -81,6 +83,22 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
> > >       return NULL;
> > >  }
> > >
> > > +void bpf_local_storage_free_rcu(struct rcu_head *rcu)
> > > +{
> > > +     struct bpf_local_storage *local_storage;
> > > +
> > > +     local_storage = container_of(rcu, struct bpf_local_storage, rcu);
> > > +     kfree_rcu(local_storage, rcu);
> > > +}
> > > +
> > > +static void bpf_selem_free_rcu(struct rcu_head *rcu)
> > > +{
> > > +     struct bpf_local_storage_elem *selem;
> > > +
> > > +     selem = container_of(rcu, struct bpf_local_storage_elem, rcu);
> > > +     kfree_rcu(selem, rcu);
> > > +}
> > > +
> > >  /* local_storage->lock must be held and selem->local_storage == local_storage.
> > >   * The caller must ensure selem->smap is still valid to be
> > >   * dereferenced for its smap->elem_size and smap->cache_idx.
> > > @@ -118,12 +136,12 @@ bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_storage,
> > >                *
> > >                * Although the unlock will be done under
> > >                * rcu_read_lock(),  it is more intutivie to
> > > -              * read if kfree_rcu(local_storage, rcu) is done
> > > +              * read if the freeing of the storage is done
> > >                * after the raw_spin_unlock_bh(&local_storage->lock).
> > >                *
> > >                * Hence, a "bool free_local_storage" is returned
> > > -              * to the caller which then calls the kfree_rcu()
> > > -              * after unlock.
> > > +              * to the caller which then calls then frees the storage after
> > > +              * all the RCU grace periods have expired.
> > >                */
> > >       }
> > >       hlist_del_init_rcu(&selem->snode);
> > > @@ -131,7 +149,7 @@ bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_storage,
> > >           SDATA(selem))
> > >               RCU_INIT_POINTER(local_storage->cache[smap->cache_idx], NULL);
> > >
> > > -     kfree_rcu(selem, rcu);
> > > +     call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_rcu);
> > Although the common use case is usually storage_get() much more often
> > than storage_delete(), do you aware any performance impact for
> > the bpf prog that does a lot of storage_delete()?
> 
> I have not really measured the impact on deletes, My understanding is
> that it should
> not impact the BPF program, but yes, if there are some critical
> sections that are prolonged
> due to a sleepable program "sleeping" too long, then it would pile up
> the callbacks.
> 
> But this is not something new, as we have a similar thing in BPF
> trampolines. If this really
> becomes an issue, we could add a flag BPF_F_SLEEPABLE_STORAGE and only maps
> with this flag would be allowed in sleepable progs.
Agree that is similar to trampoline updates but not sure it is comparable
in terms of the frequency of elems being deleted here.  e.g. many
short lived tcp connections created by external traffic.

Adding a BPF_F_SLEEPABLE_STORAGE later won't work.  It will break
existing sleepable bpf prog.

I don't know enough on call_rcu_tasks_trace() here, so the
earlier question on perf/callback-pile-up implications in order to
decide if extra logic or knob is needed here or not.

> 
> We could then wait for both critical sections only when this flag is
> set on the map.
> 
> >
> > >
> > >       return free_local_storage;
> > >  }
> > > @@ -154,7 +172,8 @@ static void __bpf_selem_unlink_storage(struct bpf_local_storage_elem *selem)
> > >       raw_spin_unlock_irqrestore(&local_storage->lock, flags);
> > >
> > >       if (free_local_storage)
> > > -             kfree_rcu(local_storage, rcu);
> > > +             call_rcu_tasks_trace(&local_storage->rcu,
> > > +                                  bpf_local_storage_free_rcu);
> > >  }
> > >
> > >  void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
> > > @@ -213,7 +232,8 @@ bpf_local_storage_lookup(struct bpf_local_storage *local_storage,
> > >       struct bpf_local_storage_elem *selem;
> > >
> > >       /* Fast path (cache hit) */
> > > -     sdata = rcu_dereference(local_storage->cache[smap->cache_idx]);
> > > +     sdata = rcu_dereference_protected(local_storage->cache[smap->cache_idx],
> > > +                                       bpf_local_storage_rcu_lock_held());
> > There are other places using rcu_dereference() also.
> > e.g. in bpf_local_storage_update().
> > Should they be changed also?
> 
> From what I saw, the other usage of rcu_derference is in a nested
> (w.r.t to the RCU section that in bpf_prog_enter/exit) RCU
> read side critical section/rcu_read_{lock, unlock} so it should not be required.
hmm... not sure what nested or not has to do here.
It is likely we are talking different things.

Did you turn on the lockdep rcu debugging in kconfig?

afaik, lockdep uses the second "check" argument to WARN on incorrect usage.
Even the right check is passed here, the later rcu_dereference() will still
complain because it only checks for rcu_read_lock_held().

Also, after another look, why rcu_dereference_protected() is used
here instead of rcu_dereference_check()?  The spinlock is not acquired
here.  The same comment goes for similar rcu_dereference_protected() usages.

> 
> If there are some that are not, then they need to be updated. Did I miss any?
> 
> >
> > [ ... ]
> >
> > > --- a/net/core/bpf_sk_storage.c
> > > +++ b/net/core/bpf_sk_storage.c
> > > @@ -13,6 +13,7 @@
> > >  #include <net/sock.h>
> > >  #include <uapi/linux/sock_diag.h>
> > >  #include <uapi/linux/btf.h>
> > > +#include <linux/rcupdate_trace.h>
> > >
> > >  DEFINE_BPF_STORAGE_CACHE(sk_cache);
> > >
> > > @@ -22,7 +23,8 @@ bpf_sk_storage_lookup(struct sock *sk, struct bpf_map *map, bool cacheit_lockit)
> > >       struct bpf_local_storage *sk_storage;
> > >       struct bpf_local_storage_map *smap;
> > >
> > > -     sk_storage = rcu_dereference(sk->sk_bpf_storage);
> > > +     sk_storage = rcu_dereference_protected(sk->sk_bpf_storage,
> > > +                                            bpf_local_storage_rcu_lock_held());
> > >       if (!sk_storage)
> > >               return NULL;
> > >
> > > @@ -258,6 +260,7 @@ BPF_CALL_4(bpf_sk_storage_get, struct bpf_map *, map, struct sock *, sk,
> > >  {
> > >       struct bpf_local_storage_data *sdata;
> > >
> > > +     WARN_ON_ONCE(!bpf_local_storage_rcu_lock_held());
> > >       if (!sk || !sk_fullsock(sk) || flags > BPF_SK_STORAGE_GET_F_CREATE)
> > sk is protected by rcu_read_lock here.
> > Is it always safe to access it with the rcu_read_lock_trace alone ?
> 
> We don't dereference sk with an rcu_dereference though, is it still the case for
> tracing and LSM programs? Or is it somehow implicity protected even
> though we don't use rcu_dereference since that's just a READ_ONCE + some checks?
e.g. the bpf_prog (currently run under rcu_read_lock()) may read the sk from
req_sk->sk which I don't think the verifier will optimize it out, so as good
as READ_ONCE(), iiuc.

The sk here is obtained from the bpf_lsm_socket_* hooks?  Those sk should have
a refcnt, right?  If that is the case, it should be good enough for now.

> 
> Would grabbing a refcount earlier in the code be helpful?
Grab the refcount earlier in the bpf prog itself?
right, it may be what eventually needs to be done
if somehow there is a usecase that the sleepable bpf prog can get a
hold on a rcu protected sk.
