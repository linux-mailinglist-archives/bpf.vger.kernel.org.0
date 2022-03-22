Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD1B4E4982
	for <lists+bpf@lfdr.de>; Wed, 23 Mar 2022 00:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiCVXJZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Mar 2022 19:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiCVXJZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Mar 2022 19:09:25 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7E45EDE5
        for <bpf@vger.kernel.org>; Tue, 22 Mar 2022 16:07:56 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22MIHsvi000871;
        Tue, 22 Mar 2022 16:07:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=60xJkSDDuDhoHmnQfOLsXKzD/m6A4tmIxK3vQVWHsEE=;
 b=h7FHp24e10ynHVJA6ZEGJGIpwmy7xjaURFLkTmQpSjLTwD6fX7P7p8oTnITgDOcSx9l3
 tHBvk1Tu9/2QQhWMP6w8ERRsOoAZuXwDoTI70EfAK2wjJ6Fk0MwV4p/tL6kSyDHLI3Az
 wJyLk+0/IstULRuKmPD82rbYF6aZ6ppKS7M= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ey6ddfmwg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Mar 2022 16:07:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LM910Ijnq04umySVVaPxo+/lMoAth8tERk0F/kyQJY/fPQ2u3d+w5385ErBGa10Y9+1BBZsdZYoLpsFuXRUSoADyRqDU7BmQaYQWLjaqK6IZ92uZozmyXO7Czqv/9+AZw1sqHpqt9MpB0jn/kAsK7dc8pMbugdSjtKdslKQtKOM5/bojTCQZy3hdWSDTjw9Khi8u2bXc8YLjJDe+yCc1PlAW1vsm7x/IRwHEuFlcjnkGjhM1Ol3FsDthx0BWndR7fNmnJz6MWF5wtV21e3LSdDn/7JH7S/wIO/ZvW/nBkuKDTYQNL5BKLHoWgG5mut57+dl6Isqk8VvYJx0LGV1DGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=60xJkSDDuDhoHmnQfOLsXKzD/m6A4tmIxK3vQVWHsEE=;
 b=A1L0BhWbjrQ78ZY30NADxYDV4kBH3ReRwNtWHDAKWtufdThf4RPhAn9dbFkhv5czp2WVM9Y0UwyknfkBYCRFq20d58rurfsiJuWg02izGCh0EvzzxT7WSSMp/4JVAqDtrQhnZjAj2TLSjQkCk12p48aFHB00PbepRYB2/WFLkgcex/gr4QqAIZvbAFSQ6crruSIfb5iS4Yetima9jWocHb9r5XKcbK3w5qQnIcR2bT0DzoOX5Mk4EV8r1XBsSKcWklencUk3HtwOBGW3aLfeusmgoc1JxpuF1q3pdfFFA66a0hvSRoRj39H61tfscRw8PEnRP9IfIm1mH/+IKGpXpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by MWHPR15MB1871.namprd15.prod.outlook.com (2603:10b6:301:4f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Tue, 22 Mar
 2022 23:07:39 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::708c:84b0:641f:e7ca]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::708c:84b0:641f:e7ca%3]) with mapi id 15.20.5102.016; Tue, 22 Mar 2022
 23:07:39 +0000
Date:   Tue, 22 Mar 2022 16:07:34 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     Joanne Koong <joannekoong@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH bpf-next v1] bpf: bpf_local_storage_update fixes
Message-ID: <20220322230734.oph7ijzmymwmknjk@kafai-mbp.dhcp.thefacebook.com>
References: <20220322211513.3994356-1-joannekoong@fb.com>
 <20220322215656.xkfzvuc3blrl7mlq@kafai-mbp.dhcp.thefacebook.com>
 <CAJnrk1aRAXeDQKQq7zUPoJSb8oOFbb+jgtdF2_ttjcQL+Oo13A@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1aRAXeDQKQq7zUPoJSb8oOFbb+jgtdF2_ttjcQL+Oo13A@mail.gmail.com>
X-ClientProxiedBy: CO2PR05CA0091.namprd05.prod.outlook.com
 (2603:10b6:104:1::17) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be723ccf-dc62-458d-7450-08da0c58c238
X-MS-TrafficTypeDiagnostic: MWHPR15MB1871:EE_
X-Microsoft-Antispam-PRVS: <MWHPR15MB187136571A8499559F27DB79D5179@MWHPR15MB1871.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DefGGAjLvacVAwn+hL3qww+UTArEyjRAfpiuuDQq2oYNxn0xu6zmhPLgE6cT8ONNzZuW76Q6luemmrtEPbUSB4FXV3IAMFNN31N0RyV2mRtfltJ5tDc3gnSf6c92/dnl0+xizeMxvDLLW3WPn3vZ9zCBu00N6oYSstVefL85tQHw6lAK0R51/H/kgGXVXCRWAUcsM3DqAMxLkHzu3ApVm3Aj3YAApoy5ELRSIm68z+fZBm/hQ/QwS5CgKWJPsAjFzTiLjNwIVq/LoLoy/S7tuJ2lJB85XprAQlJb+Gim2H9twi2Kvia6hXLTgV3/X8VAavh1DL9qcqOrmMh/E9Q1Qbz0DGQ7Y0MZ+hdV6LwRxch2v/YHYf9nyRJuMb643+k8SC8qznjjcQFLmai+1waTg20rGcMDW+UesRTDsXKlZ6ZF93I8bQcstnx45GyOyv1nFJ2WOICcOSghSaMQUm9LJhrR6KfcA+q6ClycLObLtXPIAUC+ItmNBPemI6mmzBHY1q+HENZ5aq3JOnNzeocfoxSXsiXrR49xMLyNTw1lJqUx2s5g3BR+dfGY1ld/oeV+N18dNYofL3jcZBSyuh5AcMqJ1ZcY9lSf2nxfAm60RRe9gGBgSNsOouE8V4IBwvFAXxSnT5F7JHc48hYhsYWIDr5k5UD1DPH1uwohktnHRajt7Wr7KC9qjGl8hEmj0Npw4AxRY2Kn0XJNlEhS9TDuuKeMYeGVDIoXEeLJRkfwMxU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(54906003)(52116002)(53546011)(508600001)(316002)(6916009)(186003)(83380400001)(1076003)(5660300002)(8936002)(6506007)(6512007)(4326008)(6666004)(66946007)(66556008)(9686003)(8676002)(66476007)(966005)(6486002)(38100700002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4/1tnEi04BQe4YO9IMIzP0etBbJlsHqVmCosMATqkzSNn/tUWyY6wPkwZVhC?=
 =?us-ascii?Q?fIyPg9FuVTgs6KRE8dUhe39ZJX7fnGZN36+ueS1Yw+PD4wZn5qpEP4TVhx1G?=
 =?us-ascii?Q?B4HLn48QzyesuDoe9ZqtHFLclxaU0uR9q7nEe5ruHsTtngpirx1eENIly65g?=
 =?us-ascii?Q?j4TDSfRVoNlj06suqC7u4h9cmoAyg5TkUM9VwxszLl84Ijp70OCacoEuDEAt?=
 =?us-ascii?Q?hdz8XPAmUwtAEkiT2YM4hOIIj0rmwO/19xJtWK3RQVe/JCkHiUUEKCjEySZK?=
 =?us-ascii?Q?PRMYql9cvOyR6iT5pXgVRmniPYYPtqwm671ZnRirqAFLSePM+8zSKkjUKjtT?=
 =?us-ascii?Q?COn4K3WGmJyIprBjztAG1BjlC7PSqM9cDl000oW8csT/p8ircD6Az1PBA7YA?=
 =?us-ascii?Q?do/Dm1dR9gJkJzw0PBlZrmbdZJWiEHPf8cN6ftRLQB47hvO2vJ4IO5MtLgXb?=
 =?us-ascii?Q?QjXgRpFHfSZK8LL+63ERsDsWauMPIckyI4Tu6SVwVsVbskvV6EiNemwDitWq?=
 =?us-ascii?Q?MgM5hZtU2KQoHEXZdEIxMxs85w9B0S0XFyLe85gwZUYYh+OSLeESipn6lkUb?=
 =?us-ascii?Q?MXe/gfDCk89a12Xr5zV5xgRxcC9b9ifqdNY9/UZJgVU2lU+1/80T9io+TvEd?=
 =?us-ascii?Q?zo/T774CdyUDcF3FOv/GT5y5fu3bZwx9Y9rd5/JPcnC0rlMyQqJ89wg3WIGs?=
 =?us-ascii?Q?1pDvBNngL4EHal7Yot6ZUnmWRZWiqkFsNlJPpoDK/d/JdgSND7vWUMsUjoVo?=
 =?us-ascii?Q?0y8OzzWR70GkTYXb3gs+zddIxONrJ86jkhf3iSKP6nTeJm3Bws4pnXotqzsP?=
 =?us-ascii?Q?w5MZIjvKM5i+PAIrynzMHvYmdfTtq5YWebyWyLgq4r3v4i2DhISYu5a3b0qZ?=
 =?us-ascii?Q?g7mlNp/ii5yrEtIHMqvIQw5Uvi2n3tiObrmwzeKW5RBABfXLR6cbR9xkP96A?=
 =?us-ascii?Q?4G/C2FDrn2xswebE7ejhcGCqwu9RdsYAekztg+vgjbumQsm10FS//4J1SYlK?=
 =?us-ascii?Q?GOcK+alIAX49HjaOPRLJrc0EXY6HT2n/Uy8Cga0l0A68XLKLUMEhZ4tGHLn1?=
 =?us-ascii?Q?bHVpoKZAnYDBDs5CnPwrPz61W/ol5UjWVyUXdRwqfo8MF/mCc7e07HU4fXVU?=
 =?us-ascii?Q?CCz+e8dhJBlMsj5Us4gkVqLK8DdoXiYeavxSFMW0I8e/Zsuj7H0ynIjxyBTQ?=
 =?us-ascii?Q?hV2AxLJN9C/0ex1W8T7XPVeMYdoNgqKPS9AeICtXDf3UqHbyefxDQ5PpbdES?=
 =?us-ascii?Q?r4Y0TzJXffT1KUIXUjksWXKvGV8vEfTgpotKJ4SLwtLA3l97ZpPAlj/BMZBi?=
 =?us-ascii?Q?Dqm8tz/RC384ULOu7FTX7Fw5up2OBXFYPWMF8WvnCltbfaKBkYY77RKFIrwS?=
 =?us-ascii?Q?Mc2Z3+NtbhkYQMxQ2eFNA4jeBHiY25bC+n86qGkJ/X8f+5F389DoeVxf7qj1?=
 =?us-ascii?Q?smysJ3NlGViEp3CId+88zlKwUeUtWSefdPluZJasqaYb+wBwtARFFA=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be723ccf-dc62-458d-7450-08da0c58c238
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 23:07:39.2755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rHC2Fl5A2gmWYQF4eJSIGt+emz4Uadv7kKw0900RRckO1KSRjybCScENV4mWKrxK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1871
X-Proofpoint-GUID: mAweD3iviPg2lQMEB3B_w1HazzSVW6At
X-Proofpoint-ORIG-GUID: mAweD3iviPg2lQMEB3B_w1HazzSVW6At
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-22_08,2022-03-22_01,2022-02-23_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 22, 2022 at 03:38:29PM -0700, Joanne Koong wrote:
> On Tue, Mar 22, 2022 at 2:57 PM Martin KaFai Lau <kafai@fb.com> wrote:
> >
> > On Tue, Mar 22, 2022 at 02:15:13PM -0700, Joanne Koong wrote:
> > > From: Joanne Koong <joannelkoong@gmail.com>
> > >
> > > This fixes two things in bpf_local_storage_update:
> > >
> > > 1) A memory leak where if bpf_selem_alloc is called right before we
> > > acquire the spinlock and we hit the case where we can copy the new
> > > value into old_sdata directly, we need to free the selem allocation
> > > and uncharge the memory before we return. This was reported by the
> > > kernel test robot.
> > >
> > > 2) A charge leak where if bpf_selem_alloc is called right before we
> > > acquire the spinlock and we hit the case where old_sdata exists and we
> > > need to unlink the old selem, we need to make sure the old selem gets
> > > uncharged.
> > >
> > > Fixes: b00fa38a9c1c ("bpf: Enable non-atomic allocations in local storage")
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > ---
> > >  kernel/bpf/bpf_local_storage.c | 11 +++++++----
> > >  1 file changed, 7 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
> > > index 01aa2b51ec4d..2d33af0368ba 100644
> > > --- a/kernel/bpf/bpf_local_storage.c
> > > +++ b/kernel/bpf/bpf_local_storage.c
> > > @@ -435,8 +435,12 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
> > >       if (old_sdata && (map_flags & BPF_F_LOCK)) {
> > >               copy_map_value_locked(&smap->map, old_sdata->data, value,
> > >                                     false);
> > > -             selem = SELEM(old_sdata);
> > > -             goto unlock;
> > > +             raw_spin_unlock_irqrestore(&local_storage->lock, flags);
> > > +             if (selem) {
> > There is an earlier test ensures GFP_KERNEL can only
> > be used with BPF_NOEXIST.
> >
> 
> I agree, we currently will never run into this case (since the
> GFP_KERNEL case will error out if old_sdata exists), but my thinking
> was that maybe in the future it may not always hold that GFP_KERNEL
> will always be coupled with BPF_NOEXIST, so this change would
> defensively protect against that.
Then the earlier GFP_KERNEL and BPF_NOEXIST check is enough
to guard the future change without considering other implications first.

It is better to fail early for the cases that it does not support (like
the existing GFP_KERNEL and BPF_NOEXIST check).

or make it truely work for all other cases (if there is a use case).

> > The check_flags() before this should have error out.
> >
> > Can you share a pointer to the report from kernel test robot?
> >
> I'm unable to find a link to the report, so I will copy/paste the contents:
> 
> From: kernel test robot <lkp@intel.com>
> Date: Tue, Mar 22, 2022 at 11:36 AM
> Subject: [bpf-next:master] BUILD SUCCESS
> e52b8f5bd3d2f7b2f4b98067db33bc2fdc125643
> To: BPF build status <bpf@iogearbox.net>
> 
> 
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
> master
> branch HEAD: e52b8f5bd3d2f7b2f4b98067db33bc2fdc125643  selftests/bpf:
> Fix kprobe_multi test.
> 
> Unverified Warning (likely false positive, please contact us if interested):
It is indeed a false positive.  I am not very convinced this needs
to be silenced in the expense of adding unneeded logic in
this function and makes it harder to read.

> 
> kernel/bpf/bpf_local_storage.c:473:2: warning: Potential leak of
> memory pointed to by 'selem' [clang-analyzer-unix.Malloc]
> 
> Warning ids grouped by kconfigs:
> 
> clang_recent_errors
> `-- i386-randconfig-c001
>     `-- kernel-bpf-bpf_local_storage.c:warning:Potential-leak-of-memory-pointed-to-by-selem-clang-analyzer-unix.Malloc
> 
> elapsed time: 723m
> 
> > > +                     mem_uncharge(smap, owner, smap->elem_size);
> > > +                     kfree(selem);
> > > +             }
> > > +             return old_sdata;
> > >       }
> > >
> > >       if (gfp_flags != GFP_KERNEL) {
> > > @@ -466,10 +470,9 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
> > >       if (old_sdata) {
> > >               bpf_selem_unlink_map(SELEM(old_sdata));
> > >               bpf_selem_unlink_storage_nolock(local_storage, SELEM(old_sdata),
> > > -                                             false);
> > > +                                             gfp_flags == GFP_KERNEL);
> > >       }
> > >
> > > -unlock:
> > >       raw_spin_unlock_irqrestore(&local_storage->lock, flags);
> > >       return SDATA(selem);
> > >
> > > --
> > > 2.30.2
> > >
